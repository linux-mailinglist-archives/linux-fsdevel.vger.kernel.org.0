Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F8E29ECD1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 14:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725554AbgJ2NYI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 09:24:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48736 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727009AbgJ2NYH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 09:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603977846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LIjuJOqsQwW30+SKQoN3FAByfEAXVCvb14GA26xjLV0=;
        b=UWIs6dp1/7Jyp0IAo2coyUqRLbc2dWJpswQ0TODwLdDT/OCFYryQL7BcC9+YO6mumzhCZK
        X7T7v8ECEP6qbY1pcQz5qcpWgJPGAaEtRc8BUGqgkS2lkVM9P41NsFpKYe9VNWkLm1XW1J
        kaRL5XKHJcih0wDTjh1tEu7XAkg4/KY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-k5combDPNo2rN734D2XroQ-1; Thu, 29 Oct 2020 09:24:04 -0400
X-MC-Unique: k5combDPNo2rN734D2XroQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90681195D452;
        Thu, 29 Oct 2020 13:23:28 +0000 (UTC)
Received: from bfoster.redhat.com (ovpn-113-186.rdu2.redhat.com [10.10.113.186])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 333055C1C4;
        Thu, 29 Oct 2020 13:23:28 +0000 (UTC)
From:   Brian Foster <bfoster@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org
Subject: [PATCH v2 3/3] iomap: clean up writeback state logic on writepage error
Date:   Thu, 29 Oct 2020 09:23:25 -0400
Message-Id: <20201029132325.1663790-4-bfoster@redhat.com>
In-Reply-To: <20201029132325.1663790-1-bfoster@redhat.com>
References: <20201029132325.1663790-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The iomap writepage error handling logic is a mash of old and
slightly broken XFS writepage logic. When keepwrite writeback state
tracking was introduced in XFS in commit 0d085a529b42 ("xfs: ensure
WB_SYNC_ALL writeback handles partial pages correctly"), XFS had an
additional cluster writeback context that scanned ahead of
->writepage() to process dirty pages over the current ->writepage()
extent mapping. This context expected a dirty page and required
retention of the TOWRITE tag on partial page processing so the
higher level writeback context would revisit the page (in contrast
to ->writepage(), which passes a page with the dirty bit already
cleared).

The cluster writeback mechanism was eventually removed and some of
the error handling logic folded into the primary writeback path in
commit 150d5be09ce4 ("xfs: remove xfs_cancel_ioend"). This patch
accidentally conflated the two contexts by using the keepwrite logic
in ->writepage() without accounting for the fact that the page is
not dirty. Further, the keepwrite logic has no practical effect on
the core ->writepage() caller (write_cache_pages()) because it never
revisits a page in the current function invocation.

Technically, the page should be redirtied for the keepwrite logic to
have any effect. Otherwise, write_cache_pages() may find the tagged
page but will skip it since it is clean. Even if the page was
redirtied, however, there is still no practical effect to keepwrite
since write_cache_pages() does not wrap around within a single
invocation of the function. Therefore, the dirty page would simply
end up retagged on the next writeback sequence over the associated
range.

All that being said, none of this really matters because redirtying
a partially processed page introduces a potential infinite redirty
-> writeback failure loop that deviates from the current design
principle of clearing the dirty state on writepage failure to avoid
building up too much dirty, unreclaimable memory on the system.
Therefore, drop the spurious keepwrite usage and dirty state
clearing logic from iomap_writepage_map(), treat the partially
processed page the same as a fully processed page, and let the
imminent ioend failure clean up the writeback state.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/iomap/buffered-io.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index d1f04eabc7e4..e3a4568f6c2e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1404,6 +1404,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	WARN_ON_ONCE(!wpc->ioend && !list_empty(&submit_list));
 	WARN_ON_ONCE(!PageLocked(page));
 	WARN_ON_ONCE(PageWriteback(page));
+	WARN_ON_ONCE(PageDirty(page));
 
 	/*
 	 * We cannot cancel the ioend directly here on error.  We may have
@@ -1425,21 +1426,9 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 			unlock_page(page);
 			goto done;
 		}
-
-		/*
-		 * If the page was not fully cleaned, we need to ensure that the
-		 * higher layers come back to it correctly.  That means we need
-		 * to keep the page dirty, and for WB_SYNC_ALL writeback we need
-		 * to ensure the PAGECACHE_TAG_TOWRITE index mark is not removed
-		 * so another attempt to write this page in this writeback sweep
-		 * will be made.
-		 */
-		set_page_writeback_keepwrite(page);
-	} else {
-		clear_page_dirty_for_io(page);
-		set_page_writeback(page);
 	}
 
+	set_page_writeback(page);
 	unlock_page(page);
 
 	/*
-- 
2.25.4

