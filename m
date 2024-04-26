Return-Path: <linux-fsdevel+bounces-17898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D06AE8B3887
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 15:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E1B91F237DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 13:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70D41487D1;
	Fri, 26 Apr 2024 13:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="ECoAuMMR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward200a.mail.yandex.net (forward200a.mail.yandex.net [178.154.239.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FC614831F;
	Fri, 26 Apr 2024 13:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714138466; cv=none; b=VOR1CgjutMlaMsZt3zP+cc/FpmkRxK0StUNbCHDmYw5fJiigcjnXHHjdlSCPanecE1bnaHLdSYoHy95f8optQXoFxrhyVLvR0riGjsdh7PZLptRJUXVtxBby3r/3UJiWIzykWW08+2/HFIg4M+/OX2GYpzmwWiKtq5CTV8/rogQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714138466; c=relaxed/simple;
	bh=NJLlv+BYrw+C+sbV2KvdymITp5TUT7pACIgIb4CZHl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N8vX3J58cHidIA2bcge4QkZchzZJ+AbZUrcs+yYg3HyP9uR2itenZJrLuNIrK1BUoEfEWvnq77X9uZF8sBZ0hwodYZW2EEMKH+lOgve91Ovf+rrjmUHcvyoZoYwD0t/bSQrM6yrvKN/O604S6rEQM5qkTpcWrUNct8A2zpFnwhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=ECoAuMMR; arc=none smtp.client-ip=178.154.239.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d101])
	by forward200a.mail.yandex.net (Yandex) with ESMTPS id 7AF1C66A43;
	Fri, 26 Apr 2024 16:34:16 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0d:230c:0:640:f8e:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id 8EFA360B53;
	Fri, 26 Apr 2024 16:34:08 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 2YN3P0DXnmI0-XlfhjaY2;
	Fri, 26 Apr 2024 16:34:06 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1714138446; bh=oe8bbNwOy9Cey4DMgLCWnxFN4lQ1FLTo4XG3E1C4v8Q=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=ECoAuMMRjRsRnHs1YWDcIiI84Zgj6ZrBSrBEhwjmClSLd/H74Kj3f9iLL0MLpNdOX
	 069WuQs8GyqfI7yU+T2IfDdn1aYqLeMAg/Ffxq2+hq8zN1sBe0GhbYlyMLV7qjA8CD
	 Xl0IpvfqDbE9Fnsay/URNI7VmN5Z4rJsgcHLons0=
Authentication-Results: mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Stas Sergeev <stsp2@yandex.ru>
To: linux-kernel@vger.kernel.org
Cc: Stas Sergeev <stsp2@yandex.ru>,
	Stefan Metzmacher <metze@samba.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andy Lutomirski <luto@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	David Laight <David.Laight@ACULAB.COM>,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-arch@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v5 2/3] open: add O_CRED_ALLOW flag
Date: Fri, 26 Apr 2024 16:33:09 +0300
Message-ID: <20240426133310.1159976-3-stsp2@yandex.ru>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240426133310.1159976-1-stsp2@yandex.ru>
References: <20240426133310.1159976-1-stsp2@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This flag prevents an fd from being passed via unix socket, and
makes it to be always closed on exec().
It is needed for the subsequent OA2_CRED_INHERIT addition, to work
as an "opt-in" for the new cred-inherit functionality. Without using
O_CRED_ALLOW when opening dir fd, it won't be possible to use
OA2_CRED_INHERIT on that dir fd.

Signed-off-by: Stas Sergeev <stsp2@yandex.ru>

CC: Eric Biederman <ebiederm@xmission.com>
CC: Alexander Viro <viro@zeniv.linux.org.uk>
CC: Christian Brauner <brauner@kernel.org>
CC: Jan Kara <jack@suse.cz>
CC: Andy Lutomirski <luto@kernel.org>
CC: David Laight <David.Laight@ACULAB.COM>
CC: Arnd Bergmann <arnd@arndb.de>
CC: "David S. Miller" <davem@davemloft.net>
CC: Eric Dumazet <edumazet@google.com>
CC: Jakub Kicinski <kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>
CC: Jens Axboe <axboe@kernel.dk>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>
CC: Pavel Begunkov <asml.silence@gmail.com>
CC: linux-arch@vger.kernel.org
CC: netdev@vger.kernel.org
CC: linux-fsdevel@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: linux-api@vger.kernel.org
---
 fs/fcntl.c                       |  2 +-
 fs/file.c                        | 15 ++++++++-------
 include/linux/fcntl.h            |  2 +-
 include/uapi/asm-generic/fcntl.h |  4 ++++
 net/core/scm.c                   |  5 +++++
 5 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 54cc85d3338e..78c96b1293c2 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -1039,7 +1039,7 @@ static int __init fcntl_init(void)
 	 * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
 	 * is defined as O_NONBLOCK on some platforms and not on others.
 	 */
-	BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=
+	BUILD_BUG_ON(22 - 1 /* for O_RDONLY being 0 */ !=
 		HWEIGHT32(
 			(VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
 			__FMODE_EXEC | __FMODE_NONOTIFY));
diff --git a/fs/file.c b/fs/file.c
index 3b683b9101d8..2a09d5276676 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -827,22 +827,23 @@ void do_close_on_exec(struct files_struct *files)
 	/* exec unshares first */
 	spin_lock(&files->file_lock);
 	for (i = 0; ; i++) {
+		int j;
 		unsigned long set;
 		unsigned fd = i * BITS_PER_LONG;
 		fdt = files_fdtable(files);
 		if (fd >= fdt->max_fds)
 			break;
 		set = fdt->close_on_exec[i];
-		if (!set)
-			continue;
 		fdt->close_on_exec[i] = 0;
-		for ( ; set ; fd++, set >>= 1) {
-			struct file *file;
-			if (!(set & 1))
-				continue;
-			file = fdt->fd[fd];
+		for (j = 0; j < BITS_PER_LONG; j++, fd++, set >>= 1) {
+			struct file *file = fdt->fd[fd];
 			if (!file)
 				continue;
+			/* Close all cred-allow files. */
+			if (file->f_flags & O_CRED_ALLOW)
+				set |= 1;
+			if (!(set & 1))
+				continue;
 			rcu_assign_pointer(fdt->fd[fd], NULL);
 			__put_unused_fd(files, fd);
 			spin_unlock(&files->file_lock);
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index a332e79b3207..e074ee9c1e36 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -10,7 +10,7 @@
 	(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | \
 	 O_APPEND | O_NDELAY | O_NONBLOCK | __O_SYNC | O_DSYNC | \
 	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
-	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
+	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE | O_CRED_ALLOW)
 
 /* List of all valid flags for the how->resolve argument: */
 #define VALID_RESOLVE_FLAGS \
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 80f37a0d40d7..ee8c2267c516 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -89,6 +89,10 @@
 #define __O_TMPFILE	020000000
 #endif
 
+#ifndef O_CRED_ALLOW
+#define O_CRED_ALLOW		040000000
+#endif
+
 /* a horrid kludge trying to make sure that this will fail on old kernels */
 #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
 
diff --git a/net/core/scm.c b/net/core/scm.c
index 9cd4b0a01cd6..f54fb0ee9727 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -111,6 +111,11 @@ static int scm_fp_copy(struct cmsghdr *cmsg, struct scm_fp_list **fplp)
 			fput(file);
 			return -EINVAL;
 		}
+		/* don't allow files with creds */
+		if (file->f_flags & O_CRED_ALLOW) {
+			fput(file);
+			return -EPERM;
+		}
 		if (unix_get_socket(file))
 			fpl->count_unix++;
 
-- 
2.44.0


