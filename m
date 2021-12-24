Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF3947EB5B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Dec 2021 05:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241221AbhLXEXT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 23:23:19 -0500
Received: from mga14.intel.com ([192.55.52.115]:27867 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229752AbhLXEXS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 23:23:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640319798; x=1671855798;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=GdIKH/iBPvDupvqz2hjBtyd1i8tjlmODP8lZ1Dq9nAY=;
  b=DvrIOphqApNgHUBCH/Bg5aJHBDp1pBQLoSZPuBFEodhG/l0EGF1Zi8lp
   2jJ/czbL/BGL/SFLtRO4/SSz0/FtwkxqMg2a/M/YP0JWfhqXbP0M/GOng
   A10xvuK3uW0Cd3SN/nP79kuLb51AC6hV6y/qLq4cWAu1doEdKtYGAR/nC
   FXGwM1mqlDFEFMCWPoVvGkb5vEpH2U8OtFfz7pqlntXzwsdG9/xJQ8Olm
   tNAMXw3Rnulk1pazuLfKr4q2ka3buL/rgsI3Dx69Z6MEiHVB4iy08/xNf
   +jTL9X2MlflVLtXupSJTs3NvzxXchpu/LNU3w300BiTLi+02QjQJZzJYw
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10207"; a="241149080"
X-IronPort-AV: E=Sophos;i="5.88,231,1635231600"; 
   d="scan'208";a="241149080"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 20:23:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,231,1635231600"; 
   d="scan'208";a="664766834"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by fmsmga001.fm.intel.com with ESMTP; 23 Dec 2021 20:23:11 -0800
Date:   Fri, 24 Dec 2021 12:22:34 +0800
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
Subject: Re: [PATCH v3 kvm/queue 06/16] KVM: Implement fd-based memory using
 MEMFD_OPS interfaces
Message-ID: <20211224042234.GC44042@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20211223123011.41044-1-chao.p.peng@linux.intel.com>
 <20211223123011.41044-7-chao.p.peng@linux.intel.com>
 <YcTBLpVlETdI8JHi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcTBLpVlETdI8JHi@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 23, 2021 at 06:34:22PM +0000, Sean Christopherson wrote:
> On Thu, Dec 23, 2021, Chao Peng wrote:
> >  
> > -kvm-y := $(KVM)/kvm_main.o $(KVM)/eventfd.o $(KVM)/binary_stats.o
> > +kvm-y := $(KVM)/kvm_main.o $(KVM)/eventfd.o $(KVM)/binary_stats.o $(KVM)/memfd.o
> 
> This should be
> 
>    kvm-$(CONFIG_MEMFD_OPS) += $(KVM)/memfd.o
> 
> with stubs provided in a header file as needed.  I also really dislike naming KVM's
> file memfd.c, though I don't have a good alternative off the top of my head.

Is memory-backend.c better? if we end up introducing the callback
definition in KVM we can call it CONFIG_KVM_MEMORY_BACKEDN_OPS.

Chao
