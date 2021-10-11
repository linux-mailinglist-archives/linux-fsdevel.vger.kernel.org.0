Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2DB428568
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Oct 2021 05:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbhJKDDB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Oct 2021 23:03:01 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:34586 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233677AbhJKDC5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Oct 2021 23:02:57 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UrJTOYS_1633921256;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UrJTOYS_1633921256)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 11 Oct 2021 11:00:56 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hub
Cc:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        bo.liu@linux.alibaba.com, joseph.qi@linux.alibaba.com
Subject: [PATCH v6 6/7] fuse: mark inode DONT_CACHE when per-file DAX hint changes
Date:   Mon, 11 Oct 2021 11:00:51 +0800
Message-Id: <20211011030052.98923-7-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211011030052.98923-1-jefflexu@linux.alibaba.com>
References: <20211011030052.98923-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When the per-file DAX hint changes while the file is still *opened*, it
is quite complicated and maybe fragile to dynamically change the DAX
state.

Hence mark the inode and corresponding dentries as DONE_CACHE once the
per-file DAX hint changes, so that the inode instance will be evicted
and freed as soon as possible once the file is closed and the last
reference to the inode is put. And then when the file gets reopened next
time, the new instantiated inode will reflect the new DAX state.

In summary, when the per-file DAX hint changes for an *opened* file, the
DAX state of the file won't be updated until this file is closed and
reopened later.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/fuse/dax.c    | 9 +++++++++
 fs/fuse/fuse_i.h | 1 +
 fs/fuse/inode.c  | 3 +++
 3 files changed, 13 insertions(+)

diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 15bde36829b8..ca083c13f5e8 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -1364,6 +1364,15 @@ void fuse_dax_inode_init(struct inode *inode, unsigned int flags)
 	inode->i_data.a_ops = &fuse_dax_file_aops;
 }
 
+void fuse_dax_dontcache(struct inode *inode, unsigned int flags)
+{
+	struct fuse_conn *fc = get_fuse_conn(inode);
+
+	if (fc->dax_mode == FUSE_DAX_INODE &&
+	    (!!IS_DAX(inode) != !!(flags & FUSE_ATTR_DAX)))
+		d_mark_dontcache(inode);
+}
+
 bool fuse_dax_check_alignment(struct fuse_conn *fc, unsigned int map_alignment)
 {
 	if (fc->dax && (map_alignment > FUSE_DAX_SHIFT)) {
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 0270a41c31d7..bb2c11e0311a 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1270,6 +1270,7 @@ void fuse_dax_conn_free(struct fuse_conn *fc);
 bool fuse_dax_inode_alloc(struct super_block *sb, struct fuse_inode *fi);
 void fuse_dax_inode_init(struct inode *inode, unsigned int flags);
 void fuse_dax_inode_cleanup(struct inode *inode);
+void fuse_dax_dontcache(struct inode *inode, unsigned int flags);
 bool fuse_dax_check_alignment(struct fuse_conn *fc, unsigned int map_alignment);
 void fuse_dax_cancel_work(struct fuse_conn *fc);
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 73f19cd6e702..cf934c2ba761 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -268,6 +268,9 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 		if (inval)
 			invalidate_inode_pages2(inode->i_mapping);
 	}
+
+	if (IS_ENABLED(CONFIG_FUSE_DAX))
+		fuse_dax_dontcache(inode, attr->flags);
 }
 
 static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr)
-- 
2.27.0

