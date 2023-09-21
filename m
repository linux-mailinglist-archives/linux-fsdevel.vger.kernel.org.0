Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16EF47A90AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 03:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjIUBtc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 21:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjIUBtb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 21:49:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCDDCF;
        Wed, 20 Sep 2023 18:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695260965; x=1726796965;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=ybsMtUIUFSJoctpzBY42mYJCdPhjUqrVHUheuTnnJAM=;
  b=NmudNnXXIHMsrQldTM4AvrOzP8MzJlO2D5XHb06QLXMu8Sgyh8BsZO09
   U3IdUFozBmGU70fXqMZkpKYgBW4gY11zbz7/wrwgZkFlFBxCQ5BekoBLF
   bvw+vCEMLJC8lsrFqZ3+RdnKRxdRez17FRAbtibXXMG0pHLqQYxhRATk8
   VP3jqIzFJfBlz/o9qjuFhnYaHHihc4OLXQPRip4YPjuNu2ixG7/gZvv3v
   mGUsDIh1A8DW0fiERT6FZh6P2QB3icRjkh4j1/eR6Em7fq1CudIzvud9y
   kfFNxHqXHo/73Aa6zVUNaClQFs4/u1bQLG9AZ9BivNuXuT3MhBQ0wI77p
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="377688672"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="377688672"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 18:49:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="817156551"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="817156551"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Sep 2023 18:49:21 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 18:49:21 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 18:49:20 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 20 Sep 2023 18:49:20 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 20 Sep 2023 18:49:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2lMf+RO2hmnHO+BX1hxkmC0zEJY+HEZMp1ZDkHQMd1fySEq7fj2KPa2WBo37jb+JeEnTaRvDXVkBsHwbRHg3A8rL7MrFOpyd9h8ILOC49pMfZYFkh/swdikMrJAvsdpKoyMTpmPrcIfpGEWuZh+QiaP0CLwl3zfp7Nd8ekPy0/lBoTGj17KwQHghyyODi9Fx5ygXMzH0fYvjhjR1FWJ/h6rXMwiBGdzWOp0H/L5/MgCw/hbFBCVTJWOq5LHoznsz2GId7gII4Wo/4d+glkYUxkmKCL5oZogSAhP0d7zEjIVVvJIQ/we8Gq08kiyp2dwBcJGpUZOaJQkSunTVsRH8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3aC1OVXl10q8xdpDYGn6D2IOakpCQbxwk421apnZV0=;
 b=NXbrtwktsjRY3IZ56Pi4e9LF9RQQAgLBK3Bh6lPFdgBE5Az/YFAxAa9x8neSdq6HmeYhbqVn8+mRzxn4IeDAwYopzqiTfVZB3l7REkkLQce0rKWVuQv0LgCK0CYqfOZg8jYPP+++L/Qn3hRIb7BxRPV2lm1LYQpt58JkSRz7GSEZmFQByQ8lIQ9mAO9qGmEE8IMC9NkCvAi0SqBKowzhrRcL+gfSBAJx2d8Q/KVi+TaGYWrou2zUddamPmfLH0/zoN2EUP27mrRgqwHnNsBAiV5j6uCW7iOA8YdrIucmdCjurtYReMBJqHiY91pY58qFjaQajtHgGVtEzUDtk1ACnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 IA0PR11MB7840.namprd11.prod.outlook.com (2603:10b6:208:403::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Thu, 21 Sep
 2023 01:49:15 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::5e79:2d52:51e:f602]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::5e79:2d52:51e:f602%6]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 01:49:15 +0000
Date:   Thu, 21 Sep 2023 09:21:09 +0800
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
Subject: Re: [RFC PATCH v12 11/33] KVM: Introduce per-page memory attributes
Message-ID: <ZQuahXpq2fy8rMDV@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20230914015531.1419405-1-seanjc@google.com>
 <20230914015531.1419405-12-seanjc@google.com>
 <ZQP6ZqXH81V24Lj/@yzhao56-desk.sh.intel.com>
 <ZQtdZmJ3SekURjiQ@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZQtdZmJ3SekURjiQ@google.com>
X-ClientProxiedBy: SG2PR03CA0129.apcprd03.prod.outlook.com
 (2603:1096:4:91::33) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|IA0PR11MB7840:EE_
X-MS-Office365-Filtering-Correlation-Id: 886be40f-a1ae-429f-606b-08dbba44f64e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i7SuU8NLMHtxTaWwwABNnJLctnc6KJQ/PVavIBIMfF9/0Q2/Q2EZnpI4/3H4OCL+bSRc32RjLVUcCRhiDgOHgy8z0Aon8wAqM0Ev6/Hf5wtzdfoo+C38hn7wnru7HRyTk36Isd802beP+fycpVp3EojdmDek5VH0/UZSPczCrdo7BWUUKtK8t+WWkPxl+DSynOduFJ8d1lKXBeG7VuyHzXsAscTmC5FwMyVGX0Tiyh5WDCyItMdQ994vyBHXUrwMmfkek1byMOee8NMBRNyckQW1I/wAI3o6pvGFmh6EktyYYBkWRn8LNvLcTKxKo2rWZAnsr4Ily6XZT3vHOQlxfsjxT2ck3SXNgEY/K1wUGnvzKi9XQYGbyQPTC8SIsJlaoab3GzdFXU1jaPJIsc8+HFnU5Llvc5QxfQcGWbMaxSX/a0ATwrJ4JPQl4wkdrNQhsyV6FOpVbM2sy3H3cUKbxVWMajrmDZM72SmuHhN/CxM67GafQGvC8+Mp9N4jbMlWNsSAampXHV30gXfw8PD0b7rKc1RKpV9ND5YOhVdgCg4zq+mq7AkUBAH8EFLHJoCz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199024)(1800799009)(186009)(83380400001)(41300700001)(6666004)(3450700001)(8676002)(4326008)(8936002)(6506007)(6486002)(5660300002)(26005)(86362001)(6512007)(82960400001)(7406005)(38100700002)(478600001)(7416002)(2906002)(66946007)(316002)(6916009)(66476007)(66556008)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A1TxF1ewPD0395Uonf+hysQwW8vvr6rM+BME/jcPfIxl2NVZOrIUu21OFpbh?=
 =?us-ascii?Q?wsDI85nrxHlqDZHS+7VE9ITm9EbgCurIo8OS1qEnRUJ9YDxvzVnkdJz5VHyv?=
 =?us-ascii?Q?JkJzllwTofUgbSabqMHjjI4XvIPYYi3+vjgIluSM9LIS0pWg6IV9UuTXfxZC?=
 =?us-ascii?Q?OKf4pGYAw4fUljbUxhDaShwIUP1RPfq87l35e73YE89lO97vom6xlamX1H5y?=
 =?us-ascii?Q?nHf8F/nkB7kZrwytAtN2l/ju7/pNgw9yhFA8VCF0Hez92GNmJCfjRH2C9rLS?=
 =?us-ascii?Q?lVUcY6LFdQ74u+Z+42Y7QORcxv6aSALlwTmhJudJgrFq6xO84UmorrhrJONr?=
 =?us-ascii?Q?lPsnF8yQhT9XgFh1KIsvNKYLCJzBHCNOl4gNFGwnh0Hrmew4476ZHdMDAnuI?=
 =?us-ascii?Q?Yc51LX7wdtptO/hmH9cG9ZrGDuE5cl+DL5dVWNb/sI/2w3XKgO5O+UT0gaPt?=
 =?us-ascii?Q?BBdyaKJxDSpd9UdxTSnBVB8fUaVEoj00rtj1ynUlEw/i4cht8nPLBG0BheE3?=
 =?us-ascii?Q?FAlEvZp6VjaWluDVgza7glPEw9xDalD27Njd1TRcy8OAxTrnaZpby6sJOPOS?=
 =?us-ascii?Q?KoQyBZW+zggz+1sH7EOLUv7lsME/YoPAYnEXyUKczfpf2/1FSWBZSTfvRdoV?=
 =?us-ascii?Q?GaGxmmkY/ehqmLjhzebFHhls3H0nQgy7+/9Vh7rmdPq1O4VtWw2dHW0BelQ1?=
 =?us-ascii?Q?UazMQmR7gxVayimkdNWDvUS8vDK2gLZbvisq5pnXqsn2SSjHmlOy5mT+O5gO?=
 =?us-ascii?Q?RzCXP5OwcG5k7WN0fEg9ZW77OzJvbwnYvmRhv4+xLAnmyyNdAZXUDeGHj675?=
 =?us-ascii?Q?yM8tJkDRDL3Y6obxdTYUzr8FJ1j4vQoorVExqjPcccMGepG39Ron/uRILtni?=
 =?us-ascii?Q?xHUv9iILaNtMYB+OPgeEdkyduuTqofQV4Iv2LEKsTVbUQ5CUHnL3P7u5oE1k?=
 =?us-ascii?Q?Q+G473hKNGK3DuiaHi9Ipaj44S6wT7jKL766T7HAtxXhhvjuTKeLxmnjtbCQ?=
 =?us-ascii?Q?AeXzxAuZZL2s96t3Bhmj0e/695Zcb5mQyTjqhKFXDFYN8t9LqhudqGVdlOVj?=
 =?us-ascii?Q?ijLLlpnBF+X9/LHN4tMrREewDJuc9y/1AOO4UqOmp7YSTtcvcAgoeCn1365I?=
 =?us-ascii?Q?jyX9bkQHa4UVQy06VUI8NcXCKT/yQyQQnpw+0teD/+16+NwHbWSgO1IzVxrE?=
 =?us-ascii?Q?Sw2qrBnX8yKSne7TKt9Jt2RrE6BsLxgS6tGH6KBcMj82AW+7vibSaVkLN4F3?=
 =?us-ascii?Q?dmdt+x5iruTwIPE4OkOfyYH8tfY329xZ7pA6AeEggE6mtyw0rWMSEgWg0z0Y?=
 =?us-ascii?Q?FUzBbcXDPdUAkgXRxY26olK2Wf5e0Mg+0XM+L1vC94pYzP/nhevkR0V/2dRD?=
 =?us-ascii?Q?lx7o8s+umk25xuOmD0eAOhXn5bL1N7Z83lkAYZM4ofm4Zmp1LBMGj33eqN7j?=
 =?us-ascii?Q?LaDxIHlnRHWwdbyJbC5r7tQj3BideY/VAgzinFHQWDyy4I7D3TQ22Wc5E4Gq?=
 =?us-ascii?Q?xPWmPGC7cmqGTdp18y+lOzgSDPTSpbnYBB5IpYAQcsEEw3tpKxnLwctaa3lU?=
 =?us-ascii?Q?+msaURG+keUbpCdFDTwzOq4Q4z7blAK3gFQ15d1F?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 886be40f-a1ae-429f-606b-08dbba44f64e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 01:49:15.7430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JaDD69pDRW021RZZEY4PJ8iJCzQstnBmgg+iOI1fouHssJkHBeheMrtvgVCOrPg7sykZoq8JmuHYJIMhLVJODg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7840
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 20, 2023 at 02:00:22PM -0700, Sean Christopherson wrote:
> On Fri, Sep 15, 2023, Yan Zhao wrote:
> > On Wed, Sep 13, 2023 at 06:55:09PM -0700, Sean Christopherson wrote:
> > > From: Chao Peng <chao.p.peng@linux.intel.com>
> > > 
> > > In confidential computing usages, whether a page is private or shared is
> > > necessary information for KVM to perform operations like page fault
> > > handling, page zapping etc. There are other potential use cases for
> > > per-page memory attributes, e.g. to make memory read-only (or no-exec,
> > > or exec-only, etc.) without having to modify memslots.
> > > 
> > ...
> > >> +bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
> > > +				     unsigned long attrs)
> > > +{
> > > +	XA_STATE(xas, &kvm->mem_attr_array, start);
> > > +	unsigned long index;
> > > +	bool has_attrs;
> > > +	void *entry;
> > > +
> > > +	rcu_read_lock();
> > > +
> > > +	if (!attrs) {
> > > +		has_attrs = !xas_find(&xas, end);
> > > +		goto out;
> > > +	}
> > > +
> > > +	has_attrs = true;
> > > +	for (index = start; index < end; index++) {
> > > +		do {
> > > +			entry = xas_next(&xas);
> > > +		} while (xas_retry(&xas, entry));
> > > +
> > > +		if (xas.xa_index != index || xa_to_value(entry) != attrs) {
> > Should "xa_to_value(entry) != attrs" be "!(xa_to_value(entry) & attrs)" ?
> 
> No, the exact comparsion is deliberate.  The intent of the API is to determine
> if the entire range already has the desired attributes, not if there is overlap
> between the two.
> 
> E.g. if/when RWX attributes are supported, the exact comparison is needed to
> handle a RW => R conversion.
> 
> > > +			has_attrs = false;
> > > +			break;
> > > +		}
> > > +	}
> > > +
> > > +out:
> > > +	rcu_read_unlock();
> > > +	return has_attrs;
> > > +}
> > > +
> > ...
> > > +/* Set @attributes for the gfn range [@start, @end). */
> > > +static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
> > > +				     unsigned long attributes)
> > > +{
> > > +	struct kvm_mmu_notifier_range pre_set_range = {
> > > +		.start = start,
> > > +		.end = end,
> > > +		.handler = kvm_arch_pre_set_memory_attributes,
> > > +		.on_lock = kvm_mmu_invalidate_begin,
> > > +		.flush_on_ret = true,
> > > +		.may_block = true,
> > > +	};
> > > +	struct kvm_mmu_notifier_range post_set_range = {
> > > +		.start = start,
> > > +		.end = end,
> > > +		.arg.attributes = attributes,
> > > +		.handler = kvm_arch_post_set_memory_attributes,
> > > +		.on_lock = kvm_mmu_invalidate_end,
> > > +		.may_block = true,
> > > +	};
> > > +	unsigned long i;
> > > +	void *entry;
> > > +	int r = 0;
> > > +
> > > +	entry = attributes ? xa_mk_value(attributes) : NULL;
> > Also here, do we need to get existing attributes of a GFN first ?
> 
> No?  @entry is the new value that will be set for all entries.  This line doesn't
> touch the xarray in any way.  Maybe I'm just not understanding your question.
Hmm, I thought this interface was to allow users to add/remove an attribute to a GFN
rather than overwrite all attributes of a GFN. Now I think I misunderstood the intention.

But I wonder if there is a way for users to just add one attribute, as I don't find
ioctl like KVM_GET_MEMORY_ATTRIBUTES for users to get current attributes and then to
add/remove one based on that. e.g. maybe in future, KVM wants to add one attribute in
kernel without being told by userspace ?

