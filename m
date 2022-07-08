Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C91556BC5D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jul 2022 17:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238731AbiGHOrw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jul 2022 10:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238843AbiGHOri (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jul 2022 10:47:38 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2836D55B;
        Fri,  8 Jul 2022 07:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657291564; x=1688827564;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7+2HC/1c+fJg6Dwczv49cp3Lt1Du16TWnLs7HVWs0KE=;
  b=KcS1oNYHB6gbXNg7VZQwWq3spj6g6sgAt5pxHADpYqXNWUpXC0aTxu1z
   1Bh1MT7v9O5SCmmy88CWyHFOSJp+8VvCNPEQJWtthVhFvz5b8uSP8cq2j
   fVS7qWP2RrrX11NFY6y48Oy6wqthifJ4PROJB99A/RulZ9QR6d6nvZF4w
   N+CShUKcWOrjxJBibjA1BjL483Uhy48nn+tY++BiEuDC+lX0GyJiXaVnc
   7exFAn10zKf6R1mDAtUmvDd1+9K/DKU6gGujmdAv2ItqMapCq37NVZha+
   cW4HzMjjK2g/PWpgAmCVHm7fuMhEUgoR6xfbF/Qx2rANoqEP3qXQkCyUa
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="370607966"
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="370607966"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 07:45:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="683679980"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Jul 2022 07:45:20 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 8 Jul 2022 07:45:20 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 8 Jul 2022 07:45:20 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 8 Jul 2022 07:45:20 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 8 Jul 2022 07:45:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjFk+g6iwc6CdP6omJ443tryPMp5VTPfWkKojitygkb4NsRaflMOfKXYayLZESqAfrgMoYCdEhexi/hdOKeQK5dAHf10L7svp+jSWvXDVuUABfOC3v8Vh2W2zgN5+TdKJdOSHY5NbS2Qdvpr/r4zlgsAAenOUtLQncjg+4R7s4XyuLuQSTTTLkxvypvPuLWxgbPo7diYloIs2LAbDyj59JZcqSRhOlxyOVWguG3OkB/to7YTs9M5WS1bJ4rfcXxOCsH6u2O5MXYDOZomoNxL77AA3oQXhkbbDcoBIDXkTr9mDZnOn/9zgfvs4+TFA3KNRQInhVureddc2FF1w99bxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TEr6ObQupWtPQZuHLl69ef30wMtcRv5UlhN+Z3XBZMo=;
 b=M0BZhmpMBNw/kPrcUufseDqU+zcd/nCtRUD2ixk4ll/s5ZJRCSqoIT5bPmzVIDQGb8Kn0skxBNccr/l9QMNp5E5SPhdbUdvXnaDtlk7bqgl9qKqveyEyHg+Emqvsc58k8zIqiLWNBSoX6wl+XOQ/DcZyY78g5Wn2SRfLWEand5cMRX9cH2lBwKWxwxupzfNNiZTopx5jQAaLET84pDgoXEo7j+PiKqOtnF7WN3CIWx9Ulcl+kMiolrVgWDoBjZkVhIBujGUFZMkz8L1hN/49qBC39XaKX93Fj43UMs3iRcsB7obDopdG5Jx0WJKP7OYir/KWJj3bVCX9nqcId5MDQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 CY4PR1101MB2199.namprd11.prod.outlook.com (2603:10b6:910:1a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Fri, 8 Jul
 2022 14:45:18 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f188:57e2:349e:51da]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f188:57e2:349e:51da%9]) with mapi id 15.20.5417.020; Fri, 8 Jul 2022
 14:45:18 +0000
Date:   Fri, 8 Jul 2022 07:45:12 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/3] pci/doe: Use devm_xa_init()
Message-ID: <YshC+Jaua01dPQak@iweiny-desk3>
References: <20220705232159.2218958-3-ira.weiny@intel.com>
 <20220707160646.GA306751@bhelgaas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220707160646.GA306751@bhelgaas>
X-ClientProxiedBy: BYAPR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::20) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c4cc467-b9a4-4fc2-cb72-08da60f07a44
X-MS-TrafficTypeDiagnostic: CY4PR1101MB2199:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l46N8sWlQIdbn/r6hrpMvp8blZwdSeoSiuXLqnXyvav7Coi73q41sxyYBTDwp6DVhRfLpsDsAWOnjWSbNMx8NDzVW0oGy8xSg6RP6kBoSLOZHuWY4qzntzU6oAoLH8kTJqfGPv+DCQCpp+2jd2HIpyw/1AUFCl8Rv/yJlZgxvnpgVAKV99ImM+EM1afhMoE1z69m7IeopLS8eb4hwGEo/4CaSWz7mfg8Kd3sziSTpmmbX4SZDqHEnlHK96Dy9gZ8WwhrlYX3btywFWmYRhyQ74KU9Qf1N7P7+8tffkek/Ia8Qcs3upVnc7kBezAkCV67/amhUWGyeLWoXPZEEpRmOwzwLXXNmSq4+k6fs91kznCmT4jhxMAuauMz7hvf9njm+lKyhw4Zmvqr0Zhy/g3yeKTVrBYEvRdB+cdlI2zgvzh6v6Rwj2fFmxf8HQ8M3zHZ1iqDt8NOMpvkVes4WqUQAdwl7ivtb1Upbu68ZHDqTIbuLx0leU+kphk29DvOThBLvPz6oznIzsasKzPI+F1xy/VwtowN0DCWreLvs/4dujuWkYRtpu61ovTy/dtxlxFl2+IsiVV7entC9OITsGwes+QN/Aculu4+J7681R/dOGrx4FA7ExMKEWX5lGOpM2Xnp5zlFXDAzL2D93kvFh2nh34WfaDtIN7fSA+VpJHi+nKLRzo4WORF8U/Wh8MAGqqZZ49lmHRXgRM05bMhdDsdQmJb948sDi1uE1DUzgp16dAswc/mX5wLDKTTT8JMhHUEJ4dXhT3nyu0D6L9YBpF89WRlSo8ADtJlvNko0XcvHkEPGq6uuQwdxeV+5Q934R9q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(346002)(396003)(39860400002)(136003)(376002)(5660300002)(186003)(41300700001)(2906002)(6666004)(86362001)(6506007)(33716001)(6486002)(54906003)(6512007)(9686003)(8936002)(44832011)(478600001)(4326008)(6916009)(316002)(8676002)(82960400001)(38100700002)(66946007)(66476007)(66556008)(83380400001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ancaAX0UbEPPfnjF2ugkglsl+jBdIvzHANHwU18Yzy/lOI9Zb/ddc7+u/9dP?=
 =?us-ascii?Q?mfwfNu0M7KGgmrgGx5Lbzo7c4d9VqamsVxxs6cO7CZtQvtZ5OjsOyYfictmQ?=
 =?us-ascii?Q?nO6OeGMZXyJXLn0HUKD7rbOF5lm6xrZR+jJee6mT882+eV/Fkk461KJiqhcj?=
 =?us-ascii?Q?KPBA2cbAHmjKoawg+xtEOFT1kGtSCxBfIiib/feaxj8WzfFdyouzNUVFzxCd?=
 =?us-ascii?Q?GJesPcyGN0pIkV2LQD/QZwGFvSeG/wGBsQi5xq9PhNI5dcx1M2jpfuZITZL3?=
 =?us-ascii?Q?YZBgs5bW5KFZ4yHoehE49Bb/1sQCPE4I236vLIlqsqptCne4psYA0Ceyec35?=
 =?us-ascii?Q?dYd+z9F30VJrpfbfcxrBOL2uXSPzG3Ffc6qv2rVkAFsJGPNZMO0BbZiyg4OD?=
 =?us-ascii?Q?ecI2aRR8yiF/jAi6wDmuM85yT08L5VemNs2M6MMmjY5Kyz8OtdP7GrV8uhgb?=
 =?us-ascii?Q?Ig27Uf5DiJOB+fbbkTDETiVm5Uj58GPv5i7Tw9k1Akkiu9z+ikCtIq+47n62?=
 =?us-ascii?Q?TdnCZGrRFtZmW/iD4RSUsS8iQuSbvd3R2Yrd7E1rcQf12gaRpLLQTJcnFDkV?=
 =?us-ascii?Q?iKHlPcrwDB9XwvK4KlAqJ6ev+HP89HfAx1pO5Tz3Yz9k6D+a/7pgbjztJDlF?=
 =?us-ascii?Q?NeY4zwVM+G+EoTyui5qPKW0h7hXHFuoiTA1JR9fvSTxDg1G/EsmM/dS7th3r?=
 =?us-ascii?Q?K18lxwXr8FQkaXryM2Vuf+c73NMdYAnLXYp6liCLD0hm62qouEHCY2YWrc4O?=
 =?us-ascii?Q?ivMkPv1RhvPb/gONh62ZKqaOCMhAp/paOy4sL6CUp8QkK/X+t6+mYQ7rIl5i?=
 =?us-ascii?Q?NdGviYuB0y3IFHZtvBAHeVdutGKzd/ZJCUfYQEBoBZjUB08PmN1n7ZdabU1l?=
 =?us-ascii?Q?IZ6HleLElLg0u/ACcn93mzlzQdqXFqniaJKAF+gqTWbACcLOLT+cen9inVtm?=
 =?us-ascii?Q?/BVnJzsHCsDAUAHraOTlQblMSUEkYRTd+pjy/ysuyVwPcKrxsvwQ4EMqf0oz?=
 =?us-ascii?Q?mA0tAaEm31mTnH8KINjiO5BsljnwvWgQGbrNpPgm3ulGnJ0V3oQMJhbccENH?=
 =?us-ascii?Q?P4Ro8VbqNlLVE+M5rNb7d7o8CP9UY6w9BwMsY/92Bzwd5+MNKgJsgzChwfb2?=
 =?us-ascii?Q?egcuh+Y1aFQBlVeDUOewYVxjdfOrUrYc0NeiyVJ280kBtwY1OVE3+78q4/e8?=
 =?us-ascii?Q?iI3tcpUCa2jnBGb6ChCVqhW+Ic+N46/yLEbAIntaAVIrZtQIXlzrpREjbVFz?=
 =?us-ascii?Q?uM/7BRaF1LjHtGTWhFqbGmW1COs2YMHFQxXRtn58FcaNFkq4+aip5l4xT1i/?=
 =?us-ascii?Q?Yz0DOhBTqv2fezfEqZ+rWjJD3k/VWNDTFNsCR/aMo+nfHvG3ebWXk4ua8RQw?=
 =?us-ascii?Q?O9DMLohUgZ+xYJakgaQ0mtzs4P5vo//3WRPwYyTkmDWP3awMyml+JKfVu3Ud?=
 =?us-ascii?Q?nBLs8CcAwu9BuAvxlOjgfuyMcp4QpkahEeHdXOIgedfsHkWwnmd4rRLVQW6O?=
 =?us-ascii?Q?+0IfRDiuxnlw8d/zZERoOqsy0U6HON6uuNwo64APaCmwm+bP+I8af+DULwki?=
 =?us-ascii?Q?smT3/09S9tcEwz8M4m57L19xG7kYioqURItfq8spV1I4Wpn0F6oYgzCmCdYp?=
 =?us-ascii?Q?SszyzgC3zr+Vc8shV6RdasU1OHuscI70o1cE+RTq8HGT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4cc467-b9a4-4fc2-cb72-08da60f07a44
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 14:45:18.7655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +3OZVGB0ojlSOio4azqG8uRxlCFIErMa+3I0Y/dOLRCTAfTCi3tGzIKXY43TX44rKVD0SaHVDHIIX4to5DqVbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2199
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 07, 2022 at 11:06:46AM -0500, Bjorn Helgaas wrote:
> On Tue, Jul 05, 2022 at 04:21:58PM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > The XArray being used to store the protocols does not even store
> > allocated objects.
> 
> I guess the point is that the doe_mb->prots XArray doesn't reference
> any other objects that would need to be freed when destroying
> doe_mb->prots?

Yes.

> A few more words here would make the commit log more
> useful to non-XArray experts.

I'll update this to be more clear in a V1 if it goes that far.  But to clarify
here; the protocol information is a u16 vendor id and u8 protocol number.  So
we are able to store that in the unsigned long value that would normally be a
pointer to something in the XArray.

> 
> s|pci/doe|PCI/DOE| in subject to match the drivers/pci convention.

Yes. Sorry,

Thanks for the review,
Ira

> 
> > Use devm_xa_init() to automatically destroy the XArray when the PCI
> > device goes away.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >  drivers/pci/doe.c | 14 ++------------
> >  1 file changed, 2 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> > index 0b02f33ef994..aa36f459d375 100644
> > --- a/drivers/pci/doe.c
> > +++ b/drivers/pci/doe.c
> > @@ -386,13 +386,6 @@ static int pci_doe_cache_protocols(struct pci_doe_mb *doe_mb)
> >  	return 0;
> >  }
> >  
> > -static void pci_doe_xa_destroy(void *mb)
> > -{
> > -	struct pci_doe_mb *doe_mb = mb;
> > -
> > -	xa_destroy(&doe_mb->prots);
> > -}
> > -
> >  static void pci_doe_destroy_workqueue(void *mb)
> >  {
> >  	struct pci_doe_mb *doe_mb = mb;
> > @@ -440,11 +433,8 @@ struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset)
> >  	doe_mb->pdev = pdev;
> >  	doe_mb->cap_offset = cap_offset;
> >  	init_waitqueue_head(&doe_mb->wq);
> > -
> > -	xa_init(&doe_mb->prots);
> > -	rc = devm_add_action(dev, pci_doe_xa_destroy, doe_mb);
> > -	if (rc)
> > -		return ERR_PTR(rc);
> > +	if (devm_xa_init(dev, &doe_mb->prots))
> > +		return ERR_PTR(-ENOMEM);
> >  
> >  	doe_mb->work_queue = alloc_ordered_workqueue("DOE: [%x]", 0,
> >  						     doe_mb->cap_offset);
> > -- 
> > 2.35.3
> > 
