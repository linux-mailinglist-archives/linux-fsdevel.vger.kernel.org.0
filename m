Return-Path: <linux-fsdevel+bounces-31230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5285C99353C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 19:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 057541F246B0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 17:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFBA1DDA37;
	Mon,  7 Oct 2024 17:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="tE63oCMw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5B71DDA17
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Oct 2024 17:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728323042; cv=none; b=On37NdnRFYaUhW6D5FjdmXZIjaTaW1QSK8Wcs6iFRuMbY7jJ/N155HTgmSvsT2uOHF1+KKi+zFJZYr5PlvzTB4veYyq82lterMOJvLFHzY+1vl1SNZupSIOf7G79iVs/KHLUAkiGbAQQ1Q7dFYwTVp+08Z3Aqa3oi07Lhx600wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728323042; c=relaxed/simple;
	bh=h1330etW15Ga32DIn9zu/YWOjuk5YGLfS/F7ROpW42s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/37KthunR+6oJJF51Yz6BE8gsbI83YJ/qt/bfqsJuYh0B4QyscCNA850+/rwh6456XDAdp9VxdnDkTcJADl5Jig7q0s9JdINDbxjsFPbnmJj52O8imd4YgVc0r2ZW3lxdhU9TAHGuAlxqad90gPohZBsWyoOEjiIoDrAvCx58A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=tE63oCMw; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=QsbrPFeyk5rsZ35IqKvfFYHnDaxWazjGgrnfZ9JMjJM=; b=tE63oCMwwugs7LukhqUB9D7Qgk
	E+1Vdvr0WbVutV+LlphSYnpj574qHz7wjeXG72rjuGyR+bk3HuB3iIJsxNV59UyUPQr/BPjQii2sS
	AtvcUPOU+zd0WZqN7M6WXaFv5jcCG5nht17N1cILHh62b+6O4lpj13nRWEFhicoKmiMeoLti/xsR5
	Gaj6Np24G/5aXGCIy+f+50ylUQoHw6sxRb82n/Z4OroOVZuG2Qvvz0S/29Ckeu8YQJ1gGfOnnMcYB
	DUzRTmeEA3c07mH0E2GLHmXoma4HCOHAy9Ll1KAplw4B9J3lTfwSaAgYmK+uheKQVrC3lvEDjuJq3
	UbsCITUA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sxrm3-00000001f3e-2i8l;
	Mon, 07 Oct 2024 17:43:59 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org,
	brauner@kernel.org
Subject: [PATCH v3 09/11] file.c: merge __{set,clear}_close_on_exec()
Date: Mon,  7 Oct 2024 18:43:56 +0100
Message-ID: <20241007174358.396114-9-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241007174358.396114-1-viro@zeniv.linux.org.uk>
References: <20241007173912.GR4017910@ZenIV>
 <20241007174358.396114-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

they are always go in pairs; seeing that they are inlined, might
as well make that a single inline function taking a boolean
argument ("do we want close_on_exec set for that descriptor")

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/file.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 7e5e9803a173..d8fccd4796a9 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -237,15 +237,15 @@ static int expand_files(struct files_struct *files, unsigned int nr)
 	return expanded;
 }
 
-static inline void __set_close_on_exec(unsigned int fd, struct fdtable *fdt)
+static inline void __set_close_on_exec(unsigned int fd, struct fdtable *fdt,
+				       bool set)
 {
-	__set_bit(fd, fdt->close_on_exec);
-}
-
-static inline void __clear_close_on_exec(unsigned int fd, struct fdtable *fdt)
-{
-	if (test_bit(fd, fdt->close_on_exec))
-		__clear_bit(fd, fdt->close_on_exec);
+	if (set) {
+		__set_bit(fd, fdt->close_on_exec);
+	} else {
+		if (test_bit(fd, fdt->close_on_exec))
+			__clear_bit(fd, fdt->close_on_exec);
+	}
 }
 
 static inline void __set_open_fd(unsigned int fd, struct fdtable *fdt)
@@ -518,10 +518,7 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
 		files->next_fd = fd + 1;
 
 	__set_open_fd(fd, fdt);
-	if (flags & O_CLOEXEC)
-		__set_close_on_exec(fd, fdt);
-	else
-		__clear_close_on_exec(fd, fdt);
+	__set_close_on_exec(fd, fdt, flags & O_CLOEXEC);
 	error = fd;
 
 out:
@@ -1147,13 +1144,8 @@ void __f_unlock_pos(struct file *f)
 void set_close_on_exec(unsigned int fd, int flag)
 {
 	struct files_struct *files = current->files;
-	struct fdtable *fdt;
 	spin_lock(&files->file_lock);
-	fdt = files_fdtable(files);
-	if (flag)
-		__set_close_on_exec(fd, fdt);
-	else
-		__clear_close_on_exec(fd, fdt);
+	__set_close_on_exec(fd, files_fdtable(files), flag);
 	spin_unlock(&files->file_lock);
 }
 
@@ -1195,10 +1187,7 @@ __releases(&files->file_lock)
 	get_file(file);
 	rcu_assign_pointer(fdt->fd[fd], file);
 	__set_open_fd(fd, fdt);
-	if (flags & O_CLOEXEC)
-		__set_close_on_exec(fd, fdt);
-	else
-		__clear_close_on_exec(fd, fdt);
+	__set_close_on_exec(fd, fdt, flags & O_CLOEXEC);
 	spin_unlock(&files->file_lock);
 
 	if (tofree)
-- 
2.39.5


