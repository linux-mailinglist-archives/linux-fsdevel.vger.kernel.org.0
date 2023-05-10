Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CDB6FE70E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 May 2023 00:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbjEJWM2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 May 2023 18:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236208AbjEJWM0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 May 2023 18:12:26 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69DF7AB0;
        Wed, 10 May 2023 15:11:44 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-33131d7a26eso54973885ab.0;
        Wed, 10 May 2023 15:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683756703; x=1686348703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0eBhWhdJvdbtP/cnVajG86saO4yJvG+Hc382nRSfhlk=;
        b=E6lG0OwFWDZ3U5f5gxctcCZMhZvskxVFapXQloPJidJO5OXcaTafBoprkIJmKztiGd
         lYHNFouCAzYFQ4aKNZAL+n2h96PR4yVksN8hS3qehBXukLl48zGkmjEw3lms3wc6Gder
         EFATSGHOZ8gTI+omzuPAVGZDAuX3wb+kaeU2JCddTcBGe4ieMQk1PAu9vlH9i9uF5vJl
         Nc34xtYtaT1OqNvtTuw5bzXsY8fX7HYMAhAGVeTOJz20nm+7rvlMPT/sQ5PC3T+9TkrK
         GcRANDErjMl4tN6OfXtvFBqHhGAPn0KuOQ6EVvt3K1ei+e7v68cRfxzQ9CAwfC+WUJRN
         LwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683756703; x=1686348703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0eBhWhdJvdbtP/cnVajG86saO4yJvG+Hc382nRSfhlk=;
        b=MVzFrTa7dhBH4XRvenhMdSyvivYbbwWj9hRxVayKbA37X9knCXHYOHJIoA6ZxWgSYA
         3Wj6KoFZoLTESXseHWAAy8T+se2iai8tVie2alhJmCIV7m08tJ+oURECZEKFXhTFL/lJ
         RMxq+6dGDuj5/Etsy8ubiay1/5ZERxJper/n6xb2DbiUjE5ZjctZ6rLAlKQhvqUv3Xmt
         Hhn+kihCx95p9BkhJSepkpkEuf3ynfSG6OqCaMeJiQ48dfZ8iLghZ2bdASjyXguNw3s+
         GU6HNB8NpuncGCzGQpQAWEEarvIaMsI+3zg4yfj1Fk6T7Yzq5ivcbieO4XyrK8wgIf8b
         lhmw==
X-Gm-Message-State: AC+VfDzNqm3BkIOrYLs85wQu0n/wf7tOnsAqoRNWu176zjdE3ABiy4zu
        kX6YGo0Aih71Zi4gQHPliC0=
X-Google-Smtp-Source: ACHHUZ6dy/sktjvNLR2RqHL7AB5LFLvOZuXHCXS1SnsViBu1Kh6VwYfbpECS2u25e1DewEbHqJsApg==
X-Received: by 2002:a92:609:0:b0:328:8770:b9c2 with SMTP id x9-20020a920609000000b003288770b9c2mr13419316ilg.14.1683756703349;
        Wed, 10 May 2023 15:11:43 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id b16-20020a92c850000000b0032e28db67dcsm3479124ilq.84.2023.05.10.15.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 15:11:42 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] vfs: Replace all non-returning strlcpy with strscpy
Date:   Wed, 10 May 2023 22:11:19 +0000
Message-ID: <20230510221119.3508930-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().
No return values were used, so direct replacement is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 fs/char_dev.c |    2 +-
 fs/super.c    |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/char_dev.c b/fs/char_dev.c
index 13deb45f1ec6..950b6919fb87 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -150,7 +150,7 @@ __register_chrdev_region(unsigned int major, unsigned int baseminor,
 	cd->major = major;
 	cd->baseminor = baseminor;
 	cd->minorct = minorct;
-	strlcpy(cd->name, name, sizeof(cd->name));
+	strscpy(cd->name, name, sizeof(cd->name));
 
 	if (!prev) {
 		cd->next = curr;
diff --git a/fs/super.c b/fs/super.c
index 34afe411cf2b..8d8d68799b34 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -595,7 +595,7 @@ struct super_block *sget_fc(struct fs_context *fc,
 	fc->s_fs_info = NULL;
 	s->s_type = fc->fs_type;
 	s->s_iflags |= fc->s_iflags;
-	strlcpy(s->s_id, s->s_type->name, sizeof(s->s_id));
+	strscpy(s->s_id, s->s_type->name, sizeof(s->s_id));
 	list_add_tail(&s->s_list, &super_blocks);
 	hlist_add_head(&s->s_instances, &s->s_type->fs_supers);
 	spin_unlock(&sb_lock);
@@ -674,7 +674,7 @@ struct super_block *sget(struct file_system_type *type,
 		return ERR_PTR(err);
 	}
 	s->s_type = type;
-	strlcpy(s->s_id, type->name, sizeof(s->s_id));
+	strscpy(s->s_id, type->name, sizeof(s->s_id));
 	list_add_tail(&s->s_list, &super_blocks);
 	hlist_add_head(&s->s_instances, &type->fs_supers);
 	spin_unlock(&sb_lock);

