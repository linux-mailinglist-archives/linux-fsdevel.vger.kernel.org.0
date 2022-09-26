Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71755EAB13
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Sep 2022 17:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbiIZPbE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 11:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236526AbiIZP0j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:26:39 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A495F10C;
        Mon, 26 Sep 2022 07:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664201522; x=1695737522;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=3K99V46lahR/2OM+AWPRnQqkJGlMh+2oIpwQe2KYPck=;
  b=Y6LnGx9c7yhH6Kp5vJc7Bd4doIoXc6CqLfAopx/aEQvikW1sBo4IxWPm
   WeVc6choXalmBnTGqmH0yA/RYq8b/PLxGYs1fEsxVpoUE420yXNvOAWQD
   Rw9Ru8IQ1m3leH2qco3MXnizcjTituW5JUcmoY0O8qzF+OsMdh7JfMCYE
   WZ9y0bkqQLaEpdjvAw539SSgG63iVolOUFemXs57+5n4ypvx8HaaROwvy
   QvNSW/jEae1YRk2Qbk4LmsoNijfVCIcJofvgRp+ERCkAe1MLqZIWzoTNi
   hykujIAqT9a/w0Zwh/uV40pWc7h5URwCbZLbXE1uqleCty9FC6jnjUQWw
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="299760274"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="299760274"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 07:12:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="651841295"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="651841295"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by orsmga008.jf.intel.com with ESMTP; 26 Sep 2022 07:11:51 -0700
Date:   Mon, 26 Sep 2022 22:07:15 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Fuad Tabba <tabba@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
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
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Subject: Re: [PATCH v8 5/8] KVM: Register/unregister the guest private memory
 regions
Message-ID: <20220926140715.GB2658254@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-6-chao.p.peng@linux.intel.com>
 <CA+EHjTx+GVpGavzMQQOispT-oUk5cSyssedYJ00=GdnCtEQO6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTx+GVpGavzMQQOispT-oUk5cSyssedYJ00=GdnCtEQO6A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 26, 2022 at 11:36:34AM +0100, Fuad Tabba wrote:
...

> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index 2125b50f6345..d65690cae80b 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -260,6 +260,15 @@ bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range);
> >  bool kvm_set_spte_gfn(struct kvm *kvm, struct kvm_gfn_range *range);
> >  #endif
> >
> > +#ifdef __KVM_HAVE_ZAP_GFN_RANGE
> > +void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end);
> > +#else
> > +static inline void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start
> > +                                                     gfn_t gfn_end)
> 
> Missing a comma after gfn_start.

Good catch, thanks!
Chao
> 
> Cheers,
> /fuad

