Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED12AFDDF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 15:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbfIKNn0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Sep 2019 09:43:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59091 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727302AbfIKNnZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Sep 2019 09:43:25 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9C0D210F23F8;
        Wed, 11 Sep 2019 13:43:25 +0000 (UTC)
Received: from pegasus.maiolino.com (ovpn-204-18.brq.redhat.com [10.40.204.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A5BD10018F8;
        Wed, 11 Sep 2019 13:43:24 +0000 (UTC)
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     hch@lst.de, adilger@dilger.ca, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org
Subject: [PATCH 2/9] cachefiles: drop direct usage of ->bmap method.
Date:   Wed, 11 Sep 2019 15:43:08 +0200
Message-Id: <20190911134315.27380-3-cmaiolino@redhat.com>
In-Reply-To: <20190911134315.27380-1-cmaiolino@redhat.com>
References: <20190911134315.27380-1-cmaiolino@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Wed, 11 Sep 2019 13:43:25 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replace the direct usage of ->bmap method by a bmap() call.

Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---

Changelog:
	V6:
		- ASSERT only if filesystem does not support bmap() to
		  match the original logic


 fs/cachefiles/rdwr.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/cachefiles/rdwr.c b/fs/cachefiles/rdwr.c
index 44a3ce1e4ce4..1dc97f2d6201 100644
--- a/fs/cachefiles/rdwr.c
+++ b/fs/cachefiles/rdwr.c
@@ -396,7 +396,7 @@ int cachefiles_read_or_alloc_page(struct fscache_retrieval *op,
 	struct cachefiles_object *object;
 	struct cachefiles_cache *cache;
 	struct inode *inode;
-	sector_t block0, block;
+	sector_t block;
 	unsigned shift;
 	int ret;
 
@@ -412,7 +412,6 @@ int cachefiles_read_or_alloc_page(struct fscache_retrieval *op,
 
 	inode = d_backing_inode(object->backer);
 	ASSERT(S_ISREG(inode->i_mode));
-	ASSERT(inode->i_mapping->a_ops->bmap);
 	ASSERT(inode->i_mapping->a_ops->readpages);
 
 	/* calculate the shift required to use bmap */
@@ -428,12 +427,14 @@ int cachefiles_read_or_alloc_page(struct fscache_retrieval *op,
 	 *   enough for this as it doesn't indicate errors, but it's all we've
 	 *   got for the moment
 	 */
-	block0 = page->index;
-	block0 <<= shift;
+	block = page->index;
+	block <<= shift;
+
+	ret = bmap(inode, &block);
+	ASSERT(ret < 0);
 
-	block = inode->i_mapping->a_ops->bmap(inode->i_mapping, block0);
 	_debug("%llx -> %llx",
-	       (unsigned long long) block0,
+	       (unsigned long long) (page->index << shift),
 	       (unsigned long long) block);
 
 	if (block) {
@@ -711,7 +712,6 @@ int cachefiles_read_or_alloc_pages(struct fscache_retrieval *op,
 
 	inode = d_backing_inode(object->backer);
 	ASSERT(S_ISREG(inode->i_mode));
-	ASSERT(inode->i_mapping->a_ops->bmap);
 	ASSERT(inode->i_mapping->a_ops->readpages);
 
 	/* calculate the shift required to use bmap */
@@ -728,7 +728,7 @@ int cachefiles_read_or_alloc_pages(struct fscache_retrieval *op,
 
 	ret = space ? -ENODATA : -ENOBUFS;
 	list_for_each_entry_safe(page, _n, pages, lru) {
-		sector_t block0, block;
+		sector_t block;
 
 		/* we assume the absence or presence of the first block is a
 		 * good enough indication for the page as a whole
@@ -736,13 +736,14 @@ int cachefiles_read_or_alloc_pages(struct fscache_retrieval *op,
 		 *   good enough for this as it doesn't indicate errors, but
 		 *   it's all we've got for the moment
 		 */
-		block0 = page->index;
-		block0 <<= shift;
+		block = page->index;
+		block <<= shift;
+
+		ret = bmap(inode, &block);
+		ASSERT(!ret);
 
-		block = inode->i_mapping->a_ops->bmap(inode->i_mapping,
-						      block0);
 		_debug("%llx -> %llx",
-		       (unsigned long long) block0,
+		       (unsigned long long) (page->index << shift),
 		       (unsigned long long) block);
 
 		if (block) {
-- 
2.20.1

