Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41ADA1BAC41
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 20:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgD0SUM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 14:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726223AbgD0SUJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 14:20:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D16C03C1A7;
        Mon, 27 Apr 2020 11:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=gZhdoYkjuvbpOueM83yzKSJUBUXDbflvgTLRFJS+QTc=; b=izdrZisi9bf+E3dITzFP6ng0yD
        oTEhCwg2AgiJWFUqFz7mtC+8gkjdPLvcaIOvBpU01Kcv/BGroCLWlHpsdFjOnlyERY95KqbR9Lqtk
        jmcV1t4iieQ/r7aaQ/nuu5r85oH4vqfmkxup6QAqyYJ3UkovexfWoRLk4bekP8aZc8X1/gIzFkWwV
        xCzV3I17qvzjyHdUljyraiC+JLjGlGSIIloivnX1do6McV12eLQCbdJU9D9HlffDODWk5qZ09sEt9
        kK6E0EkRO5f8D+567YBtQUcsn2f6BHbsTM2BGtKoFl7BH3t7mczz7hhB0ryobtFTZN0tGU8UBInPg
        OSg8QbQQ==;
Received: from [2001:4bb8:193:f203:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jT8MS-0003Jp-RT; Mon, 27 Apr 2020 18:20:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-ext4@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     jack@suse.cz, tytso@mit.edu, adilger@dilger.ca,
        riteshh@linux.ibm.com, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: [PATCH 04/11] ext4: remove the call to fiemap_check_flags in ext4_fiemap
Date:   Mon, 27 Apr 2020 20:19:50 +0200
Message-Id: <20200427181957.1606257-5-hch@lst.de>
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

iomap_fiemap already calls fiemap_check_flags first thing, so this
additional check is redundant.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ext4/extents.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index d2a2a3ba5c44a..a41ae7c510170 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4866,9 +4866,6 @@ int ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		fieinfo->fi_flags &= ~FIEMAP_FLAG_CACHE;
 	}
 
-	if (fiemap_check_flags(fieinfo, FIEMAP_FLAG_SYNC | FIEMAP_FLAG_XATTR))
-		return -EBADR;
-
 	/*
 	 * For bitmap files the maximum size limit could be smaller than
 	 * s_maxbytes, so check len here manually instead of just relying on the
-- 
2.26.1

