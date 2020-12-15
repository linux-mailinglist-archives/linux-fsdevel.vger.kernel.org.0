Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF8742DA728
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 05:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbgLOEgc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 23:36:32 -0500
Received: from bee.birch.relay.mailchannels.net ([23.83.209.14]:11267 "EHLO
        bee.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725440AbgLOEgc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 23:36:32 -0500
X-Greylist: delayed 637 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Dec 2020 23:36:31 EST
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id EE9F722D2E;
        Tue, 15 Dec 2020 04:25:08 +0000 (UTC)
Received: from pdx1-sub0-mail-a35.g.dreamhost.com (100-96-5-83.trex.outbound.svc.cluster.local [100.96.5.83])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 7D6C222CCA;
        Tue, 15 Dec 2020 04:25:07 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
Received: from pdx1-sub0-mail-a35.g.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.18.11);
        Tue, 15 Dec 2020 04:25:08 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|siddhesh@gotplt.org
X-MailChannels-Auth-Id: dreamhost
X-Tasty-Whimsical: 1303ce682a4e49a4_1608006308182_2923774275
X-MC-Loop-Signature: 1608006308182:4266427354
X-MC-Ingress-Time: 1608006308182
Received: from pdx1-sub0-mail-a35.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a35.g.dreamhost.com (Postfix) with ESMTP id 24F3C7F506;
        Mon, 14 Dec 2020 20:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=gotplt.org; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=gotplt.org; bh=XxVgTsIsaC/4TT1Y2yUHz6XqLMo=; b=T48VCwHTvTeh/0
        NL2dSUsirgs6OM+jeAJZM8FGmjLaA2q/SCqM7N5n/YLgjS7F0k2I13VIXSfDn8XY
        0eAPrADbe0CRKpopPJuGBP9hZ5/G5EUnSsglzGPnbSALWdLYwuO/qFFvwK40zcKM
        bwhIdOjE30Et0jCVzOMPKbJPoURfo=
Received: from rhbox.redhat.com (unknown [1.186.101.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: siddhesh@gotplt.org)
        by pdx1-sub0-mail-a35.g.dreamhost.com (Postfix) with ESMTPSA id C56857E63B;
        Mon, 14 Dec 2020 20:25:03 -0800 (PST)
X-DH-BACKEND: pdx1-sub0-mail-a35
From:   Siddhesh Poyarekar <siddhesh@gotplt.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Florian Weimer <fweimer@redhat.com>
Subject: [PATCH] proc: Escape more characters in /proc/mounts output
Date:   Tue, 15 Dec 2020 09:54:54 +0530
Message-Id: <20201215042454.998361-1-siddhesh@gotplt.org>
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
 fs/namespace.c      | 8 +++++++-
 fs/proc_namespace.c | 2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index cebaa3e81794..68bd5a814a2a 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3110,7 +3110,13 @@ static void *copy_mount_options(const void __user =
* data)
=20
 static char *copy_mount_string(const void __user *data)
 {
-	return data ? strndup_user(data, PATH_MAX) : NULL;
+	char byte;
+	if (data =3D=3D NULL)
+	  return NULL;
+
+	get_user(byte, (const char __user *)data);
+
+	return byte ? strndup_user(data, PATH_MAX) : NULL;
 }
=20
 /*
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

