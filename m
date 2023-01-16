Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC6F66D2D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 00:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235411AbjAPXOh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 18:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235300AbjAPXOB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 18:14:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49F722DF6
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 15:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673910622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hzJ1pMyiJ+RsXEy2r6s2nQM3QoHbxUG3+tLaUVatkNA=;
        b=b3zPEnlvt7pQJIsTKFxPO/TaGcXHRUqRKbi3W44jykxMTXuW4Et8yo0Qlp0o3O4Y6axI5Y
        z3jGZ7s7mlSAWO6/zzNQwEmyti5hsBfU+KyrhluK+nT+zSCEepL5FtCLGP+E7YgggL1qFI
        3YXLO1B8lgrbIQfhLXVhUWhxO7+EGCM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-578-oNGc_qOmMcuLavBHLMbwog-1; Mon, 16 Jan 2023 18:10:20 -0500
X-MC-Unique: oNGc_qOmMcuLavBHLMbwog-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4A6583806628;
        Mon, 16 Jan 2023 23:10:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C70FC40C2064;
        Mon, 16 Jan 2023 23:10:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v6 19/34] fuse:  Pin pages rather than ref'ing if appropriate
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 16 Jan 2023 23:10:18 +0000
Message-ID: <167391061826.2311931.4301280201217181104.stgit@warthog.procyon.org.uk>
In-Reply-To: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
References: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert the fuse code to use iov_iter_extract_pages() instead of
iov_iter_get_pages().  This will pin pages or leave them unaltered rather
than getting a ref on them as appropriate to the iterator.

The pages need to be pinned for DIO-read rather than having refs taken on
them to prevent VM copy-on-write from malfunctioning during a concurrent
fork() (the result of the I/O would otherwise end up only visible to the
child process and not the parent).

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Miklos Szeredi <miklos@szeredi.hu>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Christoph Hellwig <hch@lst.de>
cc: linux-fsdevel@vger.kernel.org
---

 fs/fuse/dev.c    |   25 +++++++++++++++++++------
 fs/fuse/file.c   |   26 ++++++++++++++++++--------
 fs/fuse/fuse_i.h |    1 +
 3 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index e3d8443e24a6..107497e68726 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -641,6 +641,7 @@ static int unlock_request(struct fuse_req *req)
 
 struct fuse_copy_state {
 	int write;
+	unsigned int cleanup_mode;	/* Page cleanup mode (0/FOLL_GET/PIN) */
 	struct fuse_req *req;
 	struct iov_iter *iter;
 	struct pipe_buffer *pipebufs;
@@ -661,6 +662,11 @@ static void fuse_copy_init(struct fuse_copy_state *cs, int write,
 	cs->iter = iter;
 }
 
+static void fuse_release_copy_page(struct fuse_copy_state *cs, struct page *page)
+{
+	page_put_unpin(page, cs->cleanup_mode);
+}
+
 /* Unmap and put previous page of userspace buffer */
 static void fuse_copy_finish(struct fuse_copy_state *cs)
 {
@@ -675,7 +681,7 @@ static void fuse_copy_finish(struct fuse_copy_state *cs)
 			flush_dcache_page(cs->pg);
 			set_page_dirty_lock(cs->pg);
 		}
-		put_page(cs->pg);
+		fuse_release_copy_page(cs, cs->pg);
 	}
 	cs->pg = NULL;
 }
@@ -704,6 +710,7 @@ static int fuse_copy_fill(struct fuse_copy_state *cs)
 
 			BUG_ON(!cs->nr_segs);
 			cs->currbuf = buf;
+			cs->cleanup_mode = FOLL_GET;
 			cs->pg = buf->page;
 			cs->offset = buf->offset;
 			cs->len = buf->len;
@@ -722,6 +729,7 @@ static int fuse_copy_fill(struct fuse_copy_state *cs)
 			buf->len = 0;
 
 			cs->currbuf = buf;
+			cs->cleanup_mode = FOLL_GET;
 			cs->pg = page;
 			cs->offset = 0;
 			cs->len = PAGE_SIZE;
@@ -729,15 +737,18 @@ static int fuse_copy_fill(struct fuse_copy_state *cs)
 			cs->nr_segs++;
 		}
 	} else {
+		unsigned int gup_flags = cs->write ? FOLL_SOURCE_BUF : FOLL_DEST_BUF;
+		struct page **pages = &cs->pg;
 		size_t off;
-		err = iov_iter_get_pages(cs->iter, &page, PAGE_SIZE, 1, &off,
-					 cs->write ? FOLL_SOURCE_BUF : FOLL_DEST_BUF);
+
+		err = iov_iter_extract_pages(cs->iter, &pages, PAGE_SIZE, 1,
+					     gup_flags, &off);
 		if (err < 0)
 			return err;
 		BUG_ON(!err);
 		cs->len = err;
 		cs->offset = off;
-		cs->pg = page;
+		cs->cleanup_mode = iov_iter_extract_mode(cs->iter, gup_flags);
 	}
 
 	return lock_request(cs->req);
@@ -899,10 +910,12 @@ static int fuse_ref_page(struct fuse_copy_state *cs, struct page *page,
 	if (cs->nr_segs >= cs->pipe->max_usage)
 		return -EIO;
 
-	get_page(page);
+	err = try_grab_page(page, cs->cleanup_mode);
+	if (err < 0)
+		return err;
 	err = unlock_request(cs->req);
 	if (err) {
-		put_page(page);
+		fuse_release_copy_page(cs, page);
 		return err;
 	}
 
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 68c196437306..c317300e757a 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -624,6 +624,11 @@ void fuse_read_args_fill(struct fuse_io_args *ia, struct file *file, loff_t pos,
 	args->out_args[0].size = count;
 }
 
+static void fuse_release_page(struct fuse_args_pages *ap, struct page *page)
+{
+	page_put_unpin(page, ap->cleanup_mode);
+}
+
 static void fuse_release_user_pages(struct fuse_args_pages *ap,
 				    bool should_dirty)
 {
@@ -632,7 +637,7 @@ static void fuse_release_user_pages(struct fuse_args_pages *ap,
 	for (i = 0; i < ap->num_pages; i++) {
 		if (should_dirty)
 			set_page_dirty_lock(ap->pages[i]);
-		put_page(ap->pages[i]);
+		fuse_release_page(ap, ap->pages[i]);
 	}
 }
 
@@ -920,7 +925,7 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
 		else
 			SetPageError(page);
 		unlock_page(page);
-		put_page(page);
+		fuse_release_page(ap, page);
 	}
 	if (ia->ff)
 		fuse_file_put(ia->ff, false, false);
@@ -1153,7 +1158,7 @@ static ssize_t fuse_send_write_pages(struct fuse_io_args *ia,
 		}
 		if (ia->write.page_locked && (i == ap->num_pages - 1))
 			unlock_page(page);
-		put_page(page);
+		fuse_release_page(ap, page);
 	}
 
 	return err;
@@ -1172,6 +1177,7 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 
 	ap->args.in_pages = true;
 	ap->descs[0].offset = offset;
+	ap->cleanup_mode = FOLL_GET;
 
 	do {
 		size_t tmp;
@@ -1200,7 +1206,7 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 
 		if (!tmp) {
 			unlock_page(page);
-			put_page(page);
+			fuse_release_page(ap, page);
 			goto again;
 		}
 
@@ -1393,9 +1399,12 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
 			       size_t *nbytesp, int write,
 			       unsigned int max_pages)
 {
+	unsigned int gup_flags = write ? FOLL_SOURCE_BUF : FOLL_DEST_BUF;
 	size_t nbytes = 0;  /* # bytes already packed in req */
 	ssize_t ret = 0;
 
+	ap->cleanup_mode = iov_iter_extract_mode(ii, gup_flags);
+
 	/* Special case for kernel I/O: can copy directly into the buffer */
 	if (iov_iter_is_kvec(ii)) {
 		unsigned long user_addr = fuse_get_user_addr(ii);
@@ -1412,12 +1421,13 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
 	}
 
 	while (nbytes < *nbytesp && ap->num_pages < max_pages) {
+		struct page **pages = &ap->pages[ap->num_pages];
 		unsigned npages;
 		size_t start;
-		ret = iov_iter_get_pages(ii, &ap->pages[ap->num_pages],
-					 *nbytesp - nbytes,
-					 max_pages - ap->num_pages,
-					 &start, write ? FOLL_SOURCE_BUF : FOLL_DEST_BUF);
+		ret = iov_iter_extract_pages(ii, &pages,
+					     *nbytesp - nbytes,
+					     max_pages - ap->num_pages,
+					     gup_flags, &start);
 		if (ret < 0)
 			break;
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index c673faefdcb9..7b6be1dd7593 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -271,6 +271,7 @@ struct fuse_args_pages {
 	struct page **pages;
 	struct fuse_page_desc *descs;
 	unsigned int num_pages;
+	unsigned int cleanup_mode;
 };
 
 #define FUSE_ARGS(args) struct fuse_args args = {}


