Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4FA57D6E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 00:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiGUWcJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jul 2022 18:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiGUWcI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jul 2022 18:32:08 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75281B7A3;
        Thu, 21 Jul 2022 15:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658442727; x=1689978727;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8GXS+MumU8gPy/Pb6vPNNRn3HGXDtrkY3dK1BuNA0ts=;
  b=EWD1sTFyDLVHQVqTtsRm3dUMfyGTz4uhf806VXnrPyUhn4/GhFFmrkum
   osaiTWiRzyObiuiOppMkY8ZHF97EhbjMc3/zYjNGhdmsKX84M3r2ws7b1
   ub9FmjnEKxB0py+jYCawIP71yaRtjyDVZkt8LkYRzTFs9pZ7mIq02s+Dj
   39CzIOeLdufCxsHg6Omy+BiwMaMu0exSL5mjoOUfvkcx2VoYdflNMCSnV
   SqnVd8Bv1ofvmJ6U2Hf7D8rOT0RgwMVAhJB9O/2aGsgWC1kkcMgQWMpXB
   F68UL5Ap8ReJYzuhT9nO4obukkyMYBp8ODvn06LUS+GnoIa+L9dhNBf56
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="266960330"
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="266960330"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 15:32:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="725216106"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 21 Jul 2022 15:32:06 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 21 Jul 2022 15:32:06 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 21 Jul 2022 15:32:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 21 Jul 2022 15:32:06 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 21 Jul 2022 15:32:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBe93qd8+jd/o/JiqAaIWayGpb7xq3vxstvaUCnSofPtYF3XvG3sT9nt/oahbRbQMxbKBrHTeueihFan3gnYH8mzifDN2nC3y8PHyUl1SeEJ8aQCeG8LJIKSRa8NAANOoXGuNzGuhlb4KoQnVEkwEYkcNixY0i/17pGyhhg/It8ah9kgO4rVfuLjPRqFOe3b8jItwKgwge6003OjoCBo37OIJno/1btA8wh5ySAJfoUnxEzAGDB3YVxFHwG7TgdG33aB1UkN6KUImjlL0bDCHWeTAD11Wvs5+SzzffrFz0RB0D5DBlQq35q991PeCtJ2Rdw1CeWzBsScFX4uM9iOpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71GrRWGcPcx2KUURmgdCqr+s+OTMZzXWa1Xr0E0PzYU=;
 b=H+NYgfqGjTQyILMSbbJIyhzyYevHsF4S/+ZSNBwgo4J4jap3WvdzlYh3nUYX2jOo8vu5rBqYcx0g5NN3pA8sxg2uJUaxr3ZXrYPF4lJLoJ4nTTYihwlwQW1SjTRk7w+PIePoGYrDvhsh6rowPMWFK/c92sngz3E/4zVYhLzw+dkiBZecN9k/POat+obgH9ezsdGGIAeUoG5I6DKfkU/QZVkYLq/HEQ+BVdnPE21KD4V8WmK/ySCpOQcoTU061V3ZhLgBFvEdeUdIs7jKGkzMk4HwmpJ2x503LFliZl4rGvnbyEm6cq7M8lQ2+nufW/18vhT1JSSfUEyxNOPaFFtYXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 PH0PR11MB5029.namprd11.prod.outlook.com (2603:10b6:510:30::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.18; Thu, 21 Jul 2022 22:32:04 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::3154:e32f:e50c:4fa6]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::3154:e32f:e50c:4fa6%6]) with mapi id 15.20.5438.017; Thu, 21 Jul 2022
 22:32:04 +0000
Date:   Thu, 21 Jul 2022 15:31:59 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-aio@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] aio: Replace kmap{,_atomic}() with kmap_local_page()
Message-ID: <YtnT36RXiWQ/Qtl9@iweiny-desk3>
References: <20220706233328.18582-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220706233328.18582-1-fmdefrancesco@gmail.com>
X-ClientProxiedBy: BY5PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::11) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87c99078-9a90-4f83-7018-08da6b68d64a
X-MS-TrafficTypeDiagnostic: PH0PR11MB5029:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rnzYdvj54ex798mgpn0snKDbbisAqUp+0BwhNH7K4oW15C/gW8hJHwwVJyk14qY8xtFDMQ273/Remag5ojzu0J3nXcwjDAEG0xvBb4gZgoPdB6tiytpdN3tZykpQj9lgliaiZJMVANxaC01sEIOmAc5cTepIu3E0aukxHOrs737SeZxHwtEoGXUN82MZUnzDTwLsDuCxpF/am3R099TZSi9v/68AHw5AROVMYmxUiWGMT+meRs/v9gOSJeK5kA3FLaFQu8tGAtw4c5rTdRAxUrCMuWri2zfquM+V4fJkMfV8sJQJ2XHVZu1KVzl9uKCyW3+VvD7WZd4S26dBkwG3UmPlGqbnEw2XZjo66HQZ8w/K2EdzM+XoXTTBsQ5D3gmypiEwv/Hg5c9Ua/t1l9HMAQdlAqy8b2qAUGjRy/JnWgoUQyqnWvLWVvTyyQ+iAvqr0EbtNCd1khrBhG6LOm5VCWiOv7OzYAYIdc7lYXA2qGsj5ZP751rgAdOPEWp+uXir7c5t2DwcMz3mKqKRHzrK860NGTZsHHi/sqrKzzB8TEQnvOytWlGAdmCiR34rsZkBT/y1HoI04xaADvsFhJaH5XwTikLgMTPGINVNJQVWJIJs4AyxKw1SFokhFru/fa7ZqaYs+7qU5+6VG2E0ghR/Ay84fg3fA5uWuD5eS37nCdPRohq6KMzf34ouKUG+DVyZ7pYl1RzkJ1e7u9J0M+Phx/Ybxj1gmovaZkyUuAqm/3Wm6zNlyWeNZqXkF9159/6Z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(396003)(39860400002)(376002)(366004)(136003)(26005)(2906002)(6486002)(82960400001)(66476007)(83380400001)(33716001)(6506007)(8936002)(6666004)(44832011)(41300700001)(5660300002)(86362001)(6916009)(9686003)(186003)(54906003)(6512007)(66556008)(316002)(478600001)(4326008)(38100700002)(66946007)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oNzRzxDQ+7uNK+eByrjRQ18hQgOxAvrmFuetx3GQu0Fm4PJ0GozPGpBSuPET?=
 =?us-ascii?Q?x9xGHv2o2Y/28MWueewdap7p3maW0bQTdwQfjukHJ/jLiCatuX0vmOjZVBhf?=
 =?us-ascii?Q?DHHTWEDjpipt7J3EaPSrquwXyRLK/4UzpaCmYwq87a5mLe+OM2/5l5zAvTqn?=
 =?us-ascii?Q?Ccr+YfFyVeSP+ApnyoLXBIXAxJkyiu5IvN1Vk0kt8S/VBgNqSX2w6nQNnivi?=
 =?us-ascii?Q?ocEJNfivY5ZJPvJCgjZyvR04djN89PgrCAtJiayEaBhOLM0RE89OPnavF5Om?=
 =?us-ascii?Q?5oChdjveT3KYjdOYGfX73LXFoOav3gmogDmdkoF6OyjpeZhC8di/f6/q2RcD?=
 =?us-ascii?Q?wvcRHPC/Wl5YhtdMKgzwlppzonxGs6djd9C1t/W7mAvEF1peOASuIxh+1TUU?=
 =?us-ascii?Q?eqn2y43vBaOuEEfPgSih6q7CTOE0GelkHLGgqiulm0bR2wD7amKprS+sdb+R?=
 =?us-ascii?Q?q8KPjgWBPVWqSUVIAZ9JwlkGmoAsm9+FPys36A2taAlOMl7rhUQILi/3D3YA?=
 =?us-ascii?Q?ySrICUuTQtgzobv1GUgCOduzW2tcjJTyIKx55tw4a8jbf9WDOTonoSXNIHmr?=
 =?us-ascii?Q?YoD8Tvq70o3GYRhHeEw0XkPeEcArTm4p8Q/tvtgkhX7y06pXM8luc58PQzMK?=
 =?us-ascii?Q?DTzdfKXUzRuz3k6RkwlFp0ph8o/OoaqR0DZfYPaqnO1B6hcBLNchEfukGMtU?=
 =?us-ascii?Q?uYTwmJmyStnUltCRrJ6pl0Mnli9rDTnCanOUPHg72EVgWdfXkvGGoTbwcznH?=
 =?us-ascii?Q?/4r669icsKET7CX39FXbVOmjUIME5rzK6YsYKoRkLjrUOQ8Toanz/yjEuI3b?=
 =?us-ascii?Q?29XfTnia0iZVBsqyYEwK4M4vDeSgbfHsFfe/eNQhO0ljiXQumkkzKHb4d0rV?=
 =?us-ascii?Q?g6O9XJNIKYXbfmJQk/Qo3zAliMUlqAQMJahiSApABU0aDj2ZohBB3tsWf7LF?=
 =?us-ascii?Q?nGtPXCBnnt4cRLz2ozccQIaRkVIX8oxAz5qoeVAlUr2CR3tpnkH+A1k4naw9?=
 =?us-ascii?Q?TGnSTV6s2Q53/qChyDYeeOh71EN0mi3iq2SD5HOK9UouXTRdmjsoOZWFYqwL?=
 =?us-ascii?Q?pcRORUdtnR+7L1UfKuAAl9voJLU/LM3N7eCjsd16jML/TCZhA0uU6HR6zI7K?=
 =?us-ascii?Q?39iy1yoZSrSI5RslI/bW+WYYBjleatWuocKysWadQgB+H5ILsudRbtMk7y+9?=
 =?us-ascii?Q?Mqh37klVQ4bh58WJ4qPcaM42XEE+RsjfYap5dEmtLwpJNMQUaYeheIhkKLcu?=
 =?us-ascii?Q?EDfEUcCdwWUM/ZUimG0ONcMkeUMBpUlIMCceZbEvypyEwaUJaLbyhsgXMk4H?=
 =?us-ascii?Q?yAaeb719kwfNQbs5W+t4ZkUmaGaq3HKvUWwO1LNSf6xO9TxgLtggTfM2FWMr?=
 =?us-ascii?Q?bhYxfpokJKpsEIkL2Ol+mGElQ+BOruumKCee0kSEI2PM+HKnGGD4eCSC+HZZ?=
 =?us-ascii?Q?BkYaXP198a5Rw8a47AfPv47f97rO20bXL3GkUg1dWDxDOLZ2fwayDhqd0knV?=
 =?us-ascii?Q?NiIl5uZ9grtjjmqKP4DgvaZyrl9ruX1m9rCGgPgvBJh/yFweSyCyo3ktAC2o?=
 =?us-ascii?Q?TO/U20/xQf+GI0eAVlsE9AjnWy/4eG/WaNMrHGvf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c99078-9a90-4f83-7018-08da6b68d64a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 22:32:04.3413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KV9FTfDyPZ1mNQyX1v6VyvhAMgpH9x20S1E8rKbTuOhUaplkbEs6+UVC4bggBfqcTfCa7D+n+jxZyPEK76orYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5029
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
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
