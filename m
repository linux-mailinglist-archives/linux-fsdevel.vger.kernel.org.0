Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F433DFBC0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Aug 2021 09:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbhHDHHL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Aug 2021 03:07:11 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:52823 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235495AbhHDHHK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Aug 2021 03:07:10 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UhwuUVZ_1628060816;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UhwuUVZ_1628060816)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 04 Aug 2021 15:06:56 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, virtio-fs@redhat.com,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com
Subject: [PATCH v3 8/8] fuse: show '-o dax=inode' option only when FUSE server supports
Date:   Wed,  4 Aug 2021 15:06:53 +0800
Message-Id: <20210804070653.118123-9-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210804070653.118123-1-jefflexu@linux.alibaba.com>
References: <20210804070653.118123-1-jefflexu@linux.alibaba.com>
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
index 9108d8ab39bc..439f74a041fa 100644
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

