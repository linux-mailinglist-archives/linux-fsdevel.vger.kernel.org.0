Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9662F23F33B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 21:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgHGTzt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 15:55:49 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49380 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726547AbgHGTzt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 15:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596830148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L9RWbojIVQ2p7jm03k2G6KoVG69ya+D8xde31L+iPHE=;
        b=OuqM7fz+q6mHa4gp/ASW6lGK4ah9sg359aZD2hJj8Htc53PrPkW3Gj9Ir/FPDuZyJ9IvwF
        tN+NEasAxgujj2IyqS+sWzMA6kspNTdz506r+OG6bDn6EHFLIG1nq4r1xwW4KwA9nC9jPJ
        jfy+NiQfFbhfp0TcdhQYgV+odVRklsY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-gIhu-hKBPyyoar0_g8woZw-1; Fri, 07 Aug 2020 15:55:46 -0400
X-MC-Unique: gIhu-hKBPyyoar0_g8woZw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F333E57;
        Fri,  7 Aug 2020 19:55:44 +0000 (UTC)
Received: from horse.redhat.com (ovpn-113-142.rdu2.redhat.com [10.10.113.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2625710027AB;
        Fri,  7 Aug 2020 19:55:39 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id A6969222E40; Fri,  7 Aug 2020 15:55:38 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm@lists.01.org
Subject: [PATCH v2 01/20] dax: Modify bdev_dax_pgoff() to handle NULL bdev
Date:   Fri,  7 Aug 2020 15:55:07 -0400
Message-Id: <20200807195526.426056-2-vgoyal@redhat.com>
In-Reply-To: <20200807195526.426056-1-vgoyal@redhat.com>
References: <20200807195526.426056-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

virtiofs does not have a block device but it has dax device.
Modify bdev_dax_pgoff() to be able to handle that.

If there is no bdev, that means dax offset is 0. (It can't be a partition
block device starting at an offset in dax device).

This is little hackish. There have been discussions about getting rid
of dax not supporting partitions.

https://lore.kernel.org/linux-fsdevel/20200107125159.GA15745@infradead.org/

IMHO, this path can easily break exisitng users. For example
ioctl(BLKPG_ADD_PARTITION) will start breaking on block devices
supporting DAX. Also, I personally find it very useful to be able to
partition dax devices and still be able to use DAX.

Alternatively, I tried to store offset into dax device information in iomap
interface, but that got NACKed.

https://lore.kernel.org/linux-fsdevel/20200217133117.GB20444@infradead.org/

I can't think of a good path to solve this issue properly. So to make
progress, it seems this patch is least bad option for now and I hope
we can take it.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org
---
 drivers/dax/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 8e32345be0f7..c4bec437e88b 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -46,7 +46,8 @@ EXPORT_SYMBOL_GPL(dax_read_unlock);
 int bdev_dax_pgoff(struct block_device *bdev, sector_t sector, size_t size,
 		pgoff_t *pgoff)
 {
-	phys_addr_t phys_off = (get_start_sect(bdev) + sector) * 512;
+	sector_t start_sect = bdev ? get_start_sect(bdev) : 0;
+	phys_addr_t phys_off = (start_sect + sector) * 512;
 
 	if (pgoff)
 		*pgoff = PHYS_PFN(phys_off);
-- 
2.25.4

