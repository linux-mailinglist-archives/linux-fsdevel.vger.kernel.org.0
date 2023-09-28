Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFF87B1F4A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 16:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbjI1OQD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 10:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbjI1OQD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 10:16:03 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EC119F
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 07:15:38 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-27730028198so2002041a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 07:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695910537; x=1696515337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5LDfK3iMpYFB0tVun5cTOaYgiftMpgCGCTM6bYHuB7U=;
        b=ZoPebNtnEaxtl2qK9j+WiXqi/LeBZEEy/OxDG63PZz7MXRKv1clQ+RbazC4JPDvReR
         rdeIi1Njun5LA6c0Zl5H2tuBEYqUtYU9ZF+h9StWBXcaXIk19IuOuW1uTbsU7tT3Ko7P
         GAAoEUwDqkfAr9AbRIrJfLVnneiGB5Ns2eOLZ4sJEf5HKJVkHd59UMOx0bDnxt4KTTPG
         Uc4FvJiRaJyEkRXv/VkzdLFfNTjTE//n8kAkUvMxtbeVgWLUkoqY0BJwBkQBKkKQeU1j
         dXc0No/A8I0SpOonIfm/c2TZFrErY751kZ8gF10bWSyiuqI8DmKuvc5yvQeeBj6i0hoh
         oYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695910537; x=1696515337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5LDfK3iMpYFB0tVun5cTOaYgiftMpgCGCTM6bYHuB7U=;
        b=ZBq/cf0ZclcURVSIypx2EuH3fWFuER///PVbAxx5SD8XXQz6BC4PiKYrE9I/cP8MXj
         BYvbPPfg5ipmdDUjkc9MtTJBO4f7LCuzHvWtiwGtBYNijp7yEC+AAF0KsRxsL0akv4NG
         tdhVisZS44YU/3iMDZhUVrf0LYRQnoaSM2Dqd2MDqro7g0Ui/SMvvo0MfcknUSBmvKF1
         p+3sd4LJM+c2kM+axEH668W2UwdbJB1bsAB+uTK8abhktK5kmD/UsEUdHXTx8wW92ydv
         xrGGh8d+rkQuVu9WiIb/zLB8DJgrn5DMqm7YZE5ms1cYXR3oIcl8Wge9okQi2FTqZrCA
         JH4A==
X-Gm-Message-State: AOJu0Yw0KhMqfHc/Sl8853XFRd1fgxgsYGFgZ82IRt1l3b9ennccdZ5S
        2LRceh7mZ9S+RrTmJk44zADIuA==
X-Google-Smtp-Source: AGHT+IGaWhl+UpuFcH3vzDc3xyG9j1avZnkGKieINYm0dY8rK8BR+zrso7zpMyn1wxaTwaQ8/J4lkg==
X-Received: by 2002:a17:90a:6e06:b0:278:f656:ca0e with SMTP id b6-20020a17090a6e0600b00278f656ca0emr1239830pjk.0.1695910537556;
        Thu, 28 Sep 2023 07:15:37 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id sf9-20020a17090b51c900b002609cadc56esm13222035pjb.11.2023.09.28.07.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 07:15:37 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     dan.carpenter@linaro.org, akpm@linux-foundation.org
Cc:     david@fromorbit.com, tkhai@ya.ru, vbabka@suse.cz,
        roman.gushchin@linux.dev, djwong@kernel.org, brauner@kernel.org,
        paulmck@kernel.org, tytso@mit.edu, steven.price@arm.com,
        cel@kernel.org, senozhatsky@chromium.org, yujie.liu@intel.com,
        gregkh@linuxfoundation.org, muchun.song@linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH] fixup: mm: shrinker: add a secondary array for shrinker_info::{map, nr_deferred}
Date:   Thu, 28 Sep 2023 22:15:17 +0800
Message-Id: <20230928141517.12164-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230911094444.68966-41-zhengqi.arch@bytedance.com>
References: <20230911094444.68966-41-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dan Carpenter reported the following bug:

```
The patch b6884b5f15cf: "mm: shrinker: add a secondary array for
shrinker_info::{map, nr_deferred}" from Sep 11, 2023 (linux-next),
leads to the following Smatch static checker warning:

	mm/shrinker.c:100 alloc_shrinker_info()
	warn: inconsistent returns '&shrinker_mutex'.
```

To fix it, unlock the &shrinker_rwsem before the call to
free_shrinker_info().

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-mm/f960ae49-078c-4c00-9516-da31fc1a17d6@moroto.mountain/
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/shrinker.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/shrinker.c b/mm/shrinker.c
index 893079806553..e9644cda80b5 100644
--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -95,6 +95,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
 	return ret;
 
 err:
+	up_write(&shrinker_rwsem);
 	free_shrinker_info(memcg);
 	return -ENOMEM;
 }
-- 
2.30.2

