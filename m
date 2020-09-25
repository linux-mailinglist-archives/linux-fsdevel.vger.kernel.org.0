Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBDB2788C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Sep 2020 14:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbgIYM5f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Sep 2020 08:57:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:51798 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729518AbgIYM5d (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Sep 2020 08:57:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 59EECAF2F
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2020 12:57:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 280D51E12D9; Fri, 25 Sep 2020 14:57:32 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 1/3] udf: Avoid accessing uninitialized data on failed inode read
Date:   Fri, 25 Sep 2020 14:57:28 +0200
Message-Id: <20200925125730.8496-2-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200925125730.8496-1-jack@suse.cz>
References: <20200925125730.8496-1-jack@suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When we fail to read inode, some data accessed in udf_evict_inode() may
be uninitialized. Move the accesses to !is_bad_inode() branch.

Reported-by: syzbot+91f02b28f9bb5f5f1341@syzkaller.appspotmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/inode.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index adaba8e8b326..566118417e56 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -139,21 +139,24 @@ void udf_evict_inode(struct inode *inode)
 	struct udf_inode_info *iinfo = UDF_I(inode);
 	int want_delete = 0;
 
-	if (!inode->i_nlink && !is_bad_inode(inode)) {
-		want_delete = 1;
-		udf_setsize(inode, 0);
-		udf_update_inode(inode, IS_SYNC(inode));
+	if (!is_bad_inode(inode)) {
+		if (!inode->i_nlink) {
+			want_delete = 1;
+			udf_setsize(inode, 0);
+			udf_update_inode(inode, IS_SYNC(inode));
+		}
+		if (iinfo->i_alloc_type != ICBTAG_FLAG_AD_IN_ICB &&
+		    inode->i_size != iinfo->i_lenExtents) {
+			udf_warn(inode->i_sb,
+				 "Inode %lu (mode %o) has inode size %llu different from extent length %llu. Filesystem need not be standards compliant.\n",
+				 inode->i_ino, inode->i_mode,
+				 (unsigned long long)inode->i_size,
+				 (unsigned long long)iinfo->i_lenExtents);
+		}
 	}
 	truncate_inode_pages_final(&inode->i_data);
 	invalidate_inode_buffers(inode);
 	clear_inode(inode);
-	if (iinfo->i_alloc_type != ICBTAG_FLAG_AD_IN_ICB &&
-	    inode->i_size != iinfo->i_lenExtents) {
-		udf_warn(inode->i_sb, "Inode %lu (mode %o) has inode size %llu different from extent length %llu. Filesystem need not be standards compliant.\n",
-			 inode->i_ino, inode->i_mode,
-			 (unsigned long long)inode->i_size,
-			 (unsigned long long)iinfo->i_lenExtents);
-	}
 	kfree(iinfo->i_ext.i_data);
 	iinfo->i_ext.i_data = NULL;
 	udf_clear_extent_cache(inode);
-- 
2.16.4

