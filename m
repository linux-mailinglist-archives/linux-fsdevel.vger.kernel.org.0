Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F11369330
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Apr 2021 15:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242907AbhDWNaI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Apr 2021 09:30:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56966 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242819AbhDWN3v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Apr 2021 09:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619184541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=claGAAAwAkYoHJ+sqsBkV8q9uRfXIUJw7gSPqT2Dahw=;
        b=RNGbpSH6t1lFp2Ls/JpJZ5t80QkXkn9LbxPy6Z0Y4/4aGWurPcDK2Wdf/sDYpOXWiTf7gL
        yoTSt6YrRIGnnyMXWAmQc2YPZ7Jp4JaqSN09bzTn2+NUto7aRCVDruJm5vhYZgH24wZlYj
        cojZ7pne9LmkZ9C2tQNdkLrToS6YmNI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-WXdkg2GmMNCD2H-1gpZk4w-1; Fri, 23 Apr 2021 09:28:58 -0400
X-MC-Unique: WXdkg2GmMNCD2H-1gpZk4w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01D6E107ACCD;
        Fri, 23 Apr 2021 13:28:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-124.rdu2.redhat.com [10.10.112.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 83D0F60C13;
        Fri, 23 Apr 2021 13:28:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v7 05/31] mm/readahead: Handle ractl nr_pages being modified
From:   David Howells <dhowells@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Jeff Layton <jlayton@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        dhowells@redhat.com,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date:   Fri, 23 Apr 2021 14:28:51 +0100
Message-ID: <161918453173.3145707.484012520187142542.stgit@warthog.procyon.org.uk>
In-Reply-To: <161918446704.3145707.14418606303992174310.stgit@warthog.procyon.org.uk>
References: <161918446704.3145707.14418606303992174310.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Matthew Wilcox (Oracle) <willy@infradead.org>

Filesystems are not currently permitted to modify the number of pages
in the ractl.  An upcoming patch to add readahead_expand() changes that
rule, so remove the check and resync the loop counter after every call
to the filesystem.

Tested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/20210420200116.3715790-1-willy@infradead.org/
Link: https://lore.kernel.org/r/20210421170923.4005574-1-willy@infradead.org/ # v2
---

 mm/readahead.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 2088569a947e..5b423ecc99f1 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -198,8 +198,6 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 	for (i = 0; i < nr_to_read; i++) {
 		struct page *page = xa_load(&mapping->i_pages, index + i);
 
-		BUG_ON(index + i != ractl->_index + ractl->_nr_pages);
-
 		if (page && !xa_is_value(page)) {
 			/*
 			 * Page already present?  Kick off the current batch
@@ -210,6 +208,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 			 * not worth getting one just for that.
 			 */
 			read_pages(ractl, &page_pool, true);
+			i = ractl->_index + ractl->_nr_pages - index - 1;
 			continue;
 		}
 
@@ -223,6 +222,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 					gfp_mask) < 0) {
 			put_page(page);
 			read_pages(ractl, &page_pool, true);
+			i = ractl->_index + ractl->_nr_pages - index - 1;
 			continue;
 		}
 		if (i == nr_to_read - lookahead_size)


