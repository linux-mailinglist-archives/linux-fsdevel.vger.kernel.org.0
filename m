Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CC154D6C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jun 2022 03:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348656AbiFPBHQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 21:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344002AbiFPBHP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 21:07:15 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5C637BCA;
        Wed, 15 Jun 2022 18:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655341634; x=1686877634;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lmxdoKaO/0j/BFyGaSXW7oqNjlPRyBjuIC+8EEQba7M=;
  b=OreF+on64514cpF6bYZew6M64YCHtTSOlaP/s+BSgjOG7T7YwRKZaolc
   zPRn8gnU6N1wXhzWFKhOgmpd3W60mxllRzhvyJwb76C6iAUUYzJchsl87
   KxyDeojMX9VrQZN9pZI1f8KZ0iNMiED8vs3mHsGYHcGVl4HVGWmR7k4ac
   B8xkvnItZwjWiPVhjq4ZJN1Q7USxtuWT7MRMTHZ1u40hBLJaBMh8z+pXG
   huIknnFKNqNjmnmEgOU3oNuSY1kh0Z+HoypvC9vIVD16BrClRDE5dGkzi
   UZago/c+XFNac/ly9xfb7hT9riQwBo/0N9yqXe0+a+cqtRlclAZnFsH1m
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="340793160"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="340793160"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 18:07:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="583445564"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga007.jf.intel.com with ESMTP; 15 Jun 2022 18:07:13 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 15 Jun 2022 18:07:13 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 15 Jun 2022 18:07:12 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 15 Jun 2022 18:07:12 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 15 Jun 2022 18:07:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0a1vVAvgsczFSQiqUp355T/jS+ltn9ekqGjj5MduKOYc+UVGJLHkZdmQ1jB3XlYbwhD4VCQGkBb7bv1z0WH2juOTQcQq1hacOywGoDyrC42Csy2C1WIRsbnPdpEPmhklWWf+WbRjPGL4C6g8orDkZWM6YKFEo62/eC2sTfalsUEUOszZIVTX/YTNuatWNkqrCmxLNMGvG7Ekok3H9Ik0FXSm3gPGrfPl5XmdfT6TZmZp23u0bVW81hwId2WPsSjxxVpZEPi2fKnMCGDa7XN5Yg+FB7eCh8nJwVn1nhEDXkCDk8zfe4tlGIeQpmIAhnAr1OFpWTq4GViv0TWb9d/UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HoWNdAE01qhx3qCirCe4hqfd89qyY1monwCw1n0bC70=;
 b=WXdATXOD4bkRO1/lNEWY47QrnOtihg53/x60PQHCznM9OedYjQ+CqrkLuij9J7Z6kRGq3vniGXoof/dT4DviN4UVGPBAbMlTvfufed/1wvQLBqTBI0FD6AVyqmsjPngV1jB0bdOcpVvFgOEo7z79llNuxsSgnDXToAcbQx6/81BhN02xKYpaPIPwsFPCQUXkc3CHXfD1BgbXBylzks/QeWwOp75pUviLLLwblsTQyUqgMO+JQqnCq0zeCygchzAYMsTfaooqNNE158oHaKGCJnq+qrGQT5vkbvNKRk4EC8Z9v7pRhzbWQj4dhN9uwzoUhFXqHa2FiL72qXbLlW7XFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CY4PR1101MB2358.namprd11.prod.outlook.com (2603:10b6:903:ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Thu, 16 Jun
 2022 01:07:11 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::39e0:6f4d:9c2a:85d9]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::39e0:6f4d:9c2a:85d9%9]) with mapi id 15.20.5353.014; Thu, 16 Jun 2022
 01:07:11 +0000
Message-ID: <304d2dff-ef46-180e-0840-8c6480de1f06@intel.com>
Date:   Thu, 16 Jun 2022 09:07:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [LKP] Re: [mm/readahead] 793917d997: fio.read_iops -18.8%
 regression
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
CC:     LKML <linux-kernel@vger.kernel.org>, <lkp@lists.01.org>,
        <lkp@intel.com>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
References: <20220418144234.GD25584@xsang-OptiPlex-9020>
 <Yl2bKRcRqbcMmhji@casper.infradead.org>
 <1e8deaea-5a05-1846-d51c-b834beb9f23e@intel.com>
 <YqnSWMQN58xBUEt/@casper.infradead.org>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <YqnSWMQN58xBUEt/@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0010.APCP153.PROD.OUTLOOK.COM (2603:1096::20) To
 CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3374133f-55e2-4ec9-5969-08da4f348ac3
X-MS-TrafficTypeDiagnostic: CY4PR1101MB2358:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CY4PR1101MB2358BC9B8601A8A6CDBEA881EEAC9@CY4PR1101MB2358.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cZP9932BnQBbOUX69QYuQpmM9/LvxzUqW3vri0n05J8ChtxyKxzEIyXPZKaew/QUCGrQ5B1KnKsdi8zvb075cXrqsqB78gWvuLNo3sbqHlVf+CmAuG9EaydtTMVxMxM6UcuOOG7EijT/72/zXopt3zJQXFBDU1mLXgVlMqTBwac+lgNJeSVh7rSknGf1ej31k35m77Fw7GmOMFpTBh3AYmI0e0sbGfkmHY6gMeZix/2Pu2XXMmHUIbfcCpI6hS1VgqWnFwrbKLjqqOIO8cZILtRJq3QfDPYZuCFVTt3Ek0TwtfaRv6C1R3S8VkLB67PR3ITjYE4dyqjZhDNkn+sFPsmzuPfdBD8a2V24VaWCQshJzHNshxLskbqQSTb/hH853Pgzm53cx9EHpvr28scy0rLzK5/ZzV4W4bv4eZoPQ5uNlu037FcvK32o5c8TJfUafMT43BHGyDqtxicmFWxHLB7f7uIK/ZTRjOfmGU+jElATYHCK+2nXrmihLmvJBuCq8gXnKkTqhkd0Lfar1lcVM+yruECQulEkPvGMCMrFx7gX9KS2iCKO4w9951yauVH38/luU31jz1tjtxFlHgy3QcU3d1eDXx74KWVKptfNVy7IubCyvVvZfOTrft1MeS5TOUzGTKX2Yv+fj+Q9cP3tlAJwHgIoVB0MAQuMzOnh2xSXaiB3jjJi/WuVNB2k6ZpVqVZcqyCfNnMgoLEkrqcn66ijK6y1u4X49ujSvIm/mtM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(6666004)(31696002)(38100700002)(86362001)(8936002)(5660300002)(2616005)(31686004)(6486002)(508600001)(82960400001)(4326008)(66946007)(66476007)(8676002)(316002)(66556008)(36756003)(6916009)(2906002)(26005)(6506007)(186003)(53546011)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ay9VMVkvV2tFdmphUHBaYXBVZUl6VGs2US9OYnVtZnVMOWVqbDNDcHlzRC9o?=
 =?utf-8?B?UEk4bFBwNFpMMk9wcFI1ZUxZMHp1V3FjSzBkazU5KzZLdEJBTGFSZHZSQUlw?=
 =?utf-8?B?bGxEemkzMSs2NUF6U1FFaEdkZHl5djBPZUdGbVY1OHAxZ3d0TFVmRGJUVmxH?=
 =?utf-8?B?MHdoajY3K2RIZWpiWUlqT0FpeWtkaFdYZkhQRjYweFZ0djNaRVBvRjFLajRz?=
 =?utf-8?B?cHVxMlNKbEx5Rlg5R0ZiS3g0MmV0SDJURXR1NW5LTmNxS0NRSUFuRzNudFRH?=
 =?utf-8?B?RnN4L3AvVHJiWTdLNkozVUY2QmFzWlNxanNOMFgzSnVVb2l0NTd6QWtDS2Qz?=
 =?utf-8?B?amVtN1p1VTB0S1p6K1lGZTdSZTFqZ1ZFK2pTSjNaTHRlcFJTQ0xyWUdwYkZM?=
 =?utf-8?B?UkF2YkphTnk2bkdVUE1VYUZhdFgyRDBPYzZWNTVHaWEvRjJ4TFdObitVc1lL?=
 =?utf-8?B?ZTFkOGpVMEdHOCtib0s2bkErSE9nVEhsdUgzSFl6R0lRVllmM210TUpQSlE0?=
 =?utf-8?B?M0ZJc3F0RW9vOEVkVGoySXdLSzZvRVR2cFVqUVBZT1NOMHJkcGtmVzIvM1ZB?=
 =?utf-8?B?UDVvMUw5RmFmQTIxYmhrNFAzOGg1WE5vZ3pXazJya3d2eFp0MXZZd0tTUmMz?=
 =?utf-8?B?UTBxbDFwSExLUHV0OXJpSlRtTVhPQjBNL2lBVktmOHJRV0dRRjAyVFhteFIw?=
 =?utf-8?B?WTZDdWNPNDhoYjJsUkphY3lMMkxnZjV2T3c0S3k3Z3hHUHkwcGt2SkxDSFI3?=
 =?utf-8?B?WmNhZTB4UTFrcFZVdDRpVTcxT3lqRjB4bGFnc2ZMY3lSaGtaMmlTSGN0V1c0?=
 =?utf-8?B?UFNEc0hDZ055VytmeWVsNk5sWGtZa0t2RjRZeVo1cWxCZ1B3YTg0QXJ0ZEt5?=
 =?utf-8?B?U3BmbjU2S2ZaMVZCQVZUOGNFanMzS0hVeERoQS9jaXVzNzZFVm5adFoxWHlB?=
 =?utf-8?B?ZExmZnhoVDdnUWhIS2o3V0dSM044MDNOTVAxQy9EUWNFYW1WSjBjUDBUL3Qx?=
 =?utf-8?B?V3dsZ0xWNzcyNTN0dWR5RmFjbmpSUGR1d1lGbUZKQXc1cUxnbng2NmhGYWo0?=
 =?utf-8?B?dVBXVzc2ZWlMWVRoVm9YTEtuUi9YMnlaait3OFdBZ2xTaThxZXZTb0t6QUFR?=
 =?utf-8?B?NXJDUkllRm83Sm1Sa3ZGeURlZnQzQzBhRnZkS0JqN0ExNEduVWlRZDNJbUVw?=
 =?utf-8?B?L2pwc09GVTRmQzF2ak1xS1BVOEpvQ2d0T0hkY3JKdWtlbFFLd3JGeGpYTTdT?=
 =?utf-8?B?ckJBa1JmVWhEVEl1K0p6ZlZLY1M0eGZ4YWpRc1Nwd2tiMGxZblJiVDJ3dmt6?=
 =?utf-8?B?T0NmUUJ1and1NEF6bGM4Q0Rucktsajh3blQ1RzM3YmtCeFFEU04rZkcyY0xm?=
 =?utf-8?B?YktMOVhtRjZOK0h2bTBoS0JLT01haUZHMTkxQUJ6OXZMdFFQNk92b1c3bVJK?=
 =?utf-8?B?ZzV4UGN2Sm5EaEZicWpPNnhBNnRxK3U4b25rWkN5VEpNdUdMcFBHcW14ZTdz?=
 =?utf-8?B?MHd4cGxGdDhvbzhGS3A3UVRONktHRWt3ODNQbFVuR3dWdlBjVVVMNDdNZWQv?=
 =?utf-8?B?WGFiRm52SFh4RXNUcG9yS3Arb25kME1oQWlQa0NaZW42Mm5KemdvNTV4SFJs?=
 =?utf-8?B?bVlLNCtuekFDczlENHlpV0tDczlCcFh3RHR2bktGQTRCWWVzTDd1cUR2cEdy?=
 =?utf-8?B?cnFYeXNVcmFvUjl0MHZRVm5rM1J5Wm91dlN1a2VnRjI4Z3VHRnU5aW1MeGFI?=
 =?utf-8?B?R0MyMnJXNm9vaGZGendSbU1OZmRwVHZHd1g3N3djKzlyUlZWcnlFeFc5RmVR?=
 =?utf-8?B?UThZaTh2K0RXWFNZUkF4K2FMeFJwZDR5ZDRoRWxkWjRJVzJqaGhONCtsbmk5?=
 =?utf-8?B?Q2VFRGZHR0ptNm9jZDE4dUlQVUNHRUJQUVdGeHBKSElKVERzQkovb1lpQzIv?=
 =?utf-8?B?Yk9BdWlYRU9MbGNET2NCZVltaGs2RlJvNEZHSDllU0xBYVlCK3N0KzI4cE1I?=
 =?utf-8?B?YmtOUEVER0JCQy82MXQ5R1h3aGozelh1cHpFV1J5VFRFTmlHV3J6VitxMnk0?=
 =?utf-8?B?bHpLMlZxRnc3NFFtUGRKVyt3dFFQWTdIL3g5OFVSeS96ZDBKNmEzMFZYb1F4?=
 =?utf-8?B?MGdQMVZ1anJHVHNKbkRUbG00UENyckFIQUhDdjFUV3Bycm15VHVGUWxUbndv?=
 =?utf-8?B?LzFjRG5xTncwdGlITkhOMXRsRXpweTNWb1pNczRqV0IrWjhOWnVZZDY0OXNa?=
 =?utf-8?B?VUZNa2IrNFl3Nmo2OHBvYXZXM2dRVXN4T2FzYWVsSGdjaDVwWmlJYlBDWmtI?=
 =?utf-8?B?aUtuWVlhMGs0MlBKQ2IzNjlZcHZFQlI4Nkx1QnFYK1IzdXZmWHpwdm5MMmNU?=
 =?utf-8?Q?pVWbo9e4EnQMbqKo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3374133f-55e2-4ec9-5969-08da4f348ac3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 01:07:11.4401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BpWsLiuHWWVZx19gmD4EeFAglFwCrxP/VfoMNOztNIZNpsl7EePG8ez0HnWbbFNOau5/Fn9zeSZ6QjRHNH66Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2358
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 6/15/2022 8:36 PM, Matthew Wilcox wrote:
> On Wed, Jun 15, 2022 at 02:38:24PM +0800, Yin Fengwei wrote:
>> On 4/19/2022 1:08 AM, Matthew Wilcox wrote:
>>>
>>> I'm on holiday today, but adding linux-fsdevel and linux-mm so relevant
>>> people know about this.
>>>
>>> Don't focus on the 18% regression, focus on the 240% improvement on the
>>> other benchmark ;-)
>>>
>>> Seriously, someone (probably me) needs to dig into what the benchmark
>>> is doing and understand whether there's a way to avoid (or decide this
>>> regression isn't relevant) while keeping the performance gains elsewhere.
>> With:
>> commit b9ff43dd27434dbd850b908e2e0e1f6e794efd9b
>> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
>> Date:   Wed Apr 27 17:01:28 2022 -0400
>>
>>     mm/readahead: Fix readahead with large folios
>>
>> the regression is almost gone:
> 
> That makes sense.  I did think at the time that this was probably the
> cause of the problem.
> 
>> commit:
>>   18788cfa236967741b83db1035ab24539e2a21bb
>>   b9ff43dd27434dbd850b908e2e0e1f6e794efd9b
>>
>> 18788cfa23696774 b9ff43dd27434dbd850b908e2e0
>> ---------------- ---------------------------
>>        fail:runs  %reproduction    fail:runs
>>            |             |             |
>>        4698:9       -36360%        1426:3     dmesg.timestamp:last
>>        3027:9       -22105%        1037:3     kmsg.timestamp:last
>>          %stddev     %change         %stddev
>>              \          |                \
>>       0.39 ±253%      -0.3        0.09 ±104%  fio.latency_1000us%
>>       0.00 ±141%      +0.0        0.01        fio.latency_100ms%
>>      56.60 ±  5%     +10.3       66.92 ±  8%  fio.latency_10ms%
>>      15.65 ± 22%      -1.3       14.39 ± 17%  fio.latency_20ms%
>>       1.46 ±106%      -0.5        0.95 ± 72%  fio.latency_2ms%
>>      25.81 ± 25%      -9.2       16.59 ± 18%  fio.latency_4ms%
>>       0.09 ± 44%      +0.9        1.04 ± 22%  fio.latency_50ms%
>>       0.00 ±282%      +0.0        0.02 ±141%  fio.latency_750us%
>>      13422 ±  6%      -1.4%      13233        fio.read_bw_MBps   <-----
> 
> A stddev of 6% and a decline of 1.4%?  How many tests did you run
> to make sure that this is a real decline and not fluctuation of
> one-quarter-of-one-standard-devisation?
For this test case (fio-basic with the specific parameters), we ran it
9 times with commit 18788cfa236967741b83db1035ab24539e2a21bb and 3 times
with commit b9ff43dd27434dbd850b908e2e0e1f6e794efd9b.

The stddev for commit 18788cfa236967741b83db1035ab24539e2a21bb is 6%. The
test result for commit b9ff43dd27434dbd850b908e2e0e1f6e794efd9b is quite
stable. Its stddev is less than 1% so the value is not shown.

Specific for -1.4%, we don't think it's real regression. As you said, it's 
less than stddev and we don't know whether it's because of stddev or not.

The point here is the commit b9ff43dd27434dbd850b908e2e0e1f6e794efd9b could
fix this regression. Thanks.


Regards
Yin, Fengwei

> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org
