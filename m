Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0FAC29DD80
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 01:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388790AbgJ2Aji (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 20:39:38 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33327 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388782AbgJ2AjH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:39:07 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kXvuz-0008Ep-Kw; Thu, 29 Oct 2020 00:35:53 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
Cc:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Mrunal Patel <mpatel@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Andy Lutomirski <luto@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Theodore Tso <tytso@mit.edu>, Alban Crequy <alban@kinvolk.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jann Horn <jannh@google.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-audit@redhat.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 24/34] would_dump: handle idmapped mounts
Date:   Thu, 29 Oct 2020 01:32:42 +0100
Message-Id: <20201029003252.2128653-25-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
References: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When determining whether or not to create a coredump the vfs will verify that
the caller is privileged over the inode. Make the would_dump() helper handle
idmapped mounts by passing down the mount's user namespace of the exec file.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/exec.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 8e75d7a33514..76de175eeba8 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1391,14 +1391,15 @@ EXPORT_SYMBOL(begin_new_exec);
 void would_dump(struct linux_binprm *bprm, struct file *file)
 {
 	struct inode *inode = file_inode(file);
-	if (inode_permission(inode, MAY_READ) < 0) {
+	struct user_namespace *ns = mnt_user_ns(file->f_path.mnt);
+	if (mapped_inode_permission(ns, inode, MAY_READ) < 0) {
 		struct user_namespace *old, *user_ns;
 		bprm->interp_flags |= BINPRM_FLAGS_ENFORCE_NONDUMP;
 
 		/* Ensure mm->user_ns contains the executable */
 		user_ns = old = bprm->mm->user_ns;
 		while ((user_ns != &init_user_ns) &&
-		       !privileged_wrt_inode_uidgid(user_ns, &init_user_ns, inode))
+		       !privileged_wrt_inode_uidgid(user_ns, ns, inode))
 			user_ns = user_ns->parent;
 
 		if (old != user_ns) {
-- 
2.29.0

