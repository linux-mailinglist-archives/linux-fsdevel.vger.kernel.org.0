Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A7B2816B3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Oct 2020 17:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387893AbgJBPeF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Oct 2020 11:34:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54308 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388176AbgJBPeD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Oct 2020 11:34:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601652842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7xVzS++3PN7UGKLbZPL80Omojaxju7jz3l5esbvo97c=;
        b=ONOVS3kdCzwsn7UsFETWMl3xXoMcsB7IG8AcgSPfjCfk6lGKHM3CsVT6nUOyvJtOwd3CuN
        sDjD9hrkiVt+SC+wXnNCBXUAZBB9gabMX1pEycZrpx+duJ3nZDrisYKx3rjZsjYl6DOkJ3
        ZP9LZEx/bPRfC4IyXr/LbR0iRPHC73E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-SspypNg0OQKq50r0FwCQVQ-1; Fri, 02 Oct 2020 11:34:00 -0400
X-MC-Unique: SspypNg0OQKq50r0FwCQVQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E9991084D6E;
        Fri,  2 Oct 2020 15:33:58 +0000 (UTC)
Received: from bfoster.redhat.com (ovpn-114-177.rdu2.redhat.com [10.10.114.177])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 434C7702E7;
        Fri,  2 Oct 2020 15:33:58 +0000 (UTC)
From:   Brian Foster <bfoster@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org
Subject: [PATCH 1/2] iomap: resched ioend completion when in non-atomic context
Date:   Fri,  2 Oct 2020 11:33:56 -0400
Message-Id: <20201002153357.56409-2-bfoster@redhat.com>
In-Reply-To: <20201002153357.56409-1-bfoster@redhat.com>
References: <20201002153357.56409-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The iomap ioend mechanism has the ability to construct very large,
contiguous bios and/or bio chains. This has been reported to lead to
soft lockup warnings in bio completion due to the amount of page
processing that occurs. Update the ioend completion path with a
parameter to indicate atomic context and insert a cond_resched()
call to avoid soft lockups in either scenario.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/iomap/buffered-io.c | 15 +++++++++------
 fs/xfs/xfs_aops.c      |  2 +-
 include/linux/iomap.h  |  2 +-
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index bcfc288dba3f..5dfdb77a05b2 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1092,7 +1092,7 @@ iomap_finish_page_writeback(struct inode *inode, struct page *page,
  * ioend after this.
  */
 static void
-iomap_finish_ioend(struct iomap_ioend *ioend, int error)
+iomap_finish_ioend(struct iomap_ioend *ioend, int error, bool atomic)
 {
 	struct inode *inode = ioend->io_inode;
 	struct bio *bio = &ioend->io_inline_bio;
@@ -1115,8 +1115,11 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
 			next = bio->bi_private;
 
 		/* walk each page on bio, ending page IO on them */
-		bio_for_each_segment_all(bv, bio, iter_all)
+		bio_for_each_segment_all(bv, bio, iter_all) {
 			iomap_finish_page_writeback(inode, bv->bv_page, error);
+			if (!atomic)
+				cond_resched();
+		}
 		bio_put(bio);
 	}
 	/* The ioend has been freed by bio_put() */
@@ -1129,17 +1132,17 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
 }
 
 void
-iomap_finish_ioends(struct iomap_ioend *ioend, int error)
+iomap_finish_ioends(struct iomap_ioend *ioend, int error, bool atomic)
 {
 	struct list_head tmp;
 
 	list_replace_init(&ioend->io_list, &tmp);
-	iomap_finish_ioend(ioend, error);
+	iomap_finish_ioend(ioend, error, atomic);
 
 	while (!list_empty(&tmp)) {
 		ioend = list_first_entry(&tmp, struct iomap_ioend, io_list);
 		list_del_init(&ioend->io_list);
-		iomap_finish_ioend(ioend, error);
+		iomap_finish_ioend(ioend, error, atomic);
 	}
 }
 EXPORT_SYMBOL_GPL(iomap_finish_ioends);
@@ -1208,7 +1211,7 @@ static void iomap_writepage_end_bio(struct bio *bio)
 {
 	struct iomap_ioend *ioend = bio->bi_private;
 
-	iomap_finish_ioend(ioend, blk_status_to_errno(bio->bi_status));
+	iomap_finish_ioend(ioend, blk_status_to_errno(bio->bi_status), true);
 }
 
 /*
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index b35611882ff9..3e061ea99922 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -188,7 +188,7 @@ xfs_end_ioend(
 done:
 	if (ioend->io_private)
 		error = xfs_setfilesize_ioend(ioend, error);
-	iomap_finish_ioends(ioend, error);
+	iomap_finish_ioends(ioend, error, false);
 	memalloc_nofs_restore(nofs_flag);
 }
 
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 4d1d3c3469e9..4d3778dc4318 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -229,7 +229,7 @@ struct iomap_writepage_ctx {
 	const struct iomap_writeback_ops *ops;
 };
 
-void iomap_finish_ioends(struct iomap_ioend *ioend, int error);
+void iomap_finish_ioends(struct iomap_ioend *ioend, int error, bool atomic);
 void iomap_ioend_try_merge(struct iomap_ioend *ioend,
 		struct list_head *more_ioends,
 		void (*merge_private)(struct iomap_ioend *ioend,
-- 
2.25.4

