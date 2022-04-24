Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D678250D071
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Apr 2022 10:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238668AbiDXISn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Apr 2022 04:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238659AbiDXISl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Apr 2022 04:18:41 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62AED6E4DC;
        Sun, 24 Apr 2022 01:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650788142; x=1682324142;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=R5/zZF/IyIdTwmbR+/CpSjzujNVRZET5P/KUYqz4hbY=;
  b=mUe/0iSmQ8BsD5PsLd7n1RL0F8BH/VTKHaMVrdOuAIPVJ8GR89w/HnDB
   sKsqeaFN4klnuZVvXos7Rs9PfCT8mvRHLLqPffnbpu/OvFZr3pBaX3Ly5
   vs1NLQgCJ5T8TbhmuS1yW9DUQofWNL6oLMLB0sPaFdoR6yieCfloodtXB
   pqDREHAfH+SAnBiNmZ/735NAWoGG4g1bKq+4lXVUG96cjjbLxojf6ywrH
   DFLiaes0EbuZn8tkgduvX1WS9lAM30v1xwDkyv2ZutjeDS5YtczRGo9Z0
   O+GB7OWcBXIBDjNyH9qox8ZFW3iYxyk8F0fgVl+8dBtY7aN0NYyBE/7l2
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="246931372"
X-IronPort-AV: E=Sophos;i="5.90,286,1643702400"; 
   d="scan'208";a="246931372"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2022 01:15:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,286,1643702400"; 
   d="scan'208";a="704147618"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by fmsmga001.fm.intel.com with ESMTP; 24 Apr 2022 01:15:34 -0700
Date:   Sun, 24 Apr 2022 16:15:25 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Vishal Annapurve <vannapurve@google.com>
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
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jun Nakajima <jun.nakajima@intel.com>, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com
Subject: Re: [PATCH v5 01/13] mm/memfd: Introduce MFD_INACCESSIBLE flag
Message-ID: <20220424081525.GB4207@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <20220310140911.50924-2-chao.p.peng@linux.intel.com>
 <CAGtprH9sncAeS7-=ewr07B=Q+htVDdwRJhbqF+GhehHMYmvw5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGtprH9sncAeS7-=ewr07B=Q+htVDdwRJhbqF+GhehHMYmvw5w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 22, 2022 at 10:43:50PM -0700, Vishal Annapurve wrote:
> On Thu, Mar 10, 2022 at 6:09 AM Chao Peng <chao.p.peng@linux.intel.com> wrote:
> >
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
> > +#define SHM_F_INACCESSIBLE     0x0001  /* prevent ordinary MMU access (e.g. read/write/mmap) to file content */
> > +
> >  struct shmem_inode_info {
> >         spinlock_t              lock;
> >         unsigned int            seals;          /* shmem seals */
> > @@ -24,6 +27,7 @@ struct shmem_inode_info {
> >         struct shared_policy    policy;         /* NUMA memory alloc policy */
> >         struct simple_xattrs    xattrs;         /* list of xattrs */
> >         atomic_t                stop_eviction;  /* hold when working on inode */
> > +       unsigned int            xflags;         /* shmem extended flags */
> >         struct inode            vfs_inode;
> >  };
> >
> > @@ -61,6 +65,9 @@ extern struct file *shmem_file_setup(const char *name,
> >                                         loff_t size, unsigned long flags);
> >  extern struct file *shmem_kernel_file_setup(const char *name, loff_t size,
> >                                             unsigned long flags);
> > +extern struct file *shmem_file_setup_xflags(const char *name, loff_t size,
> > +                                           unsigned long flags,
> > +                                           unsigned int xflags);
> >  extern struct file *shmem_file_setup_with_mnt(struct vfsmount *mnt,
> >                 const char *name, loff_t size, unsigned long flags);
> >  extern int shmem_zero_setup(struct vm_area_struct *);
> > diff --git a/include/uapi/linux/memfd.h b/include/uapi/linux/memfd.h
> > index 7a8a26751c23..48750474b904 100644
> > --- a/include/uapi/linux/memfd.h
> > +++ b/include/uapi/linux/memfd.h
> > @@ -8,6 +8,7 @@
> >  #define MFD_CLOEXEC            0x0001U
> >  #define MFD_ALLOW_SEALING      0x0002U
> >  #define MFD_HUGETLB            0x0004U
> > +#define MFD_INACCESSIBLE       0x0008U
> >
> >  /*
> >   * Huge page size encoding when MFD_HUGETLB is specified, and a huge page
> > diff --git a/mm/memfd.c b/mm/memfd.c
> > index 9f80f162791a..74d45a26cf5d 100644
> > --- a/mm/memfd.c
> > +++ b/mm/memfd.c
> > @@ -245,16 +245,20 @@ long memfd_fcntl(struct file *file, unsigned int cmd, unsigned long arg)
> >  #define MFD_NAME_PREFIX_LEN (sizeof(MFD_NAME_PREFIX) - 1)
> >  #define MFD_NAME_MAX_LEN (NAME_MAX - MFD_NAME_PREFIX_LEN)
> >
> > -#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB)
> > +#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB | \
> > +                      MFD_INACCESSIBLE)
> >
> >  SYSCALL_DEFINE2(memfd_create,
> >                 const char __user *, uname,
> >                 unsigned int, flags)
> >  {
> > +       struct address_space *mapping;
> >         unsigned int *file_seals;
> > +       unsigned int xflags;
> >         struct file *file;
> >         int fd, error;
> >         char *name;
> > +       gfp_t gfp;
> >         long len;
> >
> >         if (!(flags & MFD_HUGETLB)) {
> > @@ -267,6 +271,10 @@ SYSCALL_DEFINE2(memfd_create,
> >                         return -EINVAL;
> >         }
> >
> > +       /* Disallow sealing when MFD_INACCESSIBLE is set. */
> > +       if (flags & MFD_INACCESSIBLE && flags & MFD_ALLOW_SEALING)
> > +               return -EINVAL;
> > +
> >         /* length includes terminating zero */
> >         len = strnlen_user(uname, MFD_NAME_MAX_LEN + 1);
> >         if (len <= 0)
> > @@ -301,8 +309,11 @@ SYSCALL_DEFINE2(memfd_create,
> >                                         HUGETLB_ANONHUGE_INODE,
> >                                         (flags >> MFD_HUGE_SHIFT) &
> >                                         MFD_HUGE_MASK);
> 
> Should hugetlbfs also be modified to be a backing store for private
> memory like shmem when hugepages are to be used?
> As of now, this series doesn't seem to support using private memfds
> with backing hugepages.
> 

Right, as the first step tmpfs is the first backing store supported,
hugetlbfs would be potentially the second one to support once the user
semantics and kAPIs exposed to KVM are well understood.

Thanks,
Chao
