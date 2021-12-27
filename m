Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE9F47FCEA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Dec 2021 13:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbhL0MzQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Dec 2021 07:55:16 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:6852 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236921AbhL0MzL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Dec 2021 07:55:11 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V.xJoSZ_1640609708;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V.xJoSZ_1640609708)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 27 Dec 2021 20:55:08 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 20/23] cachefiles: implement .poll() for demand read
Date:   Mon, 27 Dec 2021 20:54:41 +0800
Message-Id: <20211227125444.21187-21-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
References: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

User daemon needs to poll on the devnode, and will be notified once
there's pending request to process.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/daemon.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 01496fa8c263..311dcd911a85 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -29,6 +29,8 @@ static ssize_t cachefiles_daemon_write(struct file *, const char __user *,
 				       size_t, loff_t *);
 static __poll_t cachefiles_daemon_poll(struct file *,
 					   struct poll_table_struct *);
+static __poll_t cachefiles_demand_poll(struct file *,
+					   struct poll_table_struct *);
 static int cachefiles_daemon_frun(struct cachefiles_cache *, char *);
 static int cachefiles_daemon_fcull(struct cachefiles_cache *, char *);
 static int cachefiles_daemon_fstop(struct cachefiles_cache *, char *);
@@ -62,6 +64,7 @@ const struct file_operations cachefiles_demand_fops = {
 	.open		= cachefiles_daemon_open,
 	.release	= cachefiles_daemon_release,
 	.write		= cachefiles_daemon_write,
+	.poll		= cachefiles_demand_poll,
 	.llseek		= noop_llseek,
 };
 
@@ -319,6 +322,21 @@ static __poll_t cachefiles_daemon_poll(struct file *file,
 	return mask;
 }
 
+static __poll_t cachefiles_demand_poll(struct file *file,
+					   struct poll_table_struct *poll)
+{
+	struct cachefiles_cache *cache = file->private_data;
+	__poll_t mask;
+
+	poll_wait(file, &cache->daemon_pollwq, poll);
+	mask = 0;
+
+	if (!idr_is_empty(&cache->reqs))
+		mask |= EPOLLIN;
+
+	return mask;
+}
+
 /*
  * Give a range error for cache space constraints
  * - can be tail-called
-- 
2.27.0

