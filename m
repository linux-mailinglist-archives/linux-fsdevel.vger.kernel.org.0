Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15C6358633
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 16:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbhDHOK2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 10:10:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56089 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232062AbhDHOIn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 10:08:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617890907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZvbTwnz6Vfn9FzsdNgoeK5HMEIuRnH4Dqv+Cb5/Exxc=;
        b=KBNj7eqZ+J95SHzN0oOpDW0OHIdbK+Vfkjz4RzNzPut4chel9VQrSzbayfyEpufd52W7WM
        5DxP+oMKey7bIw9fG0MsLlmlE1PKlqM0D0LtcX+ipi0DBm/6uDUzoXJZQpZfxSyvz7ZpSs
        D8IfF1clrsm4Xs8miyq81UZUf2p7VfM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-a0ylhRlDOyK2peUnga-dZA-1; Thu, 08 Apr 2021 10:08:25 -0400
X-MC-Unique: a0ylhRlDOyK2peUnga-dZA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03AB0107ACC7;
        Thu,  8 Apr 2021 14:08:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-119-35.rdu2.redhat.com [10.10.119.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 677711000358;
        Thu,  8 Apr 2021 14:08:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v6 20/30] afs: Move key to afs_read struct
From:   David Howells <dhowells@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-cachefs@redhat.com,
        dhowells@redhat.com,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date:   Thu, 08 Apr 2021 15:08:15 +0100
Message-ID: <161789089556.6155.14603302893431820997.stgit@warthog.procyon.org.uk>
In-Reply-To: <161789062190.6155.12711584466338493050.stgit@warthog.procyon.org.uk>
References: <161789062190.6155.12711584466338493050.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Stash the key used to authenticate read operations in the afs_read struct.
This will be necessary to reissue the operation against the server if a
read from the cache fails in upcoming cache changes.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/158861248336.340223.1851189950710196001.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/159465823899.1377938.11925978022348532049.stgit@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/160588529557.3465195.7303323479305254243.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/161118147693.1232039.13780672951838643842.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/161161043340.2537118.511899217704140722.stgit@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r/161340406678.1303470.12676824086429446370.stgit@warthog.procyon.org.uk/ # v3
Link: https://lore.kernel.org/r/161539550819.286939.1268332875889175195.stgit@warthog.procyon.org.uk/ # v4
Link: https://lore.kernel.org/r/161653806683.2770958.11300984379283401542.stgit@warthog.procyon.org.uk/ # v5
---

 fs/afs/dir.c      |    3 ++-
 fs/afs/file.c     |   16 +++++++++-------
 fs/afs/internal.h |    3 ++-
 fs/afs/write.c    |   12 ++++++------
 4 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 17548c1faf02..d8825ce63eba 100644
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
index f1bae0b0a9c0..af6471defec3 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -198,6 +198,7 @@ void afs_put_read(struct afs_read *req)
 			if (req->pages != req->array)
 				kfree(req->pages);
 		}
+		key_put(req->key);
 		kfree(req);
 	}
 }
@@ -228,7 +229,7 @@ static const struct afs_operation_ops afs_fetch_data_operation = {
 /*
  * Fetch file data from the volume.
  */
-int afs_fetch_data(struct afs_vnode *vnode, struct key *key, struct afs_read *req)
+int afs_fetch_data(struct afs_vnode *vnode, struct afs_read *req)
 {
 	struct afs_operation *op;
 
@@ -237,9 +238,9 @@ int afs_fetch_data(struct afs_vnode *vnode, struct key *key, struct afs_read *re
 	       vnode->fid.vid,
 	       vnode->fid.vnode,
 	       vnode->fid.unique,
-	       key_serial(key));
+	       key_serial(req->key));
 
-	op = afs_alloc_operation(key, vnode->volume);
+	op = afs_alloc_operation(req->key, vnode->volume);
 	if (IS_ERR(op))
 		return PTR_ERR(op);
 
@@ -278,6 +279,7 @@ int afs_page_filler(void *data, struct page *page)
 	 * unmarshalling code will clear the unfilled space.
 	 */
 	refcount_set(&req->usage, 1);
+	req->key = key_get(key);
 	req->pos = (loff_t)page->index << PAGE_SHIFT;
 	req->len = PAGE_SIZE;
 	req->nr_pages = 1;
@@ -287,7 +289,7 @@ int afs_page_filler(void *data, struct page *page)
 
 	/* read the contents of the file from the server into the
 	 * page */
-	ret = afs_fetch_data(vnode, key, req);
+	ret = afs_fetch_data(vnode, req);
 	afs_put_read(req);
 
 	if (ret < 0) {
@@ -372,7 +374,6 @@ static int afs_readpages_one(struct file *file, struct address_space *mapping,
 	struct afs_read *req;
 	struct list_head *p;
 	struct page *first, *page;
-	struct key *key = afs_file_key(file);
 	pgoff_t index;
 	int ret, n, i;
 
@@ -396,6 +397,7 @@ static int afs_readpages_one(struct file *file, struct address_space *mapping,
 
 	refcount_set(&req->usage, 1);
 	req->vnode = vnode;
+	req->key = key_get(afs_file_key(file));
 	req->page_done = afs_readpages_page_done;
 	req->pos = first->index;
 	req->pos <<= PAGE_SHIFT;
@@ -425,11 +427,11 @@ static int afs_readpages_one(struct file *file, struct address_space *mapping,
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
index fd437d4722b5..995fef267be7 100644
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
index babc84dd9719..a91da2e680da 100644
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


