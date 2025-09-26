Return-Path: <linux-fsdevel+bounces-62846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16129BA23FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 04:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B7F01C226A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 02:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B25C20459A;
	Fri, 26 Sep 2025 02:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="h4O22zTW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AQvK79ca"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5D91C5F1B
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 02:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758855069; cv=none; b=jGjLRTaT3oSastSB+LSUZPjgyBUH1zy8g050204TW09Hu15Cj9mP2DOpQ7owCszVoQyJqUfk7AGKE9Jd4Z9+FIy86Cl+o9w1On122KOsQ3moFdGK4z7GeOJpNyLqfAl6POfofBAAeJe+6edAdBgVSlZFHSbIqotjzAo1VxIvx0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758855069; c=relaxed/simple;
	bh=rtOvCvRYc/WpjG1GrbsN/uEuSa5iCjgE695n1dI1RHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nmWTRuQG8wVkaDbz7ki9HJSb3iKfpN+QYzsrcsz526R6lm20v7kTWaImPEamWmUIF5hC02o2MeE2rbdlsTGKW4QR+286d8itiB4dZs+LwpZ5HNsWBcOl+8Xq1lMNNT2KaB6MA6jXk2q0Ztbz3dtpPr+zvQadgaky9rel8j9KBsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=h4O22zTW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AQvK79ca; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 650EB14000C1;
	Thu, 25 Sep 2025 22:51:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 25 Sep 2025 22:51:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1758855066;
	 x=1758941466; bh=jxk1AgvHiKwt9Q174Y4F9aB2lrmh97ChVCcXEcq3urI=; b=
	h4O22zTW4bEysUmaUPoTAW7pc5A3f5wYlcUDgMk54qPfODO3DAAcZPFtCmw0J7+4
	vIl1yzybr8ZE/0HhXIQKLbHjva/qTVmcnbGPAj0A7utkgCiuB8eNs2hh31bKATBI
	zswmP+ndReiVbm8lHXRBaWT/Qbg2twNRRRVIAHq5sJzcKqfaf/8CuEyjNo5Sy38M
	30DC9DoWCK0VeTGSiY1hRHO16Z5Ed0qSfCDXXBZ+MbgIJDocwoyPIPY8YAbsnX0b
	3cDaRlL+p4AjM3jpwnSoE2g7/BeEfEXgrpI6cDdzEPPeTmNeVjmjHTiDhrVjKrw4
	/QbIqV3iU91W3KIuQ2e1bA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758855066; x=1758941466; bh=j
	xk1AgvHiKwt9Q174Y4F9aB2lrmh97ChVCcXEcq3urI=; b=AQvK79caST9NVVM5g
	9gPaqSMQSIrHGC9owylOgY//5czSR2M8FXYXhsEs6AiZH/TXxN2Hcuedj7Jdm2K1
	YN9D9eVfUGcPQywfa5lHydL9H4txtU6PIroVUqYXoh1nwqcjV8ejIRwnbJp+xpBQ
	0Bn/rWS1Ze5i7jD8sJBqM//RJlbFMwC1xCl2VnjNoiD9Mm21peya+4BcbVdPCoYF
	KmlxL47jH/vun26+TppfBoa4zLZgvfNOkpNs+2tNw7Z0psAH3ypImNjCKH1r1k+p
	G1TWQsTQkMHp3I1TITCTLQJvJbjRMHWNj3eJhmJxn2o1CQYadV81x9lsc+W2hYSD
	LBUBg==
X-ME-Sender: <xms:mv_VaLBOiNEiQ8HTKIftfzEwQKmorrl4e9Pgo6FLo3xSm-5mDR9Zkg>
    <xme:mv_VaMe_K2f4ONP25FFc6CDRnaxj68azpPtcGYFayMeQEbRoNEosSLmwbivCBtRes
    sF5C-lZqyHQbP00YA75WQnhwq8EIpnTG8cXtJx0zMZVKIFNiVo>
X-ME-Received: <xmr:mv_VaFnoaac87ithQPlTjOFjkzSsxJc-5kRTUDBuVBIwOHdoqe5NCrZool5E7TUfj7cH6jeu_pjsXTxw_q9Okra_ZhdZtPaGi0Lxhxexd8x4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeikedvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfrhgggfestdekredtredttdenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    evveekffduueevhfeigefhgfdukedtleekjeeitdejudfgueekvdekffdvfedvudenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:mv_VaDHosc1QWFqnsRNlCM8pImQn5BFvLsquIM-5voNOsj-14rkM1A>
    <xmx:mv_VaN6-y-EtDvjPXt8wItCAfSOhBpm1ZHakXOb8eeNDnEsUm_WwrQ>
    <xmx:mv_VaLkmkzjWNYDcWZaeYuMKIWAwbUxDWWwYDJgpNl88gtxbpvX_ug>
    <xmx:mv_VaCqHsrMqGf4gmSYoBEJmAQWEoSppL0tzXdvcmtDycE4c_Fxd_Q>
    <xmx:mv_VaPYevJFRhWiKhUcN4L0D0f5PE_0lNzqGE5vipuOvF45o5qiyFUo8>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 22:51:03 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/11] VFS/nfsd/ovl: introduce start_renaming() and end_renaming()
Date: Fri, 26 Sep 2025 12:49:12 +1000
Message-ID: <20250926025015.1747294-9-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250926025015.1747294-1-neilb@ownmail.net>
References: <20250926025015.1747294-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

start_renaming() combines name lookup and locking to prepare for rename.
It is used when two names need to be looked up as in nfsd and overlayfs -
cases where one or both dentrys are already available will be handled
separately.

__start_renaming() avoids the inode_permission check and hash
calculation and is suitable after filename_parentat() in do_renameat2().
It subsumes quite a bit of code from that function.

start_renaming() does calculate the hash and check X permission and is
suitable elsewhere:
- nfsd_rename()
- ovl_rename()

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c               | 197 ++++++++++++++++++++++++++++-----------
 fs/nfsd/vfs.c            |  73 +++++----------
 fs/overlayfs/dir.c       |  72 ++++++--------
 fs/overlayfs/overlayfs.h |  14 +++
 include/linux/namei.h    |   3 +
 5 files changed, 214 insertions(+), 145 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index f5c96f801b74..79a8b3b47e4d 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3684,6 +3684,129 @@ void unlock_rename(struct dentry *p1, struct dentry *p2)
 }
 EXPORT_SYMBOL(unlock_rename);
 
+/**
+ * __start_renaming - lookup and lock names for rename
+ * @rd:           rename data containing parent and flags, and
+ *                for receiving found dentries
+ * @lookup_flags: extra flags to pass to ->lookup (e.g. LOOKUP_REVAL,
+ *                LOOKUP_NO_SYMLINKS etc).
+ * @old_last:     name of object in @rd.old_parent
+ * @new_last:     name of object in @rd.new_parent
+ *
+ * Look up two names and ensure locks are in place for
+ * rename.
+ *
+ * On success the found dentrys are stored in @rd.old_dentry,
+ * @rd.new_dentry.  These references and the lock are dropped by
+ * end_renaming().
+ *
+ * The passed in qstrs must have the hash calculated, and no permission
+ * checking is performed.
+ *
+ * Returns: zero or an error.
+ */
+static int
+__start_renaming(struct renamedata *rd, int lookup_flags,
+		 struct qstr *old_last, struct qstr *new_last)
+{
+	struct dentry *trap;
+	struct dentry *d1, *d2;
+	int target_flags = LOOKUP_RENAME_TARGET | LOOKUP_CREATE;
+	int err;
+
+	if (rd->flags & RENAME_EXCHANGE)
+		target_flags = 0;
+	if (rd->flags & RENAME_NOREPLACE)
+		target_flags |= LOOKUP_EXCL;
+
+	trap = lock_rename(rd->old_parent, rd->new_parent);
+	if (IS_ERR(trap))
+		return PTR_ERR(trap);
+
+	d1 = lookup_one_qstr_excl(old_last, rd->old_parent,
+				  lookup_flags);
+	if (IS_ERR(d1))
+		goto out_unlock_1;
+
+	d2 = lookup_one_qstr_excl(new_last, rd->new_parent,
+				  lookup_flags | target_flags);
+	if (IS_ERR(d2))
+		goto out_unlock_2;
+
+	if (d1 == trap) {
+		/* source is an ancestor of target */
+		err = -EINVAL;
+		goto out_unlock_3;
+	}
+
+	if (d2 == trap) {
+		/* target is an ancestor of source */
+		if (rd->flags & RENAME_EXCHANGE)
+			err = -EINVAL;
+		else
+			err = -ENOTEMPTY;
+		goto out_unlock_3;
+	}
+
+	rd->old_dentry = d1;
+	rd->new_dentry = d2;
+	return 0;
+
+out_unlock_3:
+	dput(d2);
+	d2 = ERR_PTR(err);
+out_unlock_2:
+	dput(d1);
+	d1 = d2;
+out_unlock_1:
+	unlock_rename(rd->old_parent, rd->new_parent);
+	return PTR_ERR(d1);
+}
+
+/**
+ * start_renaming - lookup and lock names for rename with permission checking
+ * @rd:           rename data containing parent and flags, and
+ *                for receiving found dentries
+ * @lookup_flags: extra flags to pass to ->lookup (e.g. LOOKUP_REVAL,
+ *                LOOKUP_NO_SYMLINKS etc).
+ * @old_last:     name of object in @rd.old_parent
+ * @new_last:     name of object in @rd.new_parent
+ *
+ * Look up two names and ensure locks are in place for
+ * rename.
+ *
+ * On success the found dentrys are stored in @rd.old_dentry,
+ * @rd.new_dentry.  These references and the lock are dropped by
+ * end_renaming().
+ *
+ * The passed in qstrs need not have the hash calculated, and basic
+ * eXecute permission checking is performed against @rd.mnt_idmap.
+ *
+ * Returns: zero or an error.
+ */
+int start_renaming(struct renamedata *rd, int lookup_flags,
+		   struct qstr *old_last, struct qstr *new_last)
+{
+	int err;
+
+	err = lookup_one_common(rd->mnt_idmap, old_last, rd->old_parent);
+	if (err)
+		return err;
+	err = lookup_one_common(rd->mnt_idmap, new_last, rd->new_parent);
+	if (err)
+		return err;
+	return __start_renaming(rd, lookup_flags, old_last, new_last);
+}
+EXPORT_SYMBOL(start_renaming);
+
+void end_renaming(struct renamedata *rd)
+{
+	unlock_rename(rd->old_parent, rd->new_parent);
+	dput(rd->old_dentry);
+	dput(rd->new_dentry);
+}
+EXPORT_SYMBOL(end_renaming);
+
 /**
  * vfs_prepare_mode - prepare the mode to be used for a new inode
  * @idmap:	idmap of the mount the inode was found from
@@ -5509,14 +5632,11 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 		 struct filename *to, unsigned int flags)
 {
 	struct renamedata rd;
-	struct dentry *old_dentry, *new_dentry;
-	struct dentry *trap;
 	struct path old_path, new_path;
 	struct qstr old_last, new_last;
 	int old_type, new_type;
 	struct inode *delegated_inode = NULL;
-	unsigned int lookup_flags = 0, target_flags =
-		LOOKUP_RENAME_TARGET | LOOKUP_CREATE;
+	unsigned int lookup_flags = 0;
 	bool should_retry = false;
 	int error = -EINVAL;
 
@@ -5527,11 +5647,6 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 	    (flags & RENAME_EXCHANGE))
 		goto put_names;
 
-	if (flags & RENAME_EXCHANGE)
-		target_flags = 0;
-	if (flags & RENAME_NOREPLACE)
-		target_flags |= LOOKUP_EXCL;
-
 retry:
 	error = filename_parentat(olddfd, from, lookup_flags, &old_path,
 				  &old_last, &old_type);
@@ -5561,66 +5676,40 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 		goto exit2;
 
 retry_deleg:
-	trap = lock_rename(new_path.dentry, old_path.dentry);
-	if (IS_ERR(trap)) {
-		error = PTR_ERR(trap);
+	rd.old_parent	   = old_path.dentry;
+	rd.mnt_idmap	   = mnt_idmap(old_path.mnt);
+	rd.new_parent	   = new_path.dentry;
+	rd.delegated_inode = &delegated_inode;
+	rd.flags	   = flags;
+
+	error = __start_renaming(&rd, lookup_flags, &old_last, &new_last);
+	if (error)
 		goto exit_lock_rename;
-	}
 
-	old_dentry = lookup_one_qstr_excl(&old_last, old_path.dentry,
-					  lookup_flags);
-	error = PTR_ERR(old_dentry);
-	if (IS_ERR(old_dentry))
-		goto exit3;
-	new_dentry = lookup_one_qstr_excl(&new_last, new_path.dentry,
-					  lookup_flags | target_flags);
-	error = PTR_ERR(new_dentry);
-	if (IS_ERR(new_dentry))
-		goto exit4;
 	if (flags & RENAME_EXCHANGE) {
-		if (!d_is_dir(new_dentry)) {
+		if (!d_is_dir(rd.new_dentry)) {
 			error = -ENOTDIR;
 			if (new_last.name[new_last.len])
-				goto exit5;
+				goto exit_unlock;
 		}
 	}
 	/* unless the source is a directory trailing slashes give -ENOTDIR */
-	if (!d_is_dir(old_dentry)) {
+	if (!d_is_dir(rd.old_dentry)) {
 		error = -ENOTDIR;
 		if (old_last.name[old_last.len])
-			goto exit5;
+			goto exit_unlock;
 		if (!(flags & RENAME_EXCHANGE) && new_last.name[new_last.len])
-			goto exit5;
-	}
-	/* source should not be ancestor of target */
-	error = -EINVAL;
-	if (old_dentry == trap)
-		goto exit5;
-	/* target should not be an ancestor of source */
-	if (!(flags & RENAME_EXCHANGE))
-		error = -ENOTEMPTY;
-	if (new_dentry == trap)
-		goto exit5;
+			goto exit_unlock;
+	}
 
-	error = security_path_rename(&old_path, old_dentry,
-				     &new_path, new_dentry, flags);
+	error = security_path_rename(&old_path, rd.old_dentry,
+				     &new_path, rd.new_dentry, flags);
 	if (error)
-		goto exit5;
+		goto exit_unlock;
 
-	rd.old_parent	   = old_path.dentry;
-	rd.old_dentry	   = old_dentry;
-	rd.mnt_idmap	   = mnt_idmap(old_path.mnt);
-	rd.new_parent	   = new_path.dentry;
-	rd.new_dentry	   = new_dentry;
-	rd.delegated_inode = &delegated_inode;
-	rd.flags	   = flags;
 	error = vfs_rename(&rd);
-exit5:
-	dput(new_dentry);
-exit4:
-	dput(old_dentry);
-exit3:
-	unlock_rename(new_path.dentry, old_path.dentry);
+exit_unlock:
+	end_renaming(&rd);
 exit_lock_rename:
 	if (delegated_inode) {
 		error = break_deleg_wait(&delegated_inode);
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index d5b4550fd8f6..091112d931f9 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1862,11 +1862,12 @@ __be32
 nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 			    struct svc_fh *tfhp, char *tname, int tlen)
 {
-	struct dentry	*fdentry, *tdentry, *odentry, *ndentry, *trap;
+	struct dentry	*fdentry, *tdentry;
 	int		type = S_IFDIR;
+	struct renamedata rd = {};
 	__be32		err;
 	int		host_err;
-	bool		close_cached = false;
+	struct dentry	*close_cached;
 
 	trace_nfsd_vfs_rename(rqstp, ffhp, tfhp, fname, flen, tname, tlen);
 
@@ -1892,15 +1893,22 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 		goto out;
 
 retry:
+	close_cached = NULL;
 	host_err = fh_want_write(ffhp);
 	if (host_err) {
 		err = nfserrno(host_err);
 		goto out;
 	}
 
-	trap = lock_rename(tdentry, fdentry);
-	if (IS_ERR(trap)) {
-		err = nfserr_xdev;
+	rd.mnt_idmap	= &nop_mnt_idmap;
+	rd.old_parent	= fdentry;
+	rd.new_parent	= tdentry;
+
+	host_err = start_renaming(&rd, 0, &QSTR_LEN(fname, flen),
+				  &QSTR_LEN(tname, tlen));
+
+	if (host_err) {
+		err = nfserrno(host_err);
 		goto out_want_write;
 	}
 	err = fh_fill_pre_attrs(ffhp);
@@ -1910,48 +1918,23 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	if (err != nfs_ok)
 		goto out_unlock;
 
-	odentry = lookup_one(&nop_mnt_idmap, &QSTR_LEN(fname, flen), fdentry);
-	host_err = PTR_ERR(odentry);
-	if (IS_ERR(odentry))
-		goto out_nfserr;
+	type = d_inode(rd.old_dentry)->i_mode & S_IFMT;
+
+	if (d_inode(rd.new_dentry))
+		type = d_inode(rd.new_dentry)->i_mode & S_IFMT;
 
-	host_err = -ENOENT;
-	if (d_really_is_negative(odentry))
-		goto out_dput_old;
-	host_err = -EINVAL;
-	if (odentry == trap)
-		goto out_dput_old;
-	type = d_inode(odentry)->i_mode & S_IFMT;
-
-	ndentry = lookup_one(&nop_mnt_idmap, &QSTR_LEN(tname, tlen), tdentry);
-	host_err = PTR_ERR(ndentry);
-	if (IS_ERR(ndentry))
-		goto out_dput_old;
-	if (d_inode(ndentry))
-		type = d_inode(ndentry)->i_mode & S_IFMT;
-	host_err = -ENOTEMPTY;
-	if (ndentry == trap)
-		goto out_dput_new;
-
-	if ((ndentry->d_sb->s_export_op->flags & EXPORT_OP_CLOSE_BEFORE_UNLINK) &&
-	    nfsd_has_cached_files(ndentry)) {
-		close_cached = true;
-		goto out_dput_old;
+	if ((rd.new_dentry->d_sb->s_export_op->flags & EXPORT_OP_CLOSE_BEFORE_UNLINK) &&
+	    nfsd_has_cached_files(rd.new_dentry)) {
+		close_cached = dget(rd.new_dentry);
+		goto out_unlock;
 	} else {
-		struct renamedata rd = {
-			.mnt_idmap	= &nop_mnt_idmap,
-			.old_parent	= fdentry,
-			.old_dentry	= odentry,
-			.new_parent	= tdentry,
-			.new_dentry	= ndentry,
-		};
 		int retries;
 
 		for (retries = 1;;) {
 			host_err = vfs_rename(&rd);
 			if (host_err != -EAGAIN || !retries--)
 				break;
-			if (!nfsd_wait_for_delegreturn(rqstp, d_inode(odentry)))
+			if (!nfsd_wait_for_delegreturn(rqstp, d_inode(rd.old_dentry)))
 				break;
 		}
 		if (!host_err) {
@@ -1960,11 +1943,6 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 				host_err = commit_metadata(ffhp);
 		}
 	}
- out_dput_new:
-	dput(ndentry);
- out_dput_old:
-	dput(odentry);
- out_nfserr:
 	if (host_err == -EBUSY) {
 		/*
 		 * See RFC 8881 Section 18.26.4 para 1-3: NFSv4 RENAME
@@ -1983,7 +1961,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 		fh_fill_post_attrs(tfhp);
 	}
 out_unlock:
-	unlock_rename(tdentry, fdentry);
+	end_renaming(&rd);
 out_want_write:
 	fh_drop_write(ffhp);
 
@@ -1994,9 +1972,8 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	 * until this point and then reattempt the whole shebang.
 	 */
 	if (close_cached) {
-		close_cached = false;
-		nfsd_close_cached_files(ndentry);
-		dput(ndentry);
+		nfsd_close_cached_files(close_cached);
+		dput(close_cached);
 		goto retry;
 	}
 out:
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 74b1ef5860a4..b37aefe465a2 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -1099,9 +1099,7 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 	int err;
 	struct dentry *old_upperdir;
 	struct dentry *new_upperdir;
-	struct dentry *olddentry = NULL;
-	struct dentry *newdentry = NULL;
-	struct dentry *trap, *de;
+	struct renamedata rd = {};
 	bool old_opaque;
 	bool new_opaque;
 	bool cleanup_whiteout = false;
@@ -1208,29 +1206,21 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 		}
 	}
 
-	trap = lock_rename(new_upperdir, old_upperdir);
-	if (IS_ERR(trap)) {
-		err = PTR_ERR(trap);
-		goto out_revert_creds;
-	}
+	rd.mnt_idmap = ovl_upper_mnt_idmap(ofs);
+	rd.old_parent = old_upperdir;
+	rd.new_parent = new_upperdir;
+	rd.flags = flags;
 
-	de = ovl_lookup_upper(ofs, old->d_name.name, old_upperdir,
-			      old->d_name.len);
-	err = PTR_ERR(de);
-	if (IS_ERR(de))
-		goto out_unlock;
-	olddentry = de;
+	err = start_renaming(&rd, 0,
+			     &QSTR_LEN(old->d_name.name, old->d_name.len),
+			     &QSTR_LEN(new->d_name.name, new->d_name.len));
 
-	err = -ESTALE;
-	if (!ovl_matches_upper(old, olddentry))
-		goto out_unlock;
+	if (err)
+		goto out_revert_creds;
 
-	de = ovl_lookup_upper(ofs, new->d_name.name, new_upperdir,
-			      new->d_name.len);
-	err = PTR_ERR(de);
-	if (IS_ERR(de))
+	err = -ESTALE;
+	if (!ovl_matches_upper(old, rd.old_dentry))
 		goto out_unlock;
-	newdentry = de;
 
 	old_opaque = ovl_dentry_is_opaque(old);
 	new_opaque = ovl_dentry_is_opaque(new);
@@ -1238,15 +1228,15 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 	err = -ESTALE;
 	if (d_inode(new) && ovl_dentry_upper(new)) {
 		if (opaquedir) {
-			if (newdentry != opaquedir)
+			if (rd.new_dentry != opaquedir)
 				goto out_unlock;
 		} else {
-			if (!ovl_matches_upper(new, newdentry))
+			if (!ovl_matches_upper(new, rd.new_dentry))
 				goto out_unlock;
 		}
 	} else {
-		if (!d_is_negative(newdentry)) {
-			if (!new_opaque || !ovl_upper_is_whiteout(ofs, newdentry))
+		if (!d_is_negative(rd.new_dentry)) {
+			if (!new_opaque || !ovl_upper_is_whiteout(ofs, rd.new_dentry))
 				goto out_unlock;
 		} else {
 			if (flags & RENAME_EXCHANGE)
@@ -1254,19 +1244,14 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 		}
 	}
 
-	if (olddentry == trap)
-		goto out_unlock;
-	if (newdentry == trap)
-		goto out_unlock;
-
-	if (olddentry->d_inode == newdentry->d_inode)
+	if (rd.old_dentry->d_inode == rd.new_dentry->d_inode)
 		goto out_unlock;
 
 	err = 0;
 	if (ovl_type_merge_or_lower(old))
 		err = ovl_set_redirect(old, samedir);
 	else if (is_dir && !old_opaque && ovl_type_merge(new->d_parent))
-		err = ovl_set_opaque_xerr(old, olddentry, -EXDEV);
+		err = ovl_set_opaque_xerr(old, rd.old_dentry, -EXDEV);
 	if (err)
 		goto out_unlock;
 
@@ -1274,19 +1259,22 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 		err = ovl_set_redirect(new, samedir);
 	else if (!overwrite && new_is_dir && !new_opaque &&
 		 ovl_type_merge(old->d_parent))
-		err = ovl_set_opaque_xerr(new, newdentry, -EXDEV);
+		err = ovl_set_opaque_xerr(new, rd.new_dentry, -EXDEV);
 	if (err)
 		goto out_unlock;
 
-	err = ovl_do_rename(ofs, old_upperdir, olddentry,
-			    new_upperdir, newdentry, flags);
-	unlock_rename(new_upperdir, old_upperdir);
+	err = ovl_do_rename_rd(&rd);
+
+	dget(rd.new_dentry);
+	end_renaming(&rd);
+
+	if (!err && cleanup_whiteout) {
+		ovl_cleanup(ofs, old_upperdir, rd.new_dentry);
+	}
+	dput(rd.new_dentry);
 	if (err)
 		goto out_revert_creds;
 
-	if (cleanup_whiteout)
-		ovl_cleanup(ofs, old_upperdir, newdentry);
-
 	if (overwrite && d_inode(new)) {
 		if (new_is_dir)
 			clear_nlink(d_inode(new));
@@ -1311,14 +1299,12 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 	else
 		ovl_drop_write(old);
 out:
-	dput(newdentry);
-	dput(olddentry);
 	dput(opaquedir);
 	ovl_cache_free(&list);
 	return err;
 
 out_unlock:
-	unlock_rename(new_upperdir, old_upperdir);
+	end_renaming(&rd);
 	goto out_revert_creds;
 }
 
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 915af58459b7..181fc46195f2 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -378,6 +378,20 @@ static inline int ovl_do_rename(struct ovl_fs *ofs, struct dentry *olddir,
 	return err;
 }
 
+static inline int ovl_do_rename_rd(struct renamedata *rd)
+{
+	int err;
+
+	pr_debug("rename(%pd2, %pd2, 0x%x)\n", rd->old_dentry, rd->new_dentry,
+		 rd->flags);
+	err = vfs_rename(rd);
+	if (err) {
+		pr_debug("...rename(%pd2, %pd2, ...) = %i\n",
+			 rd->old_dentry, rd->new_dentry, err);
+	}
+	return err;
+}
+
 static inline int ovl_do_whiteout(struct ovl_fs *ofs,
 				  struct inode *dir, struct dentry *dentry)
 {
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 9771ec940b72..b65ed6e1e91a 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -140,6 +140,9 @@ extern int follow_up(struct path *);
 extern struct dentry *lock_rename(struct dentry *, struct dentry *);
 extern struct dentry *lock_rename_child(struct dentry *, struct dentry *);
 extern void unlock_rename(struct dentry *, struct dentry *);
+int start_renaming(struct renamedata *rd, int lookup_flags,
+		   struct qstr *old_last, struct qstr *new_last);
+void end_renaming(struct renamedata *rd);
 
 /**
  * mode_strip_umask - handle vfs umask stripping
-- 
2.50.0.107.gf914562f5916.dirty


