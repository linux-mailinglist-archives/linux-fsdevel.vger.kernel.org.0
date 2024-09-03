Return-Path: <linux-fsdevel+bounces-28419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FB996A204
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 17:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 060901F24A14
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 15:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD7618FDD8;
	Tue,  3 Sep 2024 15:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="mUXJOX/J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032C218E349
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 15:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376626; cv=none; b=TKv3VpOJrn5n0NySvjchS4cpxbwV6sn05gvyBj36D29iI8Cfdywrr5yu+8peZWAoYkescCVAwJ6tOKHSEZvn611cIWctZXdemMgb+cnSjI9Ti04p7oHv9iZsATFqCIYHi1LTub3509ob3n3Fbs39OMnV+ohPmE9Y7SELS3y82OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376626; c=relaxed/simple;
	bh=PaAk/eaWHJYrtpeNCjv4dfhLvGaJwWHZoj/fTJYrBoo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dIfkgi1ADZWvTRqFy8XF+xDyHdeVUYVu+12BUJ7fn5OmthQn1vL23NFGa7yRMr2+OKbd+gr+fj/IWTudCkhkx0y7YF21HVYoeuuDlazAHvjit4tSsLqsGV2aeLvF1NEGlgbTEOt/ZtmCccu45Otrmt+VU5llISXUxOK0VWYUsHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=mUXJOX/J; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 002A2402EB
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 15:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725376621;
	bh=oliM0t1YZlK8AQPobnRlPgoF+ATvch875oLL0LQh984=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=mUXJOX/JKEkI6pf610+HoME5lN+pfHYtxlq1Xp7d7nptuITTjpNGJd9qdy6jzcjNz
	 FlCc8Kl6u5QEBFwxv3O624rjIbqlhbSILcwGd0xVPg7LeSWjvisbFRQ/qCiIAcscIc
	 ceFJT40JP7pz2Ji9kbf+UsX5bXThywKxka3+Z37PvjTUKJc8grkD6BApaPNqsU6PNf
	 ujvuuB1nwkZxo2oJnPFlIUEFoiWvPeovJ4f0GNFZ8TrMZO0E0EtPMj6xuoVX/dmxrh
	 BNDUGNJJ23MG1+L6HN7AhlSpuxScK3gUXvFK53FjaidMR1BLOYL2BRaMknJlOJ7O7t
	 x69xJes0JLQVQ==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a7a83fad218so475386466b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2024 08:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725376620; x=1725981420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oliM0t1YZlK8AQPobnRlPgoF+ATvch875oLL0LQh984=;
        b=RaBYE1JeeqxXZbjDS5lbjpOGi+ut1Xj3xGP6R+AZoJqayvwuDzli6+egkRFpl8KRQ2
         bK8yiL/DquTFfFcMN9ZCPf4qE8XgnuJoDG7SyMbWvyehnU6Fs02Mn/RYxMoK6bdg0ODa
         rTcLHw5hhV+TunzyPmt4ZTsexgX2wrV1oMajfsgp4S6oskPk1M6yQ1YyviRwx4g36RD0
         nbqUwZligNO+sfU5MpjPar+cMfuF43jNqO2aNzre9/dJDfWvRrppEro1ftbJPQe8AA+7
         1o0HbQp2xQq12vH99dNKeKSKYyjkisUBWI2foOIxAhq1t56U8AoJ/iWAUpeIv2H7JIo1
         Bigw==
X-Forwarded-Encrypted: i=1; AJvYcCXUkVAN+2RzZzeXX0IBlxpXccE0DOEk3mdBoB61yCSaps3bLEWVX6W0wZDeK465ooB5UdcAJGO2Ol0tQjR2@vger.kernel.org
X-Gm-Message-State: AOJu0YzDSSnCsYF2yKY2nWrqwKURvDmA4q8PcPGroRPll3LjqMAT1Ujg
	3Cay2RcwtY/dUdS8bHyBbT+Thhs9hAfvyvPrWLLpb9WpEjCYSL0tnXwZGjrq9aIvyx5R5oy1JMI
	czq/HIxJIW3GzWhhQhNfIrbr9tPa3Q5ftjV4g0U6t/RiQl7vUakQC/UtSgojzeCU/nuGTtTlEOC
	M3G/A=
X-Received: by 2002:a17:907:1c1e:b0:a86:817e:d27b with SMTP id a640c23a62f3a-a89b96f8b2cmr841923566b.43.1725376620323;
        Tue, 03 Sep 2024 08:17:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPNpw2gqiAzwRWVbg8W7w5mbvdVshWLwdfJpDfVHqfWPAHPWbYqYWDRDznG8ehNU2TzIdLDQ==
X-Received: by 2002:a17:907:1c1e:b0:a86:817e:d27b with SMTP id a640c23a62f3a-a89b96f8b2cmr841921066b.43.1725376619864;
        Tue, 03 Sep 2024 08:16:59 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a19afb108sm156377166b.223.2024.09.03.08.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 08:16:59 -0700 (PDT)
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
Subject: [PATCH v4 06/15] fs/fuse: support idmapped getattr inode op
Date: Tue,  3 Sep 2024 17:16:17 +0200
Message-Id: <20240903151626.264609-7-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903151626.264609-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240903151626.264609-1-aleksandr.mikhalitsyn@canonical.com>
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
Reviewed-by: Christian Brauner <brauner@kernel.org>
---
v2:
	- pass idmap in more cases to make code easier to understand
---
 fs/fuse/dir.c | 44 ++++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 19538b1c12e2..1c28cdf9dd41 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1134,18 +1134,22 @@ static int fuse_link(struct dentry *entry, struct inode *newdir,
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
@@ -1184,8 +1188,8 @@ static void fuse_statx_to_attr(struct fuse_statx *sx, struct fuse_attr *attr)
 	attr->blksize = sx->blksize;
 }
 
-static int fuse_do_statx(struct inode *inode, struct file *file,
-			 struct kstat *stat)
+static int fuse_do_statx(struct mnt_idmap *idmap, struct inode *inode,
+			 struct file *file, struct kstat *stat)
 {
 	int err;
 	struct fuse_attr attr;
@@ -1238,15 +1242,15 @@ static int fuse_do_statx(struct inode *inode, struct file *file,
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
@@ -1285,15 +1289,15 @@ static int fuse_do_getattr(struct inode *inode, struct kstat *stat,
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
@@ -1324,17 +1328,17 @@ static int fuse_update_get_attr(struct inode *inode, struct file *file,
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
@@ -1348,7 +1352,7 @@ static int fuse_update_get_attr(struct inode *inode, struct file *file,
 
 int fuse_update_attributes(struct inode *inode, struct file *file, u32 mask)
 {
-	return fuse_update_get_attr(inode, file, NULL, mask, 0);
+	return fuse_update_get_attr(&nop_mnt_idmap, inode, file, NULL, mask, 0);
 }
 
 int fuse_reverse_inval_entry(struct fuse_conn *fc, u64 parent_nodeid,
@@ -1492,7 +1496,7 @@ static int fuse_perm_getattr(struct inode *inode, int mask)
 		return -ECHILD;
 
 	forget_all_cached_acls(inode);
-	return fuse_do_getattr(inode, NULL, NULL);
+	return fuse_do_getattr(&nop_mnt_idmap, inode, NULL, NULL);
 }
 
 /*
@@ -2071,7 +2075,7 @@ static int fuse_setattr(struct mnt_idmap *idmap, struct dentry *entry,
 			 * ia_mode calculation may have used stale i_mode.
 			 * Refresh and recalculate.
 			 */
-			ret = fuse_do_getattr(inode, NULL, file);
+			ret = fuse_do_getattr(idmap, inode, NULL, file);
 			if (ret)
 				return ret;
 
@@ -2128,7 +2132,7 @@ static int fuse_getattr(struct mnt_idmap *idmap,
 		return -EACCES;
 	}
 
-	return fuse_update_get_attr(inode, NULL, stat, request_mask, flags);
+	return fuse_update_get_attr(idmap, inode, NULL, stat, request_mask, flags);
 }
 
 static const struct inode_operations fuse_dir_inode_operations = {
-- 
2.34.1


