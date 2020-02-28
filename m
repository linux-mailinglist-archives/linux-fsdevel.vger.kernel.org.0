Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBD81173D07
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 17:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgB1QfW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 11:35:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29904 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726046AbgB1QfW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 11:35:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582907721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LzvhLPASDAYE9tGXnm3XfqZQuF+iiZo5UZjI/h6SXbQ=;
        b=O+VhbNELhxfXtPVO1wkJFzAU0lPB5MMA+9QA7bR8ls+bFeQHFFrrjhdFzB7YgJhU6NQ/5r
        2J1nL8+xenl2NPOKJNuKVRMNGF95NiGEP+IUJ1ASWxzW0V9p0eyj0jPB6UuxaWNy4jjOhf
        0cX/PnYXKcg6/o3Sm5AaI3+K8kJqMfk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-Ri0bvLgjOeOqTxU7c8Ql1g-1; Fri, 28 Feb 2020 11:35:15 -0500
X-MC-Unique: Ri0bvLgjOeOqTxU7c8Ql1g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C0791005514;
        Fri, 28 Feb 2020 16:35:14 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 52DC89184F;
        Fri, 28 Feb 2020 16:35:11 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id C5A012257D4; Fri, 28 Feb 2020 11:35:10 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        hch@infradead.org, dan.j.williams@intel.com
Cc:     vgoyal@redhat.com, david@fromorbit.com, jmoyer@redhat.com,
        dm-devel@redhat.com
Subject: [PATCH v6 2/6] dax, pmem: Add a dax operation zero_page_range
Date:   Fri, 28 Feb 2020 11:34:52 -0500
Message-Id: <20200228163456.1587-3-vgoyal@redhat.com>
In-Reply-To: <20200228163456.1587-1-vgoyal@redhat.com>
References: <20200228163456.1587-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a dax operation zero_page_range, to zero a page. This will also clear=
 any
known poison in the page being zeroed.

As of now, zeroing of one page is allowed in a single call. There
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
 drivers/dax/super.c   | 20 ++++++++++++++++++++
 drivers/nvdimm/pmem.c | 11 +++++++++++
 include/linux/dax.h   |  4 ++++
 3 files changed, 35 insertions(+)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 0aa4b6bc5101..e498daf3c0d7 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -344,6 +344,26 @@ size_t dax_copy_to_iter(struct dax_device *dax_dev, =
pgoff_t pgoff, void *addr,
 }
 EXPORT_SYMBOL_GPL(dax_copy_to_iter);
=20
+int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
+			size_t nr_pages)
+{
+	if (!dax_alive(dax_dev))
+		return -ENXIO;
+
+	if (!dax_dev->ops->zero_page_range)
+		return -EOPNOTSUPP;
+	/*
+	 * There are no callers that want to zero more than one page as of now.
+	 * Once users are there, this check can be removed after the
+	 * device mapper code has been updated to split ranges across targets.
+	 */
+	if (nr_pages !=3D 1)
+		return -EIO;
+
+	return dax_dev->ops->zero_page_range(dax_dev, pgoff, nr_pages);
+}
+EXPORT_SYMBOL_GPL(dax_zero_page_range);
+
 #ifdef CONFIG_ARCH_HAS_PMEM_API
 void arch_wb_cache_pmem(void *addr, size_t size);
 void dax_flush(struct dax_device *dax_dev, void *addr, size_t size)
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 075b11682192..5b774ddd0efb 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -282,6 +282,16 @@ static const struct block_device_operations pmem_fop=
s =3D {
 	.revalidate_disk =3D	nvdimm_revalidate_disk,
 };
=20
+static int pmem_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t =
pgoff,
+				    size_t nr_pages)
+{
+	struct pmem_device *pmem =3D dax_get_private(dax_dev);
+
+	return blk_status_to_errno(pmem_do_write(pmem, ZERO_PAGE(0), 0,
+				   PFN_PHYS(pgoff) >> SECTOR_SHIFT,
+				   PAGE_SIZE));
+}
+
 static long pmem_dax_direct_access(struct dax_device *dax_dev,
 		pgoff_t pgoff, long nr_pages, void **kaddr, pfn_t *pfn)
 {
@@ -313,6 +323,7 @@ static const struct dax_operations pmem_dax_ops =3D {
 	.dax_supported =3D generic_fsdax_supported,
 	.copy_from_iter =3D pmem_copy_from_iter,
 	.copy_to_iter =3D pmem_copy_to_iter,
+	.zero_page_range =3D pmem_dax_zero_page_range,
 };
=20
 static const struct attribute_group *pmem_attribute_groups[] =3D {
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 328c2dbb4409..71735c430c05 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -34,6 +34,8 @@ struct dax_operations {
 	/* copy_to_iter: required operation for fs-dax direct-i/o */
 	size_t (*copy_to_iter)(struct dax_device *, pgoff_t, void *, size_t,
 			struct iov_iter *);
+	/* zero_page_range: required operation. Zero page range   */
+	int (*zero_page_range)(struct dax_device *, pgoff_t, size_t);
 };
=20
 extern struct attribute_group dax_attribute_group;
@@ -199,6 +201,8 @@ size_t dax_copy_from_iter(struct dax_device *dax_dev,=
 pgoff_t pgoff, void *addr,
 		size_t bytes, struct iov_iter *i);
 size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void =
*addr,
 		size_t bytes, struct iov_iter *i);
+int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
+			size_t nr_pages);
 void dax_flush(struct dax_device *dax_dev, void *addr, size_t size);
=20
 ssize_t dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
--=20
2.20.1

