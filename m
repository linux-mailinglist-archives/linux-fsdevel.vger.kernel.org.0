Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC14C15AE20
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 18:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgBLRH6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 12:07:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20896 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728899AbgBLRH4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 12:07:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581527275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Kx97YjoepQpQ0kz210ikU62VnqPVqaOjhm9SlazRBo=;
        b=gNcbxa1isplaIvP9rBjxqY2ejICIZ/qnU8BEf+6rbzT1vqz273d3oXqK5vyv5SZo7Ejh74
        4fxcjGLwl/mXcQgtpT/ZjK+LSzXnQG2imJYukUvz6oayGDHzYO7oQjiyLsuREvTZtgVSw9
        /OQFYYMhcpUJR8Fa19OrWJtwCHybt0k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-e1m5cTtcPZ-n_WXIgSZPsQ-1; Wed, 12 Feb 2020 12:07:51 -0500
X-MC-Unique: e1m5cTtcPZ-n_WXIgSZPsQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 432DF800D41;
        Wed, 12 Feb 2020 17:07:50 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 21BC25C1B2;
        Wed, 12 Feb 2020 17:07:50 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id C052D2257D7; Wed, 12 Feb 2020 12:07:46 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        dan.j.williams@intel.com, hch@infradead.org
Cc:     vgoyal@redhat.com, dm-devel@redhat.com, jack@suse.cz
Subject: [PATCH 5/6] drivers/dax: Use dax_pgoff() instead of bdev_dax_pgoff()
Date:   Wed, 12 Feb 2020 12:07:32 -0500
Message-Id: <20200212170733.8092-6-vgoyal@redhat.com>
In-Reply-To: <20200212170733.8092-1-vgoyal@redhat.com>
References: <20200212170733.8092-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Start using dax_pgoff() instead of bdev_dax_pgoff().

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 drivers/dax/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index e9daa30e4250..ee35ecc61545 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -97,7 +97,7 @@ bool __generic_fsdax_supported(struct dax_device *dax_d=
ev,
 		return false;
 	}
=20
-	err =3D bdev_dax_pgoff(bdev, start, PAGE_SIZE, &pgoff);
+	err =3D dax_pgoff(get_start_sect(bdev), start, PAGE_SIZE, &pgoff);
 	if (err) {
 		pr_debug("%s: error: unaligned partition for dax\n",
 				bdevname(bdev, buf));
@@ -105,7 +105,7 @@ bool __generic_fsdax_supported(struct dax_device *dax=
_dev,
 	}
=20
 	last_page =3D PFN_DOWN((start + sectors - 1) * 512) * PAGE_SIZE / 512;
-	err =3D bdev_dax_pgoff(bdev, last_page, PAGE_SIZE, &pgoff_end);
+	err =3D dax_pgoff(get_start_sect(bdev), last_page, PAGE_SIZE, &pgoff_en=
d);
 	if (err) {
 		pr_debug("%s: error: unaligned partition for dax\n",
 				bdevname(bdev, buf));
--=20
2.20.1

