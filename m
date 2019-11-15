Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1471FE28D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 17:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfKOQRl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 11:17:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:36952 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727607AbfKOQRk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 11:17:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 62FF0B1DA;
        Fri, 15 Nov 2019 16:17:38 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, hch@infradead.org,
        darrick.wong@oracle.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 6/7] btrfs: flush dirty pages on compressed I/O for dio
Date:   Fri, 15 Nov 2019 10:16:59 -0600
Message-Id: <20191115161700.12305-7-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191115161700.12305-1-rgoldwyn@suse.de>
References: <20191115161700.12305-1-rgoldwyn@suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Port of "41bd9ca459a0 Btrfs: just do dirty page flush for the
inode with compression before direct IO"

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/inode.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8e55b0d343bd..6654370168ff 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7726,6 +7726,17 @@ static int direct_iomap_begin(struct inode *inode, loff_t start,
 	lockstart = start;
 	lockend = start + len - 1;
 
+	/*
+	 * The generic stuff only does filemap_write_and_wait_range, which
+	 * isn't enough if we've written compressed pages to this area, so
+	 * we need to flush the dirty pages again to make absolutely sure
+	 * that any outstanding dirty pages are on disk.
+	 */
+	if (test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
+				&BTRFS_I(inode)->runtime_flags))
+		filemap_fdatawrite_range(inode->i_mapping, lockstart, lockend);
+
+
 	if (current->journal_info) {
 		/*
 		 * Need to pull our outstanding extents and set journal_info to NULL so
-- 
2.16.4

