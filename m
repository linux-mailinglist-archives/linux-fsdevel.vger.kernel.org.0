Return-Path: <linux-fsdevel+bounces-73858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CFACDD220F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 02:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEECE3051E92
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 01:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E943424503C;
	Thu, 15 Jan 2026 01:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ehqTRoSO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5273B1373;
	Thu, 15 Jan 2026 01:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768441582; cv=none; b=ZGJXdYK3NpIo20ngnVP+7YZECZeyYqafzTPbOuC3GYiVALzvdWE9/vtRip6UMs7F9iAgrMqT/WAMxtcQ1d/so6DTEH+jDHwZskx3Mw0D9n4lIk+QWUPWFlekDE/0zETOFNk8JpqQoL5rlKHwBjZf5aw8kPmpihlq37O83sU04lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768441582; c=relaxed/simple;
	bh=uEekNr6DwGoKG4UXrbPc4eiLC4+JpSYcRJJWr2RxF6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jnriJR0I8v0q/sDKA1AcYsxGCS3SdR1jCmdzjV8vPxbE2TsiBSA6KRxXCAEw9Fxm8vwphl5962QtNBE8cijtYJ/xPFNz8VHNXQg2IOhsoyOoudeAsGP76Qc06OMYv0tspV5+GGfi09VtNnZze7HES9mKIpy7/DhEGZ6JTzOUtjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ehqTRoSO; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768441571; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=lA+iVxthBSSAwhyqVps17pUkMesnLzVESsOf8nBTCWg=;
	b=ehqTRoSOJqFnoZWJRsI9RhmjkrkgmWhdk6+p83zr8IGd85JXoHd7E8CgMEMb1c4FlZuhv8ApUgzukL8Nr+lr/KOiWsFfYA4A2Y9yC/fsVZOFHS5jPqICu6nqMw6MzEEyfRNbg83kMLv3eCQgM1p0js+LIbI/ZqGjjJ9qXUpV3Fk=
Received: from 30.221.132.28(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wx4lzf._1768441570 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 15 Jan 2026 09:46:11 +0800
Message-ID: <2cec78b5-671a-447f-abbe-2b77c1f5d0da@linux.alibaba.com>
Date: Thu, 15 Jan 2026 09:46:10 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 08/10] erofs: support unencoded inodes for page cache
 share
To: Hongbo Li <lihongbo22@huawei.com>
Cc: djwong@kernel.org, amir73il@gmail.com, hch@lst.de,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
 Christian Brauner <brauner@kernel.org>
References: <20260109102856.598531-1-lihongbo22@huawei.com>
 <20260109102856.598531-9-lihongbo22@huawei.com>
 <2d33cc2f-8188-4e62-b0be-bf985237bf24@linux.alibaba.com>
 <4152e93b-3f7d-4861-aad9-b7dc1ef71470@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <4152e93b-3f7d-4861-aad9-b7dc1ef71470@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026/1/15 09:36, Hongbo Li wrote:
> Hi,Xiang
> 
> On 2026/1/14 22:51, Gao Xiang wrote:
>>
>>
>> On 2026/1/9 18:28, Hongbo Li wrote:
>>> This patch adds inode page cache sharing functionality for unencoded
>>> files.
>>>
>>> I conducted experiments in the container environment. Below is the
> 
> ...
>>>               iomap->inline_data = ptr;
>>> @@ -383,11 +385,16 @@ static int erofs_read_folio(struct file *file, struct folio *folio)
>>>           .ops        = &iomap_bio_read_ops,
>>>           .cur_folio    = folio,
>>>       };
>>> -    struct erofs_iomap_iter_ctx iter_ctx = {};
>>> +    bool need_iput;
>>> +    struct erofs_iomap_iter_ctx iter_ctx = {
>>> +        .realinode = erofs_real_inode(folio_inode(folio), &need_iput),
>>> +    };
>>> -    trace_erofs_read_folio(folio, true);
>>> +    trace_erofs_read_folio(iter_ctx.realinode, folio, true);
>>>       iomap_read_folio(&erofs_iomap_ops, &read_ctx, &iter_ctx);
>>> +    if (need_iput)
>>> +        iput(iter_ctx.realinode);
>>>       return 0;
>>>   }
>>> @@ -397,12 +404,17 @@ static void erofs_readahead(struct readahead_control *rac)
>>>           .ops        = &iomap_bio_read_ops,
>>>           .rac        = rac,
>>>       };
>>> -    struct erofs_iomap_iter_ctx iter_ctx = {};
>>> +    bool need_iput;
>>> +    struct erofs_iomap_iter_ctx iter_ctx = {
>>> +        .realinode = erofs_real_inode(rac->mapping->host, &need_iput),
>>> +    };
>>> -    trace_erofs_readahead(rac->mapping->host, readahead_index(rac),
>>> +    trace_erofs_readahead(iter_ctx.realinode, readahead_index(rac),
>>>                       readahead_count(rac), true);
>>
>> Is it possible to add a commit to update the tracepoints
>> to add the new realinode first?
> 
> Yeah, so should we put the update on trace_erofs_read_folio and trace_erofs_readahead in a single patch after "[PATCH v14 03/10] fs: Export alloc_empty_backing_file"?

I think the tracepoint one should be just before this patch.

> 
>   Since the first two patches in this series has merged in vfs tree (thanks Christian), should we reorder the left patches?

I think you just send the new patchset version
in the future without the first two patches
in the version.

Thanks,
Gao Xiang

> 
> Thanks,
> Hongbo
> 

