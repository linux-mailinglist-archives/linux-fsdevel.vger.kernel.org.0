Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4347ABD14
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Sep 2023 03:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjIWBcP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 21:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjIWBcK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 21:32:10 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DA01AC
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Sep 2023 18:32:00 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59c2ca3bcf9so47813287b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Sep 2023 18:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695432720; x=1696037520; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6sBdVMfMRjf51/A4FAmBdDBudgEJD7XIV0S+Rn1ebf8=;
        b=DHDysvaQOkX+1QeT/kRjvxWEKSghwM022OG9aVVfIA1HUHjcImsI4IF+/RT6YSchjW
         fQDyr2N2FylsXYPtG1o+DoTbmH36dC2J/hpq09BjZJ/vyAH7BfCAkWaBq66Bi+zo/x/W
         xkXiqymmKqvkBlPMxJ6FLjQm/JAfDhpUgJUrxucLVjn5skb/7lCJ6qydVcoEMakQTvay
         rYb+IURzuvPwyTg7c7JJoI+x1HmEbcdIvBldc1G5e773ILAkauXmf0RjlXBmtoHPVEOo
         wQlBuequYCqx/SI8LLggkRYDcUIGFt/kDu8uZmcO18tRvQ1eU1uUgXjmLcsz0ZSZ6H8Q
         VT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695432720; x=1696037520;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6sBdVMfMRjf51/A4FAmBdDBudgEJD7XIV0S+Rn1ebf8=;
        b=qz7zde3h5z4boLbl8eGXKOkHdohj5344zPl50rVt8KnTB/EOupWU8RupZYtrWBbddC
         uRgFAj8t0HHG3bmTjp64en0Z+i0B5TYQAPAEHdtRzqHH9anms2CSnN4IujzfE+EF0sTe
         IremVwZi/FjBiwcYz3GlPjPqcETrgJxT1Cwd+ouql540yzQryVwbOXP7Av8eH5dh4gna
         JPC8xUoK5BCnrgjC8W+5JkBBBdr6/My3jT4UKKdxPwtHYkaOT9PK3HC85Y6WBxNdsyQQ
         1d/sjojoSfjMnfxaIncrUlwcZ1KeruKTYfLLbOYonm0lb9chzMG36hXKSWfmM8fhBF6E
         wrvQ==
X-Gm-Message-State: AOJu0YzvSE4jg83iTyHx3/ymEuhz0Y46Yr1K67Qrc0kQOxv3GaCNm+lz
        aFhgfdM0BYCv34+uhJ8anzW2a+giva4=
X-Google-Smtp-Source: AGHT+IE2yWzcwua2aqDzlLl0Y+Ymi3r6rJDilflyRWbYZnXXI88FhB4QNhRbeG/BF6XKbV1cknxCSUOXvog=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:3398:6644:ed7f:bec9])
 (user=surenb job=sendgmr) by 2002:a25:d09:0:b0:d7b:9185:e23d with SMTP id
 9-20020a250d09000000b00d7b9185e23dmr9469ybn.6.1695432719939; Fri, 22 Sep 2023
 18:31:59 -0700 (PDT)
Date:   Fri, 22 Sep 2023 18:31:46 -0700
In-Reply-To: <20230923013148.1390521-1-surenb@google.com>
Mime-Version: 1.0
References: <20230923013148.1390521-1-surenb@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230923013148.1390521-4-surenb@google.com>
Subject: [PATCH v2 3/3] selftests/mm: add UFFDIO_REMAP ioctl test
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
        aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com,
        david@redhat.com, hughd@google.com, mhocko@suse.com,
        axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
        Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com,
        bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        jdduke@google.com, surenb@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
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

Add a test for new UFFDIO_REMAP ioctl which uses uffd to remaps source
into destination buffer while checking the contents of both after
remapping. After the operation the content of the destination buffer
should match the original source buffer's content while the source
buffer should be zeroed.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 tools/testing/selftests/mm/uffd-common.c     | 41 ++++++++++++-
 tools/testing/selftests/mm/uffd-common.h     |  1 +
 tools/testing/selftests/mm/uffd-unit-tests.c | 62 ++++++++++++++++++++
 3 files changed, 102 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index 02b89860e193..2a3ffd0ce96e 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -52,6 +52,13 @@ static int anon_allocate_area(void **alloc_area, bool is_src)
 		*alloc_area = NULL;
 		return -errno;
 	}
+
+	/* Prevent source pages from collapsing into THPs */
+	if (madvise(*alloc_area, nr_pages * page_size, MADV_NOHUGEPAGE)) {
+		*alloc_area = NULL;
+		return -errno;
+	}
+
 	return 0;
 }
 
@@ -484,8 +491,14 @@ void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_args *args)
 		offset = (char *)(unsigned long)msg->arg.pagefault.address - area_dst;
 		offset &= ~(page_size-1);
 
-		if (copy_page(uffd, offset, args->apply_wp))
-			args->missing_faults++;
+		/* UFFD_REMAP is supported for anon non-shared mappings. */
+		if (uffd_test_ops == &anon_uffd_test_ops && !map_shared) {
+			if (remap_page(uffd, offset))
+				args->missing_faults++;
+		} else {
+			if (copy_page(uffd, offset, args->apply_wp))
+				args->missing_faults++;
+		}
 	}
 }
 
@@ -620,6 +633,30 @@ int copy_page(int ufd, unsigned long offset, bool wp)
 	return __copy_page(ufd, offset, false, wp);
 }
 
+int remap_page(int ufd, unsigned long offset)
+{
+	struct uffdio_remap uffdio_remap;
+
+	if (offset >= nr_pages * page_size)
+		err("unexpected offset %lu\n", offset);
+	uffdio_remap.dst = (unsigned long) area_dst + offset;
+	uffdio_remap.src = (unsigned long) area_src + offset;
+	uffdio_remap.len = page_size;
+	uffdio_remap.mode = UFFDIO_REMAP_MODE_ALLOW_SRC_HOLES;
+	uffdio_remap.remap = 0;
+	if (ioctl(ufd, UFFDIO_REMAP, &uffdio_remap)) {
+		/* real retval in uffdio_remap.remap */
+		if (uffdio_remap.remap != -EEXIST)
+			err("UFFDIO_REMAP error: %"PRId64,
+			    (int64_t)uffdio_remap.remap);
+		wake_range(ufd, uffdio_remap.dst, page_size);
+	} else if (uffdio_remap.remap != page_size) {
+		err("UFFDIO_REMAP error: %"PRId64, (int64_t)uffdio_remap.remap);
+	} else
+		return 1;
+	return 0;
+}
+
 int uffd_open_dev(unsigned int flags)
 {
 	int fd, uffd;
diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
index 7c4fa964c3b0..2bbb15d1920c 100644
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -111,6 +111,7 @@ void wp_range(int ufd, __u64 start, __u64 len, bool wp);
 void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_args *args);
 int __copy_page(int ufd, unsigned long offset, bool retry, bool wp);
 int copy_page(int ufd, unsigned long offset, bool wp);
+int remap_page(int ufd, unsigned long offset);
 void *uffd_poll_thread(void *arg);
 
 int uffd_open_dev(unsigned int flags);
diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 2709a34a39c5..a33819639187 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -824,6 +824,10 @@ static void uffd_events_test_common(bool wp)
 	char c;
 	struct uffd_args args = { 0 };
 
+	/* Prevent source pages from being mapped more than once */
+	if (madvise(area_src, nr_pages * page_size, MADV_DONTFORK))
+		err("madvise(MADV_DONTFORK) failed");
+
 	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
 	if (uffd_register(uffd, area_dst, nr_pages * page_size,
 			  true, wp, false))
@@ -1062,6 +1066,58 @@ static void uffd_poison_test(uffd_test_args_t *targs)
 	uffd_test_pass();
 }
 
+static void uffd_remap_test(uffd_test_args_t *targs)
+{
+	unsigned long nr;
+	pthread_t uffd_mon;
+	char c;
+	unsigned long long count;
+	struct uffd_args args = { 0 };
+
+	if (uffd_register(uffd, area_dst, nr_pages * page_size,
+			  true, false, false))
+		err("register failure");
+
+	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
+		err("uffd_poll_thread create");
+
+	/*
+	 * Read each of the pages back using the UFFD-registered mapping. We
+	 * expect that the first time we touch a page, it will result in a missing
+	 * fault. uffd_poll_thread will resolve the fault by remapping source
+	 * page to destination.
+	 */
+	for (nr = 0; nr < nr_pages; nr++) {
+		/* Check area_src content */
+		count = *area_count(area_src, nr);
+		if (count != count_verify[nr])
+			err("nr %lu source memory invalid %llu %llu\n",
+			    nr, count, count_verify[nr]);
+
+		/* Faulting into area_dst should remap the page */
+		count = *area_count(area_dst, nr);
+		if (count != count_verify[nr])
+			err("nr %lu memory corruption %llu %llu\n",
+			    nr, count, count_verify[nr]);
+
+		/* Re-check area_src content which should be empty */
+		count = *area_count(area_src, nr);
+		if (count != 0)
+			err("nr %lu remap failed %llu %llu\n",
+			    nr, count, count_verify[nr]);
+	}
+
+	if (write(pipefd[1], &c, sizeof(c)) != sizeof(c))
+		err("pipe write");
+	if (pthread_join(uffd_mon, NULL))
+		err("join() failed");
+
+	if (args.missing_faults != nr_pages || args.minor_faults != 0)
+		uffd_test_fail("stats check error");
+	else
+		uffd_test_pass();
+}
+
 /*
  * Test the returned uffdio_register.ioctls with different register modes.
  * Note that _UFFDIO_ZEROPAGE is tested separately in the zeropage test.
@@ -1139,6 +1195,12 @@ uffd_test_case_t uffd_tests[] = {
 		.mem_targets = MEM_ALL,
 		.uffd_feature_required = 0,
 	},
+	{
+		.name = "remap",
+		.uffd_fn = uffd_remap_test,
+		.mem_targets = MEM_ANON,
+		.uffd_feature_required = 0,
+	},
 	{
 		.name = "wp-fork",
 		.uffd_fn = uffd_wp_fork_test,
-- 
2.42.0.515.g380fc7ccd1-goog

