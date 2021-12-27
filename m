Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D75947FCEC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Dec 2021 13:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237037AbhL0MzS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Dec 2021 07:55:18 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:35702 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236978AbhL0MzM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Dec 2021 07:55:12 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V.xJoSm_1640609709;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V.xJoSm_1640609709)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 27 Dec 2021 20:55:10 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 21/23] cachefiles: implement .read() for demand read
Date:   Mon, 27 Dec 2021 20:54:42 +0800
Message-Id: <20211227125444.21187-22-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
References: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Once notified, user daemon need to get more details of the request by
reading the devnode. The readed information includes the file range of
the request, with which user daemon could somehow prepare corresponding
data (e.g. download from remote through network) and fill the hole.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/daemon.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 311dcd911a85..ce4cc5617dfc 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -29,6 +29,8 @@ static ssize_t cachefiles_daemon_write(struct file *, const char __user *,
 				       size_t, loff_t *);
 static __poll_t cachefiles_daemon_poll(struct file *,
 					   struct poll_table_struct *);
+static ssize_t cachefiles_demand_read(struct file *, char __user *, size_t,
+				      loff_t *);
 static __poll_t cachefiles_demand_poll(struct file *,
 					   struct poll_table_struct *);
 static int cachefiles_daemon_frun(struct cachefiles_cache *, char *);
@@ -63,6 +65,7 @@ const struct file_operations cachefiles_demand_fops = {
 	.owner		= THIS_MODULE,
 	.open		= cachefiles_daemon_open,
 	.release	= cachefiles_daemon_release,
+	.read		= cachefiles_demand_read,
 	.write		= cachefiles_daemon_write,
 	.poll		= cachefiles_demand_poll,
 	.llseek		= noop_llseek,
@@ -322,6 +325,32 @@ static __poll_t cachefiles_daemon_poll(struct file *file,
 	return mask;
 }
 
+static ssize_t cachefiles_demand_read(struct file *file, char __user *_buffer,
+				      size_t buflen, loff_t *pos)
+{
+	struct cachefiles_cache *cache = file->private_data;
+	struct cachefiles_req *req;
+	int n, id = 0;
+
+	if (!test_bit(CACHEFILES_READY, &cache->flags))
+		return 0;
+
+	spin_lock(&cache->reqs_lock);
+	req = idr_get_next(&cache->reqs, &id);
+	spin_unlock(&cache->reqs_lock);
+	if (!req)
+		return 0;
+
+	n = sizeof(req->req_in);
+	if (n > buflen)
+		return -EMSGSIZE;
+
+	if (copy_to_user(_buffer, &req->req_in, n) != 0)
+		return -EFAULT;
+
+	return n;
+}
+
 static __poll_t cachefiles_demand_poll(struct file *file,
 					   struct poll_table_struct *poll)
 {
-- 
2.27.0

