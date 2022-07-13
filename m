Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E67F574035
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jul 2022 01:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbiGMXwe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 19:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiGMXwc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 19:52:32 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31ABE52DF2;
        Wed, 13 Jul 2022 16:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657756351; x=1689292351;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=d4b95Nutiv+fVkeoTmmbeGdels6G19ALZ7QCpFCTTwc=;
  b=ec0iUFs99XSrMBcTD4mfXpTGHIwEqAsiwpuU0GWzLKvYLXib/Azi8/Ly
   9SiWuFCJyvAZfo7rLKu5nf79sZvP+XJ6uh10Bz4eaKKMTjP83DO/NRwwk
   m2H19M4PddgwWJsAoRb8+MPNz4kFHILwnuhNGexn3kqyeiEwcLlDCXmaR
   f/0qxuApQRvbaQdu1Pxx0cgYHtScpq0DVs3CUY6sQAG+li45pLMiuilKj
   9aEC94fvRy0+sWgWzOfKcnrFNwVTXXH0vp4CRxjh+iFcQB6PrH+VabVvQ
   mFbVzKYeTFIA9a93CFf+yAD4urjaNXi2VrlFY5v1J6eCWO7OiDlGD4o6Y
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="371685475"
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="371685475"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 16:52:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="593176855"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by orsmga007.jf.intel.com with ESMTP; 13 Jul 2022 16:52:20 -0700
Date:   Thu, 14 Jul 2022 07:49:03 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     "Gupta, Pankaj" <pankaj.gupta@amd.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
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
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v7 04/14] mm/shmem: Support memfile_notifier
Message-ID: <20220713234903.GA2881285@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-5-chao.p.peng@linux.intel.com>
 <c4112b84-9359-d4c8-1852-0057c074607c@amd.com>
 <20220713074458.GB2831541@chaop.bj.intel.com>
 <74097857-1908-2ff2-1e54-bf7e658ea6c6@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74097857-1908-2ff2-1e54-bf7e658ea6c6@amd.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 13, 2022 at 12:01:13PM +0200, Gupta, Pankaj wrote:
> 
> > > > +#ifdef CONFIG_MIGRATION
> > > > +static int shmem_migrate_page(struct address_space *mapping,
> > > > +			      struct page *newpage, struct page *page,
> > > > +			      enum migrate_mode mode)
> > > > +{
> > > > +	struct inode *inode = mapping->host;
> > > > +	struct shmem_inode_info *info = SHMEM_I(inode);
> > > > +
> > > > +	if (info->memfile_node.flags & MEMFILE_F_UNMOVABLE)
> > > > +		return -EOPNOTSUPP;
> > > > +	return migrate_page(mapping, newpage, page, mode);
> > > 
> > > Wondering how well page migrate would work for private pages
> > > on shmem memfd based backend?
> > 
> >  From high level:
> >    - KVM unset MEMFILE_F_UNMOVABLE bit to indicate it capable of
> >      migrating a page.
> >    - Introduce new 'migrate' callback(s) to memfile_notifier_ops for KVM
> >      to register.
> >    - The callback is hooked to migrate_page() here.
> >    - Once page migration requested, shmem calls into the 'migrate'
> >      callback(s) to perform additional steps for encrypted memory (For
> >      TDX we will call TDH.MEM.PAGE.RELOCATE).
> 
> Yes, that would require additional (protocol specific) handling for private
> pages. Was trying to find where "MEMFILE_F_UNMOVABLE" flag is set currently?

It's set with memfile_register_notifier() in patch 13.

> 
> Thanks,
> Pankaj
