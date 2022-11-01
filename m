Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0971F614252
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 01:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiKAAeZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 20:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiKAAeV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 20:34:21 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6726F15A28
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Oct 2022 17:34:19 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id h14so11783477pjv.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Oct 2022 17:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9S0K1fKtACWFnh+ClmzETByR2HPKxtW+87wsNKi70dQ=;
        b=ihroBuarMNM3cP1Oqrrd2eK/moeEqThQ3GG8SDacsUR4g4+OHkaWYdfOrd++ZH4six
         uRYs1Bc4hrjI46VNyO+7qxqJ1sdNGpnNTggs6kKag4zTm9gKl8YU6R2WdMTv9f0ad9QV
         ryj1XjTLFMOx+eYvUhsgHWeabrVSjzLZgIszPNRgez5zJTlaTVvwd3dq6ZfIlpzZNYxD
         fhrcL3iGnbDSnl59hBiq3vWf0rci4/j34Yj264FIVGLPEftV20EOif+R4usp4RSvu1wV
         j52iCGnLav0X+Bp/dyR5HWddz3dKBNJM32pSHzTv5oCWPVhaw68VZqBmFUebTBsOoXDL
         GfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9S0K1fKtACWFnh+ClmzETByR2HPKxtW+87wsNKi70dQ=;
        b=gGX3oT5zXnzc1WyOeAq/dreTC10YvvQ6aSVbSGWaMd8eKz/Xeo2uxf+jkJeW+EB8ei
         5bml5WSvAQbvffFaxLXbfLJn4u1Wf7qnsMyc/N7w1mdY7st3cvXfMOu0rNIgYPSX+vfS
         ue8kAsrcSYiJJL8sBjaB/NfmB33Cohh6hUcPT53R2S6EyxMG10QsO2aEVPHI2y6WfzEJ
         cbh7P01NXFV8+C5vUM5qSHsadWDgXhXQrqebCiKOmJI66jVcuZCUy1JML4fE4WMIKr1a
         4Du0x/EG4BfpT26PNZbNDZLfb/IG2t8LjNQxyGxKZYjX1Gwa4BUbEKw8mF1+sQXIqezO
         QnCg==
X-Gm-Message-State: ACrzQf2SS8RzaZAmQRP/6+S9iPdRhTiz8G/EINU2TXmzjrypUsH/Am1n
        FEIaDYiXVt503lW9dxIQOTs7Yg==
X-Google-Smtp-Source: AMsMyM5zyCOmZ6SGcrJYRytuMOJWg4Ox6ne51m3KZgNxTcmLuXrbywsFN6cFRFBz5oQH884zrY2/iw==
X-Received: by 2002:a17:903:185:b0:187:2430:d39e with SMTP id z5-20020a170903018500b001872430d39emr6817165plg.65.1667262858843;
        Mon, 31 Oct 2022 17:34:18 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au. [49.181.106.210])
        by smtp.gmail.com with ESMTPSA id h11-20020aa796cb000000b00562677968aesm5219006pfq.72.2022.10.31.17.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 17:34:17 -0700 (PDT)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1opfEN-008muI-3q; Tue, 01 Nov 2022 11:34:15 +1100
Received: from dave by discord.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1opfEN-00G7dW-0I;
        Tue, 01 Nov 2022 11:34:15 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/7] xfs: write page faults in iomap are not buffered writes
Date:   Tue,  1 Nov 2022 11:34:06 +1100
Message-Id: <20221101003412.3842572-2-david@fromorbit.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221101003412.3842572-1-david@fromorbit.com>
References: <20221101003412.3842572-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
---
 fs/xfs/xfs_file.c  | 2 +-
 fs/xfs/xfs_iomap.c | 9 +++++++++
 fs/xfs/xfs_iomap.h | 1 +
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index c6c80265c0b2..fee471ca9737 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1324,7 +1324,7 @@ __xfs_filemap_fault(
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

