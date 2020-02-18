Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74776162BA0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 18:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgBRRK2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 12:10:28 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42239 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgBRRK2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 12:10:28 -0500
Received: by mail-lj1-f195.google.com with SMTP id d10so23850580ljl.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2020 09:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eT/SN5oR8qHPpwEwvT6iuViW5jmEYiDg693/zU5SNAg=;
        b=DPideaKc6XhYHrfdqmi4V+8rc64F/Un2cc960MB+K0JNtI8pF0+oVuz3jr6UBwPjSj
         EMLUuSTbV0urSh1AhsihcUH584B2F+YpDP89CzrcJOEY0Kw/EXsn9BT7sNrLqPGH/Xnp
         0AGQU/SbZx74+VvU1j+uQlXwQmkU/vshFLYhLWGL4VJJ120OmmskJaWIQ9C+owkKUL5P
         0ygdF66U2NQDTToh2eir3vBGTsLY3j7BDiSBqFnerxBcQAd+Uthsld4ugZ3SpKwud/8g
         EQaZ723iAPF+HYUoZlTFweS1Vhhv+K0PYkPCQAnr8SAZKDs2olZvnX9aSUcgaOiaq0Wl
         7kpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eT/SN5oR8qHPpwEwvT6iuViW5jmEYiDg693/zU5SNAg=;
        b=eSQIptcgvvLJscaYwZi1hDcqtUxkDHeWI2o8uk4vwCc80SW86lpS1XhopDpiILagt6
         i9uBGdTRWgVxKCkxtvYvHXlY61Zs7XCA6X5ewejEUTQAlbbeFOUF3hnO9OKv3rF0agAZ
         se2qxxY3HW+oaO+U2Gs3W61V55bX3Tx9XVuB2c9WotidCExc2EpDeU/bjuf5MTHruZ37
         ldX0n0PKQ7sFzqhhcdAa14ji2k85JMdtHYSqrfsW2DROILk0299MsqnYr1uj42jcg3r9
         07NPYfCpZwIHZHUvkzDoj89gcZucf/PrfAoopwzHyR1ox6fL+XZ3EZ1AITSerUiuHRy/
         sSTQ==
X-Gm-Message-State: APjAAAXwI/8UGd8no4Ub4Ht4NsR0VJGiLaSLiarAvDjK2ADsF/RgMF6R
        x5EofAE7aLTPRTnuaET3iHKYwQ==
X-Google-Smtp-Source: APXvYqyTpRJaS4fne7NiUOz22DmT8TIqeKU8alDA7ovxWpU8wfrX3NeC0ZOYQP/eplYqZsXOocoRZw==
X-Received: by 2002:a2e:9842:: with SMTP id e2mr13545781ljj.293.1582045825346;
        Tue, 18 Feb 2020 09:10:25 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id p26sm2619929lfh.64.2020.02.18.09.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 09:10:24 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 1BF1D100FA6; Tue, 18 Feb 2020 20:10:52 +0300 (+03)
Date:   Tue, 18 Feb 2020 20:10:52 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/25] fs: Add zero_user_large
Message-ID: <20200218171052.lwd56nr332qjgs5j@box>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-14-willy@infradead.org>
 <20200214135248.zqcqx3erb4pnlvmu@box>
 <20200214160342.GA7778@bombadil.infradead.org>
 <20200218141634.zhhjgtv44ux23l3l@box>
 <20200218161349.GS7778@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218161349.GS7778@bombadil.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 08:13:49AM -0800, Matthew Wilcox wrote:
> On Tue, Feb 18, 2020 at 05:16:34PM +0300, Kirill A. Shutemov wrote:
> > > +               if (start1 >= PAGE_SIZE) {
> > > +                       start1 -= PAGE_SIZE;
> > > +                       end1 -= PAGE_SIZE;
> > > +                       if (start2) {
> > > +                               start2 -= PAGE_SIZE;
> > > +                               end2 -= PAGE_SIZE;
> > > +                       }
> > 
> > You assume start2/end2 is always after start1/end1 in the page.
> > Is it always true? If so, I would add BUG_ON() for it.
> 
> after or zero.  Yes, I should add a BUG_ON to check for that.
> 
> > Otherwise, looks good.
> 
> Here's what I currently have (I'll add the BUG_ON later):
> 
> commit 7fabe16755365cdc6e80343ef994843ecebde60a
> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> Date:   Sat Feb 1 03:38:49 2020 -0500
> 
>     fs: Support THPs in zero_user_segments
>     
>     We can only kmap() one subpage of a THP at a time, so loop over all
>     relevant subpages, skipping ones which don't need to be zeroed.  This is
>     too large to inline when THPs are enabled and we actually need highmem,
>     so put it in highmem.c.
>     
>     Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

> 
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index ea5cdbd8c2c3..74614903619d 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -215,13 +215,18 @@ static inline void clear_highpage(struct page *page)
>         kunmap_atomic(kaddr);
>  }
>  
> +#if defined(CONFIG_HIGHMEM) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
> +void zero_user_segments(struct page *page, unsigned start1, unsigned end1,
> +               unsigned start2, unsigned end2);
> +#else /* !HIGHMEM || !TRANSPARENT_HUGEPAGE */

This is a neat trick. I like it.

Although, it means non-inlined version will never get tested :/

>  static inline void zero_user_segments(struct page *page,
> -       unsigned start1, unsigned end1,
> -       unsigned start2, unsigned end2)
> +               unsigned start1, unsigned end1,
> +               unsigned start2, unsigned end2)
>  {
> +       unsigned long i;
>         void *kaddr = kmap_atomic(page);
>  
> -       BUG_ON(end1 > PAGE_SIZE || end2 > PAGE_SIZE);
> +       BUG_ON(end1 > thp_size(page) || end2 > thp_size(page));
>  
>         if (end1 > start1)
>                 memset(kaddr + start1, 0, end1 - start1);
> @@ -230,8 +235,10 @@ static inline void zero_user_segments(struct page *page,
>                 memset(kaddr + start2, 0, end2 - start2);
>  
>         kunmap_atomic(kaddr);
> -       flush_dcache_page(page);
> +       for (i = 0; i < hpage_nr_pages(page); i++)
> +               flush_dcache_page(page + i);
>  }
> +#endif /* !HIGHMEM || !TRANSPARENT_HUGEPAGE */
>  
>  static inline void zero_user_segment(struct page *page,
>         unsigned start, unsigned end)
> diff --git a/mm/highmem.c b/mm/highmem.c
> index 64d8dea47dd1..3a85c66ef532 100644
> --- a/mm/highmem.c
> +++ b/mm/highmem.c
> @@ -367,9 +367,67 @@ void kunmap_high(struct page *page)
>         if (need_wakeup)
>                 wake_up(pkmap_map_wait);
>  }
> -
>  EXPORT_SYMBOL(kunmap_high);
> -#endif
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +void zero_user_segments(struct page *page, unsigned start1, unsigned end1,
> +               unsigned start2, unsigned end2)
> +{
> +       unsigned int i;
> +
> +       BUG_ON(end1 > thp_size(page) || end2 > thp_size(page));
> +
> +       for (i = 0; i < hpage_nr_pages(page); i++) {
> +               void *kaddr;
> +               unsigned this_end;
> +
> +               if (end1 == 0 && start2 >= PAGE_SIZE) {
> +                       start2 -= PAGE_SIZE;
> +                       end2 -= PAGE_SIZE;
> +                       continue;
> +               }
> +
> +               if (start1 >= PAGE_SIZE) {
> +                       start1 -= PAGE_SIZE;
> +                       end1 -= PAGE_SIZE;
> +                       if (start2) {
> +                               start2 -= PAGE_SIZE;
> +                               end2 -= PAGE_SIZE;
> +                       }
> +                       continue;
> +               }
> +
> +               kaddr = kmap_atomic(page + i);
> +
> +               this_end = min_t(unsigned, end1, PAGE_SIZE);
> +               if (end1 > start1)
> +                       memset(kaddr + start1, 0, this_end - start1);
> +               end1 -= this_end;
> +               start1 = 0;
> +
> +               if (start2 >= PAGE_SIZE) {
> +                       start2 -= PAGE_SIZE;
> +                       end2 -= PAGE_SIZE;
> +               } else {
> +                       this_end = min_t(unsigned, end2, PAGE_SIZE);
> +                       if (end2 > start2)
> +                               memset(kaddr + start2, 0, this_end - start2);
> +                       end2 -= this_end;
> +                       start2 = 0;
> +               }
> +
> +               kunmap_atomic(kaddr);
> +               flush_dcache_page(page + i);
> +
> +               if (!end1 && !end2)
> +                       break;
> +       }
> +
> +       BUG_ON((start1 | start2 | end1 | end2) != 0);
> +}
> +EXPORT_SYMBOL(zero_user_segments);
> +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> +#endif /* CONFIG_HIGHMEM */
>  
>  #if defined(HASHED_PAGE_VIRTUAL)
>  
> 
> 
> 
> > > +                       continue;
> > > +               }
> > > +
> > > +               kaddr = kmap_atomic(page + i);
> > > +
> > > +               this_end = min_t(unsigned, end1, PAGE_SIZE);
> > > +               if (end1 > start1)
> > > +                       memset(kaddr + start1, 0, this_end - start1);
> > > +               end1 -= this_end;
> > > +               start1 = 0;
> > > +
> > > +               if (start2 >= PAGE_SIZE) {
> > > +                       start2 -= PAGE_SIZE;
> > > +                       end2 -= PAGE_SIZE;
> > > +               } else {
> > > +                       this_end = min_t(unsigned, end2, PAGE_SIZE);
> > > +                       if (end2 > start2)
> > > +                               memset(kaddr + start2, 0, this_end - start2);
> > > +                       end2 -= this_end;
> > > +                       start2 = 0;
> > > +               }
> > > +
> > > +               kunmap_atomic(kaddr);
> > > +               flush_dcache_page(page + i);
> > > +
> > > +               if (!end1 && !end2)
> > > +                       break;
> > > +       }
> > > +
> > > +       BUG_ON((start1 | start2 | end1 | end2) != 0);
> > >  }
> > > 
> > > I think at this point it has to move out-of-line too.
> > > 
> > > > > +static inline void zero_user_large(struct page *page,
> > > > > +		unsigned start, unsigned size)
> > > > > +{
> > > > > +	unsigned int i;
> > > > > +
> > > > > +	for (i = 0; i < thp_order(page); i++) {
> > > > > +		if (start > PAGE_SIZE) {
> > > > 
> > > > Off-by-one? >= ?
> > > 
> > > Good catch; I'd also noticed that when I came to redo the zero_user_segments().
> > > 
> > 
> > -- 
> >  Kirill A. Shutemov

-- 
 Kirill A. Shutemov
