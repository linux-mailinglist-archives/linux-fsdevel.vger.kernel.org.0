Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513C64EFEA9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Apr 2022 06:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349239AbiDBEcz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Apr 2022 00:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236778AbiDBEca (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Apr 2022 00:32:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E246039B86
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Apr 2022 21:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648873837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SwoSDylHa6/85uX5t9YhtzPHgxh2vrcpIjVJxcFxtaQ=;
        b=hDvRE+SWRghK6cqeCNWe5XVo/niBK+6Ov3S8z+WvFT2GW1e72C6DUmIqA23l2ioff3XOs1
        1mrbtp+02rgnBUgB7g6hha2HaaoOn4y3lHPDmofMrb+kVRezfRGqci5KphYWQfzf+OkakN
        b1ntGK+nICWDmZ7A1Fg8sRZoSHGyy9Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-626-sShT0NKGNMec6hI3k5AlBg-1; Sat, 02 Apr 2022 00:30:36 -0400
X-MC-Unique: sShT0NKGNMec6hI3k5AlBg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 10FF183395F;
        Sat,  2 Apr 2022 04:30:36 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-21.pek2.redhat.com [10.72.12.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4F2FF40FF416;
        Sat,  2 Apr 2022 04:30:30 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     akpm@linux-foundation.org, willy@infradead.org
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        yangtiezhu@loongson.cn, amit.kachhap@arm.com, hch@lst.de,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        bhe@redhat.com
Subject: [PATCH v5 3/3] vmcore: Convert read_from_oldmem() to take an iov_iter
Date:   Sat,  2 Apr 2022 12:30:08 +0800
Message-Id: <20220402043008.458679-4-bhe@redhat.com>
In-Reply-To: <20220402043008.458679-1-bhe@redhat.com>
References: <20220402043008.458679-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Remove the read_from_oldmem() wrapper introduced earlier and convert
all the remaining callers to pass an iov_iter.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/kernel/crash_dump_64.c |  7 +++++-
 fs/proc/vmcore.c                | 40 +++++++++++++--------------------
 include/linux/crash_dump.h      | 10 ++++-----
 3 files changed, 25 insertions(+), 32 deletions(-)

diff --git a/arch/x86/kernel/crash_dump_64.c b/arch/x86/kernel/crash_dump_64.c
index f922d51c9d1f..0fa87648e55c 100644
--- a/arch/x86/kernel/crash_dump_64.c
+++ b/arch/x86/kernel/crash_dump_64.c
@@ -55,6 +55,11 @@ ssize_t copy_oldmem_page_encrypted(struct iov_iter *iter, unsigned long pfn,
 
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
index 4a721865b5cd..4eaeb645e759 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -129,7 +129,7 @@ static int open_vmcore(struct inode *inode, struct file *file)
 }
 
 /* Reads a page from the oldmem device from given offset. */
-static ssize_t read_from_oldmem_iter(struct iov_iter *iter, size_t count,
+ssize_t read_from_oldmem(struct iov_iter *iter, size_t count,
 			 u64 *ppos, bool encrypted)
 {
 	unsigned long pfn, offset;
@@ -178,27 +178,6 @@ static ssize_t read_from_oldmem_iter(struct iov_iter *iter, size_t count,
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
@@ -218,7 +197,12 @@ void __weak elfcorehdr_free(unsigned long long addr)
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
@@ -226,7 +210,13 @@ ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
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
@@ -402,7 +392,7 @@ static ssize_t __read_vmcore(struct iov_iter *iter, loff_t *fpos)
 					    m->offset + m->size - *fpos,
 					    iov_iter_count(iter));
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
2.34.1

