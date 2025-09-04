Return-Path: <linux-fsdevel+bounces-60225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBD3B42DD3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 02:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA01C3BA095
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 00:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CE2AD2C;
	Thu,  4 Sep 2025 00:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="Gj/wjzR+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CJScsNZw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CDF11CA9;
	Thu,  4 Sep 2025 00:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756944326; cv=none; b=OBpxHMWFn9ddj0g19kanLomatQJac2F55PETJb90Xy/OcJvjXir3U9c5gI24axDSOcXcVZHGJcml4uiFu54geGnwU8yoP1+Vms6pav428jg9Z2l3dxkQkTi7RVFpeQrXLoi+GPK21fCEOr7kZLxTslQ+ovahSpBZVDkZv0v8x44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756944326; c=relaxed/simple;
	bh=Pfw4XjYA9QaepdtZ9rRokRHjNvoZR76TAkK2T8ppn8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GqB4pupAjQHHLK0cGeypqPwaAzqSEejjiW15+yftXjdt2F4zj0JgvmDmzsAIvg3SbaNTu+73O/OxRvG4Vy81vSjtbEwyFfpD5A4j/ZI+jrmDzGCMHa20hUYAP63Fjx2FjD2ywmR5Ip4K5hrFp2hI5HEsCm6d/S4cVpOScUiBL6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=Gj/wjzR+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CJScsNZw; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 698FE14005D5;
	Wed,  3 Sep 2025 20:05:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 03 Sep 2025 20:05:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1756944324; x=
	1757030724; bh=9a2uJ/XZzFeBbDe2xR2aM7GBJez95FIpdajKfJIpqwU=; b=G
	j/wjzR+c8B694v92FNw9i7g9hMavnAhCjuHR8ui1Mcxucf6NiWYEulXExFnv9UrK
	kzuTGbF6SK8w5n7sHTmIBoSCMFogy8Bq9r0vCeyheDID7P0SJYMpJjETX/wGxOd8
	1N9CFzED1ocQ4Pn/otI0OOyjESAJZTwvWucXT4bj4hM//0kqL3slRMakDLtOVCVn
	TJZvx8VJhuHKvjNxqTLrN+a9F7kYYWZxiFAuI/fcSdsp0JF0NqkrcTfeS17kiI9P
	rBn2pl1SLpqhwX31eZidikQInQKDnF00TbZmI6W1iVs4ZAN9x/A7jFlzytS1fIjY
	XXJlWzhqN9EjxTvNlbrrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1756944324; x=1757030724; bh=9
	a2uJ/XZzFeBbDe2xR2aM7GBJez95FIpdajKfJIpqwU=; b=CJScsNZwebwBuHO4G
	lqb9VEzMlzeoW7bSp5Y6JNuqU/YNutCfLGY2U4fQcitziPXJpgQLeAeTbvHSirJP
	jEsgcWP4xDYCfGx1kIzf81JfO/J7yfivt2IGkrzONeFhwaU167cN5vDiPcT4Mf6Q
	UAXxdSj8am3DpHiQxUJOZbX0LYPbx2caLSeoErCohDH3yDArm4PbScwJGZC+NB6R
	TVv1dFCMHoGVYIMjS3w2drFFHofyYLR1YBzLHt+Xm1igFsYFhXYsvTtfDMiCWa6q
	adzBY9M7TFj6WAaS0ysGtQxOiMMTvDIibkZITF79KUlhg9zXzDR9/PhfpAVGXIbn
	tVxWA==
X-ME-Sender: <xms:xNe4aP68P1ImVrgDGBhgHQUTatoi5wg81Q4uDaAffinxwvjdln2GxQ>
    <xme:xNe4aAtM3nPoC6NQkLFNCDB9yLJwkdcxPH1KWBOVcKEmERA9-mbrRpnpRa56B9gnu
    ZyrT4V6Z9wXujdN6YQ>
X-ME-Received: <xmr:xNe4aM5mg80NLeMLBSlpeVQ1Dd00rNTzTDLTEWubA_oOBobQCfgXbO76gInGiVtz_lyEqrIm2NyvRAecLAE9U1nyLzzmrIa8km8d0QmG1UejpF3wU-Mlv91J7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhinhhgmhgrohcu
    hggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeeuuddthe
    fhhefhvdejteevvddvteefffegteetueegueeljeefueekjeetieeuleenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdroh
    hrghdpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegrshhmrgguvghushestghouggvfihrvggtkhdrohhrghdprhgtphhtthhopegvrhhitg
    hvhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhutghhohesihhonhhkohhvrdhn
    vghtpdhrtghpthhtoheplhhinhhugigpohhsshestghruhguvggshihtvgdrtghomhdprh
    gtphhtthhopehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepmhesmhgrohif
    thhmrdhorhhgpdhrtghpthhtohepvhelfhhssehlihhsthhsrdhlihhnuhigrdguvghvpd
    hrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehlihhn
    uhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:xNe4aM3eYo3RFzpwamxxRsCf_L0ZB4M5_PW_fIECmsCTPpAvU7vlLQ>
    <xmx:xNe4aHh-62W0Yaio9Lv9tkmiKWdGmh8lKwAPuXoX4gnoZsmTndKZ9A>
    <xmx:xNe4aEoZaADy2fWa-0RvCG8ulDo6SWSRhKCd-7Tm4oHLcqvH1t72vQ>
    <xmx:xNe4aCMQ1YXmomqvpKjK1nCJQdKXCzGMpGQLyJC1Jhomd23kJT5e_w>
    <xmx:xNe4aGr1L-oNZcTRX6_eiwqxd8RFUuVYOXdtxW6FMSSkv3Gyrwh5LLet>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 20:05:22 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	v9fs@lists.linux.dev,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Matthew Bobrowski <repnop@google.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 3/7] fs/9p: Add ability to identify inode by path for non-.L in uncached mode
Date: Thu,  4 Sep 2025 01:04:13 +0100
Message-ID: <3e6b21a5982979929ad52a6d49ded5eda371ea7a.1756935780.git.m@maowtm.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756935780.git.m@maowtm.org>
References: <cover.1756935780.git.m@maowtm.org>
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
Changes since v1:
- Reflect v2 changes to the .L counterpart of this.

 fs/9p/v9fs.h      |   7 ++-
 fs/9p/vfs_inode.c | 150 ++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 130 insertions(+), 27 deletions(-)

diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index b4e738c1bba5..bacd0052e22c 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -202,7 +202,8 @@ extern int v9fs_vfs_rename(struct mnt_idmap *idmap,
 			   unsigned int flags);
 extern struct inode *v9fs_inode_from_fid(struct v9fs_session_info *v9ses,
 					 struct p9_fid *fid,
-					 struct super_block *sb, int new);
+					 struct super_block *sb,
+					 struct dentry *dentry, int new);
 extern const struct inode_operations v9fs_dir_inode_operations_dotl;
 extern const struct inode_operations v9fs_file_inode_operations_dotl;
 extern const struct inode_operations v9fs_symlink_inode_operations_dotl;
@@ -267,7 +268,7 @@ v9fs_get_inode_from_fid(struct v9fs_session_info *v9ses, struct p9_fid *fid,
 	if (v9fs_proto_dotl(v9ses))
 		return v9fs_inode_from_fid_dotl(v9ses, fid, sb, dentry, 0);
 	else
-		return v9fs_inode_from_fid(v9ses, fid, sb, 0);
+		return v9fs_inode_from_fid(v9ses, fid, sb, dentry, 0);
 }
 
 /**
@@ -291,7 +292,7 @@ v9fs_get_new_inode_from_fid(struct v9fs_session_info *v9ses, struct p9_fid *fid,
 	if (v9fs_proto_dotl(v9ses))
 		return v9fs_inode_from_fid_dotl(v9ses, fid, sb, dentry, 1);
 	else
-		return v9fs_inode_from_fid(v9ses, fid, sb, 1);
+		return v9fs_inode_from_fid(v9ses, fid, sb, dentry, 1);
 }
 
 #endif
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 5e56c13da733..606760f966fd 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -364,29 +364,76 @@ void v9fs_evict_inode(struct inode *inode)
 		clear_inode(inode);
 }
 
+struct iget_data {
+	struct p9_wstat *st;
+
+	/* May be NULL */
+	struct dentry *dentry;
+
+	bool need_double_check;
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
+	bool cached = v9ses->cache & (CACHE_META | CACHE_LOOSE);
 
 	umode = p9mode2unixmode(v9ses, st, &rdev);
-	/* don't match inode of different type */
+	/*
+	 * Don't reuse inode of different type, even if path matches.
+	 */
 	if (inode_wrong_type(inode, umode))
 		return 0;
 
-	/* compare qid details */
-	if (memcmp(&v9inode->qid.version,
-		   &st->qid.version, sizeof(v9inode->qid.version)))
-		return 0;
-
 	if (v9inode->qid.type != st->qid.type)
 		return 0;
 
 	if (v9inode->qid.path != st->qid.path)
 		return 0;
+
+	if (cached) {
+		/*
+		 * Server side changes are not supposed to happen in cached mode.
+		 * If we fail this version comparison on the inode, we don't reuse
+		 * it.
+		 */
+		if (memcmp(&v9inode->qid.version,
+			&st->qid.version, sizeof(v9inode->qid.version)))
+			return 0;
+	}
+
+	if (v9fs_inode_ident_path(v9ses) && dentry) {
+		if (v9inode->path) {
+			if (!ino_path_compare(v9inode->path, dentry)) {
+				p9_debug(
+					P9_DEBUG_VFS,
+					"Refusing to reuse inode %p based on path mismatch",
+					inode);
+				return 0;
+			}
+		} else if (inode->i_state & I_NEW) {
+			/*
+			 * iget5_locked may call this function with a still
+			 * initializing (I_NEW) inode, so we're now racing with the
+			 * code in v9fs_qid_iget that prepares v9inode->path.
+			 * Returning from this test function now with positive result
+			 * will cause us to wait for this inode to be ready, and we
+			 * can then re-check in v9fs_qid_iget.
+			 */
+			((struct iget_data *)data)->need_double_check = true;
+		} else {
+			WARN_ONCE(
+				1,
+				"Inode %p (ino %lu) does not have v9inode->path even though fs has path-based inode identification enabled?",
+				inode, inode->i_ino);
+		}
+	}
+
 	return 1;
 }
 
@@ -395,33 +442,74 @@ static int v9fs_test_new_inode(struct inode *inode, void *data)
 	return 0;
 }
 
-static int v9fs_set_inode(struct inode *inode,  void *data)
+static int v9fs_set_inode(struct inode *inode, void *data)
 {
 	struct v9fs_inode *v9inode = V9FS_I(inode);
-	struct p9_wstat *st = (struct p9_wstat *)data;
+	struct iget_data *idata = data;
+	struct p9_wstat *st = idata->st;
 
 	memcpy(&v9inode->qid, &st->qid, sizeof(st->qid));
+	/*
+	 * We can't fill v9inode->path here, because allocating an ino_path
+	 * means that we might sleep, and we can't sleep here.
+	 */
+	v9inode->path = NULL;
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
 	int retval;
 	umode_t umode;
 	struct inode *inode;
+	struct v9fs_inode *v9inode;
 	struct v9fs_session_info *v9ses = sb->s_fs_info;
 	int (*test)(struct inode *inode, void *data);
+	struct iget_data data = {
+		.st = st,
+		.dentry = dentry,
+		.need_double_check = false,
+	};
 
 	if (new)
 		test = v9fs_test_new_inode;
 	else
 		test = v9fs_test_inode;
 
-	inode = iget5_locked(sb, QID2INO(qid), test, v9fs_set_inode, st);
+	if (dentry) {
+		/*
+		 * If we need to compare paths to find the inode to reuse, we need
+		 * to take the rename_sem for this FS.  We need to take it here,
+		 * instead of inside ino_path_compare, as iget5_locked has
+		 * spinlock in it (inode_hash_lock)
+		 */
+		down_read(&v9ses->rename_sem);
+	}
+	while (true) {
+		data.need_double_check = false;
+		inode = iget5_locked(sb, QID2INO(qid), test, v9fs_set_inode, &data);
+		if (!data.need_double_check)
+			break;
+		/*
+		 * Need to double check path as it wasn't initialized yet when we
+		 * tested it
+		 */
+		if (!inode || (inode->i_state & I_NEW)) {
+			WARN_ONCE(
+				1,
+				"Expected iget5_locked to return an existing inode");
+			break;
+		}
+		if (ino_path_compare(V9FS_I(inode)->path, dentry))
+			break;
+		iput(inode);
+	}
+	if (dentry)
+		up_read(&v9ses->rename_sem);
+
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 	if (!(inode->i_state & I_NEW))
@@ -437,6 +525,16 @@ static struct inode *v9fs_qid_iget(struct super_block *sb,
 	if (retval)
 		goto error;
 
+	v9inode = V9FS_I(inode);
+	if (dentry) {
+		down_read(&v9ses->rename_sem);
+		v9inode->path = make_ino_path(dentry);
+		up_read(&v9ses->rename_sem);
+		if (!v9inode->path) {
+			retval = -ENOMEM;
+			goto error;
+		}
+	}
 	v9fs_stat2inode(st, inode, sb, 0);
 	v9fs_set_netfs_context(inode);
 	v9fs_cache_inode_get_cookie(inode);
@@ -448,9 +546,18 @@ static struct inode *v9fs_qid_iget(struct super_block *sb,
 
 }
 
-struct inode *
-v9fs_inode_from_fid(struct v9fs_session_info *v9ses, struct p9_fid *fid,
-		    struct super_block *sb, int new)
+/**
+ * Issues a getattr request and use the result to look up the inode for
+ * the target pointed to by @fid.
+ * @v9ses: session information
+ * @fid: fid to issue attribute request for
+ * @sb: superblock on which to create inode
+ * @dentry: if not NULL, the path of the provided dentry is compared
+ * against the path stored in the inode, to determine reuse eligibility.
+ */
+struct inode *v9fs_inode_from_fid(struct v9fs_session_info *v9ses,
+				  struct p9_fid *fid, struct super_block *sb,
+				  struct dentry *dentry, int new)
 {
 	struct p9_wstat *st;
 	struct inode *inode = NULL;
@@ -459,7 +566,7 @@ v9fs_inode_from_fid(struct v9fs_session_info *v9ses, struct p9_fid *fid,
 	if (IS_ERR(st))
 		return ERR_CAST(st);
 
-	inode = v9fs_qid_iget(sb, &st->qid, st, new);
+	inode = v9fs_qid_iget(sb, &st->qid, st, dentry, new);
 	p9stat_free(st);
 	kfree(st);
 	return inode;
@@ -608,18 +715,14 @@ v9fs_create(struct v9fs_session_info *v9ses, struct inode *dir,
 				   "p9_client_walk failed %d\n", err);
 			goto error;
 		}
-		/*
-		 * Instantiate inode.  On .L fs, pass in dentry for inodeident=path.
-		 */
-		inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb,
-			v9fs_proto_dotl(v9ses) ? dentry : NULL);
+		/* instantiate inode and assign the unopened fid to the dentry */
+		inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb, dentry);
 		if (IS_ERR(inode)) {
 			err = PTR_ERR(inode);
 			p9_debug(P9_DEBUG_VFS,
 				   "inode creation failed %d\n", err);
 			goto error;
 		}
-		/* Assign the unopened fid to the dentry */
 		v9fs_fid_add(dentry, &fid);
 		d_instantiate(dentry, inode);
 	}
@@ -1415,4 +1518,3 @@ static const struct inode_operations v9fs_symlink_inode_operations = {
 	.getattr = v9fs_vfs_getattr,
 	.setattr = v9fs_vfs_setattr,
 };
-
-- 
2.51.0

