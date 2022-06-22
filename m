Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5CD5546BF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 14:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355460AbiFVIv4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 04:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348196AbiFVIvz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:51:55 -0400
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0254F393EC;
        Wed, 22 Jun 2022 01:51:55 -0700 (PDT)
Received: by mail-pg1-f195.google.com with SMTP id l4so15493622pgh.13;
        Wed, 22 Jun 2022 01:51:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2r2ZFcponVjH8EtFELgTwaVJcACpqBslCVvaRP6ArR8=;
        b=F+G0dbJ4luLldMZ3Fx1J44PKquRoH/S/MQ5dcBY1wueT+2ihRjGLm8r54lXnof/Nyx
         6tJSkO08q96coGQxsQDtd5ZFX+cL33LUrTMFbqodDR2dzn5QpR+VU7c43SbRUHKGue93
         HarBcUPyZ5vqfFSgBXq/fItMcVp4IJpEMfk4/zpZpJM0/xAIKIkHlF1YAZm+ifbV7M9O
         axh/b/fZEDy0gYt44acdZQimrJOcPOl2xtzD54CoEtdyovowK391RTPjGHLuL6G+cxaj
         Cej5H/gCc8VmDB9O7ZJWdj9XZVIchHH2j8Vz9TpJQ5S3yy/RVnhmImHYte14lUeuANeQ
         MFeQ==
X-Gm-Message-State: AJIora/VwAZJKssDePIszblydEhsgvyQyRSHNjwGDEo3r9elQcu6f1FW
        oPAaGUtIrOPEkevnPMlw7A==
X-Google-Smtp-Source: AGRyM1vcGO7Nd9ID30vVjt7tcTVKOCn34TCI2kKGbaDAlTiQFevnbJF6F1HPZcF7YsCsNFPM9VWxfg==
X-Received: by 2002:a63:158:0:b0:40c:f753:d227 with SMTP id 85-20020a630158000000b0040cf753d227mr2054462pgb.550.1655887914573;
        Wed, 22 Jun 2022 01:51:54 -0700 (PDT)
Received: from localhost.localdomain ([156.146.53.107])
        by smtp.gmail.com with ESMTPSA id c3-20020a17090a8d0300b001ec84049064sm8176780pjo.41.2022.06.22.01.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 01:51:54 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sunliming@kylino.cn, kelulanainsley@gmail.com,
        sunliming <sunliming@kylinos.cn>
Subject: [PATCH] walk_component(): get inode in lookup_slow branch statement block
Date:   Wed, 22 Jun 2022 16:51:46 +0800
Message-Id: <20220622085146.444516-1-sunliming@kylinos.cn>
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

