Return-Path: <linux-fsdevel+bounces-68134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04776C5502A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 01:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49B8D3B4D72
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 00:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D0F24728E;
	Thu, 13 Nov 2025 00:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Bhk1Hnj4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kpdPpHYn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF4219DF8D;
	Thu, 13 Nov 2025 00:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762994522; cv=none; b=VhIEcitCzLFMqs/FvB5ct5410r8LyPZAP62H5nuJhkRjS/9c8KwI4+Ywa+okFB34uP6864RCKz52E8yJU5FQ6t9l6vnl65c2agckmzIM1OJe5fdcFmOwObeR4xFpKvhNvckGKzsXX3AP3ti8jTNgEq8ykdqJFEPoBJXAa5G01a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762994522; c=relaxed/simple;
	bh=xOImIVeSMN16wXEUQAzN8F2o53fV+JAPH3r8GJvS3Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oiX4umDRNn8bxc+2v2A6KfSw9DJg6ATZB6BiwIS4O49P+zS/wZKKO8sfkSDsEcscOW5awUiVvAagxs+4wwqZbFNMM/p8PPJgSjqet5EAdgYzyWEunZ7sSPK3OzcZuwQVDRAFguj21dc/MU4oMCDpez5ILYLNQHO8ymQuATISO+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Bhk1Hnj4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kpdPpHYn; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id B110513000C2;
	Wed, 12 Nov 2025 19:41:58 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 12 Nov 2025 19:41:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1762994518;
	 x=1763001718; bh=aEcYm+X1tX1kfPjR3Nk7GlQrwLEMuDBgjP9bjr8j+Bo=; b=
	Bhk1Hnj4d3YNdO16zlg4OQI798Pw+Ub178r1AVkYlk6E9uAYhwkjcN49lInOEqB5
	62BKn0VJci0ehMNDospYQjr/mlEl99NQyjLwgGNbNtYz7Dqyd/nB3K18cCJxW5fG
	+BPTvSi6pmLZgmHpKi6CxL6bUoQAKATBtbL7KlCjRqhjHLuAqddEqz0wf+E286km
	swFyTogNLB9WGDj9lKbSsFN36m2ncKRm1aEY6l5D50vZSkhnKHhlFoc8PbFWHQvj
	SLVKe486Ti30P50tWJ2pqOMYLm0EAqRctwCDAoBWnbsnydfXYe8iZaCnaMcmjUE/
	ifjpU0ZcHMsCBtD2hSIfFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1762994518; x=1763001718; bh=a
	EcYm+X1tX1kfPjR3Nk7GlQrwLEMuDBgjP9bjr8j+Bo=; b=kpdPpHYnRfaYyRPL7
	7P4mnZebfGBRJiSu7bEAZx9BIAjhLIVVqwzTn20okJgVNAgJXZHh59xacloW5m6x
	36AKR1fsec6VicVJ+gNfNWIt1f3S0htTUyWH1vP1ia9d1e2WXz7gIqptiramI19b
	XEFxOVk6je+z0ts37xzJrFzwB1l8tKyfUwFaLjbzxetvLc9fkr6G8trxwkM3lvZZ
	plFFWuEYAEKhBgMJp840g1/gBiBOfgGNx5GnXUxKiWL/6jIycUenrta79NRmIcPC
	Xp60gA62F+nEpFaitKHmGuglTaAa2NB0cA+uvkFVuuVsks+MM9tKwmlB+JpbQBRI
	6ciFA==
X-ME-Sender: <xms:VikVafKsRT46IMdcZaEeO6SmTg8DbSZB6DMCJazDJZ6WtUVfNWOuCg>
    <xme:VikVaYPdJVWynPo11Dr70-Qt1NPdzZu-voaVf2Kn0GlFe_lGapZPIuLuTnPfb-LOX
    yPiMRuZS-e1xtFbylgAKHSFbWD2NnQv28ahEXwL49p3oLqbgw>
X-ME-Received: <xmr:VikVaUtIDQDmMw_SmvgbZLzBavkWY6Yk1AINiT_Ae5V1wRcuqbKzBe7X3udeK6IGAqRBj3didFnMsN5L4POOHf9QHUWt17145NYtzMM5bK4q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdehheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepgedtpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdigfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidquhhnihhonhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqtghifhhssehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:VikVaWHL7RiNoBHoXkBJej6y2OOCznc_okGiIFz0FJPlIfaXaRnQyg>
    <xmx:VikVaX5V9Zg6gn8DLG2HKy6K-uUE3B580OblBansd1BSCYziRMb2RQ>
    <xmx:VikVaRWpSfNjZ3kTdwE3XfqcVeGVTMXATFeIIAMBHUYfmi7cTRfhgw>
    <xmx:VikVaZzw2rUIs32mBQMQkzqBSHo3U8UCg4HFtYpk9MzidHWgze_SnQ>
    <xmx:VikVaWoGdeVX4dBl_9SdX6DefyWmiuQy-8ningcP08XnggsI804DwtUg>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 19:41:47 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>
Cc: "Jan Kara" <jack@suse.cz>,	linux-fsdevel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,	David Howells <dhowells@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,	Tyler Hicks <code@tyhicks.com>,
	Miklos Szeredi <miklos@szeredi.hu>,	Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>,	Dai Ngo <Dai.Ngo@oracle.com>,
	Namjae Jeon <linkinjeon@kernel.org>,	Steve French <smfrench@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Carlos Maiolino <cem@kernel.org>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,	Mateusz Guzik <mjguzik@gmail.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	"Darrick J. Wong" <djwong@kernel.org>,	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,	ecryptfs@vger.kernel.org,
	linux-nfs@vger.kernel.org,	linux-unionfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,	linux-xfs@vger.kernel.org,
	linux-security-module@vger.kernel.org,	selinux@vger.kernel.org
Subject: [PATCH v6 10/15] VFS/nfsd/ovl: introduce start_renaming() and end_renaming()
Date: Thu, 13 Nov 2025 11:18:33 +1100
Message-ID: <20251113002050.676694-11-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251113002050.676694-1-neilb@ownmail.net>
References: <20251113002050.676694-1-neilb@ownmail.net>
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
cases where one or both dentries are already available will be handled
separately.

__start_renaming() avoids the inode_permission check and hash
calculation and is suitable after filename_parentat() in do_renameat2().
It subsumes quite a bit of code from that function.

start_renaming() does calculate the hash and check X permission and is
suitable elsewhere:
- nfsd_rename()
- ovl_rename()

In ovl, ovl_do_rename_rd() is factored out of ovl_do_rename(), which
itself will be gone by the end of the series.

Acked-by: Chuck Lever <chuck.lever@oracle.com> (for nfsd parts)
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: NeilBrown <neil@brown.name>

--
Changes since v3:
 - added missig dput() in ovl_rename when "whiteout" is not-NULL.

Changes since v2:
 - in __start_renaming() some label have been renamed, and err
   is always set before a "goto out_foo" rather than passing the
   error in a dentry*.
 - ovl_do_rename() changed to call the new ovl_do_rename_rd() rather
   than keeping duplicate code
 - code around ovl_cleanup() call in ovl_rename() restructured.
---
 fs/namei.c               | 197 ++++++++++++++++++++++++++++-----------
 fs/nfsd/vfs.c            |  73 +++++----------
 fs/overlayfs/dir.c       |  74 +++++++--------
 fs/overlayfs/overlayfs.h |  23 +++--
 include/linux/namei.h    |   3 +
 5 files changed, 218 insertions(+), 152 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index e70d056b9543..bad6c9d540f9 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3667,6 +3667,129 @@ void unlock_rename(struct dentry *p1, struct dentry *p2)
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
+ * On success the found dentries are stored in @rd.old_dentry,
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
+	err = PTR_ERR(d1);
+	if (IS_ERR(d1))
+		goto out_unlock;
+
+	d2 = lookup_one_qstr_excl(new_last, rd->new_parent,
+				  lookup_flags | target_flags);
+	err = PTR_ERR(d2);
+	if (IS_ERR(d2))
+		goto out_dput_d1;
+
+	if (d1 == trap) {
+		/* source is an ancestor of target */
+		err = -EINVAL;
+		goto out_dput_d2;
+	}
+
+	if (d2 == trap) {
+		/* target is an ancestor of source */
+		if (rd->flags & RENAME_EXCHANGE)
+			err = -EINVAL;
+		else
+			err = -ENOTEMPTY;
+		goto out_dput_d2;
+	}
+
+	rd->old_dentry = d1;
+	rd->new_dentry = d2;
+	return 0;
+
+out_dput_d2:
+	dput(d2);
+out_dput_d1:
+	dput(d1);
+out_unlock:
+	unlock_rename(rd->old_parent, rd->new_parent);
+	return err;
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
+ * On success the found dentries are stored in @rd.old_dentry,
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
@@ -5504,14 +5627,11 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
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
 
@@ -5522,11 +5642,6 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
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
@@ -5556,66 +5671,40 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
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
index 6291c371caa7..a993f1e54182 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1885,11 +1885,12 @@ __be32
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
 
@@ -1915,15 +1916,22 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
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
@@ -1933,48 +1941,23 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
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
@@ -1983,11 +1966,6 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
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
@@ -2006,7 +1984,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 		fh_fill_post_attrs(tfhp);
 	}
 out_unlock:
-	unlock_rename(tdentry, fdentry);
+	end_renaming(&rd);
 out_want_write:
 	fh_drop_write(ffhp);
 
@@ -2017,9 +1995,8 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
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
index 6d1d0e94e287..cf6fc48459f3 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -1124,9 +1124,7 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
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
@@ -1136,6 +1134,7 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 	bool new_is_dir = d_is_dir(new);
 	bool samedir = olddir == newdir;
 	struct dentry *opaquedir = NULL;
+	struct dentry *whiteout = NULL;
 	const struct cred *old_cred = NULL;
 	struct ovl_fs *ofs = OVL_FS(old->d_sb);
 	LIST_HEAD(list);
@@ -1233,29 +1232,21 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
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
@@ -1263,15 +1254,15 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
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
@@ -1279,19 +1270,14 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
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
 
@@ -1299,18 +1285,24 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
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
+	if (!err && cleanup_whiteout)
+		whiteout = dget(rd.new_dentry);
+
+	end_renaming(&rd);
+
 	if (err)
 		goto out_revert_creds;
 
-	if (cleanup_whiteout)
-		ovl_cleanup(ofs, old_upperdir, newdentry);
+	if (whiteout) {
+		ovl_cleanup(ofs, old_upperdir, whiteout);
+		dput(whiteout);
+	}
 
 	if (overwrite && d_inode(new)) {
 		if (new_is_dir)
@@ -1336,14 +1328,12 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
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
index 49ad65f829dc..3cc85a893b5c 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -355,11 +355,24 @@ static inline int ovl_do_remove_acl(struct ovl_fs *ofs, struct dentry *dentry,
 	return vfs_remove_acl(ovl_upper_mnt_idmap(ofs), dentry, acl_name);
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
 static inline int ovl_do_rename(struct ovl_fs *ofs, struct dentry *olddir,
 				struct dentry *olddentry, struct dentry *newdir,
 				struct dentry *newdentry, unsigned int flags)
 {
-	int err;
 	struct renamedata rd = {
 		.mnt_idmap	= ovl_upper_mnt_idmap(ofs),
 		.old_parent	= olddir,
@@ -369,13 +382,7 @@ static inline int ovl_do_rename(struct ovl_fs *ofs, struct dentry *olddir,
 		.flags		= flags,
 	};
 
-	pr_debug("rename(%pd2, %pd2, 0x%x)\n", olddentry, newdentry, flags);
-	err = vfs_rename(&rd);
-	if (err) {
-		pr_debug("...rename(%pd2, %pd2, ...) = %i\n",
-			 olddentry, newdentry, err);
-	}
-	return err;
+	return ovl_do_rename_rd(&rd);
 }
 
 static inline int ovl_do_whiteout(struct ovl_fs *ofs,
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 196c66156a8a..7fdd9fdcbd2b 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -157,6 +157,9 @@ extern int follow_up(struct path *);
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


