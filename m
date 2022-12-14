Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB9964C396
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Dec 2022 06:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiLNFoy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Dec 2022 00:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiLNFox (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Dec 2022 00:44:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48A521834;
        Tue, 13 Dec 2022 21:44:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B60AB8168A;
        Wed, 14 Dec 2022 05:44:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B87C433D2;
        Wed, 14 Dec 2022 05:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670996689;
        bh=6EinFbLzLdjIYYuAmUs7FHZ/MtkLiFAIcMtifcb+QNg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KS7Dp75PIurFFl5qbXWRE9UxYpHFjw/SITmF7ue9dh/U8sc060B/ORY+R0DCXpy4+
         APD11Mf8aAFnNjI2KQnpDNmUimOddHkzuH7YgM/OVcx3eNhk6E9E+U8j/H37PKuJFV
         EnZxSCRBD3RvsMeAPE6pSiadIE66QAGHqqObU98ZtD1TJR6/SaZ1h/94esjcE7peqU
         aGDTWVONA4+thVtlw6+d8o7RiS3uNu/8PDh9IXnaWsI7s3Jfnhgz/08ORtaCEydt4z
         0DtY5rX82/Z+L8NVszBjlcVAJijjHWffgnqxT6bFB+YObVMBxrKzAGro5owUL4O8Qo
         rVsvb4j4vtpig==
Date:   Tue, 13 Dec 2022 21:44:47 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Andrey Albershteyn <aalbersh@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 07/11] xfs: disable direct read path for fs-verity
 sealed files
Message-ID: <Y5lizzKIJUL7tNYb@sol.localdomain>
References: <20221213172935.680971-1-aalbersh@redhat.com>
 <20221213172935.680971-8-aalbersh@redhat.com>
 <20221214020715.GG3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214020715.GG3600936@dread.disaster.area>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 14, 2022 at 01:07:15PM +1100, Dave Chinner wrote:
> On Tue, Dec 13, 2022 at 06:29:31PM +0100, Andrey Albershteyn wrote:
> > The direct path is not supported on verity files. Attempts to use direct
> > I/O path on such files should fall back to buffered I/O path.
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > ---
> >  fs/xfs/xfs_file.c | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> > index 5eadd9a37c50e..fb4181e38a19d 100644
> > --- a/fs/xfs/xfs_file.c
> > +++ b/fs/xfs/xfs_file.c
> > @@ -245,7 +245,8 @@ xfs_file_dax_read(
> >  	struct kiocb		*iocb,
> >  	struct iov_iter		*to)
> >  {
> > -	struct xfs_inode	*ip = XFS_I(iocb->ki_filp->f_mapping->host);
> > +	struct inode		*inode = iocb->ki_filp->f_mapping->host;
> > +	struct xfs_inode	*ip = XFS_I(inode);
> >  	ssize_t			ret = 0;
> >  
> >  	trace_xfs_file_dax_read(iocb, to);
> > @@ -298,10 +299,17 @@ xfs_file_read_iter(
> >  
> >  	if (IS_DAX(inode))
> >  		ret = xfs_file_dax_read(iocb, to);
> 
> fsverity is supported on DAX?
> 
> Eric, I was under the impression that the DAX io path does not
> support fsverity, but I can't see anything that prevents ext4 from
> using fsverity on dax enabled filesystems. Does this work (is it
> tested regularly?), or is the lack of checking simply an oversight
> in that nobody thought to check DAX status when fsverity is enabled?

DAX and fsverity are mutually exclusive.  ext4_set_inode_flags() doesn't set the
DAX flag if the inode already has the verity flag, and
ext4_begin_enable_verity() doesn't allow setting the verity flag if the inode
already has the DAX flag.

> 
> > -	else if (iocb->ki_flags & IOCB_DIRECT)
> > +	else if (iocb->ki_flags & IOCB_DIRECT && !fsverity_active(inode))
> >  		ret = xfs_file_dio_read(iocb, to);
> > -	else
> > +	else {
> > +		/*
> > +		 * In case fs-verity is enabled, we also fallback to the
> > +		 * buffered read from the direct read path. Therefore,
> > +		 * IOCB_DIRECT is set and need to be cleared
> > +		 */
> > +		iocb->ki_flags &= ~IOCB_DIRECT;
> >  		ret = xfs_file_buffered_read(iocb, to);
> > +	}
> 
> Is this IOCB_DIRECT avoidance a limitation of the XFS
> implementation, or a generic limitation of the fsverity
> infrastructure?
> 
> If it's a limitation of the fsverity infrastructure, then we
> shouldn't be working around this in every single filesystem that
> supports fsverity.  If all the major filesystems are having to check
> fsverity_active() and clear IOCB_DIRECT on every single IOCB_DIRECT
> IO that is issued on a fsverity inode, then shouldn't we just elide
> IOCB_DIRECT from file->f_iocb_flags in the first place?

It's mainly a filesystem limitation, not a fs/verity/ limitation.  However, the
functions in fs/verity/verify.c do assume that the data pages are page cache
pages.  To allow filesystems to support direct I/O on verity files, functions
that take the inode and file offset explicitly would need to be added.

Not setting IOCB_DIRECT in ->f_iocb_flags is an interesting idea.  I've been
trying not to add fscrypt and fsverity stuff to the core VFS syscall paths,
since only certain filesystems support these features, so it makes sense to
limit to the overhead (however minimal) to those filesystems only.  However,
since ->f_iocb_flags was recently added to cache iocb_flags(), it does look like
the VFS could check IS_VERITY() in iocb_flags() with minimal overhead.

A potential issue is that if a file is opened with O_DIRECT and then
FS_IOC_ENABLE_VERITY is run (either on that fd or on a different fd), then the
O_DIRECT fd would still exist -- with IOCB_DIRECT in ->f_iocb_flags.

The read-time check would be needed to correctly handle that case.

- Eric
