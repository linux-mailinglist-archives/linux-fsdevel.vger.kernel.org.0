Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3451D13AEC6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 17:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbgANQM7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 11:12:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43710 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728688AbgANQM6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 11:12:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=my8Ph2mEg6LXHc/rF64e/o08bhUX729CzcwPRovaKLM=; b=NRBTU/AaZu+sQFQZ4IGjdaLih2
        EC4rECXtbG5PEOMagJiggEc3WbBOSbipx3iig1QOJAwDPAlfVB+txKFHjxxRC0lYrmI2UJ19gBls/
        l1oDnXE081oxYp5WpcpzNqes3e7E8reV2lB3w/gXv+Lj+ru4uAknlB/WmjXbDBuSHfI7YU2C3372X
        mrEwnRdyiNFu6tVXXVjl93yPQQ1HnkKc3OwSENOSPt8u1307+0QFUBgKt/cGvmnt30Cdo3cBf/vHG
        NqR2eUe8B/zgTTP8n+hDOS5sfgXiHDhJAAlP9qRmGwVopD4rxV97jLr3c/ez20Em0fScdTyhSxAb6
        IF26LMGQ==;
Received: from [2001:4bb8:18c:4f54:fcbb:a92b:61e1:719] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irOoL-0000FW-71; Tue, 14 Jan 2020 16:12:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 11/12] xfs: don't set IOMAP_DIO_SYNCHRONOUS for unaligned I/O
Date:   Tue, 14 Jan 2020 17:12:24 +0100
Message-Id: <20200114161225.309792-12-hch@lst.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114161225.309792-1-hch@lst.de>
References: <20200114161225.309792-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that i_rwsem is held until asynchronous writes complete, there
is no need to force them to execute synchronously, as the i_rwsem
protection is exactly the same as for synchronous writes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_file.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index d0ee7d2932e4..3a734ad4bb10 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -510,9 +510,6 @@ xfs_file_dio_aio_write(
 	}
 
 	if (iocb->ki_flags & IOCB_NOWAIT) {
-		/* unaligned dio always waits, bail */
-		if (unaligned_io)
-			return -EAGAIN;
 		if (!xfs_ilock_nowait(ip, iolock))
 			return -EAGAIN;
 	} else {
@@ -526,14 +523,11 @@ xfs_file_dio_aio_write(
 
 	/*
 	 * If we are doing unaligned I/O, we can't allow any other overlapping
-	 * I/O in-flight at the same time or we risk data corruption.  Wait for
-	 * all other I/O to drain before we submit and execute the I/O
-	 * synchronously to prevent subsequent overlapping I/O.  If the I/O is
-	 * aligned, demote the iolock if we had to take the exclusive lock in
-	 * xfs_file_aio_write_checks() for other reasons.
+	 * If the I/O is aligned, demote the iolock if we had to take the
+	 * exclusive lock in xfs_file_aio_write_checks() for other reasons.
 	 */
 	if (unaligned_io) {
-		dio_flags = IOMAP_DIO_RWSEM_EXCL | IOMAP_DIO_SYNCHRONOUS;
+		dio_flags = IOMAP_DIO_RWSEM_EXCL;
 	} else {
 		if (iolock == XFS_IOLOCK_EXCL) {
 			xfs_ilock_demote(ip, XFS_IOLOCK_EXCL);
-- 
2.24.1

