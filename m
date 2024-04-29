Return-Path: <linux-fsdevel+bounces-18064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BC58B5208
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 09:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C409C281737
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 07:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E41013AEE;
	Mon, 29 Apr 2024 07:11:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917751079D;
	Mon, 29 Apr 2024 07:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714374718; cv=none; b=H/4RrAWL1WgEAq/aXCrYZuWi1mNIjMy33UzgM2y8QqAtIHUWS+dz8Cn0Y00pxV7pkAkbb7EfgunEYJPQMahQ5Q0u2i6Gb+DCtfGZOxbA4VvUhkDx59oO2Ybc8eC3DnpudgQFDihKCJu3EhpHZM5Y+6qJpQRi/+ljr08cw/bJwnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714374718; c=relaxed/simple;
	bh=VrcNs7voZl2xbyNLKiAEs2ZgJnR3UJ/Zp71/jqId5Po=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=AzLTvnnLd7xfn45ZMBH1NgXLuUEWJ7KdBtmrIX7CzjgFNOG3WD/UMqHJQ+7sc0lhvsp4DO3I/BvjKgT9t8QKm3MIrOTjnOqsThpRdh2fg7Sf3b/vElTEfeA0lB1+NTg9oPQ1n400oheGSOvjDNBFT4NbmFFOC6J8HnizMUqePNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VSZJF44Qpz4f3mHg;
	Mon, 29 Apr 2024 15:11:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id F3B691A0568;
	Mon, 29 Apr 2024 15:11:50 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgAXOQw1SC9mlDgXLg--.20275S3;
	Mon, 29 Apr 2024 15:11:50 +0800 (CST)
Subject: Re: [PATCH v5 4/9] xfs: convert delayed extents to unwritten when
 zeroing post eof blocks
To: Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 brauner@kernel.org, david@fromorbit.com, chandanbabu@kernel.org,
 tytso@mit.edu, jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com
References: <20240425131335.878454-1-yi.zhang@huaweicloud.com>
 <20240425131335.878454-5-yi.zhang@huaweicloud.com>
 <20240425182904.GA360919@frogsfrogsfrogs>
 <3be86418-e629-c7e6-fd73-f59f97a73a89@huaweicloud.com>
 <ZitKncYr0cCmU0NG@infradead.org>
 <5b6228ce-c553-3387-dfc4-2db78e3bd810@huaweicloud.com>
 <ZiyiNzQ6oY3ZAohg@infradead.org>
 <c4ab199e-92bf-4b22-fe41-1fca400bdc31@huaweicloud.com>
 <Zi8lCUjX8lByIVZI@infradead.org>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <f8363f80-027c-cbc2-8abc-fd211e639b38@huaweicloud.com>
Date: Mon, 29 Apr 2024 15:11:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zi8lCUjX8lByIVZI@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAXOQw1SC9mlDgXLg--.20275S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw18JF1DCFWfuFy5ZFyfCrg_yoW3urc_uF
	WI939xCrs7Jan3Zan0kr1SqrWvkF45Gr1YgrZ8Xrs7Jas8AFyxJ395GrZ5uw1fKw42yrnx
	W3ZFvFy7CF9FqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbIxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU1zuWJUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/4/29 12:41, Christoph Hellwig wrote:
> On Sun, Apr 28, 2024 at 11:26:00AM +0800, Zhang Yi wrote:
>>>
>>> Oh well.  Given that we're full in on the speculative allocations
>>> we might as well deal with it.
>>>
>>
>> Let me confirm, so you also think the preallocations in the COW fork that
>> overlaps the unreflinked range is useless, we should avoid allocating
>> this range, is that right? If so, I suppose we can do this improvement in
>> another patch(set), this one works fine now.
> 
> Well, not stop allocating it, but not actually convert it to a real
> allocation when we're just truncating it and replacing the blocks with
> reflinked blocks.

OK, it looks fine, too.

Thanks,
Yi.

> 
> But yes, this is a bigger project.>
> For now for this patch to go ahead:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 


