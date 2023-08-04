Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FAE7700F5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 15:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjHDNP3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 09:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjHDNPP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:15:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD8249EC
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 06:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691154825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1MPbszDT83yI+T3IpWwque2ZQHTa1nGTriJWRytwyko=;
        b=LoUKTuVZXL2nd+ZFfDBrAccDbruNU6+hx4d6pYYunsyjrHZogof11HvlB44msmrZ+1gGSb
        ol7mz+ViGhG5sE1LhArkklMe7MPiAjwnRy+oKJpL3dBhB6nJyA53dWyb0AeFD7Zv9mCioc
        V62ptDRDJ8nXp2cGW4dPZtVhSbt7Se4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-oE0ptymvPSC83r8hwq3h0g-1; Fri, 04 Aug 2023 09:13:40 -0400
X-MC-Unique: oE0ptymvPSC83r8hwq3h0g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A9AEC101A54E;
        Fri,  4 Aug 2023 13:13:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C1A340C2063;
        Fri,  4 Aug 2023 13:13:38 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 04/18] ceph: Convert ceph_mds_request::r_pagelist to a databuf
Date:   Fri,  4 Aug 2023 14:13:13 +0100
Message-ID: <20230804131327.2574082-5-dhowells@redhat.com>
In-Reply-To: <20230804131327.2574082-1-dhowells@redhat.com>
References: <20230804131327.2574082-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert ceph_mds_request::r_pagelist to a databuf, along with the stuff
that uses it such as setxattr ops.

Signed-off-by: David Howells <dhowells@redhat.com>
---
 fs/ceph/acl.c        | 39 ++++++++++----------
 fs/ceph/file.c       | 12 ++++---
 fs/ceph/inode.c      | 85 +++++++++++++++++++-------------------------
 fs/ceph/mds_client.c | 11 +++---
 fs/ceph/mds_client.h |  2 +-
 fs/ceph/super.h      |  2 +-
 fs/ceph/xattr.c      | 67 +++++++++++++++-------------------
 7 files changed, 96 insertions(+), 122 deletions(-)

diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
index 32b26deb1741..49ec339f5783 100644
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
+	dbuf = ceph_databuf_alloc(1, PAGE_SIZE, GFP_KERNEL);
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
index 7470daafe595..323e7631c7d8 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -647,9 +647,9 @@ static int ceph_finish_async_create(struct inode *dir, struct inode *inode,
 	iinfo.change_attr = 1;
 	ceph_encode_timespec64(&iinfo.btime, &now);
 
-	if (req->r_pagelist) {
-		iinfo.xattr_len = req->r_pagelist->length;
-		iinfo.xattr_data = req->r_pagelist->mapped_tail;
+	if (req->r_dbuf) {
+		iinfo.xattr_len = req->r_dbuf->length;
+		iinfo.xattr_data = kmap_ceph_databuf_page(req->r_dbuf, 0);
 	} else {
 		/* fake it */
 		iinfo.xattr_len = ARRAY_SIZE(xattr_buf);
@@ -695,6 +695,8 @@ static int ceph_finish_async_create(struct inode *dir, struct inode *inode,
 	ret = ceph_fill_inode(inode, NULL, &iinfo, NULL, req->r_session,
 			      req->r_fmode, NULL);
 	up_read(&mdsc->snap_rwsem);
+	if (req->r_dbuf)
+		kunmap_local(iinfo.xattr_data);
 	if (ret) {
 		doutc(cl, "failed to fill inode: %d\n", ret);
 		ceph_dir_clear_complete(dir);
@@ -781,8 +783,8 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
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
index 3ff4f57f223f..f1c455fced6f 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -110,9 +110,9 @@ struct inode *ceph_new_inode(struct inode *dir, struct dentry *dentry,
 
 void ceph_as_ctx_to_req(struct ceph_mds_request *req, struct ceph_acl_sec_ctx *as_ctx)
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
@@ -2343,11 +2343,10 @@ static int fill_fscrypt_truncate(struct inode *inode,
 	int boff = attr->ia_size % CEPH_FSCRYPT_BLOCK_SIZE;
 	loff_t pos, orig_pos = round_down(attr->ia_size, CEPH_FSCRYPT_BLOCK_SIZE);
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
@@ -2373,37 +2372,35 @@ static int fill_fscrypt_truncate(struct inode *inode,
 			goto out;
 	}
 
-	page = __page_cache_alloc(GFP_KERNEL);
-	if (page == NULL) {
-		ret = -ENOMEM;
+	ret = -ENOMEM;
+	dbuf = ceph_databuf_alloc(2, 0, GFP_KERNEL);
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
@@ -2418,51 +2415,41 @@ static int fill_fscrypt_truncate(struct inode *inode,
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
+	dbuf->length = sizeof(*header);
+	if (header->block_size)
+		dbuf->length += CEPH_FSCRYPT_BLOCK_SIZE;
 
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
index 9aae39289b43..85b2f1eccf88 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1121,8 +1121,7 @@ void ceph_mdsc_release_request(struct kref *kref)
 	kfree(req->r_path1);
 	kfree(req->r_path2);
 	put_cred(req->r_cred);
-	if (req->r_pagelist)
-		ceph_pagelist_release(req->r_pagelist);
+	ceph_databuf_release(req->r_dbuf);
 	kfree(req->r_fscrypt_auth);
 	kfree(req->r_altname);
 	put_request_session(req);
@@ -3108,10 +3107,10 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
 	msg->front.iov_len = p - msg->front.iov_base;
 	msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
 
-	if (req->r_pagelist) {
-		struct ceph_pagelist *pagelist = req->r_pagelist;
-		ceph_msg_data_add_pagelist(msg, pagelist);
-		msg->hdr.data_len = cpu_to_le32(pagelist->length);
+	if (req->r_dbuf) {
+		struct ceph_databuf *dbuf = req->r_dbuf;
+		ceph_msg_data_add_databuf(msg, dbuf);
+		msg->hdr.data_len = cpu_to_le32(dbuf->length);
 	} else {
 		msg->hdr.data_len = 0;
 	}
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 717a7399bacb..ab1abc38911b 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -307,7 +307,7 @@ struct ceph_mds_request {
 	u32 r_direct_hash;      /* choose dir frag based on this dentry hash */
 
 	/* data payload is used for xattr ops */
-	struct ceph_pagelist *r_pagelist;
+	struct ceph_databuf *r_dbuf;
 
 	/* what caps shall we drop? */
 	int r_inode_drop, r_inode_unless;
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 4e78de1be23e..681e634052b1 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1139,7 +1139,7 @@ struct ceph_acl_sec_ctx {
 #ifdef CONFIG_FS_ENCRYPTION
 	struct ceph_fscrypt_auth *fscrypt_auth;
 #endif
-	struct ceph_pagelist *pagelist;
+	struct ceph_databuf *dbuf;
 };
 
 #ifdef CONFIG_SECURITY
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index d4624f56606d..ca3ec5dd0382 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -1113,17 +1113,17 @@ static int ceph_sync_setxattr(struct inode *inode, const char *name,
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
+		dbuf = ceph_databuf_alloc(1, size, GFP_NOFS);
+		if (!dbuf)
 			return -ENOMEM;
 
-		err = ceph_pagelist_append(pagelist, value, size);
+		err = ceph_databuf_append(dbuf, value, size);
 		if (err)
 			goto out;
 	} else if (!value) {
@@ -1153,8 +1153,8 @@ static int ceph_sync_setxattr(struct inode *inode, const char *name,
 		req->r_args.setxattr.flags = cpu_to_le32(flags);
 		req->r_args.setxattr.osdmap_epoch =
 			cpu_to_le32(osdc->osdmap->epoch);
-		req->r_pagelist = pagelist;
-		pagelist = NULL;
+		req->r_dbuf = dbuf;
+		dbuf = NULL;
 	}
 
 	req->r_inode = inode;
@@ -1168,8 +1168,7 @@ static int ceph_sync_setxattr(struct inode *inode, const char *name,
 	doutc(cl, "xattr.ver (after): %lld\n", ci->i_xattrs.version);
 
 out:
-	if (pagelist)
-		ceph_pagelist_release(pagelist);
+	ceph_databuf_release(dbuf);
 	return err;
 }
 
@@ -1376,7 +1375,7 @@ bool ceph_security_xattr_deadlock(struct inode *in)
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
+		dbuf = ceph_databuf_alloc(0, PAGE_SIZE, GFP_KERNEL);
+		if (!dbuf)
 			goto out;
-		err = ceph_pagelist_reserve(pagelist, PAGE_SIZE);
-		if (err)
-			goto out;
-		ceph_pagelist_encode_32(pagelist, 1);
+		ceph_databuf_encode_32(dbuf, 1);
 	}
 
 	/*
@@ -1407,37 +1403,31 @@ int ceph_security_init_secctx(struct dentry *dentry, umode_t mode,
 	 * dentry_init_security hook.
 	 */
 	name_len = strlen(name);
-	err = ceph_pagelist_reserve(pagelist,
-				    4 * 2 + name_len + as_ctx->sec_ctxlen);
+	err = ceph_databuf_reserve(dbuf, 4 * 2 + name_len + as_ctx->sec_ctxlen,
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
+		__le32 *addr = kmap_ceph_databuf_page(dbuf, 0);
+		BUG_ON(dbuf->length <= sizeof(__le32));
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
 
-	ceph_pagelist_encode_32(pagelist, as_ctx->sec_ctxlen);
-	ceph_pagelist_append(pagelist, as_ctx->sec_ctx, as_ctx->sec_ctxlen);
+	ceph_databuf_encode_32(dbuf, as_ctx->sec_ctxlen);
+	ceph_databuf_append(dbuf, as_ctx->sec_ctx, as_ctx->sec_ctxlen);
 
 	err = 0;
 out:
-	if (pagelist && !as_ctx->pagelist)
-		ceph_pagelist_release(pagelist);
+	if (dbuf && !as_ctx->dbuf)
+		ceph_databuf_release(dbuf);
 	return err;
 }
 #endif /* CONFIG_CEPH_FS_SECURITY_LABEL */
@@ -1455,8 +1445,7 @@ void ceph_release_acl_sec_ctx(struct ceph_acl_sec_ctx *as_ctx)
 #ifdef CONFIG_FS_ENCRYPTION
 	kfree(as_ctx->fscrypt_auth);
 #endif
-	if (as_ctx->pagelist)
-		ceph_pagelist_release(as_ctx->pagelist);
+	ceph_databuf_release(as_ctx->dbuf);
 }
 
 /*

