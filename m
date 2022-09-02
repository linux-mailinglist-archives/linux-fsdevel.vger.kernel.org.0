Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C6C5AAC50
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Sep 2022 12:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbiIBKYE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Sep 2022 06:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235774AbiIBKYA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Sep 2022 06:24:00 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906EEA59BB;
        Fri,  2 Sep 2022 03:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662114239; x=1693650239;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Hmx1025FThlE9cx1UE6O8SOkWc9A3kuNYU7VIFp8RZU=;
  b=XR6Jo7eI3TzsF+IKEmbfQSCLKck4Va6LEtBgyhUMbLFoNshpbJiSwMP9
   VFkNlhMpCdVqqXxekXgm8ThCF0Aq09DU/ZkxlNOEEG5TWyptfRBUM1j8N
   E/6zGz+F4umYT+B2GSKud+KLz03kNp6WNpXKkDdP9SFATzzms3Py4IZ3o
   UiCrMvyUnkIFRfRHSBR5n8AvJQTZp2wurRSD83Gg04mId+CCSORv87rAB
   zXBf+jLuVvGyMVf64L2MwIyqVVhFmXnCAxxbdDKkqiizgX91MmqAV4BmW
   wh4fEtGVdAbGvk2M0/LfQbwSz/DnUVEurh7Csmm6g8GV0cKx/EuPq0xka
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="322109916"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="322109916"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 03:23:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="608943940"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by orsmga007.jf.intel.com with ESMTP; 02 Sep 2022 03:23:46 -0700
Date:   Fri, 2 Sep 2022 18:19:05 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Fuad Tabba <tabba@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, linux-kselftest@vger.kernel.org,
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
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Message-ID: <20220902101905.GA1712673@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <CA+EHjTy6NF=BkCqK0vhXLdtKZMahp55JUMSfxN96-NT3YiMXYQ@mail.gmail.com>
 <20220829151756.GB1586678@chaop.bj.intel.com>
 <CA+EHjTxgKJ=9UP=DWtNsSgD2FtvBMYrUbcS=9h5j8Tmk57WqxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+EHjTxgKJ=9UP=DWtNsSgD2FtvBMYrUbcS=9h5j8Tmk57WqxQ@mail.gmail.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 31, 2022 at 10:12:12AM +0100, Fuad Tabba wrote:
> > > Moreover, something which was discussed here before [3], is the
> > > ability to share in-place. For pKVM/arm64, the conversion between
> > > shared and private involves only changes to the stage-2 page tables,
> > > which are controlled by the hypervisor. Android supports this in-place
> > > conversion already, and I think that the cost of copying for many
> > > use-cases that would involve large amounts of data would be big. We
> > > will measure the relative costs in due course, but in the meantime
> > > we¡¯re nervous about adopting a new user ABI which doesn¡¯t appear to
> > > cater for in-place conversion; having just the fd would simplify that
> > > somewhat
> >
> > I understand there is difficulty to achieve that with the current
> > private_fd + userspace_addr (they basically in two separate fds), but is
> > it possible for pKVM to extend this? Brainstorming for example, pKVM can
> > ignore userspace_addr and only use private_fd to cover both shared and
> > private memory, or pKVM introduce new KVM memslot flag?
> 
> It's not that there's anything blocking pKVM from doing that. It's
> that the disconnect of using a memory address for the shared memory,
> and a file descriptor for the private memory doesn't really make sense
> for pKVM. I see how it makes sense for TDX and the Intel-specific
> implementation. It just seems that this is baking in an
> implementation-specific aspect as a part of the KVM general api, and
> the worry is that this might have some unintended consequences in the
> future.

It's true this API originates from supporting TDX and probably other
similar confidential computing(CC) technologies. But if we ever get
chance to make it more common to cover more usages like pKVM, I would
also like to. The challenge on this point is pKVM diverges a lot from CC
usages, putting both shared and private memory in the same fd
complicates CC usages. If two things are different enough, I'm also
thinking implementation-specific may not be that bad.

Chao
