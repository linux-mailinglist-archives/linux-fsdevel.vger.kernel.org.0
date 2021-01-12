Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556322F3E38
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jan 2021 01:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394254AbhALWGF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 17:06:05 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:43187 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393942AbhALWEK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:04:10 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kzRl7-0003bd-87; Tue, 12 Jan 2021 22:03:25 +0000
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
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 15/42] fs: add file_user_ns() helper
Date:   Tue, 12 Jan 2021 23:00:57 +0100
Message-Id: <20210112220124.837960-16-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210112220124.837960-1-christian.brauner@ubuntu.com>
References: <20210112220124.837960-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=MZF5H2APPgBbS6dalQP77IpBwjL8HOOCA8mxwD5I4mI=; m=rorofWYhlCYDsCHBmUT6ySFEXdKQZ/BhNiBUrVhD44Y=; p=donUDu8QUHywwTXuK+sEKtSO4q8ThCf0JgX/00ZRl3c=; g=56b63087ece42342c8428cabd6c7826fd940bf53
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCX/4YtgAKCRCRxhvAZXjcoinBAP9Zb0X yPth7UfV2DKrmKc17yNpYOz/9nCdo68TG5JthyQD/fWKi5+wXROsRJbp1i3YxlH/gCo28bVGPOR3L W/gWZAw=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a simple helper to retrieve the user namespace associated with the
vfsmount of a file. Christoph correctly points out that this makes
codepaths (e.g. ioctls) way easier to follow that would otherwise
dereference via mnt_user_ns(file->f_path.mnt).

In order to make file_user_ns() static inline we'd need to include
mount.h in either file.h or fs.h which seems undesirable so let's simply
not force file_user_ns() to be inline.

Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
patch not present

/* v3 */
patch not present

/* v4 */
patch not present

/* v5 */
patch introduced
base-commit: 7c53f6b671f4aba70ff15e1b05148b10d58c2837
---
 fs/namei.c         | 6 ++++++
 include/linux/fs.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index cd124e18cec5..d8dee449e92a 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -259,6 +259,12 @@ void putname(struct filename *name)
 		__putname(name);
 }
 
+struct user_namespace *file_user_ns(struct file *file)
+{
+	return mnt_user_ns(file->f_path.mnt);
+}
+EXPORT_SYMBOL(file_user_ns);
+
 /**
  * check_acl - perform ACL permission checking
  * @mnt_userns:	user namespace of the mount the inode was found from
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ef993857682b..89e41a821bad 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2585,6 +2585,7 @@ static inline struct file *file_clone_open(struct file *file)
 	return dentry_open(&file->f_path, file->f_flags, file->f_cred);
 }
 extern int filp_close(struct file *, fl_owner_t id);
+extern struct user_namespace *file_user_ns(struct file *file);
 
 extern struct filename *getname_flags(const char __user *, int, int *);
 extern struct filename *getname(const char __user *);
-- 
2.30.0

