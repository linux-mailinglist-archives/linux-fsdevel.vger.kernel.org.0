Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630E845D51E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Nov 2021 08:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352564AbhKYHKt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Nov 2021 02:10:49 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:39866 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352588AbhKYHIs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Nov 2021 02:08:48 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UyESXWI_1637823935;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UyESXWI_1637823935)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 25 Nov 2021 15:05:35 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu
Cc:     virtio-fs@redhat.com, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
Subject: [PATCH v8 5/7] fuse: negotiate per inode DAX in FUSE_INIT
Date:   Thu, 25 Nov 2021 15:05:28 +0800
Message-Id: <20211125070530.79602-6-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211125070530.79602-1-jefflexu@linux.alibaba.com>
References: <20211125070530.79602-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Among the FUSE_INIT phase, client shall advertise per inode DAX if it's
mounted with "dax=inode". Then server is aware that client is in per
inode DAX mode, and will construct per-inode DAX attribute accordingly.

Server shall also advertise support for per inode DAX. If server doesn't
support it while client is mounted with "dax=inode", client will
silently fallback to "dax=never" since "dax=inode" is advisory only.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/fuse/dax.c    |  2 +-
 fs/fuse/fuse_i.h |  3 +++
 fs/fuse/inode.c  | 13 +++++++++----
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 1550c3624414..234c2278420f 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -1351,7 +1351,7 @@ static bool fuse_should_enable_dax(struct inode *inode, unsigned int flags)
 		return true;
 
 	/* dax_mode is FUSE_DAX_INODE* */
-	return flags & FUSE_ATTR_DAX;
+	return fc->inode_dax && (flags & FUSE_ATTR_DAX);
 }
 
 void fuse_dax_inode_init(struct inode *inode, unsigned int flags)
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f03ea7cb74b0..83970723314a 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -777,6 +777,9 @@ struct fuse_conn {
 	/* Propagate syncfs() to server */
 	unsigned int sync_fs:1;
 
+	/* Does the filesystem support per inode DAX? */
+	unsigned int inode_dax:1;
+
 	/** The number of requests waiting for completion */
 	atomic_t num_waiting;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 0669e41a9645..b26612fce6d0 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1169,10 +1169,13 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 					min_t(unsigned int, fc->max_pages_limit,
 					max_t(unsigned int, arg->max_pages, 1));
 			}
-			if (IS_ENABLED(CONFIG_FUSE_DAX) &&
-			    arg->flags & FUSE_MAP_ALIGNMENT &&
-			    !fuse_dax_check_alignment(fc, arg->map_alignment)) {
-				ok = false;
+			if (IS_ENABLED(CONFIG_FUSE_DAX)) {
+				if (arg->flags & FUSE_MAP_ALIGNMENT &&
+				    !fuse_dax_check_alignment(fc, arg->map_alignment)) {
+					ok = false;
+				}
+				if (arg->flags & FUSE_HAS_INODE_DAX)
+					fc->inode_dax = 1;
 			}
 			if (arg->flags & FUSE_HANDLE_KILLPRIV_V2) {
 				fc->handle_killpriv_v2 = 1;
@@ -1227,6 +1230,8 @@ void fuse_send_init(struct fuse_mount *fm)
 #ifdef CONFIG_FUSE_DAX
 	if (fm->fc->dax)
 		ia->in.flags |= FUSE_MAP_ALIGNMENT;
+	if (fuse_is_inode_dax_mode(fm->fc->dax_mode))
+		ia->in.flags |= FUSE_HAS_INODE_DAX;
 #endif
 	if (fm->fc->auto_submounts)
 		ia->in.flags |= FUSE_SUBMOUNTS;
-- 
2.27.0

