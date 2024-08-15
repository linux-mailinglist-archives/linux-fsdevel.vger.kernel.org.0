Return-Path: <linux-fsdevel+bounces-26045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D50952C18
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 12:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E1BC1C20F91
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 10:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AB9201273;
	Thu, 15 Aug 2024 09:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="swk7a10k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A9B200127
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2024 09:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723713899; cv=none; b=r2sP1WyG8AmXvwb16jJGw/6KITkgOnInOQpllOk9NUHQvlTaRd5Bh7JpGEwf/0xxDJobPrZuSF14UEXTG5kpK9JJleksSReAMHzLu6kVDnfEDgITvCFp8yzwAIW+490lTI651m4ssesSAfPUNDnulSKWBqoiBGK/fCdYwQG6pTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723713899; c=relaxed/simple;
	bh=No6OwevU+qxY4W/s/DWsEFKfEe7pGU5C8qXdUs/4/SQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j0trqqjyJRD72xYr/Iyu4cisUQJZBVmSfmhxbIsx3ocXu75OVLbXigW/yETEcuxFVCzge4MmFf85rs5fgtD6Cn/8IrgOi0QN04cLF1XyNLiDPT50xrQVM5nocOQ/cXgVqgzo0Beu2iGgDc/GuT9MxQtLcmSXh7Y0ZclK04tgOpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=swk7a10k; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D49973F366
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2024 09:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723713895;
	bh=xaypcV2UJPM2r0pQHUTFWnnOJyltujHG9QByRfl37as=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=swk7a10kWqI6Y0/Y/1X74iZrOGzIWwaRRv1NZqKaGFw4Ml6Yv2lcczolgFbTbZdsp
	 CtPhff21vzAln3D7aGA8vGfVxehJmLD3vueIiVXfh3KpjCQZjJUfzN/656yx+Thm0t
	 bMvzJX9zZ+chqWANFQz8+y4jGU9t+VLcCedHFBrAE2uD/SvyPY2vZF7ovi2BLtCorM
	 2MjOxtaly4hLrlCeq8sc0DaVUwfVjxFqDb2YxfcnIB7YjtXKzLyuVjUAMv4Fi1zDaq
	 mCguC8QlzHemM1ROlZpU175/CR2Lh8tjZf/l7hQSsxSRscbB+0SmX93h18g/KXpAFj
	 2H0l4C13JoLRA==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a7a9761bf6dso73565066b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2024 02:24:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723713895; x=1724318695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xaypcV2UJPM2r0pQHUTFWnnOJyltujHG9QByRfl37as=;
        b=ReTuA0rQXZepGA5Dalktfw8vDp9C8I/FwEHLkJEVkjfvBT4XJxr+0Yag7Mb0OyXgu6
         b5MBjiQPLTZndgihsfJE0nUHvp8inAGxdOpaS9FvLBa/VtTAHHPFtufp7+TF9L9vwgKQ
         vL227R6zrCJ6f2+lwra/2HYGDZ/ljoWYLHFIENlwxq9E5vBUtAFlY2s4tFwmW4KVJm0L
         qQNyHQSCsHO7/LKxtth4eOKd9ouB+wtlyDcNsBwfN0ns1SCA78JW3weB95MKA5BlgTlm
         Ivoo8D2mQkttNz5QOJ4gTz+H0e1iVhiPWsPmxvLrcq13Z5X5aJ9uMLLhfE+CsV4wZxVb
         rLdg==
X-Forwarded-Encrypted: i=1; AJvYcCVEwPR3UFAhsIHfiJYfOUBXF6Me8RNwn2CcemivFm0g9kq/h2waoOGDPoCRI+JkndVrVo5B35rl4oskW34Ngk7Q0cakvH5zxU6qTX2sUQ==
X-Gm-Message-State: AOJu0YzUTxAd6I5SkLghPYZNQm6jzSz4FSNADSJVYOWgxcn2T5MjYpWZ
	4rU8AKVdVXg2Bg+Y+saX1mEX2XMC9xAqronXl3Bx178+gsh7cBQN2T2B6s8PrYys9f391L33DPz
	NIGalDuV3MdEMuIBWGsTYyNObayDu0H5uqVEn2idk514kTWZvOy2hIVP6gzIuTeteWM5q57VuK9
	j1gGw=
X-Received: by 2002:a17:906:d7d9:b0:a80:f79a:10c9 with SMTP id a640c23a62f3a-a8366c387e8mr373890266b.12.1723713895288;
        Thu, 15 Aug 2024 02:24:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUDE6UeM03+0fYWSQvu+kTAfAhwxSnFGl4olPqV1KLax6wyKK7710ZFz/zECKrL7s7mRsrjg==
X-Received: by 2002:a17:906:d7d9:b0:a80:f79a:10c9 with SMTP id a640c23a62f3a-a8366c387e8mr373889366b.12.1723713894907;
        Thu, 15 Aug 2024 02:24:54 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383934585sm72142866b.107.2024.08.15.02.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 02:24:54 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: mszeredi@redhat.com
Cc: brauner@kernel.org,
	stgraber@stgraber.org,
	linux-fsdevel@vger.kernel.org,
	Seth Forshee <sforshee@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/11] fs/fuse: support idmapped getattr inode op
Date: Thu, 15 Aug 2024 11:24:21 +0200
Message-Id: <20240815092429.103356-5-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815092429.103356-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240815092429.103356-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have to:
- pass an idmapping to the generic_fillattr()
to properly handle UIG/GID mapping for the userspace.
- pass -/- to fuse_fillattr() (analog of generic_fillattr() in fuse).

Difference between these two is that generic_fillattr() takes all
the stat() data from the inode directly, while fuse_fillattr() codepath
takes a fresh data just from the userspace reply on the FUSE_GETATTR request.

In some cases we can just pass &nop_mnt_idmap, because idmapping won't
be used in these codepaths. For example, when 3rd argument of fuse_do_getattr()
is NULL then idmap argument is not used.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: <linux-fsdevel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
v2:
	- pass idmap in more cases to make code easier to understand
---
 fs/fuse/dir.c | 44 ++++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 1e45c6157af4..a5bf8c18a0ae 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1157,18 +1157,22 @@ static int fuse_link(struct dentry *entry, struct inode *newdir,
 	return err;
 }
 
-static void fuse_fillattr(struct inode *inode, struct fuse_attr *attr,
-			  struct kstat *stat)
+static void fuse_fillattr(struct mnt_idmap *idmap, struct inode *inode,
+			  struct fuse_attr *attr, struct kstat *stat)
 {
 	unsigned int blkbits;
 	struct fuse_conn *fc = get_fuse_conn(inode);
+	vfsuid_t vfsuid = make_vfsuid(idmap, fc->user_ns,
+				      make_kuid(fc->user_ns, attr->uid));
+	vfsgid_t vfsgid = make_vfsgid(idmap, fc->user_ns,
+				      make_kgid(fc->user_ns, attr->gid));
 
 	stat->dev = inode->i_sb->s_dev;
 	stat->ino = attr->ino;
 	stat->mode = (inode->i_mode & S_IFMT) | (attr->mode & 07777);
 	stat->nlink = attr->nlink;
-	stat->uid = make_kuid(fc->user_ns, attr->uid);
-	stat->gid = make_kgid(fc->user_ns, attr->gid);
+	stat->uid = vfsuid_into_kuid(vfsuid);
+	stat->gid = vfsgid_into_kgid(vfsgid);
 	stat->rdev = inode->i_rdev;
 	stat->atime.tv_sec = attr->atime;
 	stat->atime.tv_nsec = attr->atimensec;
@@ -1207,8 +1211,8 @@ static void fuse_statx_to_attr(struct fuse_statx *sx, struct fuse_attr *attr)
 	attr->blksize = sx->blksize;
 }
 
-static int fuse_do_statx(struct inode *inode, struct file *file,
-			 struct kstat *stat)
+static int fuse_do_statx(struct mnt_idmap *idmap, struct inode *inode,
+			 struct file *file, struct kstat *stat)
 {
 	int err;
 	struct fuse_attr attr;
@@ -1261,15 +1265,15 @@ static int fuse_do_statx(struct inode *inode, struct file *file,
 		stat->result_mask = sx->mask & (STATX_BASIC_STATS | STATX_BTIME);
 		stat->btime.tv_sec = sx->btime.tv_sec;
 		stat->btime.tv_nsec = min_t(u32, sx->btime.tv_nsec, NSEC_PER_SEC - 1);
-		fuse_fillattr(inode, &attr, stat);
+		fuse_fillattr(idmap, inode, &attr, stat);
 		stat->result_mask |= STATX_TYPE;
 	}
 
 	return 0;
 }
 
-static int fuse_do_getattr(struct inode *inode, struct kstat *stat,
-			   struct file *file)
+static int fuse_do_getattr(struct mnt_idmap *idmap, struct inode *inode,
+			   struct kstat *stat, struct file *file)
 {
 	int err;
 	struct fuse_getattr_in inarg;
@@ -1308,15 +1312,15 @@ static int fuse_do_getattr(struct inode *inode, struct kstat *stat,
 					       ATTR_TIMEOUT(&outarg),
 					       attr_version);
 			if (stat)
-				fuse_fillattr(inode, &outarg.attr, stat);
+				fuse_fillattr(idmap, inode, &outarg.attr, stat);
 		}
 	}
 	return err;
 }
 
-static int fuse_update_get_attr(struct inode *inode, struct file *file,
-				struct kstat *stat, u32 request_mask,
-				unsigned int flags)
+static int fuse_update_get_attr(struct mnt_idmap *idmap, struct inode *inode,
+				struct file *file, struct kstat *stat,
+				u32 request_mask, unsigned int flags)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_conn *fc = get_fuse_conn(inode);
@@ -1347,17 +1351,17 @@ static int fuse_update_get_attr(struct inode *inode, struct file *file,
 		forget_all_cached_acls(inode);
 		/* Try statx if BTIME is requested */
 		if (!fc->no_statx && (request_mask & ~STATX_BASIC_STATS)) {
-			err = fuse_do_statx(inode, file, stat);
+			err = fuse_do_statx(idmap, inode, file, stat);
 			if (err == -ENOSYS) {
 				fc->no_statx = 1;
 				err = 0;
 				goto retry;
 			}
 		} else {
-			err = fuse_do_getattr(inode, stat, file);
+			err = fuse_do_getattr(idmap, inode, stat, file);
 		}
 	} else if (stat) {
-		generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
+		generic_fillattr(idmap, request_mask, inode, stat);
 		stat->mode = fi->orig_i_mode;
 		stat->ino = fi->orig_ino;
 		if (test_bit(FUSE_I_BTIME, &fi->state)) {
@@ -1371,7 +1375,7 @@ static int fuse_update_get_attr(struct inode *inode, struct file *file,
 
 int fuse_update_attributes(struct inode *inode, struct file *file, u32 mask)
 {
-	return fuse_update_get_attr(inode, file, NULL, mask, 0);
+	return fuse_update_get_attr(&nop_mnt_idmap, inode, file, NULL, mask, 0);
 }
 
 int fuse_reverse_inval_entry(struct fuse_conn *fc, u64 parent_nodeid,
@@ -1515,7 +1519,7 @@ static int fuse_perm_getattr(struct inode *inode, int mask)
 		return -ECHILD;
 
 	forget_all_cached_acls(inode);
-	return fuse_do_getattr(inode, NULL, NULL);
+	return fuse_do_getattr(&nop_mnt_idmap, inode, NULL, NULL);
 }
 
 /*
@@ -2094,7 +2098,7 @@ static int fuse_setattr(struct mnt_idmap *idmap, struct dentry *entry,
 			 * ia_mode calculation may have used stale i_mode.
 			 * Refresh and recalculate.
 			 */
-			ret = fuse_do_getattr(inode, NULL, file);
+			ret = fuse_do_getattr(idmap, inode, NULL, file);
 			if (ret)
 				return ret;
 
@@ -2151,7 +2155,7 @@ static int fuse_getattr(struct mnt_idmap *idmap,
 		return -EACCES;
 	}
 
-	return fuse_update_get_attr(inode, NULL, stat, request_mask, flags);
+	return fuse_update_get_attr(idmap, inode, NULL, stat, request_mask, flags);
 }
 
 static const struct inode_operations fuse_dir_inode_operations = {
-- 
2.34.1


