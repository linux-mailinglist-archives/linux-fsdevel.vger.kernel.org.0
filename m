Return-Path: <linux-fsdevel+bounces-18833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCC68BCEB4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 15:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFBAC282927
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 13:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B175763F0;
	Mon,  6 May 2024 13:05:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5B644C66;
	Mon,  6 May 2024 13:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715000732; cv=none; b=rIGRcKfNEHVT2ridJiTzJcvCrruAObbh+uDEMnwWCzP/uerbnlIFxlFCxemF352itBrG23fFCDKsBT4u6/lkQ2J0G4yJXrS1sSRSGmBPsR8nH5nbDB8TJSgVY6XJ/sZzlx/iFGobswHQVC/kkntce9jHiiCQtJeYZ739s11Xvvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715000732; c=relaxed/simple;
	bh=o/sXgNc3t4AhEHZQzACRVWndIPoft8f4vqB8PGglIIo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MaSh/EytpS1MUuZ7I5L+h84RV0eMnIldDzu6OB8PmbvnlkR6qUYGzsSCoCiixCLfl+RHLVNcRAoDSRy/9ZYELugyHedNwABglla1RS2+/RZUucRV7PN2h79SaHr455ydDqe9j5XwesPTf+uwogOzjac9ZaIn9PwvnySM5lqsZaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VY1q04Xwqz4f3jd5;
	Mon,  6 May 2024 21:05:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id CBBD31A0572;
	Mon,  6 May 2024 21:05:24 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgAnmAuS1ThmXifRMA--.45497S3;
	Mon, 06 May 2024 21:05:24 +0800 (CST)
Subject: Re: [RFC PATCH v4 29/34] ext4: fall back to buffer_head path for
 defrag
To: Dave Chinner <david@fromorbit.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
 hch@infradead.org, djwong@kernel.org, willy@infradead.org,
 zokeefe@google.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com, wangkefeng.wang@huawei.com
References: <20240410142948.2817554-1-yi.zhang@huaweicloud.com>
 <20240410150313.2820364-1-yi.zhang@huaweicloud.com>
 <ZjIMQTAtxZ0NhCD2@dread.disaster.area>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <5dbb3021-b92e-2e53-7eee-5a6595a5ad03@huaweicloud.com>
Date: Mon, 6 May 2024 21:05:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZjIMQTAtxZ0NhCD2@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAnmAuS1ThmXifRMA--.45497S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Jr4kGw4xCryrur4xWFW8Crg_yoWDWwcE9F
	yrCrWDCw1UJF4xZrsI9rs8KFs2kr4UWr4qqryUXrnFy34FyrZ5XFsYk3yqk34rtFWxuFn0
	kwn3ZF40vr9rXjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbIAYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
	WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUFDGOUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/5/1 17:32, Dave Chinner wrote:
> On Wed, Apr 10, 2024 at 11:03:08PM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Online defrag doesn't support iomap path yet, we have to fall back to
>> buffer_head path for the inode which has been using iomap. Changing
>> active inode is dangerous, before we start, we must hold the inode lock
>> and the mapping->invalidate_lock, and writeback all dirty folios and
>> drop the inode's pagecache.
> 
> Even then, I don't think this is obviously safe. We went through
> this with DAX and we couldn't make it work safely.
> 
> Just return EOPNOTSUPP to the online defrag ioctl if iomap is in use
> - that avoids all the excitement involved in doing dangerous things
> like swapping aops structures on actively referenced inodes...
> 

Okay, this is just a temporary solution to support defrag. I've been
looking at how to support defrag for iomap recently, I hope it could
be supported in the near future, so let's drop this dangerous
operation.

Thanks,
Yi.




