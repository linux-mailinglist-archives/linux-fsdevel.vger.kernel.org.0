Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5759376B529
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 14:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbjHAMur (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 08:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjHAMuR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 08:50:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1312121
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 05:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690894168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xJsbOToPWAZq/BUuGCNQ1TQ79o7M/JDjOnzAfc0Kk/Q=;
        b=dpjvsPlGrhih3ZlXTUSdukRrdKImKJ1AXXTfsSpDgG2h5Oz4tDjgSHc1Cb0oMYivBpbaXr
        /4j623+HAPShxYyOlFzwqzuZSAQ9TKRo92pnYJJS8+h4gyKgiyP8uQ5h+OL5cXrIIVQ34T
        h1/R1ndAf3EN02S1GbVcE7Zv6w9CMcI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-GAfS87eYOzWzIWNTk4bPuA-1; Tue, 01 Aug 2023 08:49:23 -0400
X-MC-Unique: GAfS87eYOzWzIWNTk4bPuA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 14FB9800962;
        Tue,  1 Aug 2023 12:49:23 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4759CC585A1;
        Tue,  1 Aug 2023 12:49:20 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        liubo <liubo254@huawei.com>, Peter Xu <peterx@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Mel Gorman <mgorman@suse.de>, Shuah Khan <shuah@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 7/8] selftest/mm: ksm_functional_tests: test in mmap_and_merge_range() if anything got merged
Date:   Tue,  1 Aug 2023 14:48:43 +0200
Message-ID: <20230801124844.278698-8-david@redhat.com>
In-Reply-To: <20230801124844.278698-1-david@redhat.com>
References: <20230801124844.278698-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Let's extend mmap_and_merge_range() to test if anything in the current
process was merged. range_maps_duplicates() is too unreliable for that
use case, so instead look at KSM stats.

Trigger a complete unmerge first, to cleanup the stable tree and
stabilize accounting of merged pages.

Note that we're using /proc/self/ksm_merging_pages instead of
/proc/self/ksm_stat, because that one is available in more existing
kernels.

If /proc/self/ksm_merging_pages can't be opened, we can't perform any
checks and simply skip them.

We have to special-case the shared zeropage for now. But the only user
-- test_unmerge_zero_pages() -- performs its own merge checks.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 .../selftests/mm/ksm_functional_tests.c       | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
index 0de9d33cd565..cb63b600cb4f 100644
--- a/tools/testing/selftests/mm/ksm_functional_tests.c
+++ b/tools/testing/selftests/mm/ksm_functional_tests.c
@@ -30,6 +30,7 @@
 static int ksm_fd;
 static int ksm_full_scans_fd;
 static int proc_self_ksm_stat_fd;
+static int proc_self_ksm_merging_pages_fd;
 static int ksm_use_zero_pages_fd;
 static int pagemap_fd;
 static size_t pagesize;
@@ -88,6 +89,22 @@ static long get_my_ksm_zero_pages(void)
 	return my_ksm_zero_pages;
 }
 
+static long get_my_merging_pages(void)
+{
+	char buf[10];
+	ssize_t ret;
+
+	if (proc_self_ksm_merging_pages_fd < 0)
+		return proc_self_ksm_merging_pages_fd;
+
+	ret = pread(proc_self_ksm_merging_pages_fd, buf, sizeof(buf) - 1, 0);
+	if (ret <= 0)
+		return -errno;
+	buf[ret] = 0;
+
+	return strtol(buf, NULL, 10);
+}
+
 static long ksm_get_full_scans(void)
 {
 	char buf[10];
@@ -120,11 +137,29 @@ static int ksm_merge(void)
 	return 0;
 }
 
+static int ksm_unmerge(void)
+{
+	if (write(ksm_fd, "2", 1) != 1)
+		return -errno;
+	return 0;
+}
+
 static char *mmap_and_merge_range(char val, unsigned long size, bool use_prctl)
 {
 	char *map;
 	int ret;
 
+	/* Stabilize accounting by disabling KSM completely. */
+	if (ksm_unmerge()) {
+		ksft_test_result_fail("Disabling (unmerging) KSM failed\n");
+		goto unmap;
+	}
+
+	if (get_my_merging_pages() > 0) {
+		ksft_test_result_fail("Still pages merged\n");
+		goto unmap;
+	}
+
 	map = mmap(NULL, size, PROT_READ|PROT_WRITE,
 		   MAP_PRIVATE|MAP_ANON, -1, 0);
 	if (map == MAP_FAILED) {
@@ -160,6 +195,16 @@ static char *mmap_and_merge_range(char val, unsigned long size, bool use_prctl)
 		ksft_test_result_fail("Running KSM failed\n");
 		goto unmap;
 	}
+
+	/*
+	 * Check if anything was merged at all. Ignore the zero page that is
+	 * accounted differently (depending on kernel support).
+	 */
+	if (val && !get_my_merging_pages()) {
+		ksft_test_result_fail("No pages got merged\n");
+		goto unmap;
+	}
+
 	return map;
 unmap:
 	munmap(map, size);
@@ -473,6 +518,8 @@ int main(int argc, char **argv)
 	if (pagemap_fd < 0)
 		ksft_exit_skip("open(\"/proc/self/pagemap\") failed\n");
 	proc_self_ksm_stat_fd = open("/proc/self/ksm_stat", O_RDONLY);
+	proc_self_ksm_merging_pages_fd = open("/proc/self/ksm_merging_pages",
+					      O_RDONLY);
 	ksm_use_zero_pages_fd = open("/sys/kernel/mm/ksm/use_zero_pages", O_RDWR);
 
 	test_unmerge();
-- 
2.41.0

