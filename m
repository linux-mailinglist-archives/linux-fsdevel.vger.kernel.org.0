Return-Path: <linux-fsdevel+bounces-18126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A9C8B5F8F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A45171F23543
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 17:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9FB86642;
	Mon, 29 Apr 2024 17:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcL7GLws"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D7783CBA;
	Mon, 29 Apr 2024 17:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714410309; cv=none; b=ESgUzPazgIj3A65Tq6ZksJLEJCf7mAwaAVeHWhg7dmUILGlL9bnXIMcCATPRs38P0ZJ9aM83fazymSzfdOYQKSkjATxsdXp9PnU3l4vcvRIa7due/iIXp3E4j1eMfIEKdsPqtcivnirqCF903Emytoop1GomK1Ho7xVFsvDoiEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714410309; c=relaxed/simple;
	bh=qjg/aYIA2Aj3ETwT1bnW30oXWKlF7YzrJy/VAO7WdCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GNSfVgGy7QLFfgxROEbrxYP1CAi1PspfGUm1JCDcQEcCR4Fh9+aMf3r/Zru1E0vZY04vrtPEdx2hJeAr8lQgYxWc7CcCupdXbV8ztC+UX2L2P9J5EXSiEP0p0cRTby5/SL7Xgn8dw9WLDCsDi3qm7fANUPq7BNjvT0hLNZ/+s6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcL7GLws; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6ee2d64423cso897008a34.2;
        Mon, 29 Apr 2024 10:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714410307; x=1715015107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbyzPWFSpme/6Xxw3JGZg5PIHNbasBNXPhuMHV0OHPQ=;
        b=XcL7GLws32HprpZsVn28q7eMCHa4jryFb6uc84tDWQdKItFmiMCm7p87gtb29I2PSf
         FYaxHE1x7eqw+1nmhF/x6LcDHmpi/XT6YPcZMhyi3Ze1e2pNh3HT3tRhUE74e11mvrt9
         tc+HEOUDtyjV9ivc6ghvTAIQd7w6ehADRPbjbdM2DQC9PlblE7T/8XaCV+WdLwO51Ib7
         95O2yqwKOWx3qHuTCSK1jh2qxJryqGjv+O5vNRbamYdCPBUeCekJ9CQjvT0KuPpFwGWM
         2aCYL7oPkxauPnOSQQEVR5oTrlTdQvfj5tml44fQP7Abt0FTaiXIiHwFoOINJrUd5lVX
         As5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714410307; x=1715015107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rbyzPWFSpme/6Xxw3JGZg5PIHNbasBNXPhuMHV0OHPQ=;
        b=nmkK93FgnlBjd1eItKhGFLExDE4BUB9m/6gZHq/P/cEsZMu7vvolNu4ppsS5vtRM/+
         dBecIipB2yUeQLWGO7XrUdT77DZ1KV6hp52SmPUqYVIwfHWAdw6SnC81COHlwUiiuk0n
         HTU/EAGExMpT7KZc1e74ngQ3hj2YJW2N+TSW+0b3HWmjpz94nmnyX6irZzrze/D5imeF
         QA63UXyYvIzR44xZMrBvloSJHV5nYWbPajonxbjIAFNjZ5gaR4iMHGR4RF0h9lCb82Oa
         PWnWFE0L+YXQrcGbLhT/VqTdcLyaqN68dTEc5xHy670n0PNYqehoiGf9hTD8JaqSZZyi
         DggQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGijvxik9yZT5O5Wi9IZylIT2VyuXsjIOLqowW6XK5NzKsddy54AlhKCuvYnXNBjXmKAj86cSGnei0ygwwFd7dubZWNVH7Dx8osS6ac/0Zd7+dN9FDdNuHG0xKsmjKnAtjAEkHKsg78w==
X-Gm-Message-State: AOJu0Yx3EfbF0AfLU3l8/3PFXyLIgut/Velxut505Z0SiILBHa1VjbLi
	r4ZmKA116rWfKMYW3tKJxdYcoWQyST3zk7ZphYEy42UIjLC6Lz0Q
X-Google-Smtp-Source: AGHT+IGjO7mh1AyfnujisR4C9AKwUM+jghociccM9M53gOQe5r8ngqJlfGiDhTWRhS5N4AbdDyMemw==
X-Received: by 2002:a05:6830:20cd:b0:6ee:32f0:ec4e with SMTP id z13-20020a05683020cd00b006ee32f0ec4emr4182582otq.31.1714410306753;
        Mon, 29 Apr 2024 10:05:06 -0700 (PDT)
Received: from localhost.localdomain ([70.114.203.196])
        by smtp.gmail.com with ESMTPSA id g1-20020a9d6201000000b006ea20712e66sm4074448otj.17.2024.04.29.10.05.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Apr 2024 10:05:06 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <John@Groves.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev
Cc: John Groves <jgroves@micron.com>,
	john@jagalactic.com,
	Dave Chinner <david@fromorbit.com>,
	Christoph Hellwig <hch@infradead.org>,
	dave.hansen@linux.intel.com,
	gregory.price@memverge.com,
	Randy Dunlap <rdunlap@infradead.org>,
	Jerome Glisse <jglisse@google.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	Eishan Mirakhur <emirakhur@micron.com>,
	Ravi Shankar <venkataravis@micron.com>,
	Srinivasulu Thanneeru <sthanneeru@micron.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Steve French <stfrench@microsoft.com>,
	Nathan Lynch <nathanl@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Julien Panis <jpanis@baylibre.com>,
	Stanislav Fomichev <sdf@google.com>,
	Dongsheng Yang <dongsheng.yang@easystack.cn>,
	John Groves <john@groves.net>
Subject: [RFC PATCH v2 05/12] dev_dax_iomap: Add dax_operations for use by fs-dax on devdax
Date: Mon, 29 Apr 2024 12:04:21 -0500
Message-Id: <2a8b926ce25a9ef242c933fa451b29401e62bb37.1714409084.git.john@groves.net>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1714409084.git.john@groves.net>
References: <cover.1714409084.git.john@groves.net>
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
index f894272beab8..9c57d4139b74 100644
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
 
@@ -1471,6 +1475,105 @@ __weak phys_addr_t dax_pgoff_to_phys(struct dev_dax *dev_dax, pgoff_t pgoff,
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
@@ -1526,11 +1629,18 @@ static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
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
2.43.0


