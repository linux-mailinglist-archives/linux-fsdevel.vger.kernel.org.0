Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B872FEB9A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 14:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbhAUNYK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 08:24:10 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54133 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731953AbhAUNWP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:22:15 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1l2Ztw-0005g7-HI; Thu, 21 Jan 2021 13:21:28 +0000
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
Subject: [PATCH v6 17/40] af_unix: handle idmapped mounts
Date:   Thu, 21 Jan 2021 14:19:36 +0100
Message-Id: <20210121131959.646623-18-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121131959.646623-1-christian.brauner@ubuntu.com>
References: <20210121131959.646623-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=bTjAWrcqQEv0S0d4FYAs3/GqS1T6sx1KbcrCQIdbMQ0=; m=twWEGxskJSS4i1ogJQfrHKhWCmrI1WuSHxrnammM5TU=; p=aixbXYnl8q1vgWutDKTjZqvJYLBw2Sjer/EFWsTVdok=; g=22194cebe03859c478ffe95eb4a26c49a17d789e
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYAl9pQAKCRCRxhvAZXjcorRYAP4h7Rg odg1epo8B/Emlr4heI1qeisSpSXWaXsI7fcF2LgD/Z7C6n1IDnZ5efKGvPKhA3EChOiqBD4mmlPDa T8jMZQ4=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When binding a non-abstract AF_UNIX socket it will gain a representation
in the filesystem. Enable the socket infrastructure to handle idmapped
mounts by passing down the user namespace of the mount the socket will
be created from. If the initial user namespace is passed nothing changes
so non-idmapped mounts will see identical behavior as before.

Link: https://lore.kernel.org/r/20210112220124.837960-25-christian.brauner@ubuntu.com
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
unchanged

/* v5 */
unchanged
base-commit: 7c53f6b671f4aba70ff15e1b05148b10d58c2837

/* v6 */
unchanged
base-commit: 19c329f6808995b142b3966301f217c831e7cf31
---
 net/unix/af_unix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 9a1f3c04402e..5a31307ceb76 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -996,8 +996,8 @@ static int unix_mknod(const char *sun_path, umode_t mode, struct path *res)
 	 */
 	err = security_path_mknod(&path, dentry, mode, 0);
 	if (!err) {
-		err = vfs_mknod(&init_user_ns, d_inode(path.dentry), dentry,
-				mode, 0);
+		err = vfs_mknod(mnt_user_ns(path.mnt), d_inode(path.dentry),
+				dentry, mode, 0);
 		if (!err) {
 			res->mnt = mntget(path.mnt);
 			res->dentry = dget(dentry);
-- 
2.30.0

