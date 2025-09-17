Return-Path: <linux-fsdevel+bounces-62049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC00CB824BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 01:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 940DC2A7BFF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 23:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C63931282B;
	Wed, 17 Sep 2025 23:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="HQQI1cNT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5A7312816;
	Wed, 17 Sep 2025 23:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758151668; cv=none; b=QzkY2QLhD2OS7t/sULqKCxo7SRK4EVQmnKxDL1KaxHKlYM+LBzKxZwd24jnbFgeAIHruniEhHEdR4viDEG71PhdRirq1KbVsi+qsjxJTnVjZTb75ZLmlfOYWHl8AnxZx2QdPpeppJWlOrcxhZgr5Quy1yhV5mE5km1sBZD9QrSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758151668; c=relaxed/simple;
	bh=wUsvu5Z3YZ8nFnq3iTdvwnGp/cW9pYTtb5yrsdZTPhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=flRTzWS3nbtzRSWsBYd0undvr+J5cyaNwVvC/ax64NoefdFF6MSsouDLR4pOKwdyEAsk293O7nfDNeGp7ubW+/HRmB0G0uenHfOZfmv7Qn9UMmQ+Ha2dmLIsLMnnQUfDqwg+r0+2alml2yTYaQh9rlCdrfAXuXa2ONUtR5MZjMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=HQQI1cNT; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=VUSe3l0LUpPbeK04CKeztYBHcm0Rupub+vQbyuw3pOs=; b=HQQI1cNT71eJAszMsWjJuknyVD
	rzqKNP5kz1F95VxTpLl5LFL5lNq7RfDRaIiqnwfVkg2NQClur8uzzLKfjDG32r1ATPVrHEwB1kESL
	2PsaZShkXrF4XhoNaMYB90dIyYmqr7e+KNefiV+HDk+Vsd0kUlSDSyM3x/z5b4PaXeOG8BulR0ka6
	Rv/7nU4EuRuTc2kd5TbBjcBmLIRgj0U8OoXJ/LxTB104VVtsch9hR6HyGRlGAxFzmzRSscUkQ/6Hm
	2LCrAMIgCJx4S2kjgGcSOGH1yWc01zeBZQ6r0+hLdVGx6M6e9d6AgCBT90ZKwOWuGPqZMIOmZ18i6
	BDwh7vIw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz1Yn-0000000Aj5y-1str;
	Wed, 17 Sep 2025 23:27:37 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: v9fs@lists.linux.dev,
	miklos@szeredi.hu,
	agruenba@redhat.com,
	linux-nfs@vger.kernel.org,
	hansg@kernel.org,
	linux-cifs@vger.kernel.org
Subject: [PATCH 5/9] simplify vboxsf_dir_atomic_open()
Date: Thu, 18 Sep 2025 00:27:32 +0100
Message-ID: <20250917232736.2556586-5-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250917232736.2556586-1-viro@zeniv.linux.org.uk>
References: <20250917232416.GG39973@ZenIV>
 <20250917232736.2556586-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

similar to 9p et.al.

Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/vboxsf/dir.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
index 770e29ec3557..42bedc4ec7af 100644
--- a/fs/vboxsf/dir.c
+++ b/fs/vboxsf/dir.c
@@ -315,46 +315,39 @@ static int vboxsf_dir_atomic_open(struct inode *parent, struct dentry *dentry,
 {
 	struct vboxsf_sbi *sbi = VBOXSF_SBI(parent->i_sb);
 	struct vboxsf_handle *sf_handle;
-	struct dentry *res = NULL;
 	u64 handle;
 	int err;
 
 	if (d_in_lookup(dentry)) {
-		res = vboxsf_dir_lookup(parent, dentry, 0);
-		if (IS_ERR(res))
-			return PTR_ERR(res);
-
-		if (res)
-			dentry = res;
+		struct dentry *res = vboxsf_dir_lookup(parent, dentry, 0);
+		if (res || d_really_is_positive(dentry))
+			return finish_no_open(file, res);
 	}
 
 	/* Only creates */
-	if (!(flags & O_CREAT) || d_really_is_positive(dentry))
-		return finish_no_open(file, res);
+	if (!(flags & O_CREAT))
+		return finish_no_open(file, NULL);
 
 	err = vboxsf_dir_create(parent, dentry, mode, false, flags & O_EXCL, &handle);
 	if (err)
-		goto out;
+		return err;
 
 	sf_handle = vboxsf_create_sf_handle(d_inode(dentry), handle, SHFL_CF_ACCESS_READWRITE);
 	if (IS_ERR(sf_handle)) {
 		vboxsf_close(sbi->root, handle);
-		err = PTR_ERR(sf_handle);
-		goto out;
+		return PTR_ERR(sf_handle);
 	}
 
 	err = finish_open(file, dentry, generic_file_open);
 	if (err) {
 		/* This also closes the handle passed to vboxsf_create_sf_handle() */
 		vboxsf_release_sf_handle(d_inode(dentry), sf_handle);
-		goto out;
+		return err;
 	}
 
 	file->private_data = sf_handle;
 	file->f_mode |= FMODE_CREATED;
-out:
-	dput(res);
-	return err;
+	return 0;
 }
 
 static int vboxsf_dir_unlink(struct inode *parent, struct dentry *dentry)
-- 
2.47.3


