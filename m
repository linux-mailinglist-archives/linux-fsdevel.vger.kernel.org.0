Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B8A1BA0A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 11:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgD0J7T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 05:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726434AbgD0J7S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 05:59:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C955C0610D5;
        Mon, 27 Apr 2020 02:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=D/ssPkWmDzAnmroUrBtklToL+PcgWRtAJglEt4/mTZQ=; b=U0+A+ZlWds8RizGI5/0ABloC/n
        FIZOMfejb6Xjpj8bWe6dhNU4n+/wQIf2udDN2HGCuS99hmxqSI/p7+G3eJYDggS1ZyHz40h6S/YuQ
        Fx4O0EjsST03eJJT6M9lDTU0nFz3MC9CiI6ZiimESDrFMkXayd3dNfRLuOlYOxF8IJZ+6x8lW2yx8
        CxSj/8ATRgZfQzWfyAOM8e3YqjbxR89PmgTDiMunw126H7qq275G6v3F+mQ1Ho/3xgXuXdGOHAmij
        HrW+XtP+Oi7mAk4Qwfp0ugXpv4a4ylAkkGKavhrMvE3Lr5M/dEOYkM3WMg+8c2shwyRrpJiM8QVyu
        6vbPq+7A==;
Received: from [2001:4bb8:193:f203:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jT0Xl-0003kJ-Qz; Mon, 27 Apr 2020 09:59:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-ext4@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     jack@suse.cz, tytso@mit.edu, adilger@dilger.ca,
        riteshh@linux.ibm.com, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: [PATCH 7/8] iomap: fix the iomap_fiemap prototype
Date:   Mon, 27 Apr 2020 11:58:57 +0200
Message-Id: <20200427095858.1440608-8-hch@lst.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200427095858.1440608-1-hch@lst.de>
References: <20200427095858.1440608-1-hch@lst.de>
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
---
 fs/iomap/fiemap.c     | 2 +-
 include/linux/iomap.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
index fca3dfb9d964a..dd04e4added15 100644
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
2.26.1

