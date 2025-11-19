Return-Path: <linux-fsdevel+bounces-69129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3EBC7091D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 19:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id E1E082F2AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 18:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB162FFFA8;
	Wed, 19 Nov 2025 18:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAQFXiD0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549B0265CC2;
	Wed, 19 Nov 2025 18:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763575490; cv=none; b=aOuLOv7Gb0OQuQcNK2hxqWXxO6/qtW55Td3xF4CgdluCV3r+QFOTiFCyEuihKREOYw9y7KeAUAkoEK4yPOvq9aVL9F0zsPcJxn9Ruku220blbRYBLS+0CZVx9tMorw67cshPGoFSecjoV/3ogZdqMrzLGf0Oj/nxv6thVpKkp0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763575490; c=relaxed/simple;
	bh=1YXtVbAvN/jPWxo7e+RkPYTJZrgTlOf0lbDEv90MBaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkZfVEp+y12VflmPBZYJ/eRDOd5/A+uT1TV0PDF4He/DLZI2oa/q9N925/xMdkCLbAReasUoXk84bp3aCRDzem6UgsEOLl79Y4QJXCGMRcZojGoXIWdaPgl4LtvBGTTFrI8mF6PACh13uY6eiabb7F6h7hNNhY1d+fmdysR53Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAQFXiD0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A8BC4CEF5;
	Wed, 19 Nov 2025 18:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763575489;
	bh=1YXtVbAvN/jPWxo7e+RkPYTJZrgTlOf0lbDEv90MBaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KAQFXiD0QvsSRRp1WkB8gQDo4wmVk704OghRXzeAqKYkQB06Mpv1YyIOp1IH5MfyF
	 H1J0W9FtuRB2tb0Zvsk/mRndyxbzfzZx3HEZaMe2konljT4HQ0QYU4ym/WX/Ej7UOk
	 3KTSGcxS6SDxOqRtWskVqyhwpu7fxhBkmY8kP+EtbbyBzAvSG6GsvyvNtUmWdJ2HIZ
	 eEYDDC0B2/0FPsN+xK83dK1lSEEKfVmr9ItAe5y7E53hthWBM91FbpY1/Y7luF8EQI
	 BuCF0QTWMpgFj1EogzEx4gR1qsKaRA8n52+8kMZEN6GD0RFZxRGpg2bd6+KsMfC/6r
	 KqBEUxnsagv3Q==
Date: Wed, 19 Nov 2025 10:04:49 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: bernd@bsbernd.com, joannelkoong@gmail.com, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev,
	linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org,
	zfs-devel@list.zfsonlinux.org
Subject: Re: [PATCHSET v6 4/8] fuse: allow servers to use iomap for better
 file IO performance
Message-ID: <20251119180449.GS196358@frogsfrogsfrogs>
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
 <d0a122b8-3b25-44e6-8c60-538c81b35228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0a122b8-3b25-44e6-8c60-538c81b35228@gmail.com>

On Wed, Nov 19, 2025 at 04:19:36AM -0500, Demi Marie Obenour wrote:
> > By keeping the I/O path mostly within the kernel, we can dramatically
> > increase the speed of disk-based filesystems.
> 
> ZFS, BTRFS, and bcachefs all support compression, checksumming,
> and RAID.  ZFS and bcachefs also support encryption, and f2fs and
> ext4 support fscrypt.
> 
> Will this patchset be able to improve FUSE implementations of these
> filesystems?  I'd rather not be in the situation where one can have
> a FUSE filesystem that is fast, but only if it doesn't support modern
> data integrity or security features.

Not on its own, no.

> I'm not a filesystem developer, but here are some ideas (that you
> can take or leave):
> 
> 1. Keep the compression, checksumming, and/or encryption in-kernel,
>    and have userspace tell the kernel what algorithm and/or encryption
>    key to use.  These algorithms are generally well-known and secure
>    against malicious input.  It might be necessary to make an extra
>    data copy, but ideally that copy could just stay within the
>    CPU caches.

I think this is easily doable for fscrypt and compression since (IIRC)
the kernel filesystems already know how to transform data for I/O, and
nowadays iomap allows hooking of bios before submission and/or after
endio.  Obviously you'd have to store encryption keys in the kernel
somewhere.

Checksumming is harder though, since the checksum information has to be
persisted in the metadata somewhere and AFAICT each checksumming fs does
things differently.  For that, I think the fuse server would have to
convey to the kernel (a) a description of the checksum geometry and (b)
a buffer for storing the checksums.  On write the kernel would compute
the checksum and write it to the buffer for the fs to persist as part of
the ioend; and for read the fuse server would have to read the checksums
into the buffer and pass that to the kernel.

(Note that fsverity won't have this problem because all current
implementations stuff the merkle tree in post-eof datablocks; the
fsverity code only wants fses to read it in the pagecache; and pass it
the page)

> 2. Somehow integrate with the blk-crypto framework.  This has the
>    advantage that it supports inline encryption hardware, which
>    I suspect is needed for this to be usable on mobile devices.
>    After all, the keys on these systems are often not even visible
>    to the kernel, let alone to userspace.

Yes, that would be even easier than messing around with bounce buffers.

> 3. Figure out a way to make a userspace data path fast enough.
>    To prevent data corruption by unprivileged users of the FS,
>    it's necessary to make a copy before checksumming, compression,
>    or authenticated encryption.  If this copy is done in the kernel,
>    the server doesn't have to perform its own copy.  By using large
>    ring buffers, it might be possible to amortize the context switch
>    cost away.
> 
>    Authenticated encryption also needs a copy in the *other* direction:
>    if the (untrusted) client can see unauthenticated plaintext, it's
>    a security vulnerability.  That needs another copy from server
>    buffers to client buffers, and the kernel can do that as well.
> 
> 4. Make context switches much faster.  L4-style IPC is incredibly fast,
>    at least if one doesn't have to worry about Spectre.  Unfortunately,
>    nowadays one *does* need to worry about Spectre.

I don't think context switching overhead is going down.

> Obviously, none of these will be as fast as doing DMA directly to user
> buffers.  However, all of these features (except for encryption using
> inline encryption hardware) come at a performance penalty already.
> I just don't want a FUSE server to have to pay a much larger penalty
> than a kernel filesystem would.
> 
> I'm CCing the bcachefs, BTRFS, and ZFS-on-Linux mailing lists.
> -- 
> Sincerely,
> Demi Marie Obenour (she/her/hers)






