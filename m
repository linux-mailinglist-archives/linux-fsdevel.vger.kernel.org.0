Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE206C6493
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 11:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjCWKPa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 06:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjCWKP1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 06:15:27 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4CB1B2DF;
        Thu, 23 Mar 2023 03:15:26 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id m2so19840785wrh.6;
        Thu, 23 Mar 2023 03:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679566525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnqbASwlTwT+hpjobkOVo9MU5RGxoqqRsLFO5z2uP7A=;
        b=ay5smV8H77AUMTTLy9JbPLC9H0FvAA6po1YwW88plRseeVZNzrO/yWXbWoeqBe73BV
         EPgoT4A9/R/wlPu2/DDT/sXT4SvPJX01j/7S2NXxmlxFXfMomXZaZHpKhswlSSHQAlwn
         YGU9oMUiADoHyd7ZKlL/C+RRgIp5YyBRmuDMkS8V6pWCvANVchSSxW2H3WGP45Ou1g4F
         5LowAeuegB7b2wwRVSLyP6b5V+tJKxRo43A9f1YG5Pig2CU0CsXh/kbSLJ1arlLoPMAR
         UlnBALoZjxX2Emv0VI1hYbblmrbcykLwIR8Hj8xPwSWirkoP5Xg6oe7ivaw2MaP++1RV
         gW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679566525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CnqbASwlTwT+hpjobkOVo9MU5RGxoqqRsLFO5z2uP7A=;
        b=gLyvxfJjOeOx1EzI13rvmtSkvZJ0Ypk6gR8c3g10h9csBKr0WPFjwI7CIm+SGg3n/i
         0gaZArp/oGKHGGoB3MGiLvvAhx9PJli+h9+ATLltsKB4sW6mGchNOk2vorBGfuxLgv3F
         5MBX54xJQIJTCMuAU/x5s3OOPVRGGqEmkx0ptp2SNnx2Y4THGejfhjVs/GdGA3jQlU4m
         vL/XKkHhjLYexOl21SOlFkxDwqadcL5gj0/vV+g+UGUtp389U37RrrlBXDKOMEwepVYD
         tn5Eg1p+ybxpMMAVxPzta/4kPXO0ppAdDDti/v+brqvxgpJnMYIIc62pkJAHKFXnRJ+y
         MYOg==
X-Gm-Message-State: AAQBX9dPJqJJa4ILJxdBT30IaKXrfH52ZagqegYp33/NBrJiNi2Kc0qB
        zkFjJb12mn747qxDHP83Te0=
X-Google-Smtp-Source: AKy350YAiKXXkl0iQoEpKbs8mnEe9sJULjjf91EDkzy28H0cXCyjz2M7MyL7zCDYF1/QYu3rmhjIKA==
X-Received: by 2002:adf:fac2:0:b0:2cf:f061:8134 with SMTP id a2-20020adffac2000000b002cff0618134mr2124557wrs.26.1679566525016;
        Thu, 23 Mar 2023 03:15:25 -0700 (PDT)
Received: from lucifer.home (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.googlemail.com with ESMTPSA id f18-20020a05600c155200b003ede2c59a54sm1416952wmg.37.2023.03.23.03.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 03:15:24 -0700 (PDT)
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
Subject: [PATCH v8 2/4] fs/proc/kcore: convert read_kcore() to read_kcore_iter()
Date:   Thu, 23 Mar 2023 10:15:17 +0000
Message-Id: <ebe12c8d70eebd71f487d80095605f3ad0d1489c.1679566220.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679566220.git.lstoakes@gmail.com>
References: <cover.1679566220.git.lstoakes@gmail.com>
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

