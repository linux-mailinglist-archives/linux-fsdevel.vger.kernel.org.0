Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8724FE20E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Apr 2022 15:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355262AbiDLNO5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Apr 2022 09:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356782AbiDLNOJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:14:09 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A2211C0C;
        Tue, 12 Apr 2022 06:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649768459; x=1681304459;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=lExz5hm5xcTzyOEY6YHWDS3MJSoSHVq4Qg2JWxxoCRg=;
  b=Y+6d7TPQpIfSQQxlgYThQcAbaudKPjvUzwzJcvxX3Sqil7dW7Emrc8xt
   l24+fusu2XXmJIJ1UYbAJlMnVgkJRL06DZqmGsZHBtH0dUexAFAjpwUB8
   wO61WBwfoh1XZcH20OrK9QnoYUalxPPKCDX6CRDhb1cGcJX2g/24ViUQf
   vvWThyvfl8ERv4DT4oIWY5W9RNdyRj4RQjxoxjaemKkKLLY7qiVtRrOmW
   P/v11FVG4/ZDbW21y1F2WTeQPGlcIhu3fE/QOYD5gUbWSiqkWw24R0FxG
   vG9GG03m04HF7kdfrErSKP9AsZmbTO+L7VCG556xANO4+mGSf66TO0aYk
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="348805462"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="348805462"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 06:00:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="699826034"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by fmsmga001.fm.intel.com with ESMTP; 12 Apr 2022 06:00:51 -0700
Date:   Tue, 12 Apr 2022 21:00:40 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
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
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com
Subject: Re: [PATCH v5 00/13] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Message-ID: <20220412130040.GD8013@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <CALCETrWk1Y47JQC=V028A7Tmc9776Oo4AjgwqRtd9K=XDh6=TA@mail.gmail.com>
 <CAGtprH9DGyxSKSwVhc0Td3x-M4-C6j=+d3DEtkxOty+PPB0V_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGtprH9DGyxSKSwVhc0Td3x-M4-C6j=+d3DEtkxOty+PPB0V_g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 08, 2022 at 11:35:05AM -1000, Vishal Annapurve wrote:
> On Mon, Mar 28, 2022 at 10:17 AM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On Thu, Mar 10, 2022 at 6:09 AM Chao Peng <chao.p.peng@linux.intel.com> wrote:
> > >
> > > This is the v5 of this series which tries to implement the fd-based KVM
> > > guest private memory. The patches are based on latest kvm/queue branch
> > > commit:
> > >
> > >   d5089416b7fb KVM: x86: Introduce KVM_CAP_DISABLE_QUIRKS2
> >
> > Can this series be run and a VM booted without TDX?  A feature like
> > that might help push it forward.
> >
> > --Andy
> 
> I have posted a RFC series with selftests to exercise the UPM feature
> with normal non-confidential VMs via
> https://lore.kernel.org/kvm/20220408210545.3915712-1-vannapurve@google.com/

Thanks Vishal, this sounds very helpful, it already started to find
bugs.

Chao
> 
> -- Vishal
