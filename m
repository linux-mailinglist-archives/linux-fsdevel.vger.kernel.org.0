Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18567554674
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 14:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355872AbiFVIxq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 04:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355561AbiFVIx1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:53:27 -0400
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7985C31340;
        Wed, 22 Jun 2022 01:53:27 -0700 (PDT)
Received: by mail-pj1-f66.google.com with SMTP id go6so10592760pjb.0;
        Wed, 22 Jun 2022 01:53:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2r2ZFcponVjH8EtFELgTwaVJcACpqBslCVvaRP6ArR8=;
        b=c0buO3tXw2JqV+1jcfSMpcVFhozul/2CDEilKuO7vk+H4SENOSVqx7x3MQwBh1sYig
         ayNyzbENvoO4sQVr6OXr5ia+KVR940+Rn7kGwjoRbsFvVhTocML/lNqoe80bkwacipOw
         moT47KUKPSkajxdGJQSAi+PMN8g3HA4YLwHnQwnC2KH+ADut4qr1gk2yDTtDUOKmguVU
         V4BMFyiVPBoZTJF1S+DzXtb/hMWWLiZsr/JUjmPzIyA8dEY/x1Ow/fSayWJkbROLLZjt
         sEyF4+ER4FiKU1wN2b35BE+EPiiq/NcFWpZObmLcIrgAs+7GhYWdGNNfFdvIEPl2SKLC
         DzXw==
X-Gm-Message-State: AJIora9TGAno3UaEn9riyNo7+7hGLrS1Ag22g7ZlC3rnfl5LdVy4Zyk5
        MaXwS5ZoWPDRcMHGoVdaqim68FrNjsGDcnI=
X-Google-Smtp-Source: AGRyM1sAtgNHod1ODfWmeutcYo0td+h6hnidzgu+xq3pV8y4rST6tRmK0NBoNbncbyu7lFc4Q8U0dw==
X-Received: by 2002:a17:902:d542:b0:16a:5016:7a18 with SMTP id z2-20020a170902d54200b0016a50167a18mr389410plf.94.1655888007025;
        Wed, 22 Jun 2022 01:53:27 -0700 (PDT)
Received: from localhost.localdomain ([156.146.53.107])
        by smtp.gmail.com with ESMTPSA id p6-20020a62d006000000b0051b9a2d639dsm3464820pfg.43.2022.06.22.01.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 01:53:26 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sunliming@kylinos.cn, kelulanainsley@gmail.com
Subject: [PATCH] walk_component(): get inode in lookup_slow branch statement block
Date:   Wed, 22 Jun 2022 16:53:17 +0800
Message-Id: <20220622085317.444720-1-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The inode variable is used as a parameter by the step_into function,
but is not assigned a value in the sub-lookup_slow branch path. So
get the inode in the sub-lookup_slow branch path.

Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 fs/namei.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index 1f28d3f463c3..a1a3e9514f46 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2014,6 +2014,8 @@ static const char *walk_component(struct nameidata *nd, int flags)
 		dentry = lookup_slow(&nd->last, nd->path.dentry, nd->flags);
 		if (IS_ERR(dentry))
 			return ERR_CAST(dentry);
+
+		inode = d_backing_inode(dentry);
 	}
 	if (!(flags & WALK_MORE) && nd->depth)
 		put_link(nd);
-- 
2.25.1

