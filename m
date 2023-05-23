Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5E870E506
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 21:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237960AbjEWTAV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 15:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjEWTAQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 15:00:16 -0400
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5F791;
        Tue, 23 May 2023 12:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1684868415; x=1716404415;
  h=mime-version:content-transfer-encoding:date:cc:subject:
   from:to:message-id:references:in-reply-to;
  bh=2f6hgtyoF3npyINkvFYDynw82+STAB4fWRrWAyFHWQA=;
  b=rFrsHxEx4TA20pUdS17YN6UMkg+qfoSFBqBw8KE/INYT7NkhhhV5iWwV
   5T27Bh8pxrQjY/iu0XsMxq0C8VqNzfepjssPX/1G2hHoH5J5W08I3J4uF
   kpU4FR/qKo1bBZIEXdhuPI4BGSN3koysLpldGLa7iF483sjtn0BAB2T4J
   E=;
X-IronPort-AV: E=Sophos;i="6.00,187,1681171200"; 
   d="scan'208";a="564743059"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-1box-2bm6-32cf6363.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 19:00:09 +0000
Received: from EX19D004EUC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-1box-2bm6-32cf6363.us-west-2.amazon.com (Postfix) with ESMTPS id 98D7A80457;
        Tue, 23 May 2023 19:00:05 +0000 (UTC)
Received: from localhost (10.13.235.138) by EX19D004EUC001.ant.amazon.com
 (10.252.51.190) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Tue, 23 May
 2023 18:59:51 +0000
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date:   Tue, 23 May 2023 18:59:47 +0000
CC:     Chao Peng <chao.p.peng@linux.intel.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-api@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <qemu-devel@nongnu.org>, <graf@amazon.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Vitaly Kuznetsov" <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "Naoya Horiguchi" <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Shuah Khan" <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Vishal Annapurve" <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        <luto@kernel.org>, <jun.nakajima@intel.com>,
        <dave.hansen@intel.com>, <ak@linux.intel.com>, <david@redhat.com>,
        <aarcange@redhat.com>, <ddutile@redhat.com>, <dhildenb@redhat.com>,
        Quentin Perret <qperret@google.com>, <tabba@google.com>,
        Michael Roth <michael.roth@amd.com>, <mhocko@suse.com>,
        <wei.w.wang@intel.com>, <anelkz@amazon.de>
Subject: Re: [PATCH v10 2/9] KVM: Introduce per-page memory attributes
From:   Nicolas Saenz Julienne <nsaenz@amazon.com>
To:     Sean Christopherson <seanjc@google.com>
Message-ID: <CSTLMGOZVEV7.3B9QXJ2STLLLF@dev-dsk-nsaenz-1b-189b39ae.eu-west-1.amazon.com>
X-Mailer: aerc 0.15.2-21-g30c1a30168df-dirty
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-3-chao.p.peng@linux.intel.com>
 <CSQFE7I30W27.2TPDIHOTZNRIZ@dev-dsk-nsaenz-1b-189b39ae.eu-west-1.amazon.com> <ZGe+m+uFzpiW7wlr@google.com>
In-Reply-To: <ZGe+m+uFzpiW7wlr@google.com>
X-Originating-IP: [10.13.235.138]
X-ClientProxiedBy: EX19D032UWA004.ant.amazon.com (10.13.139.56) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Sean,

On Fri May 19, 2023 at 6:23 PM UTC, Sean Christopherson wrote:
> On Fri, May 19, 2023, Nicolas Saenz Julienne wrote:
> > Hi,
> > On Fri Dec 2, 2022 at 6:13 AM UTC, Chao Peng wrote:

[...]

> > VSM introduces isolated guest execution contexts called Virtual Trust
> > Levels (VTL) [2]. Each VTL has its own memory access protections,
> > virtual processors states, interrupt controllers and overlay pages. VTL=
s
> > are hierarchical and might enforce memory protections on less privilege=
d
> > VTLs. Memory protections are enforced on a per-GPA granularity.
> >
> > We implemented this in the past by using a separate address space per
> > VTL and updating memory regions on protection changes. But having to
> > update the memory slot layout for every permission change scales poorly=
,
> > especially as we have to perform 100.000s of these operations at boot
> > (see [1] for a little more context).
> >
> > I believe the biggest barrier for us to use memory attributes is not
> > having the ability to target specific address spaces, or to the very
> > least having some mechanism to maintain multiple independent layers of
> > attributes.
>
> Can you elaborate on "specific address spaces"?  In KVM, that usually mea=
ns SMM,
> but the VTL comment above makes me think you're talking about something e=
ntirely
> different.  E.g. can you provide a brief summary of the requirements/expe=
ctations?

Let me refresh some concepts first. VTLs are vCPU modes implemented by
the hypervisor. Lower VTLs switch into higher VTLs [1] through a
hypercall or asynchronously through interrupts. Each VTL has its own CPU
architectural state, lapic and MSR state (applies to only some MSRs).
These are saved/restored when switching VTLS [2]. Additionally, VTLs
share a common GPA->HPA mapping, but protection bits differ depending on
which VTL the CPU is on. Privileged VTLs might revoke R/W/X(+MBEC,
optional) access bits from lower VTLs on a per-GPA basis.

In order to deal with the per-VTL memory protection bits, we extended
the number of KVM address spaces and assigned one to each VTL. The
hypervisor initializes all VTLs address spaces with the same mappings
and protections, they are expected to diverge during runtime. Operations
that rely on memory slots for GPA->HPA/HVA translations (including page
faults) are already address space aware, so adding VTL support was
fairly simple.

Ultimately, when a privileged VTL enforces memory protections on lower
VTLs we update that VTL's address space memory regions to reflect them.
Protection changes are requested through a hypercall, which expects the
new protection to be visible system wide upon returning from it. These
hypercalls happen around 100000+ times during boot, so we introduced an
"atomic memory slot update" API similar to Emanuele's [3] that allows
splitting memory regions/changing permissions concurrent with other
vCPUs.

Now, if we had a way to map memory attributes to specific VTLs, we could
use that instead. Actually, we wouldn't need to extend address spaces at
all to support this (we might still need them to support Overlay Pages,
but that's another story).

Hope it makes a little more sense now. :)

Nicolas

[1] In practice we've only seen VTL0 and VTL1 being used. The spec
    supports up to 16 VTLs.

[2] One can draw an analogy with arm's TrustZone. The hypervisor plays
    the role of EL3. Windows (VTL0) runs in Non-Secure (EL0/EL1) and the
    secure kernel (VTL1) in Secure World (EL1s/EL0s).

[3] https://lore.kernel.org/all/20220909104506.738478-1-eesposit@redhat.com=
/
