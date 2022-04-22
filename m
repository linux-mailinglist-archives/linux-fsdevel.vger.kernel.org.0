Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCBA50B6D1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 14:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390539AbiDVMIc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 08:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447360AbiDVMHm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:07:42 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57FA56C11
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 05:04:00 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id d6so5058422ede.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 05:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HPhKrtZiI6gpcHvMXMnoGWTD9vNJsNJnZzFe+ZBrjZ0=;
        b=kSzhX3/qy1JaXUgeY9V1/7pMz1fddjr1ebGVTAsP3wNbAyQx/011Yl/6cNrq/jKkT7
         wAK9yFhBNs4gXdLDmYFrLJBJcmyyffj80Io3GMwQyRge/5d0V6ydaKGS1RgVylXcUr0p
         vIF4cgKtYQ8BoP8+YvLHooPA01Mb7QPzQLOe9qcUzt7MdWGFZruX0Dp9ZXacz7O1/1bz
         AQYbeRNcUuOfO9BQr3SHVKqntOcwXgOi7n0aY/uQ8ZpBza3N7hDFmhH9ymEZOI6njZZN
         XI+VWRumvzYhD3Br1hNU2N2uGCC41gZyxNjXxf7F9Wi1EB7sNghq4TyE0mZMZXy4xZCM
         FBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HPhKrtZiI6gpcHvMXMnoGWTD9vNJsNJnZzFe+ZBrjZ0=;
        b=WY6+C+0tiGvxO2aoYKSuwCzwQWrHgqjtqBgWg0pwXgZKZgptUULbPRSwtuCoo8pvHf
         AjI9onJABd5ASMQaP9zWTZOvMbE8wHLEckZF2FA2Z+/+1lu6ESrLxNXIuUg45I1Pr/bq
         cYi7QXEEuJKnUYSwpy2nzR+xIzIWc9hCV8jZaBMtl+dKsPiUkDjgsgV8nl1jEaQvHh0q
         X7BhzGX5Lyst61jdpIJor/r3EehECMXFby8K2Kv2Gy0042C3XaNZ+mFmchxLzH8kzJDZ
         2ujDz2+Dn5C0YVsWIa0gSxNalR6Fi5ubXgm4LQ/hcWGu8d/NVSg9985BkO0Fzp06SbWR
         Gmwg==
X-Gm-Message-State: AOAM5317i8B1AGUsigx37KJxczrwBWccfSVD6tocgekQAoLh9HVXKIDw
        zRJbgA3MqTxNUADFHvpHK+o=
X-Google-Smtp-Source: ABdhPJz1iJq3LAjZbuKtNmdrkKu6g04YhfFlOoETmPyTjpEIgKfNENarPJp9z+ObqzZh+m10HYYNKg==
X-Received: by 2002:a05:6402:54:b0:419:9b58:e305 with SMTP id f20-20020a056402005400b004199b58e305mr4479161edu.158.1650629039367;
        Fri, 22 Apr 2022 05:03:59 -0700 (PDT)
Received: from localhost.localdomain ([5.29.13.154])
        by smtp.gmail.com with ESMTPSA id x24-20020a1709064bd800b006ef606fe5c1sm697026ejv.43.2022.04.22.05.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 05:03:58 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 16/16] fanotify: enable "evictable" inode marks
Date:   Fri, 22 Apr 2022 15:03:27 +0300
Message-Id: <20220422120327.3459282-17-amir73il@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422120327.3459282-1-amir73il@gmail.com>
References: <20220422120327.3459282-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index 228cf25e9230..edad67d674dc 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1787,7 +1787,7 @@ static int __init fanotify_user_setup(void)
 
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

