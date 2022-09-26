Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11AF45EB597
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 01:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiIZXVM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 19:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiIZXTu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:19:50 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB9BF184E
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:19:21 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id n6-20020a5b0486000000b006aff8dc9865so7079089ybp.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=ESl/xWylMkiNHNcThvpwX8fFH2NXNSDhyjDpxRqtEMU=;
        b=MkwSDBT31FYXf5nSCwfaWRvyXLXA1enONkLfgFF0WbYgzAhmmlCxk2vmB7ncmLOyxq
         G89EHa/O2wKzBIfZXXWR/P6RfkVwaLTkPjCfrwm/zWkpKBdHd6ReEhIkDdvymTR/LezB
         y5b4P54tYO8MHtaQ6v7L8J6dmt+e+aDlhmh676uW5VqXWzISsC/hX5EUrd4g4TNzovKY
         tre8zy961njePn3ZrY+TLjMDofCnv1m+kG45lscMetKxQjHGgbQYRFZ167VudjxRM1k7
         vIOgSbnnq68i0UFvFf09VdY7EwTstWACUDmo4kpTJnghTh4JoK0Ush14cM4R1+tX/+KE
         9LbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=ESl/xWylMkiNHNcThvpwX8fFH2NXNSDhyjDpxRqtEMU=;
        b=gdxwMDQaVh+CsRe/+xHVCifIOBo1PG51eOfb0S7QLFpgHBREZf875Waa3dHgfNjwKf
         3y0tSLG5e9cwgiWfLlys9PpAvJTcMTQCmG8FTkXKHeAR3CDaVedjS+4M5g7tlh3WkefE
         5MWvF188077/235sN+vskBqkfc4teGv6DlzFtcTWJoOY95+zAplxIpIq2eCwNXjlNI20
         u4tB5cMAGN+jI3FxLvdJqS11b2RQBwdo0eiPVSRDzICRuqIrw8eGcE3MrruvKQ9RwrI7
         S/T7k87LucMpV6rWGWC1ULuYD7CzXbzME/Khqnb3BBQTKJxi/3SaHyf2pCaMxL0FSVCr
         h0+w==
X-Gm-Message-State: ACrzQf1vdT1K7f4m/QbiaBEec9+oKSW/Vk8btUKuhErmJW1zIv2QfFI0
        QMMZ/17msC0hSVKJbisEZlEU5T7L2cQ=
X-Google-Smtp-Source: AMsMyM7pbrRoFcQTBN3LSxxR6XfccCquBY4GMLCu8I+G7N2Z7v9wXT/FiJSnjbr7e5k8yjY6a1uz5lX46Bg=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:200:4643:a68e:2b7:f873])
 (user=drosen job=sendgmr) by 2002:a05:6902:120f:b0:676:aaa4:8434 with SMTP id
 s15-20020a056902120f00b00676aaa48434mr24439528ybu.218.1664234360778; Mon, 26
 Sep 2022 16:19:20 -0700 (PDT)
Date:   Mon, 26 Sep 2022 16:18:15 -0700
In-Reply-To: <20220926231822.994383-1-drosen@google.com>
Mime-Version: 1.0
References: <20220926231822.994383-1-drosen@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220926231822.994383-20-drosen@google.com>
Subject: [PATCH 19/26] fuse-bpf: Add attr support
From:   Daniel Rosenberg <drosen@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@google.com>,
        David Anderson <dvander@google.com>,
        Sandeep Patil <sspatil@google.com>,
        linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/backing.c | 264 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dir.c     |  84 +++++----------
 fs/fuse/fuse_i.h  | 141 +++++++++++++++++++++++++
 fs/fuse/inode.c   |  22 ++--
 4 files changed, 441 insertions(+), 70 deletions(-)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index f4ab92dc8099..13075eddeb7e 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -1626,6 +1626,270 @@ int fuse_unlink_finalize(struct bpf_fuse_args *fa, int *out,
 	return 0;
 }
 
+int fuse_getattr_initialize_in(struct bpf_fuse_args *fa, struct fuse_getattr_io *fgio,
+			       const struct dentry *entry, struct kstat *stat,
+			       u32 request_mask, unsigned int flags)
+{
+	fgio->fgi = (struct fuse_getattr_in) {
+		.getattr_flags = flags,
+		.fh = -1, /* TODO is this OK? */
+	};
+
+	*fa = (struct bpf_fuse_args) {
+		.nodeid = get_node_id(entry->d_inode),
+		.opcode = FUSE_GETATTR,
+		.in_numargs = 1,
+		.in_args[0] = (struct bpf_fuse_arg) {
+			.size = sizeof(fgio->fgi),
+			.value = &fgio->fgi,
+		},
+	};
+
+	return 0;
+}
+
+int fuse_getattr_initialize_out(struct bpf_fuse_args *fa, struct fuse_getattr_io *fgio,
+				const struct dentry *entry, struct kstat *stat,
+				u32 request_mask, unsigned int flags)
+{
+	fgio->fao = (struct fuse_attr_out) { 0 };
+
+	fa->out_numargs = 1;
+	fa->out_args[0] = (struct bpf_fuse_arg) {
+		.size = sizeof(fgio->fao),
+		.value = &fgio->fao,
+	};
+
+	return 0;
+}
+
+static void fuse_stat_to_attr(struct fuse_conn *fc, struct inode *inode,
+			      struct kstat *stat, struct fuse_attr *attr)
+{
+	unsigned int blkbits;
+
+	/* see the comment in fuse_change_attributes() */
+	if (fc->writeback_cache && S_ISREG(inode->i_mode)) {
+		stat->size = i_size_read(inode);
+		stat->mtime.tv_sec = inode->i_mtime.tv_sec;
+		stat->mtime.tv_nsec = inode->i_mtime.tv_nsec;
+		stat->ctime.tv_sec = inode->i_ctime.tv_sec;
+		stat->ctime.tv_nsec = inode->i_ctime.tv_nsec;
+	}
+
+	attr->ino = stat->ino;
+	attr->mode = (inode->i_mode & S_IFMT) | (stat->mode & 07777);
+	attr->nlink = stat->nlink;
+	attr->uid = from_kuid(fc->user_ns, stat->uid);
+	attr->gid = from_kgid(fc->user_ns, stat->gid);
+	attr->atime = stat->atime.tv_sec;
+	attr->atimensec = stat->atime.tv_nsec;
+	attr->mtime = stat->mtime.tv_sec;
+	attr->mtimensec = stat->mtime.tv_nsec;
+	attr->ctime = stat->ctime.tv_sec;
+	attr->ctimensec = stat->ctime.tv_nsec;
+	attr->size = stat->size;
+	attr->blocks = stat->blocks;
+
+	if (stat->blksize != 0)
+		blkbits = ilog2(stat->blksize);
+	else
+		blkbits = inode->i_sb->s_blocksize_bits;
+
+	attr->blksize = 1 << blkbits;
+}
+
+int fuse_getattr_backing(struct bpf_fuse_args *fa, int *out,
+			 const struct dentry *entry, struct kstat *stat,
+			 u32 request_mask, unsigned int flags)
+{
+	struct path *backing_path = &get_fuse_dentry(entry)->backing_path;
+	struct inode *backing_inode = backing_path->dentry->d_inode;
+	struct fuse_attr_out *fao = fa->out_args[0].value;
+	struct kstat tmp;
+
+	if (!stat)
+		stat = &tmp;
+
+	*out = vfs_getattr(backing_path, stat, request_mask, flags);
+
+	if (!*out)
+		fuse_stat_to_attr(get_fuse_conn(entry->d_inode), backing_inode,
+				  stat, &fao->attr);
+
+	return 0;
+}
+
+int fuse_getattr_finalize(struct bpf_fuse_args *fa, int *out,
+			  const struct dentry *entry, struct kstat *stat,
+			  u32 request_mask, unsigned int flags)
+{
+	struct fuse_attr_out *outarg = fa->out_args[0].value;
+	struct inode *inode = entry->d_inode;
+	u64 attr_version = fuse_get_attr_version(get_fuse_mount(inode)->fc);
+
+	/* TODO: Ensure this doesn't happen if we had an error getting attrs in
+	 * backing.
+	 */
+	*out = finalize_attr(inode, outarg, attr_version, stat);
+	return 0;
+}
+
+static void fattr_to_iattr(struct fuse_conn *fc,
+			   const struct fuse_setattr_in *arg,
+			   struct iattr *iattr)
+{
+	unsigned int fvalid = arg->valid;
+
+	if (fvalid & FATTR_MODE)
+		iattr->ia_valid |= ATTR_MODE, iattr->ia_mode = arg->mode;
+	if (fvalid & FATTR_UID) {
+		iattr->ia_valid |= ATTR_UID;
+		iattr->ia_uid = make_kuid(fc->user_ns, arg->uid);
+	}
+	if (fvalid & FATTR_GID) {
+		iattr->ia_valid |= ATTR_GID;
+		iattr->ia_gid = make_kgid(fc->user_ns, arg->gid);
+	}
+	if (fvalid & FATTR_SIZE)
+		iattr->ia_valid |= ATTR_SIZE, iattr->ia_size = arg->size;
+	if (fvalid & FATTR_ATIME) {
+		iattr->ia_valid |= ATTR_ATIME;
+		iattr->ia_atime.tv_sec = arg->atime;
+		iattr->ia_atime.tv_nsec = arg->atimensec;
+		if (!(fvalid & FATTR_ATIME_NOW))
+			iattr->ia_valid |= ATTR_ATIME_SET;
+	}
+	if (fvalid & FATTR_MTIME) {
+		iattr->ia_valid |= ATTR_MTIME;
+		iattr->ia_mtime.tv_sec = arg->mtime;
+		iattr->ia_mtime.tv_nsec = arg->mtimensec;
+		if (!(fvalid & FATTR_MTIME_NOW))
+			iattr->ia_valid |= ATTR_MTIME_SET;
+	}
+	if (fvalid & FATTR_CTIME) {
+		iattr->ia_valid |= ATTR_CTIME;
+		iattr->ia_ctime.tv_sec = arg->ctime;
+		iattr->ia_ctime.tv_nsec = arg->ctimensec;
+	}
+}
+
+int fuse_setattr_initialize_in(struct bpf_fuse_args *fa, struct fuse_setattr_io *fsio,
+			       struct dentry *dentry, struct iattr *attr, struct file *file)
+{
+	struct fuse_conn *fc = get_fuse_conn(dentry->d_inode);
+
+	*fsio = (struct fuse_setattr_io) { 0 };
+	iattr_to_fattr(fc, attr, &fsio->fsi, true);
+
+	*fa = (struct bpf_fuse_args) {
+		.opcode = FUSE_SETATTR,
+		.nodeid = get_node_id(dentry->d_inode),
+		.in_numargs = 1,
+		.in_args[0].size = sizeof(fsio->fsi),
+		.in_args[0].value = &fsio->fsi,
+	};
+
+	return 0;
+}
+
+int fuse_setattr_initialize_out(struct bpf_fuse_args *fa, struct fuse_setattr_io *fsio,
+				struct dentry *dentry, struct iattr *attr, struct file *file)
+{
+	fa->out_numargs = 1;
+	fa->out_args[0].size = sizeof(fsio->fao);
+	fa->out_args[0].value = &fsio->fao;
+
+	return 0;
+}
+
+int fuse_setattr_backing(struct bpf_fuse_args *fa, int *out,
+			 struct dentry *dentry, struct iattr *attr, struct file *file)
+{
+	struct fuse_conn *fc = get_fuse_conn(dentry->d_inode);
+	const struct fuse_setattr_in *fsi = fa->in_args[0].value;
+	struct iattr new_attr = { 0 };
+	struct path *backing_path = &get_fuse_dentry(dentry)->backing_path;
+
+	fattr_to_iattr(fc, fsi, &new_attr);
+	/* TODO: Some info doesn't get saved by the attr->fattr->attr transition
+	 * When we actually allow the bpf to change these, we may have to consider
+	 * the extra flags more, or pass more info into the bpf. Until then we can
+	 * keep everything except for ATTR_FILE, since we'd need a file on the
+	 * lower fs. For what it's worth, neither f2fs nor ext4 make use of that
+	 * even if it is present.
+	 */
+	new_attr.ia_valid = attr->ia_valid & ~ATTR_FILE;
+	inode_lock(d_inode(backing_path->dentry));
+	*out = notify_change(&init_user_ns, backing_path->dentry, &new_attr,
+			    NULL);
+	inode_unlock(d_inode(backing_path->dentry));
+
+	if (*out == 0 && (new_attr.ia_valid & ATTR_SIZE))
+		i_size_write(dentry->d_inode, new_attr.ia_size);
+	return 0;
+}
+
+int fuse_setattr_finalize(struct bpf_fuse_args *fa, int *out,
+			  struct dentry *dentry, struct iattr *attr, struct file *file)
+{
+	return 0;
+}
+
+int fuse_statfs_initialize_in(struct bpf_fuse_args *fa, struct fuse_statfs_out *fso,
+			      struct dentry *dentry, struct kstatfs *buf)
+{
+	*fa = (struct bpf_fuse_args) {
+		.nodeid = get_node_id(d_inode(dentry)),
+		.opcode = FUSE_STATFS,
+	};
+
+	return 0;
+}
+
+int fuse_statfs_initialize_out(struct bpf_fuse_args *fa, struct fuse_statfs_out *fso,
+			       struct dentry *dentry, struct kstatfs *buf)
+{
+	*fso = (struct fuse_statfs_out) { 0 };
+
+	fa->out_numargs = 1;
+	fa->out_args[0].size = sizeof(fso);
+	fa->out_args[0].value = fso;
+
+	return 0;
+}
+
+int fuse_statfs_backing(struct bpf_fuse_args *fa, int *out,
+			struct dentry *dentry, struct kstatfs *buf)
+{
+	struct path backing_path;
+	struct fuse_statfs_out *fso = fa->out_args[0].value;
+
+	*out = 0;
+	get_fuse_backing_path(dentry, &backing_path);
+	if (!backing_path.dentry)
+		return -EBADF;
+	*out = vfs_statfs(&backing_path, buf);
+	path_put(&backing_path);
+	buf->f_type = FUSE_SUPER_MAGIC;
+
+	//TODO Provide postfilter opportunity to modify
+	if (!*out)
+		convert_statfs_to_fuse(&fso->st, buf);
+
+	return 0;
+}
+
+int fuse_statfs_finalize(struct bpf_fuse_args *fa, int *out,
+			 struct dentry *dentry, struct kstatfs *buf)
+{
+	struct fuse_statfs_out *fso = fa->out_args[0].value;
+
+	if (!fa->error_in)
+		convert_fuse_statfs(buf, &fso->st);
+	return 0;
+}
+
 int fuse_readdir_initialize_in(struct bpf_fuse_args *fa, struct fuse_read_io *frio,
 			    struct file *file, struct dir_context *ctx,
 			    bool *force_again, bool *allow_force, bool is_continued)
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 7c9d8540668c..af1f715a405d 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1215,7 +1215,7 @@ static int fuse_link(struct dentry *entry, struct inode *newdir,
 	return err;
 }
 
-static void fuse_fillattr(struct inode *inode, struct fuse_attr *attr,
+void fuse_fillattr(struct inode *inode, struct fuse_attr *attr,
 			  struct kstat *stat)
 {
 	unsigned int blkbits;
@@ -1292,6 +1292,7 @@ static int fuse_do_getattr(struct inode *inode, struct kstat *stat,
 }
 
 static int fuse_update_get_attr(struct inode *inode, struct file *file,
+				const struct path *path,
 				struct kstat *stat, u32 request_mask,
 				unsigned int flags)
 {
@@ -1301,6 +1302,14 @@ static int fuse_update_get_attr(struct inode *inode, struct file *file,
 	u32 inval_mask = READ_ONCE(fi->inval_mask);
 	u32 cache_mask = fuse_get_cache_mask(inode);
 
+#ifdef CONFIG_FUSE_BPF
+	if (fuse_bpf_backing(inode, struct fuse_getattr_io, err,
+			       fuse_getattr_initialize_in, fuse_getattr_initialize_out,
+			       fuse_getattr_backing, fuse_getattr_finalize,
+			       path->dentry, stat, request_mask, flags))
+		return err;
+#endif
+
 	if (flags & AT_STATX_FORCE_SYNC)
 		sync = true;
 	else if (flags & AT_STATX_DONT_SYNC)
@@ -1324,7 +1333,7 @@ static int fuse_update_get_attr(struct inode *inode, struct file *file,
 
 int fuse_update_attributes(struct inode *inode, struct file *file, u32 mask)
 {
-	return fuse_update_get_attr(inode, file, NULL, mask, 0);
+	return fuse_update_get_attr(inode, file, &file->f_path, NULL, mask, 0);
 }
 
 int fuse_reverse_inval_entry(struct fuse_conn *fc, u64 parent_nodeid,
@@ -1703,58 +1712,6 @@ static long fuse_dir_compat_ioctl(struct file *file, unsigned int cmd,
 				 FUSE_IOCTL_COMPAT | FUSE_IOCTL_DIR);
 }
 
-static inline bool update_mtime(unsigned int ivalid, bool trust_local_mtime)
-{
-	/* Always update if mtime is explicitly set  */
-	if (ivalid & ATTR_MTIME_SET)
-		return true;
-
-	/* Or if kernel i_mtime is the official one */
-	if (trust_local_mtime)
-		return true;
-
-	/* If it's an open(O_TRUNC) or an ftruncate(), don't update */
-	if ((ivalid & ATTR_SIZE) && (ivalid & (ATTR_OPEN | ATTR_FILE)))
-		return false;
-
-	/* In all other cases update */
-	return true;
-}
-
-static void iattr_to_fattr(struct fuse_conn *fc, struct iattr *iattr,
-			   struct fuse_setattr_in *arg, bool trust_local_cmtime)
-{
-	unsigned ivalid = iattr->ia_valid;
-
-	if (ivalid & ATTR_MODE)
-		arg->valid |= FATTR_MODE,   arg->mode = iattr->ia_mode;
-	if (ivalid & ATTR_UID)
-		arg->valid |= FATTR_UID,    arg->uid = from_kuid(fc->user_ns, iattr->ia_uid);
-	if (ivalid & ATTR_GID)
-		arg->valid |= FATTR_GID,    arg->gid = from_kgid(fc->user_ns, iattr->ia_gid);
-	if (ivalid & ATTR_SIZE)
-		arg->valid |= FATTR_SIZE,   arg->size = iattr->ia_size;
-	if (ivalid & ATTR_ATIME) {
-		arg->valid |= FATTR_ATIME;
-		arg->atime = iattr->ia_atime.tv_sec;
-		arg->atimensec = iattr->ia_atime.tv_nsec;
-		if (!(ivalid & ATTR_ATIME_SET))
-			arg->valid |= FATTR_ATIME_NOW;
-	}
-	if ((ivalid & ATTR_MTIME) && update_mtime(ivalid, trust_local_cmtime)) {
-		arg->valid |= FATTR_MTIME;
-		arg->mtime = iattr->ia_mtime.tv_sec;
-		arg->mtimensec = iattr->ia_mtime.tv_nsec;
-		if (!(ivalid & ATTR_MTIME_SET) && !trust_local_cmtime)
-			arg->valid |= FATTR_MTIME_NOW;
-	}
-	if ((ivalid & ATTR_CTIME) && trust_local_cmtime) {
-		arg->valid |= FATTR_CTIME;
-		arg->ctime = iattr->ia_ctime.tv_sec;
-		arg->ctimensec = iattr->ia_ctime.tv_nsec;
-	}
-}
-
 /*
  * Prevent concurrent writepages on inode
  *
@@ -1869,6 +1826,13 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 	bool trust_local_cmtime = is_wb;
 	bool fault_blocked = false;
 
+#ifdef CONFIG_FUSE_BPF
+	if (fuse_bpf_backing(inode, struct fuse_setattr_io, err,
+			       fuse_setattr_initialize_in, fuse_setattr_initialize_out,
+			       fuse_setattr_backing, fuse_setattr_finalize, dentry, attr, file))
+		return err;
+#endif
+
 	if (!fc->default_permissions)
 		attr->ia_valid |= ATTR_FORCE;
 
@@ -2044,11 +2008,19 @@ static int fuse_setattr(struct user_namespace *mnt_userns, struct dentry *entry,
 		 * This should be done on write(), truncate() and chown().
 		 */
 		if (!fc->handle_killpriv && !fc->handle_killpriv_v2) {
+#ifdef CONFIG_FUSE_BPF
 			/*
 			 * ia_mode calculation may have used stale i_mode.
 			 * Refresh and recalculate.
 			 */
-			ret = fuse_do_getattr(inode, NULL, file);
+			if (!fuse_bpf_backing(inode, struct fuse_getattr_io, ret,
+					       fuse_getattr_initialize_in,
+					       fuse_getattr_initialize_out,
+					       fuse_getattr_backing,
+					       fuse_getattr_finalize,
+					       entry, NULL, 0, 0))
+#endif
+				ret = fuse_do_getattr(inode, NULL, file);
 			if (ret)
 				return ret;
 
@@ -2105,7 +2077,7 @@ static int fuse_getattr(struct user_namespace *mnt_userns,
 		return -EACCES;
 	}
 
-	return fuse_update_get_attr(inode, NULL, stat, request_mask, flags);
+	return fuse_update_get_attr(inode, NULL, path, stat, request_mask, flags);
 }
 
 static const struct inode_operations fuse_dir_inode_operations = {
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 6c2f75ae9a5a..f8eddcb24137 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1623,6 +1623,46 @@ int fuse_lookup_finalize(struct bpf_fuse_args *fa, struct dentry **out,
 			 struct inode *dir, struct dentry *entry, unsigned int flags);
 int fuse_revalidate_backing(struct dentry *entry, unsigned int flags);
 
+struct fuse_getattr_io {
+	struct fuse_getattr_in fgi;
+	struct fuse_attr_out fao;
+};
+int fuse_getattr_initialize_in(struct bpf_fuse_args *fa, struct fuse_getattr_io *fgio,
+			       const struct dentry *entry, struct kstat *stat,
+			       u32 request_mask, unsigned int flags);
+int fuse_getattr_initialize_out(struct bpf_fuse_args *fa, struct fuse_getattr_io *fgio,
+				const struct dentry *entry, struct kstat *stat,
+				u32 request_mask, unsigned int flags);
+int fuse_getattr_backing(struct bpf_fuse_args *fa, int *out,
+			 const struct dentry *entry, struct kstat *stat,
+			 u32 request_mask, unsigned int flags);
+int fuse_getattr_finalize(struct bpf_fuse_args *fa, int *out,
+			  const struct dentry *entry, struct kstat *stat,
+			  u32 request_mask, unsigned int flags);
+
+struct fuse_setattr_io {
+	struct fuse_setattr_in fsi;
+	struct fuse_attr_out fao;
+};
+
+int fuse_setattr_initialize_in(struct bpf_fuse_args *fa, struct fuse_setattr_io *fsi,
+			       struct dentry *dentry, struct iattr *attr, struct file *file);
+int fuse_setattr_initialize_out(struct bpf_fuse_args *fa, struct fuse_setattr_io *fsi,
+				struct dentry *dentry, struct iattr *attr, struct file *file);
+int fuse_setattr_backing(struct bpf_fuse_args *fa, int *out,
+			 struct dentry *dentry, struct iattr *attr, struct file *file);
+int fuse_setattr_finalize(struct bpf_fuse_args *fa, int *out,
+			  struct dentry *dentry, struct iattr *attr, struct file *file);
+
+int fuse_statfs_initialize_in(struct bpf_fuse_args *fa, struct fuse_statfs_out *fso,
+			      struct dentry *dentry, struct kstatfs *buf);
+int fuse_statfs_initialize_out(struct bpf_fuse_args *fa, struct fuse_statfs_out *fso,
+			       struct dentry *dentry, struct kstatfs *buf);
+int fuse_statfs_backing(struct bpf_fuse_args *fa, int *out,
+			struct dentry *dentry, struct kstatfs *buf);
+int fuse_statfs_finalize(struct bpf_fuse_args *fa, int *out,
+			 struct dentry *dentry, struct kstatfs *buf);
+
 struct fuse_read_io {
 	struct fuse_read_in fri;
 	struct fuse_read_out fro;
@@ -1675,6 +1715,107 @@ static inline u64 attr_timeout(struct fuse_attr_out *o)
 	return time_to_jiffies(o->attr_valid, o->attr_valid_nsec);
 }
 
+static inline bool update_mtime(unsigned int ivalid, bool trust_local_mtime)
+{
+	/* Always update if mtime is explicitly set  */
+	if (ivalid & ATTR_MTIME_SET)
+		return true;
+
+	/* Or if kernel i_mtime is the official one */
+	if (trust_local_mtime)
+		return true;
+
+	/* If it's an open(O_TRUNC) or an ftruncate(), don't update */
+	if ((ivalid & ATTR_SIZE) && (ivalid & (ATTR_OPEN | ATTR_FILE)))
+		return false;
+
+	/* In all other cases update */
+	return true;
+}
+
+void fuse_fillattr(struct inode *inode, struct fuse_attr *attr,
+			  struct kstat *stat);
+
+static inline void iattr_to_fattr(struct fuse_conn *fc, struct iattr *iattr,
+			   struct fuse_setattr_in *arg, bool trust_local_cmtime)
+{
+	unsigned int ivalid = iattr->ia_valid;
+
+	if (ivalid & ATTR_MODE)
+		arg->valid |= FATTR_MODE,   arg->mode = iattr->ia_mode;
+	if (ivalid & ATTR_UID)
+		arg->valid |= FATTR_UID,    arg->uid = from_kuid(fc->user_ns, iattr->ia_uid);
+	if (ivalid & ATTR_GID)
+		arg->valid |= FATTR_GID,    arg->gid = from_kgid(fc->user_ns, iattr->ia_gid);
+	if (ivalid & ATTR_SIZE)
+		arg->valid |= FATTR_SIZE,   arg->size = iattr->ia_size;
+	if (ivalid & ATTR_ATIME) {
+		arg->valid |= FATTR_ATIME;
+		arg->atime = iattr->ia_atime.tv_sec;
+		arg->atimensec = iattr->ia_atime.tv_nsec;
+		if (!(ivalid & ATTR_ATIME_SET))
+			arg->valid |= FATTR_ATIME_NOW;
+	}
+	if ((ivalid & ATTR_MTIME) && update_mtime(ivalid, trust_local_cmtime)) {
+		arg->valid |= FATTR_MTIME;
+		arg->mtime = iattr->ia_mtime.tv_sec;
+		arg->mtimensec = iattr->ia_mtime.tv_nsec;
+		if (!(ivalid & ATTR_MTIME_SET) && !trust_local_cmtime)
+			arg->valid |= FATTR_MTIME_NOW;
+	}
+	if ((ivalid & ATTR_CTIME) && trust_local_cmtime) {
+		arg->valid |= FATTR_CTIME;
+		arg->ctime = iattr->ia_ctime.tv_sec;
+		arg->ctimensec = iattr->ia_ctime.tv_nsec;
+	}
+}
+
+static inline int finalize_attr(struct inode *inode, struct fuse_attr_out *outarg,
+				u64 attr_version, struct kstat *stat)
+{
+	int err = 0;
+
+	if (fuse_invalid_attr(&outarg->attr) ||
+	    ((inode->i_mode ^ outarg->attr.mode) & S_IFMT)) {
+		fuse_make_bad(inode);
+		err = -EIO;
+	} else {
+		fuse_change_attributes(inode, &outarg->attr,
+				       attr_timeout(outarg),
+				       attr_version);
+		if (stat)
+			fuse_fillattr(inode, &outarg->attr, stat);
+	}
+	return err;
+}
+
+static inline void convert_statfs_to_fuse(struct fuse_kstatfs *attr, struct kstatfs *stbuf)
+{
+	attr->bsize   = stbuf->f_bsize;
+	attr->frsize  = stbuf->f_frsize;
+	attr->blocks  = stbuf->f_blocks;
+	attr->bfree   = stbuf->f_bfree;
+	attr->bavail  = stbuf->f_bavail;
+	attr->files   = stbuf->f_files;
+	attr->ffree   = stbuf->f_ffree;
+	attr->namelen = stbuf->f_namelen;
+	/* fsid is left zero */
+}
+
+static inline void convert_fuse_statfs(struct kstatfs *stbuf, struct fuse_kstatfs *attr)
+{
+	stbuf->f_type    = FUSE_SUPER_MAGIC;
+	stbuf->f_bsize   = attr->bsize;
+	stbuf->f_frsize  = attr->frsize;
+	stbuf->f_blocks  = attr->blocks;
+	stbuf->f_bfree   = attr->bfree;
+	stbuf->f_bavail  = attr->bavail;
+	stbuf->f_files   = attr->files;
+	stbuf->f_ffree   = attr->ffree;
+	stbuf->f_namelen = attr->namelen;
+	/* fsid is left zero */
+}
+
 #ifdef CONFIG_FUSE_BPF
 int __init fuse_bpf_init(void);
 void __exit fuse_bpf_cleanup(void);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index c96cfcbfd96a..d178c3eb445f 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -620,20 +620,6 @@ static void fuse_send_destroy(struct fuse_mount *fm)
 	}
 }
 
-static void convert_fuse_statfs(struct kstatfs *stbuf, struct fuse_kstatfs *attr)
-{
-	stbuf->f_type    = FUSE_SUPER_MAGIC;
-	stbuf->f_bsize   = attr->bsize;
-	stbuf->f_frsize  = attr->frsize;
-	stbuf->f_blocks  = attr->blocks;
-	stbuf->f_bfree   = attr->bfree;
-	stbuf->f_bavail  = attr->bavail;
-	stbuf->f_files   = attr->files;
-	stbuf->f_ffree   = attr->ffree;
-	stbuf->f_namelen = attr->namelen;
-	/* fsid is left zero */
-}
-
 static int fuse_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
 	struct super_block *sb = dentry->d_sb;
@@ -647,6 +633,14 @@ static int fuse_statfs(struct dentry *dentry, struct kstatfs *buf)
 		return 0;
 	}
 
+#ifdef CONFIG_FUSE_BPF
+	if (fuse_bpf_backing(dentry->d_inode, struct fuse_statfs_out, err,
+			       fuse_statfs_initialize_in, fuse_statfs_initialize_out,
+			       fuse_statfs_backing, fuse_statfs_finalize,
+			       dentry, buf))
+		return err;
+#endif
+
 	memset(&outarg, 0, sizeof(outarg));
 	args.in_numargs = 0;
 	args.opcode = FUSE_STATFS;
-- 
2.37.3.998.g577e59143f-goog

