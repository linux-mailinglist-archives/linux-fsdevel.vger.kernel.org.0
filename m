Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1876407DE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Dec 2022 14:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbiLBNol (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Dec 2022 08:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbiLBNoi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Dec 2022 08:44:38 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D457DD78C4;
        Fri,  2 Dec 2022 05:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669988676; x=1701524676;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=skS3MR2BvQKKKmac1ZclTHHuTXnPM7lSX4PdHSON5iM=;
  b=etrl713uP9zPN4Y7zzOnpu5bmc+dZ/UHIghKHo1yCxupTaAkrFTKUBaY
   t4oc46tu8uZ8kkVhwqlV5wk7FYmCZTp4bn4DU0qR1fvvbnCoLMwOTcQwY
   KyWPe1dM3gcRzgCwwsJW2Pvn8B36fT+vL8QwXI3zGWuGYWkSaKUDeJGmI
   XcOKz0oM4NmX6dqQuXhEBmtqARggoMic/rL4G6ljl0i4ujXm+hJ6AetCw
   yBSO/kCPQzE9EobLmy0B/Kk9u4MlqrjSReB22I6yUPeJVVAwP4nEtu4ue
   1OhcApdKlizefoDn8GRmuom3izr80PksleDMf4MA10VloV3880DgajFx9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="317102462"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; 
   d="scan'208";a="317102462"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 05:44:35 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="622704069"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; 
   d="scan'208";a="622704069"
Received: from valeriya-mobl2.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.211.234])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 05:44:23 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id EC5D610975F; Fri,  2 Dec 2022 16:44:19 +0300 (+03)
Date:   Fri, 2 Dec 2022 16:44:19 +0300
From:   "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     Vishal Annapurve <vannapurve@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
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
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yu Zhang <yu.c.zhang@linux.intel.com>, luto@kernel.org,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        tabba@google.com, Michael Roth <michael.roth@amd.com>,
        mhocko@suse.com, Muchun Song <songmuchun@bytedance.com>,
        wei.w.wang@intel.com
Subject: Re: [PATCH v9 1/8] mm: Introduce memfd_restricted system call to
 create restricted user memory
Message-ID: <20221202134419.vjhqzuz5alv3v2ak@box.shutemov.name>
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <20221025151344.3784230-2-chao.p.peng@linux.intel.com>
 <CAGtprH9Qu==pohH9ZSTzX9rZWSO0QWJ9rGK6NRGaiDetWAPLYg@mail.gmail.com>
 <20221202064909.GA1070297@chaop.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202064909.GA1070297@chaop.bj.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 02, 2022 at 02:49:09PM +0800, Chao Peng wrote:
> On Thu, Dec 01, 2022 at 06:16:46PM -0800, Vishal Annapurve wrote:
> > On Tue, Oct 25, 2022 at 8:18 AM Chao Peng <chao.p.peng@linux.intel.com> wrote:
> > >
> ...
> > > +}
> > > +
> > > +SYSCALL_DEFINE1(memfd_restricted, unsigned int, flags)
> > > +{
> > 
> > Looking at the underlying shmem implementation, there seems to be no
> > way to enable transparent huge pages specifically for restricted memfd
> > files.
> > 
> > Michael discussed earlier about tweaking
> > /sys/kernel/mm/transparent_hugepage/shmem_enabled setting to allow
> > hugepages to be used while backing restricted memfd. Such a change
> > will affect the rest of the shmem usecases as well. Even setting the
> > shmem_enabled policy to "advise" wouldn't help unless file based
> > advise for hugepage allocation is implemented.
> 
> Had a look at fadvise() and looks it does not support HUGEPAGE for any
> filesystem yet.

Yes, I think fadvise() is the right direction here. The problem is similar
to NUMA policy where existing APIs are focused around virtual memory
addresses. We need to extend ABI to take fd+offset as input instead.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
