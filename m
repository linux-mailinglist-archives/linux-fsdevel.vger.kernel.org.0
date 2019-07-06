Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E30976116B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jul 2019 16:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfGFO7f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Jul 2019 10:59:35 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:34540 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726702AbfGFO7f (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Jul 2019 10:59:35 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 1C229A01B0;
        Sat,  6 Jul 2019 16:59:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id UYQQdEKKt3Aq; Sat,  6 Jul 2019 16:59:21 +0200 (CEST)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: [PATCH v9 04/10] namei: split out nd->dfd handling to dirfd_path_init
Date:   Sun,  7 Jul 2019 00:57:31 +1000
Message-Id: <20190706145737.5299-5-cyphar@cyphar.com>
In-Reply-To: <20190706145737.5299-1-cyphar@cyphar.com>
References: <20190706145737.5299-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Previously, path_init's handling of *at(dfd, ...) was only done once,
but with LOOKUP_BENEATH (and LOOKUP_IN_ROOT) we have to parse the
initial nd->path at different times (before or after absolute path
handling) depending on whether we have been asked to scope resolution
within a root.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 fs/namei.c | 103 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 59 insertions(+), 44 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 4895717d2760..b490bcf855f8 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2257,9 +2257,59 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 	}
 }
 
+/*
+ * Configure nd->path based on the nd->dfd. This is only used as part of
+ * path_init().
+ */
+static inline int dirfd_path_init(struct nameidata *nd)
+{
+	if (nd->dfd == AT_FDCWD) {
+		if (nd->flags & LOOKUP_RCU) {
+			struct fs_struct *fs = current->fs;
+			unsigned seq;
+
+			do {
+				seq = read_seqcount_begin(&fs->seq);
+				nd->path = fs->pwd;
+				nd->inode = nd->path.dentry->d_inode;
+				nd->seq = __read_seqcount_begin(&nd->path.dentry->d_seq);
+			} while (read_seqcount_retry(&fs->seq, seq));
+		} else {
+			get_fs_pwd(current->fs, &nd->path);
+			nd->inode = nd->path.dentry->d_inode;
+		}
+	} else {
+		/* Caller must check execute permissions on the starting path component */
+		struct fd f = fdget_raw(nd->dfd);
+		struct dentry *dentry;
+
+		if (!f.file)
+			return -EBADF;
+
+		dentry = f.file->f_path.dentry;
+
+		if (*nd->name->name && unlikely(!d_can_lookup(dentry))) {
+			fdput(f);
+			return -ENOTDIR;
+		}
+
+		nd->path = f.file->f_path;
+		if (nd->flags & LOOKUP_RCU) {
+			nd->inode = nd->path.dentry->d_inode;
+			nd->seq = read_seqcount_begin(&nd->path.dentry->d_seq);
+		} else {
+			path_get(&nd->path);
+			nd->inode = nd->path.dentry->d_inode;
+		}
+		fdput(f);
+	}
+	return 0;
+}
+
 /* must be paired with terminate_walk() */
 static const char *path_init(struct nameidata *nd, unsigned flags)
 {
+	int error;
 	const char *s = nd->name->name;
 
 	if (!*s)
@@ -2293,52 +2343,17 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 
 	nd->m_seq = read_seqbegin(&mount_lock);
 	if (*s == '/') {
-		set_root(nd);
-		if (likely(!nd_jump_root(nd)))
-			return s;
-		return ERR_PTR(-ECHILD);
-	} else if (nd->dfd == AT_FDCWD) {
-		if (flags & LOOKUP_RCU) {
-			struct fs_struct *fs = current->fs;
-			unsigned seq;
-
-			do {
-				seq = read_seqcount_begin(&fs->seq);
-				nd->path = fs->pwd;
-				nd->inode = nd->path.dentry->d_inode;
-				nd->seq = __read_seqcount_begin(&nd->path.dentry->d_seq);
-			} while (read_seqcount_retry(&fs->seq, seq));
-		} else {
-			get_fs_pwd(current->fs, &nd->path);
-			nd->inode = nd->path.dentry->d_inode;
-		}
-		return s;
-	} else {
-		/* Caller must check execute permissions on the starting path component */
-		struct fd f = fdget_raw(nd->dfd);
-		struct dentry *dentry;
-
-		if (!f.file)
-			return ERR_PTR(-EBADF);
-
-		dentry = f.file->f_path.dentry;
-
-		if (*s && unlikely(!d_can_lookup(dentry))) {
-			fdput(f);
-			return ERR_PTR(-ENOTDIR);
-		}
-
-		nd->path = f.file->f_path;
-		if (flags & LOOKUP_RCU) {
-			nd->inode = nd->path.dentry->d_inode;
-			nd->seq = read_seqcount_begin(&nd->path.dentry->d_seq);
-		} else {
-			path_get(&nd->path);
-			nd->inode = nd->path.dentry->d_inode;
-		}
-		fdput(f);
+		if (likely(!nd->root.mnt))
+			set_root(nd);
+		error = nd_jump_root(nd);
+		if (unlikely(error))
+			s = ERR_PTR(error);
 		return s;
 	}
+	error = dirfd_path_init(nd);
+	if (unlikely(error))
+		return ERR_PTR(error);
+	return s;
 }
 
 static const char *trailing_symlink(struct nameidata *nd)
-- 
2.22.0

