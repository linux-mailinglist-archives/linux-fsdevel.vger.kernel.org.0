Return-Path: <linux-fsdevel+bounces-60407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D7BB46925
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 07:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D0321D204E6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 05:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19F625CC58;
	Sat,  6 Sep 2025 05:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="XmHFt9EH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AO1sZRmS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297491A0711
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Sep 2025 05:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757134862; cv=none; b=hkXjBl28vx19aAmQJHnAkSKlNpmhnK9TtEQ9QcvGF5vFOUrPfIycfek+7uYFcTWW8qyyxvopcFPQoI3h/4oCk+s4vI64/8+YxVhG+aGl37D3NMLnkG+5RlFevRK0xtxMcV/y7BkD5W3wJhx92ATZITlOS87e/8JHeTyY5pXglns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757134862; c=relaxed/simple;
	bh=bFANY7iZzVTdjo07HO3ukqnQxGulw0iZ0lfUJkZpZG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bi25X47qeXp32cMS+0QLHrb37Rslc1JUOKNYIO/LfGh20K+GcrEg+a6hnNysTFiKAjqnXWRTRr0h5PSJJxhj4gXLVAYznB3+cy6Z43c7L7yUEFZQM0yZkf3GtuWjtuDlqKeSCAsV+nf8nKYjbvg6G9yWdmKL/95Y+LBfWdZoh5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=XmHFt9EH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AO1sZRmS; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 3E6FB1D003A0;
	Sat,  6 Sep 2025 01:00:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sat, 06 Sep 2025 01:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1757134859; x=
	1757221259; bh=TDTWZhl01LHCR0A5MwNBwvvFNBlZivhqgRMMxXaYBfA=; b=X
	mHFt9EHUM8LqrIBx2YSy4kY6SiN0sVJvfJCmRX1qkf0mIHjJR1Uh2Ui/N4lwj+6/
	2IZFI4nvXLezG3rwtUSEdDj/uZafR5AOM6PtP/0cVdm75V6gTk+Fo7gBXmitsI5/
	Nu203B3Yz5sQnJSkstFVf4VrIYRvhuck5atsjKH2m6kto4Uo0pbYH3q/qoJ/Olt7
	QnpLvtzsOYxP2TW89MBVqMcYdGVLzock5or1pqIpS65ADIXP92c6QOjSBPngpSmP
	hVovV5dtfSViKbSO2TWnsIJ9bHYwonWrQtburL6OvFdoiEZdq7j8RmkBnDuYoXR/
	pCU7XrW5FaEPnf8Bn+7VQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757134859; x=1757221259; bh=T
	DTWZhl01LHCR0A5MwNBwvvFNBlZivhqgRMMxXaYBfA=; b=AO1sZRmSZ4Dfu+RNI
	RhhBdjByR1nqOuvwwwNrxfZc0XIA75rnl9eu4xuX91RsDdc7QAOms/rbZvzkoeWg
	M314ElybpNnzuCUZJ1OD6rMXx71e27rPuCEpRV2OXPnC3k9RXsCSAtISzrTsqvQg
	p24bcW/maV/95f5rZ/SfmxwBzKeSrwln8zkPpFWTxoUCnR16AJGOf9t438XocHg8
	wG30QVEUV4GTFdJ0Gpsk6UWx2XFsbcZkeyuluNqme9/99N9V8irwtoNbX+oB2a6W
	MTKAc40U2KMjDFs34xgnw0ztd8ORPfJPVrj3U/wLASyY/M5zCRn5zMWhQTjAJtVL
	IalLw==
X-ME-Sender: <xms:CsC7aMIQDXJa70uyzkD3T8_nRIVlnzcKic2Q7Tq2whOEXRA-_9aICQ>
    <xme:CsC7aKG2r1EA_Hx8_bD6eyu1yPzZXkUkr9iWfMDMHTPMO9hY0zXzV9Dej6oTG3Ckz
    0R55osnf2X-Og>
X-ME-Received: <xmr:CsC7aPCpwpdqOarUMTerAI9dxkAumI8A4fvowPrVWaptOzjBt8-ctL-Q3e-sUjeIRcOZ8zLnalS6bj_frHjMy-npSq3XNx4TVj5u6AHu-cX4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdekkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheurhho
    fihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepue
    ekvdehhfegtddufffhjeehfeeiueffgeeltdeuhefhtdffteejtdejtedvjeetnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsgesoh
    ifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtph
    htthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepsghrrghunhgvrheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:CsC7aN9Vk5TqiVV4UahGNA_of3gWNXNkNjrRk9IDSrQXcjabS0ysgg>
    <xmx:CsC7aLBZYxEmazUzjDJUl7eH5QnhBB7GLLakHcjnJIuxJh99OEeUlw>
    <xmx:CsC7aCQfl14JvqfL7vqyjgUPdZ0kJ748f94CgvRU5W-psHY3vn7A_w>
    <xmx:CsC7aCu5sohFRQxotap4ONxNrX5M5loYYVoqxAaWUEH_RygHyuoX3w>
    <xmx:C8C7aNMzbB-NehAUzOIoL-gU_8wg-rKea_q5fJw6uhj6IdxcPRTmPRrt>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Sep 2025 01:00:56 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/6] VFS/ovl: add lookup_one_positive_killable()
Date: Sat,  6 Sep 2025 14:57:06 +1000
Message-ID: <20250906050015.3158851-3-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250906050015.3158851-1-neilb@ownmail.net>
References: <20250906050015.3158851-1-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

ovl wants a lookup which won't block on a fatal signal.
It currently uses down_write_killable() and then repeated
calls to lookup_one()

The lock may not be needed if the name is already in the dcache and it
aid proposed future changes if the locking is kept internal to namei.c

So this patch adds lookup_one_positive_killable() which is like
lookup_one_positive() but will abort in the face of a fatal signal.
overlayfs is changed to use this.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c             | 54 ++++++++++++++++++++++++++++++++++++++++++
 fs/overlayfs/readdir.c | 28 +++++++++++-----------
 include/linux/namei.h  |  3 +++
 3 files changed, 71 insertions(+), 14 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index cd43ff89fbaa..b1bc298b9d7c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1827,6 +1827,19 @@ static struct dentry *lookup_slow(const struct qstr *name,
 	return res;
 }
 
+static struct dentry *lookup_slow_killable(const struct qstr *name,
+					   struct dentry *dir,
+					   unsigned int flags)
+{
+	struct inode *inode = dir->d_inode;
+	struct dentry *res;
+	if (inode_lock_shared_killable(inode))
+		return ERR_PTR(-EINTR);
+	res = __lookup_slow(name, dir, flags);
+	inode_unlock_shared(inode);
+	return res;
+}
+
 static inline int may_lookup(struct mnt_idmap *idmap,
 			     struct nameidata *restrict nd)
 {
@@ -3010,6 +3023,47 @@ struct dentry *lookup_one_unlocked(struct mnt_idmap *idmap, struct qstr *name,
 }
 EXPORT_SYMBOL(lookup_one_unlocked);
 
+/**
+ * lookup_one_positive_killable - lookup single pathname component
+ * @idmap:	idmap of the mount the lookup is performed from
+ * @name:	qstr olding pathname component to lookup
+ * @base:	base directory to lookup from
+ *
+ * This helper will yield ERR_PTR(-ENOENT) on negatives. The helper returns
+ * known positive or ERR_PTR(). This is what most of the users want.
+ *
+ * Note that pinned negative with unlocked parent _can_ become positive at any
+ * time, so callers of lookup_one_unlocked() need to be very careful; pinned
+ * positives have >d_inode stable, so this one avoids such problems.
+ *
+ * This can be used for in-kernel filesystem clients such as file servers.
+ *
+ * Ut should be called without the parent i_rwsem held, and will take
+ * the i_rwsem itself if necessary.  If a fatal signal is pending or
+ * delivered, it will return %-EINTR.
+ */
+struct dentry *lookup_one_positive_killable(struct mnt_idmap *idmap,
+					    struct qstr *name,
+					    struct dentry *base)
+{
+	int err;
+	struct dentry *ret;
+
+	err = lookup_one_common(idmap, name, base);
+	if (err)
+		return ERR_PTR(err);
+
+	ret = lookup_dcache(name, base, 0);
+	if (!ret)
+		ret = lookup_slow_killable(name, base, 0);
+	if (!IS_ERR(ret) && d_flags_negative(smp_load_acquire(&ret->d_flags))) {
+		dput(ret);
+		ret = ERR_PTR(-ENOENT);
+	}
+	return ret;
+}
+EXPORT_SYMBOL(lookup_one_positive_killable);
+
 /**
  * lookup_one_positive_unlocked - lookup single pathname component
  * @idmap:	idmap of the mount the lookup is performed from
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index b65cdfce31ce..15cb06fa0c9a 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -270,26 +270,26 @@ static bool ovl_fill_merge(struct dir_context *ctx, const char *name,
 
 static int ovl_check_whiteouts(const struct path *path, struct ovl_readdir_data *rdd)
 {
-	int err;
+	int err = 0;
 	struct dentry *dentry, *dir = path->dentry;
 	const struct cred *old_cred;
 
 	old_cred = ovl_override_creds(rdd->dentry->d_sb);
 
-	err = down_write_killable(&dir->d_inode->i_rwsem);
-	if (!err) {
-		while (rdd->first_maybe_whiteout) {
-			struct ovl_cache_entry *p =
-				rdd->first_maybe_whiteout;
-			rdd->first_maybe_whiteout = p->next_maybe_whiteout;
-			dentry = lookup_one(mnt_idmap(path->mnt),
-					    &QSTR_LEN(p->name, p->len), dir);
-			if (!IS_ERR(dentry)) {
-				p->is_whiteout = ovl_is_whiteout(dentry);
-				dput(dentry);
-			}
+	while (rdd->first_maybe_whiteout) {
+		struct ovl_cache_entry *p =
+			rdd->first_maybe_whiteout;
+		rdd->first_maybe_whiteout = p->next_maybe_whiteout;
+		dentry = lookup_one_positive_killable(mnt_idmap(path->mnt),
+						      &QSTR_LEN(p->name, p->len),
+						      dir);
+		if (!IS_ERR(dentry)) {
+			p->is_whiteout = ovl_is_whiteout(dentry);
+			dput(dentry);
+		} else if (PTR_ERR(dentry) == -EINTR) {
+			err = -EINTR;
+			break;
 		}
-		inode_unlock(dir->d_inode);
 	}
 	ovl_revert_creds(old_cred);
 
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 5d085428e471..551a1a01e5e7 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -80,6 +80,9 @@ struct dentry *lookup_one_unlocked(struct mnt_idmap *idmap,
 struct dentry *lookup_one_positive_unlocked(struct mnt_idmap *idmap,
 					    struct qstr *name,
 					    struct dentry *base);
+struct dentry *lookup_one_positive_killable(struct mnt_idmap *idmap,
+					    struct qstr *name,
+					    struct dentry *base);
 
 extern int follow_down_one(struct path *);
 extern int follow_down(struct path *path, unsigned int flags);
-- 
2.50.0.107.gf914562f5916.dirty


