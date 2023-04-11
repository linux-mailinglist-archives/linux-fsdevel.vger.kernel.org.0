Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B946DD18C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 07:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjDKFWo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 01:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjDKFW2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 01:22:28 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEAE26A3;
        Mon, 10 Apr 2023 22:22:27 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id ke16so6713600plb.6;
        Mon, 10 Apr 2023 22:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681190546; x=1683782546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWtmYvDUHt8kYg5jqqc4Ct59dpDebanm65gdKYnekzw=;
        b=mq4EBG43+CLN9nHjNO7faU/506EBO6W9CSZATwWvbY9nnYrq2eb4re5Rm+aMJ+9UsE
         Z2ZjORVIUkf7zIKQ60M6ZXl9Moyhaxbk8rLGs/VQyCd5796uwjRxxoahPmBfq8x5EMfe
         ucxz07cxJN7YJ66yOXLI58c9h5EkKzWPILRiZ2i3Kpf1CRxPUwWD/9SIWM5wZf2DiiDJ
         apofFTOyQaQr424id2oeMezGgRw0wG+AAOWVkfxILGmjYRcUSd/YmLVYzckC49Y6alF1
         NcQxwx3MZ5e3TVdA7eEnZDfMwtLyu3EJG5BlAErYEWmAH1JLtwg11GXYupDobxkPa7Of
         z7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681190546; x=1683782546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWtmYvDUHt8kYg5jqqc4Ct59dpDebanm65gdKYnekzw=;
        b=HdCJ9RQn6PcOKCX678BSg37EHTlSXJsPqklR+18rV0i6BDa8HiF8Sv28JovjGyT2WQ
         sjGkNrIl9YAb3YqH3oIldrboz9vU3wL0TM7JY/+aur86k43UARmip2WPCI+PGArJdRM2
         cRSea/G69fmIRWUazlLsKEi3bTyqux8siF6LBNwyfTQotRNMcwCxSBSqAoocG29TkbP+
         U7Ls+D24wSi1n9gS5kTcGvy8Mf0vAUGJpI6N4ZwxjQ92iE6qHfZdwmn2+iOQmQiwvw06
         rn6j8oh/34YUmwwXp7KBOH6kH6C7cFkRDVSM6a5r80ngWWx66tUCIbwRBQjAAP7H5zIR
         haIQ==
X-Gm-Message-State: AAQBX9cI5ERRgT9UZo3n8BX/Jrj3TS79YP06AosQcRGJW9KeB9FqT9CM
        0Yit6bjQELODj+OsiL4cpab2cear51U=
X-Google-Smtp-Source: AKy350aLeSusBE2JQwzIwO7A+nuyS//Eb69kW6Jdg1Vovy48QNaSef9wwMDXzKZJ9Z69Ej2of8XkpQ==
X-Received: by 2002:a17:90a:aa82:b0:246:9ef5:3c45 with SMTP id l2-20020a17090aaa8200b002469ef53c45mr2201648pjq.13.1681190546594;
        Mon, 10 Apr 2023 22:22:26 -0700 (PDT)
Received: from rh-tp.ibmuc.com ([2406:7400:63:7035:9095:349e:5f0b:ded0])
        by smtp.gmail.com with ESMTPSA id v19-20020a17090abb9300b00246d7cd7327sm646154pjr.51.2023.04.10.22.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 22:22:26 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv2 6/8] iomap: Remove IOMAP_DIO_NOSYNC unused dio flag
Date:   Tue, 11 Apr 2023 10:51:54 +0530
Message-Id: <86d8ef97a805c61761846ee7371c95131ec679be.1681188927.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681188927.git.ritesh.list@gmail.com>
References: <cover.1681188927.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

