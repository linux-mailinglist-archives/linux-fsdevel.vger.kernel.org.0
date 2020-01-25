Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE9CF14975B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2020 20:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgAYTJw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Jan 2020 14:09:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57876 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgAYTJw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Jan 2020 14:09:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=My5//NJQysYMT+Wea8KLUdQ/Ww11h9Uv4t+v7jFecDU=; b=fFmYgDNNvt77kQV4xKWYDlosj
        tCRnFy39irUUteCkoPzUlBM/Wm5FkejDjX1gLGOh1AOSU9xWtasFCl6Yk4gnJp6YHhDtEnfffUKLF
        EBp2IlTESitbhAv7sRphU+1LFGbjMg61Nw3xVl/bb+yYBk+izXwb/6w33+zt3U0xxf/W/ggVQJ07u
        C+r9ejvmR76/vpb7qv/B3UnJlBSOjzyCBm6eBaw8FGfOYR0uAYkhizpzn61a5zTykX2GN2qAM6O8x
        MUsWC+f6ZstKPT6dK6hp2fpwysNavccb6La+1kyQ4NeJT5uZiEB2XGltOcYtJtuxj3lzmJR+FTww1
        4eL0GLFtA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ivQoZ-00036i-67; Sat, 25 Jan 2020 19:09:51 +0000
Date:   Sat, 25 Jan 2020 11:09:51 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/12] erofs: Convert uncompressed files from readpages
 to readahead
Message-ID: <20200125190951.GN4675@bombadil.infradead.org>
References: <20200125013553.24899-1-willy@infradead.org>
 <20200125013553.24899-8-willy@infradead.org>
 <20200125015323.GA9918@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200125015323.GA9918@hsiangkao-HP-ZHAN-66-Pro-G1>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 25, 2020 at 09:53:29AM +0800, Gao Xiang wrote:
> > +		/* all the page errors are ignored when readahead */
> > +		if (IS_ERR(bio)) {
> > +			pr_err("%s, readahead error at page %lu of nid %llu\n",
> > +			       __func__, page->index,
> > +			       EROFS_I(mapping->host)->nid);
> >  
> > -				bio = NULL;
> > -			}
> > +			bio = NULL;
> > +			put_page(page);
> 
> Out of curiously, some little question... Why we need put_page(page) twice
> if erofs_read_raw_page returns with error...
> 
> One put_page(page) is used as a temporary reference count for this request,
> we could put_page(page) in advance since pages are still locked before endio.
> 
> Another put_page(page) is used for page cache xarray. I think in this case
> the page has been successfully inserted to the page cache anyway, after erroring
> out it will trigger .readpage again... so probably we need to keep this
> refcount count for page cache xarray?
> 
> If I'm missing something, kindly correct me if I'm wrong....

You're quite right.  After readahead has completed, the page should have
a refcount of 1 and be unlocked.  If we hit an error, the page should
be !uptodate.  It doesn't matter whether we set PageError or not in this
case; filemap_fault() will ClearPageError() before retrying if the page
is !uptodate.  This extra put_page() is wrong, and I'll remove it from
the next version.  Thanks!
