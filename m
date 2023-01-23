Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DACF6783BB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 18:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbjAWR4z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 12:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbjAWR4y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:56:54 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC982BECF
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jan 2023 09:56:53 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id 910905616BFB; Mon, 23 Jan 2023 09:37:56 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     linux-mm@kvack.org
Cc:     shr@devkernel.io, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [RESEND RFC PATCH v1 20/20] selftests/vm: add two functions for debugging merge outcome
Date:   Mon, 23 Jan 2023 09:37:48 -0800
Message-Id: <20230123173748.1734238-21-shr@devkernel.io>
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

This adds two functions to report the metrics in /proc/self/ksm_stat and
/sys/kernel/debug/mm/ksm.

The debugging can be enabled with the following command line:
make -C tools/testing/selftests TARGETS=3D"vm" --keep-going \
        EXTRA_CFLAGS=3D-DDEBUG=3D1

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 tools/testing/selftests/vm/ksm_tests.c | 54 ++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/tools/testing/selftests/vm/ksm_tests.c b/tools/testing/selft=
ests/vm/ksm_tests.c
index a0a48ac43b29..9fb21b982dc9 100644
--- a/tools/testing/selftests/vm/ksm_tests.c
+++ b/tools/testing/selftests/vm/ksm_tests.c
@@ -93,6 +93,55 @@ static int ksm_read_sysfs(const char *file_path, unsig=
ned long *val)
 	return 0;
 }
=20
+#ifdef DEBUG
+static void ksm_print_sysfs(void)
+{
+	unsigned long max_page_sharing, pages_sharing, pages_shared;
+	unsigned long full_scans, pages_unshared, pages_volatile;
+	unsigned long stable_node_chains, stable_node_dups;
+	long general_profit;
+
+	if (ksm_read_sysfs(KSM_FP("pages_shared"), &pages_shared) ||
+	    ksm_read_sysfs(KSM_FP("pages_sharing"), &pages_sharing) ||
+	    ksm_read_sysfs(KSM_FP("max_page_sharing"), &max_page_sharing) ||
+	    ksm_read_sysfs(KSM_FP("full_scans"), &full_scans) ||
+	    ksm_read_sysfs(KSM_FP("pages_unshared"), &pages_unshared) ||
+	    ksm_read_sysfs(KSM_FP("pages_volatile"), &pages_volatile) ||
+	    ksm_read_sysfs(KSM_FP("stable_node_chains"), &stable_node_chains) |=
|
+	    ksm_read_sysfs(KSM_FP("stable_node_dups"), &stable_node_dups) ||
+	    ksm_read_sysfs(KSM_FP("general_profit"), (unsigned long *)&general_=
profit))
+		return;
+
+	printf("pages_shared      : %lu\n", pages_shared);
+	printf("pages_sharing     : %lu\n", pages_sharing);
+	printf("max_page_sharing  : %lu\n", max_page_sharing);
+	printf("full_scans        : %lu\n", full_scans);
+	printf("pages_unshared    : %lu\n", pages_unshared);
+	printf("pages_volatile    : %lu\n", pages_volatile);
+	printf("stable_node_chains: %lu\n", stable_node_chains);
+	printf("stable_node_dups  : %lu\n", stable_node_dups);
+	printf("general_profit    : %ld\n", general_profit);
+}
+
+static void ksm_print_procfs(void)
+{
+	const char *file_name =3D "/proc/self/ksm_stat";
+	char buffer[512];
+	FILE *f =3D fopen(file_name, "r");
+
+	if (!f) {
+		fprintf(stderr, "f %s\n", file_name);
+		perror("fopen");
+		return;
+	}
+
+	while (fgets(buffer, sizeof(buffer), f))
+		printf("%s", buffer);
+
+	fclose(f);
+}
+#endif
+
 static int str_to_prot(char *prot_str)
 {
 	int prot =3D 0;
@@ -237,6 +286,11 @@ static bool assert_ksm_pages_count(long dupl_page_co=
unt)
 	    ksm_read_sysfs(KSM_FP("max_page_sharing"), &max_page_sharing))
 		return false;
=20
+#ifdef DEBUG
+	ksm_print_sysfs();
+	ksm_print_procfs();
+#endif
+
 	/*
 	 * Since there must be at least 2 pages for merging and 1 page can be
 	 * shared with the limited number of pages (max_page_sharing), sometime=
s
--=20
2.30.2

