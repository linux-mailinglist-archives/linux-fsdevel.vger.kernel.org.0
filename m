Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C55935A0C3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 16:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbhDIOMd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 10:12:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25490 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233619AbhDIOM3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 10:12:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617977536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9vFh6ZigDHKjuOkeRll+1rlsfe8Hj/YpJqm20S04nUo=;
        b=BaG3Syv0Pm21OvbJl/C6ppo6VkcHkFMZy+Jg6Mn/K5WN3/5wvrhvuPpXi1LK7NTlRjY/RK
        g6cQ61YbzVzBq0xgRFkiAw12ieLCJpK/JWQgHOGIAB+FCpjhb1ihkByQXHV6na3/MjrIUL
        dJKgsPLkwfwPgAucyS9UeiJ2iMoHRNY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-VfavZiGqOXmt2K8Cx8CzhQ-1; Fri, 09 Apr 2021 10:12:13 -0400
X-MC-Unique: VfavZiGqOXmt2K8Cx8CzhQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1AA7B8030BB;
        Fri,  9 Apr 2021 14:12:13 +0000 (UTC)
Received: from bfoster.redhat.com (ovpn-112-117.rdu2.redhat.com [10.10.112.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C00FC2C01F;
        Fri,  9 Apr 2021 14:12:12 +0000 (UTC)
From:   Brian Foster <bfoster@redhat.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 5/5] iomap: remove unused private field from ioend
Date:   Fri,  9 Apr 2021 10:12:10 -0400
Message-Id: <20210409141210.1000155-6-bfoster@redhat.com>
In-Reply-To: <20210409141210.1000155-1-bfoster@redhat.com>
References: <20210409141210.1000155-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The only remaining user of ->io_private is the generic ioend merging
infrastructure. The only user of that is XFS, which no longer sets
->io_private or passes an associated merge callback. Remove the
unused parameter and the ->io_private field.

CC: linux-fsdevel@vger.kernel.org
Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 7 +------
 fs/xfs/xfs_aops.c      | 2 +-
 include/linux/iomap.h  | 5 +----
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 414769a6ad11..b7753a7907e2 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1134,9 +1134,7 @@ iomap_ioend_can_merge(struct iomap_ioend *ioend, struct iomap_ioend *next)
 }
 
 void
-iomap_ioend_try_merge(struct iomap_ioend *ioend, struct list_head *more_ioends,
-		void (*merge_private)(struct iomap_ioend *ioend,
-				struct iomap_ioend *next))
+iomap_ioend_try_merge(struct iomap_ioend *ioend, struct list_head *more_ioends)
 {
 	struct iomap_ioend *next;
 
@@ -1148,8 +1146,6 @@ iomap_ioend_try_merge(struct iomap_ioend *ioend, struct list_head *more_ioends,
 			break;
 		list_move_tail(&next->io_list, &ioend->io_list);
 		ioend->io_size += next->io_size;
-		if (next->io_private && merge_private)
-			merge_private(ioend, next);
 	}
 }
 EXPORT_SYMBOL_GPL(iomap_ioend_try_merge);
@@ -1235,7 +1231,6 @@ iomap_alloc_ioend(struct inode *inode, struct iomap_writepage_ctx *wpc,
 	ioend->io_inode = inode;
 	ioend->io_size = 0;
 	ioend->io_offset = offset;
-	ioend->io_private = NULL;
 	ioend->io_bio = bio;
 	return ioend;
 }
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 8540180bd106..8275ee09733d 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -146,7 +146,7 @@ xfs_end_io(
 	while ((ioend = list_first_entry_or_null(&tmp, struct iomap_ioend,
 			io_list))) {
 		list_del_init(&ioend->io_list);
-		iomap_ioend_try_merge(ioend, &tmp, NULL);
+		iomap_ioend_try_merge(ioend, &tmp);
 		xfs_end_ioend(ioend);
 	}
 }
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index d202fd2d0f91..c87d0cb0de6d 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -198,7 +198,6 @@ struct iomap_ioend {
 	struct inode		*io_inode;	/* file being written to */
 	size_t			io_size;	/* size of the extent */
 	loff_t			io_offset;	/* offset in the file */
-	void			*io_private;	/* file system private data */
 	struct bio		*io_bio;	/* bio being built */
 	struct bio		io_inline_bio;	/* MUST BE LAST! */
 };
@@ -234,9 +233,7 @@ struct iomap_writepage_ctx {
 
 void iomap_finish_ioends(struct iomap_ioend *ioend, int error);
 void iomap_ioend_try_merge(struct iomap_ioend *ioend,
-		struct list_head *more_ioends,
-		void (*merge_private)(struct iomap_ioend *ioend,
-				struct iomap_ioend *next));
+		struct list_head *more_ioends);
 void iomap_sort_ioends(struct list_head *ioend_list);
 int iomap_writepage(struct page *page, struct writeback_control *wbc,
 		struct iomap_writepage_ctx *wpc,
-- 
2.26.3

