Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827F87BD3AA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 08:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345309AbjJIGmy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 02:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345318AbjJIGmv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 02:42:51 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30461E4
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Oct 2023 23:42:42 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d918aef0d0dso5869266276.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Oct 2023 23:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696833762; x=1697438562; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=50i/QdEI5D071LaRqB1M3KzWwtbx6nE7wmO2EXtVHvA=;
        b=lpP38/5JvlOaMlcq0JFOwzSjg6eLfiYW4s5QkK51KNbANf+OXr6w7n33JYk1zTj0rs
         pVM2v46jUSwZPq0Q2bVwvqSWkCdmx2vXjzTswb0gxENj9JDem5tgj20Y+Up0ceiHTyO2
         OTVxvl7zKgj9Ll56qF3PgtNjcwYY04VD62qypBcELy+5khsnbbkhxrA8oKkUEcgJq6B0
         irT+1WcXalDxbPyP+Z1ZVAcEqV1Pe+qum34WgnA1iNREWLR00x8bgoBO8BQ8FhxgV244
         LoBl7HvZ+HN+jjnFGJlZqPOCFm/CIh9TiKZlomEL361vcNsiQXL3/7rNxKRD+sej3qAt
         NKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696833762; x=1697438562;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=50i/QdEI5D071LaRqB1M3KzWwtbx6nE7wmO2EXtVHvA=;
        b=C+cXebiHAnC7m1GeNzQurR+AnEYp2hxFW12wRp0bMgmYVHWbaHiFeznv/T0FuN6Onh
         YVC3qM6iHxIszJsdYcyydA52iSI8bcSs0X2m7FiK40qeVtMr//hkquAhD+JrvQE0i/UF
         v2pc0uJlTIKYKrLpQSMy/X5MIUg9wu/A9yYeIKjz6gEjQcFmRAjCmFSjNrWxTiuWHaIX
         M4j7LqmG1dGWvnX77u9578ZN6RPCq0vrSIdYtqFPs6jAKvrZ6Bp2xQ2g2O93gEDqRq4+
         oLuk/NRXGCGTtOFJ5+E9sTYugwDCSsNcYJnaL98dbijsRz3bxuE7oWb4bV+3CqnjMmja
         /+fA==
X-Gm-Message-State: AOJu0Yxu6WC3nlNoyegfavQAQbEJKyoRiQ3XUlxdrQdU+HVsEs5b2VBS
        vnhmKcwicDd/soP7euUMQZrwAXukNds=
X-Google-Smtp-Source: AGHT+IE3ENVpgSSY9jHiu1FOcPq/GRVi/eysZgrxroKYd6Fm4a1cG8w7FQlArfhqzdMAUqw7rMWUDxE9tZI=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:3e83:601e:dc42:a455])
 (user=surenb job=sendgmr) by 2002:a25:68ce:0:b0:d86:56bc:e289 with SMTP id
 d197-20020a2568ce000000b00d8656bce289mr225181ybc.4.1696833762182; Sun, 08 Oct
 2023 23:42:42 -0700 (PDT)
Date:   Sun,  8 Oct 2023 23:42:28 -0700
In-Reply-To: <20231009064230.2952396-1-surenb@google.com>
Mime-Version: 1.0
References: <20231009064230.2952396-1-surenb@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <20231009064230.2952396-4-surenb@google.com>
Subject: [PATCH v3 3/3] selftests/mm: add UFFDIO_MOVE ioctl test
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a test for new UFFDIO_MOVE ioctl which uses uffd to move source
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
index 02b89860e193..ecc1244f1c2b 100644
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
+		/* UFFD_MOVE is supported for anon non-shared mappings. */
+		if (uffd_test_ops == &anon_uffd_test_ops && !map_shared) {
+			if (move_page(uffd, offset))
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
 
+int move_page(int ufd, unsigned long offset)
+{
+	struct uffdio_move uffdio_move;
+
+	if (offset >= nr_pages * page_size)
+		err("unexpected offset %lu\n", offset);
+	uffdio_move.dst = (unsigned long) area_dst + offset;
+	uffdio_move.src = (unsigned long) area_src + offset;
+	uffdio_move.len = page_size;
+	uffdio_move.mode = UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES;
+	uffdio_move.move = 0;
+	if (ioctl(ufd, UFFDIO_MOVE, &uffdio_move)) {
+		/* real retval in uffdio_move.move */
+		if (uffdio_move.move != -EEXIST)
+			err("UFFDIO_MOVE error: %"PRId64,
+			    (int64_t)uffdio_move.move);
+		wake_range(ufd, uffdio_move.dst, page_size);
+	} else if (uffdio_move.move != page_size) {
+		err("UFFDIO_MOVE error: %"PRId64, (int64_t)uffdio_move.move);
+	} else
+		return 1;
+	return 0;
+}
+
 int uffd_open_dev(unsigned int flags)
 {
 	int fd, uffd;
diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
index 7c4fa964c3b0..f4d79e169a3d 100644
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -111,6 +111,7 @@ void wp_range(int ufd, __u64 start, __u64 len, bool wp);
 void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_args *args);
 int __copy_page(int ufd, unsigned long offset, bool retry, bool wp);
 int copy_page(int ufd, unsigned long offset, bool wp);
+int move_page(int ufd, unsigned long offset);
 void *uffd_poll_thread(void *arg);
 
 int uffd_open_dev(unsigned int flags);
diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 2709a34a39c5..f0ded3b34367 100644
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
 
+static void uffd_move_test(uffd_test_args_t *targs)
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
+			err("nr %lu move failed %llu %llu\n",
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
+		.name = "move",
+		.uffd_fn = uffd_move_test,
+		.mem_targets = MEM_ANON,
+		.uffd_feature_required = UFFD_FEATURE_MOVE,
+	},
 	{
 		.name = "wp-fork",
 		.uffd_fn = uffd_wp_fork_test,
-- 
2.42.0.609.gbb76f46606-goog

