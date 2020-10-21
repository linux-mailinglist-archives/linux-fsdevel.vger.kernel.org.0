Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7BCA2953A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Oct 2020 22:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505523AbgJUUvh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Oct 2020 16:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505515AbgJUUvh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Oct 2020 16:51:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6E1C0613CE;
        Wed, 21 Oct 2020 13:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sUEKBUAgZWe3dgX0PdompQ/peEr+G2xBZ/JEYSmVRNw=; b=SDHQZqm9jNTGspFAwjWM2vK06V
        Wvd/oDJmdYiuaj498Fk6KTsX3RSViI3YOZDmjYuG0ZtxZYIHVZUS5wY6DHX2NMuqXUuEkXLRRpNl1
        nfd+NwruUsH5bjS0q3X5P62ISeslUTPD5SL4LM17NBpiuqeJ4BD7pOQHJX4PONEFrMaQdrahjkPrV
        5BaYHgzjZza7h3Pkbf7x0jaHhBhv9bKTmMFflsNeRXHUGK+wzmvpAkKZDQe6ivATu7xnnKVSAfy0a
        x4REeIgXNeXys7KcfEHYy2ujCQDgmYng5Uhg1OEcUtt/7RFuVrnvAcNyFVbgMAXX5BcOfm9pY20i1
        VwpxpxkQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVL55-0006pM-7n; Wed, 21 Oct 2020 20:51:35 +0000
Date:   Wed, 21 Oct 2020 21:51:35 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org, sfrench@samba.org,
        linux-cifs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] fs: kill add_to_page_cache_locked()
Message-ID: <20201021205135.GO20115@casper.infradead.org>
References: <20201021195745.3420101-1-kent.overstreet@gmail.com>
 <20201021195745.3420101-3-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021195745.3420101-3-kent.overstreet@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 21, 2020 at 03:57:45PM -0400, Kent Overstreet wrote:
>  }
> -ALLOW_ERROR_INJECTION(__add_to_page_cache_locked, ERRNO);
> +ALLOW_ERROR_INJECTION(__add_to_page_cache, ERRNO);
[..]
> +int add_to_page_cache(struct page *page, struct address_space *mapping,
> +		      pgoff_t offset, gfp_t gfp_mask)
>  {
> -	return __add_to_page_cache_locked(page, mapping, offset,
> -					  gfp_mask, NULL);
> +	return __add_to_page_cache(page, mapping, offset, gfp_mask, NULL);
>  }
> -EXPORT_SYMBOL(add_to_page_cache_locked);
> +EXPORT_SYMBOL(add_to_page_cache);
> +ALLOW_ERROR_INJECTION(add_to_page_cache, ERRNO);

I don't think you need this second one since __add_to_page_cache can be
used for the same purpose.
