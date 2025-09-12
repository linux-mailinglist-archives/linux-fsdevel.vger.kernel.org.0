Return-Path: <linux-fsdevel+bounces-61103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7734B55378
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 17:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 020BEAE2BD5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 15:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7EA30DEA5;
	Fri, 12 Sep 2025 15:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+1XLQwF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABD8221D96
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 15:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757690881; cv=none; b=gDi1GcGEhDO91V6QD1pmoxY1emVV/bobgCj8jInIvM2YzZF9vkGdv4tv9rULPFetl+CuwwjitiiVTSenR1PDdJZZBFcs4siUayYSU+v44k8+9kw7PynrzdF6gbvtakkjSQuVhxllLJikO526HQmtnY1hLlILSHvzpOibp1vqhEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757690881; c=relaxed/simple;
	bh=o0kkG3gbsibzPiYytCDeVsUKeybnHwvskBHSa2z0UkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jCJcg5BFX8ehsO6JDEm3ZYDMydcGh05cPdUBqLT+7t1m7djlUxaAow/wz7EguWUUQzbI5xFAW6uafR3TeQkFdNlHowRrYpFseqKzbNlZxjU4H2CNEufro8XfY/AqSK0ZOkyd+u+LMt7+ty1z33ZYBZYxrYcMDtRAyrIbObhlyPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+1XLQwF; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-77620a1d6bfso38075b3a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 08:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757690879; x=1758295679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tp5k30KObX2DHbYjNETNA0vsxWRW2WFebT5yQL1efcA=;
        b=A+1XLQwFscCw6MNFlM4Sw62ktqkXpIgfecNzQPJFiKzKufX4Waok8gksjCwvYo9Wn4
         J5gihhfAaH3VcP526h/p+981g31C7J/mYRC1WziqcNsPRowzs3yyxqR4F1npCGlC/YGQ
         k4uBEL+rsn+KZ94reGO/0owODjg28HATU/7f9FvMtMsP3wdhCkNVJSpxWew5yoQl3btw
         Pnxz6pfr06NQTjV26K86aF5tJ5yBwTIT2T1fuVTlVuJKtLy3dOb38qea9az3nlagOtQN
         KF2r4DWbCf8+gXfpdmO9jdgjAi9FIL+rwAwTNFSSPpCg25debTrH/VeYlkdBaMsaBzic
         qlcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757690879; x=1758295679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tp5k30KObX2DHbYjNETNA0vsxWRW2WFebT5yQL1efcA=;
        b=XDF+lPGkupPPNU+AXf79TWzK4WHvoyvTRgPxGxWWJ23qcH5qrNPEpiU/Cxf8WK/XQJ
         Lbk4cFiUwApgmXUd1DoWCdEg8kvrgEDd7h9WL32DHOQ92ym6xgbk56ZdSu0q2/KbXiB7
         1/ezM95Nk3OwXY1AlA0vYiPaDu+WZvrKk5Cxymvc8QW597L3RY5AudmRzn4pjy96HsHf
         rRfBE8fumSdfd/42WK78rQJdTgY3IEsnubyqi6AnBsvyBBSYQH2uQHFNa3deslvdQwX1
         K5QYk8Hd9+8vY8MK9l3GiY/3PNejZa65hxlgf+sGda8Uj7HOuQCgY109MjhErLUEmejX
         rLVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjD/RRXN9AfEABySnk+UVJj8Of7C2zkLs/uEhxERXF5llaXgGzZFzqvXbVpHcec7VkrHiI4T+C8DpRvqeM@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq0RKdcxJstOvfjysXcz5/zUKk/bxsjdCF5TPkgbjmhnz8AcL5
	v+GWiicAYsyLW+nCkIOnnif1napz7+BCFHNF8nGW8ButwE/S4vbOLmiQ
X-Gm-Gg: ASbGncuijvUryG8qjfsYhob4pgzNZ7WXQ+4k8g1zqLKehaEYDs4QsKNkAFTyRq4YBaG
	iEmxgp58Ve2GhIkT6oD97UtLe6cSwOXdbJ9tfKmFQDxuq2PlGM4uPWrKFxs3SsviFrpCOvdPqkM
	zZSO889hst78Mj0ZrW1C37iNpcrT4PwohuYsPix1tWJ2gtUwoSxI/xeQKTjwjYY36iBTbwTwI8o
	9rgcgE1z0EM4EOnG//wBgkqdrXzrHbRGdATTCmHdjU8mbbSv6dAmdLR0RYSaSgyE59tD7n4tz4q
	tGWbCKboGoAVUFNymJJPYFWZwDa9cAiIcOBFl62cGtWDpavvrUtRJhzz3yibvJnl5Z5YW3TSiJq
	3h1a2zijpxgt9L9Rub2IUF9LTqw==
X-Google-Smtp-Source: AGHT+IEHoyPuPNjRXMF6D9AbSE9Owm5HszgJnuRdDm6U9PHJUuzC7ORv4NWPgIIfR+wfu5arnCEw/w==
X-Received: by 2002:a05:6a21:6d9c:b0:243:c5a9:4309 with SMTP id adf61e73a8af0-2602a09ffa6mr3679449637.20.1757690879236;
        Fri, 12 Sep 2025 08:27:59 -0700 (PDT)
Received: from jicarita ([65.144.169.45])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7760944a9a9sm5436846b3a.78.2025.09.12.08.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:27:58 -0700 (PDT)
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
Subject: [PATCH v3 07/10] exportfs: new FILEID_CACHED flag for non-blocking fh lookup
Date: Fri, 12 Sep 2025 09:28:52 -0600
Message-ID: <20250912152855.689917-8-tahbertschinger@gmail.com>
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

This defines a new flag FILEID_CACHED that the VFS can set in the
handle_type field of struct file_handle to request that the FS
implementations of fh_to_{dentry,parent}() only complete if they can
satisfy the request with cached data.

Because not every FS implementation will recognize this new flag, those
that do recognize the flag can indicate their support using a new
export flag, EXPORT_OP_NONBLOCK.

If FILEID_CACHED is set in a file handle, but the filesystem does not
set EXPORT_OP_NONBLOCK, then the VFS will return -EAGAIN without
attempting to call into the filesystem code.

exportfs_decode_fh_raw() is updated to respect the new flag by returning
-EAGAIN when it would need to do an operation that may not be possible
with only cached data.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Thomas Bertschinger <tahbertschinger@gmail.com>
---
I didn't apply Amir's Reviewed-by for this patch because I added the
Documenation section, which was not reviewed in v2.

 Documentation/filesystems/nfs/exporting.rst |  6 ++++++
 fs/exportfs/expfs.c                         | 12 ++++++++++++
 fs/fhandle.c                                |  2 ++
 include/linux/exportfs.h                    |  5 +++++
 4 files changed, 25 insertions(+)

diff --git a/Documentation/filesystems/nfs/exporting.rst b/Documentation/filesystems/nfs/exporting.rst
index de64d2d002a2..70f46eaeb0d4 100644
--- a/Documentation/filesystems/nfs/exporting.rst
+++ b/Documentation/filesystems/nfs/exporting.rst
@@ -238,3 +238,9 @@ following flags are defined:
     all of an inode's dirty data on last close. Exports that behave this
     way should set EXPORT_OP_FLUSH_ON_CLOSE so that NFSD knows to skip
     waiting for writeback when closing such files.
+
+  EXPORT_OP_NONBLOCK - FS supports fh_to_{dentry,parent}() using cached data
+    When performing open_by_handle_at(2) using io_uring, it is useful to
+    complete the file open using only cached data when possible, otherwise
+    failing with -EAGAIN.  This flag indicates that the filesystem supports this
+    mode of operation.
diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index 949ce6ef6c4e..e2cfdd9d6392 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -441,6 +441,7 @@ exportfs_decode_fh_raw(struct vfsmount *mnt, struct fid *fid, int fh_len,
 		       void *context)
 {
 	const struct export_operations *nop = mnt->mnt_sb->s_export_op;
+	bool decode_cached = fileid_type & FILEID_CACHED;
 	struct dentry *result, *alias;
 	char nbuf[NAME_MAX+1];
 	int err;
@@ -453,6 +454,10 @@ exportfs_decode_fh_raw(struct vfsmount *mnt, struct fid *fid, int fh_len,
 	 */
 	if (!exportfs_can_decode_fh(nop))
 		return ERR_PTR(-ESTALE);
+
+	if (decode_cached && !(nop->flags & EXPORT_OP_NONBLOCK))
+		return ERR_PTR(-EAGAIN);
+
 	result = nop->fh_to_dentry(mnt->mnt_sb, fid, fh_len, fileid_type);
 	if (IS_ERR_OR_NULL(result))
 		return result;
@@ -481,6 +486,10 @@ exportfs_decode_fh_raw(struct vfsmount *mnt, struct fid *fid, int fh_len,
 		 * filesystem root.
 		 */
 		if (result->d_flags & DCACHE_DISCONNECTED) {
+			err = -EAGAIN;
+			if (decode_cached)
+				goto err_result;
+
 			err = reconnect_path(mnt, result, nbuf);
 			if (err)
 				goto err_result;
@@ -526,6 +535,9 @@ exportfs_decode_fh_raw(struct vfsmount *mnt, struct fid *fid, int fh_len,
 		err = PTR_ERR(target_dir);
 		if (IS_ERR(target_dir))
 			goto err_result;
+		err = -EAGAIN;
+		if (decode_cached && (target_dir->d_flags & DCACHE_DISCONNECTED))
+			goto err_result;
 
 		/*
 		 * And as usual we need to make sure the parent directory is
diff --git a/fs/fhandle.c b/fs/fhandle.c
index 2dc669aeb520..509ff8983f94 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -273,6 +273,8 @@ static int do_handle_to_path(struct file_handle *handle, struct path *path,
 	if (IS_ERR_OR_NULL(dentry)) {
 		if (dentry == ERR_PTR(-ENOMEM))
 			return -ENOMEM;
+		if (dentry == ERR_PTR(-EAGAIN))
+			return -EAGAIN;
 		return -ESTALE;
 	}
 	path->dentry = dentry;
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 30a9791d88e0..8238b6f67956 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -199,6 +199,8 @@ struct handle_to_path_ctx {
 #define FILEID_FS_FLAGS_MASK	0xff00
 #define FILEID_FS_FLAGS(flags)	((flags) & FILEID_FS_FLAGS_MASK)
 
+#define FILEID_CACHED		0x100 /* Use only cached data when decoding handle */
+
 /* User flags: */
 #define FILEID_USER_FLAGS_MASK	0xffff0000
 #define FILEID_USER_FLAGS(type) ((type) & FILEID_USER_FLAGS_MASK)
@@ -303,6 +305,9 @@ struct export_operations {
 						*/
 #define EXPORT_OP_FLUSH_ON_CLOSE	(0x20) /* fs flushes file data on close */
 #define EXPORT_OP_NOLOCKS		(0x40) /* no file locking support */
+#define EXPORT_OP_NONBLOCK		(0x80) /* Filesystem supports non-
+						  blocking fh_to_dentry()
+						*/
 	unsigned long	flags;
 };
 
-- 
2.51.0


