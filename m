Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1792546FBB2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Dec 2021 08:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235453AbhLJHkR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Dec 2021 02:40:17 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:33382 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235394AbhLJHkI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Dec 2021 02:40:08 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V-8PLQN_1639121791;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V-8PLQN_1639121791)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Dec 2021 15:36:32 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: [RFC 10/19] netfs: refactor netfs_rreq_prepare_read
Date:   Fri, 10 Dec 2021 15:36:10 +0800
Message-Id: <20211210073619.21667-11-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211210073619.21667-1-jefflexu@linux.alibaba.com>
References: <20211210073619.21667-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In demand-read mode, fs using fscache for demand-read doesn't know and
care the exact file size of the data blob file, and thus skip the file
size check in this case.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/netfs/read_helper.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index af12a7996672..ade1523fc180 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -776,14 +776,16 @@ netfs_rreq_prepare_read(struct netfs_read_request *rreq,
 		goto out;
 
 	if (source == NETFS_DOWNLOAD_FROM_SERVER) {
-		/* Call out to the netfs to let it shrink the request to fit
-		 * its own I/O sizes and boundaries.  If it shinks it here, it
-		 * will be called again to make simultaneous calls; if it wants
-		 * to make serial calls, it can indicate a short read and then
-		 * we will call it again.
-		 */
-		if (subreq->len > rreq->i_size - subreq->start)
-			subreq->len = rreq->i_size - subreq->start;
+		if (rreq->type == NETFS_TYPE_CACHE) {
+			/* Call out to the netfs to let it shrink the request to fit
+			 * its own I/O sizes and boundaries.  If it shinks it here, it
+			 * will be called again to make simultaneous calls; if it wants
+			 * to make serial calls, it can indicate a short read and then
+			 * we will call it again.
+			 */
+			if (subreq->len > rreq->i_size - subreq->start)
+				subreq->len = rreq->i_size - subreq->start;
+		}
 
 		if (rreq->netfs_ops->clamp_length &&
 		    !rreq->netfs_ops->clamp_length(subreq)) {
-- 
2.27.0

