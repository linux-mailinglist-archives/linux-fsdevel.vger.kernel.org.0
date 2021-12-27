Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F4147FCF6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Dec 2021 13:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237120AbhL0Mzb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Dec 2021 07:55:31 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:46668 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232241AbhL0MzJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Dec 2021 07:55:09 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V.vxTKl_1640609705;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V.vxTKl_1640609705)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 27 Dec 2021 20:55:06 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 18/23] cachefiles: use idr tree managing pending demand read
Date:   Mon, 27 Dec 2021 20:54:39 +0800
Message-Id: <20211227125444.21187-19-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
References: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is in prep for implementing .demand_read() callback for cachefiles.

In the following patch, .demand_read() callback is responsible for
notifying user daemon the requested file range (hole) to read. Then
.demand_read() callback will get blocked until user daemon has prepared
data and filled the hole.

This patch introduces an idr tree to manage all these pending
demand-read IO.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/daemon.c   | 3 +++
 fs/cachefiles/internal.h | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 892a9bdba53f..01496fa8c263 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -118,6 +118,8 @@ static int cachefiles_daemon_open(struct inode *inode, struct file *file)
 	INIT_LIST_HEAD(&cache->volumes);
 	INIT_LIST_HEAD(&cache->object_list);
 	spin_lock_init(&cache->object_list_lock);
+	idr_init(&cache->reqs);
+	spin_lock_init(&cache->reqs_lock);
 
 	/* set default caching limits
 	 * - limit at 1% free space and/or free files
@@ -152,6 +154,7 @@ static int cachefiles_daemon_release(struct inode *inode, struct file *file)
 	cachefiles_daemon_unbind(cache);
 
 	/* clean up the control file interface */
+	idr_destroy(&cache->reqs);
 	cache->cachefilesd = NULL;
 	file->private_data = NULL;
 	cachefiles_open = 0;
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index a8e6500889d7..af8ac8107f77 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -15,6 +15,7 @@
 #include <linux/fscache-cache.h>
 #include <linux/cred.h>
 #include <linux/security.h>
+#include <linux/idr.h>
 
 #define CACHEFILES_DIO_BLOCK_SIZE 4096
 
@@ -102,6 +103,9 @@ struct cachefiles_cache {
 	char				*rootdirname;	/* name of cache root directory */
 	char				*secctx;	/* LSM security context */
 	char				*tag;		/* cache binding tag */
+
+	struct idr			reqs;
+	spinlock_t			reqs_lock;
 };
 
 #include <trace/events/cachefiles.h>
-- 
2.27.0

