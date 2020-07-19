Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28817225125
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jul 2020 12:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgGSKGR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jul 2020 06:06:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27682 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726740AbgGSKGR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jul 2020 06:06:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595153175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wxce+VwXiIcE8UT4ez/b1VcACIitQWC3XQJlM+SStW8=;
        b=gxW1KJ00WBn9ImC7wMdBXwYssWBLZy3dHk7hZOOcvmQr+aIHdYU/gZeEuHmj8WyG39gnF6
        OKJhhaHuZTVBud993JMokm3vfE+48ivOk4zvksshMOUhTgySmd4dTR+qQxCLzjv2/dvZh1
        E/48d3v/0gCTg9sLbT0R+ggqqsuYcoo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-UitH46J6NCKpZOZIfSx9Mg-1; Sun, 19 Jul 2020 06:06:11 -0400
X-MC-Unique: UitH46J6NCKpZOZIfSx9Mg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 428EA800C64;
        Sun, 19 Jul 2020 10:06:08 +0000 (UTC)
Received: from dcbz.redhat.com (ovpn-112-10.ams2.redhat.com [10.36.112.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 64C7573044;
        Sun, 19 Jul 2020 10:05:58 +0000 (UTC)
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
Subject: [PATCH v6 5/7] prctl: Allow local CAP_CHECKPOINT_RESTORE to change /proc/self/exe
Date:   Sun, 19 Jul 2020 12:04:15 +0200
Message-Id: <20200719100418.2112740-6-areber@redhat.com>
In-Reply-To: <20200719100418.2112740-1-areber@redhat.com>
References: <20200719100418.2112740-1-areber@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Nicolas Viennot <Nicolas.Viennot@twosigma.com>

Originally, only a local CAP_SYS_ADMIN could change the exe link,
making it difficult for doing checkpoint/restore without CAP_SYS_ADMIN.
This commit adds CAP_CHECKPOINT_RESTORE in addition to CAP_SYS_ADMIN
for permitting changing the exe link.

The following describes the history of the /proc/self/exe permission
checks as it may be difficult to understand what decisions lead to this
point.

* [1] May 2012: This commit introduces the ability of changing
  /proc/self/exe if the user is CAP_SYS_RESOURCE capable.
  In the related discussion [2], no clear thread model is presented for
  what could happen if the /proc/self/exe changes multiple times, or why
  would the admin be at the mercy of userspace.

* [3] Oct 2014: This commit introduces a new API to change
  /proc/self/exe. The permission no longer checks for CAP_SYS_RESOURCE,
  but instead checks if the current user is root (uid=0) in its local
  namespace. In the related discussion [4] it is said that "Controlling
  exe_fd without privileges may turn out to be dangerous. At least
  things like tomoyo examine it for making policy decisions (see
  tomoyo_manager())."

* [5] Dec 2016: This commit removes the restriction to change
  /proc/self/exe at most once. The related discussion [6] informs that
  the audit subsystem relies on the exe symlink, presumably
  audit_log_d_path_exe() in kernel/audit.c.

* [7] May 2017: This commit changed the check from uid==0 to local
  CAP_SYS_ADMIN. No discussion.

* [8] July 2020: A PoC to spoof any program's /proc/self/exe via ptrace
  is demonstrated

Overall, the concrete points that were made to retain capability checks
around changing the exe symlink is that tomoyo_manager() and
audit_log_d_path_exe() uses the exe_file path.

Christian Brauner said that relying on /proc/<pid>/exe being immutable (or
guarded by caps) in a sake of security is a bit misleading. It can only
be used as a hint without any guarantees of what code is being executed
once execve() returns to userspace. Christian suggested that in the
future, we could call audit_log() or similar to inform the admin of all
exe link changes, instead of attempting to provide security guarantees
via permission checks. However, this proposed change requires the
understanding of the security implications in the tomoyo/audit subsystems.

[1] b32dfe377102 ("c/r: prctl: add ability to set new mm_struct::exe_file")
[2] https://lore.kernel.org/patchwork/patch/292515/
[3] f606b77f1a9e ("prctl: PR_SET_MM -- introduce PR_SET_MM_MAP operation")
[4] https://lore.kernel.org/patchwork/patch/479359/
[5] 3fb4afd9a504 ("prctl: remove one-shot limitation for changing exe link")
[6] https://lore.kernel.org/patchwork/patch/697304/
[7] 4d28df6152aa ("prctl: Allow local CAP_SYS_ADMIN changing exe_file")
[8] https://github.com/nviennot/run_as_exe

Signed-off-by: Nicolas Viennot <Nicolas.Viennot@twosigma.com>
Signed-off-by: Adrian Reber <areber@redhat.com>
---
 kernel/sys.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index 00a96746e28a..a3f4ef0bbda3 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2007,11 +2007,14 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
 
 	if (prctl_map.exe_fd != (u32)-1) {
 		/*
-		 * Make sure the caller has the rights to
-		 * change /proc/pid/exe link: only local sys admin should
-		 * be allowed to.
+		 * Check if the current user is checkpoint/restore capable.
+		 * At the time of this writing, it checks for CAP_SYS_ADMIN
+		 * or CAP_CHECKPOINT_RESTORE.
+		 * Note that a user with access to ptrace can masquerade an
+		 * arbitrary program as any executable, even setuid ones.
+		 * This may have implications in the tomoyo subsystem.
 		 */
-		if (!ns_capable(current_user_ns(), CAP_SYS_ADMIN))
+		if (!checkpoint_restore_ns_capable(current_user_ns()))
 			return -EINVAL;
 
 		error = prctl_set_mm_exe_file(mm, prctl_map.exe_fd);
-- 
2.26.2

