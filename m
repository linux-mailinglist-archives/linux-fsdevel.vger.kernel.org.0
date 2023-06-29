Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A23741E3B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 04:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjF2CYX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 22:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjF2CYV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 22:24:21 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0366C2682;
        Wed, 28 Jun 2023 19:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688005461; x=1719541461;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iRWYc588DnPjwCZSLKDLMK3NT5M0wxxRz2EjZJct/iI=;
  b=GgcubjTQn9/xoqGgQVfud5M8BL4UAh4UyCHk16fpd+UcNHekR6RKCXh8
   vyHAc+OdWdsk2seSsGcgSIvd2NgxG3X2uAnIgTT0u2YhHUhxhh/10i1xq
   pYsRDsVACVNBVrSCr1JrOUfBCmhNTB3dlmTEWHOv4YmCK3RzH8MsrHWwy
   mOkxLIsRE/Th+atcx9J16I4eXsnQ1jHKcjzKGhAmDdmRUJUVhacP3JXPi
   S5WY/C5kpmk8N7RFw59akI0VCSTDYkRfB4ankRtAsClhRspCuQzMjn7HH
   wKPAlgGcZ+OhEbGMCeFoauDdEj4nbzwYsfSsSPTJLIB6LY8GBVvxUggzS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="428023819"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="428023819"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 19:24:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="782519620"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="782519620"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 28 Jun 2023 19:24:15 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 28 Jun 2023 19:24:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 28 Jun 2023 19:24:09 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 28 Jun 2023 19:24:09 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 28 Jun 2023 19:24:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2jZA7ZIbziv+PWqG6S3hQJFhHOE04Zu3n5zX1qVOjJxy/FfBzdOHoApGwwZgSnycSktCmhsyvykVPM2LeTIIlo4Xcr4XcGJDs/1VMZQ0sLbfOyP6wHXYgo+PI6QGRC6kilbdDVBoB/fXflNtO/xRy2sAxjYNjC/LoFPt6GC404lfusmsT6mGKkYnPtxvuzGcRGrcMvrntBU4AE6f592ahb9PSIcjjeIRc9LNd7B8sz2RxPoHjFpZe3HA2p+Ki35TBy4H3bQ6t2c15cCB1lzBcOEXW8mfqGMlEEq6aqyvfvpyI/l4uXsF/jqori+Gjmg5A4pMaT/QweBV4TwQtemIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hB2Qd1hFUs2CTFyP7aNujvvifV71goBM4QFyawLvpM=;
 b=FXh2pN4oRsBQ+W+HoUseaFr0GZjsspnYX80srJvlNR4MaZY17QQaFLNH+OywhZQ0XRQUxEARjDUT1w/G92cTk9CoKjOL7azhCiPevBnVQhk70DxudoWDC35ODvfHb99/jiigH2SzbVhXsCyFEC6jhZ01iN1NpJ8pdL9u2CoPfrqgdlrvdB676/OCyXW3TxErVMd4bi6l2pDREYU1TMKvXrE5LZhvWwAxlPFvU/86lpbogTGM38Hn88H7IhuyhBkvzpN3GUci8YQBsShyuYYikyXXiMa8MXUCsF8E7rZzSQVOdsiaFRIrcSLiTd02SY3z60ovW6MQbMmzDNv78ZR8LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB8122.namprd11.prod.outlook.com (2603:10b6:510:235::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.41; Thu, 29 Jun
 2023 02:24:00 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5%7]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 02:24:00 +0000
Date:   Wed, 28 Jun 2023 19:23:54 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Sumitra Sharma <sumitraartsy@gmail.com>
CC:     Hans de Goede <hdegoede@redhat.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Fabio <fmdefrancesco@gmail.com>, Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH] fs/vboxsf: Replace kmap() with kmap_local_{page, folio}()
Message-ID: <649ceb3aeb554_92a1629445@iweiny-mobl.notmuch>
References: <20230627135115.GA452832@sumitra.com>
 <ZJxqmEVKoxxftfXM@casper.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZJxqmEVKoxxftfXM@casper.infradead.org>
X-ClientProxiedBy: BY5PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:a03:180::43) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB8122:EE_
X-MS-Office365-Filtering-Correlation-Id: 99fadb08-2a05-4f8f-40ae-08db7847e5de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9HwO6wWdsng3ldJyr+TzKq85iDsSBujhZYBb6VLjiTpK1sDdjo6qD2fpzXscN9J4FLOBYgBbRaKznkxMqQY2fwF/5DtNhhf8v+4gPQwQiEgYyUCW2EiETF2Vpzlc6esrzw5OV4g18gg3Bz3iDriFsD3zytk9aiJeGgNr2wYxtjlcVzjWiiXpMu/f8Sw4hFpDBsdvcFI0/Pog6dGXEhIxc5Aao+o4TeiT/cNEJ8tcKti1qO8Eqryp2+p7pReNq8622DmzHVDnjivDr1S8U28+ohT+B+DbSeG2zmV7G+P+VUdJ3CRvg735+hCMFVwOT/AFLBqui98CoiaT9yMZJgCnEzgq8IcqAqQ5545bTSb/Ctc3lXGE8nlmk0a1F1q2ART1Mh9whP1Scs9CA9nImu18ZQFUuUtK7oMT7gToQURAKkkzCDjO0M5scjgkOZ9n7sYq1ABpVYHBV97sLaEW/AIoJN6DmIk8efPkfLq/rpmrjLcBdmCyj0YDmZsFg+iD3JoYW3mHNLgPNRgA8tsu93yEL4x/6ij3OK4uAeJQ5eKyUDKe5MrSGeAb+OJfRBgy6aCj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(136003)(376002)(396003)(366004)(451199021)(316002)(2906002)(38100700002)(41300700001)(66556008)(66476007)(83380400001)(9686003)(26005)(6506007)(6512007)(4326008)(86362001)(5660300002)(66946007)(8676002)(6666004)(6486002)(82960400001)(186003)(478600001)(8936002)(54906003)(110136005)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wMg/5txX8tdiY07zau27T4/FoiaS8DoXhGZ97aXECA3wQIrh3E2x40/8tvB3?=
 =?us-ascii?Q?sGzvv6XdUgb+rIJf6JoojH+OL7T7j8A16rpNvPZtEcgvDEVh/+c1U0rUU9p9?=
 =?us-ascii?Q?jyDj07gn4hYwfbDsvtkKmEp+gFNl9uoQfDoTyacQpNVhV9pqjC3GFDnhZ5Zy?=
 =?us-ascii?Q?P2wQg/UormSzwrfIBBVCuYW1vC/jOL6btJfKuR13YhulzFuKAyMnwhQUa/8t?=
 =?us-ascii?Q?PwLPPapHt6ztKL/ApLfpH6/iE1wjmvgSqKsHKdssLOVZ/RJTXhh36FO3gSNn?=
 =?us-ascii?Q?gdAO/Ix2+C2v8IJByyHVwDQDCoj2O9+w5jM4GjZEGGVnYQtZHda4ce1K/Imj?=
 =?us-ascii?Q?evvxk4rIOASvwG+Ff2Fkpawv0xOqKYgnSgM+oItRVS5u7Tk+qat/BF/sCxje?=
 =?us-ascii?Q?u4Fo0YiEtJ7Lt3yAb0eQtkSItgFpCLIH3SDWX1f2h2zl+eqZjk5QHTRPlSag?=
 =?us-ascii?Q?HLMwqHfyabta0gwK5bM1qCSzek1sr6E1pCr9HYgIioPi1VRmU+2JdtvgZ8bG?=
 =?us-ascii?Q?4PBvaHfsi4sU4kQ1tbbQqOeX45PYPtaGig4wMruisJFweGNih5RyF9ma7OND?=
 =?us-ascii?Q?NPre7fCPY2SItSmbAiEXhVHC6IsAOmAFMeZT4P+agGP3XjzhcvLoXSQ/iCms?=
 =?us-ascii?Q?BE/KlElNRkI3hCf1fV+Zrd4pNqSVBGZBZyYJOYU9gVAM7PFKkuSf5VdfjIxj?=
 =?us-ascii?Q?oQjZfFoQgNsHczrP6H6fQqTdXf3KfHo72DGuC3WvXzmbZGg2xKvnzlamD9me?=
 =?us-ascii?Q?pyKxQ2TEPhVbZqL8SpRLVNJMXyAcjXLo3ZxYsHmiELBHnw+Q7HJ0Hz8r/mjh?=
 =?us-ascii?Q?O6j5kJljcZE/QK2hAcxNAdjzQcXIp95f/6smJWi1jf3RISIHyGd9ojrihzt8?=
 =?us-ascii?Q?oWdODDqWFIWE84C88aIpJTg67u7CbEW7OUMEzui47JnTjEj2GhXs/NUDUVDM?=
 =?us-ascii?Q?E9bVxb15A9mlUkLGhaKneO10Q2Y0Rd4j1pMTfLO2zWko1K2767HQKfX3gt6i?=
 =?us-ascii?Q?Y1BA228PVM9RkeTItRtOG+E7a5woGqw5TPRVVQe4xmJE6tQ+elZ1IH97qs3Y?=
 =?us-ascii?Q?ggoDPt6uwF3E90idIBZKc9moGk4bhxIsuJv7Ge8DJYp1u71/+5RY3T/48lEI?=
 =?us-ascii?Q?sMySGPvNCq1y/xBlSTiUWUDC1NZKwxniDqNCsUQ/MNCm2TDVIpZ5tFvJbaM/?=
 =?us-ascii?Q?CcwPBfUPC2dLZz6/p+Jj+CKx8G3IIJb5HN/f3+AniuF5MHBTBKTY4ckc3k3N?=
 =?us-ascii?Q?WNw5uxJ0frORr/OpB8MK9X1bEuMKmhJUGckH+/p8kE24Qt6nMt07wdDkJCar?=
 =?us-ascii?Q?NQz7T8jFcuvFEle+zPeuY2UVC5ldaUOm72j7HitLpAG7WqYAm3NOLqggntWn?=
 =?us-ascii?Q?Bw4UaDKPR1+FxtdiiPOjMSzNvbGuykS9qE3bAj/K86MjT907zvKeKUkyJJzI?=
 =?us-ascii?Q?5RN0lMY//TA2+WWZ54lP76w4I0n2ofufE8DQmkrqGx9Nu5S64ijJlGZU8CDF?=
 =?us-ascii?Q?SDhrMn6pXwtjpL1FWehae+pWb2ajCWre17vm/RNLdETSiRJpleSjT7Om9Ars?=
 =?us-ascii?Q?ibn1TkpyIMnFxSwJ4W99kUyFLOoo0+6YxH9ySNO/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 99fadb08-2a05-4f8f-40ae-08db7847e5de
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 02:24:00.1156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yG3/s8zIZFP77qH9L8r8+7QURRHU/QuQyDF41jgi3CCXClI5ZN7JW7io7fz8hy082RaIAlalgaZM44PNgjh5kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8122
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox wrote:
> Here's a more comprehensive read_folio patch.  It's not at all
> efficient, but then if we wanted an efficient vboxsf, we'd implement
> vboxsf_readahead() and actually do an async call with deferred setting
> of the uptodate flag.  I can consult with anyone who wants to do all
> this work.
> 
> I haven't even compiled this, just trying to show the direction this
> should take.

I'm a bit confused.  Is this progressing toward having the folio passed
down to vboxsf_read() or just an expanded vboxsf_read_folio which can
handle larger folios as well as fix the kmap?

Ira

> 
> diff --git a/fs/vboxsf/file.c b/fs/vboxsf/file.c
> index 2307f8037efc..f1af9a7bd3d8 100644
> --- a/fs/vboxsf/file.c
> +++ b/fs/vboxsf/file.c
> @@ -227,26 +227,31 @@ const struct inode_operations vboxsf_reg_iops = {
>  
>  static int vboxsf_read_folio(struct file *file, struct folio *folio)
>  {
> -	struct page *page = &folio->page;
>  	struct vboxsf_handle *sf_handle = file->private_data;
> -	loff_t off = page_offset(page);
> -	u32 nread = PAGE_SIZE;
> -	u8 *buf;
> +	loff_t pos = folio_pos(folio);
> +	size_t offset = 0;
>  	int err;
>  
> -	buf = kmap(page);
> +	do {
> +		u8 *buf = kmap_local_folio(folio, offset);
> +		u32 nread = PAGE_SIZE;
>  
> -	err = vboxsf_read(sf_handle->root, sf_handle->handle, off, &nread, buf);
> -	if (err == 0) {
> -		memset(&buf[nread], 0, PAGE_SIZE - nread);
> -		flush_dcache_page(page);
> -		SetPageUptodate(page);
> -	} else {
> -		SetPageError(page);
> -	}
> +		err = vboxsf_read(sf_handle->root, sf_handle->handle, pos,
> +				&nread, buf);
> +		if (nread < PAGE_SIZE)
> +			memset(&buf[nread], 0, PAGE_SIZE - nread);
> +		kunmap_local(buf);
> +		if (err)
> +			break;
> +		offset += PAGE_SIZE;
> +		pos += PAGE_SIZE;
> +	} while (offset < folio_size(folio);
>  
> -	kunmap(page);
> -	unlock_page(page);
> +	if (!err) {
> +		flush_dcache_folio(folio);
> +		folio_mark_uptodate(folio);
> +	}
> +	folio_unlock(folio);
>  	return err;
>  }
>  
