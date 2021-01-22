Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F57300AAE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 19:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbhAVR6O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 12:58:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:53910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729591AbhAVRwh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 12:52:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2DD2323AAA;
        Fri, 22 Jan 2021 17:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611337884;
        bh=ZmC/Z8c2ub1C7KMD2cN83t8AzeiWrrEekRlNmXdgI38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E1YqlOEPWLh6RsaLKJW30ig0iwygO6rNHwEv0OrzmF1jk8OqJe/fkl3LhLs690LPK
         QDqntWzSA81dGZ/DVJOciw0+jnnVoaM5rp1dD1ed/1tIn4XEuxKb6EQaF5Ytxhl5Cs
         8i9xsmf9pFVZf7P5xI8zuWhWi/2lsJzt2O8viGapcQsEVr3jlIQQs3HaLegnsD9HE5
         +swGh42FWvg9qQESA00MMNmo8mgtRrHg01tdIktjcma26LYO2Xn2D6a0YcgPTcLQQg
         uCAK+fGa7REfU29sjST+D3mxBkANmV7IW9yAC3JowdWZUS5JhZgpss/j/nNLBdcuwg
         jwucEvoAq+WQA==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        willy@infradead.org, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/6] ceph: convert readpage to fscache read helper
Date:   Fri, 22 Jan 2021 12:51:16 -0500
Message-Id: <20210122175119.364381-5-jlayton@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210122175119.364381-1-jlayton@kernel.org>
References: <20210122175119.364381-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Have the ceph KConfig select NETFS_SUPPORT. Add a new netfs ops
structure and the operations for it. Convert ceph_readpage to use
the new netfs_readpage helper.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/Kconfig |   1 +
 fs/ceph/addr.c  | 149 ++++++++++++++++++++++++++++++++++++++++++++----
 fs/ceph/cache.h |  36 ++++++++++++
 3 files changed, 176 insertions(+), 10 deletions(-)

diff --git a/fs/ceph/Kconfig b/fs/ceph/Kconfig
index 471e40156065..94df854147d3 100644
--- a/fs/ceph/Kconfig
+++ b/fs/ceph/Kconfig
@@ -6,6 +6,7 @@ config CEPH_FS
 	select LIBCRC32C
 	select CRYPTO_AES
 	select CRYPTO
+	select NETFS_SUPPORT
 	default n
 	help
 	  Choose Y or M here to include support for mounting the
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index f554667e1e91..986c9c56653f 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -12,6 +12,7 @@
 #include <linux/signal.h>
 #include <linux/iversion.h>
 #include <linux/ktime.h>
+#include <linux/netfs.h>
 
 #include "super.h"
 #include "mds_client.h"
@@ -182,6 +183,144 @@ static int ceph_releasepage(struct page *page, gfp_t gfp_flags)
 	return !PagePrivate(page);
 }
 
+static bool ceph_netfs_clamp_length(struct netfs_read_subrequest *subreq)
+{
+	struct inode *inode = subreq->rreq->mapping->host;
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	u64 objno, objoff;
+	u32 xlen;
+
+	/* Truncate the extent at the end of the current object */
+	ceph_calc_file_object_mapping(&ci->i_layout, subreq->start, subreq->len,
+				      &objno, &objoff, &xlen);
+	subreq->len = xlen;
+	return true;
+}
+
+static void finish_netfs_read(struct ceph_osd_request *req)
+{
+	struct ceph_fs_client *fsc = ceph_inode_to_client(req->r_inode);
+	struct ceph_osd_data *osd_data = osd_req_op_extent_osd_data(req, 0);
+	struct netfs_read_subrequest *subreq = req->r_priv;
+	int num_pages;
+	int err = req->r_result;
+
+	ceph_update_read_latency(&fsc->mdsc->metric, req->r_start_latency,
+				 req->r_end_latency, err);
+
+	dout("%s: result %d subreq->len=%zu i_size=%lld\n", __func__, req->r_result,
+	     subreq->len, i_size_read(req->r_inode));
+
+	/* no object means success but no data */
+	if (err == -ENOENT)
+		err = 0;
+	else if (err == -EBLOCKLISTED)
+		fsc->blocklisted = true;
+
+	if (err >= 0 && err < subreq->len)
+		__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
+
+	netfs_subreq_terminated(subreq, err);
+
+	num_pages = calc_pages_for(osd_data->alignment, osd_data->length);
+	ceph_put_page_vector(osd_data->pages, num_pages, false);
+	iput(req->r_inode);
+}
+
+static void ceph_netfs_issue_op(struct netfs_read_subrequest *subreq)
+{
+	struct netfs_read_request *rreq = subreq->rreq;
+	struct inode *inode = rreq->mapping->host;
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_osd_request *req = NULL;
+	struct ceph_vino vino = ceph_vino(inode);
+	struct iov_iter iter;
+	struct page **pages;
+	size_t page_off;
+	int err = 0;
+	u64 len = subreq->len;
+
+	req = ceph_osdc_new_request(&fsc->client->osdc, &ci->i_layout, vino, subreq->start, &len,
+			0, 1, CEPH_OSD_OP_READ,
+			CEPH_OSD_FLAG_READ | fsc->client->osdc.client->options->read_from_replica,
+			NULL, ci->i_truncate_seq, ci->i_truncate_size, false);
+	if (IS_ERR(req)) {
+		err = PTR_ERR(req);
+		goto out;
+	}
+
+	dout("%s: pos=%llu orig_len=%zu len=%llu\n", __func__, subreq->start, subreq->len, len);
+	iov_iter_xarray(&iter, READ, &rreq->mapping->i_pages, subreq->start, len);
+	len = iov_iter_get_pages_alloc(&iter, &pages, len, &page_off);
+	if (len < 0) {
+		err = len;
+		dout("%s: iov_ter_get_pages_alloc returned %d\n", __func__, err);
+		goto out;
+	}
+
+	/* should always give us a page-aligned read */
+	WARN_ON_ONCE(page_off);
+
+	osd_req_op_extent_osd_data_pages(req, 0, pages, len, 0, false, false);
+	req->r_callback = finish_netfs_read;
+	req->r_priv = subreq;
+	req->r_inode = inode;
+	ihold(inode);
+
+	err = ceph_osdc_start_request(req->r_osdc, req, false);
+	if (err)
+		iput(inode);
+out:
+	if (req)
+		ceph_osdc_put_request(req);
+	if (err)
+		netfs_subreq_terminated(subreq, err);
+	dout("%s: result %d\n", __func__, err);
+}
+
+static void ceph_init_rreq(struct netfs_read_request *rreq, struct file *file)
+{
+}
+
+const struct netfs_read_request_ops ceph_readpage_netfs_ops = {
+	.init_rreq		= ceph_init_rreq,
+	.is_cache_enabled	= ceph_is_cache_enabled,
+	.begin_cache_operation	= ceph_begin_cache_operation,
+	.issue_op		= ceph_netfs_issue_op,
+	.clamp_length		= ceph_netfs_clamp_length,
+};
+
+/* read a single page, without unlocking it. */
+static int ceph_readpage(struct file *filp, struct page *page)
+{
+	struct inode *inode = file_inode(filp);
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct ceph_vino vino = ceph_vino(inode);
+	u64 off = page_offset(page);
+	u64 len = PAGE_SIZE;
+
+	if (ci->i_inline_version != CEPH_INLINE_NONE) {
+		/*
+		 * Uptodate inline data should have been added
+		 * into page cache while getting Fcr caps.
+		 */
+		if (off == 0) {
+			unlock_page(page);
+			return -EINVAL;
+		}
+		zero_user_segment(page, 0, PAGE_SIZE);
+		SetPageUptodate(page);
+		unlock_page(page);
+		return 0;
+	}
+
+	dout("readpage ino %llx.%llx file %p off %llu len %llu page %p index %lu\n",
+	     vino.ino, vino.snap, filp, off, len, page, page->index);
+
+	return netfs_readpage(filp, page, &ceph_readpage_netfs_ops, NULL);
+}
+
 /* read a single page, without unlocking it. */
 static int ceph_do_readpage(struct file *filp, struct page *page)
 {
@@ -252,16 +391,6 @@ static int ceph_do_readpage(struct file *filp, struct page *page)
 	return err < 0 ? err : 0;
 }
 
-static int ceph_readpage(struct file *filp, struct page *page)
-{
-	int r = ceph_do_readpage(filp, page);
-	if (r != -EINPROGRESS)
-		unlock_page(page);
-	else
-		r = 0;
-	return r;
-}
-
 /*
  * Finish an async read(ahead) op.
  */
diff --git a/fs/ceph/cache.h b/fs/ceph/cache.h
index 10c21317b62f..1409d6149281 100644
--- a/fs/ceph/cache.h
+++ b/fs/ceph/cache.h
@@ -9,6 +9,8 @@
 #ifndef _CEPH_CACHE_H
 #define _CEPH_CACHE_H
 
+#include <linux/netfs.h>
+
 #ifdef CONFIG_CEPH_FSCACHE
 
 extern struct fscache_netfs ceph_cache_netfs;
@@ -35,11 +37,31 @@ static inline void ceph_fscache_inode_init(struct ceph_inode_info *ci)
 	ci->fscache = NULL;
 }
 
+static inline struct fscache_cookie *ceph_fscache_cookie(struct ceph_inode_info *ci)
+{
+	return ci->fscache;
+}
+
 static inline void ceph_fscache_invalidate(struct inode *inode)
 {
 	fscache_invalidate(ceph_inode(inode)->fscache);
 }
 
+static inline bool ceph_is_cache_enabled(struct inode *inode)
+{
+	struct fscache_cookie *cookie = ceph_fscache_cookie(ceph_inode(inode));
+
+	if (!cookie)
+		return false;
+	return fscache_cookie_enabled(cookie);
+}
+
+static inline int ceph_begin_cache_operation(struct netfs_read_request *rreq)
+{
+	struct fscache_cookie *cookie = ceph_fscache_cookie(ceph_inode(rreq->inode));
+
+	return fscache_begin_read_operation(rreq, cookie);
+}
 #else
 
 static inline int ceph_fscache_register(void)
@@ -65,6 +87,11 @@ static inline void ceph_fscache_inode_init(struct ceph_inode_info *ci)
 {
 }
 
+static inline struct fscache_cookie *ceph_fscache_cookie(struct ceph_inode_info *ci)
+{
+	return NULL;
+}
+
 static inline void ceph_fscache_register_inode_cookie(struct inode *inode)
 {
 }
@@ -82,6 +109,15 @@ static inline void ceph_fscache_invalidate(struct inode *inode)
 {
 }
 
+static inline bool ceph_is_cache_enabled(struct inode *inode)
+{
+	return false;
+}
+
+static inline int ceph_begin_cache_operation(struct netfs_read_request *rreq)
+{
+	return -ENOBUFS;
+}
 #endif
 
 #endif /* _CEPH_CACHE_H */
-- 
2.29.2

