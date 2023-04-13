Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A909C6E0920
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 10:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjDMIlu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 04:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjDMIln (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 04:41:43 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA31C9004;
        Thu, 13 Apr 2023 01:41:39 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6375ec15c48so883383b3a.1;
        Thu, 13 Apr 2023 01:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681375299; x=1683967299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KiBBvPcLWpcg6K6Pmd0AtAxNME4Yy5xrjkD7fmrXZyM=;
        b=fDJakotFHS1ZrJgf2CV0cmz61+0aDbITryi9ucO2cTTk5/DlIZzgQI9LGeBwa/eDtu
         AnRX+tsdV9LmdB9USFN3WhQ/xtcl1N/e7+eLEW1tR05rC1iuEyFp5FNBm5QcqOm8W3v0
         r40XPsmupAPuoxuCo5a8cvLVKC1fa3OQFHB9GlEWXKaEXxPxl10qwI6BtCRzXwHUZjTj
         JPDu9nzBpS08IqYQYoDNEEG3X1kHz6LHTRQZiwzZtPNxh+Q+82Y/5FlSrv09G3/DFjr+
         X2xdoWHbkskiaLhLyxJfM6+3oB2CP8oxNChmhh3S7oFfDhrs1OiwDabKXEtG/KC7tnJQ
         wCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681375299; x=1683967299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KiBBvPcLWpcg6K6Pmd0AtAxNME4Yy5xrjkD7fmrXZyM=;
        b=TW1oFppf1WHsz/ozBKe2+j1B4M7leI8ebI/FXyc5aOsK/NL5A3Y91M3VxpAO0Nsf5b
         B7ZDxmG/Lz3EffOIK2hO7TrDKQQSI+n9bxH+LdoevYidhd82crTZUNS/P8r+zDPiI6EU
         ydMqp+GELkO4+w/dCOtSXwP/cmQtBiR57txnaFdFzYasz60fYEtrkNg8FsNnpIg6cdaQ
         t4yOEBgehAkWS++GqFsWhv9VoSnCv9rMdYhOefiFc1xbAagI1q86Plr+sgRczS95qp5U
         CrrXlKB0IHAKkzQTINjGrGzvyDQb/d0B/KaevFj8FKuM5aeSnsvypFxPn0NBX6fGhXm4
         K1sg==
X-Gm-Message-State: AAQBX9f73nAZnv4dzgE5iailZAkJh5Q1SPY12+S1TJkw1acbdABGr19F
        9ht+Nv4DMGM9mKKpZY33lDt9WgWItas=
X-Google-Smtp-Source: AKy350blEoeVzJGNHgSlwJLlNNLrooClPilqJf6OsumGLHU0Kwnzm5xWmgjFVjUlJMKxoMLZn3u7oA==
X-Received: by 2002:a05:6a00:a86:b0:63a:ece0:48d0 with SMTP id b6-20020a056a000a8600b0063aece048d0mr2278352pfl.28.1681375298926;
        Thu, 13 Apr 2023 01:41:38 -0700 (PDT)
Received: from rh-tp.. ([2406:7400:63:7035:9095:349e:5f0b:ded0])
        by smtp.gmail.com with ESMTPSA id g8-20020aa78188000000b0063b23c92d02sm817243pfi.212.2023.04.13.01.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 01:41:38 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [RFCv3 08/10] iomap: Remove IOMAP_DIO_NOSYNC unused dio flag
Date:   Thu, 13 Apr 2023 14:10:30 +0530
Message-Id: <48a867b27a62045987f55b576b7688d16a896d52.1681365596.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681365596.git.ritesh.list@gmail.com>
References: <cover.1681365596.git.ritesh.list@gmail.com>
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

IOMAP_DIO_NOSYNC earlier was added for use in btrfs. But it seems for
aio dsync writes this is not useful anyway. For aio dsync case, we
we queue the request and return -EIOCBQUEUED. Now, since IOMAP_DIO_NOSYNC
doesn't let iomap_dio_complete() to call generic_write_sync(),
hence we may lose the sync write.

Hence kill this flag as it is not in use by any FS now.

Tested-by: Disha Goel <disgoel@linux.ibm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/iomap/direct-io.c  | 2 +-
 include/linux/iomap.h | 6 ------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index f771001574d0..36ab1152dbea 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -541,7 +541,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		}
 
 		/* for data sync or sync, we need sync completion processing */
-		if (iocb_is_dsync(iocb) && !(dio_flags & IOMAP_DIO_NOSYNC)) {
+		if (iocb_is_dsync(iocb)) {
 			dio->flags |= IOMAP_DIO_NEED_SYNC;
 
 		       /*
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 0f8123504e5e..e2b836c2e119 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -377,12 +377,6 @@ struct iomap_dio_ops {
  */
 #define IOMAP_DIO_PARTIAL		(1 << 2)
 
-/*
- * The caller will sync the write if needed; do not sync it within
- * iomap_dio_rw.  Overrides IOMAP_DIO_FORCE_WAIT.
- */
-#define IOMAP_DIO_NOSYNC		(1 << 3)
-
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
 		unsigned int dio_flags, void *private, size_t done_before);
-- 
2.39.2

