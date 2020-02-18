Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2AD16355E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 22:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgBRVtE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 16:49:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32845 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727976AbgBRVtC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 16:49:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582062540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tyVUZZb1YzuBSN0HxippMw48mL8qf75NwDgXuTB/Cgc=;
        b=gko633RRKPlGOoTApvTCJ209XszxISVfojJ/8xdwqrM6/JYA3xvxEwL9okhp95RJVR/kbA
        n4wr+Xba40LzZwDk1qX0VdUpyse1hiK3tGUE7A9K8rekxieztN7ieTHKii5kuj9LotFyPs
        DaXSmnF5HtB7WWa0JR07hmszPd5k+oc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-y2FBWsfmMyi3cnQC9K4Img-1; Tue, 18 Feb 2020 16:48:57 -0500
X-MC-Unique: y2FBWsfmMyi3cnQC9K4Img-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7CD9802566;
        Tue, 18 Feb 2020 21:48:55 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 007E75D9E5;
        Tue, 18 Feb 2020 21:48:52 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 9429C2257D4; Tue, 18 Feb 2020 16:48:52 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        hch@infradead.org, dan.j.williams@intel.com
Cc:     dm-devel@redhat.com, vishal.l.verma@intel.com, vgoyal@redhat.com
Subject: [PATCH v5 2/8] drivers/pmem: Allow pmem_clear_poison() to accept arbitrary offset and len
Date:   Tue, 18 Feb 2020 16:48:35 -0500
Message-Id: <20200218214841.10076-3-vgoyal@redhat.com>
In-Reply-To: <20200218214841.10076-1-vgoyal@redhat.com>
References: <20200218214841.10076-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently pmem_clear_poison() expects offset and len to be sector aligned=
.
Atleast that seems to be the assumption with which code has been written.
It is called only from pmem_do_bvec() which is called only from pmem_rw_p=
age()
and pmem_make_request() which will only passe sector aligned offset and l=
en.

Soon we want use this function from dax_zero_page_range() code path which
can try to zero arbitrary range of memory with-in a page. So update this
function to assume that offset and length can be arbitrary and do the
necessary alignments as needed.

nvdimm_clear_poison() seems to assume offset and len to be aligned to
clear_err_unit boundary. But this is currently internal detail and is
not exported for others to use. So for now, continue to align offset and
length to SECTOR_SIZE boundary. Improving it further and to align it
to clear_err_unit boundary is a TODO item for future.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 drivers/nvdimm/pmem.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 075b11682192..e72959203253 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -74,14 +74,28 @@ static blk_status_t pmem_clear_poison(struct pmem_dev=
ice *pmem,
 	sector_t sector;
 	long cleared;
 	blk_status_t rc =3D BLK_STS_OK;
+	phys_addr_t start_aligned, end_aligned;
+	unsigned int len_aligned;
=20
-	sector =3D (offset - pmem->data_offset) / 512;
+	/*
+	 * Callers can pass arbitrary offset and len. But nvdimm_clear_poison()
+	 * expects memory offset and length to meet certain alignment
+	 * restrction (clear_err_unit). Currently nvdimm does not export
+	 * required alignment. So align offset and length to sector boundary
+	 * before passing it to nvdimm_clear_poison().
+	 */
+	start_aligned =3D ALIGN(offset, SECTOR_SIZE);
+	end_aligned =3D ALIGN_DOWN((offset + len), SECTOR_SIZE) - 1;
+	len_aligned =3D end_aligned - start_aligned + 1;
+
+	sector =3D (start_aligned - pmem->data_offset) / 512;
=20
-	cleared =3D nvdimm_clear_poison(dev, pmem->phys_addr + offset, len);
-	if (cleared < len)
+	cleared =3D nvdimm_clear_poison(dev, pmem->phys_addr + start_aligned,
+				      len_aligned);
+	if (cleared < len_aligned)
 		rc =3D BLK_STS_IOERR;
 	if (cleared > 0 && cleared / 512) {
-		hwpoison_clear(pmem, pmem->phys_addr + offset, cleared);
+		hwpoison_clear(pmem, pmem->phys_addr + start_aligned, cleared);
 		cleared /=3D 512;
 		dev_dbg(dev, "%#llx clear %ld sector%s\n",
 				(unsigned long long) sector, cleared,
--=20
2.20.1

