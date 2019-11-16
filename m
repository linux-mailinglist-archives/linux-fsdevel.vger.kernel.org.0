Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81D30FF0F8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2019 17:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbfKPPt5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Nov 2019 10:49:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:57602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729351AbfKPPtz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:49:55 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67FAF20855;
        Sat, 16 Nov 2019 15:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919394;
        bh=UuqkYwaEdKSFRzNCtzmdbILIkT501RlWETeJr5f1rEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tVtrZIUQpQWBm3ykj9M+/1W0gkczQ0z9vrhI3JRG8PbJkt4a3eVESesiWtqsKtMLe
         +lZR5jqBG4Lh+sLFEdueV3XvR9fBjvdh9w0h9Aw1Um3OhFukziKj8A4UEpYDSJ3n7g
         nGBLfIvaFKoTrOx3/Mj5UdefCP+xVTPwY61qkXKw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Ernesto=20A=2E=20Fern=C3=A1ndez?= 
        <ernesto.mnd.fernandez@gmail.com>,
        Vyacheslav Dubeyko <slava@dubeyko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 099/150] hfsplus: fix return value of hfsplus_get_block()
Date:   Sat, 16 Nov 2019 10:46:37 -0500
Message-Id: <20191116154729.9573-99-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154729.9573-1-sashal@kernel.org>
References: <20191116154729.9573-1-sashal@kernel.org>
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

[ Upstream commit 839c3a6a5e1fbc8542d581911b35b2cb5cd29304 ]

Direct writes to empty inodes fail with EIO.  The generic direct-io code
is in part to blame (a patch has been submitted as "direct-io: allow
direct writes to empty inodes"), but hfsplus is worse affected than the
other filesystems because the fallback to buffered I/O doesn't happen.

The problem is the return value of hfsplus_get_block() when called with
!create.  Change it to be more consistent with the other modules.

Link: http://lkml.kernel.org/r/2cd1301404ec7cf1e39c8f11a01a4302f1460ad6.1539195310.git.ernesto.mnd.fernandez@gmail.com
Signed-off-by: Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
Reviewed-by: Vyacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/hfsplus/extents.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index 284d7fb73e863..58f296bfd4380 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -237,7 +237,9 @@ int hfsplus_get_block(struct inode *inode, sector_t iblock,
 	ablock = iblock >> sbi->fs_shift;
 
 	if (iblock >= hip->fs_blocks) {
-		if (iblock > hip->fs_blocks || !create)
+		if (!create)
+			return 0;
+		if (iblock > hip->fs_blocks)
 			return -EIO;
 		if (ablock >= hip->alloc_blocks) {
 			res = hfsplus_file_extend(inode, false);
-- 
2.20.1

