Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D177E32A4F3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Mar 2021 16:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349900AbhCBLmG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Mar 2021 06:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243067AbhCBADO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 19:03:14 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DDDC0617AA
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Mar 2021 16:01:42 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id l10so20876787ybt.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Mar 2021 16:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=y5AgFuKFjXcZgGVnYccTGhQxqZidPq3Pqfu1gkT294w=;
        b=VSKi8Uazg5pOrsOQDwoO0e8L17WYuvQ9E516op7e0cs2yyo8d2NNBPqObvyWHLOAwn
         XE9nJvogR4M6YcywOisP0eWKlk4psXjlBtES03cZe0F/IvaM1jHxKq+XuzmIeaxMX/M5
         VXTzbwEAZ46raW4Vyj73iOzSTqHNSZvKuj6FDVFj9StOGR5RMqPKiV9L+w2BcpRtnJCc
         yE2OhGlJNXpCm5tCJyVeZpUMs39A3IzURZD54wKhTKgDpEySBpdIyH82zQr896FTrRwL
         2G7KUAfHqIJQIzQyE+YEFjXgyxYBKshaJ+ND9MQjmzLTDp4P88KohT2HRMlSQ97SsYWE
         GyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=y5AgFuKFjXcZgGVnYccTGhQxqZidPq3Pqfu1gkT294w=;
        b=Ru19U2bSk0TJNUbhUTkiCaMqeuKD2/XwLmq2Xg9iaXzB6++ZAngaZIx2Qv6YEbJPYz
         NF1kWZjwPvHD5N8YuiVCruOS8lX8F/RVEuvcmczCHI+Vch37euKNXdQ0Mh7AJDsx2MWi
         JXQZ5flrZF2MSEfbXu76+mpM32pZ1XMW55jx05jwYnaFOIweVFaOuSHbnm6h0i79KbXD
         jheAicf0uvkn6diDFXGJBwgoYWxoiHO1/KIudgLshIgUi5G2c9A55nOX4WoLtdOmIbkf
         RKEhwvIDjK//OAtHQlbL2T4fxrT5MRw+WNec2KQ75EvuhJzGCAAGQkC7njevjSpDhgTj
         Xltg==
X-Gm-Message-State: AOAM533XlELgIV9EZW/iKO/U4+/dxrb/Crgc+MxPZisaMsfMz/GliaZr
        gMpbfXwAX+/vT6q+gfXkyyw6JtBsGH36qtxSJrlj
X-Google-Smtp-Source: ABdhPJyUkE1v6fhIe1n63qSf8TM18Pp21b/DiI1yIY1WVGMZb4n0zBTNQKnP1QZCYz2ewcv5iQ5K3sSeauTHPP199gqu
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:1998:8165:ca50:ab8d])
 (user=axelrasmussen job=sendgmr) by 2002:a5b:851:: with SMTP id
 v17mr27988049ybq.55.1614643301329; Mon, 01 Mar 2021 16:01:41 -0800 (PST)
Date:   Mon,  1 Mar 2021 16:01:30 -0800
In-Reply-To: <20210302000133.272579-1-axelrasmussen@google.com>
Message-Id: <20210302000133.272579-3-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210302000133.272579-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v2 2/5] userfaultfd/selftests: use memfd_create for shmem test type
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
        Brian Geffon <bgeffon@google.com>,
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
2.30.1.766.gb4fecdf3b7-goog

