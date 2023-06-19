Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4327358D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 15:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjFSNnJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 09:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjFSNnF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:43:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92D5E68
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jun 2023 06:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687182134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D31vA8JX9DN+/zyM3aRK1TEDXyUSGbv3rJjPwoSWc28=;
        b=IkQ7JwckeizQ+KqBrJyy/Bdl1FjPDQx0NqKz73hZeuhKeA1FHDLaHbD6TSa+Ox6kBvR1eD
        qO56XhCVGKIZziZ/Q5oL/GbHLmdI2pPwBN08H+0FXe9aQhxX8Qyqp/pKxIWymE0lF6ECgz
        TMGvcOnsJ2MqH1GJ4WO86KIfyD5boJg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-292-Lf93kQWeN1uQcqW1Z8TCFA-1; Mon, 19 Jun 2023 09:42:10 -0400
X-MC-Unique: Lf93kQWeN1uQcqW1Z8TCFA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 080D785A59D;
        Mon, 19 Jun 2023 13:42:10 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 272D040C6E8E;
        Mon, 19 Jun 2023 13:42:09 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 1/2] afs: Fix dangling folio ref counts in writeback
Date:   Mon, 19 Jun 2023 14:42:03 +0100
Message-ID: <20230619134204.922713-2-dhowells@redhat.com>
In-Reply-To: <20230619134204.922713-1-dhowells@redhat.com>
References: <20230619134204.922713-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>

Commit acc8d8588cb7 converted afs_writepages_region() to write back a
folio batch. If writeback needs rescheduling, the function exits without
dropping the references to the folios in fbatch. This patch fixes that.

[DH: Moved the added line before the _leave()]

Fixes: acc8d8588cb7 ("afs: convert afs_writepages_region() to use filemap_get_folios_tag()")
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Link: https://lore.kernel.org/r/20230607204120.89416-1-vishal.moola@gmail.com/
---
 fs/afs/write.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index c822d6006033..fd433024070e 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -763,6 +763,7 @@ static int afs_writepages_region(struct address_space *mapping,
 				if (wbc->sync_mode == WB_SYNC_NONE) {
 					if (skips >= 5 || need_resched()) {
 						*_next = start;
+						folio_batch_release(&fbatch);
 						_leave(" = 0 [%llx]", *_next);
 						return 0;
 					}

