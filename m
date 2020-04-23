Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A6C1B5147
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 02:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgDWA1I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 20:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726366AbgDWA1F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 20:27:05 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69319C03C1AB
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2020 17:27:04 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id x6so3214461pjg.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2020 17:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=cLhIPyxMn3s+VxrKXhmBoW15tCFqEcrWbg6AizvES3c=;
        b=DkYFt5JS1cxdS2DHIvHgS0H+WuG1lYhcepNLKeMUdwTbK0/X/yFbZ/ke8bST2Y1V9i
         N6E+lCb7I55KnDLjr1oRU4jg2YrvHExJlXCWtvVjCQFHgQSq00Iiv9CmL0r9DzgUXxIz
         UaaOWHLzhaaQIiVOVf2sTLoYnWf9KbR0ubRP67JDTDjSA6utYb0NYceD6RS/GQfcq1Pg
         Opevl3csIbN4Ha7nrW/YsexZAL2w09hSV64mfaHidynrMu826KXNcPqEVzlvbnXqPlAx
         9MYkFM8ZL1iS4waU0L3c3RBioyL2YwAYvwq6T7CUT1yonxAJjXO1oukoKp6D/v74GZt0
         HtlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=cLhIPyxMn3s+VxrKXhmBoW15tCFqEcrWbg6AizvES3c=;
        b=ltkGQ+qyJ0ywzQNbSuzMuzqbvJRZ6lINFIQhjcAXcTcPsvRYHGCidDCuzXBplcokSh
         BPYho4qsCvr/OEa8EEYQxHTBs53lmkwNZzvhi5GLrhqMgjgVzIulacItibuOsFrShZnA
         /EhfngwlQ6R6eisMYrI3u/bDwRaO1jJP8pArXvV47NhdIpOmXoYlQD28e4R9p/a3hw69
         TdjissTRmqf5TPCg0SZYTuSV8bvdpBjxn7A+WK1KOpSyb2eTyMrRIzW2yNPx3TFq81vn
         CMdhS5E5Nel6pAlfr9flV7y9aYR6LqQbntqEr/SfuvOjsl8GQqADset2b8pQH8gRWIAs
         vIiQ==
X-Gm-Message-State: AGi0PubLYtTUC2R5PsK0rh+APC5ozdJJ7UT2xnFW6DR6snbpJB84gypy
        injYYCg9yhdgWJSFCKUXReec4jbyIj0=
X-Google-Smtp-Source: APiQypJ8fFvez1uks1jwaK82spWzI82Nw2+laLmruWmMNiV7KJez/SW8NdNyAD1F4/9ojj2p3zTicA0CU7c=
X-Received: by 2002:a17:90a:210b:: with SMTP id a11mr1464127pje.31.1587601623780;
 Wed, 22 Apr 2020 17:27:03 -0700 (PDT)
Date:   Wed, 22 Apr 2020 17:26:32 -0700
In-Reply-To: <20200423002632.224776-1-dancol@google.com>
Message-Id: <20200423002632.224776-3-dancol@google.com>
Mime-Version: 1.0
References: <20200423002632.224776-1-dancol@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH 2/2] Add a new sysctl knob: unprivileged_userfaultfd_user_mode_only
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

This sysctl can be set to either zero or one. When zero (the default)
the system lets all users call userfaultfd with or without
UFFD_USER_MODE_ONLY, modulo other access controls. When
unprivileged_userfaultfd_user_mode_only is set to one, users without
CAP_SYS_PTRACE must pass UFFD_USER_MODE_ONLY to userfaultfd or the API
will fail with EPERM. This facility allows administrators to reduce
the likelihood that an attacker with access to userfaultfd can delay
faulting kernel code to widen timing windows for other exploits.

Signed-off-by: Daniel Colascione <dancol@google.com>
---
 Documentation/admin-guide/sysctl/vm.rst | 13 +++++++++++++
 fs/userfaultfd.c                        | 11 ++++++++++-
 include/linux/userfaultfd_k.h           |  1 +
 kernel/sysctl.c                         |  9 +++++++++
 4 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 0329a4d3fa9e..4296b508ab74 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -850,6 +850,19 @@ privileged users (with SYS_CAP_PTRACE capability).
 
 The default value is 1.
 
+unprivileged_userfaultfd_user_mode_only
+========================================
+
+This flag controls whether unprivileged users can use the userfaultfd
+system calls to handle page faults in kernel mode.  If set to zero,
+userfaultfd works with or without UFFD_USER_MODE_ONLY, modulo
+unprivileged_userfaultfd above.  If set to one, users without
+SYS_CAP_PTRACE must pass UFFD_USER_MODE_ONLY in order for userfaultfd
+to succeed.  Prohibiting use of userfaultfd for handling faults from
+kernel mode may make certain vulnerabilities more difficult
+to exploit.
+
+The default value is 0.
 
 user_reserve_kbytes
 ===================
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 21378abe8f7b..85cc1ab74361 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -29,6 +29,7 @@
 #include <linux/hugetlb.h>
 
 int sysctl_unprivileged_userfaultfd __read_mostly = 1;
+int sysctl_unprivileged_userfaultfd_user_mode_only __read_mostly = 0;
 
 static struct kmem_cache *userfaultfd_ctx_cachep __read_mostly;
 
@@ -2009,8 +2010,16 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 	static const int uffd_flags = UFFD_USER_MODE_ONLY;
 	struct userfaultfd_ctx *ctx;
 	int fd;
+	bool need_cap_check = false;
 
-	if (!sysctl_unprivileged_userfaultfd && !capable(CAP_SYS_PTRACE))
+	if (!sysctl_unprivileged_userfaultfd)
+		need_cap_check = true;
+
+	if (sysctl_unprivileged_userfaultfd_user_mode_only &&
+	    (flags & UFFD_USER_MODE_ONLY) == 0)
+		need_cap_check = true;
+
+	if (need_cap_check && !capable(CAP_SYS_PTRACE))
 		return -EPERM;
 
 	BUG_ON(!current->mm);
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index a8e5f3ea9bb2..d81e30074bf5 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -31,6 +31,7 @@
 #define UFFD_FLAGS_SET (EFD_SHARED_FCNTL_FLAGS)
 
 extern int sysctl_unprivileged_userfaultfd;
+extern int sysctl_unprivileged_userfaultfd_user_mode_only;
 
 extern vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason);
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 8a176d8727a3..9cbdf4483961 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1719,6 +1719,15 @@ static struct ctl_table vm_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
+	{
+		.procname	= "unprivileged_userfaultfd_user_mode_only",
+		.data		= &sysctl_unprivileged_userfaultfd_user_mode_only,
+		.maxlen		= sizeof(sysctl_unprivileged_userfaultfd_user_mode_only),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
 #endif
 	{ }
 };
-- 
2.26.2.303.gf8c07b1a785-goog

