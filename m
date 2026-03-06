Return-Path: <linux-fsdevel+bounces-79554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNQ3Kt8gqmn2LgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 01:33:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7AE219D72
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 01:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 25DF9302DE68
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 00:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1C52D2397;
	Fri,  6 Mar 2026 00:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NE/ueNpi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5914B2D47FF
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Mar 2026 00:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772757196; cv=none; b=dFSwBFkmJSNMwxtTF3VxsokgWXPij73vBSpFpDiSM9m+PpUiv36dm0tuTArPgT70wUNt29bjBOSKY71p0lclPQqJuYTeUoWFX9LEXTgqQs2W/PiE4k6mq5NPRB8PClp99wc1JXJJVcdU8mh5PDQLE99uhmgPYrap1Fsp7/BnG4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772757196; c=relaxed/simple;
	bh=gYl/EgPLgpRLJ70W17x5fC4GYre1xgh+fhjLlQ2KiVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u82uIm14umB4h+idToPkM4dw2uDPJGhYx6SbGcSKQxDAaWLj06n6Ah8ALCQpo9gweJGqOnpWRPzK+Gd4UKCrM1u9ETIB0HP6IUtV/bbmd2ltuth83i8F5RXw05QA5dMp8ZtZuklZfojdrY86bI49qdbBHsxSyWAo6wyNZO8iJWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NE/ueNpi; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82985f42664so904649b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Mar 2026 16:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772757192; x=1773361992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hh6d1b/FD+K/ax8zRmQDjv0XKlqoqIbuLbK4qEFzOTw=;
        b=NE/ueNpiKY7hK+wzVJJX2Ju4/rZEOKD7HVBXapqFATiB+e2nOtohVtzIGM7eXIb51Y
         Qx7Ykv4ej6gWeFERDVvHkM4Yk8bY06uFYkZVZTrPauC2LD+jeciMqguNCtwuzpmocuYW
         e3DRMJanzw9/VZIVC5kzST5IslA21TK9d7pKiCf7RmyEBeh/F9H88cjEK91mDqAIEvjB
         ABOyqy9Sc8cl6sRAZWvJW3QsNn3LU6qkmu06RxRIJfv2I/KhBgKPBuI4gLa5f72SHauv
         czkXvQchJHeqhNwzSnWWP0uwyj7/Wl0hmLRajfVDsXEWAO2PYgCA+hri4zLs1uGH8wzk
         4KjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772757192; x=1773361992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hh6d1b/FD+K/ax8zRmQDjv0XKlqoqIbuLbK4qEFzOTw=;
        b=nwyrUB2iTwYr0VP4NPl3+XsqGnlZWqIK3MVZsiowIci4z9xOeMBkq7sXePaRhCDIy2
         e8PC6KstMWaA+q8TCQt0ZDMJ9tlID4mRYQuuG5j+ENuiM6rt/qoTkQ0TXgiY/rx0kECz
         V6pisXI5L2+6g2BGUqs/n4zJvuf5rlFxP5jpErO7hjzZzrXuGqGUXTjF7yV8EdP6DkMz
         1k+7Z7LMmNZsYt6H6kSYS3yZ2ukxK8e1yipd/nsngxOWxCQiJExD+mXpfzsm4Rnt+Yd5
         Oi9zQHm+0ASYKjvRWZdk8E1/DxM7FgC9M8m0yEEr0JNvfrGzLGyjW/eyhtbSE2R3X2nL
         N8Gg==
X-Forwarded-Encrypted: i=1; AJvYcCUUlRjhsk0WSRsEbDr53JFSqaG13JEof+Fv2h7PJ9djJYTLnoPdAF746A1BT0ILKHeaqRA/MUhcCsUB2Ykf@vger.kernel.org
X-Gm-Message-State: AOJu0YyNINq8tNPBdmd8WVdfA8945zJP75DrqDoePAWdLVwi+reUlZTb
	mIcN7Aw6EEssl2PEKkCeCXTpgXpC5rgQqIj1h3niCtUo7k3NliD1qdC8
X-Gm-Gg: ATEYQzzR5S0mst/3VAoP61mTNFNITlzRfVILnGUzCGrxkZWvaz+8o07FhIr1nrJ6v5z
	2QO1B+yScWl/jpmJvZaOYkMAtW5w05MJrB2lgNU2zEYzRrVY9CurSvXl78HrOohyBnVZHKDXf1c
	8XGRpl2or9fYCJceEJ+hhZx5O8n2uSkVSnZrYgJXIuzf9g5YvAsF0ahv8VAMAfe2duePtSFjiT/
	X4ln9Nr5GH6675rVgNGnNRpwq+awc/iM0Qp4su29fEj2vAXphWrt0dmpNciN2VUUSLYI6fZCnt7
	+Nw5qaez1V1idzrs+D1duPFo1Hw3+XOcvgSkh1TP1Qik+2MbWHw+WQ0QPkoS38242i9tr2d9+cu
	P3oVwab9V71Zmwhix4xP+MtTB1oztDsYx3HNxtscrPkKGSpNMcqyf+Ho+CwZleM8H1o+gmysp9u
	TpnM/c7Hf6R7VrfY/RxVuMKd4GkjYy
X-Received: by 2002:a05:6a21:513:b0:395:9bfc:d5fd with SMTP id adf61e73a8af0-398590b6409mr423618637.54.1772757192461;
        Thu, 05 Mar 2026 16:33:12 -0800 (PST)
Received: from localhost ([2a03:2880:ff:40::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa82dd09sm20664692a12.28.2026.03.05.16.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 16:33:12 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: axboe@kernel.dk
Cc: hch@infradead.org,
	asml.silence@gmail.com,
	bernd@bsbernd.com,
	csander@purestorage.com,
	krisman@suse.de,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: [PATCH v3 4/8] io_uring/kbuf: return buffer id in buffer selection
Date: Thu,  5 Mar 2026 16:32:20 -0800
Message-ID: <20260306003224.3620942-5-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306003224.3620942-1-joannelkoong@gmail.com>
References: <20260306003224.3620942-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2F7AE219D72
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-79554-lists,linux-fsdevel=lfdr.de];
	TO_DN_NONE(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,gmail.com,bsbernd.com,purestorage.com,suse.de,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
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
index 7ce36e143285..505a5b13e57c 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -78,7 +78,7 @@ void io_uring_cmd_issue_blocking(struct io_uring_cmd *ioucmd);
 
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
index cb2d3bbdca67..9a681241c8b3 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -206,6 +206,7 @@ static struct io_br_sel io_ring_buffer_select(struct io_kiocb *req, size_t *len,
 	req->flags |= REQ_F_BUFFER_RING | REQ_F_BUFFERS_COMMIT;
 	req->buf_index = READ_ONCE(buf->bid);
 	sel.buf_list = bl;
+	sel.buf_id = req->buf_index;
 	if (bl->flags & IOBL_KERNEL_MANAGED)
 		sel.kaddr = (void *)(uintptr_t)READ_ONCE(buf->addr);
 	else
@@ -229,10 +230,12 @@ struct io_br_sel io_buffer_select(struct io_kiocb *req, size_t *len,
 
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


