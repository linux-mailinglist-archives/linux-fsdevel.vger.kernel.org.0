Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5392946FBAF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Dec 2021 08:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237837AbhLJHkQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Dec 2021 02:40:16 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:53157 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235298AbhLJHkC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Dec 2021 02:40:02 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V-80.nN_1639121785;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V-80.nN_1639121785)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Dec 2021 15:36:26 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: [RFC 05/19] netfs: refactor netfs_alloc_read_request
Date:   Fri, 10 Dec 2021 15:36:05 +0800
Message-Id: <20211210073619.21667-6-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211210073619.21667-1-jefflexu@linux.alibaba.com>
References: <20211210073619.21667-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/netfs/read_helper.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index 4247916c7100..9240b85548e4 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -37,7 +37,7 @@ static void netfs_put_subrequest(struct netfs_read_subrequest *subreq,
 		__netfs_put_subrequest(subreq, was_async);
 }
 
-static struct netfs_read_request *netfs_alloc_read_request(
+static struct netfs_read_request *__netfs_alloc_read_request(
 	const struct netfs_read_request_ops *ops, void *netfs_priv,
 	struct file *file)
 {
@@ -48,8 +48,6 @@ static struct netfs_read_request *netfs_alloc_read_request(
 	if (rreq) {
 		rreq->netfs_ops	= ops;
 		rreq->netfs_priv = netfs_priv;
-		rreq->inode	= file_inode(file);
-		rreq->i_size	= i_size_read(rreq->inode);
 		rreq->debug_id	= atomic_inc_return(&debug_ids);
 		INIT_LIST_HEAD(&rreq->subrequests);
 		INIT_WORK(&rreq->work, netfs_rreq_work);
@@ -63,6 +61,21 @@ static struct netfs_read_request *netfs_alloc_read_request(
 	return rreq;
 }
 
+static struct netfs_read_request *netfs_alloc_read_request(
+	const struct netfs_read_request_ops *ops, void *netfs_priv,
+	struct file *file)
+{
+	struct netfs_read_request *rreq;
+
+	rreq = __netfs_alloc_read_request(ops, netfs_priv, file);
+	if (rreq) {
+		rreq->inode	= file_inode(file);
+		rreq->i_size	= i_size_read(rreq->inode);
+	}
+
+	return rreq;
+}
+
 static void netfs_get_read_request(struct netfs_read_request *rreq)
 {
 	refcount_inc(&rreq->usage);
-- 
2.27.0

