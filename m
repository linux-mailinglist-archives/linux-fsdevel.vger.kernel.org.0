Return-Path: <linux-fsdevel+bounces-25340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC0D94AFBB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 20:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 795191C2135A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 18:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE21143759;
	Wed,  7 Aug 2024 18:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Irkx4usb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LMDhWOSN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Irkx4usb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LMDhWOSN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201C813DDDF
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Aug 2024 18:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723055409; cv=none; b=Q0JKurY5KdST+xKdYd78C/XTck07iP7EUnZMQXpzEuZr/qg7kzPQxblNJo3Gv3cpcaCkekU+9v1Hb2pfFrBXnoN4xbdxRUn6u1OnPAnIHZGoHkwPCih9cQcZdL6rJYmtyEv0mY/2QS6dLroHL4OaDVG2SaraZAXm9H63hbYGHPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723055409; c=relaxed/simple;
	bh=aelp7K/w47cwgXXwilgnQVd3tgLB6rycTPPQJCXhfB8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bHgqztRkpmDbZmibkvD+sa4RmdqysQ8fZcujJv9/wXnCmwsQF+DNLSI9w2VhLawPDap4yzatd1g6wUqyUHrRaxteEe2ANsxw/E77zyoeWPg9URtEWi868r5s93T+o70RlJkFaTCMKqjYMQx4cXjKbZCumoz0yjxZHHDGZWFzNGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Irkx4usb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LMDhWOSN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Irkx4usb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LMDhWOSN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7AE2021CA3;
	Wed,  7 Aug 2024 18:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723055405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DhYhOhTuekMwxl0QM9IpRdA8iIOSD8F0EEqUAlIvfOs=;
	b=Irkx4usbJzwFv+VC+kxGOBFPgcPhT9qA4PfFkJ61+EHaR7K+Z/IedfkARN3YkunGmGIQq1
	5Y6BQSJgTvErfkNHH64iO45FQtBBkoJOaHpV6PaQ41NhM5jUZ6Dc6BT8DO77hdneYIK6Jx
	Ciou3bAcWWoFWUcpVdsBZSN6C08Rx0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723055405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DhYhOhTuekMwxl0QM9IpRdA8iIOSD8F0EEqUAlIvfOs=;
	b=LMDhWOSN8zY3BoB+T4j0F0m2LN7gB5gsGuVcRa3mGHGhBGUEkYQsCwQea4iILm7tfT9Xwa
	8795UNLood5H28Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723055405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DhYhOhTuekMwxl0QM9IpRdA8iIOSD8F0EEqUAlIvfOs=;
	b=Irkx4usbJzwFv+VC+kxGOBFPgcPhT9qA4PfFkJ61+EHaR7K+Z/IedfkARN3YkunGmGIQq1
	5Y6BQSJgTvErfkNHH64iO45FQtBBkoJOaHpV6PaQ41NhM5jUZ6Dc6BT8DO77hdneYIK6Jx
	Ciou3bAcWWoFWUcpVdsBZSN6C08Rx0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723055405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DhYhOhTuekMwxl0QM9IpRdA8iIOSD8F0EEqUAlIvfOs=;
	b=LMDhWOSN8zY3BoB+T4j0F0m2LN7gB5gsGuVcRa3mGHGhBGUEkYQsCwQea4iILm7tfT9Xwa
	8795UNLood5H28Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 64CEA13B0B;
	Wed,  7 Aug 2024 18:30:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +lGbGCy9s2Z4NAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 07 Aug 2024 18:30:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C8DE9A0886; Wed,  7 Aug 2024 20:30:03 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Dave Chinner <david@fromorbit.com>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 07/13] overlayfs: Make ovl_start_write() return error
Date: Wed,  7 Aug 2024 20:29:52 +0200
Message-Id: <20240807183003.23562-7-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240807180706.30713-1-jack@suse.cz>
References: <20240807180706.30713-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5325; i=jack@suse.cz; h=from:subject; bh=aelp7K/w47cwgXXwilgnQVd3tgLB6rycTPPQJCXhfB8=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBms70fAqNbLgNhRBnSPyC873ZT8T9z9kf+hon3SAc9 hWtFZsWJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZrO9HwAKCRCcnaoHP2RA2TCDCA C/3riMQkfkSx4uaPIumjJBFD2ZmYc0k6psO08YR6Pnhp2EvunK+6RQapjwEbm6QT0tvM1p5ibL7p4c BHIaVU+Lp8SXM2Ey0CVQ7lpQebW27xvqjUxrX8wyGCbfIbyUppE1e5jZatrVFkKCehbG2icSsh7IDQ eV83sr0OBpe/7ybBPz+yjWvN5WblOUHEGPhOOoRpzewFN+GSB9GuyVuky+C38p5CLz+PYbCjU5ii+e 1fh9e5FFHq+fH8TSHk4ncPX3QLV70hy1P/6umppbSuBAXiAnI6WtIEYV1SmszMYl2EUWCgONsIec0n 5QiHKzr9Ooqf7AsCz98S2M+0lJ4vt9
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.80

sb_start_write() will be returning error for a shutdown filesystem.
Teach all ovl_start_write() to handle the error and bail out.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/overlayfs/copy_up.c   | 42 +++++++++++++++++++++++++++++++---------
 fs/overlayfs/overlayfs.h |  2 +-
 fs/overlayfs/util.c      |  3 ++-
 3 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index a5ef2005a2cc..6ebfd9c7b260 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -584,7 +584,9 @@ static int ovl_link_up(struct ovl_copy_up_ctx *c)
 	struct ovl_fs *ofs = OVL_FS(c->dentry->d_sb);
 	struct inode *udir = d_inode(upperdir);
 
-	ovl_start_write(c->dentry);
+	err = ovl_start_write(c->dentry);
+	if (err)
+		return err;
 
 	/* Mark parent "impure" because it may now contain non-pure upper */
 	err = ovl_set_impure(c->parent, upperdir);
@@ -744,6 +746,7 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	struct path path = { .mnt = ovl_upper_mnt(ofs) };
 	struct dentry *temp, *upper, *trap;
 	struct ovl_cu_creds cc;
+	bool frozen = false;
 	int err;
 	struct ovl_cattr cattr = {
 		/* Can't properly set mode on creation because of the umask */
@@ -756,7 +759,11 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	if (err)
 		return err;
 
-	ovl_start_write(c->dentry);
+	err = ovl_start_write(c->dentry);
+	if (err) {
+		ovl_revert_cu_creds(&cc);
+		return err;
+	}
 	inode_lock(wdir);
 	temp = ovl_create_temp(ofs, c->workdir, &cattr);
 	inode_unlock(wdir);
@@ -778,7 +785,10 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	 * ovl_copy_up_data(), so lock workdir and destdir and make sure that
 	 * temp wasn't moved before copy up completion or cleanup.
 	 */
-	ovl_start_write(c->dentry);
+	if (!err) {
+		err = ovl_start_write(c->dentry);
+		frozen = !err;
+	}
 	trap = lock_rename(c->workdir, c->destdir);
 	if (trap || temp->d_parent != c->workdir) {
 		/* temp or workdir moved underneath us? abort without cleanup */
@@ -827,7 +837,8 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 unlock:
 	unlock_rename(c->workdir, c->destdir);
 out:
-	ovl_end_write(c->dentry);
+	if (frozen)
+		ovl_end_write(c->dentry);
 
 	return err;
 
@@ -851,7 +862,11 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_ctx *c)
 	if (err)
 		return err;
 
-	ovl_start_write(c->dentry);
+	err = ovl_start_write(c->dentry);
+	if (err) {
+		ovl_revert_cu_creds(&cc);
+		return err;
+	}
 	tmpfile = ovl_do_tmpfile(ofs, c->workdir, c->stat.mode);
 	ovl_end_write(c->dentry);
 	ovl_revert_cu_creds(&cc);
@@ -865,7 +880,9 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_ctx *c)
 			goto out_fput;
 	}
 
-	ovl_start_write(c->dentry);
+	err = ovl_start_write(c->dentry);
+	if (err)
+		goto out_fput;
 
 	err = ovl_copy_up_metadata(c, temp);
 	if (err)
@@ -964,7 +981,9 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
 		 * Mark parent "impure" because it may now contain non-pure
 		 * upper
 		 */
-		ovl_start_write(c->dentry);
+		err = ovl_start_write(c->dentry);
+		if (err)
+			goto out_free_fh;
 		err = ovl_set_impure(c->parent, c->destdir);
 		ovl_end_write(c->dentry);
 		if (err)
@@ -982,7 +1001,9 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
 	if (c->indexed)
 		ovl_set_flag(OVL_INDEX, d_inode(c->dentry));
 
-	ovl_start_write(c->dentry);
+	err = ovl_start_write(c->dentry);
+	if (err)
+		goto out;
 	if (to_index) {
 		/* Initialize nlink for copy up of disconnected dentry */
 		err = ovl_set_nlink_upper(c->dentry);
@@ -1088,7 +1109,10 @@ static int ovl_copy_up_meta_inode_data(struct ovl_copy_up_ctx *c)
 	 * Writing to upper file will clear security.capability xattr. We
 	 * don't want that to happen for normal copy-up operation.
 	 */
-	ovl_start_write(c->dentry);
+	err = ovl_start_write(c->dentry);
+	if (err)
+		goto out_free;
+
 	if (capability) {
 		err = ovl_do_setxattr(ofs, upperpath.dentry, XATTR_NAME_CAPS,
 				      capability, cap_size, 0);
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 0bfe35da4b7b..ee8f2b28159a 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -423,7 +423,7 @@ static inline int ovl_do_getattr(const struct path *path, struct kstat *stat,
 /* util.c */
 int ovl_get_write_access(struct dentry *dentry);
 void ovl_put_write_access(struct dentry *dentry);
-void ovl_start_write(struct dentry *dentry);
+int __must_check ovl_start_write(struct dentry *dentry);
 void ovl_end_write(struct dentry *dentry);
 int ovl_want_write(struct dentry *dentry);
 void ovl_drop_write(struct dentry *dentry);
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index edc9216f6e27..b53fa14506a9 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -25,10 +25,11 @@ int ovl_get_write_access(struct dentry *dentry)
 }
 
 /* Get write access to upper sb - may block if upper sb is frozen */
-void ovl_start_write(struct dentry *dentry)
+int __must_check ovl_start_write(struct dentry *dentry)
 {
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	sb_start_write(ovl_upper_mnt(ofs)->mnt_sb);
+	return 0;
 }
 
 int ovl_want_write(struct dentry *dentry)
-- 
2.35.3


