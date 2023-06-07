Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB65C725362
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 07:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbjFGFdu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 01:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234003AbjFGFdj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 01:33:39 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00D219AC;
        Tue,  6 Jun 2023 22:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686116017; x=1717652017;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b80B4FUp2jLWLT48wl2Pv5ghqH9hTo1PVm01olLmrEs=;
  b=Bg0/bTR1HBC6RtOaOWlbj4bU4jVfCbSPYQ8z5s0yk/e8uGHg+vKF5wvt
   orgBHYq7dPpBK9INxzN2BApUoWdSVNuRQbaZrMAmfPeThd3wBNkyjORdw
   aTfEyMGWWodbqlHo6cY6Y0WZZEwOsb26lIPApdvPfDwuI9rTt3oEesAVW
   DQ+H81RVfxd0IyDNu2EAVrbYroK3Of0V/LUU9zvBjDm6Jj1zvO/l4ySK5
   8FL+8iQjgvZIUVcXj1APH0yenrXXvpyS4BHAbROGCGfwQ6oJdBzBOs/eR
   VmXYt9s0BC5t8cU49Gs05jZKVuZbhfn2mj1TA0Erkm+FW2ghxJcUrfBwt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="385204967"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="385204967"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 22:33:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="703472874"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="703472874"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 06 Jun 2023 22:33:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 22:33:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 22:33:35 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 6 Jun 2023 22:33:35 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 6 Jun 2023 22:33:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJ7ASTFgmRKRgEa49HbEhsosPRPk5fZpbEF/fDUaNiJMvGPQTEKAOR0GhwoF0P+m2eosTMbjc/O7hVgXxAvjbHwGcGUNx8QA/HlJNYFH1g6UxZWtRQv8G/GBPXpbXvBesogezLar+CnD6+OlOpo8KYZmkKybicroLmOrKXn4HHPhINU0e5ykK7skUTrd4V+ndIbpmxpNZ8VcbCo6PQFA03BDkbXHJRPpoR/yo/SsUnLWHWpeJl8ml4WAQQ+qiHN0YSvmvV3ANW8TaW05uvm8GAxtMLUK/8l/q5ZxtWyZWvRGl9Nk94iRWrHguSkfyGi/L5UyRf1U5diJywZfedLcjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCwkTIAK6YEGdfhoQ5MSCghUi8azAY621F3wqNAMhPw=;
 b=I9q6qpssZbogvKFwMjTuQss12i6/8rAo17P6C2HuXTBJ1b/LxFFdrw4f17ONyfcCgDe9/2bQApY3Ln3/etjK8+5Pz0La+aT9bv/AFyEQnT13S9j0x1KTLrbDm15ohs93wyxvDEajprh/O8o/q1I8dSHB6+sWQ6yqUezmjtgFXCUZTRIlHYeejDph1E65AO2g3LdKK3OTRDcn2+1ydtvsaJdbry7kdjxb0X+QmREZX2eW1TfeuI0i6D+x0qo8cnPbO8zJIhsJ/SMheWVApdKah+K4q9zz1onUEtCmEehxGTyiC9wuAzHyomjfWeUowa05hIekUreoMeVa1+X2dJOTzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by MW5PR11MB5763.namprd11.prod.outlook.com (2603:10b6:303:19a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 05:33:16 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 05:33:16 +0000
Message-ID: <ddc81be1-7546-3bc3-f20f-24c800d475d3@intel.com>
Date:   Wed, 7 Jun 2023 13:33:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.2
Subject: Re: [PATCH v2 7/7] iomap: Copy larger chunks from userspace
Content-Language: en-US
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     "Darrick J. Wong" <djwong@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        Wang Yugui <wangyugui@e16-tech.com>,
        "Dave Chinner" <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Al Viro" <viro@zeniv.linux.org.uk>
References: <20230602222445.2284892-1-willy@infradead.org>
 <20230602222445.2284892-8-willy@infradead.org>
 <20230604182952.GH72241@frogsfrogsfrogs>
 <ZH0MDtoTyUMQ7eok@casper.infradead.org>
 <d47f280e-9e98-ffd2-1386-097fc8dc11b5@intel.com>
 <ZH91+QWd3k8a2x/Z@casper.infradead.org>
 <2b5d8e17-403d-78e9-8903-659bd1253de3@intel.com>
In-Reply-To: <2b5d8e17-403d-78e9-8903-659bd1253de3@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::18) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|MW5PR11MB5763:EE_
X-MS-Office365-Filtering-Correlation-Id: 185755b5-bb26-4ac5-a976-08db6718b18f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +L1dExWRzAej4+Vy3+Lho8A7RtLeXgfJkj9aJUdr7yQhJv7JmVqzvyYqcOBGNaHPtUYkOvMCtmkvtUpMM6qooYoxQRpCLrG7QNc7L6vCW0WvF/2g5lZ1ghKmksdQz41R3FIw0jgkv1FncKzPIls5Qs8FhEhf2+KD39Ckm0a7FQOACV2GzOgpOp9CjIY+S2mQr9CBMaqwsakSosglq7pS1U2we7HTYZZquF0t9OSikLvzzeARvG1DalC97A9yzre5RDJMfwofjGUMcYmWjIUgV9ot0pVyEayBiYVsXcHMr+vTPtehLWca+GfOVT+P0NTLU8y3YUx/2vBmFQI7ajglL4zaZOzIcfhQKr5QotejqKcQRNkuw+u+XpFfeugELiZ02TbCGAEVwmT8JgSOsefvN8X9E4R6jBDdpMUvkCep3Iswb2XYpqqN00AqA6WKkAdb4gZKJ9otbjXcCAB6r8SQA7e9WunzwsNqS7Ie6zrH+nTcei27vBfyLXwWdkYXE6PX2nRUSxolR57t1eYQNm3D5kT7bQmDInZavq/5v6+7y0JELQ9TlXDlVT2wmCmIvP+rKYfZI8rJzLipmwe1zjYjF5TFFAeh+UN6QO06AkOc9Ix7pw0WfMGTE9rFdUMzMv1rFCPuL2KjwPrhJKKTBM/oUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(396003)(39860400002)(376002)(346002)(451199021)(54906003)(66899021)(478600001)(6916009)(66556008)(8936002)(8676002)(2906002)(36756003)(31696002)(5660300002)(86362001)(4326008)(66476007)(66946007)(316002)(82960400001)(38100700002)(6506007)(2616005)(41300700001)(53546011)(6512007)(26005)(83380400001)(186003)(6486002)(31686004)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnkzcU12RUV0YWlUY3Q2aWpSSmhwYlFWY1gxbEc5QVFTY3ZsYTZoVUlxNDgw?=
 =?utf-8?B?ZEp1R3JIQXBBRkVGVjJZMklCaXhUb0NaUTBaSUNVM3QwNFpzRkxFb1BKVG9n?=
 =?utf-8?B?ZFpzd2VGdDZPbWpwSEkzUzJWbVJxZnFTaC9HS2FOeDlqQzZRSTVldFdUZGdD?=
 =?utf-8?B?bzRoSVJ5TE9PWWx6UUV5UDY0OFo0b1lERXYvWjdrUlpmbzM0WFJaNmYxbXUy?=
 =?utf-8?B?MHd3SmpPczZBUkVzUnNsQ2hnd3FVWDJpM2hhdVd6TWszNE1LNWNUVmFDOHB6?=
 =?utf-8?B?ODdrc3UvQmMzZ3BWMzVEUmowYlVINHpMN0JWblg3Y2YyR0R5aUprenU1Mmwy?=
 =?utf-8?B?S01zcDd2OXhHREs1WENMbGMxTGpqWDVDSVg2bDB0eU5mMTNOYTJVMERDTFBw?=
 =?utf-8?B?cmpGOHBFeThHRjFmbHZOTHZjbWRlZjhwY0dlMHc1UkVvaFZ3Y05EV3BITk5O?=
 =?utf-8?B?SURDdUsyMWFNVVFadUpKdjdveGRnaldsZUFpZ2ZEa0xxeFNmZ0VFUXc5Z0d3?=
 =?utf-8?B?MXdISkw1bUdTdE5WcHZCcHRRWlhBUHJ4bWg4alk5V2E1U1RqU3cyV3ptRGEv?=
 =?utf-8?B?UGQ3UUlqL1hQZlpNYkp5WkZtT1lIRk5qeFRQR21DTjAwV2tTaHhKaGRSbXB3?=
 =?utf-8?B?QjYrbjV6cXp4WXd5V1d1WTFQdTZaaXkraDZVTUZ1YTFDV2ZJbTRUZ0pJK1Ay?=
 =?utf-8?B?WWhFQ2c4ak5MOWRDWTJUcGd5dld0dWdoZHNkbFU3dnI3enpObCtXZXNqNGFa?=
 =?utf-8?B?bmUwd1ZMZEEwU1ZNS2prSnBHWHZkdS91MDI4alRMbGZrY1hCaWdobXRyYkIv?=
 =?utf-8?B?TmFSbjNUWTRlSmhGdXVrRW9laG1zVndmeUFPRjdWeE02UDZkUUFnTWNidTZx?=
 =?utf-8?B?eitNQTY0SzUvdW1zeVNJNm4xcjdveFNVREhuQUsxRE5qOHhzb2Vna3orVWY1?=
 =?utf-8?B?cTh2T0JZTHhWT3NIaUFMNVJSSVUvV25yTElrWmVwSXVuL05jdllXaEJ1NnlP?=
 =?utf-8?B?cXhMaFd5MFloTjI3cjB6am15V3U0UXNVY0FyTi9nUDB5emZvaGZxeFNPZ1Zy?=
 =?utf-8?B?QlprSEhPOHpMOTRXK1FHdEtOT0c5VUlZUnl4V2hiTDRxR1l6QmpRQWxvbE5V?=
 =?utf-8?B?YkJONEM1bndpS1lET2NBNHFDR1B0Q09lK0c5RUR2M1VuaHZ3MS9LRmN3ai9V?=
 =?utf-8?B?Q0hBNG1EMDlvWXM2Q2lGdFJvcDRIVVJxV2kwajVGWDltMjBwUzdOblFqNEJX?=
 =?utf-8?B?UTNOcDNMV0psYUh2TzNyZEpoY3F3TS9TZmRNSE9UVXJnMjRpcmRrQWRCcU90?=
 =?utf-8?B?RWJISk4zdVhvTUxodXlRZHZpc3pQeHJ4U3F6bFpMREVuWXcwb3FZd2hGRmxq?=
 =?utf-8?B?V3RxMzhQN1kxUXpiMXo4SXkwemwyTnBlTjRRTGRNVnpzZ2MzOVJkM0VKc2VB?=
 =?utf-8?B?NjZpYVBFUjRxR0YrRnViZnFXaG5iQkRacHQvVlNobDU3UXRMWk8xcXQwemYw?=
 =?utf-8?B?OGNwMGZyanMvVWxwL1BXVDkvc3NuMDdHdFpKa095RzZUaDJxV1k2elBrdUxh?=
 =?utf-8?B?cVJuR2FqRlVROU1EZ1h2NWFGRTVtR1lBZWZrMTRzVnlTUm9USnArS01xQ1F5?=
 =?utf-8?B?aUI3ZTZ5aVljTjczQ1A3RHZrYmI4WDRUZHN6L3ZRWmdKNjJvQUkrRHBXQlFw?=
 =?utf-8?B?MDBZSHZvQlFhcDdWN0Y0ZTl4K0l0TmxlQ3lCbnlIcCsvZ0JqMnJmcFR4aTAw?=
 =?utf-8?B?eVg2bmFubG9YYUEvVDB0R1F5OWNvbitabFZPWGYvczFSMzVpM1J1QVVTOGJV?=
 =?utf-8?B?NElUaG9HMmlENC92alJYTFVnN1pUVlJvUkppTndEWURLNU5UaG5EenRob2d3?=
 =?utf-8?B?aEFhbnZXVzVDMnl2VUY2dVlVT3ZvcjNlNXdtMHZEWFVBWER6ME9qN1lUWjZk?=
 =?utf-8?B?SzByUnhuQjZWTWk0aHo3ZXY2Q1AxZEpWUXlsNEI4dnZtQm85M200Zy9PdldV?=
 =?utf-8?B?MEp2azMwYlN4MHVjYlRtZFI3RW0zeEhnVHdNYU54QXo0Wlcyby9KRnhZbkpM?=
 =?utf-8?B?dmMvNDdSSDBobThLbUxkNjUzekM5aWs2L1p5V1FLcW5kVER2TCtLMmg0YUhn?=
 =?utf-8?Q?qc5UMHGyK917WgAXJThafNqns?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 185755b5-bb26-4ac5-a976-08db6718b18f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 05:33:16.3307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VL7gZILF6tahkRIaozgYkqeTbEmWgOr/7d0LxBUmOuThxnpxY1ln4zXDJgYi+njURjucZyynYYhisNCmISMqlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5763
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 6/7/2023 10:21 AM, Yin Fengwei wrote:
> 
> 
> On 6/7/23 02:07, Matthew Wilcox wrote:
>> On Mon, Jun 05, 2023 at 04:25:22PM +0800, Yin, Fengwei wrote:
>>> On 6/5/2023 6:11 AM, Matthew Wilcox wrote:
>>>> On Sun, Jun 04, 2023 at 11:29:52AM -0700, Darrick J. Wong wrote:
>>>>> On Fri, Jun 02, 2023 at 11:24:44PM +0100, Matthew Wilcox (Oracle) wrote:
>>>>>> -		copied = copy_page_from_iter_atomic(page, offset, bytes, i);
>>>>>> +		copied = copy_page_from_iter_atomic(&folio->page, offset, bytes, i);
>>>>>
>>>>> I think I've gotten lost in the weeds.  Does copy_page_from_iter_atomic
>>>>> actually know how to deal with a multipage folio?  AFAICT it takes a
>>>>> page, kmaps it, and copies @bytes starting at @offset in the page.  If
>>>>> a caller feeds it a multipage folio, does that all work correctly?  Or
>>>>> will the pagecache split multipage folios as needed to make it work
>>>>> right?
>>>>
>>>> It's a smidgen inefficient, but it does work.  First, it calls
>>>> page_copy_sane() to check that offset & n fit within the compound page
>>>> (ie this all predates folios).
>>>>
>>>> ... Oh.  copy_page_from_iter() handles this correctly.
>>>> copy_page_from_iter_atomic() doesn't.  I'll have to fix this
>>>> first.  Looks like Al fixed copy_page_from_iter() in c03f05f183cd
>>>> and didn't fix copy_page_from_iter_atomic().
>>>>
>>>>> If we create a 64k folio at pos 0 and then want to write a byte at pos
>>>>> 40k, does __filemap_get_folio break up the 64k folio so that the folio
>>>>> returned by iomap_get_folio starts at 40k?  Or can the iter code handle
>>>>> jumping ten pages into a 16-page folio and I just can't see it?
>>>>
>>>> Well ... it handles it fine unless it's highmem.  p is kaddr + offset,
>>>> so if offset is 40k, it works correctly on !highmem.
>>> So is it better to have implementations for !highmem and highmem? And for
>>> !highmem, we don't need the kmap_local_page()/kunmap_local() and chunk
>>> size per copy is not limited to PAGE_SIZE. Thanks.
>>
>> No, that's not needed; we can handle that just fine.  Maybe this can
>> use kmap_local_page() instead of kmap_atomic().  Al, what do you think?
>> I haven't tested this yet; need to figure out a qemu config with highmem ...
>>
>> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
>> index 960223ed9199..d3d6a0789625 100644
>> --- a/lib/iov_iter.c
>> +++ b/lib/iov_iter.c
>> @@ -857,24 +857,36 @@ size_t iov_iter_zero(size_t bytes, struct iov_iter *i)
>>  }
>>  EXPORT_SYMBOL(iov_iter_zero);
>>  
>> -size_t copy_page_from_iter_atomic(struct page *page, unsigned offset, size_t bytes,
>> -				  struct iov_iter *i)
>> +size_t copy_page_from_iter_atomic(struct page *page, unsigned offset,
>> +		size_t bytes, struct iov_iter *i)
>>  {
>> -	char *kaddr = kmap_atomic(page), *p = kaddr + offset;
>> -	if (!page_copy_sane(page, offset, bytes)) {
>> -		kunmap_atomic(kaddr);
>> +	size_t n = bytes, copied = 0;
>> +
>> +	if (!page_copy_sane(page, offset, bytes))
>>  		return 0;
>> -	}
>> -	if (WARN_ON_ONCE(!i->data_source)) {
>> -		kunmap_atomic(kaddr);
>> +	if (WARN_ON_ONCE(!i->data_source))
>>  		return 0;
>> +
>> +	page += offset / PAGE_SIZE;
>> +	offset %= PAGE_SIZE;
>> +	if (PageHighMem(page))
>> +		n = min_t(size_t, bytes, PAGE_SIZE);
> This is smart.
> 
>> +	while (1) {
>> +		char *kaddr = kmap_atomic(page) + offset;
>> +		iterate_and_advance(i, n, base, len, off,
>> +			copyin(kaddr + off, base, len),
>> +			memcpy_from_iter(i, kaddr + off, base, len)
>> +		)
>> +		kunmap_atomic(kaddr);
>> +		copied += n;
>> +		if (!PageHighMem(page) || copied == bytes || n == 0)
>> +			break;
> My understanding is copied == bytes could cover !PageHighMem(page).
> 
>> +		offset += n;
>> +		page += offset / PAGE_SIZE;
> Should be page += n / PAGE_SIZE? Thanks.
offset / PAGE_SIZE is correct. Sorry for the noise.

Regards
Yin, Fengwei

> 
> 
> Regards
> Yin, Fengwei
> 
>> +		offset %= PAGE_SIZE;
>> +		n = min_t(size_t, bytes - copied, PAGE_SIZE);
>>  	}
>> -	iterate_and_advance(i, bytes, base, len, off,
>> -		copyin(p + off, base, len),
>> -		memcpy_from_iter(i, p + off, base, len)
>> -	)
>> -	kunmap_atomic(kaddr);
>> -	return bytes;
>> +	return copied;
>>  }
>>  EXPORT_SYMBOL(copy_page_from_iter_atomic);
>>  
