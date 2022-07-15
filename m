Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73D0575CCE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jul 2022 09:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbiGOHyg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jul 2022 03:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232471AbiGOHyf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jul 2022 03:54:35 -0400
Received: from mail-m973.mail.163.com (mail-m973.mail.163.com [123.126.97.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 37AE67D790;
        Fri, 15 Jul 2022 00:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=cwrZm
        NCSRjuzMIQT+tURFfwkYdiptMDdrXd4mko6Rok=; b=octZNLD/Y5JcfldsSN7+r
        bB85h1HyoFhWu5Z5oVLR/al1WrplJuDFxNxvpZQ3/GczPt5QYiHwsQc4UM60gdtC
        bgyk3Ib25/VbJ+QcR6q3PGITEDbHf6Tv61nWDV2lCU/Kt1J5Sc86ie0Xaj2q/N8V
        3wqN79/iKNKV84Wzc5IyaE=
Received: from localhost.localdomain (unknown [123.58.221.99])
        by smtp3 (Coremail) with SMTP id G9xpCgAn2x4JHdFiDeT0PA--.706S2;
        Fri, 15 Jul 2022 15:53:48 +0800 (CST)
From:   williamsukatube@163.com
To:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     William Dean <williamsukatube@gmail.com>,
        Hacash Robot <hacashRobot@santino.com>
Subject: [PATCH] fuse: Fix a potential memory leak for kstrdup()
Date:   Fri, 15 Jul 2022 15:53:43 +0800
Message-Id: <20220715075343.2730026-1-williamsukatube@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: G9xpCgAn2x4JHdFiDeT0PA--.706S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKry7ZrWDCFy5Kr48JFWDArb_yoWDGwb_Cr
        4fGF18uFs0vrW8Xw4DCws5tFyIgw1rGrn3Wr4xKFnxJrWjyF4avr9avr95ur4Sgr48WFZ8
        Grn8JFyfAw42qjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5Wc_DUUUUU==
X-Originating-IP: [123.58.221.99]
X-CM-SenderInfo: xzlozx5dpv3yxdwxuvi6rwjhhfrp/xtbBSQw-g1aEEKSO1wAAsG
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: William Dean <williamsukatube@gmail.com>

kfree() is missing on an error path to free the memory allocated by
kstrdup():

  sb->s_subtype = kstrdup(parent_sb->s_subtype, GFP_KERNEL);

So it is better to free it via kfree(sb->s_subtype).

Fixes: 1866d779d5d2a ("fuse: Allow fuse_fill_super_common() for submounts")
Reported-by: Hacash Robot <hacashRobot@santino.com>
Signed-off-by: William Dean <williamsukatube@gmail.com>
---
 fs/fuse/inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 8c0665c5dff8..2d10afad07f8 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1449,8 +1449,10 @@ static int fuse_fill_super_submount(struct super_block *sb,
 	get_fuse_inode(root)->nlookup--;
 	sb->s_d_op = &fuse_dentry_operations;
 	sb->s_root = d_make_root(root);
-	if (!sb->s_root)
+	if (!sb->s_root) {
+		kfree(sb->s_subtype);
 		return -ENOMEM;
+	}
 
 	return 0;
 }
-- 
2.25.1

