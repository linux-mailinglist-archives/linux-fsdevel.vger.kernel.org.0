Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC7E3434F4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Mar 2021 22:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhCUVEF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Mar 2021 17:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhCUVDm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Mar 2021 17:03:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B1FC061574;
        Sun, 21 Mar 2021 14:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=8wfvQ4hFHLmLc+ykZLh0i4O/agaX7udT/HQCqpYqs5I=; b=b8Rm4pISqPpovUmHfX0518bszh
        CtVQ/A8g6KR4OrKwqeDTiYjY+4Y+4WJ+dK5rZeXDa4MFRRDRZMGdWDeX+bGCJFMDO1BWUfIrmVvUk
        HhLGsPdd8ldbWU9J29EliJsceQ4br6IyDS4cca48N3pfp+16In2etijmA65A6XkfQj8/rhh3m997h
        y5bzv/qwAqEbV2q90M/C0teTJIH05UZ+qROjXVqiVD7UdhSzCxyFLY0bkuRlayjeiH8AwQNomifHw
        gEJaC4xvxEcJCohlGTb6g/7bwcsfnjPlbDId/a2YWlygQM0j63V6u+jkbUxUuLlKqANBtOubzQqhZ
        +r5+oHPQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lO5E8-007ZMB-VO; Sun, 21 Mar 2021 21:03:21 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH] btrfs: Use readahead_batch_length
Date:   Sun, 21 Mar 2021 21:03:11 +0000
Message-Id: <20210321210311.1803954-1-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement readahead_batch_length() to determine the number of bytes in
the current batch of readahead pages and use it in btrfs.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/btrfs/extent_io.c    | 6 ++----
 include/linux/pagemap.h | 9 +++++++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e9837562f7d6..97ac4ddb2857 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4875,10 +4875,8 @@ void extent_readahead(struct readahead_control *rac)
 	int nr;
 
 	while ((nr = readahead_page_batch(rac, pagepool))) {
-		u64 contig_start = page_offset(pagepool[0]);
-		u64 contig_end = page_offset(pagepool[nr - 1]) + PAGE_SIZE - 1;
-
-		ASSERT(contig_start + nr * PAGE_SIZE - 1 == contig_end);
+		u64 contig_start = readahead_pos(rac);
+		u64 contig_end = contig_start + readahead_batch_length(rac) - 1;
 
 		contiguous_readpages(pagepool, nr, contig_start, contig_end,
 				&em_cached, &bio, &bio_flags, &prev_em_start);
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 2cbfd4c36026..92939afd4944 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1174,6 +1174,15 @@ static inline unsigned int readahead_count(struct readahead_control *rac)
 	return rac->_nr_pages;
 }
 
+/**
+ * readahead_batch_length - The number of bytes in the current batch.
+ * @rac: The readahead request.
+ */
+static inline loff_t readahead_batch_length(struct readahead_control *rac)
+{
+	return rac->_batch_count * PAGE_SIZE;
+}
+
 static inline unsigned long dir_pages(struct inode *inode)
 {
 	return (unsigned long)(inode->i_size + PAGE_SIZE - 1) >>
-- 
2.30.2

