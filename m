Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD102AAFFB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Nov 2020 04:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbgKIDgB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Nov 2020 22:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgKIDgB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Nov 2020 22:36:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2B1C0613CF
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Nov 2020 19:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yQP6byoE5B4B57Q53kSLWIYPAnXbrjZD5tRmUuztkxU=; b=ot0XxtfyPWRBaNNMBLf95G1lLX
        kvqqqddahksHKKtL0sioL9jrYRsGWvML4zL/Ho8ZYhIUk478LGwIQ3A+nA3FYlUYThTfQ71aBFcLB
        SyanUUeAr68MevaBWpacIdW/HdgpvyxFsISnynXlSseOa/TTl3h/4wnQFJ6VFeJZjlY6IRbOdPNaR
        V2dKyU/2pxkS+hbx09D6F6qdXNjCwnrVBe7F+K/xEGWV4A2kcoh5iGZhUn/d0U/4nU+uQiFC6SCm8
        9cQz+llAhWpEFPBYZkl7vjbzeTh3tGosFUgOWWOpQ4JN1zuUpVN8ZWhzhIiTvV+qN9IIrYtd6Iazz
        AAvvIGnw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kbxyJ-0004CG-Cq; Mon, 09 Nov 2020 03:35:59 +0000
Date:   Mon, 9 Nov 2020 03:35:59 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Amy Parker <enbyamy@gmail.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        dan.j.williams@intel.com, Jan Kara <jack@suse.cz>
Subject: Re: Best solution for shifting DAX_ZERO_PAGE to XA_ZERO_ENTRY
Message-ID: <20201109033559.GY17076@casper.infradead.org>
References: <CAE1WUT6O6uP12YMU1NaU-4CR-AaxRUhhWHY=zUtNXpHUfxrF=A@mail.gmail.com>
 <20201109013322.GA9685@magnolia>
 <20201109015001.GX17076@casper.infradead.org>
 <CAE1WUT7LBAKYoZ=-UxEdt1OdoirwcKMU_A=6TAKPo7HxwnS+zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE1WUT7LBAKYoZ=-UxEdt1OdoirwcKMU_A=6TAKPo7HxwnS+zw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 08, 2020 at 05:54:14PM -0800, Amy Parker wrote:
> On Sun, Nov 8, 2020 at 5:50 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Sun, Nov 08, 2020 at 05:33:22PM -0800, Darrick J. Wong wrote:
> > > On Sun, Nov 08, 2020 at 05:15:55PM -0800, Amy Parker wrote:
> > > > XA_ZERO_ENTRY
> > > > is defined in include/linux/xarray.h, where it's defined using
> > > > xa_mk_internal(257). This function returns a void pointer, which
> > > > is incompatible with the bitwise arithmetic it is performed on with.
> >
> > We don't really perform bitwise arithmetic on it, outside of:
> >
> > static int dax_is_zero_entry(void *entry)
> > {
> >         return xa_to_value(entry) & DAX_ZERO_PAGE;
> > }
> 
> We also have:
> 
> if (dax_is_zero_entry(entry) && !(flags & DAX_ZERO_PAGE)) {
>        unsigned long index = xas->xa_index;
>        /* we are replacing a zero page with block mapping */
>        if (dax_is_pmd_entry(entry))
>               unmap_mapping_pages(mapping, index & ~PG_PMD_COLOUR,
>                             PG_PMD_NR, false);
>        else /* pte entry */
>               unmap_mapping_pages(mapping, index, 1, false);
> }
> 
> and:
> 
> *entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn,
>               DAX_PMD | DAX_ZERO_PAGE, false);

Right.  We need to be able to distinguish whether an entry represents
a PMD size.  So maybe we need XA_ZERO_PMD_ENTRY ... ?  Or we could use
the recently-added xa_get_order().

> > > > Should we go the route of adding a new definition, we might as
> > > > well just change the definition of DAX_ZERO_PAGE. This would
> > > > break the simplicity of the current DAX bit definitions:
> > > >
> > > > #define DAX_LOCKED      (1UL << 0)
> > > > #define DAX_PMD               (1UL << 1)
> > > > #define DAX_ZERO_PAGE  (1UL << 2)
> > > > #define DAX_EMPTY      (1UL << 3)
> >
> > I was proposing deleting the entire bit and shifting DAX_EMPTY down.
> 
> That'd probably be a better idea - so what should we do about the type
> issue? Not typecasting it causes it not to compile.

I don't think you'll need to do any casting once the bit operations go
away ...
