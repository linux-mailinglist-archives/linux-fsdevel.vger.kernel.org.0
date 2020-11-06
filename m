Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE982A9FA4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 22:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbgKFVzU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 16:55:20 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59350 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbgKFVzU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:55:20 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kb9hW-00024b-OC; Fri, 06 Nov 2020 21:55:18 +0000
From:   Colin King <colin.king@canonical.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hfsplus: remove pr_err message on ENOSPC file extend error
Date:   Fri,  6 Nov 2020 21:55:18 +0000
Message-Id: <20201106215518.390664-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently ENOSPC errors that are triggered from extending a file
are spamming the kernel log with messages.  Since ENOSPC is being
returned there is enough information to userspace to inform why
the extend is failing and the error message is unnecessary and
just more logging noise.  This is particularly noticeable when
exercising a full hfs filesystem with stress-ng file stress tests.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/hfsplus/extents.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index a930ddd15681..6cc30482c82c 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -446,13 +446,9 @@ int hfsplus_file_extend(struct inode *inode, bool zeroout)
 	int res;
 
 	if (sbi->alloc_file->i_size * 8 <
-	    sbi->total_blocks - sbi->free_blocks + 8) {
+	    sbi->total_blocks - sbi->free_blocks + 8)
 		/* extend alloc file */
-		pr_err("extend alloc file! (%llu,%u,%u)\n",
-		       sbi->alloc_file->i_size * 8,
-		       sbi->total_blocks, sbi->free_blocks);
 		return -ENOSPC;
-	}
 
 	mutex_lock(&hip->extents_lock);
 	if (hip->alloc_blocks == hip->first_blocks)
-- 
2.28.0

