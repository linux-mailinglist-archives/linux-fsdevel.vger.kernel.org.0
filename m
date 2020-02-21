Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C231168069
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 15:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgBUOhZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 09:37:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41018 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbgBUOhY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 09:37:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=oscywdw1eHVlIX2W4jKP5rlOyLGc6Xdek/JohMwhP9c=; b=aC4K+JQwjIZk73GuOj4mk1djH5
        uX0k31khjv5eJEOQEhfW5ku1s3QyQWPNql4BamVNlu/tref/kO3x/OVb5OZG4AKjB2QBo7vUZZa8O
        Bs1HzzhTZxv3OTZghwk12/SKVKnX9F1mcWlbmZ4UTIMiJucbxhkgMW56xs6F6hrPXN65DXSDI2ZRQ
        2lSTOlmd7uTviYo4XWK/3IvIAI6ek2IuSOvTIQ9FRiDiF2En81Y0uJ1cDC0NQCWgKA6KaI6ZxHXDh
        T8i1aqPm/qyAn86Xs4mxfF2nqrJxeJBo2EJFsNRlXxuMgqZVkLW16YgNb5k51TJzDXNprNKVdPbnz
        VEkMOGWw==;
Received: from [38.126.112.138] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j59Qh-0003c9-Lj; Fri, 21 Feb 2020 14:37:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     damien.lemoal@wdc.com, naohiro.aota@wdc.com
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] zonefs: fix IOCB_NOWAIT handling
Date:   Fri, 21 Feb 2020 06:37:23 -0800
Message-Id: <20200221143723.482323-1-hch@lst.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

IOCB_NOWAIT can't just be ignored as it breaks applications expecting
it not to block.  Just refuse the operation as applications must handle
that (e.g. by falling back to a thread pool).

Fixes: 8dcc1a9d90c1 ("fs: New zonefs file system")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/zonefs/super.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 8bc6ef82d693..69aee3dfb660 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -601,13 +601,13 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
 	ssize_t ret;
 
 	/*
-	 * For async direct IOs to sequential zone files, ignore IOCB_NOWAIT
+	 * For async direct IOs to sequential zone files, refuse IOCB_NOWAIT
 	 * as this can cause write reordering (e.g. the first aio gets EAGAIN
 	 * on the inode lock but the second goes through but is now unaligned).
 	 */
-	if (zi->i_ztype == ZONEFS_ZTYPE_SEQ && !is_sync_kiocb(iocb)
-	    && (iocb->ki_flags & IOCB_NOWAIT))
-		iocb->ki_flags &= ~IOCB_NOWAIT;
+	if (zi->i_ztype == ZONEFS_ZTYPE_SEQ && !is_sync_kiocb(iocb) &&
+	    (iocb->ki_flags & IOCB_NOWAIT))
+		return -EOPNOTSUPP;
 
 	if (iocb->ki_flags & IOCB_NOWAIT) {
 		if (!inode_trylock(inode))
-- 
2.24.1

