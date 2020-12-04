Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3CF2CF188
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Dec 2020 17:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730786AbgLDQFr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Dec 2020 11:05:47 -0500
Received: from mga03.intel.com ([134.134.136.65]:2448 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730775AbgLDQFr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Dec 2020 11:05:47 -0500
IronPort-SDR: qgHODMNu+1xnnUOE4u1EiVansFqSJb5EeufXyrX4nLWxi+ED2V1krxxl02kjdK+CPbbLU4pTBu
 Tr9ZJlQrNGHA==
X-IronPort-AV: E=McAfee;i="6000,8403,9825"; a="173492579"
X-IronPort-AV: E=Sophos;i="5.78,393,1599548400"; 
   d="scan'208";a="173492579"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2020 08:05:06 -0800
IronPort-SDR: X+NoKo1QugeVrBMgw7pJWvCsfg1PJrSs+ULxdNu73Ly5U6/0rzxW0uRVlkZ83gEX1fjYMmRAhd
 pvIZzvQDizRw==
X-IronPort-AV: E=Sophos;i="5.78,393,1599548400"; 
   d="scan'208";a="540754477"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2020 08:05:05 -0800
Date:   Fri, 4 Dec 2020 08:05:04 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        David Howells <dhowells@redhat.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Steve French <sfrench@samba.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Brian King <brking@us.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 03/17] drivers/gpu: Convert to mem*_page()
Message-ID: <20201204160504.GH1563847@iweiny-DESK2.sc.intel.com>
References: <20201124060755.1405602-1-ira.weiny@intel.com>
 <20201124060755.1405602-4-ira.weiny@intel.com>
 <160648211578.10416.3269409785516897908@jlahtine-mobl.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160648211578.10416.3269409785516897908@jlahtine-mobl.ger.corp.intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 27, 2020 at 03:01:56PM +0200, Joonas Lahtinen wrote:
> + intel-gfx mailing list
> 
> Quoting ira.weiny@intel.com (2020-11-24 08:07:41)
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > The pattern of kmap/mem*/kunmap is repeated.  Use the new mem*_page()
> > calls instead.
> > 
> > Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
> > Cc: Jani Nikula <jani.nikula@linux.intel.com>
> > Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >  drivers/gpu/drm/gma500/gma_display.c      | 7 +++----
> >  drivers/gpu/drm/gma500/mmu.c              | 4 ++--
> >  drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 6 ++----
> >  drivers/gpu/drm/i915/gt/intel_gtt.c       | 9 ++-------
> >  drivers/gpu/drm/i915/gt/shmem_utils.c     | 8 +++-----
> 
> Are you looking to merge all these from the same tree, or first merge
> the first patch and then trickle the rest through their own trees?

I was thinking that they would go through Andrew's tree in bulk.  But as I go
through all the 'variants' including adding any kmap_atomic() variants it is
getting to be a pretty big change.  I'm trying to use Coccinelle but I'm not
100% confident in it working, more precisely in my skill to make it work.

So I think I'm going to submit the base patch to Andrew today (with some
cleanups per the comments in this thread).

If Andrew could land that then I will can submit separate patches to each
subsystem which would get full testing...  :-(

That is best.

Thanks for making me think on this,
Ira

> Our last -next PR was already sent for i915, so I would queue this
> only for 5.12.
> 
> In any case, if you could split the i915 changes to a separate patch
> (we have multiple sub-trees in drm), those are:
> 
> Reviewed-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> 
> The gma500 changes also appear correct, so feel free to apply the
> R-b for those, too.
> 
> Regards, Joonas
> 
> >  5 files changed, 12 insertions(+), 22 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/gma500/gma_display.c b/drivers/gpu/drm/gma500/gma_display.c
> > index 3df6d6e850f5..f81114594211 100644
> > --- a/drivers/gpu/drm/gma500/gma_display.c
> > +++ b/drivers/gpu/drm/gma500/gma_display.c
> > @@ -9,6 +9,7 @@
> >  
> >  #include <linux/delay.h>
> >  #include <linux/highmem.h>
> > +#include <linux/pagemap.h>
> >  
> >  #include <drm/drm_crtc.h>
> >  #include <drm/drm_fourcc.h>
> > @@ -334,7 +335,7 @@ int gma_crtc_cursor_set(struct drm_crtc *crtc,
> >         struct gtt_range *gt;
> >         struct gtt_range *cursor_gt = gma_crtc->cursor_gt;
> >         struct drm_gem_object *obj;
> > -       void *tmp_dst, *tmp_src;
> > +       void *tmp_dst;
> >         int ret = 0, i, cursor_pages;
> >  
> >         /* If we didn't get a handle then turn the cursor off */
> > @@ -400,9 +401,7 @@ int gma_crtc_cursor_set(struct drm_crtc *crtc,
> >                 /* Copy the cursor to cursor mem */
> >                 tmp_dst = dev_priv->vram_addr + cursor_gt->offset;
> >                 for (i = 0; i < cursor_pages; i++) {
> > -                       tmp_src = kmap(gt->pages[i]);
> > -                       memcpy(tmp_dst, tmp_src, PAGE_SIZE);
> > -                       kunmap(gt->pages[i]);
> > +                       memcpy_from_page(tmp_dst, gt->pages[i], 0, PAGE_SIZE);
> >                         tmp_dst += PAGE_SIZE;
> >                 }
> >  
> > diff --git a/drivers/gpu/drm/gma500/mmu.c b/drivers/gpu/drm/gma500/mmu.c
> > index 505044c9a673..8a0856c7f439 100644
> > --- a/drivers/gpu/drm/gma500/mmu.c
> > +++ b/drivers/gpu/drm/gma500/mmu.c
> > @@ -5,6 +5,7 @@
> >   **************************************************************************/
> >  
> >  #include <linux/highmem.h>
> > +#include <linux/pagemap.h>
> >  
> >  #include "mmu.h"
> >  #include "psb_drv.h"
> > @@ -204,8 +205,7 @@ struct psb_mmu_pd *psb_mmu_alloc_pd(struct psb_mmu_driver *driver,
> >  
> >         kunmap(pd->p);
> >  
> > -       clear_page(kmap(pd->dummy_page));
> > -       kunmap(pd->dummy_page);
> > +       memzero_page(pd->dummy_page, 0, PAGE_SIZE);
> >  
> >         pd->tables = vmalloc_user(sizeof(struct psb_mmu_pt *) * 1024);
> >         if (!pd->tables)
> > diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> > index 75e8b71c18b9..8a25e08edd18 100644
> > --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> > +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> > @@ -558,7 +558,7 @@ i915_gem_object_create_shmem_from_data(struct drm_i915_private *dev_priv,
> >         do {
> >                 unsigned int len = min_t(typeof(size), size, PAGE_SIZE);
> >                 struct page *page;
> > -               void *pgdata, *vaddr;
> > +               void *pgdata;
> >  
> >                 err = pagecache_write_begin(file, file->f_mapping,
> >                                             offset, len, 0,
> > @@ -566,9 +566,7 @@ i915_gem_object_create_shmem_from_data(struct drm_i915_private *dev_priv,
> >                 if (err < 0)
> >                         goto fail;
> >  
> > -               vaddr = kmap(page);
> > -               memcpy(vaddr, data, len);
> > -               kunmap(page);
> > +               memcpy_to_page(page, 0, data, len);
> >  
> >                 err = pagecache_write_end(file, file->f_mapping,
> >                                           offset, len, len,
> > diff --git a/drivers/gpu/drm/i915/gt/intel_gtt.c b/drivers/gpu/drm/i915/gt/intel_gtt.c
> > index 3f1114b58b01..f3d7c601d362 100644
> > --- a/drivers/gpu/drm/i915/gt/intel_gtt.c
> > +++ b/drivers/gpu/drm/i915/gt/intel_gtt.c
> > @@ -153,13 +153,8 @@ static void poison_scratch_page(struct drm_i915_gem_object *scratch)
> >         if (IS_ENABLED(CONFIG_DRM_I915_DEBUG_GEM))
> >                 val = POISON_FREE;
> >  
> > -       for_each_sgt_page(page, sgt, scratch->mm.pages) {
> > -               void *vaddr;
> > -
> > -               vaddr = kmap(page);
> > -               memset(vaddr, val, PAGE_SIZE);
> > -               kunmap(page);
> > -       }
> > +       for_each_sgt_page(page, sgt, scratch->mm.pages)
> > +               memset_page(page, val, 0, PAGE_SIZE);
> >  }
> >  
> >  int setup_scratch_page(struct i915_address_space *vm)
> > diff --git a/drivers/gpu/drm/i915/gt/shmem_utils.c b/drivers/gpu/drm/i915/gt/shmem_utils.c
> > index f011ea42487e..2d5f1f2e803d 100644
> > --- a/drivers/gpu/drm/i915/gt/shmem_utils.c
> > +++ b/drivers/gpu/drm/i915/gt/shmem_utils.c
> > @@ -95,19 +95,17 @@ static int __shmem_rw(struct file *file, loff_t off,
> >                 unsigned int this =
> >                         min_t(size_t, PAGE_SIZE - offset_in_page(off), len);
> >                 struct page *page;
> > -               void *vaddr;
> >  
> >                 page = shmem_read_mapping_page_gfp(file->f_mapping, pfn,
> >                                                    GFP_KERNEL);
> >                 if (IS_ERR(page))
> >                         return PTR_ERR(page);
> >  
> > -               vaddr = kmap(page);
> >                 if (write)
> > -                       memcpy(vaddr + offset_in_page(off), ptr, this);
> > +                       memcpy_to_page(page, offset_in_page(off), ptr, this);
> >                 else
> > -                       memcpy(ptr, vaddr + offset_in_page(off), this);
> > -               kunmap(page);
> > +                       memcpy_from_page(ptr, page, offset_in_page(off), this);
> > +
> >                 put_page(page);
> >  
> >                 len -= this;
> > -- 
> > 2.28.0.rc0.12.gb6a658bd00c9
> > 
