Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60EC5678406
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 19:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbjAWSEV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 13:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbjAWSEV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:04:21 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21791DBC3
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jan 2023 10:04:05 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id 8864D5616BF7; Mon, 23 Jan 2023 09:37:56 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     linux-mm@kvack.org
Cc:     shr@devkernel.io, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [RESEND RFC PATCH v1 18/20] selftests/vm: add KSM get merge type test
Date:   Mon, 23 Jan 2023 09:37:46 -0800
Message-Id: <20230123173748.1734238-19-shr@devkernel.io>
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

This adds the -G flag to the ksm_tests to query if prctl has been used
to enable ksm merging.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 tools/testing/selftests/vm/ksm_tests.c | 37 ++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vm/ksm_tests.c b/tools/testing/selft=
ests/vm/ksm_tests.c
index 386a0929c8a3..9667cb3b8c6a 100644
--- a/tools/testing/selftests/vm/ksm_tests.c
+++ b/tools/testing/selftests/vm/ksm_tests.c
@@ -45,6 +45,7 @@ enum ksm_merge_type {
 enum ksm_test_name {
 	CHECK_KSM_MERGE,
 	CHECK_KSM_UNMERGE,
+	CHECK_KSM_GET_MERGE_TYPE,
 	CHECK_KSM_ZERO_PAGE_MERGE,
 	CHECK_KSM_NUMA_MERGE,
 	KSM_MERGE_TIME,
@@ -124,7 +125,8 @@ static void print_help(void)
 	       " -D evaluate unmerging time and speed when disabling KSM.\n"
 	       "    For this test, the size of duplicated memory area (in MiB)\=
n"
 	       "    must be provided using -s option\n"
-	       " -C evaluate the time required to break COW of merged pages.\n\=
n");
+	       " -C evaluate the time required to break COW of merged pages.\n"
+	       " -G query merge mode\n\n");
=20
 	printf(" -a: specify the access protections of pages.\n"
 	       "     <prot> must be of the form [rwx].\n"
@@ -323,6 +325,31 @@ static int check_ksm_merge(int merge_type, int mappi=
ng, int prot,
 	return KSFT_FAIL;
 }
=20
+static int check_ksm_get_merge_type(void)
+{
+	if (prctl(PR_SET_MEMORY_MERGE, 1)) {
+		perror("prctl set");
+		return 1;
+	}
+
+	int is_on =3D prctl(PR_GET_MEMORY_MERGE, 0);
+
+	if (prctl(PR_SET_MEMORY_MERGE, 0)) {
+		perror("prctl set");
+		return 1;
+	}
+
+	int is_off =3D prctl(PR_GET_MEMORY_MERGE, 0);
+
+	if (is_on && is_off) {
+		printf("OK\n");
+		return KSFT_PASS;
+	}
+
+	printf("Not OK\n");
+	return KSFT_FAIL;
+}
+
 static int check_ksm_unmerge(int merge_type, int mapping, int prot, int =
timeout, size_t page_size)
 {
 	void *map_ptr;
@@ -733,7 +760,7 @@ int main(int argc, char *argv[])
 	bool merge_across_nodes =3D KSM_MERGE_ACROSS_NODES_DEFAULT;
 	long size_MB =3D 0;
=20
-	while ((opt =3D getopt(argc, argv, "ha:p:l:z:m:s:t:MUZNPCHD")) !=3D -1)=
 {
+	while ((opt =3D getopt(argc, argv, "ha:p:l:z:m:s:t:GMUZNPCHD")) !=3D -1=
) {
 		switch (opt) {
 		case 'a':
 			prot =3D str_to_prot(optarg);
@@ -792,6 +819,9 @@ int main(int argc, char *argv[])
 		case 'Z':
 			test_name =3D CHECK_KSM_ZERO_PAGE_MERGE;
 			break;
+		case 'G':
+			test_name =3D CHECK_KSM_GET_MERGE_TYPE;
+			break;
 		case 'N':
 			test_name =3D CHECK_KSM_NUMA_MERGE;
 			break;
@@ -841,6 +871,9 @@ int main(int argc, char *argv[])
 		ret =3D check_ksm_unmerge(merge_type, MAP_PRIVATE | MAP_ANONYMOUS, pro=
t,
 					ksm_scan_limit_sec, page_size);
 		break;
+	case CHECK_KSM_GET_MERGE_TYPE:
+		ret =3D check_ksm_get_merge_type();
+		break;
 	case CHECK_KSM_ZERO_PAGE_MERGE:
 		ret =3D check_ksm_zero_page_merge(merge_type, MAP_PRIVATE | MAP_ANONYM=
OUS, prot,
 						page_count, ksm_scan_limit_sec, use_zero_pages,
--=20
2.30.2

