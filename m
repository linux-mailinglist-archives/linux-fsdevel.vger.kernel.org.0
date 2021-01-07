Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5722ECD94
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 11:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbhAGKMu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jan 2021 05:12:50 -0500
Received: from burlywood.elm.relay.mailchannels.net ([23.83.212.26]:8690 "EHLO
        burlywood.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725900AbhAGKMt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jan 2021 05:12:49 -0500
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 8E11F22021;
        Thu,  7 Jan 2021 10:12:02 +0000 (UTC)
Received: from pdx1-sub0-mail-a82.g.dreamhost.com (100-98-64-116.trex.outbound.svc.cluster.local [100.98.64.116])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 2384422074;
        Thu,  7 Jan 2021 10:12:00 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
Received: from pdx1-sub0-mail-a82.g.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.18.11);
        Thu, 07 Jan 2021 10:12:02 +0000
X-MC-Relay: Junk
X-MailChannels-SenderId: dreamhost|x-authsender|siddhesh@gotplt.org
X-MailChannels-Auth-Id: dreamhost
X-Illustrious-Plucky: 1e0c89197bb2e911_1610014322307_2265109397
X-MC-Loop-Signature: 1610014322307:31235877
X-MC-Ingress-Time: 1610014322307
Received: from pdx1-sub0-mail-a82.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a82.g.dreamhost.com (Postfix) with ESMTP id AD0827EFE7;
        Thu,  7 Jan 2021 02:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=gotplt.org; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=gotplt.org; bh=X24EKd/nLmqoI3HsWc3nv/fm2AQ=; b=bb8A3PEvFsjuI0
        KxHow920F/uJERO9s4kvoKNfmGaMabLwmo0sTrbth9fOoXrje3jJFdYDOC8Qi6Nr
        65Vqx41GcFz2NAW3RrYcwUoFgyaHgZxaK8pvffYm5aAtNVna3gUHJX3GIDv8FgN9
        7lezjM/b5BUmR+b2mrmOV1kPK9rP8=
Received: from rhbox.lan (unknown [103.199.172.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: siddhesh@gotplt.org)
        by pdx1-sub0-mail-a82.g.dreamhost.com (Postfix) with ESMTPSA id E0BE57E626;
        Thu,  7 Jan 2021 02:11:55 -0800 (PST)
X-DH-BACKEND: pdx1-sub0-mail-a82
From:   Siddhesh Poyarekar <siddhesh@gotplt.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>, siddhesh@gotplt.org,
        Florian Weimer <fweimer@redhat.com>
Subject: [RESEND][PATCH v3] proc: Escape more characters in /proc/mounts output
Date:   Thu,  7 Jan 2021 15:41:13 +0530
Message-Id: <20210107101113.368139-1-siddhesh@gotplt.org>
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
 fs/namespace.c      | 5 +++++
 fs/proc_namespace.c | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index d2db7dfe232b..2f81f1c7f20a 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3421,6 +3421,11 @@ SYSCALL_DEFINE5(mount, char __user *, dev_name, ch=
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
index eafb75755fa3..6d7e47750781 100644
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

