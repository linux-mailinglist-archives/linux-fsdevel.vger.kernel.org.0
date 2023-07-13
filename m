Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEBD7522F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 15:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbjGMNGk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 09:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbjGMNGB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:06:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4D32729;
        Thu, 13 Jul 2023 06:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=DIN7jTQKiX0fYn4tpLMYTRoJ4jczECHpji7D+MGfhMg=; b=1KrgdpvryGijkjmqsauXv1e/ZZ
        O8NLuXCmD1qpSczsF8QHb3i3MA0ahdWKLQJVnqEK83qSoMPJi37n4r65qTfeS/L+478eAWSb5zoNr
        YmaImsg2f5OAHPd0NtQcRyt/9IcnR/dE45qbFdVd00n+TdMFxFpqQf2iU41fmp8T6XIDE5eMuB59C
        O1OkwuP/GTYC8oBW8WyiDpCXAphlaGN9GLlasEo/JPHcodnMZoXx/YChJvSrqv2idQiwoSHzB759d
        yhMInMuD16YbUHP+5ZIsFdXGHIGKuNShlh1+QfgPbKvNNNaalXlwAFSd80vVh9cgJM0nr8yYYd2Ql
        NHEicvFw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qJw06-003Lfz-0F;
        Thu, 13 Jul 2023 13:04:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 8/9] btrfs: remove the call to btrfs_mark_ordered_io_finished in btrfs_writepage_fixup_worker
Date:   Thu, 13 Jul 2023 15:04:30 +0200
Message-Id: <20230713130431.4798-9-hch@lst.de>
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

If btrfs_writepage_fixup_worker is called for a range that is
covered by and ordered_extent, but which doesn't have the PageOrdered
bit set, that means the ordered_extent is either for a pending direct
I/O, or for a buffered writeback in the final stages of I/O completion.

In either case it is now owned by the calling context, and should
never be completed by it.

Fixes: 87826df0ec36 ("btrfs: delalloc for page dirtied out-of-band in fixup worker")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 20bee7f8dae01c..46d04803d76f13 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2796,8 +2796,6 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 		 * to reflect the errors and clean the page.
 		 */
 		mapping_set_error(page->mapping, ret);
-		btrfs_mark_ordered_io_finished(inode, page, page_start,
-					       PAGE_SIZE, !ret);
 		btrfs_page_clear_uptodate(fs_info, page, page_start, PAGE_SIZE);
 		clear_page_dirty_for_io(page);
 	}
-- 
2.39.2

