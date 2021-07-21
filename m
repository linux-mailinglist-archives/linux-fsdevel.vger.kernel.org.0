Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 253C13D1A65
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 01:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbhGUWrn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 18:47:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:55522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230109AbhGUWrm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 18:47:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 83B686120C;
        Wed, 21 Jul 2021 23:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626910098;
        bh=BV6+1Ao0IxYyJxbXmspucfsepYhMs1MorHdqcAJIsDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZZmd0E8BPE0eLUGn13SLy56Vc3klFu0/XpAmr1YLTJKW9F+B9h3kp9kejDYASJeSS
         /G+ifu2/251G86AgduBQlOl6sUgDDysk1fzY9WiH8ocfkjtI+auUToT1wWqzXnn6c2
         PbTgUQ1apNbCZoH2A+P+J39nGPPQVJflzBBGUoKEZeII1bZPwMBCO1YlrDxV0DsVCg
         y+8NvFhN8sl5ikBgb1fPElxQXNz7wHWiMbr3knXjRiMvN16E3t9avw6mvT4hXPdHzj
         PrtvPu5II/mkmj7aCCCWv6XmvrNPas+pViJD99EWQvGvWQc2e2msYdJa2TBFUGIqlg
         0F686ppGiVn8A==
Date:   Wed, 21 Jul 2021 16:28:18 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2] vfs: only allow SETFLAGS to set DAX flag on files and
 dirs
Message-ID: <20210721232818.GB8639@magnolia>
References: <20210719023834.104053-1-jefflexu@linux.alibaba.com>
 <20210719174331.GH22357@magnolia>
 <729b4efa-8903-c5ec-4e29-7f4e0d02ce2a@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <729b4efa-8903-c5ec-4e29-7f4e0d02ce2a@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 20, 2021 at 03:33:20PM +0800, JeffleXu wrote:
> 
> 
> On 7/20/21 1:43 AM, Darrick J. Wong wrote:
> > On Mon, Jul 19, 2021 at 10:38:34AM +0800, Jeffle Xu wrote:
> >> This is similar to commit dbc77f31e58b ("vfs: only allow FSSETXATTR to
> >> set DAX flag on files and dirs").
> >>
> >> Though the underlying filesystems may have filtered invalid flags, e.g.,
> >> ext4_mask_flags() called in ext4_fileattr_set(), also check it in VFS
> >> layer.
> >>
> >> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> >> ---
> >> changes since v1:
> >> - add separate parentheses surrounding flag tests
> >> ---
> >>  fs/ioctl.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/fs/ioctl.c b/fs/ioctl.c
> >> index 1e2204fa9963..90cfaa4db03a 100644
> >> --- a/fs/ioctl.c
> >> +++ b/fs/ioctl.c
> >> @@ -835,7 +835,7 @@ static int fileattr_set_prepare(struct inode *inode,
> >>  	 * It is only valid to set the DAX flag on regular files and
> >>  	 * directories on filesystems.
> >>  	 */
> >> -	if ((fa->fsx_xflags & FS_XFLAG_DAX) &&
> >> +	if (((fa->fsx_xflags & FS_XFLAG_DAX) || (fa->flags & FS_DAX_FL)) &&
> > 
> > Isn't fileattr_fill_flags supposed to fill out fa->fsx_xflags from
> > fa->flags for a SETFLAGS call?
> 
> Yes, but fa->fsx_xflags inherited from fa->flags (at least in ext4 it
> is) is the original flags/xflags of the file before SETFLAG/FSSETXATTR.

How?  old_ma is the original flags/xflags of the file.  fa reflects what
we copied in from userspace.  We use old_ma to set flags in fa that
couldn't possibly have been set by userspace, but neither DAX flag is in
that set.

Ugh, this is so much bookkeeping code to read it makes my head hurt.  Do
you have a reproducer?  I can't figure out how to trip this problem.

> Here we want to check *new* flags/xflags.

AFAICT, SETFLAGS will call ioctl_setflags, which will...
...read flags from userspace
...fill out struct fileattr via fileattr_fill_flags, which will set
   fa.fsx_flags from fa.flags, so the state of both fields' DAX flags
   will be whatever userspace gave us
...call vfs_fileattr_set, which will...
...call vfs_fileattr_get to fill out out_ma
...update the rest of xflags with the xflags from out_ma that weren't
   already set
...call fileattr_set_prepare, where it shouldn't matter if it checks
   (fa->xflags & FS_XFLAG_DAX) or (fa->flags & FS_DAX_FL), since they
   have the same value

FSSETXATTR will call ioctl_fssetxattr, which will...
...call copy_fsxattr_from_user to read fsxattr from userspace
...call fileattr_fill_xflags to set fa->flags from fa->xflags, so the
   state of both fields' DAX flags will be whatever userspace gave us
...call vfs_fileattr_set, which will...
...call vfs_fileattr_get to fill out out_ma
...update the rest of flags with the flags from out_ma that weren't
   already set
...call fileattr_set_prepare, where it shouldn't matter if it checks
   (fa->xflags & FS_XFLAG_DAX) or (fa->flags & FS_DAX_FL), since they
   have the same value

So where did I go wrong?

--D

> 
> > 
> >>  	    !(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode)))
> >>  		return -EINVAL;
> >>  
> >> -- 
> >> 2.27.0
> >>
> 
> -- 
> Thanks,
> Jeffle
