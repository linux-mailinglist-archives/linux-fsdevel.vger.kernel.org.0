Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BE96783D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 18:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbjAWR73 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 12:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbjAWR72 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:59:28 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFCB23D88
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jan 2023 09:59:26 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id 8434B5616BF5; Mon, 23 Jan 2023 09:37:56 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     linux-mm@kvack.org
Cc:     shr@devkernel.io, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [RESEND RFC PATCH v1 17/20] selftests/vm: add KSM prctl merge test
Date:   Mon, 23 Jan 2023 09:37:45 -0800
Message-Id: <20230123173748.1734238-18-shr@devkernel.io>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230123173748.1734238-1-shr@devkernel.io>
References: <20230123173748.1734238-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_NEUTRAL,SUSPICIOUS_RECIPS,TVD_RCVD_IP autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds the -t option to the ksm_tests program. The -t flag allows to
specify if it should use madvise or prctl ksm merging.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 tools/testing/selftests/vm/Makefile    |   3 +-
 tools/testing/selftests/vm/ksm_tests.c | 116 +++++++++++++++++--------
 2 files changed, 80 insertions(+), 39 deletions(-)

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftest=
s/vm/Makefile
index 89c14e41bd43..8a50802d8700 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -25,7 +25,8 @@ MACHINE ?=3D $(shell echo $(uname_M) | sed -e 's/aarch6=
4.*/arm64/' -e 's/ppc64.*/p
 # LDLIBS.
 MAKEFLAGS +=3D --no-builtin-rules
=20
-CFLAGS =3D -Wall -I $(top_srcdir) -I $(top_srcdir)/usr/include $(EXTRA_C=
FLAGS) $(KHDR_INCLUDES)
+CFLAGS =3D -Wall -I $(top_srcdir)/tools/include/uapi
+CFLAGS +=3D -I $(top_srcdir) -I $(top_srcdir)/usr/include $(EXTRA_CFLAGS=
) $(KHDR_INCLUDES)
 LDLIBS =3D -lrt -lpthread
 TEST_GEN_FILES =3D cow
 TEST_GEN_FILES +=3D compaction_test
diff --git a/tools/testing/selftests/vm/ksm_tests.c b/tools/testing/selft=
ests/vm/ksm_tests.c
index f9eb4d67e0dd..386a0929c8a3 100644
--- a/tools/testing/selftests/vm/ksm_tests.c
+++ b/tools/testing/selftests/vm/ksm_tests.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
=20
 #include <sys/mman.h>
+#include <sys/prctl.h>
+#include <sys/wait.h>
 #include <stdbool.h>
 #include <time.h>
 #include <string.h>
@@ -21,6 +23,7 @@
 #define KSM_PROT_STR_DEFAULT "rw"
 #define KSM_USE_ZERO_PAGES_DEFAULT false
 #define KSM_MERGE_ACROSS_NODES_DEFAULT true
+#define KSM_MERGE_TYPE_DEFAULT 0
 #define MB (1ul << 20)
=20
 struct ksm_sysfs {
@@ -33,6 +36,12 @@ struct ksm_sysfs {
 	unsigned long use_zero_pages;
 };
=20
+enum ksm_merge_type {
+	KSM_MERGE_MADVISE,
+	KSM_MERGE_PRCTL,
+	KSM_MERGE_LAST =3D KSM_MERGE_PRCTL
+};
+
 enum ksm_test_name {
 	CHECK_KSM_MERGE,
 	CHECK_KSM_UNMERGE,
@@ -129,6 +138,10 @@ static void print_help(void)
 	printf(" -m: change merge_across_nodes tunable\n"
 	       "     Default: %d\n", KSM_MERGE_ACROSS_NODES_DEFAULT);
 	printf(" -s: the size of duplicated memory area (in MiB)\n");
+	printf(" -t: KSM merge type\n"
+	       "     Default: 0\n"
+	       "     0: madvise merging\n"
+	       "     1: prctl merging\n");
=20
 	exit(0);
 }
@@ -176,12 +189,21 @@ static int ksm_do_scan(int scan_count, struct times=
pec start_time, int timeout)
 	return 0;
 }
=20
-static int ksm_merge_pages(void *addr, size_t size, struct timespec star=
t_time, int timeout)
+static int ksm_merge_pages(int merge_type, void *addr, size_t size,
+			struct timespec start_time, int timeout)
 {
-	if (madvise(addr, size, MADV_MERGEABLE)) {
-		perror("madvise");
-		return 1;
+	if (merge_type =3D=3D KSM_MERGE_MADVISE) {
+		if (madvise(addr, size, MADV_MERGEABLE)) {
+			perror("madvise");
+			return 1;
+		}
+	} else if (merge_type =3D=3D KSM_MERGE_PRCTL) {
+		if (prctl(PR_SET_MEMORY_MERGE, 1)) {
+			perror("prctl");
+			return 1;
+		}
 	}
+
 	if (ksm_write_sysfs(KSM_FP("run"), 1))
 		return 1;
=20
@@ -266,7 +288,8 @@ static int ksm_restore(struct ksm_sysfs *ksm_sysfs)
 	return 0;
 }
=20
-static int check_ksm_merge(int mapping, int prot, long page_count, int t=
imeout, size_t page_size)
+static int check_ksm_merge(int merge_type, int mapping, int prot,
+			long page_count, int timeout, size_t page_size)
 {
 	void *map_ptr;
 	struct timespec start_time;
@@ -281,13 +304,16 @@ static int check_ksm_merge(int mapping, int prot, l=
ong page_count, int timeout,
 	if (!map_ptr)
 		return KSFT_FAIL;
=20
-	if (ksm_merge_pages(map_ptr, page_size * page_count, start_time, timeou=
t))
+	if (ksm_merge_pages(merge_type, map_ptr, page_size * page_count, start_=
time, timeout))
 		goto err_out;
=20
 	/* verify that the right number of pages are merged */
 	if (assert_ksm_pages_count(page_count)) {
 		printf("OK\n");
-		munmap(map_ptr, page_size * page_count);
+		if (merge_type =3D=3D KSM_MERGE_MADVISE)
+			munmap(map_ptr, page_size * page_count);
+		else if (merge_type =3D=3D KSM_MERGE_PRCTL)
+			prctl(PR_SET_MEMORY_MERGE, 0);
 		return KSFT_PASS;
 	}
=20
@@ -297,7 +323,7 @@ static int check_ksm_merge(int mapping, int prot, lon=
g page_count, int timeout,
 	return KSFT_FAIL;
 }
=20
-static int check_ksm_unmerge(int mapping, int prot, int timeout, size_t =
page_size)
+static int check_ksm_unmerge(int merge_type, int mapping, int prot, int =
timeout, size_t page_size)
 {
 	void *map_ptr;
 	struct timespec start_time;
@@ -313,7 +339,7 @@ static int check_ksm_unmerge(int mapping, int prot, i=
nt timeout, size_t page_siz
 	if (!map_ptr)
 		return KSFT_FAIL;
=20
-	if (ksm_merge_pages(map_ptr, page_size * page_count, start_time, timeou=
t))
+	if (ksm_merge_pages(merge_type, map_ptr, page_size * page_count, start_=
time, timeout))
 		goto err_out;
=20
 	/* change 1 byte in each of the 2 pages -- KSM must automatically unmer=
ge them */
@@ -337,8 +363,8 @@ static int check_ksm_unmerge(int mapping, int prot, i=
nt timeout, size_t page_siz
 	return KSFT_FAIL;
 }
=20
-static int check_ksm_zero_page_merge(int mapping, int prot, long page_co=
unt, int timeout,
-				     bool use_zero_pages, size_t page_size)
+static int check_ksm_zero_page_merge(int merge_type, int mapping, int pr=
ot, long page_count,
+				int timeout, bool use_zero_pages, size_t page_size)
 {
 	void *map_ptr;
 	struct timespec start_time;
@@ -356,7 +382,7 @@ static int check_ksm_zero_page_merge(int mapping, int=
 prot, long page_count, int
 	if (!map_ptr)
 		return KSFT_FAIL;
=20
-	if (ksm_merge_pages(map_ptr, page_size * page_count, start_time, timeou=
t))
+	if (ksm_merge_pages(merge_type, map_ptr, page_size * page_count, start_=
time, timeout))
 		goto err_out;
=20
        /*
@@ -402,8 +428,8 @@ static int get_first_mem_node(void)
 	return get_next_mem_node(numa_max_node());
 }
=20
-static int check_ksm_numa_merge(int mapping, int prot, int timeout, bool=
 merge_across_nodes,
-				size_t page_size)
+static int check_ksm_numa_merge(int merge_type, int mapping, int prot, i=
nt timeout,
+				bool merge_across_nodes, size_t page_size)
 {
 	void *numa1_map_ptr, *numa2_map_ptr;
 	struct timespec start_time;
@@ -439,8 +465,8 @@ static int check_ksm_numa_merge(int mapping, int prot=
, int timeout, bool merge_a
 	memset(numa2_map_ptr, '*', page_size);
=20
 	/* try to merge the pages */
-	if (ksm_merge_pages(numa1_map_ptr, page_size, start_time, timeout) ||
-	    ksm_merge_pages(numa2_map_ptr, page_size, start_time, timeout))
+	if (ksm_merge_pages(merge_type, numa1_map_ptr, page_size, start_time, t=
imeout) ||
+	    ksm_merge_pages(merge_type, numa2_map_ptr, page_size, start_time, t=
imeout))
 		goto err_out;
=20
        /*
@@ -466,7 +492,8 @@ static int check_ksm_numa_merge(int mapping, int prot=
, int timeout, bool merge_a
 	return KSFT_FAIL;
 }
=20
-static int ksm_merge_hugepages_time(int mapping, int prot, int timeout, =
size_t map_size)
+static int ksm_merge_hugepages_time(int merge_type, int mapping, int pro=
t,
+				int timeout, size_t map_size)
 {
 	void *map_ptr, *map_ptr_orig;
 	struct timespec start_time, end_time;
@@ -508,7 +535,7 @@ static int ksm_merge_hugepages_time(int mapping, int =
prot, int timeout, size_t m
 		perror("clock_gettime");
 		goto err_out;
 	}
-	if (ksm_merge_pages(map_ptr, map_size, start_time, timeout))
+	if (ksm_merge_pages(merge_type, map_ptr, map_size, start_time, timeout)=
)
 		goto err_out;
 	if (clock_gettime(CLOCK_MONOTONIC_RAW, &end_time)) {
 		perror("clock_gettime");
@@ -533,7 +560,7 @@ static int ksm_merge_hugepages_time(int mapping, int =
prot, int timeout, size_t m
 	return KSFT_FAIL;
 }
=20
-static int ksm_merge_time(int mapping, int prot, int timeout, size_t map=
_size)
+static int ksm_merge_time(int merge_type, int mapping, int prot, int tim=
eout, size_t map_size)
 {
 	void *map_ptr;
 	struct timespec start_time, end_time;
@@ -549,7 +576,7 @@ static int ksm_merge_time(int mapping, int prot, int =
timeout, size_t map_size)
 		perror("clock_gettime");
 		goto err_out;
 	}
-	if (ksm_merge_pages(map_ptr, map_size, start_time, timeout))
+	if (ksm_merge_pages(merge_type, map_ptr, map_size, start_time, timeout)=
)
 		goto err_out;
 	if (clock_gettime(CLOCK_MONOTONIC_RAW, &end_time)) {
 		perror("clock_gettime");
@@ -574,7 +601,7 @@ static int ksm_merge_time(int mapping, int prot, int =
timeout, size_t map_size)
 	return KSFT_FAIL;
 }
=20
-static int ksm_unmerge_time(int mapping, int prot, int timeout, size_t m=
ap_size)
+static int ksm_unmerge_time(int merge_type, int mapping, int prot, int t=
imeout, size_t map_size)
 {
 	void *map_ptr;
 	struct timespec start_time, end_time;
@@ -589,7 +616,7 @@ static int ksm_unmerge_time(int mapping, int prot, in=
t timeout, size_t map_size)
 		perror("clock_gettime");
 		goto err_out;
 	}
-	if (ksm_merge_pages(map_ptr, map_size, start_time, timeout))
+	if (ksm_merge_pages(merge_type, map_ptr, map_size, start_time, timeout)=
)
 		goto err_out;
=20
 	if (clock_gettime(CLOCK_MONOTONIC_RAW, &start_time)) {
@@ -621,7 +648,7 @@ static int ksm_unmerge_time(int mapping, int prot, in=
t timeout, size_t map_size)
 	return KSFT_FAIL;
 }
=20
-static int ksm_cow_time(int mapping, int prot, int timeout, size_t page_=
size)
+static int ksm_cow_time(int merge_type, int mapping, int prot, int timeo=
ut, size_t page_size)
 {
 	void *map_ptr;
 	struct timespec start_time, end_time;
@@ -660,7 +687,7 @@ static int ksm_cow_time(int mapping, int prot, int ti=
meout, size_t page_size)
 		memset(map_ptr + page_size * i, '+', i / 2 + 1);
 		memset(map_ptr + page_size * (i + 1), '+', i / 2 + 1);
 	}
-	if (ksm_merge_pages(map_ptr, page_size * page_count, start_time, timeou=
t))
+	if (ksm_merge_pages(merge_type, map_ptr, page_size * page_count, start_=
time, timeout))
 		goto err_out;
=20
 	if (clock_gettime(CLOCK_MONOTONIC_RAW, &start_time)) {
@@ -697,6 +724,7 @@ int main(int argc, char *argv[])
 	int ret, opt;
 	int prot =3D 0;
 	int ksm_scan_limit_sec =3D KSM_SCAN_LIMIT_SEC_DEFAULT;
+	int merge_type =3D KSM_MERGE_TYPE_DEFAULT;
 	long page_count =3D KSM_PAGE_COUNT_DEFAULT;
 	size_t page_size =3D sysconf(_SC_PAGESIZE);
 	struct ksm_sysfs ksm_sysfs_old;
@@ -705,7 +733,7 @@ int main(int argc, char *argv[])
 	bool merge_across_nodes =3D KSM_MERGE_ACROSS_NODES_DEFAULT;
 	long size_MB =3D 0;
=20
-	while ((opt =3D getopt(argc, argv, "ha:p:l:z:m:s:MUZNPCHD")) !=3D -1) {
+	while ((opt =3D getopt(argc, argv, "ha:p:l:z:m:s:t:MUZNPCHD")) !=3D -1)=
 {
 		switch (opt) {
 		case 'a':
 			prot =3D str_to_prot(optarg);
@@ -745,6 +773,17 @@ int main(int argc, char *argv[])
 				printf("Size must be greater than 0\n");
 				return KSFT_FAIL;
 			}
+		case 't':
+			{
+				int tmp =3D atoi(optarg);
+
+				if (tmp < 0 || tmp > KSM_MERGE_LAST) {
+					printf("Invalid merge type\n");
+					return KSFT_FAIL;
+				}
+				merge_type =3D atoi(optarg);
+			}
+			break;
 		case 'M':
 			break;
 		case 'U':
@@ -795,35 +834,36 @@ int main(int argc, char *argv[])
=20
 	switch (test_name) {
 	case CHECK_KSM_MERGE:
-		ret =3D check_ksm_merge(MAP_PRIVATE | MAP_ANONYMOUS, prot, page_count,
+		ret =3D check_ksm_merge(merge_type, MAP_PRIVATE | MAP_ANONYMOUS, prot,=
 page_count,
 				      ksm_scan_limit_sec, page_size);
 		break;
 	case CHECK_KSM_UNMERGE:
-		ret =3D check_ksm_unmerge(MAP_PRIVATE | MAP_ANONYMOUS, prot, ksm_scan_=
limit_sec,
-					page_size);
+		ret =3D check_ksm_unmerge(merge_type, MAP_PRIVATE | MAP_ANONYMOUS, pro=
t,
+					ksm_scan_limit_sec, page_size);
 		break;
 	case CHECK_KSM_ZERO_PAGE_MERGE:
-		ret =3D check_ksm_zero_page_merge(MAP_PRIVATE | MAP_ANONYMOUS, prot, p=
age_count,
-						ksm_scan_limit_sec, use_zero_pages, page_size);
+		ret =3D check_ksm_zero_page_merge(merge_type, MAP_PRIVATE | MAP_ANONYM=
OUS, prot,
+						page_count, ksm_scan_limit_sec, use_zero_pages,
+						page_size);
 		break;
 	case CHECK_KSM_NUMA_MERGE:
-		ret =3D check_ksm_numa_merge(MAP_PRIVATE | MAP_ANONYMOUS, prot, ksm_sc=
an_limit_sec,
-					   merge_across_nodes, page_size);
+		ret =3D check_ksm_numa_merge(merge_type, MAP_PRIVATE | MAP_ANONYMOUS, =
prot,
+					ksm_scan_limit_sec, merge_across_nodes, page_size);
 		break;
 	case KSM_MERGE_TIME:
 		if (size_MB =3D=3D 0) {
 			printf("Option '-s' is required.\n");
 			return KSFT_FAIL;
 		}
-		ret =3D ksm_merge_time(MAP_PRIVATE | MAP_ANONYMOUS, prot, ksm_scan_lim=
it_sec,
-				     size_MB);
+		ret =3D ksm_merge_time(merge_type, MAP_PRIVATE | MAP_ANONYMOUS, prot,
+				ksm_scan_limit_sec, size_MB);
 		break;
 	case KSM_MERGE_TIME_HUGE_PAGES:
 		if (size_MB =3D=3D 0) {
 			printf("Option '-s' is required.\n");
 			return KSFT_FAIL;
 		}
-		ret =3D ksm_merge_hugepages_time(MAP_PRIVATE | MAP_ANONYMOUS, prot,
+		ret =3D ksm_merge_hugepages_time(merge_type, MAP_PRIVATE | MAP_ANONYMO=
US, prot,
 				ksm_scan_limit_sec, size_MB);
 		break;
 	case KSM_UNMERGE_TIME:
@@ -831,12 +871,12 @@ int main(int argc, char *argv[])
 			printf("Option '-s' is required.\n");
 			return KSFT_FAIL;
 		}
-		ret =3D ksm_unmerge_time(MAP_PRIVATE | MAP_ANONYMOUS, prot,
+		ret =3D ksm_unmerge_time(merge_type, MAP_PRIVATE | MAP_ANONYMOUS, prot=
,
 				       ksm_scan_limit_sec, size_MB);
 		break;
 	case KSM_COW_TIME:
-		ret =3D ksm_cow_time(MAP_PRIVATE | MAP_ANONYMOUS, prot, ksm_scan_limit=
_sec,
-				   page_size);
+		ret =3D ksm_cow_time(merge_type, MAP_PRIVATE | MAP_ANONYMOUS, prot,
+				ksm_scan_limit_sec, page_size);
 		break;
 	}
=20
--=20
2.30.2

