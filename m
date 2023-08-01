Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B767576A68E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 03:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjHABry (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 21:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjHABrx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 21:47:53 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5F6BD;
        Mon, 31 Jul 2023 18:47:52 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VoiopYR_1690854460;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VoiopYR_1690854460)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 09:47:49 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: drop unnecessary WARN_ON() in erofs_kill_sb()
Date:   Tue,  1 Aug 2023 09:47:37 +0800
Message-Id: <20230801014737.28614-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230731-flugbereit-wohnlage-78acdf95ab7e@brauner>
References: <20230731-flugbereit-wohnlage-78acdf95ab7e@brauner>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Previously, .kill_sb() will be called only after fill_super fails.
It will be changed [1].

Besides, checking for s_magic in erofs_kill_sb() is unnecessary from
any point of view.  Let's get rid of it now.

[1] https://lore.kernel.org/r/20230731-flugbereit-wohnlage-78acdf95ab7e@brauner
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
will upstream this commit later this week after it lands -next.

 fs/erofs/super.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 9d6a3c6158bd..566f68ddfa36 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -889,8 +889,6 @@ static void erofs_kill_sb(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi;
 
-	WARN_ON(sb->s_magic != EROFS_SUPER_MAGIC);
-
 	/* pseudo mount for anon inodes */
 	if (sb->s_flags & SB_KERNMOUNT) {
 		kill_anon_super(sb);
-- 
2.24.4

