Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED26645A5B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 15:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238191AbhKWOee (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 09:34:34 -0500
Received: from mga01.intel.com ([192.55.52.88]:5996 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234867AbhKWOee (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 09:34:34 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="258899965"
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="258899965"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 06:31:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="509429128"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 23 Nov 2021 06:31:17 -0800
Date:   Tue, 23 Nov 2021 22:30:31 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        qemu-devel@nongnu.org, Jonathan Corbet <corbet@lwn.net>,
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
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, john.ji@intel.com, susie.li@intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com
Subject: Re: [RFC v2 PATCH 04/13] KVM: Add fd-based memslot data structure
 and utils
Message-ID: <20211123143031.GC32088@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20211119134739.20218-1-chao.p.peng@linux.intel.com>
 <20211119134739.20218-5-chao.p.peng@linux.intel.com>
 <d54d58a4-3cd0-5fa3-3a81-b4bb27a7f511@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d54d58a4-3cd0-5fa3-3a81-b4bb27a7f511@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 23, 2021 at 09:41:34AM +0100, Paolo Bonzini wrote:
> On 11/19/21 14:47, Chao Peng wrote:
> > For fd-based memslot store the file references for shared fd and the
> > private fd (if any) in the memslot structure. Since there is no 'hva'
> > concept we cannot call hva_to_pfn() to get a pfn, instead kvm_memfd_ops
> > is added to get_pfn/put_pfn from the memory backing stores that provide
> > these fds.
> > 
> > Signed-off-by: Yu Zhang<yu.c.zhang@linux.intel.com>
> > Signed-off-by: Chao Peng<chao.p.peng@linux.intel.com>
> > ---
> 
> What about kvm_read/write_guest? 

Hmm, that would be another area KVM needs to change. Not totally
undoable.

> Maybe the proposal which kept
> userspace_addr for the shared fd is more doable (it would be great to
> ultimately remove the mandatory userspace mapping for the shared fd, but I
> think KVM is not quite ready for that).

Agree for short term keeping shared part unchanged would be making work
easy:) Let me try that to see if any blocker.

> 
> Paolo
