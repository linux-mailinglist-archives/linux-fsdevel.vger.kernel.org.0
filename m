Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0462EED2B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jan 2021 06:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbhAHFen (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jan 2021 00:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbhAHFem (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jan 2021 00:34:42 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B83C0612A4
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Jan 2021 21:33:08 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id j5so7407583qvu.22
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Jan 2021 21:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=yvxLkMrnVxRSxC9KzTyVpuuqR+pCEABEK4TkVEGjmlM=;
        b=n8QszcMrbIG1zQA/diOQYNUs4mCdtg1DOV6tjUlQ2lnb4Xk+zOC4rmCdSfLa9SsHTD
         1PprmyzinG1EOt3nJpebsLKdEdyvjZF1F2BghDq1S2ORAkTIkdEJwNxahywA9jft0xdc
         qoak145AZ6+a7UTh1S/Blc9JyXlsfKx5CdBSA3KY6OXoln7cuH1RKIP2mHO8XZNcHnx8
         0pUcd4G6FGfYHob7nD7B/DTyCajiHZO9AAZ1DQA+d20psDVp27zaZ7Lv9bciaxH6jXfl
         TaDmcjn4rcZXDa5tf2lupNo7K2quDgoTMdE8NA+fLHyo30TSP/nFPac46ZWyAj1+rmzP
         vVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yvxLkMrnVxRSxC9KzTyVpuuqR+pCEABEK4TkVEGjmlM=;
        b=mDAR+NI0LL3SAulzPd0Ht9JuN+wGJSykQdoegfC5T8kX7T8UY0yaelyW9QZSK3bGco
         k9MrTke1nFVY65ECKyb3tw3F+FB7T+4C3S5nVH41VBAC37UoWxucLnfxJZtJeHvjn93P
         l0ds/rwWSaDLe/lEUgpDxf5eHXSjBhOLd2h7hn2Ztcs5771jC2JXEPtDdGkL6A2aHb51
         JSkQV2xH93Gs/EM4Bp09JC+BBR8T6eyXRxLC1ai5sOqpf6Q+bRuWqcgxvvKB++hkXfFS
         i7ThlXtkVXRMfmJDSSdnsHiCThCZgrf3Hk+8uzSw+1GenIvXEm/ryOFY050uEImCTdgT
         2iug==
X-Gm-Message-State: AOAM532W/qkUSESn6szUPOpNvaq/A6f2lKwS1lR5TvqPv9StJ7HM0Cyw
        f80T6AEjolgeNZcYYurSjxytFz+lHSHvTQH0gQ==
X-Google-Smtp-Source: ABdhPJzuOALQVMCIPqy/so0d6XS8F91KbIKIZiO0eWllFdMIerQfL+846wVfHQfzbGT2UDcMBAacWRe/HHphle9OEg==
Sender: "lokeshgidra via sendgmr" <lokeshgidra@lg.mtv.corp.google.com>
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:29dd])
 (user=lokeshgidra job=sendgmr) by 2002:a0c:a905:: with SMTP id
 y5mr1983204qva.55.1610083987068; Thu, 07 Jan 2021 21:33:07 -0800 (PST)
Date:   Thu,  7 Jan 2021 21:32:58 -0800
In-Reply-To: <20210108053259.726613-1-lokeshgidra@google.com>
Message-Id: <20210108053259.726613-4-lokeshgidra@google.com>
Mime-Version: 1.0
References: <20210108053259.726613-1-lokeshgidra@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v14 3/4] selinux: teach SELinux about anonymous inodes
From:   Lokesh Gidra <lokeshgidra@google.com>
To:     Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Paul Moore <paul@paul-moore.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Eric Paris <eparis@parisplace.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Daniel Colascione <dancol@dancol.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        KP Singh <kpsingh@google.com>,
        David Howells <dhowells@redhat.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Adrian Reber <areber@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        kaleshsingh@google.com, calin@google.com, surenb@google.com,
        jeffv@google.com, kernel-team@android.com, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>, hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Daniel Colascione <dancol@google.com>

This change uses the anon_inodes and LSM infrastructure introduced in
the previous patches to give SELinux the ability to control
anonymous-inode files that are created using the new
anon_inode_getfd_secure() function.

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
Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
---
 security/selinux/hooks.c            | 59 +++++++++++++++++++++++++++++
 security/selinux/include/classmap.h |  2 +
 2 files changed, 61 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 644b17ec9e63..8b4e155b2930 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2934,6 +2933,63 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
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
+	if (unlikely(!selinux_initialized(&selinux_state)))
+		return 0;
+
+	isec = selinux_inode(inode);
+
+	/*
+	 * We only get here once per ephemeral inode.  The inode has
+	 * been initialized via inode_alloc_security but is otherwise
+	 * untouched.
+	 */
+	isec->initialized = LABEL_INITIALIZED;
+	isec->sclass = SECCLASS_ANON_INODE;
+
+	if (context_inode) {
+		struct inode_security_struct *context_isec =
+			selinux_inode(context_inode);
+		if (context_isec->initialized != LABEL_INITIALIZED)
+			return -EACCES;
+		if (context_isec->sclass != SECCLASS_ANON_INODE) {
+			pr_err("SELinux:  initializing anonymous inode with non-anonymous inode");
+			return -EACCES;
+		}
+
+		isec->sid = context_isec->sid;
+	} else {
+		rc = security_transition_sid(
+			&selinux_state, tsec->sid, tsec->sid,
+			isec->sclass, name, &isec->sid);
+		if (rc)
+			return rc;
+	}
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
+			    ANON_INODE__CREATE,
+			    &ad);
+}
+
 static int selinux_inode_create(struct inode *dir, struct dentry *dentry, umode_t mode)
 {
 	return may_create(dir, dentry, SECCLASS_FILE);
@@ -7000,6 +7057,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 
 	LSM_HOOK_INIT(inode_free_security, selinux_inode_free_security),
 	LSM_HOOK_INIT(inode_init_security, selinux_inode_init_security),
+	LSM_HOOK_INIT(inode_init_security_anon, selinux_inode_init_security_anon),
 	LSM_HOOK_INIT(inode_create, selinux_inode_create),
 	LSM_HOOK_INIT(inode_link, selinux_inode_link),
 	LSM_HOOK_INIT(inode_unlink, selinux_inode_unlink),
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 40cebde62856..ba2e01a6955c 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -249,6 +249,8 @@ struct security_class_mapping secclass_map[] = {
 	  {"open", "cpu", "kernel", "tracepoint", "read", "write"} },
 	{ "lockdown",
 	  { "integrity", "confidentiality", NULL } },
+	{ "anon_inode",
+	  { COMMON_FILE_PERMS, NULL } },
 	{ NULL }
   };
 
-- 
2.30.0.284.gd98b1dd5eaa7-goog

