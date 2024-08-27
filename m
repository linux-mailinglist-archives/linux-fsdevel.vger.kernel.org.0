Return-Path: <linux-fsdevel+bounces-27346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7263F960760
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 12:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CBD91C204F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 10:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C50B19CCE6;
	Tue, 27 Aug 2024 10:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="dcs8zJDB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4331E13B588;
	Tue, 27 Aug 2024 10:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724754432; cv=none; b=fSOveM+Yj60mQidN6nLSeTBKGCfhF4QvOkjsW1rzljAy+ipkqFH3pGoCnYrWzxT27AUu4HTbDB61bBN8Oohv9z7PqMIRYJhoHOBAQiJlSc+deaDsQm0BJoH/5U9CGAje7tNrM2X8ONo0NWVDb3KRc6Fqx6w52yOfxuVuMURRsv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724754432; c=relaxed/simple;
	bh=FQU2KV+r3vlPhj5b/I9PIiDx3dWovZFqmmraHao0Owk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IZiXSTukxycAv40ehCkVS0Q0ObF7YE+qc2MLOf6RfTP1l1N+K7MktM21iW6dm2YNtLrFYkld2LChBBsEDs6jxb87+fJEspeX4SGHP3GogH9ThdqHOU3/D9W3I65v0rJhxy5UowjrzRx3MMyXFUeG6+k60kbdbqLcjWPuM5rwUSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=dcs8zJDB; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1724754422;
	bh=FQU2KV+r3vlPhj5b/I9PIiDx3dWovZFqmmraHao0Owk=;
	h=From:To:Cc:Subject:Date:From;
	b=dcs8zJDBVXnj+3mqDHsWAAA0HLJWPUhcBpC1alTQZU3jFbaVLOuA6JZOGwwRL2t/S
	 hEUy2tvYpJwL1BUiwGBUd+j793tTTXcIatHC16j9erRw3txiGIX+rwRgPBu1ybiidj
	 hFk+Y+N/+p0LmFEL7hpxiVBeriHU6w36ZKFhD9xQ=
Received: from stargazer.. (unknown [113.200.174.85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 57B6B66F24;
	Tue, 27 Aug 2024 06:27:01 -0400 (EDT)
From: Xi Ruoyao <xry111@xry111.site>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-man@vger.kernel.org,
	Xi Ruoyao <xry111@xry111.site>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2] statx.2: Document AT_EMPTY_PATH allows using NULL instead of "" for pathname
Date: Tue, 27 Aug 2024 18:25:19 +0800
Message-ID: <20240827102518.43332-2-xry111@xry111.site>
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

Changes from v1:

- Use semantic newlines in AT_EMPTY_PATH description.
- Reorder EFAULT conditions so the added parenthetical describing NULL
  with AT_EMPTY_PATH is next to "NULL".

 man/man2/statx.2 | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/man/man2/statx.2 b/man/man2/statx.2
index f7a06467d..38754d40c 100644
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
+is an empty string (or NULL since Linux 6.11),
+operate on the file referred to by
 .I dirfd
 (which may have been obtained using the
 .BR open (2)
@@ -603,8 +605,12 @@ nor a valid file descriptor.
 .I pathname
 or
 .I statxbuf
-is NULL or points to a location outside the process's
-accessible address space.
+points to a location outside the process's accessible address space or is NULL
+(except since Linux 6.11 if
+.B AT_EMPTY_PATH
+is specified in
+.IR flags ,
+pathname is allowed to be NULL).
 .TP
 .B EINVAL
 Invalid flag specified in
-- 
2.46.0


