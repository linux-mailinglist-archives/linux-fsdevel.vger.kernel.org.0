Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6665BC2E12
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2019 09:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732941AbfJAHQ1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Oct 2019 03:16:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45502 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732829AbfJAHQ0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Oct 2019 03:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ssX5S50+8rElNg+qujiPsX9Urg+ktJ5Cp16e5jVQ2Go=; b=JXEwrgMV8xqqQkiwGvJNBQCwO1
        HThnx3GEjFf/zIKKqqjD3t1/GIjnJaSwuAUQEiJw71GtFH0EkPJdTv+3tTsfWEscVhL/AjhTIkyxw
        rMIVSHLg0n2LWXsONu+rYB4W7iKFVWmk2SU18GyBPCyZL3re3QuEebbyadKUExU5NNX+Y2LmxN2fi
        wg5oApoNsAauIXeOTGQzWWX7jLo6JRgtBamuTNvmviADruHGOqmV8M/dc8qXOC9kSybvOsOoduBHz
        9qSrXFBOFoT3V1XznJlFp2HtS0QrWA64CJ6OqylYsLqaGtbeLl4QbtqfKJDvKOxLXP/5o4pwbNfaH
        TZfE+YgQ==;
Received: from [2001:4bb8:18c:4d4a:b9e5:f9f0:a515:3f0a] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iFCOW-0001QN-Nd; Tue, 01 Oct 2019 07:16:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] xfs: set IOMAP_F_NEW more carefully
Date:   Tue,  1 Oct 2019 09:11:45 +0200
Message-Id: <20191001071152.24403-5-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191001071152.24403-1-hch@lst.de>
References: <20191001071152.24403-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Don't set IOMAP_F_NEW if we COW over and existing allocated range, as
these aren't strictly new allocations.  This is required to be able to
use IOMAP_F_NEW to zero newly allocated blocks, which is required for
the iomap code to fully support file systems that don't do delayed
allocations or use unwritten extents.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/xfs_iomap.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index f780e223b118..2dc0f182f125 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -707,9 +707,12 @@ xfs_file_iomap_begin_delay(
 	 * Flag newly allocated delalloc blocks with IOMAP_F_NEW so we punch
 	 * them out if the write happens to fail.
 	 */
-	iomap->flags |= IOMAP_F_NEW;
-	trace_xfs_iomap_alloc(ip, offset, count, whichfork,
-			whichfork == XFS_DATA_FORK ? &imap : &cmap);
+	if (whichfork == XFS_DATA_FORK) {
+		iomap->flags |= IOMAP_F_NEW;
+		trace_xfs_iomap_alloc(ip, offset, count, whichfork, &imap);
+	} else {
+		trace_xfs_iomap_alloc(ip, offset, count, whichfork, &cmap);
+	}
 done:
 	if (whichfork == XFS_COW_FORK) {
 		if (imap.br_startoff > offset_fsb) {
-- 
2.20.1

