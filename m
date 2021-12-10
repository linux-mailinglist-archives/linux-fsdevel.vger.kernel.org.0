Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3BE46FBD0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Dec 2021 08:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237872AbhLJHko (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Dec 2021 02:40:44 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:43989 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237871AbhLJHkT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Dec 2021 02:40:19 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V-8PLSf_1639121802;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V-8PLSf_1639121802)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Dec 2021 15:36:43 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: [RFC 19/19] erofs: support on demand read
Date:   Fri, 10 Dec 2021 15:36:19 +0800
Message-Id: <20211210073619.21667-20-jefflexu@linux.alibaba.com>
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
 fs/erofs/fscache.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index c849d3a89520..3d254cf7a0e3 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -83,9 +83,15 @@ static void erofs_priv_cleanup(struct address_space *mapping, void *netfs_priv)
 {
 }
 
+static void erofs_issue_op(struct netfs_read_subrequest *subreq)
+{
+	netfs_demand_read(subreq);
+}
+
 const struct netfs_read_request_ops erofs_req_ops = {
 	.begin_cache_operation  = erofs_begin_cache_operation,
 	.cleanup		= erofs_priv_cleanup,
+	.issue_op		= erofs_issue_op,
 };
 
 struct page *erofs_readpage_from_fscache(struct fscache_cookie *cookie,
-- 
2.27.0

