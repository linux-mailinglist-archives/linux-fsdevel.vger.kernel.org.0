Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0CE6F8814
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 19:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbjEERw5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 13:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbjEERww (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 13:52:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6945E191CD;
        Fri,  5 May 2023 10:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=g0rV437tY8dOCjqBKssMb5KnN1Lw3wQoRxKKU/UO4Aw=; b=QUiYU3BRfbawH7skOJcRhQIoxz
        e1FQWgPXZhADCeF+0PV72Qk6g0s7KWoMfkjZjj+7Z5aQsN8MtwAP5vuK7DB4tU6SBtnTM8mycrpbA
        LrgGAM+xDXVuIYE7IlHcNjc3jNk+CobQu8tGNGxddgYjEM6sZ0C6FlPjuAA4uoITZgUOoQLnF+0xV
        HqaWMEFkAMkxpV+2Y1LX2+2YFI6SSVuv5y6sAxqaMrK3sxw177QY2rckvQ90kwSfwkYVBC3RulNb/
        HiQacRpOl4zD8jgTt0yWrKpRpg4LOKLVT24draVg84i82rvXZGl2DLUMkA1VD85u/n/K5BOjbUjU+
        7BZNTOPQ==;
Received: from 66-46-223-221.dedicated.allstream.net ([66.46.223.221] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1puzav-00BSxE-1L;
        Fri, 05 May 2023 17:51:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH 2/9] block: avoid repeated work in blk_mark_disk_dead
Date:   Fri,  5 May 2023 13:51:25 -0400
Message-Id: <20230505175132.2236632-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230505175132.2236632-1-hch@lst.de>
References: <20230505175132.2236632-1-hch@lst.de>
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
---
 block/genhd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index 461999e9489937..9a35b8443f0b5f 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -586,7 +586,9 @@ void blk_mark_disk_dead(struct gendisk *disk)
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

