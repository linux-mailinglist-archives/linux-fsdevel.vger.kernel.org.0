Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E6167B971
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 19:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235442AbjAYSiq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 13:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjAYSip (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 13:38:45 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84D2457FE;
        Wed, 25 Jan 2023 10:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674671924; x=1706207924;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cjJlmbsBJqA2otXOfFc4i1k2x0jo01D67fOxrZxjL10=;
  b=FkbWcd4qcd9nwPHoeltSlde9DDLN8gTk233qzOyXLuOLJZmB3UgRAc8W
   D69Ti5FI96qPdXhItHDJ2XguCL6d7Z0kVL3J3TG7YAHGNn3o4sszw9dkQ
   saxIxcre4enPfrQj23jmfaF6/WI6n1rWcir+Nm/oMpaUoYcw8mDk6W/jZ
   feSUGB5itlt7G2Dg24YZFo8O95UH+caZBPn/Apu1aDVc3xxq5HHdQUNif
   dYncoEIrJaOtFi9PJtdRKMq4JjidUhV1PdJr5Nu8SCSN9DJJb2/G92Oe5
   4JqIOR/qE/D1saauErVNFtFlqC/yyMxJ3OUvfEUrqTzmdqM+jwzxIIeZf
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="391150329"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="391150329"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 10:38:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="770834697"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="770834697"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 25 Jan 2023 10:38:44 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 10:38:43 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 10:38:43 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 25 Jan 2023 10:38:43 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 25 Jan 2023 10:38:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Emeasv8tfmarsj+1UxXvdH9K8YLfsUnfASAaEY0Vt5pZ4rJaa1uB5OY4Qwzv/k60xd65vQSo+4Q/ADHmihbfs01N1yWSJPXCSjnlxwygMxMIoTY/1f+eKbmL7pEjmlMClR4v5UYBj+oxXKVCMYbx0wTLfKDJRH63PONA6MierWbMspOZ8EFeHd8/92vfMEtpO/iDqoCCemmoB34KRqc0MNZ/9ChCNpwjkSGGPv9kAVxv9cLAmTHbvHS5GJ5cYNouoIbP19exdWYRQNTRiDqEcA6C/Y+jOYunX4B00Q8rFmd/zkmYG5b5odblEre1FZ811WDNdMhOIgtb3XOUFJtg6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=snFB5qfw7aNAw5sHQ2vQeXZVp6MuttF/LdLpK3eVoKU=;
 b=hjOKukWXNgyFkJag0WZ0GlmuhbWMe6UoLkcfqFUpwAMRndsLwp/QtpNlJzWABR/tW/oo2S4vJdIgTKRdTarVvaali+3HKDeNINe99WcySbBnw2iTRoxL0fsdz420iIRTgiOmTdPeFy/Ul6o8IQEmhrpeshHUPXLV7+vsB3aFERZA+H/6aGEjSd3Agk1nbFxfF+SOrsqB659pqb+g+Zx4HX24DOsiLPeZPWZnVyEYjRNwM0UdbPLk6KSi2IHQcBfvlKq1Ub43caaWoFmBHOojO4HvJEH4hVtH2qJfTTYV2DgfeOt3P7Gje/vD7cC89YZ0iLPwxg7qyIP9Y0QP0ubepA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5024.namprd11.prod.outlook.com (2603:10b6:a03:2dd::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21; Wed, 25 Jan
 2023 18:38:40 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6002.033; Wed, 25 Jan 2023
 18:38:40 +0000
Date:   Wed, 25 Jan 2023 10:38:34 -0800
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
Subject: RE: [PATCH 7/7] block: remove ->rw_page
Message-ID: <63d1772ae1bfd_3a36e529479@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230125133436.447864-1-hch@lst.de>
 <20230125133436.447864-8-hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230125133436.447864-8-hch@lst.de>
X-ClientProxiedBy: BL1PR13CA0120.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5024:EE_
X-MS-Office365-Filtering-Correlation-Id: b8671f18-07e3-4a30-e04b-08daff03610a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wZKHECNcRq0c8Nlp/iRCNel3NO6OJi1ixK2xmTYXdYFtIfKP4GxGckQR1kouFs0XG/VzHEy2cJK/ZjbEyffQhjpHIYYf6uDfxIjQBbDXj/xCBQfYS8AW6pCxjCgJrwmI492TOpNUa1AdnAyMLjoYiZD7rYZTAbM8faFoevaJ49nr6YzFaf1X6odFDL5JYxnTsV8lDWSWL8hR7h6H8ml5wI/QEdFT2Osm4sE8vbJkDJgyhdRTv7Ldc1fdpruYqMfq21vl51H4qVmZVPNw3mxVu0Fjz3yduCvTUIWOTSX72ocmBC/pE+oDVEk/0zJMaZGIZTOlXBtqbRAr0MHNttjgU6k7Ll4V8II36Ovj4Sq+wPGZxqWwy9zs0Sn0FIyy7NWO42YZ3nY4owPJw7fK6O9ACxXYFEqFYY85WKWkRyX5WhV/c5+AphQL/M9YCKviILx6eHcG/HWl9L9MnEeieYNpdNV+vmBOZBeBSr54YAKh98jAWm3m8vPA/SUdxfjhO8qrvfgDy2n5P6n1M3JK6s+0X2LaKIHzY/ISAwJtfJLK03AnG0kKZIIbh6WCG5IuJINGvvsnaVQH1oUAgim2Yq0NbvU7vk7X039EeNl15E7a2/fSgtYWlh2+1e2J1R9iOQe0+ec6pVo8zsSgVnKzmcnvxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199018)(41300700001)(8936002)(38100700002)(2906002)(82960400001)(5660300002)(83380400001)(6486002)(6506007)(86362001)(186003)(6512007)(26005)(478600001)(6666004)(9686003)(66946007)(66476007)(66556008)(4326008)(8676002)(316002)(6636002)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XzlqRaHFNJs4n+tmsYwAyBp/s4trqZWYYvqeLawXtE2FxKBcQ6io+pMIHv/J?=
 =?us-ascii?Q?VzttMNPDyMXWVmh+vPn2VS+3yP6scKQOvNlrapaD1spA+M02k09ZdnA27aed?=
 =?us-ascii?Q?0Il1I8X0EtezX/kE0QUuoA/FzhbKWT/medF10BSOWM9GmKuEpMVzDxp/kppW?=
 =?us-ascii?Q?t4RLX9GpgioUoAJEUi72j706JrcW3QWKRHLpHtU065QDP9wEaHhF2NrcXtZo?=
 =?us-ascii?Q?3qMadttOWGih1FHfSCmSs8c2yemTGVRWdvGDABvPBF3Uv5nHDVSyUJGY8o2g?=
 =?us-ascii?Q?Olu0Vjpl+UxE/QDW1edIS0K9dvXm8on4DCy8isUc61nIEa+f8lDd86lDz9Bx?=
 =?us-ascii?Q?8eyfDhnHhaOkJe7BvCUdzlHgd/w8IyFIgbhhr54iy9s7me78JPmiTfRKk+55?=
 =?us-ascii?Q?PSwBTQfc7MSE6NVTgUOgNsrxHWWgPkzMDrRn4Vm3Ad1lBjZkrOc5Z8jCjtaK?=
 =?us-ascii?Q?iwcRGf/6JOkzkQVDidg0wwrLogg2vNG/aoo57qL0NKB8UbPLezoObpmBRpzZ?=
 =?us-ascii?Q?etsl9hlB3kPinBAg026OrKbUq44RQbqWS4QZJCuoHyYe1ZJip6a14KjMzsIQ?=
 =?us-ascii?Q?4qoEf5GvDK/pSvd+5NvqpTRYKuzh5r9Q/7pSpQJVgvr2t8yLldNqOi4FJdbi?=
 =?us-ascii?Q?OSCS6HokA7JhTmGWVrBdO+6kn4+m0XgRaeC66L+bIfrZaVBqnO7Jjsz4rKeO?=
 =?us-ascii?Q?GnwtdT0SNIkbiY8h4fLsllgnKymI1oK74tD4y1/71VEVMrsml1ZDFXAiajkO?=
 =?us-ascii?Q?orf+qbn7NEWSKVf8O+SaTxWCXMMz3EOTGfipQQQZLsnV1rheivIJ9P5k8ZkI?=
 =?us-ascii?Q?OEUGNVF+y+eVCxvlq6gC6KmY7d/XLtl6FuDaDYkd367BoMCgsN0msCHqxSjx?=
 =?us-ascii?Q?aC0WkFyy7n1/6ZPHd102BjytODJMBr4L1/GwCvDBz8BRAIjntdN38yfw4bQB?=
 =?us-ascii?Q?yyaVTFQIOVnbkIb/cF1xA23Q0a1CY8/yzy3sriljtowU/paBhHZXI/s/vM/y?=
 =?us-ascii?Q?kyKt+Bz3yvYc5uqqyxiSnPf898kOhN/Yppun24neTLCmPhfc/ZHzU+Llm3uP?=
 =?us-ascii?Q?NLBQRkkHv+IOSwwaQNAXUV5g7f/4WhERO4N8IYZetJfZcSyRKGX+nubE7DCW?=
 =?us-ascii?Q?X1hRzrMk+EDGZUKN3IIDAUX4RjkAloXI1bQo6Uv+1ejHHcuIj78o+2Wehgbr?=
 =?us-ascii?Q?MbmfPwr8/AwFFHEhFYTqbjtFFQjTZZyit2U5WGNuEwRbSBA324thBx+lt+b2?=
 =?us-ascii?Q?vjr/u+Aqa84ez1QJBT+SV1dH3LID87Hbrfv6ItjhVTUoxdb19F5XO4sCCogF?=
 =?us-ascii?Q?Nh6w92o7Q13tLOy68CV+Cv8Azz0CWRi5a3h6WBEv6R3VnoJkBp7I7BZpv9h5?=
 =?us-ascii?Q?Z4nph88qCiQaS7v+Ae8WNJSYeW1GYzVHJT1ZKT/wslHXFhadjIYnpx8BuLe2?=
 =?us-ascii?Q?VQo2bop2B63szt2hC5zIrNbPFknPXBiI+Nlrg47OMr39BWxE9mCNYsabeBHc?=
 =?us-ascii?Q?CDrKBi9C/RzpD2PjlzJceFR6BryLm/UcmEdO2TodQ+9x9ays/Rxv1sUcxC/9?=
 =?us-ascii?Q?e8+4fZVV3NCEgi7icPOyENAs1JugTBzgwv3em0EenBCFiZOG/5aLcs7R5wBB?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b8671f18-07e3-4a30-e04b-08daff03610a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 18:38:40.5996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 60yrdDvIB+4fECgpCMu6K/Uv6m5KoF1+a3/+ivawN/rPrqop2wE8ILkyIARF4Z2ZrZvSXAO9yKMWCDtKr/iuuyz6dkXyMLGuSWp0MDCfKLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5024
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
> The ->rw_page method is a special purpose bypass of the usual bio
> handling path that is limited to single-page reads and writes and
> synchronous which causes a lot of extra code in the drivers, callers
> and the block layer.
> 
> The only remaining user is the MM swap code.  Switch that swap code to
> simply submit a single-vec on-stack bio an synchronously wait on it
> based on a newly added QUEUE_FLAG_SYNCHRONOUS flag set by the drivers
> that currently implement ->rw_page instead.  While this touches one
> extra cache line and executes extra code, it simplifies the block
> layer and drivers and ensures that all feastures are properly supported
> by all drivers, e.g. right now ->rw_page bypassed cgroup writeback
> entirely.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/bdev.c                  | 78 -----------------------------------
>  drivers/block/brd.c           | 15 +------
>  drivers/block/zram/zram_drv.c | 61 +--------------------------
>  drivers/nvdimm/btt.c          | 16 +------
>  drivers/nvdimm/pmem.c         | 24 +----------
>  include/linux/blkdev.h        | 12 +++---
>  mm/page_io.c                  | 53 ++++++++++++++----------
>  mm/swapfile.c                 |  2 +-
>  8 files changed, 44 insertions(+), 217 deletions(-)
> 
[..]
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 89f51d68c68ad6..1bffe8f44ae9a8 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -555,6 +555,7 @@ struct request_queue {
>  #define QUEUE_FLAG_IO_STAT	7	/* do disk/partitions IO accounting */
>  #define QUEUE_FLAG_NOXMERGES	9	/* No extended merges */
>  #define QUEUE_FLAG_ADD_RANDOM	10	/* Contributes to random pool */
> +#define QUEUE_FLAG_SYNCHRONOUS	11	/* always complets in submit context */

s/complets/completes/

>  #define QUEUE_FLAG_SAME_FORCE	12	/* force complete on same CPU */
>  #define QUEUE_FLAG_INIT_DONE	14	/* queue is initialized */
>  #define QUEUE_FLAG_STABLE_WRITES 15	/* don't modify blks until WB is done */
> @@ -1252,6 +1253,12 @@ static inline bool bdev_nonrot(struct block_device *bdev)
>  	return blk_queue_nonrot(bdev_get_queue(bdev));
>  }
>  

Other than that, this looks good and passes regression:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
