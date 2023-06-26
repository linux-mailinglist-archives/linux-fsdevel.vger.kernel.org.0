Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5516173DAD7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 11:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjFZJJN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 05:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjFZJIf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:08:35 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A31D1;
        Mon, 26 Jun 2023 02:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687770364; x=1719306364;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rVqvBXljPlakAJLnJKaZRRL4Md1kCbDNDU1SglpAIeE=;
  b=f+//3WnSpUhjBkb/JjZMj1CgaJMcFE+PXTXCdYRZn8RVyVKyHkZiQ1L/
   FYLTpZiaw7Fsn3ZysSUsfgaJh7VwnxVYvyqb3Ua9c+K/QCB265XYEoSl2
   lN7V4VWTCDlAdEnzyMgAzHuszfq2ZFs2nNgxx1M/HtHyicjI66GqVJ2w7
   lLQjc6fdBYFS7fG9Q5ThzLNatcMeGRrixIW3QNRpiHRWlZOMBc6UvqZ1x
   FffP1l1wcug9pZz/6OiVHKXn1ktWpa8ArERaYkyqebn68NIMJq4XzaH7L
   7HnY0aBOG7VymdS/t5ae9LDrL98BVEHbfv84AOTyZOfWmOF0UoRqlKDwN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="340810000"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="340810000"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 02:06:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="719270491"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="719270491"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 26 Jun 2023 02:06:02 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 26 Jun 2023 02:06:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 26 Jun 2023 02:06:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 26 Jun 2023 02:06:01 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 26 Jun 2023 02:06:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MIXwbcaTVPar4uPaTpyS9N3PwapIimVqPRrv/m4jcapoRtIdymqsYtrWIpz8jT4OwxcHJKNVQygJsWNabYEc655me6mYSkAi6jukJfEUy0IrbswcmQr4AFE1YOwQQAv6WDV46720lIUT4wMUuB85scX8T8GQbpjG/Fj9qHJqH4P3ftlncLMQLgikMDrTxKM+KUurZwrEw0KrT5Cu2Gb2TSa3lXZ5Hvl2JDtph6I4LU+6t+TTrnbhwvFRnwP3heF8yainl8dYF92uZ2ZxvB7pogzYf4Ld+7jEUOS3CX79xLpSpdJuFWtemoH11XDSrhWMv2ItLYBBfjKbj2mHqWEj0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxJJefaYaJqjdenz+nRQoDnxCkaYdbUXUbBwcI4M3h0=;
 b=BypZCZmG5PgOL+nAjQpqp3XOGnkrDOtgle/Y1r7qAs9m6MNPRbMPt96pD9guzH9gLi3KtnAdhSTz3s3R8jCwBax2qOcckfX5/apzec87VxhHiuIAyDIHovvEEHksMJifL53HiWgka2ZkVys5ltyY2+pSUwnKoik9c4R1cY5qpewPAYPbK8thsGoGHelP0QkVfXyzkRoI6Cw8vjivloRwSAuJ8I8OyzJScbhNSCt+vfdoQXa88Dn8xZdwh/wk+6rd7CPFGotXO0DXsH5IMt4uizEm5MIxpDSGX2LF5PBjVGc/bqofqcZfSEiAhjaSmLyqvM2c9/FkI4tSECa1ZcjlQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by DM4PR11MB7328.namprd11.prod.outlook.com (2603:10b6:8:104::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 09:05:58 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 09:05:57 +0000
Message-ID: <126cb393-31aa-d27f-ac0e-f86724eae0db@intel.com>
Date:   Mon, 26 Jun 2023 17:05:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [linus:master] [page cache] 9425c591e0: vm-scalability.throughput
 -20.0% regression
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        kernel test robot <oliver.sang@intel.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ackerley Tng <ackerleytng@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Muchun Song <songmuchun@bytedance.com>,
        "Sidhartha Kumar" <sidhartha.kumar@oracle.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-fsdevel@vger.kernel.org>, <ying.huang@intel.com>,
        <feng.tang@intel.com>
References: <202306211346.1e9ff03e-oliver.sang@intel.com>
 <20230621152854.GA4155@monkey>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <20230621152854.GA4155@monkey>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0157.apcprd04.prod.outlook.com (2603:1096:4::19)
 To CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|DM4PR11MB7328:EE_
X-MS-Office365-Filtering-Correlation-Id: 40235a7e-911e-47d0-487c-08db76248deb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mqPROjOiW42FsR3YlybVcdjTMeGBcFS27Xc3yqlbzHBd3BUt4TYKkMHe9ca6XOuNwFYg9R46hXJ4opnDyMBZeqQGLrT4NxZEFruKij7nXPus3lr6AUSoTmMDoiULIqq+PZcxHcLy6XnzvHBf5AGESxpgv523Aq+intyePI2qwK6ssSZK5nMN0IMKjUryvPPICDCQMcQg//GqaVMJIEBfR96TP7aHel6pbyMmjyB4Ogr1J/a9o4LG2lbJ1vmSn1N9ua799p8Q7NP+U79W5Yt8gQoN2/RDgxmVOFdKzQ6ZXgScXMEcBe2LEtBAbjNGt18eZajnKLqAlfTqaXTCWSlFV5SmJgI+Af8BUM/tAepuHXwu57aiSh9zqAAom9DpC6f5ytqRDREUBAp28AUHRXJKEhDMHi48wLj6fZpJwjsb1oFcKMi7AKlufPbiHtf4WkIKChEn7C3ZzLHKrr1pm9ZVUMTMLKaSjOoJoqyXZBXMsdGWOTDnLvYPJb/GRucbuUy3NvfJNKm5pPdiHL0J6VrTp6o4L81N5Z2s+IXIq+RqzanU1bzW2zU01eI+eRyKmkGRNXj3cIUfSzHmXIF0F3aEFgTwAr2LpjQxjHI48O2sj3X2Ow4K9wLhWhiyhEYqPyFyjIsGdhdga1qLTRzGzH7YWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(346002)(366004)(396003)(376002)(451199021)(2906002)(6486002)(6666004)(107886003)(38100700002)(83380400001)(2616005)(82960400001)(6512007)(26005)(53546011)(186003)(966005)(41300700001)(110136005)(54906003)(86362001)(31696002)(478600001)(36756003)(66476007)(6636002)(66556008)(4326008)(66946007)(316002)(31686004)(6506007)(7416002)(5660300002)(8676002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjJ2MEowcVdDVDdYU2xzWTNMUGlaU0xockVIQi9Wd3E2eDMvUmRwMTNjWU9D?=
 =?utf-8?B?UEQ3QUMxTWpnK3J2SmdIRUJFcnN5aUZHdXhZQjFyOTZ2UXh1TUlpT0thK295?=
 =?utf-8?B?bGQ4TFVITUpkeVN6Q0FKaVg3MFJicGhVWUMzR1VveUc4RUlZRUoxRFNsQkpC?=
 =?utf-8?B?a3h4VTNWNE1Pc1ZYcHNJVy9ybERyWmZkbGQvS3NFOEtlZzM0bVdQTTgwbGpG?=
 =?utf-8?B?L2FFMjc1VlhWNVJCM0kwQWFmT0ZqVWY5WDlVcVA0dnVCOTRzYnFUblhsV1Br?=
 =?utf-8?B?QS9zdVNkWG12d0cxOHh4a1AvVXAvOEsycTYvbVo4UG04clkramgxaGhwdjlz?=
 =?utf-8?B?UlhKS0Z6cXBlNmRPenVxMTRHeUJTZEl1WE5rQ3NRUkthTUxENEJvNzlyUko4?=
 =?utf-8?B?U2ltK092TTM2QUF3TFA3aitaZDZPZGRLUExielkyMnYrMUcxL1lFb2wxdVly?=
 =?utf-8?B?emVVcWtxK2xzQWNJejU1dTdQa09pRHhCc0xSMnJiMUZoeVY2ZUZBQnhBcFdj?=
 =?utf-8?B?RmJEVHBxaWM2ai9uUnJ4aVB6Z2JmZVg5TnJaakMxNXNocDJHOXVpa0p3NlFT?=
 =?utf-8?B?eVlTaHFLeEFzQllqcm9FYlFNOC9uZkxLY2ROTmpwT1o1dEpmcDlkOUNFN0ph?=
 =?utf-8?B?akQ2RkpaVmlWbFVVM1JPbVlTaHB4N3VwVWVDYUJ5RVdKeHVUV1oxWXd4bDA5?=
 =?utf-8?B?aHRNNEhhVEpudWpCeDh4L2F2dWZYWlE1d0JJbDVZck1LeXRyQ1Z3b3E1emRk?=
 =?utf-8?B?Z2dmMEluS3UweFpqRkxmOEtQc3kvazBVWHJzNUNzZStnOVZIcUFPRjBUK3hM?=
 =?utf-8?B?TkpKMGNMVUJMK3hPeDQwTkt4c3hmQXJjYzZuLzVmRHkrWW9DUGVSeTBGbmsx?=
 =?utf-8?B?cGlkTk5JeEZDdUoxVzNwNGYrZEFVa1dWRGY0WTJWSHY1c1VBS2lKV00xZXAv?=
 =?utf-8?B?SGp4N2ttVEpwbHVPM0syOXZ1NWFoQkNYTHJtQVF5WXFPNGdreXVxWTVqZ1JU?=
 =?utf-8?B?Y2pFRzNXd2ZDb3JFTEZOK21LdGxSWE1pNWVJZ3NBR2tWRitPOXlwREtnZFpa?=
 =?utf-8?B?SWY0R2Z1RFFxby94eDRHZE9RcFc5a1VpY2RtNTJNNXcwWjBzeG5JNXBFT2py?=
 =?utf-8?B?NGRKelJHTUFOYVhGWmRpN2txSkZWMHB1VHBOZmtoNXVtQUE1N2hFazVWVkUx?=
 =?utf-8?B?Yks3bEYzdjZueGlGYzFPc25RWjJFUm1PWHVtYXBPSnZzY3ZjWHgwT3A1QjBr?=
 =?utf-8?B?U3RLYkJRVjE1ejA4b2RBRkJsdzZPN1hRWHF4eFpFa0tZWmhxL2ltU1MxNWwz?=
 =?utf-8?B?QlNGV2k5cWlLZW51Zm83M002R2VMY1pua0swanNBV2xnRVlra3B3U0M0YklR?=
 =?utf-8?B?cldmTTVVaWNlbEpZWUFRVEdoSkh2UVNueW1rV0l5TUNkWlFiSWtpSHpwMzF2?=
 =?utf-8?B?QlVxTkVwOVJXNWZXcXZaQ01pUTVEMENmSHJTOGhOOEFOT2R4T0Q4YVppR1Jh?=
 =?utf-8?B?Q3M3cHl6eGg1NXRHRDhPVFJCclhnRGVJWkg1a1NDcG5hWDE5ZkJMejlhdmpK?=
 =?utf-8?B?bi9QV25lM21ld0UrNC80cVhkWnRwZzFSaXRMWFhjcVZibUcyR3JjMXV0SXg5?=
 =?utf-8?B?M2dnVitZTXUyVEpIK3NRVFk5Slc0VnpjaXhiTmo1TWhHVEg2Witxa0ZkUkV6?=
 =?utf-8?B?U3Y3SEkxZUw2Q1pMTWRMMGl5N3VmY09jOHIxNXc3c0NKYmxrWmlmNHloNjl5?=
 =?utf-8?B?WVZ0RU9mUitOSHpjR2s5ZXZpS3RaTTMvankwQ3pMUHdxUk9xRGFORjdYVUlI?=
 =?utf-8?B?bGFkQmpEYVRNYjJrS0hkK2kzUEFNTDRFbE53QW9aMkFlYnYyU2pvY2xRZzA3?=
 =?utf-8?B?NW43aTBJSzd1N1lOZ0FEVUZESFBaaVdZTmMveDJPRHhIc0xSeGdwVXZoOTZQ?=
 =?utf-8?B?c1FIZVJoakN2cDNpVWFlb2xSblRlY3RvN0Z5aWJFTDZMemg4UHdOWUorMXZQ?=
 =?utf-8?B?ZkE2d3RkUlB0LzV0SnJIT2dDaWw0ZitQZGhWZVVXU01EL0o2eW5Ha3lyMzlG?=
 =?utf-8?B?YzhiQnpqT1JWUG96d2IzL05CZlF4VzN4QVFIRGcrc0gyQldCT3pPVGE2YUpM?=
 =?utf-8?Q?i/TZMQYXDcuH9j2z43zYyHuv9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 40235a7e-911e-47d0-487c-08db76248deb
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 09:05:57.5912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qVDoaMN4+OYKjHrSqtXUiv1KS0HXAGXVHiiXnYyJdtVlZHkSEdbaumgXDJPTl4/UPNbwiSfrFmE1AL9JHVDLfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7328
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Mike,

> On 06/21/23 15:19, kernel test robot wrote:
  <snip> 
> I suspected this change could impact page_cache_next/prev_miss users, but had
> no idea how much.
> 
> Unless someone sees something wrong in 9425c591e06a, the best approach
> might be to revert and then add a simple interface to check for 'folio at
> a given index in the cache' as suggested by Ackerley Tng.
> https://lore.kernel.org/linux-mm/98624c2f481966492b4eb8272aef747790229b73.1683069252.git.ackerleytng@google.com/

Some findings in my side.
1. You patch impact the folio order for file readahead. I collect the histogram of
   order parameter to filemap_alloc_folio() call w/o your patch:

   With your patch:
     page order    : count     distribution
        0          : 892073   |                                        |
        1          : 0        |                                        |
        2          : 65120457 |****************************************|
        3          : 32914005 |********************                    |
        4          : 33020991 |********************                    |

   Without your patch:
     page order    : count     distribution
        0          : 3417288  |****                                    |
        1          : 0        |                                        |
        2          : 877012   |*                                       |
        3          : 288      |                                        |
        4          : 5607522  |*******                                 |
        5          : 29974228 |****************************************|

   We could see the order 5 dominate the filemap folio without your patch. With your
   patch, order 2,3,4 are most used for filemap folio.

2. My understanding is your patch is correct and shouldn't be reverted. I made
   a small change based on your patch. The performance regression is gone.

diff --git a/mm/readahead.c b/mm/readahead.c
index 47afbca1d122..cca333f9b560 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -610,7 +610,7 @@ static void ondemand_readahead(struct readahead_control *ractl,
                pgoff_t start;

                rcu_read_lock();
-               start = page_cache_next_miss(ractl->mapping, index + 1,
+               start = page_cache_next_miss(ractl->mapping, index,
                                max_pages);
                rcu_read_unlock();

   And the filemap folio order is restored also:
     page order    : count     distribution
        0          : 3357622  |****                                    |
        1          : 0        |                                        |
        2          : 861726   |*                                       |
        3          : 285      |                                        |
        4          : 4511637  |*****                                   |
        5          : 30505713 |****************************************|

   I still didn't figure out why this simple change can restore the performance.
   And why index + 1 was used. Will check more.


Regards
Yin, Fengwei
