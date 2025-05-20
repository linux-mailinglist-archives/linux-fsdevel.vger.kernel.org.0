Return-Path: <linux-fsdevel+bounces-49505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2CBABD900
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 15:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A59D54A6AF3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 13:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F8922D9F5;
	Tue, 20 May 2025 13:09:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42D422D4DF;
	Tue, 20 May 2025 13:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747746579; cv=none; b=oBkOu7Fse3W/0hk2MqZ+dT422Awajuwn/4+06hy2igV5iu+TjV8TYNEOu87RlgnBMI5kpG7Z69I/3wdf4qKn3zhiWuiulxecQwJcYzn3e3Iy5sQxBrdE376SKWq2uZjSfrJcfUrB2iIH5rHa2gTTXkw20WUNAMbp9neRrMaUb4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747746579; c=relaxed/simple;
	bh=VFNsbdVe5zZ2mY7Llzl2JOjX/FQfthqpYZy39qlDyJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N/4YhteIfi8b0hWiw+PB7DN1dCBXp/rrQ8hFdydwQRdrGSYLEmF6PKwVOz7y01ZzCt3mA3VNqkcDhccIKy/vHROZ2i2vxvzVthZBsL9eHgB1krgZc/Z7TMAaJw2jOOlqCzvVTCaOZH+UagvPeC/fcS1In06eN9YHlK0RmDCpvN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4b1vyV0WTzz4f3jd9;
	Tue, 20 May 2025 21:09:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1295A1A0359;
	Tue, 20 May 2025 21:09:31 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgD3Wl8IfyxodHfqMw--.47827S3;
	Tue, 20 May 2025 21:09:29 +0800 (CST)
Message-ID: <dbc0ace4-49c4-4a75-9532-1c0774331a54@huaweicloud.com>
Date: Tue, 20 May 2025 21:09:28 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] ext4: enable large folio for regular files
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, willy@infradead.org, tytso@mit.edu,
 adilger.kernel@dilger.ca, yi.zhang@huawei.com, libaokun1@huawei.com,
 yukuai3@huawei.com, yangerkun@huawei.com
References: <20250512063319.3539411-1-yi.zhang@huaweicloud.com>
 <jm6ncwmhhv35ebmqgkfizz2mrzcaapbpcpgsqo5joxvkmx5xfu@rgyukfmyer7d>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <jm6ncwmhhv35ebmqgkfizz2mrzcaapbpcpgsqo5joxvkmx5xfu@rgyukfmyer7d>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3Wl8IfyxodHfqMw--.47827S3
X-Coremail-Antispam: 1UD129KBjvJXoWxtr4fKFWDJF4fAw4rtr13Jwb_yoWxJrWfpr
	yakF43Kr4fW347CwsxCr1YqrWYya18Gr48Xa4fXw10qFyUZF1I9wn7KF4F9a4UArW7Cryx
	JFW7Ar1xWF1YyrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUb
	mii3UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/5/20 4:33, Jan Kara wrote:
> On Mon 12-05-25 14:33:11, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Changes since v1:
>>  - Rebase codes on 6.15-rc6.
>>  - Drop the modifications in block_read_full_folio() which has supported
>>    by commit b72e591f74de ("fs/buffer: remove batching from async
>>    read").
>>  - Fine-tuning patch 6 without modifying the logic.
>>
>> v1: https://lore.kernel.org/linux-ext4/20241125114419.903270-1-yi.zhang@huaweicloud.com/
>>
>> Original Description:
>>
>> Since almost all of the code paths in ext4 have already been converted
>> to use folios, there isn't much additional work required to support
>> large folios. This series completes the remaining work and enables large
>> folios for regular files on ext4, with the exception of fsverity,
>> fscrypt, and data=journal mode.
>>
>> Unlike my other series[1], which enables large folios by converting the
>> buffered I/O path from the classic buffer_head to iomap, this solution
>> is based on the original buffer_head, it primarily modifies the block
>> offset and length calculations within a single folio in the buffer
>> write, buffer read, zero range, writeback, and move extents paths to
>> support large folios, doesn't do further code refactoring and
>> optimization.
>>
>> This series have passed kvm-xfstests in auto mode several times, every
>> thing looks fine, any comments are welcome.
>>
>> About performance:
>>
>> I used the same test script from my iomap series (need to drop the mount
>> opts parameter MOUNT_OPT) [2], run fio tests on the same machine with
>> Intel Xeon Gold 6240 CPU with 400GB system ram, 200GB ramdisk and 4TB
>> nvme ssd disk. Both compared with the base and the IOMAP + large folio
>> changes.
>>
>>  == buffer read ==
>>
>>                 base          iomap+large folio base+large folio
>>  type     bs    IOPS  BW(M/s) IOPS  BW(M/s)     IOPS   BW(M/s)
>>  ----------------------------------------------------------------
>>  hole     4K  | 576k  2253  | 762k  2975(+32%) | 747k  2918(+29%)
>>  hole     64K | 48.7k 3043  | 77.8k 4860(+60%) | 76.3k 4767(+57%)
>>  hole     1M  | 2960  2960  | 4942  4942(+67%) | 4737  4738(+60%)
>>  ramdisk  4K  | 443k  1732  | 530k  2069(+19%) | 494k  1930(+11%)
>>  ramdisk  64K | 34.5k 2156  | 45.6k 2850(+32%) | 41.3k 2584(+20%)
>>  ramdisk  1M  | 2093  2093  | 2841  2841(+36%) | 2585  2586(+24%)
>>  nvme     4K  | 339k  1323  | 364k  1425(+8%)  | 344k  1341(+1%)
>>  nvme     64K | 23.6k 1471  | 25.2k 1574(+7%)  | 25.4k 1586(+8%)
>>  nvme     1M  | 2012  2012  | 2153  2153(+7%)  | 2122  2122(+5%)
>>
>>
>>  == buffer write ==
>>
>>  O: Overwrite; S: Sync; W: Writeback
>>
>>                      base         iomap+large folio    base+large folio
>>  type    O S W bs    IOPS  BW     IOPS  BW(M/s)        IOPS  BW(M/s)
>>  ----------------------------------------------------------------------
>>  cache   N N N 4K  | 417k  1631 | 440k  1719 (+5%)   | 423k  1655 (+2%)
>>  cache   N N N 64K | 33.4k 2088 | 81.5k 5092 (+144%) | 59.1k 3690 (+77%)
>>  cache   N N N 1M  | 2143  2143 | 5716  5716 (+167%) | 3901  3901 (+82%)
>>  cache   Y N N 4K  | 449k  1755 | 469k  1834 (+5%)   | 452k  1767 (+1%)
>>  cache   Y N N 64K | 36.6k 2290 | 82.3k 5142 (+125%) | 67.2k 4200 (+83%)
>>  cache   Y N N 1M  | 2352  2352 | 5577  5577 (+137%  | 4275  4276 (+82%)
>>  ramdisk N N Y 4K  | 365k  1424 | 354k  1384 (-3%)   | 372k  1449 (+2%)
>>  ramdisk N N Y 64K | 31.2k 1950 | 74.2k 4640 (+138%) | 56.4k 3528 (+81%)
>>  ramdisk N N Y 1M  | 1968  1968 | 5201  5201 (+164%) | 3814  3814 (+94%)
>>  ramdisk N Y N 4K  | 9984  39   | 12.9k 51   (+29%)  | 9871  39   (-1%)
>>  ramdisk N Y N 64K | 5936  371  | 8960  560  (+51%)  | 6320  395  (+6%)
>>  ramdisk N Y N 1M  | 1050  1050 | 1835  1835 (+75%)  | 1656  1657 (+58%)
>>  ramdisk Y N Y 4K  | 411k  1609 | 443k  1731 (+8%)   | 441k  1723 (+7%)
>>  ramdisk Y N Y 64K | 34.1k 2134 | 77.5k 4844 (+127%) | 66.4k 4151 (+95%)
>>  ramdisk Y N Y 1M  | 2248  2248 | 5372  5372 (+139%) | 4209  4210 (+87%)
>>  ramdisk Y Y N 4K  | 182k  711  | 186k  730  (+3%)   | 182k  711  (0%)
>>  ramdisk Y Y N 64K | 18.7k 1170 | 34.7k 2171 (+86%)  | 31.5k 1969 (+68%)
>>  ramdisk Y Y N 1M  | 1229  1229 | 2269  2269 (+85%)  | 1943  1944 (+58%)
>>  nvme    N N Y 4K  | 373k  1458 | 387k  1512 (+4%)   | 399k  1559 (+7%)
>>  nvme    N N Y 64K | 29.2k 1827 | 70.9k 4431 (+143%) | 54.3k 3390 (+86%)
>>  nvme    N N Y 1M  | 1835  1835 | 4919  4919 (+168%) | 3658  3658 (+99%)
>>  nvme    N Y N 4K  | 11.7k 46   | 11.7k 46   (0%)    | 11.5k 45   (-1%)
>>  nvme    N Y N 64K | 6453  403  | 8661  541  (+34%)  | 7520  470  (+17%)
>>  nvme    N Y N 1M  | 649   649  | 1351  1351 (+108%) | 885   886  (+37%)
>>  nvme    Y N Y 4K  | 372k  1456 | 433k  1693 (+16%)  | 419k  1637 (+12%)
>>  nvme    Y N Y 64K | 33.0k 2064 | 74.7k 4669 (+126%) | 64.1k 4010 (+94%)
>>  nvme    Y N Y 1M  | 2131  2131 | 5273  5273 (+147%) | 4259  4260 (+100%)
>>  nvme    Y Y N 4K  | 56.7k 222  | 56.4k 220  (-1%)   | 59.4k 232  (+5%)
>>  nvme    Y Y N 64K | 13.4k 840  | 19.4k 1214 (+45%)  | 18.5k 1156 (+38%)
>>  nvme    Y Y N 1M  | 714   714  | 1504  1504 (+111%) | 1319  1320 (+85%)
>>
>> [1] https://lore.kernel.org/linux-ext4/20241022111059.2566137-1-yi.zhang@huaweicloud.com/
>> [2] https://lore.kernel.org/linux-ext4/3c01efe6-007a-4422-ad79-0bad3af281b1@huaweicloud.com/
>>
>> Thanks,
>> Yi.
> 
> The patches look good to me besides that one issue with journal credits. I
> can see Ted has already picked up the patches so this is probably moot but
> still:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks for your review and comments. 😉

Yi.

> 
> 								Honza
>>
>> Zhang Yi (8):
>>   ext4: make ext4_mpage_readpages() support large folios
>>   ext4: make regular file's buffered write path support large folios
>>   ext4: make __ext4_block_zero_page_range() support large folio
>>   ext4/jbd2: convert jbd2_journal_blocks_per_page() to support large
>>     folio
>>   ext4: correct the journal credits calculations of allocating blocks
>>   ext4: make the writeback path support large folios
>>   ext4: make online defragmentation support large folios
>>   ext4: enable large folio for regular file
>>
>>  fs/ext4/ext4.h        |  1 +
>>  fs/ext4/ext4_jbd2.c   |  3 +-
>>  fs/ext4/ext4_jbd2.h   |  4 +--
>>  fs/ext4/extents.c     |  5 +--
>>  fs/ext4/ialloc.c      |  3 ++
>>  fs/ext4/inode.c       | 72 ++++++++++++++++++++++++++++++-------------
>>  fs/ext4/move_extent.c | 11 +++----
>>  fs/ext4/readpage.c    | 28 ++++++++++-------
>>  fs/jbd2/journal.c     |  7 +++--
>>  include/linux/jbd2.h  |  2 +-
>>  10 files changed, 88 insertions(+), 48 deletions(-)
>>
>> -- 
>> 2.46.1
>>


