Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29E2B41A08
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2019 03:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407317AbfFLBqh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jun 2019 21:46:37 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43964 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729074AbfFLBqg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jun 2019 21:46:36 -0400
Received: by mail-ed1-f65.google.com with SMTP id w33so23011672edb.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jun 2019 18:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LXj97QV1xj0YMzJTfwO7V63Jo2GxebtIwJp0QMGiowU=;
        b=HXRALFEYuiiWfCAMv5ihCzb+blJRwM2p40Q+4CrmWGOBIgEkIDSwBrEmzJYKQ+tQQG
         z2zhnfgt9xZBNdaJnC4IYxdve974bp8GqdRK0VoTR77WKjzD+KD0JIztls5JApZ5hV+F
         OZ26YVVQJtbKfc4dhoGKHLxGltQMUFpy31s8E4bdelVuXnJSkCJzxdSGyZILsBzUq80t
         f2c+1jkR/tn+MjiDAWne64fh2CCM+Ju3910qo87nTjZEZJjXCiYH7ZeVy12toNmoHyaz
         IxnqUNMjynTbSnz5WxKPBzjlGaW/AxuUfXPeCSCnkTypuYPRZ93+e0sfsOSBZY616mof
         zdBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LXj97QV1xj0YMzJTfwO7V63Jo2GxebtIwJp0QMGiowU=;
        b=QIdgZiIofrnWJ8Q9NsP1SVRKsyxrRjtoRkxHVxUC4r1q+eAfGejvt+D0OtFtEw9u3h
         /muoLfpkkwAylvmf22EFbwnjWKm7mmQ/FGy7Ni0md20YA7LsmT+KHkQO4DinEzkx6Wi9
         RI+mQ09YDXt47ho5CGbORo1OpNehLd9sPdguExTciBojCPyjqcRJzYaKknNLkto7OtEM
         9nzm8xzRRukWd+rAJgYz0/VrQapbJjGgmu5fz8hVWzttC2Cb1A4rX5aGrwySBorhyl2T
         Y2iNPEVVk+ZBgmCQviSMnmloIAwQBZy0oVasvutwyCrztKeHdXU9l+9TJC4CarOBttOU
         eAvg==
X-Gm-Message-State: APjAAAUov1G7tVefjX6HneW/YTyLWXDi4IcrtPa76OHMdG99lZ9PzjU3
        jpi+Q5L6VvVHqj4yz5U3EHxb0Q==
X-Google-Smtp-Source: APXvYqwI5Qv0C/a0lrl6mzuoFXDCntFWruXenrhqcLo08+2SpUh6wATX727OIc7E2oRZg6ayc5q2AQ==
X-Received: by 2002:a50:ad01:: with SMTP id y1mr62139325edc.180.1560303994960;
        Tue, 11 Jun 2019 18:46:34 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id a53sm1063966eda.56.2019.06.11.18.46.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 18:46:34 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 0011A10081B; Wed, 12 Jun 2019 04:46:34 +0300 (+03)
Date:   Wed, 12 Jun 2019 04:46:34 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Hugh Dickins <hughd@google.com>,
        Jan Kara <jack@suse.cz>, Song Liu <liu.song.a23@gmail.com>
Subject: Re: [PATCH v4] page cache: Store only head pages in i_pages
Message-ID: <20190612014634.f23fjumw666jj52s@box>
References: <20190307153051.18815-1-willy@infradead.org>
 <155951205528.18214.706102020945306720@skylake-alporthouse-com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155951205528.18214.706102020945306720@skylake-alporthouse-com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 02, 2019 at 10:47:35PM +0100, Chris Wilson wrote:
> Quoting Matthew Wilcox (2019-03-07 15:30:51)
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 404acdcd0455..aaf88f85d492 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -2456,6 +2456,9 @@ static void __split_huge_page(struct page *page, struct list_head *list,
> >                         if (IS_ENABLED(CONFIG_SHMEM) && PageSwapBacked(head))
> >                                 shmem_uncharge(head->mapping->host, 1);
> >                         put_page(head + i);
> > +               } else if (!PageAnon(page)) {
> > +                       __xa_store(&head->mapping->i_pages, head[i].index,
> > +                                       head + i, 0);
> 
> Forgiving the ignorant copy'n'paste, this is required:
> 
> +               } else if (PageSwapCache(page)) {
> +                       swp_entry_t entry = { .val = page_private(head + i) };
> +                       __xa_store(&swap_address_space(entry)->i_pages,
> +                                  swp_offset(entry),
> +                                  head + i, 0);
>                 }
>         }
>  
> The locking is definitely wrong.

Does it help with the problem, or it's just a possible lead?

-- 
 Kirill A. Shutemov
