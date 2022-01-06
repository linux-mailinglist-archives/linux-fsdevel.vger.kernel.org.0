Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 518FE4864EA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jan 2022 14:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239083AbiAFNH2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jan 2022 08:07:28 -0500
Received: from mga02.intel.com ([134.134.136.20]:52817 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238990AbiAFNH1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jan 2022 08:07:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641474447; x=1673010447;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=znSuPJrdIfXZBPs+/0Wp7F8ajuSAzZTJWGMLAVEn470=;
  b=J7UQ3iBlX/ns0+EBmP4pNHhPYCJLE93lhvX/1yFvND8RSL+b9V2gpA71
   PX8Lup/pq8aQzdTO5EqmZOOAK90upvhyGPcgxCjJxg7icL6IVCBbT5qQY
   rbF/DVURDTVaozqT6vhFfRAOgoBapRCWevuKTQZ2F4V5oxEiCz3qofm8d
   9YYdam3B2TSW6LzYXQ45CJmE4ndsUdqV/pfiKtvw0BwYuY1EHhvhTlkqu
   v9p2QB4G0SOqEaz0W9ugzvvILCvjozjopjBQfzLSZfBG751v+NAKBMsqF
   XkdlHURoXqy1NPSZQWN/sLhkznkAmL0hRrRakDzcxxukhaMUAF14Al5cG
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="229980549"
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="229980549"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 05:07:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="526972284"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 06 Jan 2022 05:07:19 -0800
Date:   Thu, 6 Jan 2022 21:06:38 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com
Subject: Re: [PATCH v3 kvm/queue 01/16] mm/shmem: Introduce
 F_SEAL_INACCESSIBLE
Message-ID: <20220106130638.GB43371@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20211223123011.41044-1-chao.p.peng@linux.intel.com>
 <20211223123011.41044-2-chao.p.peng@linux.intel.com>
 <7eb40902-45dd-9193-37f1-efaca381529b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7eb40902-45dd-9193-37f1-efaca381529b@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 04, 2022 at 03:22:07PM +0100, David Hildenbrand wrote:
> On 23.12.21 13:29, Chao Peng wrote:
> > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > 
> > Introduce a new seal F_SEAL_INACCESSIBLE indicating the content of
> > the file is inaccessible from userspace in any possible ways like
> > read(),write() or mmap() etc.
> > 
> > It provides semantics required for KVM guest private memory support
> > that a file descriptor with this seal set is going to be used as the
> > source of guest memory in confidential computing environments such
> > as Intel TDX/AMD SEV but may not be accessible from host userspace.
> > 
> > At this time only shmem implements this seal.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> > ---
> >  include/uapi/linux/fcntl.h |  1 +
> >  mm/shmem.c                 | 37 +++++++++++++++++++++++++++++++++++--
> >  2 files changed, 36 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> > index 2f86b2ad6d7e..e2bad051936f 100644
> > --- a/include/uapi/linux/fcntl.h
> > +++ b/include/uapi/linux/fcntl.h
> > @@ -43,6 +43,7 @@
> >  #define F_SEAL_GROW	0x0004	/* prevent file from growing */
> >  #define F_SEAL_WRITE	0x0008	/* prevent writes */
> >  #define F_SEAL_FUTURE_WRITE	0x0010  /* prevent future writes while mapped */
> > +#define F_SEAL_INACCESSIBLE	0x0020  /* prevent file from accessing */
> 
> I think this needs more clarification: the file content can still be
> accessed using in-kernel mechanisms such as MEMFD_OPS for KVM. It
> effectively disallows traditional access to a file (read/write/mmap)
> that will result in ordinary MMU access to file content.
> 
> Not sure how to best clarify that: maybe, prevent ordinary MMU access
> (e.g., read/write/mmap) to file content?

Or: prevent userspace access (e.g., read/write/mmap) to file content?
> 
> >  /* (1U << 31) is reserved for signed error codes */
> >  
> >  /*
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 18f93c2d68f1..faa7e9b1b9bc 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -1098,6 +1098,10 @@ static int shmem_setattr(struct user_namespace *mnt_userns,
> >  		    (newsize > oldsize && (info->seals & F_SEAL_GROW)))
> >  			return -EPERM;
> >  
> > +		if ((info->seals & F_SEAL_INACCESSIBLE) &&
> > +		    (newsize & ~PAGE_MASK))
> > +			return -EINVAL;
> > +
> 
> What happens when sealing and there are existing mmaps?

I think this is similar to ftruncate, in either case we just allow that.
The existing mmaps will be unmapped and KVM will be notified to
invalidate the mapping in the secondary MMU as well. This assume we
trust the userspace even though it can not access the file content.

Thanks,
Chao
> 
> 
> -- 
> Thanks,
> 
> David / dhildenb
