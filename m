Return-Path: <linux-fsdevel+bounces-61104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 126FAB55381
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 17:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 653695C619A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 15:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E5530E0D3;
	Fri, 12 Sep 2025 15:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9g06hcM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8074302767
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 15:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757690887; cv=none; b=RCNJ+4OQUvRfqkWE4BM0BMWFJwapaJl6Lh3lifvq+Fs6AuLczqpGAzvQym7Zxf9Sl2yCRlNGRXmYoH1bzTG4lOS7InQqsrWiWc2yEyNX27ot0CB4cjlv98jXwsuVKDpvpj2nwEF1UxglphZ+ozswQS/C3Sy1hckSIOnQ1p+W/N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757690887; c=relaxed/simple;
	bh=GhbGsRZIFWwACCchhCI1wpT+Z6yk4SfcgM3GpwKm+3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a+vxwy/saElPR8+KUmHJjaNVGPsbaZiAkMXEBol3EEo5+abc5tXuPyOr+umzkstlrKBWoc/13Cmg/f2N0SYErRrVnH3yqHyGWlOhb52m4a17lw/pa+Doln/6d+p8aSHOsEsMlCZ+51uxLD/51sdtHSLXw7j1vrzOlRSKsF2Thi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9g06hcM; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77287fb79d3so1816955b3a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 08:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757690885; x=1758295685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epfohba7lLb94CzZQeNzguTuJKCwE90c2JR8b9B+3/Q=;
        b=U9g06hcMQS1SmAvit1EorYFhcCwBB3xIfBrHCGEfem88UATljbTNLdYoW6DOsBucMO
         1bClKhf9q2dfK7sQOUI9IKhq8BniuG1QuIh9uOumJw4CbR1C3t5mk7yRHaXmuUlTU+jh
         Lqr0QZ5TnjRAS6XgxE1JDl9CT+4AA3aYTX4fCC++vbq4VBuHdTJBh9NdCSDuAKCDEdYQ
         Yt54WcfDVkb9EkphV7gd8VmL4Xl0JN6IhPzlfT3EUEvfqnULG3svwYdAox6nj8xh1XkY
         ZjOInDctYBZ9JsdwD6daO83prFf3XLsmBG3VtTkvs51x1V1/KI1hkPRFvHo56Jk6qpO3
         WKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757690885; x=1758295685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=epfohba7lLb94CzZQeNzguTuJKCwE90c2JR8b9B+3/Q=;
        b=h+leyY7jZIOh7SUtDxCsh+7zS5NAD+oCEnsrQHFelDmDr5yuVVZ7yyPNrt2BZtPhVm
         NkotQKTumJz66zPgQfWtZcJW/qMwjpgRt+Kw/hv4BgOQGbVDMHxu/zyc/O67nCOoRS4D
         9G6BobSVCM3lZlkiXMtlR2O5Licllp8UcWoRpqiC+iSxOGzAM3qNpF7yBFwZNjpOm1is
         AF8ftefow3DeQWORmn8kQsn9GdArVOfkOsirowtWNZqDyu+roiPf1fVpEBfvTWuLIq8z
         BkYUTLTHUUG/sSZfOh6Ap3Vtgs6F+vEtgJZkAp2mkyWqyCigZdx+lAPgeYWN9sG/NHuL
         9Xow==
X-Forwarded-Encrypted: i=1; AJvYcCWtKhKU+UuauuR9YiaJDdxpzfhgx3uuSjxDgdsBzC0nSfjHx9+/KD+xdrXlMBA2YGHBEpA/Emz8FR7taw9a@vger.kernel.org
X-Gm-Message-State: AOJu0YzTPnzBsKiOygmdZtWqcFKngZoe4Ap5U3StqjyuMYnGXbQNkall
	yPjz0LYG8n2UVAbsC7N8ZKsvZbpTvu46LFdGPC5jEUlSWwfNZcPYgIcI
X-Gm-Gg: ASbGnct78sGE5nVfXDQNqlLODUcOv3oqh4oHLl57Kp3tMHKjye+nayGy4ZIrhTstdku
	NrtFZloGnNMJEeMuxe2oKo2btxOR1bHKENC9UV44VjelGGvW7LmTsa3zTn2iksOY50BNGbGIhyd
	6GZih3nfETXwyHchteaXaB3LIgBzOU7i2MJeNZvdhJuRNwSK9FKgxsdV6GEDihgAA9IEOR+pmwR
	OgIgcr/Nqsz+/XnG/Jq8V/uAevMaU+v/+Jq429x2lFcFgnkDzotTn30shYKXARQr8QA3C1uWpzm
	3zNkGyl65LDl4kB8c547djBUuO838803DMe14XCqsAsqUppLf2seXDX4ElQ0yWFCNWUawmCVggX
	D6uX8RzWyNJTcqFVuVlgZsxCfYTe2cYWKxuLl
X-Google-Smtp-Source: AGHT+IGNpJNOsvFiulBAn14rvV+gNw6x7YaxgnaL0p3o0QovIgtsHJ2X+893Wi/o+WL5lAWsrHnGBQ==
X-Received: by 2002:a05:6a21:6d85:b0:245:4181:e1fb with SMTP id adf61e73a8af0-2602aa83d47mr4372165637.27.1757690884773;
        Fri, 12 Sep 2025 08:28:04 -0700 (PDT)
Received: from jicarita ([65.144.169.45])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7760944a9a9sm5436846b3a.78.2025.09.12.08.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:28:04 -0700 (PDT)
From: Thomas Bertschinger <tahbertschinger@gmail.com>
To: io-uring@vger.kernel.org,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	linux-nfs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	cem@kernel.org,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	amir73il@gmail.com
Cc: Thomas Bertschinger <tahbertschinger@gmail.com>
Subject: [PATCH v3 08/10] io_uring: add __io_open_prep() helper
Date: Fri, 12 Sep 2025 09:28:53 -0600
Message-ID: <20250912152855.689917-9-tahbertschinger@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250912152855.689917-1-tahbertschinger@gmail.com>
References: <20250912152855.689917-1-tahbertschinger@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds a helper, __io_open_prep(), which does the part of preparing
for an open that is shared between openat*() and open_by_handle_at().

It excludes reading in the user path or file handle--this will be done
by functions specific to the kind of open().

Signed-off-by: Thomas Bertschinger <tahbertschinger@gmail.com>
---
 io_uring/openclose.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/io_uring/openclose.c b/io_uring/openclose.c
index 884a66e56643..4da2afdb9773 100644
--- a/io_uring/openclose.c
+++ b/io_uring/openclose.c
@@ -58,11 +58,10 @@ static bool io_openat_force_async(struct io_open *open)
 	return open->how.flags & (O_TRUNC | O_CREAT | __O_TMPFILE);
 }
 
-static int __io_openat_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
+/* Prep for open that is common to both openat*() and open_by_handle_at() */
+static int __io_open_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
 	struct io_open *open = io_kiocb_to_cmd(req, struct io_open);
-	const char __user *fname;
-	int ret;
 
 	if (unlikely(sqe->buf_index))
 		return -EINVAL;
@@ -74,6 +73,29 @@ static int __io_openat_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe
 		open->how.flags |= O_LARGEFILE;
 
 	open->dfd = READ_ONCE(sqe->fd);
+
+	open->file_slot = READ_ONCE(sqe->file_index);
+	if (open->file_slot && (open->how.flags & O_CLOEXEC))
+		return -EINVAL;
+
+	open->nofile = rlimit(RLIMIT_NOFILE);
+
+	if (io_openat_force_async(open))
+		req->flags |= REQ_F_FORCE_ASYNC;
+
+	return 0;
+}
+
+static int __io_openat_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
+{
+	struct io_open *open = io_kiocb_to_cmd(req, struct io_open);
+	const char __user *fname;
+	int ret;
+
+	ret = __io_open_prep(req, sqe);
+	if (ret)
+		return ret;
+
 	fname = u64_to_user_ptr(READ_ONCE(sqe->addr));
 	open->filename = getname(fname);
 	if (IS_ERR(open->filename)) {
@@ -82,14 +104,7 @@ static int __io_openat_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe
 		return ret;
 	}
 
-	open->file_slot = READ_ONCE(sqe->file_index);
-	if (open->file_slot && (open->how.flags & O_CLOEXEC))
-		return -EINVAL;
-
-	open->nofile = rlimit(RLIMIT_NOFILE);
 	req->flags |= REQ_F_NEED_CLEANUP;
-	if (io_openat_force_async(open))
-		req->flags |= REQ_F_FORCE_ASYNC;
 	return 0;
 }
 
-- 
2.51.0


