Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4D1502A32
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Apr 2022 14:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353732AbiDOMjb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Apr 2022 08:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350256AbiDOMjZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Apr 2022 08:39:25 -0400
Received: from out199-7.us.a.mail.aliyun.com (out199-7.us.a.mail.aliyun.com [47.90.199.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A383389C;
        Fri, 15 Apr 2022 05:36:31 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0VA7Ug.q_1650026184;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VA7Ug.q_1650026184)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 15 Apr 2022 20:36:25 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com, zhangjiachen.jaycee@bytedance.com
Subject: [PATCH v9 06/21] cachefiles: enable on-demand read mode
Date:   Fri, 15 Apr 2022 20:35:59 +0800
Message-Id: <20220415123614.54024-7-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220415123614.54024-1-jefflexu@linux.alibaba.com>
References: <20220415123614.54024-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Enable on-demand read mode by adding an optional parameter to the "bind"
command.

On-demand mode will be turned on when this parameter is "ondemand", i.e.
"bind ondemand". Otherwise cachefiles will work in the original mode.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/daemon.c | 13 ++++++++-----
 fs/cachefiles/io.c     | 11 -----------
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 2e946e4eb65a..c8bde21ace6a 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -758,11 +758,6 @@ static int cachefiles_daemon_bind(struct cachefiles_cache *cache, char *args)
 	    cache->brun_percent  >= 100)
 		return -ERANGE;
 
-	if (*args) {
-		pr_err("'bind' command doesn't take an argument\n");
-		return -EINVAL;
-	}
-
 	if (!cache->rootdirname) {
 		pr_err("No cache directory specified\n");
 		return -EINVAL;
@@ -774,6 +769,14 @@ static int cachefiles_daemon_bind(struct cachefiles_cache *cache, char *args)
 		return -EBUSY;
 	}
 
+	if (IS_ENABLED(CONFIG_CACHEFILES_ONDEMAND) &&
+	    !strcmp(args, "ondemand")) {
+		set_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags);
+	} else if (*args) {
+		pr_err("'bind' command doesn't take an argument\n");
+		return -EINVAL;
+	}
+
 	/* Make sure we have copies of the tag string */
 	if (!cache->tag) {
 		/*
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index ccf77a969653..000a28f46e59 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -95,7 +95,6 @@ static int cachefiles_read(struct netfs_cache_resources *cres,
 	       file, file_inode(file)->i_ino, start_pos, len,
 	       i_size_read(file_inode(file)));
 
-retry:
 	/* If the caller asked us to seek for data before doing the read, then
 	 * we should do that now.  If we find a gap, we fill it with zeros.
 	 */
@@ -120,16 +119,6 @@ static int cachefiles_read(struct netfs_cache_resources *cres,
 			if (read_hole == NETFS_READ_HOLE_FAIL)
 				goto presubmission_error;
 
-			if (read_hole == NETFS_READ_HOLE_ONDEMAND) {
-				ret = cachefiles_ondemand_read(object, off, len);
-				if (ret)
-					goto presubmission_error;
-
-				/* fail the read if no progress achieved */
-				read_hole = NETFS_READ_HOLE_FAIL;
-				goto retry;
-			}
-
 			iov_iter_zero(len, iter);
 			skipped = len;
 			ret = 0;
-- 
2.27.0

