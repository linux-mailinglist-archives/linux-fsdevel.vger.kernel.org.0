Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8FF13084BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jan 2021 05:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbhA2EyI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 23:54:08 -0500
Received: from mail.synology.com ([211.23.38.101]:44922 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231967AbhA2EyH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 23:54:07 -0500
Received: from localhost.localdomain (unknown [10.17.36.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id 1D884CE781E9;
        Fri, 29 Jan 2021 12:53:25 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1611896005; bh=4kMZ5zHLO27hnJMdGRSP6MiFaltvcjzGh8J9HyAvWxQ=;
        h=From:To:Cc:Subject:Date;
        b=ZiPKK1kzcOBvIRAfUPUu1IkVUx2vsk2pygJ17GkVbO/FQ0hzlPJ9sUDOYzx3gYuiR
         BYuMKf6uM0wvml0+siiXnhorscO3pJcmrQvjsEEpLR5EFWv+4bsFAsLi/7MlNw9FRn
         sZEKB1Zpz+Dad4BzPwdeKAZV0KQEOHFw/d7Ku9wg=
From:   bingjingc <bingjingc@synology.com>
To:     viro@zeniv.linux.org.uk, jack@suse.com, jack@suse.cz,
        axboe@kernel.dk, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, cccheng@synology.com,
        bingjingc@synology.com, robbieko@synology.com, willy@infradead.org,
        rdunlap@infradead.org, miklos@szeredi.hu
Subject: [PATCH v3 2/3] isofs: handle large user and group ID
Date:   Fri, 29 Jan 2021 12:53:15 +0800
Message-Id: <20210129045315.10375-1-bingjingc@synology.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

