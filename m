Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9431E29057A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 14:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407859AbgJPMqZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Oct 2020 08:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407829AbgJPMqC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Oct 2020 08:46:02 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D664C0613D5
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2020 05:46:01 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t18so1235449plo.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2020 05:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pSm/g0kqVjlpnCUrgMA34WIyplgwS/+jMYU+gRHVlgw=;
        b=yEtWgvz7p6jYnSHOfZ8SZ61XE6LNnfmjHq2tgg4W0HalfMsdO1fu7hLigiTmd3cPa1
         Epme0Xmw7MhQIRTFwtwNQ10nfw/43wDopvOLVJfhEnYYQoSzBKcpSAzeFuEvB85Lc0Nk
         IvaYD1A9N8146rLQPS6tGDPB4ns6JbD79//oY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pSm/g0kqVjlpnCUrgMA34WIyplgwS/+jMYU+gRHVlgw=;
        b=Qo0VscQ/38FYbNT4SvN65kE0uzbRgoseZDwMhNSfKkBNREfZnAxsZKmqw7JnFtwDxC
         7qdvyq3jZFGE7Mn90+G//MuPHPTVqYQ2Y8njdtUQNpBrKWImDkEO8uFzmYJ4vxeD9dbW
         0n8UNe62GEOZ9VONeBmGo3T5rqxUl1DakM7RMY8a4SPN4gWqpnAbtcUdamlqX42CCv43
         LbR0ENl+pZYO/GQX1vk3Pc0GGIwd1F70DWCM0QPYkpcAEMY9EgtzI3LJOuKYoDMf5hsL
         bYG6n7pd8mQMH+bcM+rfBhWM2vApkHAs8Ay+NWc0+05Dcs8FLlu/HE5ADU7w8kKIJmMN
         DyDg==
X-Gm-Message-State: AOAM533djrInRL9gAiLwaXsb8VIDQ3/HiB3r6N0MiDpGbj1RpdT5MAti
        FFrYOranM8HWPQQ7BvUxBmtBjQ==
X-Google-Smtp-Source: ABdhPJwopKhTcd5efvly6yqdL5APFJcFTFOl+PUbxxo8hSB6Y5ASyHdEt4/NsC+tZyTziioLvOti8Q==
X-Received: by 2002:a17:90b:3109:: with SMTP id gc9mr3917023pjb.74.1602852360786;
        Fri, 16 Oct 2020 05:46:00 -0700 (PDT)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id q123sm2906732pfq.56.2020.10.16.05.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 05:46:00 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     "J . Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        David Howells <dhowells@redhat.com>
Cc:     Sargun Dhillon <sargun@sargun.me>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kyle Anderson <kylea@netflix.com>
Subject: [RESEND PATCH v2 3/3] samples/vfs: Add example leveraging NFS with new APIs and user namespaces
Date:   Fri, 16 Oct 2020 05:45:50 -0700
Message-Id: <20201016124550.10739-4-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201016124550.10739-1-sargun@sargun.me>
References: <20201016124550.10739-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds an example which assumes you already have an NFS server setup,
but does the work of creating a user namespace, and an NFS mount from
that user namespace which then exposes different UIDs than that of
the init user namespace.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Cc: J. Bruce Fields <bfields@fieldses.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Anna Schumaker <anna.schumaker@netapp.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Kyle Anderson <kylea@netflix.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c |   1 +
 samples/vfs/.gitignore                 |   2 +
 samples/vfs/Makefile                   |   3 +-
 samples/vfs/test-nfs-userns.c          | 181 +++++++++++++++++++++++++
 4 files changed, 186 insertions(+), 1 deletion(-)
 create mode 100644 samples/vfs/test-nfs-userns.c

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index f9348ed1bcda..ee45ff7d75ac 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -361,6 +361,7 @@ ff_layout_alloc_lseg(struct pnfs_layout_hdr *lh,
 		     struct nfs4_layoutget_res *lgr,
 		     gfp_t gfp_flags)
 {
+	struct user_namespace *user_ns = lh->plh_lc_cred->user_ns;
 	struct pnfs_layout_segment *ret;
 	struct nfs4_ff_layout_segment *fls = NULL;
 	struct xdr_stream stream;
diff --git a/samples/vfs/.gitignore b/samples/vfs/.gitignore
index 8fdabf7e5373..1d09826b31a6 100644
--- a/samples/vfs/.gitignore
+++ b/samples/vfs/.gitignore
@@ -1,3 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 test-fsmount
 test-statx
+test-nfs-userns
+
diff --git a/samples/vfs/Makefile b/samples/vfs/Makefile
index 7f76875eaa70..6a2926080c08 100644
--- a/samples/vfs/Makefile
+++ b/samples/vfs/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 test-fsmount-objs := test-fsmount.o vfs-helper.o
-userprogs := test-fsmount test-statx
+test-nfs-userns-objs := test-nfs-userns.o vfs-helper.o
+userprogs := test-fsmount test-statx test-nfs-userns
 
 always-y := $(userprogs)
 
diff --git a/samples/vfs/test-nfs-userns.c b/samples/vfs/test-nfs-userns.c
new file mode 100644
index 000000000000..108af924cbdd
--- /dev/null
+++ b/samples/vfs/test-nfs-userns.c
@@ -0,0 +1,181 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <linux/unistd.h>
+#include <assert.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <errno.h>
+#include <sys/stat.h>
+#include <stdlib.h>
+#include <sys/socket.h>
+#include <string.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <sys/prctl.h>
+#include <sys/wait.h>
+#include "vfs-helper.h"
+
+
+#define WELL_KNOWN_FD	100
+
+static inline int pidfd_open(pid_t pid, unsigned int flags)
+{
+	return syscall(__NR_pidfd_open, pid, flags);
+}
+
+static inline int pidfd_getfd(int pidfd, int fd, int flags)
+{
+	return syscall(__NR_pidfd_getfd, pidfd, fd, flags);
+}
+
+static void write_to_path(const char *path, const char *str)
+{
+	int fd, len = strlen(str);
+
+	fd = open(path, O_WRONLY);
+	if (fd < 0) {
+		fprintf(stderr, "Can't open %s: %s\n", path, strerror(errno));
+		exit(1);
+	}
+
+	if (write(fd, str, len) != len) {
+		fprintf(stderr, "Can't write string: %s\n", strerror(errno));
+		exit(1);
+	}
+
+	E(close(fd));
+}
+
+static int do_work(int sk)
+{
+	int fsfd;
+
+	E(unshare(CLONE_NEWNS|CLONE_NEWUSER));
+
+	fsfd = fsopen("nfs4", 0);
+	E(fsfd);
+
+	E(send(sk, &fsfd, sizeof(fsfd), 0));
+	// Wait for the other side to close / finish / wrap up
+	recv(sk, &fsfd, sizeof(fsfd), 0);
+	E(close(sk));
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	int pidfd, mntfd, fsfd, fsfdnum, status, sk_pair[2];
+	struct statx statxbuf;
+	char buf[1024];
+	pid_t pid;
+
+	if (mkdir("/mnt/share", 0777) && errno != EEXIST) {
+		perror("mkdir");
+		return 1;
+	}
+
+	E(chmod("/mnt/share", 0777));
+
+	if (mkdir("/mnt/nfs", 0755) && errno != EEXIST) {
+		perror("mkdir");
+		return 1;
+	}
+
+	if (unlink("/mnt/share/newfile") && errno != ENOENT) {
+		perror("unlink");
+		return 1;
+	}
+
+	E(creat("/mnt/share/testfile", 0644));
+	E(chown("/mnt/share/testfile", 1001, 1001));
+
+	/* exportfs is idempotent, but expects nfs-server to be running */
+	if (system("exportfs -o no_root_squash,no_subtree_check,rw 127.0.0.0/8:/mnt/share")) {
+		fprintf(stderr,
+			"Could not export /mnt/share. Is NFS the server running?\n");
+		return 1;
+	}
+
+	E(socketpair(PF_LOCAL, SOCK_SEQPACKET, 0, sk_pair));
+
+	pid = fork();
+	E(pid);
+	if (pid == 0) {
+		E(close(sk_pair[0]));
+		return do_work(sk_pair[1]);
+	}
+
+	E(close(sk_pair[1]));
+
+	pidfd = pidfd_open(pid, 0);
+	E(pidfd);
+
+	E(recv(sk_pair[0], &fsfdnum, sizeof(fsfdnum), 0));
+
+	fsfd = pidfd_getfd(pidfd, fsfdnum, 0);
+	if (fsfd == -1) {
+		perror("pidfd_getfd");
+		return 1;
+	}
+
+
+	snprintf(buf, sizeof(buf) - 1, "/proc/%d/uid_map", pid);
+	write_to_path(buf, "0 1000 2");
+	snprintf(buf, sizeof(buf) - 1, "/proc/%d/setgroups", pid);
+	write_to_path(buf, "deny");
+	snprintf(buf, sizeof(buf) - 1, "/proc/%d/gid_map", pid);
+	write_to_path(buf, "0 1000 2");
+
+	/* Now we can proceed to mount */
+	E_fsconfig(fsfd, FSCONFIG_SET_STRING, "vers", "4.1", 0);
+	E_fsconfig(fsfd, FSCONFIG_SET_STRING, "clientaddr", "127.0.0.1", 0);
+	E_fsconfig(fsfd, FSCONFIG_SET_STRING, "addr", "127.0.0.1", 0);
+	E_fsconfig(fsfd, FSCONFIG_SET_STRING, "source", "127.0.0.1:/mnt/share",
+		   0);
+	E_fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
+
+	/* Move into the namespace's of the worker */
+	E(setns(pidfd, CLONE_NEWNS|CLONE_NEWUSER));
+	E(close(pidfd));
+
+	/* Close our socket pair indicating the child should exit */
+	E(close(sk_pair[0]));
+	assert(waitpid(pid, &status, 0) == pid);
+	if (!WIFEXITED(status) || WEXITSTATUS(status)) {
+		fprintf(stderr, "worker exited nonzero\n");
+		return 1;
+	}
+
+	E(setuid(0));
+	E(setgid(0));
+
+	/* Now do all the work of moving doing the mount in the child ns */
+	E(syscall(__NR_mount, NULL, "/", NULL, MS_REC|MS_PRIVATE, NULL));
+
+	mntfd = fsmount(fsfd, 0, MS_NODEV);
+	if (mntfd < 0) {
+		E(close(fsfd));
+		mount_error(fsfd, "fsmount");
+	}
+
+	E(move_mount(mntfd, "", AT_FDCWD, "/mnt/nfs", MOVE_MOUNT_F_EMPTY_PATH));
+	E(close(mntfd));
+
+	/* Create the file through NFS */
+	E(creat("/mnt/nfs/newfile", 0644));
+	/* Check what the file's status is on the disk, accessed directly */
+	E(statx(AT_FDCWD, "/mnt/share/newfile", 0, STATX_UID|STATX_GID,
+		&statxbuf));
+	assert(statxbuf.stx_uid == 0);
+	assert(statxbuf.stx_gid == 0);
+
+	E(statx(AT_FDCWD, "/mnt/nfs/testfile", 0, STATX_UID|STATX_GID,
+		&statxbuf));
+	assert(statxbuf.stx_uid == 1);
+	assert(statxbuf.stx_gid == 1);
+
+
+	return 0;
+}
-- 
2.25.1

