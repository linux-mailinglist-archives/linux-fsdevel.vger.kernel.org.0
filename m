Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 236262DAD88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 13:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbgLOMya (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 07:54:30 -0500
Received: from bee.birch.relay.mailchannels.net ([23.83.209.14]:13448 "EHLO
        bee.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728385AbgLOMyV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 07:54:21 -0500
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 8706C22853;
        Tue, 15 Dec 2020 12:53:33 +0000 (UTC)
Received: from pdx1-sub0-mail-a35.g.dreamhost.com (100-98-64-116.trex.outbound.svc.cluster.local [100.98.64.116])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 6C1A522940;
        Tue, 15 Dec 2020 12:53:32 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
Received: from pdx1-sub0-mail-a35.g.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.18.11);
        Tue, 15 Dec 2020 12:53:33 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|siddhesh@gotplt.org
X-MailChannels-Auth-Id: dreamhost
X-Broad-Illegal: 51ce7ecf4be5bcaa_1608036813117_2618960911
X-MC-Loop-Signature: 1608036813116:986078150
X-MC-Ingress-Time: 1608036813116
Received: from pdx1-sub0-mail-a35.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a35.g.dreamhost.com (Postfix) with ESMTP id 29A787E357;
        Tue, 15 Dec 2020 04:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=gotplt.org; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=gotplt.org; bh=2CapkiHbLASiJ63lu72UGknBi4Y=; b=j9t28UxI4WWWLD
        BhS6AMZrtk24b0mL9dw40MNkjCTQyX1CVK4sL4VNbK1ESUpOPLZv0yURtW/6r97T
        vEByeK2PWEGv9Nhs2vBH7b8y3zKIGdl4/TnlzaZf9EYKCY9ML5Drd9DE8vp1tNxG
        K0oxEv1CHABU2Wtu0Vq8/qWoAeIQI=
Received: from rhbox.redhat.com (unknown [1.186.101.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: siddhesh@gotplt.org)
        by pdx1-sub0-mail-a35.g.dreamhost.com (Postfix) with ESMTPSA id 90A747F4E0;
        Tue, 15 Dec 2020 04:53:28 -0800 (PST)
X-DH-BACKEND: pdx1-sub0-mail-a35
From:   Siddhesh Poyarekar <siddhesh@gotplt.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Florian Weimer <fweimer@redhat.com>
Subject: [PATCH v2] proc: Escape more characters in /proc/mounts output
Date:   Tue, 15 Dec 2020 18:23:18 +0530
Message-Id: <20201215125318.2681355-1-siddhesh@gotplt.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When a filesystem is mounted with a blank name like so:

 # mount '' bad -t tmpfs

its name entry in /proc/mounts is blank causing the line to start
with a space.

 /mnt/bad tmpfs rw,seclabel,relatime,inode64 0 0

Further, the name could start with a hash, causing the entry to look
like this (leading space added so that git does not strip it out):

 # /mnt/bad tmpfs rw,seclabel,relatime,inode64 0 0

This breaks getmntent and any code that aims to parse fstab as well as
/proc/mounts with the same logic since they need to strip leading
spaces or skip over comments, due to which they report incorrect
output or skip over the line respectively.

This fix resolves both issues by (1) treating blank names the same way
as not having a name and (2) by escaping the hash character into its
octal encoding, which getmntent can then decode and print correctly.
As far as file parsing is concerned, these are the only additional
cases to cater for since they cover all characters that have a special
meaning in that context.

Signed-off-by: Siddhesh Poyarekar <siddhesh@gotplt.org>
Cc: Florian Weimer <fweimer@redhat.com>
---
Changes from V1:
- Break out a separate routine copy_mount_devname for device name copy.
- Rename copy_mount_string to copy_mount_type since it is now single
  use.

 fs/namespace.c      | 36 +++++++++++++++++++++++++++++++++---
 fs/proc_namespace.c |  2 +-
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index cebaa3e81794..01fafcbd9f5b 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3108,11 +3108,41 @@ static void *copy_mount_options(const void __user=
 * data)
 	return copy;
 }
=20
-static char *copy_mount_string(const void __user *data)
+static char *copy_mount_type(const void __user *data)
 {
 	return data ? strndup_user(data, PATH_MAX) : NULL;
 }
=20
+static char *copy_mount_devname(const void __user *data)
+{
+	char *p;
+	long length;
+
+	if (data =3D=3D NULL)
+		return NULL;
+
+	length =3D strnlen_user(data, PATH_MAX);
+
+	if (!length)
+		return ERR_PTR(-EFAULT);
+
+	if (length > PATH_MAX)
+		return ERR_PTR(-EINVAL);
+
+	/* Ignore blank strings */
+	if (length =3D=3D 1)
+		return NULL;
+
+	p =3D memdup_user(data, length);
+
+	if (IS_ERR(p))
+		return p;
+
+	p[length - 1] =3D '\0';
+
+	return p;
+}
+
 /*
  * Flags is a 32-bit value that allows up to 31 non-fs dependent flags t=
o
  * be given to the mount() call (ie: read-only, no-dev, no-suid etc).
@@ -3408,12 +3438,12 @@ SYSCALL_DEFINE5(mount, char __user *, dev_name, c=
har __user *, dir_name,
 	char *kernel_dev;
 	void *options;
=20
-	kernel_type =3D copy_mount_string(type);
+	kernel_type =3D copy_mount_type(type);
 	ret =3D PTR_ERR(kernel_type);
 	if (IS_ERR(kernel_type))
 		goto out_type;
=20
-	kernel_dev =3D copy_mount_string(dev_name);
+	kernel_dev =3D copy_mount_devname(dev_name);
 	ret =3D PTR_ERR(kernel_dev);
 	if (IS_ERR(kernel_dev))
 		goto out_dev;
diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index e59d4bb3a89e..090b53120b7a 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -83,7 +83,7 @@ static void show_mnt_opts(struct seq_file *m, struct vf=
smount *mnt)
=20
 static inline void mangle(struct seq_file *m, const char *s)
 {
-	seq_escape(m, s, " \t\n\\");
+	seq_escape(m, s, " \t\n\\#");
 }
=20
 static void show_type(struct seq_file *m, struct super_block *sb)
--=20
2.29.2

