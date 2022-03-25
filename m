Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58524E7425
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Mar 2022 14:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354759AbiCYNYr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 09:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353066AbiCYNYq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 09:24:46 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBB92AD6
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Mar 2022 06:23:09 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id mp6-20020a17090b190600b001c6841b8a52so12311922pjb.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Mar 2022 06:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MNZq/AfhWONv4eEOkjonT8ZwmGpdtjXRFxD+odRrEZo=;
        b=39gXcbAq5rwMR+CcF2LHqR0IiIGoes2ew7pp/r46ULb3X81Po89LxXtqRdTRiZHE0x
         Hu8OSSL3Wbl+YcU2+PjgW9PbpspMP0C4lB80cM/ZX10j9HIwdwVxoeT66xbHELV/CBNn
         T5aL9tbJkFxEL8MpTz3PFJZURWEKuL+H/uDIiBhAGoSqRWHbIt0Zj5kN7DrLUk115sK8
         ibAGm6ldlExV09UAjIr3lHaO1Suc+I+MiVv1lsIIGnS96msdS1imQQAvXvMSR6Fzgt2G
         cVqQQZ1eTrmRZAH8ODTj+JqaoA/Sg5mPWuYjevGO0/oHkEk1Xgg5muo3B29gmP2pdWmi
         zDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MNZq/AfhWONv4eEOkjonT8ZwmGpdtjXRFxD+odRrEZo=;
        b=BlLdce3pA1uxomodqGs+MhZKVtXaOCChu/sHRYaKJV48tMFszaulHm+Kecj4lsx0CF
         4ma/VxdJuYbKNEoEiZfeXosLJWaCXXh+7RTAD/nQBIyqeclX+Q/PlJkBObVlXTZy7l33
         LGaFOhy+0wxgcfwAZHfodYIU1m6/Mb6XO64LmfpfZrbIKflMDxhe4V4mRE+qEWzGunct
         S1Yf8uPSE/drICkP3kgLK9VQFmsSjrTQZIZm88KBTaFfejsCWI8bGQz+C1MdmwoIt9Pb
         ccTiWGW8gpwMio2pPAjqHo/gZKDXN2pIiT50i+MlfBAr7GQyQh+c/kFkgkJlV7PJii1f
         HcjA==
X-Gm-Message-State: AOAM531Gj7lmN4Rc3wmKpmdjh3lfUKIF67jL5yqWIADmiNPCtc44n6om
        ARhk9YoH4A32djEFXXBCKmPajw==
X-Google-Smtp-Source: ABdhPJxfutLJEAI7eUjyGdPgkiJTgVa2cyTDLZcbbDoayxZegFNJeBm3H+zDZwTPA3cVXas/HvPBhw==
X-Received: by 2002:a17:90a:65c9:b0:1bd:5b80:5c39 with SMTP id i9-20020a17090a65c900b001bd5b805c39mr24705569pjs.185.1648214588643;
        Fri, 25 Mar 2022 06:23:08 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id b16-20020a056a000cd000b004fadb6f0290sm6857164pfv.11.2022.03.25.06.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 06:23:07 -0700 (PDT)
From:   Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
To:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, xieyongji@bytedance.com,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Subject: [RFC PATCH] fuse: support cache revalidation in writeback_cache mode
Date:   Fri, 25 Mar 2022 21:21:26 +0800
Message-Id: <20220325132126.61949-1-zhangjiachen.jaycee@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

This RFC patch implements attr cache and data cache revalidation for
fuse writeback_cache mode in kernel. Looking forward to any suggestions
or comments on this feature.

BACKGROUND

FUSE writeback_cache mode significantly improves write performance. However,
the control between performance and consistency among clients is somehow too
coarse-grained. That is, if a file is re-opened without FOPEN_KEEP_CACHE,
all cached pages of the file will be invalidated in fuse_finish_open().
While getting a good consistency among clients by re-opening files, the
unconditional page cache invalidation on file opening may lead to
performance issues.

This patch tries to implement a more relaxed cache invalidation strategy
that behaves like NFS's close-to-open (CTO) consistency [1]. In the NFSv4
CTO consistency implementation, every file in the server is associated with
a counter called change attribute (change_attr) [1]. The change_attr counter
is monotonically increased every time the file is modified. Every client
should also keep the latest change_attr it gets from the server. If a
client finds the change_attr of a file has been changed by another client,
the attr and data cache of that file will be marked as invalid and will be
evicted from kernel later. The CTO consistency also requires flushing all
dirty pages to server on file closing, which is already implemented by FUSE
in fuse_flush().

DESIGN & IMPLEMENTATION

This patch adds change_attr fileds to fuse_entry_out and fuse_open_out, and
fuse_write_out. The change_attr in fuse_entry_out is to initialize the
fi->change_attr. The change_attrs in fuse_open_out and fuse_write_out are
used by cache revalidation and fi->change_attr updating.

If the change_attr kept in kernel fuse_inode is different from the
change_attr returned from server, attr cache and page cache will be
invalidated. As for the implementation, this patch uses fuse_invalidate_attr()
and a newly added fi->wb_attr_cache_valid flag for attr invalidation.
There is also a new FUSE inode state (FUSE_I_CACHE_INVALID) for marking the
page cache of a file as invalid. The page cache marked as invalid will be
invalidated later in a fuse_finish_open() call.

The reason we need 2 change_attrs (pre_change_attr and post_change_attr)
in fuse_write_out is the FUSE_WRITE request itself will increase the server
change_attr, by returning the change_attr before and after server
change_attr increment, kernel can avoid false cache invalidation
caused by self-writings. This is so-called weak-cache-consistency (WCC)
in the NFS world [1].

To avoid false cache invalidation caused by out-of-order FUSE request
replying. This patch also adds change_attrs lists for delayed cache
revalidation. Change_attrs returned from server will be added to the
lists. Later, a single thread workqueue worker will sort the change_attrs
in the revalidation list and revalidate cache based on the sorted
change_attrs. In the implementation of this patch, we use 3 change_attr
lists to avoid contention between the revalidation workqueue thread and
threads that add change_atts to the list. The cache revalidation can
only be delayed in FUSE_WRITE cases, but no later than the file is closed
in fuse_flush. FUSE_OPEN cases will perform cache revalidation immediately.

To enable cache revalidation in FUSE writeback_cache mode, this patch adds
2 new FUSE_INIT flags, FUSE_WB_CTO and FUSE_WB_CTO_WCC. If we only set
FUSE_WB_CTO, kernel will do open revalidation. If FUSE_WB_CTO_WCC is set
with FUSE_WB_CTO, kernel will also perform WCC revalidation with pre and
post change_attrs returned within fuse_write_out.

[1] https://linux.die.net/man/5/nfs

Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>

Thanks,
Jiachen
---
 fs/fuse/dir.c             |   9 +-
 fs/fuse/file.c            | 253 +++++++++++++++++++++++++++++++++++++-
 fs/fuse/fuse_i.h          |  67 +++++++++-
 fs/fuse/inode.c           |  43 +++++--
 fs/fuse/readdir.c         |   2 +-
 include/uapi/linux/fuse.h |  10 +-
 6 files changed, 363 insertions(+), 21 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 656e921f3506..914624579fe6 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -396,7 +396,7 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 
 	*inode = fuse_iget(sb, outarg->nodeid, outarg->generation,
 			   &outarg->attr, entry_attr_timeout(outarg),
-			   attr_version);
+			   attr_version, outarg->change_attr);
 	err = -ENOMEM;
 	if (!*inode) {
 		fuse_queue_forget(fm->fc, forget, outarg->nodeid, 1);
@@ -604,7 +604,8 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	ff->nodeid = outentry.nodeid;
 	ff->open_flags = outopen.open_flags;
 	inode = fuse_iget(dir->i_sb, outentry.nodeid, outentry.generation,
-			  &outentry.attr, entry_attr_timeout(&outentry), 0);
+			  &outentry.attr, entry_attr_timeout(&outentry), 0,
+			  outentry.change_attr);
 	if (!inode) {
 		flags &= ~(O_CREAT | O_EXCL | O_TRUNC);
 		fuse_sync_release(NULL, ff, flags);
@@ -736,7 +737,8 @@ static int create_new_entry(struct fuse_mount *fm, struct fuse_args *args,
 		goto out_put_forget_req;
 
 	inode = fuse_iget(dir->i_sb, outarg.nodeid, outarg.generation,
-			  &outarg.attr, entry_attr_timeout(&outarg), 0);
+			  &outarg.attr, entry_attr_timeout(&outarg), 0,
+			  outarg.change_attr);
 	if (!inode) {
 		fuse_queue_forget(fm->fc, forget, outarg.nodeid, 1);
 		return -ENOMEM;
@@ -859,6 +861,7 @@ static void fuse_entry_unlinked(struct dentry *entry)
 
 	spin_lock(&fi->lock);
 	fi->attr_version = atomic64_inc_return(&fc->attr_version);
+	fi->wb_attr_cache_valid = true;
 	/*
 	 * If i_nlink == 0 then unlink doesn't make sense, yet this can
 	 * happen if userspace filesystem is careless.  It would be
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 0fc150c1c50b..c7c8b84052bb 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -18,6 +18,7 @@
 #include <linux/falloc.h>
 #include <linux/uio.h>
 #include <linux/fs.h>
+#include <linux/list_sort.h>
 
 static int fuse_send_open(struct fuse_mount *fm, u64 nodeid,
 			  unsigned int open_flags, int opcode,
@@ -124,12 +125,70 @@ static void fuse_file_put(struct fuse_file *ff, bool sync, bool isdir)
 	}
 }
 
+static void fuse_revalidation_queue_work(struct fuse_inode *fi, bool drain)
+{
+	struct fuse_conn *fc = get_fuse_conn(&fi->inode);
+
+	if (!fc->reval_wq)
+		return;
+
+	if (drain) {
+		queue_work(fc->reval_wq, &fi->reval_work_drain);
+		flush_work(&fi->reval_work_drain);
+	} else {
+		queue_work(fc->reval_wq, &fi->reval_work);
+	}
+}
+
+static void fuse_add_change_attr(struct fuse_inode *fi,
+			       struct list_head *entry, int from, int to,
+			       bool dispatch, bool queue_work, bool drain)
+{
+	struct timespec64 reval_interval = { 1, 0 };
+
+	spin_lock(&fi->reval_lock);
+	if (entry) {
+		list_add_tail(entry, &fi->wcc_attrs[from]);
+		fi->wcc_attrs_ctr[from]++;
+	}
+
+	if (dispatch) {
+		list_splice_tail_init(&fi->wcc_attrs[from], &fi->wcc_attrs[to]);
+		fi->wcc_attrs_ctr[to] += fi->wcc_attrs_ctr[from];
+		fi->wcc_attrs_ctr[from] = 0;
+	}
+
+	if (queue_work) {
+		fi->next_reval_time = get_jiffies_64()
+				      + timespec64_to_jiffies(&reval_interval);
+		spin_unlock(&fi->reval_lock);
+		fuse_revalidation_queue_work(fi, drain);
+	} else {
+		spin_unlock(&fi->reval_lock);
+	}
+}
+
+static void fuse_open_revalidate(struct inode *inode, u64 change_attr)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_wcc_attr *fwa = kzalloc(sizeof(*fwa), GFP_NOFS);
+
+	/* Fake up a pre_change_attr */
+	fwa->pre_change_attr = change_attr;
+	fwa->post_change_attr = change_attr;
+
+	fuse_add_change_attr(fi, &fwa->entry, FUSE_WCC_LIST_RECEIVING,
+			   FUSE_WCC_LIST_PENDING, true, true, true);
+}
+
 struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
-				 unsigned int open_flags, bool isdir)
+				 struct file *file, bool isdir)
 {
 	struct fuse_conn *fc = fm->fc;
 	struct fuse_file *ff;
 	int opcode = isdir ? FUSE_OPENDIR : FUSE_OPEN;
+	unsigned int open_flags = file->f_flags;
+	struct inode *inode = file_inode(file);
 
 	ff = fuse_file_alloc(fm);
 	if (!ff)
@@ -147,6 +206,8 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 			ff->fh = outarg.fh;
 			ff->open_flags = outarg.open_flags;
 
+			if (fc->wb_cto)
+				fuse_open_revalidate(inode, outarg.change_attr);
 		} else if (err != -ENOSYS) {
 			fuse_file_free(ff);
 			return ERR_PTR(err);
@@ -169,7 +230,7 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 int fuse_do_open(struct fuse_mount *fm, u64 nodeid, struct file *file,
 		 bool isdir)
 {
-	struct fuse_file *ff = fuse_file_open(fm, nodeid, file->f_flags, isdir);
+	struct fuse_file *ff = fuse_file_open(fm, nodeid, file, isdir);
 
 	if (!IS_ERR(ff))
 		file->private_data = ff;
@@ -197,6 +258,7 @@ void fuse_finish_open(struct inode *inode, struct file *file)
 {
 	struct fuse_file *ff = file->private_data;
 	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_inode *fi = get_fuse_inode(inode);
 
 	if (ff->open_flags & FOPEN_STREAM)
 		stream_open(inode, file);
@@ -204,16 +266,16 @@ void fuse_finish_open(struct inode *inode, struct file *file)
 		nonseekable_open(inode, file);
 
 	if (fc->atomic_o_trunc && (file->f_flags & O_TRUNC)) {
-		struct fuse_inode *fi = get_fuse_inode(inode);
-
 		spin_lock(&fi->lock);
 		fi->attr_version = atomic64_inc_return(&fc->attr_version);
+		fi->wb_attr_cache_valid = true;
 		i_size_write(inode, 0);
 		spin_unlock(&fi->lock);
 		truncate_pagecache(inode, 0);
 		file_update_time(file);
 		fuse_invalidate_attr_mask(inode, FUSE_STATX_MODSIZE);
-	} else if (!(ff->open_flags & FOPEN_KEEP_CACHE)) {
+	} else if (test_and_clear_bit(FUSE_I_CACHE_INVALID, &fi->state) ||
+		   (!fc->wb_cto && !(ff->open_flags & FOPEN_KEEP_CACHE))) {
 		invalidate_inode_pages2(inode->i_mapping);
 	}
 
@@ -464,10 +526,139 @@ static void fuse_sync_writes(struct inode *inode)
 	fuse_release_nowrite(inode);
 }
 
+void fuse_update_change_attr(struct inode *inode, u64 change_attr)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	fi->change_attr = change_attr;
+}
+
+static void fuse_update_change_attr_wcc(struct inode *inode,
+					 u64 pre_change_attr,
+					 u64 post_change_attr)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	if (fi->change_attr == pre_change_attr)
+		fuse_update_change_attr(inode, post_change_attr);
+}
+
+static int compare_change_attr(void *priv, const struct list_head *a,
+			       const struct list_head *b)
+{
+	struct fuse_wcc_attr *fwa1;
+	struct fuse_wcc_attr *fwa2;
+
+	fwa1 = container_of(a, struct fuse_wcc_attr, entry);
+	fwa2 = container_of(b, struct fuse_wcc_attr, entry);
+	if (fwa1->pre_change_attr < fwa2->pre_change_attr)
+		return -1;
+	else if (fwa1->pre_change_attr > fwa2->pre_change_attr)
+		return 1;
+	else
+		return 0;
+}
+
+static void fuse_revalidate_cache(struct inode *inode, u64 change_attr)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	/* Mark attr and data cache as invalid if change_attr is changed. */
+	if (fi->change_attr != change_attr) {
+		fuse_invalidate_attr(inode);
+		fi->wb_attr_cache_valid = false;
+		set_bit(FUSE_I_CACHE_INVALID, &fi->state);
+	}
+}
+
+static void fuse_do_revalidation(struct inode *inode, bool drain)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_wcc_attr *fwa1, *fwa2, *fwa_last;
+	int n_reval, remain;
+	struct list_head *reval_list;
+
+	fuse_add_change_attr(fi, NULL, FUSE_WCC_LIST_PENDING,
+			   FUSE_WCC_LIST_REVALIDATING, true, false, false);
+
+	reval_list = &fi->wcc_attrs[FUSE_WCC_LIST_REVALIDATING];
+
+	/*
+	 * The reason we keep wcc attrs in a list is to sort them here,
+	 * we can reduce false negative data cache invalidations this
+	 * way.
+	 */
+	list_sort(NULL, reval_list, compare_change_attr);
+
+	if (drain)
+		n_reval = fi->wcc_attrs_ctr[FUSE_WCC_LIST_REVALIDATING];
+	else
+		n_reval = fi->wcc_attrs_ctr[FUSE_WCC_LIST_REVALIDATING] / 2;
+
+	if (n_reval == 0)
+		return;
+
+	remain = n_reval;
+	list_for_each_entry(fwa2, reval_list, entry) {
+		if (remain == n_reval)
+			fwa1 = NULL;
+		else
+			fwa1 = list_prev_entry(fwa2, entry);
+
+		if (--remain == 0) {
+			if (fwa1)
+				fuse_update_change_attr(inode, fwa1->post_change_attr);
+			goto revalidate;
+		}
+
+		if (fwa1 && (fwa1->post_change_attr != fwa2->pre_change_attr)) {
+			set_bit(FUSE_I_CACHE_INVALID, &fi->state);
+			fwa_last = list_last_entry(reval_list,
+					struct fuse_wcc_attr, entry);
+			fuse_update_change_attr(inode, fwa_last->post_change_attr);
+			n_reval = fi->wcc_attrs_ctr[FUSE_WCC_LIST_REVALIDATING];
+			goto out;
+		}
+	}
+
+revalidate:
+	fuse_update_change_attr_wcc(inode, fwa2->pre_change_attr,
+				     fwa2->post_change_attr);
+	fuse_revalidate_cache(inode, fwa2->post_change_attr);
+	fuse_update_change_attr(inode, fwa2->post_change_attr);
+out:
+	remain = n_reval;
+
+	list_for_each_entry_safe(fwa1, fwa2, reval_list, entry) {
+		if (remain-- == 0)
+			break;
+		list_del(&fwa1->entry);
+		kfree(fwa1);
+	}
+	fi->wcc_attrs_ctr[FUSE_WCC_LIST_REVALIDATING] -= n_reval;
+}
+
+static void fuse_revalidation_work(struct work_struct *work)
+{
+	struct fuse_inode *fi = container_of(work, struct fuse_inode,
+					     reval_work);
+
+	fuse_do_revalidation(&fi->inode, false);
+}
+
+static void fuse_revalidation_work_drain(struct work_struct *work)
+{
+	struct fuse_inode *fi = container_of(work, struct fuse_inode,
+					     reval_work_drain);
+
+	fuse_do_revalidation(&fi->inode, true);
+}
+
 static int fuse_flush(struct file *file, fl_owner_t id)
 {
 	struct inode *inode = file_inode(file);
 	struct fuse_mount *fm = get_fuse_mount(inode);
+	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_file *ff = file->private_data;
 	struct fuse_flush_in inarg;
 	FUSE_ARGS(args);
@@ -487,6 +678,10 @@ static int fuse_flush(struct file *file, fl_owner_t id)
 	fuse_sync_writes(inode);
 	inode_unlock(inode);
 
+	if (fm->fc->wb_cto)
+		fuse_add_change_attr(fi, NULL, FUSE_WCC_LIST_RECEIVING,
+				   FUSE_WCC_LIST_PENDING, true, true, true);
+
 	err = filemap_check_errors(file->f_mapping);
 	if (err)
 		return err;
@@ -680,6 +875,7 @@ static void fuse_aio_complete(struct fuse_io_priv *io, int err, ssize_t pos)
 
 			spin_lock(&fi->lock);
 			fi->attr_version = atomic64_inc_return(&fc->attr_version);
+			fi->wb_attr_cache_valid = true;
 			spin_unlock(&fi->lock);
 		}
 
@@ -792,6 +988,7 @@ static void fuse_read_update_size(struct inode *inode, loff_t size,
 	if (attr_ver >= fi->attr_version && size < inode->i_size &&
 	    !test_bit(FUSE_I_SIZE_UNSTABLE, &fi->state)) {
 		fi->attr_version = atomic64_inc_return(&fc->attr_version);
+		fi->wb_attr_cache_valid = true;
 		i_size_write(inode, size);
 	}
 	spin_unlock(&fi->lock);
@@ -1076,6 +1273,7 @@ bool fuse_write_update_attr(struct inode *inode, loff_t pos, ssize_t written)
 
 	spin_lock(&fi->lock);
 	fi->attr_version = atomic64_inc_return(&fc->attr_version);
+	fi->wb_attr_cache_valid = true;
 	if (written > 0 && pos > inode->i_size) {
 		i_size_write(inode, pos);
 		ret = true;
@@ -1748,6 +1946,22 @@ static struct fuse_writepage_args *fuse_insert_writeback(struct rb_root *root,
 	return NULL;
 }
 
+static void fuse_wcc_revalidate(struct inode *inode,
+				      u64 pre_change_attr,
+				      u64 post_change_attr)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_wcc_attr *fwa = kzalloc(sizeof(*fwa), GFP_NOFS);
+	bool is_timeout = time_before64(fi->next_reval_time, get_jiffies_64());
+
+	fwa->pre_change_attr = pre_change_attr;
+	fwa->post_change_attr = post_change_attr;
+
+	fuse_add_change_attr(fi, &fwa->entry, FUSE_WCC_LIST_RECEIVING,
+			     FUSE_WCC_LIST_PENDING,
+			     is_timeout, is_timeout, false);
+}
+
 static void tree_insert(struct rb_root *root, struct fuse_writepage_args *wpa)
 {
 	WARN_ON(fuse_insert_writeback(root, wpa));
@@ -1762,6 +1976,11 @@ static void fuse_writepage_end(struct fuse_mount *fm, struct fuse_args *args,
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_conn *fc = get_fuse_conn(inode);
 
+	if (fc->wb_cto_wcc)
+		fuse_wcc_revalidate(inode,
+				    wpa->ia.write.out.pre_change_attr,
+				    wpa->ia.write.out.post_change_attr);
+
 	mapping_set_error(inode->i_mapping, error);
 	/*
 	 * A writeback finished and this might have updated mtime/ctime on
@@ -1838,6 +2057,7 @@ static struct fuse_file *fuse_write_file_get(struct fuse_inode *fi)
 int fuse_write_inode(struct inode *inode, struct writeback_control *wbc)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_mount *fm = get_fuse_mount(inode);
 	struct fuse_file *ff;
 	int err;
 
@@ -1852,6 +2072,10 @@ int fuse_write_inode(struct inode *inode, struct writeback_control *wbc)
 	 */
 	WARN_ON(wbc->for_reclaim);
 
+	/* In the case of CTO consistency, server updates cmtime by itself. */
+	if (fm->fc->wb_cto)
+		return 0;
+
 	ff = __fuse_write_file_get(fi);
 	err = fuse_flush_times(inode, ff);
 	if (ff)
@@ -3186,3 +3410,22 @@ void fuse_init_file_inode(struct inode *inode, unsigned int flags)
 	if (IS_ENABLED(CONFIG_FUSE_DAX))
 		fuse_dax_inode_init(inode, flags);
 }
+
+void fuse_init_cto(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	int i;
+	struct timespec64 reval_interval = { 1, 0 };
+
+	fi->wb_attr_cache_valid = true;
+	for (i = 0; i < FUSE_WCC_LIST_NUM; i++) {
+		fi->wcc_attrs_ctr[i] = 0;
+		INIT_LIST_HEAD(&fi->wcc_attrs[i]);
+	}
+	spin_lock_init(&fi->reval_lock);
+	fi->next_reval_time = get_jiffies_64()
+			      + timespec64_to_jiffies(&reval_interval);
+
+	INIT_WORK(&fi->reval_work, fuse_revalidation_work);
+	INIT_WORK(&fi->reval_work_drain, fuse_revalidation_work_drain);
+}
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index eac4984cc753..1093287475b4 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -63,6 +63,24 @@ struct fuse_forget_link {
 	struct fuse_forget_link *next;
 };
 
+/** List node for cache revalidation in writeback mode */
+struct fuse_wcc_attr {
+	struct list_head entry;
+	uint64_t pre_change_attr;
+	uint64_t post_change_attr;
+};
+
+/**
+ * List types for delayed cache revalidation, in case of out-of-order
+ * change_attr arriving.
+ */
+enum fuse_wcc_attr_list_types {
+	FUSE_WCC_LIST_RECEIVING,
+	FUSE_WCC_LIST_PENDING,
+	FUSE_WCC_LIST_REVALIDATING,
+	FUSE_WCC_LIST_NUM
+};
+
 /** FUSE inode */
 struct fuse_inode {
 	/** Inode data */
@@ -155,6 +173,33 @@ struct fuse_inode {
 	 */
 	struct fuse_inode_dax *dax;
 #endif
+	/**
+	 * Counter returned from server, used for cache revalidation in
+	 * writeback mode.
+	 */
+	u64 change_attr;
+
+	/**
+	 * Whether local cmtime and size cache are still valid in writeback
+	 * mode.
+	 */
+	bool wb_attr_cache_valid;
+
+	/**
+	 * In case of out-of-order write request replies, delay WCC cache
+	 * revalidation by storing change_attrs in a list on receiving them.
+	 * In the per-second revalidation workqueue worker function, the
+	 * change_attrs will be sorted according to pre_change_attr before
+	 * they are used for cache revalidateion.
+	 */
+	struct list_head wcc_attrs[FUSE_WCC_LIST_NUM];
+	u64 wcc_attrs_ctr[FUSE_WCC_LIST_NUM];
+	u64 next_reval_time;
+	struct work_struct reval_work;
+	struct work_struct reval_work_drain;
+
+	/** Lock to protect cache revalidation lists */
+	spinlock_t reval_lock;
 };
 
 /** FUSE inode state bits */
@@ -167,6 +212,8 @@ enum {
 	FUSE_I_SIZE_UNSTABLE,
 	/* Bad inode */
 	FUSE_I_BAD,
+	/* Data cache is invalid in writeback mode */
+	FUSE_I_CACHE_INVALID,
 };
 
 struct fuse_conn;
@@ -642,6 +689,12 @@ struct fuse_conn {
 	/** write-back cache policy (default is write-through) */
 	unsigned writeback_cache:1;
 
+	/** Enable close-to-open (CTO) consistency in write-back mode */
+	unsigned wb_cto:1;
+
+	/** Enable CTO weak cache consistency (WCC) revalidation */
+	unsigned wb_cto_wcc:1;
+
 	/** allow parallel lookups and readdir (default is serialized) */
 	unsigned parallel_dirops:1;
 
@@ -833,6 +886,9 @@ struct fuse_conn {
 
 	/* New writepages go into this bucket */
 	struct fuse_sync_bucket __rcu *curr_bucket;
+
+	/** Workqueue for writeback cache revalidateion (CTO consistency). */
+	struct workqueue_struct *reval_wq;
 };
 
 /*
@@ -956,7 +1012,7 @@ extern const struct dentry_operations fuse_root_dentry_operations;
  */
 struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 			int generation, struct fuse_attr *attr,
-			u64 attr_valid, u64 attr_version);
+			u64 attr_valid, u64 attr_version, u64 change_attr);
 
 int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name,
 		     struct fuse_entry_out *outarg, struct inode **inode);
@@ -1046,6 +1102,11 @@ void fuse_init_dir(struct inode *inode);
  */
 void fuse_init_symlink(struct inode *inode);
 
+/**
+ * Initialize close-to-open related structures
+ */
+void fuse_init_cto(struct inode *inode);
+
 /**
  * Change attributes of an inode
  */
@@ -1185,6 +1246,8 @@ void fuse_update_ctime(struct inode *inode);
 
 int fuse_update_attributes(struct inode *inode, struct file *file, u32 mask);
 
+void fuse_update_change_attr(struct inode *inode, u64 change_attr);
+
 void fuse_flush_writepages(struct inode *inode);
 
 void fuse_set_nowrite(struct inode *inode);
@@ -1312,7 +1375,7 @@ int fuse_fileattr_set(struct user_namespace *mnt_userns,
 /* file.c */
 
 struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
-				 unsigned int open_flags, bool isdir);
+				 struct file *file, bool isdir);
 void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 		       unsigned int open_flags, fl_owner_t id, bool isdir);
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 9ee36aa73251..a1ddf9ae17ba 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -222,8 +222,10 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 u32 fuse_get_cache_mask(struct inode *inode)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_inode *fi = get_fuse_inode(inode);
 
-	if (!fc->writeback_cache || !S_ISREG(inode->i_mode))
+	if (!fc->writeback_cache || !S_ISREG(inode->i_mode) ||
+	    !fi->wb_attr_cache_valid)
 		return 0;
 
 	return STATX_MTIME | STATX_CTIME | STATX_SIZE;
@@ -297,7 +299,7 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 				inval = true;
 		}
 
-		if (inval)
+		if (inval && !test_bit(FUSE_I_CACHE_INVALID, &fi->state))
 			invalidate_inode_pages2(inode->i_mapping);
 	}
 
@@ -307,6 +309,8 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 
 static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr)
 {
+	struct fuse_conn *fc = get_fuse_conn(inode);
+
 	inode->i_mode = attr->mode & S_IFMT;
 	inode->i_size = attr->size;
 	inode->i_mtime.tv_sec  = attr->mtime;
@@ -327,6 +331,9 @@ static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr)
 				   new_decode_dev(attr->rdev));
 	} else
 		BUG();
+
+	if (fc->wb_cto && (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode)))
+		fuse_init_cto(inode);
 }
 
 static int fuse_inode_eq(struct inode *inode, void *_nodeidp)
@@ -347,7 +354,7 @@ static int fuse_inode_set(struct inode *inode, void *_nodeidp)
 
 struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 			int generation, struct fuse_attr *attr,
-			u64 attr_valid, u64 attr_version)
+			u64 attr_valid, u64 attr_version, u64 change_attr)
 {
 	struct inode *inode;
 	struct fuse_inode *fi;
@@ -367,7 +374,9 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 			return NULL;
 
 		fuse_init_inode(inode, attr);
-		get_fuse_inode(inode)->nodeid = nodeid;
+		fuse_update_change_attr(inode, change_attr);
+		fi = get_fuse_inode(inode);
+		fi->nodeid = nodeid;
 		inode->i_flags |= S_AUTOMOUNT;
 		goto done;
 	}
@@ -377,12 +386,14 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 	if (!inode)
 		return NULL;
 
+	fi = get_fuse_inode(inode);
 	if ((inode->i_state & I_NEW)) {
 		inode->i_flags |= S_NOATIME;
 		if (!fc->writeback_cache || !S_ISREG(attr->mode))
 			inode->i_flags |= S_NOCMTIME;
 		inode->i_generation = generation;
 		fuse_init_inode(inode, attr);
+		fuse_update_change_attr(inode, change_attr);
 		unlock_new_inode(inode);
 	} else if (fuse_stale_inode(inode, generation, attr)) {
 		/* nodeid was reused, any I/O on the old inode should fail */
@@ -390,8 +401,8 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 		iput(inode);
 		goto retry;
 	}
+
 done:
-	fi = get_fuse_inode(inode);
 	spin_lock(&fi->lock);
 	fi->nlookup++;
 	spin_unlock(&fi->lock);
@@ -437,6 +448,7 @@ int fuse_reverse_inval_inode(struct fuse_conn *fc, u64 nodeid,
 	fi = get_fuse_inode(inode);
 	spin_lock(&fi->lock);
 	fi->attr_version = atomic64_inc_return(&fc->attr_version);
+	fi->wb_attr_cache_valid = true;
 	spin_unlock(&fi->lock);
 
 	fuse_invalidate_attr(inode);
@@ -839,6 +851,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	INIT_LIST_HEAD(&fc->mounts);
 	list_add(&fm->fc_entry, &fc->mounts);
 	fm->fc = fc;
+	fc->wb_cto = 0;
 }
 EXPORT_SYMBOL_GPL(fuse_conn_init);
 
@@ -879,7 +892,7 @@ static struct inode *fuse_get_root_inode(struct super_block *sb, unsigned mode)
 	attr.mode = mode;
 	attr.ino = FUSE_ROOT_ID;
 	attr.nlink = 1;
-	return fuse_iget(sb, 1, 0, &attr, 0, 0);
+	return fuse_iget(sb, 1, 0, &attr, 0, 0, 0);
 }
 
 struct fuse_inode_handle {
@@ -1151,8 +1164,18 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 			}
 			if (flags & FUSE_ASYNC_DIO)
 				fc->async_dio = 1;
-			if (flags & FUSE_WRITEBACK_CACHE)
+			if (flags & FUSE_WRITEBACK_CACHE) {
 				fc->writeback_cache = 1;
+				if (arg->flags & FUSE_WB_CTO) {
+					fc->wb_cto = 1;
+					if (arg->flags & FUSE_WB_CTO_WCC)
+						fc->wb_cto_wcc = 1;
+					fuse_init_cto(fm->sb->s_root->d_inode);
+				}
+				fc->reval_wq = create_singlethread_workqueue("fuse-reval-wq");
+				if (!fc->reval_wq)
+					pr_warn("Failed to allocate fuse revalidateion workqueue!\n");
+			}
 			if (flags & FUSE_PARALLEL_DIROPS)
 				fc->parallel_dirops = 1;
 			if (flags & FUSE_HANDLE_KILLPRIV)
@@ -1234,7 +1257,7 @@ void fuse_send_init(struct fuse_mount *fm)
 		FUSE_ABORT_ERROR | FUSE_MAX_PAGES | FUSE_CACHE_SYMLINKS |
 		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
 		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_INIT_EXT |
-		FUSE_SECURITY_CTX;
+		FUSE_SECURITY_CTX | FUSE_WB_CTO | FUSE_WB_CTO_WCC;
 #ifdef CONFIG_FUSE_DAX
 	if (fm->fc->dax)
 		flags |= FUSE_MAP_ALIGNMENT;
@@ -1440,7 +1463,7 @@ static int fuse_fill_super_submount(struct super_block *sb,
 		return -ENOMEM;
 
 	fuse_fill_attr_from_inode(&root_attr, parent_fi);
-	root = fuse_iget(sb, parent_fi->nodeid, 0, &root_attr, 0, 0);
+	root = fuse_iget(sb, parent_fi->nodeid, 0, &root_attr, 0, 0, parent_fi->change_attr);
 	/*
 	 * This inode is just a duplicate, so it is not looked up and
 	 * its nlookup should not be incremented.  fuse_iget() does
@@ -1773,6 +1796,8 @@ void fuse_conn_destroy(struct fuse_mount *fm)
 		list_del(&fc->entry);
 		fuse_ctl_remove_conn(fc);
 		mutex_unlock(&fuse_mutex);
+		if (fc->reval_wq)
+			destroy_workqueue(fc->reval_wq);
 	}
 }
 EXPORT_SYMBOL_GPL(fuse_conn_destroy);
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index b4e565711045..bfd7d6ec3097 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -231,7 +231,7 @@ static int fuse_direntplus_link(struct file *file,
 	} else {
 		inode = fuse_iget(dir->i_sb, o->nodeid, o->generation,
 				  &o->attr, entry_attr_timeout(o),
-				  attr_version);
+				  attr_version, o->change_attr);
 		if (!inode)
 			inode = ERR_PTR(-ENOMEM);
 
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index d6ccee961891..bd12eda29871 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -194,6 +194,8 @@
  *  - add FUSE_SECURITY_CTX init flag
  *  - add security context to create, mkdir, symlink, and mknod requests
  *  - add FUSE_HAS_INODE_DAX, FUSE_ATTR_DAX
+ *  7.37
+ *  - add attr to fuse_open_out and fuse_write_out
  */
 
 #ifndef _LINUX_FUSE_H
@@ -229,7 +231,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 36
+#define FUSE_KERNEL_MINOR_VERSION 37
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -389,6 +391,8 @@ struct fuse_file_lock {
 /* bits 32..63 get shifted down 32 bits into the flags2 field */
 #define FUSE_SECURITY_CTX	(1ULL << 32)
 #define FUSE_HAS_INODE_DAX	(1ULL << 33)
+#define FUSE_WB_CTO		(1ULL << 34)
+#define FUSE_WB_CTO_WCC		(1ULL << 35)
 
 /**
  * CUSE INIT request/reply flags
@@ -570,6 +574,7 @@ struct fuse_entry_out {
 	uint32_t	entry_valid_nsec;
 	uint32_t	attr_valid_nsec;
 	struct fuse_attr attr;
+	uint64_t	change_attr;
 };
 
 struct fuse_forget_in {
@@ -664,6 +669,7 @@ struct fuse_open_out {
 	uint64_t	fh;
 	uint32_t	open_flags;
 	uint32_t	padding;
+	uint64_t	change_attr;
 };
 
 struct fuse_release_in {
@@ -705,6 +711,8 @@ struct fuse_write_in {
 struct fuse_write_out {
 	uint32_t	size;
 	uint32_t	padding;
+	uint64_t	pre_change_attr;
+	uint64_t	post_change_attr;
 };
 
 #define FUSE_COMPAT_STATFS_SIZE 48
-- 
2.20.1

