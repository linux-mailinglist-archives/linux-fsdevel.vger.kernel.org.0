Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815BB2AFE79
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Nov 2020 06:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgKLFiX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Nov 2020 00:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730011AbgKLByg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Nov 2020 20:54:36 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50748C040208
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2020 17:54:15 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id v13so9057ybe.18
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2020 17:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=EKdfgxKmgqyWOrEoFelO0xo4xUprR4kVgmmY5QtMneA=;
        b=Mz0/RepGCaX9VPHW6LKYUdkGuWwDxdRh602UW+erQ9khnSph5lnBFq+8u9tT4GDxaS
         ckxAoj4jIZb/X+96/D7EN4p3mRLqrhrRnE3AxR4nd3qOi6FK1e/Z6XUKmdBv0V52oHoi
         fnRSEC7tE+8O3CSNKd8dbNMYYBVswtN2GpJKmuRoeXfgAY2LAq6yldLOmIxmMhutphYm
         j4fhBnd140Pi1Ckyo33E5c9jKyWfJ37HDd6ORnuKewANEJvZfovjkYwOABiS+IlQOpEn
         QIjD4OMXTdg/iDGYGT+UyppMyuf4rtDyeeBOjhzp9egpqH7d6TWO6igQsuhW95l5hcfa
         uSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EKdfgxKmgqyWOrEoFelO0xo4xUprR4kVgmmY5QtMneA=;
        b=IbxP6lR52gzlogGfMcwNadTZj8sSknXiz510kUPP2koGTzMmrG+k702+GwMV4tXx9n
         aOptnvdIGn2tEHmfxLC2A6ZWhyxbD8OvLHQybyGqCIHjW62d4sR0jpJbu4qud/v+SQo2
         qX6Rxi12h2Qlz9/am5TFT4rCqRwT5CS9/EGO4Pidg7TBoiVXdphi0b2LuBut3grxyLk9
         TK/x+HceHgV/KV6hAAX8OZ4WHo7jyDlQ7vptSvxiMc4Rvr1zEMUyUnahv3DP56ABTfmv
         7bCI3ZrhkR+s9wpga6ETt7hMpC4GKfKUZPqeuFZx5LG+gr4KPjnCRxQ2SiYdXtqwcOq1
         PcTQ==
X-Gm-Message-State: AOAM533n2h2b2XLL2+/WyGYl/AE8yFKIq0Urv73dPDj5HKqMaGZTPvXy
        xi1jIuqU4uArDGH58n8A6BLbHpIWZp9rc38mww==
X-Google-Smtp-Source: ABdhPJzFSv/Xdn7GGdy2MUG7BhSbdefjZ9hVJ+MOvRURjTp6rSFxYr2XLTCAi7JOZcqE2J6h4zH58KP3k6BneY9sdA==
Sender: "lokeshgidra via sendgmr" <lokeshgidra@lg.mtv.corp.google.com>
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:29dd])
 (user=lokeshgidra job=sendgmr) by 2002:a25:bc42:: with SMTP id
 d2mr6737406ybk.461.1605146054397; Wed, 11 Nov 2020 17:54:14 -0800 (PST)
Date:   Wed, 11 Nov 2020 17:53:58 -0800
In-Reply-To: <20201112015359.1103333-1-lokeshgidra@google.com>
Message-Id: <20201112015359.1103333-4-lokeshgidra@google.com>
Mime-Version: 1.0
References: <20201112015359.1103333-1-lokeshgidra@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH v13 3/4] selinux: teach SELinux about anonymous inodes
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
        Aaron Goidel <acgoide@tycho.nsa.gov>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Adrian Reber <areber@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        kaleshsingh@google.com, calin@google.com, surenb@google.com,
        jeffv@google.com, kernel-team@android.com, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>, hch@infradead.org,
        Daniel Colascione <dancol@google.com>
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
 security/selinux/hooks.c            | 56 +++++++++++++++++++++++++++++
 security/selinux/include/classmap.h |  2 ++
 2 files changed, 58 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6b1826fc3658..d092aa512868 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2927,6 +2927,61 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
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
+
+	if (context_inode) {
+		struct inode_security_struct *context_isec =
+			selinux_inode(context_inode);
+		if (context_isec->initialized != LABEL_INITIALIZED)
+			return -EACCES;
+
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
+			    ANON_INODE__CREATE,
+			    &ad);
+}
+
 static int selinux_inode_create(struct inode *dir, struct dentry *dentry, umode_t mode)
 {
 	return may_create(dir, dentry, SECCLASS_FILE);
@@ -6992,6 +7047,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 
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
2.29.2.299.gdc1121823c-goog

