Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEA9056A53
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2019 15:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfFZNXu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jun 2019 09:23:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48770 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfFZNXt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:23:49 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BA2D8309265B;
        Wed, 26 Jun 2019 13:23:49 +0000 (UTC)
Received: from max.com (unknown [10.40.205.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 95A741001B0E;
        Wed, 26 Jun 2019 13:23:43 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Cc:     cluster-devel@redhat.com, linux-xfs@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v2 3/3] iomap: fix page_done callback for short writes
Date:   Wed, 26 Jun 2019 15:23:35 +0200
Message-Id: <20190626132335.14809-3-agruenba@redhat.com>
In-Reply-To: <20190626132335.14809-1-agruenba@redhat.com>
References: <20190626132335.14809-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 26 Jun 2019 13:23:49 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When we truncate a short write to have it retried, pass the truncated
length to the page_done callback instead of the full length.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/iomap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap.c b/fs/iomap.c
index 97569064faaa..9a9d016b2782 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -803,7 +803,7 @@ iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
 	if (old_size < pos)
 		pagecache_isize_extended(inode, old_size, pos);
 	if (page_ops && page_ops->page_done)
-		page_ops->page_done(inode, pos, copied, page, iomap);
+		page_ops->page_done(inode, pos, ret, page, iomap);
 	put_page(page);
 
 	if (ret < len)
-- 
2.20.1

