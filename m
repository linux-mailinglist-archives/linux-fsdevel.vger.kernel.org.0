Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1946E0911
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 10:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjDMIlT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 04:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDMIlS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 04:41:18 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD6E83F8;
        Thu, 13 Apr 2023 01:41:17 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-62e102cadc7so1375072b3a.2;
        Thu, 13 Apr 2023 01:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681375276; x=1683967276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8/ZaY0xr/jE2+Wplbsl66naYkEg3/FOVBW0OMgY/EV4=;
        b=FUKmwuazEUG6Rw8osAewknIt/OT0FBs02+/U9U/Swh9P7/FKC2uWWKAymZOGA9Ilkf
         RL6ZCZf8+MMbNKfuuRv8ad6LcQQZQpLTHgV16G2KTKEdueutKmnunnS22bYhQrDzb/x4
         PGDSuubYWMPSNlIRW3XviOxeDLXRpH9sbwdLjgFKqKW+6GIqbLqM4zxttxlsxvqT+ECq
         pusGeYTYFnPRbKgmkCcDjcj3mCGU+ZeKNszmHdnaz0oq38qnim5zQnlAWoQVmcN0E4Wl
         m0fXOcYglCRUTJkQY7izv14SRyl1RiXb+TJD45BQNDCRcQ8zpWfcb4TTObwq9efCavSV
         ZhRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681375276; x=1683967276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8/ZaY0xr/jE2+Wplbsl66naYkEg3/FOVBW0OMgY/EV4=;
        b=g/vsOrTYU3PmeZn05sfhZ+01zIXK2i1I9uW7noaLNZPMXI0+AcajxE7ZzZq8d7bZde
         VKATxImRCe8ggxzC2BTCZpKOVQEpauMqTIISFW5B3s4w2dQs94kcSDleY7p2BGHogRIl
         aeAHAwVasBtVedwxUlQsW+TCVCPTLPgR1/6Fdh6V2XLEn6/WuydcPyUSKAlMgwpQhbix
         pBfdwAgGvY56MiXHauDWb+x2H1yPfMfoF8ZLoTLd3fj8CMKxu6lQlCA7bU6xHkQBZ3Rp
         ALa5wT34WhHJRzKufvQqOu66GHHN8ZSqJT2sXlxzIVwlPHwwCk8KD0kpznypYmdH4ZA1
         pWug==
X-Gm-Message-State: AAQBX9cahktZo2+K2jIXT2bEz/oZYsocr83EDY7nfWzB/jUBWCXZNXsa
        LaYf8Nc9btEicZqKcLSHVIVEI+28YHw=
X-Google-Smtp-Source: AKy350ZkeFxUCw51pkNb1CodIKGKS2tNwLwDihPqBXqOZEFquqF1yQeq7Mvf/x0+07B6SDsQYnsYFg==
X-Received: by 2002:a05:6a00:2345:b0:623:5880:98cd with SMTP id j5-20020a056a00234500b00623588098cdmr2880711pfj.5.1681375276390;
        Thu, 13 Apr 2023 01:41:16 -0700 (PDT)
Received: from rh-tp.. ([2406:7400:63:7035:9095:349e:5f0b:ded0])
        by smtp.gmail.com with ESMTPSA id g8-20020aa78188000000b0063b23c92d02sm817243pfi.212.2023.04.13.01.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 01:41:16 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv3 00/10] ext2: DIO to use iomap
Date:   Thu, 13 Apr 2023 14:10:22 +0530
Message-Id: <cover.1681365596.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Please find the series which moves ext2 direct-io to use modern iomap interface.

RFCv2 -> RFCv3:
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
It has now been tested on x86 and Power with different configurations.
Please let me know if anything else is required on this.

v2: https://lore.kernel.org/all/ZDTybcM4kjYLSrGI@infradead.org/

Ritesh Harjani (IBM) (10):
  ext2/dax: Fix ext2_setsize when len is page aligned
  libfs: Add __generic_file_fsync_nolock implementation
  ext4: Use __generic_file_fsync_nolock implementation
  ext2: Use __generic_file_fsync_nolock implementation
  ext2: Move direct-io to use iomap
  fs.h: Add TRACE_IOCB_STRINGS for use in trace points
  ext2: Add direct-io trace points
  iomap: Remove IOMAP_DIO_NOSYNC unused dio flag
  iomap: Minor refactor of iomap_dio_rw
  iomap: Add trace points for DIO path

 fs/ext2/Makefile      |   5 +-
 fs/ext2/ext2.h        |   1 +
 fs/ext2/file.c        | 127 +++++++++++++++++++++++++++++++++++++++++-
 fs/ext2/inode.c       |  58 +++++++++++--------
 fs/ext2/trace.c       |   6 ++
 fs/ext2/trace.h       |  94 +++++++++++++++++++++++++++++++
 fs/ext4/fsync.c       |  31 +++++------
 fs/iomap/direct-io.c  |  16 ++++--
 fs/iomap/trace.c      |   1 +
 fs/iomap/trace.h      |  90 ++++++++++++++++++++++++++++++
 fs/libfs.c            |  43 ++++++++++++++
 include/linux/fs.h    |  16 ++++++
 include/linux/iomap.h |   6 --
 13 files changed, 444 insertions(+), 50 deletions(-)
 create mode 100644 fs/ext2/trace.c
 create mode 100644 fs/ext2/trace.h

--
2.39.2

