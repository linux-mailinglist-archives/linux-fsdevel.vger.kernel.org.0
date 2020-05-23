Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7091DF5A4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 May 2020 09:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387736AbgEWHaf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 May 2020 03:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387713AbgEWHae (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 May 2020 03:30:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8601C061A0E;
        Sat, 23 May 2020 00:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=T9hlmD4cLiPH82HJGnuyqI3vUWindObEK5yJRLBkSkA=; b=sQped7oEEdK9kI1k52SNqtaCQs
        RkmW1BhTmAlLNK4GkqbQvF6ngb1gyvYaATjXYjGQJ4BKeDGskRZCWdS81SqlyNJ7Xzdhi/gupvema
        Fy/dGb16nS1ipirGqIz7F07SQHS3PevX0fkaWczciut2ShdL2C3oLTo/8gG8ZV6web4lSxfaPATdL
        9N8yu/LltevwmfOncMZLiCCL0k2HoAW39MToBy0jqUUCfBWxBWDUkl+Hx5mwCeU0SAUiQ5ukVhgFu
        j4E60mP6SkVtzTTWLe3qwHaAMTxnnrFcCRP52xTaSz8eab8FRoHks9Up7u/lPLM8TtRMqm5cMkLtl
        EgKv9NlA==;
Received: from [2001:4bb8:18c:5da7:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jcOc5-0007t4-Bt; Sat, 23 May 2020 07:30:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-ext4@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     jack@suse.cz, tytso@mit.edu, adilger@dilger.ca,
        riteshh@linux.ibm.com, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: [PATCH 5/9] iomap: fix the iomap_fiemap prototype
Date:   Sat, 23 May 2020 09:30:12 +0200
Message-Id: <20200523073016.2944131-6-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523073016.2944131-1-hch@lst.de>
References: <20200523073016.2944131-1-hch@lst.de>
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

