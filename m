Return-Path: <linux-fsdevel+bounces-71893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C81FCD780C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 01:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0E2A303213C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 00:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4475F1F5842;
	Tue, 23 Dec 2025 00:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOE02wlY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1CE205E3B
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 00:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766450196; cv=none; b=Ru8mTD5Y+eLvpwMC0eHjrz98K4XegiNDb9eCvqmYqOndGciCmCd9MZmaJiHzg9FJepzUu4DekEXmXGabyiNUAVVEVfPsyPn46mmLX78+2pKMT1eYAEj9xwG+l3Az9id9Zpjk7S7SnJGbwRU5QrDK6xswuhKdvsta+qAeHWtXVq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766450196; c=relaxed/simple;
	bh=AGXy415mglRhicrXFs4D990sYRrSFJ4XFWWVaF9HToY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q+SPmo/RAn59tcJau+gQsxT+RM8gFOkZk4upMG2s4O7pb+yRqXRrgKxLdQ7HDqMq/s7nu/WYVlv2EeZSFr9hUNCUvXxO7Zs89hiibHHo8hUSYSGw9qetvDY4yy6Ka/ODY0kGV0BJ1Db2z5DamSYb1Qu26S+jVlN+2WVbMqzVH74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOE02wlY; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-803474aaa8bso909308b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 16:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766450193; x=1767054993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJPtGsBDIN/oNHzNofS3ETHdQP92YfTTdzZt1yyrgZ0=;
        b=iOE02wlY/f80BFyhRFcJ7V0QPfz49LXY8Sd8HCg/C0aFeRF5S2On7EpWhcFpcRCEJQ
         b2e/jg87w29TK/ZO2Ecmbmtx4cMhIO8a4J+QTj0uMcRdQapXcrSDKWenL1gT+x7BCREi
         3aKkkfthT9XXkjqbFy2vw1/3KKV0as8tuj21ckDAyVt01+QhjOCDlFHlPamGPLWJUmH8
         OC4jVaI0PSg9XPhTTHIElcCqmCIFaH3o/ro0k1A/3Nv6Lspc7K2MPoiOjTVsDR1NjjKf
         5GSpJnJQRlqe4V7epK6qA+4kCHSfPiZZbk8igt8uUzpjxiJNJxCyyT6DFhScHcympQCK
         hioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766450193; x=1767054993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zJPtGsBDIN/oNHzNofS3ETHdQP92YfTTdzZt1yyrgZ0=;
        b=e4v11Ikk8+UabZjndbNVPQZ9s4PvsefX1Nwt1JERo9dhMGaPr7tWcVrZob+8ZaIyIg
         D3auZLaKiqu5bwneLwJ/poR9sm62Ty1gNM11GqDVvGL47f3Aarc47gw16vZhIM3FXgpe
         8TdSq7jTsJKD51mUU27l+gcMuUI012Ifs4Kp7W4OzIySiD/mGJrhk2/gBEdSFlbhBZRC
         1T2yVXVHStoI18kssTFUI//iZSebhvnTaeUTPIdq9fjv3ns7utdU51htPnd9iNrnKtX2
         qJ6rlGPknX3RJoeTIGb9TcVtypdxbelILQzpBTJFUfUzsSLsjqAunWSV/+EKLELncdow
         G2bg==
X-Forwarded-Encrypted: i=1; AJvYcCW1xeO2EtMq2ZF1ihYa2HQCCnj92Y9OKDRKxwVhnQPi4acj3nJEPDQWeoeuLPqa6aOMSH/v+lts2eNf/NKi@vger.kernel.org
X-Gm-Message-State: AOJu0YysDEHC8QDMjmzpf/ZAZtim1UU2uWag680BDdwHgYXhPJHotJFo
	j72sno3FkBPDKZCvIiy0LhHZIR96/2P4faz2OxLx0Xq1WRuYYJNs19Gt
X-Gm-Gg: AY/fxX5/SjiBWutxqw5lNwCtdG6NTae6ANCEtj8t46hrVpePeof6vILsqRr5Y8QaJcU
	SLN3Shlnv4yRMjIRqp9+3bD/xnF44gmuRw596ICmfFm1RoLs1MkYo4NlXQeciwa2BwWLbH7NNeo
	mWyhEAn7O4eH0O+EuTzzxcEAI8DCxNBnlxfHBx4XO5qNkgCbcYY1WCRfI4BrVOi2323+saqlnh/
	K7bmy40ajtZ3UeBQ4+e8QIOeO58blASgVrqaZeKcfGXTpISDqK/QltMDl39rE9R5x6zbcxtUu0W
	Rh3AQUccZDyOjxOZFEJwckq5XO0bRP4SLcvwOh9QyJ3dS7VwfLh9KS/fvdZ8M+NLPK4OVJcHdhR
	6OPnUft5pZCfktwGSFwyetZUVFtNEuLGNFAluZIACpz2HEyKS6Ty8Mbc1a01cwSwnEY80xFc5Ta
	GjtbGyPGxvS9EHZhVuYA==
X-Google-Smtp-Source: AGHT+IFSWF/+pZwJ8Or78PAT5/Ws9/B3l4ukDuEE2AokJzuO+eJCnLy7bAvuSvhWAfCLDbzfxiH+dw==
X-Received: by 2002:a05:6a00:3bca:b0:783:44b9:cbc9 with SMTP id d2e1a72fcca58-7fe0bd134d0mr11762174b3a.9.1766450193224;
        Mon, 22 Dec 2025 16:36:33 -0800 (PST)
Received: from localhost ([2a03:2880:ff:5f::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e0a0595sm11554677b3a.44.2025.12.22.16.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 16:36:32 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	csander@purestorage.com,
	xiaobing.li@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 05/25] io_uring/kbuf: support kernel-managed buffer rings in buffer selection
Date: Mon, 22 Dec 2025 16:35:02 -0800
Message-ID: <20251223003522.3055912-6-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251223003522.3055912-1-joannelkoong@gmail.com>
References: <20251223003522.3055912-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow kernel-managed buffers to be selected. This requires modifying the
io_br_sel struct to separate the fields for address and val, since a
kernel address cannot be distinguished from a negative val when error
checking.

Auto-commit any selected kernel-managed buffer.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/io_uring_types.h |  8 ++++----
 io_uring/kbuf.c                | 15 ++++++++++++---
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index e1adb0d20a0a..36fac08db636 100644
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
index 68469efe5552..8f63924bc9f7 100644
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
@@ -201,8 +206,12 @@ static struct io_br_sel io_ring_buffer_select(struct io_kiocb *req, size_t *len,
 	req->buf_index = READ_ONCE(buf->bid);
 	sel.buf_list = bl;
 	sel.addr = u64_to_user_ptr(READ_ONCE(buf->addr));
+	if (bl->flags & IOBL_KERNEL_MANAGED)
+		sel.kaddr = (void *)(uintptr_t)buf->addr;
+	else
+		sel.addr = u64_to_user_ptr(READ_ONCE(buf->addr));
 
-	if (io_should_commit(req, issue_flags)) {
+	if (io_should_commit(req, bl, issue_flags)) {
 		io_kbuf_commit(req, sel.buf_list, *len, 1);
 		sel.buf_list = NULL;
 	}
-- 
2.47.3


