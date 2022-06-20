Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA43550FEB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jun 2022 08:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238426AbiFTGAD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jun 2022 02:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238421AbiFTF7s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jun 2022 01:59:48 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F00DF8B;
        Sun, 19 Jun 2022 22:59:42 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id w24so933907pjg.5;
        Sun, 19 Jun 2022 22:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NYiD9eM+KGyPorgMmWX5XLuH3KZcPdxGd9EsYZHUhiY=;
        b=TrRaOOhpUEndVxuD7aVjtYiXelfTK4XWG/0UTWd1A0E2ycgpEs7qlg9TaEx77TCFEc
         baphQ6gYwfuGcaFW1uv9HkJ3ia7bMpYFJUC+EFXB+YEZjg4jK5eu/mqtXfkMMfEox3ME
         XmNUeGHBcjv5CfQt2sNEkfHVoK0+fj13XjXK9XyJQSvigZ1jwDbVlU0JljdqS1D0ongQ
         JjgdX228kh67cwnRpKKbSz+aeF4sCxi2TFcIuD2+NpvBJUIKLXJGWcWclIfDuM5oqhYu
         SCkVKT2LxHhTiOFTW5s6/wQCEEJFJ/corEIWHYHez0WfNSNPSObJv+rV8g4EHBUweozF
         e4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NYiD9eM+KGyPorgMmWX5XLuH3KZcPdxGd9EsYZHUhiY=;
        b=gi/0K0ZJDtRlBdMaHZAwsEIoeJQFZMkG/bOWBjLp5StBmqgrn4xz1avGWqDBQNoPD1
         MGBa8qGF2E0o5b6BQUdYZJCtLh48OfrobFVlKoJYBjmzfiRQDVd0BRqLteNRjY+AM0w2
         dZmk/wGWfPYUrUYVeKf7s8TeGFcMlc51whjqDmJS4xkbIbTwfMInbpj8fGA6NxoDZ8Ys
         tM8NZBysBJE9Gk7toDkuXZf2O2wm5F1Cjcl/jF3yG2ZKUrEpOcVn4oLD0XZboaP2pEzl
         f/is2I2GDJUnkXMvWH5u2qf47M1MiMOEXNG6ki5ulmQNf/TC3WBYn4VBNQZ3tDQ2ZMSY
         R8Uw==
X-Gm-Message-State: AJIora9ZhmrbDq0O0O9qcPyyeegTgLi3MAVZ1d8QhBdx6fw8iwj4H/oA
        dk2bcDxqkvQmPR9KdPcn75w3xtoxKzU=
X-Google-Smtp-Source: AGRyM1sMmNvyA6tVU+E7iDcAxZ4dzRCPjegQKTiw11JwZQR8nnlK1p8eEhw5j2RBrj1oZi7BWhU3VQ==
X-Received: by 2002:a17:90b:1c10:b0:1e8:90bd:d912 with SMTP id oc16-20020a17090b1c1000b001e890bdd912mr24897843pjb.233.1655704781351;
        Sun, 19 Jun 2022 22:59:41 -0700 (PDT)
Received: from localhost ([2406:7400:63:5d34:e6c2:4c64:12ae:aa11])
        by smtp.gmail.com with ESMTPSA id 144-20020a621796000000b0051b693baadcsm7934601pfx.205.2022.06.19.22.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 22:59:41 -0700 (PDT)
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Jan Kara <jack@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFC 3/3] fs/buffer: Make submit_bh & submit_bh_wbc return type as void
Date:   Mon, 20 Jun 2022 11:28:42 +0530
Message-Id: <ba89f469a59cfaca49478ee391e6bc9dde456e19.1655703467.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1655703466.git.ritesh.list@gmail.com>
References: <cover.1655703466.git.ritesh.list@gmail.com>
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

submit_bh/submit_bh_wbc are non-blocking functions which just submits
the bio and returns. The caller of submit_bh/submit_bh_wbc needs to wait
on buffer till I/O completion and then check buffer head's b_state field
to know if there was any I/O error.

Hence there is no need for these functions to have any return type.
Even now they always returns 0. Hence drop the return value and make
their return type as void to avoid any confusion.

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

