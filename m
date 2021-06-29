Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471C53B7493
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 16:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbhF2Oqo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 10:46:44 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:43923 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbhF2Oql (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 10:46:41 -0400
Received: from orion.localdomain ([95.114.16.105]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M5fQq-1lr5IJ0XAg-0079Xu; Tue, 29 Jun 2021 16:44:01 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, info@metux.net, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 1/2] fs: allow filesystems to directly pass an existing struct file
Date:   Tue, 29 Jun 2021 16:43:40 +0200
Message-Id: <20210629144341.14313-2-info@metux.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210629144341.14313-1-info@metux.net>
References: <20210629144341.14313-1-info@metux.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:U1cKzRjF5/Cc7zdLkdSrQmqEuUB12G6Ac5LjGUSzu5I9jZsDllV
 x0MqYC+vK7rIWCsN/D/p2Ey8XjUddxjDarL4yXAxVk9wFeWmSvKe9ziknuU310I4MLH6wAC
 bJ6HVDLqgBH3YBjGtFQ92cTFZWHPLg7J/v/qe48XH6hAdrkjyqcOQFdMFGCZxJsV32y6aab
 lnqqFmFst/jQr+1I1QliA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yug8u5IEgzw=:zyH2cwSrnxNuhrOQRtcRBn
 ShbL3j8OZUiSs2ktkGApEdJul+tt0SZsnWWFnbM5PqhwuNCyoTLiYuvsNwKKcZCurzPGNRMcz
 IYIQNXvIUXp5M567ypy6nkNRRkh3EvOSm2hfshxjhKg3a0POmWt2/12R0dxdE2lojhwdapveW
 Pws4pAn1irB5iUlO47vREOAfCo5VEwc9ZrUUGBuXOLO4Cqzb/+ph8AD2/iekEo4edrqqQCvT9
 XwhqlVj2rpaXrj5c1S0IUr7WRNhE97pRuNdfKK3njwdSbnIL9W85gD6SB/J+EDGxMWyiurYWP
 12po2SYuX0h8gbPaHFUsA8Sh2id4qu7rkFSx7qveRBDAm6SYaMuFH+IPfllphJPOlfYdWq7rf
 dJiiNVP59rm9J0srd2iZIb1RBC/CFyFnLIyVpt0JC6k8aqf9nqarCEL3yahXaX272Fx3eRoL8
 uLcW9pqdUU+K7FJ60SbuE7Pb2dVecQY/AWhzy80zeeqn3fBRC8MIN4hKbe3YxffeQWCXfOjq3
 TuGp8eI0g3Tz8ifoL66eQ0=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In some scenarios, file systems might want to pass an already opened
struct file instance on an open() call, instead of opening a new one.

This allows similar techniques like the already well known file descriptor
passing via Unix domain sockets, but now also for plain open() calls.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 fs/Kconfig         |  3 +++
 fs/internal.h      |  6 ++++++
 fs/namei.c         |  2 +-
 fs/open.c          | 42 +++++++++++++++++++++++++++++++++++++++++-
 include/linux/fs.h |  9 +++++++++
 5 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index 141a856c50e7..b8b7a77b656c 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -357,4 +357,7 @@ source "fs/unicode/Kconfig"
 config IO_WQ
 	bool
 
+config FS_BOXED_FILE
+	bool
+
 endmenu
diff --git a/fs/internal.h b/fs/internal.h
index 6aeae7ef3380..e5e9cf038a24 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -142,6 +142,12 @@ int do_fchownat(int dfd, const char __user *filename, uid_t user, gid_t group,
 int chown_common(const struct path *path, uid_t user, gid_t group);
 extern int vfs_open(const struct path *, struct file *);
 
+#ifdef CONFIG_FS_BOXED_FILE
+extern struct file *unbox_file(struct file *);
+#else
+static inline struct file *unbox_file(struct file *f) { return f; }
+#endif
+
 /*
  * inode.c
  */
diff --git a/fs/namei.c b/fs/namei.c
index 79b0ff9b151e..b186d2d75b63 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3496,7 +3496,7 @@ static struct file *path_openat(struct nameidata *nd,
 	}
 	if (likely(!error)) {
 		if (likely(file->f_mode & FMODE_OPENED))
-			return file;
+			return unbox_file(file);
 		WARN_ON(1);
 		error = -EINVAL;
 	}
diff --git a/fs/open.c b/fs/open.c
index e53af13b5835..88daf09ffeb4 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -769,6 +769,46 @@ SYSCALL_DEFINE3(fchown, unsigned int, fd, uid_t, user, gid_t, group)
 	return ksys_fchown(fd, user, group);
 }
 
+#ifdef CONFIG_FS_BOXED_FILE
+/*
+ * Finish up an open procedure before returning the file to the caller.
+ * in case the the fs returns some unusual things like directly passing
+ * another file, this will be handled here.
+ *
+ * This function is only supposed to be called by functions like dentry_open()
+ * and path_openat() that allocate a new struct file and finally pass it to
+ * vfs_open() - the struct file should not have been used in any ways in the
+ * meantime, or unpleasant things may happen.
+ */
+struct file *unbox_file(struct file *f)
+{
+	struct file *boxed;
+
+	if (unlikely(!f))
+		return NULL;
+
+	if (IS_ERR(f))
+		return f;
+
+	if (likely(!f->boxed_file))
+		return f;
+
+	/* the fs returned another struct file (f->lower_file) that should be
+	   directly passed to our callers instead of the one that had been newly
+	   created for the open procedure.
+
+	   the lower_file is already ref'ed, so we keep the refcount.
+	   since the upper file (f) just had been opened, and no further access,
+	   we can just call fput() on it.
+	*/
+
+	boxed = f->boxed_file;
+	fput(f);
+
+	return boxed;
+}
+#endif /* CONFIG_FS_BOXED_FILE */
+
 static int do_dentry_open(struct file *f,
 			  struct inode *inode,
 			  int (*open)(struct inode *, struct file *))
@@ -959,7 +999,7 @@ struct file *dentry_open(const struct path *path, int flags,
 			f = ERR_PTR(error);
 		}
 	}
-	return f;
+	return unbox_file(f);
 }
 EXPORT_SYMBOL(dentry_open);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c3c88fdb9b2a..a778c5c057ab 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -955,6 +955,15 @@ struct file {
 	struct address_space	*f_mapping;
 	errseq_t		f_wb_err;
 	errseq_t		f_sb_err; /* for syncfs */
+
+#ifdef CONFIG_FS_BOXED_FILE
+	/* Only for file systems that wanna pass an *existing* file to the
+	   caller of open() instead of the newly created one. This has similar
+	   semantics like passing an fd via unix socket, but instead via some
+	   open() call.
+	*/
+	struct file		*boxed_file;
+#endif
 } __randomize_layout
   __attribute__((aligned(4)));	/* lest something weird decides that 2 is OK */
 
-- 
2.20.1

