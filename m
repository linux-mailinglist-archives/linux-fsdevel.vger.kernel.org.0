Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA9B2AAED8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Nov 2020 02:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgKIBy0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Nov 2020 20:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728006AbgKIByZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Nov 2020 20:54:25 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A902CC0613CF
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Nov 2020 17:54:25 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id i18so7497630ots.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Nov 2020 17:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZuEbJd/rC1DWMKE3T/Ch6Xoh1cqdm6Mb9Oh+kDQM/38=;
        b=XPGt9iSfnLtzThbKpkfUu9on6i/kTxpXQzvCrOAPuXUVK8L4wiSUQCyPuIrFFrWfC0
         0tnXRL3f3zh6MB+ilA0+vUAathZIkEtL9DyUbHp82Ri6zELrg53TXORqlAG8N5WwzGPG
         MNQdwfdv8B4f+iLfSf7Q/DTWSC3/Qug6EirZWRke8eljiWVh4TbQiLAAghEttswIpHIc
         NnebFuoY9AHVkeER2RK/9tlL1+cKTwye3poChnNOH/TQVI9Rp8ea5hs0WQNLKEvCNeEE
         DTMFI8/ZTaODhE0KU69Kcq8Zgyou8Ll8p7++qAQZTI1nIRVGyoHejepZ7QLcsJVZQvi8
         V9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZuEbJd/rC1DWMKE3T/Ch6Xoh1cqdm6Mb9Oh+kDQM/38=;
        b=bAw8YtH2eodtVtXUBOPOpoFX4WB1G6El97fOy4A9nxy2vDC8l2dASazRqyl8zpRFvr
         0L5RCyzC1oJ9DQ1CyWYZu80lhwkMKQ0cSDs/dstgQq6EfI6bliIbdzfmYUW8GkWeJe2p
         sRnErfKL6um8pNjD2rki85x4SHUGkKJSnNoTGUNWl+Hwusq+7Ax4hGfw0zq1nnLAjDgc
         hl0zEVO1gNO/nmKb1/eon6nGpsJnUgGTFpHdtziZH46RFJRCssWDLK2EYhadrslXrdTD
         /uow0qdUxtlJWHb9kbi7l6Ia5n5cRrzLw2AUN9Ax3jAuEe0JcHZjUONxUA3vCu6zPRAY
         Vqng==
X-Gm-Message-State: AOAM5331LA3QgIG7gSxs2hlKUA1aDP+Leajc/FNBBeC8rzl/e+H9QJDF
        ZGx30G8gKbKmDDoyKC93PA3433et21HDiwTuR4A/iF9WkoK5EQ==
X-Google-Smtp-Source: ABdhPJwHfE+dlPM0iWt4PF2iejUc2DO6Beo90SBNvuX2L1LPbTXt+i/TQjSSaSIcIG6YHVd4NormZqKAaWtWGfUQdwQ=
X-Received: by 2002:a9d:1b2:: with SMTP id e47mr8146282ote.45.1604886864960;
 Sun, 08 Nov 2020 17:54:24 -0800 (PST)
MIME-Version: 1.0
References: <CAE1WUT6O6uP12YMU1NaU-4CR-AaxRUhhWHY=zUtNXpHUfxrF=A@mail.gmail.com>
 <20201109013322.GA9685@magnolia> <20201109015001.GX17076@casper.infradead.org>
In-Reply-To: <20201109015001.GX17076@casper.infradead.org>
From:   Amy Parker <enbyamy@gmail.com>
Date:   Sun, 8 Nov 2020 17:54:14 -0800
Message-ID: <CAE1WUT7LBAKYoZ=-UxEdt1OdoirwcKMU_A=6TAKPo7HxwnS+zw@mail.gmail.com>
Subject: Re: Best solution for shifting DAX_ZERO_PAGE to XA_ZERO_ENTRY
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        dan.j.williams@intel.com, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 8, 2020 at 5:50 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sun, Nov 08, 2020 at 05:33:22PM -0800, Darrick J. Wong wrote:
> > On Sun, Nov 08, 2020 at 05:15:55PM -0800, Amy Parker wrote:
> > > I've been writing a patch to migrate the defined DAX_ZERO_PAGE
> > > to XA_ZERO_ENTRY for representing holes in files.
> >
> > Why?  IIRC XA_ZERO_ENTRY ("no mapping in the address space") isn't the
> > same as DAX_ZERO_PAGE ("the zero page is mapped into the address space
> > because we took a read fault on a sparse file hole").
>
> There's no current user of XA_ZERO_ENTRY in i_pages, whether it be
> DAX or non-DAX.
>
> > > XA_ZERO_ENTRY
> > > is defined in include/linux/xarray.h, where it's defined using
> > > xa_mk_internal(257). This function returns a void pointer, which
> > > is incompatible with the bitwise arithmetic it is performed on with.
>
> We don't really perform bitwise arithmetic on it, outside of:
>
> static int dax_is_zero_entry(void *entry)
> {
>         return xa_to_value(entry) & DAX_ZERO_PAGE;
> }

We also have:

if (dax_is_zero_entry(entry) && !(flags & DAX_ZERO_PAGE)) {
       unsigned long index = xas->xa_index;
       /* we are replacing a zero page with block mapping */
       if (dax_is_pmd_entry(entry))
              unmap_mapping_pages(mapping, index & ~PG_PMD_COLOUR,
                            PG_PMD_NR, false);
       else /* pte entry */
              unmap_mapping_pages(mapping, index, 1, false);
}

and:

*entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn,
              DAX_PMD | DAX_ZERO_PAGE, false);

>
> > > Currently, DAX_ZERO_PAGE is defined as an unsigned long,
> > > so I considered typecasting it. Typecasting every time would be
> > > repetitive and inefficient. I thought about making a new definition
> > > for it which has the typecast, but this breaks the original point of
> > > using already defined terms.
> > >
> > > Should we go the route of adding a new definition, we might as
> > > well just change the definition of DAX_ZERO_PAGE. This would
> > > break the simplicity of the current DAX bit definitions:
> > >
> > > #define DAX_LOCKED      (1UL << 0)
> > > #define DAX_PMD               (1UL << 1)
> > > #define DAX_ZERO_PAGE  (1UL << 2)
> > > #define DAX_EMPTY      (1UL << 3)
>
> I was proposing deleting the entire bit and shifting DAX_EMPTY down.

That'd probably be a better idea - so what should we do about the type
issue? Not typecasting it causes it not to compile.
