Return-Path: <linux-fsdevel+bounces-58989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4446AB33B36
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 11:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EC827A7365
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 09:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9352C3248;
	Mon, 25 Aug 2025 09:36:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E74F235041;
	Mon, 25 Aug 2025 09:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756114571; cv=none; b=LwCCv+7tgLcm99ALKaxhP0l1A4/qGeaPDFRA4pna2xC63c4KZ10rsIZuYarQp6KPeKeEyyALSwWZ5XBig7Ea/NwwWZGOKZM8pqU7q7IQgLKNwYssvdRCh1SKljn2jMsjSzhQH3V0Ikanv+1Qbmm/SBauynGDgAFdYt15e7e5HFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756114571; c=relaxed/simple;
	bh=N9qWtkRk3fJ5bIXuhkjNCG48R1vPFV+wVc1tIXHExks=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=UxVPPP/+TgFLLYSw0Q1gzBwBLpyn9/7YS8wlPmuNbAZ5qcrZGxX/ESsa6wYqa/DMMa4WG7yx9+u0sdWE57p/DE7PK1x+/lPG9aREbZ8Dra6Fx0OzZX3nOILLxAHhDbKonhBGQaryEZV+0BFmjq5IQLR3bi++Jy32QANl3S4oJDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c9Qdy2sppzYQtnt;
	Mon, 25 Aug 2025 17:36:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E9F391A01A1;
	Mon, 25 Aug 2025 17:36:04 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgAXYIyCLqxo09rwAA--.44762S3;
	Mon, 25 Aug 2025 17:36:04 +0800 (CST)
Subject: Re: [PATCH] loop: fix zero sized loop for block special file
To: Christoph Hellwig <hch@infradead.org>, Ming Lei <ming.lei@redhat.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, rajeevm@hpe.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com,
 linux-fsdevel@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20250825062300.2485281-1-yukuai1@huaweicloud.com>
 <aKwlVypJuBtPH_EL@fedora> <aKwqUVmX-yH6_lZy@infradead.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <eb572576-89f4-c192-09ab-b4585d09b75a@huaweicloud.com>
Date: Mon, 25 Aug 2025 17:36:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aKwqUVmX-yH6_lZy@infradead.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXYIyCLqxo09rwAA--.44762S3
X-Coremail-Antispam: 1UD129KBjvdXoWruF48CrWrCF1fKw4xAF43Jrb_yoWftrb_Wr
	1rAFyDt348Zrn2k3y3K3WDtrZ5GF4jkry3X3y0kF9Fywn7X34fuF1rZ343WF12qryjyrsI
	9w43Zr1UJry3ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
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

ÔÚ 2025/08/25 17:18, Christoph Hellwig Ð´µÀ:
> On Mon, Aug 25, 2025 at 04:56:55PM +0800, Ming Lei wrote:
>> `stat $BDEV_PATH` never works for getting bdev size, so it looks wrong
>> to call vfs_getattr_nosec() with bdev path for retrieving bdev's size.
> 
> Exactly.
> 

Ok.
>> So just wondering why not take the following more readable way?
>>
>> 	/* vfs_getattr() never works for retrieving bdev size */
>> 	if (S_ISBLK(stat.mode)) {
>> 		loopsize = i_size_read(file->f_mapping->host);
>> 	} else {
>>            ret = vfs_getattr_nosec(&file->f_path, &stat, STATX_SIZE, 0);
>>            if (ret)
>>                    return 0;
>>            loopsize = stat.size;
>> 	}

Just we can't use stat.mode here, I'll replace it with:

S_ISBLK(file_inode(file)->i_mode)

Thanks,
Kuai

>>
>> Also the above looks like how application reads file size in case of bdev
>> involved.
> 
> That's not just more readable, but simply the way to go.  Maybe split
> it into a helper for readability, though.
> .
> 


