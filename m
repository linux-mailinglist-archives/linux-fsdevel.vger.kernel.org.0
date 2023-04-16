Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4675C6E36F5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Apr 2023 12:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjDPKJt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Apr 2023 06:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjDPKJ3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Apr 2023 06:09:29 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C921701;
        Sun, 16 Apr 2023 03:09:19 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-51b514a8424so598801a12.1;
        Sun, 16 Apr 2023 03:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681639759; x=1684231759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h3bFGTlu3ywJiImKEXsaqXr4UVp+VKQfACyqLEyVcDA=;
        b=LHc5DDwMKoTTJl1HKDFCU1duee4f21RvBWu8RQpFUfXb6WY0q6Lzwa1wm6tPVl9OKP
         1sFdbJJzvVrmU/N/J9XxVWPdYPUvrpHs0nji6yicbEPPzZJFHbmMYCS15ksmclPaFh6C
         4eDxDeGPzT9rkox7u373FWy/0S65flGl2bumnC3EMDKxZX2Bn4OpVdLjl5hth7cMcBPq
         jMO7Kl0ti2S0P0FSNDBxn+Pebx/eHRdd3eAxLpC+pqFLyKtfAbe9BEqvpThDa28U+Cae
         +X+NERWg3LaZWail9yA1vhUd1rRPsw8yxVhoLFPmPq5/S33Egqz9NAu6Lf2F/FdCh1Wp
         v1Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681639759; x=1684231759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h3bFGTlu3ywJiImKEXsaqXr4UVp+VKQfACyqLEyVcDA=;
        b=HW7+Tij3kGgxgUMFKSW7+OUdfwrW7NGnZafVBVwGY4BQg8v1OcL2OMCxbF0O/Qz8P5
         nW2/k2EUcS5BJWmUN+o7bvVj8RNkX32Xp0SNHZgSq/yH7liTpB5psOwRgwN7nY4bYuCk
         O1YH2q6g1kASUPAFCx/8KXATLKXS4SLELZ/fEVzZh23bKQsvPArLhktN5OVNquvmsc+6
         gZjfvKZOy8nuD9FCjzVA9INuSh7QQsG2BSJa7tdANbnaNDE3iQl1csfgZqBzxw95uvmI
         6UU9Dj/OSRkr4QBnDddUvFGNoRdmfh6lFsFWLQtC7BvvmWXdVsikgx0p178eM5ib3t72
         0TEg==
X-Gm-Message-State: AAQBX9fP6k6ZPTy3VUmQx5kLO1TcLoU0nFQPJMTa/OS3ssHvj2zHWj4c
        npkSBaxXNtb6hbYOxn4lRoHZUZ0VEhE=
X-Google-Smtp-Source: AKy350YL7k8+NTT4qwSLYo76D8pkPDs5y/W3N43KQ2e196BvyqhA9DMEzy+uussxLr+bm7jxSBCJqw==
X-Received: by 2002:a05:6a00:804:b0:63a:ea82:b7af with SMTP id m4-20020a056a00080400b0063aea82b7afmr17777070pfk.31.1681639758848;
        Sun, 16 Apr 2023 03:09:18 -0700 (PDT)
Received: from rh-tp.. ([2406:7400:63:2dd2:1827:1d70:2273:8ee0])
        by smtp.gmail.com with ESMTPSA id h9-20020aa786c9000000b0063b733fdd33sm3096057pfo.89.2023.04.16.03.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 03:09:18 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCHv5 8/9] iomap: Remove IOMAP_DIO_NOSYNC unused dio flag
Date:   Sun, 16 Apr 2023 15:38:43 +0530
Message-Id: <b7ffc38f61fb8685153dc2c0039e9e7546b85e3b.1681639164.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681639164.git.ritesh.list@gmail.com>
References: <cover.1681639164.git.ritesh.list@gmail.com>
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

