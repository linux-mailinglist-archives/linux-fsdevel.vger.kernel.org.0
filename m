Return-Path: <linux-fsdevel+bounces-46897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BFCA95FBA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 09:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41D5E188DFE7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 07:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF23F1EB5E7;
	Tue, 22 Apr 2025 07:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrmuUMPs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165D8CA64
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 07:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745307820; cv=none; b=ajybZ0K5gKuUu7DRGnRaxsdLJHNFIsYpSl3JcpF3mR3XMcbHFttgkRo0qOVsKDqFiyiBmQjQTGZhIoam7PnvoSoB/tQnzZLb6fPH8Pa7MKwdYNUxHHasqdcwGVJ9Lz35v7e5RHVuO9zH30wJNyI5gIf4+f+kAu1nc4IpZNPpYq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745307820; c=relaxed/simple;
	bh=op6Wt/aJdRdrx8ePAOhOB2s7HW5Q3+2M5ZEbWz9paQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b61fvBZsxGfcCYkqafFCT2e4lE64kv9Fz8v9g8xDy84jJa9awdPqJ4MIdGKbD8TCXImZa1MEyBkqcfBT9xwHSsImVxVnkKL9vnLEjmlPkcb31vBe9zyofc+9k6qQYKsZ4DoZqXXl0TpzT0M3qdTrs5T2dl2wcSwaXPrATHFEu5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrmuUMPs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBFA2C4CEE9;
	Tue, 22 Apr 2025 07:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745307819;
	bh=op6Wt/aJdRdrx8ePAOhOB2s7HW5Q3+2M5ZEbWz9paQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TrmuUMPsyZN0+Ny3v9pySGDxMTDwEWH1rIm07tvInJprgMN70irV1thGOPAlw0AZg
	 dLRn1QPucq0gKsmmfKXX3N2sdBIx/kIcUgEFWodPVIcBsvpc1BOj5QD50RcSwz/c4E
	 lWxX4A4g9jvC72Ss0BFCToggECkYLB0WZMSJ2zfypNzJRfSs3UbhFgAa70nj7semrv
	 mnLrVg3g2xErjNrAsqOmEU3QJeGW14gur1cS3NCR2zxhicAkUfzTuvSQt3u+do9HMO
	 Evm6NvxjHBxCtK6H3npCii+gqbk3xKhO83oDQ2Q3JHm6apcXXBbudBBw+fM9XC3oIl
	 6snnUoRsOMX1w==
Date: Tue, 22 Apr 2025 09:43:35 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH][RFC] ->mnt_devname is never NULL
Message-ID: <20250422-spaghetti-frohsinn-bc60b1563323@brauner>
References: <20250421033509.GV2023217@ZenIV>
 <20250421-annehmbar-fotoband-eb32f31f6124@brauner>
 <20250421162947.GW2023217@ZenIV>
 <20250421170319.GX2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250421170319.GX2023217@ZenIV>

On Mon, Apr 21, 2025 at 06:03:19PM +0100, Al Viro wrote:
> On Mon, Apr 21, 2025 at 05:29:47PM +0100, Al Viro wrote:
> 
> > What's to prevent the 'beneath' case from getting mnt mount --move'd
> > away *AND* the ex-parent from getting unmounted while we are blocked
> > in inode_lock?  At this point we are not holding any locks whatsoever
> > (and all mount-related locks nest inside inode_lock(), so we couldn't
> > hold them there anyway).
> > 
> > Hit that race and watch a very unhappy umount...
> 
> While we are at it, in normal case inode_unlock() in unlock_mount()
> is safe since we have dentry (and associated mount) pinned by
> struct path we'd fed to matching lock_mount().  No longer true for
> the 'beneath' case, AFAICS...

I'm not following. Please explain the issue in detail. Both mount and
dentry are pinned via struct path independent of whether its beneath or
not beneath.

What we pass to unlock_mount() is the mountpoint which pins the relevant
dentry separately. do_lock_mount() keeps @dentry for the mountpoint
pinned until it has taken a separate reference. We only put the
reference to the mountpoint's dentry if we know that the for (;;) will
continue aka not break or when get_mountpoint() has taken it's own
reference.

So really, I'm very confused atm.

Also if this were the case all invasive move mount beneath tests I added
should cause endless splats under any sort of KASAN which they are
constantly run under in a tight loop in my local testing and by syzbot.
For the latter I explicitly added support for it in:

https://github.com/google/syzkaller/commit/058b3a5a6a945a55767811552eb7b9f4a20307f8

