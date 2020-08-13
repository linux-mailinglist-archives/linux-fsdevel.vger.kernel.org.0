Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F36824403B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 23:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgHMVEV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 17:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgHMVEU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 17:04:20 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E36AC061384
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 14:04:19 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id v22so5490705qtq.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 14:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=iMH/6Zv7UJy3jzK0zhlQaSqjciySOnJZj31o6dSJNp0=;
        b=mGV8LJX7jIXJO2ymUdiXZYijB2e+ZMK7XHGqFN7hn1NZ2MBT5RjyZxQ4WXOFe8+WHt
         Xz9wiSNl3SFee2XcCbpPp9fI5dBds2L6mLNiPdRlIC91M8nRqvCs61IsMvlLN+YMjVaf
         5YaEE6xqNbtNUwlNEPvkZhN5BdP1xst9DntCQnwxyEUcy/9Q68+WIuOwOFo5uSzaZiH/
         IgJ0eVPykHOab6o9Sqar+fIbd39/hCv3svVU7f4vYX1pF6e5fDbwU0QwnE/eaPYBMqKt
         g3cSqX7vD6KzXI1mQWRn1Gu/KbFdmbES2SJSXpSmPMezhYxCItPKwkg8bD9oDwYi+Rh3
         ACDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iMH/6Zv7UJy3jzK0zhlQaSqjciySOnJZj31o6dSJNp0=;
        b=l9mPu72eIY+MmFlpjNdvD/0C6Q7SyQK27lguzaF4ngcBTv5BLZUJQhvG9c/Jwv0dzj
         3RXTZ5Q405MFkULvT6rpixF30X7CR+v+qIdiCwjXokL6tpVyqt0r40jdsv9wZPla4DDh
         c8gMPHPPMSLpg43OkutdXxWzbLrEFp8ud4UQzzStmZ/S1bvYbsvubZatbTba9peXDNoM
         qdzQ59/5ewcLuJgOXoFQOX3hExCVMBPSMALbPezlrYMMTERlxqZTJTI7k9f0bhTrqF6n
         aqvZM8/YWfTiC1clOXJbAp91RtmjOWo39hdyPqkOIJey3LMcZMnox0eNzkVyuOmTL3ka
         TdOw==
X-Gm-Message-State: AOAM5304EEtEYsVSuLlwkSjEECVE92j4/pkEDH5VlGf15wGDJOduu3Sm
        YrYyloCG/g82RkbHqwD4pk5orA==
X-Google-Smtp-Source: ABdhPJyPNFgx549j0l3N/LKNneKVgw/mWcfHpscrbRpHjpSU9ncv/HznYP1aP5fwY+EgXkHbRfttEg==
X-Received: by 2002:ac8:6952:: with SMTP id n18mr2620247qtr.27.1597352658507;
        Thu, 13 Aug 2020 14:04:18 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q68sm6391579qke.123.2020.08.13.14.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 14:04:17 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     hch@lst.de, viro@ZenIV.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        kernel-team@fb.com
Subject: [PATCH 1/6] proc: use vmalloc for our kernel buffer
Date:   Thu, 13 Aug 2020 17:04:06 -0400
Message-Id: <20200813210411.905010-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200813210411.905010-1-josef@toxicpanda.com>
References: <20200813210411.905010-1-josef@toxicpanda.com>
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
 mm/util.c              | 27 +++++++++++++++++++++++++++
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 6c1166ccdaea..8e19bad83b45 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -571,13 +571,13 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
 		goto out;
 
 	if (write) {
-		kbuf = memdup_user_nul(ubuf, count);
+		kbuf = kvmemdup_user_nul(ubuf, count);
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
index 9b7a0632e87a..21bb6d3d88c4 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -12,6 +12,7 @@
 extern char *strndup_user(const char __user *, long);
 extern void *memdup_user(const void __user *, size_t);
 extern void *vmemdup_user(const void __user *, size_t);
+extern void *kvmemdup_user_nul(const void __user *, size_t);
 extern void *memdup_user_nul(const void __user *, size_t);
 
 /*
diff --git a/mm/util.c b/mm/util.c
index 5ef378a2a038..cf454d57d3e2 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -208,6 +208,33 @@ void *vmemdup_user(const void __user *src, size_t len)
 }
 EXPORT_SYMBOL(vmemdup_user);
 
+/**
+ * kvmemdup_user_nul - duplicate memory region from user space and NUL-terminate
+ *
+ * @src: source address in user space
+ * @len: number of bytes to copy
+ *
+ * Return: an ERR_PTR() on failure.  Result may be not
+ * physically contiguous.  Use kvfree() to free.
+ */
+void *kvmemdup_user_nul(const void __user *src, size_t len)
+{
+	char *p;
+
+	p = kvmalloc(len + 1, GFP_USER);
+	if (!p)
+		return ERR_PTR(-ENOMEM);
+
+	if (copy_from_user(p, src, len)) {
+		kvfree(p);
+		return ERR_PTR(-EFAULT);
+	}
+	p[len] = '\0';
+
+	return p;
+}
+EXPORT_SYMBOL(kvmemdup_user_nul);
+
 /**
  * strndup_user - duplicate an existing string from user space
  * @s: The string to duplicate
-- 
2.24.1

