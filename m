Return-Path: <linux-fsdevel+bounces-32699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BCC9ADE0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 09:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7635B238DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 07:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6E61ABEC2;
	Thu, 24 Oct 2024 07:44:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE501AA7B6;
	Thu, 24 Oct 2024 07:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729755865; cv=none; b=Gv+vG2FagBTt2LsKXEAG5zoABDbr4p9ks2U0K2hEWpi5iyUL1+mKaVJbqNKWbyaAxEjk5pEBOlATerjZ7cdommvmgenY41uLaMQrHV05LVH+k8V+UiC9cZn5kycgMMs2sA52458quFHoyEHhDpHrFOZFQZvwdFJscQ5eKGe1+FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729755865; c=relaxed/simple;
	bh=JJrJEhMuUX5gDukuHS2/1Q0ILLh5H/xfJr+KhmlxVYk=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=aIIHRQhb1nFu0Q8FwCahaUUdfZSKSYyfqEOZSKxuu8fHnTxn1OgA8gk8oZ/+2OlkUDCiseNS/IoOoldc52vQNKyaqcIHBl5GtWG9szOE29f3IlDhc+gYVHLs/tmxr41ehFrDb2+7g46r4iUO+CULte1FUMivfwKAdHdiLVAu3jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XYybD1sPqz4f3jXy;
	Thu, 24 Oct 2024 15:43:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id AB3DD1A0194;
	Thu, 24 Oct 2024 15:44:09 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgCn28fE+hlnInrkEw--.34099S3;
	Thu, 24 Oct 2024 15:44:05 +0800 (CST)
Content-Type: multipart/mixed; boundary="------------x68ltKirQTg7GPL6eROhODRd"
Message-ID: <3c01efe6-007a-4422-ad79-0bad3af281b1@huaweicloud.com>
Date: Thu, 24 Oct 2024 15:44:03 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/27] ext4: use iomap for regular file's buffered I/O
 path and enable large folio
To: sedat.dilek@gmail.com
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 jack@suse.cz, ritesh.list@gmail.com, hch@infradead.org, djwong@kernel.org,
 david@fromorbit.com, zokeefe@google.com, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
References: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
 <CA+icZUWKGBKOxEaSUJv4up46b0i8=R-RgbnpHEV20HC_210syw@mail.gmail.com>
 <bf6dcc97-a204-473c-9e25-54db430e9a58@huaweicloud.com>
 <CA+icZUWjruYjiBVgV_-a6dMgovRRdRpWpfU=9Ly1bFcD8i=XLw@mail.gmail.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <CA+icZUWjruYjiBVgV_-a6dMgovRRdRpWpfU=9Ly1bFcD8i=XLw@mail.gmail.com>
X-CM-TRANSID:gCh0CgCn28fE+hlnInrkEw--.34099S3
X-Coremail-Antispam: 1UD129KBjvAXoWfJr47Jr1rCw1fCw4kJF4xWFg_yoW8Jr17Co
	WfZa17Z3W0qryUJF4vka4DX34UW3WkWr18WrW8urZ8Ga4aqay5ury7Cw47WayftF1rCr4U
	C34rCas8CrWUX3Z8n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYG7kC6x804xWl14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wASzI0EjI02j7AqF2xKxwAq
	x4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14
	v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACY4xI67k04243AVC2
	0s07M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1go7tUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

This is a multi-part message in MIME format.
--------------x68ltKirQTg7GPL6eROhODRd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/10/23 20:13, Sedat Dilek wrote:
> On Tue, Oct 22, 2024 at 11:22 AM Zhang Yi <yi.zhang@huaweicloud.com> wrote:
>>
>> On 2024/10/22 14:59, Sedat Dilek wrote:
>>> On Tue, Oct 22, 2024 at 5:13 AM Zhang Yi <yi.zhang@huaweicloud.com> wrote:
>>>>
>>>> From: Zhang Yi <yi.zhang@huawei.com>
>>>>
>>>> Hello！
>>>>
>>>> This patch series is the latest version based on my previous RFC
>>>> series[1], which converts the buffered I/O path of ext4 regular files to
>>>> iomap and enables large folios. After several months of work, almost all
>>>> preparatory changes have been upstreamed, thanks a lot for the review
>>>> and comments from Jan, Dave, Christoph, Darrick and Ritesh. Now it is
>>>> time for the main implementation of this conversion.
>>>>
>>>> This series is the main part of iomap buffered iomap conversion, it's
>>>> based on 6.12-rc4, and the code context is also depend on my anohter
>>>> cleanup series[1] (I've put that in this seris so we can merge it
>>>> directly), fixed all minor bugs found in my previous RFC v4 series.
>>>> Additionally, I've update change logs in each patch and also includes
>>>> some code modifications as Dave's suggestions. This series implements
>>>> the core iomap APIs on ext4 and introduces a mount option called
>>>> "buffered_iomap" to enable the iomap buffered I/O path. We have already
>>>> supported the default features, default mount options and bigalloc
>>>> feature. However, we do not yet support online defragmentation, inline
>>>> data, fs_verify, fs_crypt, ext3, and data=journal mode, ext4 will fall
>>>> to buffered_head I/O path automatically if you use those features and
>>>> options. Some of these features should be supported gradually in the
>>>> near future.
>>>>
>>>> Most of the implementations resemble the original buffered_head path;
>>>> however, there are four key differences.
>>>>
>>>> 1. The first aspect is the block allocation in the writeback path. The
>>>>    iomap frame will invoke ->map_blocks() at least once for each dirty
>>>>    folio. To ensure optimal writeback performance, we aim to allocate a
>>>>    range of delalloc blocks that is as long as possible within the
>>>>    writeback length for each invocation. In certain situations, we may
>>>>    allocate a range of blocks that exceeds the amount we will actually
>>>>    write back. Therefore,
>>>> 1) we cannot allocate a written extent for those blocks because it may
>>>>    expose stale data in such short write cases. Instead, we should
>>>>    allocate an unwritten extent, which means we must always enable the
>>>>    dioread_nolock option. This change could also bring many other
>>>>    benefits.
>>>> 2) We should postpone updating the 'i_disksize' until the end of the I/O
>>>>    process, based on the actual written length. This approach can also
>>>>    prevent the exposure of zero data, which may occur if there is a
>>>>    power failure during an append write.
>>>> 3) We do not need to pre-split extents during write-back, we can
>>>>    postpone this task until the end I/O process while converting
>>>>    unwritten extents.
>>>>
>>>> 2. The second reason is that since we always allocate unwritten space
>>>>    for new blocks, there is no risk of exposing stale data. As a result,
>>>>    we do not need to order the data, which allows us to disable the
>>>>    data=ordered mode. Consequently, we also do not require the reserved
>>>>    handle when converting the unwritten extent in the final I/O worker,
>>>>    we can directly start with the normal handle.
>>>>
>>>> Series details:
>>>>
>>>> Patch 1-10 is just another series of mine that refactors the fallocate
>>>> functions[1]. This series relies on the code context of that but has no
>>>> logical dependencies. I put this here just for easy access and merge.
>>>>
>>>> Patch 11-21 implement the iomap buffered read/write path, dirty folio
>>>> write back path and mmap path for ext4 regular file.
>>>>
>>>> Patch 22-23 disable the unsupported online-defragmentation function and
>>>> disable the changing of the inode journal flag to data=journal mode.
>>>> Please look at the following patch for details.
>>>>
>>>> Patch 24-27 introduce "buffered_iomap" mount option (is not enabled by
>>>> default now) to partially enable the iomap buffered I/O path and also
>>>> enable large folio.
>>>>
>>>>
>>>> About performance:
>>>>
>>>> Fio tests with psync on my machine with Intel Xeon Gold 6240 CPU with
>>>> 400GB system ram, 200GB ramdisk and 4TB nvme ssd disk.
>>>>
>>>>  fio -directory=/mnt -direct=0 -iodepth=$iodepth -fsync=$sync -rw=$rw \
>>>>      -numjobs=${numjobs} -bs=${bs} -ioengine=psync -size=$size \
>>>>      -runtime=60 -norandommap=0 -fallocate=none -overwrite=$overwrite \
>>>>      -group_reportin -name=$name --output=/tmp/test_log
>>>>
>>>
>>> Hi Zhang Yi,
>>>
>>> can you clarify about the FIO values for the diverse parameters?
>>>
>>
>> Hi Sedat,
>>
>> Sure, the test I present here is a simple single-thread and single-I/O
>> depth case with psync ioengine. Most of the FIO parameters are shown
>> in the tables below.
>>
> 
> Hi Zhang Yi,
> 
> Thanks for your reply.
> 
> Can you share a FIO config file with all (relevant) settings?
> Maybe it is in the below link?
> 
> Link: https://packages.debian.org/sid/all/fio-examples/filelist

No, I didn't have this configuration file. I simply wrote two straightforward
scripts to do this test. This serves as a reference, primarily used for
performance analysis in basic read/write operations with different backends.
More complex cases should be adjusted based on the actual circumstances.

I have attached the scripts, feel free to use them. I suggest adjusting the
parameters according to your machine configuration and service I/O model.

> 
>> For the rest, the 'iodepth' and 'numjobs' are always set to 1 and the
>> 'size' is 40GB. During the write cache test, I also disable the write
>> back process through:
>>
>>  echo 0 > /proc/sys/vm/dirty_writeback_centisecs
>>  echo 100 > /proc/sys/vm/dirty_background_ratio
>>  echo 100 > /proc/sys/vm/dirty_ratio
>>
> 
> ^^ Ist this info in one of the patches? If not - can you add this info
> to the next version's cover-letter?
> 
> The patchset and improvements are valid only for powerful servers or
> has a notebook user any benefits of this?

The performance improvement is primarily attributed to the cost savings of
the kernel software stack with large I/O. Therefore, when the CPU becomes a
bottleneck, performance should improves, i.e. the faster the disk, the more
pronounced the benefits, regardless of whether the system is a server or a
notebook.

Thanks,
Yi.

> If you have benchmark data, please share this.
> 
> I can NOT promise if I will give that patchset a try.
> 
> Best thanks.
> 
> Best regards,
> -Sedat-
> 
>> Thanks,
>> Yi.
>>
>>>
>>>>  == buffer read ==
>>>>
>>>>                 buffer_head        iomap + large folio
>>>>  type     bs    IOPS    BW(MiB/s)  IOPS    BW(MiB/s)
>>>>  -------------------------------------------------------
>>>>  hole     4K    576k    2253       762k    2975     +32%
>>>>  hole     64K   48.7k   3043       77.8k   4860     +60%
>>>>  hole     1M    2960    2960       4942    4942     +67%
>>>>  ramdisk  4K    443k    1732       530k    2069     +19%
>>>>  ramdisk  64K   34.5k   2156       45.6k   2850     +32%
>>>>  ramdisk  1M    2093    2093       2841    2841     +36%
>>>>  nvme     4K    339k    1323       364k    1425     +8%
>>>>  nvme     64K   23.6k   1471       25.2k   1574     +7%
>>>>  nvme     1M    2012    2012       2153    2153     +7%
>>>>
>>>>
>>>>  == buffer write ==
>>>>
>>>>                                        buffer_head  iomap + large folio
>>>>  type   Overwrite Sync Writeback  bs   IOPS   BW    IOPS   BW(MiB/s)
>>>>  ----------------------------------------------------------------------
>>>>  cache      N    N    N    4K     417k    1631    440k    1719   +5%
>>>>  cache      N    N    N    64K    33.4k   2088    81.5k   5092   +144%
>>>>  cache      N    N    N    1M     2143    2143    5716    5716   +167%
>>>>  cache      Y    N    N    4K     449k    1755    469k    1834   +5%
>>>>  cache      Y    N    N    64K    36.6k   2290    82.3k   5142   +125%
>>>>  cache      Y    N    N    1M     2352    2352    5577    5577   +137%
>>>>  ramdisk    N    N    Y    4K     365k    1424    354k    1384   -3%
>>>>  ramdisk    N    N    Y    64K    31.2k   1950    74.2k   4640   +138%
>>>>  ramdisk    N    N    Y    1M     1968    1968    5201    5201   +164%
>>>>  ramdisk    N    Y    N    4K     9984    39      12.9k   51     +29%
>>>>  ramdisk    N    Y    N    64K    5936    371     8960    560    +51%
>>>>  ramdisk    N    Y    N    1M     1050    1050    1835    1835   +75%
>>>>  ramdisk    Y    N    Y    4K     411k    1609    443k    1731   +8%
>>>>  ramdisk    Y    N    Y    64K    34.1k   2134    77.5k   4844   +127%
>>>>  ramdisk    Y    N    Y    1M     2248    2248    5372    5372   +139%
>>>>  ramdisk    Y    Y    N    4K     182k    711     186k    730    +3%
>>>>  ramdisk    Y    Y    N    64K    18.7k   1170    34.7k   2171   +86%
>>>>  ramdisk    Y    Y    N    1M     1229    1229    2269    2269   +85%
>>>>  nvme       N    N    Y    4K     373k    1458    387k    1512   +4%
>>>>  nvme       N    N    Y    64K    29.2k   1827    70.9k   4431   +143%
>>>>  nvme       N    N    Y    1M     1835    1835    4919    4919   +168%
>>>>  nvme       N    Y    N    4K     11.7k   46      11.7k   46      0%
>>>>  nvme       N    Y    N    64K    6453    403     8661    541    +34%
>>>>  nvme       N    Y    N    1M     649     649     1351    1351   +108%
>>>>  nvme       Y    N    Y    4K     372k    1456    433k    1693   +16%
>>>>  nvme       Y    N    Y    64K    33.0k   2064    74.7k   4669   +126%
>>>>  nvme       Y    N    Y    1M     2131    2131    5273    5273   +147%
>>>>  nvme       Y    Y    N    4K     56.7k   222     56.4k   220    -1%
>>>>  nvme       Y    Y    N    64K    13.4k   840     19.4k   1214   +45%
>>>>  nvme       Y    Y    N    1M     714     714     1504    1504   +111%
>>>>
>>>> Thanks,
>>>> Yi.
>>>>
>>>> Major changes since RFC v4:
>>>>  - Disable unsupported online defragmentation, do not fall back to
>>>>    buffer_head path.
>>>>  - Wite and wait data back while doing partial block truncate down to
>>>>    fix a stale data problem.
>>>>  - Disable the online changing of the inode journal flag to data=journal
>>>>    mode.
>>>>  - Since iomap can zero out dirty pages with unwritten extent, do not
>>>>    write data before zeroing out in ext4_zero_range(), and also do not
>>>>    zero partial blocks under a started journal handle.
>>>>
>>>> [1] https://lore.kernel.org/linux-ext4/20241010133333.146793-1-yi.zhang@huawei.com/
>>>>
>>>> ---
>>>> RFC v4: https://lore.kernel.org/linux-ext4/20240410142948.2817554-1-yi.zhang@huaweicloud.com/
>>>> RFC v3: https://lore.kernel.org/linux-ext4/20240127015825.1608160-1-yi.zhang@huaweicloud.com/
>>>> RFC v2: https://lore.kernel.org/linux-ext4/20240102123918.799062-1-yi.zhang@huaweicloud.com/
>>>> RFC v1: https://lore.kernel.org/linux-ext4/20231123125121.4064694-1-yi.zhang@huaweicloud.com/
>>>>
>>>>
>>>> Zhang Yi (27):
>>>>   ext4: remove writable userspace mappings before truncating page cache
>>>>   ext4: don't explicit update times in ext4_fallocate()
>>>>   ext4: don't write back data before punch hole in nojournal mode
>>>>   ext4: refactor ext4_punch_hole()
>>>>   ext4: refactor ext4_zero_range()
>>>>   ext4: refactor ext4_collapse_range()
>>>>   ext4: refactor ext4_insert_range()
>>>>   ext4: factor out ext4_do_fallocate()
>>>>   ext4: move out inode_lock into ext4_fallocate()
>>>>   ext4: move out common parts into ext4_fallocate()
>>>>   ext4: use reserved metadata blocks when splitting extent on endio
>>>>   ext4: introduce seq counter for the extent status entry
>>>>   ext4: add a new iomap aops for regular file's buffered IO path
>>>>   ext4: implement buffered read iomap path
>>>>   ext4: implement buffered write iomap path
>>>>   ext4: don't order data for inode with EXT4_STATE_BUFFERED_IOMAP
>>>>   ext4: implement writeback iomap path
>>>>   ext4: implement mmap iomap path
>>>>   ext4: do not always order data when partial zeroing out a block
>>>>   ext4: do not start handle if unnecessary while partial zeroing out a
>>>>     block
>>>>   ext4: implement zero_range iomap path
>>>>   ext4: disable online defrag when inode using iomap buffered I/O path
>>>>   ext4: disable inode journal mode when using iomap buffered I/O path
>>>>   ext4: partially enable iomap for the buffered I/O path of regular
>>>>     files
>>>>   ext4: enable large folio for regular file with iomap buffered I/O path
>>>>   ext4: change mount options code style
>>>>   ext4: introduce a mount option for iomap buffered I/O path
>>>>
>>>>  fs/ext4/ext4.h              |  17 +-
>>>>  fs/ext4/ext4_jbd2.c         |   3 +-
>>>>  fs/ext4/ext4_jbd2.h         |   8 +
>>>>  fs/ext4/extents.c           | 568 +++++++++++----------------
>>>>  fs/ext4/extents_status.c    |  13 +-
>>>>  fs/ext4/file.c              |  19 +-
>>>>  fs/ext4/ialloc.c            |   5 +
>>>>  fs/ext4/inode.c             | 755 ++++++++++++++++++++++++++++++------
>>>>  fs/ext4/move_extent.c       |   7 +
>>>>  fs/ext4/page-io.c           | 105 +++++
>>>>  fs/ext4/super.c             | 185 ++++-----
>>>>  include/trace/events/ext4.h |  57 +--
>>>>  12 files changed, 1153 insertions(+), 589 deletions(-)
>>>>
>>>> --
>>>> 2.46.1
>>>>
>>>>
>>

--------------x68ltKirQTg7GPL6eROhODRd
Content-Type: text/plain; charset=UTF-8; name="ext4_iomap_test_read.sh"
Content-Disposition: attachment; filename="ext4_iomap_test_read.sh"
Content-Transfer-Encoding: base64

IyEvYmluL2Jhc2gKCnJhbWRldj0kMQpudm1lZGV2PSQyCgpNT1VOVF9PUFQ9IiIKdGVzdF9z
aXplPTQwRwoKZnVuY3Rpb24gcnVuX2ZpbygpCnsKCWxvY2FsIHJ3PXJlYWQKCWxvY2FsIHN5
bmM9JDEKCWxvY2FsIGJzPSQyCglsb2NhbCBpb2RlcHRoPSQzCglsb2NhbCBudW1qb2JzPSQ0
Cglsb2NhbCBvdmVyd3JpdGU9JDUKCWxvY2FsIG5hbWU9MQoJbG9jYWwgc2l6ZT0kNgoKCWZp
byAtZGlyZWN0b3J5PS9tbnQgLWRpcmVjdD0wIC1pb2RlcHRoPSRpb2RlcHRoIC1mc3luYz0k
c3luYyAtcnc9JHJ3IFwKCSAgICAtbnVtam9icz0ke251bWpvYnN9IC1icz0ke2JzfSAtaW9l
bmdpbmU9cHN5bmMgLXNpemU9JHNpemUgXAoJICAgIC1ydW50aW1lPTYwIC1ub3JhbmRvbW1h
cD0wIC1mYWxsb2NhdGU9bm9uZSAtb3ZlcndyaXRlPSRvdmVyd3JpdGUgXAoJICAgIC1ncm91
cF9yZXBvcnRpbiAtbmFtZT0kbmFtZSAtLW91dHB1dD0vdG1wL2xvZwoKCWNhdCAvdG1wL2xv
ZyA+PiAvdG1wL2Zpb19yZXN1bHQKfQoKZnVuY3Rpb24gaW5pdF9lbnYoKQp7Cglsb2NhbCBo
b2xlPSQxCglsb2NhbCBzaXplPSQyCglsb2NhbCBkZXY9JDMKCglybSAtcmYgL21udC8qCgoJ
aWYgW1sgIiRob2xlIiA9PSAiMSIgXV07IHRoZW4KCQl0cnVuY2F0ZSAtcyAkc2l6ZSAvbW50
LzEuMC4wCgllbHNlCgkJeGZzX2lvIC1mIC1jICJwd3JpdGUgMCAkc2l6ZSIgL21udC8xLjAu
MAoJZmkKCgl1bW91bnQgL21udAoJbW91bnQgLW8gJE1PVU5UX09QVCAkZGV2IC9tbnQKfQoK
ZnVuY3Rpb24gcmVzZXRfZW52KCkKewoJbG9jYWwgZGV2PSQxCgoJdW1vdW50IC9tbnQKCW1v
dW50IC1vICRNT1VOVF9PUFQgJGRldiAvbW50Cn0KCmZ1bmN0aW9uIGRvX29uZV90ZXN0KCkK
ewoJbG9jYWwgc3luYz0wCglsb2NhbCBob2xlPSQxCglsb2NhbCBzaXplPSQyCglsb2NhbCBk
ZXY9JDMKCgllY2hvICItLS0tLS0tLS0tLS0tLS0tLS0tIiB8IHRlZSAtYSAvdG1wL2Zpb19y
ZXN1bHQKCgllY2hvICI9PT0gNEs6IiB8IHRlZSAtYSAvdG1wL2Zpb19yZXN1bHQKCXJlc2V0
X2VudiAkZGV2CglydW5fZmlvICRzeW5jIDRrIDEgMSAwICRzaXplCgoJZWNobyAiPT09IDY0
SzoiIHwgdGVlIC1hIC90bXAvZmlvX3Jlc3VsdAoJcmVzZXRfZW52ICRkZXYKCXJ1bl9maW8g
JHN5bmMgNjRrIDEgMSAwICRzaXplCgoJZWNobyAiPT09IDFNOiIgfCB0ZWUgLWEgL3RtcC9m
aW9fcmVzdWx0CglyZXNldF9lbnYgJGRldgoJcnVuX2ZpbyAkc3luYyAxTSAxIDEgMCAkc2l6
ZQoKCWVjaG8gIi0tLS0tLS0tLS0tLS0tLS0tLS0iIHwgdGVlIC1hIC90bXAvZmlvX3Jlc3Vs
dAp9CgpmdW5jdGlvbiBydW5fb25lX3JvdW5kKCkKewoJbG9jYWwgaG9sZT0kMQoJbG9jYWwg
c2l6ZT0kMgoJbG9jYWwgZGV2PSQzCgoJaW5pdF9lbnYgJGhvbGUgJHNpemUgJGRldgoJZG9f
b25lX3Rlc3QgJGhvbGUgJHNpemUgJGRldgp9CgpmdW5jdGlvbiBydW5fdGVzdCgpCnsKCWVj
aG8gIi0tLS0gVEVTVCBSQU1ERVYgLS0tLSIgfCB0ZWUgLWEgL3RtcC9maW9fcmVzdWx0Cglt
b3VudCAtbyAkTU9VTlRfT1BUICRyYW1kZXYgL21udAoKCWVjaG8gIi0tLS0tIDEuIFJFQUQg
SE9MRSIgfCB0ZWUgLWEgL3RtcC9maW9fcmVzdWx0CglydW5fb25lX3JvdW5kIDEgJHRlc3Rf
c2l6ZSAkcmFtZGV2CgoJZWNobyAiLS0tLS0gMi4gUkVBRCBSQU0gREFUQSIgfCB0ZWUgLWEg
L3RtcC9maW9fcmVzdWx0CglydW5fb25lX3JvdW5kIDAgJHRlc3Rfc2l6ZSAkcmFtZGV2Cgl1
bW91bnQgL21udAoKCWVjaG8gIi0tLS0gVEVTVCBOVk1FREVWIC0tLS0iIHwgdGVlIC1hIC90
bXAvZmlvX3Jlc3VsdAoJZWNobyAiLS0tLS0gMy4gUkVBRCBOVk1FIERBVEEiIHwgdGVlIC1h
IC90bXAvZmlvX3Jlc3VsdAoJbW91bnQgLW8gJE1PVU5UX09QVCAkbnZtZWRldiAvbW50Cgly
dW5fb25lX3JvdW5kIDAgJHRlc3Rfc2l6ZSAkbnZtZWRldgoJdW1vdW50IC9tbnQKfQoKaWYg
WyAteiAiJHJhbWRldiIgXSB8fCBbIC16ICIkbnZtZWRldiIgXTsgdGhlbgoJZWNobyAiJDAg
PHJhbWRldj4gPG52bWVkZXY+IgoJZXhpdApmaQoKdW1vdW50IC9tbnQKbWtmcy5leHQ0IC1F
IGxhenlfaXRhYmxlX2luaXQ9MCxsYXp5X2pvdXJuYWxfaW5pdD0wIC1GICRyYW1kZXYKbWtm
cy5leHQ0IC1FIGxhenlfaXRhYmxlX2luaXQ9MCxsYXp5X2pvdXJuYWxfaW5pdD0wIC1GICRu
dm1lZGV2CgpjcCAvdG1wL2Zpb19yZXN1bHQgL3RtcC9maW9fcmVzdWx0Lm9sZApybSAtZiAv
dG1wL2Zpb19yZXN1bHQKCiMjIFRFU1QgYmFzZSByYW1kZXYKZWNobyAiPT09PSBURVNUIEJB
U0UgPT09PSIgfCB0ZWUgLWEgL3RtcC9maW9fcmVzdWx0Ck1PVU5UX09QVD0ibm9idWZmZXJl
ZF9pb21hcCIKcnVuX3Rlc3QKCiMjIFRFU1QgaW9tYXAgcmFtZGV2CmVjaG8gIj09PT0gVEVT
VCBJT01BUCA9PT09IiB8IHRlZSAtYSAvdG1wL2Zpb19yZXN1bHQKTU9VTlRfT1BUPSJidWZm
ZXJlZF9pb21hcCIKcnVuX3Rlc3QK
--------------x68ltKirQTg7GPL6eROhODRd
Content-Type: text/plain; charset=UTF-8; name="ext4_iomap_test_write.sh"
Content-Disposition: attachment; filename="ext4_iomap_test_write.sh"
Content-Transfer-Encoding: base64

IyEvYmluL2Jhc2gKCnJhbWRldj0kMQpudm1lZGV2PSQyCgpNT1VOVF9PUFQ9IiIKdGVzdF9z
aXplPTQwRwoKZnVuY3Rpb24gcnVuX2ZpbygpCnsKCWxvY2FsIHJ3PXdyaXRlCglsb2NhbCBz
eW5jPSQxCglsb2NhbCBicz0kMgoJbG9jYWwgaW9kZXB0aD0kMwoJbG9jYWwgbnVtam9icz0k
NAoJbG9jYWwgb3ZlcndyaXRlPSQ1Cglsb2NhbCBuYW1lPTEKCWxvY2FsIHNpemU9JDYKCglm
aW8gLWRpcmVjdG9yeT0vbW50IC1kaXJlY3Q9MCAtaW9kZXB0aD0kaW9kZXB0aCAtZnN5bmM9
JHN5bmMgLXJ3PSRydyBcCgkgICAgLW51bWpvYnM9JHtudW1qb2JzfSAtYnM9JHtic30gLWlv
ZW5naW5lPXBzeW5jIC1zaXplPSRzaXplIFwKCSAgICAtcnVudGltZT02MCAtbm9yYW5kb21t
YXA9MCAtZmFsbG9jYXRlPW5vbmUgLW92ZXJ3cml0ZT0kb3ZlcndyaXRlIFwKCSAgICAtZ3Jv
dXBfcmVwb3J0aW4gLW5hbWU9JG5hbWUgLS1vdXRwdXQ9L3RtcC9sb2cKCgljYXQgL3RtcC9s
b2cgPj4gL3RtcC9maW9fcmVzdWx0Cn0KCmZ1bmN0aW9uIGluaXRfZW52KCkKewoJbG9jYWwg
ZGV2PSQxCgoJcm0gLXJmIC9tbnQvKgoJdW1vdW50IC9tbnQKCW1vdW50IC1vICRNT1VOVF9P
UFQgJGRldiAvbW50Cn0KCmZ1bmN0aW9uIHJlc2V0X2VudigpCnsKCWxvY2FsIG92ZXJ3cml0
ZT0kMQoJbG9jYWwgZGV2PSQyCgoJaWYgW1sgIiRvdmVyd3JpdGUiID09ICIwIiBdXTsgdGhl
bgoJCXJtIC1yZiAvbW50LyoKCWZpCgl1bW91bnQgL21udAoJbW91bnQgLW8gJE1PVU5UX09Q
VCAkZGV2IC9tbnQKfQoKZnVuY3Rpb24gZG9fb25lX3Rlc3QoKQp7Cglsb2NhbCBzeW5jPSQx
Cglsb2NhbCBvdmVyd3JpdGU9JDIKCWxvY2FsIHNpemU9JDMKCWxvY2FsIGRldj0kNAoKCWVj
aG8gIi0tLS0tLS0tLS0tLS0tLS0tLS0iIHwgdGVlIC1hIC90bXAvZmlvX3Jlc3VsdAoKCWVj
aG8gIj09PSA0SzoiIHwgdGVlIC1hIC90bXAvZmlvX3Jlc3VsdAoJcmVzZXRfZW52ICRvdmVy
d3JpdGUgJGRldgoJcnVuX2ZpbyAkc3luYyA0ayAxIDEgJG92ZXJ3cml0ZSAkc2l6ZQoKCWVj
aG8gIj09PSA2NEs6IiB8IHRlZSAtYSAvdG1wL2Zpb19yZXN1bHQKCXJlc2V0X2VudiAkb3Zl
cndyaXRlICRkZXYKCXJ1bl9maW8gJHN5bmMgNjRrIDEgMSAkb3ZlcndyaXRlICRzaXplCgoJ
ZWNobyAiPT09IDFNOiIgfCB0ZWUgLWEgL3RtcC9maW9fcmVzdWx0CglyZXNldF9lbnYgJG92
ZXJ3cml0ZSAkZGV2CglydW5fZmlvICRzeW5jIDFNIDEgMSAkb3ZlcndyaXRlICRzaXplCgoJ
ZWNobyAiLS0tLS0tLS0tLS0tLS0tLS0tLSIgfCB0ZWUgLWEgL3RtcC9maW9fcmVzdWx0Cn0K
CmZ1bmN0aW9uIHJ1bl9vbmVfcm91bmQoKQp7Cglsb2NhbCBzeW5jPSQxCglsb2NhbCBvdmVy
d3JpdGU9JDIKCWxvY2FsIHNpemU9JDMKCWxvY2FsIGRldj0kNAoKCWVjaG8gIlN5bmM6JHN5
bmMsIE92ZXJ3cml0ZTokb3ZlcndyaXRlIiB8IHRlZSAtYSAvdG1wL2Zpb19yZXN1bHQKCWlu
aXRfZW52ICRkZXYKCWRvX29uZV90ZXN0ICRzeW5jICRvdmVyd3JpdGUgJHNpemUgJGRldgp9
CgpmdW5jdGlvbiBydW5fdGVzdCgpCnsKCWVjaG8gIi0tLS0gVEVTVCBSQU1ERVYgLS0tLSIg
fCB0ZWUgLWEgL3RtcC9maW9fcmVzdWx0Cgltb3VudCAtbyAkTU9VTlRfT1BUICRyYW1kZXYg
L21udAoKCWVjaG8gIi0tLS0tIDEuIFdSSVRFIENBQ0hFIiB8IHRlZSAtYSAvdG1wL2Zpb19y
ZXN1bHQKCSMgU3RvcCB3cml0ZWJhY2sKCWVjaG8gMCA+IC9wcm9jL3N5cy92bS9kaXJ0eV93
cml0ZWJhY2tfY2VudGlzZWNzCgllY2hvIDMwMDAwID4gL3Byb2Mvc3lzL3ZtL2RpcnR5X2V4
cGlyZV9jZW50aXNlY3MKCWVjaG8gMTAwID4gL3Byb2Mvc3lzL3ZtL2RpcnR5X2JhY2tncm91
bmRfcmF0aW8KCWVjaG8gMTAwID4gL3Byb2Mvc3lzL3ZtL2RpcnR5X3JhdGlvCglydW5fb25l
X3JvdW5kIDAgMCAkdGVzdF9zaXplICRyYW1kZXYKCXJ1bl9vbmVfcm91bmQgMCAxICR0ZXN0
X3NpemUgJHJhbWRldgoKCWVjaG8gIi0tLS0tIDIuIFdSSVRFIFJBTSBESVNLIiB8IHRlZSAt
YSAvdG1wL2Zpb19yZXN1bHQKCSMgUmVzdG9yZSB3cml0ZWJhY2sKCWVjaG8gNTAwID4gL3By
b2Mvc3lzL3ZtL2RpcnR5X3dyaXRlYmFja19jZW50aXNlY3MKCWVjaG8gMzAwMCA+IC9wcm9j
L3N5cy92bS9kaXJ0eV9leHBpcmVfY2VudGlzZWNzCgllY2hvIDEwID4gL3Byb2Mvc3lzL3Zt
L2RpcnR5X2JhY2tncm91bmRfcmF0aW8KCWVjaG8gMjAgPiAvcHJvYy9zeXMvdm0vZGlydHlf
cmF0aW8KCXJ1bl9vbmVfcm91bmQgMCAwICR0ZXN0X3NpemUgJHJhbWRldgoJcnVuX29uZV9y
b3VuZCAwIDEgJHRlc3Rfc2l6ZSAkcmFtZGV2CglydW5fb25lX3JvdW5kIDEgMCAkdGVzdF9z
aXplICRyYW1kZXYKCXJ1bl9vbmVfcm91bmQgMSAxICR0ZXN0X3NpemUgJHJhbWRldgoJdW1v
dW50IC9tbnQKCgllY2hvICItLS0tIFRFU1QgTlZNRURFViAtLS0tIiB8IHRlZSAtYSAvdG1w
L2Zpb19yZXN1bHQKCWVjaG8gIi0tLS0tIDMuIFdSSVRFIE5WTUUgRElTSyIgfCB0ZWUgLWEg
L3RtcC9maW9fcmVzdWx0Cgltb3VudCAtbyAkTU9VTlRfT1BUICRudm1lZGV2IC9tbnQKCXJ1
bl9vbmVfcm91bmQgMCAwICR0ZXN0X3NpemUgJG52bWVkZXYKCXJ1bl9vbmVfcm91bmQgMCAx
ICR0ZXN0X3NpemUgJG52bWVkZXYKCXJ1bl9vbmVfcm91bmQgMSAwICR0ZXN0X3NpemUgJG52
bWVkZXYKCXJ1bl9vbmVfcm91bmQgMSAxICR0ZXN0X3NpemUgJG52bWVkZXYKCXVtb3VudCAv
bW50Cn0KCmlmIFsgLXogIiRyYW1kZXYiIF0gfHwgWyAteiAiJG52bWVkZXYiIF07IHRoZW4K
CWVjaG8gIiQwIDxyYW1kZXY+IDxudm1lZGV2PiIKCWV4aXQKZmkKCnVtb3VudCAvbW50Cm1r
ZnMuZXh0NCAtRSBsYXp5X2l0YWJsZV9pbml0PTAsbGF6eV9qb3VybmFsX2luaXQ9MCAtRiAk
cmFtZGV2Cm1rZnMuZXh0NCAtRSBsYXp5X2l0YWJsZV9pbml0PTAsbGF6eV9qb3VybmFsX2lu
aXQ9MCAtRiAkbnZtZWRldgoKY3AgL3RtcC9maW9fcmVzdWx0IC90bXAvZmlvX3Jlc3VsdC5v
bGQKcm0gLWYgL3RtcC9maW9fcmVzdWx0CgojIyBURVNUIGJhc2UKZWNobyAiPT09PSBURVNU
IEJBU0UgPT09PSIgfCB0ZWUgLWEgL3RtcC9maW9fcmVzdWx0Ck1PVU5UX09QVD0ibm9idWZm
ZXJlZF9pb21hcCIKcnVuX3Rlc3QKCiMjIFRFU1QgaW9tYXAKZWNobyAiPT09PSBURVNUIElP
TUFQID09PT0iIHwgdGVlIC1hIC90bXAvZmlvX3Jlc3VsdApNT1VOVF9PUFQ9ImJ1ZmZlcmVk
X2lvbWFwIgpydW5fdGVzdAo=

--------------x68ltKirQTg7GPL6eROhODRd--


