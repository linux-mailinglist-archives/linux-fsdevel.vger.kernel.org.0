Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE20B4EBA67
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 07:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241851AbiC3Fte (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 01:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243054AbiC3Ft3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 01:49:29 -0400
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5727C25C589;
        Tue, 29 Mar 2022 22:47:43 -0700 (PDT)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id BA5BD15F93A;
        Wed, 30 Mar 2022 14:47:42 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.16.1/8.16.1/Debian-2) with ESMTPS id 22U5lfaB147700
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 30 Mar 2022 14:47:42 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.16.1/8.16.1/Debian-2) with ESMTPS id 22U5lfg4547929
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 30 Mar 2022 14:47:41 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.16.1/8.16.1/Submit) id 22U5lfXh547928;
        Wed, 30 Mar 2022 14:47:41 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     qianfan <qianfanguijin@163.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] fat: Add ratelimit to fat*_ent_bread()
Date:   Wed, 30 Mar 2022 14:47:41 +0900
Message-ID: <87bkxogfeq.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/29.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fat*_ent_bread() can be the cause of too many report on I/O error
path. So use fat_msg_ratelimit() instead.

Reported-by: qianfan <qianfanguijin@163.com>
Tested-by: qianfan <qianfanguijin@163.com>
Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---
 fs/fat/fatent.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
index 978ac67..1db348f 100644
--- a/fs/fat/fatent.c	2022-03-28 14:34:04.582208819 +0900
+++ b/fs/fat/fatent.c	2022-03-28 14:39:26.884325073 +0900
@@ -94,7 +94,8 @@ static int fat12_ent_bread(struct super_
 err_brelse:
 	brelse(bhs[0]);
 err:
-	fat_msg(sb, KERN_ERR, "FAT read failed (blocknr %llu)", (llu)blocknr);
+	fat_msg_ratelimit(sb, KERN_ERR, "FAT read failed (blocknr %llu)",
+			  (llu)blocknr);
 	return -EIO;
 }
 
@@ -107,8 +108,8 @@ static int fat_ent_bread(struct super_bl
 	fatent->fat_inode = MSDOS_SB(sb)->fat_inode;
 	fatent->bhs[0] = sb_bread(sb, blocknr);
 	if (!fatent->bhs[0]) {
-		fat_msg(sb, KERN_ERR, "FAT read failed (blocknr %llu)",
-		       (llu)blocknr);
+		fat_msg_ratelimit(sb, KERN_ERR, "FAT read failed (blocknr %llu)",
+				  (llu)blocknr);
 		return -EIO;
 	}
 	fatent->nr_bhs = 1;
_
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
