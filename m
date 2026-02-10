Return-Path: <linux-fsdevel+bounces-76779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oE/FDgF9imkgLAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 01:34:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE897115A99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 01:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32C52304A30F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 00:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F227716F0FE;
	Tue, 10 Feb 2026 00:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7zxujbB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6722F23BD1D
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 00:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770683518; cv=none; b=mcxKoG9S/O+M2AnhfMhMRNIjqAbNsh5Sb7JFrif31BkDRfgpzWxSeybKr+34TqhttDv52j3slDkksJfA/kXM8wIOi8tuYW7Yr0KRQs2MPrNS8f6S9BT7rcC5YxAWhSPCy+XpxXS3QUnKpni+EVIh56p7GI+ua7jZLN4vwI9Yo6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770683518; c=relaxed/simple;
	bh=jDAKoDquEfz5iHsJ8TA25Lvf2VjR32G+UOFLjb9wL7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MKzzwaqQP7oTR8hk7nIECsVionMgIdASovjXyoPu90fUDoua23zYAtln3LEnu8+PZLsH6tsOKi1yxSchh+5jpn2PZZ6W8B7OUL4lXMw3bAxYPTy1BxZAtIFGQYiocYZeWnBK/0PpZPpQnB+NF2Ch0AC7HLTrwzuqcw36j+yyR5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7zxujbB; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a7d98c1879so28833045ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Feb 2026 16:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770683516; x=1771288316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9CRCzJUaIG5HxVwhWAnKhbH8L9edDS0VBxCpzR+xWrM=;
        b=D7zxujbBzZMGyvnEETpidKCqoyuBeruL30zXoXEd0TzcpijD6qzjIpaTLWmNgwGkgZ
         0yMYNfME3QfmUfkTKcMETPYvWmpvJbK0rHB6Xoy1YZbWPY6BozU0beOk/snYQd02gl8X
         2eE45VNe16bniWS3s15gMVYb+iCAL5JvtQSyyLeT2j/CS2YA/dXDtb5yZv0dnKMki6FD
         rwV199sy0QHFCOpysxW0iGa7Am9nhA81D4VltKJ7p/NNVMG2cHuQXbgFxm+21P3TJaJT
         oO6xxT3kfmuJGSjkrE+QCjnGRPgskFA+b1KZO9WQw/EcGDi+sB1y1VrA6paUk9fwVRbE
         WWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770683516; x=1771288316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9CRCzJUaIG5HxVwhWAnKhbH8L9edDS0VBxCpzR+xWrM=;
        b=L1g+y8C7k81VxdPOB+sDbs1bbt3ejtDiaPFDomfMxwhS+yLv/dKXf+1Xc+xRCkgS/s
         FqP8o65hkGLSlSAqDXu7Hbv3c6I0KLyYxZUkHdD7zuvEsO7ODPG7EM9c12ValltIVFwu
         T3nif5SbdFPG29NoD99uzf39kQ5jdcBHilFQWepnCCUCoXZ33xac4dhIvuCzbpxeI0Bo
         P6DnpePidMBDHuEq+JLjCS7yEacoh101IEX2ZZtUSoNRcOW8HHapoDHUKPFdf0UEYO8t
         oq5ZQ7RUUoca3CyDOayo53viPG1pWDrkoKjrSco3PNO06PrIMbTgfnQ2h/w4m9otFLN3
         230w==
X-Forwarded-Encrypted: i=1; AJvYcCXBRE5Q5MmOY/TlfBlTT78qXtBMUrAHxePfwsM/X2Juc0lJsce/7g+y15oAWfQ/xq6sgG9IfmnJjDpWbxE9@vger.kernel.org
X-Gm-Message-State: AOJu0YzMl9pisoNV6GJRErB8K/WHV1cFNw+zm63qmvzokIJDhNvLFxO8
	mSY5sFyhO88AQMHu9I7jR+oRJ4hwlz1Y/Agg0I90p/iQczVLSLbQhD6W/zKN2A==
X-Gm-Gg: AZuq6aI9Kk9+LeUzIaQuRcIycbEevcGCylEAeyv89Kkcn/I/PpXJkbt76G8XqwKi8L+
	QOnwzOh4ZZYm7aqu5/P/sS5nsipZpO20GKcYefUoHLhfH1ndrFYZW+LbhZzxzZ5flwnEaT9A0Lz
	MRz0zfjZcp5s5kgHZjgRF0LCYukeiBJrpAWIHEQDeHADpUpAEcxpQoo5CNxq449LoIMDneIE4jO
	iwjtsLn1t7vsmIDkFOaRk6CRX/RYwcmh9XHpbSbp62yVrr0W7yuEorvjTfCMDXiWS7JE1S6VGjB
	lqP6TyUTZzAhJtQs8EAM/2Ukx3fLkRhGJ9j5Zlr1hZAKom6v0q/vxpR5X/5oCQ0GIm1THnCryhR
	uyEt/xY5ssyBMcTihsRUB4eX9jz9YXGOFc50KfoZLRrYsXPH6qN7utQ/rolP5FmXAtx4e9ocTgn
	GTkueskFP+zuz04LFbGA==
X-Received: by 2002:a17:902:d58d:b0:2a9:4c5b:913d with SMTP id d9443c01a7336-2ab10c5b00cmr4738265ad.56.1770683515698;
        Mon, 09 Feb 2026 16:31:55 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4e::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aa3ec42e2asm118311645ad.53.2026.02.09.16.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 16:31:55 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: axboe@kernel.dk,
	io-uring@vger.kernel.org
Cc: csander@purestorage.com,
	krisman@suse.de,
	bernd@bsbernd.com,
	hch@infradead.org,
	asml.silence@gmail.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 10/11] io_uring/kbuf: return buffer id in buffer selection
Date: Mon,  9 Feb 2026 16:28:51 -0800
Message-ID: <20260210002852.1394504-11-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260210002852.1394504-1-joannelkoong@gmail.com>
References: <20260210002852.1394504-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[purestorage.com,suse.de,bsbernd.com,infradead.org,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76779-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE897115A99
X-Rspamd-Action: no action

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
index d4b5943bdeb1..94df2bdebe77 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -71,7 +71,7 @@ void io_uring_cmd_issue_blocking(struct io_uring_cmd *ioucmd);
 
 /*
  * Select a buffer from the provided buffer group for multishot uring_cmd.
- * Returns the selected buffer address and size.
+ * Returns the selected buffer address, size, and id.
  */
 struct io_br_sel io_uring_cmd_buffer_select(struct io_uring_cmd *ioucmd,
 					    unsigned buf_group, size_t *len,
diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index 36cc2e0346d9..5a56bb341337 100644
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
index 9a93f10d3214..24c1e34ea23e 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -250,6 +250,7 @@ struct io_br_sel io_ring_buffer_select(struct io_kiocb *req, size_t *len,
 	req->flags |= REQ_F_BUFFER_RING | REQ_F_BUFFERS_COMMIT;
 	req->buf_index = READ_ONCE(buf->bid);
 	sel.buf_list = bl;
+	sel.buf_id = req->buf_index;
 	if (bl->flags & IOBL_KERNEL_MANAGED)
 		sel.kaddr = (void *)(uintptr_t)READ_ONCE(buf->addr);
 	else
@@ -274,10 +275,12 @@ struct io_br_sel io_buffer_select(struct io_kiocb *req, size_t *len,
 
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


