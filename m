Return-Path: <linux-fsdevel+bounces-74425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B56D3A33C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 10:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D276D3028182
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 09:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCE2350D4D;
	Mon, 19 Jan 2026 09:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SYZYz8yk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB1333A715;
	Mon, 19 Jan 2026 09:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768815526; cv=none; b=NVKBw+f5NXOGDjaEjWkW7PndWwVHQQ/ucKeDNDDF1Ngg/pja2Oh8MGEWZa2ECCrG8RpudwTPa5rtP8g9ikcCdXlauoU3wvmXVxgHrcyVBtn0qsO/C56AYZy92sv4Gp99puBB8pUFFBw/++H2oI07hzNEb/xmNMvr4WqnNP1boQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768815526; c=relaxed/simple;
	bh=11MEOq2zJaz5dwZnCNoXwb/naHUXamjo8XoNfPj8s4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uh2+5AmwMl7HoTXDBOY8rYDbrtO0K59ms8sz4hJKSQ//k+jphvFCQab0z8Ma+j1woC7q58Xhulfdr+Wc9+Hx2Lj8+l+93rDcM5rVrcNKGPzXuaujh/mwhLY7XLR3n0a3Hi+KTY+RsO2HyF4y2YC2nMRzERQXHcz2h+9csT9Z7pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SYZYz8yk; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768815515; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=3oEwfAWlUHgA2grw4AAbMIJcUBA/9GSVEAaHUgNuOoo=;
	b=SYZYz8ykChzr21WI/IVCpD6ybwYPNHJ8eMZ7zpLXVZp/NwsYsrBIWFh5ArMmHl7p5J04azheO0sTL2pN3xSsPTTpZaKpKa5L6SKH8ig8SP1okB4anF7j3Z8Z4Z+GupnVBz893RTmPYqILOzAbB4DRE9eD1hkZbHshbtCCrF5G/k=
Received: from 30.221.131.184(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WxL7KIk_1768815513 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 19 Jan 2026 17:38:34 +0800
Message-ID: <73f2c243-e029-4f95-aa8e-285c7affacac@linux.alibaba.com>
Date: Mon, 19 Jan 2026 17:38:33 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 5/9] erofs: introduce the page cache share feature
To: Christoph Hellwig <hch@lst.de>
Cc: Hongbo Li <lihongbo22@huawei.com>, chao@kernel.org, brauner@kernel.org,
 djwong@kernel.org, amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260116095550.627082-1-lihongbo22@huawei.com>
 <20260116095550.627082-6-lihongbo22@huawei.com>
 <20260116154623.GC21174@lst.de>
 <af1f3ff6-a163-4515-92bf-44c9cf6c92f3@linux.alibaba.com>
 <20260119072932.GB2562@lst.de>
 <8e30bc4b-c97f-4ab2-a7ce-27f399ae7462@linux.alibaba.com>
 <20260119083251.GA5257@lst.de>
 <b29b112e-5fe1-414b-9912-06dcd7d7d204@linux.alibaba.com>
 <20260119092220.GA9140@lst.de>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260119092220.GA9140@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/1/19 17:22, Christoph Hellwig wrote:
> On Mon, Jan 19, 2026 at 04:52:54PM +0800, Gao Xiang wrote:
>>> To me this sounds pretty scary, as we have code in the kernel's trust
>>> domain that heavily depends on arbitrary userspace policy decisions.
>>
>> For example, overlayfs metacopy can also points to
>> arbitary files, what's the difference between them?
>> https://docs.kernel.org/filesystems/overlayfs.html#metadata-only-copy-up
>>
>> By using metacopy, overlayfs can access arbitary files
>> as long as the metacopy has the pointer, so it should
>> be a priviledged stuff, which is similar to this feature.
> 
> Sounds scary too.  But overlayfs' job is to combine underlying files, so
> it is expected.  I think it's the mix of erofs being a disk based file

But you still could point to an arbitary page cache
if metacopy is used.

> system, and reaching out beyond the device(s) assigned to the file system
> instance that makes me feel rather uneasy.

You mean the page cache can be shared from other
filesystems even not backed by these devices/files?

I admitted yes, there could be different: but that
is why new mount options "inode_share" and the
"domain_id" mount option are used.

I think they should be regarded as a single super
filesystem if "domain_id" is the same: From the
security perspective much like subvolumes of
a single super filesystem.

And mounting a new filesystem within a "domain_id"
can be regard as importing data into the super
"domain_id" filesystem, and I think only trusted
data within the single domain can be mounted/shared.

> 
>>>
>>> Similarly the sharing of blocks between different file system
>>> instances opens a lot of questions about trust boundaries and life
>>> time rules.  I don't really have good answers, but writing up the
>>
>> Could you give more details about the these? Since you
>> raised the questions but I have no idea what the threats
>> really come from.
> 
> Right now by default we don't allow any unprivileged mounts.  Now
> if people thing that say erofs is safe enough and opt into that,
> it needs to be clear what the boundaries of that are.  For a file
> system limited to a single block device that boundaries are
> pretty clear.  For file systems reaching out to the entire system
> (or some kind of domain), the scope is much wider.

Why multiple device differ for an immutable fses, any
filesystem instance cannot change the primary or
external device/blobs. All data are immutable.

> 
>> As for the lifetime: The blob itself are immutable files,
>> what the lifetime rules means?
> 
> What happens if the blob gets removed, intentionally or accidentally?

The extra device/blob reference is held during
the whole mount lifetime, much like the primary
(block) device.

And EROFS is an immutable filesystem, so that
inner blocks within the blob won't be go away
by some fs instance too.

> 
>> And how do you define trust boundaries?  You mean users
>> have no right to access the data?
>>
>> I think it's similar: for blockdevice-based filesystems,
>> you mount the filesystem with a given source, and it
>> should have permission to the mounter.
> 
> Yes.
> 
>> For multiple-blob EROFS filesystems, you mount the
>> filesystem with multiple data sources, and the blockdevices
>> and/or backed files should have permission to the
>> mounters too.
> 
> And what prevents other from modifying them, or sneaking
> unexpected data including unexpected comparison blobs in?

I don't think it's difference from filesystems with single
device.

First, EROFS instances never modify any underlay
device/blobs:

If you say some other program modify the device data, yes,
it can be changed externally, but I think it's just like
trusted FUSE deamons, untrusted FUSE daemon can return
arbitary (meta)data at random times too.

Thanks,
Gao Xiang



