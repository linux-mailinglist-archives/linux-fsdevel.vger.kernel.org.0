Return-Path: <linux-fsdevel+bounces-43953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3272A6056D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 00:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2F284211A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 23:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611151F9A95;
	Thu, 13 Mar 2025 23:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4aNjIO5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942AA1FC11B
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 23:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741908853; cv=none; b=lap/70Bm7j0jtXhi1kM83zEWFvyadvhKjdJsHoofmUbkFAGl45nwgw4jjlZ1CFJcxSdzZAY5D9Q3WBmH67JfloeYt9hF5NqL3wIfNf9byARGcKkvsNjjLe14P2Q6/BW3d4+vo00jKrrjQpoeo9MDh9HRI4lFrZbbOYruG74pP6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741908853; c=relaxed/simple;
	bh=CluZwY+eYDnkZf+z8fWzdwFU78oZfC7qBc49tfiJI8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uT0wOeEiBP7O5V0/c/JEmeoEr1LgwmybUgosPBA3J52jilRlAWvip81P1sb2C4KUWA6zyo3LUfjm845WGLG+0OpbhkHgY7TycQ0XMjqGi3xkOTjRLlvf0ZIYnmJ850Dyzz21TVQ2nI3jTUWqscB8jiumhlinwwOpCO87RKQAqOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E4aNjIO5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741908850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bDsUct3iSIdqsb4gcB1FzVfxHpzHUbzpTjfZc6AJBmM=;
	b=E4aNjIO5q5IhgsI3qNRfu8A9jvY8duhwRqXTmoOvBHsCYocBEiBuxqtGdJfbhqNzL+vsuQ
	JEDdeLyDo0vvU0SpSz1jFK2U0SSu6iC6if+s9bP791cenCNIGoHYZMEtWyz0ctcn+RDva7
	EZJOJNL+ciofzaNi+psfE8H2CA1Wg5U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-IF-bWtVKNfeYz1R2hlm-Pg-1; Thu,
 13 Mar 2025 19:34:07 -0400
X-MC-Unique: IF-bWtVKNfeYz1R2hlm-Pg-1
X-Mimecast-MFC-AGG-ID: IF-bWtVKNfeYz1R2hlm-Pg_1741908846
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA181180035C;
	Thu, 13 Mar 2025 23:34:05 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AD14D1800945;
	Thu, 13 Mar 2025 23:34:03 +0000 (UTC)
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
Subject: [RFC PATCH 04/35] ceph: Convert ceph_mds_request::r_pagelist to a databuf
Date: Thu, 13 Mar 2025 23:32:56 +0000
Message-ID: <20250313233341.1675324-5-dhowells@redhat.com>
In-Reply-To: <20250313233341.1675324-1-dhowells@redhat.com>
References: <20250313233341.1675324-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Convert ceph_mds_request::r_pagelist to a databuf, along with the stuff
that uses it such as setxattr ops.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/ceph/acl.c        | 39 ++++++++++----------
 fs/ceph/file.c       | 12 ++++---
 fs/ceph/inode.c      | 85 +++++++++++++++++++-------------------------
 fs/ceph/mds_client.c | 11 +++---
 fs/ceph/mds_client.h |  2 +-
 fs/ceph/super.h      |  2 +-
 fs/ceph/xattr.c      | 68 +++++++++++++++--------------------
 7 files changed, 96 insertions(+), 123 deletions(-)

diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
index 1564eacc253d..d6da650db83e 100644
--- a/fs/ceph/acl.c
+++ b/fs/ceph/acl.c
@@ -171,7 +171,7 @@ int ceph_pre_init_acls(struct inode *dir, umode_t *mode,
 {
 	struct posix_acl *acl, *default_acl;
 	size_t val_size1 = 0, val_size2 = 0;
-	struct ceph_pagelist *pagelist = NULL;
+	struct ceph_databuf *dbuf = NULL;
 	void *tmp_buf = NULL;
 	int err;
 
@@ -201,58 +201,55 @@ int ceph_pre_init_acls(struct inode *dir, umode_t *mode,
 	tmp_buf = kmalloc(max(val_size1, val_size2), GFP_KERNEL);
 	if (!tmp_buf)
 		goto out_err;
-	pagelist = ceph_pagelist_alloc(GFP_KERNEL);
-	if (!pagelist)
+	dbuf = ceph_databuf_req_alloc(1, PAGE_SIZE, GFP_KERNEL);
+	if (!dbuf)
 		goto out_err;
 
-	err = ceph_pagelist_reserve(pagelist, PAGE_SIZE);
-	if (err)
-		goto out_err;
-
-	ceph_pagelist_encode_32(pagelist, acl && default_acl ? 2 : 1);
+	ceph_databuf_encode_32(dbuf, acl && default_acl ? 2 : 1);
 
 	if (acl) {
 		size_t len = strlen(XATTR_NAME_POSIX_ACL_ACCESS);
-		err = ceph_pagelist_reserve(pagelist, len + val_size1 + 8);
+		err = ceph_databuf_reserve(dbuf, len + val_size1 + 8,
+					   GFP_KERNEL);
 		if (err)
 			goto out_err;
-		ceph_pagelist_encode_string(pagelist, XATTR_NAME_POSIX_ACL_ACCESS,
-					    len);
+		ceph_databuf_encode_string(dbuf, XATTR_NAME_POSIX_ACL_ACCESS,
+					   len);
 		err = posix_acl_to_xattr(&init_user_ns, acl,
 					 tmp_buf, val_size1);
 		if (err < 0)
 			goto out_err;
-		ceph_pagelist_encode_32(pagelist, val_size1);
-		ceph_pagelist_append(pagelist, tmp_buf, val_size1);
+		ceph_databuf_encode_32(dbuf, val_size1);
+		ceph_databuf_append(dbuf, tmp_buf, val_size1);
 	}
 	if (default_acl) {
 		size_t len = strlen(XATTR_NAME_POSIX_ACL_DEFAULT);
-		err = ceph_pagelist_reserve(pagelist, len + val_size2 + 8);
+		err = ceph_databuf_reserve(dbuf, len + val_size2 + 8,
+					   GFP_KERNEL);
 		if (err)
 			goto out_err;
-		ceph_pagelist_encode_string(pagelist,
-					  XATTR_NAME_POSIX_ACL_DEFAULT, len);
+		ceph_databuf_encode_string(dbuf,
+					   XATTR_NAME_POSIX_ACL_DEFAULT, len);
 		err = posix_acl_to_xattr(&init_user_ns, default_acl,
 					 tmp_buf, val_size2);
 		if (err < 0)
 			goto out_err;
-		ceph_pagelist_encode_32(pagelist, val_size2);
-		ceph_pagelist_append(pagelist, tmp_buf, val_size2);
+		ceph_databuf_encode_32(dbuf, val_size2);
+		ceph_databuf_append(dbuf, tmp_buf, val_size2);
 	}
 
 	kfree(tmp_buf);
 
 	as_ctx->acl = acl;
 	as_ctx->default_acl = default_acl;
-	as_ctx->pagelist = pagelist;
+	as_ctx->dbuf = dbuf;
 	return 0;
 
 out_err:
 	posix_acl_release(acl);
 	posix_acl_release(default_acl);
 	kfree(tmp_buf);
-	if (pagelist)
-		ceph_pagelist_release(pagelist);
+	ceph_databuf_release(dbuf);
 	return err;
 }
 
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 851d70200c6b..9de2960748b9 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -679,9 +679,9 @@ static int ceph_finish_async_create(struct inode *dir, struct inode *inode,
 	iinfo.change_attr = 1;
 	ceph_encode_timespec64(&iinfo.btime, &now);
 
-	if (req->r_pagelist) {
-		iinfo.xattr_len = req->r_pagelist->length;
-		iinfo.xattr_data = req->r_pagelist->mapped_tail;
+	if (req->r_dbuf) {
+		iinfo.xattr_len = ceph_databuf_len(req->r_dbuf);
+		iinfo.xattr_data = kmap_ceph_databuf_page(req->r_dbuf, 0);
 	} else {
 		/* fake it */
 		iinfo.xattr_len = ARRAY_SIZE(xattr_buf);
@@ -731,6 +731,8 @@ static int ceph_finish_async_create(struct inode *dir, struct inode *inode,
 	ret = ceph_fill_inode(inode, NULL, &iinfo, NULL, req->r_session,
 			      req->r_fmode, NULL);
 	up_read(&mdsc->snap_rwsem);
+	if (req->r_dbuf)
+		kunmap_local(iinfo.xattr_data);
 	if (ret) {
 		doutc(cl, "failed to fill inode: %d\n", ret);
 		ceph_dir_clear_complete(dir);
@@ -849,8 +851,8 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 			goto out_ctx;
 		}
 		/* Async create can't handle more than a page of xattrs */
-		if (as_ctx.pagelist &&
-		    !list_is_singular(&as_ctx.pagelist->head))
+		if (as_ctx.dbuf &&
+		    as_ctx.dbuf->nr_bvec > 1)
 			try_async = false;
 	} else if (!d_in_lookup(dentry)) {
 		/* If it's not being looked up, it's negative */
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index b060f765ad20..ec9b80fec7be 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -112,9 +112,9 @@ struct inode *ceph_new_inode(struct inode *dir, struct dentry *dentry,
 void ceph_as_ctx_to_req(struct ceph_mds_request *req,
 			struct ceph_acl_sec_ctx *as_ctx)
 {
-	if (as_ctx->pagelist) {
-		req->r_pagelist = as_ctx->pagelist;
-		as_ctx->pagelist = NULL;
+	if (as_ctx->dbuf) {
+		req->r_dbuf = as_ctx->dbuf;
+		as_ctx->dbuf = NULL;
 	}
 	ceph_fscrypt_as_ctx_to_req(req, as_ctx);
 }
@@ -2341,11 +2341,10 @@ static int fill_fscrypt_truncate(struct inode *inode,
 	loff_t pos, orig_pos = round_down(attr->ia_size,
 					  CEPH_FSCRYPT_BLOCK_SIZE);
 	u64 block = orig_pos >> CEPH_FSCRYPT_BLOCK_SHIFT;
-	struct ceph_pagelist *pagelist = NULL;
-	struct kvec iov = {0};
+	struct ceph_databuf *dbuf = NULL;
 	struct iov_iter iter;
-	struct page *page = NULL;
-	struct ceph_fscrypt_truncate_size_header header;
+	struct ceph_fscrypt_truncate_size_header *header;
+	void *p;
 	int retry_op = 0;
 	int len = CEPH_FSCRYPT_BLOCK_SIZE;
 	loff_t i_size = i_size_read(inode);
@@ -2372,37 +2371,35 @@ static int fill_fscrypt_truncate(struct inode *inode,
 			goto out;
 	}
 
-	page = __page_cache_alloc(GFP_KERNEL);
-	if (page == NULL) {
-		ret = -ENOMEM;
+	ret = -ENOMEM;
+	dbuf = ceph_databuf_req_alloc(2, 0, GFP_KERNEL);
+	if (!dbuf)
 		goto out;
-	}
 
-	pagelist = ceph_pagelist_alloc(GFP_KERNEL);
-	if (!pagelist) {
-		ret = -ENOMEM;
+	if (ceph_databuf_insert_frag(dbuf, 0, sizeof(*header), GFP_KERNEL) < 0)
+		goto out;
+	if (ceph_databuf_insert_frag(dbuf, 1, PAGE_SIZE, GFP_KERNEL) < 0)
 		goto out;
-	}
 
-	iov.iov_base = kmap_local_page(page);
-	iov.iov_len = len;
-	iov_iter_kvec(&iter, READ, &iov, 1, len);
+	iov_iter_bvec(&iter, ITER_DEST, &dbuf->bvec[1], 1, len);
 
 	pos = orig_pos;
 	ret = __ceph_sync_read(inode, &pos, &iter, &retry_op, &objver);
 	if (ret < 0)
 		goto out;
 
+	header = kmap_ceph_databuf_page(dbuf, 0);
+
 	/* Insert the header first */
-	header.ver = 1;
-	header.compat = 1;
-	header.change_attr = cpu_to_le64(inode_peek_iversion_raw(inode));
+	header->ver = 1;
+	header->compat = 1;
+	header->change_attr = cpu_to_le64(inode_peek_iversion_raw(inode));
 
 	/*
 	 * Always set the block_size to CEPH_FSCRYPT_BLOCK_SIZE,
 	 * because in MDS it may need this to do the truncate.
 	 */
-	header.block_size = cpu_to_le32(CEPH_FSCRYPT_BLOCK_SIZE);
+	header->block_size = cpu_to_le32(CEPH_FSCRYPT_BLOCK_SIZE);
 
 	/*
 	 * If we hit a hole here, we should just skip filling
@@ -2417,51 +2414,41 @@ static int fill_fscrypt_truncate(struct inode *inode,
 	if (!objver) {
 		doutc(cl, "hit hole, ppos %lld < size %lld\n", pos, i_size);
 
-		header.data_len = cpu_to_le32(8 + 8 + 4);
-		header.file_offset = 0;
+		header->data_len = cpu_to_le32(8 + 8 + 4);
+		header->file_offset = 0;
 		ret = 0;
 	} else {
-		header.data_len = cpu_to_le32(8 + 8 + 4 + CEPH_FSCRYPT_BLOCK_SIZE);
-		header.file_offset = cpu_to_le64(orig_pos);
+		header->data_len = cpu_to_le32(8 + 8 + 4 + CEPH_FSCRYPT_BLOCK_SIZE);
+		header->file_offset = cpu_to_le64(orig_pos);
 
 		doutc(cl, "encrypt block boff/bsize %d/%lu\n", boff,
 		      CEPH_FSCRYPT_BLOCK_SIZE);
 
 		/* truncate and zero out the extra contents for the last block */
-		memset(iov.iov_base + boff, 0, PAGE_SIZE - boff);
+		p = kmap_ceph_databuf_page(dbuf, 1);
+		memset(p + boff, 0, PAGE_SIZE - boff);
+		kunmap_local(p);
 
 		/* encrypt the last block */
-		ret = ceph_fscrypt_encrypt_block_inplace(inode, page,
-						    CEPH_FSCRYPT_BLOCK_SIZE,
-						    0, block,
-						    GFP_KERNEL);
+		ret = ceph_fscrypt_encrypt_block_inplace(
+			inode, ceph_databuf_page(dbuf, 1),
+			CEPH_FSCRYPT_BLOCK_SIZE, 0, block, GFP_KERNEL);
 		if (ret)
 			goto out;
 	}
 
-	/* Insert the header */
-	ret = ceph_pagelist_append(pagelist, &header, sizeof(header));
-	if (ret)
-		goto out;
+	ceph_databuf_added_data(dbuf, sizeof(*header));
+	if (header->block_size)
+		ceph_databuf_added_data(dbuf, CEPH_FSCRYPT_BLOCK_SIZE);
 
-	if (header.block_size) {
-		/* Append the last block contents to pagelist */
-		ret = ceph_pagelist_append(pagelist, iov.iov_base,
-					   CEPH_FSCRYPT_BLOCK_SIZE);
-		if (ret)
-			goto out;
-	}
-	req->r_pagelist = pagelist;
+	req->r_dbuf = dbuf;
 out:
 	doutc(cl, "%p %llx.%llx size dropping cap refs on %s\n", inode,
 	      ceph_vinop(inode), ceph_cap_string(got));
 	ceph_put_cap_refs(ci, got);
-	if (iov.iov_base)
-		kunmap_local(iov.iov_base);
-	if (page)
-		__free_pages(page, 0);
-	if (ret && pagelist)
-		ceph_pagelist_release(pagelist);
+	kunmap_local(header);
+	if (ret)
+		ceph_databuf_release(dbuf);
 	return ret;
 }
 
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 230e0c3f341f..09661a34f287 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1125,8 +1125,7 @@ void ceph_mdsc_release_request(struct kref *kref)
 	put_cred(req->r_cred);
 	if (req->r_mnt_idmap)
 		mnt_idmap_put(req->r_mnt_idmap);
-	if (req->r_pagelist)
-		ceph_pagelist_release(req->r_pagelist);
+	ceph_databuf_release(req->r_dbuf);
 	kfree(req->r_fscrypt_auth);
 	kfree(req->r_altname);
 	put_request_session(req);
@@ -3207,10 +3206,10 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
 	msg->front.iov_len = p - msg->front.iov_base;
 	msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
 
-	if (req->r_pagelist) {
-		struct ceph_pagelist *pagelist = req->r_pagelist;
-		ceph_msg_data_add_pagelist(msg, pagelist);
-		msg->hdr.data_len = cpu_to_le32(pagelist->length);
+	if (req->r_dbuf) {
+		struct ceph_databuf *dbuf = req->r_dbuf;
+		ceph_msg_data_add_databuf(msg, dbuf);
+		msg->hdr.data_len = cpu_to_le32(ceph_databuf_len(dbuf));
 	} else {
 		msg->hdr.data_len = 0;
 	}
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 3e2a6fa7c19a..a7ee8da07ce7 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -333,7 +333,7 @@ struct ceph_mds_request {
 	u32 r_direct_hash;      /* choose dir frag based on this dentry hash */
 
 	/* data payload is used for xattr ops */
-	struct ceph_pagelist *r_pagelist;
+	struct ceph_databuf *r_dbuf;
 
 	/* what caps shall we drop? */
 	int r_inode_drop, r_inode_unless;
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index bb0db0cc8003..984a6d2a5378 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1137,7 +1137,7 @@ struct ceph_acl_sec_ctx {
 #ifdef CONFIG_FS_ENCRYPTION
 	struct ceph_fscrypt_auth *fscrypt_auth;
 #endif
-	struct ceph_pagelist *pagelist;
+	struct ceph_databuf *dbuf;
 };
 
 #ifdef CONFIG_SECURITY
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 537165db4519..b083cd3b3974 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -1114,17 +1114,17 @@ static int ceph_sync_setxattr(struct inode *inode, const char *name,
 	struct ceph_mds_request *req;
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_osd_client *osdc = &fsc->client->osdc;
-	struct ceph_pagelist *pagelist = NULL;
+	struct ceph_databuf *dbuf = NULL;
 	int op = CEPH_MDS_OP_SETXATTR;
 	int err;
 
 	if (size > 0) {
-		/* copy value into pagelist */
-		pagelist = ceph_pagelist_alloc(GFP_NOFS);
-		if (!pagelist)
+		/* copy value into dbuf */
+		dbuf = ceph_databuf_req_alloc(1, size, GFP_NOFS);
+		if (!dbuf)
 			return -ENOMEM;
 
-		err = ceph_pagelist_append(pagelist, value, size);
+		err = ceph_databuf_append(dbuf, value, size);
 		if (err)
 			goto out;
 	} else if (!value) {
@@ -1154,8 +1154,8 @@ static int ceph_sync_setxattr(struct inode *inode, const char *name,
 		req->r_args.setxattr.flags = cpu_to_le32(flags);
 		req->r_args.setxattr.osdmap_epoch =
 			cpu_to_le32(osdc->osdmap->epoch);
-		req->r_pagelist = pagelist;
-		pagelist = NULL;
+		req->r_dbuf = dbuf;
+		dbuf = NULL;
 	}
 
 	req->r_inode = inode;
@@ -1169,8 +1169,7 @@ static int ceph_sync_setxattr(struct inode *inode, const char *name,
 	doutc(cl, "xattr.ver (after): %lld\n", ci->i_xattrs.version);
 
 out:
-	if (pagelist)
-		ceph_pagelist_release(pagelist);
+	ceph_databuf_release(dbuf);
 	return err;
 }
 
@@ -1377,7 +1376,7 @@ bool ceph_security_xattr_deadlock(struct inode *in)
 int ceph_security_init_secctx(struct dentry *dentry, umode_t mode,
 			   struct ceph_acl_sec_ctx *as_ctx)
 {
-	struct ceph_pagelist *pagelist = as_ctx->pagelist;
+	struct ceph_databuf *dbuf = as_ctx->dbuf;
 	const char *name;
 	size_t name_len;
 	int err;
@@ -1391,14 +1390,11 @@ int ceph_security_init_secctx(struct dentry *dentry, umode_t mode,
 	}
 
 	err = -ENOMEM;
-	if (!pagelist) {
-		pagelist = ceph_pagelist_alloc(GFP_KERNEL);
-		if (!pagelist)
+	if (!dbuf) {
+		dbuf = ceph_databuf_req_alloc(0, PAGE_SIZE, GFP_KERNEL);
+		if (!dbuf)
 			goto out;
-		err = ceph_pagelist_reserve(pagelist, PAGE_SIZE);
-		if (err)
-			goto out;
-		ceph_pagelist_encode_32(pagelist, 1);
+		ceph_databuf_encode_32(dbuf, 1);
 	}
 
 	/*
@@ -1407,38 +1403,31 @@ int ceph_security_init_secctx(struct dentry *dentry, umode_t mode,
 	 * dentry_init_security hook.
 	 */
 	name_len = strlen(name);
-	err = ceph_pagelist_reserve(pagelist,
-				    4 * 2 + name_len + as_ctx->lsmctx.len);
+	err = ceph_databuf_reserve(dbuf, 4 * 2 + name_len + as_ctx->lsmctx.len,
+				   GFP_KERNEL);
 	if (err)
 		goto out;
 
-	if (as_ctx->pagelist) {
+	if (as_ctx->dbuf) {
 		/* update count of KV pairs */
-		BUG_ON(pagelist->length <= sizeof(__le32));
-		if (list_is_singular(&pagelist->head)) {
-			le32_add_cpu((__le32*)pagelist->mapped_tail, 1);
-		} else {
-			struct page *page = list_first_entry(&pagelist->head,
-							     struct page, lru);
-			void *addr = kmap_atomic(page);
-			le32_add_cpu((__le32*)addr, 1);
-			kunmap_atomic(addr);
-		}
+		BUG_ON(ceph_databuf_len(dbuf) <= sizeof(__le32));
+		__le32 *addr = kmap_ceph_databuf_page(dbuf, 0);
+		le32_add_cpu(addr, 1);
+		kunmap_local(addr);
 	} else {
-		as_ctx->pagelist = pagelist;
+		as_ctx->dbuf = dbuf;
 	}
 
-	ceph_pagelist_encode_32(pagelist, name_len);
-	ceph_pagelist_append(pagelist, name, name_len);
+	ceph_databuf_encode_32(dbuf, name_len);
+	ceph_databuf_append(dbuf, name, name_len);
 
-	ceph_pagelist_encode_32(pagelist, as_ctx->lsmctx.len);
-	ceph_pagelist_append(pagelist, as_ctx->lsmctx.context,
-			     as_ctx->lsmctx.len);
+	ceph_databuf_encode_32(dbuf, as_ctx->lsmctx.len);
+	ceph_databuf_append(dbuf, as_ctx->lsmctx.context, as_ctx->lsmctx.len);
 
 	err = 0;
 out:
-	if (pagelist && !as_ctx->pagelist)
-		ceph_pagelist_release(pagelist);
+	if (dbuf && !as_ctx->dbuf)
+		ceph_databuf_release(dbuf);
 	return err;
 }
 #endif /* CONFIG_CEPH_FS_SECURITY_LABEL */
@@ -1456,8 +1445,7 @@ void ceph_release_acl_sec_ctx(struct ceph_acl_sec_ctx *as_ctx)
 #ifdef CONFIG_FS_ENCRYPTION
 	kfree(as_ctx->fscrypt_auth);
 #endif
-	if (as_ctx->pagelist)
-		ceph_pagelist_release(as_ctx->pagelist);
+	ceph_databuf_release(as_ctx->dbuf);
 }
 
 /*


