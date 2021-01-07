Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C10C32ED014
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 13:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbhAGMmD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jan 2021 07:42:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54475 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728624AbhAGMl4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jan 2021 07:41:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610023230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xdr1bNi/8x8nhjwZ1YkQeFiw/2vRifC0b4Sbse7y77w=;
        b=QFilhAaXdEwzgxFZz4FfBIv+UY2GYwCbhhmxw70rgl1UkNE1sjNVSq/DYURRfpUUrqOyW2
        6ZQVcJ8bpfvlrfWPWO5MUfhaYxxG7xKeTfTHWiyVLVBt5HKSuTG62sLPfseUqDzMwj3gZc
        zEfr3opko8GpINZMKiW0kpoXYrQsFTs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-gEfkk03cPxeM1nhMd-DFLg-1; Thu, 07 Jan 2021 07:40:27 -0500
X-MC-Unique: gEfkk03cPxeM1nhMd-DFLg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F2B9800D53;
        Thu,  7 Jan 2021 12:40:25 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C4F460C5C;
        Thu,  7 Jan 2021 12:40:23 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and
        infrastructure)), Jan Kara <jack@suse.cz>,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH] block: fallocate: avoid false positive on collision detection
Date:   Thu,  7 Jan 2021 14:40:22 +0200
Message-Id: <20210107124022.900172-1-mlevitsk@redhat.com>
In-Reply-To: <45420b24124b5b91bc0a80a4abad2e06acb8c2b3.camel@redhat.com>
References: <45420b24124b5b91bc0a80a4abad2e06acb8c2b3.camel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Align start and end on page boundaries before calling
invalidate_inode_pages2_range.

This might allow us to miss a collision if the write and the discard were done
to the same page and do overlap but it is still better than returning -EBUSY
if those writes didn't overlap.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 fs/block_dev.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 9e84b1928b94..97f0d16661b5 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1970,6 +1970,7 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 	loff_t end = start + len - 1;
 	loff_t isize;
 	int error;
+	pgoff_t invalidate_first_page, invalidate_last_page;
 
 	/* Fail if we don't recognize the flags. */
 	if (mode & ~BLKDEV_FALLOC_FL_SUPPORTED)
@@ -2020,12 +2021,23 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 
 	/*
 	 * Invalidate again; if someone wandered in and dirtied a page,
-	 * the caller will be given -EBUSY.  The third argument is
-	 * inclusive, so the rounding here is safe.
+	 * the caller will be given -EBUSY.
+	 *
+	 * If the start/end of the range is not page aligned, exclude the
+	 * non aligned regions to avoid false positives.
 	 */
+	invalidate_first_page = DIV_ROUND_UP(start, PAGE_SIZE);
+	invalidate_last_page = end >> PAGE_SHIFT;
+
+	if ((end + 1) & PAGE_MASK)
+		invalidate_last_page--;
+
+	if (invalidate_last_page < invalidate_first_page)
+		return 0;
+
 	return invalidate_inode_pages2_range(bdev->bd_inode->i_mapping,
-					     start >> PAGE_SHIFT,
-					     end >> PAGE_SHIFT);
+					     invalidate_first_page,
+					     invalidate_last_page);
 }
 
 const struct file_operations def_blk_fops = {
-- 
2.26.2

