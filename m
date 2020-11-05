Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637362A8919
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Nov 2020 22:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732451AbgKEVdi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Nov 2020 16:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732450AbgKEVdh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Nov 2020 16:33:37 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C9DC0613D2
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2020 13:33:37 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id u13so3153429ybk.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2020 13:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=L4KGFFWDHlU66vPQG585OdMG0AUk6bVr7qLzNQZAqk0=;
        b=tOJog2bwHs9WJ42YS4aBTCYXmTMKMSEdzQ9050j8gIcmImjdpUX/qNQgZfYvn3lZQQ
         yOgrRm2SKh3QYVXP1mjPLQ3m9TfYPfLa3tb5y9dg5XyFOSKWX6gnpgTDgOPDY1tdmqtd
         pvpU1h3d275nogGmjELLKdD8XvRcvwb61b4SnPnPotZ5o0JbEwPI+YVVlbCwzxyVQXR0
         rd+hnd9zw3PYlCNG2l6Bzp+bOJp3AjLmK7iToxJFzs8nCkosCnpnRosTeMOBiZutUdL/
         BDkZGGuhmHMMiTOVP8O1JGNDuGoemDbwgsWMf+AnUfnkGW3zaERO19iLR9qxtT290Q72
         sdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=L4KGFFWDHlU66vPQG585OdMG0AUk6bVr7qLzNQZAqk0=;
        b=evfhgQPDl2xdfJqYPBAHn8UcAfsg3bPSAPl+5PTg8ywMa6/FI67jDsnI/jrGx/aYKI
         PN6nfxpvgBCCygSG/1RP1E6U1fWr5CME7C8+lco4quM35FCxav/GoUD+pKHZe2WUkb9z
         0CrwmZVIebAowYIKSKSjVW3EaJEmzJrOQTUVgXmZRnoPGqviSOOQ2YOCp3tryo6+a8yD
         s4zYPEyoWzv6woLD8Hw6AmAFg3lx2AvSYru/HS1ZsrqdeMQ+Gco8iuiU7AcYcN6SENko
         9X3NMnrSI4W+saI+khrCaiSesRJF5xjNHKdo2QbTG+wQdfoWOpLtEKjO27APgjB/6Gw9
         4EjA==
X-Gm-Message-State: AOAM530TTU0P73oLnYB9wPO+kTUPczcDNRXaMpjyxtCpdowFpsq+vqUu
        9e39wNyR0Rguwc0wN86BDSZ5AKwdj5oRQyJPjQ==
X-Google-Smtp-Source: ABdhPJz5uB82DFbGCEjbZuok3KmmDSwQU271wqlzWfcXyitAJr0CBCkAWpoTQfsr+q5AnQWi/NWA6MLsQlYvHTIJng==
Sender: "lokeshgidra via sendgmr" <lokeshgidra@lg.mtv.corp.google.com>
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:29dd])
 (user=lokeshgidra job=sendgmr) by 2002:a25:7385:: with SMTP id
 o127mr4747089ybc.202.1604612016375; Thu, 05 Nov 2020 13:33:36 -0800 (PST)
Date:   Thu,  5 Nov 2020 13:33:23 -0800
In-Reply-To: <20201105213324.3111570-1-lokeshgidra@google.com>
Message-Id: <20201105213324.3111570-4-lokeshgidra@google.com>
Mime-Version: 1.0
References: <20201105213324.3111570-1-lokeshgidra@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v11 3/4] selinux: teach SELinux about anonymous inodes
From:   Lokesh Gidra <lokeshgidra@google.com>
To:     Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Daniel Colascione <dancol@dancol.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        KP Singh <kpsingh@google.com>,
        David Howells <dhowells@redhat.com>,
        Thomas Cedeno <thomascedeno@google.com>,
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
        nnk@google.com, jeffv@google.com, kernel-team@android.com,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        hch@infradead.org, Daniel Colascione <dancol@google.com>
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
 security/selinux/hooks.c            | 53 +++++++++++++++++++++++++++++
 security/selinux/include/classmap.h |  2 ++
 2 files changed, 55 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6b1826fc3658..1c0adcdce7a8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2927,6 +2927,58 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
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
@@ -6992,6 +7044,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 
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
2.29.1.341.ge80a0c044ae-goog

