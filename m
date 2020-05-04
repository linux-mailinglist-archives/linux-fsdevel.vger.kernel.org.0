Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A10331C41E5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 19:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730589AbgEDROz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 13:14:55 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35053 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730571AbgEDROy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 13:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588612492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LsFescFgbJSA2iAFdjAnyfOhzdMBffHhgT2MMC4v/KQ=;
        b=QHYOIJUnZNx2PwtI2aJSXCHtWEsqtYVcOqTsEZoeDWgWvqkwu/G2uA7BnWbTQt8s5rL/Ea
        AqYl5rc/oIpYieiETnviVRin9ODUzxZldBaAUqD1HrWADziwnoHZvOnQlNsEDiAz1Ynfkv
        AG8SpJT4kZnvffDWkz8mb6ou+vSPOE4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-u1v31251PlieW5aWzdnXPg-1; Mon, 04 May 2020 13:14:48 -0400
X-MC-Unique: u1v31251PlieW5aWzdnXPg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C447F8735C0;
        Mon,  4 May 2020 17:14:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-225.rdu2.redhat.com [10.10.118.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3FA416248B;
        Mon,  4 May 2020 17:14:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 48/61] afs: Move key to afs_read struct
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Jeff Layton <jlayton@redhat.com>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 04 May 2020 18:14:43 +0100
Message-ID: <158861248336.340223.1851189950710196001.stgit@warthog.procyon.org.uk>
In-Reply-To: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
References: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
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
index d1e1caa23c8b..9d8504885f6a 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -243,6 +243,7 @@ static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct key *key)
 		return ERR_PTR(-ENOMEM);
 
 	refcount_set(&req->usage, 1);
+	req->key = key_get(key);
 	req->nr_pages = nr_pages;
 	req->actual_len = i_size; /* May change */
 	req->len = nr_pages * PAGE_SIZE; /* We can ask for more than there is */
@@ -308,7 +309,7 @@ static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct key *key)
 
 	if (!test_bit(AFS_VNODE_DIR_VALID, &dvnode->flags)) {
 		trace_afs_reload_dir(dvnode);
-		ret = afs_fetch_data(dvnode, key, req);
+		ret = afs_fetch_data(dvnode, req);
 		if (ret < 0)
 			goto error_unlock;
 
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 39db1e7b186d..834f47c4dc94 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -211,6 +211,7 @@ void afs_put_read(struct afs_read *req)
 			if (req->pages != req->array)
 				kfree(req->pages);
 		}
+		key_put(req->key);
 		kfree(req);
 	}
 }
@@ -218,7 +219,7 @@ void afs_put_read(struct afs_read *req)
 /*
  * Fetch file data from the volume.
  */
-int afs_fetch_data(struct afs_vnode *vnode, struct key *key, struct afs_read *req)
+int afs_fetch_data(struct afs_vnode *vnode, struct afs_read *req)
 {
 	struct afs_fs_cursor fc;
 	struct afs_status_cb *scb;
@@ -229,14 +230,14 @@ int afs_fetch_data(struct afs_vnode *vnode, struct key *key, struct afs_read *re
 	       vnode->fid.vid,
 	       vnode->fid.vnode,
 	       vnode->fid.unique,
-	       key_serial(key));
+	       key_serial(req->key));
 
 	scb = kzalloc(sizeof(struct afs_status_cb), GFP_KERNEL);
 	if (!scb)
 		return -ENOMEM;
 
 	ret = -ERESTARTSYS;
-	if (afs_begin_vnode_operation(&fc, vnode, key, true)) {
+	if (afs_begin_vnode_operation(&fc, vnode, req->key, true)) {
 		afs_dataversion_t data_version = vnode->status.data_version;
 
 		while (afs_select_fileserver(&fc)) {
@@ -289,6 +290,7 @@ int afs_page_filler(void *data, struct page *page)
 	 * unmarshalling code will clear the unfilled space.
 	 */
 	refcount_set(&req->usage, 1);
+	req->key = key_get(key);
 	req->pos = (loff_t)page->index << PAGE_SHIFT;
 	req->len = PAGE_SIZE;
 	req->nr_pages = 1;
@@ -298,7 +300,7 @@ int afs_page_filler(void *data, struct page *page)
 
 	/* read the contents of the file from the server into the
 	 * page */
-	ret = afs_fetch_data(vnode, key, req);
+	ret = afs_fetch_data(vnode, req);
 	afs_put_read(req);
 
 	if (ret < 0) {
@@ -383,7 +385,6 @@ static int afs_readpages_one(struct file *file, struct address_space *mapping,
 	struct afs_read *req;
 	struct list_head *p;
 	struct page *first, *page;
-	struct key *key = afs_file_key(file);
 	pgoff_t index;
 	int ret, n, i;
 
@@ -407,6 +408,7 @@ static int afs_readpages_one(struct file *file, struct address_space *mapping,
 
 	refcount_set(&req->usage, 1);
 	req->vnode = vnode;
+	req->key = key_get(afs_file_key(file));
 	req->page_done = afs_readpages_page_done;
 	req->pos = first->index;
 	req->pos <<= PAGE_SHIFT;
@@ -436,11 +438,11 @@ static int afs_readpages_one(struct file *file, struct address_space *mapping,
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
index 633c0f49bb55..68d3eb0dc367 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -227,6 +227,7 @@ struct afs_read {
 	loff_t			actual_len;	/* How much we're actually getting */
 	loff_t			remain;		/* Amount remaining */
 	loff_t			file_size;	/* File size returned by server */
+	struct key		*key;		/* The key to use to reissue the read */
 	afs_dataversion_t	data_version;	/* Version number returned by server */
 	refcount_t		usage;
 	unsigned int		index;		/* Which page we're reading into */
@@ -921,7 +922,7 @@ extern int afs_cache_wb_key(struct afs_vnode *, struct afs_file *);
 extern void afs_put_wb_key(struct afs_wb_key *);
 extern int afs_open(struct inode *, struct file *);
 extern int afs_release(struct inode *, struct file *);
-extern int afs_fetch_data(struct afs_vnode *, struct key *, struct afs_read *);
+extern int afs_fetch_data(struct afs_vnode *, struct afs_read *);
 extern int afs_page_filler(void *, struct page *);
 extern void afs_put_read(struct afs_read *);
 
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 25786237485a..8473f9bc3548 100644
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
+	req->key = afs_file_key(file);
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
@@ -100,7 +101,7 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
 		return -ENOMEM;
 
 	if (!PageUptodate(page) && len != PAGE_SIZE) {
-		ret = afs_fill_page(vnode, key, pos & PAGE_MASK, PAGE_SIZE, page);
+		ret = afs_fill_page(file, pos & PAGE_MASK, PAGE_SIZE, page);
 		if (ret < 0) {
 			unlock_page(page);
 			put_page(page);
@@ -183,7 +184,6 @@ int afs_write_end(struct file *file, struct address_space *mapping,
 		  struct page *page, void *fsdata)
 {
 	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
-	struct key *key = afs_file_key(file);
 	loff_t i_size, maybe_i_size;
 	int ret;
 
@@ -207,7 +207,7 @@ int afs_write_end(struct file *file, struct address_space *mapping,
 			 * unmarshalling routine will take care of clearing any
 			 * bits that are beyond the EOF.
 			 */
-			ret = afs_fill_page(vnode, key, pos + copied,
+			ret = afs_fill_page(file, pos + copied,
 					    len - copied, page);
 			if (ret < 0)
 				goto out;


