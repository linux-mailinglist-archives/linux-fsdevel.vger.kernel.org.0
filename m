Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1E962FEC0E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 14:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732476AbhAUNf1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 08:35:27 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55317 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732304AbhAUNdj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:33:39 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1l2ZuI-0005g7-8p; Thu, 21 Jan 2021 13:21:50 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
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
        Theodore Tso <tytso@mit.edu>, Alban Crequy <alban@kinvolk.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v6 22/40] would_dump: handle idmapped mounts
Date:   Thu, 21 Jan 2021 14:19:41 +0100
Message-Id: <20210121131959.646623-23-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121131959.646623-1-christian.brauner@ubuntu.com>
References: <20210121131959.646623-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=A/nf/Qaib9/w6oGQlkS9dYx6cw1KsGe6yuBPNJQbdMM=; m=5fDX5uz0YnC3GH96qex7V+5TwhlVI48wrMLhtmDIkl8=; p=QepK7fKjTZuoI1u3TlKmBwlnbcyQSzJL+R6j/ywgVPc=; g=4190fea7306895f3e77ebfd677e8257c1f573c61
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYAl9pQAKCRCRxhvAZXjcokbCAP9K3z3 CreUyBktYJ8SjXaIHJXRbCwIFFhlpN72GXHM7cgEA72Za1OgttnSBIi5PswjJIk6RpEFXF+qFrzcs uz9ZrAk=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When determining whether or not to create a coredump the vfs will verify
that the caller is privileged over the inode. Make the would_dump()
helper handle idmapped mounts by passing down the mount's user namespace
of the exec file. If the initial user namespace is passed nothing
changes so non-idmapped mounts will see identical behavior as before.

Link: https://lore.kernel.org/r/20210112220124.837960-31-christian.brauner@ubuntu.com
Cc: Christoph Hellwig <hch@lst.de>
Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
unchanged

/* v3 */
unchanged

/* v4 */
- Serge Hallyn <serge@hallyn.com>:
  - Use "mnt_userns" to refer to a vfsmount's userns everywhere to make
    terminology consistent.

/* v5 */
unchanged
base-commit: 7c53f6b671f4aba70ff15e1b05148b10d58c2837

- Christoph Hellwig <hch@lst.de>:
  - Use new file_mnt_user_ns() helper.

/* v6 */
unchanged
base-commit: 19c329f6808995b142b3966301f217c831e7cf31
---
 fs/exec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index a8ec371cd3cd..d803227805f6 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1404,15 +1404,15 @@ EXPORT_SYMBOL(begin_new_exec);
 void would_dump(struct linux_binprm *bprm, struct file *file)
 {
 	struct inode *inode = file_inode(file);
-	if (inode_permission(&init_user_ns, inode, MAY_READ) < 0) {
+	struct user_namespace *mnt_userns = file_mnt_user_ns(file);
+	if (inode_permission(mnt_userns, inode, MAY_READ) < 0) {
 		struct user_namespace *old, *user_ns;
 		bprm->interp_flags |= BINPRM_FLAGS_ENFORCE_NONDUMP;
 
 		/* Ensure mm->user_ns contains the executable */
 		user_ns = old = bprm->mm->user_ns;
 		while ((user_ns != &init_user_ns) &&
-		       !privileged_wrt_inode_uidgid(user_ns, &init_user_ns,
-						    inode))
+		       !privileged_wrt_inode_uidgid(user_ns, mnt_userns, inode))
 			user_ns = user_ns->parent;
 
 		if (old != user_ns) {
-- 
2.30.0

