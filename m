Return-Path: <linux-fsdevel+bounces-53755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B95AF67CC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 04:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9BA01C28650
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 02:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5419C1D5CC6;
	Thu,  3 Jul 2025 02:13:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1BA7BAEC;
	Thu,  3 Jul 2025 02:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751508793; cv=none; b=S3ro2NBqbD5h0V34HgUIBR1CpVQ5X8Ypgvt3JYd33N3TeF+EHMDYwpc7Os63ghexoIZDhmOKoT9EmB1BdTdAMv6p0pU4ehvROyDaO/XtKcsKS3Xkn+J3fn42gFXClMC3iMnlwHITU36846k4TESiRMREBI7gYGDEN7uYC0MQ7C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751508793; c=relaxed/simple;
	bh=vdZUiIwKI1Cl3zCwisdXooEoOnjgrFiTCmB7ZQbdyXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XIXEXzSCpy6EM9xPqp45lSkCTPqlORUPSPxgEPQJa4ckvpiyqkjTQuZEUkXQgejnZoK1e582wTKN1YstvF3ACj6ikZ4AmzHnKO/5Lg8BFwLdpuwnJCiRCtbKWU6Z0Qmy4tYdMOttButuO61q1sx+rHRksJ3OvjpSeuX8C5UtUCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bXgKL2Tg6zKHMjW;
	Thu,  3 Jul 2025 10:13:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id B9EA31A0924;
	Thu,  3 Jul 2025 10:13:08 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP3 (Coremail) with SMTP id _Ch0CgA3mSYz52VoaNDrAQ--.65417S3;
	Thu, 03 Jul 2025 10:13:08 +0800 (CST)
Message-ID: <ceb8c9c1-f426-4cd0-b7d8-841190631a90@huaweicloud.com>
Date: Thu, 3 Jul 2025 10:13:07 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/10] ext4: restart handle if credits are insufficient
 during allocating blocks
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 ojaswin@linux.ibm.com, sashal@kernel.org, yi.zhang@huawei.com,
 libaokun1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
References: <20250701130635.4079595-1-yi.zhang@huaweicloud.com>
 <20250701130635.4079595-6-yi.zhang@huaweicloud.com>
 <i7lzmvk5prgnw2zri46adshfjhfq63r7le5w5sv67wmkiimbhc@a24oub5o6xtg>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <i7lzmvk5prgnw2zri46adshfjhfq63r7le5w5sv67wmkiimbhc@a24oub5o6xtg>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgA3mSYz52VoaNDrAQ--.65417S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tw1kXw1DuF45JrW3KrWrGrg_yoW8ZrWrpF
	WfCF1jkr17Wa47ua1Iqw4kXFWfG3y8CrW7JrZ8W3savan8ur9akF4rJ3Z8Kas0yrWxW3W3
	Zr4jy343u3WYyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	0PfPUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/7/2 22:18, Jan Kara wrote:
> On Tue 01-07-25 21:06:30, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> After large folios are supported on ext4, writing back a sufficiently
>> large and discontinuous folio may consume a significant number of
>> journal credits, placing considerable strain on the journal. For
>> example, in a 20GB filesystem with 1K block size and 1MB journal size,
>> writing back a 2MB folio could require thousands of credits in the
>> worst-case scenario (when each block is discontinuous and distributed
>> across different block groups), potentially exceeding the journal size.
>> This issue can also occur in ext4_write_begin() and ext4_page_mkwrite()
>> when delalloc is not enabled.
>>
>> Fix this by ensuring that there are sufficient journal credits before
>> allocating an extent in mpage_map_one_extent() and
>> ext4_block_write_begin(). If there are not enough credits, return
>> -EAGAIN, exit the current mapping loop, restart a new handle and a new
>> transaction, and allocating blocks on this folio again in the next
>> iteration.
>>
>> Suggested-by: Jan Kara <jack@suse.cz>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> Very nice. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> One small comment below:
> 
>> +/*
>> + * Make sure that the current journal transaction has enough credits to map
>> + * one extent. Return -EAGAIN if it cannot extend the current running
>> + * transaction.
>> + */
>> +static inline int ext4_journal_ensure_extent_credits(handle_t *handle,
>> +						     struct inode *inode)
>> +{
>> +	int credits;
>> +	int ret;
>> +
>> +	if (!handle)
> 
> Shouldn't this rather be ext4_handle_valid(handle) to catch nojournal mode
> properly?
> 
__ext4_journal_ensure_credits() already calls ext4_handle_valid() to handle
nojournal mode, and the '!handle' check here is to handle the case where
ext4_block_write_begin() passes in a NULL 'handle'.

Thanks,
Yi.


