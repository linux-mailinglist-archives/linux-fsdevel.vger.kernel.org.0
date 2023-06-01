Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7159771976D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 11:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbjFAJpw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 05:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbjFAJph (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:45:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4F5138;
        Thu,  1 Jun 2023 02:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=YJQybKfCdLCIlGO1r6f0pU+uuBW5OJtJmoC2d/oJamo=; b=JbTNDwZUHQDUcxy8O6bTE5P6Zo
        gcD1ddqRinuAYUlqbqusDenhM/kdMxPo3rIGWWFdCxm8Zl1XIJGWoT3/4qVNrgUELTp1pxJIi2nkX
        855mXrzwH+P5TlO8idl0ODuCqvqPKz+sd0vNhUZVKg7tHEwv0hWvh5xo4nNRmg9RSUV/D+pIoF0e9
        5hyuAcIf9Gi5YbWHn6oQpAUwywZe5KrXrKcDVQxroK3ifg26RFm8XJQVH4tLogeog3dTjehwkI+av
        e/MUBtbi91Dg/QAbQtjEU3vzkp+cOFFAp3ityrixi0wMcOzBY8TczmPLvPivM+X+RBDDtSCmtvNAJ
        Bdn9F3jg==;
Received: from [2001:4bb8:182:6d06:35f3:1da0:1cc3:d86d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4es7-002m2b-0p;
        Thu, 01 Jun 2023 09:45:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: [PATCH 06/16] block: unhash the inode earlier in delete_partition
Date:   Thu,  1 Jun 2023 11:44:49 +0200
Message-Id: <20230601094459.1350643-7-hch@lst.de>
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

Move the call to remove_inode_hash to the beginning of delete_partition,
as we want to prevent opening a block_device that is about to be removed
ASAP.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 block/partitions/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 82d26427deae25..9d1debaa5caf9a 100644
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

