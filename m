Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A6C667D86
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 19:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240058AbjALSJ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 13:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240215AbjALSJc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 13:09:32 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD62E736E0;
        Thu, 12 Jan 2023 09:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MRcNURrCcMAMUGIQZf3CCD7Lvxpvqs5be68sOS6UP0I=; b=nTd60ieJVIzIkEvkTjgjJ7SfUT
        mvK7KmAuVFDifAN4HnMX/RLqSDCsnoBzH/YqsfpejieQECVzMKwkx2+zAdLjUfkvRfdeJrCrCu0EK
        EL5g/3prvqTr8dqp9RJb3nJ9oOw9Zw7Vfbjc1pwg+invynjid40cLu+Ki15XSoeY7Z+DRUj7z3GLf
        vx9n2ZlzrNrrvkN/DpDX4rxGoH+ureY8Jbf24lDEr6DGd+DrQxJTUHVZsth5M927rApOKtQYayHix
        QXOf23LPcM7m41OPHo4xDfk81C2rZEWMl5psV9Zydi2cJta/PSzb4nTFd2ZQ5kA58QqHs5krbPwvE
        xGdNbK7w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pG1W2-001WGB-1g;
        Thu, 12 Jan 2023 17:37:26 +0000
Date:   Thu, 12 Jan 2023 17:37:26 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/9] iov_iter: Use IOCB/IOMAP_WRITE if available
 rather than iterator direction
Message-ID: <Y8BFVgdGYNQqK3sB@ZenIV>
References: <Y7+8r1IYQS3sbbVz@infradead.org>
 <167344725490.2425628.13771289553670112965.stgit@warthog.procyon.org.uk>
 <167344727810.2425628.4715663653893036683.stgit@warthog.procyon.org.uk>
 <15330.1673519461@warthog.procyon.org.uk>
 <Y8AUTlRibL+pGDJN@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8AUTlRibL+pGDJN@infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 12, 2023 at 06:08:14AM -0800, Christoph Hellwig wrote:
> On Thu, Jan 12, 2023 at 10:31:01AM +0000, David Howells wrote:
> > > And use the information in the request for this one (see patch below),
> > > and then move this patch first in the series, add an explicit direction
> > > parameter in the gup_flags to the get/pin helper and drop iov_iter_rw
> > > and the whole confusing source/dest information in the iov_iter entirely,
> > > which is a really nice big tree wide cleanup that remove redundant
> > > information.
> > 
> > Fine by me, but Al might object as I think he wanted the internal checks.  Al?
> 
> I'm happy to have another discussion, but the fact the information in
> the iov_iter is 98% redundant and various callers got it wrong and
> away is a pretty good sign that we should drop this information.  It
> also nicely simplified the API.

I have no problem with getting rid of iov_iter_rw(), but I would really like to
keep ->data_source.  If nothing else, any place getting direction wrong is
a trouble waiting to happen - something that is currently dealing only with
iovec and bvec might be given e.g. a pipe.

Speaking of which, I would really like to get rid of the kludge /dev/sg is
pulling - right now from-device requests there do the following:
	* copy the entire destination in (and better hope that nothing is mapped
write-only, etc.)
	* form a request + bio, attach the pages with the destination copy to it
	* submit
	* copy the damn thing back to destination after the completion.
The reason for that is (quoted in commit ecb554a846f8)

====
    The semantics of SG_DXFER_TO_FROM_DEV were:
       - copy user space buffer to kernel (LLD) buffer
       - do SCSI command which is assumed to be of the DATA_IN
         (data from device) variety. This would overwrite
         some or all of the kernel buffer
       - copy kernel (LLD) buffer back to the user space.
    
    The idea was to detect short reads by filling the original
    user space buffer with some marker bytes ("0xec" it would
    seem in this report). The "resid" value is a better way
    of detecting short reads but that was only added this century
    and requires co-operation from the LLD.
====

IOW, we can't tell how much do we actually want to copy out, unless the SCSI driver
in question is recent enough.  Note that the above had been written in 2009, so
it might not be an issue these days.

Do we still have SCSI drivers that would not set the residual on bypass requests
completion?  Because I would obviously very much prefer to get rid of that
copy in-overwrite-copy out thing there - given the accurate information about
the transfer length it would be easy to do.
