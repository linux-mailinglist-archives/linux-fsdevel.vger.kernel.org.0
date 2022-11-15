Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5CD628F3B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 02:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbiKOBa4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 20:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiKOBav (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 20:30:51 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4F7616C
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Nov 2022 17:30:50 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id k22so12732164pfd.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Nov 2022 17:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXTvPzYo/FNVPPUBJfWV1FT/CBSdhDIuqNcR9jo+cPM=;
        b=YeiVS6DbLpVk00yQfx8PyNLK6jcZ1YAIEmPvKhGiCeMnVsTJobJoplSrltjmtk/iIA
         LTzl4pjiLxoaKi2tGfcvcg+vUo9G04Pj/qzLWVbW1xyIMCNqF7NY/Z2s+CSkcLvmf4d1
         vY2yskVvzZ01jPJhkKb8RutnRxDpIafnWupAel36iBL943wb5ZqVLaqKJhKceu4H5/8f
         cFu+AztIQjn2HqAZa63WRRd78gwTuBP2CSIY36rG4sUjPY8yHw5CZcpBvcA1nJrj09ar
         QS60U2sttLdOtt7jz6WVVphTMh246zUic1SjasKq+K4uDu55aXs1VQnEt9hlvAGpjK3S
         3u8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xXTvPzYo/FNVPPUBJfWV1FT/CBSdhDIuqNcR9jo+cPM=;
        b=L7m1PqLx5ybQPJXfdTD74FGKRnktULKYeXl00wSNL7fAT+vUltaYsaLH6h7FSF+xNS
         RXg39oPpMuFgxyYIzug2S0iCITH9Jl7JNvpgj+Wa68rUdeEqkHv6aiCh3JFQRm0gebmi
         F+fna5iUnhGQ1aJ4oifG4AVYbWaxYPyx3e+a4n4r9KjmJlx0I4oGkRjYlwvQYeqCEr9b
         6sRHxM3HvXetg7/xDiUVWQLHBhRtLrMHyChOGI0MxeWNkfSCzSQtXCY9y8waHjmhUsPp
         /Cq/eraxGrPaE1qH7hEWQvwBpvNPQPe3YeaIdk/ovm0ZROmCAUg+P51sx7uSTU+/ZkAo
         LBVw==
X-Gm-Message-State: ANoB5plTYrzTQkDFdZBE7erNOd5Qqic3Oj0FbrrbN/huliYW2dCqIBrK
        aWotpFJ5GmgMnJe7HiMHpiqJ8fjGbwww0w==
X-Google-Smtp-Source: AA0mqf6mvfxaixLdw9mdL/WImf3S0ul9CJiKBqlXzswxmwwbWhPfuah1HeY/Qzm93fIbtOk79jnU3A==
X-Received: by 2002:a63:e343:0:b0:46f:ed91:6664 with SMTP id o3-20020a63e343000000b0046fed916664mr13798300pgj.558.1668475849538;
        Mon, 14 Nov 2022 17:30:49 -0800 (PST)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au. [49.181.106.210])
        by smtp.gmail.com with ESMTPSA id x15-20020aa7940f000000b005627d995a36sm7346339pfo.44.2022.11.14.17.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 17:30:47 -0800 (PST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oukmj-00EKFv-AB; Tue, 15 Nov 2022 12:30:45 +1100
Received: from dave by discord.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1oukmj-001VpI-0u;
        Tue, 15 Nov 2022 12:30:45 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 2/9] xfs: write page faults in iomap are not buffered writes
Date:   Tue, 15 Nov 2022 12:30:36 +1100
Message-Id: <20221115013043.360610-3-david@fromorbit.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221115013043.360610-1-david@fromorbit.com>
References: <20221115013043.360610-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_file.c  | 2 +-
 fs/xfs/xfs_iomap.c | 9 +++++++++
 fs/xfs/xfs_iomap.h | 1 +
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
-- 
2.37.2

