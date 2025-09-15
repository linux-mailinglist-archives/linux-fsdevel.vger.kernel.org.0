Return-Path: <linux-fsdevel+bounces-61267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACE9B56E35
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 04:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 776CD3B605D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 02:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B28A220F5C;
	Mon, 15 Sep 2025 02:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="HeOlDCCw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bJVcMwJu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC972DC790
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 02:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757902568; cv=none; b=K/KBgeKlrhruPMKju6leLPhzqRaNIOFVrevpOV5rytEIjo9p/D999AM2EiYChUm5DnPn46Gr9PcBv2afxiz4vz9p1rHDgG4l+sfGFvVbGitRjwg9j/51rnQ+hE92h5T01zWw1/1nVrfEUViOfE4JG02PfgGY1TOa46CErYhLZ+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757902568; c=relaxed/simple;
	bh=DpSzX/obPWbsu4bZlWuFV5gv8R5uSAWOubaWr3KrcQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i/64xXLV16dctzd2W0v2A0u5Ouza3cXgHoHBtAEy/Gez/i3qFNiFZKWPJ8jjyaMZRaR++gchLVeiN6JBfFqYpM6TJ1mLvoWDyR3xqNw54uM4UDHuilVeGhWpw0lRNoim8FTZiMG58yrEkPEFq0D7NcY0DCbBrzuM4mGaQBWk+ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=HeOlDCCw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bJVcMwJu; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0438E7A0134;
	Sun, 14 Sep 2025 22:16:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sun, 14 Sep 2025 22:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1757902564;
	 x=1757988964; bh=P0WJFe87YMWp1kH7Wjqlsk6pPv2Fzr/HzavRdhubVM4=; b=
	HeOlDCCw1pj/uIIveACz0igrymydEv3/9NyBep1thJsldjJ4VyQowFw8PtvdFggr
	diCgVpBcurMI7hfGWo7GoykNOxtnXigrLUb87N1IO49JYlM0CA6ZQ6FBPB6lEOT4
	PHYTAwI6e4w5pnwshwGnAQ/9KxjKI+wZBkjK9Mx9HMXJsidOOpU5TQZHlqz5UrPU
	90BgiE33y7VnZMrIrRydiMTPADmjqR2EOXN9e4M4AJQwC/65n1WS2omXlIyXHhkm
	/You5s3B/fGzrKdw8USHMajOTFxwlfoK74hxtQ17B5DOt89WulwdSN4rqxyAE5VP
	yFv6SXyiJfEfw5gAnyvGhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757902564; x=1757988964; bh=P
	0WJFe87YMWp1kH7Wjqlsk6pPv2Fzr/HzavRdhubVM4=; b=bJVcMwJuGLPElIPOr
	6dNCIPM2Lhf9KSkpYpEtv5O1fTl6+mCNYukNWbIj8bw7VzXECFAZOdoLvB20zz6i
	O02TeTGKcj3ohOVRCDlpIDHnwLostRm+fUuXR0cCT4OaH+z78I39Xxb8VjRnmC0i
	C5u2AWGaM6iiV3Zt0cUsTZ3uyxKtzxK8hxoq9TwjbY9F+R3vhHjQFMwRmyawLZhu
	0W+Bw4msXTs2ws1Kx3CbceQeLmoTAckjBd6puDagFi5P4WhobzqAkm08DFalaXth
	oUXn8eWsvEbf6TigfVMIYBVi/WuSqt/q4VNMJvpisWgd1/k5n4FRbOSzNX+uQ3pe
	7+XJQ==
X-ME-Sender: <xms:5HbHaKqym0zGB_mcYgwt9IZf-DQhhUrul3DIpSNdknDl_oFRzLeu7Q>
    <xme:5HbHaABFkK_GC3bN4L1fhucesQSCBC0c9PGN_Qm5Xu9LtNhpNrfwM4vtAuk9SDHEr
    JYS5AOx9m9DJg>
X-ME-Received: <xmr:5HbHaExlOfmKwcEsjJTdrbrtyV0E54WwotjbHKoSgIps9M7GsTrtODtThGNKObbEDfRLx8GvrWkPm6j60wfKKTiECsAJchptOMDx3eOuqM1l>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefieegiecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:5HbHaF1FxuPkWOThrTmSlbfdkE6wdkHzonoq3hZnoS7389cyddqmMA>
    <xmx:5HbHaMyEKETsC4XXvTtIPlEF8Lu47n24uJyK5XH2yf2fI27kQBY1cQ>
    <xmx:5HbHaEGnVAjSE5UswxmekLT6Gz_1Ewe8WkswRMFXQDrrgYhnOYZmEw>
    <xmx:5HbHaHb8iHrgIleWioc1FkeuBUrnDxfpiI7roogeMYyeu4rdOMbRlQ>
    <xmx:5HbHaHaokR5W7R4Pv1gj9fDWRyJdKxjYus55xAiRzmtGV6pfMVu4MY8c>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Sep 2025 22:16:02 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 1/6] VFS/ovl: add lookup_one_positive_killable()
Date: Mon, 15 Sep 2025 12:13:41 +1000
Message-ID: <20250915021504.2632889-2-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250915021504.2632889-1-neilb@ownmail.net>
References: <20250915021504.2632889-1-neilb@ownmail.net>
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


