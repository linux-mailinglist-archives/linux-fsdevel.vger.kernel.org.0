Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A24829F55F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 20:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgJ2TeS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 15:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbgJ2TeO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:34:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFE0C0613D2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2020 12:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=moBwCUezAcUFLo9WoDknD01nYVYEhE9p2ZKZoE3n6zM=; b=akYO2Qy2xJ3zVwULlpMcvG8eoi
        xzf6a72H7GVH2I2lViSoHAXbUOPuAFimkpllWBeTtqcCcnpWzGL2WavspUlfIyn1FDiaBppxkNvRb
        hutBxqvgnS3FNDsLAIBEapy6pGVLdKYQU2H/gyMbkJCTi1z9kLlnBxqD3wbBTePiWu1qfmyJeeoNp
        tW1QU42p/Wu8b7dZUWpenEAZ53JGGBRJkJhH26bchczLELRwE6DXhS0ZGjc7tUD5XLtYSxUkMG+pm
        LFp44VXgB8Sl5XbXWxa4t8Kv33PvevbyjMf/IimtXGnHkXpXXp8K5tULJ4au45swYPoTEcr88U3YJ
        OHrpXn/w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYDga-0007dA-Le; Thu, 29 Oct 2020 19:34:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 19/19] selftests/vm/transhuge-stress: Support file-backed THPs
Date:   Thu, 29 Oct 2020 19:34:05 +0000
Message-Id: <20201029193405.29125-20-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201029193405.29125-1-willy@infradead.org>
References: <20201029193405.29125-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a -f <filename> option to test THPs on files

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 tools/testing/selftests/vm/transhuge-stress.c | 36 ++++++++++++-------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/vm/transhuge-stress.c b/tools/testing/selftests/vm/transhuge-stress.c
index fd7f1b4a96f9..77b775700bf6 100644
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
+						backing_fd, 0) != ptr)
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
@@ -69,14 +73,23 @@ int main(int argc, char **argv)
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
-
+	if (name) {
+		backing_fd = open(name, O_RDWR);
+		if (backing_fd == -1)
+			err(2, "open %s", name);
+		mmap_flags = MAP_SHARED;
+	}
 	warnx("allocate %zd transhuge pages, using %zd MiB virtual memory"
 	      " and %zd MiB of ram", len >> HPAGE_SHIFT, len >> 20,
 	      len >> (20 + HPAGE_SHIFT - PAGE_SHIFT - 1));
@@ -86,8 +99,7 @@ int main(int argc, char **argv)
 		err(2, "open pagemap");
 
 	len -= len % HPAGE_SIZE;
-	ptr = mmap(NULL, len + HPAGE_SIZE, PROT_READ | PROT_WRITE,
-			MAP_ANONYMOUS | MAP_NORESERVE | MAP_PRIVATE, -1, 0);
+	ptr = mmap(NULL, len + HPAGE_SIZE, PROT_RW, mmap_flags, backing_fd, 0);
 	if (ptr == MAP_FAILED)
 		err(2, "initial mmap");
 	ptr += HPAGE_SIZE - (uintptr_t)ptr % HPAGE_SIZE;
-- 
2.28.0

