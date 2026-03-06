Return-Path: <linux-fsdevel+bounces-79555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJcwI/Agqmn2LgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 01:33:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E925C219D9D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 01:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC3C93055E75
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 00:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860142D8DA3;
	Fri,  6 Mar 2026 00:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpFwsdb7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2AF2D73B6
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Mar 2026 00:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772757199; cv=none; b=VjT0DdDhXjTQMDlbJ6y+RG0ZKli6qGwX/NAQ9Z/zy67IDEUkS3xtBkxHUzH/ch3iMDZzVBzA6hsVTQs1V33aRej78EgToO+6ONi2USG63D+ZI3iSK9zIIMnYjJ0wJMWQfNgiTuWJ7W5XmaQhlZKqODYSsasqQ+R3cqle3RdweNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772757199; c=relaxed/simple;
	bh=eW6ykhDFNFYwGikdfaT7YCllrHLJjuK6FvFK7TmvP68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NzL79yl0MjCxGSOdpo+yP8wHDZaS2zDuKUmozSIsee78DcQ6P7JE5B0eJH5t6qd3/+LGYyHolQowh8sNrmyxhR4GlwJTrM8bxGhsdamaPTjA38C9Sdt6/VinOPplTv9V6hV2O05cDjd5uVZz+fnXnF5oRg3ZKLDAw4KhVjlVWns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpFwsdb7; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3597fea200dso4011023a91.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Mar 2026 16:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772757196; x=1773361996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/OEXSm1HqdjrqxJhFVvNBTSrMNAOmq7g1Suj3CR0ZY=;
        b=EpFwsdb79H5Adqe/ZhbfRH123T78MRD2BNClE2PL0p2mR638li58tn4mLl1IaRnY33
         utcIkcaAaKCrZMlDJT0v4+hRJXc4wuxelRcX1Q+T5u2CkdCLLDGC2TyO9DIewVgOshq0
         syGCsTI3tOMyTOcSYBk8uXY9ehoaXVK31/5tJQykwVHq+RgbQ534i+rBDRowJq+77VbS
         NZK4/X8QgLB4eBcCuRmKTwtMftOvc937SifzMJtE8sjabPjLMZnWHP81h6Cjy3kJOai9
         810SAWmAmusdDzyAv1MCorbpgf9pOSFDrOyxvDXErqL1FZ8hgOHFdfStHgmFk6mS+VL3
         IrfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772757196; x=1773361996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n/OEXSm1HqdjrqxJhFVvNBTSrMNAOmq7g1Suj3CR0ZY=;
        b=g/rmF0khtlaBellNzC/bZ2326xflLPpcLU7mG3IJnL9x3aQXi4xHoHYEUPlQDP/9iz
         k0pBtKzMvK0UU8Ro1aULcBdabREJfILtEicR53zm1iskIB2PXbdPPP7b07eb3l5yaox5
         nMjmyF8VyHLkD/MuAXEki/A6rsFs+kgU4pc6OuWMZtDiRt85BgArGwI8zIQnz14J+omf
         VAvvyxdGvTXLYptoKNKwiqFLpq9nhxTSk3HGevZEiS3v97YgYRp7Phd+4jeYDQyoF+Qg
         iMpZ0PohJ+5oOiKnB6ICIkz88vH9vSG29298KOgLmUgRbuTxxXJRC2Jz09Urz0CCW7QG
         +khg==
X-Forwarded-Encrypted: i=1; AJvYcCXDeRa76e3qJVItiSCRfKNCKS0PTKv7qvygiHkqt6gph4ze2EiML5/Y9UOpWzrjtgbx/+Sm0DxaZNDlygd7@vger.kernel.org
X-Gm-Message-State: AOJu0Yx98dk7lO8H41evJTXsiGapXHz+OyyQD8hmIM8fzlpresvaJ3I8
	H3qKrRMd3xHO94eK5uTB77VmYyxvzwar311MisdL0Fhvz2vC+GMBGgTg
X-Gm-Gg: ATEYQzxNwlnagT1NxSM8bBef/redGem9K7iMXoD88fvI7qjR+RdbCx+cqrkeJd++rEq
	SW1r4wWf04DH03EpdLudoq+7eojXVnPTy4U3PUCuYjIcd+tNf+c9R8CnIXfLHvqcIZ0jVhfjZYZ
	N6OX/HNXq5YQFv6/MQO8NxspKFKRu0qTakcK4WI0KrQleoEl94Tsmb4mK54ZEYhSil0QO+d9WkD
	S05yNyxRW5uP7q2TJ2gv6jWiSRGXQWgqM3OleF2isxPahDb3wJ8QHWB9ctR2U4LKhqlvddvmv03
	r9kwuQer5q7VuObrLeDs0w9tComHsDmKAtXCCkgke7dQhbfL9QwC4u8PxeiN8yDHs45R/U9xkrR
	4fTYDND9KbVejqxrVbTXw6q9ysKNQBYlKZ4QK19Eh5BxllWMMVcdjaZugTFFx0Q1NR5uK3mlhcG
	/d2vsKCP14m3odjuMwMg==
X-Received: by 2002:a17:90b:2883:b0:359:7d76:5ead with SMTP id 98e67ed59e1d1-359be21a363mr264407a91.3.1772757195912;
        Thu, 05 Mar 2026 16:33:15 -0800 (PST)
Received: from localhost ([2a03:2880:ff:72::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359b2d56347sm3472198a91.9.2026.03.05.16.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 16:33:15 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: axboe@kernel.dk
Cc: hch@infradead.org,
	asml.silence@gmail.com,
	bernd@bsbernd.com,
	csander@purestorage.com,
	krisman@suse.de,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: [PATCH v3 5/8] io_uring/kbuf: add recycling for kernel managed buffer rings
Date: Thu,  5 Mar 2026 16:32:21 -0800
Message-ID: <20260306003224.3620942-6-joannelkoong@gmail.com>
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
X-Rspamd-Queue-Id: E925C219D9D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-79555-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add an interface for buffers to be recycled back into a kernel-managed
buffer ring.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/io_uring/cmd.h | 11 +++++++++
 io_uring/kbuf.c              | 48 ++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index 505a5b13e57c..dabe0cd3fe38 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -95,6 +95,10 @@ int io_uring_buf_ring_pin(struct io_uring_cmd *cmd, unsigned buf_group,
 			  unsigned issue_flags, struct io_buffer_list **out_bl);
 int io_uring_buf_ring_unpin(struct io_uring_cmd *cmd, unsigned buf_group,
 			    unsigned issue_flags);
+
+int io_uring_kmbuf_recycle(struct io_uring_cmd *cmd, unsigned int buf_group,
+			   u64 addr, unsigned int len, unsigned int bid,
+			   unsigned int issue_flags);
 #else
 static inline int
 io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
@@ -150,6 +154,13 @@ static inline int io_uring_buf_ring_unpin(struct io_uring_cmd *cmd,
 {
 	return -EOPNOTSUPP;
 }
+static inline int io_uring_kmbuf_recycle(struct io_uring_cmd *cmd,
+					 unsigned int buf_group, u64 addr,
+					 unsigned int len, unsigned int bid,
+					 unsigned int issue_flags)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 static inline struct io_uring_cmd *io_uring_cmd_from_tw(struct io_tw_req tw_req)
diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index 9a681241c8b3..1497326694d0 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -102,6 +102,54 @@ void io_kbuf_drop_legacy(struct io_kiocb *req)
 	req->kbuf = NULL;
 }
 
+int io_uring_kmbuf_recycle(struct io_uring_cmd *cmd, unsigned int buf_group,
+			   u64 addr, unsigned int len, unsigned int bid,
+			   unsigned int issue_flags)
+{
+	struct io_kiocb *req = cmd_to_io_kiocb(cmd);
+	struct io_ring_ctx *ctx = req->ctx;
+	struct io_uring_buf_ring *br;
+	struct io_uring_buf *buf;
+	struct io_buffer_list *bl;
+	unsigned int required_flags;
+	int ret = -EINVAL;
+
+	if (WARN_ON_ONCE(req->flags & REQ_F_BUFFERS_COMMIT))
+		return ret;
+
+	io_ring_submit_lock(ctx, issue_flags);
+
+	bl = io_buffer_get_list(ctx, buf_group);
+
+	if (!bl)
+		goto err;
+
+	required_flags = IOBL_BUF_RING | IOBL_KERNEL_MANAGED;
+	if (WARN_ON_ONCE((bl->flags & required_flags) != required_flags))
+		goto err;
+
+	br = bl->buf_ring;
+
+	if (WARN_ON_ONCE((__u16)(br->tail - bl->head) >= bl->nr_entries))
+		goto err;
+
+	buf = &br->bufs[(br->tail) & bl->mask];
+
+	buf->addr = addr;
+	buf->len = len;
+	buf->bid = bid;
+
+	req->flags &= ~REQ_F_BUFFER_RING;
+
+	br->tail++;
+	ret = 0;
+
+err:
+	io_ring_submit_unlock(ctx, issue_flags);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(io_uring_kmbuf_recycle);
+
 bool io_kbuf_recycle_legacy(struct io_kiocb *req, unsigned issue_flags)
 {
 	struct io_ring_ctx *ctx = req->ctx;
-- 
2.47.3


