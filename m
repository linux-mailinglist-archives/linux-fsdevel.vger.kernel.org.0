Return-Path: <linux-fsdevel+bounces-34753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A70C29C86D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 11:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D70172822FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 10:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1761F7074;
	Thu, 14 Nov 2024 10:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apE6yMBC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455241DEFFE;
	Thu, 14 Nov 2024 10:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731578744; cv=none; b=pwL712Lj8/UHfu5v/WtOcCY/q1xIyiUAMIUpfnQVArU/vbPon9EGI2aVPUes7tbaJJyNLIZrcBBQjXy+D0j+x5S0zblEC6ySOE70LPiViaduFnWHQrH8edlYIMDG/ONd2QteERQvA+8nxqm8+Ai7gQyrRx/OlQaCj0wUJzo6jTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731578744; c=relaxed/simple;
	bh=2NPPpdVrQ/T1klUCdqAcp7cskC1qA7YvzeL7Y79AQQs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LdBmL56sUo0KL81BZU0MlvFgmF8Xm8UimdWsdiI0mE/50a1YjdsFCYaksJ1jFAfKRjph8D6RiQ8p1PPxtQZjNy7rGf5k2YTOUPcldlS1v+Vg5HwIA8cdIkdUHIu9dQLmmlnRl56Wz7d4Nfo/Rp3D9WbQzhNxglShl8bstLfgF/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apE6yMBC; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c96b2a10e1so681896a12.2;
        Thu, 14 Nov 2024 02:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731578742; x=1732183542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fkBoo13TGK+/tRXL/9DASxNq0+HXbAWZt9KkjQxI/HA=;
        b=apE6yMBCssnXplN7Jy/176/WpbijuWff3iBcrmdovd4lG9PfAAppqGYgb9kaExM8rv
         OJwCiRUAEACPw4Z4c8MHB8PKRpnDsE/sFlM5WblNIBNo13ycl7RVieK23OdAb3IwOw+m
         3AGY7W8C63/xaXR5VNuU95+ZDtUAmQ30mitqULLaduEcNOdTbBQLChU3xutxd9U5ly37
         90grmqJe/56TeYcpyaJ4aK8ygCAHkz6mB1k8MM7ABqO4vL3S2OpQ1PZV6yNjo+3aplPa
         5NhqqRywxKoWJWqJM4NdxyxBM7/nG2kjvBOspKnbd2lXanL122tK1ezamKBBrFADiqXB
         Y39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731578742; x=1732183542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fkBoo13TGK+/tRXL/9DASxNq0+HXbAWZt9KkjQxI/HA=;
        b=rudexWhemSEcy8IQgxLQJ4UAPNtgNlvlF171hMjK6thidaAivFjg4uWRWE++IlRYdm
         MeIRyWtyGlbn8XbohA3iJV0jlgnAkT1tKfYdrmTpBczEQfJjbKxH1CO4/pxFW/ydqnNV
         f+DvSKvxVbQAx5bPJ98Nu7F+5glGfS+VYRNtkOG4ytCdYBu9ZU6jxIib9eKLy+vnifAF
         KUD9mX9Rzs9SocXq6FBM9aP+CLcmivHzrlBi0/kYWXlyM+ePkL6+64/D3SUs235Em/Qe
         HHX7814rFiiI8WUQ1Bg8eIOa6pruI2qIx33ikX3pfyx/k3wTIS38HHJJvW6VsR2qB9BW
         IOAg==
X-Forwarded-Encrypted: i=1; AJvYcCV0FPOUUlMZA695ML/mbk0UiQhOh4jqA4uwZgL7xY+5FnB+CDMq39dPL0c+EOHrZzKG8AWeuEDQr2e2eCGuog==@vger.kernel.org, AJvYcCWEQHhjhnBqnxWpNJSf9uK2ZrX/FRF+rYJMdGFSkXbm5LG5gMg3IBz8I3a6LSa6LMozr6HA5P2yAmRxHtFh@vger.kernel.org
X-Gm-Message-State: AOJu0YzQZQM1T82awZV7Ca6AHatinJVq7fdLhYLfduHhT3wz6j494duv
	88jzSpYyWYTVLmgUs5r0E862v+Ty410+3Jg/viP6FJUC5LjvQ8Qhi73CvjFS
X-Google-Smtp-Source: AGHT+IEXQ71RyDzQnbceP832hXFacbBgz3YYtUbc/PN4msYhbNNwU8Rh18zDf7/WzsnW8UulYKCSEw==
X-Received: by 2002:a17:907:72c5:b0:a99:ff2c:78fc with SMTP id a640c23a62f3a-a9ef00504f5mr2500466766b.57.1731578741368;
        Thu, 14 Nov 2024 02:05:41 -0800 (PST)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e043b76sm44739066b.147.2024.11.14.02.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 02:05:40 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [PATCH] ovl: pass an explicit reference of creators creds to callers
Date: Thu, 14 Nov 2024 11:05:36 +0100
Message-Id: <20241114100536.628162-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ovl_setup_cred_for_create() decrements one refcount of new creds and
ovl_revert_creds() in callers decrements the last refcount.

In preparation to revert_creds_light() back to caller creds, pass an
explicit reference of the creators creds to the callers and drop the
refcount explicitly in the callers after ovl_revert_creds().

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Miklos, Christian,

I was chasing a suspect memleak in revert_creds_light() patches.
This fix is unrelated to memleak but I think it is needed for
correctness anyway.

This applies in the middle of the series after adding the
ovl_revert_creds() helper.

Thanks,
Amir.

 fs/overlayfs/dir.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 09db5eb19242..4b0bb7a91d37 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -553,15 +553,17 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 	goto out_dput;
 }
 
-static int ovl_setup_cred_for_create(struct dentry *dentry, struct inode *inode,
-				     umode_t mode, const struct cred *old_cred)
+static const struct cred *ovl_setup_cred_for_create(struct dentry *dentry,
+						    struct inode *inode,
+						    umode_t mode,
+						    const struct cred *old_cred)
 {
 	int err;
 	struct cred *override_cred;
 
 	override_cred = prepare_creds();
 	if (!override_cred)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	override_cred->fsuid = inode->i_uid;
 	override_cred->fsgid = inode->i_gid;
@@ -569,19 +571,18 @@ static int ovl_setup_cred_for_create(struct dentry *dentry, struct inode *inode,
 					      old_cred, override_cred);
 	if (err) {
 		put_cred(override_cred);
-		return err;
+		return ERR_PTR(err);
 	}
 	put_cred(override_creds(override_cred));
-	put_cred(override_cred);
 
-	return 0;
+	return override_cred;
 }
 
 static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 			      struct ovl_cattr *attr, bool origin)
 {
 	int err;
-	const struct cred *old_cred;
+	const struct cred *old_cred, *new_cred = NULL;
 	struct dentry *parent = dentry->d_parent;
 
 	old_cred = ovl_override_creds(dentry->d_sb);
@@ -610,9 +611,13 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 		 * create a new inode, so just use the ovl mounter's
 		 * fs{u,g}id.
 		 */
-		err = ovl_setup_cred_for_create(dentry, inode, attr->mode, old_cred);
-		if (err)
+		new_cred = ovl_setup_cred_for_create(dentry, inode, attr->mode,
+						     old_cred);
+		err = PTR_ERR(new_cred);
+		if (IS_ERR(new_cred)) {
+			new_cred = NULL;
 			goto out_revert_creds;
+		}
 	}
 
 	if (!ovl_dentry_is_whiteout(dentry))
@@ -622,6 +627,7 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 
 out_revert_creds:
 	ovl_revert_creds(old_cred);
+	put_cred(new_cred);
 	return err;
 }
 
@@ -1306,7 +1312,7 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 static int ovl_create_tmpfile(struct file *file, struct dentry *dentry,
 			      struct inode *inode, umode_t mode)
 {
-	const struct cred *old_cred;
+	const struct cred *old_cred, *new_cred = NULL;
 	struct path realparentpath;
 	struct file *realfile;
 	struct dentry *newdentry;
@@ -1315,9 +1321,12 @@ static int ovl_create_tmpfile(struct file *file, struct dentry *dentry,
 	int err;
 
 	old_cred = ovl_override_creds(dentry->d_sb);
-	err = ovl_setup_cred_for_create(dentry, inode, mode, old_cred);
-	if (err)
+	new_cred = ovl_setup_cred_for_create(dentry, inode, mode, old_cred);
+	err = PTR_ERR(new_cred);
+	if (IS_ERR(new_cred)) {
+		new_cred = NULL;
 		goto out_revert_creds;
+	}
 
 	ovl_path_upper(dentry->d_parent, &realparentpath);
 	realfile = backing_tmpfile_open(&file->f_path, flags, &realparentpath,
@@ -1338,6 +1347,7 @@ static int ovl_create_tmpfile(struct file *file, struct dentry *dentry,
 	}
 out_revert_creds:
 	ovl_revert_creds(old_cred);
+	put_cred(new_cred);
 	return err;
 }
 
-- 
2.34.1


