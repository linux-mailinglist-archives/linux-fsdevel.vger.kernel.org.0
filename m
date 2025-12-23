Return-Path: <linux-fsdevel+bounces-71976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CB3CD92C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 13:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4BB03037539
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 12:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE843328F6;
	Tue, 23 Dec 2025 12:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="mhw3inuG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B7332E6AC
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 12:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766491542; cv=none; b=lsplpdbunPxchrpQD5eyqFwl8cfd7ZfiExNHJML5a816aYzNqNElfvYAj/70PBkAsR0t7/IwiH/Xmm9zJNq04lVzRvfRNALgRKSwjfkvnwTIKx7BwegRup6g9h/dZC5nRYJyEEjSNzTfuSPPKDFZS6h60z9tNv8qm5aViYQqk8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766491542; c=relaxed/simple;
	bh=2ieo10arz+brPKJFMI87VJq/NmMOxd7bYLSsc8X+9fM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B6vVtMyvEnCRe/52fTGmUiZEFkDy9JCVeTcHaB85FE0P2t0613sl6FAVxg/1M9PJKmO9EFcfgWWsleKoXkK0VSKrN+IjpucJ9IU+Qf/Utwh7Rv6YVFVi7r05P978EBZUlSpC3TrltdCM10AcxBZPR3fHADApseZkqBJ8yVKJcYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=mhw3inuG; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64b9dfc146fso5142271a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 04:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1766491539; x=1767096339; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k/YXFAj7aTNy6h2Rxea3NMcAMPvFs9nTrahKQ+j5ZUg=;
        b=mhw3inuG5HyZj9d4T+aPwlKs0AiFViTzd6hvBqFkgCwfQPR/BitTQIS9ygHpXg+Msz
         rEQD4l16EWjR4d/tERUxoJ7l3hFSk0Jv1u6CWn3njsCIqkTuAAqM4VXuFnOFQZKQaK7h
         Ff3nArFz1nuNQGyS21ESiHLISos80+zLVAlbFjK3+gre/Jc4aiSNoNqBbKQKf0jyAnlE
         hoxGHqkS8gAMs5R/bPJkj5lBOeFgoz4pjZV7IVEWXlL5CNdXKH3kyRMrB4SNwSuTAQKQ
         dT0QR3QjxAMbp6zVWOIVRikW3KZIUNQfYDEoGPb/s7oUPF5c26lGtnqxPkWMghz144Rp
         HlVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766491539; x=1767096339;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k/YXFAj7aTNy6h2Rxea3NMcAMPvFs9nTrahKQ+j5ZUg=;
        b=pzpEGHf2KeSj7IK5qPUJchJGSKhQPE1vEolBh7nvkZqObfdipcimqgo2aO4T2HbYLh
         JDQ9EsMVhkaErtSCx6lB20gflvCsWA0y9yO/2TMBEPbIHpYJ/fW15ac0EJdfdjM0a8nJ
         jCR0WaofTapvt4jzVhQUmh73zy1GU8sHh2SHgY2UzUw1+ArV08SOTPQaRvnRMWi8Q5I0
         VQ4stZ5Z7ZZZdzpOQeQFN9vyd5A9NE9V4y+fwwz+qj1JCpg+whp3iN0ekZ2Jg4xA20nm
         0JPZp2824uivBYhnM7QBTsbkdF3C/vof71swct2uLt5ce997Ys9uBoRJlDk7zK+KAWwJ
         cHMQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9V7oJbYJMzAVzS94k0cIuYM+KH9ImAIWJ6xZfxP6t6BWbHStlQ6VjuggvStnqTTZSYJcMFrpc+JYpXzuL@vger.kernel.org
X-Gm-Message-State: AOJu0YzmI5LgO79PO8DBx3mKR3UYmvSPZvrGMkAQOBMOgucLalwSZws2
	U0BNNsAV4f0oBUEsfC06DZ0Bx3kd3kT+iR0tQyiBZtJs//h/mpRwTS+U+PbbVw==
X-Gm-Gg: AY/fxX7q7kgi18mnLSwF8ML0J4UFf1mbCJ+S0hUlhxtarcyQrkGosYGkYrwshRF/ryQ
	FgBGmUViU99cgt6UVU2uHXtXAYiOxwBygCdiiesVU1JbWTUrvDYiDAsz+bpLsZRjT/zVp6agge4
	/PEFQ/Mlu/TOyiye2cV3X2wqnEVS659wyyOh/7z6gL8go4Xu/a5cfuuJl4QjH8xFa8CYnVAwiaP
	Mg5p0cOBQmfVHoUDzHVTcbNnLZZgtk+D6C3a/oht0tuisyLVYoVRP8dX6M4DZD0D1jjvSBNh2gt
	tWjGVg5K4X79NWsSQbsPUgIlCiKj6A+cPK0h1KICAwUu82lRDi5TNNS0NH1P3h5w8uT0mVTfKm1
	E7F2XoCVD3mM88UVKPPuLWe5GuN+qGc7fY+1VAYNOt8ETvS6g/FNezIsnjbWJGtDS18NvugZFVi
	pD8E3Dii7kzuyWOHPf/KU0nRjQ5LFx+e5758XUIs3A038HBFkC
X-Google-Smtp-Source: AGHT+IFeuGq4gDvEfLh3PK2/dArVoU6Q3VLO40+/E4d8G4cQcJ/hxhUfWRFhtBJgxjohGjsrLtzArQ==
X-Received: by 2002:aa7:c583:0:b0:62f:9091:ff30 with SMTP id 4fb4d7f45d1cf-64b58494a1bmr13461374a12.3.1766491539103;
        Tue, 23 Dec 2025 04:05:39 -0800 (PST)
Received: from [127.0.1.1] (178-062-210-188.ip-addr.inexio.net. [188.210.62.178])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b9105655asm13720460a12.9.2025.12.23.04.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 04:05:38 -0800 (PST)
From: Horst Birthelmer <hbirthelmer@googlemail.com>
X-Google-Original-From: Horst Birthelmer <hbirthelmer@ddn.com>
Date: Tue, 23 Dec 2025 13:05:30 +0100
Subject: [PATCH RFC 2/2] fuse: add an implementation of open+getattr
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-fuse-compounds-upstream-v1-2-7bade663947b@ddn.com>
References: <20251223-fuse-compounds-upstream-v1-0-7bade663947b@ddn.com>
In-Reply-To: <20251223-fuse-compounds-upstream-v1-0-7bade663947b@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Horst Birthelmer <hbirthelmer@ddn.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766491536; l=6870;
 i=hbirthelmer@ddn.com; s=20251006; h=from:subject:message-id;
 bh=2ieo10arz+brPKJFMI87VJq/NmMOxd7bYLSsc8X+9fM=;
 b=9Yjy+Yqd+iMunyIjCyA3kDg48B3wDh/Nn3PzWHahvCkzaf55Mc7lMMSvUSP0Zy9XC3IWwjwhY
 0fUEAwDq5FJDmy4kEqoc71IbZvBYZ8vdusy63WxhfE8HHstsksoNt7j
X-Developer-Key: i=hbirthelmer@ddn.com; a=ed25519;
 pk=v3BVDFoy16EzgHZ23ObqW+kbpURtjrwxgKu8YNDKjGg=

The discussion about compound commands in fuse was
started over an argument to add a new operation that
will open a file and return its attributes in the same operation.

Here is a demonstration of that use case with compound commands.

Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
---
 fs/fuse/file.c   | 115 +++++++++++++++++++++++++++++++++++++++++++++++--------
 fs/fuse/fuse_i.h |   6 ++-
 fs/fuse/inode.c  |   6 +++
 fs/fuse/ioctl.c  |   2 +-
 4 files changed, 111 insertions(+), 18 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 01bc894e9c2b..fd7f90f9f676 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -126,8 +126,74 @@ static void fuse_file_put(struct fuse_file *ff, bool sync)
 	}
 }
 
+static int fuse_compound_open_getattr(struct fuse_mount *fm, u64 nodeid,
+				int flags, int opcode,
+				struct fuse_file *ff,
+				struct fuse_attr_out *outattrp,
+				struct fuse_open_out *outargp)
+{
+	struct fuse_compound_req *compound;
+	struct fuse_args open_args = {}, getattr_args = {};
+	struct fuse_open_in open_in = {};
+	struct fuse_getattr_in getattr_in = {};
+	int err;
+
+	/* Build compound request with flag to execute in the given order */
+	compound = fuse_compound_alloc(fm, 0);
+	if (IS_ERR(compound))
+		return PTR_ERR(compound);
+
+	/* Add OPEN */
+	open_in.flags = flags & ~(O_CREAT | O_EXCL | O_NOCTTY);
+	if (!fm->fc->atomic_o_trunc)
+		open_in.flags &= ~O_TRUNC;
+
+	if (fm->fc->handle_killpriv_v2 &&
+	    (open_in.flags & O_TRUNC) && !capable(CAP_FSETID)) {
+		open_in.open_flags |= FUSE_OPEN_KILL_SUIDGID;
+	}
+	open_args.opcode = opcode;
+	open_args.nodeid = nodeid;
+	open_args.in_numargs = 1;
+	open_args.in_args[0].size = sizeof(open_in);
+	open_args.in_args[0].value = &open_in;
+	open_args.out_numargs = 1;
+	open_args.out_args[0].size = sizeof(struct fuse_open_out);
+	open_args.out_args[0].value = outargp;
+
+	err = fuse_compound_add(compound, &open_args);
+	if (err)
+		goto out;
+
+	/* Add GETATTR */
+	getattr_args.opcode = FUSE_GETATTR;
+	getattr_args.nodeid = nodeid;
+	getattr_args.in_numargs = 1;
+	getattr_args.in_args[0].size = sizeof(getattr_in);
+	getattr_args.in_args[0].value = &getattr_in;
+	getattr_args.out_numargs = 1;
+	getattr_args.out_args[0].size = sizeof(struct fuse_attr_out);
+	getattr_args.out_args[0].value = outattrp;
+
+	err = fuse_compound_add(compound, &getattr_args);
+	if (err)
+		goto out;
+
+	err = fuse_compound_send(compound);
+	if (err)
+		goto out;
+
+	ff->fh = outargp->fh;
+	ff->open_flags = outargp->open_flags;
+
+out:
+	fuse_compound_free(compound);
+	return err;
+}
+
 struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
-				 unsigned int open_flags, bool isdir)
+				struct inode *inode,
+				unsigned int open_flags, bool isdir)
 {
 	struct fuse_conn *fc = fm->fc;
 	struct fuse_file *ff;
@@ -153,23 +219,41 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 	if (open) {
 		/* Store outarg for fuse_finish_open() */
 		struct fuse_open_out *outargp = &ff->args->open_outarg;
-		int err;
+		int err = -ENOSYS;
+
+		if (inode && fc->compound_open_getattr) {
+			struct fuse_attr_out attr_outarg;
+			err = fuse_compound_open_getattr(fm, nodeid, open_flags,
+							opcode, ff, &attr_outarg, outargp);
+			if (!err)
+				fuse_change_attributes(inode, &attr_outarg.attr, NULL,
+						       ATTR_TIMEOUT(&attr_outarg),
+						       fuse_get_attr_version(fc));
+		}
+		if (err == -ENOSYS) {
+			err = fuse_send_open(fm, nodeid, open_flags, opcode, outargp);
 
-		err = fuse_send_open(fm, nodeid, open_flags, opcode, outargp);
-		if (!err) {
-			ff->fh = outargp->fh;
-			ff->open_flags = outargp->open_flags;
-		} else if (err != -ENOSYS) {
-			fuse_file_free(ff);
-			return ERR_PTR(err);
-		} else {
-			if (isdir) {
+			if (!err) {
+				ff->fh = outargp->fh;
+				ff->open_flags = outargp->open_flags;
+			}
+		}
+
+		if (err) {
+			if (err != -ENOSYS) {
+				/* err is not ENOSYS */
+				fuse_file_free(ff);
+				return ERR_PTR(err);
+			} else {
 				/* No release needed */
 				kfree(ff->args);
 				ff->args = NULL;
-				fc->no_opendir = 1;
-			} else {
-				fc->no_open = 1;
+
+				/* we don't have open */
+				if (isdir)
+					fc->no_opendir = 1;
+				else
+					fc->no_open = 1;
 			}
 		}
 	}
@@ -185,11 +269,10 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 int fuse_do_open(struct fuse_mount *fm, u64 nodeid, struct file *file,
 		 bool isdir)
 {
-	struct fuse_file *ff = fuse_file_open(fm, nodeid, file->f_flags, isdir);
+	struct fuse_file *ff = fuse_file_open(fm, nodeid, file_inode(file), file->f_flags, isdir);
 
 	if (!IS_ERR(ff))
 		file->private_data = ff;
-
 	return PTR_ERR_OR_ZERO(ff);
 }
 EXPORT_SYMBOL_GPL(fuse_do_open);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 86253517f59b..98af019037c3 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -924,6 +924,9 @@ struct fuse_conn {
 	/* Use io_uring for communication */
 	unsigned int io_uring;
 
+	/* Does the filesystem support compound operations? */
+	unsigned int compound_open_getattr:1;
+
 	/** Maximum stack depth for passthrough backing files */
 	int max_stack_depth;
 
@@ -1557,7 +1560,8 @@ void fuse_file_io_release(struct fuse_file *ff, struct inode *inode);
 
 /* file.c */
 struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
-				 unsigned int open_flags, bool isdir);
+								struct inode *inode,
+								unsigned int open_flags, bool isdir);
 void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 		       unsigned int open_flags, fl_owner_t id, bool isdir);
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 819e50d66622..a5fd721be96d 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -991,6 +991,12 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	fc->blocked = 0;
 	fc->initialized = 0;
 	fc->connected = 1;
+
+	/* pretend fuse server supports compound operations
+	 * until it tells us otherwise.
+	 */
+	fc->compound_open_getattr = 1;
+
 	atomic64_set(&fc->attr_version, 1);
 	atomic64_set(&fc->evict_ctr, 1);
 	get_random_bytes(&fc->scramble_key, sizeof(fc->scramble_key));
diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index fdc175e93f74..07a02e47b2c3 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -494,7 +494,7 @@ static struct fuse_file *fuse_priv_ioctl_prepare(struct inode *inode)
 	if (!S_ISREG(inode->i_mode) && !isdir)
 		return ERR_PTR(-ENOTTY);
 
-	return fuse_file_open(fm, get_node_id(inode), O_RDONLY, isdir);
+	return fuse_file_open(fm, get_node_id(inode), NULL, O_RDONLY, isdir);
 }
 
 static void fuse_priv_ioctl_cleanup(struct inode *inode, struct fuse_file *ff)

-- 
2.51.0


