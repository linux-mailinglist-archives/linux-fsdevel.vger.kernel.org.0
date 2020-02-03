Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B48031510A6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2020 21:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgBCUA4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Feb 2020 15:00:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51841 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726331AbgBCUA4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Feb 2020 15:00:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580760054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S67a5FmWny8OUQz/Os/tqeEXDXljoowi80eZq1WINIk=;
        b=a76lDm3NbugbXGRMP5oSXdNL6BJGOzyQ68uF4TG77vJcQpR3MCg9ybk659lRZa/zEf36/q
        HW/OwBtyn0L+lGTnH+16kSxCASI+EK+AhCNECCez3dM4OH8FIUNrKAePf6nVf3I31I5EJY
        wG8DLMfHLVoL43VmkDXpIc1tMsBaed4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-vX3gM4q9MPa3fPvuVXeDbQ-1; Mon, 03 Feb 2020 15:00:50 -0500
X-MC-Unique: vX3gM4q9MPa3fPvuVXeDbQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 514FF800D55;
        Mon,  3 Feb 2020 20:00:49 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7528B60BE0;
        Mon,  3 Feb 2020 20:00:46 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 092842246AE; Mon,  3 Feb 2020 15:00:46 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        dan.j.williams@intel.com, hch@infradead.org
Cc:     vgoyal@redhat.com, vishal.l.verma@intel.com, dm-devel@redhat.com
Subject: [PATCH 1/5] dax, pmem: Add a dax operation zero_page_range
Date:   Mon,  3 Feb 2020 15:00:25 -0500
Message-Id: <20200203200029.4592-2-vgoyal@redhat.com>
In-Reply-To: <20200203200029.4592-1-vgoyal@redhat.com>
References: <20200203200029.4592-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a dax operation zero_page_range, to zero a range of memory. This will
also clear any poison in the range being zeroed.

As of now, zeroing of up to one page is allowed in a single call. There
are no callers which are trying to zero more than a page in a single call=
.

Once we grow the callers which zero more than a page in single call, we
can add that support. Primary reason for not doing that yet is that this
will add little complexity in dm implementation where a range might be
spanning multiple underlying targets and one will have to split the range
into multiple sub ranges and call zero_page_range() on individual targets=
.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 drivers/dax/super.c   | 20 +++++++++++++++++
 drivers/nvdimm/pmem.c | 50 +++++++++++++++++++++++++++++++++++++++++++
 fs/dax.c              | 15 +++++++++++++
 include/linux/dax.h   |  6 ++++++
 4 files changed, 91 insertions(+)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 26a654dbc69a..371744256fe5 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -344,6 +344,26 @@ size_t dax_copy_to_iter(struct dax_device *dax_dev, =
pgoff_t pgoff, void *addr,
 }
 EXPORT_SYMBOL_GPL(dax_copy_to_iter);
=20
+int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
+			unsigned offset, size_t len)
+{
+	if (!dax_alive(dax_dev))
+		return -ENXIO;
+
+	if (!dax_dev->ops->zero_page_range)
+		return -EOPNOTSUPP;
+
+	/*
+	 * There are no users as of now. Once users are there, fix dm code
+	 * to be able to split a long range across targets.
+	 */
+	if (offset + len > PAGE_SIZE)
+		return -EIO;
+
+	return dax_dev->ops->zero_page_range(dax_dev, pgoff, offset, len);
+}
+EXPORT_SYMBOL_GPL(dax_zero_page_range);
+
 #ifdef CONFIG_ARCH_HAS_PMEM_API
 void arch_wb_cache_pmem(void *addr, size_t size);
 void dax_flush(struct dax_device *dax_dev, void *addr, size_t size)
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index ad8e4df1282b..8739244a72a4 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -268,6 +268,55 @@ static const struct block_device_operations pmem_fop=
s =3D {
 	.revalidate_disk =3D	nvdimm_revalidate_disk,
 };
=20
+static int pmem_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t =
pgoff,
+				    unsigned int offset, size_t len)
+{
+	int rc =3D 0;
+	phys_addr_t phys_pos =3D pgoff * PAGE_SIZE + offset;
+	struct pmem_device *pmem =3D dax_get_private(dax_dev);
+	struct page *page =3D ZERO_PAGE(0);
+	unsigned bytes, nr_sectors =3D 0;
+	sector_t sector_start, sector_end;
+	bool bad_pmem =3D false;
+	phys_addr_t pmem_off =3D phys_pos + pmem->data_offset;
+	void *pmem_addr =3D pmem->virt_addr + pmem_off;
+
+	bytes =3D min_t(size_t, PAGE_SIZE - offset_in_page(phys_pos),
+		      len);
+	/*
+	 * As of now zeroing only with-in a page is supported. This can be
+	 * changed once there are users of zeroing across multiple pages
+	 */
+	if (WARN_ON(len > bytes))
+		return -EIO;
+
+	sector_start =3D ALIGN(phys_pos, 512)/512;
+	sector_end =3D ALIGN_DOWN(phys_pos + bytes, 512)/512;
+	if (sector_end > sector_start)
+		nr_sectors =3D sector_end - sector_start;
+
+	if (nr_sectors &&
+	    unlikely(is_bad_pmem(&pmem->bb, sector_start,
+				 nr_sectors * 512)))
+		bad_pmem =3D true;
+
+	write_pmem(pmem_addr, page, 0, bytes);
+	if (unlikely(bad_pmem)) {
+		/*
+		 * Pass block aligned offset and length. That seems
+		 * to work as of now. Other finer grained alignment
+		 * cases can be addressed later if need be.
+		 */
+		rc =3D pmem_clear_poison(pmem, ALIGN(pmem_off, 512),
+				       nr_sectors * 512);
+		write_pmem(pmem_addr, page, 0, bytes);
+	}
+	if (rc > 0)
+		return -EIO;
+
+	return 0;
+}
+
 static long pmem_dax_direct_access(struct dax_device *dax_dev,
 		pgoff_t pgoff, long nr_pages, void **kaddr, pfn_t *pfn)
 {
@@ -299,6 +348,7 @@ static const struct dax_operations pmem_dax_ops =3D {
 	.dax_supported =3D generic_fsdax_supported,
 	.copy_from_iter =3D pmem_copy_from_iter,
 	.copy_to_iter =3D pmem_copy_to_iter,
+	.zero_page_range =3D pmem_dax_zero_page_range,
 };
=20
 static const struct attribute_group *pmem_attribute_groups[] =3D {
diff --git a/fs/dax.c b/fs/dax.c
index 1f1f0201cad1..35631a4d0295 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1057,6 +1057,21 @@ static bool dax_range_is_aligned(struct block_devi=
ce *bdev,
 	return true;
 }
=20
+int generic_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgof=
f,
+				unsigned int offset, size_t len)
+{
+	long rc;
+	void *kaddr;
+
+	rc =3D dax_direct_access(dax_dev, pgoff, 1, &kaddr, NULL);
+	if (rc < 0)
+		return rc;
+	memset(kaddr + offset, 0, len);
+	dax_flush(dax_dev, kaddr + offset, len);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(generic_dax_zero_page_range);
+
 int __dax_zero_page_range(struct block_device *bdev,
 		struct dax_device *dax_dev, sector_t sector,
 		unsigned int offset, unsigned int size)
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 9bd8528bd305..3356b874c55d 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -34,6 +34,8 @@ struct dax_operations {
 	/* copy_to_iter: required operation for fs-dax direct-i/o */
 	size_t (*copy_to_iter)(struct dax_device *, pgoff_t, void *, size_t,
 			struct iov_iter *);
+	/* zero_page_range: required operation for fs-dax direct-i/o */
+	int (*zero_page_range)(struct dax_device *, pgoff_t, unsigned, size_t);
 };
=20
 extern struct attribute_group dax_attribute_group;
@@ -209,6 +211,10 @@ size_t dax_copy_from_iter(struct dax_device *dax_dev=
, pgoff_t pgoff, void *addr,
 		size_t bytes, struct iov_iter *i);
 size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void =
*addr,
 		size_t bytes, struct iov_iter *i);
+int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
+			unsigned offset, size_t len);
+int generic_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgof=
f,
+				 unsigned int offset, size_t len);
 void dax_flush(struct dax_device *dax_dev, void *addr, size_t size);
=20
 ssize_t dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
--=20
2.18.1

