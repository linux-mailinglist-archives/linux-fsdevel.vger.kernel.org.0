Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139635AAC7C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Sep 2022 12:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235861AbiIBKc6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Sep 2022 06:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235841AbiIBKcu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Sep 2022 06:32:50 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAF1B0292;
        Fri,  2 Sep 2022 03:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662114770; x=1693650770;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=Ws38xTyai1UArcptdFTCO63DRGm+K11UNHn/R44NQ2A=;
  b=Mb/5VAfA17yHlt35Ao2Hl/TpXeVFkd3x+CULkkBnLJPuHRW2iPXaCxsi
   mN/6BInmSKgsBEOz3veXRo7SzXTljMuFuuSpMuM0B6Q7KDJIXhc9yBT+0
   xFhL1/LtWLTIlRwe0fPfrc6eOD2/ZB0V1IAB3CYHLOmFogOXNdWWgMaWh
   r4/jx2GM5q+oD6SWo43ztbUngcDGYo4zatmjx2sqiBVqLR3ZxMkDzGcL8
   yJc71Tu+A3zbMjUvhKRH+5pPec3nGAOAaffKFu2Y2nsl0T70SxnGIunQ+
   Npw1jHYBTwsGAt7tJ9C8evXPgAsEqOI2BHugwGjvvoGBdZvnS+yIBEgtI
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="278969000"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="278969000"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 03:32:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="608945519"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by orsmga007.jf.intel.com with ESMTP; 02 Sep 2022 03:32:39 -0700
Date:   Fri, 2 Sep 2022 18:27:57 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>, luto@kernel.org,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>,
        "Gupta, Pankaj" <pankaj.gupta@amd.com>,
        Elena Reshetova <elena.reshetova@intel.com>
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Message-ID: <20220902102757.GB1712673@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <ff5c5b97-acdf-9745-ebe5-c6609dd6322e@google.com>
 <20220818132421.6xmjqduempmxnnu2@box>
 <c6ccbb96-5849-2e2f-3b49-4ea711af525d@google.com>
 <20220820002700.6yflrxklmpsavdzi@box.shutemov.name>
 <c194262b-b634-4baf-abf0-dc727e8f1d7@google.com>
 <20220831142439.65q2gi4g2d2z4ofh@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831142439.65q2gi4g2d2z4ofh@box.shutemov.name>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 31, 2022 at 05:24:39PM +0300, Kirill A . Shutemov wrote:
> On Sat, Aug 20, 2022 at 10:15:32PM -0700, Hugh Dickins wrote:
> > > I will try next week to rework it as shim to top of shmem. Does it work
> > > for you?
> > 
> > Yes, please do, thanks.  It's a compromise between us: the initial TDX
> > case has no justification to use shmem at all, but doing it that way
> > will help you with some of the infrastructure, and will probably be
> > easiest for KVM to extend to other more relaxed fd cases later.
> 
> Okay, below is my take on the shim approach.
> 
> I don't hate how it turned out. It is easier to understand without
> callback exchange thing.
> 
> The only caveat is I had to introduce external lock to protect against
> race between lookup and truncate. Otherwise, looks pretty reasonable to me.
> 
> I did very limited testing. And it lacks integration with KVM, but API
> changed not substantially, any it should be easy to adopt.

I have integrated this patch with other KVM patches and verified the
functionality works well in TDX environment with a minor fix below.

> 
> Any comments?
> 

...

> diff --git a/mm/memfd.c b/mm/memfd.c
> index 08f5f8304746..1853a90f49ff 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -261,7 +261,8 @@ long memfd_fcntl(struct file *file, unsigned int cmd, unsigned long arg)
>  #define MFD_NAME_PREFIX_LEN (sizeof(MFD_NAME_PREFIX) - 1)
>  #define MFD_NAME_MAX_LEN (NAME_MAX - MFD_NAME_PREFIX_LEN)
>  
> -#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB)
> +#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB | \
> +		       MFD_INACCESSIBLE)
>  
>  SYSCALL_DEFINE2(memfd_create,
>  		const char __user *, uname,
> @@ -283,6 +284,14 @@ SYSCALL_DEFINE2(memfd_create,
>  			return -EINVAL;
>  	}
>  
> +	/* Disallow sealing when MFD_INACCESSIBLE is set. */
> +	if ((flags & MFD_INACCESSIBLE) && (flags & MFD_ALLOW_SEALING))
> +		return -EINVAL;
> +
> +	/* TODO: add hugetlb support */
> +	if ((flags & MFD_INACCESSIBLE) && (flags & MFD_HUGETLB))
> +		return -EINVAL;
> +
>  	/* length includes terminating zero */
>  	len = strnlen_user(uname, MFD_NAME_MAX_LEN + 1);
>  	if (len <= 0)
> @@ -331,10 +340,24 @@ SYSCALL_DEFINE2(memfd_create,
>  		*file_seals &= ~F_SEAL_SEAL;
>  	}
>  
> +	if (flags & MFD_INACCESSIBLE) {
> +		struct file *inaccessible_file;
> +
> +		inaccessible_file = memfd_mkinaccessible(file);
> +		if (IS_ERR(inaccessible_file)) {
> +			error = PTR_ERR(inaccessible_file);
> +			goto err_file;
> +		}

The new file should alse be marked as O_LARGEFILE otherwise setting the
initial size greater than 2^31 on the fd will be refused by ftruncate().

+               inaccessible_file->f_flags |= O_LARGEFILE;
+

> +
> +		file = inaccessible_file;
> +	}
> +
>  	fd_install(fd, file);
>  	kfree(name);
>  	return fd;
>  
> +err_file:
> +	fput(file);
>  err_fd:
>  	put_unused_fd(fd);
>  err_name:
