Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81DC50C356
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Apr 2022 01:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbiDVWi3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 18:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233885AbiDVWhu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:37:50 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A80B284D82
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 14:29:56 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2f4dee8688cso43169087b3.16
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 14:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZKwYZFMlPmL6KMhQQz8m//PR2YxeSx2kvEK7QsVigJI=;
        b=csJYqjI7+4H3NJVJax9NGS3pNlt2RUYB3+3McYgDnf45op0d8iUq0yCVP4z+6JvUFf
         2Cpb+TtSM43LXHqZExuKefroEz7gh03gyTWpMXuqRZSxtuP2YUeMnuRu69CM4h9NHqu1
         Rt1m64uZho/RVKCFiWhSXEHProJQP+tXVbfJDgG/1mE9kiZDWXOLeAbrnJgOQ5uYKaBq
         Baf2Z8XNif2KvlAHnovD2kwKU8KrPFdCWw6E/ubPmigUIOAAwqklhC5yORD60kwFj8M7
         dV8w1yeJbu4JN5R08puEouNqPqaZwWoAvF3Gdbt5JP6S2N5c4GIRczR2DvpbQeHh3uEK
         7FCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZKwYZFMlPmL6KMhQQz8m//PR2YxeSx2kvEK7QsVigJI=;
        b=ZL+JbUFl/mf+IlWFgrNj0RJusX06j6NUZNcAzcnQYOO+3CMnowMTnOIUNh+OC5IDN0
         oFJoUaHMbGiRycoOCD7VKFJHD4juj2j5XtLJE2h9cFbX5fsoAn0gmvPGAm5mU/2KZdTM
         rKmYSaPy+9ibeKDYA3JdrniIH7mqtrC1uyiUIUx6NfkPpn8q2y2PbhcP12tVj00SqWDw
         N2icVj4VWWUWGRBGx891Fp8SuM2UiOdtdhXuhsF/MFzNMNmRk1dHIm1Ce5VKuwKqafhf
         5t3pNobBykWq5A+DFa6gvIAOwClHwJXSYN1ZM+e0fX0ocISfZvxOBAMSGzlyLFTVn6WK
         mjHA==
X-Gm-Message-State: AOAM532+n1H2Cdw2Rpmc6fXoPmTbboER3AhCOOvPqkJnu4JY+E/0a8Gr
        M7MwNDcsI5BSzUfJC4SXKL8UPLCf1SMVzuK3E4p1
X-Google-Smtp-Source: ABdhPJwxCsTz9OxLMDOgPGwJ76n2p6bPU/yWKc6iqu2BypRG7Slj3og+uNJnovkB/PwFjYqyrErsxCwHfIK4qfTFl31r
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:7ba6:20ac:a8f7:1dbd])
 (user=axelrasmussen job=sendgmr) by 2002:a25:8382:0:b0:63d:6201:fa73 with
 SMTP id t2-20020a258382000000b0063d6201fa73mr6272316ybk.55.1650662995479;
 Fri, 22 Apr 2022 14:29:55 -0700 (PDT)
Date:   Fri, 22 Apr 2022 14:29:41 -0700
In-Reply-To: <20220422212945.2227722-1-axelrasmussen@google.com>
Message-Id: <20220422212945.2227722-3-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20220422212945.2227722-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v2 2/6] userfaultfd: add /dev/userfaultfd for fine grained
 access control
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Charan Teja Reddy <charante@codeaurora.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, zhangyi <yi.zhang@huawei.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
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
2.36.0.rc2.479.g8af0fa9b8e-goog

