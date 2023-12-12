Return-Path: <linux-fsdevel+bounces-5607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBC180E0E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 02:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F7721C216C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 01:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCEE20EA;
	Tue, 12 Dec 2023 01:32:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706BACE;
	Mon, 11 Dec 2023 17:32:21 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Sq1Lj3Z6Rz4f3lDc;
	Tue, 12 Dec 2023 09:32:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 5C7FC1A0D83;
	Tue, 12 Dec 2023 09:32:18 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgCn9gwauHdlugyeDQ--.45656S3;
	Tue, 12 Dec 2023 09:32:13 +0800 (CST)
Subject: Re: [PATCH RFC v2 for-6.8/block 15/18] buffer: add a new helper to
 read sb block
To: Jan Kara <jack@suse.cz>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, roger.pau@citrix.com, colyli@suse.de,
 kent.overstreet@gmail.com, joern@lazybastard.org, miquel.raynal@bootlin.com,
 richard@nod.at, vigneshr@ti.com, sth@linux.ibm.com, hoeppner@linux.ibm.com,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 jejb@linux.ibm.com, martin.petersen@oracle.com, clm@fb.com,
 josef@toxicpanda.com, dsterba@suse.com, viro@zeniv.linux.org.uk,
 brauner@kernel.org, nico@fluxnic.net, xiang@kernel.org, chao@kernel.org,
 tytso@mit.edu, adilger.kernel@dilger.ca, agruenba@redhat.com, jack@suse.com,
 konishi.ryusuke@gmail.com, willy@infradead.org, akpm@linux-foundation.org,
 p.raghav@samsung.com, hare@suse.de, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-bcache@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-ext4@vger.kernel.org, gfs2@lists.linux.dev,
 linux-nilfs@vger.kernel.org, yi.zhang@huawei.com,
 "yangerkun@huawei.com" <yangerkun@huawei.com>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20231211140552.973290-1-yukuai1@huaweicloud.com>
 <20231211140753.975297-1-yukuai1@huaweicloud.com>
 <20231211172708.qpuk4rkwq4u2zbmj@quack3>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <be459c50-5179-2748-2636-7965b9e1cb7a@huaweicloud.com>
Date: Tue, 12 Dec 2023 09:32:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231211172708.qpuk4rkwq4u2zbmj@quack3>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCn9gwauHdlugyeDQ--.45656S3
X-Coremail-Antispam: 1UD129KBjvJXoW7trWDZF4Dur4DWFWktF1xGrg_yoW8WF48pr
	ySkayakrZrAr1a9F12qw1rXFyrKa13G3WrCFyfJa4UAryagr13XrWxGF4UGFW3ZrnrAws8
	Xa1FkayrZw15KFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9q14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Wrv_Gr1UMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6rWU
	JVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F
	4UJbIYCTnIWIevJa73UjIFyTuYvjfUFfHUDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2023/12/12 1:27, Jan Kara Ð´µÀ:
> On Mon 11-12-23 22:07:53, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Unlike __bread_gfp(), ext4 has special handing while reading sb block:
>>
>> 1) __GFP_NOFAIL is not set, and memory allocation can fail;
>> 2) If buffer write failed before, set buffer uptodate and don't read
>>     block from disk;
>> 3) REQ_META is set for all IO, and REQ_PRIO is set for reading xattr;
>> 4) If failed, return error ptr instead of NULL;
>>
>> This patch add a new helper __bread_gfp2() that will match above 2 and 3(
>> 1 will be used, and 4 will still be encapsulated by ext4), and prepare to
>> prevent calling mapping_gfp_constraint() directly on bd_inode->i_mapping
>> in ext4.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ...
>> +/*
>> + * This works like __bread_gfp() except:
>> + * 1) If buffer write failed before, set buffer uptodate and don't read
>> + * block from disk;
>> + * 2) Caller can pass in additional op_flags like REQ_META;
>> + */
>> +struct buffer_head *
>> +__bread_gfp2(struct block_device *bdev, sector_t block, unsigned int size,
>> +	     blk_opf_t op_flags, gfp_t gfp)
>> +{
>> +	return bread_gfp(bdev, block, size, op_flags, gfp, true);
>> +}
>> +EXPORT_SYMBOL(__bread_gfp2);
> 
> __bread_gfp2() is not a great name, why not just using bread_gfp()
> directly? I'm not a huge fan of boolean arguments but three different flags
> arguments would be too much for my taste ;) so I guess I can live with
> that.

I agree that __bread_gfp2 is not a greate name, if possible, I'll try to
figure out a better name for v3.

Thanks for reviewing this patchset!
Kuai
> 
> 								Honza
> 


