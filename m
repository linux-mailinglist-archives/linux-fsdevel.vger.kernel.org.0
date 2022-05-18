Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1E452BE29
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 May 2022 17:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239231AbiERPLW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 11:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239206AbiERPLS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 11:11:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CFEB1C1;
        Wed, 18 May 2022 08:11:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1699619A0;
        Wed, 18 May 2022 15:11:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE5AC34100;
        Wed, 18 May 2022 15:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652886675;
        bh=8Xbp9VGRkRu9DADovZIgmzELCmC4Crhgf7Qr4utrpxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qTuQJVBHPPrsnt2ojg1qp83eN3IzRVte7f6jq7jELH2AxitcvL3Vn7LBg564ilICO
         R1mWg4xYnIgLEPblkIXhXuoG0D7WtKavP9QOFkC+nD5LWYjSW0rzrMe4IwsAAN8SBk
         z34umzE8JHSsrCD8Cye/fRIsB4POxdiLFGIbBXFfGajEOjxnqTukRly/UyMZIc+52D
         1Q0rlcJyYhc8+3jdDzLIUPNm0sMNQCaj5UlyfE6oTrizt9UiThNdquODUaxeH/D5Pk
         ByVwz7e1xwElB0nvCkESF+l3bFjirqEGN1kMCB/Eeqapxcfy3VqJfvlXtUigh2OgIQ
         YNyT6e1JnFEJw==
From:   Jeff Layton <jlayton@kernel.org>
To:     dhowells@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        xiubli@redhat.com, idryomov@gmail.com
Subject: [PATCH 2/4] ceph: Use the provided iterator in ceph_netfs_issue_op()
Date:   Wed, 18 May 2022 11:11:09 -0400
Message-Id: <20220518151111.79735-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220518151111.79735-1-jlayton@kernel.org>
References: <20220518151111.79735-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

The netfs_read_subrequest struct now contains a persistent iterator
representing the destination buffer for a read that the network filesystem
should use.  Make ceph use this.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/addr.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 8e6a931f3a0f..d14a9378d120 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -233,7 +233,6 @@ static bool ceph_netfs_issue_op_inline(struct netfs_io_subrequest *subreq)
 	struct ceph_mds_request *req;
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct iov_iter iter;
 	ssize_t err = 0;
 	size_t len;
 	int mode;
@@ -268,8 +267,7 @@ static bool ceph_netfs_issue_op_inline(struct netfs_io_subrequest *subreq)
 	}
 
 	len = min_t(size_t, iinfo->inline_len - subreq->start, subreq->len);
-	iov_iter_xarray(&iter, READ, &rreq->mapping->i_pages, subreq->start, len);
-	err = copy_to_iter(iinfo->inline_data + subreq->start, len, &iter);
+	err = copy_to_iter(iinfo->inline_data + subreq->start, len, &subreq->iter);
 	if (err == 0)
 		err = -EFAULT;
 
@@ -287,7 +285,6 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
 	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
 	struct ceph_osd_request *req;
 	struct ceph_vino vino = ceph_vino(inode);
-	struct iov_iter iter;
 	struct page **pages;
 	size_t page_off;
 	int err = 0;
@@ -308,15 +305,14 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
 	}
 
 	dout("%s: pos=%llu orig_len=%zu len=%llu\n", __func__, subreq->start, subreq->len, len);
-	iov_iter_xarray(&iter, READ, &rreq->mapping->i_pages, subreq->start, len);
-	err = iov_iter_get_pages_alloc(&iter, &pages, len, &page_off);
+
+	err = iov_iter_get_pages_alloc(&subreq->iter, &pages, len, &page_off);
 	if (err < 0) {
 		dout("%s: iov_ter_get_pages_alloc returned %d\n", __func__, err);
 		goto out;
 	}
 
-	/* should always give us a page-aligned read */
-	WARN_ON_ONCE(page_off);
+	/* FIXME: adjust the len in req downward if necessary */
 	len = err;
 
 	osd_req_op_extent_osd_data_pages(req, 0, pages, len, 0, false, false);
-- 
2.36.1

