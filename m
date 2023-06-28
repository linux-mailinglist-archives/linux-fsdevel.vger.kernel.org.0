Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A59B74170D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 19:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjF1RPM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 13:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjF1RPL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:15:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992CD1BF2;
        Wed, 28 Jun 2023 10:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wDiRitMBY2qfFL1Q5um2pQQcb/oUQxsoHUZqTuCvWq8=; b=iiC97+GXjEvZxzDq6pPHDLjMGl
        hrwSBluBUtGF9rR7jH70ssuToh8NFbz2ksTY4Gyai3Cf0Gr1YV+hbCMtgkTnZ634B1pgdAf7iyYF1
        O9nRkYDVg7qOp//mz8Qa3/takCuxFuOWiOVXgzOSjzitzNIZIzRWrEQ1pwKx7a7Tyy2u7f2VJPSC5
        yCCnkjfEUedvJNmqHnubTlGoh/4xeUdWmx5xqZJvwtfzGAl1ed20BGd8Erib1ZAEN002ltGJFLPOQ
        TzyOZp/rBfvls8IeNLVShZ+Ru9AgiAXEQMWMMtRQjRGmOdj9UoOVhwdElCvWit1UgfQE0BYHItKIY
        tE/5A9GA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qEYky-0042IN-Bx; Wed, 28 Jun 2023 17:15:04 +0000
Date:   Wed, 28 Jun 2023 18:15:04 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Sumitra Sharma <sumitraartsy@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Fabio <fmdefrancesco@gmail.com>, Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH] fs/vboxsf: Replace kmap() with kmap_local_{page, folio}()
Message-ID: <ZJxqmEVKoxxftfXM@casper.infradead.org>
References: <20230627135115.GA452832@sumitra.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627135115.GA452832@sumitra.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Here's a more comprehensive read_folio patch.  It's not at all
efficient, but then if we wanted an efficient vboxsf, we'd implement
vboxsf_readahead() and actually do an async call with deferred setting
of the uptodate flag.  I can consult with anyone who wants to do all
this work.

I haven't even compiled this, just trying to show the direction this
should take.

diff --git a/fs/vboxsf/file.c b/fs/vboxsf/file.c
index 2307f8037efc..f1af9a7bd3d8 100644
--- a/fs/vboxsf/file.c
+++ b/fs/vboxsf/file.c
@@ -227,26 +227,31 @@ const struct inode_operations vboxsf_reg_iops = {
 
 static int vboxsf_read_folio(struct file *file, struct folio *folio)
 {
-	struct page *page = &folio->page;
 	struct vboxsf_handle *sf_handle = file->private_data;
-	loff_t off = page_offset(page);
-	u32 nread = PAGE_SIZE;
-	u8 *buf;
+	loff_t pos = folio_pos(folio);
+	size_t offset = 0;
 	int err;
 
-	buf = kmap(page);
+	do {
+		u8 *buf = kmap_local_folio(folio, offset);
+		u32 nread = PAGE_SIZE;
 
-	err = vboxsf_read(sf_handle->root, sf_handle->handle, off, &nread, buf);
-	if (err == 0) {
-		memset(&buf[nread], 0, PAGE_SIZE - nread);
-		flush_dcache_page(page);
-		SetPageUptodate(page);
-	} else {
-		SetPageError(page);
-	}
+		err = vboxsf_read(sf_handle->root, sf_handle->handle, pos,
+				&nread, buf);
+		if (nread < PAGE_SIZE)
+			memset(&buf[nread], 0, PAGE_SIZE - nread);
+		kunmap_local(buf);
+		if (err)
+			break;
+		offset += PAGE_SIZE;
+		pos += PAGE_SIZE;
+	} while (offset < folio_size(folio);
 
-	kunmap(page);
-	unlock_page(page);
+	if (!err) {
+		flush_dcache_folio(folio);
+		folio_mark_uptodate(folio);
+	}
+	folio_unlock(folio);
 	return err;
 }
 
