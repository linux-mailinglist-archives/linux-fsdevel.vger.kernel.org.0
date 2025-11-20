Return-Path: <linux-fsdevel+bounces-69172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFFFC71B8D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 02:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id BB3D029B12
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 01:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D8826CE22;
	Thu, 20 Nov 2025 01:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VL7UjQTd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D1D25D917;
	Thu, 20 Nov 2025 01:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763603404; cv=none; b=BMXIRS1mhwjMu4q7Jc0yQY7PKU4O1Wwkgkz5x0KvsNvqonQwjfRciSM47t34GsAupiHWO5Rr5V5Yvs9MPjqUeD0CU0nexL77leFZA3A2bLOOtobphon3C8FJQDVA3h3X+9c882ayjqpdg5fafaKXszWFbskzUGXVtVfCP792hrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763603404; c=relaxed/simple;
	bh=1SV4WzL6clJhSl2oZ+Jsh9n+jQe3xYNIxnIR3TgqfNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hDtgIxdLTYIU8EBdC6A3UDjE8AqXG7wYf+sTq0dTn7Xtaj8bCQdSc0BCfEN+M3tUpPx3uEALugvp3y6vpe33KtknAWT1raNCf56kvcxypJrfyhRAfCRYYfVGdLFhNuHqXNFgNpk8PCNPnwQHj0TFljVaJhzFwMJ/nKDBE8X6k8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VL7UjQTd; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763603396; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=QHEG4P4AQlRs6gFmGtCUhMAClehZaBYljEnADdwliPk=;
	b=VL7UjQTdlDgki6Xkj+d4UpIDUmVxR/IVmjcyDxlXwg9vTYc55ujDm116qUY+XrG8Q/6v6LxTnwN7F4NYtSB0G/HidMt3DWh/otV1yDy49DF5xxBhTLa6Nel9pijVyXBHdiMxm4R1eIPxxaGypb/RQbCWTdE5iNlXhy/N/N9EDOU=
Received: from 30.221.131.60(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wsr7S9X_1763603395 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 20 Nov 2025 09:49:56 +0800
Message-ID: <2baf2118-c0aa-43da-8fc7-0047fc31023f@linux.alibaba.com>
Date: Thu, 20 Nov 2025 09:49:55 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v6 4/8] fuse: allow servers to use iomap for better
 file IO performance
To: Demi Marie Obenour <demiobenour@gmail.com>,
 "Darrick J. Wong" <djwong@kernel.org>
Cc: bernd@bsbernd.com, joannelkoong@gmail.com, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev,
 linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org,
 zfs-devel@list.zfsonlinux.org
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
 <d0a122b8-3b25-44e6-8c60-538c81b35228@gmail.com>
 <20251119180449.GS196358@frogsfrogsfrogs>
 <af9a8030-cd19-457c-8c15-cb63e8140dfc@linux.alibaba.com>
 <aaf98238-e8f6-472d-bfb9-7f8ddbab8e02@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <aaf98238-e8f6-472d-bfb9-7f8ddbab8e02@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/11/20 09:10, Demi Marie Obenour wrote:
> On 11/19/25 16:00, Gao Xiang wrote:
>>
>>
>> On 2025/11/20 02:04, Darrick J. Wong wrote:
>>> On Wed, Nov 19, 2025 at 04:19:36AM -0500, Demi Marie Obenour wrote:
>>>>> By keeping the I/O path mostly within the kernel, we can dramatically
>>>>> increase the speed of disk-based filesystems.
>>>>
>>>> ZFS, BTRFS, and bcachefs all support compression, checksumming,
>>>> and RAID.  ZFS and bcachefs also support encryption, and f2fs and
>>>> ext4 support fscrypt.
>>>>
>>>> Will this patchset be able to improve FUSE implementations of these
>>>> filesystems?  I'd rather not be in the situation where one can have
>>>> a FUSE filesystem that is fast, but only if it doesn't support modern
>>>> data integrity or security features.
>>>
>>> Not on its own, no.
>>>
>>>> I'm not a filesystem developer, but here are some ideas (that you
>>>> can take or leave):
>>>>
>>>> 1. Keep the compression, checksumming, and/or encryption in-kernel,
>>>>      and have userspace tell the kernel what algorithm and/or encryption
>>>>      key to use.  These algorithms are generally well-known and secure
>>>>      against malicious input.  It might be necessary to make an extra
>>>>      data copy, but ideally that copy could just stay within the
>>>>      CPU caches.
>>>
>>> I think this is easily doable for fscrypt and compression since (IIRC)
>>> the kernel filesystems already know how to transform data for I/O, and
>>> nowadays iomap allows hooking of bios before submission and/or after
>>> endio.  Obviously you'd have to store encryption keys in the kernel
>>> somewhere.
>>
>> I think it depends, since (this way) it tries to reuse some of the
>> existing kernel filesystem implementations (and assuming the code is
>> safe), so at least it still needs to load a dedicated kernel module
>> for such usage at least.
> 
> My hope is that these modules could be generic library code.

Actually, the proposed generic library code for compression,
checksumming, and encryption is already in "crypto/", but
except for checksumming usage, filesystems rarely use the
others, mostly because of inflexibility (for example,
algorithms may have case-by-case advanced functionality.)

> Compression, checksumming, and encryption algorithms aren't specific
> to any particular filesystem, and the kernel might well be using them
> already for other purposes.
> 
> Of course, it's still the host admin's job to make sure the relevant
> modules are loaded, unless they are autoloaded.

My thought is still roughly that, although algorithms could
be generic, the specific implementations are still varied
due to different filesystem on-disk intrinsicness (each
filesystem has its own special trait) and/or whether designs
are made with thoughtful thinking.  fscrypt and fsverity are
Linux kernel reference implementations, but, for example,
fsverity metadata representation still takes a while for
XFS folks to discuss (of course it doesn't impact the main
mechanism).

> 
>> I think it's not an issue for userspace ext4 of course (because ext4
>> and fscrypt is almost builtin for all kernels), but for out-of-tree
>> fses even pure userspace fses, I'm not sure it's doable to load the
>> module in a container context.
>>
>> Maybe eBPF is useful for this area, but it's still not quite
>> flexible compared to native kernel filesystems.
>>
>> Thanks,
>> Gao Xiang
> Thank you for the feedback!

Thanks,
Gao Xiang



