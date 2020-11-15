Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8AEC2B3403
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Nov 2020 11:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgKOKmr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Nov 2020 05:42:47 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59336 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgKOKmK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Nov 2020 05:42:10 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1keFS1-0000Kt-Dq; Sun, 15 Nov 2020 10:40:05 +0000
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
        linux-ext4@vger.kernel.org, linux-audit@redhat.com,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 36/39] overlayfs: do not mount on top of idmapped mounts
Date:   Sun, 15 Nov 2020 11:37:15 +0100
Message-Id: <20201115103718.298186-37-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201115103718.298186-1-christian.brauner@ubuntu.com>
References: <20201115103718.298186-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Prevent overlayfs from being mounted on top of idmapped mounts until we
have ported it to handle this case and added proper testing for it.

Cc: Christoph Hellwig <hch@lst.de>
Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
patch introduced
---
 fs/overlayfs/super.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 0d4f2baf6836..3cacc3d3fb65 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1708,6 +1708,12 @@ static struct ovl_entry *ovl_get_lowerstack(struct super_block *sb,
 		if (err)
 			goto out_err;
 
+		if (mnt_idmapped(stack[i].mnt)) {
+			err = -EINVAL;
+			pr_err("idmapped lower layers are currently unsupported\n");
+			goto out_err;
+		}
+
 		lower = strchr(lower, '\0') + 1;
 	}
 
@@ -1939,6 +1945,12 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 		if (err)
 			goto out_err;
 
+		if (mnt_idmapped(upperpath.mnt)) {
+			err = -EINVAL;
+			pr_err("idmapped lower layers are currently unsupported\n");
+			goto out_err;
+		}
+
 		err = ovl_get_workdir(sb, ofs, &upperpath);
 		if (err)
 			goto out_err;
-- 
2.29.2

