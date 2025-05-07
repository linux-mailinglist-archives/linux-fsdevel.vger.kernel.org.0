Return-Path: <linux-fsdevel+bounces-48392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA9CAAE37A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 16:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C02F1886F00
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 14:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082A1289E0A;
	Wed,  7 May 2025 14:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzomURi8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620CB28031D
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 May 2025 14:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746629191; cv=none; b=CPDh9VkfLSPXFFEZvKAp43RkpYNyZuS/uun+/tFAHv79mviRXot+HupmEN7AEA9IbszY1i0qkYs+WEFheW+TVWeCvmZETKvtvmYKwlz49CqgKrE1kIFz0i2Z9eeU9wiKD3pv0iYf+t84dDaNX0L9/Ot0n5kr17w10Q1b8yoYq7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746629191; c=relaxed/simple;
	bh=TSBK7Zhp0qoNQXQ37DDp2OqwBn69raU+RQxf+KNX3Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qo3vfGK7XpnwfZ+pR6YNNNd1wRohNDU7mhYR37inkEyw8ga8lqoo2gd6Q3qMycgKm6NWurYt2Ls7kBmlI3RxTRaKU/MMrB5EpY9PpP+LmqDh33oZ2Ipib5wB7ZRq3f5uc+N4ZqF/sGMeECY9ALq0UoG/HxPyNaoIk0J7GBT13OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzomURi8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 788D8C4CEE2;
	Wed,  7 May 2025 14:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746629190;
	bh=TSBK7Zhp0qoNQXQ37DDp2OqwBn69raU+RQxf+KNX3Lc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lzomURi86Vj2XKf9yhX3YM9dt2TD0Aa7KqeMMIwv/ThfRWONpC4R93DzKY3M+qvgD
	 TWFNVWpVKeZF2s7u/f33KBWM9EQR9GOHcpqMYtlzu8GbB81NigJU6eqxrKTH9ZN6z+
	 Bve/ICkghr1CEtylZv3J8ypU6l9vG1hBbplBmcnMWdTUBDGrVPeBzAB7Ei0c17JhDc
	 2BZcaqP2G3UlSglmy0Fhvgi9yBSv03l/TH4I/DbGNT7tiXc4xLarH6uMDNl//vVccW
	 1aXpmoEid/a/1NjWmPFMgin1UD+Q0rBJpIQKXeLPibKLjr+KaQtiTlweFJvw8frRjA
	 9w+m+YWXDpFKw==
Date: Wed, 7 May 2025 14:46:28 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	chao@kernel.org, lihongbo22@huawei.com
Subject: Re: [PATCH V3 0/7] f2fs: new mount API conversion
Message-ID: <aBtyRFIrDU3IfQhV@google.com>
References: <20250423170926.76007-1-sandeen@redhat.com>
 <aBqq1fQd1YcMAJL6@google.com>
 <f9170e82-a795-4d74-89f5-5c7c9d233978@redhat.com>
 <aBq2GrqV9hw5cTyJ@google.com>
 <380f3d52-1e48-4df0-a576-300278d98356@redhat.com>
 <25cb13c8-3123-4ee6-b0bc-b44f3039b6c1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25cb13c8-3123-4ee6-b0bc-b44f3039b6c1@redhat.com>

On 05/06, Eric Sandeen wrote:
> On 5/6/25 9:56 PM, Eric Sandeen wrote:
> > On 5/6/25 8:23 PM, Jaegeuk Kim wrote:
> 
> ...
> 
> >> What about:
> >> # mount -o loop,noextent_cache f2fsfile.img mnt
> >>
> >> In this case, 1) ctx_clear_opt(), 2) set_opt() in default_options,
> >> 3) clear_opt since mask is set?
> > 
> > Not sure what I'm missing, it seems to work properly here but I haven't
> > pulled your (slightly) modified patches yet:
> > 
> > # mount -o loop,extent_cache f2fsfile.img mnt
> > # mount | grep -wo extent_cache
> > extent_cache
> > # umount mnt
> > 
> > # mount -o loop,noextent_cache f2fsfile.img mnt
> > # mount | grep -wo noextent_cache
> > noextent_cache
> > #
> > 
> > this looks right?
> > 
> > I'll check your tree tomorrow, though it doesn't sound like you made many
> > changes.
> 
> Hmm, I checked tonight and I see the same (correct?) behavior in your tree.
> 
> >> And, device_aliasing check is still failing, since it does not understand
> >> test_opt(). Probably it's the only case?
> 
> Again, in your tree (I had to use a git version of f2fs-tools to make device
> aliasing work - maybe time for a release?) ;) 
> 
> # mkfs.ext4 /dev/vdc
> # mkfs/mkfs.f2fs -c /dev/vdc@vdc.file /dev/vdb
> # mount -o noextent_cache /dev/vdb mnt
> # dmesg | tail -n 1
> [  581.924604] F2FS-fs (vdb): device aliasing requires extent cache
> # mount -o extent_cache /dev/vdb mnt
> # mount | grep -wo extent_cache
> extent_cache
> # 

I meant:

# mkfs/mkfs.f2fs -c /dev/vdc@vdc.file /dev/vdb
# mount /dev/vdb mnt

It's supposed to be successful, since extent_cache is enabled by default.

> 
> Maybe you can show me exactly what's not working for you?
> 
> -Eric

