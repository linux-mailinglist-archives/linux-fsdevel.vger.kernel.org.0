Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4887408C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 04:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjF1C7o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 22:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjF1C7n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 22:59:43 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3146C2704;
        Tue, 27 Jun 2023 19:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687921182; x=1719457182;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BO9ajiiYOCpBancqcp8ThJyLdM+I/PnF+VY+nKahpNg=;
  b=AxOziirHpF4ZhnPWUNlnSjv5LhEh7ImwTrq+mwz315jwiJA2UgIQiCNF
   EhMe55JOBSnd5NirA9kdSmLjaibGfkXdM6yeDmzBlmJmRdLpRjRSs65tF
   lyYs/zSpON5EyvXMUGY5rCSXQUmREC4Q816ZhrsR1uQeVuCt4irul+PMQ
   p8LyXvkyWWhk+5c4aqbYSaPh9bWUV/MGwcuu371In62+jWle9VVXh9Pgk
   kXhg3GXW90BPurFQnGKH5WoTTn5c8agksNDLQ0FdCIn5t78ggXyewkQsr
   FTi2AqvUCV6X+axkN0y4/bbkMk3VBQMF6togDYjrUaSg8xmmKREqavlCt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="359228693"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="359228693"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 19:59:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="861332549"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="861332549"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jun 2023 19:59:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 19:59:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 19:59:40 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 27 Jun 2023 19:59:40 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 27 Jun 2023 19:59:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOSMXaMegF5NWq4sonrsJ78cumoZR8dPrctZMf+ClMcptIuVZj7HomE/S7qsBl/NFgRv+/Xqsg2TNJIS1aH1bCWhJpB4giCDvj9hi3WWi02+havvzEN+3X2UTUBJJzRjlZE+89u6Ip3YN86oZYPXxaAVW3W8KZr2tzJ5t/31pjR0nrqz7q9IPqrvBEr7VH39XyVOi8kdu/k5eMZCNzTl8LwshxXpeYDDj4DjGY2z/9WRs4AkCFsEEpL80cLu4HWTCEkTuTF1SZO4IGbI1iX1lMLNUzt9lm5q4PicH/L+D1K2/jFPWVY5SqcZVyFDfeIHwoneWklma2cuVx2LFP2WwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3x+dO56NwCurPa2bqOd5yK5lRt/i8+OrjELYkRWxCgA=;
 b=XZ6Myb9YB68Ht/CejppA3WtruRFNje9q0RnQTyAa+82s07UURqlxRyssmG75ZxQl135RoUty2v9opRUrm8TNr8AayoCu5YmRdQfIwmc8y3AeeiJzbTJ3Gii6b4K77KbHeTXUq4pfV8Avt6utXztOgjkmVji6kTNtQJoiRRro2FiaRhT8tOUxCs5ZvZ1ruprSdPolKKQsxIytJro4VOlXhOAkbdRUQ3EmpoMXm+IQNyTLUaWhF2BktU3H6r8zi65pdbbsZd3geCsq6j5KTCUjImwW7y9TRtv4742NoMmc+dkP7Znz6E/B24gaMZSpM5/sAprXJNiIVITlgFcYwabhUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SN7PR11MB7589.namprd11.prod.outlook.com (2603:10b6:806:34a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 28 Jun
 2023 02:59:37 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 02:59:36 +0000
Message-ID: <8d35bbf9-5843-39be-c429-3c43108520d3@intel.com>
Date:   Wed, 28 Jun 2023 10:59:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH] readahead: Correct the start and size in
 ondemand_readahead()
Content-Language: en-US
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <willy@infradead.org>, <ackerleytng@google.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     kernel test robot <oliver.sang@intel.com>
References: <20230627050702.823033-1-fengwei.yin@intel.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <20230627050702.823033-1-fengwei.yin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0030.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::17)
 To CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SN7PR11MB7589:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e4c7a7e-13cf-4ea2-e45b-08db7783b521
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5+A+yvu73O1z4tuSkwNjf9Rmt25muZO/HQNWLC03QnsRHRgZBtq3eCRnvtCLnet0oYzk1EZ1ygr7nYC/DwODZ1xbDHHFUDS3X5xHjze610duYmkrtaFXumYM3rNip5lc5a/rOG6XUtF+BPY8gUJ+KWfw0OzfAMK1C5stzNZKqfiArGECpCQ0AZGBM+bQzKIwe6IgvvSpq6PE8Kt0LN3j/Uw8mgMStzRfMjlok2IPQqcce6D0AGKD3sRhgAnC1SweKeVbDRYJrrK/KkbhE+lcdvYnReL0E9y1lS4MEYsUueYibL5DWYdv7O/cKTUEvFHQvDJF0XHWtscH/FlbMRGoIyRRztVIUd5ofBAJuDe4eE4kmFNo/6u6LAKpolsSZOyqzsSveT+FyKwsiz0gFIfB9Jwep/uTpeDhgDAUJ9O2G/P1m4t4DWnOSIpkBJ2n637aTQy3R3RR1tE4fcAXbP30zPs2ZoMnnN5sjduEWfJqDRS3950YnWLds30LP7hyo7z34p0IhotXvLWI+I7bN5TLyZ12qHFT4s7+7zY730DuTIdQZSfS1Ghu/SiqHC7GtMpndCcFgUaN95m51hT4KHibqzpF3JHpoWOIbEYcfS97OvLfisWjkt7yt+jq6VxCx+Um3LLSbH8xy9t6XqC6NlLw9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(366004)(136003)(396003)(451199021)(478600001)(31696002)(86362001)(41300700001)(66476007)(66946007)(4326008)(66556008)(2906002)(36756003)(316002)(966005)(6486002)(5660300002)(53546011)(6512007)(6506007)(26005)(186003)(2616005)(31686004)(107886003)(83380400001)(82960400001)(6666004)(8936002)(8676002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2VzSzlINkdWMnA0UDN0NHB6SG8vUHhOTjQ1Y1p0dWcyMFZUOXI0T3hlMCty?=
 =?utf-8?B?UlVaS1RjRE52cGUrd1NZZEh3VU5CNy9Ob3dTTkVvNnVtM2w2TUxKQ2p4VFhR?=
 =?utf-8?B?VHFReWNub3duN1RMeDFJUjN1WnZMU2lQdHNaaXFyYWlUR0lmclVvaENCMlRO?=
 =?utf-8?B?U1RaMjJWd1VFd054L3ZmYnh4SVd0VVgrc09pUmZodHNUbCtWQ05BRFBWNlBD?=
 =?utf-8?B?WTc5VmdzamRlZ1BWbmkzWkVnaE9LdGZRTVRSZXpDZWo5ZHU1aUc1QkY0NFYz?=
 =?utf-8?B?aUd1N3RSTUJrbzZrYWdGZVJVcHh6YVhxUjRlL2ZUL1N2QWJvNmR3TU10Q1Zh?=
 =?utf-8?B?RURBUFRYdHcyd0JlTHhGemp5bmpIci9XNlI5Wk1xeCtNSXVaSlNzYW9TdlBU?=
 =?utf-8?B?UWN1M1hXdjRaeGlXdmZmYkpOWlZxWHZnaE9IY3p0Zmt6eGJIM1IzcDExRThu?=
 =?utf-8?B?aHlDaU1NeHg2S2tGWk1saHdVczNvVk1JS3ZyMUZKdlNPdWlaOG1GaFBSbGo3?=
 =?utf-8?B?OUo1NEZZUllFeFJ4SzdvM3FPNFhTYUE0VllXT3lmT3lTY1ZReWROYkVNcGVm?=
 =?utf-8?B?ZTZnSUNWaDlETmJoeXBKaUNDZjlqRFowV0J6d2EvUk1TdXBDU3A1bFI4MDRM?=
 =?utf-8?B?cXpyVktSaVpUQllFcHpFcjlKYWtoYUR3MjgyMFNyVjY3TURVcGRvSkt5SS95?=
 =?utf-8?B?UTBYRXpkdm0rUS9YK213MjJxTUJyWUZlYys5TDZUUjRTZ25lQStTdXEyK3hP?=
 =?utf-8?B?ckNVOGJkR1EvYlAzUUgvanRKbHliS25zZUE3eWtLVlNkUnZhYkNRa1g0SXRN?=
 =?utf-8?B?QldqZnhKNkVyTEpzNWsrd2x4WGVyb2R0TzhYWUlpOFlUdlVvT2lrUkgrSjRk?=
 =?utf-8?B?bkppZFpKSWMrT3lBZm5hR1FjZ1lEelBDVTFFaWRBV2tmbHR6STlubEsxejJw?=
 =?utf-8?B?UnZyRWJ5V01tdTNGVlJlQStpTHpZY2RobWU2QnNieDJRRHhJQ0ZoNW5Hbkhi?=
 =?utf-8?B?d0dHS25FYlhvSzU0TXMvb1BFaU1zRUxaejNEQXZwd3ZGSVlIN2xkMUJNeDFk?=
 =?utf-8?B?QThDbzZUV2l0WUplTm0yR0lwODloNUlqUXNzNmdEMDY0MkpNQzlXWXZhbFlz?=
 =?utf-8?B?dGdUSDZUQ000RFJVUXFwS29mZktycWUzTFA0VE1KNU9yMktoZnNWTWZNWDYv?=
 =?utf-8?B?VTZXV01aUG1yYUkrUm9TblRkWWtYQjNidmM1UGFzMnNWUkcwbkRRU3hnck1J?=
 =?utf-8?B?a0w4RmQrVWVjQkJ1WXRQZzF4a0d3Wnh2MkRibzJsSXZKREtURjFNV3AxZGY1?=
 =?utf-8?B?U0grWkpuNUJ4c2UwL2laSHpBNS9YLzkwQ2dJL1d0QytrSHhiOFVlRTlrdjFY?=
 =?utf-8?B?a2hFK0dnSjh4M2g3SGI1bXpKUGoycm9RejFQQitBTVEyekxqazRSdUk1ZWdo?=
 =?utf-8?B?cFIzSDlpa2MrNm9YWWRDZTRVa043aFNuU09KcFZ3OXZCRmpGUHY3YzlGY2tV?=
 =?utf-8?B?NFlxblVEUzNobFJ4RUtBN2RsMWM4OExzZlpMWmdqWmNZblFsbkF3SDdESGRm?=
 =?utf-8?B?SGFtSVErTFlBOGs3Z1BvMkRrdkduWEhFeCt1NDJiYjhLZjNnWlpqVkMybDRz?=
 =?utf-8?B?MXdhNkxqR0tmSGdKdzNPeFhIU21senl4Ymx0eVVTM2ljM0JUaWNFUDRvL01n?=
 =?utf-8?B?dkE3R29GTEg3UVJXTmJ0bitBNEpwY3Q2TEpDeHRzMlZKRmI2LzY4SndYT0p1?=
 =?utf-8?B?dUZtdkU5QStaekxhVVdPRlZqcTFCTnNJMDlsSjF2V1R5VEFNSThwbnBHZEh2?=
 =?utf-8?B?U3V3OUtwM3h4OHUwL25VYXRRQzkzMXdpUC96WHAzYzA5Yzc4R25KSUVMcVJD?=
 =?utf-8?B?ZGhhSy9BWWFYT2VWRUNwZ2RhYXFKZTRZK3NRNkR3L0NTamJ1OU9UbWdxRWtV?=
 =?utf-8?B?OEtoM2UwcjZTTjh4NXY2ZG13cGZ1ZWUxWHFxa2J1SnNRU2paL3hha1drczhN?=
 =?utf-8?B?MXViczlzSUQ4bW9KMWY3S0MxNU1ITTVwaHNwaFlub1dJUXZPOGNiWWZOdUU2?=
 =?utf-8?B?UFBZTERYREFnWDhaOTI3YjZ4U292cFV6bUF1aHQ5OXoreVhuR2tmTGhIakNt?=
 =?utf-8?Q?pgLS0O2ycaypXRMc7SB2QX5Z8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e4c7a7e-13cf-4ea2-e45b-08db7783b521
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 02:59:36.9129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NDwQ3hzXMF4xVa9sPTe2rUTaa5AxeX7ob3n30QR0kskTXHW0ewqe3qX/Ic+wWsqQVfmUFnKDmuUgQxPg6Z283g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7589
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 6/27/23 13:07, Yin Fengwei wrote:
> The commit
> 9425c591e06a ("page cache: fix page_cache_next/prev_miss off by one")
> updated the page_cache_next_miss() to return the index beyond
> range.
> 
> But it breaks the start/size of ra in ondemand_readahead() because
> the offset by one is accumulated to readahead_index. As a consequence,
> not best readahead order is picked.
> 
> Tracing of the order parameter of filemap_alloc_folio() showed:
>      page order    : count     distribution
>         0          : 892073   |                                        |
>         1          : 0        |                                        |
>         2          : 65120457 |****************************************|
>         3          : 32914005 |********************                    |
>         4          : 33020991 |********************                    |
> with 9425c591e06a9.
> 
> With parent commit:
>      page order    : count     distribution
>         0          : 3417288  |****                                    |
>         1          : 0        |                                        |
>         2          : 877012   |*                                       |
>         3          : 288      |                                        |
>         4          : 5607522  |*******                                 |
>         5          : 29974228 |****************************************|
> 
> Fix the issue by set correct start/size of ra in ondemand_readahead().
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202306211346.1e9ff03e-oliver.sang@intel.com
> Fixes: 9425c591e06a ("page cache: fix page_cache_next/prev_miss off by one")
> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
> ---
>  mm/readahead.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 47afbca1d122e..a1b8c628851a9 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -614,11 +614,11 @@ static void ondemand_readahead(struct readahead_control *ractl,
>  				max_pages);
>  		rcu_read_unlock();
>  
> -		if (!start || start - index > max_pages)
> +		if (!start || start - index - 1 > max_pages)
>  			return;
The offset by one only happens when no gaps in the range. So this patch need an update.
I will send out v2 soon. Thanks.


Regards
Yin, Fengwei

>  
> -		ra->start = start;
> -		ra->size = start - index;	/* old async_size */
> +		ra->start = start - 1;
> +		ra->size = start - index - 1;	/* old async_size */
>  		ra->size += req_size;
>  		ra->size = get_next_ra_size(ra, max_pages);
>  		ra->async_size = ra->size;
