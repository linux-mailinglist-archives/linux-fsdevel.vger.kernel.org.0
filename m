Return-Path: <linux-fsdevel+bounces-26585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B82B95A8B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 02:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04F35B21067
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 00:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A26BA42;
	Thu, 22 Aug 2024 00:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Ogyvphk3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3455661
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 00:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724286174; cv=none; b=N5fDnQWJaZyO0tRr3lV80IJ9Ivye2rbAKXpiuXFz7uk3LMAA0o6gnGCJAvNq5iEWfi67yv8Tt9GdHvW4AdrUca4Z3706TH+HbEtCsxOI0sa95H2b6hS3HEH7BGMZv3HDcO4FGYUnr6JlI9M/Z5hquhXBxgrSpRQK+qmxBWZaPPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724286174; c=relaxed/simple;
	bh=VYy6c5ULtWM/jCFykb1wsu67TNBywfB0z/2A1LHLeM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l2i62loXTTmd/e36xcW0TTR+NBoKzxslOkh19/2pOSE9RIwC13u+Kg7grWO42WoTkdagtygsMuex6jMePXmmaqR9ujmGNeSXKUinaPu0KKKgw6lUP52GnmddN2v04cgzJ5SsiDEcPiHng0AJAMQZBFyj0OPi01++sjc3GUTlv5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Ogyvphk3; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ulbvwyLxj963u4YBcB4JbK+qXXe6+lAuFMKevMjC7XU=; b=Ogyvphk3JqWN9MH065bbU7KYKX
	7T00NwNdNTotbGWerDYuBz9g8rx+E9gAPF2CC/fXU5MmeCxpz21RbXPa2qLoJ7zJfd2yxfYCk76PE
	fThnenj1n1SOs0NE2bJTESyQiU47cGs1K8mYWyVZVUgGCPwyAL/hO2SLdEOzV+4Z5egJAUSOFb3iv
	mL2mPE0E3GqoYAfEX4lMJ+UdYJiRruc5iIYvJ1Kw4RkXu6RoT+9mBGYLC7d1JRmBg34gZuWpmaUqo
	+FYJeliadwQjaxh7yLUBjAAZTk6/o7nR00Fzdr83KZYQaJrIC4XmNK9oVhkwNKIDgWYPG5UWspmOQ
	FGiv5Fkw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sgvbH-00000003w8I-2XFG;
	Thu, 22 Aug 2024 00:22:51 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 10/12] file.c: merge __{set,clear}_close_on_exec()
Date: Thu, 22 Aug 2024 01:22:48 +0100
Message-ID: <20240822002250.938396-10-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240822002250.938396-1-viro@zeniv.linux.org.uk>
References: <20240822002012.GM504335@ZenIV>
 <20240822002250.938396-1-viro@zeniv.linux.org.uk>
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
index 4fbd4e323f6c..61fb8994203f 100644
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
2.39.2


