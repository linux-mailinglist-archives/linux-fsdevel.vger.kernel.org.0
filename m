Return-Path: <linux-fsdevel+bounces-27188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F0695F47E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 16:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 465A8B22083
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 14:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23B91917DB;
	Mon, 26 Aug 2024 14:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="Tu5XrLD2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66892187870;
	Mon, 26 Aug 2024 14:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724684277; cv=none; b=hH8tfeHacARCfh0BYxCyA6dJu6CPn2y80URIKhteRfP9VfrzboMMw49CFJfnCIYWXxGJTfnGffiCkQXIbz+FXKtnRweeeq6A1Xr0Jk+Ph/GcO3AAOWdFfdMOGMaRGK4grYQppWmwTV8GGG7X5ih7b+ZjrFfbAg4vu9dFvYSVjTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724684277; c=relaxed/simple;
	bh=jXVZxCuPiOYyBdvrXSIwLSLj7y3SIdN3dY041U2YV2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W+UtihKEr8KsFjYuAaIx/lwJQUd9nBPerdT+0GFFakfbFrhW6uZC4q1wA/dKbS9toR6Cm9ANy49/xACbA632deA7VHCWf+yOqEu9O0/dHeeYuyPMC5CoE5dAlAFpR4PzxJmSnnJDjUDI7QhHBalVSyKXEj5QZ1DrDiGGS5C+exE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=Tu5XrLD2; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1724684274;
	bh=jXVZxCuPiOYyBdvrXSIwLSLj7y3SIdN3dY041U2YV2k=;
	h=From:To:Cc:Subject:Date:From;
	b=Tu5XrLD2QsCq8ozJKexiEEBKIdqzwqzj1t/cI13rU0RGMlrvUoj9WQS+IKCnGiMV9
	 A+tUC0fOMqZJ0uBeYR9ppfSdjBby43JIO21TzvDU7YaDUaNGHlFIDNkZL9bqVI5i4X
	 rlLtEG/m70RpTZOIKxlwlrLzmf3t5nlJ4QqozCV4=
Received: from stargazer.. (unknown [113.200.174.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id AE6FD66F26;
	Mon, 26 Aug 2024 10:57:52 -0400 (EDT)
From: Xi Ruoyao <xry111@xry111.site>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-man@vger.kernel.org,
	Xi Ruoyao <xry111@xry111.site>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] statx.2: Document AT_EMPTY_PATH allows using NULL instead of "" for pathname
Date: Mon, 26 Aug 2024 22:57:19 +0800
Message-ID: <20240826145718.60675-2-xry111@xry111.site>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Link: https://git.kernel.org/torvalds/c/0ef625bba6fb
Cc: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 man/man2/statx.2 | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/man/man2/statx.2 b/man/man2/statx.2
index f7a06467d..741de10be 100644
--- a/man/man2/statx.2
+++ b/man/man2/statx.2
@@ -20,8 +20,9 @@ Standard C library
 .BR "#include <fcntl.h>           " "/* Definition of " AT_* " constants */"
 .B #include <sys/stat.h>
 .P
-.BI "int statx(int " dirfd ", const char *restrict " pathname ", int " flags ,
-.BI "          unsigned int " mask ", struct statx *restrict " statxbuf );
+.BI "int statx(int " dirfd ", const char *_Nullable restrict " pathname ,
+.BI "          int " flags ", unsigned int " mask ",
+.BI "          struct statx *restrict " statxbuf );
 .fi
 .SH DESCRIPTION
 This function returns information about a file, storing it in the buffer
@@ -146,7 +147,7 @@ for an explanation of why this is useful.)
 By file descriptor
 If
 .I pathname
-is an empty string and the
+is an empty string (or NULL since Linux 6.11) and the
 .B AT_EMPTY_PATH
 flag is specified in
 .I flags
@@ -164,7 +165,8 @@ is constructed by ORing together zero or more of the following constants:
 .\" commit 65cfc6722361570bfe255698d9cd4dccaf47570d
 If
 .I pathname
-is an empty string, operate on the file referred to by
+is an empty string (or NULL since Linux 6.11), operate on the file referred
+to by
 .I dirfd
 (which may have been obtained using the
 .BR open (2)
@@ -604,7 +606,11 @@ nor a valid file descriptor.
 or
 .I statxbuf
 is NULL or points to a location outside the process's
-accessible address space.
+accessible address space (except since Linux 6.11 if
+.B AT_EMPTY_PATH
+is specified in
+.IR flags ,
+pathname is allowed to be NULL)
 .TP
 .B EINVAL
 Invalid flag specified in
-- 
2.46.0


