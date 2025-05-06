Return-Path: <linux-fsdevel+bounces-48163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B43AAB941
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 08:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1FF14A694D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 06:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6070F295DAE;
	Tue,  6 May 2025 04:01:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB4B1386DA;
	Tue,  6 May 2025 02:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746498314; cv=none; b=rLqJbJLau16g8f/D1wiWvNrCNlc3rQT2oXZ7JsjJ/HRPKHYDxDrYzYrv4rNTaHp9F+4064yvZLPV3nOre2fW5FqUPCJIOzB4Dg0+npxI+80qnvTb8qffsOZlQr8jC2+kWBoTEUta7yk1HRdlk/O3z9V5uuJn05zEwg768ks7JTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746498314; c=relaxed/simple;
	bh=yEpidYVsK6d7u4CVEdAvzxNONuSeJ4rBRYQkAnE47VU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=buI/pyRaHrncxTekHyg3sLZ7ljOMIbYajO9kCM6bXOJCxey1bS/vN/baECyMyLJJz3gOYB14n5U/PJMR8D4UrFGN2x9C/z7n3rPcmG9vo76Xm0GbYjUkt/df3EzlfFnqy2VfSEYSfvViXsYOHrWFdVCDZiCC6wE+a8Mb3hKDkao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Zs2KR62dBz4f3jdt;
	Tue,  6 May 2025 10:24:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 49BD21A12DD;
	Tue,  6 May 2025 10:25:08 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgCnCl8CcxloBMVDLg--.27787S3;
	Tue, 06 May 2025 10:25:07 +0800 (CST)
Message-ID: <d93e69d0-8145-40ac-8afc-f1e8ccbe2052@huaweicloud.com>
Date: Tue, 6 May 2025 10:25:06 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kernel BUG in zero_user_segments
To: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
Cc: Liebes Wang <wanghaichi0403@gmail.com>, ojaswin@linux.ibm.com,
 Theodore Ts'o <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
 syzkaller@googlegroups.com, Ext4 Developers List <linux-ext4@vger.kernel.org>
References: <CADCV8spm=TtW_Lu6p-5q-jdHv1ryLcx45mNBEcYdELbHv_4TnQ@mail.gmail.com>
 <uxweupjmz7pzbj77cciiuxduxnbuk33mx75bimynzcjmq664zo@xqrdf6ouf5v6>
 <ac3a58f6-e686-488b-a9ee-fc041024e43d@huawei.com>
 <aBGVmIin8YxRyFDp@casper.infradead.org>
 <znfg4s5ysxqvrzeevkmtgixj5vztcyqbuny7waqkugnzkpg2zx@2vxwh57flvva>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <znfg4s5ysxqvrzeevkmtgixj5vztcyqbuny7waqkugnzkpg2zx@2vxwh57flvva>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCnCl8CcxloBMVDLg--.27787S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr1xCw4UGr47WF45CF45KFg_yoW8WF4UpF
	WxAryrtF4DtFWIkan7Zr1Iqrnaq3s8CFWUXF95Gr4fArZ8WFn29rn0kF4YkasF9r4xuw1j
	qFyjg3srJ3sIyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/5/1 19:19, Jan Kara wrote:
> On Wed 30-04-25 04:14:32, Matthew Wilcox wrote:
>> On Tue, Apr 29, 2025 at 03:55:18PM +0800, Zhang Yi wrote:
>>> After debugging, I found that this problem is caused by punching a hole
>>> with an offset variable larger than max_end on a corrupted ext4 inode,
>>> whose i_size is larger than maxbyte. It will result in a negative length
>>> in the truncate_inode_partial_folio(), which will trigger this problem.
>>
>> It seems to me like we're asking for trouble when we allow an inode with
>> an i_size larger than max_end to be instantiated.  There are probably
>> other places which assume it is smaller than max_end.  We should probably
>> decline to create the bad inode in the first place?
> 
> Indeed somewhat less quirky fix could be to make ext4_max_bitmap_size()
> return one block smaller limit. Something like:
> 
>         /* Compute how many blocks we can address by block tree */
>         res += ppb;
>         res += ppb * ppb;
>         res += ((loff_t)ppb) * ppb * ppb;
> +	/*
> +	 * Hole punching assumes it can map the block past end of hole to
> +	 * tree offsets
> +	 */
> +	res -= 1;
>         /* Compute how many metadata blocks are needed */
>         meta_blocks = 1;
>         meta_blocks += 1 + ppb;
> 
> The slight caveat is that in theory there could be filesystems out there
> with so large files and then we'd stop allowing access to such files. But I
> guess the chances are so low that it's probably worth trying.
> 

Hmm, I suppose this approach could pose some risks to our legacy products,
and it makes me feel uneasy. Personally, I am more inclined toward the
current solution, unless we decide to fix the ext4_ind_remove_space()
directly. :)

Thanks,
Yi.



