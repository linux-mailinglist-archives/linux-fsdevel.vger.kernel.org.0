Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C5076DD9A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 03:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjHCByO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 21:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjHCBxD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 21:53:03 -0400
Received: from mgamail.intel.com (unknown [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497FD4C02
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 18:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691027431; x=1722563431;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N73ePUwQDd+fD0N4PJuClLw18VjE5pbH0kmPtnja6tQ=;
  b=Ky2pkiElAZt6jtHmzsSP3SmOoCJC1JMJd65jMrNCk4usMctc7rkFgV3u
   aQi0vA4S0p3dyAqQpbuLX2FmZYdusTOUeQSNxSjNDBNfTk64auVdfGB0r
   /206//erRR3Ii1mzmv+FtKkTkKufcjwj1/dkBm3ETkRfaKqO2teZ+fu28
   Wb/+Y9dlBt+EH2uzocIHCdLyYvQSOqXOwxG4KHmdZG/1XWK5W5EDzBSoo
   c+/uXtCQPbAuh1BjXgKnX3R1GxLshQ9tz6w2rwzRmIpvwtvTCbRT2wugl
   NyogxS5KFrm154CPYbncqR3CnFxLifdko+B+SsVtaE0gqqUKjYVBJT85z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="368645213"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="368645213"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 18:49:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="723061272"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="723061272"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 02 Aug 2023 18:49:31 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 18:49:28 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 18:49:28 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 18:49:28 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 18:49:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8mtLbBdoIp9t5y66w3nW8H9fRc39ZkppECfb+y+UuwEQItZpY7IcrYXVTGIxrQwnxwtl5k/248V91KtGuTzX5rQcXsI7wPCM4dUo2cUoYxJgtI1ylTdy5WoH2bZACRtSRTJlnNuMNKLCOhVGNnPO7GDKm9UtiFHs4togErFoIKVqxhqOiyZxycrvnVF420I3UeMdeLb/0ibLMQIsDkbYib8y5qCvJgMpQ3Wyaula3gyCNOvLmqHMNpk+chYm2Kc3WEYmM6z5XIgf2t2YBqDcVH5aQyeUxRgvat35APlcvQszwG4j7OcvgrXN9Hoo3qt0e+JcPsLYGVu7BDBph3JSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVAoSsse2wRfJCs0I3Nfke4P3RaZXFbUJ5VQ1lDUEJo=;
 b=OrR3LOJFEHonwUEL6W3B0Sugq/O4H6iayhD8r3uPdkwDf0SRVRrds1t2dUQvoZTlr/CRID6UgGBOvdnIt6lArS98twIPCnYcekhibRy0xiV0WbDy1igbd9UYN/Gv4yvDMUmIgvP2VDMVi1w+86MTwUOtesn//25zuoR04SocKXU7+QeSqsNlKWEZ4oxwXX5MPioGJ59vUKtPxVj//Q/VQOXtnMoj6pHsKDdsEfX4qLeKKK8W5vxl7WuCh6C4+DOhD9C2PudCz7fYN5+omc/HZ38oam5v+k540AS5kgP+0fNdYd/VMYujNV5Dgs8M3YQiJ3LBClFTwDm0XoFGHxMcGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SN7PR11MB6900.namprd11.prod.outlook.com (2603:10b6:806:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Thu, 3 Aug
 2023 01:49:26 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 01:49:26 +0000
Message-ID: <cf9f3750-6fb1-ef99-3fa5-733c2c811bd3@intel.com>
Date:   Thu, 3 Aug 2023 09:47:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [axboe-block:xfs-async-dio] [fs] f9f8b03900:
 stress-ng.msg.ops_per_sec 29.3% improvement
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>,
        kernel test robot <oliver.sang@intel.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-fsdevel@vger.kernel.org>, <ying.huang@intel.com>,
        <feng.tang@intel.com>
References: <202308022138.a9932885-oliver.sang@intel.com>
 <029f3c86-c206-0ad5-9c42-04ea0b683367@kernel.dk>
 <a2a6e445-1cbd-1c28-af60-3e449f9673ea@kernel.dk>
 <aa730341-de7a-6923-f341-9a2be7f59061@kernel.dk>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <aa730341-de7a-6923-f341-9a2be7f59061@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1P15301CA0050.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:3d::16) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SN7PR11MB6900:EE_
X-MS-Office365-Filtering-Correlation-Id: 91998331-baaf-4acf-174c-08db93c3de2a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8iZG8TfQA9v4vUcrNIHlcUMhJ0xpROo6VIfQX7KEaOEZSAjBFywZaZhtZtpwIHFOWbZqhN1yvueOl0oY8Ajq0jRw8inCnAYbmPWuAQaww9BAiZ3JjtEwxkH8zYwInv6Ut704tAp+Ew/UUij+sAhit7iySnx2DfQJTE3c6Na4iTvMGweIpJ6d+It8jQsb2CDEC2YcdbHhS7djgu4Yl+QbssaDRGfo0Tg2j+hx8OjJnq9Xu0P14G/iMz0Joba9k+yopQ0o9Z2CVSe2m8QL5+J9W8H5a73+19GgS+tTuAQhLW7uiZsF0ZcQmOnMcFXrmwvN6MY4gneeTFtNQk7FlST49M57e4FwDE+yfFj+Tf78ZhVpTDOUaXgsZ+1Q7zq7MwbyOCiytylYE4T9RvEI9Di5nyJ0TTczaFln9eOE2dMgbydms1zqemnmG/tbdRMcfFmSxneEvCxKWmm17pfWMBfBrhpUvQXcA8ocwlS/h1ttO6EYvTxoHsctI8XWO9QlKMTBNgVnoP35/nhSiFilZeNvr2Pg/+zhEgRqRecvqmLYp5Godu36ukw8xi7C2ogTcENKJwTVaN6rqVy6LGvjcV5au2zSjSDx0ofF8EUUvtBvbdEGJB45YWZLTXoPtvJaA4Als9jYdPsXoRlViCT/cl8zkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199021)(66946007)(31696002)(86362001)(66476007)(66556008)(6486002)(6666004)(6512007)(2906002)(31686004)(107886003)(4326008)(6636002)(110136005)(36756003)(478600001)(83380400001)(38100700002)(41300700001)(2616005)(82960400001)(5660300002)(8676002)(8936002)(66899021)(26005)(53546011)(6506007)(186003)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGhvTm9NYnYvV1A2a3pqSDdrY0piRE9SWGdhZHFUSEtCYlA2OFB0RDlXSDlT?=
 =?utf-8?B?N014L0pVWWI3STBQK1h2d2Rtb3lHeExJK0NIR29QUkgxWVVTcUdkWlpzejJl?=
 =?utf-8?B?bjRSQzR1MWFGcTl4Q3ozYWNNNGFKTTJ5SENJa2I4eGlYc1cvc3VyeWZadnBN?=
 =?utf-8?B?cHNnWDB1RUF3VjNLODVpeGgxbGJmNkVRbFJYV1J2NnpoT0p0eW5TdU5ZNkFG?=
 =?utf-8?B?OGg1Z1pXWko5dDZweGVQSzZ1dlRoVlpGR3d6d3hvM3MxUjhmWThtR3JiV0Mz?=
 =?utf-8?B?Y0JneUdqQm1oWXdZNFNNYTU2S1lrZWo5VXZPWHhEaVJqS2dIZUVPZG9aemxv?=
 =?utf-8?B?M0lFeURleE5meWd2bXZUc3dseU1yeTFVUEtTQ3BoZTlET0xuVHFpRUpwUkU1?=
 =?utf-8?B?M2lJM0VjcXVJc3lWcFhJN0ZmQnp6K0lLc0J2TXVWeWQyOWo4NFhVVHkrZzlv?=
 =?utf-8?B?Z045Nmd6UTM1TzRCWkNmdmcvTU5sdHRYWk1hSjh0d3NlZklobzM1dW95T2l1?=
 =?utf-8?B?K2tvRytkUktTaDBmaDd3aWZqK0ZIeXd0YlRJdGZ0d2dnVUl6MVpiSWlMNnVT?=
 =?utf-8?B?SGY1YmxxQlc2M0cxN2FuYUxPRTlNZEhzQmNhYUdRd0Y1bHJGQ2V3dkhNWmpE?=
 =?utf-8?B?cENJd1FPRXJOa0RJZ2c5Z3dlRDBMUXh2bG45OWhLdlNra015MFYyUkwzcndx?=
 =?utf-8?B?M0dySlY1bkFtSGRlcTlYbUdIM000aU5nYWRwcGxQWEZFV2plV0ltUW9mU2hW?=
 =?utf-8?B?WDBibWphTytjdkpHdzlBcFIyM2o1b3d0dW9CYTBEYjFJN3pNcGdmRWhjekNJ?=
 =?utf-8?B?K2JKUnBhL3I0SGZDbFdSNUd6Y284VC8zV21USDVkMHI1ekNEbWdUUzlLVVdy?=
 =?utf-8?B?cnZRM2lzTlhGSFlTRG1DZGxVZDM4MGp3SXg0cGFraG9Uc0RJZFBrdHJ6Z0NU?=
 =?utf-8?B?Rmc2SEJ4NzJVMjZwWGgzcGp0THJnT3Rjb3Z2bUYyWEtRUUxsWjlZcWxPeFhp?=
 =?utf-8?B?STVLa0liSmtQQW56U3hESkJnZklxU1hWdmZiRHBJM290cU1Mank1L3pjU3hp?=
 =?utf-8?B?QkZQSVJWUVUwZGdObVg0Q3U1WEJ4MEZVeGVVSklaeVZvMXFYNFJWeHVqMDFF?=
 =?utf-8?B?a3hYejEzL2Rva1lySjVlUStOZDljOGxIZWhRM1dOZytmREYya1o1WjdIQlhU?=
 =?utf-8?B?VlhmTnB1T0tzT01hTDJ1ZUpJMnRFMGdFWmZ1QllKY0gwN1BFU3lVUW5nN2t2?=
 =?utf-8?B?Vnh4UU52Ujdwc0twWkFsVDYwRUhPLzVDWnRJQWkwNE5vS0pMNFZjdUJXUzBT?=
 =?utf-8?B?YWZxZURVeGFhRGxzK0lFZ2xjeTBDaWt1eFBLeHVaTXl0TGcwYnNoM3pFZURB?=
 =?utf-8?B?ZkVMTjJmeUl5M2xaeDJ0QithRWMvODBiOGNpM0ZLR1Rwc3h4bXl0bEpyRy91?=
 =?utf-8?B?NEpTTjZ0bXFJZ29hWHNNQkFHZDBwaGIwcVM3S1JVUzNTK1pTVEFmSW50b2ha?=
 =?utf-8?B?Wms3ZTdwUUljZ1ZPZ0k4UVY2cmJGak9ibjh6c2x1bGlEWjVTNS9XZXdMOGFZ?=
 =?utf-8?B?UlFaNVVLQzVNUmRxWW11NUJrMDJiSDdFNnhDZ3ZFKzVEcjlGVWU1Q1pjaVJq?=
 =?utf-8?B?RlJmbisra2RBU21JQk1NbzQzUnQ4UjNiaE9BZFJHZFB5TE40bDc4c0hybW9B?=
 =?utf-8?B?WTFmVDJmZzVweXF1WkxDdGd2TDhsNEQ0Z1JBNHdITUZmZ1dCK0ZKN1paanhJ?=
 =?utf-8?B?MmcvemFQYTZTN2xVUlRMOFlWVVBBc2NhdXMzYXpyVmVPbXpnVGlDYXBGSFZH?=
 =?utf-8?B?UHRSYktVMXdRTmVYeEkrOEtRRkNINmFoanMzRzllNlVIY083dGxHYmFYdHIw?=
 =?utf-8?B?bXVMeXV5VmprQVlLdW00TktINTA2N2VyM2hTbXYzRE02QkJNODVSWDlYSjB0?=
 =?utf-8?B?dkhOOVY4Q0xPbGkzQjlUSkYvTmFHQlIrcTlueVlZemJod0YreWF4MSsvdTQv?=
 =?utf-8?B?WE8wdjA0WGM5Wkc0clZLYmE3WXJZaWJrMzdaMWVJa20wd3VOYmt5K2o1b2VJ?=
 =?utf-8?B?MysvZnhTdy9zeThiRCtacHIrY1B3MG54Wnp1TitnY0lxbWxySDU4ZEVkQldF?=
 =?utf-8?B?SFFvRUtNUDBMQVFSTDhZOEZnTFByeG9pUiswU1hPZUMrOFN4TGNidGZiTU8y?=
 =?utf-8?B?b2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 91998331-baaf-4acf-174c-08db93c3de2a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 01:49:25.9442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4kEelmz1Au6S6sucDKCbFbBf2yA5B+pXWrQeKspWdWu+uaaZ7y9Vbf7qi3MyWfwRGywNAU+ovKwF+AbJCpx7fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6900
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/3/23 01:31, Jens Axboe wrote:
> On 8/2/23 11:01?AM, Jens Axboe wrote:
>> On 8/2/23 10:38?AM, Jens Axboe wrote:
>>> On 8/2/23 7:52?AM, kernel test robot wrote:
>>>>
>>>> hi, Jens Axboe,
>>>>
>>>> though all results in below formal report are improvement, Fengwei (CCed)
>>>> checked on another Intel(R) Xeon(R) Gold 6336Y CPU @ 2.40GHz (Ice Lake)
>>>> (sorry, since this machine doesn't belong to our team, we cannot intergrate
>>>> the results in our report, only can heads-up you here), and found ~30%
>>>> stress-ng.msg.ops_per_sec regression.
>>>>
>>>> but by disable the TRACEPOINT, the regression will disappear.
>>>>
>>>> Fengwei also tried to remove following section from the patch:
>>>> @@ -351,7 +361,8 @@ enum rw_hint {
>>>>  	{ IOCB_WRITE,		"WRITE" }, \
>>>>  	{ IOCB_WAITQ,		"WAITQ" }, \
>>>>  	{ IOCB_NOIO,		"NOIO" }, \
>>>> -	{ IOCB_ALLOC_CACHE,	"ALLOC_CACHE" }
>>>> +	{ IOCB_ALLOC_CACHE,	"ALLOC_CACHE" }, \
>>>> +	{ IOCB_DIO_DEFER,	"DIO_DEFER" }
>>>>
>>>> the regression is also gone.
>>>>
>>>> Fengwei also mentioned to us that his understanding is this code update changed
>>>> the data section layout of the kernel. Otherwise, it's hard to explain the
>>>> regression/improvement this commit could bring.
>>>>
>>>> these information and below formal report FYI.
>>>
>>> Very funky. I ran this on my 256 thread box, and removing the
>>> IOCB_DIO_DEFER (which is now IOCB_CALLER_COMP) trace point definition, I
>>> get:
>>>
>>> stress-ng: metrc: [4148] stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s
>>> stress-ng: metrc: [4148]                           (secs)    (secs)    (secs)   (real time) (usr+sys time)
>>> stress-ng: metrc: [4148] msg           1626997107     60.61    171.63   4003.65  26845470.19      389673.05
>>>
>>> and with it being the way it is in the branch:
>>>
>>> stress-ng: metrc: [3678] stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s
>>> stress-ng: metrc: [3678]                           (secs)    (secs)    (secs)   (real time) (usr+sys time)
>>> stress-ng: metrc: [3678] msg           1287795248     61.25    140.26   3755.50  21025449.92      330563.24
>>>
>>> which is about a -21% bogo ops drop. Then I got a bit suspicious since
>>> the previous strings fit in 64 bytes, and now they don't, and I simply
>>> shortened the names so they still fit, as per below patch. With that,
>>> the regression there is reclaimed.
>>>
>>> That's as far as I've gotten yet, but I'm guessing we end up placing it
>>> differently, maybe now overlapping with data that is dirtied? I didn't
>>> profile it very much, just for an overview, and there's really nothing
>>> to observe there. The task and system is clearly more idle when the
>>> regression hits.
>>
>> Better variant here. I did confirm via System.map that layout
>> drastically changes when we use more than 64 bytes of string data. I'm
>> suspecting your test is sensitive to this and it may not mean more than
>> the fact that this test is a bit fragile like that, but let me know how
>> it works for you with the below.
> 
> Thinking about this just a bit more - it's clear that the bigger strings
> change your layour as well. For some cases, that ends up being a big
> win, for some it ends up being a loss. This is just the very nature of
> how the kernel is linked, and things like LTO deal with that
> specifically.
> 
> I don't think there's anything to do here, your test case is just
> sensitive to the layout changes caused. That doesn't mean they are
> either good or bad, it just means that changes happened and they
> happened to impact your test case in either direction.
Totally agreed. The layout changes can trigger different results on different
env (hardware, toolchain...). I got regression on my env and Oliver got
improvement on LKP env.


Regards
Yin, Fengwei
