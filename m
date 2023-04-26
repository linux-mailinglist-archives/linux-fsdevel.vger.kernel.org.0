Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640706EF17A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Apr 2023 11:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240046AbjDZJ5M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Apr 2023 05:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239534AbjDZJ5L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Apr 2023 05:57:11 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84143E70;
        Wed, 26 Apr 2023 02:57:09 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-63b5c4c76aaso4987188b3a.2;
        Wed, 26 Apr 2023 02:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682503029; x=1685095029;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j+XkfHvOJ0wuDBB9RmNK7FWzVGkZiN85OuQCIzYOObg=;
        b=sKjeRV0kt7uKcRLqNs2pvLHKHN/5GQbs5HL0q/JfyEzbCt72LG5Y6qASBpkAfEmVHQ
         lKvqRRENtdwAcA0uulQ+PEgqaOnEzYg+/fds9+j5m0uMa6FCYz/eZRsVeZj1kM++XrrL
         nFJL96oNxNoehS5m0jLmFdfhH8qHigD36uFu99W1kUzWYfvABG5MStkN3tdS3HjvoTm9
         lkRIhlv5qKPR4etwS9gPxRt9q24/4Z4GESdRXODz/o/kXJG8TrqWNlSmwDUZv54CUMou
         uCGW2LFpZC6LcUFiwG5P8y60m/Mlr/wHrM91fU/9xCz9+mYVbYzxact3Rtpjg3/NxiZ7
         miyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682503029; x=1685095029;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j+XkfHvOJ0wuDBB9RmNK7FWzVGkZiN85OuQCIzYOObg=;
        b=QiN+eT4nFO7Qzq/hOCHCaojTH4R/1KSXXb5H8oMMTFsQQExd7pFvzxCK2mH+XeihKQ
         gx23/SzBOukbDkqewP5XOksJ1Joulbc5xJw3kQ/Sy1RMTfcsfePrCaLYmK2xQZKrmneI
         aafhPV2VgNeA5hkyeNifI/xMvt8+wkfKrqUiRm8siIGlus3cu91IXc9UpLQBh9OLIqGr
         ViMAukHYq/bqlOKiQybdrB7AIPHAtVOsr28c2bZWlcHy76jpyR46N6M5H1vHokXeHGe7
         bVCQsk7DLSG2sL1CvZBttHJmEmynL0P1uwUken8dIJUARwkAum2kR2g0Qt1HNTroln0a
         Z/ZQ==
X-Gm-Message-State: AAQBX9duhcHxzeYxuIao6mFNKtfnMyqn5K2DjGZI+ToZ+lWvXDTpcNAl
        cjnsTyMUoAEv9nzIvMZoO3fejJ42dqI=
X-Google-Smtp-Source: AKy350ZVU9cwBNgVyB6GK6bu7uIrkZlf2aDcK3uYl/dJ6SFY/h/MCXfg8KWxf7y9chYSRSJRSZk/vw==
X-Received: by 2002:a05:6a00:2e0e:b0:63f:1037:cc24 with SMTP id fc14-20020a056a002e0e00b0063f1037cc24mr27044584pfb.32.1682503028759;
        Wed, 26 Apr 2023 02:57:08 -0700 (PDT)
Received: from rh-tp ([2406:7400:63:80ba:df67:5773:54c8:514f])
        by smtp.gmail.com with ESMTPSA id o8-20020a62f908000000b006260526cf0csm10719962pfh.116.2023.04.26.02.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 02:57:08 -0700 (PDT)
Date:   Wed, 26 Apr 2023 15:27:02 +0530
Message-Id: <87mt2vge4x.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFCv3 3/3] iomap: Support subpage size dirty tracking to improve write performance
In-Reply-To: <ZACscHnzmywRaXvu@bfoster>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Brian Foster <bfoster@redhat.com> writes:

> On Mon, Feb 27, 2023 at 01:13:32AM +0530, Ritesh Harjani (IBM) wrote:
>> On a 64k pagesize platforms (specially Power and/or aarch64) with 4k
>> filesystem blocksize, this patch should improve the performance by doing
>> only the subpage dirty data write.
>>
>> This should also reduce the write amplification since we can now track
>> subpage dirty status within state bitmaps. Earlier we had to
>> write the entire 64k page even if only a part of it (e.g. 4k) was
>> updated.
>>
>> Performance testing of below fio workload reveals ~16x performance
>> improvement on nvme with XFS (4k blocksize) on Power (64K pagesize)
>> FIO reported write bw scores improved from around ~28 MBps to ~452 MBps.
>>
>> 1. <test_randwrite.fio>
>> [global]
>> 	ioengine=psync
>> 	rw=randwrite
>> 	overwrite=1
>> 	pre_read=1
>> 	direct=0
>> 	bs=4k
>> 	size=1G
>> 	dir=./
>> 	numjobs=8
>> 	fdatasync=1
>> 	runtime=60
>> 	iodepth=64
>> 	group_reporting=1
>>
>> [fio-run]
>>
>> 2. Also our internal performance team reported that this patch improves there
>>    database workload performance by around ~83% (with XFS on Power)
>>
>> Reported-by: Aravinda Herle <araherle@in.ibm.com>
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>  fs/gfs2/aops.c         |   2 +-
>>  fs/iomap/buffered-io.c | 104 +++++++++++++++++++++++++++++++++++++----
>>  fs/xfs/xfs_aops.c      |   2 +-
>>  fs/zonefs/super.c      |   2 +-
>>  include/linux/iomap.h  |   1 +
>>  5 files changed, 99 insertions(+), 12 deletions(-)
>>
> ...
>> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
>> index e0b0be16278e..fb55183c547f 100644
>> --- a/fs/iomap/buffered-io.c
>> +++ b/fs/iomap/buffered-io.c
> ...
>> @@ -1630,7 +1715,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>>  		struct writeback_control *wbc, struct inode *inode,
>>  		struct folio *folio, u64 end_pos)
>>  {
>> -	struct iomap_page *iop = iomap_page_create(inode, folio, 0);
>> +	struct iomap_page *iop = iomap_page_create(inode, folio, 0, true);
>>  	struct iomap_ioend *ioend, *next;
>>  	unsigned len = i_blocksize(inode);
>>  	unsigned nblocks = i_blocks_per_folio(inode, folio);
>> @@ -1646,7 +1731,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>>  	 * invalid, grab a new one.
>>  	 */
>>  	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {
>> -		if (iop && !iop_test_uptodate(iop, i, nblocks))
>> +		if (iop && !iop_test_dirty(iop, i, nblocks))
>>  			continue;
>>
>>  		error = wpc->ops->map_blocks(wpc, inode, pos);
>
> Hi Ritesh,
>
> I'm not sure if you followed any of the discussion on the imap
> revalidation series that landed in the last cycle or so, but the
> associated delalloc punch error handling code has a subtle dependency on
> current writeback behavior and thus left a bit of a landmine for this
> work. For reference, more detailed discussion starts around here [1].
> The context is basically that the use of mapping seek hole/data relies
> on uptodate status, which means in certain error cases the filesystem
> might allocate a delalloc block for a write, but not punch it out of the
> associated write happens to fail and the underlying portion of the folio
> was uptodate.
>
> This doesn't cause a problem in current mainline because writeback maps
> every uptodate block in a dirty folio, and so the delalloc block will
> convert at writeback time even though it wasn't written. This no longer
> occurs with the change above, which means there's a vector for a stale
> delalloc block to be left around in the inode. This is a free space
> accounting corruption issue on XFS. Here's a quick example [2] on a 1k
> FSB XFS filesystem to show exactly what I mean:
>
> # xfs_io -fc "truncate 4k" -c "mmap 0 4k" -c "mread 0 4k" -c "pwrite 0 1" -c "pwrite -f 2k 1" -c fsync /mnt/file
> # xfs_io -c "fiemap -v" /mnt/file
> /mnt/file:
>  EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
> ...
>    2: [4..5]:          0..1                 2   0x7
> ...
> (the above shows delalloc after an fsync)
> # umount /mnt
>   kernel:XFS: Assertion failed: xfs_is_shutdown(mp) || percpu_counter_sum(&mp->m_delalloc_blks) == 0, file: fs/xfs/xfs_super.c, line: 1068
> # xfs_repair -n /dev/vdb2
> Phase 1 - find and verify superblock...
> Phase 2 - using internal log
> ...
> sb_fdblocks 20960187, counted 20960195
> ...
> #
>
> I suspect this means either the error handling code needs to be updated
> to consider dirty state (i.e. punch delalloc if the block is !dirty), or
> otherwise this needs to depend on a broader change in XFS to reclaim
> delalloc blocks before inode eviction (along the lines of Dave's recent
> proposal to do something like that for corrupted inodes). Of course the
> caveat with the latter is that doesn't help for any other filesystems
> (?) that might have similar expectations for delayed allocation and want
> to use iomap.
>
> Brian
>
> [1] https://lore.kernel.org/linux-fsdevel/Y3TsPzd0XzXXIzQv@bfoster/
>
> [2] This test case depends on a local xfs_io hack to co-opt the -f flag
> into inducing a write failure. A POC patch for that is available here,
> if you wanted to replicate:
>
> https://lore.kernel.org/linux-xfs/20221123181322.3710820-1-bfoster@redhat.com/

Thanks a lot Brian for such detailed info along with a test case.
Really appreciate your insights on this! :)
And apologies for not getting to it earlier. I picked up iomap DIO conversion for
ext2 in between. Now that it is settled, I will be working on addressing
this problem.

Yes, I did follow that patch series which you pointed, but I guess
I mostly thought it was the stale iomap problem which we were solving.
But you are right the approach we take in that patch series to punch out
the delalloc blocks in case of short writes does open up a potential bug
when we add subpage size dirty tracking in iomap, which was also
discussed during the time and I had marked it as well. But I guess I had
completely forgotten about it. So thanks for bringing it up again.

I looked into the Dave's series and what we are trying to do there is
identifying uptodate folios within the [start, end) range and when if
there is a dirty folio within that range, then we punch out all of the
data blocks from *punch_start_byte uptil before this dirty folio byte.
(because these dirty folios anyways contain uptodate dirty data which
can be written back at the time of writeback. Any uptodate non-dirty
folios can be punched out to ensure we don't leak any delalloc blocks
due to short writes).
The only problem here is...when we have subpage size blocks within a
dirty folio, it can still have subblocks within the folio which are
only marked uptodate but not dirty.
Given that we never punch out these uptodate non-dirty subblocks
from within this folio, this can leave a potential delalloc blocks leak
because at the time of writeback we only considers writing subblocks
of a folio which are marked dirty (in this patch series which adds
subpage size dirty tracking). This can then cause bug on problems as you
pointed out during unmount.

I have a short fix for this problem i.e. similar to how we do writeback i.e.
to consider the dirty state of every subblock within a folio, during
punch out operation in iomap_write_delalloc_release() ->
iomap_write_delalloc_scan().
So when we identify a dirty folio in above delalloc release path, we
should iterate over each subblock of that folio as well to punch out non-dirty
blocks. This should make sure that we don't have any uptodate non-dirty
subblocks in the entire given range from [start, end).

I have also addressed many of the other smaller review comments from
others in v3. I will include this change as well will send a new
revision for review (after some cleanups and some initial testing).

Thanks!
-ritesh
