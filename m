Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0CE193428
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Mar 2020 00:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbgCYXDy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 19:03:54 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:56867 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbgCYXDx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 19:03:53 -0400
Received: by mail-pl1-f201.google.com with SMTP id ba5so2821500plb.23
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2020 16:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NvPoNDqt/FtxcJkV8j34y/lYvSuomfgx7WmZT8gVSSI=;
        b=t2o7JXy6smRSIz1Gof8XTM1mwfU4ibv7GB/FwKt0T9Ic9FsXuqErsqSRXcgIYxhCtw
         qV59nSIKz7sbvDk6aFEi5WuCNKeiKiBl7L6ezlLl4NdtcYN3LBtOtAzkKX+UMfn5CJ/a
         3tO9v4eBXJnHXx6acNqbCEj3JE0Iprd4DulA5Pmc3YygJ6jh3QdOG19BgyGY2mvNM75r
         oqRKCbFGw1fN/lSF34NwbDA3gDZK07IoyTRMsl/8RRQwSBdTupYcdNMMPCLgSQ5gf8MX
         I3zW20Tk6Y78ZynrY2eLb4g6a4mC7ddBMlA8jur2LvN325K6PqhQghfwQfZmF63bETjs
         VbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NvPoNDqt/FtxcJkV8j34y/lYvSuomfgx7WmZT8gVSSI=;
        b=iYTbuDdkKTMHr794OkPtfpxi94uxqALktPmhKyUgqAP/JBTJt7Uwke6QuBehRohOJR
         Fu2524whylsVXQaZN8rs93NOaYii4xQs7x4FldGpgPCqYsYxYHcKLQul7UkXSx9mwWvP
         B1HlsiyMj9Yo/jAC8FS56Wwgnm1of6ur2qFZYpXlgBBQzpVgdFQLFJFAylrfY0qMBh2v
         EnJvzbUVR1SZ7eFMvKoA/jm4cXfcVqXppdnFaOry06V1b+rLCfFiGeQmAhqx/OtaPF5L
         sU28OBY+vUHY2Hhu/NqkERKjJA1Q46+tZEJ1uNXxk63U8ap0bWDyiO7r7Y2lG4q5xYRf
         +5Gw==
X-Gm-Message-State: ANhLgQ3W3VR8QcuLLOG1WNTBvw/fHlI/5lkvngjeWAc6OZYnotyNKTA6
        8rnc4SRAzW+US0KEfyOU9ikx8SGlXEg=
X-Google-Smtp-Source: ADFU+vucmD0Yz2UW/2xYbr0QyEKdkrlHqcCxt3u/qpa+E0wkrqbKGWIfaK2NSVY0SRYNCtko5UlfpW5yfws=
X-Received: by 2002:a63:28c:: with SMTP id 134mr5251204pgc.165.1585177430117;
 Wed, 25 Mar 2020 16:03:50 -0700 (PDT)
Date:   Wed, 25 Mar 2020 16:02:47 -0700
In-Reply-To: <20200214032635.75434-1-dancol@google.com>
Message-Id: <20200325230245.184786-3-dancol@google.com>
Mime-Version: 1.0
References: <20200214032635.75434-1-dancol@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v2 2/3] Teach SELinux about anonymous inodes
From:   Daniel Colascione <dancol@google.com>
To:     timmurray@google.com, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, viro@zeniv.linux.org.uk, paul@paul-moore.com,
        nnk@google.com, sds@tycho.nsa.gov, lokeshgidra@google.com
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
type_transition sysadm_t sysadm_t : file uffd_t "[userfaultfd]";
allow sysadm_t uffd_t:file { create };

(The next patch in this series is necessary for making userfaultfd
support this new interface.  The example above is just
for exposition.)

Signed-off-by: Daniel Colascione <dancol@google.com>
---
 security/selinux/hooks.c            | 54 +++++++++++++++++++++++++++++
 security/selinux/include/classmap.h |  2 ++
 2 files changed, 56 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 1659b59fb5d7..b9eb45c2e4e5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2915,6 +2915,59 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 	return 0;
 }
 
+static int selinux_inode_init_security_anon(struct inode *inode,
+					    const struct qstr *name,
+					    const struct file_operations *fops,
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
+			SECCLASS_FILE, name, &isec->sid);
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
@@ -6923,6 +6976,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 
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

