Return-Path: <linux-fsdevel+bounces-60610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2867B4A0E0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 06:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7C114E1AA2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 04:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A8D2D8792;
	Tue,  9 Sep 2025 04:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="gde5pJ2p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e5eWPtCZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C76C2D94B8
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Sep 2025 04:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757393312; cv=none; b=CKgISF0oKw7msu1qIYBw8baLqSyRzdztIvIAroh6XpsrJX/+X5mx3Y6bzps8ANOWfyxlELwhfWfAwBBKX+LxOwlLTpp07cP9QfUFby4PxTqQE2LjIz6nUXVuq0EmMVMcLI2HkEW1Rd2RQblkhmza0TU2cqJl/c79Nedzso7oewc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757393312; c=relaxed/simple;
	bh=pwbsiBn91p9XLZ+JAnskwjfCbIoJevSj/v+jHcN6nQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YOGM1f8j2gzz+2wyHq1e+c8D5ch1scsJvyY45ylo/XxaO4uFp8jRGEvsCb/BD1jBurzW+9OH+NdNGHuJu2Wp+6+Z0J7xHi4yR1FqZ7zJu7X33FELtUanhkRkXzUwwooq5/Tj4VUCKLhsIyRCldaEdnYpT68gs3v7GzRdnGyaFHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=gde5pJ2p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e5eWPtCZ; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 276821D0004F;
	Tue,  9 Sep 2025 00:48:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 09 Sep 2025 00:48:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1757393309;
	 x=1757479709; bh=SB0JI5paEbTcijQZ2wIlNpxRYYKjDUBpiMdgBv80M2Q=; b=
	gde5pJ2pxk11oZ5t1Yv69R1bxxmGFv/8xn+lwYdk21oN+uIEPu0lIViq/Vnc/EJl
	m8CAbKojv5uR5l3aJN3BR9DSHhZSE0lNJuFsEvpn5WbtrvwthvQLncwkXVzanS6t
	8T+5igFgoOWtLwtvQytB552EekYCpwJu723UwtQ1Vta88/29xtRCuJ0qic+f68mA
	oCGSc5daV505nT0UjtyDqSE/XT+TK2XQx1UxkonbuQawL7lgFGJNpjntiEaHsZi4
	sXqfsyVmevyKkAloZmrEnRhbe2OZkl1IBCYfLgtgRun3TRyK19+aKDOU0zkOfvXV
	3Z7Nq0+owAA3E4SG0AIX9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757393309; x=1757479709; bh=S
	B0JI5paEbTcijQZ2wIlNpxRYYKjDUBpiMdgBv80M2Q=; b=e5eWPtCZnYuleXS4C
	0IVpA/XkSDIM0vcEDmQSy73oR02/tyFxjg5bASFuJMTR5P91oI66gBi6+CSMkD4P
	kfZJQzl0NDem1qEwoBa/sPJkJ68JGbRTA82EfFTTISowKGaUN6C8UqA2Yl3ozbxM
	rHqOnuHXpufQIBdv1NRJarqgmb5R/vFQw7M2D2bUlKdE6JsXlxbLbOVA5HnR1aCM
	CgpvrpGjVUpCsXugiiwAZtIWv6Cb/xDvDP9sZ4ji26AtBjnV5eWLx+UmOm6LDLDU
	cMiNwY37Zs5eV01TV29ZKAYXD4olwfr5laxMa2qGieJDjyuMxaWutxji3wIEusQ6
	JzjPg==
X-ME-Sender: <xms:nLG_aHWOyztMCdhk7XnZwQFvku8HViej-enAJjKLn7LVcbPdIVhQ6A>
    <xme:nLG_aG88jS8gkStZNBXzri6H0nTvEMpkVQLLIakN1RmOuLsEBOmBWqDsJxuD4tLAr
    Ga5Fat3qimENQ>
X-ME-Received: <xmr:nLG_aI95kBoC3NQi3JcEcOCb7Df0kFSiBiZ7W_10qRgXgrSMrYqC4WpxMCrpRz435FqD37YGECHfaSfwfx3gYjsLo8lRxFXS3wN0_m0leMIj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleeglecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:nLG_aOQX0hkBkOJ5xe38TU6ZtXdeTZ8FZcCJfNnN0ZfTXuQpLt6dQQ>
    <xmx:nLG_aEdyygwg6OCDK9UDOgDZA6NFDDp1wuc1MZJzGUAW3g4j_nv2YQ>
    <xmx:nLG_aKBGB4jf5TA6h-XccrCOWEbyELUSPKD1w998K9M9ol5KOW_Kvg>
    <xmx:nLG_aOkxWqJIfkN-epnDTsZ-VdDbqgaoA2fPqCLqT8fFosWzSR2L8g>
    <xmx:nLG_aCMy-1vaDwnUudAx-aUyrh4MozsG3JOXr9Q3xVHBpkw0juoYN0ma>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 00:48:26 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/7] VFS/ovl: add lookup_one_positive_killable()
Date: Tue,  9 Sep 2025 14:43:15 +1000
Message-ID: <20250909044637.705116-2-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250909044637.705116-1-neilb@ownmail.net>
References: <20250909044637.705116-1-neilb@ownmail.net>
Reply-To: neil@brown.name
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

ovl wants a lookup which won't block on a fatal signal.  It currently
uses down_write_killable() and then repeatedly calls to lookup_one()

The lock may not be needed if the name is already in the dcache and it
aids proposed future changes if the locking is kept internal to namei.c

So this patch adds lookup_one_positive_killable() which is like
lookup_one_positive() but will abort in the face of a fatal signal.
overlayfs is changed to use this.

Note that instead of always getting an exclusive lock, ovl now only gets
a shared lock, and only sometimes.  The exclusive lock was never needed.

However down_read_killable() was only added in v4.15 but overlayfs started
using down_write_killable() here in v4.7.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c             | 55 ++++++++++++++++++++++++++++++++++++++++++
 fs/overlayfs/readdir.c | 28 ++++++++++-----------
 include/linux/namei.h  |  3 +++
 3 files changed, 72 insertions(+), 14 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index cd43ff89fbaa..c7c6b255db2c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1827,6 +1827,20 @@ static struct dentry *lookup_slow(const struct qstr *name,
 	return res;
 }
 
+static struct dentry *lookup_slow_killable(const struct qstr *name,
+					   struct dentry *dir,
+					   unsigned int flags)
+{
+	struct inode *inode = dir->d_inode;
+	struct dentry *res;
+
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
@@ -3010,6 +3024,47 @@ struct dentry *lookup_one_unlocked(struct mnt_idmap *idmap, struct qstr *name,
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
+ * It should be called without the parent i_rwsem held, and will take
+ * the i_rwsem itself if necessary.  If a fatal signal is pending or
+ * delivered, it will return %-EINTR if the lock is needed.
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


