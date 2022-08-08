Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1D758CD22
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Aug 2022 19:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244153AbiHHR4i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Aug 2022 13:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244096AbiHHR41 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Aug 2022 13:56:27 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DA517A84
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Aug 2022 10:56:26 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id h67-20020a256c46000000b0067c13f8f9f0so890709ybc.14
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Aug 2022 10:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=CGty+tEr/tk0rC9BCM7jIIeUNQhRK73+QrnZH4Sx+Qo=;
        b=We9ZS1gYNHd0gn622wtkQZkkXLSQ6n5HOJ1HPvcMn6CJe9K8/pj4UiHWzPJVnC0K0B
         KB6L7cVoeu5N6NnW1F34khKpIDrw1mcbvnCwQbMdIk0/CLPLXewvvLqtlmc6IzCHpSE/
         /wIo6gf7S1BI8GxOK3AM7Diz6O0X77W5udYiZtxB6yoW8H43tHL3OIbXi+xHUmk/fLJw
         wBHTxXcUwNocVssKW/evR2A/RbNnH8Az+963jczK31ttLsFTtJZWRHzPAO6FdIvQcfhM
         B97mTxBSxdDrDNhW6dbeGmTnrZ8CS4D+Zo2TwtyPdB/cB3Zf/o3lOB+e5SPgAgx8QKaR
         l8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=CGty+tEr/tk0rC9BCM7jIIeUNQhRK73+QrnZH4Sx+Qo=;
        b=j5xvgNUfx0DUfIJ69sI8ZkwpJeBDgpx2dNyehraZgx3k0tHniYE4txUjm/W/OI5fGA
         RFC82F/UVnLzacGu5MbpIZjKMjTh7brZc8jx+qac2i06cAI/bfB0lNSqiewKTxzCVHsA
         CCX+Qj/9vtxWpf8Uxk8b1UgGTJgEm+UBKJuzr83hnisNNIEowgvUNIIIJ0dZ26wrjdOT
         1gVVXyajrKqRjz+/qS47gFSy002woGXw0vVJRilXJjfLtZRsXU6Ib+Je+vZErDVn3fw4
         jkX8LEbxENohQXPTzR2Z1kF3fZObCh45MlchcGlnzthboFOVxLdXLdjgIXxqXvgcZdLs
         kydA==
X-Gm-Message-State: ACgBeo1xVo6LjTOjiTdPQnxiN7IA8xL23IwCFz8FXDtJFHRfWxrTnryK
        VmCTccONweH5r7diY0YwQPZpcFsed5NluTO9w+m5
X-Google-Smtp-Source: AA6agR429+nQwLS+GTRt3TL8rFi5rkaCzsd+auyC+wUJV5p/vxBojaGA7Fdoexd8LBuTTZhZ7DViwZN1XsYfSYgYIEzl
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2d4:203:7a2a:3bb5:f3a0:3bbc])
 (user=axelrasmussen job=sendgmr) by 2002:a81:7406:0:b0:322:64d1:3035 with
 SMTP id p6-20020a817406000000b0032264d13035mr19673303ywc.279.1659981385704;
 Mon, 08 Aug 2022 10:56:25 -0700 (PDT)
Date:   Mon,  8 Aug 2022 10:56:11 -0700
In-Reply-To: <20220808175614.3885028-1-axelrasmussen@google.com>
Message-Id: <20220808175614.3885028-3-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20220808175614.3885028-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v5 2/5] userfaultfd: add /dev/userfaultfd for fine grained
 access control
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Acked-by: Nadav Amit <namit@vmware.com>
Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 fs/userfaultfd.c                 | 73 +++++++++++++++++++++++++-------
 include/uapi/linux/userfaultfd.h |  4 ++
 2 files changed, 61 insertions(+), 16 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 1c44bf75f916..698e768d5c3d 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -30,6 +30,7 @@
 #include <linux/security.h>
 #include <linux/hugetlb.h>
 #include <linux/swapops.h>
+#include <linux/miscdevice.h>
 
 int sysctl_unprivileged_userfaultfd __read_mostly;
 
@@ -415,13 +416,8 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 
 	if (ctx->features & UFFD_FEATURE_SIGBUS)
 		goto out;
-	if ((vmf->flags & FAULT_FLAG_USER) == 0 &&
-	    ctx->flags & UFFD_USER_MODE_ONLY) {
-		printk_once(KERN_WARNING "uffd: Set unprivileged_userfaultfd "
-			"sysctl knob to 1 if kernel faults must be handled "
-			"without obtaining CAP_SYS_PTRACE capability\n");
+	if (!(vmf->flags & FAULT_FLAG_USER) && (ctx->flags & UFFD_USER_MODE_ONLY))
 		goto out;
-	}
 
 	/*
 	 * If it's already released don't get it. This avoids to loop
@@ -2052,20 +2048,11 @@ static void init_once_userfaultfd_ctx(void *mem)
 	seqcount_spinlock_init(&ctx->refile_seq, &ctx->fault_pending_wqh.lock);
 }
 
-SYSCALL_DEFINE1(userfaultfd, int, flags)
+static int new_userfaultfd(int flags)
 {
 	struct userfaultfd_ctx *ctx;
 	int fd;
 
-	if (!sysctl_unprivileged_userfaultfd &&
-	    (flags & UFFD_USER_MODE_ONLY) == 0 &&
-	    !capable(CAP_SYS_PTRACE)) {
-		printk_once(KERN_WARNING "uffd: Set unprivileged_userfaultfd "
-			"sysctl knob to 1 if kernel faults must be handled "
-			"without obtaining CAP_SYS_PTRACE capability\n");
-		return -EPERM;
-	}
-
 	BUG_ON(!current->mm);
 
 	/* Check the UFFD_* constants for consistency.  */
@@ -2098,8 +2085,62 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 	return fd;
 }
 
+static inline bool userfaultfd_syscall_allowed(int flags)
+{
+	/* Userspace-only page faults are always allowed */
+	if (flags & UFFD_USER_MODE_ONLY)
+		return true;
+
+	/*
+	 * The user is requesting a userfaultfd which can handle kernel faults.
+	 * Privileged users are always allowed to do this.
+	 */
+	if (capable(CAP_SYS_PTRACE))
+		return true;
+
+	/* Otherwise, access to kernel fault handling is sysctl controlled. */
+	return sysctl_unprivileged_userfaultfd;
+}
+
+SYSCALL_DEFINE1(userfaultfd, int, flags)
+{
+	if (!userfaultfd_syscall_allowed(flags))
+		return -EPERM;
+
+	return new_userfaultfd(flags);
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
+	return new_userfaultfd(flags);
+}
+
+static const struct file_operations userfaultfd_dev_fops = {
+	.open = userfaultfd_dev_open,
+	.unlocked_ioctl = userfaultfd_dev_ioctl,
+	.compat_ioctl = userfaultfd_dev_ioctl,
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
index 7d32b1e797fb..005e5e306266 100644
--- a/include/uapi/linux/userfaultfd.h
+++ b/include/uapi/linux/userfaultfd.h
@@ -12,6 +12,10 @@
 
 #include <linux/types.h>
 
+/* ioctls for /dev/userfaultfd */
+#define USERFAULTFD_IOC 0xAA
+#define USERFAULTFD_IOC_NEW _IO(USERFAULTFD_IOC, 0x00)
+
 /*
  * If the UFFDIO_API is upgraded someday, the UFFDIO_UNREGISTER and
  * UFFDIO_WAKE ioctls should be defined as _IOW and not as _IOR.  In
-- 
2.37.1.559.g78731f0fdb-goog

