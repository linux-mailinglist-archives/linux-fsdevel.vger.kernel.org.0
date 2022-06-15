Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E568954C40A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 10:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243939AbiFOI4x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 04:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235386AbiFOI4t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 04:56:49 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDC43CA65;
        Wed, 15 Jun 2022 01:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655283409; x=1686819409;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=YUylNu9M17rCKFlfGnkhsZRqok22qMLdjCA7fnGzy7c=;
  b=NbZ9+CyUHocvHsi1PmjXztgbRL/+O1bDVGGI05z1EkSy0Vy2ko/5OUs0
   dux/8ByjCtROh3Oc3sJ8661OT5u1TTPS6nE3fPZN90fzZJ/St6ickxo64
   ed5H/jHlGzmyZAGCXfD9QtXzPwmWtnzzR59OUOhG9HKHwD7dOwOYmBTRD
   ejtuqDSYxlkf4w7BxogzdRPmZ04m98fURnREiaGyAdP3g/pKil6kAiQH1
   hJ+Kq+wLaVEFBQFLvwwRR6TNjj8rC8i/fHm8wg+FDnjQcoBofeQ7VBSsG
   7x+D+b6t2zZdUy0dKM8PQJSePwbusSQnr3MC2fz9SBMu8eb413Sy8jhjd
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="277679791"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="277679791"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 01:56:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="589000276"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by fmsmga007.fm.intel.com with ESMTP; 15 Jun 2022 01:56:38 -0700
Date:   Wed, 15 Jun 2022 16:53:16 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     "Gupta, Pankaj" <pankaj.gupta@amd.com>,
        Vishal Annapurve <vannapurve@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
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
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jun Nakajima <jun.nakajima@intel.com>, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com
Subject: Re: [PATCH v6 3/8] mm/memfd: Introduce MFD_INACCESSIBLE flag
Message-ID: <20220615085316.GA1823790@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220519153713.819591-1-chao.p.peng@linux.intel.com>
 <20220519153713.819591-4-chao.p.peng@linux.intel.com>
 <CAGtprH8EMsPMMoOEzjRu0SMVKT0RqmkLk=n+6uXkBA6-wiRtUA@mail.gmail.com>
 <20220601101747.GA1255243@chaop.bj.intel.com>
 <1f1b17e8-a16d-c029-88e0-01f522cc077a@amd.com>
 <20220602100733.GA1296997@chaop.bj.intel.com>
 <YqjuUngpVg8cZTD/@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqjuUngpVg8cZTD/@google.com>
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 14, 2022 at 08:23:46PM +0000, Sean Christopherson wrote:
> On Thu, Jun 02, 2022, Chao Peng wrote:
> > On Wed, Jun 01, 2022 at 02:11:42PM +0200, Gupta, Pankaj wrote:
> > > 
> > > > > > Introduce a new memfd_create() flag indicating the content of the
> > > > > > created memfd is inaccessible from userspace through ordinary MMU
> > > > > > access (e.g., read/write/mmap). However, the file content can be
> > > > > > accessed via a different mechanism (e.g. KVM MMU) indirectly.
> > > > > > 
> > > > > 
> > > > > SEV, TDX, pkvm and software-only VMs seem to have usecases to set up
> > > > > initial guest boot memory with the needed blobs.
> > > > > TDX already supports a KVM IOCTL to transfer contents to private
> > > > > memory using the TDX module but rest of the implementations will need
> > > > > to invent
> > > > > a way to do this.
> > > > 
> > > > There are some discussions in https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2022%2F5%2F9%2F1292&amp;data=05%7C01%7Cpankaj.gupta%40amd.com%7Cb81ef334e2dd44c6143308da43b87d17%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637896756895977587%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=oQbM2Hj7GlhJTwnTM%2FPnwsfJlmTL7JR9ULBysAqm6V8%3D&amp;reserved=0
> > > > already. I somehow agree with Sean. TDX is using an dedicated ioctl to
> > > > copy guest boot memory to private fd so the rest can do that similarly.
> > > > The concern is the performance (extra memcpy) but it's trivial since the
> > > > initial guest payload is usually optimized in size.
> > > > 
> > > > > 
> > > > > Is there a plan to support a common implementation for either allowing
> > > > > initial write access from userspace to private fd or adding a KVM
> > > > > IOCTL to transfer contents to such a file,
> > > > > as part of this series through future revisions?
> > > > 
> > > > Indeed, adding pre-boot private memory populating on current design
> > > > isn't impossible, but there are still some opens, e.g. how to expose
> > > > private fd to userspace for access, pKVM and CC usages may have
> > > > different requirements. Before that's well-studied I would tend to not
> > > > add that and instead use an ioctl to copy. Whether we need a generic
> > > > ioctl or feature-specific ioctl, I don't have strong opinion here.
> > > > Current TDX uses a feature-specific ioctl so it's not covered in this
> > > > series.
> > > 
> > > Common function or ioctl to populate preboot private memory actually makes
> > > sense.
> > > 
> > > Sorry, did not follow much of TDX code yet, Is it possible to filter out
> > > the current TDX specific ioctl to common function so that it can be used by
> > > other technologies?
> > 
> > TDX code is here:
> > https://patchwork.kernel.org/project/kvm/patch/70ed041fd47c1f7571aa259450b3f9244edda48d.1651774250.git.isaku.yamahata@intel.com/
> > 
> > AFAICS It might be possible to filter that out to a common function. But
> > would like to hear from Paolo/Sean for their opinion.
> 
> Eh, I wouldn't put too much effort into creating a common helper, I would be very
> surprised if TDX and SNP can share a meaningful amount of code that isn't already
> shared, e.g. provided by MMU helpers.
> 
> The only part I truly care about sharing is whatever ioctl(s) get added, i.e. I
> don't want to end up with two ioctls that do the same thing for TDX vs. SNP.

OK, then that part would be better to be added in TDX or SNP series.

Chao
