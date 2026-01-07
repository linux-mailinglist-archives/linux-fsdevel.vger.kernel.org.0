Return-Path: <linux-fsdevel+bounces-72640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F198CFF61F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 19:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 457D131D0052
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 17:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650763AA1B1;
	Wed,  7 Jan 2026 15:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lt5Lfk3l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CF63AA1AC
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 15:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767800036; cv=none; b=eHU9/7Q6IKVvhKQnI1ABEReCjpN/pTy3AESJ5oyAIzHTiFVP1P6020Q79WkplUDJ6rs19rzlNZWlx5uiDv2aUJ2hY5e5y7zgEg/PmwTPlkAuDexiS8KUSS7EkCpboFAKIfTwehvwrLa5GUseaCKxIak1mr/Sd+pwor3w6Zp8EwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767800036; c=relaxed/simple;
	bh=/zbQHEHtq57A2Q6JHU6gAg/bO8p74zRbMnNSIB3dT5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XuxdmV+pf5rFRJsTefIx3Ev3FvAgLr4Y4AC9zXG/G7mOSQVQrOL12YHSoDfZvX/TEN2ig/uYVlN0QhtptJ8DX2cjhONA5URlQ2fzrO8i4blv+gqQDYDlQZ5/z6bFw4FZbtjkEc8CcPSzAxJOA81HpApw9OQEqaJH6zSYrz6fsQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lt5Lfk3l; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-44fe903c1d6so619665b6e.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jan 2026 07:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767800034; x=1768404834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ATdgisM3Tik/NiyOwZFhtzJ8q/T+7QdescJPqQtpWw=;
        b=lt5Lfk3lcoB8+ss+HcELQvjRr1WblEz5sVwhQy11HLnS8reSuHpu0lTxPLH+rM+JeV
         VCrxplhNlRYnGmkPBk5t2OCtFD8QuOYBC3nCIMFMYCLWBC7u2L8m/Z5WXVcYs2OiGWQ4
         jCeMHvlgM2J4ou0Hv4pkcYCUIE5lcvatGoStX+xMLk8dcL4jzq0TXM2RCVMaeEssfJGe
         RWoQkyat8cKsyzvQOEZTK1qLBo6gSLWNki5iOgEDxQyuhgsycQYgygg6A3yPgi1+jIEb
         Wv2vTHskl7GeXZBFWG26D9CKMogBltlOXc6LkbgDYdhtTLzC/AtlDn30DvSdrZz5MeHL
         pJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767800034; x=1768404834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ATdgisM3Tik/NiyOwZFhtzJ8q/T+7QdescJPqQtpWw=;
        b=qe8361igitsiWf4TKgCU2VAkUDLtr3kjxp6oUXHnLgBoeExxqhaSklffjMTNU1mFMb
         fEYSOLut2puNymcBNHeJ9rJcSJapRDCRQDru3/Wi2YYGQYtDMXLRr9Bz9iKgE2GfJhlR
         qizBPS8BMaPBPp4GzCDr0MLHMfQ7NEWSkIxPbSZlpfg4Cz9dFzzB41BIB9e9POyoG4W/
         gQQVk17Ixs75uWpRyi0TkoX1YWi4YZDPTS1kE+2uPkt8CKsE84O3EbJCSw6XwubnGpYm
         7fqM3tgVTRubhUIE0zTIjYzvq8YxSgLZXvRuENY8opBPVOh0GMjWAp32I3EJyZoAoRmB
         BAEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMavUzqOoBmZZS+tkPmd6r2XuJ336MdqEnqwD86jLffjsLwkmLwgKuZUz5yXUHRyV1mEij9B2QV3m9PrZV@vger.kernel.org
X-Gm-Message-State: AOJu0YzYSAdb1l8ECSLCGE58Uaq5QUW2c6rOyaYjtf7UQpManEnoCQXL
	ySmUOmY/EUzo3HIXGQ/tknr0RkGPvndTJqJu4a4EdyWHOOIyyT6t/MdL
X-Gm-Gg: AY/fxX4MqJG4ad1Wm2V0/e8KxpFsThKlF9iCTuz3nnSozXAayEY7Wz87T6AXWfYzMFk
	u/XaqR1pzlog4Hxbo+Yhmcp+6Ew7WFownrjAqUNa7ARTT2l+weOeKwuZzL1bA38FCVnXGbJ/exi
	MDE/ASTh83SG3CYXO0U8gAz7Hui9HTgCs45ABOXxCBpE7QtENmG7Y6vHdmZ85pLSJiAeRB/xqp4
	gmgWiVc1RwkIUWwNOjp0uPWEizinNVLz4vKSbn6ocZYLx2xuKJUAjkDPIXtZRtzsM7Y4OGjZBgT
	/zovVMKxo9i0Yi9frXfmSF/LnkCta5iW+u47oerrt/NfeDULQKf1+wqcmNwfsnTewdE8s8xsEHZ
	vhXskfdo1L3aw5AsW9/+BBQ3juLKlzxgf19ONLgbMToDuwVjBp9kbHRgLQcRVrSQrYGWlVaNrwV
	m8iKcTrgY1CCSBc18rLqTdxtv/9GIvjsQPWz1Ue3ZTSC+6ZyWyz9iZ118=
X-Google-Smtp-Source: AGHT+IHve8YogzpLKDi2h5kk3r5qd0JvNPCUalMGA+1cdHL4kOqm5K/1cEfDtLFJl4ZqKfKbsphkmg==
X-Received: by 2002:a05:6808:179e:b0:450:bbed:7a75 with SMTP id 5614622812f47-45a6bde282cmr1183058b6e.28.1767800033754;
        Wed, 07 Jan 2026 07:33:53 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:a917:5124:7300:7cef])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e2f1de5sm2398106b6e.22.2026.01.07.07.33.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 07 Jan 2026 07:33:53 -0800 (PST)
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
Subject: [PATCH V3 04/21] dax: Add dax_operations for use by fs-dax on fsdev dax
Date: Wed,  7 Jan 2026 09:33:13 -0600
Message-ID: <20260107153332.64727-5-john@groves.net>
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

* These methods are based on pmem_dax_ops from drivers/nvdimm/pmem.c
* fsdev_dax_direct_access() returns the hpa, pfn and kva. The kva was
  newly stored as dev_dax->virt_addr by dev_dax_probe().
* The hpa/pfn are used for mmap (dax_iomap_fault()), and the kva is used
  for read/write (dax_iomap_rw())
* fsdev_dax_recovery_write() and dev_dax_zero_page_range() have not been
  tested yet. I'm looking for suggestions as to how to test those.
* dax-private.h: add dev_dax->cached_size, which fsdev needs to
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
index 1bb1631af485..fbd8348cc71c 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -85,6 +85,7 @@ struct dev_dax {
 	struct dax_region *region;
 	struct dax_device *dax_dev;
 	void *virt_addr;
+	u64 cached_size;
 	unsigned int align;
 	int target_node;
 	bool dyn_id;
diff --git a/drivers/dax/fsdev.c b/drivers/dax/fsdev.c
index c5c660b193e5..9e2f83aa2584 100644
--- a/drivers/dax/fsdev.c
+++ b/drivers/dax/fsdev.c
@@ -27,6 +27,81 @@
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
+	return PHYS_PFN(min_t(size_t, size, dev_dax->cached_size - offset));
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
+				       kaddr, pfn);
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
@@ -197,6 +272,11 @@ static int fsdev_dax_probe(struct dev_dax *dev_dax)
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
2.49.0


