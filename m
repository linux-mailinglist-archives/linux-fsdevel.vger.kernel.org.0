Return-Path: <linux-fsdevel+bounces-11459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB46853DDC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 22:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5FEF1F2CEE3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 21:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53AC64AA5;
	Tue, 13 Feb 2024 21:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="whIGQEXR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qMnl2LTg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFB4627F3;
	Tue, 13 Feb 2024 21:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861355; cv=none; b=D2ZeerNERPHpHiRfLuYjfETWc2y2XwddoavijHaTpa/eWspiwaISeQMPys0co8p6gPp2YaMii1ljQ9i63KpQs701+YLcNsVHtIfdBZfl4lw0hclSQSbbevHsWNkubx00XhQjh9EYeNkAIJ9BDtFop3PyIky8UJGvQSXsLyrBdE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861355; c=relaxed/simple;
	bh=4k1J5WpOg9drdG/n/818LiZXytE3GDBXdp/FO/7NnF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mdAiINDDVfvs6crXwQTk/ItsSZDUk3ppuqCu1qyIXbiUx/tLXK2uepF0vCFp7czGNg/DgSF+Yau6C/6GKL/TmhbxgJZORRuNb5vFrjc+vZ0FlYb/HAu9Ha68UZg1XQ/vqeNRbflX9Q85YtnEh2HGj2THVBOwg9MOHzdNLLPVaNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=whIGQEXR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qMnl2LTg; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id EBC085C0116;
	Tue, 13 Feb 2024 16:55:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 13 Feb 2024 16:55:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1707861352; x=1707947752; bh=9fpAY5r5SIfyHPBsxmEOn10EsQJ32jaS6lT
	W3aElgBo=; b=whIGQEXRoqx/qECUNPaK17aH59YKDK1HWsPrYdDSEtILmbdSFrw
	g3nI7hqiZ7llmvOeqFI5G8ydQXjyYEjGnGWbO/qTtAtrnYrUTyegpXqJVaSzBY6Q
	wrvN16JHKa26mAoRACslKKQw1/ZS4AkSZ15gN1f1SxK4vINwoyzOjILTscVUItIc
	BHOrrb9IE0umaiTROEs27PLpXiYKfg1rHjmiLHJNMR/2UMGTPFAmsb+iBmCVVyPx
	ulMh0mrhTkg7XFydf8oswl0j6NZBEo7VBRy636J5MnkcxOwDlLkAfuixBfKR3hpS
	INM4L8IWn669amjmF0Pz1zHioU79uKgL+RA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1707861352; x=1707947752; bh=9fpAY5r5SIfyHPBsxmEOn10EsQJ32jaS6lT
	W3aElgBo=; b=qMnl2LTgLhPI29ilM7TDeZqWes7B4ihFflMZTnlA6Zs3zsC+PTK
	8vrWl3oqs9S8yyPK/+Vbd0MtsoyLsX0kfDHPTCFpHBQdMwfJC7c1E00z7Jvxid1U
	xSlAI5VNRynW6EVN5lhKbRyGRW5NDkkbsojPNzGS6GzwL6kdXX+I4vz3AW7J8mjU
	UKJ0Bv1wWqaSUCUF3vvpcccsWQRZ2OYwiRi9uNEvvLkDDu4/DeOoXnd1g4os8C/f
	WMhR6HjM1ut/4rDONxBak+A+KYl0fU9wdUQ9u2aGuCpwH4g5d8xrvW4aI2T/hObu
	YVeoysZuqmwnTJcKY6wvzBQVWskF/+uH4MQ==
X-ME-Sender: <xms:aOXLZXoENy0rbgLIAbrGuABq7kSD1FR2F51q-esMsVFyRhpXtTnyRQ>
    <xme:aOXLZRqg4OI7wxwFYdi7h_KPj7XehGPkJPgXh1Hy1RC3DcyFtIq8galCQiXQy1EaM
    CjhvFI8vSdkPRwynw>
X-ME-Received: <xmr:aOXLZUPf04Ss3aAQR8H8b9Ykte91qUX70-VscIUWdhIdz5WyUR1Pu9l_rwk6Gz6Vzp-b5Nlx6RSg1_l5riAMIGJ5e6813PBDep81-GvKoO4KTXIg0GKm2oa0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehgdduheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrgggtgfesthekredtredtjeenucfhrhhomhepkghi
    ucgjrghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepje
    ekteekffelleekudfftdefvddtjeejuedtuedtteegjefgvedtfedujeekieevnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnse
    hsvghnthdrtghomh
X-ME-Proxy: <xmx:aOXLZa6tcxkAydMhRMB3UMGa3s23JQlHosKJsX_08KZzrDzQE-pdUg>
    <xmx:aOXLZW4L9wCk7icuEOibDbduPYPQAPpaSoYDf21Nf-wOx_5tNl7OFA>
    <xmx:aOXLZShOw8uzUuXlSxrtUxkD5kII96X4z-JZGFRqlBBzdwP3re1ACw>
    <xmx:aOXLZbNeoq9lpXzTPCTQ3ucXSMylgVFVO-pabIpRGbIvDCC9ZcSi1g>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Feb 2024 16:55:51 -0500 (EST)
From: Zi Yan <zi.yan@sent.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	linux-mm@kvack.org
Cc: Zi Yan <ziy@nvidia.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Yang Shi <shy828301@gmail.com>,
	Yu Zhao <yuzhao@google.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	"Zach O'Keefe" <zokeefe@google.com>,
	Hugh Dickins <hughd@google.com>,
	Mcgrof Chamberlain <mcgrof@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 7/7] mm: huge_memory: enable debugfs to split huge pages to any order.
Date: Tue, 13 Feb 2024 16:55:20 -0500
Message-ID: <20240213215520.1048625-8-zi.yan@sent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213215520.1048625-1-zi.yan@sent.com>
References: <20240213215520.1048625-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Zi Yan <ziy@nvidia.com>

It is used to test split_huge_page_to_list_to_order for pagecache THPs.
Also add test cases for split_huge_page_to_list_to_order via both
debugfs, truncating a file, and punching holes in a file.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c                              |  34 ++-
 .../selftests/mm/split_huge_page_test.c       | 223 +++++++++++++++++-
 2 files changed, 239 insertions(+), 18 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d0e555a8ea98..0564b007cbd1 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3399,7 +3399,7 @@ static inline bool vma_not_suitable_for_thp_split(struct vm_area_struct *vma)
 }
 
 static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
-				unsigned long vaddr_end)
+				unsigned long vaddr_end, unsigned int new_order)
 {
 	int ret = 0;
 	struct task_struct *task;
@@ -3463,13 +3463,19 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 			goto next;
 
 		total++;
-		if (!can_split_folio(folio, NULL))
+		/*
+		 * For folios with private, split_huge_page_to_list_to_order()
+		 * will try to drop it before split and then check if the folio
+		 * can be split or not. So skip the check here.
+		 */
+		if (!folio_test_private(folio) &&
+		    !can_split_folio(folio, NULL))
 			goto next;
 
 		if (!folio_trylock(folio))
 			goto next;
 
-		if (!split_folio(folio))
+		if (!split_folio_to_order(folio, new_order))
 			split++;
 
 		folio_unlock(folio);
@@ -3487,7 +3493,7 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 }
 
 static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
-				pgoff_t off_end)
+				pgoff_t off_end, unsigned int new_order)
 {
 	struct filename *file;
 	struct file *candidate;
@@ -3526,7 +3532,7 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
 		if (!folio_trylock(folio))
 			goto next;
 
-		if (!split_folio(folio))
+		if (!split_folio_to_order(folio, new_order))
 			split++;
 
 		folio_unlock(folio);
@@ -3551,10 +3557,14 @@ static ssize_t split_huge_pages_write(struct file *file, const char __user *buf,
 {
 	static DEFINE_MUTEX(split_debug_mutex);
 	ssize_t ret;
-	/* hold pid, start_vaddr, end_vaddr or file_path, off_start, off_end */
+	/*
+	 * hold pid, start_vaddr, end_vaddr, new_order or
+	 * file_path, off_start, off_end, new_order
+	 */
 	char input_buf[MAX_INPUT_BUF_SZ];
 	int pid;
 	unsigned long vaddr_start, vaddr_end;
+	unsigned int new_order = 0;
 
 	ret = mutex_lock_interruptible(&split_debug_mutex);
 	if (ret)
@@ -3583,29 +3593,29 @@ static ssize_t split_huge_pages_write(struct file *file, const char __user *buf,
 			goto out;
 		}
 
-		ret = sscanf(buf, "0x%lx,0x%lx", &off_start, &off_end);
-		if (ret != 2) {
+		ret = sscanf(buf, "0x%lx,0x%lx,%d", &off_start, &off_end, &new_order);
+		if (ret != 2 && ret != 3) {
 			ret = -EINVAL;
 			goto out;
 		}
-		ret = split_huge_pages_in_file(file_path, off_start, off_end);
+		ret = split_huge_pages_in_file(file_path, off_start, off_end, new_order);
 		if (!ret)
 			ret = input_len;
 
 		goto out;
 	}
 
-	ret = sscanf(input_buf, "%d,0x%lx,0x%lx", &pid, &vaddr_start, &vaddr_end);
+	ret = sscanf(input_buf, "%d,0x%lx,0x%lx,%d", &pid, &vaddr_start, &vaddr_end, &new_order);
 	if (ret == 1 && pid == 1) {
 		split_huge_pages_all();
 		ret = strlen(input_buf);
 		goto out;
-	} else if (ret != 3) {
+	} else if (ret != 3 && ret != 4) {
 		ret = -EINVAL;
 		goto out;
 	}
 
-	ret = split_huge_pages_pid(pid, vaddr_start, vaddr_end);
+	ret = split_huge_pages_pid(pid, vaddr_start, vaddr_end, new_order);
 	if (!ret)
 		ret = strlen(input_buf);
 out:
diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index 7b698a848bab..ffed5ae24566 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -16,6 +16,7 @@
 #include <sys/mount.h>
 #include <malloc.h>
 #include <stdbool.h>
+#include <time.h>
 #include "vm_util.h"
 #include "../kselftest.h"
 
@@ -24,10 +25,12 @@ unsigned int pageshift;
 uint64_t pmd_pagesize;
 
 #define SPLIT_DEBUGFS "/sys/kernel/debug/split_huge_pages"
+#define SMAP_PATH "/proc/self/smaps"
+#define THP_FS_PATH "/mnt/thp_fs"
 #define INPUT_MAX 80
 
-#define PID_FMT "%d,0x%lx,0x%lx"
-#define PATH_FMT "%s,0x%lx,0x%lx"
+#define PID_FMT "%d,0x%lx,0x%lx,%d"
+#define PATH_FMT "%s,0x%lx,0x%lx,%d"
 
 #define PFN_MASK     ((1UL<<55)-1)
 #define KPF_THP      (1UL<<22)
@@ -102,7 +105,7 @@ void split_pmd_thp(void)
 
 	/* split all THPs */
 	write_debugfs(PID_FMT, getpid(), (uint64_t)one_page,
-		(uint64_t)one_page + len);
+		(uint64_t)one_page + len, 0);
 
 	for (i = 0; i < len; i++)
 		if (one_page[i] != (char)i)
@@ -177,7 +180,7 @@ void split_pte_mapped_thp(void)
 
 	/* split all remapped THPs */
 	write_debugfs(PID_FMT, getpid(), (uint64_t)pte_mapped,
-		      (uint64_t)pte_mapped + pagesize * 4);
+		      (uint64_t)pte_mapped + pagesize * 4, 0);
 
 	/* smap does not show THPs after mremap, use kpageflags instead */
 	thp_size = 0;
@@ -237,7 +240,7 @@ void split_file_backed_thp(void)
 	}
 
 	/* split the file-backed THP */
-	write_debugfs(PATH_FMT, testfile, pgoff_start, pgoff_end);
+	write_debugfs(PATH_FMT, testfile, pgoff_start, pgoff_end, 0);
 
 	status = unlink(testfile);
 	if (status) {
@@ -265,8 +268,188 @@ void split_file_backed_thp(void)
 	ksft_exit_fail_msg("Error occurred\n");
 }
 
+void create_pagecache_thp_and_fd(const char *testfile, size_t fd_size, int *fd, char **addr)
+{
+	size_t i;
+	int dummy;
+
+	srand(time(NULL));
+
+	*fd = open(testfile, O_CREAT | O_RDWR, 0664);
+	if (*fd == -1)
+		ksft_exit_fail_msg("Failed to create a file at "THP_FS_PATH);
+
+	for (i = 0; i < fd_size; i++) {
+		unsigned char byte = (unsigned char)i;
+
+		write(*fd, &byte, sizeof(byte));
+	}
+	close(*fd);
+	sync();
+	*fd = open("/proc/sys/vm/drop_caches", O_WRONLY);
+	if (*fd == -1) {
+		ksft_perror("open drop_caches");
+		goto err_out_unlink;
+	}
+	if (write(*fd, "3", 1) != 1) {
+		ksft_perror("write to drop_caches");
+		goto err_out_unlink;
+	}
+	close(*fd);
+
+	*fd = open(testfile, O_RDWR);
+	if (*fd == -1) {
+		ksft_perror("Failed to open a file at "THP_FS_PATH);
+		goto err_out_unlink;
+	}
+
+	*addr = mmap(NULL, fd_size, PROT_READ|PROT_WRITE, MAP_SHARED, *fd, 0);
+	if (*addr == (char *)-1) {
+		ksft_perror("cannot mmap");
+		goto err_out_close;
+	}
+	madvise(*addr, fd_size, MADV_HUGEPAGE);
+
+	for (size_t i = 0; i < fd_size; i++)
+		dummy += *(*addr + i);
+
+	if (!check_huge_file(*addr, fd_size / pmd_pagesize, pmd_pagesize)) {
+		ksft_print_msg("No large pagecache folio generated, please mount a filesystem supporting large folio at "THP_FS_PATH"\n");
+		goto err_out_close;
+	}
+	return;
+err_out_close:
+	close(*fd);
+err_out_unlink:
+	unlink(testfile);
+	ksft_exit_fail_msg("Failed to create large pagecache folios\n");
+}
+
+void split_thp_in_pagecache_to_order(size_t fd_size, int order)
+{
+	int fd;
+	char *addr;
+	size_t i;
+	const char testfile[] = THP_FS_PATH "/test";
+	int err = 0;
+
+	create_pagecache_thp_and_fd(testfile, fd_size, &fd, &addr);
+
+	write_debugfs(PID_FMT, getpid(), (uint64_t)addr, (uint64_t)addr + fd_size, order);
+
+	for (i = 0; i < fd_size; i++)
+		if (*(addr + i) != (char)i) {
+			ksft_print_msg("%lu byte corrupted in the file\n", i);
+			err = EXIT_FAILURE;
+			goto out;
+		}
+
+	if (!check_huge_file(addr, 0, pmd_pagesize)) {
+		ksft_print_msg("Still FilePmdMapped not split\n");
+		err = EXIT_FAILURE;
+		goto out;
+	}
+
+out:
+	close(fd);
+	unlink(testfile);
+	if (err)
+		ksft_exit_fail_msg("Split PMD-mapped pagecache folio to order %d failed\n", order);
+	ksft_test_result_pass("Split PMD-mapped pagecache folio to order %d passed\n", order);
+}
+
+void truncate_thp_in_pagecache_to_order(size_t fd_size, int order)
+{
+	int fd;
+	char *addr;
+	size_t i;
+	const char testfile[] = THP_FS_PATH "/test";
+	int err = 0;
+
+	create_pagecache_thp_and_fd(testfile, fd_size, &fd, &addr);
+
+	ftruncate(fd, pagesize << order);
+
+	for (i = 0; i < (pagesize << order); i++)
+		if (*(addr + i) != (char)i) {
+			ksft_print_msg("%lu byte corrupted in the file\n", i);
+			err = EXIT_FAILURE;
+			goto out;
+		}
+
+	if (!check_huge_file(addr, 0, pmd_pagesize)) {
+		ksft_print_msg("Still FilePmdMapped not split after truncate\n");
+		err = EXIT_FAILURE;
+		goto out;
+	}
+
+out:
+	close(fd);
+	unlink(testfile);
+	if (err)
+		ksft_exit_fail_msg("Truncate PMD-mapped pagecache folio to order %d failed\n", order);
+	ksft_test_result_pass("Truncate PMD-mapped pagecache folio to order %d passed\n", order);
+}
+
+void punch_hole_in_pagecache_thp(size_t fd_size, off_t offset[], off_t len[],
+			int n, int num_left_thps)
+{
+	int fd, j;
+	char *addr;
+	size_t i;
+	const char testfile[] = THP_FS_PATH "/test";
+	int err = 0;
+
+	create_pagecache_thp_and_fd(testfile, fd_size, &fd, &addr);
+
+	for (j = 0; j < n; j++) {
+		ksft_print_msg("punch a hole to %ld kB PMD-mapped pagecache page at addr: %lx, offset %ld, and len %ld ...\n",
+			fd_size >> 10, (unsigned long)addr, offset[j], len[j]);
+		fallocate(fd, FALLOC_FL_PUNCH_HOLE|FALLOC_FL_KEEP_SIZE, offset[j], len[j]);
+	}
+
+	for (i = 0; i < fd_size; i++) {
+		int in_hole = 0;
+
+		for (j = 0; j < n; j++)
+			if (i >= offset[j] && i < (offset[j] + len[j])) {
+				in_hole = 1;
+				break;
+			}
+
+		if (in_hole) {
+			if (*(addr + i)) {
+				ksft_print_msg("%lu byte non-zero after punch\n", i);
+				err = EXIT_FAILURE;
+				goto out;
+			}
+			continue;
+		}
+		if (*(addr + i) != (char)i) {
+			ksft_print_msg("%lu byte corrupted in the file\n", i);
+			err = EXIT_FAILURE;
+			goto out;
+		}
+	}
+
+	if (!check_huge_file(addr, num_left_thps, pmd_pagesize)) {
+		ksft_print_msg("Still FilePmdMapped not split after punch\n");
+		goto out;
+	}
+out:
+	close(fd);
+	unlink(testfile);
+	if (err)
+		ksft_exit_fail_msg("Punch holes in PMD-mapped pagecache folio failed\n");
+	ksft_test_result_pass("Punch holes PMD-mapped pagecache folio passed\n");
+}
+
 int main(int argc, char **argv)
 {
+	int i;
+	size_t fd_size;
+	off_t offset[2], len[2];
+
 	ksft_print_header();
 
 	if (geteuid() != 0) {
@@ -274,7 +457,7 @@ int main(int argc, char **argv)
 		ksft_finished();
 	}
 
-	ksft_set_plan(3);
+	ksft_set_plan(3+8+9+2);
 
 	pagesize = getpagesize();
 	pageshift = ffs(pagesize) - 1;
@@ -282,9 +465,37 @@ int main(int argc, char **argv)
 	if (!pmd_pagesize)
 		ksft_exit_fail_msg("Reading PMD pagesize failed\n");
 
+	fd_size = 2 * pmd_pagesize;
+
 	split_pmd_thp();
 	split_pte_mapped_thp();
 	split_file_backed_thp();
 
+	for (i = 8; i >= 0; i--)
+		if (i != 1)
+			split_thp_in_pagecache_to_order(fd_size, i);
+
+	/*
+	 * for i is 1, truncate code in the kernel should create order-0 pages
+	 * instead of order-1 THPs, since order-1 THP is not supported. No error
+	 * is expected.
+	 */
+	for (i = 8; i >= 0; i--)
+		truncate_thp_in_pagecache_to_order(fd_size, i);
+
+	offset[0] = 123;
+	offset[1] = 4 * pagesize;
+	len[0] = 200 * pagesize;
+	len[1] = 16 * pagesize;
+	punch_hole_in_pagecache_thp(fd_size, offset, len, 2, 1);
+
+	offset[0] = 259 * pagesize + pagesize / 2;
+	offset[1] = 33 * pagesize;
+	len[0] = 129 * pagesize;
+	len[1] = 16 * pagesize;
+	punch_hole_in_pagecache_thp(fd_size, offset, len, 2, 1);
+
 	ksft_finished();
+
+	return 0;
 }
-- 
2.43.0


