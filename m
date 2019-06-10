Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B09A3B1A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2019 11:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388833AbfFJJLK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jun 2019 05:11:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38742 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388552AbfFJJLJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jun 2019 05:11:09 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4EC5B3084021;
        Mon, 10 Jun 2019 09:11:09 +0000 (UTC)
Received: from dhcp201-121.englab.pnq.redhat.com (ovpn-116-103.sin2.redhat.com [10.67.116.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C3D0160BF1;
        Mon, 10 Jun 2019 09:10:33 +0000 (UTC)
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
        xiaoguangrong.eric@gmail.com, pbonzini@redhat.com,
        yuval.shaia@oracle.com, kilobyte@angband.pl, jstaron@google.com,
        rdunlap@infradead.org, snitzer@redhat.com, pagupta@redhat.com
Subject: [PATCH v11 4/7] dm: enable synchronous dax
Date:   Mon, 10 Jun 2019 14:37:27 +0530
Message-Id: <20190610090730.8589-5-pagupta@redhat.com>
In-Reply-To: <20190610090730.8589-1-pagupta@redhat.com>
References: <20190610090730.8589-1-pagupta@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 10 Jun 2019 09:11:09 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

 This patch sets dax device 'DAXDEV_SYNC' flag if all the target
 devices of device mapper support synchrononous DAX. If device
 mapper consists of both synchronous and asynchronous dax devices,
 we don't set 'DAXDEV_SYNC' flag.

Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
---
 drivers/md/dm-table.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 350cf0451456..c5160d846fe6 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -890,10 +890,17 @@ static int device_supports_dax(struct dm_target *ti, struct dm_dev *dev,
 			start, len);
 }
 
+static int device_synchronous(struct dm_target *ti, struct dm_dev *dev,
+				       sector_t start, sector_t len, void *data)
+{
+	return dax_synchronous(dev->dax_dev);
+}
+
 bool dm_table_supports_dax(struct dm_table *t, int blocksize)
 {
 	struct dm_target *ti;
 	unsigned i;
+	bool dax_sync = true;
 
 	/* Ensure that all targets support DAX. */
 	for (i = 0; i < dm_table_get_num_targets(t); i++) {
@@ -906,7 +913,14 @@ bool dm_table_supports_dax(struct dm_table *t, int blocksize)
 		    !ti->type->iterate_devices(ti, device_supports_dax,
 			    &blocksize))
 			return false;
+
+		/* Check devices support synchronous DAX */
+		if (dax_sync &&
+		    !ti->type->iterate_devices(ti, device_synchronous, NULL))
+			dax_sync = false;
 	}
+	if (dax_sync)
+		set_dax_synchronous(t->md->dax_dev);
 
 	return true;
 }
-- 
2.20.1

