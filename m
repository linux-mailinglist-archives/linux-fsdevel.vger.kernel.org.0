Return-Path: <linux-fsdevel+bounces-10514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D2C84BE83
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 21:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1195B2379A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 20:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C85619BBA;
	Tue,  6 Feb 2024 20:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ItsvzwHw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947CC17BAE
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 20:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707250752; cv=none; b=PNYNGofOPP+hekCo6SgkYuYIZEqL6GNKVrE+4F8iBqUCyKOD/6y/eBMqTOWuG83BHujQcnQm/8w1ZOcL45yS25k00ZaYE1EJ4/3C/MDH8dh2s6tk/cdVJpf6xKPAuTpxOth5Dt8zSu9HMKE5d7oArd9oatxHjB7SUUDdnIUtxus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707250752; c=relaxed/simple;
	bh=IFPQ2jungHyUB4CEcxolgK/qYt4FICu78XWohMSyZBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QEi8/lkTZId82V4gzEqk0nZ8xqUnqk9iaifzXWRThOulqFytypktzkNnyz3KR+pz4Ib+4A93uhGlUWRZ1htnQJXEnWD6C0w8WucU9O/qX6cgmQ48HmG/oUMjah3Bre8dAl8r66HVWIqfoDvaIt3diMTvp9/vtseAy6Yu2Sb1LU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ItsvzwHw; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707250748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wa58PtJA1fEj7KT99tVetLIDmYZFQYqMwoh2nppQYCw=;
	b=ItsvzwHwNNPEMuHmsPn2p1KXWHXVJ9HrmVnzfW7oibn8pUHwy31qJcU8LGI+pduY5MzI5Z
	OKXph/Hlf4RTyrKU+msyhEwYuCoOId6rSPRhEqWhy3Sri4xhMyp1Jsy0MoNV2keCa9z3qQ
	RD/NwjpVTvHWXpTpVDokO6r1e6f4tEw=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH v2 1/7] fs: super_set_uuid()
Date: Tue,  6 Feb 2024 15:18:49 -0500
Message-ID: <20240206201858.952303-2-kent.overstreet@linux.dev>
In-Reply-To: <20240206201858.952303-1-kent.overstreet@linux.dev>
References: <20240206201858.952303-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Some weird old filesytems have UUID-like things that we wish to expose
as UUIDs, but are smaller; add a length field so that the new
FS_IOC_(GET|SET)UUID ioctls can handle them in generic code.

And add a helper super_set_uuid(), for setting nonstandard length uuids.

Helper is now required for the new FS_IOC_GETUUID ioctl; if
super_set_uuid() hasn't been called, the ioctl won't be supported.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/fs.c     | 2 +-
 fs/ext4/super.c      | 2 +-
 fs/f2fs/super.c      | 2 +-
 fs/gfs2/ops_fstype.c | 2 +-
 fs/kernfs/mount.c    | 4 +++-
 fs/ocfs2/super.c     | 4 ++--
 fs/ubifs/super.c     | 2 +-
 fs/xfs/xfs_mount.c   | 2 +-
 include/linux/fs.h   | 9 +++++++++
 mm/shmem.c           | 4 +++-
 10 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index 77ea61090e91..68e9a89e42bb 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -1946,7 +1946,7 @@ static struct dentry *bch2_mount(struct file_system_type *fs_type,
 	sb->s_time_gran		= c->sb.nsec_per_time_unit;
 	sb->s_time_min		= div_s64(S64_MIN, c->sb.time_units_per_sec) + 1;
 	sb->s_time_max		= div_s64(S64_MAX, c->sb.time_units_per_sec);
-	sb->s_uuid		= c->sb.user_uuid;
+	super_set_uuid(sb, c->sb.user_uuid.b, sizeof(c->sb.user_uuid));
 	c->vfs_sb		= sb;
 	strscpy(sb->s_id, c->name, sizeof(sb->s_id));
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index dcba0f85dfe2..9e28ebd0869a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5346,7 +5346,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 		sb->s_qcop = &ext4_qctl_operations;
 	sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP | QTYPE_MASK_PRJ;
 #endif
-	memcpy(&sb->s_uuid, es->s_uuid, sizeof(es->s_uuid));
+	super_set_uuid(sb, es->s_uuid, sizeof(es->s_uuid));
 
 	INIT_LIST_HEAD(&sbi->s_orphan); /* unlinked but open files */
 	mutex_init(&sbi->s_orphan_lock);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index d45ab0992ae5..5dd7b7b26db9 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4496,7 +4496,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_time_gran = 1;
 	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
 		(test_opt(sbi, POSIX_ACL) ? SB_POSIXACL : 0);
-	memcpy(&sb->s_uuid, raw_super->uuid, sizeof(raw_super->uuid));
+	super_set_uuid(&sb, (void *) raw_super->uuid, sizeof(raw_super->uuid));
 	sb->s_iflags |= SB_I_CGROUPWB;
 
 	/* init f2fs-specific super block info */
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 1281e60be639..572d58e86296 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -214,7 +214,7 @@ static void gfs2_sb_in(struct gfs2_sbd *sdp, const void *buf)
 
 	memcpy(sb->sb_lockproto, str->sb_lockproto, GFS2_LOCKNAME_LEN);
 	memcpy(sb->sb_locktable, str->sb_locktable, GFS2_LOCKNAME_LEN);
-	memcpy(&s->s_uuid, str->sb_uuid, 16);
+	super_set_uuid(s, str->sb_uuid, 16);
 }
 
 /**
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 0c93cad0f0ac..e29f4edf9572 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -358,7 +358,9 @@ int kernfs_get_tree(struct fs_context *fc)
 		}
 		sb->s_flags |= SB_ACTIVE;
 
-		uuid_gen(&sb->s_uuid);
+		uuid_t uuid;
+		uuid_gen(&uuid);
+		super_set_uuid(sb, uuid.b, sizeof(uuid));
 
 		down_write(&root->kernfs_supers_rwsem);
 		list_add(&info->node, &info->root->supers);
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 6b906424902b..a70aff17d455 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -2027,8 +2027,8 @@ static int ocfs2_initialize_super(struct super_block *sb,
 	cbits = le32_to_cpu(di->id2.i_super.s_clustersize_bits);
 	bbits = le32_to_cpu(di->id2.i_super.s_blocksize_bits);
 	sb->s_maxbytes = ocfs2_max_file_offset(bbits, cbits);
-	memcpy(&sb->s_uuid, di->id2.i_super.s_uuid,
-	       sizeof(di->id2.i_super.s_uuid));
+	super_set_uuid(sb, di->id2.i_super.s_uuid,
+		       sizeof(di->id2.i_super.s_uuid));
 
 	osb->osb_dx_mask = (1 << (cbits - bbits)) - 1;
 
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 09e270d6ed02..f780729eec06 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -2245,7 +2245,7 @@ static int ubifs_fill_super(struct super_block *sb, void *data, int silent)
 		goto out_umount;
 	}
 
-	import_uuid(&sb->s_uuid, c->uuid);
+	super_set_uuid(sb, c->uuid, sizeof(c->uuid));
 
 	mutex_unlock(&c->umount_mutex);
 	return 0;
diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index aabb25dc3efa..4a46bc44088f 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -62,7 +62,7 @@ xfs_uuid_mount(
 	int			hole, i;
 
 	/* Publish UUID in struct super_block */
-	uuid_copy(&mp->m_super->s_uuid, uuid);
+	super_set_uuid(mp->m_super, uuid->b, sizeof(*uuid));
 
 	if (xfs_has_nouuid(mp))
 		return 0;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ed5966a70495..acdc56987cb1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1257,6 +1257,7 @@ struct super_block {
 
 	char			s_id[32];	/* Informational name */
 	uuid_t			s_uuid;		/* UUID */
+	u8			s_uuid_len;	/* Default 16, possibly smaller for weird filesystems */
 
 	unsigned int		s_max_links;
 
@@ -2532,6 +2533,14 @@ extern __printf(2, 3)
 int super_setup_bdi_name(struct super_block *sb, char *fmt, ...);
 extern int super_setup_bdi(struct super_block *sb);
 
+static inline void super_set_uuid(struct super_block *sb, const u8 *uuid, unsigned len)
+{
+	if (WARN_ON(len > sizeof(sb->s_uuid)))
+		len = sizeof(sb->s_uuid);
+	sb->s_uuid_len = len;
+	memcpy(&sb->s_uuid, uuid, len);
+}
+
 extern int current_umask(void);
 
 extern void ihold(struct inode * inode);
diff --git a/mm/shmem.c b/mm/shmem.c
index d7c84ff62186..be41955e52da 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4355,7 +4355,9 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 #ifdef CONFIG_TMPFS_POSIX_ACL
 	sb->s_flags |= SB_POSIXACL;
 #endif
-	uuid_gen(&sb->s_uuid);
+	uuid_t uuid;
+	uuid_gen(&uuid);
+	super_set_uuid(sb, uuid.b, sizeof(uuid));
 
 #ifdef CONFIG_TMPFS_QUOTA
 	if (ctx->seen & SHMEM_SEEN_QUOTA) {
-- 
2.43.0


