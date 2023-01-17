Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1836266DEFC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 14:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjAQNin (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 08:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjAQNie (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 08:38:34 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477EB59C6;
        Tue, 17 Jan 2023 05:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673962713; x=1705498713;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=1YxIhrDQKE2lDqlUyO/ARVgD5QjeSGAHzdlrkVl5mCo=;
  b=FVs309qlXE78B/GssbtiD3lcrLHRsXs0LWTpSX3bPI1VX5MnhjUqEIyK
   QJP44sF2pnZSLspTukaj9oFzkmWPYZs3egj9PjEHMp9FwXrtSlaw6bh0R
   zuaJ0c0tz0Wpy8vbZwPYZi7J/IEz7OIRGv23X16xlv9gHmII35eDXs09H
   AA6G/MZqhrLlu1MmC1ZWljcI0i6v3EuwGGflRY8N5YV8TjTfiXQxShVxj
   VswTR/Vo1DTBFZubbZyH7zsITbqoxlUgBG8I2rgZ+/L6Y6YZtzz36AwK1
   gyxy9TC4vkKGuug6kKK9iG3tV8jjTys5v09lApvjGZ24gjyZ//07LfFWg
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="324748849"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="324748849"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 05:38:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="783240137"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="783240137"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.105])
  by orsmga004.jf.intel.com with ESMTP; 17 Jan 2023 05:38:03 -0800
Date:   Tue, 17 Jan 2023 21:30:15 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Binbin Wu <binbin.wu@linux.intel.com>
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
        Arnd Bergmann <arnd@arndb.de>,
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
Message-ID: <20230117133015.GE273037@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-3-chao.p.peng@linux.intel.com>
 <c25f1f8c-f7c0-6a96-cd67-260df47f79a9@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c25f1f8c-f7c0-6a96-cd67-260df47f79a9@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 17, 2023 at 11:21:10AM +0800, Binbin Wu wrote:
> 
> On 12/2/2022 2:13 PM, Chao Peng wrote:
> > In confidential computing usages, whether a page is private or shared is
> > necessary information for KVM to perform operations like page fault
> > handling, page zapping etc. There are other potential use cases for
> > per-page memory attributes, e.g. to make memory read-only (or no-exec,
> > or exec-only, etc.) without having to modify memslots.
> > 
> > Introduce two ioctls (advertised by KVM_CAP_MEMORY_ATTRIBUTES) to allow
> > userspace to operate on the per-page memory attributes.
> >    - KVM_SET_MEMORY_ATTRIBUTES to set the per-page memory attributes to
> >      a guest memory range.
> >    - KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES to return the KVM supported
> >      memory attributes.
> > 
> > KVM internally uses xarray to store the per-page memory attributes.
> > 
> > Suggested-by: Sean Christopherson <seanjc@google.com>
> > Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> > Link: https://lore.kernel.org/all/Y2WB48kD0J4VGynX@google.com/
> > ---
> >   Documentation/virt/kvm/api.rst | 63 ++++++++++++++++++++++++++++
> >   arch/x86/kvm/Kconfig           |  1 +
> >   include/linux/kvm_host.h       |  3 ++
> >   include/uapi/linux/kvm.h       | 17 ++++++++
> 
> Should the changes introduced in this file also need to be added in
> tools/include/uapi/linux/kvm.h ?

Yes I think. But I'm hesitate to include in this patch or not. I see
many commits sync kernel kvm.h to tools's copy. Looks that is done
periodically and with a 'pull' model.

Chao
