Return-Path: <linux-fsdevel+bounces-66400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 426D8C1DD0B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 00:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CF1C42786E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 23:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0645633343B;
	Wed, 29 Oct 2025 23:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="EB+UPCXm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Osdl4h/+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859BD328617;
	Wed, 29 Oct 2025 23:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761781671; cv=none; b=iELk2M87GC4vT6B/IPfb8nCsI4CqaKhhqA8WPRZSuP6saH08APjo70RGrWgG/p2U8D6LRNXTTXS8He25+Xqxpi+Ce4jBJBB4HJq96mO+YK/SOeTHkov0sFd1KrFo7tezgqqWvh1Wjfhz3mB6SGeFUsN2TFYIVNhlKQ7kAvI2xyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761781671; c=relaxed/simple;
	bh=UnJY3zziw7yUTfl0dL3hkuTETSblbZ0Q1Qk3fxnoh+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UbrJ9r88ZQv0jI2NXbs5weK7SieE+jOHfTIqIW7L22wZF/ikbhbuCRzCAnE3N3SOjnkvCEvcQF+U3kGHbb54lJTGZ/XBwZqMRSnDdMcUpBX/mmIxQyFUFxVfLeZjFYnot6YxTiyPNPrg9AIHjBAX3NsCUZ2jCjxpYz11Jzb/sjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=EB+UPCXm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Osdl4h/+; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 0FB3B130007D;
	Wed, 29 Oct 2025 19:47:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 29 Oct 2025 19:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1761781667;
	 x=1761788867; bh=fTSvEbE8/RNuX1OHXwzF1EdnZhiVUoe98OJSdEQ8jG4=; b=
	EB+UPCXmsM/DcyfLpMLGAMkwWvlp0N5GXB22rXFfjo4Va3mjK3Aye4ogW4hhQk8K
	kK2CJ0BdKCzy2k+pC3e4k9PO9RBtCSNyuygRajLpwjl3WjcmAiUgMFlBlxTy/2Vn
	Bvz3SRQLQ7EwzaZXSguk7luoN/N+VyLu9RehwYxA4iMYl81yp36jHTvEJhXd9Bmj
	weH7NJN4MM5tFKvp51ZobuRwPBc4I0YEM1MRP8+3ZyyG720xo2mucWyZpoa9B8Lj
	uSoI9wWex2o2hiyyNQ6lU42FV4FrV0uD8E5Wt7CT+bk+xxoeseIjQ85dI4IrD6ns
	fUGD87cWYPr4gTdEqSKAkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1761781667; x=1761788867; bh=f
	TSvEbE8/RNuX1OHXwzF1EdnZhiVUoe98OJSdEQ8jG4=; b=Osdl4h/+0IdXDkEWV
	rbHAF7FaQmw7JpQKvjpt0k6y6O69RaYY2zmhYNbZyUQpIvnKguLIn2rV2IHBTRuA
	ofMioaUZfZzE2B/pgRnsHwAfEq6ajSDICQ7Woo+Vw2/XM9Y1GICXyoaL3XAGK8Ep
	yCE0aqIO49mcIP+/cwE29py1t+vx0LfCuwyWz7tq6UUfk98ke8HEDmC0ekCvLPyZ
	fnykZK1Q0FHZPWlhl/N3SwFehKc5mm5BXC6VXhMBSIxXhJ9PkkIgg9jZzKVACd9a
	OsY+MDpYp7ouC77iK54Tun31iI39uanJ7yzBy+R+c4bERqN7JKV3mlns7CjUYq48
	LxuSA==
X-ME-Sender: <xms:o6cCaVZf6J0SUdN43Qo87RX9dXYloaAhXWN-L23LOXStYGc1VAg1VA>
    <xme:o6cCafQ9a2cQWLeZyOZN3aIZe4XOZiHqzZpmoBjc0NhHWIgZRnGkMD5fTwBrqbQ3W
    wV0bsa7PzmMdaIi8Kzsf8xVZruNYfD4eUkQzZzvIhKcz-i2tw>
X-ME-Received: <xmr:o6cCaYw4tvjTN-WRiQo0CIQjdMx9Ev_Fgbw0XNcfl5M_BxytK7dSEF55Y-2kIiW_-M_ZCvOJu0AuY3WcbQnRlgao_AeFxqU02X4jOsnqG27g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieehtdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
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
X-ME-Proxy: <xmx:o6cCaVexMFfNBZ9TxXLxfgFhawwEM9E3KfEHpVFvRX0oCPsblTmBWA>
    <xmx:o6cCaeneMGqxertrNWF58HZ_jUJUxgh9Bxb1FYx6SATfdomS9MDNzQ>
    <xmx:o6cCacRBSLsrU3eF35jlLqtRqS0aB3bitsjyl0fEX6Zv6A39rqOA6A>
    <xmx:o6cCaVdPuQ8h5dKXVtkzXPbXxbBPm50S3g3duxz1RpVnI1xqnnygqA>
    <xmx:o6cCaWnh3FQONjxIEwzvmLdsCtKTlbETjNsHsO8u-jZl9q48984d1tPg>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Oct 2025 19:47:37 -0400 (EDT)
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
Subject: [PATCH v4 14/14] VFS: introduce end_creating_keep()
Date: Thu, 30 Oct 2025 10:31:14 +1100
Message-ID: <20251029234353.1321957-15-neilb@ownmail.net>
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
index 10e732360ace..8faab04dc79f 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -252,10 +252,7 @@ struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *workdir,
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
@@ -365,8 +362,7 @@ static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
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


