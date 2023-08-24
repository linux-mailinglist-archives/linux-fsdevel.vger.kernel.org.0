Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD95786664
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 05:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239792AbjHXDxZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 23:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236822AbjHXDw3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 23:52:29 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE5D1FDC
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:50:45 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6bc57401cb9so829326a34.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692849015; x=1693453815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FlzFvcCQYvI8dZSQr0uzK4V9UWa182sTQHb8HSYecY=;
        b=CCTuSOBgedcKOMD6iZJkvY7Us2mVWVIovgQPaP6ZUpdF+pw4bAhv02m/Nl/S4QVY4d
         LPWSynhpJLRykIHUCiAxqCO+wFldrWBDT8NgV40tAakicxue0r1bpK5B/Q/mLIz5qd9g
         E+PYwX2FapH/Q+l5AGm47K2ttt7y4CjIrDWtAgA5OR6aYvDU11Lb8F1MD1U2SE6i8Bj6
         H25VAPO/X8QTRWh+vgYHVw4v2i7u3qqCizmLZFjpxfwshexicHFZyXOq/NSfx2KwPlBG
         0SM3oY1UWfVHYDPVirSv4+DuSFqTIUnfwkygBDf843DNNjRGpZkoSP1jM2B6BMbRru4C
         IyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692849015; x=1693453815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4FlzFvcCQYvI8dZSQr0uzK4V9UWa182sTQHb8HSYecY=;
        b=Yv4TwLBAjJRWyuiYIoOuSuyfCtCsbCHqB2ew43Z3lRMhbdoDOCPWEm4NVThGH13x4+
         A0shHnThdT3NFg2pCiULW05E6hnKoyd1HCXx8z0xGZdPs/wzy/YdIF0O0f+w3lNvdciF
         o+iu0k39n3dGkYz61ykiG9WsQIMRNfvEROw0WFm73n21cbSlLOWwZb6lb9zJ+Aqa/j0U
         cR2mOEbjOpUgTHJlvUk88Ywrg/BVkU/6D3YnDw73g5jc8AbnycydyWlAJN3cQRM/Nps/
         VCl0D0UomEcWejXQfEnfHnrypSgaLFMfR/kSmKa5Z/ndsp1OVw1TRAmImnt7ifIQXml0
         GF8w==
X-Gm-Message-State: AOJu0YwvVw8MYEY2N2pGW5FM5h/vxwedm2bWX2R2GWs8kwv15lq7ADef
        HzziWd0A72txXnL/0EJER3Fxtw==
X-Google-Smtp-Source: AGHT+IGNNFy+tJmkErp1Cj65UOC5qZG9ZWIMpE+ontdaYElYA5FS/+TvI/fJv+zkeYDhjrDv7KNO4g==
X-Received: by 2002:a05:6830:308f:b0:6b9:b987:1337 with SMTP id g15-20020a056830308f00b006b9b9871337mr14530264ots.1.1692849015165;
        Wed, 23 Aug 2023 20:50:15 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id t6-20020a63b246000000b005579f12a238sm10533157pgo.86.2023.08.23.20.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 20:50:14 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v5 44/45] mm: shrinker: hold write lock to reparent shrinker nr_deferred
Date:   Thu, 24 Aug 2023 11:43:03 +0800
Message-Id: <20230824034304.37411-45-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
References: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For now, reparent_shrinker_deferred() is the only holder of read lock of
shrinker_rwsem. And it already holds the global cgroup_mutex, so it will
not be called in parallel.

Therefore, in order to convert shrinker_rwsem to shrinker_mutex later,
here we change to hold the write lock of shrinker_rwsem to reparent.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/shrinker.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/shrinker.c b/mm/shrinker.c
index a66e2a30cc16..b8cb9d2f5dbf 100644
--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -292,7 +292,7 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
 		parent = root_mem_cgroup;
 
 	/* Prevent from concurrent shrinker_info expand */
-	down_read(&shrinker_rwsem);
+	down_write(&shrinker_rwsem);
 	for_each_node(nid) {
 		child_info = shrinker_info_protected(memcg, nid);
 		parent_info = shrinker_info_protected(parent, nid);
@@ -305,7 +305,7 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
 			}
 		}
 	}
-	up_read(&shrinker_rwsem);
+	up_write(&shrinker_rwsem);
 }
 #else
 static int shrinker_memcg_alloc(struct shrinker *shrinker)
-- 
2.30.2

