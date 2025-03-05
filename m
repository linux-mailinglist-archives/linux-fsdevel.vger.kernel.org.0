Return-Path: <linux-fsdevel+bounces-43238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 179BCA4FBE2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 11:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 396E61692AA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 10:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325BC2066F8;
	Wed,  5 Mar 2025 10:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKvTPS2K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365292063FB;
	Wed,  5 Mar 2025 10:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741170480; cv=none; b=GV/tAMMofx4qNYkArZZWd9rm8RzsqFZds5K0StTNMuOKoiFuUqg4j8P4PrcZbPp3MkzGGM0/kINY6SO+UZDj2nk5ta1CgNbICtdKa5VU7kLXXYcc+pmH9cOWc+Yy6nrTaBhIFOUv7+Eu6pKua9MW0V92ud/fjE0vzwACUOPL/Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741170480; c=relaxed/simple;
	bh=ISAvPA9mGuMe3kEiIGiHmnkLLBT133ajEwpJ3/bg+7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GmsMGlqaR/oPKesSOTQHjMUokFBKaB8BmcBylA4FaKEKnPssl3M0pXYXEQOV4aUXVo/oQxSa0jU67GIJ2k3Y6n/bNVoySHLareWuhT4Tyr0eTecKMi442JYmsqjGYrDZnP2an/7LHGLp2bJk6DDafSXtqv/kwlCSlhbtbxBev0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKvTPS2K; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22185cddbffso10573465ad.1;
        Wed, 05 Mar 2025 02:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741170477; x=1741775277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k67TXimsNyCJpPgpLzBGFfJN65RsX6oOCekGytWHejQ=;
        b=SKvTPS2K8WUteeYDmZEW8zi+iyOemPtGLIBtmGGKoeUildRpekS+/1XJ5sitKiAnHR
         eYFpS9CW1a4Cm69fyTW/rjXxNTyVuGPiU2PLW2yzSvMimk2OTsNRdlDOTQUaSLo3jOES
         MRagzfDhK8fQEtwGJCl1PY5oU0nCiJmyFBkEt9115OJZhlbdMjglYX/mu5sD0Zku1yQZ
         EpL9HlIYtp4GbE7SWN6tmcIcq3tMhl0fyxSblfLHLQ5Q9oqzi7XNnGbMfWbWocHlG8nF
         SQDoQi1arLM975E6JeoUqJ2qVpW8y5pG6xQ3hgWtmTR4UzqwvtNqgpKjWkLCoEBZJvvZ
         +Z0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741170477; x=1741775277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k67TXimsNyCJpPgpLzBGFfJN65RsX6oOCekGytWHejQ=;
        b=Etm/WbjelsfJWwVY+a3jCLbl177RiYslFJTkpwYbNPAEiM5NxkEVfi8mxy0UC09DMK
         1Rb7pdlV1kstEolqRsOPRSovLX81qnzNE1GIV4E7V4zVwy4PtIzyXUzEcAQvhDNcIKHX
         rT3A56xYkqJ6LqIaYDYo2OXl/iEZ9yGxA7X0efNAZN2iuRE27GRXaVAxUCVTa/tc2DQv
         A5SCEWQ75WQWMQST+y5+GP+D0iBaV93222stE5cl0lEigxCym/gayOR83YAYBmwlsJ+v
         aKZk8S3t+TGoPP67DGyOakxLkvUtQjaPMZ7iqT8HphEA9ruLP71t2V8XMkZ2OZBF7itJ
         D5AQ==
X-Gm-Message-State: AOJu0YwybQ9wSHdYbV6sPJgED1KR2xQQoKCAt5BqGUG7cELCHWfb1b0y
	h1FmvtcN2xQI9PR0cL83Ag+9zxxSFD5lAHUhFs2eKKIA1TH6nnu7zJhzZQ==
X-Gm-Gg: ASbGncv2gTuuS6+r5lSxnZLTmc/mtwiVG9OHP4OIM6RuxDDh5maEC2OXmgbUIX4jMpw
	i1mRfUJCfvs/kiarBpvn/S1T780yGX4ByTfqwUJX9ziPcgeWBtMScSc2jiFij/ht0vCdkd32fea
	fbAymlS9yw9qBv5vMeaUPr6ysOO4mNnkaTPi1nhZR3LSl2pwGkrJltDoHJyeaKxdcTPijh3PZux
	ZLm7gvB24yps3mzS9kQfimO3Jb9NzzdpS8a0DfuSm6mv3GeQlbl347E+tQxz2D3N8Vm15Nh245e
	JHRWQpKyfu7qoSwY2fbzRCi3rIcNHpL3G8G0p8L0GFG86cYPDBI=
X-Google-Smtp-Source: AGHT+IEYOuHf87Ml8QQMzEe7kVZPlPPQ3+aUa8b6UVnQ5ylVHFiIqe7dVTV8vNJ+dTrc7G+n+cHSig==
X-Received: by 2002:a05:6a00:8c2:b0:736:491b:5370 with SMTP id d2e1a72fcca58-73681ebc96emr4594224b3a.10.1741170477317;
        Wed, 05 Mar 2025 02:27:57 -0800 (PST)
Received: from dw-tp.ibmuc.com ([171.76.80.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7364ef011c1sm6252768b3a.111.2025.03.05.02.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 02:27:56 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-xfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	"Darrick J . Wong" <djwong@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v2 1/3] xfs_io: Add support for preadv2
Date: Wed,  5 Mar 2025 15:57:46 +0530
Message-ID: <68b83527415c7c2a74270193f5ffd14363e5de88.1741170031.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741170031.git.ritesh.list@gmail.com>
References: <cover.1741170031.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds support for preadv2() to xfs_io.

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


