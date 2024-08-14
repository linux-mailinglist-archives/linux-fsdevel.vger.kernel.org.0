Return-Path: <linux-fsdevel+bounces-25903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEC4951A44
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 13:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0099282705
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 11:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801ED1B4C5F;
	Wed, 14 Aug 2024 11:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="SXhJjWd5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108081B4C44
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 11:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723635691; cv=none; b=n2g776Cxx8dzkDhppVEt6gBS+iegzRXUALmUPPdTLSkE313Y+cRRHD3dn1ugyzPSvynsd7RR3dlsbdAo4xw1SOwDjNGlsYilEEJ+tfvTcJwxw0yp853zuulzhUGi08D9iIiU8FbUEdetPPuopzeqysP0GcjCNFy8CubDlXzSkfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723635691; c=relaxed/simple;
	bh=sQYa/TGQk7UO1dlX0MW4Xvi9uLCqrYRQlAcXitEceno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qQuIscR7SNi8M8dYRg8k+30zd83lUaKGwd9PQIU01vP07ntSgGUvZNMUdWhw/QQpvxKMGnobmrgoLBf+/JKmD5jSF4NLflqZsFbED265b2oVmPukP4IhSnvJ4X1ENKo+1zF8EgFU33lWOg/1hIdMMpvjmvP8LIlWuyrcg+zhfi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=SXhJjWd5; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5362E402D8
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 11:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723635688;
	bh=kX3REIljluq5iUQsttUuiM8BSwi4GrOWWl8ceulatPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=SXhJjWd5wEgmDw3hLEFmCaIq5N55DWwuhDeDl3RYjk32yUsKAUxJjv0bjcwSlOwzB
	 wZ69EIYD5K/ct2SdrQxlMsqgKzFKtdbh8M26Wmtc9eiebCpzFYKXHQ0Hn76srmJZZK
	 gyaEK0kPyBlOw6oNrqpEpxyUrApJJctBv44AqRfDZBjlkWMgEL2/Qzz0sY3T+DStJx
	 RwbUz4f0SOBpoMT37v3Ezizcyk8kH2m3dDidHZCWlC69CDPH5ewZMxSIgXZ+uGHuJt
	 hMgg882qbLeTVHeRYQn9FrZqa65MV2lG+IxPxEjRGUJlJRMHFXlo36oxFWJFSsdfqB
	 QaJi5AJTO65sg==
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-52efa034543so7019904e87.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 04:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723635688; x=1724240488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kX3REIljluq5iUQsttUuiM8BSwi4GrOWWl8ceulatPE=;
        b=htA0gWhEZY/m7FUUnrmlbAOA4/jMGZLf9Vove1Qk7DVmURLpJY74d7OBeaWz7khj7Q
         vATVLPJHJdrtLGAizQfbPk1L7a+H8tQb3dzrCt4Uo+uba2p9zJRbnXx5d5lJybfxv/hK
         sl4wFY7vD3RWR1zZK7TDeIOmY2cQyMgl0EmkaD43aT4Wr1i2rzJzABeVHEtvQihok7Ss
         LPjdH/HBl8yoVI98tCKNaZnVVMXQo1692CUyQelOApu5p6EYdnshw+fE+vZbCh1guEOO
         OLkbVlvwozdQslbhqUbporyzo6tIFl1tRhGQdZYzQcrMqCMTXSgpNXeAJYp3OjrJpddw
         57rg==
X-Forwarded-Encrypted: i=1; AJvYcCWQ6kIutc1S6AmIcQZ2+hsOIjfcZ3OZ0ZXePXnMXKzd7d527i1p8+UEriHUHm/EMyanY2fS+K3Amyxowfrv5pXtINh7LwnBjGm/e1pyHg==
X-Gm-Message-State: AOJu0YxHBuZcIwUdI/XLwQHwfKZsTe+QF9SNnSxFsAeEivydNCQKFqJj
	muZgI/AMV5lKmooBIAHzhyrkqeH6xfA6k+5KKLC/ANEmwELvQc3hRd+p7GebvymgLna4jt33YKi
	pOmYScMPLat/LA401GxMRgRoQpTNqswpk12pFPxofA+/pcqhuaLWYhj5ljOg2de6F/u8QdoR5gM
	DNX3Q=
X-Received: by 2002:a05:6512:230a:b0:52e:a63d:e5c1 with SMTP id 2adb3069b0e04-532eda83586mr1580862e87.30.1723635687506;
        Wed, 14 Aug 2024 04:41:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfI4f7MYsqVeqcum/urkA2c8ZrkB367gdfi8exfw6an4iZX6W6jbiZZlbDbsNeu4towZFUWg==
X-Received: by 2002:a05:6512:230a:b0:52e:a63d:e5c1 with SMTP id 2adb3069b0e04-532eda83586mr1580842e87.30.1723635686883;
        Wed, 14 Aug 2024 04:41:26 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3fa782csm162586166b.60.2024.08.14.04.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 04:41:26 -0700 (PDT)
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
Subject: [PATCH v2 3/9] fs/fuse: support idmapped getattr inode op
Date: Wed, 14 Aug 2024 13:40:28 +0200
Message-Id: <20240814114034.113953-4-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814114034.113953-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240814114034.113953-1-aleksandr.mikhalitsyn@canonical.com>
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


