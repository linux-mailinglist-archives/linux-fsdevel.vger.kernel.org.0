Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7BF0299864
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 22:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbgJZVBG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 17:01:06 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:37237 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729165AbgJZVBG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 17:01:06 -0400
Received: by mail-yb1-f201.google.com with SMTP id h6so12516049ybk.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2020 14:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=7bRLqN/4G8Vg/p+SruLvrAF5HknNrILrTJkN47+Yh/M=;
        b=qUQ0TpNVF/6695W1cT5dGQhemHPYRPVve802NdyObcUXlPd6c3stDHVd1mIZ0R9eYJ
         I2UHv9LxFCZhP1FQrl2GaUQ/WqVYVjm78mGGggW8O/ByiGHopRQQsdKs5sTtwtcCkp46
         MOk84ZlRjr83ZZ9k87sskBOD2HG942PvsYUVgI7IQeuJWQI2h2KstlF/Pv4h1vYubIcT
         MQkOFXtVZGdnGk54/ur9rHHGX/e6t3nK7EPjyfMP/jNDHvB5B6/aHlor6ouyhvhDrqRj
         sRAZM7Z0rqozcZl7nJIydgV4bijKcNwphJY5Y6H4rlZ8nMiuq7P1Os+JIxxLJ370EIdB
         XBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7bRLqN/4G8Vg/p+SruLvrAF5HknNrILrTJkN47+Yh/M=;
        b=Uek8OXomdohLvbpkNXLvysWqhFwh363+ruV20a0AFKEsXXnnawpM52HIXR8bbjGyr+
         0NBw2iGRkFWfaY+/xrd3lBTlOTelGU8oV4Gk62yXWqY2PUVoZUZAhkjogazNR2ASk1Va
         d//amyOXMfopPbWmsM5UBr6hZRA3QiAp+ibz/WTiUFUOvADMBKa65K9AfXGX2SnFZwSR
         yXV0BsemM0WOnWOv8t5CFl/nhVrqW/xzFw9ABSHaJ18dJb5JExZS/fRTTJGadXStnlVU
         62HpCenjIk3G0CN5o5/MEmMAQ3OkCHZs6hM0NXiq0E7algpwP8beh7rHFcPOWpOe2ATE
         FeLw==
X-Gm-Message-State: AOAM530SsA1LmZhiJ6xbfJFgeUnYkrIwh2EwH6aJdiYr4ZbbMWCJ3pXl
        nrtMPAzVlRqBn26VKDF2sc+p2pLFsE0eX00lKQ==
X-Google-Smtp-Source: ABdhPJwJFVtsOUaTVRuXfb3Nz4/S8X9LHGpjLsx9VPYaqBfCR0ehkImK/3tlePxr6gX82slucTbmbk948IwHR51PXw==
Sender: "lokeshgidra via sendgmr" <lokeshgidra@lg.mtv.corp.google.com>
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:29dd])
 (user=lokeshgidra job=sendgmr) by 2002:a25:1c1:: with SMTP id
 184mr26679062ybb.243.1603746062678; Mon, 26 Oct 2020 14:01:02 -0700 (PDT)
Date:   Mon, 26 Oct 2020 14:00:52 -0700
In-Reply-To: <20201026210052.3775167-1-lokeshgidra@google.com>
Message-Id: <20201026210052.3775167-3-lokeshgidra@google.com>
Mime-Version: 1.0
References: <20201026210052.3775167-1-lokeshgidra@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH v6 2/2] Add user-mode only option to unprivileged_userfaultfd
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

This enables administrators to reduce the likelihood that an attacker
with access to userfaultfd can delay faulting kernel code to widen
timing windows for other exploits.

The default value of this knob is changed to 0. This is required for
correct functioning of pipe mutex. However, this will fail postcopy
live migration, which will be unnoticeable to the VM guests. To avoid
this, set 'vm.userfault = 1' in /sys/sysctl.conf.

The main reason this change is desirable as in the short term is that
the Android userland will behave as with the sysctl set to zero. So
without this commit, any Linux binary using userfaultfd to manage its
memory would behave differently if run within the Android userland.
For more details, refer to Andrea's reply [1].

[1] https://lore.kernel.org/lkml/20200904033438.GI9411@redhat.com/

Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
Reviewed-by: Andrea Arcangeli <aarcange@redhat.com>
---
 Documentation/admin-guide/sysctl/vm.rst | 15 ++++++++++-----
 fs/userfaultfd.c                        | 10 ++++++++--
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index f455fa00c00f..d06a98b2a4e7 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -873,12 +873,17 @@ file-backed pages is less than the high watermark in a zone.
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
index 605599fde015..894cc28142e7 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -28,7 +28,7 @@
 #include <linux/security.h>
 #include <linux/hugetlb.h>
 
-int sysctl_unprivileged_userfaultfd __read_mostly = 1;
+int sysctl_unprivileged_userfaultfd __read_mostly;
 
 static struct kmem_cache *userfaultfd_ctx_cachep __read_mostly;
 
@@ -1966,8 +1966,14 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 	struct userfaultfd_ctx *ctx;
 	int fd;
 
-	if (!sysctl_unprivileged_userfaultfd && !capable(CAP_SYS_PTRACE))
+	if (!sysctl_unprivileged_userfaultfd &&
+	    (flags & UFFD_USER_MODE_ONLY) == 0 &&
+	    !capable(CAP_SYS_PTRACE)) {
+		printk_once(KERN_WARNING "uffd: Set unprivileged_userfaultfd "
+			"sysctl knob to 1 if kernel faults must be handled "
+			"without obtaining CAP_SYS_PTRACE capability\n");
 		return -EPERM;
+	}
 
 	BUG_ON(!current->mm);
 
-- 
2.29.0.rc1.297.gfa9743e501-goog

