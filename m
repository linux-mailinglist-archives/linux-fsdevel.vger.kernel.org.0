Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF1D31A728
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 22:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhBLV40 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 16:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbhBLVzm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 16:55:42 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD73CC0617AB
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Feb 2021 13:54:31 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id f3so1039075ybg.15
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Feb 2021 13:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ynQoh3piWdcwMI3A9fmVyJvOTKo6cf3euEv7boIDrGw=;
        b=cRBlTlUPL+lFCjJb0ltkXmv5nyTjjwdtsKPw0sOX+NVTd3AFos4dfzjVZZat3UV6lo
         TFmDe6rMsEXpiGrz0irICyHyue4UsQkWbL6JjQB4oOPrpasSHgdguYQ3e5NwqHP+aqXx
         7GWGDlFszTGeT/+3sbZTI9A2msJnIYqnKDpqls/g3+m/wiFO0dJyckcdeQKkz0GpcrMz
         gynpqIgesJvbGpNvTCQVzoup64iJEs6QnT5CK2cvZnZDjGDf7kct1SZXolOKAcViaZal
         eNNKoYLwj1c1Ou3vZGzEKQB2N0nvVh0j6IKBM1zQTiVpYsjBKkyHQ+Bpv2Am2BYJ5Rp1
         eedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ynQoh3piWdcwMI3A9fmVyJvOTKo6cf3euEv7boIDrGw=;
        b=n2PmfnQJ6Q7KT358DBEDGxFztqn5bTxSqD+tp8AraVl8Ncp40nV+e1LNduXSP1Febj
         jA7ArLKn6VckORFrm++CvWq4nE9RqBlF0Hf2wW+phAUiTeqeIZfFlbZWjD3VNAFIKkIC
         1Hfom1FPeNg4Ai8eW+QyhNU7vdzt22Oc2a/4e/exvjoHO7iDTpIJI3EuY+y2sFmiMLUm
         jrWKi7BAf/4Tki/ewr0e01WMRb43iKMwMN/X6a/AgjnMGqNKyUda0q/AvyT0cYZbco74
         LfPu/GBdaIiMYq8CHPKL7jzdEzsX+luBwy4YsHE48G0Lzlzu7lmRr3AoKWHl2x8ip/AS
         yp7g==
X-Gm-Message-State: AOAM530wH4MIFFH37MOx0WXMinhPLJHUIXc7nOav+l69RyP1Ko1g4L0c
        +4DWIe4hKMrjPxd4wj7UfXif+TaMsDnR74dfd+CU
X-Google-Smtp-Source: ABdhPJzLIMpTMFSvjBRXFuKcg5CYSqwMXlLH8ZNdogYGG1fT1is1JXX/gDwKjlilVePT2V1US2VWC5kxo6Ad1/2obs2g
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:d2f:99bb:c1e0:34ba])
 (user=axelrasmussen job=sendgmr) by 2002:a25:b883:: with SMTP id
 w3mr6815698ybj.321.1613166870943; Fri, 12 Feb 2021 13:54:30 -0800 (PST)
Date:   Fri, 12 Feb 2021 13:54:03 -0800
In-Reply-To: <20210212215403.3457686-1-axelrasmussen@google.com>
Message-Id: <20210212215403.3457686-8-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210212215403.3457686-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v6 7/7] userfaultfd/selftests: add test exercising minor fault handling
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Huang Ying <ying.huang@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Michel Lespinasse <walken@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Adam Ruprecht <ruprecht@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix a dormant bug in userfaultfd_events_test(), where we did
`return faulting_process(0)` instead of `exit(faulting_process(0))`.
This caused the forked process to keep running, trying to execute any
further test cases after the events test in parallel with the "real"
process.

Add a simple test case which exercises minor faults. In short, it does
the following:

1. "Sets up" an area (area_dst) and a second shared mapping to the same
   underlying pages (area_dst_alias).

2. Register one of these areas with userfaultfd, in minor fault mode.

3. Start a second thread to handle any minor faults.

4. Populate the underlying pages with the non-UFFD-registered side of
   the mapping. Basically, memset() each page with some arbitrary
   contents.

5. Then, using the UFFD-registered mapping, read all of the page
   contents, asserting that the contents match expectations (we expect
   the minor fault handling thread can modify the page contents before
   resolving the fault).

The minor fault handling thread, upon receiving an event, flips all the
bits (~) in that page, just to prove that it can modify it in some
arbitrary way. Then it issues a UFFDIO_CONTINUE ioctl, to setup the
mapping and resolve the fault. The reading thread should wake up and see
this modification.

Currently the minor fault test is only enabled in hugetlb_shared mode,
as this is the only configuration the kernel feature supports.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 147 ++++++++++++++++++++++-
 1 file changed, 143 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 92b8ec423201..915b34d997ce 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -81,6 +81,8 @@ static volatile bool test_uffdio_copy_eexist = true;
 static volatile bool test_uffdio_zeropage_eexist = true;
 /* Whether to test uffd write-protection */
 static bool test_uffdio_wp = false;
+/* Whether to test uffd minor faults */
+static bool test_uffdio_minor = false;
 
 static bool map_shared;
 static int huge_fd;
@@ -96,6 +98,7 @@ struct uffd_stats {
 	int cpu;
 	unsigned long missing_faults;
 	unsigned long wp_faults;
+	unsigned long minor_faults;
 };
 
 /* pthread_mutex_t starts at page offset 0 */
@@ -153,17 +156,19 @@ static void uffd_stats_reset(struct uffd_stats *uffd_stats,
 		uffd_stats[i].cpu = i;
 		uffd_stats[i].missing_faults = 0;
 		uffd_stats[i].wp_faults = 0;
+		uffd_stats[i].minor_faults = 0;
 	}
 }
 
 static void uffd_stats_report(struct uffd_stats *stats, int n_cpus)
 {
 	int i;
-	unsigned long long miss_total = 0, wp_total = 0;
+	unsigned long long miss_total = 0, wp_total = 0, minor_total = 0;
 
 	for (i = 0; i < n_cpus; i++) {
 		miss_total += stats[i].missing_faults;
 		wp_total += stats[i].wp_faults;
+		minor_total += stats[i].minor_faults;
 	}
 
 	printf("userfaults: %llu missing (", miss_total);
@@ -172,6 +177,9 @@ static void uffd_stats_report(struct uffd_stats *stats, int n_cpus)
 	printf("\b), %llu wp (", wp_total);
 	for (i = 0; i < n_cpus; i++)
 		printf("%lu+", stats[i].wp_faults);
+	printf("\b), %llu minor (", minor_total);
+	for (i = 0; i < n_cpus; i++)
+		printf("%lu+", stats[i].minor_faults);
 	printf("\b)\n");
 }
 
@@ -328,7 +336,7 @@ static struct uffd_test_ops shmem_uffd_test_ops = {
 };
 
 static struct uffd_test_ops hugetlb_uffd_test_ops = {
-	.expected_ioctls = UFFD_API_RANGE_IOCTLS_BASIC,
+	.expected_ioctls = UFFD_API_RANGE_IOCTLS_BASIC & ~(1 << _UFFDIO_CONTINUE),
 	.allocate_area	= hugetlb_allocate_area,
 	.release_pages	= hugetlb_release_pages,
 	.alias_mapping = hugetlb_alias_mapping,
@@ -362,6 +370,22 @@ static void wp_range(int ufd, __u64 start, __u64 len, bool wp)
 	}
 }
 
+static void continue_range(int ufd, __u64 start, __u64 len)
+{
+	struct uffdio_continue req;
+
+	req.range.start = start;
+	req.range.len = len;
+	req.mode = 0;
+
+	if (ioctl(ufd, UFFDIO_CONTINUE, &req)) {
+		fprintf(stderr,
+			"UFFDIO_CONTINUE failed for address 0x%" PRIx64 "\n",
+			(uint64_t)start);
+		exit(1);
+	}
+}
+
 static void *locking_thread(void *arg)
 {
 	unsigned long cpu = (unsigned long) arg;
@@ -569,8 +593,32 @@ static void uffd_handle_page_fault(struct uffd_msg *msg,
 	}
 
 	if (msg->arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WP) {
+		/* Write protect page faults */
 		wp_range(uffd, msg->arg.pagefault.address, page_size, false);
 		stats->wp_faults++;
+	} else if (msg->arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_MINOR) {
+		uint8_t *area;
+		int b;
+
+		/*
+		 * Minor page faults
+		 *
+		 * To prove we can modify the original range for testing
+		 * purposes, we're going to bit flip this range before
+		 * continuing.
+		 *
+		 * Note that this requires all minor page fault tests operate on
+		 * area_dst (non-UFFD-registered) and area_dst_alias
+		 * (UFFD-registered).
+		 */
+
+		area = (uint8_t *)(area_dst +
+				   ((char *)msg->arg.pagefault.address -
+				    area_dst_alias));
+		for (b = 0; b < page_size; ++b)
+			area[b] = ~area[b];
+		continue_range(uffd, msg->arg.pagefault.address, page_size);
+		stats->minor_faults++;
 	} else {
 		/* Missing page faults */
 		if (bounces & BOUNCE_VERIFY &&
@@ -1112,7 +1160,7 @@ static int userfaultfd_events_test(void)
 	}
 
 	if (!pid)
-		return faulting_process(0);
+		exit(faulting_process(0));
 
 	waitpid(pid, &err, 0);
 	if (err) {
@@ -1215,6 +1263,95 @@ static int userfaultfd_sig_test(void)
 	return userfaults != 0;
 }
 
+static int userfaultfd_minor_test(void)
+{
+	struct uffdio_register uffdio_register;
+	unsigned long expected_ioctls;
+	unsigned long p;
+	pthread_t uffd_mon;
+	uint8_t expected_byte;
+	void *expected_page;
+	char c;
+	struct uffd_stats stats = { 0 };
+
+	if (!test_uffdio_minor)
+		return 0;
+
+	printf("testing minor faults: ");
+	fflush(stdout);
+
+	if (uffd_test_ops->release_pages(area_dst))
+		return 1;
+
+	if (userfaultfd_open(UFFD_FEATURE_MINOR_HUGETLBFS))
+		return 1;
+
+	uffdio_register.range.start = (unsigned long)area_dst_alias;
+	uffdio_register.range.len = nr_pages * page_size;
+	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
+	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register)) {
+		fprintf(stderr, "register failure\n");
+		exit(1);
+	}
+
+	expected_ioctls = uffd_test_ops->expected_ioctls;
+	expected_ioctls |= (1 << _UFFDIO_CONTINUE);
+	if ((uffdio_register.ioctls & expected_ioctls) != expected_ioctls) {
+		fprintf(stderr, "unexpected missing ioctl(s)\n");
+		exit(1);
+	}
+
+	/*
+	 * After registering with UFFD, populate the non-UFFD-registered side of
+	 * the shared mapping. This should *not* trigger any UFFD minor faults.
+	 */
+	for (p = 0; p < nr_pages; ++p) {
+		memset(area_dst + (p * page_size), p % ((uint8_t)-1),
+		       page_size);
+	}
+
+	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, &stats)) {
+		perror("uffd_poll_thread create");
+		exit(1);
+	}
+
+	/*
+	 * Read each of the pages back using the UFFD-registered mapping. We
+	 * expect that the first time we touch a page, it will result in a minor
+	 * fault. uffd_poll_thread will resolve the fault by bit-flipping the
+	 * page's contents, and then issuing a CONTINUE ioctl.
+	 */
+
+	if (posix_memalign(&expected_page, page_size, page_size)) {
+		fprintf(stderr, "out of memory\n");
+		return 1;
+	}
+
+	for (p = 0; p < nr_pages; ++p) {
+		expected_byte = ~((uint8_t)(p % ((uint8_t)-1)));
+		memset(expected_page, expected_byte, page_size);
+		if (my_bcmp(expected_page, area_dst_alias + (p * page_size),
+			    page_size)) {
+			fprintf(stderr,
+				"unexpected page contents after minor fault\n");
+			exit(1);
+		}
+	}
+
+	if (write(pipefd[1], &c, sizeof(c)) != sizeof(c)) {
+		perror("pipe write");
+		exit(1);
+	}
+	if (pthread_join(uffd_mon, NULL))
+		return 1;
+
+	close(uffd);
+
+	uffd_stats_report(&stats, 1);
+
+	return stats.missing_faults != 0 || stats.minor_faults != nr_pages;
+}
+
 static int userfaultfd_stress(void)
 {
 	void *area;
@@ -1413,7 +1550,7 @@ static int userfaultfd_stress(void)
 
 	close(uffd);
 	return userfaultfd_zeropage_test() || userfaultfd_sig_test()
-		|| userfaultfd_events_test();
+		|| userfaultfd_events_test() || userfaultfd_minor_test();
 }
 
 /*
@@ -1454,6 +1591,8 @@ static void set_test_type(const char *type)
 		map_shared = true;
 		test_type = TEST_HUGETLB;
 		uffd_test_ops = &hugetlb_uffd_test_ops;
+		/* Minor faults require shared hugetlb; only enable here. */
+		test_uffdio_minor = true;
 	} else if (!strcmp(type, "shmem")) {
 		map_shared = true;
 		test_type = TEST_SHMEM;
-- 
2.30.0.478.g8a0d178c01-goog

