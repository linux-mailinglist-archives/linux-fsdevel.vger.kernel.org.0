Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5B9575412
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jul 2022 19:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbiGNRdI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jul 2022 13:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiGNRdH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jul 2022 13:33:07 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D234E55097;
        Thu, 14 Jul 2022 10:33:06 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id oy13so4698563ejb.1;
        Thu, 14 Jul 2022 10:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wl4sLOCF4r2ryQPKsJLAlrwRrWQnq6/0JlGSvQNEWKo=;
        b=TRPa1OlsYyCUZtSFg9cBU6tOHcsv8iEC/lby3fn89qjOU2w4LYMGsGo1b0y9nFtRLe
         TYQwjlZc4Z0/8xxqDmAkN+3jst09QapJBY1kUg45L3/uBCBJ24B99Gv+9zmmar4x+zmo
         FiNQFWLqMIhJi2j5xZXIyV3F9B7mrUWWbTitmsB90MK3CTZBNETSMkqi1BZnbFOKVhqJ
         4yyeSOTHK+AYxaIQGJiWWA6NcGBiPVrVRKQosXID8HXVrTdwG0aLxw+cAi/RvUaxsOYn
         vQ/6Z5wDSfsrkHzqBxQUbXeIV0onMU9NdNMsG2/ukBAA+9vBeHIUwpPyud9V98my9A4Q
         clyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wl4sLOCF4r2ryQPKsJLAlrwRrWQnq6/0JlGSvQNEWKo=;
        b=XJ9foouA7uh9I1K7W8NQS8gZPA/FJV9EmJZisz/HEWTaLEJ4Pbz15VaLQHjA3u7hyO
         eW0T8/KoBc6UAGg9Sfixkqo6N3/kzLZeS4nQWd3Pe+aDQU8Ng4jsq/sHlMqlx/944LSq
         k83zmYVO+b6V+wcyg2rlsK0ekyD+xeP7IWSCmVtHaPWIaGlGLxlWDW8Ly5VYFI4YCEXb
         YrbZVnWlFrGCpnf1DCCATot3m8Xo/mkkVW8FvZKqkD1FcIunM/dijg02Uo8P7jxODVGb
         4SNK9wTiTJYxqDxeD3hsyknyjrAh7hdFWL2dQ4m3HqMvND+jEWuQ3sitoU3PIhMN38eK
         Aleg==
X-Gm-Message-State: AJIora/s8kaT8u4w2oELwI40lfX/kmMS4StMNTk2F422SR0zKoq34WxV
        AI3k3aFTtdSHXMaIHVjFZcoURDZpVDQ=
X-Google-Smtp-Source: AGRyM1u8zVl5Ok/5naDIlDYM0Rjk2/BJUSfdhrkoneWxhHCTmGRDeXNU7c4ISL2tJmCu7RPN1oXChg==
X-Received: by 2002:a17:907:3f29:b0:72b:91df:2c4b with SMTP id hq41-20020a1709073f2900b0072b91df2c4bmr9803308ejc.206.1657819985210;
        Thu, 14 Jul 2022 10:33:05 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a10-20020a170906190a00b0072aa1313f5csm910875eje.201.2022.07.14.10.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 10:33:04 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] epoll: Use try_cmpxchg in list_add_tail_lockless
Date:   Thu, 14 Jul 2022 19:32:55 +0200
Message-Id: <20220714173255.12987-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old
in list_add_tail_lockless. x86 CMPXCHG instruction returns
success in ZF flag, so this change saves a compare after
cmpxchg (and related move instruction in front of cmpxchg).

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
---
 fs/eventpoll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index e2daa940ebce..6705cb965fbe 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1065,7 +1065,7 @@ static inline bool list_add_tail_lockless(struct list_head *new,
 	 * added to the list from another CPU: the winner observes
 	 * new->next == new.
 	 */
-	if (cmpxchg(&new->next, new, head) != new)
+	if (!try_cmpxchg(&new->next, &new, head))
 		return false;
 
 	/*
-- 
2.35.3

