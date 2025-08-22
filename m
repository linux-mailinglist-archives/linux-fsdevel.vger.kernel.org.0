Return-Path: <linux-fsdevel+bounces-58769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 971FDB315E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 12:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62052624366
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 10:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A4B2FCBE8;
	Fri, 22 Aug 2025 10:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UI/ucQ/S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DBF2FB609;
	Fri, 22 Aug 2025 10:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755859894; cv=none; b=KGmmUn8ekJjhCqfn686IGzo3RrAVSf6n2jjmxqAqdhEn2pkqq7Wdy5UcFv6oFRGrcs7hZUTw7QR1+fd8Cr1y8e/UjJ2AB/CairjVC0EmsLqLBH1JJOA1BVmTXuObmaSULjaTOhtdzGokvUBiOrtikvCduyqD32puQOCEaYE/5TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755859894; c=relaxed/simple;
	bh=dWFYzin0qNJzbj6XdlWM900PHyAdF58ng4Zty808CMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhSw9YetjkoChqF9y5/1VfZagJDEESOCgHu7ko1AoQFa9UJ28hZ+eKZMGfFYbXw+TkiXTnqBc1GAPrbJ6jF7bonqGlRNjXaDNmEJGLq+znU26m3tUuvBOFcbHjaj3x21TlLkdYJ+hEoehFpV7Gf/LfCQ80T5OhmswdYxhZk+Ikc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UI/ucQ/S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D90EC113D0;
	Fri, 22 Aug 2025 10:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755859894;
	bh=dWFYzin0qNJzbj6XdlWM900PHyAdF58ng4Zty808CMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UI/ucQ/SW1MPc6lWMOf5rsdD9R2sK1ypNyGKvyWNDhUfkUBE2h9r0gvNAQ8mqiIkm
	 FcYyggjt8TnxtUVvqLBhBt0j5cRu2wdPP9+XzA1TvueOX5T5rJdpG7L0Ftp84Hy8id
	 H49WBL9O0NbMQkaLJjyGqzIQCtIj2gpJG6C37FRcSdZWtEXSgqwZ1aaO+qG2l31cfn
	 +5y/8ktvuRo3D4ZGka3AWFb30XXtor+51cxThqXKu2njkfMUUybWJ81FDIECLY8AjG
	 StupRP1g643uio7KqEunf+eH3bHRQpV161TT+2WOC3YCGBd1oTqsddFYzjSh2iMOoF
	 w8nMBXcm/6tvg==
Date: Fri, 22 Aug 2025 12:51:29 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	kernel-team@fb.com, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH 00/50] fs: rework inode reference counting
Message-ID: <20250822-monster-ganztags-cc8039dc09db@brauner>
References: <cover.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>

On Thu, Aug 21, 2025 at 04:18:11PM -0400, Josef Bacik wrote:
> Hello,
> 
> This series is the first part of a larger body of work geared towards solving a
> variety of scalability issues in the VFS.
> 
> We have historically had a variety of foot-guns related to inode freeing.  We
> have I_WILL_FREE and I_FREEING flags that indicated when the inode was in the
> different stages of being reclaimed.  This lead to confusion, and bugs in cases
> where one was checked but the other wasn't.  Additionally, it's frankly
> confusing to have both of these flags and to deal with them in practice.

Agreed.

> However, this exists because we have an odd behavior with inodes, we allow them
> to have a 0 reference count and still be usable. This again is a pretty unfun
> footgun, because generally speaking we want reference counts to be meaningful.

Agreed.

> The problem with the way we reference inodes is the final iput(). The majority
> of file systems do their final truncate of a unlinked inode in their
> ->evict_inode() callback, which happens when the inode is actually being
> evicted. This can be a long process for large inodes, and thus isn't safe to
> happen in a variety of contexts. Btrfs, for example, has an entire delayed iput
> infrastructure to make sure that we do not do the final iput() in a dangerous
> context. We cannot expand the use of this reference count to all the places the
> inode is used, because there are cases where we would need to iput() in an IRQ
> context  (end folio writeback) or other unsafe context, which is not allowed.
> 
> To that end, resolve this by introducing a new i_obj_count reference count. This
> will be used to control when we can actually free the inode. We then can use
> this reference count in all the places where we may reference the inode. This
> removes another huge footgun, having ways to access the inode itself without
> having an actual reference to it. The writeback code is one of the main places
> where we see this. Inodes end up on all sorts of lists here without a proper
> reference count. This allows us to protect the inode from being freed by giving
> this an other code mechanisms to protect their access to the inode.
> 
> With this we can separate the concept of the inode being usable, and the inode
> being freed.  The next part of the patch series is to stop allowing for inodes
> to have an i_count of 0 and still be viable.  This comes with some warts. The
> biggest wart is now if we choose to cache inodes in the LRU list we have to
> remove the inode from the LRU list if we access it once it's on the LRU list.
> This will result in more contention on the lru list lock, but in practice we
> rarely have inodes that do not have a dentry, and if we do that inode is not
> long for this world.
> 
> With not allowing inodes to hit a refcount of 0, we can take advantage of that
> common pattern of using refcount_inc_not_zero() in all of the lockless places
> where we do inode lookup in cache.  From there we can change all the users who
> check I_WILL_FREE or I_FREEING to simply check the i_count. If it is 0 then they
> aren't allowed to do their work, othrwise they can proceed as normal.
> 
> With all of that in place we can finally remove these two flags.
> 
> This is a large series, but it is mostly mechanical. I've kept the patches very
> small, to make it easy to review and logic about each change. I have run this
> through fstests for btrfs and ext4, xfs is currently going. I wanted to get this
> out for review to make sure this big design changes are reasonable to everybody.
> 
> The series is based on vfs/vfs.all branch, which is based on 6.9-rc1. Thanks,

I so hope you meant 6.17-rc1 because otherwise I did something very very
wrong. :)

