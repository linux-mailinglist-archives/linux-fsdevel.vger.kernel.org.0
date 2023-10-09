Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4017BDC28
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 14:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346551AbjJIMej (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 08:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346656AbjJIMeb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:34:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EAEC6;
        Mon,  9 Oct 2023 05:33:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37EAC433CA;
        Mon,  9 Oct 2023 12:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696854835;
        bh=/Tei9Zub8HjPOpjDb/mLaSHABMBEZFzrwXTdr2GFrfA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=pDpEFdgt6V8WNKXYKBcBHNJ7ibPO+Zj1nTTW/0HoXsGwe50ceSTWdqcIowKVHYOcB
         PDFYObCjUkgdOkySedgg0zctYWrbVLitutiFP1xdtOasSm8ZYY4abDjVU7991i3lQU
         jENvgs5u/fIQ1lWvE48cpXcwCSZfFXr4s4yuYKDLDRHMezjnu0TdSqUSAVupbsVten
         qVgLfaH/j4hyafb19iz8ZJ/nQ8082MBvSU13b3Ty4FqFq3HJ5I+ljppeUCeqDUCjU4
         5f7piksHlSB0r6NGGaOIZXKpXWa/mRbZcz6CQ4rkqJsIbvEqmV+AgBIpHkILs9BZiD
         JJTl9lkEVrzlg==
From:   Christian Brauner <brauner@kernel.org>
Date:   Mon, 09 Oct 2023 14:33:38 +0200
Subject: [PATCH 1/4] reiserfs: user superblock as holder for journal device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231009-vfs-fixes-reiserfs-v1-1-723a2f1132ce@kernel.org>
References: <20231009-vfs-fixes-reiserfs-v1-0-723a2f1132ce@kernel.org>
In-Reply-To: <20231009-vfs-fixes-reiserfs-v1-0-723a2f1132ce@kernel.org>
To:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Cc:     reiserfs-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2116; i=brauner@kernel.org;
 h=from:subject:message-id; bh=/Tei9Zub8HjPOpjDb/mLaSHABMBEZFzrwXTdr2GFrfA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQqf9aft708X+xZ0VTfKY+/PWr/f2/+zCVHzHUme6TMbqtc
 GDR9Q0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEvjcy/C+1ZHj377kv7w2p5oYHCn
 yHdtyN7nj2zrZG7vvzG8GWJ/4yMpzp8NcwDT+lJJZ/9APvBlnOCZZXjZn4L139P3/7+4h2RVYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I see no reason to use the journal as the holder of the block device.
The superblock should be used. In the case were the journal and main
device are the same we can easily reclaim because the same holder is
used.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/reiserfs/journal.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index 015bfe4e4524..b9d9bf26d108 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -2591,12 +2591,7 @@ static void release_journal_dev(struct super_block *super,
 			       struct reiserfs_journal *journal)
 {
 	if (journal->j_dev_bd != NULL) {
-		void *holder = NULL;
-
-		if (journal->j_dev_bd->bd_dev != super->s_dev)
-			holder = journal;
-
-		blkdev_put(journal->j_dev_bd, holder);
+		blkdev_put(journal->j_dev_bd, super);
 		journal->j_dev_bd = NULL;
 	}
 }
@@ -2606,7 +2601,6 @@ static int journal_init_dev(struct super_block *super,
 			    const char *jdev_name)
 {
 	blk_mode_t blkdev_mode = BLK_OPEN_READ;
-	void *holder = journal;
 	int result;
 	dev_t jdev;
 
@@ -2621,10 +2615,8 @@ static int journal_init_dev(struct super_block *super,
 
 	/* there is no "jdev" option and journal is on separate device */
 	if ((!jdev_name || !jdev_name[0])) {
-		if (jdev == super->s_dev)
-			holder = NULL;
-		journal->j_dev_bd = blkdev_get_by_dev(jdev, blkdev_mode, holder,
-						      NULL);
+		journal->j_dev_bd = blkdev_get_by_dev(jdev, blkdev_mode, super,
+						      &fs_holder_ops);
 		if (IS_ERR(journal->j_dev_bd)) {
 			result = PTR_ERR(journal->j_dev_bd);
 			journal->j_dev_bd = NULL;
@@ -2638,8 +2630,8 @@ static int journal_init_dev(struct super_block *super,
 		return 0;
 	}
 
-	journal->j_dev_bd = blkdev_get_by_path(jdev_name, blkdev_mode, holder,
-					       NULL);
+	journal->j_dev_bd = blkdev_get_by_path(jdev_name, blkdev_mode, super,
+					       &fs_holder_ops);
 	if (IS_ERR(journal->j_dev_bd)) {
 		result = PTR_ERR(journal->j_dev_bd);
 		journal->j_dev_bd = NULL;

-- 
2.34.1

