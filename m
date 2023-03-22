Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A116C4EAD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 15:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjCVO4U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 10:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjCVOzz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:55:55 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0502410AAA;
        Wed, 22 Mar 2023 07:55:37 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id o32so5337843wms.1;
        Wed, 22 Mar 2023 07:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679496935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnqbASwlTwT+hpjobkOVo9MU5RGxoqqRsLFO5z2uP7A=;
        b=VYs6ugG87mfTKeYAZszhJ4zHVIrm5oSCM3SiOaM9Rb9+Z4kqLzTtkkPo8FkMnjaQCi
         Au5clGPac1dlx+ijIXPxu1kRuLlDQGOIGWa8EaA80xeGft1ma8F76vHwldlxfSFH771D
         WrXTC3+cKYn5NAe7KlQKnRR/gAsZUgXpQRW+/c4MTlEJInNTG7CleO8s1pxN2sBuyD1N
         IIYWjMBNLIvRvfR4qduXhFYFHEKbVgFkPDvyGuEOozXYaBzCj51XyHEhZhfq4n5Avnqe
         217YR8GkTStFxKUVA9XWDGV9JiUUt9MLAhCTJQfbektBiHj2p1bZYldccVgn1o6LyIGG
         LWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679496935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CnqbASwlTwT+hpjobkOVo9MU5RGxoqqRsLFO5z2uP7A=;
        b=uD4tx0z0r0bE8O253Ybvi9hibYF6wMjgQd7OaTuB36eHEauIrQgUxr9pPW6MbYipSu
         0D93coMneMg4zcF+XKKkyGJSox+rZ+se0Ic8WwETYCqztkaeSYwcJIKFV8DvoHHvqCfU
         qbrmT3PDv3QpJiVHaNADDkg880qUVbhSBtov00h31JQgMlKPjlSd5GNzRlRzGZLT3jsn
         qzA8F/n5+J7wassztit+WyOCokOIiw5bHAl+766sY/gltBM8FK6f+r2Z2BggY+LXm+ua
         +vsiT7EOSeExKBPIfare/pgMf8sFr9EuPe/Lw82CPUqd9EF/2B4+9APNVbpwLCX9JsWs
         c4nQ==
X-Gm-Message-State: AO0yUKVgDHOe6s6Oqee39X7PKqDfTh5rmF0voQ0aSyjO9kDiQ3vfvbR5
        M5aSE7tTl3EfBxNlWSyZvx0=
X-Google-Smtp-Source: AK7set+fXeYguHSdM/ECTto2wDq7Mo4z+CYXsMQV4PwwqbZd6DCt+5jTvUcB/xmS9G1k42Z3No87WA==
X-Received: by 2002:a7b:c396:0:b0:3ee:19b4:a2e6 with SMTP id s22-20020a7bc396000000b003ee19b4a2e6mr5695693wmj.19.1679496935292;
        Wed, 22 Mar 2023 07:55:35 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id n23-20020a7bcbd7000000b003ed243222adsm16812246wmi.42.2023.03.22.07.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 07:55:34 -0700 (PDT)
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
Subject: [PATCH v6 2/4] fs/proc/kcore: convert read_kcore() to read_kcore_iter()
Date:   Wed, 22 Mar 2023 14:55:26 +0000
Message-Id: <ebe12c8d70eebd71f487d80095605f3ad0d1489c.1679496827.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679496827.git.lstoakes@gmail.com>
References: <cover.1679496827.git.lstoakes@gmail.com>
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

For the time being we still use a bounce buffer for vread(), however in the
next patch we will convert this to interact directly with the iterator and
eliminate the bounce buffer altogether.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/kcore.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 556f310d6aa4..08b795fd80b4 100644
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
+	loff_t *fpos = &iocb->ki_pos;
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
 
@@ -356,12 +360,11 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 		};
 
 		tsz = min_t(size_t, buflen, sizeof(struct elfhdr) - *fpos);
-		if (copy_to_user(buffer, (char *)&ehdr + *fpos, tsz)) {
+		if (copy_to_iter((char *)&ehdr + *fpos, tsz, iter) != tsz) {
 			ret = -EFAULT;
 			goto out;
 		}
 
-		buffer += tsz;
 		buflen -= tsz;
 		*fpos += tsz;
 	}
@@ -398,15 +401,14 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 		}
 
 		tsz = min_t(size_t, buflen, phdrs_offset + phdrs_len - *fpos);
-		if (copy_to_user(buffer, (char *)phdrs + *fpos - phdrs_offset,
-				 tsz)) {
+		if (copy_to_iter((char *)phdrs + *fpos - phdrs_offset, tsz,
+				 iter) != tsz) {
 			kfree(phdrs);
 			ret = -EFAULT;
 			goto out;
 		}
 		kfree(phdrs);
 
-		buffer += tsz;
 		buflen -= tsz;
 		*fpos += tsz;
 	}
@@ -448,14 +450,13 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 				  min(vmcoreinfo_size, notes_len - i));
 
 		tsz = min_t(size_t, buflen, notes_offset + notes_len - *fpos);
-		if (copy_to_user(buffer, notes + *fpos - notes_offset, tsz)) {
+		if (copy_to_iter(notes + *fpos - notes_offset, tsz, iter) != tsz) {
 			kfree(notes);
 			ret = -EFAULT;
 			goto out;
 		}
 		kfree(notes);
 
-		buffer += tsz;
 		buflen -= tsz;
 		*fpos += tsz;
 	}
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
@@ -541,17 +542,17 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
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
@@ -559,7 +560,6 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 skip:
 		buflen -= tsz;
 		*fpos += tsz;
-		buffer += tsz;
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

