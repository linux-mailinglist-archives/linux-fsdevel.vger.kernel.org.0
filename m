Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D003243BF4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 16:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgHMOxK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 10:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgHMOxK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 10:53:10 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A6CC061383
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 07:53:09 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id o2so2739205qvk.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 07:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QuYyyEUf06CmnNYAz7kwB5OeYF/6966Caycqxe7vEQ0=;
        b=OU0ZUnoLeM1DwRoOITnt86qC2+PnWCy+k9kfNjiMlfeaWL7l+d4UxDzgQAHqy3dBQD
         hovu5kZyylIbQoPzZ5FbnD4BgRo10pRkjiN/X6IckpchwJ3ILFXxJXBybLaHdEtW4+jd
         vbsR3bzIh6eXQ0yE7t88x5wbKq4K0JKg2P+1qMROTgnbaa7V89sx1FJPrxzjzbJEp9rI
         fvNEf9j7zojY4EwizrI3rdhZnLCqcLMk5uYsdIClc9feasQPHkt55dYaf3kWaRAlJvNC
         MUa981mSnEfuc6kaCxX39Yw/l7ugpQnjZGW7QrSyL1bTDXVwNCTPsonJXeqJEZs4zTT8
         l5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QuYyyEUf06CmnNYAz7kwB5OeYF/6966Caycqxe7vEQ0=;
        b=JOJRGtY42uMyRVGjZPBwc8W2bZrcDP4AeLomYelg4I03bb3T+65I1vQeDp/QXFroYP
         AaF3+kY43I4idcB7eMR3BXXSYUJABlODyqPs3cy+/O2RvJcp8b359ruf1+uTzf/Qg0Qe
         wVwK4n2lceTWlmfeHgPVBzt39+cb7ynbAHPXLQl5d1GuRM2kSWVxqLVDBnWRjnWFaMjt
         DhSZ5uMoeEyozkrjVjkcPFiwy/iyemu9ahEdq4emkxxoaHESYPytStova3rzr9Yev5KK
         Edg830TTxkK/rEn+QxQIAKXHJ6rK2Tv4zVjyOocOTaGRbhRlZqyx7LvWXl0kIX8vnO0g
         6dew==
X-Gm-Message-State: AOAM531oB+2+U+JHU2dLrxNuDHDeqOHOsLra5Fm/PS4AwInz8vu1ZDQp
        omAIEqhD+I8+qTnrMVqmN3+u0YhTLDq7Cw==
X-Google-Smtp-Source: ABdhPJwVQph4UB/Lye91a1yKRdFfpibnEOA2suh+gJICEklsFUB5lOQIhhQ3OhNt9t405rUTR0aWNw==
X-Received: by 2002:ad4:4a27:: with SMTP id n7mr5048422qvz.184.1597330387282;
        Thu, 13 Aug 2020 07:53:07 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 9sm6559668qtg.4.2020.08.13.07.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 07:53:06 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     hch@lst.de, viro@ZenIV.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] proc: use vmalloc for our kernel buffer
Date:   Thu, 13 Aug 2020 10:53:05 -0400
Message-Id: <20200813145305.805730-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since

  sysctl: pass kernel pointers to ->proc_handler

we have been pre-allocating a buffer to copy the data from the proc
handlers into, and then copying that to userspace.  The problem is this
just blind kmalloc()'s the buffer size passed in from the read, which in
the case of our 'cat' binary was 64kib.  Order-4 allocations are not
awesome, and since we can potentially allocate up to our maximum order,
use vmalloc for these buffers.

Fixes: 32927393dc1c ("sysctl: pass kernel pointers to ->proc_handler")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/proc/proc_sysctl.c  |  6 +++---
 include/linux/string.h |  1 +
 mm/util.c              | 26 ++++++++++++++++++++++++++
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 6c1166ccdaea..207ac6e6e028 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -571,13 +571,13 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
 		goto out;
 
 	if (write) {
-		kbuf = memdup_user_nul(ubuf, count);
+		kbuf = vmemdup_user_nul(ubuf, count);
 		if (IS_ERR(kbuf)) {
 			error = PTR_ERR(kbuf);
 			goto out;
 		}
 	} else {
-		kbuf = kzalloc(count, GFP_KERNEL);
+		kbuf = kvzalloc(count, GFP_KERNEL);
 		if (!kbuf)
 			goto out;
 	}
@@ -600,7 +600,7 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
 
 	error = count;
 out_free_buf:
-	kfree(kbuf);
+	kvfree(kbuf);
 out:
 	sysctl_head_finish(head);
 
diff --git a/include/linux/string.h b/include/linux/string.h
index 9b7a0632e87a..aee3689fb865 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -12,6 +12,7 @@
 extern char *strndup_user(const char __user *, long);
 extern void *memdup_user(const void __user *, size_t);
 extern void *vmemdup_user(const void __user *, size_t);
+extern void *vmemdup_user_nul(const void __user *, size_t);
 extern void *memdup_user_nul(const void __user *, size_t);
 
 /*
diff --git a/mm/util.c b/mm/util.c
index 5ef378a2a038..4de3b4b0f358 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -208,6 +208,32 @@ void *vmemdup_user(const void __user *src, size_t len)
 }
 EXPORT_SYMBOL(vmemdup_user);
 
+/**
+ * vmemdup_user - duplicate memory region from user space and NUL-terminate
+ *
+ * @src: source address in user space
+ * @len: number of bytes to copy
+ *
+ * Return: an ERR_PTR() on failure.  Result may be not
+ * physically contiguous.  Use kvfree() to free.
+ */
+void *vmemdup_user_nul(const void __user *src, size_t len)
+{
+	void *p;
+
+	p = kvmalloc(len, GFP_USER);
+	if (!p)
+		return ERR_PTR(-ENOMEM);
+
+	if (copy_from_user(p, src, len)) {
+		kvfree(p);
+		return ERR_PTR(-EFAULT);
+	}
+
+	return p;
+}
+EXPORT_SYMBOL(vmemdup_user_nul);
+
 /**
  * strndup_user - duplicate an existing string from user space
  * @s: The string to duplicate
-- 
2.24.1

