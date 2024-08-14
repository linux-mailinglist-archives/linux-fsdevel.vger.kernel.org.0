Return-Path: <linux-fsdevel+bounces-25905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF54B951A48
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 13:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 970F6281FF5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 11:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9B51B86E0;
	Wed, 14 Aug 2024 11:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="YjQ7TUuQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5521B583A
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 11:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723635698; cv=none; b=P4vRlTfFmrkCEKDAFskoaT9REjQGCf6TqBpbTTTA6vKlbILBY3CYBG1EYVtYYXZ9k645enjTTZG4UvifheDMW4PSwgTfGI6CzDx4tOAcNCmW6uJ0Xn6rCYOxPvcRhfmKO5QpdJqAhzbkao59LDXAmwAkVOCyptJnbxykvXPkVsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723635698; c=relaxed/simple;
	bh=RkuH2BauyDIocB2ovqLtoiU8KDMUmIFO0WjdtWi8Ntc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dO95h+/v5UKNi7zjJmQvcrcssJCmY/yuZnKkxWvzmzwlQEwwbU4hRTeHf1SvCXO79LxfUvK+Slg1caN93WKVUTZKPcMA2ARSLRZ2rEOlcyL0L6BM1DLLzWbc9lFLg0mJCS4ntbdk9/MBaJUUUKaG014wYQtY11oVh9bpMv9uNfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=YjQ7TUuQ; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 87D203F366
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 11:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723635695;
	bh=EYWyI91Y390dF1i7aBpa8hiQocB2iGszfdxdXheQ3fA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=YjQ7TUuQLRlb9VmOXQMxVw7sPFMQZofLEjo6XludMkeb6F4Gufr81szl7d7H9wmKT
	 nWNsUIxiyQrwsU2K1MNbX6+z+Bka1oFlTkCaMod6lEyBrHRxCCE/t0rbYgJIDBh5yb
	 HL7ZiGjNDkyBGmKPlmsJBxfljpI+gZHlFodavHhXecDpI6XA73/DZMnJXOtCPKRVjz
	 TS4jXtWT5KEvXUsz52t0BXv3yjwFPM08QcLFH/n1X/K0Gsgd+tD9Lp+lsaN/W8EWVf
	 8KyMgrrfa60+bYuUOcnsw+/FSJ4eLliH/WALflaUBvhUTaOUDxSSGbE2Y/WIl8GC/1
	 KkeJ9iDPvyjcA==
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52fcf2b5287so7287557e87.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 04:41:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723635695; x=1724240495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EYWyI91Y390dF1i7aBpa8hiQocB2iGszfdxdXheQ3fA=;
        b=oDXTeHVpc2/Od6HDSPviDuJdJYeoSBBpHnm83CLzfnOCVTaPzrZcrp2TZBNf+mQ1ji
         hfIH4PoNcH6Y583KOgW0czadaWL6y7zMuEcCgMfqkradtfV63gq/O2W4+yu9poChBIKd
         8yeTxfFhjYUv/qFjmNiWKKiJYTKiWgzXjKAdZF1ygMNl7okwuMg3diGJJHeH63oBnrCF
         i9ga56NKxkeiLn7H+fq0WPaHYcvtFUnmt4TOhp5it2Suda6kD+Hk+0EbJT8jlj0rimu7
         41u4dLlWCooPuM13JFXZvg5VyIan2nwgxBLCelLd9iJDbGqEcq/zk0a64dTVIYUrqAJp
         clWg==
X-Forwarded-Encrypted: i=1; AJvYcCVkZtmm6n/HArUD48riqyW5AuKTDK/ffc9qK/6q07okZ6QXAMl11pJwK/8wwRtYlFIoH1imvMoNIDtxCj/VEs83CSRAEGoUTNKINMYicg==
X-Gm-Message-State: AOJu0Yz/4JfIU2yasfYHK1408YkJnthOk+0/jOAAZFyBeMWiirFZ3ItS
	ba0S5WnbTEISYgy2hqS38Gm0RjS2QRDQ5f1MAARETUmsVWdjc6jg69iZGxfSWJZGs/ASjcIm8rX
	fePUCTLR2BX0oQlyM73D5Vz9LPFt8HJzG2zqD5VdT0zrFU06l/NnrMKoKuYP9SsKxLOlj3b5pRP
	+PyB8=
X-Received: by 2002:a05:6512:3e29:b0:530:ac7d:58b0 with SMTP id 2adb3069b0e04-532eda59b78mr1743721e87.5.1723635694767;
        Wed, 14 Aug 2024 04:41:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCfBqIBOYzImrNkJqxw9487Gp+jn3aeoKRLxLbNwK9pHzrLOBBIEwRhNOpnGklER7AE1/Q+g==
X-Received: by 2002:a05:6512:3e29:b0:530:ac7d:58b0 with SMTP id 2adb3069b0e04-532eda59b78mr1743704e87.5.1723635694319;
        Wed, 14 Aug 2024 04:41:34 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3fa782csm162586166b.60.2024.08.14.04.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 04:41:33 -0700 (PDT)
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
Subject: [PATCH v2 5/9] fs/fuse: support idmapped ->setattr op
Date: Wed, 14 Aug 2024 13:40:30 +0200
Message-Id: <20240814114034.113953-6-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814114034.113953-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240814114034.113953-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cc: Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: <linux-fsdevel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/fuse/dir.c    | 32 +++++++++++++++++++++-----------
 fs/fuse/file.c   |  2 +-
 fs/fuse/fuse_i.h |  4 ++--
 3 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index cd3b91b60cae..c50f951596dd 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1771,17 +1771,27 @@ static bool update_mtime(unsigned ivalid, bool trust_local_mtime)
 	return true;
 }
 
-static void iattr_to_fattr(struct fuse_conn *fc, struct iattr *iattr,
-			   struct fuse_setattr_in *arg, bool trust_local_cmtime)
+static void iattr_to_fattr(struct mnt_idmap *idmap, struct fuse_conn *fc,
+			   struct iattr *iattr, struct fuse_setattr_in *arg,
+			   bool trust_local_cmtime)
 {
 	unsigned ivalid = iattr->ia_valid;
 
 	if (ivalid & ATTR_MODE)
 		arg->valid |= FATTR_MODE,   arg->mode = iattr->ia_mode;
-	if (ivalid & ATTR_UID)
-		arg->valid |= FATTR_UID,    arg->uid = from_kuid(fc->user_ns, iattr->ia_uid);
-	if (ivalid & ATTR_GID)
-		arg->valid |= FATTR_GID,    arg->gid = from_kgid(fc->user_ns, iattr->ia_gid);
+
+	if (ivalid & ATTR_UID) {
+		kuid_t fsuid = from_vfsuid(idmap, fc->user_ns, iattr->ia_vfsuid);
+		arg->valid |= FATTR_UID;
+		arg->uid = from_kuid(fc->user_ns, fsuid);
+	}
+
+	if (ivalid & ATTR_GID) {
+		kgid_t fsgid = from_vfsgid(idmap, fc->user_ns, iattr->ia_vfsgid);
+		arg->valid |= FATTR_GID;
+		arg->gid = from_kgid(fc->user_ns, fsgid);
+	}
+
 	if (ivalid & ATTR_SIZE)
 		arg->valid |= FATTR_SIZE,   arg->size = iattr->ia_size;
 	if (ivalid & ATTR_ATIME) {
@@ -1901,8 +1911,8 @@ int fuse_flush_times(struct inode *inode, struct fuse_file *ff)
  * vmtruncate() doesn't allow for this case, so do the rlimit checking
  * and the actual truncation by hand.
  */
-int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
-		    struct file *file)
+int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
+		    struct iattr *attr, struct file *file)
 {
 	struct inode *inode = d_inode(dentry);
 	struct fuse_mount *fm = get_fuse_mount(inode);
@@ -1922,7 +1932,7 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 	if (!fc->default_permissions)
 		attr->ia_valid |= ATTR_FORCE;
 
-	err = setattr_prepare(&nop_mnt_idmap, dentry, attr);
+	err = setattr_prepare(idmap, dentry, attr);
 	if (err)
 		return err;
 
@@ -1981,7 +1991,7 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 
 	memset(&inarg, 0, sizeof(inarg));
 	memset(&outarg, 0, sizeof(outarg));
-	iattr_to_fattr(fc, attr, &inarg, trust_local_cmtime);
+	iattr_to_fattr(idmap, fc, attr, &inarg, trust_local_cmtime);
 	if (file) {
 		struct fuse_file *ff = file->private_data;
 		inarg.valid |= FATTR_FH;
@@ -2116,7 +2126,7 @@ static int fuse_setattr(struct mnt_idmap *idmap, struct dentry *entry,
 	if (!attr->ia_valid)
 		return 0;
 
-	ret = fuse_do_setattr(entry, attr, file);
+	ret = fuse_do_setattr(idmap, entry, attr, file);
 	if (!ret) {
 		/*
 		 * If filesystem supports acls it may have updated acl xattrs in
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f39456c65ed7..562bdf8d5976 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2966,7 +2966,7 @@ static void fuse_do_truncate(struct file *file)
 	attr.ia_file = file;
 	attr.ia_valid |= ATTR_FILE;
 
-	fuse_do_setattr(file_dentry(file), &attr, file);
+	fuse_do_setattr(file_mnt_idmap(file), file_dentry(file), &attr, file);
 }
 
 static inline loff_t fuse_round_up(struct fuse_conn *fc, loff_t off)
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index d06934e70cc5..883151a44d72 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1333,8 +1333,8 @@ bool fuse_write_update_attr(struct inode *inode, loff_t pos, ssize_t written);
 int fuse_flush_times(struct inode *inode, struct fuse_file *ff);
 int fuse_write_inode(struct inode *inode, struct writeback_control *wbc);
 
-int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
-		    struct file *file);
+int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
+		    struct iattr *attr, struct file *file);
 
 void fuse_set_initialized(struct fuse_conn *fc);
 
-- 
2.34.1


