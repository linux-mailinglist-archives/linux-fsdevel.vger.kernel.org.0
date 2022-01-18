Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD03E4926CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 14:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242146AbiARNMa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 08:12:30 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:54042 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241972AbiARNMZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 08:12:25 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V2CR7xO_1642511541;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V2CR7xO_1642511541)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 18 Jan 2022 21:12:22 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/20] cachefiles: extract generic daemon write function
Date:   Tue, 18 Jan 2022 21:12:00 +0800
Message-Id: <20220118131216.85338-5-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220118131216.85338-1-jefflexu@linux.alibaba.com>
References: <20220118131216.85338-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

... so that the following new devnode can reuse most of the code when
implementing its .write() callback.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/daemon.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 7ac04ee2c0a0..aa2e5e354afb 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -209,10 +209,11 @@ static ssize_t cachefiles_daemon_read(struct file *file, char __user *_buffer,
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
@@ -261,7 +262,7 @@ static ssize_t cachefiles_daemon_write(struct file *file,
 	}
 
 	/* run the appropriate command handler */
-	for (cmd = cachefiles_daemon_cmds; cmd->name[0]; cmd++)
+	for (cmd = cmds; cmd->name[0]; cmd++)
 		if (strcmp(cmd->name, data) == 0)
 			goto found_command;
 
@@ -284,6 +285,15 @@ static ssize_t cachefiles_daemon_write(struct file *file,
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

