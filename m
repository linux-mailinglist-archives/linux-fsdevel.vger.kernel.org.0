Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8FB48FC9C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jan 2022 13:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbiAPMSb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Jan 2022 07:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbiAPMS3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Jan 2022 07:18:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7BAC06173E;
        Sun, 16 Jan 2022 04:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=n98nGVb9Cb+XvLGLcWCumBllUZqlAwFV4o2oMVvKDzc=; b=o2t+DeyBUbS3FevpABu9qYgtan
        rupYDPIC9rxuQOAHz+dZRxG8INRfiE7ODy5CXtaBeYJBCNNg3pVTAxPa4mpHTyByTf38ZmKRMscg2
        fR5Nr5Mfh1eTKO6PbCjVgEAEhVno3UrZGhbLjsLQkMIH1kQdG6m9pA9NRt9ix/G1/MtOpwxZnrmqn
        3AL6nVaDn1iqZZBHuFy9SEL8U3dzAec/FHw8YWsemfqETZDhmSqU3/6z8gGH7qs0FDVWMZQ5jHcmI
        GOaKc47uNoHsD34cT7Thya53pYEXEpJWuNse3/zAZBn/iWhOwEd6hgSkQnLt5nWaNgGkHjiMj6Mvn
        1LDB0d3A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n94UN-007FUv-5q; Sun, 16 Jan 2022 12:18:27 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 12/12] selftests/vm/transhuge-stress: Support file-backed PMD folios
Date:   Sun, 16 Jan 2022 12:18:22 +0000
Message-Id: <20220116121822.1727633-13-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220116121822.1727633-1-willy@infradead.org>
References: <20220116121822.1727633-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a -f <filename> option to test PMD folios on files

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 tools/testing/selftests/vm/transhuge-stress.c | 35 +++++++++++++------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/vm/transhuge-stress.c b/tools/testing/selftests/vm/transhuge-stress.c
index 5e4c036f6ad3..a03cb3fce1f6 100644
--- a/tools/testing/selftests/vm/transhuge-stress.c
+++ b/tools/testing/selftests/vm/transhuge-stress.c
@@ -26,15 +26,17 @@
 #define PAGEMAP_PFN(ent)	((ent) & ((1ull << 55) - 1))
 
 int pagemap_fd;
+int backing_fd = -1;
+int mmap_flags = MAP_ANONYMOUS | MAP_NORESERVE | MAP_PRIVATE;
+#define PROT_RW (PROT_READ | PROT_WRITE)
 
 int64_t allocate_transhuge(void *ptr)
 {
 	uint64_t ent[2];
 
 	/* drop pmd */
-	if (mmap(ptr, HPAGE_SIZE, PROT_READ | PROT_WRITE,
-				MAP_FIXED | MAP_ANONYMOUS |
-				MAP_NORESERVE | MAP_PRIVATE, -1, 0) != ptr)
+	if (mmap(ptr, HPAGE_SIZE, PROT_RW, MAP_FIXED | mmap_flags,
+		 backing_fd, 0) != ptr)
 		errx(2, "mmap transhuge");
 
 	if (madvise(ptr, HPAGE_SIZE, MADV_HUGEPAGE))
@@ -60,6 +62,8 @@ int main(int argc, char **argv)
 	size_t ram, len;
 	void *ptr, *p;
 	struct timespec a, b;
+	int i = 0;
+	char *name = NULL;
 	double s;
 	uint8_t *map;
 	size_t map_len;
@@ -69,13 +73,23 @@ int main(int argc, char **argv)
 		ram = SIZE_MAX / 4;
 	else
 		ram *= sysconf(_SC_PAGESIZE);
+	len = ram;
+
+	while (++i < argc) {
+		if (!strcmp(argv[i], "-h"))
+			errx(1, "usage: %s [size in MiB]", argv[0]);
+		else if (!strcmp(argv[i], "-f"))
+			name = argv[++i];
+		else
+			len = atoll(argv[i]) << 20;
+	}
 
-	if (argc == 1)
-		len = ram;
-	else if (!strcmp(argv[1], "-h"))
-		errx(1, "usage: %s [size in MiB]", argv[0]);
-	else
-		len = atoll(argv[1]) << 20;
+	if (name) {
+		backing_fd = open(name, O_RDWR);
+		if (backing_fd == -1)
+			errx(2, "open %s", name);
+		mmap_flags = MAP_SHARED;
+	}
 
 	warnx("allocate %zd transhuge pages, using %zd MiB virtual memory"
 	      " and %zd MiB of ram", len >> HPAGE_SHIFT, len >> 20,
@@ -86,8 +100,7 @@ int main(int argc, char **argv)
 		err(2, "open pagemap");
 
 	len -= len % HPAGE_SIZE;
-	ptr = mmap(NULL, len + HPAGE_SIZE, PROT_READ | PROT_WRITE,
-			MAP_ANONYMOUS | MAP_NORESERVE | MAP_PRIVATE, -1, 0);
+	ptr = mmap(NULL, len + HPAGE_SIZE, PROT_RW, mmap_flags, backing_fd, 0);
 	if (ptr == MAP_FAILED)
 		err(2, "initial mmap");
 	ptr += HPAGE_SIZE - (uintptr_t)ptr % HPAGE_SIZE;
-- 
2.34.1

