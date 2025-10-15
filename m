Return-Path: <linux-fsdevel+bounces-64190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBA1BDC086
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 03:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F66B4E6D94
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 01:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CD62FA0F2;
	Wed, 15 Oct 2025 01:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="FoIYCZbh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RztUEQoC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80962FABFE
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 01:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760492958; cv=none; b=upJxgEhe6KeZUb1/PnOvWmUxzrjB4POfWSv5Lh+AjneDrgLr3U/jpVNuB7ci+rq4Th2NY6jS6ecfy8NVMdbmL+SXLLZprk55ULpO36HFcV1ATPZLLGJTLghN3Dpfk9sIRPW+eB3B8S3CV+S0fJ46hamDq1OzC2DJaLrNB/lNVIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760492958; c=relaxed/simple;
	bh=t8xcquwlYzQumCEVUJqyKqqANKitnGAs284IbxakoYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=onz58KYueK79WwJt5sODn9InDdcOYVpK8mb2oUuWtpk/tC6SJTAiFI8f91qTFA64SxrTF0RR9K+pPYCE/o3RnIYP/FGVhXk3lou5xix4qXM5spoRDunu1K33exDdrNm6gY1T/fsP1DJpIscQwLsIu78mIriAAA86YspzrtTpxes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=FoIYCZbh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RztUEQoC; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id EF95AEC023D;
	Tue, 14 Oct 2025 21:49:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 14 Oct 2025 21:49:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1760492954;
	 x=1760579354; bh=Qw/IdKxx2yds0/EacOqu5T2o0bGbR/u0SxIknvtuWHw=; b=
	FoIYCZbhQg5JwjYTilcI3pwOj6il/F2SjT9Lh3vf8smVOPwWdy2Nl73ghBd/z0JG
	PakzzBfUWReC5fxnXnTo5nyILdYDsYFpxcpR88tqooN/dvGxuXi1/pI1AQrgcIx+
	2EDVDhi2U/+2YFzg97asDgWR0tXJJbY+b8PPx32obKsbvCGtpobqjumQnjYIRu6o
	nYtk5+8K9LTltpe+pfQsNBIdt+OZn5r7qau8Qo/S/Q+3HDdELFARDcWFlKYwfUbK
	Ujk0bwQRMhUSXeM6KIoSA6jk4BFjEzl25rrrTNEUhqR7eVGiAdBi9oKuuOxum3YX
	UMY77WlkAfxGVtA9q96COw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760492954; x=1760579354; bh=Q
	w/IdKxx2yds0/EacOqu5T2o0bGbR/u0SxIknvtuWHw=; b=RztUEQoCuyg5Y8eEE
	jQ+0h45+O9X7a7O8JRXKnlKwB0znwadhUWFqz58EeHDtrGY70/DHbZOPI+wcO1tz
	kP/5VEEJTmc1xaUIRJx18FVTiZmmlxv+oIHXVi9ET51EpHpQWSDy8uqVj22InK8z
	FVPRB/qxZLyw2HIikuQ70Fjx8Z53SSwYcYTSyqpd0hBpsSV0kC03gJNbw55b6JGp
	K20u6Q8DrkOuxFCyMvjivJ0hWQAL3T9ZR88UkLdGUvuEut5qlQPGPeFfjugy68fA
	+WkzsolwGBzyaO+hQAW7SuN3dnPtn2mz+ujOZ4lcZxkur8NCuvZ0deVZs56Sw/Ng
	ow28w==
X-ME-Sender: <xms:mv3uaDxeSd5_NbrCQqQpXdi59gPtybPKlxv-CRhdVRaKkNEa_Ea-OA>
    <xme:mv3uaGMmZwavkJQF4-vKw3uKOQxawNgPygvOQU_iIJyAqdxuSWsDAm2EcFin0UvJH
    mbOQVzYOO_SWj1z8A9a-o3ukwx0Lxj3pkeLRtbGMU71qEI->
X-ME-Received: <xmr:mv3uaMXAtLFGzUbOHzyhw0i3tE1paT3gkrc29sdd23-fwQx-q92--DphpGZC2fNAlh5_B2QVx-c58XNEx6qOomZnxESGoreXEgyNObCiBo0H>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddvudefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:mv3uaC0WkZnXKudxTBiBAFlzbYxZmRaOwvSLrRfpk48ONkdTCO45MA>
    <xmx:mv3uaCq7ch_4m6nwdjKPF6s7kBNKP514-crbBSxDkV7YhU7fp-62XA>
    <xmx:mv3uaBXbaP2jUVvFpbwwKOJ0mDbWC9utMi9hP8ryaZGFllCpQamMwQ>
    <xmx:mv3uaFb6io-2cMPqy2IYnQ4TjzfqskSAppiJ11yIr_zFx3fC0rs_og>
    <xmx:mv3uaKKdB7hgFdtZqDt5i1z-GkWBCYwePvdantBfLAojmbpWQ7Y35Wfk>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 21:49:12 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 14/14] VFS: introduce end_creating_keep()
Date: Wed, 15 Oct 2025 12:47:06 +1100
Message-ID: <20251015014756.2073439-15-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251015014756.2073439-1-neilb@ownmail.net>
References: <20251015014756.2073439-1-neilb@ownmail.net>
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

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/cachefiles/namei.c |  3 +--
 fs/overlayfs/dir.c    |  8 ++------
 fs/overlayfs/super.c  | 11 +++--------
 include/linux/namei.h | 22 ++++++++++++++++++++++
 4 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 10f010dc9946..5c50293328f4 100644
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
index 00dc797f2da7..cadbb47c6225 100644
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


