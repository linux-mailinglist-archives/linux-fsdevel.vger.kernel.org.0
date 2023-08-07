Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF52772239
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 13:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbjHGLai (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 07:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbjHGLaZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:30:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7966610C6;
        Mon,  7 Aug 2023 04:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=/Zn3NpNJWq/hZ5prwh3EWG/jr2VOTrVu8Gph2i+fSUQ=; b=1hOyzHBDzvjoL9S9paVvMSG/Ev
        86tUyqf5KZEiWSRo8pRl7Qzrf9SVzlA6JoV3gOzYsKNh8QFyAoG7vVUqGGbDG5b/D9IJOvN4wtryF
        OmwL71CG+z8jKK65wWU6RHq5k6lQ1ZOMxyoDiTRlnHl3JP/poDNyeJp+0s3UxHnG7HKXgGwker+qY
        CTe+ZQLc8WRFoLmGkpk+5/Y5tEk90PxlZNQWRLfsLuVx1KlS1q/6bIDCWx85dMi3S4g/S+/Y7mT3U
        jqn9PMlWI1dj+mK97db0zfvhLZEPFSz1Ipf+ZClZ5m9Ss/fN4s8EdfFhIwHjiSwMkPHLsEuNpmpkM
        OkdQPMpA==;
Received: from [82.33.212.90] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qSyNn-00H58p-3C;
        Mon, 07 Aug 2023 11:26:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, ocfs2-devel@lists.linux.dev,
        linux-block@vger.kernel.org
Subject: [PATCH 2/4] ext4: don't use bdev->bd_super in __ext4_journal_get_write_access
Date:   Mon,  7 Aug 2023 12:26:23 +0100
Message-Id: <20230807112625.652089-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230807112625.652089-1-hch@lst.de>
References: <20230807112625.652089-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

__ext4_journal_get_write_access already has a super_block available,
and there is no need to go from that to the bdev to go back to the
owning super_block.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ext4/ext4_jbd2.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 77f318ec8abb78..b38d59581411c0 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -234,8 +234,7 @@ int __ext4_journal_get_write_access(const char *where, unsigned int line,
 
 	might_sleep();
 
-	if (bh->b_bdev->bd_super)
-		ext4_check_bdev_write_error(bh->b_bdev->bd_super);
+	ext4_check_bdev_write_error(sb);
 
 	if (ext4_handle_valid(handle)) {
 		err = jbd2_journal_get_write_access(handle, bh);
-- 
2.39.2

