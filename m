Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72343D1016
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 15:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238825AbhGUNGg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 09:06:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28158 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238788AbhGUNGD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 09:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626875196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eiYfBTzqBLwjxFjmd1wf3xJRqWQqlFAJpRRIEev0yQ8=;
        b=SjgX77vvFYy6OLBH7FPl+SqOlRaWhllHyvAx9oBDtkGrYOF/OI7ah2xbKGQjjC6pEyGgbp
        3STJ2MHK/RRzZwjbE+N/rmOKg16ZPQFYzGfreFyW5MuALZekh+laWm9zO3wPEuE8ZdJQVk
        Ze2i824PMq0h597pgkWVoOOIKrOaW8Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-BDsfvdSzMLKJ9mscsg0FJA-1; Wed, 21 Jul 2021 09:46:35 -0400
X-MC-Unique: BDsfvdSzMLKJ9mscsg0FJA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18D8C18C8C0C;
        Wed, 21 Jul 2021 13:46:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-62.rdu2.redhat.com [10.10.112.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 75AF75C225;
        Wed, 21 Jul 2021 13:46:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 08/12] netfs: Keep dirty mark for pages with more than one
 dirty region
From:   David Howells <dhowells@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Mike Marshall <hubcap@omnibond.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        devel@lists.orangefs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 21 Jul 2021 14:46:28 +0100
Message-ID: <162687518862.276387.262991356873597293.stgit@warthog.procyon.org.uk>
In-Reply-To: <162687506932.276387.14456718890524355509.stgit@warthog.procyon.org.uk>
References: <162687506932.276387.14456718890524355509.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If a page has more than one dirty region overlapping it, then we mustn't
clear the dirty mark when we want to flush one of them.

Make netfs_set_page_writeback() check the adjacent dirty regions to see if
they overlap the page(s) the region we're interested in, and if they do,
leave the page marked dirty.

NOTES:

 (1) Might want to discount the overlapping regions if they're being
     flushed (in which case they wouldn't normally want to hold the dirty
     bit).

 (2) Similarly, the writeback mark should not be cleared if the page is
     still being written back by another, overlapping region.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/netfs/write_back.c |   41 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/fs/netfs/write_back.c b/fs/netfs/write_back.c
index 9fcb2ac50ebb..5c779cb12345 100644
--- a/fs/netfs/write_back.c
+++ b/fs/netfs/write_back.c
@@ -135,12 +135,47 @@ static int netfs_lock_pages(struct address_space *mapping,
 	return ret;
 }
 
-static int netfs_set_page_writeback(struct page *page)
+static int netfs_set_page_writeback(struct page *page,
+				    struct netfs_i_context *ctx,
+				    struct netfs_write_request *wreq)
 {
+	struct netfs_dirty_region *region = wreq->region, *r;
+	loff_t pos = page_offset(page);
+	bool clear_dirty = true;
+
 	/* Now we need to clear the dirty flags on any page that's not shared
 	 * with any other dirty region.
 	 */
-	if (!clear_page_dirty_for_io(page))
+	spin_lock(&ctx->lock);
+	if (pos < region->dirty.start) {
+		r = region;
+		list_for_each_entry_continue_reverse(r, &ctx->dirty_regions, dirty_link) {
+			if (r->dirty.end <= pos)
+				break;
+			if (r->state < NETFS_REGION_IS_DIRTY)
+				continue;
+			kdebug("keep-dirty-b %lx reg=%x r=%x",
+			       page->index, region->debug_id, r->debug_id);
+			clear_dirty = false;
+		}
+	}
+
+	pos += thp_size(page);
+	if (pos > region->dirty.end) {
+		r = region;
+		list_for_each_entry_continue(r, &ctx->dirty_regions, dirty_link) {
+			if (r->dirty.start >= pos)
+				break;
+			if (r->state < NETFS_REGION_IS_DIRTY)
+				continue;
+			kdebug("keep-dirty-f %lx reg=%x r=%x",
+			       page->index, region->debug_id, r->debug_id);
+			clear_dirty = false;
+		}
+	}
+	spin_unlock(&ctx->lock);
+
+	if (clear_dirty && !clear_page_dirty_for_io(page))
 		BUG();
 
 	/* We set writeback unconditionally because a page may participate in
@@ -225,7 +260,7 @@ static int netfs_begin_write(struct address_space *mapping,
 	trace_netfs_wreq(wreq);
 
 	netfs_iterate_pages(mapping, wreq->first, wreq->last,
-			    netfs_set_page_writeback);
+			    netfs_set_page_writeback, ctx, wreq);
 	netfs_unlock_pages(mapping, wreq->first, wreq->last);
 	iov_iter_xarray(&wreq->source, WRITE, &wreq->mapping->i_pages,
 			wreq->start, wreq->len);


