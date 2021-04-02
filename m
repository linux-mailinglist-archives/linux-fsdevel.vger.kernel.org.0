Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213E7352850
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Apr 2021 11:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234533AbhDBJNW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Apr 2021 05:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234433AbhDBJNV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Apr 2021 05:13:21 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA83C0613E6
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Apr 2021 02:13:20 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id v8so2265137plz.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Apr 2021 02:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DjRyCgO+FsYIMv6lDBRT9Icw65Tl/lomaeADojK5v1w=;
        b=KaIvC3D5xZrOpI3Fh45UdONyw0zxnSeoxx0/viC3D58q+SKIyvKiB1DqVaVR0wddEC
         XxrFDWIjBVjCX0mHKfG0q3J2/g/IjyZqI2Prtn2KmWc03hsikwk6K/XpD6N5rQrGh5L0
         umrvBKmuvCgVhk6Gio5tRxX88BWpdts1en0E26ohtH4nGulSZ+80kABTWnQTK2xoOBN7
         /OZKqyO3LvUajnG76slUWe4FQyF+FEV2IigN20MrJaMxeGw9jmQmjszi0Pxvs16CCeq0
         U9I34N3VRxg4ZPF8W+O1ZDR5X0D+dffyBhFz9wYNeUTQKYdaeEmDVSFlmXjxU6w+VxNR
         /ebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DjRyCgO+FsYIMv6lDBRT9Icw65Tl/lomaeADojK5v1w=;
        b=NPKpQ5LA9ceM7UfEGUFIMIw/dXdDCQwWt1CNIT9ErpLCj7UWLvwJiRl4RDYu++AGdp
         M93g2Io/bECuc0tyoSICklwRUnEXnMxXRTrr7dGa9Go/Zc/nOlw9RZG1/QLLLaJoIJEE
         2ngwOXJagnPEOCk2cvdqXCEu9TmxA+jM266BuF4mE3Eiz6hDu7VppuRLmaouMbfVKkmU
         SQ+VwyudLuECe8ENpJul5ARc7Bo1wYU6SBsp5yjww2N0czoK4daAxSYY6vMIoqZfBe3q
         wtSOnGPkTIq/mT8Y3E22mH1Apku0OUs9Q1O3irG+HapMpuV20gncmetkE2DlGN9JzZeB
         BbKA==
X-Gm-Message-State: AOAM5329SMFAPGmTtYOJACiraNYmADW1i/ITSYNr16NyXaEDHoXXrdN/
        og3oTXIvXf5fXtMc6byuEJNC+g==
X-Google-Smtp-Source: ABdhPJzckuM2+KIVfgoHjenDGm5wBab6s8+R3CLkAkCBWWNyVoU0Saf793YEe4GUeIPJ7Fj4WqFhlg==
X-Received: by 2002:a17:90a:f3d7:: with SMTP id ha23mr12534986pjb.130.1617354799552;
        Fri, 02 Apr 2021 02:13:19 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id b21sm1091323pji.39.2021.04.02.02.13.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Apr 2021 02:13:18 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     viro@zeniv.linux.org.uk, tj@kernel.org, axboe@fb.com,
        willy@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH v3] writeback: fix obtain a reference to a freeing memcg css
Date:   Fri,  2 Apr 2021 17:11:45 +0800
Message-Id: <20210402091145.80635-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The caller of wb_get_create() should pin the memcg, because
wb_get_create() relies on this guarantee. The rcu read lock
only can guarantee that the memcg css returned by css_from_id()
cannot be released, but the reference of the memcg can be zero.

  rcu_read_lock()
  memcg_css = css_from_id()
  wb_get_create(memcg_css)
      cgwb_create(memcg_css)
          // css_get can change the ref counter from 0 back to 1
          css_get(memcg_css)
  rcu_read_unlock()

Fix it by holding a reference to the css before calling
wb_get_create(). This is not a problem I encountered in the
real world. Just the result of a code review.

Fixes: 682aa8e1a6a1 ("writeback: implement unlocked_inode_to_wb transaction and use it for stat updates")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
Changelog in v3:
 1. Do not change GFP_ATOMIC.
 2. Update commit log.

 Thanks for Michal's review and suggestions.

Changelog in v2:
 1. Replace GFP_ATOMIC with GFP_NOIO suggested by Matthew.


 fs/fs-writeback.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 3ac002561327..dedde99da40d 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -506,9 +506,14 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
 	/* find and pin the new wb */
 	rcu_read_lock();
 	memcg_css = css_from_id(new_wb_id, &memory_cgrp_subsys);
-	if (memcg_css)
-		isw->new_wb = wb_get_create(bdi, memcg_css, GFP_ATOMIC);
+	if (memcg_css && !css_tryget(memcg_css))
+		memcg_css = NULL;
 	rcu_read_unlock();
+	if (!memcg_css)
+		goto out_free;
+
+	isw->new_wb = wb_get_create(bdi, memcg_css, GFP_ATOMIC);
+	css_put(memcg_css);
 	if (!isw->new_wb)
 		goto out_free;
 
-- 
2.11.0

