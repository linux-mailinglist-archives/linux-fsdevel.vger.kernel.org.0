Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5EC2E04A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 04:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgLVDMi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 22:12:38 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:51875 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725962AbgLVDMh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 22:12:37 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UJOs58l_1608606714;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UJOs58l_1608606714)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 22 Dec 2020 11:11:55 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
Subject: [PATCH] block: move definition of blk_qc_t to types.h
Date:   Tue, 22 Dec 2020 11:11:54 +0800
Message-Id: <20201222031154.62150-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

So that kiocb.ki_cookie can be defined as blk_qc_t, which will enforce
the encapsulation.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 include/linux/blk_types.h | 1 -
 include/linux/fs.h        | 2 +-
 include/linux/types.h     | 2 ++
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 866f74261b3b..437e1f74edf8 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -532,7 +532,6 @@ static inline int op_stat_group(unsigned int op)
 	return op_is_write(op);
 }
 
-typedef unsigned int blk_qc_t;
 #define BLK_QC_T_NONE		-1U
 #define BLK_QC_T_SHIFT		16
 #define BLK_QC_T_INTERNAL	(1U << 31)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index b0b358309657..88ec2c9ed497 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -330,7 +330,7 @@ struct kiocb {
 	u16			ki_hint;
 	u16			ki_ioprio; /* See linux/ioprio.h */
 	union {
-		unsigned int		ki_cookie; /* for ->iopoll */
+		blk_qc_t		ki_cookie; /* for ->iopoll */
 		struct wait_page_queue	*ki_waitq; /* for async buffered IO */
 	};
 
diff --git a/include/linux/types.h b/include/linux/types.h
index a147977602b5..bf4a64b6f13e 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -125,6 +125,8 @@ typedef s64			int64_t;
 typedef u64 sector_t;
 typedef u64 blkcnt_t;
 
+typedef unsigned int blk_qc_t;
+
 /*
  * The type of an index into the pagecache.
  */
-- 
2.27.0

