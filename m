Return-Path: <linux-fsdevel+bounces-39764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0754AA17CA6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 12:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A9A67A448C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 11:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA061F1315;
	Tue, 21 Jan 2025 11:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSFv86OF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3199D1F0E2F;
	Tue, 21 Jan 2025 11:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737457706; cv=none; b=hu1Sw63gyFH3tex/QkYywX3eH8X3HI0izj28+Pq3PNdqh5RZMVWb9JIayWg3ZzpUMMyitNMNZqEosjvapPPENJzPn0S1Y+YXLuI5vC9da3WdVMhoFUoZ51FHjPtn+luu+BQ96KHelD65Ve855E7mbo0CfI/B9QvMozBIOxFAueQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737457706; c=relaxed/simple;
	bh=jp56f8BWh9z/u1afhqQoShUMbka///xqJuE1I4ilViA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gS+qh4q5+hpHj6zd6S0ji1XKzWNibBGRdnFTBovwQL+sBvCBVTzhXYf7heLMIiJzEjGEbaPhwY9WyLBGeyszGupkH6SBwW7K6ZxilTo3ZPJ6C7ux46uaVtlEnfVrzhHB3uqPcMuSTxSZZHNQcirLq30n6mDv0lCcPZuq6bqdyJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSFv86OF; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d3e6274015so1875620a12.0;
        Tue, 21 Jan 2025 03:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737457702; x=1738062502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Je/YSRVUAuPF5QcYsg5n92Ibg4t6locRpRpF/v0+2lU=;
        b=XSFv86OF6cj/yde4szZUi2Kki7NiO9tOTO6PL1B6+V4xXWwyTomfXxYjuIgqXBlUs0
         lR5BGofqhm7t8Itfpb+uSeNBm75a6PLHIv4HaojgDFBaPoeyAOUcq7HDF5aEXSEK6ahu
         4j59qwZ10qW27+su0DSYx59wJ4TiE17NL5L+evH6N17k9qIvINtfDocsKjCNAtIXMbWh
         QemRIaKHbpjMg/roM0hAqU0e6mFDnNswIekeDAgFE5vZ6K9j4WC6xyM8zH13qYQ9mkYs
         c1yFvAZvBtSGysuLhwx0aC/CKwPsJnMsz0sLkmJ44OiVn4zS913ioJMZJVsxw2YatCYO
         TGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737457702; x=1738062502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Je/YSRVUAuPF5QcYsg5n92Ibg4t6locRpRpF/v0+2lU=;
        b=vg/ZQaIPCbPdPzuxpqFY4rXUNFqYl8E90Y5vCjDhZhmnKSDZ/nAzQqFbtmKVph1cL9
         QCqcVLACOuFf2rPX2yoA0fKSlMF854BDZrH9MqQV9TgEZNeOQm8LBqrjj+f51WlKD1oy
         GHMNzPCP+tgi+yPB2P3sxsrmLHAdtHfb2/lscM0mbavbYyRai5K4j7mEZzimiLR2Ubky
         /uhDdftKTdl9kzs7K3X3eapZFbh4HbMEjnkmae37Vtvzmo8CXeJjXWzAI32U+g2ZMIl8
         2btniszmZuQJVrNCRlwL87moCN1jBvjYAMYs4c1pGy6lBhcwYgF1m6Bny6lf9ulfrfz4
         9eEg==
X-Forwarded-Encrypted: i=1; AJvYcCW+ovZMmA+AU2EgD0m620EMytMBcsEhYQrjm7YoYKvHQIgJM3AMVA6dOD42fAlnouu1/BSWXBx6@vger.kernel.org, AJvYcCW1hMxlGeR6a5TEQIeHA4do7PFqlqpFwXlO/1mGHP2e0RQjwUFUAvKHhhfzxYlBZJToh1+txL30zp8RqWg+Fw==@vger.kernel.org, AJvYcCXFCU6FDPQpxCGlBBT3+OuMScvCS+3aLm42kC9CJhgcAHKyRW1W9l6bKM3muI9/OMSFpYc7TLm4PkPuNAH3@vger.kernel.org
X-Gm-Message-State: AOJu0YzQB5MlL/Pjb8lMX46ITGjly1opQDYiYzhFoHJ5yMFoPFP4xktX
	1QJze8yRTYiR1ni6zFACu80MYm30z0DG8GB6DvD2o6BYqKU/e4FU
X-Gm-Gg: ASbGncvyEXOcfJYhxU3QIPisMed67HQctni6fgGfnABZDuO/jmEuIufL19Be8HgfRFC
	uPqW0T9XkTbQQHQdlFRKwCm0evYLAuGjaWXG12tiF9Lk9505UILcAbsysn9A0/szjJl43uHa3+a
	a9TFcBp554hR61oTAzinHwvQET+y7RKEAe9vBHRo2x9WmwQRXEuJqTppC2m0ZdgmH/+6PnLYYs1
	gWR/RQNJ2d4TSuplNU9hlNrspKiPmX40MBelo3BGdcd4XymLvG1tZO8tbKdeGbuftUOuQVVDdyH
	yQaSBn/zK0IegLPiiDe8GrtFlEkEmyHjZNTk5cf0dR5hDHv82oxKOzr/5m63JnTraOI=
X-Google-Smtp-Source: AGHT+IHLU1ze4A2g1D9j9Xipxs9AzyGCl+JxKmNjXrO91RHcTVMPAgn+qJ51tFWAVVWRUiRL2tMKoA==
X-Received: by 2002:a05:6402:2342:b0:5db:67a7:e742 with SMTP id 4fb4d7f45d1cf-5db7d2f947dmr14488920a12.8.1737457701899;
        Tue, 21 Jan 2025 03:08:21 -0800 (PST)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5db73683d28sm7209841a12.40.2025.01.21.03.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 03:08:20 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Jan Kara <jack@suse.cz>,
	Dmitry Safonov <dima@arista.com>,
	Ignat Korchagin <ignat@cloudflare.com>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	stable@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 6.6 1/3] ovl: pass realinode to ovl_encode_real_fh() instead of realdentry
Date: Tue, 21 Jan 2025 12:08:13 +0100
Message-Id: <20250121110815.416785-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250121110815.416785-1-amir73il@gmail.com>
References: <20250121110815.416785-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 07aeefae7ff44d80524375253980b1bdee2396b0 ]

We want to be able to encode an fid from an inode with no alias.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Link: https://lore.kernel.org/r/20250105162404.357058-2-amir73il@gmail.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: c45beebfde34 ("ovl: support encoding fid from inode with no alias")
Signed-off-by: Sasha Levin <sashal@kernel.org>
[re-applied over v6.6.71 with conflict resolved]
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/copy_up.c   | 11 ++++++-----
 fs/overlayfs/export.c    |  5 +++--
 fs/overlayfs/namei.c     |  4 ++--
 fs/overlayfs/overlayfs.h |  2 +-
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index ada3fcc9c6d50..e97bcf15c689c 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -371,13 +371,13 @@ int ovl_set_attr(struct ovl_fs *ofs, struct dentry *upperdentry,
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
@@ -394,7 +394,8 @@ struct ovl_fh *ovl_encode_real_fh(struct ovl_fs *ofs, struct dentry *real,
 	 * the price or reconnecting the dentry.
 	 */
 	dwords = buflen >> 2;
-	fh_type = exportfs_encode_fh(real, (void *)fh->fb.fid, &dwords, 0);
+	fh_type = exportfs_encode_inode_fh(realinode, (void *)fh->fb.fid,
+					   &dwords, NULL, 0);
 	buflen = (dwords << 2);
 
 	err = -EIO;
@@ -438,7 +439,7 @@ int ovl_set_origin(struct ovl_fs *ofs, struct dentry *lower,
 	 * up and a pure upper inode.
 	 */
 	if (ovl_can_decode_fh(lower->d_sb)) {
-		fh = ovl_encode_real_fh(ofs, lower, false);
+		fh = ovl_encode_real_fh(ofs, d_inode(lower), false);
 		if (IS_ERR(fh))
 			return PTR_ERR(fh);
 	}
@@ -461,7 +462,7 @@ static int ovl_set_upper_fh(struct ovl_fs *ofs, struct dentry *upper,
 	const struct ovl_fh *fh;
 	int err;
 
-	fh = ovl_encode_real_fh(ofs, upper, true);
+	fh = ovl_encode_real_fh(ofs, d_inode(upper), true);
 	if (IS_ERR(fh))
 		return PTR_ERR(fh);
 
diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
index 611ff567a1aa6..c56e4e0b8054c 100644
--- a/fs/overlayfs/export.c
+++ b/fs/overlayfs/export.c
@@ -228,6 +228,7 @@ static int ovl_check_encode_origin(struct dentry *dentry)
 static int ovl_dentry_to_fid(struct ovl_fs *ofs, struct dentry *dentry,
 			     u32 *fid, int buflen)
 {
+	struct inode *inode = d_inode(dentry);
 	struct ovl_fh *fh = NULL;
 	int err, enc_lower;
 	int len;
@@ -241,8 +242,8 @@ static int ovl_dentry_to_fid(struct ovl_fs *ofs, struct dentry *dentry,
 		goto fail;
 
 	/* Encode an upper or lower file handle */
-	fh = ovl_encode_real_fh(ofs, enc_lower ? ovl_dentry_lower(dentry) :
-				ovl_dentry_upper(dentry), !enc_lower);
+	fh = ovl_encode_real_fh(ofs, enc_lower ? ovl_inode_lower(inode) :
+				ovl_inode_upper(inode), !enc_lower);
 	if (IS_ERR(fh))
 		return PTR_ERR(fh);
 
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 80391c687c2ad..273a39d3e9513 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -523,7 +523,7 @@ int ovl_verify_set_fh(struct ovl_fs *ofs, struct dentry *dentry,
 	struct ovl_fh *fh;
 	int err;
 
-	fh = ovl_encode_real_fh(ofs, real, is_upper);
+	fh = ovl_encode_real_fh(ofs, d_inode(real), is_upper);
 	err = PTR_ERR(fh);
 	if (IS_ERR(fh)) {
 		fh = NULL;
@@ -720,7 +720,7 @@ int ovl_get_index_name(struct ovl_fs *ofs, struct dentry *origin,
 	struct ovl_fh *fh;
 	int err;
 
-	fh = ovl_encode_real_fh(ofs, origin, false);
+	fh = ovl_encode_real_fh(ofs, d_inode(origin), false);
 	if (IS_ERR(fh))
 		return PTR_ERR(fh);
 
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 09ca82ed0f8ce..981967e507b3e 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -821,7 +821,7 @@ int ovl_copy_up_with_data(struct dentry *dentry);
 int ovl_maybe_copy_up(struct dentry *dentry, int flags);
 int ovl_copy_xattr(struct super_block *sb, const struct path *path, struct dentry *new);
 int ovl_set_attr(struct ovl_fs *ofs, struct dentry *upper, struct kstat *stat);
-struct ovl_fh *ovl_encode_real_fh(struct ovl_fs *ofs, struct dentry *real,
+struct ovl_fh *ovl_encode_real_fh(struct ovl_fs *ofs, struct inode *realinode,
 				  bool is_upper);
 int ovl_set_origin(struct ovl_fs *ofs, struct dentry *lower,
 		   struct dentry *upper);
-- 
2.34.1


