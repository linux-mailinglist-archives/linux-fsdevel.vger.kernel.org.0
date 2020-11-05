Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C732A8914
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Nov 2020 22:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732394AbgKEVdc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Nov 2020 16:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732354AbgKEVdb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Nov 2020 16:33:31 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1EEC0613CF
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2020 13:33:31 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id q83so3101352ybq.17
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2020 13:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=JxEU6nxtnscWTRV4NP6TUtkxst/drXUYmjzv3EN+9u0=;
        b=iBnclI64wiVtr6uywUdrU0+21va32D2OtQfGCmrfMewTcS5cWDULSljgoALK2XhnN0
         6Tsl1vvqRrGGoJPXOloUQWGSig/XtkZVYtJ1Sx9i7zobZOpoJx6sMo7t2D7cMbPFkFeA
         BN8z8JH4wdIejzySSmx0Y87eeE1zagxbjWu410f9jojLgU+MAooGkpCWO+JIIi+uScyN
         wzWXjOHcPijU6EKI2V8sQXsBuqmMvGJFmg32m8dO7wlfowA5Bv4YJZE69k3AJRKBRKV1
         c3ZxhjApPOlpWYOO4GK50khT6vtl+8LbkBosKd/UoZ3RismUD5rO62F6GWpeuBDHB5rk
         /1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JxEU6nxtnscWTRV4NP6TUtkxst/drXUYmjzv3EN+9u0=;
        b=da8NyCwzDqWM2tOFXVC2cmbn+se4CgfwmVX3cdhirddn43frP20HCDzCaH/DqhoiHc
         mjs4G5NS/H2YguctqZDg0GsU0Ma9vpM1n83uxLoIj/grme2m9VCUWKq09aN/KCQ05+os
         BMVBd3UkYZwF/D7K8ZxbYuMJZYi5HMKJkPFiLWhHjGpadHezFdEW2nFzy3aefLhwJsFm
         EMRRzMUCXcBoF8CQP5XI/UWeeRM80PI/w0kjcR4rxiZUyQ9kIOwcgZ9xkGfllp5EjIAh
         DRLV5siKGLZ5ELCUOINRL2yhMMps6UYQ7bOFTvD8Z5pEMgkOmlhjoL9v+3k0Oup29Shu
         kJRQ==
X-Gm-Message-State: AOAM532DyrTohFyN6u9VN4yOalCVjIVw86S5J+mQ59umfFirLr+f85J5
        0vI0m2MZimmxdTKUnC/h1Ofc7VFI38EFBU/6EA==
X-Google-Smtp-Source: ABdhPJxp4ud9F0XXGnk+/NPkc07vMWY3+QWHWoqCKr56ocLP9D9oQC4SU34vx5k14AEBaTpFOkEx5r7EVhkJwmj6Rg==
Sender: "lokeshgidra via sendgmr" <lokeshgidra@lg.mtv.corp.google.com>
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:29dd])
 (user=lokeshgidra job=sendgmr) by 2002:a25:9c02:: with SMTP id
 c2mr6112707ybo.228.1604612010473; Thu, 05 Nov 2020 13:33:30 -0800 (PST)
Date:   Thu,  5 Nov 2020 13:33:21 -0800
In-Reply-To: <20201105213324.3111570-1-lokeshgidra@google.com>
Message-Id: <20201105213324.3111570-2-lokeshgidra@google.com>
Mime-Version: 1.0
References: <20201105213324.3111570-1-lokeshgidra@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v11 1/4] security: add inode_init_security_anon() LSM hook
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
        hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This change adds a new LSM hook, inode_init_security_anon(), that
will be used while creating secure anonymous inodes.

The new hook accepts an optional context_inode parameter that
callers can use to provide additional contextual information to
security modules for granting/denying permission to create an anon-
inode of the same type.

Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
---
 include/linux/lsm_hook_defs.h |  2 ++
 include/linux/lsm_hooks.h     |  9 +++++++++
 include/linux/security.h      | 10 ++++++++++
 security/security.c           |  8 ++++++++
 4 files changed, 29 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 32a940117e7a..435a2e22ff95 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -113,6 +113,8 @@ LSM_HOOK(void, LSM_RET_VOID, inode_free_security, struct inode *inode)
 LSM_HOOK(int, 0, inode_init_security, struct inode *inode,
 	 struct inode *dir, const struct qstr *qstr, const char **name,
 	 void **value, size_t *len)
+LSM_HOOK(int, 0, inode_init_security_anon, struct inode *inode,
+	 const struct qstr *name, const struct inode *context_inode)
 LSM_HOOK(int, 0, inode_create, struct inode *dir, struct dentry *dentry,
 	 umode_t mode)
 LSM_HOOK(int, 0, inode_link, struct dentry *old_dentry, struct inode *dir,
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index c503f7ab8afb..3af055b7ee1f 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -233,6 +233,15 @@
  *	Returns 0 if @name and @value have been successfully set,
  *	-EOPNOTSUPP if no security attribute is needed, or
  *	-ENOMEM on memory allocation failure.
+ * @inode_init_security_anon:
+ *      Set up the incore security field for the new anonymous inode
+ *      and return whether the inode creation is permitted by the security
+ *      module or not.
+ *      @inode contains the inode structure
+ *      @name name of the anonymous inode class
+ *      @context_inode optional related inode
+ *	Returns 0 on success, -EACCES if the security module denies the
+ *	creation of this inode, or another -errno upon other errors.
  * @inode_create:
  *	Check permission to create a regular file.
  *	@dir contains inode structure of the parent of the new file.
diff --git a/include/linux/security.h b/include/linux/security.h
index bc2725491560..7494a93b9ed9 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -323,6 +323,9 @@ void security_inode_free(struct inode *inode);
 int security_inode_init_security(struct inode *inode, struct inode *dir,
 				 const struct qstr *qstr,
 				 initxattrs initxattrs, void *fs_data);
+int security_inode_init_security_anon(struct inode *inode,
+				      const struct qstr *name,
+				      const struct inode *context_inode);
 int security_old_inode_init_security(struct inode *inode, struct inode *dir,
 				     const struct qstr *qstr, const char **name,
 				     void **value, size_t *len);
@@ -737,6 +740,13 @@ static inline int security_inode_init_security(struct inode *inode,
 	return 0;
 }
 
+static inline int security_inode_init_security_anon(struct inode *inode,
+						    const struct qstr *name,
+						    const struct inode *context_inode)
+{
+	return 0;
+}
+
 static inline int security_old_inode_init_security(struct inode *inode,
 						   struct inode *dir,
 						   const struct qstr *qstr,
diff --git a/security/security.c b/security/security.c
index a28045dc9e7f..8989ba6af4f6 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1058,6 +1058,14 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 }
 EXPORT_SYMBOL(security_inode_init_security);
 
+int security_inode_init_security_anon(struct inode *inode,
+				      const struct qstr *name,
+				      const struct inode *context_inode)
+{
+	return call_int_hook(inode_init_security_anon, 0, inode, name,
+			     context_inode);
+}
+
 int security_old_inode_init_security(struct inode *inode, struct inode *dir,
 				     const struct qstr *qstr, const char **name,
 				     void **value, size_t *len)
-- 
2.29.1.341.ge80a0c044ae-goog

