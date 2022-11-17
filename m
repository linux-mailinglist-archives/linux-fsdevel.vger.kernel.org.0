Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A94E62DD24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Nov 2022 14:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239529AbiKQNrn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 08:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240136AbiKQNr0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:47:26 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775D971F29;
        Thu, 17 Nov 2022 05:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668692845; x=1700228845;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=Q9f7oXH6jx2XN9/kuSzGlUsyVFF0nM+veoTgLTKHR8Y=;
  b=F0d+/GQ7xQLj7304vUTKmq+rVu8TfEczUGa/K+2yUL+d/VE7F17EhAiM
   6IHHriONQigDxNDz/OHY3i4H1KHUdthM71YWlcS/CKkOd2fdsFxdJ+jzw
   29ZYODwvPR8GTiNzzv30Km4bJsd/D+UjmAncVzR9VHXakNK2ipOkKpR52
   mmt69hGpf00XZ6VClk/9P87nkvw7WREb7MVUuQcsn04oXo9t0ldHliBNK
   IT2pq3NaLfooHMAOe0+YTefayNbGxZ6N66toh1Elb5++CSlz6toooMcUT
   KNZH9WCRMtdYjDQ85iRkSp1YAoc2v/SqIjukXAaHXuA+fzpEoeHl7nuyq
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="293246760"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="293246760"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 05:47:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="670927116"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="670927116"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by orsmga008.jf.intel.com with ESMTP; 17 Nov 2022 05:47:14 -0800
Date:   Thu, 17 Nov 2022 21:42:50 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>, kvm list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, Linux API <linux-api@vger.kernel.org>,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Fuad Tabba <tabba@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Wei W Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v9 3/8] KVM: Add KVM_EXIT_MEMORY_FAULT exit
Message-ID: <20221117134250.GC422408@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <20221025151344.3784230-4-chao.p.peng@linux.intel.com>
 <2e252f4f-7d45-42ac-a88f-fa8045fe3748@app.fastmail.com>
 <Y3Uwi2lc4NDrdzML@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3Uwi2lc4NDrdzML@google.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 16, 2022 at 06:48:43PM +0000, Sean Christopherson wrote:
> On Wed, Nov 16, 2022, Andy Lutomirski wrote:
> > 
> > 
> > On Tue, Oct 25, 2022, at 8:13 AM, Chao Peng wrote:
> > > diff --git a/Documentation/virt/kvm/api.rst 
> > > b/Documentation/virt/kvm/api.rst
> > > index f3fa75649a78..975688912b8c 100644
> > > --- a/Documentation/virt/kvm/api.rst
> > > +++ b/Documentation/virt/kvm/api.rst
> > > @@ -6537,6 +6537,29 @@ array field represents return values. The 
> > > userspace should update the return
> > >  values of SBI call before resuming the VCPU. For more details on 
> > > RISC-V SBI
> > >  spec refer, https://github.com/riscv/riscv-sbi-doc.
> > > 
> > > +::
> > > +
> > > +		/* KVM_EXIT_MEMORY_FAULT */
> > > +		struct {
> > > +  #define KVM_MEMORY_EXIT_FLAG_PRIVATE	(1 << 0)
> > > +			__u32 flags;
> > > +			__u32 padding;
> > > +			__u64 gpa;
> > > +			__u64 size;
> > > +		} memory;
> > > +
> > 
> > Would it make sense to also have a field for the access type (read, write,
> > execute, etc)?  I realize that shared <-> private conversion doesn't strictly
> > need this, but it seems like it could be useful for logging failures and also
> > for avoiding a second immediate fault if the type gets converted but doesn't
> > have the right protection yet.
> 
> I don't think a separate field is necessary, that info can be conveyed via flags.
> Though maybe we should go straight to a u64 for flags.

Yeah, I can do that.

> Hmm, and maybe avoid bits
> 0-3 so that if/when RWX info is conveyed the flags can align with
> PROT_{READ,WRITE,EXEC} and the EPT flags, e.g.

You mean avoiding bits 0-2, right, bit3 is not so special and can be used
for KVM_MEMORY_EXIT_FLAG_PRIVATE.

Chao
> 
> 	KVM_MEMORY_EXIT_FLAG_READ	(1 << 0)
> 	KVM_MEMORY_EXIT_FLAG_WRITE	(1 << 1)
> 	KVM_MEMORY_EXIT_FLAG_EXECUTE	(1 << 2)
> 
> > (Obviously, if this were changed, KVM would need the ability to report that
> > it doesn't actually know the mode.)
> > 
> > --Andy
