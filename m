Return-Path: <linux-fsdevel+bounces-43944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE5AA60460
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 23:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 102323B7D01
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 22:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6663F1F5853;
	Thu, 13 Mar 2025 22:33:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EDC22612;
	Thu, 13 Mar 2025 22:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741905182; cv=none; b=oQKcCoZRJiYkHZuz4dZwP4UZ7YumsX1RtEoXFQOU1j7X5yuAg3eyEmC47Oyp8d7DgOTX1IyOW4La8EvTKeloNmt18ssqGuZ9gyYbX1xK4Jp1RuGErvZwQuU77ur5980HqGQBWuAPzKwBk4JYTV1mjjrRWlCrU3ECg0TVZ6P+bIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741905182; c=relaxed/simple;
	bh=FwB7tbMC2wL4+ylCvdz2zcoRUGupeXXHPStpgXIXNAc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=kKJQridxEuZ0lhEwHaXrCqWRtF/NaYctwRFUnDrL/lBjQe3Bi2fo2h7ZIci6+XP6UG1uVIqGB0c63g/LbF3XWXeoCD+RV3cZ2vALQPDyklp5pbN5O2ESa4hbW4ndf/lY1yGxdilS/STQsh9Zffe8m70/yBFTjRAYAfEs6checus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1tsr6k-00Dytg-Lo;
	Thu, 13 Mar 2025 22:32:54 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Ian Kent <raven@themaw.net>
Cc: linux-fsdevel@vger.kernel.org, autofs@vger.kernel.org
Subject: [PATCH] VFS/autofs: try_lookup_one_len() does not need any locks
Date: Fri, 14 Mar 2025 09:32:54 +1100
Message-id: <174190517441.9342.5956460781380903128@noble.neil.brown.name>


try_lookup_one_len() is identical to lookup_one_unlocked() except that
it doesn't include the call to lookup_slow().  The latter doesn't need
the inode to be locked, so the former cannot either.

So fix the documentation, remove the WARN_ON and fix the only caller to
not take the lock.

Signed-off-by: NeilBrown <neilb@suse.de>
---

Note that in current upstream fs/afs/dynroot.c also contains a call to
try_lookup_one_len() with unnecessary locking.  However
vfs-6.15.shared.afs contains a patch which removes that call, so I
didn't bother addressing it here.

NeilBrown


 fs/autofs/dev-ioctl.c | 3 ---
 fs/namei.c            | 5 ++---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/autofs/dev-ioctl.c b/fs/autofs/dev-ioctl.c
index 6d57efbb8110..c5a6aae12d2c 100644
--- a/fs/autofs/dev-ioctl.c
+++ b/fs/autofs/dev-ioctl.c
@@ -442,7 +442,6 @@ static int autofs_dev_ioctl_timeout(struct file *fp,
 		sbi->exp_timeout =3D timeout * HZ;
 	} else {
 		struct dentry *base =3D fp->f_path.dentry;
-		struct inode *inode =3D base->d_inode;
 		int path_len =3D param->size - AUTOFS_DEV_IOCTL_SIZE - 1;
 		struct dentry *dentry;
 		struct autofs_info *ino;
@@ -460,9 +459,7 @@ static int autofs_dev_ioctl_timeout(struct file *fp,
 				"the parent autofs mount timeout which could "
 				"prevent shutdown\n");
=20
-		inode_lock_shared(inode);
 		dentry =3D try_lookup_one_len(param->path, base, path_len);
-		inode_unlock_shared(inode);
 		if (IS_ERR_OR_NULL(dentry))
 			return dentry ? PTR_ERR(dentry) : -ENOENT;
 		ino =3D autofs_dentry_ino(dentry);
diff --git a/fs/namei.c b/fs/namei.c
index ecb7b95c2ca3..c6cef0af0625 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2863,15 +2863,14 @@ static int lookup_one_common(struct mnt_idmap *idmap,
  * Note that this routine is purely a helper for filesystem usage and should
  * not be called by generic code.
  *
- * The caller must hold base->i_mutex.
+ * No locks need be held - only a counted reference to @base is needed.
+ *
  */
 struct dentry *try_lookup_one_len(const char *name, struct dentry *base, int=
 len)
 {
 	struct qstr this;
 	int err;
=20
-	WARN_ON_ONCE(!inode_is_locked(base->d_inode));
-
 	err =3D lookup_one_common(&nop_mnt_idmap, name, base, len, &this);
 	if (err)
 		return ERR_PTR(err);
--=20
2.48.1


