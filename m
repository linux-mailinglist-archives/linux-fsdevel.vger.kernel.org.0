Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21D86E36E9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Apr 2023 12:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjDPKJA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Apr 2023 06:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjDPKI7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Apr 2023 06:08:59 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A91121;
        Sun, 16 Apr 2023 03:08:57 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-63b5312bd4fso3944760b3a.0;
        Sun, 16 Apr 2023 03:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681639736; x=1684231736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bYjCJCd7HniX0nQkvGKpF0YZsxFE+bA0a1PIYs0jE5s=;
        b=kYzS3uHOJEPPRTkKZKh3W6jZOWkPauyfgFef96OIoJmkuqsNJFAaVhjiqThLV7EAMf
         AEPkVhQtgXKF0vCqQ5igO/M1/R9G2ZzASnKWYL4+qhhATV8AUHW2AsSfr4i5ccMu8a2H
         rN0xQDzCElkfTjhcTZXwISGqpPjw0vZdLUVc771Mvxs1nnyqEBQbiwAi5gL/u9capPVk
         MmvAiQZ8sfjTtDVR1sZs2koJxhDEQ+Rw3PsTHRBIH7FyN0uuXaM9OoF1i7/aNo5rKkoS
         jiCU1RmP8yaL5flUNw59tvYPWq2xoFDCTSSYEH8lkY+zhdFJn7cn5LP+nbdyshiMUbKL
         xrog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681639736; x=1684231736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bYjCJCd7HniX0nQkvGKpF0YZsxFE+bA0a1PIYs0jE5s=;
        b=gsoFPQGwq258HJKWUZGztxX66XC0lW+bnJi1LNR9EHTdkM40FC80xmZhcNDATJDxTY
         xCjYsxzlzThaIAVjhbptxGO2M/NVcMG2P8WYI3DmcyVwLrUNKP83nH4mI1V5kgL3W0Me
         //77nIaELu9MTQmlw8SKY4wGuAoHshjVBUog/6WOSDvOk/qDoKpdQjSM/rVY2/j4tzja
         yN2WQqnCOao8WvTwc1O0joWr7oHhGKhW2rp4EBnLP57bOPCciw9+LR0GgbE/X2KLb16C
         gj59MMmqKqTDt8IjQAyIgCv4k4ytke0Ub1JYJ6z9/491wwBI2kwb090wORL1V0U6kZlJ
         tV4g==
X-Gm-Message-State: AAQBX9efDRIezfMmWZyquey4ME8Vn2rvlxup4A6ismt3W/F4ljcS5hTp
        +Qg8J1Vwdri69UwPoVWsONGz+aytyvs=
X-Google-Smtp-Source: AKy350ZZyHkbJfJUj2TFb5BmwtahELas7Sd6JIVwQAIpCikDUxb9qh4ZflJkOK2tmDVLaOVpNzFqWA==
X-Received: by 2002:a05:6a00:a0a:b0:63b:6279:1039 with SMTP id p10-20020a056a000a0a00b0063b62791039mr9901314pfh.0.1681639736337;
        Sun, 16 Apr 2023 03:08:56 -0700 (PDT)
Received: from rh-tp.. ([2406:7400:63:2dd2:1827:1d70:2273:8ee0])
        by smtp.gmail.com with ESMTPSA id h9-20020aa786c9000000b0063b733fdd33sm3096057pfo.89.2023.04.16.03.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 03:08:55 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv5 0/9] ext2: DIO to use iomap
Date:   Sun, 16 Apr 2023 15:38:35 +0530
Message-Id: <cover.1681639164.git.ritesh.list@gmail.com>
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
  fs/buffer.c: Add generic_buffer_fsync implementation
  ext4: Use generic_buffer_fsync() implementation
  ext2: Use generic_buffer_fsync() implementation
  ext2: Move direct-io to use iomap
  fs.h: Add TRACE_IOCB_STRINGS for use in trace points
  ext2: Add direct-io trace points
  iomap: Remove IOMAP_DIO_NOSYNC unused dio flag
  iomap: Add DIO tracepoints

 fs/buffer.c                 |  43 ++++++++++++
 fs/ext2/Makefile            |   5 +-
 fs/ext2/ext2.h              |   1 +
 fs/ext2/file.c              | 128 +++++++++++++++++++++++++++++++++++-
 fs/ext2/inode.c             |  58 +++++++++-------
 fs/ext2/trace.c             |   6 ++
 fs/ext2/trace.h             |  94 ++++++++++++++++++++++++++
 fs/ext4/fsync.c             |  32 ++++-----
 fs/iomap/direct-io.c        |   9 ++-
 fs/iomap/trace.c            |   1 +
 fs/iomap/trace.h            |  78 ++++++++++++++++++++++
 include/linux/buffer_head.h |   2 +
 include/linux/fs.h          |  14 ++++
 include/linux/iomap.h       |   6 --
 14 files changed, 429 insertions(+), 48 deletions(-)
 create mode 100644 fs/ext2/trace.c
 create mode 100644 fs/ext2/trace.h

--
2.39.2

