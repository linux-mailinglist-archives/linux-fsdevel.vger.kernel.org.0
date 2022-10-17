Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207D8600736
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 09:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiJQHFT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 03:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiJQHFQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 03:05:16 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7108A29C90
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Oct 2022 00:05:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqGpwsCi0E4R5pKsb7r0cIcpl+LcaO8M1TiQ5iaHkVbxpE04kilf/7XAc9fYn+NuNpI2riHm1wI9zE7YDk8vV0FxC58CrZuTru5WuDK0eau/84KyUujCf50snUhLhF2INyPnW4D91ktZneRUNzwks+EqE7J9x6LsiylXGhMraNHO4t6uoFCw2eapiUVjcePoKR7nAIeP1G2JRWFYENap/U9t+MI+wmgrWwWM2iM/I8ZbnE/Nbp0uSgIYVwCoXKf6TOircmUw32T8x9OjD0/QLRQ3PVwRG9nBrC4wRWFhs/sQ5DSlbXejYlOEMc6NEScMEQeyCWHHUmNRejQ3UG1CoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/Yfd18HbPGgUHUe3yWvEHh4SEtjFnK0Ynf5hVR93DE=;
 b=LLPe1LYK6ygjgETjeP+PhE4zMbY4JQESoQNSMynJz7rNghQr9bZtcRhyTtZ+lLd7sJzqQYGO4W/fZR8+4HCikvpkyRMUbmfoOaM1TUdrUpXgOnBz49bjU+ZZXVAxBBTYuFGH5FjpM6pgN/BastkxzGiTgNsNrRkVWVum96jyeqdU08n3e21UOcPeZW2UvSjrjDIfvXJTohCI4NmE+gu+0xGL/98Ik1pYCsHev/ZaeaP3AyhEXLyBT4i8JTsiCnoNED1zyt82wxEiGES/Z7V8iH63usLX04rarmL03FcJpR3ESNgFmW4f7ek6D29KEXdZSyIrAc8BRxbbfq/TMakDSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/Yfd18HbPGgUHUe3yWvEHh4SEtjFnK0Ynf5hVR93DE=;
 b=icQ+92aK9tIJuOFFsQ+VPst4Nq66kosbFrvcVunSMQtZrysQXKhmh/Fzz90G2E/eJA0RRdqBqPKacSOagLJPtaN9PFNiDPD4MWKPmVPP8ipkm3ZbNyzEkZAgjjRfP09LGPlDWdiTZVoocy4OsSbbbSRPBY2un0m/YTDSb9vrqSR1sRoxkpLorcRdCayOcn0mp1bVL/kj1hrL27Y/6VL2tiPI0znX2zMNE9sjvvzgeie62gMvzoZ9gQRSWsKH4+H4/rCbc8GK+PDQCjSmfvIp9j/RSVic16p/AhD+DRW0DXlgAUER9fWKEMU2/89a/SZikHknz6E4l/x31gqJ633O+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by BY5PR12MB4919.namprd12.prod.outlook.com (2603:10b6:a03:1d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.31; Mon, 17 Oct
 2022 07:05:10 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::6ed5:b1a6:b935:a4d8]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::6ed5:b1a6:b935:a4d8%7]) with mapi id 15.20.5723.032; Mon, 17 Oct 2022
 07:05:09 +0000
References: <166579181584.2236710.17813547487183983273.stgit@dwillia2-xfh.jf.intel.com>
 <166579195218.2236710.8731183545033177929.stgit@dwillia2-xfh.jf.intel.com>
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
Subject: Re: [PATCH v3 23/25] mm/memremap_pages: Initialize all ZONE_DEVICE
 pages to start at refcount 0
Date:   Mon, 17 Oct 2022 18:04:12 +1100
In-reply-to: <166579195218.2236710.8731183545033177929.stgit@dwillia2-xfh.jf.intel.com>
Message-ID: <8735bn0w2l.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0070.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::15) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|BY5PR12MB4919:EE_
X-MS-Office365-Filtering-Correlation-Id: a981b0e6-73fb-4f2c-79e9-08dab00dedb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a+3YEb3blekRRXhYRsV7yKlZLbe/SnxekapieoRh/XEBe4/CBXWeB5UTOm3vNCAtzfC+kLpJul8VyeLwuSOyVDOf0NP3psT73atpejzlmNX1k6kRaq30t7edso0ZFNyIXbK5BrIs/B58hpoJmsLiQ9TnAvqfiZJsPUzqKQa13wkwWGZNRmQ2hZU4pUVqWfaZGf8SC7lNTYi53XlYMP4Wg6kzjDZncMvKoocYJa14MPOEO6BCaIZf4OG72R5oapd4nc4WsNlQqo3RvbBzihjPxClVhrUIETThiJtBaJOvSpJL3zcckjramVTGHPiw9iW/DEDjxXpI1qUCNH6jTRlCDp1vXQ3P4fHTfIdjG/53gb3SVCJhGDNoYPqQzm/IkbNQsB3J/NFYScrGVIwitPKrXAG6h2s1OrL76jSBBkvM6/GL5i4pFAxCTvhtTO7hOrjCQQNyWIvuiLNoCdnjDW3f4yGuMxOz3E5XiZCcC/IMBU2qlYAJCl3H08HMgt2LSX4K8oUqONiAjy4JrVpllWJW1OLFIRYLQjcYpNsM6p4YAv1xpmW/54h3YASIFdnU4u8UlFMyIJzT0CR61JRaxkVYE+PutlyBRY3MAtUZheOdLIDtggqSA4r+8TJPzll0cpA77+eX5WADd5zyCmRdy+lujgc7THnoKkzDcAPtNzgzeZHu18BfUIb0Q98HfBtg4qITrtu6KzvccMCWS4boIKBkUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199015)(36756003)(38100700002)(8936002)(5660300002)(83380400001)(86362001)(6512007)(26005)(54906003)(6916009)(6666004)(186003)(2616005)(478600001)(6486002)(316002)(4326008)(66946007)(66556008)(66476007)(41300700001)(8676002)(7416002)(6506007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uFckLub5epW6bCPnaaEHWVcnOt12yQTRwqGKzJxHLCuYLcywMjBW0xYv/w9O?=
 =?us-ascii?Q?+Ug1cR0btwJtZ6VNrA1g5uZ9JIVni2hQkgttsonzTmUyFssaDRfsWYK1FNaY?=
 =?us-ascii?Q?bh8oIlrSMADvUID5Kg7eFtofXhAr7oOXyXoqgJEbDLzLoPlMccfxdRniBTj9?=
 =?us-ascii?Q?LbKmx9hKDfCrNgamcDemv23XSV+PpI4IgPo9Xg4/naS33hb/6b3dKy5Mtmw6?=
 =?us-ascii?Q?yuJ3Xe4dkYgr+lrpUEXNMyhGt1qZi7awDlEzgc+CAiBVoPEgMhvUXahA6Jcc?=
 =?us-ascii?Q?tgpgxOp7geuvZnvdetF8YxtdGlBxhhaw5Gs4/jxKbuebsGM4oxVdwj0LPh37?=
 =?us-ascii?Q?3Fo5t6WUE/taCqyaVaFoFn5Qu7MxbKebAYahF8zLw6kbXBu4Hus0Z43YeZ89?=
 =?us-ascii?Q?Nxl/4R7zVSDCioc4G7hGGXBrnnqZfcOvzQvpfuCnG2r7qyhf0F3FVWnskjiW?=
 =?us-ascii?Q?iq13TPYdoNiuDbubezMBxgTzdd8+zquiWA8g6sBBTDWRuOhiSNxMqxM4/YvD?=
 =?us-ascii?Q?8PvfGyf9aZEY2QpAuH1xuV7AQXaJ7wypov82yn6oIQWkRB9o8hxkv+afXULO?=
 =?us-ascii?Q?7cipJruK1qo1wXhZmFqFthAknSnBDFtxpQ3Aovhjm4ikPi6lq18GipkIGONP?=
 =?us-ascii?Q?oLTgQJfJYYkFcccrYIQS6cNhk8eJ55WXH0keyCgo4J7RsXFHfJWv+T6Ku626?=
 =?us-ascii?Q?8P5MmS7NlJ0P6ATKMVpHe0ixJlPN+xoVsgYYUGoM8jEo0Pss963cLUfNPZD8?=
 =?us-ascii?Q?H+xqpBR4PgaTnmudj12o81W22nQSa5nLQjjqXiViO+y0EZeIdXyivoWEw6IQ?=
 =?us-ascii?Q?sytKN89hNjIrQjDYB3kS5SZjgDWG1TuVRm9IADnpcKA+YHO2jWF2MT4PgUlo?=
 =?us-ascii?Q?iru20tSvruVUqHmsE1hG4FSs+cT7LDOx3xJI9HW2bPL7lwXFG1oOiYnzmGcm?=
 =?us-ascii?Q?wXenXw8dxzNWXVL00fxi4ZP0AQ0rA2ZVgbfQapwUZDA3kVFVD8UTYHzIk1CB?=
 =?us-ascii?Q?mEVqn2uG1sKKz0YlvMt1Nasd25e7FYBOI5HfPxwyKa8JPKDj08ZkPb4MNz1e?=
 =?us-ascii?Q?fGRf2HvXho674FYoWevKBMenyh3xliQo8yqSJzYSj78YGtByyic3fVcpOV5E?=
 =?us-ascii?Q?T2hbzigh6Yb1lV1e6bbaLkfaRzskzROXEplBX2V6EmLJKABL1PnILzUddezC?=
 =?us-ascii?Q?3skgkcwbaeyThX3DJ9KLkHplcl6tITIqP/NGbRmN4g6PIDJrGLbI5aFxHDJ8?=
 =?us-ascii?Q?OpnzBmW+B2uYN6390aB/HS+ZaVkI/zY3BCfyysbh9VRtCm7EGplAFJ/FV4RL?=
 =?us-ascii?Q?j48o2fu9URRoXyjKuSuN/qPCD6zGIhSHEb3JNaPjzlzFadyqoGW3dZJkrSIL?=
 =?us-ascii?Q?Hkx5DgcRa/qkyeJD43Zece5BNxkTR0XYYpQq379CatgwE2WtXdvEWnVPcncW?=
 =?us-ascii?Q?jX6aOea11ptqZ5gzp59FJoYU4rGPO/Bws83B453KO0VN2heTY4D5dRqLGgAW?=
 =?us-ascii?Q?cITYqNa1hlgCgexT7NqT+Y2v6sl2/RuNrUyJJCkHmVY1UKO05KRKNSQ3viIT?=
 =?us-ascii?Q?bMqpoNWYb7fpWBsXu5z6mY3+XBroWdbF9wbl3Mt+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a981b0e6-73fb-4f2c-79e9-08dab00dedb5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 07:05:09.8784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pqwJxqF0TFatfvkS5gOpage32VDyA2e2wnycFiUSWinhSHMKkcnk+E5JB6pujHtLo4bd7XcjjWRzixT/Y1ucFw==
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


The DEVICE_PRIVATE/COHERENT changes look good to me so feel free to add:

Reviewed-by: Alistair Popple <apopple@nvidia.com>

Dan Williams <dan.j.williams@intel.com> writes:

> The initial memremap_pages() implementation inherited the
> __init_single_page() default of pages starting life with an elevated
> reference count. This originally allowed for the page->pgmap pointer to
> alias with the storage for page->lru since a page was only allowed to be
> on an lru list when its reference count was zero.
>
> Since then, 'struct page' definition cleanups have arranged for
> dedicated space for the ZONE_DEVICE page metadata, the
> MEMORY_DEVICE_{PRIVATE,COHERENT} work has arranged for the 1 -> 0
> page->_refcount transition to route the page to free_zone_device_page()
> and not the core-mm page-free, and MEMORY_DEVICE_{PRIVATE,COHERENT} now
> arranges for its ZONE_DEVICE pages to start at _refcount 0. With those
> cleanups in place and with filesystem-dax and device-dax now converted
> to take and drop references at map and truncate time, it is possible to
> start MEMORY_DEVICE_FS_DAX and MEMORY_DEVICE_GENERIC reference counts at
> 0 as well.
>
> This conversion also unifies all @pgmap accounting to be relative to
> pgmap_request_folio() and the paired folio_put() calls for those
> requested folios. This allows pgmap_release_folios() to be simplified to
> just a folio_put() helper.
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
>  drivers/dax/mapping.c    |    2 +-
>  include/linux/dax.h      |    2 +-
>  include/linux/memremap.h |    6 ++----
>  mm/memremap.c            |   36 ++++++++++++++++--------------------
>  mm/page_alloc.c          |    9 +--------
>  5 files changed, 21 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/dax/mapping.c b/drivers/dax/mapping.c
> index 07caaa23d476..ca06f2515644 100644
> --- a/drivers/dax/mapping.c
> +++ b/drivers/dax/mapping.c
> @@ -691,7 +691,7 @@ static struct page *dax_zap_pages(struct xa_state *xas, void *entry)
>
>  	dax_for_each_folio(entry, folio, i) {
>  		if (zap)
> -			pgmap_release_folios(folio_pgmap(folio), folio, 1);
> +			pgmap_release_folios(folio, 1);
>  		if (!ret && !dax_folio_idle(folio))
>  			ret = folio_page(folio, 0);
>  	}
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index f2fbb5746ffa..f4fc37933fc2 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -235,7 +235,7 @@ static inline void dax_unlock_mapping_entry(struct address_space *mapping,
>   */
>  static inline bool dax_page_idle(struct page *page)
>  {
> -	return page_ref_count(page) == 1;
> +	return page_ref_count(page) == 0;
>  }
>
>  static inline bool dax_folio_idle(struct folio *folio)
> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> index 3fb3809d71f3..ddb196ae0696 100644
> --- a/include/linux/memremap.h
> +++ b/include/linux/memremap.h
> @@ -195,8 +195,7 @@ struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
>  				    struct dev_pagemap *pgmap);
>  bool pgmap_request_folios(struct dev_pagemap *pgmap, struct folio *folio,
>  			  int nr_folios);
> -void pgmap_release_folios(struct dev_pagemap *pgmap, struct folio *folio,
> -			  int nr_folios);
> +void pgmap_release_folios(struct folio *folio, int nr_folios);
>  bool pgmap_pfn_valid(struct dev_pagemap *pgmap, unsigned long pfn);
>
>  unsigned long vmem_altmap_offset(struct vmem_altmap *altmap);
> @@ -238,8 +237,7 @@ static inline bool pgmap_request_folios(struct dev_pagemap *pgmap,
>  	return false;
>  }
>
> -static inline void pgmap_release_folios(struct dev_pagemap *pgmap,
> -					struct folio *folio, int nr_folios)
> +static inline void pgmap_release_folios(struct folio *folio, int nr_folios)
>  {
>  }
>
> diff --git a/mm/memremap.c b/mm/memremap.c
> index c46e700f5245..368ff41c560b 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -469,8 +469,10 @@ EXPORT_SYMBOL_GPL(get_dev_pagemap);
>
>  void free_zone_device_page(struct page *page)
>  {
> -	if (WARN_ON_ONCE(!page->pgmap->ops || !page->pgmap->ops->page_free))
> -		return;
> +	struct dev_pagemap *pgmap = page->pgmap;
> +
> +	/* wake filesystem 'break dax layouts' waiters */
> +	wake_up_var(page);
>
>  	mem_cgroup_uncharge(page_folio(page));
>
> @@ -505,17 +507,9 @@ void free_zone_device_page(struct page *page)
>  	 * to clear page->mapping.
>  	 */
>  	page->mapping = NULL;
> -	page->pgmap->ops->page_free(page);
> -
> -	if (page->pgmap->type != MEMORY_DEVICE_PRIVATE &&
> -	    page->pgmap->type != MEMORY_DEVICE_COHERENT)
> -		/*
> -		 * Reset the page count to 1 to prepare for handing out the page
> -		 * again.
> -		 */
> -		set_page_count(page, 1);
> -	else
> -		put_dev_pagemap(page->pgmap);
> +	if (pgmap->ops && pgmap->ops->page_free)
> +		pgmap->ops->page_free(page);
> +	put_dev_pagemap(page->pgmap);
>  }
>
>  static bool folio_span_valid(struct dev_pagemap *pgmap, struct folio *folio,
> @@ -576,17 +570,19 @@ bool pgmap_request_folios(struct dev_pagemap *pgmap, struct folio *folio,
>  }
>  EXPORT_SYMBOL_GPL(pgmap_request_folios);
>
> -void pgmap_release_folios(struct dev_pagemap *pgmap, struct folio *folio, int nr_folios)
> +/*
> + * A symmetric helper to undo the page references acquired by
> + * pgmap_request_folios(), but the caller can also just arrange
> + * folio_put() on all the folios it acquired previously for the same
> + * effect.
> + */
> +void pgmap_release_folios(struct folio *folio, int nr_folios)
>  {
>  	struct folio *iter;
>  	int i;
>
> -	for (iter = folio, i = 0; i < nr_folios; iter = folio_next(iter), i++) {
> -		if (!put_devmap_managed_page(&iter->page))
> -			folio_put(iter);
> -		if (!folio_ref_count(iter))
> -			put_dev_pagemap(pgmap);
> -	}
> +	for (iter = folio, i = 0; i < nr_folios; iter = folio_next(folio), i++)
> +		folio_put(iter);
>  }
>
>  #ifdef CONFIG_FS_DAX
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 8e9b7f08a32c..e35d1eb3308d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6787,6 +6787,7 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
>  {
>
>  	__init_single_page(page, pfn, zone_idx, nid);
> +	set_page_count(page, 0);
>
>  	/*
>  	 * Mark page reserved as it will need to wait for onlining
> @@ -6819,14 +6820,6 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
>  		set_pageblock_migratetype(page, MIGRATE_MOVABLE);
>  		cond_resched();
>  	}
> -
> -	/*
> -	 * ZONE_DEVICE pages are released directly to the driver page allocator
> -	 * which will set the page count to 1 when allocating the page.
> -	 */
> -	if (pgmap->type == MEMORY_DEVICE_PRIVATE ||
> -	    pgmap->type == MEMORY_DEVICE_COHERENT)
> -		set_page_count(page, 0);
>  }
>
>  /*
