Return-Path: <linux-fsdevel+bounces-74430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32171D3A3E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 10:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E63C3079AF2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 09:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814F33382FA;
	Mon, 19 Jan 2026 09:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DKIExsoJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA06C305057;
	Mon, 19 Jan 2026 09:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768816420; cv=none; b=QdlsAqipSxPWNbanjsjB2ryEi/FKsLWeiXnfTzp3WTPCTkXnsxvSviubAnLRr3PG5eGV3t885IoVudSayElwx4FmPDKJCsagUhtBE0vEgBHQFDX+a64S4w29Z5vKG10mzFpj+wPyArVFRV7zeraSZfMcsFKTdYx7hUBTXKWROE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768816420; c=relaxed/simple;
	bh=DRaYzP9m7YLoBNmjoiVGSo/Qk1cxoFKlI5nWDutxq3Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EfqBDaWiMROFJmDjmjKSJA8aiHeOwrWfeQAZeqQxDiMBVHfJBk6A8GZDAljW0ZdMkPcrvSIc9+sxqFw9I0NVHUfh4RD8eSsgpWxme3y7JUSVkNvFgv2e3+yq3IHo9X682XIon4Twy0+xvY4e4sWLgfCS/LKKT/0vB0+QTGJS1eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DKIExsoJ; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768816414; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=hPPrNXHoXR8mRzEfeDQGV5JB64ifiuGfpPhzFKE3cxU=;
	b=DKIExsoJ5v1/gmxgvItZfE10IZVL49yPodZ+XmkXPyuD+4nYeAvPQul02OCw3oEuw7tj0G6Bx2wCUftxpdxN/PgJhpT8sC97t0iQKnj3I62QPqtBSevNpZdnRtG6lNFRxkhAZQEhE3oVgWElVUIbWwkw+DvnmABFjsb+q9zGpSA=
Received: from 30.221.131.184(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WxLJyuZ_1768816384 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 19 Jan 2026 17:53:33 +0800
Message-ID: <033806bc-c91a-4ff4-8df3-f414bd0bf264@linux.alibaba.com>
Date: Mon, 19 Jan 2026 17:53:33 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 5/9] erofs: introduce the page cache share feature
From: Gao Xiang <hsiangkao@linux.alibaba.com>
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
 <73f2c243-e029-4f95-aa8e-285c7affacac@linux.alibaba.com>
In-Reply-To: <73f2c243-e029-4f95-aa8e-285c7affacac@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026/1/19 17:38, Gao Xiang wrote:
> 
> 
> On 2026/1/19 17:22, Christoph Hellwig wrote:
>> On Mon, Jan 19, 2026 at 04:52:54PM +0800, Gao Xiang wrote:
>>>> To me this sounds pretty scary, as we have code in the kernel's trust
>>>> domain that heavily depends on arbitrary userspace policy decisions.
>>>
>>> For example, overlayfs metacopy can also points to
>>> arbitary files, what's the difference between them?
>>> https://docs.kernel.org/filesystems/overlayfs.html#metadata-only-copy-up
>>>
>>> By using metacopy, overlayfs can access arbitary files
>>> as long as the metacopy has the pointer, so it should
>>> be a priviledged stuff, which is similar to this feature.
>>
>> Sounds scary too.  But overlayfs' job is to combine underlying files, so
>> it is expected.  I think it's the mix of erofs being a disk based file
> 
> But you still could point to an arbitary page cache
> if metacopy is used.
> 
>> system, and reaching out beyond the device(s) assigned to the file system
>> instance that makes me feel rather uneasy.
> 
> You mean the page cache can be shared from other
> filesystems even not backed by these devices/files?
> 
> I admitted yes, there could be different: but that
> is why new mount options "inode_share" and the
> "domain_id" mount option are used.
> 
> I think they should be regarded as a single super
> filesystem if "domain_id" is the same: From the
> security perspective much like subvolumes of
> a single super filesystem.
> 
> And mounting a new filesystem within a "domain_id"
> can be regard as importing data into the super
> "domain_id" filesystem, and I think only trusted
> data within the single domain can be mounted/shared.
> 
>>
>>>>
>>>> Similarly the sharing of blocks between different file system
>>>> instances opens a lot of questions about trust boundaries and life
>>>> time rules.  I don't really have good answers, but writing up the
>>>
>>> Could you give more details about the these? Since you
>>> raised the questions but I have no idea what the threats
>>> really come from.
>>
>> Right now by default we don't allow any unprivileged mounts.  Now
>> if people thing that say erofs is safe enough and opt into that,
>> it needs to be clear what the boundaries of that are.  For a file
>> system limited to a single block device that boundaries are
>> pretty clear.  For file systems reaching out to the entire system
>> (or some kind of domain), the scope is much wider.

btw, I think it's indeed to be helpful to get the boundaries (even
from on-disk formats and runtime features).

But I have to clarify that a single EROFS filesystem instance won'
have access to random block device or files.

The backing device or files are specified by users explicitly when
mounting, like:

  mount -odevice=blob1,device=blob2,...,device=blobn-1 blob0 mnt

And these devices / files will be opened when mounting at once,
no more than that.

May I ask the difference between one device/file and a group of
given devices/files? Especially for immutable usage.

Thanks,
Gao Xiang

