Return-Path: <linux-fsdevel+bounces-57344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDC8B209EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 15:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7065E3ACF92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 13:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14E72DCF60;
	Mon, 11 Aug 2025 13:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCD79R8W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119717E0E8;
	Mon, 11 Aug 2025 13:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754918227; cv=none; b=Z3s/BxOXKqSNdonysfPlUmmZvfLo8P0HZmFfhHghtPqtsBMXDoUIQCqQQI9TkIwnsJOS4kYsYwhvbIymyxrLT2Q4sfMvq0FFa0fbT34YuCtIS2g4Q/Ne67CMvQh57xdPjZ7UvXU0SAj7I+8bs/qn3cWrKH+5Z7hi8UGGB91Zbws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754918227; c=relaxed/simple;
	bh=9H/x5XG1IcYYuNxoZ/FRiA+0c4IRqwYORLUEqhmTUO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A23dEFd39trF7bzhN1SIIXJnxG0we6QrsZiJ1QiCHgfMefdt9jIzZpIbJrGMd7mkt7BhK8IdjcYPOGZyccMRFEabHk1UDofXF6CsZ2qbW+Bt6ijXc4/c1zXi1JsDQhr9hyRgv9u53jsHkvoAVtFveU4Sq+kfLbBI+XN7kGszQuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCD79R8W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C58FC4CEF4;
	Mon, 11 Aug 2025 13:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754918226;
	bh=9H/x5XG1IcYYuNxoZ/FRiA+0c4IRqwYORLUEqhmTUO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rCD79R8WxTBcVrqg9rMg+tofGwTK8plCUX7hNKwEW3euMu+ELqZMDzG3+NaHbwoym
	 Z69gkLPwTFj/nx6Bg1B+irqlcABZjhpqoq3jVFiKTJDeZyxYw5CnVFo3Q+bloZ86fg
	 2m7vRUyEdvxYTnp4GkbhiIKHV/bfrHqC23dXRI85VIsNFxmxcLBjVAxLQmgF30a916
	 xH/7d0xrt5yCWPjsIm3OC3Vy5w0lb1AV3fMcYGzfzRi4FUKJKTzdL5BmdhSAyC1qsd
	 WvUrI1WnXciEAjbrhDJcFTMO79IkymShrf+HBHbQRv+JPtbb2CJrsIaGlHXIvqUdR+
	 G4L8HPawNFllQ==
Date: Mon, 11 Aug 2025 15:17:01 +0200
From: Christian Brauner <brauner@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-fscrypt@vger.kernel.org, fsverity@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org, linux-btrfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org
Subject: Re: [PATCH v5 00/13] Move fscrypt and fsverity info out of struct
 inode
Message-ID: <20250811-distribuieren-nilpferd-bef047fa7992@brauner>
References: <20250810075706.172910-1-ebiggers@kernel.org>
 <20250810-tortur-gerammt-8d9ffd00da19@brauner>
 <20250810090302.GA1274@sol>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250810090302.GA1274@sol>

On Sun, Aug 10, 2025 at 02:03:02AM -0700, Eric Biggers wrote:
> On Sun, Aug 10, 2025 at 10:47:32AM +0200, Christian Brauner wrote:
> > On Sun, Aug 10, 2025 at 12:56:53AM -0700, Eric Biggers wrote:
> > > This is a cleaned-up implementation of moving the i_crypt_info and
> > > i_verity_info pointers out of 'struct inode' and into the fs-specific
> > > part of the inode, as proposed previously by Christian at
> > > https://lore.kernel.org/r/20250723-work-inode-fscrypt-v4-0-c8e11488a0e6@kernel.org/
> > > 
> > > The high-level concept is still the same: fs/crypto/ and fs/verity/
> > > locate the pointer by adding an offset to the address of struct inode.
> > > The offset is retrieved from fscrypt_operations or fsverity_operations.
> > > 
> > > I've cleaned up a lot of the details, including:
> > > - Grouped changes into patches differently
> > > - Rewrote commit messages and comments to be clearer
> > > - Adjusted code formatting to be consistent with existing code
> > > - Removed unneeded #ifdefs
> > > - Improved choice and location of VFS_WARN_ON_ONCE() statements
> > > - Added missing kerneldoc for ubifs_inode::i_crypt_info
> > > - Moved field initialization to init_once functions when they exist
> > > - Improved ceph offset calculation and removed unneeded static_asserts
> > > - fsverity_get_info() now checks IS_VERITY() instead of v_ops
> > > - fscrypt_put_encryption_info() no longer checks IS_ENCRYPTED(), since I
> > >   no longer think it's actually correct there.
> > > - verity_data_blocks() now keeps doing a raw dereference
> > > - Dropped fscrypt_set_inode_info() 
> > > - Renamed some functions
> > > - Do offset calculation using int, so we don't rely on unsigned overflow
> > > - And more.
> > > 
> > > For v4 and earlier, see
> > > https://lore.kernel.org/r/20250723-work-inode-fscrypt-v4-0-c8e11488a0e6@kernel.org/
> > > 
> > > I'd like to take this series through the fscrypt tree for 6.18.
> > > (fsverity normally has a separate tree, but by choosing just one tree
> > > for this, we'll avoid conflicts in some places.)
> > 
> > Woh woh. First, I had a cleaned up version ready for v6.18 so if you
> > plan on taking over someone's series and resend then maybe ask the
> > author first whether that's ok or not. I haven't seen you do that. You
> > just caused duplicated work for no reason.
> 
> Ah, sorry about that.  When I started looking at it again yesterday
> there turned out to be way too many cleanups and fixes I wanted to make
> (beyond the comments I gave earlier), and I hadn't seen activity from
> you on it in a while.  So I figured it would be easier to just send a
> series myself.  But I should have asked you first, sorry.

So I started working on this pretty much right away. And I had planned
on sending it out rather soon but then thought to better wait for -rc1
to be released because I saw you had a bunch of crypto changes in for
-rc1 that would've caused merge conflicts. It's no big deal overall but
I just don't like that I wasted massaging all that stuff. So next time a
heads-up would be nice. Thank you!

> 
> > And second general infrastructure changes that touch multiple fses and
> > generic fs infrastructure I very much want to go through VFS trees.
> > We'll simply use a shared tree.
> 
> So you'd like to discontinue the fscrypt and fsverity trees?  That's
> what they are for: general infrastructure shared by multiple
> filesystems.  Or is this comment just for this series in particular,
> presumably because it touches 'struct inode'?

My comment just applies this series. I'm not here to take away your
trees ofc unless you would like to have them go through the VFS batch.
That's something that some people like Amir have started doing.

I'll put the series into vfs-6.17.inode and push it out then you can
base any additional changes on top of that. I'll not touch it unless you
tell me to. Linus knows that VFS trees often have work that is used as
the base for other trees so he will merge VFS trees before any of the
smaller trees and I always mention this to him.

