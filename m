Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09EC132C51D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 01:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383092AbhCDATO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 19:19:14 -0500
Received: from verein.lst.de ([213.95.11.211]:36165 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356550AbhCCKrm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:47:42 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9A87668BEB; Wed,  3 Mar 2021 10:28:08 +0100 (CET)
Date:   Wed, 3 Mar 2021 10:28:08 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, dan.j.williams@intel.com,
        willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk,
        linux-btrfs@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de
Subject: Re: [PATCH v2 02/10] fsdax: Factor helper: dax_fault_actor()
Message-ID: <20210303092808.GC12784@lst.de>
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com> <20210226002030.653855-3-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226002030.653855-3-ruansy.fnst@fujitsu.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 26, 2021 at 08:20:22AM +0800, Shiyang Ruan wrote:
> The core logic in the two dax page fault functions is similar. So, move
> the logic into a common helper function. Also, to facilitate the
> addition of new features, such as CoW, switch-case is no longer used to
> handle different iomap types.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  fs/dax.c | 211 ++++++++++++++++++++++++++++++-------------------------
>  1 file changed, 117 insertions(+), 94 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 7031e4302b13..9dea1572868e 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1289,6 +1289,93 @@ static int dax_fault_cow_page(struct vm_fault *vmf, struct iomap *iomap,
>  	return 0;
>  }
>  
> +static vm_fault_t dax_fault_insert_pfn(struct vm_fault *vmf, pfn_t pfn,
> +		bool pmd, bool write)
> +{
> +	vm_fault_t ret;
> +
> +	if (!pmd) {
> +		struct vm_area_struct *vma = vmf->vma;
> +		unsigned long address = vmf->address;
> +
> +		if (write)
> +			ret = vmf_insert_mixed_mkwrite(vma, address, pfn);
> +		else
> +			ret = vmf_insert_mixed(vma, address, pfn);
> +	} else
> +		ret = vmf_insert_pfn_pmd(vmf, pfn, write);

What about simplifying this a little bit more, something like:

	if (pmd)
		return vmf_insert_pfn_pmd(vmf, pfn, write);

	if (write)
		return vmf_insert_mixed_mkwrite(vmf->vma, vmf->address, pfn);
	return vmf_insert_mixed(vmf->vma, vmf->address, pfn);

also given that this only has a single user, why not keep open coding
it in the caller?

> +#ifdef CONFIG_FS_DAX_PMD
> +static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
> +		struct iomap *iomap, void **entry);
> +#else
> +static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
> +		struct iomap *iomap, void **entry)
> +{
> +	return VM_FAULT_FALLBACK;
> +}
> +#endif

Can we try to avoid the forward declaration?  Also is there a reason
dax_pmd_load_hole does not compile for the !CONFIG_FS_DAX_PMD case?
If it compiles fine we can just rely on IS_ENABLED() based dead code
elimination entirely.

> +	/* if we are reading UNWRITTEN and HOLE, return a hole. */
> +	if (!write &&
> +	    (iomap->type == IOMAP_UNWRITTEN || iomap->type == IOMAP_HOLE)) {
> +		if (!pmd)
> +			return dax_load_hole(xas, mapping, &entry, vmf);
> +		else
> +			return dax_pmd_load_hole(xas, vmf, iomap, &entry);
> +	}
> +
> +	if (iomap->type != IOMAP_MAPPED) {
> +		WARN_ON_ONCE(1);
> +		return VM_FAULT_SIGBUS;
> +	}

Nit: I'd use a switch statement here for a clarity:

	switch (iomap->type) {
	case IOMAP_MAPPED:
		break;
	case IOMAP_UNWRITTEN:
	case IOMAP_HOLE:
		if (!write) {
			if (!pmd)
				return dax_load_hole(xas, mapping, &entry, vmf);
			return dax_pmd_load_hole(xas, vmf, iomap, &entry);
		}
		break;
	default:
		WARN_ON_ONCE(1);
		return VM_FAULT_SIGBUS;
	}


> +	err = dax_iomap_pfn(iomap, pos, size, &pfn);
> +	if (err)
> +		goto error_fault;
> +
> +	entry = dax_insert_entry(xas, mapping, vmf, entry, pfn, 0,
> +				 write && !sync);
> +
> +	if (sync)
> +		return dax_fault_synchronous_pfnp(pfnp, pfn);
> +
> +	ret = dax_fault_insert_pfn(vmf, pfn, pmd, write);
> +
> +error_fault:
> +	if (err)
> +		ret = dax_fault_return(err);
> +
> +	return ret;

It seems like the only place that sets err is the dax_iomap_pfn case
above.  So I'd move the dax_fault_return there, which then allows a direct
return for everyone else, including the open coded version of
dax_fault_insert_pfn.

I really like where this is going!
