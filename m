Return-Path: <linux-fsdevel+bounces-38402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5EAA01A92
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jan 2025 17:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26D3A7A27F8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jan 2025 16:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6095D18453E;
	Sun,  5 Jan 2025 16:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvE1lfRi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6156157466
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Jan 2025 16:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736094254; cv=none; b=RjENQwvItuwDGV8IdpB406omE5FiUoGQDCkVJN14o9BQshlUXSoyT8oFDUonhk3gaK40zW/03paxtcwfu602I20dRjv3qTP3OGw4BwgbeBRjehLzbEUP2NCn71g1hh7iEJO5tBaNqrucfg+zt2GxFhNx0/jS5dfgw6TTuvAM4F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736094254; c=relaxed/simple;
	bh=mxcE2u8ziwtn8DaKFE+aHhmPAN7Wb8re9XbPdXrbpWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jY9LQL/odtVshQEFkEwnHpPsNTZDkcXbcpQnY38+H0rxEPEtvcenzsGx+wDm1AKT9KyVMMmZpR2y8+oJvUcyvepHI7l/7z1s1kRY+Oaupi2gMo+i5xIxNEqI08YuEJt11dLQmGbh62lg2PEFzM8n/kwKwbvTF6eaeBUn1Y03j4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HvE1lfRi; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38637614567so6169099f8f.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Jan 2025 08:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736094251; x=1736699051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xaJRHx0ZLC9uUaaKHP1trKkhs7TN1+0+w9y8l8aF8CI=;
        b=HvE1lfRiwdYzmwVNTZ7XnowMhNB0DEhUxgOVGpO75GYP3wo1Alc/vwzhMw5IL8OsXY
         vlaVhxvH43VLuzj8Jho5EjB6RN3x092oUydvO5Brhmg/JMBsA1Gpo/uJZ8rjtX7SPVkb
         FDs+Kic+R9MVLN9wBFjWnWdpkn42KLNqcIzvDbC2sEtr+E9IsDX7GqHEOllj+cE/IznZ
         UoI/N89BP2C31n9eVjRLT4KSXJfhinYEgguO5i6o5Qh8BhrSU2JcRKG+R2QuyddR97Dl
         NyINzbgSeFv5n4X0+8b78Rq8aoPe87B0GCGhWyOLYQFcjw9YKyJesr4OL8HLJ8X9rddt
         Qfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736094251; x=1736699051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xaJRHx0ZLC9uUaaKHP1trKkhs7TN1+0+w9y8l8aF8CI=;
        b=o2EtVhJUi32Tr3PhvP7BJqTcu8Y1aTfQXgleHZbqOtU/pe8RY6wvq8zUSioO3s1tjQ
         epOYRZsvctxi2c+V2B6LDpYv/w9+joIA6SPGQIZvqvzbxMbXbT0daOycbYcWvr/IKOLy
         ltxVaRHSoW7CJcHGpYsQDZsmHrUdCmHxilHZr3MhqQeV0PkBGvN9aPgBuGGjb6hV2wsX
         zG7NYe5nkx95xcb88CJi+aY+gKckzEHfEnczTnX22Zq5XFAPsEyWqafPru8HW36ef2of
         EfKBeOIPWFoOeRDLdyh43grMZ/0tgXnAX6/NeFukzYJjwHG9PHSFQ665ywrEwpRVEZVs
         S99Q==
X-Forwarded-Encrypted: i=1; AJvYcCWFYPFRIeKMXPDI87ZTM7PtaHDEFF4zbnQLLGgX/mhAIyTNUaf3kaLzvElum8uJwglyjvH09BcVcmm1Gw4k@vger.kernel.org
X-Gm-Message-State: AOJu0Ywztldguu58L3gJDy7Mtoulja7QFhA3eMK6hU14IifHZhYWH2Rq
	XO0oshYlfIgVLKCTWWEGX3yRifm3e/yI8IOdVxmVW5EPKQcsuHhq
X-Gm-Gg: ASbGncvIagEOcFted8lL4etnBuYYc4YWtZYwkkbsi+nboYqkipDMuCayYEieDeiUfDA
	fVDnF26ozWFztaX5EwbmU+fRlUg9QniEuMrF2HxHDzEguU2bxjn/c8PpVZrlvBTBSAlCeY5d3Tv
	y80CrB0z2XzxHM6NXhgTb/vFe23YK8nr/szhv3/2nDvKkQBzSDMbd9PV74xrMlwZVWfdE/NoQmC
	Fg/dsk51MqdNZiJqk2EhqFDg5wxiXTLwurw9eHWozhxUENNQGzk1NM/c7zjLI9TdF1/0HjUgXgY
	Mmjyx87+Zt/TJWen3xd5CE2951PwkLW29oUR+L6crx6kQXtnSQN2pQ==
X-Google-Smtp-Source: AGHT+IGzMtfN+8s5MJk41uaxd1pEtiXC0xmluBoX4nmoWotsMb+NfBwGTRQnKRG+yUEMqfNUISy1YQ==
X-Received: by 2002:a05:6000:490e:b0:385:fc97:9c63 with SMTP id ffacd0b85a97d-38a221f16d6mr46165818f8f.9.1736094250654;
        Sun, 05 Jan 2025 08:24:10 -0800 (PST)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436612008b1sm538372765e9.15.2025.01.05.08.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 08:24:10 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org,
	Dmitry Safonov <dima@arista.com>
Subject: [PATCH 2/2] ovl: support encoding fid from inode with no alias
Date: Sun,  5 Jan 2025 17:24:04 +0100
Message-Id: <20250105162404.357058-3-amir73il@gmail.com>
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

Dmitry Safonov reported that a WARN_ON() assertion can be trigered by
userspace when calling inotify_show_fdinfo() for an overlayfs watched
inode, whose dentry aliases were discarded with drop_caches.

The WARN_ON() assertion in inotify_show_fdinfo() was removed, because
it is possible for encoding file handle to fail for other reason, but
the impact of failing to encode an overlayfs file handle goes beyond
this assertion.

As shown in the LTP test case mentioned in the link below, failure to
encode an overlayfs file handle from a non-aliased inode also leads to
failure to report an fid with FAN_DELETE_SELF fanotify events.

As Dmitry notes in his analyzis of the problem, ovl_encode_fh() fails
if it cannot find an alias for the inode, but this failure can be fixed.
ovl_encode_fh() seldom uses the alias and in the case of non-decodable
file handles, as is often the case with fanotify fid info,
ovl_encode_fh() never needs to use the alias to encode a file handle.

Defer finding an alias until it is actually needed so ovl_encode_fh()
will not fail in the common case of FAN_DELETE_SELF fanotify events.

Fixes: 16aac5ad1fa9 ("ovl: support encoding non-decodable file handles")
Reported-by: Dmitry Safonov <dima@arista.com>
Closes: https://lore.kernel.org/linux-fsdevel/CAOQ4uxiie81voLZZi2zXS1BziXZCM24nXqPAxbu8kxXCUWdwOg@mail.gmail.com/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/export.c | 46 +++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
index 036c9f39a14d7..444aeeccb6daf 100644
--- a/fs/overlayfs/export.c
+++ b/fs/overlayfs/export.c
@@ -176,35 +176,37 @@ static int ovl_connect_layer(struct dentry *dentry)
  *
  * Return 0 for upper file handle, > 0 for lower file handle or < 0 on error.
  */
-static int ovl_check_encode_origin(struct dentry *dentry)
+static int ovl_check_encode_origin(struct inode *inode)
 {
-	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
+	struct ovl_fs *ofs = OVL_FS(inode->i_sb);
 	bool decodable = ofs->config.nfs_export;
+	struct dentry *dentry;
+	int err;
 
 	/* No upper layer? */
 	if (!ovl_upper_mnt(ofs))
 		return 1;
 
 	/* Lower file handle for non-upper non-decodable */
-	if (!ovl_dentry_upper(dentry) && !decodable)
+	if (!ovl_inode_upper(inode) && !decodable)
 		return 1;
 
 	/* Upper file handle for pure upper */
-	if (!ovl_dentry_lower(dentry))
+	if (!ovl_inode_lower(inode))
 		return 0;
 
 	/*
 	 * Root is never indexed, so if there's an upper layer, encode upper for
 	 * root.
 	 */
-	if (dentry == dentry->d_sb->s_root)
+	if (inode == d_inode(inode->i_sb->s_root))
 		return 0;
 
 	/*
 	 * Upper decodable file handle for non-indexed upper.
 	 */
-	if (ovl_dentry_upper(dentry) && decodable &&
-	    !ovl_test_flag(OVL_INDEX, d_inode(dentry)))
+	if (ovl_inode_upper(inode) && decodable &&
+	    !ovl_test_flag(OVL_INDEX, inode))
 		return 0;
 
 	/*
@@ -213,17 +215,25 @@ static int ovl_check_encode_origin(struct dentry *dentry)
 	 * ovl_connect_layer() will try to make origin's layer "connected" by
 	 * copying up a "connectable" ancestor.
 	 */
-	if (d_is_dir(dentry) && decodable)
-		return ovl_connect_layer(dentry);
+	if (!decodable || !S_ISDIR(inode->i_mode))
+		return 1;
+
+	dentry = d_find_any_alias(inode);
+	if (!dentry)
+		return -ENOENT;
+
+	err = ovl_connect_layer(dentry);
+	dput(dentry);
+	if (err < 0)
+		return err;
 
 	/* Lower file handle for indexed and non-upper dir/non-dir */
 	return 1;
 }
 
-static int ovl_dentry_to_fid(struct ovl_fs *ofs, struct dentry *dentry,
+static int ovl_dentry_to_fid(struct ovl_fs *ofs, struct inode *inode,
 			     u32 *fid, int buflen)
 {
-	struct inode *inode = d_inode(dentry);
 	struct ovl_fh *fh = NULL;
 	int err, enc_lower;
 	int len;
@@ -232,7 +242,7 @@ static int ovl_dentry_to_fid(struct ovl_fs *ofs, struct dentry *dentry,
 	 * Check if we should encode a lower or upper file handle and maybe
 	 * copy up an ancestor to make lower file handle connectable.
 	 */
-	err = enc_lower = ovl_check_encode_origin(dentry);
+	err = enc_lower = ovl_check_encode_origin(inode);
 	if (enc_lower < 0)
 		goto fail;
 
@@ -252,8 +262,8 @@ static int ovl_dentry_to_fid(struct ovl_fs *ofs, struct dentry *dentry,
 	return err;
 
 fail:
-	pr_warn_ratelimited("failed to encode file handle (%pd2, err=%i)\n",
-			    dentry, err);
+	pr_warn_ratelimited("failed to encode file handle (ino=%lu, err=%i)\n",
+			    inode->i_ino, err);
 	goto out;
 }
 
@@ -261,19 +271,13 @@ static int ovl_encode_fh(struct inode *inode, u32 *fid, int *max_len,
 			 struct inode *parent)
 {
 	struct ovl_fs *ofs = OVL_FS(inode->i_sb);
-	struct dentry *dentry;
 	int bytes, buflen = *max_len << 2;
 
 	/* TODO: encode connectable file handles */
 	if (parent)
 		return FILEID_INVALID;
 
-	dentry = d_find_any_alias(inode);
-	if (!dentry)
-		return FILEID_INVALID;
-
-	bytes = ovl_dentry_to_fid(ofs, dentry, fid, buflen);
-	dput(dentry);
+	bytes = ovl_dentry_to_fid(ofs, inode, fid, buflen);
 	if (bytes <= 0)
 		return FILEID_INVALID;
 
-- 
2.34.1


