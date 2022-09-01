Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEEF5A90BC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 09:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbiIAHm4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 03:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbiIAHms (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:42:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7325C11E82A;
        Thu,  1 Sep 2022 00:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=dIecHME7GD9eTT6DRFQ8fxva9C5znLEXWNUzbOtIc9U=; b=vgEjvvYgl+Nd71/vogWCk5HxUN
        73x3c+GTNsDaFX7FxEnFnFsZBm1HPlrKZtMo4CaYN8KBTRvnYHCPMmYyssuCwcuq3+f7LyFh0RWoL
        KuKLGddfzVlyixJejGnFV08zUsX94fP09mJISaidG6Rk7x9eXdRw2m9TBALibjRZ8+iL/Pn1jKtLp
        yNUc8Lqzt+Np/KsefDRLabU0deaq8mqhK9x2ZaaioA14y7ZDZBnzN1K8ViwLxgx6iDfPu20e9ccXq
        JHERPA5z+Qwt0t5L5jKAa7Y2YKhyfbPwRSjuP+hkhGImioZf7/yAI587suBQiX1uxuTUDPI8LAPsR
        QBrtyDFA==;
Received: from 213-225-1-14.nat.highway.a1.net ([213.225.1.14] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTeqL-00ANWK-5o; Thu, 01 Sep 2022 07:42:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 02/17] btrfs: stop tracking failed reads in the I/O tree
Date:   Thu,  1 Sep 2022 10:42:01 +0300
Message-Id: <20220901074216.1849941-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220901074216.1849941-1-hch@lst.de>
References: <20220901074216.1849941-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is a separate I/O failure tree to track the fail reads, so remove
the extra EXTENT_DAMAGED bit in the I/O tree.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent-io-tree.h        |  1 -
 fs/btrfs/extent_io.c             | 16 +---------------
 fs/btrfs/tests/extent-io-tests.c |  1 -
 include/trace/events/btrfs.h     |  1 -
 4 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index ec2f8b8e6faa7..e218bb56d86ac 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -17,7 +17,6 @@ struct io_failure_record;
 #define EXTENT_NODATASUM	(1U << 7)
 #define EXTENT_CLEAR_META_RESV	(1U << 8)
 #define EXTENT_NEED_WAIT	(1U << 9)
-#define EXTENT_DAMAGED		(1U << 10)
 #define EXTENT_NORESERVE	(1U << 11)
 #define EXTENT_QGROUP_RESERVED	(1U << 12)
 #define EXTENT_CLEAR_DATA_RESV	(1U << 13)
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 591c191a58bc9..6ac76534d2c9e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2280,23 +2280,13 @@ int free_io_failure(struct extent_io_tree *failure_tree,
 		    struct io_failure_record *rec)
 {
 	int ret;
-	int err = 0;
 
 	set_state_failrec(failure_tree, rec->start, NULL);
 	ret = clear_extent_bits(failure_tree, rec->start,
 				rec->start + rec->len - 1,
 				EXTENT_LOCKED | EXTENT_DIRTY);
-	if (ret)
-		err = ret;
-
-	ret = clear_extent_bits(io_tree, rec->start,
-				rec->start + rec->len - 1,
-				EXTENT_DAMAGED);
-	if (ret && !err)
-		err = ret;
-
 	kfree(rec);
-	return err;
+	return ret;
 }
 
 /*
@@ -2521,7 +2511,6 @@ static struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode
 	u64 start = bbio->file_offset + bio_offset;
 	struct io_failure_record *failrec;
 	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
-	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
 	const u32 sectorsize = fs_info->sectorsize;
 	int ret;
 
@@ -2573,9 +2562,6 @@ static struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode
 			      EXTENT_LOCKED | EXTENT_DIRTY);
 	if (ret >= 0) {
 		ret = set_state_failrec(failure_tree, start, failrec);
-		/* Set the bits in the inode's tree */
-		ret = set_extent_bits(tree, start, start + sectorsize - 1,
-				      EXTENT_DAMAGED);
 	} else if (ret < 0) {
 		kfree(failrec);
 		return ERR_PTR(ret);
diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
index a232b15b8021f..ba4b7601e8c0a 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -80,7 +80,6 @@ static void extent_flag_to_str(const struct extent_state *state, char *dest)
 	PRINT_ONE_FLAG(state, dest, cur, NODATASUM);
 	PRINT_ONE_FLAG(state, dest, cur, CLEAR_META_RESV);
 	PRINT_ONE_FLAG(state, dest, cur, NEED_WAIT);
-	PRINT_ONE_FLAG(state, dest, cur, DAMAGED);
 	PRINT_ONE_FLAG(state, dest, cur, NORESERVE);
 	PRINT_ONE_FLAG(state, dest, cur, QGROUP_RESERVED);
 	PRINT_ONE_FLAG(state, dest, cur, CLEAR_DATA_RESV);
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 73df80d462dc8..f8a4118b16574 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -154,7 +154,6 @@ FLUSH_STATES
 	{ EXTENT_NODATASUM,		"NODATASUM"},		\
 	{ EXTENT_CLEAR_META_RESV,	"CLEAR_META_RESV"},	\
 	{ EXTENT_NEED_WAIT,		"NEED_WAIT"},		\
-	{ EXTENT_DAMAGED,		"DAMAGED"},		\
 	{ EXTENT_NORESERVE,		"NORESERVE"},		\
 	{ EXTENT_QGROUP_RESERVED,	"QGROUP_RESERVED"},	\
 	{ EXTENT_CLEAR_DATA_RESV,	"CLEAR_DATA_RESV"},	\
-- 
2.30.2

