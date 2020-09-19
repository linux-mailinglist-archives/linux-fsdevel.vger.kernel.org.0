Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696F8270B1D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Sep 2020 08:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgISGbD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Sep 2020 02:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgISGbD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Sep 2020 02:31:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290EEC0613CE;
        Fri, 18 Sep 2020 23:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gCfRMQDlKt9WzvOtrCHvtw3aUOEiJiFkpDbStYvBSdw=; b=L0UhmbylOF2D6E4Fu/SRLO5WFu
        8wICNyR1d5ddftzKvfqYVOOQXvXACr64hOiIaaVpgRCbFCNZNUUQ3Cg8PdQY2Jsguu0NFvXm4t3wu
        R79GdiaQydWHWfElL5rHYA3UzZjQS5XBLHFMS6kWQmADOQhBaswwzu2OXWQ/wow+8bgtZFFoIYm+9
        cJ+B2HyuEhCniXawj0bQEA1qxQb9zUlj2lZ0ZQyBizJlEBDVbst3zE5LnJVP3xhNu94r7/vwWoEEe
        fw/HjrfyQEbprFTTzmLNIxmRjLn3Gxo1tJmyFLdgsXQGGwXKp+8otgwpOayFF1yBGhL5zqJXNOCb3
        eR6x/u4A==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJWOj-0003r8-NG; Sat, 19 Sep 2020 06:31:01 +0000
Date:   Sat, 19 Sep 2020 07:31:01 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 14/13] iomap: Inline iomap_iop_set_range_uptodate into
 its one caller
Message-ID: <20200919063101.GF13501@infradead.org>
References: <20200917151050.5363-1-willy@infradead.org>
 <20200917225647.26481-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917225647.26481-1-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 17, 2020 at 11:56:45PM +0100, Matthew Wilcox (Oracle) wrote:
> iomap_set_range_uptodate() is the only caller of
> iomap_iop_set_range_uptodate() and it makes future patches easier to
> have it inline.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/iomap/buffered-io.c | 24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 897ab9a26a74..2a6492b3c4db 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -135,8 +135,8 @@ iomap_adjust_read_range(struct inode *inode, struct iomap_page *iop,
>  	*lenp = plen;
>  }
>  
> -static void
> -iomap_iop_set_range_uptodate(struct page *page, unsigned off, unsigned len)
> +static
> +void iomap_set_range_uptodate(struct page *page, unsigned off, unsigned len)

Please don't use such weird formatting for the prototype, the existing
one is perfectly fine, and the Linus approved version would be the
static and the type on the same line. 
