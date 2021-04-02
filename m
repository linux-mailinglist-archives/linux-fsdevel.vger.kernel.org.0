Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BADC352AB8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Apr 2021 14:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235441AbhDBMhY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Apr 2021 08:37:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:53622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235444AbhDBMhW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Apr 2021 08:37:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DBDB561158;
        Fri,  2 Apr 2021 12:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617367041;
        bh=H6rhK7YrJlG/TnSxkRrxaV6rrHER++o1pLWVgVT/hFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mwQQARNS0037UZK89bxhtfJS0qxf3bmbfYK+TSZ2aszVj1R0CFT5JWFSJa+408xbU
         LduHUJs3023xhEbFZhCn9rWliymuJQihvvlT/k4PyYw/dVN7so8BbUicQxSYGHqjpJ
         yxPiGwKCz0d0/Eu7M3+QqU+oAwyvEDgvnc/XhMgLJ1uxl69N1AKaXGL40+mNnPjcwQ
         LFpJJ+nr4QGnfFXH6RhXc0kaeXLdo5IXiKKUNnfRLYZJPmjLDnQe+p7vAdgblMxPj7
         TAa8toiH/NVpeHJnh//typ7l7XiZAYoQU6/FgIBSJxxofEGYeleXfhb+bY1MkoiQwA
         k3MHO07+sRL/w==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>,
        Giuseppe Scrivano <gscrivan@redhat.com>
Subject: [PATCH 2/3] file: let pick_file() tell caller it's done
Date:   Fri,  2 Apr 2021 14:35:47 +0200
Message-Id: <20210402123548.108372-3-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <00000000000069c40405be6bdad4@google.com>
References: <00000000000069c40405be6bdad4@google.com>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=u3FypIfYYEuouoQtFnkkSF1BaueP8r/+poOiz25rjy0=; m=XxDs1iQXFGporBJagccdLRPprhMJ0YTgd0CCqHCv/W0=; p=1aFtf2Ns3INd5B6Bg/dGOcnyrKqqA2iROlkVMFoo6vQ=; g=08c35118ac0e088c52bdd2f77bea1f7f51a1a5e2
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYGcPkgAKCRCRxhvAZXjcojxNAPsGKlX WDUEjrlXQwYn36lKSceQnpjvrryk0HoPfwLIR8AD+JW8wb+JEIELp2e+5u4hkMuWqLAgTWIgHDw4/ akXT3wE=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Let pick_file() report back that the fd it was passed exceeded the
maximum fd in that fdtable. This allows us to simplify the caller of
this helper because it doesn't need to care anymore whether the passed
in max_fd is excessive. It can rely on pick_file() telling it that it's
past the last valid fd.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/file.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index f633348029a5..740040346a98 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -596,18 +596,32 @@ void fd_install(unsigned int fd, struct file *file)
 
 EXPORT_SYMBOL(fd_install);
 
+/**
+ * pick_file - return file associatd with fd
+ * @files: file struct to retrieve file from
+ * @fd: file descriptor to retrieve file for
+ *
+ * If this functions returns an EINVAL error pointer the fd was beyond the
+ * current maximum number of file descriptors for that fdtable.
+ *
+ * Returns: The file associated with @fd, on error returns an error pointer.
+ */
 static struct file *pick_file(struct files_struct *files, unsigned fd)
 {
-	struct file *file = NULL;
+	struct file *file;
 	struct fdtable *fdt;
 
 	spin_lock(&files->file_lock);
 	fdt = files_fdtable(files);
-	if (fd >= fdt->max_fds)
+	if (fd >= fdt->max_fds) {
+		file = ERR_PTR(-EINVAL);
 		goto out_unlock;
+	}
 	file = fdt->fd[fd];
-	if (!file)
+	if (!file) {
+		file = ERR_PTR(-EBADF);
 		goto out_unlock;
+	}
 	rcu_assign_pointer(fdt->fd[fd], NULL);
 	__put_unused_fd(files, fd);
 
@@ -622,7 +636,7 @@ int close_fd(unsigned fd)
 	struct file *file;
 
 	file = pick_file(files, fd);
-	if (!file)
+	if (IS_ERR(file))
 		return -EBADF;
 
 	return filp_close(file, files);
@@ -663,11 +677,16 @@ static inline void __range_close(struct files_struct *cur_fds, unsigned int fd,
 		struct file *file;
 
 		file = pick_file(cur_fds, fd++);
-		if (!file)
+		if (!IS_ERR(file)) {
+			/* found a valid file to close */
+			filp_close(file, cur_fds);
+			cond_resched();
 			continue;
+		}
 
-		filp_close(file, cur_fds);
-		cond_resched();
+		/* beyond the last fd in that table */
+		if (PTR_ERR(file) == -EINVAL)
+			return;
 	}
 }
 
-- 
2.27.0

