Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2396355E9B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 18:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbiF1QaL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 12:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347724AbiF1Q3O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 12:29:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3E23A1A0;
        Tue, 28 Jun 2022 09:20:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7BAF7B81EF1;
        Tue, 28 Jun 2022 16:20:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF58C385A5;
        Tue, 28 Jun 2022 16:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656433204;
        bh=9pchgL8YFP3Hx5Q02p0k2JNpsUBkX+zukfrJ3q2OcKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O5fRq5RidSwRGjSy3tClru4NFzOywFU0UFX7DH9LUOrUQsivUbrDr2uT4moov+Kkx
         KWZvUES4e4R03/T5Uy4dCylqjBtpiBzNRvEuK3KI8e9039f9K97/lLdPsSTtbqexx/
         4+vPwqQ8gSnHBApZIsgu3qVvau8NRIi9Dn5/9x1L2cqqh/+N5OzZ4MnZe/hvKo5Jv9
         qJfFZPtGkGKXjZTtjlGTgGxgS2at0UEhleWIItaps/NFm4ZKWBpkMWJkh6ILYBQKj1
         cj1c//KDlTwBWma3mZ1YGIZK2Z4YMIh+TGEvzh4Fm6w8CWj5s1amo8A1Wtt0Rdx8yb
         4oJYwcD/CGTTA==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     KP Singh <kpsingh@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: [PATCH v5 bpf-next 5/5] bpf/selftests: Add a selftest for bpf_getxattr
Date:   Tue, 28 Jun 2022 16:19:48 +0000
Message-Id: <20220628161948.475097-6-kpsingh@kernel.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220628161948.475097-1-kpsingh@kernel.org>
References: <20220628161948.475097-1-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A simple test that adds an xattr on a copied /bin/ls and reads it back
when the copied ls is executed.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/xattr.c  | 54 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/xattr.c     | 37 +++++++++++++
 2 files changed, 91 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/xattr.c

diff --git a/tools/testing/selftests/bpf/prog_tests/xattr.c b/tools/testing/selftests/bpf/prog_tests/xattr.c
new file mode 100644
index 000000000000..ef07fa8a1763
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/xattr.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2022 Google LLC.
+ */
+
+#include <test_progs.h>
+#include <sys/xattr.h>
+#include "xattr.skel.h"
+
+#define XATTR_NAME "security.bpf"
+#define XATTR_VALUE "test_progs"
+
+void test_xattr(void)
+{
+	struct xattr *skel = NULL;
+	char tmp_dir_path[] = "/tmp/xattrXXXXXX";
+	char tmp_exec_path[64];
+	char cmd[256];
+	int err;
+
+	if (CHECK_FAIL(!mkdtemp(tmp_dir_path)))
+		goto close_prog;
+
+	snprintf(tmp_exec_path, sizeof(tmp_exec_path), "%s/copy_of_ls",
+		 tmp_dir_path);
+	snprintf(cmd, sizeof(cmd), "cp /bin/ls %s", tmp_exec_path);
+	if (CHECK_FAIL(system(cmd)))
+		goto close_prog_rmdir;
+
+	if (CHECK_FAIL(setxattr(tmp_exec_path, XATTR_NAME, XATTR_VALUE,
+			   sizeof(XATTR_VALUE), 0)))
+		goto close_prog_rmdir;
+
+	skel = xattr__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_load"))
+		goto close_prog_rmdir;
+
+	err = xattr__attach(skel);
+	if (!ASSERT_OK(err, "xattr__attach failed"))
+		goto close_prog_rmdir;
+
+	snprintf(cmd, sizeof(cmd), "%s -l", tmp_exec_path);
+	if (CHECK_FAIL(system(cmd)))
+		goto close_prog_rmdir;
+
+	ASSERT_EQ(skel->bss->result, 1, "xattr result");
+
+close_prog_rmdir:
+	snprintf(cmd, sizeof(cmd), "rm -rf %s", tmp_dir_path);
+	system(cmd);
+close_prog:
+	xattr__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/xattr.c b/tools/testing/selftests/bpf/progs/xattr.c
new file mode 100644
index 000000000000..ccc078fb8ebd
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/xattr.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2022 Google LLC.
+ */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+#define XATTR_NAME "security.bpf"
+#define XATTR_VALUE "test_progs"
+
+__u64 result = 0;
+
+extern ssize_t bpf_getxattr(struct dentry *dentry, struct inode *inode,
+			    const char *name, void *value, int size) __ksym;
+
+SEC("lsm.s/bprm_committed_creds")
+void BPF_PROG(bprm_cc, struct linux_binprm *bprm)
+{
+	struct task_struct *current = bpf_get_current_task_btf();
+	char dir_xattr_value[64] = {0};
+	int xattr_sz = 0;
+
+	xattr_sz = bpf_getxattr(bprm->file->f_path.dentry,
+				bprm->file->f_path.dentry->d_inode, XATTR_NAME,
+				dir_xattr_value, 64);
+
+	if (xattr_sz <= 0)
+		return;
+
+	if (!bpf_strncmp(dir_xattr_value, sizeof(XATTR_VALUE), XATTR_VALUE))
+		result = 1;
+}
-- 
2.37.0.rc0.161.g10f37bed90-goog

