Return-Path: <linux-fsdevel+bounces-28418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DA896A201
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 17:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 373DEB276FE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 15:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DA018EFDC;
	Tue,  3 Sep 2024 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Hmozy3iG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C5818BBAF
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376622; cv=none; b=tRM9e1yB00+dDKr/8y42e/wYMDqwIDHzjZIN55dozC1HMzFTszDht/RuEaz+CJiaQITVqinwciMdoV/yNah1JebsvNMM3YOokgOk7R1YD8WJDyaLfzKbYuI8y+rI4hd/DyCMGKV8VAGLhgBIojdLX15OYLPUS4fkBuqMm7Qh12s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376622; c=relaxed/simple;
	bh=Yr7wQhBs5pebMPkKqO5eqjjytj+7qxLU8ExEBWlCpb0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SV9HYnyV+vvTnc0fxaq2v7c3GYy8558kw8zO8HVOzrN/VV2XBZlR+AiIo709j9/IizAUMHoWjxIDJrh3jdOA/r5CtcLA+QgqH7+9+wkTKv5mZJrOx5OOsR+xgPYi4RaBznpTgBQybN/tX8CGcGd8dSVfXRZX2/rm4SSL2NZvVVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Hmozy3iG; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 94F93400E1
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 15:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725376619;
	bh=BpXAW2lUVronVaNHhSb0yzusLu0aiPuPE022IFBzXL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=Hmozy3iGov6XJmRVuFVAN7TpJSUnoa0IsAhpyeIaYCtPh1Kw7lJ5AGaTIiw8RNWQa
	 1kWVSIRDwpAa/XeKb9FrlzArfvK0VLpctMjuBGzxS9lWq6FMQVoz37aZlTTE63bGUC
	 XaK3k8bA9ODLHcbaVun5AmXaC+4cNrxhqC/88L/3XZCJ5BEDgIrcDK7R0qdHcXkQQU
	 HAIgP4mCaSScZThGU3eQMBjCIRIMxW8Xb4xcx41MTh5Bth615HMm1mkwJiyC1aYh5M
	 KA7tCcVSUb9RbaU6oEwNQ4EQUTseZruT64ze6JygVqTPIfyDNMpsdcOQj8+xT4stTR
	 NBs5eKFszjyjQ==
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-53440ff1ecfso5784011e87.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2024 08:16:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725376618; x=1725981418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BpXAW2lUVronVaNHhSb0yzusLu0aiPuPE022IFBzXL8=;
        b=dNsu2WoXUFTYkAhXJsXWFdo8Y0zAmgR7h6DeNJejEEkY0D/bP+8SnRclIjuqu9cwq2
         5cITTgr1sU1XttzV7NrdjShb0K5Bo9mZP0i5UOXLQQtPpHKFYdK92/z2SFoUdMH2b8Iz
         HdNpYqxviQj7IWYe/i2kYJUaqXKv9Sm3jGTFtZrCWI9mCxdGd4JNee0m4U5c4+dWJCcW
         WoJjCoOGgy8CoIGT3FtFRRGZ4QloGLYULUPnUxxRxYXGMSVU6VyDAJ8jV3MI9Kg+EGZo
         PUKwBw3j8oVkC1bMMbLxO72TdjR/fHz1+l+HhulvZ/rjpPhztXOm+0rYkhkpB+KpzRvM
         qqag==
X-Forwarded-Encrypted: i=1; AJvYcCXTeSC+3tZx+Yr6kIrawEtmc2UUCiGGGod6GdQuvD3BUWjN4C1uu8UQWAfSlgOIMr3khVuCKsI/bnb7Sw/i@vger.kernel.org
X-Gm-Message-State: AOJu0YzkmPZ0h/CuGbqRPhQuw91lnXuVrbNznvnC0uvVb8aLoGBI84wm
	qrq/9G4UFROqy4MtSzV0xqdEsYWvqdjfjgClDzjP279AlENMdotqiq5/nNEox4S07UcCVnFCWRq
	nJKqPnxMtpKZHdfCKTuFLh9a4JdrukCrmtA8kQclgIRFOTroQ4mUBwFBofKM6CTwnglEHg8UAhR
	89pfY=
X-Received: by 2002:a05:6512:3b2b:b0:533:71f:3a53 with SMTP id 2adb3069b0e04-53546b053admr12510697e87.19.1725376618032;
        Tue, 03 Sep 2024 08:16:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdwhaHs8FzcWgy+bcSv/A5Fb3K4tgSBYe1Zj63ijkeXEFavmBE5n3V1565EXlaJFFrj2Oa4g==
X-Received: by 2002:a05:6512:3b2b:b0:533:71f:3a53 with SMTP id 2adb3069b0e04-53546b053admr12510667e87.19.1725376617503;
        Tue, 03 Sep 2024 08:16:57 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a19afb108sm156377166b.223.2024.09.03.08.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 08:16:57 -0700 (PDT)
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
Subject: [PATCH v4 05/15] fs/fuse: support idmap for mkdir/mknod/symlink/create/tmpfile
Date: Tue,  3 Sep 2024 17:16:16 +0200
Message-Id: <20240903151626.264609-6-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903151626.264609-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240903151626.264609-1-aleksandr.mikhalitsyn@canonical.com>
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
Reviewed-by: Christian Brauner <brauner@kernel.org>
---
v4:
	- pass idmapping to fuse_simple_request()
---
 fs/fuse/dir.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index b0b57f383889..19538b1c12e2 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -614,9 +614,9 @@ static void free_ext_value(struct fuse_args *args)
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
@@ -673,11 +673,11 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	args.out_args[1].size = sizeof(*outopenp);
 	args.out_args[1].value = outopenp;
 
-	err = get_create_ext(&nop_mnt_idmap, &args, dir, entry, mode);
+	err = get_create_ext(idmap, &args, dir, entry, mode);
 	if (err)
 		goto out_put_forget_req;
 
-	err = fuse_simple_request(NULL, fm, &args);
+	err = fuse_simple_request(idmap, fm, &args);
 	free_ext_value(&args);
 	if (err)
 		goto out_free_ff;
@@ -734,6 +734,7 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 			    umode_t mode)
 {
 	int err;
+	struct mnt_idmap *idmap = file_mnt_idmap(file);
 	struct fuse_conn *fc = get_fuse_conn(dir);
 	struct dentry *res = NULL;
 
@@ -758,7 +759,7 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 	if (fc->no_create)
 		goto mknod;
 
-	err = fuse_create_open(dir, entry, file, flags, mode, FUSE_CREATE);
+	err = fuse_create_open(idmap, dir, entry, file, flags, mode, FUSE_CREATE);
 	if (err == -ENOSYS) {
 		fc->no_create = 1;
 		goto mknod;
@@ -769,7 +770,7 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 	return err;
 
 mknod:
-	err = fuse_mknod(&nop_mnt_idmap, dir, entry, mode, 0);
+	err = fuse_mknod(idmap, dir, entry, mode, 0);
 	if (err)
 		goto out_dput;
 no_open:
@@ -779,9 +780,9 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
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
@@ -803,12 +804,12 @@ static int create_new_entry(struct fuse_mount *fm, struct fuse_args *args,
 	args->out_args[0].value = &outarg;
 
 	if (args->opcode != FUSE_LINK) {
-		err = get_create_ext(&nop_mnt_idmap, args, dir, entry, mode);
+		err = get_create_ext(idmap, args, dir, entry, mode);
 		if (err)
 			goto out_put_forget_req;
 	}
 
-	err = fuse_simple_request(NULL, fm, args);
+	err = fuse_simple_request(idmap, fm, args);
 	free_ext_value(args);
 	if (err)
 		goto out_put_forget_req;
@@ -869,13 +870,13 @@ static int fuse_mknod(struct mnt_idmap *idmap, struct inode *dir,
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
@@ -887,7 +888,7 @@ static int fuse_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 	if (fc->no_tmpfile)
 		return -EOPNOTSUPP;
 
-	err = fuse_create_open(dir, file->f_path.dentry, file, file->f_flags, mode, FUSE_TMPFILE);
+	err = fuse_create_open(idmap, dir, file->f_path.dentry, file, file->f_flags, mode, FUSE_TMPFILE);
 	if (err == -ENOSYS) {
 		fc->no_tmpfile = 1;
 		err = -EOPNOTSUPP;
@@ -914,7 +915,7 @@ static int fuse_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	args.in_args[0].value = &inarg;
 	args.in_args[1].size = entry->d_name.len + 1;
 	args.in_args[1].value = entry->d_name.name;
-	return create_new_entry(fm, &args, dir, entry, S_IFDIR);
+	return create_new_entry(idmap, fm, &args, dir, entry, S_IFDIR);
 }
 
 static int fuse_symlink(struct mnt_idmap *idmap, struct inode *dir,
@@ -930,7 +931,7 @@ static int fuse_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	args.in_args[0].value = entry->d_name.name;
 	args.in_args[1].size = len;
 	args.in_args[1].value = link;
-	return create_new_entry(fm, &args, dir, entry, S_IFLNK);
+	return create_new_entry(idmap, fm, &args, dir, entry, S_IFLNK);
 }
 
 void fuse_flush_time_update(struct inode *inode)
@@ -1124,7 +1125,7 @@ static int fuse_link(struct dentry *entry, struct inode *newdir,
 	args.in_args[0].value = &inarg;
 	args.in_args[1].size = newent->d_name.len + 1;
 	args.in_args[1].value = newent->d_name.name;
-	err = create_new_entry(fm, &args, newdir, newent, inode->i_mode);
+	err = create_new_entry(NULL, fm, &args, newdir, newent, inode->i_mode);
 	if (!err)
 		fuse_update_ctime_in_cache(inode);
 	else if (err == -EINTR)
-- 
2.34.1


