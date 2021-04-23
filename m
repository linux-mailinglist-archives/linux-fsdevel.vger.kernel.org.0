Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31CC369AFE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Apr 2021 21:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243979AbhDWToL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Apr 2021 15:44:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243941AbhDWToK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Apr 2021 15:44:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 22B2D613C3;
        Fri, 23 Apr 2021 19:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619207013;
        bh=r+wSGFxLzhy9PdYfk7/aXccc1B2fnDspkLIYaK0Nb0k=;
        h=From:To:Cc:Subject:Date:From;
        b=N0LGVjA1hOlnij2eO5hJ+oZekjCcTKixLGsavS79dywbkJ5a0Ybkb0SwL77fxG7wJ
         P5m+VdUBIQvBScB9ZVX94Fk6M6kOOUd/UoPA8cH66ISFUEOwSBzhhHqxPwM2BYQ/cO
         SLlEBBQazhIda1DqVNoXHVxGZjTQtXe5IoikA6hqS5PE3CHx8iKC+NBEPCnEjprsGZ
         RKlpeUkT/KsFiVhmnxEzNRtGMf0Xyj9b4QjDjrKX8i3TRqDfobqyOPg7ardn2cuzZA
         OGyHs5pdUtFFky07PLuHlP3Ja2wVJ0pW764s8TSZbcNUcTbvXwQ0DWa92lx1p3UjEG
         N4/Ozn8A81/bA==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     idryomov@gmail.com, xiublu@redhat.com, dhowells@redhat.com,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        willy@infradead.org, lhenriques@suse.de
Subject: [PATCH v2] ceph: clamp length of an OSD read to rsize mount option
Date:   Fri, 23 Apr 2021 15:43:31 -0400
Message-Id: <20210423194331.203697-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There's a hard limit on how large a read we can do from the OSD, defined
as CEPH_MSG_MAX_DATA_LEN (currently, 64M). It's possible to create a
file that is backed by larger objects than that (and indeed, xfstest
ceph/001 does just that).

Ensure we clamp the final length of a read to the rsize, which defaults
to CEPH_MSG_MAX_DATA_LEN, but can be set lower.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/addr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

I think this version is more correct. Again, I'll plan to roll this into
the earlier patch that adds the clamp_length op.

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 9939100f9f9d..c1570fada3d8 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -205,6 +205,7 @@ static void ceph_netfs_expand_readahead(struct netfs_read_request *rreq)
 static bool ceph_netfs_clamp_length(struct netfs_read_subrequest *subreq)
 {
 	struct inode *inode = subreq->rreq->mapping->host;
+	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	u64 objno, objoff;
 	u32 xlen;
@@ -212,7 +213,7 @@ static bool ceph_netfs_clamp_length(struct netfs_read_subrequest *subreq)
 	/* Truncate the extent at the end of the current block */
 	ceph_calc_file_object_mapping(&ci->i_layout, subreq->start, subreq->len,
 				      &objno, &objoff, &xlen);
-	subreq->len = xlen;
+	subreq->len = min(xlen, fsc->mount_options->rsize);
 	return true;
 }
 
-- 
2.31.1

