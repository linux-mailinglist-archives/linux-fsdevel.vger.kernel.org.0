Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF599383B0A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 May 2021 19:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239486AbhEQRSp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 May 2021 13:18:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57002 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235882AbhEQRSo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 May 2021 13:18:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621271846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OFHWngphh1h6Mxu0IxINP4n2sPHM5fvjAZsp4Nyy99s=;
        b=ZMILs1ueNCm/2z6jcVnZfheTTnpNDzfscguzs+n5NYElnJbdRNbVjB2qd+cnjEAoEBDxuX
        0n4qhWJKgjOhe0Q/byA11ID/SyGamfARoggrdEhXM/Y18AkubWtZOkHdzC/O7Ym0fUrlnN
        rdIHzK4TeMDI0+96P+pxEfHbBdCJ0VY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-3EWtdGeaONCJEfqVpmmu3g-1; Mon, 17 May 2021 13:17:25 -0400
X-MC-Unique: 3EWtdGeaONCJEfqVpmmu3g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43A34107ACE6;
        Mon, 17 May 2021 17:17:24 +0000 (UTC)
Received: from bfoster.redhat.com (ovpn-113-80.rdu2.redhat.com [10.10.113.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF7F65D9F2;
        Mon, 17 May 2021 17:17:23 +0000 (UTC)
From:   Brian Foster <bfoster@redhat.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 1/3] iomap: resched ioend completion when in non-atomic context
Date:   Mon, 17 May 2021 13:17:20 -0400
Message-Id: <20210517171722.1266878-2-bfoster@redhat.com>
In-Reply-To: <20210517171722.1266878-1-bfoster@redhat.com>
References: <20210517171722.1266878-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
index 414769a6ad11..642422775e4e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1061,7 +1061,7 @@ iomap_finish_page_writeback(struct inode *inode, struct page *page,
  * ioend after this.
  */
 static void
-iomap_finish_ioend(struct iomap_ioend *ioend, int error)
+iomap_finish_ioend(struct iomap_ioend *ioend, int error, bool atomic)
 {
 	struct inode *inode = ioend->io_inode;
 	struct bio *bio = &ioend->io_inline_bio;
@@ -1084,9 +1084,12 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
 			next = bio->bi_private;
 
 		/* walk each page on bio, ending page IO on them */
-		bio_for_each_segment_all(bv, bio, iter_all)
+		bio_for_each_segment_all(bv, bio, iter_all) {
 			iomap_finish_page_writeback(inode, bv->bv_page, error,
 					bv->bv_len);
+			if (!atomic)
+				cond_resched();
+		}
 		bio_put(bio);
 	}
 	/* The ioend has been freed by bio_put() */
@@ -1099,17 +1102,17 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
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
@@ -1178,7 +1181,7 @@ static void iomap_writepage_end_bio(struct bio *bio)
 {
 	struct iomap_ioend *ioend = bio->bi_private;
 
-	iomap_finish_ioend(ioend, blk_status_to_errno(bio->bi_status));
+	iomap_finish_ioend(ioend, blk_status_to_errno(bio->bi_status), true);
 }
 
 /*
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 9b08db45ce85..84cd6cf46b12 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -123,7 +123,7 @@ xfs_end_ioend(
 	if (!error && xfs_ioend_is_append(ioend))
 		error = xfs_setfilesize(ip, ioend->io_offset, ioend->io_size);
 done:
-	iomap_finish_ioends(ioend, error);
+	iomap_finish_ioends(ioend, error, false);
 	memalloc_nofs_restore(nofs_flag);
 }
 
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index d202fd2d0f91..07f3f4e69084 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -232,7 +232,7 @@ struct iomap_writepage_ctx {
 	const struct iomap_writeback_ops *ops;
 };
 
-void iomap_finish_ioends(struct iomap_ioend *ioend, int error);
+void iomap_finish_ioends(struct iomap_ioend *ioend, int error, bool atomic);
 void iomap_ioend_try_merge(struct iomap_ioend *ioend,
 		struct list_head *more_ioends,
 		void (*merge_private)(struct iomap_ioend *ioend,
-- 
2.26.3

