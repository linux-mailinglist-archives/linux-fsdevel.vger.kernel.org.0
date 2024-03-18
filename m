Return-Path: <linux-fsdevel+bounces-14737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4E387E932
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 13:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E40282CE4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 12:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56519381B1;
	Mon, 18 Mar 2024 12:17:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D2425740;
	Mon, 18 Mar 2024 12:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710764262; cv=none; b=cnQNebfd3wMSTIStJqgh+zIzNOLGn0MAyloVKKaRp17H82C3oTmvE+eDDHzC1vkuDlK1TWMtsEXmo0oX4Peup/ZpGnqwXw8zpIu1Ys4UvQqpIf/Pha9i5ggCVSOqgMciGEIn/W8+R/UGoJ6+nxsbf2XahPTJ574F+FsPk+7J1NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710764262; c=relaxed/simple;
	bh=C9vwxNqqS1MgLoDivRETYtHtVTLZAJOzHIFtIGowLEw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DSIfTe7Xasz45VNNjzdmJ8BOgag0ssynh9ra++c9xZPxjaXyW1nrjYW1ChCps0c+jdl3vxnIYwVaHzySrYWDBTIWAXiwEpynYFfZFYpnK1CxHittV9f6q2R29kwJXIH9C+qoTYUU1nnq7rUiKiroLqibZbkhl8geENC+6nnsVRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Tytdk6WRgz4f3jMX;
	Mon, 18 Mar 2024 19:57:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id CBDEE1A0A6E;
	Mon, 18 Mar 2024 19:57:52 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBE9LPhlRX9THQ--.47650S3;
	Mon, 18 Mar 2024 19:57:51 +0800 (CST)
Subject: Re: [RFC v4 linux-next 19/19] fs & block: remove bdev->bd_inode
To: Christian Brauner <brauner@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>, jack@suse.cz, axboe@kernel.dk,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
 <20240222124555.2049140-20-yukuai1@huaweicloud.com>
 <20240317213847.GD10665@lst.de>
 <022204e6-c387-b4b2-5982-970fd1ed5b5b@huaweicloud.com>
 <20240318013208.GA23711@lst.de>
 <5c231b60-a2bf-383e-e641-371e7e57da67@huaweicloud.com>
 <ea4774db-188e-6744-6a5b-0096f6206112@huaweicloud.com>
 <20240318-umwirbt-fotowettbewerb-63176f9d75f3@brauner>
 <20240318-fassen-xylofon-1d50d573a196@brauner>
 <20240318-darauf-lachhaft-b7a510575d87@brauner>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <06c8cc61-0368-eccc-b781-0eda223a9b07@huaweicloud.com>
Date: Mon, 18 Mar 2024 19:57:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240318-darauf-lachhaft-b7a510575d87@brauner>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHGBE9LPhlRX9THQ--.47650S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw1xJFyUuFy5Cw45WFWDtwb_yoW7GrWDpF
	W5tF4UKr4kGr10g3Z2v3W7Xr4Fyws5JrW5Xr1Yqry5ArWq9rnagFWrKr1YkF1Utr4xAr4j
	qr4jgry7Xrn8ArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
	3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/03/18 18:46, Christian Brauner 写道:
> On Mon, Mar 18, 2024 at 11:29:22AM +0100, Christian Brauner wrote:
>> On Mon, Mar 18, 2024 at 11:07:49AM +0100, Christian Brauner wrote:
>>> On Mon, Mar 18, 2024 at 03:19:03PM +0800, Yu Kuai wrote:
>>>> Hi, Christoph!
>>>>
>>>> 在 2024/03/18 9:51, Yu Kuai 写道:
>>>>> Hi,
>>>>>
>>>>> 在 2024/03/18 9:32, Christoph Hellwig 写道:
>>>>>> On Mon, Mar 18, 2024 at 09:26:48AM +0800, Yu Kuai wrote:
>>>>>>> Because there is a real filesystem(devtmpfs) used for raw block devcie
>>>>>>> file operations, open syscall to devtmpfs:
>>
>> Don't forget:
>>
>> mknod /my/xfs/file/system b 8 0
>>
>> which means you're not opening it via devtmpfs but via xfs. IOW, the
>> inode for that file is from xfs.

I think there is no difference from devtmpfs, no matter what file is
passed in from blkdev_open(), we'll find the only bd_inode and stash
new bdev_file here.
>>
>>>>>>>
>>>>>>> blkdev_open
>>>>>>>    bdev = blkdev_get_no_open
>>>>>>>    bdev_open -> pass in file is from devtmpfs
>>>>>>>    -> in this case, file inode is from devtmpfs,
>>>>>>
>>>>>> But file->f_mapping->host should still point to the bdevfs inode,
>>>>>> and file->f_mapping->host is what everything in the I/O path should
>>>>>> be using.
>>>
>>> I mentioned this in
>>> https://lore.kernel.org/r/20240118-gemustert-aalen-ee71d0c69826@brauner
>>>
>>> "[...] if we want to have all code pass a file and we have code in
>>> fs/buffer.c like iomap_to_bh():
>>>
>>> iomap_to_bh(struct inode *inode, sector_t block, struct buffer_head *bh,
>>>          loff_t offset = block << inode->i_blkbits;
>>>
>>>          bh->b_bdev = iomap->bdev;
>>> +       bh->f_b_bdev = iomap->f_bdev;
>>>
>>> While that works for every single filesystem that uses block devices
>>> because they stash them somewhere (like s_bdev_file) it doesn't work for
>>> the bdev filesystem itself. So if the bdev filesystem calls into helpers
>>> that expect e.g., buffer_head->s_f_bdev to have been initialized from
>>> iomap->f_bdev this wouldn't work.
>>>
>>> So if we want to remove b_bdev from struct buffer_head and fully rely on
>>> f_b_bdev - and similar in iomap - then we need a story for the bdev fs
>>> itself. And I wasn't clear on what that would be."
>>>
>>>>>>
>>>>>>> Then later, in blkdev_iomap_begin(), bd_inode is passed in and there is
>>>>>>> no access to the devtmpfs file, we can't use s_bdev_file() as other
>>>>>>> filesystems here.
>>>>>>
>>>>>> We can just pass the file down in iomap_iter.private
>>>>>
>>>>> I can do this for blkdev_read_folio(), however, for other ops like
>>>>> blkdev_writepages(), I can't find a way to pass the file to
>>>>> iomap_iter.private yet.
>>>>>
>>>>> Any suggestions?
>>>>
>>>> I come up with an ideal:
>>>>
>>>> While opening the block_device the first time, store the generated new
>>>> file in "bd_inode->i_private". And release it after the last opener
>>>> close the block_device.
>>>>
>>>> The advantages are:
>>>>   - multiple openers can share the same bdev_file;
>>>
>>> You mean use the file stashed in bdev_inode->i_private only to retrieve
>>> the inode/mapping in the block layer ops.

Yes. I mean in the first bdev_open() allocate a bdev_file and stash it,
and free it in the last bdev_release().
>>>
>>>>   - raw block device ops can use the bdev_file as well, and there is no
>>>> need to distinguish iomap/buffer_head for raw block_device;
>>>>
>>>> Please let me know what do you think?
>>>
>>> It's equally ugly but probably slightly less error prone than the union
>>> approach. But please make that separate patches on top of the series.
> 
> The other issue with this on-demand inode->i_private allocation will be
> lifetime management. If you're doing some sort of writeback initiated
> from the filesystem then you're guaranteed that the file stashed in
> sb->bdev_file is aligned with the lifetime of the filesystem. All
> writeback related stuff that relies on inode's can rely on the
> superblock being valid while it is doing stuff.

For raw block device, before bdev_release() is called for the last
opener(specifically bd_openers decreased to zero),
blkdev_flush_mapping() is called, hence raw block_device writeback
should always see valid 'bdev_file' that will be release in the last
bdev_release().

And 'blockdev_superblock' will always be there and is always valid.>
> In your approach that guarantee can't be given easily. If someone opens
> a block device /dev/sda does some buffered writes and then closes it the
> file might be cleaned up while there's still operations ongoing that
> rely on the file stashed in inode->i_private to be valid.
> 
> If on the other hand you allocate a stub file on-demand during
> bdev_open() and stash it in inode->i_private you need to make sure to
> avoid creating reference count cycles that keep the inode alive.

I'm thinking about use 'bdev_openers' to gurantee the lifetime. I can't
think of possible problems for now, however, I cound be wrong.

Thanks,
Kuai

> .
> 


