Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00299332B19
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Mar 2021 16:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbhCIPzQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Mar 2021 10:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbhCIPy4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Mar 2021 10:54:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A24C06174A;
        Tue,  9 Mar 2021 07:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=TAB/jSR7P4i0tEpg6lVq01ZMIeZeWk00j+JpXBqlTDM=; b=T+H3yeYw5iLZv7pUgmsb25tUIS
        qPrxwvgXhTEZ/+r7gvFNaBtHWVhs+PHbFoxnkj3u3ZSdxQ1KPpmoPcESzA3k/SeQfbnnw7C7vmFV4
        ht9K8Nznds34Ck8c6U8ozAmgx/WZQEIqhVXZbzxQSPAkP1/qbORT5eOL56k3VB2PCjAbitpXHbgpu
        eiUF8/HeYWm75kV2gwxDcBw/l/+jgr0vuiYgcG+wnyVuvaRla7CnP3FJUd9MYQ7g8c4vFTQtC0aGz
        WlQPsUmOhiOmPqoIXuA+dDB2dUutIqClmDeHaP1qDtnQAjooDHIbfuprZiwSY9pToikcKK3d8G5z+
        Cxq7OdwQ==;
Received: from [2001:4bb8:180:9884:c70:4a89:bc61:3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lJegY-000lMp-OH; Tue, 09 Mar 2021 15:54:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Vetter <daniel@ffwll.ch>, Nadav Amit <namit@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 2/9] fs: add an argument-less alloc_anon_inode
Date:   Tue,  9 Mar 2021 16:53:41 +0100
Message-Id: <20210309155348.974875-3-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210309155348.974875-1-hch@lst.de>
References: <20210309155348.974875-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a new alloc_anon_inode helper that allocates an inode on
the anon_inode file system.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/anon_inodes.c            | 15 +++++++++++++--
 include/linux/anon_inodes.h |  1 +
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index 4745fc37014332..b6a8ea71920bc3 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -63,7 +63,7 @@ static struct inode *anon_inode_make_secure_inode(
 	const struct qstr qname = QSTR_INIT(name, strlen(name));
 	int error;
 
-	inode = alloc_anon_inode_sb(anon_inode_mnt->mnt_sb);
+	inode = alloc_anon_inode();
 	if (IS_ERR(inode))
 		return inode;
 	inode->i_flags &= ~S_PRIVATE;
@@ -225,13 +225,24 @@ int anon_inode_getfd_secure(const char *name, const struct file_operations *fops
 }
 EXPORT_SYMBOL_GPL(anon_inode_getfd_secure);
 
+/**
+ * alloc_anon_inode - create a new anonymous inode
+ *
+ * Create an inode on the anon_inode file system and return it.
+ */
+struct inode *alloc_anon_inode(void)
+{
+	return alloc_anon_inode_sb(anon_inode_mnt->mnt_sb);
+}
+EXPORT_SYMBOL_GPL(alloc_anon_inode);
+
 static int __init anon_inode_init(void)
 {
 	anon_inode_mnt = kern_mount(&anon_inode_fs_type);
 	if (IS_ERR(anon_inode_mnt))
 		panic("anon_inode_init() kernel mount failed (%ld)\n", PTR_ERR(anon_inode_mnt));
 
-	anon_inode_inode = alloc_anon_inode_sb(anon_inode_mnt->mnt_sb);
+	anon_inode_inode = alloc_anon_inode();
 	if (IS_ERR(anon_inode_inode))
 		panic("anon_inode_init() inode allocation failed (%ld)\n", PTR_ERR(anon_inode_inode));
 
diff --git a/include/linux/anon_inodes.h b/include/linux/anon_inodes.h
index 71881a2b6f7860..b5ae9a6eda9923 100644
--- a/include/linux/anon_inodes.h
+++ b/include/linux/anon_inodes.h
@@ -21,6 +21,7 @@ int anon_inode_getfd_secure(const char *name,
 			    const struct file_operations *fops,
 			    void *priv, int flags,
 			    const struct inode *context_inode);
+struct inode *alloc_anon_inode(void);
 
 #endif /* _LINUX_ANON_INODES_H */
 
-- 
2.30.1

