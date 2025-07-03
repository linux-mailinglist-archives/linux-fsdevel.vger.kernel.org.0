Return-Path: <linux-fsdevel+bounces-53827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47188AF8095
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 20:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A28C91CA1718
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 18:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3152F431A;
	Thu,  3 Jul 2025 18:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTrLyX/T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5B4291C11;
	Thu,  3 Jul 2025 18:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751568654; cv=none; b=aZTZhDLJEY4oRIHHnemNIIHuVWBuoJaAhQwkYksmkZla51onymLrYrjE16m2pU2a3X76VKiIohks3AtEIp1pFnJW+lE/Lq/YV0mYfAQOQmOg5pCB9VCVExTGWraaAafdiqAT8NYlKeF41s1EQY8H0itGTLpR2MQOLS9dd9v4m/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751568654; c=relaxed/simple;
	bh=Pw428QKL7vU/Q+rAmnYuMV/vyS2i6xzQE57G20v2vFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H65Ia5k/Ds0mZq03qGQgA/J2MPSfWXgcGK/pLMJyKrpjoFTY9aGhcMCZc1HKhJ1V8wPrGk2X5x4j3n+H+qnFUPWMkNvHI7SdMhUTAkxwrVhkSOkcWJCQApOf/Xomx4E/q06KqjP+wuiJLt6YcatPH4SsssmqRqA0HAHeYMwHaF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTrLyX/T; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-72c47631b4cso193852a34.1;
        Thu, 03 Jul 2025 11:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751568651; x=1752173451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgKTg4/Nk6wm5J+WL43f3KfjMbT1HMf3Vkuk3EBDHmU=;
        b=cTrLyX/Tbs89Rpf3SvB/1q3aaP8L0eO+9h+B6fsgho2tUU7wWtEw5our7cO4lVp3xp
         nozG2ib6Hg2qDUk6+jGxYBJW7zWexzD9A5GN1B4eCfCGdgnEhsc/oOaX9KKvT/IFciDj
         eUPKxE1u4Nwt/fc+6W14YtOkoKDsoW5ZfdsbeNYLFzSaop6lgjm36mJBMgEDTE2aETG9
         WjcBpn6gieiqSryLNYq6WSwYS08VSZERLv7QOy1ngLo67PyDI31GY1yHYOZJqdQQZfTQ
         9NpxiQnuvirSdGrAknKf00lrF4Dk1Fnrv/28vmix4wd8yGme/TJ8+2GZMQWUuFTRInDn
         DPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751568651; x=1752173451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wgKTg4/Nk6wm5J+WL43f3KfjMbT1HMf3Vkuk3EBDHmU=;
        b=PM8Pmh8PSCAsMj27UhtOELTy+CSeVOD5pX3qVLLM7d+820hC8ySlGv4xKdSMQVRQ/m
         DQTmJCL6aBwhlrmGWxyDewrNeWncV2cA20a8R/M9Fb55QmtGxusFE80vflghURYS0BAf
         RdQIlCPSJ139MHqwb4isoQsEFXOPdllHjQz9mKLLnup1ZTU+6gohIZBVrrSdiXg2h8zI
         wW/W7uemEdz8j8NCOKdyAsXAYk5PMr7c6CFOnYLJYeyvRJVLXrdrCEJtabBt02MBUz+X
         A3Wx+HFe7OvojwZ9VHkeZI8/H8OuOhWA8OZgKmVxesXx0D18fe+3YsThKhCBtGr6BGrd
         PpfA==
X-Forwarded-Encrypted: i=1; AJvYcCVkpy6IrkX6r9JgPAZDfZw50YbFJUb2ttNhs2omI4Slw8p9lc/O87wg3FousmF/5rldvNpOek0J55NjODpL@vger.kernel.org, AJvYcCX5ZUxCTLByS+sGtAD4mYzObaBdNg2IFJbqcjg3D31oo3YRMr15+jb7MLiH+5toJHEE/rcW1A6kcytpMCffXw==@vger.kernel.org, AJvYcCXJwIm2xjFkvy9JvAYjcsnjWKhKbrHDbI2ptmrD2B/R77BydUSpA+AeHDV6Q5ZQocMH5HLqXl5anCZ5@vger.kernel.org, AJvYcCXyOdcunEjBfZVAvZC7MgHFJ5SEYrNcgZdX+xKOyoMW6D8iGD+ssW4W0n1+1OTdVOiucWDBBLcl9As=@vger.kernel.org
X-Gm-Message-State: AOJu0YziLrRIMaM8jOT7IZxF6BfoFHlzmlaTeqYBc/lrH/7F3dl4qti3
	iXXOyfsUrdSOIcn/5qX7Bulz9sn9VMxWaulhlnEJFcWNJqhkx1LvNLrp
X-Gm-Gg: ASbGncuAh/dEiaLqFSH/A0/8binC2q36lT4e0fOdqSiNhdlEEp+CIeIk42iEdA12G94
	lWwrrmphTEtxKiVUavJSmWDKp0RkyCCBTF+NODNmjVOtjbPHESeNfadPADTOMbwk7Bi+l8eTVp3
	6fZySz+3HwxCNPCkd2a75Mz+BjZTXRuJEn2lfrIO/m6KPhnCOuDiX5+hBV9u60oK9UUjosXRzs8
	Y2PFXMiSbwRfGa00qRNh9Vb8bqjDI8+RxWegLolWj9nw0h8wWJXugQ2gq3JfN+OwRvNolWDUxZ9
	i+JJk8dmETc8gqFsYRwXGsVPJlbYNaXAxO53kT+X5bkPtmw9Tm5El4IADP35sAH6zDCeBrworjj
	eJjRMwmz0pZ8WSqpiY4ukNMd7
X-Google-Smtp-Source: AGHT+IGNEYE8azkCu6i4tdt/Jh/JzWWu2d955CfMIRLR2kAADDQEL7D+pI5ll8ogxoQ3Xa3+A+d+Cg==
X-Received: by 2002:a05:6830:3c8d:b0:739:fcb4:db17 with SMTP id 46e09a7af769-73b4cb2f25amr6347478a34.15.1751568650976;
        Thu, 03 Jul 2025 11:50:50 -0700 (PDT)
Received: from localhost.localdomain ([2603:8080:1500:3d89:cd4:2776:8c4a:3597])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73c9f90d1ccsm68195a34.44.2025.07.03.11.50.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Jul 2025 11:50:49 -0700 (PDT)
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
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
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
Subject: [RFC V2 04/18] dev_dax_iomap: Add dax_operations for use by fs-dax on devdax
Date: Thu,  3 Jul 2025 13:50:18 -0500
Message-Id: <20250703185032.46568-5-john@groves.net>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250703185032.46568-1-john@groves.net>
References: <20250703185032.46568-1-john@groves.net>
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


