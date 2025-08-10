Return-Path: <linux-fsdevel+bounces-57203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9068CB1F89A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 08:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26083160C0C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 06:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42467229B36;
	Sun, 10 Aug 2025 06:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=wiesinger.com header.i=@wiesinger.com header.b="NxcgECf6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from vps01.wiesinger.com (vps01.wiesinger.com [46.36.37.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF88376;
	Sun, 10 Aug 2025 06:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.36.37.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754806852; cv=none; b=iTcdud4AL4PEdVTMQOs8B3pPmH9EPOEYBFXGBCk/zsmggVyjhMIvVl3Zairs47HJyvgdFl5Xaf/6rc3XhjVE1X3d0PpdXXFPbSIP8vPGUqSq7ocot5DR96ZN6v/c/nxGpssBBBPv/WvBqmJ7hKeJDfY2y3bzdfYd1EbMmX5kbTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754806852; c=relaxed/simple;
	bh=M7BvxSuPFE1PLsNqp4rFUS6XlJhH6tEbM4K6dTLyfDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uA6NvUH0tA6Bvxkyz3hvx/St96O9UZn8rBu3gEs1XOrxQS6XeOIOi9fmDMlbpttVVsWD/6lFml1dX6T2ssUIoyLtoeZcx5bf+zvwpt/lsPdDfeaFXFwEglHM0baCYclsa2yLVn5a1rXDvGj3cZ8UNoRgLSNQwgU77fV7dxfGCwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wiesinger.com; spf=pass smtp.mailfrom=wiesinger.com; dkim=pass (4096-bit key) header.d=wiesinger.com header.i=@wiesinger.com header.b=NxcgECf6; arc=none smtp.client-ip=46.36.37.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wiesinger.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiesinger.com
Received: from wiesinger.com (wiesinger.com [84.112.177.114])
	by vps01.wiesinger.com (Postfix) with ESMTPS id 30C389F297;
	Sun, 10 Aug 2025 08:20:47 +0200 (CEST)
Received: from [192.168.33.7] (wireguard7.intern [192.168.33.7] (may be forged))
	(authenticated bits=0)
	by wiesinger.com (8.18.1/8.18.1) with ESMTPSA id 57A6KhtN1484441
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sun, 10 Aug 2025 08:20:44 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 wiesinger.com 57A6KhtN1484441
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiesinger.com;
	s=default; t=1754806845;
	bh=GAdzF4QqfDT99s7sOhQOl37zKv8DI7o1004cutcmn6g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NxcgECf6x5++A999sOmr/8Tbj9CLYMiH9ruTJSCmiwPwFT8ok/LrqGAZtCkoNy+W8
	 V7rqHMflCvqzsWdLm6y/PAzjNYm0RUOUpDNe0yyyO2/8nMcBdtfLlQ51CeuNJ1sbnI
	 eV8z0HuCuE5IOPQZqmqA8tQuho5o9LMzjuzaP2nP+JcwoxXP5eLbPjtlbWTQCtVjDQ
	 DFMA91kI9xzBE1EVI+lLu3wHZpIW/xMoRbffqF/IDwfEZlY/c5vk3vm0ooSxity+By
	 gHzr6er2z2qmlOcw6ej0ySJzUmkXQEwrRt4WqcNYavdTxr25S+nBbot/AY9yf3PQDu
	 4tDwMQiMNxoVA+V3cBrgImIbpdJstjveS7BmaQ1QZmo/u+krSbeSc28Q7JppefjnC8
	 YikeZZYaKRSkp4YHm2Gp3Wsi+PNef2n0i/kxTedrovn5tlo4ecNjCkj/IPYdQOL/Is
	 DgoESdCK41Lxidj1DFvToVPBws5qDB/nWE9BEDWSHoxcKFaVgADNLf4WSGf0RuKnTf
	 zcmdLP/EWpeNVV/M/6ayL5eHkSbVYIuaGAAxcdke6X36QvnfnlJ1+BZtEN+iJj+OZe
	 j6/WAiVJWUZQvRFd7TXuanW/8dBTBjL7ku30eMvYVMDfcMF4J3TvcTkP3DUjlRvp9G
	 uNEyDiZSMPAoCiUPrrlGKdFo=
Message-ID: <e19849f2-4a39-4a09-b19e-cb4f291a2dc2@wiesinger.com>
Date: Sun, 10 Aug 2025 08:20:43 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [GIT PULL] bcachefs changes for 6.17
Content-Language: en-US
To: Kent Overstreet <kent.overstreet@linux.dev>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <22ib5scviwwa7bqeln22w2xm3dlywc4yuactrddhmsntixnghr@wjmmbpxjvipv>
From: Gerhard Wiesinger <lists@wiesinger.com>
In-Reply-To: <22ib5scviwwa7bqeln22w2xm3dlywc4yuactrddhmsntixnghr@wjmmbpxjvipv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28.07.2025 17:14, Kent Overstreet wrote:
> Schedule notes for users:
>
> I've been digging through the bug tracker and polling users to see what
> bugs are still outstanding, and - it's not much.
>
> So, the experimental label is coming off in 6.18.
>
> As always, if you do hit a bug, please report it.
>
I can now confirm that bcachefs is getting stable and the test cases 
with intentionally data corruption (simulation of a real world case I 
had) gets bcachefs back to a consistent state (after 2 runs of: bcachefs 
fsck -f -y ${DEV}). That's a base requirement for a stable filesystem. 
Version of bcachefs-tools is git 
530e8ade4e6af7d152f4f79bf9f2b9dec6441f2b and kernel is 
6.16.0-200.fc42.x86_64.

See for details, I made data corruption even worser with running the 
destroy script 5x:

https://lore.kernel.org/linux-bcachefs/aa613c37-153c-43e4-b68e-9d50744be7de@wiesinger.com/

Great work Kent and the other contributors.

Unfortunately btrfs can't be repaired to a consistent state with the 
same testcase. I'd like to be that testcase fixed also for BTRFS as a 
stable filesystem (versions: 6.16.0-200.fc42.x86_64, btrfs-progs v6.15, 
-EXPERIMENTAL -INJECT -STATIC +LZO +ZSTD +UDEV +FSVERITY +ZONED 
CRYPTO=libgcrypt).

(I reported that already far in the past on the mailing list, see here: 
https://lore.kernel.org/linux-btrfs/63f8866f-ceda-4228-b595-e37b016e7b1f@wiesinger.com/).

Thnx.

Ciao,

Gerhard


