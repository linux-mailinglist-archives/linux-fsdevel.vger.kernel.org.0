Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6EE47FCF1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Dec 2021 13:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237088AbhL0MzY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Dec 2021 07:55:24 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:48603 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237029AbhL0MzQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Dec 2021 07:55:16 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V.wXYX3_1640609711;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V.wXYX3_1640609711)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 27 Dec 2021 20:55:12 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 23/23] erofs: support on demand read
Date:   Mon, 27 Dec 2021 20:54:44 +0800
Message-Id: <20211227125444.21187-24-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
References: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement .issue_op() callback to support demand reading.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 7d4f6682e521..bd64dbe1b0be 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -18,13 +18,7 @@ static void erofs_priv_cleanup(struct address_space *mapping, void *netfs_priv)
 
 static void erofs_issue_op(struct netfs_read_subrequest *subreq)
 {
-	/*
-	 * TODO: implement demand-read logic later.
-	 * We rely on user daemon to prepare blob files under corresponding
-	 * directory, and we can reach here if blob files don't exist.
-	 */
-
-	netfs_subreq_terminated(subreq, -EOPNOTSUPP, false);
+	netfs_demand_read(subreq);
 }
 
 const struct netfs_read_request_ops erofs_req_ops = {
-- 
2.27.0

