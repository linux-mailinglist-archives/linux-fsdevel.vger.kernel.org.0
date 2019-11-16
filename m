Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D09E6FF003
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2019 17:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731463AbfKPQCg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Nov 2019 11:02:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:33556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729684AbfKPPwq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:52:46 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A1A820859;
        Sat, 16 Nov 2019 15:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919565;
        bh=QTntiOm27ELfX+4pHEMJoOCTT0p1VFvY5sE0aEjOdi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fNIcLmZy1xRYHtYh6oMMEDTPAwFtUNMeFu40NhzmBZEFP0uXL4nUXEMQGE0yPpS6W
         zmSca6SXG5N248fK/8dbCs7HcdDlDj1dcW+muh7iJYAM/TvQDpSydd2Hy0ADHBZ3WS
         Oe9rIkEFP4RvG8FBpA2Xkap20FY95ZtqSEpM+wqE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Ernesto=20A=2E=20Fern=C3=A1ndez?= 
        <ernesto.mnd.fernandez@gmail.com>,
        Vyacheslav Dubeyko <slava@dubeyko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 63/99] hfsplus: fix return value of hfsplus_get_block()
Date:   Sat, 16 Nov 2019 10:50:26 -0500
Message-Id: <20191116155103.10971-63-sashal@kernel.org>
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
index ce0b8f8374081..d93c051559cb8 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -236,7 +236,9 @@ int hfsplus_get_block(struct inode *inode, sector_t iblock,
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

