Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75B93DF54F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 21:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239633AbhHCTSs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 15:18:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43527 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239628AbhHCTSq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 15:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628018315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eHAPyz9FQE5Ee8AyZmG2GtC2H3b8hfWmrC+ZK8I1sOc=;
        b=h3X1vuU9g/hBayDGIBivvGHAQmPjsGQFmKEf3/oF4oiWaf5KUhB53fTUHGDrbo1C1GrCxe
        AQDPG7wUagbDqmQgnN3EKLgNFvHpE4a+00VNmPP+38ObQd8sP5XYSDViZB58ZXqmfyqyHk
        4aOIhGC07Cgp1n0kWfyv7tV1iVvRSDo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-wmjaZHIfN8m5iYZckG7Xmw-1; Tue, 03 Aug 2021 15:18:32 -0400
X-MC-Unique: wmjaZHIfN8m5iYZckG7Xmw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E14D800489;
        Tue,  3 Aug 2021 19:18:30 +0000 (UTC)
Received: from max.com (unknown [10.40.193.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 24BAA60C0F;
        Tue,  3 Aug 2021 19:18:27 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v5 01/12] iov_iter: Fix iov_iter_get_pages{,_alloc} page fault return value
Date:   Tue,  3 Aug 2021 21:18:07 +0200
Message-Id: <20210803191818.993968-2-agruenba@redhat.com>
In-Reply-To: <20210803191818.993968-1-agruenba@redhat.com>
References: <20210803191818.993968-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Both iov_iter_get_pages and iov_iter_get_pages_alloc return the number of bytes
of the iovec they could get the pages for.  When they cannot get any pages,
they're supposed to return 0, but when the start of the iovec isn't page
aligned, the calculation goes wrong and they return a negative value.  Fix both
functions.

In addition, change iov_iter_get_pages_alloc to return NULL in that case to
prevent resource leaks.

It seems that the cifs and nfs filesystems don't handle the zero case very
well.  Could the maintainers please have a look?

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 lib/iov_iter.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index e23123ae3a13..25dfc48536d7 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1484,7 +1484,7 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
 		res = get_user_pages_fast(addr, n,
 				iov_iter_rw(i) != WRITE ?  FOLL_WRITE : 0,
 				pages);
-		if (unlikely(res < 0))
+		if (unlikely(res <= 0))
 			return res;
 		return (res == n ? len : res * PAGE_SIZE) - *start;
 	}
@@ -1608,8 +1608,9 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 			return -ENOMEM;
 		res = get_user_pages_fast(addr, n,
 				iov_iter_rw(i) != WRITE ?  FOLL_WRITE : 0, p);
-		if (unlikely(res < 0)) {
+		if (unlikely(res <= 0)) {
 			kvfree(p);
+			*pages = NULL;
 			return res;
 		}
 		*pages = p;
-- 
2.26.3

