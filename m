Return-Path: <linux-fsdevel+bounces-70507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E7EC9D6B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 01:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C2DB634AEE5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 00:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A7024679F;
	Wed,  3 Dec 2025 00:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zp1u9c5Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278A42459E5
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 00:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764722213; cv=none; b=ckhqKSZQc0fq6RgKGVMRmKdjM+SgJnrF2uYjJvWtjMi+WsJj6F4S43JpiP4jxD+roc9uvpyglx8JSA/Uuvr5w2686DkF6KtOK+ADfQpjhR0N80Tt8lOqtrFroaKhNB96wqitgdWlMmjXgGyhjimKr+n9cjo/UM6cU+cx3iYK1ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764722213; c=relaxed/simple;
	bh=Gq4EohnDLiLhvA13waj017tjnt9miiS8JKFxzcQ91nM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NR8kr2ee4ui6WyIa36NntdaftqfIL8k5IG7n1p7sHLvEIzNS4GxDXoE+oxYeBgZdW045iJoOGI5AeeJPGYpRi84XabAyobMgHPXCqtCDfeJ5n1cWDheAr6NUzqiv1PFkXxA0W1gsLal6UIi2VfZBG1z9ULMHcG4yZYPUHJ1G1Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zp1u9c5Y; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-298144fb9bcso60110855ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 16:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764722211; x=1765327011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ovLoIp8wIOYRxKmLkTi+d+xL6weQO8L4UyvbcbaHcs=;
        b=Zp1u9c5YwLvY4kdSw1Y7bh0OcyOSIsdW56/xLYx0X3HVGUFvO3Uo7fGY3eYtS37iol
         MuvY2nS/gMSx8ksAR/xLoTTU33jbqsKb4ybXqs3u3vr1Tq55Sm4Iw7fXHFvls6H3hTX6
         c1MKjLOrjsWdNhKe4D3oEOe8eBj6m3wjf5RXO4WeAWCydFgCpzooYJbzaJPPgKtpufeo
         4LchgIJ/TJR9gYu4kVrScGvvQnkJB8uKlSZusrxs4sw4t+GJW4TvpWzG2KZDidLg+c4Y
         DCv6XwNIK4567RY7+sV6TDrVVeUW7yw7/vLOFfqRCwFs+WFs+ASq1A4DLGbYYgDCbPIW
         H+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764722211; x=1765327011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0ovLoIp8wIOYRxKmLkTi+d+xL6weQO8L4UyvbcbaHcs=;
        b=MfZv5XPjyiZAG1aYeJgdqWtOY/eLXOhEdBoPqOyX1PDS/CGxbLnH+7n7BEUQOVjZGu
         ZDJ9K8/qhRPVdduqSEj6vqu9J121NpWh3hct3zB4xSpAxcrLjH32LHvh5xOOYwnnX8NM
         whVHga/ry0NaF4Xsm/GD8qp/ssNDS/tH8vXwffR3X4b+uRC1XRKzRxUYSMVgNNY25VKT
         8YCX0ZSjWn8JP5Ttimv8irT70J0j7Ww1PxofQ1XbmrJmuwLd2Whoup5yf2JuH8xSuhxU
         nP9k+TtJwTx4byUHBtdUJVStdo/LWL6CyXJ26ov7XFJlktyv6YpQqzu4IGw8g7HXru4y
         ly9w==
X-Forwarded-Encrypted: i=1; AJvYcCXHVVunc7K+0R5rZVtltz2yq0R7WRSuBdyjVnqlRDsA/GzyZri4HA0tr+9vK/XPOo4zVp7gPZ3IJk8t2EOc@vger.kernel.org
X-Gm-Message-State: AOJu0YxeBo1gUY6T8loVmzF8NXuRiN925wgc6+RioyeKfYlVfgQcL2iX
	jQI6frLLeTaCcvNud+QTNwlt1TBYFgp+8upVGx143HhzLXbiHmwFmytL
X-Gm-Gg: ASbGncvcMsKO/OiDYMB7Gsy97WbW9ZJHEKEz8ELRAa2ALZzhKMeDxVbgJy8UovalbrA
	VHQYYBjCrMtHVwgJfcibKKcxXii9jwzeMQE7dhtrQ+PVKKj7mtT6kpYOPFedReBOzft6Etrv5HY
	q+FZqXa7Cv85VRAkIMDtzDrwg3DJQ8N5jsGXysu90ZlJ591uT71mQ/aOF3+hWuiudQZeQqIR4bH
	qZdRwvJKc0bRU223TRj9HO/6E6k9pQhwAFCgyYjNZQX7Vu3eHKQlfPza8UMoxIBRn3C/F6RmkFX
	ZdpQ+oiSg3SspSjRlKag9sp0bDa6NtZU3pRnH8woqlCXz3FMzok+40H7hbSja3rcvBdhMtWk/5H
	nO2sz3h/9d5t1qcJa8ah08AWMKUfdmpwvNSYXRzR7YnSRXhXGeQeAXtK0ivbELteAFndOylZeoH
	kZ2/FjsP2hLezUMP5z9YFP5Ju644QM
X-Google-Smtp-Source: AGHT+IFfpQ3v4X7ooNfi/KRmj0N8M/KPvXG8PZVQg3QsGuOBdO1S8PqU7PdH79SLSdr56335gB+ZFQ==
X-Received: by 2002:a17:903:1b6f:b0:294:fcae:826 with SMTP id d9443c01a7336-29d684844bbmr4820335ad.59.1764722211461;
        Tue, 02 Dec 2025 16:36:51 -0800 (PST)
Received: from localhost ([2a03:2880:ff:72::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb27804sm166724115ad.54.2025.12.02.16.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 16:36:51 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	csander@purestorage.com,
	xiaobing.li@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 13/30] io_uring/cmd: set selected buffer index in __io_uring_cmd_done()
Date: Tue,  2 Dec 2025 16:35:08 -0800
Message-ID: <20251203003526.2889477-14-joannelkoong@gmail.com>
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

When uring_cmd operations select a buffer, the completion queue entry
should indicate which buffer was selected.

Set IORING_CQE_F_BUFFER on the completed entry and encode the buffer
index if a buffer was selected.

This will be needed for fuse, which needs to relay to userspace which
selected buffer contains the data.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 io_uring/uring_cmd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index e077eba00efe..3eb10bbba177 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -142,6 +142,7 @@ void __io_uring_cmd_done(struct io_uring_cmd *ioucmd, s32 ret, u64 res2,
 		       unsigned issue_flags, bool is_cqe32)
 {
 	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
+	u32 cflags = 0;
 
 	if (WARN_ON_ONCE(req->flags & REQ_F_APOLL_MULTISHOT))
 		return;
@@ -151,7 +152,10 @@ void __io_uring_cmd_done(struct io_uring_cmd *ioucmd, s32 ret, u64 res2,
 	if (ret < 0)
 		req_set_fail(req);
 
-	io_req_set_res(req, ret, 0);
+	if (req->flags & (REQ_F_BUFFER_SELECTED | REQ_F_BUFFER_RING))
+		cflags |= IORING_CQE_F_BUFFER |
+			(req->buf_index << IORING_CQE_BUFFER_SHIFT);
+	io_req_set_res(req, ret, cflags);
 	if (is_cqe32) {
 		if (req->ctx->flags & IORING_SETUP_CQE_MIXED)
 			req->cqe.flags |= IORING_CQE_F_32;
-- 
2.47.3


