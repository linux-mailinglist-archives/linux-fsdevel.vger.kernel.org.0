Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0581D15F5C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2020 19:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390707AbgBNSiw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Feb 2020 13:38:52 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33659 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730491AbgBNSiB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Feb 2020 13:38:01 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j2fqN-0000uO-MI; Fri, 14 Feb 2020 18:37:39 +0000
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
Subject: [PATCH v2 06/28] cred: add kfs{g,u}id
Date:   Fri, 14 Feb 2020 19:35:32 +0100
Message-Id: <20200214183554.1133805-7-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200214183554.1133805-1-christian.brauner@ubuntu.com>
References: <20200214183554.1133805-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After the introduction of fsid mappings we need to carefully handle
single-superblock filesystems that are visible in user namespaces. This
specifically concerns proc and sysfs. For those filesystems we want to continue
looking up fsid in the id mappings of the relevant user namespace. We can
either do this by dynamically translating between these fsids or we simply keep
them around with the other creds. The latter option is not just simpler but
also more performant since we don't need to do the translation from fsid
mappings into id mappings on the fly.

Link: https://lore.kernel.org/r/20200212145149.zohmc6d3x52bw6j6@wittgenstein
Cc: Jann Horn <jannh@google.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
patch added
---
 include/linux/cred.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 18639c069263..604914d3fd51 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -125,6 +125,8 @@ struct cred {
 	kgid_t		egid;		/* effective GID of the task */
 	kuid_t		fsuid;		/* UID for VFS ops */
 	kgid_t		fsgid;		/* GID for VFS ops */
+	kuid_t		kfsuid;		/* UID for VFS ops for userns visible filesystems */
+	kgid_t		kfsgid;		/* GID for VFS ops for userns visible filesystems */
 	unsigned	securebits;	/* SUID-less security management */
 	kernel_cap_t	cap_inheritable; /* caps our children can inherit */
 	kernel_cap_t	cap_permitted;	/* caps we're permitted */
@@ -384,6 +386,8 @@ static inline void put_cred(const struct cred *_cred)
 #define current_sgid()		(current_cred_xxx(sgid))
 #define current_fsuid() 	(current_cred_xxx(fsuid))
 #define current_fsgid() 	(current_cred_xxx(fsgid))
+#define current_kfsuid() 	(current_cred_xxx(kfsuid))
+#define current_kfsgid() 	(current_cred_xxx(kfsgid))
 #define current_cap()		(current_cred_xxx(cap_effective))
 #define current_user()		(current_cred_xxx(user))
 
-- 
2.25.0

