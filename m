Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C81BB15F5FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2020 19:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390522AbgBNSmc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Feb 2020 13:42:32 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33940 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388570AbgBNSmc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Feb 2020 13:42:32 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j2fqm-0000uO-LT; Fri, 14 Feb 2020 18:38:04 +0000
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
Subject: [PATCH v2 25/28] commoncap: handle fsid mappings with vfs caps
Date:   Fri, 14 Feb 2020 19:35:51 +0100
Message-Id: <20200214183554.1133805-26-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200214183554.1133805-1-christian.brauner@ubuntu.com>
References: <20200214183554.1133805-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 security/commoncap.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 0581c6aa8bdc..d2259dc0450b 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -328,7 +328,7 @@ static bool rootid_owns_currentns(kuid_t kroot)
 		return false;
 
 	for (ns = current_user_ns(); ; ns = ns->parent) {
-		if (from_kuid(ns, kroot) == 0)
+		if (from_kfsuid(ns, kroot) == 0)
 			return true;
 		if (ns == &init_user_ns)
 			break;
@@ -411,11 +411,11 @@ int cap_inode_getsecurity(struct inode *inode, const char *name, void **buffer,
 
 	nscap = (struct vfs_ns_cap_data *) tmpbuf;
 	root = le32_to_cpu(nscap->rootid);
-	kroot = make_kuid(fs_ns, root);
+	kroot = make_kfsuid(fs_ns, root);
 
-	/* If the root kuid maps to a valid uid in current ns, then return
+	/* If the root kfsuid maps to a valid uid in current ns, then return
 	 * this as a nscap. */
-	mappedroot = from_kuid(current_user_ns(), kroot);
+	mappedroot = from_kfsuid(current_user_ns(), kroot);
 	if (mappedroot != (uid_t)-1 && mappedroot != (uid_t)0) {
 		if (alloc) {
 			*buffer = tmpbuf;
@@ -460,7 +460,7 @@ static kuid_t rootid_from_xattr(const void *value, size_t size,
 	if (size == XATTR_CAPS_SZ_3)
 		rootid = le32_to_cpu(nscap->rootid);
 
-	return make_kuid(task_ns, rootid);
+	return make_kfsuid(task_ns, rootid);
 }
 
 static bool validheader(size_t size, const struct vfs_cap_data *cap)
@@ -501,7 +501,7 @@ int cap_convert_nscap(struct dentry *dentry, void **ivalue, size_t size)
 	if (!uid_valid(rootid))
 		return -EINVAL;
 
-	nsrootid = from_kuid(fs_ns, rootid);
+	nsrootid = from_kfsuid(fs_ns, rootid);
 	if (nsrootid == -1)
 		return -EINVAL;
 
@@ -600,7 +600,7 @@ int get_vfs_caps_from_disk(const struct dentry *dentry, struct cpu_vfs_cap_data
 
 	cpu_caps->magic_etc = magic_etc = le32_to_cpu(caps->magic_etc);
 
-	rootkuid = make_kuid(fs_ns, 0);
+	rootkuid = make_kfsuid(fs_ns, 0);
 	switch (magic_etc & VFS_CAP_REVISION_MASK) {
 	case VFS_CAP_REVISION_1:
 		if (size != XATTR_CAPS_SZ_1)
@@ -616,7 +616,7 @@ int get_vfs_caps_from_disk(const struct dentry *dentry, struct cpu_vfs_cap_data
 		if (size != XATTR_CAPS_SZ_3)
 			return -EINVAL;
 		tocopy = VFS_CAP_U32_3;
-		rootkuid = make_kuid(fs_ns, le32_to_cpu(nscaps->rootid));
+		rootkuid = make_kfsuid(fs_ns, le32_to_cpu(nscaps->rootid));
 		break;
 
 	default:
-- 
2.25.0

