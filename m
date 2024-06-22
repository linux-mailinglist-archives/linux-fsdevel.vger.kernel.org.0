Return-Path: <linux-fsdevel+bounces-22174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B78DB91331C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jun 2024 13:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69936285681
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jun 2024 11:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D277514F106;
	Sat, 22 Jun 2024 11:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="laPrQx36"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA131E871;
	Sat, 22 Jun 2024 11:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719054040; cv=none; b=Bwd1EFOzDXo5KQzO+QmcZ/w22P+8PJsiuCskWg1rjDymRMXkPXksGCG1miozhxxaMP5JpVOLmqT6c2//Sib0ywTJZigJOc2IyIkzuvI1Oydoc2s2QD64NnHOzc92rGSZbv5GtneTXAstkC4abV2gGpwsxKKfWuJjx/zpV4OaO1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719054040; c=relaxed/simple;
	bh=jZKMMHb1Scf+LoA5wMQap4Hh2SvydY9wTa+sLKebS1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t9a433ECgg7e8gAlbISI8V9KxoIEX6vk+ysMZxInYRX1Zn18NFqSEflrF0l+fgDL/DHqSE1x0/zJff3MiXHsR1hSYBGSqwPcM+i85OUEhIoNdjdUwEDmT1gRhgWePjnINDLSL89oNgtVfgzUYOrSwG46XwMvSQBI2DGCftKCaGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=laPrQx36; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1719054029;
	bh=jZKMMHb1Scf+LoA5wMQap4Hh2SvydY9wTa+sLKebS1Y=;
	h=From:To:Cc:Subject:Date:From;
	b=laPrQx36mxewqlSzNXdvqDIS29piPKgu9336MrbdIgNT3WC5NA0Ro9IxsDcNlLi+t
	 P8WlXAIWI/x2Ns7ydjjjK8xZuiQFT62TB997/iP50gl2OGi3nNPJREndIzqzd1ZRpG
	 7y7wx8028ms1cyGDyraw3wKfWcAHy34wrTs/AmPc=
Received: from stargazer.. (unknown [113.200.174.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 9093F67186;
	Sat, 22 Jun 2024 07:00:25 -0400 (EDT)
From: Xi Ruoyao <xry111@xry111.site>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Xi Ruoyao <xry111@xry111.site>,
	Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alejandro Colomar <alx@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Icenowy Zheng <uwu@icenowy.me>,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vfs: Add AT_EMPTY_PATH_NOCHECK as unchecked AT_EMPTY_PATH
Date: Sat, 22 Jun 2024 18:56:08 +0800
Message-ID: <20240622105621.7922-1-xry111@xry111.site>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's cheap to check if the path is empty in the userspace, but expensive
to check if a userspace string is empty from the kernel.  So using statx
and AT_EMPTY_PATH to implement fstat is slower than a "native" fstat
call.  But for arch/loongarch fstat does not exist so we have to use
statx, and on all 32-bit architectures we must use statx after 2037.
And seccomp also cannot audit AT_EMPTY_PATH properly because it cannot
check if path is empty.

To resolve these issues, add a relaxed version of AT_EMPTY_PATH: it does
not check if the path is empty, but just assumes the path is empty and
then behaves like AT_EMPTY_PATH.

Link: https://sourceware.org/pipermail/libc-alpha/2023-September/151364.html
Link: https://lore.kernel.org/loongarch/599df4a3-47a4-49be-9c81-8e21ea1f988a@xen0n.name/
Cc: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Alejandro Colomar <alx@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Huacai Chen <chenhuacai@loongson.cn>
Cc: Xuerui Wang <kernel@xen0n.name>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Icenowy Zheng <uwu@icenowy.me>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: loongarch@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 fs/namei.c                 | 8 +++++++-
 fs/stat.c                  | 4 +++-
 include/linux/namei.h      | 4 ++++
 include/trace/misc/fs.h    | 1 +
 include/uapi/linux/fcntl.h | 3 +++
 5 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 37fb0a8aa09a..0c44a7ea5961 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -147,7 +147,13 @@ getname_flags(const char __user *filename, int flags, int *empty)
 	kname = (char *)result->iname;
 	result->name = kname;
 
-	len = strncpy_from_user(kname, filename, EMBEDDED_NAME_MAX);
+	if (!(flags & LOOKUP_EMPTY_NOCHECK))
+		len = strncpy_from_user(kname, filename, EMBEDDED_NAME_MAX);
+	else {
+		len = 0;
+		kname[0] = '\0';
+	}
+
 	if (unlikely(len < 0)) {
 		__putname(result);
 		return ERR_PTR(len);
diff --git a/fs/stat.c b/fs/stat.c
index 70bd3e888cfa..53944d3287cd 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -210,6 +210,8 @@ int getname_statx_lookup_flags(int flags)
 		lookup_flags |= LOOKUP_AUTOMOUNT;
 	if (flags & AT_EMPTY_PATH)
 		lookup_flags |= LOOKUP_EMPTY;
+	if (flags & AT_EMPTY_PATH_NOCHECK)
+		lookup_flags |= LOOKUP_EMPTY | LOOKUP_EMPTY_NOCHECK;
 
 	return lookup_flags;
 }
@@ -237,7 +239,7 @@ static int vfs_statx(int dfd, struct filename *filename, int flags,
 	int error;
 
 	if (flags & ~(AT_SYMLINK_NOFOLLOW | AT_NO_AUTOMOUNT | AT_EMPTY_PATH |
-		      AT_STATX_SYNC_TYPE))
+		      AT_STATX_SYNC_TYPE | AT_EMPTY_PATH_NOCHECK))
 		return -EINVAL;
 
 retry:
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 967aa9ea9f96..def6a8a1b531 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -45,9 +45,13 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
 #define LOOKUP_IN_ROOT		0x100000 /* Treat dirfd as fs root. */
 #define LOOKUP_CACHED		0x200000 /* Only do cached lookup */
 #define LOOKUP_LINKAT_EMPTY	0x400000 /* Linkat request with empty path. */
+
 /* LOOKUP_* flags which do scope-related checks based on the dirfd. */
 #define LOOKUP_IS_SCOPED (LOOKUP_BENEATH | LOOKUP_IN_ROOT)
 
+/* If this is set, LOOKUP_EMPTY must be set as well. */
+#define LOOKUP_EMPTY_NOCHECK	0x800000 /* Consider path empty. */
+
 extern int path_pts(struct path *path);
 
 extern int user_path_at_empty(int, const char __user *, unsigned, struct path *, int *empty);
diff --git a/include/trace/misc/fs.h b/include/trace/misc/fs.h
index 738b97f22f36..24aec7ed6b0b 100644
--- a/include/trace/misc/fs.h
+++ b/include/trace/misc/fs.h
@@ -119,4 +119,5 @@
 		{ LOOKUP_NO_XDEV,	"NO_XDEV" }, \
 		{ LOOKUP_BENEATH,	"BENEATH" }, \
 		{ LOOKUP_IN_ROOT,	"IN_ROOT" }, \
+		{ LOOKUP_EMPTY_NOCHECK,	"EMPTY_NOCHECK" }, \
 		{ LOOKUP_CACHED,	"CACHED" })
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index c0bcc185fa48..aa2f68d80820 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -113,6 +113,9 @@
 #define AT_STATX_DONT_SYNC	0x4000	/* - Don't sync attributes with the server */
 
 #define AT_RECURSIVE		0x8000	/* Apply to the entire subtree */
+#define AT_EMPTY_PATH_NOCHECK	0x10000	/* Like AT_EMPTY_PATH, but the path
+                                           is not checked and it's just
+                                           assumed to be empty */
 
 /* Flags for name_to_handle_at(2). We reuse AT_ flag space to save bits... */
 #define AT_HANDLE_FID		AT_REMOVEDIR	/* file handle is needed to
-- 
2.45.2


