Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DECDA496095
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jan 2022 15:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381017AbiAUOSn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jan 2022 09:18:43 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57302 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381012AbiAUOSm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:18:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80BF4617AE;
        Fri, 21 Jan 2022 14:18:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC6EC340E5;
        Fri, 21 Jan 2022 14:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642774721;
        bh=2u9pe6nwGCKcyCtVd6BRmuJUvlF6F40W1gx18D56fZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vht3QlyWwaIZ7NwwqARRkFgonbUxbEN8fU45cPL6NBA0FCuW8zliu37exdtLGti+l
         PEWfKySrd4LeHk0aqENtwjGAEj+SXuL3U30KLnVk1TzWTIqyyUHohSJAFRyyOADvG6
         KLeb7BlbjwNZOmcmg6XjfZ+r1r3o15NiivksqLEGUzerFHy+VugJU3o7nUjJ+0bRAZ
         fOHkT2NPohx5q9eWqMDCaV+DuhapNxhtV2ss9WzXBfU8vDexb2PBuLzxAGl09/9H18
         yb5g0iCq2KJazdGxN6u/mxZ5SoDSIMFRXB6olVL/n5NKMFcuTKw+hscf+lxpDR2D2U
         pTUWbfMxG653Q==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     idryomov@gmail.com, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 2/3] ceph: Make ceph_netfs_issue_op() handle inlined data
Date:   Fri, 21 Jan 2022 09:18:37 -0500
Message-Id: <20220121141838.110954-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121141838.110954-1-jlayton@kernel.org>
References: <20220121141838.110954-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Make ceph_netfs_issue_op() handle inlined data on page 0.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/addr.c | 79 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 62 insertions(+), 17 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index fcba36d2cc23..01d97ab56f71 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -239,6 +239,61 @@ static void finish_netfs_read(struct ceph_osd_request *req)
 	iput(req->r_inode);
 }
 
+static bool ceph_netfs_issue_op_inline(struct netfs_read_subrequest *subreq)
+{
+	struct netfs_read_request *rreq = subreq->rreq;
+	struct inode *inode = rreq->inode;
+	struct ceph_mds_reply_info_parsed *rinfo;
+	struct ceph_mds_reply_info_in *iinfo;
+	struct ceph_mds_request *req;
+	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct iov_iter iter;
+	ssize_t err = 0;
+	size_t len;
+
+	__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
+	__clear_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags);
+
+	if (subreq->start >= inode->i_size)
+		goto out;
+
+	/* We need to fetch the inline data. */
+	req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_GETATTR, USE_ANY_MDS);
+	if (IS_ERR(req)) {
+		err = PTR_ERR(req);
+		goto out;
+	}
+	req->r_ino1 = ci->i_vino;
+	req->r_args.getattr.mask = cpu_to_le32(CEPH_STAT_CAP_INLINE_DATA);
+	req->r_num_caps = 2;
+
+	err = ceph_mdsc_do_request(mdsc, NULL, req);
+	if (err < 0)
+		goto out;
+
+	rinfo = &req->r_reply_info;
+	iinfo = &rinfo->targeti;
+	if (iinfo->inline_version == CEPH_INLINE_NONE) {
+		/* The data got uninlined */
+		ceph_mdsc_put_request(req);
+		return false;
+	}
+
+	len = iinfo->inline_len;
+	iov_iter_xarray(&iter, READ, &rreq->mapping->i_pages, subreq->start, len);
+
+	err = copy_to_iter(iinfo->inline_data, len, &iter);
+	if (err == 0)
+		err = -EFAULT;
+
+	ceph_mdsc_put_request(req);
+
+out:
+	netfs_subreq_terminated(subreq, err, false);
+	return true;
+}
+
 static void ceph_netfs_issue_op(struct netfs_read_subrequest *subreq)
 {
 	struct netfs_read_request *rreq = subreq->rreq;
@@ -253,6 +308,10 @@ static void ceph_netfs_issue_op(struct netfs_read_subrequest *subreq)
 	int err = 0;
 	u64 len = subreq->len;
 
+	if (ci->i_inline_version != CEPH_INLINE_NONE &&
+	    ceph_netfs_issue_op_inline(subreq))
+		return;
+
 	req = ceph_osdc_new_request(&fsc->client->osdc, &ci->i_layout, vino, subreq->start, &len,
 			0, 1, CEPH_OSD_OP_READ,
 			CEPH_OSD_FLAG_READ | fsc->client->osdc.client->options->read_from_replica,
@@ -326,23 +385,9 @@ static int ceph_readpage(struct file *file, struct page *subpage)
 	size_t len = folio_size(folio);
 	u64 off = folio_file_pos(folio);
 
-	if (ci->i_inline_version != CEPH_INLINE_NONE) {
-		/*
-		 * Uptodate inline data should have been added
-		 * into page cache while getting Fcr caps.
-		 */
-		if (off == 0) {
-			folio_unlock(folio);
-			return -EINVAL;
-		}
-		zero_user_segment(&folio->page, 0, folio_size(folio));
-		folio_mark_uptodate(folio);
-		folio_unlock(folio);
-		return 0;
-	}
-
-	dout("readpage ino %llx.%llx file %p off %llu len %zu folio %p index %lu\n",
-	     vino.ino, vino.snap, file, off, len, folio, folio_index(folio));
+	dout("readpage ino %llx.%llx file %p off %llu len %zu folio %p index %lu\n inline %d",
+	     vino.ino, vino.snap, file, off, len, folio, folio_index(folio),
+	     ci->i_inline_version != CEPH_INLINE_NONE);
 
 	return netfs_readpage(file, folio, &ceph_netfs_read_ops, NULL);
 }
-- 
2.34.1

