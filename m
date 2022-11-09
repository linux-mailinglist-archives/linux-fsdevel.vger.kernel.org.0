Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1D0623222
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Nov 2022 19:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiKISQD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Nov 2022 13:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiKISPy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Nov 2022 13:15:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF5313E96;
        Wed,  9 Nov 2022 10:15:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4DCE2B81F6A;
        Wed,  9 Nov 2022 18:15:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD2BC433D7;
        Wed,  9 Nov 2022 18:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668017751;
        bh=wV6FrFgAv7lbu7/m3oTVhMSTYUXey1hP/1VQ4tBUfaw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SUjkU3OmPyJAFeCBLimeM+CGjnkiq41IeS4fsf7ZgEkz4dUXCORNHx9lA7bASb5+N
         EToZABNI/GkQYZG78YwFfCfcbt/lNt28CBHV1Gq+1zim5jqer4CwuNuWWRhk6PsxiN
         7k/FR1OBJEXlnwBZakSe6jGM4t1rzSh1LNMFLA8n+1ei/7ruZmk00svdId9MdVlmdJ
         Z9AtOhI8GHpjVfZEKxhhC7HCTnybqF53qMD5LskvYYI3EmQ4T8jWCPI1tQhzD/hKLg
         Xuli5NwoLMBoYkHoem87pNLN9ol6D8fB1NRO7VREQoiFxVr56FoUgCPR4THI7eLOIt
         4B64bVvXWszyg==
Subject: [PATCH 01/14] xfs: write page faults in iomap are not buffered writes
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     Dave Chinner <dchinner@redhat.com>, Christoph Hellwig <hch@lst.de>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org
Date:   Wed, 09 Nov 2022 10:15:50 -0800
Message-ID: <166801775049.3992140.14376099491514761985.stgit@magnolia>
In-Reply-To: <166801774453.3992140.241667783932550826.stgit@magnolia>
References: <166801774453.3992140.241667783932550826.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

When we reserve a delalloc region in xfs_buffered_write_iomap_begin,
we mark the iomap as IOMAP_F_NEW so that the the write context
understands that it allocated the delalloc region.

If we then fail that buffered write, xfs_buffered_write_iomap_end()
checks for the IOMAP_F_NEW flag and if it is set, it punches out
the unused delalloc region that was allocated for the write.

The assumption this code makes is that all buffered write operations
that can allocate space are run under an exclusive lock (i_rwsem).
This is an invalid assumption: page faults in mmap()d regions call
through this same function pair to map the file range being faulted
and this runs only holding the inode->i_mapping->invalidate_lock in
shared mode.

IOWs, we can have races between page faults and write() calls that
fail the nested page cache write operation that result in data loss.
That is, the failing iomap_end call will punch out the data that
the other racing iomap iteration brought into the page cache. This
can be reproduced with generic/34[46] if we arbitrarily fail page
cache copy-in operations from write() syscalls.

Code analysis tells us that the iomap_page_mkwrite() function holds
the already instantiated and uptodate folio locked across the iomap
mapping iterations. Hence the folio cannot be removed from memory
whilst we are mapping the range it covers, and as such we do not
care if the mapping changes state underneath the iomap iteration
loop:

1. if the folio is not already dirty, there is no writeback races
   possible.
2. if we allocated the mapping (delalloc or unwritten), the folio
   cannot already be dirty. See #1.
3. If the folio is already dirty, it must be up to date. As we hold
   it locked, it cannot be reclaimed from memory. Hence we always
   have valid data in the page cache while iterating the mapping.
4. Valid data in the page cache can exist when the underlying
   mapping is DELALLOC, UNWRITTEN or WRITTEN. Having the mapping
   change from DELALLOC->UNWRITTEN or UNWRITTEN->WRITTEN does not
   change the data in the page - it only affects actions if we are
   initialising a new page. Hence #3 applies  and we don't care
   about these extent map transitions racing with
   iomap_page_mkwrite().
5. iomap_page_mkwrite() checks for page invalidation races
   (truncate, hole punch, etc) after it locks the folio. We also
   hold the mapping->invalidation_lock here, and hence the mapping
   cannot change due to extent removal operations while we are
   iterating the folio.

As such, filesystems that don't use bufferheads will never fail
the iomap_folio_mkwrite_iter() operation on the current mapping,
regardless of whether the iomap should be considered stale.

Further, the range we are asked to iterate is limited to the range
inside EOF that the folio spans. Hence, for XFS, we will only map
the exact range we are asked for, and we will only do speculative
preallocation with delalloc if we are mapping a hole at the EOF
page. The iterator will consume the entire range of the folio that
is within EOF, and anything beyond the EOF block cannot be accessed.
We never need to truncate this post-EOF speculative prealloc away in
the context of the iomap_page_mkwrite() iterator because if it
remains unused we'll remove it when the last reference to the inode
goes away.

Hence we don't actually need an .iomap_end() cleanup/error handling
path at all for iomap_page_mkwrite() for XFS. This means we can
separate the page fault processing from the complexity of the
.iomap_end() processing in the buffered write path. This also means
that the buffered write path will also be able to take the
mapping->invalidate_lock as necessary.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_file.c  |    2 +-
 fs/xfs/xfs_iomap.c |    9 +++++++++
 fs/xfs/xfs_iomap.h |    1 +
 3 files changed, 11 insertions(+), 1 deletion(-)


diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index e462d39c840e..595a5bcf46b9 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1325,7 +1325,7 @@ __xfs_filemap_fault(
 		if (write_fault) {
 			xfs_ilock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
 			ret = iomap_page_mkwrite(vmf,
-					&xfs_buffered_write_iomap_ops);
+					&xfs_page_mkwrite_iomap_ops);
 			xfs_iunlock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
 		} else {
 			ret = filemap_fault(vmf);
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 07da03976ec1..5cea069a38b4 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1187,6 +1187,15 @@ const struct iomap_ops xfs_buffered_write_iomap_ops = {
 	.iomap_end		= xfs_buffered_write_iomap_end,
 };
 
+/*
+ * iomap_page_mkwrite() will never fail in a way that requires delalloc extents
+ * that it allocated to be revoked. Hence we do not need an .iomap_end method
+ * for this operation.
+ */
+const struct iomap_ops xfs_page_mkwrite_iomap_ops = {
+	.iomap_begin		= xfs_buffered_write_iomap_begin,
+};
+
 static int
 xfs_read_iomap_begin(
 	struct inode		*inode,
diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
index c782e8c0479c..0f62ab633040 100644
--- a/fs/xfs/xfs_iomap.h
+++ b/fs/xfs/xfs_iomap.h
@@ -47,6 +47,7 @@ xfs_aligned_fsb_count(
 }
 
 extern const struct iomap_ops xfs_buffered_write_iomap_ops;
+extern const struct iomap_ops xfs_page_mkwrite_iomap_ops;
 extern const struct iomap_ops xfs_direct_write_iomap_ops;
 extern const struct iomap_ops xfs_read_iomap_ops;
 extern const struct iomap_ops xfs_seek_iomap_ops;

