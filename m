Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441C8307017
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbhA1Hrf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:47:35 -0500
Received: from mail.synology.com ([211.23.38.101]:54226 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231478AbhA1HOX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:14:23 -0500
Received: from localhost.localdomain (unknown [10.17.32.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id DE71ACE781E9;
        Thu, 28 Jan 2021 15:13:41 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1611818021; bh=mfQSo2y1ioyoR0zeX+3qv6/nwQu3gb5J4I0HNXMlFXw=;
        h=From:To:Cc:Subject:Date;
        b=ODsPWgo2h9ZiDzgqnz5OtUW4WigYRAx+gLHtzvjBlr7Zu3Iq8phZIZkfFCOBby6X5
         puZefx1OkbbnZQI2nUMIzs8bkbDfq4BxPOaanZtAs+DAhTEeDnIE0mG5vH2lOuyVmW
         wcp0VPuZI2jbYpyWAdHACbIVnPHIpAjqVUEHWJR0=
From:   bingjingc <bingjingc@synology.com>
To:     viro@zeniv.linux.org.uk, jack@suse.com, jack@suse.cz,
        axboe@kernel.dk, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, cccheng@synology.com,
        bingjingc@synology.com, robbieko@synology.com, willy@infradead.org,
        rdunlap@infradead.org
Subject: [PATCH v2 2/3] isofs: handle large user and group ID
Date:   Thu, 28 Jan 2021 15:13:32 +0800
Message-Id: <1611818012-2946-1-git-send-email-bingjingc@synology.com>
X-Mailer: git-send-email 2.7.4
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: BingJing Chang <bingjingc@synology.com>

If uid or gid of mount options is larger than INT_MAX, isofs_fill_super
will return -EINVAL.

The problem can be encountered by a domain user or reproduced via:
mount -o loop,uid=2147483648 ubuntu-16.04.6-server-amd64.iso /mnt

This can be fixed as commit 233a01fa9c4c ("fuse: handle large user and
group ID").

Reviewed-by: Robbie Ko <robbieko@synology.com>
Reviewed-by: Chung-Chiang Cheng <cccheng@synology.com>
Reviewed-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: BingJing Chang <bingjingc@synology.com>
---
 fs/isofs/inode.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index ec90773..21edc42 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -339,6 +339,7 @@ static int parse_options(char *options, struct iso9660_options *popt)
 {
 	char *p;
 	int option;
+	unsigned int uv;
 
 	popt->map = 'n';
 	popt->rock = 1;
@@ -434,17 +435,17 @@ static int parse_options(char *options, struct iso9660_options *popt)
 		case Opt_ignore:
 			break;
 		case Opt_uid:
-			if (match_int(&args[0], &option))
+			if (match_uint(&args[0], &uv))
 				return 0;
-			popt->uid = make_kuid(current_user_ns(), option);
+			popt->uid = make_kuid(current_user_ns(), uv);
 			if (!uid_valid(popt->uid))
 				return 0;
 			popt->uid_set = 1;
 			break;
 		case Opt_gid:
-			if (match_int(&args[0], &option))
+			if (match_uint(&args[0], &uv))
 				return 0;
-			popt->gid = make_kgid(current_user_ns(), option);
+			popt->gid = make_kgid(current_user_ns(), uv);
 			if (!gid_valid(popt->gid))
 				return 0;
 			popt->gid_set = 1;
-- 
2.7.4

