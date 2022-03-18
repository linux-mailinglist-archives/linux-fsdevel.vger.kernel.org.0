Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A624DD732
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 10:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbiCRJiw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Mar 2022 05:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234539AbiCRJiu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Mar 2022 05:38:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4723E2EB544
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Mar 2022 02:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647596251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eQqq3tAm+IryJ8cAH+qgKU1zkyNnMxOLjwIL6dRIXvw=;
        b=NwmNzmyTa1ykFu+SwcrbMJJIs94bvjDo09KBpji2GaEGLObP8B2DSixrH5Ege/naOkF9NN
        x8zSGWTK8zTRgHcGmLfJAMd8EdZnqIN3z9GuPlO3K6A/Z+jk8t/KsKbsMpQ8rawGXS6zWE
        RFMdqk5jLCFtv8eKyyBRyLcLIouIYEY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-G4iKGDoQONK-N6PQuvQUtg-1; Fri, 18 Mar 2022 05:37:28 -0400
X-MC-Unique: G4iKGDoQONK-N6PQuvQUtg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B8D9B8002BF;
        Fri, 18 Mar 2022 09:37:27 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-13-174.pek2.redhat.com [10.72.13.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F344112C08E;
        Fri, 18 Mar 2022 09:37:23 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     willy@infradead.org, bhe@redhat.com, kexec@lists.infradead.org,
        yangtiezhu@loongson.cn, amit.kachhap@arm.com, hch@lst.de,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: [PATCH v4 2/4] vmcore: Convert __read_vmcore to use an iov_iter
Date:   Fri, 18 Mar 2022 17:37:04 +0800
Message-Id: <20220318093706.161534-3-bhe@redhat.com>
In-Reply-To: <20220318093706.161534-1-bhe@redhat.com>
References: <20220318093706.161534-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

This gets rid of copy_to() and let us use proc_read_iter() instead
of proc_read().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Baoquan He <bhe@redhat.com>
---
 fs/proc/vmcore.c | 81 +++++++++++++++++-------------------------------
 1 file changed, 29 insertions(+), 52 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 7e7252e162c2..cebf49160ea5 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -246,22 +246,8 @@ ssize_t __weak copy_oldmem_page_encrypted(struct iov_iter *iter,
 	return copy_oldmem_page(iter, pfn, csize, offset);
 }
 
-/*
- * Copy to either kernel or user space
- */
-static int copy_to(void *target, void *src, size_t size, int userbuf)
-{
-	if (userbuf) {
-		if (copy_to_user((char __user *) target, src, size))
-			return -EFAULT;
-	} else {
-		memcpy(target, src, size);
-	}
-	return 0;
-}
-
 #ifdef CONFIG_PROC_VMCORE_DEVICE_DUMP
-static int vmcoredd_copy_dumps(void *dst, u64 start, size_t size, int userbuf)
+static int vmcoredd_copy_dumps(struct iov_iter *iter, u64 start, size_t size)
 {
 	struct vmcoredd_node *dump;
 	u64 offset = 0;
@@ -274,14 +260,13 @@ static int vmcoredd_copy_dumps(void *dst, u64 start, size_t size, int userbuf)
 		if (start < offset + dump->size) {
 			tsz = min(offset + (u64)dump->size - start, (u64)size);
 			buf = dump->buf + start - offset;
-			if (copy_to(dst, buf, tsz, userbuf)) {
+			if (copy_to_iter(buf, tsz, iter) < tsz) {
 				ret = -EFAULT;
 				goto out_unlock;
 			}
 
 			size -= tsz;
 			start += tsz;
-			dst += tsz;
 
 			/* Leave now if buffer filled already */
 			if (!size)
@@ -337,33 +322,28 @@ static int vmcoredd_mmap_dumps(struct vm_area_struct *vma, unsigned long dst,
 /* Read from the ELF header and then the crash dump. On error, negative value is
  * returned otherwise number of bytes read are returned.
  */
-static ssize_t __read_vmcore(char *buffer, size_t buflen, loff_t *fpos,
-			     int userbuf)
+static ssize_t __read_vmcore(struct iov_iter *iter, loff_t *fpos)
 {
 	ssize_t acc = 0, tmp;
 	size_t tsz;
 	u64 start;
 	struct vmcore *m = NULL;
 
-	if (buflen == 0 || *fpos >= vmcore_size)
+	if (iter->count == 0 || *fpos >= vmcore_size)
 		return 0;
 
-	/* trim buflen to not go beyond EOF */
-	if (buflen > vmcore_size - *fpos)
-		buflen = vmcore_size - *fpos;
+	iov_iter_truncate(iter, vmcore_size - *fpos);
 
 	/* Read ELF core header */
 	if (*fpos < elfcorebuf_sz) {
-		tsz = min(elfcorebuf_sz - (size_t)*fpos, buflen);
-		if (copy_to(buffer, elfcorebuf + *fpos, tsz, userbuf))
+		tsz = min(elfcorebuf_sz - (size_t)*fpos, iter->count);
+		if (copy_to_iter(elfcorebuf + *fpos, tsz, iter) < tsz)
 			return -EFAULT;
-		buflen -= tsz;
 		*fpos += tsz;
-		buffer += tsz;
 		acc += tsz;
 
 		/* leave now if filled buffer already */
-		if (buflen == 0)
+		if (iter->count == 0)
 			return acc;
 	}
 
@@ -384,35 +364,31 @@ static ssize_t __read_vmcore(char *buffer, size_t buflen, loff_t *fpos,
 		/* Read device dumps */
 		if (*fpos < elfcorebuf_sz + vmcoredd_orig_sz) {
 			tsz = min(elfcorebuf_sz + vmcoredd_orig_sz -
-				  (size_t)*fpos, buflen);
+				  (size_t)*fpos, iter->count);
 			start = *fpos - elfcorebuf_sz;
-			if (vmcoredd_copy_dumps(buffer, start, tsz, userbuf))
+			if (vmcoredd_copy_dumps(iter, start, tsz))
 				return -EFAULT;
 
-			buflen -= tsz;
 			*fpos += tsz;
-			buffer += tsz;
 			acc += tsz;
 
 			/* leave now if filled buffer already */
-			if (!buflen)
+			if (!iter->count)
 				return acc;
 		}
 #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
 
 		/* Read remaining elf notes */
-		tsz = min(elfcorebuf_sz + elfnotes_sz - (size_t)*fpos, buflen);
+		tsz = min(elfcorebuf_sz + elfnotes_sz - (size_t)*fpos, iter->count);
 		kaddr = elfnotes_buf + *fpos - elfcorebuf_sz - vmcoredd_orig_sz;
-		if (copy_to(buffer, kaddr, tsz, userbuf))
+		if (copy_to_iter(kaddr, tsz, iter) < tsz)
 			return -EFAULT;
 
-		buflen -= tsz;
 		*fpos += tsz;
-		buffer += tsz;
 		acc += tsz;
 
 		/* leave now if filled buffer already */
-		if (buflen == 0)
+		if (iter->count == 0)
 			return acc;
 	}
 
@@ -420,19 +396,17 @@ static ssize_t __read_vmcore(char *buffer, size_t buflen, loff_t *fpos,
 		if (*fpos < m->offset + m->size) {
 			tsz = (size_t)min_t(unsigned long long,
 					    m->offset + m->size - *fpos,
-					    buflen);
+					    iter->count);
 			start = m->paddr + *fpos - m->offset;
-			tmp = read_from_oldmem(buffer, tsz, &start,
-					       userbuf, cc_platform_has(CC_ATTR_MEM_ENCRYPT));
+			tmp = read_from_oldmem_iter(iter, tsz, &start,
+					cc_platform_has(CC_ATTR_MEM_ENCRYPT));
 			if (tmp < 0)
 				return tmp;
-			buflen -= tsz;
 			*fpos += tsz;
-			buffer += tsz;
 			acc += tsz;
 
 			/* leave now if filled buffer already */
-			if (buflen == 0)
+			if (iter->count == 0)
 				return acc;
 		}
 	}
@@ -440,15 +414,14 @@ static ssize_t __read_vmcore(char *buffer, size_t buflen, loff_t *fpos,
 	return acc;
 }
 
-static ssize_t read_vmcore(struct file *file, char __user *buffer,
-			   size_t buflen, loff_t *fpos)
+static ssize_t read_vmcore(struct kiocb *iocb, struct iov_iter *iter)
 {
-	return __read_vmcore((__force char *) buffer, buflen, fpos, 1);
+	return __read_vmcore(iter, &iocb->ki_pos);
 }
 
 /*
  * The vmcore fault handler uses the page cache and fills data using the
- * standard __vmcore_read() function.
+ * standard __read_vmcore() function.
  *
  * On s390 the fault handler is used for memory regions that can't be mapped
  * directly with remap_pfn_range().
@@ -458,9 +431,10 @@ static vm_fault_t mmap_vmcore_fault(struct vm_fault *vmf)
 #ifdef CONFIG_S390
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
 	pgoff_t index = vmf->pgoff;
+	struct iov_iter iter;
+	struct kvec kvec;
 	struct page *page;
 	loff_t offset;
-	char *buf;
 	int rc;
 
 	page = find_or_create_page(mapping, index, GFP_KERNEL);
@@ -468,8 +442,11 @@ static vm_fault_t mmap_vmcore_fault(struct vm_fault *vmf)
 		return VM_FAULT_OOM;
 	if (!PageUptodate(page)) {
 		offset = (loff_t) index << PAGE_SHIFT;
-		buf = __va((page_to_pfn(page) << PAGE_SHIFT));
-		rc = __read_vmcore(buf, PAGE_SIZE, &offset, 0);
+		kvec.iov_base = page_address(page);
+		kvec.iov_len = PAGE_SIZE;
+		iov_iter_kvec(&iter, READ, &kvec, 1, PAGE_SIZE);
+
+		rc = __read_vmcore(&iter, &offset);
 		if (rc < 0) {
 			unlock_page(page);
 			put_page(page);
@@ -719,7 +696,7 @@ static int mmap_vmcore(struct file *file, struct vm_area_struct *vma)
 
 static const struct proc_ops vmcore_proc_ops = {
 	.proc_open	= open_vmcore,
-	.proc_read	= read_vmcore,
+	.proc_read_iter	= read_vmcore,
 	.proc_lseek	= default_llseek,
 	.proc_mmap	= mmap_vmcore,
 };
-- 
2.34.1

