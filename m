Return-Path: <linux-fsdevel+bounces-72641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E5621CFF616
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 19:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B122E3329BAD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 17:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D397318EC6;
	Wed,  7 Jan 2026 15:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYZfh877"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76463B8D59
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 15:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767800039; cv=none; b=j7wIou2dQp7zVJzPnN9cyFnXLUGmh58JqyFK0kXVhb8SA4nbkDTCW5gSSzS6pCdhENQ1jkZ3PrpyhZxDStrH+RLx0836qluMgMonLt2ecAgwZ5WgKM7l0xweZkcpPboLaQl2oauY0TMV4Cr5/DmoOVMH90yv3B8ATUmNgPp1hH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767800039; c=relaxed/simple;
	bh=Z9XPB5cChIo/t/9LU2WCPFfPnMA+oTk5cMf0x2oZ3bQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPa1jFLGnSOvyMKh3SQpI39zo/+nzVKf458TXUVZoIPmY/3i2nLMhNl8QA5EpzKEyrQ9b7+GsUV0BnLRcftQMLRgmUvvnQMRbqPv2DHHnuRUzX/Bi7auX7BQEhGoc5eVr2Gl/72VimGi+0b40OrAnnB8A6ZPO+TvHY4DRv4YgKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYZfh877; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-450ac3ed719so1400551b6e.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jan 2026 07:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767800036; x=1768404836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlFXJUauQcVO7MpBSFt3XLVu48darYU11J/SZXzaKDg=;
        b=jYZfh877RReMmfFRD6GWP3bQzt1ANjBRZGVIUOLvyUfx9OnJZG/H1IeyRu+MhrLzRQ
         23u/9qutVr5C00CfshrsMxHls3MQCfG1ReI2Gst4aqyPyo9sQ7Um/VmitCMnFh+QXkR3
         FfY+GEqtWmwwLT8/zv/57whvbIV4yGUyJ60GtUA0//hbmft6k4TzTWzOxboL/aT2u18f
         +jc9RgK9PyGsaygo3mSg61TGLX1gvq/mTe5UhBk3cK4HcBWCYOjhS9CQ7ccWC5rR3tKH
         KPGAI3jaBPT14jjTxP8bwsB6RQwX/3Y9Ont8y49DbY1RD0VA5BGNqnLzgDzT08BNWTPx
         2oNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767800036; x=1768404836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OlFXJUauQcVO7MpBSFt3XLVu48darYU11J/SZXzaKDg=;
        b=L9VXC36hQxNarfEno6W+booaAmtRO6QfUA181WLZNAy3pJrBx7N8Vm5e7JqMJrVd3K
         a1UWFheIWTAmjr9V+W5YsgRj02BLS7ju7HEb2o+Hm7xQnQG1KeE6O7jhqSr8ybZFUdM6
         heDNJmRV1pHM6IzmhgI4wQ2hPIUVrF7GMffTfZRGXZYaFkWRsCcqV/9fp2SxIeLvlSVy
         USeu77gx3SSoQ3uwI5gl70GH12aAPIK6RKLHk4Xx9IzZozCx6AwzS9BRjko02c4W2HCZ
         u6fZr+nxMmBqpCNMP0Vbl6yWGHqUaLAvFqlNDhBK5BV/KRCspBzEEF7FThYN1hxFkWD1
         MGgg==
X-Forwarded-Encrypted: i=1; AJvYcCW5uN3/sBiV8w1hODO5SuLxDTxaTfk4BKIDSy7c2Upu1YXJaD2LCukdS09Ul/Feyz8aMcw/AH8WX/Niycq4@vger.kernel.org
X-Gm-Message-State: AOJu0YypZlL9sXwN1B4+l3cWPc1dInMbJqDlSq+p29iSkZ9i1gyapE4X
	IZMtEGP0/GI65hYuGvzL/NZYSWPDOjQrf58ksGWuH5nnMweqQC7ckhpR
X-Gm-Gg: AY/fxX5y03mdd3KbEbTd1YDvMlbyoQzd/g6UMXi2z8gw76tyzObWrq4Nc8aLdUJhvov
	08zW8PURQqwmS8XvJ4siOYneKYMShjsIGkz8HQTWqAXmbVNep9/7xP9PVEMeQIVzstlFaB3/x7E
	mIk3ibkiWfpNFJBxAOb+CgjQew8JvJTyaZwJ8yrnr5fAmCyZNIMGYYqbJX/i6HbLPIee71exm32
	u6ZFxkEiCq5jTzSU3qcc8g1R3hO0CwrnrHjQ/rsOVH475+n5XLqkw8OrXxWNuzSqdenblvu3Upb
	KfrGE7OXFuZKSa2RhjVNFHpvYzpNv2YNrMA0g9PP1L7CXrp9EA4LT+SBOkFUE6C8l/rD5BAZboU
	+J1AC+6jsafZbn9Utcyzte+5Kq1JgaujIHPetiXnqLQH524AjFdjAqz5s8nGD5QKutbK9x/iJ9n
	pZ1+8XzvcJLQWKW3/YRXDDzwD+7oioN03uCaI07eXN46zy
X-Google-Smtp-Source: AGHT+IGZ+SYDHTTG5p48tl+QB5iPnahkcLty5U9a8Qi/hJOxw+cPuomkuu2gZKHVriePbcQqcWrLVA==
X-Received: by 2002:a05:6808:221e:b0:43f:7287:a5de with SMTP id 5614622812f47-45a6bdfb427mr1080778b6e.41.1767800036459;
        Wed, 07 Jan 2026 07:33:56 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:a917:5124:7300:7cef])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e2f1de5sm2398106b6e.22.2026.01.07.07.33.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 07 Jan 2026 07:33:56 -0800 (PST)
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
	Chen Linxuan <chenlinxuan@uniontech.com>,
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
	linux-fsdevel@vger.kernel.org,
	John Groves <john@groves.net>
Subject: [PATCH V3 05/21] dax: Add dax_set_ops() for setting dax_operations at bind time
Date: Wed,  7 Jan 2026 09:33:14 -0600
Message-ID: <20260107153332.64727-6-john@groves.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260107153332.64727-1-john@groves.net>
References: <20260107153244.64703-1-john@groves.net>
 <20260107153332.64727-1-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: John Groves <John@Groves.net>

The dax_device is created (in the non-pmem case) at hmem probe time via
devm_create_dev_dax(), before we know which driver (device_dax,
fsdev_dax, or kmem) will bind - by calling alloc_dax() with NULL ops,
drivers (i.e. fsdev_dax) that need specific dax_operations must set
them later.

Add dax_set_ops() exported function so fsdev_dax can set its ops at
probe time and clear them on remove. device_dax doesn't need ops since
it uses the mmap fault path directly.

Use cmpxchg() to atomically set ops only if currently NULL, returning
-EBUSY if ops are already set. This prevents accidental double-binding.
Clearing ops (NULL) always succeeds.

Signed-off-by: John Groves <john@groves.net>
---
 drivers/dax/fsdev.c | 12 ++++++++++++
 drivers/dax/super.c | 38 +++++++++++++++++++++++++++++++++++++-
 include/linux/dax.h |  1 +
 3 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/fsdev.c b/drivers/dax/fsdev.c
index 9e2f83aa2584..3f4f593896e3 100644
--- a/drivers/dax/fsdev.c
+++ b/drivers/dax/fsdev.c
@@ -330,12 +330,24 @@ static int fsdev_dax_probe(struct dev_dax *dev_dax)
 	if (rc)
 		return rc;
 
+	/* Set the dax operations for fs-dax access path */
+	rc = dax_set_ops(dax_dev, &dev_dax_ops);
+	if (rc)
+		return rc;
+
 	run_dax(dax_dev);
 	return devm_add_action_or_reset(dev, fsdev_kill, dev_dax);
 }
 
+static void fsdev_dax_remove(struct dev_dax *dev_dax)
+{
+	/* Clear ops on unbind so they aren't used with a different driver */
+	dax_set_ops(dev_dax->dax_dev, NULL);
+}
+
 static struct dax_device_driver fsdev_dax_driver = {
 	.probe = fsdev_dax_probe,
+	.remove = fsdev_dax_remove,
 	.type = DAXDRV_FSDEV_TYPE,
 };
 
diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index c00b9dff4a06..ba0b4cd18a77 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -157,6 +157,9 @@ long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
 	if (!dax_alive(dax_dev))
 		return -ENXIO;
 
+	if (!dax_dev->ops)
+		return -EOPNOTSUPP;
+
 	if (nr_pages < 0)
 		return -EINVAL;
 
@@ -207,6 +210,10 @@ int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 
 	if (!dax_alive(dax_dev))
 		return -ENXIO;
+
+	if (!dax_dev->ops)
+		return -EOPNOTSUPP;
+
 	/*
 	 * There are no callers that want to zero more than one page as of now.
 	 * Once users are there, this check can be removed after the
@@ -223,7 +230,7 @@ EXPORT_SYMBOL_GPL(dax_zero_page_range);
 size_t dax_recovery_write(struct dax_device *dax_dev, pgoff_t pgoff,
 		void *addr, size_t bytes, struct iov_iter *iter)
 {
-	if (!dax_dev->ops->recovery_write)
+	if (!dax_dev->ops || !dax_dev->ops->recovery_write)
 		return 0;
 	return dax_dev->ops->recovery_write(dax_dev, pgoff, addr, bytes, iter);
 }
@@ -307,6 +314,35 @@ void set_dax_nomc(struct dax_device *dax_dev)
 }
 EXPORT_SYMBOL_GPL(set_dax_nomc);
 
+/**
+ * dax_set_ops - set the dax_operations for a dax_device
+ * @dax_dev: the dax_device to configure
+ * @ops: the operations to set (may be NULL to clear)
+ *
+ * This allows drivers to set the dax_operations after the dax_device
+ * has been allocated. This is needed when the device is created before
+ * the driver that needs specific ops is bound (e.g., fsdev_dax binding
+ * to a dev_dax created by hmem).
+ *
+ * When setting non-NULL ops, fails if ops are already set (returns -EBUSY).
+ * When clearing ops (NULL), always succeeds.
+ *
+ * Return: 0 on success, -EBUSY if ops already set
+ */
+int dax_set_ops(struct dax_device *dax_dev, const struct dax_operations *ops)
+{
+	if (ops) {
+		/* Setting ops: fail if already set */
+		if (cmpxchg(&dax_dev->ops, NULL, ops) != NULL)
+			return -EBUSY;
+	} else {
+		/* Clearing ops: always allowed */
+		dax_dev->ops = NULL;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dax_set_ops);
+
 bool dax_alive(struct dax_device *dax_dev)
 {
 	lockdep_assert_held(&dax_srcu);
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 74e098010016..3fcd8562b72b 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -246,6 +246,7 @@ static inline void dax_break_layout_final(struct inode *inode)
 
 bool dax_alive(struct dax_device *dax_dev);
 void *dax_get_private(struct dax_device *dax_dev);
+int dax_set_ops(struct dax_device *dax_dev, const struct dax_operations *ops);
 long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
 		enum dax_access_mode mode, void **kaddr, unsigned long *pfn);
 size_t dax_copy_from_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
-- 
2.49.0


