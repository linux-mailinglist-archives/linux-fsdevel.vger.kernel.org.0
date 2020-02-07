Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9C41155F90
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 21:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgBGU1O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 15:27:14 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38759 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727068AbgBGU1M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 15:27:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581107231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+PIs0aogCK20rQ10EgLXcJqcuxsHbzkpWoBj+waYkxo=;
        b=PI4xM+F36IsY8cjLawUB2oWb5EaxZ1HcqszXypZATtSpdpprZKpm7Eg4u018iMjTp84Gkk
        9NwR/eaxng9Csacp8MZuKOhJqFfr1ETIj4CHwSesgsKgkoMsP5Badmb/WATXdOHgUPncCk
        bwV/LSrrg6OXilA8examNsJEgRKl7KA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-G1LW6OLLO12cioVzd5mrEQ-1; Fri, 07 Feb 2020 15:27:07 -0500
X-MC-Unique: G1LW6OLLO12cioVzd5mrEQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C14B2800E21;
        Fri,  7 Feb 2020 20:27:05 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 14E2C1BC6D;
        Fri,  7 Feb 2020 20:27:03 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 9B0742257D6; Fri,  7 Feb 2020 15:27:02 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        hch@infradead.org, dan.j.williams@intel.com
Cc:     dm-devel@redhat.com, vishal.l.verma@intel.com, vgoyal@redhat.com,
        linux-s390@vger.kernel.org
Subject: [PATCH v3 4/7] s390,dcssblk,dax: Add dax zero_page_range operation to dcssblk driver
Date:   Fri,  7 Feb 2020 15:26:49 -0500
Message-Id: <20200207202652.1439-5-vgoyal@redhat.com>
In-Reply-To: <20200207202652.1439-1-vgoyal@redhat.com>
References: <20200207202652.1439-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add dax operation zero_page_range for dcssblk driver.

CC: linux-s390@vger.kernel.org
Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 drivers/s390/block/dcssblk.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 63502ca537eb..331abab5d066 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -57,11 +57,28 @@ static size_t dcssblk_dax_copy_to_iter(struct dax_dev=
ice *dax_dev,
 	return copy_to_iter(addr, bytes, i);
 }
=20
+static int dcssblk_dax_zero_page_range(struct dax_device *dax_dev, u64 o=
ffset,
+				       size_t len)
+{
+	long rc;
+	void *kaddr;
+	pgoff_t pgoff =3D offset >> PAGE_SHIFT;
+	unsigned page_offset =3D offset_in_page(offset);
+
+	rc =3D dax_direct_access(dax_dev, pgoff, 1, &kaddr, NULL);
+	if (rc < 0)
+		return rc;
+	memset(kaddr + page_offset, 0, len);
+	dax_flush(dax_dev, kaddr + page_offset, len);
+	return 0;
+}
+
 static const struct dax_operations dcssblk_dax_ops =3D {
 	.direct_access =3D dcssblk_dax_direct_access,
 	.dax_supported =3D generic_fsdax_supported,
 	.copy_from_iter =3D dcssblk_dax_copy_from_iter,
 	.copy_to_iter =3D dcssblk_dax_copy_to_iter,
+	.zero_page_range =3D dcssblk_dax_zero_page_range,
 };
=20
 struct dcssblk_dev_info {
--=20
2.20.1

