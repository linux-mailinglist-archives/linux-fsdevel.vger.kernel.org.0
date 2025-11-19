Return-Path: <linux-fsdevel+bounces-69067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE25C6DCFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 10:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8F8EF366B36
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 09:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB16340A7A;
	Wed, 19 Nov 2025 09:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="huEK/zG2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8490D2F7AAA;
	Wed, 19 Nov 2025 09:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763545287; cv=none; b=WrORH5yOZLQJ1LHQqv64Ty3uWJl0PS5d0ngaKiTUdRYIZRqi7VAI+BQZZyRPhWgqfTkhZm2oE+Wk0DFvSiGcaNPJXcii+itijRVpapjPOp7myMhOulynozblxzd+2VS2GLvNnZdjeId/HdAUD1YhCdKcS32Uu5KeUDbtb6qrDKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763545287; c=relaxed/simple;
	bh=WRrE8SKdBZ556uYHPiBB/Rwss72t0Uyt/XtCgxsCzPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=egncBt4zU60x74jrXai+RHGybK4KljDsHgC3qOLGfxOKQXDvfjfUuFqeAwUgHZzUuHb8DNYNYKBGyQg385BukKij7ainWXw/SHCxX8idoJiG0Tmm1HdoAEktv8xEq88Io0uQURmsa1h1F5lmMAM7Dta4xwIeWd1Xe8XWlThDQpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=huEK/zG2; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763545281; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=1HL2Tkg5C/S7obHiCDFQGHIECrBu19mg6QTF59ky4ko=;
	b=huEK/zG2iU5jLid98/hkd7PbK3gEtpoUwBCGwOrCih8VfSq9Z7A3rIicvTFOQwzaLSsHwrMqejO07KLKRVGvHrp1rVOXkcywGKa51t3hO4EYOFaHwRSMZLzZgz5/rZ3HZXLEP/UVHGCMc247LV2xASzsCQuo7CPDktCi/5rNmBk=
Received: from 30.221.131.104(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wso825c_1763545279 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Nov 2025 17:41:20 +0800
Message-ID: <2f6ff2a6-6099-42da-84f0-d7adc69850b3@linux.alibaba.com>
Date: Wed, 19 Nov 2025 17:41:19 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v6 4/8] fuse: allow servers to use iomap for better
 file IO performance
To: Demi Marie Obenour <demiobenour@gmail.com>, djwong@kernel.org
Cc: bernd@bsbernd.com, joannelkoong@gmail.com, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev,
 linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org,
 zfs-devel@list.zfsonlinux.org
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
 <d0a122b8-3b25-44e6-8c60-538c81b35228@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <d0a122b8-3b25-44e6-8c60-538c81b35228@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/11/19 17:19, Demi Marie Obenour wrote:
>> By keeping the I/O path mostly within the kernel, we can dramatically
>> increase the speed of disk-based filesystems.
> 
> ZFS, BTRFS, and bcachefs all support compression, checksumming,
> and RAID.  ZFS and bcachefs also support encryption, and f2fs and
> ext4 support fscrypt.
> 
> Will this patchset be able to improve FUSE implementations of these
> filesystems?  I'd rather not be in the situation where one can have
> a FUSE filesystem that is fast, but only if it doesn't support modern
> data integrity or security features.
> 
> I'm not a filesystem developer, but here are some ideas (that you
> can take or leave):
> 
> 1. Keep the compression, checksumming, and/or encryption in-kernel,
>     and have userspace tell the kernel what algorithm and/or encryption

I don't think it's generally feasible unless it's limited to
specific implementations because each transformation-like ondisk
encoded data has its own design, which is unlike raw data.

Although the algorithms are well-known but the ondisk data could
be wrapped up with headers, footers, or specific markers.

I think for the specific fscrypt or fsverity it could be possible
(for example, I'm not sure zfs is 100%-compatible with fscrypt or
fsverity, if they implements similiar stuffs), but considering
generic compression, checksumming, and encryption, filesystem
implementations can do various ways (even in various orders) with
possible additional representations.

>     key to use.  These algorithms are generally well-known and secure
>     against malicious input.  It might be necessary to make an extra
>     data copy, but ideally that copy could just stay within the
>     CPU caches.
Thanks,
Gao Xiang

