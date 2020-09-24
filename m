Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C53B2769CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 08:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbgIXG4T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 02:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgIXG4R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 02:56:17 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B573C0613CE
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2020 23:56:17 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id l5so1748743qtu.20
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2020 23:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ke1FEsl77Kc9oiXNsFHcCDNOwBSCt2v+UAY//5HtPgA=;
        b=wFNt8GqobtkvzKQbpeNuwwKD7cJM6653QEQTP0/fQ32HCibNFnNSCAdUGk7XxvxLCQ
         wZMVMziyIc+3KTIXWzlQ44tdEtv4Jms/lVWMSApeK+7xyiNDVGXduAgCQPWQmGScBe0y
         b3DZXlUy+6BpBugiPDDa6yscGSmDf4orJiy+k4J33nRIG0YifrMCLg9DsHILEenRyogr
         xgpuzhDOsJoD/y9ak4A+GfsFCQdUT9rNiT2C+iRojP6S0NSxY5Yy9rih4puQaZqexUQi
         WfclaOJ5k4/HwBP5gzQpCfxbdYlMU6bi6k0Pb6Pk2/aFrsXrwg4ro0JeWieN9YfqtCIW
         iqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ke1FEsl77Kc9oiXNsFHcCDNOwBSCt2v+UAY//5HtPgA=;
        b=G7xaFfUqr8gZlFxbmu7a/Q2LvYxI8RWOpV5OLhVELGwZ+Poca0TqM/PanxEQ3GpqdS
         RwiobWWDpPBOWnS9Wi8hQg/KRflKQFcK/t1YhXDI0Q4X9P2YsJzjPXhOtkkcrjVmhwOv
         6XF+ChNOKjV8WqjP7i8b40l3KG+3OjSnNTcO2MY3EoMQZmnfsxsWl+0hNnAEniuuu8yv
         xhOZ6YR/qRxkM/uXWQTpJtrIbtSM+4R1NXC1rOlA/ZPbHXqPLvy2v88Ge7GNq+7Fl3GZ
         yM3wqoJ41E2O16Ok2gQohuqMzD8RL0sxw8MJ/fcHfxAvXL6fTj9qUGam3+i+3tlrO5/q
         XVAQ==
X-Gm-Message-State: AOAM532BxTQKIZ4c8tcVShx6ndLQqAZ5raiu0OYdHIsJDhaPlRR8vKYo
        RTcI9bkYhz2N/KkUSpOCEUZ+e/xnxNelf1G9WQ==
X-Google-Smtp-Source: ABdhPJxza0fuBaFmbZ3gbUVLmFUZdTvAFAr+hqa4TX5v95zkmpSNEi+rzcne2bTvV+co7oFl2J4bRL0sKnZX61IOKQ==
Sender: "lokeshgidra via sendgmr" <lokeshgidra@lg.mtv.corp.google.com>
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:29dd])
 (user=lokeshgidra job=sendgmr) by 2002:ad4:58e3:: with SMTP id
 di3mr3949934qvb.54.1600930576477; Wed, 23 Sep 2020 23:56:16 -0700 (PDT)
Date:   Wed, 23 Sep 2020 23:56:06 -0700
In-Reply-To: <20200924065606.3351177-1-lokeshgidra@google.com>
Message-Id: <20200924065606.3351177-3-lokeshgidra@google.com>
Mime-Version: 1.0
References: <20200924065606.3351177-1-lokeshgidra@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v4 2/2] Add user-mode only option to unprivileged_userfaultfd
 sysctl knob
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
        Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With this change, when the knob is set to 0, it allows unprivileged
users to call userfaultfd, like when it is set to 1, but with the
restriction that page faults from only user-mode can be handled.
In this mode, an unprivileged user (without SYS_CAP_PTRACE capability)
must pass UFFD_USER_MODE_ONLY to userfaultd or the API will fail with
EPERM.

This enables administrators to reduce the likelihood that
an attacker with access to userfaultfd can delay faulting kernel
code to widen timing windows for other exploits.

The default value of this knob is changed to 0. This is required for
correct functioning of pipe mutex. However, this will fail postcopy
live migration, which will be unnoticeable to the VM guests. To avoid
this, set 'vm.userfault = 1' in /sys/sysctl.conf. For more details,
refer to Andrea's reply [1].

[1] https://lore.kernel.org/lkml/20200904033438.GI9411@redhat.com/

Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
---
 Documentation/admin-guide/sysctl/vm.rst | 15 ++++++++++-----
 fs/userfaultfd.c                        |  6 ++++--
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 4b9d2e8e9142..4263d38c3c21 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -871,12 +871,17 @@ file-backed pages is less than the high watermark in a zone.
 unprivileged_userfaultfd
 ========================
 
-This flag controls whether unprivileged users can use the userfaultfd
-system calls.  Set this to 1 to allow unprivileged users to use the
-userfaultfd system calls, or set this to 0 to restrict userfaultfd to only
-privileged users (with SYS_CAP_PTRACE capability).
+This flag controls the mode in which unprivileged users can use the
+userfaultfd system calls. Set this to 0 to restrict unprivileged users
+to handle page faults in user mode only. In this case, users without
+SYS_CAP_PTRACE must pass UFFD_USER_MODE_ONLY in order for userfaultfd to
+succeed. Prohibiting use of userfaultfd for handling faults from kernel
+mode may make certain vulnerabilities more difficult to exploit.
 
-The default value is 1.
+Set this to 1 to allow unprivileged users to use the userfaultfd system
+calls without any restrictions.
+
+The default value is 0.
 
 
 user_reserve_kbytes
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 3191434057f3..3816c11a986a 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -28,7 +28,7 @@
 #include <linux/security.h>
 #include <linux/hugetlb.h>
 
-int sysctl_unprivileged_userfaultfd __read_mostly = 1;
+int sysctl_unprivileged_userfaultfd __read_mostly;
 
 static struct kmem_cache *userfaultfd_ctx_cachep __read_mostly;
 
@@ -1972,7 +1972,9 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 	struct userfaultfd_ctx *ctx;
 	int fd;
 
-	if (!sysctl_unprivileged_userfaultfd && !capable(CAP_SYS_PTRACE))
+	if (!sysctl_unprivileged_userfaultfd &&
+	    (flags & UFFD_USER_MODE_ONLY) == 0 &&
+	    !capable(CAP_SYS_PTRACE))
 		return -EPERM;
 
 	BUG_ON(!current->mm);
-- 
2.28.0.681.g6f77f65b4e-goog

