Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860822BA0C1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 04:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgKTDEU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 22:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgKTDEU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 22:04:20 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72ADC061A04
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2020 19:04:19 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id bn4so6138747qvb.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2020 19:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=S80ppjIa8avRgCLzMtS9uD6gmPO2GY129S5ovczlpcA=;
        b=bn7ilro4cOy+tDQBg0BRd9vDaADZLaBkGp8sycj7nJbZrcIxlJ8zRDBvHRXiSp4/vt
         bCGgK1DJGcSDZjcdWvldVAXk1Kr4M9ydE7q4MBcnvrbaj3SY1Xn3DjskcExrURpmNq/u
         /k9u5/4jdFDvoWSgxZ2b3dJmKDyDIz+KCQ6ri9RfFSySl2P/JzZddjgT6ZDBZYmIJwZj
         ySNIw9IdveLjnuXgBiEIlp0j10K5uwBXgUIhyff9SIXaEBmLNkopb1NZwpYFoVrcOe5I
         VqjQGTivND7CdMI4ftMS3HLMtAfS4yOPIVF/Qu8baAHx6XAhDLquEzfKJT0HkGoDhjEj
         mXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=S80ppjIa8avRgCLzMtS9uD6gmPO2GY129S5ovczlpcA=;
        b=IRoLC1E6fqQL/WmmOGXSw1nfT7XTvAMPKoOzYP/l9TYgD5O4UkwwtFs90Ih8s1vcPz
         /a7TPXmUIBvFC1L6JzLzjN8IrahTWFFjxxzqg50oVcpD/gZ7YWvLc0jAPGdIeB879g/z
         nu4P9I/gsCzlF4Eyju0K/KoLa8O6P/o/p7JrYkoYC8tnFj9R7pI+a9kfM17016ZnA3Jn
         ubjIC8odl+YL0jNpbCK/hhu9oJIStwPEe5q119loGKLP5CgaW9UoQC8xVtMd3PnG1L8M
         JrmQj1pg4hoYLC7B5c1PfWE7M0Xq3Of7hpo4r91yQZHgjwBtc98PXBmOr/rCUCiLZ8lR
         N34w==
X-Gm-Message-State: AOAM532njnm7B1D1kj8RN/4prp8KirNghE9OEQfcZw1ghGdLA1XiLxrQ
        SwngC0VKHPopzMg0tc7fDA2h6tDNA1O07v7vfg==
X-Google-Smtp-Source: ABdhPJx34e9nPiDw+gT8zarXTKmsqrTynJL70oY3j/bY/HhHf4bACXfvvpHHXZO8YLCgaXOcRpzYo2Ixc5atUVGxXA==
Sender: "lokeshgidra via sendgmr" <lokeshgidra@lg.mtv.corp.google.com>
X-Received: from lg.mtv.corp.google.com ([100.89.4.209]) (user=lokeshgidra
 job=sendgmr) by 2002:ad4:4051:: with SMTP id r17mr10076025qvp.39.1605841458917;
 Thu, 19 Nov 2020 19:04:18 -0800 (PST)
Date:   Thu, 19 Nov 2020 19:04:10 -0800
In-Reply-To: <20201120030411.2690816-1-lokeshgidra@google.com>
Message-Id: <20201120030411.2690816-2-lokeshgidra@google.com>
Mime-Version: 1.0
References: <20201120030411.2690816-1-lokeshgidra@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v6 1/2] Add UFFD_USER_MODE_ONLY
From:   Lokesh Gidra <lokeshgidra@google.com>
To:     Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Daniel Colascione <dancol@dancol.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kaleshsingh@google.com,
        calin@google.com, surenb@google.com, jeffv@google.com,
        kernel-team@android.com, Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Jerome Glisse <jglisse@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nitin Gupta <nigupta@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Iurii Zaikin <yzaikin@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-mm@kvack.kernel.org, Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

userfaultfd handles page faults from both user and kernel code.
Add a new UFFD_USER_MODE_ONLY flag for userfaultfd(2) that makes
the resulting userfaultfd object refuse to handle faults from kernel
mode, treating these faults as if SIGBUS were always raised, causing
the kernel code to fail with EFAULT.

A future patch adds a knob allowing administrators to give some
processes the ability to create userfaultfd file objects only if they
pass UFFD_USER_MODE_ONLY, reducing the likelihood that these processes
will exploit userfaultfd's ability to delay kernel page faults to open
timing windows for future exploits.

Signed-off-by: Daniel Colascione <dancol@google.com>
Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
Reviewed-by: Andrea Arcangeli <aarcange@redhat.com>
---
 fs/userfaultfd.c                 | 10 +++++++++-
 include/uapi/linux/userfaultfd.h |  9 +++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 000b457ad087..605599fde015 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -405,6 +405,13 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 
 	if (ctx->features & UFFD_FEATURE_SIGBUS)
 		goto out;
+	if ((vmf->flags & FAULT_FLAG_USER) == 0 &&
+	    ctx->flags & UFFD_USER_MODE_ONLY) {
+		printk_once(KERN_WARNING "uffd: Set unprivileged_userfaultfd "
+			"sysctl knob to 1 if kernel faults must be handled "
+			"without obtaining CAP_SYS_PTRACE capability\n");
+		goto out;
+	}
 
 	/*
 	 * If it's already released don't get it. This avoids to loop
@@ -1965,10 +1972,11 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 	BUG_ON(!current->mm);
 
 	/* Check the UFFD_* constants for consistency.  */
+	BUILD_BUG_ON(UFFD_USER_MODE_ONLY & UFFD_SHARED_FCNTL_FLAGS);
 	BUILD_BUG_ON(UFFD_CLOEXEC != O_CLOEXEC);
 	BUILD_BUG_ON(UFFD_NONBLOCK != O_NONBLOCK);
 
-	if (flags & ~UFFD_SHARED_FCNTL_FLAGS)
+	if (flags & ~(UFFD_SHARED_FCNTL_FLAGS | UFFD_USER_MODE_ONLY))
 		return -EINVAL;
 
 	ctx = kmem_cache_alloc(userfaultfd_ctx_cachep, GFP_KERNEL);
diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
index e7e98bde221f..5f2d88212f7c 100644
--- a/include/uapi/linux/userfaultfd.h
+++ b/include/uapi/linux/userfaultfd.h
@@ -257,4 +257,13 @@ struct uffdio_writeprotect {
 	__u64 mode;
 };
 
+/*
+ * Flags for the userfaultfd(2) system call itself.
+ */
+
+/*
+ * Create a userfaultfd that can handle page faults only in user mode.
+ */
+#define UFFD_USER_MODE_ONLY 1
+
 #endif /* _LINUX_USERFAULTFD_H */
-- 
2.29.0.rc1.297.gfa9743e501-goog

