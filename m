Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996AD6BFFB2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Mar 2023 08:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjCSHJt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Mar 2023 03:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjCSHJq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Mar 2023 03:09:46 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D788293E4;
        Sun, 19 Mar 2023 00:09:44 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id x3so35381717edb.10;
        Sun, 19 Mar 2023 00:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679209783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ML/fjqBQiFdniaLp2U4iIoVxIHX7dLvD1UO1EbWAfgg=;
        b=Z5A4SYAMeoS3RR8Z4VWJcLUiygTK9MPz2hpEcGzak+h9lDhV9fLONDhT9zbE2C+yNg
         8rv7BvOpHO0Sx3zejcitLQz6k0a4MVQIxsp9pkabAiX3qbecdxCSYy1n/OTf5RrL2ibo
         imKjO+t9688AnjvhOoFAdoaDlUwgG7oddRgRcNPVlJEtwMAZHJUFCIouxn9LGFRg5sPp
         3specuIgov4Tk2AoSaONSPqii/LRvwchK3NxsaP4ID8Jpud36J7LBJY7/MyOYZ+Yryl/
         eLLC8ao/emzfoxD23mCr58ZoewzZOJcncj0ZpZrlVsnuTdhu6B12vmmKBw5twY17tH8n
         24xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679209783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ML/fjqBQiFdniaLp2U4iIoVxIHX7dLvD1UO1EbWAfgg=;
        b=KPxyjybsdBCpGkkCm982QT6TnBQWKfv+VNpCzBL0Dt12+4wBXkKS0sB0ukrTtbeL2m
         W/kh+8mvzTyeoRRN6SEli/RSE38lNcRL011B8qkIrVltobRZW8TLiGpfdVTzDMlEYmM8
         8/lKyzYCzcqF39NI0JGB1g2JmptrbVgx8RBqSUYgwMt5ZoA1gNf6houQX88/w3a/Mo+M
         6BCta2vP7tXxRmfltVQtz/xK08LCuIxYh9q9uw00yBK08b/SZ5QyfgIpQkw6FPOG1Tw1
         oWkInZPfLNQKBgAX4L4F40lB7/0wqrBEbt1Inb4ZwpXQ4+Dxk9hUst5y52khFK8delgN
         qWRw==
X-Gm-Message-State: AO0yUKWgJ+u8OmYKXDojAp7vSYFuuH97Ctx/So7j70ybiGsC3/0c9Ygp
        6+NhTPeuX2r04fJTa61TyAI=
X-Google-Smtp-Source: AK7set+MDLQIHRjSLb5brGnPCVCIAh7+aXOeit8OMTHh4Z0ogtj8/iZA2kquj6wEYzeRrXr2kOJBAQ==
X-Received: by 2002:a17:907:3e0e:b0:933:3da2:436 with SMTP id hp14-20020a1709073e0e00b009333da20436mr4510936ejc.54.1679209783409;
        Sun, 19 Mar 2023 00:09:43 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23ee:1938:1bcd:c6e1:42ba:ae87:772e])
        by smtp.googlemail.com with ESMTPSA id u8-20020a170906b10800b008c9b44b7851sm2943920ejy.182.2023.03.19.00.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 00:09:42 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Baoquan He <bhe@redhat.com>, Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v2 3/4] fs/proc/kcore: convert read_kcore() to read_kcore_iter()
Date:   Sun, 19 Mar 2023 07:09:32 +0000
Message-Id: <32f8fad50500d0cd0927a66638c5890533725d30.1679209395.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679209395.git.lstoakes@gmail.com>
References: <cover.1679209395.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now we have eliminated spinlocks from the vread() case, convert
read_kcore() to read_kcore_iter().

For the time being we still use a bounce buffer for vread(), however in the
next patch we will convert this to interact directly with the iterator and
eliminate the bounce buffer altogether.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 fs/proc/kcore.c | 58 ++++++++++++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 556f310d6aa4..25e0eeb8d498 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -24,7 +24,7 @@
 #include <linux/memblock.h>
 #include <linux/init.h>
 #include <linux/slab.h>
-#include <linux/uaccess.h>
+#include <linux/uio.h>
 #include <asm/io.h>
 #include <linux/list.h>
 #include <linux/ioport.h>
@@ -308,9 +308,12 @@ static void append_kcore_note(char *notes, size_t *i, const char *name,
 }
 
 static ssize_t
-read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
+read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
+	struct file *file = iocb->ki_filp;
 	char *buf = file->private_data;
+	loff_t *ppos = &iocb->ki_pos;
+
 	size_t phdrs_offset, notes_offset, data_offset;
 	size_t page_offline_frozen = 1;
 	size_t phdrs_len, notes_len;
@@ -318,6 +321,7 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 	size_t tsz;
 	int nphdr;
 	unsigned long start;
+	size_t buflen = iov_iter_count(iter);
 	size_t orig_buflen = buflen;
 	int ret = 0;
 
@@ -333,7 +337,7 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 	notes_offset = phdrs_offset + phdrs_len;
 
 	/* ELF file header. */
-	if (buflen && *fpos < sizeof(struct elfhdr)) {
+	if (buflen && *ppos < sizeof(struct elfhdr)) {
 		struct elfhdr ehdr = {
 			.e_ident = {
 				[EI_MAG0] = ELFMAG0,
@@ -355,19 +359,18 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 			.e_phnum = nphdr,
 		};
 
-		tsz = min_t(size_t, buflen, sizeof(struct elfhdr) - *fpos);
-		if (copy_to_user(buffer, (char *)&ehdr + *fpos, tsz)) {
+		tsz = min_t(size_t, buflen, sizeof(struct elfhdr) - *ppos);
+		if (copy_to_iter((char *)&ehdr + *ppos, tsz, iter) != tsz) {
 			ret = -EFAULT;
 			goto out;
 		}
 
-		buffer += tsz;
 		buflen -= tsz;
-		*fpos += tsz;
+		*ppos += tsz;
 	}
 
 	/* ELF program headers. */
-	if (buflen && *fpos < phdrs_offset + phdrs_len) {
+	if (buflen && *ppos < phdrs_offset + phdrs_len) {
 		struct elf_phdr *phdrs, *phdr;
 
 		phdrs = kzalloc(phdrs_len, GFP_KERNEL);
@@ -397,22 +400,21 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 			phdr++;
 		}
 
-		tsz = min_t(size_t, buflen, phdrs_offset + phdrs_len - *fpos);
-		if (copy_to_user(buffer, (char *)phdrs + *fpos - phdrs_offset,
-				 tsz)) {
+		tsz = min_t(size_t, buflen, phdrs_offset + phdrs_len - *ppos);
+		if (copy_to_iter((char *)phdrs + *ppos - phdrs_offset, tsz,
+				 iter) != tsz) {
 			kfree(phdrs);
 			ret = -EFAULT;
 			goto out;
 		}
 		kfree(phdrs);
 
-		buffer += tsz;
 		buflen -= tsz;
-		*fpos += tsz;
+		*ppos += tsz;
 	}
 
 	/* ELF note segment. */
-	if (buflen && *fpos < notes_offset + notes_len) {
+	if (buflen && *ppos < notes_offset + notes_len) {
 		struct elf_prstatus prstatus = {};
 		struct elf_prpsinfo prpsinfo = {
 			.pr_sname = 'R',
@@ -447,24 +449,23 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 				  vmcoreinfo_data,
 				  min(vmcoreinfo_size, notes_len - i));
 
-		tsz = min_t(size_t, buflen, notes_offset + notes_len - *fpos);
-		if (copy_to_user(buffer, notes + *fpos - notes_offset, tsz)) {
+		tsz = min_t(size_t, buflen, notes_offset + notes_len - *ppos);
+		if (copy_to_iter(notes + *ppos - notes_offset, tsz, iter) != tsz) {
 			kfree(notes);
 			ret = -EFAULT;
 			goto out;
 		}
 		kfree(notes);
 
-		buffer += tsz;
 		buflen -= tsz;
-		*fpos += tsz;
+		*ppos += tsz;
 	}
 
 	/*
 	 * Check to see if our file offset matches with any of
 	 * the addresses in the elf_phdr on our list.
 	 */
-	start = kc_offset_to_vaddr(*fpos - data_offset);
+	start = kc_offset_to_vaddr(*ppos - data_offset);
 	if ((tsz = (PAGE_SIZE - (start & ~PAGE_MASK))) > buflen)
 		tsz = buflen;
 
@@ -497,7 +498,7 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 		}
 
 		if (!m) {
-			if (clear_user(buffer, tsz)) {
+			if (iov_iter_zero(tsz, iter) != tsz) {
 				ret = -EFAULT;
 				goto out;
 			}
@@ -508,14 +509,14 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 		case KCORE_VMALLOC:
 			vread(buf, (char *)start, tsz);
 			/* we have to zero-fill user buffer even if no read */
-			if (copy_to_user(buffer, buf, tsz)) {
+			if (copy_to_iter(buf, tsz, iter) != tsz) {
 				ret = -EFAULT;
 				goto out;
 			}
 			break;
 		case KCORE_USER:
 			/* User page is handled prior to normal kernel page: */
-			if (copy_to_user(buffer, (char *)start, tsz)) {
+			if (copy_to_iter((char *)start, tsz, iter) != tsz) {
 				ret = -EFAULT;
 				goto out;
 			}
@@ -531,7 +532,7 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 			 */
 			if (!page || PageOffline(page) ||
 			    is_page_hwpoison(page) || !pfn_is_ram(pfn)) {
-				if (clear_user(buffer, tsz)) {
+				if (iov_iter_zero(tsz, iter) != tsz) {
 					ret = -EFAULT;
 					goto out;
 				}
@@ -541,25 +542,24 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 		case KCORE_VMEMMAP:
 		case KCORE_TEXT:
 			/*
-			 * We use _copy_to_user() to bypass usermode hardening
+			 * We use _copy_to_iter() to bypass usermode hardening
 			 * which would otherwise prevent this operation.
 			 */
-			if (_copy_to_user(buffer, (char *)start, tsz)) {
+			if (_copy_to_iter((char *)start, tsz, iter) != tsz) {
 				ret = -EFAULT;
 				goto out;
 			}
 			break;
 		default:
 			pr_warn_once("Unhandled KCORE type: %d\n", m->type);
-			if (clear_user(buffer, tsz)) {
+			if (iov_iter_zero(tsz, iter) != tsz) {
 				ret = -EFAULT;
 				goto out;
 			}
 		}
 skip:
 		buflen -= tsz;
-		*fpos += tsz;
-		buffer += tsz;
+		*ppos += tsz;
 		start += tsz;
 		tsz = (buflen > PAGE_SIZE ? PAGE_SIZE : buflen);
 	}
@@ -603,7 +603,7 @@ static int release_kcore(struct inode *inode, struct file *file)
 }
 
 static const struct proc_ops kcore_proc_ops = {
-	.proc_read	= read_kcore,
+	.proc_read_iter	= read_kcore_iter,
 	.proc_open	= open_kcore,
 	.proc_release	= release_kcore,
 	.proc_lseek	= default_llseek,
-- 
2.39.2

