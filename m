Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBCD5403D18
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 17:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352243AbhIHP7B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 11:59:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43180 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352229AbhIHP7A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 11:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631116672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mLEHghLzNWkilh231F1gIAuGY3O3lXAULkapl+1j+JQ=;
        b=WRt+yAliikc7KvyQDCPohWYXc5up0NlvzHydDl7NI46e++HyhA/8IfxFGY0N7nPSn7p9Rl
        UggbCNegDmLCFC9o1wGLEdPxB3siYE/RoOmretnnt1TFC88TlSbDB8YIDjeAtOwuESGoCy
        0G25GuqO166tee8DnL8y5ifw9hqzHI8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-KOjKT64GO3uAMO7iEY6V3g-1; Wed, 08 Sep 2021 11:57:49 -0400
X-MC-Unique: KOjKT64GO3uAMO7iEY6V3g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E17184A5E1;
        Wed,  8 Sep 2021 15:57:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3192D1B5C1;
        Wed,  8 Sep 2021 15:57:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/6] afs: Fix page leak
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Marc Dionne <marc.dionne@auristor.com>, dhowells@redhat.com,
        markus.suvanto@gmail.com, Marc Dionne <marc.dionne@auristor.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 08 Sep 2021 16:57:46 +0100
Message-ID: <163111666635.283156.177701903478910460.stgit@warthog.procyon.org.uk>
In-Reply-To: <163111665183.283156.17200205573146438918.stgit@warthog.procyon.org.uk>
References: <163111665183.283156.17200205573146438918.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There's a loop in afs_extend_writeback() that adds extra pages to a write
we want to make to improve the efficiency of the writeback by making it
larger.  This loop stops, however, if we hit a page we can't write back
from immediately, but it doesn't get rid of the page ref we speculatively
acquired.

This was caused by the removal of the cleanup loop when the code switched
from using find_get_pages_contig() to xarray scanning as the latter only
gets a single page at a time, not a batch.

Fix this by putting the page on a ref on an early break from the loop.
Unfortunately, we can't just add that page to the pagevec we're employing
as we'll go through that and add those pages to the RPC call.

This was found by the generic/074 test.  It leaks ~4GiB of RAM each time it
is run - which can be observed with "top".

Fixes: e87b03f5830e ("afs: Prepare for use of THPs")
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
---

 fs/afs/write.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index c0534697268e..66b235266893 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -471,13 +471,18 @@ static void afs_extend_writeback(struct address_space *mapping,
 			}
 
 			/* Has the page moved or been split? */
-			if (unlikely(page != xas_reload(&xas)))
+			if (unlikely(page != xas_reload(&xas))) {
+				put_page(page);
 				break;
+			}
 
-			if (!trylock_page(page))
+			if (!trylock_page(page)) {
+				put_page(page);
 				break;
+			}
 			if (!PageDirty(page) || PageWriteback(page)) {
 				unlock_page(page);
+				put_page(page);
 				break;
 			}
 
@@ -487,6 +492,7 @@ static void afs_extend_writeback(struct address_space *mapping,
 			t = afs_page_dirty_to(page, priv);
 			if (f != 0 && !new_content) {
 				unlock_page(page);
+				put_page(page);
 				break;
 			}
 


