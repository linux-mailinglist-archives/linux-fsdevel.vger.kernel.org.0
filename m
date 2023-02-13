Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CBC6946A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Feb 2023 14:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjBMNL0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Feb 2023 08:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjBMNLV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Feb 2023 08:11:21 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2082.outbound.protection.outlook.com [40.107.101.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706811ADDA;
        Mon, 13 Feb 2023 05:11:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wj5Va6nMnqK14OX2dnxQZG/lhuVTJSk0nURph/VyOJLAL0lbyUGWYHEpoODqbr9jA9AoV4qCzUeFtd4S5d9Pqpi1oPgaIAWnzKPupqY9lOQDxgxO5i7P88EEQbHiIc00vDtKqVhui/hInBo7oD33czr9oeL+FYuARrBtQlE4KFiChJTu6zfWG19QwWp3BWrEmmkd4ldHEqDKtclSW20t6AoCaY6TpetGo/pGF3ERkE4JGGeyTQrFGti7YG3LayWIXSUc/tGDPX5phDmUW1mQs/Vp7q+PtTwW9Hg9yz7YA+Ho4H16xCAuf9HfjWnbgXMc9pNFG2gRdrKP6F8oT7xjZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ENVP1GGBPj1xqietufnO2P2Fn2qUANJ0PPZBR999UM=;
 b=Lb0z4i8D8TvgbhpE6yFTRzFTkIt6f6yntLbDkTYFJfGLjkivaFzeXBFfLeYbklYVRo8/tAJ+EhEgKon6HG3kgh7WdDHEF1gTWEPn3oJzYzIHqAcj2pNspVMVfYmIQB/wCcVw8oPMDvcQKlJ+4eiZ6QMyvIOF7KgI7ZLOBW7Xa3dFYIHIpOnewIWesqB07ndbuKOonMhO/K6bxRMIOmCYI7vGh4X3aOBN8UYN77eEYrjTa2ZWZ0Xp00aOTJc7ZTt8y3GHnjXxnUJvl1vayJBKPWUTei4hqA/ZJE4ew0kXlAzoAoKLKICT8NxlotDAPqUrs+RGe0iDFzplRyVxor83bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ENVP1GGBPj1xqietufnO2P2Fn2qUANJ0PPZBR999UM=;
 b=pgBZBMnzg1xuWq9+hkCzJ1g7x/OQ0/CvsAJisZad9nedqaW++CLtEYzz7H3tqYlwqx9lrVAaoXSgVaWsFUlTIQu7VJajap8WdGButgQrMQQV955wHOon32GxW+m2ZhEwpGJc4NzAmwoQjH8Dpn5vIsg6xeK72iRl69na8eTWqHk=
Received: from MW4PR03CA0106.namprd03.prod.outlook.com (2603:10b6:303:b7::21)
 by PH8PR12MB6748.namprd12.prod.outlook.com (2603:10b6:510:1c4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Mon, 13 Feb
 2023 13:11:13 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::35) by MW4PR03CA0106.outlook.office365.com
 (2603:10b6:303:b7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24 via Frontend
 Transport; Mon, 13 Feb 2023 13:11:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.24 via Frontend Transport; Mon, 13 Feb 2023 13:11:12 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 13 Feb
 2023 07:11:11 -0600
Date:   Mon, 13 Feb 2023 07:01:02 -0600
From:   Michael Roth <michael.roth@amd.com>
To:     Sean Christopherson <seanjc@google.com>
CC:     Isaku Yamahata <isaku.yamahata@gmail.com>,
        Chao Peng <chao.p.peng@linux.intel.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-api@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, <x86@kernel.org>,
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
        <luto@kernel.org>, <jun.nakajima@intel.com>,
        <dave.hansen@intel.com>, <ak@linux.intel.com>, <david@redhat.com>,
        <aarcange@redhat.com>, <ddutile@redhat.com>, <dhildenb@redhat.com>,
        Quentin Perret <qperret@google.com>, <tabba@google.com>,
        <mhocko@suse.com>, <wei.w.wang@intel.com>
Subject: Re: [PATCH v10 0/9] KVM: mm: fd-based approach for supporting KVM
Message-ID: <20230213130102.two7q3kkcf254uof@amd.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <Y8H5Z3e4hZkFxAVS@google.com>
 <20230119111308.GC2976263@ls.amr.corp.intel.com>
 <Y8lg1G2lRIrI/hld@google.com>
 <20230119223704.GD2976263@ls.amr.corp.intel.com>
 <Y880FiYF7YCtsw/i@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y880FiYF7YCtsw/i@google.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT040:EE_|PH8PR12MB6748:EE_
X-MS-Office365-Filtering-Correlation-Id: 43a8f9a3-32a8-46b7-e39a-08db0dc3c810
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jbNd5Iv+nMb/kEsrf0a8am47WtZl2VEdW+ysLc0RZ7wgpegcD+SSGtuIQXPlQNvo9ZBd/oyhw/8GDy7NVP36VWmLk2SlhGtIP7ekYWgAYC6ztrMz0e/1CbALYRSHZ4ZzXtXayQqdSzNq8j/2jSRPF3C3+FGYGYc7WY4ufKEv0thC3Ov9WXO/wqvFRBTUVR5eXIA5jNnibeghjNCZK/jDyirnqeFVt3tiP03TZD/neroEJCrx0kwMy/h2c39XjF5zp5bTFRuKXFJkwM6FCr5z4sjdMNLYeRfcR+7UvLpoUz2ElJd05/vrYi7wtujUoeqopScUGMPFqXWnLJ0I27HjcPUXSFnGRDN5A+MrYchK1n9aoUh0jqFbejQOXIRPVZ8I/HMaheZfCcgZy8bu7rBKuZBrN3PJXGVeoSRxL/Q3H3H8MFl22pWCWwitHLU0Mt9Bv5ONkDAPOygw49ebzKA5vzJL/Mrtmz2courqHRxGHCFNguSmC+fgBG5E2Lk+b4GUDqvIW2XU+JKf9fP4CwzR9Ah6acFp9gtsGyvoFJ9ZBv5PTJrQcnBhhpl5TKLlwsBEj1A/7VH/thUzdNWlB7QrV4mHgtZqbAKA5MMBZ/GGTD5nLGq4Bpb+0Iu/YVjMY3cu+2QN7nBwPblqQukKzNjZmMBXsTrbF3VDpu5A2fMdn+bkRRuq7pUOsg3EWSVLw13ppaUdwwP7hyiiUFymRAJb77VNxzesS9WvS+HUrVZ3fb/zFVHw5PnLfWdlCHc+0KSJH3eM0Ab6y4pd6JZ+FCkbgg2Y7z2fgSMK5ZEs3HgOniocdlmBICt30Cv7PU9yGrhF
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(396003)(346002)(376002)(451199018)(40470700004)(36840700001)(46966006)(40480700001)(70206006)(2616005)(70586007)(966005)(6666004)(8676002)(86362001)(36756003)(6916009)(54906003)(426003)(47076005)(316002)(83380400001)(40460700003)(478600001)(4326008)(82310400005)(16526019)(66899018)(186003)(356005)(2906002)(26005)(82740400003)(81166007)(1076003)(336012)(41300700001)(7406005)(44832011)(8936002)(7416002)(5660300002)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 13:11:12.7672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a8f9a3-32a8-46b7-e39a-08db0dc3c810
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6748
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 24, 2023 at 01:27:50AM +0000, Sean Christopherson wrote:
> On Thu, Jan 19, 2023, Isaku Yamahata wrote:
> > On Thu, Jan 19, 2023 at 03:25:08PM +0000,
> > Sean Christopherson <seanjc@google.com> wrote:
> > 
> > > On Thu, Jan 19, 2023, Isaku Yamahata wrote:
> > > > On Sat, Jan 14, 2023 at 12:37:59AM +0000,
> > > > Sean Christopherson <seanjc@google.com> wrote:
> > > > 
> > > > > On Fri, Dec 02, 2022, Chao Peng wrote:
> > > > > > This patch series implements KVM guest private memory for confidential
> > > > > > computing scenarios like Intel TDX[1]. If a TDX host accesses
> > > > > > TDX-protected guest memory, machine check can happen which can further
> > > > > > crash the running host system, this is terrible for multi-tenant
> > > > > > configurations. The host accesses include those from KVM userspace like
> > > > > > QEMU. This series addresses KVM userspace induced crash by introducing
> > > > > > new mm and KVM interfaces so KVM userspace can still manage guest memory
> > > > > > via a fd-based approach, but it can never access the guest memory
> > > > > > content.
> > > > > > 
> > > > > > The patch series touches both core mm and KVM code. I appreciate
> > > > > > Andrew/Hugh and Paolo/Sean can review and pick these patches. Any other
> > > > > > reviews are always welcome.
> > > > > >   - 01: mm change, target for mm tree
> > > > > >   - 02-09: KVM change, target for KVM tree
> > > > > 
> > > > > A version with all of my feedback, plus reworked versions of Vishal's selftest,
> > > > > is available here:
> > > > > 
> > > > >   git@github.com:sean-jc/linux.git x86/upm_base_support
> > > > > 
> > > > > It compiles and passes the selftest, but it's otherwise barely tested.  There are
> > > > > a few todos (2 I think?) and many of the commits need changelogs, i.e. it's still
> > > > > a WIP.
> > > > > 
> > > > > As for next steps, can you (handwaving all of the TDX folks) take a look at what
> > > > > I pushed and see if there's anything horrifically broken, and that it still works
> > > > > for TDX?
> > > > > 
> > > > > Fuad (and pKVM folks) same ask for you with respect to pKVM.  Absolutely no rush
> > > > > (and I mean that).
> > > > > 
> > > > > On my side, the two things on my mind are (a) tests and (b) downstream dependencies
> > > > > (SEV and TDX).  For tests, I want to build a lists of tests that are required for
> > > > > merging so that the criteria for merging are clear, and so that if the list is large
> > > > > (haven't thought much yet), the work of writing and running tests can be distributed.
> > > > > 
> > > > > Regarding downstream dependencies, before this lands, I want to pull in all the
> > > > > TDX and SNP series and see how everything fits together.  Specifically, I want to
> > > > > make sure that we don't end up with a uAPI that necessitates ugly code, and that we
> > > > > don't miss an opportunity to make things simpler.  The patches in the SNP series to
> > > > > add "legacy" SEV support for UPM in particular made me slightly rethink some minor
> > > > > details.  Nothing remotely major, but something that needs attention since it'll
> > > > > be uAPI.
> > > > 
> > > > Although I'm still debuging with TDX KVM, I needed the following.
> > > > kvm_faultin_pfn() is called without mmu_lock held.  the race to change
> > > > private/shared is handled by mmu_seq.  Maybe dedicated function only for
> > > > kvm_faultin_pfn().
> > > 
> > > Gah, you're not on the other thread where this was discussed[*].  Simply deleting
> > > the lockdep assertion is safe, for guest types that rely on the attributes to
> > > define shared vs. private, KVM rechecks the attributes under the protection of
> > > mmu_seq.
> > > 
> > > I'll get a fixed version pushed out today.
> > > 
> > > [*] https://lore.kernel.org/all/Y8gpl+LwSuSgBFks@google.com
> > 
> > Now I have tdx kvm working. I've uploaded at the followings.
> > It's rebased to v6.2-rc3.
> >         git@github.com:yamahata/linux.git tdx/upm
> >         git@github.com:yamahata/qemu.git tdx/upm
> 
> And I finally got a working, building version updated and pushed out (again to):
> 
>   git@github.com:sean-jc/linux.git x86/upm_base_support
> 
> Took longer than expected to get the memslot restrictions sussed out.  I'm done
> working on the code for now, my plan is to come back to it+TDX+SNP in 2-3 weeks
> to resolves any remaining todos (that no one else tackles) and to do the whole
> "merge the world" excersise.
> 
> > kvm_mmu_do_page_fault() needs the following change.
> > kvm_mem_is_private() queries mem_attr_array.  kvm_faultin_pfn() also uses
> > kvm_mem_is_private(). So the shared-private check in kvm_faultin_pfn() doesn't
> > make sense. This change would belong to TDX KVM patches, though.
> 
> Yeah, SNP needs similar treatment.  Sorting that out is high up on the todo list.

Hi Sean,

We've rebased the SEV+SNP support onto your updated UPM base support
tree and things seem to be working okay, but we needed some fixups on
top of the base support get things working, along with 1 workaround
for an issue that hasn't been root-caused yet:

  https://github.com/mdroth/linux/commits/upmv10b-host-snp-v8-wip

  *stash (upm_base_support): mm: restrictedmem: Kirill's pinning implementation
  *workaround (use_base_support): mm: restrictedmem: loosen exclusivity check
  *fixup (upm_base_support): KVM: use inclusive ranges for restrictedmem binding/unbinding
  *fixup (upm_base_support): mm: restrictedmem: use inclusive ranges for issuing invalidations
  *fixup (upm_base_support): KVM: fix restrictedmem GFN range calculations
  *fixup (upm_base_support): KVM: selftests: CoCo compilation fixes

We plan to post an updated RFC for v8 soon, but also wanted to share
the staging tree in case you end up looking at the UPM integration aspects
before then.

-Mike
