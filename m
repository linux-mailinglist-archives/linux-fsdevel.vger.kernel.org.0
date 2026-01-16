Return-Path: <linux-fsdevel+bounces-74260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EBED38A21
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jan 2026 00:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 83D7E3025210
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 23:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8671D2D8364;
	Fri, 16 Jan 2026 23:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1LFzzch"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5AB31812E
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 23:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768606285; cv=none; b=Zb9XxZ6xoWDJ3JN4yqVcLJuQv/GZSiKiJCK7KR4FIUKWNnlH5xcW1eo55Y/EdIJCO0pIMmg3BmdSU4JBa3NtCTCcQ2MzdxeREaVy2jGy4cnQw5Sa6lZFergZc5ZNzCW+qeSwGArHjOy/U/bnhr6iVAXboVBqXWRr7teX9c4JIko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768606285; c=relaxed/simple;
	bh=d2Exw5shL65mmWBgftxDlE8YJf2sHQiJqGfzBdKjU4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ec2r1kyYlqz5PYT9hXiVc56XvkUT2frWu5s1nzPaL5Zd2kWGb+FOuUlJObMQTCOHs+2q5gm7L+6JdBFV4pRw51mFz5U2O9kJUZPNJb/BmqFfBBH6Fs0xhMD3lJz1+xPfOCYayCxnj5zrbO5ZR8wpcCM3ZAQyO1REbgCcSXY5qkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1LFzzch; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-81345800791so1578897b3a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 15:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768606283; x=1769211083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Platj88LMl/Gmni8R/u11ZNoR7auOwrTDvEWtflAldM=;
        b=A1LFzzchu5GAIttHGjPU69ZeyvAMa3etND8SOrgtYCOaePkGSXX5YdMszsVFl2qI7w
         Q6jPPSxAsCiOLf5VGETThCiuJt9gjr2oWFfSoVQX4gFIZtKv2kGaZDzX2mOryHCrSaAU
         SWZz+1kGEv7dB/ykUjC/kh6ho6Z1l3dWnVT21nEkC3QQtAGwrv7jgKr8aMmCxwEnG6LR
         eLgDBdmktzXfm1QEIY+ThgxC2VFC1uUv/ejF8RUyAkHR8BVi9ikii3PTL/T74dXgeIHc
         OwS904qwuD/iDkbUIjMQqa5EyrUrgNTR3v1ZHflBi05LnGXKKYGJvJNPGUSB0k5pZ+oI
         jELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768606283; x=1769211083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Platj88LMl/Gmni8R/u11ZNoR7auOwrTDvEWtflAldM=;
        b=HYFhKh82ONBsfARwCXUDXAQE04ooeDTGhXQSK1F8Jzk1sqf9AbCUqUWlrRNbiiE9kr
         umjZ4HivqnJnN/62XI59Lwku4hPVNoTw27VZ0TimWDgaJNiEYaV7S7LFIGP3Z3vJj+G7
         qbJGJzZaA8fGeX2JDuP+AktHCELxqG7tofGkkV/DJVFE6XQ7a65Vcy3jdUjAiQiLLyzO
         KTyYDoeZwX3wYH5EdJtu2UlU/ZoLg4y3EDWXY3E5vN6y2sWx9lIM8Kpt6wXy269JOOOE
         afTG3Tu67qdVaam+hfrcCLjrCchI2PUX5X+TrPjZqOyIceCw34z7CyOHK6jx15Jl12f+
         Upmw==
X-Forwarded-Encrypted: i=1; AJvYcCUkvxJM57uGA0UG1vVpQaIWyB3A8mryQfS0QUDHsCLUIZOUZC+bIwGS9olAHMwS5eGTutCR7YAYHn1VVWvg@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/3Imv78pjOjlK9VlN1vqokg7YmtVq80uVtqHqnqm24Jqyj/Zi
	XXEvygTOak28AD7MGgUUsw9HUJATUc8YjFpTf1NJWRLNXpPMtBVoWgkc
X-Gm-Gg: AY/fxX7pnXAXv3HS+u8gvfYZs8fJ07erJgDLcDTszJEeg0NlvqDamU6jWkmU/p/Hiai
	4WjsEs7CELGjXFCDaMzMjodufyEtiI0SPFE+7tr1IPNN/wo7vqedNxF6KvLsTj9Y1CAdDqXSl4Y
	4IZHS36j3IletVNjDsjxad6HDQHifvBryCs9qYPuvKxp4W9SbyFZHxa6ME7JcB3B3zsygk4itvJ
	xhcLGjyNJqMmuH6SfguxtTCB6zu06lCFXPmYwr+65wofBV+QuD9hbN1ZqtaqWoxqpRYuI4EmN3e
	SG6cIo6mLM0AkB3Qepse/qTa4lU8XRJ1fcNd/cg1JnpqX0sTxxdFwxYIiin7kr0RKQXc9olbWo9
	6FUa6YsqPeFtBL4P0XDDJ0sp4fjrTOYFRbCOT1vifNQ765lPL5tf+dKivrNn/VjXUVMYOqrKKoG
	WePfksGg==
X-Received: by 2002:a17:90b:1d45:b0:34c:35ce:3c5f with SMTP id 98e67ed59e1d1-3527315c079mr2886367a91.5.1768606283206;
        Fri, 16 Jan 2026 15:31:23 -0800 (PST)
Received: from localhost ([2a03:2880:ff:40::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35272f4a9a1sm2947608a91.0.2026.01.16.15.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 15:31:22 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: axboe@kernel.dk,
	miklos@szeredi.hu
Cc: bschubert@ddn.com,
	csander@purestorage.com,
	krisman@suse.de,
	io-uring@vger.kernel.org,
	asml.silence@gmail.com,
	xiaobing.li@samsung.com,
	safinaskar@gmail.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 11/25] io_uring/kbuf: return buffer id in buffer selection
Date: Fri, 16 Jan 2026 15:30:30 -0800
Message-ID: <20260116233044.1532965-12-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260116233044.1532965-1-joannelkoong@gmail.com>
References: <20260116233044.1532965-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Return the id of the selected buffer in io_buffer_select(). This is
needed for kernel-managed buffer rings to later recycle the selected
buffer.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/io_uring/cmd.h   | 2 +-
 include/linux/io_uring_types.h | 2 ++
 io_uring/kbuf.c                | 7 +++++--
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index 6ff5c0386d0a..8881fb8da5e6 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -79,7 +79,7 @@ void io_uring_cmd_issue_blocking(struct io_uring_cmd *ioucmd);
 
 /*
  * Select a buffer from the provided buffer group for multishot uring_cmd.
- * Returns the selected buffer address and size.
+ * Returns the selected buffer address, size, and id.
  */
 struct io_br_sel io_uring_cmd_buffer_select(struct io_uring_cmd *ioucmd,
 					    unsigned buf_group, size_t *len,
diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index 0b8880cdda8b..157eaf92d893 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -100,6 +100,8 @@ struct io_br_sel {
 		void *kaddr;
 	};
 	ssize_t val;
+	/* id of the selected buffer */
+	unsigned buf_id;
 };
 
 
diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index d2a660ecc7ac..ada4bdaae79d 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -251,6 +251,7 @@ struct io_br_sel io_ring_buffer_select(struct io_kiocb *req, size_t *len,
 	req->flags |= REQ_F_BUFFER_RING | REQ_F_BUFFERS_COMMIT;
 	req->buf_index = READ_ONCE(buf->bid);
 	sel.buf_list = bl;
+	sel.buf_id = req->buf_index;
 	if (bl->flags & IOBL_KERNEL_MANAGED)
 		sel.kaddr = (void *)(uintptr_t)READ_ONCE(buf->addr);
 	else
@@ -275,10 +276,12 @@ struct io_br_sel io_buffer_select(struct io_kiocb *req, size_t *len,
 
 	bl = io_buffer_get_list(ctx, buf_group);
 	if (likely(bl)) {
-		if (bl->flags & IOBL_BUF_RING)
+		if (bl->flags & IOBL_BUF_RING) {
 			sel = io_ring_buffer_select(req, len, bl, issue_flags);
-		else
+		} else {
 			sel.addr = io_provided_buffer_select(req, len, bl);
+			sel.buf_id = req->buf_index;
+		}
 	}
 	io_ring_submit_unlock(req->ctx, issue_flags);
 	return sel;
-- 
2.47.3


