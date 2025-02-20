Return-Path: <linux-fsdevel+bounces-42198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D033A3E8D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 00:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B62F18875C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 23:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FAC26A0B3;
	Thu, 20 Feb 2025 23:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uO+E1+1H";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bgVIc5zc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vHh33IOG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8W6nmmm7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1161267B68
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 23:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740095281; cv=none; b=qbWvR6z6lLZxHzccBEy8dHtwtLMucP4b9nEFsZlS32zMuC6hxKcE6YNagu+I973C4+IYKkUi+scE/d462nL+ZCmQqkn2PqUe+XjddURWPdhbsojq7cEMDWI5nUEHSoj3i2n/uEas7NTwitUnFyKE0C8Nbh8tlRumnLNAVXWOnAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740095281; c=relaxed/simple;
	bh=sNFVhiyVdBLbnvbQ65sLSCtqIrmnVsXCtWVAE2KIQBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQo1WxCYZeEkAhSqYYiT1VcEBXDtEQLi8ZbHEcyendVxUAG2dFmqMeVe6K4l+xKQ+SGRhA4kaViQY8BJ0LJ0Evf5dp088S27eC2ztScvJu+XsltsPxIuH4Mca2VS6qCR9s3JNPihpirSJoQvhsPueO9gjaHTDZzXybjrL2y0W2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uO+E1+1H; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bgVIc5zc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vHh33IOG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8W6nmmm7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DAEC71F394;
	Thu, 20 Feb 2025 23:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740095277; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kexmf3pX2VfKhFlop+2oFbn2PMGrvWZX6ZRZ5nKyk3U=;
	b=uO+E1+1Hiar1cfYVQX/8cFdraITK5VQahhP/XOIX3eJCtVoEqAnCdixzPtI6gnph8saGfu
	+BPOysSOuV1kCWYj4Qhd9TZZojySQJuTyQiMo/arbmArpBp+3/jQc7hpa0P6PEUSI/2/ol
	X/i9Cd+LpeeZv1VmA+Gt2jF0SJiwpV0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740095277;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kexmf3pX2VfKhFlop+2oFbn2PMGrvWZX6ZRZ5nKyk3U=;
	b=bgVIc5zcBpU/MRGwC9PnsKp+MvrnX4SmEei9TxUoPRPsOr1gBk7Eem+pvLnTalKChqM6Fy
	v9QaeMJeyXgzC7Bg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vHh33IOG;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8W6nmmm7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740095276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kexmf3pX2VfKhFlop+2oFbn2PMGrvWZX6ZRZ5nKyk3U=;
	b=vHh33IOGwgClwsyHbIMpR3Um3yUtJs+yRtq9JuSOc9Z21RSPP0E7G4SOVRURk8NS/XUBu0
	YRdNqgs+aVk5HtkM2lEIAm9gRprrNWg1NRrM0U0+4M/qmLWaLsig3RcWOiumNZiZaL7eL0
	7gN6RtSpgBHiZNAGJrvKOTRtL0U/6U0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740095276;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kexmf3pX2VfKhFlop+2oFbn2PMGrvWZX6ZRZ5nKyk3U=;
	b=8W6nmmm7wckiHkrrWL1pJx9DQkMsmMfLg55xBqydE/9k/sXAgxofzuXVPo7eGdssG0fBVR
	KsAkDJiMEe6F4dAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF84F13301;
	Thu, 20 Feb 2025 23:47:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id szNRKSS/t2dEAwAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 20 Feb 2025 23:47:48 +0000
From: NeilBrown <neilb@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-um@lists.infradead.org,
	ceph-devel@vger.kernel.org,
	netfs@lists.linux.dev
Subject: [PATCH 4/6] fuse: return correct dentry for ->mkdir
Date: Fri, 21 Feb 2025 10:36:33 +1100
Message-ID: <20250220234630.983190-5-neilb@suse.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250220234630.983190-1-neilb@suse.de>
References: <20250220234630.983190-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DAEC71F394
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,szeredi.hu,redhat.com,gmail.com,nod.at,cambridgegreys.com,sipsolutions.net,oracle.com,talpey.com,chromium.org];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
	FROM_EQ_ENVFROM(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn),to_ip_from(RL41gfrsx5ox46amq79i8sk6fy)];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

fuse already uses d_splice_alias() to ensure an appropriate dentry is
found for a newly created dentry.  Now that ->mkdir can return that
dentry we do so.

This requires changing create_new_entry() to return a dentry and
handling that change in all callers.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/fuse/dir.c | 55 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 5bb65f38bfb8..8c44c9c73c38 100644
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
@@ -871,7 +870,12 @@ static int fuse_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	args.in_args[0].value = &inarg;
 	args.in_args[1].size = entry->d_name.len + 1;
 	args.in_args[1].value = entry->d_name.name;
-	return create_new_entry(idmap, fm, &args, dir, entry, mode);
+	de = create_new_entry(idmap, fm, &args, dir, entry, mode);
+	if (IS_ERR(de))
+		return PTR_ERR(de);
+	if (de)
+		dput(de);
+	return 0;
 }
 
 static int fuse_create(struct mnt_idmap *idmap, struct inode *dir,
@@ -917,7 +921,7 @@ static struct dentry *fuse_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	args.in_args[0].value = &inarg;
 	args.in_args[1].size = entry->d_name.len + 1;
 	args.in_args[1].value = entry->d_name.name;
-	return ERR_PTR(create_new_entry(idmap, fm, &args, dir, entry, S_IFDIR));
+	return create_new_entry(idmap, fm, &args, dir, entry, S_IFDIR);
 }
 
 static int fuse_symlink(struct mnt_idmap *idmap, struct inode *dir,
@@ -925,6 +929,7 @@ static int fuse_symlink(struct mnt_idmap *idmap, struct inode *dir,
 {
 	struct fuse_mount *fm = get_fuse_mount(dir);
 	unsigned len = strlen(link) + 1;
+	struct dentry *de;
 	FUSE_ARGS(args);
 
 	args.opcode = FUSE_SYMLINK;
@@ -934,7 +939,12 @@ static int fuse_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	args.in_args[1].value = entry->d_name.name;
 	args.in_args[2].size = len;
 	args.in_args[2].value = link;
-	return create_new_entry(idmap, fm, &args, dir, entry, S_IFLNK);
+	de = create_new_entry(idmap, fm, &args, dir, entry, S_IFLNK);
+	if (IS_ERR(de))
+		return PTR_ERR(de);
+	if (de)
+		dput(de);
+	return 0;
 }
 
 void fuse_flush_time_update(struct inode *inode)
@@ -1117,7 +1127,7 @@ static int fuse_rename2(struct mnt_idmap *idmap, struct inode *olddir,
 static int fuse_link(struct dentry *entry, struct inode *newdir,
 		     struct dentry *newent)
 {
-	int err;
+	struct dentry *de;
 	struct fuse_link_in inarg;
 	struct inode *inode = d_inode(entry);
 	struct fuse_mount *fm = get_fuse_mount(inode);
@@ -1131,13 +1141,16 @@ static int fuse_link(struct dentry *entry, struct inode *newdir,
 	args.in_args[0].value = &inarg;
 	args.in_args[1].size = newent->d_name.len + 1;
 	args.in_args[1].value = newent->d_name.name;
-	err = create_new_entry(&invalid_mnt_idmap, fm, &args, newdir, newent, inode->i_mode);
-	if (!err)
+	de = create_new_entry(&invalid_mnt_idmap, fm, &args, newdir, newent, inode->i_mode);
+	if (!IS_ERR(de)) {
+		if (de)
+			dput(de);
+		de = NULL;
 		fuse_update_ctime_in_cache(inode);
-	else if (err == -EINTR)
+	} else if (PTR_ERR(de) == -EINTR)
 		fuse_invalidate_attr(inode);
 
-	return err;
+	return PTR_ERR(de);
 }
 
 static void fuse_fillattr(struct mnt_idmap *idmap, struct inode *inode,
-- 
2.47.1


