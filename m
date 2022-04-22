Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D127850C3C4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Apr 2022 01:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbiDVWib (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 18:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234089AbiDVWh5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:37:57 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5309F288EEE
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 14:30:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a18-20020a25bad2000000b0063360821ea7so8223627ybk.15
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 14:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1YOjrnQqyN8cWPWkvfNUjTufFbltn2OwC2/XNWaN1e0=;
        b=VXaVbbtBV03bulzAic2gmN8NCLz/V3ogNL6IMpUPoIEsATtTIJStusANwVvrAoLxjv
         fkvqlb6oQ96giIPTD0RY1s7jdxptuPWu8kfoVzvuOg8C0C32WXl8qZzv11n9fppg3P7z
         MCzA2nE/4x8vHUZC/oFKsQJxeBxpCSO9DZyv/RHB6igxtBeXTcNLvhOBUrMONmTXITmC
         Q1HuwamYVWWP6rtLGSDmD58hOW5WRi7ZxZVg45RtfHx4jYax2LP8OdDXzya11iu+o6tk
         88F+2mzpijpTSk69INGoR0ljgkz4YKldnOs3vhQc2Ls/zSToXGQz4AiQRTmuyuOTSk79
         WQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1YOjrnQqyN8cWPWkvfNUjTufFbltn2OwC2/XNWaN1e0=;
        b=RVdawLYMD3buaVYpduscuh1eh8/yQfN+00th/EjDm2HRXFkbaPGJBxYAn5+YYBT8f6
         /yYy4MyfuyItdBkEuyBdt+WWYC70NwNFzhA2EfavZWHzqcoUDExeJi5EGbh1F098znuU
         1rugarxFXYNndD9Nr/u8DARfsQ0PkRiDC+TBkA0ZO4Kcplt+wcjX78IcvwhZS3t4fhdh
         s0AxRkZDyZXzbXNdSnt9eVyMvvWwDP1utb+x/ZR9JX9zSBs1YRwqqthSGb/lWISNKCxK
         tkKRhyAzLbdoJqSpMRaonsWLcLE1bBY8l65zL2httmRpEe0y1AC+EzEQrNK1lnAl/aZf
         QSNA==
X-Gm-Message-State: AOAM531PtgReaT6BFOvmzk52y0tE31r0hS2TKx2ooIjzFcCLgvtbXcFm
        mNJqzsoMzyZ9+LV2y/qhMYR7T128tV/Ig1RvIImj
X-Google-Smtp-Source: ABdhPJyvEbcz/g37JS1iHe7tFbj9IzynivIbmgA81koqkS0c5Hqgo9XHv7TCJvVa1vy3xfQL4hFPgo3isBOBJ39pAMse
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:7ba6:20ac:a8f7:1dbd])
 (user=axelrasmussen job=sendgmr) by 2002:a25:df8a:0:b0:647:4954:83e8 with
 SMTP id w132-20020a25df8a000000b00647495483e8mr645787ybg.526.1650663002551;
 Fri, 22 Apr 2022 14:30:02 -0700 (PDT)
Date:   Fri, 22 Apr 2022 14:29:44 -0700
In-Reply-To: <20220422212945.2227722-1-axelrasmussen@google.com>
Message-Id: <20220422212945.2227722-6-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20220422212945.2227722-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v2 5/6] userfaultfd: selftests: make /dev/userfaultfd testing configurable
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
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
index 12ae742a9981..274522704e40 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -142,8 +142,17 @@ static void usage(void)
 {
 	fprintf(stderr, "\nUsage: ./userfaultfd <test type> <MiB> <bounces> "
 		"[hugetlbfs_file]\n\n");
+
 	fprintf(stderr, "Supported <test type>: anon, hugetlb, "
 		"hugetlb_shared, shmem\n\n");
+
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
@@ -1610,8 +1619,6 @@ unsigned long default_huge_page_size(void)
 
 static void set_test_type(const char *type)
 {
-	uint64_t features = UFFD_API_FEATURES;
-
 	if (!strcmp(type, "anon")) {
 		test_type = TEST_ANON;
 		uffd_test_ops = &anon_uffd_test_ops;
@@ -1631,10 +1638,28 @@ static void set_test_type(const char *type)
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
@@ -1681,7 +1706,7 @@ int main(int argc, char **argv)
 		err("failed to arm SIGALRM");
 	alarm(ALARM_INTERVAL_SECS);
 
-	set_test_type(argv[1]);
+	parse_test_type_arg(argv[1]);
 
 	nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
 	nr_pages_per_cpu = atol(argv[2]) * 1024*1024 / page_size /
@@ -1719,12 +1744,6 @@ int main(int argc, char **argv)
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
2.36.0.rc2.479.g8af0fa9b8e-goog

