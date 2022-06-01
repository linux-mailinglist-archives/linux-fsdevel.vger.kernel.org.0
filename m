Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD05B53B038
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jun 2022 00:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbiFAVK3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jun 2022 17:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbiFAVKK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jun 2022 17:10:10 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A811B3A19D
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jun 2022 14:10:06 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 85-20020a250358000000b0065b9b24987aso2456048ybd.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jun 2022 14:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dcDBeY/HLlNXef9d9FAHPxWe/EV2aZU1witDOt2KoeY=;
        b=KaDwHX79CJbASDMmgXRlKLc/huskW7utSclJ0kfppbnZS1T/syXXX0OOqqco2+9elP
         5EBfVeZWFsTr/FQRRajBdxKDD8WMBg7o9fiYLOlSBVHnkUMU6qLlmQ8wbxRiy97vjj1n
         d1MHsEJH+Fi8Yb2ErPHvZ95O8Pno4nEVoSdAmNwSrCbw8KI+39rmeI321hQC0x1VXEWa
         VizEGAex47VEQ4UJzuGfcJgV8KzlCSFFPFdauODxm1cORxr0QYeWj8tzyU2u86tekVow
         Y2TOE/hImTDvfKNFRWfSNAw6WFb0njnagrXm1EE2xQotfnLtM0lz0f8/yYojMTbYOQce
         HPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dcDBeY/HLlNXef9d9FAHPxWe/EV2aZU1witDOt2KoeY=;
        b=Xfcg77K7nAnqZGSogQTPYUH83zYm7EUHMr8npMj6m8uCNFhaPtiX3DkpSCx2X92bdg
         aVMVHWypj6cHrR9l4kSNCIUSmQY+s2BfmfR5fRegQX1PL34t6fP75czAY15ob1EtNfLK
         ZMCmvpBDG1Vb0W4oK4J5KF7VMIPL/jpc/NOXZ+nGfM1wL/fquu1HFTlKo8YbLCZC0nJS
         8JDl61yJbjnxBhELdB6MLcUq7kG+nCMEEuuWWGJTL/4u7RWa88K9WhuW/taY1+yLrFhh
         yAwlEKBAtu4c7bZu5smbkJZBhG+vB3SB5RmumWzkrYO4TuN79SXlcQMdE1u1Yi1CoaN2
         5F/w==
X-Gm-Message-State: AOAM5309DxNqQGihYtcbQqdyue+z2vXQ3HasgtKfXNuTz9EKRFRBZfVv
        Of/AlhGHrKk4J6WybXY2oESB8RU9B3w2U3iG20ja
X-Google-Smtp-Source: ABdhPJykmwhlBXZrVDl0pEafra93LcclZ+yr17pnesiatozzZ/fWqR+h2P6cAMloCLCsdJazTqo9524d106wb6pcRX79
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:aaec:e358:9f0e:2b26])
 (user=axelrasmussen job=sendgmr) by 2002:a25:744:0:b0:64f:79e5:6528 with SMTP
 id 65-20020a250744000000b0064f79e56528mr1969376ybh.104.1654117805867; Wed, 01
 Jun 2022 14:10:05 -0700 (PDT)
Date:   Wed,  1 Jun 2022 14:09:50 -0700
In-Reply-To: <20220601210951.3916598-1-axelrasmussen@google.com>
Message-Id: <20220601210951.3916598-6-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20220601210951.3916598-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v3 5/6] userfaultfd: selftests: make /dev/userfaultfd testing configurable
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Charan Teja Reddy <charante@codeaurora.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, zhangyi <yi.zhang@huawei.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of always testing both userfaultfd(2) and /dev/userfaultfd,
let the user choose which to test.

As with other test features, change the behavior based on a new
command line flag. Introduce the idea of "test mods", which are
generic (not specific to a test type) modifications to the behavior of
the test. This is sort of borrowed from this RFC patch series [1], but
simplified a bit.

The benefit is, in "typical" configurations this test is somewhat slow
(say, 30sec or something). Testing both clearly doubles it, so it may
not always be desirable, as users are likely to use one or the other,
but never both, in the "real world".

[1]: https://patchwork.kernel.org/project/linux-mm/patch/20201129004548.1619714-14-namit@vmware.com/

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 41 +++++++++++++++++-------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 1badb5d31bf9..aeee6f1ad8ef 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -128,6 +128,8 @@ struct uffd_stats {
 const char *examples =
     "# Run anonymous memory test on 100MiB region with 99999 bounces:\n"
     "./userfaultfd anon 100 99999\n\n"
+    "# Run the same anonymous memory test, but using /dev/userfaultfd:\n"
+    "./userfaultfd anon:dev 100 99999\n\n"
     "# Run share memory test on 1GiB region with 99 bounces:\n"
     "./userfaultfd shmem 1000 99\n\n"
     "# Run hugetlb memory test on 256MiB region with 50 bounces:\n"
@@ -144,6 +146,13 @@ static void usage(void)
 		"[hugetlbfs_file]\n\n");
 	fprintf(stderr, "Supported <test type>: anon, hugetlb, "
 		"hugetlb_shared, shmem\n\n");
+	fprintf(stderr, "'Test mods' can be joined to the test type string with a ':'. "
+		"Supported mods:\n");
+	fprintf(stderr, "\tdev - Use /dev/userfaultfd instead of userfaultfd(2)\n");
+	fprintf(stderr, "\nExample test mod usage:\n");
+	fprintf(stderr, "# Run anonymous memory test with /dev/userfaultfd:\n");
+	fprintf(stderr, "./userfaultfd anon:dev 100 99999\n\n");
+
 	fprintf(stderr, "Examples:\n\n");
 	fprintf(stderr, "%s", examples);
 	exit(1);
@@ -1607,8 +1616,6 @@ unsigned long default_huge_page_size(void)
 
 static void set_test_type(const char *type)
 {
-	uint64_t features = UFFD_API_FEATURES;
-
 	if (!strcmp(type, "anon")) {
 		test_type = TEST_ANON;
 		uffd_test_ops = &anon_uffd_test_ops;
@@ -1626,10 +1633,28 @@ static void set_test_type(const char *type)
 		test_type = TEST_SHMEM;
 		uffd_test_ops = &shmem_uffd_test_ops;
 		test_uffdio_minor = true;
-	} else {
-		err("Unknown test type: %s", type);
+	}
+}
+
+static void parse_test_type_arg(const char *raw_type)
+{
+	char *buf = strdup(raw_type);
+	uint64_t features = UFFD_API_FEATURES;
+
+	while (buf) {
+		const char *token = strsep(&buf, ":");
+
+		if (!test_type)
+			set_test_type(token);
+		else if (!strcmp(token, "dev"))
+			test_dev_userfaultfd = true;
+		else
+			err("unrecognized test mod '%s'", token);
 	}
 
+	if (!test_type)
+		err("failed to parse test type argument: '%s'", raw_type);
+
 	if (test_type == TEST_HUGETLB)
 		page_size = default_huge_page_size();
 	else
@@ -1676,7 +1701,7 @@ int main(int argc, char **argv)
 		err("failed to arm SIGALRM");
 	alarm(ALARM_INTERVAL_SECS);
 
-	set_test_type(argv[1]);
+	parse_test_type_arg(argv[1]);
 
 	nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
 	nr_pages_per_cpu = atol(argv[2]) * 1024*1024 / page_size /
@@ -1714,12 +1739,6 @@ int main(int argc, char **argv)
 	}
 	printf("nr_pages: %lu, nr_pages_per_cpu: %lu\n",
 	       nr_pages, nr_pages_per_cpu);
-
-	test_dev_userfaultfd = false;
-	if (userfaultfd_stress())
-		return 1;
-
-	test_dev_userfaultfd = true;
 	return userfaultfd_stress();
 }
 
-- 
2.36.1.255.ge46751e96f-goog

