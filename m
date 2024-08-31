Return-Path: <linux-fsdevel+bounces-28105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BED96708F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2024 11:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1561F22636
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2024 09:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A871A17B4F9;
	Sat, 31 Aug 2024 09:49:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103DC193;
	Sat, 31 Aug 2024 09:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725097747; cv=none; b=HYy+9KDOcSiaB1MLb86FUAUw5neHkR3EI5toEQI/VkMrGrhIuieoUTbVkaJJhQHefn8ABY+/HAhgijsHY0tBzKAT9AYuNgAj0/mPhQwTbIHnffNAQ4OoPh6l5FxDrUC8M+ISJuKx4jPNO/KDLgJ+dwKVrDgwAX9TI6zZx8Pbgjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725097747; c=relaxed/simple;
	bh=6sUFkB0Ok0x06XvwFC30pbHHuqpTWoIbsyF3CR8TNjA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=LD8+udpoMuBgfeFErdIBMS/JqOcpu+vGF7DlqSsIleK2b5NtalHRqi5EVrom5HvYcixZnLZ3P1dkMUR/j9Ru2Gtlqr8bQmFT2iVXz1NolU5YH56ka6QyGoSlYlllWLdIL9EoQpfHrnSMM9iXTH2M0JXddrefmCAM0EXPyJlM/z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WwqwM4BG7z4f3jkJ;
	Sat, 31 Aug 2024 17:48:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A88F61A058E;
	Sat, 31 Aug 2024 17:49:01 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgAHL4UJ59JmmU_mDA--.25745S3;
	Sat, 31 Aug 2024 17:48:59 +0800 (CST)
Subject: Re: [PATCH] buffer: Associate the meta bio with blkg from buffer page
To: Tejun Heo <tj@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: Haifeng Xu <haifeng.xu@shopee.com>, viro@zeniv.linux.org.uk,
 brauner@kernel.org, jack@suse.cz, tytso@mit.edu, yi.zhang@huaweicloud.com,
 linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240828033224.146584-1-haifeng.xu@shopee.com>
 <ZtIfgc1CcG9XOu0-@slm.duckdns.org>
 <9cae20f9-aa6a-77da-8978-b4cfb7b0cb73@huaweicloud.com>
 <ZtLOUuoxnobhYgrm@slm.duckdns.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <5c6c1aa7-eae9-fe0f-aaf4-626a5f273234@huaweicloud.com>
Date: Sat, 31 Aug 2024 17:48:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZtLOUuoxnobhYgrm@slm.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHL4UJ59JmmU_mDA--.25745S3
X-Coremail-Antispam: 1UD129KBjvdXoWrWw1fXF4fJF4DCr4fWr13twb_yoWxXFg_u3
	9Ivr17Gw4UZan3uFs8tF18JFZ7GF4UuayIq3yjqr97Ww1fZr1UGFZ5G34xA3Z5AFZ7AF9x
	GF1DZw15JrWUGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/08/31 16:03, Tejun Heo Ð´µÀ:
> Hello,
> 
> On Sat, Aug 31, 2024 at 02:11:08PM +0800, Yu Kuai wrote:
> ...
>>> I think the right way to do it is marking the bio with REQ_META and
>>> implement forced charging in blk-throtl similar to blk-iocost.
>>
>> This is the exact thing I did in the code I attached in the other
>> thread, do you take a look?
>>
>> https://lore.kernel.org/all/97fc38e6-a226-5e22-efc2-4405beb6d75b@huaweicloud.com/
> 
> Sorry about missing it but yeah that *looks* like the right direction to be
> headed. Would you mind testing it and turning it into a proper patch?

Of course.

Thanks!
Kuai

> 
> Thanks.
> 


