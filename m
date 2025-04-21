Return-Path: <linux-fsdevel+bounces-46748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5876DA94A3D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 03:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F100A1890CE8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 01:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630A316F282;
	Mon, 21 Apr 2025 01:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fe4JeiZU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB3B1624D0;
	Mon, 21 Apr 2025 01:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745199249; cv=none; b=GJUnD3tyv01alsoj2R2DzmdlJxLtHZA1LZNxZEzSmzGiSz4S1bfpZbf0TXWPtf8UwnW4iIJBekYv85ywBjP67orjbijvDi2oEfTE8eO5f8l21NYOzRXlKne1okSkDPHHZWnqIb5tEWFEuKQ+WRlTgW1CorCIK+4I+lgdgXt5W6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745199249; c=relaxed/simple;
	bh=Pw428QKL7vU/Q+rAmnYuMV/vyS2i6xzQE57G20v2vFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rfWOGq6PsLkQD0R+nA5dDOeSPZ0kYULVQd6e9Bcr/61jI3ahBksKEKH7UB3KpKJfimw1vUlmw+U8jjCtNhmSGSWv+6m1b4sIe5RbQNU6cTzsWl6KUcvwScQAX4qkUIt+AME84erJwcJASFYLO2kgnsHYfAztp9wSi9ZcSDrPVqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fe4JeiZU; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-72b0626c785so3023586a34.2;
        Sun, 20 Apr 2025 18:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745199247; x=1745804047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgKTg4/Nk6wm5J+WL43f3KfjMbT1HMf3Vkuk3EBDHmU=;
        b=fe4JeiZUDmCEeLgT1F6BjS6kfAQuFIiWuFcsrCS/rLGYdunESxfS2qfH3BRrqHjeMG
         YcztIhZZyIKCw1BAgQ7cftEt6wIti3/DBxyhbL0lAUKgFM+5aKsHHEdgPRNGM/qLCeht
         JHrEznqio6rwcY4Dl/91aH2B/gevt1lJfgQn3n5FpzoK33FBHikUwUwGezBjziJQfVep
         oHUVXfGP6aWvYWSO1Qs85kKL3K1lar0w+sNw8W098zakwLOZcSSn3RePCX/qitHDy97G
         P/15hEc7qF8GLFvX5Asegrlk2JYHenAv3Ixt2/d2+dcPaGuXmPYiQKPaMk7waiVvud3R
         +wIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745199247; x=1745804047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wgKTg4/Nk6wm5J+WL43f3KfjMbT1HMf3Vkuk3EBDHmU=;
        b=D/ho8GnNBSG2jnaFq+XjWnuCc/MuHno0MSzL/EOmZxfQBDBVllzxIKZM4bcoGvGgc9
         gceiQWGwnTpcWcpPAWyXz4Q1QGoqDzPAmNgGqbjnht8K+bXzQIMgT4+3DM09RzNtrFBh
         sQV75XeVcaI3ee6liDlwnJig/5qK6Hzbd9UEiSFBIwiqEdtSt9tZiTF7GslDSVSrjkYQ
         UFswdOQe3+2afM4oJXviF2SeZrMd8dkSj7v7U7hh1OmRqSr5gCLJ5kVyjWKSi678OivI
         sQhbfB66yKRZTkpCm3RLGmRAcd+G1sJHB3kul42upNlNU0FptNpHH7Dt7YJn/Ax6D80S
         ijew==
X-Forwarded-Encrypted: i=1; AJvYcCVacVpwhH99H85sOXnoFI8uuUOCANpa9nO2FYkDf2YntgyA85mAkgbzugMCExqLnJAcD2UrLMYeDCKURNFi@vger.kernel.org, AJvYcCVmUeggnvDwNN/MMw25TrI6rrNIJS3kcxwgr1jRNUt74X6MAERvYaSUW+jaM7ScvtdGn9GdCaeIln1ZR85T2Q==@vger.kernel.org, AJvYcCWEZWmlBhYBUQAUJ6+IGI8KJmAQVOjRaeqalCVSsshWqDJ3YsQWBvi5nDQgypOD81cMvaGRV3WefUc=@vger.kernel.org, AJvYcCWfug0dufP2z0KF4xjU0LWEef0kWMdiNFc+h0UJHgYgdbYGBKqyAtWUpC3K8fG11WxqqZ/Yn5llNxAg@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6crTA3zqiExbw5WhUUdYIxu7UgZUhSR+9r9V4pgJIOfeAWo9Q
	gVw2JAiazZMP5GeDxnAfFie2n2+3aV4TOld1XgkllLn5IJqrqXJM
X-Gm-Gg: ASbGncuEyLZUpwYyXUqv0UpP4fl2v18pkcvOH18GyqKPyIzdsQdeHea9C9OzXU/Vg8P
	Cd6QKanXQg/sV1kQJ8D2go6Cu1ieFu3L98nttR9ChFqPMw6+qKvWTdRJXLN79o1mRbJ+tfKYCMA
	8g9/8wcs7PgfRO4OMj6OMNp33m78zRQwPQuSaMqsycr+XZ0w2Zz+S84JlYwOPiFo4TEwlRRaqM4
	1kOwzASKXSI7BEKqJvN8o4DMhibY6M9c6tU1cBOzMsYcnXOtSFjujO4Hsn1nvIaXPVAc/YtQ4zb
	m63u+8tom1MryErg8uEOTP3xklcNhoT32sSC/lWbYYGS4XhOkZ+80Vnj0rvPqP/wUP4Mlg==
X-Google-Smtp-Source: AGHT+IEsMa4dpZJjBid8/pLKvlf+SmLNSge/Fka+TntF/FXSs3PgaAfQ5jAVyn8KSUpKFBCYf59yRg==
X-Received: by 2002:a05:6830:a92:b0:72b:8974:e3db with SMTP id 46e09a7af769-7300634d735mr6694059a34.25.1745199247110;
        Sun, 20 Apr 2025 18:34:07 -0700 (PDT)
Received: from localhost.localdomain ([2603:8080:1500:3d89:a8f7:1b36:93ce:8dbf])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7300489cd44sm1267588a34.66.2025.04.20.18.34.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 20 Apr 2025 18:34:06 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <John@Groves.net>,
	Dan Williams <dan.j.williams@intel.com>,
	Miklos Szeredi <miklos@szeredb.hu>,
	Bernd Schubert <bschubert@ddn.com>
Cc: John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Luis Henriques <luis@igalia.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Petr Vorel <pvorel@suse.cz>,
	Brian Foster <bfoster@redhat.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	John Groves <john@groves.net>
Subject: [RFC PATCH 04/19] dev_dax_iomap: Add dax_operations for use by fs-dax on devdax
Date: Sun, 20 Apr 2025 20:33:31 -0500
Message-Id: <20250421013346.32530-5-john@groves.net>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250421013346.32530-1-john@groves.net>
References: <20250421013346.32530-1-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Notes about this commit:

* These methods are based on pmem_dax_ops from drivers/nvdimm/pmem.c

* dev_dax_direct_access() is returns the hpa, pfn and kva. The kva was
  newly stored as dev_dax->virt_addr by dev_dax_probe().

* The hpa/pfn are used for mmap (dax_iomap_fault()), and the kva is used
  for read/write (dax_iomap_rw())

* dev_dax_recovery_write() and dev_dax_zero_page_range() have not been
  tested yet. I'm looking for suggestions as to how to test those.

Signed-off-by: John Groves <john@groves.net>
---
 drivers/dax/bus.c | 120 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 115 insertions(+), 5 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 9d9a4ae7bbc0..61a8d1b3c07a 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -7,6 +7,10 @@
 #include <linux/slab.h>
 #include <linux/dax.h>
 #include <linux/io.h>
+#include <linux/backing-dev.h>
+#include <linux/pfn_t.h>
+#include <linux/range.h>
+#include <linux/uio.h>
 #include "dax-private.h"
 #include "bus.h"
 
@@ -1441,6 +1445,105 @@ __weak phys_addr_t dax_pgoff_to_phys(struct dev_dax *dev_dax, pgoff_t pgoff,
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
+			long nr_pages, enum dax_access_mode mode, void **kaddr,
+			pfn_t *pfn)
+{
+	struct dev_dax *dev_dax = dax_get_private(dax_dev);
+	size_t size = nr_pages << PAGE_SHIFT;
+	size_t offset = pgoff << PAGE_SHIFT;
+	void *virt_addr = dev_dax->virt_addr + offset;
+	u64 flags = PFN_DEV|PFN_MAP;
+	phys_addr_t phys;
+	pfn_t local_pfn;
+	size_t dax_size;
+
+	WARN_ON(!dev_dax->virt_addr);
+
+	if (down_read_interruptible(&dax_dev_rwsem))
+		return 0; /* no valid data since we were killed */
+	dax_size = dev_dax_size(dev_dax);
+	up_read(&dax_dev_rwsem);
+
+	phys = dax_pgoff_to_phys(dev_dax, pgoff, nr_pages << PAGE_SHIFT);
+
+	if (kaddr)
+		*kaddr = virt_addr;
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
+	size_t off;
+
+	off = offset_in_page(addr);
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
 static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
 {
 	struct dax_region *dax_region = data->dax_region;
@@ -1496,11 +1599,18 @@ static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
 		}
 	}
 
-	/*
-	 * No dax_operations since there is no access to this device outside of
-	 * mmap of the resulting character device.
-	 */
-	dax_dev = alloc_dax(dev_dax, NULL);
+	if (IS_ENABLED(CONFIG_DEV_DAX_IOMAP))
+		/* holder_ops currently populated separately in a slightly
+		 * hacky way
+		 */
+		dax_dev = alloc_dax(dev_dax, &dev_dax_ops);
+	else
+		/*
+		 * No dax_operations since there is no access to this device
+		 * outside of mmap of the resulting character device.
+		 */
+		dax_dev = alloc_dax(dev_dax, NULL);
+
 	if (IS_ERR(dax_dev)) {
 		rc = PTR_ERR(dax_dev);
 		goto err_alloc_dax;
-- 
2.49.0


