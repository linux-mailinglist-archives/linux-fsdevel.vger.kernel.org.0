Return-Path: <linux-fsdevel+bounces-42990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0718A4CABC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 19:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA58A3ABACA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 17:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D10215F61;
	Mon,  3 Mar 2025 17:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PA8IiwNz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1970514A62B;
	Mon,  3 Mar 2025 17:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741024508; cv=none; b=QazK/YpG9w1FkGhJO1A1Vu0McjMdWIGfrW+w5te1Gfr8/nc7bfLHZzUyDVEK+jolLhJeYtyh+WBKNZLflZ3hYeus3B0P+MC9rt8AhI6l0GK2eQPtsEX/IAeTHj/QBz9JmavQDi0puwuVJLST+lVfwjdJS02c99/A0FFD/vjFUJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741024508; c=relaxed/simple;
	bh=bygB+KSy4nCyH86yMVpCzDQGwYnbdH7wYJjn25uKJP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cp/Gts5f6Xvzy1n7WkfdV3fygyAavYMQRjUi7XkefVSisehWCj7L1KL6ou3TtP1PQNO5WoE6jRMMmAznodmRCPUqQLAWlwTw0K1Y3p1L9cbMDjkNmbpkNp1USzuvWIkHuXFPiUKeCAAnSeLXvKG1iiH3S8/IvBgowSM9q3sAPe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PA8IiwNz; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-439946a49e1so30718895e9.0;
        Mon, 03 Mar 2025 09:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741024505; x=1741629305; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GxgMyPCeZhrpNp+/XnLUc7w3JJy9kOWYtBCSGvA+8J8=;
        b=PA8IiwNz8YRE+fczawZReC5/NRyStLvOxlWZceLPtSfx6XhNCwLq2GocQCFk9/bYDB
         h5ze5BHmI/ydU1m5CIarEWB0XgKHGoZ5uwLA4TqOOJnfWcFbMpsqSdMH2BzsWeSLigxi
         qL5q/Pm4qahdklHjcKQi8Kb6hHlsGKdOmUm8AJ/y9Kh90d98rQllbpAxvPmuhJPrit1V
         AsDdSG2ooyw89Y30c/USoqK02sN7NF6LqB1ThnJB+5qEEPhygNpVzVii9leAfBBGSlcy
         k/qMCHm7dxylEmNU2MnbYqORfyGgjpC33yfvnDIgqETUYgz0mtRzm+N+s56zFIEUwXN4
         YRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741024505; x=1741629305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GxgMyPCeZhrpNp+/XnLUc7w3JJy9kOWYtBCSGvA+8J8=;
        b=WNULdoLpKaG9GdOx11N5V2+NPYDgQKP3UYO5OVMkUFPFJ7rMUbIXUQuf6FeowhWV5m
         B9ikKBQLQ+njEtzJXWIlgG0DEMP+4NLoKHSwpzweZj23ZtRsB2Yb3uIB7MkE36nLh2Mo
         33lJSJgQX9RBFsrAG4Uiil0MMucA6Dz3/3caSkTxpuUekLu54BnnGf4FVucad1teRSWy
         FCM4meZ0gDL2fGeQyGcUBRBOhGQ8MB3c/h86SYGKP4JcAdSo54wF7F9hmHm9Zjyoz/tb
         N2Talrv6jRlgYQSS/LdC/e2SsiWJBbskTxA+dovpOz3OKQoX6q1sxeP3i4ZicrbS7K6T
         KvTA==
X-Forwarded-Encrypted: i=1; AJvYcCVd3QgA59sU0VuV62T1N1mL7/qkZgSD55HBx4SnoWmHUeMkj2+LHQaSoMVH/KSbHO/2yDnUE6v34tFSVARl@vger.kernel.org, AJvYcCWCfSFc9UMBdZ7idc4wu2jSyj+eItjqcJsw8W/ZEC4XfIo3iW/TzYi1O7sa9ADUxOiT4AIiA7sC6lP0bd04@vger.kernel.org
X-Gm-Message-State: AOJu0YzKMy0a7yYFLmKFWA3aH+ff+iMiG/G9klzmmBIjNO0d/EIrG8MA
	r39Xu9xOqoLGmoiOVb6MGZoFn7bv1ZYAahfORAReVgaCe7YoHUjp
X-Gm-Gg: ASbGncvnot4/Jxoi93x6mnvGzwBMwEw4tvc2CF1azunm+4m9SVVVMAUaDLGzV31aWhj
	RQQ2f8N87yHyv099MN3BRlqBLI/Ide2owy5TeD9I3oMWuMV2rWmU8m/CRuJTlwP87EHXde12RQZ
	yyp8CD3KJAqL2UxQgwnXBD0TC5zq+amX6UizShRwZ4tuWkdJt5v6D/CWdjAfm6Jg5WkrGHQr55/
	V9o9MQpQim3+7tWTBkejWu/bSQx9hwHlT+AOn7FVvJaRiWKP1w0X0p/jt0GFUGXTHtW/BlJSgOx
	zWXab5rlrFynPfZWZjgXe3u+EyVzsW7nUYm166tbLyxrqZyXk81QcPZIJA==
X-Google-Smtp-Source: AGHT+IHSEmvlUjg6uYfCQCNPZnFb4aRlIqcXxHFDy8STT/fnere33E6vvwoMfgidfuWCURMih5FMjQ==
X-Received: by 2002:a05:600c:1c95:b0:43b:cad1:46a0 with SMTP id 5b1f17b1804b1-43bcad14869mr2729815e9.14.1741024505016;
        Mon, 03 Mar 2025 09:55:05 -0800 (PST)
Received: from f (cst-prg-71-44.cust.vodafone.cz. [46.135.71.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba52b591sm200078405e9.6.2025.03.03.09.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 09:55:04 -0800 (PST)
Date: Mon, 3 Mar 2025 18:54:53 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>, 
	Oleg Nesterov <oleg@redhat.com>, Manfred Spraul <manfred@colorfullife.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, 
	David Howells <dhowells@redhat.com>, WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>, 
	Neeraj.Upadhyay@amd.com, Ananth.narayan@amd.com
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
Message-ID: <3jnnhipk2at3f7r23qb7fvznqg6dqw4rfrhajc7h6j2nu7twi2@wc3g5sdlfewt>
References: <qsehsgqnti4csvsg2xrrsof4qm4smhdhv6s4v4twspf76bp3jo@2mpz5xtqhmgt>
 <c63cc8e8-424f-43e2-834f-fc449b24787e@amd.com>
 <20250227211229.GD25639@redhat.com>
 <06ae9c0e-ba5c-4f25-a9b9-a34f3290f3fe@amd.com>
 <20250228143049.GA17761@redhat.com>
 <20250228163347.GB17761@redhat.com>
 <03a1f4af-47e0-459d-b2bf-9f65536fc2ab@amd.com>
 <CAGudoHHA7uAVUmBWMy4L50DXb4uhi72iU+nHad=Soy17Xvf8yw@mail.gmail.com>
 <CAGudoHE_M2MUOpqhYXHtGvvWAL4Z7=u36dcs0jh3PxCDwqMf+w@mail.gmail.com>
 <741fe214-d534-4484-9cf3-122aabe6281e@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <741fe214-d534-4484-9cf3-122aabe6281e@amd.com>

Can you guys try out the patch below?

It changes things up so that there is no need to read 2 different vars.

It is not the final version and I don't claim to be able to fully
justify the thing at the moment either, but I would like to know if it
fixes the problem.

If you don't have time that's fine, this is a quick jab. While I can't
reproduce the bug myself even after inserting a delay by hand with
msleep between the loads, I verified it does not outright break either.
:P

diff --git a/fs/pipe.c b/fs/pipe.c
index 19a7948ab234..e61ad589fc2c 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -210,11 +210,21 @@ static const struct pipe_buf_operations anon_pipe_buf_ops = {
 /* Done while waiting without holding the pipe lock - thus the READ_ONCE() */
 static inline bool pipe_readable(const struct pipe_inode_info *pipe)
 {
-	unsigned int head = READ_ONCE(pipe->head);
-	unsigned int tail = READ_ONCE(pipe->tail);
-	unsigned int writers = READ_ONCE(pipe->writers);
+	return !READ_ONCE(pipe->isempty) || !READ_ONCE(pipe->writers);
+}
+
+static inline void pipe_recalc_state(struct pipe_inode_info *pipe)
+{
+	pipe->isempty = pipe_empty(pipe->head, pipe->tail);
+	pipe->isfull = pipe_full(pipe->head, pipe->tail, pipe->max_usage);
+	VFS_BUG_ON(pipe->isempty && pipe->isfull);
+}
 
-	return !pipe_empty(head, tail) || !writers;
+static inline void pipe_update_head(struct pipe_inode_info *pipe,
+				    unsigned int head)
+{
+	pipe->head = ++head;
+	pipe_recalc_state(pipe);
 }
 
 static inline unsigned int pipe_update_tail(struct pipe_inode_info *pipe,
@@ -244,6 +254,7 @@ static inline unsigned int pipe_update_tail(struct pipe_inode_info *pipe,
 	 * without the spinlock - the mutex is enough.
 	 */
 	pipe->tail = ++tail;
+	pipe_recalc_state(pipe);
 	return tail;
 }
 
@@ -403,12 +414,7 @@ static inline int is_packetized(struct file *file)
 /* Done while waiting without holding the pipe lock - thus the READ_ONCE() */
 static inline bool pipe_writable(const struct pipe_inode_info *pipe)
 {
-	unsigned int head = READ_ONCE(pipe->head);
-	unsigned int tail = READ_ONCE(pipe->tail);
-	unsigned int max_usage = READ_ONCE(pipe->max_usage);
-
-	return !pipe_full(head, tail, max_usage) ||
-		!READ_ONCE(pipe->readers);
+	return !READ_ONCE(pipe->isfull) || !READ_ONCE(pipe->readers);
 }
 
 static ssize_t
@@ -512,7 +518,7 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 				break;
 			}
 
-			pipe->head = head + 1;
+			pipe_update_head(pipe, head);
 			pipe->tmp_page = NULL;
 			/* Insert it into the buffer array */
 			buf = &pipe->bufs[head & mask];
@@ -529,10 +535,9 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 
 			if (!iov_iter_count(from))
 				break;
-		}
 
-		if (!pipe_full(head, pipe->tail, pipe->max_usage))
 			continue;
+		}
 
 		/* Wait for buffer space to become available. */
 		if ((filp->f_flags & O_NONBLOCK) ||
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index 8ff23bf5a819..d4b7539399b5 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -69,6 +69,8 @@ struct pipe_inode_info {
 	unsigned int r_counter;
 	unsigned int w_counter;
 	bool poll_usage;
+	bool isempty;
+	bool isfull;
 #ifdef CONFIG_WATCH_QUEUE
 	bool note_loss;
 #endif

