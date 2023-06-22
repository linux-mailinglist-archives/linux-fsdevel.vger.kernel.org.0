Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C8F73979E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 08:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjFVGuL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jun 2023 02:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjFVGuJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jun 2023 02:50:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77863B4;
        Wed, 21 Jun 2023 23:50:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3860422882;
        Thu, 22 Jun 2023 06:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1687416607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9B0qcrOdREoohRCJHKU4tBeqBNmxmvpM86a3m6k/jlM=;
        b=sFW7VckQctkAtCtA8p2UEgyyvzOn/1emk99zLmqBx3Sf8k2Wy8nSYS9ruQLhA1wjc6T7lv
        SJ19FsNXWD7DuhW8+v0xnOywStjIG4a5xzWy2GvCtV+MrAhO0LgUX17676E2IdIHgeh5dY
        neddWFbmdLQRGUCoOP15JI7WY5H+71g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1687416607;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9B0qcrOdREoohRCJHKU4tBeqBNmxmvpM86a3m6k/jlM=;
        b=K+FwlG2hn4ZTW5p5BD7Ujb4LDKo2snoqlURkm+sL4fxRcGiEr2s+dYA2mzp0/puHPgMUsH
        gmpQO8iQ0Vw0dbAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EAF6C132BE;
        Thu, 22 Jun 2023 06:50:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id b5JPOB7vk2TSVwAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 22 Jun 2023 06:50:06 +0000
Message-ID: <94d9e935-c8a4-896a-13ac-263831a78dd5@suse.de>
Date:   Thu, 22 Jun 2023 08:50:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC 0/4] minimum folio order support in filemap
Content-Language: en-US
From:   Hannes Reinecke <hare@suse.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Pankaj Raghav <p.raghav@samsung.com>, willy@infradead.org,
        gost.dev@samsung.com, mcgrof@kernel.org, hch@lst.de,
        jwong@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <CGME20230621083825eucas1p1b05a6d7e0bf90e7a3d8e621f6578ff0a@eucas1p1.samsung.com>
 <20230621083823.1724337-1-p.raghav@samsung.com>
 <b311ae01-cec9-8e06-02a6-f139e37d5863@suse.de>
 <ZJN0pvgA2TqOQ9BC@dread.disaster.area>
 <4270b5c7-04b4-28e0-6181-ef98d1f5130c@suse.de>
In-Reply-To: <4270b5c7-04b4-28e0-6181-ef98d1f5130c@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/22/23 07:51, Hannes Reinecke wrote:
> On 6/22/23 00:07, Dave Chinner wrote:
>> On Wed, Jun 21, 2023 at 11:00:24AM +0200, Hannes Reinecke wrote:
>>> On 6/21/23 10:38, Pankaj Raghav wrote:
>>>> There has been a lot of discussion recently to support devices and 
>>>> fs for
>>>> bs > ps. One of the main plumbing to support buffered IO is to have 
>>>> a minimum
>>>> order while allocating folios in the page cache.
>>>>
>>>> Hannes sent recently a series[1] where he deduces the minimum folio
>>>> order based on the i_blkbits in struct inode. This takes a different
>>>> approach based on the discussion in that thread where the minimum and
>>>> maximum folio order can be set individually per inode.
>>>>
>>>> This series is based on top of Christoph's patches to have iomap aops
>>>> for the block cache[2]. I rebased his remaining patches to
>>>> next-20230621. The whole tree can be found here[3].
>>>>
>>>> Compiling the tree with CONFIG_BUFFER_HEAD=n, I am able to do a 
>>>> buffered
>>>> IO on a nvme drive with bs>ps in QEMU without any issues:
>>>>
>>>> [root@archlinux ~]# cat /sys/block/nvme0n2/queue/logical_block_size
>>>> 16384
>>>> [root@archlinux ~]# fio -bs=16k -iodepth=8 -rw=write 
>>>> -ioengine=io_uring -size=500M
>>>>             -name=io_uring_1 -filename=/dev/nvme0n2 -verify=md5
>>>> io_uring_1: (g=0): rw=write, bs=(R) 16.0KiB-16.0KiB, (W) 
>>>> 16.0KiB-16.0KiB, (T) 16.0KiB-16.0KiB, ioengine=io_uring, iodepth=8
>>>> fio-3.34
>>>> Starting 1 process
>>>> Jobs: 1 (f=1): [V(1)][100.0%][r=336MiB/s][r=21.5k IOPS][eta 00m:00s]
>>>> io_uring_1: (groupid=0, jobs=1): err= 0: pid=285: Wed Jun 21 
>>>> 07:58:29 2023
>>>>     read: IOPS=27.3k, BW=426MiB/s (447MB/s)(500MiB/1174msec)
>>>>     <snip>
>>>> Run status group 0 (all jobs):
>>>>      READ: bw=426MiB/s (447MB/s), 426MiB/s-426MiB/s 
>>>> (447MB/s-447MB/s), io=500MiB (524MB), run=1174-1174msec
>>>>     WRITE: bw=198MiB/s (207MB/s), 198MiB/s-198MiB/s 
>>>> (207MB/s-207MB/s), io=500MiB (524MB), run=2527-2527msec
>>>>
>>>> Disk stats (read/write):
>>>>     nvme0n2: ios=35614/4297, merge=0/0, ticks=11283/1441, 
>>>> in_queue=12725, util=96.27%
>>>>
>>>> One of the main dependency to work on a block device with bs>ps is
>>>> Christoph's work on converting block device aops to use iomap.
>>>>
>>>> [1] https://lwn.net/Articles/934651/
>>>> [2] https://lwn.net/ml/linux-kernel/20230424054926.26927-1-hch@lst.de/
>>>> [3] 
>>>> https://github.com/Panky-codes/linux/tree/next-20230523-filemap-order-generic-v1
>>>>
>>>> Luis Chamberlain (1):
>>>>     block: set mapping order for the block cache in set_init_blocksize
>>>>
>>>> Matthew Wilcox (Oracle) (1):
>>>>     fs: Allow fine-grained control of folio sizes
>>>>
>>>> Pankaj Raghav (2):
>>>>     filemap: use minimum order while allocating folios
>>>>     nvme: enable logical block size > PAGE_SIZE
>>>>
>>>>    block/bdev.c             |  9 ++++++++
>>>>    drivers/nvme/host/core.c |  2 +-
>>>>    include/linux/pagemap.h  | 46 
>>>> ++++++++++++++++++++++++++++++++++++----
>>>>    mm/filemap.c             |  9 +++++---
>>>>    mm/readahead.c           | 34 ++++++++++++++++++++---------
>>>>    5 files changed, 82 insertions(+), 18 deletions(-)
>>>>
>>>
>>> Hmm. Most unfortunate; I've just finished my own patchset 
>>> (duplicating much
>>> of this work) to get 'brd' running with large folios.
>>> And it even works this time, 'fsx' from the xfstest suite runs 
>>> happily on
>>> that.
>>
>> So you've converted a filesystem to use bs > ps, too? Or is the
>> filesystem that fsx is running on just using normal 4kB block size?
>> If the latter, then fsx is not actually testing the large folio page
>> cache support, it's mostly just doing 4kB aligned IO to brd....
>>
> I have been running fsx on an xfs with bs=16k, and it worked like a charm.
> I'll try to run the xfstest suite once I'm finished with merging
> Pankajs patches into my patchset.
> Well, would've been too easy.
'fsx' bails out at test 27 (collapse), with:

XFS (ram0): Corruption detected. Unmount and run xfs_repair
XFS (ram0): Internal error isnullstartblock(got.br_startblock) at line 
5787 of file fs/xfs/libxfs/xfs_bmap.c.  Caller 
xfs_bmap_collapse_extents+0x2d9/0x320 [xfs]

Guess some more work needs to be done here.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

