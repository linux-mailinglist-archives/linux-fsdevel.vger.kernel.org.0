Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7217522EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 15:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbjGMNGO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 09:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234372AbjGMNFw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:05:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617263A8E;
        Thu, 13 Jul 2023 06:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ZOkQVTJJYdXe/u2csdGqahKYBWo+lvzD5ymfs7yQGIc=; b=3bUjfMwEEHlLAcqaJRpRhI2RUn
        ScmA+KKqf2RUCTbmcrRDpO7nltbKGTKMD+CQZisIlPz+xqgajGzilCbQQ30tOdK9D7Ll9oRcEJf7c
        V+imnDA8VIKtY43fHmPz3HaABn19EzokCx0/1BpgHS7Gh9SQKd+zN51dkN46wBZOavoCWMkjZAuNA
        J1EphwDGup6OozQjRojShLJ9WYaZiq/NAqgKEiJMmA7uek9fFO2cdTyw8TBP9HDgaCvdmUq4aLVra
        e5Fv1Rut/ZDZzUt41aUuO23+eFh5PHyG2sMaat1BeAyx+4HhJHI2PgLGv07idXlw2zsH+d3HSPwab
        LvYBPoDQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qJvzu-003LVX-1B;
        Thu, 13 Jul 2023 13:04:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/9] btrfs: fix an error handling corner case in cow_file_range
Date:   Thu, 13 Jul 2023 15:04:25 +0200
Message-Id: <20230713130431.4798-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230713130431.4798-1-hch@lst.de>
References: <20230713130431.4798-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When the call to btrfs_reloc_clone_csums in cow_file_range returns an
error, we jump to the out_unlock label with the extent_reserved variable
set to false.   The cleanup at the label will then call
extent_clear_unlock_delalloc on the range from start to end.  But we've
already added cur_alloc_size to start, so there might no range be left
from the newly increment start to end.  Move the check for start < end
so that it is reached by also for the !extent_reserved case.

Fixes: a315e68f6e8b ("Btrfs: fix invalid attempt to free reserved space on failure to cow range")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ae1bda58004b26..20bee7f8dae01c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1548,8 +1548,6 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 					     clear_bits,
 					     page_ops);
 		start += cur_alloc_size;
-		if (start >= end)
-			return ret;
 	}
 
 	/*
@@ -1558,9 +1556,11 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	 * space_info's bytes_may_use counter, reserved in
 	 * btrfs_check_data_free_space().
 	 */
-	extent_clear_unlock_delalloc(inode, start, end, locked_page,
-				     clear_bits | EXTENT_CLEAR_DATA_RESV,
-				     page_ops);
+	if (start < end) {
+		clear_bits |= EXTENT_CLEAR_DATA_RESV;
+		extent_clear_unlock_delalloc(inode, start, end, locked_page,
+					     clear_bits, page_ops);
+	}
 	return ret;
 }
 
-- 
2.39.2

