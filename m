Return-Path: <linux-fsdevel+bounces-59515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B1AB3A736
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 19:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DEB2563DB6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 17:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674B4334708;
	Thu, 28 Aug 2025 17:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mznaX4SE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740D8334722;
	Thu, 28 Aug 2025 17:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756400447; cv=none; b=Fr9OceDBaIsvGr/t6cuBJTTznMgVI6SVxyJR1wsIUag4mr/Mm6+TqTqoKgk/+MFbR43dCtBcxTmZ9p9rs1fkTnccwDlTFz53aSFLTgOCqri/GHRCeykFkqHHrG5iXkPgv4mbQpR0CE4/dj+VkMpmLfXv75G+Icr1Tls12D4bSMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756400447; c=relaxed/simple;
	bh=vIV9vNLPtSJyjkOOHRO0Msdz09leXrDWSKaguyPFRGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nRqA5PKWe/2KC23nKqcVHNptqAqFOk9fuhptQp2KAirJE50k06asyzUmfRQwG08mI/iS/780KA8/7153XOaikW1YNc3rFkAQsPmY2uoiOr5V3z0O/wOzeWj41Vjz/q2/yzr2IStRefIIVojcJhQ2/fx2NSklefl4nipdI2vVzDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mznaX4SE; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756400442; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=aiFCRU9LXSY/bIWty4OaiEhlX2pdz7wrUkGjuGECjr8=;
	b=mznaX4SETjtX0X8g5D2jNEuyaGH5/JI+ccpmSvHoQWGIrMZM//PkvawsrnAUsDDAml/O+dadMQScgyRs9QyTm+Uhb5/nhOUu4gihItEuBdPngAOtTvDma1TU5dfl7anMjkGux3H+XpM/hymsh8x6782PibF8WFGIqlAtwd+w5EM=
Received: from 30.180.0.242(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wmnvh9S_1756400440 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 29 Aug 2025 01:00:41 +0800
Message-ID: <18d15255-2a6f-4fe8-bbf7-c4e5cc51692c@linux.alibaba.com>
Date: Fri, 29 Aug 2025 01:00:39 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] initrd: support erofs as initrd
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
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <198f1915a27.10415eef562419.6441525173245870022@zohomail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/8/29 00:44, Askar Safin wrote:
>   ---- On Wed, 27 Aug 2025 13:58:02 +0400  Gao Xiang <hsiangkao@linux.alibaba.com> wrote ---
>   > The additional cpio extraction destroys bit-for-bit identical data
>   > protection, or some other new verification approach is needed for
>   > initramfs tmpfs.
> 
> Put erofs to initramfs and sign whole thing.
> 
> Also: initramfs's are concatenatable.
> So, you can put erofs to cpio and sign the result.
> And then concatenate that cpio with another cpio (with init).
> 
> Also, you can put erofs to cpio, then sign this thing, and then add init to kernel
> built-in cpio (via INITRAMFS_SOURCE).

Which part of the running system check the cpio signature.

Why users need some cpio format (which even cannot be random accessed)
since it already contains a real filesystem, also which part check the
signature of `init` itself before `init` runs?  IOWs, why `init` in
cpio can be trusted to run?

Why users need to extract the whole cpio to tmpfs just for some data
part in the erofs? even some data is never used?

Why the initrd memory cannot be used directly as the dax filesystem
instead of copying to tmpfs instead?

Thanks,
Gao Xiang

