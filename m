Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9678F46B14B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 04:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbhLGDSb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Dec 2021 22:18:31 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:32043 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229653AbhLGDSb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Dec 2021 22:18:31 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Uzilg7F_1638846889;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Uzilg7F_1638846889)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 07 Dec 2021 11:14:49 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com
Cc:     linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org
Subject: [PATCH] netfs: fix parameter of cleanup()
Date:   Tue,  7 Dec 2021 11:14:49 +0800
Message-Id: <20211207031449.100510-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The order of these two parameters is just reversed. gcc didn't warn on
that, probably because 'void *' can be converted from or to other
pointer types without warning.

Cc: stable@vger.kernel.org
Fixes: 3d3c95046742 ("netfs: Provide readahead and readpage netfs helpers")
Fixes: e1b1240c1ff5 ("netfs: Add write_begin helper")
Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/netfs/read_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index 7046f9bdd8dc..4adcb0336ecf 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -960,7 +960,7 @@ int netfs_readpage(struct file *file,
 	rreq = netfs_alloc_read_request(ops, netfs_priv, file);
 	if (!rreq) {
 		if (netfs_priv)
-			ops->cleanup(netfs_priv, folio_file_mapping(folio));
+			ops->cleanup(folio_file_mapping(folio), netfs_priv);
 		folio_unlock(folio);
 		return -ENOMEM;
 	}
@@ -1191,7 +1191,7 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
 		goto error;
 have_folio_no_wait:
 	if (netfs_priv)
-		ops->cleanup(netfs_priv, mapping);
+		ops->cleanup(mapping, netfs_priv);
 	*_folio = folio;
 	_leave(" = 0");
 	return 0;
@@ -1202,7 +1202,7 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
 	folio_unlock(folio);
 	folio_put(folio);
 	if (netfs_priv)
-		ops->cleanup(netfs_priv, mapping);
+		ops->cleanup(mapping, netfs_priv);
 	_leave(" = %d", ret);
 	return ret;
 }
-- 
2.27.0

