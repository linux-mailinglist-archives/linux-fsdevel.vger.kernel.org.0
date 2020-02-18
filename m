Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC251163560
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 22:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgBRVtH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 16:49:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29758 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727996AbgBRVtD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 16:49:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582062542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MPuW8FJYXb4EyYv2Zcbckz83nVUeVWfBw8sxF/N5fjs=;
        b=BhnJmMzpRfRha//wsvmMtq3Cy2+0tC0Hycmec9YbRtaa8FcG8oj/b/GDM1UDlaeG11bCn9
        XLn+cdtX8emLz+8sj4YQyZ/YX9jtojHZxYhvbYKXkMeHmIxjwdpcsANIWohYr9nxXVnS2I
        k1Pm5XCrtAh9JJt/Ca5blsvCfS3cPws=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-t2mG82F3PxyQsJxHcH8wnQ-1; Tue, 18 Feb 2020 16:48:57 -0500
X-MC-Unique: t2mG82F3PxyQsJxHcH8wnQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF155802567;
        Tue, 18 Feb 2020 21:48:55 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 10EBE5C1B0;
        Tue, 18 Feb 2020 21:48:53 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 8E9362257D3; Tue, 18 Feb 2020 16:48:52 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        hch@infradead.org, dan.j.williams@intel.com
Cc:     dm-devel@redhat.com, vishal.l.verma@intel.com, vgoyal@redhat.com,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 1/8] pmem: Add functions for reading/writing page to/from pmem
Date:   Tue, 18 Feb 2020 16:48:34 -0500
Message-Id: <20200218214841.10076-2-vgoyal@redhat.com>
In-Reply-To: <20200218214841.10076-1-vgoyal@redhat.com>
References: <20200218214841.10076-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This splits pmem_do_bvec() into pmem_do_read() and pmem_do_write().
pmem_do_write() will be used by pmem zero_page_range() as well. Hence
sharing the same code.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 drivers/nvdimm/pmem.c | 86 +++++++++++++++++++++++++------------------
 1 file changed, 50 insertions(+), 36 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 4eae441f86c9..075b11682192 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -136,9 +136,25 @@ static blk_status_t read_pmem(struct page *page, uns=
igned int off,
 	return BLK_STS_OK;
 }
=20
-static blk_status_t pmem_do_bvec(struct pmem_device *pmem, struct page *=
page,
-			unsigned int len, unsigned int off, unsigned int op,
-			sector_t sector)
+static blk_status_t pmem_do_read(struct pmem_device *pmem,
+			struct page *page, unsigned int page_off,
+			sector_t sector, unsigned int len)
+{
+	blk_status_t rc;
+	phys_addr_t pmem_off =3D sector * 512 + pmem->data_offset;
+	void *pmem_addr =3D pmem->virt_addr + pmem_off;
+
+	if (unlikely(is_bad_pmem(&pmem->bb, sector, len)))
+		return BLK_STS_IOERR;
+
+	rc =3D read_pmem(page, page_off, pmem_addr, len);
+	flush_dcache_page(page);
+	return rc;
+}
+
+static blk_status_t pmem_do_write(struct pmem_device *pmem,
+			struct page *page, unsigned int page_off,
+			sector_t sector, unsigned int len)
 {
 	blk_status_t rc =3D BLK_STS_OK;
 	bool bad_pmem =3D false;
@@ -148,34 +164,25 @@ static blk_status_t pmem_do_bvec(struct pmem_device=
 *pmem, struct page *page,
 	if (unlikely(is_bad_pmem(&pmem->bb, sector, len)))
 		bad_pmem =3D true;
=20
-	if (!op_is_write(op)) {
-		if (unlikely(bad_pmem))
-			rc =3D BLK_STS_IOERR;
-		else {
-			rc =3D read_pmem(page, off, pmem_addr, len);
-			flush_dcache_page(page);
-		}
-	} else {
-		/*
-		 * Note that we write the data both before and after
-		 * clearing poison.  The write before clear poison
-		 * handles situations where the latest written data is
-		 * preserved and the clear poison operation simply marks
-		 * the address range as valid without changing the data.
-		 * In this case application software can assume that an
-		 * interrupted write will either return the new good
-		 * data or an error.
-		 *
-		 * However, if pmem_clear_poison() leaves the data in an
-		 * indeterminate state we need to perform the write
-		 * after clear poison.
-		 */
-		flush_dcache_page(page);
-		write_pmem(pmem_addr, page, off, len);
-		if (unlikely(bad_pmem)) {
-			rc =3D pmem_clear_poison(pmem, pmem_off, len);
-			write_pmem(pmem_addr, page, off, len);
-		}
+	/*
+	 * Note that we write the data both before and after
+	 * clearing poison.  The write before clear poison
+	 * handles situations where the latest written data is
+	 * preserved and the clear poison operation simply marks
+	 * the address range as valid without changing the data.
+	 * In this case application software can assume that an
+	 * interrupted write will either return the new good
+	 * data or an error.
+	 *
+	 * However, if pmem_clear_poison() leaves the data in an
+	 * indeterminate state we need to perform the write
+	 * after clear poison.
+	 */
+	flush_dcache_page(page);
+	write_pmem(pmem_addr, page, page_off, len);
+	if (unlikely(bad_pmem)) {
+		rc =3D pmem_clear_poison(pmem, pmem_off, len);
+		write_pmem(pmem_addr, page, page_off, len);
 	}
=20
 	return rc;
@@ -197,8 +204,12 @@ static blk_qc_t pmem_make_request(struct request_que=
ue *q, struct bio *bio)
=20
 	do_acct =3D nd_iostat_start(bio, &start);
 	bio_for_each_segment(bvec, bio, iter) {
-		rc =3D pmem_do_bvec(pmem, bvec.bv_page, bvec.bv_len,
-				bvec.bv_offset, bio_op(bio), iter.bi_sector);
+		if (op_is_write(bio_op(bio)))
+			rc =3D pmem_do_write(pmem, bvec.bv_page, bvec.bv_offset,
+				iter.bi_sector, bvec.bv_len);
+		else
+			rc =3D pmem_do_read(pmem, bvec.bv_page, bvec.bv_offset,
+				iter.bi_sector, bvec.bv_len);
 		if (rc) {
 			bio->bi_status =3D rc;
 			break;
@@ -223,9 +234,12 @@ static int pmem_rw_page(struct block_device *bdev, s=
ector_t sector,
 	struct pmem_device *pmem =3D bdev->bd_queue->queuedata;
 	blk_status_t rc;
=20
-	rc =3D pmem_do_bvec(pmem, page, hpage_nr_pages(page) * PAGE_SIZE,
-			  0, op, sector);
-
+	if (op_is_write(op))
+		rc =3D pmem_do_write(pmem, page, 0, sector,
+				   hpage_nr_pages(page) * PAGE_SIZE);
+	else
+		rc =3D pmem_do_read(pmem, page, 0, sector,
+				   hpage_nr_pages(page) * PAGE_SIZE);
 	/*
 	 * The ->rw_page interface is subtle and tricky.  The core
 	 * retries on any error, so we can only invoke page_endio() in
--=20
2.20.1

