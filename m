Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78887A3F2F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 03:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbjIRBXS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Sep 2023 21:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236990AbjIRBXM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Sep 2023 21:23:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C99A124;
        Sun, 17 Sep 2023 18:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695000187; x=1726536187;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=6EbWrAqaFv/oHwPa3uHaSjB2vXOYqABxuhluMCXJBeU=;
  b=VOEYMjEc+GF43u5sl6ky8S+gjFASjzsMp8R58sGjT/goZgWYcgEz7+il
   IXohIMpjWUnHBOHjaJEPo+6xya4nn8S1VgPia2EDRsbtpTlMdf2YUI4kl
   Ffajd5NVhLIgmuQCJ88PXLjpTmPrPy9GNeqpt58S9eqyxMKrHYOJ+KJid
   N0ShU5wgMpOP1zIcVd+RFefxqlNusFjZLfg3Pf1CG3Vd01ubi/4MjJG+F
   0ERAi3P+l8pgzMI8ZmOcCx+wGrUcdPJwKsn+hIwmGgHs5tn+qd/Eu9UMn
   hoEPhbdMHQ/FJUp/JuN/Ze0KpjnAQPvsdkvmkkJaNBMQYD3+qZCc9etDG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="378457085"
X-IronPort-AV: E=Sophos;i="6.02,155,1688454000"; 
   d="scan'208";a="378457085"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2023 18:23:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="780722719"
X-IronPort-AV: E=Sophos;i="6.02,155,1688454000"; 
   d="scan'208";a="780722719"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Sep 2023 18:23:05 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 17 Sep 2023 18:23:04 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 17 Sep 2023 18:23:04 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 17 Sep 2023 18:23:04 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 17 Sep 2023 18:23:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4lxWoZMRzAo59z1I2pLgOx3hN8lzTQUlvMzOM7K9OUhvudB00Qu/9HvqCF01lRRIFdsVZYY4bo2vYGAyqFY2JnT3Hp1bTWC37DE99k4emtDOJrGX8tczu6KpmKbc9BCONTtGewX269+ksZt40semzuXvnEC/lgn4eKQpVQ8aUidPgoMYo/p31pTas3eSXPWIpVJdbrQquQrQkbtV0GSwrcfbtDKDfNoYX+e5HUZZPKrBKA+supJxWF99rV/qLXh9yLR+MQAZEWKoDTRQDJtm1djuk2qzmdFSiGSOYcv4dqTXby1GbSKzv0XxdQHY9T4mwqIsYx89A4AcSChZB65Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ur7Su/Z1/S0UvJGlJ+MkSZAJR/Mdw50edtAS62R+TIo=;
 b=k6QX1ZS3kU/YiOJYmeT2AbpagbgPgVCgip9actldoQxQLS3Uhb9BVf8hLUs3I/2xOfp8Zd1rcj8PP//MlxYOAZJ8eX/DpeJf7P4SUhRkrbhbp2zuQnqrKPm8KovJ31tPVyfcc1ISYWq+DwrGFv2xPo4mEqIY6VUoslpzfXlG9jAE0nujlh1zJUVBM6M4oPxuAjGcgnzFGK5n92SSOgKZ+7b+TV014UQxoZ4tRx1rzqLtX6wwY/crBgkLcNuaXC6o2RLZySmU1npKh7CXTJta3R9cc88G0FB6Ntf3LeKosCl8sAnINhHKy52VWbsahhWCaTE3EzA+91kxrcgGHMpBKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 LV3PR11MB8529.namprd11.prod.outlook.com (2603:10b6:408:1b3::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.26; Mon, 18 Sep 2023 01:23:01 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::5e79:2d52:51e:f602]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::5e79:2d52:51e:f602%6]) with mapi id 15.20.6792.024; Mon, 18 Sep 2023
 01:23:01 +0000
Date:   Mon, 18 Sep 2023 08:54:55 +0800
From:   Yan Zhao <yan.y.zhao@intel.com>
To:     Sean Christopherson <seanjc@google.com>
CC:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, <kvm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
        <linux-mips@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <kvm-riscv@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Anish Moorthy <amoorthy@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        "Liam Merwick" <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [RFC PATCH v12 18/33] KVM: x86/mmu: Handle page fault for
 private memory
Message-ID: <ZQef3zAEYjZMkn9k@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20230914015531.1419405-1-seanjc@google.com>
 <20230914015531.1419405-19-seanjc@google.com>
 <ZQPuMK6D/7UzDH+D@yzhao56-desk.sh.intel.com>
 <ZQRpiOd1DNDDJQ3r@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZQRpiOd1DNDDJQ3r@google.com>
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|LV3PR11MB8529:EE_
X-MS-Office365-Filtering-Correlation-Id: bef82a8b-4508-4e7d-100d-08dbb7e5cbca
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GZxw9XyHnvNfIg4V0xpSa90vulloD9GcHC30G1Pw4rK3AUp1NRWTn5y1psz16m6Xh0yVXYUN7RDdbZ+hoV4XCEVwXJScoqGutuzZ5YzCFx48WmwGwGaLybzjZQ07kNE3TggRY4kw3uNShmRsjCB6WcZXOt3CaxU81WtdmMMKk6y4Mu5pNPVIe+1erm2urVM1ZyPXkTSAgKRHNBjvWJcr3wXpWuWIgfRgNqzB7bP17BgSY2ZVU53gbUwIzw2Q1hqVHXeqOttx+VoHQnVaoLLJZ18qqL1/MzG37wwjWs9bBtb92t2UYNSiO/ovuqWUQ0spY6/Y7dpRpOhKjSmhzaYKI6gjO/bnLUCZb0je/vKQYSzyiMHyzx13aI6nNCehFizXVw+aEy4ukTVv+bdmi3vvPHPjEQx2KBvj2yuM6d1g4HtjEJWg2p59LcUfPLU2tgvexeUoy98urVFXh0BQldeoZBaAlFAS3Np1fV2TJFJn3k8ZIFSCM8SvresZfG+iSLzgqlLUhiiCxa8PG51n43VjT66WWfZCK5TXa1Urt9e/S1Z7UzE+g8k9nf0d+prm0p/Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39850400004)(396003)(136003)(346002)(366004)(186009)(1800799009)(451199024)(478600001)(66476007)(6916009)(54906003)(316002)(66946007)(66556008)(6506007)(26005)(6486002)(6512007)(6666004)(8936002)(8676002)(41300700001)(7416002)(7406005)(5660300002)(2906002)(4326008)(3450700001)(38100700002)(82960400001)(86362001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+QC4LkLcreg4ZiO8oKZsUBSIAB3DK50h5w8kyIS8oDZ5L6oRmkpsZ6uGBagA?=
 =?us-ascii?Q?Htgj33E49Bvr/fWfSYMLNIJVnzwWNRu6lt8KmuBxfHg1+OGAcpqUBOjSwMT9?=
 =?us-ascii?Q?J5RiEdOZHc+HD1vo3+N1STPQPVSqeXfiyvN9ePFhCmVtJN/mL7cd5TzxMnkd?=
 =?us-ascii?Q?BpE0AP7ZZqjlD3mRCE/JPBYbTIfkFsZnzCkihlUR3ohS4aFhrpL16/GB6N4/?=
 =?us-ascii?Q?JTs1x/MzR7WG9RmD+eA+2YbPK91cA1PJ/MpnODua/dBAYlkFmKgfcqo9udcN?=
 =?us-ascii?Q?S2YFarnz9ZRKzz2vVc+4wuOvjIiGpV3VHhwOgg6BBNAEzb7NaYiKwdBud/h4?=
 =?us-ascii?Q?NHnjDcbWl9ZYBlORS7KDRjtwraieDcGk+jTHeAaPrSTAwjI9pl2yxgkTExRp?=
 =?us-ascii?Q?J19vr6+qSFwMmmJcEfOBk+8b6ItzuF7gU3arbmmc0GUz/AwIKHZNbDaYgYRd?=
 =?us-ascii?Q?SwbjPV0NsOGHO0Oywr0W6nksTLg2wZeCrg/ic2Z+Up8S8s+oFSq2t/D0SE8J?=
 =?us-ascii?Q?XlUt2BpflFhLcO52+VfrYno66dvD9HvhwVobPSVH60xOpvdOrj0Z7Y+Rhqow?=
 =?us-ascii?Q?XZnOphonStxah3V7SXZEgDMSBT1V3dVgbOafMkvNgovXXZXSzRCWaonngOyl?=
 =?us-ascii?Q?mvy+zkmHC7No1lLPilhos7sTp2oC/31F3XNxUHS0KM5RfpyinTRqV0oarC4r?=
 =?us-ascii?Q?L+fzuIw8YRX6wkBFEbqzqnMqhypC34rbHUlC4XVBZFLGEgCQTVc2xPpBtHou?=
 =?us-ascii?Q?Wb/bTY0oqLzU/lUgsVkzIXZtv+z4KCBOrTpfQ7JEzbs9NBBP5Wz6qd5rH5uD?=
 =?us-ascii?Q?tpI7ESebV9jzaJBT8q8GCfykL9LoIDZawx+FGQij45abNHDZVYIxRdjMu8BX?=
 =?us-ascii?Q?vyVh8BFwVF1+F5QINLZU8jeSOnSdaA/ZRoz/2qyjlR0P419mqvewsNqSas8g?=
 =?us-ascii?Q?OEtEehOMirrIa46yE0JZmTznT/1UOoKAwWgP13gAiaHiX005TAR9zY+YYT6x?=
 =?us-ascii?Q?KUGnGU2Sp/Q1FrWJ26lIqHR71ieEPfVl+PdHnN3eRynxCYX5N22ieneMcFNS?=
 =?us-ascii?Q?sqq2Uba8I8TzECItrY9TKxKWA83oU1KlMihP8tjvI393y6ela0gzuolkO/zo?=
 =?us-ascii?Q?fJUe5dQfg5tCFwc33T9DZjNjzomBoFrMZw7pRI5iUFERScaGbvvqDpVBp8G3?=
 =?us-ascii?Q?LMbYSQPuE++1toe2Astb3QOAY4upFR5HVJxIermEr63HR3yjBlsLIe5XRsTq?=
 =?us-ascii?Q?ozqzFpdTvvcNkCewLJCg3QW4MRRzW73itY0RDaOtG6aQyke2r3Z1iie7HUYH?=
 =?us-ascii?Q?n8+kW5zTok+ClZm8Xk2Xx6bdlfxgDMVD+CDA2rtGzjXZVzjJzT0xiUN4PHWu?=
 =?us-ascii?Q?folYGbFtU8vB+oZ09iU/NHKy33Dc07am9LdgztlQMbZAgr1MixN6sJfin9PD?=
 =?us-ascii?Q?zSkEW/bCTtNLDQ4rWtvL1HIE2yVH6PN+PSCe2N2IiQiQz8/TGEQ04WY3ts3L?=
 =?us-ascii?Q?zxwGATpFJPp6fyd2szMQIcAeOeyojmMH4bQUYSCeYV4Ocu94qwOKprLdGqRj?=
 =?us-ascii?Q?Be9OHBH+r7cTaQwMZHWurNzQxfohkAnrJS6zucCj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bef82a8b-4508-4e7d-100d-08dbb7e5cbca
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 01:22:59.9211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RGUJS95eCjqGyaHpC1kPLEmwQl1il+Ri5x/Lf061Du/Wdw2FNu22cj+zYJ/uHmeOZDW0s7WR0Jxjl66m0PIz0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8529
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 15, 2023 at 07:26:16AM -0700, Sean Christopherson wrote:
> On Fri, Sep 15, 2023, Yan Zhao wrote:
> > On Wed, Sep 13, 2023 at 06:55:16PM -0700, Sean Christopherson wrote:
> > ....
> > > +static void kvm_mmu_prepare_memory_fault_exit(struct kvm_vcpu *vcpu,
> > > +					      struct kvm_page_fault *fault)
> > > +{
> > > +	kvm_prepare_memory_fault_exit(vcpu, fault->gfn << PAGE_SHIFT,
> > > +				      PAGE_SIZE, fault->write, fault->exec,
> > > +				      fault->is_private);
> > > +}
> > > +
> > > +static int kvm_faultin_pfn_private(struct kvm_vcpu *vcpu,
> > > +				   struct kvm_page_fault *fault)
> > > +{
> > > +	int max_order, r;
> > > +
> > > +	if (!kvm_slot_can_be_private(fault->slot)) {
> > > +		kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
> > > +		return -EFAULT;
> > > +	}
> > > +
> > > +	r = kvm_gmem_get_pfn(vcpu->kvm, fault->slot, fault->gfn, &fault->pfn,
> > > +			     &max_order);
> > > +	if (r) {
> > > +		kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
> > > +		return r;
> > > +	}
> > > +
> > > +	fault->max_level = min(kvm_max_level_for_order(max_order),
> > > +			       fault->max_level);
> > > +	fault->map_writable = !(fault->slot->flags & KVM_MEM_READONLY);
> > > +
> > > +	return RET_PF_CONTINUE;
> > > +}
> > > +
> > >  static int __kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
> > >  {
> > >  	struct kvm_memory_slot *slot = fault->slot;
> > > @@ -4293,6 +4356,14 @@ static int __kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
> > >  			return RET_PF_EMULATE;
> > >  	}
> > >  
> > > +	if (fault->is_private != kvm_mem_is_private(vcpu->kvm, fault->gfn)) {
> > In patch 21,
> > fault->is_private is set as:
> > 	".is_private = kvm_mem_is_private(vcpu->kvm, cr2_or_gpa >> PAGE_SHIFT)",
> > then, the inequality here means memory attribute has been updated after
> > last check.
> > So, why an exit to user space for converting is required instead of a mere retry?
> > 
> > Or, is it because how .is_private is assigned in patch 21 is subjected to change
> > in future? 
> 
> This.  Retrying on SNP or TDX would hang the guest.  I suppose we could special
Is this because if the guest access a page in private way (e.g. via
private key in TDX), the returned page must be a private page?

> case VMs where .is_private is derived from the memory attributes, but the
> SW_PROTECTED_VM type is primary a development vehicle at this point.  I'd like to
> have it mimic SNP/TDX as much as possible; performance is a secondary concern.
Ok. But this mimic is somewhat confusing as it may be problematic in below scenario,
though sane guest should ensure no one is accessing a page before doing memory
conversion.


CPU 0                           CPU 1
access GFN A in private way
fault->is_private=true
                                convert GFN A to shared
			        set memory attribute of A to shared

faultin, mismatch and exit
set memory attribute of A
to private

                                vCPU access GFN A in shared way
                                fault->is_private = true
                                faultin, match and map a private PFN B

                                vCPU accesses private PFN B in shared way

> 
> E.g. userspace needs to be prepared for "spurious" exits due to races on SNP and
> TDX, which this can theoretically exercise.  Though the window is quite small so
> I doubt that'll actually happen in practice; which of course also makes it less
> important to retry instead of exiting.
