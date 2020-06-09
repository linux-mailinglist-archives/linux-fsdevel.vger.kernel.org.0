Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B900C1F4289
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 19:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbgFIRiy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 13:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728603AbgFIRiy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:38:54 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97E4C05BD1E;
        Tue,  9 Jun 2020 10:38:53 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id l1so17035115ede.11;
        Tue, 09 Jun 2020 10:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PhIgWmwqTHHYLFRj9bS4pjY8kRjpr8XQeQwjE1P6dO4=;
        b=Nf8qYs3ffgfdyGaKS/hwyfl6ID0k2oY8vglNmHU7kHmrSL+IPnb5vv3zWboci731Ve
         NlOON4kxYp54uiVEzZRF24LHoVla7fuhD96R88F5kq220CrRi+FkhrU0aarJp1nXx/+k
         qqT4UUlljP2X4lg0BMYWvdZjSqEk8OZ4BW2/CTxjXaor7ZZqxYa6LVvB76koCFD9bh2Q
         Cfm+xQ/z5kU3e6cLR8tz1iSil5yxALM61WQJquhHjQywrkxP7DaBxEQURjCu1NT+7YMZ
         /I2xKNmTnkyT1uVfTxM/zt0y6oV2hhz32F+dAqYE4Qowysuju+ACLA9+lRYDqatzp/uW
         Xdew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PhIgWmwqTHHYLFRj9bS4pjY8kRjpr8XQeQwjE1P6dO4=;
        b=DkkAuEgm/DyWkcj+YbaGrl+P4ZDj5MoYpXzEvPu/VQMpUQTyfF8+Ky9ymYsc7GII2Y
         vthuNvIz1gKYP9a9sGRPCTqL9SRHVS6pXBMr+/joJOg1xL69DHojYiTMDkRQiyBv8Meh
         i/xWGZl30cj/eWrYcC3zvqMptch0M3xLJXSUtgNotAjLprghgAdrbqQ7lmuTtzyyrQOy
         4B1t6m+DOLYLYSktaZ9SmwJnctvcXNj+bAr4toiS4lk3NhKQ8q9y1JeHAsecvFsQ1Fbv
         mJwdUXmW2GZavqFrxfo98N2yt7zCY/EeccgiKRlIzgHv+CbXhtj8H/cGMzVcFwbD8+Fb
         HUEQ==
X-Gm-Message-State: AOAM53050UCvFjcWH04+L9qduNVW7EsG8HpTII9QV0eOZZNFfP0nwI2a
        1/xsM2+sVST/25cvPmvi1bETpLi67ffqGdzqXtE=
X-Google-Smtp-Source: ABdhPJyzF/oqxiQcpDv42b2V3XczCloQQHDIKu/J7WPLxZzRjf0KJt9cN0SEvPjPXZu2usVEJrk/nEELX6Iv0IkLcsU=
X-Received: by 2002:a50:9e21:: with SMTP id z30mr26917408ede.347.1591724332496;
 Tue, 09 Jun 2020 10:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200429133657.22632-1-willy@infradead.org> <20200429133657.22632-18-willy@infradead.org>
 <CAHbLzkrEmEvVXmhPfngjkLP5iT_GH2SyRhDbHAiC7D2De8xyjw@mail.gmail.com> <20200607030847.GS19604@bombadil.infradead.org>
In-Reply-To: <20200607030847.GS19604@bombadil.infradead.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 9 Jun 2020 10:38:09 -0700
Message-ID: <CAHbLzko_sxTfv3Po1FcjJ4K0Y1q+41eBzC4YhhRq1BBVNh7VSA@mail.gmail.com>
Subject: Re: [PATCH v3 17/25] mm: Add __page_cache_alloc_order
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 6, 2020 at 8:08 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, May 06, 2020 at 11:03:06AM -0700, Yang Shi wrote:
> > > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > > index 55199cb5bd66..1169e2428dd7 100644
> > > --- a/include/linux/pagemap.h
> > > +++ b/include/linux/pagemap.h
> > > @@ -205,15 +205,33 @@ static inline int page_cache_add_speculative(struct page *page, int count)
> > >         return __page_cache_add_speculative(page, count);
> > >  }
> > >
> > > +static inline gfp_t thp_gfpmask(gfp_t gfp)
> > > +{
> > > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > > +       /* We'd rather allocate smaller pages than stall a page fault */
> > > +       gfp |= GFP_TRANSHUGE_LIGHT;
> >
> > This looks not correct. GFP_TRANSHUGE_LIGHT may set GFP_FS, but some
> > filesystem may expect GFP_NOFS, i.e. in readahead path.
>
> Apologies, I overlooked this mail.
>
> In one of the prerequisite patches for this patch set (which is now merged
> as f2c817bed58d9be2051fad1d18e167e173c0c227), we call memalloc_nofs_save()
> in the readahead path.  That ensures all allocations will have GFP_NOFS
> set by the time the page allocator sees them.
>
> Thanks for checking on this.

Aha, yes, correct. I missed that. Thanks for finding that commit.
