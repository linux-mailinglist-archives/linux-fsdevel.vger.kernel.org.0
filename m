Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAA4707900
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 06:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjEREXx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 00:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjEREXt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 00:23:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA653A9C;
        Wed, 17 May 2023 21:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=AEZFZY7uDblJqc6MRCkyc/4sDbTvR5XPNQTdXxY7VQE=; b=h4ELWNwnLh6K+WQmSi+mv7+A21
        ej+faSMvdhKBbK+s/bzbfWIZw4DQtNiCAkaBgU4/TFRzCCBYF1YDxF4GfUSoVGwesJldpjTEQMNRa
        gz1dZBtkbzRoeaBMc4c0nCyCVcasvOkvRamhALhOTrWWNPLNe/c/P0iNG5MQIFPr8KrKMoM44M7/P
        ffqDhsbGK0IgOzGMd1faygPHN7A0V+GYngLTkjk45rY2tRjD8RRCfFeH30E7jc9i7nx/Em96+XuTy
        ifmsdNqYe6rUe1bBhHIuyfDC2iFWP3BaPTjQOwrabnBAwVzIH0WX6kB6Uh0twaUidWHX5XpZHqm2G
        w+Hxy0eQ==;
Received: from [2001:4bb8:188:3dd5:c90:b13:29fb:f2b9] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pzVAy-00BqPV-1k;
        Thu, 18 May 2023 04:23:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: [PATCH 06/13] block: unhash the inode earlier in delete_partition
Date:   Thu, 18 May 2023 06:23:15 +0200
Message-Id: <20230518042323.663189-7-hch@lst.de>
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

Move the call to remove_inode_hash to the beginning of delete_partition,
as we want to prevent opening a block_device that is about to be removed
ASAP.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/partitions/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 49e0496ff23c1e..fa5c707fe0ad2f 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -267,6 +267,12 @@ static void delete_partition(struct block_device *part)
 {
 	lockdep_assert_held(&part->bd_disk->open_mutex);
 
+	/*
+	 * Remove the block device from the inode hash, so that it cannot be
+	 * looked up any more even when openers still hold references.
+	 */
+	remove_inode_hash(part->bd_inode);
+
 	fsync_bdev(part);
 	__invalidate_device(part, true);
 
@@ -274,12 +280,6 @@ static void delete_partition(struct block_device *part)
 	kobject_put(part->bd_holder_dir);
 	device_del(&part->bd_device);
 
-	/*
-	 * Remove the block device from the inode hash, so that it cannot be
-	 * looked up any more even when openers still hold references.
-	 */
-	remove_inode_hash(part->bd_inode);
-
 	put_device(&part->bd_device);
 }
 
-- 
2.39.2

