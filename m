Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2DE4D4D90
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 16:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbiCJPss (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 10:48:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbiCJPsq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 10:48:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3964CDAC
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 07:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646927264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=l9mR/80qlAMFJEP55l81aNyJ85t2ielrHjLYKFMQaYQ=;
        b=KTN9ECwFXlZhIrYTzh4nJ1Jj73oLE2AHdIqGDFOTsPTW4geGuehiSF3il+iTCGe9SzoQVf
        JQhynYzFaucxP04hI1kxN4iwx14ysjqOVVNu4KwtJDEV7vKvWqEEck5t9adE1xTd7w5rip
        JGVrsvFoAglNIhePWhm9rCoSXmxv0mM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-P74NfXXjNsGi-zE_7koIOA-1; Thu, 10 Mar 2022 10:47:41 -0500
X-MC-Unique: P74NfXXjNsGi-zE_7koIOA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD6A3520E;
        Thu, 10 Mar 2022 15:47:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8889A832A5;
        Thu, 10 Mar 2022 15:47:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Fix potential thrashing in afs writeback
From:   David Howells <dhowells@redhat.com>
To:     marc.dionne@auristor.com
Cc:     linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 10 Mar 2022 15:47:37 +0000
Message-ID: <164692725757.2097000.2060513769492301854.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In afs_writepages_region(), if the dirty page we find is undergoing
writeback or write to cache, but the sync_mode is WB_SYNC_NONE, we go round
the loop trying the same page again and again with no pausing or waiting
unless and until another thread manages to clear the writeback and fscache
flags.

Fix this with three measures:

 (1) Advance the start to after the page we found.

 (2) Break out of the loop and return if rescheduling is requested.

 (3) Arbitrarily give up after a maximum of 5 skips.

Fixes: 31143d5d515e ("AFS: implement basic file write support")
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/write.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index 85c9056ba9fb..bd0201f4939a 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -701,7 +701,7 @@ static int afs_writepages_region(struct address_space *mapping,
 	struct folio *folio;
 	struct page *head_page;
 	ssize_t ret;
-	int n;
+	int n, skips = 0;
 
 	_enter("%llx,%llx,", start, end);
 
@@ -752,8 +752,15 @@ static int afs_writepages_region(struct address_space *mapping,
 #ifdef CONFIG_AFS_FSCACHE
 				folio_wait_fscache(folio);
 #endif
+			} else {
+				start += folio_size(folio);
 			}
 			folio_put(folio);
+			if (wbc->sync_mode == WB_SYNC_NONE) {
+				if (skips >= 5 || need_resched())
+					break;
+				skips++;
+			}
 			continue;
 		}
 


