Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206897A0922
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 17:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241002AbjINP0i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 11:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240964AbjINP0g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:26:36 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473561FD0
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Sep 2023 08:26:32 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58cbf62bae8so14676267b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Sep 2023 08:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694705191; x=1695309991; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mu1OGPWARKH9oRMfZEcpV5n3maR0zmAnXssCvh8qI9k=;
        b=SQb9k5tA0qUyySqshNePRlA2p9ujS673L82mvo09YoCVxby0xVIUm5s7+SMYhOtZ9A
         pK5ysDa0CNM2+droM8gynPxphCozcpPc5IdaWiv7cA+OzlpTWtCGtLnzGgvU731lViZD
         BngPn/oDOhVXmnlsAZig2adWy1yhmgZFDaxGVk6CAAKqNKWM3cdZ2uHvZTTFXWOzegMJ
         vMvxyy8fePM9Dh17fjO6ElbOj133csNcqM7y/6OHzGEt4OxXdeGL7sQg4gMzXsMkOMS6
         FICqishDIl3hRUTyb1Z3+pmYFuRzrv1epRYSeQfJfepZ/QbLljY8Vcoq2J6961CHhrK2
         E3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694705191; x=1695309991;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mu1OGPWARKH9oRMfZEcpV5n3maR0zmAnXssCvh8qI9k=;
        b=mkZ6PJEAqAPWm/4SE5Pc6aLPK9UyheTKliE53j2xDRiyX8PHDGbXFQ7SxPVZpTxQXd
         Bn9ng3hzWSszDtpdhLo2QkMtcF7a+GBfguqlnDaWoaNhPRn2t/yF2YfdgeB80swmd+3W
         CgdDuWit8X1B7WwgNCgOk+zQg+Gf4LCn20vJVdUuaULKHGwxAFP4oVOrP8HW+kwlX5dc
         k3MARWpSSLb94uFYm87SEZjBScX3ARCYDrApRRp1/GWpE8xG8LOcPkPZ2KUkU6UJBNxh
         UOC/Gmf11p3ebgifdC5l53LE7Ik5vIk6nKwORKTPsfmAsAIvi3LkTEk2dsjpLXlH8ZnL
         1dsA==
X-Gm-Message-State: AOJu0YxcaaG6xqG8dAjlcKHZhlTRQekk1YxgnVxc6SS70KCLy3f5NE5L
        gqmNKeIwpGBx/vDSAFZW+mklfXeLOhE=
X-Google-Smtp-Source: AGHT+IFBVegGxf80f6tK8JTRTL2eDdZPWBJrMSOMFpp88sQURTGOGeLIWNKbAvxE88xxjjHdcadvLmZLUmU=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:405c:ba64:810f:5fee])
 (user=surenb job=sendgmr) by 2002:a81:c94b:0:b0:59b:ba8a:97d0 with SMTP id
 c11-20020a81c94b000000b0059bba8a97d0mr154662ywl.3.1694705191508; Thu, 14 Sep
 2023 08:26:31 -0700 (PDT)
Date:   Thu, 14 Sep 2023 08:26:13 -0700
In-Reply-To: <20230914152620.2743033-1-surenb@google.com>
Mime-Version: 1.0
References: <20230914152620.2743033-1-surenb@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230914152620.2743033-4-surenb@google.com>
Subject: [PATCH 3/3] selftests/mm: add UFFDIO_REMAP ioctl test
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
 tools/testing/selftests/mm/uffd-common.c     | 34 ++++++++++-
 tools/testing/selftests/mm/uffd-common.h     |  1 +
 tools/testing/selftests/mm/uffd-unit-tests.c | 62 ++++++++++++++++++++
 3 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index 02b89860e193..fb449abc46e2 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -484,8 +484,14 @@ void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_args *args)
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
 
@@ -620,6 +626,30 @@ int copy_page(int ufd, unsigned long offset, bool wp)
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
2.42.0.283.g2d96d420d3-goog

