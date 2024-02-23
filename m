Return-Path: <linux-fsdevel+bounces-12600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 901BF861A32
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 18:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40BBC288C16
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 17:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5821913F009;
	Fri, 23 Feb 2024 17:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRcfj1xF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0174C13EFEB;
	Fri, 23 Feb 2024 17:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710154; cv=none; b=bxmguQg/1Kpyf3LAXbcZcWc/CInhn3lKd/C480zZQzQ0UwxziKIAQvICFWAUNcvawmc0ukm/xvWOt7re9CoW6gGoI0E7IuLGAf3gt8HxR7jZ5blXA7YLJC/FeOXY1YPuG8G9WtJuokU4K+73+JKy6PO8RnufHmb/+tAvsWtJca4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710154; c=relaxed/simple;
	bh=ONsam/yo/NB0rVpRcPxD7RtX2OC7QDpgecXyPCxVYcI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pdhiTKmP/Q7FAME+mTA9wGIlB27jH1FHjdiTm4Ab+fbh/KkVzGoRnda+NgTAv7ORW1atg66LWhIKm3GjY4pkh+RM4cEUXiPzYE8xmhBdFTIs1OnnWMDP60+BeFtO4hcQPsisw2yEIQnC9U5pFhs8jrDJkVJkg2GZ5WABBpRFRFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRcfj1xF; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-21f8665908bso538164fac.3;
        Fri, 23 Feb 2024 09:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708710152; x=1709314952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+SPGnsXaoNSfbfuHnl0d9x2mOvuVC4g7NKkHxsyha0=;
        b=bRcfj1xFnVXHMgKI/6QVU3iZJqZyGE2ezlQlcZXuABP01z0RXN8NWzW3peZVe60uTH
         KWztEqkUj0LgaD14so7ko0BtSCdKUX+jQIiMPIt+fe3eLhmnxcA/rvIbDf1w45m3nlbm
         Zq1sbXmUb3eCgfQErPyQHNe4paXghI9vDvIrGw6aYIgUI5xFdL19doTeHzCQrUqSsa6q
         RheradwFQXn0u2GfJR1VeKZcvZZo+hhNWa+UNssbajXLXcbweD3Wtn1qHtZl3NagIW7B
         hKOi7NPMWK45k1EiFPf2TceoRw/GGdjBp8Kd15wFCz6ToytwDxEJjw2LgEp/do6kbiPe
         EJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708710152; x=1709314952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y+SPGnsXaoNSfbfuHnl0d9x2mOvuVC4g7NKkHxsyha0=;
        b=OoS42P6TncsLCurteAvRKm/n2PibpjCR5hih70q29s5BSY6GFVqhJb4lR86ExBywUA
         qv3kyIfTESoA1GJBD31yqzaEuT908ObfntCNGqGxFmd9A5nt4sRHOlFFL36fWtaEzrpk
         k6mViX0y7WVBO5pVNGbZy5X95Uyj3GFDDGMSPXeKD63i2u6U1O96XwcttswTAYM6c76l
         /NqFbMJoxVaHGxqp6YOdtmIrK82Ppe3Z8mv5Mep+6tH8B/iy7S7ANIN1BhpufPNxw3nF
         E1BPm1M4xNco9vD3vTUeWWzsVbACID423bQGQu6l65KPbs4JqysYZ6AQdJ0pY+za5mzA
         hFxw==
X-Forwarded-Encrypted: i=1; AJvYcCWzMnwf/RHx5p+RyTheMNifgRZLlGr8keKBUm9Rcba7FoH3/2J4teqgj/uKyv/NXPibmTfMp/7zFn1p0Zvu0uxK0BnwKLXcfUzsnf0jSFseNWdfLtzNGIjoDoGeUAO/2zZ4lPIVrWBfJUo/s5Z462GtBRO6SW6XVNrdJpLwed9uAvKaAIqLKBvaKcZbJZFd/QkyaFXWQuBGvO4q2s6rSPubiA==
X-Gm-Message-State: AOJu0YxCFaIXDmzsStxkE/ctqh6pBsFGc+qRPCjJTU3OvW30bJQklQ/B
	p8XQHkg4t4iCkozysb6Ld/8oenzRKD8x4j2kJc4D2+ttUX9l21exXlOfzvXI2Fg=
X-Google-Smtp-Source: AGHT+IHo7d1kSgOminRJoAgE7SvJGJsPx2WRzRdQZTC6zITUaEqf+Edvz9EYo78fq+2qihcwbDC9aQ==
X-Received: by 2002:a05:6870:9691:b0:21f:aad7:686c with SMTP id o17-20020a056870969100b0021faad7686cmr544319oaq.35.1708710152018;
        Fri, 23 Feb 2024 09:42:32 -0800 (PST)
Received: from localhost.localdomain (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id rb7-20020a056871618700b0021f6a2bd4b9sm1257803oab.3.2024.02.23.09.42.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Feb 2024 09:42:31 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev
Cc: John@Groves.net,
	john@jagalactic.com,
	Dave Chinner <david@fromorbit.com>,
	Christoph Hellwig <hch@infradead.org>,
	dave.hansen@linux.intel.com,
	gregory.price@memverge.com,
	John Groves <john@groves.net>
Subject: [RFC PATCH 05/20] dev_dax_iomap: Add dax_operations for use by fs-dax on devdax
Date: Fri, 23 Feb 2024 11:41:49 -0600
Message-Id: <5727b1be956278e3a6c4cf7b728ee4f8f037ae51.1708709155.git.john@groves.net>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <cover.1708709155.git.john@groves.net>
References: <cover.1708709155.git.john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Notes about this commit:

* These methods are based somewhat loosely on pmem_dax_ops from
  drivers/nvdimm/pmem.c

* dev_dax_direct_access() is returns the hpa, pfn and kva. The kva was
  newly stored as dev_dax->virt_addr by dev_dax_probe().

* The hpa/pfn are used for mmap (dax_iomap_fault()), and the kva is used
  for read/write (dax_iomap_rw())

* dev_dax_recovery_write() and dev_dax_zero_page_range() have not been
  tested yet. I'm looking for suggestions as to how to test those.

Signed-off-by: John Groves <john@groves.net>
---
 drivers/dax/bus.c | 107 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 664e8c1b9930..06fcda810674 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -10,6 +10,12 @@
 #include "dax-private.h"
 #include "bus.h"
 
+#if IS_ENABLED(CONFIG_DEV_DAX_IOMAP)
+#include <linux/backing-dev.h>
+#include <linux/pfn_t.h>
+#include <linux/range.h>
+#endif
+
 static DEFINE_MUTEX(dax_bus_lock);
 
 #define DAX_NAME_LEN 30
@@ -1349,6 +1355,101 @@ __weak phys_addr_t dax_pgoff_to_phys(struct dev_dax *dev_dax, pgoff_t pgoff,
 }
 EXPORT_SYMBOL_GPL(dax_pgoff_to_phys);
 
+#if IS_ENABLED(CONFIG_DEV_DAX_IOMAP)
+
+static void write_dax(void *pmem_addr, struct page *page,
+		unsigned int off, unsigned int len)
+{
+	unsigned int chunk;
+	void *mem;
+
+	while (len) {
+		mem = kmap_local_page(page);
+		chunk = min_t(unsigned int, len, PAGE_SIZE - off);
+		memcpy_flushcache(pmem_addr, mem + off, chunk);
+		kunmap_local(mem);
+		len -= chunk;
+		off = 0;
+		page++;
+		pmem_addr += chunk;
+	}
+}
+
+static long __dev_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
+			     long nr_pages, enum dax_access_mode mode, void **kaddr,
+			     pfn_t *pfn)
+{
+	struct dev_dax *dev_dax = dax_get_private(dax_dev);
+	size_t dax_size = dev_dax_size(dev_dax);
+	size_t size = nr_pages << PAGE_SHIFT;
+	size_t offset = pgoff << PAGE_SHIFT;
+	phys_addr_t phys;
+	u64 virt_addr = dev_dax->virt_addr + offset;
+	pfn_t local_pfn;
+	u64 flags = PFN_DEV|PFN_MAP;
+
+	WARN_ON(!dev_dax->virt_addr); /* virt_addr must be saved for direct_access */
+
+	phys = dax_pgoff_to_phys(dev_dax, pgoff, nr_pages << PAGE_SHIFT);
+
+	if (kaddr)
+		*kaddr = (void *)virt_addr;
+
+	local_pfn = phys_to_pfn_t(phys, flags); /* are flags correct? */
+	if (pfn)
+		*pfn = local_pfn;
+
+	/* This the valid size at the specified address */
+	return PHYS_PFN(min_t(size_t, size, dax_size - offset));
+}
+
+static int dev_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
+				    size_t nr_pages)
+{
+	long resid = nr_pages << PAGE_SHIFT;
+	long offset = pgoff << PAGE_SHIFT;
+
+	/* Break into one write per dax region */
+	while (resid > 0) {
+		void *kaddr;
+		pgoff_t poff = offset >> PAGE_SHIFT;
+		long len = __dev_dax_direct_access(dax_dev, poff,
+						   nr_pages, DAX_ACCESS, &kaddr, NULL);
+		len = min_t(long, len, PAGE_SIZE);
+		write_dax(kaddr, ZERO_PAGE(0), offset, len);
+
+		offset += len;
+		resid  -= len;
+	}
+	return 0;
+}
+
+static long dev_dax_direct_access(struct dax_device *dax_dev,
+		pgoff_t pgoff, long nr_pages, enum dax_access_mode mode,
+		void **kaddr, pfn_t *pfn)
+{
+	return __dev_dax_direct_access(dax_dev, pgoff, nr_pages, mode, kaddr, pfn);
+}
+
+static size_t dev_dax_recovery_write(struct dax_device *dax_dev, pgoff_t pgoff,
+		void *addr, size_t bytes, struct iov_iter *i)
+{
+	size_t len, off;
+
+	off = offset_in_page(addr);
+	len = PFN_PHYS(PFN_UP(off + bytes));
+
+	return _copy_from_iter_flushcache(addr, bytes, i);
+}
+
+static const struct dax_operations dev_dax_ops = {
+	.direct_access = dev_dax_direct_access,
+	.zero_page_range = dev_dax_zero_page_range,
+	.recovery_write = dev_dax_recovery_write,
+};
+
+#endif /* IS_ENABLED(CONFIG_DEV_DAX_IOMAP) */
+
 struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
 {
 	struct dax_region *dax_region = data->dax_region;
@@ -1404,11 +1505,17 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
 		}
 	}
 
+#if IS_ENABLED(CONFIG_DEV_DAX_IOMAP)
+	/* holder_ops currently populated separately in a slightly hacky way */
+	dax_dev = alloc_dax(dev_dax, &dev_dax_ops);
+#else
 	/*
 	 * No dax_operations since there is no access to this device outside of
 	 * mmap of the resulting character device.
 	 */
 	dax_dev = alloc_dax(dev_dax, NULL);
+#endif
+
 	if (IS_ERR(dax_dev)) {
 		rc = PTR_ERR(dax_dev);
 		goto err_alloc_dax;
-- 
2.43.0


