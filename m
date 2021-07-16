Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145AA3CB094
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 03:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhGPBzp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 21:55:45 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:54738 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230297AbhGPBzp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 21:55:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Ufw0VTO_1626400369;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Ufw0VTO_1626400369)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 16 Jul 2021 09:52:50 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     vgoyal@redhat.com
Cc:     stefanha@redhat.com, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, bo.liu@linux.alibaba.com
Subject: [PATCH] virtiofsd: support per-file DAX
Date:   Fri, 16 Jul 2021 09:52:49 +0800
Message-Id: <20210716015249.86064-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <YPDhv0JJHqbMCyXD@redhat.com>
References: <YPDhv0JJHqbMCyXD@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

An example implementation of supporting per-file DAX flag for virtiofsd,
where DAx is enabled for files larger than 1M size.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 contrib/virtiofsd/fuse_kernel.h   | 4 +++-
 contrib/virtiofsd/fuse_lowlevel.c | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/contrib/virtiofsd/fuse_kernel.h b/contrib/virtiofsd/fuse_kernel.h
index d2b7ccf96b..9c476b7021 100644
--- a/contrib/virtiofsd/fuse_kernel.h
+++ b/contrib/virtiofsd/fuse_kernel.h
@@ -165,6 +165,8 @@
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
 
+#define FUSE_ATTR_DAX  (1 << 1)
+
 /* Make sure all structures are padded to 64bit boundary, so 32bit
    userspace works under 64bit kernels */
 
@@ -184,7 +186,7 @@ struct fuse_attr {
 	uint32_t	gid;
 	uint32_t	rdev;
 	uint32_t	blksize;
-	uint32_t	padding;
+	uint32_t	flags;
 };
 
 struct fuse_kstatfs {
diff --git a/contrib/virtiofsd/fuse_lowlevel.c b/contrib/virtiofsd/fuse_lowlevel.c
index 046a1b4a02..d8a3873246 100644
--- a/contrib/virtiofsd/fuse_lowlevel.c
+++ b/contrib/virtiofsd/fuse_lowlevel.c
@@ -60,6 +60,9 @@ static void convert_stat(const struct stat *stbuf, struct fuse_attr *attr)
 	attr->atimensec = ST_ATIM_NSEC(stbuf);
 	attr->mtimensec = ST_MTIM_NSEC(stbuf);
 	attr->ctimensec = ST_CTIM_NSEC(stbuf);
+
+	if (stbuf->st_size >= 1048576)
+		attr->flags |= FUSE_ATTR_DAX;
 }
 
 static void convert_attr(const struct fuse_setattr_in *attr, struct stat *stbuf)
-- 
2.27.0

