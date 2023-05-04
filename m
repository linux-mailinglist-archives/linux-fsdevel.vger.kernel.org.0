Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F347A6F6E1A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 May 2023 16:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjEDOvl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 May 2023 10:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjEDOve (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 May 2023 10:51:34 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D4F359B;
        Thu,  4 May 2023 07:51:23 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64115eef620so12943209b3a.1;
        Thu, 04 May 2023 07:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683211883; x=1685803883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7u4h5Jb3fpwl3HY0MAPC5MFYuZ8SOpZhAXyc/unPdcY=;
        b=lTA0eJDUvzcLr1+jI85PRtEqTQltAv3Lj2O9xg3diAdKTsSWRcqguLOLv6xCurD6Ev
         JJoqqtJHfGtxmliGUKFYJHfT8xIxT3EPtafsGJXfcg2f9QUdP8hTcjj/hEm0euEGLm1B
         RvjToXRb66A9yJ0wGDof5D5rTFAqg4dGnVcqWWs8NC5y2pbkynENPWcQlZ5GSnHnoqlK
         3Sb7ThvQ1cxeqVQR6L3Exul92JXWcSd1TTCUhU5TEN8IXklVuP8B4fPyhyAoxRn/ka67
         y1sKV/Lmw18IUg2o4XduDpxtIemzfTYJ3l1BpJGzfWd3++zxgMNYELcal/33T2FR46pp
         MfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683211883; x=1685803883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7u4h5Jb3fpwl3HY0MAPC5MFYuZ8SOpZhAXyc/unPdcY=;
        b=PlFanAbhks3rP5HFWdI3vEESOoapjNIF72yFxbDt1mN/9pTiBMe19CWpJqd/SzU120
         wyO9z3hyvcK0TsApeLnT9EAA3cpm7qiI3GxVmpRbXgBx8XjdU8R0F7g9S5qJXvs68HOE
         MRcg17kqsSGFmZ87Wy/UbTG811IOsf+8NzrPTOT+V5CBvpm9tRIaqP15/soSrB85q1ZV
         hMcDb8paFf6WfW6HkvzuLDNQ3+q3YlTUiwOfqa3b7H07uhFuUoGknxts9WceOXTvn0X1
         mL9lJBcAxCI4CamplvPHzsd0pSunxWesm67D73iVdFbM2tDgnqS46FCKtcYlqFskTKj+
         pdkA==
X-Gm-Message-State: AC+VfDwPeyTJtCBwnUUc5PFJJZKw4ZnRPkYF/BtwxnXVM1IL9Cc2dDr2
        fPVrgmpm4Xn3RyhLxOv1LNJEXXjfeO0=
X-Google-Smtp-Source: ACHHUZ7FneJXuzNre+wpHZTDXT/ZgQKo5NO3JTrZHHq01XlcaJrIXJeTPPEXt/G6/qmp8YIqHoLxiQ==
X-Received: by 2002:a05:6a00:448e:b0:643:4608:7c2d with SMTP id cu14-20020a056a00448e00b0064346087c2dmr3003520pfb.12.1683211882362;
        Thu, 04 May 2023 07:51:22 -0700 (PDT)
Received: from rh-tp.ibmuc.com ([2406:7400:63:80ba:df67:5773:54c8:514f])
        by smtp.gmail.com with ESMTPSA id z192-20020a6333c9000000b0052c53577756sm3107503pgz.64.2023.05.04.07.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 07:51:21 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv4 0/3] iomap: Support subpage size dirty tracking to improve write performance
Date:   Thu,  4 May 2023 20:21:06 +0530
Message-Id: <cover.1683208091.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello All,

Please find RFCv4 of the subpage size dirty tracking support to iomap
buffered-io.

RFCv3 -> RFCv4
===============
1. Addressed most of the review comments from Dave and Matthew on rfcv3.
2. Note I have added Reviewed-by from Dave in Patch-2 which he provide for the
   mechanical changes.
3. We now have two functions iomap_iop_set_range() and iomap_iop_clear_range()
   after addressing review comment from Dave to add a common wrapper for
   uptodate and dirty bits rather than each having different function.
4. Addressed a problem reported by Brian for a short write case with delalloc
   release. This is addressed in patch-3 in function iomap_write_delalloc_scan().
   I suppose this is a major change from the previous rfcv3 which adds some
   functionality change. I did test a unit test which Brian provided with xfs_io
   -f option. Before those changes, the kernel caused a bug_on during unmount
   with the unit test. This gets fixed with the changes added in v4.

	i.e. After v4
	=================
	root@ubuntu# ./xfs_io -fc "truncate 4k" -c "mmap 0 4k" -c "mread 0 4k" -c "pwrite 0 1" -c "pwrite -f 2k 1" -c fsync /mnt1/tmnt/testfile
	wrote 1/1 bytes at offset 0
	1.000000 bytes, 1 ops; 0.0001 sec (7.077 KiB/sec and 7246.3768 ops/sec)
	pwrite: Bad address
	root@ubuntu# ./xfs_io -c "fiemap -v" /mnt1/tmnt/testfile
	/mnt1/tmnt/testfile:
	 EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
	   0: [0..1]:          22..23               2   0x1
	   1: [2..7]:          hole                 6
	root@ubuntu# filefrag -v /mnt1/tmnt/testfile
	Filesystem type is: 58465342
	File size of /mnt1/tmnt/testfile is 4096 (4 blocks of 1024 bytes)
	 ext:     logical_offset:        physical_offset: length:   expected: flags:
	   0:        0..       0:         11..        11:      1:             last
	/mnt1/tmnt/testfile: 1 extent found
	root@ubuntu# umount /mnt1/tmnt
	root@ubuntu#

	Before v4
	===========
	root@ubuntu# mount /dev/loop8 /mnt1/test
	root@ubuntu# ./xfs_io -fc "truncate 4k" -c "mmap 0 4k" -c "mread 0 4k" -c "pwrite 0 1" -c "pwrite -f 2k 1" -c fsync /mnt1/test/testfile
	wrote 1/1 bytes at offset 0
	1.000000 bytes, 1 ops; 0.0000 sec (10.280 KiB/sec and 10526.3158 ops/sec)
	pwrite: Bad address
	root@ubuntu# ./xfs_io -c "fiemap -v" /mnt1/test/testfile
	/mnt1/test/testfile:
	 EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
	   0: [0..1]:          22..23               2   0x0
	   1: [2..3]:          hole                 2
	   2: [4..5]:          0..1                 2   0x7
	   3: [6..7]:          hole                 2
	root@ubuntu# filefrag -v /mnt1/test/testfile
	Filesystem type is: 58465342
	File size of /mnt1/test/testfile is 4096 (4 blocks of 1024 bytes)
	 ext:     logical_offset:        physical_offset: length:   expected: flags:
	   0:        0..       0:         11..        11:      1:
	   1:        2..       2:          0..         0:      0:             last,unknown_loc,delalloc
	/mnt1/test/testfile: 2 extents found
	root@ubuntu# umount /mnt1/test
	<dmesg snip>
	[  156.581188] XFS (loop8): Unmounting Filesystem 7889507d-fc7f-4a1c-94d5-06797f2cc790
	[  156.584455] XFS (loop8): ino 43 data fork has delalloc extent at [0x2:0x1]
	[  156.587847] XFS: Assertion failed: 0, file: fs/xfs/xfs_icache.c, line: 1816
	[  156.591675] ------------[ cut here ]------------
	[  156.594133] kernel BUG at fs/xfs/xfs_message.c:102!
	[  156.596669] invalid opcode: 0000 [#1] PREEMPT SMP PTI
	[  156.599277] CPU: 7 PID: 435 Comm: kworker/7:5 Not tainted 6.3.0-rc6-xfstests-00003-g99a844f4e411-dirty #105
	[  156.603721] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
	[  156.608701] Workqueue: xfs-inodegc/loop8 xfs_inodegc_worker
	[  156.611426] RIP: 0010:assfail+0x38/0x40
	[  156.613329] Code: c9 48 c7 c2 b8 87 a5 82 48 89 f1 48 89 fe 48 c7 c7 1f 81 96 82 e8 68 fd ff ff 80 3d f1 03 98 01 00 75 07 0f 0b c3 cc cc0
	[  156.621642] RSP: 0018:ffffc90001a33e08 EFLAGS: 00010202
	[  156.624012] RAX: 0000000000000000 RBX: ffff888320bd0000 RCX: 0000000000000000
	[  156.627238] RDX: 00000000ffffffc0 RSI: 0000000000000000 RDI: ffffffff8296811f
	[  156.630430] RBP: ffff888320bd0000 R08: 0000000000000000 R09: 000000000000000a
	[  156.633573] R10: 000000000000000a R11: f000000000000000 R12: fffffffffffffeb0
	[  156.636732] R13: 0000000000000000 R14: ffff8881d49d7000 R15: ffffe8ffffdf6d05
	[  156.639042] FS:  0000000000000000(0000) GS:ffff88842fdc0000(0000) knlGS:0000000000000000
	[  156.641957] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	[  156.644666] CR2: 00007ffff7daf1f3 CR3: 00000001057f6006 CR4: 0000000000170ee0
	[  156.646981] Call Trace:
	[  156.647951]  <TASK>
	[  156.648904]  xfs_inodegc_set_reclaimable+0x15b/0x160
	[  156.651270]  xfs_inodegc_worker+0x95/0x1d0
	[  156.653202]  process_one_work+0x274/0x550
	[  156.655305]  worker_thread+0x4f/0x300
	[  156.657081]  ? __pfx_worker_thread+0x10/0x10
	[  156.658977]  kthread+0xf6/0x120
	[  156.660657]  ? __pfx_kthread+0x10/0x10
	[  156.662565]  ret_from_fork+0x2c/0x50
	[  156.664421]  </TASK>

Testing
==========
1. I have tested this on 1k and 4k block size on x86 box with no new failures.
2. Tested this on Power with 4k and 64k. No failures reported till now. I am
   continuing to test this as we speak.
3. fio benchmark gives 16x performance boost on Power with 4k blocksize.
4. Will soon report pgbench scores as well on Power. I am assuming we won't see
   any surprises here with v4.

TODOs:
========
1. Test zonefs / gfs2 using xfstests suite. Make sure no regression.
   Although as I was seeing gfs2 uses the IOMAP_F_BUFFER_HEAD path of the code so
   I am not sure if these changes can impact gfs2. I recently noticed that for
   IOMAP_F_BUFFER_HEAD we take __block_write_begin_int() path and not
   __iomap_write_begin() path. That means we never create iop structures for them
   in the write_begin path. Yet we create and use iop in iomap_writepage_map() path
   during the writeback.
   Note: This is an existing behavior and not due to this patch. However since
   I noticed that only recently, I do want to keep a note of it so that we can
   maybe look at that in next revision.
2. I still don't have an answer to todo-5 from rfcv2. a better data structure
   instead of bitmap for iops.
3. Look into other optimizations which Dave suggested on v2 which is whether we
   can use find_first_zero_bit() helpers and whether those will be helpful?
   Sorry that I couldn't get this in v4. I initially thought that we don't do
   this even today for uptodate bit searches with large folios. So maybe I can
   work on these optimizations in next round with other cleanup work in iomap
   once this patch series looks good?

<From here is the copy paste from previous versions>
RFCv2 -> RFCv3
===============
1. Addressed review comments on adding accessor APIs for both uptodate and dirty
   iop bitmap. (todo-1 of rfcv2).
   Addressed few other review comments from Christoph & Matthew.
2. Performance testing of these patches reveal the same performance improvement
   i.e. the given fio workload shows 16x perf improvement on nvme drive.
   (completed todo-3 of rfcv2)
3. Addressed todo-4 of rfcv2

Few TODOs
===========
1. Test gfs2 and zonefs with these changes (todo-2 of rfcv2)
2. Look into todo-5 of rfcv2

xfstests testing with default options and 1k blocksize on x86 reveals no new
issues. Also didn't observe any surprises on Power with 4k blocksize.
(Please do suggest if there are any specific xfstests config options (for
xfs) which are good to get it tested for this patch series?)


Copy-Paste Cover letter of RFCv2
================================

RFC -> RFCv2
=============
1. One of the key fix in v2 is that earlier when the folio gets marked as dirty,
   we were never marking the bits dirty in iop bitmap.
   This patch adds support for iomap_dirty_folio() as new ->dirty_folio() aops
   callback, which sets the dirty bitmap in iop and later call filemap_dirty_folio().
   This was one of the review comment that was discussed in RFC.

2. One of the other key fix identified in testing was that iop structure could
   get allocated at the time of the writeback if the folio is uptodate.
   (since it can get freed during memory pressure or during
   truncate_inode_partial_folio() in case of large folio). This could then cause
   nothing to get written if we have not marked the necessary bits as dirty in
   iop->state[]. Patch-1 & Patch-3 takes care of that.

TODOs
======
1. I still need to work on macros which we could declare and use for easy
   reference to uptodate/dirty bits in iop->state[] bitmap (based on previous
   review comments).

2. Test xfstests on other filesystems which are using the iomap buffered write
   path (gfs2, zonefs).

3. Latest performance testing with this patch series (I am not expecting any
   surprises here. The perf improvements should be more or less similar to rfc).

4. To address one of the todo in Patch-3. I think I missed to address it and
   noticed it only now before sending. But it should be easily addressable.
   I can address it in the next revision along with others.

5. To address one of the other review comments like what happens with a large
   folio. Can we limit the size of bitmaps if the folio is too large e.g. > 2MB.

   [RH] - I can start looking into this area too, if we think these patches
   are looking good. My preference would be to work on todos 1-4 as part of this
   patch series and take up bitmap optimization as a follow-up work for next
   part. Please do let me know your thoughts and suggestions on this.

Note: I have done a 4k bs test with auto group on Power with 64k pagesize and
I haven't found any surprises. I am also running a full bench of all tests with
x86 and 1k blocksize, but it still hasn't completed. I can update the results
once it completes.

Also as we discussed, all the dirty and uptodate bitmap tracking code for
iomap_page's state[] bitmap, is still contained within iomap buffered-io.c file.

I would appreciate any review comments/feedback and help on this work i.e.
adding subpage size dirty tracking to reduce write amplification problem and
improve buffered write performance. Kindly note that w/o these patches,
below type of workload gets severly impacted.


Performance Results from RFC [1]:
=================================
1. Performance testing of below fio workload reveals ~16x performance
improvement on nvme with XFS (4k blocksize) on Power (64K pagesize)
FIO reported write bw scores, improved from ~28 MBps to ~452 MBps.

<test_randwrite.fio>
[global]
	ioengine=psync
	rw=randwrite
	overwrite=1
	pre_read=1
	direct=0
	bs=4k
	size=1G
	dir=./
	numjobs=8
	fdatasync=1
	runtime=60
	iodepth=64
	group_reporting=1

[fio-run]

2. Also our internal performance team reported that this patch improves there
   database workload performance by around ~83% (with XFS on Power)

[1]: https://lore.kernel.org/linux-xfs/cover.1666928993.git.ritesh.list@gmail.com/

Ritesh Harjani (IBM) (3):
  iomap: Allocate iop in ->write_begin() early
  iomap: Change uptodate variable name to state
  iomap: Support subpage size dirty tracking to improve write performance

 fs/gfs2/aops.c         |   2 +-
 fs/iomap/buffered-io.c | 243 ++++++++++++++++++++++++++++++++++-------
 fs/xfs/xfs_aops.c      |   2 +-
 fs/zonefs/file.c       |   2 +-
 include/linux/iomap.h  |   1 +
 5 files changed, 209 insertions(+), 41 deletions(-)

--
2.39.2

