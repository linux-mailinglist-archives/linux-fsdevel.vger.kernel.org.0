Return-Path: <linux-fsdevel+bounces-69146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EFEC711AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 22:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA90D4E1481
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 21:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E9D2D7DCA;
	Wed, 19 Nov 2025 21:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gCnH8K+t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF337372AC3;
	Wed, 19 Nov 2025 21:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763586047; cv=none; b=kikugCcJwjUyqaTgOW14gJNB0UqWms/QyyN1i8OIgZxMu5QObZX72Ga0o0fQM3oRbSKTn4pc38mYdJe1vOGlDZHwIRCxagiv3S5ZzdvM3G3QWeIyEj7xG5iLwmXd2tTBSKugWFxUxBKnl1Y265tMhbZvLTsEy8X4iAi+Oj8qOq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763586047; c=relaxed/simple;
	bh=r7C8xS7yEE6YYuP/pA5ysFrNgtT5U3/+DkMPNzLpe5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bsza0HR71/MBRwy3UXxbS/mRQP8ibBM92+F6EwZTiFFJmjNm9+KDHpORAI3eRie1BOWVZlWW5KBwtttovW1wJiAtBWmc7lmZ0TI/egwADy/yOMYBM9Dzf39LUViYAP5eA6NY9ObCX3+GEUrKQtBrXDMMDJa8ag2TSjFJO1xBp3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gCnH8K+t; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763586040; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=XIHVJS64IJK02n9X3Q9SJUGrPypXfQhkFr8iSbiymFs=;
	b=gCnH8K+taUmv+d9Y7T162Yi/0gZ5xCymJaLefL0BfG21da2pQVlKxsapkLzoXYLaIPGwiaL5f+b1iXOc9lw8pAUaOVsDFDrTm2bE+1JeCMt9HzDywN02a1BnLZPyG8xvN8yjZ2il9ILUKybEoW4PpGd8ZVzftnXmDtT2ixszIjY=
Received: from 30.170.82.147(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WsqDtfP_1763586038 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 20 Nov 2025 05:00:40 +0800
Message-ID: <af9a8030-cd19-457c-8c15-cb63e8140dfc@linux.alibaba.com>
Date: Thu, 20 Nov 2025 05:00:38 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v6 4/8] fuse: allow servers to use iomap for better
 file IO performance
To: "Darrick J. Wong" <djwong@kernel.org>,
 Demi Marie Obenour <demiobenour@gmail.com>
Cc: bernd@bsbernd.com, joannelkoong@gmail.com, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev,
 linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org,
 zfs-devel@list.zfsonlinux.org
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
 <d0a122b8-3b25-44e6-8c60-538c81b35228@gmail.com>
 <20251119180449.GS196358@frogsfrogsfrogs>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251119180449.GS196358@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/11/20 02:04, Darrick J. Wong wrote:
> On Wed, Nov 19, 2025 at 04:19:36AM -0500, Demi Marie Obenour wrote:
>>> By keeping the I/O path mostly within the kernel, we can dramatically
>>> increase the speed of disk-based filesystems.
>>
>> ZFS, BTRFS, and bcachefs all support compression, checksumming,
>> and RAID.  ZFS and bcachefs also support encryption, and f2fs and
>> ext4 support fscrypt.
>>
>> Will this patchset be able to improve FUSE implementations of these
>> filesystems?  I'd rather not be in the situation where one can have
>> a FUSE filesystem that is fast, but only if it doesn't support modern
>> data integrity or security features.
> 
> Not on its own, no.
> 
>> I'm not a filesystem developer, but here are some ideas (that you
>> can take or leave):
>>
>> 1. Keep the compression, checksumming, and/or encryption in-kernel,
>>     and have userspace tell the kernel what algorithm and/or encryption
>>     key to use.  These algorithms are generally well-known and secure
>>     against malicious input.  It might be necessary to make an extra
>>     data copy, but ideally that copy could just stay within the
>>     CPU caches.
> 
> I think this is easily doable for fscrypt and compression since (IIRC)
> the kernel filesystems already know how to transform data for I/O, and
> nowadays iomap allows hooking of bios before submission and/or after
> endio.  Obviously you'd have to store encryption keys in the kernel
> somewhere.

I think it depends, since (this way) it tries to reuse some of the
existing kernel filesystem implementations (and assuming the code is
safe), so at least it still needs to load a dedicated kernel module
for such usage at least.

I think it's not an issue for userspace ext4 of course (because ext4
and fscrypt is almost builtin for all kernels), but for out-of-tree
fses even pure userspace fses, I'm not sure it's doable to load the
module in a container context.

Maybe eBPF is useful for this area, but it's still not quite
flexible compared to native kernel filesystems.

Thanks,
Gao Xiang

