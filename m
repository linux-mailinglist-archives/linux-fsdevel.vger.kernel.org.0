Return-Path: <linux-fsdevel+bounces-59354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51478B37F68
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 11:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2243E204E44
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 09:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37BE30ACF1;
	Wed, 27 Aug 2025 09:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tKboMPw4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893B327B337;
	Wed, 27 Aug 2025 09:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756288696; cv=none; b=AQ+ELplhFuaB9znyd5/AoOk7geKxXqH8sqIc3vkLomsPBOKtmeMF6bL3qV/ebr3fMGJgZZKHg3PbXe82ujl2SZOTVwex7iB26gGZ5YDl5sR0Hwn8lVFQiou7EMyejfYWywjyCc9xP3y8hHg8MvjrEcassDUp2r+Z8vJDcOPEkwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756288696; c=relaxed/simple;
	bh=/Ir3rFh00106bX4RF58/hFmZNAZqe4EjsVSxf8bFFZ0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nY6DKBnVpx7Yemi40HTu1NohkLwuwf79pdt1zaaed2+FFNTJjNX+2EDUF7oFc3tBi/bfCsawWo8/i35unU+LZvoDMf1sNDHCbgq0f2YaDBxcxfY/1fbW8SjyYiWXTAWsOaTmdRqubLHms8+sA9kTTqBp761vKtCcqiJEfPA6PEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tKboMPw4; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756288684; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=f5I6oWDR0PQgRWnuoQy+/ziRBVt2cA+qqfHQvEueHu0=;
	b=tKboMPw4FT9MkMaEBa1TVrd/w7qdc7VwSYx3mm1LHsAjytEpXAffwmmJuTqT2Op3zNgeco2FrStmudYjp44VXwmXMrB1l/3So1jf/Hxtk8V4sZe+tA5cIp6Ymg6d9uRwU+UmzfEbgBf6f/bYw1VG03xXGLr7V2phQDmwctBK1vw=
Received: from 30.221.131.253(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WmicTMP_1756288682 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 27 Aug 2025 17:58:03 +0800
Message-ID: <81788d65-968a-4225-ba1b-8ede4deb0f61@linux.alibaba.com>
Date: Wed, 27 Aug 2025 17:58:02 +0800
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
In-Reply-To: <d820951e-f5df-4ddb-a657-5f0cc7c3493a@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/8/27 17:48, Gao Xiang wrote:
> 
> 
> On 2025/8/27 17:22, Askar Safin wrote:
>>   ---- On Tue, 26 Aug 2025 19:32:34 +0400  Gao Xiang <hsiangkao@linux.alibaba.com> wrote ---
>>   > I completely agree with that point. However, since EROFS is a
>>   > block-based filesystem (Thanks to strictly block alignment, meta(data)
>>   > can work efficiently on both block-addressed storage
>>   > devices and byte-addressed memory devices. Also if the fsblock size
>>
>> As I said previously, just put your erofs image to initramfs
>> (or to disk) and then (in your initramfs init) create ramdisk out of it
>> or loop mount it (both ramdisks and loop devices are block devices).
>>
>> This way you will have erofs on top of block device.
>>
>> And you will not depend on initrd. (Again: I plan to remove initial ramdisk
>> support, not ramdisk support per se.)
> 
> It doesn't work if end users put `init` into erofs image and sign
> the whole erofs initram images with their certifications.
> 
> And it doesn't have any relationship with cpio because users need
> signed image and load from memory.

Again, I don't think initramfs is the same concept as a golden
signed initramdisk, and cpio doesn't support those advanced usage.

The additional cpio extraction destroys bit-for-bit identical data
protection, or some other new verification approach is needed for
initramfs tmpfs.

Thanks,
Gao Xiang

> 
> Thanks,
> Gao Xiang


