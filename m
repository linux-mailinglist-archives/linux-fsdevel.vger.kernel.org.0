Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA0903D2A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2019 18:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405021AbfFKQlq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jun 2019 12:41:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54508 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388306AbfFKQlq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jun 2019 12:41:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 63CD23083392;
        Tue, 11 Jun 2019 16:41:40 +0000 (UTC)
Received: from dhcp201-121.englab.pnq.redhat.com (ovpn-116-60.sin2.redhat.com [10.67.116.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BA13F627DF;
        Tue, 11 Jun 2019 16:41:03 +0000 (UTC)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     dm-devel@redhat.com, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-acpi@vger.kernel.org,
        qemu-devel@nongnu.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
Cc:     dan.j.williams@intel.com, zwisler@kernel.org,
        vishal.l.verma@intel.com, dave.jiang@intel.com, mst@redhat.com,
        jasowang@redhat.com, willy@infradead.org, rjw@rjwysocki.net,
        hch@infradead.org, lenb@kernel.org, jack@suse.cz, tytso@mit.edu,
        adilger.kernel@dilger.ca, darrick.wong@oracle.com,
        lcapitulino@redhat.com, kwolf@redhat.com, imammedo@redhat.com,
        jmoyer@redhat.com, nilal@redhat.com, riel@surriel.com,
        stefanha@redhat.com, aarcange@redhat.com, david@redhat.com,
        david@fromorbit.com, cohuck@redhat.com,
        xiaoguangrong.eric@gmail.com, pagupta@redhat.com,
        pbonzini@redhat.com, yuval.shaia@oracle.com, kilobyte@angband.pl,
        jstaron@google.com, rdunlap@infradead.org, snitzer@redhat.com
Subject: [PATCH v12 4/7] dm: enable synchronous dax
Date:   Tue, 11 Jun 2019 22:07:59 +0530
Message-Id: <20190611163802.25352-5-pagupta@redhat.com>
In-Reply-To: <20190611163802.25352-1-pagupta@redhat.com>
References: <20190611163802.25352-1-pagupta@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 11 Jun 2019 16:41:45 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch sets dax device 'DAXDEV_SYNC' flag if all the target
devices of device mapper support synchrononous DAX. If device
mapper consists of both synchronous and asynchronous dax devices,
we don't set 'DAXDEV_SYNC' flag.

'dm_table_supports_dax' is refactored to pass 'iterate_devices_fn'
as argument so that the callers can pass the appropriate functions.

Suggested-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
---
 drivers/md/dm-table.c | 24 ++++++++++++++++++------
 drivers/md/dm.c       |  2 +-
 drivers/md/dm.h       |  5 ++++-
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 350cf0451456..81c55304c4fa 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -881,7 +881,7 @@ void dm_table_set_type(struct dm_table *t, enum dm_queue_mode type)
 EXPORT_SYMBOL_GPL(dm_table_set_type);
 
 /* validate the dax capability of the target device span */
-static int device_supports_dax(struct dm_target *ti, struct dm_dev *dev,
+int device_supports_dax(struct dm_target *ti, struct dm_dev *dev,
 				       sector_t start, sector_t len, void *data)
 {
 	int blocksize = *(int *) data;
@@ -890,7 +890,15 @@ static int device_supports_dax(struct dm_target *ti, struct dm_dev *dev,
 			start, len);
 }
 
-bool dm_table_supports_dax(struct dm_table *t, int blocksize)
+/* Check devices support synchronous DAX */
+static int device_synchronous(struct dm_target *ti, struct dm_dev *dev,
+				       sector_t start, sector_t len, void *data)
+{
+	return dax_synchronous(dev->dax_dev);
+}
+
+bool dm_table_supports_dax(struct dm_table *t,
+			  iterate_devices_callout_fn iterate_fn, int *blocksize)
 {
 	struct dm_target *ti;
 	unsigned i;
@@ -903,8 +911,7 @@ bool dm_table_supports_dax(struct dm_table *t, int blocksize)
 			return false;
 
 		if (!ti->type->iterate_devices ||
-		    !ti->type->iterate_devices(ti, device_supports_dax,
-			    &blocksize))
+			!ti->type->iterate_devices(ti, iterate_fn, blocksize))
 			return false;
 	}
 
@@ -940,6 +947,7 @@ static int dm_table_determine_type(struct dm_table *t)
 	struct dm_target *tgt;
 	struct list_head *devices = dm_table_get_devices(t);
 	enum dm_queue_mode live_md_type = dm_get_md_type(t->md);
+	int page_size = PAGE_SIZE;
 
 	if (t->type != DM_TYPE_NONE) {
 		/* target already set the table's type */
@@ -984,7 +992,7 @@ static int dm_table_determine_type(struct dm_table *t)
 verify_bio_based:
 		/* We must use this table as bio-based */
 		t->type = DM_TYPE_BIO_BASED;
-		if (dm_table_supports_dax(t, PAGE_SIZE) ||
+		if (dm_table_supports_dax(t, device_supports_dax, &page_size) ||
 		    (list_empty(devices) && live_md_type == DM_TYPE_DAX_BIO_BASED)) {
 			t->type = DM_TYPE_DAX_BIO_BASED;
 		} else {
@@ -1883,6 +1891,7 @@ void dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 			       struct queue_limits *limits)
 {
 	bool wc = false, fua = false;
+	int page_size = PAGE_SIZE;
 
 	/*
 	 * Copy table's limits to the DM device's request_queue
@@ -1910,8 +1919,11 @@ void dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 	}
 	blk_queue_write_cache(q, wc, fua);
 
-	if (dm_table_supports_dax(t, PAGE_SIZE))
+	if (dm_table_supports_dax(t, device_supports_dax, &page_size)) {
 		blk_queue_flag_set(QUEUE_FLAG_DAX, q);
+		if (dm_table_supports_dax(t, device_synchronous, NULL))
+			set_dax_synchronous(t->md->dax_dev);
+	}
 	else
 		blk_queue_flag_clear(QUEUE_FLAG_DAX, q);
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index b1caa7188209..b92c42a72ad4 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1119,7 +1119,7 @@ static bool dm_dax_supported(struct dax_device *dax_dev, struct block_device *bd
 	if (!map)
 		return false;
 
-	ret = dm_table_supports_dax(map, blocksize);
+	ret = dm_table_supports_dax(map, device_supports_dax, &blocksize);
 
 	dm_put_live_table(md, srcu_idx);
 
diff --git a/drivers/md/dm.h b/drivers/md/dm.h
index 17e3db54404c..0475673337f3 100644
--- a/drivers/md/dm.h
+++ b/drivers/md/dm.h
@@ -72,7 +72,10 @@ bool dm_table_bio_based(struct dm_table *t);
 bool dm_table_request_based(struct dm_table *t);
 void dm_table_free_md_mempools(struct dm_table *t);
 struct dm_md_mempools *dm_table_get_md_mempools(struct dm_table *t);
-bool dm_table_supports_dax(struct dm_table *t, int blocksize);
+bool dm_table_supports_dax(struct dm_table *t, iterate_devices_callout_fn fn,
+			   int *blocksize);
+int device_supports_dax(struct dm_target *ti, struct dm_dev *dev,
+			   sector_t start, sector_t len, void *data);
 
 void dm_lock_md_type(struct mapped_device *md);
 void dm_unlock_md_type(struct mapped_device *md);
-- 
2.20.1

