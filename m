Return-Path: <linux-fsdevel+bounces-72806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48385D0402D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 16:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 776813126357
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 15:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF4843AD7A;
	Thu,  8 Jan 2026 09:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HBgma4z1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F281D43C044;
	Thu,  8 Jan 2026 09:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864356; cv=none; b=gBlkBMmOL76VGIbc6S3IIJRBAwkgbyTvThqWoKjfdiixe0GR0RsLqmwCfh4x+8ZlldF6EOnXLztVrC5HSTCwogmHjxgD4dhuLyEi8h5ovbdhDJBuUJso3z5is5ynVkwFMrlirdqmQbv17TVQ4ydiODPCQUzihVfjdcRU1KxqLrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864356; c=relaxed/simple;
	bh=NVppUQc/hTHyoQWvfHp5asa82U5s99VasdQIx4djeK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uJKHIKjF5G8GpDhGE3ngqXrBEo+IpDhQ0mrMSnEbjwyqCPc57muaM/uevGYC0IfYVPO0v5a6VTNoWewSKTcMqHVdmTHvfN5e9LJTTEFvBMvAICXCqwBSJ3vuUn2mVW/CLZWXCj/N0F3ppN1Nc13bJr6gZPeyF4Utpfh0zkSmsTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HBgma4z1; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767864340; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=R81n7a/YK49HxVlPNyTqmXKfaVXMmyysflz3STjD8Zc=;
	b=HBgma4z1+N/b1ZmnO5kucBvTTdC3VBAkqcHlaf4yio6NMy5zLGJljuU/uvBdjBu46CptDzHIom5uR4iL7M2Q9NwYybTSof995T5BDul8yNAByLrVDB4NpcYid7zxT3itKVrzK3ABeH6shWieVmGtaxZfVIVKd9TIL0G21zjlLE8=
Received: from 30.221.132.104(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wwc942C_1767864338 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 08 Jan 2026 17:25:39 +0800
Message-ID: <bf7f5eb0-7c9f-41e1-9a39-2278595b98e9@linux.alibaba.com>
Date: Thu, 8 Jan 2026 17:25:37 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 RESEND] erofs: don't bother with s_stack_depth
 increasing for now
To: Sheng Yong <shengyong2021@gmail.com>, linux-erofs@lists.ozlabs.org
Cc: shengyong1@xiaomi.com, LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Dusty Mabe <dusty@dustymabe.com>, =?UTF-8?Q?Timoth=C3=A9e_Ravier?=
 <tim@siosm.fr>, =?UTF-8?B?QWxla3PDqWkgTmFpZMOpbm92?= <an@digitaltide.io>,
 Amir Goldstein <amir73il@gmail.com>, Alexander Larsson <alexl@redhat.com>,
 Christian Brauner <brauner@kernel.org>, Miklos Szeredi
 <mszeredi@redhat.com>, Zhiguo Niu <niuzhiguo84@gmail.com>
References: <3acec686-4020-4609-aee4-5dae7b9b0093@gmail.com>
 <20260108030709.3305545-1-hsiangkao@linux.alibaba.com>
 <243f57b8-246f-47e7-9fb1-27a771e8e9e8@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <243f57b8-246f-47e7-9fb1-27a771e8e9e8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Sheng,

On 2026/1/8 17:14, Sheng Yong wrote:
> On 1/8/26 11:07, Gao Xiang wrote:
>> Previously, commit d53cd891f0e4 ("erofs: limit the level of fs stacking
>> for file-backed mounts") bumped `s_stack_depth` by one to avoid kernel
>> stack overflow when stacking an unlimited number of EROFS on top of
>> each other.
>>
>> This fix breaks composefs mounts, which need EROFS+ovl^2 sometimes
>> (and such setups are already used in production for quite a long time).
>>
>> One way to fix this regression is to bump FILESYSTEM_MAX_STACK_DEPTH
>> from 2 to 3, but proving that this is safe in general is a high bar.
>>
>> After a long discussion on GitHub issues [1] about possible solutions,
>> one conclusion is that there is no need to support nesting file-backed
>> EROFS mounts on stacked filesystems, because there is always the option
>> to use loopback devices as a fallback.
>>
>> As a quick fix for the composefs regression for this cycle, instead of
>> bumping `s_stack_depth` for file backed EROFS mounts, we disallow
>> nesting file-backed EROFS over EROFS and over filesystems with
>> `s_stack_depth` > 0.
>>
>> This works for all known file-backed mount use cases (composefs,
>> containerd, and Android APEX for some Android vendors), and the fix is
>> self-contained.
>>
>> Essentially, we are allowing one extra unaccounted fs stacking level of
>> EROFS below stacking filesystems, but EROFS can only be used in the read
>> path (i.e. overlayfs lower layers), which typically has much lower stack
>> usage than the write path.
>>
>> We can consider increasing FILESYSTEM_MAX_STACK_DEPTH later, after more
>> stack usage analysis or using alternative approaches, such as splitting
>> the `s_stack_depth` limitation according to different combinations of
>> stacking.
>>
>> Fixes: d53cd891f0e4 ("erofs: limit the level of fs stacking for file-backed mounts")
>> Reported-and-tested-by: Dusty Mabe <dusty@dustymabe.com>
>> Reported-by: Timothée Ravier <tim@siosm.fr>
>> Closes: https://github.com/coreos/fedora-coreos-tracker/issues/2087 [1]
>> Reported-by: "Alekséi Naidénov" <an@digitaltide.io>
>> Closes: https://lore.kernel.org/r/CAFHtUiYv4+=+JP_-JjARWjo6OwcvBj1wtYN=z0QXwCpec9sXtg@mail.gmail.com
>> Acked-by: Amir Goldstein <amir73il@gmail.com>
>> Acked-by: Alexander Larsson <alexl@redhat.com>
>> Cc: Christian Brauner <brauner@kernel.org>
>> Cc: Miklos Szeredi <mszeredi@redhat.com>
>> Cc: Sheng Yong <shengyong1@xiaomi.com>
>> Cc: Zhiguo Niu <niuzhiguo84@gmail.com>
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Reviewed-and-tested-by: Sheng Yong <shengyong1@xiaomi.com>
> 
> I tested the APEX scenario on an Android phone. APEX images are
> filebacked-mounted correctly.


> And for a stacked APEX testcase, it reports error as expected.

Just to make sure it's an invalid case (should not be used on
Android), yes? If so, thanks for the test on the APEX side.

Thanks,
Gao Xiang

> 
> thanks,
> shengyong

