Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5DA24E484
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Aug 2020 03:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgHVBkf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 21:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgHVBk2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 21:40:28 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8322EC061575
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 18:40:27 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e1so4054172ybk.14
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 18:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=tKITLEyWnWCi9IJ4HMcscwuSv2AmZTmql/ok3Wo7ZvQ=;
        b=ucn8M6gYfR4WBFzw8eeNOL6MRtLncDDzaiGDLI6u21NlKZXLjmVIM6kCYQFIxVdxSJ
         zdsSL8sRuhAY02v8EPbLClsbB0hu7jJeZNfVgz2NwSv1KCveVJooy4+EBftCUaaGKJJw
         cc0qLfj32PQHBoSrbsvLv6ke8gSbrx/SedtQAYLjKRti5v3LdgVFIdmSGSWVviicG1/D
         OB7LLKlB6f+VXc1/QEm2z+HDWzzNrpQga3HUi3OjTldhS5rFl6ZI9PXBVWmJ2feZKBiW
         0FqU6fHiUHVDFPOeLhfxiOUK4oGWMNOO6Z8a7ewewzlpFXDGeRIjH056qHfnde08RZKq
         WNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tKITLEyWnWCi9IJ4HMcscwuSv2AmZTmql/ok3Wo7ZvQ=;
        b=rdV2JMaeDPJShj/Auhc3Q11aIZvGdIcgh1K44SsSaHcpf9ZLoDV0YDzFbCskoLs/6V
         4q81GttrzHd1O83N0PEazseakwd4142UkKAREmCZA+x0ZAJnitIqbean+Td11dJ18oQ0
         6ju37jbiJLhyt+nw/9M6WK9P3bEpZfia+9fApoNqgqArk4iLpHM/ydFg82qz+iW3Px4u
         vD7O0uuvI3/dKqH1tyDKpR5UjzQHuTxrTmSnoX+F37iTbOebIQMOo9stcZJf8TinP1OF
         71KxzvqKSnbook+gf6r+wiLz0q43ysW0hlrs3cXoCijCxhaMUmIX+SCRQkR9QlVvb14m
         +tKg==
X-Gm-Message-State: AOAM5311LVkSmplQAPJD+Mq+oCoT+pXizFncYfC9+0HEh6ndlBuxrWTy
        U7PAzxKHzZoM3md27VJpKU3nvAUlwfhwRBCcAg==
X-Google-Smtp-Source: ABdhPJyDjyQrzQvudTYj4/X7uhGm0k2D6vJ9FL3QpJpxNbUXIBUfhsFQ4o0as7SBR1h8V3D/ko8jO98VYXcUtxCLwQ==
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:29dd])
 (user=lokeshgidra job=sendgmr) by 2002:a25:c582:: with SMTP id
 v124mr7843055ybe.456.1598060426970; Fri, 21 Aug 2020 18:40:26 -0700 (PDT)
Date:   Fri, 21 Aug 2020 18:40:17 -0700
In-Reply-To: <20200822014018.913868-1-lokeshgidra@google.com>
Message-Id: <20200822014018.913868-2-lokeshgidra@google.com>
Mime-Version: 1.0
References: <20200822014018.913868-1-lokeshgidra@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v2 1/2] Add UFFD_USER_MODE_ONLY
From:   Lokesh Gidra <lokeshgidra@google.com>
To:     Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Biggers <ebiggers@kernel.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Daniel Colascione <dancol@dancol.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kaleshsingh@google.com,
        calin@google.com, surenb@google.com, nnk@google.com,
        jeffv@google.com, kernel-team@android.com,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Jerome Glisse <jglisse@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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
 fs/userfaultfd.c                 | 7 ++++++-
 include/uapi/linux/userfaultfd.h | 9 +++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 0e4a3837da52..3e4ae6145112 100644
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
@@ -1966,6 +1969,7 @@ static void init_once_userfaultfd_ctx(void *mem)
 
 SYSCALL_DEFINE1(userfaultfd, int, flags)
 {
+	static const int uffd_flags = UFFD_USER_MODE_ONLY;
 	struct userfaultfd_ctx *ctx;
 	int fd;
 
@@ -1975,10 +1979,11 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
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
2.28.0.297.g1956fa8f8d-goog

