Return-Path: <linux-fsdevel+bounces-11045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDE98503C8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Feb 2024 11:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2A5A1F23341
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Feb 2024 10:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6306E364AC;
	Sat, 10 Feb 2024 10:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lH9UT/Fc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293E13FF4
	for <linux-fsdevel@vger.kernel.org>; Sat, 10 Feb 2024 10:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707559613; cv=none; b=MVr0f92i2JWim5q2QfV2NIcRlmiWa75ftMwdLg20Wmt1Oiz0gs8it3MFsrX/6KIItpOD0AyKekKwTveOEnLgMUlSVPPBc1ghdib1AnjxBF6P8Lxp5bB9bqs6bcdKmARViAf5BVzOp6v95L+azexnrt8NEk+cHZrC/Fj/SOUCY/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707559613; c=relaxed/simple;
	bh=4cxdB4Uv9nD/EY/k02/VTju42hj9QO5eshudCnuJVz4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rf1qdAlXypdTiSQky5HnRF5a4R8bHLu4I7wO2eyaM7ziwDXe04bCyK9QbmISDd6DGoK69SFCp91axUyrY2U0jEEBJT0ZMVRFgE0Er8oALx2ue3rqdZjlnG3ejFRHfProWk4Y1adrnTRlhRp2MTY5S0iaknm+RDg4uTLjcDA9S4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lH9UT/Fc; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3392b12dd21so935089f8f.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Feb 2024 02:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707559610; x=1708164410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1OeKp4hItBg+Wx9ixJ7goS/W0BoB9IHS5clqqGWuYFo=;
        b=lH9UT/FcPs/nIHF1017zh9xyKEcz1VVVJA5XYGKy8FvmKgauf1NwoPvisuKPtBgsgA
         uAHGPFxnBYB+SKBBXScbkp+Ta6tbSosV573NhZMLZZRw1UEgWeEgFihHHXBD7GjRJHfU
         lOXR39KuoSvp75M4LbD8B/6e8xyIXgysAhzn6XKeutkjggDXLH1UcQvdc7gu6MAphkFo
         XWEgf8fn7c0OTksuY76kUadj1yFkJhyrO2TrBnks35dVZ4eazzgxCcbB4nwzKNUDwqOt
         MyJIKFmEcRlOo3wxmIQJ3tOQx/ugweCPHEjZ0rdFRWr0so3q9xHy/6qtVC+DkIKmrMa0
         K/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707559610; x=1708164410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1OeKp4hItBg+Wx9ixJ7goS/W0BoB9IHS5clqqGWuYFo=;
        b=ovJGOjzmhMXC5uA1c42buRWny61bosu9i1+NHygWqk93XnAl1X5NfqP8DScBt5N13H
         JHqbk/bk4PKil7iQiH58+2PUQPdyVLDRQFBruNAiDU/1czaWqLAfVKhiHm/aqWBi8zOi
         h3LH4bChe9ukjRv/B1M6/sDdpvylAePUMNidTWuUxwVPecp+RiOYNeyrcc/k1OidLy9q
         X/DazRKYtLbea0tAucAXep5PITO9n92tUwD/b6gzgiCad/OBcVpkm3f9R+EjB7+XV73g
         7tc8iEsdlqp4ZRBr6H0xe7LjiTcDqD9hYaRmqyvUblrszrh0p+MYf3YOJAmWgsIDPQlU
         0Xhg==
X-Forwarded-Encrypted: i=1; AJvYcCVU3YZqpHuZHM7+nM2YqrFfgAxVDip7w9kuQur1ybpgKimPszozioYEv26nCJ03jy7i/jyC8RhPbSdqd9g1XegfMf62hR/W3USU4owEbw==
X-Gm-Message-State: AOJu0YxEfoWTBsKbFnC64Ju5QkuG+SDDbckiqj8VzyVyUJXXeFgg1NHr
	zJQMdqIP/RYDRwH3PnSk2B8HJROpIIynpHtpyXtop+2Rcra/kVUv
X-Google-Smtp-Source: AGHT+IFmDrfpGd7yuJCUrN4IltCrnm6VM8ZtY6M4MXnheDL5tNFAzMlfDh+YUqIzTgp/lJJ9fo6slw==
X-Received: by 2002:a05:6000:1002:b0:33b:39d6:666d with SMTP id a2-20020a056000100200b0033b39d6666dmr986485wrx.36.1707559609522;
        Sat, 10 Feb 2024 02:06:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUR50No3HcUuHpqH3GwhkmhI2MSRYKNqAxiL5MjqahH5UcRXUdyojguyvyRAB9nPNsOZmNgfXAqwUT4I+J7+OVWMFH4QR3B6//jiQLUsg==
Received: from amir-ThinkPad-T480.lan (85-250-217-151.bb.netvision.net.il. [85.250.217.151])
        by smtp.gmail.com with ESMTPSA id p13-20020a5d4e0d000000b0033b4b1d180esm1456334wrt.43.2024.02.10.02.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 02:06:48 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] dcache: rename d_genocide()
Date: Sat, 10 Feb 2024 12:06:43 +0200
Message-Id: <20240210100643.2207350-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Political context aside, using analogies from the real world in code
is supposed to help us human programmers understand the code better.

In the case of d_genocide(), not only is it a very dark analogy, but it's
also a bad one, because d_genocide() does not actually kill any dentries.

Rename it to dput_dcache_for_umount() and rename the DCACHE_GENOCIDE
flag to DCACHE_SB_DYING.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Al,

I am not usually for PC culture and I know that you are on team
"freedom of speech" ;-), but IMO this one stood out for its high ratio
of bad taste vs. usefulness.

The patch is based on your revert of "get rid of DCACHE_GENOCIDE".
I was hoping that you could queue my patch along with the revert.

BTW, why was d_genocide() only dropping refcounts on the s_root tree
and not on the s_roots trees like shrink_dcache_for_umount()?
Is it because dentries on s_roots are not supposed to be hashed?

Thanks,
Amir.

 fs/dcache.c            | 13 ++++++++-----
 fs/internal.h          |  2 +-
 fs/super.c             |  3 +--
 include/linux/dcache.h |  2 +-
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 6ebccba33336..61ecc98c49a8 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -3054,24 +3054,27 @@ bool is_subdir(struct dentry *new_dentry, struct dentry *old_dentry)
 }
 EXPORT_SYMBOL(is_subdir);
 
-static enum d_walk_ret d_genocide_kill(void *data, struct dentry *dentry)
+/* make umount_check() happy before killing sb */
+static enum d_walk_ret dput_for_umount(void *data, struct dentry *dentry)
 {
 	struct dentry *root = data;
 	if (dentry != root) {
 		if (d_unhashed(dentry) || !dentry->d_inode)
 			return D_WALK_SKIP;
 
-		if (!(dentry->d_flags & DCACHE_GENOCIDE)) {
-			dentry->d_flags |= DCACHE_GENOCIDE;
+		if (!(dentry->d_flags & DCACHE_SB_DYING)) {
+			dentry->d_flags |= DCACHE_SB_DYING;
 			dentry->d_lockref.count--;
 		}
 	}
 	return D_WALK_CONTINUE;
 }
 
-void d_genocide(struct dentry *parent)
+/* drop last references before shrink_dcache_for_umount() */
+void dput_dcache_for_umount(struct super_block *sb)
 {
-	d_walk(parent, parent, d_genocide_kill);
+	if (sb->s_root)
+		d_walk(sb->s_root, sb->s_root, dput_for_umount);
 }
 
 void d_mark_tmpfile(struct file *file, struct inode *inode)
diff --git a/fs/internal.h b/fs/internal.h
index b67406435fc0..27bda8a3ff9d 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -215,10 +215,10 @@ extern char *simple_dname(struct dentry *, char *, int);
 extern void dput_to_list(struct dentry *, struct list_head *);
 extern void shrink_dentry_list(struct list_head *);
 extern void shrink_dcache_for_umount(struct super_block *);
+extern void dput_dcache_for_umount(struct super_block *);
 extern struct dentry *__d_lookup(const struct dentry *, const struct qstr *);
 extern struct dentry *__d_lookup_rcu(const struct dentry *parent,
 				const struct qstr *name, unsigned *seq);
-extern void d_genocide(struct dentry *);
 
 /*
  * pipe.c
diff --git a/fs/super.c b/fs/super.c
index d35e85295489..42b3189fbe06 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1235,8 +1235,7 @@ EXPORT_SYMBOL(kill_anon_super);
 
 void kill_litter_super(struct super_block *sb)
 {
-	if (sb->s_root)
-		d_genocide(sb->s_root);
+	dput_dcache_for_umount(sb);
 	kill_anon_super(sb);
 }
 EXPORT_SYMBOL(kill_litter_super);
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index d07cf2f1bb7d..0ce8543b64d7 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -173,7 +173,7 @@ struct dentry_operations {
 #define DCACHE_DONTCACHE		BIT(7) /* Purge from memory on final dput() */
 
 #define DCACHE_CANT_MOUNT		BIT(8)
-#define DCACHE_GENOCIDE			BIT(9)
+#define DCACHE_SB_DYING			BIT(9)
 #define DCACHE_SHRINK_LIST		BIT(10)
 
 #define DCACHE_OP_WEAK_REVALIDATE	BIT(11)
-- 
2.34.1


