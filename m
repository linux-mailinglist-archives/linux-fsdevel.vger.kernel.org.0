Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83A26E56E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 03:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjDRBoD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 21:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjDRBmw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 21:42:52 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAC85FFE
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 18:41:50 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54fbc270950so116954207b3.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 18:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681782099; x=1684374099;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nG4okeL2v0Jdp53r3S0fEOBeF2fbrMx1qVzxXkIqqTE=;
        b=u0cBnWjjy4rLWn/KKVJ6YrMH0yDyoE7VqGPJ1ZiIQiauc+J5y96wH58/hT/Tgc/dtZ
         qAd8rv3qhW+TfRFJg9rTk5e1V98BfhsrmoHYLyb0zIlV624hfurC4g6h1SkmtTdbB341
         9N9rKVQFrHEQHE+epE3uDxR+62tw6wmYtb5fVlZg/aQUSKFfRzHj2Vdiu4aT0COlQHJD
         68+YCVPzX890hTZGkZW7BXMMybXNvFt12+o4RZx6+p/OOvSLdYn1UPSLG/g5tTN3SCq7
         v6msMYUXxk8pTJQWAng43xaxeTq5LLYD7um28T6hLW6CQD3nYt1tEV7tT85OQc7zg2Ss
         jdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681782099; x=1684374099;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nG4okeL2v0Jdp53r3S0fEOBeF2fbrMx1qVzxXkIqqTE=;
        b=Li6+wJGVtO+9J+5oMOHi0frD0CFyzBw0iNpNPGOSkmDUuk14Ak9tGpuXJhsnK/9s7Z
         iQaZZWgOctswa07NMeKT9eXrW1fq4hAd+J3hUnZkPSI+YKVSmovNtoKbD3YmumZ34Q00
         xzSDOcve3evhcQS9o1cyTTwuMPO7G7U9/PPUROdqef/4spW2YN+GKog7TIQBjtxeDroL
         QB25aaY6cwA3hLiRKi/Uk0PFPbu//DfiBl+6lFSGWHJggZKkUVRVKzHN5W5xV5fYNdsW
         ZG7/vBSkGMkFqfapJs2fwjnSlGGfNSIxmgw0tYYt9skAwA9G7vWm4v359zBN2q0aJvTL
         rkBg==
X-Gm-Message-State: AAQBX9cbqix1r7Fjekrez9eJXLPLqI3Sk4FKuhjTK2Yu3xcq8dT3arp5
        jbNEs9qR3Za/GFTL0dc3jHa3XgGISqA=
X-Google-Smtp-Source: AKy350YhytlOZ02ss3SEwZRBfhwnYIswD0E28QPdA5RI4z8jwAukpSy/1DOKgKx6QO6ewMAWxbSCDtbtTCc=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:e67a:98b0:942d:86aa])
 (user=drosen job=sendgmr) by 2002:a81:ae12:0:b0:54c:2409:c306 with SMTP id
 m18-20020a81ae12000000b0054c2409c306mr10197096ywh.6.1681782098995; Mon, 17
 Apr 2023 18:41:38 -0700 (PDT)
Date:   Mon, 17 Apr 2023 18:40:21 -0700
In-Reply-To: <20230418014037.2412394-1-drosen@google.com>
Mime-Version: 1.0
References: <20230418014037.2412394-1-drosen@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418014037.2412394-22-drosen@google.com>
Subject: [RFC PATCH v3 21/37] fuse-bpf: Add attr support
From:   Daniel Rosenberg <drosen@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds backing support for FUSE_GETATTR, FUSE_SETATTR, and FUSE_STATFS

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/backing.c | 288 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dir.c     |  68 ++---------
 fs/fuse/fuse_i.h  | 102 ++++++++++++++++
 fs/fuse/inode.c   |  17 +--
 4 files changed, 405 insertions(+), 70 deletions(-)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index d3a706b55905..6a6130a16d2b 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -2066,6 +2066,294 @@ int fuse_bpf_unlink(int *out, struct inode *dir, struct dentry *entry)
 				dir, entry);
 }
 
+struct fuse_getattr_args {
+	struct fuse_getattr_in in;
+	struct fuse_attr_out out;
+};
+
+static int fuse_getattr_initialize_in(struct bpf_fuse_args *fa, struct fuse_getattr_args *args,
+				      const struct dentry *entry, struct kstat *stat,
+				      u32 request_mask, unsigned int flags)
+{
+	args->in = (struct fuse_getattr_in) {
+		.getattr_flags = flags,
+		.fh = -1, /* TODO is this OK? */
+	};
+
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.nodeid = get_node_id(entry->d_inode),
+			.opcode = FUSE_GETATTR,
+		},
+		.in_numargs = 1,
+		.in_args[0] = (struct bpf_fuse_arg) {
+			.size = sizeof(args->in),
+			.value = &args->in,
+		},
+	};
+
+	return 0;
+}
+
+static int fuse_getattr_initialize_out(struct bpf_fuse_args *fa, struct fuse_getattr_args *args,
+				       const struct dentry *entry, struct kstat *stat,
+				       u32 request_mask, unsigned int flags)
+{
+	args->out = (struct fuse_attr_out) { 0 };
+
+	fa->out_numargs = 1;
+	fa->out_args[0] = (struct bpf_fuse_arg) {
+		.size = sizeof(args->out),
+		.value = &args->out,
+	};
+
+	return 0;
+}
+
+static int fuse_getattr_backing(struct bpf_fuse_args *fa, int *out,
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
+static int fuse_getattr_finalize(struct bpf_fuse_args *fa, int *out,
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
+	return bpf_fuse_backing(inode, struct fuse_getattr_args, out,
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
+struct fuse_setattr_args {
+	struct fuse_setattr_in in;
+	struct fuse_attr_out out;
+};
+
+static int fuse_setattr_initialize_in(struct bpf_fuse_args *fa, struct fuse_setattr_args *args,
+				      struct dentry *dentry, struct iattr *attr, struct file *file)
+{
+	struct fuse_conn *fc = get_fuse_conn(dentry->d_inode);
+
+	*args = (struct fuse_setattr_args) { 0 };
+	iattr_to_fattr(fc, attr, &args->in, true);
+
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.opcode = FUSE_SETATTR,
+			.nodeid = get_node_id(dentry->d_inode),
+		},
+		.in_numargs = 1,
+		.in_args[0].size = sizeof(args->in),
+		.in_args[0].value = &args->in,
+	};
+
+	return 0;
+}
+
+static int fuse_setattr_initialize_out(struct bpf_fuse_args *fa, struct fuse_setattr_args *args,
+				       struct dentry *dentry, struct iattr *attr, struct file *file)
+{
+	fa->out_numargs = 1;
+	fa->out_args[0].size = sizeof(args->out);
+	fa->out_args[0].value = &args->out;
+
+	return 0;
+}
+
+static int fuse_setattr_backing(struct bpf_fuse_args *fa, int *out,
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
+	*out = notify_change(&nop_mnt_idmap, backing_path->dentry, &new_attr,
+			    NULL);
+	inode_unlock(d_inode(backing_path->dentry));
+
+	if (*out == 0 && (new_attr.ia_valid & ATTR_SIZE))
+		i_size_write(dentry->d_inode, new_attr.ia_size);
+	return 0;
+}
+
+static int fuse_setattr_finalize(struct bpf_fuse_args *fa, int *out,
+				 struct dentry *dentry, struct iattr *attr, struct file *file)
+{
+	return 0;
+}
+
+int fuse_bpf_setattr(int *out, struct inode *inode, struct dentry *dentry, struct iattr *attr, struct file *file)
+{
+	return bpf_fuse_backing(inode, struct fuse_setattr_args, out,
+				fuse_setattr_initialize_in, fuse_setattr_initialize_out,
+				fuse_setattr_backing, fuse_setattr_finalize,
+				dentry, attr, file);
+}
+
+static int fuse_statfs_initialize_in(struct bpf_fuse_args *fa, struct fuse_statfs_out *out,
+				     struct dentry *dentry, struct kstatfs *buf)
+{
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.nodeid = get_node_id(d_inode(dentry)),
+			.opcode = FUSE_STATFS,
+		},
+	};
+
+	return 0;
+}
+
+static int fuse_statfs_initialize_out(struct bpf_fuse_args *fa, struct fuse_statfs_out *out,
+				      struct dentry *dentry, struct kstatfs *buf)
+{
+	*out = (struct fuse_statfs_out) { 0 };
+
+	fa->out_numargs = 1;
+	fa->out_args[0].size = sizeof(*out);
+	fa->out_args[0].value = out;
+
+	return 0;
+}
+
+static int fuse_statfs_backing(struct bpf_fuse_args *fa, int *out,
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
+static int fuse_statfs_finalize(struct bpf_fuse_args *fa, int *out,
+				struct dentry *dentry, struct kstatfs *buf)
+{
+	struct fuse_statfs_out *fso = fa->out_args[0].value;
+
+	if (!fa->info.error_in)
+		convert_fuse_statfs(buf, &fso->st);
+	return 0;
+}
+
+int fuse_bpf_statfs(int *out, struct inode *inode, struct dentry *dentry, struct kstatfs *buf)
+{
+	return bpf_fuse_backing(dentry->d_inode, struct fuse_statfs_out, out,
+				fuse_statfs_initialize_in, fuse_statfs_initialize_out,
+				fuse_statfs_backing, fuse_statfs_finalize,
+				dentry, buf);
+}
+
 struct fuse_read_args {
 	struct fuse_read_in in;
 	struct fuse_read_out out;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 086e3ecada19..7d589241c9b0 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1236,7 +1236,7 @@ static int fuse_link(struct dentry *entry, struct inode *newdir,
 	return err;
 }
 
-static void fuse_fillattr(struct inode *inode, struct fuse_attr *attr,
+void fuse_fillattr(struct inode *inode, struct fuse_attr *attr,
 			  struct kstat *stat)
 {
 	unsigned int blkbits;
@@ -1313,6 +1313,7 @@ static int fuse_do_getattr(struct inode *inode, struct kstat *stat,
 }
 
 static int fuse_update_get_attr(struct inode *inode, struct file *file,
+				const struct path *path,
 				struct kstat *stat, u32 request_mask,
 				unsigned int flags)
 {
@@ -1322,6 +1323,9 @@ static int fuse_update_get_attr(struct inode *inode, struct file *file,
 	u32 inval_mask = READ_ONCE(fi->inval_mask);
 	u32 cache_mask = fuse_get_cache_mask(inode);
 
+	if (fuse_bpf_getattr(&err, inode, path->dentry, stat, request_mask, flags))
+		return err;
+
 	if (flags & AT_STATX_FORCE_SYNC)
 		sync = true;
 	else if (flags & AT_STATX_DONT_SYNC)
@@ -1345,7 +1349,7 @@ static int fuse_update_get_attr(struct inode *inode, struct file *file,
 
 int fuse_update_attributes(struct inode *inode, struct file *file, u32 mask)
 {
-	return fuse_update_get_attr(inode, file, NULL, mask, 0);
+	return fuse_update_get_attr(inode, file, &file->f_path, NULL, mask, 0);
 }
 
 int fuse_reverse_inval_entry(struct fuse_conn *fc, u64 parent_nodeid,
@@ -1714,58 +1718,6 @@ static long fuse_dir_compat_ioctl(struct file *file, unsigned int cmd,
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
@@ -1880,6 +1832,9 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 	bool trust_local_cmtime = is_wb;
 	bool fault_blocked = false;
 
+	if (fuse_bpf_setattr(&err, inode, dentry, attr, file))
+		return err;
+
 	if (!fc->default_permissions)
 		attr->ia_valid |= ATTR_FORCE;
 
@@ -2059,7 +2014,8 @@ static int fuse_setattr(struct mnt_idmap *idmap, struct dentry *entry,
 			 * ia_mode calculation may have used stale i_mode.
 			 * Refresh and recalculate.
 			 */
-			ret = fuse_do_getattr(inode, NULL, file);
+			if (!fuse_bpf_getattr(&ret, inode, entry, NULL, 0, 0))
+				ret = fuse_do_getattr(inode, NULL, file);
 			if (ret)
 				return ret;
 
@@ -2116,7 +2072,7 @@ static int fuse_getattr(struct mnt_idmap *idmap,
 		return -EACCES;
 	}
 
-	return fuse_update_get_attr(inode, NULL, stat, request_mask, flags);
+	return fuse_update_get_attr(inode, NULL, path, stat, request_mask, flags);
 }
 
 static const struct inode_operations fuse_dir_inode_operations = {
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 5c8bd2f76fb9..17899a1fe885 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1427,6 +1427,10 @@ int fuse_bpf_file_read_iter(ssize_t *out, struct inode *inode, struct kiocb *ioc
 int fuse_bpf_file_write_iter(ssize_t *out, struct inode *inode, struct kiocb *iocb, struct iov_iter *from);
 int fuse_bpf_file_fallocate(int *out, struct inode *inode, struct file *file, int mode, loff_t offset, loff_t length);
 int fuse_bpf_lookup(struct dentry **out, struct inode *dir, struct dentry *entry, unsigned int flags);
+int fuse_bpf_getattr(int *out, struct inode *inode, const struct dentry *entry, struct kstat *stat,
+		     u32 request_mask, unsigned int flags);
+int fuse_bpf_setattr(int *out, struct inode *inode, struct dentry *dentry, struct iattr *attr, struct file *file);
+int fuse_bpf_statfs(int *out, struct inode *inode, struct dentry *dentry, struct kstatfs *buf);
 int fuse_bpf_readdir(int *out, struct inode *inode, struct file *file, struct dir_context *ctx);
 int fuse_bpf_access(int *out, struct inode *inode, int mask);
 
@@ -1526,6 +1530,22 @@ static inline int fuse_bpf_lookup(struct dentry **out, struct inode *dir, struct
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
@@ -1571,6 +1591,88 @@ static inline u64 attr_timeout(struct fuse_attr_out *o)
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
index fd00910f1eb1..3dfb9cfb6e73 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -623,20 +623,6 @@ static void fuse_send_destroy(struct fuse_mount *fm)
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
@@ -650,6 +636,9 @@ static int fuse_statfs(struct dentry *dentry, struct kstatfs *buf)
 		return 0;
 	}
 
+	if (fuse_bpf_statfs(&err, dentry->d_inode, dentry, buf))
+		return err;
+
 	memset(&outarg, 0, sizeof(outarg));
 	args.in_numargs = 0;
 	args.opcode = FUSE_STATFS;
-- 
2.40.0.634.g4ca3ef3211-goog

