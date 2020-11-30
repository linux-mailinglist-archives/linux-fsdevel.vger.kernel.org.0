Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6392C2C85A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 14:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgK3Nhf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 08:37:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:54880 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726988AbgK3Nhf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 08:37:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A77D2AB63;
        Mon, 30 Nov 2020 13:36:53 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A500F1E131B; Mon, 30 Nov 2020 14:36:52 +0100 (CET)
Date:   Mon, 30 Nov 2020 14:36:52 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amy Parker <enbyamy@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        dan.j.williams@intel.com, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH 1/3] fs: dax.c: move fs hole signifier from
 DAX_ZERO_PAGE to XA_ZERO_ENTRY
Message-ID: <20201130133652.GK11250@quack2.suse.cz>
References: <CAE1WUT7ke9TR_H+et5_BUg93OYcDF0LD2ku+Cto59PhP6nz8qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE1WUT7ke9TR_H+et5_BUg93OYcDF0LD2ku+Cto59PhP6nz8qg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 28-11-20 20:36:29, Amy Parker wrote:
> DAX uses the DAX_ZERO_PAGE bit to represent holes in files. It could also use
> a single entry, such as XArray's XA_ZERO_ENTRY. This distinguishes zero pages
> and allows us to shift DAX_EMPTY down (see patch 2/3).
> 
> Signed-off-by: Amy Parker <enbyamy@gmail.com>

Thanks for the patch. The idea looks nice however I think technically there
are some problems with the patch. See below.

> +/*
> + * A zero entry, XA_ZERO_ENTRY, is used to represent a zero page. This
> + * definition helps with checking if an entry is a PMD size.
> + */
> +#define XA_ZERO_PMD_ENTRY DAX_PMD | (unsigned long)XA_ZERO_ENTRY
> +

Firstly, if you define a macro, we usually wrap it inside braces like:

#define XA_ZERO_PMD_ENTRY (DAX_PMD | (unsigned long)XA_ZERO_ENTRY)

to avoid unexpected issues when macro expands and surrounding operators
have higher priority.

Secondly, I don't think you can combine XA_ZERO_ENTRY with DAX_PMD (or any
other bits for that matter). XA_ZERO_ENTRY is defined as
xa_mk_internal(257) which is ((257 << 2) | 2) - DAX bits will overlap with
the bits xarray internal entries are using and things will break.

Honestly, I find it somewhat cumbersome to use xarray internal entries for
DAX purposes since all the locking (using DAX_LOCKED) and size checking
(using DAX_PMD) functions will have to special-case internal entries to
operate on different set of bits. It could be done, sure, but I'm not sure
it is worth the trouble for saving two bits (we could get rid of
DAX_ZERO_PAGE and DAX_EMPTY bits in this way) in DAX entries. But maybe
Matthew had some idea how to do this in an elegant way...

								Honza

>  static unsigned long dax_to_pfn(void *entry)
>  {
>      return xa_to_value(entry) >> DAX_SHIFT;
> @@ -114,7 +119,7 @@ static bool dax_is_pte_entry(void *entry)
> 
>  static int dax_is_zero_entry(void *entry)
>  {
> -    return xa_to_value(entry) & DAX_ZERO_PAGE;
> +    return xa_to_value(entry) & (unsigned long)XA_ZERO_ENTRY;
>  }
> 
>  static int dax_is_empty_entry(void *entry)
> @@ -738,7 +743,7 @@ static void *dax_insert_entry(struct xa_state *xas,
>      if (dirty)
>          __mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
> 
> -    if (dax_is_zero_entry(entry) && !(flags & DAX_ZERO_PAGE)) {
> +    if (dax_is_zero_entry(entry) && !(flags & (unsigned long)XA_ZERO_ENTRY)) {
>          unsigned long index = xas->xa_index;
>          /* we are replacing a zero page with block mapping */
>          if (dax_is_pmd_entry(entry))
> @@ -1047,7 +1052,7 @@ static vm_fault_t dax_load_hole(struct xa_state *xas,
>      vm_fault_t ret;
> 
>      *entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn,
> -            DAX_ZERO_PAGE, false);
> +            XA_ZERO_ENTRY, false);
> 
>      ret = vmf_insert_mixed(vmf->vma, vaddr, pfn);
>      trace_dax_load_hole(inode, vmf, ret);
> @@ -1434,7 +1439,7 @@ static vm_fault_t dax_pmd_load_hole(struct
> xa_state *xas, struct vm_fault *vmf,
> 
>      pfn = page_to_pfn_t(zero_page);
>      *entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn,
> -            DAX_PMD | DAX_ZERO_PAGE, false);
> +            XA_ZERO_PMD_ENTRY, false);
> 
>      if (arch_needs_pgtable_deposit()) {
>          pgtable = pte_alloc_one(vma->vm_mm);
> -- 
> 2.29.2
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
