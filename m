Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6C1610A2B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 08:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiJ1GRR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 02:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiJ1GRP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 02:17:15 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75EF68CD6;
        Thu, 27 Oct 2022 23:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666937834; x=1698473834;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=dF/aWwaNQggwj6gD+KJTCT5Ni9qMvVF3l+TfbYoad8o=;
  b=cz4o6+8UlqHnvioAVQjz4Ublzvx8r+9l3uEQN2RV0Ivt+YJkLLVcCfL0
   8QplgOY/8AE7rrUfZYbwpdVYKaZ9in52yRzSPgSMPrkjv/M3lG0tKmL6C
   j8BwegLkehF7mAy/Iw6z39HnTOseMEHWx2QfMD8408wgFLI3t8TqAMaL0
   UK3Vt9wqn9CymgRBiJmk2o7nU5K2bX/bojBdnsLhe39jenVsoquk4tIhE
   bLWyMh1sgqnPIZkEHD25lmzRy118mpem8iBU85zZhApGHxyZmmgCGmi6r
   SJiBO3cROnEXTHLeLO9uWM/gmGYFNNcsNcSafc3ZwA7r/kWx45oqkfEeJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="372634624"
X-IronPort-AV: E=Sophos;i="5.95,220,1661842800"; 
   d="scan'208";a="372634624"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 23:17:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="627427865"
X-IronPort-AV: E=Sophos;i="5.95,220,1661842800"; 
   d="scan'208";a="627427865"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by orsmga007.jf.intel.com with ESMTP; 27 Oct 2022 23:17:01 -0700
Date:   Fri, 28 Oct 2022 14:12:32 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Isaku Yamahata <isaku.yamahata@gmail.com>
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
        Vishal Annapurve <vannapurve@google.com>,
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
Message-ID: <20221028061232.GA3885130@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <20221025151344.3784230-2-chao.p.peng@linux.intel.com>
 <20221026173145.GA3819453@ls.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026173145.GA3819453@ls.amr.corp.intel.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 26, 2022 at 10:31:45AM -0700, Isaku Yamahata wrote:
> On Tue, Oct 25, 2022 at 11:13:37PM +0800,
> Chao Peng <chao.p.peng@linux.intel.com> wrote:
> 
> > +int restrictedmem_get_page(struct file *file, pgoff_t offset,
> > +			   struct page **pagep, int *order)
> > +{
> > +	struct restrictedmem_data *data = file->f_mapping->private_data;
> > +	struct file *memfd = data->memfd;
> > +	struct page *page;
> > +	int ret;
> > +
> > +	ret = shmem_getpage(file_inode(memfd), offset, &page, SGP_WRITE);
> 
> shmem_getpage() was removed.
> https://lkml.kernel.org/r/20220902194653.1739778-34-willy@infradead.org

Thanks for pointing out. My current base(kvm/queue) has not included
this change yet so still use shmem_getpage().

Chao
> 
> I needed the following fix to compile.
> 
> thanks,
> 
> diff --git a/mm/restrictedmem.c b/mm/restrictedmem.c
> index e5bf8907e0f8..4694dd5609d6 100644
> --- a/mm/restrictedmem.c
> +++ b/mm/restrictedmem.c
> @@ -231,13 +231,15 @@ int restrictedmem_get_page(struct file *file, pgoff_t offset,
>  {
>         struct restrictedmem_data *data = file->f_mapping->private_data;
>         struct file *memfd = data->memfd;
> +       struct folio *folio = NULL;
>         struct page *page;
>         int ret;
>  
> -       ret = shmem_getpage(file_inode(memfd), offset, &page, SGP_WRITE);
> +       ret = shmem_get_folio(file_inode(memfd), offset, &folio, SGP_WRITE);
>         if (ret)
>                 return ret;
>  
> +       page = folio_file_page(folio, offset);
>         *pagep = page;
>         if (order)
>                 *order = thp_order(compound_head(page));
> -- 
> Isaku Yamahata <isaku.yamahata@gmail.com>
