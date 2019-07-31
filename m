Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1607C483
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2019 16:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbfGaONJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 10:13:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43152 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbfGaONJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 10:13:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2E0AB30ADC82;
        Wed, 31 Jul 2019 14:13:09 +0000 (UTC)
Received: from pegasus.maiolino.com (unknown [10.40.205.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5E4A460852;
        Wed, 31 Jul 2019 14:13:07 +0000 (UTC)
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     hch@lst.de, adilger@dilger.ca, jaegeuk@kernel.org,
        darrick.wong@oracle.com, miklos@szeredi.hu, rpeterso@redhat.com,
        linux-xfs@vger.kernel.org
Subject: [PATCH 3/9] ecryptfs: drop direct calls to ->bmap
Date:   Wed, 31 Jul 2019 16:12:39 +0200
Message-Id: <20190731141245.7230-4-cmaiolino@redhat.com>
In-Reply-To: <20190731141245.7230-1-cmaiolino@redhat.com>
References: <20190731141245.7230-1-cmaiolino@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 31 Jul 2019 14:13:09 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replace direct ->bmap calls by bmap() method.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---
 fs/ecryptfs/mmap.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index cdf358b209d9..ff323dccef36 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -538,16 +538,12 @@ static int ecryptfs_write_end(struct file *file,
 
 static sector_t ecryptfs_bmap(struct address_space *mapping, sector_t block)
 {
-	int rc = 0;
-	struct inode *inode;
-	struct inode *lower_inode;
-
-	inode = (struct inode *)mapping->host;
-	lower_inode = ecryptfs_inode_to_lower(inode);
-	if (lower_inode->i_mapping->a_ops->bmap)
-		rc = lower_inode->i_mapping->a_ops->bmap(lower_inode->i_mapping,
-							 block);
-	return rc;
+	struct inode *lower_inode = ecryptfs_inode_to_lower(mapping->host);
+	int ret = bmap(lower_inode, &block);
+
+	if (ret)
+		return 0;
+	return block;
 }
 
 const struct address_space_operations ecryptfs_aops = {
-- 
2.20.1

