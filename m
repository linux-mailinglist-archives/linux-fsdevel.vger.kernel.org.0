Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38EC60B52B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 20:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbiJXSNE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 14:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbiJXSMW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:12:22 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461B757E17;
        Mon, 24 Oct 2022 09:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666630459; x=1698166459;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f12+hDSs2xhh9+cgFUHAQwPz5EdOX4nrGTxSpB9xto8=;
  b=Lx4O7B4HXPSw6eCOX6fxKVKroy/kLcxL2hy81b68CBxeeJRyLCmgMCfL
   +GmcUQtQfNoaO0aKDUWtL30YejrZoBatDCS3PeFJE4DrVZy75n4meLb3V
   lTd9rYHhJuaupDbeWYGNYIRyNXZj3pq47viEZfMgcU99FnPK0/qZgfmIi
   gspbcVr59orDB9o72YPvLlrDzWGOkCq17RmNQJRAMNg2/pBM0j0LNOMfA
   bj+i/Q+CUyf8nP7jn5Mf5krunxQliQkthbAZqVw/QMtNgTnCY5KYq20Fa
   rnUMOQajJskrGGHNEtBU+aDreoW/sfo7JqEpyO72zuy8iUIvlJ76mj0/t
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="290739879"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="290739879"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 07:59:41 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="631284461"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="631284461"
Received: from unisar-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.38.228])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 07:59:30 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 381A7104D5C; Mon, 24 Oct 2022 17:59:28 +0300 (+03)
Date:   Mon, 24 Oct 2022 17:59:28 +0300
From:   "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>,
        Vishal Annapurve <vannapurve@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
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
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yu Zhang <yu.c.zhang@linux.intel.com>, luto@kernel.org,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Subject: Re: [PATCH v8 1/8] mm/memfd: Introduce userspace inaccessible memfd
Message-ID: <20221024145928.66uehsokp7bpa2st@box.shutemov.name>
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-2-chao.p.peng@linux.intel.com>
 <CAGtprH_MiCxT2xSxD2UrM4M+ghL0V=XEZzEX4Fo5wQKV4fAL4w@mail.gmail.com>
 <20221021134711.GA3607894@chaop.bj.intel.com>
 <Y1LGRvVaWwHS+Zna@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1LGRvVaWwHS+Zna@google.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 21, 2022 at 04:18:14PM +0000, Sean Christopherson wrote:
> On Fri, Oct 21, 2022, Chao Peng wrote:
> > > 
> > > In the context of userspace inaccessible memfd, what would be a
> > > suggested way to enforce NUMA memory policy for physical memory
> > > allocation? mbind[1] won't work here in absence of virtual address
> > > range.
> > 
> > How about set_mempolicy():
> > https://www.man7.org/linux/man-pages/man2/set_mempolicy.2.html
> 
> Andy Lutomirski brought this up in an off-list discussion way back when the whole
> private-fd thing was first being proposed.
> 
>   : The current Linux NUMA APIs (mbind, move_pages) work on virtual addresses.  If
>   : we want to support them for TDX private memory, we either need TDX private
>   : memory to have an HVA or we need file-based equivalents. Arguably we should add
>   : fmove_pages and fbind syscalls anyway, since the current API is quite awkward
>   : even for tools like numactl.

Yeah, we definitely have gaps in API wrt NUMA, but I don't think it be
addressed in the initial submission.

BTW, it is not regression comparing to old KVM slots, if the memory is
backed by memfd or other file:

MBIND(2)
       The  specified policy will be ignored for any MAP_SHARED mappings in the
       specified memory range.  Rather the pages will be allocated according to
       the  memory  policy  of the thread that caused the page to be allocated.
       Again, this may not be the thread that called mbind().

It is not clear how to define fbind(2) semantics, considering that multiple
processes may compete for the same region of page cache.

Should it be per-inode or per-fd? Or maybe per-range in inode/fd?

fmove_pages(2) should be relatively straight forward, since it is
best-effort and does not guarantee that the page will note be moved
somewhare else just after return from the syscall.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
