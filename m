Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F0F2769CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 08:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgIXG4P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 02:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgIXG4O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 02:56:14 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1597DC0613CE
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2020 23:56:14 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 139so2008760ybe.15
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2020 23:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=0lc69aA0lZ8Rvz8am0rRBV+yoECXRArvVbNXpFjuF40=;
        b=IAfJ9hUkQEx5zcT/VoPJFQBNov4n/VGUJ2rUk3yYjsbHcmOpHg2psmZnWDQT1HibG8
         EoL1YHN1lh6kttKZYhxFxT/bhLxpS+FE5pJfN4nnr5ghPEoQFQX19vUBUc/UYBrd3aiD
         Y34qiKb+zTLH1vMmlVMKBg7iplLE/XMAYY4RDNo0HjImc21wcDBULe2M9Wu1rNNeJpNw
         OcyEND8JQgLZiLpqDHihBdOkCGy62BeywRwX0UGdoeAj+mEYZw+9IZ36lYOXp30qEtOe
         /3XOP5Wpdp9/In1hwPw11yVmfusFF4LGPB41iX8Pk1nN9EJL6Uygo8ox5pY8p2rh5ylP
         b1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0lc69aA0lZ8Rvz8am0rRBV+yoECXRArvVbNXpFjuF40=;
        b=ph0Qfg16buEKgG33VeBKJo0lGncI86YRg2g0SGIls0OgwRAm0sErSqdoqBqjaivPiw
         OgNDO90KJyPSkeoReCvydjZQn/uGOrhIhhhULPgpbrsjJXCJo9JZtA9NridyfazFs+ZO
         4LjlZByATq+2yDSw+r8ynr475iHiIS4ZiUyZeOH09DMBlQ4YvpmasuD9UfOuGipEIjOQ
         FZdh6pBpqMn7XeMVt9BiN7eBCb8O6QACmvDv5qKenJHnO7ip5p6lmgxHKsb91rJbpPZ5
         VyJrkaLqDbJYnsAt+mSpnxSEJyS4H56MZcJ9eNoFom60xY0qgNQMf/IhSOcsGH2VgQ1r
         X6BA==
X-Gm-Message-State: AOAM530knKDoaYNKskekRIVVDKVQCYLA8NPZ7oWFQqRh0XygakiYe44l
        icwaNfJFEr2hybjMxL77O5EHXLni8kuwO2PkzQ==
X-Google-Smtp-Source: ABdhPJzMmPQPeoJFyWqE98eXL323QIE0VTj57+sU2UBDWAcdC/qsoSA0OeELDrbSu6EGODdQw9UHozulqnwRgeyFRA==
Sender: "lokeshgidra via sendgmr" <lokeshgidra@lg.mtv.corp.google.com>
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:29dd])
 (user=lokeshgidra job=sendgmr) by 2002:a5b:e83:: with SMTP id
 z3mr4661708ybr.289.1600930573277; Wed, 23 Sep 2020 23:56:13 -0700 (PDT)
Date:   Wed, 23 Sep 2020 23:56:05 -0700
In-Reply-To: <20200924065606.3351177-1-lokeshgidra@google.com>
Message-Id: <20200924065606.3351177-2-lokeshgidra@google.com>
Mime-Version: 1.0
References: <20200924065606.3351177-1-lokeshgidra@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v4 1/2] Add UFFD_USER_MODE_ONLY
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
 fs/userfaultfd.c                 | 6 +++++-
 include/uapi/linux/userfaultfd.h | 9 +++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 0e4a3837da52..3191434057f3 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -405,6 +405,9 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 
 	if (ctx->features & UFFD_FEATURE_SIGBUS)
 		goto out;
+	if ((vmf->flags & FAULT_FLAG_USER) == 0 &&
+	    ctx->flags & UFFD_USER_MODE_ONLY)
+		goto out;
 
 	/*
 	 * If it's already released don't get it. This avoids to loop
@@ -1975,10 +1978,11 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
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
2.28.0.681.g6f77f65b4e-goog

