Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E8074931D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 03:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbjGFBck (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 21:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjGFBcj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 21:32:39 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633F51988;
        Wed,  5 Jul 2023 18:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688607158; x=1720143158;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xC8PgczKW50JZUwHSGDuag3Zbhxp5tEHGsfUEQb9UPk=;
  b=j58RvQtf1Kz8oRoQVinXpTOv5sqG6y1XRxsbVVUgpEEI9v/Zaubg2Tq3
   e7QT27iDRHmPs7b5pbP8e2MPQPDT3YjZtaVTUJNCGjV7CPDiS8PxLce/N
   bocdyeL8Cj1yYPVDwUDk46S11uT6Lw/OmLYgM8GkHA6GoEap8d4WbA0RR
   9KAzjv9fYwo0BsjVKYR6pHqMgM/mnzP5fXwiLIHthJNGHsPd1J6ssn3Pd
   rYknK1cFKRE7L9oT6iaOfrNTn7uDUlInRsRONbLkAK1yXVkBAY4BlKQek
   hE7pM0jRwDiUlJZce+T9/4ozUsfCLQDjkrhbyNAJxJy1MvwiYgu/O44zV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="343071424"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="343071424"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 18:32:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="863913860"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="863913860"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 05 Jul 2023 18:32:37 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 18:32:36 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 18:32:36 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 5 Jul 2023 18:32:36 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 5 Jul 2023 18:32:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOhZf3OHC3ftMlLarHez7vFBqwrnAvfueMH/G6Ricezz7Inqu682IvPpL5aKcIYw9o5b6MFWAByhXxJRPE49eEfN+JfHRoet6/HJWkOmlRvDifiKKLR9GGcjyVjvAODjKgbxIgC82rrmsikEJec8tUEIN+3Kv3gxslEbg4IAVAhCJ6LRq/EYxkSUO1JXkZ5OcW1PutrJS49fv3eWjEQL3O2AG87OOk0jCHB2+4NEWi+3aEgp8m+yeL77ESDfawlpjyfztIPWk5hrXGVmZIVSyd4VhzdZ2RRKBX22U90YNFS5XJPA++IkZSPgRXn7RdaXF8oFnhxymyL+EhZfPhbRPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UM3ADFTZ0aVfhHDSzxybr3C9m470XhA6OSBurc1qk6g=;
 b=j5FOWWQQWt3YqjglbpLVQg4NNQRx5w40TFkmEMF1jecB2TEbW8I/ind5XCcFNChZ3rr8lJalS1ThOBPRNAx11Qee2D1x/WSfSXxBILA4VmOHZiiZBMrWldcFO/Ymp2A7HGtSpmYCoSkLQnAr27ALPs5eAfT7zyx7tzaKhmzeT2cLfYyQWerF+P10bniAiO4W/XmrRZg8nd4zG/KLsuQf3bEFUWftzadoYfmZXRbJH0811pAE2BUH5C4szry98Svj/eWI/caET2UxOirO1yKX1IdXk3EUX779c5HuXSynf6XAC5eURrnrl3+mRK7DGIUK+7doBG0OfNeE4sdrRJscIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CY5PR11MB6137.namprd11.prod.outlook.com (2603:10b6:930:2b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 01:32:33 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 01:32:33 +0000
Message-ID: <0107897d-d43e-8848-3f23-94b005fe7c6c@intel.com>
Date:   Thu, 6 Jul 2023 09:32:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v2] readahead: Correct the start and size in
 ondemand_readahead()
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>, <willy@infradead.org>,
        <akpm@linux-foundation.org>
CC:     <ackerleytng@google.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <oliver.sang@intel.com>
References: <20230628044303.1412624-1-fengwei.yin@intel.com>
 <20230703184928.GB4378@monkey>
 <d6957a20-db31-d6ac-8822-003bdb9cd747@intel.com>
 <20230705165235.GA6575@monkey>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <20230705165235.GA6575@monkey>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0129.apcprd02.prod.outlook.com
 (2603:1096:4:188::19) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CY5PR11MB6137:EE_
X-MS-Office365-Filtering-Correlation-Id: bf4eeb2b-92a2-49b7-a1ce-08db7dc0df01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yAgN0zw4FmiyDglL8yBx0C3Df6an1kH0H2ntzqIxDKzdN1vSSf0pTWTsmQaat9OwuUitneWFVbuYpoLvk7iOviI1XYXM3KJPNKAj34v7XrZSVg2GMPORLbMgGGHbsH/Qy+4EnaLxO+IubwiWC99/S9QJNLxVNlnZ0olfrMu47nVrXsZMsyEEsm4PGrRxgqftIXUMGP8GHVzxhCZ2kHHUg88LF3OXgwARwBq/tOEH8xabDOJKnTQMx8CJabdcVKvviJ7KXjY22LxhGvoxLs4WS4cBExMpuLuoi9N4Qqy68ctaU/pmdpFZHecZ4Zj2UOYspE9eKfpTEuUY2jDJhcFTEP4Yb1ueza6r2RSF91VNUtcPiCXAXIaOVkfxZNchZy4zlxmF/I/rZuHNpumWG4tzWM5BXHzJiAi5J+bymBq956ReiceO99RGNpujPaf05rePAfYLrQJbldzf8qokLdMiTMo3chKvu2nFUNYe/wgSxWRoTC4qFP1G4QOzt/s6FpnEgUXW5u5bBrBvgZTrWNGNzLFyMLU8gFDfcChwYiYp3/MAUC4qWDpdJgafgv0W1b9jnEBXf/nWHNPwnI5xXC7EnKm8GbZgx40HwgVpXvDMCaDjOQSE9F71tFnWm6ysZw4ndq6LVMlSy/YihHc40Yw5bA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(376002)(396003)(136003)(346002)(451199021)(26005)(38100700002)(2616005)(82960400001)(186003)(6506007)(83380400001)(53546011)(8936002)(5660300002)(41300700001)(8676002)(316002)(36756003)(2906002)(86362001)(6666004)(31696002)(6512007)(66946007)(107886003)(4326008)(478600001)(66556008)(66476007)(6486002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1FYYXNQbVFPbmg0RURLRk5RYjZkeDQ3WWx5UjVoTlBOVmw0c1YwbEk5azJB?=
 =?utf-8?B?QkpNcXhuNzlRdkxQY0ZnSU9zd3MrYTZVWlVWMEFlU1AwMjNpWitBV240TERn?=
 =?utf-8?B?bUF2RXFiaG1sYlJTb1pvME9QYkxhNXdOQ2FXamhlcjdhSWFTWm5XWXpkQjY0?=
 =?utf-8?B?LzN5cC8yekpLbkNPYnp4K2JGWGFPTkZwTE41d1JjLzc5aWRtdUtlL2xKelQ0?=
 =?utf-8?B?cnlNMm0wVmlTcTl5MWJ1OU1IRHdXY2ZPOG5HMlhwUXk0MEZPMkVub1RMR1NL?=
 =?utf-8?B?MlIvZXh2U2QvaVJYeVFvTlk1R0g3aExzT2xXZnVNTHFzU2JQRm1FREFHeHdE?=
 =?utf-8?B?dzRobnE4TUNaWThTQTVNajI3WkZUdGltd2ZiTzQ3eFhQYmRtZ1Q3bkZVYXkr?=
 =?utf-8?B?c0VyNGZ5R04rcFM4c0pXTFNkYi9sNDZHQVVOZUxWNUhYQ214TTl4WmgwakxY?=
 =?utf-8?B?Rys0Tnh0RUVpeitXQzFhTVo4c3dPNEEvVXF1S04vQU9lWXErRllQblhvTzBw?=
 =?utf-8?B?VHZYRllkN3hsQzRyYjZ3ZnIyaUdtMU1UYUNGSlNGbjBJMitwdTlNcVR6KzV5?=
 =?utf-8?B?Nng0Ykp1R0k1ZFpEZncwSVhvZGtqMXFudDdLbkllclZoTllwcEt1cCtNQnpM?=
 =?utf-8?B?eUdVVXFkWHJhUkpQMGxnd1RZcFc5SHNSWDB2dDZYOWVraFlhWTNMVmszeUJX?=
 =?utf-8?B?NVdzRGdvNkQ4VnRQUlJJeEpuSUNpUUpnOUJCcGNpcHozN2UvemJjbTQvKyty?=
 =?utf-8?B?cklWWGF6N2IrRFpudHpaK2w4UmppMjlqMDNaRWlmMjhnaW1CK2tXRXdEVnI0?=
 =?utf-8?B?ZkNRNDV5aElmMUVUNXJzTnZrQmdOYUhNOEtHUkxBMWQ3cVRRcndkTXB4QXA2?=
 =?utf-8?B?Yit0akNNWURtTkhBVW8ybTJKZnh2YmRvTU9sZ0tYdzArZDQ5YVd1cG1FSUl2?=
 =?utf-8?B?Mm1SYXB4ZWhZSnpqdTFEaU8xYVhudUVwZldtUjU1cEZSNGZXY0JzZWxJaUJX?=
 =?utf-8?B?eXB5bXVoU0JYaWJqVy8vYzM0OWo1eUhTUmN1RW1MYWR4TE1IdGJRMXp2QzJE?=
 =?utf-8?B?cGFXUG5PcGlhcEFudGUxTnh1dDFLWXR3cnkrTCtielVVNllkWDhSYUYvNnBH?=
 =?utf-8?B?b0kxL1UxM016TVBwV3RLalpHQnJpWDdzSWhMRmNhK3haa3RSb3J6MkRkdXJO?=
 =?utf-8?B?TUtDSmdISlcwbDZldUxoQU5KcGN5ZURCNFVTZElTNStIYUljZ0pOWHRZcEtK?=
 =?utf-8?B?YXh5YWVCZ3B5RUt6WFowbmVlSmVLbGZqTCtGeXlKdkhtRGoxRUJ6WEU5MmNH?=
 =?utf-8?B?b2ZFdndmVjdFUFZKYmJ2a3FjY1dYM1pNQXcyWVF1anQyM2c5a3Y4eGdVK1RJ?=
 =?utf-8?B?WHpZbytUWkNjL0JWb0lVLzhFSzZWc1JEbkh2NHlXa09YMFlrSGRsR1JlalV0?=
 =?utf-8?B?VGlhZlJHNksvOU81NDBya3BhU0hsSEhZSnJIcFlVWU5FYXpkRUszNTZ0ak9T?=
 =?utf-8?B?Mjd4SXJnVVlXWFIzUTRVL29ISGtoejEweDFBOVRJSUxkTW1XZ1Rza1lnS1lV?=
 =?utf-8?B?bXN3TFB6emRpUDhGbWFTTDVCS05LL0wrZVNjUk9GUElUSGY2NkFhQWp3Z3kr?=
 =?utf-8?B?ZVliNUJ6OU9abzdWS0hzUVQrMy9mTEtrNG0rN01nYTZQWnZVU2FjaDBOR1dM?=
 =?utf-8?B?N1VPcVU2TVA3ZlYra2k3N05obVEyWDgvdnlBTHFIYjM4TXdCOFl6bU5ZQ09m?=
 =?utf-8?B?bVRNVmJLQ2p2cVlhaHR5U0lMWHhWdDcxRitmU1pycnlDZUpGdFVaUnlnazN5?=
 =?utf-8?B?UnZSYTJ6YXFObHZDNEw5UFY1amRkQ1RTbWErYUJhQWlUbXZMZWhLQ1A2TFFQ?=
 =?utf-8?B?QlJLQTNXa0x4SjVUYlExakgwZHI2TkJ4RWtpcUhKSEIrUGJkVS96Q3JkQVNO?=
 =?utf-8?B?SG5DbUswM2Z6ZTY1U0grR2trQ1M5NjlSQzh2bEFUQkg4bWFSdVJ1cGZMS1Z4?=
 =?utf-8?B?MVBDS0RmbGplYzhVcW1DcDNFMHBmeVVBYW41ZUc2S1AyMGN6VFdiK04wUjIy?=
 =?utf-8?B?YUFKSC9XSVF0UzlMZUZmeUQyeUN4dzdyZDlkTTYwUkU2a292U0RUYnR5UlZK?=
 =?utf-8?Q?xIomh4ta8cF2f8s+GuqdHn5OV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf4eeb2b-92a2-49b7-a1ce-08db7dc0df01
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 01:32:33.4723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CJwM2qrLHDpGeuJSrnBQwqSrLgCXKEhGxRyrXo9QINE6iZRKSrCy48bcHqD3P1aPdedj2IJFd+LWkK7xccA4og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6137
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



On 7/6/23 00:52, Mike Kravetz wrote:
> On 07/04/23 09:41, Yin, Fengwei wrote:
>> On 7/4/2023 2:49 AM, Mike Kravetz wrote:
>>> On 06/28/23 12:43, Yin Fengwei wrote:
>>>
>>> Thank you for your detailed analysis!
>>>
>>> When the regression was initially discovered, I sent a patch to revert
>>> commit 9425c591e06a.  Andrew has picked up this change.  And, Andrew has
>>> also picked up this patch.
>> Oh. I didn't notice that you sent revert patch. My understanding is that
>> commit 9425c591e06a is a good change.
>>
>>>
>>> I have not verified yet, but I suspect that this patch is going to cause
>>> a regression because it depends on the behavior of page_cache_next_miss
>>> in 9425c591e06a which has been reverted.
>> Yes. If the 9425c591e06a was reverted, this patch could introduce regression.
>> Which fixing do you prefer? reverting 9425c591e06a or this patch? Then we
>> can suggest to Andrew to take it.
> 
> For now, I suggest we go with the revert.  Why?
> - The revert is already going into stable trees.
> - I may not be remembering correctly, but I seem to recall Matthew
>   mentioning plans to redo/redesign the page cache and possibly
>   readahead code.  If this is the case, then better to keep the legacy
>   behavior for now.  But, I am not sure if this is actually part of any
>   plan or work in progress.
> 
It's fine to me and thanks a lot for detail explanations.


Hi Andrew,
Could you please help to drop this patch? Thanks.


Regards
Yin, Fengwei
