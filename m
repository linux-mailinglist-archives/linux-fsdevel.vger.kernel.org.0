Return-Path: <linux-fsdevel+bounces-67252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE76EC38A4F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 02:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F8263BC787
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 00:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B077247287;
	Thu,  6 Nov 2025 00:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="PTST6WA8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZJEcOsnA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A847E1FE46D;
	Thu,  6 Nov 2025 00:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762390636; cv=none; b=n87Kzlfpv36SFB5SFlHICkyTTVvugCr/CoPTrK/ny+W76rXGQj70g8N+o9lVZBJxl6SylopAT35NEsWX/fj7jwawuR2sMtfX40T+3UTYrE3f1mH1GGUgBKauq4pDVKlXvQRXnVvEO1Fx2oDIl2s2v/RXtm2P3QJXfTHh65U+tFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762390636; c=relaxed/simple;
	bh=X2D3OwIKW4rR3cIHHnntV7DDsOoGo04YBA483px290I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SCfvo29P/A0dvsHBV9k3+0VOQ2GSxJs+6QLkoZ65jv6uE7ruk26wWh1gvYJPifmIfTS4bKBAglmIF3rxd/Ja0BVF8rvzk61WupZDTXoLlPPqx4a7RHjNF3zX78sQii/9toSDA9zqRAodSp8rAxZSSFc3Aub81nj6lRDV7PpPxfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=PTST6WA8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZJEcOsnA; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id E9AA113005FE;
	Wed,  5 Nov 2025 19:57:12 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 05 Nov 2025 19:57:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1762390632;
	 x=1762397832; bh=6X4X+jO8scXaaR1fA21EGG74X2XQZWnQw+ie11lSXCw=; b=
	PTST6WA8hfLl1kp1qyqqgQgCaPl3oThCtjKzi+CutJCPiAO0qOZtCNkFXtOZbYIr
	6/z7UAeFWK610e9P12o+aWGmoMgMBUXVfwQB5ewT+6rnXfz80ZHUWC4Ci5gSv7hl
	wWCTyCVcyzACiu+rfkAx8934wUDpptGJClj6DJhv3FWWECLZDPwAN+ZeJ2OXJzRM
	JthM/fejEKuFoSlzgzdp98QNLTP6J81Zn3brDKEMg/TiormExtTiIcWLTeK/L34D
	Fnzb5cclWtt/gVEEIRGSQHnrAftkUB/ecYH7cK1J88qYraX6ykEgcnDJsgZOPOeu
	LCVucLO90TPP/KNbMQJRPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1762390632; x=1762397832; bh=6
	X4X+jO8scXaaR1fA21EGG74X2XQZWnQw+ie11lSXCw=; b=ZJEcOsnAfFH09d89e
	xMnEvMts0mGxlHriO4R2hiJGejWj2avaymUdFF/QjuJP+aOtLH601VFRHHSwMVcc
	6z5nghlAOmInHpxMhXOIyd4qVNmRqKbOdvEoH6vDYx/tqLXTAImiKPu4jrKb1pTu
	pYcjRcxOM//owrYHfZ8iPi6eEJ8fzPecQ4FjjyG4v7BunczFu8jY0b88J0ScmbQV
	qw4r5H7jrAKrn0+5I9DtlG3GimpgUMhSnkmiBIR0Z66UCSfwz/wZpmmle5NyYNRQ
	XEr1bXgqDSmRNrzHz4BxVFEDE0BqRoa/DOu321Z6ZkGO+9I0CGHYUt3XQbfIVJ/0
	P6zAw==
X-ME-Sender: <xms:aPILaQoliaJCA0F8WPgArfBCnlyvr_5jlFurL2Iax8fjtRYmvNaj2g>
    <xme:aPILabuP5SmzjrZSMnDYXIF37Bi1aUl1JFwDkXZe47jYVq-chGG2SQG4NFAmvPH5i
    -XEurUYyaiId4CZnVm8uPRngXZhWdYTVXLMQW2HBQcUEBK4TA>
X-ME-Received: <xmr:aPILaSN6aqtKa1guMORW5uua4BDZUfBARCFJLayzm2unI6ppmY8ceqmyl1PzwWdEyevUXUf5NnIBqdXP4Nt2fOKc1Qd-yp1X238JPFBU3jjk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeehfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
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
X-ME-Proxy: <xmx:aPILaVkUhA08m4Sorrl9Wc2SBj15wI5xlRK_lOh9YRS19MEhgXlIHA>
    <xmx:aPILaRY3IReKWTzcv-pRVn183qO-H72I7OjH9XpoVlCJmldBN8YODw>
    <xmx:aPILac1Gx-DLb0z5dk-RSQfbm_gPK58TNeBlI1G1A2mzTTgdWupztw>
    <xmx:aPILafRnqqWjoD5PXsl_HNX8qNHlMmVM1Gkdl7p4mbFP_uQZI7OBCQ>
    <xmx:aPILadyOYBpskcKadCFIOqZ6_3lrJ0Wdn6zP2iMtmTntXjzow5PIl0Hp>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 19:57:02 -0500 (EST)
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
Subject: [PATCH v5 14/14] VFS: introduce end_creating_keep()
Date: Thu,  6 Nov 2025 11:50:58 +1100
Message-ID: <20251106005333.956321-15-neilb@ownmail.net>
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
index 59327618ac42..ef22ac19545b 100644
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
index a4a0dc261310..50717ff8cac7 100644
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
index b4d95b79b5a8..58600cf234bc 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -126,6 +126,28 @@ static inline void end_creating(struct dentry *child)
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


