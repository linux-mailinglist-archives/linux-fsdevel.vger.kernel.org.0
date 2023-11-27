Return-Path: <linux-fsdevel+bounces-3930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6D27FA053
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 14:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B67B1C20E0A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 13:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354762D79D;
	Mon, 27 Nov 2023 13:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD1C10F;
	Mon, 27 Nov 2023 05:07:30 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Sf5Tl4wF0z4f3jJ0;
	Mon, 27 Nov 2023 21:07:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 75CE61A0C58;
	Mon, 27 Nov 2023 21:07:26 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgDX2hCKlGRldTJXCA--.14854S3;
	Mon, 27 Nov 2023 21:07:25 +0800 (CST)
Subject: Re: [PATCH block/for-next v2 01/16] block: add a new helper to get
 inode from block_device
To: Christoph Hellwig <hch@infradead.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: ming.lei@redhat.com, axboe@kernel.dk, roger.pau@citrix.com,
 colyli@suse.de, kent.overstreet@gmail.com, joern@lazybastard.org,
 miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
 sth@linux.ibm.com, hoeppner@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, jejb@linux.ibm.com,
 martin.petersen@oracle.com, clm@fb.com, josef@toxicpanda.com,
 dsterba@suse.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
 nico@fluxnic.net, xiang@kernel.org, chao@kernel.org, tytso@mit.edu,
 adilger.kernel@dilger.ca, agruenba@redhat.com, jack@suse.com,
 konishi.ryusuke@gmail.com, dchinner@redhat.com, linux@weissschuh.net,
 min15.li@samsung.com, dlemoal@kernel.org, willy@infradead.org,
 akpm@linux-foundation.org, hare@suse.de, p.raghav@samsung.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-bcachefs@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
 gfs2@lists.linux.dev, linux-nilfs@vger.kernel.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20231127062116.2355129-1-yukuai1@huaweicloud.com>
 <20231127062116.2355129-2-yukuai1@huaweicloud.com>
 <ZWRDeQ4K8BiYnV+X@infradead.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <6acdeece-7163-3219-95e2-827e54eadd0c@huaweicloud.com>
Date: Mon, 27 Nov 2023 21:07:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZWRDeQ4K8BiYnV+X@infradead.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDX2hCKlGRldTJXCA--.14854S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KF1fWFWkJw1kuFy8XF43KFg_yoW8KrWDp3
	y7KFn8tw1DJryFgan7tw1jqrn0g3W7GrWUZ34rZrsxurZ8WFy2qF10krsrXFyIyr48Jw4I
	qF45AF43Xry2grJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_WFyU
	JVCq3wCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26rxl6s0DYx
	BIdaVFxhVjvjDU0xZFpf9x0JUd8n5UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2023/11/27 15:21, Christoph Hellwig Ð´µÀ:
> On Mon, Nov 27, 2023 at 02:21:01PM +0800, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> block_devcie is allocated from bdev_alloc() by bdev_alloc_inode(), and
>> currently block_device contains a pointer that point to the address of
>> inode, while such inode is allocated together:
> 
> This is going the wrong way.  Nothing outside of core block layer code
> should ever directly use the bdev inode.  We've been rather sloppy
> and added a lot of direct reference to it, but they really need to
> go away and be replaced with well defined high level operation on
> struct block_device.  Once that is done we can remove the bd_inode
> pointer, but replacing it with something that pokes even more deeply
> into bdev internals is a bad idea.

Thanks for the advice, however, after collecting how other modules are
using bdev inode, I got two main questions:

1) Is't okay to add a new helper to pass in bdev for following apis?
If so, then almost all the fs and driver can avoid to access bd_inode
dirctly.

errseq_check(&bdev->bd_inode->i_mapping->wb_err, wb_err);
errseq_check_and_advance(&bdev->bd_inode->i_mapping->wb_err, &wb_err);
mapping_gfp_constraint(bdev->bd_inode->i_mapping, gfp);
i_size_read(bdev->bd_inode)
find_get_page(bdev->bd_inode->i_mapping, offset);
find_or_create_page(bdev->bd_inode->i_mapping, index, gfp);
read_cache_page_gfp(bdev->bd_inode->i_mapping, index, gfp);
invalidate_inode_pages2(bdev->bd_inode->i_mapping);
invalidate_inode_pages2_range(bdev->bd_inode->i_mapping, start, end);
read_mapping_folio(bdev->bd_inode->i_mapping, index, file);
read_mapping_page(bdev->bd_inode->i_mapping, index, file);
balance_dirty_pages_ratelimited(bdev->bd_inode->i_mapping)
file_ra_state_init(ra, bdev->bd_inode->i_mapping);
page_cache_sync_readahead(bdev->bd_inode->i_mapping, ra, file, index, 
req_count);
inode_to_bdi(bdev->bd_inode)

2) For the file fs/buffer.c, there are some special usage like
following that I don't think it's good to add a helper:

spin_lock(&bd_inode->i_mapping->private_lock);

Is't okay to move following apis from fs/buffer.c directly to
block/bdev.c?

__find_get_block
bdev_getblk

Thanks,
Kuai

> .
> 


