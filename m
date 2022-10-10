Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68AD25F9B04
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Oct 2022 10:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbiJJI34 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Oct 2022 04:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbiJJI3x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Oct 2022 04:29:53 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605C015FC9;
        Mon, 10 Oct 2022 01:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665390592; x=1696926592;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=5AUxEww8V8qWvvG5bCArmS7RBRQUNOLUMKgyDwR1O0k=;
  b=mC0prYi4XCb2fnmmDbKr5ZHMRDx9mqzE9wwo9ChA1hExPGhdnHFSz5jJ
   H3qljG6LEBcGoyP12aVXoN3q6QsrOg0Dze95/twoHjvhdulfwTdeCpkz3
   2zfiT1ap23hlrgfritrSHLg/F877ePbjRWn5TcW+MXKFq/PJ1kZ48Rghk
   sAt+AGhkAlcl1ueHyVkobJo5zHiksMZo427qUZhGXJSzDi1uLiVXr9VLD
   +eMpYrNA2F0o+alTsCtHDL4VAUEelTgSudZfGU1YcoDd3Z9Gauoi5jqoH
   LKN6SLpquJbRVVf17YvQv3u6Wr4J9rqEKnmIdQzGz2OGxHfA6j11otA1A
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="366137263"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="366137263"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 01:29:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="656853060"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="656853060"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by orsmga008.jf.intel.com with ESMTP; 10 Oct 2022 01:29:40 -0700
Date:   Mon, 10 Oct 2022 16:25:07 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
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
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Subject: Re: [PATCH v8 2/8] KVM: Extend the memslot to support fd-based
 private memory
Message-ID: <20221010082507.GA3144879@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-3-chao.p.peng@linux.intel.com>
 <Yz7s+JIexAHJm5dc@kernel.org>
 <Yz7vHXZmU3EpmI0j@kernel.org>
 <Yz71ogila0mSHxxJ@google.com>
 <Y0AJ++m/TxoscOZg@kernel.org>
 <Y0A+rogB6TRDtbyE@google.com>
 <Y0CgFIq6JnHmdWrL@kernel.org>
 <Y0GiEW0cYCNx5jyK@kernel.org>
 <Y0G085xCmFBxSodG@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0G085xCmFBxSodG@kernel.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 08, 2022 at 08:35:47PM +0300, Jarkko Sakkinen wrote:
> On Sat, Oct 08, 2022 at 07:15:17PM +0300, Jarkko Sakkinen wrote:
> > On Sat, Oct 08, 2022 at 12:54:32AM +0300, Jarkko Sakkinen wrote:
> > > On Fri, Oct 07, 2022 at 02:58:54PM +0000, Sean Christopherson wrote:
> > > > On Fri, Oct 07, 2022, Jarkko Sakkinen wrote:
> > > > > On Thu, Oct 06, 2022 at 03:34:58PM +0000, Sean Christopherson wrote:
> > > > > > On Thu, Oct 06, 2022, Jarkko Sakkinen wrote:
> > > > > > > On Thu, Oct 06, 2022 at 05:58:03PM +0300, Jarkko Sakkinen wrote:
> > > > > > > > On Thu, Sep 15, 2022 at 10:29:07PM +0800, Chao Peng wrote:
> > > > > > > > > This new extension, indicated by the new flag KVM_MEM_PRIVATE, adds two
> > > > > > > > > additional KVM memslot fields private_fd/private_offset to allow
> > > > > > > > > userspace to specify that guest private memory provided from the
> > > > > > > > > private_fd and guest_phys_addr mapped at the private_offset of the
> > > > > > > > > private_fd, spanning a range of memory_size.
> > > > > > > > > 
> > > > > > > > > The extended memslot can still have the userspace_addr(hva). When use, a
> > > > > > > > > single memslot can maintain both private memory through private
> > > > > > > > > fd(private_fd/private_offset) and shared memory through
> > > > > > > > > hva(userspace_addr). Whether the private or shared part is visible to
> > > > > > > > > guest is maintained by other KVM code.
> > > > > > > > 
> > > > > > > > What is anyway the appeal of private_offset field, instead of having just
> > > > > > > > 1:1 association between regions and files, i.e. one memfd per region?
> > > > > > 
> > > > > > Modifying memslots is slow, both in KVM and in QEMU (not sure about Google's VMM).
> > > > > > E.g. if a vCPU converts a single page, it will be forced to wait until all other
> > > > > > vCPUs drop SRCU, which can have severe latency spikes, e.g. if KVM is faulting in
> > > > > > memory.  KVM's memslot updates also hold a mutex for the entire duration of the
> > > > > > update, i.e. conversions on different vCPUs would be fully serialized, exacerbating
> > > > > > the SRCU problem.
> > > > > > 
> > > > > > KVM also has historical baggage where it "needs" to zap _all_ SPTEs when any
> > > > > > memslot is deleted.
> > > > > > 
> > > > > > Taking both a private_fd and a shared userspace address allows userspace to convert
> > > > > > between private and shared without having to manipulate memslots.
> > > > > 
> > > > > Right, this was really good explanation, thank you.
> > > > > 
> > > > > Still wondering could this possibly work (or not):
> > > > > 
> > > > > 1. Union userspace_addr and private_fd.
> > > > 
> > > > No, because userspace needs to be able to provide both userspace_addr (shared
> > > > memory) and private_fd (private memory) for a single memslot.
> > > 
> > > Got it, thanks for clearing my misunderstandings on this topic, and it
> > > is quite obviously visible in 5/8 and 7/8. I.e. if I got it right,
> > > memblock can be partially private, and you dig the shared holes with
> > > KVM_MEMORY_ENCRYPT_UNREG_REGION. We have (in Enarx) ATM have memblock
> > > per host mmap, I was looking into this dilated by that mindset but makes
> > > definitely sense to support that.
> > 
> > For me the most useful reference with this feature is kvm_set_phys_mem()
> > implementation in privmem-v8 branch. Took while to find it because I did
> > not have much experience with QEMU code base. I'd even recommend to mention
> > that function in the cover letter because it is really good reference on
> > how this feature is supposed to be used.

That's a good point, I can mention that if people find useful. 

> 
> While learning QEMU code, I also noticed bunch of comparison like this:
> 
> if (slot->flags | KVM_MEM_PRIVATE)
> 
> I guess those could be just replaced with unconditional fills as it does
> not do any harm, if KVM_MEM_PRIVATE is not set.

Make sense, thanks.

Chao
> 
> BR, Jarkko
