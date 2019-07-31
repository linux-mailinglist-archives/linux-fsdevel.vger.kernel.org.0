Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 612837C485
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2019 16:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387782AbfGaONL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 10:13:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49454 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbfGaONL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 10:13:11 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4F05C308424C;
        Wed, 31 Jul 2019 14:13:11 +0000 (UTC)
Received: from pegasus.maiolino.com (unknown [10.40.205.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C9B660852;
        Wed, 31 Jul 2019 14:13:09 +0000 (UTC)
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     hch@lst.de, adilger@dilger.ca, jaegeuk@kernel.org,
        darrick.wong@oracle.com, miklos@szeredi.hu, rpeterso@redhat.com,
        linux-xfs@vger.kernel.org
Subject: [PATCH 4/9] fibmap: Use bmap instead of ->bmap method in ioctl_fibmap
Date:   Wed, 31 Jul 2019 16:12:40 +0200
Message-Id: <20190731141245.7230-5-cmaiolino@redhat.com>
In-Reply-To: <20190731141245.7230-1-cmaiolino@redhat.com>
References: <20190731141245.7230-1-cmaiolino@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 31 Jul 2019 14:13:11 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now we have the possibility of proper error return in bmap, use bmap()
function in ioctl_fibmap() instead of calling ->bmap method directly.

Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---

Changelog:

V4:
	- Ensure ioctl_fibmap() returns 0 in case of error returned from
	  bmap(). Otherwise we'll be changing the user interface (which
	  returns 0 in case of error)
V3:
	- Rename usr_blk to ur_block

V2:
	- Use a local sector_t variable to asign the block number
	  instead of using direct casting.

 fs/ioctl.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index fef3a6bf7c78..6b589c873bc2 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -53,19 +53,28 @@ EXPORT_SYMBOL(vfs_ioctl);
 
 static int ioctl_fibmap(struct file *filp, int __user *p)
 {
-	struct address_space *mapping = filp->f_mapping;
-	int res, block;
+	struct inode *inode = file_inode(filp);
+	int error, ur_block;
+	sector_t block;
 
-	/* do we support this mess? */
-	if (!mapping->a_ops->bmap)
-		return -EINVAL;
 	if (!capable(CAP_SYS_RAWIO))
 		return -EPERM;
-	res = get_user(block, p);
-	if (res)
-		return res;
-	res = mapping->a_ops->bmap(mapping, block);
-	return put_user(res, p);
+
+	error = get_user(ur_block, p);
+	if (error)
+		return error;
+
+	block = ur_block;
+	error = bmap(inode, &block);
+
+	if (error)
+		ur_block = 0;
+	else
+		ur_block = block;
+
+	error = put_user(ur_block, p);
+
+	return error;
 }
 
 /**
-- 
2.20.1

