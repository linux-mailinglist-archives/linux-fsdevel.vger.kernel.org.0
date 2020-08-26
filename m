Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1C8252510
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Aug 2020 03:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgHZBkR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Aug 2020 21:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbgHZBkM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Aug 2020 21:40:12 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44548C061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2020 18:40:10 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id k32so293883pgm.15
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2020 18:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=QrfOzc6XPAwCgYDeycXOM2EpifoygU2U9TLCo43uwFY=;
        b=Gp9NVG0ZESXHmSZItMfVjNi/mKQmY5fuiZVCI7LgbDD0Pfi5ybSYImPwOJa25MEa0X
         ua6+a0hlj8fL33Ya6kESSfJaHhGxhu/4UzOsuKnHGDnPc0MvLqlfI0SMX5ojLWt7USFD
         EXz/vaGOAUXmVjNXZN3g8s1dfXUf6J3kKrRhURksX/sFRerGdp71sW+i0VzxsBf9T3sQ
         e1iV4RNOUXMnH+EWLrUSNuXtF+OVWHtPdBgqAHCoP4u3JT/21DOFHpVimdFLws/rA1m5
         9+8F+8hdgjZzjRo4l3zAZpR6XbQWv5lixZubr53cBM9RaGqpjmL5m5Qmt10/Z87pyxQd
         RX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QrfOzc6XPAwCgYDeycXOM2EpifoygU2U9TLCo43uwFY=;
        b=FQuVe7I9pWe+uP+oZ9onOX+o6VJoERmDH4fUyzOaxSwhttVR79LbDa+LFVs4QmxeDI
         KSQQWYub9dz+mCkQEc6Qw+Dy7KK0VMM1F9j66n7zVUP6T4rR7NINJ89DU6v+FDC1azl+
         wTJBna4vS7mXNYW+xH27OR6RCdjk+gNJ5+OgfNvIXtQkqKQ0xfA6GqO2ix9d7JNf/HPm
         du9EKp5+flZ/yZLDxnCKl6cX/PzQpAy8/Wvxv0WWdllvpo27HAz+kmj9WqbuWp3DUhcF
         Tov4IiY3uqQQpr0mx0bQ627zJ1fbs6MKAyNzQGtaRiVw2e4NvmRrooVxn2a3nQuhjPc6
         YH6w==
X-Gm-Message-State: AOAM53306Lo7V/aoltElOLFjRydO+3PHKgmioxi4dIoyOnuzQQffmtk7
        KQlWSM59GnU/jj44SF3qOxilEBzksspNyMQ/9w==
X-Google-Smtp-Source: ABdhPJyuRHyDek0VQzUH9/QGNGLtchxKND8ZsBU0EPK7mBXtEMW1Vk/5gFl9Wx92oYp93X1Yy9DmZ2wtuCvjjxP7RQ==
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:29dd])
 (user=lokeshgidra job=sendgmr) by 2002:a17:90b:1b47:: with SMTP id
 nv7mr3677042pjb.128.1598406009623; Tue, 25 Aug 2020 18:40:09 -0700 (PDT)
Date:   Tue, 25 Aug 2020 18:39:58 -0700
In-Reply-To: <20200826013959.1981270-1-lokeshgidra@google.com>
Message-Id: <20200826013959.1981270-2-lokeshgidra@google.com>
Mime-Version: 1.0
References: <20200826013959.1981270-1-lokeshgidra@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v3 1/2] Add UFFD_USER_MODE_ONLY
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
Sender: linux-fsdevel-owner@vger.kernel.org
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
2.28.0.297.g1956fa8f8d-goog

