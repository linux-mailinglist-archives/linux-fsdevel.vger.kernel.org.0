Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830F16E2F8F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Apr 2023 09:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjDOHpc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Apr 2023 03:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjDOHpC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Apr 2023 03:45:02 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B322C9742;
        Sat, 15 Apr 2023 00:45:01 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63b5c4c76aaso488437b3a.2;
        Sat, 15 Apr 2023 00:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681544701; x=1684136701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h3bFGTlu3ywJiImKEXsaqXr4UVp+VKQfACyqLEyVcDA=;
        b=rqMdHgKtL8a63yiIEjpiwlXwkF9YbeGj46sA7GCKNX+IbxgCF3hCl4MmAOzSkueg4/
         0nvmop8ZOHQZJY1tzjJHBoshlEnotOM+2CAXUuWbHgEGQ/l0CuZskFxwKqMTaIImxuXB
         kf/tphfugu2IxUS0e5p64tkgV8J8aIJ88Op2BWvB9pTFfUi31uhlYe9UvjcfTFeHey/K
         qEy5Glht6VSM9YIWWwFs5KUeZRK1PZkHcwrYj36feYWRTI4dTj9kXH/W55NBR+Atyy8U
         h+B+Yr98a+zhj0v30u3ToxGnzIqQMsiN6B/TeW7WR8K0C2LQwruaYzMuxrE0cZN1ddPn
         mHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681544701; x=1684136701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h3bFGTlu3ywJiImKEXsaqXr4UVp+VKQfACyqLEyVcDA=;
        b=ASI9oVkoSPgk+m7oqVG/3UKauss/gMBeFlLdFSnakFXwuEjznIX57/ins3k7y8Hz3+
         /78ELA3KlGGXB95nD5EUSLN7n24t1RLxnMfRdq+HO4xWYj8achCL5J4TqKyzL0G6VO7E
         +O/rf+eI2Nsa+F/1Wk885njJO74jOKOCpsvUrT3plb7RX+SXIINvPEgGPO7Zh4rDYQH5
         VcaPgqSpD4dxEBj9q1ysSH9iOGnRhFJhtgO64amUpE1kVycBRgu+FYVyMt0SmP13KH0J
         dPpF0wLd28EDycTAHiYIdGVgYoMBzWj8FCEab4fYU3lj325OXcYKWoYVAtqd/oDxr0qA
         Lo2Q==
X-Gm-Message-State: AAQBX9cwJphaDNjC//htORu5Ln432D4er9GhcT2POiS+XQbsMWRK6+Dr
        YambhOgyDEkLrpcOO9C8UIe3OdCfuQE=
X-Google-Smtp-Source: AKy350Z7K9hQWK0ODGog7Gg4kBjX4TEWrmZ5vgneHSaNZp7ABstvZLv52a7mB56nquLZaSDtDFVPJQ==
X-Received: by 2002:a05:6a00:10c7:b0:5a8:a0df:a624 with SMTP id d7-20020a056a0010c700b005a8a0dfa624mr11744429pfu.22.1681544701013;
        Sat, 15 Apr 2023 00:45:01 -0700 (PDT)
Received: from rh-tp.. ([2406:7400:63:2dd2:1827:1d70:2273:8ee0])
        by smtp.gmail.com with ESMTPSA id e21-20020aa78255000000b0063b675f01a5sm2338789pfn.11.2023.04.15.00.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 00:45:00 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [RFCv4 8/9] iomap: Remove IOMAP_DIO_NOSYNC unused dio flag
Date:   Sat, 15 Apr 2023 13:14:29 +0530
Message-Id: <98ac88dea1a83a8083f5a741e4af400f27821a48.1681544352.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681544352.git.ritesh.list@gmail.com>
References: <cover.1681544352.git.ritesh.list@gmail.com>
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

IOMAP_DIO_NOSYNC earlier was added for use in btrfs. But it seems for
aio dsync writes this is not useful anyway. For aio dsync case, we
we queue the request and return -EIOCBQUEUED. Now, since IOMAP_DIO_NOSYNC
doesn't let iomap_dio_complete() to call generic_write_sync(),
hence we may lose the sync write.

Hence kill this flag as it is not in use by any FS now.

Tested-by: Disha Goel <disgoel@linux.ibm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
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

