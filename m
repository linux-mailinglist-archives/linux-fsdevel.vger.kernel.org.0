Return-Path: <linux-fsdevel+bounces-28416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE93A96A1FA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 17:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F9CB1C202ED
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 15:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E954818A6C7;
	Tue,  3 Sep 2024 15:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="e4Gt2ohf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E345E1885B6
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 15:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376618; cv=none; b=sfzTy85Hv1840f3bbgJqTIzKEqLceSRqA5rXSLsM5ZHtVnpl7v2rnSY+F/44kr0SaIXCcW5eymavhxXmr8mtEWeSPQEKz3/zlijEg/IKH2HPuaDzfzFFGfGVKiGYHdo4Vee0JbeRa34XS8OzWeuKNjYhnqEqD/B5iNX2sUbgUMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376618; c=relaxed/simple;
	bh=f/gJKyVl4ADm/yoP4N8bpvEgSEtHH1kP5oeqKqZ4Tds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dh0HSlQ/78gJ9qSAVt2YJlc13jmUw2TkCkYwsnXD7MjaOSDAr9BQ7hYJT63K9Jnv5ffMCD+PY0yzHhWYIc9jsToHHenVFWWNlBOwrArfagqIvVtHpDCd93ObGkTU5uSyY4wpRxylMBwpUMqwIDLfohC5Jfx3Kw5elGkBPllTXAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=e4Gt2ohf; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 11B953FE1B
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 15:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725376614;
	bh=UdafeJegpZAV0BY3M2qbl16uDJIFaN2Zpg+hXMszRa4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=e4Gt2ohfyKEL+chtBg45zJgoMfyP5AwCGwHYWnI1HBoXQHKj7tupOvOwZVSutttek
	 xxKxPkpRfT0kXhlNe1G2Gxw87JDC5wuObx7H2igP3IKNqckhV8xqgD1N21cuTLm34L
	 Pqkj7m57oWwHCmoJot5nKzppM+GH4BW4jCevaYbnVpj0ARllBkyAYyNKpyYGcPeVS8
	 X+A52dGZfPiZROqFyDlMn7p9KJ4LlJyuuklCc2zUpG9FPp7cF1Lyr9Fj+6Cs+tDkhS
	 pnlbmKSAor8PZxI6FDGk29CaWh3VpCx0ciBw2P8PyTu5WA8/s8ZpgEztVomlSywT7u
	 8932cxFCs7uYQ==
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2f401c76ce1so60989891fa.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2024 08:16:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725376613; x=1725981413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UdafeJegpZAV0BY3M2qbl16uDJIFaN2Zpg+hXMszRa4=;
        b=pUugYjGfaAuHlrhTmclPW3y/NSD9NgpET54qoq4MiIA6ygQgA4M0zMJ89FknQq4ei5
         CmhB++ut+xQUpLnYPEhBRq+evsgzP2WYKB/VX41OzSVDFYgp61T/21atc5UFTghnkqqh
         e61aykHQ/Skr8g2CoFKjMgejfNkUBWnVpPqHQO56zKFu3bzwZJtxWsRS7AR1iBvoePWI
         mvpOeDx8b9LZ6RkQ2dgjW4sVCWdEWtrL0eWguZE5EnPyRzp4rxRS+LVjg1Lqsj/lsowU
         yrXQWd0DL3sW8/EfllYk/f17+bmlaKRJ8tfRTAIzWzTaAJcA5LaMBp4okdsGRUeFTmVE
         PBMw==
X-Forwarded-Encrypted: i=1; AJvYcCXkqox2H5D4pp2uRrnp075nxqDo3/FFt54Py0IjRr2RZt26QIrhkZ0jFgLFhqCB5RvTLW/tLGCjM1JcKjUA@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9T8wSu+uEIbasUgXWFkLd8LKMoDv5F5Y+hJ6CW26dDn+r1TT9
	2cRiZZi67QqDIqjTeLTHubn/VJ00skOKnPl78m60aVP02Y8kyIFHXp3yWRzebBIafYBVkeq9OYi
	2lcf2T+SYSIeoRrDicktmWCsEbsPyCxwuHBXHqjPq+6TacyMGua3/DY3GMLRwP24ooPB6Er5FQ9
	KlmMs=
X-Received: by 2002:a2e:612:0:b0:2ef:2677:7b74 with SMTP id 38308e7fff4ca-2f6108ae26dmr113933431fa.41.1725376613109;
        Tue, 03 Sep 2024 08:16:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhC2jwLdKr/I93Lw0mhZQlHq3y/Gq9QIm9cGGG1aK6M+8ZSCFhfX7x8b8W1hP24WyaaimLhA==
X-Received: by 2002:a2e:612:0:b0:2ef:2677:7b74 with SMTP id 38308e7fff4ca-2f6108ae26dmr113933141fa.41.1725376612477;
        Tue, 03 Sep 2024 08:16:52 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a19afb108sm156377166b.223.2024.09.03.08.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 08:16:51 -0700 (PDT)
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
Subject: [PATCH v4 03/15] fs/fuse: add an idmap argument to fuse_simple_request
Date: Tue,  3 Sep 2024 17:16:14 +0200
Message-Id: <20240903151626.264609-4-aleksandr.mikhalitsyn@canonical.com>
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

If idmap == NULL *and* filesystem daemon declared idmapped mounts
support, then uid/gid values in a fuse header will be -1.

No functional changes intended.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: <linux-fsdevel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
v4:
	- this commit added
---
 fs/fuse/dax.c     |  4 ++--
 fs/fuse/dev.c     |  6 ++++--
 fs/fuse/dir.c     | 26 +++++++++++++-------------
 fs/fuse/file.c    | 32 ++++++++++++++++----------------
 fs/fuse/fuse_i.h  |  3 ++-
 fs/fuse/inode.c   |  6 +++---
 fs/fuse/ioctl.c   |  2 +-
 fs/fuse/readdir.c |  4 ++--
 fs/fuse/xattr.c   |  8 ++++----
 9 files changed, 47 insertions(+), 44 deletions(-)

diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 12ef91d170bb..6d8368d66dd4 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -207,7 +207,7 @@ static int fuse_setup_one_mapping(struct inode *inode, unsigned long start_idx,
 	args.in_numargs = 1;
 	args.in_args[0].size = sizeof(inarg);
 	args.in_args[0].value = &inarg;
-	err = fuse_simple_request(fm, &args);
+	err = fuse_simple_request(NULL, fm, &args);
 	if (err < 0)
 		return err;
 	dmap->writable = writable;
@@ -245,7 +245,7 @@ static int fuse_send_removemapping(struct inode *inode,
 	args.in_args[0].value = inargp;
 	args.in_args[1].size = inargp->count * sizeof(*remove_one);
 	args.in_args[1].value = remove_one;
-	return fuse_simple_request(fm, &args);
+	return fuse_simple_request(NULL, fm, &args);
 }
 
 static int dmap_removemapping_list(struct inode *inode, unsigned int num,
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index d3f3c3557c04..349fc84897a5 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -508,7 +508,9 @@ static void fuse_args_to_req(struct fuse_req *req, struct fuse_args *args)
 		__set_bit(FR_ASYNC, &req->flags);
 }
 
-ssize_t fuse_simple_request(struct fuse_mount *fm, struct fuse_args *args)
+ssize_t fuse_simple_request(struct mnt_idmap *idmap,
+			    struct fuse_mount *fm,
+			    struct fuse_args *args)
 {
 	struct fuse_conn *fc = fm->fc;
 	struct fuse_req *req;
@@ -525,7 +527,7 @@ ssize_t fuse_simple_request(struct fuse_mount *fm, struct fuse_args *args)
 		__set_bit(FR_FORCE, &req->flags);
 	} else {
 		WARN_ON(args->nocreds);
-		req = fuse_get_req(NULL, fm, false);
+		req = fuse_get_req(idmap, fm, false);
 		if (IS_ERR(req))
 			return PTR_ERR(req);
 	}
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 2b0d4781f394..2a8344776350 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -230,7 +230,7 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 		parent = dget_parent(entry);
 		fuse_lookup_init(fm->fc, &args, get_node_id(d_inode(parent)),
 				 &entry->d_name, &outarg);
-		ret = fuse_simple_request(fm, &args);
+		ret = fuse_simple_request(NULL, fm, &args);
 		dput(parent);
 		/* Zero nodeid is same as -ENOENT */
 		if (!ret && !outarg.nodeid)
@@ -383,7 +383,7 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 	attr_version = fuse_get_attr_version(fm->fc);
 
 	fuse_lookup_init(fm->fc, &args, nodeid, name, outarg);
-	err = fuse_simple_request(fm, &args);
+	err = fuse_simple_request(NULL, fm, &args);
 	/* Zero nodeid is same as -ENOENT, but with valid timeout */
 	if (err || !outarg->nodeid)
 		goto out_put_forget;
@@ -672,7 +672,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	if (err)
 		goto out_put_forget_req;
 
-	err = fuse_simple_request(fm, &args);
+	err = fuse_simple_request(NULL, fm, &args);
 	free_ext_value(&args);
 	if (err)
 		goto out_free_ff;
@@ -803,7 +803,7 @@ static int create_new_entry(struct fuse_mount *fm, struct fuse_args *args,
 			goto out_put_forget_req;
 	}
 
-	err = fuse_simple_request(fm, args);
+	err = fuse_simple_request(NULL, fm, args);
 	free_ext_value(args);
 	if (err)
 		goto out_put_forget_req;
@@ -987,7 +987,7 @@ static int fuse_unlink(struct inode *dir, struct dentry *entry)
 	args.in_numargs = 1;
 	args.in_args[0].size = entry->d_name.len + 1;
 	args.in_args[0].value = entry->d_name.name;
-	err = fuse_simple_request(fm, &args);
+	err = fuse_simple_request(NULL, fm, &args);
 	if (!err) {
 		fuse_dir_changed(dir);
 		fuse_entry_unlinked(entry);
@@ -1010,7 +1010,7 @@ static int fuse_rmdir(struct inode *dir, struct dentry *entry)
 	args.in_numargs = 1;
 	args.in_args[0].size = entry->d_name.len + 1;
 	args.in_args[0].value = entry->d_name.name;
-	err = fuse_simple_request(fm, &args);
+	err = fuse_simple_request(NULL, fm, &args);
 	if (!err) {
 		fuse_dir_changed(dir);
 		fuse_entry_unlinked(entry);
@@ -1040,7 +1040,7 @@ static int fuse_rename_common(struct inode *olddir, struct dentry *oldent,
 	args.in_args[1].value = oldent->d_name.name;
 	args.in_args[2].size = newent->d_name.len + 1;
 	args.in_args[2].value = newent->d_name.name;
-	err = fuse_simple_request(fm, &args);
+	err = fuse_simple_request(NULL, fm, &args);
 	if (!err) {
 		/* ctime changes */
 		fuse_update_ctime(d_inode(oldent));
@@ -1210,7 +1210,7 @@ static int fuse_do_statx(struct inode *inode, struct file *file,
 	args.out_numargs = 1;
 	args.out_args[0].size = sizeof(outarg);
 	args.out_args[0].value = &outarg;
-	err = fuse_simple_request(fm, &args);
+	err = fuse_simple_request(NULL, fm, &args);
 	if (err)
 		return err;
 
@@ -1268,7 +1268,7 @@ static int fuse_do_getattr(struct inode *inode, struct kstat *stat,
 	args.out_numargs = 1;
 	args.out_args[0].size = sizeof(outarg);
 	args.out_args[0].value = &outarg;
-	err = fuse_simple_request(fm, &args);
+	err = fuse_simple_request(NULL, fm, &args);
 	if (!err) {
 		if (fuse_invalid_attr(&outarg.attr) ||
 		    inode_wrong_type(inode, outarg.attr.mode)) {
@@ -1472,7 +1472,7 @@ static int fuse_access(struct inode *inode, int mask)
 	args.in_numargs = 1;
 	args.in_args[0].size = sizeof(inarg);
 	args.in_args[0].value = &inarg;
-	err = fuse_simple_request(fm, &args);
+	err = fuse_simple_request(NULL, fm, &args);
 	if (err == -ENOSYS) {
 		fm->fc->no_access = 1;
 		err = 0;
@@ -1584,7 +1584,7 @@ static int fuse_readlink_page(struct inode *inode, struct page *page)
 	ap.args.page_zeroing = true;
 	ap.args.out_numargs = 1;
 	ap.args.out_args[0].size = desc.length;
-	res = fuse_simple_request(fm, &ap.args);
+	res = fuse_simple_request(NULL, fm, &ap.args);
 
 	fuse_invalidate_atime(inode);
 
@@ -1857,7 +1857,7 @@ int fuse_flush_times(struct inode *inode, struct fuse_file *ff)
 	}
 	fuse_setattr_fill(fm->fc, &args, inode, &inarg, &outarg);
 
-	return fuse_simple_request(fm, &args);
+	return fuse_simple_request(NULL, fm, &args);
 }
 
 /*
@@ -1970,7 +1970,7 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 			inarg.valid |= FATTR_KILL_SUIDGID;
 	}
 	fuse_setattr_fill(fc, &args, inode, &inarg, &outarg);
-	err = fuse_simple_request(fm, &args);
+	err = fuse_simple_request(NULL, fm, &args);
 	if (err) {
 		if (err == -EINTR)
 			fuse_invalidate_attr(inode);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f39456c65ed7..7d14d533dad1 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -48,7 +48,7 @@ static int fuse_send_open(struct fuse_mount *fm, u64 nodeid,
 	args.out_args[0].size = sizeof(*outargp);
 	args.out_args[0].value = outargp;
 
-	return fuse_simple_request(fm, &args);
+	return fuse_simple_request(NULL, fm, &args);
 }
 
 struct fuse_file *fuse_file_alloc(struct fuse_mount *fm, bool release)
@@ -111,7 +111,7 @@ static void fuse_file_put(struct fuse_file *ff, bool sync)
 		if (!args) {
 			/* Do nothing when server does not implement 'open' */
 		} else if (sync) {
-			fuse_simple_request(ff->fm, args);
+			fuse_simple_request(NULL, ff->fm, args);
 			fuse_release_end(ff->fm, args, 0);
 		} else {
 			args->end = fuse_release_end;
@@ -539,7 +539,7 @@ static int fuse_flush(struct file *file, fl_owner_t id)
 	args.in_args[0].value = &inarg;
 	args.force = true;
 
-	err = fuse_simple_request(fm, &args);
+	err = fuse_simple_request(NULL, fm, &args);
 	if (err == -ENOSYS) {
 		fm->fc->no_flush = 1;
 		err = 0;
@@ -572,7 +572,7 @@ int fuse_fsync_common(struct file *file, loff_t start, loff_t end,
 	args.in_numargs = 1;
 	args.in_args[0].size = sizeof(inarg);
 	args.in_args[0].value = &inarg;
-	return fuse_simple_request(fm, &args);
+	return fuse_simple_request(NULL, fm, &args);
 }
 
 static int fuse_fsync(struct file *file, loff_t start, loff_t end,
@@ -814,7 +814,7 @@ static ssize_t fuse_send_read(struct fuse_io_args *ia, loff_t pos, size_t count,
 	if (ia->io->async)
 		return fuse_async_req_send(fm, ia, count);
 
-	return fuse_simple_request(fm, &ia->ap.args);
+	return fuse_simple_request(NULL, fm, &ia->ap.args);
 }
 
 static void fuse_read_update_size(struct inode *inode, loff_t size,
@@ -878,7 +878,7 @@ static int fuse_do_readpage(struct file *file, struct page *page)
 		desc.length--;
 
 	fuse_read_args_fill(&ia, file, pos, desc.length, FUSE_READ);
-	res = fuse_simple_request(fm, &ia.ap.args);
+	res = fuse_simple_request(NULL, fm, &ia.ap.args);
 	if (res < 0)
 		return res;
 	/*
@@ -976,7 +976,7 @@ static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file)
 		if (!err)
 			return;
 	} else {
-		res = fuse_simple_request(fm, &ap->args);
+		res = fuse_simple_request(NULL, fm, &ap->args);
 		err = res < 0 ? res : 0;
 	}
 	fuse_readpages_end(fm, &ap->args, err);
@@ -1101,7 +1101,7 @@ static ssize_t fuse_send_write(struct fuse_io_args *ia, loff_t pos,
 	if (ia->io->async)
 		return fuse_async_req_send(fm, ia, count);
 
-	err = fuse_simple_request(fm, &ia->ap.args);
+	err = fuse_simple_request(NULL, fm, &ia->ap.args);
 	if (!err && ia->write.out.size > count)
 		err = -EIO;
 
@@ -1147,7 +1147,7 @@ static ssize_t fuse_send_write_pages(struct fuse_io_args *ia,
 	if (fm->fc->handle_killpriv_v2 && !capable(CAP_FSETID))
 		ia->write.in.write_flags |= FUSE_WRITE_KILL_SUIDGID;
 
-	err = fuse_simple_request(fm, &ap->args);
+	err = fuse_simple_request(NULL, fm, &ap->args);
 	if (!err && ia->write.out.size > count)
 		err = -EIO;
 
@@ -2656,7 +2656,7 @@ static int fuse_getlk(struct file *file, struct file_lock *fl)
 	args.out_numargs = 1;
 	args.out_args[0].size = sizeof(outarg);
 	args.out_args[0].value = &outarg;
-	err = fuse_simple_request(fm, &args);
+	err = fuse_simple_request(NULL, fm, &args);
 	if (!err)
 		err = convert_fuse_file_lock(fm->fc, &outarg.lk, fl);
 
@@ -2680,7 +2680,7 @@ static int fuse_setlk(struct file *file, struct file_lock *fl, int flock)
 	}
 
 	fuse_lk_fill(&args, file, fl, opcode, pid_nr, flock, &inarg);
-	err = fuse_simple_request(fm, &args);
+	err = fuse_simple_request(NULL, fm, &args);
 
 	/* locking is restartable */
 	if (err == -EINTR)
@@ -2754,7 +2754,7 @@ static sector_t fuse_bmap(struct address_space *mapping, sector_t block)
 	args.out_numargs = 1;
 	args.out_args[0].size = sizeof(outarg);
 	args.out_args[0].value = &outarg;
-	err = fuse_simple_request(fm, &args);
+	err = fuse_simple_request(NULL, fm, &args);
 	if (err == -ENOSYS)
 		fm->fc->no_bmap = 1;
 
@@ -2786,7 +2786,7 @@ static loff_t fuse_lseek(struct file *file, loff_t offset, int whence)
 	args.out_numargs = 1;
 	args.out_args[0].size = sizeof(outarg);
 	args.out_args[0].value = &outarg;
-	err = fuse_simple_request(fm, &args);
+	err = fuse_simple_request(NULL, fm, &args);
 	if (err) {
 		if (err == -ENOSYS) {
 			fm->fc->no_lseek = 1;
@@ -2919,7 +2919,7 @@ __poll_t fuse_file_poll(struct file *file, poll_table *wait)
 	args.out_numargs = 1;
 	args.out_args[0].size = sizeof(outarg);
 	args.out_args[0].value = &outarg;
-	err = fuse_simple_request(fm, &args);
+	err = fuse_simple_request(NULL, fm, &args);
 
 	if (!err)
 		return demangle_poll(outarg.revents);
@@ -3141,7 +3141,7 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 	args.in_numargs = 1;
 	args.in_args[0].size = sizeof(inarg);
 	args.in_args[0].value = &inarg;
-	err = fuse_simple_request(fm, &args);
+	err = fuse_simple_request(NULL, fm, &args);
 	if (err == -ENOSYS) {
 		fm->fc->no_fallocate = 1;
 		err = -EOPNOTSUPP;
@@ -3253,7 +3253,7 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 	args.out_numargs = 1;
 	args.out_args[0].size = sizeof(outarg);
 	args.out_args[0].value = &outarg;
-	err = fuse_simple_request(fm, &args);
+	err = fuse_simple_request(NULL, fm, &args);
 	if (err == -ENOSYS) {
 		fc->no_copy_file_range = 1;
 		err = -EOPNOTSUPP;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f23919610313..656575e3e4cf 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1154,7 +1154,8 @@ void __exit fuse_ctl_cleanup(void);
 /**
  * Simple request sending that does request allocation and freeing
  */
-ssize_t fuse_simple_request(struct fuse_mount *fm, struct fuse_args *args);
+ssize_t fuse_simple_request(struct mnt_idmap *idmap, struct fuse_mount *fm,
+			    struct fuse_args *args);
 int fuse_simple_background(struct fuse_mount *fm, struct fuse_args *args,
 			   gfp_t gfp_flags);
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 115538f6f283..2e26810066e8 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -586,7 +586,7 @@ static void fuse_send_destroy(struct fuse_mount *fm)
 		args.opcode = FUSE_DESTROY;
 		args.force = true;
 		args.nocreds = true;
-		fuse_simple_request(fm, &args);
+		fuse_simple_request(NULL, fm, &args);
 	}
 }
 
@@ -624,7 +624,7 @@ static int fuse_statfs(struct dentry *dentry, struct kstatfs *buf)
 	args.out_numargs = 1;
 	args.out_args[0].size = sizeof(outarg);
 	args.out_args[0].value = &outarg;
-	err = fuse_simple_request(fm, &args);
+	err = fuse_simple_request(NULL, fm, &args);
 	if (!err)
 		convert_fuse_statfs(buf, &outarg.st);
 	return err;
@@ -713,7 +713,7 @@ static int fuse_sync_fs(struct super_block *sb, int wait)
 	args.nodeid = get_node_id(sb->s_root->d_inode);
 	args.out_numargs = 0;
 
-	err = fuse_simple_request(fm, &args);
+	err = fuse_simple_request(NULL, fm, &args);
 	if (err == -ENOSYS) {
 		fc->sync_fs = 0;
 		err = 0;
diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index 572ce8a82ceb..b40dd931167d 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -18,7 +18,7 @@ static ssize_t fuse_send_ioctl(struct fuse_mount *fm, struct fuse_args *args,
 	args->out_args[0].size = sizeof(*outarg);
 	args->out_args[0].value = outarg;
 
-	ret = fuse_simple_request(fm, args);
+	ret = fuse_simple_request(NULL, fm, args);
 
 	/* Translate ENOSYS, which shouldn't be returned from fs */
 	if (ret == -ENOSYS)
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index 0377b6dc24c8..e8a093289421 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -279,7 +279,7 @@ static void fuse_force_forget(struct file *file, u64 nodeid)
 	args.force = true;
 	args.noreply = true;
 
-	fuse_simple_request(fm, &args);
+	fuse_simple_request(NULL, fm, &args);
 	/* ignore errors */
 }
 
@@ -358,7 +358,7 @@ static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
 				    FUSE_READDIR);
 	}
 	locked = fuse_lock_inode(inode);
-	res = fuse_simple_request(fm, &ap->args);
+	res = fuse_simple_request(NULL, fm, &ap->args);
 	fuse_unlock_inode(inode, locked);
 	if (res >= 0) {
 		if (!res) {
diff --git a/fs/fuse/xattr.c b/fs/fuse/xattr.c
index 5b423fdbb13f..6f8f1453b550 100644
--- a/fs/fuse/xattr.c
+++ b/fs/fuse/xattr.c
@@ -37,7 +37,7 @@ int fuse_setxattr(struct inode *inode, const char *name, const void *value,
 	args.in_args[1].value = name;
 	args.in_args[2].size = size;
 	args.in_args[2].value = value;
-	err = fuse_simple_request(fm, &args);
+	err = fuse_simple_request(NULL, fm, &args);
 	if (err == -ENOSYS) {
 		fm->fc->no_setxattr = 1;
 		err = -EOPNOTSUPP;
@@ -79,7 +79,7 @@ ssize_t fuse_getxattr(struct inode *inode, const char *name, void *value,
 		args.out_args[0].size = sizeof(outarg);
 		args.out_args[0].value = &outarg;
 	}
-	ret = fuse_simple_request(fm, &args);
+	ret = fuse_simple_request(NULL, fm, &args);
 	if (!ret && !size)
 		ret = min_t(ssize_t, outarg.size, XATTR_SIZE_MAX);
 	if (ret == -ENOSYS) {
@@ -141,7 +141,7 @@ ssize_t fuse_listxattr(struct dentry *entry, char *list, size_t size)
 		args.out_args[0].size = sizeof(outarg);
 		args.out_args[0].value = &outarg;
 	}
-	ret = fuse_simple_request(fm, &args);
+	ret = fuse_simple_request(NULL, fm, &args);
 	if (!ret && !size)
 		ret = min_t(ssize_t, outarg.size, XATTR_LIST_MAX);
 	if (ret > 0 && size)
@@ -167,7 +167,7 @@ int fuse_removexattr(struct inode *inode, const char *name)
 	args.in_numargs = 1;
 	args.in_args[0].size = strlen(name) + 1;
 	args.in_args[0].value = name;
-	err = fuse_simple_request(fm, &args);
+	err = fuse_simple_request(NULL, fm, &args);
 	if (err == -ENOSYS) {
 		fm->fc->no_removexattr = 1;
 		err = -EOPNOTSUPP;
-- 
2.34.1


