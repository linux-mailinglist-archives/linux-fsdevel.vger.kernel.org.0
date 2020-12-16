Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744F32DC6E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 20:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731308AbgLPTJR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 14:09:17 -0500
Received: from cheetah.elm.relay.mailchannels.net ([23.83.212.34]:53406 "EHLO
        cheetah.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726665AbgLPTJR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 14:09:17 -0500
X-Greylist: delayed 128273 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Dec 2020 14:09:16 EST
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 895D91818E3;
        Wed, 16 Dec 2020 19:08:29 +0000 (UTC)
Received: from pdx1-sub0-mail-a17.g.dreamhost.com (100-105-161-17.trex.outbound.svc.cluster.local [100.105.161.17])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id D3CEA181F3D;
        Wed, 16 Dec 2020 19:08:28 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
Received: from pdx1-sub0-mail-a17.g.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.18.11);
        Wed, 16 Dec 2020 19:08:29 +0000
X-MC-Relay: Good
X-MailChannels-SenderId: dreamhost|x-authsender|siddhesh@gotplt.org
X-MailChannels-Auth-Id: dreamhost
X-Turn-Eight: 3863ca7e600b5ebe_1608145709194_2758044234
X-MC-Loop-Signature: 1608145709194:2935019634
X-MC-Ingress-Time: 1608145709193
Received: from pdx1-sub0-mail-a17.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a17.g.dreamhost.com (Postfix) with ESMTP id 8EDEB7F0EF;
        Wed, 16 Dec 2020 11:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=gotplt.org; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=gotplt.org; bh=gT0qKu6lYfWDkNttl7vX1GdFo4g=; b=F1am7u6cT3FQ9U
        SGmo9YirhAhoArLjGd9rLd7KZen8ZEXJaCHuV4ZdIODQ/h1oFNpxkmRj8SDK71l4
        JqP7LfQS1Ei9w0SwxGeshuRxfRano3auEhclRqWaQaqzCdjoZRevB9pmXqTq/tdI
        ndng160CJcCRiXwIRSv/j8DZ9k4UA=
Received: from rhbox.redhat.com (unknown [1.186.101.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: siddhesh@gotplt.org)
        by pdx1-sub0-mail-a17.g.dreamhost.com (Postfix) with ESMTPSA id 8E69A7F0F7;
        Wed, 16 Dec 2020 11:08:25 -0800 (PST)
X-DH-BACKEND: pdx1-sub0-mail-a17
From:   Siddhesh Poyarekar <siddhesh@gotplt.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Florian Weimer <fweimer@redhat.com>
Subject: [PATCH v3] proc: Escape more characters in /proc/mounts output
Date:   Thu, 17 Dec 2020 00:38:18 +0530
Message-Id: <20201216190818.342878-1-siddhesh@gotplt.org>
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

Changes from v2:
- Check for blank name after the string has been duplicated into
  kernelspace.

 fs/namespace.c      | 5 +++++
 fs/proc_namespace.c | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index cebaa3e81794..1c19bf930807 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3418,6 +3418,11 @@ SYSCALL_DEFINE5(mount, char __user *, dev_name, ch=
ar __user *, dir_name,
 	if (IS_ERR(kernel_dev))
 		goto out_dev;
=20
+	if (kernel_dev && !kernel_dev[0]) {
+		kfree(kernel_dev);
+		kernel_dev =3D NULL;
+	}
+
 	options =3D copy_mount_options(data);
 	ret =3D PTR_ERR(options);
 	if (IS_ERR(options))
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

