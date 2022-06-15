Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33ABE54C206
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 08:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354712AbiFOGi7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 02:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354748AbiFOGi4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 02:38:56 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD89443EB;
        Tue, 14 Jun 2022 23:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655275132; x=1686811132;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9OAic8fTowdtg7WFnn6Te1v1Kx8SGTIwb/xwmX7szmE=;
  b=SDZ9HHNx4MM4FuMUWbWgEKqk3COrHHYGtBot3FQaBaT9KuQXkR8XdOox
   eslMNedIa35MuKM66EQVuZ7yPqHJF9cFeX+r/ye9sfNqF48fVybvaenQ/
   K1oru7PAKep58j7B0Otw5/iUl6l4Ky6BVmskjkfSUzhTCj6mkBkF1xF7O
   S92D/rvw1a+FlMaW9YCa9PY5Tx01G+/u3lBqoCWPIGl5WizT5Se1brNVI
   m3jTN9dIvEfL8Rmb//3oNi112vTK25CkApCO4yjD7bdxdSFzayD+uLFP3
   bGj3qyUhXtkjpy/zAIw5725oYyVlD02rckziwX1b95FN2+RIl/puImwFD
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="277647888"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="277647888"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 23:38:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="558877549"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga006.jf.intel.com with ESMTP; 14 Jun 2022 23:38:47 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 14 Jun 2022 23:38:46 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 14 Jun 2022 23:38:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 14 Jun 2022 23:38:45 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 14 Jun 2022 23:38:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N53yQgPMk9wGUoTYj3BCV6RbOk6Avzt1lAMpCD3lO7Nbw3Gd2Pv58c5onBCF/GqPrEc9/OQiVLKdKopjafQ4aZZBZeOxrmaAxy5J0cCrxf4q/LlXugHwHGKKw0KETk1O8cacsifEfdMisvUg9d1g4m7BjfoOuPoBh43uGrZeCL/44wP0dI7yk8UIAqULrgybKjioCXz1a6cH5Y239wZs6oKIIo5jsbi+RdACWbumN/WbhjHd74z8rvzPz3WjxHqsUN1dDUrAFgBp0SPUKEcVcSsw+/ENX1mXz/cUUaQcfl3CZiIStYuzJXOJOYxuCU8k8YuBP6evJCONGFcniZuk+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3W6YP1yqbt67NUkMXbCzUa6L3lfmms9aDbod/4zPgk=;
 b=QEnZsroBuPJzkJVt/JZR0Kkc50yacRTzpLw3g/fDJ65JA959sC7XygsNkdwVRaViRIOg1QgmzVWG3Bdy4WS3U2v6yriyxRZq2VmstIuo/KRZ3yYpOAZnWpLmDX0MWVw5mFHpp/vYNumdqmen68WKYX/ksfbCxMr2B28lV9ALxaDoIiVv6GHDTl1P0dtm0X4yGpuFAmx/57ufBW6r0zSOwNP7DHI4V+3JADapIXW8UtSR0LYZ2c8T9NFosN9KcoVvvR4wYv1Qg27+TPmq2ekTgcKEvaH922tA6XeJCkG3B+LH1bZsldlVSaHYDcdJKtXEtTrHiQCdew6ixWdCv6aaBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by BL0PR11MB3217.namprd11.prod.outlook.com (2603:10b6:208:63::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.17; Wed, 15 Jun
 2022 06:38:33 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::39e0:6f4d:9c2a:85d9]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::39e0:6f4d:9c2a:85d9%9]) with mapi id 15.20.5353.014; Wed, 15 Jun 2022
 06:38:33 +0000
Message-ID: <1e8deaea-5a05-1846-d51c-b834beb9f23e@intel.com>
Date:   Wed, 15 Jun 2022 14:38:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [LKP] Re: [mm/readahead] 793917d997: fio.read_iops -18.8%
 regression
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        kernel test robot <oliver.sang@intel.com>
CC:     LKML <linux-kernel@vger.kernel.org>, <lkp@lists.01.org>,
        <lkp@intel.com>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
References: <20220418144234.GD25584@xsang-OptiPlex-9020>
 <Yl2bKRcRqbcMmhji@casper.infradead.org>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <Yl2bKRcRqbcMmhji@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:54::19) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c41b0ca7-19c6-4ee6-1b34-08da4e99aaa3
X-MS-TrafficTypeDiagnostic: BL0PR11MB3217:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BL0PR11MB3217F8AC8783E58118AF3510EEAD9@BL0PR11MB3217.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: inT2lLPXqq3lIrnH3M6NlLh8GeXHod1P1ldTNE4uNJCryzGaXqA5NJH2ntz14k5ZOqxvgWy9X2JkKT7l3aaCEei+tb+L307C0WwIc67WTw9595fXSCk9O9EAyUWkIMtTvbxDmh47dXPBu50SrfhnI3NX/miqAec3LOEJtio/+ctmz1mV9LKW0YviAodVzUWW8bJE2bCGFDuvQC3xfiqQN6B6f9KyLcJj8nZCdeqP+wackPyKyPEN2tI1aT9Xlb2+la+mOTfJgj7VYJBB9P3fYPVXZ0uVa+CSoB0dBjphyk7tk/mTadWLJ3Jwbhl3lQ95OY2+CmP3YTX6/ddZo5TiT+mkAdzNHpdGtssBBbbdq76orXXZ78AfsFN1s3BuoZn+DlZJE18yjL4xswOFtz5HPG41PQqTuP4WaR2dXxqNusTFg0RZiBCZRDW0qE5eImXRXXq59oEwht0x5VpMRlCPv0kbPiUU8NWyABtkmxDeYf4WmN7bP/OAE+h393BpxJ0iWbo4KDMgd3Xo1JOjOMurkd4eAQQ4varKxKfNI/TIAtFcPRaVG4r+LsmduylhjupJ13hXnONQmSZP6MrWNGH+XByTepFtGj75LuBVpNX9FdSHkHVKBHUXFjUUiCAiuStXYQ7AQ5fr+IZrysT/fHvPuLceYbkUhICeqLZ1ho70eOxzGmiNnKN4jYEAsmBr3w5An5SQAaa7N9I5MuW3wIcdroqKLM+2AQgJzhGcD7tITF/e1Mo9fwrI57kDzzjwzJxfmUpfj/Ioz0iOHVxnlcoMtA6IlohR6bxqoZFToHkpmss0tGutRspFsBREIG5UthhKH2iWL5VCC0WkbOmVQN1Pze28hJgbFYBJFyo3hbH1jEU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(30864003)(8936002)(6636002)(45080400002)(6486002)(966005)(5660300002)(82960400001)(83380400001)(186003)(508600001)(2616005)(53546011)(6666004)(2906002)(26005)(6512007)(110136005)(31696002)(6506007)(66476007)(38100700002)(31686004)(8676002)(66946007)(66556008)(4326008)(86362001)(316002)(36756003)(19627235002)(66574015)(43740500002)(45980500001)(559001)(579004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHFIcHBhZE9RTDJFU1BaZldpZWdQTm5yWDdyaEdQMGFHUlNsTlh4cURXSkZM?=
 =?utf-8?B?WVVtaEFDKytGV1lOVzQyZ3l6U1B5OUh1WERrWWRnd2xta1pRN0JnN3M3bG54?=
 =?utf-8?B?WG5qYmNOYWJTazFVaVhpYkgybld5VWJyRDlUM2oyR2E1M1JKM3I1bno4THZr?=
 =?utf-8?B?NHNhdDdCUmtwdWFGbGJudlhJQlVPTkI4dEUrRitGL2QvcHhUZGo0WWs2RVFh?=
 =?utf-8?B?T3pWSkNNakp1MVFYSzZGbHcxNDI2WG9SWVlvandNcTllWUw3Z041eDdQbDR3?=
 =?utf-8?B?SmF5c3J2N1dzK0lpZlgweHZEY2ZScHk2QjhQZEMvamFyR3dKUHlhTldUZ2xB?=
 =?utf-8?B?TW05M0tLT2NiM3VwbEpmY3VFaG9LWWx4YmpFSzRNZVpNN3lUeXUycGg1ZXln?=
 =?utf-8?B?ckRtRmtMK3BMRW0rRHAwdjFwRTNzODJ2Z05XUWUzeWV1bDQ5TDlhTUNyTXMr?=
 =?utf-8?B?ZjQ3ZmtHaVNtdlE1UDJJNUFXTktYcGcyaE9jUzloREdKZ3BwSXd6bGt3KzR6?=
 =?utf-8?B?dHFuTllubDBtMjJWYzVHUENPTE9LSmZUVy85VmRFZlVob0xtOVZobnZCdG5W?=
 =?utf-8?B?ZDZWQWdtQlFLTVRyM1Y2ZHQ0MkZTKzc5cjRCWnE2RE1Qd0sxdTVoY013VWhn?=
 =?utf-8?B?MCtRb0VYWHNaZ3NlVFhVb2NMdDZPYk95anhwVWtSSDhmMmg5dnk2WTNxUzU1?=
 =?utf-8?B?enBVc1JLUEp3a3VGQkliQk9YMEVNcENRTHprK3gyWUV1Mi9kZi9EbjdSL3Nt?=
 =?utf-8?B?ckxoU0xOdFVCMkdGeW5pZ1o1bEU3MllWMmgycXUxZlF2NEg4cVdrR3N2RnBY?=
 =?utf-8?B?cFdMV0pYVzRtYlBwNXdsdiswV1ZZK1pWSitnSkdRUFBKa3RkcGtPMVpOUFdZ?=
 =?utf-8?B?U2dlOHhZa201d0xkdGZsbWNuZVR0Mm8rUURHL0ZTRXlsVnR5STFGMHNIR3dP?=
 =?utf-8?B?VEUwQk4rVWFGOHNEL2dXNldMcUNpZElpZmN1UUlYTFlrWXhCNHk0TmlVUmky?=
 =?utf-8?B?a0d6RlNiR0RqcXpOU25TeEIwTEVxVUluN2RyUHdTT0Zpd001QnNacm1VRzMx?=
 =?utf-8?B?WG95WENZWnBLOEVYbm5RclV4aFJIOWp2MjJycmk3UWpkcERGeW4yM3NEb1Fw?=
 =?utf-8?B?dEYyVmZCWG1TSElwSEdqVFJVN2Y5WkRRbFMxSDVwZlJJbmtxRWh3dzMySVZi?=
 =?utf-8?B?SEoyeXJpZlNuZ0pKT0xxK09SY25COTlDWnV1elBlbm1wRUJKSTdNS051R3Ra?=
 =?utf-8?B?NVd0M1J3V1k4Sk5JWXRQdklXU1cwUkNRSFdRdGtXUiswaWRQTlB3RlMrVzVV?=
 =?utf-8?B?NXNqR0JTMXlQQVFscU9RcVo1TUdZNUtqTHB3bGZSbVlSN0NGRHdUZXU3YjZO?=
 =?utf-8?B?UzQ5UDRCZ2dVQ1FGaGt0dTdFcVZobUd4MTM4S2YxbmpCN3JoeUNwQUpuUWtI?=
 =?utf-8?B?cFJFSGZtL24xcGJra1NkS053VE1zdHlVQXpxaGtPNmRJYTBSYTZNdDN3bUtY?=
 =?utf-8?B?djloUlRlSkgxM0Y3NlBpTFI1ZjNvZnpFZ3hHd1NNM0xrNUxUUjgxRmpnV0li?=
 =?utf-8?B?NmV5SG0vTHJwdW1JR0U2SlJkeEN0OXdIVkFuKzJiL283elVNMm5wOFhqZXpu?=
 =?utf-8?B?VDI5a2xkRlNWNjlLSGMzK0hYMFpLWmRLU2tDdGlKRVFSSktCUlMwdFhYSUJh?=
 =?utf-8?B?YjJ4c0xpYWg3QVBORVJHTlAwN3hUakxzUU8ycnFwbUFEc0d0YWNSZ3NLc0U1?=
 =?utf-8?B?WW1zNkZPVHM1bW5GWU9QU2VqZlQ2c29KckwxbDJHWS9SR0pDNnp1QndlT2pH?=
 =?utf-8?B?aHgvV1phVHUvUGNqTUZVaDJ0OTRlb29uV2J6VWZqbit3RmhpWHB2VlNKR3NO?=
 =?utf-8?B?QWhmeDFQM013Y1N3V0pkWU1OWHE1bzFzQlNod0JzRjBmNGpRSWNoQ3lkd0ZT?=
 =?utf-8?B?aU83WWFQdzZPcFBQcmhIZVB6NjlMY29DYVBlTlQ4WFZCZDY5Y0tuYkdLOGlm?=
 =?utf-8?B?eFFVZ1BTcFJydEQxKzBUa0NvSC9NUXlGY2xaWitNMnFoaVdjd3ordm93RVhQ?=
 =?utf-8?B?VWpaaUNYWFdjOXZ1SXhhVmZtdUtpajA2NDV5RXJHamF4ZHBJVGlxZFNTdHVZ?=
 =?utf-8?B?dFIybHJRL0RsTmJaT0p5VXNEenJwcThmdWRLbjdadlVxYXFBMnJPT21wSmN5?=
 =?utf-8?B?L3FvaGRuTjJodjIxOWZzL0IvWEFJYnM5bkdzWlRaMHQ1SklaVnVyQzF2UVQ2?=
 =?utf-8?B?VkFya2tURitDWnUrdUFWMjFzSUluUkhYc2daTUJZQUVCYVpmcU1YMisvT0FF?=
 =?utf-8?B?UUJXWjNDQ3pYb3Q2aHBlR0Q3ZUJ5Tm9iQm40dmt6QTBYMGpaZGs1RThPVVhJ?=
 =?utf-8?Q?NflZcIGHl84w1H9k=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c41b0ca7-19c6-4ee6-1b34-08da4e99aaa3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 06:38:33.8277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AyU4TxnndhK6fePzsB90medpG7nDZMumDDIdgJAp/tFRNFHmmr3p6EEK5H96VXTjdgWlk2gSahQGOZZG4rJoOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3217
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


On 4/19/2022 1:08 AM, Matthew Wilcox wrote:
> 
> I'm on holiday today, but adding linux-fsdevel and linux-mm so relevant
> people know about this.
> 
> Don't focus on the 18% regression, focus on the 240% improvement on the
> other benchmark ;-)
> 
> Seriously, someone (probably me) needs to dig into what the benchmark
> is doing and understand whether there's a way to avoid (or decide this
> regression isn't relevant) while keeping the performance gains elsewhere.
With:
commit b9ff43dd27434dbd850b908e2e0e1f6e794efd9b
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Wed Apr 27 17:01:28 2022 -0400

    mm/readahead: Fix readahead with large folios

    Reading 100KB chunks from a big file (eg dd bs=100K) leads to poor
    readahead behaviour.  Studying the traces in detail, I noticed two
    problems.

    The first is that we were setting the readahead flag on the folio which
    contains the last byte read from the block.  This is wrong because we
    will trigger readahead at the end of the read without waiting to see
    if a subsequent read is going to use the pages we just read.  Instead,
    we need to set the readahead flag on the first folio after the one
    which contains the last byte that we're reading.

    The second is that we were looking for the index of the folio with the
    readahead flag set to exactly match the start + size - async_size.
    If we've rounded this, either down (as previously) or up (as now),
    we'll think we hit a folio marked as readahead by a different read,
    and try to read the wrong pages.  So round the expected index to the
    order of the folio we hit.

the regression is almost gone:
commit:
  18788cfa236967741b83db1035ab24539e2a21bb
  b9ff43dd27434dbd850b908e2e0e1f6e794efd9b

18788cfa23696774 b9ff43dd27434dbd850b908e2e0
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
       4698:9       -36360%        1426:3     dmesg.timestamp:last
       3027:9       -22105%        1037:3     kmsg.timestamp:last
         %stddev     %change         %stddev
             \          |                \
      0.39 ±253%      -0.3        0.09 ±104%  fio.latency_1000us%
      0.00 ±141%      +0.0        0.01        fio.latency_100ms%
     56.60 ±  5%     +10.3       66.92 ±  8%  fio.latency_10ms%
     15.65 ± 22%      -1.3       14.39 ± 17%  fio.latency_20ms%
      1.46 ±106%      -0.5        0.95 ± 72%  fio.latency_2ms%
     25.81 ± 25%      -9.2       16.59 ± 18%  fio.latency_4ms%
      0.09 ± 44%      +0.9        1.04 ± 22%  fio.latency_50ms%
      0.00 ±282%      +0.0        0.02 ±141%  fio.latency_750us%
     13422 ±  6%      -1.4%      13233        fio.read_bw_MBps   <-----
  11439672 ±  6%      -1.3%   11294037 ±  7%  fio.read_clat_90%_us
  13988295 ±  6%     +25.9%   17607338        fio.read_clat_95%_us
  17723847           +13.1%   20054016        fio.read_clat_99%_us
   6376330 ±  5%      +7.7%    6866076 ±  2%  fio.read_clat_mean_us


Regards
Yin, Fengwei

> 
> On Mon, Apr 18, 2022 at 10:42:34PM +0800, kernel test robot wrote:
>>
>>
>> Greeting,
>>
>> FYI, we noticed a -18.8% regression of fio.read_iops due to commit:
>>
>>
>> commit: 793917d997df2e432f3e9ac126e4482d68256d01 ("mm/readahead: Add large folio readahead")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>
>> in testcase: fio-basic
>> on test machine: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 512G memory
>> with following parameters:
>>
>> 	disk: 2pmem
>> 	fs: xfs
>> 	runtime: 200s
>> 	nr_task: 50%
>> 	time_based: tb
>> 	rw: read
>> 	bs: 2M
>> 	ioengine: sync
>> 	test_size: 200G
>> 	cpufreq_governor: performance
>> 	ucode: 0x500320a
>>
>> test-description: Fio is a tool that will spawn a number of threads or processes doing a particular type of I/O action as specified by the user.
>> test-url: https://github.com/axboe/fio
>>
>> In addition to that, the commit also has significant impact on the following tests:
>>
>> +------------------+-------------------------------------------------------------------------------------+
>> | testcase: change | vm-scalability: vm-scalability.throughput 241.0% improvement                        |
>> | test machine     | 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
>> | test parameters  | cpufreq_governor=performance                                                        |
>> |                  | runtime=300s                                                                        |
>> |                  | test=mmap-pread-seq                                                                 |
>> |                  | ucode=0x500320a                                                                     |
>> +------------------+-------------------------------------------------------------------------------------+
>> | testcase: change | vm-scalability: vm-scalability.throughput 64.8% improvement                         |
>> | test machine     | 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
>> | test parameters  | cpufreq_governor=performance                                                        |
>> |                  | runtime=300s                                                                        |
>> |                  | test=mmap-pread-seq-mt                                                              |
>> |                  | ucode=0x500320a                                                                     |
>> +------------------+-------------------------------------------------------------------------------------+
>> | testcase: change | vm-scalability: vm-scalability.throughput 24.1% improvement                         |
>> | test machine     | 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz with 112G memory     |
>> | test parameters  | cpufreq_governor=performance                                                        |
>> |                  | runtime=300s                                                                        |
>> |                  | test=migrate                                                                        |
>> |                  | ucode=0x42e                                                                         |
>> +------------------+-------------------------------------------------------------------------------------+
>> | testcase: change | vm-scalability: vm-scalability.throughput 45.0% improvement                         |
>> | test machine     | 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
>> | test parameters  | cpufreq_governor=performance                                                        |
>> |                  | runtime=300s                                                                        |
>> |                  | test=lru-file-mmap-read                                                             |
>> |                  | ucode=0x500320a                                                                     |
>> +------------------+-------------------------------------------------------------------------------------+
>>
>>
>> If you fix the issue, kindly add following tag
>> Reported-by: kernel test robot <oliver.sang@intel.com>
>>
>>
>> Details are as below:
>> -------------------------------------------------------------------------------------------------->
>>
>>
>> To reproduce:
>>
>>         git clone https://github.com/intel/lkp-tests.git
>>         cd lkp-tests
>>         sudo bin/lkp install job.yaml           # job file is attached in this email
>>         bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>>         sudo bin/lkp run generated-yaml-file
>>
>>         # if come across any failure that blocks the test,
>>         # please remove ~/.lkp and /lkp dir to run from a clean state.
>>
>> =========================================================================================
>> bs/compiler/cpufreq_governor/disk/fs/ioengine/kconfig/nr_task/rootfs/runtime/rw/tbox_group/test_size/testcase/time_based/ucode:
>>   2M/gcc-11/performance/2pmem/xfs/sync/x86_64-rhel-8.3/50%/debian-10.4-x86_64-20200603.cgz/200s/read/lkp-csl-2sp7/200G/fio-basic/tb/0x500320a
>>
>> commit: 
>>   18788cfa23 ("mm: Support arbitrary THP sizes")
>>   793917d997 ("mm/readahead: Add large folio readahead")
>>
>> 18788cfa23696774 793917d997df2e432f3e9ac126e 
>> ---------------- --------------------------- 
>>          %stddev     %change         %stddev
>>              \          |                \  
>>       0.57 ±204%      -0.6        0.00 ±223%  fio.latency_1000us%
>>      16.62 ± 22%     +24.7       41.29 ±  3%  fio.latency_20ms%
>>       1.64 ±103%      -1.6        0.08 ±112%  fio.latency_2ms%
>>      24.33 ± 30%     -23.0        1.35 ± 17%  fio.latency_4ms%
>>       0.10 ± 45%      +0.2        0.33 ± 17%  fio.latency_50ms%
>>      13189 ±  7%     -18.8%      10710        fio.read_bw_MBps
>>   11643562 ±  6%     +33.0%   15488341        fio.read_clat_90%_us
>>   14265002 ±  5%     +13.3%   16165546        fio.read_clat_95%_us
>>    6493088 ±  5%     +37.0%    8897953        fio.read_clat_mean_us
>>    3583181 ±  6%     +16.5%    4173165 ±  2%  fio.read_clat_stddev
>>       6594 ±  7%     -18.8%       5355        fio.read_iops
>>  5.417e+09 ±  6%     -19.0%  4.388e+09        fio.time.file_system_inputs
>>      36028 ±  2%     -35.5%      23253        fio.time.involuntary_context_switches
>>      31.69 ±  9%     +42.8%      45.26 ±  4%  fio.time.user_time
>>      21307            -5.2%      20198        fio.time.voluntary_context_switches
>>    1322167 ±  6%     -19.0%    1071118        fio.workload
>>     451.73            -2.9%     438.55        pmeter.Average_Active_Power
>>   13277785 ±  7%     -18.6%   10808063        vmstat.io.bi
>>       2158           -14.8%       1839        vmstat.system.cs
>>       1.72 ±  5%      +0.5        2.20        mpstat.cpu.all.irq%
>>       0.22 ± 13%      +0.1        0.33 ±  3%  mpstat.cpu.all.soft%
>>       0.27 ± 12%      +0.2        0.46 ±  3%  mpstat.cpu.all.usr%
>>     341045           -67.6%     110363        meminfo.KReclaimable
>>      64800 ±  8%     +21.6%      78827 ±  7%  meminfo.Mapped
>>     341045           -67.6%     110363        meminfo.SReclaimable
>>     555633           -40.9%     328399        meminfo.Slab
>>       0.06 ±  6%     -67.6%       0.02        turbostat.IPC
>>      13881 ± 56%     -60.3%       5510 ± 62%  turbostat.POLL
>>      66.00            -3.0%      64.00        turbostat.PkgTmp
>>     276.27            -2.7%     268.67        turbostat.PkgWatt
>>  3.121e+08 ± 16%     -99.4%    1987161 ±  5%  numa-numastat.node0.local_node
>>  1.059e+08 ± 12%     -98.6%    1510071 ±  4%  numa-numastat.node0.numa_foreign
>>  3.113e+08 ± 16%     -99.3%    2032533 ±  4%  numa-numastat.node0.numa_hit
>>  2.627e+08 ±  3%     -99.0%    2626722 ±  3%  numa-numastat.node1.local_node
>>  2.621e+08 ±  3%     -99.0%    2668324 ±  2%  numa-numastat.node1.numa_hit
>>  1.059e+08 ± 12%     -98.6%    1510159 ±  4%  numa-numastat.node1.numa_miss
>>  1.061e+08 ± 12%     -98.5%    1551712 ±  2%  numa-numastat.node1.other_node
>>     163410 ±  3%     -64.4%      58180 ± 38%  numa-meminfo.node0.KReclaimable
>>     163410 ±  3%     -64.4%      58180 ± 38%  numa-meminfo.node0.SReclaimable
>>     272215 ±  6%     -34.0%     179749 ± 13%  numa-meminfo.node0.Slab
>>   64115515 ±  4%     +11.0%   71186782        numa-meminfo.node1.FilePages
>>     177499 ±  3%     -70.6%      52181 ± 44%  numa-meminfo.node1.KReclaimable
>>   65243028 ±  4%     +10.8%   72267036        numa-meminfo.node1.MemUsed
>>     177499 ±  3%     -70.6%      52181 ± 44%  numa-meminfo.node1.SReclaimable
>>     283269 ±  6%     -47.5%     148640 ± 18%  numa-meminfo.node1.Slab
>>     931356 ±  2%     +17.3%    1092480        sched_debug.cpu.avg_idle.avg
>>    1444016 ±  8%     +19.3%    1722423 ±  3%  sched_debug.cpu.avg_idle.max
>>     339528 ± 20%     +70.6%     579295 ± 16%  sched_debug.cpu.avg_idle.min
>>     187998 ±  9%     +47.3%     276979 ±  4%  sched_debug.cpu.avg_idle.stddev
>>       8.03 ± 42%    +204.5%      24.45 ± 25%  sched_debug.cpu.clock.stddev
>>     516781           +11.8%     577621        sched_debug.cpu.max_idle_balance_cost.avg
>>     705916 ±  7%     +21.6%     858128 ±  3%  sched_debug.cpu.max_idle_balance_cost.max
>>      38577 ± 31%    +150.1%      96487 ±  9%  sched_debug.cpu.max_idle_balance_cost.stddev
>>       0.00 ± 17%    +122.4%       0.00 ± 49%  sched_debug.cpu.next_balance.stddev
>>      40844 ±  3%     -64.4%      14543 ± 38%  numa-vmstat.node0.nr_slab_reclaimable
>>  1.059e+08 ± 12%     -98.6%    1510071 ±  4%  numa-vmstat.node0.numa_foreign
>>  3.113e+08 ± 16%     -99.3%    2032392 ±  4%  numa-vmstat.node0.numa_hit
>>  3.121e+08 ± 16%     -99.4%    1987020 ±  5%  numa-vmstat.node0.numa_local
>>       3202 ±101%     -98.8%      38.17 ± 60%  numa-vmstat.node0.workingset_nodes
>>   16031245 ±  4%     +10.9%   17773973        numa-vmstat.node1.nr_file_pages
>>      44374 ±  3%     -70.6%      13045 ± 44%  numa-vmstat.node1.nr_slab_reclaimable
>>   2.62e+08 ±  3%     -99.0%    2668367 ±  2%  numa-vmstat.node1.numa_hit
>>  2.626e+08 ±  3%     -99.0%    2626765 ±  3%  numa-vmstat.node1.numa_local
>>  1.059e+08 ± 12%     -98.6%    1510159 ±  4%  numa-vmstat.node1.numa_miss
>>  1.061e+08 ± 12%     -98.5%    1551712 ±  2%  numa-vmstat.node1.numa_other
>>     299.83 ± 34%     -95.6%      13.33 ± 74%  numa-vmstat.node1.workingset_nodes
>>     318998 ±113%     -99.4%       1970 ±141%  proc-vmstat.compact_daemon_free_scanned
>>     193995 ± 28%    +430.3%    1028832 ± 27%  proc-vmstat.compact_daemon_migrate_scanned
>>   42975962 ± 42%     -95.3%    2030090 ± 41%  proc-vmstat.compact_free_scanned
>>    7148833 ± 16%     -98.6%      97725 ± 18%  proc-vmstat.compact_isolated
>>   26398894 ± 11%     -30.4%   18367268 ± 31%  proc-vmstat.compact_migrate_scanned
>>       9977 ±  2%      -4.6%       9519 ±  3%  proc-vmstat.nr_active_anon
>>   26107465            +4.9%   27388404        proc-vmstat.nr_file_pages
>>   50836830            -2.5%   49578796        proc-vmstat.nr_free_pages
>>   25502602            +5.0%   26782320        proc-vmstat.nr_inactive_file
>>      16509 ±  8%     +20.7%      19932 ±  6%  proc-vmstat.nr_mapped
>>      85277           -67.6%      27589        proc-vmstat.nr_slab_reclaimable
>>      53644            +1.6%      54503        proc-vmstat.nr_slab_unreclaimable
>>       9977 ±  2%      -4.6%       9519 ±  3%  proc-vmstat.nr_zone_active_anon
>>   25502515            +5.0%   26782297        proc-vmstat.nr_zone_inactive_file
>>  1.059e+08 ± 12%     -98.6%    1510071 ±  4%  proc-vmstat.numa_foreign
>>  5.734e+08 ± 10%     -99.2%    4702875 ±  2%  proc-vmstat.numa_hit
>>  5.748e+08 ± 10%     -99.2%    4615902 ±  2%  proc-vmstat.numa_local
>>  1.059e+08 ± 12%     -98.6%    1510159 ±  4%  proc-vmstat.numa_miss
>>  1.062e+08 ± 12%     -98.5%    1597130 ±  3%  proc-vmstat.numa_other
>>  6.695e+08 ±  6%     -18.7%  5.444e+08        proc-vmstat.pgalloc_normal
>>  6.592e+08 ±  6%     -21.1%  5.201e+08 ±  2%  proc-vmstat.pgfree
>>    3598703 ± 16%     -97.8%      80835 ± 11%  proc-vmstat.pgmigrate_success
>>  2.708e+09 ±  6%     -19.0%  2.194e+09        proc-vmstat.pgpgin
>>      13829 ± 86%    -100.0%       1.00 ±100%  proc-vmstat.pgrotated
>>   29010332 ± 58%     -85.8%    4115913 ± 55%  proc-vmstat.pgscan_file
>>   29010332 ± 58%     -85.8%    4114473 ± 55%  proc-vmstat.pgscan_kswapd
>>   28974103 ± 58%     -85.8%    4114957 ± 55%  proc-vmstat.pgsteal_file
>>   28974103 ± 58%     -85.8%    4113517 ± 55%  proc-vmstat.pgsteal_kswapd
>>       3588 ± 96%     -98.6%      51.50 ± 58%  proc-vmstat.workingset_nodes
>>      28.72 ±  3%    +109.8%      60.27        perf-stat.i.MPKI
>>  5.903e+09 ±  4%     -68.8%  1.841e+09        perf-stat.i.branch-instructions
>>       0.24 ±  3%      +0.1        0.36        perf-stat.i.branch-miss-rate%
>>   14069166 ±  5%     -54.5%    6402039        perf-stat.i.branch-misses
>>      85.42            +5.1       90.52        perf-stat.i.cache-miss-rate%
>>  7.328e+08 ±  7%     -20.1%  5.852e+08        perf-stat.i.cache-misses
>>  8.581e+08 ±  7%     -24.9%  6.444e+08        perf-stat.i.cache-references
>>       2034           -16.3%       1703        perf-stat.i.context-switches
>>       5.10 ±  5%    +188.5%      14.72        perf-stat.i.cpi
>>     230.67 ±  7%     +28.4%     296.26        perf-stat.i.cycles-between-cache-misses
>>       0.02 ± 14%      -0.0        0.00 ± 12%  perf-stat.i.dTLB-load-miss-rate%
>>    1298538 ± 17%     -93.1%      90201 ± 11%  perf-stat.i.dTLB-load-misses
>>  6.904e+09 ±  4%     -71.4%  1.976e+09        perf-stat.i.dTLB-loads
>>       0.02 ± 12%      -0.0        0.00 ± 20%  perf-stat.i.dTLB-store-miss-rate%
>>    1002153 ± 17%     -95.1%      49149 ± 20%  perf-stat.i.dTLB-store-misses
>>  4.381e+09 ±  6%     -61.1%  1.703e+09        perf-stat.i.dTLB-stores
>>      55.38 ±  2%     -11.7       43.67        perf-stat.i.iTLB-load-miss-rate%
>>    2015561 ±  7%     -42.1%    1166138        perf-stat.i.iTLB-load-misses
>>  3.049e+10 ±  4%     -65.3%  1.057e+10        perf-stat.i.instructions
>>      15085 ±  3%     -40.6%       8965 ±  2%  perf-stat.i.instructions-per-iTLB-miss
>>       0.22 ±  4%     -65.3%       0.08        perf-stat.i.ipc
>>      14.43            +5.4%      15.21        perf-stat.i.major-faults
>>       1115 ± 15%     +37.6%       1534        perf-stat.i.metric.K/sec
>>     190.01 ±  5%     -65.5%      65.55        perf-stat.i.metric.M/sec
>>      27.84 ± 14%     +10.8       38.67 ±  2%  perf-stat.i.node-load-miss-rate%
>>   33175146 ±  4%     +14.4%   37941465 ±  2%  perf-stat.i.node-load-misses
>>      25.76 ± 20%     +12.6       38.33 ±  2%  perf-stat.i.node-store-miss-rate%
>>   35188134 ± 10%     +35.5%   47664398 ±  2%  perf-stat.i.node-store-misses
>>      28.13 ±  3%    +116.5%      60.90        perf-stat.overall.MPKI
>>       0.24 ±  2%      +0.1        0.35        perf-stat.overall.branch-miss-rate%
>>      85.41            +5.4       90.82        perf-stat.overall.cache-miss-rate%
>>       4.52 ±  4%    +192.8%      13.24        perf-stat.overall.cpi
>>     188.69 ±  8%     +26.9%     239.44        perf-stat.overall.cycles-between-cache-misses
>>       0.02 ± 14%      -0.0        0.00 ± 11%  perf-stat.overall.dTLB-load-miss-rate%
>>       0.02 ± 13%      -0.0        0.00 ± 21%  perf-stat.overall.dTLB-store-miss-rate%
>>      56.41 ±  2%     -12.7       43.76        perf-stat.overall.iTLB-load-miss-rate%
>>      15146 ±  3%     -40.7%       8984        perf-stat.overall.instructions-per-iTLB-miss
>>       0.22 ±  4%     -65.9%       0.08        perf-stat.overall.ipc
>>      23.53 ± 13%      +7.7       31.24 ±  2%  perf-stat.overall.node-load-miss-rate%
>>      22.91 ± 19%      +9.8       32.76 ±  2%  perf-stat.overall.node-store-miss-rate%
>>    4618032 ±  3%     -57.6%    1956685        perf-stat.overall.path-length
>>  5.845e+09 ±  4%     -69.0%  1.811e+09        perf-stat.ps.branch-instructions
>>   13926188 ±  5%     -54.7%    6307104        perf-stat.ps.branch-misses
>>  7.264e+08 ±  7%     -20.8%   5.75e+08        perf-stat.ps.cache-misses
>>  8.503e+08 ±  7%     -25.5%  6.331e+08        perf-stat.ps.cache-references
>>       2016           -16.4%       1685        perf-stat.ps.context-switches
>>    1283289 ± 17%     -93.1%      88877 ± 11%  perf-stat.ps.dTLB-load-misses
>>  6.836e+09 ±  4%     -71.6%  1.944e+09        perf-stat.ps.dTLB-loads
>>     989408 ± 17%     -95.1%      48472 ± 20%  perf-stat.ps.dTLB-store-misses
>>  4.338e+09 ±  6%     -61.4%  1.674e+09        perf-stat.ps.dTLB-stores
>>    1997784 ±  7%     -42.1%    1157224        perf-stat.ps.iTLB-load-misses
>>  3.019e+10 ±  4%     -65.6%   1.04e+10        perf-stat.ps.instructions
>>   33161221 ±  4%     +15.1%   38152076 ±  2%  perf-stat.ps.node-load-misses
>>   35138617 ± 10%     +35.8%   47712507 ±  2%  perf-stat.ps.node-store-misses
>>  6.093e+12 ±  4%     -65.6%  2.096e+12        perf-stat.total.instructions
>>      40.24 ±  5%     -40.2        0.00        perf-profile.calltrace.cycles-pp.page_cache_ra_unbounded.filemap_get_pages.filemap_read.xfs_file_buffered_read.xfs_file_read_iter
>>      26.04 ±  4%     -26.0        0.00        perf-profile.calltrace.cycles-pp.read_pages.page_cache_ra_unbounded.filemap_get_pages.filemap_read.xfs_file_buffered_read
>>      26.03 ±  4%     -26.0        0.00        perf-profile.calltrace.cycles-pp.iomap_readahead.read_pages.page_cache_ra_unbounded.filemap_get_pages.filemap_read
>>      24.65 ±  5%     -24.6        0.00        perf-profile.calltrace.cycles-pp.__submit_bio_noacct.iomap_readahead.read_pages.page_cache_ra_unbounded.filemap_get_pages
>>      24.65 ±  5%     -24.6        0.00        perf-profile.calltrace.cycles-pp.__submit_bio.__submit_bio_noacct.iomap_readahead.read_pages.page_cache_ra_unbounded
>>       8.82 ± 25%      -8.8        0.00        perf-profile.calltrace.cycles-pp.filemap_add_folio.page_cache_ra_unbounded.filemap_get_pages.filemap_read.xfs_file_buffered_read
>>       7.78 ± 37%      -7.8        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.posix_fadvise64
>>       7.78 ± 37%      -7.8        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.posix_fadvise64
>>       7.78 ± 37%      -7.8        0.00        perf-profile.calltrace.cycles-pp.posix_fadvise64
>>       7.78 ± 37%      -7.8        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_fadvise64.do_syscall_64.entry_SYSCALL_64_after_hwframe.posix_fadvise64
>>       7.78 ± 37%      -7.8        0.00        perf-profile.calltrace.cycles-pp.ksys_fadvise64_64.__x64_sys_fadvise64.do_syscall_64.entry_SYSCALL_64_after_hwframe.posix_fadvise64
>>       7.78 ± 37%      -7.8        0.00        perf-profile.calltrace.cycles-pp.generic_fadvise.ksys_fadvise64_64.__x64_sys_fadvise64.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>       7.78 ± 37%      -7.8        0.00        perf-profile.calltrace.cycles-pp.invalidate_mapping_pagevec.generic_fadvise.ksys_fadvise64_64.__x64_sys_fadvise64.do_syscall_64
>>       6.88 ± 34%      -6.9        0.00        perf-profile.calltrace.cycles-pp.folio_add_lru.filemap_add_folio.page_cache_ra_unbounded.filemap_get_pages.filemap_read
>>       6.82 ± 34%      -6.8        0.00        perf-profile.calltrace.cycles-pp.__pagevec_lru_add.folio_add_lru.filemap_add_folio.page_cache_ra_unbounded.filemap_get_pages
>>       6.09 ± 41%      -6.1        0.00        perf-profile.calltrace.cycles-pp.__pagevec_release.invalidate_mapping_pagevec.generic_fadvise.ksys_fadvise64_64.__x64_sys_fadvise64
>>       6.08 ± 41%      -6.1        0.00        perf-profile.calltrace.cycles-pp.release_pages.__pagevec_release.invalidate_mapping_pagevec.generic_fadvise.ksys_fadvise64_64
>>       0.00            +0.5        0.54 ±  2%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.folio_alloc.page_cache_ra_order.filemap_get_pages
>>       0.00            +0.6        0.58 ±  3%  perf-profile.calltrace.cycles-pp.__alloc_pages.folio_alloc.page_cache_ra_order.filemap_get_pages.filemap_read
>>       0.00            +0.6        0.60 ±  2%  perf-profile.calltrace.cycles-pp.folio_alloc.page_cache_ra_order.filemap_get_pages.filemap_read.xfs_file_buffered_read
>>       0.00            +1.0        0.98        perf-profile.calltrace.cycles-pp.page_cache_ra_order.filemap_get_pages.filemap_read.xfs_file_buffered_read.xfs_file_read_iter
>>      64.14 ±  4%      +7.3       71.44        perf-profile.calltrace.cycles-pp.filemap_read.xfs_file_buffered_read.xfs_file_read_iter.new_sync_read.vfs_read
>>      64.15 ±  4%      +7.3       71.45        perf-profile.calltrace.cycles-pp.xfs_file_buffered_read.xfs_file_read_iter.new_sync_read.vfs_read.ksys_read
>>      64.16 ±  4%      +7.3       71.47        perf-profile.calltrace.cycles-pp.xfs_file_read_iter.new_sync_read.vfs_read.ksys_read.do_syscall_64
>>      64.16 ±  4%      +7.3       71.47        perf-profile.calltrace.cycles-pp.new_sync_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>      64.17 ±  4%      +7.3       71.50        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>>      64.19 ±  4%      +7.3       71.52        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>>      64.18 ±  4%      +7.3       71.51        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>>      64.19 ±  4%      +7.3       71.52        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
>>      64.20 ±  4%      +7.3       71.54        perf-profile.calltrace.cycles-pp.read
>>      24.55 ±  3%     +10.8       35.40        perf-profile.calltrace.cycles-pp.copy_mc_fragile.pmem_do_read.pmem_submit_bio.__submit_bio.__submit_bio_noacct
>>      24.01 ±  5%     +11.8       35.76        perf-profile.calltrace.cycles-pp.pmem_submit_bio.__submit_bio.__submit_bio_noacct.iomap_readahead.read_pages
>>      23.92 ±  5%     +11.8       35.70        perf-profile.calltrace.cycles-pp.pmem_do_read.pmem_submit_bio.__submit_bio.__submit_bio_noacct.iomap_readahead
>>      19.40 ±  4%     +13.5       32.92        perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyout.copy_page_to_iter.filemap_read.xfs_file_buffered_read
>>      19.64 ±  4%     +13.7       33.39        perf-profile.calltrace.cycles-pp.copyout.copy_page_to_iter.filemap_read.xfs_file_buffered_read.xfs_file_read_iter
>>      19.77 ±  4%     +14.0       33.75        perf-profile.calltrace.cycles-pp.copy_page_to_iter.filemap_read.xfs_file_buffered_read.xfs_file_read_iter.new_sync_read
>>       0.00           +36.0       35.98        perf-profile.calltrace.cycles-pp.__submit_bio.__submit_bio_noacct.iomap_readahead.read_pages.filemap_get_pages
>>       0.00           +36.0       35.99        perf-profile.calltrace.cycles-pp.__submit_bio_noacct.iomap_readahead.read_pages.filemap_get_pages.filemap_read
>>       0.00           +36.3       36.34        perf-profile.calltrace.cycles-pp.iomap_readahead.read_pages.filemap_get_pages.filemap_read.xfs_file_buffered_read
>>       0.00           +36.4       36.38        perf-profile.calltrace.cycles-pp.read_pages.filemap_get_pages.filemap_read.xfs_file_buffered_read.xfs_file_read_iter
>>      40.24 ±  5%     -40.2        0.00        perf-profile.children.cycles-pp.page_cache_ra_unbounded
>>      13.34 ± 17%     -13.2        0.15 ± 13%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
>>       9.26 ± 30%      -9.3        0.00        perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
>>       9.34 ± 30%      -9.1        0.22 ±  7%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
>>       8.83 ± 25%      -8.5        0.37 ±  4%  perf-profile.children.cycles-pp.filemap_add_folio
>>       7.78 ± 37%      -7.4        0.39 ±  7%  perf-profile.children.cycles-pp.posix_fadvise64
>>       7.78 ± 37%      -7.4        0.39 ±  7%  perf-profile.children.cycles-pp.__x64_sys_fadvise64
>>       7.78 ± 37%      -7.4        0.39 ±  7%  perf-profile.children.cycles-pp.ksys_fadvise64_64
>>       7.78 ± 37%      -7.4        0.39 ±  7%  perf-profile.children.cycles-pp.generic_fadvise
>>       7.78 ± 37%      -7.4        0.39 ±  7%  perf-profile.children.cycles-pp.invalidate_mapping_pagevec
>>       6.90 ± 34%      -6.8        0.08 ±  8%  perf-profile.children.cycles-pp.folio_add_lru
>>       6.85 ± 34%      -6.8        0.08 ±  8%  perf-profile.children.cycles-pp.__pagevec_lru_add
>>       6.20 ± 40%      -6.0        0.18 ±  9%  perf-profile.children.cycles-pp.release_pages
>>       6.09 ± 41%      -5.9        0.17 ± 10%  perf-profile.children.cycles-pp.__pagevec_release
>>       5.05 ± 14%      -4.5        0.60 ±  2%  perf-profile.children.cycles-pp.folio_alloc
>>       5.01 ± 14%      -4.4        0.60 ±  2%  perf-profile.children.cycles-pp.__alloc_pages
>>       4.88 ± 14%      -4.3        0.56 ±  2%  perf-profile.children.cycles-pp.get_page_from_freelist
>>       4.74 ± 15%      -4.2        0.51 ±  3%  perf-profile.children.cycles-pp.rmqueue
>>       1.93 ± 14%      -1.6        0.29 ±  3%  perf-profile.children.cycles-pp.__filemap_add_folio
>>       1.07 ± 38%      -0.9        0.19 ±  6%  perf-profile.children.cycles-pp.iomap_readpage_iter
>>       0.98 ± 24%      -0.8        0.17 ±  7%  perf-profile.children.cycles-pp.__mem_cgroup_charge
>>       0.81 ±  7%      -0.7        0.11 ±  5%  perf-profile.children.cycles-pp.filemap_get_read_batch
>>       0.75 ± 18%      -0.7        0.08 ±  6%  perf-profile.children.cycles-pp.__list_del_entry_valid
>>       0.69 ± 10%      -0.6        0.04 ± 45%  perf-profile.children.cycles-pp.__pagevec_lru_add_fn
>>       0.75 ± 41%      -0.6        0.20 ± 10%  perf-profile.children.cycles-pp.remove_mapping
>>       0.74 ± 41%      -0.5        0.20 ± 10%  perf-profile.children.cycles-pp.__remove_mapping
>>       0.64 ± 33%      -0.5        0.12 ±  7%  perf-profile.children.cycles-pp.charge_memcg
>>       0.58 ± 20%      -0.5        0.06 ±  7%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
>>       0.58 ±  5%      -0.5        0.07 ±  6%  perf-profile.children.cycles-pp.iomap_read_end_io
>>       0.58 ± 11%      -0.5        0.08 ±  4%  perf-profile.children.cycles-pp.xas_load
>>       0.44 ± 48%      -0.4        0.09 ± 10%  perf-profile.children.cycles-pp.try_charge_memcg
>>       0.32 ± 52%      -0.2        0.08 ± 12%  perf-profile.children.cycles-pp.page_counter_try_charge
>>       0.23 ± 20%      -0.2        0.06 ±  7%  perf-profile.children.cycles-pp.__mod_lruvec_state
>>       0.20 ± 19%      -0.1        0.06 ±  7%  perf-profile.children.cycles-pp.__mod_node_page_state
>>       0.14 ±  6%      -0.1        0.06 ±  8%  perf-profile.children.cycles-pp.kmem_cache_alloc
>>       0.05 ± 74%      +0.0        0.10 ± 11%  perf-profile.children.cycles-pp.generic_file_write_iter
>>       0.01 ±223%      +0.0        0.06 ± 11%  perf-profile.children.cycles-pp.__x64_sys_execve
>>       0.01 ±223%      +0.0        0.06 ± 11%  perf-profile.children.cycles-pp.do_execveat_common
>>       0.01 ±223%      +0.0        0.06 ± 11%  perf-profile.children.cycles-pp.execve
>>       0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.mempool_alloc
>>       0.05 ± 76%      +0.1        0.11 ± 13%  perf-profile.children.cycles-pp.new_sync_write
>>       0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.find_busiest_group
>>       0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.update_sd_lb_stats
>>       0.05 ± 76%      +0.1        0.11 ± 12%  perf-profile.children.cycles-pp.vfs_write
>>       0.05 ± 76%      +0.1        0.11 ± 11%  perf-profile.children.cycles-pp.ksys_write
>>       0.02 ±141%      +0.1        0.08 ±  9%  perf-profile.children.cycles-pp.exc_page_fault
>>       0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.bio_free
>>       0.00            +0.1        0.06 ± 17%  perf-profile.children.cycles-pp.schedule
>>       0.06 ± 76%      +0.1        0.12 ± 11%  perf-profile.children.cycles-pp.write
>>       0.06 ± 11%      +0.1        0.12 ± 46%  perf-profile.children.cycles-pp.__might_resched
>>       0.02 ±141%      +0.1        0.08 ±  7%  perf-profile.children.cycles-pp.asm_exc_page_fault
>>       0.01 ±223%      +0.1        0.07 ±  9%  perf-profile.children.cycles-pp.handle_mm_fault
>>       0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.load_balance
>>       0.00            +0.1        0.07 ± 11%  perf-profile.children.cycles-pp.bio_alloc_bioset
>>       0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.__might_fault
>>       0.00            +0.1        0.07 ± 11%  perf-profile.children.cycles-pp.__handle_mm_fault
>>       0.01 ±223%      +0.1        0.08 ±  9%  perf-profile.children.cycles-pp.do_user_addr_fault
>>       0.00            +0.1        0.07 ±  8%  perf-profile.children.cycles-pp.__kmalloc
>>       0.03 ± 70%      +0.1        0.10 ± 10%  perf-profile.children.cycles-pp.iomap_iter
>>       0.00            +0.1        0.08 ± 12%  perf-profile.children.cycles-pp.__free_pages_ok
>>       0.00            +0.1        0.08 ±  9%  perf-profile.children.cycles-pp.iomap_page_create
>>       0.00            +0.1        0.08 ± 13%  perf-profile.children.cycles-pp.__schedule
>>       0.01 ±223%      +0.1        0.09 ± 11%  perf-profile.children.cycles-pp.xfs_read_iomap_begin
>>       0.00            +0.2        0.16 ± 11%  perf-profile.children.cycles-pp.__cond_resched
>>       0.00            +0.2        0.18 ±  9%  perf-profile.children.cycles-pp.folio_mapped
>>       0.00            +1.0        0.98        perf-profile.children.cycles-pp.page_cache_ra_order
>>      64.15 ±  4%      +7.3       71.45        perf-profile.children.cycles-pp.xfs_file_buffered_read
>>      64.14 ±  4%      +7.3       71.44        perf-profile.children.cycles-pp.filemap_read
>>      64.16 ±  4%      +7.3       71.47        perf-profile.children.cycles-pp.xfs_file_read_iter
>>      64.18 ±  4%      +7.3       71.50        perf-profile.children.cycles-pp.new_sync_read
>>      64.20 ±  4%      +7.3       71.54        perf-profile.children.cycles-pp.vfs_read
>>      64.21 ±  4%      +7.4       71.56        perf-profile.children.cycles-pp.ksys_read
>>      64.23 ±  4%      +7.4       71.60        perf-profile.children.cycles-pp.read
>>      26.03 ±  4%     +10.3       36.34        perf-profile.children.cycles-pp.iomap_readahead
>>      26.04 ±  4%     +10.3       36.39        perf-profile.children.cycles-pp.read_pages
>>      25.55 ±  4%     +10.4       35.98        perf-profile.children.cycles-pp.__submit_bio
>>      25.55 ±  4%     +10.4       35.99        perf-profile.children.cycles-pp.__submit_bio_noacct
>>      24.68 ±  4%     +10.9       35.54        perf-profile.children.cycles-pp.copy_mc_fragile
>>      24.89 ±  4%     +10.9       35.77        perf-profile.children.cycles-pp.pmem_submit_bio
>>      24.80 ±  4%     +10.9       35.70        perf-profile.children.cycles-pp.pmem_do_read
>>      19.64 ±  4%     +13.8       33.39        perf-profile.children.cycles-pp.copyout
>>      19.64 ±  4%     +13.8       33.42        perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
>>      19.78 ±  4%     +14.0       33.77        perf-profile.children.cycles-pp.copy_page_to_iter
>>      13.34 ± 17%     -13.2        0.15 ± 13%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
>>       0.74 ± 18%      -0.7        0.08 ±  6%  perf-profile.self.cycles-pp.__list_del_entry_valid
>>       0.52 ± 11%      -0.5        0.06 ±  6%  perf-profile.self.cycles-pp.xas_load
>>       0.36 ±  3%      -0.3        0.10 ±  6%  perf-profile.self.cycles-pp.filemap_read
>>       0.25 ± 52%      -0.2        0.06 ± 11%  perf-profile.self.cycles-pp.page_counter_try_charge
>>       0.20 ± 19%      -0.1        0.06 ±  7%  perf-profile.self.cycles-pp.__mod_node_page_state
>>       0.17 ± 30%      -0.1        0.07 ±  7%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
>>       0.11 ±  6%      +0.0        0.16 ±  2%  perf-profile.self.cycles-pp.pmem_do_read
>>       0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.kmem_cache_free
>>       0.00            +0.1        0.13 ± 10%  perf-profile.self.cycles-pp.__cond_resched
>>       0.14 ±  6%      +0.2        0.31 ±  2%  perf-profile.self.cycles-pp.rmqueue
>>       0.00            +0.2        0.18 ±  9%  perf-profile.self.cycles-pp.folio_mapped
>>      24.40 ±  4%     +10.8       35.18        perf-profile.self.cycles-pp.copy_mc_fragile
>>      19.38 ±  4%     +13.7       33.04        perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
>>
>>
>> ***************************************************************************************************
>> lkp-csl-2ap4: 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
>> =========================================================================================
>> compiler/cpufreq_governor/kconfig/rootfs/runtime/tbox_group/test/testcase/ucode:
>>   gcc-11/performance/x86_64-rhel-8.3/debian-10.4-x86_64-20200603.cgz/300s/lkp-csl-2ap4/mmap-pread-seq/vm-scalability/0x500320a
>>
>> commit: 
>>   18788cfa23 ("mm: Support arbitrary THP sizes")
>>   793917d997 ("mm/readahead: Add large folio readahead")
>>
>> 18788cfa23696774 793917d997df2e432f3e9ac126e 
>> ---------------- --------------------------- 
>>          %stddev     %change         %stddev
>>              \          |                \  
>>      46.87 ± 10%     -97.9%       0.96 ±  4%  vm-scalability.free_time
>>     191595 ±  2%    +241.0%     653394 ± 13%  vm-scalability.median
>>       0.19 ± 20%      +1.2        1.37 ± 20%  vm-scalability.stddev%
>>   36786240 ±  2%    +241.0%  1.255e+08 ± 13%  vm-scalability.throughput
>>     180.40           -77.2%      41.08 ± 12%  vm-scalability.time.elapsed_time
>>     180.40           -77.2%      41.08 ± 12%  vm-scalability.time.elapsed_time.max
>>      84631           -66.5%      28382 ± 21%  vm-scalability.time.involuntary_context_switches
>>   31087438 ±  5%     -46.7%   16568180 ± 28%  vm-scalability.time.major_page_faults
>>  1.614e+08           -46.5%   86356129 ±  7%  vm-scalability.time.minor_page_faults
>>      18216            -3.2%      17637        vm-scalability.time.percent_of_cpu_this_job_got
>>      28597           -86.4%       3901 ± 19%  vm-scalability.time.system_time
>>       4268           -21.8%       3336 ±  2%  vm-scalability.time.user_time
>>   46509474 ±  8%     -45.0%   25597276 ± 33%  vm-scalability.time.voluntary_context_switches
>>     227.97           -60.7%      89.66 ±  3%  uptime.boot
>>   1.48e+09 ±  5%     -45.4%  8.087e+08 ±  9%  cpuidle..time
>>   44196685 ±  8%     -40.6%   26236295 ± 32%  cpuidle..usage
>>    4036916 ± 40%     -82.9%     691729 ±  7%  numa-numastat.node2.local_node
>>    4117121 ± 39%     -81.4%     766207 ±  7%  numa-numastat.node2.numa_hit
>>    1861867 ± 84%     -62.8%     692093 ±  6%  numa-numastat.node3.local_node
>>    1942475 ± 80%     -59.9%     778947 ±  5%  numa-numastat.node3.numa_hit
>>       3.67 ±  4%      +4.2        7.85 ±  4%  mpstat.cpu.all.idle%
>>       0.88 ± 17%      +1.0        1.90 ± 35%  mpstat.cpu.all.iowait%
>>       0.88            +0.2        1.06        mpstat.cpu.all.irq%
>>       0.14 ± 10%      +0.1        0.21 ± 11%  mpstat.cpu.all.soft%
>>      82.08           -34.6       47.48 ±  8%  mpstat.cpu.all.sys%
>>      12.35           +29.2       41.51 ± 10%  mpstat.cpu.all.usr%
>>       4.00          +175.0%      11.00 ±  7%  vmstat.cpu.id
>>      81.67           -44.1%      45.67 ±  8%  vmstat.cpu.sy
>>      12.00          +227.8%      39.33 ± 10%  vmstat.cpu.us
>>   16429426           -22.0%   12818057        vmstat.memory.cache
>>     182.33           -10.4%     163.33        vmstat.procs.r
>>     509931 ±  9%    +119.5%    1119546 ± 25%  vmstat.system.cs
>>    2966302 ±  8%     -89.8%     303438 ± 23%  meminfo.Active
>>      20863 ± 33%     -74.0%       5428        meminfo.Active(anon)
>>    2945438 ±  8%     -89.9%     298009 ± 24%  meminfo.Active(file)
>>     180004 ±  2%     -49.7%      90484 ±  5%  meminfo.AnonHugePages
>>   16278300           -20.6%   12927130        meminfo.Cached
>>   24189299           -18.6%   19701239        meminfo.Memused
>>    5160427           -23.6%    3940730        meminfo.PageTables
>>     153951 ±  2%     -26.3%     113466        meminfo.Shmem
>>   24513374           -14.7%   20907068        meminfo.max_used_kB
>>    2755746 ±  8%     -72.3%     762359 ± 59%  turbostat.C1
>>    4033941 ±  8%     -58.5%    1674613 ± 32%  turbostat.C1E
>>       2.54 ±  7%      +2.8        5.35 ±  4%  turbostat.C1E%
>>       0.22 ± 40%      +1.3        1.53 ± 95%  turbostat.C6%
>>       2.82 ±  4%    +139.6%       6.76 ± 17%  turbostat.CPU%c1
>>       0.07 ± 11%    +304.8%       0.28 ±  3%  turbostat.CPU%c6
>>       0.05         +9800.0%       4.95 ±136%  turbostat.IPC
>>   79897140           -76.2%   19045918 ± 13%  turbostat.IRQ
>>   37324544 ±  8%     -36.7%   23632422 ± 33%  turbostat.POLL
>>       1.37 ±  9%      +1.4        2.78 ± 31%  turbostat.POLL%
>>      51.33            +2.6%      52.67        turbostat.PkgTmp
>>     254.83           +22.1%     311.09 ±  2%  turbostat.PkgWatt
>>     137924 ±  9%     -49.1%      70157 ± 20%  numa-meminfo.node0.AnonHugePages
>>     355569 ±  8%    +649.5%    2665047 ±108%  numa-meminfo.node0.Inactive
>>    1305569 ±  2%     -23.2%    1003009        numa-meminfo.node0.PageTables
>>    1287418 ±  2%     -21.9%    1005960        numa-meminfo.node1.PageTables
>>    1758487 ± 54%     -92.5%     132350 ± 85%  numa-meminfo.node2.Active
>>    1757440 ± 54%     -92.5%     131820 ± 86%  numa-meminfo.node2.Active(file)
>>      27560 ± 45%     +38.2%      38100 ± 13%  numa-meminfo.node2.AnonPages
>>    8204369 ± 46%     -64.0%    2956327 ± 76%  numa-meminfo.node2.FilePages
>>      37157 ± 20%     -38.1%      22997 ± 40%  numa-meminfo.node2.KReclaimable
>>   10086474 ± 38%     -54.6%    4583950 ± 48%  numa-meminfo.node2.MemUsed
>>    1265170           -21.8%     988848        numa-meminfo.node2.PageTables
>>      37157 ± 20%     -38.1%      22997 ± 40%  numa-meminfo.node2.SReclaimable
>>      78887 ±141%    -100.0%      12.00 ±118%  numa-meminfo.node2.Unevictable
>>      14660 ± 37%     -99.2%     124.33 ± 24%  numa-meminfo.node3.Active(anon)
>>      28679 ±119%     -95.6%       1269 ±  5%  numa-meminfo.node3.AnonPages
>>      76530 ± 69%     -96.5%       2646 ± 18%  numa-meminfo.node3.AnonPages.max
>>      51139 ± 71%     -89.1%       5573 ± 83%  numa-meminfo.node3.Inactive(anon)
>>    1286708 ±  2%     -22.9%     991696        numa-meminfo.node3.PageTables
>>      37154 ± 10%     -91.5%       3148 ±129%  numa-meminfo.node3.Shmem
>>     323291           -23.7%     246709        numa-vmstat.node0.nr_page_table_pages
>>     318784 ±  2%     -22.3%     247722 ±  3%  numa-vmstat.node1.nr_page_table_pages
>>     427728 ± 53%     -92.1%      33763 ±101%  numa-vmstat.node2.nr_active_file
>>       6907 ± 45%     +37.8%       9516 ± 13%  numa-vmstat.node2.nr_anon_pages
>>     313337           -22.3%     243536 ±  2%  numa-vmstat.node2.nr_page_table_pages
>>       9253 ± 20%     -37.7%       5769 ± 40%  numa-vmstat.node2.nr_slab_reclaimable
>>      19721 ±141%    -100.0%       3.00 ±118%  numa-vmstat.node2.nr_unevictable
>>     427713 ± 53%     -92.1%      33773 ±101%  numa-vmstat.node2.nr_zone_active_file
>>      19721 ±141%    -100.0%       3.00 ±118%  numa-vmstat.node2.nr_zone_unevictable
>>    4117235 ± 39%     -81.4%     765901 ±  7%  numa-vmstat.node2.numa_hit
>>    4037029 ± 40%     -82.9%     691422 ±  7%  numa-vmstat.node2.numa_local
>>       3813 ± 37%     -99.2%      30.67 ± 24%  numa-vmstat.node3.nr_active_anon
>>       7118 ±119%     -95.5%     319.67 ±  4%  numa-vmstat.node3.nr_anon_pages
>>      12533 ± 71%     -88.9%       1394 ± 82%  numa-vmstat.node3.nr_inactive_anon
>>     318650 ±  2%     -23.4%     244204 ±  2%  numa-vmstat.node3.nr_page_table_pages
>>       9236 ± 11%     -91.5%     786.67 ±129%  numa-vmstat.node3.nr_shmem
>>       3813 ± 37%     -99.2%      30.67 ± 24%  numa-vmstat.node3.nr_zone_active_anon
>>      12533 ± 71%     -88.9%       1394 ± 82%  numa-vmstat.node3.nr_zone_inactive_anon
>>    1942945 ± 80%     -59.9%     779066 ±  5%  numa-vmstat.node3.numa_hit
>>    1862337 ± 84%     -62.8%     692212 ±  6%  numa-vmstat.node3.numa_local
>>       5229 ± 31%     -74.1%       1356        proc-vmstat.nr_active_anon
>>     734568 ±  8%     -86.7%      98029 ± 20%  proc-vmstat.nr_active_file
>>      78115            -2.6%      76120        proc-vmstat.nr_anon_pages
>>    4067457           -19.8%    3262058        proc-vmstat.nr_file_pages
>>   43384997            +2.5%   44462783        proc-vmstat.nr_free_pages
>>     111285            -7.1%     103410        proc-vmstat.nr_inactive_anon
>>    2728035            -5.8%    2569881        proc-vmstat.nr_inactive_file
>>    2741812            -4.6%    2616807        proc-vmstat.nr_mapped
>>    1288800 ±  2%     -22.7%     996178        proc-vmstat.nr_page_table_pages
>>      38433 ±  2%     -26.2%      28368        proc-vmstat.nr_shmem
>>      41758            -6.1%      39207        proc-vmstat.nr_slab_reclaimable
>>      79625            -2.7%      77448        proc-vmstat.nr_slab_unreclaimable
>>       5229 ± 31%     -74.1%       1356        proc-vmstat.nr_zone_active_anon
>>     734568 ±  8%     -86.7%      98029 ± 20%  proc-vmstat.nr_zone_active_file
>>     111285            -7.1%     103410        proc-vmstat.nr_zone_inactive_anon
>>    2728035            -5.8%    2569881        proc-vmstat.nr_zone_inactive_file
>>      29202 ± 11%     -29.6%      20544 ± 20%  proc-vmstat.numa_hint_faults
>>    8906395           -63.8%    3221607 ±  2%  proc-vmstat.numa_hit
>>    8647246           -65.8%    2961022 ±  2%  proc-vmstat.numa_local
>>      33133 ±  4%     -79.5%       6790 ± 29%  proc-vmstat.numa_pages_migrated
>>     115948 ±  9%     -56.1%      50895 ± 29%  proc-vmstat.numa_pte_updates
>>    8910054            -1.5%    8776609        proc-vmstat.pgalloc_normal
>>  2.246e+08           -46.6%  1.199e+08 ± 13%  proc-vmstat.pgfault
>>    8615822            -1.7%    8473592        proc-vmstat.pgfree
>>       1799 ± 10%     -99.8%       4.00 ± 35%  proc-vmstat.pgmajfault
>>      33133 ±  4%     -79.5%       6790 ± 29%  proc-vmstat.pgmigrate_success
>>       2108            -1.3%       2081        proc-vmstat.pgpgout
>>      53952           -63.2%      19870 ±  4%  proc-vmstat.pgreuse
>>      68595 ± 40%     -99.9%      67.08 ±141%  sched_debug.cfs_rq:/.MIN_vruntime.avg
>>    5806823 ± 32%     -99.9%       7023 ±141%  sched_debug.cfs_rq:/.MIN_vruntime.max
>>     620191 ± 35%     -99.9%     655.14 ±141%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
>>       0.65 ± 15%     -89.8%       0.07 ±  9%  sched_debug.cfs_rq:/.h_nr_running.avg
>>       1.64 ±  6%     -39.0%       1.00        sched_debug.cfs_rq:/.h_nr_running.max
>>       0.22 ±  5%     +12.5%       0.25 ±  4%  sched_debug.cfs_rq:/.h_nr_running.stddev
>>       5552 ± 12%     -69.5%       1695 ±  5%  sched_debug.cfs_rq:/.load.avg
>>      13.57 ± 19%     +34.1%      18.20 ±  2%  sched_debug.cfs_rq:/.load_avg.avg
>>      66.62 ± 42%     +62.5%     108.26 ±  2%  sched_debug.cfs_rq:/.load_avg.stddev
>>      68595 ± 40%     -99.9%      67.08 ±141%  sched_debug.cfs_rq:/.max_vruntime.avg
>>    5806823 ± 32%     -99.9%       7023 ±141%  sched_debug.cfs_rq:/.max_vruntime.max
>>     620191 ± 35%     -99.9%     655.14 ±141%  sched_debug.cfs_rq:/.max_vruntime.stddev
>>   13104524 ± 19%     -99.9%      15496 ± 30%  sched_debug.cfs_rq:/.min_vruntime.avg
>>   13419952 ± 18%     -99.7%      38089 ± 18%  sched_debug.cfs_rq:/.min_vruntime.max
>>   11781278 ± 16%    -100.0%       4704 ± 36%  sched_debug.cfs_rq:/.min_vruntime.min
>>     239246 ± 22%     -97.9%       5113 ± 11%  sched_debug.cfs_rq:/.min_vruntime.stddev
>>       0.64 ± 15%     -89.6%       0.07 ±  9%  sched_debug.cfs_rq:/.nr_running.avg
>>       0.20 ± 11%     +26.5%       0.25 ±  4%  sched_debug.cfs_rq:/.nr_running.stddev
>>       3.29 ± 17%     +58.9%       5.23 ±  3%  sched_debug.cfs_rq:/.removed.load_avg.avg
>>     363.44 ± 29%    +175.1%       1000 ±  3%  sched_debug.cfs_rq:/.removed.load_avg.max
>>      33.82 ± 22%    +113.2%      72.10 ±  3%  sched_debug.cfs_rq:/.removed.load_avg.stddev
>>     180.33 ± 24%     +79.1%     323.00 ± 36%  sched_debug.cfs_rq:/.removed.runnable_avg.max
>>      13.81 ± 30%     +68.6%      23.29 ± 36%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
>>     180.33 ± 24%     +79.1%     323.00 ± 36%  sched_debug.cfs_rq:/.removed.util_avg.max
>>      13.81 ± 30%     +68.6%      23.29 ± 36%  sched_debug.cfs_rq:/.removed.util_avg.stddev
>>     603.68 ± 16%     -78.0%     132.63        sched_debug.cfs_rq:/.runnable_avg.avg
>>      66.03 ± 51%    -100.0%       0.00        sched_debug.cfs_rq:/.runnable_avg.min
>>     165.10 ± 13%     +65.5%     273.26 ±  2%  sched_debug.cfs_rq:/.runnable_avg.stddev
>>    -173513           -93.7%     -10949        sched_debug.cfs_rq:/.spread0.avg
>>     145970 ± 52%     -92.0%      11642 ± 76%  sched_debug.cfs_rq:/.spread0.max
>>   -1500915           -98.6%     -21741        sched_debug.cfs_rq:/.spread0.min
>>     240582 ± 22%     -97.9%       5113 ± 11%  sched_debug.cfs_rq:/.spread0.stddev
>>     597.31 ± 16%     -77.8%     132.59        sched_debug.cfs_rq:/.util_avg.avg
>>      65.36 ± 51%    -100.0%       0.00        sched_debug.cfs_rq:/.util_avg.min
>>     159.11 ± 15%     +71.7%     273.19 ±  2%  sched_debug.cfs_rq:/.util_avg.stddev
>>     527.10 ± 16%     -97.8%      11.48 ±  5%  sched_debug.cfs_rq:/.util_est_enqueued.avg
>>       1208 ± 13%     -31.5%     828.00        sched_debug.cfs_rq:/.util_est_enqueued.max
>>     144.31 ± 11%     -45.9%      78.03        sched_debug.cfs_rq:/.util_est_enqueued.stddev
>>     339313 ± 25%    +142.8%     823971        sched_debug.cpu.avg_idle.avg
>>     935254 ±  7%     +21.5%    1136425 ±  8%  sched_debug.cpu.avg_idle.max
>>      22494 ± 99%     -93.8%       1391 ± 20%  sched_debug.cpu.avg_idle.min
>>     146018 ± 28%     +77.2%     258706 ±  2%  sched_debug.cpu.avg_idle.stddev
>>     126960 ± 13%     -62.4%      47674 ±  2%  sched_debug.cpu.clock.avg
>>     127006 ± 13%     -62.5%      47684 ±  2%  sched_debug.cpu.clock.max
>>     126910 ± 13%     -62.4%      47665 ±  2%  sched_debug.cpu.clock.min
>>      26.99 ± 13%     -77.9%       5.98 ±  2%  sched_debug.cpu.clock.stddev
>>     126018 ± 13%     -62.3%      47544 ±  2%  sched_debug.cpu.clock_task.avg
>>     126163 ± 13%     -62.2%      47659 ±  2%  sched_debug.cpu.clock_task.max
>>     118809 ± 11%     -67.8%      38275 ±  2%  sched_debug.cpu.clock_task.min
>>       4965 ± 16%     -93.4%     327.73 ± 17%  sched_debug.cpu.curr->pid.avg
>>       8887 ±  2%     -40.1%       5324        sched_debug.cpu.curr->pid.max
>>       0.00 ± 14%     -73.5%       0.00 ±  4%  sched_debug.cpu.next_balance.stddev
>>       0.64 ± 15%     -89.5%       0.07 ± 16%  sched_debug.cpu.nr_running.avg
>>       1.64 ±  6%     -39.0%       1.00        sched_debug.cpu.nr_running.max
>>     262669 ±  6%     -99.1%       2383 ±  2%  sched_debug.cpu.nr_switches.avg
>>     339518 ±  7%     -94.9%      17226 ± 23%  sched_debug.cpu.nr_switches.max
>>     133856 ± 14%     -99.5%     608.33 ± 23%  sched_debug.cpu.nr_switches.min
>>      73154 ± 15%     -96.4%       2659 ± 10%  sched_debug.cpu.nr_switches.stddev
>>   2.33e+09           +12.3%  2.617e+09 ±  5%  sched_debug.cpu.nr_uninterruptible.avg
>>     126908 ± 13%     -62.4%      47668 ±  2%  sched_debug.cpu_clk
>>     125894 ± 13%     -62.9%      46652 ±  2%  sched_debug.ktime
>>     129346 ± 10%     -62.8%      48145 ±  2%  sched_debug.sched_clk
>>      12.39 ±  8%     -57.1%       5.31        perf-stat.i.MPKI
>>  3.154e+10 ±  2%    +307.2%  1.284e+11 ± 11%  perf-stat.i.branch-instructions
>>       0.16 ±  4%      -0.1        0.05 ± 14%  perf-stat.i.branch-miss-rate%
>>   39015811 ±  4%     +46.0%   56949389 ± 11%  perf-stat.i.branch-misses
>>      27.47           -15.6       11.85 ±  9%  perf-stat.i.cache-miss-rate%
>>  1.869e+08           +27.5%  2.382e+08 ±  2%  perf-stat.i.cache-misses
>>  6.927e+08          +197.5%   2.06e+09 ±  7%  perf-stat.i.cache-references
>>     532481 ±  9%    +129.5%    1221898 ± 26%  perf-stat.i.context-switches
>>      11.00 ± 10%     -86.7%       1.46 ± 11%  perf-stat.i.cpi
>>  5.805e+11            -1.8%  5.703e+11        perf-stat.i.cpu-cycles
>>       1227 ± 11%    +159.7%       3188 ± 26%  perf-stat.i.cpu-migrations
>>       3324           -27.0%       2426 ±  2%  perf-stat.i.cycles-between-cache-misses
>>       0.02 ±  2%      -0.0        0.01 ±  7%  perf-stat.i.dTLB-load-miss-rate%
>>    6130936          +109.1%   12821616 ±  2%  perf-stat.i.dTLB-load-misses
>>  2.569e+10 ±  2%    +299.8%  1.027e+11 ± 11%  perf-stat.i.dTLB-loads
>>       0.02 ±  3%      -0.0        0.02 ±  7%  perf-stat.i.dTLB-store-miss-rate%
>>    1267107 ±  3%    +135.4%    2983372 ±  3%  perf-stat.i.dTLB-store-misses
>>  4.635e+09 ±  2%    +270.6%  1.718e+10 ± 10%  perf-stat.i.dTLB-stores
>>    6815222 ±  3%     +53.9%   10485254 ± 16%  perf-stat.i.iTLB-load-misses
>>    9.9e+10 ±  2%    +299.0%   3.95e+11 ± 10%  perf-stat.i.instructions
>>      13347          +197.8%      39746 ± 28%  perf-stat.i.instructions-per-iTLB-miss
>>       0.17 ±  2%    +303.5%       0.70 ± 11%  perf-stat.i.ipc
>>     177593 ±  6%    +123.8%     397415 ± 20%  perf-stat.i.major-faults
>>       3.02            -1.7%       2.97        perf-stat.i.metric.GHz
>>     325.59 ±  2%    +300.2%       1303 ± 11%  perf-stat.i.metric.M/sec
>>     926874 ±  2%    +129.5%    2126907 ±  3%  perf-stat.i.minor-faults
>>      95.92            -1.3       94.58        perf-stat.i.node-load-miss-rate%
>>    1082968 ±  3%     +42.9%    1547522 ±  4%  perf-stat.i.node-loads
>>      98.43            -1.8       96.63        perf-stat.i.node-store-miss-rate%
>>     135314 ± 21%    +108.5%     282144 ± 23%  perf-stat.i.node-stores
>>    1104467 ±  3%    +128.6%    2524323 ±  3%  perf-stat.i.page-faults
>>       7.13           -26.5%       5.24 ±  3%  perf-stat.overall.MPKI
>>       0.12 ±  3%      -0.1        0.05 ± 20%  perf-stat.overall.branch-miss-rate%
>>      27.42           -15.8       11.66 ±  9%  perf-stat.overall.cache-miss-rate%
>>       6.00           -75.6%       1.46 ± 11%  perf-stat.overall.cpi
>>       3065           -22.0%       2389 ±  2%  perf-stat.overall.cycles-between-cache-misses
>>       0.02            -0.0        0.01 ±  8%  perf-stat.overall.dTLB-load-miss-rate%
>>       0.03            -0.0        0.02 ±  7%  perf-stat.overall.dTLB-store-miss-rate%
>>      14472          +172.7%      39462 ± 28%  perf-stat.overall.instructions-per-iTLB-miss
>>       0.17          +316.0%       0.69 ± 12%  perf-stat.overall.ipc
>>      98.95            -1.7       97.30        perf-stat.overall.node-store-miss-rate%
>>       3605            -8.3%       3305        perf-stat.overall.path-length
>>  3.058e+10          +308.8%   1.25e+11 ± 10%  perf-stat.ps.branch-instructions
>>   37933954 ±  4%     +46.3%   55497860 ± 11%  perf-stat.ps.branch-misses
>>   1.88e+08           +23.7%  2.325e+08 ±  2%  perf-stat.ps.cache-misses
>>  6.856e+08          +192.8%  2.008e+09 ±  7%  perf-stat.ps.cache-references
>>     514435 ±  8%    +131.2%    1189347 ± 26%  perf-stat.ps.context-switches
>>     190639            -1.9%     187097        perf-stat.ps.cpu-clock
>>  5.764e+11            -3.7%  5.553e+11        perf-stat.ps.cpu-cycles
>>       1188 ± 11%    +162.8%       3124 ± 26%  perf-stat.ps.cpu-migrations
>>    6014890          +107.4%   12475043 ±  2%  perf-stat.ps.dTLB-load-misses
>>  2.494e+10          +300.9%  9.998e+10 ± 10%  perf-stat.ps.dTLB-loads
>>    1226138          +136.8%    2902969 ±  2%  perf-stat.ps.dTLB-store-misses
>>  4.503e+09          +271.6%  1.673e+10 ±  9%  perf-stat.ps.dTLB-stores
>>    6644280 ±  2%     +53.6%   10202828 ± 16%  perf-stat.ps.iTLB-load-misses
>>   9.61e+10          +300.1%  3.845e+11 ± 10%  perf-stat.ps.instructions
>>     171562 ±  6%    +125.4%     386762 ± 21%  perf-stat.ps.major-faults
>>     895259          +131.2%    2069711 ±  3%  perf-stat.ps.minor-faults
>>    1077758 ±  2%     +39.9%    1508290 ±  4%  perf-stat.ps.node-loads
>>   12361604 ±  3%     -15.9%   10395011 ± 15%  perf-stat.ps.node-store-misses
>>     131225 ± 22%    +109.1%     274420 ± 23%  perf-stat.ps.node-stores
>>    1066822 ±  2%    +130.3%    2456474 ±  2%  perf-stat.ps.page-faults
>>     190639            -1.9%     187097        perf-stat.ps.task-clock
>>  1.742e+13            -8.3%  1.597e+13        perf-stat.total.instructions
>>      99.45           -99.4        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.munmap
>>      99.45           -99.4        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.munmap
>>      99.45           -99.4        0.00        perf-profile.calltrace.cycles-pp.__do_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>      99.45           -99.4        0.00        perf-profile.calltrace.cycles-pp.unmap_region.__do_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
>>      99.45           -99.4        0.00        perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.munmap
>>      99.45           -99.4        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.munmap
>>      99.45           -99.4        0.00        perf-profile.calltrace.cycles-pp.munmap
>>      99.44           -99.4        0.00        perf-profile.calltrace.cycles-pp.unmap_vmas.unmap_region.__do_munmap.__vm_munmap.__x64_sys_munmap
>>      99.44           -99.4        0.00        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.unmap_region.__do_munmap.__vm_munmap
>>      99.44           -99.2        0.20 ±141%  perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region.__do_munmap
>>      99.42           -99.2        0.20 ±141%  perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region
>>      80.45           -80.4        0.00        perf-profile.calltrace.cycles-pp.folio_mark_accessed.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
>>      50.41 ±  2%     -50.4        0.00        perf-profile.calltrace.cycles-pp.workingset_activation.folio_mark_accessed.zap_pte_range.zap_pmd_range.unmap_page_range
>>      49.47 ±  2%     -49.5        0.00        perf-profile.calltrace.cycles-pp.workingset_age_nonresident.workingset_activation.folio_mark_accessed.zap_pte_range.zap_pmd_range
>>      25.91 ±  3%     -25.9        0.00        perf-profile.calltrace.cycles-pp.pagevec_lru_move_fn.folio_mark_accessed.zap_pte_range.zap_pmd_range.unmap_page_range
>>      24.60 ±  3%     -24.6        0.00        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.pagevec_lru_move_fn.folio_mark_accessed.zap_pte_range.zap_pmd_range
>>      24.59 ±  3%     -24.6        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.pagevec_lru_move_fn.folio_mark_accessed.zap_pte_range
>>      24.53 ±  3%     -24.5        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.pagevec_lru_move_fn.folio_mark_accessed
>>       8.21 ±  4%      -8.2        0.00        perf-profile.calltrace.cycles-pp.tlb_flush_mmu.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
>>       6.14 ±  4%      -6.1        0.00        perf-profile.calltrace.cycles-pp.release_pages.tlb_flush_mmu.zap_pte_range.zap_pmd_range.unmap_page_range
>>       5.40 ±  4%      -5.4        0.00        perf-profile.calltrace.cycles-pp.page_remove_rmap.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
>>       0.00            +0.7        0.69 ± 13%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
>>       0.00            +0.7        0.69 ± 13%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
>>       0.00            +0.7        0.69 ± 13%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
>>       0.00            +0.7        0.69 ± 13%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
>>       0.00            +0.7        0.69 ± 13%  perf-profile.calltrace.cycles-pp.task_state.proc_pid_status.proc_single_show.seq_read_iter.seq_read
>>       0.00            +0.9        0.89 ± 25%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
>>       0.00            +0.9        0.89 ± 25%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
>>       0.00            +0.9        0.92 ± 33%  perf-profile.calltrace.cycles-pp.io_serial_out.uart_console_write.serial8250_console_write.call_console_drivers.console_unlock
>>       0.00            +0.9        0.92 ± 33%  perf-profile.calltrace.cycles-pp._free_event.perf_event_release_kernel.perf_release.__fput.task_work_run
>>       0.00            +0.9        0.92 ± 33%  perf-profile.calltrace.cycles-pp.fork
>>       0.00            +1.0        1.01 ± 15%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
>>       0.00            +1.0        1.01 ± 15%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
>>       0.00            +1.1        1.08 ± 39%  perf-profile.calltrace.cycles-pp.delay_tsc.wait_for_xmitr.serial8250_console_putchar.uart_console_write.serial8250_console_write
>>       0.00            +1.1        1.09 ± 46%  perf-profile.calltrace.cycles-pp.__close
>>       0.00            +1.2        1.17 ± 34%  perf-profile.calltrace.cycles-pp.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common
>>       0.00            +1.2        1.21 ± 35%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyin.copy_page_from_iter_atomic.generic_perform_write.__generic_file_write_iter
>>       0.00            +1.2        1.21 ± 35%  perf-profile.calltrace.cycles-pp.copy_page_from_iter_atomic.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.new_sync_write
>>       0.00            +1.2        1.21 ± 35%  perf-profile.calltrace.cycles-pp.copyin.copy_page_from_iter_atomic.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
>>       0.00            +1.2        1.24 ± 69%  perf-profile.calltrace.cycles-pp.__fput.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
>>       0.00            +1.3        1.25 ±  4%  perf-profile.calltrace.cycles-pp.sys_imageblit.drm_fbdev_fb_imageblit.bit_putcs.fbcon_putcs.fbcon_redraw
>>       0.00            +1.3        1.25 ±  4%  perf-profile.calltrace.cycles-pp.con_scroll.lf.vt_console_print.call_console_drivers.console_unlock
>>       0.00            +1.3        1.25 ±  4%  perf-profile.calltrace.cycles-pp.vt_console_print.call_console_drivers.console_unlock.vprintk_emit.devkmsg_emit
>>       0.00            +1.3        1.25 ±  4%  perf-profile.calltrace.cycles-pp.lf.vt_console_print.call_console_drivers.console_unlock.vprintk_emit
>>       0.00            +1.3        1.25 ±  4%  perf-profile.calltrace.cycles-pp.fbcon_scroll.con_scroll.lf.vt_console_print.call_console_drivers
>>       0.00            +1.3        1.25 ±  4%  perf-profile.calltrace.cycles-pp.fbcon_redraw.fbcon_scroll.con_scroll.lf.vt_console_print
>>       0.00            +1.3        1.25 ±  4%  perf-profile.calltrace.cycles-pp.fbcon_putcs.fbcon_redraw.fbcon_scroll.con_scroll.lf
>>       0.00            +1.3        1.25 ±  4%  perf-profile.calltrace.cycles-pp.bit_putcs.fbcon_putcs.fbcon_redraw.fbcon_scroll.con_scroll
>>       0.00            +1.3        1.25 ±  4%  perf-profile.calltrace.cycles-pp.drm_fbdev_fb_imageblit.bit_putcs.fbcon_putcs.fbcon_redraw.fbcon_scroll
>>       0.00            +1.3        1.27 ± 44%  perf-profile.calltrace.cycles-pp.seq_read_iter.proc_reg_read_iter.new_sync_read.vfs_read.ksys_read
>>       0.00            +1.3        1.27 ± 44%  perf-profile.calltrace.cycles-pp.proc_reg_read_iter.new_sync_read.vfs_read.ksys_read.do_syscall_64
>>       0.00            +1.3        1.28 ± 20%  perf-profile.calltrace.cycles-pp.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve
>>       0.00            +1.3        1.28 ± 20%  perf-profile.calltrace.cycles-pp.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
>>       0.00            +1.4        1.38 ± 76%  perf-profile.calltrace.cycles-pp.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
>>       0.00            +1.5        1.50 ± 14%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
>>       0.00            +1.5        1.50 ± 14%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
>>       0.00            +1.6        1.55 ± 41%  perf-profile.calltrace.cycles-pp.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>       0.00            +1.6        1.64 ± 45%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>       0.00            +1.6        1.64 ± 45%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>       0.00            +1.6        1.64 ± 45%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>       0.00            +1.7        1.68 ± 19%  perf-profile.calltrace.cycles-pp.fnmatch
>>       0.00            +1.7        1.68 ± 46%  perf-profile.calltrace.cycles-pp.new_sync_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>       0.00            +1.7        1.69 ± 49%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execve
>>       0.00            +1.7        1.69 ± 49%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
>>       0.00            +1.7        1.69 ± 49%  perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
>>       0.00            +1.7        1.69 ± 49%  perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
>>       0.00            +1.7        1.69 ± 49%  perf-profile.calltrace.cycles-pp.execve
>>       0.00            +1.7        1.71 ± 65%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe._dl_catch_error
>>       0.00            +1.7        1.71 ± 65%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe._dl_catch_error
>>       0.00            +1.9        1.88 ± 26%  perf-profile.calltrace.cycles-pp.proc_pid_status.proc_single_show.seq_read_iter.seq_read.vfs_read
>>       0.00            +1.9        1.88 ± 26%  perf-profile.calltrace.cycles-pp.proc_single_show.seq_read_iter.seq_read.vfs_read.ksys_read
>>       0.00            +2.1        2.10 ± 29%  perf-profile.calltrace.cycles-pp.seq_read_iter.seq_read.vfs_read.ksys_read.do_syscall_64
>>       0.00            +2.1        2.10 ± 29%  perf-profile.calltrace.cycles-pp.seq_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>       0.00            +2.2        2.23 ± 46%  perf-profile.calltrace.cycles-pp.smp_call_function_single.event_function_call.perf_event_release_kernel.perf_release.__fput
>>       0.00            +2.3        2.30 ± 57%  perf-profile.calltrace.cycles-pp.update_sg_lb_stats.update_sd_lb_stats.find_busiest_group.load_balance.newidle_balance
>>       0.00            +2.3        2.30 ± 57%  perf-profile.calltrace.cycles-pp.find_busiest_group.load_balance.newidle_balance.pick_next_task_fair.__schedule
>>       0.00            +2.3        2.30 ± 57%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.find_busiest_group.load_balance.newidle_balance.pick_next_task_fair
>>       0.00            +2.3        2.33 ±103%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>       0.00            +2.4        2.43 ± 40%  perf-profile.calltrace.cycles-pp.event_function_call.perf_event_release_kernel.perf_release.__fput.task_work_run
>>       0.00            +2.6        2.60 ± 76%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
>>       0.00            +2.6        2.60 ± 76%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>       0.00            +2.7        2.67 ± 16%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
>>       0.00            +2.7        2.67 ± 16%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
>>       0.00            +2.7        2.69 ± 59%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe._dl_catch_error
>>       0.00            +2.7        2.69 ± 59%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe._dl_catch_error
>>       0.00            +2.9        2.93 ± 57%  perf-profile.calltrace.cycles-pp._dl_catch_error
>>       0.00            +3.7        3.66 ± 49%  perf-profile.calltrace.cycles-pp.generic_file_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
>>       0.00            +3.7        3.66 ± 49%  perf-profile.calltrace.cycles-pp.__generic_file_write_iter.generic_file_write_iter.new_sync_write.vfs_write.ksys_write
>>       0.00            +3.7        3.66 ± 49%  perf-profile.calltrace.cycles-pp.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.new_sync_write.vfs_write
>>       0.00            +3.7        3.67 ± 56%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>       0.00            +3.7        3.67 ± 56%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
>>       0.00            +3.7        3.68 ± 27%  perf-profile.calltrace.cycles-pp.perf_release.__fput.task_work_run.do_exit.do_group_exit
>>       0.00            +3.7        3.68 ± 27%  perf-profile.calltrace.cycles-pp.perf_event_release_kernel.perf_release.__fput.task_work_run.do_exit
>>       0.00            +3.8        3.78 ± 17%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
>>       0.00            +3.8        3.78 ± 17%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>>       0.00            +3.8        3.78 ± 17%  perf-profile.calltrace.cycles-pp.read
>>       0.00            +3.8        3.78 ± 17%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>>       0.00            +3.8        3.78 ± 17%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>>       0.00            +4.2        4.22 ± 34%  perf-profile.calltrace.cycles-pp.task_work_run.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
>>       0.00            +4.2        4.22 ± 34%  perf-profile.calltrace.cycles-pp.__fput.task_work_run.do_exit.do_group_exit.get_signal
>>       0.00            +4.6        4.58 ± 34%  perf-profile.calltrace.cycles-pp.do_group_exit.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare
>>       0.00            +4.6        4.58 ± 34%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop
>>       0.00            +6.7        6.66 ± 45%  perf-profile.calltrace.cycles-pp.io_serial_in.wait_for_xmitr.serial8250_console_putchar.uart_console_write.serial8250_console_write
>>       0.00            +7.7        7.74 ± 43%  perf-profile.calltrace.cycles-pp.wait_for_xmitr.serial8250_console_putchar.uart_console_write.serial8250_console_write.call_console_drivers
>>       0.00            +7.7        7.74 ± 43%  perf-profile.calltrace.cycles-pp.serial8250_console_putchar.uart_console_write.serial8250_console_write.call_console_drivers.console_unlock
>>       0.00            +8.0        8.04 ± 75%  perf-profile.calltrace.cycles-pp.memcpy_toio.drm_fb_helper_damage_blit.drm_fb_helper_damage_work.process_one_work.worker_thread
>>       0.00            +8.1        8.15 ± 76%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork
>>       0.00            +8.1        8.15 ± 76%  perf-profile.calltrace.cycles-pp.drm_fb_helper_damage_work.process_one_work.worker_thread.kthread.ret_from_fork
>>       0.00            +8.1        8.15 ± 76%  perf-profile.calltrace.cycles-pp.drm_fb_helper_damage_blit.drm_fb_helper_damage_work.process_one_work.worker_thread.kthread
>>       0.00            +8.6        8.62 ± 68%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork
>>       0.00            +8.7        8.66 ± 41%  perf-profile.calltrace.cycles-pp.uart_console_write.serial8250_console_write.call_console_drivers.console_unlock.vprintk_emit
>>       0.00            +8.9        8.87 ± 67%  perf-profile.calltrace.cycles-pp.ret_from_fork
>>       0.00            +8.9        8.87 ± 67%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
>>       0.00            +9.5        9.47 ± 39%  perf-profile.calltrace.cycles-pp.serial8250_console_write.call_console_drivers.console_unlock.vprintk_emit.devkmsg_emit
>>       0.00           +10.7       10.72 ± 35%  perf-profile.calltrace.cycles-pp.console_unlock.vprintk_emit.devkmsg_emit.devkmsg_write.cold.new_sync_write
>>       0.00           +10.7       10.72 ± 35%  perf-profile.calltrace.cycles-pp.call_console_drivers.console_unlock.vprintk_emit.devkmsg_emit.devkmsg_write.cold
>>       0.00           +16.3       16.26 ± 19%  perf-profile.calltrace.cycles-pp.devkmsg_write.cold.new_sync_write.vfs_write.ksys_write.do_syscall_64
>>       0.00           +16.3       16.26 ± 19%  perf-profile.calltrace.cycles-pp.devkmsg_emit.devkmsg_write.cold.new_sync_write.vfs_write.ksys_write
>>       0.00           +16.3       16.26 ± 19%  perf-profile.calltrace.cycles-pp.vprintk_emit.devkmsg_emit.devkmsg_write.cold.new_sync_write.vfs_write
>>       0.00           +20.0       20.03 ± 19%  perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>       0.00           +20.1       20.14 ± 20%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>>       0.00           +20.3       20.27 ± 19%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
>>       0.00           +20.3       20.27 ± 19%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>>       0.00           +20.3       20.27 ± 19%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>>       0.00           +20.3       20.27 ± 19%  perf-profile.calltrace.cycles-pp.write
>>       0.00           +34.4       34.37 ± 18%  perf-profile.calltrace.cycles-pp.mwait_idle_with_hints.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
>>       0.00           +34.8       34.84 ± 18%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
>>       0.00           +39.3       39.35 ± 19%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.secondary_startup_64_no_verify
>>       0.00           +39.3       39.35 ± 19%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
>>       0.00           +39.9       39.90 ± 19%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.secondary_startup_64_no_verify
>>       0.00           +41.4       41.39 ± 16%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.secondary_startup_64_no_verify
>>       0.00           +41.4       41.39 ± 16%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.secondary_startup_64_no_verify
>>       0.00           +41.5       41.53 ± 16%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
>>      99.45           -99.4        0.00        perf-profile.children.cycles-pp.munmap
>>      99.46           -99.3        0.14 ±141%  perf-profile.children.cycles-pp.__vm_munmap
>>      99.45           -99.3        0.14 ±141%  perf-profile.children.cycles-pp.__x64_sys_munmap
>>      99.47           -99.3        0.20 ±141%  perf-profile.children.cycles-pp.unmap_region
>>      99.47           -98.9        0.61 ± 82%  perf-profile.children.cycles-pp.__do_munmap
>>      99.45           -98.4        1.08 ± 39%  perf-profile.children.cycles-pp.zap_pte_range
>>      99.45           -98.4        1.08 ± 39%  perf-profile.children.cycles-pp.unmap_page_range
>>      99.45           -98.4        1.08 ± 39%  perf-profile.children.cycles-pp.zap_pmd_range
>>      99.45           -98.2        1.28 ± 20%  perf-profile.children.cycles-pp.unmap_vmas
>>      80.46           -80.5        0.00        perf-profile.children.cycles-pp.folio_mark_accessed
>>      99.61           -62.0       37.61 ±  9%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
>>      99.61           -62.0       37.61 ±  9%  perf-profile.children.cycles-pp.do_syscall_64
>>      50.42 ±  2%     -50.4        0.00        perf-profile.children.cycles-pp.workingset_activation
>>      49.67 ±  2%     -49.7        0.00        perf-profile.children.cycles-pp.workingset_age_nonresident
>>      26.03 ±  3%     -26.0        0.00        perf-profile.children.cycles-pp.pagevec_lru_move_fn
>>      24.79 ±  3%     -24.8        0.00        perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
>>      24.71 ±  3%     -24.7        0.00        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
>>      24.81 ±  3%     -24.7        0.11 ±141%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
>>       8.21 ±  4%      -8.2        0.00        perf-profile.children.cycles-pp.tlb_flush_mmu
>>       6.58 ±  3%      -6.5        0.11 ±141%  perf-profile.children.cycles-pp.release_pages
>>       5.42 ±  4%      -4.9        0.52 ± 99%  perf-profile.children.cycles-pp.page_remove_rmap
>>       0.00            +0.4        0.45 ± 25%  perf-profile.children.cycles-pp._raw_spin_trylock
>>       0.00            +0.4        0.45 ± 25%  perf-profile.children.cycles-pp.__irq_exit_rcu
>>       0.00            +0.4        0.45 ± 25%  perf-profile.children.cycles-pp.setlocale
>>       0.00            +0.4        0.45 ± 25%  perf-profile.children.cycles-pp.__alloc_pages
>>       0.00            +0.4        0.45 ± 25%  perf-profile.children.cycles-pp.__softirqentry_text_start
>>       0.00            +0.4        0.45 ± 25%  perf-profile.children.cycles-pp.do_read_fault
>>       0.00            +0.4        0.45 ± 25%  perf-profile.children.cycles-pp.finish_fault
>>       0.00            +0.4        0.45 ± 25%  perf-profile.children.cycles-pp.kfree
>>       0.00            +0.4        0.45 ± 25%  perf-profile.children.cycles-pp.rebalance_domains
>>       0.00            +0.4        0.45 ± 25%  perf-profile.children.cycles-pp.single_release
>>       0.10 ±  4%      +0.5        0.58 ± 34%  perf-profile.children.cycles-pp.scheduler_tick
>>       0.00            +0.6        0.56 ± 19%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
>>       0.00            +0.6        0.56 ± 19%  perf-profile.children.cycles-pp.tick_nohz_next_event
>>       0.00            +0.6        0.56 ± 19%  perf-profile.children.cycles-pp.dup_mm
>>       0.00            +0.6        0.56 ± 19%  perf-profile.children.cycles-pp.dup_mmap
>>       0.00            +0.6        0.56 ± 19%  perf-profile.children.cycles-pp.filename_lookup
>>       0.00            +0.6        0.56 ± 19%  perf-profile.children.cycles-pp.menu_select
>>       0.00            +0.6        0.56 ± 19%  perf-profile.children.cycles-pp.path_lookupat
>>       0.00            +0.6        0.56 ± 19%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
>>       0.00            +0.6        0.56 ± 19%  perf-profile.children.cycles-pp.user_path_at_empty
>>       0.00            +0.6        0.58 ± 34%  perf-profile.children.cycles-pp.page_counter_uncharge
>>       0.00            +0.6        0.58 ± 34%  perf-profile.children.cycles-pp.do_fault
>>       0.00            +0.6        0.58 ± 34%  perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
>>       0.00            +0.6        0.58 ± 34%  perf-profile.children.cycles-pp.mod_objcg_state
>>       0.00            +0.6        0.58 ± 34%  perf-profile.children.cycles-pp.obj_cgroup_uncharge_pages
>>       0.00            +0.7        0.67 ± 36%  perf-profile.children.cycles-pp.__do_sys_clone
>>       0.00            +0.7        0.67 ± 36%  perf-profile.children.cycles-pp.kernel_clone
>>       0.00            +0.7        0.67 ± 36%  perf-profile.children.cycles-pp.copy_process
>>       0.00            +0.7        0.67 ± 36%  perf-profile.children.cycles-pp.sw_perf_event_destroy
>>       0.00            +0.7        0.69 ± 13%  perf-profile.children.cycles-pp.dput
>>       0.00            +0.7        0.69 ± 13%  perf-profile.children.cycles-pp.__do_sys_newstat
>>       0.00            +0.7        0.69 ± 13%  perf-profile.children.cycles-pp.task_state
>>       0.00            +0.7        0.69 ± 13%  perf-profile.children.cycles-pp.vfs_statx
>>       0.00            +0.7        0.72 ± 52%  perf-profile.children.cycles-pp.__cond_resched
>>       0.00            +0.7        0.72 ± 52%  perf-profile.children.cycles-pp.memcg_slab_free_hook
>>       0.13            +0.8        0.89 ± 25%  perf-profile.children.cycles-pp.update_process_times
>>       0.13            +0.8        0.89 ± 25%  perf-profile.children.cycles-pp.tick_sched_handle
>>       0.24            +0.8        1.01 ± 15%  perf-profile.children.cycles-pp.__hrtimer_run_queues
>>       0.00            +0.9        0.86 ± 65%  perf-profile.children.cycles-pp.kmem_cache_alloc
>>       0.14            +0.9        1.01 ± 15%  perf-profile.children.cycles-pp.tick_sched_timer
>>       0.00            +0.9        0.89 ± 25%  perf-profile.children.cycles-pp.__close
>>       0.00            +0.9        0.92 ± 33%  perf-profile.children.cycles-pp._free_event
>>       0.00            +0.9        0.92 ± 45%  perf-profile.children.cycles-pp.begin_new_exec
>>       0.00            +0.9        0.92 ± 45%  perf-profile.children.cycles-pp.exec_mmap
>>       0.00            +1.0        1.03 ± 44%  perf-profile.children.cycles-pp.io_serial_out
>>       0.00            +1.1        1.07 ± 53%  perf-profile.children.cycles-pp.shmem_getpage_gfp
>>       0.00            +1.1        1.07 ± 53%  perf-profile.children.cycles-pp.shmem_write_begin
>>       0.00            +1.1        1.08 ± 39%  perf-profile.children.cycles-pp.delay_tsc
>>       0.00            +1.1        1.12 ± 19%  perf-profile.children.cycles-pp.fork
>>       0.02 ±141%      +1.2        1.17 ± 34%  perf-profile.children.cycles-pp.load_elf_binary
>>       0.00            +1.2        1.18 ± 49%  perf-profile.children.cycles-pp.vsnprintf
>>       0.00            +1.2        1.18 ± 49%  perf-profile.children.cycles-pp.seq_printf
>>       0.00            +1.2        1.21 ± 35%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
>>       0.00            +1.2        1.21 ± 35%  perf-profile.children.cycles-pp.copy_page_from_iter_atomic
>>       0.00            +1.2        1.21 ± 35%  perf-profile.children.cycles-pp.copyin
>>       0.05            +1.2        1.28 ± 20%  perf-profile.children.cycles-pp._raw_spin_lock
>>       0.00            +1.3        1.25 ±  4%  perf-profile.children.cycles-pp.sys_imageblit
>>       0.00            +1.3        1.25 ±  4%  perf-profile.children.cycles-pp.con_scroll
>>       0.00            +1.3        1.25 ±  4%  perf-profile.children.cycles-pp.vt_console_print
>>       0.00            +1.3        1.25 ±  4%  perf-profile.children.cycles-pp.lf
>>       0.00            +1.3        1.25 ±  4%  perf-profile.children.cycles-pp.fbcon_scroll
>>       0.00            +1.3        1.25 ±  4%  perf-profile.children.cycles-pp.fbcon_redraw
>>       0.00            +1.3        1.25 ±  4%  perf-profile.children.cycles-pp.fbcon_putcs
>>       0.00            +1.3        1.25 ±  4%  perf-profile.children.cycles-pp.bit_putcs
>>       0.00            +1.3        1.25 ±  4%  perf-profile.children.cycles-pp.drm_fbdev_fb_imageblit
>>       0.02 ±141%      +1.3        1.28 ± 20%  perf-profile.children.cycles-pp.search_binary_handler
>>       0.02 ±141%      +1.3        1.28 ± 20%  perf-profile.children.cycles-pp.exec_binprm
>>       0.00            +1.3        1.27 ± 44%  perf-profile.children.cycles-pp.proc_reg_read_iter
>>       0.34            +1.3        1.64 ± 21%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
>>       0.33 ±  2%      +1.3        1.64 ± 21%  perf-profile.children.cycles-pp.hrtimer_interrupt
>>       0.02 ±141%      +1.5        1.55 ± 41%  perf-profile.children.cycles-pp.bprm_execve
>>       0.00            +1.6        1.61 ± 20%  perf-profile.children.cycles-pp.handle_mm_fault
>>       0.00            +1.6        1.61 ± 20%  perf-profile.children.cycles-pp.__handle_mm_fault
>>       0.02 ±141%      +1.6        1.64 ± 45%  perf-profile.children.cycles-pp.__x64_sys_exit_group
>>       0.02 ±141%      +1.7        1.69 ± 49%  perf-profile.children.cycles-pp.__x64_sys_execve
>>       0.02 ±141%      +1.7        1.69 ± 49%  perf-profile.children.cycles-pp.do_execveat_common
>>       0.02 ±141%      +1.7        1.69 ± 49%  perf-profile.children.cycles-pp.execve
>>       0.00            +1.7        1.68 ± 19%  perf-profile.children.cycles-pp.fnmatch
>>       0.00            +1.7        1.68 ± 46%  perf-profile.children.cycles-pp.new_sync_read
>>       0.00            +1.7        1.72 ± 80%  perf-profile.children.cycles-pp.poll_idle
>>       0.00            +1.8        1.76 ± 98%  perf-profile.children.cycles-pp.__libc_start_main
>>       0.00            +1.8        1.76 ± 98%  perf-profile.children.cycles-pp.main
>>       0.00            +1.8        1.76 ± 98%  perf-profile.children.cycles-pp.run_builtin
>>       0.00            +1.8        1.76 ± 98%  perf-profile.children.cycles-pp.cmd_record
>>       0.00            +1.8        1.76 ± 98%  perf-profile.children.cycles-pp.__cmd_record
>>       0.03 ±141%      +1.8        1.80 ± 42%  perf-profile.children.cycles-pp.mmput
>>       0.03 ±141%      +1.8        1.80 ± 42%  perf-profile.children.cycles-pp.exit_mmap
>>       0.00            +1.9        1.88 ± 26%  perf-profile.children.cycles-pp.proc_pid_status
>>       0.00            +1.9        1.88 ± 26%  perf-profile.children.cycles-pp.proc_single_show
>>       0.00            +2.0        2.01 ± 15%  perf-profile.children.cycles-pp.exc_page_fault
>>       0.00            +2.0        2.01 ± 15%  perf-profile.children.cycles-pp.do_user_addr_fault
>>       0.00            +2.1        2.10 ± 29%  perf-profile.children.cycles-pp.seq_read
>>       0.00            +2.2        2.23 ± 46%  perf-profile.children.cycles-pp.smp_call_function_single
>>       0.00            +2.4        2.43 ± 40%  perf-profile.children.cycles-pp.event_function_call
>>       0.36            +2.4        2.81 ± 22%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
>>       0.00            +2.6        2.58 ± 65%  perf-profile.children.cycles-pp.update_sg_lb_stats
>>       0.00            +2.6        2.58 ± 65%  perf-profile.children.cycles-pp.find_busiest_group
>>       0.00            +2.6        2.58 ± 65%  perf-profile.children.cycles-pp.update_sd_lb_stats
>>       0.76 ±  5%      +2.6        3.39 ± 23%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
>>       0.00            +2.6        2.65 ± 82%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
>>       0.00            +2.8        2.77 ± 23%  perf-profile.children.cycles-pp.asm_exc_page_fault
>>       0.00            +2.9        2.91 ± 61%  perf-profile.children.cycles-pp.load_balance
>>       0.00            +3.0        3.00 ± 46%  perf-profile.children.cycles-pp.pick_next_task_fair
>>       0.00            +3.0        3.02 ± 55%  perf-profile.children.cycles-pp.newidle_balance
>>       0.02 ±141%      +3.3        3.29 ± 52%  perf-profile.children.cycles-pp._dl_catch_error
>>       0.02 ±141%      +3.6        3.66 ± 49%  perf-profile.children.cycles-pp.generic_file_write_iter
>>       0.02 ±141%      +3.6        3.66 ± 49%  perf-profile.children.cycles-pp.__generic_file_write_iter
>>       0.02 ±141%      +3.6        3.66 ± 49%  perf-profile.children.cycles-pp.generic_perform_write
>>       0.00            +3.6        3.65 ± 19%  perf-profile.children.cycles-pp.seq_read_iter
>>       0.00            +3.7        3.67 ± 45%  perf-profile.children.cycles-pp.__schedule
>>       0.00            +3.7        3.68 ± 56%  perf-profile.children.cycles-pp.do_filp_open
>>       0.00            +3.7        3.68 ± 56%  perf-profile.children.cycles-pp.path_openat
>>       0.00            +3.7        3.68 ± 27%  perf-profile.children.cycles-pp.perf_release
>>       0.00            +3.7        3.68 ± 27%  perf-profile.children.cycles-pp.perf_event_release_kernel
>>       0.00            +3.8        3.78 ± 17%  perf-profile.children.cycles-pp.ksys_read
>>       0.00            +3.8        3.78 ± 17%  perf-profile.children.cycles-pp.vfs_read
>>       0.00            +3.9        3.92 ± 17%  perf-profile.children.cycles-pp.read
>>       0.00            +3.9        3.92 ± 56%  perf-profile.children.cycles-pp.__x64_sys_openat
>>       0.00            +3.9        3.92 ± 56%  perf-profile.children.cycles-pp.do_sys_openat2
>>       0.00            +4.6        4.58 ± 34%  perf-profile.children.cycles-pp.arch_do_signal_or_restart
>>       0.00            +4.6        4.58 ± 34%  perf-profile.children.cycles-pp.get_signal
>>       0.00            +5.5        5.46 ± 15%  perf-profile.children.cycles-pp.__fput
>>       0.00            +5.7        5.71 ± 16%  perf-profile.children.cycles-pp.task_work_run
>>       0.00            +6.1        6.07 ± 19%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
>>       0.02 ±141%      +6.2        6.22 ± 13%  perf-profile.children.cycles-pp.do_group_exit
>>       0.02 ±141%      +6.2        6.22 ± 13%  perf-profile.children.cycles-pp.do_exit
>>       0.00            +6.3        6.27 ± 15%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
>>       0.00            +7.4        7.36 ± 41%  perf-profile.children.cycles-pp.io_serial_in
>>       0.00            +7.7        7.74 ± 43%  perf-profile.children.cycles-pp.serial8250_console_putchar
>>       0.00            +8.1        8.15 ± 76%  perf-profile.children.cycles-pp.process_one_work
>>       0.00            +8.1        8.15 ± 76%  perf-profile.children.cycles-pp.drm_fb_helper_damage_work
>>       0.00            +8.1        8.15 ± 76%  perf-profile.children.cycles-pp.drm_fb_helper_damage_blit
>>       0.00            +8.1        8.15 ± 76%  perf-profile.children.cycles-pp.memcpy_toio
>>       0.00            +8.3        8.33 ± 40%  perf-profile.children.cycles-pp.wait_for_xmitr
>>       0.00            +8.6        8.62 ± 68%  perf-profile.children.cycles-pp.worker_thread
>>       0.00            +8.7        8.66 ± 41%  perf-profile.children.cycles-pp.uart_console_write
>>       0.02 ±141%      +8.9        8.87 ± 67%  perf-profile.children.cycles-pp.ret_from_fork
>>       0.02 ±141%      +8.9        8.87 ± 67%  perf-profile.children.cycles-pp.kthread
>>       0.00            +9.5        9.47 ± 39%  perf-profile.children.cycles-pp.serial8250_console_write
>>       0.00           +10.7       10.72 ± 35%  perf-profile.children.cycles-pp.console_unlock
>>       0.00           +10.7       10.72 ± 35%  perf-profile.children.cycles-pp.call_console_drivers
>>       0.00           +16.3       16.26 ± 19%  perf-profile.children.cycles-pp.devkmsg_write.cold
>>       0.00           +16.3       16.26 ± 19%  perf-profile.children.cycles-pp.devkmsg_emit
>>       0.00           +16.3       16.26 ± 19%  perf-profile.children.cycles-pp.vprintk_emit
>>       0.02 ±141%     +20.0       20.03 ± 19%  perf-profile.children.cycles-pp.new_sync_write
>>       0.02 ±141%     +20.1       20.14 ± 20%  perf-profile.children.cycles-pp.vfs_write
>>       0.03 ±141%     +20.2       20.27 ± 19%  perf-profile.children.cycles-pp.ksys_write
>>       0.02 ±141%     +20.2       20.27 ± 19%  perf-profile.children.cycles-pp.write
>>       0.32 ± 37%     +34.7       34.98 ± 18%  perf-profile.children.cycles-pp.intel_idle
>>       0.32 ± 37%     +34.7       34.98 ± 18%  perf-profile.children.cycles-pp.mwait_idle_with_hints
>>       0.33 ± 36%     +39.2       39.48 ± 19%  perf-profile.children.cycles-pp.cpuidle_enter
>>       0.33 ± 36%     +39.2       39.48 ± 19%  perf-profile.children.cycles-pp.cpuidle_enter_state
>>       0.33 ± 35%     +39.7       40.04 ± 19%  perf-profile.children.cycles-pp.cpuidle_idle_call
>>       0.33 ± 35%     +41.2       41.53 ± 16%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
>>       0.33 ± 35%     +41.2       41.53 ± 16%  perf-profile.children.cycles-pp.cpu_startup_entry
>>       0.33 ± 35%     +41.2       41.53 ± 16%  perf-profile.children.cycles-pp.do_idle
>>      49.51 ±  2%     -49.5        0.00        perf-profile.self.cycles-pp.workingset_age_nonresident
>>      24.71 ±  3%     -24.7        0.00        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
>>       6.52 ±  3%      -6.5        0.00        perf-profile.self.cycles-pp.release_pages
>>       5.28 ±  6%      -4.9        0.36 ± 76%  perf-profile.self.cycles-pp.zap_pte_range
>>       0.00            +0.4        0.45 ± 25%  perf-profile.self.cycles-pp.proc_pid_status
>>       0.00            +0.4        0.45 ± 25%  perf-profile.self.cycles-pp._raw_spin_trylock
>>       0.00            +0.4        0.45 ± 25%  perf-profile.self.cycles-pp.page_counter_uncharge
>>       0.00            +0.6        0.56 ± 19%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
>>       0.00            +1.0        1.03 ± 44%  perf-profile.self.cycles-pp.io_serial_out
>>       0.00            +1.1        1.08 ± 39%  perf-profile.self.cycles-pp.delay_tsc
>>       0.00            +1.2        1.21 ± 35%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
>>       0.03 ± 70%      +1.2        1.28 ± 20%  perf-profile.self.cycles-pp._raw_spin_lock
>>       0.00            +1.3        1.25 ±  4%  perf-profile.self.cycles-pp.sys_imageblit
>>       0.00            +1.7        1.68 ± 19%  perf-profile.self.cycles-pp.fnmatch
>>       0.00            +1.7        1.72 ± 80%  perf-profile.self.cycles-pp.poll_idle
>>       0.00            +2.1        2.12 ± 41%  perf-profile.self.cycles-pp.smp_call_function_single
>>       0.00            +2.4        2.44 ± 61%  perf-profile.self.cycles-pp.update_sg_lb_stats
>>       0.00            +7.4        7.36 ± 41%  perf-profile.self.cycles-pp.io_serial_in
>>       0.00            +8.1        8.15 ± 76%  perf-profile.self.cycles-pp.memcpy_toio
>>       0.32 ± 37%     +34.7       34.98 ± 18%  perf-profile.self.cycles-pp.mwait_idle_with_hints
>>
>>
>>
>> ***************************************************************************************************
>> lkp-csl-2ap4: 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
>> =========================================================================================
>> compiler/cpufreq_governor/kconfig/rootfs/runtime/tbox_group/test/testcase/ucode:
>>   gcc-9/performance/x86_64-rhel-8.3/debian-10.4-x86_64-20200603.cgz/300s/lkp-csl-2ap4/mmap-pread-seq-mt/vm-scalability/0x500320a
>>
>> commit: 
>>   18788cfa23 ("mm: Support arbitrary THP sizes")
>>   793917d997 ("mm/readahead: Add large folio readahead")
>>
>> 18788cfa23696774 793917d997df2e432f3e9ac126e 
>> ---------------- --------------------------- 
>>          %stddev     %change         %stddev
>>              \          |                \  
>>      47.76 ± 21%    +120.9%     105.50 ± 18%  vm-scalability.free_time
>>     381902           +67.5%     639832 ±  9%  vm-scalability.median
>>   72780899           +64.8%  1.199e+08 ±  6%  vm-scalability.throughput
>>     461.08           +35.5%     624.74        vm-scalability.time.elapsed_time
>>     461.08           +35.5%     624.74        vm-scalability.time.elapsed_time.max
>>     140148 ±  7%     +46.2%     204907 ± 13%  vm-scalability.time.involuntary_context_switches
>>  1.039e+10          +149.1%  2.588e+10 ±  5%  vm-scalability.time.maximum_resident_set_size
>>  3.901e+08           +35.8%  5.298e+08 ± 11%  vm-scalability.time.minor_page_faults
>>      11965           -27.0%       8731 ±  3%  vm-scalability.time.percent_of_cpu_this_job_got
>>      45372           -31.5%      31070 ± 13%  vm-scalability.time.system_time
>>       9799          +139.3%      23452 ± 20%  vm-scalability.time.user_time
>>  2.327e+10           +67.3%  3.895e+10 ±  3%  vm-scalability.workload
>>   3.17e+10           +97.0%  6.247e+10 ±  4%  cpuidle..time
>>  1.364e+08 ±  2%     +52.6%  2.081e+08 ± 18%  cpuidle..usage
>>     511.67           +31.7%     673.93        uptime.boot
>>      39763           +75.9%      69937 ±  3%  uptime.idle
>>    1650179 ±  6%    +108.4%    3439319 ± 13%  numa-numastat.node0.local_node
>>    1714274 ±  7%    +104.0%    3497283 ± 12%  numa-numastat.node0.numa_hit
>>      80709 ± 10%   +1568.8%    1346869 ± 50%  numa-numastat.node1.other_node
>>      51833 ± 45%   +3011.6%    1612852 ± 72%  numa-numastat.node2.other_node
>>      35.43           +16.4       51.83 ±  2%  mpstat.cpu.all.idle%
>>       1.15            +0.2        1.32 ±  3%  mpstat.cpu.all.irq%
>>       0.14 ±  2%      -0.0        0.12 ± 12%  mpstat.cpu.all.soft%
>>      51.46           -25.4       26.05 ± 10%  mpstat.cpu.all.sys%
>>      11.22            +8.7       19.95 ± 21%  mpstat.cpu.all.usr%
>>      35.33           +44.3%      51.00        vmstat.cpu.id
>>      11.00           +72.7%      19.00 ± 22%  vmstat.cpu.us
>>   39267912          +186.2%  1.124e+08        vmstat.memory.cache
>>  1.463e+08           -61.9%   55690119 ±  3%  vmstat.memory.free
>>     121.33           -25.8%      90.00 ±  3%  vmstat.procs.r
>>       2004           -25.7%       1489 ±  2%  turbostat.Avg_MHz
>>      65.34           -16.4       48.90 ±  2%  turbostat.Busy%
>>    4391194 ±  3%     -40.7%    2602910 ± 48%  turbostat.C1
>>   65661757           +90.5%  1.251e+08 ±  4%  turbostat.C1E
>>      33.68           +15.8       49.47 ±  3%  turbostat.C1E%
>>      34.63           +47.3%      51.01 ±  2%  turbostat.CPU%c1
>>       0.07 ±  7%    +135.0%       0.16 ±  7%  turbostat.IPC
>>  2.636e+08 ±  7%     +64.2%  4.327e+08 ± 41%  turbostat.IRQ
>>     206.94            -1.8%     203.27        turbostat.PkgWatt
>>   18398499          +233.3%   61329324 ± 14%  meminfo.Active
>>     434070 ± 10%     -41.0%     256027 ± 30%  meminfo.Active(anon)
>>   17964429          +240.0%   61073297 ± 14%  meminfo.Active(file)
>>   39197349          +185.9%  1.121e+08        meminfo.Cached
>>    2720032 ±  3%     -12.0%    2394908        meminfo.Committed_AS
>>   18649788          +160.4%   48571839 ± 21%  meminfo.Inactive
>>     592314 ± 10%     -23.6%     452265 ± 14%  meminfo.Inactive(anon)
>>   18057473          +166.5%   48119574 ± 21%  meminfo.Inactive(file)
>>     219940           +73.3%     381070        meminfo.KReclaimable
>>   36119017          +201.2%  1.088e+08        meminfo.Mapped
>>  1.812e+08            -9.5%  1.639e+08        meminfo.MemAvailable
>>  1.461e+08           -61.8%   55768647 ±  3%  meminfo.MemFree
>>   51577716          +175.2%  1.419e+08        meminfo.Memused
>>   10114995          +171.9%   27506491 ±  2%  meminfo.PageTables
>>     219940           +73.3%     381070        meminfo.SReclaimable
>>     312390           +13.2%     353621 ±  2%  meminfo.SUnreclaim
>>     734611 ± 13%     -41.7%     427960 ±  8%  meminfo.Shmem
>>     532331           +38.0%     734691        meminfo.Slab
>>   55437706          +182.4%  1.566e+08        meminfo.max_used_kB
>>     270259 ±112%   +1573.3%    4522215 ± 16%  numa-vmstat.node0.nr_active_file
>>     946393 ± 35%    +663.5%    7225435 ± 16%  numa-vmstat.node0.nr_file_pages
>>   10541034 ±  3%     -69.1%    3255834 ± 25%  numa-vmstat.node0.nr_free_pages
>>      98102 ± 70%   +2211.2%    2267326 ± 32%  numa-vmstat.node0.nr_inactive_file
>>     381079 ± 92%   +1678.2%    6776300 ± 21%  numa-vmstat.node0.nr_mapped
>>     643599 ±  3%    +153.2%    1629683 ± 22%  numa-vmstat.node0.nr_page_table_pages
>>      20984 ± 12%     +51.4%      31778 ± 15%  numa-vmstat.node0.nr_slab_reclaimable
>>     270259 ±112%   +1573.3%    4522216 ± 16%  numa-vmstat.node0.nr_zone_active_file
>>      98101 ± 70%   +2211.2%    2267302 ± 32%  numa-vmstat.node0.nr_zone_inactive_file
>>    1713996 ±  7%    +104.0%    3496544 ± 12%  numa-vmstat.node0.numa_hit
>>    1649901 ±  6%    +108.4%    3438581 ± 13%  numa-vmstat.node0.numa_local
>>     708884 ±122%    +466.2%    4013857 ±  7%  numa-vmstat.node1.nr_active_file
>>    1335766 ±119%    +354.3%    6068220 ± 19%  numa-vmstat.node1.nr_file_pages
>>   10293220 ± 15%     -58.1%    4317437 ± 20%  numa-vmstat.node1.nr_free_pages
>>     622687 ±117%    +224.6%    2021489 ± 45%  numa-vmstat.node1.nr_inactive_file
>>    1331303 ±119%    +348.9%    5976082 ± 20%  numa-vmstat.node1.nr_mapped
>>     642435          +189.7%    1860950 ± 16%  numa-vmstat.node1.nr_page_table_pages
>>       6047 ± 66%    +206.0%      18505 ± 14%  numa-vmstat.node1.nr_slab_reclaimable
>>      16156 ±  3%     +29.6%      20936 ± 11%  numa-vmstat.node1.nr_slab_unreclaimable
>>     708884 ±122%    +466.2%    4013857 ±  7%  numa-vmstat.node1.nr_zone_active_file
>>     622684 ±117%    +224.6%    2021474 ± 45%  numa-vmstat.node1.nr_zone_inactive_file
>>      80709 ± 10%   +1568.8%    1346867 ± 50%  numa-vmstat.node1.numa_other
>>     629284 ±  7%    +212.3%    1965297 ± 36%  numa-vmstat.node2.nr_page_table_pages
>>      51833 ± 45%   +3011.6%    1612851 ± 72%  numa-vmstat.node2.numa_other
>>      76205 ± 42%     -77.4%      17185 ±135%  numa-vmstat.node3.nr_active_anon
>>    2340058 ± 55%     +93.0%    4516830 ± 11%  numa-vmstat.node3.nr_active_file
>>      27102 ± 87%     -88.7%       3069 ± 50%  numa-vmstat.node3.nr_anon_pages
>>    4825949 ± 61%     +73.4%    8366128 ±  6%  numa-vmstat.node3.nr_file_pages
>>    6778041 ± 42%     -63.2%    2495049 ± 11%  numa-vmstat.node3.nr_free_pages
>>      61462 ± 36%     -90.9%       5604 ±  6%  numa-vmstat.node3.nr_inactive_anon
>>       9125 ± 24%     -25.3%       6816 ±  7%  numa-vmstat.node3.nr_kernel_stack
>>     614483 ±  6%    +124.8%    1381443 ± 22%  numa-vmstat.node3.nr_page_table_pages
>>     110543 ± 34%     -82.1%      19753 ±119%  numa-vmstat.node3.nr_shmem
>>      16802 ± 18%     +54.9%      26023 ± 18%  numa-vmstat.node3.nr_slab_reclaimable
>>      76205 ± 42%     -77.4%      17185 ±135%  numa-vmstat.node3.nr_zone_active_anon
>>    2340060 ± 55%     +93.0%    4516833 ± 11%  numa-vmstat.node3.nr_zone_active_file
>>      61462 ± 36%     -90.9%       5606 ±  6%  numa-vmstat.node3.nr_zone_inactive_anon
>>    1395481 ± 71%    +251.5%    4905621 ± 17%  proc-vmstat.compact_free_scanned
>>      33074 ± 70%    +419.4%     171779 ± 22%  proc-vmstat.compact_isolated
>>     202053 ± 73%   +9922.0%   20249857 ± 36%  proc-vmstat.compact_migrate_scanned
>>     108289 ±  9%     -40.8%      64062 ± 30%  proc-vmstat.nr_active_anon
>>    4508307          +239.1%   15287070 ± 14%  proc-vmstat.nr_active_file
>>    4529195            -9.4%    4101452        proc-vmstat.nr_dirty_background_threshold
>>    9069466            -9.4%    8212934        proc-vmstat.nr_dirty_threshold
>>    9806867          +185.6%   28009127        proc-vmstat.nr_file_pages
>>   36527728           -61.8%   13964856 ±  3%  proc-vmstat.nr_free_pages
>>     147970 ± 10%     -23.8%     112719 ± 14%  proc-vmstat.nr_inactive_anon
>>    4504742          +166.5%   12005145 ± 21%  proc-vmstat.nr_inactive_file
>>       9.67 ± 70%   +1544.8%     159.00 ± 73%  proc-vmstat.nr_isolated_file
>>      32470            -2.3%      31717        proc-vmstat.nr_kernel_stack
>>    9038764          +200.8%   27190039        proc-vmstat.nr_mapped
>>    2528396          +171.3%    6860572        proc-vmstat.nr_page_table_pages
>>     183340 ± 13%     -41.8%     106760 ±  8%  proc-vmstat.nr_shmem
>>      55004           +73.2%      95262        proc-vmstat.nr_slab_reclaimable
>>      78097           +13.2%      88396 ±  2%  proc-vmstat.nr_slab_unreclaimable
>>     108289 ±  9%     -40.8%      64062 ± 30%  proc-vmstat.nr_zone_active_anon
>>    4508309          +239.1%   15287080 ± 14%  proc-vmstat.nr_zone_active_file
>>     147971 ± 10%     -23.8%     112721 ± 14%  proc-vmstat.nr_zone_inactive_anon
>>    4504748          +166.5%   12005031 ± 21%  proc-vmstat.nr_zone_inactive_file
>>    1399962 ± 70%    +205.1%    4271516 ± 15%  proc-vmstat.numa_foreign
>>     187918 ± 10%     -26.4%     138295 ± 13%  proc-vmstat.numa_hint_faults_local
>>   20021857 ±  5%     -27.1%   14586662 ±  7%  proc-vmstat.numa_hit
>>   19764621 ±  5%     -27.5%   14337667 ±  7%  proc-vmstat.numa_local
>>    1400006 ± 70%    +205.2%    4273115 ± 15%  proc-vmstat.numa_miss
>>    1661389 ± 59%    +172.8%    4532571 ± 14%  proc-vmstat.numa_other
>>   13859568          +153.3%   35111344        proc-vmstat.pgactivate
>>       0.00       +3.9e+107%     393020 ±  3%  proc-vmstat.pgalloc_dma32
>>   21429150          +145.6%   52620266 ±  4%  proc-vmstat.pgalloc_normal
>>     289208 ± 74%   +3004.1%    8977408 ± 51%  proc-vmstat.pgdeactivate
>>  5.274e+08           +35.0%   7.12e+08 ± 17%  proc-vmstat.pgfault
>>   21431234          +147.7%   53085222 ±  4%  proc-vmstat.pgfree
>>       6523 ±  8%     -78.2%       1419 ±122%  proc-vmstat.pgmajfault
>>      51107 ± 27%    +105.8%     105175 ± 15%  proc-vmstat.pgmigrate_success
>>     289208 ± 74%   +3004.1%    8977408 ± 51%  proc-vmstat.pgrefill
>>     114636           +24.7%     142954 ±  2%  proc-vmstat.pgreuse
>>     256146 ± 80%  +10403.4%   26904076 ± 47%  proc-vmstat.pgscan_file
>>     256146 ± 80%   +2517.8%    6705410 ± 27%  proc-vmstat.pgscan_kswapd
>>       1706 ±141%   +4493.7%      78398 ± 94%  proc-vmstat.slabs_scanned
>>       5.68            -9.8%       5.12 ±  7%  perf-stat.i.MPKI
>>  2.635e+10           +89.2%  4.987e+10 ±  2%  perf-stat.i.branch-instructions
>>   29446064 ±  2%     -26.8%   21568998 ± 20%  perf-stat.i.branch-misses
>>      41.05            +8.4       49.42 ±  3%  perf-stat.i.cache-miss-rate%
>>  4.891e+08           +66.5%  8.145e+08 ±  4%  perf-stat.i.cache-references
>>       3.18           -31.9%       2.17 ± 14%  perf-stat.i.cpi
>>   3.57e+11           -26.4%  2.627e+11 ±  3%  perf-stat.i.cpu-cycles
>>       2046 ±  2%     -38.8%       1252 ±  7%  perf-stat.i.cycles-between-cache-misses
>>       0.02 ±  4%      -0.0        0.01 ± 13%  perf-stat.i.dTLB-load-miss-rate%
>>  2.143e+10           +87.7%  4.022e+10 ±  2%  perf-stat.i.dTLB-loads
>>       0.02            -0.0        0.01 ±  5%  perf-stat.i.dTLB-store-miss-rate%
>>  4.017e+09           +71.6%  6.894e+09 ±  3%  perf-stat.i.dTLB-stores
>>      67.19            -6.8       60.42 ±  2%  perf-stat.i.iTLB-load-miss-rate%
>>  8.244e+10           +87.3%  1.544e+11 ±  2%  perf-stat.i.instructions
>>      11508           +64.7%      18958 ± 20%  perf-stat.i.instructions-per-iTLB-miss
>>       0.46           +71.5%       0.78 ±  3%  perf-stat.i.ipc
>>       1.86           -26.5%       1.37 ±  3%  perf-stat.i.metric.GHz
>>     272.17           +86.8%     508.48 ±  2%  perf-stat.i.metric.M/sec
>>      89.61            -4.2       85.41 ±  2%  perf-stat.i.node-load-miss-rate%
>>      93.39            -1.1       92.31        perf-stat.i.node-store-miss-rate%
>>       5.94           -11.1%       5.27 ±  2%  perf-stat.overall.MPKI
>>       0.11            -0.1        0.04 ± 18%  perf-stat.overall.branch-miss-rate%
>>      24.75            -8.3       16.49 ±  3%  perf-stat.overall.cache-miss-rate%
>>       4.34           -58.3%       1.81 ±  7%  perf-stat.overall.cpi
>>       2957           -29.4%       2088 ±  8%  perf-stat.overall.cycles-between-cache-misses
>>       0.03 ±  4%      -0.0        0.02 ± 18%  perf-stat.overall.dTLB-load-miss-rate%
>>       0.03            -0.0        0.02 ±  6%  perf-stat.overall.dTLB-store-miss-rate%
>>      79.19            -4.8       74.43 ±  5%  perf-stat.overall.iTLB-load-miss-rate%
>>      14468          +118.3%      31586 ± 23%  perf-stat.overall.instructions-per-iTLB-miss
>>       0.23          +140.9%       0.55 ±  7%  perf-stat.overall.ipc
>>       1753           +44.2%       2527 ±  3%  perf-stat.overall.path-length
>>  2.825e+10           +80.0%  5.086e+10 ±  4%  perf-stat.ps.branch-instructions
>>   31369620           -29.5%   22107780 ± 22%  perf-stat.ps.branch-misses
>>  5.237e+08           +58.7%  8.311e+08 ±  7%  perf-stat.ps.cache-references
>>  3.833e+11           -25.9%  2.842e+11 ±  2%  perf-stat.ps.cpu-cycles
>>  2.292e+10           +78.8%    4.1e+10 ±  5%  perf-stat.ps.dTLB-loads
>>  4.264e+09           +64.4%  7.011e+09 ±  6%  perf-stat.ps.dTLB-stores
>>  8.823e+10           +78.4%  1.574e+11 ±  5%  perf-stat.ps.instructions
>>   18972299           -23.4%   14538789 ± 27%  perf-stat.ps.node-load-misses
>>    1093618 ±  5%      -7.4%    1012942 ±  3%  perf-stat.ps.node-loads
>>    7576747 ±  5%     -20.8%    5997202 ± 26%  perf-stat.ps.node-store-misses
>>  4.081e+13          +141.5%  9.854e+13 ±  6%  perf-stat.total.instructions
>>    1078861 ±112%   +1578.0%   18103185 ± 16%  numa-meminfo.node0.Active
>>    1073730 ±112%   +1574.7%   17982022 ± 17%  numa-meminfo.node0.Active(file)
>>    3776230 ± 34%    +665.8%   28918288 ± 16%  numa-meminfo.node0.FilePages
>>     510515 ± 29%   +1738.2%    9384093 ± 29%  numa-meminfo.node0.Inactive
>>     390425 ± 70%   +2253.6%    9188935 ± 31%  numa-meminfo.node0.Inactive(file)
>>      83922 ± 12%     +51.5%     127156 ± 15%  numa-meminfo.node0.KReclaimable
>>    1513602 ± 92%   +1691.7%   27118547 ± 21%  numa-meminfo.node0.Mapped
>>   42176849 ±  3%     -69.2%   12973556 ± 24%  numa-meminfo.node0.MemFree
>>    6979665 ± 18%    +418.4%   36182958 ±  8%  numa-meminfo.node0.MemUsed
>>    2570494 ±  3%    +154.8%    6550818 ± 23%  numa-meminfo.node0.PageTables
>>      83922 ± 12%     +51.5%     127156 ± 15%  numa-meminfo.node0.SReclaimable
>>     181192 ± 10%     +28.8%     233452 ± 12%  numa-meminfo.node0.Slab
>>    2821085 ±121%    +465.7%   15958433 ±  8%  numa-meminfo.node1.Active
>>    2812387 ±122%    +467.1%   15948621 ±  8%  numa-meminfo.node1.Active(file)
>>      46712 ± 79%    +167.4%     124913 ± 51%  numa-meminfo.node1.AnonPages.max
>>    5323354 ±119%    +355.5%   24250501 ± 19%  numa-meminfo.node1.FilePages
>>    2511909 ±116%    +228.8%    8260033 ± 43%  numa-meminfo.node1.Inactive
>>    2494074 ±117%    +227.6%    8170385 ± 45%  numa-meminfo.node1.Inactive(file)
>>      24145 ± 66%    +206.4%      73980 ± 14%  numa-meminfo.node1.KReclaimable
>>    5303377 ±119%    +350.4%   23887574 ± 20%  numa-meminfo.node1.Mapped
>>   41195841 ± 15%     -58.1%   17270949 ± 20%  numa-meminfo.node1.MemFree
>>    8338805 ± 76%    +286.9%   32263698 ± 10%  numa-meminfo.node1.MemUsed
>>    2565988          +190.9%    7463727 ± 16%  numa-meminfo.node1.PageTables
>>      24145 ± 66%    +206.4%      73980 ± 14%  numa-meminfo.node1.SReclaimable
>>      64627 ±  3%     +29.6%      83746 ± 11%  numa-meminfo.node1.SUnreclaim
>>      88774 ± 20%     +77.7%     157727 ± 11%  numa-meminfo.node1.Slab
>>    2513412 ±  7%    +212.9%    7864995 ± 36%  numa-meminfo.node2.PageTables
>>     115780 ± 29%     +36.6%     158133 ± 12%  numa-meminfo.node2.Slab
>>    9580292 ± 54%     +88.0%   18009449 ± 11%  numa-meminfo.node3.Active
>>     305023 ± 43%     -77.4%      68934 ±135%  numa-meminfo.node3.Active(anon)
>>    9275268 ± 55%     +93.4%   17940514 ± 10%  numa-meminfo.node3.Active(file)
>>     108407 ± 87%     -88.6%      12400 ± 51%  numa-meminfo.node3.AnonPages
>>     160985 ± 61%     -73.4%      42806 ± 76%  numa-meminfo.node3.AnonPages.max
>>   19239019 ± 61%     +74.0%   33471217 ±  6%  numa-meminfo.node3.FilePages
>>     246214 ± 36%     -90.8%      22559 ±  6%  numa-meminfo.node3.Inactive(anon)
>>      67061 ± 18%     +55.3%     104124 ± 18%  numa-meminfo.node3.KReclaimable
>>       9127 ± 24%     -25.3%       6820 ±  8%  numa-meminfo.node3.KernelStack
>>   27179894 ± 42%     -63.4%    9952841 ± 10%  numa-meminfo.node3.MemFree
>>   22309393 ± 51%     +77.2%   39536446 ±  2%  numa-meminfo.node3.MemUsed
>>    2454785 ±  6%    +125.9%    5545631 ± 22%  numa-meminfo.node3.PageTables
>>      67061 ± 18%     +55.3%     104124 ± 18%  numa-meminfo.node3.SReclaimable
>>     442746 ± 34%     -82.1%      79224 ±119%  numa-meminfo.node3.Shmem
>>     146622 ±  3%     +26.3%     185228 ±  9%  numa-meminfo.node3.Slab
>>       0.69 ±  5%     -28.1%       0.49 ±  5%  sched_debug.cfs_rq:/.h_nr_running.avg
>>       1.64 ±  6%     -10.5%       1.47        sched_debug.cfs_rq:/.h_nr_running.max
>>       0.20 ±  2%     +15.6%       0.24 ±  8%  sched_debug.cfs_rq:/.h_nr_running.stddev
>>       6824 ±  8%    +196.8%      20253 ±  6%  sched_debug.cfs_rq:/.load.avg
>>     229906 ±  3%    +129.8%     528372 ±  9%  sched_debug.cfs_rq:/.load.max
>>      21576 ± 14%    +260.6%      77803 ±  5%  sched_debug.cfs_rq:/.load.stddev
>>       9.61 ± 13%    +125.1%      21.63 ±  9%  sched_debug.cfs_rq:/.load_avg.avg
>>     338.23 ± 10%     +90.2%     643.24 ±  7%  sched_debug.cfs_rq:/.load_avg.max
>>       1.93 ± 20%     -50.2%       0.96 ± 51%  sched_debug.cfs_rq:/.load_avg.min
>>      35.19 ± 16%    +148.2%      87.36 ±  4%  sched_debug.cfs_rq:/.load_avg.stddev
>>   28561269 ±  4%     +23.7%   35334125 ±  5%  sched_debug.cfs_rq:/.min_vruntime.avg
>>   29300278 ±  4%     +24.1%   36374870 ±  5%  sched_debug.cfs_rq:/.min_vruntime.max
>>   25701358 ±  3%     +10.0%   28264060 ±  8%  sched_debug.cfs_rq:/.min_vruntime.min
>>     520966 ± 10%    +117.7%    1134026 ± 46%  sched_debug.cfs_rq:/.min_vruntime.stddev
>>       0.68 ±  5%     -28.2%       0.48 ±  6%  sched_debug.cfs_rq:/.nr_running.avg
>>       0.18 ±  2%     +19.6%       0.21 ±  5%  sched_debug.cfs_rq:/.nr_running.stddev
>>     137.38 ±  5%     -30.0%      96.19 ±  4%  sched_debug.cfs_rq:/.removed.load_avg.max
>>      54.41 ± 14%     -34.3%      35.73 ± 37%  sched_debug.cfs_rq:/.removed.runnable_avg.max
>>      54.41 ± 14%     -34.3%      35.73 ± 37%  sched_debug.cfs_rq:/.removed.util_avg.max
>>     617.96 ±  5%     -24.3%     467.92 ±  2%  sched_debug.cfs_rq:/.runnable_avg.avg
>>       1519 ±  3%      -8.0%       1397        sched_debug.cfs_rq:/.runnable_avg.max
>>     208.55 ± 11%     -33.1%     139.44 ± 22%  sched_debug.cfs_rq:/.runnable_avg.min
>>     140.06 ±  3%     +32.9%     186.10 ±  7%  sched_debug.cfs_rq:/.runnable_avg.stddev
>>     590586 ± 38%     +96.2%    1158625 ± 14%  sched_debug.cfs_rq:/.spread0.max
>>   -3015844          +130.5%   -6950269        sched_debug.cfs_rq:/.spread0.min
>>     521714 ± 10%    +117.4%    1134421 ± 46%  sched_debug.cfs_rq:/.spread0.stddev
>>     609.27 ±  5%     -24.4%     460.70 ±  2%  sched_debug.cfs_rq:/.util_avg.avg
>>       1444 ±  4%      -7.9%       1330        sched_debug.cfs_rq:/.util_avg.max
>>     130.58 ±  3%     +35.1%     176.43 ±  7%  sched_debug.cfs_rq:/.util_avg.stddev
>>     572.34 ±  5%     -31.2%     393.53 ±  6%  sched_debug.cfs_rq:/.util_est_enqueued.avg
>>       1316 ±  9%     -18.0%       1078        sched_debug.cfs_rq:/.util_est_enqueued.max
>>     310775 ± 11%     +89.7%     589408 ± 15%  sched_debug.cpu.avg_idle.avg
>>     239814 ±  5%     +41.3%     338862 ±  4%  sched_debug.cpu.clock.avg
>>     239856 ±  5%     +41.3%     338900 ±  4%  sched_debug.cpu.clock.max
>>     239768 ±  5%     +41.3%     338817 ±  4%  sched_debug.cpu.clock.min
>>     237458 ±  5%     +40.9%     334653 ±  4%  sched_debug.cpu.clock_task.avg
>>     237726 ±  5%     +41.1%     335330 ±  4%  sched_debug.cpu.clock_task.max
>>     227513 ±  5%     +42.8%     324812 ±  4%  sched_debug.cpu.clock_task.min
>>       5295 ±  6%     -31.7%       3615 ±  6%  sched_debug.cpu.curr->pid.avg
>>      13058 ±  5%     +24.9%      16312 ±  2%  sched_debug.cpu.curr->pid.max
>>       1468           +14.2%       1678 ±  4%  sched_debug.cpu.curr->pid.stddev
>>       0.68 ±  6%     -32.1%       0.46 ±  6%  sched_debug.cpu.nr_running.avg
>>  2.408e+09            -9.4%  2.182e+09 ±  6%  sched_debug.cpu.nr_uninterruptible.avg
>>     239765 ±  5%     +41.3%     338814 ±  4%  sched_debug.cpu_clk
>>     238754 ±  5%     +41.5%     337801 ±  4%  sched_debug.ktime
>>     240246 ±  5%     +41.2%     339291 ±  4%  sched_debug.sched_clk
>>      54.77           -39.6       15.17 ±  4%  perf-profile.calltrace.cycles-pp.filemap_map_pages.xfs_filemap_map_pages.do_fault.__handle_mm_fault.handle_mm_fault
>>      43.84           -38.2        5.61 ±  3%  perf-profile.calltrace.cycles-pp.next_uptodate_page.filemap_map_pages.xfs_filemap_map_pages.do_fault.__handle_mm_fault
>>      69.95           -37.8       32.18 ±  3%  perf-profile.calltrace.cycles-pp.xfs_filemap_map_pages.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
>>      75.67           -35.5       40.16 ±  7%  perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
>>      76.91           -32.6       44.30 ±  7%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
>>      77.31           -32.5       44.81 ±  7%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
>>      78.89           -25.4       53.45 ±  8%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
>>      78.91           -25.2       53.70 ±  8%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.do_access
>>      79.15           -25.1       54.07 ±  8%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.do_access
>>      88.17           -15.5       72.70 ±  3%  perf-profile.calltrace.cycles-pp.do_access
>>       1.25 ±  3%      -0.9        0.37 ± 70%  perf-profile.calltrace.cycles-pp.folio_wake_bit.filemap_map_pages.xfs_filemap_map_pages.do_fault.__handle_mm_fault
>>       1.43 ±  2%      -0.2        1.20        perf-profile.calltrace.cycles-pp.page_add_file_rmap.do_set_pte.filemap_map_pages.xfs_filemap_map_pages.do_fault
>>       1.48 ±  2%      -0.1        1.36 ±  2%  perf-profile.calltrace.cycles-pp.do_set_pte.filemap_map_pages.xfs_filemap_map_pages.do_fault.__handle_mm_fault
>>       4.18            +1.1        5.30 ±  2%  perf-profile.calltrace.cycles-pp.xas_load.xas_find.filemap_map_pages.xfs_filemap_map_pages.do_fault
>>       4.19            +1.1        5.32 ±  2%  perf-profile.calltrace.cycles-pp.xas_find.filemap_map_pages.xfs_filemap_map_pages.do_fault.__handle_mm_fault
>>       6.57            +1.1        7.70 ±  4%  perf-profile.calltrace.cycles-pp.xfs_iunlock.xfs_filemap_map_pages.do_fault.__handle_mm_fault.handle_mm_fault
>>       4.03            +1.1        5.16 ±  2%  perf-profile.calltrace.cycles-pp.xas_start.xas_load.xas_find.filemap_map_pages.xfs_filemap_map_pages
>>       6.30            +1.2        7.52 ±  4%  perf-profile.calltrace.cycles-pp.up_read.xfs_iunlock.xfs_filemap_map_pages.do_fault.__handle_mm_fault
>>       0.17 ±141%      +2.4        2.62 ±  8%  perf-profile.calltrace.cycles-pp.up_read.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
>>       0.74 ± 21%      +3.8        4.52 ± 18%  perf-profile.calltrace.cycles-pp.down_read_trylock.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
>>      12.32           +22.6       34.87 ± 11%  perf-profile.calltrace.cycles-pp.do_rw_once
>>      54.79           -39.6       15.19 ±  4%  perf-profile.children.cycles-pp.filemap_map_pages
>>      44.39           -38.8        5.64 ±  3%  perf-profile.children.cycles-pp.next_uptodate_page
>>      69.96           -37.8       32.18 ±  3%  perf-profile.children.cycles-pp.xfs_filemap_map_pages
>>      75.69           -35.5       40.17 ±  7%  perf-profile.children.cycles-pp.do_fault
>>      76.93           -32.6       44.32 ±  7%  perf-profile.children.cycles-pp.__handle_mm_fault
>>      77.35           -32.4       44.94 ±  7%  perf-profile.children.cycles-pp.handle_mm_fault
>>      78.91           -25.5       53.46 ±  8%  perf-profile.children.cycles-pp.do_user_addr_fault
>>      78.93           -25.2       53.71 ±  8%  perf-profile.children.cycles-pp.exc_page_fault
>>      79.18           -25.1       54.10 ±  8%  perf-profile.children.cycles-pp.asm_exc_page_fault
>>      90.13           -16.3       73.82 ±  4%  perf-profile.children.cycles-pp.do_access
>>       1.75            -1.6        0.11 ± 25%  perf-profile.children.cycles-pp.folio_unlock
>>       1.96 ±  3%      -1.1        0.88 ± 15%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
>>       1.39 ±  4%      -0.7        0.74 ± 34%  perf-profile.children.cycles-pp.folio_wake_bit
>>       0.69 ±  2%      -0.6        0.11 ± 11%  perf-profile.children.cycles-pp.PageHeadHuge
>>       0.48            -0.4        0.03 ± 70%  perf-profile.children.cycles-pp.filemap_add_folio
>>       0.71 ±  9%      -0.4        0.28 ± 56%  perf-profile.children.cycles-pp.intel_idle
>>       0.86 ±  2%      -0.4        0.45 ± 31%  perf-profile.children.cycles-pp.__wake_up_common
>>       0.80 ±  3%      -0.4        0.41 ± 31%  perf-profile.children.cycles-pp.wake_page_function
>>       0.77 ±  3%      -0.4        0.39 ± 30%  perf-profile.children.cycles-pp.try_to_wake_up
>>       0.93 ±  9%      -0.3        0.62 ± 13%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
>>       0.54 ±  6%      -0.2        0.31 ± 37%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
>>       0.46 ±  9%      -0.2        0.26 ± 43%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
>>       0.35 ±  3%      -0.2        0.17 ± 29%  perf-profile.children.cycles-pp.ttwu_do_activate
>>       1.49 ±  2%      -0.2        1.32        perf-profile.children.cycles-pp.page_add_file_rmap
>>       0.61 ±  8%      -0.2        0.43 ± 15%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
>>       0.60 ±  9%      -0.2        0.43 ± 15%  perf-profile.children.cycles-pp.hrtimer_interrupt
>>       0.58 ±  3%      -0.2        0.41 ± 32%  perf-profile.children.cycles-pp.schedule_idle
>>       0.30 ±  2%      -0.2        0.14 ± 31%  perf-profile.children.cycles-pp.enqueue_task_fair
>>       0.27 ±  4%      -0.1        0.12 ± 36%  perf-profile.children.cycles-pp.pick_next_task_fair
>>       0.27 ±  3%      -0.1        0.14 ± 30%  perf-profile.children.cycles-pp.dequeue_task_fair
>>       0.29 ± 15%      -0.1        0.17 ± 14%  perf-profile.children.cycles-pp.irq_exit_rcu
>>       0.22 ±  2%      -0.1        0.11 ± 30%  perf-profile.children.cycles-pp.enqueue_entity
>>       0.39 ± 11%      -0.1        0.28 ± 16%  perf-profile.children.cycles-pp.__hrtimer_run_queues
>>       0.22 ±  6%      -0.1        0.11 ± 17%  perf-profile.children.cycles-pp.update_load_avg
>>       0.23 ±  3%      -0.1        0.12 ± 29%  perf-profile.children.cycles-pp.dequeue_entity
>>       0.21 ±  2%      -0.1        0.10 ± 19%  perf-profile.children.cycles-pp.read_pages
>>       0.31 ± 17%      -0.1        0.21 ± 17%  perf-profile.children.cycles-pp.update_process_times
>>       0.20 ±  2%      -0.1        0.10 ± 19%  perf-profile.children.cycles-pp.iomap_readahead
>>       0.24 ± 17%      -0.1        0.14 ± 15%  perf-profile.children.cycles-pp.__softirqentry_text_start
>>       0.32 ± 18%      -0.1        0.23 ± 16%  perf-profile.children.cycles-pp.tick_sched_timer
>>       0.31 ± 17%      -0.1        0.21 ± 17%  perf-profile.children.cycles-pp.tick_sched_handle
>>       0.26 ±  6%      -0.1        0.17 ± 38%  perf-profile.children.cycles-pp._raw_spin_lock_irq
>>       0.14 ±  5%      -0.1        0.06 ± 13%  perf-profile.children.cycles-pp.asm_sysvec_call_function
>>       0.12 ±  8%      -0.1        0.04 ± 73%  perf-profile.children.cycles-pp.newidle_balance
>>       0.21 ± 16%      -0.1        0.14 ± 17%  perf-profile.children.cycles-pp.scheduler_tick
>>       0.16 ± 16%      -0.1        0.09 ± 10%  perf-profile.children.cycles-pp.rebalance_domains
>>       0.11 ± 11%      -0.1        0.04 ± 70%  perf-profile.children.cycles-pp.irqtime_account_irq
>>       0.10 ±  4%      -0.1        0.04 ± 70%  perf-profile.children.cycles-pp.select_task_rq_fair
>>       0.10 ±  8%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.set_next_entity
>>       0.13 ±  7%      -0.1        0.07 ± 23%  perf-profile.children.cycles-pp.update_curr
>>       0.14 ± 13%      -0.1        0.08 ± 12%  perf-profile.children.cycles-pp._raw_spin_trylock
>>       0.16 ± 17%      -0.1        0.10 ± 19%  perf-profile.children.cycles-pp.task_tick_fair
>>       1.54 ±  2%      -0.1        1.48        perf-profile.children.cycles-pp.do_set_pte
>>       0.12            -0.1        0.07 ± 70%  perf-profile.children.cycles-pp.switch_mm_irqs_off
>>       0.10 ±  4%      -0.0        0.05 ± 70%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
>>       0.14 ±  5%      -0.0        0.09 ± 33%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
>>       0.11 ± 11%      -0.0        0.07 ± 11%  perf-profile.children.cycles-pp.folio_memcg_lock
>>       0.09 ±  9%      -0.0        0.05 ± 71%  perf-profile.children.cycles-pp.update_rq_clock
>>       0.18            -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.sync_regs
>>       0.21            -0.0        0.19 ±  2%  perf-profile.children.cycles-pp.error_entry
>>       0.07            +0.0        0.08        perf-profile.children.cycles-pp.___perf_sw_event
>>       0.07            +0.0        0.11        perf-profile.children.cycles-pp.__perf_sw_event
>>       0.02 ±141%      +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.__memcg_kmem_charge_page
>>       0.00            +0.1        0.05        perf-profile.children.cycles-pp.unlock_page_memcg
>>       0.00            +0.1        0.07 ± 23%  perf-profile.children.cycles-pp.memset_erms
>>       0.00            +0.1        0.07 ± 11%  perf-profile.children.cycles-pp.ondemand_readahead
>>       0.00            +0.1        0.07        perf-profile.children.cycles-pp.pmd_install
>>       0.12 ±  4%      +0.1        0.21 ± 27%  perf-profile.children.cycles-pp.finish_fault
>>       0.35            +0.2        0.50 ±  6%  perf-profile.children.cycles-pp._raw_spin_lock
>>       0.24 ±  6%      +0.3        0.51 ± 20%  perf-profile.children.cycles-pp.native_irq_return_iret
>>       0.38 ±  9%      +0.5        0.87 ± 36%  perf-profile.children.cycles-pp.finish_task_switch
>>       0.17 ± 29%      +0.5        0.71 ± 62%  perf-profile.children.cycles-pp.find_vma
>>       8.29 ±  4%      +1.1        9.36 ±  9%  perf-profile.children.cycles-pp.down_read
>>       5.10            +1.1        6.22 ±  5%  perf-profile.children.cycles-pp.xas_start
>>       6.58            +1.1        7.71 ±  4%  perf-profile.children.cycles-pp.xfs_iunlock
>>       5.20            +1.2        6.36 ±  5%  perf-profile.children.cycles-pp.xas_load
>>       4.20            +1.2        5.39 ±  2%  perf-profile.children.cycles-pp.xas_find
>>       6.94            +3.6       10.58 ±  6%  perf-profile.children.cycles-pp.up_read
>>       0.74 ± 21%      +3.8        4.53 ± 18%  perf-profile.children.cycles-pp.down_read_trylock
>>      10.62           +23.3       33.93 ± 13%  perf-profile.children.cycles-pp.do_rw_once
>>      43.93           -38.4        5.53 ±  3%  perf-profile.self.cycles-pp.next_uptodate_page
>>       1.73            -1.6        0.10 ± 29%  perf-profile.self.cycles-pp.folio_unlock
>>       0.68            -0.6        0.10 ± 14%  perf-profile.self.cycles-pp.PageHeadHuge
>>       0.70 ±  9%      -0.4        0.28 ± 56%  perf-profile.self.cycles-pp.intel_idle
>>       1.32            -0.2        1.12 ±  2%  perf-profile.self.cycles-pp.page_add_file_rmap
>>       0.46 ±  9%      -0.2        0.25 ± 46%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
>>       0.13 ±  9%      -0.1        0.05 ±  8%  perf-profile.self.cycles-pp.__count_memcg_events
>>       0.17 ±  4%      -0.1        0.09 ± 33%  perf-profile.self.cycles-pp._raw_spin_lock_irq
>>       0.09 ± 18%      -0.1        0.03 ± 70%  perf-profile.self.cycles-pp.irqtime_account_irq
>>       0.14 ± 13%      -0.1        0.08 ± 12%  perf-profile.self.cycles-pp._raw_spin_trylock
>>       0.11 ± 11%      -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.folio_memcg_lock
>>       0.11 ±  4%      -0.0        0.07 ± 70%  perf-profile.self.cycles-pp.switch_mm_irqs_off
>>       0.08 ±  5%      -0.0        0.04 ± 71%  perf-profile.self.cycles-pp.enqueue_entity
>>       0.07 ±  7%      -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.update_rq_clock
>>       0.18            -0.0        0.15 ±  3%  perf-profile.self.cycles-pp.sync_regs
>>       0.00            +0.1        0.07 ± 23%  perf-profile.self.cycles-pp.memset_erms
>>       0.00            +0.1        0.09 ± 18%  perf-profile.self.cycles-pp.xas_find
>>       0.03 ± 70%      +0.1        0.16 ±  7%  perf-profile.self.cycles-pp.do_set_pte
>>       0.33            +0.2        0.49 ±  5%  perf-profile.self.cycles-pp._raw_spin_lock
>>       0.00            +0.2        0.25 ± 22%  perf-profile.self.cycles-pp.exc_page_fault
>>       0.24 ±  6%      +0.3        0.51 ± 20%  perf-profile.self.cycles-pp.native_irq_return_iret
>>       0.28 ±  7%      +0.3        0.57 ± 35%  perf-profile.self.cycles-pp.__schedule
>>       0.25 ± 10%      +0.5        0.75 ± 37%  perf-profile.self.cycles-pp.finish_task_switch
>>       0.87 ±  3%      +1.0        1.91 ± 14%  perf-profile.self.cycles-pp.filemap_map_pages
>>       8.19 ±  4%      +1.1        9.27 ±  9%  perf-profile.self.cycles-pp.down_read
>>       2.01 ±  2%      +1.1        3.13 ± 23%  perf-profile.self.cycles-pp.filemap_fault
>>       5.05            +1.1        6.18 ±  5%  perf-profile.self.cycles-pp.xas_start
>>       1.21 ± 22%      +2.9        4.08 ± 11%  perf-profile.self.cycles-pp.__handle_mm_fault
>>       6.87            +3.6       10.51 ±  6%  perf-profile.self.cycles-pp.up_read
>>       0.73 ± 21%      +3.8        4.50 ± 18%  perf-profile.self.cycles-pp.down_read_trylock
>>       9.43            +4.7       14.14 ±  6%  perf-profile.self.cycles-pp.do_access
>>       7.58           +20.1       27.67 ± 16%  perf-profile.self.cycles-pp.do_rw_once
>>
>>
>>
>> ***************************************************************************************************
>> lkp-ivb-2ep1: 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz with 112G memory
>> =========================================================================================
>> compiler/cpufreq_governor/kconfig/rootfs/runtime/tbox_group/test/testcase/ucode:
>>   gcc-9/performance/x86_64-rhel-8.3/debian-10.4-x86_64-20200603.cgz/300s/lkp-ivb-2ep1/migrate/vm-scalability/0x42e
>>
>> commit: 
>>   18788cfa23 ("mm: Support arbitrary THP sizes")
>>   793917d997 ("mm/readahead: Add large folio readahead")
>>
>> 18788cfa23696774 793917d997df2e432f3e9ac126e 
>> ---------------- --------------------------- 
>>          %stddev     %change         %stddev
>>              \          |                \  
>>    1279697 ±  2%     +24.1%    1588230        vm-scalability.median
>>    1279697 ±  2%     +24.1%    1588230        vm-scalability.throughput
>>     627.91            -1.0%     621.31        vm-scalability.time.elapsed_time
>>     627.91            -1.0%     621.31        vm-scalability.time.elapsed_time.max
>>       6.24 ±  5%      -1.0        5.22 ±  5%  turbostat.Busy%
>>   33945569 ± 20%     +44.6%   49088231 ± 17%  turbostat.C6
>>    3642839           -96.6%     122845        numa-numastat.node0.interleave_hit
>>   12102273 ± 14%     -27.0%    8838437 ± 13%  numa-numastat.node0.numa_hit
>>    3665673           -96.7%     122772        numa-numastat.node1.interleave_hit
>>   18826459 ±  8%     -24.4%   14235613 ±  7%  numa-numastat.node1.numa_hit
>>      40872 ±  6%  +67564.4%   27656338        meminfo.Active
>>     217.20        +1.3e+07%   27613029        meminfo.Active(file)
>>   28240893           -97.1%     806140        meminfo.Inactive
>>   27927778           -98.2%     491393 ±  2%  meminfo.Inactive(file)
>>     627080           -15.9%     527421        meminfo.Mapped
>>      56525 ± 12%     -12.9%      49208 ±  4%  sched_debug.cfs_rq:/.min_vruntime.max
>>      64.98 ± 31%     -61.2%      25.18 ± 83%  sched_debug.cfs_rq:/.removed.runnable_avg.max
>>      12.77 ± 25%     -64.1%       4.58 ± 86%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
>>      55.55 ± 24%     -54.7%      25.18 ± 83%  sched_debug.cfs_rq:/.removed.util_avg.max
>>      11.42 ± 19%     -59.9%       4.58 ± 86%  sched_debug.cfs_rq:/.removed.util_avg.stddev
>>      24966 ± 36%     -39.8%      15027 ± 29%  sched_debug.cfs_rq:/.spread0.max
>>       6277 ± 55%  +2.2e+05%   13807856        numa-meminfo.node0.Active
>>     128.00        +1.1e+07%   13801812        numa-meminfo.node0.Active(file)
>>   14256136           -96.4%     508062 ±  6%  numa-meminfo.node0.Inactive
>>   13970347           -98.2%     245790 ±  2%  numa-meminfo.node0.Inactive(file)
>>     329516           -15.4%     278703        numa-meminfo.node0.Mapped
>>      34559 ± 14%  +39944.8%   13839251        numa-meminfo.node1.Active
>>      89.00 ±  2%  +1.6e+07%   13801956        numa-meminfo.node1.Active(file)
>>   13998562           -97.9%     298543 ± 10%  numa-meminfo.node1.Inactive
>>   13971170           -98.2%     245871        numa-meminfo.node1.Inactive(file)
>>     297635           -16.3%     249066 ±  2%  numa-meminfo.node1.Mapped
>>      53.60        +1.3e+07%    6902228        proc-vmstat.nr_active_file
>>    6981859           -98.2%     122915        proc-vmstat.nr_inactive_file
>>     156878           -15.7%     132188        proc-vmstat.nr_mapped
>>      26257            +7.1%      28123        proc-vmstat.nr_slab_unreclaimable
>>      53.60        +1.3e+07%    6902228        proc-vmstat.nr_zone_active_file
>>    6981859           -98.2%     122915        proc-vmstat.nr_zone_inactive_file
>>   30931182           -25.4%   23076379 ±  3%  proc-vmstat.numa_hit
>>    7308513           -96.6%     245617        proc-vmstat.numa_interleave
>>   24103602 ±  2%     -18.4%   19671160 ±  3%  proc-vmstat.numa_local
>>    6826723 ±  9%     -50.1%    3404877 ± 12%  proc-vmstat.numa_other
>>      66066        +10919.7%    7280270        proc-vmstat.pgactivate
>>      32.00        +1.1e+07%    3451480        numa-vmstat.node0.nr_active_file
>>    3491772           -98.2%      61446        numa-vmstat.node0.nr_inactive_file
>>      82425           -15.2%      69909        numa-vmstat.node0.nr_mapped
>>      32.00        +1.1e+07%    3451480        numa-vmstat.node0.nr_zone_active_file
>>    3491772           -98.2%      61446        numa-vmstat.node0.nr_zone_inactive_file
>>   12101625 ± 14%     -27.0%    8837704 ± 13%  numa-vmstat.node0.numa_hit
>>    3642839           -96.6%     122845        numa-vmstat.node0.numa_interleave
>>      21.60 ±  2%  +1.6e+07%    3451528        numa-vmstat.node1.nr_active_file
>>    3491978           -98.2%      61461        numa-vmstat.node1.nr_inactive_file
>>      74233           -16.1%      62260        numa-vmstat.node1.nr_mapped
>>      21.60 ±  2%  +1.6e+07%    3451528        numa-vmstat.node1.nr_zone_active_file
>>    3491978           -98.2%      61461        numa-vmstat.node1.nr_zone_inactive_file
>>   18825701 ±  8%     -24.4%   14234723 ±  7%  numa-vmstat.node1.numa_hit
>>    3665673           -96.7%     122772        numa-vmstat.node1.numa_interleave
>>      40.20 ±  7%     +28.4%      51.60 ±  3%  perf-stat.i.MPKI
>>  4.844e+08            -4.1%  4.644e+08        perf-stat.i.branch-instructions
>>       9.15 ±  5%      +1.5       10.66        perf-stat.i.branch-miss-rate%
>>      19.69 ±  5%      +2.0       21.69 ±  5%  perf-stat.i.cache-miss-rate%
>>    8672757 ± 11%     +28.2%   11114804 ± 11%  perf-stat.i.cache-misses
>>   49731408 ±  4%     +12.4%   55875231 ±  5%  perf-stat.i.cache-references
>>     765.32 ±  9%     -22.8%     590.45 ±  4%  perf-stat.i.cycles-between-cache-misses
>>       1.15 ±  5%      +0.2        1.30 ±  2%  perf-stat.i.dTLB-load-miss-rate%
>>       0.18 ±  2%      +0.0        0.20        perf-stat.i.dTLB-store-miss-rate%
>>     811798 ±  7%     +18.5%     962255 ±  8%  perf-stat.i.dTLB-store-misses
>>      90.13            +2.5       92.64        perf-stat.i.iTLB-load-miss-rate%
>>     162262 ±  8%     -21.6%     127248 ± 16%  perf-stat.i.iTLB-loads
>>  2.198e+09            -4.5%  2.099e+09        perf-stat.i.instructions
>>     374.33 ±  6%     +21.9%     456.27 ± 10%  perf-stat.i.metric.K/sec
>>     898067 ±  4%     +17.5%    1055190 ±  3%  perf-stat.i.node-stores
>>      22.64 ±  6%     +17.5%      26.62 ±  5%  perf-stat.overall.MPKI
>>      17.39 ±  6%      +2.4       19.83 ±  6%  perf-stat.overall.cache-miss-rate%
>>     731.03 ±  8%     -22.9%     563.68 ±  5%  perf-stat.overall.cycles-between-cache-misses
>>       0.17 ±  3%      +0.0        0.19 ±  2%  perf-stat.overall.dTLB-store-miss-rate%
>>      90.01            +1.8       91.84        perf-stat.overall.iTLB-load-miss-rate%
>>      34.37            -3.0       31.41        perf-stat.overall.node-store-miss-rate%
>>      42785            -5.6%      40397        perf-stat.overall.path-length
>>  4.838e+08            -4.1%  4.638e+08        perf-stat.ps.branch-instructions
>>    8662103 ± 11%     +28.2%   11100817 ± 11%  perf-stat.ps.cache-misses
>>   49649551 ±  4%     +12.3%   55779056 ±  5%  perf-stat.ps.cache-references
>>     810507 ±  7%     +18.5%     960597 ±  8%  perf-stat.ps.dTLB-store-misses
>>     162062 ±  8%     -21.6%     127036 ± 16%  perf-stat.ps.iTLB-loads
>>  2.195e+09            -4.5%  2.096e+09        perf-stat.ps.instructions
>>     898053 ±  4%     +17.5%    1055430 ±  3%  perf-stat.ps.node-stores
>>  1.389e+12            -5.6%  1.311e+12        perf-stat.total.instructions
>>       1.48 ±  8%      -0.4        1.04 ±  4%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork
>>       1.69 ± 19%      -0.4        1.29 ±  8%  perf-profile.calltrace.cycles-pp.fork
>>       1.08 ± 12%      -0.4        0.69 ±  9%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit.drm_atomic_helper_dirtyfb.drm_fb_helper_damage_work.process_one_work.worker_thread
>>       1.08 ± 12%      -0.4        0.69 ±  9%  perf-profile.calltrace.cycles-pp.commit_tail.drm_atomic_helper_commit.drm_atomic_helper_dirtyfb.drm_fb_helper_damage_work.process_one_work
>>       1.08 ± 12%      -0.4        0.69 ±  9%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit_tail.commit_tail.drm_atomic_helper_commit.drm_atomic_helper_dirtyfb.drm_fb_helper_damage_work
>>       1.08 ± 12%      -0.4        0.69 ±  9%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail.commit_tail.drm_atomic_helper_commit.drm_atomic_helper_dirtyfb
>>       1.08 ± 12%      -0.4        0.69 ±  9%  perf-profile.calltrace.cycles-pp.mgag200_simple_display_pipe_update.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail.commit_tail.drm_atomic_helper_commit
>>       1.08 ± 12%      -0.4        0.69 ±  9%  perf-profile.calltrace.cycles-pp.mgag200_handle_damage.mgag200_simple_display_pipe_update.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail.commit_tail
>>       1.08 ± 12%      -0.4        0.69 ±  9%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_dirtyfb.drm_fb_helper_damage_work.process_one_work.worker_thread.kthread
>>       1.08 ± 12%      -0.4        0.69 ±  9%  perf-profile.calltrace.cycles-pp.drm_fb_memcpy_toio.mgag200_handle_damage.mgag200_simple_display_pipe_update.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail
>>       1.02 ± 13%      -0.4        0.64 ± 11%  perf-profile.calltrace.cycles-pp.memcpy_toio.drm_fb_memcpy_toio.mgag200_handle_damage.mgag200_simple_display_pipe_update.drm_atomic_helper_commit_planes
>>       1.09 ± 11%      -0.4        0.74 ±  5%  perf-profile.calltrace.cycles-pp.drm_fb_helper_damage_work.process_one_work.worker_thread.kthread.ret_from_fork
>>       0.59 ±  5%      +0.1        0.71 ±  9%  perf-profile.calltrace.cycles-pp.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
>>       0.57 ±  6%      +0.1        0.69 ±  8%  perf-profile.calltrace.cycles-pp.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
>>       1.48 ±  8%      -0.4        1.04 ±  4%  perf-profile.children.cycles-pp.process_one_work
>>       1.72 ± 19%      -0.4        1.30 ±  8%  perf-profile.children.cycles-pp.fork
>>       1.08 ± 12%      -0.4        0.69 ±  9%  perf-profile.children.cycles-pp.drm_atomic_helper_commit
>>       1.08 ± 12%      -0.4        0.69 ±  9%  perf-profile.children.cycles-pp.commit_tail
>>       1.08 ± 12%      -0.4        0.69 ±  9%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_tail
>>       1.08 ± 12%      -0.4        0.69 ±  9%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_planes
>>       1.08 ± 12%      -0.4        0.69 ±  9%  perf-profile.children.cycles-pp.mgag200_simple_display_pipe_update
>>       1.08 ± 12%      -0.4        0.69 ±  9%  perf-profile.children.cycles-pp.mgag200_handle_damage
>>       1.08 ± 12%      -0.4        0.69 ±  9%  perf-profile.children.cycles-pp.drm_atomic_helper_dirtyfb
>>       1.08 ± 12%      -0.4        0.69 ±  9%  perf-profile.children.cycles-pp.memcpy_toio
>>       1.08 ± 12%      -0.4        0.69 ±  9%  perf-profile.children.cycles-pp.drm_fb_memcpy_toio
>>       1.09 ± 11%      -0.4        0.74 ±  5%  perf-profile.children.cycles-pp.drm_fb_helper_damage_work
>>       0.45 ± 19%      -0.1        0.31 ± 19%  perf-profile.children.cycles-pp.finish_task_switch
>>       0.32 ± 19%      -0.1        0.20 ± 15%  perf-profile.children.cycles-pp.perf_iterate_sb
>>       0.50 ± 12%      -0.1        0.40 ±  8%  perf-profile.children.cycles-pp.native_irq_return_iret
>>       0.40 ± 14%      -0.1        0.31 ± 11%  perf-profile.children.cycles-pp.get_page_from_freelist
>>       0.35 ± 12%      -0.1        0.27 ± 16%  perf-profile.children.cycles-pp.perf_pmu_sched_task
>>       0.30 ± 15%      -0.1        0.22 ± 13%  perf-profile.children.cycles-pp.__perf_pmu_sched_task
>>       0.16 ±  8%      -0.1        0.11 ± 18%  perf-profile.children.cycles-pp.__close
>>       0.18 ± 21%      -0.1        0.13 ±  9%  perf-profile.children.cycles-pp.__get_vm_area_node
>>       0.11 ± 20%      -0.0        0.08 ± 15%  perf-profile.children.cycles-pp.__put_user_nocheck_4
>>       0.13 ± 14%      -0.0        0.10 ±  7%  perf-profile.children.cycles-pp.flush_tlb_func
>>       0.34 ± 12%      +0.1        0.44 ± 11%  perf-profile.children.cycles-pp.timerqueue_del
>>       0.61 ±  6%      +0.1        0.72 ±  8%  perf-profile.children.cycles-pp.irq_enter_rcu
>>       0.58 ±  6%      +0.1        0.70 ±  8%  perf-profile.children.cycles-pp.tick_irq_enter
>>       0.42 ± 12%      +0.1        0.54 ± 11%  perf-profile.children.cycles-pp.__remove_hrtimer
>>       0.60 ± 48%      -0.3        0.31 ± 15%  perf-profile.self.cycles-pp.rcu_sched_clock_irq
>>       0.85 ± 10%      -0.2        0.64 ± 10%  perf-profile.self.cycles-pp.memcpy_toio
>>       0.49 ± 11%      -0.1        0.40 ±  8%  perf-profile.self.cycles-pp.native_irq_return_iret
>>       0.25 ± 16%      -0.1        0.18 ± 22%  perf-profile.self.cycles-pp._dl_catch_error
>>       0.09 ± 13%      -0.0        0.05 ± 51%  perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
>>       0.15 ±  5%      -0.0        0.12 ± 18%  perf-profile.self.cycles-pp.update_load_avg
>>       0.11 ± 15%      +0.1        0.16 ± 18%  perf-profile.self.cycles-pp.timerqueue_del
>>
>>
>>
>> ***************************************************************************************************
>> lkp-csl-2ap4: 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
>> =========================================================================================
>> compiler/cpufreq_governor/kconfig/rootfs/runtime/tbox_group/test/testcase/ucode:
>>   gcc-9/performance/x86_64-rhel-8.3/debian-10.4-x86_64-20200603.cgz/300s/lkp-csl-2ap4/lru-file-mmap-read/vm-scalability/0x500320a
>>
>> commit: 
>>   18788cfa23 ("mm: Support arbitrary THP sizes")
>>   793917d997 ("mm/readahead: Add large folio readahead")
>>
>> 18788cfa23696774 793917d997df2e432f3e9ac126e 
>> ---------------- --------------------------- 
>>          %stddev     %change         %stddev
>>              \          |                \  
>>       0.10 ±  3%    +118.3%       0.22 ± 16%  vm-scalability.free_time
>>     101518 ±  2%     +42.3%     144417 ±  3%  vm-scalability.median
>>     411.17 ± 36%    +892.2        1303 ± 17%  vm-scalability.stddev%
>>   19593900           +45.0%   28415043 ±  3%  vm-scalability.throughput
>>     301.57           -34.4%     197.69 ±  2%  vm-scalability.time.elapsed_time
>>     301.57           -34.4%     197.69 ±  2%  vm-scalability.time.elapsed_time.max
>>     640209 ±  4%     -19.7%     514308 ± 10%  vm-scalability.time.involuntary_context_switches
>>      15114            +5.2%      15894        vm-scalability.time.percent_of_cpu_this_job_got
>>      42292           -35.8%      27163 ±  3%  vm-scalability.time.system_time
>>       3288 ±  4%     +29.7%       4264 ±  5%  vm-scalability.time.user_time
>>  1.085e+10 ±  3%     -51.9%  5.216e+09 ±  7%  cpuidle..time
>>   21205215 ± 12%     -48.5%   10910479 ±  5%  cpuidle..usage
>>     349.92           -29.7%     246.17        uptime.boot
>>      18808           -30.0%      13160 ±  4%  uptime.idle
>>       5.17 ±  7%    +109.7%      10.83 ±  3%  vmstat.cpu.us
>>   21348646           -41.2%   12548500 ±  5%  vmstat.memory.free
>>       5766 ±  4%     +23.5%       7120 ±  8%  vmstat.system.cs
>>  2.715e+08 ±  2%     -43.2%  1.542e+08 ±  6%  turbostat.IRQ
>>      33367 ± 25%     -64.5%      11839 ± 20%  turbostat.POLL
>>      43.50 ±  2%     +11.1%      48.33 ±  2%  turbostat.PkgTmp
>>     252.04            +6.8%     269.14        turbostat.PkgWatt
>>      18.99 ±  2%      -5.4       13.63 ±  8%  mpstat.cpu.all.idle%
>>       0.00 ± 31%      +0.0        0.01 ±106%  mpstat.cpu.all.iowait%
>>       1.08 ±  3%      +0.7        1.75 ±  7%  mpstat.cpu.all.irq%
>>       0.07 ±  3%      +0.1        0.14 ±  6%  mpstat.cpu.all.soft%
>>       5.82 ±  5%      +5.4       11.22 ±  4%  mpstat.cpu.all.usr%
>>     165900 ±  4%   +7920.0%   13305211 ± 12%  meminfo.Active
>>     160338 ±  4%     -63.9%      57831 ± 15%  meminfo.Active(anon)
>>       5561 ± 11%  +2.4e+05%   13247380 ± 12%  meminfo.Active(file)
>>     880618 ±  7%     -24.3%     666574 ±  2%  meminfo.Committed_AS
>>     569221 ± 11%     -22.3%     442282 ±  2%  meminfo.Inactive(anon)
>>   23000987 ±  3%     -46.2%   12372721 ±  4%  meminfo.MemFree
>>     388894           +16.7%     453885 ±  2%  meminfo.SUnreclaim
>>     422287 ± 14%     -55.5%     188091 ±  9%  meminfo.Shmem
>>  2.278e+08 ±  3%     -95.1%   11200440 ± 15%  numa-numastat.node0.local_node
>>   40532177 ± 14%     -90.8%    3741196 ± 21%  numa-numastat.node0.numa_foreign
>>  2.275e+08 ±  3%     -95.1%   11245827 ± 15%  numa-numastat.node0.numa_hit
>>   29443860 ± 13%     -83.7%    4811729 ± 27%  numa-numastat.node0.numa_miss
>>   29476169 ± 13%     -83.5%    4859208 ± 27%  numa-numastat.node0.other_node
>>  2.303e+08 ±  3%     -95.4%   10517523 ± 16%  numa-numastat.node1.local_node
>>   37621005 ± 13%     -88.6%    4292186 ± 19%  numa-numastat.node1.numa_foreign
>>  2.299e+08 ±  3%     -95.4%   10603099 ± 16%  numa-numastat.node1.numa_hit
>>   41991213 ± 19%     -90.5%    3972773 ± 19%  numa-numastat.node1.numa_miss
>>   42068264 ± 19%     -90.4%    4057461 ± 19%  numa-numastat.node1.other_node
>>  2.349e+08 ±  3%     -95.2%   11355001 ± 20%  numa-numastat.node2.local_node
>>   34589661 ± 21%     -88.3%    4047359 ± 16%  numa-numastat.node2.numa_foreign
>>  2.345e+08 ±  3%     -95.1%   11421655 ± 20%  numa-numastat.node2.numa_hit
>>   41161372 ± 19%     -91.1%    3677838 ± 19%  numa-numastat.node2.numa_miss
>>   41262019 ± 19%     -90.9%    3744731 ± 19%  numa-numastat.node2.other_node
>>  2.429e+08           -95.5%   10974126 ± 17%  numa-numastat.node3.local_node
>>   31729047 ± 13%     -86.9%    4152899 ± 24%  numa-numastat.node3.numa_foreign
>>  2.425e+08           -95.4%   11034785 ± 17%  numa-numastat.node3.numa_hit
>>   31871419 ±  7%     -88.2%    3769387 ± 24%  numa-numastat.node3.numa_miss
>>   31964737 ±  7%     -88.0%    3833705 ± 23%  numa-numastat.node3.other_node
>>      18558 ± 21%  +16974.0%    3168645 ± 14%  numa-meminfo.node0.Active
>>     736.50 ±109%  +4.3e+05%    3151953 ± 15%  numa-meminfo.node0.Active(file)
>>   34210000            +9.8%   37546409        numa-meminfo.node0.Mapped
>>    5885498 ±  5%     -46.0%    3176670 ±  4%  numa-meminfo.node0.MemFree
>>      17451 ± 43%  +18303.0%    3211606 ± 17%  numa-meminfo.node1.Active
>>      13751 ± 59%     -64.0%       4950 ± 54%  numa-meminfo.node1.Active(anon)
>>       3698 ± 33%  +86597.6%    3206655 ± 17%  numa-meminfo.node1.Active(file)
>>      86098 ± 84%     -81.2%      16195 ±100%  numa-meminfo.node1.Inactive(anon)
>>   36059221           +11.3%   40136100        numa-meminfo.node1.Mapped
>>    6127422 ±  6%     -48.4%    3164279 ±  5%  numa-meminfo.node1.MemFree
>>      79357 ± 69%     -90.4%       7595 ± 68%  numa-meminfo.node1.Shmem
>>       5745 ± 20%  +63238.1%    3639196 ± 20%  numa-meminfo.node2.Active
>>     432.83 ±111%  +8.4e+05%    3634730 ± 20%  numa-meminfo.node2.Active(file)
>>    5992877 ±  3%     -47.5%    3148114 ±  5%  numa-meminfo.node2.MemFree
>>      82044 ±  2%     +30.5%     107052 ± 14%  numa-meminfo.node2.SUnreclaim
>>     127440 ±  8%   +2819.6%    3720728 ± 14%  numa-meminfo.node3.Active
>>     126792 ±  7%     -74.1%      32868 ± 32%  numa-meminfo.node3.Active(anon)
>>     647.17 ± 88%  +5.7e+05%    3687859 ± 14%  numa-meminfo.node3.Active(file)
>>   35603773           +10.6%   39372854        numa-meminfo.node3.Mapped
>>    6060136 ±  4%     -47.8%    3163708 ±  6%  numa-meminfo.node3.MemFree
>>     174654 ± 21%     -55.6%      77594 ± 59%  numa-meminfo.node3.Shmem
>>      29.60 ± 15%     +20.6%      35.71 ±  9%  sched_debug.cfs_rq:/.load_avg.avg
>>   23054096 ± 12%     -46.9%   12234921 ± 16%  sched_debug.cfs_rq:/.min_vruntime.avg
>>   23762670 ± 12%     -46.6%   12697185 ± 16%  sched_debug.cfs_rq:/.min_vruntime.max
>>   19343278 ± 15%     -61.2%    7508563 ± 23%  sched_debug.cfs_rq:/.min_vruntime.min
>>    1484122 ± 52%     -67.1%     487970 ± 52%  sched_debug.cfs_rq:/.spread0.max
>>     768.96 ±  6%     -33.8%     509.26 ± 11%  sched_debug.cfs_rq:/.util_est_enqueued.avg
>>     186.50 ± 14%     +68.2%     313.61 ± 11%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
>>     836130 ±  4%     +12.9%     943827 ±  3%  sched_debug.cpu.avg_idle.avg
>>    1477455 ± 18%     +82.9%    2702269 ± 24%  sched_debug.cpu.avg_idle.max
>>     143256 ± 15%     +91.3%     274043 ± 25%  sched_debug.cpu.avg_idle.min
>>     168476 ± 10%     -33.2%     112500 ± 11%  sched_debug.cpu.clock.avg
>>     168594 ± 10%     -33.2%     112546 ± 11%  sched_debug.cpu.clock.max
>>     168368 ± 10%     -33.2%     112436 ± 11%  sched_debug.cpu.clock.min
>>     167148 ± 10%     -33.5%     111146 ± 10%  sched_debug.cpu.clock_task.avg
>>     167428 ± 10%     -33.4%     111447 ± 10%  sched_debug.cpu.clock_task.max
>>     157510 ± 10%     -34.9%     102572 ± 11%  sched_debug.cpu.clock_task.min
>>      10904 ±  6%     -13.6%       9420 ±  4%  sched_debug.cpu.curr->pid.max
>>     779426 ± 22%     +69.3%    1319881 ± 25%  sched_debug.cpu.max_idle_balance_cost.max
>>      22416 ± 61%    +282.2%      85670 ± 44%  sched_debug.cpu.max_idle_balance_cost.stddev
>>       6379 ±  6%     -31.4%       4375 ±  9%  sched_debug.cpu.nr_switches.avg
>>       3704 ±  7%     -43.7%       2086 ± 15%  sched_debug.cpu.nr_switches.min
>>     168334 ± 10%     -33.2%     112430 ± 11%  sched_debug.cpu_clk
>>     167321 ± 10%     -33.4%     111418 ± 11%  sched_debug.ktime
>>     168815 ± 10%     -32.5%     113880 ± 10%  sched_debug.sched_clk
>>       2616 ±  9%     +46.3%       3827 ± 14%  proc-vmstat.allocstall_normal
>>    2156058 ± 15%   +4474.3%   98624936 ± 55%  proc-vmstat.compact_daemon_migrate_scanned
>>      20.00 ± 38%  +2.4e+05%      48248 ± 40%  proc-vmstat.compact_fail
>>    8500358 ±  8%     -73.3%    2268228 ± 46%  proc-vmstat.compact_isolated
>>   10223131 ±  8%   +3370.9%  3.548e+08 ± 61%  proc-vmstat.compact_migrate_scanned
>>      27.00 ± 46%  +9.8e+05%     265302 ± 36%  proc-vmstat.compact_stall
>>       7.00 ± 73%  +3.1e+06%     217053 ± 36%  proc-vmstat.compact_success
>>     823.33 ±  4%   +1193.8%      10652 ± 56%  proc-vmstat.kswapd_low_wmark_hit_quickly
>>      41044 ±  4%     -64.6%      14549 ± 15%  proc-vmstat.nr_active_anon
>>       1387 ± 11%  +2.4e+05%    3353262 ± 12%  proc-vmstat.nr_active_file
>>   41328974            +6.4%   43963911        proc-vmstat.nr_file_pages
>>    5852009 ±  2%     -46.9%    3109416 ±  4%  proc-vmstat.nr_free_pages
>>     142808 ± 11%     -22.5%     110708 ±  2%  proc-vmstat.nr_inactive_anon
>>       1075 ±  3%     -32.2%     728.67 ± 10%  proc-vmstat.nr_isolated_file
>>      35690            +2.4%      36540        proc-vmstat.nr_kernel_stack
>>   35775593            +9.8%   39287167        proc-vmstat.nr_mapped
>>     869101            +5.6%     917415 ±  2%  proc-vmstat.nr_page_table_pages
>>     107130 ± 15%     -55.9%      47235 ±  9%  proc-vmstat.nr_shmem
>>      97259           +16.7%     113507 ±  2%  proc-vmstat.nr_slab_unreclaimable
>>      41046 ±  4%     -64.5%      14554 ± 15%  proc-vmstat.nr_zone_active_anon
>>       1387 ± 11%  +2.4e+05%    3353349 ± 12%  proc-vmstat.nr_zone_active_file
>>     142851 ± 11%     -22.5%     110765 ±  2%  proc-vmstat.nr_zone_inactive_anon
>>  1.445e+08 ± 14%     -88.8%   16233642 ± 19%  proc-vmstat.numa_foreign
>>      80928 ± 55%     -74.9%      20329 ± 20%  proc-vmstat.numa_hint_faults
>>      40260 ± 38%     -71.4%      11516 ± 32%  proc-vmstat.numa_hint_faults_local
>>  9.344e+08 ±  2%     -95.3%   44308201 ± 16%  proc-vmstat.numa_hit
>>  9.359e+08 ±  2%     -95.3%   44049923 ± 16%  proc-vmstat.numa_local
>>  1.445e+08 ± 14%     -88.8%   16231729 ± 19%  proc-vmstat.numa_miss
>>  1.448e+08 ± 14%     -88.6%   16495107 ± 19%  proc-vmstat.numa_other
>>     411268 ± 14%     -51.4%     199735 ± 35%  proc-vmstat.numa_pte_updates
>>       2547 ±  2%    +339.4%      11194 ± 53%  proc-vmstat.pageoutrun
>>     254135 ± 15%  +14971.1%   38301088 ±  5%  proc-vmstat.pgactivate
>>    8098345           +12.0%    9067933 ±  4%  proc-vmstat.pgalloc_dma32
>>    4244635 ±  8%     -73.7%    1116248 ± 46%  proc-vmstat.pgmigrate_success
>>       2415            -1.5%       2380        proc-vmstat.pgpgout
>>      86990 ±  2%     -23.8%      66253 ±  2%  proc-vmstat.pgreuse
>>   1.85e+09           -24.6%  1.396e+09 ±  7%  proc-vmstat.pgscan_direct
>>       2175 ± 16%     -94.3%     124.67 ± 32%  proc-vmstat.pgscan_direct_throttle
>>  1.965e+08 ± 16%    +239.4%  6.671e+08 ± 14%  proc-vmstat.pgscan_kswapd
>>  9.921e+08            -4.0%  9.527e+08        proc-vmstat.pgsteal_direct
>>   34748892 ±  2%    +116.7%   75306059 ±  7%  proc-vmstat.pgsteal_kswapd
>>    4957012            -8.8%    4522105 ±  2%  proc-vmstat.workingset_nodereclaim
>>       4020 ± 17%     -59.1%       1644 ± 74%  proc-vmstat.workingset_refault_file
>>     183.17 ±109%  +4.5e+05%     821995 ± 14%  numa-vmstat.node0.nr_active_file
>>    1519607 ±  6%     -45.2%     832457 ±  4%  numa-vmstat.node0.nr_free_pages
>>    8464904           +10.0%    9312159        numa-vmstat.node0.nr_mapped
>>     183.17 ±109%  +4.5e+05%     822014 ± 14%  numa-vmstat.node0.nr_zone_active_file
>>   40532177 ± 14%     -90.8%    3741196 ± 21%  numa-vmstat.node0.numa_foreign
>>  2.275e+08 ±  3%     -95.1%   11245235 ± 15%  numa-vmstat.node0.numa_hit
>>  2.278e+08 ±  3%     -95.1%   11199848 ± 15%  numa-vmstat.node0.numa_local
>>   29443860 ± 13%     -83.7%    4811729 ± 27%  numa-vmstat.node0.numa_miss
>>   29476169 ± 13%     -83.5%    4859208 ± 27%  numa-vmstat.node0.numa_other
>>       3499 ± 59%     -63.4%       1280 ± 53%  numa-vmstat.node1.nr_active_anon
>>     922.83 ± 33%  +90476.4%     835869 ± 17%  numa-vmstat.node1.nr_active_file
>>    1586446 ±  5%     -47.8%     827706 ±  5%  numa-vmstat.node1.nr_free_pages
>>      21322 ± 84%     -81.0%       4042 ±100%  numa-vmstat.node1.nr_inactive_anon
>>     254.17 ±  5%     -24.0%     193.17 ±  8%  numa-vmstat.node1.nr_isolated_file
>>    8919519           +11.6%    9957601        numa-vmstat.node1.nr_mapped
>>      19735 ± 68%     -90.1%       1947 ± 67%  numa-vmstat.node1.nr_shmem
>>       3500 ± 59%     -63.4%       1281 ± 53%  numa-vmstat.node1.nr_zone_active_anon
>>     923.00 ± 33%  +90460.5%     835873 ± 17%  numa-vmstat.node1.nr_zone_active_file
>>      21334 ± 83%     -81.0%       4056 ±100%  numa-vmstat.node1.nr_zone_inactive_anon
>>   37621005 ± 13%     -88.6%    4292186 ± 19%  numa-vmstat.node1.numa_foreign
>>  2.299e+08 ±  3%     -95.4%   10603128 ± 16%  numa-vmstat.node1.numa_hit
>>  2.303e+08 ±  3%     -95.4%   10517553 ± 16%  numa-vmstat.node1.numa_local
>>   41991213 ± 19%     -90.5%    3972773 ± 19%  numa-vmstat.node1.numa_miss
>>   42068264 ± 19%     -90.4%    4057461 ± 19%  numa-vmstat.node1.numa_other
>>    1268948 ±  4%     -17.2%    1051134 ±  9%  numa-vmstat.node1.workingset_nodereclaim
>>       3123 ± 50%     -84.8%     476.17 ±183%  numa-vmstat.node1.workingset_refault_file
>>     107.83 ±111%  +8.8e+05%     944107 ± 20%  numa-vmstat.node2.nr_active_file
>>    1554237 ±  2%     -46.9%     826010 ±  5%  numa-vmstat.node2.nr_free_pages
>>     277.50 ±  3%     -45.2%     152.17 ± 11%  numa-vmstat.node2.nr_isolated_file
>>      20516 ±  2%     +30.5%      26769 ± 14%  numa-vmstat.node2.nr_slab_unreclaimable
>>     107.83 ±111%  +8.8e+05%     944108 ± 20%  numa-vmstat.node2.nr_zone_active_file
>>   34589661 ± 21%     -88.3%    4047359 ± 16%  numa-vmstat.node2.numa_foreign
>>  2.345e+08 ±  3%     -95.1%   11421811 ± 20%  numa-vmstat.node2.numa_hit
>>  2.349e+08 ±  3%     -95.2%   11355157 ± 20%  numa-vmstat.node2.numa_local
>>   41161372 ± 19%     -91.1%    3677838 ± 19%  numa-vmstat.node2.numa_miss
>>   41262019 ± 19%     -90.9%    3744731 ± 19%  numa-vmstat.node2.numa_other
>>    1263735 ±  6%     -10.7%    1128659 ±  4%  numa-vmstat.node2.workingset_nodereclaim
>>      31933 ±  7%     -73.0%       8623 ± 34%  numa-vmstat.node3.nr_active_anon
>>     161.00 ± 88%    +6e+05%     961368 ± 14%  numa-vmstat.node3.nr_active_file
>>    1568641 ±  4%     -47.2%     828497 ±  5%  numa-vmstat.node3.nr_free_pages
>>     264.00 ±  9%     -44.3%     147.00 ± 14%  numa-vmstat.node3.nr_isolated_file
>>    8802026           +10.9%    9759037        numa-vmstat.node3.nr_mapped
>>      43822 ± 20%     -54.4%      20003 ± 57%  numa-vmstat.node3.nr_shmem
>>      31933 ±  7%     -73.0%       8625 ± 34%  numa-vmstat.node3.nr_zone_active_anon
>>     161.00 ± 88%    +6e+05%     961370 ± 14%  numa-vmstat.node3.nr_zone_active_file
>>   31729047 ± 13%     -86.9%    4152899 ± 24%  numa-vmstat.node3.numa_foreign
>>  2.425e+08           -95.5%   11033782 ± 17%  numa-vmstat.node3.numa_hit
>>  2.429e+08           -95.5%   10973124 ± 17%  numa-vmstat.node3.numa_local
>>   31871419 ±  7%     -88.2%    3769387 ± 24%  numa-vmstat.node3.numa_miss
>>   31964738 ±  7%     -88.0%    3833705 ± 23%  numa-vmstat.node3.numa_other
>>  2.978e+10           +13.3%  3.375e+10        perf-stat.i.branch-instructions
>>   32180693 ±  4%     -14.4%   27541092 ±  7%  perf-stat.i.branch-misses
>>   5.15e+08 ±  3%     +19.6%   6.16e+08 ±  4%  perf-stat.i.cache-references
>>       5528 ±  4%     +30.5%       7216 ± 10%  perf-stat.i.context-switches
>>       4.07            +6.5%       4.33 ±  3%  perf-stat.i.cpi
>>  4.639e+11            +8.0%  5.009e+11        perf-stat.i.cpu-cycles
>>     270.77            +9.2%     295.80 ±  4%  perf-stat.i.cpu-migrations
>>   14735665 ±  5%     -32.1%    9999207 ±  8%  perf-stat.i.dTLB-load-misses
>>  2.788e+10            +4.1%  2.903e+10        perf-stat.i.dTLB-loads
>>       0.01 ± 29%      +0.0        0.02 ± 10%  perf-stat.i.dTLB-store-miss-rate%
>>     838683 ±  5%     +22.9%    1030872 ±  3%  perf-stat.i.dTLB-store-misses
>>  6.544e+09           -30.2%  4.568e+09 ±  2%  perf-stat.i.dTLB-stores
>>    3574432           +25.9%    4499739 ±  6%  perf-stat.i.iTLB-load-misses
>>  1.084e+11            +4.2%   1.13e+11        perf-stat.i.instructions
>>      29122           -15.1%      24732 ±  6%  perf-stat.i.instructions-per-iTLB-miss
>>       0.35 ±  4%     -20.1%       0.28 ±  6%  perf-stat.i.ipc
>>     111142           +51.4%     168291 ±  2%  perf-stat.i.major-faults
>>       2.39            +7.8%       2.58        perf-stat.i.metric.GHz
>>     332.60            +5.1%     349.53        perf-stat.i.metric.M/sec
>>     219873 ±  2%     +51.0%     331983 ±  2%  perf-stat.i.minor-faults
>>   18812619 ±  3%     +50.5%   28318976 ± 10%  perf-stat.i.node-load-misses
>>    4668466 ±  6%     +72.7%    8060213 ± 11%  perf-stat.i.node-loads
>>      60.86           +19.9       80.75        perf-stat.i.node-store-miss-rate%
>>   11184776 ±  3%     -70.5%    3297078 ±  4%  perf-stat.i.node-stores
>>     331016           +51.1%     500275 ±  2%  perf-stat.i.page-faults
>>       4.70           +15.5%       5.43 ±  3%  perf-stat.overall.MPKI
>>       0.11 ±  3%      -0.0        0.08 ±  7%  perf-stat.overall.branch-miss-rate%
>>      31.24            -1.6       29.60 ±  2%  perf-stat.overall.cache-miss-rate%
>>       0.05 ±  5%      -0.0        0.03 ±  7%  perf-stat.overall.dTLB-load-miss-rate%
>>       0.01 ±  3%      +0.0        0.02 ±  3%  perf-stat.overall.dTLB-store-miss-rate%
>>      30846           -17.5%      25451 ±  6%  perf-stat.overall.instructions-per-iTLB-miss
>>      54.45           +26.4       80.82        perf-stat.overall.node-store-miss-rate%
>>       6878           -32.1%       4673        perf-stat.overall.path-length
>>   3.01e+10           +12.7%  3.391e+10        perf-stat.ps.branch-instructions
>>   32017180 ±  4%     -15.6%   27019688 ±  7%  perf-stat.ps.branch-misses
>>  5.163e+08 ±  2%     +19.4%  6.167e+08 ±  4%  perf-stat.ps.cache-references
>>       5664 ±  4%     +23.3%       6986 ±  9%  perf-stat.ps.context-switches
>>  4.801e+11            +5.8%  5.079e+11        perf-stat.ps.cpu-cycles
>>     269.63            +6.4%     286.97 ±  4%  perf-stat.ps.cpu-migrations
>>   15001073 ±  5%     -32.9%   10065925 ±  8%  perf-stat.ps.dTLB-load-misses
>>  2.823e+10            +3.4%  2.918e+10        perf-stat.ps.dTLB-loads
>>     840470 ±  4%     +22.8%    1031964 ±  3%  perf-stat.ps.dTLB-store-misses
>>  6.581e+09           -30.6%   4.57e+09 ±  2%  perf-stat.ps.dTLB-stores
>>    3558560           +25.8%    4478004 ±  6%  perf-stat.ps.iTLB-load-misses
>>  1.098e+11            +3.4%  1.135e+11        perf-stat.ps.instructions
>>     110858           +52.3%     168813 ±  2%  perf-stat.ps.major-faults
>>     219045           +51.8%     332439 ±  2%  perf-stat.ps.minor-faults
>>   18998997 ±  3%     +49.3%   28360434 ± 10%  perf-stat.ps.node-load-misses
>>    4608425 ±  6%     +71.4%    7899142 ± 10%  perf-stat.ps.node-loads
>>   11135414 ±  3%     -70.6%    3278444 ±  4%  perf-stat.ps.node-stores
>>     329904           +51.9%     501252 ±  2%  perf-stat.ps.page-faults
>>  3.324e+13           -32.1%  2.258e+13        perf-stat.total.instructions
>>      88.08           -62.2       25.91 ± 39%  perf-profile.calltrace.cycles-pp.page_cache_ra_unbounded.filemap_fault.__xfs_filemap_fault.__do_fault.do_fault
>>      61.68 ±  3%     -36.0       25.68 ± 39%  perf-profile.calltrace.cycles-pp.folio_alloc.page_cache_ra_unbounded.filemap_fault.__xfs_filemap_fault.__do_fault
>>      61.64 ±  3%     -36.0       25.68 ± 39%  perf-profile.calltrace.cycles-pp.__alloc_pages.folio_alloc.page_cache_ra_unbounded.filemap_fault.__xfs_filemap_fault
>>      55.80 ±  5%     -30.1       25.65 ± 39%  perf-profile.calltrace.cycles-pp.__alloc_pages_slowpath.__alloc_pages.folio_alloc.page_cache_ra_unbounded.filemap_fault
>>      55.22 ±  5%     -29.6       25.59 ± 39%  perf-profile.calltrace.cycles-pp.try_to_free_pages.__alloc_pages_slowpath.__alloc_pages.folio_alloc.page_cache_ra_unbounded
>>      20.78 ± 11%     -20.8        0.00        perf-profile.calltrace.cycles-pp.filemap_add_folio.page_cache_ra_unbounded.filemap_fault.__xfs_filemap_fault.__do_fault
>>      52.64 ±  5%     -19.5       33.18 ±  8%  perf-profile.calltrace.cycles-pp.shrink_inactive_list.shrink_lruvec.shrink_node.do_try_to_free_pages.try_to_free_pages
>>      52.68 ±  5%     -19.5       33.23 ±  8%  perf-profile.calltrace.cycles-pp.shrink_lruvec.shrink_node.do_try_to_free_pages.try_to_free_pages.__alloc_pages_slowpath
>>      18.43 ± 12%     -18.4        0.00        perf-profile.calltrace.cycles-pp.folio_add_lru.filemap_add_folio.page_cache_ra_unbounded.filemap_fault.__xfs_filemap_fault
>>      18.39 ± 12%     -18.4        0.00        perf-profile.calltrace.cycles-pp.__pagevec_lru_add.folio_add_lru.filemap_add_folio.page_cache_ra_unbounded.filemap_fault
>>      17.74 ± 12%     -17.7        0.00        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.__pagevec_lru_add.folio_add_lru.filemap_add_folio.page_cache_ra_unbounded
>>      55.38 ±  6%     -14.3       41.11 ± 16%  perf-profile.calltrace.cycles-pp.do_try_to_free_pages.try_to_free_pages.__alloc_pages_slowpath.__alloc_pages.folio_alloc
>>      56.25 ±  6%     -14.3       41.99 ± 17%  perf-profile.calltrace.cycles-pp.shrink_node.do_try_to_free_pages.try_to_free_pages.__alloc_pages_slowpath.__alloc_pages
>>      25.36 ± 10%     -12.3       13.07 ± 18%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.shrink_inactive_list.shrink_lruvec.shrink_node
>>      25.22 ±  9%     -12.1       13.12 ± 18%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.shrink_inactive_list.shrink_lruvec.shrink_node.do_try_to_free_pages
>>      88.37           -11.6       76.74 ±  5%  perf-profile.calltrace.cycles-pp.filemap_fault.__xfs_filemap_fault.__do_fault.do_fault.__handle_mm_fault
>>      88.37           -11.6       76.75 ±  5%  perf-profile.calltrace.cycles-pp.__do_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
>>      88.37           -11.6       76.75 ±  5%  perf-profile.calltrace.cycles-pp.__xfs_filemap_fault.__do_fault.do_fault.__handle_mm_fault.handle_mm_fault
>>      90.28           -11.1       79.20 ±  5%  perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
>>      90.32           -11.0       79.34 ±  5%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
>>      90.45           -10.9       79.57 ±  5%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
>>      90.50           -10.8       79.66 ±  4%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
>>      90.50           -10.8       79.66 ±  4%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.do_access
>>      90.56           -10.8       79.74 ±  4%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.do_access
>>      94.36            -8.1       86.27 ±  4%  perf-profile.calltrace.cycles-pp.do_access
>>      17.70 ± 12%      -5.9       11.76 ± 14%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__pagevec_lru_add.folio_add_lru
>>      17.73 ± 12%      -5.9       11.84 ± 14%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__pagevec_lru_add.folio_add_lru.filemap_add_folio
>>       5.77 ± 25%      -5.8        0.00        perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.folio_alloc.page_cache_ra_unbounded.filemap_fault
>>       5.51 ±  9%      -5.5        0.00        perf-profile.calltrace.cycles-pp.read_pages.page_cache_ra_unbounded.filemap_fault.__xfs_filemap_fault.__do_fault
>>       5.50 ±  8%      -5.5        0.00        perf-profile.calltrace.cycles-pp.iomap_readahead.read_pages.page_cache_ra_unbounded.filemap_fault.__xfs_filemap_fault
>>       5.46 ± 27%      -5.5        0.00        perf-profile.calltrace.cycles-pp.rmqueue_bulk.get_page_from_freelist.__alloc_pages.folio_alloc.page_cache_ra_unbounded
>>       5.29 ±  9%      -5.3        0.00        perf-profile.calltrace.cycles-pp.iomap_readpage_iter.iomap_readahead.read_pages.page_cache_ra_unbounded.filemap_fault
>>       5.12 ± 28%      -5.1        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.rmqueue_bulk.get_page_from_freelist.__alloc_pages.folio_alloc
>>       5.12 ± 28%      -5.1        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.rmqueue_bulk.get_page_from_freelist.__alloc_pages
>>      11.37 ±  9%      -5.0        6.38 ± 16%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.lru_note_cost.shrink_inactive_list.shrink_lruvec
>>      11.41 ±  9%      -5.0        6.44 ± 16%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.lru_note_cost.shrink_inactive_list.shrink_lruvec.shrink_node
>>       5.37 ± 13%      -4.9        0.47 ± 70%  perf-profile.calltrace.cycles-pp.__remove_mapping.shrink_page_list.shrink_inactive_list.shrink_lruvec.shrink_node
>>      11.50 ±  9%      -4.9        6.60 ± 16%  perf-profile.calltrace.cycles-pp.lru_note_cost.shrink_inactive_list.shrink_lruvec.shrink_node.do_try_to_free_pages
>>       0.76 ±  8%      +0.5        1.28 ± 20%  perf-profile.calltrace.cycles-pp.filemap_map_pages.xfs_filemap_map_pages.do_fault.__handle_mm_fault.handle_mm_fault
>>       0.79 ±  7%      +0.5        1.33 ± 19%  perf-profile.calltrace.cycles-pp.xfs_filemap_map_pages.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
>>       1.40 ±  9%      +0.5        1.95 ±  8%  perf-profile.calltrace.cycles-pp.shrink_lruvec.shrink_node.balance_pgdat.kswapd.kthread
>>       1.40 ±  9%      +0.5        1.95 ±  8%  perf-profile.calltrace.cycles-pp.shrink_inactive_list.shrink_lruvec.shrink_node.balance_pgdat.kswapd
>>       1.43 ±  9%      +0.6        2.00 ±  8%  perf-profile.calltrace.cycles-pp.shrink_node.balance_pgdat.kswapd.kthread.ret_from_fork
>>       1.43 ±  9%      +0.6        2.00 ±  8%  perf-profile.calltrace.cycles-pp.balance_pgdat.kswapd.kthread.ret_from_fork
>>       1.43 ±  9%      +0.6        2.02 ±  8%  perf-profile.calltrace.cycles-pp.kswapd.kthread.ret_from_fork
>>       0.27 ±100%      +0.7        0.96 ± 23%  perf-profile.calltrace.cycles-pp.page_add_file_rmap.do_set_pte.filemap_map_pages.xfs_filemap_map_pages.do_fault
>>       0.28 ±100%      +0.7        1.00 ± 23%  perf-profile.calltrace.cycles-pp.do_set_pte.filemap_map_pages.xfs_filemap_map_pages.do_fault.__handle_mm_fault
>>       0.00            +0.7        0.74 ± 26%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.page_add_file_rmap.do_set_pte.filemap_map_pages.xfs_filemap_map_pages
>>       0.56 ± 46%      +0.8        1.35 ± 10%  perf-profile.calltrace.cycles-pp.shrink_page_list.shrink_inactive_list.shrink_lruvec.shrink_node.balance_pgdat
>>       0.00            +1.0        1.00 ± 25%  perf-profile.calltrace.cycles-pp.try_charge_memcg.charge_memcg.__mem_cgroup_charge.__filemap_add_folio.filemap_add_folio
>>       0.00            +1.0        1.04 ± 21%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.get_page_from_freelist.__alloc_pages_slowpath.__alloc_pages
>>       0.00            +1.0        1.04 ± 22%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.get_page_from_freelist.__alloc_pages_slowpath.__alloc_pages.folio_alloc
>>       0.00            +1.1        1.15 ± 26%  perf-profile.calltrace.cycles-pp.charge_memcg.__mem_cgroup_charge.__filemap_add_folio.filemap_add_folio.ondemand_readahead
>>       0.00            +1.2        1.17 ± 21%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages_slowpath.__alloc_pages.folio_alloc.ondemand_readahead
>>       0.00            +1.2        1.19 ± 58%  perf-profile.calltrace.cycles-pp.uncharge_batch.__mem_cgroup_uncharge.free_compound_page.shrink_page_list.shrink_inactive_list
>>       1.76 ±  9%      +1.3        3.02 ± 15%  perf-profile.calltrace.cycles-pp.ret_from_fork
>>       1.76 ±  9%      +1.3        3.02 ± 15%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
>>       0.00            +1.3        1.32 ± 29%  perf-profile.calltrace.cycles-pp.__mem_cgroup_charge.__filemap_add_folio.filemap_add_folio.ondemand_readahead.filemap_fault
>>       0.00            +1.4        1.45 ± 54%  perf-profile.calltrace.cycles-pp.__mem_cgroup_uncharge.free_compound_page.shrink_page_list.shrink_inactive_list.shrink_lruvec
>>       0.00            +1.5        1.45 ± 54%  perf-profile.calltrace.cycles-pp.free_compound_page.shrink_page_list.shrink_inactive_list.shrink_lruvec.shrink_node
>>       0.00            +1.5        1.50 ± 81%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__free_pages_ok.shrink_page_list.shrink_inactive_list
>>       0.00            +1.5        1.53 ± 80%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__free_pages_ok.shrink_page_list.shrink_inactive_list.shrink_lruvec
>>       0.00            +1.6        1.61 ± 77%  perf-profile.calltrace.cycles-pp.__free_pages_ok.shrink_page_list.shrink_inactive_list.shrink_lruvec.shrink_node
>>       0.00            +1.7        1.74 ± 26%  perf-profile.calltrace.cycles-pp.__filemap_add_folio.filemap_add_folio.ondemand_readahead.filemap_fault.__xfs_filemap_fault
>>       4.68 ±  5%      +2.2        6.89 ± 15%  perf-profile.calltrace.cycles-pp.do_rw_once
>>       0.00            +3.5        3.49 ± 35%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.memset_erms.iomap_readpage_iter.iomap_readahead.read_pages
>>       0.00            +6.7        6.71 ± 14%  perf-profile.calltrace.cycles-pp.memset_erms.iomap_readpage_iter.iomap_readahead.read_pages.filemap_fault
>>       0.00            +9.0        8.97 ± 13%  perf-profile.calltrace.cycles-pp.iomap_readpage_iter.iomap_readahead.read_pages.filemap_fault.__xfs_filemap_fault
>>       0.00            +9.1        9.05 ± 32%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.get_page_from_freelist.__alloc_pages.folio_alloc
>>       0.00            +9.1        9.10 ± 12%  perf-profile.calltrace.cycles-pp.iomap_readahead.read_pages.filemap_fault.__xfs_filemap_fault.__do_fault
>>       0.00            +9.1        9.10 ± 12%  perf-profile.calltrace.cycles-pp.read_pages.filemap_fault.__xfs_filemap_fault.__do_fault.do_fault
>>       0.00            +9.1        9.10 ± 31%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.get_page_from_freelist.__alloc_pages.folio_alloc.ondemand_readahead
>>       0.00            +9.7        9.72 ± 31%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.folio_alloc.ondemand_readahead.filemap_fault
>>       0.00           +11.8       11.84 ± 14%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.__pagevec_lru_add.folio_add_lru.filemap_add_folio.ondemand_readahead
>>       0.00           +12.4       12.38 ± 14%  perf-profile.calltrace.cycles-pp.__pagevec_lru_add.folio_add_lru.filemap_add_folio.ondemand_readahead.filemap_fault
>>       0.00           +12.4       12.39 ± 14%  perf-profile.calltrace.cycles-pp.folio_add_lru.filemap_add_folio.ondemand_readahead.filemap_fault.__xfs_filemap_fault
>>       0.00           +14.1       14.13 ± 14%  perf-profile.calltrace.cycles-pp.filemap_add_folio.ondemand_readahead.filemap_fault.__xfs_filemap_fault.__do_fault
>>       0.00           +15.5       15.54 ± 44%  perf-profile.calltrace.cycles-pp.try_to_free_pages.__alloc_pages_slowpath.__alloc_pages.folio_alloc.ondemand_readahead
>>       0.00           +17.8       17.76 ± 42%  perf-profile.calltrace.cycles-pp.__alloc_pages_slowpath.__alloc_pages.folio_alloc.ondemand_readahead.filemap_fault
>>       0.00           +27.5       27.50 ± 36%  perf-profile.calltrace.cycles-pp.__alloc_pages.folio_alloc.ondemand_readahead.filemap_fault.__xfs_filemap_fault
>>       0.00           +27.5       27.51 ± 36%  perf-profile.calltrace.cycles-pp.folio_alloc.ondemand_readahead.filemap_fault.__xfs_filemap_fault.__do_fault
>>       0.00           +41.7       41.69 ± 23%  perf-profile.calltrace.cycles-pp.ondemand_readahead.filemap_fault.__xfs_filemap_fault.__do_fault.do_fault
>>      88.08           -62.1       25.98 ± 39%  perf-profile.children.cycles-pp.page_cache_ra_unbounded
>>      54.48 ±  5%     -19.0       35.44 ±  8%  perf-profile.children.cycles-pp.shrink_inactive_list
>>      54.50 ±  5%     -19.0       35.47 ±  8%  perf-profile.children.cycles-pp.shrink_lruvec
>>      56.66 ±  6%     -14.4       42.30 ± 17%  perf-profile.children.cycles-pp.do_try_to_free_pages
>>      56.67 ±  6%     -14.4       42.31 ± 17%  perf-profile.children.cycles-pp.try_to_free_pages
>>      58.09 ±  6%     -13.8       44.30 ± 16%  perf-profile.children.cycles-pp.shrink_node
>>      68.98 ±  2%     -13.6       55.40 ± 10%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
>>      57.28 ±  6%     -12.7       44.62 ± 15%  perf-profile.children.cycles-pp.__alloc_pages_slowpath
>>      88.37           -11.5       76.88 ±  5%  perf-profile.children.cycles-pp.filemap_fault
>>      88.37           -11.5       76.89 ±  5%  perf-profile.children.cycles-pp.__do_fault
>>      88.37           -11.5       76.89 ±  5%  perf-profile.children.cycles-pp.__xfs_filemap_fault
>>      90.49           -11.0       79.46 ±  5%  perf-profile.children.cycles-pp.__handle_mm_fault
>>      90.30           -10.9       79.36 ±  5%  perf-profile.children.cycles-pp.do_fault
>>      90.63           -10.8       79.78 ±  5%  perf-profile.children.cycles-pp.handle_mm_fault
>>      90.64           -10.8       79.86 ±  5%  perf-profile.children.cycles-pp.do_user_addr_fault
>>      90.64           -10.8       79.88 ±  5%  perf-profile.children.cycles-pp.exc_page_fault
>>      90.70           -10.7       79.96 ±  5%  perf-profile.children.cycles-pp.asm_exc_page_fault
>>      10.20 ± 18%      -8.7        1.50 ± 17%  perf-profile.children.cycles-pp._raw_spin_lock
>>      94.68            -7.5       87.16 ±  4%  perf-profile.children.cycles-pp.do_access
>>      20.78 ± 11%      -6.4       14.34 ± 14%  perf-profile.children.cycles-pp.filemap_add_folio
>>       6.28 ± 24%      -5.9        0.36 ± 42%  perf-profile.children.cycles-pp.rmqueue_bulk
>>      18.47 ± 12%      -5.9       12.58 ± 14%  perf-profile.children.cycles-pp.folio_add_lru
>>      18.50 ± 12%      -5.8       12.65 ± 14%  perf-profile.children.cycles-pp.__pagevec_lru_add
>>      17.85 ± 12%      -5.6       12.29 ± 14%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
>>      12.08 ±  9%      -5.1        7.00 ± 16%  perf-profile.children.cycles-pp.lru_note_cost
>>       5.56 ± 13%      -4.6        0.96 ± 16%  perf-profile.children.cycles-pp.__remove_mapping
>>       2.26 ±  8%      -2.1        0.20 ± 29%  perf-profile.children.cycles-pp.iomap_set_range_uptodate
>>       1.27 ± 13%      -1.2        0.12 ± 19%  perf-profile.children.cycles-pp.workingset_eviction
>>       0.71            -0.6        0.16 ± 12%  perf-profile.children.cycles-pp.__list_del_entry_valid
>>       0.61 ± 12%      -0.5        0.13 ± 57%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
>>       0.96 ±  6%      -0.5        0.49 ± 23%  perf-profile.children.cycles-pp.free_pcppages_bulk
>>       0.46 ± 10%      -0.4        0.04 ± 75%  perf-profile.children.cycles-pp.workingset_age_nonresident
>>       0.65 ±  5%      -0.4        0.28 ± 12%  perf-profile.children.cycles-pp.isolate_lru_pages
>>       0.96 ±  6%      -0.3        0.64 ± 14%  perf-profile.children.cycles-pp.folio_referenced
>>       0.26 ±  5%      -0.2        0.08 ± 12%  perf-profile.children.cycles-pp.__free_one_page
>>       0.24 ±  5%      -0.1        0.10 ±  9%  perf-profile.children.cycles-pp.down_read
>>       0.20 ± 18%      -0.1        0.08 ± 24%  perf-profile.children.cycles-pp.move_pages_to_lru
>>       0.14 ±  4%      -0.1        0.02 ± 99%  perf-profile.children.cycles-pp.__might_resched
>>       0.20 ±  6%      -0.1        0.08 ± 13%  perf-profile.children.cycles-pp.xas_load
>>       0.15 ± 42%      -0.1        0.04 ±104%  perf-profile.children.cycles-pp.alloc_pages_vma
>>       0.30 ± 11%      -0.1        0.21 ± 19%  perf-profile.children.cycles-pp.xas_create
>>       0.20 ±  7%      -0.1        0.14 ± 23%  perf-profile.children.cycles-pp.filemap_unaccount_folio
>>       0.14 ±  4%      -0.1        0.08 ± 17%  perf-profile.children.cycles-pp.next_uptodate_page
>>       0.08 ±  6%      -0.0        0.04 ± 45%  perf-profile.children.cycles-pp.__list_add_valid
>>       0.06 ± 13%      +0.0        0.08 ± 13%  perf-profile.children.cycles-pp.count_shadow_nodes
>>       0.05 ±  7%      +0.0        0.09 ± 14%  perf-profile.children.cycles-pp.__mod_zone_page_state
>>       0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.update_load_avg
>>       0.06 ±  9%      +0.1        0.11 ± 22%  perf-profile.children.cycles-pp.release_pages
>>       0.00            +0.1        0.06 ± 16%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
>>       0.00            +0.1        0.06 ± 14%  perf-profile.children.cycles-pp.flush_tlb_func
>>       0.00            +0.1        0.07 ± 37%  perf-profile.children.cycles-pp.__sysvec_call_function_single
>>       0.02 ±141%      +0.1        0.09 ± 10%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
>>       0.00            +0.1        0.07 ± 38%  perf-profile.children.cycles-pp.sysvec_call_function_single
>>       0.00            +0.1        0.08 ± 16%  perf-profile.children.cycles-pp.iomap_releasepage
>>       0.01 ±223%      +0.1        0.09 ± 22%  perf-profile.children.cycles-pp.irq_exit_rcu
>>       0.00            +0.1        0.08 ± 20%  perf-profile.children.cycles-pp.try_to_release_page
>>       0.00            +0.1        0.08 ± 20%  perf-profile.children.cycles-pp.filemap_release_folio
>>       0.08 ±  4%      +0.1        0.17 ± 15%  perf-profile.children.cycles-pp.task_tick_fair
>>       0.00            +0.1        0.09 ± 17%  perf-profile.children.cycles-pp.__mod_lruvec_kmem_state
>>       0.18 ±  4%      +0.1        0.28 ± 14%  perf-profile.children.cycles-pp.__mod_lruvec_state
>>       0.11 ±  6%      +0.1        0.22 ± 16%  perf-profile.children.cycles-pp.scheduler_tick
>>       0.16 ±  4%      +0.1        0.27 ± 14%  perf-profile.children.cycles-pp.__mod_node_page_state
>>       0.08 ± 54%      +0.1        0.20 ± 44%  perf-profile.children.cycles-pp.__softirqentry_text_start
>>       0.00            +0.1        0.13 ±  7%  perf-profile.children.cycles-pp.folio_mapcount
>>       0.15 ±  6%      +0.1        0.30 ± 17%  perf-profile.children.cycles-pp.tick_sched_handle
>>       0.15 ±  4%      +0.1        0.30 ± 17%  perf-profile.children.cycles-pp.update_process_times
>>       0.16 ±  5%      +0.2        0.31 ± 17%  perf-profile.children.cycles-pp.tick_sched_timer
>>       0.06 ± 52%      +0.2        0.26 ± 52%  perf-profile.children.cycles-pp.workingset_update_node
>>       0.05 ± 76%      +0.2        0.25 ± 54%  perf-profile.children.cycles-pp.list_lru_add
>>       0.22 ±  4%      +0.2        0.43 ± 16%  perf-profile.children.cycles-pp.__hrtimer_run_queues
>>       0.00            +0.2        0.21 ± 61%  perf-profile.children.cycles-pp.pagevec_lru_move_fn
>>       0.46 ±  4%      +0.2        0.67 ± 19%  perf-profile.children.cycles-pp.xas_store
>>       0.00            +0.2        0.22 ± 47%  perf-profile.children.cycles-pp.uncharge_folio
>>       0.00            +0.2        0.22 ± 61%  perf-profile.children.cycles-pp.folio_mark_accessed
>>       0.12 ± 10%      +0.2        0.34 ± 13%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
>>       0.00            +0.2        0.24 ± 52%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
>>       0.30 ±  3%      +0.2        0.55 ± 16%  perf-profile.children.cycles-pp.hrtimer_interrupt
>>       0.31 ±  3%      +0.2        0.56 ± 16%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
>>       0.18 ±  7%      +0.3        0.46 ± 13%  perf-profile.children.cycles-pp.native_irq_return_iret
>>       0.34 ±  4%      +0.3        0.65 ± 15%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
>>       0.24 ±  8%      +0.3        0.55 ± 25%  perf-profile.children.cycles-pp.__count_memcg_events
>>       0.14 ± 37%      +0.3        0.47 ± 24%  perf-profile.children.cycles-pp.drain_local_pages_wq
>>       0.14 ± 37%      +0.3        0.47 ± 24%  perf-profile.children.cycles-pp.drain_pages_zone
>>       0.15 ± 36%      +0.4        0.51 ± 25%  perf-profile.children.cycles-pp.process_one_work
>>       0.15 ± 34%      +0.4        0.52 ± 25%  perf-profile.children.cycles-pp.worker_thread
>>       0.00            +0.4        0.39 ± 63%  perf-profile.children.cycles-pp.unmap_vmas
>>       0.00            +0.4        0.39 ± 63%  perf-profile.children.cycles-pp.unmap_page_range
>>       0.00            +0.4        0.39 ± 63%  perf-profile.children.cycles-pp.zap_pte_range
>>       0.00            +0.4        0.40 ± 63%  perf-profile.children.cycles-pp.munmap
>>       0.00            +0.4        0.41 ± 63%  perf-profile.children.cycles-pp.__x64_sys_munmap
>>       0.00            +0.4        0.41 ± 62%  perf-profile.children.cycles-pp.__do_munmap
>>       0.00            +0.4        0.41 ± 62%  perf-profile.children.cycles-pp.unmap_region
>>       0.00            +0.4        0.41 ± 62%  perf-profile.children.cycles-pp.__vm_munmap
>>       0.50 ± 10%      +0.5        0.97 ± 23%  perf-profile.children.cycles-pp.page_add_file_rmap
>>       0.51 ±  9%      +0.5        1.00 ± 23%  perf-profile.children.cycles-pp.do_set_pte
>>       0.77 ±  7%      +0.5        1.30 ± 19%  perf-profile.children.cycles-pp.filemap_map_pages
>>       1.75 ±  2%      +0.5        2.28 ± 18%  perf-profile.children.cycles-pp.rmap_walk_file
>>       0.79 ±  7%      +0.5        1.33 ± 19%  perf-profile.children.cycles-pp.xfs_filemap_map_pages
>>       0.24 ± 16%      +0.5        0.78 ± 25%  perf-profile.children.cycles-pp.page_counter_try_charge
>>       1.43 ±  9%      +0.6        2.00 ±  8%  perf-profile.children.cycles-pp.balance_pgdat
>>       1.43 ±  9%      +0.6        2.02 ±  8%  perf-profile.children.cycles-pp.kswapd
>>       0.18 ± 16%      +0.6        0.79 ± 39%  perf-profile.children.cycles-pp.page_counter_cancel
>>       0.32 ± 14%      +0.7        1.01 ± 24%  perf-profile.children.cycles-pp.try_charge_memcg
>>       0.08 ± 14%      +0.7        0.78 ± 38%  perf-profile.children.cycles-pp.propagate_protected_usage
>>       0.00            +0.7        0.72 ± 49%  perf-profile.children.cycles-pp.free_transhuge_page
>>       0.87 ±  4%      +0.7        1.62 ± 23%  perf-profile.children.cycles-pp.try_to_unmap
>>       1.25 ±  9%      +0.9        2.12 ± 28%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
>>       0.70 ±  4%      +0.9        1.60 ± 23%  perf-profile.children.cycles-pp.try_to_unmap_one
>>       0.24 ±  7%      +1.0        1.21 ± 29%  perf-profile.children.cycles-pp.page_remove_rmap
>>       0.21 ± 14%      +1.1        1.34 ± 40%  perf-profile.children.cycles-pp.page_counter_uncharge
>>       1.80 ± 10%      +1.2        3.02 ± 14%  perf-profile.children.cycles-pp.ret_from_fork
>>       1.76 ±  9%      +1.3        3.02 ± 15%  perf-profile.children.cycles-pp.kthread
>>       0.23 ± 11%      +1.3        1.57 ± 42%  perf-profile.children.cycles-pp.uncharge_batch
>>       0.00            +1.7        1.72 ± 43%  perf-profile.children.cycles-pp.free_compound_page
>>       0.00            +1.7        1.75 ± 43%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge
>>       0.00            +2.1        2.08 ± 64%  perf-profile.children.cycles-pp.__free_pages_ok
>>       0.46 ±  5%      +2.1        2.61 ± 28%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
>>       5.50 ±  8%      +3.7        9.17 ± 12%  perf-profile.children.cycles-pp.iomap_readahead
>>       5.51 ±  9%      +3.7        9.18 ± 12%  perf-profile.children.cycles-pp.read_pages
>>       5.32 ±  9%      +3.7        9.04 ± 13%  perf-profile.children.cycles-pp.iomap_readpage_iter
>>       2.98 ± 10%      +5.7        8.69 ± 13%  perf-profile.children.cycles-pp.memset_erms
>>      17.88 ± 12%      +8.1       25.98 ± 16%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
>>       0.00           +41.7       41.74 ± 23%  perf-profile.children.cycles-pp.ondemand_readahead
>>      68.94 ±  2%     -13.5       55.40 ± 10%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
>>       2.20 ±  8%      -2.1        0.07 ± 21%  perf-profile.self.cycles-pp.iomap_set_range_uptodate
>>       0.80 ± 14%      -0.7        0.07 ± 16%  perf-profile.self.cycles-pp.workingset_eviction
>>       0.70            -0.5        0.16 ± 12%  perf-profile.self.cycles-pp.__list_del_entry_valid
>>       0.60 ± 11%      -0.5        0.13 ± 57%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
>>       0.46 ± 10%      -0.4        0.04 ± 75%  perf-profile.self.cycles-pp.workingset_age_nonresident
>>       0.28 ± 13%      -0.2        0.08 ± 75%  perf-profile.self.cycles-pp.charge_memcg
>>       0.24 ±  3%      -0.2        0.08 ± 11%  perf-profile.self.cycles-pp.shrink_page_list
>>       0.19 ± 12%      -0.1        0.04 ±118%  perf-profile.self.cycles-pp.__mem_cgroup_charge
>>       0.23 ±  5%      -0.1        0.09 ± 10%  perf-profile.self.cycles-pp._raw_spin_lock
>>       0.22 ±  5%      -0.1        0.12 ± 10%  perf-profile.self.cycles-pp.isolate_lru_pages
>>       0.16 ±  4%      -0.1        0.05 ± 45%  perf-profile.self.cycles-pp.xas_load
>>       0.20 ±  3%      -0.1        0.10 ±  9%  perf-profile.self.cycles-pp.xas_create
>>       0.19 ±  5%      -0.1        0.10 ± 21%  perf-profile.self.cycles-pp.__pagevec_lru_add
>>       0.17 ±  5%      -0.1        0.08 ± 12%  perf-profile.self.cycles-pp.down_read
>>       0.30 ±  4%      -0.1        0.21 ±  7%  perf-profile.self.cycles-pp.page_vma_mapped_walk
>>       0.14 ±  5%      -0.1        0.07 ± 14%  perf-profile.self.cycles-pp.next_uptodate_page
>>       0.07            -0.0        0.04 ± 45%  perf-profile.self.cycles-pp.__list_add_valid
>>       0.05 ±  7%      +0.0        0.09 ± 14%  perf-profile.self.cycles-pp.__mod_zone_page_state
>>       0.06 ±  6%      +0.0        0.09 ± 13%  perf-profile.self.cycles-pp.xas_store
>>       0.02 ±141%      +0.1        0.07 ± 12%  perf-profile.self.cycles-pp.count_shadow_nodes
>>       0.00            +0.1        0.06 ± 16%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
>>       0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.page_remove_rmap
>>       0.01 ±223%      +0.1        0.08 ± 25%  perf-profile.self.cycles-pp.release_pages
>>       0.06 ±  8%      +0.1        0.14 ± 14%  perf-profile.self.cycles-pp.filemap_map_pages
>>       0.06 ±  9%      +0.1        0.16 ± 21%  perf-profile.self.cycles-pp.lru_note_cost
>>       0.00            +0.1        0.12 ± 14%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
>>       0.15 ±  6%      +0.1        0.27 ± 14%  perf-profile.self.cycles-pp.__mod_node_page_state
>>       0.00            +0.1        0.13 ±  7%  perf-profile.self.cycles-pp.folio_mapcount
>>       0.00            +0.1        0.14 ± 46%  perf-profile.self.cycles-pp.uncharge_batch
>>       0.00            +0.2        0.15 ± 19%  perf-profile.self.cycles-pp.page_add_file_rmap
>>       0.08 ± 12%      +0.2        0.22 ± 24%  perf-profile.self.cycles-pp.try_charge_memcg
>>       0.21 ±  7%      +0.2        0.37 ± 18%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
>>       0.00            +0.2        0.22 ± 47%  perf-profile.self.cycles-pp.uncharge_folio
>>       0.20 ±  8%      +0.3        0.46 ± 27%  perf-profile.self.cycles-pp.__count_memcg_events
>>       0.18 ±  7%      +0.3        0.46 ± 13%  perf-profile.self.cycles-pp.native_irq_return_iret
>>       0.04 ± 44%      +0.4        0.40 ± 27%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
>>       0.19 ± 16%      +0.4        0.56 ± 24%  perf-profile.self.cycles-pp.page_counter_try_charge
>>       0.18 ± 15%      +0.6        0.78 ± 38%  perf-profile.self.cycles-pp.page_counter_cancel
>>       0.08 ± 14%      +0.7        0.77 ± 38%  perf-profile.self.cycles-pp.propagate_protected_usage
>>       3.37 ±  8%      +2.8        6.19 ± 16%  perf-profile.self.cycles-pp.do_access
>>       2.95 ±  9%      +5.5        8.47 ± 13%  perf-profile.self.cycles-pp.memset_erms
>>
>>
>>
>>
>>
>> Disclaimer:
>> Results have been estimated based on internal Intel analysis and are provided
>> for informational purposes only. Any difference in system hardware or software
>> design or configuration may affect actual performance.
>>
>>
>> -- 
>> 0-DAY CI Kernel Test Service
>> https://01.org/lkp
>>
>>
> 
>> #
>> # Automatically generated file; DO NOT EDIT.
>> # Linux/x86_64 5.17.0-rc4 Kernel Configuration
>> #
>> CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.2.0-19) 11.2.0"
>> CONFIG_CC_IS_GCC=y
>> CONFIG_GCC_VERSION=110200
>> CONFIG_CLANG_VERSION=0
>> CONFIG_AS_IS_GNU=y
>> CONFIG_AS_VERSION=23800
>> CONFIG_LD_IS_BFD=y
>> CONFIG_LD_VERSION=23800
>> CONFIG_LLD_VERSION=0
>> CONFIG_CC_CAN_LINK=y
>> CONFIG_CC_CAN_LINK_STATIC=y
>> CONFIG_CC_HAS_ASM_GOTO=y
>> CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
>> CONFIG_CC_HAS_ASM_INLINE=y
>> CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
>> CONFIG_IRQ_WORK=y
>> CONFIG_BUILDTIME_TABLE_SORT=y
>> CONFIG_THREAD_INFO_IN_TASK=y
>>
>> #
>> # General setup
>> #
>> CONFIG_INIT_ENV_ARG_LIMIT=32
>> # CONFIG_COMPILE_TEST is not set
>> # CONFIG_WERROR is not set
>> CONFIG_LOCALVERSION=""
>> CONFIG_LOCALVERSION_AUTO=y
>> CONFIG_BUILD_SALT=""
>> CONFIG_HAVE_KERNEL_GZIP=y
>> CONFIG_HAVE_KERNEL_BZIP2=y
>> CONFIG_HAVE_KERNEL_LZMA=y
>> CONFIG_HAVE_KERNEL_XZ=y
>> CONFIG_HAVE_KERNEL_LZO=y
>> CONFIG_HAVE_KERNEL_LZ4=y
>> CONFIG_HAVE_KERNEL_ZSTD=y
>> CONFIG_KERNEL_GZIP=y
>> # CONFIG_KERNEL_BZIP2 is not set
>> # CONFIG_KERNEL_LZMA is not set
>> # CONFIG_KERNEL_XZ is not set
>> # CONFIG_KERNEL_LZO is not set
>> # CONFIG_KERNEL_LZ4 is not set
>> # CONFIG_KERNEL_ZSTD is not set
>> CONFIG_DEFAULT_INIT=""
>> CONFIG_DEFAULT_HOSTNAME="(none)"
>> CONFIG_SWAP=y
>> CONFIG_SYSVIPC=y
>> CONFIG_SYSVIPC_SYSCTL=y
>> CONFIG_POSIX_MQUEUE=y
>> CONFIG_POSIX_MQUEUE_SYSCTL=y
>> # CONFIG_WATCH_QUEUE is not set
>> CONFIG_CROSS_MEMORY_ATTACH=y
>> # CONFIG_USELIB is not set
>> CONFIG_AUDIT=y
>> CONFIG_HAVE_ARCH_AUDITSYSCALL=y
>> CONFIG_AUDITSYSCALL=y
>>
>> #
>> # IRQ subsystem
>> #
>> CONFIG_GENERIC_IRQ_PROBE=y
>> CONFIG_GENERIC_IRQ_SHOW=y
>> CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
>> CONFIG_GENERIC_PENDING_IRQ=y
>> CONFIG_GENERIC_IRQ_MIGRATION=y
>> CONFIG_GENERIC_IRQ_INJECTION=y
>> CONFIG_HARDIRQS_SW_RESEND=y
>> CONFIG_IRQ_DOMAIN=y
>> CONFIG_IRQ_DOMAIN_HIERARCHY=y
>> CONFIG_GENERIC_MSI_IRQ=y
>> CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
>> CONFIG_IRQ_MSI_IOMMU=y
>> CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
>> CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
>> CONFIG_IRQ_FORCED_THREADING=y
>> CONFIG_SPARSE_IRQ=y
>> # CONFIG_GENERIC_IRQ_DEBUGFS is not set
>> # end of IRQ subsystem
>>
>> CONFIG_CLOCKSOURCE_WATCHDOG=y
>> CONFIG_ARCH_CLOCKSOURCE_INIT=y
>> CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
>> CONFIG_GENERIC_TIME_VSYSCALL=y
>> CONFIG_GENERIC_CLOCKEVENTS=y
>> CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
>> CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
>> CONFIG_GENERIC_CMOS_UPDATE=y
>> CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
>> CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y
>>
>> #
>> # Timers subsystem
>> #
>> CONFIG_TICK_ONESHOT=y
>> CONFIG_NO_HZ_COMMON=y
>> # CONFIG_HZ_PERIODIC is not set
>> # CONFIG_NO_HZ_IDLE is not set
>> CONFIG_NO_HZ_FULL=y
>> CONFIG_CONTEXT_TRACKING=y
>> # CONFIG_CONTEXT_TRACKING_FORCE is not set
>> CONFIG_NO_HZ=y
>> CONFIG_HIGH_RES_TIMERS=y
>> # end of Timers subsystem
>>
>> CONFIG_BPF=y
>> CONFIG_HAVE_EBPF_JIT=y
>> CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
>>
>> #
>> # BPF subsystem
>> #
>> CONFIG_BPF_SYSCALL=y
>> CONFIG_BPF_JIT=y
>> CONFIG_BPF_JIT_ALWAYS_ON=y
>> CONFIG_BPF_JIT_DEFAULT_ON=y
>> CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
>> # CONFIG_BPF_PRELOAD is not set
>> # CONFIG_BPF_LSM is not set
>> # end of BPF subsystem
>>
>> CONFIG_PREEMPT_VOLUNTARY_BUILD=y
>> # CONFIG_PREEMPT_NONE is not set
>> CONFIG_PREEMPT_VOLUNTARY=y
>> # CONFIG_PREEMPT is not set
>> CONFIG_PREEMPT_COUNT=y
>> # CONFIG_PREEMPT_DYNAMIC is not set
>> # CONFIG_SCHED_CORE is not set
>>
>> #
>> # CPU/Task time and stats accounting
>> #
>> CONFIG_VIRT_CPU_ACCOUNTING=y
>> CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
>> CONFIG_IRQ_TIME_ACCOUNTING=y
>> CONFIG_HAVE_SCHED_AVG_IRQ=y
>> CONFIG_BSD_PROCESS_ACCT=y
>> CONFIG_BSD_PROCESS_ACCT_V3=y
>> CONFIG_TASKSTATS=y
>> CONFIG_TASK_DELAY_ACCT=y
>> CONFIG_TASK_XACCT=y
>> CONFIG_TASK_IO_ACCOUNTING=y
>> # CONFIG_PSI is not set
>> # end of CPU/Task time and stats accounting
>>
>> CONFIG_CPU_ISOLATION=y
>>
>> #
>> # RCU Subsystem
>> #
>> CONFIG_TREE_RCU=y
>> # CONFIG_RCU_EXPERT is not set
>> CONFIG_SRCU=y
>> CONFIG_TREE_SRCU=y
>> CONFIG_TASKS_RCU_GENERIC=y
>> CONFIG_TASKS_RUDE_RCU=y
>> CONFIG_TASKS_TRACE_RCU=y
>> CONFIG_RCU_STALL_COMMON=y
>> CONFIG_RCU_NEED_SEGCBLIST=y
>> CONFIG_RCU_NOCB_CPU=y
>> # end of RCU Subsystem
>>
>> CONFIG_BUILD_BIN2C=y
>> CONFIG_IKCONFIG=y
>> CONFIG_IKCONFIG_PROC=y
>> # CONFIG_IKHEADERS is not set
>> CONFIG_LOG_BUF_SHIFT=20
>> CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
>> CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
>> # CONFIG_PRINTK_INDEX is not set
>> CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
>>
>> #
>> # Scheduler features
>> #
>> # CONFIG_UCLAMP_TASK is not set
>> # end of Scheduler features
>>
>> CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
>> CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
>> CONFIG_CC_HAS_INT128=y
>> CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
>> CONFIG_ARCH_SUPPORTS_INT128=y
>> CONFIG_NUMA_BALANCING=y
>> CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
>> CONFIG_CGROUPS=y
>> CONFIG_PAGE_COUNTER=y
>> CONFIG_MEMCG=y
>> CONFIG_MEMCG_SWAP=y
>> CONFIG_MEMCG_KMEM=y
>> CONFIG_BLK_CGROUP=y
>> CONFIG_CGROUP_WRITEBACK=y
>> CONFIG_CGROUP_SCHED=y
>> CONFIG_FAIR_GROUP_SCHED=y
>> CONFIG_CFS_BANDWIDTH=y
>> CONFIG_RT_GROUP_SCHED=y
>> CONFIG_CGROUP_PIDS=y
>> CONFIG_CGROUP_RDMA=y
>> CONFIG_CGROUP_FREEZER=y
>> CONFIG_CGROUP_HUGETLB=y
>> CONFIG_CPUSETS=y
>> CONFIG_PROC_PID_CPUSET=y
>> CONFIG_CGROUP_DEVICE=y
>> CONFIG_CGROUP_CPUACCT=y
>> CONFIG_CGROUP_PERF=y
>> CONFIG_CGROUP_BPF=y
>> # CONFIG_CGROUP_MISC is not set
>> # CONFIG_CGROUP_DEBUG is not set
>> CONFIG_SOCK_CGROUP_DATA=y
>> CONFIG_NAMESPACES=y
>> CONFIG_UTS_NS=y
>> CONFIG_TIME_NS=y
>> CONFIG_IPC_NS=y
>> CONFIG_USER_NS=y
>> CONFIG_PID_NS=y
>> CONFIG_NET_NS=y
>> # CONFIG_CHECKPOINT_RESTORE is not set
>> CONFIG_SCHED_AUTOGROUP=y
>> # CONFIG_SYSFS_DEPRECATED is not set
>> CONFIG_RELAY=y
>> CONFIG_BLK_DEV_INITRD=y
>> CONFIG_INITRAMFS_SOURCE=""
>> CONFIG_RD_GZIP=y
>> CONFIG_RD_BZIP2=y
>> CONFIG_RD_LZMA=y
>> CONFIG_RD_XZ=y
>> CONFIG_RD_LZO=y
>> CONFIG_RD_LZ4=y
>> CONFIG_RD_ZSTD=y
>> # CONFIG_BOOT_CONFIG is not set
>> CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
>> # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
>> CONFIG_LD_ORPHAN_WARN=y
>> CONFIG_SYSCTL=y
>> CONFIG_HAVE_UID16=y
>> CONFIG_SYSCTL_EXCEPTION_TRACE=y
>> CONFIG_HAVE_PCSPKR_PLATFORM=y
>> # CONFIG_EXPERT is not set
>> CONFIG_UID16=y
>> CONFIG_MULTIUSER=y
>> CONFIG_SGETMASK_SYSCALL=y
>> CONFIG_SYSFS_SYSCALL=y
>> CONFIG_FHANDLE=y
>> CONFIG_POSIX_TIMERS=y
>> CONFIG_PRINTK=y
>> CONFIG_BUG=y
>> CONFIG_ELF_CORE=y
>> CONFIG_PCSPKR_PLATFORM=y
>> CONFIG_BASE_FULL=y
>> CONFIG_FUTEX=y
>> CONFIG_FUTEX_PI=y
>> CONFIG_EPOLL=y
>> CONFIG_SIGNALFD=y
>> CONFIG_TIMERFD=y
>> CONFIG_EVENTFD=y
>> CONFIG_SHMEM=y
>> CONFIG_AIO=y
>> CONFIG_IO_URING=y
>> CONFIG_ADVISE_SYSCALLS=y
>> CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
>> CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
>> CONFIG_MEMBARRIER=y
>> CONFIG_KALLSYMS=y
>> CONFIG_KALLSYMS_ALL=y
>> CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
>> CONFIG_KALLSYMS_BASE_RELATIVE=y
>> CONFIG_USERFAULTFD=y
>> CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
>> CONFIG_KCMP=y
>> CONFIG_RSEQ=y
>> # CONFIG_EMBEDDED is not set
>> CONFIG_HAVE_PERF_EVENTS=y
>> CONFIG_GUEST_PERF_EVENTS=y
>>
>> #
>> # Kernel Performance Events And Counters
>> #
>> CONFIG_PERF_EVENTS=y
>> # CONFIG_DEBUG_PERF_USE_VMALLOC is not set
>> # end of Kernel Performance Events And Counters
>>
>> CONFIG_VM_EVENT_COUNTERS=y
>> CONFIG_SLUB_DEBUG=y
>> # CONFIG_COMPAT_BRK is not set
>> # CONFIG_SLAB is not set
>> CONFIG_SLUB=y
>> CONFIG_SLAB_MERGE_DEFAULT=y
>> CONFIG_SLAB_FREELIST_RANDOM=y
>> # CONFIG_SLAB_FREELIST_HARDENED is not set
>> CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
>> CONFIG_SLUB_CPU_PARTIAL=y
>> CONFIG_SYSTEM_DATA_VERIFICATION=y
>> CONFIG_PROFILING=y
>> CONFIG_TRACEPOINTS=y
>> # end of General setup
>>
>> CONFIG_64BIT=y
>> CONFIG_X86_64=y
>> CONFIG_X86=y
>> CONFIG_INSTRUCTION_DECODER=y
>> CONFIG_OUTPUT_FORMAT="elf64-x86-64"
>> CONFIG_LOCKDEP_SUPPORT=y
>> CONFIG_STACKTRACE_SUPPORT=y
>> CONFIG_MMU=y
>> CONFIG_ARCH_MMAP_RND_BITS_MIN=28
>> CONFIG_ARCH_MMAP_RND_BITS_MAX=32
>> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
>> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
>> CONFIG_GENERIC_ISA_DMA=y
>> CONFIG_GENERIC_BUG=y
>> CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
>> CONFIG_ARCH_MAY_HAVE_PC_FDC=y
>> CONFIG_GENERIC_CALIBRATE_DELAY=y
>> CONFIG_ARCH_HAS_CPU_RELAX=y
>> CONFIG_ARCH_HAS_FILTER_PGPROT=y
>> CONFIG_ARCH_HIBERNATION_POSSIBLE=y
>> CONFIG_ARCH_NR_GPIO=1024
>> CONFIG_ARCH_SUSPEND_POSSIBLE=y
>> CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
>> CONFIG_AUDIT_ARCH=y
>> CONFIG_HAVE_INTEL_TXT=y
>> CONFIG_X86_64_SMP=y
>> CONFIG_ARCH_SUPPORTS_UPROBES=y
>> CONFIG_FIX_EARLYCON_MEM=y
>> CONFIG_PGTABLE_LEVELS=5
>> CONFIG_CC_HAS_SANE_STACKPROTECTOR=y
>>
>> #
>> # Processor type and features
>> #
>> CONFIG_SMP=y
>> CONFIG_X86_FEATURE_NAMES=y
>> CONFIG_X86_X2APIC=y
>> CONFIG_X86_MPPARSE=y
>> # CONFIG_GOLDFISH is not set
>> CONFIG_RETPOLINE=y
>> CONFIG_CC_HAS_SLS=y
>> # CONFIG_SLS is not set
>> # CONFIG_X86_CPU_RESCTRL is not set
>> CONFIG_X86_EXTENDED_PLATFORM=y
>> # CONFIG_X86_NUMACHIP is not set
>> # CONFIG_X86_VSMP is not set
>> CONFIG_X86_UV=y
>> # CONFIG_X86_GOLDFISH is not set
>> # CONFIG_X86_INTEL_MID is not set
>> CONFIG_X86_INTEL_LPSS=y
>> # CONFIG_X86_AMD_PLATFORM_DEVICE is not set
>> CONFIG_IOSF_MBI=y
>> # CONFIG_IOSF_MBI_DEBUG is not set
>> CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
>> # CONFIG_SCHED_OMIT_FRAME_POINTER is not set
>> CONFIG_HYPERVISOR_GUEST=y
>> CONFIG_PARAVIRT=y
>> # CONFIG_PARAVIRT_DEBUG is not set
>> CONFIG_PARAVIRT_SPINLOCKS=y
>> CONFIG_X86_HV_CALLBACK_VECTOR=y
>> # CONFIG_XEN is not set
>> CONFIG_KVM_GUEST=y
>> CONFIG_ARCH_CPUIDLE_HALTPOLL=y
>> # CONFIG_PVH is not set
>> CONFIG_PARAVIRT_TIME_ACCOUNTING=y
>> CONFIG_PARAVIRT_CLOCK=y
>> # CONFIG_JAILHOUSE_GUEST is not set
>> # CONFIG_ACRN_GUEST is not set
>> # CONFIG_MK8 is not set
>> # CONFIG_MPSC is not set
>> # CONFIG_MCORE2 is not set
>> # CONFIG_MATOM is not set
>> CONFIG_GENERIC_CPU=y
>> CONFIG_X86_INTERNODE_CACHE_SHIFT=6
>> CONFIG_X86_L1_CACHE_SHIFT=6
>> CONFIG_X86_TSC=y
>> CONFIG_X86_CMPXCHG64=y
>> CONFIG_X86_CMOV=y
>> CONFIG_X86_MINIMUM_CPU_FAMILY=64
>> CONFIG_X86_DEBUGCTLMSR=y
>> CONFIG_IA32_FEAT_CTL=y
>> CONFIG_X86_VMX_FEATURE_NAMES=y
>> CONFIG_CPU_SUP_INTEL=y
>> CONFIG_CPU_SUP_AMD=y
>> CONFIG_CPU_SUP_HYGON=y
>> CONFIG_CPU_SUP_CENTAUR=y
>> CONFIG_CPU_SUP_ZHAOXIN=y
>> CONFIG_HPET_TIMER=y
>> CONFIG_HPET_EMULATE_RTC=y
>> CONFIG_DMI=y
>> # CONFIG_GART_IOMMU is not set
>> CONFIG_MAXSMP=y
>> CONFIG_NR_CPUS_RANGE_BEGIN=8192
>> CONFIG_NR_CPUS_RANGE_END=8192
>> CONFIG_NR_CPUS_DEFAULT=8192
>> CONFIG_NR_CPUS=8192
>> CONFIG_SCHED_CLUSTER=y
>> CONFIG_SCHED_SMT=y
>> CONFIG_SCHED_MC=y
>> CONFIG_SCHED_MC_PRIO=y
>> CONFIG_X86_LOCAL_APIC=y
>> CONFIG_X86_IO_APIC=y
>> CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
>> CONFIG_X86_MCE=y
>> CONFIG_X86_MCELOG_LEGACY=y
>> CONFIG_X86_MCE_INTEL=y
>> # CONFIG_X86_MCE_AMD is not set
>> CONFIG_X86_MCE_THRESHOLD=y
>> CONFIG_X86_MCE_INJECT=m
>>
>> #
>> # Performance monitoring
>> #
>> CONFIG_PERF_EVENTS_INTEL_UNCORE=m
>> CONFIG_PERF_EVENTS_INTEL_RAPL=m
>> CONFIG_PERF_EVENTS_INTEL_CSTATE=m
>> # CONFIG_PERF_EVENTS_AMD_POWER is not set
>> CONFIG_PERF_EVENTS_AMD_UNCORE=y
>> # end of Performance monitoring
>>
>> CONFIG_X86_16BIT=y
>> CONFIG_X86_ESPFIX64=y
>> CONFIG_X86_VSYSCALL_EMULATION=y
>> CONFIG_X86_IOPL_IOPERM=y
>> CONFIG_I8K=m
>> CONFIG_MICROCODE=y
>> CONFIG_MICROCODE_INTEL=y
>> # CONFIG_MICROCODE_AMD is not set
>> CONFIG_MICROCODE_OLD_INTERFACE=y
>> CONFIG_X86_MSR=y
>> CONFIG_X86_CPUID=y
>> CONFIG_X86_5LEVEL=y
>> CONFIG_X86_DIRECT_GBPAGES=y
>> # CONFIG_X86_CPA_STATISTICS is not set
>> # CONFIG_AMD_MEM_ENCRYPT is not set
>> CONFIG_NUMA=y
>> # CONFIG_AMD_NUMA is not set
>> CONFIG_X86_64_ACPI_NUMA=y
>> CONFIG_NUMA_EMU=y
>> CONFIG_NODES_SHIFT=10
>> CONFIG_ARCH_SPARSEMEM_ENABLE=y
>> CONFIG_ARCH_SPARSEMEM_DEFAULT=y
>> CONFIG_ARCH_SELECT_MEMORY_MODEL=y
>> # CONFIG_ARCH_MEMORY_PROBE is not set
>> CONFIG_ARCH_PROC_KCORE_TEXT=y
>> CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
>> CONFIG_X86_PMEM_LEGACY_DEVICE=y
>> CONFIG_X86_PMEM_LEGACY=m
>> CONFIG_X86_CHECK_BIOS_CORRUPTION=y
>> # CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
>> CONFIG_MTRR=y
>> CONFIG_MTRR_SANITIZER=y
>> CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
>> CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
>> CONFIG_X86_PAT=y
>> CONFIG_ARCH_USES_PG_UNCACHED=y
>> CONFIG_ARCH_RANDOM=y
>> CONFIG_X86_SMAP=y
>> CONFIG_X86_UMIP=y
>> CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
>> CONFIG_X86_INTEL_TSX_MODE_OFF=y
>> # CONFIG_X86_INTEL_TSX_MODE_ON is not set
>> # CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
>> # CONFIG_X86_SGX is not set
>> CONFIG_EFI=y
>> CONFIG_EFI_STUB=y
>> CONFIG_EFI_MIXED=y
>> # CONFIG_HZ_100 is not set
>> # CONFIG_HZ_250 is not set
>> # CONFIG_HZ_300 is not set
>> CONFIG_HZ_1000=y
>> CONFIG_HZ=1000
>> CONFIG_SCHED_HRTICK=y
>> CONFIG_KEXEC=y
>> CONFIG_KEXEC_FILE=y
>> CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
>> # CONFIG_KEXEC_SIG is not set
>> CONFIG_CRASH_DUMP=y
>> CONFIG_KEXEC_JUMP=y
>> CONFIG_PHYSICAL_START=0x1000000
>> CONFIG_RELOCATABLE=y
>> CONFIG_RANDOMIZE_BASE=y
>> CONFIG_X86_NEED_RELOCS=y
>> CONFIG_PHYSICAL_ALIGN=0x200000
>> CONFIG_DYNAMIC_MEMORY_LAYOUT=y
>> CONFIG_RANDOMIZE_MEMORY=y
>> CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
>> CONFIG_HOTPLUG_CPU=y
>> CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
>> # CONFIG_DEBUG_HOTPLUG_CPU0 is not set
>> # CONFIG_COMPAT_VDSO is not set
>> CONFIG_LEGACY_VSYSCALL_EMULATE=y
>> # CONFIG_LEGACY_VSYSCALL_XONLY is not set
>> # CONFIG_LEGACY_VSYSCALL_NONE is not set
>> # CONFIG_CMDLINE_BOOL is not set
>> CONFIG_MODIFY_LDT_SYSCALL=y
>> # CONFIG_STRICT_SIGALTSTACK_SIZE is not set
>> CONFIG_HAVE_LIVEPATCH=y
>> CONFIG_LIVEPATCH=y
>> # end of Processor type and features
>>
>> CONFIG_ARCH_HAS_ADD_PAGES=y
>> CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y
>>
>> #
>> # Power management and ACPI options
>> #
>> CONFIG_ARCH_HIBERNATION_HEADER=y
>> CONFIG_SUSPEND=y
>> CONFIG_SUSPEND_FREEZER=y
>> CONFIG_HIBERNATE_CALLBACKS=y
>> CONFIG_HIBERNATION=y
>> CONFIG_HIBERNATION_SNAPSHOT_DEV=y
>> CONFIG_PM_STD_PARTITION=""
>> CONFIG_PM_SLEEP=y
>> CONFIG_PM_SLEEP_SMP=y
>> # CONFIG_PM_AUTOSLEEP is not set
>> # CONFIG_PM_WAKELOCKS is not set
>> CONFIG_PM=y
>> CONFIG_PM_DEBUG=y
>> # CONFIG_PM_ADVANCED_DEBUG is not set
>> # CONFIG_PM_TEST_SUSPEND is not set
>> CONFIG_PM_SLEEP_DEBUG=y
>> # CONFIG_PM_TRACE_RTC is not set
>> CONFIG_PM_CLK=y
>> # CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
>> # CONFIG_ENERGY_MODEL is not set
>> CONFIG_ARCH_SUPPORTS_ACPI=y
>> CONFIG_ACPI=y
>> CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
>> CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
>> CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
>> # CONFIG_ACPI_DEBUGGER is not set
>> CONFIG_ACPI_SPCR_TABLE=y
>> # CONFIG_ACPI_FPDT is not set
>> CONFIG_ACPI_LPIT=y
>> CONFIG_ACPI_SLEEP=y
>> CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
>> CONFIG_ACPI_EC_DEBUGFS=m
>> CONFIG_ACPI_AC=y
>> CONFIG_ACPI_BATTERY=y
>> CONFIG_ACPI_BUTTON=y
>> CONFIG_ACPI_VIDEO=m
>> CONFIG_ACPI_FAN=y
>> CONFIG_ACPI_TAD=m
>> CONFIG_ACPI_DOCK=y
>> CONFIG_ACPI_CPU_FREQ_PSS=y
>> CONFIG_ACPI_PROCESSOR_CSTATE=y
>> CONFIG_ACPI_PROCESSOR_IDLE=y
>> CONFIG_ACPI_CPPC_LIB=y
>> CONFIG_ACPI_PROCESSOR=y
>> CONFIG_ACPI_IPMI=m
>> CONFIG_ACPI_HOTPLUG_CPU=y
>> CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
>> CONFIG_ACPI_THERMAL=y
>> CONFIG_ACPI_PLATFORM_PROFILE=m
>> CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
>> CONFIG_ACPI_TABLE_UPGRADE=y
>> # CONFIG_ACPI_DEBUG is not set
>> CONFIG_ACPI_PCI_SLOT=y
>> CONFIG_ACPI_CONTAINER=y
>> CONFIG_ACPI_HOTPLUG_MEMORY=y
>> CONFIG_ACPI_HOTPLUG_IOAPIC=y
>> CONFIG_ACPI_SBS=m
>> CONFIG_ACPI_HED=y
>> # CONFIG_ACPI_CUSTOM_METHOD is not set
>> CONFIG_ACPI_BGRT=y
>> CONFIG_ACPI_NFIT=m
>> # CONFIG_NFIT_SECURITY_DEBUG is not set
>> CONFIG_ACPI_NUMA=y
>> # CONFIG_ACPI_HMAT is not set
>> CONFIG_HAVE_ACPI_APEI=y
>> CONFIG_HAVE_ACPI_APEI_NMI=y
>> CONFIG_ACPI_APEI=y
>> CONFIG_ACPI_APEI_GHES=y
>> CONFIG_ACPI_APEI_PCIEAER=y
>> CONFIG_ACPI_APEI_MEMORY_FAILURE=y
>> CONFIG_ACPI_APEI_EINJ=m
>> # CONFIG_ACPI_APEI_ERST_DEBUG is not set
>> # CONFIG_ACPI_DPTF is not set
>> CONFIG_ACPI_WATCHDOG=y
>> CONFIG_ACPI_EXTLOG=m
>> CONFIG_ACPI_ADXL=y
>> # CONFIG_ACPI_CONFIGFS is not set
>> # CONFIG_ACPI_PFRUT is not set
>> CONFIG_ACPI_PCC=y
>> CONFIG_PMIC_OPREGION=y
>> CONFIG_X86_PM_TIMER=y
>> CONFIG_ACPI_PRMT=y
>>
>> #
>> # CPU Frequency scaling
>> #
>> CONFIG_CPU_FREQ=y
>> CONFIG_CPU_FREQ_GOV_ATTR_SET=y
>> CONFIG_CPU_FREQ_GOV_COMMON=y
>> CONFIG_CPU_FREQ_STAT=y
>> CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
>> # CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
>> # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
>> # CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
>> CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
>> CONFIG_CPU_FREQ_GOV_POWERSAVE=y
>> CONFIG_CPU_FREQ_GOV_USERSPACE=y
>> CONFIG_CPU_FREQ_GOV_ONDEMAND=y
>> CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
>> CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
>>
>> #
>> # CPU frequency scaling drivers
>> #
>> CONFIG_X86_INTEL_PSTATE=y
>> # CONFIG_X86_PCC_CPUFREQ is not set
>> # CONFIG_X86_AMD_PSTATE is not set
>> CONFIG_X86_ACPI_CPUFREQ=m
>> CONFIG_X86_ACPI_CPUFREQ_CPB=y
>> CONFIG_X86_POWERNOW_K8=m
>> # CONFIG_X86_AMD_FREQ_SENSITIVITY is not set
>> # CONFIG_X86_SPEEDSTEP_CENTRINO is not set
>> CONFIG_X86_P4_CLOCKMOD=m
>>
>> #
>> # shared options
>> #
>> CONFIG_X86_SPEEDSTEP_LIB=m
>> # end of CPU Frequency scaling
>>
>> #
>> # CPU Idle
>> #
>> CONFIG_CPU_IDLE=y
>> # CONFIG_CPU_IDLE_GOV_LADDER is not set
>> CONFIG_CPU_IDLE_GOV_MENU=y
>> # CONFIG_CPU_IDLE_GOV_TEO is not set
>> # CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
>> CONFIG_HALTPOLL_CPUIDLE=y
>> # end of CPU Idle
>>
>> CONFIG_INTEL_IDLE=y
>> # end of Power management and ACPI options
>>
>> #
>> # Bus options (PCI etc.)
>> #
>> CONFIG_PCI_DIRECT=y
>> CONFIG_PCI_MMCONFIG=y
>> CONFIG_MMCONF_FAM10H=y
>> CONFIG_ISA_DMA_API=y
>> CONFIG_AMD_NB=y
>> # end of Bus options (PCI etc.)
>>
>> #
>> # Binary Emulations
>> #
>> CONFIG_IA32_EMULATION=y
>> # CONFIG_X86_X32 is not set
>> CONFIG_COMPAT_32=y
>> CONFIG_COMPAT=y
>> CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
>> CONFIG_SYSVIPC_COMPAT=y
>> # end of Binary Emulations
>>
>> CONFIG_HAVE_KVM=y
>> CONFIG_HAVE_KVM_PFNCACHE=y
>> CONFIG_HAVE_KVM_IRQCHIP=y
>> CONFIG_HAVE_KVM_IRQFD=y
>> CONFIG_HAVE_KVM_IRQ_ROUTING=y
>> CONFIG_HAVE_KVM_DIRTY_RING=y
>> CONFIG_HAVE_KVM_EVENTFD=y
>> CONFIG_KVM_MMIO=y
>> CONFIG_KVM_ASYNC_PF=y
>> CONFIG_HAVE_KVM_MSI=y
>> CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
>> CONFIG_KVM_VFIO=y
>> CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
>> CONFIG_KVM_COMPAT=y
>> CONFIG_HAVE_KVM_IRQ_BYPASS=y
>> CONFIG_HAVE_KVM_NO_POLL=y
>> CONFIG_KVM_XFER_TO_GUEST_WORK=y
>> CONFIG_HAVE_KVM_PM_NOTIFIER=y
>> CONFIG_VIRTUALIZATION=y
>> CONFIG_KVM=m
>> CONFIG_KVM_INTEL=m
>> # CONFIG_KVM_AMD is not set
>> # CONFIG_KVM_XEN is not set
>> CONFIG_KVM_MMU_AUDIT=y
>> CONFIG_AS_AVX512=y
>> CONFIG_AS_SHA1_NI=y
>> CONFIG_AS_SHA256_NI=y
>> CONFIG_AS_TPAUSE=y
>>
>> #
>> # General architecture-dependent options
>> #
>> CONFIG_CRASH_CORE=y
>> CONFIG_KEXEC_CORE=y
>> CONFIG_HOTPLUG_SMT=y
>> CONFIG_GENERIC_ENTRY=y
>> CONFIG_KPROBES=y
>> CONFIG_JUMP_LABEL=y
>> # CONFIG_STATIC_KEYS_SELFTEST is not set
>> # CONFIG_STATIC_CALL_SELFTEST is not set
>> CONFIG_OPTPROBES=y
>> CONFIG_KPROBES_ON_FTRACE=y
>> CONFIG_UPROBES=y
>> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
>> CONFIG_ARCH_USE_BUILTIN_BSWAP=y
>> CONFIG_KRETPROBES=y
>> CONFIG_USER_RETURN_NOTIFIER=y
>> CONFIG_HAVE_IOREMAP_PROT=y
>> CONFIG_HAVE_KPROBES=y
>> CONFIG_HAVE_KRETPROBES=y
>> CONFIG_HAVE_OPTPROBES=y
>> CONFIG_HAVE_KPROBES_ON_FTRACE=y
>> CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
>> CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
>> CONFIG_HAVE_NMI=y
>> CONFIG_TRACE_IRQFLAGS_SUPPORT=y
>> CONFIG_HAVE_ARCH_TRACEHOOK=y
>> CONFIG_HAVE_DMA_CONTIGUOUS=y
>> CONFIG_GENERIC_SMP_IDLE_THREAD=y
>> CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
>> CONFIG_ARCH_HAS_SET_MEMORY=y
>> CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
>> CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
>> CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
>> CONFIG_ARCH_WANTS_NO_INSTR=y
>> CONFIG_HAVE_ASM_MODVERSIONS=y
>> CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
>> CONFIG_HAVE_RSEQ=y
>> CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
>> CONFIG_HAVE_HW_BREAKPOINT=y
>> CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
>> CONFIG_HAVE_USER_RETURN_NOTIFIER=y
>> CONFIG_HAVE_PERF_EVENTS_NMI=y
>> CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
>> CONFIG_HAVE_PERF_REGS=y
>> CONFIG_HAVE_PERF_USER_STACK_DUMP=y
>> CONFIG_HAVE_ARCH_JUMP_LABEL=y
>> CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
>> CONFIG_MMU_GATHER_TABLE_FREE=y
>> CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
>> CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
>> CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
>> CONFIG_HAVE_CMPXCHG_LOCAL=y
>> CONFIG_HAVE_CMPXCHG_DOUBLE=y
>> CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
>> CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
>> CONFIG_HAVE_ARCH_SECCOMP=y
>> CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
>> CONFIG_SECCOMP=y
>> CONFIG_SECCOMP_FILTER=y
>> # CONFIG_SECCOMP_CACHE_DEBUG is not set
>> CONFIG_HAVE_ARCH_STACKLEAK=y
>> CONFIG_HAVE_STACKPROTECTOR=y
>> CONFIG_STACKPROTECTOR=y
>> CONFIG_STACKPROTECTOR_STRONG=y
>> CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
>> CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
>> CONFIG_LTO_NONE=y
>> CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
>> CONFIG_HAVE_CONTEXT_TRACKING=y
>> CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK=y
>> CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
>> CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
>> CONFIG_HAVE_MOVE_PUD=y
>> CONFIG_HAVE_MOVE_PMD=y
>> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
>> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
>> CONFIG_HAVE_ARCH_HUGE_VMAP=y
>> CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
>> CONFIG_HAVE_ARCH_SOFT_DIRTY=y
>> CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
>> CONFIG_MODULES_USE_ELF_RELA=y
>> CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
>> CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
>> CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
>> CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
>> CONFIG_HAVE_EXIT_THREAD=y
>> CONFIG_ARCH_MMAP_RND_BITS=28
>> CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
>> CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
>> CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
>> CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
>> CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
>> CONFIG_HAVE_STACK_VALIDATION=y
>> CONFIG_HAVE_RELIABLE_STACKTRACE=y
>> CONFIG_OLD_SIGSUSPEND3=y
>> CONFIG_COMPAT_OLD_SIGACTION=y
>> CONFIG_COMPAT_32BIT_TIME=y
>> CONFIG_HAVE_ARCH_VMAP_STACK=y
>> CONFIG_VMAP_STACK=y
>> CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
>> # CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
>> CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
>> CONFIG_STRICT_KERNEL_RWX=y
>> CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
>> CONFIG_STRICT_MODULE_RWX=y
>> CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
>> CONFIG_ARCH_USE_MEMREMAP_PROT=y
>> # CONFIG_LOCK_EVENT_COUNTS is not set
>> CONFIG_ARCH_HAS_MEM_ENCRYPT=y
>> CONFIG_HAVE_STATIC_CALL=y
>> CONFIG_HAVE_STATIC_CALL_INLINE=y
>> CONFIG_HAVE_PREEMPT_DYNAMIC=y
>> CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
>> CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
>> CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
>> CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
>> CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
>> CONFIG_DYNAMIC_SIGFRAME=y
>>
>> #
>> # GCOV-based kernel profiling
>> #
>> # CONFIG_GCOV_KERNEL is not set
>> CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
>> # end of GCOV-based kernel profiling
>>
>> CONFIG_HAVE_GCC_PLUGINS=y
>> CONFIG_GCC_PLUGINS=y
>> # CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
>> # CONFIG_GCC_PLUGIN_RANDSTRUCT is not set
>> # end of General architecture-dependent options
>>
>> CONFIG_RT_MUTEXES=y
>> CONFIG_BASE_SMALL=0
>> CONFIG_MODULE_SIG_FORMAT=y
>> CONFIG_MODULES=y
>> CONFIG_MODULE_FORCE_LOAD=y
>> CONFIG_MODULE_UNLOAD=y
>> # CONFIG_MODULE_FORCE_UNLOAD is not set
>> # CONFIG_MODVERSIONS is not set
>> # CONFIG_MODULE_SRCVERSION_ALL is not set
>> CONFIG_MODULE_SIG=y
>> # CONFIG_MODULE_SIG_FORCE is not set
>> CONFIG_MODULE_SIG_ALL=y
>> # CONFIG_MODULE_SIG_SHA1 is not set
>> # CONFIG_MODULE_SIG_SHA224 is not set
>> CONFIG_MODULE_SIG_SHA256=y
>> # CONFIG_MODULE_SIG_SHA384 is not set
>> # CONFIG_MODULE_SIG_SHA512 is not set
>> CONFIG_MODULE_SIG_HASH="sha256"
>> CONFIG_MODULE_COMPRESS_NONE=y
>> # CONFIG_MODULE_COMPRESS_GZIP is not set
>> # CONFIG_MODULE_COMPRESS_XZ is not set
>> # CONFIG_MODULE_COMPRESS_ZSTD is not set
>> # CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
>> CONFIG_MODPROBE_PATH="/sbin/modprobe"
>> CONFIG_MODULES_TREE_LOOKUP=y
>> CONFIG_BLOCK=y
>> CONFIG_BLK_CGROUP_RWSTAT=y
>> CONFIG_BLK_DEV_BSG_COMMON=y
>> CONFIG_BLK_ICQ=y
>> CONFIG_BLK_DEV_BSGLIB=y
>> CONFIG_BLK_DEV_INTEGRITY=y
>> CONFIG_BLK_DEV_INTEGRITY_T10=m
>> # CONFIG_BLK_DEV_ZONED is not set
>> CONFIG_BLK_DEV_THROTTLING=y
>> # CONFIG_BLK_DEV_THROTTLING_LOW is not set
>> CONFIG_BLK_WBT=y
>> CONFIG_BLK_WBT_MQ=y
>> # CONFIG_BLK_CGROUP_IOLATENCY is not set
>> # CONFIG_BLK_CGROUP_FC_APPID is not set
>> # CONFIG_BLK_CGROUP_IOCOST is not set
>> # CONFIG_BLK_CGROUP_IOPRIO is not set
>> CONFIG_BLK_DEBUG_FS=y
>> # CONFIG_BLK_SED_OPAL is not set
>> # CONFIG_BLK_INLINE_ENCRYPTION is not set
>>
>> #
>> # Partition Types
>> #
>> # CONFIG_PARTITION_ADVANCED is not set
>> CONFIG_MSDOS_PARTITION=y
>> CONFIG_EFI_PARTITION=y
>> # end of Partition Types
>>
>> CONFIG_BLOCK_COMPAT=y
>> CONFIG_BLK_MQ_PCI=y
>> CONFIG_BLK_MQ_VIRTIO=y
>> CONFIG_BLK_PM=y
>> CONFIG_BLOCK_HOLDER_DEPRECATED=y
>>
>> #
>> # IO Schedulers
>> #
>> CONFIG_MQ_IOSCHED_DEADLINE=y
>> CONFIG_MQ_IOSCHED_KYBER=y
>> CONFIG_IOSCHED_BFQ=y
>> CONFIG_BFQ_GROUP_IOSCHED=y
>> # CONFIG_BFQ_CGROUP_DEBUG is not set
>> # end of IO Schedulers
>>
>> CONFIG_PREEMPT_NOTIFIERS=y
>> CONFIG_PADATA=y
>> CONFIG_ASN1=y
>> CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
>> CONFIG_INLINE_READ_UNLOCK=y
>> CONFIG_INLINE_READ_UNLOCK_IRQ=y
>> CONFIG_INLINE_WRITE_UNLOCK=y
>> CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
>> CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
>> CONFIG_MUTEX_SPIN_ON_OWNER=y
>> CONFIG_RWSEM_SPIN_ON_OWNER=y
>> CONFIG_LOCK_SPIN_ON_OWNER=y
>> CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
>> CONFIG_QUEUED_SPINLOCKS=y
>> CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
>> CONFIG_QUEUED_RWLOCKS=y
>> CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
>> CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
>> CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
>> CONFIG_FREEZER=y
>>
>> #
>> # Executable file formats
>> #
>> CONFIG_BINFMT_ELF=y
>> CONFIG_COMPAT_BINFMT_ELF=y
>> CONFIG_ELFCORE=y
>> CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
>> CONFIG_BINFMT_SCRIPT=y
>> CONFIG_BINFMT_MISC=m
>> CONFIG_COREDUMP=y
>> # end of Executable file formats
>>
>> #
>> # Memory Management options
>> #
>> CONFIG_SELECT_MEMORY_MODEL=y
>> CONFIG_SPARSEMEM_MANUAL=y
>> CONFIG_SPARSEMEM=y
>> CONFIG_SPARSEMEM_EXTREME=y
>> CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
>> CONFIG_SPARSEMEM_VMEMMAP=y
>> CONFIG_HAVE_FAST_GUP=y
>> CONFIG_NUMA_KEEP_MEMINFO=y
>> CONFIG_MEMORY_ISOLATION=y
>> CONFIG_EXCLUSIVE_SYSTEM_RAM=y
>> CONFIG_HAVE_BOOTMEM_INFO_NODE=y
>> CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
>> CONFIG_MEMORY_HOTPLUG=y
>> # CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
>> CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
>> CONFIG_MEMORY_HOTREMOVE=y
>> CONFIG_MHP_MEMMAP_ON_MEMORY=y
>> CONFIG_SPLIT_PTLOCK_CPUS=4
>> CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
>> CONFIG_MEMORY_BALLOON=y
>> CONFIG_BALLOON_COMPACTION=y
>> CONFIG_COMPACTION=y
>> CONFIG_PAGE_REPORTING=y
>> CONFIG_MIGRATION=y
>> CONFIG_DEVICE_MIGRATION=y
>> CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
>> CONFIG_ARCH_ENABLE_THP_MIGRATION=y
>> CONFIG_CONTIG_ALLOC=y
>> CONFIG_PHYS_ADDR_T_64BIT=y
>> CONFIG_VIRT_TO_BUS=y
>> CONFIG_MMU_NOTIFIER=y
>> CONFIG_KSM=y
>> CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
>> CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
>> CONFIG_MEMORY_FAILURE=y
>> CONFIG_HWPOISON_INJECT=m
>> CONFIG_TRANSPARENT_HUGEPAGE=y
>> CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
>> # CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
>> CONFIG_ARCH_WANTS_THP_SWAP=y
>> CONFIG_THP_SWAP=y
>> CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
>> CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
>> CONFIG_USE_PERCPU_NUMA_NODE_ID=y
>> CONFIG_HAVE_SETUP_PER_CPU_AREA=y
>> CONFIG_FRONTSWAP=y
>> # CONFIG_CMA is not set
>> CONFIG_ZSWAP=y
>> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
>> CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
>> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
>> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
>> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
>> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
>> CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
>> CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
>> # CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
>> # CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
>> CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
>> # CONFIG_ZSWAP_DEFAULT_ON is not set
>> CONFIG_ZPOOL=y
>> CONFIG_ZBUD=y
>> # CONFIG_Z3FOLD is not set
>> CONFIG_ZSMALLOC=y
>> CONFIG_ZSMALLOC_STAT=y
>> CONFIG_GENERIC_EARLY_IOREMAP=y
>> CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
>> CONFIG_PAGE_IDLE_FLAG=y
>> CONFIG_IDLE_PAGE_TRACKING=y
>> CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
>> CONFIG_ARCH_HAS_PTE_DEVMAP=y
>> CONFIG_ZONE_DMA=y
>> CONFIG_ZONE_DMA32=y
>> CONFIG_ZONE_DEVICE=y
>> CONFIG_DEVICE_PRIVATE=y
>> CONFIG_VMAP_PFN=y
>> CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
>> CONFIG_ARCH_HAS_PKEYS=y
>> # CONFIG_PERCPU_STATS is not set
>> # CONFIG_GUP_TEST is not set
>> # CONFIG_READ_ONLY_THP_FOR_FS is not set
>> CONFIG_ARCH_HAS_PTE_SPECIAL=y
>> CONFIG_SECRETMEM=y
>> # CONFIG_ANON_VMA_NAME is not set
>>
>> #
>> # Data Access Monitoring
>> #
>> # CONFIG_DAMON is not set
>> # end of Data Access Monitoring
>> # end of Memory Management options
>>
>> CONFIG_NET=y
>> CONFIG_NET_INGRESS=y
>> CONFIG_NET_EGRESS=y
>> CONFIG_SKB_EXTENSIONS=y
>>
>> #
>> # Networking options
>> #
>> CONFIG_PACKET=y
>> CONFIG_PACKET_DIAG=m
>> CONFIG_UNIX=y
>> CONFIG_UNIX_SCM=y
>> CONFIG_AF_UNIX_OOB=y
>> CONFIG_UNIX_DIAG=m
>> CONFIG_TLS=m
>> CONFIG_TLS_DEVICE=y
>> # CONFIG_TLS_TOE is not set
>> CONFIG_XFRM=y
>> CONFIG_XFRM_OFFLOAD=y
>> CONFIG_XFRM_ALGO=y
>> CONFIG_XFRM_USER=y
>> # CONFIG_XFRM_USER_COMPAT is not set
>> # CONFIG_XFRM_INTERFACE is not set
>> CONFIG_XFRM_SUB_POLICY=y
>> CONFIG_XFRM_MIGRATE=y
>> CONFIG_XFRM_STATISTICS=y
>> CONFIG_XFRM_AH=m
>> CONFIG_XFRM_ESP=m
>> CONFIG_XFRM_IPCOMP=m
>> CONFIG_NET_KEY=m
>> CONFIG_NET_KEY_MIGRATE=y
>> CONFIG_XDP_SOCKETS=y
>> # CONFIG_XDP_SOCKETS_DIAG is not set
>> CONFIG_INET=y
>> CONFIG_IP_MULTICAST=y
>> CONFIG_IP_ADVANCED_ROUTER=y
>> CONFIG_IP_FIB_TRIE_STATS=y
>> CONFIG_IP_MULTIPLE_TABLES=y
>> CONFIG_IP_ROUTE_MULTIPATH=y
>> CONFIG_IP_ROUTE_VERBOSE=y
>> CONFIG_IP_ROUTE_CLASSID=y
>> CONFIG_IP_PNP=y
>> CONFIG_IP_PNP_DHCP=y
>> # CONFIG_IP_PNP_BOOTP is not set
>> # CONFIG_IP_PNP_RARP is not set
>> CONFIG_NET_IPIP=m
>> CONFIG_NET_IPGRE_DEMUX=m
>> CONFIG_NET_IP_TUNNEL=m
>> CONFIG_NET_IPGRE=m
>> CONFIG_NET_IPGRE_BROADCAST=y
>> CONFIG_IP_MROUTE_COMMON=y
>> CONFIG_IP_MROUTE=y
>> CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
>> CONFIG_IP_PIMSM_V1=y
>> CONFIG_IP_PIMSM_V2=y
>> CONFIG_SYN_COOKIES=y
>> CONFIG_NET_IPVTI=m
>> CONFIG_NET_UDP_TUNNEL=m
>> # CONFIG_NET_FOU is not set
>> # CONFIG_NET_FOU_IP_TUNNELS is not set
>> CONFIG_INET_AH=m
>> CONFIG_INET_ESP=m
>> CONFIG_INET_ESP_OFFLOAD=m
>> # CONFIG_INET_ESPINTCP is not set
>> CONFIG_INET_IPCOMP=m
>> CONFIG_INET_XFRM_TUNNEL=m
>> CONFIG_INET_TUNNEL=m
>> CONFIG_INET_DIAG=m
>> CONFIG_INET_TCP_DIAG=m
>> CONFIG_INET_UDP_DIAG=m
>> CONFIG_INET_RAW_DIAG=m
>> # CONFIG_INET_DIAG_DESTROY is not set
>> CONFIG_TCP_CONG_ADVANCED=y
>> CONFIG_TCP_CONG_BIC=m
>> CONFIG_TCP_CONG_CUBIC=y
>> CONFIG_TCP_CONG_WESTWOOD=m
>> CONFIG_TCP_CONG_HTCP=m
>> CONFIG_TCP_CONG_HSTCP=m
>> CONFIG_TCP_CONG_HYBLA=m
>> CONFIG_TCP_CONG_VEGAS=m
>> CONFIG_TCP_CONG_NV=m
>> CONFIG_TCP_CONG_SCALABLE=m
>> CONFIG_TCP_CONG_LP=m
>> CONFIG_TCP_CONG_VENO=m
>> CONFIG_TCP_CONG_YEAH=m
>> CONFIG_TCP_CONG_ILLINOIS=m
>> CONFIG_TCP_CONG_DCTCP=m
>> # CONFIG_TCP_CONG_CDG is not set
>> CONFIG_TCP_CONG_BBR=m
>> CONFIG_DEFAULT_CUBIC=y
>> # CONFIG_DEFAULT_RENO is not set
>> CONFIG_DEFAULT_TCP_CONG="cubic"
>> CONFIG_TCP_MD5SIG=y
>> CONFIG_IPV6=y
>> CONFIG_IPV6_ROUTER_PREF=y
>> CONFIG_IPV6_ROUTE_INFO=y
>> CONFIG_IPV6_OPTIMISTIC_DAD=y
>> CONFIG_INET6_AH=m
>> CONFIG_INET6_ESP=m
>> CONFIG_INET6_ESP_OFFLOAD=m
>> # CONFIG_INET6_ESPINTCP is not set
>> CONFIG_INET6_IPCOMP=m
>> CONFIG_IPV6_MIP6=m
>> # CONFIG_IPV6_ILA is not set
>> CONFIG_INET6_XFRM_TUNNEL=m
>> CONFIG_INET6_TUNNEL=m
>> CONFIG_IPV6_VTI=m
>> CONFIG_IPV6_SIT=m
>> CONFIG_IPV6_SIT_6RD=y
>> CONFIG_IPV6_NDISC_NODETYPE=y
>> CONFIG_IPV6_TUNNEL=m
>> CONFIG_IPV6_GRE=m
>> CONFIG_IPV6_MULTIPLE_TABLES=y
>> # CONFIG_IPV6_SUBTREES is not set
>> CONFIG_IPV6_MROUTE=y
>> CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
>> CONFIG_IPV6_PIMSM_V2=y
>> # CONFIG_IPV6_SEG6_LWTUNNEL is not set
>> # CONFIG_IPV6_SEG6_HMAC is not set
>> # CONFIG_IPV6_RPL_LWTUNNEL is not set
>> # CONFIG_IPV6_IOAM6_LWTUNNEL is not set
>> CONFIG_NETLABEL=y
>> # CONFIG_MPTCP is not set
>> CONFIG_NETWORK_SECMARK=y
>> CONFIG_NET_PTP_CLASSIFY=y
>> CONFIG_NETWORK_PHY_TIMESTAMPING=y
>> CONFIG_NETFILTER=y
>> CONFIG_NETFILTER_ADVANCED=y
>> CONFIG_BRIDGE_NETFILTER=m
>>
>> #
>> # Core Netfilter Configuration
>> #
>> CONFIG_NETFILTER_INGRESS=y
>> CONFIG_NETFILTER_EGRESS=y
>> CONFIG_NETFILTER_SKIP_EGRESS=y
>> CONFIG_NETFILTER_NETLINK=m
>> CONFIG_NETFILTER_FAMILY_BRIDGE=y
>> CONFIG_NETFILTER_FAMILY_ARP=y
>> # CONFIG_NETFILTER_NETLINK_HOOK is not set
>> # CONFIG_NETFILTER_NETLINK_ACCT is not set
>> CONFIG_NETFILTER_NETLINK_QUEUE=m
>> CONFIG_NETFILTER_NETLINK_LOG=m
>> CONFIG_NETFILTER_NETLINK_OSF=m
>> CONFIG_NF_CONNTRACK=m
>> CONFIG_NF_LOG_SYSLOG=m
>> CONFIG_NETFILTER_CONNCOUNT=m
>> CONFIG_NF_CONNTRACK_MARK=y
>> CONFIG_NF_CONNTRACK_SECMARK=y
>> CONFIG_NF_CONNTRACK_ZONES=y
>> CONFIG_NF_CONNTRACK_PROCFS=y
>> CONFIG_NF_CONNTRACK_EVENTS=y
>> CONFIG_NF_CONNTRACK_TIMEOUT=y
>> CONFIG_NF_CONNTRACK_TIMESTAMP=y
>> CONFIG_NF_CONNTRACK_LABELS=y
>> CONFIG_NF_CT_PROTO_DCCP=y
>> CONFIG_NF_CT_PROTO_GRE=y
>> CONFIG_NF_CT_PROTO_SCTP=y
>> CONFIG_NF_CT_PROTO_UDPLITE=y
>> CONFIG_NF_CONNTRACK_AMANDA=m
>> CONFIG_NF_CONNTRACK_FTP=m
>> CONFIG_NF_CONNTRACK_H323=m
>> CONFIG_NF_CONNTRACK_IRC=m
>> CONFIG_NF_CONNTRACK_BROADCAST=m
>> CONFIG_NF_CONNTRACK_NETBIOS_NS=m
>> CONFIG_NF_CONNTRACK_SNMP=m
>> CONFIG_NF_CONNTRACK_PPTP=m
>> CONFIG_NF_CONNTRACK_SANE=m
>> CONFIG_NF_CONNTRACK_SIP=m
>> CONFIG_NF_CONNTRACK_TFTP=m
>> CONFIG_NF_CT_NETLINK=m
>> CONFIG_NF_CT_NETLINK_TIMEOUT=m
>> CONFIG_NF_CT_NETLINK_HELPER=m
>> CONFIG_NETFILTER_NETLINK_GLUE_CT=y
>> CONFIG_NF_NAT=m
>> CONFIG_NF_NAT_AMANDA=m
>> CONFIG_NF_NAT_FTP=m
>> CONFIG_NF_NAT_IRC=m
>> CONFIG_NF_NAT_SIP=m
>> CONFIG_NF_NAT_TFTP=m
>> CONFIG_NF_NAT_REDIRECT=y
>> CONFIG_NF_NAT_MASQUERADE=y
>> CONFIG_NETFILTER_SYNPROXY=m
>> CONFIG_NF_TABLES=m
>> CONFIG_NF_TABLES_INET=y
>> CONFIG_NF_TABLES_NETDEV=y
>> CONFIG_NFT_NUMGEN=m
>> CONFIG_NFT_CT=m
>> CONFIG_NFT_CONNLIMIT=m
>> CONFIG_NFT_LOG=m
>> CONFIG_NFT_LIMIT=m
>> CONFIG_NFT_MASQ=m
>> CONFIG_NFT_REDIR=m
>> CONFIG_NFT_NAT=m
>> # CONFIG_NFT_TUNNEL is not set
>> CONFIG_NFT_OBJREF=m
>> CONFIG_NFT_QUEUE=m
>> CONFIG_NFT_QUOTA=m
>> CONFIG_NFT_REJECT=m
>> CONFIG_NFT_REJECT_INET=m
>> CONFIG_NFT_COMPAT=m
>> CONFIG_NFT_HASH=m
>> CONFIG_NFT_FIB=m
>> CONFIG_NFT_FIB_INET=m
>> # CONFIG_NFT_XFRM is not set
>> CONFIG_NFT_SOCKET=m
>> # CONFIG_NFT_OSF is not set
>> # CONFIG_NFT_TPROXY is not set
>> # CONFIG_NFT_SYNPROXY is not set
>> CONFIG_NF_DUP_NETDEV=m
>> CONFIG_NFT_DUP_NETDEV=m
>> CONFIG_NFT_FWD_NETDEV=m
>> CONFIG_NFT_FIB_NETDEV=m
>> # CONFIG_NFT_REJECT_NETDEV is not set
>> # CONFIG_NF_FLOW_TABLE is not set
>> CONFIG_NETFILTER_XTABLES=y
>> CONFIG_NETFILTER_XTABLES_COMPAT=y
>>
>> #
>> # Xtables combined modules
>> #
>> CONFIG_NETFILTER_XT_MARK=m
>> CONFIG_NETFILTER_XT_CONNMARK=m
>> CONFIG_NETFILTER_XT_SET=m
>>
>> #
>> # Xtables targets
>> #
>> CONFIG_NETFILTER_XT_TARGET_AUDIT=m
>> CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
>> CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
>> CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
>> CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
>> CONFIG_NETFILTER_XT_TARGET_CT=m
>> CONFIG_NETFILTER_XT_TARGET_DSCP=m
>> CONFIG_NETFILTER_XT_TARGET_HL=m
>> CONFIG_NETFILTER_XT_TARGET_HMARK=m
>> CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
>> # CONFIG_NETFILTER_XT_TARGET_LED is not set
>> CONFIG_NETFILTER_XT_TARGET_LOG=m
>> CONFIG_NETFILTER_XT_TARGET_MARK=m
>> CONFIG_NETFILTER_XT_NAT=m
>> CONFIG_NETFILTER_XT_TARGET_NETMAP=m
>> CONFIG_NETFILTER_XT_TARGET_NFLOG=m
>> CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
>> CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
>> CONFIG_NETFILTER_XT_TARGET_RATEEST=m
>> CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
>> CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
>> CONFIG_NETFILTER_XT_TARGET_TEE=m
>> CONFIG_NETFILTER_XT_TARGET_TPROXY=m
>> CONFIG_NETFILTER_XT_TARGET_TRACE=m
>> CONFIG_NETFILTER_XT_TARGET_SECMARK=m
>> CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
>> CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m
>>
>> #
>> # Xtables matches
>> #
>> CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
>> CONFIG_NETFILTER_XT_MATCH_BPF=m
>> CONFIG_NETFILTER_XT_MATCH_CGROUP=m
>> CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
>> CONFIG_NETFILTER_XT_MATCH_COMMENT=m
>> CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
>> CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
>> CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
>> CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
>> CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
>> CONFIG_NETFILTER_XT_MATCH_CPU=m
>> CONFIG_NETFILTER_XT_MATCH_DCCP=m
>> CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
>> CONFIG_NETFILTER_XT_MATCH_DSCP=m
>> CONFIG_NETFILTER_XT_MATCH_ECN=m
>> CONFIG_NETFILTER_XT_MATCH_ESP=m
>> CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
>> CONFIG_NETFILTER_XT_MATCH_HELPER=m
>> CONFIG_NETFILTER_XT_MATCH_HL=m
>> # CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
>> CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
>> CONFIG_NETFILTER_XT_MATCH_IPVS=m
>> # CONFIG_NETFILTER_XT_MATCH_L2TP is not set
>> CONFIG_NETFILTER_XT_MATCH_LENGTH=m
>> CONFIG_NETFILTER_XT_MATCH_LIMIT=m
>> CONFIG_NETFILTER_XT_MATCH_MAC=m
>> CONFIG_NETFILTER_XT_MATCH_MARK=m
>> CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
>> # CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
>> CONFIG_NETFILTER_XT_MATCH_OSF=m
>> CONFIG_NETFILTER_XT_MATCH_OWNER=m
>> CONFIG_NETFILTER_XT_MATCH_POLICY=m
>> CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
>> CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
>> CONFIG_NETFILTER_XT_MATCH_QUOTA=m
>> CONFIG_NETFILTER_XT_MATCH_RATEEST=m
>> CONFIG_NETFILTER_XT_MATCH_REALM=m
>> CONFIG_NETFILTER_XT_MATCH_RECENT=m
>> CONFIG_NETFILTER_XT_MATCH_SCTP=m
>> CONFIG_NETFILTER_XT_MATCH_SOCKET=m
>> CONFIG_NETFILTER_XT_MATCH_STATE=m
>> CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
>> CONFIG_NETFILTER_XT_MATCH_STRING=m
>> CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
>> # CONFIG_NETFILTER_XT_MATCH_TIME is not set
>> # CONFIG_NETFILTER_XT_MATCH_U32 is not set
>> # end of Core Netfilter Configuration
>>
>> CONFIG_IP_SET=m
>> CONFIG_IP_SET_MAX=256
>> CONFIG_IP_SET_BITMAP_IP=m
>> CONFIG_IP_SET_BITMAP_IPMAC=m
>> CONFIG_IP_SET_BITMAP_PORT=m
>> CONFIG_IP_SET_HASH_IP=m
>> CONFIG_IP_SET_HASH_IPMARK=m
>> CONFIG_IP_SET_HASH_IPPORT=m
>> CONFIG_IP_SET_HASH_IPPORTIP=m
>> CONFIG_IP_SET_HASH_IPPORTNET=m
>> CONFIG_IP_SET_HASH_IPMAC=m
>> CONFIG_IP_SET_HASH_MAC=m
>> CONFIG_IP_SET_HASH_NETPORTNET=m
>> CONFIG_IP_SET_HASH_NET=m
>> CONFIG_IP_SET_HASH_NETNET=m
>> CONFIG_IP_SET_HASH_NETPORT=m
>> CONFIG_IP_SET_HASH_NETIFACE=m
>> CONFIG_IP_SET_LIST_SET=m
>> CONFIG_IP_VS=m
>> CONFIG_IP_VS_IPV6=y
>> # CONFIG_IP_VS_DEBUG is not set
>> CONFIG_IP_VS_TAB_BITS=12
>>
>> #
>> # IPVS transport protocol load balancing support
>> #
>> CONFIG_IP_VS_PROTO_TCP=y
>> CONFIG_IP_VS_PROTO_UDP=y
>> CONFIG_IP_VS_PROTO_AH_ESP=y
>> CONFIG_IP_VS_PROTO_ESP=y
>> CONFIG_IP_VS_PROTO_AH=y
>> CONFIG_IP_VS_PROTO_SCTP=y
>>
>> #
>> # IPVS scheduler
>> #
>> CONFIG_IP_VS_RR=m
>> CONFIG_IP_VS_WRR=m
>> CONFIG_IP_VS_LC=m
>> CONFIG_IP_VS_WLC=m
>> CONFIG_IP_VS_FO=m
>> CONFIG_IP_VS_OVF=m
>> CONFIG_IP_VS_LBLC=m
>> CONFIG_IP_VS_LBLCR=m
>> CONFIG_IP_VS_DH=m
>> CONFIG_IP_VS_SH=m
>> # CONFIG_IP_VS_MH is not set
>> CONFIG_IP_VS_SED=m
>> CONFIG_IP_VS_NQ=m
>> # CONFIG_IP_VS_TWOS is not set
>>
>> #
>> # IPVS SH scheduler
>> #
>> CONFIG_IP_VS_SH_TAB_BITS=8
>>
>> #
>> # IPVS MH scheduler
>> #
>> CONFIG_IP_VS_MH_TAB_INDEX=12
>>
>> #
>> # IPVS application helper
>> #
>> CONFIG_IP_VS_FTP=m
>> CONFIG_IP_VS_NFCT=y
>> CONFIG_IP_VS_PE_SIP=m
>>
>> #
>> # IP: Netfilter Configuration
>> #
>> CONFIG_NF_DEFRAG_IPV4=m
>> CONFIG_NF_SOCKET_IPV4=m
>> CONFIG_NF_TPROXY_IPV4=m
>> CONFIG_NF_TABLES_IPV4=y
>> CONFIG_NFT_REJECT_IPV4=m
>> CONFIG_NFT_DUP_IPV4=m
>> CONFIG_NFT_FIB_IPV4=m
>> CONFIG_NF_TABLES_ARP=y
>> CONFIG_NF_DUP_IPV4=m
>> CONFIG_NF_LOG_ARP=m
>> CONFIG_NF_LOG_IPV4=m
>> CONFIG_NF_REJECT_IPV4=m
>> CONFIG_NF_NAT_SNMP_BASIC=m
>> CONFIG_NF_NAT_PPTP=m
>> CONFIG_NF_NAT_H323=m
>> CONFIG_IP_NF_IPTABLES=m
>> CONFIG_IP_NF_MATCH_AH=m
>> CONFIG_IP_NF_MATCH_ECN=m
>> CONFIG_IP_NF_MATCH_RPFILTER=m
>> CONFIG_IP_NF_MATCH_TTL=m
>> CONFIG_IP_NF_FILTER=m
>> CONFIG_IP_NF_TARGET_REJECT=m
>> CONFIG_IP_NF_TARGET_SYNPROXY=m
>> CONFIG_IP_NF_NAT=m
>> CONFIG_IP_NF_TARGET_MASQUERADE=m
>> CONFIG_IP_NF_TARGET_NETMAP=m
>> CONFIG_IP_NF_TARGET_REDIRECT=m
>> CONFIG_IP_NF_MANGLE=m
>> # CONFIG_IP_NF_TARGET_CLUSTERIP is not set
>> CONFIG_IP_NF_TARGET_ECN=m
>> CONFIG_IP_NF_TARGET_TTL=m
>> CONFIG_IP_NF_RAW=m
>> CONFIG_IP_NF_SECURITY=m
>> CONFIG_IP_NF_ARPTABLES=m
>> CONFIG_IP_NF_ARPFILTER=m
>> CONFIG_IP_NF_ARP_MANGLE=m
>> # end of IP: Netfilter Configuration
>>
>> #
>> # IPv6: Netfilter Configuration
>> #
>> CONFIG_NF_SOCKET_IPV6=m
>> CONFIG_NF_TPROXY_IPV6=m
>> CONFIG_NF_TABLES_IPV6=y
>> CONFIG_NFT_REJECT_IPV6=m
>> CONFIG_NFT_DUP_IPV6=m
>> CONFIG_NFT_FIB_IPV6=m
>> CONFIG_NF_DUP_IPV6=m
>> CONFIG_NF_REJECT_IPV6=m
>> CONFIG_NF_LOG_IPV6=m
>> CONFIG_IP6_NF_IPTABLES=m
>> CONFIG_IP6_NF_MATCH_AH=m
>> CONFIG_IP6_NF_MATCH_EUI64=m
>> CONFIG_IP6_NF_MATCH_FRAG=m
>> CONFIG_IP6_NF_MATCH_OPTS=m
>> CONFIG_IP6_NF_MATCH_HL=m
>> CONFIG_IP6_NF_MATCH_IPV6HEADER=m
>> CONFIG_IP6_NF_MATCH_MH=m
>> CONFIG_IP6_NF_MATCH_RPFILTER=m
>> CONFIG_IP6_NF_MATCH_RT=m
>> # CONFIG_IP6_NF_MATCH_SRH is not set
>> # CONFIG_IP6_NF_TARGET_HL is not set
>> CONFIG_IP6_NF_FILTER=m
>> CONFIG_IP6_NF_TARGET_REJECT=m
>> CONFIG_IP6_NF_TARGET_SYNPROXY=m
>> CONFIG_IP6_NF_MANGLE=m
>> CONFIG_IP6_NF_RAW=m
>> CONFIG_IP6_NF_SECURITY=m
>> CONFIG_IP6_NF_NAT=m
>> CONFIG_IP6_NF_TARGET_MASQUERADE=m
>> CONFIG_IP6_NF_TARGET_NPT=m
>> # end of IPv6: Netfilter Configuration
>>
>> CONFIG_NF_DEFRAG_IPV6=m
>> CONFIG_NF_TABLES_BRIDGE=m
>> # CONFIG_NFT_BRIDGE_META is not set
>> CONFIG_NFT_BRIDGE_REJECT=m
>> # CONFIG_NF_CONNTRACK_BRIDGE is not set
>> CONFIG_BRIDGE_NF_EBTABLES=m
>> CONFIG_BRIDGE_EBT_BROUTE=m
>> CONFIG_BRIDGE_EBT_T_FILTER=m
>> CONFIG_BRIDGE_EBT_T_NAT=m
>> CONFIG_BRIDGE_EBT_802_3=m
>> CONFIG_BRIDGE_EBT_AMONG=m
>> CONFIG_BRIDGE_EBT_ARP=m
>> CONFIG_BRIDGE_EBT_IP=m
>> CONFIG_BRIDGE_EBT_IP6=m
>> CONFIG_BRIDGE_EBT_LIMIT=m
>> CONFIG_BRIDGE_EBT_MARK=m
>> CONFIG_BRIDGE_EBT_PKTTYPE=m
>> CONFIG_BRIDGE_EBT_STP=m
>> CONFIG_BRIDGE_EBT_VLAN=m
>> CONFIG_BRIDGE_EBT_ARPREPLY=m
>> CONFIG_BRIDGE_EBT_DNAT=m
>> CONFIG_BRIDGE_EBT_MARK_T=m
>> CONFIG_BRIDGE_EBT_REDIRECT=m
>> CONFIG_BRIDGE_EBT_SNAT=m
>> CONFIG_BRIDGE_EBT_LOG=m
>> CONFIG_BRIDGE_EBT_NFLOG=m
>> # CONFIG_BPFILTER is not set
>> CONFIG_IP_DCCP=y
>> CONFIG_INET_DCCP_DIAG=m
>>
>> #
>> # DCCP CCIDs Configuration
>> #
>> # CONFIG_IP_DCCP_CCID2_DEBUG is not set
>> CONFIG_IP_DCCP_CCID3=y
>> # CONFIG_IP_DCCP_CCID3_DEBUG is not set
>> CONFIG_IP_DCCP_TFRC_LIB=y
>> # end of DCCP CCIDs Configuration
>>
>> #
>> # DCCP Kernel Hacking
>> #
>> # CONFIG_IP_DCCP_DEBUG is not set
>> # end of DCCP Kernel Hacking
>>
>> CONFIG_IP_SCTP=m
>> # CONFIG_SCTP_DBG_OBJCNT is not set
>> # CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
>> CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
>> # CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
>> CONFIG_SCTP_COOKIE_HMAC_MD5=y
>> CONFIG_SCTP_COOKIE_HMAC_SHA1=y
>> CONFIG_INET_SCTP_DIAG=m
>> # CONFIG_RDS is not set
>> CONFIG_TIPC=m
>> CONFIG_TIPC_MEDIA_UDP=y
>> CONFIG_TIPC_CRYPTO=y
>> CONFIG_TIPC_DIAG=m
>> CONFIG_ATM=m
>> CONFIG_ATM_CLIP=m
>> # CONFIG_ATM_CLIP_NO_ICMP is not set
>> CONFIG_ATM_LANE=m
>> # CONFIG_ATM_MPOA is not set
>> CONFIG_ATM_BR2684=m
>> # CONFIG_ATM_BR2684_IPFILTER is not set
>> CONFIG_L2TP=m
>> CONFIG_L2TP_DEBUGFS=m
>> CONFIG_L2TP_V3=y
>> CONFIG_L2TP_IP=m
>> CONFIG_L2TP_ETH=m
>> CONFIG_STP=m
>> CONFIG_GARP=m
>> CONFIG_MRP=m
>> CONFIG_BRIDGE=m
>> CONFIG_BRIDGE_IGMP_SNOOPING=y
>> CONFIG_BRIDGE_VLAN_FILTERING=y
>> # CONFIG_BRIDGE_MRP is not set
>> # CONFIG_BRIDGE_CFM is not set
>> # CONFIG_NET_DSA is not set
>> CONFIG_VLAN_8021Q=m
>> CONFIG_VLAN_8021Q_GVRP=y
>> CONFIG_VLAN_8021Q_MVRP=y
>> # CONFIG_DECNET is not set
>> CONFIG_LLC=m
>> # CONFIG_LLC2 is not set
>> # CONFIG_ATALK is not set
>> # CONFIG_X25 is not set
>> # CONFIG_LAPB is not set
>> # CONFIG_PHONET is not set
>> CONFIG_6LOWPAN=m
>> # CONFIG_6LOWPAN_DEBUGFS is not set
>> # CONFIG_6LOWPAN_NHC is not set
>> CONFIG_IEEE802154=m
>> # CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
>> CONFIG_IEEE802154_SOCKET=m
>> CONFIG_IEEE802154_6LOWPAN=m
>> CONFIG_MAC802154=m
>> CONFIG_NET_SCHED=y
>>
>> #
>> # Queueing/Scheduling
>> #
>> CONFIG_NET_SCH_CBQ=m
>> CONFIG_NET_SCH_HTB=m
>> CONFIG_NET_SCH_HFSC=m
>> CONFIG_NET_SCH_ATM=m
>> CONFIG_NET_SCH_PRIO=m
>> CONFIG_NET_SCH_MULTIQ=m
>> CONFIG_NET_SCH_RED=m
>> CONFIG_NET_SCH_SFB=m
>> CONFIG_NET_SCH_SFQ=m
>> CONFIG_NET_SCH_TEQL=m
>> CONFIG_NET_SCH_TBF=m
>> # CONFIG_NET_SCH_CBS is not set
>> # CONFIG_NET_SCH_ETF is not set
>> # CONFIG_NET_SCH_TAPRIO is not set
>> CONFIG_NET_SCH_GRED=m
>> CONFIG_NET_SCH_DSMARK=m
>> CONFIG_NET_SCH_NETEM=m
>> CONFIG_NET_SCH_DRR=m
>> CONFIG_NET_SCH_MQPRIO=m
>> # CONFIG_NET_SCH_SKBPRIO is not set
>> CONFIG_NET_SCH_CHOKE=m
>> CONFIG_NET_SCH_QFQ=m
>> CONFIG_NET_SCH_CODEL=m
>> CONFIG_NET_SCH_FQ_CODEL=y
>> # CONFIG_NET_SCH_CAKE is not set
>> CONFIG_NET_SCH_FQ=m
>> CONFIG_NET_SCH_HHF=m
>> CONFIG_NET_SCH_PIE=m
>> # CONFIG_NET_SCH_FQ_PIE is not set
>> CONFIG_NET_SCH_INGRESS=m
>> CONFIG_NET_SCH_PLUG=m
>> # CONFIG_NET_SCH_ETS is not set
>> CONFIG_NET_SCH_DEFAULT=y
>> # CONFIG_DEFAULT_FQ is not set
>> # CONFIG_DEFAULT_CODEL is not set
>> CONFIG_DEFAULT_FQ_CODEL=y
>> # CONFIG_DEFAULT_SFQ is not set
>> # CONFIG_DEFAULT_PFIFO_FAST is not set
>> CONFIG_DEFAULT_NET_SCH="fq_codel"
>>
>> #
>> # Classification
>> #
>> CONFIG_NET_CLS=y
>> CONFIG_NET_CLS_BASIC=m
>> CONFIG_NET_CLS_TCINDEX=m
>> CONFIG_NET_CLS_ROUTE4=m
>> CONFIG_NET_CLS_FW=m
>> CONFIG_NET_CLS_U32=m
>> CONFIG_CLS_U32_PERF=y
>> CONFIG_CLS_U32_MARK=y
>> CONFIG_NET_CLS_RSVP=m
>> CONFIG_NET_CLS_RSVP6=m
>> CONFIG_NET_CLS_FLOW=m
>> CONFIG_NET_CLS_CGROUP=y
>> CONFIG_NET_CLS_BPF=m
>> CONFIG_NET_CLS_FLOWER=m
>> CONFIG_NET_CLS_MATCHALL=m
>> CONFIG_NET_EMATCH=y
>> CONFIG_NET_EMATCH_STACK=32
>> CONFIG_NET_EMATCH_CMP=m
>> CONFIG_NET_EMATCH_NBYTE=m
>> CONFIG_NET_EMATCH_U32=m
>> CONFIG_NET_EMATCH_META=m
>> CONFIG_NET_EMATCH_TEXT=m
>> # CONFIG_NET_EMATCH_CANID is not set
>> CONFIG_NET_EMATCH_IPSET=m
>> # CONFIG_NET_EMATCH_IPT is not set
>> CONFIG_NET_CLS_ACT=y
>> CONFIG_NET_ACT_POLICE=m
>> CONFIG_NET_ACT_GACT=m
>> CONFIG_GACT_PROB=y
>> CONFIG_NET_ACT_MIRRED=m
>> CONFIG_NET_ACT_SAMPLE=m
>> # CONFIG_NET_ACT_IPT is not set
>> CONFIG_NET_ACT_NAT=m
>> CONFIG_NET_ACT_PEDIT=m
>> CONFIG_NET_ACT_SIMP=m
>> CONFIG_NET_ACT_SKBEDIT=m
>> CONFIG_NET_ACT_CSUM=m
>> # CONFIG_NET_ACT_MPLS is not set
>> CONFIG_NET_ACT_VLAN=m
>> CONFIG_NET_ACT_BPF=m
>> # CONFIG_NET_ACT_CONNMARK is not set
>> # CONFIG_NET_ACT_CTINFO is not set
>> CONFIG_NET_ACT_SKBMOD=m
>> # CONFIG_NET_ACT_IFE is not set
>> CONFIG_NET_ACT_TUNNEL_KEY=m
>> # CONFIG_NET_ACT_GATE is not set
>> # CONFIG_NET_TC_SKB_EXT is not set
>> CONFIG_NET_SCH_FIFO=y
>> CONFIG_DCB=y
>> CONFIG_DNS_RESOLVER=m
>> # CONFIG_BATMAN_ADV is not set
>> CONFIG_OPENVSWITCH=m
>> CONFIG_OPENVSWITCH_GRE=m
>> CONFIG_VSOCKETS=m
>> CONFIG_VSOCKETS_DIAG=m
>> CONFIG_VSOCKETS_LOOPBACK=m
>> CONFIG_VMWARE_VMCI_VSOCKETS=m
>> CONFIG_VIRTIO_VSOCKETS=m
>> CONFIG_VIRTIO_VSOCKETS_COMMON=m
>> CONFIG_NETLINK_DIAG=m
>> CONFIG_MPLS=y
>> CONFIG_NET_MPLS_GSO=y
>> CONFIG_MPLS_ROUTING=m
>> CONFIG_MPLS_IPTUNNEL=m
>> CONFIG_NET_NSH=y
>> # CONFIG_HSR is not set
>> CONFIG_NET_SWITCHDEV=y
>> CONFIG_NET_L3_MASTER_DEV=y
>> # CONFIG_QRTR is not set
>> # CONFIG_NET_NCSI is not set
>> CONFIG_PCPU_DEV_REFCNT=y
>> CONFIG_RPS=y
>> CONFIG_RFS_ACCEL=y
>> CONFIG_SOCK_RX_QUEUE_MAPPING=y
>> CONFIG_XPS=y
>> CONFIG_CGROUP_NET_PRIO=y
>> CONFIG_CGROUP_NET_CLASSID=y
>> CONFIG_NET_RX_BUSY_POLL=y
>> CONFIG_BQL=y
>> CONFIG_BPF_STREAM_PARSER=y
>> CONFIG_NET_FLOW_LIMIT=y
>>
>> #
>> # Network testing
>> #
>> CONFIG_NET_PKTGEN=m
>> CONFIG_NET_DROP_MONITOR=y
>> # end of Network testing
>> # end of Networking options
>>
>> # CONFIG_HAMRADIO is not set
>> CONFIG_CAN=m
>> CONFIG_CAN_RAW=m
>> CONFIG_CAN_BCM=m
>> CONFIG_CAN_GW=m
>> # CONFIG_CAN_J1939 is not set
>> # CONFIG_CAN_ISOTP is not set
>>
>> #
>> # CAN Device Drivers
>> #
>> CONFIG_CAN_VCAN=m
>> # CONFIG_CAN_VXCAN is not set
>> CONFIG_CAN_SLCAN=m
>> CONFIG_CAN_DEV=m
>> CONFIG_CAN_CALC_BITTIMING=y
>> # CONFIG_CAN_KVASER_PCIEFD is not set
>> CONFIG_CAN_C_CAN=m
>> CONFIG_CAN_C_CAN_PLATFORM=m
>> CONFIG_CAN_C_CAN_PCI=m
>> CONFIG_CAN_CC770=m
>> # CONFIG_CAN_CC770_ISA is not set
>> CONFIG_CAN_CC770_PLATFORM=m
>> # CONFIG_CAN_IFI_CANFD is not set
>> # CONFIG_CAN_M_CAN is not set
>> # CONFIG_CAN_PEAK_PCIEFD is not set
>> CONFIG_CAN_SJA1000=m
>> CONFIG_CAN_EMS_PCI=m
>> # CONFIG_CAN_F81601 is not set
>> CONFIG_CAN_KVASER_PCI=m
>> CONFIG_CAN_PEAK_PCI=m
>> CONFIG_CAN_PEAK_PCIEC=y
>> CONFIG_CAN_PLX_PCI=m
>> # CONFIG_CAN_SJA1000_ISA is not set
>> CONFIG_CAN_SJA1000_PLATFORM=m
>> CONFIG_CAN_SOFTING=m
>>
>> #
>> # CAN SPI interfaces
>> #
>> # CONFIG_CAN_HI311X is not set
>> # CONFIG_CAN_MCP251X is not set
>> # CONFIG_CAN_MCP251XFD is not set
>> # end of CAN SPI interfaces
>>
>> #
>> # CAN USB interfaces
>> #
>> # CONFIG_CAN_8DEV_USB is not set
>> # CONFIG_CAN_EMS_USB is not set
>> # CONFIG_CAN_ESD_USB2 is not set
>> # CONFIG_CAN_ETAS_ES58X is not set
>> # CONFIG_CAN_GS_USB is not set
>> # CONFIG_CAN_KVASER_USB is not set
>> # CONFIG_CAN_MCBA_USB is not set
>> # CONFIG_CAN_PEAK_USB is not set
>> # CONFIG_CAN_UCAN is not set
>> # end of CAN USB interfaces
>>
>> # CONFIG_CAN_DEBUG_DEVICES is not set
>> # end of CAN Device Drivers
>>
>> # CONFIG_BT is not set
>> # CONFIG_AF_RXRPC is not set
>> # CONFIG_AF_KCM is not set
>> CONFIG_STREAM_PARSER=y
>> # CONFIG_MCTP is not set
>> CONFIG_FIB_RULES=y
>> CONFIG_WIRELESS=y
>> CONFIG_CFG80211=m
>> # CONFIG_NL80211_TESTMODE is not set
>> # CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
>> CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
>> CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
>> CONFIG_CFG80211_DEFAULT_PS=y
>> # CONFIG_CFG80211_DEBUGFS is not set
>> CONFIG_CFG80211_CRDA_SUPPORT=y
>> # CONFIG_CFG80211_WEXT is not set
>> CONFIG_MAC80211=m
>> CONFIG_MAC80211_HAS_RC=y
>> CONFIG_MAC80211_RC_MINSTREL=y
>> CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
>> CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
>> # CONFIG_MAC80211_MESH is not set
>> CONFIG_MAC80211_LEDS=y
>> CONFIG_MAC80211_DEBUGFS=y
>> # CONFIG_MAC80211_MESSAGE_TRACING is not set
>> # CONFIG_MAC80211_DEBUG_MENU is not set
>> CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
>> CONFIG_RFKILL=m
>> CONFIG_RFKILL_LEDS=y
>> CONFIG_RFKILL_INPUT=y
>> # CONFIG_RFKILL_GPIO is not set
>> CONFIG_NET_9P=y
>> CONFIG_NET_9P_FD=y
>> CONFIG_NET_9P_VIRTIO=y
>> # CONFIG_NET_9P_DEBUG is not set
>> # CONFIG_CAIF is not set
>> CONFIG_CEPH_LIB=m
>> # CONFIG_CEPH_LIB_PRETTYDEBUG is not set
>> CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
>> # CONFIG_NFC is not set
>> CONFIG_PSAMPLE=m
>> # CONFIG_NET_IFE is not set
>> CONFIG_LWTUNNEL=y
>> CONFIG_LWTUNNEL_BPF=y
>> CONFIG_DST_CACHE=y
>> CONFIG_GRO_CELLS=y
>> CONFIG_SOCK_VALIDATE_XMIT=y
>> CONFIG_NET_SELFTESTS=y
>> CONFIG_NET_SOCK_MSG=y
>> CONFIG_FAILOVER=m
>> CONFIG_ETHTOOL_NETLINK=y
>>
>> #
>> # Device Drivers
>> #
>> CONFIG_HAVE_EISA=y
>> # CONFIG_EISA is not set
>> CONFIG_HAVE_PCI=y
>> CONFIG_PCI=y
>> CONFIG_PCI_DOMAINS=y
>> CONFIG_PCIEPORTBUS=y
>> CONFIG_HOTPLUG_PCI_PCIE=y
>> CONFIG_PCIEAER=y
>> CONFIG_PCIEAER_INJECT=m
>> CONFIG_PCIE_ECRC=y
>> CONFIG_PCIEASPM=y
>> CONFIG_PCIEASPM_DEFAULT=y
>> # CONFIG_PCIEASPM_POWERSAVE is not set
>> # CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
>> # CONFIG_PCIEASPM_PERFORMANCE is not set
>> CONFIG_PCIE_PME=y
>> CONFIG_PCIE_DPC=y
>> # CONFIG_PCIE_PTM is not set
>> # CONFIG_PCIE_EDR is not set
>> CONFIG_PCI_MSI=y
>> CONFIG_PCI_MSI_IRQ_DOMAIN=y
>> CONFIG_PCI_QUIRKS=y
>> # CONFIG_PCI_DEBUG is not set
>> # CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
>> CONFIG_PCI_STUB=y
>> CONFIG_PCI_PF_STUB=m
>> CONFIG_PCI_ATS=y
>> CONFIG_PCI_LOCKLESS_CONFIG=y
>> CONFIG_PCI_IOV=y
>> CONFIG_PCI_PRI=y
>> CONFIG_PCI_PASID=y
>> # CONFIG_PCI_P2PDMA is not set
>> CONFIG_PCI_LABEL=y
>> CONFIG_HOTPLUG_PCI=y
>> CONFIG_HOTPLUG_PCI_ACPI=y
>> CONFIG_HOTPLUG_PCI_ACPI_IBM=m
>> # CONFIG_HOTPLUG_PCI_CPCI is not set
>> CONFIG_HOTPLUG_PCI_SHPC=y
>>
>> #
>> # PCI controller drivers
>> #
>> CONFIG_VMD=y
>>
>> #
>> # DesignWare PCI Core Support
>> #
>> # CONFIG_PCIE_DW_PLAT_HOST is not set
>> # CONFIG_PCI_MESON is not set
>> # end of DesignWare PCI Core Support
>>
>> #
>> # Mobiveil PCIe Core Support
>> #
>> # end of Mobiveil PCIe Core Support
>>
>> #
>> # Cadence PCIe controllers support
>> #
>> # end of Cadence PCIe controllers support
>> # end of PCI controller drivers
>>
>> #
>> # PCI Endpoint
>> #
>> # CONFIG_PCI_ENDPOINT is not set
>> # end of PCI Endpoint
>>
>> #
>> # PCI switch controller drivers
>> #
>> # CONFIG_PCI_SW_SWITCHTEC is not set
>> # end of PCI switch controller drivers
>>
>> # CONFIG_CXL_BUS is not set
>> # CONFIG_PCCARD is not set
>> # CONFIG_RAPIDIO is not set
>>
>> #
>> # Generic Driver Options
>> #
>> CONFIG_AUXILIARY_BUS=y
>> # CONFIG_UEVENT_HELPER is not set
>> CONFIG_DEVTMPFS=y
>> CONFIG_DEVTMPFS_MOUNT=y
>> # CONFIG_DEVTMPFS_SAFE is not set
>> CONFIG_STANDALONE=y
>> CONFIG_PREVENT_FIRMWARE_BUILD=y
>>
>> #
>> # Firmware loader
>> #
>> CONFIG_FW_LOADER=y
>> CONFIG_FW_LOADER_PAGED_BUF=y
>> CONFIG_EXTRA_FIRMWARE=""
>> CONFIG_FW_LOADER_USER_HELPER=y
>> # CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
>> # CONFIG_FW_LOADER_COMPRESS is not set
>> CONFIG_FW_CACHE=y
>> # end of Firmware loader
>>
>> CONFIG_ALLOW_DEV_COREDUMP=y
>> # CONFIG_DEBUG_DRIVER is not set
>> # CONFIG_DEBUG_DEVRES is not set
>> # CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
>> # CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
>> CONFIG_GENERIC_CPU_AUTOPROBE=y
>> CONFIG_GENERIC_CPU_VULNERABILITIES=y
>> CONFIG_REGMAP=y
>> CONFIG_REGMAP_I2C=m
>> CONFIG_REGMAP_SPI=m
>> CONFIG_DMA_SHARED_BUFFER=y
>> # CONFIG_DMA_FENCE_TRACE is not set
>> # end of Generic Driver Options
>>
>> #
>> # Bus devices
>> #
>> # CONFIG_MHI_BUS is not set
>> # end of Bus devices
>>
>> CONFIG_CONNECTOR=y
>> CONFIG_PROC_EVENTS=y
>>
>> #
>> # Firmware Drivers
>> #
>>
>> #
>> # ARM System Control and Management Interface Protocol
>> #
>> # end of ARM System Control and Management Interface Protocol
>>
>> CONFIG_EDD=m
>> # CONFIG_EDD_OFF is not set
>> CONFIG_FIRMWARE_MEMMAP=y
>> CONFIG_DMIID=y
>> CONFIG_DMI_SYSFS=y
>> CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
>> # CONFIG_ISCSI_IBFT is not set
>> CONFIG_FW_CFG_SYSFS=y
>> # CONFIG_FW_CFG_SYSFS_CMDLINE is not set
>> CONFIG_SYSFB=y
>> # CONFIG_SYSFB_SIMPLEFB is not set
>> # CONFIG_GOOGLE_FIRMWARE is not set
>>
>> #
>> # EFI (Extensible Firmware Interface) Support
>> #
>> CONFIG_EFI_VARS=y
>> CONFIG_EFI_ESRT=y
>> CONFIG_EFI_VARS_PSTORE=y
>> CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
>> CONFIG_EFI_RUNTIME_MAP=y
>> # CONFIG_EFI_FAKE_MEMMAP is not set
>> CONFIG_EFI_RUNTIME_WRAPPERS=y
>> CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
>> # CONFIG_EFI_BOOTLOADER_CONTROL is not set
>> # CONFIG_EFI_CAPSULE_LOADER is not set
>> # CONFIG_EFI_TEST is not set
>> # CONFIG_APPLE_PROPERTIES is not set
>> # CONFIG_RESET_ATTACK_MITIGATION is not set
>> # CONFIG_EFI_RCI2_TABLE is not set
>> # CONFIG_EFI_DISABLE_PCI_DMA is not set
>> # end of EFI (Extensible Firmware Interface) Support
>>
>> CONFIG_UEFI_CPER=y
>> CONFIG_UEFI_CPER_X86=y
>> CONFIG_EFI_EARLYCON=y
>> CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y
>>
>> #
>> # Tegra firmware driver
>> #
>> # end of Tegra firmware driver
>> # end of Firmware Drivers
>>
>> # CONFIG_GNSS is not set
>> # CONFIG_MTD is not set
>> # CONFIG_OF is not set
>> CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
>> CONFIG_PARPORT=m
>> CONFIG_PARPORT_PC=m
>> CONFIG_PARPORT_SERIAL=m
>> # CONFIG_PARPORT_PC_FIFO is not set
>> # CONFIG_PARPORT_PC_SUPERIO is not set
>> # CONFIG_PARPORT_AX88796 is not set
>> CONFIG_PARPORT_1284=y
>> CONFIG_PNP=y
>> # CONFIG_PNP_DEBUG_MESSAGES is not set
>>
>> #
>> # Protocols
>> #
>> CONFIG_PNPACPI=y
>> CONFIG_BLK_DEV=y
>> CONFIG_BLK_DEV_NULL_BLK=m
>> # CONFIG_BLK_DEV_FD is not set
>> CONFIG_CDROM=m
>> # CONFIG_PARIDE is not set
>> # CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
>> # CONFIG_ZRAM is not set
>> CONFIG_BLK_DEV_LOOP=m
>> CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
>> # CONFIG_BLK_DEV_DRBD is not set
>> CONFIG_BLK_DEV_NBD=m
>> # CONFIG_BLK_DEV_SX8 is not set
>> CONFIG_BLK_DEV_RAM=m
>> CONFIG_BLK_DEV_RAM_COUNT=16
>> CONFIG_BLK_DEV_RAM_SIZE=16384
>> CONFIG_CDROM_PKTCDVD=m
>> CONFIG_CDROM_PKTCDVD_BUFFERS=8
>> # CONFIG_CDROM_PKTCDVD_WCACHE is not set
>> # CONFIG_ATA_OVER_ETH is not set
>> CONFIG_VIRTIO_BLK=m
>> CONFIG_BLK_DEV_RBD=m
>>
>> #
>> # NVME Support
>> #
>> CONFIG_NVME_CORE=m
>> CONFIG_BLK_DEV_NVME=m
>> CONFIG_NVME_MULTIPATH=y
>> # CONFIG_NVME_HWMON is not set
>> CONFIG_NVME_FABRICS=m
>> CONFIG_NVME_FC=m
>> # CONFIG_NVME_TCP is not set
>> CONFIG_NVME_TARGET=m
>> # CONFIG_NVME_TARGET_PASSTHRU is not set
>> CONFIG_NVME_TARGET_LOOP=m
>> CONFIG_NVME_TARGET_FC=m
>> CONFIG_NVME_TARGET_FCLOOP=m
>> # CONFIG_NVME_TARGET_TCP is not set
>> # end of NVME Support
>>
>> #
>> # Misc devices
>> #
>> CONFIG_SENSORS_LIS3LV02D=m
>> # CONFIG_AD525X_DPOT is not set
>> # CONFIG_DUMMY_IRQ is not set
>> # CONFIG_IBM_ASM is not set
>> # CONFIG_PHANTOM is not set
>> CONFIG_TIFM_CORE=m
>> CONFIG_TIFM_7XX1=m
>> # CONFIG_ICS932S401 is not set
>> CONFIG_ENCLOSURE_SERVICES=m
>> CONFIG_SGI_XP=m
>> CONFIG_HP_ILO=m
>> CONFIG_SGI_GRU=m
>> # CONFIG_SGI_GRU_DEBUG is not set
>> CONFIG_APDS9802ALS=m
>> CONFIG_ISL29003=m
>> CONFIG_ISL29020=m
>> CONFIG_SENSORS_TSL2550=m
>> CONFIG_SENSORS_BH1770=m
>> CONFIG_SENSORS_APDS990X=m
>> # CONFIG_HMC6352 is not set
>> # CONFIG_DS1682 is not set
>> CONFIG_VMWARE_BALLOON=m
>> # CONFIG_LATTICE_ECP3_CONFIG is not set
>> # CONFIG_SRAM is not set
>> # CONFIG_DW_XDATA_PCIE is not set
>> # CONFIG_PCI_ENDPOINT_TEST is not set
>> # CONFIG_XILINX_SDFEC is not set
>> CONFIG_MISC_RTSX=m
>> # CONFIG_C2PORT is not set
>>
>> #
>> # EEPROM support
>> #
>> # CONFIG_EEPROM_AT24 is not set
>> # CONFIG_EEPROM_AT25 is not set
>> CONFIG_EEPROM_LEGACY=m
>> CONFIG_EEPROM_MAX6875=m
>> CONFIG_EEPROM_93CX6=m
>> # CONFIG_EEPROM_93XX46 is not set
>> # CONFIG_EEPROM_IDT_89HPESX is not set
>> # CONFIG_EEPROM_EE1004 is not set
>> # end of EEPROM support
>>
>> CONFIG_CB710_CORE=m
>> # CONFIG_CB710_DEBUG is not set
>> CONFIG_CB710_DEBUG_ASSUMPTIONS=y
>>
>> #
>> # Texas Instruments shared transport line discipline
>> #
>> # CONFIG_TI_ST is not set
>> # end of Texas Instruments shared transport line discipline
>>
>> CONFIG_SENSORS_LIS3_I2C=m
>> CONFIG_ALTERA_STAPL=m
>> CONFIG_INTEL_MEI=m
>> CONFIG_INTEL_MEI_ME=m
>> # CONFIG_INTEL_MEI_TXE is not set
>> # CONFIG_INTEL_MEI_HDCP is not set
>> # CONFIG_INTEL_MEI_PXP is not set
>> CONFIG_VMWARE_VMCI=m
>> # CONFIG_GENWQE is not set
>> # CONFIG_ECHO is not set
>> # CONFIG_BCM_VK is not set
>> # CONFIG_MISC_ALCOR_PCI is not set
>> CONFIG_MISC_RTSX_PCI=m
>> # CONFIG_MISC_RTSX_USB is not set
>> # CONFIG_HABANA_AI is not set
>> # CONFIG_UACCE is not set
>> CONFIG_PVPANIC=y
>> # CONFIG_PVPANIC_MMIO is not set
>> # CONFIG_PVPANIC_PCI is not set
>> # end of Misc devices
>>
>> #
>> # SCSI device support
>> #
>> CONFIG_SCSI_MOD=y
>> CONFIG_RAID_ATTRS=m
>> CONFIG_SCSI_COMMON=y
>> CONFIG_SCSI=y
>> CONFIG_SCSI_DMA=y
>> CONFIG_SCSI_NETLINK=y
>> CONFIG_SCSI_PROC_FS=y
>>
>> #
>> # SCSI support type (disk, tape, CD-ROM)
>> #
>> CONFIG_BLK_DEV_SD=m
>> CONFIG_CHR_DEV_ST=m
>> CONFIG_BLK_DEV_SR=m
>> CONFIG_CHR_DEV_SG=m
>> CONFIG_BLK_DEV_BSG=y
>> CONFIG_CHR_DEV_SCH=m
>> CONFIG_SCSI_ENCLOSURE=m
>> CONFIG_SCSI_CONSTANTS=y
>> CONFIG_SCSI_LOGGING=y
>> CONFIG_SCSI_SCAN_ASYNC=y
>>
>> #
>> # SCSI Transports
>> #
>> CONFIG_SCSI_SPI_ATTRS=m
>> CONFIG_SCSI_FC_ATTRS=m
>> CONFIG_SCSI_ISCSI_ATTRS=m
>> CONFIG_SCSI_SAS_ATTRS=m
>> CONFIG_SCSI_SAS_LIBSAS=m
>> CONFIG_SCSI_SAS_ATA=y
>> CONFIG_SCSI_SAS_HOST_SMP=y
>> CONFIG_SCSI_SRP_ATTRS=m
>> # end of SCSI Transports
>>
>> CONFIG_SCSI_LOWLEVEL=y
>> # CONFIG_ISCSI_TCP is not set
>> # CONFIG_ISCSI_BOOT_SYSFS is not set
>> # CONFIG_SCSI_CXGB3_ISCSI is not set
>> # CONFIG_SCSI_CXGB4_ISCSI is not set
>> # CONFIG_SCSI_BNX2_ISCSI is not set
>> # CONFIG_BE2ISCSI is not set
>> # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
>> # CONFIG_SCSI_HPSA is not set
>> # CONFIG_SCSI_3W_9XXX is not set
>> # CONFIG_SCSI_3W_SAS is not set
>> # CONFIG_SCSI_ACARD is not set
>> # CONFIG_SCSI_AACRAID is not set
>> # CONFIG_SCSI_AIC7XXX is not set
>> # CONFIG_SCSI_AIC79XX is not set
>> # CONFIG_SCSI_AIC94XX is not set
>> # CONFIG_SCSI_MVSAS is not set
>> # CONFIG_SCSI_MVUMI is not set
>> # CONFIG_SCSI_DPT_I2O is not set
>> # CONFIG_SCSI_ADVANSYS is not set
>> # CONFIG_SCSI_ARCMSR is not set
>> # CONFIG_SCSI_ESAS2R is not set
>> # CONFIG_MEGARAID_NEWGEN is not set
>> # CONFIG_MEGARAID_LEGACY is not set
>> # CONFIG_MEGARAID_SAS is not set
>> CONFIG_SCSI_MPT3SAS=m
>> CONFIG_SCSI_MPT2SAS_MAX_SGE=128
>> CONFIG_SCSI_MPT3SAS_MAX_SGE=128
>> # CONFIG_SCSI_MPT2SAS is not set
>> # CONFIG_SCSI_MPI3MR is not set
>> # CONFIG_SCSI_SMARTPQI is not set
>> # CONFIG_SCSI_UFSHCD is not set
>> # CONFIG_SCSI_HPTIOP is not set
>> # CONFIG_SCSI_BUSLOGIC is not set
>> # CONFIG_SCSI_MYRB is not set
>> # CONFIG_SCSI_MYRS is not set
>> # CONFIG_VMWARE_PVSCSI is not set
>> # CONFIG_LIBFC is not set
>> # CONFIG_SCSI_SNIC is not set
>> # CONFIG_SCSI_DMX3191D is not set
>> # CONFIG_SCSI_FDOMAIN_PCI is not set
>> CONFIG_SCSI_ISCI=m
>> # CONFIG_SCSI_IPS is not set
>> # CONFIG_SCSI_INITIO is not set
>> # CONFIG_SCSI_INIA100 is not set
>> # CONFIG_SCSI_PPA is not set
>> # CONFIG_SCSI_IMM is not set
>> # CONFIG_SCSI_STEX is not set
>> # CONFIG_SCSI_SYM53C8XX_2 is not set
>> # CONFIG_SCSI_IPR is not set
>> # CONFIG_SCSI_QLOGIC_1280 is not set
>> # CONFIG_SCSI_QLA_FC is not set
>> # CONFIG_SCSI_QLA_ISCSI is not set
>> # CONFIG_SCSI_LPFC is not set
>> # CONFIG_SCSI_EFCT is not set
>> # CONFIG_SCSI_DC395x is not set
>> # CONFIG_SCSI_AM53C974 is not set
>> # CONFIG_SCSI_WD719X is not set
>> CONFIG_SCSI_DEBUG=m
>> # CONFIG_SCSI_PMCRAID is not set
>> # CONFIG_SCSI_PM8001 is not set
>> # CONFIG_SCSI_BFA_FC is not set
>> # CONFIG_SCSI_VIRTIO is not set
>> # CONFIG_SCSI_CHELSIO_FCOE is not set
>> CONFIG_SCSI_DH=y
>> CONFIG_SCSI_DH_RDAC=y
>> CONFIG_SCSI_DH_HP_SW=y
>> CONFIG_SCSI_DH_EMC=y
>> CONFIG_SCSI_DH_ALUA=y
>> # end of SCSI device support
>>
>> CONFIG_ATA=m
>> CONFIG_SATA_HOST=y
>> CONFIG_PATA_TIMINGS=y
>> CONFIG_ATA_VERBOSE_ERROR=y
>> CONFIG_ATA_FORCE=y
>> CONFIG_ATA_ACPI=y
>> # CONFIG_SATA_ZPODD is not set
>> CONFIG_SATA_PMP=y
>>
>> #
>> # Controllers with non-SFF native interface
>> #
>> CONFIG_SATA_AHCI=m
>> CONFIG_SATA_MOBILE_LPM_POLICY=0
>> CONFIG_SATA_AHCI_PLATFORM=m
>> # CONFIG_SATA_INIC162X is not set
>> # CONFIG_SATA_ACARD_AHCI is not set
>> # CONFIG_SATA_SIL24 is not set
>> CONFIG_ATA_SFF=y
>>
>> #
>> # SFF controllers with custom DMA interface
>> #
>> # CONFIG_PDC_ADMA is not set
>> # CONFIG_SATA_QSTOR is not set
>> # CONFIG_SATA_SX4 is not set
>> CONFIG_ATA_BMDMA=y
>>
>> #
>> # SATA SFF controllers with BMDMA
>> #
>> CONFIG_ATA_PIIX=m
>> # CONFIG_SATA_DWC is not set
>> # CONFIG_SATA_MV is not set
>> # CONFIG_SATA_NV is not set
>> # CONFIG_SATA_PROMISE is not set
>> # CONFIG_SATA_SIL is not set
>> # CONFIG_SATA_SIS is not set
>> # CONFIG_SATA_SVW is not set
>> # CONFIG_SATA_ULI is not set
>> # CONFIG_SATA_VIA is not set
>> # CONFIG_SATA_VITESSE is not set
>>
>> #
>> # PATA SFF controllers with BMDMA
>> #
>> # CONFIG_PATA_ALI is not set
>> # CONFIG_PATA_AMD is not set
>> # CONFIG_PATA_ARTOP is not set
>> # CONFIG_PATA_ATIIXP is not set
>> # CONFIG_PATA_ATP867X is not set
>> # CONFIG_PATA_CMD64X is not set
>> # CONFIG_PATA_CYPRESS is not set
>> # CONFIG_PATA_EFAR is not set
>> # CONFIG_PATA_HPT366 is not set
>> # CONFIG_PATA_HPT37X is not set
>> # CONFIG_PATA_HPT3X2N is not set
>> # CONFIG_PATA_HPT3X3 is not set
>> # CONFIG_PATA_IT8213 is not set
>> # CONFIG_PATA_IT821X is not set
>> # CONFIG_PATA_JMICRON is not set
>> # CONFIG_PATA_MARVELL is not set
>> # CONFIG_PATA_NETCELL is not set
>> # CONFIG_PATA_NINJA32 is not set
>> # CONFIG_PATA_NS87415 is not set
>> # CONFIG_PATA_OLDPIIX is not set
>> # CONFIG_PATA_OPTIDMA is not set
>> # CONFIG_PATA_PDC2027X is not set
>> # CONFIG_PATA_PDC_OLD is not set
>> # CONFIG_PATA_RADISYS is not set
>> # CONFIG_PATA_RDC is not set
>> # CONFIG_PATA_SCH is not set
>> # CONFIG_PATA_SERVERWORKS is not set
>> # CONFIG_PATA_SIL680 is not set
>> # CONFIG_PATA_SIS is not set
>> # CONFIG_PATA_TOSHIBA is not set
>> # CONFIG_PATA_TRIFLEX is not set
>> # CONFIG_PATA_VIA is not set
>> # CONFIG_PATA_WINBOND is not set
>>
>> #
>> # PIO-only SFF controllers
>> #
>> # CONFIG_PATA_CMD640_PCI is not set
>> # CONFIG_PATA_MPIIX is not set
>> # CONFIG_PATA_NS87410 is not set
>> # CONFIG_PATA_OPTI is not set
>> # CONFIG_PATA_RZ1000 is not set
>>
>> #
>> # Generic fallback / legacy drivers
>> #
>> # CONFIG_PATA_ACPI is not set
>> CONFIG_ATA_GENERIC=m
>> # CONFIG_PATA_LEGACY is not set
>> CONFIG_MD=y
>> CONFIG_BLK_DEV_MD=y
>> CONFIG_MD_AUTODETECT=y
>> CONFIG_MD_LINEAR=m
>> CONFIG_MD_RAID0=m
>> CONFIG_MD_RAID1=m
>> CONFIG_MD_RAID10=m
>> CONFIG_MD_RAID456=m
>> # CONFIG_MD_MULTIPATH is not set
>> CONFIG_MD_FAULTY=m
>> CONFIG_MD_CLUSTER=m
>> # CONFIG_BCACHE is not set
>> CONFIG_BLK_DEV_DM_BUILTIN=y
>> CONFIG_BLK_DEV_DM=m
>> CONFIG_DM_DEBUG=y
>> CONFIG_DM_BUFIO=m
>> # CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
>> CONFIG_DM_BIO_PRISON=m
>> CONFIG_DM_PERSISTENT_DATA=m
>> # CONFIG_DM_UNSTRIPED is not set
>> CONFIG_DM_CRYPT=m
>> CONFIG_DM_SNAPSHOT=m
>> CONFIG_DM_THIN_PROVISIONING=m
>> CONFIG_DM_CACHE=m
>> CONFIG_DM_CACHE_SMQ=m
>> CONFIG_DM_WRITECACHE=m
>> # CONFIG_DM_EBS is not set
>> CONFIG_DM_ERA=m
>> # CONFIG_DM_CLONE is not set
>> CONFIG_DM_MIRROR=m
>> CONFIG_DM_LOG_USERSPACE=m
>> CONFIG_DM_RAID=m
>> CONFIG_DM_ZERO=m
>> CONFIG_DM_MULTIPATH=m
>> CONFIG_DM_MULTIPATH_QL=m
>> CONFIG_DM_MULTIPATH_ST=m
>> # CONFIG_DM_MULTIPATH_HST is not set
>> # CONFIG_DM_MULTIPATH_IOA is not set
>> CONFIG_DM_DELAY=m
>> # CONFIG_DM_DUST is not set
>> CONFIG_DM_UEVENT=y
>> CONFIG_DM_FLAKEY=m
>> CONFIG_DM_VERITY=m
>> # CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
>> # CONFIG_DM_VERITY_FEC is not set
>> CONFIG_DM_SWITCH=m
>> CONFIG_DM_LOG_WRITES=m
>> CONFIG_DM_INTEGRITY=m
>> CONFIG_DM_AUDIT=y
>> CONFIG_TARGET_CORE=m
>> CONFIG_TCM_IBLOCK=m
>> CONFIG_TCM_FILEIO=m
>> CONFIG_TCM_PSCSI=m
>> CONFIG_TCM_USER2=m
>> CONFIG_LOOPBACK_TARGET=m
>> CONFIG_ISCSI_TARGET=m
>> # CONFIG_SBP_TARGET is not set
>> # CONFIG_FUSION is not set
>>
>> #
>> # IEEE 1394 (FireWire) support
>> #
>> CONFIG_FIREWIRE=m
>> CONFIG_FIREWIRE_OHCI=m
>> CONFIG_FIREWIRE_SBP2=m
>> CONFIG_FIREWIRE_NET=m
>> # CONFIG_FIREWIRE_NOSY is not set
>> # end of IEEE 1394 (FireWire) support
>>
>> CONFIG_MACINTOSH_DRIVERS=y
>> CONFIG_MAC_EMUMOUSEBTN=y
>> CONFIG_NETDEVICES=y
>> CONFIG_MII=y
>> CONFIG_NET_CORE=y
>> # CONFIG_BONDING is not set
>> # CONFIG_DUMMY is not set
>> # CONFIG_WIREGUARD is not set
>> # CONFIG_EQUALIZER is not set
>> # CONFIG_NET_FC is not set
>> # CONFIG_IFB is not set
>> # CONFIG_NET_TEAM is not set
>> # CONFIG_MACVLAN is not set
>> # CONFIG_IPVLAN is not set
>> # CONFIG_VXLAN is not set
>> # CONFIG_GENEVE is not set
>> # CONFIG_BAREUDP is not set
>> # CONFIG_GTP is not set
>> # CONFIG_AMT is not set
>> # CONFIG_MACSEC is not set
>> CONFIG_NETCONSOLE=m
>> CONFIG_NETCONSOLE_DYNAMIC=y
>> CONFIG_NETPOLL=y
>> CONFIG_NET_POLL_CONTROLLER=y
>> CONFIG_TUN=m
>> # CONFIG_TUN_VNET_CROSS_LE is not set
>> # CONFIG_VETH is not set
>> CONFIG_VIRTIO_NET=m
>> # CONFIG_NLMON is not set
>> # CONFIG_NET_VRF is not set
>> # CONFIG_VSOCKMON is not set
>> # CONFIG_ARCNET is not set
>> CONFIG_ATM_DRIVERS=y
>> # CONFIG_ATM_DUMMY is not set
>> # CONFIG_ATM_TCP is not set
>> # CONFIG_ATM_LANAI is not set
>> # CONFIG_ATM_ENI is not set
>> # CONFIG_ATM_FIRESTREAM is not set
>> # CONFIG_ATM_ZATM is not set
>> # CONFIG_ATM_NICSTAR is not set
>> # CONFIG_ATM_IDT77252 is not set
>> # CONFIG_ATM_AMBASSADOR is not set
>> # CONFIG_ATM_HORIZON is not set
>> # CONFIG_ATM_IA is not set
>> # CONFIG_ATM_FORE200E is not set
>> # CONFIG_ATM_HE is not set
>> # CONFIG_ATM_SOLOS is not set
>> CONFIG_ETHERNET=y
>> CONFIG_MDIO=y
>> # CONFIG_NET_VENDOR_3COM is not set
>> CONFIG_NET_VENDOR_ADAPTEC=y
>> # CONFIG_ADAPTEC_STARFIRE is not set
>> CONFIG_NET_VENDOR_AGERE=y
>> # CONFIG_ET131X is not set
>> CONFIG_NET_VENDOR_ALACRITECH=y
>> # CONFIG_SLICOSS is not set
>> CONFIG_NET_VENDOR_ALTEON=y
>> # CONFIG_ACENIC is not set
>> # CONFIG_ALTERA_TSE is not set
>> CONFIG_NET_VENDOR_AMAZON=y
>> # CONFIG_ENA_ETHERNET is not set
>> # CONFIG_NET_VENDOR_AMD is not set
>> CONFIG_NET_VENDOR_AQUANTIA=y
>> # CONFIG_AQTION is not set
>> CONFIG_NET_VENDOR_ARC=y
>> CONFIG_NET_VENDOR_ASIX=y
>> # CONFIG_SPI_AX88796C is not set
>> CONFIG_NET_VENDOR_ATHEROS=y
>> # CONFIG_ATL2 is not set
>> # CONFIG_ATL1 is not set
>> # CONFIG_ATL1E is not set
>> # CONFIG_ATL1C is not set
>> # CONFIG_ALX is not set
>> CONFIG_NET_VENDOR_BROADCOM=y
>> # CONFIG_B44 is not set
>> # CONFIG_BCMGENET is not set
>> # CONFIG_BNX2 is not set
>> # CONFIG_CNIC is not set
>> # CONFIG_TIGON3 is not set
>> # CONFIG_BNX2X is not set
>> # CONFIG_SYSTEMPORT is not set
>> # CONFIG_BNXT is not set
>> CONFIG_NET_VENDOR_BROCADE=y
>> # CONFIG_BNA is not set
>> CONFIG_NET_VENDOR_CADENCE=y
>> # CONFIG_MACB is not set
>> CONFIG_NET_VENDOR_CAVIUM=y
>> # CONFIG_THUNDER_NIC_PF is not set
>> # CONFIG_THUNDER_NIC_VF is not set
>> # CONFIG_THUNDER_NIC_BGX is not set
>> # CONFIG_THUNDER_NIC_RGX is not set
>> CONFIG_CAVIUM_PTP=y
>> # CONFIG_LIQUIDIO is not set
>> # CONFIG_LIQUIDIO_VF is not set
>> CONFIG_NET_VENDOR_CHELSIO=y
>> # CONFIG_CHELSIO_T1 is not set
>> # CONFIG_CHELSIO_T3 is not set
>> # CONFIG_CHELSIO_T4 is not set
>> # CONFIG_CHELSIO_T4VF is not set
>> CONFIG_NET_VENDOR_CISCO=y
>> # CONFIG_ENIC is not set
>> CONFIG_NET_VENDOR_CORTINA=y
>> # CONFIG_CX_ECAT is not set
>> # CONFIG_DNET is not set
>> CONFIG_NET_VENDOR_DEC=y
>> # CONFIG_NET_TULIP is not set
>> CONFIG_NET_VENDOR_DLINK=y
>> # CONFIG_DL2K is not set
>> # CONFIG_SUNDANCE is not set
>> CONFIG_NET_VENDOR_EMULEX=y
>> # CONFIG_BE2NET is not set
>> CONFIG_NET_VENDOR_ENGLEDER=y
>> # CONFIG_TSNEP is not set
>> CONFIG_NET_VENDOR_EZCHIP=y
>> CONFIG_NET_VENDOR_GOOGLE=y
>> # CONFIG_GVE is not set
>> CONFIG_NET_VENDOR_HUAWEI=y
>> # CONFIG_HINIC is not set
>> CONFIG_NET_VENDOR_I825XX=y
>> CONFIG_NET_VENDOR_INTEL=y
>> # CONFIG_E100 is not set
>> CONFIG_E1000=y
>> CONFIG_E1000E=y
>> CONFIG_E1000E_HWTS=y
>> CONFIG_IGB=y
>> CONFIG_IGB_HWMON=y
>> # CONFIG_IGBVF is not set
>> # CONFIG_IXGB is not set
>> CONFIG_IXGBE=y
>> CONFIG_IXGBE_HWMON=y
>> # CONFIG_IXGBE_DCB is not set
>> CONFIG_IXGBE_IPSEC=y
>> # CONFIG_IXGBEVF is not set
>> CONFIG_I40E=y
>> # CONFIG_I40E_DCB is not set
>> # CONFIG_I40EVF is not set
>> # CONFIG_ICE is not set
>> # CONFIG_FM10K is not set
>> CONFIG_IGC=y
>> CONFIG_NET_VENDOR_MICROSOFT=y
>> # CONFIG_JME is not set
>> CONFIG_NET_VENDOR_LITEX=y
>> CONFIG_NET_VENDOR_MARVELL=y
>> # CONFIG_MVMDIO is not set
>> # CONFIG_SKGE is not set
>> # CONFIG_SKY2 is not set
>> # CONFIG_PRESTERA is not set
>> CONFIG_NET_VENDOR_MELLANOX=y
>> # CONFIG_MLX4_EN is not set
>> # CONFIG_MLX5_CORE is not set
>> # CONFIG_MLXSW_CORE is not set
>> # CONFIG_MLXFW is not set
>> CONFIG_NET_VENDOR_MICREL=y
>> # CONFIG_KS8842 is not set
>> # CONFIG_KS8851 is not set
>> # CONFIG_KS8851_MLL is not set
>> # CONFIG_KSZ884X_PCI is not set
>> CONFIG_NET_VENDOR_MICROCHIP=y
>> # CONFIG_ENC28J60 is not set
>> # CONFIG_ENCX24J600 is not set
>> # CONFIG_LAN743X is not set
>> CONFIG_NET_VENDOR_MICROSEMI=y
>> CONFIG_NET_VENDOR_MYRI=y
>> # CONFIG_MYRI10GE is not set
>> # CONFIG_FEALNX is not set
>> CONFIG_NET_VENDOR_NATSEMI=y
>> # CONFIG_NATSEMI is not set
>> # CONFIG_NS83820 is not set
>> CONFIG_NET_VENDOR_NETERION=y
>> # CONFIG_S2IO is not set
>> # CONFIG_VXGE is not set
>> CONFIG_NET_VENDOR_NETRONOME=y
>> # CONFIG_NFP is not set
>> CONFIG_NET_VENDOR_NI=y
>> # CONFIG_NI_XGE_MANAGEMENT_ENET is not set
>> CONFIG_NET_VENDOR_8390=y
>> # CONFIG_NE2K_PCI is not set
>> CONFIG_NET_VENDOR_NVIDIA=y
>> # CONFIG_FORCEDETH is not set
>> CONFIG_NET_VENDOR_OKI=y
>> # CONFIG_ETHOC is not set
>> CONFIG_NET_VENDOR_PACKET_ENGINES=y
>> # CONFIG_HAMACHI is not set
>> # CONFIG_YELLOWFIN is not set
>> CONFIG_NET_VENDOR_PENSANDO=y
>> # CONFIG_IONIC is not set
>> CONFIG_NET_VENDOR_QLOGIC=y
>> # CONFIG_QLA3XXX is not set
>> # CONFIG_QLCNIC is not set
>> # CONFIG_NETXEN_NIC is not set
>> # CONFIG_QED is not set
>> CONFIG_NET_VENDOR_QUALCOMM=y
>> # CONFIG_QCOM_EMAC is not set
>> # CONFIG_RMNET is not set
>> CONFIG_NET_VENDOR_RDC=y
>> # CONFIG_R6040 is not set
>> CONFIG_NET_VENDOR_REALTEK=y
>> # CONFIG_ATP is not set
>> # CONFIG_8139CP is not set
>> # CONFIG_8139TOO is not set
>> CONFIG_R8169=y
>> CONFIG_NET_VENDOR_RENESAS=y
>> CONFIG_NET_VENDOR_ROCKER=y
>> # CONFIG_ROCKER is not set
>> CONFIG_NET_VENDOR_SAMSUNG=y
>> # CONFIG_SXGBE_ETH is not set
>> CONFIG_NET_VENDOR_SEEQ=y
>> CONFIG_NET_VENDOR_SOLARFLARE=y
>> # CONFIG_SFC is not set
>> # CONFIG_SFC_FALCON is not set
>> CONFIG_NET_VENDOR_SILAN=y
>> # CONFIG_SC92031 is not set
>> CONFIG_NET_VENDOR_SIS=y
>> # CONFIG_SIS900 is not set
>> # CONFIG_SIS190 is not set
>> CONFIG_NET_VENDOR_SMSC=y
>> # CONFIG_EPIC100 is not set
>> # CONFIG_SMSC911X is not set
>> # CONFIG_SMSC9420 is not set
>> CONFIG_NET_VENDOR_SOCIONEXT=y
>> CONFIG_NET_VENDOR_STMICRO=y
>> # CONFIG_STMMAC_ETH is not set
>> CONFIG_NET_VENDOR_SUN=y
>> # CONFIG_HAPPYMEAL is not set
>> # CONFIG_SUNGEM is not set
>> # CONFIG_CASSINI is not set
>> # CONFIG_NIU is not set
>> CONFIG_NET_VENDOR_SYNOPSYS=y
>> # CONFIG_DWC_XLGMAC is not set
>> CONFIG_NET_VENDOR_TEHUTI=y
>> # CONFIG_TEHUTI is not set
>> CONFIG_NET_VENDOR_TI=y
>> # CONFIG_TI_CPSW_PHY_SEL is not set
>> # CONFIG_TLAN is not set
>> CONFIG_NET_VENDOR_VERTEXCOM=y
>> # CONFIG_MSE102X is not set
>> CONFIG_NET_VENDOR_VIA=y
>> # CONFIG_VIA_RHINE is not set
>> # CONFIG_VIA_VELOCITY is not set
>> CONFIG_NET_VENDOR_WIZNET=y
>> # CONFIG_WIZNET_W5100 is not set
>> # CONFIG_WIZNET_W5300 is not set
>> CONFIG_NET_VENDOR_XILINX=y
>> # CONFIG_XILINX_EMACLITE is not set
>> # CONFIG_XILINX_AXI_EMAC is not set
>> # CONFIG_XILINX_LL_TEMAC is not set
>> # CONFIG_FDDI is not set
>> # CONFIG_HIPPI is not set
>> # CONFIG_NET_SB1000 is not set
>> CONFIG_PHYLIB=y
>> CONFIG_SWPHY=y
>> # CONFIG_LED_TRIGGER_PHY is not set
>> CONFIG_FIXED_PHY=y
>>
>> #
>> # MII PHY device drivers
>> #
>> # CONFIG_AMD_PHY is not set
>> # CONFIG_ADIN_PHY is not set
>> # CONFIG_AQUANTIA_PHY is not set
>> CONFIG_AX88796B_PHY=y
>> # CONFIG_BROADCOM_PHY is not set
>> # CONFIG_BCM54140_PHY is not set
>> # CONFIG_BCM7XXX_PHY is not set
>> # CONFIG_BCM84881_PHY is not set
>> # CONFIG_BCM87XX_PHY is not set
>> # CONFIG_CICADA_PHY is not set
>> # CONFIG_CORTINA_PHY is not set
>> # CONFIG_DAVICOM_PHY is not set
>> # CONFIG_ICPLUS_PHY is not set
>> # CONFIG_LXT_PHY is not set
>> # CONFIG_INTEL_XWAY_PHY is not set
>> # CONFIG_LSI_ET1011C_PHY is not set
>> # CONFIG_MARVELL_PHY is not set
>> # CONFIG_MARVELL_10G_PHY is not set
>> # CONFIG_MARVELL_88X2222_PHY is not set
>> # CONFIG_MAXLINEAR_GPHY is not set
>> # CONFIG_MEDIATEK_GE_PHY is not set
>> # CONFIG_MICREL_PHY is not set
>> # CONFIG_MICROCHIP_PHY is not set
>> # CONFIG_MICROCHIP_T1_PHY is not set
>> # CONFIG_MICROSEMI_PHY is not set
>> # CONFIG_MOTORCOMM_PHY is not set
>> # CONFIG_NATIONAL_PHY is not set
>> # CONFIG_NXP_C45_TJA11XX_PHY is not set
>> # CONFIG_NXP_TJA11XX_PHY is not set
>> # CONFIG_QSEMI_PHY is not set
>> CONFIG_REALTEK_PHY=y
>> # CONFIG_RENESAS_PHY is not set
>> # CONFIG_ROCKCHIP_PHY is not set
>> # CONFIG_SMSC_PHY is not set
>> # CONFIG_STE10XP is not set
>> # CONFIG_TERANETICS_PHY is not set
>> # CONFIG_DP83822_PHY is not set
>> # CONFIG_DP83TC811_PHY is not set
>> # CONFIG_DP83848_PHY is not set
>> # CONFIG_DP83867_PHY is not set
>> # CONFIG_DP83869_PHY is not set
>> # CONFIG_VITESSE_PHY is not set
>> # CONFIG_XILINX_GMII2RGMII is not set
>> # CONFIG_MICREL_KS8995MA is not set
>> CONFIG_MDIO_DEVICE=y
>> CONFIG_MDIO_BUS=y
>> CONFIG_FWNODE_MDIO=y
>> CONFIG_ACPI_MDIO=y
>> CONFIG_MDIO_DEVRES=y
>> # CONFIG_MDIO_BITBANG is not set
>> # CONFIG_MDIO_BCM_UNIMAC is not set
>> # CONFIG_MDIO_MVUSB is not set
>> # CONFIG_MDIO_THUNDER is not set
>>
>> #
>> # MDIO Multiplexers
>> #
>>
>> #
>> # PCS device drivers
>> #
>> # CONFIG_PCS_XPCS is not set
>> # end of PCS device drivers
>>
>> # CONFIG_PLIP is not set
>> # CONFIG_PPP is not set
>> # CONFIG_SLIP is not set
>> CONFIG_USB_NET_DRIVERS=y
>> # CONFIG_USB_CATC is not set
>> # CONFIG_USB_KAWETH is not set
>> # CONFIG_USB_PEGASUS is not set
>> # CONFIG_USB_RTL8150 is not set
>> CONFIG_USB_RTL8152=y
>> # CONFIG_USB_LAN78XX is not set
>> CONFIG_USB_USBNET=y
>> CONFIG_USB_NET_AX8817X=y
>> CONFIG_USB_NET_AX88179_178A=y
>> # CONFIG_USB_NET_CDCETHER is not set
>> # CONFIG_USB_NET_CDC_EEM is not set
>> # CONFIG_USB_NET_CDC_NCM is not set
>> # CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
>> # CONFIG_USB_NET_CDC_MBIM is not set
>> # CONFIG_USB_NET_DM9601 is not set
>> # CONFIG_USB_NET_SR9700 is not set
>> # CONFIG_USB_NET_SR9800 is not set
>> # CONFIG_USB_NET_SMSC75XX is not set
>> # CONFIG_USB_NET_SMSC95XX is not set
>> # CONFIG_USB_NET_GL620A is not set
>> # CONFIG_USB_NET_NET1080 is not set
>> # CONFIG_USB_NET_PLUSB is not set
>> # CONFIG_USB_NET_MCS7830 is not set
>> # CONFIG_USB_NET_RNDIS_HOST is not set
>> # CONFIG_USB_NET_CDC_SUBSET is not set
>> # CONFIG_USB_NET_ZAURUS is not set
>> # CONFIG_USB_NET_CX82310_ETH is not set
>> # CONFIG_USB_NET_KALMIA is not set
>> # CONFIG_USB_NET_QMI_WWAN is not set
>> # CONFIG_USB_HSO is not set
>> # CONFIG_USB_NET_INT51X1 is not set
>> # CONFIG_USB_IPHETH is not set
>> # CONFIG_USB_SIERRA_NET is not set
>> # CONFIG_USB_NET_CH9200 is not set
>> # CONFIG_USB_NET_AQC111 is not set
>> CONFIG_WLAN=y
>> CONFIG_WLAN_VENDOR_ADMTEK=y
>> # CONFIG_ADM8211 is not set
>> CONFIG_WLAN_VENDOR_ATH=y
>> # CONFIG_ATH_DEBUG is not set
>> # CONFIG_ATH5K is not set
>> # CONFIG_ATH5K_PCI is not set
>> # CONFIG_ATH9K is not set
>> # CONFIG_ATH9K_HTC is not set
>> # CONFIG_CARL9170 is not set
>> # CONFIG_ATH6KL is not set
>> # CONFIG_AR5523 is not set
>> # CONFIG_WIL6210 is not set
>> # CONFIG_ATH10K is not set
>> # CONFIG_WCN36XX is not set
>> # CONFIG_ATH11K is not set
>> CONFIG_WLAN_VENDOR_ATMEL=y
>> # CONFIG_ATMEL is not set
>> # CONFIG_AT76C50X_USB is not set
>> CONFIG_WLAN_VENDOR_BROADCOM=y
>> # CONFIG_B43 is not set
>> # CONFIG_B43LEGACY is not set
>> # CONFIG_BRCMSMAC is not set
>> # CONFIG_BRCMFMAC is not set
>> CONFIG_WLAN_VENDOR_CISCO=y
>> # CONFIG_AIRO is not set
>> CONFIG_WLAN_VENDOR_INTEL=y
>> # CONFIG_IPW2100 is not set
>> # CONFIG_IPW2200 is not set
>> # CONFIG_IWL4965 is not set
>> # CONFIG_IWL3945 is not set
>> # CONFIG_IWLWIFI is not set
>> # CONFIG_IWLMEI is not set
>> CONFIG_WLAN_VENDOR_INTERSIL=y
>> # CONFIG_HOSTAP is not set
>> # CONFIG_HERMES is not set
>> # CONFIG_P54_COMMON is not set
>> CONFIG_WLAN_VENDOR_MARVELL=y
>> # CONFIG_LIBERTAS is not set
>> # CONFIG_LIBERTAS_THINFIRM is not set
>> # CONFIG_MWIFIEX is not set
>> # CONFIG_MWL8K is not set
>> # CONFIG_WLAN_VENDOR_MEDIATEK is not set
>> CONFIG_WLAN_VENDOR_MICROCHIP=y
>> # CONFIG_WILC1000_SDIO is not set
>> # CONFIG_WILC1000_SPI is not set
>> CONFIG_WLAN_VENDOR_RALINK=y
>> # CONFIG_RT2X00 is not set
>> CONFIG_WLAN_VENDOR_REALTEK=y
>> # CONFIG_RTL8180 is not set
>> # CONFIG_RTL8187 is not set
>> CONFIG_RTL_CARDS=m
>> # CONFIG_RTL8192CE is not set
>> # CONFIG_RTL8192SE is not set
>> # CONFIG_RTL8192DE is not set
>> # CONFIG_RTL8723AE is not set
>> # CONFIG_RTL8723BE is not set
>> # CONFIG_RTL8188EE is not set
>> # CONFIG_RTL8192EE is not set
>> # CONFIG_RTL8821AE is not set
>> # CONFIG_RTL8192CU is not set
>> # CONFIG_RTL8XXXU is not set
>> # CONFIG_RTW88 is not set
>> # CONFIG_RTW89 is not set
>> CONFIG_WLAN_VENDOR_RSI=y
>> # CONFIG_RSI_91X is not set
>> CONFIG_WLAN_VENDOR_ST=y
>> # CONFIG_CW1200 is not set
>> CONFIG_WLAN_VENDOR_TI=y
>> # CONFIG_WL1251 is not set
>> # CONFIG_WL12XX is not set
>> # CONFIG_WL18XX is not set
>> # CONFIG_WLCORE is not set
>> CONFIG_WLAN_VENDOR_ZYDAS=y
>> # CONFIG_USB_ZD1201 is not set
>> # CONFIG_ZD1211RW is not set
>> CONFIG_WLAN_VENDOR_QUANTENNA=y
>> # CONFIG_QTNFMAC_PCIE is not set
>> # CONFIG_MAC80211_HWSIM is not set
>> # CONFIG_USB_NET_RNDIS_WLAN is not set
>> # CONFIG_VIRT_WIFI is not set
>> # CONFIG_WAN is not set
>> CONFIG_IEEE802154_DRIVERS=m
>> # CONFIG_IEEE802154_FAKELB is not set
>> # CONFIG_IEEE802154_AT86RF230 is not set
>> # CONFIG_IEEE802154_MRF24J40 is not set
>> # CONFIG_IEEE802154_CC2520 is not set
>> # CONFIG_IEEE802154_ATUSB is not set
>> # CONFIG_IEEE802154_ADF7242 is not set
>> # CONFIG_IEEE802154_CA8210 is not set
>> # CONFIG_IEEE802154_MCR20A is not set
>> # CONFIG_IEEE802154_HWSIM is not set
>>
>> #
>> # Wireless WAN
>> #
>> # CONFIG_WWAN is not set
>> # end of Wireless WAN
>>
>> # CONFIG_VMXNET3 is not set
>> # CONFIG_FUJITSU_ES is not set
>> # CONFIG_NETDEVSIM is not set
>> CONFIG_NET_FAILOVER=m
>> # CONFIG_ISDN is not set
>>
>> #
>> # Input device support
>> #
>> CONFIG_INPUT=y
>> CONFIG_INPUT_LEDS=y
>> CONFIG_INPUT_FF_MEMLESS=m
>> CONFIG_INPUT_SPARSEKMAP=m
>> # CONFIG_INPUT_MATRIXKMAP is not set
>>
>> #
>> # Userland interfaces
>> #
>> CONFIG_INPUT_MOUSEDEV=y
>> # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
>> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
>> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
>> CONFIG_INPUT_JOYDEV=m
>> CONFIG_INPUT_EVDEV=y
>> # CONFIG_INPUT_EVBUG is not set
>>
>> #
>> # Input Device Drivers
>> #
>> CONFIG_INPUT_KEYBOARD=y
>> # CONFIG_KEYBOARD_ADP5588 is not set
>> # CONFIG_KEYBOARD_ADP5589 is not set
>> # CONFIG_KEYBOARD_APPLESPI is not set
>> CONFIG_KEYBOARD_ATKBD=y
>> # CONFIG_KEYBOARD_QT1050 is not set
>> # CONFIG_KEYBOARD_QT1070 is not set
>> # CONFIG_KEYBOARD_QT2160 is not set
>> # CONFIG_KEYBOARD_DLINK_DIR685 is not set
>> # CONFIG_KEYBOARD_LKKBD is not set
>> # CONFIG_KEYBOARD_GPIO is not set
>> # CONFIG_KEYBOARD_GPIO_POLLED is not set
>> # CONFIG_KEYBOARD_TCA6416 is not set
>> # CONFIG_KEYBOARD_TCA8418 is not set
>> # CONFIG_KEYBOARD_MATRIX is not set
>> # CONFIG_KEYBOARD_LM8323 is not set
>> # CONFIG_KEYBOARD_LM8333 is not set
>> # CONFIG_KEYBOARD_MAX7359 is not set
>> # CONFIG_KEYBOARD_MCS is not set
>> # CONFIG_KEYBOARD_MPR121 is not set
>> # CONFIG_KEYBOARD_NEWTON is not set
>> # CONFIG_KEYBOARD_OPENCORES is not set
>> # CONFIG_KEYBOARD_SAMSUNG is not set
>> # CONFIG_KEYBOARD_STOWAWAY is not set
>> # CONFIG_KEYBOARD_SUNKBD is not set
>> # CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
>> # CONFIG_KEYBOARD_XTKBD is not set
>> # CONFIG_KEYBOARD_CYPRESS_SF is not set
>> CONFIG_INPUT_MOUSE=y
>> CONFIG_MOUSE_PS2=y
>> CONFIG_MOUSE_PS2_ALPS=y
>> CONFIG_MOUSE_PS2_BYD=y
>> CONFIG_MOUSE_PS2_LOGIPS2PP=y
>> CONFIG_MOUSE_PS2_SYNAPTICS=y
>> CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
>> CONFIG_MOUSE_PS2_CYPRESS=y
>> CONFIG_MOUSE_PS2_LIFEBOOK=y
>> CONFIG_MOUSE_PS2_TRACKPOINT=y
>> CONFIG_MOUSE_PS2_ELANTECH=y
>> CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
>> CONFIG_MOUSE_PS2_SENTELIC=y
>> # CONFIG_MOUSE_PS2_TOUCHKIT is not set
>> CONFIG_MOUSE_PS2_FOCALTECH=y
>> CONFIG_MOUSE_PS2_VMMOUSE=y
>> CONFIG_MOUSE_PS2_SMBUS=y
>> CONFIG_MOUSE_SERIAL=m
>> # CONFIG_MOUSE_APPLETOUCH is not set
>> # CONFIG_MOUSE_BCM5974 is not set
>> CONFIG_MOUSE_CYAPA=m
>> CONFIG_MOUSE_ELAN_I2C=m
>> CONFIG_MOUSE_ELAN_I2C_I2C=y
>> CONFIG_MOUSE_ELAN_I2C_SMBUS=y
>> CONFIG_MOUSE_VSXXXAA=m
>> # CONFIG_MOUSE_GPIO is not set
>> CONFIG_MOUSE_SYNAPTICS_I2C=m
>> # CONFIG_MOUSE_SYNAPTICS_USB is not set
>> # CONFIG_INPUT_JOYSTICK is not set
>> # CONFIG_INPUT_TABLET is not set
>> # CONFIG_INPUT_TOUCHSCREEN is not set
>> # CONFIG_INPUT_MISC is not set
>> CONFIG_RMI4_CORE=m
>> CONFIG_RMI4_I2C=m
>> CONFIG_RMI4_SPI=m
>> CONFIG_RMI4_SMB=m
>> CONFIG_RMI4_F03=y
>> CONFIG_RMI4_F03_SERIO=m
>> CONFIG_RMI4_2D_SENSOR=y
>> CONFIG_RMI4_F11=y
>> CONFIG_RMI4_F12=y
>> CONFIG_RMI4_F30=y
>> CONFIG_RMI4_F34=y
>> # CONFIG_RMI4_F3A is not set
>> CONFIG_RMI4_F55=y
>>
>> #
>> # Hardware I/O ports
>> #
>> CONFIG_SERIO=y
>> CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
>> CONFIG_SERIO_I8042=y
>> CONFIG_SERIO_SERPORT=y
>> # CONFIG_SERIO_CT82C710 is not set
>> # CONFIG_SERIO_PARKBD is not set
>> # CONFIG_SERIO_PCIPS2 is not set
>> CONFIG_SERIO_LIBPS2=y
>> CONFIG_SERIO_RAW=m
>> CONFIG_SERIO_ALTERA_PS2=m
>> # CONFIG_SERIO_PS2MULT is not set
>> CONFIG_SERIO_ARC_PS2=m
>> # CONFIG_SERIO_GPIO_PS2 is not set
>> # CONFIG_USERIO is not set
>> # CONFIG_GAMEPORT is not set
>> # end of Hardware I/O ports
>> # end of Input device support
>>
>> #
>> # Character devices
>> #
>> CONFIG_TTY=y
>> CONFIG_VT=y
>> CONFIG_CONSOLE_TRANSLATIONS=y
>> CONFIG_VT_CONSOLE=y
>> CONFIG_VT_CONSOLE_SLEEP=y
>> CONFIG_HW_CONSOLE=y
>> CONFIG_VT_HW_CONSOLE_BINDING=y
>> CONFIG_UNIX98_PTYS=y
>> # CONFIG_LEGACY_PTYS is not set
>> CONFIG_LDISC_AUTOLOAD=y
>>
>> #
>> # Serial drivers
>> #
>> CONFIG_SERIAL_EARLYCON=y
>> CONFIG_SERIAL_8250=y
>> # CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
>> CONFIG_SERIAL_8250_PNP=y
>> # CONFIG_SERIAL_8250_16550A_VARIANTS is not set
>> # CONFIG_SERIAL_8250_FINTEK is not set
>> CONFIG_SERIAL_8250_CONSOLE=y
>> CONFIG_SERIAL_8250_DMA=y
>> CONFIG_SERIAL_8250_PCI=y
>> CONFIG_SERIAL_8250_EXAR=y
>> CONFIG_SERIAL_8250_NR_UARTS=64
>> CONFIG_SERIAL_8250_RUNTIME_UARTS=4
>> CONFIG_SERIAL_8250_EXTENDED=y
>> CONFIG_SERIAL_8250_MANY_PORTS=y
>> CONFIG_SERIAL_8250_SHARE_IRQ=y
>> # CONFIG_SERIAL_8250_DETECT_IRQ is not set
>> CONFIG_SERIAL_8250_RSA=y
>> CONFIG_SERIAL_8250_DWLIB=y
>> CONFIG_SERIAL_8250_DW=y
>> # CONFIG_SERIAL_8250_RT288X is not set
>> CONFIG_SERIAL_8250_LPSS=y
>> CONFIG_SERIAL_8250_MID=y
>> CONFIG_SERIAL_8250_PERICOM=y
>>
>> #
>> # Non-8250 serial port support
>> #
>> # CONFIG_SERIAL_MAX3100 is not set
>> # CONFIG_SERIAL_MAX310X is not set
>> # CONFIG_SERIAL_UARTLITE is not set
>> CONFIG_SERIAL_CORE=y
>> CONFIG_SERIAL_CORE_CONSOLE=y
>> CONFIG_SERIAL_JSM=m
>> # CONFIG_SERIAL_LANTIQ is not set
>> # CONFIG_SERIAL_SCCNXP is not set
>> # CONFIG_SERIAL_SC16IS7XX is not set
>> # CONFIG_SERIAL_BCM63XX is not set
>> # CONFIG_SERIAL_ALTERA_JTAGUART is not set
>> # CONFIG_SERIAL_ALTERA_UART is not set
>> CONFIG_SERIAL_ARC=m
>> CONFIG_SERIAL_ARC_NR_PORTS=1
>> # CONFIG_SERIAL_RP2 is not set
>> # CONFIG_SERIAL_FSL_LPUART is not set
>> # CONFIG_SERIAL_FSL_LINFLEXUART is not set
>> # CONFIG_SERIAL_SPRD is not set
>> # end of Serial drivers
>>
>> CONFIG_SERIAL_MCTRL_GPIO=y
>> CONFIG_SERIAL_NONSTANDARD=y
>> # CONFIG_MOXA_INTELLIO is not set
>> # CONFIG_MOXA_SMARTIO is not set
>> CONFIG_SYNCLINK_GT=m
>> CONFIG_N_HDLC=m
>> CONFIG_N_GSM=m
>> CONFIG_NOZOMI=m
>> # CONFIG_NULL_TTY is not set
>> CONFIG_HVC_DRIVER=y
>> # CONFIG_SERIAL_DEV_BUS is not set
>> CONFIG_PRINTER=m
>> # CONFIG_LP_CONSOLE is not set
>> CONFIG_PPDEV=m
>> CONFIG_VIRTIO_CONSOLE=m
>> CONFIG_IPMI_HANDLER=m
>> CONFIG_IPMI_DMI_DECODE=y
>> CONFIG_IPMI_PLAT_DATA=y
>> CONFIG_IPMI_PANIC_EVENT=y
>> CONFIG_IPMI_PANIC_STRING=y
>> CONFIG_IPMI_DEVICE_INTERFACE=m
>> CONFIG_IPMI_SI=m
>> CONFIG_IPMI_SSIF=m
>> CONFIG_IPMI_WATCHDOG=m
>> CONFIG_IPMI_POWEROFF=m
>> CONFIG_HW_RANDOM=y
>> CONFIG_HW_RANDOM_TIMERIOMEM=m
>> CONFIG_HW_RANDOM_INTEL=m
>> # CONFIG_HW_RANDOM_AMD is not set
>> # CONFIG_HW_RANDOM_BA431 is not set
>> CONFIG_HW_RANDOM_VIA=m
>> CONFIG_HW_RANDOM_VIRTIO=y
>> # CONFIG_HW_RANDOM_XIPHERA is not set
>> # CONFIG_APPLICOM is not set
>> # CONFIG_MWAVE is not set
>> CONFIG_DEVMEM=y
>> CONFIG_NVRAM=y
>> CONFIG_DEVPORT=y
>> CONFIG_HPET=y
>> CONFIG_HPET_MMAP=y
>> # CONFIG_HPET_MMAP_DEFAULT is not set
>> CONFIG_HANGCHECK_TIMER=m
>> CONFIG_UV_MMTIMER=m
>> CONFIG_TCG_TPM=y
>> CONFIG_HW_RANDOM_TPM=y
>> CONFIG_TCG_TIS_CORE=y
>> CONFIG_TCG_TIS=y
>> # CONFIG_TCG_TIS_SPI is not set
>> # CONFIG_TCG_TIS_I2C_CR50 is not set
>> CONFIG_TCG_TIS_I2C_ATMEL=m
>> CONFIG_TCG_TIS_I2C_INFINEON=m
>> CONFIG_TCG_TIS_I2C_NUVOTON=m
>> CONFIG_TCG_NSC=m
>> CONFIG_TCG_ATMEL=m
>> CONFIG_TCG_INFINEON=m
>> CONFIG_TCG_CRB=y
>> # CONFIG_TCG_VTPM_PROXY is not set
>> CONFIG_TCG_TIS_ST33ZP24=m
>> CONFIG_TCG_TIS_ST33ZP24_I2C=m
>> # CONFIG_TCG_TIS_ST33ZP24_SPI is not set
>> CONFIG_TELCLOCK=m
>> # CONFIG_XILLYBUS is not set
>> # CONFIG_XILLYUSB is not set
>> # CONFIG_RANDOM_TRUST_CPU is not set
>> # CONFIG_RANDOM_TRUST_BOOTLOADER is not set
>> # end of Character devices
>>
>> #
>> # I2C support
>> #
>> CONFIG_I2C=y
>> CONFIG_ACPI_I2C_OPREGION=y
>> CONFIG_I2C_BOARDINFO=y
>> CONFIG_I2C_COMPAT=y
>> CONFIG_I2C_CHARDEV=m
>> CONFIG_I2C_MUX=m
>>
>> #
>> # Multiplexer I2C Chip support
>> #
>> # CONFIG_I2C_MUX_GPIO is not set
>> # CONFIG_I2C_MUX_LTC4306 is not set
>> # CONFIG_I2C_MUX_PCA9541 is not set
>> # CONFIG_I2C_MUX_PCA954x is not set
>> # CONFIG_I2C_MUX_REG is not set
>> CONFIG_I2C_MUX_MLXCPLD=m
>> # end of Multiplexer I2C Chip support
>>
>> CONFIG_I2C_HELPER_AUTO=y
>> CONFIG_I2C_SMBUS=y
>> CONFIG_I2C_ALGOBIT=y
>> CONFIG_I2C_ALGOPCA=m
>>
>> #
>> # I2C Hardware Bus support
>> #
>>
>> #
>> # PC SMBus host controller drivers
>> #
>> # CONFIG_I2C_ALI1535 is not set
>> # CONFIG_I2C_ALI1563 is not set
>> # CONFIG_I2C_ALI15X3 is not set
>> # CONFIG_I2C_AMD756 is not set
>> # CONFIG_I2C_AMD8111 is not set
>> # CONFIG_I2C_AMD_MP2 is not set
>> CONFIG_I2C_I801=y
>> CONFIG_I2C_ISCH=m
>> CONFIG_I2C_ISMT=m
>> CONFIG_I2C_PIIX4=m
>> CONFIG_I2C_NFORCE2=m
>> CONFIG_I2C_NFORCE2_S4985=m
>> # CONFIG_I2C_NVIDIA_GPU is not set
>> # CONFIG_I2C_SIS5595 is not set
>> # CONFIG_I2C_SIS630 is not set
>> CONFIG_I2C_SIS96X=m
>> CONFIG_I2C_VIA=m
>> CONFIG_I2C_VIAPRO=m
>>
>> #
>> # ACPI drivers
>> #
>> CONFIG_I2C_SCMI=m
>>
>> #
>> # I2C system bus drivers (mostly embedded / system-on-chip)
>> #
>> # CONFIG_I2C_CBUS_GPIO is not set
>> CONFIG_I2C_DESIGNWARE_CORE=m
>> # CONFIG_I2C_DESIGNWARE_SLAVE is not set
>> CONFIG_I2C_DESIGNWARE_PLATFORM=m
>> CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
>> # CONFIG_I2C_DESIGNWARE_PCI is not set
>> # CONFIG_I2C_EMEV2 is not set
>> # CONFIG_I2C_GPIO is not set
>> # CONFIG_I2C_OCORES is not set
>> CONFIG_I2C_PCA_PLATFORM=m
>> CONFIG_I2C_SIMTEC=m
>> # CONFIG_I2C_XILINX is not set
>>
>> #
>> # External I2C/SMBus adapter drivers
>> #
>> # CONFIG_I2C_DIOLAN_U2C is not set
>> # CONFIG_I2C_CP2615 is not set
>> CONFIG_I2C_PARPORT=m
>> # CONFIG_I2C_ROBOTFUZZ_OSIF is not set
>> # CONFIG_I2C_TAOS_EVM is not set
>> # CONFIG_I2C_TINY_USB is not set
>>
>> #
>> # Other I2C/SMBus bus drivers
>> #
>> CONFIG_I2C_MLXCPLD=m
>> # CONFIG_I2C_VIRTIO is not set
>> # end of I2C Hardware Bus support
>>
>> CONFIG_I2C_STUB=m
>> # CONFIG_I2C_SLAVE is not set
>> # CONFIG_I2C_DEBUG_CORE is not set
>> # CONFIG_I2C_DEBUG_ALGO is not set
>> # CONFIG_I2C_DEBUG_BUS is not set
>> # end of I2C support
>>
>> # CONFIG_I3C is not set
>> CONFIG_SPI=y
>> # CONFIG_SPI_DEBUG is not set
>> CONFIG_SPI_MASTER=y
>> # CONFIG_SPI_MEM is not set
>>
>> #
>> # SPI Master Controller Drivers
>> #
>> # CONFIG_SPI_ALTERA is not set
>> # CONFIG_SPI_AXI_SPI_ENGINE is not set
>> # CONFIG_SPI_BITBANG is not set
>> # CONFIG_SPI_BUTTERFLY is not set
>> # CONFIG_SPI_CADENCE is not set
>> # CONFIG_SPI_DESIGNWARE is not set
>> # CONFIG_SPI_NXP_FLEXSPI is not set
>> # CONFIG_SPI_GPIO is not set
>> # CONFIG_SPI_LM70_LLP is not set
>> # CONFIG_SPI_LANTIQ_SSC is not set
>> # CONFIG_SPI_OC_TINY is not set
>> # CONFIG_SPI_PXA2XX is not set
>> # CONFIG_SPI_ROCKCHIP is not set
>> # CONFIG_SPI_SC18IS602 is not set
>> # CONFIG_SPI_SIFIVE is not set
>> # CONFIG_SPI_MXIC is not set
>> # CONFIG_SPI_XCOMM is not set
>> # CONFIG_SPI_XILINX is not set
>> # CONFIG_SPI_ZYNQMP_GQSPI is not set
>> # CONFIG_SPI_AMD is not set
>>
>> #
>> # SPI Multiplexer support
>> #
>> # CONFIG_SPI_MUX is not set
>>
>> #
>> # SPI Protocol Masters
>> #
>> # CONFIG_SPI_SPIDEV is not set
>> # CONFIG_SPI_LOOPBACK_TEST is not set
>> # CONFIG_SPI_TLE62X0 is not set
>> # CONFIG_SPI_SLAVE is not set
>> CONFIG_SPI_DYNAMIC=y
>> # CONFIG_SPMI is not set
>> # CONFIG_HSI is not set
>> CONFIG_PPS=y
>> # CONFIG_PPS_DEBUG is not set
>>
>> #
>> # PPS clients support
>> #
>> # CONFIG_PPS_CLIENT_KTIMER is not set
>> CONFIG_PPS_CLIENT_LDISC=m
>> CONFIG_PPS_CLIENT_PARPORT=m
>> CONFIG_PPS_CLIENT_GPIO=m
>>
>> #
>> # PPS generators support
>> #
>>
>> #
>> # PTP clock support
>> #
>> CONFIG_PTP_1588_CLOCK=y
>> CONFIG_PTP_1588_CLOCK_OPTIONAL=y
>> # CONFIG_DP83640_PHY is not set
>> # CONFIG_PTP_1588_CLOCK_INES is not set
>> CONFIG_PTP_1588_CLOCK_KVM=m
>> # CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
>> # CONFIG_PTP_1588_CLOCK_IDTCM is not set
>> # CONFIG_PTP_1588_CLOCK_VMW is not set
>> # end of PTP clock support
>>
>> CONFIG_PINCTRL=y
>> # CONFIG_DEBUG_PINCTRL is not set
>> # CONFIG_PINCTRL_AMD is not set
>> # CONFIG_PINCTRL_MCP23S08 is not set
>> # CONFIG_PINCTRL_SX150X is not set
>>
>> #
>> # Intel pinctrl drivers
>> #
>> # CONFIG_PINCTRL_BAYTRAIL is not set
>> # CONFIG_PINCTRL_CHERRYVIEW is not set
>> # CONFIG_PINCTRL_LYNXPOINT is not set
>> # CONFIG_PINCTRL_ALDERLAKE is not set
>> # CONFIG_PINCTRL_BROXTON is not set
>> # CONFIG_PINCTRL_CANNONLAKE is not set
>> # CONFIG_PINCTRL_CEDARFORK is not set
>> # CONFIG_PINCTRL_DENVERTON is not set
>> # CONFIG_PINCTRL_ELKHARTLAKE is not set
>> # CONFIG_PINCTRL_EMMITSBURG is not set
>> # CONFIG_PINCTRL_GEMINILAKE is not set
>> # CONFIG_PINCTRL_ICELAKE is not set
>> # CONFIG_PINCTRL_JASPERLAKE is not set
>> # CONFIG_PINCTRL_LAKEFIELD is not set
>> # CONFIG_PINCTRL_LEWISBURG is not set
>> # CONFIG_PINCTRL_SUNRISEPOINT is not set
>> # CONFIG_PINCTRL_TIGERLAKE is not set
>> # end of Intel pinctrl drivers
>>
>> #
>> # Renesas pinctrl drivers
>> #
>> # end of Renesas pinctrl drivers
>>
>> CONFIG_GPIOLIB=y
>> CONFIG_GPIOLIB_FASTPATH_LIMIT=512
>> CONFIG_GPIO_ACPI=y
>> # CONFIG_DEBUG_GPIO is not set
>> CONFIG_GPIO_CDEV=y
>> CONFIG_GPIO_CDEV_V1=y
>>
>> #
>> # Memory mapped GPIO drivers
>> #
>> # CONFIG_GPIO_AMDPT is not set
>> # CONFIG_GPIO_DWAPB is not set
>> # CONFIG_GPIO_EXAR is not set
>> # CONFIG_GPIO_GENERIC_PLATFORM is not set
>> CONFIG_GPIO_ICH=m
>> # CONFIG_GPIO_MB86S7X is not set
>> # CONFIG_GPIO_VX855 is not set
>> # CONFIG_GPIO_AMD_FCH is not set
>> # end of Memory mapped GPIO drivers
>>
>> #
>> # Port-mapped I/O GPIO drivers
>> #
>> # CONFIG_GPIO_F7188X is not set
>> # CONFIG_GPIO_IT87 is not set
>> # CONFIG_GPIO_SCH is not set
>> # CONFIG_GPIO_SCH311X is not set
>> # CONFIG_GPIO_WINBOND is not set
>> # CONFIG_GPIO_WS16C48 is not set
>> # end of Port-mapped I/O GPIO drivers
>>
>> #
>> # I2C GPIO expanders
>> #
>> # CONFIG_GPIO_ADP5588 is not set
>> # CONFIG_GPIO_MAX7300 is not set
>> # CONFIG_GPIO_MAX732X is not set
>> # CONFIG_GPIO_PCA953X is not set
>> # CONFIG_GPIO_PCA9570 is not set
>> # CONFIG_GPIO_PCF857X is not set
>> # CONFIG_GPIO_TPIC2810 is not set
>> # end of I2C GPIO expanders
>>
>> #
>> # MFD GPIO expanders
>> #
>> # end of MFD GPIO expanders
>>
>> #
>> # PCI GPIO expanders
>> #
>> # CONFIG_GPIO_AMD8111 is not set
>> # CONFIG_GPIO_BT8XX is not set
>> # CONFIG_GPIO_ML_IOH is not set
>> # CONFIG_GPIO_PCI_IDIO_16 is not set
>> # CONFIG_GPIO_PCIE_IDIO_24 is not set
>> # CONFIG_GPIO_RDC321X is not set
>> # end of PCI GPIO expanders
>>
>> #
>> # SPI GPIO expanders
>> #
>> # CONFIG_GPIO_MAX3191X is not set
>> # CONFIG_GPIO_MAX7301 is not set
>> # CONFIG_GPIO_MC33880 is not set
>> # CONFIG_GPIO_PISOSR is not set
>> # CONFIG_GPIO_XRA1403 is not set
>> # end of SPI GPIO expanders
>>
>> #
>> # USB GPIO expanders
>> #
>> # end of USB GPIO expanders
>>
>> #
>> # Virtual GPIO drivers
>> #
>> # CONFIG_GPIO_AGGREGATOR is not set
>> # CONFIG_GPIO_MOCKUP is not set
>> # CONFIG_GPIO_VIRTIO is not set
>> # CONFIG_GPIO_SIM is not set
>> # end of Virtual GPIO drivers
>>
>> # CONFIG_W1 is not set
>> CONFIG_POWER_RESET=y
>> # CONFIG_POWER_RESET_RESTART is not set
>> CONFIG_POWER_SUPPLY=y
>> # CONFIG_POWER_SUPPLY_DEBUG is not set
>> CONFIG_POWER_SUPPLY_HWMON=y
>> # CONFIG_PDA_POWER is not set
>> # CONFIG_TEST_POWER is not set
>> # CONFIG_CHARGER_ADP5061 is not set
>> # CONFIG_BATTERY_CW2015 is not set
>> # CONFIG_BATTERY_DS2780 is not set
>> # CONFIG_BATTERY_DS2781 is not set
>> # CONFIG_BATTERY_DS2782 is not set
>> # CONFIG_BATTERY_SBS is not set
>> # CONFIG_CHARGER_SBS is not set
>> # CONFIG_MANAGER_SBS is not set
>> # CONFIG_BATTERY_BQ27XXX is not set
>> # CONFIG_BATTERY_MAX17040 is not set
>> # CONFIG_BATTERY_MAX17042 is not set
>> # CONFIG_CHARGER_MAX8903 is not set
>> # CONFIG_CHARGER_LP8727 is not set
>> # CONFIG_CHARGER_GPIO is not set
>> # CONFIG_CHARGER_LT3651 is not set
>> # CONFIG_CHARGER_LTC4162L is not set
>> # CONFIG_CHARGER_MAX77976 is not set
>> # CONFIG_CHARGER_BQ2415X is not set
>> # CONFIG_CHARGER_BQ24257 is not set
>> # CONFIG_CHARGER_BQ24735 is not set
>> # CONFIG_CHARGER_BQ2515X is not set
>> # CONFIG_CHARGER_BQ25890 is not set
>> # CONFIG_CHARGER_BQ25980 is not set
>> # CONFIG_CHARGER_BQ256XX is not set
>> # CONFIG_BATTERY_GAUGE_LTC2941 is not set
>> # CONFIG_BATTERY_GOLDFISH is not set
>> # CONFIG_BATTERY_RT5033 is not set
>> # CONFIG_CHARGER_RT9455 is not set
>> # CONFIG_CHARGER_BD99954 is not set
>> CONFIG_HWMON=y
>> CONFIG_HWMON_VID=m
>> # CONFIG_HWMON_DEBUG_CHIP is not set
>>
>> #
>> # Native drivers
>> #
>> CONFIG_SENSORS_ABITUGURU=m
>> CONFIG_SENSORS_ABITUGURU3=m
>> # CONFIG_SENSORS_AD7314 is not set
>> CONFIG_SENSORS_AD7414=m
>> CONFIG_SENSORS_AD7418=m
>> CONFIG_SENSORS_ADM1021=m
>> CONFIG_SENSORS_ADM1025=m
>> CONFIG_SENSORS_ADM1026=m
>> CONFIG_SENSORS_ADM1029=m
>> CONFIG_SENSORS_ADM1031=m
>> # CONFIG_SENSORS_ADM1177 is not set
>> CONFIG_SENSORS_ADM9240=m
>> CONFIG_SENSORS_ADT7X10=m
>> # CONFIG_SENSORS_ADT7310 is not set
>> CONFIG_SENSORS_ADT7410=m
>> CONFIG_SENSORS_ADT7411=m
>> CONFIG_SENSORS_ADT7462=m
>> CONFIG_SENSORS_ADT7470=m
>> CONFIG_SENSORS_ADT7475=m
>> # CONFIG_SENSORS_AHT10 is not set
>> # CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
>> # CONFIG_SENSORS_AS370 is not set
>> CONFIG_SENSORS_ASC7621=m
>> # CONFIG_SENSORS_AXI_FAN_CONTROL is not set
>> CONFIG_SENSORS_K8TEMP=m
>> CONFIG_SENSORS_K10TEMP=m
>> CONFIG_SENSORS_FAM15H_POWER=m
>> CONFIG_SENSORS_APPLESMC=m
>> CONFIG_SENSORS_ASB100=m
>> # CONFIG_SENSORS_ASPEED is not set
>> CONFIG_SENSORS_ATXP1=m
>> # CONFIG_SENSORS_CORSAIR_CPRO is not set
>> # CONFIG_SENSORS_CORSAIR_PSU is not set
>> # CONFIG_SENSORS_DRIVETEMP is not set
>> CONFIG_SENSORS_DS620=m
>> CONFIG_SENSORS_DS1621=m
>> CONFIG_SENSORS_DELL_SMM=m
>> CONFIG_SENSORS_I5K_AMB=m
>> CONFIG_SENSORS_F71805F=m
>> CONFIG_SENSORS_F71882FG=m
>> CONFIG_SENSORS_F75375S=m
>> CONFIG_SENSORS_FSCHMD=m
>> # CONFIG_SENSORS_FTSTEUTATES is not set
>> CONFIG_SENSORS_GL518SM=m
>> CONFIG_SENSORS_GL520SM=m
>> CONFIG_SENSORS_G760A=m
>> # CONFIG_SENSORS_G762 is not set
>> # CONFIG_SENSORS_HIH6130 is not set
>> CONFIG_SENSORS_IBMAEM=m
>> CONFIG_SENSORS_IBMPEX=m
>> CONFIG_SENSORS_I5500=m
>> CONFIG_SENSORS_CORETEMP=m
>> CONFIG_SENSORS_IT87=m
>> CONFIG_SENSORS_JC42=m
>> # CONFIG_SENSORS_POWR1220 is not set
>> CONFIG_SENSORS_LINEAGE=m
>> # CONFIG_SENSORS_LTC2945 is not set
>> # CONFIG_SENSORS_LTC2947_I2C is not set
>> # CONFIG_SENSORS_LTC2947_SPI is not set
>> # CONFIG_SENSORS_LTC2990 is not set
>> # CONFIG_SENSORS_LTC2992 is not set
>> CONFIG_SENSORS_LTC4151=m
>> CONFIG_SENSORS_LTC4215=m
>> # CONFIG_SENSORS_LTC4222 is not set
>> CONFIG_SENSORS_LTC4245=m
>> # CONFIG_SENSORS_LTC4260 is not set
>> CONFIG_SENSORS_LTC4261=m
>> # CONFIG_SENSORS_MAX1111 is not set
>> # CONFIG_SENSORS_MAX127 is not set
>> CONFIG_SENSORS_MAX16065=m
>> CONFIG_SENSORS_MAX1619=m
>> CONFIG_SENSORS_MAX1668=m
>> CONFIG_SENSORS_MAX197=m
>> # CONFIG_SENSORS_MAX31722 is not set
>> # CONFIG_SENSORS_MAX31730 is not set
>> # CONFIG_SENSORS_MAX6620 is not set
>> # CONFIG_SENSORS_MAX6621 is not set
>> CONFIG_SENSORS_MAX6639=m
>> CONFIG_SENSORS_MAX6642=m
>> CONFIG_SENSORS_MAX6650=m
>> CONFIG_SENSORS_MAX6697=m
>> # CONFIG_SENSORS_MAX31790 is not set
>> CONFIG_SENSORS_MCP3021=m
>> # CONFIG_SENSORS_MLXREG_FAN is not set
>> # CONFIG_SENSORS_TC654 is not set
>> # CONFIG_SENSORS_TPS23861 is not set
>> # CONFIG_SENSORS_MR75203 is not set
>> # CONFIG_SENSORS_ADCXX is not set
>> CONFIG_SENSORS_LM63=m
>> # CONFIG_SENSORS_LM70 is not set
>> CONFIG_SENSORS_LM73=m
>> CONFIG_SENSORS_LM75=m
>> CONFIG_SENSORS_LM77=m
>> CONFIG_SENSORS_LM78=m
>> CONFIG_SENSORS_LM80=m
>> CONFIG_SENSORS_LM83=m
>> CONFIG_SENSORS_LM85=m
>> CONFIG_SENSORS_LM87=m
>> CONFIG_SENSORS_LM90=m
>> CONFIG_SENSORS_LM92=m
>> CONFIG_SENSORS_LM93=m
>> CONFIG_SENSORS_LM95234=m
>> CONFIG_SENSORS_LM95241=m
>> CONFIG_SENSORS_LM95245=m
>> CONFIG_SENSORS_PC87360=m
>> CONFIG_SENSORS_PC87427=m
>> # CONFIG_SENSORS_NCT6683 is not set
>> CONFIG_SENSORS_NCT6775=m
>> # CONFIG_SENSORS_NCT7802 is not set
>> # CONFIG_SENSORS_NCT7904 is not set
>> # CONFIG_SENSORS_NPCM7XX is not set
>> # CONFIG_SENSORS_NZXT_KRAKEN2 is not set
>> # CONFIG_SENSORS_NZXT_SMART2 is not set
>> CONFIG_SENSORS_PCF8591=m
>> CONFIG_PMBUS=m
>> CONFIG_SENSORS_PMBUS=m
>> # CONFIG_SENSORS_ADM1266 is not set
>> CONFIG_SENSORS_ADM1275=m
>> # CONFIG_SENSORS_BEL_PFE is not set
>> # CONFIG_SENSORS_BPA_RS600 is not set
>> # CONFIG_SENSORS_DELTA_AHE50DC_FAN is not set
>> # CONFIG_SENSORS_FSP_3Y is not set
>> # CONFIG_SENSORS_IBM_CFFPS is not set
>> # CONFIG_SENSORS_DPS920AB is not set
>> # CONFIG_SENSORS_INSPUR_IPSPS is not set
>> # CONFIG_SENSORS_IR35221 is not set
>> # CONFIG_SENSORS_IR36021 is not set
>> # CONFIG_SENSORS_IR38064 is not set
>> # CONFIG_SENSORS_IRPS5401 is not set
>> # CONFIG_SENSORS_ISL68137 is not set
>> CONFIG_SENSORS_LM25066=m
>> CONFIG_SENSORS_LTC2978=m
>> # CONFIG_SENSORS_LTC3815 is not set
>> # CONFIG_SENSORS_MAX15301 is not set
>> CONFIG_SENSORS_MAX16064=m
>> # CONFIG_SENSORS_MAX16601 is not set
>> # CONFIG_SENSORS_MAX20730 is not set
>> # CONFIG_SENSORS_MAX20751 is not set
>> # CONFIG_SENSORS_MAX31785 is not set
>> CONFIG_SENSORS_MAX34440=m
>> CONFIG_SENSORS_MAX8688=m
>> # CONFIG_SENSORS_MP2888 is not set
>> # CONFIG_SENSORS_MP2975 is not set
>> # CONFIG_SENSORS_MP5023 is not set
>> # CONFIG_SENSORS_PIM4328 is not set
>> # CONFIG_SENSORS_PM6764TR is not set
>> # CONFIG_SENSORS_PXE1610 is not set
>> # CONFIG_SENSORS_Q54SJ108A2 is not set
>> # CONFIG_SENSORS_STPDDC60 is not set
>> # CONFIG_SENSORS_TPS40422 is not set
>> # CONFIG_SENSORS_TPS53679 is not set
>> CONFIG_SENSORS_UCD9000=m
>> CONFIG_SENSORS_UCD9200=m
>> # CONFIG_SENSORS_XDPE122 is not set
>> CONFIG_SENSORS_ZL6100=m
>> # CONFIG_SENSORS_SBTSI is not set
>> # CONFIG_SENSORS_SBRMI is not set
>> CONFIG_SENSORS_SHT15=m
>> CONFIG_SENSORS_SHT21=m
>> # CONFIG_SENSORS_SHT3x is not set
>> # CONFIG_SENSORS_SHT4x is not set
>> # CONFIG_SENSORS_SHTC1 is not set
>> CONFIG_SENSORS_SIS5595=m
>> CONFIG_SENSORS_DME1737=m
>> CONFIG_SENSORS_EMC1403=m
>> # CONFIG_SENSORS_EMC2103 is not set
>> CONFIG_SENSORS_EMC6W201=m
>> CONFIG_SENSORS_SMSC47M1=m
>> CONFIG_SENSORS_SMSC47M192=m
>> CONFIG_SENSORS_SMSC47B397=m
>> CONFIG_SENSORS_SCH56XX_COMMON=m
>> CONFIG_SENSORS_SCH5627=m
>> CONFIG_SENSORS_SCH5636=m
>> # CONFIG_SENSORS_STTS751 is not set
>> # CONFIG_SENSORS_SMM665 is not set
>> # CONFIG_SENSORS_ADC128D818 is not set
>> CONFIG_SENSORS_ADS7828=m
>> # CONFIG_SENSORS_ADS7871 is not set
>> CONFIG_SENSORS_AMC6821=m
>> CONFIG_SENSORS_INA209=m
>> CONFIG_SENSORS_INA2XX=m
>> # CONFIG_SENSORS_INA238 is not set
>> # CONFIG_SENSORS_INA3221 is not set
>> # CONFIG_SENSORS_TC74 is not set
>> CONFIG_SENSORS_THMC50=m
>> CONFIG_SENSORS_TMP102=m
>> # CONFIG_SENSORS_TMP103 is not set
>> # CONFIG_SENSORS_TMP108 is not set
>> CONFIG_SENSORS_TMP401=m
>> CONFIG_SENSORS_TMP421=m
>> # CONFIG_SENSORS_TMP513 is not set
>> CONFIG_SENSORS_VIA_CPUTEMP=m
>> CONFIG_SENSORS_VIA686A=m
>> CONFIG_SENSORS_VT1211=m
>> CONFIG_SENSORS_VT8231=m
>> # CONFIG_SENSORS_W83773G is not set
>> CONFIG_SENSORS_W83781D=m
>> CONFIG_SENSORS_W83791D=m
>> CONFIG_SENSORS_W83792D=m
>> CONFIG_SENSORS_W83793=m
>> CONFIG_SENSORS_W83795=m
>> # CONFIG_SENSORS_W83795_FANCTRL is not set
>> CONFIG_SENSORS_W83L785TS=m
>> CONFIG_SENSORS_W83L786NG=m
>> CONFIG_SENSORS_W83627HF=m
>> CONFIG_SENSORS_W83627EHF=m
>> # CONFIG_SENSORS_XGENE is not set
>>
>> #
>> # ACPI drivers
>> #
>> CONFIG_SENSORS_ACPI_POWER=m
>> CONFIG_SENSORS_ATK0110=m
>> # CONFIG_SENSORS_ASUS_WMI is not set
>> # CONFIG_SENSORS_ASUS_WMI_EC is not set
>> CONFIG_THERMAL=y
>> # CONFIG_THERMAL_NETLINK is not set
>> # CONFIG_THERMAL_STATISTICS is not set
>> CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
>> CONFIG_THERMAL_HWMON=y
>> CONFIG_THERMAL_WRITABLE_TRIPS=y
>> CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
>> # CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
>> # CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
>> CONFIG_THERMAL_GOV_FAIR_SHARE=y
>> CONFIG_THERMAL_GOV_STEP_WISE=y
>> CONFIG_THERMAL_GOV_BANG_BANG=y
>> CONFIG_THERMAL_GOV_USER_SPACE=y
>> # CONFIG_THERMAL_EMULATION is not set
>>
>> #
>> # Intel thermal drivers
>> #
>> CONFIG_INTEL_POWERCLAMP=m
>> CONFIG_X86_THERMAL_VECTOR=y
>> CONFIG_X86_PKG_TEMP_THERMAL=m
>> # CONFIG_INTEL_SOC_DTS_THERMAL is not set
>>
>> #
>> # ACPI INT340X thermal drivers
>> #
>> # CONFIG_INT340X_THERMAL is not set
>> # end of ACPI INT340X thermal drivers
>>
>> CONFIG_INTEL_PCH_THERMAL=m
>> # CONFIG_INTEL_TCC_COOLING is not set
>> # CONFIG_INTEL_MENLOW is not set
>> # end of Intel thermal drivers
>>
>> CONFIG_WATCHDOG=y
>> CONFIG_WATCHDOG_CORE=y
>> # CONFIG_WATCHDOG_NOWAYOUT is not set
>> CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
>> CONFIG_WATCHDOG_OPEN_TIMEOUT=0
>> CONFIG_WATCHDOG_SYSFS=y
>> # CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set
>>
>> #
>> # Watchdog Pretimeout Governors
>> #
>> # CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set
>>
>> #
>> # Watchdog Device Drivers
>> #
>> CONFIG_SOFT_WATCHDOG=m
>> CONFIG_WDAT_WDT=m
>> # CONFIG_XILINX_WATCHDOG is not set
>> # CONFIG_ZIIRAVE_WATCHDOG is not set
>> # CONFIG_MLX_WDT is not set
>> # CONFIG_CADENCE_WATCHDOG is not set
>> # CONFIG_DW_WATCHDOG is not set
>> # CONFIG_MAX63XX_WATCHDOG is not set
>> # CONFIG_ACQUIRE_WDT is not set
>> # CONFIG_ADVANTECH_WDT is not set
>> CONFIG_ALIM1535_WDT=m
>> CONFIG_ALIM7101_WDT=m
>> # CONFIG_EBC_C384_WDT is not set
>> CONFIG_F71808E_WDT=m
>> # CONFIG_SP5100_TCO is not set
>> CONFIG_SBC_FITPC2_WATCHDOG=m
>> # CONFIG_EUROTECH_WDT is not set
>> CONFIG_IB700_WDT=m
>> CONFIG_IBMASR=m
>> # CONFIG_WAFER_WDT is not set
>> CONFIG_I6300ESB_WDT=y
>> CONFIG_IE6XX_WDT=m
>> CONFIG_ITCO_WDT=y
>> CONFIG_ITCO_VENDOR_SUPPORT=y
>> CONFIG_IT8712F_WDT=m
>> CONFIG_IT87_WDT=m
>> CONFIG_HP_WATCHDOG=m
>> CONFIG_HPWDT_NMI_DECODING=y
>> # CONFIG_SC1200_WDT is not set
>> # CONFIG_PC87413_WDT is not set
>> CONFIG_NV_TCO=m
>> # CONFIG_60XX_WDT is not set
>> # CONFIG_CPU5_WDT is not set
>> CONFIG_SMSC_SCH311X_WDT=m
>> # CONFIG_SMSC37B787_WDT is not set
>> # CONFIG_TQMX86_WDT is not set
>> CONFIG_VIA_WDT=m
>> CONFIG_W83627HF_WDT=m
>> CONFIG_W83877F_WDT=m
>> CONFIG_W83977F_WDT=m
>> CONFIG_MACHZ_WDT=m
>> # CONFIG_SBC_EPX_C3_WATCHDOG is not set
>> CONFIG_INTEL_MEI_WDT=m
>> # CONFIG_NI903X_WDT is not set
>> # CONFIG_NIC7018_WDT is not set
>> # CONFIG_MEN_A21_WDT is not set
>>
>> #
>> # PCI-based Watchdog Cards
>> #
>> CONFIG_PCIPCWATCHDOG=m
>> CONFIG_WDTPCI=m
>>
>> #
>> # USB-based Watchdog Cards
>> #
>> # CONFIG_USBPCWATCHDOG is not set
>> CONFIG_SSB_POSSIBLE=y
>> # CONFIG_SSB is not set
>> CONFIG_BCMA_POSSIBLE=y
>> CONFIG_BCMA=m
>> CONFIG_BCMA_HOST_PCI_POSSIBLE=y
>> CONFIG_BCMA_HOST_PCI=y
>> # CONFIG_BCMA_HOST_SOC is not set
>> CONFIG_BCMA_DRIVER_PCI=y
>> CONFIG_BCMA_DRIVER_GMAC_CMN=y
>> CONFIG_BCMA_DRIVER_GPIO=y
>> # CONFIG_BCMA_DEBUG is not set
>>
>> #
>> # Multifunction device drivers
>> #
>> CONFIG_MFD_CORE=y
>> # CONFIG_MFD_AS3711 is not set
>> # CONFIG_PMIC_ADP5520 is not set
>> # CONFIG_MFD_AAT2870_CORE is not set
>> # CONFIG_MFD_BCM590XX is not set
>> # CONFIG_MFD_BD9571MWV is not set
>> # CONFIG_MFD_AXP20X_I2C is not set
>> # CONFIG_MFD_MADERA is not set
>> # CONFIG_PMIC_DA903X is not set
>> # CONFIG_MFD_DA9052_SPI is not set
>> # CONFIG_MFD_DA9052_I2C is not set
>> # CONFIG_MFD_DA9055 is not set
>> # CONFIG_MFD_DA9062 is not set
>> # CONFIG_MFD_DA9063 is not set
>> # CONFIG_MFD_DA9150 is not set
>> # CONFIG_MFD_DLN2 is not set
>> # CONFIG_MFD_MC13XXX_SPI is not set
>> # CONFIG_MFD_MC13XXX_I2C is not set
>> # CONFIG_MFD_MP2629 is not set
>> # CONFIG_HTC_PASIC3 is not set
>> # CONFIG_HTC_I2CPLD is not set
>> # CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
>> CONFIG_LPC_ICH=y
>> CONFIG_LPC_SCH=m
>> CONFIG_MFD_INTEL_LPSS=y
>> CONFIG_MFD_INTEL_LPSS_ACPI=y
>> CONFIG_MFD_INTEL_LPSS_PCI=y
>> # CONFIG_MFD_INTEL_PMC_BXT is not set
>> # CONFIG_MFD_IQS62X is not set
>> # CONFIG_MFD_JANZ_CMODIO is not set
>> # CONFIG_MFD_KEMPLD is not set
>> # CONFIG_MFD_88PM800 is not set
>> # CONFIG_MFD_88PM805 is not set
>> # CONFIG_MFD_88PM860X is not set
>> # CONFIG_MFD_MAX14577 is not set
>> # CONFIG_MFD_MAX77693 is not set
>> # CONFIG_MFD_MAX77843 is not set
>> # CONFIG_MFD_MAX8907 is not set
>> # CONFIG_MFD_MAX8925 is not set
>> # CONFIG_MFD_MAX8997 is not set
>> # CONFIG_MFD_MAX8998 is not set
>> # CONFIG_MFD_MT6360 is not set
>> # CONFIG_MFD_MT6397 is not set
>> # CONFIG_MFD_MENF21BMC is not set
>> # CONFIG_EZX_PCAP is not set
>> # CONFIG_MFD_VIPERBOARD is not set
>> # CONFIG_MFD_RETU is not set
>> # CONFIG_MFD_PCF50633 is not set
>> # CONFIG_MFD_RDC321X is not set
>> # CONFIG_MFD_RT4831 is not set
>> # CONFIG_MFD_RT5033 is not set
>> # CONFIG_MFD_RC5T583 is not set
>> # CONFIG_MFD_SI476X_CORE is not set
>> CONFIG_MFD_SM501=m
>> CONFIG_MFD_SM501_GPIO=y
>> # CONFIG_MFD_SKY81452 is not set
>> # CONFIG_MFD_SYSCON is not set
>> # CONFIG_MFD_TI_AM335X_TSCADC is not set
>> # CONFIG_MFD_LP3943 is not set
>> # CONFIG_MFD_LP8788 is not set
>> # CONFIG_MFD_TI_LMU is not set
>> # CONFIG_MFD_PALMAS is not set
>> # CONFIG_TPS6105X is not set
>> # CONFIG_TPS65010 is not set
>> # CONFIG_TPS6507X is not set
>> # CONFIG_MFD_TPS65086 is not set
>> # CONFIG_MFD_TPS65090 is not set
>> # CONFIG_MFD_TI_LP873X is not set
>> # CONFIG_MFD_TPS6586X is not set
>> # CONFIG_MFD_TPS65910 is not set
>> # CONFIG_MFD_TPS65912_I2C is not set
>> # CONFIG_MFD_TPS65912_SPI is not set
>> # CONFIG_TWL4030_CORE is not set
>> # CONFIG_TWL6040_CORE is not set
>> # CONFIG_MFD_WL1273_CORE is not set
>> # CONFIG_MFD_LM3533 is not set
>> # CONFIG_MFD_TQMX86 is not set
>> CONFIG_MFD_VX855=m
>> # CONFIG_MFD_ARIZONA_I2C is not set
>> # CONFIG_MFD_ARIZONA_SPI is not set
>> # CONFIG_MFD_WM8400 is not set
>> # CONFIG_MFD_WM831X_I2C is not set
>> # CONFIG_MFD_WM831X_SPI is not set
>> # CONFIG_MFD_WM8350_I2C is not set
>> # CONFIG_MFD_WM8994 is not set
>> # CONFIG_MFD_ATC260X_I2C is not set
>> # CONFIG_MFD_INTEL_M10_BMC is not set
>> # end of Multifunction device drivers
>>
>> # CONFIG_REGULATOR is not set
>> CONFIG_RC_CORE=m
>> CONFIG_RC_MAP=m
>> CONFIG_LIRC=y
>> CONFIG_RC_DECODERS=y
>> CONFIG_IR_NEC_DECODER=m
>> CONFIG_IR_RC5_DECODER=m
>> CONFIG_IR_RC6_DECODER=m
>> CONFIG_IR_JVC_DECODER=m
>> CONFIG_IR_SONY_DECODER=m
>> CONFIG_IR_SANYO_DECODER=m
>> # CONFIG_IR_SHARP_DECODER is not set
>> CONFIG_IR_MCE_KBD_DECODER=m
>> # CONFIG_IR_XMP_DECODER is not set
>> CONFIG_IR_IMON_DECODER=m
>> # CONFIG_IR_RCMM_DECODER is not set
>> CONFIG_RC_DEVICES=y
>> # CONFIG_RC_ATI_REMOTE is not set
>> CONFIG_IR_ENE=m
>> # CONFIG_IR_IMON is not set
>> # CONFIG_IR_IMON_RAW is not set
>> # CONFIG_IR_MCEUSB is not set
>> CONFIG_IR_ITE_CIR=m
>> CONFIG_IR_FINTEK=m
>> CONFIG_IR_NUVOTON=m
>> # CONFIG_IR_REDRAT3 is not set
>> # CONFIG_IR_STREAMZAP is not set
>> CONFIG_IR_WINBOND_CIR=m
>> # CONFIG_IR_IGORPLUGUSB is not set
>> # CONFIG_IR_IGUANA is not set
>> # CONFIG_IR_TTUSBIR is not set
>> # CONFIG_RC_LOOPBACK is not set
>> CONFIG_IR_SERIAL=m
>> CONFIG_IR_SERIAL_TRANSMITTER=y
>> # CONFIG_RC_XBOX_DVD is not set
>> # CONFIG_IR_TOY is not set
>>
>> #
>> # CEC support
>> #
>> # CONFIG_MEDIA_CEC_SUPPORT is not set
>> # end of CEC support
>>
>> CONFIG_MEDIA_SUPPORT=m
>> CONFIG_MEDIA_SUPPORT_FILTER=y
>> CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
>>
>> #
>> # Media device types
>> #
>> # CONFIG_MEDIA_CAMERA_SUPPORT is not set
>> # CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
>> # CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
>> # CONFIG_MEDIA_RADIO_SUPPORT is not set
>> # CONFIG_MEDIA_SDR_SUPPORT is not set
>> # CONFIG_MEDIA_PLATFORM_SUPPORT is not set
>> # CONFIG_MEDIA_TEST_SUPPORT is not set
>> # end of Media device types
>>
>> #
>> # Media drivers
>> #
>>
>> #
>> # Drivers filtered as selected at 'Filter media drivers'
>> #
>> # CONFIG_MEDIA_USB_SUPPORT is not set
>> # CONFIG_MEDIA_PCI_SUPPORT is not set
>> # end of Media drivers
>>
>> CONFIG_MEDIA_HIDE_ANCILLARY_SUBDRV=y
>>
>> #
>> # Media ancillary drivers
>> #
>>
>> #
>> # Media SPI Adapters
>> #
>> # end of Media SPI Adapters
>> # end of Media ancillary drivers
>>
>> #
>> # Graphics support
>> #
>> # CONFIG_AGP is not set
>> CONFIG_INTEL_GTT=m
>> CONFIG_VGA_ARB=y
>> CONFIG_VGA_ARB_MAX_GPUS=64
>> CONFIG_VGA_SWITCHEROO=y
>> CONFIG_DRM=m
>> CONFIG_DRM_MIPI_DSI=y
>> CONFIG_DRM_DP_AUX_CHARDEV=y
>> # CONFIG_DRM_DEBUG_SELFTEST is not set
>> CONFIG_DRM_KMS_HELPER=m
>> CONFIG_DRM_FBDEV_EMULATION=y
>> CONFIG_DRM_FBDEV_OVERALLOC=100
>> CONFIG_DRM_LOAD_EDID_FIRMWARE=y
>> # CONFIG_DRM_DP_CEC is not set
>> CONFIG_DRM_TTM=m
>> CONFIG_DRM_VRAM_HELPER=m
>> CONFIG_DRM_TTM_HELPER=m
>> CONFIG_DRM_GEM_SHMEM_HELPER=m
>>
>> #
>> # I2C encoder or helper chips
>> #
>> CONFIG_DRM_I2C_CH7006=m
>> CONFIG_DRM_I2C_SIL164=m
>> # CONFIG_DRM_I2C_NXP_TDA998X is not set
>> # CONFIG_DRM_I2C_NXP_TDA9950 is not set
>> # end of I2C encoder or helper chips
>>
>> #
>> # ARM devices
>> #
>> # end of ARM devices
>>
>> # CONFIG_DRM_RADEON is not set
>> # CONFIG_DRM_AMDGPU is not set
>> # CONFIG_DRM_NOUVEAU is not set
>> CONFIG_DRM_I915=m
>> CONFIG_DRM_I915_FORCE_PROBE=""
>> CONFIG_DRM_I915_CAPTURE_ERROR=y
>> CONFIG_DRM_I915_COMPRESS_ERROR=y
>> CONFIG_DRM_I915_USERPTR=y
>> CONFIG_DRM_I915_GVT=y
>> # CONFIG_DRM_I915_GVT_KVMGT is not set
>> CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
>> CONFIG_DRM_I915_FENCE_TIMEOUT=10000
>> CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
>> CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
>> CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
>> CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
>> CONFIG_DRM_I915_STOP_TIMEOUT=100
>> CONFIG_DRM_I915_TIMESLICE_DURATION=1
>> # CONFIG_DRM_VGEM is not set
>> # CONFIG_DRM_VKMS is not set
>> # CONFIG_DRM_VMWGFX is not set
>> CONFIG_DRM_GMA500=m
>> # CONFIG_DRM_UDL is not set
>> CONFIG_DRM_AST=m
>> CONFIG_DRM_MGAG200=m
>> CONFIG_DRM_QXL=m
>> CONFIG_DRM_VIRTIO_GPU=m
>> CONFIG_DRM_PANEL=y
>>
>> #
>> # Display Panels
>> #
>> # CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
>> # CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
>> # end of Display Panels
>>
>> CONFIG_DRM_BRIDGE=y
>> CONFIG_DRM_PANEL_BRIDGE=y
>>
>> #
>> # Display Interface Bridges
>> #
>> # CONFIG_DRM_ANALOGIX_ANX78XX is not set
>> # end of Display Interface Bridges
>>
>> # CONFIG_DRM_ETNAVIV is not set
>> CONFIG_DRM_BOCHS=m
>> CONFIG_DRM_CIRRUS_QEMU=m
>> # CONFIG_DRM_GM12U320 is not set
>> # CONFIG_DRM_SIMPLEDRM is not set
>> # CONFIG_TINYDRM_HX8357D is not set
>> # CONFIG_TINYDRM_ILI9163 is not set
>> # CONFIG_TINYDRM_ILI9225 is not set
>> # CONFIG_TINYDRM_ILI9341 is not set
>> # CONFIG_TINYDRM_ILI9486 is not set
>> # CONFIG_TINYDRM_MI0283QT is not set
>> # CONFIG_TINYDRM_REPAPER is not set
>> # CONFIG_TINYDRM_ST7586 is not set
>> # CONFIG_TINYDRM_ST7735R is not set
>> # CONFIG_DRM_VBOXVIDEO is not set
>> # CONFIG_DRM_GUD is not set
>> # CONFIG_DRM_LEGACY is not set
>> CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
>> CONFIG_DRM_NOMODESET=y
>> CONFIG_DRM_PRIVACY_SCREEN=y
>>
>> #
>> # Frame buffer Devices
>> #
>> CONFIG_FB_CMDLINE=y
>> CONFIG_FB_NOTIFY=y
>> CONFIG_FB=y
>> # CONFIG_FIRMWARE_EDID is not set
>> CONFIG_FB_BOOT_VESA_SUPPORT=y
>> CONFIG_FB_CFB_FILLRECT=y
>> CONFIG_FB_CFB_COPYAREA=y
>> CONFIG_FB_CFB_IMAGEBLIT=y
>> CONFIG_FB_SYS_FILLRECT=m
>> CONFIG_FB_SYS_COPYAREA=m
>> CONFIG_FB_SYS_IMAGEBLIT=m
>> # CONFIG_FB_FOREIGN_ENDIAN is not set
>> CONFIG_FB_SYS_FOPS=m
>> CONFIG_FB_DEFERRED_IO=y
>> # CONFIG_FB_MODE_HELPERS is not set
>> CONFIG_FB_TILEBLITTING=y
>>
>> #
>> # Frame buffer hardware drivers
>> #
>> # CONFIG_FB_CIRRUS is not set
>> # CONFIG_FB_PM2 is not set
>> # CONFIG_FB_CYBER2000 is not set
>> # CONFIG_FB_ARC is not set
>> # CONFIG_FB_ASILIANT is not set
>> # CONFIG_FB_IMSTT is not set
>> # CONFIG_FB_VGA16 is not set
>> # CONFIG_FB_UVESA is not set
>> CONFIG_FB_VESA=y
>> CONFIG_FB_EFI=y
>> # CONFIG_FB_N411 is not set
>> # CONFIG_FB_HGA is not set
>> # CONFIG_FB_OPENCORES is not set
>> # CONFIG_FB_S1D13XXX is not set
>> # CONFIG_FB_NVIDIA is not set
>> # CONFIG_FB_RIVA is not set
>> # CONFIG_FB_I740 is not set
>> # CONFIG_FB_LE80578 is not set
>> # CONFIG_FB_MATROX is not set
>> # CONFIG_FB_RADEON is not set
>> # CONFIG_FB_ATY128 is not set
>> # CONFIG_FB_ATY is not set
>> # CONFIG_FB_S3 is not set
>> # CONFIG_FB_SAVAGE is not set
>> # CONFIG_FB_SIS is not set
>> # CONFIG_FB_VIA is not set
>> # CONFIG_FB_NEOMAGIC is not set
>> # CONFIG_FB_KYRO is not set
>> # CONFIG_FB_3DFX is not set
>> # CONFIG_FB_VOODOO1 is not set
>> # CONFIG_FB_VT8623 is not set
>> # CONFIG_FB_TRIDENT is not set
>> # CONFIG_FB_ARK is not set
>> # CONFIG_FB_PM3 is not set
>> # CONFIG_FB_CARMINE is not set
>> # CONFIG_FB_SM501 is not set
>> # CONFIG_FB_SMSCUFX is not set
>> # CONFIG_FB_UDL is not set
>> # CONFIG_FB_IBM_GXT4500 is not set
>> # CONFIG_FB_VIRTUAL is not set
>> # CONFIG_FB_METRONOME is not set
>> # CONFIG_FB_MB862XX is not set
>> # CONFIG_FB_SIMPLE is not set
>> # CONFIG_FB_SSD1307 is not set
>> # CONFIG_FB_SM712 is not set
>> # end of Frame buffer Devices
>>
>> #
>> # Backlight & LCD device support
>> #
>> CONFIG_LCD_CLASS_DEVICE=m
>> # CONFIG_LCD_L4F00242T03 is not set
>> # CONFIG_LCD_LMS283GF05 is not set
>> # CONFIG_LCD_LTV350QV is not set
>> # CONFIG_LCD_ILI922X is not set
>> # CONFIG_LCD_ILI9320 is not set
>> # CONFIG_LCD_TDO24M is not set
>> # CONFIG_LCD_VGG2432A4 is not set
>> CONFIG_LCD_PLATFORM=m
>> # CONFIG_LCD_AMS369FG06 is not set
>> # CONFIG_LCD_LMS501KF03 is not set
>> # CONFIG_LCD_HX8357 is not set
>> # CONFIG_LCD_OTM3225A is not set
>> CONFIG_BACKLIGHT_CLASS_DEVICE=y
>> # CONFIG_BACKLIGHT_KTD253 is not set
>> # CONFIG_BACKLIGHT_PWM is not set
>> CONFIG_BACKLIGHT_APPLE=m
>> # CONFIG_BACKLIGHT_QCOM_WLED is not set
>> # CONFIG_BACKLIGHT_SAHARA is not set
>> # CONFIG_BACKLIGHT_ADP8860 is not set
>> # CONFIG_BACKLIGHT_ADP8870 is not set
>> # CONFIG_BACKLIGHT_LM3630A is not set
>> # CONFIG_BACKLIGHT_LM3639 is not set
>> CONFIG_BACKLIGHT_LP855X=m
>> # CONFIG_BACKLIGHT_GPIO is not set
>> # CONFIG_BACKLIGHT_LV5207LP is not set
>> # CONFIG_BACKLIGHT_BD6107 is not set
>> # CONFIG_BACKLIGHT_ARCXCNN is not set
>> # end of Backlight & LCD device support
>>
>> CONFIG_HDMI=y
>>
>> #
>> # Console display driver support
>> #
>> CONFIG_VGA_CONSOLE=y
>> CONFIG_DUMMY_CONSOLE=y
>> CONFIG_DUMMY_CONSOLE_COLUMNS=80
>> CONFIG_DUMMY_CONSOLE_ROWS=25
>> CONFIG_FRAMEBUFFER_CONSOLE=y
>> # CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
>> CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
>> CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
>> # CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
>> # end of Console display driver support
>>
>> CONFIG_LOGO=y
>> # CONFIG_LOGO_LINUX_MONO is not set
>> # CONFIG_LOGO_LINUX_VGA16 is not set
>> CONFIG_LOGO_LINUX_CLUT224=y
>> # end of Graphics support
>>
>> # CONFIG_SOUND is not set
>>
>> #
>> # HID support
>> #
>> CONFIG_HID=y
>> CONFIG_HID_BATTERY_STRENGTH=y
>> CONFIG_HIDRAW=y
>> CONFIG_UHID=m
>> CONFIG_HID_GENERIC=y
>>
>> #
>> # Special HID drivers
>> #
>> CONFIG_HID_A4TECH=m
>> # CONFIG_HID_ACCUTOUCH is not set
>> CONFIG_HID_ACRUX=m
>> # CONFIG_HID_ACRUX_FF is not set
>> CONFIG_HID_APPLE=m
>> # CONFIG_HID_APPLEIR is not set
>> CONFIG_HID_ASUS=m
>> CONFIG_HID_AUREAL=m
>> CONFIG_HID_BELKIN=m
>> # CONFIG_HID_BETOP_FF is not set
>> # CONFIG_HID_BIGBEN_FF is not set
>> CONFIG_HID_CHERRY=m
>> # CONFIG_HID_CHICONY is not set
>> # CONFIG_HID_CORSAIR is not set
>> # CONFIG_HID_COUGAR is not set
>> # CONFIG_HID_MACALLY is not set
>> CONFIG_HID_CMEDIA=m
>> # CONFIG_HID_CP2112 is not set
>> # CONFIG_HID_CREATIVE_SB0540 is not set
>> CONFIG_HID_CYPRESS=m
>> CONFIG_HID_DRAGONRISE=m
>> # CONFIG_DRAGONRISE_FF is not set
>> # CONFIG_HID_EMS_FF is not set
>> # CONFIG_HID_ELAN is not set
>> CONFIG_HID_ELECOM=m
>> # CONFIG_HID_ELO is not set
>> CONFIG_HID_EZKEY=m
>> # CONFIG_HID_FT260 is not set
>> CONFIG_HID_GEMBIRD=m
>> CONFIG_HID_GFRM=m
>> # CONFIG_HID_GLORIOUS is not set
>> # CONFIG_HID_HOLTEK is not set
>> # CONFIG_HID_VIVALDI is not set
>> # CONFIG_HID_GT683R is not set
>> CONFIG_HID_KEYTOUCH=m
>> CONFIG_HID_KYE=m
>> # CONFIG_HID_UCLOGIC is not set
>> CONFIG_HID_WALTOP=m
>> # CONFIG_HID_VIEWSONIC is not set
>> # CONFIG_HID_XIAOMI is not set
>> CONFIG_HID_GYRATION=m
>> CONFIG_HID_ICADE=m
>> CONFIG_HID_ITE=m
>> CONFIG_HID_JABRA=m
>> CONFIG_HID_TWINHAN=m
>> CONFIG_HID_KENSINGTON=m
>> CONFIG_HID_LCPOWER=m
>> CONFIG_HID_LED=m
>> CONFIG_HID_LENOVO=m
>> # CONFIG_HID_LETSKETCH is not set
>> CONFIG_HID_LOGITECH=m
>> CONFIG_HID_LOGITECH_DJ=m
>> CONFIG_HID_LOGITECH_HIDPP=m
>> # CONFIG_LOGITECH_FF is not set
>> # CONFIG_LOGIRUMBLEPAD2_FF is not set
>> # CONFIG_LOGIG940_FF is not set
>> # CONFIG_LOGIWHEELS_FF is not set
>> CONFIG_HID_MAGICMOUSE=y
>> # CONFIG_HID_MALTRON is not set
>> # CONFIG_HID_MAYFLASH is not set
>> # CONFIG_HID_REDRAGON is not set
>> CONFIG_HID_MICROSOFT=m
>> CONFIG_HID_MONTEREY=m
>> CONFIG_HID_MULTITOUCH=m
>> # CONFIG_HID_NINTENDO is not set
>> CONFIG_HID_NTI=m
>> # CONFIG_HID_NTRIG is not set
>> CONFIG_HID_ORTEK=m
>> CONFIG_HID_PANTHERLORD=m
>> # CONFIG_PANTHERLORD_FF is not set
>> # CONFIG_HID_PENMOUNT is not set
>> CONFIG_HID_PETALYNX=m
>> CONFIG_HID_PICOLCD=m
>> CONFIG_HID_PICOLCD_FB=y
>> CONFIG_HID_PICOLCD_BACKLIGHT=y
>> CONFIG_HID_PICOLCD_LCD=y
>> CONFIG_HID_PICOLCD_LEDS=y
>> CONFIG_HID_PICOLCD_CIR=y
>> CONFIG_HID_PLANTRONICS=m
>> CONFIG_HID_PRIMAX=m
>> # CONFIG_HID_RETRODE is not set
>> # CONFIG_HID_ROCCAT is not set
>> CONFIG_HID_SAITEK=m
>> CONFIG_HID_SAMSUNG=m
>> # CONFIG_HID_SEMITEK is not set
>> # CONFIG_HID_SONY is not set
>> CONFIG_HID_SPEEDLINK=m
>> # CONFIG_HID_STEAM is not set
>> CONFIG_HID_STEELSERIES=m
>> CONFIG_HID_SUNPLUS=m
>> CONFIG_HID_RMI=m
>> CONFIG_HID_GREENASIA=m
>> # CONFIG_GREENASIA_FF is not set
>> CONFIG_HID_SMARTJOYPLUS=m
>> # CONFIG_SMARTJOYPLUS_FF is not set
>> CONFIG_HID_TIVO=m
>> CONFIG_HID_TOPSEED=m
>> CONFIG_HID_THINGM=m
>> CONFIG_HID_THRUSTMASTER=m
>> # CONFIG_THRUSTMASTER_FF is not set
>> # CONFIG_HID_UDRAW_PS3 is not set
>> # CONFIG_HID_U2FZERO is not set
>> # CONFIG_HID_WACOM is not set
>> CONFIG_HID_WIIMOTE=m
>> CONFIG_HID_XINMO=m
>> CONFIG_HID_ZEROPLUS=m
>> # CONFIG_ZEROPLUS_FF is not set
>> CONFIG_HID_ZYDACRON=m
>> CONFIG_HID_SENSOR_HUB=y
>> CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
>> CONFIG_HID_ALPS=m
>> # CONFIG_HID_MCP2221 is not set
>> # end of Special HID drivers
>>
>> #
>> # USB HID support
>> #
>> CONFIG_USB_HID=y
>> # CONFIG_HID_PID is not set
>> # CONFIG_USB_HIDDEV is not set
>> # end of USB HID support
>>
>> #
>> # I2C HID support
>> #
>> # CONFIG_I2C_HID_ACPI is not set
>> # end of I2C HID support
>>
>> #
>> # Intel ISH HID support
>> #
>> CONFIG_INTEL_ISH_HID=m
>> # CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
>> # end of Intel ISH HID support
>>
>> #
>> # AMD SFH HID Support
>> #
>> # CONFIG_AMD_SFH_HID is not set
>> # end of AMD SFH HID Support
>> # end of HID support
>>
>> CONFIG_USB_OHCI_LITTLE_ENDIAN=y
>> CONFIG_USB_SUPPORT=y
>> CONFIG_USB_COMMON=y
>> # CONFIG_USB_LED_TRIG is not set
>> # CONFIG_USB_ULPI_BUS is not set
>> # CONFIG_USB_CONN_GPIO is not set
>> CONFIG_USB_ARCH_HAS_HCD=y
>> CONFIG_USB=y
>> CONFIG_USB_PCI=y
>> CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
>>
>> #
>> # Miscellaneous USB options
>> #
>> CONFIG_USB_DEFAULT_PERSIST=y
>> # CONFIG_USB_FEW_INIT_RETRIES is not set
>> # CONFIG_USB_DYNAMIC_MINORS is not set
>> # CONFIG_USB_OTG is not set
>> # CONFIG_USB_OTG_PRODUCTLIST is not set
>> CONFIG_USB_LEDS_TRIGGER_USBPORT=y
>> CONFIG_USB_AUTOSUSPEND_DELAY=2
>> CONFIG_USB_MON=y
>>
>> #
>> # USB Host Controller Drivers
>> #
>> # CONFIG_USB_C67X00_HCD is not set
>> CONFIG_USB_XHCI_HCD=y
>> # CONFIG_USB_XHCI_DBGCAP is not set
>> CONFIG_USB_XHCI_PCI=y
>> # CONFIG_USB_XHCI_PCI_RENESAS is not set
>> # CONFIG_USB_XHCI_PLATFORM is not set
>> CONFIG_USB_EHCI_HCD=y
>> CONFIG_USB_EHCI_ROOT_HUB_TT=y
>> CONFIG_USB_EHCI_TT_NEWSCHED=y
>> CONFIG_USB_EHCI_PCI=y
>> # CONFIG_USB_EHCI_FSL is not set
>> # CONFIG_USB_EHCI_HCD_PLATFORM is not set
>> # CONFIG_USB_OXU210HP_HCD is not set
>> # CONFIG_USB_ISP116X_HCD is not set
>> # CONFIG_USB_FOTG210_HCD is not set
>> # CONFIG_USB_MAX3421_HCD is not set
>> CONFIG_USB_OHCI_HCD=y
>> CONFIG_USB_OHCI_HCD_PCI=y
>> # CONFIG_USB_OHCI_HCD_PLATFORM is not set
>> CONFIG_USB_UHCI_HCD=y
>> # CONFIG_USB_SL811_HCD is not set
>> # CONFIG_USB_R8A66597_HCD is not set
>> # CONFIG_USB_HCD_BCMA is not set
>> # CONFIG_USB_HCD_TEST_MODE is not set
>>
>> #
>> # USB Device Class drivers
>> #
>> # CONFIG_USB_ACM is not set
>> # CONFIG_USB_PRINTER is not set
>> # CONFIG_USB_WDM is not set
>> # CONFIG_USB_TMC is not set
>>
>> #
>> # NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
>> #
>>
>> #
>> # also be needed; see USB_STORAGE Help for more info
>> #
>> CONFIG_USB_STORAGE=m
>> # CONFIG_USB_STORAGE_DEBUG is not set
>> # CONFIG_USB_STORAGE_REALTEK is not set
>> # CONFIG_USB_STORAGE_DATAFAB is not set
>> # CONFIG_USB_STORAGE_FREECOM is not set
>> # CONFIG_USB_STORAGE_ISD200 is not set
>> # CONFIG_USB_STORAGE_USBAT is not set
>> # CONFIG_USB_STORAGE_SDDR09 is not set
>> # CONFIG_USB_STORAGE_SDDR55 is not set
>> # CONFIG_USB_STORAGE_JUMPSHOT is not set
>> # CONFIG_USB_STORAGE_ALAUDA is not set
>> # CONFIG_USB_STORAGE_ONETOUCH is not set
>> # CONFIG_USB_STORAGE_KARMA is not set
>> # CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
>> # CONFIG_USB_STORAGE_ENE_UB6250 is not set
>> # CONFIG_USB_UAS is not set
>>
>> #
>> # USB Imaging devices
>> #
>> # CONFIG_USB_MDC800 is not set
>> # CONFIG_USB_MICROTEK is not set
>> # CONFIG_USBIP_CORE is not set
>> # CONFIG_USB_CDNS_SUPPORT is not set
>> # CONFIG_USB_MUSB_HDRC is not set
>> # CONFIG_USB_DWC3 is not set
>> # CONFIG_USB_DWC2 is not set
>> # CONFIG_USB_CHIPIDEA is not set
>> # CONFIG_USB_ISP1760 is not set
>>
>> #
>> # USB port drivers
>> #
>> # CONFIG_USB_USS720 is not set
>> CONFIG_USB_SERIAL=m
>> CONFIG_USB_SERIAL_GENERIC=y
>> # CONFIG_USB_SERIAL_SIMPLE is not set
>> # CONFIG_USB_SERIAL_AIRCABLE is not set
>> # CONFIG_USB_SERIAL_ARK3116 is not set
>> # CONFIG_USB_SERIAL_BELKIN is not set
>> # CONFIG_USB_SERIAL_CH341 is not set
>> # CONFIG_USB_SERIAL_WHITEHEAT is not set
>> # CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
>> # CONFIG_USB_SERIAL_CP210X is not set
>> # CONFIG_USB_SERIAL_CYPRESS_M8 is not set
>> # CONFIG_USB_SERIAL_EMPEG is not set
>> # CONFIG_USB_SERIAL_FTDI_SIO is not set
>> # CONFIG_USB_SERIAL_VISOR is not set
>> # CONFIG_USB_SERIAL_IPAQ is not set
>> # CONFIG_USB_SERIAL_IR is not set
>> # CONFIG_USB_SERIAL_EDGEPORT is not set
>> # CONFIG_USB_SERIAL_EDGEPORT_TI is not set
>> # CONFIG_USB_SERIAL_F81232 is not set
>> # CONFIG_USB_SERIAL_F8153X is not set
>> # CONFIG_USB_SERIAL_GARMIN is not set
>> # CONFIG_USB_SERIAL_IPW is not set
>> # CONFIG_USB_SERIAL_IUU is not set
>> # CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
>> # CONFIG_USB_SERIAL_KEYSPAN is not set
>> # CONFIG_USB_SERIAL_KLSI is not set
>> # CONFIG_USB_SERIAL_KOBIL_SCT is not set
>> # CONFIG_USB_SERIAL_MCT_U232 is not set
>> # CONFIG_USB_SERIAL_METRO is not set
>> # CONFIG_USB_SERIAL_MOS7720 is not set
>> # CONFIG_USB_SERIAL_MOS7840 is not set
>> # CONFIG_USB_SERIAL_MXUPORT is not set
>> # CONFIG_USB_SERIAL_NAVMAN is not set
>> # CONFIG_USB_SERIAL_PL2303 is not set
>> # CONFIG_USB_SERIAL_OTI6858 is not set
>> # CONFIG_USB_SERIAL_QCAUX is not set
>> # CONFIG_USB_SERIAL_QUALCOMM is not set
>> # CONFIG_USB_SERIAL_SPCP8X5 is not set
>> # CONFIG_USB_SERIAL_SAFE is not set
>> # CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
>> # CONFIG_USB_SERIAL_SYMBOL is not set
>> # CONFIG_USB_SERIAL_TI is not set
>> # CONFIG_USB_SERIAL_CYBERJACK is not set
>> # CONFIG_USB_SERIAL_OPTION is not set
>> # CONFIG_USB_SERIAL_OMNINET is not set
>> # CONFIG_USB_SERIAL_OPTICON is not set
>> # CONFIG_USB_SERIAL_XSENS_MT is not set
>> # CONFIG_USB_SERIAL_WISHBONE is not set
>> # CONFIG_USB_SERIAL_SSU100 is not set
>> # CONFIG_USB_SERIAL_QT2 is not set
>> # CONFIG_USB_SERIAL_UPD78F0730 is not set
>> # CONFIG_USB_SERIAL_XR is not set
>> CONFIG_USB_SERIAL_DEBUG=m
>>
>> #
>> # USB Miscellaneous drivers
>> #
>> # CONFIG_USB_EMI62 is not set
>> # CONFIG_USB_EMI26 is not set
>> # CONFIG_USB_ADUTUX is not set
>> # CONFIG_USB_SEVSEG is not set
>> # CONFIG_USB_LEGOTOWER is not set
>> # CONFIG_USB_LCD is not set
>> # CONFIG_USB_CYPRESS_CY7C63 is not set
>> # CONFIG_USB_CYTHERM is not set
>> # CONFIG_USB_IDMOUSE is not set
>> # CONFIG_USB_FTDI_ELAN is not set
>> # CONFIG_USB_APPLEDISPLAY is not set
>> # CONFIG_APPLE_MFI_FASTCHARGE is not set
>> # CONFIG_USB_SISUSBVGA is not set
>> # CONFIG_USB_LD is not set
>> # CONFIG_USB_TRANCEVIBRATOR is not set
>> # CONFIG_USB_IOWARRIOR is not set
>> # CONFIG_USB_TEST is not set
>> # CONFIG_USB_EHSET_TEST_FIXTURE is not set
>> # CONFIG_USB_ISIGHTFW is not set
>> # CONFIG_USB_YUREX is not set
>> # CONFIG_USB_EZUSB_FX2 is not set
>> # CONFIG_USB_HUB_USB251XB is not set
>> # CONFIG_USB_HSIC_USB3503 is not set
>> # CONFIG_USB_HSIC_USB4604 is not set
>> # CONFIG_USB_LINK_LAYER_TEST is not set
>> # CONFIG_USB_CHAOSKEY is not set
>> # CONFIG_USB_ATM is not set
>>
>> #
>> # USB Physical Layer drivers
>> #
>> # CONFIG_NOP_USB_XCEIV is not set
>> # CONFIG_USB_GPIO_VBUS is not set
>> # CONFIG_USB_ISP1301 is not set
>> # end of USB Physical Layer drivers
>>
>> # CONFIG_USB_GADGET is not set
>> CONFIG_TYPEC=y
>> # CONFIG_TYPEC_TCPM is not set
>> CONFIG_TYPEC_UCSI=y
>> # CONFIG_UCSI_CCG is not set
>> CONFIG_UCSI_ACPI=y
>> # CONFIG_TYPEC_TPS6598X is not set
>> # CONFIG_TYPEC_STUSB160X is not set
>>
>> #
>> # USB Type-C Multiplexer/DeMultiplexer Switch support
>> #
>> # CONFIG_TYPEC_MUX_PI3USB30532 is not set
>> # end of USB Type-C Multiplexer/DeMultiplexer Switch support
>>
>> #
>> # USB Type-C Alternate Mode drivers
>> #
>> # CONFIG_TYPEC_DP_ALTMODE is not set
>> # end of USB Type-C Alternate Mode drivers
>>
>> # CONFIG_USB_ROLE_SWITCH is not set
>> CONFIG_MMC=m
>> CONFIG_MMC_BLOCK=m
>> CONFIG_MMC_BLOCK_MINORS=8
>> CONFIG_SDIO_UART=m
>> # CONFIG_MMC_TEST is not set
>>
>> #
>> # MMC/SD/SDIO Host Controller Drivers
>> #
>> # CONFIG_MMC_DEBUG is not set
>> CONFIG_MMC_SDHCI=m
>> CONFIG_MMC_SDHCI_IO_ACCESSORS=y
>> CONFIG_MMC_SDHCI_PCI=m
>> CONFIG_MMC_RICOH_MMC=y
>> CONFIG_MMC_SDHCI_ACPI=m
>> CONFIG_MMC_SDHCI_PLTFM=m
>> # CONFIG_MMC_SDHCI_F_SDH30 is not set
>> # CONFIG_MMC_WBSD is not set
>> # CONFIG_MMC_TIFM_SD is not set
>> # CONFIG_MMC_SPI is not set
>> # CONFIG_MMC_CB710 is not set
>> # CONFIG_MMC_VIA_SDMMC is not set
>> # CONFIG_MMC_VUB300 is not set
>> # CONFIG_MMC_USHC is not set
>> # CONFIG_MMC_USDHI6ROL0 is not set
>> # CONFIG_MMC_REALTEK_PCI is not set
>> CONFIG_MMC_CQHCI=m
>> # CONFIG_MMC_HSQ is not set
>> # CONFIG_MMC_TOSHIBA_PCI is not set
>> # CONFIG_MMC_MTK is not set
>> # CONFIG_MMC_SDHCI_XENON is not set
>> # CONFIG_MEMSTICK is not set
>> CONFIG_NEW_LEDS=y
>> CONFIG_LEDS_CLASS=y
>> # CONFIG_LEDS_CLASS_FLASH is not set
>> # CONFIG_LEDS_CLASS_MULTICOLOR is not set
>> # CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set
>>
>> #
>> # LED drivers
>> #
>> # CONFIG_LEDS_APU is not set
>> CONFIG_LEDS_LM3530=m
>> # CONFIG_LEDS_LM3532 is not set
>> # CONFIG_LEDS_LM3642 is not set
>> # CONFIG_LEDS_PCA9532 is not set
>> # CONFIG_LEDS_GPIO is not set
>> CONFIG_LEDS_LP3944=m
>> # CONFIG_LEDS_LP3952 is not set
>> # CONFIG_LEDS_LP50XX is not set
>> CONFIG_LEDS_CLEVO_MAIL=m
>> # CONFIG_LEDS_PCA955X is not set
>> # CONFIG_LEDS_PCA963X is not set
>> # CONFIG_LEDS_DAC124S085 is not set
>> # CONFIG_LEDS_PWM is not set
>> # CONFIG_LEDS_BD2802 is not set
>> CONFIG_LEDS_INTEL_SS4200=m
>> CONFIG_LEDS_LT3593=m
>> # CONFIG_LEDS_TCA6507 is not set
>> # CONFIG_LEDS_TLC591XX is not set
>> # CONFIG_LEDS_LM355x is not set
>>
>> #
>> # LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
>> #
>> CONFIG_LEDS_BLINKM=m
>> CONFIG_LEDS_MLXCPLD=m
>> # CONFIG_LEDS_MLXREG is not set
>> # CONFIG_LEDS_USER is not set
>> # CONFIG_LEDS_NIC78BX is not set
>> # CONFIG_LEDS_TI_LMU_COMMON is not set
>>
>> #
>> # Flash and Torch LED drivers
>> #
>>
>> #
>> # LED Triggers
>> #
>> CONFIG_LEDS_TRIGGERS=y
>> CONFIG_LEDS_TRIGGER_TIMER=m
>> CONFIG_LEDS_TRIGGER_ONESHOT=m
>> # CONFIG_LEDS_TRIGGER_DISK is not set
>> CONFIG_LEDS_TRIGGER_HEARTBEAT=m
>> CONFIG_LEDS_TRIGGER_BACKLIGHT=m
>> # CONFIG_LEDS_TRIGGER_CPU is not set
>> # CONFIG_LEDS_TRIGGER_ACTIVITY is not set
>> CONFIG_LEDS_TRIGGER_GPIO=m
>> CONFIG_LEDS_TRIGGER_DEFAULT_ON=m
>>
>> #
>> # iptables trigger is under Netfilter config (LED target)
>> #
>> CONFIG_LEDS_TRIGGER_TRANSIENT=m
>> CONFIG_LEDS_TRIGGER_CAMERA=m
>> # CONFIG_LEDS_TRIGGER_PANIC is not set
>> # CONFIG_LEDS_TRIGGER_NETDEV is not set
>> # CONFIG_LEDS_TRIGGER_PATTERN is not set
>> CONFIG_LEDS_TRIGGER_AUDIO=m
>> # CONFIG_LEDS_TRIGGER_TTY is not set
>>
>> #
>> # Simple LED drivers
>> #
>> # CONFIG_ACCESSIBILITY is not set
>> # CONFIG_INFINIBAND is not set
>> CONFIG_EDAC_ATOMIC_SCRUB=y
>> CONFIG_EDAC_SUPPORT=y
>> CONFIG_EDAC=y
>> CONFIG_EDAC_LEGACY_SYSFS=y
>> # CONFIG_EDAC_DEBUG is not set
>> CONFIG_EDAC_GHES=y
>> CONFIG_EDAC_E752X=m
>> CONFIG_EDAC_I82975X=m
>> CONFIG_EDAC_I3000=m
>> CONFIG_EDAC_I3200=m
>> CONFIG_EDAC_IE31200=m
>> CONFIG_EDAC_X38=m
>> CONFIG_EDAC_I5400=m
>> CONFIG_EDAC_I7CORE=m
>> CONFIG_EDAC_I5000=m
>> CONFIG_EDAC_I5100=m
>> CONFIG_EDAC_I7300=m
>> CONFIG_EDAC_SBRIDGE=m
>> CONFIG_EDAC_SKX=m
>> # CONFIG_EDAC_I10NM is not set
>> CONFIG_EDAC_PND2=m
>> # CONFIG_EDAC_IGEN6 is not set
>> CONFIG_RTC_LIB=y
>> CONFIG_RTC_MC146818_LIB=y
>> CONFIG_RTC_CLASS=y
>> CONFIG_RTC_HCTOSYS=y
>> CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
>> # CONFIG_RTC_SYSTOHC is not set
>> # CONFIG_RTC_DEBUG is not set
>> CONFIG_RTC_NVMEM=y
>>
>> #
>> # RTC interfaces
>> #
>> CONFIG_RTC_INTF_SYSFS=y
>> CONFIG_RTC_INTF_PROC=y
>> CONFIG_RTC_INTF_DEV=y
>> # CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
>> # CONFIG_RTC_DRV_TEST is not set
>>
>> #
>> # I2C RTC drivers
>> #
>> # CONFIG_RTC_DRV_ABB5ZES3 is not set
>> # CONFIG_RTC_DRV_ABEOZ9 is not set
>> # CONFIG_RTC_DRV_ABX80X is not set
>> CONFIG_RTC_DRV_DS1307=m
>> # CONFIG_RTC_DRV_DS1307_CENTURY is not set
>> CONFIG_RTC_DRV_DS1374=m
>> # CONFIG_RTC_DRV_DS1374_WDT is not set
>> CONFIG_RTC_DRV_DS1672=m
>> CONFIG_RTC_DRV_MAX6900=m
>> CONFIG_RTC_DRV_RS5C372=m
>> CONFIG_RTC_DRV_ISL1208=m
>> CONFIG_RTC_DRV_ISL12022=m
>> CONFIG_RTC_DRV_X1205=m
>> CONFIG_RTC_DRV_PCF8523=m
>> # CONFIG_RTC_DRV_PCF85063 is not set
>> # CONFIG_RTC_DRV_PCF85363 is not set
>> CONFIG_RTC_DRV_PCF8563=m
>> CONFIG_RTC_DRV_PCF8583=m
>> CONFIG_RTC_DRV_M41T80=m
>> CONFIG_RTC_DRV_M41T80_WDT=y
>> CONFIG_RTC_DRV_BQ32K=m
>> # CONFIG_RTC_DRV_S35390A is not set
>> CONFIG_RTC_DRV_FM3130=m
>> # CONFIG_RTC_DRV_RX8010 is not set
>> CONFIG_RTC_DRV_RX8581=m
>> CONFIG_RTC_DRV_RX8025=m
>> CONFIG_RTC_DRV_EM3027=m
>> # CONFIG_RTC_DRV_RV3028 is not set
>> # CONFIG_RTC_DRV_RV3032 is not set
>> # CONFIG_RTC_DRV_RV8803 is not set
>> # CONFIG_RTC_DRV_SD3078 is not set
>>
>> #
>> # SPI RTC drivers
>> #
>> # CONFIG_RTC_DRV_M41T93 is not set
>> # CONFIG_RTC_DRV_M41T94 is not set
>> # CONFIG_RTC_DRV_DS1302 is not set
>> # CONFIG_RTC_DRV_DS1305 is not set
>> # CONFIG_RTC_DRV_DS1343 is not set
>> # CONFIG_RTC_DRV_DS1347 is not set
>> # CONFIG_RTC_DRV_DS1390 is not set
>> # CONFIG_RTC_DRV_MAX6916 is not set
>> # CONFIG_RTC_DRV_R9701 is not set
>> CONFIG_RTC_DRV_RX4581=m
>> # CONFIG_RTC_DRV_RS5C348 is not set
>> # CONFIG_RTC_DRV_MAX6902 is not set
>> # CONFIG_RTC_DRV_PCF2123 is not set
>> # CONFIG_RTC_DRV_MCP795 is not set
>> CONFIG_RTC_I2C_AND_SPI=y
>>
>> #
>> # SPI and I2C RTC drivers
>> #
>> CONFIG_RTC_DRV_DS3232=m
>> CONFIG_RTC_DRV_DS3232_HWMON=y
>> # CONFIG_RTC_DRV_PCF2127 is not set
>> CONFIG_RTC_DRV_RV3029C2=m
>> # CONFIG_RTC_DRV_RV3029_HWMON is not set
>> # CONFIG_RTC_DRV_RX6110 is not set
>>
>> #
>> # Platform RTC drivers
>> #
>> CONFIG_RTC_DRV_CMOS=y
>> CONFIG_RTC_DRV_DS1286=m
>> CONFIG_RTC_DRV_DS1511=m
>> CONFIG_RTC_DRV_DS1553=m
>> # CONFIG_RTC_DRV_DS1685_FAMILY is not set
>> CONFIG_RTC_DRV_DS1742=m
>> CONFIG_RTC_DRV_DS2404=m
>> CONFIG_RTC_DRV_STK17TA8=m
>> # CONFIG_RTC_DRV_M48T86 is not set
>> CONFIG_RTC_DRV_M48T35=m
>> CONFIG_RTC_DRV_M48T59=m
>> CONFIG_RTC_DRV_MSM6242=m
>> CONFIG_RTC_DRV_BQ4802=m
>> CONFIG_RTC_DRV_RP5C01=m
>> CONFIG_RTC_DRV_V3020=m
>>
>> #
>> # on-CPU RTC drivers
>> #
>> # CONFIG_RTC_DRV_FTRTC010 is not set
>>
>> #
>> # HID Sensor RTC drivers
>> #
>> # CONFIG_RTC_DRV_GOLDFISH is not set
>> CONFIG_DMADEVICES=y
>> # CONFIG_DMADEVICES_DEBUG is not set
>>
>> #
>> # DMA Devices
>> #
>> CONFIG_DMA_ENGINE=y
>> CONFIG_DMA_VIRTUAL_CHANNELS=y
>> CONFIG_DMA_ACPI=y
>> # CONFIG_ALTERA_MSGDMA is not set
>> CONFIG_INTEL_IDMA64=m
>> # CONFIG_INTEL_IDXD is not set
>> # CONFIG_INTEL_IDXD_COMPAT is not set
>> CONFIG_INTEL_IOATDMA=m
>> # CONFIG_PLX_DMA is not set
>> # CONFIG_AMD_PTDMA is not set
>> # CONFIG_QCOM_HIDMA_MGMT is not set
>> # CONFIG_QCOM_HIDMA is not set
>> CONFIG_DW_DMAC_CORE=y
>> CONFIG_DW_DMAC=m
>> CONFIG_DW_DMAC_PCI=y
>> # CONFIG_DW_EDMA is not set
>> # CONFIG_DW_EDMA_PCIE is not set
>> CONFIG_HSU_DMA=y
>> # CONFIG_SF_PDMA is not set
>> # CONFIG_INTEL_LDMA is not set
>>
>> #
>> # DMA Clients
>> #
>> CONFIG_ASYNC_TX_DMA=y
>> CONFIG_DMATEST=m
>> CONFIG_DMA_ENGINE_RAID=y
>>
>> #
>> # DMABUF options
>> #
>> CONFIG_SYNC_FILE=y
>> # CONFIG_SW_SYNC is not set
>> # CONFIG_UDMABUF is not set
>> # CONFIG_DMABUF_MOVE_NOTIFY is not set
>> # CONFIG_DMABUF_DEBUG is not set
>> # CONFIG_DMABUF_SELFTESTS is not set
>> # CONFIG_DMABUF_HEAPS is not set
>> # CONFIG_DMABUF_SYSFS_STATS is not set
>> # end of DMABUF options
>>
>> CONFIG_DCA=m
>> # CONFIG_AUXDISPLAY is not set
>> # CONFIG_PANEL is not set
>> CONFIG_UIO=m
>> CONFIG_UIO_CIF=m
>> CONFIG_UIO_PDRV_GENIRQ=m
>> # CONFIG_UIO_DMEM_GENIRQ is not set
>> CONFIG_UIO_AEC=m
>> CONFIG_UIO_SERCOS3=m
>> CONFIG_UIO_PCI_GENERIC=m
>> # CONFIG_UIO_NETX is not set
>> # CONFIG_UIO_PRUSS is not set
>> # CONFIG_UIO_MF624 is not set
>> CONFIG_VFIO=m
>> CONFIG_VFIO_IOMMU_TYPE1=m
>> CONFIG_VFIO_VIRQFD=m
>> CONFIG_VFIO_NOIOMMU=y
>> CONFIG_VFIO_PCI_CORE=m
>> CONFIG_VFIO_PCI_MMAP=y
>> CONFIG_VFIO_PCI_INTX=y
>> CONFIG_VFIO_PCI=m
>> # CONFIG_VFIO_PCI_VGA is not set
>> # CONFIG_VFIO_PCI_IGD is not set
>> CONFIG_VFIO_MDEV=m
>> CONFIG_IRQ_BYPASS_MANAGER=m
>> # CONFIG_VIRT_DRIVERS is not set
>> CONFIG_VIRTIO=y
>> CONFIG_VIRTIO_PCI_LIB=y
>> CONFIG_VIRTIO_PCI_LIB_LEGACY=y
>> CONFIG_VIRTIO_MENU=y
>> CONFIG_VIRTIO_PCI=y
>> CONFIG_VIRTIO_PCI_LEGACY=y
>> # CONFIG_VIRTIO_PMEM is not set
>> CONFIG_VIRTIO_BALLOON=m
>> CONFIG_VIRTIO_MEM=m
>> CONFIG_VIRTIO_INPUT=m
>> # CONFIG_VIRTIO_MMIO is not set
>> CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
>> # CONFIG_VDPA is not set
>> CONFIG_VHOST_IOTLB=m
>> CONFIG_VHOST=m
>> CONFIG_VHOST_MENU=y
>> CONFIG_VHOST_NET=m
>> # CONFIG_VHOST_SCSI is not set
>> CONFIG_VHOST_VSOCK=m
>> # CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set
>>
>> #
>> # Microsoft Hyper-V guest support
>> #
>> # CONFIG_HYPERV is not set
>> # end of Microsoft Hyper-V guest support
>>
>> # CONFIG_GREYBUS is not set
>> # CONFIG_COMEDI is not set
>> # CONFIG_STAGING is not set
>> CONFIG_X86_PLATFORM_DEVICES=y
>> CONFIG_ACPI_WMI=m
>> CONFIG_WMI_BMOF=m
>> # CONFIG_HUAWEI_WMI is not set
>> # CONFIG_UV_SYSFS is not set
>> CONFIG_MXM_WMI=m
>> # CONFIG_PEAQ_WMI is not set
>> # CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
>> # CONFIG_XIAOMI_WMI is not set
>> # CONFIG_GIGABYTE_WMI is not set
>> # CONFIG_YOGABOOK_WMI is not set
>> CONFIG_ACERHDF=m
>> # CONFIG_ACER_WIRELESS is not set
>> CONFIG_ACER_WMI=m
>> # CONFIG_AMD_PMC is not set
>> # CONFIG_ADV_SWBUTTON is not set
>> CONFIG_APPLE_GMUX=m
>> CONFIG_ASUS_LAPTOP=m
>> # CONFIG_ASUS_WIRELESS is not set
>> CONFIG_ASUS_WMI=m
>> CONFIG_ASUS_NB_WMI=m
>> # CONFIG_ASUS_TF103C_DOCK is not set
>> # CONFIG_MERAKI_MX100 is not set
>> CONFIG_EEEPC_LAPTOP=m
>> CONFIG_EEEPC_WMI=m
>> # CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
>> CONFIG_AMILO_RFKILL=m
>> CONFIG_FUJITSU_LAPTOP=m
>> CONFIG_FUJITSU_TABLET=m
>> # CONFIG_GPD_POCKET_FAN is not set
>> CONFIG_HP_ACCEL=m
>> # CONFIG_WIRELESS_HOTKEY is not set
>> CONFIG_HP_WMI=m
>> # CONFIG_IBM_RTL is not set
>> CONFIG_IDEAPAD_LAPTOP=m
>> CONFIG_SENSORS_HDAPS=m
>> CONFIG_THINKPAD_ACPI=m
>> # CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
>> # CONFIG_THINKPAD_ACPI_DEBUG is not set
>> # CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
>> CONFIG_THINKPAD_ACPI_VIDEO=y
>> CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
>> # CONFIG_THINKPAD_LMI is not set
>> # CONFIG_INTEL_ATOMISP2_PM is not set
>> # CONFIG_INTEL_SAR_INT1092 is not set
>> CONFIG_INTEL_PMC_CORE=m
>>
>> #
>> # Intel Speed Select Technology interface support
>> #
>> # CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
>> # end of Intel Speed Select Technology interface support
>>
>> CONFIG_INTEL_WMI=y
>> # CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
>> CONFIG_INTEL_WMI_THUNDERBOLT=m
>> CONFIG_INTEL_HID_EVENT=m
>> CONFIG_INTEL_VBTN=m
>> # CONFIG_INTEL_INT0002_VGPIO is not set
>> CONFIG_INTEL_OAKTRAIL=m
>> # CONFIG_INTEL_ISHTP_ECLITE is not set
>> # CONFIG_INTEL_PUNIT_IPC is not set
>> CONFIG_INTEL_RST=m
>> # CONFIG_INTEL_SMARTCONNECT is not set
>> CONFIG_INTEL_TURBO_MAX_3=y
>> # CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
>> # CONFIG_INTEL_VSEC is not set
>> CONFIG_MSI_LAPTOP=m
>> CONFIG_MSI_WMI=m
>> # CONFIG_PCENGINES_APU2 is not set
>> # CONFIG_BARCO_P50_GPIO is not set
>> CONFIG_SAMSUNG_LAPTOP=m
>> CONFIG_SAMSUNG_Q10=m
>> CONFIG_TOSHIBA_BT_RFKILL=m
>> # CONFIG_TOSHIBA_HAPS is not set
>> # CONFIG_TOSHIBA_WMI is not set
>> CONFIG_ACPI_CMPC=m
>> CONFIG_COMPAL_LAPTOP=m
>> # CONFIG_LG_LAPTOP is not set
>> CONFIG_PANASONIC_LAPTOP=m
>> CONFIG_SONY_LAPTOP=m
>> CONFIG_SONYPI_COMPAT=y
>> # CONFIG_SYSTEM76_ACPI is not set
>> CONFIG_TOPSTAR_LAPTOP=m
>> # CONFIG_I2C_MULTI_INSTANTIATE is not set
>> CONFIG_MLX_PLATFORM=m
>> CONFIG_INTEL_IPS=m
>> # CONFIG_INTEL_SCU_PCI is not set
>> # CONFIG_INTEL_SCU_PLATFORM is not set
>> # CONFIG_SIEMENS_SIMATIC_IPC is not set
>> CONFIG_PMC_ATOM=y
>> # CONFIG_CHROME_PLATFORMS is not set
>> CONFIG_MELLANOX_PLATFORM=y
>> CONFIG_MLXREG_HOTPLUG=m
>> # CONFIG_MLXREG_IO is not set
>> # CONFIG_MLXREG_LC is not set
>> CONFIG_SURFACE_PLATFORMS=y
>> # CONFIG_SURFACE3_WMI is not set
>> # CONFIG_SURFACE_3_POWER_OPREGION is not set
>> # CONFIG_SURFACE_GPE is not set
>> # CONFIG_SURFACE_HOTPLUG is not set
>> # CONFIG_SURFACE_PRO3_BUTTON is not set
>> CONFIG_HAVE_CLK=y
>> CONFIG_HAVE_CLK_PREPARE=y
>> CONFIG_COMMON_CLK=y
>> # CONFIG_LMK04832 is not set
>> # CONFIG_COMMON_CLK_MAX9485 is not set
>> # CONFIG_COMMON_CLK_SI5341 is not set
>> # CONFIG_COMMON_CLK_SI5351 is not set
>> # CONFIG_COMMON_CLK_SI544 is not set
>> # CONFIG_COMMON_CLK_CDCE706 is not set
>> # CONFIG_COMMON_CLK_CS2000_CP is not set
>> # CONFIG_COMMON_CLK_LAN966X is not set
>> # CONFIG_COMMON_CLK_PWM is not set
>> # CONFIG_XILINX_VCU is not set
>> CONFIG_HWSPINLOCK=y
>>
>> #
>> # Clock Source drivers
>> #
>> CONFIG_CLKEVT_I8253=y
>> CONFIG_I8253_LOCK=y
>> CONFIG_CLKBLD_I8253=y
>> # end of Clock Source drivers
>>
>> CONFIG_MAILBOX=y
>> CONFIG_PCC=y
>> # CONFIG_ALTERA_MBOX is not set
>> CONFIG_IOMMU_IOVA=y
>> CONFIG_IOASID=y
>> CONFIG_IOMMU_API=y
>> CONFIG_IOMMU_SUPPORT=y
>>
>> #
>> # Generic IOMMU Pagetable Support
>> #
>> # end of Generic IOMMU Pagetable Support
>>
>> # CONFIG_IOMMU_DEBUGFS is not set
>> # CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
>> CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
>> # CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
>> CONFIG_IOMMU_DMA=y
>> # CONFIG_AMD_IOMMU is not set
>> CONFIG_DMAR_TABLE=y
>> CONFIG_INTEL_IOMMU=y
>> # CONFIG_INTEL_IOMMU_SVM is not set
>> # CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
>> CONFIG_INTEL_IOMMU_FLOPPY_WA=y
>> CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=y
>> CONFIG_IRQ_REMAP=y
>> # CONFIG_VIRTIO_IOMMU is not set
>>
>> #
>> # Remoteproc drivers
>> #
>> # CONFIG_REMOTEPROC is not set
>> # end of Remoteproc drivers
>>
>> #
>> # Rpmsg drivers
>> #
>> # CONFIG_RPMSG_QCOM_GLINK_RPM is not set
>> # CONFIG_RPMSG_VIRTIO is not set
>> # end of Rpmsg drivers
>>
>> # CONFIG_SOUNDWIRE is not set
>>
>> #
>> # SOC (System On Chip) specific Drivers
>> #
>>
>> #
>> # Amlogic SoC drivers
>> #
>> # end of Amlogic SoC drivers
>>
>> #
>> # Broadcom SoC drivers
>> #
>> # end of Broadcom SoC drivers
>>
>> #
>> # NXP/Freescale QorIQ SoC drivers
>> #
>> # end of NXP/Freescale QorIQ SoC drivers
>>
>> #
>> # i.MX SoC drivers
>> #
>> # end of i.MX SoC drivers
>>
>> #
>> # Enable LiteX SoC Builder specific drivers
>> #
>> # end of Enable LiteX SoC Builder specific drivers
>>
>> #
>> # Qualcomm SoC drivers
>> #
>> # end of Qualcomm SoC drivers
>>
>> # CONFIG_SOC_TI is not set
>>
>> #
>> # Xilinx SoC drivers
>> #
>> # end of Xilinx SoC drivers
>> # end of SOC (System On Chip) specific Drivers
>>
>> # CONFIG_PM_DEVFREQ is not set
>> # CONFIG_EXTCON is not set
>> # CONFIG_MEMORY is not set
>> # CONFIG_IIO is not set
>> CONFIG_NTB=m
>> # CONFIG_NTB_MSI is not set
>> # CONFIG_NTB_AMD is not set
>> # CONFIG_NTB_IDT is not set
>> # CONFIG_NTB_INTEL is not set
>> # CONFIG_NTB_EPF is not set
>> # CONFIG_NTB_SWITCHTEC is not set
>> # CONFIG_NTB_PINGPONG is not set
>> # CONFIG_NTB_TOOL is not set
>> # CONFIG_NTB_PERF is not set
>> # CONFIG_NTB_TRANSPORT is not set
>> # CONFIG_VME_BUS is not set
>> CONFIG_PWM=y
>> CONFIG_PWM_SYSFS=y
>> # CONFIG_PWM_DEBUG is not set
>> # CONFIG_PWM_DWC is not set
>> CONFIG_PWM_LPSS=m
>> CONFIG_PWM_LPSS_PCI=m
>> CONFIG_PWM_LPSS_PLATFORM=m
>> # CONFIG_PWM_PCA9685 is not set
>>
>> #
>> # IRQ chip support
>> #
>> # end of IRQ chip support
>>
>> # CONFIG_IPACK_BUS is not set
>> # CONFIG_RESET_CONTROLLER is not set
>>
>> #
>> # PHY Subsystem
>> #
>> # CONFIG_GENERIC_PHY is not set
>> # CONFIG_USB_LGM_PHY is not set
>> # CONFIG_PHY_CAN_TRANSCEIVER is not set
>>
>> #
>> # PHY drivers for Broadcom platforms
>> #
>> # CONFIG_BCM_KONA_USB2_PHY is not set
>> # end of PHY drivers for Broadcom platforms
>>
>> # CONFIG_PHY_PXA_28NM_HSIC is not set
>> # CONFIG_PHY_PXA_28NM_USB2 is not set
>> # CONFIG_PHY_INTEL_LGM_EMMC is not set
>> # end of PHY Subsystem
>>
>> CONFIG_POWERCAP=y
>> CONFIG_INTEL_RAPL_CORE=m
>> CONFIG_INTEL_RAPL=m
>> # CONFIG_IDLE_INJECT is not set
>> # CONFIG_DTPM is not set
>> # CONFIG_MCB is not set
>>
>> #
>> # Performance monitor support
>> #
>> # end of Performance monitor support
>>
>> CONFIG_RAS=y
>> # CONFIG_RAS_CEC is not set
>> # CONFIG_USB4 is not set
>>
>> #
>> # Android
>> #
>> # CONFIG_ANDROID is not set
>> # end of Android
>>
>> CONFIG_LIBNVDIMM=m
>> CONFIG_BLK_DEV_PMEM=m
>> CONFIG_ND_BLK=m
>> CONFIG_ND_CLAIM=y
>> CONFIG_ND_BTT=m
>> CONFIG_BTT=y
>> CONFIG_ND_PFN=m
>> CONFIG_NVDIMM_PFN=y
>> CONFIG_NVDIMM_DAX=y
>> CONFIG_NVDIMM_KEYS=y
>> CONFIG_DAX=y
>> CONFIG_DEV_DAX=m
>> CONFIG_DEV_DAX_PMEM=m
>> CONFIG_DEV_DAX_KMEM=m
>> CONFIG_NVMEM=y
>> CONFIG_NVMEM_SYSFS=y
>> # CONFIG_NVMEM_RMEM is not set
>>
>> #
>> # HW tracing support
>> #
>> CONFIG_STM=m
>> # CONFIG_STM_PROTO_BASIC is not set
>> # CONFIG_STM_PROTO_SYS_T is not set
>> CONFIG_STM_DUMMY=m
>> CONFIG_STM_SOURCE_CONSOLE=m
>> CONFIG_STM_SOURCE_HEARTBEAT=m
>> CONFIG_STM_SOURCE_FTRACE=m
>> CONFIG_INTEL_TH=m
>> CONFIG_INTEL_TH_PCI=m
>> CONFIG_INTEL_TH_ACPI=m
>> CONFIG_INTEL_TH_GTH=m
>> CONFIG_INTEL_TH_STH=m
>> CONFIG_INTEL_TH_MSU=m
>> CONFIG_INTEL_TH_PTI=m
>> # CONFIG_INTEL_TH_DEBUG is not set
>> # end of HW tracing support
>>
>> # CONFIG_FPGA is not set
>> # CONFIG_TEE is not set
>> # CONFIG_UNISYS_VISORBUS is not set
>> # CONFIG_SIOX is not set
>> # CONFIG_SLIMBUS is not set
>> # CONFIG_INTERCONNECT is not set
>> # CONFIG_COUNTER is not set
>> # CONFIG_MOST is not set
>> # end of Device Drivers
>>
>> #
>> # File systems
>> #
>> CONFIG_DCACHE_WORD_ACCESS=y
>> # CONFIG_VALIDATE_FS_PARSER is not set
>> CONFIG_FS_IOMAP=y
>> CONFIG_EXT2_FS=m
>> # CONFIG_EXT2_FS_XATTR is not set
>> # CONFIG_EXT3_FS is not set
>> CONFIG_EXT4_FS=y
>> CONFIG_EXT4_FS_POSIX_ACL=y
>> CONFIG_EXT4_FS_SECURITY=y
>> # CONFIG_EXT4_DEBUG is not set
>> CONFIG_JBD2=y
>> # CONFIG_JBD2_DEBUG is not set
>> CONFIG_FS_MBCACHE=y
>> # CONFIG_REISERFS_FS is not set
>> # CONFIG_JFS_FS is not set
>> CONFIG_XFS_FS=m
>> CONFIG_XFS_SUPPORT_V4=y
>> CONFIG_XFS_QUOTA=y
>> CONFIG_XFS_POSIX_ACL=y
>> CONFIG_XFS_RT=y
>> CONFIG_XFS_ONLINE_SCRUB=y
>> # CONFIG_XFS_ONLINE_REPAIR is not set
>> CONFIG_XFS_DEBUG=y
>> CONFIG_XFS_ASSERT_FATAL=y
>> CONFIG_GFS2_FS=m
>> CONFIG_GFS2_FS_LOCKING_DLM=y
>> CONFIG_OCFS2_FS=m
>> CONFIG_OCFS2_FS_O2CB=m
>> CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
>> CONFIG_OCFS2_FS_STATS=y
>> CONFIG_OCFS2_DEBUG_MASKLOG=y
>> # CONFIG_OCFS2_DEBUG_FS is not set
>> CONFIG_BTRFS_FS=m
>> CONFIG_BTRFS_FS_POSIX_ACL=y
>> # CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
>> # CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
>> # CONFIG_BTRFS_DEBUG is not set
>> # CONFIG_BTRFS_ASSERT is not set
>> # CONFIG_BTRFS_FS_REF_VERIFY is not set
>> # CONFIG_NILFS2_FS is not set
>> CONFIG_F2FS_FS=m
>> CONFIG_F2FS_STAT_FS=y
>> CONFIG_F2FS_FS_XATTR=y
>> CONFIG_F2FS_FS_POSIX_ACL=y
>> # CONFIG_F2FS_FS_SECURITY is not set
>> # CONFIG_F2FS_CHECK_FS is not set
>> # CONFIG_F2FS_FAULT_INJECTION is not set
>> # CONFIG_F2FS_FS_COMPRESSION is not set
>> CONFIG_F2FS_IOSTAT=y
>> CONFIG_FS_DAX=y
>> CONFIG_FS_DAX_PMD=y
>> CONFIG_FS_POSIX_ACL=y
>> CONFIG_EXPORTFS=y
>> CONFIG_EXPORTFS_BLOCK_OPS=y
>> CONFIG_FILE_LOCKING=y
>> CONFIG_FS_ENCRYPTION=y
>> CONFIG_FS_ENCRYPTION_ALGS=y
>> # CONFIG_FS_VERITY is not set
>> CONFIG_FSNOTIFY=y
>> CONFIG_DNOTIFY=y
>> CONFIG_INOTIFY_USER=y
>> CONFIG_FANOTIFY=y
>> CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
>> CONFIG_QUOTA=y
>> CONFIG_QUOTA_NETLINK_INTERFACE=y
>> CONFIG_PRINT_QUOTA_WARNING=y
>> # CONFIG_QUOTA_DEBUG is not set
>> CONFIG_QUOTA_TREE=y
>> # CONFIG_QFMT_V1 is not set
>> CONFIG_QFMT_V2=y
>> CONFIG_QUOTACTL=y
>> CONFIG_AUTOFS4_FS=y
>> CONFIG_AUTOFS_FS=y
>> CONFIG_FUSE_FS=m
>> CONFIG_CUSE=m
>> # CONFIG_VIRTIO_FS is not set
>> CONFIG_OVERLAY_FS=m
>> # CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
>> # CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
>> # CONFIG_OVERLAY_FS_INDEX is not set
>> # CONFIG_OVERLAY_FS_XINO_AUTO is not set
>> # CONFIG_OVERLAY_FS_METACOPY is not set
>>
>> #
>> # Caches
>> #
>> CONFIG_NETFS_SUPPORT=m
>> CONFIG_NETFS_STATS=y
>> CONFIG_FSCACHE=m
>> CONFIG_FSCACHE_STATS=y
>> # CONFIG_FSCACHE_DEBUG is not set
>> CONFIG_CACHEFILES=m
>> # CONFIG_CACHEFILES_DEBUG is not set
>> # CONFIG_CACHEFILES_ERROR_INJECTION is not set
>> # end of Caches
>>
>> #
>> # CD-ROM/DVD Filesystems
>> #
>> CONFIG_ISO9660_FS=m
>> CONFIG_JOLIET=y
>> CONFIG_ZISOFS=y
>> CONFIG_UDF_FS=m
>> # end of CD-ROM/DVD Filesystems
>>
>> #
>> # DOS/FAT/EXFAT/NT Filesystems
>> #
>> CONFIG_FAT_FS=m
>> CONFIG_MSDOS_FS=m
>> CONFIG_VFAT_FS=m
>> CONFIG_FAT_DEFAULT_CODEPAGE=437
>> CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
>> # CONFIG_FAT_DEFAULT_UTF8 is not set
>> # CONFIG_EXFAT_FS is not set
>> # CONFIG_NTFS_FS is not set
>> # CONFIG_NTFS3_FS is not set
>> # end of DOS/FAT/EXFAT/NT Filesystems
>>
>> #
>> # Pseudo filesystems
>> #
>> CONFIG_PROC_FS=y
>> CONFIG_PROC_KCORE=y
>> CONFIG_PROC_VMCORE=y
>> CONFIG_PROC_VMCORE_DEVICE_DUMP=y
>> CONFIG_PROC_SYSCTL=y
>> CONFIG_PROC_PAGE_MONITOR=y
>> CONFIG_PROC_CHILDREN=y
>> CONFIG_PROC_PID_ARCH_STATUS=y
>> CONFIG_KERNFS=y
>> CONFIG_SYSFS=y
>> CONFIG_TMPFS=y
>> CONFIG_TMPFS_POSIX_ACL=y
>> CONFIG_TMPFS_XATTR=y
>> # CONFIG_TMPFS_INODE64 is not set
>> CONFIG_HUGETLBFS=y
>> CONFIG_HUGETLB_PAGE=y
>> CONFIG_HUGETLB_PAGE_FREE_VMEMMAP=y
>> # CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON is not set
>> CONFIG_MEMFD_CREATE=y
>> CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
>> CONFIG_CONFIGFS_FS=y
>> CONFIG_EFIVAR_FS=y
>> # end of Pseudo filesystems
>>
>> CONFIG_MISC_FILESYSTEMS=y
>> # CONFIG_ORANGEFS_FS is not set
>> # CONFIG_ADFS_FS is not set
>> # CONFIG_AFFS_FS is not set
>> # CONFIG_ECRYPT_FS is not set
>> # CONFIG_HFS_FS is not set
>> # CONFIG_HFSPLUS_FS is not set
>> # CONFIG_BEFS_FS is not set
>> # CONFIG_BFS_FS is not set
>> # CONFIG_EFS_FS is not set
>> CONFIG_CRAMFS=m
>> CONFIG_CRAMFS_BLOCKDEV=y
>> CONFIG_SQUASHFS=m
>> # CONFIG_SQUASHFS_FILE_CACHE is not set
>> CONFIG_SQUASHFS_FILE_DIRECT=y
>> # CONFIG_SQUASHFS_DECOMP_SINGLE is not set
>> # CONFIG_SQUASHFS_DECOMP_MULTI is not set
>> CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
>> CONFIG_SQUASHFS_XATTR=y
>> CONFIG_SQUASHFS_ZLIB=y
>> # CONFIG_SQUASHFS_LZ4 is not set
>> CONFIG_SQUASHFS_LZO=y
>> CONFIG_SQUASHFS_XZ=y
>> # CONFIG_SQUASHFS_ZSTD is not set
>> # CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
>> # CONFIG_SQUASHFS_EMBEDDED is not set
>> CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
>> # CONFIG_VXFS_FS is not set
>> # CONFIG_MINIX_FS is not set
>> # CONFIG_OMFS_FS is not set
>> # CONFIG_HPFS_FS is not set
>> # CONFIG_QNX4FS_FS is not set
>> # CONFIG_QNX6FS_FS is not set
>> # CONFIG_ROMFS_FS is not set
>> CONFIG_PSTORE=y
>> CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
>> CONFIG_PSTORE_DEFLATE_COMPRESS=y
>> # CONFIG_PSTORE_LZO_COMPRESS is not set
>> # CONFIG_PSTORE_LZ4_COMPRESS is not set
>> # CONFIG_PSTORE_LZ4HC_COMPRESS is not set
>> # CONFIG_PSTORE_842_COMPRESS is not set
>> # CONFIG_PSTORE_ZSTD_COMPRESS is not set
>> CONFIG_PSTORE_COMPRESS=y
>> CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
>> CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
>> # CONFIG_PSTORE_CONSOLE is not set
>> # CONFIG_PSTORE_PMSG is not set
>> # CONFIG_PSTORE_FTRACE is not set
>> CONFIG_PSTORE_RAM=m
>> # CONFIG_PSTORE_BLK is not set
>> # CONFIG_SYSV_FS is not set
>> # CONFIG_UFS_FS is not set
>> # CONFIG_EROFS_FS is not set
>> CONFIG_NETWORK_FILESYSTEMS=y
>> CONFIG_NFS_FS=y
>> # CONFIG_NFS_V2 is not set
>> CONFIG_NFS_V3=y
>> CONFIG_NFS_V3_ACL=y
>> CONFIG_NFS_V4=m
>> # CONFIG_NFS_SWAP is not set
>> CONFIG_NFS_V4_1=y
>> CONFIG_NFS_V4_2=y
>> CONFIG_PNFS_FILE_LAYOUT=m
>> CONFIG_PNFS_BLOCK=m
>> CONFIG_PNFS_FLEXFILE_LAYOUT=m
>> CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
>> # CONFIG_NFS_V4_1_MIGRATION is not set
>> CONFIG_NFS_V4_SECURITY_LABEL=y
>> CONFIG_ROOT_NFS=y
>> # CONFIG_NFS_USE_LEGACY_DNS is not set
>> CONFIG_NFS_USE_KERNEL_DNS=y
>> CONFIG_NFS_DEBUG=y
>> CONFIG_NFS_DISABLE_UDP_SUPPORT=y
>> # CONFIG_NFS_V4_2_READ_PLUS is not set
>> CONFIG_NFSD=m
>> CONFIG_NFSD_V2_ACL=y
>> CONFIG_NFSD_V3=y
>> CONFIG_NFSD_V3_ACL=y
>> CONFIG_NFSD_V4=y
>> CONFIG_NFSD_PNFS=y
>> # CONFIG_NFSD_BLOCKLAYOUT is not set
>> CONFIG_NFSD_SCSILAYOUT=y
>> # CONFIG_NFSD_FLEXFILELAYOUT is not set
>> # CONFIG_NFSD_V4_2_INTER_SSC is not set
>> CONFIG_NFSD_V4_SECURITY_LABEL=y
>> CONFIG_GRACE_PERIOD=y
>> CONFIG_LOCKD=y
>> CONFIG_LOCKD_V4=y
>> CONFIG_NFS_ACL_SUPPORT=y
>> CONFIG_NFS_COMMON=y
>> CONFIG_NFS_V4_2_SSC_HELPER=y
>> CONFIG_SUNRPC=y
>> CONFIG_SUNRPC_GSS=m
>> CONFIG_SUNRPC_BACKCHANNEL=y
>> CONFIG_RPCSEC_GSS_KRB5=m
>> # CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
>> CONFIG_SUNRPC_DEBUG=y
>> CONFIG_CEPH_FS=m
>> # CONFIG_CEPH_FSCACHE is not set
>> CONFIG_CEPH_FS_POSIX_ACL=y
>> # CONFIG_CEPH_FS_SECURITY_LABEL is not set
>> CONFIG_CIFS=m
>> CONFIG_CIFS_STATS2=y
>> CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
>> CONFIG_CIFS_UPCALL=y
>> CONFIG_CIFS_XATTR=y
>> CONFIG_CIFS_POSIX=y
>> CONFIG_CIFS_DEBUG=y
>> # CONFIG_CIFS_DEBUG2 is not set
>> # CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
>> CONFIG_CIFS_DFS_UPCALL=y
>> # CONFIG_CIFS_SWN_UPCALL is not set
>> # CONFIG_CIFS_FSCACHE is not set
>> # CONFIG_SMB_SERVER is not set
>> CONFIG_SMBFS_COMMON=m
>> # CONFIG_CODA_FS is not set
>> # CONFIG_AFS_FS is not set
>> # CONFIG_9P_FS is not set
>> CONFIG_NLS=y
>> CONFIG_NLS_DEFAULT="utf8"
>> CONFIG_NLS_CODEPAGE_437=y
>> CONFIG_NLS_CODEPAGE_737=m
>> CONFIG_NLS_CODEPAGE_775=m
>> CONFIG_NLS_CODEPAGE_850=m
>> CONFIG_NLS_CODEPAGE_852=m
>> CONFIG_NLS_CODEPAGE_855=m
>> CONFIG_NLS_CODEPAGE_857=m
>> CONFIG_NLS_CODEPAGE_860=m
>> CONFIG_NLS_CODEPAGE_861=m
>> CONFIG_NLS_CODEPAGE_862=m
>> CONFIG_NLS_CODEPAGE_863=m
>> CONFIG_NLS_CODEPAGE_864=m
>> CONFIG_NLS_CODEPAGE_865=m
>> CONFIG_NLS_CODEPAGE_866=m
>> CONFIG_NLS_CODEPAGE_869=m
>> CONFIG_NLS_CODEPAGE_936=m
>> CONFIG_NLS_CODEPAGE_950=m
>> CONFIG_NLS_CODEPAGE_932=m
>> CONFIG_NLS_CODEPAGE_949=m
>> CONFIG_NLS_CODEPAGE_874=m
>> CONFIG_NLS_ISO8859_8=m
>> CONFIG_NLS_CODEPAGE_1250=m
>> CONFIG_NLS_CODEPAGE_1251=m
>> CONFIG_NLS_ASCII=y
>> CONFIG_NLS_ISO8859_1=m
>> CONFIG_NLS_ISO8859_2=m
>> CONFIG_NLS_ISO8859_3=m
>> CONFIG_NLS_ISO8859_4=m
>> CONFIG_NLS_ISO8859_5=m
>> CONFIG_NLS_ISO8859_6=m
>> CONFIG_NLS_ISO8859_7=m
>> CONFIG_NLS_ISO8859_9=m
>> CONFIG_NLS_ISO8859_13=m
>> CONFIG_NLS_ISO8859_14=m
>> CONFIG_NLS_ISO8859_15=m
>> CONFIG_NLS_KOI8_R=m
>> CONFIG_NLS_KOI8_U=m
>> CONFIG_NLS_MAC_ROMAN=m
>> CONFIG_NLS_MAC_CELTIC=m
>> CONFIG_NLS_MAC_CENTEURO=m
>> CONFIG_NLS_MAC_CROATIAN=m
>> CONFIG_NLS_MAC_CYRILLIC=m
>> CONFIG_NLS_MAC_GAELIC=m
>> CONFIG_NLS_MAC_GREEK=m
>> CONFIG_NLS_MAC_ICELAND=m
>> CONFIG_NLS_MAC_INUIT=m
>> CONFIG_NLS_MAC_ROMANIAN=m
>> CONFIG_NLS_MAC_TURKISH=m
>> CONFIG_NLS_UTF8=m
>> CONFIG_DLM=m
>> CONFIG_DLM_DEBUG=y
>> # CONFIG_UNICODE is not set
>> CONFIG_IO_WQ=y
>> # end of File systems
>>
>> #
>> # Security options
>> #
>> CONFIG_KEYS=y
>> # CONFIG_KEYS_REQUEST_CACHE is not set
>> CONFIG_PERSISTENT_KEYRINGS=y
>> CONFIG_TRUSTED_KEYS=y
>> CONFIG_ENCRYPTED_KEYS=y
>> # CONFIG_KEY_DH_OPERATIONS is not set
>> # CONFIG_SECURITY_DMESG_RESTRICT is not set
>> CONFIG_SECURITY=y
>> CONFIG_SECURITYFS=y
>> CONFIG_SECURITY_NETWORK=y
>> CONFIG_PAGE_TABLE_ISOLATION=y
>> CONFIG_SECURITY_NETWORK_XFRM=y
>> CONFIG_SECURITY_PATH=y
>> CONFIG_INTEL_TXT=y
>> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
>> CONFIG_HARDENED_USERCOPY=y
>> CONFIG_FORTIFY_SOURCE=y
>> # CONFIG_STATIC_USERMODEHELPER is not set
>> # CONFIG_SECURITY_SELINUX is not set
>> # CONFIG_SECURITY_SMACK is not set
>> # CONFIG_SECURITY_TOMOYO is not set
>> CONFIG_SECURITY_APPARMOR=y
>> CONFIG_SECURITY_APPARMOR_HASH=y
>> CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
>> # CONFIG_SECURITY_APPARMOR_DEBUG is not set
>> # CONFIG_SECURITY_LOADPIN is not set
>> CONFIG_SECURITY_YAMA=y
>> # CONFIG_SECURITY_SAFESETID is not set
>> # CONFIG_SECURITY_LOCKDOWN_LSM is not set
>> # CONFIG_SECURITY_LANDLOCK is not set
>> CONFIG_INTEGRITY=y
>> CONFIG_INTEGRITY_SIGNATURE=y
>> CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
>> CONFIG_INTEGRITY_TRUSTED_KEYRING=y
>> # CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
>> CONFIG_INTEGRITY_AUDIT=y
>> # CONFIG_IMA is not set
>> # CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
>> CONFIG_EVM=y
>> CONFIG_EVM_ATTR_FSUUID=y
>> # CONFIG_EVM_ADD_XATTRS is not set
>> # CONFIG_EVM_LOAD_X509 is not set
>> CONFIG_DEFAULT_SECURITY_APPARMOR=y
>> # CONFIG_DEFAULT_SECURITY_DAC is not set
>> CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo,bpf"
>>
>> #
>> # Kernel hardening options
>> #
>>
>> #
>> # Memory initialization
>> #
>> CONFIG_INIT_STACK_NONE=y
>> # CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
>> # CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF is not set
>> # CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is not set
>> # CONFIG_GCC_PLUGIN_STACKLEAK is not set
>> # CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
>> # CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
>> CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
>> # CONFIG_ZERO_CALL_USED_REGS is not set
>> # end of Memory initialization
>> # end of Kernel hardening options
>> # end of Security options
>>
>> CONFIG_XOR_BLOCKS=m
>> CONFIG_ASYNC_CORE=m
>> CONFIG_ASYNC_MEMCPY=m
>> CONFIG_ASYNC_XOR=m
>> CONFIG_ASYNC_PQ=m
>> CONFIG_ASYNC_RAID6_RECOV=m
>> CONFIG_CRYPTO=y
>>
>> #
>> # Crypto core or helper
>> #
>> CONFIG_CRYPTO_ALGAPI=y
>> CONFIG_CRYPTO_ALGAPI2=y
>> CONFIG_CRYPTO_AEAD=y
>> CONFIG_CRYPTO_AEAD2=y
>> CONFIG_CRYPTO_SKCIPHER=y
>> CONFIG_CRYPTO_SKCIPHER2=y
>> CONFIG_CRYPTO_HASH=y
>> CONFIG_CRYPTO_HASH2=y
>> CONFIG_CRYPTO_RNG=y
>> CONFIG_CRYPTO_RNG2=y
>> CONFIG_CRYPTO_RNG_DEFAULT=y
>> CONFIG_CRYPTO_AKCIPHER2=y
>> CONFIG_CRYPTO_AKCIPHER=y
>> CONFIG_CRYPTO_KPP2=y
>> CONFIG_CRYPTO_KPP=m
>> CONFIG_CRYPTO_ACOMP2=y
>> CONFIG_CRYPTO_MANAGER=y
>> CONFIG_CRYPTO_MANAGER2=y
>> CONFIG_CRYPTO_USER=m
>> CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
>> CONFIG_CRYPTO_GF128MUL=y
>> CONFIG_CRYPTO_NULL=y
>> CONFIG_CRYPTO_NULL2=y
>> CONFIG_CRYPTO_PCRYPT=m
>> CONFIG_CRYPTO_CRYPTD=y
>> CONFIG_CRYPTO_AUTHENC=m
>> # CONFIG_CRYPTO_TEST is not set
>> CONFIG_CRYPTO_SIMD=y
>>
>> #
>> # Public-key cryptography
>> #
>> CONFIG_CRYPTO_RSA=y
>> CONFIG_CRYPTO_DH=m
>> CONFIG_CRYPTO_ECC=m
>> CONFIG_CRYPTO_ECDH=m
>> # CONFIG_CRYPTO_ECDSA is not set
>> # CONFIG_CRYPTO_ECRDSA is not set
>> # CONFIG_CRYPTO_SM2 is not set
>> # CONFIG_CRYPTO_CURVE25519 is not set
>> # CONFIG_CRYPTO_CURVE25519_X86 is not set
>>
>> #
>> # Authenticated Encryption with Associated Data
>> #
>> CONFIG_CRYPTO_CCM=m
>> CONFIG_CRYPTO_GCM=y
>> CONFIG_CRYPTO_CHACHA20POLY1305=m
>> # CONFIG_CRYPTO_AEGIS128 is not set
>> # CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
>> CONFIG_CRYPTO_SEQIV=y
>> CONFIG_CRYPTO_ECHAINIV=m
>>
>> #
>> # Block modes
>> #
>> CONFIG_CRYPTO_CBC=y
>> CONFIG_CRYPTO_CFB=y
>> CONFIG_CRYPTO_CTR=y
>> CONFIG_CRYPTO_CTS=m
>> CONFIG_CRYPTO_ECB=y
>> CONFIG_CRYPTO_LRW=m
>> CONFIG_CRYPTO_OFB=m
>> CONFIG_CRYPTO_PCBC=m
>> CONFIG_CRYPTO_XTS=m
>> # CONFIG_CRYPTO_KEYWRAP is not set
>> # CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
>> # CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
>> # CONFIG_CRYPTO_ADIANTUM is not set
>> CONFIG_CRYPTO_ESSIV=m
>>
>> #
>> # Hash modes
>> #
>> CONFIG_CRYPTO_CMAC=m
>> CONFIG_CRYPTO_HMAC=y
>> CONFIG_CRYPTO_XCBC=m
>> CONFIG_CRYPTO_VMAC=m
>>
>> #
>> # Digest
>> #
>> CONFIG_CRYPTO_CRC32C=y
>> CONFIG_CRYPTO_CRC32C_INTEL=m
>> CONFIG_CRYPTO_CRC32=m
>> CONFIG_CRYPTO_CRC32_PCLMUL=m
>> CONFIG_CRYPTO_XXHASH=m
>> CONFIG_CRYPTO_BLAKE2B=m
>> # CONFIG_CRYPTO_BLAKE2S is not set
>> # CONFIG_CRYPTO_BLAKE2S_X86 is not set
>> CONFIG_CRYPTO_CRCT10DIF=y
>> CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
>> CONFIG_CRYPTO_GHASH=y
>> CONFIG_CRYPTO_POLY1305=m
>> CONFIG_CRYPTO_POLY1305_X86_64=m
>> CONFIG_CRYPTO_MD4=m
>> CONFIG_CRYPTO_MD5=y
>> CONFIG_CRYPTO_MICHAEL_MIC=m
>> CONFIG_CRYPTO_RMD160=m
>> CONFIG_CRYPTO_SHA1=y
>> CONFIG_CRYPTO_SHA1_SSSE3=y
>> CONFIG_CRYPTO_SHA256_SSSE3=y
>> CONFIG_CRYPTO_SHA512_SSSE3=m
>> CONFIG_CRYPTO_SHA256=y
>> CONFIG_CRYPTO_SHA512=y
>> CONFIG_CRYPTO_SHA3=m
>> # CONFIG_CRYPTO_SM3 is not set
>> # CONFIG_CRYPTO_STREEBOG is not set
>> CONFIG_CRYPTO_WP512=m
>> CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m
>>
>> #
>> # Ciphers
>> #
>> CONFIG_CRYPTO_AES=y
>> # CONFIG_CRYPTO_AES_TI is not set
>> CONFIG_CRYPTO_AES_NI_INTEL=y
>> CONFIG_CRYPTO_ANUBIS=m
>> CONFIG_CRYPTO_ARC4=m
>> CONFIG_CRYPTO_BLOWFISH=m
>> CONFIG_CRYPTO_BLOWFISH_COMMON=m
>> CONFIG_CRYPTO_BLOWFISH_X86_64=m
>> CONFIG_CRYPTO_CAMELLIA=m
>> CONFIG_CRYPTO_CAMELLIA_X86_64=m
>> CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
>> CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
>> CONFIG_CRYPTO_CAST_COMMON=m
>> CONFIG_CRYPTO_CAST5=m
>> CONFIG_CRYPTO_CAST5_AVX_X86_64=m
>> CONFIG_CRYPTO_CAST6=m
>> CONFIG_CRYPTO_CAST6_AVX_X86_64=m
>> CONFIG_CRYPTO_DES=m
>> # CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
>> CONFIG_CRYPTO_FCRYPT=m
>> CONFIG_CRYPTO_KHAZAD=m
>> CONFIG_CRYPTO_CHACHA20=m
>> CONFIG_CRYPTO_CHACHA20_X86_64=m
>> CONFIG_CRYPTO_SEED=m
>> CONFIG_CRYPTO_SERPENT=m
>> CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
>> CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
>> CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
>> CONFIG_CRYPTO_SM4=m
>> # CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
>> # CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
>> CONFIG_CRYPTO_TEA=m
>> CONFIG_CRYPTO_TWOFISH=m
>> CONFIG_CRYPTO_TWOFISH_COMMON=m
>> CONFIG_CRYPTO_TWOFISH_X86_64=m
>> CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
>> CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m
>>
>> #
>> # Compression
>> #
>> CONFIG_CRYPTO_DEFLATE=y
>> CONFIG_CRYPTO_LZO=y
>> # CONFIG_CRYPTO_842 is not set
>> # CONFIG_CRYPTO_LZ4 is not set
>> # CONFIG_CRYPTO_LZ4HC is not set
>> # CONFIG_CRYPTO_ZSTD is not set
>>
>> #
>> # Random Number Generation
>> #
>> CONFIG_CRYPTO_ANSI_CPRNG=m
>> CONFIG_CRYPTO_DRBG_MENU=y
>> CONFIG_CRYPTO_DRBG_HMAC=y
>> CONFIG_CRYPTO_DRBG_HASH=y
>> CONFIG_CRYPTO_DRBG_CTR=y
>> CONFIG_CRYPTO_DRBG=y
>> CONFIG_CRYPTO_JITTERENTROPY=y
>> CONFIG_CRYPTO_USER_API=y
>> CONFIG_CRYPTO_USER_API_HASH=y
>> CONFIG_CRYPTO_USER_API_SKCIPHER=y
>> CONFIG_CRYPTO_USER_API_RNG=y
>> # CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
>> CONFIG_CRYPTO_USER_API_AEAD=y
>> CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
>> # CONFIG_CRYPTO_STATS is not set
>> CONFIG_CRYPTO_HASH_INFO=y
>> CONFIG_CRYPTO_HW=y
>> CONFIG_CRYPTO_DEV_PADLOCK=m
>> CONFIG_CRYPTO_DEV_PADLOCK_AES=m
>> CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
>> # CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
>> # CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
>> CONFIG_CRYPTO_DEV_CCP=y
>> CONFIG_CRYPTO_DEV_CCP_DD=m
>> CONFIG_CRYPTO_DEV_SP_CCP=y
>> CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
>> CONFIG_CRYPTO_DEV_SP_PSP=y
>> # CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
>> CONFIG_CRYPTO_DEV_QAT=m
>> CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
>> CONFIG_CRYPTO_DEV_QAT_C3XXX=m
>> CONFIG_CRYPTO_DEV_QAT_C62X=m
>> # CONFIG_CRYPTO_DEV_QAT_4XXX is not set
>> CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
>> CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
>> CONFIG_CRYPTO_DEV_QAT_C62XVF=m
>> CONFIG_CRYPTO_DEV_NITROX=m
>> CONFIG_CRYPTO_DEV_NITROX_CNN55XX=m
>> # CONFIG_CRYPTO_DEV_VIRTIO is not set
>> # CONFIG_CRYPTO_DEV_SAFEXCEL is not set
>> # CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
>> CONFIG_ASYMMETRIC_KEY_TYPE=y
>> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
>> # CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
>> CONFIG_X509_CERTIFICATE_PARSER=y
>> # CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
>> CONFIG_PKCS7_MESSAGE_PARSER=y
>> # CONFIG_PKCS7_TEST_KEY is not set
>> CONFIG_SIGNED_PE_FILE_VERIFICATION=y
>>
>> #
>> # Certificates for signature checking
>> #
>> CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
>> CONFIG_MODULE_SIG_KEY_TYPE_RSA=y
>> # CONFIG_MODULE_SIG_KEY_TYPE_ECDSA is not set
>> CONFIG_SYSTEM_TRUSTED_KEYRING=y
>> CONFIG_SYSTEM_TRUSTED_KEYS=""
>> # CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
>> # CONFIG_SECONDARY_TRUSTED_KEYRING is not set
>> CONFIG_SYSTEM_BLACKLIST_KEYRING=y
>> CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
>> # CONFIG_SYSTEM_REVOCATION_LIST is not set
>> # end of Certificates for signature checking
>>
>> CONFIG_BINARY_PRINTF=y
>>
>> #
>> # Library routines
>> #
>> CONFIG_RAID6_PQ=m
>> CONFIG_RAID6_PQ_BENCHMARK=y
>> # CONFIG_PACKING is not set
>> CONFIG_BITREVERSE=y
>> CONFIG_GENERIC_STRNCPY_FROM_USER=y
>> CONFIG_GENERIC_STRNLEN_USER=y
>> CONFIG_GENERIC_NET_UTILS=y
>> CONFIG_CORDIC=m
>> # CONFIG_PRIME_NUMBERS is not set
>> CONFIG_RATIONAL=y
>> CONFIG_GENERIC_PCI_IOMAP=y
>> CONFIG_GENERIC_IOMAP=y
>> CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
>> CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
>> CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
>>
>> #
>> # Crypto library routines
>> #
>> CONFIG_CRYPTO_LIB_AES=y
>> CONFIG_CRYPTO_LIB_ARC4=m
>> CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
>> CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
>> CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
>> # CONFIG_CRYPTO_LIB_CHACHA is not set
>> # CONFIG_CRYPTO_LIB_CURVE25519 is not set
>> CONFIG_CRYPTO_LIB_DES=m
>> CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
>> CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=m
>> CONFIG_CRYPTO_LIB_POLY1305_GENERIC=m
>> # CONFIG_CRYPTO_LIB_POLY1305 is not set
>> # CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
>> CONFIG_CRYPTO_LIB_SHA256=y
>> CONFIG_CRYPTO_LIB_SM4=m
>> # end of Crypto library routines
>>
>> CONFIG_CRC_CCITT=y
>> CONFIG_CRC16=y
>> CONFIG_CRC_T10DIF=y
>> CONFIG_CRC_ITU_T=m
>> CONFIG_CRC32=y
>> # CONFIG_CRC32_SELFTEST is not set
>> CONFIG_CRC32_SLICEBY8=y
>> # CONFIG_CRC32_SLICEBY4 is not set
>> # CONFIG_CRC32_SARWATE is not set
>> # CONFIG_CRC32_BIT is not set
>> # CONFIG_CRC64 is not set
>> # CONFIG_CRC4 is not set
>> CONFIG_CRC7=m
>> CONFIG_LIBCRC32C=m
>> CONFIG_CRC8=m
>> CONFIG_XXHASH=y
>> # CONFIG_RANDOM32_SELFTEST is not set
>> CONFIG_ZLIB_INFLATE=y
>> CONFIG_ZLIB_DEFLATE=y
>> CONFIG_LZO_COMPRESS=y
>> CONFIG_LZO_DECOMPRESS=y
>> CONFIG_LZ4_DECOMPRESS=y
>> CONFIG_ZSTD_COMPRESS=m
>> CONFIG_ZSTD_DECOMPRESS=y
>> CONFIG_XZ_DEC=y
>> CONFIG_XZ_DEC_X86=y
>> CONFIG_XZ_DEC_POWERPC=y
>> CONFIG_XZ_DEC_IA64=y
>> CONFIG_XZ_DEC_ARM=y
>> CONFIG_XZ_DEC_ARMTHUMB=y
>> CONFIG_XZ_DEC_SPARC=y
>> # CONFIG_XZ_DEC_MICROLZMA is not set
>> CONFIG_XZ_DEC_BCJ=y
>> # CONFIG_XZ_DEC_TEST is not set
>> CONFIG_DECOMPRESS_GZIP=y
>> CONFIG_DECOMPRESS_BZIP2=y
>> CONFIG_DECOMPRESS_LZMA=y
>> CONFIG_DECOMPRESS_XZ=y
>> CONFIG_DECOMPRESS_LZO=y
>> CONFIG_DECOMPRESS_LZ4=y
>> CONFIG_DECOMPRESS_ZSTD=y
>> CONFIG_GENERIC_ALLOCATOR=y
>> CONFIG_REED_SOLOMON=m
>> CONFIG_REED_SOLOMON_ENC8=y
>> CONFIG_REED_SOLOMON_DEC8=y
>> CONFIG_TEXTSEARCH=y
>> CONFIG_TEXTSEARCH_KMP=m
>> CONFIG_TEXTSEARCH_BM=m
>> CONFIG_TEXTSEARCH_FSM=m
>> CONFIG_INTERVAL_TREE=y
>> CONFIG_XARRAY_MULTI=y
>> CONFIG_ASSOCIATIVE_ARRAY=y
>> CONFIG_HAS_IOMEM=y
>> CONFIG_HAS_IOPORT_MAP=y
>> CONFIG_HAS_DMA=y
>> CONFIG_DMA_OPS=y
>> CONFIG_NEED_SG_DMA_LENGTH=y
>> CONFIG_NEED_DMA_MAP_STATE=y
>> CONFIG_ARCH_DMA_ADDR_T_64BIT=y
>> CONFIG_SWIOTLB=y
>> # CONFIG_DMA_API_DEBUG is not set
>> # CONFIG_DMA_MAP_BENCHMARK is not set
>> CONFIG_SGL_ALLOC=y
>> CONFIG_CHECK_SIGNATURE=y
>> CONFIG_CPUMASK_OFFSTACK=y
>> CONFIG_CPU_RMAP=y
>> CONFIG_DQL=y
>> CONFIG_GLOB=y
>> # CONFIG_GLOB_SELFTEST is not set
>> CONFIG_NLATTR=y
>> CONFIG_CLZ_TAB=y
>> CONFIG_IRQ_POLL=y
>> CONFIG_MPILIB=y
>> CONFIG_SIGNATURE=y
>> CONFIG_OID_REGISTRY=y
>> CONFIG_UCS2_STRING=y
>> CONFIG_HAVE_GENERIC_VDSO=y
>> CONFIG_GENERIC_GETTIMEOFDAY=y
>> CONFIG_GENERIC_VDSO_TIME_NS=y
>> CONFIG_FONT_SUPPORT=y
>> # CONFIG_FONTS is not set
>> CONFIG_FONT_8x8=y
>> CONFIG_FONT_8x16=y
>> CONFIG_SG_POOL=y
>> CONFIG_ARCH_HAS_PMEM_API=y
>> CONFIG_MEMREGION=y
>> CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
>> CONFIG_ARCH_HAS_COPY_MC=y
>> CONFIG_ARCH_STACKWALK=y
>> CONFIG_SBITMAP=y
>> # end of Library routines
>>
>> CONFIG_ASN1_ENCODER=y
>>
>> #
>> # Kernel hacking
>> #
>>
>> #
>> # printk and dmesg options
>> #
>> CONFIG_PRINTK_TIME=y
>> CONFIG_PRINTK_CALLER=y
>> # CONFIG_STACKTRACE_BUILD_ID is not set
>> CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
>> CONFIG_CONSOLE_LOGLEVEL_QUIET=4
>> CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
>> CONFIG_BOOT_PRINTK_DELAY=y
>> CONFIG_DYNAMIC_DEBUG=y
>> CONFIG_DYNAMIC_DEBUG_CORE=y
>> CONFIG_SYMBOLIC_ERRNAME=y
>> CONFIG_DEBUG_BUGVERBOSE=y
>> # end of printk and dmesg options
>>
>> #
>> # Compile-time checks and compiler options
>> #
>> CONFIG_DEBUG_INFO=y
>> CONFIG_DEBUG_INFO_REDUCED=y
>> # CONFIG_DEBUG_INFO_COMPRESSED is not set
>> # CONFIG_DEBUG_INFO_SPLIT is not set
>> # CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
>> CONFIG_DEBUG_INFO_DWARF4=y
>> # CONFIG_DEBUG_INFO_DWARF5 is not set
>> CONFIG_PAHOLE_HAS_SPLIT_BTF=y
>> # CONFIG_GDB_SCRIPTS is not set
>> CONFIG_FRAME_WARN=2048
>> CONFIG_STRIP_ASM_SYMS=y
>> # CONFIG_READABLE_ASM is not set
>> # CONFIG_HEADERS_INSTALL is not set
>> CONFIG_DEBUG_SECTION_MISMATCH=y
>> CONFIG_SECTION_MISMATCH_WARN_ONLY=y
>> CONFIG_STACK_VALIDATION=y
>> # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
>> # end of Compile-time checks and compiler options
>>
>> #
>> # Generic Kernel Debugging Instruments
>> #
>> CONFIG_MAGIC_SYSRQ=y
>> CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
>> CONFIG_MAGIC_SYSRQ_SERIAL=y
>> CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
>> CONFIG_DEBUG_FS=y
>> CONFIG_DEBUG_FS_ALLOW_ALL=y
>> # CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
>> # CONFIG_DEBUG_FS_ALLOW_NONE is not set
>> CONFIG_HAVE_ARCH_KGDB=y
>> # CONFIG_KGDB is not set
>> CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
>> # CONFIG_UBSAN is not set
>> CONFIG_HAVE_ARCH_KCSAN=y
>> CONFIG_HAVE_KCSAN_COMPILER=y
>> # CONFIG_KCSAN is not set
>> # end of Generic Kernel Debugging Instruments
>>
>> CONFIG_DEBUG_KERNEL=y
>> CONFIG_DEBUG_MISC=y
>>
>> #
>> # Networking Debugging
>> #
>> # CONFIG_NET_DEV_REFCNT_TRACKER is not set
>> # CONFIG_NET_NS_REFCNT_TRACKER is not set
>> # end of Networking Debugging
>>
>> #
>> # Memory Debugging
>> #
>> # CONFIG_PAGE_EXTENSION is not set
>> # CONFIG_DEBUG_PAGEALLOC is not set
>> # CONFIG_PAGE_OWNER is not set
>> # CONFIG_PAGE_TABLE_CHECK is not set
>> # CONFIG_PAGE_POISONING is not set
>> # CONFIG_DEBUG_PAGE_REF is not set
>> # CONFIG_DEBUG_RODATA_TEST is not set
>> CONFIG_ARCH_HAS_DEBUG_WX=y
>> # CONFIG_DEBUG_WX is not set
>> CONFIG_GENERIC_PTDUMP=y
>> # CONFIG_PTDUMP_DEBUGFS is not set
>> # CONFIG_DEBUG_OBJECTS is not set
>> # CONFIG_SLUB_DEBUG_ON is not set
>> # CONFIG_SLUB_STATS is not set
>> CONFIG_HAVE_DEBUG_KMEMLEAK=y
>> # CONFIG_DEBUG_KMEMLEAK is not set
>> # CONFIG_DEBUG_STACK_USAGE is not set
>> # CONFIG_SCHED_STACK_END_CHECK is not set
>> CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
>> # CONFIG_DEBUG_VM is not set
>> # CONFIG_DEBUG_VM_PGTABLE is not set
>> CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
>> # CONFIG_DEBUG_VIRTUAL is not set
>> CONFIG_DEBUG_MEMORY_INIT=y
>> # CONFIG_DEBUG_PER_CPU_MAPS is not set
>> CONFIG_HAVE_ARCH_KASAN=y
>> CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
>> CONFIG_CC_HAS_KASAN_GENERIC=y
>> CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
>> # CONFIG_KASAN is not set
>> CONFIG_HAVE_ARCH_KFENCE=y
>> # CONFIG_KFENCE is not set
>> # end of Memory Debugging
>>
>> CONFIG_DEBUG_SHIRQ=y
>>
>> #
>> # Debug Oops, Lockups and Hangs
>> #
>> CONFIG_PANIC_ON_OOPS=y
>> CONFIG_PANIC_ON_OOPS_VALUE=1
>> CONFIG_PANIC_TIMEOUT=0
>> CONFIG_LOCKUP_DETECTOR=y
>> CONFIG_SOFTLOCKUP_DETECTOR=y
>> # CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
>> CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
>> CONFIG_HARDLOCKUP_DETECTOR_PERF=y
>> CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
>> CONFIG_HARDLOCKUP_DETECTOR=y
>> CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
>> CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
>> CONFIG_DETECT_HUNG_TASK=y
>> CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
>> # CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
>> CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
>> CONFIG_WQ_WATCHDOG=y
>> # CONFIG_TEST_LOCKUP is not set
>> # end of Debug Oops, Lockups and Hangs
>>
>> #
>> # Scheduler Debugging
>> #
>> CONFIG_SCHED_DEBUG=y
>> CONFIG_SCHED_INFO=y
>> CONFIG_SCHEDSTATS=y
>> # end of Scheduler Debugging
>>
>> # CONFIG_DEBUG_TIMEKEEPING is not set
>>
>> #
>> # Lock Debugging (spinlocks, mutexes, etc...)
>> #
>> CONFIG_LOCK_DEBUGGING_SUPPORT=y
>> # CONFIG_PROVE_LOCKING is not set
>> # CONFIG_LOCK_STAT is not set
>> # CONFIG_DEBUG_RT_MUTEXES is not set
>> # CONFIG_DEBUG_SPINLOCK is not set
>> # CONFIG_DEBUG_MUTEXES is not set
>> # CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
>> # CONFIG_DEBUG_RWSEMS is not set
>> # CONFIG_DEBUG_LOCK_ALLOC is not set
>> CONFIG_DEBUG_ATOMIC_SLEEP=y
>> # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
>> # CONFIG_LOCK_TORTURE_TEST is not set
>> # CONFIG_WW_MUTEX_SELFTEST is not set
>> # CONFIG_SCF_TORTURE_TEST is not set
>> # CONFIG_CSD_LOCK_WAIT_DEBUG is not set
>> # end of Lock Debugging (spinlocks, mutexes, etc...)
>>
>> # CONFIG_DEBUG_IRQFLAGS is not set
>> CONFIG_STACKTRACE=y
>> # CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
>> # CONFIG_DEBUG_KOBJECT is not set
>>
>> #
>> # Debug kernel data structures
>> #
>> CONFIG_DEBUG_LIST=y
>> # CONFIG_DEBUG_PLIST is not set
>> # CONFIG_DEBUG_SG is not set
>> # CONFIG_DEBUG_NOTIFIERS is not set
>> CONFIG_BUG_ON_DATA_CORRUPTION=y
>> # end of Debug kernel data structures
>>
>> # CONFIG_DEBUG_CREDENTIALS is not set
>>
>> #
>> # RCU Debugging
>> #
>> # CONFIG_RCU_SCALE_TEST is not set
>> # CONFIG_RCU_TORTURE_TEST is not set
>> # CONFIG_RCU_REF_SCALE_TEST is not set
>> CONFIG_RCU_CPU_STALL_TIMEOUT=60
>> # CONFIG_RCU_TRACE is not set
>> # CONFIG_RCU_EQS_DEBUG is not set
>> # end of RCU Debugging
>>
>> # CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
>> # CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
>> CONFIG_LATENCYTOP=y
>> CONFIG_USER_STACKTRACE_SUPPORT=y
>> CONFIG_NOP_TRACER=y
>> CONFIG_HAVE_FUNCTION_TRACER=y
>> CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
>> CONFIG_HAVE_DYNAMIC_FTRACE=y
>> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
>> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
>> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
>> CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
>> CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
>> CONFIG_HAVE_FENTRY=y
>> CONFIG_HAVE_OBJTOOL_MCOUNT=y
>> CONFIG_HAVE_C_RECORDMCOUNT=y
>> CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
>> CONFIG_BUILDTIME_MCOUNT_SORT=y
>> CONFIG_TRACER_MAX_TRACE=y
>> CONFIG_TRACE_CLOCK=y
>> CONFIG_RING_BUFFER=y
>> CONFIG_EVENT_TRACING=y
>> CONFIG_CONTEXT_SWITCH_TRACER=y
>> CONFIG_TRACING=y
>> CONFIG_GENERIC_TRACER=y
>> CONFIG_TRACING_SUPPORT=y
>> CONFIG_FTRACE=y
>> # CONFIG_BOOTTIME_TRACING is not set
>> CONFIG_FUNCTION_TRACER=y
>> CONFIG_FUNCTION_GRAPH_TRACER=y
>> CONFIG_DYNAMIC_FTRACE=y
>> CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
>> CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
>> CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
>> CONFIG_FUNCTION_PROFILER=y
>> CONFIG_STACK_TRACER=y
>> # CONFIG_IRQSOFF_TRACER is not set
>> CONFIG_SCHED_TRACER=y
>> CONFIG_HWLAT_TRACER=y
>> # CONFIG_OSNOISE_TRACER is not set
>> # CONFIG_TIMERLAT_TRACER is not set
>> # CONFIG_MMIOTRACE is not set
>> CONFIG_FTRACE_SYSCALLS=y
>> CONFIG_TRACER_SNAPSHOT=y
>> # CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
>> CONFIG_BRANCH_PROFILE_NONE=y
>> # CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
>> CONFIG_BLK_DEV_IO_TRACE=y
>> CONFIG_KPROBE_EVENTS=y
>> # CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
>> CONFIG_UPROBE_EVENTS=y
>> CONFIG_BPF_EVENTS=y
>> CONFIG_DYNAMIC_EVENTS=y
>> CONFIG_PROBE_EVENTS=y
>> # CONFIG_BPF_KPROBE_OVERRIDE is not set
>> CONFIG_FTRACE_MCOUNT_RECORD=y
>> CONFIG_FTRACE_MCOUNT_USE_CC=y
>> CONFIG_TRACING_MAP=y
>> CONFIG_SYNTH_EVENTS=y
>> CONFIG_HIST_TRIGGERS=y
>> # CONFIG_TRACE_EVENT_INJECT is not set
>> # CONFIG_TRACEPOINT_BENCHMARK is not set
>> CONFIG_RING_BUFFER_BENCHMARK=m
>> # CONFIG_TRACE_EVAL_MAP_FILE is not set
>> # CONFIG_FTRACE_RECORD_RECURSION is not set
>> # CONFIG_FTRACE_STARTUP_TEST is not set
>> # CONFIG_FTRACE_SORT_STARTUP_TEST is not set
>> # CONFIG_RING_BUFFER_STARTUP_TEST is not set
>> # CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
>> # CONFIG_PREEMPTIRQ_DELAY_TEST is not set
>> # CONFIG_SYNTH_EVENT_GEN_TEST is not set
>> # CONFIG_KPROBE_EVENT_GEN_TEST is not set
>> # CONFIG_HIST_TRIGGERS_DEBUG is not set
>> CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
>> # CONFIG_SAMPLES is not set
>> CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
>> CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
>> CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
>> CONFIG_STRICT_DEVMEM=y
>> # CONFIG_IO_STRICT_DEVMEM is not set
>>
>> #
>> # x86 Debugging
>> #
>> CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
>> CONFIG_EARLY_PRINTK_USB=y
>> CONFIG_X86_VERBOSE_BOOTUP=y
>> CONFIG_EARLY_PRINTK=y
>> CONFIG_EARLY_PRINTK_DBGP=y
>> CONFIG_EARLY_PRINTK_USB_XDBC=y
>> # CONFIG_EFI_PGT_DUMP is not set
>> # CONFIG_DEBUG_TLBFLUSH is not set
>> CONFIG_HAVE_MMIOTRACE_SUPPORT=y
>> # CONFIG_X86_DECODER_SELFTEST is not set
>> CONFIG_IO_DELAY_0X80=y
>> # CONFIG_IO_DELAY_0XED is not set
>> # CONFIG_IO_DELAY_UDELAY is not set
>> # CONFIG_IO_DELAY_NONE is not set
>> CONFIG_DEBUG_BOOT_PARAMS=y
>> # CONFIG_CPA_DEBUG is not set
>> # CONFIG_DEBUG_ENTRY is not set
>> # CONFIG_DEBUG_NMI_SELFTEST is not set
>> # CONFIG_X86_DEBUG_FPU is not set
>> # CONFIG_PUNIT_ATOM_DEBUG is not set
>> CONFIG_UNWINDER_ORC=y
>> # CONFIG_UNWINDER_FRAME_POINTER is not set
>> # end of x86 Debugging
>>
>> #
>> # Kernel Testing and Coverage
>> #
>> # CONFIG_KUNIT is not set
>> # CONFIG_NOTIFIER_ERROR_INJECTION is not set
>> CONFIG_FUNCTION_ERROR_INJECTION=y
>> # CONFIG_FAULT_INJECTION is not set
>> CONFIG_ARCH_HAS_KCOV=y
>> CONFIG_CC_HAS_SANCOV_TRACE_PC=y
>> # CONFIG_KCOV is not set
>> CONFIG_RUNTIME_TESTING_MENU=y
>> # CONFIG_LKDTM is not set
>> # CONFIG_TEST_MIN_HEAP is not set
>> # CONFIG_TEST_DIV64 is not set
>> # CONFIG_BACKTRACE_SELF_TEST is not set
>> # CONFIG_TEST_REF_TRACKER is not set
>> # CONFIG_RBTREE_TEST is not set
>> # CONFIG_REED_SOLOMON_TEST is not set
>> # CONFIG_INTERVAL_TREE_TEST is not set
>> # CONFIG_PERCPU_TEST is not set
>> # CONFIG_ATOMIC64_SELFTEST is not set
>> # CONFIG_ASYNC_RAID6_TEST is not set
>> # CONFIG_TEST_HEXDUMP is not set
>> # CONFIG_STRING_SELFTEST is not set
>> # CONFIG_TEST_STRING_HELPERS is not set
>> # CONFIG_TEST_STRSCPY is not set
>> # CONFIG_TEST_KSTRTOX is not set
>> # CONFIG_TEST_PRINTF is not set
>> # CONFIG_TEST_SCANF is not set
>> # CONFIG_TEST_BITMAP is not set
>> # CONFIG_TEST_UUID is not set
>> # CONFIG_TEST_XARRAY is not set
>> # CONFIG_TEST_OVERFLOW is not set
>> # CONFIG_TEST_RHASHTABLE is not set
>> # CONFIG_TEST_SIPHASH is not set
>> # CONFIG_TEST_IDA is not set
>> # CONFIG_TEST_LKM is not set
>> # CONFIG_TEST_BITOPS is not set
>> # CONFIG_TEST_VMALLOC is not set
>> # CONFIG_TEST_USER_COPY is not set
>> # CONFIG_TEST_BPF is not set
>> # CONFIG_TEST_BLACKHOLE_DEV is not set
>> # CONFIG_FIND_BIT_BENCHMARK is not set
>> # CONFIG_TEST_FIRMWARE is not set
>> # CONFIG_TEST_SYSCTL is not set
>> # CONFIG_TEST_UDELAY is not set
>> # CONFIG_TEST_STATIC_KEYS is not set
>> # CONFIG_TEST_KMOD is not set
>> # CONFIG_TEST_MEMCAT_P is not set
>> # CONFIG_TEST_LIVEPATCH is not set
>> # CONFIG_TEST_STACKINIT is not set
>> # CONFIG_TEST_MEMINIT is not set
>> # CONFIG_TEST_HMM is not set
>> # CONFIG_TEST_FREE_PAGES is not set
>> # CONFIG_TEST_FPU is not set
>> # CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
>> CONFIG_ARCH_USE_MEMTEST=y
>> # CONFIG_MEMTEST is not set
>> # end of Kernel Testing and Coverage
>> # end of Kernel hacking
> 
>> #!/bin/sh
>>
>> export_top_env()
>> {
>> 	export suite='fio-basic'
>> 	export testcase='fio-basic'
>> 	export category='benchmark'
>> 	export runtime=200
>> 	export nr_task=48
>> 	export time_based='tb'
>> 	export job_origin='fio-basic-2pmem-256G.yaml'
>> 	export queue_cmdline_keys='branch
>> commit'
>> 	export queue='validate'
>> 	export testbox='lkp-csl-2sp7'
>> 	export tbox_group='lkp-csl-2sp7'
>> 	export kconfig='x86_64-rhel-8.3'
>> 	export submit_id='625b59ae51c8127c87623bd0'
>> 	export job_file='/lkp/jobs/scheduled/lkp-csl-2sp7/fio-basic-2M-performance-2pmem-xfs-sync-50%-200s-read-200G-tb-ucode=0x500320a-debian-10.4-x86_64-20200603.cgz-793917d997df2e432f-20220417-31879-iiyjii-4.yaml'
>> 	export id='8abf80605d459344a98ae4d07a60a1716e0c86dd'
>> 	export queuer_version='/zday/lkp'
>> 	export model='Cascade Lake'
>> 	export nr_node=2
>> 	export nr_cpu=96
>> 	export memory='512G'
>> 	export nr_hdd_partitions=1
>> 	export nr_ssd_partitions=1
>> 	export hdd_partitions='/dev/disk/by-id/ata-ST1000NM0055-1V410C_ZBS1K5E0-part1'
>> 	export ssd_partitions='/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL4204000G800RGN-part1'
>> 	export swap_partitions=
>> 	export rootfs_partition='/dev/disk/by-id/ata-ST1000NM0055-1V410C_ZBS1K5E0-part2'
>> 	export brand='Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz'
>> 	export need_kconfig='LIBNVDIMM
>> BTT
>> BLK_DEV_PMEM
>> X86_PMEM_LEGACY
>> XFS_FS'
>> 	export commit='793917d997df2e432f3e9ac126e4482d68256d01'
>> 	export ucode='0x500320a'
>> 	export need_kconfig_hw='{"I40E"=>"y"}
>> SATA_AHCI'
>> 	export bisect_dmesg=true
>> 	export enqueue_time='2022-04-17 08:05:03 +0800'
>> 	export _id='625b59af51c8127c87623bd1'
>> 	export _rt='/result/fio-basic/2M-performance-2pmem-xfs-sync-50%-200s-read-200G-tb-ucode=0x500320a/lkp-csl-2sp7/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-11/793917d997df2e432f3e9ac126e4482d68256d01'
>> 	export user='lkp'
>> 	export compiler='gcc-11'
>> 	export LKP_SERVER='internal-lkp-server'
>> 	export head_commit='5fa5e911d842a595c8b48add5e7e7279277ab764'
>> 	export base_commit='ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e'
>> 	export branch='linus/master'
>> 	export rootfs='debian-10.4-x86_64-20200603.cgz'
>> 	export result_root='/result/fio-basic/2M-performance-2pmem-xfs-sync-50%-200s-read-200G-tb-ucode=0x500320a/lkp-csl-2sp7/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-11/793917d997df2e432f3e9ac126e4482d68256d01/3'
>> 	export scheduler_version='/lkp/lkp/.src-20220415-153857'
>> 	export arch='x86_64'
>> 	export max_uptime=2100
>> 	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
>> 	export bootloader_append='root=/dev/ram0
>> RESULT_ROOT=/result/fio-basic/2M-performance-2pmem-xfs-sync-50%-200s-read-200G-tb-ucode=0x500320a/lkp-csl-2sp7/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-11/793917d997df2e432f3e9ac126e4482d68256d01/3
>> BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-11/793917d997df2e432f3e9ac126e4482d68256d01/vmlinuz-5.17.0-rc4-00163-g793917d997df
>> branch=linus/master
>> job=/lkp/jobs/scheduled/lkp-csl-2sp7/fio-basic-2M-performance-2pmem-xfs-sync-50%-200s-read-200G-tb-ucode=0x500320a-debian-10.4-x86_64-20200603.cgz-793917d997df2e432f-20220417-31879-iiyjii-4.yaml
>> user=lkp
>> ARCH=x86_64
>> kconfig=x86_64-rhel-8.3
>> commit=793917d997df2e432f3e9ac126e4482d68256d01
>> memmap=104G!8G
>> memmap=104G!132G
>> max_uptime=2100
>> LKP_SERVER=internal-lkp-server
>> nokaslr
>> selinux=0
>> debug
>> apic=debug
>> sysrq_always_enabled
>> rcupdate.rcu_cpu_stall_timeout=100
>> net.ifnames=0
>> printk.devkmsg=on
>> panic=-1
>> softlockup_panic=1
>> nmi_watchdog=panic
>> oops=panic
>> load_ramdisk=2
>> prompt_ramdisk=0
>> drbd.minor_count=8
>> systemd.log_level=err
>> ignore_loglevel
>> console=tty0
>> earlyprintk=ttyS0,115200
>> console=ttyS0,115200
>> vga=normal
>> rw'
>> 	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-11/793917d997df2e432f3e9ac126e4482d68256d01/modules.cgz'
>> 	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20220105.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs_20210917.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fio_20220416.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/fio-x86_64-3.15-1_20220416.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/turbostat_20220316.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/turbostat-x86_64-56e337f2cf13-1_20220316.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20220416.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-90ea17a9e27b-1_20220416.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
>> 	export ucode_initrd='/osimage/ucode/intel-ucode-20220216.cgz'
>> 	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
>> 	export site='inn'
>> 	export LKP_CGI_PORT=80
>> 	export LKP_CIFS_PORT=139
>> 	export last_kernel='5.18.0-rc2'
>> 	export repeat_to=6
>> 	export schedule_notify_address=
>> 	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-11/793917d997df2e432f3e9ac126e4482d68256d01/vmlinuz-5.17.0-rc4-00163-g793917d997df'
>> 	export dequeue_time='2022-04-17 08:12:18 +0800'
>> 	export job_initrd='/lkp/jobs/scheduled/lkp-csl-2sp7/fio-basic-2M-performance-2pmem-xfs-sync-50%-200s-read-200G-tb-ucode=0x500320a-debian-10.4-x86_64-20200603.cgz-793917d997df2e432f-20220417-31879-iiyjii-4.cgz'
>>
>> 	[ -n "$LKP_SRC" ] ||
>> 	export LKP_SRC=/lkp/${user:-lkp}/src
>> }
>>
>> run_job()
>> {
>> 	echo $$ > $TMP/run-job.pid
>>
>> 	. $LKP_SRC/lib/http.sh
>> 	. $LKP_SRC/lib/job.sh
>> 	. $LKP_SRC/lib/env.sh
>>
>> 	export_top_env
>>
>> 	run_setup bp1_memmap='104G!8G' bp2_memmap='104G!132G' $LKP_SRC/setup/boot_params
>>
>> 	run_setup nr_pmem=2 $LKP_SRC/setup/disk
>>
>> 	run_setup fs='xfs' $LKP_SRC/setup/fs
>>
>> 	run_setup rw='read' bs='2M' ioengine='sync' test_size='200G' $LKP_SRC/setup/fio-setup-basic
>>
>> 	run_setup $LKP_SRC/setup/cpufreq_governor 'performance'
>>
>> 	run_monitor $LKP_SRC/monitors/wrapper kmsg
>> 	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
>> 	run_monitor $LKP_SRC/monitors/wrapper uptime
>> 	run_monitor $LKP_SRC/monitors/wrapper iostat
>> 	run_monitor $LKP_SRC/monitors/wrapper heartbeat
>> 	run_monitor $LKP_SRC/monitors/wrapper vmstat
>> 	run_monitor $LKP_SRC/monitors/wrapper numa-numastat
>> 	run_monitor $LKP_SRC/monitors/wrapper numa-vmstat
>> 	run_monitor $LKP_SRC/monitors/wrapper numa-meminfo
>> 	run_monitor $LKP_SRC/monitors/wrapper proc-vmstat
>> 	run_monitor $LKP_SRC/monitors/wrapper proc-stat
>> 	run_monitor $LKP_SRC/monitors/wrapper meminfo
>> 	run_monitor $LKP_SRC/monitors/wrapper slabinfo
>> 	run_monitor $LKP_SRC/monitors/wrapper interrupts
>> 	run_monitor $LKP_SRC/monitors/wrapper lock_stat
>> 	run_monitor lite_mode=1 $LKP_SRC/monitors/wrapper perf-sched
>> 	run_monitor $LKP_SRC/monitors/wrapper softirqs
>> 	run_monitor $LKP_SRC/monitors/one-shot/wrapper bdi_dev_mapping
>> 	run_monitor $LKP_SRC/monitors/wrapper diskstats
>> 	run_monitor $LKP_SRC/monitors/wrapper nfsstat
>> 	run_monitor $LKP_SRC/monitors/wrapper cpuidle
>> 	run_monitor $LKP_SRC/monitors/wrapper cpufreq-stats
>> 	run_monitor $LKP_SRC/monitors/wrapper turbostat
>> 	run_monitor $LKP_SRC/monitors/wrapper sched_debug
>> 	run_monitor $LKP_SRC/monitors/wrapper perf-stat
>> 	run_monitor $LKP_SRC/monitors/wrapper mpstat
>> 	run_monitor debug_mode=0 $LKP_SRC/monitors/no-stdout/wrapper perf-profile
>> 	run_monitor pmeter_server='lkp-serial03' pmeter_device='yokogawa-wt310' $LKP_SRC/monitors/wrapper pmeter
>> 	run_monitor $LKP_SRC/monitors/wrapper oom-killer
>> 	run_monitor $LKP_SRC/monitors/plain/watchdog
>>
>> 	run_test $LKP_SRC/tests/wrapper fio
>> }
>>
>> extract_stats()
>> {
>> 	export stats_part_begin=
>> 	export stats_part_end=
>>
>> 	$LKP_SRC/stats/wrapper fio
>> 	$LKP_SRC/stats/wrapper kmsg
>> 	$LKP_SRC/stats/wrapper boot-time
>> 	$LKP_SRC/stats/wrapper uptime
>> 	$LKP_SRC/stats/wrapper iostat
>> 	$LKP_SRC/stats/wrapper vmstat
>> 	$LKP_SRC/stats/wrapper numa-numastat
>> 	$LKP_SRC/stats/wrapper numa-vmstat
>> 	$LKP_SRC/stats/wrapper numa-meminfo
>> 	$LKP_SRC/stats/wrapper proc-vmstat
>> 	$LKP_SRC/stats/wrapper meminfo
>> 	$LKP_SRC/stats/wrapper slabinfo
>> 	$LKP_SRC/stats/wrapper interrupts
>> 	$LKP_SRC/stats/wrapper lock_stat
>> 	env lite_mode=1 $LKP_SRC/stats/wrapper perf-sched
>> 	$LKP_SRC/stats/wrapper softirqs
>> 	$LKP_SRC/stats/wrapper diskstats
>> 	$LKP_SRC/stats/wrapper nfsstat
>> 	$LKP_SRC/stats/wrapper cpuidle
>> 	$LKP_SRC/stats/wrapper turbostat
>> 	$LKP_SRC/stats/wrapper sched_debug
>> 	$LKP_SRC/stats/wrapper perf-stat
>> 	$LKP_SRC/stats/wrapper mpstat
>> 	env debug_mode=0 $LKP_SRC/stats/wrapper perf-profile
>> 	env pmeter_server='lkp-serial03' pmeter_device='yokogawa-wt310' $LKP_SRC/stats/wrapper pmeter
>>
>> 	$LKP_SRC/stats/wrapper time fio.time
>> 	$LKP_SRC/stats/wrapper dmesg
>> 	$LKP_SRC/stats/wrapper kmsg
>> 	$LKP_SRC/stats/wrapper last_state
>> 	$LKP_SRC/stats/wrapper stderr
>> 	$LKP_SRC/stats/wrapper time
>> }
>>
>> "$@"
> 
>> ---
>> :#! jobs/fio-basic-2pmem-256G.yaml:
>> suite: fio-basic
>> testcase: fio-basic
>> category: benchmark
>> boot_params:
>>   bp1_memmap: 104G!8G
>>   bp2_memmap: 104G!132G
>> disk: 2pmem
>> fs: xfs
>> runtime: 200s
>> nr_task: 50%
>> time_based: tb
>> fio-setup-basic:
>>   rw: read
>>   bs: 2M
>>   ioengine: sync
>>   test_size: 200G
>> fio:
>> job_origin: fio-basic-2pmem-256G.yaml
>> :#! queue options:
>> queue_cmdline_keys:
>> - branch
>> - commit
>> queue: bisect
>> testbox: lkp-csl-2sp7
>> tbox_group: lkp-csl-2sp7
>> kconfig: x86_64-rhel-8.3
>> submit_id: 625b4b8c51c8127ae7b26d12
>> job_file: "/lkp/jobs/scheduled/lkp-csl-2sp7/fio-basic-2M-performance-2pmem-xfs-sync-50%-200s-read-200G-tb-ucode=0x500320a-debian-10.4-x86_64-20200603.cgz-793917d997df2e432f-20220417-31463-x7t23q-1.yaml"
>> id: 9f5839063543acff7e4ea638fd66a81f8a516ead
>> queuer_version: "/zday/lkp"
>> :#! hosts/lkp-csl-2sp7:
>> model: Cascade Lake
>> nr_node: 2
>> nr_cpu: 96
>> memory: 512G
>> nr_hdd_partitions: 1
>> nr_ssd_partitions: 1
>> hdd_partitions: "/dev/disk/by-id/ata-ST1000NM0055-1V410C_ZBS1K5E0-part1"
>> ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL4204000G800RGN-part1"
>> swap_partitions:
>> rootfs_partition: "/dev/disk/by-id/ata-ST1000NM0055-1V410C_ZBS1K5E0-part2"
>> brand: Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz
>> :#! include/category/benchmark:
>> kmsg:
>> boot-time:
>> uptime:
>> iostat:
>> heartbeat:
>> vmstat:
>> numa-numastat:
>> numa-vmstat:
>> numa-meminfo:
>> proc-vmstat:
>> proc-stat:
>> meminfo:
>> slabinfo:
>> interrupts:
>> lock_stat:
>> perf-sched:
>>   lite_mode: 1
>> softirqs:
>> bdi_dev_mapping:
>> diskstats:
>> nfsstat:
>> cpuidle:
>> cpufreq-stats:
>> turbostat:
>> sched_debug:
>> perf-stat:
>> mpstat:
>> perf-profile:
>>   debug_mode: 0
>> :#! include/category/ALL:
>> cpufreq_governor: performance
>> :#! include/disk/nr_pmem:
>> need_kconfig:
>> - LIBNVDIMM
>> - BTT
>> - BLK_DEV_PMEM
>> - X86_PMEM_LEGACY
>> - XFS_FS
>> :#! include/queue/cyclic:
>> commit: 793917d997df2e432f3e9ac126e4482d68256d01
>> :#! include/testbox/lkp-csl-2sp7:
>> ucode: '0x500320a'
>> need_kconfig_hw:
>> - I40E: y
>> - SATA_AHCI
>> pmeter:
>>   pmeter_server: lkp-serial03
>>   pmeter_device: yokogawa-wt310
>> bisect_dmesg: true
>> :#! include/fs/OTHERS:
>> enqueue_time: 2022-04-17 07:04:44.782676356 +08:00
>> _id: 625b4b8c51c8127ae7b26d13
>> _rt: "/result/fio-basic/2M-performance-2pmem-xfs-sync-50%-200s-read-200G-tb-ucode=0x500320a/lkp-csl-2sp7/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-11/793917d997df2e432f3e9ac126e4482d68256d01"
>> :#! schedule options:
>> user: lkp
>> compiler: gcc-11
>> LKP_SERVER: internal-lkp-server
>> head_commit: 5fa5e911d842a595c8b48add5e7e7279277ab764
>> base_commit: ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e
>> branch: linus/master
>> rootfs: debian-10.4-x86_64-20200603.cgz
>> result_root: "/result/fio-basic/2M-performance-2pmem-xfs-sync-50%-200s-read-200G-tb-ucode=0x500320a/lkp-csl-2sp7/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-11/793917d997df2e432f3e9ac126e4482d68256d01/0"
>> scheduler_version: "/lkp/lkp/.src-20220415-153857"
>> arch: x86_64
>> max_uptime: 2100
>> initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
>> bootloader_append:
>> - root=/dev/ram0
>> - RESULT_ROOT=/result/fio-basic/2M-performance-2pmem-xfs-sync-50%-200s-read-200G-tb-ucode=0x500320a/lkp-csl-2sp7/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-11/793917d997df2e432f3e9ac126e4482d68256d01/0
>> - BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-11/793917d997df2e432f3e9ac126e4482d68256d01/vmlinuz-5.17.0-rc4-00163-g793917d997df
>> - branch=linus/master
>> - job=/lkp/jobs/scheduled/lkp-csl-2sp7/fio-basic-2M-performance-2pmem-xfs-sync-50%-200s-read-200G-tb-ucode=0x500320a-debian-10.4-x86_64-20200603.cgz-793917d997df2e432f-20220417-31463-x7t23q-1.yaml
>> - user=lkp
>> - ARCH=x86_64
>> - kconfig=x86_64-rhel-8.3
>> - commit=793917d997df2e432f3e9ac126e4482d68256d01
>> - memmap=104G!8G
>> - memmap=104G!132G
>> - max_uptime=2100
>> - LKP_SERVER=internal-lkp-server
>> - nokaslr
>> - selinux=0
>> - debug
>> - apic=debug
>> - sysrq_always_enabled
>> - rcupdate.rcu_cpu_stall_timeout=100
>> - net.ifnames=0
>> - printk.devkmsg=on
>> - panic=-1
>> - softlockup_panic=1
>> - nmi_watchdog=panic
>> - oops=panic
>> - load_ramdisk=2
>> - prompt_ramdisk=0
>> - drbd.minor_count=8
>> - systemd.log_level=err
>> - ignore_loglevel
>> - console=tty0
>> - earlyprintk=ttyS0,115200
>> - console=ttyS0,115200
>> - vga=normal
>> - rw
>> modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-11/793917d997df2e432f3e9ac126e4482d68256d01/modules.cgz"
>> bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20220105.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs_20210917.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fio_20220416.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/fio-x86_64-3.15-1_20220416.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/turbostat_20220316.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/turbostat-x86_64-56e337f2cf13-1_20220316.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20220416.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-90ea17a9e27b-1_20220416.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
>> ucode_initrd: "/osimage/ucode/intel-ucode-20220216.cgz"
>> lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
>> site: inn
>> :#! /cephfs/db/releases/20220411142827/lkp-src/include/site/inn:
>> LKP_CGI_PORT: 80
>> LKP_CIFS_PORT: 139
>> oom-killer:
>> watchdog:
>> :#! runtime status:
>> last_kernel: 5.18.0-rc2
>> :#! /cephfs/db/releases/20220412142511/lkp-src/include/site/inn:
>> repeat_to: 3
>> schedule_notify_address:
>> :#! user overrides:
>> kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-11/793917d997df2e432f3e9ac126e4482d68256d01/vmlinuz-5.17.0-rc4-00163-g793917d997df"
>> dequeue_time: 2022-04-17 07:16:24.889681764 +08:00
>> :#! /cephfs/db/releases/20220416203257/lkp-src/include/site/inn:
>> job_state: finished
>> loadavg: 39.85 23.36 9.60 1/776 12144
>> start_time: '1650151225'
>> end_time: '1650151426'
>> version: "/lkp/lkp/.src-20220415-153936:c7b8fcf9:f06178ed5"
> 
>>  "modprobe" "nd_e820"
>> dmsetup remove_all
>> wipefs -a --force /dev/pmem0
>> wipefs -a --force /dev/pmem1
>> mkfs -t xfs -f /dev/pmem0
>> mkfs -t xfs -f /dev/pmem1
>> mkdir -p /fs/pmem0
>> modprobe xfs
>> mount -t xfs -o inode64 /dev/pmem0 /fs/pmem0
>> mkdir -p /fs/pmem1
>> mount -t xfs -o inode64 /dev/pmem1 /fs/pmem1
>>
>> for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
>> do
>> 	online_file="$cpu_dir"/online
>> 	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue
>>
>> 	file="$cpu_dir"/cpufreq/scaling_governor
>> 	[ -f "$file" ] && echo "performance" > "$file"
>> done
>>
>> echo '
>> [global]
>> bs=2M
>> ioengine=sync
>> iodepth=32
>> size=4473924266
>> nr_files=1
>> filesize=4473924266
>> direct=0
>> runtime=200
>> invalidate=1
>> fallocate=posix
>> io_size=4473924266
>> file_service_type=roundrobin
>> random_distribution=random
>> group_reporting
>> pre_read=0
>>
>> time_based
>>
>> [task_0]
>> rw=read
>> directory=/fs/pmem0
>> numjobs=24
>>
>> [task_1]
>> rw=read
>> directory=/fs/pmem1
>> numjobs=24' | fio --output-format=json -
> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org
