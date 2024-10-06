Return-Path: <linux-fsdevel+bounces-31113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF9A991D2E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 10:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51B3F280E1C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 08:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA151714BD;
	Sun,  6 Oct 2024 08:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kS6t5zex"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105C9170A0E;
	Sun,  6 Oct 2024 08:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728203049; cv=none; b=Mir1W6SA7jtJ4v2lA3IZiywZvn/hElx4YWSOucHWGq60StyGxcOIRy/vrIOeKljlcYYIbPzcK0VduYOSamDppwRUTjkOaEM7+UcUS5k96fVy8HacsJfdFnBS332/Iyuo+OIPJ5cFXemMAmb2FtGHq+t7LLM8tpj2F80XVLhaKR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728203049; c=relaxed/simple;
	bh=QMzq+1ebVy2XaR3Qa9/G67ngqH+RcG9apsABMCtHgMs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EvriUpMuiBJS0bodiAeqKlvOb78skHNIEH8Gwhisisamcvhhj0Z5lLxPCgFAjeX1VcjdVfXMeKuHkJ0JrbTbPDWcTdglVxYJ2HROLPvCrTfsQWU3vlIB+fiU20GMbhfJqixW03zlOxWV3s54hxud/39rhqGXbE72+wESsJVVb/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kS6t5zex; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9952ea05c5so2147766b.2;
        Sun, 06 Oct 2024 01:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728203046; x=1728807846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFPVmwMl47cpCVcgRpHwEB2nrCmqksp7mNnWXWma8OQ=;
        b=kS6t5zexw2EkSpRgfr19l5QLvp0t74nKM7fZ4M7yE8BouqTswrmkmzTIfp44n/T9Sl
         +POP+ff4lVlaH0JDhIzqDweKHqD92byLxhbYwlwKnAjZCsr/QyWFr61nxyQFXv35uL2W
         QjedwNXEkRZs+MYFH0Tdm47ChRrRfWbdyp3cBFTIWY1fgUSIcBNcfukHsKgeGEZbQJy7
         EIm1CfkzFLTCMXJ3NdMFtXnsixrsbd57iWD1u7350qif1ZDQsSj1lM4U6r0fTuCxQTrz
         2IvsVnfMjwatNydlogTcnffVJ1v2fGIDYWEWXlwecaLiuQZ4X3nStQzaFJuywYeonxtg
         zpRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728203046; x=1728807846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SFPVmwMl47cpCVcgRpHwEB2nrCmqksp7mNnWXWma8OQ=;
        b=T9QKBFn2CwhvsueOt9qe6PIAZaeQoXyNhEEMVBxjBTxrm51WWkgeMTxK4WNjfl6e6A
         iPIV9UHYyY01zpiPkXxJBLO7c+7feVjtL2rLK5/rLIFxOKFCc+LKui/dmnOEwFaLyGzW
         537SXC1DlFb4h/IC4wf46vGM7NGoNzpVY/P636kDMF8I5icYEj1gmXwDI/0MEGE64wRq
         XNwOHs8eAwQNsIgIuaxChrAJjuDXR0JcReHBUCA4XQ40ATieP2S28CTk/ie3K3WeGAXu
         mizSboa4AA4WYEFOc9hAMG++NfVLyEvBHJMegLn0/YDWLur84lgUgxxKiKa2snoxRrK2
         IqHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAdTxhO4yc1RESSuKZJaBlr5Nc/rPCIIzWS7im6d694kscrKDKAbBqNN0681bdsLWBHLnewL3ZF42LzvNl@vger.kernel.org, AJvYcCWGIpjN6vBQ7FA/VQs4+HfzZ2qvZoUdITwaF151aGRFLWkloa+FBKCeinH7BaKtPwoP9mjuQItS1FQ7+3q+Kw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBeod4Uyx5TZY5MZze8AqLdkRhN0fuP1RfrDVBB7ju51bsbcv1
	oc8ol3kujW+EdfFWKPQAHKijbkZDYnA49WAUYSjIlrKbT4YaSKW8
X-Google-Smtp-Source: AGHT+IFQpVz9QF6RRW+bJwyy1iwUp3E3Uxh5Q8X0Y85qf554xlk0Qg1S/UCz2O5p+o07bXsUnxq1Yw==
X-Received: by 2002:a17:907:2d88:b0:a86:a6ee:7dad with SMTP id a640c23a62f3a-a991c031471mr892738166b.52.1728203046002;
        Sun, 06 Oct 2024 01:24:06 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a993fdd2202sm153215766b.55.2024.10.06.01.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 01:24:05 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [PATCH v2 2/4] ovl: stash upper real file in backing_file struct
Date: Sun,  6 Oct 2024 10:23:57 +0200
Message-Id: <20241006082359.263755-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241006082359.263755-1-amir73il@gmail.com>
References: <20241006082359.263755-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an overlayfs file is opened as lower and then the file is copied up,
every operation on the overlayfs open file will open a temporary backing
file to the upper dentry and close it at the end of the operation.

The original (lower) real file is stored in file->private_data pointer.
We could have allocated another container struct for file->private_data
to potentially store two backing files, the lower and the upper.

However the original backing file struct is not very space optimized
(and it has no memcache pool), so add a private_data pointer to the
backing_file struct and store the optional second backing upper file in
there instead of opening a temporary upper file on every operation.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/file_table.c     |  7 +++++
 fs/internal.h       |  6 ++++
 fs/overlayfs/file.c | 70 +++++++++++++++++++++++++++++++++++++++------
 3 files changed, 74 insertions(+), 9 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index eed5ffad9997..1c2c08a5a66a 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -47,6 +47,7 @@ static struct percpu_counter nr_files __cacheline_aligned_in_smp;
 struct backing_file {
 	struct file file;
 	struct path user_path;
+	void *private_data;
 };
 
 static inline struct backing_file *backing_file(struct file *f)
@@ -60,6 +61,12 @@ struct path *backing_file_user_path(struct file *f)
 }
 EXPORT_SYMBOL_GPL(backing_file_user_path);
 
+void **backing_file_private_ptr(struct file *f)
+{
+	return &backing_file(f)->private_data;
+}
+EXPORT_SYMBOL_GPL(backing_file_private_ptr);
+
 static inline void file_free(struct file *f)
 {
 	security_file_free(f);
diff --git a/fs/internal.h b/fs/internal.h
index 8c1b7acbbe8f..b1152a3e8ba2 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -100,6 +100,12 @@ extern void chroot_fs_refs(const struct path *, const struct path *);
 struct file *alloc_empty_file(int flags, const struct cred *cred);
 struct file *alloc_empty_file_noaccount(int flags, const struct cred *cred);
 struct file *alloc_empty_backing_file(int flags, const struct cred *cred);
+void **backing_file_private_ptr(struct file *f);
+
+static inline void *backing_file_private(struct file *f)
+{
+	return READ_ONCE(*backing_file_private_ptr(f));
+}
 
 static inline void file_put_write_access(struct file *file)
 {
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index d40c10a6bfac..42f9bbdd65b4 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -14,6 +14,8 @@
 #include <linux/backing-file.h>
 #include "overlayfs.h"
 
+#include "../internal.h"	/* for backing_file_private{,_ptr}() */
+
 static char ovl_whatisit(struct inode *inode, struct inode *realinode)
 {
 	if (realinode != ovl_inode_upper(inode))
@@ -89,29 +91,70 @@ static int ovl_change_flags(struct file *file, unsigned int flags)
 	return 0;
 }
 
+static bool ovl_is_real_file(const struct file *realfile,
+			     const struct path *realpath)
+{
+	return file_inode(realfile) == d_inode(realpath->dentry);
+}
+
 static int ovl_real_fdget_path(const struct file *file, struct fd *real,
 			       struct path *realpath)
 {
 	struct file *realfile = file->private_data;
+	struct file *upperfile = backing_file_private(realfile);
 
-	real->word = (unsigned long)realfile;
+	real->word = 0;
 
 	if (WARN_ON_ONCE(!realpath->dentry))
 		return -EIO;
 
-	/* Has it been copied up since we'd opened it? */
-	if (unlikely(file_inode(realfile) != d_inode(realpath->dentry))) {
-		struct file *f = ovl_open_realfile(file, realpath);
-		if (IS_ERR(f))
-			return PTR_ERR(f);
-		real->word = (unsigned long)f | FDPUT_FPUT;
-		return 0;
+	/*
+	 * Usually, if we operated on a stashed upperfile once, all following
+	 * operations will operate on the stashed upperfile, but there is one
+	 * exception - ovl_fsync(datasync = false) can populate the stashed
+	 * upperfile to perform fsync on upper metadata inode.  In this case,
+	 * following read/write operations will not use the stashed upperfile.
+	 */
+	if (upperfile && likely(ovl_is_real_file(upperfile, realpath))) {
+		realfile = upperfile;
+		goto checkflags;
 	}
 
+	/*
+	 * If realfile is lower and has been copied up since we'd opened it,
+	 * open the real upper file and stash it in backing_file_private().
+	 */
+	if (unlikely(!ovl_is_real_file(realfile, realpath))) {
+		struct file *old;
+
+		/* Either stashed realfile or upperfile must match realinode */
+		if (WARN_ON_ONCE(upperfile))
+			return -EIO;
+
+		upperfile = ovl_open_realfile(file, realpath);
+		if (IS_ERR(upperfile))
+			return PTR_ERR(upperfile);
+
+		old = cmpxchg_release(backing_file_private_ptr(realfile), NULL,
+				      upperfile);
+		if (old) {
+			fput(upperfile);
+			upperfile = old;
+		}
+
+		/* Stashed upperfile that won the race must match realinode */
+		if (WARN_ON_ONCE(!ovl_is_real_file(upperfile, realpath)))
+			return -EIO;
+
+		realfile = upperfile;
+	}
+
+checkflags:
 	/* Did the flags change since open? */
 	if (unlikely((file->f_flags ^ realfile->f_flags) & ~OVL_OPEN_FLAGS))
 		return ovl_change_flags(realfile, file->f_flags);
 
+	real->word = (unsigned long)realfile;
 	return 0;
 }
 
@@ -192,7 +235,16 @@ static int ovl_open(struct inode *inode, struct file *file)
 
 static int ovl_release(struct inode *inode, struct file *file)
 {
-	fput(file->private_data);
+	struct file *realfile = file->private_data;
+	struct file *upperfile = backing_file_private(realfile);
+
+	fput(realfile);
+	/*
+	 * If realfile is lower and file was copied up and accessed, we need
+	 * to put reference also on the stashed real upperfile.
+	 */
+	if (upperfile)
+		fput(upperfile);
 
 	return 0;
 }
-- 
2.34.1


