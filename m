Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A4E67B8E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 18:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbjAYR7H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 12:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjAYR7G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 12:59:06 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1E0AD35;
        Wed, 25 Jan 2023 09:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674669545; x=1706205545;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TB1usJA6A+0V9D2E8qR5757kQJTtgcSM0SFKk6JJu+Q=;
  b=F8eQ2bb1NlV9uFHHYA+xzyEJd+AuzhWe5PfRZs7+v1lj8vEZeWD+W7UH
   loGPqVGoPT8NIB18tYqkZ1MhXm12fCLW0gz3Auq2CHliPGNmORyn6DL51
   30CrMVnSBw44Tch/d3i+795MhK5ofaP2vE6qwedMgexp9yk5t4LMAD0Dv
   /lJxnzzlsxAirSjXzWNuUPq/l263a1IS7JyMe91H47jX8ggkfcow0XmBa
   TTGH4Z4sGvAm9vXqITL31EepN3fuHy0yeGHUYHdix2QEWKG5a1SeWN23u
   DrZyoxQzhzJv5/sqbeKKGP7QIPcukWPFjpeWuIoD6TQ2+lOv9qAJOiG0a
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="325303334"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="325303334"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 09:59:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="694810271"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="694810271"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 25 Jan 2023 09:59:04 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 09:59:03 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 09:59:03 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 25 Jan 2023 09:59:03 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 25 Jan 2023 09:59:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IR8xRGgjVLUVCKwsEoZ4FYOzrZwb/ehbgOMpSLWLcWbffOu5wzObdhDe1YdTb5DQ/TDXsAeCWBS+hP+oVsQs5wM0B5t2uJYCDlTOxmnGewaEuIw15CRiUMO74bfIPAIZHA9EnFxIe2L9WeVupx5P/ZKSg+6XLhy08zStPKagfC8/NfAdS5FxJY78wdsqthYyHfaNKBDRu0hrc7y5+ZzXEqhYCBwkV1bniXPpq6H/RabNslLVpjjYOPVqUx1EmVbqxl4ARPP4DGFpv++75zfolGUGPZnOZIbiw+5D3YDgNgzDVt/746dnLDMZsX4erfbNta21DVqI1PYucoDJ983juQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gyQa9Ba2sNpBgfVg6L+J4JLzJIPqQpqkjoH95HYJHkE=;
 b=QqoQWZ/zdgTJrTIrRRLkinvkf1W1BJ9vv8gPJ7f99IX8I/Tml9KnX+T+gBV6TEBGTxoMAGw+Gx9SrKZYzsJeje57Eig3IOrXLz0JXT9xWR5IZhxe0438AJ9AAcHwMV8HYKRQGvqBUAu5Rfk3ZdNd9pKoeAR6QblZ/OnTMwoMR9bg2gB/Tu8e5FvPdjjH2yyNBCwxUAW1wukSv0qzpKHS/3+LyLeT2gOdq3zLv/KaDCWUiWa/GDNU7BEGl/OJfFtOjrp5EsstF+L6xaCxig+rp/IF6a0hPss29nwUwYbUvpkMR5dp5MU6YeH/DT81hXQ5cCQqeOiou7x6ZpWajPl9KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB6963.namprd11.prod.outlook.com (2603:10b6:930:58::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.20; Wed, 25 Jan
 2023 17:59:00 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6002.033; Wed, 25 Jan 2023
 17:59:00 +0000
Date:   Wed, 25 Jan 2023 09:58:56 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        <linux-block@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: RE: [PATCH 1/7] mpage: stop using bdev_{read,write}_page
Message-ID: <63d16de08ab5e_3a36e52944e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230125133436.447864-1-hch@lst.de>
 <20230125133436.447864-2-hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230125133436.447864-2-hch@lst.de>
X-ClientProxiedBy: CY5PR15CA0142.namprd15.prod.outlook.com
 (2603:10b6:930:67::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB6963:EE_
X-MS-Office365-Filtering-Correlation-Id: bfc37a2c-6942-41d6-a1d4-08dafefdd604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nAYwSPHtbdk5wlYiC073WQs02vcXvMC2Oauwj1XlOpoCsJJ7W+eiipnTG0Bro5ITMqdWaiOQkLUSg7sizSKX5ZkNVhg0pGt8HAA7mYMXz5JF77X7P3mBbmwwQtuPnPKMmDFMD4gIozCxKiXbQ8pE9FX2PVuUJF8ZcmG3o3DhQfHKjS5356P+gM01B4eIiq9RQSyQBcQu4Kkava8yHoNeKUpFeTg3Dx94dltiBGnGcMahtaK+s1FOWxHYdwxICOyFowfGpHFszac5uhWG380NgajaLKK2Ga51Ku11FFS1A8rKVqUf5odgtQFsXlY82oSJGs2CDImet00oS8Qbl2V1v6wk4PGObUdKrSEf/cG/KXXSFb96wkm/EfQqeOpjybYVOJ6jX/8FmuIAyqYYD2gjbpcLlTnjwQ6ZXNp+xO7zZ1GNBtLJ+a8WAETXt4nQzEdKslefbL43XbP26OZFLUeV91C4fubPaWjzlpH72u8U95W5gU4+ix6aq7bD4DfWD0DP0+utVrlB3HktrXCyaASEM52MKgHEDNr3R9ipH/3iaez27elYpnYbRsaPvvu5qdg9zt7sqplMOdJBpokRAwaAacpKRH592LJFsF84SHAe9aBFLvVJLAfHrgXpN8z+F+VslIRap9UNP65kum3+jMfXuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(396003)(366004)(39860400002)(376002)(451199018)(38100700002)(86362001)(82960400001)(316002)(6636002)(110136005)(478600001)(2906002)(66476007)(41300700001)(66556008)(4326008)(66946007)(8676002)(5660300002)(8936002)(6512007)(26005)(186003)(6506007)(9686003)(83380400001)(6486002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HC53SR0jliP0KEvHw6BW5VQeuBWV4g7Mj5I56zudVIvmUgpO6mf6inyTCRl+?=
 =?us-ascii?Q?PaQUNRM8N3svvpK/DzkzeB1ltmXlui25UOcBKRtfLZlwMgG7GhRSP3OLTAKK?=
 =?us-ascii?Q?mgMejcVs5FGEIASTD2K8b21VqbPimeP5xkEsnREb29yZFIDavEnh6rIt+7yf?=
 =?us-ascii?Q?+r/qPt4BxIPUwcvr6BHT1hSwaBlGTZ6LmhM6LApFuaFTdPoZXEioBYLB/1Ej?=
 =?us-ascii?Q?ILpaLJCboAmNNUbh3UbQh9kGGbNg/PRTVGxEzpCRt4lZUboUF0kXmn0cs9X/?=
 =?us-ascii?Q?MU12L+06q7gs/QGrVUO36N1iYUjdicZkw/Wzhlpds/xpML7/ldYdvhqtZ3ZN?=
 =?us-ascii?Q?zC3+NhGqTsf8O+I/p7uhQu1Xq8Yf1mwkEl4WXk0NjyfAr8A07YyYnjLU4+pI?=
 =?us-ascii?Q?6tuvsKYqSr47Yze/IHiR0re9mUcIBxULD0SLWcmPrITNMADJAGsVQhqnVaPg?=
 =?us-ascii?Q?7dMRkfmK6DPRtZjqnbJMdxORaBdcOW0t1iV9vDfgZ7IoOfTLMwGJvGESIByz?=
 =?us-ascii?Q?G4wy5dNWXdP2rPyblRoibHqEBGh6u8YLKw2ROHa0dGxBttW7FSlxbiaMhRUA?=
 =?us-ascii?Q?zmDp1sdsOwwB8hklbcek3YDmKm79k5mXmG8TH/gYiQHR3kynyiTYkQ0Kn4KA?=
 =?us-ascii?Q?jGo7CkfIjemkiE+Z+o6w6tLjSAFIbTnAllCKVtHebJziz4E2h83tRASHijE7?=
 =?us-ascii?Q?yl1bxKjStqO52u6LXKwg9lAn8pUkN02DQ9lHN/REb4ymUzJkh/WZL33L80BW?=
 =?us-ascii?Q?6HY2HCvpdRmidYQJwgP7GeNmP2TWwTN7cTKWimh9A1FfKq5bN3OBVxZ1KOZm?=
 =?us-ascii?Q?PNBEelT8jXk4Q2jDucM0s/bfConit/I7tTg33JwtAfYxMf76qSB6y+Y+YrqQ?=
 =?us-ascii?Q?sQg+zeHnjx3Bb2RpoJJ9G3fRpEpwvqkddOZwc38JgLz2KUnPBNCVTerxb8ZD?=
 =?us-ascii?Q?eg6zPYoxoCke3SnhBiq0CEINmSR3W6udvDiLXPzMvJFS7xzLbILwWsj/CTEW?=
 =?us-ascii?Q?BNw2ZcARZV5P8lZ9TVWzLMtN2gIBHS2nlpJoOvI+ytkp6YbkPJS/I007IZDx?=
 =?us-ascii?Q?ppJdH7M1fAJ3hrxxta662I152qt7GYslA55NpbItozY7grKP2u+O4fUA48SF?=
 =?us-ascii?Q?XoW1VA6iuiPb9BPzYuMpyvaC/5uabBKle726gFP1y2jFsfShxwJkt4GlFnXA?=
 =?us-ascii?Q?kuYz+0ef+UEkwEqbsQ6JLpuCVmSN78kH2ZSsT841ClvzZMRf67Jpr9QCjhAW?=
 =?us-ascii?Q?p431PKPaao+WPVOulcbK3sfXbOR+UjJSo+IB+8lB/7UlQUqMAcYFtPOZSiuj?=
 =?us-ascii?Q?db4xnNQR67oGop3It46XoE0hdBi0ka5PtR9GGajB0GxWCkvLpn5bLKou9j/k?=
 =?us-ascii?Q?rJ+3ewfdLVf01HO5cAfcCM7mCrgG9FMtFezi1nsDYLvGXsDrAWBXwjN3c+xd?=
 =?us-ascii?Q?KZ80xqnnRTvS6WMaEn/jDBGrn/6Q9g8ZNZve9zeKOe1cz/DOol1QU0pUWcaS?=
 =?us-ascii?Q?F0OpFUJxhRjmhAxpL8Btd/UlbHJummaZq/fUpcrsEIYkTXuINZAjssYRk8ps?=
 =?us-ascii?Q?VhVIraFQRuKbwhWbE8iHij6lP2bvaNjbJg8wNW8y79x9OH29PMu3Ll7E62Fz?=
 =?us-ascii?Q?ew=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc37a2c-6942-41d6-a1d4-08dafefdd604
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 17:58:59.9030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ycE+DctptIMwXxdTc2YQH9vq6v+BNr0s8rloZYGvKJNuc19pIQJAPPFD7iKpLDnrGwiluA6GtQ3sMJuIAdevmORWuPuHDuPczv45zumEsjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6963
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig wrote:
> These are micro-optimizations for synchronous I/O, which do not matter
> compared to all the other inefficiencies in the legacy buffer_head
> based mpage code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/mpage.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/fs/mpage.c b/fs/mpage.c
> index 0f8ae954a57903..124550cfac4a70 100644
> --- a/fs/mpage.c
> +++ b/fs/mpage.c
> @@ -269,11 +269,6 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
>  
>  alloc_new:
>  	if (args->bio == NULL) {
> -		if (first_hole == blocks_per_page) {
> -			if (!bdev_read_page(bdev, blocks[0] << (blkbits - 9),
> -								&folio->page))
> -				goto out;
> -		}
>  		args->bio = bio_alloc(bdev, bio_max_segs(args->nr_pages), opf,
>  				      gfp);
>  		if (args->bio == NULL)
> @@ -579,11 +574,6 @@ static int __mpage_writepage(struct page *page, struct writeback_control *wbc,
>  
>  alloc_new:
>  	if (bio == NULL) {
> -		if (first_unmapped == blocks_per_page) {
> -			if (!bdev_write_page(bdev, blocks[0] << (blkbits - 9),
> -								page, wbc))
> -				goto out;
> -		}
>  		bio = bio_alloc(bdev, BIO_MAX_VECS,
>  				REQ_OP_WRITE | wbc_to_write_flags(wbc),
>  				GFP_NOFS);
> -- 
> 2.39.0
> 

Makes sense,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
