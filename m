Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B7035D722
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 07:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344550AbhDMFSJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 01:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344496AbhDMFSB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 01:18:01 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330D7C061756
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Apr 2021 22:17:40 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id k199so12375707ybf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Apr 2021 22:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=l2i93c0D52SLfGu2rkvXcmRcnJGNafhRbk6pUsLSI1w=;
        b=C4Ph3T5LPg46cqLVVraagPCEdHhGh1gYl/hhbULoTKxzkji59i9JdW05JgvYQBh82z
         gcxc4JXlELbBwT/dcsyu5fbUHU5BTVSvapR0E8czq77gOndoTR3aC+/pNIUsD6KmQwaV
         lNXBy1mIuuS+pfwaJm3GwARldwPKpnJxjAhAR9Z+7+E55GDGhZAuAypUnX3XH9DeM+Sz
         FzxGFyX5WnOvJhrGuAUETMqbKDgKkOMBAGj0LA+D8JWsn2/rnqqvYC9RioKQd4/FwJJl
         YGwfVuWwhkTwI74ysw7FeByB6Ljdih1RijuGpZPgpdKJL8DrXmbZUCopdKaQfnALYL2D
         ThFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=l2i93c0D52SLfGu2rkvXcmRcnJGNafhRbk6pUsLSI1w=;
        b=mQ7n48LlZFzZNP87FoJe3zvddRfu7VwYmTQTKZyQlmL2xZTeho4W64IYP1nno7Bev6
         vXfUHVp0MhA859kSfN2nOaIBP/EDKUf2IyAR3rv7SznHSZwzyANmrN3d8zeBuAiwaFZL
         ry/2vm3aJD9i82QOW+rRks14dxkpBUw92QD7pV8Ssv/cIQ87tTGMBZmfEfLkZ9LtCSzK
         zfCqRw9umhdvBuUBaULeeBQfNXCmgcvSsgBDIfgR/EtV/Lw+J8LSRMiiir2Z9ulc8jOC
         r8ld2ZlxXt8ZvgbhW9SM3usf9ZGCzuxDoHiePaIxJcG2X6mpKFB3DafMt9TyUQvW1SJK
         aM+Q==
X-Gm-Message-State: AOAM5300ZQwJ/Wp1GiaScufl2WE4OZsP62k1y+WN+IfJDPuz6/BmW1H0
        WQAxpBwBqPHSq0kenkvNwgfqWPzbLMrcP2ApckZF
X-Google-Smtp-Source: ABdhPJzYi6y7kbLqWoNzDFmc0mNDDDXQIxQB5nuQA+FyuaB0LaEXxS55HjozjFHHAJ+1hNmZL7XJDp6yJLi6F9f+pHTq
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:d508:eee5:2d57:3e32])
 (user=axelrasmussen job=sendgmr) by 2002:a25:6c85:: with SMTP id
 h127mr39041723ybc.341.1618291059410; Mon, 12 Apr 2021 22:17:39 -0700 (PDT)
Date:   Mon, 12 Apr 2021 22:17:20 -0700
In-Reply-To: <20210413051721.2896915-1-axelrasmussen@google.com>
Message-Id: <20210413051721.2896915-9-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210413051721.2896915-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH v2 8/9] userfaultfd/selftests: exercise minor fault handling
 shmem support
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

Enable test_uffdio_minor for test_type == TEST_SHMEM, and modify the
test slightly to pass in / check for the right feature flags.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 29 ++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 0ff01f437a39..0830f155e6c2 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -484,6 +484,7 @@ static void wp_range(int ufd, __u64 start, __u64 len, bool wp)
 static void continue_range(int ufd, __u64 start, __u64 len)
 {
 	struct uffdio_continue req;
+	int ret;
 
 	req.range.start = start;
 	req.range.len = len;
@@ -492,6 +493,17 @@ static void continue_range(int ufd, __u64 start, __u64 len)
 	if (ioctl(ufd, UFFDIO_CONTINUE, &req))
 		err("UFFDIO_CONTINUE failed for address 0x%" PRIx64,
 		    (uint64_t)start);
+
+	/*
+	 * Error handling within the kernel for continue is subtly different
+	 * from copy or zeropage, so it may be a source of bugs. Trigger an
+	 * error (-EEXIST) on purpose, to verify doing so doesn't cause a BUG.
+	 */
+	req.mapped = 0;
+	ret = ioctl(ufd, UFFDIO_CONTINUE, &req);
+	if (ret >= 0 || req.mapped != -EEXIST)
+		err("failed to exercise UFFDIO_CONTINUE error handling, ret=%d, mapped=%" PRId64,
+		    ret, (int64_t) req.mapped);
 }
 
 static void *locking_thread(void *arg)
@@ -1196,7 +1208,7 @@ static int userfaultfd_minor_test(void)
 	void *expected_page;
 	char c;
 	struct uffd_stats stats = { 0 };
-	uint64_t features = UFFD_FEATURE_MINOR_HUGETLBFS;
+	uint64_t req_features, features_out;
 
 	if (!test_uffdio_minor)
 		return 0;
@@ -1204,10 +1216,18 @@ static int userfaultfd_minor_test(void)
 	printf("testing minor faults: ");
 	fflush(stdout);
 
-	if (uffd_test_ctx_clear() || uffd_test_ctx_init_ext(&features))
+	if (test_type == TEST_HUGETLB)
+		req_features = UFFD_FEATURE_MINOR_HUGETLBFS;
+	else if (test_type == TEST_SHMEM)
+		req_features = UFFD_FEATURE_MINOR_SHMEM;
+	else
+		return 1;
+
+	features_out = req_features;
+	if (uffd_test_ctx_clear() || uffd_test_ctx_init_ext(&features_out))
 		return 1;
-	/* If kernel reports the feature isn't supported, skip the test. */
-	if (!(features & UFFD_FEATURE_MINOR_HUGETLBFS)) {
+	/* If kernel reports required features aren't supported, skip test. */
+	if ((features_out & req_features) != req_features) {
 		printf("skipping test due to lack of feature support\n");
 		fflush(stdout);
 		return 0;
@@ -1442,6 +1462,7 @@ static void set_test_type(const char *type)
 		map_shared = true;
 		test_type = TEST_SHMEM;
 		uffd_test_ops = &shmem_uffd_test_ops;
+		test_uffdio_minor = true;
 	} else {
 		err("Unknown test type: %s", type);
 	}
-- 
2.31.1.295.g9ea45b61b8-goog

