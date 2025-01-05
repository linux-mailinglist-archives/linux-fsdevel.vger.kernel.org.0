Return-Path: <linux-fsdevel+bounces-38401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2199AA01A90
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jan 2025 17:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01A0A188670E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jan 2025 16:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D728166F3A;
	Sun,  5 Jan 2025 16:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhZjUayE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C83B13D893
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Jan 2025 16:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736094253; cv=none; b=HMBAJPevjO0Q+QSJLw1XIh+sQDGjtSwbF0OLFI0JRocpU5pihmRx9wNjqrGKv3Ye7O7f1JdkJolvuQjwL9FDSmR+U5AOe7lizNj4n12+tkTVmPKM3yBke08+hPxRpexN/cK7r/XJGBDXzoAwXIfXAvbVXjt3YvPx7lZimk7PzFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736094253; c=relaxed/simple;
	bh=fbMCy/OTi6yYm/BOvTRgkzNDREg7AN5kYCZJYnaOVhI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l+5280bhMetiBomGTLa6xdvwX3fX22lpelGCm//HpssAoNDfMhsvLbxZWUcOOKV7Grc5k7o7Y9nIJ/+h3SXPsh5L7+0u/G3+FXmZL+yxZ2gxUfQjZBFQfdd73F78gVQZ3+j5GotMO5RHiG55Zt46htdsdWN1AamUkj+vMR4hgHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhZjUayE; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3862d6d5765so7996968f8f.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Jan 2025 08:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736094250; x=1736699050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7qimU7o0oROFYF1Tm2dVv5of3ktjRvDly3zO6OyRx8=;
        b=fhZjUayEpjhrTuoX4wS6sLwcYg+TpEE8dj9NXVN0GJrGaatJyRWfFR+uVvTNV8jMgw
         eeJ0S13XlvqbkQ3vRILDhBT61gWNLqeNncsWVjW8iacSvYrZrI+hYF/Lke3TrInQ/wL8
         J/qtIbp+aTkRUWtLQ7fPhyLT7yn3AZEpCo8cWJUbZw/b4vSzNlXVh8HC1TxR6912qF3F
         OxvZ6L8NqYI05moSWdRjD1n1ykZ/cXWTLr7phij7TNFQbC6RMCchFi2fHjvetRAY1wJ9
         ubhlHNhLNv3KyuRhiSLnm4P39Uwy7ETTofL9g5NDZOahflUY+WlddwkE8c2K/xzsniEq
         mFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736094250; x=1736699050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X7qimU7o0oROFYF1Tm2dVv5of3ktjRvDly3zO6OyRx8=;
        b=gQrZil2Lhu19i2JwyeMC2ESrVHITe4lI4dS+P1/MmhJ744dXh5BkRXU2h4F2NmoNpf
         Ve+ulTyZxg1as3tJkFs887Yju1rXLKUuz64Yd8SYxT68JT8Vox+1WhN47q1a1S+zk1gZ
         RKQlflqaFlH8k+LdZV+jBEnBN64MQwfbsrcWxynF4EK1ITwgiZrgFx01xf7VwXG5ypNz
         RWFX5WwnwQpvr1tuGJCjEiCTd6+g/XXR3pmYMBIKUkSGNn3P7WxjjRB2Ta745a3fINHk
         8eswIcLftCSs0seRyStYbxkducYOtebonoU3E+gd/Sy9UNaLQdBpe+LhrSwETQmQ6Fdn
         vwog==
X-Forwarded-Encrypted: i=1; AJvYcCWCqgjYz4/ATpo4DzMBUuoQiLo+QOt1CChDRV3YbCCNETyudg9uu3gS7diwewv+k5PnceQ9j0/9iqKdap58@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm4+utjqACA2nIufhyhZoV93t0i7m8YY/wzqBetcN11MihVyjG
	xC+2lqhlRp3JAt8Eep+zpdJw6zvVTE71Ly+Uzh/BXNHD1bhFTNnC
X-Gm-Gg: ASbGnctbFu7U0XYVKskvT/CuKCLImjhwYkS302FgO3SqyyE8DqeqObnj5YL4G6M+Iiv
	lrr+2afWfgdHZplzXqvcWJ7WCMPpMnvId3donf9QJr/Foca2fAkc7Dt7sToTjqMmbi2PKzYEpim
	v78o8ivbti4C/0qazoK/zaiq5jrDt7+aj/ViuM1FvPEZv1DLhBkZ8cGheF3oI6tOKGEl4r2vM+K
	Lb7h3OkO/oMB+ZxswvFdTAbB1km7wx0ax68VmkLA9YVAHCSy7+h0VuQrX8zhjHe7/Z7Am87Be0f
	X2E8h2axpWekgC74WOiO4m7c5JmgkhRSKo9qPI3UkYtDJfXALw29cA==
X-Google-Smtp-Source: AGHT+IGkP4ET4ie1Q/a3Ws2Y8imL5PIZi/RczoaPq05YvNvqqGBzH1awyDAGNkPNzFS3fKDQVQA5Rw==
X-Received: by 2002:a05:6000:4024:b0:385:f6b9:e750 with SMTP id ffacd0b85a97d-38a221f31a9mr39657410f8f.9.1736094249885;
        Sun, 05 Jan 2025 08:24:09 -0800 (PST)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436612008b1sm538372765e9.15.2025.01.05.08.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 08:24:09 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] ovl: pass realinode to ovl_encode_real_fh() instead of realdentry
Date: Sun,  5 Jan 2025 17:24:03 +0100
Message-Id: <20250105162404.357058-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250105162404.357058-1-amir73il@gmail.com>
References: <20250105162404.357058-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We want to be able to encode an fid from an inode with no alias.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/copy_up.c   | 11 ++++++-----
 fs/overlayfs/export.c    |  5 +++--
 fs/overlayfs/namei.c     |  4 ++--
 fs/overlayfs/overlayfs.h |  2 +-
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 56eee9f23ea9a..0c28e5fa34077 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -415,13 +415,13 @@ int ovl_set_attr(struct ovl_fs *ofs, struct dentry *upperdentry,
 	return err;
 }
 
-struct ovl_fh *ovl_encode_real_fh(struct ovl_fs *ofs, struct dentry *real,
+struct ovl_fh *ovl_encode_real_fh(struct ovl_fs *ofs, struct inode *realinode,
 				  bool is_upper)
 {
 	struct ovl_fh *fh;
 	int fh_type, dwords;
 	int buflen = MAX_HANDLE_SZ;
-	uuid_t *uuid = &real->d_sb->s_uuid;
+	uuid_t *uuid = &realinode->i_sb->s_uuid;
 	int err;
 
 	/* Make sure the real fid stays 32bit aligned */
@@ -438,7 +438,8 @@ struct ovl_fh *ovl_encode_real_fh(struct ovl_fs *ofs, struct dentry *real,
 	 * the price or reconnecting the dentry.
 	 */
 	dwords = buflen >> 2;
-	fh_type = exportfs_encode_fh(real, (void *)fh->fb.fid, &dwords, 0);
+	fh_type = exportfs_encode_inode_fh(realinode, (void *)fh->fb.fid,
+					   &dwords, NULL, 0);
 	buflen = (dwords << 2);
 
 	err = -EIO;
@@ -479,7 +480,7 @@ struct ovl_fh *ovl_get_origin_fh(struct ovl_fs *ofs, struct dentry *origin)
 	if (!ovl_can_decode_fh(origin->d_sb))
 		return NULL;
 
-	return ovl_encode_real_fh(ofs, origin, false);
+	return ovl_encode_real_fh(ofs, d_inode(origin), false);
 }
 
 int ovl_set_origin_fh(struct ovl_fs *ofs, const struct ovl_fh *fh,
@@ -504,7 +505,7 @@ static int ovl_set_upper_fh(struct ovl_fs *ofs, struct dentry *upper,
 	const struct ovl_fh *fh;
 	int err;
 
-	fh = ovl_encode_real_fh(ofs, upper, true);
+	fh = ovl_encode_real_fh(ofs, d_inode(upper), true);
 	if (IS_ERR(fh))
 		return PTR_ERR(fh);
 
diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
index 5868cb2229552..036c9f39a14d7 100644
--- a/fs/overlayfs/export.c
+++ b/fs/overlayfs/export.c
@@ -223,6 +223,7 @@ static int ovl_check_encode_origin(struct dentry *dentry)
 static int ovl_dentry_to_fid(struct ovl_fs *ofs, struct dentry *dentry,
 			     u32 *fid, int buflen)
 {
+	struct inode *inode = d_inode(dentry);
 	struct ovl_fh *fh = NULL;
 	int err, enc_lower;
 	int len;
@@ -236,8 +237,8 @@ static int ovl_dentry_to_fid(struct ovl_fs *ofs, struct dentry *dentry,
 		goto fail;
 
 	/* Encode an upper or lower file handle */
-	fh = ovl_encode_real_fh(ofs, enc_lower ? ovl_dentry_lower(dentry) :
-				ovl_dentry_upper(dentry), !enc_lower);
+	fh = ovl_encode_real_fh(ofs, enc_lower ? ovl_inode_lower(inode) :
+				ovl_inode_upper(inode), !enc_lower);
 	if (IS_ERR(fh))
 		return PTR_ERR(fh);
 
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 7e27b7d4adee8..cea820cb3b55b 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -542,7 +542,7 @@ int ovl_verify_origin_xattr(struct ovl_fs *ofs, struct dentry *dentry,
 	struct ovl_fh *fh;
 	int err;
 
-	fh = ovl_encode_real_fh(ofs, real, is_upper);
+	fh = ovl_encode_real_fh(ofs, d_inode(real), is_upper);
 	err = PTR_ERR(fh);
 	if (IS_ERR(fh)) {
 		fh = NULL;
@@ -738,7 +738,7 @@ int ovl_get_index_name(struct ovl_fs *ofs, struct dentry *origin,
 	struct ovl_fh *fh;
 	int err;
 
-	fh = ovl_encode_real_fh(ofs, origin, false);
+	fh = ovl_encode_real_fh(ofs, d_inode(origin), false);
 	if (IS_ERR(fh))
 		return PTR_ERR(fh);
 
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index b361f35762be0..0021e20250202 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -865,7 +865,7 @@ int ovl_copy_up_with_data(struct dentry *dentry);
 int ovl_maybe_copy_up(struct dentry *dentry, int flags);
 int ovl_copy_xattr(struct super_block *sb, const struct path *path, struct dentry *new);
 int ovl_set_attr(struct ovl_fs *ofs, struct dentry *upper, struct kstat *stat);
-struct ovl_fh *ovl_encode_real_fh(struct ovl_fs *ofs, struct dentry *real,
+struct ovl_fh *ovl_encode_real_fh(struct ovl_fs *ofs, struct inode *realinode,
 				  bool is_upper);
 struct ovl_fh *ovl_get_origin_fh(struct ovl_fs *ofs, struct dentry *origin);
 int ovl_set_origin_fh(struct ovl_fs *ofs, const struct ovl_fh *fh,
-- 
2.34.1


