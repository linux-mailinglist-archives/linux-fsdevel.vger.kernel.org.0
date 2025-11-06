Return-Path: <linux-fsdevel+bounces-67358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A44DC3D011
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 19:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D67CA3BC140
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 18:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09A9350285;
	Thu,  6 Nov 2025 18:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9zT2uU6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04EC31B828
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 18:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762452077; cv=none; b=ri77m9uNXZ0InrdA6VpDmFTRi5XzDdM3FM2s80SwiI3/zSE6NTjt+Rm4XV677iqIJLM4CzOTYia0oUczE0UwGkiFjAo4CuJqdfC8IvRxMhgkCzmINfBnzIwhMgyzaE0ZHY06FncahVSI7AQBAQIrOfIOvBKJQaQOHHSglEpAWd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762452077; c=relaxed/simple;
	bh=oOyMMLZ0qRc3PnzzdC6IK+8pYe7Vv38imFtGR8cpW38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V+NeoyYMAKl+oGMF7MaQZga3C244VjgxxLROhguR6DczGfQAWXkXbNES9QvxQALnl2s2Hum+UyX4eHufyczTnKtCamvuvMJ96E8tQp8qOwXTxwoduZlzQm5sawcQWkaQaW4L12ntXVuMjtflrOasxob4PFY2bGSgwmmLs3R0+Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9zT2uU6; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b71397df721so205708366b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Nov 2025 10:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762452073; x=1763056873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SRa5Bkp4HIkypmTsErN74ag9T32XRLlOpjNnbQAQA9s=;
        b=A9zT2uU6XxXghMwMahVtpP+c+s+ykCuOrqYTwaPYv2L1B1nS3mSbRlbBcDWJanXvRZ
         tTpcBe32rnHIMGyTzSjklVCOYKMHLOuRQoUoceFJ9LCUkgMugiMWwYRKPj3Oe2GpEs/G
         Tc2rtLuR05qLd6Nvp8ByYSZw7g5LcjN7BbiL4ld2TNZc56rQczyYbV+Twh1eJbYEZD/6
         b3DTmBGc67onhXY2ll/+KOcG9MwQ8qeWDSc0ivzsF0Olaj5EujN6yc60nYYYM4EQLytt
         plySebHCGj3ivUrZWlauHSSxrqX4C69RotWTKnMCJBR/TuOnoxb3GRyCiuGszKRLMsFy
         di/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762452073; x=1763056873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SRa5Bkp4HIkypmTsErN74ag9T32XRLlOpjNnbQAQA9s=;
        b=HFXGEfIkPUl+BEOKIdJHF2uEi0M1/e8SutWnm9WO/eIbm5vWhzttnWPjajrCtNUU0h
         u3MH1DRvzEZ/TGLl77lRx54B7gGoP+iFLd5JNFzbsj01XPQBdNzT9ybqpHYWaDXdATgw
         e60l7/kPCm0TZ9a79a6ntYajNjDoZ/Xx3J7UWCLrFe1CfVL+Qgw3NL6GQv62TfDckGdy
         MxzTR8vMEShB1wYU+MJ7D+1gITyv1WDl9mghHFskL43+xrc/cf9+DbTSloLqQ0y6sMIE
         2f2bIVbrq3hA6TxIVjLC12tBS5s5+X/+fzJD04T9PDA+XrHvOCCC+wT6gMfDhCMVT0OR
         btgg==
X-Forwarded-Encrypted: i=1; AJvYcCWcKF/Ixawq3RKTxqiVtd7fuQImgfbGbF/CvqD6vnhBjLOIYjXDMwZKeE1P/iHoAGHZ/2gHpRRnyLpMklpq@vger.kernel.org
X-Gm-Message-State: AOJu0YxvNMJXjSTNDu21bZHZSdASJbcVHtbkf4GAKjwHkkq8IEjS4sJc
	8kkvJ345Bink+YCugeWIsgbUOqxHfe96XvU1dafqfv7fhgXmrlh9JCKc
X-Gm-Gg: ASbGnctp9ZWZSnDxRF96MzoJEj4g2GhvKKeN36uIcjYaDJTRedPchJW3w0twtLrA/mz
	Ozp2h3s8FcQPYD/5qzRMT20jvIhk8NlycHPUcHx8Yyo9iNUk3kNcorVScRPKDKJUk9vTnRS4svu
	CJoFgMnGyyBHmblXDzoi5TRhJXxelkwEDjWkBjUmWcoRpAUJzxDmpPKPmpgeQSWd+du+J70l859
	cbH2p9EwxXGpiG151T2UHqb1uOR56clbxY0wvXu61MqHJUnKI2f9wkYZxxag9HigWigEhd6U+wI
	DEfd1YvPrDaYolDt519Xa6Aiaqk3y4A4u3bEe862FrFmVw8alt53sPYL9hKGuyFbXLjT0SrcT54
	G66VsHg5GjhLRon3TMVj74tXMRoz8PaWtqZ/qVrC6ZW1ryedQfvuPBa9OCCTAkSEfw5LSSllC5V
	DqiG0KvxNcGMhBX9317kb87Ghh12UOcyHJVNokJAJuu+5dotSh
X-Google-Smtp-Source: AGHT+IE2AEJx1i3yhTZ9qDAocemW2UKSOYSqbVA2llKS1ct13gyN8ychGsIBa2qFngKoaOT2+AjBRw==
X-Received: by 2002:a17:907:7e8b:b0:b6f:9db1:f831 with SMTP id a640c23a62f3a-b72c09e9697mr5366566b.23.1762452073028;
        Thu, 06 Nov 2025 10:01:13 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa0f1bbsm15430466b.65.2025.11.06.10.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 10:01:12 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	tytso@mit.edu,
	torvalds@linux-foundation.org,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 1/4] fs: speed up path lookup with cheaper MAY_EXEC checks
Date: Thu,  6 Nov 2025 19:00:59 +0100
Message-ID: <20251106180103.923856-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106180103.923856-1-mjguzik@gmail.com>
References: <20251106180103.923856-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Vast majority of real-world lookups happen on directories which are
traversable by anyone. Figuring out that this holds for a given inode
can be done when instantiating it or changing permissions, avoiding the
overhead during lookup. Stats below.

A simple microbench of stating /usr/include/linux/fs.h on ext4 in a loop
on Sapphire Rapids (ops/s):
before: 3640352
after:  3797258 (+4%)

Filesystems interested in utilizing the feature call inode_enable_fast_may_exec().

Explicit opt-in is necessary as some filesystems have custom inode
permission check hooks which happen to be of no significance for
MAY_EXEC. With an opt-in we know it can be safely ignored. Otherwise any
inode with such a func present would need to be excluded.

inodes which end up skipping perm checks during kernel build grouped
per-fs (0 means checks executed, 1 means skipped):

@[devpts]:
[0, 1)                 2 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|

@[cgroup2]:
[0, 1)                68 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|

@[tmpfs]:
[0, 1)                84 |@@@@@@@@@                                           |
[1, ...)             451 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|

@[sysfs]:
[0, 1)              4532 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|

@[devtmpfs]:
[0, 1)              3609 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   |
[1, ...)            3790 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|

@[proc]:
[0, 1)             19855 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|

@[ext4]:
[0, 1)            484292 |@@@                                                 |
[1, ...)         7775413 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|

@[btrfs]:
[0, 1)           5628821 |@@@@@                                               |
[1, ...)        52551904 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|

Note that devpts, cgroup2, sysfs and proc are not opting in and thus got
no hits.

gathered with:
bpftrace -e 'kprobe:security_inode_permission { @[str(((struct inode *)arg0)->i_sb->s_type->name)] = lhist(((struct inode *)arg0)->i_opflags & 0x80 ? 1 : 0, 0, 1, 1); }'

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/attr.c          |  1 +
 fs/namei.c         | 95 +++++++++++++++++++++++++++++++++++++++++++++-
 fs/posix_acl.c     |  1 +
 fs/xattr.c         |  1 +
 include/linux/fs.h | 21 +++++++---
 5 files changed, 111 insertions(+), 8 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index 795f231d00e8..572363ff9c6d 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -549,6 +549,7 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
 
 	if (!error) {
 		fsnotify_change(dentry, ia_valid);
+		inode_recalc_fast_may_exec(inode);
 		security_inode_post_setattr(idmap, dentry, ia_valid);
 	}
 
diff --git a/fs/namei.c b/fs/namei.c
index a9f9d0453425..bc4bd9114c49 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -602,6 +602,97 @@ int inode_permission(struct mnt_idmap *idmap,
 }
 EXPORT_SYMBOL(inode_permission);
 
+/**
+ * inode_permission_may_exec - Check traversal right for given inode
+ *
+ * This is a special case routine for may_lookup(). Use inode_permission()
+ * instead even if MAY_EXEC is the only thing you want to check for.
+ */
+static __always_inline int inode_permission_may_exec(struct mnt_idmap *idmap,
+	struct inode *inode, int mask)
+{
+	mask |= MAY_EXEC;
+
+	if (!(READ_ONCE(inode->i_opflags) & IOP_FAST_MAY_EXEC))
+		return inode_permission(idmap, inode, mask);
+
+#ifdef CONFIG_DEBUG_VFS
+	/*
+	 * We expect everyone has the execute permission and that there are no
+	 * acls. For debug purposes we validate this indeed holds.
+	 *
+	 * However, we may be racing against setattr and/or setacl, in which case
+	 * we will have to redo the check with the appropriate lock held to avoid
+	 * false-positives.
+	 */
+	unsigned int mode = READ_ONCE(inode->i_mode);
+
+	VFS_BUG_ON_INODE(!S_ISDIR(mode), inode);
+	if (((mode & 0111) != 0111) || !no_acl_inode(inode)) {
+		/*
+		 * If we are in RCU mode may_lookup() will unlazy and try
+		 * again. Worst case if we are still racing the lock will be
+		 * taken below when we get back here.
+		 */
+		if (mask & MAY_NOT_BLOCK)
+			return -ECHILD;
+		inode_lock(inode);
+		if (inode->i_opflags & IOP_FAST_MAY_EXEC) {
+			VFS_BUG_ON_INODE((inode->i_mode & 0111) != 0111, inode);
+			VFS_BUG_ON_INODE(!no_acl_inode(inode), inode);
+		}
+		inode_unlock(inode);
+		return inode_permission(idmap, inode, mask);
+	}
+#endif
+	return security_inode_permission(inode, mask);
+}
+
+/**
+ * inode_recalc_fast_may_exec - recalc IOP_FAST_MAY_EXEC
+ * @inode: Inode to set/unset the bit on
+ *
+ * To be called if the fs considers the inode eligible for short-circuited
+ * permission checks.
+ */
+void inode_recalc_fast_may_exec(struct inode *inode)
+{
+	unsigned int mode;
+	bool wantbit = false;
+
+	if (!(inode_state_read_once(inode) & I_NEW))
+		lockdep_assert_held_write(&inode->i_rwsem);
+
+	if (!(inode->i_flags & S_CAN_FAST_MAY_EXEC)) {
+		VFS_BUG_ON_INODE(inode->i_opflags & IOP_FAST_MAY_EXEC, inode);
+		return;
+	}
+
+	mode = inode->i_mode;
+	if (!S_ISDIR(mode)) {
+		VFS_BUG_ON_INODE(inode->i_opflags & IOP_FAST_MAY_EXEC, inode);
+		return;
+	}
+
+	if (((mode & 0111) == 0111) && no_acl_inode(inode))
+		wantbit = true;
+
+	if (wantbit) {
+		if (inode->i_opflags & IOP_FAST_MAY_EXEC)
+			return;
+		spin_lock(&inode->i_lock);
+		inode->i_opflags |= IOP_FAST_MAY_EXEC;
+		spin_unlock(&inode->i_lock);
+	} else {
+		if (!(inode->i_opflags & IOP_FAST_MAY_EXEC))
+			return;
+		spin_lock(&inode->i_lock);
+		inode->i_opflags &= ~IOP_FAST_MAY_EXEC;
+		spin_unlock(&inode->i_lock);
+	}
+}
+EXPORT_SYMBOL(inode_recalc_fast_may_exec);
+
 /**
  * path_get - get a reference to a path
  * @path: path to get the reference to
@@ -1855,7 +1946,7 @@ static inline int may_lookup(struct mnt_idmap *idmap,
 	int err, mask;
 
 	mask = nd->flags & LOOKUP_RCU ? MAY_NOT_BLOCK : 0;
-	err = inode_permission(idmap, nd->inode, mask | MAY_EXEC);
+	err = inode_permission_may_exec(idmap, nd->inode, mask);
 	if (likely(!err))
 		return 0;
 
@@ -1870,7 +1961,7 @@ static inline int may_lookup(struct mnt_idmap *idmap,
 	if (err != -ECHILD)	// hard error
 		return err;
 
-	return inode_permission(idmap, nd->inode, MAY_EXEC);
+	return inode_permission_may_exec(idmap, nd->inode, 0);
 }
 
 static int reserve_stack(struct nameidata *nd, struct path *link)
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 4050942ab52f..da27dd536058 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -1135,6 +1135,7 @@ int vfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		error = -EIO;
 	if (!error) {
 		fsnotify_xattr(dentry);
+		inode_recalc_fast_may_exec(inode);
 		security_inode_post_set_acl(dentry, acl_name, kacl);
 	}
 
diff --git a/fs/xattr.c b/fs/xattr.c
index 8851a5ef34f5..917946a7f367 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -235,6 +235,7 @@ int __vfs_setxattr_noperm(struct mnt_idmap *idmap,
 				       size, flags);
 		if (!error) {
 			fsnotify_xattr(dentry);
+			inode_recalc_fast_may_exec(inode);
 			security_inode_post_setxattr(dentry, name, value,
 						     size, flags);
 		}
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 03e450dd5211..4f9962dfe2e6 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -647,13 +647,14 @@ is_uncached_acl(struct posix_acl *acl)
 	return (long)acl & 1;
 }
 
-#define IOP_FASTPERM	0x0001
-#define IOP_LOOKUP	0x0002
-#define IOP_NOFOLLOW	0x0004
-#define IOP_XATTR	0x0008
+#define IOP_FASTPERM		0x0001
+#define IOP_LOOKUP		0x0002
+#define IOP_NOFOLLOW		0x0004
+#define IOP_XATTR		0x0008
 #define IOP_DEFAULT_READLINK	0x0010
-#define IOP_MGTIME	0x0020
-#define IOP_CACHED_LINK	0x0040
+#define IOP_MGTIME		0x0020
+#define IOP_CACHED_LINK		0x0040
+#define IOP_FAST_MAY_EXEC	0x0080
 
 /*
  * Inode state bits.  Protected by inode->i_lock
@@ -2128,6 +2129,7 @@ extern loff_t vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
 #define S_VERITY	(1 << 16) /* Verity file (using fs/verity/) */
 #define S_KERNEL_FILE	(1 << 17) /* File is in use by the kernel (eg. fs/cachefiles) */
 #define S_ANON_INODE	(1 << 19) /* Inode is an anonymous inode */
+#define S_CAN_FAST_MAY_EXEC (1 << 20) /* Inode is eligible for IOP_FAST_MAY_EXEC */
 
 /*
  * Note that nosuid etc flags are inode-specific: setting some file-system
@@ -2904,6 +2906,13 @@ static inline int inode_init_always(struct super_block *sb, struct inode *inode)
 	return inode_init_always_gfp(sb, inode, GFP_NOFS);
 }
 
+void inode_recalc_fast_may_exec(struct inode *);
+static inline void inode_enable_fast_may_exec(struct inode *inode)
+{
+	inode->i_flags |= S_CAN_FAST_MAY_EXEC;
+	inode_recalc_fast_may_exec(inode);
+}
+
 extern void inode_init_once(struct inode *);
 extern void address_space_init_once(struct address_space *mapping);
 extern struct inode * igrab(struct inode *);
-- 
2.48.1


