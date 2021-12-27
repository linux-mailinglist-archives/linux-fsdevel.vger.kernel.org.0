Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD47547FCEF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Dec 2021 13:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237058AbhL0MzT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Dec 2021 07:55:19 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:45133 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237000AbhL0MzN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Dec 2021 07:55:13 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V.wXYWr_1640609710;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V.wXYWr_1640609710)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 27 Dec 2021 20:55:11 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 22/23] cachefiles: add done command for demand read
Date:   Mon, 27 Dec 2021 20:54:43 +0800
Message-Id: <20211227125444.21187-23-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
References: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Once has prepared data and filled the hole, user daemon could notify
cachefiles backend by writing 'done' command to devnode.

With done command, the id originally readed from devnode is transferred
back to cachefiles backend. This id identifies the position of the
completed request inside the idr tree, and thus cachefiles backend could
find the corresponding completed request once gets notified.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/daemon.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index ce4cc5617dfc..36d0bcf5fc3f 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -48,6 +48,7 @@ static int cachefiles_daemon_tag(struct cachefiles_cache *, char *);
 static int cachefiles_daemon_mode(struct cachefiles_cache *, char *);
 static int cachefiles_daemon_bind(struct cachefiles_cache *, char *);
 static void cachefiles_daemon_unbind(struct cachefiles_cache *);
+static int cachefiles_daemon_done(struct cachefiles_cache *, char *);
 
 static unsigned long cachefiles_open;
 
@@ -91,6 +92,7 @@ static const struct cachefiles_daemon_cmd cachefiles_daemon_cmds[] = {
 	{ "secctx",	cachefiles_daemon_secctx	},
 	{ "tag",	cachefiles_daemon_tag		},
 	{ "mode",	cachefiles_daemon_mode		},
+	{ "done",	cachefiles_daemon_done		},
 	{ "",		NULL				}
 };
 
@@ -604,6 +606,38 @@ static int cachefiles_daemon_tag(struct cachefiles_cache *cache, char *args)
 	return 0;
 }
 
+/*
+ * Request completion
+ * - command: "done <id>"
+ */
+static int cachefiles_daemon_done(struct cachefiles_cache *cache, char *args)
+{
+	unsigned long id;
+	int ret;
+	struct cachefiles_req *req;
+
+	_enter(",%s", args);
+
+	if (!*args) {
+		pr_err("Empty id specified\n");
+		return -EINVAL;
+	}
+
+	ret = kstrtoul(args, 0, &id);
+	if (ret)
+		return ret;
+
+	spin_lock(&cache->reqs_lock);
+	req = idr_remove(&cache->reqs, id);
+	spin_unlock(&cache->reqs_lock);
+	if (!req)
+		return -EINVAL;
+
+	complete(&req->done);
+
+	return 0;
+}
+
 /*
  * Request a node in the cache be culled from the current working directory
  * - command: "cull <name>"
-- 
2.27.0

