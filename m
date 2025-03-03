Return-Path: <linux-fsdevel+bounces-43012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E9DA4CF0B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 00:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5D32189282B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 23:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCBF23C8C7;
	Mon,  3 Mar 2025 23:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFBRbagu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1082423C8B5;
	Mon,  3 Mar 2025 23:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741043073; cv=none; b=RBfbc9vx3/9dlER+iqb+GshPf6htaY5WW+4t+OcOcGgiHy3HhFhNplZ5b6Pkj0wovxV6nElQeq/8siB5OpLndBIy3phJSwmqm6+6pqP806MeT05PBzUIVcYhzg3g3eFUwGGMVXBnAx2/FMmOp7KHZ995lsiNcE0zFpYFcslR2kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741043073; c=relaxed/simple;
	bh=QOzhI2b6ctkjNKifd+G7Xj7Wz464uYGuCUhIT6YriC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eFSMT1oCeq1mr7z6YCb2y8tvlgwrgzJEzhf2a0hnUZSKGDSKZfJ3w2o98lUxlORUxA5Q8mMNuMJuKE9cN06hwKAYnVzUh0gGHydLMdfUCg+vaxpngNsq2sDROMdauGxH+ZCvrPmFWPAcjbVciHZ8eQK7nKguZKCNwsfZmPa14bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFBRbagu; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43996e95114so34172045e9.3;
        Mon, 03 Mar 2025 15:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741043070; x=1741647870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2F/qQHvwhGWsalkeXNzBKPitDr0lKPU47I7B3LbQaPw=;
        b=fFBRbaguDVHqC8M9r31pnYVjqy4my6B0NLAZ0HMbCJwcZv82Dm/bBJ7JUvmo2veTA2
         aVBEHaAyHSbYBJUqVXNjGPaID4L95LXOzGyd1VxyXBeK1ByCEXe4VQOliLFEFpbEOOuI
         wRZ8RCZOFOWV6WtJX6C6aS1p/TGNigRczBDRKH1J4ITv/RcKwB+1g2H7y+rspYACxOOh
         depSdCoHyvvcPuu713CStRe3t7yOOaIYx7jatU45IRT7aaylUzazx0v6qOkk3lo1gcM/
         6iKV8mBMPBOG1E2sgpli9ypN0zXJBkrArrYIZTWOvQW4q+jywdbhgh6Unk3WEUnnD0hf
         DGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741043070; x=1741647870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2F/qQHvwhGWsalkeXNzBKPitDr0lKPU47I7B3LbQaPw=;
        b=EtgVr6DoH1zpacLDwEFWj8m6hLEEnpXQEVr5vl0wrcpI/mpvQZicR6oY6Dh7Wmrmz2
         biiWqJhGmwZQ9TqvCF+gpfTPdYS2DQcj9nfo/98xL0W8foJVwL3PgqaGfm5a2BlaI+Yc
         +LmXCIuiHiGSheCearrqjCq2ZMatbBYZk56vKca/5gtLNcPY/VaOcXLjZjPL0qGl5sUi
         ZnoR8OBolTunvJB39QNmlkpBB/jR0O2WPDK1GnkEM55dN6OnBJU7Cm+4E4/KATM4/ehR
         ODLTsQiaa4cJ8rWSTDqNBuNJxO2h6a4vauMf4pZVqzrhiRlQFInXSnmXnUJmIuAKgGNK
         qHqg==
X-Forwarded-Encrypted: i=1; AJvYcCUeVqqRXgfOvKcG/xEflBB8ZwAxCB3tnYMqJw2VQQBbYVRHv9MZXKq69yPqNDWTVB6lU0TLL8ma42lZzr4A@vger.kernel.org, AJvYcCX54XjQXpC072UGP0Shlkti6GDd7MlfMk8IW5cMQOPaZkGzCL7Vc0YrPYuLIzAbJjoWsfggw4OGaIrzRPeO@vger.kernel.org
X-Gm-Message-State: AOJu0YwAeDivFTKgsdNLQxwNL6fzHQfxce37ZeB6NJhG5lAJcwThmOxu
	89QoZW/8RZYxtylqKwRY7cGBU8kpSsjS0u7cQXttWCo5NjRmPr7a
X-Gm-Gg: ASbGnct8Q/uKxD9X5IeVkjK87avT7LGe8uXC/l9yOHO1686ziMfFMTK3wM3n2Relc0x
	ZGtta/aYcFKtgbDPGMG/LomDmty83Kab/yDvVjXgIfdBBAcwpPE5CE3xc7MqwRYHnzy6t8BgxsF
	X4A5AyMj+0K8Pud00q2ObVgACvnQxugBx6wPNdoGzno16X4aBHmi6f0SR8JZxHB19g87FH3DBqj
	DHJ1+WObwI6sx0GPQ42KjRs45QDeJmbU2nNxM5OI6H2iVDHg9LJYpqTUMtkx9dGyaYV0dfCYA5/
	m5Wp97eXoBe35BXuNpz4o5o2Y9iRvIFpA5b9Z0KaobGH+I1F7BrJ8j69nsgQ
X-Google-Smtp-Source: AGHT+IG7w2Xeex5WgCFf5PvhDfd2xd6ae3PCC2vkZQaUZkOO6mM1HJ32jp4rud1z8WkIoCSIdH+ihg==
X-Received: by 2002:a05:600c:1c25:b0:439:5a37:8157 with SMTP id 5b1f17b1804b1-43ba6774a03mr136746665e9.30.1741043070208;
        Mon, 03 Mar 2025 15:04:30 -0800 (PST)
Received: from f.. (cst-prg-71-44.cust.vodafone.cz. [46.135.71.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bc57529fasm37679255e9.31.2025.03.03.15.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 15:04:29 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: torvalds@linux-foundation.org
Cc: oleg@redhat.com,
	brauner@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 2/3] pipe: cache 2 pages instead of 1
Date: Tue,  4 Mar 2025 00:04:08 +0100
Message-ID: <20250303230409.452687-3-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250303230409.452687-1-mjguzik@gmail.com>
References: <20250303230409.452687-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

User data is kept in a circular buffer backed by pages allocated as
needed. Only having space for one spare is still prone to having to
resort to allocation / freeing.

In my testing this decreases page allocs by 60% during a kernel build.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/pipe.c                 | 60 ++++++++++++++++++++++++++-------------
 include/linux/pipe_fs_i.h |  2 +-
 2 files changed, 41 insertions(+), 21 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index d5238f6e0f08..f5a316d4da95 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -112,20 +112,40 @@ void pipe_double_lock(struct pipe_inode_info *pipe1,
 	pipe_lock(pipe2);
 }
 
+static struct page *anon_pipe_get_page(struct pipe_inode_info *pipe)
+{
+	for (int i = 0; i < ARRAY_SIZE(pipe->tmp_page); i++) {
+		if (pipe->tmp_page[i]) {
+			struct page *page = pipe->tmp_page[i];
+			pipe->tmp_page[i] = NULL;
+			return page;
+		}
+	}
+
+	return alloc_page(GFP_HIGHUSER | __GFP_ACCOUNT);
+}
+
+static void anon_pipe_put_page(struct pipe_inode_info *pipe,
+			       struct page *page)
+{
+	if (page_count(page) == 1) {
+		for (int i = 0; i < ARRAY_SIZE(pipe->tmp_page); i++) {
+			if (!pipe->tmp_page[i]) {
+				pipe->tmp_page[i] = page;
+				return;
+			}
+		}
+	}
+
+	put_page(page);
+}
+
 static void anon_pipe_buf_release(struct pipe_inode_info *pipe,
 				  struct pipe_buffer *buf)
 {
 	struct page *page = buf->page;
 
-	/*
-	 * If nobody else uses this page, and we don't already have a
-	 * temporary page, let's keep track of it as a one-deep
-	 * allocation cache. (Otherwise just release our reference to it)
-	 */
-	if (page_count(page) == 1 && !pipe->tmp_page)
-		pipe->tmp_page = page;
-	else
-		put_page(page);
+	anon_pipe_put_page(pipe, page);
 }
 
 static bool anon_pipe_buf_try_steal(struct pipe_inode_info *pipe,
@@ -493,27 +513,25 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 		if (!pipe_full(head, pipe->tail, pipe->max_usage)) {
 			unsigned int mask = pipe->ring_size - 1;
 			struct pipe_buffer *buf;
-			struct page *page = pipe->tmp_page;
+			struct page *page;
 			int copied;
 
-			if (!page) {
-				page = alloc_page(GFP_HIGHUSER | __GFP_ACCOUNT);
-				if (unlikely(!page)) {
-					ret = ret ? : -ENOMEM;
-					break;
-				}
-				pipe->tmp_page = page;
+			page = anon_pipe_get_page(pipe);
+			if (unlikely(!page)) {
+				if (!ret)
+					ret = -ENOMEM;
+				break;
 			}
 
 			copied = copy_page_from_iter(page, 0, PAGE_SIZE, from);
 			if (unlikely(copied < PAGE_SIZE && iov_iter_count(from))) {
+				anon_pipe_put_page(pipe, page);
 				if (!ret)
 					ret = -EFAULT;
 				break;
 			}
 
 			pipe->head = head + 1;
-			pipe->tmp_page = NULL;
 			/* Insert it into the buffer array */
 			buf = &pipe->bufs[head & mask];
 			buf->page = page;
@@ -846,8 +864,10 @@ void free_pipe_info(struct pipe_inode_info *pipe)
 	if (pipe->watch_queue)
 		put_watch_queue(pipe->watch_queue);
 #endif
-	if (pipe->tmp_page)
-		__free_page(pipe->tmp_page);
+	for (i = 0; i < ARRAY_SIZE(pipe->tmp_page); i++) {
+		if (pipe->tmp_page[i])
+			__free_page(pipe->tmp_page[i]);
+	}
 	kfree(pipe->bufs);
 	kfree(pipe);
 }
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index 8ff23bf5a819..eb7994a1ff93 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -72,7 +72,7 @@ struct pipe_inode_info {
 #ifdef CONFIG_WATCH_QUEUE
 	bool note_loss;
 #endif
-	struct page *tmp_page;
+	struct page *tmp_page[2];
 	struct fasync_struct *fasync_readers;
 	struct fasync_struct *fasync_writers;
 	struct pipe_buffer *bufs;
-- 
2.43.0


