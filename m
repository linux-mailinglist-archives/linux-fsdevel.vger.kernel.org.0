Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB7A3AFDE3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 15:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbfIKNn3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Sep 2019 09:43:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57826 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727302AbfIKNn3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Sep 2019 09:43:29 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CA4EB18C427A;
        Wed, 11 Sep 2019 13:43:28 +0000 (UTC)
Received: from pegasus.maiolino.com (ovpn-204-18.brq.redhat.com [10.40.204.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 82B3510016EB;
        Wed, 11 Sep 2019 13:43:27 +0000 (UTC)
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     hch@lst.de, adilger@dilger.ca, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org
Subject: [PATCH 4/9] fibmap: Use bmap instead of ->bmap method in ioctl_fibmap
Date:   Wed, 11 Sep 2019 15:43:10 +0200
Message-Id: <20190911134315.27380-5-cmaiolino@redhat.com>
In-Reply-To: <20190911134315.27380-1-cmaiolino@redhat.com>
References: <20190911134315.27380-1-cmaiolino@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Wed, 11 Sep 2019 13:43:28 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now we have the possibility of proper error return in bmap, use bmap()
function in ioctl_fibmap() instead of calling ->bmap method directly.

Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---
Changelog:

	V6:
		- Add a dummy bmap() definition so build does not break if
		  CONFIG_BLOCK is not set
			Reported-by: kbuild test robot <lkp@intel.com>
	V4:
		- Ensure ioctl_fibmap() returns 0 in case of error returned from
		  bmap(). Otherwise we'll be changing the user interface (which
		  returns 0 in case of error)
	V3:
		- Rename usr_blk to ur_block
	V2:
		- Use a local sector_t variable to asign the block number
		  instead of using direct casting.

 fs/ioctl.c         | 29 +++++++++++++++++++----------
 include/linux/fs.h |  7 +++++++
 2 files changed, 26 insertions(+), 10 deletions(-)

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
diff --git a/include/linux/fs.h b/include/linux/fs.h
index d787ceefc937..f1fbd8298ca4 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2859,9 +2859,16 @@ static inline ssize_t generic_write_sync(struct kiocb *iocb, ssize_t count)
 
 extern void emergency_sync(void);
 extern void emergency_remount(void);
+
 #ifdef CONFIG_BLOCK
 extern int bmap(struct inode *, sector_t *);
+#else
+static inline int bmap(struct inode *,  sector_t *)
+{
+	return -EINVAL;
+}
 #endif
+
 extern int notify_change(struct dentry *, struct iattr *, struct inode **);
 extern int inode_permission(struct inode *, int);
 extern int generic_permission(struct inode *, int);
-- 
2.20.1

