Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F5E74A74E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 00:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjGFWv4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 18:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbjGFWvZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 18:51:25 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3772127
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jul 2023 15:51:07 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c361777c7f7so3608028276.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jul 2023 15:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688683866; x=1691275866;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vNyM+7c0est1wcVkLGeYyWS2zFzaKr32nANrKlDiGpI=;
        b=EK01mLypW26xwbB17tl+WVi77pgJ0OApJdOy0ZdOVv84/lYvfVuW7WowZ4rEK8f7WX
         g4rTBFdn/gfopVFptl2AY7oR1MbOxcuKJ5NLlgJS4KZnwJQ/O9DYar58Cp6+LJtem2dz
         7aV6c0xPB8rtx/DVLBBYyqqPk4Y5aP7bx24BzHZVQh7fjXNIuWh3WsjiPncdyuOWOy0f
         szlc4nj/Zd3/Khbkib9ISdsge3HmKG+4el8u83yJEUvEUWR2sl14PZi/zm9NTrqicFDS
         XKFqXwSRFH+ICd8i9r7ldw2FSna2YUHpUhgptiJGArRniVNPuiWl7n0jMNBuoRiJ6+di
         6/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688683866; x=1691275866;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vNyM+7c0est1wcVkLGeYyWS2zFzaKr32nANrKlDiGpI=;
        b=cBDb0WWUvhS2PEWXT/PGACUTf5v0nX391HfyMadreLcbc7aT1+5MS4bims9YXzq2vL
         dTuGB8Mia5nfjvN4D6VOL02j4vTlHnUMeYkuzA4l3Gs6DIHmDBStWMo2dAE0Xlu0XqgV
         9JFk7NizZ3pEIMJmcgykwhyhKM+CB4Wd2TpGXRLSxDHD9yENiN9yDxVe9ul6Uc9RajiZ
         Ze+Meog1sNtubWHmVk7hohpDjAWMMRnbARtAwQl2btw4X/pGnmgAjEu5etvi2gNoE6od
         NRvhz4dar4AMimT5oFQBcPd9aWPkpUwRFwaKTyHuC507vDKzxDsUHxQLl3wRdAeexGJ7
         2YdA==
X-Gm-Message-State: ABy/qLZ4SdS3RVOP8NYCEOfa+lKtPtOjZ2hD9Xz7Ant40QHu3MdzxSTk
        QDjkk1iyyoeLnqvvlLxCONGG4MDzKrRqOaFLn2+w
X-Google-Smtp-Source: APBJJlHgoq6fX5m1+Roj1PD+nUlgNcdctSDPa98kXCzajWjYbfEt4nefdrt/24V9AOah7Hkvx+a3A+kIbPjrz61F6Iqg
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:bec3:2b1c:87a:fca2])
 (user=axelrasmussen job=sendgmr) by 2002:a25:ab90:0:b0:bc4:a660:528f with
 SMTP id v16-20020a25ab90000000b00bc4a660528fmr39975ybi.5.1688683866544; Thu,
 06 Jul 2023 15:51:06 -0700 (PDT)
Date:   Thu,  6 Jul 2023 15:50:36 -0700
In-Reply-To: <20230706225037.1164380-1-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20230706225037.1164380-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230706225037.1164380-9-axelrasmussen@google.com>
Subject: [PATCH v3 8/8] selftests/mm: add uffd unit test for UFFDIO_POISON
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Geffon <bgeffon@google.com>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        James Houghton <jthoughton@google.com>,
        "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Peter Xu <peterx@redhat.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "T.J. Alumbaugh" <talumbau@google.com>,
        Yu Zhao <yuzhao@google.com>,
        ZhangPeng <zhangpeng362@huawei.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
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

The test is pretty basic, and exercises UFFDIO_POISON straightforwardly.
We register a region with userfaultfd, in missing fault mode. For each
fault, we either UFFDIO_COPY a zeroed page (odd pages) or UFFDIO_POISON
(even pages). We do this mix to test "something like a real use case",
where guest memory would be some mix of poisoned and non-poisoned pages.

We read each page in the region, and assert that the odd pages are
zeroed as expected, and the even pages yield a SIGBUS as expected.

Why UFFDIO_COPY instead of UFFDIO_ZEROPAGE? Because hugetlb doesn't
support UFFDIO_ZEROPAGE, and we don't want to have special case code.

Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/mm/uffd-unit-tests.c | 117 +++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 04d91f144d1c..2709a34a39c5 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -951,6 +951,117 @@ static void uffd_zeropage_test(uffd_test_args_t *args)
 	uffd_test_pass();
 }
 
+static void uffd_register_poison(int uffd, void *addr, uint64_t len)
+{
+	uint64_t ioctls = 0;
+	uint64_t expected = (1 << _UFFDIO_COPY) | (1 << _UFFDIO_POISON);
+
+	if (uffd_register_with_ioctls(uffd, addr, len, true,
+				      false, false, &ioctls))
+		err("poison register fail");
+
+	if ((ioctls & expected) != expected)
+		err("registered area doesn't support COPY and POISON ioctls");
+}
+
+static void do_uffdio_poison(int uffd, unsigned long offset)
+{
+	struct uffdio_poison uffdio_poison = { 0 };
+	int ret;
+	__s64 res;
+
+	uffdio_poison.range.start = (unsigned long) area_dst + offset;
+	uffdio_poison.range.len = page_size;
+	uffdio_poison.mode = 0;
+	ret = ioctl(uffd, UFFDIO_POISON, &uffdio_poison);
+	res = uffdio_poison.updated;
+
+	if (ret)
+		err("UFFDIO_POISON error: %"PRId64, (int64_t)res);
+	else if (res != page_size)
+		err("UFFDIO_POISON unexpected size: %"PRId64, (int64_t)res);
+}
+
+static void uffd_poison_handle_fault(
+	struct uffd_msg *msg, struct uffd_args *args)
+{
+	unsigned long offset;
+
+	if (msg->event != UFFD_EVENT_PAGEFAULT)
+		err("unexpected msg event %u", msg->event);
+
+	if (msg->arg.pagefault.flags &
+	    (UFFD_PAGEFAULT_FLAG_WP | UFFD_PAGEFAULT_FLAG_MINOR))
+		err("unexpected fault type %llu", msg->arg.pagefault.flags);
+
+	offset = (char *)(unsigned long)msg->arg.pagefault.address - area_dst;
+	offset &= ~(page_size-1);
+
+	/* Odd pages -> copy zeroed page; even pages -> poison. */
+	if (offset & page_size)
+		copy_page(uffd, offset, false);
+	else
+		do_uffdio_poison(uffd, offset);
+}
+
+static void uffd_poison_test(uffd_test_args_t *targs)
+{
+	pthread_t uffd_mon;
+	char c;
+	struct uffd_args args = { 0 };
+	struct sigaction act = { 0 };
+	unsigned long nr_sigbus = 0;
+	unsigned long nr;
+
+	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
+
+	uffd_register_poison(uffd, area_dst, nr_pages * page_size);
+	memset(area_src, 0, nr_pages * page_size);
+
+	args.handle_fault = uffd_poison_handle_fault;
+	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
+		err("uffd_poll_thread create");
+
+	sigbuf = &jbuf;
+	act.sa_sigaction = sighndl;
+	act.sa_flags = SA_SIGINFO;
+	if (sigaction(SIGBUS, &act, 0))
+		err("sigaction");
+
+	for (nr = 0; nr < nr_pages; ++nr) {
+		unsigned long offset = nr * page_size;
+		const char *bytes = (const char *) area_dst + offset;
+		const char *i;
+
+		if (sigsetjmp(*sigbuf, 1)) {
+			/*
+			 * Access below triggered a SIGBUS, which was caught by
+			 * sighndl, which then jumped here. Count this SIGBUS,
+			 * and move on to next page.
+			 */
+			++nr_sigbus;
+			continue;
+		}
+
+		for (i = bytes; i < bytes + page_size; ++i) {
+			if (*i)
+				err("nonzero byte in area_dst (%p) at %p: %u",
+				    area_dst, i, *i);
+		}
+	}
+
+	if (write(pipefd[1], &c, sizeof(c)) != sizeof(c))
+		err("pipe write");
+	if (pthread_join(uffd_mon, NULL))
+		err("pthread_join()");
+
+	if (nr_sigbus != nr_pages / 2)
+		err("expected to receive %lu SIGBUS, actually received %lu",
+		    nr_pages / 2, nr_sigbus);
+
+	uffd_test_pass();
+}
+
 /*
  * Test the returned uffdio_register.ioctls with different register modes.
  * Note that _UFFDIO_ZEROPAGE is tested separately in the zeropage test.
@@ -1126,6 +1237,12 @@ uffd_test_case_t uffd_tests[] = {
 		UFFD_FEATURE_PAGEFAULT_FLAG_WP |
 		UFFD_FEATURE_WP_HUGETLBFS_SHMEM,
 	},
+	{
+		.name = "poison",
+		.uffd_fn = uffd_poison_test,
+		.mem_targets = MEM_ALL,
+		.uffd_feature_required = UFFD_FEATURE_POISON,
+	},
 };
 
 static void usage(const char *prog)
-- 
2.41.0.255.g8b1d071c50-goog

