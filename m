Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E272C8698
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 15:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgK3OXf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 09:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgK3OXe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:23:34 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0C4C0613CF
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Nov 2020 06:22:54 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id 11so11379554oty.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Nov 2020 06:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6RyzP1BHCjRud9EiSNkPV34M475R8mJLc661DDcE6dc=;
        b=hKRnVdcEIu6E8XR51vNhuQKkMxlObb3IotM6bvCvvveEHPx6WZQeUoYPkT3vN73Orw
         hnyLAY70W8xN+LO6c3BCNdXdpJet5zsT7jF1uVkgpKrckz1L7rE/ukYVDGsdZpzkUMib
         QdH7N3b3XyOnefexKnLrYXlVtBfBQpX7xno438gFCjZOemxdbCFCDQcRo2LlubSCQ3DS
         CtljFQ2WKKiXbr2WNP9MFCvo6H+0iytOZB6r23Mj/y082hG9GmoIw/qLPxF4bpHlPR3X
         tICYl+y2xUxidO2JuCD6aaDQJqyQmWFAD0aqPuw9q4kODYmj3fyz2X5AB0kRMHK+nmwY
         uVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6RyzP1BHCjRud9EiSNkPV34M475R8mJLc661DDcE6dc=;
        b=LRfgeu/ArMibFARClB3f0Ghc2P4aqzyJ3aK1BrXEccQiLlfJl8y4u82y4ec5vYmuKF
         LkpJDTsYwzcOsrw4lyaLP+bUF/D/Kh0ZNBhBR7v7MEhTfawg1JMmvO2M37Qv/mbfe/5g
         y/HseSuhbaongQClV855pJbL3CyOIIYKjA7M7jsschIqZagQTiY8EzV8bn/tBltZQY+S
         0qMu4RMAnFaqxKOzzdX/FCdqlpfkrn3/ZOEdazVROGNPMd8MAnZhnwEf8dGdK3NjDsRL
         jyQj1QZQBlUKdfCxnoh2v8v6ONmEDq2yhRYD/4ugsQKDQNjxjg42r5RL4kTtOaXw2gX7
         nyhA==
X-Gm-Message-State: AOAM533yI0GGDPDIZuYArNiweDQmioiCnkep3ek9zjh0sKqm6XEasHgy
        IRBkN1ijH0WHqiQ9b570ThrdwRh/jaBOEmbJ6ME=
X-Google-Smtp-Source: ABdhPJw4qCd0h8SJHjs2zXLz7rvL/Uf8wPxatY9pltIgD41USjGHaioce896BLGpF07o6q68Pra4OkWxnfg3Q4KZcEo=
X-Received: by 2002:a9d:1b2:: with SMTP id e47mr16477605ote.45.1606746174201;
 Mon, 30 Nov 2020 06:22:54 -0800 (PST)
MIME-Version: 1.0
References: <CAE1WUT7ke9TR_H+et5_BUg93OYcDF0LD2ku+Cto59PhP6nz8qg@mail.gmail.com>
 <20201130133652.GK11250@quack2.suse.cz>
In-Reply-To: <20201130133652.GK11250@quack2.suse.cz>
From:   Amy Parker <enbyamy@gmail.com>
Date:   Mon, 30 Nov 2020 06:22:42 -0800
Message-ID: <CAE1WUT5LbFiKTAmT8V-ERH-=aGUjhOw5ZMjPMmoNWTNTspzN9w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] fs: dax.c: move fs hole signifier from
 DAX_ZERO_PAGE to XA_ZERO_ENTRY
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        dan.j.williams@intel.com, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > +/*
> > + * A zero entry, XA_ZERO_ENTRY, is used to represent a zero page. This
> > + * definition helps with checking if an entry is a PMD size.
> > + */
> > +#define XA_ZERO_PMD_ENTRY DAX_PMD | (unsigned long)XA_ZERO_ENTRY
> > +
>
> Firstly, if you define a macro, we usually wrap it inside braces like:
>
> #define XA_ZERO_PMD_ENTRY (DAX_PMD | (unsigned long)XA_ZERO_ENTRY)
>
> to avoid unexpected issues when macro expands and surrounding operators
> have higher priority.

Oops! Must've missed that - I'll make sure to get on that when
revising this patch.

> Secondly, I don't think you can combine XA_ZERO_ENTRY with DAX_PMD (or any
> other bits for that matter). XA_ZERO_ENTRY is defined as
> xa_mk_internal(257) which is ((257 << 2) | 2) - DAX bits will overlap with
> the bits xarray internal entries are using and things will break.

Could you provide an example of this overlap? I can't seem to find any.

> Honestly, I find it somewhat cumbersome to use xarray internal entries for
> DAX purposes since all the locking (using DAX_LOCKED) and size checking
> (using DAX_PMD) functions will have to special-case internal entries to
> operate on different set of bits. It could be done, sure, but I'm not sure
> it is worth the trouble for saving two bits (we could get rid of
> DAX_ZERO_PAGE and DAX_EMPTY bits in this way) in DAX entries. But maybe
> Matthew had some idea how to do this in an elegant way...

Yeah, that's likely the best we've got for now. Hopefully Matthew can
provide some
insight into this.

Best regards,
Amy Parker
(she/her)

>
>                                                                 Honza
>
> >  static unsigned long dax_to_pfn(void *entry)
> >  {
> >      return xa_to_value(entry) >> DAX_SHIFT;
> > @@ -114,7 +119,7 @@ static bool dax_is_pte_entry(void *entry)
> >
> >  static int dax_is_zero_entry(void *entry)
> >  {
> > -    return xa_to_value(entry) & DAX_ZERO_PAGE;
> > +    return xa_to_value(entry) & (unsigned long)XA_ZERO_ENTRY;
> >  }
> >
> >  static int dax_is_empty_entry(void *entry)
> > @@ -738,7 +743,7 @@ static void *dax_insert_entry(struct xa_state *xas,
> >      if (dirty)
> >          __mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
> >
> > -    if (dax_is_zero_entry(entry) && !(flags & DAX_ZERO_PAGE)) {
> > +    if (dax_is_zero_entry(entry) && !(flags & (unsigned long)XA_ZERO_ENTRY)) {
> >          unsigned long index = xas->xa_index;
> >          /* we are replacing a zero page with block mapping */
> >          if (dax_is_pmd_entry(entry))
> > @@ -1047,7 +1052,7 @@ static vm_fault_t dax_load_hole(struct xa_state *xas,
> >      vm_fault_t ret;
> >
> >      *entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn,
> > -            DAX_ZERO_PAGE, false);
> > +            XA_ZERO_ENTRY, false);
> >
> >      ret = vmf_insert_mixed(vmf->vma, vaddr, pfn);
> >      trace_dax_load_hole(inode, vmf, ret);
> > @@ -1434,7 +1439,7 @@ static vm_fault_t dax_pmd_load_hole(struct
> > xa_state *xas, struct vm_fault *vmf,
> >
> >      pfn = page_to_pfn_t(zero_page);
> >      *entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn,
> > -            DAX_PMD | DAX_ZERO_PAGE, false);
> > +            XA_ZERO_PMD_ENTRY, false);
> >
> >      if (arch_needs_pgtable_deposit()) {
> >          pgtable = pte_alloc_one(vma->vm_mm);
> > --
> > 2.29.2
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
