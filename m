Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C614FE240
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Apr 2022 15:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355853AbiDLNWZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Apr 2022 09:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353308AbiDLNWR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:22:17 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A03197;
        Tue, 12 Apr 2022 06:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649769107; x=1681305107;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=1KeYAHX9pm/ikMj2hiQRjLWmiTvrzP7m01hIo3GA0o4=;
  b=KGHDBbMLXzD9MPjEkX4buLEjDU0DefdekSPdtciqBC5tPWYIkqGEkYfV
   w/YZX/Rr3jIofpjzOcnUQHpWxYQSq7nxpg99oHs0KSkogUOfTPaaSc0MC
   v/15udPsm8BVy4LfrKBEXuCTQiN4hsPTcAuz91atDTR5Al/TtpX6xlsYR
   kekgpISrPOPMt/udhH6vkTq6UAOC+ppyr9lauaTTzCrGiP+o7mtS7zk6O
   MFLySurcDSkkSfXOaHliXJXmPB8N2SlrPTWRhafkJ7ZjOVLmBky0um3Ha
   bTDVfQxOFHf/oHHiOQm+urrJGL9XU8ywR/XIkKTZO+EyzhcLvlFTeYmTU
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="325279839"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="325279839"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 06:11:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="699828702"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by fmsmga001.fm.intel.com with ESMTP; 12 Apr 2022 06:11:38 -0700
Date:   Tue, 12 Apr 2022 21:11:28 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
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
Subject: Re: [PATCH v5 01/13] mm/memfd: Introduce MFD_INACCESSIBLE flag
Message-ID: <20220412131128.GE8013@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <20220310140911.50924-2-chao.p.peng@linux.intel.com>
 <20220411151023.4nx34pxyg5amj44m@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411151023.4nx34pxyg5amj44m@box.shutemov.name>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 11, 2022 at 06:10:23PM +0300, Kirill A. Shutemov wrote:
> On Thu, Mar 10, 2022 at 10:08:59PM +0800, Chao Peng wrote:
> > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > 
> > Introduce a new memfd_create() flag indicating the content of the
> > created memfd is inaccessible from userspace through ordinary MMU
> > access (e.g., read/write/mmap). However, the file content can be
> > accessed via a different mechanism (e.g. KVM MMU) indirectly.
> > 
> > It provides semantics required for KVM guest private memory support
> > that a file descriptor with this flag set is going to be used as the
> > source of guest memory in confidential computing environments such
> > as Intel TDX/AMD SEV but may not be accessible from host userspace.
> > 
> > Since page migration/swapping is not yet supported for such usages
> > so these pages are currently marked as UNMOVABLE and UNEVICTABLE
> > which makes them behave like long-term pinned pages.
> > 
> > The flag can not coexist with MFD_ALLOW_SEALING, future sealing is
> > also impossible for a memfd created with this flag.
> > 
> > At this time only shmem implements this flag.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> > ---
> >  include/linux/shmem_fs.h   |  7 +++++
> >  include/uapi/linux/memfd.h |  1 +
> >  mm/memfd.c                 | 26 +++++++++++++++--
> >  mm/shmem.c                 | 57 ++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 88 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> > index e65b80ed09e7..2dde843f28ef 100644
> > --- a/include/linux/shmem_fs.h
> > +++ b/include/linux/shmem_fs.h
> > @@ -12,6 +12,9 @@
> >  
> >  /* inode in-kernel data */
> >  
> > +/* shmem extended flags */
> > +#define SHM_F_INACCESSIBLE	0x0001  /* prevent ordinary MMU access (e.g. read/write/mmap) to file content */
> > +
> >  struct shmem_inode_info {
> >  	spinlock_t		lock;
> >  	unsigned int		seals;		/* shmem seals */
> > @@ -24,6 +27,7 @@ struct shmem_inode_info {
> >  	struct shared_policy	policy;		/* NUMA memory alloc policy */
> >  	struct simple_xattrs	xattrs;		/* list of xattrs */
> >  	atomic_t		stop_eviction;	/* hold when working on inode */
> > +	unsigned int		xflags;		/* shmem extended flags */
> >  	struct inode		vfs_inode;
> >  };
> >  
> 
> AFAICS, only two bits of 'flags' are used. And that's very strange that
> VM_ flags are used for the purpose. My guess that someone was lazy to
> introduce new constants for this.
> 
> I think we should fix this: introduce SHM_F_LOCKED and SHM_F_NORESERVE
> alongside with SHM_F_INACCESSIBLE and stuff them all into info->flags.
> It also makes shmem_file_setup_xflags() go away.

Did a quick search and sounds we only use SHM_F_LOCKED/SHM_F_NORESERVE and
that definitely don't have to be VM_ flags.

Chao
> 
> -- 
>  Kirill A. Shutemov
