Return-Path: <linux-fsdevel+bounces-13240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BEE86DA04
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 04:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 306F21F230F6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 03:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688C94437F;
	Fri,  1 Mar 2024 03:26:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759D041C93;
	Fri,  1 Mar 2024 03:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709263609; cv=none; b=i0AwXvK79ugmf6iU4MGCeRVehj3yuSl8cQMt7vdgveUSn4WxkgdM3lzYin6oWDvzL9SnNumC5AyMuRloe7dnpNDiFhjz+t8nTIL7T38oV/oKV2oGNkWIbo7okk5j0tb8+hFj5P6Wv3tiqrsxHmfNddC4vwBirOZZUpcozR6Rh4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709263609; c=relaxed/simple;
	bh=fW9YFLy50+y8EU/W46CfJW7150cPRI8UIXLaa/73BB0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jTETChI0qMyy9KWjruMO71GCx06UdEPDzPvM14/4atweN2mHkjlxf1W0NqLJ4+fD5XVOA2EZQpoGlxdcZs3XkuUBT5q9nx/tfXB7a1VQPO2uD6H+rLJL+QOs3bynMuTEoar2dnKILSow7HphT0aRLqD0vQ8m09nQH+OuKDU2eGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TmD5n336rz4f3jdH;
	Fri,  1 Mar 2024 11:26:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id AE8E11A0838;
	Fri,  1 Mar 2024 11:26:42 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
	by APP1 (Coremail) with SMTP id cCh0CgBHZQ7wSuFlmyFSFg--.41524S3;
	Fri, 01 Mar 2024 11:26:42 +0800 (CST)
Subject: Re: [RFC PATCH v3 07/26] iomap: don't increase i_size if it's not a
 write operation
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@infradead.org>, djwong@kernel.org,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
 ritesh.list@gmail.com, willy@infradead.org, zokeefe@google.com,
 yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
 wangkefeng.wang@huawei.com
References: <20240127015825.1608160-1-yi.zhang@huaweicloud.com>
 <20240127015825.1608160-8-yi.zhang@huaweicloud.com>
 <ZcsCP4h-ExNOcdD6@infradead.org>
 <9b0040ef-3d9d-6246-4bdd-82b9a8f55fa2@huaweicloud.com>
 <Zd+y2VP8HpbkDu41@dread.disaster.area>
 <45c1607a-805d-e7a2-a5ca-3fd7e507a664@huaweicloud.com>
 <ZeERAob9Imwh01bG@dread.disaster.area>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <0b316c9a-b2d7-af02-854e-31430d4f53cd@huaweicloud.com>
Date: Fri, 1 Mar 2024 11:26:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZeERAob9Imwh01bG@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgBHZQ7wSuFlmyFSFg--.41524S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw48KF15uw15Jw1rKw1DAwb_yoWxAFgE9F
	srAr48Kw4DGw47uw42ka1ktrsFgFWUWa12qrW5Xr4vkrZ8JFWDWr13Gr93Z3sakFsakFnI
	9F9Y9347ZrnIvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbIxYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
	WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU13rcDUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/3/1 7:19, Dave Chinner wrote:
> On Thu, Feb 29, 2024 at 04:59:34PM +0800, Zhang Yi wrote:
>> Hello, Dave!
>>
>> On 2024/2/29 6:25, Dave Chinner wrote:
>>> On Wed, Feb 28, 2024 at 04:53:32PM +0800, Zhang Yi wrote:
>>>> On 2024/2/13 13:46, Christoph Hellwig wrote:
...
> 
> The general solution is to have zeroing of speculative prealloc
> extents beyond EOF simply convert the range to unwritten and then
> invalidate any cached pages over that range. At this point, we are
> guaranteed to have zeroes across that range, all without needing to
> do any IO at all...
> 

Sure, thanks for the explanation, I will try to solve this problem
for xfs first.

Thanks,
Yi.


