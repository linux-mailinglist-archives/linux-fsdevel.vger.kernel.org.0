Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5358E1BAC39
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 20:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgD0SUD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 14:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725995AbgD0SUD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 14:20:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37432C0610D5;
        Mon, 27 Apr 2020 11:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=RgQiwfsSPXHYeN94dR0SYoXUiw/kCpJ0Bv9UO/BsFqU=; b=BZxBCRTur20sj9uySrIguqsEiH
        kawpgo4M21PUls6U6h8RMq+sC8wX4PjSq1ndwBGO0wnMDbDYe75vmGHV7S7V1T1ES+EAqcYKYizw9
        yV4vsVlcTJhLFgOX8c+/mV8O60eaRc4pqvX1B2aYJUGzuS1CzJiQX6ItOGqEyVdreh2vMPEYsXz9+
        06xagbrY2xPze2EyMXJsDCGnqs+3afHtjqEGQNsdL21HUIXnalZmsdxUJIXkHqZwbxJtu/yhOY02K
        mnnEt8ksW3sCuIGgUtG4GMhENhUhMMOfZRmmGrJPOoVZWIRxr/WDWYy0MupN84aDTwT+EFVJhtc49
        W5Fy50ZQ==;
Received: from [2001:4bb8:193:f203:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jT8ML-00025U-J1; Mon, 27 Apr 2020 18:20:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-ext4@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     jack@suse.cz, tytso@mit.edu, adilger@dilger.ca,
        riteshh@linux.ibm.com, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        syzbot+77fa5bdb65cc39711820@syzkaller.appspotmail.com
Subject: [PATCH 01/11] ext4: fix EXT4_MAX_LOGICAL_BLOCK macro
Date:   Mon, 27 Apr 2020 20:19:47 +0200
Message-Id: <20200427181957.1606257-2-hch@lst.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200427181957.1606257-1-hch@lst.de>
References: <20200427181957.1606257-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ritesh Harjani <riteshh@linux.ibm.com>

ext4 supports max number of logical blocks in a file to be 0xffffffff.
(This is since ext4_extent's ee_block is __le32).
This means that EXT4_MAX_LOGICAL_BLOCK should be 0xfffffffe (starting
from 0 logical offset). This patch fixes this.

The issue was seen when ext4 moved to iomap_fiemap API and when
overlayfs was mounted on top of ext4. Since overlayfs was missing
filemap_check_ranges(), so it could pass a arbitrary huge length which
lead to overflow of map.m_len logic.

This patch fixes that.

Fixes: d3b6f23f7167 ("ext4: move ext4_fiemap to use iomap framework")
Reported-by: syzbot+77fa5bdb65cc39711820@syzkaller.appspotmail.com
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ext4/ext4.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 91eb4381cae5b..ad2dbf6e49245 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -722,7 +722,7 @@ enum {
 #define EXT4_MAX_BLOCK_FILE_PHYS	0xFFFFFFFF
 
 /* Max logical block we can support */
-#define EXT4_MAX_LOGICAL_BLOCK		0xFFFFFFFF
+#define EXT4_MAX_LOGICAL_BLOCK		0xFFFFFFFE
 
 /*
  * Structure of an inode on the disk
-- 
2.26.1

