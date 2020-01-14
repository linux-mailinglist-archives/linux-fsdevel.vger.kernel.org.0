Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1549D13AECA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 17:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbgANQNB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 11:13:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43754 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728688AbgANQNB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 11:13:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=m2saCpf7ggz2fcYQT7OoTpnuyef/oFSaHismlZbaRwg=; b=oe4mwhFZgfpe9eTAKq5ucy4vTN
        NaN8iUTyOjY/EZWJ71LcA5QaZWt4OSsutSc6fLAIIoAare7j/+jUTGIn/UtPsBt4EWMGxOBKEcbDS
        EZYHcVXyQqFS/k3PtNf5ElfH03EYQdj4YLWnBMY4t26wLDS91nEdgDBck5YCUSwo5euviW7OmwMik
        ZIlKWgxrRLkyWEH9i2gbgtzUo3YqrNrJAlVWITaDEbflh5zmoN/E4VbqXU9dCYXe285Fjafs/dpm0
        MSi9wED6clPOjNi1XE6QmGW9rw5fxSkj7bZrJvQnHGiIWqmpamopH8FdxveTkOrCheBdsT6fUAvzu
        UftNEe5A==;
Received: from [2001:4bb8:18c:4f54:fcbb:a92b:61e1:719] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irOoO-0000GP-6P; Tue, 14 Jan 2020 16:13:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 12/12] iomap: remove the inode_dio_begin/end calls
Date:   Tue, 14 Jan 2020 17:12:25 +0100
Message-Id: <20200114161225.309792-13-hch@lst.de>
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

Now that all iomap users hold i_rwsem over asynchronous I/O
operations these calls can be removed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/direct-io.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 0113ac33b0a0..c90ec82e8e08 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -126,7 +126,6 @@ static ssize_t iomap_dio_complete(struct iomap_dio *dio, bool unlock)
 	if (ret > 0 && (dio->flags & IOMAP_DIO_NEED_SYNC))
 		ret = generic_write_sync(iocb, ret);
 
-	inode_dio_end(file_inode(iocb->ki_filp));
 	kfree(dio);
 
 	return ret;
@@ -513,8 +512,6 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 			goto out_free_dio;
 	}
 
-	inode_dio_begin(inode);
-
 	blk_start_plug(&plug);
 	do {
 		ret = iomap_apply(inode, pos, count, flags, ops, dio,
-- 
2.24.1

