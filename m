Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915A94C4E1E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 19:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbiBYSzd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Feb 2022 13:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbiBYSz3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Feb 2022 13:55:29 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12ED11CABE0;
        Fri, 25 Feb 2022 10:54:57 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id w3so8656554edu.8;
        Fri, 25 Feb 2022 10:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5JCzyKO1UGfLV/7xsnb4oZePBiMZ1ZUia6iSNgCx/I8=;
        b=fzybFQ1BUMKHTpsaJZmc2s3lMD0wZsKBh3JzpqlDdskF3BwjA/C/RoMdQrtIm0eZNV
         B7G5iiaWtIKNfk8JYvJbWJTio/tz0SMH9cZMKLC0TqIBrlw3M6ydY22nqsrLlIFNaK2f
         7PvJ7IowggLeRCeQiYTO3YkHxF7v/0NlxSPrukh+bTz+aJcNhaspB/0RskNqE7T74CHv
         YyE20Ql/zysnRTK5kbBrX3hkj7jUSDtANJWd9NYmbfQ1z4IbisKH9+nTgRZWs9dtfZPL
         M01BmzEU8XZZmGejTOwkLGPrfsU4VQYpChuf95yRLf4W1wShbHK3IxnERDoFyaBJMvcC
         lAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5JCzyKO1UGfLV/7xsnb4oZePBiMZ1ZUia6iSNgCx/I8=;
        b=oyj61DGkM4AIrXf9Qd6YZsvI+wxzAOI2U3YVV8fw3uap5//W4Fkixn5Q8h9aX9V1Le
         0YOn64bCz+16cr95tWUfe3d7247jI/tyEv22/3IvQMUu085EyiP/1WqCQCifZXmdoUAy
         WxMTUf5A71nUAqy36kTs+xtawVH8y/EG01jEwMiyuevIhinxnE3bTr7GywmmfnBrcEQF
         g6bc2fuGHCwXMZFGkmgj4C0fgstpQqQgk4czum6/FM+iXstM0V+czw/HxlGf4NHGoK9C
         MPzsGhPkhkM3wCjxy+HNfH4eTIYRKHwHzz1qEQ7oW25Q/y5z/PNsOiugQzKII0SgWObG
         kE7w==
X-Gm-Message-State: AOAM531TQKUrqfRzCRixpnNDnpR/Qml80cc5BDr9ikcFg/VOljcJju9O
        WVjq0sZ0Qg7jNAS0LvuwlR8=
X-Google-Smtp-Source: ABdhPJyOIbYW6P4rt0+e7CKu4EGWteknSPX2AEuzYr7OOjJ4sWwL5/3OERE3gk57FgmZH01ETGoGCw==
X-Received: by 2002:a05:6402:270b:b0:410:d71d:3f06 with SMTP id y11-20020a056402270b00b00410d71d3f06mr8256665edd.10.1645815295599;
        Fri, 25 Feb 2022 10:54:55 -0800 (PST)
Received: from heron.intern.cm-ag (p200300dc6f1cbe000000000000000fd2.dip0.t-ipconnect.de. [2003:dc:6f1c:be00::fd2])
        by smtp.gmail.com with ESMTPSA id u19-20020a170906125300b006ceb043c8e1sm1328508eja.91.2022.02.25.10.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 10:54:55 -0800 (PST)
From:   Max Kellermann <max.kellermann@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Max Kellermann <max.kellermann@gmail.com>
Subject: [PATCH 4/4] pipe_fs_i.h: add pipe_buf_init()
Date:   Fri, 25 Feb 2022 19:54:31 +0100
Message-Id: <20220225185431.2617232-4-max.kellermann@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20220225185431.2617232-1-max.kellermann@gmail.com>
References: <20220225185431.2617232-1-max.kellermann@gmail.com>
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

Adds one central function which shall be used to initialize a newly
allocated struct pipe_buffer.  This shall make the pipe code more
robust for the next time the pipe_buffer struct gets modified, to
avoid leaving new members uninitialized.  Instead, adding new members
should also add a new pipe_buf_init() parameter, which causes
compile-time errors in call sites that were not adapted.

This commit doesn't refactor fs/fuse/dev.c because this code looks
obscure to me; it initializes pipe_buffers incrementally through a
variety of functions, too complicated for me to understand.

To: Alexander Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@gmail.com>
---
 fs/pipe.c                 | 11 +++--------
 fs/splice.c               |  9 ++++-----
 include/linux/pipe_fs_i.h | 20 ++++++++++++++++++++
 kernel/watch_queue.c      |  8 +++-----
 lib/iov_iter.c            | 13 +++----------
 5 files changed, 33 insertions(+), 28 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index b2075ecd4751..6da11ea9da49 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -518,14 +518,9 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 
 			/* Insert it into the buffer array */
 			buf = &pipe->bufs[head & mask];
-			buf->page = page;
-			buf->ops = &anon_pipe_buf_ops;
-			buf->offset = 0;
-			buf->len = 0;
-			if (is_packetized(filp))
-				buf->flags = PIPE_BUF_FLAG_PACKET;
-			else
-				buf->flags = PIPE_BUF_FLAG_CAN_MERGE;
+			pipe_buf_init(buf, page, 0, 0,
+				      &anon_pipe_buf_ops,
+				      is_packetized(filp) ? PIPE_BUF_FLAG_PACKET : PIPE_BUF_FLAG_CAN_MERGE);
 			pipe->tmp_page = NULL;
 
 			copied = copy_page_from_iter(page, 0, PAGE_SIZE, from);
diff --git a/fs/splice.c b/fs/splice.c
index 5dbce4dcc1a7..d2e4205acc46 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -200,12 +200,11 @@ ssize_t splice_to_pipe(struct pipe_inode_info *pipe,
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
index 0e36a58adf0e..61639682cc4e 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -179,6 +179,26 @@ static inline unsigned int pipe_space_for_user(unsigned int head, unsigned int t
 	return p_space;
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
index 9c9eb20dd2c5..34720138cc22 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -106,12 +106,10 @@ static bool post_one_notification(struct watch_queue *wqueue,
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
 	pipe->head = head + 1;
 
 	if (!test_and_clear_bit(note, wqueue->notes_bitmap)) {
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 6dd5330f7a99..289e96947fb5 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -413,12 +413,8 @@ static size_t copy_page_to_iter_pipe(struct page *page, size_t offset, size_t by
 	if (pipe_full(i_head, p_tail, pipe->max_usage))
 		return 0;
 
-	buf->ops = &page_cache_pipe_buf_ops;
-	buf->flags = 0;
 	get_page(page);
-	buf->page = page;
-	buf->offset = offset;
-	buf->len = bytes;
+	pipe_buf_init(buf, page, offset, bytes, &page_cache_pipe_buf_ops, 0);
 
 	pipe->head = i_head + 1;
 	i->iov_offset = offset + bytes;
@@ -577,11 +573,8 @@ static size_t push_pipe(struct iov_iter *i, size_t size,
 		if (!page)
 			break;
 
-		buf->ops = &default_pipe_buf_ops;
-		buf->flags = 0;
-		buf->page = page;
-		buf->offset = 0;
-		buf->len = min_t(ssize_t, left, PAGE_SIZE);
+		pipe_buf_init(buf, page, 0, min_t(ssize_t, left, PAGE_SIZE),
+			      &default_pipe_buf_ops, 0);
 		left -= buf->len;
 		iter_head++;
 		pipe->head = iter_head;
-- 
2.34.0

