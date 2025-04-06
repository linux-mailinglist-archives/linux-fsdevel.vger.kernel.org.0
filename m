Return-Path: <linux-fsdevel+bounces-45824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29873A7D07B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Apr 2025 22:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE48E3AE9C2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Apr 2025 20:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06351A262A;
	Sun,  6 Apr 2025 20:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="RP7QWYON";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A3brkeqZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E042E62A8;
	Sun,  6 Apr 2025 20:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743972362; cv=none; b=QSNW1RXP7eL3ztmOnnFIU/qaI2X5UBAi1+izLXPJ7XLQFog3M0TDSvo6fQnp1m5QL04AQnPwuZiZ7LzmMgfcga7cROe2sucVqeHCoVemVNdIhtOPZppTmidlZjA35Eau3AvnE645E86etSbdO8+8tbvXS7DRQd/o32l/6z4OlF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743972362; c=relaxed/simple;
	bh=0hchm3FeyjJjJO2HG5wfFrBkeFUETDnwqD5n55ge7xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a4UWOoF7oAeOT4k5hr6Utl4x2Qp8m2rUpyr+R2vAp2fKhBXGufE7x8D/Gz3v61b3V8/wdoNN0Rmcy0GYRVAbAucCI1XZeT7Kb5bCw4N1bdHWRiusLOp3JuC1+B6XoJ6izr73vtI9kKG7FVBNYJg0LNJoP1dlwoI4Ddc9H8Cv++A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=RP7QWYON; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A3brkeqZ; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailflow.phl.internal (Postfix) with ESMTP id 7D0DB202428;
	Sun,  6 Apr 2025 16:45:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Sun, 06 Apr 2025 16:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1743972359; x=
	1743975959; bh=POOHptp+/dVW3vm3gf8nE0D5rIirz3UAl7VbL7lUWo0=; b=R
	P7QWYONARZeHV3oUUpUNC9Lekb3TXY6Iy8nY+ueZT76ixRXcIamrQye0i96D8AWT
	tJyV9FLSas7RX6ciALTJm9Znqc+uCUErGTq8ChY4WLHaQqV02c06UKciulh6I+Rp
	rHTpe3TIREbZyWgz4xEtyqw6BGiofTN6aq4OSm0av8RBj4bbA/1nVJVw/PfATsyw
	vtKOszmmf3MQTATd4W971No56ujK6+f24kfytitanbEj8Zg47svg2pAbVM/iS3O4
	WO8mJdVq0ma8ZwKZAIN9/fkx9p1tOWBiGIp059p63oJiwvqPGuusZCNb2gycnzP6
	e0VfTk3WBv4SLRc1jq+5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1743972359; x=1743975959; bh=P
	OOHptp+/dVW3vm3gf8nE0D5rIirz3UAl7VbL7lUWo0=; b=A3brkeqZ7Hg1+NL3q
	GVCRN82m0/J8ux+/pT5TgINvOscQUHJBxGjunty6Lr629PBSFhn3l7n+LqwWNtvB
	kadNcnjDBtVtbZfjH4gGQc90qDU7+65I7vp0xM0YPXm5tRKTSt/2QOh+Kpel+1g2
	l3j8JWsRjSKPWR83eBwx0GrQjtIdVSFQGRc5FvMWe84DLLevxswhTSV032aJ2tcT
	F6a0y/9BEBGYNDsf3IymgYab4smYdF9TW5/XXQBDBv+idN4+O8p9C/qzYVENNGPM
	TyVjF2j7RizmkeAHBksJCwyeLWRf4WOwdzgZylq39K1UE9ZeO1IhkZdJNgrdajB9
	B/4gg==
X-ME-Sender: <xms:BujyZ5mwaEMhfDNaukpnzY7q9_g5XXkm0meNOFYBibczpaEJi-H3nA>
    <xme:BujyZ03DPoU0aZhCYWv6JfDlciEGRZMpdvGUQxt33vHaS4JMf-p0_z6s3BWvHFQ8i
    qPlWfHouuu1OfYJLpg>
X-ME-Received: <xmr:BujyZ_qtjOckXyzpGG-6Pl0keiI1o6kOZ7gMdwf97UQGXJSqbk0Js_Rc6J1wev37wsLhBKzRppfHXSpdIFcdBLKtEBdh9Ci6G7_h8Fyi71ec6l-GoZ5ynfk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduleekvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepvfhinhhgmhgrohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqe
    enucggtffrrghtthgvrhhnpeeuuddthefhhefhvdejteevvddvteefffegteetueegueel
    jeefueekjeetieeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghpthhtohepudefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegvrhhitghvhheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheprghsmhgruggvuhhssegtohguvgifrhgvtghkrdhorhhgpdhrtghpthht
    oheplhhutghhohesihhonhhkohhvrdhnvghtpdhrtghpthhtoheplhhinhhugigpohhssh
    estghruhguvggshihtvgdrtghomhdprhgtphhtthhopehmsehmrghofihtmhdrohhrghdp
    rhgtphhtthhopehvlehfsheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhope
    hmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepghhnohgrtghksehgohhoghhl
    vgdrtghomhdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:BujyZ5kbkG4Xk8aKbEhmZjYa7ox2XuLHyY8gWth50D_kBAjtaSR5mA>
    <xmx:BujyZ336duf266ZXKhxIZSXdDb9E-s7cRtjwXgrdur3TQNAb2bc1xA>
    <xmx:BujyZ4uR10SBzszEN68Al1ffjIy4AzeZjDr6Xh-QxFBhnSpBy_ghHg>
    <xmx:BujyZ7VrTSW8qvn519v7SSDQYPUAVYkdQZFbQWTvL6iyBU-KOldIFg>
    <xmx:B-jyZ_q3saMvK72AWN1mtw0CDicZrNU0tTekaDTZAJXW7mhGfvQ-uwcP>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Apr 2025 16:45:57 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Tingmao Wang <m@maowtm.org>,
	v9fs@lists.linux.dev,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Matthew Bobrowski <repnop@google.com>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 4/6] fs/9p: Add ability to identify inode by path for non-.L
Date: Sun,  6 Apr 2025 21:43:05 +0100
Message-ID: <90f6c4c492821407bf0659e5fd16e94db8bf5143.1743971855.git.m@maowtm.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1743971855.git.m@maowtm.org>
References: <cover.1743971855.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This replicates the earlier .L patch for non-.L, and removing some
previously inserted conditionals in shared code.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 fs/9p/v9fs.h      |   7 +--
 fs/9p/vfs_inode.c | 112 +++++++++++++++++++++++++++++++++++++---------
 2 files changed, 96 insertions(+), 23 deletions(-)

diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index b4874fdd925e..3199d516dc8a 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -201,7 +201,8 @@ extern int v9fs_vfs_rename(struct mnt_idmap *idmap,
 			   unsigned int flags);
 extern struct inode *v9fs_inode_from_fid(struct v9fs_session_info *v9ses,
 					 struct p9_fid *fid,
-					 struct super_block *sb, int new);
+					 struct super_block *sb,
+					 struct dentry *dentry, int new);
 extern const struct inode_operations v9fs_dir_inode_operations_dotl;
 extern const struct inode_operations v9fs_file_inode_operations_dotl;
 extern const struct inode_operations v9fs_symlink_inode_operations_dotl;
@@ -258,7 +259,7 @@ v9fs_get_inode_from_fid(struct v9fs_session_info *v9ses, struct p9_fid *fid,
 	if (v9fs_proto_dotl(v9ses))
 		return v9fs_inode_from_fid_dotl(v9ses, fid, sb, dentry, 0);
 	else
-		return v9fs_inode_from_fid(v9ses, fid, sb, 0);
+		return v9fs_inode_from_fid(v9ses, fid, sb, dentry, 0);
 }
 
 /**
@@ -276,7 +277,7 @@ v9fs_get_new_inode_from_fid(struct v9fs_session_info *v9ses, struct p9_fid *fid,
 	if (v9fs_proto_dotl(v9ses))
 		return v9fs_inode_from_fid_dotl(v9ses, fid, sb, dentry, 1);
 	else
-		return v9fs_inode_from_fid(v9ses, fid, sb, 1);
+		return v9fs_inode_from_fid(v9ses, fid, sb, dentry, 1);
 }
 
 #endif
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 72fd72a2ff06..1137a5960ac2 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -363,12 +363,18 @@ void v9fs_evict_inode(struct inode *inode)
 		clear_inode(inode);
 }
 
+struct iget_data {
+	struct p9_wstat *st;
+	struct dentry *dentry;
+};
+
 static int v9fs_test_inode(struct inode *inode, void *data)
 {
 	int umode;
 	dev_t rdev;
 	struct v9fs_inode *v9inode = V9FS_I(inode);
-	struct p9_wstat *st = (struct p9_wstat *)data;
+	struct p9_wstat *st = ((struct iget_data *)data)->st;
+	struct dentry *dentry = ((struct iget_data *)data)->dentry;
 	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
 
 	umode = p9mode2unixmode(v9ses, st, &rdev);
@@ -386,26 +392,81 @@ static int v9fs_test_inode(struct inode *inode, void *data)
 
 	if (v9inode->qid.path != st->qid.path)
 		return 0;
+
+	if (v9fs_inode_ident_path(v9ses)) {
+		if (!ino_path_compare(v9inode->path, dentry)) {
+			p9_debug(P9_DEBUG_VFS, "Refusing to reuse inode %p based on path mismatch",
+				 inode);
+			return 0;
+		}
+	}
+
 	return 1;
 }
 
 static int v9fs_test_new_inode(struct inode *inode, void *data)
 {
+	int umode;
+	dev_t rdev;
+	struct v9fs_inode *v9inode = V9FS_I(inode);
+	struct p9_wstat *st = ((struct iget_data *)data)->st;
+	struct dentry *dentry = ((struct iget_data *)data)->dentry;
+	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
+
+	umode = p9mode2unixmode(v9ses, st, &rdev);
+	/*
+	 * Don't reuse inode of different type, even if we have
+	 * inodeident=path and path matches.
+	 */
+	if (inode_wrong_type(inode, umode))
+		return 0;
+
+	/*
+	 * We're only getting here if QID2INO stays the same anyway, so
+	 * mirroring the qid checks in v9fs_test_inode
+	 * (but maybe that check is unnecessary anyway? at least on 64bit)
+	 */
+
+	if (v9inode->qid.path != st->qid.path)
+		return 0;
+
+	if (v9inode->qid.type != st->qid.type)
+		return 0;
+
+	if (v9fs_inode_ident_path(v9ses) && dentry && v9inode->path) {
+		if (ino_path_compare(V9FS_I(inode)->path, dentry)) {
+			p9_debug(P9_DEBUG_VFS, "Refusing to reuse inode %p based on path mismatch",
+				 inode);
+			return 1;
+		}
+	}
+
 	return 0;
 }
 
-static int v9fs_set_inode(struct inode *inode,  void *data)
+static int v9fs_set_inode(struct inode *inode, void *data)
 {
 	struct v9fs_inode *v9inode = V9FS_I(inode);
-	struct p9_wstat *st = (struct p9_wstat *)data;
+	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
+	struct iget_data *idata = data;
+	struct p9_wstat *st = idata->st;
+	struct dentry *dentry = idata->dentry;
 
 	memcpy(&v9inode->qid, &st->qid, sizeof(st->qid));
+	if (v9fs_inode_ident_path(v9ses)) {
+		if (dentry) {
+			v9inode->path = make_ino_path(dentry);
+			if (!v9inode->path)
+				return -ENOMEM;
+		} else {
+			v9inode->path = NULL;
+		}
+	}
 	return 0;
 }
 
-static struct inode *v9fs_qid_iget(struct super_block *sb,
-				   struct p9_qid *qid,
-				   struct p9_wstat *st,
+static struct inode *v9fs_qid_iget(struct super_block *sb, struct p9_qid *qid,
+				   struct p9_wstat *st, struct dentry *dentry,
 				   int new)
 {
 	dev_t rdev;
@@ -414,13 +475,27 @@ static struct inode *v9fs_qid_iget(struct super_block *sb,
 	struct inode *inode;
 	struct v9fs_session_info *v9ses = sb->s_fs_info;
 	int (*test)(struct inode *inode, void *data);
+	struct iget_data data = {
+		.st = st,
+		.dentry = dentry,
+	};
 
 	if (new)
 		test = v9fs_test_new_inode;
 	else
 		test = v9fs_test_inode;
 
-	inode = iget5_locked(sb, QID2INO(qid), test, v9fs_set_inode, st);
+	if (v9fs_inode_ident_path(v9ses) && dentry) {
+		/*
+		 * We have to take the rename_sem lock here as iget5_locked has
+		 * spinlock in it (inode_hash_lock)
+		 */
+		down_read(&v9ses->rename_sem);
+	}
+	inode = iget5_locked(sb, QID2INO(qid), test, v9fs_set_inode, &data);
+	if (v9fs_inode_ident_path(v9ses) && dentry)
+		up_read(&v9ses->rename_sem);
+
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 	if (!(inode->i_state & I_NEW))
@@ -447,9 +522,9 @@ static struct inode *v9fs_qid_iget(struct super_block *sb,
 
 }
 
-struct inode *
-v9fs_inode_from_fid(struct v9fs_session_info *v9ses, struct p9_fid *fid,
-		    struct super_block *sb, int new)
+struct inode *v9fs_inode_from_fid(struct v9fs_session_info *v9ses,
+				  struct p9_fid *fid, struct super_block *sb,
+				  struct dentry *dentry, int new)
 {
 	struct p9_wstat *st;
 	struct inode *inode = NULL;
@@ -458,7 +533,7 @@ v9fs_inode_from_fid(struct v9fs_session_info *v9ses, struct p9_fid *fid,
 	if (IS_ERR(st))
 		return ERR_CAST(st);
 
-	inode = v9fs_qid_iget(sb, &st->qid, st, new);
+	inode = v9fs_qid_iget(sb, &st->qid, st, dentry, new);
 	p9stat_free(st);
 	kfree(st);
 	return inode;
@@ -608,10 +683,9 @@ v9fs_create(struct v9fs_session_info *v9ses, struct inode *dir,
 			goto error;
 		}
 		/*
-		 * Instantiate inode.  On .L fs, pass in dentry for inodeident=path.
+		 * Instantiate inode.  Pass in dentry for inodeident=path.
 		 */
-		inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb,
-			v9fs_proto_dotl(v9ses) ? dentry : NULL);
+		inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb, dentry);
 		if (IS_ERR(inode)) {
 			err = PTR_ERR(inode);
 			p9_debug(P9_DEBUG_VFS,
@@ -738,19 +812,17 @@ struct dentry *v9fs_vfs_lookup(struct inode *dir, struct dentry *dentry,
 	p9_fid_put(dfid);
 
 	/*
-	 * On .L fs, pass in dentry to v9fs_get_inode_from_fid in case it is
-	 * needed by inodeident=path
+	 * Pass in dentry to v9fs_get_inode_from_fid in case it is needed by
+	 * inodeident=path
 	 */
 	if (fid == ERR_PTR(-ENOENT))
 		inode = NULL;
 	else if (IS_ERR(fid))
 		inode = ERR_CAST(fid);
 	else if (v9ses->cache & (CACHE_META | CACHE_LOOSE))
-		inode = v9fs_get_inode_from_fid(v9ses, fid, dir->i_sb,
-			v9fs_proto_dotl(v9ses) ? dentry : NULL);
+		inode = v9fs_get_inode_from_fid(v9ses, fid, dir->i_sb, dentry);
 	else
-		inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb,
-			v9fs_proto_dotl(v9ses) ? dentry : NULL);
+		inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb, dentry);
 	/*
 	 * If we had a rename on the server and a parallel lookup
 	 * for the new name, then make sure we instantiate with
-- 
2.39.5


