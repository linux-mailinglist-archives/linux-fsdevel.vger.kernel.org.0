Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D36419AF76
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Apr 2020 18:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbgDAQLg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Apr 2020 12:11:36 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38798 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726205AbgDAQLg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585757494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KCQVduOzYqeO0UI7AC7TozjgQwEuu7aRADaqvSOaujc=;
        b=iQuztXXfwNuOoeUwAFn/sCkbWztg0roK4BgSkaOfqA2gDYBonT8jACQ9FhgrF4QK7aojQS
        E5DlhLRPsKTvkMDntE6E/afiLiXFrG1p374M4276UOiaYdfGQAWHuw5jR8C0+QCSa06p5M
        cAJz5Nc4DQdapNGphHus/atw9NbtwmQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-yTPcPYSwN9K5iE6YgFMaDA-1; Wed, 01 Apr 2020 12:11:30 -0400
X-MC-Unique: yTPcPYSwN9K5iE6YgFMaDA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FF931005509;
        Wed,  1 Apr 2020 16:11:29 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-83.rdu2.redhat.com [10.10.115.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 833BE5C1A2;
        Wed,  1 Apr 2020 16:11:26 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id F1704220005; Wed,  1 Apr 2020 12:11:25 -0400 (EDT)
Date:   Wed, 1 Apr 2020 12:11:25 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        hch@infradead.org, dan.j.williams@intel.com
Cc:     david@fromorbit.com, jmoyer@redhat.com, dm-devel@redhat.com,
        gerald.schaefer@de.ibm.com
Subject: [PATCH v6 7/6] dax: Move mandatory ->zero_page_range() check in
 alloc_dax()
Message-ID: <20200401161125.GB9398@redhat.com>
References: <20200228163456.1587-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228163456.1587-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

zero_page_range() dax operation is mandatory for dax devices. Right now
that check happens in dax_zero_page_range() function. Dan thinks that's
too late and its better to do the check earlier in alloc_dax().

I also modified alloc_dax() to return pointer with error code in it in
case of failure. Right now it returns NULL and caller assumes failure
happened due to -ENOMEM. But with this ->zero_page_range() check, I
need to return -EINVAL instead.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 drivers/dax/bus.c            |    4 +++-
 drivers/dax/super.c          |   14 +++++++++-----
 drivers/md/dm.c              |    2 +-
 drivers/nvdimm/pmem.c        |    4 ++--
 drivers/s390/block/dcssblk.c |    5 +++--
 5 files changed, 18 insertions(+), 11 deletions(-)

Index: redhat-linux/drivers/dax/super.c
===================================================================
--- redhat-linux.orig/drivers/dax/super.c	2020-04-01 12:03:39.911439769 -0400
+++ redhat-linux/drivers/dax/super.c	2020-04-01 12:05:31.727439769 -0400
@@ -349,9 +349,6 @@ int dax_zero_page_range(struct dax_devic
 {
 	if (!dax_alive(dax_dev))
 		return -ENXIO;
-
-	if (!dax_dev->ops->zero_page_range)
-		return -EOPNOTSUPP;
 	/*
 	 * There are no callers that want to zero more than one page as of now.
 	 * Once users are there, this check can be removed after the
@@ -571,9 +568,16 @@ struct dax_device *alloc_dax(void *priva
 	dev_t devt;
 	int minor;
 
+	if (ops && !ops->zero_page_range) {
+		pr_debug("%s: error: device does not provide dax"
+			 " operation zero_page_range()\n",
+			 __host ? __host : "Unknown");
+		return ERR_PTR(-EINVAL);
+	}
+
 	host = kstrdup(__host, GFP_KERNEL);
 	if (__host && !host)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	minor = ida_simple_get(&dax_minor_ida, 0, MINORMASK+1, GFP_KERNEL);
 	if (minor < 0)
@@ -596,7 +600,7 @@ struct dax_device *alloc_dax(void *priva
 	ida_simple_remove(&dax_minor_ida, minor);
  err_minor:
 	kfree(host);
-	return NULL;
+	return ERR_PTR(-ENOMEM);
 }
 EXPORT_SYMBOL_GPL(alloc_dax);
 
Index: redhat-linux/drivers/nvdimm/pmem.c
===================================================================
--- redhat-linux.orig/drivers/nvdimm/pmem.c	2020-04-01 12:03:39.911439769 -0400
+++ redhat-linux/drivers/nvdimm/pmem.c	2020-04-01 12:05:31.729439769 -0400
@@ -487,9 +487,9 @@ static int pmem_attach_disk(struct devic
 	if (is_nvdimm_sync(nd_region))
 		flags = DAXDEV_F_SYNC;
 	dax_dev = alloc_dax(pmem, disk->disk_name, &pmem_dax_ops, flags);
-	if (!dax_dev) {
+	if (IS_ERR(dax_dev)) {
 		put_disk(disk);
-		return -ENOMEM;
+		return PTR_ERR(dax_dev);
 	}
 	dax_write_cache(dax_dev, nvdimm_has_cache(nd_region));
 	pmem->dax_dev = dax_dev;
Index: redhat-linux/drivers/dax/bus.c
===================================================================
--- redhat-linux.orig/drivers/dax/bus.c	2020-04-01 12:03:39.911439769 -0400
+++ redhat-linux/drivers/dax/bus.c	2020-04-01 12:05:31.729439769 -0400
@@ -421,8 +421,10 @@ struct dev_dax *__devm_create_dev_dax(st
 	 * device outside of mmap of the resulting character device.
 	 */
 	dax_dev = alloc_dax(dev_dax, NULL, NULL, DAXDEV_F_SYNC);
-	if (!dax_dev)
+	if (IS_ERR(dax_dev)) {
+		rc = PTR_ERR(dax_dev);
 		goto err;
+	}
 
 	/* a device_dax instance is dead while the driver is not attached */
 	kill_dax(dax_dev);
Index: redhat-linux/drivers/s390/block/dcssblk.c
===================================================================
--- redhat-linux.orig/drivers/s390/block/dcssblk.c	2020-04-01 12:03:39.911439769 -0400
+++ redhat-linux/drivers/s390/block/dcssblk.c	2020-04-01 12:05:31.730439769 -0400
@@ -695,8 +695,9 @@ dcssblk_add_store(struct device *dev, st
 
 	dev_info->dax_dev = alloc_dax(dev_info, dev_info->gd->disk_name,
 			&dcssblk_dax_ops, DAXDEV_F_SYNC);
-	if (!dev_info->dax_dev) {
-		rc = -ENOMEM;
+	if (IS_ERR(dev_info->dax_dev)) {
+		rc = PTR_ERR(dev_info->dax_dev);
+		dev_info->dax_dev = NULL;
 		goto put_dev;
 	}
 
Index: redhat-linux/drivers/md/dm.c
===================================================================
--- redhat-linux.orig/drivers/md/dm.c	2020-04-01 12:03:39.911439769 -0400
+++ redhat-linux/drivers/md/dm.c	2020-04-01 12:05:31.732439769 -0400
@@ -2005,7 +2005,7 @@ static struct mapped_device *alloc_dev(i
 	if (IS_ENABLED(CONFIG_DAX_DRIVER)) {
 		md->dax_dev = alloc_dax(md, md->disk->disk_name,
 					&dm_dax_ops, 0);
-		if (!md->dax_dev)
+		if (IS_ERR(md->dax_dev))
 			goto bad;
 	}
 

