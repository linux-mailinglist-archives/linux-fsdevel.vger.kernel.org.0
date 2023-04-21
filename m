Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D936EA777
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 11:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjDUJrC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 05:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjDUJrA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 05:47:00 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F540A268;
        Fri, 21 Apr 2023 02:46:30 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-63b51fd2972so1713199b3a.3;
        Fri, 21 Apr 2023 02:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682070389; x=1684662389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xb1I4jqgfui9BU7UH5cPLKSUiRB5/jMDgVPekQInLI4=;
        b=db0ysnwjEL4MMTtuibm5DFQ7dBX457xUNSV2a2CTDNmdEssxO5CUHguDlGbhx4Ie6R
         ikMXJfmW9JFQW4s742Zh9gfXu4nImNBLUBUA7Om9Yd8f3gj2zpKTzrUM2s4ntNF3OZOv
         tnSX6myTBrrdJxaGx7SnFH8owCZ2mjWkKVqbkkgbS0FM7/Kbrug/LvVEZf2iohqI6LC8
         fJWz6F4pM+47HjTaH1t4/EkZAVY99bmLwq6j3lmWrt37+ZjWZHulZ4raagrliAB5G4uj
         efwYDIy72w2arBsi6Rh7tz8CZgYg/nxnRlIFb3OmX5oigbHljO9QTokuOiP75j096ofr
         xMtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682070389; x=1684662389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xb1I4jqgfui9BU7UH5cPLKSUiRB5/jMDgVPekQInLI4=;
        b=cm8s/Im5rlVL9Sf6nN0c7AlPfZKLRmzr+HNfAQ8zlN6HqXhhL6K7+MPSYGTd2dKB2M
         /mDvmXmn62TBBSvfI5QLR0puJ0TRjJx7Z+G+Egh5tmCtc96CRzVvPvWMO9cMAqfRJPxG
         dpWX35+c7N/w2lqHXEVcuE0ZbC7LgtztbFj5sQHxSC7YR+Dq5Rslvzr6YLE+bEfeI8PN
         c6qRjAP5YN7KgGAlg+eA/vOMNT4qhGmQEk3nDlYubLctvl+vg0slzI0im/HpHomhcpA8
         ePeFTEwcq9FvcRASUN6pmL+W1onA38sI7RN55BSPBOOm62e/P2idaipvYWrq5xNsuqfJ
         LxYg==
X-Gm-Message-State: AAQBX9d2fD6qONB77pyfuMdR9TX6zYF6Ba6ml3F3X+GRIcQO63ByjQs2
        oF+LVgFYdTMn9XimBEw1oZ/s/9n1D04=
X-Google-Smtp-Source: AKy350YQoSo/hf7Z51wCoQMUt9ReY/Sp8MdgIZuMVqCzwbxnbtQNyJ07O/bvHYgvxFhhP8MX3D0/RQ==
X-Received: by 2002:a05:6a20:258c:b0:ef:f558:b76 with SMTP id k12-20020a056a20258c00b000eff5580b76mr7545426pzd.5.1682070388978;
        Fri, 21 Apr 2023 02:46:28 -0700 (PDT)
Received: from rh-tp.. ([2406:7400:63:2dd2:8818:e6e1:3a73:368c])
        by smtp.gmail.com with ESMTPSA id w35-20020a631623000000b0051f15c575fesm2295376pgl.87.2023.04.21.02.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 02:46:28 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv6 0/9] ext2: DIO to use iomap
Date:   Fri, 21 Apr 2023 15:16:10 +0530
Message-Id: <cover.1682069716.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
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

Please find the series which rewrites ext2 direct-io path to use modern
iomap interface.

PATCHv5 -> PATCHv6:
===================
1. Patch-2 Added generic_buffers_fsync_noflush() & generic_buffers_fsync() functions.
2. Patch-3 & Patch-4 to use above functions in ext4 & ext2.
3. Added Reviewed-by from Christoph on Patch-9 (iomap: Add DIO tracepoints)

RFCv4 -> PATCHv5:
=================
1. Added trace_iomap_dio_rw_begin tracepoint in __iomap_dio_rw()
2. Added Reviewed-by tags from Christoph

RFCv3 -> RFCV4:
===============
1. Renamed __generic_file_fsync_nolock() from libfs to generic_buffer_fsync() in
   fs/buffer.c
   (Review comment from Christoph)
2. Fixed s/EVENTD/EVENTFD/ in TRACE_IOCB_STRINGS
3. Fixed few data types for parameters in ext2 trace patch (size_t && ssize_t)
4. Killed this patch "Minor refactor of iomap_dio_rw"
5. Changed iomap tracepoint patch and fixed the data types (size_t && ssize_t)
   (addressed review comments from Christoph)

RFCv2 -> RFCv3:
===============
1. Addressed minor review comments related to extern, parameter naming in
   function declaration, removing not required braces and shorting overly long
   lines.
2. Added Reviewed-by from various reviewers.
3. Fixed a warning & couple of compilation errors in Patch-7 (ext2 trace points)
   related to CFLAGS_trace & second related to unable to find function
   definition for iov_iter_count(). (requires uio.h file)
   CFLAGS_trace is required in Makefile so that it can find trace.h file from
   tracepoint infrastructure.
4. Changed naming of IOCB_STRINGS TO TRACE_IOCB_STRINGS.
5. Shortened naming of tracepoint events for ext2 dio.
6. Added iomap DIO tracepoint events.
7. Disha tested this series internally against Power with "auto" group for 4k
   and 64k blocksize configuration. Added her "Tested-by" tag in all DIO
   related patches. No new failures were reported.

Thanks everyone for the review and test. The series is looking good to me now.
It has been tested on x86 and Power with different configurations.
Please let me know if anything else is required on this.

v2: https://lore.kernel.org/all/ZDTybcM4kjYLSrGI@infradead.org/

Ritesh Harjani (IBM) (9):
  ext2/dax: Fix ext2_setsize when len is page aligned
  fs/buffer.c: Add generic_buffers_fsync*() implementation
  ext4: Use generic_buffers_fsync_noflush() implementation
  ext2: Use generic_buffers_fsync() implementation
  ext2: Move direct-io to use iomap
  fs.h: Add TRACE_IOCB_STRINGS for use in trace points
  ext2: Add direct-io trace points
  iomap: Remove IOMAP_DIO_NOSYNC unused dio flag
  iomap: Add DIO tracepoints

 fs/buffer.c                 |  70 ++++++++++++++++++++
 fs/ext2/Makefile            |   5 +-
 fs/ext2/ext2.h              |   1 +
 fs/ext2/file.c              | 126 +++++++++++++++++++++++++++++++++++-
 fs/ext2/inode.c             |  58 ++++++++++-------
 fs/ext2/trace.c             |   6 ++
 fs/ext2/trace.h             |  94 +++++++++++++++++++++++++++
 fs/ext4/fsync.c             |  33 +++++-----
 fs/iomap/direct-io.c        |   9 ++-
 fs/iomap/trace.c            |   1 +
 fs/iomap/trace.h            |  78 ++++++++++++++++++++++
 include/linux/buffer_head.h |   4 ++
 include/linux/fs.h          |  14 ++++
 include/linux/iomap.h       |   6 --
 14 files changed, 456 insertions(+), 49 deletions(-)
 create mode 100644 fs/ext2/trace.c
 create mode 100644 fs/ext2/trace.h

--
2.39.2

