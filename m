Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9A01510A5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2020 21:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgBCUA4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Feb 2020 15:00:56 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25252 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726187AbgBCUAz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Feb 2020 15:00:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580760054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KBvBjwfgsut+QyCKuq0fAQ19bjQxWchuDiUcYbX6UgI=;
        b=jC6WEQ+LuYE/apjs6uEITxXr/2ltaJKGgyUyQs5jipncmEitDhEJXL6Eru2JYL8YZGKetA
        cQp+6Obe2kt7MaVwsD7/cfgoOZZ3DQfaTBEwyq2XgBWdSShdvet3qq2a5Iky8rLJXVC925
        1Tvs5S4xkiMG+lJlGrnGnUC34BrHNks=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-HSPBJUu1PjifWqItHPaKfA-1; Mon, 03 Feb 2020 15:00:50 -0500
X-MC-Unique: HSPBJUu1PjifWqItHPaKfA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 511DC107ACC9;
        Mon,  3 Feb 2020 20:00:49 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7AC155C1B5;
        Mon,  3 Feb 2020 20:00:46 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 1440022471C; Mon,  3 Feb 2020 15:00:46 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        dan.j.williams@intel.com, hch@infradead.org
Cc:     vgoyal@redhat.com, vishal.l.verma@intel.com, dm-devel@redhat.com
Subject: [PATCH 3/5] dm,dax: Add dax zero_page_range operation
Date:   Mon,  3 Feb 2020 15:00:27 -0500
Message-Id: <20200203200029.4592-4-vgoyal@redhat.com>
In-Reply-To: <20200203200029.4592-1-vgoyal@redhat.com>
References: <20200203200029.4592-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch adds support for dax zero_page_range operation to dm targets.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 drivers/md/dm-linear.c        | 18 ++++++++++++++++++
 drivers/md/dm-log-writes.c    | 17 +++++++++++++++++
 drivers/md/dm-stripe.c        | 23 +++++++++++++++++++++++
 drivers/md/dm.c               | 30 ++++++++++++++++++++++++++++++
 include/linux/device-mapper.h |  3 +++
 5 files changed, 91 insertions(+)

diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 8d07fdf63a47..a6db998f0264 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -201,10 +201,27 @@ static size_t linear_dax_copy_to_iter(struct dm_tar=
get *ti, pgoff_t pgoff,
 	return dax_copy_to_iter(dax_dev, pgoff, addr, bytes, i);
 }
=20
+static int linear_dax_zero_page_range(struct dm_target *ti, pgoff_t pgof=
f,
+		unsigned offset, size_t len)
+{
+	int ret;
+	struct linear_c *lc =3D ti->private;
+	struct block_device *bdev =3D lc->dev->bdev;
+	struct dax_device *dax_dev =3D lc->dev->dax_dev;
+	sector_t dev_sector, sector =3D pgoff * PAGE_SECTORS;
+
+	dev_sector =3D linear_map_sector(ti, sector);
+	ret =3D bdev_dax_pgoff(bdev, dev_sector, ALIGN(len, PAGE_SIZE), &pgoff)=
;
+	if (ret)
+		return ret;
+	return dax_zero_page_range(dax_dev, pgoff, offset, len);
+}
+
 #else
 #define linear_dax_direct_access NULL
 #define linear_dax_copy_from_iter NULL
 #define linear_dax_copy_to_iter NULL
+#define linear_dax_zero_page_range NULL
 #endif
=20
 static struct target_type linear_target =3D {
@@ -226,6 +243,7 @@ static struct target_type linear_target =3D {
 	.direct_access =3D linear_dax_direct_access,
 	.dax_copy_from_iter =3D linear_dax_copy_from_iter,
 	.dax_copy_to_iter =3D linear_dax_copy_to_iter,
+	.dax_zero_page_range =3D linear_dax_zero_page_range,
 };
=20
 int __init dm_linear_init(void)
diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
index 99721c76225d..be20605f7544 100644
--- a/drivers/md/dm-log-writes.c
+++ b/drivers/md/dm-log-writes.c
@@ -994,10 +994,26 @@ static size_t log_writes_dax_copy_to_iter(struct dm=
_target *ti,
 	return dax_copy_to_iter(lc->dev->dax_dev, pgoff, addr, bytes, i);
 }
=20
+static int log_writes_dax_zero_page_range(struct dm_target *ti,
+					  pgoff_t pgoff, unsigned offset,
+					  size_t len)
+{
+	int ret;
+	struct log_writes_c *lc =3D ti->private;
+	sector_t sector =3D pgoff * PAGE_SECTORS;
+
+	ret =3D bdev_dax_pgoff(lc->dev->bdev, sector, ALIGN(len, PAGE_SIZE),
+			     &pgoff);
+	if (ret)
+		return ret;
+	return dax_zero_page_range(lc->dev->dax_dev, pgoff, offset, len);
+}
+
 #else
 #define log_writes_dax_direct_access NULL
 #define log_writes_dax_copy_from_iter NULL
 #define log_writes_dax_copy_to_iter NULL
+#define log_writes_dax_zero_page_range NULL
 #endif
=20
 static struct target_type log_writes_target =3D {
@@ -1016,6 +1032,7 @@ static struct target_type log_writes_target =3D {
 	.direct_access =3D log_writes_dax_direct_access,
 	.dax_copy_from_iter =3D log_writes_dax_copy_from_iter,
 	.dax_copy_to_iter =3D log_writes_dax_copy_to_iter,
+	.dax_zero_page_range =3D log_writes_dax_zero_page_range,
 };
=20
 static int __init dm_log_writes_init(void)
diff --git a/drivers/md/dm-stripe.c b/drivers/md/dm-stripe.c
index 63bbcc20f49a..8ad3c956efbf 100644
--- a/drivers/md/dm-stripe.c
+++ b/drivers/md/dm-stripe.c
@@ -360,10 +360,32 @@ static size_t stripe_dax_copy_to_iter(struct dm_tar=
get *ti, pgoff_t pgoff,
 	return dax_copy_to_iter(dax_dev, pgoff, addr, bytes, i);
 }
=20
+static int stripe_dax_zero_page_range(struct dm_target *ti, pgoff_t pgof=
f,
+				      unsigned offset, size_t len)
+{
+	int ret;
+	sector_t dev_sector, sector =3D pgoff * PAGE_SECTORS;
+	struct stripe_c *sc =3D ti->private;
+	struct dax_device *dax_dev;
+	struct block_device *bdev;
+	uint32_t stripe;
+
+	stripe_map_sector(sc, sector, &stripe, &dev_sector);
+	dev_sector +=3D sc->stripe[stripe].physical_start;
+	dax_dev =3D sc->stripe[stripe].dev->dax_dev;
+	bdev =3D sc->stripe[stripe].dev->bdev;
+
+	ret =3D bdev_dax_pgoff(bdev, dev_sector, ALIGN(len, PAGE_SIZE), &pgoff)=
;
+	if (ret)
+		return ret;
+	return dax_zero_page_range(dax_dev, pgoff, offset, len);
+}
+
 #else
 #define stripe_dax_direct_access NULL
 #define stripe_dax_copy_from_iter NULL
 #define stripe_dax_copy_to_iter NULL
+#define stripe_dax_zero_page_range NULL
 #endif
=20
 /*
@@ -486,6 +508,7 @@ static struct target_type stripe_target =3D {
 	.direct_access =3D stripe_dax_direct_access,
 	.dax_copy_from_iter =3D stripe_dax_copy_from_iter,
 	.dax_copy_to_iter =3D stripe_dax_copy_to_iter,
+	.dax_zero_page_range =3D stripe_dax_zero_page_range,
 };
=20
 int __init dm_stripe_init(void)
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index e8f9661a10a1..4605d30dad60 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1198,6 +1198,35 @@ static size_t dm_dax_copy_to_iter(struct dax_devic=
e *dax_dev, pgoff_t pgoff,
 	return ret;
 }
=20
+static int dm_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pg=
off,
+				  unsigned offset, size_t len)
+{
+	struct mapped_device *md =3D dax_get_private(dax_dev);
+	sector_t sector =3D pgoff * PAGE_SECTORS;
+	struct dm_target *ti;
+	int ret =3D -EIO;
+	int srcu_idx;
+
+	ti =3D dm_dax_get_live_target(md, sector, &srcu_idx);
+
+	if (!ti)
+		goto out;
+	if (WARN_ON(!ti->type->dax_zero_page_range)) {
+		/*
+		 * ->zero_page_range() is mandatory dax operation. If we are
+		 *  here, something is wrong.
+		 */
+		dm_put_live_table(md, srcu_idx);
+		goto out;
+	}
+	ret =3D ti->type->dax_zero_page_range(ti, pgoff, offset, len);
+
+ out:
+	dm_put_live_table(md, srcu_idx);
+
+	return ret;
+}
+
 /*
  * A target may call dm_accept_partial_bio only from the map routine.  I=
t is
  * allowed for all bio types except REQ_PREFLUSH, REQ_OP_ZONE_RESET,
@@ -3194,6 +3223,7 @@ static const struct dax_operations dm_dax_ops =3D {
 	.dax_supported =3D dm_dax_supported,
 	.copy_from_iter =3D dm_dax_copy_from_iter,
 	.copy_to_iter =3D dm_dax_copy_to_iter,
+	.zero_page_range =3D dm_dax_zero_page_range,
 };
=20
 /*
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.=
h
index 475668c69dbc..04009accf819 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -141,6 +141,8 @@ typedef long (*dm_dax_direct_access_fn) (struct dm_ta=
rget *ti, pgoff_t pgoff,
 		long nr_pages, void **kaddr, pfn_t *pfn);
 typedef size_t (*dm_dax_copy_iter_fn)(struct dm_target *ti, pgoff_t pgof=
f,
 		void *addr, size_t bytes, struct iov_iter *i);
+typedef int (*dm_dax_zero_page_range_fn)(struct dm_target *ti, pgoff_t p=
goff,
+		unsigned, size_t len);
 #define PAGE_SECTORS (PAGE_SIZE / 512)
=20
 void dm_error(const char *message);
@@ -195,6 +197,7 @@ struct target_type {
 	dm_dax_direct_access_fn direct_access;
 	dm_dax_copy_iter_fn dax_copy_from_iter;
 	dm_dax_copy_iter_fn dax_copy_to_iter;
+	dm_dax_zero_page_range_fn dax_zero_page_range;
=20
 	/* For internal device-mapper use. */
 	struct list_head list;
--=20
2.18.1

