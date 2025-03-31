Return-Path: <linux-fsdevel+bounces-45369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B78A76A97
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 17:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C83DB16D095
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 15:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B631D214A69;
	Mon, 31 Mar 2025 15:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzjHdoRM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE001DE4E3;
	Mon, 31 Mar 2025 15:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743433432; cv=none; b=fIXys5/9fRNm1beMx6Ym8TMQ2rq9nj5ESwSHVJT66GvamlOkfOD5w1triqBbp8zI89YpvXXWRebp2302OVMHovCxQLsm7k84u+A4Yij1HSgzQTV6GkVmXB8q/EWBtGFfNSK8VtSFFTrdBtFxSn9V4IKhnjEMOPT2lQtTRwUbGl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743433432; c=relaxed/simple;
	bh=sUfL431bLkrHacFB60/GFrSaPyTjHacwX9q/Ur7pV0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMIJ9ilh78ZzrsVHiALWLOxsuw9KNeAnyzssI4H6GII+ZOvut5qxhQ/zvt36JaE220BMcw5sSxCzw1N5PoSYgQnRyMV2745G75tvucKNAk47mG3CWbkdccOgh+HlD6sWLWQszBDInTfndf4fzR8S1Z2HkkB+zL6L6I8WTjZSf6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzjHdoRM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F3FC4CEE3;
	Mon, 31 Mar 2025 15:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743433431;
	bh=sUfL431bLkrHacFB60/GFrSaPyTjHacwX9q/Ur7pV0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bzjHdoRMxp5FnIVDt1jf8oPgDdxYcNFvtLA4kRVOp4ZMj2m7sAxHqUuzeXPHUZ5Mf
	 cBwAx8+iXPdU7RVL1+J5nWnI7EPH5OGe4pj6MdPtPdMasBMUBVI4NEGw30VSdiYnBX
	 i0InwBNUsSykHMc9iECmFOApTdYnKlQj1Lo/1yzKdxsQimwjymd07T1+aEys2AfvIE
	 iuxvKz7KsfkU5r7L/9/Ae54N605KUE7djXRZuksb7yIFerKTDFY+h0+xXrlcuj0OGp
	 noF2Y6Wf6N7apo3xcf+raSYxot/rYnzo4qWyz5mfLvnMuVpkM5U43OkTBdk8iZhV9P
	 tpAdtdTuFlS9w==
Date: Mon, 31 Mar 2025 17:03:45 +0200
From: Christian Brauner <brauner@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mcgrof@kernel.org, hch@infradead.org, david@fromorbit.com, rafael@kernel.org, 
	djwong@kernel.org, pavel@kernel.org, peterz@infradead.org, mingo@redhat.com, 
	will@kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH 2/2] efivarfs: support freeze/thaw
Message-ID: <20250331-mitunter-samen-07781404fd12@brauner>
References: <20250331-work-freeze-v1-0-6dfbe8253b9f@kernel.org>
 <20250331-work-freeze-v1-2-6dfbe8253b9f@kernel.org>
 <792a6f2f5ad3285d71595860c20f354e2d2306b6.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <792a6f2f5ad3285d71595860c20f354e2d2306b6.camel@HansenPartnership.com>

On Mon, Mar 31, 2025 at 10:46:43AM -0400, James Bottomley wrote:
> On Mon, 2025-03-31 at 14:42 +0200, Christian Brauner wrote:
> > Allow efivarfs to partake to resync variable state during system
> > hibernation and suspend. Add freeze/thaw support.
> > 
> > This is a pretty straightforward implementation. We simply add
> > regular freeze/thaw support for both userspace and the kernel. This
> > works without any big issues and congrats afaict efivars is the first
> > pseudofilesystem that adds support for filesystem freezing and
> > thawing.
> > 
> > The simplicity comes from the fact that we simply always resync
> > variable state after efivarfs has been frozen. It doesn't matter
> > whether that's because of suspend, userspace initiated freeze or
> > hibernation. Efivars is simple enough that it doesn't matter that we
> > walk all dentries. There are no directories and there aren't insane
> > amounts of entries and both freeze/thaw are already heavy-handed
> > operations. We really really don't need to care.
> 
> Just as a point of order: this can't actually work until freeze/thaw is
> actually plumbed into suspend/resume.
> 
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/efivarfs/internal.h |   1 -
> >  fs/efivarfs/super.c    | 196 +++++++++++++--------------------------
> > ----------
> >  2 files changed, 51 insertions(+), 146 deletions(-)
> > 
> > diff --git a/fs/efivarfs/internal.h b/fs/efivarfs/internal.h
> > index ac6a1dd0a6a5..f913b6824289 100644
> > --- a/fs/efivarfs/internal.h
> > +++ b/fs/efivarfs/internal.h
> > @@ -17,7 +17,6 @@ struct efivarfs_fs_info {
> >  	struct efivarfs_mount_opts mount_opts;
> >  	struct super_block *sb;
> >  	struct notifier_block nb;
> > -	struct notifier_block pm_nb;
> >  };
> >  
> >  struct efi_variable {
> > diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> > index 0486e9b68bc6..567e849a03fe 100644
> > --- a/fs/efivarfs/super.c
> > +++ b/fs/efivarfs/super.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/printk.h>
> >  
> >  #include "internal.h"
> > +#include "../internal.h"
> >  
> >  static int efivarfs_ops_notifier(struct notifier_block *nb, unsigned
> > long event,
> >  				 void *data)
> > @@ -119,12 +120,18 @@ static int efivarfs_statfs(struct dentry
> > *dentry, struct kstatfs *buf)
> >  
> >  	return 0;
> >  }
> > +
> > +static int efivarfs_freeze_fs(struct super_block *sb);
> > +static int efivarfs_unfreeze_fs(struct super_block *sb);
> > +
> >  static const struct super_operations efivarfs_ops = {
> >  	.statfs = efivarfs_statfs,
> >  	.drop_inode = generic_delete_inode,
> >  	.alloc_inode = efivarfs_alloc_inode,
> >  	.free_inode = efivarfs_free_inode,
> >  	.show_options = efivarfs_show_options,
> > +	.freeze_fs = efivarfs_freeze_fs,
> 
> Why is it necessary to have a freeze_fs operation?  The current code in
> super.c:freeze_super() reads:

Fwiw, I've explained this already in prior mails. The same behavior as
for the ioctl where we check whether the filesystem provides either a
->freeze_fs or ->freeze_super method. If neither is provided the
filesystem is assumed to not have freeze support.

> 
> 	if (sb->s_op->freeze_fs) {
> 		ret = sb->s_op->freeze_fs(sb);
> 
> So it would seem that setting this to NULL has exactly the same effect
> as providing a null method.

No, it would cause freeze to not be called.

IOW, any filesystem that doesn't provides neither a freeze_super or
freeze_fs method doesn't support freeze (that's how the ioctls work as
well) which allows us to only call into filesystems that are able to
properly freeze so we don't need pointless FS_* flags. By only providing
thaw it would end up thawing something that was never frozen. Both are
provided and the freeze methods function as the indicator whether
freezing/thawing is supported.

That could be changed but not in this series. We could also provide
noop_freeze just like we have noop_sync but again, not for this series.

> 
> > +	.unfreeze_fs = efivarfs_unfreeze_fs,
> >  };
> >  
> >  /*
> > 
> [...]
> > @@ -608,9 +516,7 @@ static void efivarfs_kill_sb(struct super_block
> > *sb)
> >  {
> >  	struct efivarfs_fs_info *sfi = sb->s_fs_info;
> >  
> > -	blocking_notifier_chain_unregister(&efivar_ops_nh, &sfi-
> > >nb);
> 
> This is an extraneous deletion of an unrelated notifier which efivarfs
> still needs to listen for ops updates from the efi subsystem.

At first I was bewildered because I thought you were talking about pm_nb
for some reason and was ready to explode. Man, I need a post LSFMM
vacation. :)

Thanks for spotting this. This is now fixed by adding back:

blocking_notifier_chain_unregister(&efivar_ops_nh, &sfi->nb);

