Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1524114627
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 18:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbfLERop (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 12:44:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:37482 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729396AbfLERop (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 12:44:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 82358AEAC;
        Thu,  5 Dec 2019 17:44:43 +0000 (UTC)
Date:   Thu, 5 Dec 2019 11:44:41 -0600
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com,
        fdmanana@kernel.org, nborisov@suse.com, dsterba@suse.cz
Subject: Re: [PATCH 4/8] btrfs: Switch to iomap_dio_rw() for dio
Message-ID: <20191205174441.ech4nh4jxpfijule@fiona>
References: <20191205155630.28817-1-rgoldwyn@suse.de>
 <20191205155630.28817-5-rgoldwyn@suse.de>
 <20191205171815.GA19670@Johanness-MacBook-Pro.local>
 <20191205171959.GA8586@infradead.org>
 <20191205173242.GB19670@Johanness-MacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205173242.GB19670@Johanness-MacBook-Pro.local>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 18:32 05/12, Johannes Thumshirn wrote:
> On Thu, Dec 05, 2019 at 09:19:59AM -0800, Christoph Hellwig wrote:
> > I actually much prefer exporting generic_file_buffered_read and will
> > gladly switch other callers not needing the messy direct I/O handling
> > in generic_file_read_iter over to generic_file_buffered_read once this
> > series is merged.
> 
> I think you misunderstood me here, I meant the code to be:
> 
> static ssize_t btrfs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
> {
> 	ssize_t ret = 0;
> 
> 	if (iocb->ki_flags & IOCB_DIRECT) {
> 		struct inode *inode = file_inode(iocb->ki_filp);
> 
> 		inode_lock_shared(inode);
> 		ret = btrfs_direct_IO(iocb, to);
> 		inode_unlock_shared(inode);
> 		if (ret < 0)
> 			return ret;
> 		}
> 	}
> 
> 	return generic_file_read_iter(icob, to);
> }
> 
> This way an iocb that is no dio will end in generic_file_read_iter():
> 
> generic_file_read_iter(iocb, to)
> {
> 	size_t count = iov_iter_count(iter);
>         ssize_t retval = 0;
> 
>         if (!count)
>                 goto out; /* skip atime */
> 
> 	if (iocb->ki_flags & IOCB_DIRECT) {
> 		skipped as flag is not set
> 	}
> 
> 	retval = generic_file_buffered_read(iocb, iter, retval);
> out:
> 	return retval;
> }
> 
> Meaning we do not need to export generic_file_buffered_read() and still can
> skip the generic DIO madness.
> 
> Makes sense?

For btrfs, DIO and buffered I/O is not mutually exclusive, since we fall
back to buffered I/O in case of incomplete Direct I/O. In this case,
the control will not skip IOCB_DIRECT branch.

-- 
Goldwyn
