Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDF65B3622
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 13:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiIILQ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 07:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiIILQu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 07:16:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10570130D23
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Sep 2022 04:16:50 -0700 (PDT)
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1oWc06-0002dP-1w; Fri, 09 Sep 2022 13:16:46 +0200
From:   Lucas Stach <l.stach@pengutronix.de>
To:     linux-mm@kvack.org, dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= 
        <ckoenig.leichtzumerken@gmail.com>, linux-fsdevel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [RFC PATCH 5/5] drm/etnaviv: account memory used by GEM buffers
Date:   Fri,  9 Sep 2022 13:16:40 +0200
Message-Id: <20220909111640.3789791-6-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220909111640.3789791-1-l.stach@pengutronix.de>
References: <20220909111640.3789791-1-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Etnaviv GEM buffers are pinned into memory as soon as we allocate
the pages backing the object and only disappear when freeing the
GEM object as there is no shrinker hooked up for unused buffers.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/gpu/drm/etnaviv/etnaviv_gem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
index cc386f8a7116..bf3d75b8e154 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
@@ -67,6 +67,8 @@ static int etnaviv_gem_shmem_get_pages(struct etnaviv_gem_object *etnaviv_obj)
 
 	etnaviv_obj->pages = p;
 
+	drm_gem_add_resident(&etnaviv_obj->base);
+
 	return 0;
 }
 
@@ -79,6 +81,7 @@ static void put_pages(struct etnaviv_gem_object *etnaviv_obj)
 		etnaviv_obj->sgt = NULL;
 	}
 	if (etnaviv_obj->pages) {
+		drm_gem_dec_resident(&etnaviv_obj->base);
 		drm_gem_put_pages(&etnaviv_obj->base, etnaviv_obj->pages,
 				  true, false);
 
-- 
2.30.2

