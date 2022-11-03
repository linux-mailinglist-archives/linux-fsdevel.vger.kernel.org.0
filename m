Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA43618A9C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 22:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiKCVe2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 17:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKCVe1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 17:34:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB471CE5
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Nov 2022 14:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667511211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=meSbCtcdhls8TiywckooFQyX4UhcYRP/sFZKWlTa6GQ=;
        b=P0nQl0kXy06GaaV8nY/6FxSfZPTJi7eb1keUoLjf+vOYiMp/CnJ9OeTfv69GaGDCm79xL9
        vEftDwehKNQmu+61EpcdNrHe5PTDXCBMg9rswkaS5pJo0jw0raZPLmm0k4mFm4SfGMefpi
        QTWR42l8F7WPlPWj/Dkw8jdwrhxX3dM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-EbztDGetOYmouMU7AEhUXw-1; Thu, 03 Nov 2022 17:33:30 -0400
X-MC-Unique: EbztDGetOYmouMU7AEhUXw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD7503C0D183;
        Thu,  3 Nov 2022 21:33:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E94A8112131B;
        Thu,  3 Nov 2022 21:33:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] netfs: Fix missing xas_retry() calls in xarray iteration
From:   David Howells <dhowells@redhat.com>
To:     willy@infradead.org
Cc:     George Law <glaw@redhat.com>, Jeff Layton <jlayton@kernel.org>,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        dhowells@redhat.com, linux-kernel@vger.kernel.org
Date:   Thu, 03 Nov 2022 21:33:28 +0000
Message-ID: <166751120808.117671.15797010154703575921.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

netfslib has a number of places in which it performs iteration of an xarray
whilst being under the RCU read lock.  It *should* call xas_retry() as the
first thing inside of the loop and do "continue" if it returns true in case
the xarray walker passed out a special value indicating that the walk needs
to be redone from the root[*].

Fix this by adding the missing retry checks.

[*] I wonder if this should be done inside xas_find(), xas_next_node() and
    suchlike, but I'm told that's not an simple change to effect.

This can cause an oops like that below.  Note the faulting address - this
is an internal value (|0x2) returned from xarray.

BUG: kernel NULL pointer dereference, address: 0000000000000402
...
RIP: 0010:netfs_rreq_unlock+0xef/0x380 [netfs]
...
Call Trace:
 netfs_rreq_assess+0xa6/0x240 [netfs]
 netfs_readpage+0x173/0x3b0 [netfs]
 ? init_wait_var_entry+0x50/0x50
 filemap_read_page+0x33/0xf0
 filemap_get_pages+0x2f2/0x3f0
 filemap_read+0xaa/0x320
 ? do_filp_open+0xb2/0x150
 ? rmqueue+0x3be/0xe10
 ceph_read_iter+0x1fe/0x680 [ceph]
 ? new_sync_read+0x115/0x1a0
 new_sync_read+0x115/0x1a0
 vfs_read+0xf3/0x180
 ksys_read+0x5f/0xe0
 do_syscall_64+0x38/0x90
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Fixes: 3d3c95046742 ("netfs: Provide readahead and readpage netfs helpers")
Reported-by: George Law <glaw@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
---

 fs/netfs/buffered_read.c |    9 +++++++--
 fs/netfs/io.c            |    3 +++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 0ce535852151..baf668fb4315 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -46,10 +46,15 @@ void netfs_rreq_unlock_folios(struct netfs_io_request *rreq)
 
 	rcu_read_lock();
 	xas_for_each(&xas, folio, last_page) {
-		unsigned int pgpos = (folio_index(folio) - start_page) * PAGE_SIZE;
-		unsigned int pgend = pgpos + folio_size(folio);
+		unsigned int pgpos, pgend;
 		bool pg_failed = false;
 
+		if (xas_retry(&xas, folio))
+			continue;
+
+		pgpos = (folio_index(folio) - start_page) * PAGE_SIZE;
+		pgend = pgpos + folio_size(folio);
+
 		for (;;) {
 			if (!subreq) {
 				pg_failed = true;
diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index 428925899282..e374767d1b68 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -121,6 +121,9 @@ static void netfs_rreq_unmark_after_write(struct netfs_io_request *rreq,
 		XA_STATE(xas, &rreq->mapping->i_pages, subreq->start / PAGE_SIZE);
 
 		xas_for_each(&xas, folio, (subreq->start + subreq->len - 1) / PAGE_SIZE) {
+			if (xas_retry(&xas, folio))
+				continue;
+
 			/* We might have multiple writes from the same huge
 			 * folio, but we mustn't unlock a folio more than once.
 			 */


