Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208E86F0DCA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 23:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344027AbjD0Vgk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 17:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjD0Vgj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 17:36:39 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A563212C;
        Thu, 27 Apr 2023 14:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682631398; x=1714167398;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=Ijw3OZwkdkT87oJbt1Y74Tg7z2IXARGLQE8lToTTkiY=;
  b=licKTtY11m12WQ7gsveCNfE17Xyhkq89PqSbaqWJbptpinQXgzGoO35E
   hP1clNflXb1OMJNxvS40Lizwyb1IbJ2iuCJTgPolR29RCTMXDszV5F4+i
   kOCNYoj6A0aAV6MUZDc9ei07LGZaywZutZynEY7B4qmyDIDREpmn/12Ry
   JDygP3t1CzeuJtffOaPHePCIl5+9aTZNd1FL0qbFdFtctTu7r+p55W+Fl
   F0E3BqN8MaVsnT6dzRGhW32w0JMy3x62aUdo4ZZJuw496g+vVAoC/CC0R
   D/GkgQAwvkLXlLemyiIyUVoZAEMz/ec+XDcl7r1vy/JN2ayKdZSxdIz5d
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="410634032"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="410634032"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 14:36:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="759324733"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="759324733"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 27 Apr 2023 14:36:37 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 27 Apr 2023 14:36:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 27 Apr 2023 14:36:37 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 27 Apr 2023 14:36:37 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 27 Apr 2023 14:36:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJnPCURnfnBhkQRE9hUGtzUuEo24j77XUPwMOSDnYg9kSSKLru5Y+9mZlKOwVH6Br24LJT7gr8X0GH+Q+aFM9aXEh0sESvYAS8HXBI3Ak46+At8sbzcFAUz8HUQfv1nMxOYrNyI2gEAQPk4IofvIKH4TaePZavuV9w+XCjmRVSS3ystHytpDOJ/S0KF25cLNHGd36bm1Xcf1KzEye+VT7je15T3RKCvjnNTDgj5zqPLKLZL39wvMhJYKJzbeC9PWS3qkrHvnDlEJzx7BjUpkY0/Q6XkgBmuG4oGkrqfit78M1gxlaaNeKPxOa5+XVfwNw87kpEzxNjBBG3w/TGjPrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amjdFHCen2IC1q8IVUAImWuOMKFC144OrvSqiEBHK84=;
 b=D9jjAsaHua4TWeP0u1NI0hlYr+uFFnlJaFo7FBEsqt5NxEtE1gDiirNEqNJSh2EthVL4f61YkyahNjOv0gGpos6piHf24HqaNVy3eg/Z/paEa5UvV9A8eTbXv1JWH8EauiEXwkA9CEIulvk/WQKtvSC/YQoHuyShtWghf4q1HECP8G73PNXBOaQiE5/jNCNznHypVcjhsRA20likyqFlW1ldN6tvowJ7Vv53YEruyYOg/n24DSiztdXUDXxMUThRRhNjoqcBLIdRVJRkfwMO0yDXOT+WvXpEW18lbSuYmFwcU9ym4mmHfafARhEmTH4Cmthztu3k9FBhJw8mx7vWAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6261.namprd11.prod.outlook.com (2603:10b6:8:a8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 21:36:32 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%6]) with mapi id 15.20.6340.020; Thu, 27 Apr 2023
 21:36:31 +0000
Date:   Thu, 27 Apr 2023 14:36:28 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jane Chu <jane.chu@oracle.com>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <dave.jiang@intel.com>,
        <ira.weiny@intel.com>, <willy@infradead.org>,
        <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH v2] dax: enable dax fault handler to report
 VM_FAULT_HWPOISON
Message-ID: <644aeadcba13b_2028294c9@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230406230127.716716-1-jane.chu@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230406230127.716716-1-jane.chu@oracle.com>
X-ClientProxiedBy: BY5PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:a03:180::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6261:EE_
X-MS-Office365-Filtering-Correlation-Id: 12d105a0-c788-4e6f-177d-08db4767770e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aoCEz4by01pk+p6bKFRT0X0gGtqu8W9oDnwR186i9awHLScd6kN8tZK7T53Z74CXf+OvuvdkRakSSKuwVVyiiqsi9GAheDthhS/j00uVyJ7sG/hn9hZJRe6Is4pgLWN9+NM2RGR7N59GPxpA/9WxC+p7+cASIq4fxK9Aou369905oRS6MO+U0XsdBUSuICsgXLOE4HVBSHQFa+jANyfSSX1w9T5zd/Ro+y4Pf/JMa6+WJtJp37EegFgh2JKIMk6Cq+rGhr4zH4yWj69axDbAOI9HHSFUnh53tmaIZNluk2Aw5lUBqp8jXv/z/RDI/nm/qS2ca3RdTmITdmXYB05nvZs0P7cYkPGpyGmwn/gjHkLu8lFAE8+hHix25ojPb76UOkXG8nBBIVY4hcPkQYymRGlDFBWpvw+jFKZXqpKk0i9zRU+R64Cg/j4AmpMnNClkfhwPTccCcOBGP3o7msX61rToV4O4iBBuRE1HpZGlQrF4ES2XQW9XQQqsoc33eKtZCvoyWHkZkAKgRfJaELdbW8t30+GVwO8MzbODLQebFsIBIuXEIGsIVSv9GLgtAR3Ja3nW65eITRxN0oM5ZgJPEakPv3Nh/6YNXH3BH25mdWk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199021)(83380400001)(26005)(6506007)(6512007)(9686003)(186003)(66476007)(82960400001)(86362001)(38100700002)(66946007)(2906002)(41300700001)(316002)(921005)(66556008)(478600001)(6666004)(5660300002)(8676002)(6486002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Skb50vJ2KigAfDP+2yORfiwNEQ4lp+FUe2wod7MimwrlTQ8PAu8nX/afeqHD?=
 =?us-ascii?Q?dofpyevT9I9fCbnkb+xTc0uM7f6i7YkqpSbJytimT86Gk7E7ndFMMiQn75Hq?=
 =?us-ascii?Q?BgMvnjGGaY4MRgHzzboA9kgE1WVz9xJAkvkIfe0qcLw/DPHvTD8iDd9/LVlp?=
 =?us-ascii?Q?kCe+H52xQeotel07vi4rQ47hZkA5VPUJ3QVvZeez8Z+CesBrWrw6UZJjOTgY?=
 =?us-ascii?Q?8ticdhGH7NbM/gYazMhrlaAzADOMZD0t/gnjCjck91QsX2oTtjKfS9Kkkqnh?=
 =?us-ascii?Q?uvCHfJsvw05NFjHSgj/WiKF0Ggma83i08yUclEmEyIOSwFjswUBIIM+LINc+?=
 =?us-ascii?Q?v/Fm9vRLu9pIxeXlnJYwrQ4LUAjXcpt8lBpBotMZUujT6jzj8rrcW7d5IASt?=
 =?us-ascii?Q?avRYG7uzKq2/erNsbdAaCoFPO4l8b6jKfc4oHTth17AR8uayW9pXuDcWPXpE?=
 =?us-ascii?Q?YL0Fl8WhkZNJJZ6w9DBuWmaExGrsatrXzD3SlO1UtMW6lKN0JJdLe6YWpiW8?=
 =?us-ascii?Q?XcqCN6DYoD8sCg9NaOqD3JIZCVrJUORCUiEv7F6ZwwOdJSEjv8dsqPodaCH+?=
 =?us-ascii?Q?P2S/8mc5aXzDX9qvkm3HbogSViB37eU3qxhW8vIRdOQ2U35c6I1z2lgQsNtO?=
 =?us-ascii?Q?tKGxB/lgmdYAE829b9eAPXr9hoOo9dwhCpzi38ulNBmBV/G5oXHnGFR65HQk?=
 =?us-ascii?Q?hGWtNfHxJzS3pqTFYKMkljivP/RXJYOX/9tfbLGH8hPtbC52rD2LSP4i0E0c?=
 =?us-ascii?Q?qUs4IVyPcDCCcpp2yLANAD3NOCwcOrsM1NtmC1L9kaVWeJf1B6b2SEGfqmqa?=
 =?us-ascii?Q?JovNR2hPH6skinD3gbvou+yJ723a+7KW90ypROh/OnchWm9U1QEp1tq4eyQA?=
 =?us-ascii?Q?SrNxYOu1bFnuq09TS4zyg4yZpmwF1lUgI1YsBbe5ppDoihltAERVYiUr/hvB?=
 =?us-ascii?Q?xFvxw+m0z/0PsZpNrDV4Ftcu11bY7on87oCtjWaXR+bac9l8tM82rnYSDiNa?=
 =?us-ascii?Q?Gd+s51kJcW26XmWxcQNbaNrFr5NWuGPS+FJqHQ5uDzvlZ9g5hoeXRSHmpm/k?=
 =?us-ascii?Q?mdcmtwwJuOqhl9d3+8CoWbwURf5w63io4uJ9g2SeHeOwR5TGwttAQa+zTd4i?=
 =?us-ascii?Q?0lWqc3ZsylOFF462Fpfh9zpXhTxFmMGIz9KcqKk6Ga7kg6ks/QEAbunr20MN?=
 =?us-ascii?Q?nCEcAfhFfSmCpdjzvWznirCHVqYcbIpKWneHJsPOmbqpmt9DQWbG0CCFdMZp?=
 =?us-ascii?Q?b8e2Q8e8Yaa/qSjT3TY8HmRaKdc5KtXb2BAGMNcP53JiyqMPkWjFtrsXWMe7?=
 =?us-ascii?Q?CPUIPKXAyup2t5crTgoZ1O5sCpPGj6+t7W0L6Kei07Gd8iiLWRxGMihYfusP?=
 =?us-ascii?Q?EyLALdQvF1zszes7363PczROWLUimWifnKL8m8sb3Ij1cPRuy8UmdTujdffx?=
 =?us-ascii?Q?CEXO+UxYc5+o6ameCephqZtSWYgpSSLOmlbFzXe/PbNEg2wHlq6ERpYs6tkb?=
 =?us-ascii?Q?aEe+ZFch5rtMWivx7hSbH+9JKKKpMSLXfSDPYoQ6uXK8ls1Ycf4tksFrY9VY?=
 =?us-ascii?Q?UZcOFaLx9UzuUY+V3iV2NeIXpo/l2SWRySI+P3w1xC72K4WaD+VagU6Hy7Rj?=
 =?us-ascii?Q?bg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d105a0-c788-4e6f-177d-08db4767770e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 21:36:31.3093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H+BlazYS76+6sGgAPvVstt08Yqn+TWhSfMtcI23AmXCe9L5ISSLyNe99HqzT0UvNB9Zu8FAewP2KbEKRomwQqELCueZK8W19V+HD7rUHHDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6261
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jane Chu wrote:
> When dax fault handler fails to provision the fault page due to
> hwpoison, it returns VM_FAULT_SIGBUS which lead to a sigbus delivered
> to userspace with .si_code BUS_ADRERR.  Channel dax backend driver's
> detection on hwpoison to the filesystem to provide the precise reason
> for the fault.

It's not yet clear to me by this description why this is an improvement
or will not cause other confusion. In this case the reason for the
SIGBUS is because the driver wants to prevent access to poison, not that
the CPU consumed poison. Can you clarify what is lost by *not* making
this change?

> 
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> ---
>  drivers/nvdimm/pmem.c | 2 +-
>  fs/dax.c              | 2 +-
>  include/linux/mm.h    | 2 ++
>  3 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index ceea55f621cc..46e094e56159 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -260,7 +260,7 @@ __weak long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
>  		long actual_nr;
>  
>  		if (mode != DAX_RECOVERY_WRITE)
> -			return -EIO;
> +			return -EHWPOISON;
>  
>  		/*
>  		 * Set the recovery stride is set to kernel page size because
> diff --git a/fs/dax.c b/fs/dax.c
> index 3e457a16c7d1..c93191cd4802 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1456,7 +1456,7 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
>  
>  		map_len = dax_direct_access(dax_dev, pgoff, PHYS_PFN(size),
>  				DAX_ACCESS, &kaddr, NULL);
> -		if (map_len == -EIO && iov_iter_rw(iter) == WRITE) {
> +		if (map_len == -EHWPOISON && iov_iter_rw(iter) == WRITE) {
>  			map_len = dax_direct_access(dax_dev, pgoff,
>  					PHYS_PFN(size), DAX_RECOVERY_WRITE,
>  					&kaddr, NULL);

This change results in EHWPOISON leaking to usersapce in the case of
read(2), that's not a return code that block I/O applications have ever
had to contend with before. Just as badblocks cause EIO to be returned,
so should poisoned cachelines for pmem.


> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 1f79667824eb..e4c974587659 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3217,6 +3217,8 @@ static inline vm_fault_t vmf_error(int err)
>  {
>  	if (err == -ENOMEM)
>  		return VM_FAULT_OOM;
> +	else if (err == -EHWPOISON)
> +		return VM_FAULT_HWPOISON;
>  	return VM_FAULT_SIGBUS;
>  }
>  
> -- 
> 2.18.4
> 
> 


