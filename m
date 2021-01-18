Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09912FAA86
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 20:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437603AbhARTsb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 14:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437390AbhARTrq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 14:47:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07E2C061573;
        Mon, 18 Jan 2021 11:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=IOUkrZ/GxkPaQGTKTJtehA0aySabPrU71HfB48HErxI=; b=ZikdTwGEBxmDMkbXJ7Tk5QKrDF
        6eMhQAK87Qm2YpgtDHf2nmX8Ik4hrPD2vGmQm9RlB85YMjwv5B+6VOwrMvrHwE/Hm2yoX6lZhSQuS
        xeRddXI67ULBGI47PHgviFH2mI59j0ZiXt5zIOadWm9CE7kf7BczeR6GxMyEe2q7Hjy7mrD963lIg
        ZYpou8J1+AbXTFhVphdfvhNpTIpDD94xcU09D0BR2uw9sZhpiZVwiqnEyF5A+UvWyRCoB+lTXcxx/
        PsI7e55XbbFULBfTFOAUbakvfj64dPkuo7WjP+2uKHCpJULhbI5xfFlzY/zJvh7XudWydNwSMPGrm
        mM6LgQgA==;
Received: from 089144206130.atnat0015.highway.bob.at ([89.144.206.130] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l1aUC-00DJZ8-Di; Mon, 18 Jan 2021 19:46:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, avi@scylladb.com,
        Dave Chinner <dchinner@redhat.com>
Subject: [PATCH 04/11] xfs: remove the buffered I/O fallback assert
Date:   Mon, 18 Jan 2021 20:35:09 +0100
Message-Id: <20210118193516.2915706-5-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118193516.2915706-1-hch@lst.de>
References: <20210118193516.2915706-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The iomap code has been designed from the start not to do magic fallback,
so remove the assert in preparation for further code cleanups.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/xfs_file.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index ae7313ccaa11ed..97836ec53397d4 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -610,12 +610,6 @@ xfs_file_dio_write(
 out:
 	if (iolock)
 		xfs_iunlock(ip, iolock);
-
-	/*
-	 * No fallback to buffered IO after short writes for XFS, direct I/O
-	 * will either complete fully or return an error.
-	 */
-	ASSERT(ret < 0 || ret == count);
 	return ret;
 }
 
-- 
2.29.2

