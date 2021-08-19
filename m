Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56FC33F18D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 14:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238931AbhHSMMt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 08:12:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33464 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238105AbhHSMMp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 08:12:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629375129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=G+4vtigOnbB4xKnVedwIs1VfbakOzdLgEC5FdZhN+eM=;
        b=bKrWjYB8CXdrZAfiZ8Jhb0tLESpcxY88WvE04V3T/R88+176N1i3Y+d/IIWelqRLmFo0OQ
        WSKqthZavg+NWq8NB1ylyZMeYqbBMTj+mnw9rjlr1jzM4XPzvJB4jwYIuae3IDvgVSKGqu
        I/7tYJziLDetSv8xNMrwKi+k+3zNvsI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-NbsW2SVUPzShLwPalXqcwg-1; Thu, 19 Aug 2021 08:12:07 -0400
X-MC-Unique: NbsW2SVUPzShLwPalXqcwg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 780D5180FCA7;
        Thu, 19 Aug 2021 12:12:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F1ABE1B5B7;
        Thu, 19 Aug 2021 12:12:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Fix afs_launder_page() to set correct start file
 position
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     Jeffrey Altman <jaltman@auristor.com>,
        linux-afs@lists.infradead.org, dhowells@redhat.com,
        marc.dionne@auristor.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 19 Aug 2021 13:12:04 +0100
Message-ID: <162937512409.1449272.18441473411207824084.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix afs_launder_page() to set the starting position of the StoreData RPC at
the offset into the page at which the modified data starts instead of at
the beginning of the page (the iov_iter is correctly offset).

The offset got lost during the conversion to passing an iov_iter into
afs_store_data().

Fixes: bd80d8a80e12 ("afs: Use ITER_XARRAY for writing")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
cc: linux-afs@lists.infradead.org
Link: https://lore.kernel.org/r/162880783179.3421678.7795105718190440134.stgit@warthog.procyon.org.uk/
---

 fs/afs/write.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index fb7d5c1cabde..fff4c7d88e0d 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -950,8 +950,8 @@ int afs_launder_page(struct page *page)
 		iov_iter_bvec(&iter, WRITE, bv, 1, bv[0].bv_len);
 
 		trace_afs_page_dirty(vnode, tracepoint_string("launder"), page);
-		ret = afs_store_data(vnode, &iter, (loff_t)page->index * PAGE_SIZE,
-				     true);
+		ret = afs_store_data(vnode, &iter,
+				     (loff_t)page->index * PAGE_SIZE + f, true);
 	}
 
 	trace_afs_page_dirty(vnode, tracepoint_string("laundered"), page);


