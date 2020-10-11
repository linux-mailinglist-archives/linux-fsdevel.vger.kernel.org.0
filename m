Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932EB28A5EA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Oct 2020 08:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgJKGZE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Oct 2020 02:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgJKGZD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Oct 2020 02:25:03 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1F7C0613D2
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Oct 2020 23:25:03 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id eh4so4870465qvb.12
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Oct 2020 23:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=EOovoB63mTNgnDeBGShd0QgMbi9PshapUqeSaojca1c=;
        b=LVXko3Hcrxqpkqjw4qp3l2lqDGjuJbCxZwlPQHlN3ABbKQE5MnJQJGYvrPrzp0+XQJ
         xe35ME2rFCaVv6FCK8RBf96ywpGvNTtsbOgMFmcsifDgIDsJYxLffmrAJLgPe04ITLhP
         7q7V3YPlWvaRT8l/h21YGG8ykaEMDOJrVf7fa4Ogu7ZBflNc0n3VGKRQUato1UY9JDCz
         9awfqjwCrbO7YZWSEu12mT6XSBJNXvsdCK2YM2TRriD/nL1oskRfAYOVUiLoz1mXdluR
         R0BzQdOraoC1ywdVMUmzqmwmIKhxYEJMbfUIrEp1IjVUgpvuHVfJlp28ySs9B/AhhGcv
         uF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EOovoB63mTNgnDeBGShd0QgMbi9PshapUqeSaojca1c=;
        b=rMuiwor8MlICv3uVnsqM+/U6JoLvWcmErSjOFyibODHNDU0+DVvH1jO6gEYUKiNcPN
         zPqWMBgdMIsd2nHsUPqKBxSXAwVZKSTNgwripYldjZl8I+JHIcsOql8zrrGmLodoP2Yu
         LgurE9yyTFHTksGCikc9uGsTExJiV4u/YkflQqPpNmrZns3Qp6vyxqyD59ATQNmqyVVF
         gqkgthje1Eb74RxxJEJQYS4g8nFbn6PrX0TaZnFzBRcdwjGbUvTLJUG9sK4gntw0+Dvt
         LPirL18VuNwV3VkdzzJLCpAi7MyaJ/hM5d789aAdc9PbJiAPN1+LefSC75l8yY8SoxNx
         tNHQ==
X-Gm-Message-State: AOAM533oD4SYpOPym46AXhLKzp7I+EWwyKejiUbsjQQF9sEuZJVOpMkE
        +6VyJdG+rbsXeyiqINkZsP48skiz2QEnGyCByQ==
X-Google-Smtp-Source: ABdhPJw9sm8/WVHSmcrHkJYm7Ha57Yv6FZUh8ylmPOpg1TPvFBMEVR2+aHjracYoglMHkrUriRfoN2WmW7juJLjHwA==
Sender: "lokeshgidra via sendgmr" <lokeshgidra@lg.mtv.corp.google.com>
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:29dd])
 (user=lokeshgidra job=sendgmr) by 2002:ad4:544a:: with SMTP id
 h10mr20428528qvt.35.1602397502814; Sat, 10 Oct 2020 23:25:02 -0700 (PDT)
Date:   Sat, 10 Oct 2020 23:24:55 -0700
In-Reply-To: <20201011062456.4065576-1-lokeshgidra@google.com>
Message-Id: <20201011062456.4065576-2-lokeshgidra@google.com>
Mime-Version: 1.0
References: <20201011062456.4065576-1-lokeshgidra@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v5 1/2] Add UFFD_USER_MODE_ONLY
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
        calin@google.com, surenb@google.com, nnk@google.com,
        jeffv@google.com, kernel-team@android.com,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Jerome Glisse <jglisse@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nitin Gupta <nigupta@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Iurii Zaikin <yzaikin@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Daniel Colascione <dancol@google.com>
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
---
 fs/userfaultfd.c                 | 10 +++++++++-
 include/uapi/linux/userfaultfd.h |  9 +++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 0e4a3837da52..bd229f06d4e9 100644
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
@@ -1975,10 +1982,11 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
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
2.28.0.1011.ga647a8990f-goog

