Return-Path: <linux-fsdevel+bounces-26044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A53952C15
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 12:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BC1D1C22DEB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 10:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6463E20012A;
	Thu, 15 Aug 2024 09:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Z7vkY4PW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556801EB4B0
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2024 09:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723713896; cv=none; b=hfhzEkOyY99Xscsb1DGu6JRmYxOe8K5elLGxRNSaNHeJkFUUZIZFcKBxQ0sbPsJYNXkFZ93emDL36ijpp6dHDB308X0zigPzCw7sKVh2+QaE4RJL4yL/cxRY8CGd28oaTVDGs1j6YA4ncKi7VkOrg2AClh1Ywe5I0u24zM0vC7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723713896; c=relaxed/simple;
	bh=4eTUDWhrEbeO6LacpkSTpWZsQS6mjvQhzRI0A/zxHU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JwVH2PNweYkYOVxmw4b2ughgFHw8Fb8zLc+VHDj4CLbnZUtYy9xPQout7CwYOKsKjPNSJQocy1PRoSafDKv9vM8qikQZ1aW7mNYyYl1B2fW1M/Q2iQa5ZJAOTy/P7Cko3XpeACIfFlqLytr10OZ2sg5zrtdDUy3HQ5O29C7y4MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Z7vkY4PW; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 94FA73F1FC
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2024 09:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723713893;
	bh=cuULsUu9z+BvalrO9+cGgsIucfP8fxo4BNYi78/zGSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=Z7vkY4PWsL+FbY/LwaeQP8UReIhxt+pJEJJWHSi8C05CP0tueuJHk2gxuL9yW3+QR
	 4XSMyvnpi2Ju2vaQvqSl4KObuIEgc8+XQiqV3sYWbNg28oqwjUSupyP3CG2LS1GqWB
	 9KG4TBy3QHf1KwndLlrfi+3cyF6UElTL+ixjN4+ZZaApTG5ujPR2X6m11g48HWSbVw
	 CQ9jSrAI7iM4dk4rIS2WJLk84vOSam1T8Lr3JrFnwwa7AtbqiacEJ6bCn1ecJQS5i+
	 uA3m4r/CEddcLeY6tWswu5ZhMobWaHrwmWzUBvGMybZ+cPgOJZXFGHEwhCbuUNp3BE
	 6QsfrXUemHiVw==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a7d63fbf4afso85182666b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2024 02:24:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723713893; x=1724318693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cuULsUu9z+BvalrO9+cGgsIucfP8fxo4BNYi78/zGSU=;
        b=APoRAWZRZ0mwVK28eEp7uO8ooeLWQVDD/iPhB7iVdw0X3vL8wNS/vM9EoYHmOtTb/e
         DPlrUfi2B3wqVgZjZUbEw3cR+cil6h2qPIZXmaDTaWZ7QDKxNcWRvu/v2mp5wRJpioYC
         vsONeteiEWrCiX1J064KqzktfiooCsDjSTY1NZtzMr4cFPyR9enxjX6WlJHsUCYnHqgn
         AsOFP6Bm9DEYHBZnruemDC7gHtdP3X72uQqbOOkFSnC8z/gqK0dR3LLAbKDFNqq7t68E
         UfR21+Op2TGZqIJLNuig50Pfc5WU0G7Ks+uNhM9UqwtpGTM7PnQl2+fXpZYkCnWYsiLE
         jiHg==
X-Forwarded-Encrypted: i=1; AJvYcCVOASBl8+3sezvpiLCiaonuwN00xo9R2AvXYQMw+7H+rkw6mnrp6EM7bzcTstmAN+JpsAr/yPOyjENcHUmkyVi/zROQ5yPwSMl729uWlg==
X-Gm-Message-State: AOJu0YxxICgaaI9slQ2HqvbJJ16NTkLtbIu5xRdUIxck4V5/riXHX3g2
	TbaAHxLNYgjmRLR+Rf0qlMSKOl7OtaQkhSPyvihbHKU7abtebaRmBTv1n+r+pwX8U8XnXYj7BYe
	Pf1QI2yjgOUORrAP+AEk+SvOKf7wM+O8iDq85Jg31UH+UNqSa0KWYEOweTfcGSZSHAMawmna5KM
	fzVIE=
X-Received: by 2002:a17:907:e65f:b0:a7a:952b:95ae with SMTP id a640c23a62f3a-a8367058dbfmr391411666b.47.1723713892784;
        Thu, 15 Aug 2024 02:24:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHVQTlmRiIxSatjFzhhXDyxgdPLqtIwQZ41XRrUNboCAzF4zXXfl9MJmxs2xMNWOOI3Fsi2g==
X-Received: by 2002:a17:907:e65f:b0:a7a:952b:95ae with SMTP id a640c23a62f3a-a8367058dbfmr391410066b.47.1723713892276;
        Thu, 15 Aug 2024 02:24:52 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383934585sm72142866b.107.2024.08.15.02.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 02:24:51 -0700 (PDT)
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
Subject: [PATCH v3 03/11] fs/fuse: support idmap for mkdir/mknod/symlink/create
Date: Thu, 15 Aug 2024 11:24:20 +0200
Message-Id: <20240815092429.103356-4-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815092429.103356-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240815092429.103356-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have all the infrastructure in place, we just need
to pass an idmapping here.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: <linux-fsdevel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/fuse/dir.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 30d27d4f3b5a..1e45c6157af4 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -637,9 +637,9 @@ static void free_ext_value(struct fuse_args *args)
  * If the filesystem doesn't support this, then fall back to separate
  * 'mknod' + 'open' requests.
  */
-static int fuse_create_open(struct inode *dir, struct dentry *entry,
-			    struct file *file, unsigned int flags,
-			    umode_t mode, u32 opcode)
+static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
+			    struct dentry *entry, struct file *file,
+			    unsigned int flags, umode_t mode, u32 opcode)
 {
 	int err;
 	struct inode *inode;
@@ -696,7 +696,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	args.out_args[1].size = sizeof(*outopenp);
 	args.out_args[1].value = outopenp;
 
-	err = get_create_ext(&nop_mnt_idmap, &args, dir, entry, mode);
+	err = get_create_ext(idmap, &args, dir, entry, mode);
 	if (err)
 		goto out_put_forget_req;
 
@@ -757,6 +757,7 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 			    umode_t mode)
 {
 	int err;
+	struct mnt_idmap *idmap = file_mnt_idmap(file);
 	struct fuse_conn *fc = get_fuse_conn(dir);
 	struct dentry *res = NULL;
 
@@ -781,7 +782,7 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 	if (fc->no_create)
 		goto mknod;
 
-	err = fuse_create_open(dir, entry, file, flags, mode, FUSE_CREATE);
+	err = fuse_create_open(idmap, dir, entry, file, flags, mode, FUSE_CREATE);
 	if (err == -ENOSYS) {
 		fc->no_create = 1;
 		goto mknod;
@@ -792,7 +793,7 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 	return err;
 
 mknod:
-	err = fuse_mknod(&nop_mnt_idmap, dir, entry, mode, 0);
+	err = fuse_mknod(idmap, dir, entry, mode, 0);
 	if (err)
 		goto out_dput;
 no_open:
@@ -802,9 +803,9 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 /*
  * Code shared between mknod, mkdir, symlink and link
  */
-static int create_new_entry(struct fuse_mount *fm, struct fuse_args *args,
-			    struct inode *dir, struct dentry *entry,
-			    umode_t mode)
+static int create_new_entry(struct mnt_idmap *idmap, struct fuse_mount *fm,
+			    struct fuse_args *args, struct inode *dir,
+			    struct dentry *entry, umode_t mode)
 {
 	struct fuse_entry_out outarg;
 	struct inode *inode;
@@ -826,7 +827,7 @@ static int create_new_entry(struct fuse_mount *fm, struct fuse_args *args,
 	args->out_args[0].value = &outarg;
 
 	if (args->opcode != FUSE_LINK) {
-		err = get_create_ext(&nop_mnt_idmap, args, dir, entry, mode);
+		err = get_create_ext(idmap, args, dir, entry, mode);
 		if (err)
 			goto out_put_forget_req;
 	}
@@ -892,13 +893,13 @@ static int fuse_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	args.in_args[0].value = &inarg;
 	args.in_args[1].size = entry->d_name.len + 1;
 	args.in_args[1].value = entry->d_name.name;
-	return create_new_entry(fm, &args, dir, entry, mode);
+	return create_new_entry(idmap, fm, &args, dir, entry, mode);
 }
 
 static int fuse_create(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *entry, umode_t mode, bool excl)
 {
-	return fuse_mknod(&nop_mnt_idmap, dir, entry, mode, 0);
+	return fuse_mknod(idmap, dir, entry, mode, 0);
 }
 
 static int fuse_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
@@ -910,7 +911,7 @@ static int fuse_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 	if (fc->no_tmpfile)
 		return -EOPNOTSUPP;
 
-	err = fuse_create_open(dir, file->f_path.dentry, file, file->f_flags, mode, FUSE_TMPFILE);
+	err = fuse_create_open(idmap, dir, file->f_path.dentry, file, file->f_flags, mode, FUSE_TMPFILE);
 	if (err == -ENOSYS) {
 		fc->no_tmpfile = 1;
 		err = -EOPNOTSUPP;
@@ -937,7 +938,7 @@ static int fuse_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	args.in_args[0].value = &inarg;
 	args.in_args[1].size = entry->d_name.len + 1;
 	args.in_args[1].value = entry->d_name.name;
-	return create_new_entry(fm, &args, dir, entry, S_IFDIR);
+	return create_new_entry(idmap, fm, &args, dir, entry, S_IFDIR);
 }
 
 static int fuse_symlink(struct mnt_idmap *idmap, struct inode *dir,
@@ -953,7 +954,7 @@ static int fuse_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	args.in_args[0].value = entry->d_name.name;
 	args.in_args[1].size = len;
 	args.in_args[1].value = link;
-	return create_new_entry(fm, &args, dir, entry, S_IFLNK);
+	return create_new_entry(idmap, fm, &args, dir, entry, S_IFLNK);
 }
 
 void fuse_flush_time_update(struct inode *inode)
@@ -1147,7 +1148,7 @@ static int fuse_link(struct dentry *entry, struct inode *newdir,
 	args.in_args[0].value = &inarg;
 	args.in_args[1].size = newent->d_name.len + 1;
 	args.in_args[1].value = newent->d_name.name;
-	err = create_new_entry(fm, &args, newdir, newent, inode->i_mode);
+	err = create_new_entry(&nop_mnt_idmap, fm, &args, newdir, newent, inode->i_mode);
 	if (!err)
 		fuse_update_ctime_in_cache(inode);
 	else if (err == -EINTR)
-- 
2.34.1


