Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17868306B04
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 03:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhA1CUr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 21:20:47 -0500
Received: from mail.synology.com ([211.23.38.101]:50398 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231173AbhA1CUY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 21:20:24 -0500
Received: from localhost.localdomain (unknown [10.17.32.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id 2073FCE781E9;
        Thu, 28 Jan 2021 10:19:42 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1611800382; bh=NSxonVFVqna1DVcV3wqoEdl1NpU+injU1V92s7H48F4=;
        h=From:To:Cc:Subject:Date;
        b=Kd2tGdviUWjq348qQpajRc80LAsJo7/2Bb8Ylyjm/UQKlDRwjdv7QXjLHJzzls9NA
         N8Lkr5b7seHh4SXI4ZhNjTdfQRfHQcUBMnLnc938OYNc6m4Nqxq/eWlUrhMOghljon
         V2p1NTVTF0vWI5uDUpEegh8nyNu7FaGN4TyDd6eY=
From:   bingjingc <bingjingc@synology.com>
To:     viro@zeniv.linux.org.uk, jack@suse.com, jack@suse.cz,
        axboe@kernel.dk, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, cccheng@synology.com,
        bingjingc@synology.com, robbieko@synology.com
Subject: [PATCH 2/3] udf: handle large user and group ID
Date:   Thu, 28 Jan 2021 10:19:32 +0800
Message-Id: <1611800372-9688-1-git-send-email-bingjingc@synology.com>
X-Mailer: git-send-email 2.7.4
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: BingJing Chang <bingjingc@synology.com>

If uid or gid of mount options is larger than INT_MAX, udf_fill_super will
return -EINVAL.

The problem can be encountered by a domain user or reproduced via:
mount -o loop,uid=2147483648 something-in-udf-format.iso /mnt

This can be fixed as commit 233a01fa9c4c ("fuse: handle large user and
group ID").

Reviewed-by: Robbie Ko <robbieko@synology.com>
Reviewed-by: Chung-Chiang Cheng <cccheng@synology.com>
Signed-off-by: BingJing Chang <bingjingc@synology.com>
---
 fs/udf/super.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index d0df217..efeac8c 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -454,11 +454,24 @@ static const match_table_t tokens = {
 	{Opt_err,	NULL}
 };
 
+static int udf_match_uint(substring_t *s, unsigned int *res)
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
 static int udf_parse_options(char *options, struct udf_options *uopt,
 			     bool remount)
 {
 	char *p;
 	int option;
+	unsigned int uv;
 
 	uopt->novrs = 0;
 	uopt->session = 0xFFFFFFFF;
@@ -508,17 +521,17 @@ static int udf_parse_options(char *options, struct udf_options *uopt,
 			uopt->flags &= ~(1 << UDF_FLAG_USE_SHORT_AD);
 			break;
 		case Opt_gid:
-			if (match_int(args, &option))
+			if (udf_match_uint(args, &uv))
 				return 0;
-			uopt->gid = make_kgid(current_user_ns(), option);
+			uopt->gid = make_kgid(current_user_ns(), uv);
 			if (!gid_valid(uopt->gid))
 				return 0;
 			uopt->flags |= (1 << UDF_FLAG_GID_SET);
 			break;
 		case Opt_uid:
-			if (match_int(args, &option))
+			if (udf_match_uint(args, &uv))
 				return 0;
-			uopt->uid = make_kuid(current_user_ns(), option);
+			uopt->uid = make_kuid(current_user_ns(), uv);
 			if (!uid_valid(uopt->uid))
 				return 0;
 			uopt->flags |= (1 << UDF_FLAG_UID_SET);
-- 
2.7.4

