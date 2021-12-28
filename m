Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073AF480BE9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Dec 2021 18:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236688AbhL1RM1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Dec 2021 12:12:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50173 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235870AbhL1RM1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Dec 2021 12:12:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640711546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K2bAtOvojdga/7paLAB6jMZTvffzBYx7Nr0h6WOmw3s=;
        b=aJVNq34Q7L11xZmh2DWeNfzerhpwhoIFYi0XTrAmFy2Cu13mvpELsraP+iAp66Nxr+JASN
        zBiqAKCFJ6E4J6GGZqSrrc95kFlIb8nu7HUo2Fc9mzRNZjOVSJpMANX/BglRVWQd1QJCug
        +K9J4sOIOUVcn6kubKtCaTBi9Q+7XWQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-iizx6YkiMZW0EyZFpaH5MA-1; Tue, 28 Dec 2021 12:12:23 -0500
X-MC-Unique: iizx6YkiMZW0EyZFpaH5MA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22044102C8A0;
        Tue, 28 Dec 2021 17:12:21 +0000 (UTC)
Received: from wcosta.com (ovpn-116-95.gru2.redhat.com [10.97.116.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2057177440;
        Tue, 28 Dec 2021 17:11:29 +0000 (UTC)
From:   Wander Lairson Costa <wander@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        YunQiang Su <ysu@wavecomp.com>,
        Laurent Vivier <laurent@vivier.eu>,
        Wander Lairson Costa <wander@redhat.com>,
        Helge Deller <deller@gmx.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        David Hildenbrand <david@redhat.com>,
        Rolf Eike Beer <eb@emlix.com>,
        linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and
        infrastructure)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH RFC v2 3/4] coredump: mitigate privilege escalation of process coredump
Date:   Tue, 28 Dec 2021 14:09:07 -0300
Message-Id: <20211228170910.623156-4-wander@redhat.com>
In-Reply-To: <20211228170910.623156-1-wander@redhat.com>
References: <20211228170910.623156-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A set-uid executable might be a vector to a privilege escalation if the
system configures the coredump file name pattern as a relative
directory destiny. The full description of the vulnerability and
a demonstration of how we can exploit it can be found at [1].

We now check if the core dump pattern is relative. If it is, then we
verify if root owns the current directory and if it does, we deny
writing the core file unless the directory is universally writable.

[1] https://www.openwall.com/lists/oss-security/2021/10/20/2

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 fs/coredump.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/coredump.c b/fs/coredump.c
index a6b3c196cdef..26bea87af153 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -514,6 +514,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 	struct core_name cn;
 	struct mm_struct *mm = current->mm;
 	struct linux_binfmt * binfmt;
+	struct inode *pwd_inode;
 	const struct cred *old_cred;
 	struct cred *cred;
 	int retval = 0;
@@ -559,6 +560,20 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		need_suid_safe = true;
 	}
 
+	/*
+	 * If we are a set-uid/gid root process and the current directory is
+	 * owned by root but not universally writable, prohibit dumps under
+	 * this path.
+	 *
+	 * Mitigate https://www.openwall.com/lists/oss-security/2021/10/20/2
+	 */
+	pwd_inode = current->fs->pwd.dentry->d_inode;
+	if (current->flags & PF_SUID &&
+	    capable(CAP_SYS_ADMIN) &&
+	    uid_eq(pwd_inode->i_uid, GLOBAL_ROOT_UID) &&
+	    !(pwd_inode->i_mode & 0002))
+		need_suid_safe = true;
+
 	retval = coredump_wait(siginfo->si_signo, &core_state);
 	if (retval < 0)
 		goto fail_creds;
-- 
2.27.0

