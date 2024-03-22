Return-Path: <linux-fsdevel+bounces-15059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C31F688672B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 07:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2A661C23909
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 06:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548811BDEE;
	Fri, 22 Mar 2024 06:52:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D7E1B967;
	Fri, 22 Mar 2024 06:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711090352; cv=none; b=Ui/FpEeajAuaDkL+zw6dfV9iSgUMeT9Ig7sDHaEnMTB/zv78CuJjF9G25MgZzMWWgqhk/EZNf0YKc1cO56ZFQHslzXLuc0JTX4bllydJIPFS5acQ2V4UZXfsbztJJVkx4aOAXBVrtem8ebzcu9W57y20dG5EZeoIdZV9zT+fAs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711090352; c=relaxed/simple;
	bh=bC0VwAMmjjaPlPp/AY14cXKkkFDIEQiIYzG/xloaQLY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZAX87Ml3D/ELoxFlNxvRd7++ZNUgKC+K4D8QbcZFSxq3f+6jkbM7wzzTr2Fl0P3HSi/p76a/T5qs4iezAsTgMxwM+7hQgPGqhZ28Y4JJlf6n+KCTCvN/Em42TfinQXK07wxccJYWxTN1V2La/CwACywzeeKUCZCwApvmSyN9pUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V1CgG6b9Fz4f3m6f;
	Fri, 22 Mar 2024 14:52:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E008A1A0199;
	Fri, 22 Mar 2024 14:52:18 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBHZQ6hKv1l5bTaHg--.60999S3;
	Fri, 22 Mar 2024 14:52:18 +0800 (CST)
Subject: Re: [RFC v4 linux-next 19/19] fs & block: remove bdev->bd_inode
To: Al Viro <viro@zeniv.linux.org.uk>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
 brauner@kernel.org, axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240317213847.GD10665@lst.de>
 <022204e6-c387-b4b2-5982-970fd1ed5b5b@huaweicloud.com>
 <20240318013208.GA23711@lst.de>
 <5c231b60-a2bf-383e-e641-371e7e57da67@huaweicloud.com>
 <ea4774db-188e-6744-6a5b-0096f6206112@huaweicloud.com>
 <20240318232245.GA17831@lst.de>
 <c62dac0e-666f-9cc9-cffe-f3d985029d6a@huaweicloud.com>
 <20240321112737.33xuxfttrahtvbej@quack3>
 <240b78df-257e-a97c-31ff-a8b1b1882e80@huaweicloud.com>
 <20240322063718.GC3404528@ZenIV> <20240322063955.GM538574@ZenIV>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <170c544c-164e-368c-474a-74ae4055d55f@huaweicloud.com>
Date: Fri, 22 Mar 2024 14:52:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240322063955.GM538574@ZenIV>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHZQ6hKv1l5bTaHg--.60999S3
X-Coremail-Antispam: 1UD129KBjvdXoW7XF45GFW7ZrW7Gryruw1Dtrb_yoWDuFX_XF
	y8uF9Yyw1UXFn5uan0kFyrJryqqw1DZrW3t39xX34rXwn3Xas3uF1rC34xAF98Gw4UKrsx
	Cr1rXFW5XryxtjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
	3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/03/22 14:39, Al Viro Ð´µÀ:
> On Fri, Mar 22, 2024 at 06:37:18AM +0000, Al Viro wrote:
>> On Thu, Mar 21, 2024 at 08:15:06PM +0800, Yu Kuai wrote:
>>
>>>> blkdev_iomap_begin() etc. may be an arbitrary filesystem block device
>>>> inode. But why can't you use I_BDEV(inode->i_mapping->host) to get to the
>>>> block device instead of your file_bdev(inode->i_private)? I don't see any
>>>> advantage in stashing away that special bdev_file into inode->i_private but
>>>> perhaps I'm missing something...
>>>>
>>>
>>> Because we're goning to remove the 'block_device' from iomap and
>>> buffer_head, and replace it with a 'bdev_file'.
>>
>> What of that?  file_inode(file)->f_mapping->host will give you bdevfs inode
>> just fine...
> 
> file->f_mapping->host, obviously - sorry.
> .

Yes, we already get bdev_inode this way, and use it in
blkdev_iomap_begin() and blkdev_get_block(), the problem is that if we
want to let iomap and buffer_head to use bdev_file for raw block fops as 
well, we need a 'bdev_file' somehow.

Thanks,
Kuai

> 


