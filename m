Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9909A36CEF5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 00:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239075AbhD0Wyt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 18:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239425AbhD0Wxq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 18:53:46 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE8EC061345
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Apr 2021 15:53:02 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id i7-20020ac84f470000b02901b944d49e13so16438430qtw.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Apr 2021 15:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=u1gk9aiwDmv6+SRZ0ft4k2Rli22/pgCpQ8yAo+qVnNA=;
        b=WhttcOh6OlYlGtQYO3hqYvxXeiYuKV+rWQSt5GADJGax/zVklA+4aVWY6Vth1HSH3X
         jwqi4xlCmJmF2uk4C3mUlO9dXP5GKLMafa/YYpnFpCz7vDawNizmXlGB6yjOLRbWnnjs
         zUKKD0pPXPMq+GNf9mgcyCiC+JYB1W0gdtCctKXlHEeJk0mX+xU28z2b6gRtk8Yu85nl
         2JjUUN+ND3iO+ubDxIVQYc87lZwqiydAQ90ZMWi5SimqntNNm/EZWf8oo0PfH30L05ai
         eXKCJjGA7iP4ZQy64cNZRCZh9nqI8vq5hUhkIc2nfyfHUBlBdiVJlltPIDFueWEmrOik
         S4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=u1gk9aiwDmv6+SRZ0ft4k2Rli22/pgCpQ8yAo+qVnNA=;
        b=lD7BndSBAXLFqPAR11KWNOJn4kwhhoGbSf9VCMRp1xXDoz9QrvCOPou05YhDAk7KcH
         /EJXPPA1/2G7kckEeAr3d9iiFBKrkMvhnFSGjVA7APsaOe6rJ4SSGfhFGEikqlOOY63b
         fk0inGZikMsMnstgkzlYo/82EPI0bHhYCCF8oeZ9UVyL7M3GaL9iC/5oC4c94XvbAZU3
         HNoG82bXtaiSk9XHqdgx/4XMrsdpy9IcfMghlvJCBkNMWavp3760BafBVchH8VaOOqB7
         CI2diQ31PZHZsDXj+L5xdko9IK8r3804SnjLmUeZHp45ZRINARoDsQzYC2d109LArk6C
         f02w==
X-Gm-Message-State: AOAM532qlUi9DkK8Z3LnCAmENO0OmkHU3zjN1S93ina7LsFMD7FByJJw
        axdrhsTWr/zBmpBltgckfALx3F25xuv7/U0R+3oD
X-Google-Smtp-Source: ABdhPJwiDFSleswhpJEUOz8lD3obBc43FvS6xslLfDjp1Gi5RYfDgRHiZ7zkrRDES+WQD/M44l98muWb/GGEwvLSrFN1
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:c423:570b:b823:c33e])
 (user=axelrasmussen job=sendgmr) by 2002:a0c:fcc8:: with SMTP id
 i8mr14211207qvq.31.1619563981243; Tue, 27 Apr 2021 15:53:01 -0700 (PDT)
Date:   Tue, 27 Apr 2021 15:52:41 -0700
In-Reply-To: <20210427225244.4326-1-axelrasmussen@google.com>
Message-Id: <20210427225244.4326-8-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210427225244.4326-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH v5 07/10] userfaultfd/selftests: use memfd_create for shmem
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
2.31.1.498.g6c1eba8ee3d-goog

