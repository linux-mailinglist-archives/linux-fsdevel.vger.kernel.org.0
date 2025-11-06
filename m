Return-Path: <linux-fsdevel+bounces-67250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22149C389E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 02:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8459A1A268D3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 00:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A9A21E08D;
	Thu,  6 Nov 2025 00:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="d91jkyPC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VQLQyARF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A928321CA0D;
	Thu,  6 Nov 2025 00:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762390610; cv=none; b=uPsxw9uKjJBSYcQp6XHUN0gaBJ971WwKEOoeAJ9Phajt+cOW6YRyr+HgDAFNMGHUBNpOMwDwlqKsuxNhUGS0esV3EtIxZoeZsJnl1s9pUT4CoB0BS6Wh3wbiNSQ4s+npmq38llMFvrzPnqDxjRKK1qnryfyHAT2imEZ/0zICvVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762390610; c=relaxed/simple;
	bh=DWvhklOWx9+UcovcigTS5fzY29Sfu8jqlcYa5xHbdRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=diUIhVCvJrO0nBsScJ/G+jUmulX94C74CQIJH5Owl2u2wDu0r3eG2gy2s5OVcvxtxKZ7J3Gp5wMR1ejjewYhsMjl7tm7YDr6ypwz4cQYzf+sUq97tx3cT4eERauEi6nuKPOKMvJ+Bb3tSKcwNnhqUEWAknxc2nd8PL633+0NTlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=d91jkyPC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VQLQyARF; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailflow.stl.internal (Postfix) with ESMTP id 34AB413005FE;
	Wed,  5 Nov 2025 19:56:45 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 05 Nov 2025 19:56:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1762390605;
	 x=1762397805; bh=UWJZZpGwHERGNgTVe5CxEVFi5CuCBzj100TTcgR3OGk=; b=
	d91jkyPCaOuqkHjyBDU5S3rmDuJ0eSd+MohQ7Rth6Dz5aJKwZI+kBFaspKvMEYCK
	dt5QV7u/7IMGxGBIGbIuSUS47qPPhJcTy4Ikx716Op45kxYlfIDyRTX1tW8E0c4P
	8JxkTYZwQkdfBzyBI5l9b6vJBLdm/WkbwVASyklMLyUqOBPgovUPxCMch/jkOJhb
	Fextbdp8eBYTo6uBRFzvQ3BsKY0ZzsYVBw+XyCaiNSCMk50BV9csaN4pmzSnuyPe
	V55HdMJp4Bl2YqB80X0Hr7Kg/HZuQAI4QMZHuigsqmLEObANnU2j/gp6rH81g0iw
	19+EnJ1HPeXyyDiEoVFczg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1762390605; x=1762397805; bh=U
	WJZZpGwHERGNgTVe5CxEVFi5CuCBzj100TTcgR3OGk=; b=VQLQyARFtKlkpofCa
	IjUNYayf0Ut0aTfI98uWqdRo4rryRS/vXBwbzNZncgQ0ApXTm3DcKwbCck/Lbv9m
	wyT0SRvinznNSr0htnzWZIb4jNrQzPZbBTDBq4TY9c04DTi+KnAfDpCZ5B8kYTny
	OoOctcLv57hqVuIhHOH/6zfPaW3KwzOzaClrlJ/S2RtfsLNF1qaCe88D3LmxaE7p
	jrLQGgbUYQOMLqtn2K3/oxt1Mw0TeRw2Bl75NN06nVGq6Fc0kwP274y+unT2brQO
	llVw+qTzw/qjcic3fQN/fHEGnwCEJZxlt6CYnd8pY1JXBjaD6yZ2sGI8D1Dm1rSW
	43B8A==
X-ME-Sender: <xms:TPILaRjwKee4rkH1xnFbbKSqy8wbODqVqZD1Xc59GaxA49SZUgQAmQ>
    <xme:TPILabwP1ysEqkZnxMllnvIETdAFBhz-wPxiBX4QLLYQBuFCft4s5u6R8OVfeDmbJ
    dgmo-g7DX6FshbE9_Of5dUB5y-O6kpJTuiDI42PQ8SI0a7oeQ>
X-ME-Received: <xmr:TPILaX48M-FUCOh5acrsN7D6vTW0AeF2ztPqwfAGDQfljxN2ibAnkgycJwp9z9rEUA4EyAFK1oe63LAQfKgL5CSWjw2XUWIpdxwk-NEzGXHC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeehgedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:TPILadeM4q5kTfmpHtgsD1yFmjh9ZPjDKp43mEbz49dc2UeGh_JnFw>
    <xmx:TPILafovEJ3lvHZhJZK2iJRHC6Ms4tO7xgQpwaR87dC74QsQ6mGu7g>
    <xmx:TPILaR0esE2wU8REYRXpztUKc6h6Z77i_ZVcYPGjKD8-K9wTbZjOHA>
    <xmx:TPILaUSMaxpiua1H3orYTIXg5OVTaZDmGyrHPKDhx80U36Cadwmg-g>
    <xmx:TfILacuVV6_Y8HBd3A2l1sMF07TQZciXbSwyO4stnfQEwei2lkf8rKcB>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 19:56:34 -0500 (EST)
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
Subject: [PATCH v5 12/14] ecryptfs: use new start_creating/start_removing APIs
Date: Thu,  6 Nov 2025 11:50:56 +1100
Message-ID: <20251106005333.956321-13-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251106005333.956321-1-neilb@ownmail.net>
References: <20251106005333.956321-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

This requires the addition of start_creating_dentry() which is given the
dentry which has already been found, and asks for it to be locked and
its parent validated.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: NeilBrown <neil@brown.name>

---
changes since v4
- two places in ecryptfs uses dget_parent(dentry->d_parent),
  thus incorrectly. getting grandparent.  Changed to
  dget_parent(dentry).
---
 fs/ecryptfs/inode.c   | 153 ++++++++++++++++++++----------------------
 fs/namei.c            |  33 +++++++++
 include/linux/namei.h |   2 +
 3 files changed, 107 insertions(+), 81 deletions(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index fc6d37419753..37d6293600c7 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -24,18 +24,26 @@
 #include <linux/unaligned.h>
 #include "ecryptfs_kernel.h"
 
-static int lock_parent(struct dentry *dentry,
-		       struct dentry **lower_dentry,
-		       struct inode **lower_dir)
+static struct dentry *ecryptfs_start_creating_dentry(struct dentry *dentry)
 {
-	struct dentry *lower_dir_dentry;
+	struct dentry *parent = dget_parent(dentry);
+	struct dentry *ret;
 
-	lower_dir_dentry = ecryptfs_dentry_to_lower(dentry->d_parent);
-	*lower_dir = d_inode(lower_dir_dentry);
-	*lower_dentry = ecryptfs_dentry_to_lower(dentry);
+	ret = start_creating_dentry(ecryptfs_dentry_to_lower(parent),
+				    ecryptfs_dentry_to_lower(dentry));
+	dput(parent);
+	return ret;
+}
 
-	inode_lock_nested(*lower_dir, I_MUTEX_PARENT);
-	return (*lower_dentry)->d_parent == lower_dir_dentry ? 0 : -EINVAL;
+static struct dentry *ecryptfs_start_removing_dentry(struct dentry *dentry)
+{
+	struct dentry *parent = dget_parent(dentry);
+	struct dentry *ret;
+
+	ret = start_removing_dentry(ecryptfs_dentry_to_lower(parent),
+				    ecryptfs_dentry_to_lower(dentry));
+	dput(parent);
+	return ret;
 }
 
 static int ecryptfs_inode_test(struct inode *inode, void *lower_inode)
@@ -141,15 +149,12 @@ static int ecryptfs_do_unlink(struct inode *dir, struct dentry *dentry,
 	struct inode *lower_dir;
 	int rc;
 
-	rc = lock_parent(dentry, &lower_dentry, &lower_dir);
-	dget(lower_dentry);	// don't even try to make the lower negative
-	if (!rc) {
-		if (d_unhashed(lower_dentry))
-			rc = -EINVAL;
-		else
-			rc = vfs_unlink(&nop_mnt_idmap, lower_dir, lower_dentry,
-					NULL);
-	}
+	lower_dentry = ecryptfs_start_removing_dentry(dentry);
+	if (IS_ERR(lower_dentry))
+		return PTR_ERR(lower_dentry);
+
+	lower_dir = lower_dentry->d_parent->d_inode;
+	rc = vfs_unlink(&nop_mnt_idmap, lower_dir, lower_dentry, NULL);
 	if (rc) {
 		printk(KERN_ERR "Error in vfs_unlink; rc = [%d]\n", rc);
 		goto out_unlock;
@@ -158,8 +163,7 @@ static int ecryptfs_do_unlink(struct inode *dir, struct dentry *dentry,
 	set_nlink(inode, ecryptfs_inode_to_lower(inode)->i_nlink);
 	inode_set_ctime_to_ts(inode, inode_get_ctime(dir));
 out_unlock:
-	dput(lower_dentry);
-	inode_unlock(lower_dir);
+	end_removing(lower_dentry);
 	if (!rc)
 		d_drop(dentry);
 	return rc;
@@ -186,10 +190,12 @@ ecryptfs_do_create(struct inode *directory_inode,
 	struct inode *lower_dir;
 	struct inode *inode;
 
-	rc = lock_parent(ecryptfs_dentry, &lower_dentry, &lower_dir);
-	if (!rc)
-		rc = vfs_create(&nop_mnt_idmap, lower_dir,
-				lower_dentry, mode, true);
+	lower_dentry = ecryptfs_start_creating_dentry(ecryptfs_dentry);
+	if (IS_ERR(lower_dentry))
+		return ERR_CAST(lower_dentry);
+	lower_dir = lower_dentry->d_parent->d_inode;
+	rc = vfs_create(&nop_mnt_idmap, lower_dir,
+			lower_dentry, mode, true);
 	if (rc) {
 		printk(KERN_ERR "%s: Failure to create dentry in lower fs; "
 		       "rc = [%d]\n", __func__, rc);
@@ -205,7 +211,7 @@ ecryptfs_do_create(struct inode *directory_inode,
 	fsstack_copy_attr_times(directory_inode, lower_dir);
 	fsstack_copy_inode_size(directory_inode, lower_dir);
 out_lock:
-	inode_unlock(lower_dir);
+	end_creating(lower_dentry, NULL);
 	return inode;
 }
 
@@ -433,10 +439,12 @@ static int ecryptfs_link(struct dentry *old_dentry, struct inode *dir,
 
 	file_size_save = i_size_read(d_inode(old_dentry));
 	lower_old_dentry = ecryptfs_dentry_to_lower(old_dentry);
-	rc = lock_parent(new_dentry, &lower_new_dentry, &lower_dir);
-	if (!rc)
-		rc = vfs_link(lower_old_dentry, &nop_mnt_idmap, lower_dir,
-			      lower_new_dentry, NULL);
+	lower_new_dentry = ecryptfs_start_creating_dentry(new_dentry);
+	if (IS_ERR(lower_new_dentry))
+		return PTR_ERR(lower_new_dentry);
+	lower_dir = lower_new_dentry->d_parent->d_inode;
+	rc = vfs_link(lower_old_dentry, &nop_mnt_idmap, lower_dir,
+		      lower_new_dentry, NULL);
 	if (rc || d_really_is_negative(lower_new_dentry))
 		goto out_lock;
 	rc = ecryptfs_interpose(lower_new_dentry, new_dentry, dir->i_sb);
@@ -448,7 +456,7 @@ static int ecryptfs_link(struct dentry *old_dentry, struct inode *dir,
 		  ecryptfs_inode_to_lower(d_inode(old_dentry))->i_nlink);
 	i_size_write(d_inode(new_dentry), file_size_save);
 out_lock:
-	inode_unlock(lower_dir);
+	end_creating(lower_new_dentry, NULL);
 	return rc;
 }
 
@@ -468,9 +476,11 @@ static int ecryptfs_symlink(struct mnt_idmap *idmap,
 	size_t encoded_symlen;
 	struct ecryptfs_mount_crypt_stat *mount_crypt_stat = NULL;
 
-	rc = lock_parent(dentry, &lower_dentry, &lower_dir);
-	if (rc)
-		goto out_lock;
+	lower_dentry = ecryptfs_start_creating_dentry(dentry);
+	if (IS_ERR(lower_dentry))
+		return PTR_ERR(lower_dentry);
+	lower_dir = lower_dentry->d_parent->d_inode;
+
 	mount_crypt_stat = &ecryptfs_superblock_to_private(
 		dir->i_sb)->mount_crypt_stat;
 	rc = ecryptfs_encrypt_and_encode_filename(&encoded_symname,
@@ -490,7 +500,7 @@ static int ecryptfs_symlink(struct mnt_idmap *idmap,
 	fsstack_copy_attr_times(dir, lower_dir);
 	fsstack_copy_inode_size(dir, lower_dir);
 out_lock:
-	inode_unlock(lower_dir);
+	end_creating(lower_dentry, NULL);
 	if (d_really_is_negative(dentry))
 		d_drop(dentry);
 	return rc;
@@ -501,12 +511,14 @@ static struct dentry *ecryptfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 {
 	int rc;
 	struct dentry *lower_dentry;
+	struct dentry *lower_dir_dentry;
 	struct inode *lower_dir;
 
-	rc = lock_parent(dentry, &lower_dentry, &lower_dir);
-	if (rc)
-		goto out;
-
+	lower_dentry = ecryptfs_start_creating_dentry(dentry);
+	if (IS_ERR(lower_dentry))
+		return lower_dentry;
+	lower_dir_dentry = dget(lower_dentry->d_parent);
+	lower_dir = lower_dir_dentry->d_inode;
 	lower_dentry = vfs_mkdir(&nop_mnt_idmap, lower_dir,
 				 lower_dentry, mode);
 	rc = PTR_ERR(lower_dentry);
@@ -522,7 +534,7 @@ static struct dentry *ecryptfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	fsstack_copy_inode_size(dir, lower_dir);
 	set_nlink(dir, lower_dir->i_nlink);
 out:
-	inode_unlock(lower_dir);
+	end_creating(lower_dentry, lower_dir_dentry);
 	if (d_really_is_negative(dentry))
 		d_drop(dentry);
 	return ERR_PTR(rc);
@@ -534,21 +546,18 @@ static int ecryptfs_rmdir(struct inode *dir, struct dentry *dentry)
 	struct inode *lower_dir;
 	int rc;
 
-	rc = lock_parent(dentry, &lower_dentry, &lower_dir);
-	dget(lower_dentry);	// don't even try to make the lower negative
-	if (!rc) {
-		if (d_unhashed(lower_dentry))
-			rc = -EINVAL;
-		else
-			rc = vfs_rmdir(&nop_mnt_idmap, lower_dir, lower_dentry);
-	}
+	lower_dentry = ecryptfs_start_removing_dentry(dentry);
+	if (IS_ERR(lower_dentry))
+		return PTR_ERR(lower_dentry);
+	lower_dir = lower_dentry->d_parent->d_inode;
+
+	rc = vfs_rmdir(&nop_mnt_idmap, lower_dir, lower_dentry);
 	if (!rc) {
 		clear_nlink(d_inode(dentry));
 		fsstack_copy_attr_times(dir, lower_dir);
 		set_nlink(dir, lower_dir->i_nlink);
 	}
-	dput(lower_dentry);
-	inode_unlock(lower_dir);
+	end_removing(lower_dentry);
 	if (!rc)
 		d_drop(dentry);
 	return rc;
@@ -562,10 +571,12 @@ ecryptfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	struct dentry *lower_dentry;
 	struct inode *lower_dir;
 
-	rc = lock_parent(dentry, &lower_dentry, &lower_dir);
-	if (!rc)
-		rc = vfs_mknod(&nop_mnt_idmap, lower_dir,
-			       lower_dentry, mode, dev);
+	lower_dentry = ecryptfs_start_creating_dentry(dentry);
+	if (IS_ERR(lower_dentry))
+		return PTR_ERR(lower_dentry);
+	lower_dir = lower_dentry->d_parent->d_inode;
+
+	rc = vfs_mknod(&nop_mnt_idmap, lower_dir, lower_dentry, mode, dev);
 	if (rc || d_really_is_negative(lower_dentry))
 		goto out;
 	rc = ecryptfs_interpose(lower_dentry, dentry, dir->i_sb);
@@ -574,7 +585,7 @@ ecryptfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	fsstack_copy_attr_times(dir, lower_dir);
 	fsstack_copy_inode_size(dir, lower_dir);
 out:
-	inode_unlock(lower_dir);
+	end_removing(lower_dentry);
 	if (d_really_is_negative(dentry))
 		d_drop(dentry);
 	return rc;
@@ -590,7 +601,6 @@ ecryptfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	struct dentry *lower_new_dentry;
 	struct dentry *lower_old_dir_dentry;
 	struct dentry *lower_new_dir_dentry;
-	struct dentry *trap;
 	struct inode *target_inode;
 	struct renamedata rd = {};
 
@@ -605,31 +615,13 @@ ecryptfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 
 	target_inode = d_inode(new_dentry);
 
-	trap = lock_rename(lower_old_dir_dentry, lower_new_dir_dentry);
-	if (IS_ERR(trap))
-		return PTR_ERR(trap);
-	dget(lower_new_dentry);
-	rc = -EINVAL;
-	if (lower_old_dentry->d_parent != lower_old_dir_dentry)
-		goto out_lock;
-	if (lower_new_dentry->d_parent != lower_new_dir_dentry)
-		goto out_lock;
-	if (d_unhashed(lower_old_dentry) || d_unhashed(lower_new_dentry))
-		goto out_lock;
-	/* source should not be ancestor of target */
-	if (trap == lower_old_dentry)
-		goto out_lock;
-	/* target should not be ancestor of source */
-	if (trap == lower_new_dentry) {
-		rc = -ENOTEMPTY;
-		goto out_lock;
-	}
+	rd.mnt_idmap  = &nop_mnt_idmap;
+	rd.old_parent = lower_old_dir_dentry;
+	rd.new_parent = lower_new_dir_dentry;
+	rc = start_renaming_two_dentries(&rd, lower_old_dentry, lower_new_dentry);
+	if (rc)
+		return rc;
 
-	rd.mnt_idmap		= &nop_mnt_idmap;
-	rd.old_parent		= lower_old_dir_dentry;
-	rd.old_dentry		= lower_old_dentry;
-	rd.new_parent		= lower_new_dir_dentry;
-	rd.new_dentry		= lower_new_dentry;
 	rc = vfs_rename(&rd);
 	if (rc)
 		goto out_lock;
@@ -640,8 +632,7 @@ ecryptfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	if (new_dir != old_dir)
 		fsstack_copy_attr_all(old_dir, d_inode(lower_old_dir_dentry));
 out_lock:
-	dput(lower_new_dentry);
-	unlock_rename(lower_old_dir_dentry, lower_new_dir_dentry);
+	end_renaming(&rd);
 	return rc;
 }
 
diff --git a/fs/namei.c b/fs/namei.c
index 7f0384ceb976..2444c7ddb926 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3397,6 +3397,39 @@ struct dentry *start_removing_noperm(struct dentry *parent,
 }
 EXPORT_SYMBOL(start_removing_noperm);
 
+/**
+ * start_creating_dentry - prepare to create a given dentry
+ * @parent: directory from which dentry should be removed
+ * @child:  the dentry to be removed
+ *
+ * A lock is taken to protect the dentry again other dirops and
+ * the validity of the dentry is checked: correct parent and still hashed.
+ *
+ * If the dentry is valid and negative a reference is taken and
+ * returned.  If not an error is returned.
+ *
+ * end_creating() should be called when creation is complete, or aborted.
+ *
+ * Returns: the valid dentry, or an error.
+ */
+struct dentry *start_creating_dentry(struct dentry *parent,
+				     struct dentry *child)
+{
+	inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
+	if (unlikely(IS_DEADDIR(parent->d_inode) ||
+		     child->d_parent != parent ||
+		     d_unhashed(child))) {
+		inode_unlock(parent->d_inode);
+		return ERR_PTR(-EINVAL);
+	}
+	if (d_is_positive(child)) {
+		inode_unlock(parent->d_inode);
+		return ERR_PTR(-EEXIST);
+	}
+	return dget(child);
+}
+EXPORT_SYMBOL(start_creating_dentry);
+
 /**
  * start_removing_dentry - prepare to remove a given dentry
  * @parent: directory from which dentry should be removed
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 9104c7104191..0e6b1b9afc26 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -101,6 +101,8 @@ struct dentry *start_removing_killable(struct mnt_idmap *idmap,
 				       struct qstr *name);
 struct dentry *start_creating_noperm(struct dentry *parent, struct qstr *name);
 struct dentry *start_removing_noperm(struct dentry *parent, struct qstr *name);
+struct dentry *start_creating_dentry(struct dentry *parent,
+				     struct dentry *child);
 struct dentry *start_removing_dentry(struct dentry *parent,
 				     struct dentry *child);
 
-- 
2.50.0.107.gf914562f5916.dirty


