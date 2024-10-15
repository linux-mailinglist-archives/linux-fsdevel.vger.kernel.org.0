Return-Path: <linux-fsdevel+bounces-31933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5320E99DD23
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 06:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F28921F23166
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 04:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E6B172767;
	Tue, 15 Oct 2024 04:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wopLP0AC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873912B9A4;
	Tue, 15 Oct 2024 04:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728965636; cv=none; b=CamSizNyb29v8w3ijqV3Sj3fiUVZOURP6NAQ62ZvUmSI0pF9ZvL0KIYa2U2yKHbYoTnZWdyAIWbMgsIdm30pB6BKhbW3Zu29HavVPa/aPX7mPNHtgubop8R5702+NbnrS2RnWRr6mYEmi/8VOy2Z73Nz7cU9y4FGmgYGd4GmMGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728965636; c=relaxed/simple;
	bh=qhm5/G1t4ORR7apeSmEmhPgjtHdwcIyO3zWRObKhidk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=osckDCiO5eIW/LiPN0acNBwQ88reg5VSOiGxwjsUV5T1NVthjYXz+DsL8mOMqynaVSJtlyGP3BYvi/0O94h7Ii+IHm6ww0OLoGkz3B7kzxY7y9Ie+8gIyRXwYm5GCDlYSfYYoKFy3VPScQHQBxGV4ygVM1rsULdTOXop/f2GA2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wopLP0AC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=mk9AtiTBk0FKZgZvBif+eyLF92Y0AH1k0wOKr5Ar35o=; b=wopLP0ACvM5+Oa0vg4sUvcmRmv
	gZNCYRvE134XOP6kXp6iaECcznoZgzU1PF/qSn7hEUIPlTOA3vTU+KEzKLMuIQ1XgtkvD/A6n3GM1
	xdMBAjDdQJ/uMn9C9eWF+olfKAQfW8KLi0vNW6EnEmUXKv81Y5x5mIiqjNs/IWU/v1vHoLBGJQIbH
	dr+D4A98ZcMfDmDQuuAhJduA3aFCyLDHX4EZEYCYjp2puVIfmupM2YJn8k4+5XIoU/GA9pYTr7BWy
	abrvy3oij2UoPJxxRq331JA8vwak1txW6ba5qqnUOK4NzX/o4Q1oU/Ga21qTMH1eOeZ32EehNn6tJ
	et/O8H7w==;
Received: from 2a02-8389-2341-5b80-a6f6-1cc3-c123-683b.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:a6f6:1cc3:c123:683b] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t0YwT-000000072C4-2lrU;
	Tue, 15 Oct 2024 04:13:54 +0000
From: Christoph Hellwig <hch@lst.de>
To: brauner@kernel.org
Cc: djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] iomap: turn iomap_want_unshare_iter into an inline function
Date: Tue, 15 Oct 2024 06:13:50 +0200
Message-ID: <20241015041350.118403-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

iomap_want_unshare_iter currently sits in fs/iomap/buffered-io.c, which
depends on CONFIG_BLOCK.  It is also in used in fs/dax.c whіch has no
such dependency.  Given that it is a trivial check turn it into an inline
in include/linux/iomap.h to fix the DAX && !BLOCK build.

Fixes: 6ef6a0e821d3 ("iomap: share iomap_unshare_iter predicate code with fsdax")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 17 -----------------
 include/linux/iomap.h  | 19 +++++++++++++++++++
 2 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 604f786be4bc54..ef0b68bccbb612 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1270,23 +1270,6 @@ void iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
 }
 EXPORT_SYMBOL_GPL(iomap_write_delalloc_release);
 
-bool iomap_want_unshare_iter(const struct iomap_iter *iter)
-{
-	/*
-	 * Don't bother with blocks that are not shared to start with; or
-	 * mappings that cannot be shared, such as inline data, delalloc
-	 * reservations, holes or unwritten extents.
-	 *
-	 * Note that we use srcmap directly instead of iomap_iter_srcmap as
-	 * unsharing requires providing a separate source map, and the presence
-	 * of one is a good indicator that unsharing is needed, unlike
-	 * IOMAP_F_SHARED which can be set for any data that goes into the COW
-	 * fork for XFS.
-	 */
-	return (iter->iomap.flags & IOMAP_F_SHARED) &&
-		iter->srcmap.type == IOMAP_MAPPED;
-}
-
 static loff_t iomap_unshare_iter(struct iomap_iter *iter)
 {
 	struct iomap *iomap = &iter->iomap;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index e04c060e8fe185..664c5f2f0aaa2d 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -270,6 +270,25 @@ static inline loff_t iomap_last_written_block(struct inode *inode, loff_t pos,
 	return round_up(pos + written, i_blocksize(inode));
 }
 
+/*
+ * Check if the range needs to be unshared for a FALLOC_FL_UNSHARE_RANGE
+ * operation.
+ *
+ * Don't bother with blocks that are not shared to start with; or mappings that
+ * cannot be shared, such as inline data, delalloc reservations, holes or
+ * unwritten extents.
+ *
+ * Note that we use srcmap directly instead of iomap_iter_srcmap as unsharing
+ * requires providing a separate source map, and the presence of one is a good
+ * indicator that unsharing is needed, unlike IOMAP_F_SHARED which can be set
+ * for any data that goes into the COW fork for XFS.
+ */
+static inline bool iomap_want_unshare_iter(const struct iomap_iter *iter)
+{
+	return (iter->iomap.flags & IOMAP_F_SHARED) &&
+		iter->srcmap.type == IOMAP_MAPPED;
+}
+
 ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
 		const struct iomap_ops *ops, void *private);
 int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops);
-- 
2.45.2


