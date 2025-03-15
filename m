Return-Path: <linux-fsdevel+bounces-44109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE87A628F8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Mar 2025 09:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CEE88805DD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Mar 2025 08:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A071DFD96;
	Sat, 15 Mar 2025 08:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhJIIsPO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4D318E023;
	Sat, 15 Mar 2025 08:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742026831; cv=none; b=bLiJXAc0uJCH83/R/23EQEMyhvKGgc6OOEzrdzICfb4rpU/cC1bcOYB0/i36CHeMT55AZmi0yjrZXI/BjdonRnPsvcTIFR7IEUIQh4CWVGn466fxHmnW4SctmQ7/Bt4xBPUCf4lSc/5OzBWzs5qcOvQiupEAGPpUvTJJqb0NHO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742026831; c=relaxed/simple;
	bh=czJ60Mg0jpKXxP6obLKAe+Jse5gOjYrtu0Z6+1OU33w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RRRgzc0HJ/U+wy9UtZj9VR2xQvS3B2lYXIGB2M/QCKwYzWJfV7GkOy/fA0f4qbBgQrW0ivWpYFiJPb9nTc/mR2SX8ngYzVQT+VAeKdt/zlBdU4w8eoktnOXASj5zwaZA2hXuvIMlX6AeVqrJNKAUSy8R+1IlEpQ/Q6754p+OuvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhJIIsPO; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-224191d92e4so57056105ad.3;
        Sat, 15 Mar 2025 01:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742026828; x=1742631628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uo2iuroLr/xEVn94lcwpCquIfx88/trS/NRdQQvjLt0=;
        b=QhJIIsPOLuI7yEImM33yfbcNpziRle+XIR3aNC6aei+3sQmtLG7icwIs2PXEFZmGQs
         azD6wu3OYRDVww3ki+7toDHA+FAQNT6y1N9KOyTTf4GT9Db3aVY5AfFwktv+wnaY08Ul
         3FiNl4OCANU/EkjDZzqfkpTykLDB3vhHgI28ul762OtQZp5WS7NjkimryoAvkLT1betd
         Yaf+MosG7+PhdCMQXIrPn17C1Rycd2F6+LkVJO+mlWGq04wSBRxy0+8MLNMcpqduHpJy
         yD3qp25GgjwA9hbdEsbjnNqZCW8fUjyP0ukuZ8qGRJWgVSV8luLKIUHTJF+gZMVsGs4+
         tReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742026828; x=1742631628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uo2iuroLr/xEVn94lcwpCquIfx88/trS/NRdQQvjLt0=;
        b=eRdmElGYLURTXZEVjy2SBjm4+KyB0G/oyjh9nEWwH2tvXFT4CxGjMLKV/xSDQ1ULhK
         6hACPpuEhz9FaidFfwC9sP//3Qmzc+TEH5WtELzxg9gGGBBNWABcizpzWiB83IKQ0L0z
         u1tkkh5iB8GGfED5K2Pj+xJK0bIIlxNH01HDb7dLX9V0QHEUHN1ui/ojGmreJNdiQloo
         DYckDQYKCmrpOQvyMHmIDgv1lFLeeEjGTfY7w0z46WBgVSLY4KHRjZRr/UHrXJepCYLV
         tky5FOMK8ad8BWW2oN5oDzgLsODOJyu8mmIJhNNFMQtNs9US8p116+6Wdu0fxmrsNdiJ
         6b2g==
X-Forwarded-Encrypted: i=1; AJvYcCUOrajbSz4QNQ0hdkllUkwEw1DOBxG/IJFqU8JnRjEHXYhoCrf6GD6OTexBjRfYzhCxrVOZiIhJQO+SN4Xf@vger.kernel.org
X-Gm-Message-State: AOJu0YxR3xirGH4Ov1l87NlNnubj5x4apNtMDiG+8qSw8SySwguDKdlo
	6EGFEB8mEgR/kbP5myCaRIuxnARXP7Eyco9E+qZeuK48glUd9uq+FnSQRw==
X-Gm-Gg: ASbGncsGuoK4Nv7a67n0AO8gYaaMGC3QyBCfSrJBV7DAThNKbaibqiku0kjhft71xOL
	p0X7kKtyxE5K2NKqnODo88tA+U65t99aoVDOuse9XHbEB4xZzTUhmQocbZDzjXXJWC540F8GUm1
	PPcVHqnpuexJ6+oIxNeKr1Ti986cV+xgma57incNmc5uAB85YmWcQ9mSW5F3SqaiEgpvyGDPCK7
	EVZwGGusmjKARTw2GkDXAXTso+kpnY01XdP40CnyH4UZ9dKAYmSWbgnFMBqtlD6pcT2+HGHU9dg
	o2y0An5fVbrn3WrdyzyV8744rSfzMzYIFzPe7k6JCXNN2BmBDA==
X-Google-Smtp-Source: AGHT+IGy15Irg5VwD3E3zLDMiMU361fqg7mrfdMUkchBHWIY7U7YJyN+AWtmA3ndWUgKt9An9PDNcw==
X-Received: by 2002:a17:902:d54f:b0:215:9bc2:42ec with SMTP id d9443c01a7336-225e0b14fb5mr66205455ad.47.1742026827698;
        Sat, 15 Mar 2025 01:20:27 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([171.76.87.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbe7e4sm40071405ad.189.2025.03.15.01.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 01:20:27 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-xfs@vger.kernel.org
Cc: "Darrick J . Wong" <djwong@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v3 1/3] xfs_io: Add support for preadv2
Date: Sat, 15 Mar 2025 13:50:11 +0530
Message-ID: <fcf1cbeb80cbdca9939aac4b823f6139ef40e178.1741340857.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741340857.git.ritesh.list@gmail.com>
References: <cover.1741340857.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds support for preadv2() to xfs_io.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 io/Makefile |  2 +-
 io/pread.c  | 45 ++++++++++++++++++++++++++++++---------------
 2 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/io/Makefile b/io/Makefile
index 8f835ec7..14a3fe20 100644
--- a/io/Makefile
+++ b/io/Makefile
@@ -66,7 +66,7 @@ LLDLIBS += $(LIBEDITLINE) $(LIBTERMCAP)
 endif
 
 ifeq ($(HAVE_PWRITEV2),yes)
-LCFLAGS += -DHAVE_PWRITEV2
+LCFLAGS += -DHAVE_PWRITEV2 -DHAVE_PREADV2
 endif
 
 ifeq ($(HAVE_MAP_SYNC),yes)
diff --git a/io/pread.c b/io/pread.c
index 62c771fb..b314fbc7 100644
--- a/io/pread.c
+++ b/io/pread.c
@@ -162,7 +162,8 @@ static ssize_t
 do_preadv(
 	int		fd,
 	off_t		offset,
-	long long	count)
+	long long	count,
+	int			preadv2_flags)
 {
 	int		vecs = 0;
 	ssize_t		oldlen = 0;
@@ -181,8 +182,14 @@ do_preadv(
 	} else {
 		vecs = vectors;
 	}
+#ifdef HAVE_PREADV2
+	if (preadv2_flags)
+		bytes = preadv2(fd, iov, vectors, offset, preadv2_flags);
+	else
+		bytes = preadv(fd, iov, vectors, offset);
+#else
 	bytes = preadv(fd, iov, vectors, offset);
-
+#endif
 	/* restore trimmed iov */
 	if (oldlen)
 		iov[vecs - 1].iov_len = oldlen;
@@ -195,12 +202,13 @@ do_pread(
 	int		fd,
 	off_t		offset,
 	long long	count,
-	size_t		buffer_size)
+	size_t		buffer_size,
+	int			preadv2_flags)
 {
 	if (!vectors)
 		return pread(fd, io_buffer, min(count, buffer_size), offset);
 
-	return do_preadv(fd, offset, count);
+	return do_preadv(fd, offset, count, preadv2_flags);
 }
 
 static int
@@ -210,7 +218,8 @@ read_random(
 	long long	count,
 	long long	*total,
 	unsigned int	seed,
-	int		eof)
+	int		eof,
+	int		preadv2_flags)
 {
 	off_t		end, off, range;
 	ssize_t		bytes;
@@ -234,7 +243,7 @@ read_random(
 				io_buffersize;
 		else
 			off = offset;
-		bytes = do_pread(fd, off, io_buffersize, io_buffersize);
+		bytes = do_pread(fd, off, io_buffersize, io_buffersize, preadv2_flags);
 		if (bytes == 0)
 			break;
 		if (bytes < 0) {
@@ -256,7 +265,8 @@ read_backward(
 	off_t		*offset,
 	long long	*count,
 	long long	*total,
-	int		eof)
+	int		eof,
+	int		preadv2_flags)
 {
 	off_t		end, off = *offset;
 	ssize_t		bytes = 0, bytes_requested;
@@ -276,7 +286,7 @@ read_backward(
 	/* Do initial unaligned read if needed */
 	if ((bytes_requested = (off % io_buffersize))) {
 		off -= bytes_requested;
-		bytes = do_pread(fd, off, bytes_requested, io_buffersize);
+		bytes = do_pread(fd, off, bytes_requested, io_buffersize, preadv2_flags);
 		if (bytes == 0)
 			return ops;
 		if (bytes < 0) {
@@ -294,7 +304,7 @@ read_backward(
 	while (cnt > end) {
 		bytes_requested = min(cnt, io_buffersize);
 		off -= bytes_requested;
-		bytes = do_pread(fd, off, cnt, io_buffersize);
+		bytes = do_pread(fd, off, cnt, io_buffersize, preadv2_flags);
 		if (bytes == 0)
 			break;
 		if (bytes < 0) {
@@ -318,14 +328,15 @@ read_forward(
 	long long	*total,
 	int		verbose,
 	int		onlyone,
-	int		eof)
+	int		eof,
+	int		preadv2_flags)
 {
 	ssize_t		bytes;
 	int		ops = 0;
 
 	*total = 0;
 	while (count > 0 || eof) {
-		bytes = do_pread(fd, offset, count, io_buffersize);
+		bytes = do_pread(fd, offset, count, io_buffersize, preadv2_flags);
 		if (bytes == 0)
 			break;
 		if (bytes < 0) {
@@ -353,7 +364,7 @@ read_buffer(
 	int		verbose,
 	int		onlyone)
 {
-	return read_forward(fd, offset, count, total, verbose, onlyone, 0);
+	return read_forward(fd, offset, count, total, verbose, onlyone, 0, 0);
 }
 
 static int
@@ -371,6 +382,7 @@ pread_f(
 	int		Cflag, qflag, uflag, vflag;
 	int		eof = 0, direction = IO_FORWARD;
 	int		c;
+	int		preadv2_flags = 0;
 
 	Cflag = qflag = uflag = vflag = 0;
 	init_cvtnum(&fsblocksize, &fssectsize);
@@ -463,15 +475,18 @@ pread_f(
 	case IO_RANDOM:
 		if (!zeed)	/* srandom seed */
 			zeed = time(NULL);
-		c = read_random(file->fd, offset, count, &total, zeed, eof);
+		c = read_random(file->fd, offset, count, &total, zeed, eof,
+						preadv2_flags);
 		break;
 	case IO_FORWARD:
-		c = read_forward(file->fd, offset, count, &total, vflag, 0, eof);
+		c = read_forward(file->fd, offset, count, &total, vflag, 0, eof,
+						 preadv2_flags);
 		if (eof)
 			count = total;
 		break;
 	case IO_BACKWARD:
-		c = read_backward(file->fd, &offset, &count, &total, eof);
+		c = read_backward(file->fd, &offset, &count, &total, eof,
+						  preadv2_flags);
 		break;
 	default:
 		ASSERT(0);
-- 
2.48.1


