Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86A87AA730
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 05:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjIVDBl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 23:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjIVDBj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 23:01:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E5A192;
        Thu, 21 Sep 2023 20:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695351693; x=1726887693;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wZzjpgUeGO5DXNpmCdQkQpsu9UHw4NMxJm7OVDUqQNQ=;
  b=gtZ5dLx4sOIg4EciGd2HWas/LxfQIv6SRk+uU31koNGIONE63rvbDkqA
   MK6lFV6o5+wawV7bc+EKqOMoKUsaNWBLPlmNuVFrfh5j0+U91/uczkYey
   L+uS5RJV6FPFdD1HYqe3LGnpqEI6u0n83S+7hwUYHXUYPwDUC0LZI1/LH
   J21toTQDOnZpbEAwRcxrMXmSfPSwBAomXEp4rJhm8gnmSNOWIgCXGzEJG
   AizFFhkxtCdmoo+LKeJhpq0bawVb5AVpdIWn83emc7zGUY0QCPq9ebxkd
   t4MwLqz8drgeqB7FpgqwombtY6NCdvpJbwrCiXqgQoaaq+27D3O3OfxN4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="371048337"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="371048337"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 20:01:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="862766575"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="862766575"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Sep 2023 20:01:32 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 21 Sep 2023 20:01:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 21 Sep 2023 20:01:32 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 21 Sep 2023 20:01:32 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 21 Sep 2023 20:01:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKaQOlpBp8CoTRGWpdsvmIfiPpimzWSDE3MZti/1+u0ya1wlTGlX+WCba/GjQlK9GFhEqqT/4Q70gX7tIWHOack9sZMP8G8NgxoePiqAZLKpLqHAhT3uUYoL1FVmKAdIn0A8LUP3lh6/mUPu4yXONk7pmiRqnXgV8+eBgGVlhjQ9Oyniiiw93O+8YegSLjtG3VP1T703edNSc2YlaPG5kDrFWpuZbsBmQaHyQ7c1ckoG8ZCNB/UhcTflTH48GqCPrgnnUxZaAyREUM1ho9EaXa699nDiGIMXZFbvyCljXiVGMpYv/zwO0ffFGqv1U1CvZW7QIT3LqUINtubtKOFhfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTU32zQnAb57Q7rDkiB02xtupTtXnZnrMehDHKV+LlM=;
 b=FeLnsZ0ZdbGI8YMEvhfzm7x2A4WWpehL2Xl2TG7YKd8JyOmESQoq7T1tPVYlPjCQYhDGQ3nREnO5UuXh2KtlsyWpOuyc7+Ma959nhyrKTiGsYBBp9d02pLO1Tk1r/SnKGjwrHoUtyX/+r1S0oC76gq1ES/2Bw3Uxw5ab6Fls8RR8JolAS++kr7D7Iq9+f4jhZ2Crf0Ug3x6GfX+AyiI3QiOylHVtdbxQqeb+8yEIpRMt3P+agM2CD7UFhzfO/3GRC4n5KC1IL0s4A3KNmb6MyFMxqTbq6KzFDGoynF+QX0KxIQIYwQXjl2dusKhODRZrzZebhSkXheR0PGSOY2mjJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4831.namprd11.prod.outlook.com (2603:10b6:a03:2d2::20)
 by MW4PR11MB5821.namprd11.prod.outlook.com (2603:10b6:303:184::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Fri, 22 Sep
 2023 03:01:21 +0000
Received: from SJ0PR11MB4831.namprd11.prod.outlook.com
 ([fe80::afa7:e289:5ea5:cf7e]) by SJ0PR11MB4831.namprd11.prod.outlook.com
 ([fe80::afa7:e289:5ea5:cf7e%3]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 03:01:19 +0000
Message-ID: <64e96f3a-b9a5-49d5-9705-46d507fab3bb@intel.com>
Date:   Fri, 22 Sep 2023 11:01:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/filemap: increase usage of folio_next_index()
 helper
Content-Language: en-US
To:     Minjie Du <duminjie@vivo.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:PAGE CACHE" <linux-fsdevel@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     <opensource.kernel@vivo.com>
References: <20230921081535.3398-1-duminjie@vivo.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <20230921081535.3398-1-duminjie@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0192.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::21) To SJ0PR11MB4831.namprd11.prod.outlook.com
 (2603:10b6:a03:2d2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4831:EE_|MW4PR11MB5821:EE_
X-MS-Office365-Filtering-Correlation-Id: 26d49875-8613-40dc-8207-08dbbb1831c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4qvW7laCqROb2LuRRsVZJUqDLQlAKU/mzT1HdwqgYcHUNPjIDQxpiUtri6STLypygIRR7zx4GlGIaN/17z7UIRLiT0OnfnmKTqvgKoQePM19yxjjxvBtO33AMJtFOZUKZOZm1oSEKkHQmc9tLzqBxtQU+orYgy5qdWOtkJZtkGhZszisQBDa3HtBNcY7ELWNMDxeQ98G0fwP+5BePefwv870s8C6+ccErROkIINhe6qkoj9RCQw7wKESCQapbCUAe8b+hMpkmFBzuFRHVSBnJ/z5I4IBLgDeLFahhabaecR5NsDbtAZDK7EDwGXe/NwDnmAAbQdpc3IAtTNNYekxOL4GWovEukXAfBlSrMVVZA6Al2qnD3V1+KyhFbK1PtyR+anfWvpkZnUyW/15S4d+hRl/PUhlT/OTd4OF1W3ZRUwoqIQTcqa3SYcQ+PQCrMr4fLgv7IvPBeBYRBaLrHBgduaiVIbQRL2GuUHsYKrCDMHNoyZq/bcXy74WRWZxAPzeMbck3LuAP99xIZ6Ys64MUSlXNVeBRNJn8yoCTHKt4DifKgFxJHb6WHoYBq4XDYZQ1druNUmwLw2GOKiY2jGLKpQb+Ho6jwTmCKwql/GqwtRUbQyF+zDvnreuduTEm1nzLuB1aG05lHm5sU9XMn9sMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4831.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(39860400002)(136003)(396003)(186009)(1800799009)(451199024)(26005)(82960400001)(8936002)(2616005)(4326008)(2906002)(8676002)(83380400001)(4744005)(31696002)(36756003)(5660300002)(86362001)(6506007)(53546011)(6486002)(478600001)(31686004)(6666004)(38100700002)(6512007)(66476007)(66946007)(110136005)(66556008)(316002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmFrbUkrakUvVjFIVlVreVc0YXZyKzMwdnpWRUtHM1VYS21PMldlOGx0b2dM?=
 =?utf-8?B?QTBwWWxreThHc1djZ1g5aE00STFabmpXWDE0cVo4ckIrVCtRL25JaWJtaFVy?=
 =?utf-8?B?WUFkdWlSd3k5RWFjbjhqTGxBdDZzVW0zUmJ5QzhPMHE0SG10cTJwaFpDcEpU?=
 =?utf-8?B?dkZqbHBKMnFsbjAzOHJKOUdLaDB5Ylk5dTl1cC9nM25saXNzV3VRZzY1WUZo?=
 =?utf-8?B?bThsc3E5Q2ppNjJOdnRCc1MvUVRKMXVjSXczYlVGSVEyTFVVQjNReXB4UGdP?=
 =?utf-8?B?L1ZsM1h0N3ZrRnQrSzgzN0gyMXZjN2ZxSGZxWURzWDRnQkMyZ0orR01JaWJq?=
 =?utf-8?B?cmErSnpmRkFBYU4rcHFyRGpsZ1d1ZWI1UnEybmxiTDd1VGJ3V1dxcVREUGhM?=
 =?utf-8?B?c3VqdTNIZjJTdlk3UWZZNkMzQUFIR0gwQkU3TStIMkVLeXUvemJsQ2xYZWN6?=
 =?utf-8?B?Q0R4ak9YWnVSbDNmS2VjcnJlaWFyNy9FWjJrNVQ4a0tJYTZKbjU3WlVkcTBZ?=
 =?utf-8?B?NzFXWU1lVkpGSUJwdm5BeDFVQUY3cmJBN1ZaSU9jUi80UEJLd21OYVUwSi8x?=
 =?utf-8?B?dGZDSy9qckhWU0FCb2hMTzJ0QnNicDM5T0c4ZVVkOGhwMG41ellYcDRqSit3?=
 =?utf-8?B?enl4S01od3JMMEJZc3ZXcGsySjBWOVkvNjFSQkRGd0tldUlsN0txMm1lbXh4?=
 =?utf-8?B?K2VPMmZuWlB3RjRITmlybnIzb0U2Z2tBdVRoQTNZalZCWHh2RTY5S1UrbGsz?=
 =?utf-8?B?TUVpZFBuSHhBS1prQWlubzFRNEJXeVNzTzVwUkNLUUhid0ZUa0RzUnhUV1dS?=
 =?utf-8?B?VDN1R1VSYXd0MStIb0IzRkU1RXp1K0VLSTNDeUMwbmNBK0poMTRUMWJ0MzJ5?=
 =?utf-8?B?ZlVvc2JaSTRnMStPNkRxLzZsWjZmbWlMVjJRV1JMWVVpNXZSejNoWWdkc1VW?=
 =?utf-8?B?OUtKNGFjVlE0aXVNS1RJNWdhQkp3L3hJa1Z2OHh0anNxQzhmRmdpNVZ6bTQv?=
 =?utf-8?B?bEVYeDZsYm5oMG5FWE5MZnRJeWw3bmhHNmtCenhFVmc0NjlmYTNzbkhDeEpY?=
 =?utf-8?B?TXBxSjJ4WlZtSk85emkrWVlzTlZxTmdoTXR6YVRhRFpCREFib043aFpKbFB6?=
 =?utf-8?B?WmQ4OEl1NTdnT2s4Wk9TczU1TEVGRzZ0K2w3VDhqSHFvZjZQbWJkTnp4Qmw4?=
 =?utf-8?B?RGZDcWRFdUNmS2VtQ2JiK3B1TXY3V2JQeDh4NWdkL2JUUXlJamsxOVpiS0pt?=
 =?utf-8?B?cjdGRTl6YjlRRHhuQlZDOWJuTU54STc0YWU0VXQzK0FFVE96MjRHZkNleWw3?=
 =?utf-8?B?VVZpM1Q0d1hXK1EwOVh0Uzk0Qy9XYlFUK1ZHNDQrb0RFTCtJaGZUWGJoVk93?=
 =?utf-8?B?YTFGSWVjK0xIWnNnK29ySUhvbTNHa2xEcDBHUTdSQ0ZtbmdrcXhpbFVUdjQr?=
 =?utf-8?B?Um1qV0xKVnl1Y3ZkZ1pkZC9wNTZJN1lqZ1ozeDI0MStGbFozRkRFaXlSQXRF?=
 =?utf-8?B?ZDl1U3JqUzdlNGxodXVPaFhWNW9RTEtGTVpNZXZJU3kvVTd4YWhVYzFtUHhx?=
 =?utf-8?B?aGx2eU5GOEwrZXJwcEltbTFndHZMQ0RkRmhFWEZteG9Vem16ZGNCL1FxTFZP?=
 =?utf-8?B?TmxtYmtsS1RQVC90RWZzZzkrcjM1b0UrOXRENWY3UDJoSGJRdWdwd2lPWDIx?=
 =?utf-8?B?YTNHWmdUelVzeUY4OGpFcWNweVBIL2dnek84UWFkam9MYXhvOGRaWlpsaHJM?=
 =?utf-8?B?dnhCSDFnVXcvUG5jb0JsU3JSWEEvbzRBNkZLMjlrbHJwVnN5Yk90T3llMHNR?=
 =?utf-8?B?OGF2YkE2dU1mZ3pnVXZBSTVmbklTN2w4d0JsZ3BENTVlK2g3QURrcCtDTFcx?=
 =?utf-8?B?UEVzd1BhWmJhMEVVN01GUmQrTlJkY2xuUjdSZWY0SENuaHJzaVNmWlBTdFdE?=
 =?utf-8?B?dGc0QTVWakhRTjk5YmhoVXpKNmVJbUZqMEJRcEY1L2dTS3NsbDhBTXpQTkpv?=
 =?utf-8?B?L1pIQ01DbjhMcWdYemNzb0laNUlFb3hQZURxb3BKZmp6ZklnREFEaUVSWEZ2?=
 =?utf-8?B?aDA2Yitrd0pmS1lHMk15M3FYZEFuSVVzVFMxNE1HR1UxNDJOTlVrNXlGWGQz?=
 =?utf-8?Q?/CTcorOqeYUVZHVxvrXSR8+06?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d49875-8613-40dc-8207-08dbbb1831c5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4831.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 03:01:19.5456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fkjkqH6ih72qv0hKSO7Cha3Wz4M0t509ZZ1kSKqKsE2CBOMK/A1JqY1M8nkFtaRFGSWqMs4hJPPzBJYSjOSSzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5821
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/21/2023 4:15 PM, Minjie Du wrote:
> Simplify code pattern of 'folio->index + folio_nr_pages(folio)' by using
> the existing helper folio_next_index() in filemap_map_pages().
> 
> Signed-off-by: Minjie Du <duminjie@vivo.com>
Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>


Regards
Yin, Fengwei

> ---
>  mm/filemap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 4ea4387053e8..f8d0b97f9e94 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3591,7 +3591,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
>  		addr += (xas.xa_index - last_pgoff) << PAGE_SHIFT;
>  		vmf->pte += xas.xa_index - last_pgoff;
>  		last_pgoff = xas.xa_index;
> -		end = folio->index + folio_nr_pages(folio) - 1;
> +		end = folio_next_index(folio) - 1;
>  		nr_pages = min(end, end_pgoff) - xas.xa_index + 1;
>  
>  		if (!folio_test_large(folio))
