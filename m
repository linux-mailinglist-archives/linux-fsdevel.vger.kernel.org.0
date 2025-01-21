Return-Path: <linux-fsdevel+bounces-39765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27923A17CA7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 12:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1BC61884987
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 11:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7217F1F1317;
	Tue, 21 Jan 2025 11:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hy5f6ls1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0773F1EF0BA;
	Tue, 21 Jan 2025 11:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737457706; cv=none; b=TLaStdL+5+rKH/gH2GzY71OaD5xNOHhsdAFRbGT9sgRX2QVGGFFcI2sdmSzlfE76aWXjN1plEwVpkFKHr65CToKUiryXaSFn9pOrYuyZBj5scoLpNE+lWI8iDG6l6ptIjoipUhRt/KoCYozaCYOaKbKgkXMpGiOGDOH25UDh3J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737457706; c=relaxed/simple;
	bh=b2k2S+wI5xiH5715BF3rShaNjtPqryp7/Z7jvTHKn4s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hDpwN48nAHafDkSQzdaD4TngIimC+JIJGaJlSAC2H/ft6WmCWMKIpGCMTX6I/DMciff00abA+tpKt/e3OixvS1Jm0KrLHEd6n2weEI3AtCVfvzKMgqUJrDhza39GONT7QC6Jz/6TfyMFCTxpVrTYxoR7tVffEAO6Uf/hFRyrm9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hy5f6ls1; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d3e6274015so1875653a12.0;
        Tue, 21 Jan 2025 03:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737457703; x=1738062503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKlbeu4A1We+UcyBZC2G9WSyIvInqYg8mwICtl4YMBc=;
        b=Hy5f6ls1BnA0tJyK87Nk6a3Qa1ikm2ml6w6VNLj9UxZhw9BGFsegRqRY1MrhdP0/DT
         /ubCD7bRjfXH1zoLGIlieGNKUtFF98I9hHszCm44MhGnymfiv6BXw0H77u8sU6FwyeIw
         yMJOC6udOAOyPkkAtvJiwaprKGSEbbpNGswh1fUJmirK+T6kqiCZvHzv0fUwCs0pE4Zn
         R2o+yffOKIzVsF786W9OR2dfE0W4M8w6jQA2NaKoNY2DjUCmuE6sQWUIzeSbkVf9inXC
         uT1TYYpS6FyT778W1A2ShJhqI82t5IOQisdydNnPL6afoKynV2ZAOE4oS8VW0p5pRe7r
         aYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737457703; x=1738062503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hKlbeu4A1We+UcyBZC2G9WSyIvInqYg8mwICtl4YMBc=;
        b=SbmsNtxbna/sQR3OFB8LmP+cEpSREMkrpQXqDj1V0ZjteW+o/tmtuFJj4t9k8TYeTr
         AqWqiB2BlxV8iF1voEOyCiZorPnWoU1yeI4JIluULWTu9O85pIyt4dldqSdftet5yC5G
         u640CjPqaMyWRnFPe98Eni+6xu2HwzzggQCySkc3E48cPDYs98aWhQqO4CoCn3FW73kT
         lR/XUNtGUGYvVRiw/v0OnphIfZ4V0KXkJkhlG0pzueu+zR52+MMBmnunyKPQLMFvy75g
         QcrYbnLaCqkqwl8h1oskJ5Tihd1bwPFWXyU/mb55FWo5JheBXx4w1xyitSnbebGHHWII
         5m1w==
X-Forwarded-Encrypted: i=1; AJvYcCUZE1lX3p1jB9T+3SXgjETXRHarBG4xk4+KabsrrGu4LQTguRUnp47WmkkwPewiQ0Bkez0T3+xNEGN8AS8HbA==@vger.kernel.org, AJvYcCVBm+ZdMcRdOzT0q2O74blqUTfBA8RCwZS7mhYDMf8EaLkaoj1IZJqwYW4gSlzZuaEe23XWOX80@vger.kernel.org, AJvYcCWFB/vDyPPJYWd7CwLtwV8SOLOjqgoIqmHJyfVJbWwnS+17721MWxtZBnDTLylczcxQq2yQZCXyY78ylLB5@vger.kernel.org
X-Gm-Message-State: AOJu0YxSADcNOuVAgGWpwtpmHw0dXOHlnedL/pwwQJ1cIX7px2ZbSL18
	0HqxAua87nNCf+ECYpaqWOw3gUkwLvwB+j4vmnyC6FSViirmHNgX
X-Gm-Gg: ASbGncsF743vCoVMSpYodAGi9tcXf8bzMCQjq010IfL1p9P5FV/bbYDxyFtMLBhC+1I
	tZ5jXOSEfFPo5V6T+hUi4LnK5nae9MA+uMjmZy7DtrcSsKHx7fktXf4ayjrJJF4msbBearr/xxB
	MRPidITu5wDKYXWcclvZNlSGr6f+rKJ0YbvKEDFh5zdphljEAAx5i49wymi47MARYeo1KJ+wjYY
	532SIY7xmiGLfHPcXP50Y91geRMxj+GeB0UelBTZ0bkSQBovaf59vODd9CVBcZU5toDkRsavV6/
	GPFvDQOUBe7RiJZHrfuohmaRBriOIVHro29DHj56sMantHUvSEJjNEeV+C9symPR2V0=
X-Google-Smtp-Source: AGHT+IExh6oiUclInr3SeswnB/qMoXt9IMZvkHqJwRVzNRUboHJ+tVSoXkuNZW0g6m8kKe/k4CloqQ==
X-Received: by 2002:a05:6402:254a:b0:5d2:8f70:75f6 with SMTP id 4fb4d7f45d1cf-5db7db12d0fmr16664098a12.30.1737457702748;
        Tue, 21 Jan 2025 03:08:22 -0800 (PST)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5db73683d28sm7209841a12.40.2025.01.21.03.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 03:08:22 -0800 (PST)
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
Subject: [PATCH 6.6 2/3] ovl: support encoding fid from inode with no alias
Date: Tue, 21 Jan 2025 12:08:14 +0100
Message-Id: <20250121110815.416785-3-amir73il@gmail.com>
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

[ Upstream commit c45beebfde34aa71afbc48b2c54cdda623515037 ]

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
Link: https://lore.kernel.org/r/20250105162404.357058-3-amir73il@gmail.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/export.c | 46 +++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
index c56e4e0b8054c..3a17e4366f28c 100644
--- a/fs/overlayfs/export.c
+++ b/fs/overlayfs/export.c
@@ -181,35 +181,37 @@ static int ovl_connect_layer(struct dentry *dentry)
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
@@ -218,17 +220,25 @@ static int ovl_check_encode_origin(struct dentry *dentry)
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
@@ -237,7 +247,7 @@ static int ovl_dentry_to_fid(struct ovl_fs *ofs, struct dentry *dentry,
 	 * Check if we should encode a lower or upper file handle and maybe
 	 * copy up an ancestor to make lower file handle connectable.
 	 */
-	err = enc_lower = ovl_check_encode_origin(dentry);
+	err = enc_lower = ovl_check_encode_origin(inode);
 	if (enc_lower < 0)
 		goto fail;
 
@@ -257,8 +267,8 @@ static int ovl_dentry_to_fid(struct ovl_fs *ofs, struct dentry *dentry,
 	return err;
 
 fail:
-	pr_warn_ratelimited("failed to encode file handle (%pd2, err=%i)\n",
-			    dentry, err);
+	pr_warn_ratelimited("failed to encode file handle (ino=%lu, err=%i)\n",
+			    inode->i_ino, err);
 	goto out;
 }
 
@@ -266,19 +276,13 @@ static int ovl_encode_fh(struct inode *inode, u32 *fid, int *max_len,
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


