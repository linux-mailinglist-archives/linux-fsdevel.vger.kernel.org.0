Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7791128A5EE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Oct 2020 08:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgJKGZK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Oct 2020 02:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgJKGZH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Oct 2020 02:25:07 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78D5C0613CE
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Oct 2020 23:25:06 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id e19so10236808qtq.17
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Oct 2020 23:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=5fGPuFwLHe/GLon7KcEGj+q06IZAPIH4nCR0GWMNees=;
        b=iuK2qujS2Wpb/UqMfnOeCjgHvZ1IsRGnt0EmpuwPtogcu4rNijokbrOyxMBpdb9OAK
         85ZHfXv1VPQNQdn1y41zmpAAmWpNR40EPAMVSaiKmahqGdI55+GfXLwGSXuYmI41+d37
         mTvdq6tLM9FgV7Sr3lLamNKbDZzCDB0bEup8RZg/XsEMsawRG0IbvaT3zFghbjRIY8CU
         HsQo72JTpSux84TMMpY3ZwnfkMeBWZusK9Bqzx2ZlC3qbUKbRU+hl7cLM4nkoJvVMw9J
         qfa01qh2VDH/dee9xBYEYl4LGHYvW7GcqzTeABvB/1rlz3VFA/pXUrZIxZzqMzrgfiO2
         L3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5fGPuFwLHe/GLon7KcEGj+q06IZAPIH4nCR0GWMNees=;
        b=eZMKA+PWonzsU/GHFfpnO8xyT+0D0mBmuXjW+3Xhqo28STMbMvWKccg+58NycT3Uxi
         LrrUaM2qQx8okuSpnfirbyuLroaS5XDiWA6ciI/VVmvK+hbEeOEu+mDe5jmIIWW7ycJP
         MenQqfXC7DWbKdmEFPMc7rhqo5OC4B2qgWh2L62n9ylzbzEW/PiYlAA0/E88MrZ8RZdP
         dAx69ZC4YTGEYbwcd1r6anQMhSR+XHe71PFjq7aPgZG0tr77JV5eP0hVWYLv7K43z/Va
         h/SO+znFI/krREFuA9g0VjzR+UJHVSjNPFceVGWjR3gMoGGjjjbWttDatajG1xz5veSq
         vh9g==
X-Gm-Message-State: AOAM533e/ZhsU/oj7vG6npZO8knL90Rp7kyvVlOfr8p3/Tac0W+JZpNp
        5jMehrMbIyC8DsdczoZzVcrCY3c2flsTCX6xFA==
X-Google-Smtp-Source: ABdhPJwT/P3/Fh36zKb/0qLPFkU8c3uzBjOUT7W2zQEYpKzol1aZwZdzOhkr0Y/f/ACdpO1wkyJGoNMDZQeurtOaJA==
Sender: "lokeshgidra via sendgmr" <lokeshgidra@lg.mtv.corp.google.com>
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:29dd])
 (user=lokeshgidra job=sendgmr) by 2002:a0c:fca9:: with SMTP id
 h9mr20337980qvq.30.1602397506018; Sat, 10 Oct 2020 23:25:06 -0700 (PDT)
Date:   Sat, 10 Oct 2020 23:24:56 -0700
In-Reply-To: <20201011062456.4065576-1-lokeshgidra@google.com>
Message-Id: <20201011062456.4065576-3-lokeshgidra@google.com>
Mime-Version: 1.0
References: <20201011062456.4065576-1-lokeshgidra@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v5 2/2] Add user-mode only option to unprivileged_userfaultfd
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
index bd229f06d4e9..0f8a975db3be 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -28,7 +28,7 @@
 #include <linux/security.h>
 #include <linux/hugetlb.h>
 
-int sysctl_unprivileged_userfaultfd __read_mostly = 1;
+int sysctl_unprivileged_userfaultfd __read_mostly;
 
 static struct kmem_cache *userfaultfd_ctx_cachep __read_mostly;
 
@@ -1976,7 +1976,9 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 	struct userfaultfd_ctx *ctx;
 	int fd;
 
-	if (!sysctl_unprivileged_userfaultfd && !capable(CAP_SYS_PTRACE))
+	if (!sysctl_unprivileged_userfaultfd &&
+	    (flags & UFFD_USER_MODE_ONLY) == 0 &&
+	    !capable(CAP_SYS_PTRACE))
 		return -EPERM;
 
 	BUG_ON(!current->mm);
-- 
2.28.0.1011.ga647a8990f-goog

