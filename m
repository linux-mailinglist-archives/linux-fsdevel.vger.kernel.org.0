Return-Path: <linux-fsdevel+bounces-60228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1846EB42DD7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 02:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0DDC207464
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 00:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA56D27461;
	Thu,  4 Sep 2025 00:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="JV2Jxbei";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DbLs7W4t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B711F5E6;
	Thu,  4 Sep 2025 00:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756944332; cv=none; b=MFP9F1/p7qSXM/7TPqsKGwNIASJQWrowS5oQlrpzZG696eDgFMTpkmgGNekur3YACXgJsfxoTj7nWO0prO+Aq72lMLWJ3qOQIsM64i5Ls2cLhr/TgG2kY3qRps/HSs7423QI7ez6GjcjbMn7WbMP1rLPml3MqCacyeN0veMi4sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756944332; c=relaxed/simple;
	bh=/4TL2TAmfVFoh6KPU5xy1AIcRqX2FC92HyDRvSfCms0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JcKR/V1nDg+8slrppXvqdLWrda/sKLHpKuLL7eK+jOU+BiuAO2VLlgVPa9x6M6Cew+0XDeuboSMLNKN1PASIvqqntuj9QCdLh8hJEmCHzgc0N4z+baf6T3Lh/feVw9qvb5+H4Kanv6NfUVWEMIWUNk9zL/lYk1Jf4qT51vEhIp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=JV2Jxbei; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DbLs7W4t; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 908AD1400182;
	Wed,  3 Sep 2025 20:05:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 03 Sep 2025 20:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756944330;
	 x=1757030730; bh=IuFUOFQSyxPBcvSnTQaXJMJ+FD5mAtube8FhbvKV6Oo=; b=
	JV2Jxbei6wO88OsjrWJjm/dba2N7UT4g1qN/G/+AA4lkao0lCZ4xKj5mNSohv6fe
	T48vjZBbTTDZb8dPH1V5Pq4pzaFHGif6qc5rETDnPyyMeyQ4UuBitahwU609ytc7
	RN0ynvvaMiQrz7wr8701TE15hkS6ZaOsdvGxyVvKIgGSrU8UL8aXsgpssk/XhRlU
	REqXWSXEgqSmdHFwQLbHIzgUo8C6NPhq0TMSkQV6oGNjT+ThRoDOlM8/GDYyr3E9
	fMf8d5fkRoxHZaxYxXDAP64WPXJrDRqj5cfswpEY5Brwbp+sqMIcqDbYSkVpxikl
	26A1MyGWV6vlw9NQ+rpsTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756944330; x=
	1757030730; bh=IuFUOFQSyxPBcvSnTQaXJMJ+FD5mAtube8FhbvKV6Oo=; b=D
	bLs7W4tSH1xW/9Z3vjaFhVBIrEjxenpkzoEew4fRDsIy8OcZyzw2+gFsVrE55Lmf
	9Uboae7c9VS9OG4D2KyrW5ftKXIVAQ+d5Or9arUlSpiZThJozDi/Y424py/dmJjI
	bvIkJnJZg74aznB2K+odYWADmZYANi0wtz4FQaEvU/h9M0VSqAzDudLvKvbzg++L
	fge5joHig2Rwd0RsGX/GPBPAlKYlbY7nXyrVw0eV1lHiJlk/kTJdqAuwipk+6Vt1
	NP5hgIrGuKXjpSbJMFWYrKCx9pi2qOY4z4T5Vngz0IVF2Kh1o9jjxoCXC40LAAni
	ixPhH3CiG4vYEp20L66dw==
X-ME-Sender: <xms:yte4aA7sE9TGkWuAJTU7Ks7Ky6VgYEXoe1jhfgIIFsISpCBKHUAz0w>
    <xme:yte4aNu1PqBYBZcx6UC7LM-G8_3dawVZz4ntgKzc24TEGTdlzxUkcPYvjhHodY-pr
    PCAsjUHD_stmINsQso>
X-ME-Received: <xmr:yte4aF5UYT2mDieC-4ThNoGhpqOmWYq681TuQjbjk9hh6eSmG0PX72TsbZHzb6xhA9aoPa0n52-GTRMBSR7A4GtWrnKUEDV4nW2MZjoaeOiBFHUzhz-d4B-DiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefvihhnghhmrgho
    ucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhephffghe
    ffveettdffkeejvddtgeekvdfgleefvdejtdelledtgeevgfeuuefhgeelnecuffhomhgr
    ihhnpehinhhouggvrdhrvggrugenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghpthhtohepudeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrshhmrgguvghushestghouggvfi
    hrvggtkhdrohhrghdprhgtphhtthhopegvrhhitghvhheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhutghhohesihhonhhkohhvrdhnvghtpdhrtghpthhtoheplhhinhhugi
    gpohhsshestghruhguvggshihtvgdrtghomhdprhgtphhtthhopehmihgtseguihhgihhk
    ohgurdhnvghtpdhrtghpthhtohepmhesmhgrohifthhmrdhorhhgpdhrtghpthhtohepvh
    elfhhssehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepghhnohgrtghksehg
    ohhoghhlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoug
    hulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:yte4aB1lEHN0lzCuexwsxps1_oezmiGzorUc074Kc3qseAH2NbF_Rw>
    <xmx:yte4aIiOOUmubK53QFcxp1LfQyGMAVpM-Umq_yKsL45lm1YKY6e7PA>
    <xmx:yte4aBpQ05mWfesqSvDLsP5Qkbc5SHSmA3dSRndKnUtKsccnRRWzgg>
    <xmx:yte4aLNGehPx92QJ3VW--9R_XsAMQF4anUZh_CmXTIgDtUTpzmJxJw>
    <xmx:yte4aPrTpbXMmJx3P7Fps5p87tNeiaWrMxG8NpLlxMfJ9J_WCsG6Gv37>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 20:05:28 -0400 (EDT)
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
Subject: [PATCH v2 6/7] fs/9p: update the target's ino_path on rename
Date: Thu,  4 Sep 2025 01:04:16 +0100
Message-ID: <7ff4695e74af9945f26ccfc9f9a993a598cc1014.1756935780.git.m@maowtm.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756935780.git.m@maowtm.org>
References: <cover.1756935780.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This makes it possible for the inode to "move along" to the new location
when a file under a inodeident=path 9pfs is moved, and it will be reused
on next access to the new location.

Modifying the ino_path of children when renaming a directory is currently
not handled.  Renaming non-empty directories still work, but the children
won't have their the inodes be reused after renaming.

Inodes will also not be reused on server-side rename, since there is no
way for us to know about it.  From our perspective this is
indistinguishable from a new file being created in the destination that
just happened to have the same qid, and the original file being deleted.

Signed-off-by: Tingmao Wang <m@maowtm.org>
Cc: "Mickaël Salaün" <mic@digikod.net>
Cc: "Günther Noack" <gnoack@google.com>

---
New patch in v2

 fs/9p/ino_path.c       |  3 ++-
 fs/9p/v9fs.h           |  3 +++
 fs/9p/vfs_inode.c      | 30 ++++++++++++++++++++++++++++++
 fs/9p/vfs_inode_dotl.c |  6 ++++++
 4 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/fs/9p/ino_path.c b/fs/9p/ino_path.c
index a03145e08a9d..ee4752b9f796 100644
--- a/fs/9p/ino_path.c
+++ b/fs/9p/ino_path.c
@@ -27,7 +27,8 @@ struct v9fs_ino_path *make_ino_path(struct dentry *dentry)
 	struct dentry *curr = dentry;
 	ssize_t i;
 
-	lockdep_assert_held_read(&v9fs_dentry2v9ses(dentry)->rename_sem);
+	/* Either read or write lock held is ok */
+	lockdep_assert_held(&v9fs_dentry2v9ses(dentry)->rename_sem);
 	might_sleep(); /* Allocation below might block */
 
 	rcu_read_lock();
diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index bacd0052e22c..c441fa8e757b 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -157,6 +157,9 @@ struct v9fs_inode {
 	/*
 	 * Stores the path of the file this inode is for, only for filesystems
 	 * with inode_ident=path.  Lifetime is the same as this inode.
+	 * Read/write to this pointer should be under the target v9fs's
+	 * rename_sem to protect against races (except when initializing or
+	 * freeing an inode, at which point nobody else has reference to us)
 	 */
 	struct v9fs_ino_path *path;
 };
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 4b4712eafe4d..68a1837ff3dc 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -532,6 +532,12 @@ static struct inode *v9fs_qid_iget(struct super_block *sb, struct p9_qid *qid,
 
 	v9inode = V9FS_I(inode);
 	if (dentry) {
+		/*
+		 * In order to make_ino_path, we need at least a read lock on the
+		 * rename_sem.  Since we re initializing a new inode, there is no
+		 * risk of races with another task trying to write to
+		 * v9inode->path, so we do not need an actual down_write.
+		 */
 		down_read(&v9ses->rename_sem);
 		v9inode->path = make_ino_path(dentry);
 		up_read(&v9ses->rename_sem);
@@ -983,18 +989,21 @@ v9fs_vfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 {
 	int retval;
 	struct inode *old_inode;
+	struct v9fs_inode *old_v9inode;
 	struct inode *new_inode;
 	struct v9fs_session_info *v9ses;
 	struct p9_fid *oldfid = NULL, *dfid = NULL;
 	struct p9_fid *olddirfid = NULL;
 	struct p9_fid *newdirfid = NULL;
 	struct p9_wstat wstat;
+	struct v9fs_ino_path *new_ino_path = NULL;
 
 	if (flags)
 		return -EINVAL;
 
 	p9_debug(P9_DEBUG_VFS, "\n");
 	old_inode = d_inode(old_dentry);
+	old_v9inode = V9FS_I(old_inode);
 	new_inode = d_inode(new_dentry);
 	v9ses = v9fs_inode2v9ses(old_inode);
 	oldfid = v9fs_fid_lookup(old_dentry);
@@ -1022,6 +1031,17 @@ v9fs_vfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	}
 
 	down_write(&v9ses->rename_sem);
+	if (v9fs_inode_ident_path(v9ses)) {
+		/*
+		 * Try to allocate this first, and don't actually do rename if
+		 * allocation fails.
+		 */
+		new_ino_path = make_ino_path(new_dentry);
+		if (!new_ino_path) {
+			retval = -ENOMEM;
+			goto error_locked;
+		}
+	}
 	if (v9fs_proto_dotl(v9ses)) {
 		retval = p9_client_renameat(olddirfid, old_dentry->d_name.name,
 					    newdirfid, new_dentry->d_name.name);
@@ -1061,6 +1081,15 @@ v9fs_vfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		v9fs_invalidate_inode_attr(old_inode);
 		v9fs_invalidate_inode_attr(old_dir);
 		v9fs_invalidate_inode_attr(new_dir);
+		if (v9fs_inode_ident_path(v9ses)) {
+			/*
+			 * We currently have rename_sem write lock, which protects all
+			 * v9inode->path in this fs.
+			 */
+			free_ino_path(old_v9inode->path);
+			old_v9inode->path = new_ino_path;
+			new_ino_path = NULL;
+		}
 
 		/* successful rename */
 		d_move(old_dentry, new_dentry);
@@ -1068,6 +1097,7 @@ v9fs_vfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	up_write(&v9ses->rename_sem);
 
 error:
+	free_ino_path(new_ino_path);
 	p9_fid_put(newdirfid);
 	p9_fid_put(olddirfid);
 	p9_fid_put(oldfid);
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index d008e82256ac..a3f70dd422fb 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -232,6 +232,12 @@ static struct inode *v9fs_qid_iget_dotl(struct super_block *sb,
 
 	v9inode = V9FS_I(inode);
 	if (dentry) {
+		/*
+		 * In order to make_ino_path, we need at least a read lock on the
+		 * rename_sem.  Since we re initializing a new inode, there is no
+		 * risk of races with another task trying to write to
+		 * v9inode->path, so we do not need an actual down_write.
+		 */
 		down_read(&v9ses->rename_sem);
 		v9inode->path = make_ino_path(dentry);
 		up_read(&v9ses->rename_sem);
-- 
2.51.0

