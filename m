Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82364C24DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 09:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbiBXIIg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 03:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiBXIIf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 03:08:35 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166111B988A;
        Thu, 24 Feb 2022 00:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645690086; x=1677226086;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=zEoJWzKmpcYe9rSTl+BlseiX6qsVqXPhxybFv18kU3Y=;
  b=YmXVklXWeL5w30rG/hRcjNLdX8WWQVkkme0P4DW7eUh3yPHii0CrJU0E
   BXClZehcmm9xlnMr6xxiw6djBiS8pHNdhJX+4HAsjaXjz8hNrDs5c2uiJ
   TnNyJvVpOx/7GqUAW3go9UiTOCyw6jbMNLul4GOTuYQRfLlDC0EQy11Dq
   EMkjBydr4sn+mybv/Rb97UgHaeCT8ZnKVrcQD0e6c3uv4ViR5W93wMptF
   LNnb9IuGb34vbTHJtZTaupOHnLI1PBB0PBYMkK4boP/X937bSTydQ/eLP
   AZTYtfVRygMRXPDobTS/9QfFQY3bamfZ16ZO+RCaPmc89ofqQA4llys2e
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="251004744"
X-IronPort-AV: E=Sophos;i="5.88,393,1635231600"; 
   d="scan'208";a="251004744"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 00:08:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,393,1635231600"; 
   d="scan'208";a="637745308"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by fmsmga002.fm.intel.com with ESMTP; 24 Feb 2022 00:07:58 -0800
Date:   Thu, 24 Feb 2022 16:07:39 +0800
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
Message-ID: <20220224080739.GA6672@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220118132121.31388-1-chao.p.peng@linux.intel.com>
 <20220118132121.31388-13-chao.p.peng@linux.intel.com>
 <a121e766-900d-2135-1516-e1d3ba716834@maciej.szmigiero.name>
 <20220217134548.GA33836@chaop.bj.intel.com>
 <45148f5f-fe79-b452-f3b2-482c5c3291c4@maciej.szmigiero.name>
 <20220223120047.GB53733@chaop.bj.intel.com>
 <7822c00f-5a2d-b6a2-2f81-cf3330801ad3@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7822c00f-5a2d-b6a2-2f81-cf3330801ad3@maciej.szmigiero.name>
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

On Wed, Feb 23, 2022 at 07:32:37PM +0100, Maciej S. Szmigiero wrote:
> On 23.02.2022 13:00, Chao Peng wrote:
> > On Tue, Feb 22, 2022 at 02:16:46AM +0100, Maciej S. Szmigiero wrote:
> > > On 17.02.2022 14:45, Chao Peng wrote:
> > > > On Tue, Jan 25, 2022 at 09:20:39PM +0100, Maciej S. Szmigiero wrote:
> > > > > On 18.01.2022 14:21, Chao Peng wrote:
> > > > > > KVM_MEM_PRIVATE is not exposed by default but architecture code can turn
> > > > > > on it by implementing kvm_arch_private_memory_supported().
> > > > > > 
> > > > > > Also private memslot cannot be movable and the same file+offset can not
> > > > > > be mapped into different GFNs.
> > > > > > 
> > > > > > Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> > > > > > Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> > > > > > ---
> > > > > (..)
> > > > > >     static bool kvm_check_memslot_overlap(struct kvm_memslots *slots, int id,
> > > > > > -				      gfn_t start, gfn_t end)
> > > > > > +				      struct file *file,
> > > > > > +				      gfn_t start, gfn_t end,
> > > > > > +				      loff_t start_off, loff_t end_off)
> > > > > >     {
> > > > > >     	struct kvm_memslot_iter iter;
> > > > > > +	struct kvm_memory_slot *slot;
> > > > > > +	struct inode *inode;
> > > > > > +	int bkt;
> > > > > >     	kvm_for_each_memslot_in_gfn_range(&iter, slots, start, end) {
> > > > > >     		if (iter.slot->id != id)
> > > > > >     			return true;
> > > > > >     	}
> > > > > > +	/* Disallow mapping the same file+offset into multiple gfns. */
> > > > > > +	if (file) {
> > > > > > +		inode = file_inode(file);
> > > > > > +		kvm_for_each_memslot(slot, bkt, slots) {
> > > > > > +			if (slot->private_file &&
> > > > > > +			     file_inode(slot->private_file) == inode &&
> > > > > > +			     !(end_off <= slot->private_offset ||
> > > > > > +			       start_off >= slot->private_offset
> > > > > > +					     + (slot->npages >> PAGE_SHIFT)))
> > > > > > +				return true;
> > > > > > +		}
> > > > > > +	}
> > > > > 
> > > > > That's a linear scan of all memslots on each CREATE (and MOVE) operation
> > > > > with a fd - we just spent more than a year rewriting similar linear scans
> > > > > into more efficient operations in KVM.
> > > > 
> (..)
> > > > So linear scan is used before I can find a better way.
> > > 
> > > Another option would be to simply not check for overlap at add or move
> > > time, declare such configuration undefined behavior under KVM API and
> > > make sure in MMU notifiers that nothing bad happens to the host kernel
> > > if it turns out somebody actually set up a VM this way (it could be
> > > inefficient in this case, since it's not supposed to ever happen
> > > unless there is a bug somewhere in the userspace part).
> > 
> > Specific to TDX case, SEAMMODULE will fail the overlapping case and then
> > KVM prints a message to the kernel log. It will not cause any other side
> > effect, it does look weird however. Yes warn that in the API document
> > can help to some extent.
> 
> So for the functionality you are adding this code for (TDX) this scan
> isn't necessary and the overlapping case (not supported anyway) is safely
> handled by the hardware (or firmware)?

Yes, it will be handled by the firmware.

> Then I would simply remove the scan and, maybe, add a comment instead
> that the overlap check is done by the hardware.

Sure.

> 
> By the way, if a kernel log message could be triggered by (misbehaving)
> userspace then it should be rate limited (if it isn't already).

Thanks for mention.

Chao
> 
> > Thanks,
> > Chao
> 
> Thanks,
> Maciej
