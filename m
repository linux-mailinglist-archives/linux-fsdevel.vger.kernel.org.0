Return-Path: <linux-fsdevel+bounces-76774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OW5Jbp8imk4LAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 01:32:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37881115A48
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 01:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBF4A303AB67
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 00:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DB223AB98;
	Tue, 10 Feb 2026 00:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilqoJwRW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BA81A9F8D
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 00:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770683508; cv=none; b=hGn3LKO10PhUKV3R60vCdK64wmstYpkWC0AZisXwUiEeSrrzqHBNLk6ar3v0BSTJcAg6Bno5PqQ8cPscuoCQD0ktaV5jSF9yC9pTUQbvfET4baSi4hD6z6oYcu1PWKhIvpHiFKIvPPvHxj3iSKXh2wBNCaZal/LhnS/k2mG330Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770683508; c=relaxed/simple;
	bh=ko5qf49NJZyN8n0RgrlQ5koyiabGsEE2+6GI5bai0yY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DWNp6pXS3zfdZocrvB5nK4wWwetWcWgJCHEw/u2kqK70bo137EMmqrP0NTYK3wqkb04CPcjEbXNkr1vqL8npcj1VdZCpmU6opzBj7DTTBHIglbHpcwvzqT9HPiq1+JXya018jhvHJSwwJ01sj6kEN7V1Y2U+wIHJM69pzS3GKVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilqoJwRW; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a79998d35aso36555835ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Feb 2026 16:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770683507; x=1771288307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQDLZqXE3BcVNZzVpuMd9hJ4u9LazHZ6EFv0AmYNj5k=;
        b=ilqoJwRW/AJWSf56nl8y3LY1OBsJfh5ExQlyyrgNE03AOfl5AYytLboak8emsLJG9g
         35MW+foeyjlA8NoXl8zdoiEL4+/7qU5lnSuU9YE3C1LpQzmHnJ0Mst6hVPJf05EkRjk3
         +9DIUu775RpqYeI8ojJBHTdnFmX0TdEKO9LzR0aMYC7qKewkzLF/lVBJwHVd2od6dIgY
         F7q+lNWhS0zd45NqmXh4DcQTmvIshs/zl6PhojmaiF7v5AhderG66P4E9F7gttI/qiLM
         P4AwyfqaYjvb22+QEGGLcH9HUvRNQcmxhJq5G8M1O4k3PsNcuOqROvZuDgWymq+NVmC6
         Kppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770683507; x=1771288307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oQDLZqXE3BcVNZzVpuMd9hJ4u9LazHZ6EFv0AmYNj5k=;
        b=v5dEojE4CI1bufj/XDXWAIh/pu6dblaqSyrADrIm34V1N8CQ6mWFW3IkE9V5sKhY/S
         1/QhbrKcVwArfsPvtRGzeDfzoUOwGN/Bf2l+UVokR0Hv5GltrMwJbnlD6wz07DrN4Rgh
         FB4Fg1VS20+kz7H3Vq7Rp90His0Jb0pAzMyIiS2QPrJH34DgGHrijqxXb2peSHux3AgC
         OGX7NJC4VmtQBcvlaLqs8gnIu24wv8kh75P668FJOFU2HLb9xRtQ3VwKZJAgKBrmCWcN
         FCtryXxFyYybbFYoVSNEIHQH84x3QBmm2CcNM3cSyM6A8Ihh8YqmCpCuEyGDvsAMlMnD
         lQWg==
X-Forwarded-Encrypted: i=1; AJvYcCVfBaJSVPG2/HE/zEcml8UvFHHU+pyaDL5OwneTkNknKtPzGjGtrF86ITjzBFE7Q3qBAKoRIQ3SViEAzL0v@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5ysFkfgcHSlq3/Ni0Dzfi9szFZN+4oaqa/ITNkaECjP6s+MLH
	Wyu4QXeoxs0nnw1toAH2k51sKFG75TacTa16H1i04mBIb7XUgR09MWvT
X-Gm-Gg: AZuq6aKzFTNzllF/V27yLnXnXnjRKyP5IsS7eFG6jkVuZkPyRQOjX12Us7Dsm6BrKai
	rK0RSjFrhSRAkV0Z0/KiYtpmInDXC2nRqe1bGntdkn9eCJiyE2m0jxy53HjLN6sJIRFlBTP1VM7
	dMe1RAIlKsXu2P8qeIV1a3X8krLW0Ei2lHAOcimoJ7FZGKuaey0uPgXWTpzlchMIlzan+EQ4Vo9
	ixMtFog6ClEb0Lpr2AfnVXVDcahcJFRp5LE9s0VsOTsQOwzxDkzU1BLy2Y8cptXDxWuLiTVw+2F
	bt3pJKl9RFBgOJ5wSVXbx33LjAAuo7nkDc+Xyt4XBgHttnNfm1MnoHfflxnLCGS8neb/Kdt1Dd3
	VGXGOX7dLVPtsYr9o9aSo6YPI6SYZ8WhRb3xkxuqzUmYH99vxMmCogIoAGMuweosIACaXUgbknb
	OZzJS/N82A82sX9GrbJQ==
X-Received: by 2002:a17:903:2a8c:b0:2a9:327f:aa2f with SMTP id d9443c01a7336-2a952166b89mr147756635ad.26.1770683507006;
        Mon, 09 Feb 2026 16:31:47 -0800 (PST)
Received: from localhost ([2a03:2880:ff:53::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a9cb100965sm84878985ad.78.2026.02.09.16.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 16:31:46 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: axboe@kernel.dk,
	io-uring@vger.kernel.org
Cc: csander@purestorage.com,
	krisman@suse.de,
	bernd@bsbernd.com,
	hch@infradead.org,
	asml.silence@gmail.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 05/11] io_uring/kbuf: support kernel-managed buffer rings in buffer selection
Date: Mon,  9 Feb 2026 16:28:46 -0800
Message-ID: <20260210002852.1394504-6-joannelkoong@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-76774-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 37881115A48
X-Rspamd-Action: no action

Allow kernel-managed buffers to be selected. This requires modifying the
io_br_sel struct to separate the fields for address and val, since a
kernel address cannot be distinguished from a negative val when error
checking.

Auto-commit any selected kernel-managed buffer.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/io_uring_types.h |  8 ++++----
 io_uring/kbuf.c                | 16 ++++++++++++----
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index 3e4a82a6f817..36cc2e0346d9 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -93,13 +93,13 @@ struct io_mapped_region {
  */
 struct io_br_sel {
 	struct io_buffer_list *buf_list;
-	/*
-	 * Some selection parts return the user address, others return an error.
-	 */
 	union {
+		/* for classic/ring provided buffers */
 		void __user *addr;
-		ssize_t val;
+		/* for kernel-managed buffers */
+		void *kaddr;
 	};
+	ssize_t val;
 };
 
 
diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index ccf5b213087b..1e8395270227 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -155,7 +155,8 @@ static int io_provided_buffers_select(struct io_kiocb *req, size_t *len,
 	return 1;
 }
 
-static bool io_should_commit(struct io_kiocb *req, unsigned int issue_flags)
+static bool io_should_commit(struct io_kiocb *req, struct io_buffer_list *bl,
+			     unsigned int issue_flags)
 {
 	/*
 	* If we came in unlocked, we have no choice but to consume the
@@ -170,7 +171,11 @@ static bool io_should_commit(struct io_kiocb *req, unsigned int issue_flags)
 	if (issue_flags & IO_URING_F_UNLOCKED)
 		return true;
 
-	/* uring_cmd commits kbuf upfront, no need to auto-commit */
+	/* kernel-managed buffers are auto-committed */
+	if (bl->flags & IOBL_KERNEL_MANAGED)
+		return true;
+
+	/* multishot uring_cmd commits kbuf upfront, no need to auto-commit */
 	if (!io_file_can_poll(req) && req->opcode != IORING_OP_URING_CMD)
 		return true;
 	return false;
@@ -200,9 +205,12 @@ static struct io_br_sel io_ring_buffer_select(struct io_kiocb *req, size_t *len,
 	req->flags |= REQ_F_BUFFER_RING | REQ_F_BUFFERS_COMMIT;
 	req->buf_index = READ_ONCE(buf->bid);
 	sel.buf_list = bl;
-	sel.addr = u64_to_user_ptr(READ_ONCE(buf->addr));
+	if (bl->flags & IOBL_KERNEL_MANAGED)
+		sel.kaddr = (void *)(uintptr_t)READ_ONCE(buf->addr);
+	else
+		sel.addr = u64_to_user_ptr(READ_ONCE(buf->addr));
 
-	if (io_should_commit(req, issue_flags)) {
+	if (io_should_commit(req, bl, issue_flags)) {
 		io_kbuf_commit(req, sel.buf_list, *len, 1);
 		sel.buf_list = NULL;
 	}
-- 
2.47.3


