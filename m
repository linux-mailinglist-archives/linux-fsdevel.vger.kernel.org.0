Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899094BA1D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Feb 2022 14:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241307AbiBQNqd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Feb 2022 08:46:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237030AbiBQNqc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:46:32 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A249F2AF91B;
        Thu, 17 Feb 2022 05:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645105577; x=1676641577;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=8+xFg8pu7fX7w5OrNIMbop+pkXQzV4mq0rLcHHtAokE=;
  b=KyH2syqz/8lV+/aUSKd7shF5ekhfitmw6ENLWNQrOyiDT2NuEk2DQe9V
   5E+sjQ8CYA2kI+oTqW30Xb1K7+DBrbCizknYoGt/Ms7RISsbQW1/aiDs6
   sp776BTtxRQbOyZBSzX8RgPVyRDLLtmwqLoTA6IaQJn8IfJa5GDDLfv4t
   jFhVZZ1xmS/an0HIQ7JRltdZp66jdMBQY0mmUec0z/6M4Qab0MR1CikZG
   Vpn3z32PQ8YvoE5R4WbZPF7SAA1+v4jZOB/lrs+wyTaXhrNFSg+GCDJCJ
   KLcmZluts0SN43bk5ZndqHMTsDzUPUhQ8MG61k06tV/PISLtG82+lpzfm
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="249710570"
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="249710570"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 05:46:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="503513631"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by orsmga002.jf.intel.com with ESMTP; 17 Feb 2022 05:46:10 -0800
Date:   Thu, 17 Feb 2022 21:45:48 +0800
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
Message-ID: <20220217134548.GA33836@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220118132121.31388-1-chao.p.peng@linux.intel.com>
 <20220118132121.31388-13-chao.p.peng@linux.intel.com>
 <a121e766-900d-2135-1516-e1d3ba716834@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a121e766-900d-2135-1516-e1d3ba716834@maciej.szmigiero.name>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 25, 2022 at 09:20:39PM +0100, Maciej S. Szmigiero wrote:
> On 18.01.2022 14:21, Chao Peng wrote:
> > KVM_MEM_PRIVATE is not exposed by default but architecture code can turn
> > on it by implementing kvm_arch_private_memory_supported().
> > 
> > Also private memslot cannot be movable and the same file+offset can not
> > be mapped into different GFNs.
> > 
> > Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> > Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> > ---
> (..)
> >   static bool kvm_check_memslot_overlap(struct kvm_memslots *slots, int id,
> > -				      gfn_t start, gfn_t end)
> > +				      struct file *file,
> > +				      gfn_t start, gfn_t end,
> > +				      loff_t start_off, loff_t end_off)
> >   {
> >   	struct kvm_memslot_iter iter;
> > +	struct kvm_memory_slot *slot;
> > +	struct inode *inode;
> > +	int bkt;
> >   	kvm_for_each_memslot_in_gfn_range(&iter, slots, start, end) {
> >   		if (iter.slot->id != id)
> >   			return true;
> >   	}
> > +	/* Disallow mapping the same file+offset into multiple gfns. */
> > +	if (file) {
> > +		inode = file_inode(file);
> > +		kvm_for_each_memslot(slot, bkt, slots) {
> > +			if (slot->private_file &&
> > +			     file_inode(slot->private_file) == inode &&
> > +			     !(end_off <= slot->private_offset ||
> > +			       start_off >= slot->private_offset
> > +					     + (slot->npages >> PAGE_SHIFT)))
> > +				return true;
> > +		}
> > +	}
> 
> That's a linear scan of all memslots on each CREATE (and MOVE) operation
> with a fd - we just spent more than a year rewriting similar linear scans
> into more efficient operations in KVM.

In the last version I tried to solve this problem by using interval tree
(just like existing hva_tree), but finally we realized that in one VM we
can have multiple fds with overlapped offsets so that approach is
incorrect. See https://lkml.org/lkml/2021/12/28/480 for the discussion.

So linear scan is used before I can find a better way.

Chao
