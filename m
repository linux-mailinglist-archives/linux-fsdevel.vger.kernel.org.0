Return-Path: <linux-fsdevel+bounces-61102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CF3B55371
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 17:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 759021D68050
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 15:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9FA221DB0;
	Fri, 12 Sep 2025 15:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFsWz68d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4632D309EEC
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 15:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757690875; cv=none; b=XkvEf3aoW2M69Me2oIcwBKIPxwRRdsFzROJLKErOFBQs1C3MLh+aLqRTYMH7HLB3rFBwMeIbABSyJE2XSIiatBytak2IfHfhH/BU4HjVajh6jZ5xrLtoibJ5IZpGuK6Eb01GFvUhwY8pJOl3OykDJjVe32Ws9LrdaNLKZmBBx94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757690875; c=relaxed/simple;
	bh=XsFT/IwIeCNwjH7INLvGpvbx+PBWYaIu3SRJqPiVCuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GVrnqwOFzys81t+RBNStbPiuKChaGtAd35p8Cez0bwW3VlXeKCZmk4gi/z+MtzaJb9dtYCZHUS0leRsb/6Mq3X9gHpqKvKosy6pq4j14/tgeI3RJw6hdkYzUt68tnkgEe1cMaa+WI9yysOi9A6GRojxLS6iOJTYEgTCIwKOXuwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFsWz68d; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-32d3e17d95dso1513757a91.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 08:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757690873; x=1758295673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KQqfXYDSkx+KIBX1m2qzvvqxw26HH8BbdvvTnVzTEI=;
        b=dFsWz68dPPCRIP1jZs+OtCrgkFKL8nkG43kCPpQVv4fWjYL29Qx4J5Cl3KnubLi8yl
         wBR98SEKlyWKDHT1dWtnmTHhfKtQImzspjcNpBH1xj+chHgkU6CkW2gwWUJAynz/8SgW
         A3vwdAhujDnSWbrsC2QLegahiafzA2LNxRsjBWIP0XVMCCmCU3O71eBCDd1gBrwiw/NR
         WAxCNjxxrrAJ329rsHIiJjBKhpYSdZMcNfPCFar8MssRMti7uLys6OcBKeNgJSxdhhFC
         oXhOsDz/H9sDTkqbQQHmvcIlPK+Cm1Gwh0rVhPD5AmeLzajF/KGAEOClbtvjjItlqXhF
         H0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757690874; x=1758295674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KQqfXYDSkx+KIBX1m2qzvvqxw26HH8BbdvvTnVzTEI=;
        b=Pf7VdZX/+37BI8U89jRUmCnqTupxgViI70reGroMK1AaZv6O2xjJ+uWsKT42aIVy1t
         7RwJvbH00uNAewUsMaCq62+LPhhndCOdfyYto1akLeilS4wPiFiTrABlvY/OS0Z7dNas
         8IEXryEm94pDCq8yqz1JqB7/BNbxuHHnCEGmN2gsqAVZi2IaZbfZ3dU3zJ/MnQKa9nIR
         f2LmhqvD2aL8OfheWzsXcD3GjUFiBztooXFvKxeL4yz93qM7KfBnIUCI6ZgdUqTUwFLd
         wBDbqJRJZq++b3n91AEmygRXtNAdE+CIwJn8UuPu3jMfM/ZKP0x94b6dLszHhd6Gh+XH
         hfAA==
X-Forwarded-Encrypted: i=1; AJvYcCVOEozvPwtgdeNg4XcMd+pV/Dzk0Htc90iYw9e4Id2G5qSUb4dvEXK3z0Cnb/iEAabeNTnriKIe61/fzI+0@vger.kernel.org
X-Gm-Message-State: AOJu0YyspblS1W2NUnW3X5vBYc/6Ehi4Zx0RBKrSHi6M7CoSJ8UoKEzZ
	1oCrVI1B23XzJ/n+HcV5UKBFxbF5tdw7awjnHjso2YMZjenyt+oUwTK0
X-Gm-Gg: ASbGncuDKkdyfYcZuyYtPkf2Hv/9XYKcRxsOJqMnhFysnuxkJzutC0tTNZEhUzqL1R+
	t+srwhW0A0gkGH9tH2NLAwpRGuyebicfl5pXHWs5cD45EHMuJhgBA5cmZGTD60Ny6WnDI47kiy8
	M+zwBI6hCPCRuooem83hiSd6LS6VkRUJR3XgCxgtrHoUZ89vTnWrJAtWjBJuXA+MvT95v0204bp
	LeUp7pMcErV/wSL3oI8satlVuAOJ5mzbMNodAgNnUFV8iFE0mBq2YML2Tv1mm7t2hoRW4HG5L7V
	MRTNligDylH0ukvJxkR/rvNRS93Ftn02BIRM3TdjDCloBrn/+nReH3IKuUgAPv48gKvj5rBzbbD
	XzTJPMrhgCiqvRjkZhpZhfc9fR0nLiFBXI7PCqfCtp1xx1xE=
X-Google-Smtp-Source: AGHT+IGnJ9VsaACt1AKMpATeUxCkpqJjFHaj0qnzXlJqT//M/R/kbT4Nqz/SiCiV3gK94hMaThYifg==
X-Received: by 2002:a17:90b:2787:b0:32d:f315:7b59 with SMTP id 98e67ed59e1d1-32df3157cb2mr1737440a91.21.1757690873540;
        Fri, 12 Sep 2025 08:27:53 -0700 (PDT)
Received: from jicarita ([65.144.169.45])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7760944a9a9sm5436846b3a.78.2025.09.12.08.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:27:53 -0700 (PDT)
From: Thomas Bertschinger <tahbertschinger@gmail.com>
To: io-uring@vger.kernel.org,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	linux-nfs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	cem@kernel.org,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	amir73il@gmail.com
Cc: Thomas Bertschinger <tahbertschinger@gmail.com>
Subject: [PATCH v3 06/10] exportfs: allow VFS flags in struct file_handle
Date: Fri, 12 Sep 2025 09:28:51 -0600
Message-ID: <20250912152855.689917-7-tahbertschinger@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250912152855.689917-1-tahbertschinger@gmail.com>
References: <20250912152855.689917-1-tahbertschinger@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The handle_type field of struct file_handle is already being used to
pass "user" flags to open_by_handle_at() in the upper 16 bits.

Bits 8..15 are still unused, as FS implementations are expected to only
set the lower 8 bits.

This change prepares the VFS to pass flags to FS implementations of
fh_to_{dentry,parent}() using the previously unused bits 8..15 of
handle_type.

The user is prevented from setting VFS flags in a file handle--such a
handle will be rejected by open_by_handle_at(2). Only the VFS can set
those flags before passing the handle to the FS.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Thomas Bertschinger <tahbertschinger@gmail.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/exportfs/expfs.c      |  2 +-
 fs/fhandle.c             |  2 +-
 include/linux/exportfs.h | 29 ++++++++++++++++++++++++++---
 3 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index d3e55de4a2a2..949ce6ef6c4e 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -391,7 +391,7 @@ int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
 	else
 		type = nop->encode_fh(inode, fid->raw, max_len, parent);
 
-	if (type > 0 && FILEID_USER_FLAGS(type)) {
+	if (type > 0 && (type & ~FILEID_HANDLE_TYPE_MASK)) {
 		pr_warn_once("%s: unexpected fh type value 0x%x from fstype %s.\n",
 			     __func__, type, inode->i_sb->s_type->name);
 		return -EINVAL;
diff --git a/fs/fhandle.c b/fs/fhandle.c
index 7cc17e03e632..2dc669aeb520 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -342,7 +342,7 @@ struct file_handle *get_user_handle(struct file_handle __user *ufh)
 	    (f_handle.handle_bytes == 0))
 		return ERR_PTR(-EINVAL);
 
-	if (f_handle.handle_type < 0 ||
+	if (f_handle.handle_type < 0 || FILEID_FS_FLAGS(f_handle.handle_type) ||
 	    FILEID_USER_FLAGS(f_handle.handle_type) & ~FILEID_VALID_USER_FLAGS)
 		return ERR_PTR(-EINVAL);
 
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index cfb0dd1ea49c..30a9791d88e0 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -173,10 +173,33 @@ struct handle_to_path_ctx {
 #define EXPORT_FH_DIR_ONLY	0x4 /* Only decode file handle for a directory */
 
 /*
- * Filesystems use only lower 8 bits of file_handle type for fid_type.
- * name_to_handle_at() uses upper 16 bits of type as user flags to be
- * interpreted by open_by_handle_at().
+ * The 32 bits of the handle_type field of struct file_handle are used for a few
+ * different purposes:
+ *
+ *   Filesystems use only lower 8 bits of file_handle type for fid_type.
+ *
+ *   VFS uses bits 8..15 of the handle_type to pass flags to the FS
+ *   implementation of fh_to_{dentry,parent}().
+ *
+ *   name_to_handle_at() uses upper 16 bits of type as user flags to be
+ *   interpreted by open_by_handle_at().
+ *
+ *  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ *  |           user flags          |   VFS flags   |   fid_type    |
+ *  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ *  (MSB)                                                       (LSB)
+ *
+ * Filesystems are expected not to fill in any bits outside of fid_type in
+ * their encode_fh() implementation.
  */
+#define FILEID_HANDLE_TYPE_MASK	0xff
+#define FILEID_TYPE(type)	((type) & FILEID_HANDLE_TYPE_MASK)
+
+/* VFS flags: */
+#define FILEID_FS_FLAGS_MASK	0xff00
+#define FILEID_FS_FLAGS(flags)	((flags) & FILEID_FS_FLAGS_MASK)
+
+/* User flags: */
 #define FILEID_USER_FLAGS_MASK	0xffff0000
 #define FILEID_USER_FLAGS(type) ((type) & FILEID_USER_FLAGS_MASK)
 
-- 
2.51.0


