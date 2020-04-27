Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338C41BAC47
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 20:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgD0SUS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 14:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726519AbgD0SUQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 14:20:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD56C0610D5;
        Mon, 27 Apr 2020 11:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=D/ssPkWmDzAnmroUrBtklToL+PcgWRtAJglEt4/mTZQ=; b=GYrMVKe83AmFMQ8KTkcoioN+Ir
        KNlqFmhlCqOCNyf5MGfdf2NamCxbtbCrfh5T81IX53hfcy+HNaaJYZpa9UF1dhDYzfg5T18T0oX6e
        EsEyshCql6D6BRrovV3sXh0BbuuXMUWfZ0r7mg0s0zQtApPjdQEf+x7KCqnDQ/ivG4YSnm64aeByV
        NLeV/bSKnr+A6zP25MCbO52CgsrSmeDMH/tGJ77ntJDgj4jlxyUzUBHvDz5xzvJoV3ZYP/pgEjKsY
        mYu9PEcDnxG1R65/VQzpwPelIUsLb2nhzjhenXIBrKUJ13JjNio7aPE/kBSHrMjLBJjQS7MJ7K3mT
        uJvSrCsg==;
Received: from [2001:4bb8:193:f203:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jT8Ma-0004Yo-42; Mon, 27 Apr 2020 18:20:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-ext4@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     jack@suse.cz, tytso@mit.edu, adilger@dilger.ca,
        riteshh@linux.ibm.com, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: [PATCH 07/11] iomap: fix the iomap_fiemap prototype
Date:   Mon, 27 Apr 2020 20:19:53 +0200
Message-Id: <20200427181957.1606257-8-hch@lst.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200427181957.1606257-1-hch@lst.de>
References: <20200427181957.1606257-1-hch@lst.de>
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

