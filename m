Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFB97447BB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jul 2023 09:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjGAHf0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Jul 2023 03:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjGAHfY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Jul 2023 03:35:24 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDBB199;
        Sat,  1 Jul 2023 00:35:23 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3a1a47b33d8so2110466b6e.2;
        Sat, 01 Jul 2023 00:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688196922; x=1690788922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z46IE+Wb1Co+S9765aq/4PqiPsKv7xdaoquDMMnByas=;
        b=bqXISYmLAOCxUFmdzWfUHdTmwjhiOkqcfVGtbCAaocPjuFqqVH2PvC1OiUR1xJMDsU
         50vfaSkKBZWEp0PL+ZAxerkC9an3nkyqfafXi5gfCeAwTIBX0nvsetemSu4CSEtN9KXq
         XRXn3QIqRegv2GHd8j4akxy7w4K2o9DH0FMZDYVg3U0jbGTM/KTzXA/j3V+og2XYEwk4
         AUUpkRrEzHRb/WrJgjxWljH3fJKl7w6hP+PlXoZl7rD7C20E4g3jhh8SjO36jItiHkYL
         +MaYxMtmWggMo92/kUKdzk9khnIl1osl8XXIBMbFlAv0u6aMcAJtBxFy9LlvcdTCaOwo
         uONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688196922; x=1690788922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z46IE+Wb1Co+S9765aq/4PqiPsKv7xdaoquDMMnByas=;
        b=A85bxJOx/9yZdbjvLpk0eCRMa+DbJlyeJ1sfaIciOOwloiVMOKAaryhJqdnzaECqot
         71/fidodFRrcPSkLXnm7iJTElF4zTZz7WSIsq5cLuDifc4VzNvmqv9NXxD6Afg0A0thD
         C/F/P74n8FrpmmJOUoZR3Zlmru3ST/9uA6LlOE14Jm0XKCrHQzAJGHKV7gpE4YEPozAQ
         QDZknO4i0FDjXwlpXlMX+poG0b1NK0SnmnDYqFITnKh6fWZQXy5O1071xC+s49Tc+GQM
         4R4CVGbzBWS0FOxfuHRrpS8KYtdzFnPiGb5NsHYpQNdtOkEi3T9J23Snzy/kWOYOiJwd
         p9cg==
X-Gm-Message-State: AC+VfDw5+yidvO1XSN/bKgF0WJuecjcTB02bDjduR7u6skzVKP1gn6H3
        Hydv1E7/jyhtWCrhCeKfUApV9W/7S24=
X-Google-Smtp-Source: ACHHUZ5Te+3HnuKZ11DUjJFGAVp2yX2Wkjs1csWLOAC1qNAJQLYkcUeSa4hlZ1ZF87MoLEZ3SYaUjA==
X-Received: by 2002:a05:6808:1827:b0:3a3:6c7d:a5cb with SMTP id bh39-20020a056808182700b003a36c7da5cbmr5933536oib.46.1688196921736;
        Sat, 01 Jul 2023 00:35:21 -0700 (PDT)
Received: from dw-tp.localdomain ([49.207.232.207])
        by smtp.gmail.com with ESMTPSA id h14-20020aa786ce000000b0063aa1763146sm8603414pfo.17.2023.07.01.00.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jul 2023 00:35:21 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv11 0/8] iomap: Add support for per-block dirty state to improve write performance
Date:   Sat,  1 Jul 2023 13:04:33 +0530
Message-Id: <cover.1688188958.git.ritesh.list@gmail.com>
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

Please find PATCHv11 which adds per-block dirty tracking to iomap.
As discussed earlier this is required to improve write performance and reduce
write amplification for cases where either blocksize is less than pagesize (such
as Power platform with 64k pagesize) or when we have a large folio (such as xfs
which currently supports large folio).

Thanks everyone for helping with reviews and suggestions.

v10 -> v11:
===========
1. Dropped iomap_block_state enum. Thereby automatically addressing variables
   names like first_blk etc. in bitmap handling functions.

Testing of v11:
===============
1. I have done fstests testing of v11 on my setup for x86 (1k & 4k bs),
   arm (4k bs) and Power (4k bs) with xfstests. I haven't found any new
   failures as such in my testing so far with xfstests.
2. I have also done some random read/write testing using fio & haven't
   observed any performance issues in my testing so far.

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
 fs/iomap/buffered-io.c | 402 ++++++++++++++++++++++++++++-------------
 fs/xfs/xfs_aops.c      |   2 +-
 fs/zonefs/file.c       |   2 +-
 include/linux/iomap.h  |   1 +
 5 files changed, 281 insertions(+), 128 deletions(-)

--
2.40.1

