Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDDB306AFF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 03:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhA1CUH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 21:20:07 -0500
Received: from mail.synology.com ([211.23.38.101]:48752 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229578AbhA1CUF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 21:20:05 -0500
Received: from localhost.localdomain (unknown [10.17.32.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id DD728CE781CA;
        Thu, 28 Jan 2021 10:19:23 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1611800363; bh=WxOuNU7pk5AdClNDp7CD6pHne9N33altWiuk+MKNGVY=;
        h=From:To:Cc:Subject:Date;
        b=RRGwCVTb4JAxGxIYaRwftgX86SR0CP+Q3Jg476yploIobhLHcPsKpEcrBHP2Nz2Hb
         bOqMGffeQaRcu8qzlPPyK9sI8U0ew/4FffgM9gFiYLjmPe+8zOW5B1yv4yXYtlIwPp
         ql+HWpS4fIIa9zRoRYGQaVVqbHWni9xuKRGnGCsg=
From:   bingjingc <bingjingc@synology.com>
To:     viro@zeniv.linux.org.uk, jack@suse.com, jack@suse.cz,
        axboe@kernel.dk, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, cccheng@synology.com,
        bingjingc@synology.com, robbieko@synology.com
Subject: [PATCH 1/3] isofs: handle large user and group ID
Date:   Thu, 28 Jan 2021 10:19:14 +0800
Message-Id: <1611800354-9635-1-git-send-email-bingjingc@synology.com>
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
Signed-off-by: BingJing Chang <bingjingc@synology.com>
---
 fs/isofs/inode.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index ec90773..342ac19 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -335,10 +335,23 @@ static const match_table_t tokens = {
 	{Opt_err, NULL}
 };
 
+static int isofs_match_uint(substring_t *s, unsigned int *res)
+{
+	int err = -ENOMEM;
+	char *buf = match_strdup(s);
+
+	if (buf) {
+		err = kstrtouint(buf, 10, res);
+		kfree(buf);
+	}
+	return err;
+}
+
 static int parse_options(char *options, struct iso9660_options *popt)
 {
 	char *p;
 	int option;
+	unsigned int uv;
 
 	popt->map = 'n';
 	popt->rock = 1;
@@ -434,17 +447,17 @@ static int parse_options(char *options, struct iso9660_options *popt)
 		case Opt_ignore:
 			break;
 		case Opt_uid:
-			if (match_int(&args[0], &option))
+			if (isofs_match_uint(&args[0], &uv))
 				return 0;
-			popt->uid = make_kuid(current_user_ns(), option);
+			popt->uid = make_kuid(current_user_ns(), uv);
 			if (!uid_valid(popt->uid))
 				return 0;
 			popt->uid_set = 1;
 			break;
 		case Opt_gid:
-			if (match_int(&args[0], &option))
+			if (isofs_match_uint(&args[0], &uv))
 				return 0;
-			popt->gid = make_kgid(current_user_ns(), option);
+			popt->gid = make_kgid(current_user_ns(), uv);
 			if (!gid_valid(popt->gid))
 				return 0;
 			popt->gid_set = 1;
-- 
2.7.4

