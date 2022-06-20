Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEEED5513B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jun 2022 11:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240557AbiFTJFS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jun 2022 05:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240469AbiFTJFK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:05:10 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23C0C44;
        Mon, 20 Jun 2022 02:05:08 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id a17so7206026pls.6;
        Mon, 20 Jun 2022 02:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zQQNu+xKu/aVWNgACtcsO4n2RX9MyLtbnx8C7isp5xU=;
        b=QgK0kNAr3B5qx7NDnBmojccPnx5eeut3zS14vACDT6Ehmr8fbX3xcq3Uf2pAo4z9OR
         Akf8MhSifrNDgvtsRBXiT4fmyVbrnzRn1VkIKx+BHd6baoXU+2Yntf69JUOU9GJa8QfP
         kHOdtnq76Qd2HUjeFeiEKjY1H2OloZXNI2I8W5QFbgcE8n63FKU/GgW3dk+O9UC0zbkJ
         r0iWa8OocBiImBTJBQTjEgbI8ItgCfOPL+ezG+1aGzZ9bWxdt+pQRR5XD4vs6zzoqtf6
         QXpKDhqwO+WmaNZWN5XzO9GOeXo6w8G0L6E7WdQ+puMlYFh7WZeyqLLtSJWVtoqb9BcJ
         a5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zQQNu+xKu/aVWNgACtcsO4n2RX9MyLtbnx8C7isp5xU=;
        b=Ww71GqKcdKR5R28GdotGH9hBwDf9hFvVb7HE8ZnXaMnwSmsH8fQx8n8khKn5uX0etB
         c3EOiQLJ7EkRcsFI1UpK/KB1vchrZ2I2CLb0+MnFdeIQSdpZ1Fuh2Tu5pr4/AJn5oRtN
         xy4isvxQPCm/FWMb1REn+MjRt5CBv9S/JBHbpb+KHLX+0KxEjnV3RPj0yei1mIZhV689
         L2uA6qoYYfbNDXC8iM/jYl6Aain9ikC+/MQpRPk9NUtKxuU7d9m4dg0cm7CxruF9UtkP
         qdvksVg/ar5Prwx6hKAMg2Hfq/WY+KDy5dHOmebtaPxPHFg8ZT9WeUSG7WZqU+ToLFox
         WWrA==
X-Gm-Message-State: AJIora9aY6VfHt8AxZyFO6XXk9lR1t16Bb3Cl+AoZMIXBD0E9lpmx7aQ
        Y3+zGQROabyk0pwu2iXy8kRTixoQpJc=
X-Google-Smtp-Source: AGRyM1vqpVK35b08eJmEdgb51J1AUhZIb4mlFzs0dAdNQBNbaujlaNErJbc80pxjIFiDchcUVzJ75w==
X-Received: by 2002:a17:902:7610:b0:16a:805:6ac9 with SMTP id k16-20020a170902761000b0016a08056ac9mr15459124pll.119.1655715908114;
        Mon, 20 Jun 2022 02:05:08 -0700 (PDT)
Received: from localhost ([2406:7400:63:5d34:e6c2:4c64:12ae:aa11])
        by smtp.gmail.com with ESMTPSA id f9-20020a170902684900b0016a07e3b0c0sm5819982pln.148.2022.06.20.02.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 02:05:07 -0700 (PDT)
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Jan Kara <jack@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCHv2 4/4] fs/buffer: Make submit_bh & submit_bh_wbc return type as void
Date:   Mon, 20 Jun 2022 14:34:37 +0530
Message-Id: <5c8fd257bd86f8f2a3f97b72ef46c85c4f5030b1.1655715329.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1655715329.git.ritesh.list@gmail.com>
References: <cover.1655715329.git.ritesh.list@gmail.com>
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

submit_bh/submit_bh_wbc are non-blocking functions which just submit
the bio and return. The caller of submit_bh/submit_bh_wbc needs to wait
on buffer till I/O completion and then check buffer head's b_state field
to know if there was any I/O error.

Hence there is no need for these functions to have any return type.
Even now they always returns 0. Hence drop the return value and make
their return type as void to avoid any confusion.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ritesh Harjani <ritesh.list@gmail.com>
---
 fs/buffer.c                 | 9 ++++-----
 include/linux/buffer_head.h | 2 +-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 313283af15b6..6671abc98e21 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -52,7 +52,7 @@
 #include "internal.h"

 static int fsync_buffers_list(spinlock_t *lock, struct list_head *list);
-static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
+static void submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
 			 struct writeback_control *wbc);

 #define BH_ENTRY(list) list_entry((list), struct buffer_head, b_assoc_buffers)
@@ -2994,7 +2994,7 @@ static void end_bio_bh_io_sync(struct bio *bio)
 	bio_put(bio);
 }

-static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
+static void submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
 			 struct writeback_control *wbc)
 {
 	struct bio *bio;
@@ -3037,12 +3037,11 @@ static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
 	}

 	submit_bio(bio);
-	return 0;
 }

-int submit_bh(int op, int op_flags, struct buffer_head *bh)
+void submit_bh(int op, int op_flags, struct buffer_head *bh)
 {
-	return submit_bh_wbc(op, op_flags, bh, NULL);
+	submit_bh_wbc(op, op_flags, bh, NULL);
 }
 EXPORT_SYMBOL(submit_bh);

diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index c9d1463bb20f..392d7d5aec05 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -205,7 +205,7 @@ void ll_rw_block(int, int, int, struct buffer_head * bh[]);
 int sync_dirty_buffer(struct buffer_head *bh);
 int __sync_dirty_buffer(struct buffer_head *bh, int op_flags);
 void write_dirty_buffer(struct buffer_head *bh, int op_flags);
-int submit_bh(int, int, struct buffer_head *);
+void submit_bh(int op, int op_flags, struct buffer_head *bh);
 void write_boundary_block(struct block_device *bdev,
 			sector_t bblock, unsigned blocksize);
 int bh_uptodate_or_lock(struct buffer_head *bh);
--
2.35.3

