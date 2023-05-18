Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8017078FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 06:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjEREXv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 00:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjEREXs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 00:23:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F90A3A80;
        Wed, 17 May 2023 21:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=zVh8PQXTeVA8iyI9fAo2W/lxY0C5+PJZJOJGBkva1A8=; b=3ideWFXdZztm5NrMKUlwxpbXkk
        iMa4zmJpmJrGLGnSGCA4riM50MtfCF0+XvSEO55SY7IoqN0kPKw4Sj5Gr3z7MDw8nUSfVWXePwl18
        lfiRsEpdKMivGQFahxNZAMCkOps0s1/B58PKIv2PjMguf6El06FztyzE75DDoEn96LPDFBo8IJzoc
        JOGjjw5RVDOlbj8lIT8DfHDanVdr17c4yV9kDok7yH3RZoeiqNG4g40nRFMvT83qUwjA0B+e3pJQr
        qzDx9UU82h329S45jzV3UzO1CFnogsbTP8W7Zf+ZSTaL7D86hOWedFRYhP9IzYV+VcW6jtd98WHqP
        CDd4RDxQ==;
Received: from [2001:4bb8:188:3dd5:c90:b13:29fb:f2b9] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pzVAw-00BqOo-0M;
        Thu, 18 May 2023 04:23:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: [PATCH 05/13] block: avoid repeated work in blk_mark_disk_dead
Date:   Thu, 18 May 2023 06:23:14 +0200
Message-Id: <20230518042323.663189-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518042323.663189-1-hch@lst.de>
References: <20230518042323.663189-1-hch@lst.de>
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
index d8fe40c7d1f0a2..a744daeed55318 100644
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

