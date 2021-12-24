Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69CC847EB62
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Dec 2021 05:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241221AbhLXE0k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 23:26:40 -0500
Received: from mga02.intel.com ([134.134.136.20]:40249 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229752AbhLXE0j (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 23:26:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640319999; x=1671855999;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=XVICpTcj5dklnFFnMTQIYshv6lyZmXqWiuOZMigDHD4=;
  b=XrCFEYcODreSC2ByYZGGZU5TaNJn+a3POjvTrQrMIBxMyaCJpPYYYZNy
   F0tcMsTI1w+AiT1lLuzoQcdnWalZ4GEySKYmWOh0tHWBdVDsti3xWVjWf
   9vWawJfpNTOI9L2ze0Uykn/C/HHZma5etjwMEOCFfGRFtfSc0sX6paLeb
   pdIHt6+2eyEAJWsTChbN5CPJ7qqwPKL0Za9olyL40YWmA0AEz4ptQM/Zv
   G34jL2nDoHyRtU+UZK7sEFT/NcNuP9TWnGKGXv/hKRymZUyHpdl26ziDZ
   RPaDlsOh4BMyjKE/gZ+pfTS6KfPTIl3CxoaRJI2LEFzn1BjpsWJS6qEvm
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10207"; a="228226524"
X-IronPort-AV: E=Sophos;i="5.88,231,1635231600"; 
   d="scan'208";a="228226524"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 20:26:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,231,1635231600"; 
   d="scan'208";a="664767253"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by fmsmga001.fm.intel.com with ESMTP; 23 Dec 2021 20:26:31 -0800
Date:   Fri, 24 Dec 2021 12:25:54 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, qemu-devel@nongnu.org,
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
Message-ID: <20211224042554.GD44042@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20211223123011.41044-1-chao.p.peng@linux.intel.com>
 <20211223123011.41044-7-chao.p.peng@linux.intel.com>
 <YcTBLpVlETdI8JHi@google.com>
 <e3fe04eb-1a01-bea4-f1ea-cb9ee98ee216@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3fe04eb-1a01-bea4-f1ea-cb9ee98ee216@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 24, 2021 at 12:09:47AM +0100, Paolo Bonzini wrote:
> On 12/23/21 19:34, Sean Christopherson wrote:
> > >   	select HAVE_KVM_PM_NOTIFIER if PM
> > > +	select MEMFD_OPS
> > MEMFD_OPS is a weird Kconfig name given that it's not just memfd() that can
> > implement the ops.
> > 
> 
> Or, it's kvm that implements them to talk to memfd?

The only thing is VFIO may also use the same set of callbacks, as
discussed in the v2. But I think that's fine.

Chao
> 
> Paolo
