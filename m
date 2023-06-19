Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC009734A34
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 04:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjFSC3E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Jun 2023 22:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjFSC3D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Jun 2023 22:29:03 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5558AE49;
        Sun, 18 Jun 2023 19:29:02 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6b5853a140cso88623a34.2;
        Sun, 18 Jun 2023 19:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687141741; x=1689733741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zvc3TtUiGYyGe9v9CW2ozDKeTspctQPkaLDox3pC/4A=;
        b=e68EKTuuhifyhbgsjx/0RmKbMo/YTW7naAUEbbgzhXpfnEMhHe9aoDU/p0o9ZAXH8R
         FDwduRT8MT2Uo/Y5HCLwFWc8fnTLgiSQ4SHkbAD05rDVIKSj6rKqZ5WQCuZl0IpbCuSc
         4wFGEHJnaRkWtw9o5x2NtVabUt/mdn3436I5LRmX+yuLt9T8UQDscYib9zjjsnz8hq4u
         UWnBIyiQp2I+nZuDIK++Fw2ymcZ5A+kO9iWL3C+hJWrOkOt5/DrtJVfwK57wOe73dR+8
         o6R6oEkY4jWaMwC7ALzLt6QFEfd0WJiVyI2bPsdyXy+KaFpiSMam9Xmz9Yze67cx7IRd
         m9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687141741; x=1689733741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zvc3TtUiGYyGe9v9CW2ozDKeTspctQPkaLDox3pC/4A=;
        b=LmNpI0TMX7ypNqUuU4otQktSl3GEC1VbClxBaj4aXA+hoEAGdEB3RClutisRA4FVgV
         I3pPb9/5FjCeO0bfsDuLZjh7h7tAfv8J9QLXLBisuPuEH7tnirgP7uTncB8PdUDp08Hf
         +G4faJAkuqgUoSx+RaJh/XUGpPMPq184EIu9bqO6tE74BBcUU6eiK95M+kWwZ9KxfS8b
         pW8J1re1p7h0uUcGpS2Gc2DchcmvHpoF5hsTc3LvRLxe30PWKMKKfkeV1vxuCUdKHynh
         VQ/5w1Hyc6PvZ8nd2HCjfCgGglxTXfe3eKWawTBa6XvWAsUMmW9v1vK87bXkckye0PrO
         umKA==
X-Gm-Message-State: AC+VfDz6ktgUuUdIP7i+Go93QzSqSoXef7VjLvMNANP2oxoYnEUtN+PO
        LkF3DHwStX30wfxUhJ2GJec7TQyEQrk=
X-Google-Smtp-Source: ACHHUZ5cUAoHQIOVmAhwFX2siaUFryfoPkVJ5zEGO6v758urwFDMaqOiySDAePWciBfUfFh9T4Rtdw==
X-Received: by 2002:a05:6358:1a84:b0:130:e669:a6c4 with SMTP id gm4-20020a0563581a8400b00130e669a6c4mr2082696rwb.17.1687141740689;
        Sun, 18 Jun 2023 19:29:00 -0700 (PDT)
Received: from dw-tp.ihost.com ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id g18-20020aa78752000000b0064ff1f1df65sm399531pfo.61.2023.06.18.19.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 19:28:59 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv10 0/8] iomap: Add support for per-block dirty state to improve write performance
Date:   Mon, 19 Jun 2023 07:58:43 +0530
Message-Id: <cover.1687140389.git.ritesh.list@gmail.com>
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

Please find PATCHv10 which adds per-block dirty tracking to iomap.
As discussed earlier this is required to improve write performance and reduce
write amplification for cases where either blocksize is less than pagesize (such
as Power platform with 64k pagesize) or when we have a large folio (such as xfs
which currently supports large folio).

v9 -> v10:
===========
1. Mostly function renames from iomap_ifs_** to ifs_** (patch-1)
2. Addressed review comments from Darrick & Andreas
3. Added 2 suggested by patches from Matthew (patch-4 & patch-5)
4. Defined a new separate function for iomap_write_delalloc_ifs_punch() in
   Patch-8

Note: since v10 mainly had function name changes in existing patches (which
already had reviewed-by), hence I have kept the Reviewed-by from previous
reviewers as is.

Testing of v10:
===============
I have done some weekend long testing of v10 on my setup for x86 (1k & 4k bs),
arm (4k bs, 64k ps) and Power (4k bs) with xfstests. I haven't found any new
failures as such in my testing so far with xfstests.


v7/v8 -> v9
============
1. Splitted the renaming & refactoring changes into different patchsets.
   (Patch-1 & Patch-2)
2. Addressed review comments from everyone in v9.
3. Fixed a punch-out bug pointed out by Darrick in Patch-6.
4. Included iomap_ifs_calc_range() function suggested by Christoph in Patch-6.

Testing
=========
I have tested v9 on:-
   - Power with 4k blocksize -g auto
   - x86 with 1k and 1k_adv with -g auto
   - arm64 with 4k blocksize and 64k pagesize with 4k quick
   - also tested gfs2 with minimal local config (-O -b 1024 -p lock_nolock)
   - unit tested failed punch-out operation with "-f" support to pwrite in
     xfs_io.
I haven't observed any new testcase failures in any of my testing so far.

Thanks everyone for helping with reviews and suggestions.
Please do let me know if there are any further review comments on this one.

<Perf data copy paste from previous version>
=============================================
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


Ritesh Harjani (IBM) (8):
  iomap: Rename iomap_page to iomap_folio_state and others
  iomap: Drop ifs argument from iomap_set_range_uptodate()
  iomap: Add some uptodate state handling helpers for ifs state bitmap
  iomap: Fix possible overflow condition in iomap_write_delalloc_scan
  iomap: Use iomap_punch_t typedef
  iomap: Refactor iomap_write_delalloc_punch() function out
  iomap: Allocate ifs in ->write_begin() early
  iomap: Add per-block dirty state tracking to improve performance

 fs/gfs2/aops.c         |   2 +-
 fs/iomap/buffered-io.c | 418 +++++++++++++++++++++++++++++------------
 fs/xfs/xfs_aops.c      |   2 +-
 fs/zonefs/file.c       |   2 +-
 include/linux/iomap.h  |   1 +
 5 files changed, 298 insertions(+), 127 deletions(-)

--
2.40.1

