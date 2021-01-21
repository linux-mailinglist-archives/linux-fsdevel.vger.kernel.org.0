Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923D12FEC10
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 14:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732496AbhAUNfc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 08:35:32 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55324 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732314AbhAUNdo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:33:44 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1l2ZuM-0005g7-Ag; Thu, 21 Jan 2021 13:21:54 +0000
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
Subject: [PATCH v6 23/40] exec: handle idmapped mounts
Date:   Thu, 21 Jan 2021 14:19:42 +0100
Message-Id: <20210121131959.646623-24-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121131959.646623-1-christian.brauner@ubuntu.com>
References: <20210121131959.646623-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=z3V1fTqinwXFXuBPT/F1/hXfgz5+RFdSDv1+bqcElO4=; m=pa7oyqjV6cs0De7RkFUKqnoILUWsjrd+GGkDcRnF7e4=; p=e3JlF/8T1cdyjaEUPbrFI9rl6HdxUVBqTEYS22fNFZk=; g=96f8f9f670a40251c9d649d880221f3c3f943146
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYAl9pQAKCRCRxhvAZXjconUpAQCTIZQ 8C3ba4lje18NvrTHsReci/Ovd9qdOQRTBQ2jEdwD/YSyNacQTQKobAyIgKGa8ALgMZ7LbpDA6GlTv S/f8HQw=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When executing a setuid binary the kernel will verify in bprm_fill_uid()
that the inode has a mapping in the caller's user namespace before
setting the callers uid and gid. Let bprm_fill_uid() handle idmapped
mounts. If the inode is accessed through an idmapped mount it is mapped
according to the mount's user namespace. Afterwards the checks are
identical to non-idmapped mounts. If the initial user namespace is
passed nothing changes so non-idmapped mounts will see identical
behavior as before.

Link: https://lore.kernel.org/r/20210112220124.837960-32-christian.brauner@ubuntu.com
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

/* v6 */
base-commit: 19c329f6808995b142b3966301f217c831e7cf31

- Christoph Hellwig <hch@lst.de>:
  - Use new file_mnt_user_ns() helper.
---
 fs/exec.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index d803227805f6..48d1e8b1610b 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1580,6 +1580,7 @@ static void check_unsafe_exec(struct linux_binprm *bprm)
 static void bprm_fill_uid(struct linux_binprm *bprm, struct file *file)
 {
 	/* Handle suid and sgid on files */
+	struct user_namespace *mnt_userns;
 	struct inode *inode;
 	unsigned int mode;
 	kuid_t uid;
@@ -1596,13 +1597,15 @@ static void bprm_fill_uid(struct linux_binprm *bprm, struct file *file)
 	if (!(mode & (S_ISUID|S_ISGID)))
 		return;
 
+	mnt_userns = file_mnt_user_ns(file);
+
 	/* Be careful if suid/sgid is set */
 	inode_lock(inode);
 
 	/* reload atomically mode/uid/gid now that lock held */
 	mode = inode->i_mode;
-	uid = inode->i_uid;
-	gid = inode->i_gid;
+	uid = i_uid_into_mnt(mnt_userns, inode);
+	gid = i_gid_into_mnt(mnt_userns, inode);
 	inode_unlock(inode);
 
 	/* We ignore suid/sgid if there are no mappings for them in the ns */
-- 
2.30.0

