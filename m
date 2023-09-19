Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B287A5BF4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 10:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjISIH1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 04:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjISIH0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:07:26 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DE8FB
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 01:07:20 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3216ba1b01eso108921f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 01:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695110838; x=1695715638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KauzblMbtoKORsMsCBmvlq8Rtah+B4qEiz+EyZ86dq4=;
        b=aej/MT05aBbrF4vhKurpilvHhgOxK4KLrHLpKyGXRu2Od0zs4a2PyIlWtaTCeWnRe7
         JfAuqV3t/poDtcpGSQCQOvINRQRgYNrldOEhB2OIhJH5Y7vRXTNUpih5FIyEsVbe54oW
         LP307ovbi6GBUh40mqueuP+AUwYMQMESaOIuaiz0y0Tu4M/fkUxm/8x8jEPacUvzofx9
         cwJqDllm1wqZmSiTHvSDrHltxLSZZ/BC+8ejWgloK+UNMoZzl6U3inV+lQb1f8TL9cPH
         pHOQ8wrefJDnjSo8QbEMiNX6wLfnFb6InIZaBbW1fVYLAMXwGwBWzvXix0G7VzzPM9HB
         mPzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695110838; x=1695715638;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KauzblMbtoKORsMsCBmvlq8Rtah+B4qEiz+EyZ86dq4=;
        b=lJh0a7TGFK5HHF04RpkRF8nGsd+uHKFYx7JkDb2OpU4R9lyEYUJRIkE/6phH+dR/8F
         SDAyZ3CXu3N3RPOd8cwql5vBztgRqFQZFZk8REsKrx4Df+5T2CopSfMfiy7vLL1INz5Z
         tgUOBz7M4AuAhnCQQDT7as0nydaEq67Mh/hBAFM4Nac4Lw45nc/++T3DY6r2w/tvx1mU
         bAiGygwqoFACNAv8QKwh9mM9rfk0IGDPdIPYkjC91YNfDBcgTCDwj7/bRTgqLtpUNlma
         VSIBqywE9xuITZQXxVB5lssB3fCylD8No6MXAHlEB2YZQFBhtjt7YaeF5dEy1TGvC3rM
         62mg==
X-Gm-Message-State: AOJu0Yz6XnseTvikLV98kFwwQHV7zRQ/zgxofUgy0GAgLMWojF0rxwsp
        sXBe8aZzvNNkTRvWCDx6eeyApg==
X-Google-Smtp-Source: AGHT+IE8qi+dsghdzDbTiwa+G9WSy2YkcwrfbpN6ruotbQOOULLulDuGSAZEVLhxEsDuDDNXa2JYcA==
X-Received: by 2002:a5d:58e1:0:b0:319:79bb:980c with SMTP id f1-20020a5d58e1000000b0031979bb980cmr8726188wrd.64.1695110838407;
        Tue, 19 Sep 2023 01:07:18 -0700 (PDT)
Received: from heron.intern.cm-ag (p200300dc6f209c00529a4cfffe3dd983.dip0.t-ipconnect.de. [2003:dc:6f20:9c00:529a:4cff:fe3d:d983])
        by smtp.gmail.com with ESMTPSA id z8-20020a056000110800b0031f3ad17b2csm14772096wrw.52.2023.09.19.01.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 01:07:17 -0700 (PDT)
From:   Max Kellermann <max.kellermann@ionos.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
Cc:     Max Kellermann <max.kellermann@ionos.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] pipe_fs_i.h: add pipe_buf_init()
Date:   Tue, 19 Sep 2023 10:07:06 +0200
Message-Id: <20230919080707.1077426-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Adds one central function which shall be used to initialize a newly
allocated struct pipe_buffer.  This shall make the pipe code more
robust for the next time the pipe_buffer struct gets modified, to
avoid leaving new members uninitialized.  Instead, adding new members
should also add a new pipe_buf_init() parameter, which causes
compile-time errors in call sites that were not adapted.

This commit doesn't refactor fs/fuse/dev.c because this code looks
obscure to me; it initializes pipe_buffers incrementally through a
variety of functions, too complicated for me to understand.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/pipe.c                 |  9 +++------
 fs/splice.c               |  9 ++++-----
 include/linux/pipe_fs_i.h | 20 ++++++++++++++++++++
 kernel/watch_queue.c      |  8 +++-----
 mm/filemap.c              |  8 ++------
 mm/shmem.c                |  9 +++------
 6 files changed, 35 insertions(+), 28 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 6c1a9b1db907..edba8c666c95 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -520,14 +520,11 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 
 			/* Insert it into the buffer array */
 			buf = &pipe->bufs[head & mask];
-			buf->page = page;
-			buf->ops = &anon_pipe_buf_ops;
-			buf->offset = 0;
-			buf->len = 0;
+			pipe_buf_init(buf, page, 0, 0,
+				      &anon_pipe_buf_ops,
+				      PIPE_BUF_FLAG_CAN_MERGE);
 			if (is_packetized(filp))
 				buf->flags = PIPE_BUF_FLAG_PACKET;
-			else
-				buf->flags = PIPE_BUF_FLAG_CAN_MERGE;
 			pipe->tmp_page = NULL;
 
 			copied = copy_page_from_iter(page, 0, PAGE_SIZE, from);
diff --git a/fs/splice.c b/fs/splice.c
index d983d375ff11..277bc4812164 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -215,12 +215,11 @@ ssize_t splice_to_pipe(struct pipe_inode_info *pipe,
 	while (!pipe_full(head, tail, pipe->max_usage)) {
 		struct pipe_buffer *buf = &pipe->bufs[head & mask];
 
-		buf->page = spd->pages[page_nr];
-		buf->offset = spd->partial[page_nr].offset;
-		buf->len = spd->partial[page_nr].len;
+		pipe_buf_init(buf, spd->pages[page_nr],
+			      spd->partial[page_nr].offset,
+			      spd->partial[page_nr].len,
+			      spd->ops, 0);
 		buf->private = spd->partial[page_nr].private;
-		buf->ops = spd->ops;
-		buf->flags = 0;
 
 		head++;
 		pipe->head = head;
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index 608a9eb86bff..2ef2bb218641 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -176,6 +176,26 @@ static inline struct pipe_buffer *pipe_head_buf(const struct pipe_inode_info *pi
 	return pipe_buf(pipe, pipe->head);
 }
 
+/**
+ * Initialize a struct pipe_buffer.
+ */
+static inline void pipe_buf_init(struct pipe_buffer *buf,
+				 struct page *page,
+				 unsigned int offset, unsigned int len,
+				 const struct pipe_buf_operations *ops,
+				 unsigned int flags)
+{
+	buf->page = page;
+	buf->offset = offset;
+	buf->len = len;
+	buf->ops = ops;
+	buf->flags = flags;
+
+	/* not initializing the "private" member because it is only
+	   used by pipe_buf_operations which inject it via struct
+	   partial_page / struct splice_pipe_desc */
+}
+
 /**
  * pipe_buf_get - get a reference to a pipe_buffer
  * @pipe:	the pipe that the buffer belongs to
diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index d0b6b390ee42..187ad7ca38b0 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -125,12 +125,10 @@ static bool post_one_notification(struct watch_queue *wqueue,
 	kunmap_atomic(p);
 
 	buf = &pipe->bufs[head & mask];
-	buf->page = page;
+	pipe_buf_init(buf, page, offset, len,
+		      &watch_queue_pipe_buf_ops,
+		      PIPE_BUF_FLAG_WHOLE);
 	buf->private = (unsigned long)wqueue;
-	buf->ops = &watch_queue_pipe_buf_ops;
-	buf->offset = offset;
-	buf->len = len;
-	buf->flags = PIPE_BUF_FLAG_WHOLE;
 	smp_store_release(&pipe->head, head + 1); /* vs pipe_read() */
 
 	if (!test_and_clear_bit(note, wqueue->notes_bitmap)) {
diff --git a/mm/filemap.c b/mm/filemap.c
index 582f5317ff71..74532e0cb8d7 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2850,12 +2850,8 @@ size_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
 		struct pipe_buffer *buf = pipe_head_buf(pipe);
 		size_t part = min_t(size_t, PAGE_SIZE - offset, size - spliced);
 
-		*buf = (struct pipe_buffer) {
-			.ops	= &page_cache_pipe_buf_ops,
-			.page	= page,
-			.offset	= offset,
-			.len	= part,
-		};
+		pipe_buf_init(buf, page, offset, part,
+			      &page_cache_pipe_buf_ops, 0);
 		folio_get(folio);
 		pipe->head++;
 		page++;
diff --git a/mm/shmem.c b/mm/shmem.c
index 02e62fccc80d..75d39653b028 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2901,12 +2901,9 @@ static size_t splice_zeropage_into_pipe(struct pipe_inode_info *pipe,
 	if (!pipe_full(pipe->head, pipe->tail, pipe->max_usage)) {
 		struct pipe_buffer *buf = pipe_head_buf(pipe);
 
-		*buf = (struct pipe_buffer) {
-			.ops	= &zero_pipe_buf_ops,
-			.page	= ZERO_PAGE(0),
-			.offset	= offset,
-			.len	= size,
-		};
+		pipe_buf_init(buf, ZERO_PAGE(0),
+			      offset, size,
+			      &zero_pipe_buf_ops, 0);
 		pipe->head++;
 	}
 
-- 
2.39.2

