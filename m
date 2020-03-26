Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D033E194853
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Mar 2020 21:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbgCZUGv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Mar 2020 16:06:51 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:43302 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728750AbgCZUGu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Mar 2020 16:06:50 -0400
Received: by mail-qk1-f201.google.com with SMTP id w195so5969156qkb.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2020 13:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jxOc9o6NdvdCnjWFdn8kUz8yJ8bzL6ZGVJ74OA5uXfY=;
        b=Ffjr9V6LlkXfWH5QWPvkkOxpxxaPg2dBmP9aODBfh2MLONLCpKoT5k6cl3xcUKMvoK
         RQzzut1js/XvxLH1WYNzXDMxzX/EUHXmEsJjRsd0rxdpdtySLJicp7wXKmiALgbYim3E
         6+WdDcZIplOzHSme1fEbEIyao/XjxmX4fDidOvBTabMGEHqP9x9xqJls0Ih4lpPheMUE
         SThJQS41nDzmr15P9GPI0LlcZCAHx3mEzRVxzGHnuqrdlfKC9JYb69H4B7ke/lcJyHhW
         74YCrn8uaVita3ZLizNU2C8Qiv8rvRuFk4BSMQKezoD4iCwQC6QACAFgpb0AjRumR3ud
         DgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jxOc9o6NdvdCnjWFdn8kUz8yJ8bzL6ZGVJ74OA5uXfY=;
        b=EMSfwEHqF305WTa1zGoQOmuVF91V7rPpWwmC6j2tnPd0ZVAowDAXuBkiHIkKrnZgDe
         65U8TEfSNSP+3vGH7+ohS/4Gr1mwMmhY+WaVqVpaQAkc6zLIsE6fAixV3BvPc4dscZye
         j3L84Z6+A9nDer2y3I9XU8QhzEHOKLl8ZbtntA1keLYAKSZrvGumxpbmKahTtvl10o4Q
         rpsKdFU/MmK+kPY5opEKt0qe0avX22A3rGOhyneAjLcWEeaq63j0TVmWCwOoeFQvLAHc
         0p0GNCRaybA2pyJQwnuVCQKjndn27D2YUi9GGbLWKAXn8uhsx89v7vHRyCSULB3D1YEO
         Naaw==
X-Gm-Message-State: ANhLgQ18rPYK4g7pcNFgI7dAqkcfHnug06woOzQP98BGGLWXrChpGEOF
        x1XOW9nHM9ZMjBqdBGbc8CGxTg2kSVM=
X-Google-Smtp-Source: ADFU+vvaexDqyLY8GoD+ICFTM/vR7zLUOM6FxoFEd6oCKQxs/tDvOvNnpUYgLbAaeb0sHk5Q7eX0naECVtc=
X-Received: by 2002:ac8:1c17:: with SMTP id a23mr10721235qtk.239.1585253209979;
 Thu, 26 Mar 2020 13:06:49 -0700 (PDT)
Date:   Thu, 26 Mar 2020 13:06:33 -0700
In-Reply-To: <20200326200634.222009-1-dancol@google.com>
Message-Id: <20200326200634.222009-3-dancol@google.com>
Mime-Version: 1.0
References: <20200326181456.132742-1-dancol@google.com> <20200326200634.222009-1-dancol@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v4 2/3] Teach SELinux about anonymous inodes
From:   Daniel Colascione <dancol@google.com>
To:     timmurray@google.com, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, viro@zeniv.linux.org.uk, paul@paul-moore.com,
        nnk@google.com, sds@tycho.nsa.gov, lokeshgidra@google.com,
        jmorris@namei.org
Cc:     Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This change uses the anon_inodes and LSM infrastructure introduced in
the previous patch to give SELinux the ability to control
anonymous-inode files that are created using the new _secure()
anon_inodes functions.

A SELinux policy author detects and controls these anonymous inodes by
adding a name-based type_transition rule that assigns a new security
type to anonymous-inode files created in some domain. The name used
for the name-based transition is the name associated with the
anonymous inode for file listings --- e.g., "[userfaultfd]" or
"[perf_event]".

Example:

type uffd_t;
type_transition sysadm_t sysadm_t : anon_inode uffd_t "[userfaultfd]";
allow sysadm_t uffd_t:anon_inode { create };

(The next patch in this series is necessary for making userfaultfd
support this new interface.  The example above is just
for exposition.)

Signed-off-by: Daniel Colascione <dancol@google.com>
---
 security/selinux/hooks.c            | 53 +++++++++++++++++++++++++++++
 security/selinux/include/classmap.h |  2 ++
 2 files changed, 55 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 1659b59fb5d7..6f7222d2e404 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2915,6 +2915,58 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 	return 0;
 }
 
+static int selinux_inode_init_security_anon(struct inode *inode,
+					    const struct qstr *name,
+					    const struct inode *context_inode)
+{
+	const struct task_security_struct *tsec = selinux_cred(current_cred());
+	struct common_audit_data ad;
+	struct inode_security_struct *isec;
+	int rc;
+
+	if (unlikely(!selinux_state.initialized))
+		return 0;
+
+	isec = selinux_inode(inode);
+
+	/*
+	 * We only get here once per ephemeral inode.  The inode has
+	 * been initialized via inode_alloc_security but is otherwise
+	 * untouched.
+	 */
+
+	if (context_inode) {
+		struct inode_security_struct *context_isec =
+			selinux_inode(context_inode);
+		isec->sclass = context_isec->sclass;
+		isec->sid = context_isec->sid;
+	} else {
+		isec->sclass = SECCLASS_ANON_INODE;
+		rc = security_transition_sid(
+			&selinux_state, tsec->sid, tsec->sid,
+			isec->sclass, name, &isec->sid);
+		if (rc)
+			return rc;
+	}
+
+	isec->initialized = LABEL_INITIALIZED;
+
+	/*
+	 * Now that we've initialized security, check whether we're
+	 * allowed to actually create this type of anonymous inode.
+	 */
+
+	ad.type = LSM_AUDIT_DATA_INODE;
+	ad.u.inode = inode;
+
+	return avc_has_perm(&selinux_state,
+			    tsec->sid,
+			    isec->sid,
+			    isec->sclass,
+			    FILE__CREATE,
+			    &ad);
+}
+
 static int selinux_inode_create(struct inode *dir, struct dentry *dentry, umode_t mode)
 {
 	return may_create(dir, dentry, SECCLASS_FILE);
@@ -6923,6 +6975,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 
 	LSM_HOOK_INIT(inode_free_security, selinux_inode_free_security),
 	LSM_HOOK_INIT(inode_init_security, selinux_inode_init_security),
+	LSM_HOOK_INIT(inode_init_security_anon, selinux_inode_init_security_anon),
 	LSM_HOOK_INIT(inode_create, selinux_inode_create),
 	LSM_HOOK_INIT(inode_link, selinux_inode_link),
 	LSM_HOOK_INIT(inode_unlink, selinux_inode_unlink),
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 986f3ac14282..263750b6aaac 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -248,6 +248,8 @@ struct security_class_mapping secclass_map[] = {
 	  {"open", "cpu", "kernel", "tracepoint", "read", "write"} },
 	{ "lockdown",
 	  { "integrity", "confidentiality", NULL } },
+	{ "anon_inode",
+	  { COMMON_FILE_PERMS, NULL } },
 	{ NULL }
   };
 
-- 
2.25.1.696.g5e7596f4ac-goog

