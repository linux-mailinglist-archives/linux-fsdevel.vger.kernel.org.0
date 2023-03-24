Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293F96C758C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 03:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjCXCVN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 22:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjCXCVK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 22:21:10 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930953C03;
        Thu, 23 Mar 2023 19:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679624464; x=1711160464;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=WC/GKCLsgaUV1To9x+OiRyuA8e2gZbfaT5Wbg90dNqM=;
  b=AhPApKX0Eb4Ak1S8lBWPCg6hYQk7pV2RhB39omX4jViXIcox2b6EN7Vz
   kL9ie22HTTI0y7xAMBcpwbTgEQ78f6vkjNKM8WhiOGGKeDwCq8DPDUTqf
   mk8VwQkqot9BEW0Cd3WfmtknLvly/8HxhuJS7iHaZ8kMB5Ulkn0boJ9+0
   o8bPAkCjE7B+HhR3zYzDTGcGILsoP3wvdh6iofFHoJiIUaw/FN+PcRpoB
   TDTU6XcYFejPaiW52+axPOL+M0rq3QKPmfpgilQANmIuceY6qVIfKmzez
   XaZ40C9WP2Clb3sP7ws6O5N6hMtOU8Pdce+/+Y4VEgTupBvcirHol8cci
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="338401271"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="338401271"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 19:21:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="746987117"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="746987117"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.105])
  by fmsmga008.fm.intel.com with ESMTP; 23 Mar 2023 19:20:52 -0700
Date:   Fri, 24 Mar 2023 10:13:17 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Michael Roth <michael.roth@amd.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>, tabba@google.com,
        mhocko@suse.com, wei.w.wang@intel.com
Subject: Re: [PATCH v10 0/9] KVM: mm: fd-based approach for supporting KVM
Message-ID: <20230324021317.GB2774613@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <Y8H5Z3e4hZkFxAVS@google.com>
 <20230119111308.GC2976263@ls.amr.corp.intel.com>
 <Y8lg1G2lRIrI/hld@google.com>
 <20230119223704.GD2976263@ls.amr.corp.intel.com>
 <Y880FiYF7YCtsw/i@google.com>
 <20230213130102.two7q3kkcf254uof@amd.com>
 <20230221121135.GA1595130@chaop.bj.intel.com>
 <20230323012737.7vn4ynsbfz7c2ch4@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323012737.7vn4ynsbfz7c2ch4@amd.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 22, 2023 at 08:27:37PM -0500, Michael Roth wrote:
> On Tue, Feb 21, 2023 at 08:11:35PM +0800, Chao Peng wrote:
> > > Hi Sean,
> > > 
> > > We've rebased the SEV+SNP support onto your updated UPM base support
> > > tree and things seem to be working okay, but we needed some fixups on
> > > top of the base support get things working, along with 1 workaround
> > > for an issue that hasn't been root-caused yet:
> > > 
> > >   https://github.com/mdroth/linux/commits/upmv10b-host-snp-v8-wip
> > > 
> > >   *stash (upm_base_support): mm: restrictedmem: Kirill's pinning implementation
> > >   *workaround (use_base_support): mm: restrictedmem: loosen exclusivity check
> > 
> > What I'm seeing is Slot#3 gets added first and then deleted. When it's
> > gets added, Slot#0 already has the same range bound to restrictedmem so
> > trigger the exclusive check. This check is exactly the current code for.
> 
> With the following change in QEMU, we no longer trigger this check:
> 
>   diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
>   index 20da121374..849b5de469 100644
>   --- a/hw/pci-host/q35.c
>   +++ b/hw/pci-host/q35.c
>   @@ -588,9 +588,9 @@ static void mch_realize(PCIDevice *d, Error **errp)
>        memory_region_init_alias(&mch->open_high_smram, OBJECT(mch), "smram-open-high",
>                                 mch->ram_memory, MCH_HOST_BRIDGE_SMRAM_C_BASE,
>                                 MCH_HOST_BRIDGE_SMRAM_C_SIZE);
>   +    memory_region_set_enabled(&mch->open_high_smram, false);
>        memory_region_add_subregion_overlap(mch->system_memory, 0xfeda0000,
>                                            &mch->open_high_smram, 1);
>   -    memory_region_set_enabled(&mch->open_high_smram, false);
> 
> I'm not sure if QEMU is actually doing something wrong here though or if
> this check is putting tighter restrictions on userspace than what was
> expected before. Will look into it more.

I don't think above QEMU change is upstream acceptable. It may break
functionality for 'normal' VMs.

The UPM check does putting tighter restriction, the restriction is that
you can't bind the same fd range to more than one memslot. For SMRAM in
QEMU however, it violates this restriction. The right 'fix' is disabling
SMM in QEMU for UPM usages rather than trying to work around it. There
is more discussion in below link:

  https://lore.kernel.org/all/Y8bOB7VuVIsxoMcn@google.com/

Chao

> 
> > 
> > >   *fixup (upm_base_support): KVM: use inclusive ranges for restrictedmem binding/unbinding
> > >   *fixup (upm_base_support): mm: restrictedmem: use inclusive ranges for issuing invalidations
> > 
> > As many kernel APIs treat 'end' as exclusive, I would rather keep using
> > exclusive 'end' for these APIs(restrictedmem_bind/restrictedmem_unbind
> > and notifier callbacks) but fix it internally in the restrictedmem. E.g.
> > all the places where xarray API needs a 'last'/'max' we use 'end - 1'.
> > See below for the change.
> 
> Yes I did feel like I was fighting the kernel a bit on that; your
> suggestion seems like it would be a better fit.
> 
> > 
> > >   *fixup (upm_base_support): KVM: fix restrictedmem GFN range calculations
> > 
> > Subtracting slot->restrictedmem.index for start/end in
> > restrictedmem_get_gfn_range() is the correct fix.
> > 
> > >   *fixup (upm_base_support): KVM: selftests: CoCo compilation fixes
> > > 
> > > We plan to post an updated RFC for v8 soon, but also wanted to share
> > > the staging tree in case you end up looking at the UPM integration aspects
> > > before then.
> > > 
> > > -Mike
> > 
> > This is the restrictedmem fix to solve 'end' being stored and checked in xarray:
> 
> Looks good.
> 
> Thanks!
> 
> -Mike
> 
> > 
> > --- a/mm/restrictedmem.c
> > +++ b/mm/restrictedmem.c
> > @@ -46,12 +46,12 @@ static long restrictedmem_punch_hole(struct restrictedmem *rm, int mode,
> >          */
> >         down_read(&rm->lock);
> >  
> > -       xa_for_each_range(&rm->bindings, index, notifier, start, end)
> > +       xa_for_each_range(&rm->bindings, index, notifier, start, end - 1)
> >                 notifier->ops->invalidate_start(notifier, start, end);
> >  
> >         ret = memfd->f_op->fallocate(memfd, mode, offset, len);
> >  
> > -       xa_for_each_range(&rm->bindings, index, notifier, start, end)
> > +       xa_for_each_range(&rm->bindings, index, notifier, start, end - 1)
> >                 notifier->ops->invalidate_end(notifier, start, end);
> >  
> >         up_read(&rm->lock);
> > @@ -224,7 +224,7 @@ static int restricted_error_remove_page(struct address_space *mapping,
> >                 }
> >                 spin_unlock(&inode->i_lock);
> >  
> > -               xa_for_each_range(&rm->bindings, index, notifier, start, end)
> > +               xa_for_each_range(&rm->bindings, index, notifier, start, end - 1)
> >                         notifier->ops->error(notifier, start, end);
> >                 break;
> >         }
> > @@ -301,11 +301,12 @@ int restrictedmem_bind(struct file *file, pgoff_t start, pgoff_t end,
> >                 if (exclusive != rm->exclusive)
> >                         goto out_unlock;
> >  
> > -               if (exclusive && xa_find(&rm->bindings, &start, end, XA_PRESENT))
> > +               if (exclusive &&
> > +                   xa_find(&rm->bindings, &start, end - 1, XA_PRESENT))
> >                         goto out_unlock;
> >         }
> >  
> > -       xa_store_range(&rm->bindings, start, end, notifier, GFP_KERNEL);
> > +       xa_store_range(&rm->bindings, start, end - 1, notifier, GFP_KERNEL);
> >         rm->exclusive = exclusive;
> >         ret = 0;
> >  out_unlock:
> > @@ -320,7 +321,7 @@ void restrictedmem_unbind(struct file *file, pgoff_t start, pgoff_t end,
> >         struct restrictedmem *rm = file->f_mapping->private_data;
> >  
> >         down_write(&rm->lock);
> > -       xa_store_range(&rm->bindings, start, end, NULL, GFP_KERNEL);
> > +       xa_store_range(&rm->bindings, start, end - 1, NULL, GFP_KERNEL);
> >         synchronize_rcu();
> >         up_write(&rm->lock);
> >  }
