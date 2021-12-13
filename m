Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBFB3471EEA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 01:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhLMAGu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Dec 2021 19:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbhLMAGt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Dec 2021 19:06:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BC3C06173F;
        Sun, 12 Dec 2021 16:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=2kcPCntTwKjxs8BtewFrXF8P1gkqleQIfk0SKAzJAwk=; b=mQr3499WyGyralX215DywFDBfN
        iQSkBf+sr90e/77C2c0q0fb9vvADZHRZMveeQpFhgTFZQTDWUGYu8jlYSMa7n0kiWzstjXXkUdJXS
        4j4tjRdYEyBRsNbQKaqREi0DhKcg6GOrQcRqqetBFgm3AtA4X6qxSADhtEp64L3VqVpN7GL9S2bBV
        6ezTmSaRKOb6VaQy8teoC4kM10ozXsVrU05lFxZgT0SthYJMFYAekNsYej9Qsl/NKWFSBK3JE97Me
        ksIE5s4bwM5vecpn0ZuFlqnSeWnZJ+JfjfFYxFzPx1D7gUikZQ6hjEJzg9XEcz/ladWf95trcOTjl
        uLsIRGJg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mwYrW-00CIuK-Ag; Mon, 13 Dec 2021 00:06:38 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        linux-kernel@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/3] vmcore: Convert read_from_oldmem() to take an iov_iter
Date:   Mon, 13 Dec 2021 00:06:36 +0000
Message-Id: <20211213000636.2932569-4-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211213000636.2932569-1-willy@infradead.org>
References: <20211213000636.2932569-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove the read_from_oldmem() wrapper introduced earlier and convert
all the remaining callers to pass an iov_iter.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/x86/kernel/crash_dump_64.c |  7 +++++-
 fs/proc/vmcore.c                | 40 +++++++++++++--------------------
 include/linux/crash_dump.h      | 10 ++++-----
 3 files changed, 25 insertions(+), 32 deletions(-)

diff --git a/arch/x86/kernel/crash_dump_64.c b/arch/x86/kernel/crash_dump_64.c
index 8d91e5f2e14d..991e09b80852 100644
--- a/arch/x86/kernel/crash_dump_64.c
+++ b/arch/x86/kernel/crash_dump_64.c
@@ -68,6 +68,11 @@ ssize_t copy_oldmem_page_encrypted(struct iov_iter *iter, unsigned long pfn,
 
 ssize_t elfcorehdr_read(char *buf, size_t count, u64 *ppos)
 {
-	return read_from_oldmem(buf, count, ppos, 0,
+	struct kvec kvec = { .iov_base = buf, .iov_len = count };
+	struct iov_iter iter;
+
+	iov_iter_kvec(&iter, READ, &kvec, 1, count);
+
+	return read_from_oldmem(&iter, count, ppos,
 				cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT));
 }
diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 443cbaf16ec8..986474f02a02 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -132,7 +132,7 @@ static int open_vmcore(struct inode *inode, struct file *file)
 }
 
 /* Reads a page from the oldmem device from given offset. */
-ssize_t read_from_oldmem_iter(struct iov_iter *iter, size_t count,
+ssize_t read_from_oldmem(struct iov_iter *iter, size_t count,
 			 u64 *ppos, bool encrypted)
 {
 	unsigned long pfn, offset;
@@ -180,27 +180,6 @@ ssize_t read_from_oldmem_iter(struct iov_iter *iter, size_t count,
 	return read;
 }
 
-ssize_t read_from_oldmem(char *buf, size_t count,
-			 u64 *ppos, int userbuf,
-			 bool encrypted)
-{
-	struct iov_iter iter;
-	struct iovec iov;
-	struct kvec kvec;
-
-	if (userbuf) {
-		iov.iov_base = (__force void __user *)buf;
-		iov.iov_len = count;
-		iov_iter_init(&iter, READ, &iov, 1, count);
-	} else {
-		kvec.iov_base = buf;
-		kvec.iov_len = count;
-		iov_iter_kvec(&iter, READ, &kvec, 1, count);
-	}
-
-	return read_from_oldmem_iter(&iter, count, ppos, encrypted);
-}
-
 /*
  * Architectures may override this function to allocate ELF header in 2nd kernel
  */
@@ -220,7 +199,12 @@ void __weak elfcorehdr_free(unsigned long long addr)
  */
 ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
 {
-	return read_from_oldmem(buf, count, ppos, 0, false);
+	struct kvec kvec = { .iov_base = buf, .iov_len = count };
+	struct iov_iter iter;
+
+	iov_iter_kvec(&iter, READ, &kvec, 1, count);
+
+	return read_from_oldmem(&iter, count, ppos, false);
 }
 
 /*
@@ -228,7 +212,13 @@ ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
  */
 ssize_t __weak elfcorehdr_read_notes(char *buf, size_t count, u64 *ppos)
 {
-	return read_from_oldmem(buf, count, ppos, 0, cc_platform_has(CC_ATTR_MEM_ENCRYPT));
+	struct kvec kvec = { .iov_base = buf, .iov_len = count };
+	struct iov_iter iter;
+
+	iov_iter_kvec(&iter, READ, &kvec, 1, count);
+
+	return read_from_oldmem(&iter, count, ppos,
+			cc_platform_has(CC_ATTR_MEM_ENCRYPT));
 }
 
 /*
@@ -405,7 +395,7 @@ static ssize_t __read_vmcore(struct iov_iter *iter, loff_t *fpos)
 					    m->offset + m->size - *fpos,
 					    iter->count);
 			start = m->paddr + *fpos - m->offset;
-			tmp = read_from_oldmem_iter(iter, tsz, &start,
+			tmp = read_from_oldmem(iter, tsz, &start,
 					cc_platform_has(CC_ATTR_MEM_ENCRYPT));
 			if (tmp < 0)
 				return tmp;
diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index a1cf7d5c03c7..0f3a656293b0 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -134,13 +134,11 @@ static inline int vmcore_add_device_dump(struct vmcoredd_data *data)
 #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
 
 #ifdef CONFIG_PROC_VMCORE
-ssize_t read_from_oldmem(char *buf, size_t count,
-			 u64 *ppos, int userbuf,
-			 bool encrypted);
+ssize_t read_from_oldmem(struct iov_iter *iter, size_t count,
+			 u64 *ppos, bool encrypted);
 #else
-static inline ssize_t read_from_oldmem(char *buf, size_t count,
-				       u64 *ppos, int userbuf,
-				       bool encrypted)
+static inline ssize_t read_from_oldmem(struct iov_iter *iter, size_t count,
+				       u64 *ppos, bool encrypted)
 {
 	return -EOPNOTSUPP;
 }
-- 
2.33.0

