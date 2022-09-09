Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044165B3621
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 13:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiIILQz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 07:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiIILQu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 07:16:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA385130D1C
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Sep 2022 04:16:49 -0700 (PDT)
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1oWc05-0002dP-2O; Fri, 09 Sep 2022 13:16:45 +0200
From:   Lucas Stach <l.stach@pengutronix.de>
To:     linux-mm@kvack.org, dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= 
        <ckoenig.leichtzumerken@gmail.com>, linux-fsdevel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [RFC PATCH 3/5] drm/gem: add functions to account GEM object memory usage
Date:   Fri,  9 Sep 2022 13:16:38 +0200
Message-Id: <20220909111640.3789791-4-l.stach@pengutronix.de>
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

This adds some functions which driver can call to make the MM aware
of the resident memory used by the GEM object. As drivers will have
different points where memory is made resident/pinned into system
memory, this just adds the helper functions and drivers need to make
sure to call them at the right points.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/gpu/drm/drm_gem.c | 37 +++++++++++++++++++++++++++++++++++++
 include/drm/drm_gem.h     |  3 +++
 2 files changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index b882f935cd4b..efccd0a1dde7 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -1279,3 +1279,40 @@ drm_gem_unlock_reservations(struct drm_gem_object **objs, int count,
 	ww_acquire_fini(acquire_ctx);
 }
 EXPORT_SYMBOL(drm_gem_unlock_reservations);
+
+/**
+ * drm_gem_add_resident - Account memory used by GEM object to the
+ * task which called drm_gem_object_init(). Call when the pages are
+ * made resident in system memory, i.e. pinned for GPU usage.
+ *
+ * @obj: GEM buffer object
+ */
+void drm_gem_add_resident(struct drm_gem_object *obj)
+{
+	if (!mmget_not_zero(obj->mm))
+		return;
+
+	add_mm_counter(obj->mm, MM_DRIVERPAGES, obj->size / PAGE_SIZE);
+
+	mmput(obj->mm);
+}
+EXPORT_SYMBOL(drm_gem_add_resident)
+
+/**
+ * drm_gem_dec_resident - Remove memory used by GEM object accounted
+ * to the task which called drm_gem_object_init(). Call this when the
+ * pages backing the GEM object are no longer resident in system memory,
+ * i.e. when freeing or unpinning the pages.
+ *
+ * @obj: GEM buffer object
+ */
+void drm_gem_dec_resident(struct drm_gem_object *obj)
+{
+	if (!mmget_not_zero(obj->mm))
+		return;
+
+	add_mm_counter(obj->mm, MM_DRIVERPAGES, -(obj->size / PAGE_SIZE));
+
+	mmput(obj->mm);
+}
+EXPORT_SYMBOL(drm_gem_dec_resident)
diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index d021a083c282..5951963a2f1a 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -374,6 +374,9 @@ int drm_gem_mmap_obj(struct drm_gem_object *obj, unsigned long obj_size,
 		     struct vm_area_struct *vma);
 int drm_gem_mmap(struct file *filp, struct vm_area_struct *vma);
 
+void drm_gem_add_resident(struct drm_gem_object *obj);
+void drm_gem_dec_resident(struct drm_gem_object *obj);
+
 /**
  * drm_gem_object_get - acquire a GEM buffer object reference
  * @obj: GEM buffer object
-- 
2.30.2

