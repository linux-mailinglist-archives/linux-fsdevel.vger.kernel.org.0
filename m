Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2957FEE9B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2019 16:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730277AbfKPPwt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Nov 2019 10:52:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:33570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728671AbfKPPws (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:52:48 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E4CA20859;
        Sat, 16 Nov 2019 15:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919567;
        bh=4s8e4vFMSbvxkOqzZBgfRHrA0gBMSbB8WI/S0IuJjVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IbexRtYucwBVF0jz/2nLGvoWrQvCeHVpTXgRFeo+UNSS+w5nQggyYuThGK8aqWstv
         YV2S4oh8jjUUZoq7PQO6wTHkFBYWHBA6viXp5jwsC9FVH+TbQcfx0fm1mE+m2NuUCK
         1IAA//sUgL/bjD3rf3Xolo00g9jI7mNGqgWl3W8s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Ernesto=20A=2E=20Fern=C3=A1ndez?= 
        <ernesto.mnd.fernandez@gmail.com>,
        Vyacheslav Dubeyko <slava@dubeyko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 64/99] hfs: fix return value of hfs_get_block()
Date:   Sat, 16 Nov 2019 10:50:27 -0500
Message-Id: <20191116155103.10971-64-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116155103.10971-1-sashal@kernel.org>
References: <20191116155103.10971-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>

[ Upstream commit 1267a07be5ebbff2d2739290f3d043ae137c15b4 ]

Direct writes to empty inodes fail with EIO.  The generic direct-io code
is in part to blame (a patch has been submitted as "direct-io: allow
direct writes to empty inodes"), but hfs is worse affected than the other
filesystems because the fallback to buffered I/O doesn't happen.

The problem is the return value of hfs_get_block() when called with
!create.  Change it to be more consistent with the other modules.

Link: http://lkml.kernel.org/r/4538ab8c35ea37338490525f0f24cbc37227528c.1539195310.git.ernesto.mnd.fernandez@gmail.com
Signed-off-by: Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
Reviewed-by: Vyacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/hfs/extent.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/hfs/extent.c b/fs/hfs/extent.c
index 1bd1afefe2538..16819d2a978b4 100644
--- a/fs/hfs/extent.c
+++ b/fs/hfs/extent.c
@@ -345,7 +345,9 @@ int hfs_get_block(struct inode *inode, sector_t block,
 	ablock = (u32)block / HFS_SB(sb)->fs_div;
 
 	if (block >= HFS_I(inode)->fs_blocks) {
-		if (block > HFS_I(inode)->fs_blocks || !create)
+		if (!create)
+			return 0;
+		if (block > HFS_I(inode)->fs_blocks)
 			return -EIO;
 		if (ablock >= HFS_I(inode)->alloc_blocks) {
 			res = hfs_extend_file(inode);
-- 
2.20.1

