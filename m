Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6DC428566
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Oct 2021 05:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbhJKDDA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Oct 2021 23:03:00 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:53785 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233650AbhJKDC4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Oct 2021 23:02:56 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UrJf2Uv_1633921255;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UrJf2Uv_1633921255)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 11 Oct 2021 11:00:55 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hub
Cc:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        bo.liu@linux.alibaba.com, joseph.qi@linux.alibaba.com
Subject: [PATCH v6 4/7] fuse: negotiate per-file DAX in FUSE_INIT
Date:   Mon, 11 Oct 2021 11:00:49 +0800
Message-Id: <20211011030052.98923-5-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211011030052.98923-1-jefflexu@linux.alibaba.com>
References: <20211011030052.98923-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Among the FUSE_INIT phase, client shall advertise per-file DAX if it's
mounted with "-o dax=inode". Then server is aware that client is in
per-file DAX mode, and will construct per-inode DAX attribute
accordingly.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/fuse/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index b4b41683e97e..f4ad99e2415b 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1203,6 +1203,8 @@ void fuse_send_init(struct fuse_mount *fm)
 #ifdef CONFIG_FUSE_DAX
 	if (fm->fc->dax)
 		ia->in.flags |= FUSE_MAP_ALIGNMENT;
+	if (fm->fc->dax_mode == FUSE_DAX_INODE)
+		ia->in.flags |= FUSE_PERFILE_DAX;
 #endif
 	if (fm->fc->auto_submounts)
 		ia->in.flags |= FUSE_SUBMOUNTS;
-- 
2.27.0

