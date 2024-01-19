Return-Path: <linux-fsdevel+bounces-8299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4348832781
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 11:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4487C1F2308D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 10:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AD13C496;
	Fri, 19 Jan 2024 10:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O9AEWbVC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16E33C463
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jan 2024 10:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705659302; cv=none; b=B3ty0UJT1Pw94NjfbB+d8fkXYfvKsz28K2sgNzzhBXOWT/PxZ7V4RXuXLVrgoXL6EpW1IjttBaTnU/CCIiflhnt/LztQXoL4sObMYU123WHg7FABpgYIeJZZNPRhtbgmsXodH+7E2wLt4DjaN9zF6QDcQm7/AyLLaU/lFF2NSQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705659302; c=relaxed/simple;
	bh=PoGZhOlA4I6K2rbHCfM89+kkuoAnwJHPvSOVGyYTJGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SjnZC66vMhcwcIEeI4+QsObsr6oS/SSxxs3QlBfnH/9l3aReKKo1G3z4KcsV95PN+mWdk9rswIq4uFZ3tHa2+e5DgXXF48DEs1T3aJvx9IyF9pvIDfsY4fvnTfxxVR7oCBJJ7cR810A/Ju2TXPwdL8+z5nFx6dJu8z6FD+lPkJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O9AEWbVC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705659299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Grt+SDOK1/c/nYm3Ye87fT+Zp8d7TJfN64yiGI0kHKA=;
	b=O9AEWbVCJPUf3t3PiTK3eFJpQKphEgbqI85c3hpViqFIfRYzcjBi2woHcGfzfhg1UzifhO
	SMwpRbAHstrbosKNVKW8I2U1rxWmvGHCDovwJyOoaSeIFVa2koaGjMAit1030D+1Tp249Q
	AN0BqVVc6uTomSYc+hP0z6AggaoANeM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-ETdcDrtoPyuZwIjjmRovJg-1; Fri, 19 Jan 2024 05:14:57 -0500
X-MC-Unique: ETdcDrtoPyuZwIjjmRovJg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a2bd17e6155so18109466b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jan 2024 02:14:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705659296; x=1706264096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Grt+SDOK1/c/nYm3Ye87fT+Zp8d7TJfN64yiGI0kHKA=;
        b=jeG1eHesHoEe9kLi/Sapai8KZJuO6oZy7bJGOQCFeYkhYS5nVJNXgKfMEEfDqR04XJ
         tkXTdy/hvt3Oi5zJ/GKkYF/saMQDsoRuh8Iv/sRkPZTqPw0ETIj1oP9MQYWAVahX2N5p
         UeW9ZYT7FMj+iFpmhNaZb4tr7mxXc5W+5XP0V3y71LoWMmtpcjkjlv6eo7WtJpUtCFZD
         rYBOuvaEk1iix8C2SYSSonKQDmoWnjPanVEajCU75sI+rsljnjDfONbzcBGmpWJkm6la
         KHYM3OEod26GIepnoZ79AxGdpF+Mj9bb6MZFpGRTvaA0xrPUWkClyKWajXilR+eMzrrd
         9dEQ==
X-Gm-Message-State: AOJu0Yz/q1uqM9IZhzX/kjSLLNr8tAL9K+Jb2Vk1/r3J6Chx4V45it27
	1a8OvAYHcu1Gd5f4nVDJ1HNcAMGLRO6eMQgRG8PIVWF8vwL/RcgHy1NVJhhJRh8Paw5o7aZVzGo
	mo/17LLD2TP/sH15ORtM/WOBO5dNTq6Vui2+LAQEuWq2rtjxJ8aN39p52+H9uA0w=
X-Received: by 2002:a17:907:8743:b0:a2c:fa8f:6f4b with SMTP id qo3-20020a170907874300b00a2cfa8f6f4bmr1732899ejc.101.1705659296549;
        Fri, 19 Jan 2024 02:14:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7QJ2+mW7+zktqnOGA/Hqwy3FVOuFpur9mZWd4e5YumwmFg4ljGG0AeMOPI4ZjUgZfXcQehg==
X-Received: by 2002:a17:907:8743:b0:a2c:fa8f:6f4b with SMTP id qo3-20020a170907874300b00a2cfa8f6f4bmr1732893ejc.101.1705659296191;
        Fri, 19 Jan 2024 02:14:56 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (213-197-75-215.pool.digikabel.hu. [213.197.75.215])
        by smtp.gmail.com with ESMTPSA id vu3-20020a170907a64300b00a2d7f63dd71sm6987612ejc.29.2024.01.19.02.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 02:14:55 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: Alexander Larsson <alexl@redhat.com>,
	Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] ovl: require xwhiteout feature flag on layer roots
Date: Fri, 19 Jan 2024 11:14:53 +0100
Message-ID: <20240119101454.532809-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a check on each lower layer for the xwhiteout feature.  This prevents
unnecessary checking the overlay.whiteouts xattr when reading a directory
if this feature is not enabled, i.e. most of the time.

Share the same xattr for the per-directory and the per-layer flag, which
has the effect that if this is enabled for a layer, then the optimization
to bypass checking of individual entries does not work on the root of the
layer.  This was deemed better, than having a separate xattr for the layer
and the directory.

Fixes: bc8df7a3dc03 ("ovl: Add an alternative type of whiteout")
Cc: <stable@vger.kernel.org> # v6.7
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
v2:
 - use overlay.whiteouts instead of overlay.feature_xwhiteout
 - move initialization to ovl_get_layers()
 - xwhiteouts can only be enabled on lower layer

 fs/overlayfs/namei.c     | 10 +++++++---
 fs/overlayfs/overlayfs.h |  7 +++++--
 fs/overlayfs/ovl_entry.h |  2 ++
 fs/overlayfs/readdir.c   | 11 ++++++++---
 fs/overlayfs/super.c     | 13 +++++++++++++
 fs/overlayfs/util.c      |  7 ++++++-
 6 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 03bc8d5dfa31..583cf56df66e 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -863,7 +863,8 @@ struct dentry *ovl_lookup_index(struct ovl_fs *ofs, struct dentry *upper,
  * Returns next layer in stack starting from top.
  * Returns -1 if this is the last layer.
  */
-int ovl_path_next(int idx, struct dentry *dentry, struct path *path)
+int ovl_path_next(int idx, struct dentry *dentry, struct path *path,
+		  const struct ovl_layer **layer)
 {
 	struct ovl_entry *oe = OVL_E(dentry);
 	struct ovl_path *lowerstack = ovl_lowerstack(oe);
@@ -871,13 +872,16 @@ int ovl_path_next(int idx, struct dentry *dentry, struct path *path)
 	BUG_ON(idx < 0);
 	if (idx == 0) {
 		ovl_path_upper(dentry, path);
-		if (path->dentry)
+		if (path->dentry) {
+			*layer = &OVL_FS(dentry->d_sb)->layers[0];
 			return ovl_numlower(oe) ? 1 : -1;
+		}
 		idx++;
 	}
 	BUG_ON(idx > ovl_numlower(oe));
 	path->dentry = lowerstack[idx - 1].dentry;
-	path->mnt = lowerstack[idx - 1].layer->mnt;
+	*layer = lowerstack[idx - 1].layer;
+	path->mnt = (*layer)->mnt;
 
 	return (idx < ovl_numlower(oe)) ? idx + 1 : -1;
 }
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 05c3dd597fa8..6359cf5c66ff 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -492,7 +492,9 @@ bool ovl_path_check_dir_xattr(struct ovl_fs *ofs, const struct path *path,
 			      enum ovl_xattr ox);
 bool ovl_path_check_origin_xattr(struct ovl_fs *ofs, const struct path *path);
 bool ovl_path_check_xwhiteout_xattr(struct ovl_fs *ofs, const struct path *path);
-bool ovl_path_check_xwhiteouts_xattr(struct ovl_fs *ofs, const struct path *path);
+bool ovl_path_check_xwhiteouts_xattr(struct ovl_fs *ofs,
+				     const struct ovl_layer *layer,
+				     const struct path *path);
 bool ovl_init_uuid_xattr(struct super_block *sb, struct ovl_fs *ofs,
 			 const struct path *upperpath);
 
@@ -674,7 +676,8 @@ int ovl_get_index_name(struct ovl_fs *ofs, struct dentry *origin,
 struct dentry *ovl_get_index_fh(struct ovl_fs *ofs, struct ovl_fh *fh);
 struct dentry *ovl_lookup_index(struct ovl_fs *ofs, struct dentry *upper,
 				struct dentry *origin, bool verify);
-int ovl_path_next(int idx, struct dentry *dentry, struct path *path);
+int ovl_path_next(int idx, struct dentry *dentry, struct path *path,
+		  const struct ovl_layer **layer);
 int ovl_verify_lowerdata(struct dentry *dentry);
 struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 			  unsigned int flags);
diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index d82d2a043da2..33fcd3d3af30 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -40,6 +40,8 @@ struct ovl_layer {
 	int idx;
 	/* One fsid per unique underlying sb (upper fsid == 0) */
 	int fsid;
+	/* xwhiteouts are enabled on this layer*/
+	bool xwhiteouts;
 };
 
 struct ovl_path {
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index a490fc47c3e7..c2597075e3f8 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -305,8 +305,6 @@ static inline int ovl_dir_read(const struct path *realpath,
 	if (IS_ERR(realfile))
 		return PTR_ERR(realfile);
 
-	rdd->in_xwhiteouts_dir = rdd->dentry &&
-		ovl_path_check_xwhiteouts_xattr(OVL_FS(rdd->dentry->d_sb), realpath);
 	rdd->first_maybe_whiteout = NULL;
 	rdd->ctx.pos = 0;
 	do {
@@ -359,10 +357,14 @@ static int ovl_dir_read_merged(struct dentry *dentry, struct list_head *list,
 		.is_lowest = false,
 	};
 	int idx, next;
+	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
+	const struct ovl_layer *layer;
 
 	for (idx = 0; idx != -1; idx = next) {
-		next = ovl_path_next(idx, dentry, &realpath);
+		next = ovl_path_next(idx, dentry, &realpath, &layer);
 		rdd.is_upper = ovl_dentry_upper(dentry) == realpath.dentry;
+		if (ovl_path_check_xwhiteouts_xattr(ofs, layer, &realpath))
+			rdd.in_xwhiteouts_dir = true;
 
 		if (next != -1) {
 			err = ovl_dir_read(&realpath, &rdd);
@@ -568,6 +570,7 @@ static int ovl_dir_read_impure(const struct path *path,  struct list_head *list,
 	int err;
 	struct path realpath;
 	struct ovl_cache_entry *p, *n;
+	struct ovl_fs *ofs = OVL_FS(path->dentry->d_sb);
 	struct ovl_readdir_data rdd = {
 		.ctx.actor = ovl_fill_plain,
 		.list = list,
@@ -577,6 +580,8 @@ static int ovl_dir_read_impure(const struct path *path,  struct list_head *list,
 	INIT_LIST_HEAD(list);
 	*root = RB_ROOT;
 	ovl_path_upper(path->dentry, &realpath);
+	if (ovl_path_check_xwhiteouts_xattr(ofs, &ofs->layers[0], &realpath))
+		rdd.in_xwhiteouts_dir = true;
 
 	err = ovl_dir_read(&realpath, &rdd);
 	if (err)
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index a0967bb25003..04588721eb2a 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1027,6 +1027,7 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
 		struct ovl_fs_context_layer *l = &ctx->lower[i];
 		struct vfsmount *mnt;
 		struct inode *trap;
+		struct path root;
 		int fsid;
 
 		if (i < nr_merged_lower)
@@ -1069,6 +1070,16 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
 		 */
 		mnt->mnt_flags |= MNT_READONLY | MNT_NOATIME;
 
+		/*
+		 * Check if xwhiteout (xattr whiteout) support is enabled on
+		 * this layer.
+		 */
+		root.mnt = mnt;
+		root.dentry = mnt->mnt_root;
+		err = ovl_path_getxattr(ofs, &root, OVL_XATTR_XWHITEOUTS, NULL, 0);
+		if (err >= 0)
+			layers[ofs->numlayer].xwhiteouts = true;
+
 		layers[ofs->numlayer].trap = trap;
 		layers[ofs->numlayer].mnt = mnt;
 		layers[ofs->numlayer].idx = ofs->numlayer;
@@ -1079,6 +1090,8 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
 		l->name = NULL;
 		ofs->numlayer++;
 		ofs->fs[fsid].is_lower = true;
+
+
 	}
 
 	/*
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index c3f020ca13a8..6c6e6f5893ea 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -739,11 +739,16 @@ bool ovl_path_check_xwhiteout_xattr(struct ovl_fs *ofs, const struct path *path)
 	return res >= 0;
 }
 
-bool ovl_path_check_xwhiteouts_xattr(struct ovl_fs *ofs, const struct path *path)
+bool ovl_path_check_xwhiteouts_xattr(struct ovl_fs *ofs,
+				     const struct ovl_layer *layer,
+				     const struct path *path)
 {
 	struct dentry *dentry = path->dentry;
 	int res;
 
+	if (!layer->xwhiteouts)
+		return false;
+
 	/* xattr.whiteouts must be a directory */
 	if (!d_is_dir(dentry))
 		return false;
-- 
2.43.0


