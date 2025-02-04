Return-Path: <linux-fsdevel+bounces-40805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82343A27BE9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 20:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BDBB1884CBF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 19:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBAB21A432;
	Tue,  4 Feb 2025 19:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SsvWfTrP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017A621A422
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 19:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738698508; cv=none; b=oRCQ2+yv/vMWLIq5PLxaaJdbaOgFV+y/31dvujz7zn2+CTdjwt+j9CBrVIAlo9bEoFl4PIQYOhUlWr67ZINdio1gnDQ8OfzIL6LxLonaCCh8ldbHo11iftARkPbXwBHvzsmfcoo4zA0GFBoZ1s/mwGcMyni6OHXWNe+xsS8begM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738698508; c=relaxed/simple;
	bh=im1ntOsYLHYjJiEvx6njeC6vx3wirWuYtKuqP171Gs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UvDgDgd//4b3WSpDstxeyuqR5DWNhkw+OrkS5C2UbO4Gvy8wUoKapfLegBhSLyuWrBDtKhimegOd5BwozCYxJtOQDchlR00RJ6OmtKrCgeGEGF2Z8RTa8d3gTgcO0q0NyxoXIMwcvGWHr1yDodmXqC9fgEmIKKiW/8ywsCtPxCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=SsvWfTrP; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-84a1ce51187so163989539f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Feb 2025 11:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1738698506; x=1739303306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQ8sKu9TA7JXcFTCTxuSEZOOG4qI+mYE1gZPeZ19VjI=;
        b=SsvWfTrPPFbY5eWm1kGdmTK4bIFiTSznfzgR9fXviYxF+7VaB4SmDSUx0rSPBeIMNn
         f13pUbio3mp2TBgMC8WZwbwK1zCyDob5A4EJTdHW9WqdeyiDvNAxao/ZQPZd3k1q2mLH
         gvErpQzOaNyQJVuLFAQjYgS9J9CoNJwlNmdglJwZua0gm1dyAsT13bn32QR9Q7MkC1J4
         4+itUYlkQkeILa4XSo8s0biwRTaykHDnYmcZurDxm471Zitk1kLsEH2ZzFOn+otjMiF4
         a8G16c5/f/cobgJNwUyXWca8THYyA1mre63/j31MnKXssrODU695XAhza5iMtRaGsb6S
         NF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738698506; x=1739303306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQ8sKu9TA7JXcFTCTxuSEZOOG4qI+mYE1gZPeZ19VjI=;
        b=HS31LadA+Wb5VLPWpupZ0lbGBqrrm3cVRNS16e7sGm1P2yH097q3t36r6xxryaZ6/n
         JZwcixeZA+2hwS/WDEEYNnMnxuD6lVfJygw7Gf1Hu6COwPAMnNicD9/cKxiMAq02P+TS
         vlQRLJG0J15u+gFu3dc2UUT99fT1ILAyPm/XrmV3BEz0q+U5R2QLkFZ2xOZtxYDDkfgI
         +KwQygbb2pSlI501n0Ib98CwlOg2QA8xv7GnVkaD0FTV3sGOoI7fwMBIHmqRJiJxBKRY
         pZYTuK+0bh2JSdSRmh+A8HZedMSF0M6AC+a8ZKjGKyvKLpw84ssTUBTK3vzXc6TslMWO
         vyzw==
X-Gm-Message-State: AOJu0YzVcQEvbSy7QSRf3LpNCqg8wWDC7yQbgLd5PUZTVqSl8zGfLufU
	HSuCT1Tb2PCjNP7CTO16fiPfaFBu0U1M2mXKUci5DEzWDkEH8JpcC/RJhl9j3a8=
X-Gm-Gg: ASbGncumMwVFDEzFZqVPgBPulGQq3SI1AO/A8EHLUnANT7XwLjWk062ww593nmAvySU
	AbE1ZPGhRqjz+6OJ9hkn68QmDUFUUdiCqdryvv3+7b5TBNa9hY7+EQhrWHhFhIOI5zjRKzLpkMn
	ZxXZnhY4KFEvMS+sAKnW7WVro0TQqQ6mFlpES3ti428hWytC9jWTgWxKrMfNZaq2bvTphvktJi+
	+rhagwwrBKhIieDUVePg+PN6XW4csMBW2hD2omjrAQ0UEajmPAfoMNvkRDeAFmS6DbadNsDTwtj
	gJPIWufGjL7VDFJ8p+E=
X-Google-Smtp-Source: AGHT+IGgKsTAIuMWIIUyjhHQg9pg2TRiKqIeaaiPRkZN0hdZykJCKB/DPuXnqQ84gaSqM31W+Yz5gA==
X-Received: by 2002:a05:6602:4192:b0:844:cbd0:66ca with SMTP id ca18e2360f4ac-854ea411c82mr28620039f.1.1738698506071;
        Tue, 04 Feb 2025 11:48:26 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ec746c95c4sm2841466173.127.2025.02.04.11.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 11:48:25 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 07/11] io_uring/poll: pull ownership handling into poll.h
Date: Tue,  4 Feb 2025 12:46:41 -0700
Message-ID: <20250204194814.393112-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250204194814.393112-1-axboe@kernel.dk>
References: <20250204194814.393112-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for using it from somewhere else. Rather than try and
duplicate the functionality, just make it generically available to
io_uring opcodes.

Note: would have to be used carefully, cannot be used by opcodes that
can trigger poll logic.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/poll.c | 30 +-----------------------------
 io_uring/poll.h | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 29 deletions(-)

diff --git a/io_uring/poll.c b/io_uring/poll.c
index bb1c0cd4f809..5e44ac562491 100644
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -41,16 +41,6 @@ struct io_poll_table {
 	__poll_t result_mask;
 };
 
-#define IO_POLL_CANCEL_FLAG	BIT(31)
-#define IO_POLL_RETRY_FLAG	BIT(30)
-#define IO_POLL_REF_MASK	GENMASK(29, 0)
-
-/*
- * We usually have 1-2 refs taken, 128 is more than enough and we want to
- * maximise the margin between this amount and the moment when it overflows.
- */
-#define IO_POLL_REF_BIAS	128
-
 #define IO_WQE_F_DOUBLE		1
 
 static int io_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
@@ -70,7 +60,7 @@ static inline bool wqe_is_double(struct wait_queue_entry *wqe)
 	return priv & IO_WQE_F_DOUBLE;
 }
 
-static bool io_poll_get_ownership_slowpath(struct io_kiocb *req)
+bool io_poll_get_ownership_slowpath(struct io_kiocb *req)
 {
 	int v;
 
@@ -85,24 +75,6 @@ static bool io_poll_get_ownership_slowpath(struct io_kiocb *req)
 	return !(atomic_fetch_inc(&req->poll_refs) & IO_POLL_REF_MASK);
 }
 
-/*
- * If refs part of ->poll_refs (see IO_POLL_REF_MASK) is 0, it's free. We can
- * bump it and acquire ownership. It's disallowed to modify requests while not
- * owning it, that prevents from races for enqueueing task_work's and b/w
- * arming poll and wakeups.
- */
-static inline bool io_poll_get_ownership(struct io_kiocb *req)
-{
-	if (unlikely(atomic_read(&req->poll_refs) >= IO_POLL_REF_BIAS))
-		return io_poll_get_ownership_slowpath(req);
-	return !(atomic_fetch_inc(&req->poll_refs) & IO_POLL_REF_MASK);
-}
-
-static void io_poll_mark_cancelled(struct io_kiocb *req)
-{
-	atomic_or(IO_POLL_CANCEL_FLAG, &req->poll_refs);
-}
-
 static struct io_poll *io_poll_get_double(struct io_kiocb *req)
 {
 	/* pure poll stashes this in ->async_data, poll driven retry elsewhere */
diff --git a/io_uring/poll.h b/io_uring/poll.h
index 04ede93113dc..2f416cd3be13 100644
--- a/io_uring/poll.h
+++ b/io_uring/poll.h
@@ -21,6 +21,18 @@ struct async_poll {
 	struct io_poll		*double_poll;
 };
 
+#define IO_POLL_CANCEL_FLAG	BIT(31)
+#define IO_POLL_RETRY_FLAG	BIT(30)
+#define IO_POLL_REF_MASK	GENMASK(29, 0)
+
+bool io_poll_get_ownership_slowpath(struct io_kiocb *req);
+
+/*
+ * We usually have 1-2 refs taken, 128 is more than enough and we want to
+ * maximise the margin between this amount and the moment when it overflows.
+ */
+#define IO_POLL_REF_BIAS	128
+
 /*
  * Must only be called inside issue_flags & IO_URING_F_MULTISHOT, or
  * potentially other cases where we already "own" this poll request.
@@ -30,6 +42,25 @@ static inline void io_poll_multishot_retry(struct io_kiocb *req)
 	atomic_inc(&req->poll_refs);
 }
 
+/*
+ * If refs part of ->poll_refs (see IO_POLL_REF_MASK) is 0, it's free. We can
+ * bump it and acquire ownership. It's disallowed to modify requests while not
+ * owning it, that prevents from races for enqueueing task_work's and b/w
+ * arming poll and wakeups.
+ */
+static inline bool io_poll_get_ownership(struct io_kiocb *req)
+{
+	if (unlikely(atomic_read(&req->poll_refs) >= IO_POLL_REF_BIAS))
+		return io_poll_get_ownership_slowpath(req);
+	return !(atomic_fetch_inc(&req->poll_refs) & IO_POLL_REF_MASK);
+}
+
+static inline void io_poll_mark_cancelled(struct io_kiocb *req)
+{
+	atomic_or(IO_POLL_CANCEL_FLAG, &req->poll_refs);
+}
+
+
 int io_poll_add_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
 int io_poll_add(struct io_kiocb *req, unsigned int issue_flags);
 
-- 
2.47.2


