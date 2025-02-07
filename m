Return-Path: <linux-fsdevel+bounces-41161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3059A2BBD4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 07:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6674D165C6D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 06:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2796199E8B;
	Fri,  7 Feb 2025 06:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZGFi75+6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VYb8ziXw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZGFi75+6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VYb8ziXw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C1D19049A
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Feb 2025 06:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738911101; cv=none; b=FMZeEKA2q6IFf+JnN/aE5u9liQJoHQtZYQ/to7AcOlk/fGKt8zKUJKAxMe+fpmGttTDhrIcYMlKxTO3Q/ZrwBTI8cd8WNLTI2cGQ3EkXWmqQxPDWjSDKQbuXsIz4qnmc7OOfnsBXmdqd7zQR4jLOMUCmZJvNYkGu/eNb3La9H8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738911101; c=relaxed/simple;
	bh=JTxXfksqAGgzMD7d6mydojDSCkqtiPHmnO6tng2oZMo=;
	h=Content-Type:MIME-Version:From:To:cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Shvz0e7a8EFfobn6FBC5V+gDoQXUxdv4ccGx+KRq+/FoypAK35svjQAe8HzDV0qTre+dzKK1NCfvFEz1UBnkfhcCHaPYC+7gambNXMAUr1K4dEpg1P4xtt0KeaGNqRBH0rHwLMoRpXIiN497/ThCn3SucEIBh4zusdbtygSVOM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZGFi75+6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VYb8ziXw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZGFi75+6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VYb8ziXw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 148A61F38D;
	Fri,  7 Feb 2025 06:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738911097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E9j5Xs0mZ6wtU6j7VFVCEoj4y6f/ta7EoSkwrrk+4pQ=;
	b=ZGFi75+6VoBbxJKTYGHdLOqDel7a7DxCz98Kn6hUCKkf9rgLKGQiT2WNbiXitr4RZbiWXH
	9HfjpsKod28XBYaGPEe7o7qEDLEVNqA5xbOoNnhSQm6nUSVaUEmf/zIJ3AodgqJa7uQung
	TH0PRGnszPOsQAxnulyGEtGSRQMZwUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738911097;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E9j5Xs0mZ6wtU6j7VFVCEoj4y6f/ta7EoSkwrrk+4pQ=;
	b=VYb8ziXwpnoAKjJFt4BQcCLxYuW5JPfDgGNs61Q241dkAgg7k3Vmax3ISXioG6cDJzp0HT
	r1xy3RCXQH/XQfAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738911097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E9j5Xs0mZ6wtU6j7VFVCEoj4y6f/ta7EoSkwrrk+4pQ=;
	b=ZGFi75+6VoBbxJKTYGHdLOqDel7a7DxCz98Kn6hUCKkf9rgLKGQiT2WNbiXitr4RZbiWXH
	9HfjpsKod28XBYaGPEe7o7qEDLEVNqA5xbOoNnhSQm6nUSVaUEmf/zIJ3AodgqJa7uQung
	TH0PRGnszPOsQAxnulyGEtGSRQMZwUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738911097;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E9j5Xs0mZ6wtU6j7VFVCEoj4y6f/ta7EoSkwrrk+4pQ=;
	b=VYb8ziXwpnoAKjJFt4BQcCLxYuW5JPfDgGNs61Q241dkAgg7k3Vmax3ISXioG6cDJzp0HT
	r1xy3RCXQH/XQfAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 30CFD139CB;
	Fri,  7 Feb 2025 06:51:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gbSGNXatpWfKLgAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 07 Feb 2025 06:51:34 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Kent Overstreet" <kent.overstreet@linux.dev>,
 "Christian Brauner" <brauner@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>
cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2 v2] VFS: change kern_path_locked() and
 user_path_locked_at() to never return negative dentry
In-reply-to: <7mxksfnkamzqromejfknfsat6cah4taggprj3wxdoputvvwc7f@qnjsm36bsrex>
References:
 <>, <7mxksfnkamzqromejfknfsat6cah4taggprj3wxdoputvvwc7f@qnjsm36bsrex>
Date: Fri, 07 Feb 2025 17:51:28 +1100
Message-id: <173891108813.22054.3457231434034001354@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 


No callers of kern_path_locked() want a negative dentry.  So change it
to return -ENOENT instead.  This simplifies callers.

user_path_locked() needs to still return a negative dentry.  The only
caller of user_path_locked() wants a negative dentry so it can give the
correct -EXDEV error when given a path on a different filesystem even
when the final component of the path doesn't exist.

Signed-off-by: NeilBrown <neilb@suse.de>
---

This is an alternate version of 1/2 which doesn't change
user_path_locked_at() or bcachefs.  I'm only sending it to VFS emails
and Kent.
Please let me know if it is OK but you would rather I resent the whole
series.=20

Thanks,
NeilBrown


 drivers/base/devtmpfs.c | 65 +++++++++++++++++++----------------------
 fs/namei.c              | 13 +++++++--
 kernel/audit_watch.c    | 12 ++++----
 3 files changed, 46 insertions(+), 44 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index b848764ef018..c9e34842139f 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -245,15 +245,12 @@ static int dev_rmdir(const char *name)
 	dentry =3D kern_path_locked(name, &parent);
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
-	if (d_really_is_positive(dentry)) {
-		if (d_inode(dentry)->i_private =3D=3D &thread)
-			err =3D vfs_rmdir(&nop_mnt_idmap, d_inode(parent.dentry),
-					dentry);
-		else
-			err =3D -EPERM;
-	} else {
-		err =3D -ENOENT;
-	}
+	if (d_inode(dentry)->i_private =3D=3D &thread)
+		err =3D vfs_rmdir(&nop_mnt_idmap, d_inode(parent.dentry),
+				dentry);
+	else
+		err =3D -EPERM;
+
 	dput(dentry);
 	inode_unlock(d_inode(parent.dentry));
 	path_put(&parent);
@@ -310,6 +307,8 @@ static int handle_remove(const char *nodename, struct dev=
ice *dev)
 {
 	struct path parent;
 	struct dentry *dentry;
+	struct kstat stat;
+	struct path p;
 	int deleted =3D 0;
 	int err;
=20
@@ -317,32 +316,28 @@ static int handle_remove(const char *nodename, struct d=
evice *dev)
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
=20
-	if (d_really_is_positive(dentry)) {
-		struct kstat stat;
-		struct path p =3D {.mnt =3D parent.mnt, .dentry =3D dentry};
-		err =3D vfs_getattr(&p, &stat, STATX_TYPE | STATX_MODE,
-				  AT_STATX_SYNC_AS_STAT);
-		if (!err && dev_mynode(dev, d_inode(dentry), &stat)) {
-			struct iattr newattrs;
-			/*
-			 * before unlinking this node, reset permissions
-			 * of possible references like hardlinks
-			 */
-			newattrs.ia_uid =3D GLOBAL_ROOT_UID;
-			newattrs.ia_gid =3D GLOBAL_ROOT_GID;
-			newattrs.ia_mode =3D stat.mode & ~0777;
-			newattrs.ia_valid =3D
-				ATTR_UID|ATTR_GID|ATTR_MODE;
-			inode_lock(d_inode(dentry));
-			notify_change(&nop_mnt_idmap, dentry, &newattrs, NULL);
-			inode_unlock(d_inode(dentry));
-			err =3D vfs_unlink(&nop_mnt_idmap, d_inode(parent.dentry),
-					 dentry, NULL);
-			if (!err || err =3D=3D -ENOENT)
-				deleted =3D 1;
-		}
-	} else {
-		err =3D -ENOENT;
+	p.mnt =3D parent.mnt;
+	p.dentry =3D dentry;
+	err =3D vfs_getattr(&p, &stat, STATX_TYPE | STATX_MODE,
+			  AT_STATX_SYNC_AS_STAT);
+	if (!err && dev_mynode(dev, d_inode(dentry), &stat)) {
+		struct iattr newattrs;
+		/*
+		 * before unlinking this node, reset permissions
+		 * of possible references like hardlinks
+		 */
+		newattrs.ia_uid =3D GLOBAL_ROOT_UID;
+		newattrs.ia_gid =3D GLOBAL_ROOT_GID;
+		newattrs.ia_mode =3D stat.mode & ~0777;
+		newattrs.ia_valid =3D
+			ATTR_UID|ATTR_GID|ATTR_MODE;
+		inode_lock(d_inode(dentry));
+		notify_change(&nop_mnt_idmap, dentry, &newattrs, NULL);
+		inode_unlock(d_inode(dentry));
+		err =3D vfs_unlink(&nop_mnt_idmap, d_inode(parent.dentry),
+				 dentry, NULL);
+		if (!err || err =3D=3D -ENOENT)
+			deleted =3D 1;
 	}
 	dput(dentry);
 	inode_unlock(d_inode(parent.dentry));
diff --git a/fs/namei.c b/fs/namei.c
index 3a4039acdb3f..e53427083342 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2721,7 +2721,8 @@ static int filename_parentat(int dfd, struct filename *=
name,
 }
=20
 /* does lookup, returns the object with parent locked */
-static struct dentry *__kern_path_locked(int dfd, struct filename *name, str=
uct path *path)
+static struct dentry *__kern_path_locked(int dfd, struct filename *name,
+					 struct path *path, bool require_positive)
 {
 	struct dentry *d;
 	struct qstr last;
@@ -2736,6 +2737,10 @@ static struct dentry *__kern_path_locked(int dfd, stru=
ct filename *name, struct
 	}
 	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
 	d =3D lookup_one_qstr_excl(&last, path->dentry, 0);
+	if (!IS_ERR(d) && d_is_negative(d) && !require_positive) {
+		dput(d);
+		d =3D ERR_PTR(-ENOENT);
+	}
 	if (IS_ERR(d)) {
 		inode_unlock(path->dentry->d_inode);
 		path_put(path);
@@ -2743,19 +2748,21 @@ static struct dentry *__kern_path_locked(int dfd, str=
uct filename *name, struct
 	return d;
 }
=20
+/* kern_path_locked() always returns a positive dentry or an error */
 struct dentry *kern_path_locked(const char *name, struct path *path)
 {
 	struct filename *filename =3D getname_kernel(name);
-	struct dentry *res =3D __kern_path_locked(AT_FDCWD, filename, path);
+	struct dentry *res =3D __kern_path_locked(AT_FDCWD, filename, path, true);
=20
 	putname(filename);
 	return res;
 }
=20
+/* user_path_locks() may return a negative dentry */
 struct dentry *user_path_locked_at(int dfd, const char __user *name, struct =
path *path)
 {
 	struct filename *filename =3D getname(name);
-	struct dentry *res =3D __kern_path_locked(dfd, filename, path);
+	struct dentry *res =3D __kern_path_locked(dfd, filename, path, false);
=20
 	putname(filename);
 	return res;
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 7f358740e958..e3130675ee6b 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -350,11 +350,10 @@ static int audit_get_nd(struct audit_watch *watch, stru=
ct path *parent)
 	struct dentry *d =3D kern_path_locked(watch->path, parent);
 	if (IS_ERR(d))
 		return PTR_ERR(d);
-	if (d_is_positive(d)) {
-		/* update watch filter fields */
-		watch->dev =3D d->d_sb->s_dev;
-		watch->ino =3D d_backing_inode(d)->i_ino;
-	}
+	/* update watch filter fields */
+	watch->dev =3D d->d_sb->s_dev;
+	watch->ino =3D d_backing_inode(d)->i_ino;
+
 	inode_unlock(d_backing_inode(parent->dentry));
 	dput(d);
 	return 0;
@@ -419,7 +418,7 @@ int audit_add_watch(struct audit_krule *krule, struct lis=
t_head **list)
 	/* caller expects mutex locked */
 	mutex_lock(&audit_filter_mutex);
=20
-	if (ret) {
+	if (ret && ret !=3D -ENOENT) {
 		audit_put_watch(watch);
 		return ret;
 	}
@@ -438,6 +437,7 @@ int audit_add_watch(struct audit_krule *krule, struct lis=
t_head **list)
=20
 	h =3D audit_hash_ino((u32)watch->ino);
 	*list =3D &audit_inode_hash[h];
+	ret =3D 0;
 error:
 	path_put(&parent_path);
 	audit_put_watch(watch);
--=20
2.47.1


