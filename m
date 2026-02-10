Return-Path: <linux-fsdevel+bounces-76778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMWeH/N8imk4LAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 01:33:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC293115A82
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 01:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9312E304703F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 00:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB3016F0FE;
	Tue, 10 Feb 2026 00:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGPNJljL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B438D18E02A
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 00:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770683515; cv=none; b=s2jKVQTk7HptaMqeA47nRWOCarT5kAga89h8XK1nVUr8KKyUEoHNTwin7s3LazhOvaBkj7STq1S6w3/LvNhMATcTs8573bIH7WJVSotVQ5CEZ0lGVwJ0itZHoXzl0AM9FCqXe2vtKKrvclQj9to5GVkxlMEb23sFuuAATswbDl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770683515; c=relaxed/simple;
	bh=85T418bxMQPlMoZgpwsR449gfWaGrmCBfTpbDTAIlA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QLuUkfsih8iCKT/2aELjuwIKtg67KHOA98iRSfMnmPVuqeZEHA2GiJi2sA8RkPOna2OmHr2g2K3sc2RgBhd6LS5qAoz8+8D/76cFp+AN8xhWETGtxTNAcVwpx+p1v20FBH74upxk1dOdQELDI9jx3BxSn8Tnx/r4P3v1D4yldZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGPNJljL; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c2a9a9b43b1so2078095a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Feb 2026 16:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770683514; x=1771288314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4GMzQ+WyVIO7EowZoyQFL8qWo07xEupOkDSdjri3ek=;
        b=jGPNJljLXc3IFXzRxV+/piT7XXqzTSROpKhtyVIXOCzPwjGW2j2s409zz1+C8S/fVx
         1tLOigkc1nCwgQibub1IDZwqcyUk5GXsxDvMjYK7W/fXyq+elFVBjw93HBlTj1kwoCOJ
         DpDviI8oI7zHHBpmwDoV/6ElnS9d47tJvDgx/V92afZjeFvf/epRpiWNKU0HN+SxvpVl
         zvkDqvvhxDEIWG4wvfqUSlCnFAQUGdxxu5NUIGLQfihQUM+R9YpVstAFskMhMgVvymQs
         D5YL6POYCYqYFQ8c+KW4bWc0ARUs5ijZyluX4U7gMijCMHIxtXO/SDSAgdChk/0RAEuD
         BrWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770683514; x=1771288314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j4GMzQ+WyVIO7EowZoyQFL8qWo07xEupOkDSdjri3ek=;
        b=tpPgvSYkySgFi9iqwdxiJq8tr01lzKpTMByoBGd/tmp183V0H78QVkkTKMtV2pHGfB
         eaK9GMmBBV9u0llPtEpa8FLdSe5rGyB2zjO9O2Nc8G31epJj7HGTjzJZiEN5Cc7Qs5cV
         0J5cb8F705xes7zUKNU4WjXG8KUAYqv1ZT9GiN3nP6cOYmdvL2Dtt8vfyLeDNKpsJE9t
         iwzqJm5E1kW9rsmSJCIgUXS5QmN7aLP6qM7qIhefGMNj5pUxKrx5dErj6DlVHef02TMe
         lTNXEJ3tixrjPviwB5SySUpE5Z+2Kg96/yqpX5AgNyWT8qfbFt9NBGe7yhZ7Bcxk7S93
         U2Bg==
X-Forwarded-Encrypted: i=1; AJvYcCUu7F1kB1XGS4Mb+21ZoM1xd2DPakywQhzcEcxeyDle5adYUn4Q2sZzAsSuyWHsDwNGecuSndd/LJHXIoeJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+uajuSeB84NNoVjsCHSkvjfd+QGErprZYM6iU/4EMt+YsZ7NX
	+j7q7ubzOft82vJSPEw/usQGCzKAi4W4JCSWaKkhC9wOWK+gWnQ0UD6I
X-Gm-Gg: AZuq6aIc1mI0EYxy+bqJySSiLQ4yd8iSRUHSU6V8bLPlRVV13DuRyCiRjkUukOWwlbQ
	U0uo991+T8QS3ZZEz65O8wYUQScARfgjBjEvveQrodRjxOVT/oTy5USsdZJW8afCNg03hxYo8Bp
	Yja81mcxKVWcnJDZW7z3W/51b6U6WVQ/Ao8IF//RPJp7SS7jZRq3RE/p9MQcfCeXJ0qZnj77yWx
	aSfYpeVoZbAFHnhnGyYff3UaJ1yDnOamu6E/SZlyhIqeULr+z/e9BieapTPEN1YnI3tYGx4H4zh
	bKtZg9hjPC9rtIhpiHAViH6jQ9T8MfklsS1MuIuVGqj+LXxK+8fVmQ5v+wiWuF/kPxTxNIG/Ce3
	8kxGbHaln3WPmNN4MW1NAGxwHWU96XWNY9RcXd1PqyBS6U5T9jL5zAI0wjGM1hbWZcoTh2OpCHK
	JbHNcc9xV0W2o/MS8XsA==
X-Received: by 2002:a17:903:298e:b0:2a0:b06d:1585 with SMTP id d9443c01a7336-2a951926c64mr120927835ad.34.1770683514022;
        Mon, 09 Feb 2026 16:31:54 -0800 (PST)
Received: from localhost ([2a03:2880:ff:55::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab0b392cb5sm7660585ad.70.2026.02.09.16.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 16:31:53 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: axboe@kernel.dk,
	io-uring@vger.kernel.org
Cc: csander@purestorage.com,
	krisman@suse.de,
	bernd@bsbernd.com,
	hch@infradead.org,
	asml.silence@gmail.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 09/11] io_uring/kbuf: export io_ring_buffer_select()
Date: Mon,  9 Feb 2026 16:28:50 -0800
Message-ID: <20260210002852.1394504-10-joannelkoong@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-76778-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: DC293115A82
X-Rspamd-Action: no action

Export io_ring_buffer_select() so that it may be used by callers who
pass in a pinned bufring without needing to grab the io_uring mutex.

This is a preparatory patch that will be needed by fuse io-uring, which
will need to select a buffer from a kernel-managed bufring while the
uring mutex may already be held by in-progress commits, and may need to
select a buffer in atomic contexts.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/io_uring/cmd.h | 14 ++++++++++++++
 io_uring/kbuf.c              |  7 ++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index 04a937f6f4d3..d4b5943bdeb1 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -95,6 +95,10 @@ int io_uring_kmbuf_recycle(struct io_uring_cmd *cmd, unsigned int buf_group,
 
 bool io_uring_is_kmbuf_ring(struct io_uring_cmd *cmd, unsigned int buf_group,
 			    unsigned int issue_flags);
+
+struct io_br_sel io_ring_buffer_select(struct io_kiocb *req, size_t *len,
+				       struct io_buffer_list *bl,
+				       unsigned int issue_flags);
 #else
 static inline int
 io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
@@ -163,6 +167,16 @@ static inline bool io_uring_is_kmbuf_ring(struct io_uring_cmd *cmd,
 {
 	return false;
 }
+static inline struct io_br_sel io_ring_buffer_select(struct io_kiocb *req,
+						     size_t *len,
+						     struct io_buffer_list *bl,
+						     unsigned int issue_flags)
+{
+	struct io_br_sel sel = {
+		.val = -EOPNOTSUPP,
+	};
+	return sel;
+}
 #endif
 
 static inline struct io_uring_cmd *io_uring_cmd_from_tw(struct io_tw_req tw_req)
diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index 797cc2f0a5e9..9a93f10d3214 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -226,9 +226,9 @@ static bool io_should_commit(struct io_kiocb *req, struct io_buffer_list *bl,
 	return false;
 }
 
-static struct io_br_sel io_ring_buffer_select(struct io_kiocb *req, size_t *len,
-					      struct io_buffer_list *bl,
-					      unsigned int issue_flags)
+struct io_br_sel io_ring_buffer_select(struct io_kiocb *req, size_t *len,
+				       struct io_buffer_list *bl,
+				       unsigned int issue_flags)
 {
 	struct io_uring_buf_ring *br = bl->buf_ring;
 	__u16 tail, head = bl->head;
@@ -261,6 +261,7 @@ static struct io_br_sel io_ring_buffer_select(struct io_kiocb *req, size_t *len,
 	}
 	return sel;
 }
+EXPORT_SYMBOL_GPL(io_ring_buffer_select);
 
 struct io_br_sel io_buffer_select(struct io_kiocb *req, size_t *len,
 				  unsigned buf_group, unsigned int issue_flags)
-- 
2.47.3


