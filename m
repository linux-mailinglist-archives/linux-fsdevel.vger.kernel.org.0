Return-Path: <linux-fsdevel+bounces-43086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D053A4DD2B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 12:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E52B1770F0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 11:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016B1202C32;
	Tue,  4 Mar 2025 11:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9KgcA7U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F07201110;
	Tue,  4 Mar 2025 11:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089360; cv=none; b=qHjO5k2lBy0dnb3C8UldZRqR0c8VO1FUerrp8ex0CL1RZ8Ov3NWPDaE7ZrPelaf/0aIJhKOhMoKpCVw/RP5540Idjl2K2sH/FY2N4lhTEtVxAtZmlZJ1WGmuWd2Mj0f5tI05TS0b5wR96RjZn36qyk7r5Iy1lOc2PJNmVeOSuek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089360; c=relaxed/simple;
	bh=VZ3+ZbDgThIHSCchnwlHCHEhjpPFqWfXiipHyF93qF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EIvyeWP4CX1DA3Ism+S24UZNMIAE7E0yEplz20aM2BhrybZpiCnVYk+MM8BjmKks1xg631WCmREn79jDX81bOHrge2lnEhkoYuTw3+VbGyJoiq4FpyD/gjByyNuodFlgzHl55do8kJdvTjiS7HrcySbv4MMmWtAnYA7JCYoy6kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9KgcA7U; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22328dca22fso81993315ad.1;
        Tue, 04 Mar 2025 03:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741089357; x=1741694157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PEfB7F71LO87zIRah2z680gief8fAZP73FNyLtIpjko=;
        b=O9KgcA7UTHWklBo5/MC//h1XAfykWG9y4ZnYe3qH4U6BIkEUgYWCVUxjxeFN3g9xwi
         FdNu9HH4EUn6GnJVgjLV/XdXrnzsyYxDUwnhVfk9KXHw1YAKAa9N2RvMyKEdka64+Up/
         qgvcOZOHgEzi6yzqCGhPzKso1QedTL/+g9iumxf6yDZW6k87WBxx9keDWYFpt4txfTH5
         x8VKUaQVxd1tv51KYsMXIeiyNcW62kZcjiF8ozRWwAiV0E3yuM4r8to1TCJ+9h55pzD7
         2kR4NA/ADq/CTrtlpIdbs0cdKgOlbkUKDvabUXK0+fKzaKB6iYaRkLFTxyDOoko1Q9er
         50Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741089357; x=1741694157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PEfB7F71LO87zIRah2z680gief8fAZP73FNyLtIpjko=;
        b=Zf1f4hus7CkUKeg+SbR8Cv6rEPOhpdJ4sfE0Wt/2DRQWb7YPtWm2GwcLEI3L1JjRyj
         WIamfc9dgy1ROGxo9OkTTaASDuGbXbRk3gEu75LEc7WrGg8uNw0kWqdOhxNotPi5xboM
         BStGiWB0iPzoBY8beS0HpQ8awbFZcBz6A6i/c/ZfovIbJTnq2LdUclUv4WslNPHkBWkd
         6sP3ZvTrLQS+6qcsHbD8h/7AGRuUhFjRULE0ATclDSi7TnMkPzUsP3vcWvqBBgpFSxWh
         wRgCXTS0klN7MODJKxqURdVwf+SnDrWtVOxYC9gzStFgUVlyxEsJKZGL3A+VCyB/wH9i
         wrRA==
X-Gm-Message-State: AOJu0YxMWcLCXxGdh3lgSa8bG79HqPZKvEgWAbDDnL+l6j1bzpqxdBxQ
	qAt4yInagKjHEWniigyI8OfDbafXSCz//oh8F4Zfg2Ide33dA5TfsMJhZeBT
X-Gm-Gg: ASbGnctwXN8bKdbjxQGXNsmKNzJjMvQAZ3HLaGw/hQWwD2abSbdr1rp+4882xqSHnMB
	smTMyInz83oU5FoTXag/ZMW/o2At6RLKYlsSeP+PxQo33jCSjb+10yxb8GGoJvo41W9aXjvHEeI
	e0D/3jbzrv92U72vVDDG2Z2egoCZ+pkI4NAG6KypS6e9pC+69i3niZgGVEFL9jwe3qKx5az6SQz
	EwAar2Xo3Um59+iMUrMzgeiZFd3NXY9q9eKoDuMAE47Kg35zmj3gIUOTiNwKkUo0S6xaVAv1+7L
	wiYHuc9YPmBfFkJT9qjWKopdsRgaGPwDdhygrctOJzvAd5BDw7A=
X-Google-Smtp-Source: AGHT+IHc+uF11+v6/Wpuwk7DcUMdr5Ck3osaF5psv3FuOk9JpZ8IsD26ymZ4RzQ+SIOAh5yd97zbPg==
X-Received: by 2002:a17:903:41d2:b0:216:2dc5:233c with SMTP id d9443c01a7336-223692517f4mr275646965ad.41.1741089357032;
        Tue, 04 Mar 2025 03:55:57 -0800 (PST)
Received: from dw-tp.ibmuc.com ([171.76.80.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d28desm94154565ad.16.2025.03.04.03.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 03:55:56 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-xfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	"Darrick J . Wong" <djwong@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v1 1/3] configure: xfs_io: Add support for preadv2
Date: Tue,  4 Mar 2025 17:25:35 +0530
Message-ID: <046cc1b4dc00f8fb8997ec6ebedc9b3625f34c1c.1741087191.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741087191.git.ritesh.list@gmail.com>
References: <cover.1741087191.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

preadv2() was introduced in Linux 4.6. This patch adds support for
preadv2() to xfs_io.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 configure.ac          |  1 +
 include/builddefs.in  |  1 +
 io/Makefile           |  4 ++++
 io/pread.c            | 45 ++++++++++++++++++++++++++++---------------
 m4/package_libcdev.m4 | 18 +++++++++++++++++
 5 files changed, 54 insertions(+), 15 deletions(-)

diff --git a/configure.ac b/configure.ac
index 8c76f398..658117ad 100644
--- a/configure.ac
+++ b/configure.ac
@@ -153,6 +153,7 @@ AC_PACKAGE_NEED_URCU_H
 AC_PACKAGE_NEED_RCU_INIT
 
 AC_HAVE_PWRITEV2
+AC_HAVE_PREADV2
 AC_HAVE_COPY_FILE_RANGE
 AC_NEED_INTERNAL_FSXATTR
 AC_NEED_INTERNAL_FSCRYPT_ADD_KEY_ARG
diff --git a/include/builddefs.in b/include/builddefs.in
index 82840ec7..a11d201c 100644
--- a/include/builddefs.in
+++ b/include/builddefs.in
@@ -94,6 +94,7 @@ ENABLE_SCRUB	= @enable_scrub@
 HAVE_ZIPPED_MANPAGES = @have_zipped_manpages@
 
 HAVE_PWRITEV2 = @have_pwritev2@
+HAVE_PREADV2 = @have_preadv2@
 HAVE_COPY_FILE_RANGE = @have_copy_file_range@
 NEED_INTERNAL_FSXATTR = @need_internal_fsxattr@
 NEED_INTERNAL_FSCRYPT_ADD_KEY_ARG = @need_internal_fscrypt_add_key_arg@
diff --git a/io/Makefile b/io/Makefile
index 8f835ec7..f8b19ac5 100644
--- a/io/Makefile
+++ b/io/Makefile
@@ -69,6 +69,10 @@ ifeq ($(HAVE_PWRITEV2),yes)
 LCFLAGS += -DHAVE_PWRITEV2
 endif
 
+ifeq ($(HAVE_PREADV2),yes)
+LCFLAGS += -DHAVE_PREADV2
+endif
+
 ifeq ($(HAVE_MAP_SYNC),yes)
 LCFLAGS += -DHAVE_MAP_SYNC
 endif
diff --git a/io/pread.c b/io/pread.c
index 62c771fb..782f2a36 100644
--- a/io/pread.c
+++ b/io/pread.c
@@ -162,7 +162,8 @@ static ssize_t
 do_preadv(
 	int		fd,
 	off_t		offset,
-	long long	count)
+	long long	count,
+	int 		preadv2_flags)
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
+	int 		preadv2_flags)
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
+	int 	preadv2_flags)
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
+	int 	preadv2_flags)
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
+	int 	preadv2_flags)
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
+	int 	preadv2_flags = 0;
 
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
diff --git a/m4/package_libcdev.m4 b/m4/package_libcdev.m4
index 4ef7e8f6..5a1f748a 100644
--- a/m4/package_libcdev.m4
+++ b/m4/package_libcdev.m4
@@ -16,6 +16,24 @@ pwritev2(0, 0, 0, 0, 0);
     AC_SUBST(have_pwritev2)
   ])
 
+#
+# Check if we have a preadv2 libc call (Linux)
+#
+AC_DEFUN([AC_HAVE_PREADV2],
+  [ AC_MSG_CHECKING([for preadv2])
+    AC_LINK_IFELSE(
+    [	AC_LANG_PROGRAM([[
+#define _GNU_SOURCE
+#include <sys/uio.h>
+	]], [[
+preadv2(0, 0, 0, 0, 0);
+	]])
+    ], have_preadv2=yes
+       AC_MSG_RESULT(yes),
+       AC_MSG_RESULT(no))
+    AC_SUBST(have_preadv2)
+  ])
+
 #
 # Check if we have a copy_file_range system call (Linux)
 #
-- 
2.48.1


