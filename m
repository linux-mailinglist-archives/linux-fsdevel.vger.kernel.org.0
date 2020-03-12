Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97906183D45
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Mar 2020 00:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgCLXXo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Mar 2020 19:23:44 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:50464 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726710AbgCLXXo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Mar 2020 19:23:44 -0400
Received: from dread.disaster.area (pa49-195-202-68.pa.nsw.optusnet.com.au [49.195.202.68])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 3092B3A4706;
        Fri, 13 Mar 2020 10:23:38 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jCXAv-0005Bb-BR; Fri, 13 Mar 2020 10:23:37 +1100
Date:   Fri, 13 Mar 2020 10:23:37 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     David Howells <dhowells@redhat.com>
Cc:     mbobrowski@mbobrowski.org, jack@suse.cz,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Is ext4_dio_read_iter() broken?
Message-ID: <20200312232337.GZ10737@dread.disaster.area>
References: <969260.1584004779@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <969260.1584004779@warthog.procyon.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=mqTaRPt+QsUAtUurwE173Q==:117 a=mqTaRPt+QsUAtUurwE173Q==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=SS2py6AdgQ4A:10
        a=7-415B0cAAAA:8 a=yP_QldvOnB6FU5zP-N4A:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 12, 2020 at 09:19:39AM +0000, David Howells wrote:
> Hi Matthew,
> 
> Is ext4_dio_read_iter() broken?  It calls:
> 
> 	file_accessed(iocb->ki_filp);
> 
> at the end of the function - but surely iocb should be expected to have been
> freed when iocb->ki_complete() was called?
> 
> In my cachefiles rewrite, I'm seeing the attached kasan dump.  The offending
> RIP, ext4_file_read_iter+0x12b is at the above line, where it is trying to
> read iocb->ki_filp.
> 
> Here's an excerpt of the relevant bits from my code:
> 
> 	static void cachefiles_read_complete(struct kiocb *iocb, long ret, long ret2)
> 	{
> 		struct cachefiles_kiocb *ki =
> 			container_of(iocb, struct cachefiles_kiocb, iocb);
> 		struct fscache_io_request *req = ki->req;
> 	...
> 		fput(ki->iocb.ki_filp);
> 		kfree(ki);
> 		fscache_end_io_operation(req->cookie);
> 	...
> 	}
> 
> 	int cachefiles_read(struct fscache_object *obj,
> 			    struct fscache_io_request *req,
> 			    struct iov_iter *iter)
> 	{
> 		struct cachefiles_object *object =
> 			container_of(obj, struct cachefiles_object, fscache);
> 		struct cachefiles_kiocb *ki;
> 		struct file *file = object->backing_file;
> 		ssize_t ret = -ENOBUFS;
> 	...
> 		ki = kzalloc(sizeof(struct cachefiles_kiocb), GFP_KERNEL);
> 		if (!ki)
> 			goto presubmission_error;
> 
> 		ki->iocb.ki_filp	= get_file(file);
> 		ki->iocb.ki_pos		= req->pos;
> 		ki->iocb.ki_flags	= IOCB_DIRECT;
> 		ki->iocb.ki_hint	= ki_hint_validate(file_write_hint(file));
> 		ki->iocb.ki_ioprio	= get_current_ioprio();
> 		ki->req			= req;
> 
> 		if (req->io_done)
> 			ki->iocb.ki_complete = cachefiles_read_complete;
> 
> 		ret = rw_verify_area(READ, file, &ki->iocb.ki_pos, iov_iter_count(iter));
> 		if (ret < 0)
> 			goto presubmission_error_free;
> 
> 		fscache_get_io_request(req);
> 		trace_cachefiles_read(object, file_inode(file), req);
> 		ret = call_read_iter(file, &ki->iocb, iter);
> 		...
> 	}
> 
> The allocation point, cachefiles_read+0xd0, is the kzalloc() you can see and
> the free point, cachefiles_read_complete+0x86, is the kfree() in the callback
> function.

It looks to me like you are creating your own iocb that you are
doing AIO+DIO on, and you aren't taking a reference count to the
iocb yourself to ensure that it exists for the entire submission
path. i.e. see how the AIO code uses ki_refcnt and iocb_put() to
ensure the iocb does not get destroyed by IO completion before the
submission path has completed.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
