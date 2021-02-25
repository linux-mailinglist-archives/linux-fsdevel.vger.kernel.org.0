Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684553248CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 03:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236755AbhBYCQG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Feb 2021 21:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236400AbhBYCQE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Feb 2021 21:16:04 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2173BC06178C
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Feb 2021 18:14:45 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id m16so3317782qkh.20
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Feb 2021 18:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=us3C43DDKNe3vmD9vgqgm0NwVPFkKr8bUz8YjvFEJ68=;
        b=azgcrjBFGpIKHs9mxItadu7KNGX0xu18yRBYBSTtzn10N/qHaP7iMaiGNC6TyUinsH
         rb2tllixM92p5m+B5NgoMFtXPvjZI8o1xwoTvKVPXKHy1M6zYf6sKExD/BXKQH3fzCh8
         LFqhrL0Geo1ardkbKKRN/9vEiMKhfliNXskKF+jT5eO1CUAyNRSPW6KoCXpEpsZAeFe4
         xN2WhiwXQgMxRfnQVFbiHs2iKlqa9tIwBVqTukBZ17FeYY3sk3LEBnfgvrZczbxshuya
         Lw2XGBbiJWWFlyMNJRsphvWzZEtLQ+3NSxdfBmMv47Kschp49h+MyyqiExfLJCpBmLj+
         ugaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=us3C43DDKNe3vmD9vgqgm0NwVPFkKr8bUz8YjvFEJ68=;
        b=p1PW9R3XtWY+drNgI7akPyOM+3udvp0iacfdaetKUTlnWNZ/WiM+6qrh/Yj9jNSSu2
         wBCZjYR1xkl3k0EaZwMA7B9wVymXFmIyp+RVQi4Zdb4t0glaaKTaJQymMnMsNGUMsUsy
         uWZp+cosPYt8B4KVuIOl2yQwqmvuhPifMyxMIoqvFPyXAFmkNdrck7ZlJhd8kBf1MK6b
         Q00ee3DTuG0HHGSS5YfsTUnDifbJ00CpI4w2yr0iAJGAjTpKL7v6SWZbheGwOzsrBF7v
         91OyP3bEXC5q848Sh4Nw4ejMHKIcz6XxnRKtkkSk+4nmL+hsCeOdEiHi08gCcGxKuKai
         PMog==
X-Gm-Message-State: AOAM533Vv8Y/+8Zxtd2NoUFgCbqufXWkFPxm2N4mI559LVUo2gnPy2j0
        y59pGhC9pl/zf0ZRadAfcTFnc/hvVaKY3hxlr4Mj
X-Google-Smtp-Source: ABdhPJydO3y5DVIx8aI+4cvq389VtWeuFRi8HvtBqAFhsL4dc3FHyt3DUtvBG34/zGlnmXM6v+kW4HrqI9UrE9mMR2CR
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:a5fd:f848:2fdf:4651])
 (user=axelrasmussen job=sendgmr) by 2002:ad4:58c3:: with SMTP id
 dh3mr682909qvb.27.1614219284205; Wed, 24 Feb 2021 18:14:44 -0800 (PST)
Date:   Wed, 24 Feb 2021 18:14:17 -0800
In-Reply-To: <20210225021420.2290912-1-axelrasmussen@google.com>
Message-Id: <20210225021420.2290912-3-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210225021420.2290912-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH 2/5] userfaultfd/selftests: use memfd_create for shmem test type
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>, Wang Qing <wangqing@vivo.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michel Lespinasse <walken@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a preparatory commit. In the future, we want to be able to setup
alias mappings for area_src and area_dst in the shmem test, like we do
in the hugetlb_shared test. With a VMA obtained via
mmap(MAP_ANONYMOUS | MAP_SHARED), it isn't clear how to do this.

So, mmap() with an fd, so we can create alias mappings. Use memfd_create
instead of actually passing in a tmpfs path like hugetlb does, since
it's more convenient / simpler to run, and works just as well.

Future commits will:

1. Setup the alias mappings.
2. Extend our tests to actually take advantage of this, to test new
   userfaultfd behavior being introduced in this series.

Also, a small fix in the area we're changing: when the hugetlb setup
fails in main(), pass in the right argv[] so we actually print out the
hugetlb file path.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 35 ++++++++++++++++++++----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index f5ab5e0312e7..859398efb4fe 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -85,6 +85,7 @@ static bool test_uffdio_wp = false;
 static bool test_uffdio_minor = false;
 
 static bool map_shared;
+static int shm_fd;
 static int huge_fd;
 static char *huge_fd_off0;
 static unsigned long long *count_verify;
@@ -297,12 +298,20 @@ static int shmem_release_pages(char *rel_area)
 
 static void shmem_allocate_area(void **alloc_area)
 {
+	unsigned long offset =
+		alloc_area == (void **)&area_src ? 0 : nr_pages * page_size;
+
 	*alloc_area = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
-			   MAP_ANONYMOUS | MAP_SHARED, -1, 0);
+			   MAP_SHARED, shm_fd, offset);
 	if (*alloc_area == MAP_FAILED) {
-		fprintf(stderr, "shared memory mmap failed\n");
-		*alloc_area = NULL;
+		perror("mmap of memfd failed");
+		goto fail;
 	}
+
+	return;
+
+fail:
+	*alloc_area = NULL;
 }
 
 struct uffd_test_ops {
@@ -1672,15 +1681,31 @@ int main(int argc, char **argv)
 			usage();
 		huge_fd = open(argv[4], O_CREAT | O_RDWR, 0755);
 		if (huge_fd < 0) {
-			fprintf(stderr, "Open of %s failed", argv[3]);
+			fprintf(stderr, "Open of %s failed", argv[4]);
 			perror("open");
 			exit(1);
 		}
 		if (ftruncate(huge_fd, 0)) {
-			fprintf(stderr, "ftruncate %s to size 0 failed", argv[3]);
+			fprintf(stderr, "ftruncate %s to size 0 failed", argv[4]);
 			perror("ftruncate");
 			exit(1);
 		}
+	} else if (test_type == TEST_SHMEM) {
+		shm_fd = memfd_create(argv[0], 0);
+		if (shm_fd < 0) {
+			perror("memfd_create");
+			exit(1);
+		}
+		if (ftruncate(shm_fd, nr_pages * page_size * 2)) {
+			perror("ftruncate");
+			exit(1);
+		}
+		if (fallocate(shm_fd,
+			      FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0,
+			      nr_pages * page_size * 2)) {
+			perror("fallocate");
+			exit(1);
+		}
 	}
 	printf("nr_pages: %lu, nr_pages_per_cpu: %lu\n",
 	       nr_pages, nr_pages_per_cpu);
-- 
2.30.0.617.g56c4b15f3c-goog

