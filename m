Return-Path: <linux-fsdevel+bounces-61749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 352E7B598CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 16:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C96B71888A41
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 14:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812A035AAD3;
	Tue, 16 Sep 2025 14:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtUt9nFp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC88C353346
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 14:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031204; cv=none; b=sTqnHJHf3kj2X/O6FB2miZKSu8kLSkFT2V1UfQLoJ//XWlAZplZc1jG2ggnGhrD+GUmzUS5MAXTfokm5l7a7sdpQwXsa9qE6IncCxN2KX+nA8Ak80SVpGsrxbPVaGuAclahlmuO9D0SS0HKjKuGzmqx4pI08XWeoXdOE4rKC67g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031204; c=relaxed/simple;
	bh=onJPCe9YqJgqvuYwKD4fnxdCGXT93MaxVU0lwENDDkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f8Bs3oLKlteX2GHhzg32kZIs3nP5iVGHrcaj+uk05PH7MBxwuTqzlv0UdDMqahv+o/MXBWJo20r2nSc7vpCap+6W/oMI+8jGxSv3a9mM4Kl79F7gXdJaq4XrWepNaSx1yBinLsuq35trGBNvNR5B3SsN/BiJNxnzpOk4t1Hd4Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtUt9nFp; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45f29e5e89bso33322505e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 07:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758031201; x=1758636001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9LJ4r8TF2Lv0as7EYdqZVHam471k9lVFSDN/DCiOydU=;
        b=RtUt9nFpd50H7wmzr0gHC58QRsJODnR+/tCPl1yNDa0OdGz8TZwvuZRtbSOYz+iZW+
         DRZCQlpIZQqsRh1TqDFUvf8A899jysaa1AIkBL39A9YUUipAZgQ/yQDhj+h9Hd32NOKz
         VQkmEnQiDn4DOlZveL4LIkl7SHK/bFDiB5cySMs57DOXhJP5sT51HrhMkavke8tZjR/n
         r7GADARKaNnMQAu3ZiUCnjRubbNc3hV1pgLEosREt8hzec0AYg5f/Acjw8fivI6+3Dr+
         AEFdfCHbTnv0+NKXHtM/soOzMeeqvYtV+QAalJqAgBKLJ9DnImHL1odT6uVFWuMJ5+gS
         gfbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758031201; x=1758636001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9LJ4r8TF2Lv0as7EYdqZVHam471k9lVFSDN/DCiOydU=;
        b=d5RNUdcyi1W6B5qLCf38qUciXRwYMVgfzrxG6E2pKhf4SSc6ndw7uBMB86o0Gok4GH
         pMTtaSmur5dPB1/Ketb1lSMxXw+oz60Pj/l/LAi7rkOU/LbhxDNOHzatc9CIhW6iyeRt
         EWpJqJvThk7SUHs4X3ybZEaMTILWlnCIX0XTQV7JZfEW6Mg7kyDTMrsfB/xTnuiZAZOQ
         +Pwbu7dUwKU0Rc8fNJnGrw1fOgHpvAfPZq6tSwPfOgPglXR03YobxNnCueWDFIk590jW
         W48mKpfFUgeVKLnWqfVoacGjsMqbcOFCVnpwkOB02MGMFzhCfcPhjWI3C2WZv3bCkvnP
         Qv7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVx1Zakuzb/ySkngCFyWVm45/b1E1EQH0dijFlX2zXbDFdzaozg425p+IjbOoj8/eo/4SCpo7V2XlilZ/g4@vger.kernel.org
X-Gm-Message-State: AOJu0YwGqCPKZw2dM+0fyxeyH8kdg01liS22NdFDhGzlWaD4MjoOCq6H
	8RrhTBaXoz4jInDF5zmk6F+buDw57KNclYs07YSiQbplW9n4Sjv2qv4l
X-Gm-Gg: ASbGncsNvSDzHokRm8MsxPstl3bPjLoUmEBVqDKbgy556WkOQMZi7rLlGVxfcCLC1IY
	S61l9CX2PLqOzHrIPiv7KCGupdVam9nBNsxSzzDbBycNpmB9sIMm7lDEK1Dt5y1n00ZawmEJ29J
	P2oGf9uC2l5oBPRmvCjzEyuEXkL7couQY9sS9P1oATEbgP2VMtiVZaWGUYg293CjORvz3cRjb43
	QJH0YdD7Ek9DBw/EHp7SQVjMmjG+Iipr9cucUj0e2B5arSp2f7g5BcHgtcGJpZ1nl9fGFw8oiWc
	EjnWwQ+2mYuVZnLUMWQIH0ETsOMSZFoVAihPdyB15xh3ADD9DE8z3ynNZYFgnxoipR3UP2TM92b
	m24vM6tYbnfUtJ+hDYbCQSwDzA/QFQR83dPefX5vWE5e1jWlxhGl17dzqkYmPu7l7QSVdvJeH
X-Google-Smtp-Source: AGHT+IHYJqSjXtRyu8AlavSqqYLYRl8QcSweA/3ngpN0GUZA3qROSZnetWUBJ5Se7JCe/tV8GyTMYw==
X-Received: by 2002:a05:600c:1387:b0:45b:88d6:8ddb with SMTP id 5b1f17b1804b1-45f211fc2dbmr154100195e9.37.1758031200730;
        Tue, 16 Sep 2025 07:00:00 -0700 (PDT)
Received: from f.. (cst-prg-88-146.cust.vodafone.cz. [46.135.88.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7cde81491sm16557991f8f.42.2025.09.16.06.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:00:00 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com,
	kernel-team@fb.com,
	amir73il@gmail.com,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v4 10/12] ceph: use the new ->i_state accessors
Date: Tue, 16 Sep 2025 15:58:58 +0200
Message-ID: <20250916135900.2170346-11-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916135900.2170346-1-mjguzik@gmail.com>
References: <20250916135900.2170346-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/ceph/cache.c  |  2 +-
 fs/ceph/crypto.c |  4 ++--
 fs/ceph/file.c   |  4 ++--
 fs/ceph/inode.c  | 28 ++++++++++++++--------------
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/fs/ceph/cache.c b/fs/ceph/cache.c
index 930fbd54d2c8..f678bab189d8 100644
--- a/fs/ceph/cache.c
+++ b/fs/ceph/cache.c
@@ -26,7 +26,7 @@ void ceph_fscache_register_inode_cookie(struct inode *inode)
 		return;
 
 	/* Only new inodes! */
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read_once(inode) & I_NEW))
 		return;
 
 	WARN_ON_ONCE(ci->netfs.cache);
diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index 7026e794813c..928746b92512 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -329,7 +329,7 @@ int ceph_encode_encrypted_dname(struct inode *parent, char *buf, int elen)
 out:
 	kfree(cryptbuf);
 	if (dir != parent) {
-		if ((dir->i_state & I_NEW))
+		if ((inode_state_read_once(dir) & I_NEW))
 			discard_new_inode(dir);
 		else
 			iput(dir);
@@ -438,7 +438,7 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
 	fscrypt_fname_free_buffer(&_tname);
 out_inode:
 	if (dir != fname->dir) {
-		if ((dir->i_state & I_NEW))
+		if ((inode_state_read_once(dir) & I_NEW))
 			discard_new_inode(dir);
 		else
 			iput(dir);
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index c02f100f8552..59f2be41c9aa 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -744,7 +744,7 @@ static int ceph_finish_async_create(struct inode *dir, struct inode *inode,
 		      vino.ino, ceph_ino(dir), dentry->d_name.name);
 		ceph_dir_clear_ordered(dir);
 		ceph_init_inode_acls(inode, as_ctx);
-		if (inode->i_state & I_NEW) {
+		if (inode_state_read_once(inode) & I_NEW) {
 			/*
 			 * If it's not I_NEW, then someone created this before
 			 * we got here. Assume the server is aware of it at
@@ -907,7 +907,7 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 				new_inode = NULL;
 				goto out_req;
 			}
-			WARN_ON_ONCE(!(new_inode->i_state & I_NEW));
+			WARN_ON_ONCE(!(inode_state_read_once(new_inode) & I_NEW));
 
 			spin_lock(&dentry->d_lock);
 			di->flags |= CEPH_DENTRY_ASYNC_CREATE;
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 480cb3a1d639..6786ec955a87 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -86,7 +86,7 @@ struct inode *ceph_new_inode(struct inode *dir, struct dentry *dentry,
 			goto out_err;
 	}
 
-	inode->i_state = 0;
+	inode_state_set_raw(inode, 0);
 	inode->i_mode = *mode;
 
 	err = ceph_security_init_secctx(dentry, *mode, as_ctx);
@@ -155,7 +155,7 @@ struct inode *ceph_get_inode(struct super_block *sb, struct ceph_vino vino,
 
 	doutc(cl, "on %llx=%llx.%llx got %p new %d\n",
 	      ceph_present_inode(inode), ceph_vinop(inode), inode,
-	      !!(inode->i_state & I_NEW));
+	      !!(inode_state_read_once(inode) & I_NEW));
 	return inode;
 }
 
@@ -182,7 +182,7 @@ struct inode *ceph_get_snapdir(struct inode *parent)
 		goto err;
 	}
 
-	if (!(inode->i_state & I_NEW) && !S_ISDIR(inode->i_mode)) {
+	if (!(inode_state_read_once(inode) & I_NEW) && !S_ISDIR(inode->i_mode)) {
 		pr_warn_once_client(cl, "bad snapdir inode type (mode=0%o)\n",
 				    inode->i_mode);
 		goto err;
@@ -215,7 +215,7 @@ struct inode *ceph_get_snapdir(struct inode *parent)
 		}
 	}
 #endif
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read_once(inode) & I_NEW) {
 		inode->i_op = &ceph_snapdir_iops;
 		inode->i_fop = &ceph_snapdir_fops;
 		ci->i_snap_caps = CEPH_CAP_PIN; /* so we can open */
@@ -224,7 +224,7 @@ struct inode *ceph_get_snapdir(struct inode *parent)
 
 	return inode;
 err:
-	if ((inode->i_state & I_NEW))
+	if ((inode_state_read_once(inode) & I_NEW))
 		discard_new_inode(inode);
 	else
 		iput(inode);
@@ -698,7 +698,7 @@ void ceph_evict_inode(struct inode *inode)
 
 	netfs_wait_for_outstanding_io(inode);
 	truncate_inode_pages_final(&inode->i_data);
-	if (inode->i_state & I_PINNING_NETFS_WB)
+	if (inode_state_read_once(inode) & I_PINNING_NETFS_WB)
 		ceph_fscache_unuse_cookie(inode, true);
 	clear_inode(inode);
 
@@ -967,7 +967,7 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 	      le64_to_cpu(info->version), ci->i_version);
 
 	/* Once I_NEW is cleared, we can't change type or dev numbers */
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read_once(inode) & I_NEW) {
 		inode->i_mode = mode;
 	} else {
 		if (inode_wrong_type(inode, mode)) {
@@ -1044,7 +1044,7 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 
 #ifdef CONFIG_FS_ENCRYPTION
 	if (iinfo->fscrypt_auth_len &&
-	    ((inode->i_state & I_NEW) || (ci->fscrypt_auth_len == 0))) {
+	    ((inode_state_read_once(inode) & I_NEW) || (ci->fscrypt_auth_len == 0))) {
 		kfree(ci->fscrypt_auth);
 		ci->fscrypt_auth_len = iinfo->fscrypt_auth_len;
 		ci->fscrypt_auth = iinfo->fscrypt_auth;
@@ -1638,13 +1638,13 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 			pr_err_client(cl, "badness %p %llx.%llx\n", in,
 				      ceph_vinop(in));
 			req->r_target_inode = NULL;
-			if (in->i_state & I_NEW)
+			if (inode_state_read_once(in) & I_NEW)
 				discard_new_inode(in);
 			else
 				iput(in);
 			goto done;
 		}
-		if (in->i_state & I_NEW)
+		if (inode_state_read_once(in) & I_NEW)
 			unlock_new_inode(in);
 	}
 
@@ -1830,11 +1830,11 @@ static int readdir_prepopulate_inodes_only(struct ceph_mds_request *req,
 			pr_err_client(cl, "inode badness on %p got %d\n", in,
 				      rc);
 			err = rc;
-			if (in->i_state & I_NEW) {
+			if (inode_state_read_once(in) & I_NEW) {
 				ihold(in);
 				discard_new_inode(in);
 			}
-		} else if (in->i_state & I_NEW) {
+		} else if (inode_state_read_once(in) & I_NEW) {
 			unlock_new_inode(in);
 		}
 
@@ -2046,7 +2046,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 			pr_err_client(cl, "badness on %p %llx.%llx\n", in,
 				      ceph_vinop(in));
 			if (d_really_is_negative(dn)) {
-				if (in->i_state & I_NEW) {
+				if (inode_state_read_once(in) & I_NEW) {
 					ihold(in);
 					discard_new_inode(in);
 				}
@@ -2056,7 +2056,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 			err = ret;
 			goto next_item;
 		}
-		if (in->i_state & I_NEW)
+		if (inode_state_read_once(in) & I_NEW)
 			unlock_new_inode(in);
 
 		if (d_really_is_negative(dn)) {
-- 
2.43.0


