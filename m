Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1963E496E0C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jan 2022 21:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbiAVUzN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Jan 2022 15:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234844AbiAVUzN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Jan 2022 15:55:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB46DC06173D;
        Sat, 22 Jan 2022 12:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=3H17ZwduCeulLDZ8G7sSfbVcJQrwo5WKSwj+sy/g+qI=; b=IWAWN0UBg/t1BcYDP4KL2EDU3K
        s3MxYl2lNhK+VZCIKM8wR3QkVENKhn9C7ZbqYIR9s8CXwjq9lpQ7CigDDhsSpZxCsKkNRKQRHeY6t
        AlxzTzcq2zC2+BkOearzCUpVuiQmsC0v5SDU7tU8GhnezqGHcxjplEznDzpY9WY1QtOmJX/3E8UMr
        o1NW92jdNvcou5/EIpd0/Ysa2rXETloAiZJ3/+9ZxtexqK+dBy4hEMBAwr7sempRSJSyfNVCcmZY0
        asCdi2wQrEYJAquFbnu2jMPTlWG9NWosiro9I1mBItsyt8SjhKMoppdLKJit0H+q06ZHIZausX/Ku
        Ilx+mnFA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBNPV-00GblC-SM; Sat, 22 Jan 2022 20:54:57 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 1/2] Convert NFS from readpages to readahead
Date:   Sat, 22 Jan 2022 20:54:52 +0000
Message-Id: <20220122205453.3958181-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

NFS is one of the last two users of the deprecated ->readpages aop.
This conversion looks straightforward, but I have only compile-tested
it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nfs/file.c          |  2 +-
 fs/nfs/nfstrace.h      |  6 +++---
 fs/nfs/read.c          | 21 +++++++++++++--------
 include/linux/nfs_fs.h |  3 +--
 4 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 76d76acbc594..4d681683d13c 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -514,7 +514,7 @@ static void nfs_swap_deactivate(struct file *file)
 
 const struct address_space_operations nfs_file_aops = {
 	.readpage = nfs_readpage,
-	.readpages = nfs_readpages,
+	.readahead = nfs_readahead,
 	.set_page_dirty = __set_page_dirty_nobuffers,
 	.writepage = nfs_writepage,
 	.writepages = nfs_writepages,
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 317ce27bdc4b..4611aa3a21a4 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -889,11 +889,11 @@ TRACE_EVENT(nfs_aop_readpage_done,
 TRACE_EVENT(nfs_aop_readahead,
 		TP_PROTO(
 			const struct inode *inode,
-			struct page *page,
+			loff_t pos,
 			unsigned int nr_pages
 		),
 
-		TP_ARGS(inode, page, nr_pages),
+		TP_ARGS(inode, pos, nr_pages),
 
 		TP_STRUCT__entry(
 			__field(dev_t, dev)
@@ -911,7 +911,7 @@ TRACE_EVENT(nfs_aop_readahead,
 			__entry->fileid = nfsi->fileid;
 			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
 			__entry->version = inode_peek_iversion_raw(inode);
-			__entry->offset = page_index(page) << PAGE_SHIFT;
+			__entry->offset = pos;
 			__entry->nr_pages = nr_pages;
 		),
 
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index eb00229c1a50..2472f962a9a2 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -290,9 +290,8 @@ static void nfs_readpage_result(struct rpc_task *task,
 }
 
 static int
-readpage_async_filler(void *data, struct page *page)
+readpage_async_filler(struct nfs_readdesc *desc, struct page *page)
 {
-	struct nfs_readdesc *desc = data;
 	struct inode *inode = page_file_mapping(page)->host;
 	unsigned int rsize = NFS_SERVER(inode)->rsize;
 	struct nfs_page *new;
@@ -397,14 +396,16 @@ int nfs_readpage(struct file *file, struct page *page)
 	return ret;
 }
 
-int nfs_readpages(struct file *file, struct address_space *mapping,
-		struct list_head *pages, unsigned nr_pages)
+void nfs_readahead(struct readahead_control *ractl)
 {
+	unsigned int nr_pages = readahead_count(ractl);
+	struct file *file = ractl->file;
 	struct nfs_readdesc desc;
-	struct inode *inode = mapping->host;
+	struct inode *inode = ractl->mapping->host;
+	struct page *page;
 	int ret;
 
-	trace_nfs_aop_readahead(inode, lru_to_page(pages), nr_pages);
+	trace_nfs_aop_readahead(inode, readahead_pos(ractl), nr_pages);
 	nfs_inc_stats(inode, NFSIOS_VFSREADPAGES);
 
 	ret = -ESTALE;
@@ -422,14 +423,18 @@ int nfs_readpages(struct file *file, struct address_space *mapping,
 	nfs_pageio_init_read(&desc.pgio, inode, false,
 			     &nfs_async_read_completion_ops);
 
-	ret = read_cache_pages(mapping, pages, readpage_async_filler, &desc);
+	while ((page = readahead_page(ractl)) != NULL) {
+		ret = readpage_async_filler(&desc, page);
+		put_page(page);
+		if (ret)
+			break;
+	}
 
 	nfs_pageio_complete_read(&desc.pgio);
 
 	put_nfs_open_context(desc.ctx);
 out:
 	trace_nfs_aop_readahead_done(inode, nr_pages, ret);
-	return ret;
 }
 
 int __init nfs_init_readpagecache(void)
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 00835bacd236..e6ab516bc3d1 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -598,8 +598,7 @@ nfs_have_writebacks(struct inode *inode)
  * linux/fs/nfs/read.c
  */
 extern int  nfs_readpage(struct file *, struct page *);
-extern int  nfs_readpages(struct file *, struct address_space *,
-		struct list_head *, unsigned);
+void nfs_readahead(struct readahead_control *);
 
 /*
  * inline functions
-- 
2.34.1

