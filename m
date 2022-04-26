Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9904250FE5C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 15:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350155AbiDZNMW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 09:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349580AbiDZNMV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:12:21 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E368522EB
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Apr 2022 06:09:13 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id g20so22282569edw.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Apr 2022 06:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VdN4pWw1gFHOQoY+oG3aMlLwfFdnNeJvy8yld8aLNZY=;
        b=h9eIxIlj8VlMyJtF8rAipZvas4ylrtXbM0hqwo7YY5TNioud6/RuQ78vi1FtKhPMwx
         aQU0m4bB8FiWzJb6aNIT7OfCpOhL4d2qn0kmOnQYYUSDlBC7J99crI4KwUXybbZJnWnV
         oEO84zPRqvWKMYf46FTtaIYUvYznA/dEsYHEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VdN4pWw1gFHOQoY+oG3aMlLwfFdnNeJvy8yld8aLNZY=;
        b=n/hU4HM7heh/zYA878JxL6EMoyoL9nf51I/EP2AWAEE3rbhGY/LezG+4MleeIzLgtZ
         5s9qdyaNiagVi+CthCKqhrRTO5LiBewDorFLf5xFFaVDpmtu18TVdffRMOaGSiN78qj+
         vH8mgwA3f05oS7qA24sEvEmp0saE5xD2G9aUrcLLgLkeEPAr0QtnS9Ob5lY8xpckI/Rv
         gnt7ulB6tV+e/aOfwpIfXVK22gKOR8oKoYLkkhgbbuIRTHP6JjKWS2Hl+n8BszVhGzk0
         kDr2jOyyAZDS8eFkGi1gr2GaCgY+iFC4yZAPBFsZ6opjCjwVHkt4hNYUS8JGj4oODRS1
         jkqg==
X-Gm-Message-State: AOAM532Am+G66PMwKMrEjcMa7nFyUWxvOyM+NuRmGufuTV1eXaef7AqV
        hWmK39dzqJtGSZLz2hKGbMU8yA==
X-Google-Smtp-Source: ABdhPJwoEgGyFlADhZL2+OS+zU1EASVg1k8ks63rb41Idnhg6YfoUENziFMMN4nFvKLmsbj4O1A3xw==
X-Received: by 2002:a50:9f06:0:b0:425:c1ba:5037 with SMTP id b6-20020a509f06000000b00425c1ba5037mr21686551edf.285.1650978552055;
        Tue, 26 Apr 2022 06:09:12 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-178-48-189-3.catv.fixed.vodafone.hu. [178.48.189.3])
        by smtp.gmail.com with ESMTPSA id lb4-20020a170907784400b006e0d13f65e5sm4857331ejc.167.2022.04.26.06.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 06:09:11 -0700 (PDT)
Date:   Tue, 26 Apr 2022 15:09:05 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xie Yongji <xieyongji@bytedance.com>
Subject: Re: Re: Re: [RFC PATCH] fuse: support cache revalidation in
 writeback_cache mode
Message-ID: <Ymfu8fGbfYi4FxQ4@miu.piliscsaba.redhat.com>
References: <20220325132126.61949-1-zhangjiachen.jaycee@bytedance.com>
 <CAJfpeguESQm1KsQLyoMRTevLttV8N8NTGsb2tRbNS1AQ_pNAww@mail.gmail.com>
 <CAFQAk7ibzCn8OD84-nfg6_AePsKFTu9m7pXuQwcQP5OBp7ZCag@mail.gmail.com>
 <CAJfpegsbaz+RRcukJEOw+H=G3ft43vjDMnJ8A24JiuZFQ24eHA@mail.gmail.com>
 <CAFQAk7hakYNfBaOeMKRmMPTyxFb2xcyUTdugQG1D6uZB_U1zBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFQAk7hakYNfBaOeMKRmMPTyxFb2xcyUTdugQG1D6uZB_U1zBg@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 25, 2022 at 09:52:44PM +0800, Jiachen Zhang wrote:

> Some users may want both the high performance of writeback mode and a
> little bit more consistency among FUSE mounts. In the current
> writeback mode implementation, users of one FUSE mount can never see
> the file expansion done by other FUSE mounts.

Okay.

Here's a preliminary patch that you could try.

Thanks,
Miklos

---
 fs/fuse/dir.c             |   35 ++++++++++++++++++++++-------------
 fs/fuse/file.c            |   17 +++++++++++++++--
 fs/fuse/fuse_i.h          |   14 +++++++++++++-
 fs/fuse/inode.c           |   32 +++++++++++++++++++++++++++-----
 include/uapi/linux/fuse.h |    5 +++++
 5 files changed, 82 insertions(+), 21 deletions(-)

--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -194,6 +194,7 @@
  *  - add FUSE_SECURITY_CTX init flag
  *  - add security context to create, mkdir, symlink, and mknod requests
  *  - add FUSE_HAS_INODE_DAX, FUSE_ATTR_DAX
+ *  - add FUSE_WRITEBACK_CACHE_V2 init flag
  */
 
 #ifndef _LINUX_FUSE_H
@@ -353,6 +354,9 @@ struct fuse_file_lock {
  * FUSE_SECURITY_CTX:	add security context to create, mkdir, symlink, and
  *			mknod
  * FUSE_HAS_INODE_DAX:  use per inode DAX
+ * FUSE_WRITEBACK_CACHE_V2:
+ *			- allow time/size to be refreshed if no pending write
+ * 			- time/size not cached for falocate/copy_file_range
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -389,6 +393,7 @@ struct fuse_file_lock {
 /* bits 32..63 get shifted down 32 bits into the flags2 field */
 #define FUSE_SECURITY_CTX	(1ULL << 32)
 #define FUSE_HAS_INODE_DAX	(1ULL << 33)
+#define FUSE_WRITEBACK_CACHE_V2	(1ULL << 34)
 
 /**
  * CUSE INIT request/reply flags
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -222,19 +222,37 @@ void fuse_change_attributes_common(struc
 u32 fuse_get_cache_mask(struct inode *inode)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_inode *fi = get_fuse_inode(inode);
 
 	if (!fc->writeback_cache || !S_ISREG(inode->i_mode))
 		return 0;
 
+	/*
+	 * In writeback_cache_v2 mode if all the following conditions are met,
+	 * then allow the attributes to be refreshed:
+	 *
+	 * - inode is not dirty (I_DIRTY_INODE)
+	 * - inode is not in the process of being written (I_SYNC)
+	 * - inode has no dirty pages (I_DIRTY_PAGES)
+	 * - inode does not have any page writeback in progress
+	 *
+	 * Note: checking PAGECACHE_TAG_WRITEBACK is not sufficient in fuse,
+	 * since inode can appear to have no PageWriteback pages, yet still have
+	 * outstanding write request.
+	 */
+	if (fc->writeback_cache_v2 && !(inode->i_state & (I_DIRTY | I_SYNC)) &&
+	    RB_EMPTY_ROOT(&fi->writepages))
+		return 0;
+
 	return STATX_MTIME | STATX_CTIME | STATX_SIZE;
 }
 
-void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
-			    u64 attr_valid, u64 attr_version)
+void fuse_change_attributes_mask(struct inode *inode, struct fuse_attr *attr,
+				 u64 attr_valid, u64 attr_version,
+				 u32 cache_mask)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct fuse_inode *fi = get_fuse_inode(inode);
-	u32 cache_mask;
 	loff_t oldsize;
 	struct timespec64 old_mtime;
 
@@ -244,7 +262,7 @@ void fuse_change_attributes(struct inode
 	 * may update i_size.  In these cases trust the cached value in the
 	 * inode.
 	 */
-	cache_mask = fuse_get_cache_mask(inode);
+	cache_mask |= fuse_get_cache_mask(inode);
 	if (cache_mask & STATX_SIZE)
 		attr->size = i_size_read(inode);
 
@@ -1153,6 +1171,10 @@ static void process_init_reply(struct fu
 				fc->async_dio = 1;
 			if (flags & FUSE_WRITEBACK_CACHE)
 				fc->writeback_cache = 1;
+			if (flags & FUSE_WRITEBACK_CACHE_V2) {
+				fc->writeback_cache = 1;
+				fc->writeback_cache_v2 = 1;
+			}
 			if (flags & FUSE_PARALLEL_DIROPS)
 				fc->parallel_dirops = 1;
 			if (flags & FUSE_HANDLE_KILLPRIV)
@@ -1234,7 +1256,7 @@ void fuse_send_init(struct fuse_mount *f
 		FUSE_ABORT_ERROR | FUSE_MAX_PAGES | FUSE_CACHE_SYMLINKS |
 		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
 		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_INIT_EXT |
-		FUSE_SECURITY_CTX;
+		FUSE_SECURITY_CTX | FUSE_WRITEBACK_CACHE_V2;
 #ifdef CONFIG_FUSE_DAX
 	if (fm->fc->dax)
 		flags |= FUSE_MAP_ALIGNMENT;
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -213,6 +213,7 @@ static int fuse_dentry_revalidate(struct
 		FUSE_ARGS(args);
 		struct fuse_forget_link *forget;
 		u64 attr_version;
+		u32 cache_mask;
 
 		/* For negative dentries, always do a fresh lookup */
 		if (!inode)
@@ -230,6 +231,7 @@ static int fuse_dentry_revalidate(struct
 			goto out;
 
 		attr_version = fuse_get_attr_version(fm->fc);
+		cache_mask = fuse_get_cache_mask(inode);
 
 		parent = dget_parent(entry);
 		fuse_lookup_init(fm->fc, &args, get_node_id(d_inode(parent)),
@@ -259,9 +261,9 @@ static int fuse_dentry_revalidate(struct
 			goto invalid;
 
 		forget_all_cached_acls(inode);
-		fuse_change_attributes(inode, &outarg.attr,
-				       entry_attr_timeout(&outarg),
-				       attr_version);
+		fuse_change_attributes_mask(inode, &outarg.attr,
+					    entry_attr_timeout(&outarg),
+					    attr_version, cache_mask);
 		fuse_change_entry_timeout(entry, &outarg);
 	} else if (inode) {
 		fi = get_fuse_inode(inode);
@@ -836,16 +838,23 @@ static int fuse_symlink(struct user_name
 
 void fuse_flush_time_update(struct inode *inode)
 {
-	int err = sync_inode_metadata(inode, 1);
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	int err;
 
-	mapping_set_error(inode->i_mapping, err);
+	if (!fc->writeback_cache_v2) {
+		err = sync_inode_metadata(inode, 1);
+		mapping_set_error(inode->i_mapping, err);
+	}
 }
 
 static void fuse_update_ctime_in_cache(struct inode *inode)
 {
 	if (!IS_NOCMTIME(inode)) {
+		struct fuse_conn *fc = get_fuse_conn(inode);
+
 		inode->i_ctime = current_time(inode);
-		mark_inode_dirty_sync(inode);
+		if (!fc->writeback_cache_v2)
+			mark_inode_dirty_sync(inode);
 		fuse_flush_time_update(inode);
 	}
 }
@@ -1065,7 +1074,7 @@ static void fuse_fillattr(struct inode *
 }
 
 static int fuse_do_getattr(struct inode *inode, struct kstat *stat,
-			   struct file *file)
+			   struct file *file, u32 cache_mask)
 {
 	int err;
 	struct fuse_getattr_in inarg;
@@ -1100,9 +1109,9 @@ static int fuse_do_getattr(struct inode
 			fuse_make_bad(inode);
 			err = -EIO;
 		} else {
-			fuse_change_attributes(inode, &outarg.attr,
-					       attr_timeout(&outarg),
-					       attr_version);
+			fuse_change_attributes_mask(inode, &outarg.attr,
+						    attr_timeout(&outarg),
+						    attr_version, cache_mask);
 			if (stat)
 				fuse_fillattr(inode, &outarg.attr, stat);
 		}
@@ -1131,7 +1140,7 @@ static int fuse_update_get_attr(struct i
 
 	if (sync) {
 		forget_all_cached_acls(inode);
-		err = fuse_do_getattr(inode, stat, file);
+		err = fuse_do_getattr(inode, stat, file, cache_mask);
 	} else if (stat) {
 		generic_fillattr(&init_user_ns, inode, stat);
 		stat->mode = fi->orig_i_mode;
@@ -1277,7 +1286,7 @@ static int fuse_perm_getattr(struct inod
 		return -ECHILD;
 
 	forget_all_cached_acls(inode);
-	return fuse_do_getattr(inode, NULL, NULL);
+	return fuse_do_getattr(inode, NULL, NULL, 0);
 }
 
 /*
@@ -1833,7 +1842,7 @@ static int fuse_setattr(struct user_name
 			 * ia_mode calculation may have used stale i_mode.
 			 * Refresh and recalculate.
 			 */
-			ret = fuse_do_getattr(inode, NULL, file);
+			ret = fuse_do_getattr(inode, NULL, file, 0);
 			if (ret)
 				return ret;
 
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2949,6 +2949,19 @@ static int fuse_writeback_range(struct i
 	return err;
 }
 
+static void fuse_update_time(struct file *file)
+{
+	struct inode *inode = file_inode(file);
+	struct fuse_conn *fc = get_fuse_conn(inode);
+
+	if (!IS_NOCMTIME(inode)) {
+		if (fc->writeback_cache_v2)
+			inode->i_mtime = inode->i_ctime = current_time(inode);
+		else
+			file_update_time(file);
+	}
+}
+
 static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 				loff_t length)
 {
@@ -3021,7 +3034,7 @@ static long fuse_file_fallocate(struct f
 	/* we could have extended the file */
 	if (!(mode & FALLOC_FL_KEEP_SIZE)) {
 		if (fuse_write_update_attr(inode, offset + length, length))
-			file_update_time(file);
+			fuse_update_time(file);
 	}
 
 	if (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE))
@@ -3135,7 +3148,7 @@ static ssize_t __fuse_copy_file_range(st
 				   ALIGN_DOWN(pos_out, PAGE_SIZE),
 				   ALIGN(pos_out + outarg.size, PAGE_SIZE) - 1);
 
-	file_update_time(file_out);
+	fuse_update_time(file_out);
 	fuse_write_update_attr(inode_out, pos_out + outarg.size, outarg.size);
 
 	err = outarg.size;
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -654,6 +654,9 @@ struct fuse_conn {
 	/* show legacy mount options */
 	unsigned int legacy_opts_show:1;
 
+	/* Improved writeback cache policy */
+	unsigned writeback_cache_v2:1;
+
 	/*
 	 * fs kills suid/sgid/cap on write/chown/trunc. suid is killed on
 	 * write/trunc only if caller did not have CAP_FSETID.  sgid is killed
@@ -1049,8 +1052,17 @@ void fuse_init_symlink(struct inode *ino
 /**
  * Change attributes of an inode
  */
+void fuse_change_attributes_mask(struct inode *inode, struct fuse_attr *attr,
+				 u64 attr_valid, u64 attr_version,
+				 u32 cache_mask);
+
+static inline
 void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
-			    u64 attr_valid, u64 attr_version);
+			    u64 attr_valid, u64 attr_version)
+{
+	return fuse_change_attributes_mask(inode, attr,
+					   attr_valid, attr_version, 0);
+}
 
 void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 				   u64 attr_valid, u32 cache_mask);
