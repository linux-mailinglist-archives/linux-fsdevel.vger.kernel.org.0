Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F31A13AEBA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 17:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbgANQMk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 11:12:40 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43448 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbgANQMj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 11:12:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=79c/IqiMprBaz8H+ADFYKQUEqd4rZzvM1P9wDVwg94s=; b=oplgdNMprg/V9W1Vc9mSW6qBSh
        ChGK0XTPuUo5pfag32IxC8sSxaBrkFyl0myFkYt5pYEyGDrjCOovd86lG6sDj5l1Dco9y642z5ofb
        N/SL8Ih0SiW0jUAC/rpbTkGHn1T03SY2d3AGw+aVATKAXqEDbHN/Dygi0lo5LHvV8raebRWT9GfJi
        DKIua/yP7vmAD/gBNERutRlhO3Wd2YpngZcwxHUuVlIJRVz7EivgPFTLE7wzC+rnD9dkkn1uiTVrE
        TSVhdz5wCPHNKFv3VsImok06/b6DKyqx29YHWXMa+eS2n363pcieQPrgHV03WpEDEzEpMmSeup9El
        slJllqmg==;
Received: from [2001:4bb8:18c:4f54:fcbb:a92b:61e1:719] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irOo2-00009S-As; Tue, 14 Jan 2020 16:12:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 04/12] gfs2: move setting current->backing_dev_info
Date:   Tue, 14 Jan 2020 17:12:17 +0100
Message-Id: <20200114161225.309792-5-hch@lst.de>
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

Only set current->backing_dev_info just around the buffered write calls
to prepare for the next fix.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/gfs2/file.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 9d58295ccf7a..21d032c4b077 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -867,18 +867,15 @@ static ssize_t gfs2_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	inode_lock(inode);
 	ret = generic_write_checks(iocb, from);
 	if (ret <= 0)
-		goto out;
-
-	/* We can write back this queue in page reclaim */
-	current->backing_dev_info = inode_to_bdi(inode);
+		goto out_unlock;
 
 	ret = file_remove_privs(file);
 	if (ret)
-		goto out2;
+		goto out_unlock;
 
 	ret = file_update_time(file);
 	if (ret)
-		goto out2;
+		goto out_unlock;
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		struct address_space *mapping = file->f_mapping;
@@ -887,11 +884,13 @@ static ssize_t gfs2_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 		written = gfs2_file_direct_write(iocb, from);
 		if (written < 0 || !iov_iter_count(from))
-			goto out2;
+			goto out_unlock;
 
+		current->backing_dev_info = inode_to_bdi(inode);
 		ret = iomap_file_buffered_write(iocb, from, &gfs2_iomap_ops);
+		current->backing_dev_info = NULL;
 		if (unlikely(ret < 0))
-			goto out2;
+			goto out_unlock;
 		buffered = ret;
 
 		/*
@@ -915,14 +914,14 @@ static ssize_t gfs2_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			 */
 		}
 	} else {
+		current->backing_dev_info = inode_to_bdi(inode);
 		ret = iomap_file_buffered_write(iocb, from, &gfs2_iomap_ops);
+		current->backing_dev_info = NULL;
 		if (likely(ret > 0))
 			iocb->ki_pos += ret;
 	}
 
-out2:
-	current->backing_dev_info = NULL;
-out:
+out_unlock:
 	inode_unlock(inode);
 	if (likely(ret > 0)) {
 		/* Handle various SYNC-type writes */
-- 
2.24.1

