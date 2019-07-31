Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83EE27C481
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2019 16:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbfGaONH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 10:13:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34070 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbfGaONH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 10:13:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 13BA22DD3B;
        Wed, 31 Jul 2019 14:13:07 +0000 (UTC)
Received: from pegasus.maiolino.com (unknown [10.40.205.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 558B260605;
        Wed, 31 Jul 2019 14:13:03 +0000 (UTC)
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     hch@lst.de, adilger@dilger.ca, jaegeuk@kernel.org,
        darrick.wong@oracle.com, miklos@szeredi.hu, rpeterso@redhat.com,
        linux-xfs@vger.kernel.org
Subject: [PATCH 2/9] cachefiles: drop direct usage of ->bmap method.
Date:   Wed, 31 Jul 2019 16:12:38 +0200
Message-Id: <20190731141245.7230-3-cmaiolino@redhat.com>
In-Reply-To: <20190731141245.7230-1-cmaiolino@redhat.com>
References: <20190731141245.7230-1-cmaiolino@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 31 Jul 2019 14:13:07 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replace the direct usage of ->bmap method by a bmap() call.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---
 fs/cachefiles/rdwr.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/cachefiles/rdwr.c b/fs/cachefiles/rdwr.c
index 8a577409d030..1a74aa978056 100644
--- a/fs/cachefiles/rdwr.c
+++ b/fs/cachefiles/rdwr.c
@@ -400,7 +400,7 @@ int cachefiles_read_or_alloc_page(struct fscache_retrieval *op,
 	struct cachefiles_object *object;
 	struct cachefiles_cache *cache;
 	struct inode *inode;
-	sector_t block0, block;
+	sector_t block;
 	unsigned shift;
 	int ret;
 
@@ -416,7 +416,6 @@ int cachefiles_read_or_alloc_page(struct fscache_retrieval *op,
 
 	inode = d_backing_inode(object->backer);
 	ASSERT(S_ISREG(inode->i_mode));
-	ASSERT(inode->i_mapping->a_ops->bmap);
 	ASSERT(inode->i_mapping->a_ops->readpages);
 
 	/* calculate the shift required to use bmap */
@@ -432,12 +431,14 @@ int cachefiles_read_or_alloc_page(struct fscache_retrieval *op,
 	 *   enough for this as it doesn't indicate errors, but it's all we've
 	 *   got for the moment
 	 */
-	block0 = page->index;
-	block0 <<= shift;
+	block = page->index;
+	block <<= shift;
+
+	ret = bmap(inode, &block);
+	ASSERT(!ret);
 
-	block = inode->i_mapping->a_ops->bmap(inode->i_mapping, block0);
 	_debug("%llx -> %llx",
-	       (unsigned long long) block0,
+	       (unsigned long long) (page->index << shift),
 	       (unsigned long long) block);
 
 	if (block) {
@@ -715,7 +716,6 @@ int cachefiles_read_or_alloc_pages(struct fscache_retrieval *op,
 
 	inode = d_backing_inode(object->backer);
 	ASSERT(S_ISREG(inode->i_mode));
-	ASSERT(inode->i_mapping->a_ops->bmap);
 	ASSERT(inode->i_mapping->a_ops->readpages);
 
 	/* calculate the shift required to use bmap */
@@ -732,7 +732,7 @@ int cachefiles_read_or_alloc_pages(struct fscache_retrieval *op,
 
 	ret = space ? -ENODATA : -ENOBUFS;
 	list_for_each_entry_safe(page, _n, pages, lru) {
-		sector_t block0, block;
+		sector_t block;
 
 		/* we assume the absence or presence of the first block is a
 		 * good enough indication for the page as a whole
@@ -740,13 +740,14 @@ int cachefiles_read_or_alloc_pages(struct fscache_retrieval *op,
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

