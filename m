Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 434D048B707
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 20:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350763AbiAKTRn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 14:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346329AbiAKTRK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:17:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496FCC028BE5;
        Tue, 11 Jan 2022 11:16:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1285BB81D21;
        Tue, 11 Jan 2022 19:16:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618E5C36AF2;
        Tue, 11 Jan 2022 19:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641928600;
        bh=oEci9JXOMlHJQQwWBKCBwXgtaml6xMFWkKDpgYBLTzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZwSbr0LCMZxWV/RhxJNVwhsKpJd4JKxXdn6poNsvFj8O7VWgwClSC/SV5C1f2QRgD
         Rp1j1z4rohBIlcDfL9ECctVAakrA78pvKrcTHIL1gYNgPYTz9NwSveAdn5jZzgUTJE
         QqkbGH5Afsv8zHKs5KchtY+4Ucnz0wFp0nYCQJZT8TmB7SJIkIR5LdxGBNtuJ+jDt/
         7ctWfbQM9rKXj8MQK7llMZLErukJ7Jje5e8BQU6kqGfOypNYnMcoL7ecYLozSeC4gn
         4ecAWRhC/NrX92k1atfZ0WQRfmX1z7IGbiCzRJv4EpcaPgHTBnLzExjCiqstcbkJs9
         FKbc8t6kkojNg==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, idryomov@gmail.com
Subject: [RFC PATCH v10 42/48] ceph: align data in pages in ceph_sync_write
Date:   Tue, 11 Jan 2022 14:16:02 -0500
Message-Id: <20220111191608.88762-43-jlayton@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220111191608.88762-1-jlayton@kernel.org>
References: <20220111191608.88762-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Encrypted files will need to be dealt with in block-sized chunks and
once we do that, the way that ceph_sync_write aligns the data in the
bounce buffer won't be acceptable.

Change it to align the data the same way it would be aligned in the
pagecache.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/file.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 17e26c030f5f..a6305ad5519b 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1479,6 +1479,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 	bool check_caps = false;
 	struct timespec64 mtime = current_time(inode);
 	size_t count = iov_iter_count(from);
+	size_t off;
 
 	if (ceph_snap(file_inode(file)) != CEPH_NOSNAP)
 		return -EROFS;
@@ -1516,12 +1517,8 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 			break;
 		}
 
-		/*
-		 * write from beginning of first page,
-		 * regardless of io alignment
-		 */
-		num_pages = (len + PAGE_SIZE - 1) >> PAGE_SHIFT;
-
+		/* FIXME: express in FSCRYPT_BLOCK_SIZE units */
+		num_pages = calc_pages_for(pos, len);
 		pages = ceph_alloc_page_vector(num_pages, GFP_KERNEL);
 		if (IS_ERR(pages)) {
 			ret = PTR_ERR(pages);
@@ -1529,9 +1526,11 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 		}
 
 		left = len;
+		off = pos & ~CEPH_FSCRYPT_BLOCK_MASK;
 		for (n = 0; n < num_pages; n++) {
-			size_t plen = min_t(size_t, left, PAGE_SIZE);
-			ret = copy_page_from_iter(pages[n], 0, plen, from);
+			size_t plen = min_t(size_t, left, CEPH_FSCRYPT_BLOCK_SIZE - off);
+			ret = copy_page_from_iter(pages[n], off, plen, from);
+			off = 0;
 			if (ret != plen) {
 				ret = -EFAULT;
 				break;
@@ -1546,8 +1545,9 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 
 		req->r_inode = inode;
 
-		osd_req_op_extent_osd_data_pages(req, 0, pages, len, 0,
-						false, true);
+		osd_req_op_extent_osd_data_pages(req, 0, pages, len,
+						 pos & ~CEPH_FSCRYPT_BLOCK_MASK,
+						 false, true);
 
 		req->r_mtime = mtime;
 		ret = ceph_osdc_start_request(&fsc->client->osdc, req, false);
-- 
2.34.1

