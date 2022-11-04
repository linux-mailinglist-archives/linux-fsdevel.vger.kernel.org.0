Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155DA619D7A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Nov 2022 17:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbiKDQjR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Nov 2022 12:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbiKDQjM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:39:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8769C2C10E
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Nov 2022 09:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667579891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=98DS/ShV9PbTmYsJBJpYU7G9vDl9LaoIobMfit60y3k=;
        b=UQ8hN+/j33WOzm354DKyiNQV8NMJCCyQ0b8vo+bldZLYtQ8tl9u/JDfYukYP1GjLbsluTE
        6nnRxleA8oa49XnLw0xAHL707mesmU15tndZGfBUKHJGdxS9YTFmg9AwfLCTo6i9NtFihI
        CkM4lTvEzIOuyBOfC3tGwrelE9tKZgk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-H_dYYikvOU6jbZlu1Jeswg-1; Fri, 04 Nov 2022 12:38:08 -0400
X-MC-Unique: H_dYYikvOU6jbZlu1Jeswg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 852D8800B23;
        Fri,  4 Nov 2022 16:38:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C4B8C40C835A;
        Fri,  4 Nov 2022 16:38:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 2/2] netfs: Fix dodgy maths
From:   David Howells <dhowells@redhat.com>
To:     willy@infradead.org
Cc:     Jeff Layton <jlayton@kernel.org>, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        linux-kernel@vger.kernel.org
Date:   Fri, 04 Nov 2022 16:38:06 +0000
Message-ID: <166757988611.950645.7626959069846893164.stgit@warthog.procyon.org.uk>
In-Reply-To: <166757987929.950645.12595273010425381286.stgit@warthog.procyon.org.uk>
References: <166757987929.950645.12595273010425381286.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix the dodgy maths in netfs_rreq_unlock_folios().  start_page could be
inside the folio, in which case the calculation of pgpos will be come up
with a negative number (though for the moment rreq->start is rounded down
earlier and folios would have to get merged whilst locked)

Alter how this works to just frame the tracking in terms of absolute file
positions, rather than offsets from the start of the I/O request.  This
simplifies the maths and makes it easier to follow.

Fix the issue by using folio_pos() and folio_size() to calculate the end
position of the page.

Fixes: 3d3c95046742 ("netfs: Provide readahead and readpage netfs helpers")
Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/Y2SJw7w1IsIik3nb@casper.infradead.org/
---

 fs/netfs/buffered_read.c |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index baf668fb4315..7679a68e8193 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -17,9 +17,9 @@ void netfs_rreq_unlock_folios(struct netfs_io_request *rreq)
 {
 	struct netfs_io_subrequest *subreq;
 	struct folio *folio;
-	unsigned int iopos, account = 0;
 	pgoff_t start_page = rreq->start / PAGE_SIZE;
 	pgoff_t last_page = ((rreq->start + rreq->len) / PAGE_SIZE) - 1;
+	size_t account = 0;
 	bool subreq_failed = false;
 
 	XA_STATE(xas, &rreq->mapping->i_pages, start_page);
@@ -39,23 +39,23 @@ void netfs_rreq_unlock_folios(struct netfs_io_request *rreq)
 	 */
 	subreq = list_first_entry(&rreq->subrequests,
 				  struct netfs_io_subrequest, rreq_link);
-	iopos = 0;
 	subreq_failed = (subreq->error < 0);
 
 	trace_netfs_rreq(rreq, netfs_rreq_trace_unlock);
 
 	rcu_read_lock();
 	xas_for_each(&xas, folio, last_page) {
-		unsigned int pgpos, pgend;
+		loff_t pg_end;
 		bool pg_failed = false;
 
 		if (xas_retry(&xas, folio))
 			continue;
 
-		pgpos = (folio_index(folio) - start_page) * PAGE_SIZE;
-		pgend = pgpos + folio_size(folio);
+		pg_end = folio_pos(folio) + folio_size(folio) - 1;
 
 		for (;;) {
+			loff_t sreq_end;
+
 			if (!subreq) {
 				pg_failed = true;
 				break;
@@ -63,11 +63,11 @@ void netfs_rreq_unlock_folios(struct netfs_io_request *rreq)
 			if (test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags))
 				folio_start_fscache(folio);
 			pg_failed |= subreq_failed;
-			if (pgend < iopos + subreq->len)
+			sreq_end = subreq->start + subreq->len - 1;
+			if (pg_end < sreq_end)
 				break;
 
 			account += subreq->transferred;
-			iopos += subreq->len;
 			if (!list_is_last(&subreq->rreq_link, &rreq->subrequests)) {
 				subreq = list_next_entry(subreq, rreq_link);
 				subreq_failed = (subreq->error < 0);
@@ -75,7 +75,8 @@ void netfs_rreq_unlock_folios(struct netfs_io_request *rreq)
 				subreq = NULL;
 				subreq_failed = false;
 			}
-			if (pgend == iopos)
+
+			if (pg_end == sreq_end)
 				break;
 		}
 


