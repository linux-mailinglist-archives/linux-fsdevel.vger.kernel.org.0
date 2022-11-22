Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6B3633322
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 03:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbiKVCT7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 21:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbiKVCSW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 21:18:22 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70472E8727
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 18:16:34 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-360b9418f64so127237647b3.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 18:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vK6IEU0rl0A24X4GIdUEvjRzL9edAkzNEa8n9WiUMOU=;
        b=nMVdkL0Xs5RgzWRONSx7pNImE+bdCfORjqA/LqFEd467SrKJfeWf6eN7nWhCoYvm8i
         lKE791H13iGM9kcYULB5UfWIT7xYH8K0/qG2RNjqHoa3PwzjAgp201p8gC7hDeLwDbuI
         KRMgvcAME8kkAHQkq1IKt6UoKtL5lk/lrppet4xXxkvnIZ2jZRAIf1ZlzdvA9a9T+pVJ
         CnUcjD9wra0H99CSqH1Q8CksG93wEUjbHpF1gS0mzvHoaJLRNXhBi/dkAY0BQfB0sSqQ
         P5RX2FYAas3eiojJoqiNofyNGKolBNM/dV9mQ70c1wBz5OKscuESwcZHX6KvA+cdNL2V
         4DpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vK6IEU0rl0A24X4GIdUEvjRzL9edAkzNEa8n9WiUMOU=;
        b=yiXgIZsINV73ONLaDZVuqsO4wSY6ooR61rlr0m4vv5KYTfUJ9agzvXzfls3Itbif0b
         k506/Xgma0cisGGDok9tacjp7S4945a+C+deFtve8/oORL5uhLOcjPx/4P1wYgCxB1po
         IPF6NbRxfy4A36TqqrPtiV6DdaVj+9cwoOYt8aPtpDskEbM8cHFSpcln0nDrWavQ10Su
         xJ3xXQuFI56bZ3qDmCQZOBKYLu4EHVi+W0gUAQrKcWc5QuVPhPyAuQTsoJjSenRAutal
         VH54sb8KY6PUgjU5lS+YxrtTeawxdBIcY8XA4006JRF2YtLc3GHL+aoAXl/x0QVu8Afj
         mgpw==
X-Gm-Message-State: ANoB5plMjVo8MkQhnZM5b1MvcJ5oUAwJEKLD8XhsfpnzySFNprgwaF4/
        FOuhO0IR441PvnMnYCIjeKqtjNIdFWk=
X-Google-Smtp-Source: AA0mqf4juP2sH3loBkPBVMzJjWmoJtUT4+2VIy9N+HQ0k5t+bQfVKfppkSGU+H9HgW3UD4/H4KKDeH9fU+Y=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:200:8539:aadd:13be:6e82])
 (user=drosen job=sendgmr) by 2002:a81:4e14:0:b0:39d:5ff1:4418 with SMTP id
 c20-20020a814e14000000b0039d5ff14418mr2ywb.381.1669083393403; Mon, 21 Nov
 2022 18:16:33 -0800 (PST)
Date:   Mon, 21 Nov 2022 18:15:32 -0800
In-Reply-To: <20221122021536.1629178-1-drosen@google.com>
Mime-Version: 1.0
References: <20221122021536.1629178-1-drosen@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221122021536.1629178-18-drosen@google.com>
Subject: [RFC PATCH v2 17/21] fuse-bpf: Add attr support
From:   Daniel Rosenberg <drosen@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>
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
 fs/fuse/backing.c | 281 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dir.c     |  68 ++---------
 fs/fuse/fuse_i.h  | 102 +++++++++++++++++
 fs/fuse/inode.c   |  17 +--
 4 files changed, 398 insertions(+), 70 deletions(-)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index 333181d6ad73..e2fe8c3aac2d 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -1949,6 +1949,287 @@ int fuse_bpf_unlink(int *out, struct inode *dir, struct dentry *entry)
 				dir, entry);
 }
 
+struct fuse_getattr_io {
+	struct fuse_getattr_in fgi;
+	struct fuse_attr_out fao;
+};
+
+static int fuse_getattr_initialize_in(struct fuse_args *fa, struct fuse_getattr_io *fgio,
+				      const struct dentry *entry, struct kstat *stat,
+				      u32 request_mask, unsigned int flags)
+{
+	fgio->fgi = (struct fuse_getattr_in) {
+		.getattr_flags = flags,
+		.fh = -1, /* TODO is this OK? */
+	};
+
+	*fa = (struct fuse_args) {
+		.nodeid = get_node_id(entry->d_inode),
+		.opcode = FUSE_GETATTR,
+		.in_numargs = 1,
+		.in_args[0] = (struct fuse_in_arg) {
+			.size = sizeof(fgio->fgi),
+			.value = &fgio->fgi,
+		},
+	};
+
+	return 0;
+}
+
+static int fuse_getattr_initialize_out(struct fuse_args *fa, struct fuse_getattr_io *fgio,
+				       const struct dentry *entry, struct kstat *stat,
+				       u32 request_mask, unsigned int flags)
+{
+	fgio->fao = (struct fuse_attr_out) { 0 };
+
+	fa->out_numargs = 1;
+	fa->out_args[0] = (struct fuse_arg) {
+		.size = sizeof(fgio->fao),
+		.value = &fgio->fao,
+	};
+
+	return 0;
+}
+
+static int fuse_getattr_backing(struct fuse_args *fa, int *out,
+				const struct dentry *entry, struct kstat *stat,
+				u32 request_mask, unsigned int flags)
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
+static int finalize_attr(struct inode *inode, struct fuse_attr_out *outarg,
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
+static int fuse_getattr_finalize(struct fuse_args *fa, int *out,
+				 const struct dentry *entry, struct kstat *stat,
+				 u32 request_mask, unsigned int flags)
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
+int fuse_bpf_getattr(int *out, struct inode *inode, const struct dentry *entry, struct kstat *stat,
+		     u32 request_mask, unsigned int flags)
+{
+	return fuse_bpf_backing(inode, struct fuse_getattr_io, out,
+				fuse_getattr_initialize_in, fuse_getattr_initialize_out,
+				fuse_getattr_backing, fuse_getattr_finalize,
+				entry, stat, request_mask, flags);
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
+struct fuse_setattr_io {
+	struct fuse_setattr_in fsi;
+	struct fuse_attr_out fao;
+};
+
+static int fuse_setattr_initialize_in(struct fuse_args *fa, struct fuse_setattr_io *fsio,
+				      struct dentry *dentry, struct iattr *attr, struct file *file)
+{
+	struct fuse_conn *fc = get_fuse_conn(dentry->d_inode);
+
+	*fsio = (struct fuse_setattr_io) { 0 };
+	iattr_to_fattr(fc, attr, &fsio->fsi, true);
+
+	*fa = (struct fuse_args) {
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
+static int fuse_setattr_initialize_out(struct fuse_args *fa, struct fuse_setattr_io *fsio,
+				       struct dentry *dentry, struct iattr *attr, struct file *file)
+{
+	fa->out_numargs = 1;
+	fa->out_args[0].size = sizeof(fsio->fao);
+	fa->out_args[0].value = &fsio->fao;
+
+	return 0;
+}
+
+static int fuse_setattr_backing(struct fuse_args *fa, int *out,
+				struct dentry *dentry, struct iattr *attr, struct file *file)
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
+static int fuse_setattr_finalize(struct fuse_args *fa, int *out,
+				 struct dentry *dentry, struct iattr *attr, struct file *file)
+{
+	return 0;
+}
+
+int fuse_bpf_setattr(int *out, struct inode *inode, struct dentry *dentry, struct iattr *attr, struct file *file)
+{
+	return fuse_bpf_backing(inode, struct fuse_setattr_io, out,
+				fuse_setattr_initialize_in, fuse_setattr_initialize_out,
+				fuse_setattr_backing, fuse_setattr_finalize, dentry, attr, file);
+}
+
+static int fuse_statfs_initialize_in(struct fuse_args *fa, struct fuse_statfs_out *fso,
+				     struct dentry *dentry, struct kstatfs *buf)
+{
+	*fa = (struct fuse_args) {
+		.nodeid = get_node_id(d_inode(dentry)),
+		.opcode = FUSE_STATFS,
+	};
+
+	return 0;
+}
+
+static int fuse_statfs_initialize_out(struct fuse_args *fa, struct fuse_statfs_out *fso,
+				      struct dentry *dentry, struct kstatfs *buf)
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
+static int fuse_statfs_backing(struct fuse_args *fa, int *out,
+			       struct dentry *dentry, struct kstatfs *buf)
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
+static int fuse_statfs_finalize(struct fuse_args *fa, int *out,
+				struct dentry *dentry, struct kstatfs *buf)
+{
+	struct fuse_statfs_out *fso = fa->out_args[0].value;
+
+	if (!fa->error_in)
+		convert_fuse_statfs(buf, &fso->st);
+	return 0;
+}
+
+int fuse_bpf_statfs(int *out, struct inode *inode, struct dentry *dentry, struct kstatfs *buf)
+{
+	return fuse_bpf_backing(dentry->d_inode, struct fuse_statfs_out, out,
+				fuse_statfs_initialize_in, fuse_statfs_initialize_out,
+				fuse_statfs_backing, fuse_statfs_finalize,
+				dentry, buf);
+}
+
 struct fuse_read_io {
 	struct fuse_read_in fri;
 	struct fuse_read_out fro;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 6ad0eb92de3b..899de6c84c2e 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1168,7 +1168,7 @@ static int fuse_link(struct dentry *entry, struct inode *newdir,
 	return err;
 }
 
-static void fuse_fillattr(struct inode *inode, struct fuse_attr *attr,
+void fuse_fillattr(struct inode *inode, struct fuse_attr *attr,
 			  struct kstat *stat)
 {
 	unsigned int blkbits;
@@ -1245,6 +1245,7 @@ static int fuse_do_getattr(struct inode *inode, struct kstat *stat,
 }
 
 static int fuse_update_get_attr(struct inode *inode, struct file *file,
+				const struct path *path,
 				struct kstat *stat, u32 request_mask,
 				unsigned int flags)
 {
@@ -1254,6 +1255,9 @@ static int fuse_update_get_attr(struct inode *inode, struct file *file,
 	u32 inval_mask = READ_ONCE(fi->inval_mask);
 	u32 cache_mask = fuse_get_cache_mask(inode);
 
+	if (fuse_bpf_getattr(&err, inode, path->dentry, stat, request_mask, flags))
+		return err;
+
 	if (flags & AT_STATX_FORCE_SYNC)
 		sync = true;
 	else if (flags & AT_STATX_DONT_SYNC)
@@ -1277,7 +1281,7 @@ static int fuse_update_get_attr(struct inode *inode, struct file *file,
 
 int fuse_update_attributes(struct inode *inode, struct file *file, u32 mask)
 {
-	return fuse_update_get_attr(inode, file, NULL, mask, 0);
+	return fuse_update_get_attr(inode, file, &file->f_path, NULL, mask, 0);
 }
 
 int fuse_reverse_inval_entry(struct fuse_conn *fc, u64 parent_nodeid,
@@ -1639,58 +1643,6 @@ static long fuse_dir_compat_ioctl(struct file *file, unsigned int cmd,
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
@@ -1805,6 +1757,9 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 	bool trust_local_cmtime = is_wb;
 	bool fault_blocked = false;
 
+	if (fuse_bpf_setattr(&err, inode, dentry, attr, file))
+		return err;
+
 	if (!fc->default_permissions)
 		attr->ia_valid |= ATTR_FORCE;
 
@@ -1984,7 +1939,8 @@ static int fuse_setattr(struct user_namespace *mnt_userns, struct dentry *entry,
 			 * ia_mode calculation may have used stale i_mode.
 			 * Refresh and recalculate.
 			 */
-			ret = fuse_do_getattr(inode, NULL, file);
+			if (!fuse_bpf_getattr(&ret, inode, entry, NULL, 0, 0))
+				ret = fuse_do_getattr(inode, NULL, file);
 			if (ret)
 				return ret;
 
@@ -2041,7 +1997,7 @@ static int fuse_getattr(struct user_namespace *mnt_userns,
 		return -EACCES;
 	}
 
-	return fuse_update_get_attr(inode, NULL, stat, request_mask, flags);
+	return fuse_update_get_attr(inode, NULL, path, stat, request_mask, flags);
 }
 
 static const struct inode_operations fuse_dir_inode_operations = {
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 3338ac84d083..8ecaf55e4632 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1422,6 +1422,10 @@ int fuse_bpf_file_read_iter(ssize_t *out, struct inode *inode, struct kiocb *ioc
 int fuse_bpf_file_write_iter(ssize_t *out, struct inode *inode, struct kiocb *iocb, struct iov_iter *from);
 int fuse_bpf_file_fallocate(int *out, struct inode *inode, struct file *file, int mode, loff_t offset, loff_t length);
 int fuse_bpf_lookup(struct dentry **out, struct inode *dir, struct dentry *entry, unsigned int flags);
+int fuse_bpf_getattr(int *out, struct inode *inode, const struct dentry *entry, struct kstat *stat,
+		     u32 request_mask, unsigned int flags);
+int fuse_bpf_setattr(int *out, struct inode *inode, struct dentry *dentry, struct iattr *attr, struct file *file);
+int fuse_bpf_statfs(int *out, struct inode *inode, struct dentry *dentry, struct kstatfs *buf);
 int fuse_bpf_readdir(int *out, struct inode *inode, struct file *file, struct dir_context *ctx);
 int fuse_bpf_access(int *out, struct inode *inode, int mask);
 
@@ -1521,6 +1525,22 @@ static inline int fuse_bpf_lookup(struct dentry **out, struct inode *dir, struct
 	return 0;
 }
 
+static inline int fuse_bpf_getattr(int *out, struct inode *inode, const struct dentry *entry, struct kstat *stat,
+				   u32 request_mask, unsigned int flags)
+{
+	return 0;
+}
+
+static inline int fuse_bpf_setattr(int *out, struct inode *inode, struct dentry *dentry, struct iattr *attr, struct file *file)
+{
+	return 0;
+}
+
+static inline int fuse_bpf_statfs(int *out, struct inode *inode, struct dentry *dentry, struct kstatfs *buf)
+{
+	return 0;
+}
+
 static inline int fuse_bpf_readdir(int *out, struct inode *inode, struct file *file, struct dir_context *ctx)
 {
 	return 0;
@@ -1566,6 +1586,88 @@ static inline u64 attr_timeout(struct fuse_attr_out *o)
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
index 9781faff6df6..1e7d45977144 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -616,20 +616,6 @@ static void fuse_send_destroy(struct fuse_mount *fm)
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
@@ -643,6 +629,9 @@ static int fuse_statfs(struct dentry *dentry, struct kstatfs *buf)
 		return 0;
 	}
 
+	if (fuse_bpf_statfs(&err, dentry->d_inode, dentry, buf))
+		return err;
+
 	memset(&outarg, 0, sizeof(outarg));
 	args.in_numargs = 0;
 	args.opcode = FUSE_STATFS;
-- 
2.38.1.584.g0f3c55d4c2-goog

