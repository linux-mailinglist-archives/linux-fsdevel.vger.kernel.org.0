Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3279480522
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Dec 2021 23:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbhL0Whe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Dec 2021 17:37:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27747 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233819AbhL0Whe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Dec 2021 17:37:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640644653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oRQiwqjB0NQi4Sdbyi3eqHG7nJYYCHzMQstJ4Dw6XnM=;
        b=K2OdjMnKAkHABzMJac2IDR3CJXOHB02spONVAqvmFt/+JMB8kaaewpEK//0o4s+DF+/kXM
        PfzKbWSmrMXQIwtJfGGKyfW2tpJZJDdOCiVkTgvsXQadPNuO9A5e0YlpycZ2neXnel1KOb
        RqJWJhGJyjvOvcVz56Y/NSAApaiAp6M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-150-YAFzHXULPnKfsmnBuVDelg-1; Mon, 27 Dec 2021 17:37:30 -0500
X-MC-Unique: YAFzHXULPnKfsmnBuVDelg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27031102CB3D;
        Mon, 27 Dec 2021 22:37:28 +0000 (UTC)
Received: from wcosta.com (ovpn-116-95.gru2.redhat.com [10.97.116.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A5B178D8F;
        Mon, 27 Dec 2021 22:36:55 +0000 (UTC)
From:   Wander Lairson Costa <wander@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Laurent Vivier <laurent@vivier.eu>,
        Wander Lairson Costa <wander@redhat.com>,
        YunQiang Su <ysu@wavecomp.com>, Helge Deller <deller@gmx.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Rafael Aquini <aquini@redhat.com>,
        Phil Auld <pauld@redhat.com>, Rolf Eike Beer <eb@emlix.com>,
        Muchun Song <songmuchun@bytedance.com>,
        linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and
        infrastructure)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH RFC 3/4] coredump: mitigate privilege escalation of process coredump
Date:   Mon, 27 Dec 2021 19:34:34 -0300
Message-Id: <20211227223436.317091-4-wander@redhat.com>
In-Reply-To: <20211227223436.317091-1-wander@redhat.com>
References: <20211227223436.317091-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
index 07afb5ddb1c4..74eae7bd144d 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -580,6 +580,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 	struct core_name cn;
 	struct mm_struct *mm = current->mm;
 	struct linux_binfmt * binfmt;
+	struct inode *pwd_inode;
 	const struct cred *old_cred;
 	struct cred *cred;
 	int retval = 0;
@@ -625,6 +626,20 @@ void do_coredump(const kernel_siginfo_t *siginfo)
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

