Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB726424962
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 00:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239770AbhJFWDy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 18:03:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30024 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230213AbhJFWDy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 18:03:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633557721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KwYOi5FBnZz/GGBHEzCJubt9MvgZTdgF9/2Py157wwg=;
        b=gTevRTiAb6CA/rjwNIw6TjVuxy1w4I7xdaWCNFMiJl9VkKxv7juND/TvMSSdSBhKFZx7GE
        IJ9t6WJi+6AiibS3wvbVJrwWiNdMWDCBeBhtDEH6D709mvvHgdRjmD/hJaUQM3/4ViN18F
        VTEo1Vm6AMe9dl6fBk4seuGJv9Sdy0U=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-C157u8G1PLKs22zfTEJFOg-1; Wed, 06 Oct 2021 18:02:00 -0400
X-MC-Unique: C157u8G1PLKs22zfTEJFOg-1
Received: by mail-qt1-f197.google.com with SMTP id e5-20020ac84905000000b002a69dc43859so3331406qtq.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Oct 2021 15:01:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KwYOi5FBnZz/GGBHEzCJubt9MvgZTdgF9/2Py157wwg=;
        b=D5m2WKpurb5H2kV4LBcKZZiHkuIbU2KkXb5DVj34ccdTI+FtcU2jfBx5zujqCRLoTr
         D23D7+L93LyS3ISHRKr5/Ht4Si12ZO5W48Y8NaTPSasks3sGjot7Ydbofr6Eudh52bBM
         wRvw97vnxFZmXdTEJ43jKiKOtLU/Oav8VClnVEGPCWH/wAj9OWw0VaBJc18EJNg2Y0U0
         xOwSxeUYEWpbh/SGkFPlL2iGPIvy/kF7YWnb0kP2IImhOeI1tB4qeA9orP8ZTAIVG9qI
         aMsVGam8mzqkdAKLvQ610twTtJaZLsObmoYRDQZVpJh26IqHp6DDmiVZPw40AG5X1/hi
         CiDg==
X-Gm-Message-State: AOAM532jy5IEnYxo/HjiQfPEGIsxXGC/VDHL4Ad7YYFDFattvgY/TVuZ
        Q4/S5zYwiQYSsdQJXwm4KGc6zXXRbyBIXFOmtiqfobzfCm1xNaOBThA0GLhhltwwG1DAEC/G1bp
        3FSNUWL/ABngBGTuzhiVNZ4oucg==
X-Received: by 2002:ac8:72d3:: with SMTP id o19mr799988qtp.19.1633557719536;
        Wed, 06 Oct 2021 15:01:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUY14CsRfg/wBWv/+kqo9Sz/TvI8iid6C/lEFVyVZtsk5eS9VSjdeR6pwre/6nqu4PMIIBHA==
X-Received: by 2002:ac8:72d3:: with SMTP id o19mr799947qtp.19.1633557719251;
        Wed, 06 Oct 2021 15:01:59 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::bed8])
        by smtp.gmail.com with ESMTPSA id o23sm14084849qtl.74.2021.10.06.15.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 15:01:58 -0700 (PDT)
Date:   Wed, 6 Oct 2021 18:01:57 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        osalvador@suse.de, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH 3/5] mm: hwpoison: refactor refcount check handling
Message-ID: <YV4c1dOfctEMnH2s@t490s>
References: <20210930215311.240774-1-shy828301@gmail.com>
 <20210930215311.240774-4-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210930215311.240774-4-shy828301@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 30, 2021 at 02:53:09PM -0700, Yang Shi wrote:
> +/*
> + * Return true if page is still referenced by others, otherwise return
> + * false.
> + *
> + * The dec is true when one extra refcount is expected.
> + */
> +static bool has_extra_refcount(struct page_state *ps, struct page *p,
> +			       bool dec)

Nit: would it be nicer to keep using things like "extra_pins", so we pass in 1
for swapcache dirty case and 0 for the rest?  Then it'll also match with most
of the similar cases in e.g. huge_memory.c (please try grep "extra_pins" there).

> +{
> +	int count = page_count(p) - 1;
> +
> +	if (dec)
> +		count -= 1;
> +
> +	if (count > 0) {
> +		pr_err("Memory failure: %#lx: %s still referenced by %d users\n",
> +		       page_to_pfn(p), action_page_types[ps->type], count);
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
>  /*
>   * Error hit kernel page.
>   * Do nothing, try to be lucky and not touch this instead. For a few cases we
>   * could be more sophisticated.
>   */
> -static int me_kernel(struct page *p, unsigned long pfn)
> +static int me_kernel(struct page_state *ps, struct page *p)

Not sure whether it's intended, but some of the action() hooks do not call the
refcount check now while in the past they'll all do.  Just to double check
they're expected, like this one and me_unknown().

>  {
>  	unlock_page(p);
>  	return MF_IGNORED;
> @@ -820,9 +852,9 @@ static int me_kernel(struct page *p, unsigned long pfn)
>  /*
>   * Page in unknown state. Do nothing.
>   */
> -static int me_unknown(struct page *p, unsigned long pfn)
> +static int me_unknown(struct page_state *ps, struct page *p)
>  {
> -	pr_err("Memory failure: %#lx: Unknown page state\n", pfn);
> +	pr_err("Memory failure: %#lx: Unknown page state\n", page_to_pfn(p));
>  	unlock_page(p);
>  	return MF_FAILED;
>  }

Thanks,

-- 
Peter Xu

