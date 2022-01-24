Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21DA8497AB7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jan 2022 09:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236412AbiAXIvn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jan 2022 03:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236281AbiAXIvn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:51:43 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBC9C06173D
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jan 2022 00:51:43 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id c10so48999863ybb.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jan 2022 00:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bELfTHEk6E+Ur1KnM4vcunvX6YMOTiYgaY+wBXhSmNY=;
        b=xuzHORiZtxL4ALsbPI12Enqz7+Y7z0qaEw1VTD5rZOAhs136D3XcklFmacDAPP1Wix
         b1LezGAI1F3NQTCI3w2mzRPC+MN6bdvFBSfGz1dtd48u5S8myG1WDGav+YscfQrYNIyT
         bW4EIysGkBOF3+/+evUyYiHTyjBobHidSnKY3XRHsRzfufOk2nJE7LOgO/bNLOnPqckC
         K2NOq5CLsd2a53530xwZVi/LbOfFyuiMm7xB/ASE2pT2LN7016uNyqlOtbNmhXhU6GUt
         ztNByXTKi0m1souZOOtIvo7KOv/wq5MzYC8eEGDxp0xOL5QolSsngo80rWPP/ZmLnKM1
         fFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bELfTHEk6E+Ur1KnM4vcunvX6YMOTiYgaY+wBXhSmNY=;
        b=hXVQopzOEwesTvG7+vkSRpORJuvB5SB332n3tXjHWPKg80XD88xEXKrbsEmVmn3UFu
         xqIGJ7FOF5Jtnn+JSeGcGGPuFQqzY2dAE+Oc9xAd+6srbdKsWZBYufKXqkd+srCFaIzk
         beOjFei0+dfZM1kxv2VAwH2LrDixRmg8Do8h4Lq6p9kmzDFg9gO8zbOqTXSK3SlyzoN5
         9qrHUtY9Pm+muA2PgLBORhUwh7V49vSWYN8Eac79TnFhUGgR9Rkn071t6RfijOUv/sPV
         JCijag3dLz5MqPhBz5ILZ6asqmS0AZd82/AfRoa7UchPYkgjBrrihXqvUEpJsgR6SjNI
         OB9w==
X-Gm-Message-State: AOAM530kp81PP+fvB0QJagREQbUQPUeX2sFSvZq5C9Xmuj2s7UhHm0C7
        NWpMdU80vnSKX8PehI5F0rLq4w8Zn0moP09IwYR3jg==
X-Google-Smtp-Source: ABdhPJw1vSctPW8saHhj1FGspU/fxdcO6t1LvGwNO4aTt6W6d1v0JCyqb15ZQrKh1+6SniqvhSjPXoVXuqbGSbR4L3Y=
X-Received: by 2002:a25:d107:: with SMTP id i7mr20792477ybg.495.1643014302301;
 Mon, 24 Jan 2022 00:51:42 -0800 (PST)
MIME-Version: 1.0
References: <20220121075515.79311-1-songmuchun@bytedance.com> <Ye5WfvUdJBhZ3lME@infradead.org>
In-Reply-To: <Ye5WfvUdJBhZ3lME@infradead.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 24 Jan 2022 16:51:06 +0800
Message-ID: <CAMZfGtUab0PS7tO0ni4Z7eSKWc0UAVQO=prc-iKNj0S67qaRtw@mail.gmail.com>
Subject: Re: [PATCH 1/5] mm: rmap: fix cache flush on THP pages
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

On Mon, Jan 24, 2022 at 3:34 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Jan 21, 2022 at 03:55:11PM +0800, Muchun Song wrote:
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index b0fd9dc19eba..65670cb805d6 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -974,7 +974,7 @@ static bool page_mkclean_one(struct page *page, struct vm_area_struct *vma,
> >                       if (!pmd_dirty(*pmd) && !pmd_write(*pmd))
> >                               continue;
> >
> > -                     flush_cache_page(vma, address, page_to_pfn(page));
> > +                     flush_cache_range(vma, address, address + HPAGE_PMD_SIZE);
>
> Do we need a flush_cache_folio here given that we must be dealing with
> what effectively is a folio here?

I think it is a future improvement. I suspect it will be easy if
someone wants to backport this patch. If we do not want
someone to do this, I think it is better to introduce
flush_cache_folio in this patch. What do you think?

>
> Also please avoid the overly long line.
>

OK.

Thanks.
