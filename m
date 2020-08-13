Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F70C243D10
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 18:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgHMQOJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 12:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbgHMQOF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 12:14:05 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0C3C061383
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 09:14:04 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 62so5650139qkj.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 09:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HhEB3Mg3nvNWsemF4sD82cye0hI4+b2TW/nx8QC3dx0=;
        b=b4AurNeJIAF2fYTZ/ZBi+tFFzfvW4WNkMgFGaoCNkT8rcS2qtkwPUViVmJRR3p0cW+
         8gc8tXKn4ECvrujqaUFyUNJsldb7AjFHbW/tVLzgz5S2+JU49GLRR1/Qa36Q9RFbpCd8
         rvMV1AEhm3MNDTVGg4s0M8DQkARYmyrXwfy+h6Fq14iKPDQ82G43zfXgO6J7Ko0qlUGW
         GJmyhHo0zo1ZwP0Desd+dkJ3VTGY2X2ANjvEmSW/BThivX1xDHhF2ZKbiqjKEvt7ndXQ
         sjB3BZUvA5vLy98d+H2F3ZxxW7spaurnG//3cR9tUwCgMPQPhPlT3Ocf/s84w1gYwhQJ
         azSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HhEB3Mg3nvNWsemF4sD82cye0hI4+b2TW/nx8QC3dx0=;
        b=cdtqh0wbozQDn6roBo8Ku9XoYP1VhEqsJzGLeZc3DgRHoiw50smJbsmIIUCERPUGw+
         ozoBj2Pbp0hb8zdmWo2dnDi+fvplZCU+zwDxiqJoD6vQFg0e5OWTAYK1/DNlC5t+6Yj9
         jmEtC4mMqhiUyPo/Y/jnoRjHBMcPfMQcE9P4PhY/ZJRTDXiA1+CQ9QqAQT1OTTUxR5Il
         7BfYi/UyZ7+zeG1pcXOrbeb4Mp6gDjrJj8y6onrk2f4Reg4Pr6bvx4pydxGnXjEnFAzY
         5gZ3brWNm2M4RpZqCLf4IilsysJkGgJfvMBTM9MibWWFUL57FELJtR0bKJaH1i8M2LpL
         ifvQ==
X-Gm-Message-State: AOAM531xye9wy0Xj7AnbTxuMdemHI59XTLGx1m8gH1uD/3hFT1VL7q/q
        3pfGSeIBakt8Ys9ppvUKL8+rJA==
X-Google-Smtp-Source: ABdhPJxv46ylbFnEPWIDY/PPJLa+al7athcnoRZw3Za0NiEI76P7UhaG4zQ6XuXqZAUt+UT2tpc/mA==
X-Received: by 2002:a05:620a:128e:: with SMTP id w14mr4989267qki.97.1597335241714;
        Thu, 13 Aug 2020 09:14:01 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y3sm7276053qtj.55.2020.08.13.09.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 09:14:00 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     hch@lst.de, viro@ZenIV.linux.org.uk, willy@infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 1/2][v3] proc: use vmalloc for our kernel buffer
Date:   Thu, 13 Aug 2020 12:13:58 -0400
Message-Id: <20200813161359.904275-1-josef@toxicpanda.com>
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
v2->v3:
- Rename vmemdup_user_nul to kvmemdup_user_nul.
v1->v2:
- Make vmemdup_user_nul actually do the right thing...sorry about that.

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

