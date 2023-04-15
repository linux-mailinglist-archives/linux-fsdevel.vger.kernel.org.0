Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524E66E2F7E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Apr 2023 09:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjDOHom (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Apr 2023 03:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjDOHol (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Apr 2023 03:44:41 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A516D7EF4;
        Sat, 15 Apr 2023 00:44:39 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so1208384a12.1;
        Sat, 15 Apr 2023 00:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681544679; x=1684136679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nuhNVdlGPw6k76QHxAotfJZ5tPw3XtlEJ9YeMfVt5tQ=;
        b=Ft8IzVOljPg6JRa/nReAk9YYNWOkSHj59UCrV55AanxgitiazgN9xztW0pCjV8BEcn
         qb3WGBHE9YKoFgombHfjldFDJ8ETQiGheIYX8d7d202h5JYPdvNECTACfjd9mIkDzL5M
         wYxn7f6uWrPG9qnzUXblT4VM0WGymgNoOVYsiPIupowyrgsEB3cWYvReWtJOhDJ3NXRF
         mgVcSm1yQWX05y6gn3iZTH98r91cblRgeWSv46UXi68goX3NC8JKp6GDuUPAF244Wv69
         yNhgcrWSlzQX93FGpLMZ157ecFzwwQ1Jkfx7xWz6MshhIoKtIMa5Owqp3vBRIKkuuT5Q
         tTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681544679; x=1684136679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nuhNVdlGPw6k76QHxAotfJZ5tPw3XtlEJ9YeMfVt5tQ=;
        b=ZsuJpCMA0DjWiS3CCm/jkICKH8T8MiyCRoYyJpb2qApud1UGz8DKWkdloe7cyidhpP
         nB34tNctvQ0mm2Mpbwxoa9/3Ek2R4Ly/8/emmiRbcNhkfTQoR3+u1QIy9LiYaUxYhwUN
         L9WZpiQvdrfzdaLaZDvPQBUSKNeIKDLvyvufqZo9aAe+VOWwr2+Sygxacu5Wr2aemQpn
         w4ShEL0qKnk9I1kMMZ61Nw91Byx1aUwNqkUpp8Kvfp1eOdLAplOYYtQ1vO//DDwR6mL9
         oDAxgwhIFhPlOfD6Knzg4Sm6/4MwfF9+2imdPFP7nxywm5a28dkTZbzxyvE2IwCHGLNf
         9Uvw==
X-Gm-Message-State: AAQBX9ckeQVoRFlo9fDYdKRy7ZspizplES28C7aRFT/6FiolqAiTSLwm
        fOoF+yl0vuPGFUAkm6TFJGxTjmD7gaU=
X-Google-Smtp-Source: AKy350bfuBHeSEqThKdIvDCGjNpAqgRNs0wSR4gDCvCEKaK6F3bEddQJEsaezxYxgmHpbPA6KuRKBA==
X-Received: by 2002:a05:6a00:21c2:b0:63b:2102:a1c9 with SMTP id t2-20020a056a0021c200b0063b2102a1c9mr11658637pfj.22.1681544678602;
        Sat, 15 Apr 2023 00:44:38 -0700 (PDT)
Received: from rh-tp.. ([2406:7400:63:2dd2:1827:1d70:2273:8ee0])
        by smtp.gmail.com with ESMTPSA id e21-20020aa78255000000b0063b675f01a5sm2338789pfn.11.2023.04.15.00.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 00:44:38 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv4 0/9] ext2: DIO to use iomap
Date:   Sat, 15 Apr 2023 13:14:21 +0530
Message-Id: <cover.1681544352.git.ritesh.list@gmail.com>
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

Please find the series which rewrites ext2 direct-io path to use modern
iomap interface.

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
It has now been tested on x86 and Power with different configurations.
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
  iomap: Add couple of DIO tracepoints

 fs/buffer.c                 |  43 ++++++++++++
 fs/ext2/Makefile            |   5 +-
 fs/ext2/ext2.h              |   1 +
 fs/ext2/file.c              | 128 +++++++++++++++++++++++++++++++++++-
 fs/ext2/inode.c             |  58 +++++++++-------
 fs/ext2/trace.c             |   6 ++
 fs/ext2/trace.h             |  94 ++++++++++++++++++++++++++
 fs/ext4/fsync.c             |  32 ++++-----
 fs/iomap/direct-io.c        |   7 +-
 fs/iomap/trace.c            |   1 +
 fs/iomap/trace.h            |  35 ++++++++++
 include/linux/buffer_head.h |   2 +
 include/linux/fs.h          |  14 ++++
 include/linux/iomap.h       |   6 --
 14 files changed, 384 insertions(+), 48 deletions(-)
 create mode 100644 fs/ext2/trace.c
 create mode 100644 fs/ext2/trace.h

--
2.39.2

