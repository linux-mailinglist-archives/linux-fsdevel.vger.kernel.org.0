Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9609C155F8B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 21:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbgBGU1N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 15:27:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44044 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727032AbgBGU1K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 15:27:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581107229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8foEyay8+OOzaGQuCRaBURtgFdqxdF17uA4H4O9cpZo=;
        b=e19OyZhOgR4XkvTXMOY16420lpgdcni7hM7ixVlLsiRP7cTNP/wirzgU3cX0IOzjPu1BQE
        C/8vKYgVXrmePe+qUew6gRMBW79ei9OJz9VZ/vbuV1viLzP1tLsrKQvItHNsbpqzB88QbA
        Gv6srX44qgAf1mMfa96vVrFVv2K/qwU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-fzC9EGLuMAyyP2LKicSqnQ-1; Fri, 07 Feb 2020 15:27:06 -0500
X-MC-Unique: fzC9EGLuMAyyP2LKicSqnQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4758801E74;
        Fri,  7 Feb 2020 20:27:05 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 057545DA7E;
        Fri,  7 Feb 2020 20:27:03 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 8E3172257D3; Fri,  7 Feb 2020 15:27:02 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        hch@infradead.org, dan.j.williams@intel.com
Cc:     dm-devel@redhat.com, vishal.l.verma@intel.com, vgoyal@redhat.com
Subject: [PATCH v3 1/7] pmem: Add functions for reading/writing page to/from pmem
Date:   Fri,  7 Feb 2020 15:26:46 -0500
Message-Id: <20200207202652.1439-2-vgoyal@redhat.com>
In-Reply-To: <20200207202652.1439-1-vgoyal@redhat.com>
References: <20200207202652.1439-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This splits pmem_do_bvec() into pmem_do_read() and pmem_do_write().
pmem_do_write() will be used by pmem zero_page_range() as well. Hence
sharing the same code.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 drivers/nvdimm/pmem.c | 79 ++++++++++++++++++++++++++-----------------
 1 file changed, 48 insertions(+), 31 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index ad8e4df1282b..9ad07cb8c9fc 100644
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
@@ -148,39 +164,40 @@ static blk_status_t pmem_do_bvec(struct pmem_device=
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
 }
=20
+static blk_status_t pmem_do_bvec(struct pmem_device *pmem, struct page *=
page,
+			unsigned int len, unsigned int off, unsigned int op,
+			sector_t sector)
+{
+	if (!op_is_write(op))
+		return pmem_do_read(pmem, page, off, sector, len);
+
+	return pmem_do_write(pmem, page, off, sector, len);
+}
+
 static blk_qc_t pmem_make_request(struct request_queue *q, struct bio *b=
io)
 {
 	int ret =3D 0;
--=20
2.20.1

