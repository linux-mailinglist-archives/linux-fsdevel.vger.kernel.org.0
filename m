Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250DE4EDD72
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 17:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239113AbiCaPhB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 11:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238883AbiCaPgH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 11:36:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8510A228D3B;
        Thu, 31 Mar 2022 08:32:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3A8061AED;
        Thu, 31 Mar 2022 15:32:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8C0C340ED;
        Thu, 31 Mar 2022 15:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648740736;
        bh=yFggls32PpJnHZoOWr1YXMvmI/6FWHd4t40Ihk95vTM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r8V9Pdpg6RsUKeJgHrhPkJAjiWbPEyk1nCgxSM1htzXf3OZ4HA8IuDr0lQXCSUDsB
         urZPVAfVzGf0hwSpG3n+SQxQrQFSg6PUt8G6g23vNxObk2tr5/AxkNwoBXV639Rif4
         D8fd35kGazY+tKIqe1b/rFwU8JjrUipL9Si/wdr4y5HDD8kx3F9cp70+wVcq2Elko+
         Bq4Tdpu5WpHa99HOssNnfT3MQBndyBiIUTsIPZaJhumZfZqJy/7MCUKdzCtuJaT9mS
         trHJUp8fsl6Vf44MbabP3YJh+qpwhN3a/dBDT33G6icPYE6OupY5CjD87V/lTH9TwT
         HYH/qB1jB3jNA==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     xiubli@redhat.com, idryomov@gmail.com, lhenriques@suse.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v12 48/54] ceph: align data in pages in ceph_sync_write
Date:   Thu, 31 Mar 2022 11:31:24 -0400
Message-Id: <20220331153130.41287-49-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331153130.41287-1-jlayton@kernel.org>
References: <20220331153130.41287-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index fdd59477af5b..ec6324d23aa6 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1553,6 +1553,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 	bool check_caps = false;
 	struct timespec64 mtime = current_time(inode);
 	size_t count = iov_iter_count(from);
+	size_t off;
 
 	if (ceph_snap(file_inode(file)) != CEPH_NOSNAP)
 		return -EROFS;
@@ -1590,12 +1591,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 			break;
 		}
 
-		/*
-		 * write from beginning of first page,
-		 * regardless of io alignment
-		 */
-		num_pages = (len + PAGE_SIZE - 1) >> PAGE_SHIFT;
-
+		num_pages = calc_pages_for(pos, len);
 		pages = ceph_alloc_page_vector(num_pages, GFP_KERNEL);
 		if (IS_ERR(pages)) {
 			ret = PTR_ERR(pages);
@@ -1603,9 +1599,12 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 		}
 
 		left = len;
+		off = offset_in_page(pos);
 		for (n = 0; n < num_pages; n++) {
-			size_t plen = min_t(size_t, left, PAGE_SIZE);
-			ret = copy_page_from_iter(pages[n], 0, plen, from);
+			size_t plen = min_t(size_t, left, PAGE_SIZE - off);
+
+			ret = copy_page_from_iter(pages[n], off, plen, from);
+			off = 0;
 			if (ret != plen) {
 				ret = -EFAULT;
 				break;
@@ -1620,8 +1619,9 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 
 		req->r_inode = inode;
 
-		osd_req_op_extent_osd_data_pages(req, 0, pages, len, 0,
-						false, true);
+		osd_req_op_extent_osd_data_pages(req, 0, pages, len,
+						 offset_in_page(pos),
+						 false, true);
 
 		req->r_mtime = mtime;
 		ret = ceph_osdc_start_request(&fsc->client->osdc, req, false);
-- 
2.35.1

