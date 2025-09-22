Return-Path: <linux-fsdevel+bounces-62358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A879EB8EF07
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 06:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AC213BC1EC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 04:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74189217733;
	Mon, 22 Sep 2025 04:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="ShU1d53a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Oo+r231t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ED2207A0C
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 04:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758515606; cv=none; b=fKdgp0lSQvQo4Li6LD79LfLgMxjUJ7MO4MXoI/nKD4iexXJDJCHy1EJ0dGDYFn4479AVKZO5Kjq8wh1zCUYrV18Il9hBmNvZXrbin9GSv7a/ZCE1lTsQpIXlGZG/3g3RbqhNaQfONx93ly46kyuVzcLpfFRFBfSv0ugOWDrBsRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758515606; c=relaxed/simple;
	bh=DpSzX/obPWbsu4bZlWuFV5gv8R5uSAWOubaWr3KrcQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DuS+0kCp2GEWMSZgsGt3K/IZqvaWqEAZtaw623VfMPRoIjI9po3px0IGLh4XkngCbWYzLDfsTP/8AeKuzGHX4GjO4gHZhNRXmbivVrwUpkwnjHO2V8rNrO6L7FhGoHNDo9w4rWOjOwrZFzJoqIAXOdO92ZPtKKJc1iBbnDY1nxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=ShU1d53a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Oo+r231t; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 0ED6CEC0109;
	Mon, 22 Sep 2025 00:33:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 22 Sep 2025 00:33:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1758515604;
	 x=1758602004; bh=P0WJFe87YMWp1kH7Wjqlsk6pPv2Fzr/HzavRdhubVM4=; b=
	ShU1d53aglPb/bovFOFh47lBnRg+VXjwfOjF+S6ykpq5MvXns+q5W/AMJIWblgBe
	tJmucolxpUp6rTCJ2CnGjZRXisDcbt79t/6HtfD3eh+dRLSFbS5UpPAOhrXTgXeY
	mm1/4JSdN+jZWVKKJS6SumbE9F7JvOiXuVzaqpOi9XT9u3HszbylHNbYLQSICMJl
	7cweL3VJZNVvCJB37dII+iFnHPpt1LWBQ9aImMbNR/ABMr1G0Avm58C2SiHigjwr
	AAc6e0Nkf1SlqF0wRCdiQjBvQXUTh2ckdZeBw9J4kv3l24UA4VQXq5sa+GvLlTqj
	fpGQaUaljwLxD9BGsBl4kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758515604; x=1758602004; bh=P
	0WJFe87YMWp1kH7Wjqlsk6pPv2Fzr/HzavRdhubVM4=; b=Oo+r231tlGVixKWB3
	gkOtU8ViRgAlrKCK52qxSPRRGblPN0AcPvJFWBtNWHCm1SCZW0xdMyWtzUEy1hwp
	0ii2L+/6WQ0Ax+sTB+sPLwL7zdWOVv1tPxIA9VTKOKUiDVuYhoclKtCxMMnSSw1f
	hJY8l4v5DqAADg6sMoWzYzCCzEN7jybyRW5RIz4S4wccH4hCNAn0DY4BXmq6eSJ4
	/g1e98nE79l9CzJUpN8vu4dNerSwo+vCPlkbwAjotQbuHfM7PCv1A+V3rUwjdhBj
	wCtgsOyELrzBGW4iAQo1nSnwYBnBG/EM1SQ7m4oly/kF58mSOzuYmD4CyKMe9ME9
	EAL8Q==
X-ME-Sender: <xms:k9HQaGrhf1swceFx2vg-0MVommbO_wBgB66lqq5gRd2mQSerhdlMAw>
    <xme:k9HQaMCsuKGblvnbpMCBa33HtxSSGO9dmBFLQVwYhb6864OAOS6Vb3yfrqENgrvHU
    YzHWLnjZycC3g>
X-ME-Received: <xmr:k9HQaAwSpIb4uwiDgqe2twz1uRpgfSFTY3eg5kzki2QqD2y2v2P54M7DPuQ7UgmEBjYT8HnO5kLYxppRTSoRJTR_HhdfnrUFHnEeRVEIIfoU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehieeltdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:k9HQaB1TZrLzCgT7g0Ou8ZvAUMJA9MzKLQLC48ZWxj7dq_4R46qkwg>
    <xmx:k9HQaIzfqDc4AIUu9Nx7b1QO0VjxxDrvQ62kkgyKroR_ob_JlUc6Lg>
    <xmx:k9HQaAHLgzBKZAhskX1jk8vvfhtF--C858xzMGzsGaayyr9yY2q8uw>
    <xmx:k9HQaDa1uWUE_Ihf5AdMVUEuAg-gchrwqFfDEOxQyye33bVZqW8u8g>
    <xmx:lNHQaJAh3W_5wEC5oQIBJGeJZtndXThkCjY3NE7xcb9MX44AjvDXuQLS>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 00:33:21 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 1/6] VFS/ovl: add lookup_one_positive_killable()
Date: Mon, 22 Sep 2025 14:29:48 +1000
Message-ID: <20250922043121.193821-2-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250922043121.193821-1-neilb@ownmail.net>
References: <20250922043121.193821-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
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

Note that the linked list ->first_maybe_whiteout ->next_maybe_white is
local to the thread so there is no concurrency in that list which could
be threatened by removing the locking.

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


