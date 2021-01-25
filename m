Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7E1302F3C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jan 2021 23:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732487AbhAYWmH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jan 2021 17:42:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36475 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732883AbhAYVfe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 16:35:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611610446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LnEtYBUhzI3CX1vikJ0e0ojAT0Lczz7YWxs9VcDeUYY=;
        b=ibo0NIDW0Crk/tIiyo627eGdFrnZaeW4MQ5tJL48GeUrz64JxJisa0pPMftjlMC0a4ZP3X
        dkdiCoW1EModSSidOLGhBiDF4/nOm+S7Y1TZErurhdeCeW8Pa63qhq8OXLZg36pTi3WolI
        RK06IFCmOGmR7jwpS9tNSOuCpm80WjU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-abmkHp3HOgmS_FnGCNOCQg-1; Mon, 25 Jan 2021 16:34:02 -0500
X-MC-Unique: abmkHp3HOgmS_FnGCNOCQg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC44218C89C4;
        Mon, 25 Jan 2021 21:34:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3289E60C47;
        Mon, 25 Jan 2021 21:33:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 15/32] afs: Move key to afs_read struct
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 25 Jan 2021 21:33:53 +0000
Message-ID: <161161043340.2537118.511899217704140722.stgit@warthog.procyon.org.uk>
In-Reply-To: <161161025063.2537118.2009249444682241405.stgit@warthog.procyon.org.uk>
References: <161161025063.2537118.2009249444682241405.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Stash the key used to authenticate read operations in the afs_read struct.
This will be necessary to reissue the operation against the server if a
read from the cache fails in upcoming cache changes.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/dir.c      |    3 ++-
 fs/afs/file.c     |   16 +++++++++-------
 fs/afs/internal.h |    3 ++-
 fs/afs/write.c    |   12 ++++++------
 4 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 7bd659ad959e..96e9e2e60d97 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -241,6 +241,7 @@ static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct key *key)
 		return ERR_PTR(-ENOMEM);
 
 	refcount_set(&req->usage, 1);
+	req->key = key_get(key);
 	req->nr_pages = nr_pages;
 	req->actual_len = i_size; /* May change */
 	req->len = nr_pages * PAGE_SIZE; /* We can ask for more than there is */
@@ -305,7 +306,7 @@ static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct key *key)
 
 	if (!test_bit(AFS_VNODE_DIR_VALID, &dvnode->flags)) {
 		trace_afs_reload_dir(dvnode);
-		ret = afs_fetch_data(dvnode, key, req);
+		ret = afs_fetch_data(dvnode, req);
 		if (ret < 0)
 			goto error_unlock;
 
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 21868bfc3a44..d23192b3b933 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -199,6 +199,7 @@ void afs_put_read(struct afs_read *req)
 			if (req->pages != req->array)
 				kfree(req->pages);
 		}
+		key_put(req->key);
 		kfree(req);
 	}
 }
@@ -229,7 +230,7 @@ static const struct afs_operation_ops afs_fetch_data_operation = {
 /*
  * Fetch file data from the volume.
  */
-int afs_fetch_data(struct afs_vnode *vnode, struct key *key, struct afs_read *req)
+int afs_fetch_data(struct afs_vnode *vnode, struct afs_read *req)
 {
 	struct afs_operation *op;
 
@@ -238,9 +239,9 @@ int afs_fetch_data(struct afs_vnode *vnode, struct key *key, struct afs_read *re
 	       vnode->fid.vid,
 	       vnode->fid.vnode,
 	       vnode->fid.unique,
-	       key_serial(key));
+	       key_serial(req->key));
 
-	op = afs_alloc_operation(key, vnode->volume);
+	op = afs_alloc_operation(req->key, vnode->volume);
 	if (IS_ERR(op))
 		return PTR_ERR(op);
 
@@ -279,6 +280,7 @@ int afs_page_filler(void *data, struct page *page)
 	 * unmarshalling code will clear the unfilled space.
 	 */
 	refcount_set(&req->usage, 1);
+	req->key = key_get(key);
 	req->pos = (loff_t)page->index << PAGE_SHIFT;
 	req->len = PAGE_SIZE;
 	req->nr_pages = 1;
@@ -288,7 +290,7 @@ int afs_page_filler(void *data, struct page *page)
 
 	/* read the contents of the file from the server into the
 	 * page */
-	ret = afs_fetch_data(vnode, key, req);
+	ret = afs_fetch_data(vnode, req);
 	afs_put_read(req);
 
 	if (ret < 0) {
@@ -373,7 +375,6 @@ static int afs_readpages_one(struct file *file, struct address_space *mapping,
 	struct afs_read *req;
 	struct list_head *p;
 	struct page *first, *page;
-	struct key *key = afs_file_key(file);
 	pgoff_t index;
 	int ret, n, i;
 
@@ -397,6 +398,7 @@ static int afs_readpages_one(struct file *file, struct address_space *mapping,
 
 	refcount_set(&req->usage, 1);
 	req->vnode = vnode;
+	req->key = key_get(afs_file_key(file));
 	req->page_done = afs_readpages_page_done;
 	req->pos = first->index;
 	req->pos <<= PAGE_SHIFT;
@@ -426,11 +428,11 @@ static int afs_readpages_one(struct file *file, struct address_space *mapping,
 	} while (req->nr_pages < n);
 
 	if (req->nr_pages == 0) {
-		kfree(req);
+		afs_put_read(req);
 		return 0;
 	}
 
-	ret = afs_fetch_data(vnode, key, req);
+	ret = afs_fetch_data(vnode, req);
 	if (ret < 0)
 		goto error;
 
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index cd545e7dbfb8..4b255d10f726 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -204,6 +204,7 @@ struct afs_read {
 	loff_t			actual_len;	/* How much we're actually getting */
 	loff_t			remain;		/* Amount remaining */
 	loff_t			file_size;	/* File size returned by server */
+	struct key		*key;		/* The key to use to reissue the read */
 	afs_dataversion_t	data_version;	/* Version number returned by server */
 	refcount_t		usage;
 	unsigned int		index;		/* Which page we're reading into */
@@ -1045,7 +1046,7 @@ extern int afs_cache_wb_key(struct afs_vnode *, struct afs_file *);
 extern void afs_put_wb_key(struct afs_wb_key *);
 extern int afs_open(struct inode *, struct file *);
 extern int afs_release(struct inode *, struct file *);
-extern int afs_fetch_data(struct afs_vnode *, struct key *, struct afs_read *);
+extern int afs_fetch_data(struct afs_vnode *, struct afs_read *);
 extern int afs_page_filler(void *, struct page *);
 extern void afs_put_read(struct afs_read *);
 
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 9d0cef35ecba..7eba0d3201ba 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -25,9 +25,10 @@ int afs_set_page_dirty(struct page *page)
 /*
  * partly or wholly fill a page that's under preparation for writing
  */
-static int afs_fill_page(struct afs_vnode *vnode, struct key *key,
+static int afs_fill_page(struct file *file,
 			 loff_t pos, unsigned int len, struct page *page)
 {
+	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
 	struct afs_read *req;
 	size_t p;
 	void *data;
@@ -49,6 +50,7 @@ static int afs_fill_page(struct afs_vnode *vnode, struct key *key,
 		return -ENOMEM;
 
 	refcount_set(&req->usage, 1);
+	req->key = key_get(afs_file_key(file));
 	req->pos = pos;
 	req->len = len;
 	req->nr_pages = 1;
@@ -56,7 +58,7 @@ static int afs_fill_page(struct afs_vnode *vnode, struct key *key,
 	req->pages[0] = page;
 	get_page(page);
 
-	ret = afs_fetch_data(vnode, key, req);
+	ret = afs_fetch_data(vnode, req);
 	afs_put_read(req);
 	if (ret < 0) {
 		if (ret == -ENOENT) {
@@ -80,7 +82,6 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
 {
 	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
 	struct page *page;
-	struct key *key = afs_file_key(file);
 	unsigned long priv;
 	unsigned f, from = pos & (PAGE_SIZE - 1);
 	unsigned t, to = from + len;
@@ -95,7 +96,7 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
 		return -ENOMEM;
 
 	if (!PageUptodate(page) && len != PAGE_SIZE) {
-		ret = afs_fill_page(vnode, key, pos & PAGE_MASK, PAGE_SIZE, page);
+		ret = afs_fill_page(file, pos & PAGE_MASK, PAGE_SIZE, page);
 		if (ret < 0) {
 			unlock_page(page);
 			put_page(page);
@@ -163,7 +164,6 @@ int afs_write_end(struct file *file, struct address_space *mapping,
 		  struct page *page, void *fsdata)
 {
 	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
-	struct key *key = afs_file_key(file);
 	unsigned long priv;
 	unsigned int f, from = pos & (PAGE_SIZE - 1);
 	unsigned int t, to = from + copied;
@@ -193,7 +193,7 @@ int afs_write_end(struct file *file, struct address_space *mapping,
 			 * unmarshalling routine will take care of clearing any
 			 * bits that are beyond the EOF.
 			 */
-			ret = afs_fill_page(vnode, key, pos + copied,
+			ret = afs_fill_page(file, pos + copied,
 					    len - copied, page);
 			if (ret < 0)
 				goto out;


