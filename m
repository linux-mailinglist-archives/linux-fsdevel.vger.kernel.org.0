Return-Path: <linux-fsdevel+bounces-70499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD1AC9D682
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 01:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 68DBA4E4065
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 00:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201C8221DB5;
	Wed,  3 Dec 2025 00:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSlyreMM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7A6221271
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 00:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764722198; cv=none; b=g924Y9fsmLb31NkGjjR/lqVPvTZfUfqKfU34RlEnj82PyyV32+BkeGQhPgJvv8lC79RIH4WyA783KzjR3Pu/f6xjNxli82O41dxw00+b4DrJiN8jfnwHsv+fZrBH4cM5SM6vIl4kQ8ieC7diO3DHnU4yvC7uuAhoRC9WH360QI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764722198; c=relaxed/simple;
	bh=95J19zdA0gFR5TQ9JtO/onNl+Rpz2nyDeix6qIuVJpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X3fH8aJ7Lt9j4FHj2EH94j7m4wuHWE29JTR56UypVvSbthp/sbkQtS0EVnflftaXIDQodkydWi3Ya29Nubqy1/GQHay21CxSrQ6F+8k3RSCp1ZNw6jDOc0KGVQvyPNgyFFwFaTrjRY6maMe/1FVk8ae1O7jUEgSgCZukCGeJmKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSlyreMM; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-297d4a56f97so88714395ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 16:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764722196; x=1765326996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/LVHiRdfY144qEpuet9OcoP6m8LjFCEGntwPIjqRxY=;
        b=mSlyreMMWcf3Xlrsz5GBukX29icKW8/kFV/UeFtx7uASjbjE0lKohB+oMisnUD11be
         iAc66Ig6bRF47XYg7cq6YcuceYGS9iDQ0LLkqOLVD3Pn4wkCu/jxbjK4rY3E2Cgtc5dI
         djzxnPWP4iGCcFSkQ5TOdQXBlb6Xj+FiL1yiRBJCRmlehC1KyIzjHDuMxBGXo/NUC9FF
         xe7eKHhTjhV2xOD5/HVZdtZfxkPhn80c/SQyesx1LSSwFoWxlDY2pW+bXpTVyUveVGmK
         OHbHuKs6yQ+8iLPmBcx1GdTmwdxD6dBUii2AY+CfoetRiQ11ekDpFe5TplnV91F0QyHz
         FsUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764722196; x=1765326996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J/LVHiRdfY144qEpuet9OcoP6m8LjFCEGntwPIjqRxY=;
        b=FXWAT98qjxIN1sScCPAoC8ti8Nogr1q4SoiglegUjU5X3P8Aceu7TbOKLwjOLDIWK1
         x4FCC/yMI5ceG9qsvTq7y0EcOGSlP4Wwu88IzG+/xyTDbwJgkDblICBF4sxDyzQZM+UV
         NihwhKaTSv/e7nOeagDB3ua6TWWPy3UD8XpSUcO/Ay0pOXOuPOjtdjPHM30nt5iIT9zd
         Nh2/qQpgcalAstIi/l6xybD2tGg0f4FgT36XQA+p+ipyFyMyiLUblGsMA0TMUT/+dYnb
         P60duopXbFQqli2sM70m66opZV9yAAKH+o3XHnZI2+mpRdIvPXVT63A0Y3iJmX5gDDR3
         5FYw==
X-Forwarded-Encrypted: i=1; AJvYcCVkWBCasOk7cO4glLWXYiAHCDYvnEpK8SlmpxsHG4bxmKF3do7kWI96Ehg+CJVHXms0lMhISsZvzzl/L3oQ@vger.kernel.org
X-Gm-Message-State: AOJu0YySSUihTbHxGW8F0xGSzt6Bjh/HmhSNU3edO6ZMcbx/7NUNbQUr
	3+9Zyi+LTO5TwRm1kLWXlnHNpmYoLDHfKC0zHGY8VqH+5jyX0nlb/OEs
X-Gm-Gg: ASbGncu6YIQiYcjEvM4nFmz8o9PZ1kmjpGrt8XgwMmjrjeL0zuxgJxV9XEb2KlHrId1
	Xf2GAXCGsHNHwZyl5nwqWhYVEZNq9VPKWbLoe9ReioXx+jFu3CSf7pFAj3FJWe5U7lkppi0xhpv
	Ujf2Ez8dyvRwYjvQmleg6QRAtyMX4hENcfUmhxU0TTqj74DV0CzJn/F0V07vnRKcETaUQgOjwto
	F/C1PLHLqgC/RuGth6SLiFK1xLkZE0TQfPRa/lfAq5HaIzfIwmHGRXLLjGnjzIiGhLAJzBADSDM
	SgL9hFj6pIX5luacfN/KDgELAHWzb10IeB/aUg/aw5y4aJZPJzf4MwKL/JQwCByRWU1ka7U2GFH
	n9AkDufYsrZNP2FHHdWBipiSmhExLiIUBa/SZvqQPdhEmm2WNvO0psKhqSf5/u1U1GdKz63SdOj
	AFASfCd7G62yV4gxUZ+g==
X-Google-Smtp-Source: AGHT+IE+zujOuCxHYlrac2mQToPfmTEH/033p3LJotHccaXCVNMYsUR3N2EIIFaCxfgWhFH/eiptSQ==
X-Received: by 2002:a17:902:cf4e:b0:295:560a:e474 with SMTP id d9443c01a7336-29d68400fabmr3500845ad.32.1764722196397;
        Tue, 02 Dec 2025 16:36:36 -0800 (PST)
Received: from localhost ([2a03:2880:ff:54::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bce40a5ffsm168764905ad.18.2025.12.02.16.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 16:36:36 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	csander@purestorage.com,
	xiaobing.li@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 05/30] io_uring/kbuf: support kernel-managed buffer rings in buffer selection
Date: Tue,  2 Dec 2025 16:35:00 -0800
Message-ID: <20251203003526.2889477-6-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251203003526.2889477-1-joannelkoong@gmail.com>
References: <20251203003526.2889477-1-joannelkoong@gmail.com>
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
 io_uring/kbuf.c                | 16 ++++++++++++----
 2 files changed, 16 insertions(+), 8 deletions(-)

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
index 619bba43dda3..00ab17a034b5 100644
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
 	req->buf_index = buf->bid;
 	sel.buf_list = bl;
-	sel.addr = u64_to_user_ptr(buf->addr);
+	if (bl->flags & IOBL_KERNEL_MANAGED)
+		sel.kaddr = (void *)buf->addr;
+	else
+		sel.addr = u64_to_user_ptr(buf->addr);
 
-	if (io_should_commit(req, issue_flags)) {
+	if (io_should_commit(req, bl, issue_flags)) {
 		io_kbuf_commit(req, sel.buf_list, *len, 1);
 		sel.buf_list = NULL;
 	}
-- 
2.47.3


