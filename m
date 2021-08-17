Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 277383EE444
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 04:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236662AbhHQCXF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 22:23:05 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:35427 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236550AbhHQCW7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 22:22:59 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UjHKDCK_1629166944;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UjHKDCK_1629166944)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 17 Aug 2021 10:22:24 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, virtio-fs@redhat.com,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com
Subject: [PATCH v4 8/8] fuse: show '-o dax=inode' option only when FUSE server supports
Date:   Tue, 17 Aug 2021 10:22:20 +0800
Message-Id: <20210817022220.17574-9-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Prior of this patch, the mount option will still show '-o dax=inode'
when FUSE server advertises that it doesn't support per-file DAX.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/fuse/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 8c9774c6a210..7f09a964823f 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -697,7 +697,7 @@ static int fuse_show_options(struct seq_file *m, struct dentry *root)
 		seq_puts(m, ",dax=always");
 	else if (fc->dax_mode == FUSE_DAX_NEVER)
 		seq_puts(m, ",dax=never");
-	else if (fc->dax_mode == FUSE_DAX_INODE)
+	else if ((fc->dax_mode == FUSE_DAX_INODE) && fc->perfile_dax)
 		seq_puts(m, ",dax=inode");
 #endif
 
-- 
2.27.0

