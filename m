Return-Path: <linux-fsdevel+bounces-56679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2357B1A8AA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 19:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BE9A3B8F8E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 17:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D682264CC;
	Mon,  4 Aug 2025 17:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uP56rsh4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D21B224B1B
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Aug 2025 17:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754328758; cv=none; b=fbxGbeuIRWqB556eG70uIqlvDkSIDL9mokcZyTVxAPAdifL3P+SZaNiWUuhwszvwa5iAFjDhr9BEhlGXCUvq38/Kw1f8Ldj2r7+1PwEIlONgXTqeyPKBqPwRflmA+z0yXNnNRDzXy8rnWzh20w+hRJU/gUIS6GqkaKISFNY0kEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754328758; c=relaxed/simple;
	bh=CR9Dt1wH26vHE1YX5/CJIpyp8jDX/bTop8QDdnBP+8M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kIL0f0B8yvMnutn+rdGdNgtMlexHjIFqMYy0QFRqWIodXnxoR0S/iHU9Zh/R20i7u0jHGRfC5RcYJh3u2yvaKOXKtLjhA0NDu2xEcdqO5CGL+LQuvyTApSmOSHplB3oLvFB85OUSz84DhqD7gbff1L23OunTUMT4ciDeqtvJv9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--paullawrence.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uP56rsh4; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--paullawrence.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76bfab12672so3357247b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Aug 2025 10:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754328756; x=1754933556; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q+fFbis65lzN6iN3E1Il6cAJENCj+5dg3T9v8McMK64=;
        b=uP56rsh48J9+H3ZIn8rvFE8SH8qYqvWSfzAMYB5ibaFOVambIs7KUjtga/BJiOWm1W
         758JLpzp52qBOkKOwJSqe8VT+w46iY9oYVFG6+7eb/SA+1hRSYlmqK5SPmQpzUWJAx++
         Dm8Gf078i2Z8y0T7Z2/iHlfpTeGJR9Ffc6URVRdZQRCdSC34kLT48lyqZmJMbhzd53jX
         1mmzXzmNOxt3gvRmJIO9T7uMl7t73w3b8O+IARh5x79sZ0rjxHdHhc7fMjwv9nq90Itn
         ZlezFX9hUB9TulEPpkEQaovRv7o8Go1nuuLJSFNMcQ1PEdF+//GkkRHalhtqaC2KhAZ4
         T4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754328756; x=1754933556;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q+fFbis65lzN6iN3E1Il6cAJENCj+5dg3T9v8McMK64=;
        b=bPSvJgJTSK3rO3HOJc59Boz8+jLOqbX2UqaC51o00n1rkGttxKiYkyzeIjgC5dqnsq
         fwvfpUj9xJuSDDJZcgVe6FLQSM2zoPbn7sPpn3eQ4qwwj5k98G3R0CNh/zhYQ2L1wrvw
         HwHXhcCuU1amRceHEJM2avNsRZfMIGfX0qAYRdjDvguy2lwBNu1dDHVPlGHPcq3lnuzR
         pHcLCRcA6wdvlmVreu7qe0K9G8n4cEJgmHrcK6ijbn2Wde7l6D8fcdr9ScUE/52K9I0u
         gXt/ENYiu9MParx8GDpUzynT2bPVzejwGCmsXJht442NyY3ujDLlO86YsR+VDkvMbPj5
         aE7w==
X-Forwarded-Encrypted: i=1; AJvYcCUNuZRg8JLbt9RsAvVLcC+1Ayj+NNs3+05+jfAcxYXo5hnsM81imy+DNr8Wmy3HglY3y8635q0C5+NgLKWL@vger.kernel.org
X-Gm-Message-State: AOJu0YwfaEntbBxkPQycc4MkMXwdJy3JvW4I0XT/961Xgd02xmFeshGU
	RDTaby8uIL0wlU+mH3yPzIDxD4VQewWa3Id2hld1WUStKSe1aads1PhHtxHTMpQz3Zzv0KhpNsJ
	jinAT11nv1SBh5T8LrIMBSHLU7Gq6aQ==
X-Google-Smtp-Source: AGHT+IEVaICFnKy/dNHwTnYnHWnggLoU3y5vgOAABzCZm2Njzqap0z/bdEQDD7IW0zOnHdfGwk/80ry2oqrJgRZwurw=
X-Received: from pfbcj11.prod.google.com ([2002:a05:6a00:298b:b0:767:efa:8329])
 (user=paullawrence job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:37c4:b0:76b:f0ac:e7b2 with SMTP id d2e1a72fcca58-76bf0aced3cmr10777588b3a.13.1754328755840;
 Mon, 04 Aug 2025 10:32:35 -0700 (PDT)
Date: Mon,  4 Aug 2025 10:32:27 -0700
In-Reply-To: <20250804173228.1990317-1-paullawrence@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAOQ4uxhmA862ZPAXd=g3vKJAvwAdobAnB--7MqHV87Vmh0USFw@mail.gmail.com>
 <20250804173228.1990317-1-paullawrence@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250804173228.1990317-2-paullawrence@google.com>
Subject: [PATCH 1/2] fuse: Allow backing file to be set at lookup (WIP)
From: Paul Lawrence <paullawrence@google.com>
To: amir73il@gmail.com
Cc: bernd.schubert@fastmail.fm, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, miklos@szeredi.hu, paullawrence@google.com
Content-Type: text/plain; charset="UTF-8"

Add optional extra outarg to FUSE_LOOKUP which holds a backing id to set
a backing file at lookup.

Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/dir.c             | 23 ++++++++++++++++++----
 fs/fuse/fuse_i.h          |  3 +++
 fs/fuse/iomode.c          | 41 +++++++++++++++++++++++++++++++++++----
 fs/fuse/passthrough.c     | 40 +++++++++++++++++++++++++++++---------
 include/uapi/linux/fuse.h |  4 ++++
 5 files changed, 94 insertions(+), 17 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 62508d212826..c0bef93dd078 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -170,7 +170,8 @@ static void fuse_invalidate_entry(struct dentry *entry)
 
 static void fuse_lookup_init(struct fuse_conn *fc, struct fuse_args *args,
 			     u64 nodeid, const struct qstr *name,
-			     struct fuse_entry_out *outarg)
+			     struct fuse_entry_out *outarg,
+			     struct fuse_entry_passthrough_out *backing)
 {
 	memset(outarg, 0, sizeof(struct fuse_entry_out));
 	args->opcode = FUSE_LOOKUP;
@@ -184,6 +185,12 @@ static void fuse_lookup_init(struct fuse_conn *fc, struct fuse_args *args,
 	args->out_numargs = 1;
 	args->out_args[0].size = sizeof(struct fuse_entry_out);
 	args->out_args[0].value = outarg;
+	if (backing) {
+		args->out_numargs = 2;
+		args->out_args[1].size = sizeof(struct fuse_entry_passthrough_out);
+		args->out_args[1].value = backing;
+		args->out_argvar = true;
+	}
 }
 
 /*
@@ -236,7 +243,7 @@ static int fuse_dentry_revalidate(struct inode *dir, const struct qstr *name,
 		attr_version = fuse_get_attr_version(fm->fc);
 
 		fuse_lookup_init(fm->fc, &args, get_node_id(dir),
-				 name, &outarg);
+				 name, &outarg, NULL);
 		ret = fuse_simple_request(fm, &args);
 		/* Zero nodeid is same as -ENOENT */
 		if (!ret && !outarg.nodeid)
@@ -369,6 +376,7 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 	struct fuse_forget_link *forget;
 	u64 attr_version, evict_ctr;
 	int err;
+	struct fuse_entry_passthrough_out passthrough;
 
 	*inode = NULL;
 	err = -ENAMETOOLONG;
@@ -384,10 +392,10 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 	attr_version = fuse_get_attr_version(fm->fc);
 	evict_ctr = fuse_get_evict_ctr(fm->fc);
 
-	fuse_lookup_init(fm->fc, &args, nodeid, name, outarg);
+	fuse_lookup_init(fm->fc, &args, nodeid, name, outarg, &passthrough);
 	err = fuse_simple_request(fm, &args);
 	/* Zero nodeid is same as -ENOENT, but with valid timeout */
-	if (err || !outarg->nodeid)
+	if (err < 0 || !outarg->nodeid)
 		goto out_put_forget;
 
 	err = -EIO;
@@ -406,6 +414,13 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 		fuse_queue_forget(fm->fc, forget, outarg->nodeid, 1);
 		goto out;
 	}
+
+	// TODO check that if fuse_backing is already set they are consistent
+	if (args.out_args[1].size && !get_fuse_inode(*inode)->fb) {
+		err = fuse_inode_set_passthrough(*inode, passthrough.backing_id);
+		if (err)
+			goto out;
+	}
 	err = 0;
 
  out_put_forget:
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 1e8e732a2f09..aebd338751f1 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1595,9 +1595,12 @@ ssize_t fuse_passthrough_splice_read(struct file *in, loff_t *ppos,
 ssize_t fuse_passthrough_splice_write(struct pipe_inode_info *pipe,
 				      struct file *out, loff_t *ppos,
 				      size_t len, unsigned int flags);
+struct fuse_backing *fuse_backing_id_get(struct fuse_conn *fc, int backing_id);
 ssize_t fuse_passthrough_mmap(struct file *file, struct vm_area_struct *vma);
 int fuse_passthrough_readdir(struct file *file, struct dir_context *ctx);
 
+int fuse_inode_set_passthrough(struct inode *inode, int backing_id);
+
 static inline struct fuse_backing *fuse_inode_passthrough(struct fuse_inode *fi)
 {
 #ifdef CONFIG_FUSE_PASSTHROUGH
diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
index f46dfa040e53..4c23ae640624 100644
--- a/fs/fuse/iomode.c
+++ b/fs/fuse/iomode.c
@@ -166,6 +166,37 @@ static void fuse_file_uncached_io_release(struct fuse_file *ff,
 	fuse_inode_uncached_io_end(fi);
 }
 
+/* Setup passthrough for inode operations without an open file */
+int fuse_inode_set_passthrough(struct inode *inode, int backing_id)
+{
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_backing *fb;
+	int err;
+
+	if (!IS_ENABLED(CONFIG_FUSE_PASSTHROUGH) || !fc->passthrough_ino)
+		return 0;
+
+	/* backing inode is set once for the lifetime of the inode */
+	if (fuse_inode_passthrough(fi))
+		return 0;
+
+	fb = fuse_backing_id_get(fc, backing_id);
+	err = PTR_ERR(fb);
+	if (IS_ERR(fb))
+		goto fail;
+
+	fi->fb = fb;
+	set_bit(FUSE_I_PASSTHROUGH, &fi->state);
+	fi->iocachectr--;
+	return 0;
+
+fail:
+	pr_debug("failed to setup backing inode (ino=%lu, backing_id=%d, err=%i).\n",
+		 inode->i_ino, backing_id, err);
+	return err;
+}
+
 /*
  * Open flags that are allowed in combination with FOPEN_PASSTHROUGH.
  * A combination of FOPEN_PASSTHROUGH and FOPEN_DIRECT_IO means that read/write
@@ -185,8 +216,10 @@ static int fuse_file_passthrough_open(struct inode *inode, struct file *file)
 	int err;
 
 	/* Check allowed conditions for file open in passthrough mode */
-	if (!IS_ENABLED(CONFIG_FUSE_PASSTHROUGH) || !fc->passthrough ||
-	    (ff->open_flags & ~FOPEN_PASSTHROUGH_MASK))
+	if (!IS_ENABLED(CONFIG_FUSE_PASSTHROUGH) || !fc->passthrough)
+		return -EINVAL;
+
+	if (ff->open_flags & ~FOPEN_PASSTHROUGH_MASK && !fuse_inode_backing(get_fuse_inode(inode)))
 		return -EINVAL;
 
 	fb = fuse_passthrough_open(file, inode,
@@ -224,8 +257,8 @@ int fuse_file_io_open(struct file *file, struct inode *inode)
 	 * which is already open for passthrough.
 	 */
 	err = -EINVAL;
-	if (fuse_inode_backing(fi) && !(ff->open_flags & FOPEN_PASSTHROUGH))
-		goto fail;
+	if (fuse_inode_backing(fi))
+		ff->open_flags |= FOPEN_PASSTHROUGH;
 
 	/*
 	 * FOPEN_PARALLEL_DIRECT_WRITES requires FOPEN_DIRECT_IO.
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index de6ece996ff8..cee40e1c6e4a 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -229,7 +229,6 @@ static int fuse_backing_id_free(int id, void *p, void *data)
 {
 	struct fuse_backing *fb = p;
 
-	WARN_ON_ONCE(refcount_read(&fb->count) != 1);
 	fuse_backing_free(fb);
 	return 0;
 }
@@ -348,6 +347,29 @@ int fuse_backing_close(struct fuse_conn *fc, int backing_id)
 	return err;
 }
 
+/*
+ * Get fuse backing object by backing id.
+ *
+ * Returns an fb object with elevated refcount to be stored in fuse inode.
+ */
+struct fuse_backing *fuse_backing_id_get(struct fuse_conn *fc, int backing_id)
+{
+	struct fuse_backing *fb;
+
+	if (backing_id <= 0)
+		return ERR_PTR(-EINVAL);
+
+	rcu_read_lock();
+	fb = idr_find(&fc->backing_files_map, backing_id);
+	fb = fuse_backing_get(fb);
+	rcu_read_unlock();
+
+	if (!fb)
+		return ERR_PTR(-ENOENT);
+
+	return fb;
+}
+
 /*
  * Setup passthrough to a backing file.
  *
@@ -363,18 +385,18 @@ struct fuse_backing *fuse_passthrough_open(struct file *file,
 	struct file *backing_file;
 	int err;
 
-	err = -EINVAL;
-	if (backing_id <= 0)
-		goto out;
-
 	rcu_read_lock();
-	fb = idr_find(&fc->backing_files_map, backing_id);
+	if (backing_id <= 0) {
+		err = -EINVAL;
+		fb = fuse_inode_backing(get_fuse_inode(inode));
+	} else {
+		err = -ENOENT;
+		fb = idr_find(&fc->backing_files_map, backing_id);
+	}
 	fb = fuse_backing_get(fb);
-	rcu_read_unlock();
-
-	err = -ENOENT;
 	if (!fb)
 		goto out;
+	rcu_read_unlock();
 
 	/* Allocate backing file per fuse file to store fuse path */
 	backing_file = backing_file_open(&file->f_path, file->f_flags,
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index ff769766b748..6dbb045c794d 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -695,6 +695,10 @@ struct fuse_entry_out {
 	struct fuse_attr attr;
 };
 
+struct fuse_entry_passthrough_out {
+	int32_t 	backing_id;
+};
+
 struct fuse_forget_in {
 	uint64_t	nlookup;
 };
-- 
2.50.1.565.gc32cd1483b-goog


