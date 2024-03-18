Return-Path: <linux-fsdevel+bounces-14714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2676687E3FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 08:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7EB61F21779
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 07:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7522F2262B;
	Mon, 18 Mar 2024 07:19:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D512233E;
	Mon, 18 Mar 2024 07:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710746353; cv=none; b=cEjJRQiQx+CD4TJsPIRzMgYEdTbFszIjIP56t5MpE4+JODdwIgK8Kn50G2xFiNcUaQF+QUKmKjNvg6uDLbdY35eIqDYwWeeo/H1eTTLXtXwnfVnv5Sc3dm6h4LDQgIWjTzqcuf1UoE9G6qH3d24ehe3iwSHBnqA1sys98M5m9lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710746353; c=relaxed/simple;
	bh=T9rR11fKbyEXYx5AZtCFHklQYWM3C/yUh98/aYPFuxM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=hXaUTqD9a8WZG8HO6NlA1GSRwmckuOqVwGMT5G6WD5rhrzXfPffY2VjVjEcTNRxYgVfXdwVDRH2+AAsQ8drfUhy75Ri2G7Qub2j9eeQ8lOWTyiWAUlHVMDI4U+vXLidO9FA2TTP1JI2C/ceWPov+9oEhKsAxXMcdPJBy6FkfeO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TymS55gszz4f3k6Y;
	Mon, 18 Mar 2024 15:19:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 98FE71A0E2A;
	Mon, 18 Mar 2024 15:19:05 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxDn6vdlBmg_HQ--.26754S3;
	Mon, 18 Mar 2024 15:19:05 +0800 (CST)
Subject: Re: [RFC v4 linux-next 19/19] fs & block: remove bdev->bd_inode
To: Yu Kuai <yukuai1@huaweicloud.com>, Christoph Hellwig <hch@lst.de>
Cc: jack@suse.cz, brauner@kernel.org, axboe@kernel.dk,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
 <20240222124555.2049140-20-yukuai1@huaweicloud.com>
 <20240317213847.GD10665@lst.de>
 <022204e6-c387-b4b2-5982-970fd1ed5b5b@huaweicloud.com>
 <20240318013208.GA23711@lst.de>
 <5c231b60-a2bf-383e-e641-371e7e57da67@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <ea4774db-188e-6744-6a5b-0096f6206112@huaweicloud.com>
Date: Mon, 18 Mar 2024 15:19:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5c231b60-a2bf-383e-e641-371e7e57da67@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxDn6vdlBmg_HQ--.26754S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tw4xGrykuw45Xr4xtFW7CFg_yoW8XryDpa
	98JFWUKr4kGryDK3Wvv3WUJr4Fkr13trW5X34SqryfC3yDC39agFWSgrn8CF1DG39rCr40
	va1UWry5Xr1rAr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
	3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi, Christoph!

在 2024/03/18 9:51, Yu Kuai 写道:
> Hi,
> 
> 在 2024/03/18 9:32, Christoph Hellwig 写道:
>> On Mon, Mar 18, 2024 at 09:26:48AM +0800, Yu Kuai wrote:
>>> Because there is a real filesystem(devtmpfs) used for raw block devcie
>>> file operations, open syscall to devtmpfs:
>>>
>>> blkdev_open
>>>   bdev = blkdev_get_no_open
>>>   bdev_open -> pass in file is from devtmpfs
>>>   -> in this case, file inode is from devtmpfs,
>>
>> But file->f_mapping->host should still point to the bdevfs inode,
>> and file->f_mapping->host is what everything in the I/O path should
>> be using.
>>
>>> Then later, in blkdev_iomap_begin(), bd_inode is passed in and there is
>>> no access to the devtmpfs file, we can't use s_bdev_file() as other
>>> filesystems here.
>>
>> We can just pass the file down in iomap_iter.private
> 
> I can do this for blkdev_read_folio(), however, for other ops like
> blkdev_writepages(), I can't find a way to pass the file to
> iomap_iter.private yet.
> 
> Any suggestions?

I come up with an ideal:

While opening the block_device the first time, store the generated new
file in "bd_inode->i_private". And release it after the last opener
close the block_device.

The advantages are:
  - multiple openers can share the same bdev_file;
  - raw block device ops can use the bdev_file as well, and there is no
need to distinguish iomap/buffer_head for raw block_device;

Please let me know what do you think?

Thanks,
Kuai
> 
> Thanks,
> Kuai
>> .
>>
> 
> .
> 


