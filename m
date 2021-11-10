Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B9744CB36
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Nov 2021 22:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbhKJVW5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Nov 2021 16:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233433AbhKJVW4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Nov 2021 16:22:56 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F51C06127A
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Nov 2021 13:20:08 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id e12-20020aa7980c000000b0049fa3fc29d0so2646808pfl.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Nov 2021 13:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=XWUyVcqFDorfkxK8BmUlQ2jLw5lcWmVuPPsoovex71Y=;
        b=G2nMJLGxPIMyEeUfb/vaasX85o5Sfnbuzq+2YEd/YK686uuZTNaruqnosc1t/nwbaF
         m5N05wjs10IyzymZE1gJ6SWhZ1AMTcdNqaVe9/ePQ2lp28a0MtFXaJFaLSD8rvEzo5Wh
         arhruu4iKXYXKUfbZPe5gNtak87IS9WUPyWzKzMJN8Yxwl5hewD/kaNYM4lIxyeTf+fa
         nBx6tWsFO5qj9ltm0CS79xcUMAQAurs6zyFOmzCmBBqH4fRRF/TfEkkeKLL+FAEsaSzs
         RtO8Yf1co/HOZQINwy2CIqTxLQgBoMSO3o/5uxwPDjYidsajo4DRAO7ZTOxHZhxVZTK5
         Ornw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=XWUyVcqFDorfkxK8BmUlQ2jLw5lcWmVuPPsoovex71Y=;
        b=C7PdMTNFgCdYpsfgssAV3vYo576p/Ceevq6zJIj17vuB4w+UnyfZgRi/OSQsAt4fqF
         JMWmpoOvsu+CUn0uYDVsAyvIz10NU14dFn3BvlfE6XUn4pIl2m2kD5yl6eEqDUYTdDNq
         NDtCL2YyYWoU1zZ1d/ERISPaQ2/zjVPcqbrx2AiEoLPrL7WHX1ImOwFpSwmXB/Q0FVEc
         UWCrfwMCpJtw52IBY2O0PjDoM6SwTEMrdvh4rELosZ5GTHyIEd1jnHtErxxin6GAfMgL
         qtbXrT6QO7jIbgRmgwAuoVRIMT8InAI0L4jexP8rGJw4nEQGZB059tXQphTfx0zwZwLo
         4Oiw==
X-Gm-Message-State: AOAM530ii/JRUGaLKn4VsDaJWGGglO9+ZxqyeToN2ldTByRGGiATfH8M
        lBano9dWNCBe90F5Mck86qyGjGSMMPidtPng8A==
X-Google-Smtp-Source: ABdhPJwgK2AbRmOmsVL7fZ0uDB5Xq1S64WUY/kQU6kiEqA95TWLlPwwtuaHfqsCtshAjZpFdVr+GfBeRh9uNMzO7/w==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2cd:202:59c8:7b4e:e859:9db0])
 (user=almasrymina job=sendgmr) by 2002:a62:4e87:0:b0:47b:dbbf:c6f0 with SMTP
 id c129-20020a624e87000000b0047bdbbfc6f0mr2005596pfb.47.1636579207325; Wed,
 10 Nov 2021 13:20:07 -0800 (PST)
Date:   Wed, 10 Nov 2021 13:19:50 -0800
In-Reply-To: <20211110211951.3730787-1-almasrymina@google.com>
Message-Id: <20211110211951.3730787-5-almasrymina@google.com>
Mime-Version: 1.0
References: <20211110211951.3730787-1-almasrymina@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v2 4/4] mm, shmem, selftests: add tmpfs memcg= mount option tests
From:   Mina Almasry <almasrymina@google.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>, riel@surriel.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Mina Almasry <almasrymina@google.com>

Cc: Michal Hocko <mhocko@suse.com>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Greg Thelen <gthelen@google.com>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Roman Gushchin <guro@fb.com>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: riel@surriel.com
Cc: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org
Cc: cgroups@vger.kernel.org

---
 tools/testing/selftests/vm/.gitignore     |   1 +
 tools/testing/selftests/vm/mmap_write.c   | 103 ++++++++++++++++++++++
 tools/testing/selftests/vm/tmpfs-memcg.sh |  87 ++++++++++++++++++
 3 files changed, 191 insertions(+)
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
index 0000000000000..eb584ddcbae5f
--- /dev/null
+++ b/tools/testing/selftests/vm/tmpfs-memcg.sh
@@ -0,0 +1,87 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+CGROUP_PATH=/dev/cgroup/memory/tmpfs-memcg-test
+
+function cleanup() {
+  rm -rf /mnt/tmpfs/*
+  umount /mnt/tmpfs
+  rm -rf /mnt/tmpfs
+
+  rmdir $CGROUP_PATH
+
+  echo CLEANUP DONE
+}
+
+function setup() {
+  mkdir -p $CGROUP_PATH
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
+mount -t tmpfs -o memcg=$CGROUP_PATH tmpfs /mnt/tmpfs
+
+TARGET_MEMCG_USAGE=$(cat $CGROUP_PATH/memory.usage_in_bytes)
+expect_equal 0 "$TARGET_MEMCG_USAGE" "Before echo, memcg usage should be 0"
+
+# Echo to allocate a page in the tmpfs
+echo hello > /mnt/tmpfs/test
+TARGET_MEMCG_USAGE=$(cat $CGROUP_PATH/memory.usage_in_bytes)
+expect_ge 4096 "$TARGET_MEMCG_USAGE" "After echo, memcg usage should be greater than 4096"
+echo "Echo test succeeded"
+
+tools/testing/selftests/vm/mmap_write -p /mnt/tmpfs/test -s $((1 * 1024 * 1024))
+TARGET_MEMCG_USAGE=$(cat $CGROUP_PATH/memory.usage_in_bytes)
+expect_ge $((1 * 1024 * 1024)) "$TARGET_MEMCG_USAGE" "After echo, memcg usage should greater than 1MB"
+echo "Write succeeded"
+
+# OOM the remote container on pagefault.
+echo
+echo
+echo "OOMing the remote container using pagefault."
+echo "This will take a long time because the kernel goes through reclaim retries,"
+echo "but should eventually be OOM-killed by 'Out of memory (Killing remote allocating task)'"
+#tools/testing/selftests/vm/mmap_write -p /mnt/tmpfs/test -s $((11 * 1024 * 1024))
+
+# OOM the remote container on non pagefault.
+echo
+echo
+echo "OOMing the remote container using cat (non-pagefault)"
+echo "This will take a long time because the kernel goes through reclaim retries,"
+echo "but should eventually the cat command should receive an ENOMEM"
+cat /dev/random > /mnt/tmpfs/random
+
+cleanup
+echo SUCCESS
--
2.34.0.rc0.344.g81b53c2807-goog
