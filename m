Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED8D6C3C4B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 21:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjCUUyt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 16:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjCUUym (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 16:54:42 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0CC53DA2;
        Tue, 21 Mar 2023 13:54:41 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id l27so6733627wrb.2;
        Tue, 21 Mar 2023 13:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679432081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ML/fjqBQiFdniaLp2U4iIoVxIHX7dLvD1UO1EbWAfgg=;
        b=YTjVAh5UfzB+CsNEwTjIfb2sXKfTJ9cL7bqTAxOe7qKhN/upK8iC1PWM4DgivCzm05
         ttdfRorxxCQpI8/l/gjPXvwGkms6pAF/al5MUxDX9d29ZwadLfLdqvcgFWxJRQlmoPU0
         4CQjzyHq9YLOAM/rJpnucme9REBoZcWXxJahEAgd5cgkouFCER0RSVQY7R6X0jPpWQS5
         kwz6QwVxOqeLv2eeBoVOR31iuvqP++gLvSyZ6i9Neca6kI2ufsLY60u+lPSTF9Drw/0B
         y/A0h4kUaYY421T28LPml4lEv3IvBC9TEoU3UqAi5t4S+TH22FkUnGAGXYjuGAsOojMf
         UF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679432081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ML/fjqBQiFdniaLp2U4iIoVxIHX7dLvD1UO1EbWAfgg=;
        b=2/9kLv2VzGUavtLs7gNI53cdxs4XZ5x1wp6ebAGOv8VaUr/IyV8JPSeO50eS5C770J
         Zp/s0+ZCz7cX4aOw323WjA0S7LY2yrXro9yMfpksS3QolrgUjQOYrFhkeP5whG3PlINx
         Y7mx8Wse/d2wPRoFRpJRkmiCkbB3y7NXeCKD6n9m3lbd312Y3/DfOBw0PzohBbbD5BX1
         DiuTgerJse+OlCeB2V523VWr3sT7MZAFT1tIYwI8uscHEw0QmpTCUWiJgqFx51+BxPwa
         vol3RaModyhItpc0eayxV+opteexN7tOzgSMmCK3G2+lU00VsOv2eenIJ7YaSL6LCC2p
         jTgQ==
X-Gm-Message-State: AO0yUKXkMAxkU81shL+jE9GNW/fVmP6kN8OvLPEohN0DPxJAM9BMORDn
        dsrM7LtNdWnxg6FPuhj5CpE=
X-Google-Smtp-Source: AK7set8MSnjFXlCZD0uN53pKmP4le+esx+7d2fMHwFpAur07bL4JB0RzcgXxWJwNwVXEk2Q3nrp++g==
X-Received: by 2002:adf:e682:0:b0:2d8:1aff:813 with SMTP id r2-20020adfe682000000b002d81aff0813mr3718845wrm.43.1679432080699;
        Tue, 21 Mar 2023 13:54:40 -0700 (PDT)
Received: from lucifer.home (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.googlemail.com with ESMTPSA id a8-20020a056000100800b002d8566128e5sm3744575wrx.25.2023.03.21.13.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 13:54:39 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Baoquan He <bhe@redhat.com>, Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v4 2/4] fs/proc/kcore: convert read_kcore() to read_kcore_iter()
Date:   Tue, 21 Mar 2023 20:54:31 +0000
Message-Id: <a84da6cc458b44d949058b5f475ed3225008cfd9.1679431886.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679431886.git.lstoakes@gmail.com>
References: <cover.1679431886.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

