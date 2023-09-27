Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3387B053C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 15:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjI0NVt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 09:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbjI0NVq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 09:21:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C398121
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 06:21:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB430C433C9;
        Wed, 27 Sep 2023 13:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695820905;
        bh=cN9tY8OGDpR9T5D37vXQPEyp2WgyMszQnYS5olbSug8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ZmM7nnnbAeMM3BytwvXLbN5xstBK4IGnYc47ePZxj/834w4hCsP4Z2Rc7b552soqC
         8fROxfqA4OER5/UFELNnFv/tCpYnfNM1JXnuh12k717kub7NFEt95mBek6jhPC7kEY
         JwEOaSEbpdtwyoOeRtoYmR2/s8i2vpzbSEe4wpRanjtKYsOq3wOBVe5zOPmXu9NWAG
         je4C/Ip7aZl7TYecDm7H6Qr986TjCaeBQchz/rKlyyfPpIQBkwamYembh5eLTPuIvY
         Zmyrgu6y4PVflGgGASu8ASmzTfHuYGNcdOE9flM8g8wjxjiCOTOm9UWXHdSoDh7ZyW
         8N7LUzSi2FUmw==
From:   Christian Brauner <brauner@kernel.org>
Date:   Wed, 27 Sep 2023 15:21:15 +0200
Subject: [PATCH 2/7] bdev: add freeze and thaw holder operations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230927-vfs-super-freeze-v1-2-ecc36d9ab4d9@kernel.org>
References: <20230927-vfs-super-freeze-v1-0-ecc36d9ab4d9@kernel.org>
In-Reply-To: <20230927-vfs-super-freeze-v1-0-ecc36d9ab4d9@kernel.org>
To:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=915; i=brauner@kernel.org;
 h=from:subject:message-id; bh=cN9tY8OGDpR9T5D37vXQPEyp2WgyMszQnYS5olbSug8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSK6KSsU0lyjol42bpwf7Zp5JFzDBJfDq0+tcagdFns72mb
 wv6t6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI4lJGhmXXXeQu+i39E1LV8bb/tH
 xRbz33FSUzb1GrkOI0j3Ur3zL8Zrn6TeWv/zkZPpcDv79JWGcJbbn3avJT5Rq14Ay96XmneQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add block device freeze and thaw holder operations. Follow-up patches
will implement block device freeze and thaw based on stuct
blk_holder_ops.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/blkdev.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index bf25b63e13d5..f2ddccaaef4d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1468,6 +1468,16 @@ struct blk_holder_ops {
 	 * Sync the file system mounted on the block device.
 	 */
 	void (*sync)(struct block_device *bdev);
+
+	/*
+	 * Freeze the file system mounted on the block device.
+	 */
+	int (*freeze)(struct block_device *bdev);
+
+	/*
+	 * Thaw the file system mounted on the block device.
+	 */
+	int (*thaw)(struct block_device *bdev);
 };
 
 extern const struct blk_holder_ops fs_holder_ops;

-- 
2.34.1

