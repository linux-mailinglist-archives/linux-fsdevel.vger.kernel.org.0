Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D9F7358CD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 15:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbjFSNnG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 09:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjFSNnF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:43:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFC0E74
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jun 2023 06:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687182136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tmhBzVk04OxjQU7+mvQb9QjdfMiM2IPBAE5pRAjvCBI=;
        b=LR9uOUTbXJzsT0c6xAhnFdo19vbqITjmJIPGPU5xdtKoD9FKzUMGV9BaOVUbkEcWPt/W3I
        hS/MKLHtZojlS72BFBIeteiNIws4+o1gicsj246cFdWG2E5YqoBP77sNXH7hgF8FivaY37
        v9R5dHQ/QrwDM/2LeJgtGAZ3hGurV5w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-401-cY5mjncINvWwWGUMnL5--g-1; Mon, 19 Jun 2023 09:42:11 -0400
X-MC-Unique: cY5mjncINvWwWGUMnL5--g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D65685A58C;
        Mon, 19 Jun 2023 13:42:11 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 906D8C1603B;
        Mon, 19 Jun 2023 13:42:10 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 2/2] afs: Fix waiting for writeback then skipping folio
Date:   Mon, 19 Jun 2023 14:42:04 +0100
Message-ID: <20230619134204.922713-3-dhowells@redhat.com>
In-Reply-To: <20230619134204.922713-1-dhowells@redhat.com>
References: <20230619134204.922713-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>

Commit acc8d8588cb7 converted afs_writepages_region() to write back a
folio batch. The function waits for writeback to a folio, but then
proceeds to the rest of the batch without trying to write that folio
again. This patch fixes has it attempt to write the folio again.

[DH: Also remove an 'else' that adding a goto makes redundant]

Fixes: acc8d8588cb7 ("afs: convert afs_writepages_region() to use filemap_get_folios_tag()")
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Link: https://lore.kernel.org/r/20230607204120.89416-2-vishal.moola@gmail.com/
---
 fs/afs/write.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index fd433024070e..8750b99c3f56 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -731,6 +731,7 @@ static int afs_writepages_region(struct address_space *mapping,
 			 * (changing page->mapping to NULL), or even swizzled
 			 * back from swapper_space to tmpfs file mapping
 			 */
+try_again:
 			if (wbc->sync_mode != WB_SYNC_NONE) {
 				ret = folio_lock_killable(folio);
 				if (ret < 0) {
@@ -757,9 +758,10 @@ static int afs_writepages_region(struct address_space *mapping,
 #ifdef CONFIG_AFS_FSCACHE
 					folio_wait_fscache(folio);
 #endif
-				} else {
-					start += folio_size(folio);
+					goto try_again;
 				}
+
+				start += folio_size(folio);
 				if (wbc->sync_mode == WB_SYNC_NONE) {
 					if (skips >= 5 || need_resched()) {
 						*_next = start;

