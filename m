Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE244D5DA5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 09:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238437AbiCKInl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 03:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238414AbiCKInk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 03:43:40 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3B73B3F4;
        Fri, 11 Mar 2022 00:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646988157; x=1678524157;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=rnnCy0Hbi4uhBKWJV93SLPhz7c/vwnMymNdqjK9CGiI=;
  b=TSElsKllxlM6Vbk/Yu5miqQ82L2dxUe/dDgksMB0D2EdOXf8XYk2WkEj
   myfQNcCnR6zYAGT12LUIKb8v3YV9o/90cR3BDbuXEH+LX9DqDeVD32A1M
   8rNxfacfmDOdjrJiizTANRs3sG23rLUpT9TSd9jxsx1ZO2+pX2Kxy+Cq8
   nNPz0jbwJzTVG/OayqiycDDw3+vZOaAntqGF4w+S4wRM1YExYLl09AMQ6
   vkqLelSenko/TAyf/FG1Ngp00gfmzfLgYgD4beHN9Op/lpMch9ZLhABxN
   u1g/19eSh9AuGotby4eBXtAboRcwbyLK/1dgRkKnzlZJtpeEgILjBNmVD
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="341958572"
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="341958572"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 00:42:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="538926645"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by orsmga007.jf.intel.com with ESMTP; 11 Mar 2022 00:42:24 -0800
Date:   Fri, 11 Mar 2022 16:42:08 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, qemu-devel@nongnu.org,
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
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com
Subject: Re: [PATCH v5 03/13] mm/shmem: Support memfile_notifier
Message-ID: <20220311084208.GB56193@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <20220310140911.50924-4-chao.p.peng@linux.intel.com>
 <20220310230822.GO661808@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310230822.GO661808@dread.disaster.area>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 11, 2022 at 10:08:22AM +1100, Dave Chinner wrote:
> On Thu, Mar 10, 2022 at 10:09:01PM +0800, Chao Peng wrote:
> > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > 
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
> >  include/linux/shmem_fs.h |  4 +++
> >  mm/shmem.c               | 76 ++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 80 insertions(+)
> > 
> > diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> > index 2dde843f28ef..7bb16f2d2825 100644
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
> > @@ -28,6 +29,9 @@ struct shmem_inode_info {
> >  	struct simple_xattrs	xattrs;		/* list of xattrs */
> >  	atomic_t		stop_eviction;	/* hold when working on inode */
> >  	unsigned int		xflags;		/* shmem extended flags */
> > +#ifdef CONFIG_MEMFILE_NOTIFIER
> > +	struct memfile_notifier_list memfile_notifiers;
> > +#endif
> >  	struct inode		vfs_inode;
> >  };
> >  
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 9b31a7056009..7b43e274c9a2 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -903,6 +903,28 @@ static struct folio *shmem_get_partial_folio(struct inode *inode, pgoff_t index)
> >  	return page ? page_folio(page) : NULL;
> >  }
> >  
> > +static void notify_fallocate(struct inode *inode, pgoff_t start, pgoff_t end)
> > +{
> > +#ifdef CONFIG_MEMFILE_NOTIFIER
> > +	struct shmem_inode_info *info = SHMEM_I(inode);
> > +
> > +	memfile_notifier_fallocate(&info->memfile_notifiers, start, end);
> > +#endif
> > +}
> 
> *notify_populate(), not fallocate.  This is a notification that a
> range has been populated, not that the fallocate() syscall was run
> to populate the backing store of a file.
> 
> i.e.  fallocate is the name of a userspace filesystem API that can
> be used to manipulate the backing store of a file in various ways.
> It can both populate and punch away the backing store of a file, and
> some operations that fallocate() can run will do both (e.g.
> FALLOC_FL_ZERO_RANGE) and so could generate both
> notify_invalidate() and a notify_populate() events.

Yes, I fully agreed fallocate syscall has both populating and hole
punching semantics so notify_fallocate can be misleading since we
actually mean populate here.

> 
> Hence "fallocate" as an internal mm namespace or operation does not
> belong anywhere in core MM infrastructure - it should never get used
> anywhere other than the VFS/filesystem layers that implement the
> fallocate() syscall or use it directly.

Will use your suggestion through the series where applied. Thanks for
your suggestion.

Chao
> 
> Cheers,
> 
> Dave.
> 
> -- 
> Dave Chinner
> david@fromorbit.com
