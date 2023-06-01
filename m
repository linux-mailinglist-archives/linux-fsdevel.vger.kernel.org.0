Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A95071976A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 11:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjFAJpm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 05:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbjFAJp3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:45:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB96107;
        Thu,  1 Jun 2023 02:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=FCBrupMSi2gX4xBrWPykUficbuGDQWQogDz/WNYsqZU=; b=cEYDIK7id/fucsksAWexU/ieCz
        Qin08z4KispC9wOLvMd2ldfFTB3Is8I6MQVjLbhxL8X7JEApZ2KGtZwUI9imTxbi8TZhLd87NrOAG
        ZNVR0pK5kc3Kik9yz61Qvjlhjbj9AlHPywGmMTRVEsOAXN7roWqbGlrJ09cT0qCwRq/U+UUIC7c8C
        uMOEpPN5LQ880W7c12lSA8WFNrtIeKDNebSL7LITJUOqoma8bEgIIs9lhlKKVFfpLqZOtJD8GDkut
        cqk2WTeB1zDx2L+iDOWjZTRCDwWu8Q/L65k7r8U0sf63wlNeSgSlskhZp+4MU7JNO9CKlfPVQn0MB
        4PThO84Q==;
Received: from [2001:4bb8:182:6d06:35f3:1da0:1cc3:d86d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4es1-002m0W-0J;
        Thu, 01 Jun 2023 09:45:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: [PATCH 05/16] block: avoid repeated work in blk_mark_disk_dead
Date:   Thu,  1 Jun 2023 11:44:48 +0200
Message-Id: <20230601094459.1350643-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230601094459.1350643-1-hch@lst.de>
References: <20230601094459.1350643-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Check if GD_DEAD is already set in blk_mark_disk_dead, and don't
duplicate the work already done.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Christian Brauner <brauner@kernel.org>
---
 block/genhd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index aa327314905e63..6fa926a02d8534 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -575,7 +575,9 @@ void blk_mark_disk_dead(struct gendisk *disk)
 	/*
 	 * Fail any new I/O.
 	 */
-	set_bit(GD_DEAD, &disk->state);
+	if (test_and_set_bit(GD_DEAD, &disk->state))
+		return;
+
 	if (test_bit(GD_OWNS_QUEUE, &disk->state))
 		blk_queue_flag_set(QUEUE_FLAG_DYING, disk->queue);
 
-- 
2.39.2

