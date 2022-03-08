Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4BB4D26EB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 05:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiCIBkS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 20:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbiCIBkR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:40:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 354B0D4C99
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Mar 2022 17:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646789953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VjUeE5se6UUWWGMy05o/RQVZHtLonuXJkqieqEpsiuM=;
        b=iqWrIj9TJIhNBhXBcolMqLWIQkEjkvKSCVt83K8eOEK7EnIlKQFUdYGBkzvSRd6D8zpa2g
        Xmjv0+/t06fQy3pzSR2ODReKFqkuO11Y19M2cTLjuGjhexlcx9pru8ISdfzsS0cfmcJb2v
        XYd32J/zDT89BXPUTYNm8N2lmKF0zh0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-427-YelqM6oFN4uJTvIZNKEbQQ-1; Tue, 08 Mar 2022 18:25:57 -0500
X-MC-Unique: YelqM6oFN4uJTvIZNKEbQQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9E52FC81;
        Tue,  8 Mar 2022 23:25:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 71A2C7A224;
        Tue,  8 Mar 2022 23:25:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 03/19] netfs: Rename netfs_read_*request to
 netfs_io_*request
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 08 Mar 2022 23:25:51 +0000
Message-ID: <164678195157.1200972.366609966927368090.stgit@warthog.procyon.org.uk>
In-Reply-To: <164678185692.1200972.597611902374126174.stgit@warthog.procyon.org.uk>
References: <164678185692.1200972.597611902374126174.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rename netfs_read_*request to netfs_io_*request so that the same structures
can be used for the write helpers too.

perl -p -i -e 's/netfs_read_(request|subrequest)/netfs_io_$1/g' \
   `git grep -l 'netfs_read_\(sub\|\)request'`
perl -p -i -e 's/nr_rd_ops/nr_outstanding/g' \
   `git grep -l nr_rd_ops`
perl -p -i -e 's/nr_wr_ops/nr_copy_ops/g' \
   `git grep -l nr_wr_ops`
perl -p -i -e 's/netfs_read_source/netfs_io_source/g' \
   `git grep -l 'netfs_read_source'`
perl -p -i -e 's/netfs_io_request_ops/netfs_request_ops/g' \
   `git grep -l 'netfs_io_request_ops'`
perl -p -i -e 's/init_rreq/init_request/g' \
   `git grep -l 'init_rreq'`

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com

Link: https://lore.kernel.org/r/164622988070.3564931.7089670190434315183.stgit@warthog.procyon.org.uk/ # v1
---

 Documentation/filesystems/netfs_library.rst |   40 +++---
 fs/9p/vfs_addr.c                            |   16 +-
 fs/afs/file.c                               |   12 +-
 fs/afs/internal.h                           |    4 -
 fs/cachefiles/io.c                          |    6 -
 fs/ceph/addr.c                              |   16 +-
 fs/ceph/cache.h                             |    4 -
 fs/netfs/read_helper.c                      |  194 ++++++++++++++-------------
 include/linux/netfs.h                       |   42 +++---
 include/trace/events/cachefiles.h           |    6 -
 include/trace/events/netfs.h                |   14 +-
 11 files changed, 177 insertions(+), 177 deletions(-)

diff --git a/Documentation/filesystems/netfs_library.rst b/Documentation/filesystems/netfs_library.rst
index 4f373a8ec47b..a997e2d4321d 100644
--- a/Documentation/filesystems/netfs_library.rst
+++ b/Documentation/filesystems/netfs_library.rst
@@ -71,11 +71,11 @@ Read Helper Functions
 Three read helpers are provided::
 
 	void netfs_readahead(struct readahead_control *ractl,
-			     const struct netfs_read_request_ops *ops,
+			     const struct netfs_request_ops *ops,
 			     void *netfs_priv);
 	int netfs_readpage(struct file *file,
 			   struct folio *folio,
-			   const struct netfs_read_request_ops *ops,
+			   const struct netfs_request_ops *ops,
 			   void *netfs_priv);
 	int netfs_write_begin(struct file *file,
 			      struct address_space *mapping,
@@ -84,7 +84,7 @@ Three read helpers are provided::
 			      unsigned int flags,
 			      struct folio **_folio,
 			      void **_fsdata,
-			      const struct netfs_read_request_ops *ops,
+			      const struct netfs_request_ops *ops,
 			      void *netfs_priv);
 
 Each corresponds to a VM operation, with the addition of a couple of parameters
@@ -116,7 +116,7 @@ occurs, the request will get partially completed if sufficient data is read.
 
 Additionally, there is::
 
-  * void netfs_subreq_terminated(struct netfs_read_subrequest *subreq,
+  * void netfs_subreq_terminated(struct netfs_io_subrequest *subreq,
 				 ssize_t transferred_or_error,
 				 bool was_async);
 
@@ -132,7 +132,7 @@ Read Helper Structures
 The read helpers make use of a couple of structures to maintain the state of
 the read.  The first is a structure that manages a read request as a whole::
 
-	struct netfs_read_request {
+	struct netfs_io_request {
 		struct inode		*inode;
 		struct address_space	*mapping;
 		struct netfs_cache_resources cache_resources;
@@ -140,7 +140,7 @@ the read.  The first is a structure that manages a read request as a whole::
 		loff_t			start;
 		size_t			len;
 		loff_t			i_size;
-		const struct netfs_read_request_ops *netfs_ops;
+		const struct netfs_request_ops *netfs_ops;
 		unsigned int		debug_id;
 		...
 	};
@@ -187,8 +187,8 @@ The above fields are the ones the netfs can use.  They are:
 The second structure is used to manage individual slices of the overall read
 request::
 
-	struct netfs_read_subrequest {
-		struct netfs_read_request *rreq;
+	struct netfs_io_subrequest {
+		struct netfs_io_request *rreq;
 		loff_t			start;
 		size_t			len;
 		size_t			transferred;
@@ -244,23 +244,23 @@ Read Helper Operations
 The network filesystem must provide the read helpers with a table of operations
 through which it can issue requests and negotiate::
 
-	struct netfs_read_request_ops {
-		void (*init_rreq)(struct netfs_read_request *rreq, struct file *file);
+	struct netfs_request_ops {
+		void (*init_request)(struct netfs_io_request *rreq, struct file *file);
 		bool (*is_cache_enabled)(struct inode *inode);
-		int (*begin_cache_operation)(struct netfs_read_request *rreq);
-		void (*expand_readahead)(struct netfs_read_request *rreq);
-		bool (*clamp_length)(struct netfs_read_subrequest *subreq);
-		void (*issue_op)(struct netfs_read_subrequest *subreq);
-		bool (*is_still_valid)(struct netfs_read_request *rreq);
+		int (*begin_cache_operation)(struct netfs_io_request *rreq);
+		void (*expand_readahead)(struct netfs_io_request *rreq);
+		bool (*clamp_length)(struct netfs_io_subrequest *subreq);
+		void (*issue_op)(struct netfs_io_subrequest *subreq);
+		bool (*is_still_valid)(struct netfs_io_request *rreq);
 		int (*check_write_begin)(struct file *file, loff_t pos, unsigned len,
 					 struct folio *folio, void **_fsdata);
-		void (*done)(struct netfs_read_request *rreq);
+		void (*done)(struct netfs_io_request *rreq);
 		void (*cleanup)(struct address_space *mapping, void *netfs_priv);
 	};
 
 The operations are as follows:
 
- * ``init_rreq()``
+ * ``init_request()``
 
    [Optional] This is called to initialise the request structure.  It is given
    the file for reference and can modify the ->netfs_priv value.
@@ -420,12 +420,12 @@ The network filesystem's ->begin_cache_operation() method is called to set up a
 cache and this must call into the cache to do the work.  If using fscache, for
 example, the cache would call::
 
-	int fscache_begin_read_operation(struct netfs_read_request *rreq,
+	int fscache_begin_read_operation(struct netfs_io_request *rreq,
 					 struct fscache_cookie *cookie);
 
 passing in the request pointer and the cookie corresponding to the file.
 
-The netfs_read_request object contains a place for the cache to hang its
+The netfs_io_request object contains a place for the cache to hang its
 state::
 
 	struct netfs_cache_resources {
@@ -443,7 +443,7 @@ operation table looks like the following::
 		void (*expand_readahead)(struct netfs_cache_resources *cres,
 					 loff_t *_start, size_t *_len, loff_t i_size);
 
-		enum netfs_read_source (*prepare_read)(struct netfs_read_subrequest *subreq,
+		enum netfs_io_source (*prepare_read)(struct netfs_io_subrequest *subreq,
 						       loff_t i_size);
 
 		int (*read)(struct netfs_cache_resources *cres,
diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 9a10e68c5f30..7b79fabe7593 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -31,9 +31,9 @@
  * v9fs_req_issue_op - Issue a read from 9P
  * @subreq: The read to make
  */
-static void v9fs_req_issue_op(struct netfs_read_subrequest *subreq)
+static void v9fs_req_issue_op(struct netfs_io_subrequest *subreq)
 {
-	struct netfs_read_request *rreq = subreq->rreq;
+	struct netfs_io_request *rreq = subreq->rreq;
 	struct p9_fid *fid = rreq->netfs_priv;
 	struct iov_iter to;
 	loff_t pos = subreq->start + subreq->transferred;
@@ -52,11 +52,11 @@ static void v9fs_req_issue_op(struct netfs_read_subrequest *subreq)
 }
 
 /**
- * v9fs_init_rreq - Initialise a read request
+ * v9fs_init_request - Initialise a read request
  * @rreq: The read request
  * @file: The file being read from
  */
-static void v9fs_init_rreq(struct netfs_read_request *rreq, struct file *file)
+static void v9fs_init_request(struct netfs_io_request *rreq, struct file *file)
 {
 	struct p9_fid *fid = file->private_data;
 
@@ -65,7 +65,7 @@ static void v9fs_init_rreq(struct netfs_read_request *rreq, struct file *file)
 }
 
 /**
- * v9fs_req_cleanup - Cleanup request initialized by v9fs_init_rreq
+ * v9fs_req_cleanup - Cleanup request initialized by v9fs_init_request
  * @mapping: unused mapping of request to cleanup
  * @priv: private data to cleanup, a fid, guaranted non-null.
  */
@@ -91,7 +91,7 @@ static bool v9fs_is_cache_enabled(struct inode *inode)
  * v9fs_begin_cache_operation - Begin a cache operation for a read
  * @rreq: The read request
  */
-static int v9fs_begin_cache_operation(struct netfs_read_request *rreq)
+static int v9fs_begin_cache_operation(struct netfs_io_request *rreq)
 {
 #ifdef CONFIG_9P_FSCACHE
 	struct fscache_cookie *cookie = v9fs_inode_cookie(V9FS_I(rreq->inode));
@@ -102,8 +102,8 @@ static int v9fs_begin_cache_operation(struct netfs_read_request *rreq)
 #endif
 }
 
-static const struct netfs_read_request_ops v9fs_req_ops = {
-	.init_rreq		= v9fs_init_rreq,
+static const struct netfs_request_ops v9fs_req_ops = {
+	.init_request		= v9fs_init_request,
 	.is_cache_enabled	= v9fs_is_cache_enabled,
 	.begin_cache_operation	= v9fs_begin_cache_operation,
 	.issue_op		= v9fs_req_issue_op,
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 720818a7c166..e55761f8858c 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -240,7 +240,7 @@ void afs_put_read(struct afs_read *req)
 static void afs_fetch_data_notify(struct afs_operation *op)
 {
 	struct afs_read *req = op->fetch.req;
-	struct netfs_read_subrequest *subreq = req->subreq;
+	struct netfs_io_subrequest *subreq = req->subreq;
 	int error = op->error;
 
 	if (error == -ECONNABORTED)
@@ -310,7 +310,7 @@ int afs_fetch_data(struct afs_vnode *vnode, struct afs_read *req)
 	return afs_do_sync_operation(op);
 }
 
-static void afs_req_issue_op(struct netfs_read_subrequest *subreq)
+static void afs_req_issue_op(struct netfs_io_subrequest *subreq)
 {
 	struct afs_vnode *vnode = AFS_FS_I(subreq->rreq->inode);
 	struct afs_read *fsreq;
@@ -359,7 +359,7 @@ static int afs_symlink_readpage(struct file *file, struct page *page)
 	return ret;
 }
 
-static void afs_init_rreq(struct netfs_read_request *rreq, struct file *file)
+static void afs_init_request(struct netfs_io_request *rreq, struct file *file)
 {
 	rreq->netfs_priv = key_get(afs_file_key(file));
 }
@@ -371,7 +371,7 @@ static bool afs_is_cache_enabled(struct inode *inode)
 	return fscache_cookie_enabled(cookie) && cookie->cache_priv;
 }
 
-static int afs_begin_cache_operation(struct netfs_read_request *rreq)
+static int afs_begin_cache_operation(struct netfs_io_request *rreq)
 {
 #ifdef CONFIG_AFS_FSCACHE
 	struct afs_vnode *vnode = AFS_FS_I(rreq->inode);
@@ -396,8 +396,8 @@ static void afs_priv_cleanup(struct address_space *mapping, void *netfs_priv)
 	key_put(netfs_priv);
 }
 
-const struct netfs_read_request_ops afs_req_ops = {
-	.init_rreq		= afs_init_rreq,
+const struct netfs_request_ops afs_req_ops = {
+	.init_request		= afs_init_request,
 	.is_cache_enabled	= afs_is_cache_enabled,
 	.begin_cache_operation	= afs_begin_cache_operation,
 	.check_write_begin	= afs_check_write_begin,
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index b6f02321fc09..c56a0e1719ae 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -207,7 +207,7 @@ struct afs_read {
 	loff_t			file_size;	/* File size returned by server */
 	struct key		*key;		/* The key to use to reissue the read */
 	struct afs_vnode	*vnode;		/* The file being read into. */
-	struct netfs_read_subrequest *subreq;	/* Fscache helper read request this belongs to */
+	struct netfs_io_subrequest *subreq;	/* Fscache helper read request this belongs to */
 	afs_dataversion_t	data_version;	/* Version number returned by server */
 	refcount_t		usage;
 	unsigned int		call_debug_id;
@@ -1063,7 +1063,7 @@ extern const struct address_space_operations afs_file_aops;
 extern const struct address_space_operations afs_symlink_aops;
 extern const struct inode_operations afs_file_inode_operations;
 extern const struct file_operations afs_file_operations;
-extern const struct netfs_read_request_ops afs_req_ops;
+extern const struct netfs_request_ops afs_req_ops;
 
 extern int afs_cache_wb_key(struct afs_vnode *, struct afs_file *);
 extern void afs_put_wb_key(struct afs_wb_key *);
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 753986ea1583..6ac6fdbc70d3 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -382,18 +382,18 @@ static int cachefiles_write(struct netfs_cache_resources *cres,
  * Prepare a read operation, shortening it to a cached/uncached
  * boundary as appropriate.
  */
-static enum netfs_read_source cachefiles_prepare_read(struct netfs_read_subrequest *subreq,
+static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *subreq,
 						      loff_t i_size)
 {
 	enum cachefiles_prepare_read_trace why;
-	struct netfs_read_request *rreq = subreq->rreq;
+	struct netfs_io_request *rreq = subreq->rreq;
 	struct netfs_cache_resources *cres = &rreq->cache_resources;
 	struct cachefiles_object *object;
 	struct cachefiles_cache *cache;
 	struct fscache_cookie *cookie = fscache_cres_cookie(cres);
 	const struct cred *saved_cred;
 	struct file *file = cachefiles_cres_file(cres);
-	enum netfs_read_source ret = NETFS_DOWNLOAD_FROM_SERVER;
+	enum netfs_io_source ret = NETFS_DOWNLOAD_FROM_SERVER;
 	loff_t off, to;
 	ino_t ino = file ? file_inode(file)->i_ino : 0;
 
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 46e0881ae8b2..9d995f351079 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -183,7 +183,7 @@ static int ceph_releasepage(struct page *page, gfp_t gfp)
 	return 1;
 }
 
-static void ceph_netfs_expand_readahead(struct netfs_read_request *rreq)
+static void ceph_netfs_expand_readahead(struct netfs_io_request *rreq)
 {
 	struct inode *inode = rreq->inode;
 	struct ceph_inode_info *ci = ceph_inode(inode);
@@ -200,7 +200,7 @@ static void ceph_netfs_expand_readahead(struct netfs_read_request *rreq)
 	rreq->len = roundup(rreq->len, lo->stripe_unit);
 }
 
-static bool ceph_netfs_clamp_length(struct netfs_read_subrequest *subreq)
+static bool ceph_netfs_clamp_length(struct netfs_io_subrequest *subreq)
 {
 	struct inode *inode = subreq->rreq->inode;
 	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
@@ -219,7 +219,7 @@ static void finish_netfs_read(struct ceph_osd_request *req)
 {
 	struct ceph_fs_client *fsc = ceph_inode_to_client(req->r_inode);
 	struct ceph_osd_data *osd_data = osd_req_op_extent_osd_data(req, 0);
-	struct netfs_read_subrequest *subreq = req->r_priv;
+	struct netfs_io_subrequest *subreq = req->r_priv;
 	int num_pages;
 	int err = req->r_result;
 
@@ -245,9 +245,9 @@ static void finish_netfs_read(struct ceph_osd_request *req)
 	iput(req->r_inode);
 }
 
-static bool ceph_netfs_issue_op_inline(struct netfs_read_subrequest *subreq)
+static bool ceph_netfs_issue_op_inline(struct netfs_io_subrequest *subreq)
 {
-	struct netfs_read_request *rreq = subreq->rreq;
+	struct netfs_io_request *rreq = subreq->rreq;
 	struct inode *inode = rreq->inode;
 	struct ceph_mds_reply_info_parsed *rinfo;
 	struct ceph_mds_reply_info_in *iinfo;
@@ -298,9 +298,9 @@ static bool ceph_netfs_issue_op_inline(struct netfs_read_subrequest *subreq)
 	return true;
 }
 
-static void ceph_netfs_issue_op(struct netfs_read_subrequest *subreq)
+static void ceph_netfs_issue_op(struct netfs_io_subrequest *subreq)
 {
-	struct netfs_read_request *rreq = subreq->rreq;
+	struct netfs_io_request *rreq = subreq->rreq;
 	struct inode *inode = rreq->inode;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
@@ -364,7 +364,7 @@ static void ceph_readahead_cleanup(struct address_space *mapping, void *priv)
 		ceph_put_cap_refs(ci, got);
 }
 
-static const struct netfs_read_request_ops ceph_netfs_read_ops = {
+static const struct netfs_request_ops ceph_netfs_read_ops = {
 	.is_cache_enabled	= ceph_is_cache_enabled,
 	.begin_cache_operation	= ceph_begin_cache_operation,
 	.issue_op		= ceph_netfs_issue_op,
diff --git a/fs/ceph/cache.h b/fs/ceph/cache.h
index 09164389fa66..b8b3b5cb6438 100644
--- a/fs/ceph/cache.h
+++ b/fs/ceph/cache.h
@@ -62,7 +62,7 @@ static inline int ceph_fscache_set_page_dirty(struct page *page)
 	return fscache_set_page_dirty(page, ceph_fscache_cookie(ci));
 }
 
-static inline int ceph_begin_cache_operation(struct netfs_read_request *rreq)
+static inline int ceph_begin_cache_operation(struct netfs_io_request *rreq)
 {
 	struct fscache_cookie *cookie = ceph_fscache_cookie(ceph_inode(rreq->inode));
 
@@ -143,7 +143,7 @@ static inline bool ceph_is_cache_enabled(struct inode *inode)
 	return false;
 }
 
-static inline int ceph_begin_cache_operation(struct netfs_read_request *rreq)
+static inline int ceph_begin_cache_operation(struct netfs_io_request *rreq)
 {
 	return -ENOBUFS;
 }
diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index 501da990c259..50035d93f1dc 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -28,23 +28,23 @@ module_param_named(debug, netfs_debug, uint, S_IWUSR | S_IRUGO);
 MODULE_PARM_DESC(netfs_debug, "Netfs support debugging mask");
 
 static void netfs_rreq_work(struct work_struct *);
-static void __netfs_put_subrequest(struct netfs_read_subrequest *, bool);
+static void __netfs_put_subrequest(struct netfs_io_subrequest *, bool);
 
-static void netfs_put_subrequest(struct netfs_read_subrequest *subreq,
+static void netfs_put_subrequest(struct netfs_io_subrequest *subreq,
 				 bool was_async)
 {
 	if (refcount_dec_and_test(&subreq->usage))
 		__netfs_put_subrequest(subreq, was_async);
 }
 
-static struct netfs_read_request *netfs_alloc_read_request(
-	const struct netfs_read_request_ops *ops, void *netfs_priv,
+static struct netfs_io_request *netfs_alloc_read_request(
+	const struct netfs_request_ops *ops, void *netfs_priv,
 	struct file *file)
 {
 	static atomic_t debug_ids;
-	struct netfs_read_request *rreq;
+	struct netfs_io_request *rreq;
 
-	rreq = kzalloc(sizeof(struct netfs_read_request), GFP_KERNEL);
+	rreq = kzalloc(sizeof(struct netfs_io_request), GFP_KERNEL);
 	if (rreq) {
 		rreq->netfs_ops	= ops;
 		rreq->netfs_priv = netfs_priv;
@@ -55,27 +55,27 @@ static struct netfs_read_request *netfs_alloc_read_request(
 		INIT_WORK(&rreq->work, netfs_rreq_work);
 		refcount_set(&rreq->usage, 1);
 		__set_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
-		if (ops->init_rreq)
-			ops->init_rreq(rreq, file);
+		if (ops->init_request)
+			ops->init_request(rreq, file);
 		netfs_stat(&netfs_n_rh_rreq);
 	}
 
 	return rreq;
 }
 
-static void netfs_get_read_request(struct netfs_read_request *rreq)
+static void netfs_get_read_request(struct netfs_io_request *rreq)
 {
 	refcount_inc(&rreq->usage);
 }
 
-static void netfs_rreq_clear_subreqs(struct netfs_read_request *rreq,
+static void netfs_rreq_clear_subreqs(struct netfs_io_request *rreq,
 				     bool was_async)
 {
-	struct netfs_read_subrequest *subreq;
+	struct netfs_io_subrequest *subreq;
 
 	while (!list_empty(&rreq->subrequests)) {
 		subreq = list_first_entry(&rreq->subrequests,
-					  struct netfs_read_subrequest, rreq_link);
+					  struct netfs_io_subrequest, rreq_link);
 		list_del(&subreq->rreq_link);
 		netfs_put_subrequest(subreq, was_async);
 	}
@@ -83,8 +83,8 @@ static void netfs_rreq_clear_subreqs(struct netfs_read_request *rreq,
 
 static void netfs_free_read_request(struct work_struct *work)
 {
-	struct netfs_read_request *rreq =
-		container_of(work, struct netfs_read_request, work);
+	struct netfs_io_request *rreq =
+		container_of(work, struct netfs_io_request, work);
 	netfs_rreq_clear_subreqs(rreq, false);
 	if (rreq->netfs_priv)
 		rreq->netfs_ops->cleanup(rreq->mapping, rreq->netfs_priv);
@@ -95,7 +95,7 @@ static void netfs_free_read_request(struct work_struct *work)
 	netfs_stat_d(&netfs_n_rh_rreq);
 }
 
-static void netfs_put_read_request(struct netfs_read_request *rreq, bool was_async)
+static void netfs_put_read_request(struct netfs_io_request *rreq, bool was_async)
 {
 	if (refcount_dec_and_test(&rreq->usage)) {
 		if (was_async) {
@@ -111,12 +111,12 @@ static void netfs_put_read_request(struct netfs_read_request *rreq, bool was_asy
 /*
  * Allocate and partially initialise an I/O request structure.
  */
-static struct netfs_read_subrequest *netfs_alloc_subrequest(
-	struct netfs_read_request *rreq)
+static struct netfs_io_subrequest *netfs_alloc_subrequest(
+	struct netfs_io_request *rreq)
 {
-	struct netfs_read_subrequest *subreq;
+	struct netfs_io_subrequest *subreq;
 
-	subreq = kzalloc(sizeof(struct netfs_read_subrequest), GFP_KERNEL);
+	subreq = kzalloc(sizeof(struct netfs_io_subrequest), GFP_KERNEL);
 	if (subreq) {
 		INIT_LIST_HEAD(&subreq->rreq_link);
 		refcount_set(&subreq->usage, 2);
@@ -128,15 +128,15 @@ static struct netfs_read_subrequest *netfs_alloc_subrequest(
 	return subreq;
 }
 
-static void netfs_get_read_subrequest(struct netfs_read_subrequest *subreq)
+static void netfs_get_read_subrequest(struct netfs_io_subrequest *subreq)
 {
 	refcount_inc(&subreq->usage);
 }
 
-static void __netfs_put_subrequest(struct netfs_read_subrequest *subreq,
+static void __netfs_put_subrequest(struct netfs_io_subrequest *subreq,
 				   bool was_async)
 {
-	struct netfs_read_request *rreq = subreq->rreq;
+	struct netfs_io_request *rreq = subreq->rreq;
 
 	trace_netfs_sreq(subreq, netfs_sreq_trace_free);
 	kfree(subreq);
@@ -147,7 +147,7 @@ static void __netfs_put_subrequest(struct netfs_read_subrequest *subreq,
 /*
  * Clear the unread part of an I/O request.
  */
-static void netfs_clear_unread(struct netfs_read_subrequest *subreq)
+static void netfs_clear_unread(struct netfs_io_subrequest *subreq)
 {
 	struct iov_iter iter;
 
@@ -160,7 +160,7 @@ static void netfs_clear_unread(struct netfs_read_subrequest *subreq)
 static void netfs_cache_read_terminated(void *priv, ssize_t transferred_or_error,
 					bool was_async)
 {
-	struct netfs_read_subrequest *subreq = priv;
+	struct netfs_io_subrequest *subreq = priv;
 
 	netfs_subreq_terminated(subreq, transferred_or_error, was_async);
 }
@@ -169,8 +169,8 @@ static void netfs_cache_read_terminated(void *priv, ssize_t transferred_or_error
  * Issue a read against the cache.
  * - Eats the caller's ref on subreq.
  */
-static void netfs_read_from_cache(struct netfs_read_request *rreq,
-				  struct netfs_read_subrequest *subreq,
+static void netfs_read_from_cache(struct netfs_io_request *rreq,
+				  struct netfs_io_subrequest *subreq,
 				  enum netfs_read_from_hole read_hole)
 {
 	struct netfs_cache_resources *cres = &rreq->cache_resources;
@@ -188,8 +188,8 @@ static void netfs_read_from_cache(struct netfs_read_request *rreq,
 /*
  * Fill a subrequest region with zeroes.
  */
-static void netfs_fill_with_zeroes(struct netfs_read_request *rreq,
-				   struct netfs_read_subrequest *subreq)
+static void netfs_fill_with_zeroes(struct netfs_io_request *rreq,
+				   struct netfs_io_subrequest *subreq)
 {
 	netfs_stat(&netfs_n_rh_zero);
 	__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
@@ -212,8 +212,8 @@ static void netfs_fill_with_zeroes(struct netfs_read_request *rreq,
  * - NETFS_SREQ_CLEAR_TAIL: A short read - the rest of the buffer will be
  *   cleared.
  */
-static void netfs_read_from_server(struct netfs_read_request *rreq,
-				   struct netfs_read_subrequest *subreq)
+static void netfs_read_from_server(struct netfs_io_request *rreq,
+				   struct netfs_io_subrequest *subreq)
 {
 	netfs_stat(&netfs_n_rh_download);
 	rreq->netfs_ops->issue_op(subreq);
@@ -222,7 +222,7 @@ static void netfs_read_from_server(struct netfs_read_request *rreq,
 /*
  * Release those waiting.
  */
-static void netfs_rreq_completed(struct netfs_read_request *rreq, bool was_async)
+static void netfs_rreq_completed(struct netfs_io_request *rreq, bool was_async)
 {
 	trace_netfs_rreq(rreq, netfs_rreq_trace_done);
 	netfs_rreq_clear_subreqs(rreq, was_async);
@@ -235,10 +235,10 @@ static void netfs_rreq_completed(struct netfs_read_request *rreq, bool was_async
  *
  * May be called in softirq mode and we inherit a ref from the caller.
  */
-static void netfs_rreq_unmark_after_write(struct netfs_read_request *rreq,
+static void netfs_rreq_unmark_after_write(struct netfs_io_request *rreq,
 					  bool was_async)
 {
-	struct netfs_read_subrequest *subreq;
+	struct netfs_io_subrequest *subreq;
 	struct folio *folio;
 	pgoff_t unlocked = 0;
 	bool have_unlocked = false;
@@ -267,8 +267,8 @@ static void netfs_rreq_unmark_after_write(struct netfs_read_request *rreq,
 static void netfs_rreq_copy_terminated(void *priv, ssize_t transferred_or_error,
 				       bool was_async)
 {
-	struct netfs_read_subrequest *subreq = priv;
-	struct netfs_read_request *rreq = subreq->rreq;
+	struct netfs_io_subrequest *subreq = priv;
+	struct netfs_io_request *rreq = subreq->rreq;
 
 	if (IS_ERR_VALUE(transferred_or_error)) {
 		netfs_stat(&netfs_n_rh_write_failed);
@@ -280,8 +280,8 @@ static void netfs_rreq_copy_terminated(void *priv, ssize_t transferred_or_error,
 
 	trace_netfs_sreq(subreq, netfs_sreq_trace_write_term);
 
-	/* If we decrement nr_wr_ops to 0, the ref belongs to us. */
-	if (atomic_dec_and_test(&rreq->nr_wr_ops))
+	/* If we decrement nr_copy_ops to 0, the ref belongs to us. */
+	if (atomic_dec_and_test(&rreq->nr_copy_ops))
 		netfs_rreq_unmark_after_write(rreq, was_async);
 
 	netfs_put_subrequest(subreq, was_async);
@@ -291,10 +291,10 @@ static void netfs_rreq_copy_terminated(void *priv, ssize_t transferred_or_error,
  * Perform any outstanding writes to the cache.  We inherit a ref from the
  * caller.
  */
-static void netfs_rreq_do_write_to_cache(struct netfs_read_request *rreq)
+static void netfs_rreq_do_write_to_cache(struct netfs_io_request *rreq)
 {
 	struct netfs_cache_resources *cres = &rreq->cache_resources;
-	struct netfs_read_subrequest *subreq, *next, *p;
+	struct netfs_io_subrequest *subreq, *next, *p;
 	struct iov_iter iter;
 	int ret;
 
@@ -303,7 +303,7 @@ static void netfs_rreq_do_write_to_cache(struct netfs_read_request *rreq)
 	/* We don't want terminating writes trying to wake us up whilst we're
 	 * still going through the list.
 	 */
-	atomic_inc(&rreq->nr_wr_ops);
+	atomic_inc(&rreq->nr_copy_ops);
 
 	list_for_each_entry_safe(subreq, p, &rreq->subrequests, rreq_link) {
 		if (!test_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags)) {
@@ -334,7 +334,7 @@ static void netfs_rreq_do_write_to_cache(struct netfs_read_request *rreq)
 		iov_iter_xarray(&iter, WRITE, &rreq->mapping->i_pages,
 				subreq->start, subreq->len);
 
-		atomic_inc(&rreq->nr_wr_ops);
+		atomic_inc(&rreq->nr_copy_ops);
 		netfs_stat(&netfs_n_rh_write);
 		netfs_get_read_subrequest(subreq);
 		trace_netfs_sreq(subreq, netfs_sreq_trace_write);
@@ -342,20 +342,20 @@ static void netfs_rreq_do_write_to_cache(struct netfs_read_request *rreq)
 				 netfs_rreq_copy_terminated, subreq);
 	}
 
-	/* If we decrement nr_wr_ops to 0, the usage ref belongs to us. */
-	if (atomic_dec_and_test(&rreq->nr_wr_ops))
+	/* If we decrement nr_copy_ops to 0, the usage ref belongs to us. */
+	if (atomic_dec_and_test(&rreq->nr_copy_ops))
 		netfs_rreq_unmark_after_write(rreq, false);
 }
 
 static void netfs_rreq_write_to_cache_work(struct work_struct *work)
 {
-	struct netfs_read_request *rreq =
-		container_of(work, struct netfs_read_request, work);
+	struct netfs_io_request *rreq =
+		container_of(work, struct netfs_io_request, work);
 
 	netfs_rreq_do_write_to_cache(rreq);
 }
 
-static void netfs_rreq_write_to_cache(struct netfs_read_request *rreq)
+static void netfs_rreq_write_to_cache(struct netfs_io_request *rreq)
 {
 	rreq->work.func = netfs_rreq_write_to_cache_work;
 	if (!queue_work(system_unbound_wq, &rreq->work))
@@ -366,9 +366,9 @@ static void netfs_rreq_write_to_cache(struct netfs_read_request *rreq)
  * Unlock the folios in a read operation.  We need to set PG_fscache on any
  * folios we're going to write back before we unlock them.
  */
-static void netfs_rreq_unlock(struct netfs_read_request *rreq)
+static void netfs_rreq_unlock(struct netfs_io_request *rreq)
 {
-	struct netfs_read_subrequest *subreq;
+	struct netfs_io_subrequest *subreq;
 	struct folio *folio;
 	unsigned int iopos, account = 0;
 	pgoff_t start_page = rreq->start / PAGE_SIZE;
@@ -391,7 +391,7 @@ static void netfs_rreq_unlock(struct netfs_read_request *rreq)
 	 * mixture inside.
 	 */
 	subreq = list_first_entry(&rreq->subrequests,
-				  struct netfs_read_subrequest, rreq_link);
+				  struct netfs_io_subrequest, rreq_link);
 	iopos = 0;
 	subreq_failed = (subreq->error < 0);
 
@@ -450,8 +450,8 @@ static void netfs_rreq_unlock(struct netfs_read_request *rreq)
 /*
  * Handle a short read.
  */
-static void netfs_rreq_short_read(struct netfs_read_request *rreq,
-				  struct netfs_read_subrequest *subreq)
+static void netfs_rreq_short_read(struct netfs_io_request *rreq,
+				  struct netfs_io_subrequest *subreq)
 {
 	__clear_bit(NETFS_SREQ_SHORT_READ, &subreq->flags);
 	__set_bit(NETFS_SREQ_SEEK_DATA_READ, &subreq->flags);
@@ -460,7 +460,7 @@ static void netfs_rreq_short_read(struct netfs_read_request *rreq,
 	trace_netfs_sreq(subreq, netfs_sreq_trace_resubmit_short);
 
 	netfs_get_read_subrequest(subreq);
-	atomic_inc(&rreq->nr_rd_ops);
+	atomic_inc(&rreq->nr_outstanding);
 	if (subreq->source == NETFS_READ_FROM_CACHE)
 		netfs_read_from_cache(rreq, subreq, NETFS_READ_HOLE_CLEAR);
 	else
@@ -471,9 +471,9 @@ static void netfs_rreq_short_read(struct netfs_read_request *rreq,
  * Resubmit any short or failed operations.  Returns true if we got the rreq
  * ref back.
  */
-static bool netfs_rreq_perform_resubmissions(struct netfs_read_request *rreq)
+static bool netfs_rreq_perform_resubmissions(struct netfs_io_request *rreq)
 {
-	struct netfs_read_subrequest *subreq;
+	struct netfs_io_subrequest *subreq;
 
 	WARN_ON(in_interrupt());
 
@@ -482,7 +482,7 @@ static bool netfs_rreq_perform_resubmissions(struct netfs_read_request *rreq)
 	/* We don't want terminating submissions trying to wake us up whilst
 	 * we're still going through the list.
 	 */
-	atomic_inc(&rreq->nr_rd_ops);
+	atomic_inc(&rreq->nr_outstanding);
 
 	__clear_bit(NETFS_RREQ_INCOMPLETE_IO, &rreq->flags);
 	list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
@@ -494,27 +494,27 @@ static bool netfs_rreq_perform_resubmissions(struct netfs_read_request *rreq)
 			netfs_stat(&netfs_n_rh_download_instead);
 			trace_netfs_sreq(subreq, netfs_sreq_trace_download_instead);
 			netfs_get_read_subrequest(subreq);
-			atomic_inc(&rreq->nr_rd_ops);
+			atomic_inc(&rreq->nr_outstanding);
 			netfs_read_from_server(rreq, subreq);
 		} else if (test_bit(NETFS_SREQ_SHORT_READ, &subreq->flags)) {
 			netfs_rreq_short_read(rreq, subreq);
 		}
 	}
 
-	/* If we decrement nr_rd_ops to 0, the usage ref belongs to us. */
-	if (atomic_dec_and_test(&rreq->nr_rd_ops))
+	/* If we decrement nr_outstanding to 0, the usage ref belongs to us. */
+	if (atomic_dec_and_test(&rreq->nr_outstanding))
 		return true;
 
-	wake_up_var(&rreq->nr_rd_ops);
+	wake_up_var(&rreq->nr_outstanding);
 	return false;
 }
 
 /*
  * Check to see if the data read is still valid.
  */
-static void netfs_rreq_is_still_valid(struct netfs_read_request *rreq)
+static void netfs_rreq_is_still_valid(struct netfs_io_request *rreq)
 {
-	struct netfs_read_subrequest *subreq;
+	struct netfs_io_subrequest *subreq;
 
 	if (!rreq->netfs_ops->is_still_valid ||
 	    rreq->netfs_ops->is_still_valid(rreq))
@@ -534,7 +534,7 @@ static void netfs_rreq_is_still_valid(struct netfs_read_request *rreq)
  * Note that we could be in an ordinary kernel thread, on a workqueue or in
  * softirq context at this point.  We inherit a ref from the caller.
  */
-static void netfs_rreq_assess(struct netfs_read_request *rreq, bool was_async)
+static void netfs_rreq_assess(struct netfs_io_request *rreq, bool was_async)
 {
 	trace_netfs_rreq(rreq, netfs_rreq_trace_assess);
 
@@ -561,8 +561,8 @@ static void netfs_rreq_assess(struct netfs_read_request *rreq, bool was_async)
 
 static void netfs_rreq_work(struct work_struct *work)
 {
-	struct netfs_read_request *rreq =
-		container_of(work, struct netfs_read_request, work);
+	struct netfs_io_request *rreq =
+		container_of(work, struct netfs_io_request, work);
 	netfs_rreq_assess(rreq, false);
 }
 
@@ -570,7 +570,7 @@ static void netfs_rreq_work(struct work_struct *work)
  * Handle the completion of all outstanding I/O operations on a read request.
  * We inherit a ref from the caller.
  */
-static void netfs_rreq_terminated(struct netfs_read_request *rreq,
+static void netfs_rreq_terminated(struct netfs_io_request *rreq,
 				  bool was_async)
 {
 	if (test_bit(NETFS_RREQ_INCOMPLETE_IO, &rreq->flags) &&
@@ -600,11 +600,11 @@ static void netfs_rreq_terminated(struct netfs_read_request *rreq,
  * If @was_async is true, the caller might be running in softirq or interrupt
  * context and we can't sleep.
  */
-void netfs_subreq_terminated(struct netfs_read_subrequest *subreq,
+void netfs_subreq_terminated(struct netfs_io_subrequest *subreq,
 			     ssize_t transferred_or_error,
 			     bool was_async)
 {
-	struct netfs_read_request *rreq = subreq->rreq;
+	struct netfs_io_request *rreq = subreq->rreq;
 	int u;
 
 	_enter("[%u]{%llx,%lx},%zd",
@@ -648,12 +648,12 @@ void netfs_subreq_terminated(struct netfs_read_subrequest *subreq,
 out:
 	trace_netfs_sreq(subreq, netfs_sreq_trace_terminated);
 
-	/* If we decrement nr_rd_ops to 0, the ref belongs to us. */
-	u = atomic_dec_return(&rreq->nr_rd_ops);
+	/* If we decrement nr_outstanding to 0, the ref belongs to us. */
+	u = atomic_dec_return(&rreq->nr_outstanding);
 	if (u == 0)
 		netfs_rreq_terminated(rreq, was_async);
 	else if (u == 1)
-		wake_up_var(&rreq->nr_rd_ops);
+		wake_up_var(&rreq->nr_outstanding);
 
 	netfs_put_subrequest(subreq, was_async);
 	return;
@@ -691,10 +691,10 @@ void netfs_subreq_terminated(struct netfs_read_subrequest *subreq,
 }
 EXPORT_SYMBOL(netfs_subreq_terminated);
 
-static enum netfs_read_source netfs_cache_prepare_read(struct netfs_read_subrequest *subreq,
+static enum netfs_io_source netfs_cache_prepare_read(struct netfs_io_subrequest *subreq,
 						       loff_t i_size)
 {
-	struct netfs_read_request *rreq = subreq->rreq;
+	struct netfs_io_request *rreq = subreq->rreq;
 	struct netfs_cache_resources *cres = &rreq->cache_resources;
 
 	if (cres->ops)
@@ -707,11 +707,11 @@ static enum netfs_read_source netfs_cache_prepare_read(struct netfs_read_subrequ
 /*
  * Work out what sort of subrequest the next one will be.
  */
-static enum netfs_read_source
-netfs_rreq_prepare_read(struct netfs_read_request *rreq,
-			struct netfs_read_subrequest *subreq)
+static enum netfs_io_source
+netfs_rreq_prepare_read(struct netfs_io_request *rreq,
+			struct netfs_io_subrequest *subreq)
 {
-	enum netfs_read_source source;
+	enum netfs_io_source source;
 
 	_enter("%llx-%llx,%llx", subreq->start, subreq->start + subreq->len, rreq->i_size);
 
@@ -748,11 +748,11 @@ netfs_rreq_prepare_read(struct netfs_read_request *rreq,
 /*
  * Slice off a piece of a read request and submit an I/O request for it.
  */
-static bool netfs_rreq_submit_slice(struct netfs_read_request *rreq,
+static bool netfs_rreq_submit_slice(struct netfs_io_request *rreq,
 				    unsigned int *_debug_index)
 {
-	struct netfs_read_subrequest *subreq;
-	enum netfs_read_source source;
+	struct netfs_io_subrequest *subreq;
+	enum netfs_io_source source;
 
 	subreq = netfs_alloc_subrequest(rreq);
 	if (!subreq)
@@ -777,7 +777,7 @@ static bool netfs_rreq_submit_slice(struct netfs_read_request *rreq,
 	if (source == NETFS_INVALID_READ)
 		goto subreq_failed;
 
-	atomic_inc(&rreq->nr_rd_ops);
+	atomic_inc(&rreq->nr_outstanding);
 
 	rreq->submitted += subreq->len;
 
@@ -804,7 +804,7 @@ static bool netfs_rreq_submit_slice(struct netfs_read_request *rreq,
 	return false;
 }
 
-static void netfs_cache_expand_readahead(struct netfs_read_request *rreq,
+static void netfs_cache_expand_readahead(struct netfs_io_request *rreq,
 					 loff_t *_start, size_t *_len, loff_t i_size)
 {
 	struct netfs_cache_resources *cres = &rreq->cache_resources;
@@ -813,7 +813,7 @@ static void netfs_cache_expand_readahead(struct netfs_read_request *rreq,
 		cres->ops->expand_readahead(cres, _start, _len, i_size);
 }
 
-static void netfs_rreq_expand(struct netfs_read_request *rreq,
+static void netfs_rreq_expand(struct netfs_io_request *rreq,
 			      struct readahead_control *ractl)
 {
 	/* Give the cache a chance to change the request parameters.  The
@@ -866,10 +866,10 @@ static void netfs_rreq_expand(struct netfs_read_request *rreq,
  * This is usable whether or not caching is enabled.
  */
 void netfs_readahead(struct readahead_control *ractl,
-		     const struct netfs_read_request_ops *ops,
+		     const struct netfs_request_ops *ops,
 		     void *netfs_priv)
 {
-	struct netfs_read_request *rreq;
+	struct netfs_io_request *rreq;
 	unsigned int debug_index = 0;
 	int ret;
 
@@ -897,7 +897,7 @@ void netfs_readahead(struct readahead_control *ractl,
 
 	netfs_rreq_expand(rreq, ractl);
 
-	atomic_set(&rreq->nr_rd_ops, 1);
+	atomic_set(&rreq->nr_outstanding, 1);
 	do {
 		if (!netfs_rreq_submit_slice(rreq, &debug_index))
 			break;
@@ -910,8 +910,8 @@ void netfs_readahead(struct readahead_control *ractl,
 	while (readahead_folio(ractl))
 		;
 
-	/* If we decrement nr_rd_ops to 0, the ref belongs to us. */
-	if (atomic_dec_and_test(&rreq->nr_rd_ops))
+	/* If we decrement nr_outstanding to 0, the ref belongs to us. */
+	if (atomic_dec_and_test(&rreq->nr_outstanding))
 		netfs_rreq_assess(rreq, false);
 	return;
 
@@ -944,10 +944,10 @@ EXPORT_SYMBOL(netfs_readahead);
  */
 int netfs_readpage(struct file *file,
 		   struct folio *folio,
-		   const struct netfs_read_request_ops *ops,
+		   const struct netfs_request_ops *ops,
 		   void *netfs_priv)
 {
-	struct netfs_read_request *rreq;
+	struct netfs_io_request *rreq;
 	unsigned int debug_index = 0;
 	int ret;
 
@@ -977,19 +977,19 @@ int netfs_readpage(struct file *file,
 
 	netfs_get_read_request(rreq);
 
-	atomic_set(&rreq->nr_rd_ops, 1);
+	atomic_set(&rreq->nr_outstanding, 1);
 	do {
 		if (!netfs_rreq_submit_slice(rreq, &debug_index))
 			break;
 
 	} while (rreq->submitted < rreq->len);
 
-	/* Keep nr_rd_ops incremented so that the ref always belongs to us, and
+	/* Keep nr_outstanding incremented so that the ref always belongs to us, and
 	 * the service code isn't punted off to a random thread pool to
 	 * process.
 	 */
 	do {
-		wait_var_event(&rreq->nr_rd_ops, atomic_read(&rreq->nr_rd_ops) == 1);
+		wait_var_event(&rreq->nr_outstanding, atomic_read(&rreq->nr_outstanding) == 1);
 		netfs_rreq_assess(rreq, false);
 	} while (test_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags));
 
@@ -1076,10 +1076,10 @@ static bool netfs_skip_folio_read(struct folio *folio, loff_t pos, size_t len)
 int netfs_write_begin(struct file *file, struct address_space *mapping,
 		      loff_t pos, unsigned int len, unsigned int aop_flags,
 		      struct folio **_folio, void **_fsdata,
-		      const struct netfs_read_request_ops *ops,
+		      const struct netfs_request_ops *ops,
 		      void *netfs_priv)
 {
-	struct netfs_read_request *rreq;
+	struct netfs_io_request *rreq;
 	struct folio *folio;
 	struct inode *inode = file_inode(file);
 	unsigned int debug_index = 0, fgp_flags;
@@ -1153,19 +1153,19 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
 	while (readahead_folio(&ractl))
 		;
 
-	atomic_set(&rreq->nr_rd_ops, 1);
+	atomic_set(&rreq->nr_outstanding, 1);
 	do {
 		if (!netfs_rreq_submit_slice(rreq, &debug_index))
 			break;
 
 	} while (rreq->submitted < rreq->len);
 
-	/* Keep nr_rd_ops incremented so that the ref always belongs to us, and
+	/* Keep nr_outstanding incremented so that the ref always belongs to us, and
 	 * the service code isn't punted off to a random thread pool to
 	 * process.
 	 */
 	for (;;) {
-		wait_var_event(&rreq->nr_rd_ops, atomic_read(&rreq->nr_rd_ops) == 1);
+		wait_var_event(&rreq->nr_outstanding, atomic_read(&rreq->nr_outstanding) == 1);
 		netfs_rreq_assess(rreq, false);
 		if (!test_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags))
 			break;
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 614f22213e21..a2ca91cb7a68 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -106,7 +106,7 @@ static inline int wait_on_page_fscache_killable(struct page *page)
 	return folio_wait_private_2_killable(page_folio(page));
 }
 
-enum netfs_read_source {
+enum netfs_io_source {
 	NETFS_FILL_WITH_ZEROES,
 	NETFS_DOWNLOAD_FROM_SERVER,
 	NETFS_READ_FROM_CACHE,
@@ -130,8 +130,8 @@ struct netfs_cache_resources {
 /*
  * Descriptor for a single component subrequest.
  */
-struct netfs_read_subrequest {
-	struct netfs_read_request *rreq;	/* Supervising read request */
+struct netfs_io_subrequest {
+	struct netfs_io_request *rreq;	/* Supervising read request */
 	struct list_head	rreq_link;	/* Link in rreq->subrequests */
 	loff_t			start;		/* Where to start the I/O */
 	size_t			len;		/* Size of the I/O */
@@ -139,7 +139,7 @@ struct netfs_read_subrequest {
 	refcount_t		usage;
 	short			error;		/* 0 or error that occurred */
 	unsigned short		debug_index;	/* Index in list (for debugging output) */
-	enum netfs_read_source	source;		/* Where to read from */
+	enum netfs_io_source	source;		/* Where to read from */
 	unsigned long		flags;
 #define NETFS_SREQ_WRITE_TO_CACHE	0	/* Set if should write to cache */
 #define NETFS_SREQ_CLEAR_TAIL		1	/* Set if the rest of the read should be cleared */
@@ -152,7 +152,7 @@ struct netfs_read_subrequest {
  * Descriptor for a read helper request.  This is used to make multiple I/O
  * requests on a variety of sources and then stitch the result together.
  */
-struct netfs_read_request {
+struct netfs_io_request {
 	struct work_struct	work;
 	struct inode		*inode;		/* The file being accessed */
 	struct address_space	*mapping;	/* The mapping being accessed */
@@ -160,8 +160,8 @@ struct netfs_read_request {
 	struct list_head	subrequests;	/* Requests to fetch I/O from disk or net */
 	void			*netfs_priv;	/* Private data for the netfs */
 	unsigned int		debug_id;
-	atomic_t		nr_rd_ops;	/* Number of read ops in progress */
-	atomic_t		nr_wr_ops;	/* Number of write ops in progress */
+	atomic_t		nr_outstanding;	/* Number of read ops in progress */
+	atomic_t		nr_copy_ops;	/* Number of write ops in progress */
 	size_t			submitted;	/* Amount submitted for I/O so far */
 	size_t			len;		/* Length of the request */
 	short			error;		/* 0 or error that occurred */
@@ -176,23 +176,23 @@ struct netfs_read_request {
 #define NETFS_RREQ_DONT_UNLOCK_FOLIOS	3	/* Don't unlock the folios on completion */
 #define NETFS_RREQ_FAILED		4	/* The request failed */
 #define NETFS_RREQ_IN_PROGRESS		5	/* Unlocked when the request completes */
-	const struct netfs_read_request_ops *netfs_ops;
+	const struct netfs_request_ops *netfs_ops;
 };
 
 /*
  * Operations the network filesystem can/must provide to the helpers.
  */
-struct netfs_read_request_ops {
+struct netfs_request_ops {
 	bool (*is_cache_enabled)(struct inode *inode);
-	void (*init_rreq)(struct netfs_read_request *rreq, struct file *file);
-	int (*begin_cache_operation)(struct netfs_read_request *rreq);
-	void (*expand_readahead)(struct netfs_read_request *rreq);
-	bool (*clamp_length)(struct netfs_read_subrequest *subreq);
-	void (*issue_op)(struct netfs_read_subrequest *subreq);
-	bool (*is_still_valid)(struct netfs_read_request *rreq);
+	void (*init_request)(struct netfs_io_request *rreq, struct file *file);
+	int (*begin_cache_operation)(struct netfs_io_request *rreq);
+	void (*expand_readahead)(struct netfs_io_request *rreq);
+	bool (*clamp_length)(struct netfs_io_subrequest *subreq);
+	void (*issue_op)(struct netfs_io_subrequest *subreq);
+	bool (*is_still_valid)(struct netfs_io_request *rreq);
 	int (*check_write_begin)(struct file *file, loff_t pos, unsigned len,
 				 struct folio *folio, void **_fsdata);
-	void (*done)(struct netfs_read_request *rreq);
+	void (*done)(struct netfs_io_request *rreq);
 	void (*cleanup)(struct address_space *mapping, void *netfs_priv);
 };
 
@@ -235,7 +235,7 @@ struct netfs_cache_ops {
 	/* Prepare a read operation, shortening it to a cached/uncached
 	 * boundary as appropriate.
 	 */
-	enum netfs_read_source (*prepare_read)(struct netfs_read_subrequest *subreq,
+	enum netfs_io_source (*prepare_read)(struct netfs_io_subrequest *subreq,
 					       loff_t i_size);
 
 	/* Prepare a write operation, working out what part of the write we can
@@ -255,19 +255,19 @@ struct netfs_cache_ops {
 
 struct readahead_control;
 extern void netfs_readahead(struct readahead_control *,
-			    const struct netfs_read_request_ops *,
+			    const struct netfs_request_ops *,
 			    void *);
 extern int netfs_readpage(struct file *,
 			  struct folio *,
-			  const struct netfs_read_request_ops *,
+			  const struct netfs_request_ops *,
 			  void *);
 extern int netfs_write_begin(struct file *, struct address_space *,
 			     loff_t, unsigned int, unsigned int, struct folio **,
 			     void **,
-			     const struct netfs_read_request_ops *,
+			     const struct netfs_request_ops *,
 			     void *);
 
-extern void netfs_subreq_terminated(struct netfs_read_subrequest *, ssize_t, bool);
+extern void netfs_subreq_terminated(struct netfs_io_subrequest *, ssize_t, bool);
 extern void netfs_stats_show(struct seq_file *);
 
 #endif /* _LINUX_NETFS_H */
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index c6f5aa74db89..002d0ae4f9bc 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -424,8 +424,8 @@ TRACE_EVENT(cachefiles_vol_coherency,
 	    );
 
 TRACE_EVENT(cachefiles_prep_read,
-	    TP_PROTO(struct netfs_read_subrequest *sreq,
-		     enum netfs_read_source source,
+	    TP_PROTO(struct netfs_io_subrequest *sreq,
+		     enum netfs_io_source source,
 		     enum cachefiles_prepare_read_trace why,
 		     ino_t cache_inode),
 
@@ -435,7 +435,7 @@ TRACE_EVENT(cachefiles_prep_read,
 		    __field(unsigned int,		rreq		)
 		    __field(unsigned short,		index		)
 		    __field(unsigned short,		flags		)
-		    __field(enum netfs_read_source,	source		)
+		    __field(enum netfs_io_source,	source		)
 		    __field(enum cachefiles_prepare_read_trace,	why	)
 		    __field(size_t,			len		)
 		    __field(loff_t,			start		)
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 88d9a74dd346..2d0665b416bf 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -94,7 +94,7 @@ netfs_failures;
 #define E_(a, b)	{ a, b }
 
 TRACE_EVENT(netfs_read,
-	    TP_PROTO(struct netfs_read_request *rreq,
+	    TP_PROTO(struct netfs_io_request *rreq,
 		     loff_t start, size_t len,
 		     enum netfs_read_trace what),
 
@@ -127,7 +127,7 @@ TRACE_EVENT(netfs_read,
 	    );
 
 TRACE_EVENT(netfs_rreq,
-	    TP_PROTO(struct netfs_read_request *rreq,
+	    TP_PROTO(struct netfs_io_request *rreq,
 		     enum netfs_rreq_trace what),
 
 	    TP_ARGS(rreq, what),
@@ -151,7 +151,7 @@ TRACE_EVENT(netfs_rreq,
 	    );
 
 TRACE_EVENT(netfs_sreq,
-	    TP_PROTO(struct netfs_read_subrequest *sreq,
+	    TP_PROTO(struct netfs_io_subrequest *sreq,
 		     enum netfs_sreq_trace what),
 
 	    TP_ARGS(sreq, what),
@@ -161,7 +161,7 @@ TRACE_EVENT(netfs_sreq,
 		    __field(unsigned short,		index		)
 		    __field(short,			error		)
 		    __field(unsigned short,		flags		)
-		    __field(enum netfs_read_source,	source		)
+		    __field(enum netfs_io_source,	source		)
 		    __field(enum netfs_sreq_trace,	what		)
 		    __field(size_t,			len		)
 		    __field(size_t,			transferred	)
@@ -190,8 +190,8 @@ TRACE_EVENT(netfs_sreq,
 	    );
 
 TRACE_EVENT(netfs_failure,
-	    TP_PROTO(struct netfs_read_request *rreq,
-		     struct netfs_read_subrequest *sreq,
+	    TP_PROTO(struct netfs_io_request *rreq,
+		     struct netfs_io_subrequest *sreq,
 		     int error, enum netfs_failure what),
 
 	    TP_ARGS(rreq, sreq, error, what),
@@ -201,7 +201,7 @@ TRACE_EVENT(netfs_failure,
 		    __field(unsigned short,		index		)
 		    __field(short,			error		)
 		    __field(unsigned short,		flags		)
-		    __field(enum netfs_read_source,	source		)
+		    __field(enum netfs_io_source,	source		)
 		    __field(enum netfs_failure,		what		)
 		    __field(size_t,			len		)
 		    __field(size_t,			transferred	)


