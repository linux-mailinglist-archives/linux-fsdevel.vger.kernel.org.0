Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21406800F2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2019 21:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392097AbfHBT37 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Aug 2019 15:29:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34940 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391971AbfHBT37 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Aug 2019 15:29:59 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 089EF3CA12;
        Fri,  2 Aug 2019 19:29:59 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A4D4F19C68;
        Fri,  2 Aug 2019 19:29:56 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 2C27C22377E; Fri,  2 Aug 2019 15:29:56 -0400 (EDT)
Date:   Fri, 2 Aug 2019 15:29:56 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     dan.j.williams@intel.com, linux-nvdimm@lists.01.org
Cc:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com
Subject: [PATCH] dax: dax_layout_busy_page() should not unmap cow pages
Message-ID: <20190802192956.GA3032@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 02 Aug 2019 19:29:59 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As of now dax_layout_busy_page() calls unmap_mapping_range() with last
argument as 1, which says even unmap cow pages. I am wondering who needs
to get rid of cow pages as well.

I noticed one interesting side affect of this. I mount xfs with -o dax and
mmaped a file with MAP_PRIVATE and wrote some data to a page which created
cow page. Then I called fallocate() on that file to zero a page of file.
fallocate() called dax_layout_busy_page() which unmapped cow pages as well
and then I tried to read back the data I wrote and what I get is old
data from persistent memory. I lost the data I had written. This
read basically resulted in new fault and read back the data from
persistent memory.

This sounds wrong. Are there any users which need to unmap cow pages
as well? If not, I am proposing changing it to not unmap cow pages.

I noticed this while while writing virtio_fs code where when I tried
to reclaim a memory range and that corrupted the executable and I
was running from virtio-fs and program got segment violation.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/dax.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: rhvgoyal-linux/fs/dax.c
===================================================================
--- rhvgoyal-linux.orig/fs/dax.c	2019-08-01 17:03:10.574675652 -0400
+++ rhvgoyal-linux/fs/dax.c	2019-08-02 14:32:28.809639116 -0400
@@ -600,7 +600,7 @@ struct page *dax_layout_busy_page(struct
 	 * guaranteed to either see new references or prevent new
 	 * references from being established.
 	 */
-	unmap_mapping_range(mapping, 0, 0, 1);
+	unmap_mapping_range(mapping, 0, 0, 0);
 
 	xas_lock_irq(&xas);
 	xas_for_each(&xas, entry, ULONG_MAX) {
