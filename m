Return-Path: <linux-fsdevel+bounces-66541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED58C22E8F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 02:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D20C3ACCB2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 01:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B940B25EFBB;
	Fri, 31 Oct 2025 01:47:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9330AF9EC;
	Fri, 31 Oct 2025 01:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761875271; cv=none; b=nNlMc3nEwt7mP2vkwdWX44kdLKRig7UE2bQ5MfUhZhSApTZtwPN6nuzwfdeSx+BMWiiBf2E3t5SjS/5ivhy23V4e6egBQsoxjB3l3xksu8q1m/rE2TRoF96I6WTWrygiBgfkacgBGDO+vm+v5XQ7/zOumF0gvVBYLRB8668LPiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761875271; c=relaxed/simple;
	bh=RMfWNxPNBNw9I+ZX3djWGVD3yE77SQDtOZv505GvMAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IBwkJeFt5nWS95YqpVsHzrm3/uL/SbjjL00QJaixKhvJ55b/fvpAYDfkISL0hOvQJPPNImcJaima59DDmWpEoxsCHl1GYUflAWlv3YsUd7rOmP7nqaTTug8A4zXb3Y7E9Q+Nckrj5Z/dF4HaibB4l/5zYNGuBJORD/tbsZwFe8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cyP4V2LvBzYQtgj;
	Fri, 31 Oct 2025 09:47:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id ED83A1A0359;
	Fri, 31 Oct 2025 09:47:45 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP2 (Coremail) with SMTP id Syh0CgBnCEE_FQRp1gDACA--.16157S3;
	Fri, 31 Oct 2025 09:47:45 +0800 (CST)
Message-ID: <1901ccda-bed8-4f83-a959-7a6acccf2754@huaweicloud.com>
Date: Fri, 31 Oct 2025 09:47:43 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/25] fs/buffer: prevent WARN_ON in
 __alloc_pages_slowpath() when BS > PS
To: Matthew Wilcox <willy@infradead.org>, Baokun Li <libaokun@huaweicloud.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-ext4@vger.kernel.org,
 tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
 linux-kernel@vger.kernel.org, kernel@pankajraghav.com, mcgrof@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com, libaokun1@huawei.com
References: <20251025032221.2905818-1-libaokun@huaweicloud.com>
 <20251025032221.2905818-23-libaokun@huaweicloud.com>
 <aPxV6QnXu-OufSDH@casper.infradead.org>
 <adccaa99-ffbc-4fbf-9210-47932724c184@huaweicloud.com>
 <aQPX1-XWQjKaMTZB@casper.infradead.org>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <aQPX1-XWQjKaMTZB@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBnCEE_FQRp1gDACA--.16157S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr45Zr47ZrWkXFy5Kr4fGrg_yoW8trWfpa
	ySkF1jkrWkAryru3Z7Cr1xtFyftaykWF48GFyFq34UCF15JryF9F43t3ZY9Fy7Cr4xu3W2
	qFW8A34Durn8AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

Hi!

On 10/31/2025 5:25 AM, Matthew Wilcox wrote:
> On Sat, Oct 25, 2025 at 02:32:45PM +0800, Baokun Li wrote:
>> On 2025-10-25 12:45, Matthew Wilcox wrote:
>>> No, absolutely not.  We're not having open-coded GFP_NOFAIL semantics.
>>> The right way forward is for ext4 to use iomap, not for buffer heads
>>> to support large block sizes.
>>
>> ext4 only calls getblk_unmovable or __getblk when reading critical
>> metadata. Both of these functions set __GFP_NOFAIL to ensure that
>> metadata reads do not fail due to memory pressure.
>>
>> Both functions eventually call grow_dev_folio(), which is why we
>> handle the __GFP_NOFAIL logic there. xfs_buf_alloc_backing_mem()
>> has similar logic, but XFS manages its own metadata, allowing it
>> to use vmalloc for memory allocation.
> 
> In today's ext4 call, we discussed various options:
> 
> 1. Change folios to be potentially fragmented.  This change would be
> ridiculously large and nobody thinks this is a good idea.  Included here
> for completeness.
> 
> 2. Separate the buffer cache from the page cache again.  They were
> unified about 25 years ago, and this also feels like a very big job.
> 
> 3. Duplicate the buffer cache into ext4/jbd2, remove the functionality
> not needed and make _this_ version of the buffer cache allocate
> its own memory instead of aliasing into the page cache.  More feasible
> than 1 or 2; still quite a big job.
> 
> 4. Pick up Catherine's work and make ext4/jbd2 use it.  Seems to be
> about an equivalent amount of work to option 3.
> 

Regarding these two proposals, would you consider them for the long
term? Besides the currently discussed case, they offer additional
benefits, such as making ext4's metadata management more flexible and
secure, as well as enabling more robust error handling.

Thanks,
Yi.

> 5. Make __GFP_NOFAIL work for allocations up to 64KiB (we decided this was
> probably the practical limit of sector sizes that people actually want).
> In terms of programming, it's a one-line change.  But we need to sell
> this change to the MM people.  I think it's doable because if we have
> a filesystem with 64KiB sectors, there will be many clean folios in the
> pagecache which are 64KiB or larger.
> 
> So, we liked option 5 best.
> 


