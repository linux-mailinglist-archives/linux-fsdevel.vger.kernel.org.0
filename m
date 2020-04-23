Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A560F1B5145
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 02:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgDWA1B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 20:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725846AbgDWA1B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 20:27:01 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040C0C03C1AA
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2020 17:27:01 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id y16so3670199pfe.16
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2020 17:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=3cs6cpETnu5up7poODqqpjwIIIEEY9B/JJrROxUknZo=;
        b=UM9lf+UjXr7lQ4WhqVJUaEoeVlpkZXm8IVaaoCLCkjlU4nL3c9A30jdtNMATw5LU30
         ZN/uQt6iOFMRSjWe1mIyG0tfJLl07wwCa/9w/q7bnyzDQOzo62S+rW6YV9fc1x2yMaQy
         U26PJs1dTMsjpsMRYLOd5Y5Y2ITryXXyxPAZ8VA12ffUY6m57kgupwUGYHEqKj1oYPH0
         wF2hsOYFZU4zrR9uMbePQ9C1+He52kETBBM+OgoLJ2Lkf3j4fXoRvjjJxfFl+aP+ocyf
         H5+ezAemb1c/R0uR3+ZNDWcwGgvTWOQ2RA2jRQxlu+8ZJTVKxedPGoiN9dnLIV1O+TvS
         /04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=3cs6cpETnu5up7poODqqpjwIIIEEY9B/JJrROxUknZo=;
        b=pdMhhTvXvrU9Myy+fFUB4UhRzbXJeopsB+PvAJ7gjSwUp/0YhRBj6yTHgmJPVGDgd0
         m5e5qQBfXbEMIbPayFPyzMxCNFxiGFpSMRa2WEhr0+ppxG673d/rIRyJgHi2Sy0YVif3
         voDUhOTGNPeVTdtwhqg4WmCIAxYTe3NGxJ6pl+/WidXWlyIUNNHq3G+oyr65Lxe6bjv/
         qMIdPwxfwi3U9PjZw9Ylvn0k50bM4uaXBLRMyqLHJcA4GRqFWUpS56UhGL3sUUUanbHn
         z1WfZlaYp+ZDo5Yj3qunXWJh5rnSDUffLCFoMNNrptszjjxKwx9Z4B9HSArff3mhuRbi
         vPXQ==
X-Gm-Message-State: AGi0Pub3ybEUV4sR33f0EeYYaB3VcVhj4cg3m16COyyQZtIz4XlHBnD4
        ScH07AhMOeq2Do4/FAILYgi3pi1Dg7g=
X-Google-Smtp-Source: APiQypLEMPU3+WWUCkc7uWfkQ+0lZ7h9UwrP41CKaeCyB4zN/CtnLBODcu/h6ljeA8UPWl8LNoRxpWvc6W0=
X-Received: by 2002:a17:90a:b104:: with SMTP id z4mr1426983pjq.115.1587601620510;
 Wed, 22 Apr 2020 17:27:00 -0700 (PDT)
Date:   Wed, 22 Apr 2020 17:26:31 -0700
In-Reply-To: <20200423002632.224776-1-dancol@google.com>
Message-Id: <20200423002632.224776-2-dancol@google.com>
Mime-Version: 1.0
References: <20200423002632.224776-1-dancol@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH 1/2] Add UFFD_USER_MODE_ONLY
From:   Daniel Colascione <dancol@google.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Xu <peterx@redhat.com>,
        Daniel Colascione <dancol@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>, Shaohua Li <shli@fb.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, timmurray@google.com,
        minchan@google.com, sspatil@google.com, lokeshgidra@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

userfaultfd handles page faults from both user and kernel code.  Add a
new UFFD_USER_MODE_ONLY flag for userfaultfd(2) that makes the
resulting userfaultfd object refuse to handle faults from kernel mode,
treating these faults as if SIGBUS were always raised, causing the
kernel code to fail with EFAULT.

A future patch adds a knob allowing administrators to give some
processes the ability to create userfaultfd file objects only if they
pass UFFD_USER_MODE_ONLY, reducing the likelihood that these processes
will exploit userfaultfd's ability to delay kernel page faults to open
timing windows for future exploits.

Signed-off-by: Daniel Colascione <dancol@google.com>
---
 fs/userfaultfd.c                 | 7 ++++++-
 include/uapi/linux/userfaultfd.h | 9 +++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index e39fdec8a0b0..21378abe8f7b 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -418,6 +418,9 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 
 	if (ctx->features & UFFD_FEATURE_SIGBUS)
 		goto out;
+	if ((vmf->flags & FAULT_FLAG_USER) == 0 &&
+	    ctx->flags & UFFD_USER_MODE_ONLY)
+		goto out;
 
 	/*
 	 * If it's already released don't get it. This avoids to loop
@@ -2003,6 +2006,7 @@ static void init_once_userfaultfd_ctx(void *mem)
 
 SYSCALL_DEFINE1(userfaultfd, int, flags)
 {
+	static const int uffd_flags = UFFD_USER_MODE_ONLY;
 	struct userfaultfd_ctx *ctx;
 	int fd;
 
@@ -2012,10 +2016,11 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 	BUG_ON(!current->mm);
 
 	/* Check the UFFD_* constants for consistency.  */
+	BUILD_BUG_ON(uffd_flags & UFFD_SHARED_FCNTL_FLAGS);
 	BUILD_BUG_ON(UFFD_CLOEXEC != O_CLOEXEC);
 	BUILD_BUG_ON(UFFD_NONBLOCK != O_NONBLOCK);
 
-	if (flags & ~UFFD_SHARED_FCNTL_FLAGS)
+	if (flags & ~(UFFD_SHARED_FCNTL_FLAGS | uffd_flags))
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
2.26.2.303.gf8c07b1a785-goog

