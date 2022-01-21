Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9A749609B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jan 2022 15:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381039AbiAUOSr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jan 2022 09:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381022AbiAUOSo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:18:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC77C06173F;
        Fri, 21 Jan 2022 06:18:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B16FB81FB0;
        Fri, 21 Jan 2022 14:18:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD741C340E4;
        Fri, 21 Jan 2022 14:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642774721;
        bh=CcBmZjXQGpjwvTM5+AfWUuAJXNCr0n4yAqb5f6GIcgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N2lCgfagNhlKq++z3Bt88YeYPmO6Daz+7UyWw6VvejHBGGeEvLpdcBnKFUrF+5iq2
         kGI0TKCC8+Is20SWZhUd67Gi+4kLD1jTI56QbBkGtergmJeyL4jdUwDoSrbpUP6ITR
         ubLeR2Ml3yGYi9t9a0maM4v06YiRHr/ZnzNneuUBmx4Zma7BpCmOe51+baJLNjamX5
         3lNIoOYF+U163J64nxw7C9p6xSTZnJ21e8dB+SViJom1hSfddd/7Mb0KuskgqE+Yg5
         X6rn6dwMqRQ4ogJortqIctNtjj9TJZ8wq1hjsC+9K2kilJ9o7CCg3h87LSKq8vbGCR
         DVkcnsbhZ+0fQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     idryomov@gmail.com, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 1/3] ceph: switch netfs read ops to use rreq->inode instead of rreq->mapping->host
Date:   Fri, 21 Jan 2022 09:18:36 -0500
Message-Id: <20220121141838.110954-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121141838.110954-1-jlayton@kernel.org>
References: <20220121141838.110954-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

One fewer pointer dereference, and in the future we may not be able to
count on the mapping pointer being populated (e.g. in the DIO case).

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/addr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index e53c8541f5b2..fcba36d2cc23 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -179,7 +179,7 @@ static int ceph_releasepage(struct page *page, gfp_t gfp)
 
 static void ceph_netfs_expand_readahead(struct netfs_read_request *rreq)
 {
-	struct inode *inode = rreq->mapping->host;
+	struct inode *inode = rreq->inode;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_file_layout *lo = &ci->i_layout;
 	u32 blockoff;
@@ -196,7 +196,7 @@ static void ceph_netfs_expand_readahead(struct netfs_read_request *rreq)
 
 static bool ceph_netfs_clamp_length(struct netfs_read_subrequest *subreq)
 {
-	struct inode *inode = subreq->rreq->mapping->host;
+	struct inode *inode = subreq->rreq->inode;
 	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	u64 objno, objoff;
@@ -242,7 +242,7 @@ static void finish_netfs_read(struct ceph_osd_request *req)
 static void ceph_netfs_issue_op(struct netfs_read_subrequest *subreq)
 {
 	struct netfs_read_request *rreq = subreq->rreq;
-	struct inode *inode = rreq->mapping->host;
+	struct inode *inode = rreq->inode;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
 	struct ceph_osd_request *req;
-- 
2.34.1

