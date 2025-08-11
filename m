Return-Path: <linux-fsdevel+bounces-57397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13640B21260
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 18:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A33C3A6469
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 16:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4697329BDB6;
	Mon, 11 Aug 2025 16:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGsk5/BB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F289296BB4;
	Mon, 11 Aug 2025 16:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754930409; cv=none; b=SPYoowoZjHkKsJCRY0ZE/Sf5d0iiYG/PVDYWSzMcgrREbAws1vyoBEiaGbtUyGmqq3A3VlMiFgfV/cZlyj6av3VfvsCpAajIwbxkko5vJXFSla45W1YDag6x5PFmoZ6LAUGGJBuJLvh7m728G1xiX0ASE2F8wWlp1qEY7ZP5HME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754930409; c=relaxed/simple;
	bh=yfY9fEwE5prSXu7c0Ar8fQ1UlOn+Yver65cw9lpRakc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAi5LpIgcDokwTnT3cSrmNkltlflOYVOYzd0G4GLBfjxIpn6gH+UDo6EyCshwo94qp5lyx7DIB+kNwNpmdimfRD/iSwHt+uobPX40cDcC9m2LPSBnI7xzz5o0o9XVWHuOD39PPJaLup90nm9lMlVOGrZ1zkaL99xKEj72dEhRus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pGsk5/BB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B361C4CEED;
	Mon, 11 Aug 2025 16:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754930409;
	bh=yfY9fEwE5prSXu7c0Ar8fQ1UlOn+Yver65cw9lpRakc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pGsk5/BBpOcOyGSEi4YMVtKP9l1LnkIw0E8k1OWWmvEzjR8tWPYLRCdVWgDivYzB0
	 QBjs/iXUHLQNSFF4scAcafi5A8kFz1Z8tWfjAEZfNb9NTb5L3WGctIErpbHiBvkSjS
	 jAGC82roagiAIKtNyS3bUDO/rDabILKuUtEMC3vtmh4MpO1+42hJvpurkyNYZzA8f6
	 uJ8+z6YbJb9LNnmANY2gQPZvA+X+dfQdOzHLdtSWb7wVG3CjCC6waAV6DvQSRz5Mm4
	 JlzXaWwIgprKlf+tsPTkwngce/DAsh+8U1uF1N3mPSSegfPMWUPEc15lr9rK5LUNSN
	 vJdnzKs0VS1gA==
Date: Mon, 11 Aug 2025 09:39:07 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fscrypt@vger.kernel.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-mtd@lists.infradead.org, linux-btrfs@vger.kernel.org,
	ceph-devel@vger.kernel.org
Subject: Re: [PATCH v5 00/13] Move fscrypt and fsverity info out of struct
 inode
Message-ID: <20250811163907.GA1268@sol>
References: <20250810075706.172910-1-ebiggers@kernel.org>
 <20250810-tortur-gerammt-8d9ffd00da19@brauner>
 <20250810090302.GA1274@sol>
 <20250811-distribuieren-nilpferd-bef047fa7992@brauner>
 <20250811-unbedacht-vollmond-1a805b76212b@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811-unbedacht-vollmond-1a805b76212b@brauner>

On Mon, Aug 11, 2025 at 03:34:35PM +0200, Christian Brauner wrote:
> On Mon, Aug 11, 2025 at 03:17:01PM +0200, Christian Brauner wrote:
> > On Sun, Aug 10, 2025 at 02:03:02AM -0700, Eric Biggers wrote:
> > > On Sun, Aug 10, 2025 at 10:47:32AM +0200, Christian Brauner wrote:
> > > > On Sun, Aug 10, 2025 at 12:56:53AM -0700, Eric Biggers wrote:
> > > > > This is a cleaned-up implementation of moving the i_crypt_info and
> > > > > i_verity_info pointers out of 'struct inode' and into the fs-specific
> > > > > part of the inode, as proposed previously by Christian at
> > > > > https://lore.kernel.org/r/20250723-work-inode-fscrypt-v4-0-c8e11488a0e6@kernel.org/
> > > > > 
> > > > > The high-level concept is still the same: fs/crypto/ and fs/verity/
> > > > > locate the pointer by adding an offset to the address of struct inode.
> > > > > The offset is retrieved from fscrypt_operations or fsverity_operations.
> > > > > 
> > > > > I've cleaned up a lot of the details, including:
> > > > > - Grouped changes into patches differently
> > > > > - Rewrote commit messages and comments to be clearer
> > > > > - Adjusted code formatting to be consistent with existing code
> > > > > - Removed unneeded #ifdefs
> > > > > - Improved choice and location of VFS_WARN_ON_ONCE() statements
> > > > > - Added missing kerneldoc for ubifs_inode::i_crypt_info
> > > > > - Moved field initialization to init_once functions when they exist
> > > > > - Improved ceph offset calculation and removed unneeded static_asserts
> > > > > - fsverity_get_info() now checks IS_VERITY() instead of v_ops
> > > > > - fscrypt_put_encryption_info() no longer checks IS_ENCRYPTED(), since I
> > > > >   no longer think it's actually correct there.
> > > > > - verity_data_blocks() now keeps doing a raw dereference
> > > > > - Dropped fscrypt_set_inode_info() 
> > > > > - Renamed some functions
> > > > > - Do offset calculation using int, so we don't rely on unsigned overflow
> > > > > - And more.
> > > > > 
> > > > > For v4 and earlier, see
> > > > > https://lore.kernel.org/r/20250723-work-inode-fscrypt-v4-0-c8e11488a0e6@kernel.org/
> > > > > 
> > > > > I'd like to take this series through the fscrypt tree for 6.18.
> > > > > (fsverity normally has a separate tree, but by choosing just one tree
> > > > > for this, we'll avoid conflicts in some places.)
> > > > 
> > > > Woh woh. First, I had a cleaned up version ready for v6.18 so if you
> > > > plan on taking over someone's series and resend then maybe ask the
> > > > author first whether that's ok or not. I haven't seen you do that. You
> > > > just caused duplicated work for no reason.
> > > 
> > > Ah, sorry about that.  When I started looking at it again yesterday
> > > there turned out to be way too many cleanups and fixes I wanted to make
> > > (beyond the comments I gave earlier), and I hadn't seen activity from
> > > you on it in a while.  So I figured it would be easier to just send a
> > > series myself.  But I should have asked you first, sorry.
> > 
> > So I started working on this pretty much right away. And I had planned
> > on sending it out rather soon but then thought to better wait for -rc1
> > to be released because I saw you had a bunch of crypto changes in for
> > -rc1 that would've caused merge conflicts. It's no big deal overall but
> > I just don't like that I wasted massaging all that stuff. So next time a
> > heads-up would be nice. Thank you!
> 
> I just pulled the series and now I see that you also changed the
> authorship of every single patch in the series from me to you and put my
> Co-developed-by in there.
> 
> I mean I acknowledge that there's changes between the branches and
> there's some function renaming but it's not to the point where
> authorship should be changed. And if you think that's necessary than it
> would be something you would want to talk to me about first.
> 
> I don't care about the stats but it was always hugely frustrating to me
> when I started kernel development when senior kernel developers waltzed
> in and thought they'd just take things over so I try very hard to not do
> that unless this is agreed upon first.

If you want to keep the authorship that's fine with me.  Make sure
you've checked the diff: the diff between v4 and v5 is larger than the
diff between the base and either version.  And as I mentioned, I rewrote
the commit messages and divided some of the changes into commits
differently as well.  If the situation was flipped, I wouldn't want to
be kept as the author.  But I realize there are different opinions about
this sort of thing, and I'm totally fine with whatever you prefer.

Thanks,

- Eric

