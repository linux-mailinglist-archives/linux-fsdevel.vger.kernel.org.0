Return-Path: <linux-fsdevel+bounces-12880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF324868246
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 21:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 857A628A5BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 20:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74671339AA;
	Mon, 26 Feb 2024 20:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="OhmXJsbj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HkcqTlDi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C1D133282;
	Mon, 26 Feb 2024 20:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708980979; cv=none; b=M/1sCxn5BpDIo2dm6ltmG+K1AUN+ccOVBcjkNXWFmsXzRH1ZgVnSB44/9YaCIXhmc2wpD/bhyVE5ipu391vv4IYM31MIql+MCJa+2mVgbMRwojbu4kknOjuvOCMtMdON/cEEaVry6uTm5YlTPyFHGTnYOsxdl8+5ylxGvdn9VrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708980979; c=relaxed/simple;
	bh=vgsm4k7rgVedH8rRB2J8JRli9rUrF9iO5L/lbj+auXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q9HNsnAa1n8lVGFt+jnf0rNWvSzwboN8hz8Oguo3ZMAi9WyBBNYkw+OPuh5IsUCAotje4b+6BVMgiVhoEKSQRdkJMloLvVrsXSq7LE6eDXxgU2RWyr6Mu5EUAU/dNafUz8eXb+JPWX0xOHTgt0s84KKvb7+M/elt35oRDTccsfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=OhmXJsbj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HkcqTlDi; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 3F4E95C00A8;
	Mon, 26 Feb 2024 15:56:16 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 26 Feb 2024 15:56:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1708980976; x=1709067376; bh=eBpC8nLmV3t+tILOOyF9MHkmmffIcEidaEQ
	0IucvPX4=; b=OhmXJsbjvWBU33DO8vx9Sxyp+wXJmzSpaj6+LDBZDG49O+6ffyx
	ZSUltZ/7nhkEFqVsCc3a2BUJ4ZoVi67suV+jcrt7L2a41KVnXgGz7u5C2OQ4vK7Q
	qe5mbw7Dyw200uoLqf7Y25BxkdETjX2nq02CXm4lZAplslb24g51eTMqbeA1CC0j
	JE5a5N7H2DfGnr/RAYJJKK13TFEmJ+gq91rNp8+BSLK9z/0fwejQT7dLIWMMKkFA
	9cIxCDfrLy93emdUnHrFQdAslKi55y1LFDxW3rqJjzeiJY6ZHYZX2EqCL80oxiim
	9LB/ULPPKQBWQm0HacSUH3o3KmmnjeUpoiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1708980976; x=1709067376; bh=eBpC8nLmV3t+tILOOyF9MHkmmffIcEidaEQ
	0IucvPX4=; b=HkcqTlDiLWonV5rP8T2a91tyNh3gzcRKAFCXLT+izkUiGmAM2tV
	EqGPzyq9qIzXV+qS6IOEglz7RnR9WR0gQ+/KQDzJjaLsW2j4MS2zASpXMwSEtkeE
	/8IPpT7yvoXVSdApLjEfvcMxPf2UTtOX04hE40u5hQntCFfKyfCsyZmmoUrsP2gC
	1RSn1NOuSDsx9lVkwKOeusqYV2xuixW1d+E8Q1YSZQULNpCZYWHCxKKwFicO2vyo
	FllPcUGrYbTwUOhkLuvDr0qN88nRM6skelfHLgdoJ30SY7ohg5V9/inmL0zv/t1S
	4yDU6cQaB100xO5B1Ub2UmNrWOYZKr6DWPA==
X-ME-Sender: <xms:8PrcZUewksT6eqyNS7elE5kUUAdWRXCzH7xywK_SUrKPBFpWhXhfuw>
    <xme:8PrcZWP0PtiwmnaNZPNfqnU4sK89rmYhENbAdpP0l-VvsRLlSSOVD_L891SBu0V0a
    k1Zr0vDRgVCsydgaA>
X-ME-Received: <xmr:8PrcZVhYA7-ppK29uG0CMfFDb8Pr9eZUOkg-YBX32OWLsOnVuiWVGx9oHIsf6yt0DO_bU6b-NhN1xybPwTADkczzElSsU1IFQctxYkkMwEL8l6vQ33SJbaRl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgedvgddugedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrgggtgfesthekredtredtjeenucfhrhhomhepkghi
    ucgjrghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepje
    ekteekffelleekudfftdefvddtjeejuedtuedtteegjefgvedtfedujeekieevnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnse
    hsvghnthdrtghomh
X-ME-Proxy: <xmx:8PrcZZ8Zz1vu__5NAipN1mDTs2mPn97R70iKk57iJrL9QBOADG3Rrw>
    <xmx:8PrcZQuHCuWFZk2iGprfnIAy680TzAsWjXWlE9985OgeHx3ETMxz9A>
    <xmx:8PrcZQH-2YM2DCXXdhSEqh-17IkCN-5JfAydAN3IWi6jnwi3Lc8U8A>
    <xmx:8PrcZQReVwXQhAcM5XrHHkWf5VD9k509qekqHlS1UK_SkDXzdy70tg>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Feb 2024 15:56:15 -0500 (EST)
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
	Luis Chamberlain <mcgrof@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v5 8/8] mm: huge_memory: enable debugfs to split huge pages to any order.
Date: Mon, 26 Feb 2024 15:55:34 -0500
Message-ID: <20240226205534.1603748-9-zi.yan@sent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240226205534.1603748-1-zi.yan@sent.com>
References: <20240226205534.1603748-1-zi.yan@sent.com>
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
debugfs.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c                              |  34 ++++--
 .../selftests/mm/split_huge_page_test.c       | 115 +++++++++++++++++-
 2 files changed, 131 insertions(+), 18 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 8b47a96a28f9..50d146eb248f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3422,7 +3422,7 @@ static inline bool vma_not_suitable_for_thp_split(struct vm_area_struct *vma)
 }
 
 static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
-				unsigned long vaddr_end)
+				unsigned long vaddr_end, unsigned int new_order)
 {
 	int ret = 0;
 	struct task_struct *task;
@@ -3486,13 +3486,19 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
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
@@ -3510,7 +3516,7 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 }
 
 static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
-				pgoff_t off_end)
+				pgoff_t off_end, unsigned int new_order)
 {
 	struct filename *file;
 	struct file *candidate;
@@ -3549,7 +3555,7 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
 		if (!folio_trylock(folio))
 			goto next;
 
-		if (!split_folio(folio))
+		if (!split_folio_to_order(folio, new_order))
 			split++;
 
 		folio_unlock(folio);
@@ -3574,10 +3580,14 @@ static ssize_t split_huge_pages_write(struct file *file, const char __user *buf,
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
@@ -3606,29 +3616,29 @@ static ssize_t split_huge_pages_write(struct file *file, const char __user *buf,
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
index 7b698a848bab..cf09fdc9ef22 100644
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
@@ -265,8 +268,101 @@ void split_file_backed_thp(void)
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
 int main(int argc, char **argv)
 {
+	int i;
+	size_t fd_size;
+
 	ksft_print_header();
 
 	if (geteuid() != 0) {
@@ -274,7 +370,7 @@ int main(int argc, char **argv)
 		ksft_finished();
 	}
 
-	ksft_set_plan(3);
+	ksft_set_plan(3+9);
 
 	pagesize = getpagesize();
 	pageshift = ffs(pagesize) - 1;
@@ -282,9 +378,16 @@ int main(int argc, char **argv)
 	if (!pmd_pagesize)
 		ksft_exit_fail_msg("Reading PMD pagesize failed\n");
 
+	fd_size = 2 * pmd_pagesize;
+
 	split_pmd_thp();
 	split_pte_mapped_thp();
 	split_file_backed_thp();
 
+	for (i = 8; i >= 0; i--)
+		split_thp_in_pagecache_to_order(fd_size, i);
+
 	ksft_finished();
+
+	return 0;
 }
-- 
2.43.0


