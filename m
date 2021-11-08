Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D351C449DFA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Nov 2021 22:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240068AbhKHVXF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Nov 2021 16:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240052AbhKHVXC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Nov 2021 16:23:02 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C734C0613F5
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Nov 2021 13:20:17 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id x14-20020a627c0e000000b0049473df362dso7590507pfc.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Nov 2021 13:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=LgzEEqLYmw5ziRk+Zpmuo/4f8TX/yoKSNyIDF3U5Tf0=;
        b=dkS19bQQYgTX6/T8jpDaR8pAVWMYF9eTHs7ItoEw3LmZ6NEboTY5qgaJunrQFd4nxd
         hmIH43JH05TYBkiNZHmt7mz6SQpIc2T1RebaDAq+1gqUPbjJJwR8AV3q+lwvAj2efYGP
         Ec7gzZ2pGVc+bS/HMhHLxxkVEiilmFOfyUWuktV2i91mDTDQ+rvUrdoh03H2cpyPTqYA
         qLcppI1NNSqtON/IG5KuPPu/mL47x7Vh8EGcgUbF902dOTymSW8R3F8xglbi2XWS1Y8N
         ImS/vJb3SmqXzR0z2tm19uedWyIS8L2xDAAIxDIbtsYANfcHr9OtX5Ab8TBfp7zN+qrN
         GQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=LgzEEqLYmw5ziRk+Zpmuo/4f8TX/yoKSNyIDF3U5Tf0=;
        b=pVwLkBhXlw/PkkQpBw1mBv+iC7RLeKVk+dLurTKEo9KGTyutmu8DQ1UQA05gv9fT6q
         edckBKcOEgurxAL4XDzo4Ymyqgebk/oBlkIyXsKtrKQlmK44UFBy8iK5xltp7GxwL0d6
         QL0RQ79OVX2/d08K6iFias3QjIq3yudnwdyJ5CiRUU8ZRcoC2YMEYrLXjzs29E7XkFDf
         XuIBicOKD/HTZPhVbQIfn0j27yC2fvNe1DJIqph0tmKwv4BY58U1oiGdUI9vR9sVHixo
         rIzGZANiUk3Nk27avEtrsCtpYrwvWioiyofe3Tzows9wPccdiaOSZ+eq7lJoPPQ6ekcO
         mroA==
X-Gm-Message-State: AOAM531ruFPCJizPyMidT2cgkYvvlkyhd7sr7VVsEryub2GPv4tXhozx
        jpPgQ9Y5LZEkir4uPfYoAFIIbtBeb8ez7bPZdw==
X-Google-Smtp-Source: ABdhPJz/4wwyS8huhn9kLJ1CmDJcWry/ijIFPMY/kO2XaGL2/Kt4rjB472R+qFOc6hisw6Uhe1o3ER09e9RLY12zdw==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2cd:202:8717:7707:fb59:664e])
 (user=almasrymina job=sendgmr) by 2002:a17:902:654d:b0:141:7df3:b94 with SMTP
 id d13-20020a170902654d00b001417df30b94mr2306024pln.60.1636406416836; Mon, 08
 Nov 2021 13:20:16 -0800 (PST)
Date:   Mon,  8 Nov 2021 13:19:59 -0800
In-Reply-To: <20211108211959.1750915-1-almasrymina@google.com>
Message-Id: <20211108211959.1750915-6-almasrymina@google.com>
Mime-Version: 1.0
References: <20211108211959.1750915-1-almasrymina@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v1 5/5] mm, shmem, selftests: add tmpfs memcg= mount option tests
From:   Mina Almasry <almasrymina@google.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Roman Gushchin <songmuchun@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, riel@surriel.com,
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
Cc: Roman Gushchin <songmuchun@bytedance.com>
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
 tools/testing/selftests/vm/mmap_write.c   | 105 ++++++++++++++++++++++
 tools/testing/selftests/vm/tmpfs-memcg.sh |  70 +++++++++++++++
 3 files changed, 176 insertions(+)
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
index 0000000000000..3afeaccea9f44
--- /dev/null
+++ b/tools/testing/selftests/vm/mmap_write.c
@@ -0,0 +1,105 @@
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
+	printf("Not writing to memory.\n");
+	printf("Allocating using HUGETLBFS.\n");
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
index 0000000000000..fe7ffe769f903
--- /dev/null
+++ b/tools/testing/selftests/vm/tmpfs-memcg.sh
@@ -0,0 +1,70 @@
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
+  if [[ "$expected" != "$actual" ]]; then
+    echo "expected ($expected) != actual ($actual): $3" >&2
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
+expect_equal 131072 "$TARGET_MEMCG_USAGE" "After echo, memcg usage should be 131072"
+echo "Echo test succeeded"
+
+# OOM the remote container on pagefault.
+echo
+echo
+echo "OOMing the remote container using pagefault."
+echo "This will take a long time because the kernel goes through reclaim retries,"
+echo "but should eventually be OOM-killed by 'Out of memory (Killing remote allocating task)'"
+tools/testing/selftests/vm/mmap_write -p /mnt/tmpfs/test -s $((11 * 1024 * 1024))
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
