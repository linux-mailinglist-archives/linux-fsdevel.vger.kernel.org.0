Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E442816B2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Oct 2020 17:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388093AbgJBPeF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Oct 2020 11:34:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41475 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388115AbgJBPeC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Oct 2020 11:34:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601652841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JHcJj36zHRiJ6bf9ie64HvlM0zB1bc0CCjKGLinsI3c=;
        b=JRGeUFhCO4ocpKwB3nrXNCIpsddKVTQj4dNfdNQkK+2s0oBRrf0O/eCiDp40f/o+gJrX0m
        Milo2LVypN2gVU1W2i80mDPDO/8BeapWTD4UzL3I+K6WL7kwqQAz92pHnTS7TbxhXbRdBx
        LMqqq9SZ2evN+frYDHYlVpxbrFLFa9k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-1lolfs79NimJdh0iFAzocQ-1; Fri, 02 Oct 2020 11:34:00 -0400
X-MC-Unique: 1lolfs79NimJdh0iFAzocQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 337AC801AFB;
        Fri,  2 Oct 2020 15:33:59 +0000 (UTC)
Received: from bfoster.redhat.com (ovpn-114-177.rdu2.redhat.com [10.10.114.177])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CC8AB78813;
        Fri,  2 Oct 2020 15:33:58 +0000 (UTC)
From:   Brian Foster <bfoster@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org
Subject: [PATCH 2/2] xfs: kick extra large ioends to completion workqueue
Date:   Fri,  2 Oct 2020 11:33:57 -0400
Message-Id: <20201002153357.56409-3-bfoster@redhat.com>
In-Reply-To: <20201002153357.56409-1-bfoster@redhat.com>
References: <20201002153357.56409-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We've had reports of soft lockup warnings in the iomap ioend
completion path due to very large bios and/or bio chains. Divert any
ioends with 256k or more pages to process to the workqueue so
completion occurs in non-atomic context and can reschedule to avoid
soft lockup warnings.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/xfs/xfs_aops.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 3e061ea99922..84ee917014f1 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -30,6 +30,13 @@ XFS_WPC(struct iomap_writepage_ctx *ctx)
 	return container_of(ctx, struct xfs_writepage_ctx, ctx);
 }
 
+/*
+ * Kick extra large ioends off to the workqueue. Completion will process a lot
+ * of pages for a large bio or bio chain and a non-atomic context is required to
+ * reschedule and avoid soft lockup warnings.
+ */
+#define XFS_LARGE_IOEND	(262144 << PAGE_SHIFT)
+
 /*
  * Fast and loose check if this write could update the on-disk inode size.
  */
@@ -239,7 +246,8 @@ static inline bool xfs_ioend_needs_workqueue(struct iomap_ioend *ioend)
 {
 	return ioend->io_private ||
 		ioend->io_type == IOMAP_UNWRITTEN ||
-		(ioend->io_flags & IOMAP_F_SHARED);
+		(ioend->io_flags & IOMAP_F_SHARED) ||
+		(ioend->io_size >= XFS_LARGE_IOEND);
 }
 
 STATIC void
-- 
2.25.4

