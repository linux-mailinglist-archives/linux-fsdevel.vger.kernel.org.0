Return-Path: <linux-fsdevel+bounces-42738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7475CA47195
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 02:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D3833A123E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 01:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8DA19F104;
	Thu, 27 Feb 2025 01:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SHyroeTV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4ZPSS4K1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SHyroeTV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4ZPSS4K1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF8B1465A1
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2025 01:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740620448; cv=none; b=EKraZxo1PP4pnBasED6W76Tp2OhMf587iuKmpXS7Rudhl7cpo4TnmkDJVHNf8hajvmmk7HdsH0Rgwq8A9YpP8y3oVeBeuosKmghua62amlHueu0GXYQlaOT5xne3VhQuTl98ns2XZTprfaAySKgqGhLdG1y29TCBSwWJn2lN+O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740620448; c=relaxed/simple;
	bh=tCpt507iFmDykSLM+0jeNdmp6tN2z3F/Ee9xo97HGeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s7K0La43BNPlD+/49ISDdJ/RtSGBJa/hhFBkmoy0cE/3zx8K1Do8UQow7DMn+JdKjdlZy9BRoVe5jKKAOhcvRCb1jgJRZARkif4T0ovTm8j79uH3dLrHag+c+YVbzfL+srW3kEX4ZCe2LjvCszQEpJ2og6N92XZqL4n20vgwv8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SHyroeTV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4ZPSS4K1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SHyroeTV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4ZPSS4K1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B44ED21186;
	Thu, 27 Feb 2025 01:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740620445; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HpsssM3bSMTiY4nGx2PiIOfNYtj975+x+AQWsDXV3Ac=;
	b=SHyroeTVlvqnzjfvZrVeCxtsLmigWd4IggPE+WI2Bkxq7SI5eO4R2XgRaMZrWy+9VcQhqA
	KpTbaLjGsd+PD+iutmN8lRSXzI65zpYAPJvL5/WZC4+pJZuhN7WF92jD7jOkV+m5tQela2
	EmfAn/QE4thkAv/LJTCS/GF/ZlXLOCE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740620445;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HpsssM3bSMTiY4nGx2PiIOfNYtj975+x+AQWsDXV3Ac=;
	b=4ZPSS4K1c4jTVduJLmMbptL9zrth0ZhPl5JCSPS9Dxqdn6uI9mDnlqNpZbMObVyIW36blD
	KBUmnZaiojPNRaAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740620445; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HpsssM3bSMTiY4nGx2PiIOfNYtj975+x+AQWsDXV3Ac=;
	b=SHyroeTVlvqnzjfvZrVeCxtsLmigWd4IggPE+WI2Bkxq7SI5eO4R2XgRaMZrWy+9VcQhqA
	KpTbaLjGsd+PD+iutmN8lRSXzI65zpYAPJvL5/WZC4+pJZuhN7WF92jD7jOkV+m5tQela2
	EmfAn/QE4thkAv/LJTCS/GF/ZlXLOCE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740620445;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HpsssM3bSMTiY4nGx2PiIOfNYtj975+x+AQWsDXV3Ac=;
	b=4ZPSS4K1c4jTVduJLmMbptL9zrth0ZhPl5JCSPS9Dxqdn6uI9mDnlqNpZbMObVyIW36blD
	KBUmnZaiojPNRaAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 85409134A0;
	Thu, 27 Feb 2025 01:40:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UcubDpfCv2f+EQAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 27 Feb 2025 01:40:39 +0000
From: NeilBrown <neilb@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org,
	Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubli@redhat.com>,
	ceph-devel@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] fuse: return correct dentry for ->mkdir
Date: Thu, 27 Feb 2025 12:32:56 +1100
Message-ID: <20250227013949.536172-5-neilb@suse.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227013949.536172-1-neilb@suse.de>
References: <20250227013949.536172-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,kernel.org,vger.kernel.org,gmail.com,redhat.com,szeredi.hu,nod.at,cambridgegreys.com,sipsolutions.net,lists.infradead.org];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	R_RATELIMIT(0.00)[to_ip_from(RL99f7qjgz3j4qaff4fhggowz5),from(RLewrxuus8mos16izbn)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -2.80
X-Spam-Flag: NO

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
 fs/fuse/dir.c | 48 +++++++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index d0289ce068ba..2779ebf2b3b9 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -781,9 +781,9 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 /*
  * Code shared between mknod, mkdir, symlink and link
  */
-static int create_new_entry(struct mnt_idmap *idmap, struct fuse_mount *fm,
-			    struct fuse_args *args, struct inode *dir,
-			    struct dentry *entry, umode_t mode)
+static struct dentry *create_new_entry(struct mnt_idmap *idmap, struct fuse_mount *fm,
+				       struct fuse_args *args, struct inode *dir,
+				       struct dentry *entry, umode_t mode)
 {
 	struct fuse_entry_out outarg;
 	struct inode *inode;
@@ -792,11 +792,11 @@ static int create_new_entry(struct mnt_idmap *idmap, struct fuse_mount *fm,
 	struct fuse_forget_link *forget;
 
 	if (fuse_is_bad(dir))
-		return -EIO;
+		return ERR_PTR(-EIO);
 
 	forget = fuse_alloc_forget();
 	if (!forget)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	memset(&outarg, 0, sizeof(outarg));
 	args->nodeid = get_node_id(dir);
@@ -826,29 +826,27 @@ static int create_new_entry(struct mnt_idmap *idmap, struct fuse_mount *fm,
 			  &outarg.attr, ATTR_TIMEOUT(&outarg), 0, 0);
 	if (!inode) {
 		fuse_queue_forget(fm->fc, forget, outarg.nodeid, 1);
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 	}
 	kfree(forget);
 
 	d_drop(entry);
 	d = d_splice_alias(inode, entry);
 	if (IS_ERR(d))
-		return PTR_ERR(d);
+		return d;
 
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
 
  out_put_forget_req:
 	if (err == -EEXIST)
 		fuse_invalidate_entry(entry);
 	kfree(forget);
-	return err;
+	return ERR_PTR(err);
 }
 
 static int fuse_mknod(struct mnt_idmap *idmap, struct inode *dir,
@@ -856,6 +854,7 @@ static int fuse_mknod(struct mnt_idmap *idmap, struct inode *dir,
 {
 	struct fuse_mknod_in inarg;
 	struct fuse_mount *fm = get_fuse_mount(dir);
+	struct dentry *de;
 	FUSE_ARGS(args);
 
 	if (!fm->fc->dont_mask)
@@ -871,7 +870,10 @@ static int fuse_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	args.in_args[0].value = &inarg;
 	args.in_args[1].size = entry->d_name.len + 1;
 	args.in_args[1].value = entry->d_name.name;
-	return create_new_entry(idmap, fm, &args, dir, entry, mode);
+	de = create_new_entry(idmap, fm, &args, dir, entry, mode);
+	if (IS_ERR(de))
+		return PTR_ERR(de);
+	return 0;
 }
 
 static int fuse_create(struct mnt_idmap *idmap, struct inode *dir,
@@ -917,7 +919,7 @@ static struct dentry *fuse_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	args.in_args[0].value = &inarg;
 	args.in_args[1].size = entry->d_name.len + 1;
 	args.in_args[1].value = entry->d_name.name;
-	return ERR_PTR(create_new_entry(idmap, fm, &args, dir, entry, S_IFDIR));
+	return create_new_entry(idmap, fm, &args, dir, entry, S_IFDIR);
 }
 
 static int fuse_symlink(struct mnt_idmap *idmap, struct inode *dir,
@@ -925,6 +927,7 @@ static int fuse_symlink(struct mnt_idmap *idmap, struct inode *dir,
 {
 	struct fuse_mount *fm = get_fuse_mount(dir);
 	unsigned len = strlen(link) + 1;
+	struct dentry *de;
 	FUSE_ARGS(args);
 
 	args.opcode = FUSE_SYMLINK;
@@ -934,7 +937,10 @@ static int fuse_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	args.in_args[1].value = entry->d_name.name;
 	args.in_args[2].size = len;
 	args.in_args[2].value = link;
-	return create_new_entry(idmap, fm, &args, dir, entry, S_IFLNK);
+	de = create_new_entry(idmap, fm, &args, dir, entry, S_IFLNK);
+	if (IS_ERR(de))
+		return PTR_ERR(de);
+	return 0;
 }
 
 void fuse_flush_time_update(struct inode *inode)
@@ -1117,7 +1123,7 @@ static int fuse_rename2(struct mnt_idmap *idmap, struct inode *olddir,
 static int fuse_link(struct dentry *entry, struct inode *newdir,
 		     struct dentry *newent)
 {
-	int err;
+	struct dentry *de;
 	struct fuse_link_in inarg;
 	struct inode *inode = d_inode(entry);
 	struct fuse_mount *fm = get_fuse_mount(inode);
@@ -1131,13 +1137,13 @@ static int fuse_link(struct dentry *entry, struct inode *newdir,
 	args.in_args[0].value = &inarg;
 	args.in_args[1].size = newent->d_name.len + 1;
 	args.in_args[1].value = newent->d_name.name;
-	err = create_new_entry(&invalid_mnt_idmap, fm, &args, newdir, newent, inode->i_mode);
-	if (!err)
+	de = create_new_entry(&invalid_mnt_idmap, fm, &args, newdir, newent, inode->i_mode);
+	if (!IS_ERR(de))
 		fuse_update_ctime_in_cache(inode);
-	else if (err == -EINTR)
+	else if (PTR_ERR(de) == -EINTR)
 		fuse_invalidate_attr(inode);
 
-	return err;
+	return PTR_ERR(de);
 }
 
 static void fuse_fillattr(struct mnt_idmap *idmap, struct inode *inode,
-- 
2.48.1


