Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058CB6BFE9E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Mar 2023 01:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjCSAZl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Mar 2023 20:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjCSAYm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Mar 2023 20:24:42 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA3D2C67F;
        Sat, 18 Mar 2023 17:21:54 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id i9so7385662wrp.3;
        Sat, 18 Mar 2023 17:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679185220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ML/fjqBQiFdniaLp2U4iIoVxIHX7dLvD1UO1EbWAfgg=;
        b=n3/WQOG/ih4PqFSwkZOumfiFVTaTsKhtI63BBDGI+/vv/zPkXwXwDN0ApMTMTk8SYB
         ZMBRckYTo15ECbqaHnrBo48DrtOZUTNYDSw8c2T1sKBr5u2pwlk3r9mfSp26dS+X7GiD
         hT0ZMmPNSr5XADXvConvouz1CmLldien5XgSGZJMS+0yZw8l6uxPhbwG5PXY7KrqrM5C
         pMxQhA41a0VwFVargL4lvGa73JGXOiX13ei56eMROD8jAJ7I7o5+7YinueUteFCHDPXM
         230nGcCMkJr4sHIdUsxmxEX2nkRrEyhgq3V6csMtQPw4EcM45xMSJc3lLbFfE8xRTgJJ
         bZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679185220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ML/fjqBQiFdniaLp2U4iIoVxIHX7dLvD1UO1EbWAfgg=;
        b=ccR0Go4jV2kgjMuaF5K86GP9semjSbCJLcLD253xGCvgUZApABBgcNpyptCDnxq/b1
         nJeiw9RgTNabLQI6doet3ERsI4Dhm+RApIAXU7rB7ImRgJH2k54vaLgDFkzGbGduaHvz
         5fm+2DyJq5Q92gEkS+NzCs96bmZPqJudLvJ/Yy3458M9CHt8iDz2s/UxDXzL/mV2l9hE
         bmXerK7xL0MJwPSvB5IDLkptKL9yog6WSx3fXmHu+7b6+5K9k5UaDY0FlUq6By9GyQwp
         B1amcmGH2m1czGu8sRkBbpkh+HIaZaiJXYRXyI4wz/JosdW/yfRjaN8N52KqazEuFBGq
         lLOA==
X-Gm-Message-State: AO0yUKVEGpnDIBgcdP5ly/w0T2e9o9LlVAnNi90cXnN3A5cvzXQgHXFF
        +/KuyV77on1ckuya4HONqK1JBr3DtU0=
X-Google-Smtp-Source: AK7set95d6yiRVYGBDcNsU8nn/6kRPj65SWvFG+EDet5fLk/OpQVCKm3COqIdxAlwCybBefp9ljiDQ==
X-Received: by 2002:a5d:54c1:0:b0:2d3:fba4:e61d with SMTP id x1-20020a5d54c1000000b002d3fba4e61dmr4877232wrv.12.1679185220032;
        Sat, 18 Mar 2023 17:20:20 -0700 (PDT)
Received: from lucifer.home (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.googlemail.com with ESMTPSA id x14-20020adfdd8e000000b002cff0c57b98sm5399639wrl.18.2023.03.18.17.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 17:20:19 -0700 (PDT)
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
Subject: [PATCH 3/4] fs/proc/kcore: convert read_kcore() to read_kcore_iter()
Date:   Sun, 19 Mar 2023 00:20:11 +0000
Message-Id: <32f8fad50500d0cd0927a66638c5890533725d30.1679183626.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679183626.git.lstoakes@gmail.com>
References: <cover.1679183626.git.lstoakes@gmail.com>
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

