Return-Path: <linux-fsdevel+bounces-62849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7B0BA2407
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 04:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7965B385CA9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 02:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428EA1FCFEF;
	Fri, 26 Sep 2025 02:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="BdVsN/Q1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ohnmpe6z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4861EB9E1
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 02:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758855082; cv=none; b=tToXcBNJlfhbkv98dcLOKmmT8arYUz0+Vxo/UZDxYNXDnDMSmXXtyLyIhinWmKMudseTV0PAB5I6fZNv75apTGjytEGw81X0PvzAeBtpeCk/ypdGoS3XCv9AB9mm9aeACeq33eu8XMhnNi+cJMLogSgp0i6Mttw4TqDWYBZ3re4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758855082; c=relaxed/simple;
	bh=DrWgMT0yHvuUGV1jXUjj8lGm226bGy2AXXR6MUPZiWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BMGP92Gc0V0LlZmf67sxH8Yq1Upc7Yzf3pL93SinIxK5XB+f0abWiAfWWFCV9abNjGeWSGD0z8IV2x3OaEqzMRY/zl6OaV7TIb0/M5/weH2LeJejhDFV/ZGDuIAlzG/7TUG06qYALpVZN8KFx4GTV28ez6MrfIcbIwnsTXLs7dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=BdVsN/Q1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ohnmpe6z; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9BA931400040;
	Thu, 25 Sep 2025 22:51:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 25 Sep 2025 22:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1758855079;
	 x=1758941479; bh=XRCtpsZVqyTHYwZAxZIsQh/VJWkjEnq0XAvEosHEW20=; b=
	BdVsN/Q16ec4Ff5qrVgNAyKGuk5YtEIsnHchAGy7G/Rrs1u0Qrfjf4qdp0+Zh/Zx
	GF1y3e1Bd4B/OKXBfeTC5mnnWeS2MQ4kawQkoz9TF/fNqUJWh8REBwncytK26FZU
	53I84XIsmjzY3ST+nza3lJ190r1DELbolHJOaOIXhCHG9nfnsAVbLQS86fR2Ya6D
	mSV3tFt21Hp+DegTFBhRY4iBq5OualpZ0vszneqp16JRpRiOKakLzHttDytiruwR
	RM9ods9lkKiYh7+h4t0a62eT/cn+Xp++dJ9B4RAkmtPJJFfuAYNU7FmAJz/EOuqX
	3TQbpTPn1E0pYw5C8ot5Xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758855079; x=1758941479; bh=X
	RCtpsZVqyTHYwZAxZIsQh/VJWkjEnq0XAvEosHEW20=; b=Ohnmpe6zmVGUABwFP
	MXGia91tz4Y4TB7psMCIzt5krlcAq1DWsMqBKWslus5FCnTGNh6fExPeFRVz2hZG
	O39F7mahcnUQF6FvHHbySTw277X/3fMumW78o7dcnPx1wjXRPtyehUTqAinnpv6o
	cU+eMcPuaBMRjZpRMq8uZ0oLCZI/0cGbi2ntwHilBN+8LwNZBx3oN67AyzkGjIV7
	KM1PfrmqtWQ4iWGZCl7JTtgohkLcLAJei52IWwiEY5U+P777Lmc6FfgeIS+KLydd
	hlFuw7T0EPcv7+d3J7K2UiMTKJw3zrFbAtff1BTpjDEQMyFYC0DKlGDCPPBN/kdP
	s0JXw==
X-ME-Sender: <xms:p__VaMwjZz03z3QNDP7sMOx_b9HP-357jDju_LIuA2NilpSeFWDt2A>
    <xme:p__VaLOkU0ZyiJ5H11iMZjW3rJXbwVfXLJH_FjShyYqLqIjgYCRft9P9Y3OVvrb1_
    woACxnXvb6gPKnFI2OckUzINoIbcssTCkAyfL6RLAdwE9OoPA>
X-ME-Received: <xmr:p__VaNVoojQadBA69iLwRhSmJ2GVL2vHWtY8Hw-YSXL4CfPjsayea40NdUM8XMFf7d9W_lGUDOUc0GAZuJV2Xr-aWsLn5GqNjvn_8vL-gkBM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeikedvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfrhgggfestdekredtredttdenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    evveekffduueevhfeigefhgfdukedtleekjeeitdejudfgueekvdekffdvfedvudenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:p__VaP0EgKwfbm5B677Pn6bX1oBdC4azFRzwOcpGGzRi-X-0pKRZRw>
    <xmx:p__VaLpJfWEyopfe0sq8NfaYlsWlU3wyzVfgBj-sEs6BLCw-0U-oJA>
    <xmx:p__VaGXuvOS1oPfV4KGUVrSgK9UL0vlt_edH3GboKXtyiWIvOA0sLw>
    <xmx:p__VaGYTccXsjz_lNT7ejCprFQ1PnT-VClpInsDYWhIRR9YwiEwJ2g>
    <xmx:p__VaLIgZqM6_BKrDKVuoKs_kLNjRUNjcDNFbP3a8t9MlbLINFG51lUL>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 22:51:17 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/11] ecryptfs: use new start_creaing/start_removing APIs
Date: Fri, 26 Sep 2025 12:49:15 +1000
Message-ID: <20250926025015.1747294-12-neilb@ownmail.net>
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

This requires the addition of start_creating_dentry().

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/ecryptfs/inode.c   | 153 ++++++++++++++++++++----------------------
 fs/namei.c            |  41 ++++++++++-
 include/linux/namei.h |   2 +
 3 files changed, 113 insertions(+), 83 deletions(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index abd954c6a14e..25ef6ea8b150 100644
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
+	struct dentry *parent = dget_parent(dentry->d_parent);
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
+	struct dentry *parent = dget_parent(dentry->d_parent);
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
 
@@ -442,10 +448,12 @@ static int ecryptfs_link(struct dentry *old_dentry, struct inode *dir,
 
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
@@ -457,7 +465,7 @@ static int ecryptfs_link(struct dentry *old_dentry, struct inode *dir,
 		  ecryptfs_inode_to_lower(d_inode(old_dentry))->i_nlink);
 	i_size_write(d_inode(new_dentry), file_size_save);
 out_lock:
-	inode_unlock(lower_dir);
+	end_creating(lower_new_dentry, NULL);
 	return rc;
 }
 
@@ -477,9 +485,11 @@ static int ecryptfs_symlink(struct mnt_idmap *idmap,
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
@@ -499,7 +509,7 @@ static int ecryptfs_symlink(struct mnt_idmap *idmap,
 	fsstack_copy_attr_times(dir, lower_dir);
 	fsstack_copy_inode_size(dir, lower_dir);
 out_lock:
-	inode_unlock(lower_dir);
+	end_creating(lower_dentry, NULL);
 	if (d_really_is_negative(dentry))
 		d_drop(dentry);
 	return rc;
@@ -510,12 +520,14 @@ static struct dentry *ecryptfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
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
@@ -531,7 +543,7 @@ static struct dentry *ecryptfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	fsstack_copy_inode_size(dir, lower_dir);
 	set_nlink(dir, lower_dir->i_nlink);
 out:
-	inode_unlock(lower_dir);
+	end_creating(lower_dentry, lower_dir_dentry);
 	if (d_really_is_negative(dentry))
 		d_drop(dentry);
 	return ERR_PTR(rc);
@@ -543,21 +555,18 @@ static int ecryptfs_rmdir(struct inode *dir, struct dentry *dentry)
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
@@ -571,10 +580,12 @@ ecryptfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
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
@@ -583,7 +594,7 @@ ecryptfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	fsstack_copy_attr_times(dir, lower_dir);
 	fsstack_copy_inode_size(dir, lower_dir);
 out:
-	inode_unlock(lower_dir);
+	end_removing(lower_dentry);
 	if (d_really_is_negative(dentry))
 		d_drop(dentry);
 	return rc;
@@ -599,7 +610,6 @@ ecryptfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	struct dentry *lower_new_dentry;
 	struct dentry *lower_old_dir_dentry;
 	struct dentry *lower_new_dir_dentry;
-	struct dentry *trap;
 	struct inode *target_inode;
 	struct renamedata rd = {};
 
@@ -614,31 +624,13 @@ ecryptfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 
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
+	rc = start_renaming_two_dentry(&rd, lower_old_dentry, lower_new_dentry);
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
@@ -649,8 +641,7 @@ ecryptfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	if (new_dir != old_dir)
 		fsstack_copy_attr_all(old_dir, d_inode(lower_old_dir_dentry));
 out_lock:
-	dput(lower_new_dentry);
-	unlock_rename(lower_old_dir_dentry, lower_new_dir_dentry);
+	end_renaming(&rd);
 	return rc;
 }
 
diff --git a/fs/namei.c b/fs/namei.c
index 23f9adb43401..80a687a95da0 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3418,6 +3418,39 @@ struct dentry *start_removing_noperm(struct dentry *parent,
 }
 EXPORT_SYMBOL(start_removing_noperm);
 
+/**
+ * start_creating_dentry - prepare to create a given dentry
+ * @parent - directory from which dentry should be removed
+ * @child - the dentry to be removed
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
  * @parent - directory from which dentry should be removed
@@ -3426,8 +3459,8 @@ EXPORT_SYMBOL(start_removing_noperm);
  * A lock is taken to protect the dentry again other dirops and
  * the validity of the dentry is checked: correct parent and still hashed.
  *
- * If the dentry is valid a reference is taken and returned.  If not
- * an error is returned.
+ * If the dentry is valid and positive a reference is taken and
+ * returned.  If not an error is returned.
  *
  * end_removing() should be called when removal is complete, or aborted.
  *
@@ -3443,6 +3476,10 @@ struct dentry *start_removing_dentry(struct dentry *parent,
 		inode_unlock(parent->d_inode);
 		return ERR_PTR(-EINVAL);
 	}
+	if (d_is_negative(child)) {
+		inode_unlock(parent->d_inode);
+		return ERR_PTR(-ENOENT);
+	}
 	return dget(child);
 }
 EXPORT_SYMBOL(start_removing_dentry);
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 434b10476e40..7ed299567da8 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -100,6 +100,8 @@ struct dentry *start_removing_killable(struct mnt_idmap *idmap,
 				       struct qstr *name);
 struct dentry *start_creating_noperm(struct dentry *parent, struct qstr *name);
 struct dentry *start_removing_noperm(struct dentry *parent, struct qstr *name);
+struct dentry *start_creating_dentry(struct dentry *parent,
+				     struct dentry *child);
 struct dentry *start_removing_dentry(struct dentry *parent,
 				     struct dentry *child);
 
-- 
2.50.0.107.gf914562f5916.dirty


