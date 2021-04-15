Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8395361264
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Apr 2021 20:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbhDOSsW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Apr 2021 14:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234654AbhDOSsP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Apr 2021 14:48:15 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6273C06138F
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Apr 2021 11:47:45 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f7so3462847ybp.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Apr 2021 11:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=q0uullLY89k5tjNP5bU3tD7YqwSbU41Jf2SRzlEhX2Q=;
        b=PGhYtBE5xnrNWkt51izqGm/qqZ/cW5JSEclkj59Lulv/OOsL4nNr5wBX4/UNX2H+pc
         NtUTO+A3IDVdzLi7XgXzMzEpQDKOEuTwvCjxT0ozSLU0k/8BKO/zitl8EjWbCGmaWljJ
         jDXxrTbtZsInoUjqUldYDExN0y8hiV0UwjujxkF8jxeqyy/mHCj3BRjM2s6qBQfm0rV1
         kvgeVsd1GSpAsr56cEGxp9ad/LvetcfXzfH/ICYuKga420o1bgtq54z1IT0NI8vXJARv
         /vm/KSNTdC1/nM3iVAfvA7oKufOphb6cRjcxLw0EE2w6dBfqK59totZRkxNxQnjky0IQ
         RsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=q0uullLY89k5tjNP5bU3tD7YqwSbU41Jf2SRzlEhX2Q=;
        b=AxmpRFti1Pc4NvMVbWp1qva/Gi3QKFd9LgdPRx8qFP4RG3aY130E/n4LtYFMrsK2mD
         YkxMZMQAH9SOCxbRptSNFnr0WZJkt/uXO2EjmU9hlH+MC0QGqAgfD2UVMGXN0juO6UNd
         zUt13jPRmVs1orxX3rkzg7UKLDQsKsRSCl9kk3Vk15guV7rbs99s00i+cHsQFfw0A3LA
         u2Spw6+6jE/hypj5C1SJ7RnLNmEVfI0UpFHt0VEi4y/pidIuKIJQKQnvSAJAty1vpaUo
         U5S4UKiIlr0OHbBd49w74L9nZgh12VusX1zfgY8DJLVoAMYJ8dV1zmu7Xh0FNisjQNpR
         0sNg==
X-Gm-Message-State: AOAM530zHAC4yHIjtSo80nI+Qx3UIemh+LIEq5w+qygoKitSKVmj/5xV
        rWRFj+gEKDtB1kKLjZAHb/QYRKBXxEetSYLvngPG
X-Google-Smtp-Source: ABdhPJymMGKYCItf3/WZHnpAEKUrYL5DbfHrd53I0ndsk01MdMvDdWfa8cT4Nn2s+ngHPVJmoiz41D4joq2vuPSIEtpq
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:21b1:6e5c:b371:7e3])
 (user=axelrasmussen job=sendgmr) by 2002:a25:1855:: with SMTP id
 82mr6603080yby.305.1618512465042; Thu, 15 Apr 2021 11:47:45 -0700 (PDT)
Date:   Thu, 15 Apr 2021 11:47:27 -0700
In-Reply-To: <20210415184732.3410521-1-axelrasmussen@google.com>
Message-Id: <20210415184732.3410521-6-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210415184732.3410521-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH v3 05/10] userfaultfd/selftests: use memfd_create for shmem
 test type
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, Axel Rasmussen <axelrasmussen@google.com>,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
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

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 6339aeaeeff8..fc40831f818f 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -85,6 +85,7 @@ static bool test_uffdio_wp = false;
 static bool test_uffdio_minor = false;
 
 static bool map_shared;
+static int shm_fd;
 static int huge_fd;
 static char *huge_fd_off0;
 static unsigned long long *count_verify;
@@ -277,8 +278,11 @@ static void shmem_release_pages(char *rel_area)
 
 static void shmem_allocate_area(void **alloc_area)
 {
+	unsigned long offset =
+		alloc_area == (void **)&area_src ? 0 : nr_pages * page_size;
+
 	*alloc_area = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
-			   MAP_ANONYMOUS | MAP_SHARED, -1, 0);
+			   MAP_SHARED, shm_fd, offset);
 	if (*alloc_area == MAP_FAILED)
 		err("mmap of memfd failed");
 }
@@ -1448,6 +1452,16 @@ int main(int argc, char **argv)
 			err("Open of %s failed", argv[4]);
 		if (ftruncate(huge_fd, 0))
 			err("ftruncate %s to size 0 failed", argv[4]);
+	} else if (test_type == TEST_SHMEM) {
+		shm_fd = memfd_create(argv[0], 0);
+		if (shm_fd < 0)
+			err("memfd_create");
+		if (ftruncate(shm_fd, nr_pages * page_size * 2))
+			err("ftruncate");
+		if (fallocate(shm_fd,
+			      FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0,
+			      nr_pages * page_size * 2))
+			err("fallocate");
 	}
 	printf("nr_pages: %lu, nr_pages_per_cpu: %lu\n",
 	       nr_pages, nr_pages_per_cpu);
-- 
2.31.1.368.gbe11c130af-goog

