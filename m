Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99256055C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Oct 2022 05:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbiJTDJ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Oct 2022 23:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiJTDJ1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Oct 2022 23:09:27 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6F410E4;
        Wed, 19 Oct 2022 20:09:22 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id fw14so18576671pjb.3;
        Wed, 19 Oct 2022 20:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fI84mLWVngwKUi26D1TkjXUQLixkWYJFgxEZz3tPHX8=;
        b=mXoImnuBwYTrzEXpbrq9iPF+KlNKvbh+pkRzZISj+9gL/lA3wkzX/TN48tYGZreI12
         6HbT0IR17kV2/c8EMX1db2aRPhEkXwT6i52Zqo3KpeCdEDW+VAYEwiD72g+eUFSDsrHF
         75tPWuhWAw2wktcBcAlqT8QJp9nsMA7pgoiHqsPlzQPRjh3ZHAg780LU4JdD3b/01z6A
         S/M9jXDgByGQNis6Vnx2FvDbPWKGv00FZaNuArl1Qj/zCmFpzgIdVAR/zKfba9RZ+cny
         4sdJyla5p1Amx/1POa2kyR4H788vFkGhK+Pk3ISpNJ/yuOOR7JUDzJ1gqzwKu0l8+0Dc
         al8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fI84mLWVngwKUi26D1TkjXUQLixkWYJFgxEZz3tPHX8=;
        b=vYJnpQGFvWbnwZJWJMfgVYcETzqNKizpwMTjSyNIHOHGvkk3Y8jpDt5QImMj/w7AwX
         8hWLvOGiBVo+yhtwA5uNgXi/xKw9bmlNtnCFE1xNG5blLSy38EUdo9ff/JxIepRagI4W
         5pm/GKX5xorZC1WqJuJZKQ29vAtGCnVKCEFYpj6tkSIZDF73EevhAZwzU/TeLWzKz9ik
         agJ8hkmYSbByGkYDXxeXACHi0sBJS7+t69dFXsIkFRnXwwDorAwcAJPcIxGwZ/56XZvK
         lYFaMf4CZXZUdNcZ+sxtZkHvhyhSWmr0wKqkSQWmqjaQucMno/sl77L9CLWMs726mzAC
         5A5Q==
X-Gm-Message-State: ACrzQf3qOH4G3SRN54YR+yrA0YS+qD5x5Wq0pIHBkQM3hTNYwNSOX5iO
        +qT5oBM83jinZV3Z/K+MauI=
X-Google-Smtp-Source: AMsMyM6tlFWl0ZtIUfK+us5mHYCufSSy40VmICgkov+tBCjlzeM/yx0MJBIUdq7/qLO+A8tihwSwzQ==
X-Received: by 2002:a17:90b:3c51:b0:20c:2630:5259 with SMTP id pm17-20020a17090b3c5100b0020c26305259mr48319115pjb.177.1666235361609;
        Wed, 19 Oct 2022 20:09:21 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id b2-20020a170902d50200b00177324a7862sm718541plg.45.2022.10.19.20.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 20:09:19 -0700 (PDT)
From:   cuijinpeng666@gmail.com
X-Google-Original-From: cui.jinpeng2@zte.com.cn
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jinpeng Cui <cui.jinpeng2@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] fs/super.c: use strscpy() is more robust and safer
Date:   Thu, 20 Oct 2022 03:09:15 +0000
Message-Id: <20221020030915.393801-1-cui.jinpeng2@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>

The implementation of strscpy() is more robust and safer.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
---
 fs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 8d39e4f11cfa..ca791da59c98 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -574,7 +574,7 @@ struct super_block *sget_fc(struct fs_context *fc,
 	fc->s_fs_info = NULL;
 	s->s_type = fc->fs_type;
 	s->s_iflags |= fc->s_iflags;
-	strlcpy(s->s_id, s->s_type->name, sizeof(s->s_id));
+	strscpy(s->s_id, s->s_type->name, sizeof(s->s_id));
 	list_add_tail(&s->s_list, &super_blocks);
 	hlist_add_head(&s->s_instances, &s->s_type->fs_supers);
 	spin_unlock(&sb_lock);
@@ -653,7 +653,7 @@ struct super_block *sget(struct file_system_type *type,
 		return ERR_PTR(err);
 	}
 	s->s_type = type;
-	strlcpy(s->s_id, type->name, sizeof(s->s_id));
+	strscpy(s->s_id, type->name, sizeof(s->s_id));
 	list_add_tail(&s->s_list, &super_blocks);
 	hlist_add_head(&s->s_instances, &type->fs_supers);
 	spin_unlock(&sb_lock);
-- 
2.25.1

