Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A043084C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jan 2021 05:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbhA2E4A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 23:56:00 -0500
Received: from mail.synology.com ([211.23.38.101]:46528 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231919AbhA2Ez7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 23:55:59 -0500
Received: from localhost.localdomain (unknown [10.17.36.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id 466EECE781CF;
        Fri, 29 Jan 2021 12:55:17 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1611896117; bh=KR/d7f/IJiq7eFafCUwFZBsFyYlfdC/PGOHGOdEzuUM=;
        h=From:To:Cc:Subject:Date;
        b=MvgukezEm3wc6GEw9IV/Vzojnk/AFbjAMchAhV+2TLgifYWnrfkfgpSMeItOR1+Tu
         oPgGMild9oYvjwWBsO6CSnfqCI+N280mIb+gTCr0zBI7CkrQeOukdQdrjuascCLluM
         fpW+mAVOLmuDsE5wDo7GqoIB48IhAE2qSIHqRjXE=
From:   bingjingc <bingjingc@synology.com>
To:     viro@zeniv.linux.org.uk, jack@suse.com, jack@suse.cz,
        axboe@kernel.dk, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, cccheng@synology.com,
        bingjingc@synology.com, robbieko@synology.com, willy@infradead.org,
        rdunlap@infradead.org, miklos@szeredi.hu
Subject: [PATCH v3 3/3] udf: handle large user and group ID
Date:   Fri, 29 Jan 2021 12:55:02 +0800
Message-Id: <20210129045502.10546-1-bingjingc@synology.com>
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
 fs/udf/super.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index d0df217..2f83c12 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -459,6 +459,7 @@ static int udf_parse_options(char *options, struct udf_options *uopt,
 {
 	char *p;
 	int option;
+	unsigned int uv;
 
 	uopt->novrs = 0;
 	uopt->session = 0xFFFFFFFF;
@@ -508,17 +509,17 @@ static int udf_parse_options(char *options, struct udf_options *uopt,
 			uopt->flags &= ~(1 << UDF_FLAG_USE_SHORT_AD);
 			break;
 		case Opt_gid:
-			if (match_int(args, &option))
+			if (match_uint(args, &uv))
 				return 0;
-			uopt->gid = make_kgid(current_user_ns(), option);
+			uopt->gid = make_kgid(current_user_ns(), uv);
 			if (!gid_valid(uopt->gid))
 				return 0;
 			uopt->flags |= (1 << UDF_FLAG_GID_SET);
 			break;
 		case Opt_uid:
-			if (match_int(args, &option))
+			if (match_uint(args, &uv))
 				return 0;
-			uopt->uid = make_kuid(current_user_ns(), option);
+			uopt->uid = make_kuid(current_user_ns(), uv);
 			if (!uid_valid(uopt->uid))
 				return 0;
 			uopt->flags |= (1 << UDF_FLAG_UID_SET);
-- 
2.7.4

