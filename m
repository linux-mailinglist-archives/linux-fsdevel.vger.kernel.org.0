Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648EB252513
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Aug 2020 03:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgHZBkX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Aug 2020 21:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgHZBkP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Aug 2020 21:40:15 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86099C061786
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2020 18:40:14 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id w11so698919ybi.23
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2020 18:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=pTY8yvOFmDR39/jT1bJjnUgxnfLpSxUhw6z3x4vY4tM=;
        b=Q7e3Em/t6aRaQagh6zbzCNxKDgJZrEMnVmuAoU+Q+zcOeavBrAsCD5z8sUZVr3F564
         p5WyiGNrEDETco6Id7AsSPQBp4MoGDQFTTXsSeVmHjkB9lVzVxUCc1aS0VcOjVPyjYoU
         fZiDnEDABYcj1bI0D2hD0KxWKpmozk1JAAARkvJ3lcN1Gb4eBRrDnAzfMgm6DcXn8a4N
         cwTC0ZbK3qeAhhKZ68OSa6IYHMGojKxdjhuIyLelO5qbmb1/NYF2bJ/gj0zhRiJK0B7q
         4gPWx8ptKo9Nvk4iwGlLqGDtytclbB6fhHL4WEQbwlTwdKfiABC+lIq2YMiuv5tJNFh6
         F2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pTY8yvOFmDR39/jT1bJjnUgxnfLpSxUhw6z3x4vY4tM=;
        b=ZLSvAupBn0Lb5AX7aKZcQiU182p37GfIDHf1JzfEF+9UJbo5SNTrwvtzgmySaGR+uT
         UlqUkYR7+Q4TNT8a25QcbBGrqHEaTC87G4BeaQG/iGqrZSOVG9q1NVweeX3oXUYqR6yu
         x7T2hPjJH0nrEkruayPKlbzPMNA+e2LXTkD/DZ72qEedYtettpnJs0OGVzMXazbRDt5/
         XbKxP5F5zjwMbKvq8cH4SSOOX5VTdewx4VRtaZv0BCCLqumY6Uwpln3hIiVRLPgPXUmm
         1W8dOApEkRmAwfLAXBBZPAqu/vtKJXVshJhkiT1FLZEp8M9oB8QaMeywLkMyVEleOave
         VelA==
X-Gm-Message-State: AOAM5338VLjfsJYdRSqT8IA3Wy26KIKmbZmLSKD53eSGIkyYi85+yoAs
        43YV/mARknZBzed7YdQnl9Nol/wyGWwj3boMCg==
X-Google-Smtp-Source: ABdhPJx4BxKrWWOKp8nitIzvxRLkTef4v+wYkIcCllLG3sRdwIsmkV4hwMYhryB4NtYOfB578tdl1RpWnVhPiaiOkA==
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:29dd])
 (user=lokeshgidra job=sendgmr) by 2002:a5b:744:: with SMTP id
 s4mr19088606ybq.26.1598406013712; Tue, 25 Aug 2020 18:40:13 -0700 (PDT)
Date:   Tue, 25 Aug 2020 18:39:59 -0700
In-Reply-To: <20200826013959.1981270-1-lokeshgidra@google.com>
Message-Id: <20200826013959.1981270-3-lokeshgidra@google.com>
Mime-Version: 1.0
References: <20200826013959.1981270-1-lokeshgidra@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v3 2/2] Add user-mode only option to unprivileged_userfaultfd
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
        Luis Chamberlain <mcgrof@kernel.org>,
        Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A third option is added to 'unprivileged_userfaultfd' sysctl knob.
When the knob is set to 2, it allows unprivileged users to call
userfaultfd, like when it is set to 1, but with the restriction that
page faults from only user-mode can be handled. In this mode,
an unprivileged user (without SYS_CAP_PTRACE capability) must pass
UFFD_USER_MODE_ONLY to userfaultd or the API will fail with EPERM.

This facility allows administrators to reduce the likelihood that
an attacker with access to userfaultfd can delay faulting kernel
code to widen timing windows for other exploits.

Signed-off-by: Daniel Colascione <dancol@google.com>
Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
---
 Documentation/admin-guide/sysctl/vm.rst | 10 +++++++---
 fs/userfaultfd.c                        | 10 ++++++++--
 kernel/sysctl.c                         |  2 +-
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 4b9d2e8e9142..23d6feb79f5c 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -872,9 +872,13 @@ unprivileged_userfaultfd
 ========================
 
 This flag controls whether unprivileged users can use the userfaultfd
-system calls.  Set this to 1 to allow unprivileged users to use the
-userfaultfd system calls, or set this to 0 to restrict userfaultfd to only
-privileged users (with SYS_CAP_PTRACE capability).
+system calls.  Set this to 0 to restrict userfaultfd to only privileged
+users (with SYS_CAP_PTRACE capability), set this to 1 to allow unprivileged
+users to use the userfaultfd system calls, or set this to 2 to restrict
+unprivileged users to handle page faults in user mode only. In the last case,
+users without SYS_CAP_PTRACE must pass UFFD_USER_MODE_ONLY in order for
+userfaultfd to succeed.  Prohibiting use of userfaultfd for handling faults
+from kernel mode may make certain vulnerabilities more difficult to exploit.
 
 The default value is 1.
 
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 3191434057f3..26cb87cf492d 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1972,8 +1972,14 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 	struct userfaultfd_ctx *ctx;
 	int fd;
 
-	if (!sysctl_unprivileged_userfaultfd && !capable(CAP_SYS_PTRACE))
-		return -EPERM;
+	switch (sysctl_unprivileged_userfaultfd) {
+	case 2:
+		if (flags & UFFD_USER_MODE_ONLY)
+			break;
+	case 0:
+		if (!capable(CAP_SYS_PTRACE))
+			return -EPERM;
+	}
 
 	BUG_ON(!current->mm);
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 287862f91717..7e94215dfff5 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -3119,7 +3119,7 @@ static struct ctl_table vm_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.extra2		= &two,
 	},
 #endif
 	{ }
-- 
2.28.0.297.g1956fa8f8d-goog

