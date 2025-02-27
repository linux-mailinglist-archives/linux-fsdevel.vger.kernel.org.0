Return-Path: <linux-fsdevel+bounces-42768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06637A4873B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 19:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFA191891A7E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 18:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D63E1EB5FF;
	Thu, 27 Feb 2025 18:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lj5xxQ2X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022CF1DDA3D;
	Thu, 27 Feb 2025 18:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740679464; cv=none; b=uQCKpGsRBRhbP9H6jFmt4UN1iCq1LXoBP0Gu9JpBT3pNJFn/UbGSMYA4ljjDOf2vR/xhK4A/SxWcHctVXfOdW6g4h+HcQVd96/Bka48LrzCXqSswuLp08yPKWMOjC9av5SZKdmOcb7FhxmQvsxCaGzkzbLacep9Swr9kIGRsM2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740679464; c=relaxed/simple;
	bh=iSjuS89FEZ15XYsSuWXx6li3MNVymA0EpMw0imDyXZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qk/hbGpLMrQvM03a5wTC4vkIUYKiGTloKaUNIJIM+iO/bjpWRV7YZCOa79+cQTuOzq2yRfArljb1kTGbDy7Gouzo8T0kESLlxSKo+SqULF1QNmVYIMzbqenSB+C1OGtGEx98eByP38Gad88fXsx7/512oZ23aNbL8nQI+vMMVEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lj5xxQ2X; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54524740032so1210788e87.3;
        Thu, 27 Feb 2025 10:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740679461; x=1741284261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p64rkc2/wV0ej6a0OX3NpwSYfnbAOnRa6XnC1VmKW3I=;
        b=Lj5xxQ2XmruUUOsuDT9m2U2+vvM3g+SYStwc833A47SID9ghyM0jD59iGuWpLCNshE
         8AlVZLHzpY+d1HpXhscAIoQRvvbKgsfvhOcmlL5z8N2HFiF6CCY66EeAVgwwE9CFKze6
         4fizWgRJjVuVjz1nOeDkpvFN43WjReaCVSBhF27Pq7ZvARMyyKblUhX7eWubeaZSHKYz
         /kcDeKTHbXdoMSOCOIFANwkNFWQamPqnASugKYR2qMi67Oof9N9l8LX21E3qxRyna9WI
         VpbtcEWWjSUMIUazRnrm00HoinhLAYfw2M5fOBuNNtuS2X7M5oxnPMn6ANS13rIrnvvn
         /Mqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740679461; x=1741284261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p64rkc2/wV0ej6a0OX3NpwSYfnbAOnRa6XnC1VmKW3I=;
        b=E5RCq7BpYYK+ff5t7Ru3ADGJZh97eT9xRtbwv3KGe5vp+q/ag/JHrGWAWqUpg8ZnAT
         rUVel5bo0moCS/DWAcnZyKtEdxhr/ZSRtBAIDOAv+xR1Lbfv0nP9YWoWkyme/GSi3NLW
         ggDhiFb1m8kzF/f/C+r5vIfV1qKD69t/w8+St/eECYz0UXiaYtQYdnTui2pkvTmqttQB
         aDkoT6UjR5CBrHu2qgIZihIDShU/KSSeBOmJKrihc6mj+wam8mjlOTkYf152PQ+MRxFH
         CSwEywWpQSXpZ7dX363ydw1L6PcJkEc6a+Z/jgRPqQBMAjAk+l87M4YnmZ1z5XmkFzQn
         Z8Sg==
X-Forwarded-Encrypted: i=1; AJvYcCUNyLNuF6XqaxzY07czOwt9+cpdnqmBAkbAvX4O1No72zu9xuAjSiXSaAHoqKDIseA4lkrt1uqCN95osvXP@vger.kernel.org, AJvYcCXJ29/BslbpjhVMEdln7bJqSuK2C9NkGvHMI59AvFE/yxc2ETehgCT4FQoTGB07DX9VWgfVShx3xFlPVdKw@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/1ncjfHI/xRiU4aCYoQTHTd7BPfbQT/mERkU9To7fjSp9/DTe
	OmhYoNKD5WS/ETDH8MgfhInQnnVjvoG7nwLEYQrOnLYmGjq8fWMv
X-Gm-Gg: ASbGnctHPCYX0cngsMqJ2f5cWnvl071zS66tTQklATtvOJLD01YHbeXSSGz6q0gqJS2
	s8Huye/YRWR8SN/HpoY7RSpDoo0F+glrZyV7RMBijNsLHP4tkqNadaNlUlkx1w8Gn/YMyTzAgkX
	YaFUGTBvvROEhtx7wh4VPnJ6Crr1i4WZ4TDWt8gOXs5OJoob9wcOoUKdbwJWjGouSOIydYZ6jTr
	mUu1k5Vw+Oe0aoBQ44SFwGf5qS669WKmzwhvNCnsaa7795yxGux5CQPo8eCLWMD87FYrp2SuTMs
	HkgnkDPDdfy7Xg6ZnIdOx39SgfxWy0e+JXvKUVDt0IX3
X-Google-Smtp-Source: AGHT+IEWSzLX5rXDnH6GIqDb+xXExjOnXpxrGLpCDB+AkWNgim9KIb74ynx2zh+Wm2ppFgvjkcbakw==
X-Received: by 2002:ac2:4e11:0:b0:549:3af5:3530 with SMTP id 2adb3069b0e04-5494c354573mr208245e87.48.1740679460523;
        Thu, 27 Feb 2025 10:04:20 -0800 (PST)
Received: from f.. (cst-prg-72-140.cust.vodafone.cz. [46.135.72.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0ba6b5sm157274066b.30.2025.02.27.10.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 10:04:19 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	oleg@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] pipe: cache 2 pages instead of 1
Date: Thu, 27 Feb 2025 19:04:07 +0100
Message-ID: <20250227180407.111787-1-mjguzik@gmail.com>
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

In my testing this decreases page allocs by 60% during a -j 20 kernel
build.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/pipe.c                 | 67 +++++++++++++++++++++++++++------------
 include/linux/pipe_fs_i.h |  2 +-
 2 files changed, 48 insertions(+), 21 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 19a7948ab234..2508d14e8812 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -112,20 +112,47 @@ void pipe_double_lock(struct pipe_inode_info *pipe1,
 	pipe_lock(pipe2);
 }
 
+static struct page *anon_pipe_get_page(struct pipe_inode_info *pipe)
+{
+	struct page *page;
+
+	if (pipe->tmp_page[0]) {
+		page = pipe->tmp_page[0];
+		pipe->tmp_page[0] = NULL;
+	} else if (pipe->tmp_page[1]) {
+		page = pipe->tmp_page[1];
+		pipe->tmp_page[1] = NULL;
+	} else {
+		page = alloc_page(GFP_HIGHUSER | __GFP_ACCOUNT);
+	}
+
+	return page;
+}
+
+static void anon_pipe_put_page(struct pipe_inode_info *pipe,
+			       struct page *page)
+{
+	if (page_count(page) == 1) {
+		if (!pipe->tmp_page[0]) {
+			pipe->tmp_page[0] = page;
+			return;
+		}
+
+		if (!pipe->tmp_page[1]) {
+			pipe->tmp_page[1] = page;
+			return;
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
@@ -493,27 +520,25 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
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
@@ -847,8 +872,10 @@ void free_pipe_info(struct pipe_inode_info *pipe)
 	if (pipe->watch_queue)
 		put_watch_queue(pipe->watch_queue);
 #endif
-	if (pipe->tmp_page)
-		__free_page(pipe->tmp_page);
+	if (pipe->tmp_page[0])
+		__free_page(pipe->tmp_page[0]);
+	if (pipe->tmp_page[1])
+		__free_page(pipe->tmp_page[1]);
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


