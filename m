Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E137BDC2F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 14:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376437AbjJIMeo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 08:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346678AbjJIMec (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:34:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC9010D;
        Mon,  9 Oct 2023 05:34:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5852C433CB;
        Mon,  9 Oct 2023 12:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696854840;
        bh=1XOQKvKpjSd/+56eqGAnKA9SYfbekuL9uuFHtuJE7dg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=gPSmAxvYgN+cpMs9bF+LDR60qs+ykUOZZmoZzJQgovcuby88sGcfyw4HSca4wgMNF
         yNkfqQ4PcYZeFW2wcuf4mMENl6Brz2ryJBOaYF5H3W/RvSZRCGmJN/ATxh/uTbk06x
         87BgTkpbNLn9vQcPQpAnWjPxVJP3iXyauinQxU5d0iOWmpizi1KQGXC23SQGNoFjlp
         yxenpEgxKfOoodxth+5PsyBchIZhlOiIr4fXVZaOMd4UFEIOS65ykKNlwyVRjYXOaJ
         nx/F+kFJzY4jSXF8bj2u5T+3KeICSDY04djCWCZsT40bN3eIjUtkqE+3OopWsebzKu
         1sHrXCZ5g1Ukw==
From:   Christian Brauner <brauner@kernel.org>
Date:   Mon, 09 Oct 2023 14:33:41 +0200
Subject: [PATCH 4/4] reiserfs: fix journal device opening
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231009-vfs-fixes-reiserfs-v1-4-723a2f1132ce@kernel.org>
References: <20231009-vfs-fixes-reiserfs-v1-0-723a2f1132ce@kernel.org>
In-Reply-To: <20231009-vfs-fixes-reiserfs-v1-0-723a2f1132ce@kernel.org>
To:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Cc:     reiserfs-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        syzbot+062317ea1d0a6d5e29e7@syzkaller.appspotmail.com,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2042; i=brauner@kernel.org;
 h=from:subject:message-id; bh=1XOQKvKpjSd/+56eqGAnKA9SYfbekuL9uuFHtuJE7dg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQqf9bvb760dda21bEpnqHT3Dv/2R1r7pqTdupqB4/Ix+Xz
 3wT1dZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk/W9Ghi0qqzdd4W/Xr2E1FsxUDU
 qZKlhQqLDxgjnPvDgpV+flfIwMXVuclpf8OsjTsE8mMLr/UsV5dxa1NdWtB1hKDpZd85FkAAA=
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

We can't open devices with s_umount held without risking deadlocks.
So drop s_umount and reacquire it when opening the journal device.

Reported-by: syzbot+062317ea1d0a6d5e29e7@syzkaller.appspotmail.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/reiserfs/journal.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index e001a96fc76c..0c680de72d43 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -2714,7 +2714,7 @@ int journal_init(struct super_block *sb, const char *j_dev_name,
 	struct reiserfs_journal_header *jh;
 	struct reiserfs_journal *journal;
 	struct reiserfs_journal_list *jl;
-	int ret;
+	int ret = 1;
 
 	journal = SB_JOURNAL(sb) = vzalloc(sizeof(struct reiserfs_journal));
 	if (!journal) {
@@ -2727,6 +2727,13 @@ int journal_init(struct super_block *sb, const char *j_dev_name,
 	INIT_LIST_HEAD(&journal->j_working_list);
 	INIT_LIST_HEAD(&journal->j_journal_list);
 	journal->j_persistent_trans = 0;
+
+	/*
+	 * blkdev_put() can't be called under s_umount, see the comment
+	 * in get_tree_bdev() for more details
+	 */
+	up_write(&sb->s_umount);
+
 	if (reiserfs_allocate_list_bitmaps(sb, journal->j_list_bitmap,
 					   reiserfs_bmap_count(sb)))
 		goto free_and_return;
@@ -2891,8 +2898,7 @@ int journal_init(struct super_block *sb, const char *j_dev_name,
 		goto free_and_return;
 	}
 
-	ret = journal_read(sb);
-	if (ret < 0) {
+	if (journal_read(sb) < 0) {
 		reiserfs_warning(sb, "reiserfs-2006",
 				 "Replay Failure, unable to mount");
 		goto free_and_return;
@@ -2900,10 +2906,14 @@ int journal_init(struct super_block *sb, const char *j_dev_name,
 
 	INIT_DELAYED_WORK(&journal->j_work, flush_async_commits);
 	journal->j_work_sb = sb;
-	return 0;
+	ret = 0;
+
 free_and_return:
-	free_journal_ram(sb);
-	return 1;
+	if (ret)
+		free_journal_ram(sb);
+
+	down_write(&sb->s_umount);
+	return ret;
 }
 
 /*

-- 
2.34.1

