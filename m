Return-Path: <linux-fsdevel+bounces-73821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 46290D215BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 22:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CBF13031798
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 21:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB866362131;
	Wed, 14 Jan 2026 21:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpvHmTlk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873D53624BE
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 21:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768426504; cv=none; b=C6yMkEiYPJ0eBZSm1mJfvOc+CgT14amFxGbnWSrWlhCZQKD+cVTXH0EjAlPwTdHQMh0jjwDXxDmzRYXjQKNols6m7bugwyAEW7AfGLnd6wqqk5wywDpyx1iUUoDAFF8/pDCTP/vSxlM59IJHvLW96wgNeCt17e+rYKu9IXPOcSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768426504; c=relaxed/simple;
	bh=VJhZh7W86znk6T4YU4zDAnr6xplKZCmyhBUSPOyJHg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YO7fzCaFKoBEWmcJuI1WLoeZVvZ7d6siCsUPu9m9lfwzClBtc0IkXnIbX5r5prxA3xNaApNhJWEP175E/Q3FwKcr7GRzNQ94wymIOHqYbN3kcAdHtebuKadX7OP9bI/Ig0PymIq2R2AruydC3Mf2e/XBmBtnvjodkTTUiGYneS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpvHmTlk; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7c78d30649aso187531a34.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 13:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768426497; x=1769031297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZsKBgwQfRTYfl5tr8Q6BwcIVeayQIJR9+JPKX7ldDM=;
        b=EpvHmTlkd4h43mRZ/zud+Xdm6bUE6hs/6lONcTdqZt98vIpx7ZNhOhP7gcZz4Qfis3
         I+RwfhEtdQ3zRZAXEBaQxpVWPw8NGx8D36u3WYoRvMn0mxbGQuAIo94V1RM1LM+DPQhs
         lwLbFi+ohtx1uSjXVrKDp9hI4KGs1OxXyleaZ9RFNhaeJJRaSnHU3TiIDYNZY5Cj8hKI
         423LISk6X9Yo4IGOLgJ4KrfPmrDQxMLVrEPlkzHWODTA4iqY6CJtMQx9vltbMhmJACTr
         /0tDyyrUzeI4pJ+YBqonvFKy5bzLa6yy+iQ/7hGO8pAW6GhfjoF2rseTast8sbx1V/jY
         FlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768426497; x=1769031297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vZsKBgwQfRTYfl5tr8Q6BwcIVeayQIJR9+JPKX7ldDM=;
        b=QrqG2RwcRf9AE0xEZaiqazwdlINQdNUiIkdDeQUaWDs/wuTDVpu3LFoTUpmswaOcz4
         r/LOnJS/iZQ862C0niINK2AuXX1m9Z8LnWJE7e1nLpzStjwBwrwuQjI823BPQEbQQTWL
         WMrMy3Y73hdUQaCP9ekm16j5ZPjrYFMNk6OPn3YnNtJElXhMzLTzS/pvRX/g3wqL4eEA
         qk33W9BHuMWMAmLFIDQurYtzrv2adrXXOfZDzo1GrdWvnUbe5iDryK9SYbUXVD0I/ZP1
         Eh9hLoqTqIwf8X/bXcIHofGGbHTu8CfC98bv7sjjH85yecP0Ke4puaq3S/6ZijmD7fjs
         mRlQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3l5skXLyddoqVFz7PaoV2WfRs71X16simGDMIejtirIM3lV6FnP+ITIzojnqgjTDd33Edu/EpQyFqyU14@vger.kernel.org
X-Gm-Message-State: AOJu0YzlxI2kJj0/A7pIh+dh6++UyvHwsQ7WYDfGrBWR2LV5tQeGcSWi
	r7qp+fLcbLze8ev/Y4LaK4fNTnEFydIsPamHH5tmmeeYKRYoXNBVUy7J
X-Gm-Gg: AY/fxX74By+HIbLXtYuXaS7AK5Z2Iwnu5A9nVv6CAWv0/7Wzzfq6iy5oj/dhUF4R8pl
	isFnz/7Ubt7jTZY5PFuBqm4IYbzyfpZEBfhCCYd9SftYlRwdDqZxKEU2dGS7qgrQAHBbb/kqFxd
	N1An05emeKOaZD+uVrS4rUKPLBOYQYtbSIK6zL4U0PM86AcAsGRylxeeohoFDaXLkmZO3oRimtT
	xUhrju3t2te+OSc5euB4Xsi3qiV2ToG9kTRY24VotW70Fi1tcDXMvYK6yc098ddqPiQAAkFVLMf
	rNvm3ilR9/mQ7q+KeNvq3UFoF7ExVL3gNcQt1pCn0tkmNMkHpwepJGP/7AzGEvI2eEIcHre6hwz
	WMlm68A1joq7KcVAb3pXMsM1mknyS3CZFbNjbsNa5Pd+kR98TUZVhoUyB2SPBQcGYJuCjN1PlgM
	AIMNDIHEm7+6KDtLGsoEgXcBqRbbTepMxueU7aoYNRHnzmVu+dZqWydbI=
X-Received: by 2002:a05:6830:4124:b0:7cf:d18e:706e with SMTP id 46e09a7af769-7cfd18e7074mr1365370a34.5.1768426497284;
        Wed, 14 Jan 2026 13:34:57 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:4c85:2962:e438:72c4])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfd447151csm542661a34.14.2026.01.14.13.34.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Jan 2026 13:34:56 -0800 (PST)
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
Subject: [PATCH V4 05/19] dax: Add dax_operations for use by fs-dax on fsdev dax
Date: Wed, 14 Jan 2026 15:31:52 -0600
Message-ID: <20260114213209.29453-6-john@groves.net>
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

From: John Groves <John@Groves.net>

fsdev: Add dax_operations for use by famfs

- These methods are based on pmem_dax_ops from drivers/nvdimm/pmem.c
- fsdev_dax_direct_access() returns the hpa, pfn and kva. The kva was
  newly stored as dev_dax->virt_addr by dev_dax_probe().
- The hpa/pfn are used for mmap (dax_iomap_fault()), and the kva is used
  for read/write (dax_iomap_rw())
- fsdev_dax_recovery_write() and dev_dax_zero_page_range() have not been
  tested yet. I'm looking for suggestions as to how to test those.
- dax-private.h: add dev_dax->cached_size, which fsdev needs to
  remember. The dev_dax size cannot change while a driver is bound
  (dev_dax_resize returns -EBUSY if dev->driver is set). Caching the size
  at probe time allows fsdev's direct_access path can use it without
  acquiring dax_dev_rwsem (which isn't exported anyway).

Signed-off-by: John Groves <john@groves.net>
---
 drivers/dax/dax-private.h |  1 +
 drivers/dax/fsdev.c       | 80 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index f3cf0a664f1b..164dd5b9d933 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -86,6 +86,7 @@ struct dev_dax {
 	struct dax_region *region;
 	struct dax_device *dax_dev;
 	void *virt_addr;
+	u64 cached_size;
 	unsigned int align;
 	int target_node;
 	bool dyn_id;
diff --git a/drivers/dax/fsdev.c b/drivers/dax/fsdev.c
index 72f78f606e06..f58c88de7a4d 100644
--- a/drivers/dax/fsdev.c
+++ b/drivers/dax/fsdev.c
@@ -28,6 +28,81 @@
  * - No mmap support - all access is through fs-dax/iomap
  */
 
+static void fsdev_write_dax(void *pmem_addr, struct page *page,
+		unsigned int off, unsigned int len)
+{
+	while (len) {
+		void *mem = kmap_local_page(page);
+		unsigned int chunk = min_t(unsigned int, len, PAGE_SIZE - off);
+
+		memcpy_flushcache(pmem_addr, mem + off, chunk);
+		kunmap_local(mem);
+		len -= chunk;
+		off = 0;
+		page++;
+		pmem_addr += chunk;
+	}
+}
+
+static long __fsdev_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
+			long nr_pages, enum dax_access_mode mode, void **kaddr,
+			unsigned long *pfn)
+{
+	struct dev_dax *dev_dax = dax_get_private(dax_dev);
+	size_t size = nr_pages << PAGE_SHIFT;
+	size_t offset = pgoff << PAGE_SHIFT;
+	void *virt_addr = dev_dax->virt_addr + offset;
+	phys_addr_t phys;
+	unsigned long local_pfn;
+
+	WARN_ON(!dev_dax->virt_addr);
+
+	phys = dax_pgoff_to_phys(dev_dax, pgoff, nr_pages << PAGE_SHIFT);
+
+	if (kaddr)
+		*kaddr = virt_addr;
+
+	local_pfn = PHYS_PFN(phys);
+	if (pfn)
+		*pfn = local_pfn;
+
+	/*
+	 * Use cached_size which was computed at probe time. The size cannot
+	 * change while the driver is bound (resize returns -EBUSY).
+	 */
+	return PHYS_PFN(min(size, dev_dax->cached_size - offset));
+}
+
+static int fsdev_dax_zero_page_range(struct dax_device *dax_dev,
+			pgoff_t pgoff, size_t nr_pages)
+{
+	void *kaddr;
+
+	WARN_ONCE(nr_pages > 1, "%s: nr_pages > 1\n", __func__);
+	__fsdev_dax_direct_access(dax_dev, pgoff, 1, DAX_ACCESS, &kaddr, NULL);
+	fsdev_write_dax(kaddr, ZERO_PAGE(0), 0, PAGE_SIZE);
+	return 0;
+}
+
+static long fsdev_dax_direct_access(struct dax_device *dax_dev,
+		  pgoff_t pgoff, long nr_pages, enum dax_access_mode mode,
+		  void **kaddr, unsigned long *pfn)
+{
+	return __fsdev_dax_direct_access(dax_dev, pgoff, nr_pages, mode,
+					 kaddr, pfn);
+}
+
+static size_t fsdev_dax_recovery_write(struct dax_device *dax_dev, pgoff_t pgoff,
+		void *addr, size_t bytes, struct iov_iter *i)
+{
+	return _copy_from_iter_flushcache(addr, bytes, i);
+}
+
+static const struct dax_operations dev_dax_ops = {
+	.direct_access = fsdev_dax_direct_access,
+	.zero_page_range = fsdev_dax_zero_page_range,
+	.recovery_write = fsdev_dax_recovery_write,
+};
 
 static void fsdev_cdev_del(void *cdev)
 {
@@ -163,6 +238,11 @@ static int fsdev_dax_probe(struct dev_dax *dev_dax)
 		}
 	}
 
+	/* Cache size now; it cannot change while driver is bound */
+	dev_dax->cached_size = 0;
+	for (i = 0; i < dev_dax->nr_range; i++)
+		dev_dax->cached_size += range_len(&dev_dax->ranges[i].range);
+
 	/*
 	 * FS-DAX compatible mode: Use MEMORY_DEVICE_FS_DAX type and
 	 * do NOT set vmemmap_shift. This leaves folios at order-0,
-- 
2.52.0


