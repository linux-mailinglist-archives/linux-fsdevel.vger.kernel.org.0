Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF486724143
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 13:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237140AbjFFLoD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 07:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjFFLoC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:44:02 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE7F9E;
        Tue,  6 Jun 2023 04:44:01 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-65540715b4bso1653677b3a.0;
        Tue, 06 Jun 2023 04:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686051841; x=1688643841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zFLdd1F7emitKLWZlp12oRc6lUO0GVbEKV953lMIh6Y=;
        b=OKg/n6r4J5cXw0b9ohx/n84o6gI18K4/G4m7zDnoLj3ra5bycbpVI+9kzL69kWUwUq
         qg9qF/juH617HlOVBCTyINX/wXexHz28jxAWJAwyTk7q74Ny6YCfL8hJpbFqopsQFIlI
         T1xQ5PJDQHctbY5sUCSGUEbFZ718zlNDqkEqSGX1XZ4Z5nVdA/HBBRtg72YjpM8/zsjh
         vnzhhM+gPdwkdVlKHqIdsezOQf6HxIQ05Um8j9gvmgYuddyXGnlanYNrajreVwV0rEkV
         XySVdQXWzlt7H0mzhzkgvORa1ydkYajG4qIdcWulfnBs2cLAG9VdYgG8IRvzUnhl+qxN
         b/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686051841; x=1688643841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zFLdd1F7emitKLWZlp12oRc6lUO0GVbEKV953lMIh6Y=;
        b=FIrLKFEdJR47J8HMluPSqQ8slkm+AjtAn31aOWj7yTfCVh72JnbMnMVubfY0kCpLHk
         EHBkMntoUHkwSuIEAvRWQ/HQ/mP7mto9Q0InKCZUqLk+Aii1gWreXZDlSCuBLV6AqaVS
         Ka6EjW5hvU3Bko69WgUld9xiU61VoY/dhDbfZnrRwo6hhsxUqeIMZ4nbtEfiLUP/kQsL
         TxgF5ueQkZFK1dJrm6AELN+5RecHASlBB3L1HU/w+Ccg4Xq7gJltLAxA/BkNTxvQw0AR
         dV5ygAYgEvzytMnzEKZSjF10kP5b7GUZ5wqEfLTzNQIL/QGYYVHfvOlsp2l49raismt+
         9O6Q==
X-Gm-Message-State: AC+VfDykh6uxyKKfzGBwHmBH5mB6dpC30BrY9V1RNBIl3+6c80HKzZt4
        p7COQ4akC3s3mpc5zAPOxlP5pH52kxg=
X-Google-Smtp-Source: ACHHUZ5GhVVcaqdXdCxjdNFWTbeYg03F4AQ8KfeDSQTzNObNDyf4l44flnMzPJTaA/Et1CD9qeXYAg==
X-Received: by 2002:a05:6a20:9591:b0:10b:cb87:f5e with SMTP id iu17-20020a056a20959100b0010bcb870f5emr814845pzb.45.1686051840630;
        Tue, 06 Jun 2023 04:44:00 -0700 (PDT)
Received: from dw-tp.localdomain ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902ed4400b001ab0a30c895sm8325120plb.202.2023.06.06.04.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 04:44:00 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv8 0/5] iomap: Add support for per-block dirty state to improve write performance
Date:   Tue,  6 Jun 2023 17:13:47 +0530
Message-Id: <cover.1686050333.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello All,

Please find PATCHv8 which adds per-block dirty tracking to iomap.
As discussed earlier this is required to improve write performance and reduce
write amplification for cases where either blocksize is less than pagesize (such
as Power platform with 64k pagesize) or when we have a large folio (such as xfs
which currently supports large folio).

v7 -> v8
==========
1. Renamed iomap_page -> iomap_folio & iop -> iof in Patch-1 itself.
2. Made changes to the naming conventions of iomap_iop_** function to take iop
   as a function argument (as Darrick suggested). Also changed
   iomap_iop_test_full_uptodate() -> iomap_iop_is_fully_uptodate() &
   iomap_iop_test_block_uptodate() -> iomap_iop_is_block_uptodate().
   (similary for dirty state as well)
3. Added comment in iomap_set_range_dirty() to explain why we pass inode
   argument in that.
4. Added Reviewed-by from Darrick in Patch-3 & Patch-4 as there were no changes
   in these patches in v8.

Thanks to all the review comments. I think the patch series looks in much better
shape now. Please do let me know if this looks good?

Patchv6 -> Patchv7
==================
1. Fixed __maybe_unused annotation.
2. Added this patch-4
   iomap: Refactor iomap_write_delalloc_punch() function out

RFCv5 -> PATCHv6:
=================
1. Addresses review comments from Brian, Christoph and Matthew.
   @Christoph:
     - I have renamed the higher level functions such as iop_alloc/iop_free() to
       iomap_iop_alloc/free() in v6.
     - As for the low level bitmap accessor functions I couldn't find any better
       naming then iop_test_/set/clear_**. I could have gone for
       iomap_iop__test/set/clear/_** or iomap__iop_test/set/clear_**, but
       I wasn't convinced with either of above as it also increases function
       name.
       Besides iop_test/set_clear_ accessors functions for uptodate and dirty
       status tracking make sense as we are sure we have a valid iop in such
       cases. Please do let me know if this looks ok to you.
2. I tried testing gfs2 (initially with no patches) with xfstests. But I always ended up
   in some or the other deadlock (I couldn't spend any time debugging that).
   I also ran it with -x log, but still it was always failing for me.
   @Andreas:
   - could you please suggest how can I test gfs2 with these patches. I see gfs2
     can have a smaller blocksize and it uses iomap buffered io path. It will be
     good if we can get these patches tested on it too.

3. I can now say I have run some good amount of fstests on these patches on
   these platforms and I haven't found any new failure in my testing so far.
   arm64 (64k pagesize): with 4k -g quick
   Power: with 4k -g auto
   x86: 1k, 4k with -g auto and adv_auto

From my testing so far these patches looks stable to me and if this looks good
to reviewers as well, do you think this can be queued to linux-next for wider
testing?

Performance numbers copied from last patch commit message
==================================================
Performance testing of below fio workload reveals ~16x performance
improvement using nvme with XFS (4k blocksize) on Power (64K pagesize)
FIO reported write bw scores improved from around ~28 MBps to ~452 MBps.

1. <test_randwrite.fio>
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

2. Also our internal performance team reported that this patch improves
   their database workload performance by around ~83% (with XFS on Power)

Ritesh Harjani (IBM) (5):
  iomap: Rename iomap_page to iomap_folio and others
  iomap: Renames and refactor iomap_folio state bitmap handling
  iomap: Refactor iomap_write_delalloc_punch() function out
  iomap: Allocate iof in ->write_begin() early
  iomap: Add per-block dirty state tracking to improve performance

 fs/gfs2/aops.c         |   2 +-
 fs/iomap/buffered-io.c | 378 +++++++++++++++++++++++++++++------------
 fs/xfs/xfs_aops.c      |   2 +-
 fs/zonefs/file.c       |   2 +-
 include/linux/iomap.h  |   1 +
 5 files changed, 269 insertions(+), 116 deletions(-)

--
2.40.1

