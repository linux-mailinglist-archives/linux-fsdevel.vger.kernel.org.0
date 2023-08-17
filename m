Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C65B77F875
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 16:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351759AbjHQONv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 10:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351754AbjHQONs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:13:48 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7859C19A1
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 07:13:47 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31771bb4869so7010187f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 07:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692281626; x=1692886426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6YuWRmUoMignxqEslNtZo8J+oVteko0Nb2mvhOmiic=;
        b=olMafWZ0I+UTIVhMAu+7C5CGNrftjWIaQlU3c4CY3rkfGz80muqpa8CAeEF4yxQftd
         ZFqxkgtaVAaNvgg3jIqO68WaFV11qGZkXRRRm2Fgkjy/BUqKtLgDkjIyDTrhvMvxW/5X
         o0kEos6Sv5hTZ4XQsF5LOOfJRgneCByUY7bv1MGyIO9zj4164R0IHnBAiFrfzHQXehqs
         +/yw2dxVzYvBKv0m45HcM39VVIrx6JABqmMvl39+Hm486SZts6RX9P3ofaxvLD/SjSNe
         GaoP8I/NZTZhjhQvxRpFTEbqqxMCraQfUrb2G0tjbb5pV01h4wK0a2TpQOu7tQNfQIns
         CeJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692281626; x=1692886426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6YuWRmUoMignxqEslNtZo8J+oVteko0Nb2mvhOmiic=;
        b=Muf/esqejw+mcYKG0fasN/Md+jrYemejg0w8IGd16PnqsU1p2SpgkoxMQdBO9sZOBy
         9VKxCLYHb4hzF6InGEMCxg3KdraRAXiWZL3o6xStodINoCgZ+YYCYqUZyuD/kFpXgIEN
         d7b/r2EGWnocETpSngcv3sZoqtaGtPjvnQnYO8DQibOBMmWji3/OQeSXAaUBMAjdgRKr
         dMRdQ+QjCzJl8ierHYinSkTE57wik8nSdN6NPibC6B5GzKwgPl1kEXeNLVJ17sWW3o3x
         qPG6yI693v/wpFlOK88a9hgmJzzMIFo9OWqt0Vuzf1DhvwC1TRyYiJYCWBdaPCeDTHkU
         Pl5g==
X-Gm-Message-State: AOJu0Ywfh5n0ka0tiZzXoC5EKjSAk4CZA6olHkynawGuj/Rv+HcGQaQF
        84rdmxrLLhMRf1OlLfU20J8=
X-Google-Smtp-Source: AGHT+IFZlG6quUjBbW70ATIfR3KtCW1mYbE7Rgk6ArtnZgfpuSKVTCJ4t43eS5qpGHtPstfzhzZ5YA==
X-Received: by 2002:a5d:4a91:0:b0:315:8a13:ef17 with SMTP id o17-20020a5d4a91000000b003158a13ef17mr4154631wrq.65.1692281625730;
        Thu, 17 Aug 2023 07:13:45 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id m12-20020a7bca4c000000b003fe2120ad0bsm3080605wml.41.2023.08.17.07.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 07:13:45 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 3/7] fs: create kiocb_{start,end}_write() helpers
Date:   Thu, 17 Aug 2023 17:13:33 +0300
Message-Id: <20230817141337.1025891-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817141337.1025891-1-amir73il@gmail.com>
References: <20230817141337.1025891-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

aio, io_uring, cachefiles and overlayfs, all open code an ugly variant
of file_{start,end}_write() to silence lockdep warnings.

Create helpers for this lockdep dance so we can use the helpers in all
the callers.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 include/linux/fs.h | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index ced388aff51f..2548048a6e6c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2579,6 +2579,42 @@ static inline void file_end_write(struct file *file)
 	sb_end_write(file_inode(file)->i_sb);
 }
 
+/**
+ * kiocb_start_write - get write access to a superblock for async file io
+ * @iocb: the io context we want to submit the write with
+ *
+ * This is a variant of sb_start_write() for async io submission.
+ * Should be matched with a call to kiocb_end_write().
+ */
+static inline void kiocb_start_write(struct kiocb *iocb)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	sb_start_write(inode->i_sb);
+	/*
+	 * Fool lockdep by telling it the lock got released so that it
+	 * doesn't complain about the held lock when we return to userspace.
+	 */
+	__sb_writers_release(inode->i_sb, SB_FREEZE_WRITE);
+}
+
+/**
+ * kiocb_end_write - drop write access to a superblock after async file io
+ * @iocb: the io context we sumbitted the write with
+ *
+ * Should be matched with a call to kiocb_start_write().
+ */
+static inline void kiocb_end_write(struct kiocb *iocb)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	/*
+	 * Tell lockdep we inherited freeze protection from submission thread.
+	 */
+	__sb_writers_acquired(inode->i_sb, SB_FREEZE_WRITE);
+	sb_end_write(inode->i_sb);
+}
+
 /*
  * This is used for regular files where some users -- especially the
  * currently executed binary in a process, previously handled via
-- 
2.34.1

