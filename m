Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDAEB59791C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 23:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242371AbiHQVsA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 17:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242260AbiHQVrw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 17:47:52 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B989AB410
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 14:47:40 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3345ad926f2so73821887b3.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 14:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=yddoa+559b8nrUIn5RkzA6LuoLnD/Z+9mfZhmJLmujQ=;
        b=m9tiA0nPg/s7VYVOjcdjDNni4budWfetLx4rz82pZbVDwEPrPwRNE+d0za8Ah41wVX
         fAZ9qV7UwzKqhXTuh15M/FMYRAjV5W8R9lY//jQ5RJ+qm9Pu+o+KpTelgenH5TAnKE4X
         cvQWA++nmAxmU3CLPfqnSRY+N+KY8PPFoBLYeOwn7NxThxdLKXwGQkhEwwKZ4utGheye
         gRVg8rFECj25MeBphygKyPxeUprIcAXTnCEkY8F1Sz9BHEmIldeeg5VjXBGC2pnmhIOp
         48WWLZ9QbUGdbla+SIs+rDOPKuT+EF2+7NZ004G3S1o0JwvkQ3HqTFd0RUz1R9bkouNS
         zmCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=yddoa+559b8nrUIn5RkzA6LuoLnD/Z+9mfZhmJLmujQ=;
        b=QBV0RZmqt69cOii7tPEgO93+BMromQ0jRIkD4Kicz5IW06WLFRw3zSGk1ditpCr8M2
         ehNLf28kzou63LbFKu/9ECzbHnfRiEargo+zCA6HFX4J7P03pWlI5Y2VHpDyFou1aeJ2
         g8tsjm7e02LpVCGPKTGQlMctAzwyc8VRUgXw5tcftDWLQNeAzwHv1rAvTHgGMiHgf49O
         NOEIMUO+Q6HpOz+ZnIq4+VWXjWulQsDL//lrMAtLxR5/N+ADQLBRKyT1in8nCTYx068Z
         DXUNfSnIKZ+cLGh/K6CL/H2Fy3/YtcDurzSob9W/OnG7S+veN22Bz1Ff6X0CR8ZxiAzQ
         xZug==
X-Gm-Message-State: ACgBeo2xMSjPOzDPSkVvjBQY0EwjGDzi2ByfwrdIu67xX2Crd6Fiy4Rc
        LWHNKUpsnExSi97zCJG7vzAfANOmg7pSAzY+cn/I
X-Google-Smtp-Source: AA6agR5uiGSbWNSyAVwfvEjoliYuIG/CANePnm5YVailnBUiHaTKY38N4XKiRjGKv1XOqkLFxT5GeSaoN05kueWOJ71k
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2d4:203:2f41:f176:4bac:b729])
 (user=axelrasmussen job=sendgmr) by 2002:a5b:a0d:0:b0:689:9eee:348f with SMTP
 id k13-20020a5b0a0d000000b006899eee348fmr219249ybq.111.1660772859837; Wed, 17
 Aug 2022 14:47:39 -0700 (PDT)
Date:   Wed, 17 Aug 2022 14:47:26 -0700
In-Reply-To: <20220817214728.489904-1-axelrasmussen@google.com>
Message-Id: <20220817214728.489904-4-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20220817214728.489904-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v6 3/5] userfaultfd: selftests: modify selftest to use /dev/userfaultfd
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
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

We clearly want to ensure both userfaultfd(2) and /dev/userfaultfd keep
working into the future, so just run the test twice, using each
interface.

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

Acked-by: Mike Rapoport <rppt@linux.ibm.com>
Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 76 ++++++++++++++++++++----
 1 file changed, 66 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 7c3f1b0ab468..7be709d9eed0 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -77,6 +77,11 @@ static int bounces;
 #define TEST_SHMEM	3
 static int test_type;
 
+#define UFFD_FLAGS	(O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY)
+
+/* test using /dev/userfaultfd, instead of userfaultfd(2) */
+static bool test_dev_userfaultfd;
+
 /* exercise the test_uffdio_*_eexist every ALARM_INTERVAL_SECS */
 #define ALARM_INTERVAL_SECS 10
 static volatile bool test_uffdio_copy_eexist = true;
@@ -125,6 +130,8 @@ struct uffd_stats {
 const char *examples =
     "# Run anonymous memory test on 100MiB region with 99999 bounces:\n"
     "./userfaultfd anon 100 99999\n\n"
+    "# Run the same anonymous memory test, but using /dev/userfaultfd:\n"
+    "./userfaultfd anon:dev 100 99999\n\n"
     "# Run share memory test on 1GiB region with 99 bounces:\n"
     "./userfaultfd shmem 1000 99\n\n"
     "# Run hugetlb memory test on 256MiB region with 50 bounces:\n"
@@ -141,6 +148,14 @@ static void usage(void)
 		"[hugetlbfs_file]\n\n");
 	fprintf(stderr, "Supported <test type>: anon, hugetlb, "
 		"hugetlb_shared, shmem\n\n");
+	fprintf(stderr, "'Test mods' can be joined to the test type string with a ':'. "
+		"Supported mods:\n");
+	fprintf(stderr, "\tsyscall - Use userfaultfd(2) (default)\n");
+	fprintf(stderr, "\tdev - Use /dev/userfaultfd instead of userfaultfd(2)\n");
+	fprintf(stderr, "\nExample test mod usage:\n");
+	fprintf(stderr, "# Run anonymous memory test with /dev/userfaultfd:\n");
+	fprintf(stderr, "./userfaultfd anon:dev 100 99999\n\n");
+
 	fprintf(stderr, "Examples:\n\n");
 	fprintf(stderr, "%s", examples);
 	exit(1);
@@ -154,12 +169,14 @@ static void usage(void)
 			ret, __LINE__);				\
 	} while (0)
 
-#define err(fmt, ...)				\
+#define errexit(exitcode, fmt, ...)		\
 	do {					\
 		_err(fmt, ##__VA_ARGS__);	\
-		exit(1);			\
+		exit(exitcode);			\
 	} while (0)
 
+#define err(fmt, ...) errexit(1, fmt, ##__VA_ARGS__)
+
 static void uffd_stats_reset(struct uffd_stats *uffd_stats,
 			     unsigned long n_cpus)
 {
@@ -383,13 +400,34 @@ static void assert_expected_ioctls_present(uint64_t mode, uint64_t ioctls)
 	}
 }
 
+static int __userfaultfd_open_dev(void)
+{
+	int fd, _uffd;
+
+	fd = open("/dev/userfaultfd", O_RDWR | O_CLOEXEC);
+	if (fd < 0)
+		errexit(KSFT_SKIP, "opening /dev/userfaultfd failed");
+
+	_uffd = ioctl(fd, USERFAULTFD_IOC_NEW, UFFD_FLAGS);
+	if (_uffd < 0)
+		errexit(errno == ENOTTY ? KSFT_SKIP : 1,
+			"creating userfaultfd failed");
+	close(fd);
+	return _uffd;
+}
+
 static void userfaultfd_open(uint64_t *features)
 {
 	struct uffdio_api uffdio_api;
 
-	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY);
-	if (uffd < 0)
-		err("userfaultfd syscall not available in this kernel");
+	if (test_dev_userfaultfd)
+		uffd = __userfaultfd_open_dev();
+	else {
+		uffd = syscall(__NR_userfaultfd, UFFD_FLAGS);
+		if (uffd < 0)
+			errexit(errno == ENOSYS ? KSFT_SKIP : 1,
+				"creating userfaultfd failed");
+	}
 	uffd_flags = fcntl(uffd, F_GETFD, NULL);
 
 	uffdio_api.api = UFFD_API;
@@ -1584,8 +1622,6 @@ unsigned long default_huge_page_size(void)
 
 static void set_test_type(const char *type)
 {
-	uint64_t features = UFFD_API_FEATURES;
-
 	if (!strcmp(type, "anon")) {
 		test_type = TEST_ANON;
 		uffd_test_ops = &anon_uffd_test_ops;
@@ -1603,9 +1639,29 @@ static void set_test_type(const char *type)
 		test_type = TEST_SHMEM;
 		uffd_test_ops = &shmem_uffd_test_ops;
 		test_uffdio_minor = true;
-	} else {
-		err("Unknown test type: %s", type);
 	}
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
+		else if (!strcmp(token, "syscall"))
+			test_dev_userfaultfd = false;
+		else
+			err("unrecognized test mod '%s'", token);
+	}
+
+	if (!test_type)
+		err("failed to parse test type argument: '%s'", raw_type);
 
 	if (test_type == TEST_HUGETLB)
 		page_size = default_huge_page_size();
@@ -1653,7 +1709,7 @@ int main(int argc, char **argv)
 		err("failed to arm SIGALRM");
 	alarm(ALARM_INTERVAL_SECS);
 
-	set_test_type(argv[1]);
+	parse_test_type_arg(argv[1]);
 
 	nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
 	nr_pages_per_cpu = atol(argv[2]) * 1024*1024 / page_size /
-- 
2.37.1.595.g718a3a8f04-goog

