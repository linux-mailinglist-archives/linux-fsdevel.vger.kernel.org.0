Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E324C1216
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 13:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240210AbiBWMBy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 07:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbiBWMBx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 07:01:53 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0C99A4ED;
        Wed, 23 Feb 2022 04:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645617685; x=1677153685;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=eoV+NoqJpfdApzLIf0eBSfJu/vs2jcIFT1WCrSXOtdw=;
  b=iLngOzGH4PoTbIKFUazf5Mawfw5oC0OcT19HQOliRJfnJoHK0URhdOT+
   g0I39UdUdSjrNYqZEiAcHRd655lGVokoHuSIXxx8orKo6g6m1ugFQXqmY
   ARMtJ2Yic+VfKTouKjnt7hdfegfJPXOtA4mm4OeD0OIqMDLwwn86h2JD8
   AFOnLTRJr7LGWJJkVQqJuvmig6MGEoWW/3BVVQhqaJeX6Rcz/byP1eyYQ
   RAJLOhCTQm1E5Ru/cdwg+6VnmRISnPjZMNDzl8sNvenWYhMBYqOrV/mIP
   TwKzExSnP/R0/Ss5Y476vSGMsth41ecruomSOUJAJ+L5aLROsguehz0yb
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="338384365"
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="338384365"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 04:01:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="532653565"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by orsmga007.jf.intel.com with ESMTP; 23 Feb 2022 04:01:07 -0800
Date:   Wed, 23 Feb 2022 20:00:47 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Yu Zhang <yu.c.zhang@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, kvm@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 12/12] KVM: Expose KVM_MEM_PRIVATE
Message-ID: <20220223120047.GB53733@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220118132121.31388-1-chao.p.peng@linux.intel.com>
 <20220118132121.31388-13-chao.p.peng@linux.intel.com>
 <a121e766-900d-2135-1516-e1d3ba716834@maciej.szmigiero.name>
 <20220217134548.GA33836@chaop.bj.intel.com>
 <45148f5f-fe79-b452-f3b2-482c5c3291c4@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45148f5f-fe79-b452-f3b2-482c5c3291c4@maciej.szmigiero.name>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 22, 2022 at 02:16:46AM +0100, Maciej S. Szmigiero wrote:
> On 17.02.2022 14:45, Chao Peng wrote:
> > On Tue, Jan 25, 2022 at 09:20:39PM +0100, Maciej S. Szmigiero wrote:
> > > On 18.01.2022 14:21, Chao Peng wrote:
> > > > KVM_MEM_PRIVATE is not exposed by default but architecture code can turn
> > > > on it by implementing kvm_arch_private_memory_supported().
> > > > 
> > > > Also private memslot cannot be movable and the same file+offset can not
> > > > be mapped into different GFNs.
> > > > 
> > > > Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> > > > Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> > > > ---
> > > (..)
> > > >    static bool kvm_check_memslot_overlap(struct kvm_memslots *slots, int id,
> > > > -				      gfn_t start, gfn_t end)
> > > > +				      struct file *file,
> > > > +				      gfn_t start, gfn_t end,
> > > > +				      loff_t start_off, loff_t end_off)
> > > >    {
> > > >    	struct kvm_memslot_iter iter;
> > > > +	struct kvm_memory_slot *slot;
> > > > +	struct inode *inode;
> > > > +	int bkt;
> > > >    	kvm_for_each_memslot_in_gfn_range(&iter, slots, start, end) {
> > > >    		if (iter.slot->id != id)
> > > >    			return true;
> > > >    	}
> > > > +	/* Disallow mapping the same file+offset into multiple gfns. */
> > > > +	if (file) {
> > > > +		inode = file_inode(file);
> > > > +		kvm_for_each_memslot(slot, bkt, slots) {
> > > > +			if (slot->private_file &&
> > > > +			     file_inode(slot->private_file) == inode &&
> > > > +			     !(end_off <= slot->private_offset ||
> > > > +			       start_off >= slot->private_offset
> > > > +					     + (slot->npages >> PAGE_SHIFT)))
> > > > +				return true;
> > > > +		}
> > > > +	}
> > > 
> > > That's a linear scan of all memslots on each CREATE (and MOVE) operation
> > > with a fd - we just spent more than a year rewriting similar linear scans
> > > into more efficient operations in KVM.
> > 
> > In the last version I tried to solve this problem by using interval tree
> > (just like existing hva_tree), but finally we realized that in one VM we
> > can have multiple fds with overlapped offsets so that approach is
> > incorrect. See https://lkml.org/lkml/2021/12/28/480 for the discussion.
> 
> That's right, in this case a two-level structure would be necessary:
> the first level matching a file, then the second level matching that
> file ranges.
> However, if such data is going to be used just for checking possible
> overlap at memslot add or move time it is almost certainly an overkill.

Yes, that is also what I'm seeing.

> 
> > So linear scan is used before I can find a better way.
> 
> Another option would be to simply not check for overlap at add or move
> time, declare such configuration undefined behavior under KVM API and
> make sure in MMU notifiers that nothing bad happens to the host kernel
> if it turns out somebody actually set up a VM this way (it could be
> inefficient in this case, since it's not supposed to ever happen
> unless there is a bug somewhere in the userspace part).

Specific to TDX case, SEAMMODULE will fail the overlapping case and then
KVM prints a message to the kernel log. It will not cause any other side
effect, it does look weird however. Yes warn that in the API document
can help to some extent.

Thanks,
Chao
> 
> > Chao
> 
> Thanks,
> Maciej
