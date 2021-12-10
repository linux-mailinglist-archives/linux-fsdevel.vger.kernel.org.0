Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065D046FBAE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Dec 2021 08:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237809AbhLJHkP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Dec 2021 02:40:15 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:23429 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237686AbhLJHkH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Dec 2021 02:40:07 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V-8PLQ6_1639121790;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V-8PLQ6_1639121790)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Dec 2021 15:36:31 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: [RFC 09/19] netfs: refactor netfs_rreq_unlock()
Date:   Fri, 10 Dec 2021 15:36:09 +0800
Message-Id: <20211210073619.21667-10-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211210073619.21667-1-jefflexu@linux.alibaba.com>
References: <20211210073619.21667-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In demand-read case, the input folio of netfs API is may not the page
cache inside the address space of the netfs file. Instead it may be just
a temporary page used to contain the data.

Thus iterate corresponding pages through rreq->folio directly.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/netfs/read_helper.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index 04d0cc2fca83..af12a7996672 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -414,6 +414,22 @@ static void netfs_rreq_unlock(struct netfs_read_request *rreq)
 	pgoff_t last_page = ((rreq->start + rreq->len) / PAGE_SIZE) - 1;
 	bool subreq_failed = false;
 
+	if (rreq->type == NETFS_TYPE_DEMAND) {
+		folio = rreq->folio;
+
+		list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
+			subreq_failed = (subreq->error < 0);
+			if (subreq_failed)
+				break;
+		}
+
+		if (!subreq_failed)
+			folio_mark_uptodate(folio);
+
+		if (!test_bit(NETFS_RREQ_DONT_UNLOCK_FOLIOS, &rreq->flags))
+			folio_unlock(folio);
+	} else {
+
 	XA_STATE(xas, &rreq->mapping->i_pages, start_page);
 
 	if (test_bit(NETFS_RREQ_FAILED, &rreq->flags)) {
@@ -480,6 +496,7 @@ static void netfs_rreq_unlock(struct netfs_read_request *rreq)
 		}
 	}
 	rcu_read_unlock();
+	}
 
 	task_io_account_read(account);
 	if (rreq->netfs_ops->done)
-- 
2.27.0

