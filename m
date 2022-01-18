Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6AA4926C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 14:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242233AbiARNNJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 08:13:09 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:56252 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242680AbiARNMp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 08:12:45 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V2C2ayE_1642511560;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V2C2ayE_1642511560)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 18 Jan 2022 21:12:41 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 20/20] erofs: support on-demand reading
Date:   Tue, 18 Jan 2022 21:12:16 +0800
Message-Id: <20220118131216.85338-21-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220118131216.85338-1-jefflexu@linux.alibaba.com>
References: <20220118131216.85338-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement the .issue_op() callback, and all work is done by
netfs_ondemand_read().

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index e8df35ee4ba8..9ba668c42098 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -28,9 +28,15 @@ static void erofs_noop_cleanup(struct address_space *mapping, void *netfs_priv)
 {
 }
 
+static void erofs_issue_op(struct netfs_read_subrequest *subreq)
+{
+	netfs_ondemand_read(subreq);
+}
+
 static const struct netfs_read_request_ops erofs_blob_req_ops = {
 	.begin_cache_operation  = erofs_blob_begin_cache_operation,
 	.cleanup		= erofs_noop_cleanup,
+	.issue_op		= erofs_issue_op,
 };
 
 static int erofs_begin_cache_operation(struct netfs_read_request *rreq)
@@ -58,6 +64,7 @@ static const struct netfs_read_request_ops erofs_req_ops = {
 	.begin_cache_operation  = erofs_begin_cache_operation,
 	.cleanup		= erofs_noop_cleanup,
 	.clamp_length		= erofs_clamp_length,
+	.issue_op		= erofs_issue_op,
 };
 
 static int erofs_fscache_blob_readpage(struct file *data, struct page *page)
-- 
2.27.0

