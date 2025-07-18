Return-Path: <linux-fsdevel+bounces-55444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3226B0A818
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 18:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C37EA42039
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 16:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E33225419;
	Fri, 18 Jul 2025 16:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXJ4rST3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFEF12E7E
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 16:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752854660; cv=none; b=DsyArGKeAQvAWNDs5VrH1DQvhlyGabTsNnX3hDTskEniqt+Zi6CxS1KCU8iJxDM7s31Ufm/iEva9BI9cA4HkECd2NbsCA8Nr0TeLrAnKeuw3TwawBwmic5dlxngyh6tGW2jnhYK7KWaAP6yCNtnzMLk/X8X03+lntcu/Dv846kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752854660; c=relaxed/simple;
	bh=grvoAyysdk7D3YMDdBb004pczA1wrL6pIJsFbHePbQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQrVIKM5ELoW5Z30sqULrKd/1AVm4WdXW50Bs+dP9D5FMmp17jHq+OhSsu4fB1EatQxvlVs/R4eb3ub9HQ1Ri4aZnP7rxcFttM4th/3dtesHA8AOzPr0mmqp/y+zdvDuxN4n5SKzzzLkiy7NhnNZZLDaGps7KChGoCjMO8x0BHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXJ4rST3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F2FC4CEEB;
	Fri, 18 Jul 2025 16:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752854656;
	bh=grvoAyysdk7D3YMDdBb004pczA1wrL6pIJsFbHePbQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fXJ4rST3B3IQPhHV8htsxVALtjuEWA34vzEWP7IX8a0hQ8WvmzwyQ9fpEpNX7X86Z
	 P6wOlLnNnOVg7YiJcO3k9PbwoiWQW77wuHDL7Kc66kW/PQ1T64uDDfK4m+85/Wp7n3
	 hfqPEfDUXo6L47zOy9O2bah9673ryRHIma1S2brkqsToaa0j99O1clGBybwOIH4loX
	 BXDtNdMe6LOa4hSUq/7lfvqq7IW814UavplB0FFTcnByRUtFDNpyn3glOyQZ7En3iM
	 s+dExWWCXz5td0sAB6sfCOfZeoxPjdRk9/DBr3tDZk/+FTNTc09iKIwq0w2zkMj2bw
	 b/0hc1jfRDp8A==
Date: Fri, 18 Jul 2025 09:04:14 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC DRAFT DOESNOTBUILD] inode: free up more space
Message-ID: <20250718160414.GC1574@quark>
References: <20250715-work-inode-fscrypt-v1-1-aa3ef6f44b6b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715-work-inode-fscrypt-v1-1-aa3ef6f44b6b@kernel.org>

On Tue, Jul 15, 2025 at 04:35:24PM +0200, Christian Brauner wrote:
> struct inode is bloated as everyone is aware and we should try and
> shrink it as that's potentially a lot of memory savings. I've already
> freed up around 8 bytes but we can probably do better.
> 
> There's a bunch of stuff that got shoved into struct inode that I don't
> think deserves a spot in there. There are two members I'm currently
> particularly interested in:
> 
> (1) #ifdef CONFIG_FS_ENCRYPTION
>             struct fscrypt_inode_info *i_crypt_info;
>     #endif
> 
>     ceph, ext4, f2fs, ubifs
> 
> (2) #ifdef CONFIG_FS_VERITY
>             struct fsverity_info *i_verity_info;
>     #endif
> 
>     btrfs, ext4, f2fs
> 
> So we have 4 users for fscrypt and 3 users for fsverity with both
> features having been around for a decent amount of time.
> 
> For all other filesystems the 16 bytes are just wasted bloating inodes
> for every pseudo filesystem and most other regular filesystems.
> 
> We should be able to move both of these out of struct inode by adding
> inode operations and making it the filesystem's responsibility to
> accommodate the information in their respective inodes.
> 
> Unless there are severe performance penalties for the extra pointer
> dereferences getting our hands on 16 bytes is a good reason to at least
> consider doing this.
> 
> I've drafted one way of doing this using ext4 as my victim^wexample. I'd
> like to hear some early feedback whether this is something we would want
> to pursue.
> 
> Build failures very much expected!
> 
> Not-Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/crypto/bio.c             |  2 +-
>  fs/crypto/crypto.c          |  8 ++++----
>  fs/crypto/fname.c           |  8 ++++----
>  fs/crypto/fscrypt_private.h |  3 +--
>  fs/crypto/hooks.c           |  2 +-
>  fs/crypto/inline_crypt.c    | 10 +++++-----
>  fs/crypto/keysetup.c        | 21 ++++----------------
>  fs/crypto/policy.c          |  8 ++++----
>  fs/ext4/ext4.h              |  9 +++++++++
>  fs/ext4/file.c              |  4 ++++
>  fs/ext4/namei.c             | 22 +++++++++++++++++++++
>  fs/ext4/super.c             |  6 +++++-
>  fs/ext4/symlink.c           | 12 ++++++++++++
>  include/linux/fs.h          |  9 +++++----
>  include/linux/fscrypt.h     | 47 ++++++++++++++++++++++++++++++---------------
>  15 files changed, 112 insertions(+), 59 deletions(-)

This should have been Cc'ed to linux-fscrypt@vger.kernel.org and
fsverity@lists.linux.dev.  I almost missed this.

If done properly, fixing this would be great.  I've tried to minimize
the overhead of CONFIG_FS_ENCRYPTION and CONFIG_FS_VERITY when those
features are not actually being used at runtime.  The struct inode
fields are the main case where we still don't do a good job at that.

However, as was mentioned elsewhere in the thread, unfortunately
indirect calls are really expensive and would not be a great solution.
I've been cleaning up indirect calls in other parts of the kernel, such
as the crypto and crc subsystems, and getting some significant
performance improvements from that.  It would be unfortunate to add a
large number of indirect calls for basically all operations done on
encrypted and/or verity files.

Doing the dereferences to get an offset stored in the inode_operations
(or fscrypt_operations or fsverity_operations, or maybe even super_block
which would just need one dereference rather than two?), and then doing
the pointer arithmetic, would be faster than an indirect call.  It won't
be all that great either, but it would do.

There are some cases where we could instead modify the functions in
fs/crypto/ to have the filesystem pass in a pointer to the
fscrypt_inode_info.  But that won't work in all cases.

Just throwing another idea out there: there could also be an
optimization for the case where only a single *filesystem type* is using
fscrypt (or fsverity) at runtime, which is the usual case.  This would
look something like:

    if (static_branch_likely(&fscrypt_single_fs_type))
            ci = *(struct fscrypt_inode_info **)((void *)inode + fscrypt_crypt_info_offset);
    else
            ci = // get it in slower way.  Maybe even just the indirect call.

In theory, the first case could even use a "runtime_const" for
fscrypt_crypt_info_offset.  In that case, the only difference between
the fast code path (where fscrypt_single_fs_type==true) and the current
inode->i_crypt_info would be the nop associated with the static branch.

But, that might be too fancy.  For now we probably should go with a
single code path that loads the offset from a per-filesystem-instance
struct, like inode_operations or super_block.

- Eric

