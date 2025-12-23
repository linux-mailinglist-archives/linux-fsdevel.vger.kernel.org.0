Return-Path: <linux-fsdevel+bounces-71900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F91ECD7845
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 01:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 393133047676
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 00:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0901F3BA4;
	Tue, 23 Dec 2025 00:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekw/VbLk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA73C2B9A4
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 00:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766450207; cv=none; b=UlN9Q8uhzdL/U6Usj5GHsmMHwkulUQdEZlygxpFfrMhp1GSvFdoGPJRKGWPxkHhujA4rpy3XL3mkinQi5jbVUNbl+H5/J3OCuB9dmGlXb/wXmrXT6hoaGMwZREkkKwMYpCxMozFEvV0azAcmIQXG0XHQXlIb2+681bdW3fT4Vv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766450207; c=relaxed/simple;
	bh=aKLejG38uvIOlTozL6KpMQyVF5B+JfW8946A+LiVe7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XXtPZ2EdZ/o3DIOJUh0Lf0ExiqWr5TOMqE0PbskrVPHtUVj69sRai4F3FgzAjI3CBARWGL9JrTyz1iWatxqGQoF8eBy9hCkMegwNgs0iP48xY/hWA+NEX2MTQO+/CFe3e9FiEapLfrMDrGnEdXGtWe0SnQpm4+J4il8yZlfC/tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekw/VbLk; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34ab8e0df53so4325067a91.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 16:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766450205; x=1767055005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kh5ZVXmsBZcQ3OrKebkx1eIN+Pz6xPHYh4mwcIs+LIA=;
        b=ekw/VbLkD4wiZ09sFp/fb6uF5lI3c024eYpyefEzw81rW1KwuwuSxFaa82oe+giJ5T
         vsfXHBT3oNeGgYcGei9sP/MjO7vdTvcbb8f9G49XIxc4UyctSGn/KCl4Emi2spEEodEi
         6EXcajhCH2bJ8yNnqsBYW/ZbQyD+uh7CRNY8uNIxHDuPIjqseuE/Ei2bOcstWLcsIO/k
         nOmDcY3pUmgN0BBzkZa8WjEMnrmk8cVr05CIMo7pgmrFycI8fUcIdg6UMwV31M6F8CRj
         UlUJLPSdVSEPDh4ydHhKeGluFOsZSQthVrBZp7wl4pPhRqEwvkKgkdBBQKu8EQPc8JoQ
         QDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766450205; x=1767055005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kh5ZVXmsBZcQ3OrKebkx1eIN+Pz6xPHYh4mwcIs+LIA=;
        b=eU1BTq+aVcDLlDxlT9j6+JEqP1MFQpKnrAJ7wxnq/4n6hBPrroWza7RjApd0gxzfJu
         FN4iaJOQaJ8ardFnwhWatmYYhC7b/zKm71bBxZ1+uaM1gmaxGLendRdFaQWHjoKpziwk
         FKn826MTn5W1gWgQdxrEa8ZY7xSKuDXitBz7LRZdTDxMuvM3Vpnd1/ttdivyrOVu6iOy
         QAXpp8tl3ap93WQC2KA4qN7/n4qIeAu1MJjj41lUld/3FCrHNzHbhp4dDlG8CN5IAkMB
         6EayjHi2mPTMGVHPjK8tdJHqGSxFoFvMlH6ndVbd8Bysr8GQuz6GD+56vDt8AnkoDvhQ
         fq6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVp/kFj9KQNSVNhEo617HGks1Wl7AM/OquNQTX1PqlhQfZepQqVqV7W/7zJeAYztwhj41JwlvBYJzSRwfBo@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8qAbmnHx+JFINpzXOMRvkJ4UHv1m+IipbwG9+61T3gqzt1EIe
	v0HZpUCfZyoyMz0PeGUMchARQt96HjTrzoqNqVZn16CP88UGrSIwG9N/
X-Gm-Gg: AY/fxX58gnc2wO9Agx74u+TGXEqlz5bmhlR9T5AAFWQHKoYo5OS3UXtZ/XA/XdjN07k
	e4aUY2ZX/M8cna23n/AJ/ivUBUFD9FVMsElPGcgwGL6G5atwEXN3jpi64gInFmTYYVQd63KPibu
	U9lV/rNJ1kM8qW1vp2a70Pp7Ob3Gwtl3h6wVTxuDyarlvIKRs5qjX7cbODehu62V8DOru440kS/
	TsLuSZKaQhsJ1vmuCXedQPuIINFlhsAw5Lfw1/rhRijRbjH7k9rBH9XnUS7EOVN/TY/RCowN0+v
	cbJScqSRIREUPBfBt+DrKMg9zdouTvdBx90LmwPv53Cs+P4MhRWQY2sfuFO9AcsM27DmxLpS6Ex
	nYURYV6lQIr7hK+H08tjNIyWGhVl6LQSnyUqBMpXp4i+meoLABxB16Z1BTLxX5LuiN6uJDa+Ni3
	ofxX9WrsmiTkcWxXqJbg==
X-Google-Smtp-Source: AGHT+IHQmJ/iYFMQ1CONToiMLDUQ2ZEpyegdZpTA+eDDXrBPi1fE6+xkXGGpdKmj0U7uxNsGP+aRNg==
X-Received: by 2002:a17:90b:3c83:b0:339:d03e:2a11 with SMTP id 98e67ed59e1d1-34e9214931dmr10605718a91.14.1766450205178;
        Mon, 22 Dec 2025 16:36:45 -0800 (PST)
Received: from localhost ([2a03:2880:ff:40::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e79a164d0sm10248466a12.10.2025.12.22.16.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 16:36:44 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	csander@purestorage.com,
	xiaobing.li@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 12/25] io_uring/cmd: set selected buffer index in __io_uring_cmd_done()
Date: Mon, 22 Dec 2025 16:35:09 -0800
Message-ID: <20251223003522.3055912-13-joannelkoong@gmail.com>
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
index 4534710252da..c78a06845cbc 100644
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


