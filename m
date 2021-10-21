Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C9143620B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 14:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbhJUMrT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 08:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbhJUMrS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 08:47:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAB1C06161C
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Oct 2021 05:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=OdstAJJ/aNxAfiq3+i1crM5pZ57n3VavG4zixG5t6MY=; b=pcHEnwMXx537KKcW7aTqEKyhWh
        /+zcUhPuTBrY7E8EEIhV9YJDk+OtDP4J91xvJpoT0cJThFOmVVtsbn5Jci1Jik6BWAeE0/tmyYK3C
        RVo8Q8whjQYbu0UpH463xncgxbnL2rcB1ugWOZ+B44yaNFVMfUeX0GZS7hq4Z5cYfUREZunllDZVZ
        R9jMQ6tOwXQitYBib19oALNXB0tISM4c1hQwVEsu3IqO9LZXsTJPHW/poGNsGKCle5NXXO1w/2Bsz
        OQaVxlq0QpWXkBWNzF2RDuA5eXQdJcVsdI8EXxksma1BojPeL/lMzqGKA6w0QS42iyLgakLJTdNd9
        ddJRG4cw==;
Received: from [2001:4bb8:180:8777:dd70:8011:36d9:4c23] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdXRL-007X1k-GZ; Thu, 21 Oct 2021 12:44:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>, Jan Kara <jack@suse.cz>,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 5/5] mm: simplify bdi refcounting
Date:   Thu, 21 Oct 2021 14:44:41 +0200
Message-Id: <20211021124441.668816-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211021124441.668816-1-hch@lst.de>
References: <20211021124441.668816-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move grabbing and releasing the bdi refcount out of the common
wb_init/wb_exit helpers into code that is only used for the non-default
memcg driven bdi_writeback structures.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/backing-dev.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 768e9ae489f66..5ccb250898083 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -291,8 +291,6 @@ static int wb_init(struct bdi_writeback *wb, struct backing_dev_info *bdi,
 
 	memset(wb, 0, sizeof(*wb));
 
-	if (wb != &bdi->wb)
-		bdi_get(bdi);
 	wb->bdi = bdi;
 	wb->last_old_flush = jiffies;
 	INIT_LIST_HEAD(&wb->b_dirty);
@@ -316,7 +314,7 @@ static int wb_init(struct bdi_writeback *wb, struct backing_dev_info *bdi,
 
 	err = fprop_local_init_percpu(&wb->completions, gfp);
 	if (err)
-		goto out_put_bdi;
+		return err;
 
 	for (i = 0; i < NR_WB_STAT_ITEMS; i++) {
 		err = percpu_counter_init(&wb->stat[i], 0, gfp);
@@ -330,9 +328,6 @@ static int wb_init(struct bdi_writeback *wb, struct backing_dev_info *bdi,
 	while (i--)
 		percpu_counter_destroy(&wb->stat[i]);
 	fprop_local_destroy_percpu(&wb->completions);
-out_put_bdi:
-	if (wb != &bdi->wb)
-		bdi_put(bdi);
 	return err;
 }
 
@@ -373,8 +368,6 @@ static void wb_exit(struct bdi_writeback *wb)
 		percpu_counter_destroy(&wb->stat[i]);
 
 	fprop_local_destroy_percpu(&wb->completions);
-	if (wb != &wb->bdi->wb)
-		bdi_put(wb->bdi);
 }
 
 #ifdef CONFIG_CGROUP_WRITEBACK
@@ -397,6 +390,7 @@ static void cgwb_release_workfn(struct work_struct *work)
 	struct bdi_writeback *wb = container_of(work, struct bdi_writeback,
 						release_work);
 	struct blkcg *blkcg = css_to_blkcg(wb->blkcg_css);
+	struct backing_dev_info *bdi = wb->bdi;
 
 	mutex_lock(&wb->bdi->cgwb_release_mutex);
 	wb_shutdown(wb);
@@ -416,6 +410,7 @@ static void cgwb_release_workfn(struct work_struct *work)
 
 	percpu_ref_exit(&wb->refcnt);
 	wb_exit(wb);
+	bdi_put(bdi);
 	WARN_ON_ONCE(!list_empty(&wb->b_attached));
 	kfree_rcu(wb, rcu);
 }
@@ -497,6 +492,7 @@ static int cgwb_create(struct backing_dev_info *bdi,
 	INIT_LIST_HEAD(&wb->b_attached);
 	INIT_WORK(&wb->release_work, cgwb_release_workfn);
 	set_bit(WB_registered, &wb->state);
+	bdi_get(bdi);
 
 	/*
 	 * The root wb determines the registered state of the whole bdi and
@@ -528,6 +524,7 @@ static int cgwb_create(struct backing_dev_info *bdi,
 	goto out_put;
 
 err_fprop_exit:
+	bdi_put(bdi);
 	fprop_local_destroy_percpu(&wb->memcg_completions);
 err_ref_exit:
 	percpu_ref_exit(&wb->refcnt);
-- 
2.30.2

