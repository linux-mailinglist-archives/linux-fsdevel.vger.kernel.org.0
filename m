Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 985A915F59B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2020 19:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730731AbgBNSiJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Feb 2020 13:38:09 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33722 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389468AbgBNSiJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Feb 2020 13:38:09 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j2fqd-0000uO-Bq; Fri, 14 Feb 2020 18:37:55 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>
Cc:     smbarber@chromium.org, Seth Forshee <seth.forshee@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Phil Estes <estesp@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 18/28] capability: privileged_wrt_inode_uidgid(): handle fsid mappings
Date:   Fri, 14 Feb 2020 19:35:44 +0100
Message-Id: <20200214183554.1133805-19-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200214183554.1133805-1-christian.brauner@ubuntu.com>
References: <20200214183554.1133805-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Switch privileged_wrt_inode_uidgid() to lookup fsids in the fsid mappings. If
no fsid mappings are setup the behavior is unchanged, i.e. fsids are looked up
in the id mappings.

Filesystems that share a superblock in all user namespaces they are mounted in
will retain their old semantics even with the introduction of fsidmappings.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
unchanged
---
 kernel/capability.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/capability.c b/kernel/capability.c
index 1444f3954d75..2b0c1dc992e2 100644
--- a/kernel/capability.c
+++ b/kernel/capability.c
@@ -19,6 +19,8 @@
 #include <linux/pid_namespace.h>
 #include <linux/user_namespace.h>
 #include <linux/uaccess.h>
+#include <linux/fsuidgid.h>
+#include <linux/fs.h>
 
 /*
  * Leveraged for setting/resetting capabilities
@@ -486,8 +488,12 @@ EXPORT_SYMBOL(file_ns_capable);
  */
 bool privileged_wrt_inode_uidgid(struct user_namespace *ns, const struct inode *inode)
 {
-	return kuid_has_mapping(ns, inode->i_uid) &&
-		kgid_has_mapping(ns, inode->i_gid);
+	if (is_userns_visible(inode->i_sb->s_iflags))
+		return kuid_has_mapping(ns, inode->i_uid) &&
+		       kgid_has_mapping(ns, inode->i_gid);
+
+	return kfsuid_has_mapping(ns, inode->i_uid) &&
+	       kfsgid_has_mapping(ns, inode->i_gid);
 }
 
 /**
-- 
2.25.0

