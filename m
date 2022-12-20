Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75769651BB3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Dec 2022 08:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbiLTHaN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Dec 2022 02:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbiLTH3o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Dec 2022 02:29:44 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E9417059;
        Mon, 19 Dec 2022 23:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671521355; x=1703057355;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=fjNSa0+921I8s8ST66iQKKAKKNcHFJo2C7vp0DyF6bU=;
  b=btMmDhriNUXIYE3RDC/D+VlLnxqJpYdVAtCnKG6Y00TuZKg18RKtoen/
   ncKwhvbRaEWA1yueeu/7jrTKZZOoQBLg26c0Jt3b66l28RtiMKqyl9/ZK
   BgHqrpZBvLVYRk05frWTi7WjlYd3SqywoATxQxUttzwFkOdyx0XW+LztN
   CT8l4frasDPosl1OcaAHaow6ysNwW+VRk+KO1MvSkc8CdXfQLlS84LxHt
   PsQDsqnKCjOamEfvwz7swdwU6fxTOAEc4xaYAcKCHBhwLzFWG5Ik71Oci
   VCft7PHZkTWzSaxoNXv3sAK88Okxl6FcOPm9twU7H/ESpoxPiFwvgzL6V
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="307230620"
X-IronPort-AV: E=Sophos;i="5.96,258,1665471600"; 
   d="scan'208";a="307230620"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 23:29:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="775191645"
X-IronPort-AV: E=Sophos;i="5.96,258,1665471600"; 
   d="scan'208";a="775191645"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by orsmga004.jf.intel.com with ESMTP; 19 Dec 2022 23:29:03 -0800
Date:   Tue, 20 Dec 2022 15:24:46 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
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
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
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
        wei.w.wang@intel.com
Subject: Re: [PATCH v10 2/9] KVM: Introduce per-page memory attributes
Message-ID: <20221220072446.GB1724933@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-3-chao.p.peng@linux.intel.com>
 <Y5yKEpwCzZpNoBrp@zn.tnic>
 <20221219081532.GD1691829@chaop.bj.intel.com>
 <Y6A6MkFjckQ18fFH@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6A6MkFjckQ18fFH@zn.tnic>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 19, 2022 at 11:17:22AM +0100, Borislav Petkov wrote:
> On Mon, Dec 19, 2022 at 04:15:32PM +0800, Chao Peng wrote:
> > Tamping down with error number a bit:
> > 
> >         if (attrs->flags)
> >                 return -ENXIO;
> >         if (attrs->attributes & ~supported_attrs)
> >                 return -EOPNOTSUPP;
> >         if (!PAGE_ALIGNED(attrs->address) || !PAGE_ALIGNED(attrs->size) ||
> >             attrs->size == 0)
> >                 return -EINVAL;
> >         if (attrs->address + attrs->size < attrs->address)
> >                 return -E2BIG;
> 
> Yap, better.
> 
> I guess you should add those to the documentation of the ioctl too
> so that people can find out why it fails. Or, well, they can look
> at the code directly too but still... imagine some blurb about
> user-friendliness here...

Thanks for reminding. Yes KVM api doc is the right place to put these
documentation in.

Thanks,
Chao
> 
> :-)
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
