Return-Path: <linux-fsdevel+bounces-14795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2969787F524
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 02:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE5961F21B1A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 01:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E81629F3;
	Tue, 19 Mar 2024 01:43:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F8E2F22;
	Tue, 19 Mar 2024 01:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710812610; cv=none; b=oB8PaPSDQ+yUBhQ+mUd8frDmnNZis4bFqArd7eQFUY0CEzSWfIusoZs1lQUDfDjlg8UwexOTGFZ9A8utVviQIs0ZWr+lmuEGT4asR+CtW7y6Oks15ibJ96OR3g1SdSAhU7N5reE6n0BVaks8f3AbDYC7u2dfF1XtQUac/HJ7lCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710812610; c=relaxed/simple;
	bh=em3g8D9JGmpkhCEW6BubAq2pSMb2nx+ivC79uAbHsD0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=extBTRTUdCmdbLHAr0J61FeYTU7EJJQtP/B61SdPmKLfOrDjpVMIOur9iJGpaThpEYdIN4TdFCIBdnopzdm/VLWFTzQbArrcwujTBA/6WBsUFGUnFxw16LMvYkm1j0pjar+pA1QoRtOuupELO8aWS3c269b0whYCRdCDRcSUI/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TzDyF4SWNz4f3mHp;
	Tue, 19 Mar 2024 09:43:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 7E40F1A09EB;
	Tue, 19 Mar 2024 09:43:25 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBnOBG77fhl_lSPHQ--.38859S3;
	Tue, 19 Mar 2024 09:43:25 +0800 (CST)
Subject: Re: [RFC v4 linux-next 00/19] fs & block: remove bdev->bd_inode
To: Yu Kuai <yukuai1@huaweicloud.com>, Christian Brauner <brauner@kernel.org>
Cc: jack@suse.cz, hch@lst.de, axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
 <1324ffb5-28b6-34fb-014e-3f57df714095@huawei.com>
 <20240315-assoziieren-hacken-b43f24f78970@brauner>
 <ac0eb132-c604-9761-bce5-69158e73f256@huaweicloud.com>
 <20240318-mythisch-pittoresk-1c57af743061@brauner>
 <c9bfba49-9611-c965-713c-1ef0b1e305ce@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <dd4e443a-696d-b02f-44ff-4649b585ef17@huaweicloud.com>
Date: Tue, 19 Mar 2024 09:43:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <c9bfba49-9611-c965-713c-1ef0b1e305ce@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBnOBG77fhl_lSPHQ--.38859S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZw1DCF1UGw17AF48uF1ftFb_yoWkXFgEvw
	sIkas7G34DZw1jqanxtrs0yrWvkFy3Jry5t345JF13Xa1kXFyDGF4kJ3s2vwn8G3W3tF1S
	kF4qqFy5ZrWfGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUba8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3
	Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/03/19 9:18, Yu Kuai 写道:
> Hi,
> 
> 在 2024/03/18 17:39, Christian Brauner 写道:
>> On Sat, Mar 16, 2024 at 10:49:33AM +0800, Yu Kuai wrote:
>>> Hi, Christian
>>>
>>> 在 2024/03/15 21:54, Christian Brauner 写道:
>>>> On Fri, Mar 15, 2024 at 08:08:49PM +0800, Yu Kuai wrote:
>>>>> Hi, Christian
>>>>> Hi, Christoph
>>>>> Hi, Jan
>>>>>
>>>>> Perhaps now is a good time to send a formal version of this set.
>>>>> However, I'm not sure yet what branch should I rebase and send this 
>>>>> set.
>>>>> Should I send to the vfs tree?
>>>>
>>>> Nearly all of it is in fs/ so I'd say yes.
>>>> .
>>>
>>> I see that you just create a new branch vfs.fixes, perhaps can I rebase
>>> this set against this branch?
>>
>> Please base it on vfs.super. I'll rebase it to v6.9-rc1 on Sunday.
> 
> Okay, I just see that vfs.super doesn't contain commit
> 1cdeac6da33f("btrfs: pass btrfs_device to btrfs_scratch_superblocks()"),
> and you might need to fix the conflict at some point.

And there is another problem, dm-vdo doesn't exist in vfs.super yet. Do
you still want me to rebase here?

Thanks,
Kuai

> 
> Thanks,
> Kuai
> 
>> .
>>
> 
> .
> 


