Return-Path: <linux-fsdevel+bounces-57349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C46B20A4D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 15:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50FF32A4F9F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 13:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3FB2DECC5;
	Mon, 11 Aug 2025 13:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLF36AqI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12252DCF64;
	Mon, 11 Aug 2025 13:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754919281; cv=none; b=qiyMRcrKRsk+PXn2R1jepqZsdgxZXFWgU0Ep6ROfxWDdRCvRAM+bVloRT77MZNAixDKKWOhmNl+KACeYxDqEpQzt0+lYEbp44aUL51E3GzKkoLd9vx2kr98u2LgBY6V8XAfVjXroBxstgXWQkj3oEWk1jHb2g7jCI4A2wKaIym8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754919281; c=relaxed/simple;
	bh=Ba4T8JRIhY1ucolU1ke77/oTfZPh0CpkbfaJTVmXDGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAay2s+1vnBbpK8oTH1lAqxj40TojrxT/uIG1Nq34Cp2dGxw2EWSYgn86L6sjIm0sni2aFdArI5YADRnpPUvMPVBCxqxEFZI539PtWYCJbTxJ2svKpyBcDRk4NQ3/1x2c9exnhm2NLyqulhy9YtwBuqA3OhQE9bw+o0LgfjI8Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLF36AqI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB39C4CEED;
	Mon, 11 Aug 2025 13:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754919280;
	bh=Ba4T8JRIhY1ucolU1ke77/oTfZPh0CpkbfaJTVmXDGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OLF36AqIkTxYij3rbRxLgiTKeAc20fE19pNkSF+6AsTmK4O7x7hqc6h9W1w8JaKxB
	 F6Yd6j+Zuz3C0Z725mv1ub40YX4pJKu9nCeUFh2JxNvosAsHrd4mTQ2qzKY1GIBjIw
	 utXSwPyDvH5GbbB4gOpKORIsVNVeawQrxrddtJU038mcQ5W0vgkBBoWX+bWpmCh+K1
	 wrIWKmD6rZBzQrW6phPG619xf0GlruQdThXJEfKIWfoZkrpK2I9COSa5cZMyFHZNg/
	 LG8LJcdQ3DDiYJIXqSDznqH/6+C6ULpc7F7fNadE2owbTdrJ+LR0jcwygpsMArWBYA
	 ZgrzYeoo58MPw==
Date: Mon, 11 Aug 2025 15:34:35 +0200
From: Christian Brauner <brauner@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-fscrypt@vger.kernel.org, fsverity@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org, linux-btrfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org
Subject: Re: [PATCH v5 00/13] Move fscrypt and fsverity info out of struct
 inode
Message-ID: <20250811-unbedacht-vollmond-1a805b76212b@brauner>
References: <20250810075706.172910-1-ebiggers@kernel.org>
 <20250810-tortur-gerammt-8d9ffd00da19@brauner>
 <20250810090302.GA1274@sol>
 <20250811-distribuieren-nilpferd-bef047fa7992@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250811-distribuieren-nilpferd-bef047fa7992@brauner>

On Mon, Aug 11, 2025 at 03:17:01PM +0200, Christian Brauner wrote:
> On Sun, Aug 10, 2025 at 02:03:02AM -0700, Eric Biggers wrote:
> > On Sun, Aug 10, 2025 at 10:47:32AM +0200, Christian Brauner wrote:
> > > On Sun, Aug 10, 2025 at 12:56:53AM -0700, Eric Biggers wrote:
> > > > This is a cleaned-up implementation of moving the i_crypt_info and
> > > > i_verity_info pointers out of 'struct inode' and into the fs-specific
> > > > part of the inode, as proposed previously by Christian at
> > > > https://lore.kernel.org/r/20250723-work-inode-fscrypt-v4-0-c8e11488a0e6@kernel.org/
> > > > 
> > > > The high-level concept is still the same: fs/crypto/ and fs/verity/
> > > > locate the pointer by adding an offset to the address of struct inode.
> > > > The offset is retrieved from fscrypt_operations or fsverity_operations.
> > > > 
> > > > I've cleaned up a lot of the details, including:
> > > > - Grouped changes into patches differently
> > > > - Rewrote commit messages and comments to be clearer
> > > > - Adjusted code formatting to be consistent with existing code
> > > > - Removed unneeded #ifdefs
> > > > - Improved choice and location of VFS_WARN_ON_ONCE() statements
> > > > - Added missing kerneldoc for ubifs_inode::i_crypt_info
> > > > - Moved field initialization to init_once functions when they exist
> > > > - Improved ceph offset calculation and removed unneeded static_asserts
> > > > - fsverity_get_info() now checks IS_VERITY() instead of v_ops
> > > > - fscrypt_put_encryption_info() no longer checks IS_ENCRYPTED(), since I
> > > >   no longer think it's actually correct there.
> > > > - verity_data_blocks() now keeps doing a raw dereference
> > > > - Dropped fscrypt_set_inode_info() 
> > > > - Renamed some functions
> > > > - Do offset calculation using int, so we don't rely on unsigned overflow
> > > > - And more.
> > > > 
> > > > For v4 and earlier, see
> > > > https://lore.kernel.org/r/20250723-work-inode-fscrypt-v4-0-c8e11488a0e6@kernel.org/
> > > > 
> > > > I'd like to take this series through the fscrypt tree for 6.18.
> > > > (fsverity normally has a separate tree, but by choosing just one tree
> > > > for this, we'll avoid conflicts in some places.)
> > > 
> > > Woh woh. First, I had a cleaned up version ready for v6.18 so if you
> > > plan on taking over someone's series and resend then maybe ask the
> > > author first whether that's ok or not. I haven't seen you do that. You
> > > just caused duplicated work for no reason.
> > 
> > Ah, sorry about that.  When I started looking at it again yesterday
> > there turned out to be way too many cleanups and fixes I wanted to make
> > (beyond the comments I gave earlier), and I hadn't seen activity from
> > you on it in a while.  So I figured it would be easier to just send a
> > series myself.  But I should have asked you first, sorry.
> 
> So I started working on this pretty much right away. And I had planned
> on sending it out rather soon but then thought to better wait for -rc1
> to be released because I saw you had a bunch of crypto changes in for
> -rc1 that would've caused merge conflicts. It's no big deal overall but
> I just don't like that I wasted massaging all that stuff. So next time a
> heads-up would be nice. Thank you!

I just pulled the series and now I see that you also changed the
authorship of every single patch in the series from me to you and put my
Co-developed-by in there.

I mean I acknowledge that there's changes between the branches and
there's some function renaming but it's not to the point where
authorship should be changed. And if you think that's necessary than it
would be something you would want to talk to me about first.

I don't care about the stats but it was always hugely frustrating to me
when I started kernel development when senior kernel developers waltzed
in and thought they'd just take things over so I try very hard to not do
that unless this is agreed upon first.

> > > And second general infrastructure changes that touch multiple fses and
> > > generic fs infrastructure I very much want to go through VFS trees.
> > > We'll simply use a shared tree.
> > 
> > So you'd like to discontinue the fscrypt and fsverity trees?  That's
> > what they are for: general infrastructure shared by multiple
> > filesystems.  Or is this comment just for this series in particular,
> > presumably because it touches 'struct inode'?
> 
> My comment just applies this series. I'm not here to take away your
> trees ofc unless you would like to have them go through the VFS batch.
> That's something that some people like Amir have started doing.
> 
> I'll put the series into vfs-6.17.inode and push it out then you can
> base any additional changes on top of that. I'll not touch it unless you
> tell me to. Linus knows that VFS trees often have work that is used as
> the base for other trees so he will merge VFS trees before any of the
> smaller trees and I always mention this to him.

