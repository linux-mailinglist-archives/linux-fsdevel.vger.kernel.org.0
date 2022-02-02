Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BAB4A6E24
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 10:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245637AbiBBJwW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 04:52:22 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59782 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbiBBJwW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 04:52:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1DE5B8305A;
        Wed,  2 Feb 2022 09:52:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC82C004E1;
        Wed,  2 Feb 2022 09:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643795539;
        bh=zTsakfmHfwgjvVmFqIUX9q0PunPtBXLCKRNOE0Dd9zk=;
        h=From:To:Cc:Subject:Date:From;
        b=K4ZTLIXJcvnLRb+oi3YWXv9DVqGid8uBcr4p1QQHUTB5xeD3j9I1Ceo1M/5T2uMpN
         SqUz28iMfVn8Q3vnh9FHQW764mR9ILKSCI+PsgvBjap7V0t/2jO74NTnJMuSk3N4/B
         DazbZ8AgWPC46NJs9ZofcgrqTMj5AMxR+5u1z11I60kT9gewlpSDsKG8FmKOkYJ/Hq
         FAcF73UVSB+jaeb54uUzrcEGD40ZD30ywjF4b5NQGjtxaUdh27r83cvNepSeIJVCf/
         s27meK1UOrtygs913uq39GkzKvSy1L3ewxSEmi3NmbYTHITETBwCAfpiKbPek7ZM8v
         GA00RpncKXbhA==
From:   Christian Brauner <brauner@kernel.org>
To:     Eryu Guan <guan@eryu.me>, fstests@vger.kernel.org
Cc:     Ariadne Conill <ariadne@dereferenced.org>,
        Kees Cook <keescook@chromium.org>,
        Rich Felker <dalias@libc.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Laight <David.Laight@ACULAB.COM>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Eryu Guan <guaneryu@gmail.com>
Subject: [PATCH] generic/633: pass non-empty argv with execveat()
Date:   Wed,  2 Feb 2022 10:52:09 +0100
Message-Id: <20220202095209.2953458-1-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6733; h=from:subject; bh=zTsakfmHfwgjvVmFqIUX9q0PunPtBXLCKRNOE0Dd9zk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST+CjE9/+d32OF1jkdXGokpT/smUPZ6trRC9xlHb+O9bZbV 7KwJHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABN5k8HwV+rRk0jPYI9Nq+WksiZ7hb JlnhW/Wm3mOnODblOoRLDdQ4b/WYEin+92vOB5VL7lttPX2fVvhCQl+WOfKVUy8t6u/F/PCQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

So far the kernel allowed passing an empty argv. Given that there's now
a push to restrict the kernel in that regard make sure we pass at least
one argument with argv.

Cc: Ariadne Conill <ariadne@dereferenced.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Rich Felker <dalias@libc.org>
Cc: Eryu Guan <guaneryu@gmail.com>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Link: https://lore.kernel.org/lkml/20220127000724.15106-1-ariadne@dereferenced.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
/* v2 */
- Make sure argv array is NULL terminated. I fired the first patch too
  quickly.
- Take the chance and remove the repeated argv open-coding and move it
  directly into the execveat helper and rename it to reflect the fact
  that it's not just a simple syscall wrapper anymore.
---
 src/idmapped-mounts/idmapped-mounts.c | 65 +++++++++------------------
 1 file changed, 22 insertions(+), 43 deletions(-)

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index 4cf6c3bb..5bab19a9 100644
--- a/src/idmapped-mounts/idmapped-mounts.c
+++ b/src/idmapped-mounts/idmapped-mounts.c
@@ -695,11 +695,14 @@ static int fd_to_fd(int from, int to)
 	return 0;
 }
 
-static int sys_execveat(int fd, const char *path, char **argv, char **envp,
-			int flags)
+static int do_execveat(int fd, const char *path, char **envp)
 {
 #ifdef __NR_execveat
-	return syscall(__NR_execveat, fd, path, argv, envp, flags);
+	static char *argv_empty[] = {
+		"",
+		NULL,
+	};
+	return syscall(__NR_execveat, fd, path, argv_empty, envp, 0);
 #else
 	errno = ENOSYS;
 	return -1;
@@ -3597,15 +3600,12 @@ static int setid_binaries(void)
 			"EXPECTED_EGID=5000",
 			NULL,
 		};
-		static char *argv[] = {
-			NULL,
-		};
 
 		if (!expected_uid_gid(t_dir1_fd, FILE1, 0, 5000, 5000))
 			die("failure: expected_uid_gid");
 
-		sys_execveat(t_dir1_fd, FILE1, argv, envp, 0);
-		die("failure: sys_execveat");
+		do_execveat(t_dir1_fd, FILE1, envp);
+		die("failure: do_execveat");
 
 		exit(EXIT_FAILURE);
 	}
@@ -3725,15 +3725,12 @@ static int setid_binaries_idmapped_mounts(void)
 			"EXPECTED_EGID=15000",
 			NULL,
 		};
-		static char *argv[] = {
-			NULL,
-		};
 
 		if (!expected_uid_gid(open_tree_fd, FILE1, 0, 15000, 15000))
 			die("failure: expected_uid_gid");
 
-		sys_execveat(open_tree_fd, FILE1, argv, envp, 0);
-		die("failure: sys_execveat");
+		do_execveat(open_tree_fd, FILE1, envp);
+		die("failure: do_execveat");
 
 		exit(EXIT_FAILURE);
 	}
@@ -3864,9 +3861,6 @@ static int setid_binaries_idmapped_mounts_in_userns(void)
 			"EXPECTED_EGID=5000",
 			NULL,
 		};
-		static char *argv[] = {
-			NULL,
-		};
 
 		if (!switch_userns(attr.userns_fd, 0, 0, false))
 			die("failure: switch_userns");
@@ -3874,8 +3868,8 @@ static int setid_binaries_idmapped_mounts_in_userns(void)
 		if (!expected_uid_gid(open_tree_fd, FILE1, 0, 5000, 5000))
 			die("failure: expected_uid_gid");
 
-		sys_execveat(open_tree_fd, FILE1, argv, envp, 0);
-		die("failure: sys_execveat");
+		do_execveat(open_tree_fd, FILE1, envp);
+		die("failure: do_execveat");
 
 		exit(EXIT_FAILURE);
 	}
@@ -3923,9 +3917,6 @@ static int setid_binaries_idmapped_mounts_in_userns(void)
 			"EXPECTED_EGID=0",
 			NULL,
 		};
-		static char *argv[] = {
-			NULL,
-		};
 
 		if (!caps_supported()) {
 			log_debug("skip: capability library not installed");
@@ -3938,8 +3929,8 @@ static int setid_binaries_idmapped_mounts_in_userns(void)
 		if (!expected_uid_gid(open_tree_fd, FILE1, 0, 0, 0))
 			die("failure: expected_uid_gid");
 
-		sys_execveat(open_tree_fd, FILE1, argv, envp, 0);
-		die("failure: sys_execveat");
+		do_execveat(open_tree_fd, FILE1, envp);
+		die("failure: do_execveat");
 
 		exit(EXIT_FAILURE);
 	}
@@ -3991,9 +3982,6 @@ static int setid_binaries_idmapped_mounts_in_userns(void)
 			NULL,
 			NULL,
 		};
-		static char *argv[] = {
-			NULL,
-		};
 
 		if (!switch_userns(attr.userns_fd, 0, 0, false))
 			die("failure: switch_userns");
@@ -4007,8 +3995,8 @@ static int setid_binaries_idmapped_mounts_in_userns(void)
 		if (!expected_uid_gid(open_tree_fd, FILE1, 0, t_overflowuid, t_overflowgid))
 			die("failure: expected_uid_gid");
 
-		sys_execveat(open_tree_fd, FILE1, argv, envp, 0);
-		die("failure: sys_execveat");
+		do_execveat(open_tree_fd, FILE1, envp);
+		die("failure: do_execveat");
 
 		exit(EXIT_FAILURE);
 	}
@@ -4149,9 +4137,6 @@ static int setid_binaries_idmapped_mounts_in_userns_separate_userns(void)
 			"EXPECTED_EGID=5000",
 			NULL,
 		};
-		static char *argv[] = {
-			NULL,
-		};
 
 		userns_fd = get_userns_fd(0, 10000, 10000);
 		if (userns_fd < 0)
@@ -4163,8 +4148,8 @@ static int setid_binaries_idmapped_mounts_in_userns_separate_userns(void)
 		if (!expected_uid_gid(open_tree_fd, FILE1, 0, 5000, 5000))
 			die("failure: expected_uid_gid");
 
-		sys_execveat(open_tree_fd, FILE1, argv, envp, 0);
-		die("failure: sys_execveat");
+		do_execveat(open_tree_fd, FILE1, envp);
+		die("failure: do_execveat");
 
 		exit(EXIT_FAILURE);
 	}
@@ -4213,9 +4198,6 @@ static int setid_binaries_idmapped_mounts_in_userns_separate_userns(void)
 			"EXPECTED_EGID=0",
 			NULL,
 		};
-		static char *argv[] = {
-			NULL,
-		};
 
 		userns_fd = get_userns_fd(0, 10000, 10000);
 		if (userns_fd < 0)
@@ -4232,8 +4214,8 @@ static int setid_binaries_idmapped_mounts_in_userns_separate_userns(void)
 		if (!expected_uid_gid(open_tree_fd, FILE1, 0, 0, 0))
 			die("failure: expected_uid_gid");
 
-		sys_execveat(open_tree_fd, FILE1, argv, envp, 0);
-		die("failure: sys_execveat");
+		do_execveat(open_tree_fd, FILE1, envp);
+		die("failure: do_execveat");
 
 		exit(EXIT_FAILURE);
 	}
@@ -4285,9 +4267,6 @@ static int setid_binaries_idmapped_mounts_in_userns_separate_userns(void)
 			NULL,
 			NULL,
 		};
-		static char *argv[] = {
-			NULL,
-		};
 
 		userns_fd = get_userns_fd(0, 10000, 10000);
 		if (userns_fd < 0)
@@ -4305,8 +4284,8 @@ static int setid_binaries_idmapped_mounts_in_userns_separate_userns(void)
 		if (!expected_uid_gid(open_tree_fd, FILE1, 0, t_overflowuid, t_overflowgid))
 			die("failure: expected_uid_gid");
 
-		sys_execveat(open_tree_fd, FILE1, argv, envp, 0);
-		die("failure: sys_execveat");
+		do_execveat(open_tree_fd, FILE1, envp);
+		die("failure: do_execveat");
 
 		exit(EXIT_FAILURE);
 	}

base-commit: d8dee1222ecdfa1cff1386a61248e587eb3b275d
-- 
2.32.0

