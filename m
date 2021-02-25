Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B323248CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 03:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236818AbhBYCQ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Feb 2021 21:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236800AbhBYCQW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Feb 2021 21:16:22 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672DFC06121E
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Feb 2021 18:14:51 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id b27so3324568qkl.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Feb 2021 18:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=lQ7mB70IC4ojvTJeDVa366V82dbz54zsKMBfnZVy7Ms=;
        b=lFJ9b0YcGKvqVJcJEUWuytLaGKckdM7KmGvm907xlugk9wxeiWjXhPwfymQVBxp9Q2
         IstnBZ8+wjO+/QcGj1MgU+rwbm/UiybZgKvq2fglhsfXqANGr3ud+VEau8tVuHe7Zwq0
         EOsAWX7/nPq9KEfZpIga28EXZplEa6KRx3g8oLhVyKHm43f/W6MSgPYdJTGREFCUq9Yk
         L5dgUKAtfUBQ/hnIfNzSPMRRDfmbVO1hBAZlwAZUFV04WBoUr9vtDP9OMlrp9rrLK11H
         YD7EYLvmCaGZLJ2TPMNI82UfqLI879FX+YDnAJqPFrpxTtbYACU08rJtMWHFZHY/P+nE
         r0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lQ7mB70IC4ojvTJeDVa366V82dbz54zsKMBfnZVy7Ms=;
        b=cdvfBzI/LU6DGJuX4eua3TbjVIPw1ty+lf5KnlsLuN8BRRs65yGu1L6V2mZzqcEX1H
         kwCYsf+539t8a5uCTfIRSaIxncZq2ia9ABAl6O5FaMh8DUuVoWZQtiuoKqnxGy4O0rAp
         Z/8gskO5ShEPT+5Wr73Nwca36T1N+FEJWqJmVjAwuCpB/zBZeRUY8OV4IhibAgIUw5cz
         1XFcbQbbj4Kbo3g+8+sTVTY9TOFBobJx/F4tIj7Zj1sgBYADQFAzL9PEc3Vxd8fHsH9p
         j3R8dc6LLSspYN03lU1+6Z7taz3BU/r8UI2bPFzYPxFuho9vg+xVCsD+cspSFxWvXrSC
         XX9A==
X-Gm-Message-State: AOAM530K3h/RDrQjvgi519oPuQowZ9nWk5Nvi2MJDEds4FO6Kzgeh5hf
        E0uQsw4CK9wUv6+4ygGr8Ti7m9CL2U3D/JJQpeCv
X-Google-Smtp-Source: ABdhPJzSrYbVzMfooR0D4GJVwJWAmLVAkLv5BsZNvFUpe/9PmHmsazV5LOf8VJL8bA6bcXTyCbI+qACA2cxNuhvbX7Xd
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:a5fd:f848:2fdf:4651])
 (user=axelrasmussen job=sendgmr) by 2002:ad4:5609:: with SMTP id
 ca9mr615259qvb.58.1614219290463; Wed, 24 Feb 2021 18:14:50 -0800 (PST)
Date:   Wed, 24 Feb 2021 18:14:20 -0800
In-Reply-To: <20210225021420.2290912-1-axelrasmussen@google.com>
Message-Id: <20210225021420.2290912-6-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210225021420.2290912-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH 5/5] userfaultfd/selftests: exercise minor fault handling
 shmem support
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

Enable test_uffdio_minor for test_type == TEST_SHMEM, and modify the
test slightly to pass in / check for the right feature flags.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 5183ddb3080d..f31e9a4edc55 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -1410,7 +1410,7 @@ static int userfaultfd_minor_test(void)
 	void *expected_page;
 	char c;
 	struct uffd_stats stats = { 0 };
-	uint64_t features = UFFD_FEATURE_MINOR_HUGETLBFS;
+	uint64_t req_features, features_out;
 
 	if (!test_uffdio_minor)
 		return 0;
@@ -1418,10 +1418,18 @@ static int userfaultfd_minor_test(void)
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
@@ -1431,7 +1439,7 @@ static int userfaultfd_minor_test(void)
 	uffdio_register.range.len = nr_pages * page_size;
 	uffdio_register.mode = UFFDIO_REGISTER_MODE_MINOR;
 	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register)) {
-		fprintf(stderr, "register failure\n");
+		perror("register failure");
 		exit(1);
 	}
 
@@ -1695,6 +1703,7 @@ static void set_test_type(const char *type)
 		map_shared = true;
 		test_type = TEST_SHMEM;
 		uffd_test_ops = &shmem_uffd_test_ops;
+		test_uffdio_minor = true;
 	} else {
 		fprintf(stderr, "Unknown test type: %s\n", type); exit(1);
 	}
-- 
2.30.0.617.g56c4b15f3c-goog

