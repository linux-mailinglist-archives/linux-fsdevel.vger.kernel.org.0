Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9240150D065
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Apr 2022 10:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238630AbiDXIKy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Apr 2022 04:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236428AbiDXIKx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Apr 2022 04:10:53 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB101816C6;
        Sun, 24 Apr 2022 01:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650787674; x=1682323674;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=Jg69NAeROVkmxoEWc411QwNioJnF4WnIiJ0sHVRfPPE=;
  b=gl1rcmLSizfukbF+kURWVeQ4WDc6GXknisCAooeJSK5KrUnRfxau5Ldv
   /f//mIHeegzZVbXychQYSUZfHzUbIjTOJl3EPoUtVvq0XVPY8jO9w8E0f
   JFQTqnqvp/ODv0keKt0KFlKUEfIConqJkvaLbciCSEKkPWCX2ydMGRxTB
   /VNcdAkmv/POalgQ2zYktLqTYvUeyp4OIpPWK9+t93vkosScOo/oJSXXW
   FqJSK9QNlzhI4JSLEPT/SLI1n+nXxkoFs9ikujHMKt71obVDrzjLH/1lI
   WBC0fvBjNjsGZiPDyOcx+S1S+Bf35DIwlTh1t7KKxyOO1uD2H7NZXhEnR
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="265182519"
X-IronPort-AV: E=Sophos;i="5.90,286,1643702400"; 
   d="scan'208";a="265182519"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2022 01:07:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,286,1643702400"; 
   d="scan'208";a="704146191"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by fmsmga001.fm.intel.com with ESMTP; 24 Apr 2022 01:07:45 -0700
Date:   Sun, 24 Apr 2022 16:07:37 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Quentin Perret <qperret@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Price <steven.price@arm.com>,
        kvm list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>, qemu-devel@nongnu.org,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v5 00/13] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Message-ID: <20220424080737.GA4207@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <80aad2f9-9612-4e87-a27a-755d3fa97c92@www.fastmail.com>
 <YkcTTY4YjQs5BRhE@google.com>
 <83fd55f8-cd42-4588-9bf6-199cbce70f33@www.fastmail.com>
 <YksIQYdG41v3KWkr@google.com>
 <Ykslo2eo2eRXrpFR@google.com>
 <eefc3c74-acca-419c-8947-726ce2458446@www.fastmail.com>
 <Ykwbqv90C7+8K+Ao@google.com>
 <YkyEaYiL0BrDYcZv@google.com>
 <20220422105612.GB61987@chaop.bj.intel.com>
 <ae7c9c7a-ecda-8c80-751f-f05dbc6489d7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae7c9c7a-ecda-8c80-751f-f05dbc6489d7@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 22, 2022 at 01:06:25PM +0200, Paolo Bonzini wrote:
> On 4/22/22 12:56, Chao Peng wrote:
> >          /* memfile notifier flags */
> >          #define MFN_F_USER_INACCESSIBLE   0x0001  /* memory allocated in the file is inaccessible from userspace (e.g. read/write/mmap) */
> >          #define MFN_F_UNMOVABLE           0x0002  /* memory allocated in the file is unmovable */
> >          #define MFN_F_UNRECLAIMABLE       0x0003  /* memory allocated in the file is unreclaimable (e.g. via kswapd or any other pathes) */
> 
> You probably mean BIT(0/1/2) here.

Right, it's BIT(n), Thanks.

Chao
> 
> Paolo
> 
> >      When memfile_notifier is being registered, memfile_register_notifier will
> >      need check these flags. E.g. for MFN_F_USER_INACCESSIBLE, it fails when
> >      previous mmap-ed mapping exists on the fd (I'm still unclear on how to do
> >      this). When multiple consumers are supported it also need check all
> >      registered consumers to see if any conflict (e.g. all consumers should have
> >      MFN_F_USER_INACCESSIBLE set). Only when the register succeeds, the fd is
> >      converted into a private fd, before that, the fd is just a normal (shared)
> >      one. During this conversion, the previous data is preserved so you can put
> >      some initial data in guest pages (whether the architecture allows this is
> >      architecture-specific and out of the scope of this patch).
