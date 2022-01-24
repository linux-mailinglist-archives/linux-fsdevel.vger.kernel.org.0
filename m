Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD22498108
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jan 2022 14:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243148AbiAXNaT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jan 2022 08:30:19 -0500
Received: from mga07.intel.com ([134.134.136.100]:10513 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239975AbiAXNaS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jan 2022 08:30:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643031018; x=1674567018;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=s3MS9jlacq/GjKUc1J7BgRzARDrYpUsH/uofSxi2lpg=;
  b=KLRPcaAbDHrNZpMyBof98siiy0gAuPPtlI4CKpGuBwNxzRetDKWphdC2
   M1oo/sIUZg4nrBGVO7nf9hlVbZSIAk28FR33u2qrrLP8crYqrxVoqC1Ve
   cmSg8ewfLxDCphmv31A8o4+OaeeCPJMYavnkHXm3z2TtHIiLW5PkXs9Z5
   v7X0BUG/w3HXdktUQLGkGqIqKHVxb2InaeKZh+1njd7FhTt6wRy/BI88k
   W4hfEndP3MtbUrRgJ698e30lU51j0NlhN71QgYKyLSWHo8nzZT3ZksVNr
   Oh95EDet0nyKSanTgNQsC+shQhzmHA0UFcS5Sx7sUpfC/zB+Iyx2PqSPz
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="309362579"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="309362579"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 05:30:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="532077916"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by fmsmga007.fm.intel.com with ESMTP; 24 Jan 2022 05:30:05 -0800
Date:   Mon, 24 Jan 2022 21:29:36 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Steven Price <steven.price@arm.com>
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
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com
Subject: Re: [PATCH v4 02/12] mm/memfd: Introduce MFD_INACCESSIBLE flag
Message-ID: <20220124132936.GA55051@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220118132121.31388-1-chao.p.peng@linux.intel.com>
 <20220118132121.31388-3-chao.p.peng@linux.intel.com>
 <8f1eba03-e5e9-e9fc-084d-0ef683093d65@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f1eba03-e5e9-e9fc-084d-0ef683093d65@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 21, 2022 at 03:50:55PM +0000, Steven Price wrote:
> On 18/01/2022 13:21, Chao Peng wrote:
> > Introduce a new memfd_create() flag indicating the content of the
> > created memfd is inaccessible from userspace. It does this by force
> > setting F_SEAL_INACCESSIBLE seal when the file is created. It also set
> > F_SEAL_SEAL to prevent future sealing, which means, it can not coexist
> > with MFD_ALLOW_SEALING.
> > 
> > The pages backed by such memfd will be used as guest private memory in
> > confidential computing environments such as Intel TDX/AMD SEV. Since
> > page migration/swapping is not yet supported for such usages so these
> > pages are currently marked as UNMOVABLE and UNEVICTABLE which makes
> > them behave like long-term pinned pages.
> > 
> > Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> > ---
> >  include/uapi/linux/memfd.h |  1 +
> >  mm/memfd.c                 | 20 +++++++++++++++++++-
> >  2 files changed, 20 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/uapi/linux/memfd.h b/include/uapi/linux/memfd.h
> > index 7a8a26751c23..48750474b904 100644
> > --- a/include/uapi/linux/memfd.h
> > +++ b/include/uapi/linux/memfd.h
> > @@ -8,6 +8,7 @@
> >  #define MFD_CLOEXEC		0x0001U
> >  #define MFD_ALLOW_SEALING	0x0002U
> >  #define MFD_HUGETLB		0x0004U
> > +#define MFD_INACCESSIBLE	0x0008U
> >  
> >  /*
> >   * Huge page size encoding when MFD_HUGETLB is specified, and a huge page
> > diff --git a/mm/memfd.c b/mm/memfd.c
> > index 9f80f162791a..26998d96dc11 100644
> > --- a/mm/memfd.c
> > +++ b/mm/memfd.c
> > @@ -245,16 +245,19 @@ long memfd_fcntl(struct file *file, unsigned int cmd, unsigned long arg)
> >  #define MFD_NAME_PREFIX_LEN (sizeof(MFD_NAME_PREFIX) - 1)
> >  #define MFD_NAME_MAX_LEN (NAME_MAX - MFD_NAME_PREFIX_LEN)
> >  
> > -#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB)
> > +#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB | \
> > +		       MFD_INACCESSIBLE)
> >  
> >  SYSCALL_DEFINE2(memfd_create,
> >  		const char __user *, uname,
> >  		unsigned int, flags)
> >  {
> > +	struct address_space *mapping;
> >  	unsigned int *file_seals;
> >  	struct file *file;
> >  	int fd, error;
> >  	char *name;
> > +	gfp_t gfp;
> >  	long len;
> >  
> >  	if (!(flags & MFD_HUGETLB)) {
> > @@ -267,6 +270,10 @@ SYSCALL_DEFINE2(memfd_create,
> >  			return -EINVAL;
> >  	}
> >  
> > +	/* Disallow sealing when MFD_INACCESSIBLE is set. */
> > +	if (flags & MFD_INACCESSIBLE && flags & MFD_ALLOW_SEALING)
> > +		return -EINVAL;
> > +
> >  	/* length includes terminating zero */
> >  	len = strnlen_user(uname, MFD_NAME_MAX_LEN + 1);
> >  	if (len <= 0)
> > @@ -315,6 +322,17 @@ SYSCALL_DEFINE2(memfd_create,
> >  		*file_seals &= ~F_SEAL_SEAL;
> >  	}
> >  
> > +	if (flags & MFD_INACCESSIBLE) {
> > +		mapping = file_inode(file)->i_mapping;
> > +		gfp = mapping_gfp_mask(mapping);
> > +		gfp &= ~__GFP_MOVABLE;
> > +		mapping_set_gfp_mask(mapping, gfp);
> > +		mapping_set_unevictable(mapping);
> > +
> > +		file_seals = memfd_file_seals_ptr(file);
> > +		*file_seals &= F_SEAL_SEAL | F_SEAL_INACCESSIBLE;
> 
> This looks backwards - the flags should be set on *file_seals, but here
> you are unsetting all other flags.

Thanks Steve. '|=' actually should be used here.

Chao
> 
> Steve
> 
> > +	}
> > +
> >  	fd_install(fd, file);
> >  	kfree(name);
> >  	return fd;
> > 
