Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BED7E4196
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2019 04:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390178AbfJYCga (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 22:36:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41344 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728416AbfJYCga (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 22:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:Content-Type:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3kikTJ9SvjuYwD0CKdDNcEF71ucz9PsOK2rZyOULu/U=; b=km0f3+4tfwOBlKYVbYV5Cr800
        wt98OkAP6v/qxYrRuD6Xp5T/UMM5E+8HSgMKP+/eJXYDwGIC+vmeMF0bra7nY7tyregLmyILIpMZP
        mWkbI3/mBMivcfd6fZazljY83JzVQps46XxNdQyj5nxvDz2D2LJX0nrZgY1SNN5ArcAURVN7AZJdg
        Ceh0ItY7z8+teqBOQWeooxSlmyBEToLGkwJF1CDKvgWItzGXcayYrwJPOUH4x4tJejviShyhvl5IU
        Jlgxyl627+V6Oa19n27WeGHRoZAgCPxrJgnf6xKVpU0gaD0GhiKIgtV4V8j1ZWgwHKA8Sq8+ngAWX
        LSmCfQq1Q==;
Received: from p91006-ipngnfx01marunouchi.tokyo.ocn.ne.jp ([153.156.43.6] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNpSn-0003em-6G; Fri, 25 Oct 2019 02:36:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/4] xfs: disable xfs_ioc_space for always COW inodes
Date:   Fri, 25 Oct 2019 11:36:08 +0900
Message-Id: <20191025023609.22295-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025023609.22295-1-hch@lst.de>
References: <20191025023609.22295-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we always have to write out of place preallocating blocks is
pointless.  We already check for this in the normal falloc path, but
the check was missig in the legacy ALLOCSP path.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_ioctl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 3fe1543f9f02..552034325991 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -33,6 +33,7 @@
 #include "xfs_sb.h"
 #include "xfs_ag.h"
 #include "xfs_health.h"
+#include "xfs_reflink.h"
 
 #include <linux/mount.h>
 #include <linux/namei.h>
@@ -606,6 +607,9 @@ xfs_ioc_space(
 	if (!S_ISREG(inode->i_mode))
 		return -EINVAL;
 
+	if (xfs_is_always_cow_inode(ip))
+		return -EOPNOTSUPP;
+
 	if (filp->f_flags & O_DSYNC)
 		flags |= XFS_PREALLOC_SYNC;
 	if (filp->f_mode & FMODE_NOCMTIME)
-- 
2.20.1

