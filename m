Return-Path: <linux-fsdevel+bounces-72371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B66E6CF18E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 05 Jan 2026 02:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 28F59300119B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jan 2026 01:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858582C11C9;
	Mon,  5 Jan 2026 01:18:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AE62BDC0A;
	Mon,  5 Jan 2026 01:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767575939; cv=none; b=IfrEgVPggToY+qa7fln+Gle+L910roCINJ/3ptzQHXC3w+9Acg4ZBP5lcFh1VK2buHdQ95ULR8NRFA/zxcwEJX6GA1oaAuZgQENtKMx0KLpLWuvIXv7a0TPDR19qb57nlZ1KD48FL5xlYCrVat4+UDW2yiLNTA1Sd7QlfTcAcKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767575939; c=relaxed/simple;
	bh=BMki50x7viBiOeBkeQLRFUMkIbs34xjZGd9x+JkL8j8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PqpWj2y+/PttY2gdo4+I9QmDBVDLsfasVjju6Yvv71lYcYIVcM0D1+pzgIvsjfNAUvpbKH96C8CpfLjal0iP7mzBry4JE1/MYwnCPwgIMygtFRue5Yo5wrbP01onf7phfc0MAtBzaORXGB75J/JH1GuG2eW9gPKJj5CpO/031pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dkxJ76BmlzKHM07;
	Mon,  5 Jan 2026 09:18:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 57FBB40570;
	Mon,  5 Jan 2026 09:18:53 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP4 (Coremail) with SMTP id gCh0CgDXOPl6EVtpgeKpCg--.40742S3;
	Mon, 05 Jan 2026 09:18:51 +0800 (CST)
Message-ID: <7846a127-c67e-491c-8d99-f00b9c472084@huaweicloud.com>
Date: Mon, 5 Jan 2026 09:18:50 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2 6/7] ext4: simply the mapping query logic in
 ext4_iomap_begin()
To: Markus Elfring <Markus.Elfring@web.de>, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Baokun Li <libaokun1@huawei.com>,
 Jan Kara <jack@suse.cz>, Ojaswin Mujoo <ojaswin@linux.ibm.com>,
 Theodore Ts'o <tytso@mit.edu>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Ritesh Harjani <ritesh.list@gmail.com>, Yang Erkun <yangerkun@huawei.com>,
 Yu Kuai <yukuai@fnnas.com>, zhangyi <yizhang089@gmail.com>
References: <20251223011802.31238-7-yi.zhang@huaweicloud.com>
 <f81c3747-ef35-4726-a7b9-f69b99ed1d97@web.de>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <f81c3747-ef35-4726-a7b9-f69b99ed1d97@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXOPl6EVtpgeKpCg--.40742S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYV7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kI
	c2xKxwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AKxVWUtVW8ZwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UQzVbUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 1/4/2026 9:00 PM, Markus Elfring wrote:
>> In the write path mapping check of ext4_iomap_begin(), the return value
>> 'ret' should never greater than orig_mlen. If 'ret' equals 'orig_mlen',
>> it can be returned directly without checking IOMAP_ATOMIC.
> 
> See also once more:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.19-rc3#n94
> 
> 
> How do you think about to use the word “simplify” in the summary phrase?
> 
> Regards,
> Markus

Yeah, it makes sense to me, I will revise it in v3.

Thanks,
Yi.


