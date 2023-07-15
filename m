Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509947546F9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jul 2023 08:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjGOGDI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Jul 2023 02:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGOGDG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Jul 2023 02:03:06 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EE63A9D;
        Fri, 14 Jul 2023 23:03:05 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-55ba5fae2e6so2056098a12.0;
        Fri, 14 Jul 2023 23:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689400985; x=1691992985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=MGO1tmxvxbkBqZqs03H9wbAAe3QjFMqSXQx8bEXmnnA=;
        b=hVuxwAx2/3A9Ki6FyKxxHE8/Zwgr0GByXCcE0fptUBQfCsHXdmBj/te2motC0BxfOJ
         BhpNThbqoJD4roiYtMVZzpYbN60QuYrQGF4+QUWxN8Wuxy92wKaWxjZucrzj/Rpwcfgj
         1BZzQWQS5k/TvmLxG812NHxbYvWNp6onkqnIT3oX0YGS0Gsdi8B7xNomaP/O3BkazwuG
         aGXtQdtY2fj0NMNL2+p9n4fri0xb2QepTpq/0b9dFw5iHGy0ndffKkwIAD3831yzCWVO
         t3WMzSlCGJJUR8q6Xol3Vn9v7u8zm6aIwT6XpNJxr51dmzMy8vQ/IHUv+8emQL18Bz7P
         Hyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689400985; x=1691992985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGO1tmxvxbkBqZqs03H9wbAAe3QjFMqSXQx8bEXmnnA=;
        b=PQzPWIQkBLWAVZNRVh63z65HwYGecknZ6GbNY059ok5nYGxmVbuA7AtaHwYs09OHCL
         sPBfr3z9FwyROVCWjASSie32EX44XBZJGKr9O5bjBGDs1cgvy8Myn3fMquhYd7XP8s3I
         WQbEKjYIAwRLnD2nElUJis8kJ5DTVBNcC3taGUjrvXh1iuRoOGT34Q3B+aP4p6yM3+ZR
         rgfnwN5C4z6hmHSObX8dwDmPbbcJKSZhczQ96MJQXy/EvU4zuI1NhN9K5x772QYwig+B
         f46LSkyU9Q98LXXQlXcrwH7LEdZMfnyICx/BrVq/cOmOzreE4+GiMEuw90oo13MqfgPg
         gzsQ==
X-Gm-Message-State: ABy/qLb03y0p5HOLdgShoC4HohPM6HLflxLadFb01Er6Bsm4FsLYWiio
        gqcoHptiBLIZ9QjZbF+5BXA=
X-Google-Smtp-Source: APBJJlEX6XFB2ZvLtsgpNOQ+xm54ReQg+xNiD68mkbhyjdUgwC21WOq0DEyAxEKXQnGbCcg7j/CXEA==
X-Received: by 2002:a17:90a:4f81:b0:263:25f9:6603 with SMTP id q1-20020a17090a4f8100b0026325f96603mr5995670pjh.13.1689400984734;
        Fri, 14 Jul 2023 23:03:04 -0700 (PDT)
Received: from sandbox.. ([115.178.65.130])
        by smtp.googlemail.com with ESMTPSA id ez4-20020a17090ae14400b00264044cca0fsm4669121pjb.1.2023.07.14.23.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 23:03:04 -0700 (PDT)
Sender: Leesoo Ahn <yisooan.dev@gmail.com>
From:   Leesoo Ahn <lsahn@ooseel.net>
X-Google-Original-From: Leesoo Ahn <lsahn@wewakecorp.com>
To:     lsahn@wewakecorp.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs: inode: return proper errno on bmap()
Date:   Sat, 15 Jul 2023 15:02:17 +0900
Message-Id: <20230715060217.1469690-1-lsahn@wewakecorp.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It better returns -EOPNOTSUPP instead of -EINVAL which has meaning of
the argument is an inappropriate value. It doesn't make sense in the
case of that a file system doesn't support bmap operation.

-EINVAL could make confusion in the userspace perspective.

Signed-off-by: Leesoo Ahn <lsahn@wewakecorp.com>
---
 fs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index 8fefb69e1f84..c13cac26f08d 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1837,7 +1837,7 @@ EXPORT_SYMBOL(iput);
 int bmap(struct inode *inode, sector_t *block)
 {
 	if (!inode->i_mapping->a_ops->bmap)
-		return -EINVAL;
+		return -EOPNOTSUPP;
 
 	*block = inode->i_mapping->a_ops->bmap(inode->i_mapping, *block);
 	return 0;
-- 
2.34.1

