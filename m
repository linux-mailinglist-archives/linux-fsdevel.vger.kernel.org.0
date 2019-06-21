Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3308A4EF70
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2019 21:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfFUT2m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jun 2019 15:28:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:33226 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726111AbfFUT2k (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jun 2019 15:28:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 162A8AEE9;
        Fri, 21 Jun 2019 19:28:39 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, hch@lst.de, darrick.wong@oracle.com,
        david@fromorbit.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 3/6] iomap: Check iblocksize before transforming page->private
Date:   Fri, 21 Jun 2019 14:28:25 -0500
Message-Id: <20190621192828.28900-4-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190621192828.28900-1-rgoldwyn@suse.de>
References: <20190621192828.28900-1-rgoldwyn@suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

btrfs uses page->private as well to store extent_buffer. Make
the check stricter to make sure we are using page->private for iop by
comparing iblocksize < PAGE_SIZE.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 include/linux/iomap.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index f49767c7fd83..6511124e58b6 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -128,7 +128,8 @@ struct iomap_page {
 
 static inline struct iomap_page *to_iomap_page(struct page *page)
 {
-	if (page_has_private(page))
+	if (i_blocksize(page->mapping->host) < PAGE_SIZE &&
+			page_has_private(page))
 		return (struct iomap_page *)page_private(page);
 	return NULL;
 }
-- 
2.16.4

