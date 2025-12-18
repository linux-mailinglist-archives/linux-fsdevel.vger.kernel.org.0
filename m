Return-Path: <linux-fsdevel+bounces-71632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E02CCAF41
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 09:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1698030B0A4C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 08:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F5E32FA3D;
	Thu, 18 Dec 2025 08:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEXEO/2A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFDA2D2398
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 08:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766046884; cv=none; b=YJTEhF0WvhSUJmfwonIyhoDMv0RD7eM8FaKevwNRNMHq4g3jeIyMFxsHDpeXS4e7brPfVXXqMNXV/yBbRW4o3KIqTFNWWjHWVrGDREi/FZ8aZHuHEqT7WFYeI3nEhgh2TwD+yw7Jtt4TBoP/Bku6lhk9HXvF7Z0jQUemsiiaYpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766046884; c=relaxed/simple;
	bh=j4pCXsrkwTGJ0Yt8ShUCMPcAaExRESShE0RxC+SZfjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQFD+YBOynBdajY7+c8nTBxNR8yn1YKLcM+/82HI/jIvIS5WCLGMzrYvDs6RrZOmjD94eUrtgvct3fSLJ1a8ZuUrzLOOGRJkDSFT1U2mcvY8yEcbQyKdR9hmpLNKOOP3cNThEEnN4+9lyq7SQdn7J4j0DkI1GgC/Td81zYydPEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEXEO/2A; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso333971b3a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 00:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766046882; x=1766651682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XiB+Fy0CW+7OP9Cqy2W6zdEPfAr8bWS3LGB82D8pXcM=;
        b=XEXEO/2AO3w87ZDj2pveF9XPvlJOxbfEm2lEiQo/z7z+O+b05qQ5WGSuuEPZeeSnim
         PBCffGF2n05mdcAKSd1t3PsLslrlqd36Qg+cnsBZ4Ub/uUbOXwiutMWSIA6FSCOdlJe6
         ixXRP2hXyqcmPCL0bHkzs0bFpso9pxxnVW7p87gZHFCU48OzB2l3dnrZoSYuidmUZDAi
         PfZdPDz5Ntw+DJkcTycCn4R+aVHvQC9LLUwmJppdWg4Zkng2L7NDygN5Qd2LU0ZAt68V
         mqDO0Yj45JlsO/51qsBtXzVlwoBxMmu2XLxk8AyZsvG9SrYtfi+X9HVUBX/yTobdG1CK
         q1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766046882; x=1766651682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XiB+Fy0CW+7OP9Cqy2W6zdEPfAr8bWS3LGB82D8pXcM=;
        b=SYeHTSQhEkc9dTp0iy77GssXcCil5HWc9SPD1m9o0BD7jpFvLy3hX60a7Vee/ErV7U
         U5V8/U+8b/0+r8tBmdNSSPn9vW4qJ9gqVAI431tyR0lgB5kB4KUuUsloxemj54QtA79u
         fVH/sKlqvuuc8K4ZYyLjZNaJnlXFSQ0VSY3soUZcilgRPRRBm4iyl7Y+567y40Ss+mk4
         zMpckZe+rqmB0BE0W8y2WkthBze2WywTpLhdtaWK1BZ4XHOCI+aw5UW4Q+ikLOUzQpuP
         KjqEsa+NHgt8Ytxi7gd4ISEc+NBZTHYI+iMX3qqiv1d4yKJ4si+mWTPJb9v+RghTdxky
         0THQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6GkZ0pEsBiG7Xx/SdZfdndAeR2fmn8u9pfI0UW177kFl2cClBdMiZHiKgxYdYK+WB/kzsAYAajgTVPZrg@vger.kernel.org
X-Gm-Message-State: AOJu0YwyoHx1RDaWLcD00lhcTWHU+ec31uIooekkSFZZXzNhZMU7s47k
	ZRWtKdNQTQZ/Nfbjes+vOmd+NAmBtOjdKiSQ4YiyjoGUaJVrVaIMqorI
X-Gm-Gg: AY/fxX67LEK8ecgrvUtXNdTscMeIAfPWIFRYmoQ6n/eK6lc5YijST+tq8frBGJTRRG9
	7J5+7FtUlL/hRuBI/4q+SsV0JS3VzXOc+Mh6SogKKg4xMB/pIYdmmViNEIHiWyc9hsj4dG1eoxP
	o7R2L022028zLErheL4XKqf2UmzPkR4Nt6b3J0PA4dtW7+/d5j9O4uy6+tyhOLFlc1Lf3nx/8vI
	QfR3qR39Blmi+m4ZbG4uaROd/macabAdIXQktgION5RdaUccexK1sXh6wecwqP6IIcMJoX4rP11
	D7Td1rh4n99FRICxitoHnMKEuX9QaxqkUaoolE4NyeH7mqWTwNdqoT717hf91nMsLYW0WqboO2v
	to7G5Ikxc8TKvk4edZic+6RLGdZ9ncUM5xKk3K60i+NnwERdDZRgDdgcwMG/8NvlgQxONp76+4o
	RqevIJJ/nmJKRL3g==
X-Google-Smtp-Source: AGHT+IGwUHxIZlG18VV1M2bBcER/DVkm4R1Wng+/OHLLt7cl6x6eUBvkwRac2QPIiryNLUgHaAsj0A==
X-Received: by 2002:a05:6a20:7285:b0:35d:6b4e:91f1 with SMTP id adf61e73a8af0-369ae0ac5a8mr19292293637.34.1766046881763;
        Thu, 18 Dec 2025 00:34:41 -0800 (PST)
Received: from localhost ([2a03:2880:ff::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d1926d45sm17258245ad.78.2025.12.18.00.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 00:34:41 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	csander@purestorage.com,
	xiaobing.li@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 05/25] io_uring/kbuf: support kernel-managed buffer rings in buffer selection
Date: Thu, 18 Dec 2025 00:32:59 -0800
Message-ID: <20251218083319.3485503-6-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251218083319.3485503-1-joannelkoong@gmail.com>
References: <20251218083319.3485503-1-joannelkoong@gmail.com>
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
index 65102aaadd15..c98cecb56b8c 100644
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
+		sel.kaddr = (void *)buf->addr;
+	else
+		sel.addr = u64_to_user_ptr(READ_ONCE(buf->addr));
 
-	if (io_should_commit(req, issue_flags)) {
+	if (io_should_commit(req, bl, issue_flags)) {
 		io_kbuf_commit(req, sel.buf_list, *len, 1);
 		sel.buf_list = NULL;
 	}
-- 
2.47.3


