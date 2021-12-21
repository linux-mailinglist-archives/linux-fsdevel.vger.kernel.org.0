Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA45247B851
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 03:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbhLUCSI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Dec 2021 21:18:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32561 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230060AbhLUCSH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Dec 2021 21:18:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640053086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=92jGNB0gro1jXL9B2iwhe5DeDQMLoKCOk9yvZGwt2nw=;
        b=ebjyrqKsvlqP5qqfKXdxS4SyT8TTyBEJqGQSLxu3aadOj/BfA/4AQTspSeA8WsBH4N/KSl
        3bmmQRPPmwoNFMBI4QbvdVFFQBn9t/b/A034LqKWy/5VYL1tTXR7Pr5hHWe0aH7UZpWm0G
        hTmT53dgQsfRECJqsx2kFWAeKzkbHGQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-542-rzYvQeGTNmyk3u_L7d7G2A-1; Mon, 20 Dec 2021 21:18:01 -0500
X-MC-Unique: rzYvQeGTNmyk3u_L7d7G2A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0DC2801B0B;
        Tue, 21 Dec 2021 02:17:59 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B804E2B46A;
        Tue, 21 Dec 2021 02:17:55 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent Vivier <laurent@vivier.eu>,
        YunQiang Su <ysu@wavecomp.com>, Helge Deller <deller@gmx.de>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] exec: Make suid_dumpable apply to SUID/SGID binaries irrespective of invoking users
Date:   Mon, 20 Dec 2021 21:17:44 -0500
Message-Id: <20211221021744.864115-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The begin_new_exec() function checks for SUID or SGID binaries by
comparing effective uid and gid against real uid and gid and using
the suid_dumpable sysctl parameter setting only if either one of them
differs.

In the special case that the uid and/or gid of the SUID/SGID binaries
matches the id's of the user invoking it, the suid_dumpable is not
used and SUID_DUMP_USER will be used instead. The documentation for the
suid_dumpable sysctl parameter does not include that exception and so
this will be an undocumented behavior.

Eliminate this undocumented behavior by adding a flag in the linux_binprm
structure to designate a SUID/SGID binary and use it for determining
if the suid_dumpable setting should be applied or not.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 fs/exec.c               | 6 +++---
 include/linux/binfmts.h | 5 ++++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 537d92c41105..60e02e678fb6 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1344,9 +1344,7 @@ int begin_new_exec(struct linux_binprm * bprm)
 	 * is wrong, but userspace depends on it. This should be testing
 	 * bprm->secureexec instead.
 	 */
-	if (bprm->interp_flags & BINPRM_FLAGS_ENFORCE_NONDUMP ||
-	    !(uid_eq(current_euid(), current_uid()) &&
-	      gid_eq(current_egid(), current_gid())))
+	if (bprm->interp_flags & BINPRM_FLAGS_ENFORCE_NONDUMP || bprm->is_sugid)
 		set_dumpable(current->mm, suid_dumpable);
 	else
 		set_dumpable(current->mm, SUID_DUMP_USER);
@@ -1619,11 +1617,13 @@ static void bprm_fill_uid(struct linux_binprm *bprm, struct file *file)
 	if (mode & S_ISUID) {
 		bprm->per_clear |= PER_CLEAR_ON_SETID;
 		bprm->cred->euid = uid;
+		bprm->is_sugid = 1;
 	}
 
 	if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
 		bprm->per_clear |= PER_CLEAR_ON_SETID;
 		bprm->cred->egid = gid;
+		bprm->is_sugid = 1;
 	}
 }
 
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 049cf9421d83..6d9893c59085 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -41,7 +41,10 @@ struct linux_binprm {
 		 * Set when errors can no longer be returned to the
 		 * original userspace.
 		 */
-		point_of_no_return:1;
+		point_of_no_return:1,
+
+		/* Is a SUID or SGID binary? */
+		is_sugid:1;
 #ifdef __alpha__
 	unsigned int taso:1;
 #endif
-- 
2.27.0

