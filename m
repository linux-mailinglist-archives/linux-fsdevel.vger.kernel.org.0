Return-Path: <linux-fsdevel+bounces-43975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD2FA605DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 00:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D95903AF2B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 23:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBF620B208;
	Thu, 13 Mar 2025 23:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cuuu3THA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344E2206F0E
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 23:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741908934; cv=none; b=N2kiDLx6fSaflSE3Q/RAgGPH61uF8/uXDNBHkQ7h8nvsl4LY+yEteCJ0YBJK9W97/z0AhH0Z9Rm+QWl1hQ2AHcQmjgNubTU/B5bN0LHPkoMGSktWhJ6olmQdqCVXC6Dd9vYFId6InD7np4hxZXtO+FpQMXGWnoZ3SeEwMJ9X2tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741908934; c=relaxed/simple;
	bh=ufQudNEzzeiDLcQykRdQgPkD6KuVET09igARrkJdeTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XoOcwN3zfO8HwHVT1a3l8V4hFo5IKTnaNmscM6EIBIeb1FxpjlooAyq39WoMFV8exxaMrcY/+vh0vQ9ENAwherzDDFgV7/kO6Y3EdhS3x+JqVElQHEv7VQYCC8HH9PoZ43/KzXthYWK32ghv5kS+Ct3g9GnNwCzKzfa8KCoJZcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cuuu3THA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741908931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5MrayBHV+6dK7LiAjQhlOclbDaGg8mYI23n6D75wm7Q=;
	b=Cuuu3THAyDIBlXTh0tdzGQC8nF5IBXf4HSnjDD3jilfHEqeZZ/4uzbMs/DYr6fEHGfUUyO
	c5QVIIqrVl4h4WrvK1iS1htwF9rDPgcoPN0k7gercOUSMV9kku2lteVlN3xRU87vcvL472
	z653a0z9qFP3CZllzC3nk5xssqpgYsk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-aWQDqZpaOmOITLt0AqEJnw-1; Thu,
 13 Mar 2025 19:35:28 -0400
X-MC-Unique: aWQDqZpaOmOITLt0AqEJnw-1
X-Mimecast-MFC-AGG-ID: aWQDqZpaOmOITLt0AqEJnw_1741908926
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B32531800259;
	Thu, 13 Mar 2025 23:35:26 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 617181955BCB;
	Thu, 13 Mar 2025 23:35:24 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	Alex Markuze <amarkuze@redhat.com>
Cc: David Howells <dhowells@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Dongsheng Yang <dongsheng.yang@easystack.cn>,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 26/35] ceph: Kill ceph_rw_context
Date: Thu, 13 Mar 2025 23:33:18 +0000
Message-ID: <20250313233341.1675324-27-dhowells@redhat.com>
In-Reply-To: <20250313233341.1675324-1-dhowells@redhat.com>
References: <20250313233341.1675324-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

With all invokers of readahead:

	- read() and co.
	- splice()
	- fadvise(POSIX_FADV_WILLNEED)
	- madvise(MADV_WILLNEED)
	- fault-in

now getting the FILE_CACHE cap or the LAZYIO cap and holding it across
readahead invocation, there's no need for the ceph_rw_context.  It can be
assumed that we have one or other cap - and apparently it doesn't matter
which as we don't actually check rw_ctx->caps.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/ceph/addr.c  | 19 +++++++------------
 fs/ceph/file.c  | 13 +------------
 fs/ceph/super.h | 47 -----------------------------------------------
 3 files changed, 8 insertions(+), 71 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 7c89cafcb91a..27f27ab24446 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -473,18 +473,16 @@ static int ceph_init_request(struct netfs_io_request *rreq, struct file *file)
 	if (!priv)
 		return -ENOMEM;
 
+	/*
+	 * If we are doing readahead triggered by a read, fault-in or
+	 * MADV/FADV_WILLNEED, someone higher up the stack must be holding the
+	 * FILE_CACHE and/or LAZYIO caps.
+	 */
 	if (file) {
-		struct ceph_rw_context *rw_ctx;
-		struct ceph_file_info *fi = file->private_data;
-
 		priv->file_ra_pages = file->f_ra.ra_pages;
 		priv->file_ra_disabled = file->f_mode & FMODE_RANDOM;
-
-		rw_ctx = ceph_find_rw_context(fi);
-		if (rw_ctx) {
-			rreq->netfs_priv = priv;
-			return 0;
-		}
+		rreq->netfs_priv = priv;
+		return 0;
 	}
 
 	/*
@@ -1982,10 +1980,7 @@ static vm_fault_t ceph_filemap_fault(struct vm_fault *vmf)
 
 	if ((got & (CEPH_CAP_FILE_CACHE | CEPH_CAP_FILE_LAZYIO)) ||
 	    !ceph_has_inline_data(ci)) {
-		CEPH_DEFINE_RW_CONTEXT(rw_ctx, got);
-		ceph_add_rw_context(fi, &rw_ctx);
 		ret = filemap_fault(vmf);
-		ceph_del_rw_context(fi, &rw_ctx);
 		doutc(cl, "%llx.%llx %llu drop cap refs %s ret %x\n",
 		      ceph_vinop(inode), off, ceph_cap_string(got), ret);
 	} else
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index b876cecbaba5..4512215cccc6 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -229,8 +229,6 @@ static int ceph_init_file_info(struct inode *inode, struct file *file,
 	ceph_get_fmode(ci, fmode, 1);
 	fi->fmode = fmode;
 
-	spin_lock_init(&fi->rw_contexts_lock);
-	INIT_LIST_HEAD(&fi->rw_contexts);
 	fi->filp_gen = READ_ONCE(ceph_inode_to_fs_client(inode)->filp_gen);
 
 	if ((file->f_mode & FMODE_WRITE) && ceph_has_inline_data(ci)) {
@@ -999,7 +997,6 @@ int ceph_release(struct inode *inode, struct file *file)
 		struct ceph_dir_file_info *dfi = file->private_data;
 		doutc(cl, "%p %llx.%llx dir file %p\n", inode,
 		      ceph_vinop(inode), file);
-		WARN_ON(!list_empty(&dfi->file_info.rw_contexts));
 
 		ceph_put_fmode(ci, dfi->file_info.fmode, 1);
 
@@ -1012,7 +1009,6 @@ int ceph_release(struct inode *inode, struct file *file)
 		struct ceph_file_info *fi = file->private_data;
 		doutc(cl, "%p %llx.%llx regular file %p\n", inode,
 		      ceph_vinop(inode), file);
-		WARN_ON(!list_empty(&fi->rw_contexts));
 
 		ceph_fscache_unuse_cookie(inode, file->f_mode & FMODE_WRITE);
 		ceph_put_fmode(ci, fi->fmode, 1);
@@ -2154,13 +2150,10 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			retry_op = READ_INLINE;
 		}
 	} else {
-		CEPH_DEFINE_RW_CONTEXT(rw_ctx, got);
 		doutc(cl, "async %p %llx.%llx %llu~%u got cap refs on %s\n",
 		      inode, ceph_vinop(inode), iocb->ki_pos, (unsigned)len,
 		      ceph_cap_string(got));
-		ceph_add_rw_context(fi, &rw_ctx);
 		ret = generic_file_read_iter(iocb, to);
-		ceph_del_rw_context(fi, &rw_ctx);
 	}
 
 	doutc(cl, "%p %llx.%llx dropping cap refs on %s = %d\n",
@@ -2256,7 +2249,6 @@ static ssize_t ceph_splice_read(struct file *in, loff_t *ppos,
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	ssize_t ret;
 	int want = 0, got = 0;
-	CEPH_DEFINE_RW_CONTEXT(rw_ctx, 0);
 
 	dout("splice_read %p %llx.%llx %llu~%zu trying to get caps on %p\n",
 	     inode, ceph_vinop(inode), *ppos, len, inode);
@@ -2291,10 +2283,7 @@ static ssize_t ceph_splice_read(struct file *in, loff_t *ppos,
 	dout("splice_read %p %llx.%llx %llu~%zu got cap refs on %s\n",
 	     inode, ceph_vinop(inode), *ppos, len, ceph_cap_string(got));
 
-	rw_ctx.caps = got;
-	ceph_add_rw_context(fi, &rw_ctx);
 	ret = filemap_splice_read(in, ppos, pipe, len, flags);
-	ceph_del_rw_context(fi, &rw_ctx);
 
 	dout("splice_read %p %llx.%llx dropping cap refs on %s = %zd\n",
 	     inode, ceph_vinop(inode), ceph_cap_string(got), ret);
@@ -3177,7 +3166,7 @@ static int ceph_fadvise(struct file *file, loff_t offset, loff_t len, int advice
 		goto out;
 	}
 
-	if ((got & want) == want) {
+	if (got & want) {
 		doutc(cl, "fadvise(WILLNEED) %p %llx.%llx %llu~%llu got cap refs on %s\n",
 		      inode, ceph_vinop(inode), offset, len,
 		      ceph_cap_string(got));
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index b072572e2cf4..14784ad86670 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -833,10 +833,6 @@ extern void change_auth_cap_ses(struct ceph_inode_info *ci,
 struct ceph_file_info {
 	short fmode;     /* initialized on open */
 	short flags;     /* CEPH_F_* */
-
-	spinlock_t rw_contexts_lock;
-	struct list_head rw_contexts;
-
 	u32 filp_gen;
 };
 
@@ -859,49 +855,6 @@ struct ceph_dir_file_info {
 	int dir_info_len;
 };
 
-struct ceph_rw_context {
-	struct list_head list;
-	struct task_struct *thread;
-	int caps;
-};
-
-#define CEPH_DEFINE_RW_CONTEXT(_name, _caps)	\
-	struct ceph_rw_context _name = {	\
-		.thread = current,		\
-		.caps = _caps,			\
-	}
-
-static inline void ceph_add_rw_context(struct ceph_file_info *cf,
-				       struct ceph_rw_context *ctx)
-{
-	spin_lock(&cf->rw_contexts_lock);
-	list_add(&ctx->list, &cf->rw_contexts);
-	spin_unlock(&cf->rw_contexts_lock);
-}
-
-static inline void ceph_del_rw_context(struct ceph_file_info *cf,
-				       struct ceph_rw_context *ctx)
-{
-	spin_lock(&cf->rw_contexts_lock);
-	list_del(&ctx->list);
-	spin_unlock(&cf->rw_contexts_lock);
-}
-
-static inline struct ceph_rw_context*
-ceph_find_rw_context(struct ceph_file_info *cf)
-{
-	struct ceph_rw_context *ctx, *found = NULL;
-	spin_lock(&cf->rw_contexts_lock);
-	list_for_each_entry(ctx, &cf->rw_contexts, list) {
-		if (ctx->thread == current) {
-			found = ctx;
-			break;
-		}
-	}
-	spin_unlock(&cf->rw_contexts_lock);
-	return found;
-}
-
 struct ceph_readdir_cache_control {
 	struct folio *folio;
 	struct dentry **dentries;


