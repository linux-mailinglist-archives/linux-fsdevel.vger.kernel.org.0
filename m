Return-Path: <linux-fsdevel+bounces-79556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODDfIfogqmn2LgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 01:34:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A974219DA5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 01:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BED4F3040183
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 00:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E962D73B8;
	Fri,  6 Mar 2026 00:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJ8QeFsE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3455E2D7DCE
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Mar 2026 00:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772757200; cv=none; b=fspv5S9hje6srVCyghiu11bCqwNcIMONm5y01au/DpBklHi+K8GvSkUc9icJIhIH8HwfmJlt1PnwwGtwHklrHM1SDa7lOPaLFyIntyGnTkKUh0OB9PAIvYJltSWnXz3Wiojq7JN1u08oMtS3/qBQ2Eo/LoNH/KVnlITV+IDt0xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772757200; c=relaxed/simple;
	bh=9FiJ9Vh/COT/DtwiC7Qy6dUrzqWlig2GQOyBX8xa26w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aY4kXNPBnlIE+Lm5F/0v40eOlAvx6sirGMuuSnOMw/QJP9nLRPVHBorb5flpeQShjAJ90V0K+VaWzOefO+udBmUXEWH6icLaho4l9yaiFqtJL8ig4fSIRuSVn0B+ym4jPKLjrtS59TW333ZoabyzTQNPEzzTU4UyCmLazTPlcnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJ8QeFsE; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ae505619baso30253255ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Mar 2026 16:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772757197; x=1773361997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYsWQ4yEhY0GWyuiUuPHYhvzR+dlr1D7W6qgXUYn5hQ=;
        b=TJ8QeFsERxwOVeIEEYs1s1LAoH6kdWL4uom8rc2YTp4oNuCiG06g0FCiZiBvpIc49X
         SkXW3WrwC/TD3XnBZvdbM316cVtqveY7OrDJz/Pb3vN0OPAavmxOYFMirvFiTt4pbH6W
         hov6jfedvKsaqnKm3yPrIeZnOudFRctWG+BTQpI/tc1MNJuBWuIYpyWQJSu6Cz0ZAFWX
         iz/jxcTQB/MvSMHLjzM4qLXyymf/qUvyLkTJyIiFLCc8Mx24PIgI0OXG4/P4GAaU6h2u
         PHoQkKVdVeR1/ZVMY1u/TteqAdJBta6CZFzH9PSYkLkMrIfI8Ml/G46DHOZoU5adaaNH
         FuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772757197; x=1773361997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uYsWQ4yEhY0GWyuiUuPHYhvzR+dlr1D7W6qgXUYn5hQ=;
        b=HSS0T07kzaeYu5ZWQxHsuA75tlrwEC0HJu62v8Y5BOQnif6sy9iuz+YUQlFHI9EV3Q
         EN4AOh2NYmxfFAR3b2ThL0z1Nu67pcr+vBx1o10pS0/e/62crlhrX8SzzsdCtksLtCG8
         PceEsTnUVVIYoQdvnXRqH29XFNMVlNmII6qKm6lrLUKSqx6ATyg3RFbJiK8hMjRzamy0
         kXZVcb59g1w6iR//G3CYX16qoa1ds3Vzh4eXtTGfIuqiX7LjU7Rn7QhqS/XMKKNw2/Xq
         6325Nj9ZY72Xi6HBa8C9DNC4uUeT7glyl/qy8IAQiV0C0KzS492zadqJTYEff/1ozYfh
         lykw==
X-Forwarded-Encrypted: i=1; AJvYcCU16PTEC6OCM3/NZouiuYm9qQVD5PS/Pi+IaKgEmdVAVkIBC1NDnv4hPpqJLpu7Wr+ndipDGsFfcNChD2fQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv0zD4IqbSYrRM0DmTFlPoWaaeqURLwxFYGeUl1z4FgjvpIFJu
	OHXbhbto13cxQXGaICtzs0Y0oe4tyQ88SfrRToRjjI4hkEG8qHe3NbxA
X-Gm-Gg: ATEYQzwwBKZoWZhkfdzvF4dUb+98Z+r+nfhSQhwhFxIvvQ9cDu3keO+Mc92pKYyxWmV
	TMsFxjg4dwft2/gqBjKwbCX+Aj/0Ng+27ZG1CY1bW3IYeB+GzijIWf8GoqBmXzeI8jfmd77Cp8b
	Bye7Ck/tp2NstuxDLbSeglJ1LtFzZ2w/noodg0yZc8Q9ccnskIGiboQWvNw3lsjLH6UTgv/IB4g
	mZC59+k/a4JZxYhySxnyoWb1OOC5YWXzLYqs/qbfSJata8RXCLNKt0fyufoQ5Z99lPJnhSeetKq
	ZHtMKPL+o2+3JhR//O8boeCI18j4zNc6b8yKEfwg4/yCTX0ggLYwFgstd5SyLSgIMBhlRSK0DEd
	7SnUSmy2KPaDFfQe2/A+20gFyEPxE060VsRBKljpGsZgQ03bYsrSH7yTgiuM2LLlZgUA8qAsj8x
	iqW/pfRDm2dZ16cFoJRg==
X-Received: by 2002:a17:903:1aef:b0:2ae:4555:479e with SMTP id d9443c01a7336-2ae8243aa03mr3702915ad.18.1772757197353;
        Thu, 05 Mar 2026 16:33:17 -0800 (PST)
Received: from localhost ([2a03:2880:ff:49::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae5e1699easm94810615ad.7.2026.03.05.16.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 16:33:17 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: axboe@kernel.dk
Cc: hch@infradead.org,
	asml.silence@gmail.com,
	bernd@bsbernd.com,
	csander@purestorage.com,
	krisman@suse.de,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: [PATCH v3 6/8] io_uring/kbuf: add io_uring_is_kmbuf_ring()
Date: Thu,  5 Mar 2026 16:32:22 -0800
Message-ID: <20260306003224.3620942-7-joannelkoong@gmail.com>
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
X-Rspamd-Queue-Id: 0A974219DA5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-79556-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

io_uring_is_kmbuf_ring() returns true if there is a kernel-managed
buffer ring at the specified buffer group.

This is a preparatory patch for upcoming fuse kernel-managed buffer
support, which needs to ensure the buffer ring registered by the server
is a kernel-managed buffer ring.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/io_uring/cmd.h |  9 +++++++++
 io_uring/kbuf.c              | 20 ++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index dabe0cd3fe38..b258671099ec 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -99,6 +99,9 @@ int io_uring_buf_ring_unpin(struct io_uring_cmd *cmd, unsigned buf_group,
 int io_uring_kmbuf_recycle(struct io_uring_cmd *cmd, unsigned int buf_group,
 			   u64 addr, unsigned int len, unsigned int bid,
 			   unsigned int issue_flags);
+
+bool io_uring_is_kmbuf_ring(struct io_uring_cmd *cmd, unsigned int buf_group,
+			    unsigned int issue_flags);
 #else
 static inline int
 io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
@@ -161,6 +164,12 @@ static inline int io_uring_kmbuf_recycle(struct io_uring_cmd *cmd,
 {
 	return -EOPNOTSUPP;
 }
+static inline bool io_uring_is_kmbuf_ring(struct io_uring_cmd *cmd,
+					  unsigned int buf_group,
+					  unsigned int issue_flags)
+{
+	return false;
+}
 #endif
 
 static inline struct io_uring_cmd *io_uring_cmd_from_tw(struct io_tw_req tw_req)
diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index 1497326694d0..ef9be071ae4e 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -917,3 +917,23 @@ struct io_mapped_region *io_pbuf_get_region(struct io_ring_ctx *ctx,
 		return NULL;
 	return &bl->region;
 }
+
+bool io_uring_is_kmbuf_ring(struct io_uring_cmd *cmd, unsigned int buf_group,
+			    unsigned int issue_flags)
+{
+	struct io_ring_ctx *ctx = cmd_to_io_kiocb(cmd)->ctx;
+	struct io_buffer_list *bl;
+	bool is_kmbuf_ring = false;
+
+	io_ring_submit_lock(ctx, issue_flags);
+
+	bl = io_buffer_get_list(ctx, buf_group);
+	if (likely(bl) && (bl->flags & IOBL_KERNEL_MANAGED)) {
+		WARN_ON_ONCE(!(bl->flags & IOBL_BUF_RING));
+		is_kmbuf_ring = true;
+	}
+
+	io_ring_submit_unlock(ctx, issue_flags);
+	return is_kmbuf_ring;
+}
+EXPORT_SYMBOL_GPL(io_uring_is_kmbuf_ring);
-- 
2.47.3


