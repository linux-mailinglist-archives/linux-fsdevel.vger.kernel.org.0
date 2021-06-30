Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B4B3B851A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 16:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbhF3Ogn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 10:36:43 -0400
Received: from m15112.mail.126.com ([220.181.15.112]:50519 "EHLO
        m15112.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234882AbhF3Ogm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 10:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=yYZx7OJCN/9Q00hcQp
        F22VIKH/8bsew3VKwL0pMebUs=; b=j4HcDOFS4qudeFtIG63tbPCVso/nQ+jv0s
        jwOr+0qsLh3PgshpNUv0ULGkbcHjZyaj8AuNAaSDVAdD/EOslPd3Vpeoe0AWof5z
        nh/6hDDESwT6tq63/VPTEX+fBWupBySpwiQODe6ZYbvGvWC4F6/lt70+8yvjvFHf
        y4BAoGFaU=
Received: from 192.168.137.133 (unknown [112.10.75.196])
        by smtp2 (Coremail) with SMTP id DMmowAAnFKLdgNxg3RjqCg--.15597S3;
        Wed, 30 Jun 2021 22:34:07 +0800 (CST)
From:   Xianting Tian <xianting_tian@126.com>
To:     damien.lemoal@wdc.com, naohiro.aota@wdc.com, jth@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH] zonefs: remove redundant null bio check
Date:   Wed, 30 Jun 2021 10:33:36 -0400
Message-Id: <1625063616-8467-1-git-send-email-xianting_tian@126.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: DMmowAAnFKLdgNxg3RjqCg--.15597S3
X-Coremail-Antispam: 1Uf129KBjvdXoWruF18tw4DtFW3ury7uF43Awb_yoW3Wwc_J3
        yIqa97WrWUJrnIk3y2g3yFvryF93WY93WUWF1Fy3W3XF4Dtws5Cw1qvw1fZw15Za1SvFZ8
        Ja10grW29r40gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0wNVDUUUUU==
X-Originating-IP: [112.10.75.196]
X-CM-SenderInfo: h0ld03plqjs3xldqqiyswou0bp/1tbi5h-BpFpEBONwPgAAsr
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Xianting Tian <xianting.tian@linux.alibaba.com>

bio_alloc() with __GFP_DIRECT_RECLAIM, which is included in
GFP_NOFS, never fails, see comments in bio_alloc_bioset().

Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
---
 fs/zonefs/super.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index cd145d3..d6d08da 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -705,9 +705,6 @@ static ssize_t zonefs_file_dio_append(struct kiocb *iocb, struct iov_iter *from)
 		return 0;
 
 	bio = bio_alloc(GFP_NOFS, nr_pages);
-	if (!bio)
-		return -ENOMEM;
-
 	bio_set_dev(bio, bdev);
 	bio->bi_iter.bi_sector = zi->i_zsector;
 	bio->bi_write_hint = iocb->ki_hint;
-- 
1.8.3.1

