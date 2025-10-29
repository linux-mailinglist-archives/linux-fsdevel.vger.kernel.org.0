Return-Path: <linux-fsdevel+bounces-66396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D669AC1DCD8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 00:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10EDD42467E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 23:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C60D32D421;
	Wed, 29 Oct 2025 23:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="GmHJclZA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z84vu4tZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A1132BF3D;
	Wed, 29 Oct 2025 23:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761781616; cv=none; b=bR2zPjMC7V8JAcGti7yjhn2uVj59D2LIPS3wG2l1dE8v60Qw79XoQwjSlInItrnb8v6IjIC3MSm9kMExyOXMO70q497RH/DRJOXtrUgS9OW8thEnJigBKMQHeUU63JAgLZCXbzfer30woy+hjOtkPcYwq7utGBbyP38xo9IvxEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761781616; c=relaxed/simple;
	bh=GrWrrLtSHjdzhh+W7LDg0wRWtUM1d37s9wITVHkhKaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RSfQjhJLTaqk3y9yNRa6L340K+OEpouxMK9cINt52IfBjuFeIIt7IpyW4ixEMZbr95Fx+2WF1yDx5aFnqSyr2UCE3UOM1K0wYBusabySmXRVOL2Tw3RN+sMOU8IhpEubB8OJQySjuRS4dRi3zUytMDyGZN9wzabQih3onXdxtNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=GmHJclZA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z84vu4tZ; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id 9A894130007D;
	Wed, 29 Oct 2025 19:46:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 29 Oct 2025 19:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1761781612;
	 x=1761788812; bh=I3P06nc1qk5mWCjVqPmobZQ5mBOMMFA2/DiQeMin+P4=; b=
	GmHJclZAxYDUWRHlLZVZiZMiDOwcFUYOk2xNR5BCveB1IOgLVggzA81s0Z7XjbL0
	UxCXYYeBe/BNbJPJrctorYclNq8uOt6fa1OBm8fLq79JeHXMP2FefyHmE8RdQwxG
	5rCEik7BQ/KEjN9xRgf13+VQwVG2kJzRKje3Q8vXUBW25tz6Iiiu8r85dmJmiS50
	1rcoXhuM85nfzN6u/ojhEHxgnI3jjZ5BNVDcGRs2KweTl62WauS0TbmGrCQwgOas
	822+IN/EfJjezOdsWlzTWANuS9WXBgwANQzFr9iCL/AcVVRDH8jysa3P+BcNAdV2
	hWzSBOKA9uze5cCnVzYG3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1761781612; x=1761788812; bh=I
	3P06nc1qk5mWCjVqPmobZQ5mBOMMFA2/DiQeMin+P4=; b=Z84vu4tZME4hMwHHm
	squSoQoIIWEnwI90a8WagcOLyxKflDZYq0MSUGL3Y5cqLTA2G7uWK3QZY1rNeEXn
	ivoP/dTHZPvdxdAllQoCvW/fISRJD/GHn56X3nKy8Zh4kEyo7/uHn1lToDXdtlrv
	h6a6bsi90+ft8LC3j4quu/XjrgkPEVgnmwfqcsVw8e5ibWosn5J8yYfGVwO2vfb5
	Z0Rc5TkB95uFWGWpDsa1aakUf8fwq2K/BsPySrklXPj/6jop0TVOh3mP00Y9g5jx
	JjLc6dWG0Xud+Nscek8tew10y1bfh1NjOUgdC3gkEZXfP0tq6z0fyG2lQVI3I9FR
	7A2jg==
X-ME-Sender: <xms:a6cCabOtuziZ_7cil2ZY5QZJY02bV-Vb-K5Tr7stS9fZOuBItBUDvQ>
    <xme:a6cCad9mbwJXgRrQVSJtYcbx1YwXJdteUOYhwwyWnTiU0BmQcNaW2Mvpi-ztVcdDJ
    vJouxoRhD9hfdzrR5ZrHKECu2zJta6-dxhFB7QZPPMNeRlE>
X-ME-Received: <xmr:a6cCaa78K4ljHjxZqRoDvwUSUdHMMkYHPWCGwQ3cNDVNGMrG3uIZjfpklMT_8e9vkSivoBMdHCEvv7j4B-VvMc-1sEyaJ_bN0y9mzDWnZ2h2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieehtdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepgedupdhmohguvgepshhmthhp
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
X-ME-Proxy: <xmx:a6cCafQcFF65StYNIadTkqkXHsDrpWrP8VDkJh-y8H3ftuoFM6MlTg>
    <xmx:a6cCaXOO63irZfzJEzdy_O0XNTwjCcCZeto6PAgzosrYdOte8--KMA>
    <xmx:a6cCadovevhuiLP8Z2ntoKtU9DIWf0xy7VVkOcHFbdjXpyD2gaOUFw>
    <xmx:a6cCaeQvrCzVhHfKRrFejG_I7hOK-J7MxotoKZH1rHgQW9b_MOOhgQ>
    <xmx:bKcCac59HxqJcsLpu8MnnR_lEclqM1giVSX3jTUXo5Aw3XnmsIYjBsYM>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Oct 2025 19:46:41 -0400 (EDT)
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
	apparmor@lists.ubuntu.com,	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH v4 10/14] VFS/ovl/smb: introduce start_renaming_dentry()
Date: Thu, 30 Oct 2025 10:31:10 +1100
Message-ID: <20251029234353.1321957-11-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251029234353.1321957-1-neilb@ownmail.net>
References: <20251029234353.1321957-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

Several callers perform a rename on a dentry they already have, and only
require lookup for the target name.  This includes smb/server and a few
different places in overlayfs.

start_renaming_dentry() performs the required lookup and takes the
required lock using lock_rename_child()

It is used in three places in overlayfs and in ksmbd_vfs_rename().

In the ksmbd case, the parent of the source is not important - the
source must be renamed from wherever it is.  So start_renaming_dentry()
allows rd->old_parent to be NULL and only checks it if it is non-NULL.
On success rd->old_parent will be the parent of old_dentry with an extra
reference taken.  Other start_renaming function also now take the extra
reference and end_renaming() now drops this reference as well.

ovl_lookup_temp(), ovl_parent_lock(), and ovl_parent_unlock() are
all removed as they are no longer needed.

OVL_TEMPNAME_SIZE and ovl_tempname() are now declared in overlayfs.h so
that ovl_check_rename_whiteout() can access them.

ovl_copy_up_workdir() now always cleans up on error.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c               | 108 ++++++++++++++++++++++++++++++++++++---
 fs/overlayfs/copy_up.c   |  54 +++++++++-----------
 fs/overlayfs/dir.c       |  19 +------
 fs/overlayfs/overlayfs.h |   8 +--
 fs/overlayfs/super.c     |  22 ++++----
 fs/overlayfs/util.c      |  11 ----
 fs/smb/server/vfs.c      |  60 ++++------------------
 include/linux/namei.h    |   2 +
 8 files changed, 150 insertions(+), 134 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 0ee0a110b088..5153ceddd37a 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3669,7 +3669,7 @@ EXPORT_SYMBOL(unlock_rename);
 
 /**
  * __start_renaming - lookup and lock names for rename
- * @rd:           rename data containing parent and flags, and
+ * @rd:           rename data containing parents and flags, and
  *                for receiving found dentries
  * @lookup_flags: extra flags to pass to ->lookup (e.g. LOOKUP_REVAL,
  *                LOOKUP_NO_SYMLINKS etc).
@@ -3680,8 +3680,8 @@ EXPORT_SYMBOL(unlock_rename);
  * rename.
  *
  * On success the found dentries are stored in @rd.old_dentry,
- * @rd.new_dentry.  These references and the lock are dropped by
- * end_renaming().
+ * @rd.new_dentry and an extra ref is taken on @rd.old_parent.
+ * These references and the lock are dropped by end_renaming().
  *
  * The passed in qstrs must have the hash calculated, and no permission
  * checking is performed.
@@ -3735,6 +3735,7 @@ __start_renaming(struct renamedata *rd, int lookup_flags,
 
 	rd->old_dentry = d1;
 	rd->new_dentry = d2;
+	dget(rd->old_parent);
 	return 0;
 
 out_dput_d2:
@@ -3748,7 +3749,7 @@ __start_renaming(struct renamedata *rd, int lookup_flags,
 
 /**
  * start_renaming - lookup and lock names for rename with permission checking
- * @rd:           rename data containing parent and flags, and
+ * @rd:           rename data containing parents and flags, and
  *                for receiving found dentries
  * @lookup_flags: extra flags to pass to ->lookup (e.g. LOOKUP_REVAL,
  *                LOOKUP_NO_SYMLINKS etc).
@@ -3759,8 +3760,8 @@ __start_renaming(struct renamedata *rd, int lookup_flags,
  * rename.
  *
  * On success the found dentries are stored in @rd.old_dentry,
- * @rd.new_dentry.  These references and the lock are dropped by
- * end_renaming().
+ * @rd.new_dentry.  Also the refcount on @rd->old_parent is increased.
+ * These references and the lock are dropped by end_renaming().
  *
  * The passed in qstrs need not have the hash calculated, and basic
  * eXecute permission checking is performed against @rd.mnt_idmap.
@@ -3782,11 +3783,106 @@ int start_renaming(struct renamedata *rd, int lookup_flags,
 }
 EXPORT_SYMBOL(start_renaming);
 
+static int
+__start_renaming_dentry(struct renamedata *rd, int lookup_flags,
+			struct dentry *old_dentry, struct qstr *new_last)
+{
+	struct dentry *trap;
+	struct dentry *d2;
+	int target_flags = LOOKUP_RENAME_TARGET | LOOKUP_CREATE;
+	int err;
+
+	if (rd->flags & RENAME_EXCHANGE)
+		target_flags = 0;
+	if (rd->flags & RENAME_NOREPLACE)
+		target_flags |= LOOKUP_EXCL;
+
+	/* Already have the dentry - need to be sure to lock the correct parent */
+	trap = lock_rename_child(old_dentry, rd->new_parent);
+	if (IS_ERR(trap))
+		return PTR_ERR(trap);
+	if (d_unhashed(old_dentry) ||
+	    (rd->old_parent && rd->old_parent != old_dentry->d_parent)) {
+		/* dentry was removed, or moved and explicit parent requested */
+		err = -EINVAL;
+		goto out_unlock;
+	}
+
+	d2 = lookup_one_qstr_excl(new_last, rd->new_parent,
+				  lookup_flags | target_flags);
+	err = PTR_ERR(d2);
+	if (IS_ERR(d2))
+		goto out_unlock;
+
+	if (old_dentry == trap) {
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
+	rd->old_dentry = dget(old_dentry);
+	rd->new_dentry = d2;
+	rd->old_parent = dget(old_dentry->d_parent);
+	return 0;
+
+out_dput_d2:
+	dput(d2);
+out_unlock:
+	unlock_rename(old_dentry->d_parent, rd->new_parent);
+	return err;
+}
+
+/**
+ * start_renaming_dentry - lookup and lock name for rename with permission checking
+ * @rd:           rename data containing parents and flags, and
+ *                for receiving found dentries
+ * @lookup_flags: extra flags to pass to ->lookup (e.g. LOOKUP_REVAL,
+ *                LOOKUP_NO_SYMLINKS etc).
+ * @old_dentry:   dentry of name to move
+ * @new_last:     name of target in @rd.new_parent
+ *
+ * Look up target name and ensure locks are in place for
+ * rename.
+ *
+ * On success the found dentry is stored in @rd.new_dentry and
+ * @rd.old_parent is confirmed to be the parent of @old_dentry.  If it
+ * was originally %NULL, it is set.  In either case a reference is taken
+ * so that end_renaming() can have a stable reference to unlock.
+ *
+ * References and the lock can be dropped with end_renaming()
+ *
+ * The passed in qstr need not have the hash calculated, and basic
+ * eXecute permission checking is performed against @rd.mnt_idmap.
+ *
+ * Returns: zero or an error.
+ */
+int start_renaming_dentry(struct renamedata *rd, int lookup_flags,
+			  struct dentry *old_dentry, struct qstr *new_last)
+{
+	int err;
+
+	err = lookup_one_common(rd->mnt_idmap, new_last, rd->new_parent);
+	if (err)
+		return err;
+	return __start_renaming_dentry(rd, lookup_flags, old_dentry, new_last);
+}
+EXPORT_SYMBOL(start_renaming_dentry);
+
 void end_renaming(struct renamedata *rd)
 {
 	unlock_rename(rd->old_parent, rd->new_parent);
 	dput(rd->old_dentry);
 	dput(rd->new_dentry);
+	dput(rd->old_parent);
 }
 EXPORT_SYMBOL(end_renaming);
 
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 7a31ca9bdea2..27014ada11c7 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -523,8 +523,8 @@ static int ovl_create_index(struct dentry *dentry, const struct ovl_fh *fh,
 {
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct dentry *indexdir = ovl_indexdir(dentry->d_sb);
-	struct dentry *index = NULL;
 	struct dentry *temp = NULL;
+	struct renamedata rd = {};
 	struct qstr name = { };
 	int err;
 
@@ -556,17 +556,15 @@ static int ovl_create_index(struct dentry *dentry, const struct ovl_fh *fh,
 	if (err)
 		goto out;
 
-	err = ovl_parent_lock(indexdir, temp);
+	rd.mnt_idmap = ovl_upper_mnt_idmap(ofs);
+	rd.old_parent = indexdir;
+	rd.new_parent = indexdir;
+	err = start_renaming_dentry(&rd, 0, temp, &name);
 	if (err)
 		goto out;
-	index = ovl_lookup_upper(ofs, name.name, indexdir, name.len);
-	if (IS_ERR(index)) {
-		err = PTR_ERR(index);
-	} else {
-		err = ovl_do_rename(ofs, indexdir, temp, indexdir, index, 0);
-		dput(index);
-	}
-	ovl_parent_unlock(indexdir);
+
+	err = ovl_do_rename_rd(&rd);
+	end_renaming(&rd);
 out:
 	if (err)
 		ovl_cleanup(ofs, indexdir, temp);
@@ -763,7 +761,8 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	struct ovl_fs *ofs = OVL_FS(c->dentry->d_sb);
 	struct inode *inode;
 	struct path path = { .mnt = ovl_upper_mnt(ofs) };
-	struct dentry *temp, *upper, *trap;
+	struct renamedata rd = {};
+	struct dentry *temp;
 	struct ovl_cu_creds cc;
 	int err;
 	struct ovl_cattr cattr = {
@@ -807,29 +806,24 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	 * ovl_copy_up_data(), so lock workdir and destdir and make sure that
 	 * temp wasn't moved before copy up completion or cleanup.
 	 */
-	trap = lock_rename(c->workdir, c->destdir);
-	if (trap || temp->d_parent != c->workdir) {
-		/* temp or workdir moved underneath us? abort without cleanup */
-		dput(temp);
+	rd.mnt_idmap = ovl_upper_mnt_idmap(ofs);
+	rd.old_parent = c->workdir;
+	rd.new_parent = c->destdir;
+	rd.flags = 0;
+	err = start_renaming_dentry(&rd, 0, temp,
+				    &QSTR_LEN(c->destname.name, c->destname.len));
+	if (err) {
+		/* temp or workdir moved underneath us? map to -EIO */
 		err = -EIO;
-		if (!IS_ERR(trap))
-			unlock_rename(c->workdir, c->destdir);
-		goto out;
 	}
-
-	err = ovl_copy_up_metadata(c, temp);
 	if (err)
-		goto cleanup;
+		goto cleanup_unlocked;
 
-	upper = ovl_lookup_upper(ofs, c->destname.name, c->destdir,
-				 c->destname.len);
-	err = PTR_ERR(upper);
-	if (IS_ERR(upper))
-		goto cleanup;
+	err = ovl_copy_up_metadata(c, temp);
+	if (!err)
+		err = ovl_do_rename_rd(&rd);
+	end_renaming(&rd);
 
-	err = ovl_do_rename(ofs, c->workdir, temp, c->destdir, upper, 0);
-	unlock_rename(c->workdir, c->destdir);
-	dput(upper);
 	if (err)
 		goto cleanup_unlocked;
 
@@ -850,8 +844,6 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 
 	return err;
 
-cleanup:
-	unlock_rename(c->workdir, c->destdir);
 cleanup_unlocked:
 	ovl_cleanup(ofs, c->workdir, temp);
 	dput(temp);
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 0f2c2da68433..2b423ebc85c4 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -57,8 +57,7 @@ int ovl_cleanup(struct ovl_fs *ofs, struct dentry *workdir,
 	return 0;
 }
 
-#define OVL_TEMPNAME_SIZE 20
-static void ovl_tempname(char name[OVL_TEMPNAME_SIZE])
+void ovl_tempname(char name[OVL_TEMPNAME_SIZE])
 {
 	static atomic_t temp_id = ATOMIC_INIT(0);
 
@@ -66,22 +65,6 @@ static void ovl_tempname(char name[OVL_TEMPNAME_SIZE])
 	snprintf(name, OVL_TEMPNAME_SIZE, "#%x", atomic_inc_return(&temp_id));
 }
 
-struct dentry *ovl_lookup_temp(struct ovl_fs *ofs, struct dentry *workdir)
-{
-	struct dentry *temp;
-	char name[OVL_TEMPNAME_SIZE];
-
-	ovl_tempname(name);
-	temp = ovl_lookup_upper(ofs, name, workdir, strlen(name));
-	if (!IS_ERR(temp) && temp->d_inode) {
-		pr_err("workdir/%s already exists\n", name);
-		dput(temp);
-		temp = ERR_PTR(-EIO);
-	}
-
-	return temp;
-}
-
 static struct dentry *ovl_start_creating_temp(struct ovl_fs *ofs,
 					      struct dentry *workdir)
 {
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 3cc85a893b5c..746bc4ad7b37 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -447,11 +447,6 @@ static inline bool ovl_open_flags_need_copy_up(int flags)
 }
 
 /* util.c */
-int ovl_parent_lock(struct dentry *parent, struct dentry *child);
-static inline void ovl_parent_unlock(struct dentry *parent)
-{
-	inode_unlock(parent->d_inode);
-}
 int ovl_get_write_access(struct dentry *dentry);
 void ovl_put_write_access(struct dentry *dentry);
 void ovl_start_write(struct dentry *dentry);
@@ -888,7 +883,8 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs,
 			       struct dentry *parent, struct dentry *newdentry,
 			       struct ovl_cattr *attr);
 int ovl_cleanup(struct ovl_fs *ofs, struct dentry *workdir, struct dentry *dentry);
-struct dentry *ovl_lookup_temp(struct ovl_fs *ofs, struct dentry *workdir);
+#define OVL_TEMPNAME_SIZE 20
+void ovl_tempname(char name[OVL_TEMPNAME_SIZE]);
 struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *workdir,
 			       struct ovl_cattr *attr);
 
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 6e0816c1147a..a721ef2b90e8 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -566,9 +566,10 @@ static int ovl_check_rename_whiteout(struct ovl_fs *ofs)
 {
 	struct dentry *workdir = ofs->workdir;
 	struct dentry *temp;
-	struct dentry *dest;
 	struct dentry *whiteout;
 	struct name_snapshot name;
+	struct renamedata rd = {};
+	char name2[OVL_TEMPNAME_SIZE];
 	int err;
 
 	temp = ovl_create_temp(ofs, workdir, OVL_CATTR(S_IFREG | 0));
@@ -576,23 +577,21 @@ static int ovl_check_rename_whiteout(struct ovl_fs *ofs)
 	if (IS_ERR(temp))
 		return err;
 
-	err = ovl_parent_lock(workdir, temp);
+	rd.mnt_idmap = ovl_upper_mnt_idmap(ofs);
+	rd.old_parent = workdir;
+	rd.new_parent = workdir;
+	rd.flags = RENAME_WHITEOUT;
+	ovl_tempname(name2);
+	err = start_renaming_dentry(&rd, 0, temp, &QSTR(name2));
 	if (err) {
 		dput(temp);
 		return err;
 	}
-	dest = ovl_lookup_temp(ofs, workdir);
-	err = PTR_ERR(dest);
-	if (IS_ERR(dest)) {
-		dput(temp);
-		ovl_parent_unlock(workdir);
-		return err;
-	}
 
 	/* Name is inline and stable - using snapshot as a copy helper */
 	take_dentry_name_snapshot(&name, temp);
-	err = ovl_do_rename(ofs, workdir, temp, workdir, dest, RENAME_WHITEOUT);
-	ovl_parent_unlock(workdir);
+	err = ovl_do_rename_rd(&rd);
+	end_renaming(&rd);
 	if (err) {
 		if (err == -EINVAL)
 			err = 0;
@@ -616,7 +615,6 @@ static int ovl_check_rename_whiteout(struct ovl_fs *ofs)
 	ovl_cleanup(ofs, workdir, temp);
 	release_dentry_name_snapshot(&name);
 	dput(temp);
-	dput(dest);
 
 	return err;
 }
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index f76672f2e686..46387aeb6be6 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1548,14 +1548,3 @@ void ovl_copyattr(struct inode *inode)
 	i_size_write(inode, i_size_read(realinode));
 	spin_unlock(&inode->i_lock);
 }
-
-int ovl_parent_lock(struct dentry *parent, struct dentry *child)
-{
-	inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
-	if (!child ||
-	    (!d_unhashed(child) && child->d_parent == parent))
-		return 0;
-
-	inode_unlock(parent->d_inode);
-	return -EINVAL;
-}
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 7c4ddc43ab39..f54b5b0aaba2 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -663,7 +663,6 @@ int ksmbd_vfs_link(struct ksmbd_work *work, const char *oldname,
 int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
 		     char *newname, int flags)
 {
-	struct dentry *old_parent, *new_dentry, *trap;
 	struct dentry *old_child = old_path->dentry;
 	struct path new_path;
 	struct qstr new_last;
@@ -673,7 +672,6 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
 	struct ksmbd_file *parent_fp;
 	int new_type;
 	int err, lookup_flags = LOOKUP_NO_SYMLINKS;
-	int target_lookup_flags = LOOKUP_RENAME_TARGET | LOOKUP_CREATE;
 
 	if (ksmbd_override_fsids(work))
 		return -ENOMEM;
@@ -684,14 +682,6 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
 		goto revert_fsids;
 	}
 
-	/*
-	 * explicitly handle file overwrite case, for compatibility with
-	 * filesystems that may not support rename flags (e.g: fuse)
-	 */
-	if (flags & RENAME_NOREPLACE)
-		target_lookup_flags |= LOOKUP_EXCL;
-	flags &= ~(RENAME_NOREPLACE);
-
 retry:
 	err = vfs_path_parent_lookup(to, lookup_flags | LOOKUP_BENEATH,
 				     &new_path, &new_last, &new_type,
@@ -708,17 +698,14 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
 	if (err)
 		goto out2;
 
-	trap = lock_rename_child(old_child, new_path.dentry);
-	if (IS_ERR(trap)) {
-		err = PTR_ERR(trap);
+	rd.mnt_idmap		= mnt_idmap(old_path->mnt);
+	rd.old_parent		= NULL;
+	rd.new_parent		= new_path.dentry;
+	rd.flags		= flags;
+	rd.delegated_inode	= NULL,
+	err = start_renaming_dentry(&rd, lookup_flags, old_child, &new_last);
+	if (err)
 		goto out_drop_write;
-	}
-
-	old_parent = dget(old_child->d_parent);
-	if (d_unhashed(old_child)) {
-		err = -EINVAL;
-		goto out3;
-	}
 
 	parent_fp = ksmbd_lookup_fd_inode(old_child->d_parent);
 	if (parent_fp) {
@@ -731,44 +718,17 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
 		ksmbd_fd_put(work, parent_fp);
 	}
 
-	new_dentry = lookup_one_qstr_excl(&new_last, new_path.dentry,
-					  lookup_flags | target_lookup_flags);
-	if (IS_ERR(new_dentry)) {
-		err = PTR_ERR(new_dentry);
-		goto out3;
-	}
-
-	if (d_is_symlink(new_dentry)) {
+	if (d_is_symlink(rd.new_dentry)) {
 		err = -EACCES;
-		goto out4;
-	}
-
-	if (old_child == trap) {
-		err = -EINVAL;
-		goto out4;
-	}
-
-	if (new_dentry == trap) {
-		err = -ENOTEMPTY;
-		goto out4;
+		goto out3;
 	}
 
-	rd.mnt_idmap		= mnt_idmap(old_path->mnt),
-	rd.old_parent		= old_parent,
-	rd.old_dentry		= old_child,
-	rd.new_parent		= new_path.dentry,
-	rd.new_dentry		= new_dentry,
-	rd.flags		= flags,
-	rd.delegated_inode	= NULL,
 	err = vfs_rename(&rd);
 	if (err)
 		ksmbd_debug(VFS, "vfs_rename failed err %d\n", err);
 
-out4:
-	dput(new_dentry);
 out3:
-	dput(old_parent);
-	unlock_rename(old_parent, new_path.dentry);
+	end_renaming(&rd);
 out_drop_write:
 	mnt_drop_write(old_path->mnt);
 out2:
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 19c3d8e336d5..f73001e3719a 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -158,6 +158,8 @@ extern struct dentry *lock_rename_child(struct dentry *, struct dentry *);
 extern void unlock_rename(struct dentry *, struct dentry *);
 int start_renaming(struct renamedata *rd, int lookup_flags,
 		   struct qstr *old_last, struct qstr *new_last);
+int start_renaming_dentry(struct renamedata *rd, int lookup_flags,
+			  struct dentry *old_dentry, struct qstr *new_last);
 void end_renaming(struct renamedata *rd);
 
 /**
-- 
2.50.0.107.gf914562f5916.dirty


