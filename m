Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCF74F964A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 15:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236043AbiDHNFS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Apr 2022 09:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbiDHNFR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Apr 2022 09:05:17 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774751E868C;
        Fri,  8 Apr 2022 06:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649422993; x=1680958993;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=fGTAiXBITEf6vhZtefTnJfo1Ql9L0wnvDyySANGwVrA=;
  b=VImeqnQFsQyUuCRPDCbJI0VwXqNsrM93rbqct0nITwfbOLFGAfVcYnc7
   MWggwbdwC7x+2YyvFCrHG1ewR8ekCYytgA7PiakRUQ+bvk791xwRER23P
   oMQCDb+wuzhGZXS1GM3SnvtBIiwb6cdp56uJ9J4sU/bntxkZYzySEClMP
   AmCw2UsRDJjK/8JuCkeAgk0EvJ6S7n5EWUkb6Is70uKAt7+5x74YJRUa/
   wabL4YapZrjwggaXRXmEhIOIVmrvKLTvLpX7db/HkBEg9W1nZr+AmC3cW
   5xwmSKUtes9mwNELZycnETTuXRjo28ANyie8lgMFfySkf5Uc1LFOfm+v9
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="242181296"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="242181296"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 06:03:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="698175603"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by fmsmga001.fm.intel.com with ESMTP; 08 Apr 2022 06:03:05 -0700
Date:   Fri, 8 Apr 2022 21:02:54 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com
Subject: Re: [PATCH v5 04/13] mm/shmem: Restrict MFD_INACCESSIBLE memory
 against RLIMIT_MEMLOCK
Message-ID: <20220408130254.GB57095@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <20220310140911.50924-5-chao.p.peng@linux.intel.com>
 <Yk8L0CwKpTrv3Rg3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yk8L0CwKpTrv3Rg3@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 07, 2022 at 04:05:36PM +0000, Sean Christopherson wrote:
> On Thu, Mar 10, 2022, Chao Peng wrote:
> > Since page migration / swapping is not supported yet, MFD_INACCESSIBLE
> > memory behave like longterm pinned pages and thus should be accounted to
> > mm->pinned_vm and be restricted by RLIMIT_MEMLOCK.
> > 
> > Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> > ---
> >  mm/shmem.c | 25 ++++++++++++++++++++++++-
> >  1 file changed, 24 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 7b43e274c9a2..ae46fb96494b 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -915,14 +915,17 @@ static void notify_fallocate(struct inode *inode, pgoff_t start, pgoff_t end)
> >  static void notify_invalidate_page(struct inode *inode, struct folio *folio,
> >  				   pgoff_t start, pgoff_t end)
> >  {
> > -#ifdef CONFIG_MEMFILE_NOTIFIER
> >  	struct shmem_inode_info *info = SHMEM_I(inode);
> >  
> > +#ifdef CONFIG_MEMFILE_NOTIFIER
> >  	start = max(start, folio->index);
> >  	end = min(end, folio->index + folio_nr_pages(folio));
> >  
> >  	memfile_notifier_invalidate(&info->memfile_notifiers, start, end);
> >  #endif
> > +
> > +	if (info->xflags & SHM_F_INACCESSIBLE)
> > +		atomic64_sub(end - start, &current->mm->pinned_vm);
> 
> As Vishal's to-be-posted selftest discovered, this is broken as current->mm may
> be NULL.  Or it may be a completely different mm, e.g. AFAICT there's nothing that
> prevents a different process from punching hole in the shmem backing.
> 
> I don't see a sane way of tracking this in the backing store unless the inode is
> associated with a single mm when it's created, and that opens up a giant can of
> worms, e.g. what happens with the accounting if the creating process goes away?

Yes, I realized this.

> 
> I think the correct approach is to not do the locking automatically for SHM_F_INACCESSIBLE,
> and instead require userspace to do shmctl(.., SHM_LOCK, ...) if userspace knows the
> consumers don't support migrate/swap.  That'd require wrapping migrate_page() and then
> wiring up notifier hooks for migrate/swap, but IMO that's a good thing to get sorted
> out sooner than later.  KVM isn't planning on support migrate/swap for TDX or SNP,
> but supporting at least migrate for a software-only implementation a la pKVM should
> be relatively straightforward.  On the notifiee side, KVM can terminate the VM if it
> gets an unexpected migrate/swap, e.g. so that TDX/SEV VMs don't die later with
> exceptions and/or data corruption (pre-SNP SEV guests) in the guest.

SHM_LOCK sounds like a good match.

Thanks,
Chao
> 
> Hmm, shmem_writepage() already handles SHM_F_INACCESSIBLE by rejecting the swap, so
> maybe it's just the page migration path that needs to be updated?
