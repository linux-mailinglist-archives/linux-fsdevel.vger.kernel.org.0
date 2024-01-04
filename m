Return-Path: <linux-fsdevel+bounces-7361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40888824187
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 13:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2F491F2514D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 12:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAC621A03;
	Thu,  4 Jan 2024 12:19:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4F221361;
	Thu,  4 Jan 2024 12:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4T5QcW2wTFz4f3jJK;
	Thu,  4 Jan 2024 20:19:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 266E71A0804;
	Thu,  4 Jan 2024 20:19:09 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBHShA5opZl+60EFg--.63321S3;
	Thu, 04 Jan 2024 20:19:08 +0800 (CST)
Subject: Re: [PATCH RFC v3 for-6.8/block 02/17] xen/blkback: use bdev api in
 xen_update_blkif_status()
To: Jan Kara <jack@suse.cz>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, roger.pau@citrix.com, colyli@suse.de,
 kent.overstreet@gmail.com, joern@lazybastard.org, miquel.raynal@bootlin.com,
 richard@nod.at, vigneshr@ti.com, sth@linux.ibm.com, hoeppner@linux.ibm.com,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 jejb@linux.ibm.com, martin.petersen@oracle.com, clm@fb.com,
 josef@toxicpanda.com, dsterba@suse.com, viro@zeniv.linux.org.uk,
 brauner@kernel.org, nico@fluxnic.net, xiang@kernel.org, chao@kernel.org,
 tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com,
 konishi.ryusuke@gmail.com, willy@infradead.org, akpm@linux-foundation.org,
 hare@suse.de, p.raghav@samsung.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-bcache@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-ext4@vger.kernel.org, linux-nilfs@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20231221085712.1766333-1-yukuai1@huaweicloud.com>
 <20231221085712.1766333-3-yukuai1@huaweicloud.com>
 <20240104110631.3vspsvxbbvcpdqdu@quack3>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <29bfcfc7-62b0-3876-78ce-f7ebe3506eb6@huaweicloud.com>
Date: Thu, 4 Jan 2024 20:19:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240104110631.3vspsvxbbvcpdqdu@quack3>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHShA5opZl+60EFg--.63321S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ur1xtw4fZF13Gr48Wr1rZwb_yoW8WF4rpr
	y7GF48AryDKFWjkFs3Xa1I9Fn3Ka17GrW5urZxA34fXr90qr92gasYy34YgFWxXrn3Jrs2
	qw47XFs3Ary8W3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Wrv_Gr1UMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j
	6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUd8n5UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi, Jan!

ÔÚ 2024/01/04 19:06, Jan Kara Ð´µÀ:
> On Thu 21-12-23 16:56:57, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Avoid to access bd_inode directly, prepare to remove bd_inode from
>> block_devcie.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/block/xen-blkback/xenbus.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
>> index e34219ea2b05..e645afa4af57 100644
>> --- a/drivers/block/xen-blkback/xenbus.c
>> +++ b/drivers/block/xen-blkback/xenbus.c
>> @@ -104,8 +104,7 @@ static void xen_update_blkif_status(struct xen_blkif *blkif)
>>   		xenbus_dev_error(blkif->be->dev, err, "block flush");
>>   		return;
>>   	}
>> -	invalidate_inode_pages2(
>> -			blkif->vbd.bdev_handle->bdev->bd_inode->i_mapping);
>> +	invalidate_bdev(blkif->vbd.bdev_handle->bdev);
> 
> This function uses invalidate_inode_pages2() while invalidate_bdev() ends
> up using mapping_try_invalidate() and there are subtle behavioral
> differences between these two (for example invalidate_inode_pages2() tries
> to clean dirty pages using the ->launder_folio method). So I think you'll
> need helper like invalidate_bdev2() for this.

Thanks for reviewing this patch, I know the differenct between then,
what I don't understand is that why using invalidate_inode_pages2()
here. sync_blockdev() is just called and 0 is returned, I think in this
case it's safe to call invalidate_bdev() directly, or am I missing
other things?

Thanks,
Kuai

> 
> 								Honza
> 


