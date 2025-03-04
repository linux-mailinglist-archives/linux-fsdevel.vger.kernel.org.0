Return-Path: <linux-fsdevel+bounces-43181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF46A4EF89
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 22:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABB3C3AA28E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 21:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791D0264F8C;
	Tue,  4 Mar 2025 21:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zBR//K0H";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Sfyy+Wm5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vIA7yxbp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KS5YkmFr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022CC24C085
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 21:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741124918; cv=none; b=HgIT5GINm/SR0GD8HE92vPpUcxap18fKDvJ7++v7StT7QIrTi+i7BrD/luq7IzXTMcEJda3hh3nYv0GrMp+kAf0I/pGzQVhEZXp/dZhFF9gqxkEP7viwcqraWTL1ThSxBdu4qm+nyxMRZSWGxmY8pWNoAK/YQJ6Tjd45rSLIlgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741124918; c=relaxed/simple;
	bh=pCVLLuxek3bUk5qBpkIjOZF+Xauo1myEVPouhTYzhsE=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=pyVdGcNiZbmBE1jgyvnzHQvO9aE/fdEF+a6r+CkUsZuTKKH6NTdhNqtaNl+Hpp9CTn6Et7zj2rRymgIlpD9h3tjBiBsG6e1BjJINHiDtyPSedksvqykCsA5hKpwxvQ9nb4GYMjvTpzYIjlD2m6Sto9KAnh0k2E1k6Xo2buzuax4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zBR//K0H; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Sfyy+Wm5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vIA7yxbp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KS5YkmFr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EDD9F21168;
	Tue,  4 Mar 2025 21:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741124915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bX4IMw/eYOxOFV044cg6lar1/3a+2fllXZS9auhZXXM=;
	b=zBR//K0HMoJ/YhGdJs58LuvYxmik1loF9eqalRjgpnJv8HnmR8ytsQmTHP3UWKoNPZiQMZ
	2ORendZN21tcpon13z4Nw6sXEtvKYosVaEwfghSUHUGRsQ4QOFJxb2Tz0oMhIivQFP/yp+
	fOxuhVk4J5BL843lvhBp6ac8SrmG0pA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741124915;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bX4IMw/eYOxOFV044cg6lar1/3a+2fllXZS9auhZXXM=;
	b=Sfyy+Wm52mc4tH5U7Qxjvw21CisT0gLAxP5cEnqXwIqSf0YlTZTOC0/YA+myxaLMX9h7Gp
	1pdJQQxOfBpa4FDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vIA7yxbp;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KS5YkmFr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741124913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bX4IMw/eYOxOFV044cg6lar1/3a+2fllXZS9auhZXXM=;
	b=vIA7yxbppBkUlNdlpIn5WyrLJDzCa6sxDiG1pXXbTq7svkbo0aXQ62E5ZP8PNO6qf5oxv8
	XDxnR3rhV3lROd1nWOpovdoadE7hdtn6uElKC9cqgvGxOxBz8wXYoNoelmOkxs6xoLopka
	cuJDkAj6A1eQyY/t68ibgShBYnHCxnM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741124913;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bX4IMw/eYOxOFV044cg6lar1/3a+2fllXZS9auhZXXM=;
	b=KS5YkmFrakP+hBPlX/OaaPOX6hS9p9VCFeSjsg4IbH5tSBzgRDfB6wast/hKDJzXRKFveo
	Nuf1PaTESxQDBnCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E31C13967;
	Tue,  4 Mar 2025 21:48:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /FE8MCt1x2cGNAAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 04 Mar 2025 21:48:27 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Miklos Szeredi" <miklos@szeredi.hu>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 linux-nfs@vger.kernel.org, "Ilya Dryomov" <idryomov@gmail.com>,
 "Xiubo Li" <xiubli@redhat.com>, ceph-devel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>, linux-um@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 4/6 - REVISED] fuse: return correct dentry for ->mkdir
In-reply-to:
 <CAJfpegtu1xs-FifNfc2VpQuhBjbniTqUcE+H=uNpdYW=cOSGkw@mail.gmail.com>
References:
 <>, <CAJfpegtu1xs-FifNfc2VpQuhBjbniTqUcE+H=uNpdYW=cOSGkw@mail.gmail.com>
Date: Wed, 05 Mar 2025 08:48:20 +1100
Message-id: <174112490070.33508.15852253149143067890@noble.neil.brown.name>
X-Rspamd-Queue-Id: EDD9F21168
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,vger.kernel.org,gmail.com,redhat.com,nod.at,cambridgegreys.com,sipsolutions.net,lists.infradead.org];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 


Subject: [PATCH] fuse: return correct dentry for ->mkdir

fuse already uses d_splice_alias() to ensure an appropriate dentry is
found for a newly created dentry.  Now that ->mkdir can return that
dentry we do so.

This requires changing create_new_entry() to return a dentry and
handling that change in all callers.

Note that when create_new_entry() is asked to create anything other than
a directory we can be sure it will NOT return an alternate dentry as
d_splice_alias() only returns an alternate dentry for directories.
So we don't need to check for that case when passing one the result.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/fuse/dir.c | 48 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 17 deletions(-)

Thanks for the suggestion Miklos - this looks much better.

Christian: could you please replace the fuse patch in your tree
with this version?  Thanks.

NeilBrown


diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index d0289ce068ba..fa8f1141ea74 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -781,9 +781,9 @@ static int fuse_atomic_open(struct inode *dir, struct den=
try *entry,
 /*
  * Code shared between mknod, mkdir, symlink and link
  */
-static int create_new_entry(struct mnt_idmap *idmap, struct fuse_mount *fm,
-			    struct fuse_args *args, struct inode *dir,
-			    struct dentry *entry, umode_t mode)
+static struct dentry *create_new_entry(struct mnt_idmap *idmap, struct fuse_=
mount *fm,
+				       struct fuse_args *args, struct inode *dir,
+				       struct dentry *entry, umode_t mode)
 {
 	struct fuse_entry_out outarg;
 	struct inode *inode;
@@ -792,11 +792,11 @@ static int create_new_entry(struct mnt_idmap *idmap, st=
ruct fuse_mount *fm,
 	struct fuse_forget_link *forget;
=20
 	if (fuse_is_bad(dir))
-		return -EIO;
+		return ERR_PTR(-EIO);
=20
 	forget =3D fuse_alloc_forget();
 	if (!forget)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
=20
 	memset(&outarg, 0, sizeof(outarg));
 	args->nodeid =3D get_node_id(dir);
@@ -826,29 +826,43 @@ static int create_new_entry(struct mnt_idmap *idmap, st=
ruct fuse_mount *fm,
 			  &outarg.attr, ATTR_TIMEOUT(&outarg), 0, 0);
 	if (!inode) {
 		fuse_queue_forget(fm->fc, forget, outarg.nodeid, 1);
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 	}
 	kfree(forget);
=20
 	d_drop(entry);
 	d =3D d_splice_alias(inode, entry);
 	if (IS_ERR(d))
-		return PTR_ERR(d);
+		return d;
=20
-	if (d) {
+	if (d)
 		fuse_change_entry_timeout(d, &outarg);
-		dput(d);
-	} else {
+	else
 		fuse_change_entry_timeout(entry, &outarg);
-	}
 	fuse_dir_changed(dir);
-	return 0;
+	return d;
=20
  out_put_forget_req:
 	if (err =3D=3D -EEXIST)
 		fuse_invalidate_entry(entry);
 	kfree(forget);
-	return err;
+	return ERR_PTR(err);
+}
+
+static int create_new_nondir(struct mnt_idmap *idmap, struct fuse_mount *fm,
+			     struct fuse_args *args, struct inode *dir,
+			     struct dentry *entry, umode_t mode)
+{
+	/*
+	 * Note that when creating anything other than a directory we
+	 * can be sure create_new_entry() will NOT return an alternate
+	 * dentry as d_splice_alias() only returns an alternate dentry
+	 * for directories.  So we don't need to check for that case
+	 * when passing back the result.
+	 */
+	WARN_ON_ONCE(S_ISDIR(mode));
+
+	return PTR_ERR(create_new_entry(idmap, fm, args, dir, entry, mode));
 }
=20
 static int fuse_mknod(struct mnt_idmap *idmap, struct inode *dir,
@@ -871,7 +885,7 @@ static int fuse_mknod(struct mnt_idmap *idmap, struct ino=
de *dir,
 	args.in_args[0].value =3D &inarg;
 	args.in_args[1].size =3D entry->d_name.len + 1;
 	args.in_args[1].value =3D entry->d_name.name;
-	return create_new_entry(idmap, fm, &args, dir, entry, mode);
+	return create_new_nondir(idmap, fm, &args, dir, entry, mode);
 }
=20
 static int fuse_create(struct mnt_idmap *idmap, struct inode *dir,
@@ -917,7 +931,7 @@ static struct dentry *fuse_mkdir(struct mnt_idmap *idmap,=
 struct inode *dir,
 	args.in_args[0].value =3D &inarg;
 	args.in_args[1].size =3D entry->d_name.len + 1;
 	args.in_args[1].value =3D entry->d_name.name;
-	return ERR_PTR(create_new_entry(idmap, fm, &args, dir, entry, S_IFDIR));
+	return create_new_entry(idmap, fm, &args, dir, entry, S_IFDIR);
 }
=20
 static int fuse_symlink(struct mnt_idmap *idmap, struct inode *dir,
@@ -934,7 +948,7 @@ static int fuse_symlink(struct mnt_idmap *idmap, struct i=
node *dir,
 	args.in_args[1].value =3D entry->d_name.name;
 	args.in_args[2].size =3D len;
 	args.in_args[2].value =3D link;
-	return create_new_entry(idmap, fm, &args, dir, entry, S_IFLNK);
+	return create_new_nondir(idmap, fm, &args, dir, entry, S_IFLNK);
 }
=20
 void fuse_flush_time_update(struct inode *inode)
@@ -1131,7 +1145,7 @@ static int fuse_link(struct dentry *entry, struct inode=
 *newdir,
 	args.in_args[0].value =3D &inarg;
 	args.in_args[1].size =3D newent->d_name.len + 1;
 	args.in_args[1].value =3D newent->d_name.name;
-	err =3D create_new_entry(&invalid_mnt_idmap, fm, &args, newdir, newent, ino=
de->i_mode);
+	err =3D create_new_nondir(&invalid_mnt_idmap, fm, &args, newdir, newent, in=
ode->i_mode);
 	if (!err)
 		fuse_update_ctime_in_cache(inode);
 	else if (err =3D=3D -EINTR)
--=20
2.48.1


