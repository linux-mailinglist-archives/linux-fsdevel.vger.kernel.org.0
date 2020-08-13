Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C20243C95
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 17:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgHMPeE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 11:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbgHMPeA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 11:34:00 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED27C061757
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 08:33:59 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id w2so2794440qvh.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 08:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ezijkfx0Y5DorrGX8/YWq9ouXTyf+zW2VdpyaeIcFao=;
        b=qDYeaWFLKTNgjRfAfZohibiECyItuS3oMZUnILoFBX8iTUtxUnigrWwfg2amqlh5KM
         kyfL1zNnz0tm8K1XD90feWYeZFRXu09RcA4Glp56T2BpFM6rE75iB+p8z+kqC2IwHAA8
         2+aDzbP6gT6ToL8EtuItNlng3DgdUF8kV3P8NoyU66zmJj6zXfQWZHJstKBRRMKYW8vj
         xlDq2+7WStOHiOH6xR5/vGwSVl3oPItrOlGaHSxtTM/2IXQeheUoKld1ob/TBI8NpHAk
         eZ5AZmTI4VK2tKpbC3SzihCLuKMJ2v2n+3JHvW+ofUbIjJxli3KGIHYQnWaOaJqWwpC1
         xjgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ezijkfx0Y5DorrGX8/YWq9ouXTyf+zW2VdpyaeIcFao=;
        b=m83ghntLW9U3f796i5TmACT5dW0R+UXKXGaoxyH6nUobBjnz0vuQ7MVaiBtZzW9lDJ
         hlLGKcY0q5aePOiP+/QMeW/vxy7nfjweCWN2407l19mMw4KjAiQVi0L1qQl+ekJuBYXG
         RiaxPaV9sjHrfPwiaEb+YbISKXHuyXoAAZLCFfvjT3XYsqPKsQTnTbS5ECUlPGv88hXJ
         o17Pcq1XOspJW2fOI0mt2H/HoHgK6BtzzywJzIUwHfh8ZHN9bQ4YbyiM7kcSO15Qm6t7
         h55OU+K2NWwAMcHjFyXD6WGKDS0cMuxlbXDOsPcYxcRy1jeBBR5w0rmw8xMj08CoZ1bZ
         yBwQ==
X-Gm-Message-State: AOAM530+r8r3/lhCkXvvnQf3Gid3zYukFL0UKPbJAoUrsL0MYiG0Kr2b
        tR3K2Fse5WhDj/6CepILTm+epg==
X-Google-Smtp-Source: ABdhPJzW2g4O8d3zoBeCYopEB+n7a4zLaABB0qlEdfWfB/LmLR6LYK/+D2eWkuiuFTTIausl+jr1Mw==
X-Received: by 2002:ad4:4806:: with SMTP id g6mr5112072qvy.39.1597332839042;
        Thu, 13 Aug 2020 08:33:59 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l66sm6861647qte.48.2020.08.13.08.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 08:33:58 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     hch@lst.de, viro@ZenIV.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@fb.com,
        willy@infradead.org
Subject: [PATCH][v2] proc: use vmalloc for our kernel buffer
Date:   Thu, 13 Aug 2020 11:33:56 -0400
Message-Id: <20200813153356.857625-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200813145305.805730-1-josef@toxicpanda.com>
References: <20200813145305.805730-1-josef@toxicpanda.com>
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
v1->v2:
- Make vmemdup_user_nul actually do the right thing...sorry about that.

 fs/proc/proc_sysctl.c  |  6 +++---
 include/linux/string.h |  1 +
 mm/util.c              | 27 +++++++++++++++++++++++++++
 3 files changed, 31 insertions(+), 3 deletions(-)

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
index 5ef378a2a038..9d0ad7aafc27 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -208,6 +208,33 @@ void *vmemdup_user(const void __user *src, size_t len)
 }
 EXPORT_SYMBOL(vmemdup_user);
 
+/**
+ * vmemdup_user_nul - duplicate memory region from user space and NUL-terminate
+ *
+ * @src: source address in user space
+ * @len: number of bytes to copy
+ *
+ * Return: an ERR_PTR() on failure.  Result may be not
+ * physically contiguous.  Use kvfree() to free.
+ */
+void *vmemdup_user_nul(const void __user *src, size_t len)
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
+EXPORT_SYMBOL(vmemdup_user_nul);
+
 /**
  * strndup_user - duplicate an existing string from user space
  * @s: The string to duplicate
-- 
2.24.1

