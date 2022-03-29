Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C94E4EA8BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 09:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbiC2Hv4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 03:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbiC2Hvf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 03:51:35 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F1C1EC639
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 00:49:32 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so919109wmp.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 00:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w5A1yiZw+L1K6U44DKTZa4QH85ywxk7I8QqZCQCmDCw=;
        b=EuyZQUz0OPwl00Rjs026c/rnJJCbgvXXm5tgWTJigLdNdF9RnvhiZn7hUWGBOXIjDn
         +mdwR1fm6NLRZaVlTlOnGDwwkThqGUCBQH4GUbCUWVvpsoI3siNg4FtoVZFEL864QMYh
         5znQwwKX10Egy8GesC7sooPZgl9OwFNp0pUJGC28dogBiFPmW4rGbAE9PjuxjNpQyhZ2
         XrAktZutrLjRxDzIBi3q94qvJnXmib5BfCJwZs9+Vqk47qKjPfkvAxeI/qvEmVGY52Ex
         1+MicLMHdEBb6EkLS6oISXI1fYLnlPD0X6x4yxMqOWsxqdPCKM8IZw3AVbKgYHILBXVp
         t0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w5A1yiZw+L1K6U44DKTZa4QH85ywxk7I8QqZCQCmDCw=;
        b=pmm6qVqAGfxQ2AkOWVD5leH3H18myYIqIgHyp3Cl9WOyzN6PLGEUx+yEvl5TGB/WWn
         UhDdq0yr/2Lv4P/6AKWO6JCJDZpwoaZGrvl58gqLBCIIzlfHeASikvL1WgeDpkQ+jY2g
         70v4LbR9dorWFBpa9QaksM9qHoUO6BHU9SwxzuEnSaxjCeyIFDB2BjHx01w6Z7w8DLvl
         HUHu6FlbixII+mu9mZKUgngQNwOMLP1CEqoMDQAqXmE8R/LwzR+ZQu5VEYd+bNJU5O0f
         GMK5iJ5RhAGyXRI5qJwI7FRIM2Qt34A00mvCIDcLY9stJysBweBlMtnt/ULzh6bW3Lkf
         NMXw==
X-Gm-Message-State: AOAM531ftBEWrMMH9sSxokXQGBZfPDjXwD4QRLwKgpqhVNmTKxqCzuE4
        cQsQh+7p5CE1Iate6E/FCiw=
X-Google-Smtp-Source: ABdhPJzll6haXDFBh5oTCIeCu8E6GsqQ4NcGyCmG/6eXr27SBJMe6q8C1MQm1yXW7HquesgVpzMerA==
X-Received: by 2002:a05:600c:3586:b0:38c:a92f:1744 with SMTP id p6-20020a05600c358600b0038ca92f1744mr5030455wmq.126.1648540171370;
        Tue, 29 Mar 2022 00:49:31 -0700 (PDT)
Received: from localhost.localdomain ([77.137.71.203])
        by smtp.gmail.com with ESMTPSA id k40-20020a05600c1ca800b0038c6c8b7fa8sm1534342wms.25.2022.03.29.00.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 00:49:30 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 16/16] fanotify: enable "evictable" inode marks
Date:   Tue, 29 Mar 2022 10:49:04 +0300
Message-Id: <20220329074904.2980320-17-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220329074904.2980320-1-amir73il@gmail.com>
References: <20220329074904.2980320-1-amir73il@gmail.com>
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

Now that the direct reclaim path is handled we can enable evictable
inode marks.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify_user.c | 2 +-
 include/linux/fanotify.h           | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 5c857bfe8c3e..4ea36659addc 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1821,7 +1821,7 @@ static int __init fanotify_user_setup(void)
 
 	BUILD_BUG_ON(FANOTIFY_INIT_FLAGS & FANOTIFY_INTERNAL_GROUP_FLAGS);
 	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 12);
-	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 9);
+	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 10);
 
 	fanotify_mark_cache = KMEM_CACHE(fsnotify_mark,
 					 SLAB_PANIC|SLAB_ACCOUNT);
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 419cadcd7ff5..edc28555814c 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -66,6 +66,7 @@
 				 FAN_MARK_ONLYDIR | \
 				 FAN_MARK_IGNORED_MASK | \
 				 FAN_MARK_IGNORED_SURV_MODIFY | \
+				 FAN_MARK_EVICTABLE | \
 				 FAN_MARK_FLUSH)
 
 /*
-- 
2.25.1

