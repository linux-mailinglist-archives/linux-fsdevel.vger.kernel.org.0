Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0F81C5BFE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 17:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbgEEPnu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 11:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730542AbgEEPns (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 11:43:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784BAC061A0F;
        Tue,  5 May 2020 08:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=T9hlmD4cLiPH82HJGnuyqI3vUWindObEK5yJRLBkSkA=; b=thiflPlsOhbGGd4koxuACDElMI
        6UHbZn0a4oZKGibu8yKKdBVhUwdcGm1+7i/xDk0nB1qwO8yD0+A6Z9gt52d10GNxZhz6XBw+OQ5n3
        DBIexF06e8WBZIxsczSJIDDrgfdTlqJp3o/LjoF4nGblBACV68dc9gHuInZy4ftOqyElXTPgKt7fz
        2a9Bkua/chUQjQ7lvDY8WyKqiqZuWRLTaZCLu+uNJzDKvFstLC+3D/ojX41uXTaB1lpwLfPuLWgyx
        hh3Rvq7hEZqhODiT2fqSLywwAvrea03oYdRTNeqDWMuZvQ2VrWyqAXCJFOLg0bRcy8GeWTo4PAU94
        b29vi5UA==;
Received: from [2001:4bb8:191:66b6:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVzjX-00043C-UR; Tue, 05 May 2020 15:43:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-ext4@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     jack@suse.cz, tytso@mit.edu, adilger@dilger.ca,
        riteshh@linux.ibm.com, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: [PATCH 07/11] iomap: fix the iomap_fiemap prototype
Date:   Tue,  5 May 2020 17:43:20 +0200
Message-Id: <20200505154324.3226743-8-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200505154324.3226743-1-hch@lst.de>
References: <20200505154324.3226743-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

iomap_fiemap should take u64 start and len arguments, just like the
->fiemap prototype.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/iomap/fiemap.c     | 2 +-
 include/linux/iomap.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
index 0a807bbb2b4af..449705575acf9 100644
--- a/fs/iomap/fiemap.c
+++ b/fs/iomap/fiemap.c
@@ -66,7 +66,7 @@ iomap_fiemap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 }
 
 int iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fi,
-		loff_t start, loff_t len, const struct iomap_ops *ops)
+		u64 start, u64 len, const struct iomap_ops *ops)
 {
 	struct fiemap_ctx ctx;
 	loff_t ret;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 8b09463dae0db..63db02528b702 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -178,7 +178,7 @@ int iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf,
 			const struct iomap_ops *ops);
 int iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
-		loff_t start, loff_t len, const struct iomap_ops *ops);
+		u64 start, u64 len, const struct iomap_ops *ops);
 loff_t iomap_seek_hole(struct inode *inode, loff_t offset,
 		const struct iomap_ops *ops);
 loff_t iomap_seek_data(struct inode *inode, loff_t offset,
-- 
2.26.2

