Return-Path: <linux-fsdevel+bounces-59352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4B8B37F2D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 11:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B295F7A272A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 09:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE412D2485;
	Wed, 27 Aug 2025 09:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CYbXcZK5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB238F48;
	Wed, 27 Aug 2025 09:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756288102; cv=none; b=e4tmmV3uGEhwYrMknbAbUF3c3xmAtY4FaIdfr6R+PG9GtSSyleAd8Qa3MzEjw0E0HOYIUIIqSrgruNNMvF5HDbKxWLPwcNcuS4cM25Ktd89U7MsOm89epf1A/Yw7uWM/euR68svxsPqM/AGFLCVI6ivt+U6DUHBBqczNlD6cI7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756288102; c=relaxed/simple;
	bh=+w2RGnieQf6fF7AYdvNbK7tdl8lTwQYl3t6wdcQBQVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SNplj3Q33KETfE5xROgqhD48YWQpaJ+s8ZwcfC3BBeop49hsAR/n3A3LM0gZc5NdbxxaOR1BFYKCFtVCYTYE10Imgv0mM6Y+4aqTiYkDd8sRhvsuono3BGsjlbIJiU13f/KJhhvas0PPR3+p5D17E9wtBBcRAC3phiEThztSbyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CYbXcZK5; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756288089; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=yI9aY3kCrwJbkAALJF4/YaEOmckx3mMDHOyqA2RjXOY=;
	b=CYbXcZK5+EOEXc180ee1iIQ6SP0fuw89NwPqXZdSGWKIT0jHHmEgChdxrgREHK+/q2XhCIPdfs6BTxchCxch3siaRXiJZlfUFm0wP5hzvK5TOPn+UsumFND6ciM3xmiS45mSulbD9/jKDNaJSYeOTJ50fo+UP70HbAXhKguuTQU=
Received: from 30.221.131.253(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WmicQLC_1756288088 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 27 Aug 2025 17:48:08 +0800
Message-ID: <d820951e-f5df-4ddb-a657-5f0cc7c3493a@linux.alibaba.com>
Date: Wed, 27 Aug 2025 17:48:07 +0800
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
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <198ead62fff.fc7d206346787.2754614060206901867@zohomail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/8/27 17:22, Askar Safin wrote:
>   ---- On Tue, 26 Aug 2025 19:32:34 +0400  Gao Xiang <hsiangkao@linux.alibaba.com> wrote ---
>   > I completely agree with that point. However, since EROFS is a
>   > block-based filesystem (Thanks to strictly block alignment, meta(data)
>   > can work efficiently on both block-addressed storage
>   > devices and byte-addressed memory devices. Also if the fsblock size
> 
> As I said previously, just put your erofs image to initramfs
> (or to disk) and then (in your initramfs init) create ramdisk out of it
> or loop mount it (both ramdisks and loop devices are block devices).
> 
> This way you will have erofs on top of block device.
> 
> And you will not depend on initrd. (Again: I plan to remove initial ramdisk
> support, not ramdisk support per se.)

It doesn't work if end users put `init` into erofs image and sign
the whole erofs initram images with their certifications.

And it doesn't have any relationship with cpio because users need
signed image and load from memory.

Thanks,
Gao Xiang

