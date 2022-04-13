Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCCE4FF314
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 11:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbiDMJNO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 05:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbiDMJM2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:12:28 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0703DDD0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Apr 2022 02:10:00 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id m14so1648350wrb.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Apr 2022 02:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MXNZwzrbtI4Eu4i/LOeqiME138fc1RP1+sEhKATJ+qs=;
        b=QwIS+Wlbhs++k9RgPI8+NvYdNn3ycIgGewaNLpgvCHQJ2LnEkEtZZ6G31Nd74lSC0g
         ae8Odru0e/OoT82iFJAe4rdkZm5KLV5CB6KxNNNPZdhjwRfsQ2/H8MoNtB8r4nfWXdLg
         zZRqKxpjWM69gjCsPiS35JGL16ob3MjCaEkrjq09UFsdf4IJ9h4hX8DpEAWRP6uM+45a
         uunG0PYsSoPE3GDc2yZLEMml4BXCrTYFBaTDjFJ9qeVZCkfEHuADmXOSSd7gXqCkqxmd
         ZCiqasgpSUivTsKLsHzBDwHp5+gt+4wFmkUnnlBFfV0dK5mnWOOuRD+VH387udQP3rJU
         F3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MXNZwzrbtI4Eu4i/LOeqiME138fc1RP1+sEhKATJ+qs=;
        b=wabklOFOc/budT6StE+c++vV7uFA50O3wKidtU35hqDqCSrFx75gzX4rnNOUM2OuHj
         r0IbVi9BfxuxJxQozT9RYtwKPWPyenOFBY2sp0JBjNGKI4F4vRIr2tvSiFWvhjF9nBmT
         1ZaVl1lMknCgyQW2XVCmbyBFqr9UNfN2TK2VOmCsawKJt2KPv5FTw18TJW2aDktTul1b
         ZQ63M/Hdi3EK/KTHG3vvHNWYYOSIZbGoB1D5SBB+hiGvH/LilG95GVERIu5C52mup2AR
         7M8aON1kruQsdIygSBp0m+h6snGDKJgABichFj7oOlRHRIDBowrZ1AN8F9WI5X0lCZLC
         J+tA==
X-Gm-Message-State: AOAM5335LeuwpwPYaepLe2bFQEa2rNhy2nxuOxu2fuVhRyLV2f+KzdXu
        XKpK4zZHUfQ50L0v2x+i1eEwi3Dezkc=
X-Google-Smtp-Source: ABdhPJwtBC0nW0xb0bptjvivdsjxzVhmbvuTrektOtNSBuN6ta1sv/DFvHvScG5Mk0wfvU/9ffbB5g==
X-Received: by 2002:a05:6000:1a85:b0:205:a234:d0a5 with SMTP id f5-20020a0560001a8500b00205a234d0a5mr32554598wry.126.1649840999417;
        Wed, 13 Apr 2022 02:09:59 -0700 (PDT)
Received: from localhost.localdomain ([5.29.13.154])
        by smtp.gmail.com with ESMTPSA id bk1-20020a0560001d8100b002061d6bdfd0sm24050518wrb.63.2022.04.13.02.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 02:09:58 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 16/16] fanotify: enable "evictable" inode marks
Date:   Wed, 13 Apr 2022 12:09:35 +0300
Message-Id: <20220413090935.3127107-17-amir73il@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220413090935.3127107-1-amir73il@gmail.com>
References: <20220413090935.3127107-1-amir73il@gmail.com>
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
index fe2534043c17..87756a015be9 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1788,7 +1788,7 @@ static int __init fanotify_user_setup(void)
 
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
2.35.1

