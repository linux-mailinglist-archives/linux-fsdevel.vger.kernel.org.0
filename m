Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4B96BAB13
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 09:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjCOIt5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 04:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjCOIty (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 04:49:54 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8129C5C11F
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 01:49:52 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id a2so19279947plm.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 01:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112; t=1678870192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PiH3qSD87Gy2R0sEveTfXmyJns2RRHbdlIcrLyx7vY=;
        b=dGXEAZWGtw3hjf4evG9X6AHe1yTsnbPEjFBkPoP86wCPr8QN6TVnbPOULBMveWDVoT
         jiIftWXhqKYSzp0qmhThWBeyCKsD4Tm6Xp+7PMte7cJF7wgzVLSiYssGL15uSOr3lvfV
         rQd66fF+t9UQq3jhdoFYBw6GCsPIQuVOxn5UolXc0160hrbGsy9zlV4+B/qhV9yCDS7F
         H/CMxjUw1Z+tGw+1u0CeYT7yhOpK5oiWVK6GvR3bPJpgJzz75iWIvVxMm4iFmXRulZ4+
         jvTJP5PpwGUCDBuh+DdFDKIgLX1jwAvPcxNGWCCVoZa7qwZqgDG/cKCvCt3mmTsN4n4r
         PO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678870192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3PiH3qSD87Gy2R0sEveTfXmyJns2RRHbdlIcrLyx7vY=;
        b=USIRaZzSBmyElw4k13eWycgXe/zTECKo6YXa7sFRAzLI9ECz6xb6VpexNJN6oA97MA
         jMT/D+hg5cpKXyrAwJaS/Pyc4nzDZGDpqhcH0uziW8FiUWlvQUvIqJbWTOLR0ayi9ioC
         v3CEBuJPZ6DkV+TjVurMtn+AnNbmBA9a/lPezuANgoG17efer/OJvNQCH7M7Ls3rWKMY
         7rlzknZ+NBV5WttMiolbx+NwlkhN3lM04FnWupjwCSZwqAyEQJ9gaxzLQjjLuhlUxHCG
         ZmvMDbZGmUGA42SXS2CiNksC1LsOqDRKguftM8clGOD+OS9+mmJrE0R7jvp2x/Pcmhcw
         fuKg==
X-Gm-Message-State: AO0yUKWdEvMqtGSQX9jGH11Zlw2guT+cTT5ZX6mCGF8OHI9jdp34Sj9T
        GuPHgBTMoFPf6TMFrs5XFW/agA==
X-Google-Smtp-Source: AK7set/d5shADEggOumzehf9o4A4WvFVUPs23yylPGUIObnfMjjp0YKBaZtfOr+A8wcBYihNDIQpPQ==
X-Received: by 2002:a17:902:e541:b0:19a:70f9:affb with SMTP id n1-20020a170902e54100b0019a70f9affbmr2478057plf.2.1678870191825;
        Wed, 15 Mar 2023 01:49:51 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-4-237.pa.vic.optusnet.com.au. [49.186.4.237])
        by smtp.gmail.com with ESMTPSA id kk5-20020a170903070500b0019a928a8982sm3096849plb.118.2023.03.15.01.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 01:49:51 -0700 (PDT)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <dave@fromorbit.com>)
        id 1pcMpQ-008zeU-45; Wed, 15 Mar 2023 19:49:48 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.96)
        (envelope-from <dave@devoid.disaster.area>)
        id 1pcMpQ-00Ag6T-0N;
        Wed, 15 Mar 2023 19:49:48 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Cc:     linux-mm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        yebin10@huawei.com
Subject: [PATCH 3/4] fork: remove use of percpu_counter_sum_all
Date:   Wed, 15 Mar 2023 19:49:37 +1100
Message-Id: <20230315084938.2544737-4-david@fromorbit.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315084938.2544737-1-david@fromorbit.com>
References: <20230315084938.2544737-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

This effectively reverts the change made in commit f689054aace2
("percpu_counter: add percpu_counter_sum_all interface") as the
race condition percpu_counter_sum_all() was invented to avoid is
now handled directly in percpu_counter_sum() and nobody needs to
care about summing racing with cpu unplug anymore.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 kernel/fork.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index d8cda4c6de6c..c0257cbee093 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -755,11 +755,6 @@ static void check_mm(struct mm_struct *mm)
 	for (i = 0; i < NR_MM_COUNTERS; i++) {
 		long x = percpu_counter_sum(&mm->rss_stat[i]);
 
-		if (likely(!x))
-			continue;
-
-		/* Making sure this is not due to race with CPU offlining. */
-		x = percpu_counter_sum_all(&mm->rss_stat[i]);
 		if (unlikely(x))
 			pr_alert("BUG: Bad rss-counter state mm:%p type:%s val:%ld\n",
 				 mm, resident_page_types[i], x);
-- 
2.39.2

