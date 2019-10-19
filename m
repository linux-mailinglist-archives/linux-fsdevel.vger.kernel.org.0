Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8175BDD91F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2019 16:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbfJSOo6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Oct 2019 10:44:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43042 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfJSOo6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Oct 2019 10:44:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yen1bDUl6EDMCgAF888wW2vx8opGK8BRsc70cOmSwgU=; b=YUT2tsre1CairE53o9cV5tvtl9
        JjCTCYPAql4PkemFW4ogU9zqXN2bkEb7GWgSUJ77FkSRZAHClyq58aw0pZ7TVZSdHbuCoB1MNTA/4
        2vKj6ela6b2yYIO9wrxI8ZrD8kybxLXm5hzlAtOFA0OlqvXmPRuCz/z7ugDfRNNmb5/ZrAcdWiywo
        Es5l+sCP6aoWEZVO4f2Gv+rhFZ4WTla553nJI8GNSN5Qy1KCDKfX1bGEm130wSGuG0xoQibFXnLVD
        7quGXQm+jNqSRhtcRc1v3ne0Yz0r6QEAEdzx5z4/y8ZAS3JeBqwKawZ2Ru+9UBEeUN7IKHSpq1JLa
        p/JV8LQg==;
Received: from [2001:4bb8:18c:d7b:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLpyT-0001t8-Ed; Sat, 19 Oct 2019 14:44:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: [PATCH 01/12] xfs: also call xfs_file_iomap_end_delalloc for zeroing operations
Date:   Sat, 19 Oct 2019 16:44:37 +0200
Message-Id: <20191019144448.21483-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191019144448.21483-1-hch@lst.de>
References: <20191019144448.21483-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is no reason not to punch out stale delalloc blocks for zeroing
operations, as they otherwise behave exactly like normal writes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/xfs_iomap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 95719e161286..f1d32bcf48bd 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1145,7 +1145,8 @@ xfs_file_iomap_end(
 	unsigned		flags,
 	struct iomap		*iomap)
 {
-	if ((flags & IOMAP_WRITE) && iomap->type == IOMAP_DELALLOC)
+	if ((flags & (IOMAP_WRITE | IOMAP_ZERO)) &&
+	    iomap->type == IOMAP_DELALLOC)
 		return xfs_file_iomap_end_delalloc(XFS_I(inode), offset,
 				length, written, iomap);
 	return 0;
-- 
2.20.1

