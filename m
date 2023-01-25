Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C1467B95D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 19:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235997AbjAYSau (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 13:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235811AbjAYSam (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 13:30:42 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2455AB5A;
        Wed, 25 Jan 2023 10:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674671436; x=1706207436;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Z47aIO3R+QLxitBQErlXrrMD/8q8YA7MBOAGZf8GSsg=;
  b=R5Bxaa9o7GwhnIVHcwfWprTK1xOuma+zFg1lJ8Qb1Oj8Poqu72CCW45e
   g0lt/JLcB34GF/RJUIwRI0AodNVzt+fcTyNc7VP9UDV8aEnn1VKpBiIsY
   t6hYGW5cdzemI8mJ1DzYOfyRWCAg3mCdwc5pCRw92JNUoWDbKbWKwQF/e
   aORXJ0lssVlRcFy/APyy1KmRwAcQi9au5f1aMigJnm+gCKbTiTkEL+Pgx
   IybnFDf8YEKWFL5tTlue4TDWQ+O16Y23jAoP8nv5c/RfEbrnT2vHWZjIz
   n0txuhJWcH5lKfT5MfArcixCzYViiey/AnmTv8Q+nZZrWSt6Rcth3D/0s
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="326665193"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="326665193"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 10:30:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="991363730"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="991363730"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 25 Jan 2023 10:30:35 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 10:30:35 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 10:30:35 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 25 Jan 2023 10:30:35 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 25 Jan 2023 10:30:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZAr50EQCcjWaSCjY7csHakwsPPdtyB+MJidXAGbEm59G1kA70nB0tXVUzV7EgLalWMlbwU39SojLLVaaCkAx85Vxu5Vn1WqAb7xH4LhFPVGHAjsM03xWDHVcxNedcBGkrT8s7WR4MfJMjU0lDa6qOxfoDMNqYuh2t/H7rC25VnhK7FhH/juEL6BhSVYFCFNdSQezq+E+hxgA7f68+FIsH9wulvaLsTero/FGLR+QKA0O1TSd7ymPKe3IMHBo0uGyrg/+y9n4R/BCY+q9nD3+TVx6Mh6Z9NZGCBdt3FGtX3rMnpQydXkgKxl850OI6EnW1FVDB8iKAjNw/TTd7XXRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSqCCDe/AHmCSYF6g56/Mfd8MJhDkAhF2nlvbu03jbc=;
 b=Yezm3zuhlym01liYuXFgiI+zN3xLz2GBLKh/eVHrGjCeZ45ZsQafQ0IxLoXFAtbarLFWKQSfdia0E0f1+KLKk3FS9j8evAi5qMbgf3+77As17OO/6jzxAFa9fAkL/FgFlSVG2E9h/R/f65mc1j5mZh5yXNe4LYuLxUnI2lYs7XEcVcbiXAE7WKcWtzz4HDz9ATQUUyZFZTIg+32LYhTsCuhtnlCsWduKe8os6h71PvJ6wSbUBnkhMxeT5Wnx7BrSDsxfKz3r6P1twGXYrHFX3SI+WvkBBuJ3RdmCEC39j04bZBu+EFfLR9HDse67tazmx1GPa69GL9GCbit/G5vZmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB5519.namprd11.prod.outlook.com (2603:10b6:5:39e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Wed, 25 Jan
 2023 18:30:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6002.033; Wed, 25 Jan 2023
 18:30:33 +0000
Date:   Wed, 25 Jan 2023 10:30:29 -0800
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
Subject: RE: [PATCH 3/7] mm: factor out a swap_readpage_bdev helper
Message-ID: <63d17545bb932_3a36e5294ec@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230125133436.447864-1-hch@lst.de>
 <20230125133436.447864-4-hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230125133436.447864-4-hch@lst.de>
X-ClientProxiedBy: CY8PR22CA0007.namprd22.prod.outlook.com
 (2603:10b6:930:45::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB5519:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f57ac2e-489d-4304-3c94-08daff023e79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SHL1+r48UYSoGgUfPabKA3OLH/+whIKgP2SFp68r3dMf7XczNYrgH6sDv2ICAOPprbm/1LPUCQTcFlLgsC5PNTN4eJuqrOHm6HCEft+jIdmgusYn7KznKIFVgZOfaMfjbHBvoCnC8E81tCOsqjbSzhzIBfGyxJht5svm4dxC1QNYrgq31rr/ocKhEBVVqG6Rndc7qxvXSTJsBDJuY9BPqABVmDCXM9v9Yt84ArwdePGxpflJq7lf4UW9bYxo4u8xZ6gg+2WAs1SX1A7i6rAr02ULtDeYUrVngk1g3SHHM4PZPCx8i+6E3B5iEqokRfM5nl51FUjhIUTaJSQmDpgjB9m9LlybYqeozD0/LzM7FwPEq4yVH2ZjFqTw0mxpLeGLZAliPf3AxvK9RC8JZX/TDIz8wNNThRdeNVjU/jetw/UiCiMiVvv8ZBGpNUP8LYpnETSuyp2ck5efFjiPK/5rVND9y6TyKI7f5LV1ArQ4Xe6dWMH7PXHI+yxb/8jpG52qPzJTxB1cxM4kkbGDR79A+pIGe+6cuOiUoCb9snf5ffnek6NNSUpB4mUrOafG2tob4HqIb17QqgwGJLf4UFRqEWK7307Iqyaat1rNxVZAknAbVqa4TMFNz8IZhO02fdUB4Ova2hOAZu8xApYw5JUm8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199018)(82960400001)(38100700002)(186003)(66946007)(6506007)(2906002)(86362001)(5660300002)(26005)(8936002)(83380400001)(6512007)(9686003)(6666004)(6486002)(8676002)(478600001)(316002)(4326008)(6636002)(66556008)(110136005)(66476007)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uzWbO5/CsJDRrocwYKPD+y2fSeuqTBeuPlC0iMGYWOkZNi2gN420Wz7mG4Bz?=
 =?us-ascii?Q?zf8cgJcUDNFi9Eg2olTB1xPa9xNAdK3qgopLPj4alkr39JFGuxcucsvsFsij?=
 =?us-ascii?Q?r6zYM7d3eIoI1p5egU+OaGHpxIMK9ZSPkbLGilaQaAtJIr7OhTm3TkEx73Kd?=
 =?us-ascii?Q?CnoYlVq3/6ukNVgfESlH6PqpOVBEXaaFI1HL7or/A77DBk3Pv7rTbgv07Zbm?=
 =?us-ascii?Q?KNWw/UKw5551NJHMJ0wXJPbplViwDbtJ7t5/y22C4ESP02cetagPHbAZeE5W?=
 =?us-ascii?Q?ViljDnwI7uSfedz3zOkqye4Q+dEBT64VmAKOxByT5bTo/gSV5TzdIr2Y8k0n?=
 =?us-ascii?Q?3I8qUq31wPi9pCQYELW7GX6RtWY1gCAGxV0ecdlJthKcvBpmRkP8BDLjPdb7?=
 =?us-ascii?Q?GybR5jClV0wMFTbWSABCHoeiCIB7XE39Xf2er3N1SYNy3Lqljd4DLgR8lILf?=
 =?us-ascii?Q?ulDLPnlsylna/MBj2nZ0ezyyqk+to8kAKpBYP4aOUXQWLe3qUo7WTVIC7IDK?=
 =?us-ascii?Q?kRbC/y1cnbk28g10T8qptFFku02f/WUfLzFdh3DLQL0BTsUsqGQGqtSXJT0a?=
 =?us-ascii?Q?Jrn+Bi+WpcycidM8shf9bIJdCCqVFSDb+gr58jwOErnoeknF2u7N7b9HE/rx?=
 =?us-ascii?Q?q2QjvTtrr5mkKSzyG0fZbnZA1+uicfVqof1/8xziy3C7PEHQG1zIF7wrmJJO?=
 =?us-ascii?Q?7lj04XCZpomS9B6/nCAfPY6X7OBLAeeM/L1n/zd7MEja0q7NSaEHE85mrHno?=
 =?us-ascii?Q?Z6Z8FvNnjPnTGLy9NU+nddNOkw/FdBTYaA0ggA1VEEpXxoXwhiSaYdN6xTD5?=
 =?us-ascii?Q?50/RwY9T0ZPwlhTWWNM8RwKUwVWg9oWjnogVlm1Oy820u/8bscRqYEamHYUb?=
 =?us-ascii?Q?+fB+/zI9gITpo73C7o1cXp46l1y2dVtKZyXCuj9ytFt78mTbKjIAnjKk2eRI?=
 =?us-ascii?Q?qmSz+sT0oIUescD4uFhInpFgMafzMzL8+O3zVO1uQlWA+IC1oHXSjNzmqFYi?=
 =?us-ascii?Q?dp5W3zYT0b+/or1w+RrY9jQbqB46lVYoWgB1ijvzaUKJMmJkcfhSZTLriVS4?=
 =?us-ascii?Q?lFogQ8l1ykZfJr+KjjX5C/LCRN1T3tJ5skyl+ZcW9UCKy/G62FlR1fZ7J1hM?=
 =?us-ascii?Q?df8NLrRLLZtSyKlIzXbbBy31s9ngV2FbHAaMGNAqlK7gDawggh/9JUCpwWMf?=
 =?us-ascii?Q?8xf2jdCX1V+29iAHCn1u6dqBh8yMGeJ1yoshjcLX4AMZMA7UpM5lEkqmhQWg?=
 =?us-ascii?Q?aAHOxYQCjzzkG7OF7zuTKkJ1peGtTkZoTPQhXRPNzsMCqJzFNJBHttAuJN7Z?=
 =?us-ascii?Q?tmlW31szIulRQQ9XeXy11G8GE+lxj3W32iopHE9kBwau9FY5TzTZ44P3NT/z?=
 =?us-ascii?Q?MjTqjRo99lAn/Pfqa3Gj+CVzHJ0gml6XBFY/4asQgInIbo1I4F7Clp/uwrK4?=
 =?us-ascii?Q?MLmESUY81yEMt/0SN8WtTwNtf1zyYVb1OxfOzQ3ejZBjei2Mv+f4EQ0/zZ6h?=
 =?us-ascii?Q?bHvZSZLtF59Hggk9C+mYb0nXzsVoOakA6FtQ80wUXDbZq88YFOKMGJ96/r+h?=
 =?us-ascii?Q?XCOc/HSKG+m0M4keVIU+qPxu/7W2hDRPgQba1hVTLkLGaFX1q8VdweWH/gxJ?=
 =?us-ascii?Q?zw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f57ac2e-489d-4304-3c94-08daff023e79
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 18:30:33.1528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sF8lKod7JIMN2bY1J6koShD/5IKUMq/laIbU1O9GM7d3Fe0uj7Y44WJn1GZBpYSAY9L0GTarw30fzaxrwAxPWeU4XUd4CSzqAV9GuO2Wox0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5519
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
> Split the block device case from swap_readpage into a separate helper,
> following the abstraction for file based swap and frontswap.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/page_io.c | 68 +++++++++++++++++++++++++++-------------------------
>  1 file changed, 35 insertions(+), 33 deletions(-)
> 
> diff --git a/mm/page_io.c b/mm/page_io.c
> index 6f7166fdc4b2bb..ce0b3638094f85 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -445,44 +445,15 @@ static void swap_readpage_fs(struct page *page,
>  		*plug = sio;
>  }
>  
> -void swap_readpage(struct page *page, bool synchronous, struct swap_iocb **plug)
> +static void swap_readpage_bdev(struct page *page, bool synchronous,
> +		struct swap_info_struct *sis)
>  {
>  	struct bio *bio;
> -	struct swap_info_struct *sis = page_swap_info(page);
> -	bool workingset = PageWorkingset(page);
> -	unsigned long pflags;
> -	bool in_thrashing;
> -
> -	VM_BUG_ON_PAGE(!PageSwapCache(page) && !synchronous, page);
> -	VM_BUG_ON_PAGE(!PageLocked(page), page);
> -	VM_BUG_ON_PAGE(PageUptodate(page), page);
> -
> -	/*
> -	 * Count submission time as memory stall and delay. When the device
> -	 * is congested, or the submitting cgroup IO-throttled, submission
> -	 * can be a significant part of overall IO time.
> -	 */
> -	if (workingset) {
> -		delayacct_thrashing_start(&in_thrashing);
> -		psi_memstall_enter(&pflags);
> -	}
> -	delayacct_swapin_start();
> -
> -	if (frontswap_load(page) == 0) {
> -		SetPageUptodate(page);
> -		unlock_page(page);
> -		goto out;
> -	}
> -
> -	if (data_race(sis->flags & SWP_FS_OPS)) {
> -		swap_readpage_fs(page, plug);
> -		goto out;
> -	}
>  
>  	if ((sis->flags & SWP_SYNCHRONOUS_IO) &&
>  	    !bdev_read_page(sis->bdev, swap_page_sector(page), page)) {
>  		count_vm_event(PSWPIN);
> -		goto out;
> +		return;
>  	}
>  
>  	bio = bio_alloc(sis->bdev, 1, REQ_OP_READ, GFP_KERNEL);
> @@ -509,8 +480,39 @@ void swap_readpage(struct page *page, bool synchronous, struct swap_iocb **plug)
>  	}
>  	__set_current_state(TASK_RUNNING);
>  	bio_put(bio);
> +}
> +
> +void swap_readpage(struct page *page, bool synchronous, struct swap_iocb **plug)
> +{
> +	struct swap_info_struct *sis = page_swap_info(page);
> +	bool workingset = PageWorkingset(page);
> +	unsigned long pflags;
> +	bool in_thrashing;
> +
> +	VM_BUG_ON_PAGE(!PageSwapCache(page) && !synchronous, page);
> +	VM_BUG_ON_PAGE(!PageLocked(page), page);
> +	VM_BUG_ON_PAGE(PageUptodate(page), page);
> +
> +	/*
> +	 * Count submission time as memory stall and delay. When the device
> +	 * is congested, or the submitting cgroup IO-throttled, submission
> +	 * can be a significant part of overall IO time.
> +	 */
> +	if (workingset) {
> +		delayacct_thrashing_start(&in_thrashing);
> +		psi_memstall_enter(&pflags);
> +	}
> +	delayacct_swapin_start();
> +
> +	if (frontswap_load(page) == 0) {
> +		SetPageUptodate(page);
> +		unlock_page(page);
> +	} else if (data_race(sis->flags & SWP_FS_OPS)) {
> +		swap_readpage_fs(page, plug);
> +	} else {
> +		swap_readpage_bdev(page, synchronous, sis);
> +	}
>  
> -out:
>  	if (workingset) {
>  		delayacct_thrashing_end(&in_thrashing);
>  		psi_memstall_leave(&pflags);

Looks good, passes tests,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
