Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7686A59A73E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Aug 2022 23:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352156AbiHSUwx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Aug 2022 16:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352034AbiHSUwc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Aug 2022 16:52:32 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C0910D583
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Aug 2022 13:52:15 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-33580e26058so94452227b3.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Aug 2022 13:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=Idvj8+mYb4IUUixNLqVBka+slWZ3wfKGTMlkwxnvXbY=;
        b=RTR1sKOG3HS4oRmW+To22+xxQ9cPl1t5H7t3If9jYPgGFCxKjrjIRLLoyJf0Zqg9M3
         A68g/+ubMGpKBNXnLo6zhHo/1eHFuYJrnYeyg/B+LL/j3oRRKJMIs5DFXTmcwbaJrwWd
         NTpoSvxhWDlytbbQ9xrbhKWMpDVCd3Oob9QI+i3wrCh1GopvhF7R6B0QLj/RqxrAs58J
         8q4wfbQX1lJcncPCvsneCOALWmwYNq5jrsRjdSvOTXXOb4hM2qdEwiCb1k5qZQlSeHbc
         fbntD2eqsTowh9hXEYMRTZC2dYPzaKx7C0TBU1DmNY2A2XmhlIUs9xienW1M2adUTMDE
         j/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=Idvj8+mYb4IUUixNLqVBka+slWZ3wfKGTMlkwxnvXbY=;
        b=S2dpRQVAD9eGnM93te0nQhKuzBH7h2UU5wb3kUONpAUYytkTP8RnAJcCtfazbttI4c
         30acHY2KTZ4wPQrRMuPgR8lTLeG6ntSxUsrwIi5F9YSOItoIgQFVH9GJEVL/nWJzCEzm
         C+PLnN/l5hlz10dGOMcH60Mv5L+HPmDbp/FUQF4xU8Y0St7UJx70TDuueRnXOPCl4Elr
         a29IrmUBm+VsTzu2ffpHPzJIAbk8KwVyJ5A/2Kk5NWCc0lPBmvv14E2Vmc5aBzrPJocB
         LxVWg8mfIfyrGS0axIYUiIbqPiuh/KftFk1uP28/lb76E3sLPdH/aUmFzNwCq8mf90xG
         +QmQ==
X-Gm-Message-State: ACgBeo1BzRShbi+NxCyrEgXs/a/vQeBiSyCLQCbaXd3bKzLW1bdeZiue
        vKIe8vd2P7JXJg+wnwQjR1535wYowiZbxdOIV0nm
X-Google-Smtp-Source: AA6agR6EvZXCKnp/iA4CQcQxWJXCi/R8jfuoo5HJrCckmL50W1T2bKUISNLxRbusQZ/m1ZhpIN+ZdYhFaJ8pMV/EVH6B
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2d4:203:baf:4c5:18b:2c4b])
 (user=axelrasmussen job=sendgmr) by 2002:a81:1117:0:b0:336:45a1:221b with
 SMTP id 23-20020a811117000000b0033645a1221bmr9778987ywr.229.1660942335151;
 Fri, 19 Aug 2022 13:52:15 -0700 (PDT)
Date:   Fri, 19 Aug 2022 13:51:58 -0700
In-Reply-To: <20220819205201.658693-1-axelrasmussen@google.com>
Message-Id: <20220819205201.658693-3-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20220819205201.658693-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v7 2/5] userfaultfd: add /dev/userfaultfd for fine grained
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
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
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

Acked-by: Mike Rapoport <rppt@linux.ibm.com>
Acked-by: Nadav Amit <namit@vmware.com>
Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 fs/userfaultfd.c                 | 71 +++++++++++++++++++++++++-------
 include/uapi/linux/userfaultfd.h |  4 ++
 2 files changed, 59 insertions(+), 16 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 1c44bf75f916..03ba23e144ec 100644
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
@@ -2098,8 +2085,60 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
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
+static long userfaultfd_dev_ioctl(struct file *file, unsigned int cmd, unsigned long flags)
+{
+	if (cmd != USERFAULTFD_IOC_NEW)
+		return -EINVAL;
+
+	return new_userfaultfd(flags);
+}
+
+static const struct file_operations userfaultfd_dev_fops = {
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
+	int ret;
+
+	ret = misc_register(&userfaultfd_misc);
+	if (ret)
+		return ret;
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
2.37.1.595.g718a3a8f04-goog

