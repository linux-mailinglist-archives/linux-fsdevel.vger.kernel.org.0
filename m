Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26FC497AE6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jan 2022 10:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242575AbiAXJBo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jan 2022 04:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242560AbiAXJBk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jan 2022 04:01:40 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB49C06173D
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jan 2022 01:01:40 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id l68so48401882ybl.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jan 2022 01:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qPuSl5NxTGIIFIMAw/dyMyil9mBbCPqU09NIe0oAokU=;
        b=6llndIHFqFppJ4Gj2xb3cyh+pp6mM711rLtlQwGBakuS3Q/v/2zuj98cryr+VeHrrL
         o2nf1CmZkHq3QGBrZz1wVwwc8efKujB3hPJQp8C18rdlsVNUx09LyjgmCG4xxoPWQIrH
         tXOo/ee/k5v9Ic/JAECmKiaQPChSJqOuzivhyfpTWcq6rXvOTLL8Q47QcHdVdH9eQdL6
         9P494f3fHakyK4GIkdVdr/un6XlnRhD8Slk1P+r1/j+V2wqnbtDvV8odCtEhc/ohlZU2
         d5OwhJx6507d5A3f02MdKERpXa4k6wccCLoHWkv1h56Sik5coVN96gQjQkpXch7rsJIB
         Z0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qPuSl5NxTGIIFIMAw/dyMyil9mBbCPqU09NIe0oAokU=;
        b=Oy6O7QFwWWJ3JVbFRbHK6uVQIvp4cyvs5E3PLY2/cmpWsfEfutZ68cQRemlk8QcpIh
         f42AOH+E1EdtJg8pn7IBcKu8c3xN+qj0vA2QmYFxbACief///ATmB7RwP26udpYt1c9E
         ISj3nWkZekyGn/l0qPeQqs6bCgpNYrQVtXCtON0q5DhXGfnzj4gJ0T2Zq19AHHwG97PC
         Tcw6EyFTpgPY+kgTLrhFxBTbUiajFACnlPyOX1KTXh2zjKlEOZllJPXWRAS5q3KnpvSr
         x/Fj54dm6KlAP67ceGxGU2RZkre0ak6zRDhnwvtpXJ4WeIFIiyFM6DRfQfWFbN2VDIdi
         WK9g==
X-Gm-Message-State: AOAM532j2FWqfBBNCCFMttb9/bYUpM1c4vyujzNn3qtrMFYU9anstlni
        /QiwBQ/o3C7F8R2BcQPkMfKlNlOCTS8Z3C8l4hMbXw==
X-Google-Smtp-Source: ABdhPJxCB2+GYystUm4f6yE23AKfFLdR4LWU/ii96fyLJt0DuPLnpNq7DG11ShRdZIfMVzy8ewQT7cV3z2wTwLiVyRY=
X-Received: by 2002:a25:6d09:: with SMTP id i9mr20946206ybc.703.1643014899644;
 Mon, 24 Jan 2022 01:01:39 -0800 (PST)
MIME-Version: 1.0
References: <20220121075515.79311-1-songmuchun@bytedance.com>
 <20220121075515.79311-3-songmuchun@bytedance.com> <Ye5XEeMYt8c7/iMV@infradead.org>
In-Reply-To: <Ye5XEeMYt8c7/iMV@infradead.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 24 Jan 2022 17:01:03 +0800
Message-ID: <CAMZfGtWForYqmrZJFfOVw5pQPq8idQxwT9aFcUuCJMjdE6Tf3Q@mail.gmail.com>
Subject: Re: [PATCH 3/5] mm: page_vma_mapped: support checking if a pfn is
 mapped into a vma
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>, apopple@nvidia.com,
        Yang Shi <shy828301@gmail.com>, rcampbell@nvidia.com,
        Hugh Dickins <hughd@google.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        zwisler@kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        nvdimm@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 24, 2022 at 3:36 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Jan 21, 2022 at 03:55:13PM +0800, Muchun Song wrote:
> > +     if (pvmw->pte && ((pvmw->flags & PVMW_PFN_WALK) || !PageHuge(pvmw->page)))
>
> Please avoid the overly long line here and in a few other places.

OK.

>
> > +/*
> > + * Then at what user virtual address will none of the page be found in vma?
>
> Doesn't parse, what is this trying to say?

Well, I am also confused.

BTW, this is not introduced by me, it is introduced by:

  commit 37ffe9f4d7ff ("mm/thp: fix vma_address() if virtual address
below file offset")

If it is really confusing, I can replace this line with:

"Return the end user virtual address of a page within a vma"

Thanks.
