Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F173E27C1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Aug 2021 11:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244689AbhHFJuu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Aug 2021 05:50:50 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:38802
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242756AbhHFJut (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Aug 2021 05:50:49 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id F089F3F07E;
        Fri,  6 Aug 2021 09:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628243429;
        bh=VRKu5JbfP8fDodfHVzLXjIhnBUVCoQ0OMMefCa+C3x4=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=HVyETiQzFXa2aEmDvSWdMZpTh9WQFZWmz35ekePUuornguyWP58VFpVuW6hn8PWaT
         S/2kjN6qY5onSpV3QlPkuNcPPsVqQxcQa+HPfuMxV3Ti6MKLEr4K+kbsSy1eiZYfzw
         YzbAcLNHfqZ+PoqaYybCPdrzEB5MgFFbydc8w9cM5oIKt5uy4IhIPgmMgYZ0wRoYCw
         LpXr+YUw+6p0c147toXmDOiV9D50cJsQRcrlDB+i0Y6e3hQLkMOLl1feXDC/xTvFt3
         TR1iv3hMc7rRxPxT1XqbsZ0rEa8Rk28lYoPW1cLEQgpfh5wMiUF+PKPflhAMeu6na0
         8fA5DJigRdbVQ==
From:   Colin King <colin.king@canonical.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] fuse: Fix uninitiailized error return in variable err
Date:   Fri,  6 Aug 2021 10:50:27 +0100
Message-Id: <20210806095027.8408-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is an error return path where err is being returned but
it not been yet set. Fix this by just returning -EINVAL.

Addresses-Coverity: ("Uninitialized scalar variable")
Fixes: ff12b2314569 ("fuse: move fget() to fuse_get_tree()")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/fuse/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 0580a8319593..09adb4f4734e 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1522,7 +1522,7 @@ static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
 	 */
 	if ((ctx->file->f_op != &fuse_dev_operations) ||
 	    (ctx->file->f_cred->user_ns != sb->s_user_ns))
-		goto err;
+		return -EINVAL;
 	ctx->fudptr = &ctx->file->private_data;
 
 	fc = kmalloc(sizeof(*fc), GFP_KERNEL);
-- 
2.31.1

