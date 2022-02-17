Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9E04BA0B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Feb 2022 14:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240714AbiBQNLU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Feb 2022 08:11:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbiBQNLT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:11:19 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EBA2AE285;
        Thu, 17 Feb 2022 05:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645103465; x=1676639465;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=3j1F15BrCbKN2Xpg8Gu2Cb+UfX7fWFXHLd+x9nlgm/s=;
  b=B4TkHEmt5MSPJ9UQlPQXluKIH+UFiTk4m0rIdL97p2J6nuLfZvS56Nmb
   hdjxUa7riYQJUN+PMZyFpGNTrbHsMecQ6ibTEnPpDVvhqxcyh5uMTXHew
   f7c/5nxA/tw8mO+n2e2VAAu/wi3ExIXP5kSHDK4ACJiF6o9aW4qxZjPOv
   kFId2eP8ZfSdZ9yJg4iB9FRtWD0DS8DyMABtoPrRTtZlXUZESnvOnsyPj
   CJuOi4twDnwGOJ4uYyu3KIzi4ej1Qev3b0BYnXuhtu32NTlucr2cnXj8v
   VyKy/U6porYWldpuFxumskQ6Uam2+o6LbY1coH4FWyL2D+5BwZoCpArbJ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="248465322"
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="248465322"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 05:11:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="704791747"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by orsmga005.jf.intel.com with ESMTP; 17 Feb 2022 05:10:57 -0800
Date:   Thu, 17 Feb 2022 21:10:36 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Mike Rapoport <rppt@kernel.org>
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
Subject: Re: [PATCH v4 04/12] mm/shmem: Support memfile_notifier
Message-ID: <20220217131036.GC32679@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220118132121.31388-1-chao.p.peng@linux.intel.com>
 <20220118132121.31388-5-chao.p.peng@linux.intel.com>
 <YgK2pDB34AsqCHd0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgK2pDB34AsqCHd0@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 08, 2022 at 08:29:56PM +0200, Mike Rapoport wrote:
> Hi,
> 
> On Tue, Jan 18, 2022 at 09:21:13PM +0800, Chao Peng wrote:
> > It maintains a memfile_notifier list in shmem_inode_info structure and
> > implements memfile_pfn_ops callbacks defined by memfile_notifier. It
> > then exposes them to memfile_notifier via
> > shmem_get_memfile_notifier_info.
> > 
> > We use SGP_NOALLOC in shmem_get_lock_pfn since the pages should be
> > allocated by userspace for private memory. If there is no pages
> > allocated at the offset then error should be returned so KVM knows that
> > the memory is not private memory.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> > ---
> >  include/linux/shmem_fs.h |  4 ++
> >  mm/memfile_notifier.c    | 12 +++++-
> >  mm/shmem.c               | 81 ++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 96 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> > index 166158b6e917..461633587eaf 100644
> > --- a/include/linux/shmem_fs.h
> > +++ b/include/linux/shmem_fs.h
> > @@ -9,6 +9,7 @@
> >  #include <linux/percpu_counter.h>
> >  #include <linux/xattr.h>
> >  #include <linux/fs_parser.h>
> > +#include <linux/memfile_notifier.h>
> >  
> >  /* inode in-kernel data */
> >  
> > @@ -24,6 +25,9 @@ struct shmem_inode_info {
> >  	struct shared_policy	policy;		/* NUMA memory alloc policy */
> >  	struct simple_xattrs	xattrs;		/* list of xattrs */
> >  	atomic_t		stop_eviction;	/* hold when working on inode */
> > +#ifdef CONFIG_MEMFILE_NOTIFIER
> > +	struct memfile_notifier_list memfile_notifiers;
> > +#endif
> >  	struct inode		vfs_inode;
> >  };
> >  
> > diff --git a/mm/memfile_notifier.c b/mm/memfile_notifier.c
> > index 8171d4601a04..b4699cbf629e 100644
> > --- a/mm/memfile_notifier.c
> > +++ b/mm/memfile_notifier.c
> > @@ -41,11 +41,21 @@ void memfile_notifier_fallocate(struct memfile_notifier_list *list,
> >  	srcu_read_unlock(&srcu, id);
> >  }
> >  
> > +#ifdef CONFIG_SHMEM
> > +extern int shmem_get_memfile_notifier_info(struct inode *inode,
> > +					struct memfile_notifier_list **list,
> > +					struct memfile_pfn_ops **ops);
> > +#endif
> > +
> >  static int memfile_get_notifier_info(struct inode *inode,
> >  				     struct memfile_notifier_list **list,
> >  				     struct memfile_pfn_ops **ops)
> >  {
> > -	return -EOPNOTSUPP;
> > +	int ret = -EOPNOTSUPP;
> > +#ifdef CONFIG_SHMEM
> > +	ret = shmem_get_memfile_notifier_info(inode, list, ops);
> > +#endif
> 
> This looks backwards. Can we have some register method for memory backing
> store and call it from shmem.c?

Agreed. That would be clearer.

Chao
> 
> > +	return ret;
> >  }
> >  
> >  int memfile_register_notifier(struct inode *inode,
> 
> -- 
> Sincerely yours,
> Mike.
