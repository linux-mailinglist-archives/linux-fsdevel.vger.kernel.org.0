Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A0A2653FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 23:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgIJVmw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 17:42:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:41614 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730319AbgIJMsP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 08:48:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5FCE7ACAF;
        Thu, 10 Sep 2020 12:48:00 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] iomap: Use round_down/round_up macros in __iomap_write_begin
Date:   Thu, 10 Sep 2020 15:47:43 +0300
Message-Id: <20200910124743.27603-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/iomap/buffered-io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index bcfc288dba3f..31eb680d8c64 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -571,8 +571,8 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
 {
 	struct iomap_page *iop = iomap_page_create(inode, page);
 	loff_t block_size = i_blocksize(inode);
-	loff_t block_start = pos & ~(block_size - 1);
-	loff_t block_end = (pos + len + block_size - 1) & ~(block_size - 1);
+	loff_t block_start = round_down(pos, block_size);
+	loff_t block_end = round_up(pos + len, block_size);
 	unsigned from = offset_in_page(pos), to = from + len, poff, plen;
 	int status;
 
-- 
2.17.1

