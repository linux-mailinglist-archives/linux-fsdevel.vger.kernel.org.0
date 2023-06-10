Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706A672AB2A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jun 2023 13:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbjFJLjU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Jun 2023 07:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjFJLjU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Jun 2023 07:39:20 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25498E1;
        Sat, 10 Jun 2023 04:39:19 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b3a9eae57cso1360895ad.1;
        Sat, 10 Jun 2023 04:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686397158; x=1688989158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2rnSgSbl9Hg8S2bOhndYQ4vz7d+md2+YorLkp3LT4mw=;
        b=TFXscOLspui/N/FopuEVqWLS16gtVxUKe+LJnIKnc/NNxyPnFsL2PPqsvJYGBOVkT1
         tL8y+g+lmYX4tuKVKiSIe5smcYfmotHKHTC7xazAtVTdOwMPwYtz0BzfGiRwrXuUCO8Z
         VuwoFJCi3ZIi6sn6tsUZiybFzQCGm+hblNZZCBc18UlBQhn9R/b5KL1smsJfNxMLCFqA
         cz1OMELPgOjK1NYVng4/0MOAzK+Vbwo5nYNkL7u6sUpIBMbWzNsA3lMrsetEuWSk+D5k
         X3Zmj8DzwhLkKQNSv2GrkkZf3HHxPtra5ghk2rlDc81MM138wg9lEEOYFmfCaqjVuZ2n
         0+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686397158; x=1688989158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2rnSgSbl9Hg8S2bOhndYQ4vz7d+md2+YorLkp3LT4mw=;
        b=TNbcXazPVtdXF4+7pvFrkaMO7Wdi7pNeqSANbfanbTnycou8K4IT7AY94FhgerpUIa
         T3Ii2F/uaG/aaGxXpKWIhEFm7azd0FuFVWVjxDV87giKoINaGkLnRgxilwzwa2L4YnoO
         NylXJgP52Kb5qZSzKejflrDIBqRNjoYfRvGA66K73AoL68T0Ucpz5waAlWh7sP76JGq8
         +sKYJluP58hu8uiDv9MELbE8pscMmOrbmR9CW07jWgdy8iNXrN0CbEajffy/KCyO7ycK
         7/sgQfGo6TiSJ+frH4lOnd4mlYo8S8/Zc5sUH70uMLcas8RmGg+meeduOyH66nRlgGsH
         CXyg==
X-Gm-Message-State: AC+VfDx9nPVs6EdudKC2hdUR3YAyVw2IUXtVGAg8q5/eRb5wNU8S0gv9
        2Cu0XCx+Z49tAt6IYEzYPP9+cxuADtc=
X-Google-Smtp-Source: ACHHUZ7HzFDsSy6cTN/HKUl+7L2yk/OQ/ZeKKZ3kIGXroQQZ08sdGqyQdDIrTlHlo/48veRa7dl4ag==
X-Received: by 2002:a17:902:da90:b0:1ae:10a5:8349 with SMTP id j16-20020a170902da9000b001ae10a58349mr1731190plx.23.1686397158163;
        Sat, 10 Jun 2023 04:39:18 -0700 (PDT)
Received: from dw-tp.ihost.com ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902e54a00b001aaf5dcd762sm4753698plf.214.2023.06.10.04.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 04:39:17 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv9 0/6] iomap: Add support for per-block dirty state to improve write performance
Date:   Sat, 10 Jun 2023 17:09:01 +0530
Message-Id: <cover.1686395560.git.ritesh.list@gmail.com>
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

Please find PATCHv9 which adds per-block dirty tracking to iomap.
As discussed earlier this is required to improve write performance and reduce
write amplification for cases where either blocksize is less than pagesize (such
as Power platform with 64k pagesize) or when we have a large folio (such as xfs
which currently supports large folio).

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

Ritesh Harjani (IBM) (6):
  iomap: Rename iomap_page to iomap_folio_state and others
  iomap: Drop ifs argument from iomap_set_range_uptodate()
  iomap: Add some uptodate state handling helpers for ifs state bitmap
  iomap: Refactor iomap_write_delalloc_punch() function out
  iomap: Allocate ifs in ->write_begin() early
  iomap: Add per-block dirty state tracking to improve performance

 fs/gfs2/aops.c         |   2 +-
 fs/iomap/buffered-io.c | 394 +++++++++++++++++++++++++++++------------
 fs/xfs/xfs_aops.c      |   2 +-
 fs/zonefs/file.c       |   2 +-
 include/linux/iomap.h  |   1 +
 5 files changed, 282 insertions(+), 119 deletions(-)

--
2.40.1

