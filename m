Return-Path: <linux-fsdevel+bounces-59232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FF0B36DDE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62E401BA7AFB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D452C08DB;
	Tue, 26 Aug 2025 15:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sAn04JiM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6FA26AA91;
	Tue, 26 Aug 2025 15:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222363; cv=none; b=g24R/Ry7FIjbHC4vfG4u5gsnVCHmGuFGfbCp7cUzPJkRXXHWdcQNNp5jzwrMu7buefvQ+XxG/wqiPc89o22W6tRmvN74dDsJq/Fw3/gZU32Pt8dT9pZ4qMXpBUguSET9+1DJ9Bxb8/4fnkEPxmy+kROIwfpzkHlYxrNBM1g/Fco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222363; c=relaxed/simple;
	bh=fC/nU8xaHnvz/PM0mJ+jVeESy5vuXAWVaUN73A7maf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bU1bAi++tdmTiha0N89OzrG6eK82cmDobnAyct8X5Ox1EW01j9ss5pJaZnW5RovzK2TL32ZMJ8o6cuFAZjY+myWDbpsBxQ/QacRYaC/ce8uquJ8uBLsuDAEFsEFkpG7eB3JWE9WDK/iEQ3hTiCorDOICVzZT+PCPrrQY/sDf7as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sAn04JiM; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756222356; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=4rpybjtb9ce5ONtY50XV5BaMBLLQm41wjVK301PYaWw=;
	b=sAn04JiMcFcAJU302fp1tYNf5+X7n5CZ0ld++AdEM8XmqVIBtenTpUoDeytB4a0JAMGi7r9Rwzf3/esn9CuscoZTLXqpbLGYhFHqbdXxOLY70ndPpGS2eGTk/Y6+kW5swxHJNx2oeju6Os5ZgXsXe3P0Pdg/jcvsdVAVJh0sago=
Received: from 30.180.0.242(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WmfIcd9_1756222355 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 26 Aug 2025 23:32:36 +0800
Message-ID: <6b77eda9-142e-44fa-9986-77ac0ed5382f@linux.alibaba.com>
Date: Tue, 26 Aug 2025 23:32:34 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] initrd: support erofs as initrd
To: Byron Stanoszek <gandalf@winds.org>, Christoph Hellwig <hch@lst.de>
Cc: gregkh@linuxfoundation.org, julian.stecklina@cyberus-technology.de,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 rafael@kernel.org, torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Christian Brauner <brauner@kernel.org>, Askar Safin <safinaskar@zohomail.com>
References: <20250321050114.GC1831@lst.de>
 <20250825182713.2469206-1-safinaskar@zohomail.com>
 <20250826075910.GA22903@lst.de>
 <a54ced51-280e-cc9d-38e4-5b592dd9e77b@winds.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <a54ced51-280e-cc9d-38e4-5b592dd9e77b@winds.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/8/26 22:21, Byron Stanoszek wrote:
> On Tue, 26 Aug 2025, Christoph Hellwig wrote:
> 
>> On Mon, Aug 25, 2025 at 09:27:13PM +0300, Askar Safin wrote:
>>>> We've been trying to kill off initrd in favor of initramfs for about
>>>> two decades.  I don't think adding new file system support to it is
>>>> helpful.
>>>
>>> I totally agree.
>>>
>>> What prevents us from removing initrd right now?
>>>
>>> The only reason is lack of volunteers?
>>>
>>> If yes, then may I remove initrd?
>>
>> Give it a spin and see if anyone shouts.
> 
> Well, this makes me a little sad. I run several hundred embedded systems out in
> the world, and I use a combination of initrd and initramfs for booting. These
> systems operate entirely in ramdisk form.
> 
> I concatenate a very large .sqfs file onto the end of "vmlinuz", which gets
> loaded into initrd automatically by the bootloader. Then in my initramfs (cpio
> archive that's compiled in with the kernel), my /sbin/init executable copies
> /initrd.image to /dev/ram0, mounts a tmpfs overlay on top of it, then does a
> pivot root to it.
> 
> This gives it the appearance of a read-write initramfs filesystem, but the
> lower layer data remains compressed in RAM. This saves quite a bit of RAM
> during runtime, which is still yet important on older PCs.
> 
> If there's a better (more official) way of having a real compressed initramfs
> that remains compressed during runtime, I'm all for it. But until then, I would
> like to ask you to please not remove the initrd functionality.
> 
> (In fact, I was actually thinking about trying this method with erofs as the
> lower layer filesystem someday soon instead of squashfs. But I would still be
> using an overlay to mount it, instead of the auto-detect method addressed by
> this patch.)

Something a bit out of the topic, to quota the previous reply from
Christiph:

> There is no reason to fake up a block device, just have a version
> of erofs that directly points to pre-loaded kernel memory instead. 

I completely agree with that point. However, since EROFS is a
block-based filesystem (Thanks to strictly block alignment, meta(data)
can work efficiently on both block-addressed storage
devices and byte-addressed memory devices. Also if the fsblock size
is set as the page size, the page cache itself can also be avoided
for plain inodes), I think even pre-loaded kernel memory is used,
a unified set of block-based kAPIs to access different backends
(e.g., block devices, kernel memory, etc.) is useful for block-based
filesystems instead of developing another dax_direct_access() path
just as pmem-specialized filesystems.

In short, in my opinion, the current bio interfaces fit the
requirements well for various storage for block-based filesystems.

As for EROFS initrd support, I've seen several requests on this,
although I think the interesting point is data integrity and
security since the golden image can be easier protected compared to
tmpfs-based initramfs. It is just my own opinion though, if initrd
survives in the foresee future, I do hope initrd could be an
intermediate solution to initdax support since it just needs a few
line of changes, but if initrd removes soon, just forget what I said.

Thanks,
Gao Xiang

> 
> Thank you,
>   -Byron


