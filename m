Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2666C5872E9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Aug 2022 23:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbiHAVOu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Aug 2022 17:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiHAVOt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Aug 2022 17:14:49 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2192F3C161
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Aug 2022 14:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hobwk6PDWvRnlLpBRqtlKjYD+ldHSmfHhWRUfLNw/yo=; b=Yhvt5fh46fLEg9EQbWHwTrUuFY
        u/dbOLR0GaPjkzQJSTJ7mDv/iZItbKNaia7aXq1aR9jO26TPw0AwSjLH/GJ1PX+VGjLduW7JnvgKU
        htXbF+18BlFDRfZkkGlXzigCH7mR987ahIpZM68XA+EY4xTNoO0F9AElGSYPionA2lbB5oD+nCc4b
        jfS4z4AgZZo1g+BYMIoU8wVpCzMc7UHGrDNYNipDv33+kpv6azXEA80rQRfRIgZFIfkEUF9nJ4hS3
        F8oyyYCE6zbfHiztBjMuqSvGJP2F6F0YD3vMkdMsMCQ8jXlOS0FksG5daxgG1XDsnCWhQOZjdWSf/
        5HARUeYQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oIckP-000PeA-DT;
        Mon, 01 Aug 2022 21:14:45 +0000
Date:   Mon, 1 Aug 2022 22:14:45 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 09/44] new iov_iter flavour - ITER_UBUF
Message-ID: <YuhCRa9XFfacwWgU@ZenIV>
References: <20220622041552.737754-9-viro@zeniv.linux.org.uk>
 <YrKWRCOOWXPHRCKg@ZenIV>
 <20220622041552.737754-1-viro@zeniv.linux.org.uk>
 <2806275.1659357724@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2806275.1659357724@warthog.procyon.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 01, 2022 at 01:42:04PM +0100, David Howells wrote:
> You need to modify dup_iter() also.  That will go through the:
> 
> 		return new->iov = kmemdup(new->iov,
> 				   new->nr_segs * sizeof(struct iovec),
> 				   flags);
> 
> case with a ubuf-class iterators, which will clobber new->ubuf.
> 
> David

Fixed, folded and pushed out.  Incremental:

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 939078ffbfb5..46ec07886d7b 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1659,17 +1659,16 @@ const void *dup_iter(struct iov_iter *new, struct iov_iter *old, gfp_t flags)
 		WARN_ON(1);
 		return NULL;
 	}
-	if (unlikely(iov_iter_is_discard(new) || iov_iter_is_xarray(new)))
-		return NULL;
 	if (iov_iter_is_bvec(new))
 		return new->bvec = kmemdup(new->bvec,
 				    new->nr_segs * sizeof(struct bio_vec),
 				    flags);
-	else
+	else if (iov_iter_is_kvec(new) || iter_is_iovec(new))
 		/* iovec and kvec have identical layout */
 		return new->iov = kmemdup(new->iov,
 				   new->nr_segs * sizeof(struct iovec),
 				   flags);
+	return NULL;
 }
 EXPORT_SYMBOL(dup_iter);
 
