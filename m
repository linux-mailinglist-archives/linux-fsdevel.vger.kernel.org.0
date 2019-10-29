Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73AF8E8A21
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2019 14:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388819AbfJ2Nxb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Oct 2019 09:53:31 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35428 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388294AbfJ2Nxb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Oct 2019 09:53:31 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iPRw9-0005Wd-Fv; Tue, 29 Oct 2019 13:53:29 +0000
Date:   Tue, 29 Oct 2019 13:53:29 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] ceph_fill_trace(): add missing check in d_revalidate snapdir
 handling
Message-ID: <20191029135329.GI26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[resent to correct address]

we should not play with dcache without parent locked...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 9f135624ae47..c07407586ce8 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1434,6 +1434,7 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 		dout(" final dn %p\n", dn);
 	} else if ((req->r_op == CEPH_MDS_OP_LOOKUPSNAP ||
 		    req->r_op == CEPH_MDS_OP_MKSNAP) &&
+	           test_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags) &&
 		   !test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags)) {
 		struct inode *dir = req->r_parent;
 
