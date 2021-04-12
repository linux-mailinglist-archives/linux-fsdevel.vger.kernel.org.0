Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B69535C3CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Apr 2021 12:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239154AbhDLKX6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Apr 2021 06:23:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:49966 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237607AbhDLKX5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Apr 2021 06:23:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 04D01AFF3;
        Mon, 12 Apr 2021 10:23:39 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AD5E41F2B6B; Mon, 12 Apr 2021 12:23:38 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Eric Whitney <enwlinux@gmail.com>,
        <linux-fsdevel@vger.kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 3/3] ext4: Fix overflow in ext4_iomap_alloc()
Date:   Mon, 12 Apr 2021 12:23:33 +0200
Message-Id: <20210412102333.2676-4-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210412102333.2676-1-jack@suse.cz>
References: <20210412102333.2676-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A code in iomap alloc may overblock block number when converting it to
byte offset. Luckily this is mostly harmless as we will just use more
expensive method of writing using unwritten extents even though we are
writing beyond i_size.

Fixes: 378f32bab371 ("ext4: introduce direct I/O write using iomap infrastructure")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 0948a43f1b3d..7cebbb2d2e34 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3420,7 +3420,7 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
 	 * i_disksize out to i_size. This could be beyond where direct I/O is
 	 * happening and thus expose allocated blocks to direct I/O reads.
 	 */
-	else if ((map->m_lblk * (1 << blkbits)) >= i_size_read(inode))
+	else if (((loff_t)map->m_lblk << blkbits) >= i_size_read(inode))
 		m_flags = EXT4_GET_BLOCKS_CREATE;
 	else if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
 		m_flags = EXT4_GET_BLOCKS_IO_CREATE_EXT;
-- 
2.26.2

