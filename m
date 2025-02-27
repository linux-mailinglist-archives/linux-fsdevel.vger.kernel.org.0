Return-Path: <linux-fsdevel+bounces-42793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39534A48C72
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 00:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C13481890780
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 23:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4E0272914;
	Thu, 27 Feb 2025 23:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HllX7fUh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A2C2309A3;
	Thu, 27 Feb 2025 23:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740697886; cv=none; b=c0qVc4NwCfVh6BkfGDmHVqHSXmQ/eWlaO5feLakgSLuXu3JU5kMnln+MpXNNl2YuAH4p4AjqBfldiM5xlZWCsFbx8vB7fVq/6nCF5grGpakCAj71xahEfHuxMqwRYl28NJPmBuUQgmCd6i/Gi+KDBNJVL8+/x9BJmFsg0npmf30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740697886; c=relaxed/simple;
	bh=nf1/dckcnomNKWFNl7Mj3elVZpIUPC9x6D/lkkXmlTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dTXP/uAv7bChhYd0jtv24+mLrL70Jz6XGn9b3IFCZKFfpqVZ/3xLeOuuNlRI40EoiRjnDIYEMGAMQs5xWghxciQKDCGM8bCPwtGCkgUK3tGrIeVi1+km0bMto/I3UdMGbmlwcUxUnZjResN4cyALFMG5oFiFWqXBGhEaOc+B+iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HllX7fUh; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5dec817f453so2133526a12.2;
        Thu, 27 Feb 2025 15:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740697883; x=1741302683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AY8ndVYJ7XgqaUiDvauHMj3rzJsfZgflXLJt38pHW0c=;
        b=HllX7fUhB2pTRmlySPaHA66Lw5chXVGZNGaiLPOOGYx8KNtNJxH3205BmbUK3QUFYf
         TUySLKxjIp5ZRhF8dR6Lp8/k2I2Cl3yJSMDY5aVWNxyHdSDNehXnVoTGm17jTkF/0Jbm
         kVSK1/uDGXos1lK32M06nppeGAiYE3tAlf8sXpC99ln2nfMLBJW0vyk45ZTTdfHArNHl
         S58rDsRkbV6+8z2zzOP5BX/wYEMgVNd0yIkhVtzk6so9F/PMgNlmWnISZFoKry1cbr/o
         aUakx3moE6SPZXMYYNiQxkEWH7/0xzoWMFOf75YEfaIHL7lT2xduzuH9lqfWgyUJ4Suf
         hmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740697883; x=1741302683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AY8ndVYJ7XgqaUiDvauHMj3rzJsfZgflXLJt38pHW0c=;
        b=AFpPXUT2B7BhS430CyvjOk1rJW42bm3PMgK2U0M4+ZZYx7gxQUUCeGeWYUS2jUtSgE
         pdkxRVvns8YsD+DenBsYGylCp1mEOZz9vnQbA+3Ss+pMVWh3FA1Tjn7HmomqUG9FhOKU
         gOqnJKWiA4KL1iFqa3H/S7cLJA9VdNn2S2giT96HDjbYKbdzTS6bbtVr6sk75AO6DY0G
         CW+NId1AKOUYQqEJVbpcMQjmJqixLXnqySvVxc3G82fOtkyAHD6qbKRQEfiB8Ge3FLPZ
         GKI1wdatXn8htOl4KFw9Nk1JppfXsJuOhvi/TXR3weFe1M/bceXGVf3eY23Acg2fQZva
         ngPA==
X-Forwarded-Encrypted: i=1; AJvYcCVolypfRDzqjLsVbpk7hPtMEoF21O8lriE8J5ua6Sfp1fhTOVCbaosY4NjTwpbJ6u320ZSEdqLKDXrhJa1u@vger.kernel.org, AJvYcCX2k70xJJ3yZqz/3EuGH3A+ZAZ9YlGiett6h+GYoTTRLsAaw7uk6cGbzfRIBwObpm3n8YeJqqHIkAXMdiGu@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa0gpd8JFJhCFSHvdS7R0lkXeAYIDibe58eD7jD8MisY1Phx/b
	YwEnuad9yHzWWdXvwezkgDmd4WytM9IMPC2mt/ewpOBURPUeoEga
X-Gm-Gg: ASbGncu5bSAN2qb/u1njr0CH6v1MzF3ZvaJpV4B/zAGOuNvJfBH53jgNF7e2pfhucvI
	lTGfEK54naMC88LieEZVk/8a/PkWilULoiQw441Cs9hCZFIeQpA5RZYtuLfp30zFomjMDBIbo+K
	TKY+8vWYQ7eu1LPGzwuSFhYkMIILtoWodKu5ZkOfp6GGNPlqPeJckqHXtDmsSU2R5gbdH1JVfEN
	3d427E1zYibQtFXAIBRrjMMygXnTYtpvopUXgTxCg8SC904n++7ZJVOmlYXY8fWzzMgfmkqRR2L
	o8kx+mueRWyHJ17SxT5oG80EEZizuug4zvjYQSEoIG6O
X-Google-Smtp-Source: AGHT+IH1s6mwS8zayyWG+J0RZb18tEFC5xGqBkXi4CaMktxg/7/kRZoW/5g2fKi/89vA6+bnOCcD2Q==
X-Received: by 2002:a17:907:6d25:b0:ab7:ec7c:89e4 with SMTP id a640c23a62f3a-abf26542879mr109995066b.21.1740697883212;
        Thu, 27 Feb 2025 15:11:23 -0800 (PST)
Received: from f.. (cst-prg-72-140.cust.vodafone.cz. [46.135.72.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c756f6csm194377866b.141.2025.02.27.15.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 15:11:22 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	oleg@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2] pipe: cache 2 pages instead of 1
Date: Fri, 28 Feb 2025 00:11:16 +0100
Message-ID: <20250227231116.140640-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
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

v2:
- iterate over an array

 fs/pipe.c                 | 60 ++++++++++++++++++++++++++-------------
 include/linux/pipe_fs_i.h |  2 +-
 2 files changed, 41 insertions(+), 21 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 19a7948ab234..b5b40d5e2a17 100644
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
@@ -847,8 +865,10 @@ void free_pipe_info(struct pipe_inode_info *pipe)
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


