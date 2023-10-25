Return-Path: <linux-fsdevel+bounces-1179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E674A7D6E74
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 16:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 223011C20DDD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 14:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BDE28E2E;
	Wed, 25 Oct 2023 14:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kjmYQYUX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB5F286BF
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 14:10:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4636C18B;
	Wed, 25 Oct 2023 07:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=xXpAs87vXAa9NcBEUc0wVOYAyOZDx4ei3lj0IRgnDRM=; b=kjmYQYUXdwr23Na3Fs85kvexm3
	tKafXooWcQ+nC1AYT81ALSCMPJQR1IxvgYrd9qXM+tmSkjdQEyKwqtzdO/Rh8OxjRl9dZnqw+iHzK
	lz6ZYNJPwUISI38kJGEDyJ+fd2T4cuCaDbcMWZFGZG/nhWNKhN5Lmmx9UHt/uuCBVBBQZ4VhgTwCy
	ZF8IqLEMn5OUDYhEXtH9j5e4F8nhz+zqvspVy/I/TQfhff41N4CxOdZ4yJtrhUsx6Q0SCa+1Z8p1t
	1ICFXCt1HDWvaUE5GgJET3XdEzt3obj589ysFIjHVjgO9reBbkpYPXn9S2XmIc7excThupGm07EMF
	v1QPnScg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qveag-00CTws-0x;
	Wed, 25 Oct 2023 14:10:34 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Matthew Wilcox <willy@infradead.org>
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH 1/4] filemap: add a per-mapping stable writes flag
Date: Wed, 25 Oct 2023 16:10:17 +0200
Message-Id: <20231025141020.192413-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231025141020.192413-1-hch@lst.de>
References: <20231025141020.192413-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

folio_wait_stable waits for writeback to finish before modifying the
contents of a folio again, e.g. to support check summing of the data
in the block integrity code.

Currently this behavior is controlled by the SB_I_STABLE_WRITES flag
on the super_block, which means it is uniform for the entire file system.
This is wrong for the block device pseudofs which is shared by all
block devices, or file systems that can use multiple devices like XFS
witht the RT subvolume or btrfs (although btrfs currently reimplements
folio_wait_stable anyway).

Add a per-address_space AS_STABLE_WRITES flag to control the behavior
in a more fine grained way.  The existing SB_I_STABLE_WRITES is kept
to initialize AS_STABLE_WRITES to the existing default which covers
most cases.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Tested-by: Ilya Dryomov <idryomov@gmail.com>
---
 fs/inode.c              |  2 ++
 include/linux/pagemap.h | 17 +++++++++++++++++
 mm/page-writeback.c     |  2 +-
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index 84bc3c76e5ccb5..ae1a6410b53d7e 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -215,6 +215,8 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
 	lockdep_set_class_and_name(&mapping->invalidate_lock,
 				   &sb->s_type->invalidate_lock_key,
 				   "mapping.invalidate_lock");
+	if (sb->s_iflags & SB_I_STABLE_WRITES)
+		mapping_set_stable_writes(mapping);
 	inode->i_private = NULL;
 	inode->i_mapping = mapping;
 	INIT_HLIST_HEAD(&inode->i_dentry);	/* buggered by rcu freeing */
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 351c3b7f93a14e..8c9608b217b000 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -204,6 +204,8 @@ enum mapping_flags {
 	AS_NO_WRITEBACK_TAGS = 5,
 	AS_LARGE_FOLIO_SUPPORT = 6,
 	AS_RELEASE_ALWAYS,	/* Call ->release_folio(), even if no private data */
+	AS_STABLE_WRITES,	/* must wait for writeback before modifying
+				   folio contents */
 };
 
 /**
@@ -289,6 +291,21 @@ static inline void mapping_clear_release_always(struct address_space *mapping)
 	clear_bit(AS_RELEASE_ALWAYS, &mapping->flags);
 }
 
+static inline bool mapping_stable_writes(const struct address_space *mapping)
+{
+	return test_bit(AS_STABLE_WRITES, &mapping->flags);
+}
+
+static inline void mapping_set_stable_writes(struct address_space *mapping)
+{
+	set_bit(AS_STABLE_WRITES, &mapping->flags);
+}
+
+static inline void mapping_clear_stable_writes(struct address_space *mapping)
+{
+	clear_bit(AS_STABLE_WRITES, &mapping->flags);
+}
+
 static inline gfp_t mapping_gfp_mask(struct address_space * mapping)
 {
 	return mapping->gfp_mask;
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index b8d3d7040a506a..4656534b8f5cc6 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -3110,7 +3110,7 @@ EXPORT_SYMBOL_GPL(folio_wait_writeback_killable);
  */
 void folio_wait_stable(struct folio *folio)
 {
-	if (folio_inode(folio)->i_sb->s_iflags & SB_I_STABLE_WRITES)
+	if (mapping_stable_writes(folio_mapping(folio)))
 		folio_wait_writeback(folio);
 }
 EXPORT_SYMBOL_GPL(folio_wait_stable);
-- 
2.39.2


