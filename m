Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6843A3CCC54
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 04:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbhGSClf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Jul 2021 22:41:35 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:53890 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233720AbhGSClf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Jul 2021 22:41:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UgAj7zf_1626662314;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UgAj7zf_1626662314)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 19 Jul 2021 10:38:34 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        djwong@kernel.org
Subject: [PATCH v2] vfs: only allow SETFLAGS to set DAX flag on files and dirs
Date:   Mon, 19 Jul 2021 10:38:34 +0800
Message-Id: <20210719023834.104053-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is similar to commit dbc77f31e58b ("vfs: only allow FSSETXATTR to
set DAX flag on files and dirs").

Though the underlying filesystems may have filtered invalid flags, e.g.,
ext4_mask_flags() called in ext4_fileattr_set(), also check it in VFS
layer.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
changes since v1:
- add separate parentheses surrounding flag tests
---
 fs/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 1e2204fa9963..90cfaa4db03a 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -835,7 +835,7 @@ static int fileattr_set_prepare(struct inode *inode,
 	 * It is only valid to set the DAX flag on regular files and
 	 * directories on filesystems.
 	 */
-	if ((fa->fsx_xflags & FS_XFLAG_DAX) &&
+	if (((fa->fsx_xflags & FS_XFLAG_DAX) || (fa->flags & FS_DAX_FL)) &&
 	    !(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode)))
 		return -EINVAL;
 
-- 
2.27.0

