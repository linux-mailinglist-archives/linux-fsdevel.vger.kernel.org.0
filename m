Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBFC47EB17
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Dec 2021 05:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351250AbhLXEOi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 23:14:38 -0500
Received: from mga14.intel.com ([192.55.52.115]:27452 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235118AbhLXEOg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 23:14:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640319276; x=1671855276;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=/49miauxNDl94xdxNi7g5SLdNpWpXmBxfwYVTy6gkAk=;
  b=Uc8aVQYvYlnaZ1oA3tYiIBqqylVisX+Gq3d+vPrgRg2vSpxtt8aVPw+b
   6ab0wOpM4t31gDlkczzxpm+57t6ou7I9qi/K4339+cyKXawm5DIhBzFmp
   GdbZv+gWqErWxLYiv9yIK8pncNBUaQ5t3/0roYa62x4gIihBsIKZYHUz3
   YojrfjDJJ2jrUQRrXq+7XDiEBIeHY9qQ8Il2xFTgHfd9qEaFQ79HPwqNz
   abuOmRaiUly87/zG2cGaFKsb/+XWWstM+XP3hXUDLgF52Js8UpkhIDVwn
   mwph7VSqel9h6rNTpKqpqKSShGlp0wlkwaJH+1jndXIrA55i9kv3VTARu
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10207"; a="241148365"
X-IronPort-AV: E=Sophos;i="5.88,231,1635231600"; 
   d="scan'208";a="241148365"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 20:14:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,231,1635231600"; 
   d="scan'208";a="664765610"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by fmsmga001.fm.intel.com with ESMTP; 23 Dec 2021 20:14:29 -0800
Date:   Fri, 24 Dec 2021 12:13:51 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
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
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, john.ji@intel.com, susie.li@intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com
Subject: Re: [PATCH v3 kvm/queue 11/16] KVM: Add kvm_map_gfn_range
Message-ID: <20211224041351.GB44042@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20211223123011.41044-1-chao.p.peng@linux.intel.com>
 <20211223123011.41044-12-chao.p.peng@linux.intel.com>
 <YcS6m9CieYaIGA3F@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcS6m9CieYaIGA3F@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 23, 2021 at 06:06:19PM +0000, Sean Christopherson wrote:
> On Thu, Dec 23, 2021, Chao Peng wrote:
> > This new function establishes the mapping in KVM page tables for a
> > given gfn range. It can be used in the memory fallocate callback for
> > memfd based memory to establish the mapping for KVM secondary MMU when
> > the pages are allocated in the memory backend.
> 
> NAK, under no circumstance should KVM install SPTEs in response to allocating
> memory in a file.   The correct thing to do is to invalidate the gfn range
> associated with the newly mapped range, i.e. wipe out any shared SPTEs associated
> with the memslot.

Right, thanks.
