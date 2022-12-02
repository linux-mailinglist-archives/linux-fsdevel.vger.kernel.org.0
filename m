Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9596400AE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Dec 2022 07:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbiLBGxp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Dec 2022 01:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbiLBGxn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Dec 2022 01:53:43 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2254BB7C1;
        Thu,  1 Dec 2022 22:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669964022; x=1701500022;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=hsL57ikcNVoLHdsSPb/2quBPJAcrsHQWRoxcjDJhwfk=;
  b=eT0WFURXcMGeVYPNWIXxRON88XkgDgnK57MP8L9HBxKxsLmaAF3wJG7q
   rnDKkrgZoX9TcVbQjFOyiHKO0gbbZ9fcMwwssDAXYyl0WJvN4OeI0hfn/
   Kn0FuzeN0TDa37Lo4FaguVQsHPwL8t1p0mbouzgGyTeMfR+/WJw28w2b8
   rh2r81QD8/4ACEi8dpcM54W2kVY5TcI1TPegcZnSzlgwg7wDRxmJr7X5t
   P2v2sBsKA3vddkTIPlScUBDZCzecu1t1zNo639kpdVQMg7YY5Tl2lDL/u
   KEf8CmRexAJLimiQPuCvaGZlDcib1wrhzm98hW6Vv0ekfUBtGpO0LdthQ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="299253379"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="299253379"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 22:53:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="708374082"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="708374082"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by fmsmga008.fm.intel.com with ESMTP; 01 Dec 2022 22:53:30 -0800
Date:   Fri, 2 Dec 2022 14:49:09 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
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
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Subject: Re: [PATCH v9 1/8] mm: Introduce memfd_restricted system call to
 create restricted user memory
Message-ID: <20221202064909.GA1070297@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <20221025151344.3784230-2-chao.p.peng@linux.intel.com>
 <CAGtprH9Qu==pohH9ZSTzX9rZWSO0QWJ9rGK6NRGaiDetWAPLYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGtprH9Qu==pohH9ZSTzX9rZWSO0QWJ9rGK6NRGaiDetWAPLYg@mail.gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 01, 2022 at 06:16:46PM -0800, Vishal Annapurve wrote:
> On Tue, Oct 25, 2022 at 8:18 AM Chao Peng <chao.p.peng@linux.intel.com> wrote:
> >
...
> > +}
> > +
> > +SYSCALL_DEFINE1(memfd_restricted, unsigned int, flags)
> > +{
> 
> Looking at the underlying shmem implementation, there seems to be no
> way to enable transparent huge pages specifically for restricted memfd
> files.
> 
> Michael discussed earlier about tweaking
> /sys/kernel/mm/transparent_hugepage/shmem_enabled setting to allow
> hugepages to be used while backing restricted memfd. Such a change
> will affect the rest of the shmem usecases as well. Even setting the
> shmem_enabled policy to "advise" wouldn't help unless file based
> advise for hugepage allocation is implemented.

Had a look at fadvise() and looks it does not support HUGEPAGE for any
filesystem yet.

> 
> Does it make sense to provide a flag here to allow creating restricted
> memfds backed possibly by huge pages to give a more granular control?

We do have a unused 'flags' can be extended for such usage, but I would
let Kirill have further look, perhaps need more discussions.

Chao
> 
> > +       struct file *file, *restricted_file;
> > +       int fd, err;
> > +
> > +       if (flags)
> > +               return -EINVAL;
> > +
> > +       fd = get_unused_fd_flags(0);
> > +       if (fd < 0)
> > +               return fd;
> > +
> > +       file = shmem_file_setup("memfd:restrictedmem", 0, VM_NORESERVE);
> > +       if (IS_ERR(file)) {
> > +               err = PTR_ERR(file);
> > +               goto err_fd;
> > +       }
> > +       file->f_mode |= FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE;
> > +       file->f_flags |= O_LARGEFILE;
> > +
> > +       restricted_file = restrictedmem_file_create(file);
> > +       if (IS_ERR(restricted_file)) {
> > +               err = PTR_ERR(restricted_file);
> > +               fput(file);
> > +               goto err_fd;
> > +       }
> > +
> > +       fd_install(fd, restricted_file);
> > +       return fd;
> > +err_fd:
> > +       put_unused_fd(fd);
> > +       return err;
> > +}
> > +
> > +void restrictedmem_register_notifier(struct file *file,
> > +                                    struct restrictedmem_notifier *notifier)
> > +{
> > +       struct restrictedmem_data *data = file->f_mapping->private_data;
> > +
> > +       mutex_lock(&data->lock);
> > +       list_add(&notifier->list, &data->notifiers);
> > +       mutex_unlock(&data->lock);
> > +}
> > +EXPORT_SYMBOL_GPL(restrictedmem_register_notifier);
> > +
> > +void restrictedmem_unregister_notifier(struct file *file,
> > +                                      struct restrictedmem_notifier *notifier)
> > +{
> > +       struct restrictedmem_data *data = file->f_mapping->private_data;
> > +
> > +       mutex_lock(&data->lock);
> > +       list_del(&notifier->list);
> > +       mutex_unlock(&data->lock);
> > +}
> > +EXPORT_SYMBOL_GPL(restrictedmem_unregister_notifier);
> > +
> > +int restrictedmem_get_page(struct file *file, pgoff_t offset,
> > +                          struct page **pagep, int *order)
> > +{
> > +       struct restrictedmem_data *data = file->f_mapping->private_data;
> > +       struct file *memfd = data->memfd;
> > +       struct page *page;
> > +       int ret;
> > +
> > +       ret = shmem_getpage(file_inode(memfd), offset, &page, SGP_WRITE);
> > +       if (ret)
> > +               return ret;
> > +
> > +       *pagep = page;
> > +       if (order)
> > +               *order = thp_order(compound_head(page));
> > +
> > +       SetPageUptodate(page);
> > +       unlock_page(page);
> > +
> > +       return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(restrictedmem_get_page);
> > --
> > 2.25.1
> >
