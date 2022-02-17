Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956414B9F8B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Feb 2022 13:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240198AbiBQMCT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Feb 2022 07:02:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240190AbiBQMCR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Feb 2022 07:02:17 -0500
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFAC60F4;
        Thu, 17 Feb 2022 04:02:02 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0V4kVs6e_1645099318;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V4kVs6e_1645099318)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 17 Feb 2022 20:01:59 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com
Cc:     xiang@kernel.org, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v3 3/4] cachefiles: extract generic function for daemon methods
Date:   Thu, 17 Feb 2022 20:01:53 +0800
Message-Id: <20220217120154.16658-4-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220217120154.16658-1-jefflexu@linux.alibaba.com>
References: <20220217120154.16658-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

... so that the following new devnode can reuse most of the code when
implementing its own methods.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Liu Bo <bo.liu@linux.alibaba.com>
---
 fs/cachefiles/daemon.c | 70 +++++++++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 25 deletions(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 7ac04ee2c0a0..6b8d7c5bbe5d 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -78,6 +78,34 @@ static const struct cachefiles_daemon_cmd cachefiles_daemon_cmds[] = {
 	{ "",		NULL				}
 };
 
+static struct cachefiles_cache *cachefiles_daemon_open_cache(void)
+{
+	struct cachefiles_cache *cache;
+
+	/* allocate a cache record */
+	cache = kzalloc(sizeof(struct cachefiles_cache), GFP_KERNEL);
+	if (cache) {
+		mutex_init(&cache->daemon_mutex);
+		init_waitqueue_head(&cache->daemon_pollwq);
+		INIT_LIST_HEAD(&cache->volumes);
+		INIT_LIST_HEAD(&cache->object_list);
+		spin_lock_init(&cache->object_list_lock);
+
+		/* set default caching limits
+		 * - limit at 1% free space and/or free files
+		 * - cull below 5% free space and/or free files
+		 * - cease culling above 7% free space and/or free files
+		 */
+		cache->frun_percent = 7;
+		cache->fcull_percent = 5;
+		cache->fstop_percent = 1;
+		cache->brun_percent = 7;
+		cache->bcull_percent = 5;
+		cache->bstop_percent = 1;
+	}
+
+	return cache;
+}
 
 /*
  * Prepare a cache for caching.
@@ -96,31 +124,13 @@ static int cachefiles_daemon_open(struct inode *inode, struct file *file)
 	if (xchg(&cachefiles_open, 1) == 1)
 		return -EBUSY;
 
-	/* allocate a cache record */
-	cache = kzalloc(sizeof(struct cachefiles_cache), GFP_KERNEL);
+
+	cache = cachefiles_daemon_open_cache();
 	if (!cache) {
 		cachefiles_open = 0;
 		return -ENOMEM;
 	}
 
-	mutex_init(&cache->daemon_mutex);
-	init_waitqueue_head(&cache->daemon_pollwq);
-	INIT_LIST_HEAD(&cache->volumes);
-	INIT_LIST_HEAD(&cache->object_list);
-	spin_lock_init(&cache->object_list_lock);
-
-	/* set default caching limits
-	 * - limit at 1% free space and/or free files
-	 * - cull below 5% free space and/or free files
-	 * - cease culling above 7% free space and/or free files
-	 */
-	cache->frun_percent = 7;
-	cache->fcull_percent = 5;
-	cache->fstop_percent = 1;
-	cache->brun_percent = 7;
-	cache->bcull_percent = 5;
-	cache->bstop_percent = 1;
-
 	file->private_data = cache;
 	cache->cachefilesd = file;
 	return 0;
@@ -209,10 +219,11 @@ static ssize_t cachefiles_daemon_read(struct file *file, char __user *_buffer,
 /*
  * Take a command from cachefilesd, parse it and act on it.
  */
-static ssize_t cachefiles_daemon_write(struct file *file,
-				       const char __user *_data,
-				       size_t datalen,
-				       loff_t *pos)
+static ssize_t cachefiles_daemon_do_write(struct file *file,
+					  const char __user *_data,
+					  size_t datalen,
+					  loff_t *pos,
+			const struct cachefiles_daemon_cmd *cmds)
 {
 	const struct cachefiles_daemon_cmd *cmd;
 	struct cachefiles_cache *cache = file->private_data;
@@ -261,7 +272,7 @@ static ssize_t cachefiles_daemon_write(struct file *file,
 	}
 
 	/* run the appropriate command handler */
-	for (cmd = cachefiles_daemon_cmds; cmd->name[0]; cmd++)
+	for (cmd = cmds; cmd->name[0]; cmd++)
 		if (strcmp(cmd->name, data) == 0)
 			goto found_command;
 
@@ -284,6 +295,15 @@ static ssize_t cachefiles_daemon_write(struct file *file,
 	goto error;
 }
 
+static ssize_t cachefiles_daemon_write(struct file *file,
+				       const char __user *_data,
+				       size_t datalen,
+				       loff_t *pos)
+{
+	return cachefiles_daemon_do_write(file, _data, datalen, pos,
+					  cachefiles_daemon_cmds);
+}
+
 /*
  * Poll for culling state
  * - use EPOLLOUT to indicate culling state
-- 
2.27.0

