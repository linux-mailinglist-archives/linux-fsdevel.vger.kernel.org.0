Return-Path: <linux-fsdevel+bounces-65046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96329BFA012
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 06:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE9E219C9EFC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 04:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B323E223710;
	Wed, 22 Oct 2025 04:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="IVxtoee/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RPk3nfNU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211232D9499
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 04:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761108502; cv=none; b=LVI0uJJfkp+QX0dwAUyNa/oc1umOz4r8O9E03781SrMRu9gTM80KeMW/tHIs34IripL2XCr1w5Vv12WsFnxBAN/Txln8gUbToR6sZ2pBzoMHnPLBh508aQgmomaLFBEQxPOCLzdAKJUsVUGi3KCmye+X9X9mRs1Twe4qm6HDh2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761108502; c=relaxed/simple;
	bh=ZbD4ioIxDtQxwuEq9lC+IyrONonJ0FDs07A9+2bz4u8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fYyCb7j4ljy3YIXwvlamV0bX7spP41alsnTvJKpvrpPsRShVIaK4VxpcOfAl+WQoo0MUcJs+5GCpKzMCwgLRO8PB26TOW17U6EzidkmQf91uxZmI4ljdm2dyCnV0/mKxvxggfU0PJQ/ntq/jJmTosdWEqD7QefCz2wPiJvjZjWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=IVxtoee/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RPk3nfNU; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3AE191400140;
	Wed, 22 Oct 2025 00:48:20 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 22 Oct 2025 00:48:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1761108500;
	 x=1761194900; bh=jh/P+P77MQ5fOG8YBpJDILnYShXTl7xDGrOardw8aCk=; b=
	IVxtoee/SYKv/cznTKDRH5K1wNtCOe/zcoXe8RRfKCKZysbn91QVXZlAYLa4d+4S
	SXPkEjWA9NIS4kRUAfFs99glmlPsxk2HfjNDHnJEAH/YXcL7zakjzoOPy0yT/L2N
	DbNWgBzreLGvHbWAtwjnjUZttPMlPxyTnHsbgkzRp+n1JNZsdOAPyqY0LL7Pd2lY
	twaiWeAESHyvd3VcQ0oZjvjTYF98++Cy8XkNLK1no+8EknblSRYjvl/8EmQrCIB/
	uPele450svIy9amNMCvDbp78AgD/U8qPGRmFsx8OkVMhNGVqV7MIf9XGKWAzWpfS
	cGWsT8f8dr9cBB4/ACDLoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1761108500; x=1761194900; bh=j
	h/P+P77MQ5fOG8YBpJDILnYShXTl7xDGrOardw8aCk=; b=RPk3nfNUxzbfnfL/h
	HYh4MBhxzjETrHxD+Y94NfCeeaXaw+iE6JYbnHpz1pwuF9C6f2S7tjzi/GUBe91f
	6CCYxq/QJjNXOx7XzJ/td/9kBm9juVIly1qs+nO8kkInt0cb/036DBFLiyO8YR68
	9p1YLL1s2Fks3M92wtlKyhBX8uBEGvlWmfakcEWcmpaNRThaSYEIfQU0YULadTzb
	wnWhDMRksUkR0tHqAFnbTEww2B8u+Be+dHXPiuTqqvmfQNd3dapkFlmK8d7ngRNI
	p/kuC3KwKGi4G2IrouV8TfKGo1bAOqLLRa3Fv9JML4H6w1P1oI0GoJ/O5y6aHKUK
	UewRg==
X-ME-Sender: <xms:E2L4aFReOrSQJdLPT2YO0-Saigut_RfsfYpOYrAjrl3DL0NANCdLGw>
    <xme:E2L4aJvAOYp_hTemLJLcwy5xBNZBfO9A9P6R-qWPH6rV6inJ1Dhbz4rRYCsmyxQGA
    YBTMhCBnUx4nVsO7aM1onhtWI8GzMKLRGr-HS-eI1-JltcT>
X-ME-Received: <xmr:E2L4aJ26jsSDFDBRGMNEwCrCOc1CJe-_JaEW0EXfmA-fG-jwfvDZvrrmwbGfo-lRGMb75K3GNb8deXib7ZJzPCvmRmB0humGtRi68hUcJPnd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedvieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprh
    gtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepjhhlrgihthhonh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:E2L4aCWH-BkvHuJGpGp0D7pUqpFzIkkbcyG5R9_0mziS8p97T2QEpA>
    <xmx:E2L4aMKknO_5r5y1JGHmxnzOgQpbNcXf2L_-6uCyxAjuTnsvjzUbnw>
    <xmx:E2L4aM3gP28UUorODn5564HMF60r--VAGyltF_qTfmELsLRXnj6-Hw>
    <xmx:E2L4aK652ww3tW2_tvPHvAj3whGVlJs4Pjm1f6tNbqgHxWvoCx3slg>
    <xmx:FGL4aPoTEmI5wnsvRP6r3Oc-Jf07S4dBxZZPHPyBABtGQicO8_yT9QBx>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 00:48:17 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 14/14] VFS: introduce end_creating_keep()
Date: Wed, 22 Oct 2025 15:41:48 +1100
Message-ID: <20251022044545.893630-15-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251022044545.893630-1-neilb@ownmail.net>
References: <20251022044545.893630-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

Occasionally the caller of end_creating() wants to keep using the dentry.
Rather then requiring them to dget() the dentry (when not an error)
before calling end_creating(), provide end_creating_keep() which does
this.

cachefiles and overlayfs make use of this.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/cachefiles/namei.c |  3 +--
 fs/overlayfs/dir.c    |  8 ++------
 fs/overlayfs/super.c  | 11 +++--------
 include/linux/namei.h | 22 ++++++++++++++++++++++
 4 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index c417ba4bcec3..4c72af174540 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -155,8 +155,7 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 
 	/* Tell rmdir() it's not allowed to delete the subdir */
 	inode_lock(d_inode(subdir));
-	dget(subdir);
-	end_creating(subdir);
+	end_creating_keep(subdir);
 
 	if (!__cachefiles_mark_inode_in_use(NULL, d_inode(subdir))) {
 		pr_notice("cachefiles: Inode already in use: %pd (B=%lx)\n",
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 1d52cbb2f0fb..1ff87e12c386 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -251,10 +251,7 @@ struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *workdir,
 	if (IS_ERR(ret))
 		return ret;
 	ret = ovl_create_real(ofs, workdir, ret, attr);
-	if (!IS_ERR(ret))
-		dget(ret);
-	end_creating(ret);
-	return ret;
+	return end_creating_keep(ret);
 }
 
 static int ovl_set_opaque_xerr(struct dentry *dentry, struct dentry *upper,
@@ -364,8 +361,7 @@ static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
 	if (IS_ERR(newdentry))
 		return PTR_ERR(newdentry);
 
-	dget(newdentry);
-	end_creating(newdentry);
+	end_creating_keep(newdentry);
 
 	if (ovl_type_merge(dentry->d_parent) && d_is_dir(newdentry) &&
 	    !ovl_allow_offline_changes(ofs)) {
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 3acda985c8a3..7b8fc1cab6eb 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -319,8 +319,7 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 		};
 
 		if (work->d_inode) {
-			dget(work);
-			end_creating(work);
+			end_creating_keep(work);
 			if (persist)
 				return work;
 			err = -EEXIST;
@@ -336,9 +335,7 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 		}
 
 		work = ovl_do_mkdir(ofs, dir, work, attr.ia_mode);
-		if (!IS_ERR(work))
-			dget(work);
-		end_creating(work);
+		end_creating_keep(work);
 		err = PTR_ERR(work);
 		if (IS_ERR(work))
 			goto out_err;
@@ -630,9 +627,7 @@ static struct dentry *ovl_lookup_or_create(struct ovl_fs *ofs,
 		if (!child->d_inode)
 			child = ovl_create_real(ofs, parent, child,
 						OVL_CATTR(mode));
-		if (!IS_ERR(child))
-			dget(child);
-		end_creating(child);
+		end_creating_keep(child);
 	}
 	dput(parent);
 
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 0ef73d739a31..3d82c6a19197 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -125,6 +125,28 @@ static inline void end_creating(struct dentry *child)
 	end_dirop(child);
 }
 
+/* end_creating_keep - finish action started with start_creating() and return result
+ * @child: dentry returned by start_creating() or vfs_mkdir()
+ *
+ * Unlock and return the child. This can be called after
+ * start_creating() whether that function succeeded or not,
+ * but it is not needed on failure.
+ *
+ * If vfs_mkdir() was called then the value returned from that function
+ * should be given for @child rather than the original dentry, as vfs_mkdir()
+ * may have provided a new dentry.
+ *
+ * Returns: @child, which may be a dentry or an error.
+ *
+ */
+static inline struct dentry *end_creating_keep(struct dentry *child)
+{
+	if (!IS_ERR(child))
+		dget(child);
+	end_dirop(child);
+	return child;
+}
+
 /**
  * end_removing - finish action started with start_removing
  * @child:  dentry returned by start_removing()
-- 
2.50.0.107.gf914562f5916.dirty


