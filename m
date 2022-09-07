Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9755AF9F5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Sep 2022 04:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiIGChl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Sep 2022 22:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiIGChj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Sep 2022 22:37:39 -0400
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA1394EEC;
        Tue,  6 Sep 2022 19:37:38 -0700 (PDT)
Received: from ([60.208.111.195])
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id BBS00135;
        Wed, 07 Sep 2022 10:37:35 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201604.home.langchao.com (10.100.2.4) with Microsoft SMTP Server id
 15.1.2507.12; Wed, 7 Sep 2022 10:37:34 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bo Liu <liubo03@inspur.com>
Subject: [PATCH] eventfd: check ida_simple_get() return value
Date:   Tue, 6 Sep 2022 22:37:32 -0400
Message-ID: <20220907023732.2394-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
tUid:   2022907103735a539d6fdd942df50d7dbbb9c15ae5d65
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As ida_simple_get() can fail, we should check the return value.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 fs/eventfd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index c0ffee99ad23..fde730492993 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -428,6 +428,8 @@ static int do_eventfd(unsigned int count, int flags)
 	ctx->count = count;
 	ctx->flags = flags;
 	ctx->id = ida_simple_get(&eventfd_ida, 0, 0, GFP_KERNEL);
+	if (ctx->id < 0)
+		goto err;
 
 	flags &= EFD_SHARED_FCNTL_FLAGS;
 	flags |= O_RDWR;
-- 
2.27.0

