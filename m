Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F0F1ED446
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jun 2020 18:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgFCQYr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jun 2020 12:24:47 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30195 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726296AbgFCQYq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jun 2020 12:24:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591201485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cXciDkK7OoMQ0gJnd5P/3MbteHCW4WYolIjWhTKn9Z0=;
        b=C+Obht5Pa4PNdV1LcaaYEADbY9ygnIEwkqoDENvrwMu7hvN2pC7SpsqYeGw/UNPJRcnGQh
        Czj/nGDhtsNckVeaYjMZ/UAhnq+yBDs1Zxu6uGZCcrzIh4zC+yy0AerMFcnysutGGzwvEn
        ajfEVX9N8ogmT+KlA9gtKG3DjkbrGhI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-RG2C8sGoMUe5_ujS4Peu8g-1; Wed, 03 Jun 2020 12:24:43 -0400
X-MC-Unique: RG2C8sGoMUe5_ujS4Peu8g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54702EC1A2;
        Wed,  3 Jun 2020 16:24:40 +0000 (UTC)
Received: from dcbz.redhat.com (ovpn-113-67.ams2.redhat.com [10.36.113.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 96B6119C71;
        Wed,  3 Jun 2020 16:24:30 +0000 (UTC)
From:   Adrian Reber <areber@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        =?UTF-8?q?Micha=C5=82=20C=C5=82api=C5=84ski?= 
        <mclapinski@google.com>, Kamil Yurtsever <kyurtsever@google.com>,
        Dirk Petersen <dipeit@gmail.com>,
        Christine Flood <chf@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Adrian Reber <areber@redhat.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 3/3] prctl: Allow ptrace capable processes to change exe_fd
Date:   Wed,  3 Jun 2020 18:23:28 +0200
Message-Id: <20200603162328.854164-4-areber@redhat.com>
In-Reply-To: <20200603162328.854164-1-areber@redhat.com>
References: <20200603162328.854164-1-areber@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Nicolas Viennot <Nicolas.Viennot@twosigma.com>

The current process is authorized to change its /proc/self/exe link via
two policies:
1) The current user can do checkpoint/restore In other words is
   CAP_SYS_ADMIN or CAP_CHECKPOINT_RESTORE capable.
2) The current user can use ptrace.

With access to ptrace facilities, a process can do the following: fork a
child, execve() the target executable, and have the child use ptrace()
to replace the memory content of the current process. This technique
makes it possible to masquerade an arbitrary program as any executable,
even setuid ones.

This commit also changes the permission error code from -EINVAL to
-EPERM for consistency with the rest of the prctl() syscall when
checking capabilities.

Signed-off-by: Nicolas Viennot <Nicolas.Viennot@twosigma.com>
Signed-off-by: Adrian Reber <areber@redhat.com>
---
 kernel/sys.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index fd46865b46ba..2f34108e26e0 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1994,12 +1994,23 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
 
 	if (prctl_map.exe_fd != (u32)-1) {
 		/*
-		 * Make sure the caller has the rights to
-		 * change /proc/pid/exe link: only local sys admin should
-		 * be allowed to.
+		 * The current process is authorized to change its
+		 * /proc/self/exe link via two policies:
+		 * 1) The current user can do checkpoint/restore
+		 *    In other words is CAP_SYS_ADMIN or
+		 *    CAP_CHECKPOINT_RESTORE capable.
+		 * 2) The current user can use ptrace.
+		 *
+		 * With access to ptrace facilities, a process can do the
+		 * following: fork a child, execve() the target executable,
+		 * and have the child use ptrace() to replace the memory
+		 * content of the current process. This technique makes it
+		 * possible to masquerade an arbitrary program as the target
+		 * executable, even if it is setuid.
 		 */
-		if (!ns_capable(current_user_ns(), CAP_SYS_ADMIN))
-			return -EINVAL;
+		if (!(checkpoint_restore_ns_capable(current_user_ns()) ||
+		      security_ptrace_access_check(current, PTRACE_MODE_ATTACH_REALCREDS)))
+			return -EPERM;
 
 		error = prctl_set_mm_exe_file(mm, prctl_map.exe_fd);
 		if (error)
-- 
2.26.2

