Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8E3A1FA9F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 21:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfEOT2I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 May 2019 15:28:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49680 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727725AbfEOT1g (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 May 2019 15:27:36 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D49807E9F9;
        Wed, 15 May 2019 19:27:35 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC45B9CCA;
        Wed, 15 May 2019 19:27:32 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id B0D40225480; Wed, 15 May 2019 15:27:29 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-nvdimm@lists.01.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, swhiteho@redhat.com
Subject: [PATCH v2 12/30] dax: remove block device dependencies
Date:   Wed, 15 May 2019 15:26:57 -0400
Message-Id: <20190515192715.18000-13-vgoyal@redhat.com>
In-Reply-To: <20190515192715.18000-1-vgoyal@redhat.com>
References: <20190515192715.18000-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 15 May 2019 19:27:35 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Stefan Hajnoczi <stefanha@redhat.com>

Although struct dax_device itself is not tied to a block device, some
DAX code assumes there is a block device.  Make block devices optional
by allowing bdev to be NULL in commonly used DAX APIs.

When there is no block device:
 * Skip the partition offset calculation in bdev_dax_pgoff()
 * Skip the blkdev_issue_zeroout() optimization

Note that more block device assumptions remain but I haven't reach those
code paths yet.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 drivers/dax/super.c | 3 ++-
 fs/dax.c            | 7 ++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 0a339b85133e..cb44ec663991 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -53,7 +53,8 @@ EXPORT_SYMBOL_GPL(dax_read_unlock);
 int bdev_dax_pgoff(struct block_device *bdev, sector_t sector, size_t size,
 		pgoff_t *pgoff)
 {
-	phys_addr_t phys_off = (get_start_sect(bdev) + sector) * 512;
+	sector_t start_sect = bdev ? get_start_sect(bdev) : 0;
+	phys_addr_t phys_off = (start_sect + sector) * 512;
 
 	if (pgoff)
 		*pgoff = PHYS_PFN(phys_off);
diff --git a/fs/dax.c b/fs/dax.c
index e5e54da1715f..815bc32fd967 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1042,7 +1042,12 @@ static vm_fault_t dax_load_hole(struct xa_state *xas,
 static bool dax_range_is_aligned(struct block_device *bdev,
 				 unsigned int offset, unsigned int length)
 {
-	unsigned short sector_size = bdev_logical_block_size(bdev);
+	unsigned short sector_size;
+
+	if (!bdev)
+		return false;
+
+	sector_size = bdev_logical_block_size(bdev);
 
 	if (!IS_ALIGNED(offset, sector_size))
 		return false;
-- 
2.20.1

