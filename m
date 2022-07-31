Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C034585CCD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Jul 2022 03:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbiGaBlL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Jul 2022 21:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiGaBlK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Jul 2022 21:41:10 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0246C13F44;
        Sat, 30 Jul 2022 18:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659231668; x=1690767668;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=audiBCstPqMEsG0/vQrkFk6nQ5a4g5QuBEnDB3ZCOfw=;
  b=JPO8t7Uh5HD3V98WcZluXFdLnZCip/XReDb1ENN2ff1wP/oisTNINIPR
   kOaTC4WYoMs9yR5WxII0yf0RfmFFKrCJThCK8epdHfYuJ4knRhvRTU6eo
   txffzux1ViWqrklZc8pj47bhXbOAT5GfPX+daf2KmbtFHb9sU9snq4htK
   PbHM8v1531p3y8A6EFds7/kGZ+vPTe+yEQwUG8ed/E4lUdLkLVKcfWa3d
   fzyyLSzuy+TiMRq46zXSIkGAdU5C+GTQDQB+F3jurPk84uBSwMSBl/0VU
   qZ4q1+xKvuDQAaepDtGGlGuPNM8SK1dBCnPzusArKs5weO0vGfI7CimBE
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10424"; a="268725074"
X-IronPort-AV: E=Sophos;i="5.93,205,1654585200"; 
   d="scan'208";a="268725074"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2022 18:41:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,205,1654585200"; 
   d="scan'208";a="728098130"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 30 Jul 2022 18:41:08 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sat, 30 Jul 2022 18:41:07 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sat, 30 Jul 2022 18:41:07 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Sat, 30 Jul 2022 18:41:07 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Sat, 30 Jul 2022 18:41:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFfcU1lN8IMZ4WPpLxIzAycBCroEf7iX9XFQ4YY1k5LgH3SchBzTZKPU/NbQZRNUdkyP1zG3VD/E59JgqqZIwF4SMtcdZfxpXHygKyibveXnkPBbqWua5TWaGqpBf3VjiM5WDdpNX6xNwcN5ZOYc41XVPnEX5N9FLmUo6v1vL/PkFcBEUHTDKaBLSl1iWEfMvr5RSV05iaDPNrcVSs5zWwLonb0luxCk9ng3vEJhhFet9LoaXIYa/l2eMW2TwTiuru8M/ta7KT1t5TPVbeA4KRWPishmXI31JHnoinkyrem9FkHQA9AHg4hzRkoJrM4GQPw/DiOoSA6FPl3Qt0w1jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QuFAg/iB2fayqEJdy+121uKsI43jOGNzW9OGsXXQ3dI=;
 b=O9wu1rCPHfznpDiJoCAgwhykA0gLK49yFuG3TzGn3KqrmS4FpEAqlDonPLKy8NgQjVa1Gyt8bCesswgq8JXFpx9p4iaoCOioctdFxxA5+uc0iMp5/iGoTA7SqyWBRK6yOcWEpVbachpwAzzMYaD6GnuX+J0YLyspsj2chmYu95BDq3vCL3odWh97bpPu52QcDagoZBcvHeNLW1L/emUIprPUnMHpKfguiDqroudrCwBr7UN8x02i1hSALUwXh+FmCuRT255luT+WD9UMGPIpW8Hb3Pa5QN17cjHALPF9tZ7C5ey7sC1k5se0ANJG6BqWqxrxk67T4prW4Fng3KdjsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 CH2PR11MB4392.namprd11.prod.outlook.com (2603:10b6:610:3e::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.6; Sun, 31 Jul 2022 01:40:59 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::1168:74bf:ff5d:68db]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::1168:74bf:ff5d:68db%7]) with mapi id 15.20.5458.025; Sun, 31 Jul 2022
 01:40:59 +0000
Date:   Sat, 30 Jul 2022 18:40:54 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-aio@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] aio: Replace kmap{,_atomic}() with kmap_local_page()
Message-ID: <YuXdprlqIFF1uCUS@iweiny-desk3>
References: <20220706233328.18582-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220706233328.18582-1-fmdefrancesco@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0211.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::6) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20d09680-500a-4e8e-2daf-08da7295b86e
X-MS-TrafficTypeDiagnostic: CH2PR11MB4392:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NkGWcYaPAbkkGYaYhGkhWHFez5Dy1f2MjUdbAHWZS6B0pjT8yXhs5iP7ugzXt2iY8Mg6db9P0wQmE/nJJ/byNAOhA4P5OrhvjGzbEzjcadujYO8Otu/npG9pAWEjsyoh5ez42n6uAhAgV9blP8k1D5eqPEvt1u1/+0D0bNWrbW3FdHDSCgkpYtTxlz8vIL79ecD2ZrH53Gb8W9HKGOUqbyvhxqgLODOE7FwORbZomd2XG2qNSN7G96WzzTJ6pEgDxKwNvFDNRhelzJA/HwEVMHgqZu/IIbJXpKLtl36sqSApFXBP4HbCOS9DM4fSoh6c1v4fqBCMaduAXUK3/VCDy6lss20/oQ7BhbmeWQw+8815TrzbmSBL0ziS7T6EXYVjqAs2IKsd2qARs9JxXWfGoXG9uhs3gjR0t8sMhl0ZFwt6yG8HQvpYj9NjoirwUHn2V7BEN6+ELaFH1h8WW9ekjFLZN3y8Qp3opLFfNJpuJSOywg2jo1WYOicRy7bspbmCve+JcsEMK3l+svXPF++UQnSEKK1chd99gtCV4uaVC1JAunWoQH2yTvqgKnoGW2c3sSOMYfOnCbK1lSwf76E4j35TrIXXUW7L4PXQNaIMKD43AqIa4AR6fGlgjC9a7/c2Cgi2Xb+oyWl/Bt44sQkh5vO/tT//nFyYoSjQPakUeyZOSI5Bqt26U+CaOIVOZFcqC84JDgPp+OIEbn9h+0GKm1DL9/DuOmPWogSflsnyskM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(396003)(136003)(366004)(376002)(39860400002)(6486002)(8936002)(5660300002)(478600001)(26005)(2906002)(6506007)(44832011)(6666004)(41300700001)(82960400001)(9686003)(6512007)(38100700002)(33716001)(186003)(86362001)(83380400001)(8676002)(66946007)(316002)(66556008)(66476007)(6916009)(4326008)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5A4/A2wLHUqnm9DDXeFgauGOc/cWOVxKod6sJq8XHbGdmeE7Ll3L4baEOuIQ?=
 =?us-ascii?Q?bi99LJ6+fIgsjaEftvQLmxc9ho1GcKIAcD7pvX5Jh23Xq9ym4XdvR8mx1EuN?=
 =?us-ascii?Q?EFJGaccVIG+fr4wGURb4t4Y27XjpJ6eO48nRGfgIpoQtDfsDfpsjwr+G4ah7?=
 =?us-ascii?Q?PL6LsIvMnLSNBd9NXB+hZFDATi22gIyq4+EyT1Zd33NUG25i76/kVsdyZI9V?=
 =?us-ascii?Q?t3ZZEv2HJdj4iAok3z0PiyNgHh21b4sRiz57IOvSm/wKynjr+cZx8VxBNUxK?=
 =?us-ascii?Q?foBlkG4uKx29Gj8eInBNfZjahKyGnJAtjVYstZpYNaxWdtdlwB/ned7MHarM?=
 =?us-ascii?Q?/6mff+FaSvQQSEhbbv64Zi16T78Mhm4jZVvcAikQ+qkInpylciGCiDahyxCg?=
 =?us-ascii?Q?99D93ITuPGldQmCJorPYKTZKdwrzzLTui4TUysXQ482HRzD7axQZge6tXFcn?=
 =?us-ascii?Q?6e2WxZCtw0iXnZyW+ebhZ4whTBu1fJmMlWPQNPxHIqkgG3iv9DfpbwPBluVE?=
 =?us-ascii?Q?pqiNbnb+gycMXegmXXhWPN6c7VmFU2Q2QSff7PucjzIL7vUc7P/haD42uwB5?=
 =?us-ascii?Q?s3gMWy3r+/DnlGntJCfBeG8ejLOk4Uxa29xObb0IY1lE/ti+oOqx7H8ZlFjB?=
 =?us-ascii?Q?ePH5TcmrOXYRpV+tOQysxQl/5u5m7ZrRvD5g378aNRKOxzmwSRdym/kta9Zg?=
 =?us-ascii?Q?2S+Yv96x13HpXFhjrxgsBmNEaQorpc9s/WdtwaYKgIdhvCr6QZHUecg8xOjU?=
 =?us-ascii?Q?eXDlFjJNL1C6Ou6GlHZoWAjE+8ABq6PCVWC7lojfcnTmoZUbibfc6HQXMgx6?=
 =?us-ascii?Q?2wLnILaZSBvLy3DvAeBug04C/BtLbLZKpW7y30hXGgJsfPSS88yTBEQbdWSd?=
 =?us-ascii?Q?reNUNqS7NrB4LtFaad6MzqiCGGuEcpQnFkxZEBMZ2RaRjF9xYuxB7ybnfmJq?=
 =?us-ascii?Q?JscxatEBMn5YdAjJyD2QEwDjC97T2r5KOKsSWlORtfot1cUlSrzwQ3GuhYOT?=
 =?us-ascii?Q?66bfxDAhiYvKqTBUKDz14xWsT1hdp5C3aSfpsEXQ0QJy4N1kXju/QaHQJ67W?=
 =?us-ascii?Q?RoZXd4CLoo/dgYJmoCeX/N25OS72eSn/TeYwfl4X5B4a7b5nBqqecJGaQyZo?=
 =?us-ascii?Q?2LRbkoBAjgza1V/J3VfnOpo6i4kxDD28buYeUDqc6giBeHz3sDyuDqBoDNFN?=
 =?us-ascii?Q?eVgnOKZ6uz9QwTTnF0hkGTbQxVkJtgh2d+4r8CQsd99mTJ2FaJiXrRGfVRT4?=
 =?us-ascii?Q?osV8m0BcSUcD8rF5ryzNqm22dGqGnG663Hwsuz59ccWp//j/V9HZcPuE0uAE?=
 =?us-ascii?Q?Oru7EK7FwwSIePd5BegVruGdQ6JhE9/D1Z0tRwh6Sutt1q+vFtxyf2yVJOrS?=
 =?us-ascii?Q?LPtVffhZg0sdcWnh5XxRmsUbshQ/NZnhETut1jzy2dwskucQRDuVdYFi0E53?=
 =?us-ascii?Q?iGqvLrhXD60MIffBlVfj9QeVacVZYSvysstJenl1fZ/iJrkW5iPd5r6jZJFe?=
 =?us-ascii?Q?pgyWXpogZ+cwbSlLEMQrSVcoJW2nVE+CQZHHE3zq7onWyTmljyYSExyAB5bm?=
 =?us-ascii?Q?gUFNbuh5kVNpcs1GnHzfVpny1UJH9ODBdFJU33wH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 20d09680-500a-4e8e-2daf-08da7295b86e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2022 01:40:59.7518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fga5kkX63TfK6P6LCwq9/xkl4of2XrOplVXg5K6pZWYMBlgrsJqAPC1iQ8lL2muJNiy78LQPNJsw6hObijHglg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4392
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 07, 2022 at 01:33:28AM +0200, Fabio M. De Francesco wrote:
> The use of kmap() and kmap_atomic() are being deprecated in favor of
> kmap_local_page().
> 
> With kmap_local_page(), the mappings are per thread, CPU local and not
> globally visible. Furthermore, the mappings can be acquired from any
> context (including interrupts).
> 
> Therefore, use kmap_local_page() in aio.c because these mappings are per
> thread, CPU local, and not globally visible.
> 
> Tested with xfstests on a QEMU + KVM 32-bits VM booting a kernel with
> HIGHMEM64GB enabled.
> 
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

I'm not sure why this slipped by for so long.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
> 
> I've tested with "./check -g aio". The tests in this group fail 3/26
> times, with and without my patch. Therefore, these changes don't introduce
> further errors.
> 
>  fs/aio.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index 3c249b938632..343fea0c6d1a 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -567,7 +567,7 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
>  	ctx->user_id = ctx->mmap_base;
>  	ctx->nr_events = nr_events; /* trusted copy */
>  
> -	ring = kmap_atomic(ctx->ring_pages[0]);
> +	ring = kmap_local_page(ctx->ring_pages[0]);
>  	ring->nr = nr_events;	/* user copy */
>  	ring->id = ~0U;
>  	ring->head = ring->tail = 0;
> @@ -575,7 +575,7 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
>  	ring->compat_features = AIO_RING_COMPAT_FEATURES;
>  	ring->incompat_features = AIO_RING_INCOMPAT_FEATURES;
>  	ring->header_length = sizeof(struct aio_ring);
> -	kunmap_atomic(ring);
> +	kunmap_local(ring);
>  	flush_dcache_page(ctx->ring_pages[0]);
>  
>  	return 0;
> @@ -678,9 +678,9 @@ static int ioctx_add_table(struct kioctx *ctx, struct mm_struct *mm)
>  					 * we are protected from page migration
>  					 * changes ring_pages by ->ring_lock.
>  					 */
> -					ring = kmap_atomic(ctx->ring_pages[0]);
> +					ring = kmap_local_page(ctx->ring_pages[0]);
>  					ring->id = ctx->id;
> -					kunmap_atomic(ring);
> +					kunmap_local(ring);
>  					return 0;
>  				}
>  
> @@ -1024,9 +1024,9 @@ static void user_refill_reqs_available(struct kioctx *ctx)
>  		 * against ctx->completed_events below will make sure we do the
>  		 * safe/right thing.
>  		 */
> -		ring = kmap_atomic(ctx->ring_pages[0]);
> +		ring = kmap_local_page(ctx->ring_pages[0]);
>  		head = ring->head;
> -		kunmap_atomic(ring);
> +		kunmap_local(ring);
>  
>  		refill_reqs_available(ctx, head, ctx->tail);
>  	}
> @@ -1132,12 +1132,12 @@ static void aio_complete(struct aio_kiocb *iocb)
>  	if (++tail >= ctx->nr_events)
>  		tail = 0;
>  
> -	ev_page = kmap_atomic(ctx->ring_pages[pos / AIO_EVENTS_PER_PAGE]);
> +	ev_page = kmap_local_page(ctx->ring_pages[pos / AIO_EVENTS_PER_PAGE]);
>  	event = ev_page + pos % AIO_EVENTS_PER_PAGE;
>  
>  	*event = iocb->ki_res;
>  
> -	kunmap_atomic(ev_page);
> +	kunmap_local(ev_page);
>  	flush_dcache_page(ctx->ring_pages[pos / AIO_EVENTS_PER_PAGE]);
>  
>  	pr_debug("%p[%u]: %p: %p %Lx %Lx %Lx\n", ctx, tail, iocb,
> @@ -1151,10 +1151,10 @@ static void aio_complete(struct aio_kiocb *iocb)
>  
>  	ctx->tail = tail;
>  
> -	ring = kmap_atomic(ctx->ring_pages[0]);
> +	ring = kmap_local_page(ctx->ring_pages[0]);
>  	head = ring->head;
>  	ring->tail = tail;
> -	kunmap_atomic(ring);
> +	kunmap_local(ring);
>  	flush_dcache_page(ctx->ring_pages[0]);
>  
>  	ctx->completed_events++;
> @@ -1214,10 +1214,10 @@ static long aio_read_events_ring(struct kioctx *ctx,
>  	mutex_lock(&ctx->ring_lock);
>  
>  	/* Access to ->ring_pages here is protected by ctx->ring_lock. */
> -	ring = kmap_atomic(ctx->ring_pages[0]);
> +	ring = kmap_local_page(ctx->ring_pages[0]);
>  	head = ring->head;
>  	tail = ring->tail;
> -	kunmap_atomic(ring);
> +	kunmap_local(ring);
>  
>  	/*
>  	 * Ensure that once we've read the current tail pointer, that
> @@ -1249,10 +1249,10 @@ static long aio_read_events_ring(struct kioctx *ctx,
>  		avail = min(avail, nr - ret);
>  		avail = min_t(long, avail, AIO_EVENTS_PER_PAGE - pos);
>  
> -		ev = kmap(page);
> +		ev = kmap_local_page(page);
>  		copy_ret = copy_to_user(event + ret, ev + pos,
>  					sizeof(*ev) * avail);
> -		kunmap(page);
> +		kunmap_local(ev);
>  
>  		if (unlikely(copy_ret)) {
>  			ret = -EFAULT;
> @@ -1264,9 +1264,9 @@ static long aio_read_events_ring(struct kioctx *ctx,
>  		head %= ctx->nr_events;
>  	}
>  
> -	ring = kmap_atomic(ctx->ring_pages[0]);
> +	ring = kmap_local_page(ctx->ring_pages[0]);
>  	ring->head = head;
> -	kunmap_atomic(ring);
> +	kunmap_local(ring);
>  	flush_dcache_page(ctx->ring_pages[0]);
>  
>  	pr_debug("%li  h%u t%u\n", ret, head, tail);
> -- 
> 2.36.1
> 
