Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB7B1510A3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2020 21:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgBCUAx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Feb 2020 15:00:53 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45630 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726250AbgBCUAx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Feb 2020 15:00:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580760051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=shhBFCMAdHyZPSUtZvbDnSl6Hh6MWwOI5m8jhLLofFE=;
        b=aYPYw6rbVKMjPUaXgL2iKl6e8kJuYsD+Ky2Qwh/kzQEocqB1e2av7jckb1uZvtFSbCvvGm
        C0iagWOmhlhuFvIk5mX82l9Chg6vOjGF3/bPJZ/1ODnsq6Sei2zU764x36vCO4jqDWRCSF
        0XrqJbfyfeGb+XCyxgT46GMPoHkRtk4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-F8QWiDr3OLqkSVisg9cvPg-1; Mon, 03 Feb 2020 15:00:50 -0500
X-MC-Unique: F8QWiDr3OLqkSVisg9cvPg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03C65107ACC4;
        Mon,  3 Feb 2020 20:00:49 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 777C48CCC2;
        Mon,  3 Feb 2020 20:00:46 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 0DB832246B1; Mon,  3 Feb 2020 15:00:46 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        dan.j.williams@intel.com, hch@infradead.org
Cc:     vgoyal@redhat.com, vishal.l.verma@intel.com, dm-devel@redhat.com
Subject: [PATCH 2/5] s390,dax: Add dax zero_page_range operation to dcssblk driver
Date:   Mon,  3 Feb 2020 15:00:26 -0500
Message-Id: <20200203200029.4592-3-vgoyal@redhat.com>
In-Reply-To: <20200203200029.4592-1-vgoyal@redhat.com>
References: <20200203200029.4592-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add dax operation zero_page_range. This just calls generic helper
generic_dax_zero_page_range().

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 drivers/s390/block/dcssblk.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 63502ca537eb..f6709200bcd0 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -62,6 +62,7 @@ static const struct dax_operations dcssblk_dax_ops =3D =
{
 	.dax_supported =3D generic_fsdax_supported,
 	.copy_from_iter =3D dcssblk_dax_copy_from_iter,
 	.copy_to_iter =3D dcssblk_dax_copy_to_iter,
+	.zero_page_range =3D dcssblk_dax_zero_page_range,
 };
=20
 struct dcssblk_dev_info {
@@ -941,6 +942,12 @@ dcssblk_dax_direct_access(struct dax_device *dax_dev=
, pgoff_t pgoff,
 	return __dcssblk_direct_access(dev_info, pgoff, nr_pages, kaddr, pfn);
 }
=20
+static int dcssblk_dax_zero_page_range(struct dax_device *dax_dev,pgoff_=
t pgoff,
+				       unsigned offset, size_t len)
+{
+	return generic_dax_zero_page_range(dax_dev, pgoff, offset, len);
+}
+
 static void
 dcssblk_check_params(void)
 {
--=20
2.18.1

