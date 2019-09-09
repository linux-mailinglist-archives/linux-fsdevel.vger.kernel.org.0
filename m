Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B674ADEDF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 20:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731426AbfIIS1s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 14:27:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35850 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730720AbfIIS1s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 14:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:Content-Type:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=h5iKxHAvG5gcLJNe3uja+0hSwfHffYq9K5dxhW6ZX3E=; b=X/1FhXUqyDZeR6YI9W4yD9jh8
        mc48gvxM97ouTBLLOyCm1lkrgYDWPDsrchDE/OaUy5ppOWwJ4XTxhxCvxs4rLGP/dy/7JHymTfW/t
        fMPuIw0YR451TPoKTKLJvzOcU3emL4hRxPWO9CggWMr68zVkLx2cEhoTbdf4jHx9tVd/VG8w3owGy
        xC2U7AsnHnB6Kdk5nwaDKamkV3DblKE70sFEz6vZdg2MhMKb9lDBgx0wE5Y3U9KVLR6hzmYiM7MZl
        qY1QnDd4O6GXBDETFPLmG+8bcxnMLUSnbLuH1joO7Rm6HEcknYeOldnZcS8xiwutirslebS8FiUPG
        TjlbZk9Pw==;
Received: from [2001:4bb8:180:57ff:412:4333:4bf9:9db2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i7OOB-00020K-Oj; Mon, 09 Sep 2019 18:27:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/19] xfs: also call xfs_file_iomap_end_delalloc for zeroing operations
Date:   Mon,  9 Sep 2019 20:27:11 +0200
Message-Id: <20190909182722.16783-9-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190909182722.16783-1-hch@lst.de>
References: <20190909182722.16783-1-hch@lst.de>
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
---
 fs/xfs/xfs_iomap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index f1c3ff27c666..db4764c16142 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1138,7 +1138,8 @@ xfs_file_iomap_end(
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

