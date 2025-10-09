Return-Path: <linux-fsdevel+bounces-63637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F275BC7E0B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 09 Oct 2025 10:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DF253C65D6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 08:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AE52D5A07;
	Thu,  9 Oct 2025 08:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AP2BOWtO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCBE2D7DD5
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Oct 2025 07:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996798; cv=none; b=DLXWaeASgsJPaC3XHOALPtZiXo0k/0+9XWwmDuiyP5x0t3Wh0gS/w9X0kn/L7i3v/cuvLnlnofUyI7DHGmGUmFYR4/ulQgm3PhOLcTIyKaUixQGD/8ZzlYKIMfdhEwMWO7K9rPyS2rw9u8G/MQdOxnG6b+UwpWEoR55nkBvmBF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996798; c=relaxed/simple;
	bh=C2dm91mSHiXEN5ZR1LoL61DaMO1AWxjUqLWD/0PM02A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cbxt/Fyj6vTXzdJYQyei+kZOqFkWrQ4WE2y9rjdE7kueoXmweQ8TvvuVdD+RFXc69l29orw7OuDLYPGR6GDvWrB915c/9Uj2cQHYTRMz+v9SrROS78b723zvhg1lWFGlQTM0s7TNJQkgerGgiqvS8teS4he4poEv3D9Wdkhu8K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AP2BOWtO; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b3e9d633b78so2083866b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Oct 2025 00:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759996791; x=1760601591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+oN/DyZ5OmjZbLZHfaeiaZe3fElqmiRAqyveNfIkiY=;
        b=AP2BOWtO+wxZIsfs9g4bk2rM3k9+am+gL2+hdfNTlvusJzfUgyo8maloNT0XFCahbw
         Q7U6+tj/Jy4eG3M+BHPpn92xvMkgkTsThTeGK+aHqc36bo6LHMBdc+Q7SoLM6hRyC7sq
         eLwP5rvxi7i+6P8n0AHQ1T8cQRRz/bH5vcZRd++o2VIxobFj/1hTvDUeSzZnoEK7l+6o
         SxGVjzdaWHo0BDDQgWVLQnbT0a4kwIZutA4qxMBFXNdzNS6Js9BVfhx1m46vFBYr6UZM
         9h8M9VGH4ehn6xj/9VfG9yazGeA+nzebqz8IO3JgNJuDo7pB1uqtfsDNbIsbJ/TDB4B0
         ArpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759996791; x=1760601591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+oN/DyZ5OmjZbLZHfaeiaZe3fElqmiRAqyveNfIkiY=;
        b=TzrO0hyTUyOrVPj0RUCx6wG5ItPwcVVju4o9ERCFKDH3WLr9V/pPmb0TvMGHbP5/zY
         UJ92R1HzNxex7zMfRH6zvzkiLYtUPAlbudsonE37PtanNcwXdxMoVaYfQclfBQ9V8ZSH
         G3ItHzY1pajoT+SabJ8lfsb9jwxw8rZXdpQ+6bo1X8iLg7qs0FblhPGL0DXYRF850YBD
         Q/TbebP2NB1mEGWv85W+dLgwaOcXcS7niw59Bg98WvaNWnJdCBevegpqFhkNPO2CWT3H
         IsdezvxKGBloRYoS24G+J8VIJ57mava5Ktt1p1HgQO1+J87y2hUFtV9yoNbPBWnrrZQL
         wRUw==
X-Forwarded-Encrypted: i=1; AJvYcCUnXFIdRSbTdOJ4Cy53eZYTCQmAncrfG5XzY1oyRJ+gGmQ/F5Ep45KRKZjfATiaS5LjQR8i06mZatDh9y1H@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp8SMZthWLMeM7oaxMsZQVxLEGM5CBR8x9X7n9wvNHNUNly9eG
	it6N2PKtE6B35AOZguifoGL+bQWeqmooKQmZsXEGeXJAD41bfARNs6+S
X-Gm-Gg: ASbGncvaGKhmAThHnBmCSXi/w/ia2wFT9EtBwcPpr/tMDbHSq9j6ajE9naOVnpkugWd
	F/O3kCceJTksGAreR5b0vzkstsymH9MVC+Wfp4tNMMVsuU1Pw8XTPlejC/xLuXSFeS5AC1u89wq
	wjQxjPnOGXhv+EmkF4MR5PE8OnTTO/2zcqlYVkCGRjFAbzkmIBE3YGwE6BGmnn9ByVOX8yMnT0p
	lsht3jQ0bmGKj6leHs8I2T1wmyNgWByZgaEhan0gNCnkI8J+XzdsrQ3UxJE0OeQCB+KlU10aF7X
	CubpvM6nCLbzLHkY+Dc3E4+zumtEyBhy8JplhXyYIgwkeMbjoYKQfS+OufC+3ybqNeK3OFKy05B
	ND38oK/ye1RHuFZTXB91aI2lIJ8NQ3e8TvT3kivF8SVtzWYPzqxfz9VRHAteVFaBfG7MLTvNOyA
	KDX/4gsJkFonnrNq1B1pi+8uUXaN7Et6JM
X-Google-Smtp-Source: AGHT+IH3ImJkM3/bzzYQyK/9TOJC1LdehI/1ru2uvVM6TTb9f7+7EjH48P+FdhY/X4IZrQot7gdX+w==
X-Received: by 2002:a17:907:d7ca:b0:b3d:a295:5445 with SMTP id a640c23a62f3a-b4f4116a343mr1423263866b.13.1759996791435;
        Thu, 09 Oct 2025 00:59:51 -0700 (PDT)
Received: from f.. (cst-prg-66-155.cust.vodafone.cz. [46.135.66.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5007639379sm553509366b.48.2025.10.09.00.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 00:59:50 -0700 (PDT)
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
Subject: [PATCH v7 07/14] ceph: use the new ->i_state accessors
Date: Thu,  9 Oct 2025 09:59:21 +0200
Message-ID: <20251009075929.1203950-8-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251009075929.1203950-1-mjguzik@gmail.com>
References: <20251009075929.1203950-1-mjguzik@gmail.com>
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

cheat sheet:

If ->i_lock is held, then:

state = inode->i_state          => state = inode_state_read(inode)
inode->i_state |= (I_A | I_B)   => inode_state_set(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B)  => inode_state_clear(inode, I_A | I_B)
inode->i_state = I_A | I_B      => inode_state_assign(inode, I_A | I_B)

If ->i_lock is not held or only held conditionally:

state = inode->i_state          => state = inode_state_read_once(inode)
inode->i_state |= (I_A | I_B)   => inode_state_set_raw(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B)  => inode_state_clear_raw(inode, I_A | I_B)
inode->i_state = I_A | I_B      => inode_state_assign_raw(inode, I_A | I_B)

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
index 978acd3d4b32..1c9d73523b88 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -741,7 +741,7 @@ static int ceph_finish_async_create(struct inode *dir, struct inode *inode,
 		      vino.ino, ceph_ino(dir), dentry->d_name.name);
 		ceph_dir_clear_ordered(dir);
 		ceph_init_inode_acls(inode, as_ctx);
-		if (inode->i_state & I_NEW) {
+		if (inode_state_read_once(inode) & I_NEW) {
 			/*
 			 * If it's not I_NEW, then someone created this before
 			 * we got here. Assume the server is aware of it at
@@ -903,7 +903,7 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 				new_inode = NULL;
 				goto out_req;
 			}
-			WARN_ON_ONCE(!(new_inode->i_state & I_NEW));
+			WARN_ON_ONCE(!(inode_state_read_once(new_inode) & I_NEW));
 
 			spin_lock(&dentry->d_lock);
 			di->flags |= CEPH_DENTRY_ASYNC_CREATE;
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 949f0badc944..4044a13969ad 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -132,7 +132,7 @@ struct inode *ceph_new_inode(struct inode *dir, struct dentry *dentry,
 			goto out_err;
 	}
 
-	inode->i_state = 0;
+	inode_state_assign_raw(inode, 0);
 	inode->i_mode = *mode;
 
 	err = ceph_security_init_secctx(dentry, *mode, as_ctx);
@@ -201,7 +201,7 @@ struct inode *ceph_get_inode(struct super_block *sb, struct ceph_vino vino,
 
 	doutc(cl, "on %llx=%llx.%llx got %p new %d\n",
 	      ceph_present_inode(inode), ceph_vinop(inode), inode,
-	      !!(inode->i_state & I_NEW));
+	      !!(inode_state_read_once(inode) & I_NEW));
 	return inode;
 }
 
@@ -228,7 +228,7 @@ struct inode *ceph_get_snapdir(struct inode *parent)
 		goto err;
 	}
 
-	if (!(inode->i_state & I_NEW) && !S_ISDIR(inode->i_mode)) {
+	if (!(inode_state_read_once(inode) & I_NEW) && !S_ISDIR(inode->i_mode)) {
 		pr_warn_once_client(cl, "bad snapdir inode type (mode=0%o)\n",
 				    inode->i_mode);
 		goto err;
@@ -261,7 +261,7 @@ struct inode *ceph_get_snapdir(struct inode *parent)
 		}
 	}
 #endif
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read_once(inode) & I_NEW) {
 		inode->i_op = &ceph_snapdir_iops;
 		inode->i_fop = &ceph_snapdir_fops;
 		ci->i_snap_caps = CEPH_CAP_PIN; /* so we can open */
@@ -270,7 +270,7 @@ struct inode *ceph_get_snapdir(struct inode *parent)
 
 	return inode;
 err:
-	if ((inode->i_state & I_NEW))
+	if ((inode_state_read_once(inode) & I_NEW))
 		discard_new_inode(inode);
 	else
 		iput(inode);
@@ -744,7 +744,7 @@ void ceph_evict_inode(struct inode *inode)
 
 	netfs_wait_for_outstanding_io(inode);
 	truncate_inode_pages_final(&inode->i_data);
-	if (inode->i_state & I_PINNING_NETFS_WB)
+	if (inode_state_read_once(inode) & I_PINNING_NETFS_WB)
 		ceph_fscache_unuse_cookie(inode, true);
 	clear_inode(inode);
 
@@ -1013,7 +1013,7 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 	      le64_to_cpu(info->version), ci->i_version);
 
 	/* Once I_NEW is cleared, we can't change type or dev numbers */
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read_once(inode) & I_NEW) {
 		inode->i_mode = mode;
 	} else {
 		if (inode_wrong_type(inode, mode)) {
@@ -1090,7 +1090,7 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 
 #ifdef CONFIG_FS_ENCRYPTION
 	if (iinfo->fscrypt_auth_len &&
-	    ((inode->i_state & I_NEW) || (ci->fscrypt_auth_len == 0))) {
+	    ((inode_state_read_once(inode) & I_NEW) || (ci->fscrypt_auth_len == 0))) {
 		kfree(ci->fscrypt_auth);
 		ci->fscrypt_auth_len = iinfo->fscrypt_auth_len;
 		ci->fscrypt_auth = iinfo->fscrypt_auth;
@@ -1692,13 +1692,13 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
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
 
@@ -1887,11 +1887,11 @@ static int readdir_prepopulate_inodes_only(struct ceph_mds_request *req,
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
 
@@ -2103,7 +2103,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 			pr_err_client(cl, "badness on %p %llx.%llx\n", in,
 				      ceph_vinop(in));
 			if (d_really_is_negative(dn)) {
-				if (in->i_state & I_NEW) {
+				if (inode_state_read_once(in) & I_NEW) {
 					ihold(in);
 					discard_new_inode(in);
 				}
@@ -2113,7 +2113,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 			err = ret;
 			goto next_item;
 		}
-		if (in->i_state & I_NEW)
+		if (inode_state_read_once(in) & I_NEW)
 			unlock_new_inode(in);
 
 		if (d_really_is_negative(dn)) {
-- 
2.34.1


