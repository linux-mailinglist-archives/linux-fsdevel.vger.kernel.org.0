Return-Path: <linux-fsdevel+bounces-59516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E88B3A77F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 19:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 844841C8411D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 17:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB035338F5E;
	Thu, 28 Aug 2025 17:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="S+WQdnQy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F5533472C;
	Thu, 28 Aug 2025 17:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756401288; cv=none; b=u0Gm2WsAXXV8E/hpGhzt4thO98U48fKFpUZMH90IChD2BGMmPmdb2O0jhHkl6rNSGWIHRhLe++UaxCkzfN3kG0MDKScq1rWD0A9T28KLOra2DlyZ0SCwGm3tvXO++nLsgD2rK+KIRxpVDdENmSNAc3qB2BSpYpRZB+0EMdc9Rww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756401288; c=relaxed/simple;
	bh=MgagqO04WNpGnv0g/dC0qVqo90USVfsxVor7K5+LQuI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IdfK/65YwEFzn94TZpAp6Vz/kedd9sIpkaPGZsnKkorRMLsTgQkTfeAM2IJpF6cW3By5bLyxxIHqDZcsJenOXnK3Wko0vigFZjtU7qi7NmmQ12fmhBytUQiFlc+8upbVgIoMiTsQXMMC41v483HOdNkfVB5PONvST5gjZEn+PbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=S+WQdnQy; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756401276; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=VtPnvvvsuIuz+8aE9dOMXXrNjYoyMry3R9OySyeN1ks=;
	b=S+WQdnQyBkEDIowKVqEc0u3ZTTNICR1I367XsuFBvS37Tz7KaUmjUfkFwGeKzClviRfPfrAoI/5a00CnwQ8Plv1kiL3fk6XWszlF03PsmD/8ezn+ZbQN3gbzveLCU8juIvWjUbOm6kbotK2vcqt1J8uoE/PcUwmzP/Sr9zhf5bU=
Received: from 30.180.0.242(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wmnpluh_1756401274 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 29 Aug 2025 01:14:36 +0800
Message-ID: <79315382-5ba8-42c1-ad03-5cb448b23b72@linux.alibaba.com>
Date: Fri, 29 Aug 2025 01:14:34 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] initrd: support erofs as initrd
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Askar Safin <safinaskar@zohomail.com>
Cc: Byron Stanoszek <gandalf@winds.org>, Christoph Hellwig <hch@lst.de>,
 gregkh <gregkh@linuxfoundation.org>,
 "julian.stecklina" <julian.stecklina@cyberus-technology.de>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, rafael <rafael@kernel.org>,
 torvalds <torvalds@linux-foundation.org>, viro <viro@zeniv.linux.org.uk>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Christian Brauner <brauner@kernel.org>
References: <20250321050114.GC1831@lst.de>
 <20250825182713.2469206-1-safinaskar@zohomail.com>
 <20250826075910.GA22903@lst.de>
 <a54ced51-280e-cc9d-38e4-5b592dd9e77b@winds.org>
 <6b77eda9-142e-44fa-9986-77ac0ed5382f@linux.alibaba.com>
 <198ead62fff.fc7d206346787.2754614060206901867@zohomail.com>
 <d820951e-f5df-4ddb-a657-5f0cc7c3493a@linux.alibaba.com>
 <81788d65-968a-4225-ba1b-8ede4deb0f61@linux.alibaba.com>
 <198f1915a27.10415eef562419.6441525173245870022@zohomail.com>
 <18d15255-2a6f-4fe8-bbf7-c4e5cc51692c@linux.alibaba.com>
In-Reply-To: <18d15255-2a6f-4fe8-bbf7-c4e5cc51692c@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/8/29 01:00, Gao Xiang wrote:
> 
> 
> On 2025/8/29 00:44, Askar Safin wrote:
>>   ---- On Wed, 27 Aug 2025 13:58:02 +0400  Gao Xiang <hsiangkao@linux.alibaba.com> wrote ---
>>   > The additional cpio extraction destroys bit-for-bit identical data
>>   > protection, or some other new verification approach is needed for
>>   > initramfs tmpfs.
>>
>> Put erofs to initramfs and sign whole thing.
>>
>> Also: initramfs's are concatenatable.
>> So, you can put erofs to cpio and sign the result.
>> And then concatenate that cpio with another cpio (with init).
>>
>> Also, you can put erofs to cpio, then sign this thing, and then add init to kernel
>> built-in cpio (via INITRAMFS_SOURCE).
> 
> Which part of the running system check the cpio signature.

Anyway, built-in cpio may resolve the issue (honestly, I've never tried
this feature), but I'm not sure all users would like to use this way to
bind the customized `init` to the kernel.

Again, I don't have any strong opinion to kill initrd entirely because
I think initdax may be more efficient and I don't have any time to work
on this part -- it's unrelated to my job.

Personally I just don't understand why cpio stands out considering it
even the format itself doesn't support xattrs and more.

Thanks,
Gao Xiang

> 
> Why users need some cpio format (which even cannot be random accessed)
> since it already contains a real filesystem, also which part check the
> signature of `init` itself before `init` runs?  IOWs, why `init` in
> cpio can be trusted to run?
> 
> Why users need to extract the whole cpio to tmpfs just for some data
> part in the erofs? even some data is never used?
> 
> Why the initrd memory cannot be used directly as the dax filesystem
> instead of copying to tmpfs instead?
> 
> Thanks,
> Gao Xiang


