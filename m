Return-Path: <linux-fsdevel+bounces-69149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED298C71311
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 22:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 06B842940E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 21:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5D73093CD;
	Wed, 19 Nov 2025 21:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yLOQQZvu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3BC2D063E;
	Wed, 19 Nov 2025 21:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763589076; cv=none; b=f1KdzgcmjlNd6CnAx5ahUOXxSYcCLSjsrVLcq9dnbneiHLa1ZJQJqS76tAuj1laB8Edn+0ZSD7R5H7h8523T6B4ROlz68WYeBuS9x7hbkYsJi3uPI76M4eA9XAfNN01lyHSpQcGQNvpGDiwWSZ4ysK0hFV/Ro0zUvp6vJenuedY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763589076; c=relaxed/simple;
	bh=rjO8/EIU0uGA9VyCRUHGKIFo2Cfr0MckSaPfGU8kzbA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WFCLIFObOH1+oc6KSgHJL1yq91ZOsj/Bow/kKIpxfVIMB38sv9QwcvsJtBhaLsghx4GTCsUylK51TIIhbXRFfndMpjBFmbOhFUzeZoWT8pVgj/jsUmeOfZi6NdP0bbT78Ycl2s7yYBLEsu/9FYidi9jEvoZZtIXikYE3LkZrMl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yLOQQZvu; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763589069; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=a2ebXqu2wMZ+a9A6Ssx3+/b3Gpxusqda3SSXvC7SSQ8=;
	b=yLOQQZvutSRbuB9Ucuc14XqT2mgHARH9ug/oJGPBc3n8xJVFZdd+Xis/eA/4gIitrYtanHgyVngLIGQ0yFZW3XJxlZAwgmTNn3grOWTitv2hQzHI9W7DKbVC9w8/K2/Jd+ZnQVMS17YjU427Xqru4ziFqiLC5WbhJTT7l9yYJLg=
Received: from 30.170.82.147(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WsqMdLV_1763589067 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 20 Nov 2025 05:51:08 +0800
Message-ID: <1be4cb25-50e2-46fa-ba86-d6342e997e63@linux.alibaba.com>
Date: Thu, 20 Nov 2025 05:51:07 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v6 4/8] fuse: allow servers to use iomap for better
 file IO performance
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: "Darrick J. Wong" <djwong@kernel.org>,
 Demi Marie Obenour <demiobenour@gmail.com>
Cc: bernd@bsbernd.com, joannelkoong@gmail.com, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev,
 linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org,
 zfs-devel@list.zfsonlinux.org
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
 <d0a122b8-3b25-44e6-8c60-538c81b35228@gmail.com>
 <20251119180449.GS196358@frogsfrogsfrogs>
 <af9a8030-cd19-457c-8c15-cb63e8140dfc@linux.alibaba.com>
In-Reply-To: <af9a8030-cd19-457c-8c15-cb63e8140dfc@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/11/20 05:00, Gao Xiang wrote:
> 
> 
> On 2025/11/20 02:04, Darrick J. Wong wrote:
>> On Wed, Nov 19, 2025 at 04:19:36AM -0500, Demi Marie Obenour wrote:
>>>> By keeping the I/O path mostly within the kernel, we can dramatically
>>>> increase the speed of disk-based filesystems.
>>>
>>> ZFS, BTRFS, and bcachefs all support compression, checksumming,
>>> and RAID.  ZFS and bcachefs also support encryption, and f2fs and
>>> ext4 support fscrypt.
>>>
>>> Will this patchset be able to improve FUSE implementations of these
>>> filesystems?  I'd rather not be in the situation where one can have
>>> a FUSE filesystem that is fast, but only if it doesn't support modern
>>> data integrity or security features.
>>
>> Not on its own, no.
>>
>>> I'm not a filesystem developer, but here are some ideas (that you
>>> can take or leave):
>>>
>>> 1. Keep the compression, checksumming, and/or encryption in-kernel,
>>>     and have userspace tell the kernel what algorithm and/or encryption
>>>     key to use.  These algorithms are generally well-known and secure
>>>     against malicious input.  It might be necessary to make an extra
>>>     data copy, but ideally that copy could just stay within the
>>>     CPU caches.
>>
>> I think this is easily doable for fscrypt and compression since (IIRC)
>> the kernel filesystems already know how to transform data for I/O, and
>> nowadays iomap allows hooking of bios before submission and/or after
>> endio.  Obviously you'd have to store encryption keys in the kernel
>> somewhere.
> 
> I think it depends, since (this way) it tries to reuse some of the
> existing kernel filesystem implementations (and assuming the code is
> safe), so at least it still needs to load a dedicated kernel module
> for such usage at least.
> 
> I think it's not an issue for userspace ext4 of course (because ext4
> and fscrypt is almost builtin for all kernels), but for out-of-tree
> fses even pure userspace fses, I'm not sure it's doable to load the
> module in a container context.

Two examples for reference:

  - For compression, in-tree f2fs already has a compression header
    in data of each compressed extent:
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/f2fs/f2fs.h?h=v6.17#n1497

    while other fs may store additional metadata in extent metadata
    or other place.

  - gocryptfs (a pure userspace FUSE fs) uses a different format
    from fscrypt (encrypted data seems even unaligned on disk):
    https://github.com/rfjakob/gocryptfs/blob/master/Documentation/file-format.md

> 
> Maybe eBPF is useful for this area, but it's still not quite
> flexible compared to native kernel filesystems.
> 
> Thanks,
> Gao Xiang


