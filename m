Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96D179ADA1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 01:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239931AbjIKUzo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236153AbjIKJvu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:51:50 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7005EE4E
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:51:46 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c0efe0c4acso7092885ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694425906; x=1695030706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsvoU0P27T3SHlAjt1w8muCb9cUYLpaKhV7Wpc+WlY8=;
        b=MvfkuhGv5LSqcHxqezdO64QWsSfeqOWmh+z7MR0G1nOz6WcIDMS39Bfqr878+95aXc
         BGPqjS0S5Ei+gmHGEwjO0RiBVsO5icVoaO1wrlshJmJQ2kZCMRgfqNnFtFk0Wcv3dF1k
         NM4oxC5ka5vTFDnb31mgr94lVASrbROj6WoYR5908dboqY+AtGVWOPG+7mwax8KyQokk
         mEta+E84kN38rtcRWL+RTNB/fCnjOW/V9Eg/gaeqwVIuY4zL75euj4HoC8OdAljB9eyl
         lEGibk39FSr501S1w7YpAa4fI/vi9EB4tB8sg34bELF3jWI/XgHH3pq0W2hkj1JAbiEz
         c0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425906; x=1695030706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nsvoU0P27T3SHlAjt1w8muCb9cUYLpaKhV7Wpc+WlY8=;
        b=ek1+J07VpOAJ9/OAIdN7+nVSO9wxaCrKWlVWhMyEViuZmzo8DkO+c3JGXb/XIz3ObW
         QaLOUp1J7d6ggSPLwQNmZsMLy0jyTTtktzEIWKONxs/Yt3CQTNGXVWEaP6RDNEsLlaNO
         O3e5WMnNvJBlXk6l+4X0os+dXdp25tKuOH+y+Lwe2mI2AWG0pad0cY2ekD7alBm+F7Wk
         fgjx8dT9+U0NR+D3zlk1UZ5vcgsMNh6xyStucW+SfKyGXda0+ygscsM4KITYT+Iukikr
         21J6TXGQM4p/8tAkymFUGTqVB2Ywx4+b1l4GDp2FDZkONZmSfzoZZaEgElK3WuyYGXFE
         lN/w==
X-Gm-Message-State: AOJu0Yz8Q5mDC1/5PSxPgoNbuZjvY4DaisjlMYJwxp0UZo6wXrix07KM
        tDcqiEyMB/HbcQpogsycf4CWqA==
X-Google-Smtp-Source: AGHT+IFtnlx2HOm/jCSk9ayFrW0ZCh+0jIw0rvxZkQXsUrMha5y88qwb+DelOOMwpsKlazP0cUr2uw==
X-Received: by 2002:a17:902:c94e:b0:1c3:4073:bf80 with SMTP id i14-20020a170902c94e00b001c34073bf80mr11732124pla.0.1694425905934;
        Mon, 11 Sep 2023 02:51:45 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id az7-20020a170902a58700b001bdc2fdcf7esm5988188plb.129.2023.09.11.02.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:51:45 -0700 (PDT)
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
Subject: [PATCH v6 44/45] mm: shrinker: hold write lock to reparent shrinker nr_deferred
Date:   Mon, 11 Sep 2023 17:44:43 +0800
Message-Id: <20230911094444.68966-45-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
References: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
index ad64cac5248c..471c07d75c4a 100644
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

