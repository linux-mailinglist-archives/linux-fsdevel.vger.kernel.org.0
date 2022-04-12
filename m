Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55C44FE989
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Apr 2022 22:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiDLUnP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Apr 2022 16:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiDLUnB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Apr 2022 16:43:01 -0400
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16778AC939
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Apr 2022 13:37:44 -0700 (PDT)
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-2eb7d137101so378157b3.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Apr 2022 13:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=WxuM56vp7eyey8vt1AZa+KldYkNrgkjPuC+4UbMDXgc=;
        b=rIM9EOW8GOu9cyGO8TXJ6h03VJygSCKXO8crDJqnskQH89h0ZkNfJ9QcigR3yBGwJg
         qIZIakU+ukGgbzbtBtrcJRatlgtr2WsuT1uhRYMkDZoB5wk0eninAo43ymkRPOkirNrq
         /816AqwD33qIzqfBV4wacqsGUAdSBGLoiJdn++k8j9aJAvNiMRne7dHD0R17EQukclon
         jCkxn4wbNTcNTRMRaVaA+0YjqUxB72PaFAAjiPWKXOSO3MiH1+AQx3jMXyfiGcttDc6b
         hy8JW5fCyciu4xUl/9HYYP0ybCeWnGKSjYBNlj56ErlhIeelassl5VxG2u3/aJIXAJ0J
         q/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=WxuM56vp7eyey8vt1AZa+KldYkNrgkjPuC+4UbMDXgc=;
        b=isn5WR/yKXThNKkANWLvnJdnWIP/hxMDFR5dAf4UYQ/3InM8q/nM+3IRP36hyoDzwA
         6/r8nc/O9rQB4DLm5x1/87jZZFQ6Tr5tYIUDZdk+Gp1s3SyKMUPkhwPKQpAiprBdVS68
         aRUTH2mVHTSaBt+ZJfljSSc6DKPLsY9ONDvPKcWUR7VSg/ZAUm9BRepqsWZSgyLo+0U3
         J3MA3dz9lVNPxWNO4zNp3AJpXEGOU7ADyPTg9ZOGZ/ODozzASDBswolv5pPiMz3jj4NI
         +mgGfr8hZHSViE8RM4/DL58wLsOg8hCFJEKwCPXFKUzHtmMNg0XQDRXhj76Se2tcj5x0
         4YkA==
X-Gm-Message-State: AOAM5321vFyhB1fMtBoJ9OoGdSnOsCE1xMnzSJvXtvAFpZSfl2TKzYIH
        91BlHPv/gTGoGZ2J7HRBvdC0w5MteqRLaI0cNU+h
X-Google-Smtp-Source: ABdhPJwN1rKyVp/tc0fMg/HjGUO+kQyygAHoYo6COvoV6GzliqlsiWADXi0U2ptDq7ByWupmrnrJxjn86JmOaUcWFqlS
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:8927:f9ed:8b14:ddae])
 (user=axelrasmussen job=sendgmr) by 2002:a25:9391:0:b0:641:3842:c5c4 with
 SMTP id a17-20020a259391000000b006413842c5c4mr11278242ybm.323.1649795388862;
 Tue, 12 Apr 2022 13:29:48 -0700 (PDT)
Date:   Tue, 12 Apr 2022 13:29:41 -0700
Message-Id: <20220412202942.386981-1-axelrasmussen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH 1/2] userfaultfd: add /dev/userfaultfd for fine grained access control
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <namit@vmware.com>, Peter Xu <peterx@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Historically, it has been shown that intercepting kernel faults with
userfaultfd (thereby forcing the kernel to wait for an arbitrary amount
of time) can be exploited, or at least can make some kinds of exploits
easier. So, in 37cd0575b8 "userfaultfd: add UFFD_USER_MODE_ONLY" we
changed things so, in order for kernel faults to be handled by
userfaultfd, either the process needs CAP_SYS_PTRACE, or this sysctl
must be configured so that any unprivileged user can do it.

In a typical implementation of a hypervisor with live migration (take
QEMU/KVM as one such example), we do indeed need to be able to handle
kernel faults. But, both options above are less than ideal:

- Toggling the sysctl increases attack surface by allowing any
  unprivileged user to do it.

- Granting the live migration process CAP_SYS_PTRACE gives it this
  ability, but *also* the ability to "observe and control the
  execution of another process [...], and examine and change [its]
  memory and registers" (from ptrace(2)). This isn't something we need
  or want to be able to do, so granting this permission violates the
  "principle of least privilege".

This is all a long winded way to say: we want a more fine-grained way to
grant access to userfaultfd, without granting other additional
permissions at the same time.

To achieve this, add a /dev/userfaultfd misc device. This device
provides an alternative to the userfaultfd(2) syscall for the creation
of new userfaultfds. The idea is, any userfaultfds created this way will
be able to handle kernel faults, without the caller having any special
capabilities. Access to this mechanism is instead restricted using e.g.
standard filesystem permissions.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 fs/userfaultfd.c                 | 79 ++++++++++++++++++++++++++------
 include/uapi/linux/userfaultfd.h |  4 ++
 2 files changed, 69 insertions(+), 14 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index aa0c47cb0d16..16d7573ab41a 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -29,6 +29,7 @@
 #include <linux/ioctl.h>
 #include <linux/security.h>
 #include <linux/hugetlb.h>
+#include <linux/miscdevice.h>
 
 int sysctl_unprivileged_userfaultfd __read_mostly;
 
@@ -65,6 +66,8 @@ struct userfaultfd_ctx {
 	unsigned int flags;
 	/* features requested from the userspace */
 	unsigned int features;
+	/* whether or not to handle kernel faults */
+	bool handle_kernel_faults;
 	/* released */
 	bool released;
 	/* memory mappings are changing because of non-cooperative event */
@@ -410,13 +413,8 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 
 	if (ctx->features & UFFD_FEATURE_SIGBUS)
 		goto out;
-	if ((vmf->flags & FAULT_FLAG_USER) == 0 &&
-	    ctx->flags & UFFD_USER_MODE_ONLY) {
-		printk_once(KERN_WARNING "uffd: Set unprivileged_userfaultfd "
-			"sysctl knob to 1 if kernel faults must be handled "
-			"without obtaining CAP_SYS_PTRACE capability\n");
+	if (!(vmf->flags & FAULT_FLAG_USER) && !ctx->handle_kernel_faults)
 		goto out;
-	}
 
 	/*
 	 * If it's already released don't get it. This avoids to loop
@@ -2064,19 +2062,33 @@ static void init_once_userfaultfd_ctx(void *mem)
 	seqcount_spinlock_init(&ctx->refile_seq, &ctx->fault_pending_wqh.lock);
 }
 
-SYSCALL_DEFINE1(userfaultfd, int, flags)
+static inline bool userfaultfd_allowed(bool is_syscall, int flags)
+{
+	bool kernel_faults = !(flags & UFFD_USER_MODE_ONLY);
+	bool allow_unprivileged = sysctl_unprivileged_userfaultfd;
+
+	/* userfaultfd(2) access is controlled by sysctl + capability. */
+	if (is_syscall && kernel_faults) {
+		if (!allow_unprivileged && !capable(CAP_SYS_PTRACE))
+			return false;
+	}
+
+	/*
+	 * For /dev/userfaultfd, access is to be controlled using e.g.
+	 * permissions on the device node. We assume this is correctly
+	 * configured by userspace, so we simply allow access here.
+	 */
+
+	return true;
+}
+
+static int new_userfaultfd(bool is_syscall, int flags)
 {
 	struct userfaultfd_ctx *ctx;
 	int fd;
 
-	if (!sysctl_unprivileged_userfaultfd &&
-	    (flags & UFFD_USER_MODE_ONLY) == 0 &&
-	    !capable(CAP_SYS_PTRACE)) {
-		printk_once(KERN_WARNING "uffd: Set unprivileged_userfaultfd "
-			"sysctl knob to 1 if kernel faults must be handled "
-			"without obtaining CAP_SYS_PTRACE capability\n");
+	if (!userfaultfd_allowed(is_syscall, flags))
 		return -EPERM;
-	}
 
 	BUG_ON(!current->mm);
 
@@ -2095,6 +2107,11 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 	refcount_set(&ctx->refcount, 1);
 	ctx->flags = flags;
 	ctx->features = 0;
+	/*
+	 * If UFFD_USER_MODE_ONLY is not set, then userfaultfd_allowed() above
+	 * decided that kernel faults were allowed and should be handled.
+	 */
+	ctx->handle_kernel_faults = !(flags & UFFD_USER_MODE_ONLY);
 	ctx->released = false;
 	atomic_set(&ctx->mmap_changing, 0);
 	ctx->mm = current->mm;
@@ -2110,8 +2127,42 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 	return fd;
 }
 
+SYSCALL_DEFINE1(userfaultfd, int, flags)
+{
+	return new_userfaultfd(true, flags);
+}
+
+static int userfaultfd_dev_open(struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+static long userfaultfd_dev_ioctl(struct file *file, unsigned int cmd, unsigned long flags)
+{
+	if (cmd != USERFAULTFD_IOC_NEW)
+		return -EINVAL;
+
+	return new_userfaultfd(false, flags);
+}
+
+static const struct file_operations userfaultfd_dev_fops = {
+	.open = userfaultfd_dev_open,
+	.unlocked_ioctl = userfaultfd_dev_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
+	.owner = THIS_MODULE,
+	.llseek = noop_llseek,
+};
+
+static struct miscdevice userfaultfd_misc = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = "userfaultfd",
+	.fops = &userfaultfd_dev_fops
+};
+
 static int __init userfaultfd_init(void)
 {
+	WARN_ON(misc_register(&userfaultfd_misc));
+
 	userfaultfd_ctx_cachep = kmem_cache_create("userfaultfd_ctx_cache",
 						sizeof(struct userfaultfd_ctx),
 						0,
diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
index ef739054cb1c..032a35b3bbd2 100644
--- a/include/uapi/linux/userfaultfd.h
+++ b/include/uapi/linux/userfaultfd.h
@@ -12,6 +12,10 @@
 
 #include <linux/types.h>
 
+/* ioctls for /dev/userfaultfd */
+#define USERFAULTFD_IOC 0xAA
+#define USERFAULTFD_IOC_NEW _IOWR(USERFAULTFD_IOC, 0x00, int)
+
 /*
  * If the UFFDIO_API is upgraded someday, the UFFDIO_UNREGISTER and
  * UFFDIO_WAKE ioctls should be defined as _IOW and not as _IOR.  In
-- 
2.35.1.1178.g4f1659d476-goog

