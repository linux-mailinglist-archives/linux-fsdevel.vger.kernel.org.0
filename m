Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F12B213981
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jul 2020 13:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgGCLlN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jul 2020 07:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgGCLlM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jul 2020 07:41:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1292DC08C5C1;
        Fri,  3 Jul 2020 04:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=brKPBqGkq9UpOiE2pzCiAvP7F0wRaBf/lffdYdZP/rY=; b=XocJJ6PESJAwgCpUXDyHtQLyEY
        ImvwQMMgXfNfl/2vJRzeoMsFHOQbc6U3VvRGZALaGzCRdcq4/Py/xEghTVrPLnzQCwkwKIaAXICoz
        Kg+2CbynrhQfNNo33tS8nq3CUUujct0ek/qAb5kNGsAU5zis0gLisiajUb5NHL+N+yondC6UIpCgk
        iwJIX+U6eRrE6Iez6yUgNwYxpKrIGUzffzSf8NqCKeVftBWuOLbFtBdAggk+5DAxT+6hGVM/dmVeY
        sznKaHOF8crWlVtyREAfZ26xGBqikJF0sdqoDeVS3v6yyIvKl1ecLCyjzwY1rcKwAy0WFkVrFWEU/
        sHa/Plxw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrK45-0000Gn-0o; Fri, 03 Jul 2020 11:41:09 +0000
Date:   Fri, 3 Jul 2020 12:41:08 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 1/2] fs: Add IOCB_NOIO flag for generic_file_read_iter
Message-ID: <20200703114108.GE25523@casper.infradead.org>
References: <20200703095325.1491832-1-agruenba@redhat.com>
 <20200703095325.1491832-2-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703095325.1491832-2-agruenba@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 03, 2020 at 11:53:24AM +0200, Andreas Gruenbacher wrote:
> Add an IOCB_NOIO flag that indicates to generic_file_read_iter that it
> shouldn't trigger any filesystem I/O for the actual request or for
> readahead.  This allows to do tentative reads out of the page cache as
> some filesystems allow, and to take the appropriate locks and retry the
> reads only if the requested pages are not cached.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

> @@ -2249,9 +2253,18 @@ EXPORT_SYMBOL_GPL(generic_file_buffered_read);
>   *
>   * This is the "read_iter()" routine for all filesystems
>   * that can use the page cache directly.
> + *
> + * The IOCB_NOWAIT flag in iocb->ki_flags indicates that -EAGAIN shall
> + * be returned when no data can be read without waiting for I/O requests
> + * to complete; it doesn't prevent readahead.
> + *
> + * The IOCB_NOIO flag in iocb->ki_flags indicates that -EAGAIN shall be
> + * returned when no data can be read without issuing new I/O requests,
> + * and 0 shall be returned when readhead would have been triggered.

s/shall/may/ -- if we read a previous page then hit a readahead page,
we'll return a positive value.  If the first page we hit is a readahead
page, then yes, we'll return zero.

Again, I'm happy for the patch to go in as-is without this nitpick.

