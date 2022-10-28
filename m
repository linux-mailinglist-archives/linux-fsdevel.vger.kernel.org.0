Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3AF610928
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 06:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiJ1EGD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 00:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJ1EGB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 00:06:01 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CE6868AF
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Oct 2022 21:05:58 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso3451410pjc.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Oct 2022 21:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DjNDCmtaDyTi+sX4Pf3JIZExNUHwda3QT7q2egtTo8o=;
        b=ehFygeg6pvPoUkRY2wnMRQX/o1fRtwAX2R3z3ASXeuUd78DEW1Z0nOfhPXJ7NogC0e
         E0UbLdWdbkarxIyEEd8gNYTSs6idNgMz4PDO7QZ1IccG63wEFOnKex96rkTUx9Z278JD
         qr46xCNErRJJXJ6MKtLu6n+gLu067+MrzJph+FoBOz23+WMqdL6X/7TBvxUgaerW23Pa
         RytfAcL/b5LdIpIUSZnF+HKARwDQSeUcTXpg5ae2oSMKp98nOmyjZiAq0jFTs+njWFaQ
         TlF9KYDEIny2rsoEnvGq23Kp798C1TIb7AVzzuhXOvDe1n4VrWKSRsafY0gvLDg4YjeN
         NkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjNDCmtaDyTi+sX4Pf3JIZExNUHwda3QT7q2egtTo8o=;
        b=YbAz+VdioSbPa2HXiV3zxxgi7L+2qxWXUj4N3J8Y7osuylOvI//BYHAJkNnkbBtE8p
         LIY5soBjt7IVqt7Up4GzSjL7Vf7szm6gkdrmWATTqsxeyFyZEamSL/XmWyi+6jYzUvB+
         NoDEAeRPkwiJT9h9zLNTlBxDY66IevLINB6BgZmyG/AhAmtUQ6JAgCYgE3wo/G1+tnXh
         VLqJMI9aMBRCI2P6+GeoLjQaPqyxvP4SNZzFtgF1XoOBHJJz4KgYdQjCaJRJfTslhs0Q
         R+ufugqZTx8nyzqwnL7G0gTtRWrw7BEDgbYYPbUuvczWVOP/VllyerNJVXa1fEoMQydV
         Z+eg==
X-Gm-Message-State: ACrzQf2uHgW3DovGjd8gXutWNTkw9T8Xv0KxvTb5ARS40M/vRtU/dOZv
        D2+AFHl5vulJDgqSyyZuQiB39g==
X-Google-Smtp-Source: AMsMyM5FMep431PxudoLZ+qRT7bNktV8krQz5EsyQfpx+NFq0RdtPmkCAgZVxbZob/qWSUVYMWQcfA==
X-Received: by 2002:a17:902:74c3:b0:182:57fa:b9c4 with SMTP id f3-20020a17090274c300b0018257fab9c4mr566074plt.104.1666929958311;
        Thu, 27 Oct 2022 21:05:58 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au. [49.181.106.210])
        by smtp.gmail.com with ESMTPSA id a4-20020a1709027e4400b001801aec1f6bsm1945602pln.141.2022.10.27.21.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 21:05:57 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ooGd0-007Gjv-PK; Fri, 28 Oct 2022 15:05:54 +1100
Date:   Fri, 28 Oct 2022 15:05:54 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Zhaoyang Huang <huangzhaoyang@gmail.com>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        steve.kang@unisoc.com, baocong.liu@unisoc.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: move xa forward when run across zombie page
Message-ID: <20221028040554.GU2703033@dread.disaster.area>
References: <Y0lSChlclGPkwTeA@casper.infradead.org>
 <CAGWkznG=_A-3A8JCJEoWXVcx+LUNH=gvXjLpZZs0cRX4dhUJfQ@mail.gmail.com>
 <Y017BeC64GDb3Kg7@casper.infradead.org>
 <CAGWkznEdtGPPZkHrq6Y_+XLL37w12aC8XN8R_Q-vhq48rFhkSA@mail.gmail.com>
 <Y04Y3RNq6D2T9rVw@casper.infradead.org>
 <20221018223042.GJ2703033@dread.disaster.area>
 <Y1AWXiJdyjdLmO1E@casper.infradead.org>
 <20221019220424.GO2703033@dread.disaster.area>
 <Y1HDDu3UV0L3cDwE@casper.infradead.org>
 <Y1lZ9Rm87GpFRM/Q@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1lZ9Rm87GpFRM/Q@casper.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 26, 2022 at 05:01:57PM +0100, Matthew Wilcox wrote:
> On Thu, Oct 20, 2022 at 10:52:14PM +0100, Matthew Wilcox wrote:
> > But I think the tests you've done refute that theory.  I'm all out of
> > ideas at the moment.
> 
> I have a new idea.  In page_cache_delete_batch(), we don't set the
> order of the entry before calling xas_store().  That means we can end
> up in a situation where we have an order-2 folio in the page cache,
> delete it and end up with a NULL pointer at (say) index 20 and sibling
> entries at indices 21-23.  We can come along (potentially much later)
> and put an order-0 folio back at index 20.  Now all of indices 20-23
> point to the index-20, order-0 folio.  Worse, the xarray node can be
> freed with the sibling entries still intact and then be reallocated by
> an entirely different xarray.
> 
> I don't know if this is going to fix the problem you're seeing.  I can't
> quite draw a line from this situation to your symptoms.  I came across
> it while auditing all the places which set folio->mapping to NULL.
> I did notice a mis-ordering; all the other places first remove the folio
> from the xarray before setting folio to NULL, but I have a hard time
> connecting that to your symptoms either.
> 
> diff --git a/include/linux/xarray.h b/include/linux/xarray.h
> index 44dd6d6e01bc..cc1fd1f849a7 100644
> --- a/include/linux/xarray.h
> +++ b/include/linux/xarray.h
> @@ -1617,6 +1617,12 @@ static inline void xas_advance(struct xa_state *xas, unsigned long index)
>  	xas->xa_offset = (index >> shift) & XA_CHUNK_MASK;
>  }
>  
> +static inline void xas_adjust_order(struct xa_state *xas, unsigned int order)
> +{
> +	xas->xa_shift = order - (order % XA_CHUNK_SHIFT);
> +	xas->xa_sibs = (1 << (order % XA_CHUNK_SHIFT)) - 1;
> +}
> +
>  /**
>   * xas_set_order() - Set up XArray operation state for a multislot entry.
>   * @xas: XArray operation state.
> @@ -1628,8 +1634,7 @@ static inline void xas_set_order(struct xa_state *xas, unsigned long index,
>  {
>  #ifdef CONFIG_XARRAY_MULTI
>  	xas->xa_index = order < BITS_PER_LONG ? (index >> order) << order : 0;
> -	xas->xa_shift = order - (order % XA_CHUNK_SHIFT);
> -	xas->xa_sibs = (1 << (order % XA_CHUNK_SHIFT)) - 1;
> +	xas_adjust_order(xas, order);
>  	xas->xa_node = XAS_RESTART;
>  #else
>  	BUG_ON(order > 0);
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 08341616ae7a..6e3f486131e4 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -305,11 +305,13 @@ static void page_cache_delete_batch(struct address_space *mapping,
>  
>  		WARN_ON_ONCE(!folio_test_locked(folio));
>  
> +		if (!folio_test_hugetlb(folio))
> +			xas_adjust_order(&xas, folio_order(folio));
> +		xas_store(&xas, NULL);
>  		folio->mapping = NULL;
>  		/* Leave folio->index set: truncation lookup relies on it */
>  
>  		i++;
> -		xas_store(&xas, NULL);
>  		total_pages += folio_nr_pages(folio);
>  	}
>  	mapping->nrpages -= total_pages;

Nope, that ain't it. I think I've got the data corruption fix sorted
now (at least, g/270 isn't assert failing on stray delalloc extents
anymore), so if that's the case, I can spend some time actively
trying to track this down....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
