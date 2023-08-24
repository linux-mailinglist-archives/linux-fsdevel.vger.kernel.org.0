Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B7B786602
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 05:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239705AbjHXDo7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 23:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239687AbjHXDon (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 23:44:43 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7AD10F1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:44:41 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a8586813cfso655321b6e.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692848681; x=1693453481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lY6Vi/2E/8aKoDMoFhdgeDuzJGEBhcHcwJKxLN5aRm4=;
        b=gHtaEy0lF74Ntkso7g4C6I/YE4P2dpDs+7amPy7WakPzh2kjSvMiiaFri5oP5OIPtC
         BfsgxJG3dolAaeJ2n+Yhq2chgoukBpNASEoJSTjbYwJljlwjXrNh9kx520+RsCMTFI9a
         cZRaUUBTw/fsxlcCpVpRSbHKngHy3yg6ERr+RLU72xkk0Hn+mGlF4r5SkkNhy/H1qmC/
         4YbOWxnFhSSxA3RyOpAdhS6L/9ifNoZvavLY3HZvYg4yrEZzgzD6jn7exa/rpKElUHVR
         rTIHwS9nbuifcIi3X9sduJyAWlvrWQdqWxFvFKFyC4rdXuEY8eTaAP0iyvcMIEJFSAPS
         QpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692848681; x=1693453481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lY6Vi/2E/8aKoDMoFhdgeDuzJGEBhcHcwJKxLN5aRm4=;
        b=U0GK9q8rO2U8fUQwc5Ljnu3fSboteqjAesprTIQqykoGyi0Ubg62ZNdPOs82X63Ftv
         AP6Ck9StBiVjNCc4DyXrY6BjllwIakZA3Zxvl6Gemz0q3QErXvHqL4ca+gnoryIsTgP5
         Hs8e+Y98ohynSTFyher7aqy6yNr3eBShi9QNJVJH7CvQ5DSIm/kBzSkLBwhZCjs061kQ
         BxQ9Q7EBivQ/mwtGQPAp4s+RZZZHnQKy/13Cw14VSDYqLsDqlKCGrNLaZUaCLNByyOVU
         DE11k6Cu/c8SrAGBbhaHXchydQAn8B0sJry+CQwnK0OnRRLvsKUUokfU33OrUhoHSCXy
         of3w==
X-Gm-Message-State: AOJu0YwWraSh1olox1dIc8ZLRPrl67amqUBTj4T29DFP6GL0XMEoxLBX
        uyC0T9ClbaL+Fh/nVJXr5ieJzA==
X-Google-Smtp-Source: AGHT+IGSn8aXVXktFOZZa/BcVGbtb8f6zEZDLrwOYj68DXtiQe8FLStK6m/pgQCqQbi7Z2XDHrDQOQ==
X-Received: by 2002:a05:6808:30a7:b0:3a7:2eb4:ce04 with SMTP id bl39-20020a05680830a700b003a72eb4ce04mr17475307oib.5.1692848680931;
        Wed, 23 Aug 2023 20:44:40 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id t6-20020a63b246000000b005579f12a238sm10533157pgo.86.2023.08.23.20.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 20:44:40 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Subject: [PATCH v5 06/45] erofs: dynamically allocate the erofs-shrinker
Date:   Thu, 24 Aug 2023 11:42:25 +0800
Message-Id: <20230824034304.37411-7-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
References: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use new APIs to dynamically allocate the erofs-shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
CC: Gao Xiang <xiang@kernel.org>
CC: Chao Yu <chao@kernel.org>
CC: Yue Hu <huyue2@coolpad.com>
CC: Jeffle Xu <jefflexu@linux.alibaba.com>
CC: linux-erofs@lists.ozlabs.org
---
 fs/erofs/utils.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
index cc6fb9e98899..6e1a828e6ca3 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -270,19 +270,25 @@ static unsigned long erofs_shrink_scan(struct shrinker *shrink,
 	return freed;
 }
 
-static struct shrinker erofs_shrinker_info = {
-	.scan_objects = erofs_shrink_scan,
-	.count_objects = erofs_shrink_count,
-	.seeks = DEFAULT_SEEKS,
-};
+static struct shrinker *erofs_shrinker_info;
 
 int __init erofs_init_shrinker(void)
 {
-	return register_shrinker(&erofs_shrinker_info, "erofs-shrinker");
+	erofs_shrinker_info = shrinker_alloc(0, "erofs-shrinker");
+	if (!erofs_shrinker_info)
+		return -ENOMEM;
+
+	erofs_shrinker_info->count_objects = erofs_shrink_count;
+	erofs_shrinker_info->scan_objects = erofs_shrink_scan;
+	erofs_shrinker_info->seeks = DEFAULT_SEEKS;
+
+	shrinker_register(erofs_shrinker_info);
+
+	return 0;
 }
 
 void erofs_exit_shrinker(void)
 {
-	unregister_shrinker(&erofs_shrinker_info);
+	shrinker_free(erofs_shrinker_info);
 }
 #endif	/* !CONFIG_EROFS_FS_ZIP */
-- 
2.30.2

