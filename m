Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01EB3B9E4C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jul 2021 11:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbhGBJhx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jul 2021 05:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbhGBJhx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jul 2021 05:37:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CD2C061762;
        Fri,  2 Jul 2021 02:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tkJyKcy/IiS11XBHSsWE1sU1W22MTH0QdN6h7xIDEiw=; b=rOb9sQ/LRIvaDOIhMJbEkKLisp
        4gkSaYSOzuJoEWR5n8GUGO5dMvi6lV+VBr+20oS4D7mQfw3jGtDGPX8vze2UmcyNdJFxP1sBbo9XE
        k7fvR3xO7Y0MCBdRoTB6NfUImBd0ZYDFPlbYsnolauplqmGRnMris9sKm94lX1X0aNuxsE5N8Ir4p
        UGxNm2cCl7OOL243nYuFKXJ/1aCVt25a8M3aMOZRJ67PyKXWnd+0BW4iIyJ3VBJixkKWSIu+rxK07
        EoKJELsYJtWTak9RNRxbLJrJvJsdX0un9g9Lfx2vUVIQFp64zX5+VrfhrHLaRbPTDQyUBUIa9O1CO
        xfLJWYVQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lzFZ1-007ZFU-97; Fri, 02 Jul 2021 09:34:40 +0000
Date:   Fri, 2 Jul 2021 10:34:23 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next 1/1] iomap: Fix a false positive of UBSAN in
 iomap_seek_data()
Message-ID: <YN7dn08eeUXfixJ7@infradead.org>
References: <20210702092109.2601-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210702092109.2601-1-thunder.leizhen@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We might as well just kill off the length variable while we're at it:


diff --git a/fs/iomap/seek.c b/fs/iomap/seek.c
index dab1b02eba5b7f..942e354e9e13e6 100644
--- a/fs/iomap/seek.c
+++ b/fs/iomap/seek.c
@@ -35,23 +35,21 @@ loff_t
 iomap_seek_hole(struct inode *inode, loff_t offset, const struct iomap_ops *ops)
 {
 	loff_t size = i_size_read(inode);
-	loff_t length = size - offset;
 	loff_t ret;
 
 	/* Nothing to be found before or beyond the end of the file. */
 	if (offset < 0 || offset >= size)
 		return -ENXIO;
 
-	while (length > 0) {
-		ret = iomap_apply(inode, offset, length, IOMAP_REPORT, ops,
-				  &offset, iomap_seek_hole_actor);
+	while (offset < size) {
+		ret = iomap_apply(inode, offset, size - offset, IOMAP_REPORT,
+				  ops, &offset, iomap_seek_hole_actor);
 		if (ret < 0)
 			return ret;
 		if (ret == 0)
 			break;
 
 		offset += ret;
-		length -= ret;
 	}
 
 	return offset;
