Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61138457B60
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Nov 2021 05:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236905AbhKTEyd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 23:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236932AbhKTExn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 23:53:43 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2B0C061759
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Nov 2021 20:50:29 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 18-20020a631352000000b00320e714912bso98230pgt.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Nov 2021 20:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uvNIfQ2xPxMosCuaZIYF62oO8SwPg1ICTimCdNTm9Vg=;
        b=kkr7HoN4DfwCs24jlS1zFyDomRuE632ceq1FIOuLPKkP5rbmQpiVF2QlY4VWdBv3f1
         gmqzsT2J6RO1wFTt8ELRkyFxE7vOyk00zgiJmcI++BCKPDYfxgEBhj05WQ7P+HSAClIG
         uf73/EDXzDcXIsjYc7JgHddA0schC1QFC2zw8I9Et5IeYM5W24UkLIAMwTAZzYEdWFht
         2+fTz1sSwLrbVTLMUTAkfO39C3FXugos8dhvkeoTBA7tZIIqyRvWvhn/IjKZR6i5U+/j
         KHdrJPbo07RKeWEdjCMuyNp0MrsGP8F03eJKk+Km8ZFWfPBXNC9PKlY4qEgXEmdbL8PO
         gdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uvNIfQ2xPxMosCuaZIYF62oO8SwPg1ICTimCdNTm9Vg=;
        b=xt9bKV8pWhFfyrn5vl42cfOg1a3RAH3cLhTNVfUTQ97S/7AFQb37fY2LKVY5sX0EnK
         6JbxrjPY+ibaFhU3KRWQympQ54D3Edr11LyLG9CEpIeRjza6QEVZZH+7kcSwyP0G9kjG
         FH0EsCMuT+ydS9lLH+lb7VWFvJZBiO6H1Dc9MuJ8VxKm1MV7wHtzr5PB29Qrqcmxtu+c
         GMBcC4PgsbEo2dwv1uIJ7sZDC6tJWy1RKakq2lOx7mX6TTpDiZqt9OENBqh/SGESDhyK
         eCKl6KeVHpreQu0PCp2pBRJNmM+eoFxGexTkwuKCGLb2AEVppx0mmxaNmTOvb8iPgOiu
         beug==
X-Gm-Message-State: AOAM530h/TdOTD/ZiW14nakOFVbKP+owrUwfPMXhWjyWRwbVXf7IChpw
        Adw72RUk9m3zttkp9hxtGRWxnEMeWtGYsScNew==
X-Google-Smtp-Source: ABdhPJxznMEO7QjA++HmqkjBv2dw1jatuQ8Xo0MBwxe+EG5+/zYigHZk1KISXWqJLlEm4pkIXaY6ZL25E8kDU4UWTA==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2cd:202:fa91:560a:d7b4:93])
 (user=almasrymina job=sendgmr) by 2002:a17:90a:c78f:: with SMTP id
 gn15mr6699081pjb.54.1637383828674; Fri, 19 Nov 2021 20:50:28 -0800 (PST)
Date:   Fri, 19 Nov 2021 20:50:10 -0800
In-Reply-To: <20211120045011.3074840-1-almasrymina@google.com>
Message-Id: <20211120045011.3074840-5-almasrymina@google.com>
Mime-Version: 1.0
References: <20211120045011.3074840-1-almasrymina@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v4 4/4] mm, shmem, selftests: add tmpfs memcg= mount option tests
From:   Mina Almasry <almasrymina@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Mina Almasry <almasrymina@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Roman Gushchin <guro@fb.com>, "Theodore Ts'o" <tytso@mit.edu>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

- Test mounting and remounting with memcg= succeeds.
- Test that simple writes in this file system are charged to the correct
  memecg.
- Test that on non-pagefault paths the calling process gets an ENOSPC.
- Test that in pagefault paths the calling process gets a SIGBUS.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---

Changes in v4:

- Convert tests to expect ENOSPC/SIGBUS rather than ENOMEM oom behavior.
- Added remount test.

---
 tools/testing/selftests/vm/.gitignore     |   1 +
 tools/testing/selftests/vm/mmap_write.c   | 103 +++++++++++++++++++
 tools/testing/selftests/vm/tmpfs-memcg.sh | 116 ++++++++++++++++++++++
 3 files changed, 220 insertions(+)
 create mode 100644 tools/testing/selftests/vm/mmap_write.c
 create mode 100755 tools/testing/selftests/vm/tmpfs-memcg.sh

diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftests/vm/.gitignore
index 2e7e86e852828..cb229974c5f15 100644
--- a/tools/testing/selftests/vm/.gitignore
+++ b/tools/testing/selftests/vm/.gitignore
@@ -19,6 +19,7 @@ madv_populate
 userfaultfd
 mlock-intersect-test
 mlock-random-test
+mmap_write
 virtual_address_range
 gup_test
 va_128TBswitch
diff --git a/tools/testing/selftests/vm/mmap_write.c b/tools/testing/selftests/vm/mmap_write.c
new file mode 100644
index 0000000000000..88a8468f2128c
--- /dev/null
+++ b/tools/testing/selftests/vm/mmap_write.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This program faults memory in tmpfs
+ */
+
+#include <err.h>
+#include <errno.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <sys/types.h>
+#include <sys/shm.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+
+/* Global definitions. */
+
+/* Global variables. */
+static const char *self;
+static char *shmaddr;
+static int shmid;
+
+/*
+ * Show usage and exit.
+ */
+static void exit_usage(void)
+{
+	printf("Usage: %s -p <path to tmpfs file> -s <size to map>\n", self);
+	exit(EXIT_FAILURE);
+}
+
+int main(int argc, char **argv)
+{
+	int fd = 0;
+	int key = 0;
+	int *ptr = NULL;
+	int c = 0;
+	int size = 0;
+	char path[256] = "";
+	int want_sleep = 0, private = 0;
+	int populate = 0;
+	int write = 0;
+	int reserve = 1;
+
+	/* Parse command-line arguments. */
+	setvbuf(stdout, NULL, _IONBF, 0);
+	self = argv[0];
+
+	while ((c = getopt(argc, argv, ":s:p:")) != -1) {
+		switch (c) {
+		case 's':
+			size = atoi(optarg);
+			break;
+		case 'p':
+			strncpy(path, optarg, sizeof(path));
+			break;
+		default:
+			errno = EINVAL;
+			perror("Invalid arg");
+			exit_usage();
+		}
+	}
+
+	printf("%s\n", path);
+	if (strncmp(path, "", sizeof(path)) != 0) {
+		printf("Writing to this path: %s\n", path);
+	} else {
+		errno = EINVAL;
+		perror("path not found");
+		exit_usage();
+	}
+
+	if (size != 0) {
+		printf("Writing this size: %d\n", size);
+	} else {
+		errno = EINVAL;
+		perror("size not found");
+		exit_usage();
+	}
+
+	fd = open(path, O_CREAT | O_RDWR, 0777);
+	if (fd == -1)
+		err(1, "Failed to open file.");
+
+	if (ftruncate(fd, size))
+		err(1, "failed to ftruncate %s", path);
+
+	ptr = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	if (ptr == MAP_FAILED) {
+		close(fd);
+		err(1, "Error mapping the file");
+	}
+
+	printf("Writing to memory.\n");
+	memset(ptr, 1, size);
+	printf("Done writing to memory.\n");
+	close(fd);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/vm/tmpfs-memcg.sh b/tools/testing/selftests/vm/tmpfs-memcg.sh
new file mode 100755
index 0000000000000..50876992107fd
--- /dev/null
+++ b/tools/testing/selftests/vm/tmpfs-memcg.sh
@@ -0,0 +1,116 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+CGROUP_PATH=/dev/cgroup/memory/tmpfs-memcg-test
+REMOUNT_CGROUP_PATH=/dev/cgroup/memory/remount-memcg-test
+
+function cleanup() {
+  rm -rf /mnt/tmpfs/*
+  umount /mnt/tmpfs
+  rm -rf /mnt/tmpfs
+
+  rmdir $CGROUP_PATH
+  rmdir $REMOUNT_CGROUP_PATH
+
+  echo CLEANUP DONE
+}
+
+function setup() {
+  mkdir -p $CGROUP_PATH
+  mkdir -p $REMOUNT_CGROUP_PATH
+  echo $((10 * 1024 * 1024)) > $CGROUP_PATH/memory.limit_in_bytes
+  echo 0 > $CGROUP_PATH/cpuset.cpus
+  echo 0 > $CGROUP_PATH/cpuset.mems
+
+  mkdir -p /mnt/tmpfs
+
+  echo SETUP DONE
+}
+
+function expect_equal() {
+  local expected="$1"
+  local actual="$2"
+  local error="$3"
+
+  if [[ "$actual" != "$expected" ]]; then
+    echo "expected ($expected) != actual ($actual): $3" >&2
+    cleanup
+    exit 1
+  fi
+}
+
+function expect_ge() {
+  local expected="$1"
+  local actual="$2"
+  local error="$3"
+
+  if [[ "$actual" -lt "$expected" ]]; then
+    echo "expected ($expected) < actual ($actual): $3" >&2
+    cleanup
+    exit 1
+  fi
+}
+
+cleanup
+setup
+
+mount -t tmpfs -o memcg=$REMOUNT_CGROUP_PATH tmpfs /mnt/tmpfs
+check=$(cat /proc/mounts | grep -i remount-memcg-test)
+if [ -z "$check" ]; then
+  echo "tmpfs memcg= was not mounted correctly:"
+  echo $check
+  echo "FAILED"
+  cleanup
+  exit 1
+fi
+
+mount -t tmpfs -o remount,memcg=$CGROUP_PATH tmpfs /mnt/tmpfs
+check=$(cat /proc/mounts | grep -i tmpfs-memcg-test)
+if [ -z "$check" ]; then
+  echo "tmpfs memcg= was not remounted correctly:"
+  echo $check
+  echo "FAILED"
+  cleanup
+  exit 1
+fi
+
+TARGET_MEMCG_USAGE=$(cat $CGROUP_PATH/memory.usage_in_bytes)
+expect_equal 0 "$TARGET_MEMCG_USAGE" "Before echo, memcg usage should be 0"
+
+# Echo to allocate a page in the tmpfs
+echo
+echo
+echo hello > /mnt/tmpfs/test
+TARGET_MEMCG_USAGE=$(cat $CGROUP_PATH/memory.usage_in_bytes)
+expect_ge 4096 "$TARGET_MEMCG_USAGE" "After echo, memcg usage should be greater than 4096"
+echo "Echo test succeeded"
+
+echo
+echo
+tools/testing/selftests/vm/mmap_write -p /mnt/tmpfs/test -s $((1 * 1024 * 1024))
+TARGET_MEMCG_USAGE=$(cat $CGROUP_PATH/memory.usage_in_bytes)
+expect_ge $((1 * 1024 * 1024)) "$TARGET_MEMCG_USAGE" "After mmap_write, memcg usage should greater than 1MB"
+echo "WRITE TEST SUCCEEDED"
+
+# SIGBUS the remote container on pagefault.
+echo
+echo
+echo "SIGBUS the process doing the remote charge on hitting the limit of the remote cgroup."
+echo "This will take a long time because the kernel goes through reclaim retries,"
+echo "but should eventually the write process should receive a SIGBUS"
+set +e
+tools/testing/selftests/vm/mmap_write -p /mnt/tmpfs/test -s $((11 * 1024 * 1024)) &
+wait $!
+expect_equal "$?" "135" "mmap_write should have exited with SIGBUS"
+set -e
+
+# ENOSPC the remote container on non pagefault.
+echo
+echo
+echo "OOMing the remote container using cat (non-pagefault)"
+echo "This will take a long time because the kernel goes through reclaim retries,"
+echo "but should eventually the cat command should receive an ENOSPC"
+cat /dev/random > /mnt/tmpfs/random || true
+
+cleanup
+echo TEST PASSED
--
2.34.0.rc2.393.gf8c9666880-goog
