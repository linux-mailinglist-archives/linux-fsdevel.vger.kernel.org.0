Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFBC45B3620
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 13:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiIILQx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 07:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiIILQu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 07:16:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357E2130D16
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Sep 2022 04:16:49 -0700 (PDT)
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1oWc04-0002dP-Ir; Fri, 09 Sep 2022 13:16:44 +0200
From:   Lucas Stach <l.stach@pengutronix.de>
To:     linux-mm@kvack.org, dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= 
        <ckoenig.leichtzumerken@gmail.com>, linux-fsdevel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [RFC PATCH 2/5] drm/gem: track mm struct of allocating process in gem object
Date:   Fri,  9 Sep 2022 13:16:37 +0200
Message-Id: <20220909111640.3789791-3-l.stach@pengutronix.de>
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

This keeps around a weak reference to the struct mm of the process
allocating the GEM object. This allows us to charge/uncharge the
process with the allocated backing store memory, even if this is
happening from another context.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/gpu/drm/drm_gem.c |  5 +++++
 include/drm/drm_gem.h     | 12 ++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 86d670c71286..b882f935cd4b 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -36,6 +36,7 @@
 #include <linux/pagemap.h>
 #include <linux/pagevec.h>
 #include <linux/shmem_fs.h>
+#include <linux/sched/mm.h>
 #include <linux/slab.h>
 #include <linux/string_helpers.h>
 #include <linux/types.h>
@@ -157,6 +158,9 @@ void drm_gem_private_object_init(struct drm_device *dev,
 	obj->dev = dev;
 	obj->filp = NULL;
 
+	mmgrab(current->mm);
+	obj->mm = current->mm;
+
 	kref_init(&obj->refcount);
 	obj->handle_count = 0;
 	obj->size = size;
@@ -949,6 +953,7 @@ drm_gem_object_release(struct drm_gem_object *obj)
 	if (obj->filp)
 		fput(obj->filp);
 
+	mmdrop(obj->mm);
 	dma_resv_fini(&obj->_resv);
 	drm_gem_free_mmap_offset(obj);
 }
diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index 87cffc9efa85..d021a083c282 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -234,6 +234,18 @@ struct drm_gem_object {
 	 */
 	struct drm_vma_offset_node vma_node;
 
+	/**
+	 * @mm:
+	 *
+	 * mm struct of the process creating the object. Used to account the
+	 * allocated backing store memory.
+	 *
+	 * Note that this is a weak reference created by mmgrab(), so any
+	 * manipulation needs to make sure the address space is still around by
+	 * calling mmget_not_zero().
+	 */
+	struct mm_struct *mm;
+
 	/**
 	 * @size:
 	 *
-- 
2.30.2

