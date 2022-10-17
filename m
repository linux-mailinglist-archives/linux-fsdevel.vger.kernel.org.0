Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C27600762
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 09:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiJQHLS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 03:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiJQHLR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 03:11:17 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F342659273
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Oct 2022 00:11:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kntk93pvuBGuw4b0MYVwLNAQ2r5/Rb2tNSRNESUiczVVXcTSlB7FnyBwG5bVC2bhNcDsY5tPnWHFj/JtqwrpQD9U2Hmp6lgQHEaNgryiJeLVB9Yf7kJJFq0DYTao4x444z8IDD2Q3/DJmej2k/xhZt6gTGUvcFmloGXRkzb28G0a3RBKw5BiOXrMrYQ+ugP5h2JO/E/wMySxLE0/SO4rqtn/ZU5iJPPEv9qHCXVdZsPSrACMrBvrnrQhI+LtUwS48pgicMvZCs7TSENrX7AqYKJ7mu+jKJulaCnLbJhs1E4lWVWTW0EYfj7AAJKHgQhDo1/oGqRML5qZH4gRwH/Htg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nd1dh4zHVbiokpSVr6u7FYsLVem+xDDjtqO5JReMcyY=;
 b=KrgM13s/uambnjEcRn0RS0OkS9ZimbpydcxXeG1UcnWyMK6t6dftGQxz6n1/o4E/BgSlCz3qDKQWjOsihWsZr3GIaPXMIYJHhl27XLWHXG6Kc/7WhRFw+uTgd7NXvm2siQcsJn/9U1U5A/DEGxRcGpsH3XCyLowyWgziES+Kck+NcNUsUIdCB7n9CHwsh9+4aQr51KYJrJjCSZi2beRlCCjv9R34nBtJtKTqJ/+VWzqlMeg7lNBgXdbMHu4+H+gF8M62kiVBwRilwUVu70YBGRxQ8mBy/RKx9lLmydhvLBr8jrQD0BJO17emi0hxi2ThA11pwFhraeFkKfudf8tUZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nd1dh4zHVbiokpSVr6u7FYsLVem+xDDjtqO5JReMcyY=;
 b=NbpPsMscapvPyu8SdRPOSVu9HGsZWx/JJ2dAdxjBR+tgS8qXV6Zw1NoRnOElztjCu/vL57H8gD4I5k3HM1Ko2f3SIemANupM3Mev+YAalWbb8cH/1O6/Wyo7SqgqkzyRvx+4Tw89pOsqPRqqafbAy7RgNRLDvX0p8WP7InQWV1vD9cAZjEHjCll48UyWbt4PJVM+2OA3I2KECdsIFTb9bg0yVzxv/q43zaBbEXvZLTV49YoJ+E/azklmaMWtCVOHvQnCRtyvEBmIalhmaPkNWaxFcm0h5crcVag2BNBeiLpVjqmD3VApxFe0iYJt4PVU5Q6jq1sPYVtR0Kk6j5+T/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by BY5PR12MB4919.namprd12.prod.outlook.com (2603:10b6:a03:1d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.31; Mon, 17 Oct
 2022 07:10:59 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::6ed5:b1a6:b935:a4d8]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::6ed5:b1a6:b935:a4d8%7]) with mapi id 15.20.5723.032; Mon, 17 Oct 2022
 07:10:59 +0000
References: <166579181584.2236710.17813547487183983273.stgit@dwillia2-xfh.jf.intel.com>
 <166579195789.2236710.7946318795534242314.stgit@dwillia2-xfh.jf.intel.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>, david@fromorbit.com,
        nvdimm@lists.linux.dev, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 24/25] mm/meremap_pages: Delete
 put_devmap_managed_page_refs()
Date:   Mon, 17 Oct 2022 18:08:55 +1100
In-reply-to: <166579195789.2236710.7946318795534242314.stgit@dwillia2-xfh.jf.intel.com>
Message-ID: <87y1tfylfk.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0091.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::6) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|BY5PR12MB4919:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cb45c23-4ac8-4575-63ef-08dab00ebe00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ruHVP9JS2LL2/8S/sZRy5mdkOE0Pkq9ZtRUpQowZi++1wBoYROV13dyIZitWRcKqJeqkVMUNTetKDuq4lNAMupFnVqJFO5f937KQirCjOSr4ib1QkOLUAVS1tlE089sToM2fd8w0wNSDFSD+LFbElvaBow8UymN9qEc4O4vL6cjNrNVvGKm94LEqbmrVbwVUpAIDL9XSvLq8ba/rGhxEKJhhkUgFzVY4UGt05YjwWbBaSPVJ44ptSuej6EQjD67748RdQa8iH1OSxQDUjmdyxqnjGRnBw1Ug0kkezxB3EUjiZsMXVpSn3dX3HJ2cqO9X4KqGoonO/krvm9PyDEMtcaWvaNkXfk/oRQJWpT4r9jemakiCB1uCVMg1JwS028pi65F2QGQjnDKpjLKRIa1NKWLfNw/IlroNAiOQ54n+WX4guB7lsDD/+A7Aolj7TO7dGWhPYdYiJpB4qXcFsQVYBa7uBndbPbkWBOJZW+64SH2OaH2MlPP+6531EgH6OpIj9dAA8SyJ8n6698eN42ZRYpZNVQalT1iDInKsaXrGHkT7uU6zc5e8xILAtU9cslQUQeq7HxUDf9QaAVmbPCClvMwcTIBqB2CXeBZ21Ef2qgdapAUSaCf/AqqApMk+kOb6x413VvDXQDioxRSfzNcRRWZxnb2RQn9JyZ0GqrKIkhEEoWniNACUwJQOZGEFYjQOKmPQmZZ03EvN1CghPEOPAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199015)(36756003)(38100700002)(8936002)(5660300002)(83380400001)(86362001)(6512007)(26005)(54906003)(6916009)(6666004)(186003)(2616005)(478600001)(6486002)(316002)(4326008)(66946007)(66556008)(66476007)(41300700001)(8676002)(7416002)(6506007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O24kGiYkJnDG1N9PO3y2/naq9wOqlHJGVTuUtaor409gjuyMJHJknVnbahvo?=
 =?us-ascii?Q?WrLtft5yfQLmzCOZJvgH3Gted/XjSYtRZkHu9oYfhFxPFOWxCTgePuwhYQYP?=
 =?us-ascii?Q?T6ywp30gWnNdgI7cWZwmfrsLIyPrdYxM7GwVfZ6qNAOS6JNJlV+YlG41O6AY?=
 =?us-ascii?Q?IpA3GNgJNJD14qJFg4y9h3HDGI5bJhzjIWpO5MA6KyTjAVFuP4mLz45lKatF?=
 =?us-ascii?Q?6Xe1zFSPudVdoPmNKJv9qAk6W5uzQzwcTUBUHTeJjfIB0yMLf5DHqfGwUJuq?=
 =?us-ascii?Q?7L22y9SUMHJyv6pxdsw0tSxTwGQ9Aad1bpd0e57rC/pxF01jokyZyqJZyURJ?=
 =?us-ascii?Q?s1Qo0wm+/dKvxGEnDwCdjnGVa/1q8gJuw1H29nNva4antOn1EaEyU0EoAc0V?=
 =?us-ascii?Q?rmaRAS+M32ASTnVGjlBgHMugUr4YO89sxDI93SerGGwHxeNCcTjdqssQI+mJ?=
 =?us-ascii?Q?e9OO/a8ABGRc9+F6wOBA6tShNUhnMcobeUVjDFeMn7k9pWdHk8ikO4cWFxy2?=
 =?us-ascii?Q?tFkxCXqxwEpMUBq3DOY/jTYZV/3XJyY5teQQ/wF2TGVCvNOFFzAngdljdcyc?=
 =?us-ascii?Q?Fd7VSW33Hecvd8OL6CM3zMYON6Pt297ZOP9cWJ3cYfGFiLQsAQUtM0aOHbHI?=
 =?us-ascii?Q?c1M2MAYsMAJgou6j28fL3bOB7UEwnprdsYFgDErrC+weWZJcwOHAFe5NfsAi?=
 =?us-ascii?Q?yRh6dHPj0qeDVzTvJ+nZXrO9+zMymlRVlEh9ajZSHCr1v2ScujO+m72jBeIP?=
 =?us-ascii?Q?H1STwt53dLubg6+Xryo/OFVNh+Ke9YkdugHZP/qE9TnqmDbjFKSx6310EOL5?=
 =?us-ascii?Q?nULoZK1eiPxD8t05AJiDQrfq36LBEfgAsO/26w+JRoxTaqv0STxQ9xLc6Xf5?=
 =?us-ascii?Q?fJvsClIBqm+QHz8a9umQFwPqV+R1WpirJLgcTrkaa5B3VM2q8ReKwT57Yr5E?=
 =?us-ascii?Q?db3ymdxcIknEkJgpHew/y8b30kFkyUX66DMTfY3h4CxYUv4fA22MdZYpqRA2?=
 =?us-ascii?Q?AkUj/JqEHnUFr4gDboX0c+XWSYHWWaT+iqjcv+/pzB6axjOkZYmb2vruyRqe?=
 =?us-ascii?Q?SsAgIwbj4dg7xpt+mgL5OydDE9W59GSmlxmeBdY575zFHDhIs/Iu+AROyJee?=
 =?us-ascii?Q?BVRk+TQNGFRWuf2ZLbFyEMML8x/xU0jN7t9UPFKc+NYmlFgqH3noBciFvOwc?=
 =?us-ascii?Q?RG188oz5ORDxGnQ9kfEGdV0zpuHeiOlCO0E+3HLtdBAGTMQCCbMTIuvzGm6S?=
 =?us-ascii?Q?p8g7SO1Kw1dMRN7JZIRUl99C/sKtmHnTKhbNLJBFpPBCNGzf2b65wCku2FQb?=
 =?us-ascii?Q?XOAeT6yCke7nqygH9+NbqlsAKkxt8+ZyjouAEePfi+J307dN0gCKbzelUnLz?=
 =?us-ascii?Q?OhWiTDMSKPB1PQCpYGQMIU4argu4YmOcnXwDUhRDGF3VbXx5TJSH2nPDjAos?=
 =?us-ascii?Q?uyr0R7B6kfIIgepPM+elshi266aa7qQlis+s5euoXXLjLk4BEgGtzp/oNZoS?=
 =?us-ascii?Q?nKEFQanqkA8bB1Ra5O+TY2G57QecXzE5AcNrVAO2rQgVVtnxXcfHjVUleV1k?=
 =?us-ascii?Q?pGm68tfkHB51401Eu+lPqgihUF6CBZVCRY8xD7YC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb45c23-4ac8-4575-63ef-08dab00ebe00
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 07:10:59.3667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DroxnSy9YsSybpqobOW3Y5rr1dw36M0hR7RlCkSrzG0EcqphEpGZ0yAV5V5FLZo2mY+hru24FprxlkTc19bAUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4919
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


I didn't spot any issues with this nice clean up so:

Reviewed-by: Alistair Popple <apopple@nvidia.com>

Dan Williams <dan.j.williams@intel.com> writes:

> Now that fsdax DMA-idle detection no longer depends on catching
> transitions of page->_refcount to 1, and all users of pgmap pages get
> access to them via pgmap_request_folios(), remove
> put_devmap_managed_page_refs() and associated infrastructure. This
> includes the pgmap references taken at the beginning of time for each
> page because those @pgmap references are now arbitrated via
> pgmap_request_folios().
>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: "Darrick J. Wong" <djwong@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  include/linux/mm.h |   30 ------------------------------
>  mm/gup.c           |    6 ++----
>  mm/memremap.c      |   38 --------------------------------------
>  mm/swap.c          |    2 --
>  4 files changed, 2 insertions(+), 74 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 8bbcccbc5565..c63dfc804f1e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1082,30 +1082,6 @@ vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf);
>   *   back into memory.
>   */
>
> -#if defined(CONFIG_ZONE_DEVICE) && defined(CONFIG_FS_DAX)
> -DECLARE_STATIC_KEY_FALSE(devmap_managed_key);
> -
> -bool __put_devmap_managed_page_refs(struct page *page, int refs);
> -static inline bool put_devmap_managed_page_refs(struct page *page, int refs)
> -{
> -	if (!static_branch_unlikely(&devmap_managed_key))
> -		return false;
> -	if (!is_zone_device_page(page))
> -		return false;
> -	return __put_devmap_managed_page_refs(page, refs);
> -}
> -#else /* CONFIG_ZONE_DEVICE && CONFIG_FS_DAX */
> -static inline bool put_devmap_managed_page_refs(struct page *page, int refs)
> -{
> -	return false;
> -}
> -#endif /* CONFIG_ZONE_DEVICE && CONFIG_FS_DAX */
> -
> -static inline bool put_devmap_managed_page(struct page *page)
> -{
> -	return put_devmap_managed_page_refs(page, 1);
> -}
> -
>  /* 127: arbitrary random number, small enough to assemble well */
>  #define folio_ref_zero_or_close_to_overflow(folio) \
>  	((unsigned int) folio_ref_count(folio) + 127u <= 127u)
> @@ -1202,12 +1178,6 @@ static inline void put_page(struct page *page)
>  {
>  	struct folio *folio = page_folio(page);
>
> -	/*
> -	 * For some devmap managed pages we need to catch refcount transition
> -	 * from 2 to 1:
> -	 */
> -	if (put_devmap_managed_page(&folio->page))
> -		return;
>  	folio_put(folio);
>  }
>
> diff --git a/mm/gup.c b/mm/gup.c
> index ce00a4c40da8..e49b1f46faa5 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -87,8 +87,7 @@ static inline struct folio *try_get_folio(struct page *page, int refs)
>  	 * belongs to this folio.
>  	 */
>  	if (unlikely(page_folio(page) != folio)) {
> -		if (!put_devmap_managed_page_refs(&folio->page, refs))
> -			folio_put_refs(folio, refs);
> +		folio_put_refs(folio, refs);
>  		goto retry;
>  	}
>
> @@ -184,8 +183,7 @@ static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
>  			refs *= GUP_PIN_COUNTING_BIAS;
>  	}
>
> -	if (!put_devmap_managed_page_refs(&folio->page, refs))
> -		folio_put_refs(folio, refs);
> +	folio_put_refs(folio, refs);
>  }
>
>  /**
> diff --git a/mm/memremap.c b/mm/memremap.c
> index 368ff41c560b..53fe30bb79bb 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -94,19 +94,6 @@ bool pgmap_pfn_valid(struct dev_pagemap *pgmap, unsigned long pfn)
>  	return false;
>  }
>
> -static unsigned long pfn_end(struct dev_pagemap *pgmap, int range_id)
> -{
> -	const struct range *range = &pgmap->ranges[range_id];
> -
> -	return (range->start + range_len(range)) >> PAGE_SHIFT;
> -}
> -
> -static unsigned long pfn_len(struct dev_pagemap *pgmap, unsigned long range_id)
> -{
> -	return (pfn_end(pgmap, range_id) -
> -		pfn_first(pgmap, range_id)) >> pgmap->vmemmap_shift;
> -}
> -
>  static void pageunmap_range(struct dev_pagemap *pgmap, int range_id)
>  {
>  	struct range *range = &pgmap->ranges[range_id];
> @@ -138,10 +125,6 @@ void memunmap_pages(struct dev_pagemap *pgmap)
>  	int i;
>
>  	percpu_ref_kill(&pgmap->ref);
> -	if (pgmap->type != MEMORY_DEVICE_PRIVATE &&
> -	    pgmap->type != MEMORY_DEVICE_COHERENT)
> -		for (i = 0; i < pgmap->nr_range; i++)
> -			percpu_ref_put_many(&pgmap->ref, pfn_len(pgmap, i));
>
>  	wait_for_completion(&pgmap->done);
>
> @@ -267,9 +250,6 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
>  	memmap_init_zone_device(&NODE_DATA(nid)->node_zones[ZONE_DEVICE],
>  				PHYS_PFN(range->start),
>  				PHYS_PFN(range_len(range)), pgmap);
> -	if (pgmap->type != MEMORY_DEVICE_PRIVATE &&
> -	    pgmap->type != MEMORY_DEVICE_COHERENT)
> -		percpu_ref_get_many(&pgmap->ref, pfn_len(pgmap, range_id));
>  	return 0;
>
>  err_add_memory:
> @@ -584,21 +564,3 @@ void pgmap_release_folios(struct folio *folio, int nr_folios)
>  	for (iter = folio, i = 0; i < nr_folios; iter = folio_next(folio), i++)
>  		folio_put(iter);
>  }
> -
> -#ifdef CONFIG_FS_DAX
> -bool __put_devmap_managed_page_refs(struct page *page, int refs)
> -{
> -	if (page->pgmap->type != MEMORY_DEVICE_FS_DAX)
> -		return false;
> -
> -	/*
> -	 * fsdax page refcounts are 1-based, rather than 0-based: if
> -	 * refcount is 1, then the page is free and the refcount is
> -	 * stable because nobody holds a reference on the page.
> -	 */
> -	if (page_ref_sub_return(page, refs) == 1)
> -		wake_up_var(page);
> -	return true;
> -}
> -EXPORT_SYMBOL(__put_devmap_managed_page_refs);
> -#endif /* CONFIG_FS_DAX */
> diff --git a/mm/swap.c b/mm/swap.c
> index 955930f41d20..0742b84fbf17 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -1003,8 +1003,6 @@ void release_pages(struct page **pages, int nr)
>  				unlock_page_lruvec_irqrestore(lruvec, flags);
>  				lruvec = NULL;
>  			}
> -			if (put_devmap_managed_page(&folio->page))
> -				continue;
>  			if (folio_put_testzero(folio))
>  				free_zone_device_page(&folio->page);
>  			continue;
