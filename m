Return-Path: <linux-fsdevel+bounces-73823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 520B7D215DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 22:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91B723042748
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 21:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF86A37417A;
	Wed, 14 Jan 2026 21:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUA2yd3S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB33236C5AF
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 21:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768426586; cv=none; b=DR3LTqcUAiBUQOu9tndPhe+TPV14KxmcYXaH33E1lEZlqZgYiuSs9L8Pz0nyN2PY4Aq8FCFiINVvxD1TsQ1L/703390eXZgRHnjspFYJdvTS1GacX18ILcR9ERwBSv0GmzvTKJD9gWnmE+mhkZAyP7eRia9i0DYT+8EQy2Aa2Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768426586; c=relaxed/simple;
	bh=RJs5dBBAWuOxqEEVBB1HCtYboJ+JS3oCwl7NKWs84IM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pnmC5BWrOtHXHJ9SRfig8aBM7JaOHdK9E2QY3xqaDhMbSGs8S65Q2ROGSBim84SiJqhPu4rS/HSgVWFWilUuten1t5B+Rwens4l1CT6Zn5STdQ+KcZe3ZO6rA31AdRgoM1Btyi2j7wp90ZW0xBPlUCyobvSKHvoNh7w6r3Z2ghA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUA2yd3S; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7cdd651c884so169232a34.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 13:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768426562; x=1769031362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHr6a06dT/VqhW8Rq+1vjbEURwj0h9cjtIZdXyvuQJA=;
        b=KUA2yd3Sy/4pN0SwaHe/Tc1SVJTmAE2s5qNTCn10qsOKrR1OcqQ6PV7RH9T99njJpC
         Dw9XlFS3SbzSYgud6nMrAwzAeQQU3JB05ZoZxBOGxGQWdFh0Gor7Dm8XEbheySdLtLPV
         0b+DlcceYvx7Ehgsu0SYru2z+7+9cTJNeOTCldpvNScWmAWs98aKsSgJ4pojBv67ke1T
         o9Ez2nSzDVQuPx+qSbXbfe+heAS9oKaDK2coUCw3hG4cpI8qpW+Y7aSLTWYAPm/PCplr
         Lr/uJfqZDHrbVnaHKvWMpCiTbR4ca6zZ/4N2Jsr/tDt6Bwn2WeCrXkRwYStGCnlu9CGE
         pFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768426562; x=1769031362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BHr6a06dT/VqhW8Rq+1vjbEURwj0h9cjtIZdXyvuQJA=;
        b=OXYvQRZVoHAT62HUpPUbMvoHoufCqZsxJz4fmr9TLsQ+kO9X9zD0TXnGg1iP8UYMWI
         pDVMtVrZCd3xVhdJbR//TlBvJpJIsnKPeNGChmR6Ob0OA3CWCp+9vs8w9uAQd8gbjBTV
         vWiWtlvCjUuelgV6XR92ugRcSWAul/Ekt1NxGYxZZthhyXJu2zSkzICnV4poDAA5igNs
         2/ceVr8BFzWL8n8Sig13AW2s2VQZ+mjV2TmJ3d3ECVMEuV+v2EtRzJ1/wihee3fttkaC
         z81XeNJB8nxG+qYsISzSBB2fUVbOc/h5I8XHLeNGF/yZ+zn4+oHzwW2+6QRnCBGlVv8K
         UqEw==
X-Forwarded-Encrypted: i=1; AJvYcCWkEzlZDSQdp98XE4ff6TE+Tczo1jGQIZvwAgVC/ts/HS2wiVA/LmTacswajEE5ymX7spJGUvfKOgt4efSk@vger.kernel.org
X-Gm-Message-State: AOJu0YwrtH9U8iRPmU8IPuYDMe079ptaeHt1fjR5LJLq8At0vhhRxOFo
	PZt2Z5RJcxcFoZEWYqr9LaQ1xDORb7Aje4Mr/NqzsZ26IrPYhKNB+gwo
X-Gm-Gg: AY/fxX4rpSSr8//EvVpsi6Ay//vJQx0W5RZicM1ujSmBFVqNQrCeQXu4ZD5XAsyNGj9
	p7SZ9JheVG3tEpiMZMvx9zcHBWzBnJDkOC08fj4eqHfCdOT9Dw9hhiU80vlm0EHFXWdceoY1bWd
	HKEdDX6UcBZFo+0mvye+2FNvig2g9A5w6zeRmSdW2akhLlzzmR+0Y5CcDymRmuCIi6D045FkRK5
	UuG51ROGDdajjhhQNIYJbqoPVMX8vvy3fcprutPCBYx1FpGMVtdEVh+XPwzlGliaSxetWCsoMJQ
	O+ig9fj+krpiI+vELn+adg+VO6/jCUR0MzOxp7tXoBNJ/Ubs+dmg4MVb6AS9Wh54ITZF7RK/JUZ
	plcmfVxk0qJtSMVtfEoALDOSGDkU3GWTKjq4tjBd5Tng5DGJThZxR6Yh+XPOtcP3Em6gHfGv3hD
	UsQrT+WXuPIrHOzBtAZHrVgq1BBeKg2qYqreVzsp0bGjnq
X-Received: by 2002:a05:6830:3c06:b0:7c7:7f85:d19 with SMTP id 46e09a7af769-7cfd46192a9mr560960a34.8.1768426562527;
        Wed, 14 Jan 2026 13:36:02 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:4c85:2962:e438:72c4])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce4781c43asm18703055a34.7.2026.01.14.13.36.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Jan 2026 13:36:02 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <John@Groves.net>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Dan Williams <dan.j.williams@intel.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alison Schofield <alison.schofield@intel.com>
Cc: John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	David Hildenbrand <david@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	James Morse <james.morse@arm.com>,
	Fuad Tabba <tabba@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Shivank Garg <shivankg@amd.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Gregory Price <gourry@gourry.net>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	venkataravis@micron.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH V4 07/19] dax: Add fs_dax_get() func to prepare dax for fs-dax usage
Date: Wed, 14 Jan 2026 15:31:54 -0600
Message-ID: <20260114213209.29453-8-john@groves.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114213209.29453-1-john@groves.net>
References: <20260114153133.29420.compound@groves.net>
 <20260114213209.29453-1-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fs_dax_get() function should be called by fs-dax file systems after
opening a fsdev dax device. This adds holder_operations, which provides
a memory failure callback path and effects exclusivity between callers
of fs_dax_get().

fs_dax_get() is specific to fsdev_dax, so it checks the driver type
(which required touching bus.[ch]). fs_dax_get() fails if fsdev_dax is
not bound to the memory.

This function serves the same role as fs_dax_get_by_bdev(), which dax
file systems call after opening the pmem block device.

This can't be located in fsdev.c because struct dax_device is opaque
there.

This will be called by fs/fuse/famfs.c in a subsequent commit.

Signed-off-by: John Groves <john@groves.net>
---
 drivers/dax/bus.c   |  2 --
 drivers/dax/bus.h   |  2 ++
 drivers/dax/super.c | 58 ++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/dax.h | 20 ++++++++++------
 4 files changed, 72 insertions(+), 10 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index e79daf825b52..01402d5103ef 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -39,8 +39,6 @@ static int dax_bus_uevent(const struct device *dev, struct kobj_uevent_env *env)
 	return add_uevent_var(env, "MODALIAS=" DAX_DEVICE_MODALIAS_FMT, 0);
 }
 
-#define to_dax_drv(__drv)	container_of_const(__drv, struct dax_device_driver, drv)
-
 static struct dax_id *__dax_match_id(const struct dax_device_driver *dax_drv,
 		const char *dev_name)
 {
diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
index 880bdf7e72d7..dc6f112ac4a4 100644
--- a/drivers/dax/bus.h
+++ b/drivers/dax/bus.h
@@ -42,6 +42,8 @@ struct dax_device_driver {
 	void (*remove)(struct dev_dax *dev);
 };
 
+#define to_dax_drv(__drv) container_of_const(__drv, struct dax_device_driver, drv)
+
 int __dax_driver_register(struct dax_device_driver *dax_drv,
 		struct module *module, const char *mod_name);
 #define dax_driver_register(driver) \
diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index ba0b4cd18a77..00c330ef437c 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -14,6 +14,7 @@
 #include <linux/fs.h>
 #include <linux/cacheinfo.h>
 #include "dax-private.h"
+#include "bus.h"
 
 /**
  * struct dax_device - anchor object for dax services
@@ -111,6 +112,10 @@ struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev, u64 *start_off,
 }
 EXPORT_SYMBOL_GPL(fs_dax_get_by_bdev);
 
+#endif /* CONFIG_BLOCK && CONFIG_FS_DAX */
+
+#if IS_ENABLED(CONFIG_FS_DAX)
+
 void fs_put_dax(struct dax_device *dax_dev, void *holder)
 {
 	if (dax_dev && holder &&
@@ -119,7 +124,58 @@ void fs_put_dax(struct dax_device *dax_dev, void *holder)
 	put_dax(dax_dev);
 }
 EXPORT_SYMBOL_GPL(fs_put_dax);
-#endif /* CONFIG_BLOCK && CONFIG_FS_DAX */
+
+/**
+ * fs_dax_get() - get ownership of a devdax via holder/holder_ops
+ *
+ * fs-dax file systems call this function to prepare to use a devdax device for
+ * fsdax. This is like fs_dax_get_by_bdev(), but the caller already has struct
+ * dev_dax (and there is no bdev). The holder makes this exclusive.
+ *
+ * @dax_dev: dev to be prepared for fs-dax usage
+ * @holder: filesystem or mapped device inside the dax_device
+ * @hops: operations for the inner holder
+ *
+ * Returns: 0 on success, <0 on failure
+ */
+int fs_dax_get(struct dax_device *dax_dev, void *holder,
+	const struct dax_holder_operations *hops)
+{
+	struct dev_dax *dev_dax;
+	struct dax_device_driver *dax_drv;
+	int id;
+
+	id = dax_read_lock();
+	if (!dax_dev || !dax_alive(dax_dev) || !igrab(&dax_dev->inode)) {
+		dax_read_unlock(id);
+		return -ENODEV;
+	}
+	dax_read_unlock(id);
+
+	/* Verify the device is bound to fsdev_dax driver */
+	dev_dax = dax_get_private(dax_dev);
+	if (!dev_dax || !dev_dax->dev.driver) {
+		iput(&dax_dev->inode);
+		return -ENODEV;
+	}
+
+	dax_drv = to_dax_drv(dev_dax->dev.driver);
+	if (dax_drv->type != DAXDRV_FSDEV_TYPE) {
+		iput(&dax_dev->inode);
+		return -EOPNOTSUPP;
+	}
+
+	if (cmpxchg(&dax_dev->holder_data, NULL, holder)) {
+		iput(&dax_dev->inode);
+		return -EBUSY;
+	}
+
+	dax_dev->holder_ops = hops;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fs_dax_get);
+#endif /* CONFIG_FS_DAX */
 
 enum dax_device_flags {
 	/* !alive + rcu grace period == no new operations / mappings */
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 5aaaca135737..6897c5736543 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -52,9 +52,6 @@ struct dax_holder_operations {
 #if IS_ENABLED(CONFIG_DAX)
 struct dax_device *alloc_dax(void *private, const struct dax_operations *ops);
 
-#if IS_ENABLED(CONFIG_DEV_DAX_FS)
-struct dax_device *inode_dax(struct inode *inode);
-#endif
 void *dax_holder(struct dax_device *dax_dev);
 void put_dax(struct dax_device *dax_dev);
 void kill_dax(struct dax_device *dax_dev);
@@ -134,7 +131,6 @@ int dax_add_host(struct dax_device *dax_dev, struct gendisk *disk);
 void dax_remove_host(struct gendisk *disk);
 struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev, u64 *start_off,
 		void *holder, const struct dax_holder_operations *ops);
-void fs_put_dax(struct dax_device *dax_dev, void *holder);
 #else
 static inline int dax_add_host(struct dax_device *dax_dev, struct gendisk *disk)
 {
@@ -149,12 +145,13 @@ static inline struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev,
 {
 	return NULL;
 }
-static inline void fs_put_dax(struct dax_device *dax_dev, void *holder)
-{
-}
 #endif /* CONFIG_BLOCK && CONFIG_FS_DAX */
 
 #if IS_ENABLED(CONFIG_FS_DAX)
+void fs_put_dax(struct dax_device *dax_dev, void *holder);
+int fs_dax_get(struct dax_device *dax_dev, void *holder,
+	       const struct dax_holder_operations *hops);
+struct dax_device *inode_dax(struct inode *inode);
 int dax_writeback_mapping_range(struct address_space *mapping,
 		struct dax_device *dax_dev, struct writeback_control *wbc);
 int dax_folio_reset_order(struct folio *folio);
@@ -168,6 +165,15 @@ dax_entry_t dax_lock_mapping_entry(struct address_space *mapping,
 void dax_unlock_mapping_entry(struct address_space *mapping,
 		unsigned long index, dax_entry_t cookie);
 #else
+static inline void fs_put_dax(struct dax_device *dax_dev, void *holder)
+{
+}
+
+static inline int fs_dax_get(struct dax_device *dax_dev, void *holder,
+			     const struct dax_holder_operations *hops)
+{
+	return -EOPNOTSUPP;
+}
 static inline struct page *dax_layout_busy_page(struct address_space *mapping)
 {
 	return NULL;
-- 
2.52.0


