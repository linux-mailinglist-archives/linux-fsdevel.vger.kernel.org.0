Return-Path: <linux-fsdevel+bounces-59291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DF5B36F2E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 18:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA34A7B1E9E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080843164C6;
	Tue, 26 Aug 2025 16:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nRaM+a3e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FB13148DA;
	Tue, 26 Aug 2025 16:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756224037; cv=none; b=WBJaZKgAdUZyu9ThqqUhTpkVIuZi52FpzbebY7iGydl3OcmTBsoL9siweygZCjuauwr3voYvr+bPEbt00q9hBlPqdI1Fl3XQu7UZpbbBbdNsC/aZ+FwFDdPc0WhKgEPlin0t8drQw1KcFViYWci1C6D3kEWGuCoNWRdSaDnsaUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756224037; c=relaxed/simple;
	bh=SW3Udsfg/kC1vWj+EXo2Gp1NsaIYKluIF/RACcf/+pM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qLe7CglQgrwkfyvP9DRkcKL8ZLVmTfd3UoRyskNKV9eF/bCxCQ3aCDW7zyHGlthny4VlcBNvEdmQ3d4ypu+TRnn74DrqyZkRnh4WNBQ/oE9RMCKGuQSIXJlEuW2ZPUaFOlRAd7vjhPzC4tPAJ5WNCviXuTMYTthmfIipj4G8uEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nRaM+a3e; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756224030; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=8FC3T6a7dTU/8hV5hjMfJEP0D2lUkVGYSknlTfcOP8w=;
	b=nRaM+a3eS0hFVsi+EuMrZbxGzULtN0JYRwUak5Spzp3vMvxzTEOPg3fYW+GcA+nPQKHhbqJND3EPFiotjzX9XyJxNAlleeqvSpBzYRHBQ4G7fsfK343sf0R62b7MH5w/MfFWvh+1VGIBdhjh/z21ONR+Qs9E/3xB5/qZTwbzlk0=
Received: from 30.180.0.242(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WmfRBhu_1756224028 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 27 Aug 2025 00:00:30 +0800
Message-ID: <9f8bf7f7-3194-4b54-a164-65cbbb261c19@linux.alibaba.com>
Date: Wed, 27 Aug 2025 00:00:28 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] initrd: support erofs as initrd
From: Gao Xiang <hsiangkao@linux.alibaba.com>
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
 <6b77eda9-142e-44fa-9986-77ac0ed5382f@linux.alibaba.com>
In-Reply-To: <6b77eda9-142e-44fa-9986-77ac0ed5382f@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/8/26 23:32, Gao Xiang wrote:
> 
> 
> On 2025/8/26 22:21, Byron Stanoszek wrote:
>> On Tue, 26 Aug 2025, Christoph Hellwig wrote:
>>
>>> On Mon, Aug 25, 2025 at 09:27:13PM +0300, Askar Safin wrote:
>>>>> We've been trying to kill off initrd in favor of initramfs for about
>>>>> two decades.  I don't think adding new file system support to it is
>>>>> helpful.
>>>>
>>>> I totally agree.
>>>>
>>>> What prevents us from removing initrd right now?
>>>>
>>>> The only reason is lack of volunteers?
>>>>
>>>> If yes, then may I remove initrd?
>>>
>>> Give it a spin and see if anyone shouts.
>>
>> Well, this makes me a little sad. I run several hundred embedded systems out in
>> the world, and I use a combination of initrd and initramfs for booting. These
>> systems operate entirely in ramdisk form.
>>
>> I concatenate a very large .sqfs file onto the end of "vmlinuz", which gets
>> loaded into initrd automatically by the bootloader. Then in my initramfs (cpio
>> archive that's compiled in with the kernel), my /sbin/init executable copies
>> /initrd.image to /dev/ram0, mounts a tmpfs overlay on top of it, then does a
>> pivot root to it.
>>
>> This gives it the appearance of a read-write initramfs filesystem, but the
>> lower layer data remains compressed in RAM. This saves quite a bit of RAM
>> during runtime, which is still yet important on older PCs.
>>
>> If there's a better (more official) way of having a real compressed initramfs
>> that remains compressed during runtime, I'm all for it. But until then, I would
>> like to ask you to please not remove the initrd functionality.
>>
>> (In fact, I was actually thinking about trying this method with erofs as the
>> lower layer filesystem someday soon instead of squashfs. But I would still be
>> using an overlay to mount it, instead of the auto-detect method addressed by
>> this patch.)
> 
> Something a bit out of the topic, to quota the previous reply from
> Christiph:
> 
>> There is no reason to fake up a block device, just have a version
>> of erofs that directly points to pre-loaded kernel memory instead. 
> 
> I completely agree with that point. However, since EROFS is a
> block-based filesystem (Thanks to strictly block alignment, meta(data)
> can work efficiently on both block-addressed storage
> devices and byte-addressed memory devices. Also if the fsblock size
> is set as the page size, the page cache itself can also be avoided
> for plain inodes), I think even pre-loaded kernel memory is used,
> a unified set of block-based kAPIs to access different backends
> (e.g., block devices, kernel memory, etc.) is useful for block-based
> filesystems instead of developing another dax_direct_access() path
> just as pmem-specialized filesystems.
> 
> In short, in my opinion, the current bio interfaces fit the
> requirements well for various storage for block-based filesystems.

refine a bit: for data/metadata direct access, dax_direct_access()
and page cache apis are simple and efficient enough, but if on-disk
(meta)data needs to be transformed ((de)compressed or {en,de}crypted),
a unified bio interface is simplier than working on these individual
storage.

> 
> As for EROFS initrd support, I've seen several requests on this,
> although I think the interesting point is data integrity and
> security since the golden image can be easier protected compared to
> tmpfs-based initramfs. It is just my own opinion though, if initrd
> survives in the foresee future, I do hope initrd could be an
> intermediate solution to initdax support since it just needs a few
> line of changes, but if initrd removes soon, just forget what I said.
> 
> Thanks,
> Gao Xiang
> 
>>
>> Thank you,
>>   -Byron
> 


