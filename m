Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3F153A279
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 12:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345117AbiFAKVY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jun 2022 06:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiFAKVX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jun 2022 06:21:23 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189A46D955;
        Wed,  1 Jun 2022 03:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654078883; x=1685614883;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=MPDfwkz64kDPQGnp5LEYEWHtzrsbbGi1CtkgkpVVQ9g=;
  b=my0Teip4tC+h3shpaalEILbiEcsZvyfUzCTkEnYUqVGXPt8d1tylIeSC
   qhwvDylj53iu1h2GlNGQnChlyIxX+ESo1w/xIu1nQYXlAlHpX2eqW7hgr
   zGGcipkkeX9Pz4GHyWfISA4Mg9qrVGSCNGYNROK5vWlng7/W4tw2i2sw1
   Tic7YnnuEDcfJUyiLpRHkStg+ZOgrqEsuTyt/TKklXrE2WHj+tCU/NKHw
   A9yqMUdVKiqRH4R7p6lf8pwEpmJRK4w1bgviNvncuhqxcC6fSoOzADrSt
   2+QAckyQe/R4cztUs5dLmiqZYU1ioFMP2R9dPNTUuGo5dCVPPOM4p6VXA
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="336197555"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="336197555"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 03:21:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="755837829"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by orsmga005.jf.intel.com with ESMTP; 01 Jun 2022 03:21:12 -0700
Date:   Wed, 1 Jun 2022 18:17:47 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Vishal Annapurve <vannapurve@google.com>
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
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jun Nakajima <jun.nakajima@intel.com>, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com
Subject: Re: [PATCH v6 3/8] mm/memfd: Introduce MFD_INACCESSIBLE flag
Message-ID: <20220601101747.GA1255243@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220519153713.819591-1-chao.p.peng@linux.intel.com>
 <20220519153713.819591-4-chao.p.peng@linux.intel.com>
 <CAGtprH8EMsPMMoOEzjRu0SMVKT0RqmkLk=n+6uXkBA6-wiRtUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGtprH8EMsPMMoOEzjRu0SMVKT0RqmkLk=n+6uXkBA6-wiRtUA@mail.gmail.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 31, 2022 at 12:15:00PM -0700, Vishal Annapurve wrote:
> On Thu, May 19, 2022 at 8:41 AM Chao Peng <chao.p.peng@linux.intel.com> wrote:
> >
> > Introduce a new memfd_create() flag indicating the content of the
> > created memfd is inaccessible from userspace through ordinary MMU
> > access (e.g., read/write/mmap). However, the file content can be
> > accessed via a different mechanism (e.g. KVM MMU) indirectly.
> >
> 
> SEV, TDX, pkvm and software-only VMs seem to have usecases to set up
> initial guest boot memory with the needed blobs.
> TDX already supports a KVM IOCTL to transfer contents to private
> memory using the TDX module but rest of the implementations will need
> to invent
> a way to do this.

There are some discussions in https://lkml.org/lkml/2022/5/9/1292
already. I somehow agree with Sean. TDX is using an dedicated ioctl to
copy guest boot memory to private fd so the rest can do that similarly.
The concern is the performance (extra memcpy) but it's trivial since the
initial guest payload is usually optimized in size.

> 
> Is there a plan to support a common implementation for either allowing
> initial write access from userspace to private fd or adding a KVM
> IOCTL to transfer contents to such a file,
> as part of this series through future revisions?

Indeed, adding pre-boot private memory populating on current design
isn't impossible, but there are still some opens, e.g. how to expose
private fd to userspace for access, pKVM and CC usages may have
different requirements. Before that's well-studied I would tend to not
add that and instead use an ioctl to copy. Whether we need a generic
ioctl or feature-specific ioctl, I don't have strong opinion here.
Current TDX uses a feature-specific ioctl so it's not covered in this
series.

Chao
> 
> Regards,
> Vishal
