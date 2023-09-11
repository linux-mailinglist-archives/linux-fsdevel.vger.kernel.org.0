Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5A179BF40
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 02:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242138AbjIKU5i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235387AbjIKIca (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:32:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050A3FB;
        Mon, 11 Sep 2023 01:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694421142; x=1725957142;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tKD8SyCZdgHxkIFuSqRJFyoIHi6hl6mQ5JAmkUr+qAo=;
  b=ATXZxPE8j3mvCMibRIrM7LBY5rYKNYAFMgpLHn9zjtdxYLP30e7i3Jom
   +e17pDjbrOQ/tX7w5d8Gk6GTs/TcKhawB3lafLY0aO9UiDzm7Rt959eZ5
   1oal8Wt3qmvfKW1Y0SkViqKq7Vg8vBWWR6oUaMXdJmBTgZuU+MI+XYJhV
   qzbgF7SO3CRPeKQvaUKj6eKlMnYx/0v4HgbqWSIixEJ3SC3oaB6v4b1oA
   v9L2QU9qaPhvTmh+1lscOhRPfBtkBbCy8lutirHBvt5MKFRZngLGUQdIi
   aszCBpidYQUnPnH3JfdwLPUef8df7uvwK8aQ5Iy+1UUEPUdi3WOxPVVVQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="442022077"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="442022077"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 01:32:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="693011834"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="693011834"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2023 01:32:19 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 01:32:18 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 01:32:17 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 01:32:17 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 01:32:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzBxYtqGuvN3YUFoh3FHvJLAL/6y/aERMTO01w2Bfl3zyJqfAwyUoNLnVvmUgLB/Xz8W/N3WGtePUEnOjnEP9P4faONhd6aibDpQbEybP0CUVw6pLgcCjnjn47i80HbIkm+fEYN8yoEDGRq7boy1nPN9l3ZW8aV5lNkZUV+rg4ScRS/o9UdRTWsBquwhNc5FEydbWeiZoSTH7DisyyoxHlC86JmYmpQPCmHc9bF7VyqcByszf9IxmA2Qr/ShldWo/LkkEvQ9KqR345X2Zv+xPNVZN6htwCwSlUefBccpraXm7s8RicvHiHkOTWVkSC94Yx5aBOgMshTg5FPlgfAq2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUXXZKPPqdJkfIdi71olkHKPQx5r2El1H9FYQte/QB8=;
 b=UM3Tqwva1jcf/toFH0Hyp1ZRsenlIeWUMfaRXCMno4Od71rx1ebacN228wMTGHfCXvIfx6A/Gu7GnV/fNmmDbPs77t/WiQAj7HeScOjKOIQUxo/HZBNDqEYC+8sXBnD2uI7Gdch3LJ9OsTJMQ/iQwgCoRjkawgSqlmxLNixdpeB9oMLdsvcDE8/kGFdlkMZ2d6rJ4igiAdKt07cIu+yuPH42rK32ApzMQLFa8zOyGlgRJNZA3rLfwtSVTjRIqGYLLM1bD4HlnoBgL5u+CCTCFKTuLikPAEmf1pQ2pFB6H9rW604JHY/Z/TF6nmiQncMdrHw2hf96NBv3+eO+usByAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SA2PR11MB4972.namprd11.prod.outlook.com (2603:10b6:806:fb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 08:32:11 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::2846:e5f8:b2e8:1da6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::2846:e5f8:b2e8:1da6%4]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 08:32:10 +0000
Message-ID: <2122b680-c1f0-e475-d978-dc26137faf1c@intel.com>
Date:   Mon, 11 Sep 2023 16:32:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [linus:master] [filemap] de74976eb6:
 stress-ng.bad-altstack.ops_per_sec -25.2% regression
Content-Language: en-US
To:     kernel test robot <oliver.sang@intel.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        <linux-fsdevel@vger.kernel.org>, <ying.huang@intel.com>,
        <feng.tang@intel.com>
References: <202309111556.b2aa3d7a-oliver.sang@intel.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <202309111556.b2aa3d7a-oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::18) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SA2PR11MB4972:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b160727-c6af-40cb-db00-08dbb2a1973e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U+lMBYfggVLcMU/N6eDm02kjuMzVCbkZ9BrJde2uZ6EP6NedBRtgZy1T+1ks2y6NwQE6C1Qjzx8azSPLMOeQPMe1hdyNQ9JK78Z1CgPu6e+ehIpINin007XE7OEsFCkpKEP99jgsPBnqHE+6AHKBDlgcXODBL/J7+lJODW4J+VRuTjHp5oynQQ4yIiHECDbbj+WbhWVTQ0dQq2HlXojz2xlB0lvh3fDbJ3waAKg3asrS/z3h8uLaeTJI5FTFfotZDsxJwjDtB/5eX6bVg1WnQHcZrjYw16feMqWX8Iay5lUgMd4eVmdHjXnp+NggUb2ryQAj9/iVkA0IMNBumtpWsVx8nQUbTnO+whwc5MmPUEvAhLkpvhlXjOXbRN37P37nrC/mQvXK5OMaKHA3csrDuHpCxP6HvtOnYitCG+pJ6LBL34tY3FxSiX2OrTkC/y4C8Vcu7mYdBnglxxGTxtbV8UUvp3KhtQm1XpFiNhIBGFM5pWnkAzxuEkuuI/uKQp64f+ouIOanBFBV+VNrqOr8NjM5zYpHshqWq5nXImp//HZrmTcCesxE1aPcow83AhJ7NqcvU+y/QLKLerYY/uBQQPA7R8czK63eOYbxXNfWwiIxY1bWKNLrr67bhRvhuMRnngOaXfL1yTTeYxEl45zHqYmwcl/X6sIKgzmJ19U4aeOSDXaG6HU5MxzUQRBDHkpQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199024)(1800799009)(186009)(4326008)(54906003)(37006003)(966005)(478600001)(316002)(6636002)(66476007)(6862004)(8676002)(66556008)(66946007)(5660300002)(41300700001)(31686004)(8936002)(30864003)(2906002)(83380400001)(82960400001)(38100700002)(26005)(86362001)(31696002)(107886003)(2616005)(36756003)(19627235002)(53546011)(6506007)(6512007)(6486002)(45980500001)(43740500002)(579004)(559001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2xxazFNL3h4eE90VUVuYk5kdjREWUxBS1NXTG9EVGJEOE14Z0ZnSnhGUlFX?=
 =?utf-8?B?RDFnSDBqc3hFR2c2Y01FclFybHE2NGZKUzh4L1FuWHdld1o2bHRIR0pxT1Zw?=
 =?utf-8?B?TWo3bzFvU1ZnaC9TYUJkM05tY3k0TE93RUdNa0tReldYS2pwcXNlNWhySW5r?=
 =?utf-8?B?MGZ6QVpyZkxLell3U2gyMjBlZnNkaHY3ZTM2alp0RGhFYWlnbXlGd2VZN1VW?=
 =?utf-8?B?bGtkam1rVjhBMGZyZEtqQnE1R0Z6dW85K2FoWTkrWGhRY0huNXFnTVhHNEVF?=
 =?utf-8?B?RG16Z0ZKNFFsb3lpcDVPU28rVEw1eFpUSnJJcnMwTVc2cGZIZzRhanRpdWdy?=
 =?utf-8?B?dXNPbXgzc2NXRHR1K0RIYUtzYzJaNmdPNG1iNkFqemFlTDYzTnBFZElMSUFl?=
 =?utf-8?B?U010MXUxOEowWS9Sd3dlTGdUSzBWdW5xWDNlWmpNN2x6RTJVZFdNam9ZalNp?=
 =?utf-8?B?Rm9HU1E4RGU5ZXY3MEVCc0JIOTN2R1lXOGlsdWorckZyZDRKaVNFWWw4MUVM?=
 =?utf-8?B?K1ZpS1RRd1NJMng2UjJuQnloV2dyWlVodmM5THlMUno3WnlxOUUvK05VUTdl?=
 =?utf-8?B?cjFXdHhGeWp2TmpwNGNDWE9qMnpwQUNVVjl1N042V0xGcUFoU2NSUm5HRkRz?=
 =?utf-8?B?bytYZnlVb2JlZ0NoZVBXYWhaalZvVTZGSHFMSjJMais5SmtrK1dwb1FqSXZ4?=
 =?utf-8?B?bTkwQ0w4dEFtbTVwZ25PMk4yZGsyTHM4UUkyVW1lSEFTejcyYjZGNUVmMWxQ?=
 =?utf-8?B?QWd2c21FK004a3hma0xIaEM3ZWpzWmNMY056aUJMcDBEVmZKUmtZQ1QrYUhY?=
 =?utf-8?B?aFQ3dG5TbTRyQVg3RU5iMDBFUUY5S3lqdHBQVzJGWFdKTjhpOC9sc1Z6Qm1D?=
 =?utf-8?B?UEcxc29ka2pmanRLQTBnb01wV3hMeXNqdG1PeW1RVG9CMjVZT2lhVWRFbTRC?=
 =?utf-8?B?SjhXMDVLbVlFNmpmQTlHcVFpaTdyVEUrekpZWmFuQnJUeWo3VEIyTTVJSER5?=
 =?utf-8?B?NHdCWEZ1bnBvZG1zZXIrS0hsT3pkWEZqcjZkMEUyWFlLQzVMaUxheHE3OHZh?=
 =?utf-8?B?RWFpOFFKMkZGZ0RTZnIzTEpyZ3RXZm82VEpVR3dNTE9rYkRLTWs1YXFvTkJn?=
 =?utf-8?B?THluMnlENWRZM0FaakhIc1MzVzFXaVZjOXl0YjJWRE1WSGVFNmdvbTFSUFVD?=
 =?utf-8?B?R3Ayc0lMckRpWmVCUUwzbncvaDBMbVZDV2x4bU9WeWxON05KMVlQZkc1dEFX?=
 =?utf-8?B?ZkIwaGR5TEMyR1dMRDVGSkZGazBySWx5RWVMVThYZDgxMFlqczl2cnBMZVUy?=
 =?utf-8?B?a0JNRjRuQmJuNzJJVHZ3a2ZyVW9ObTVxbzUwMy9YY1BKbnlHK0VRcXhyMzhD?=
 =?utf-8?B?c3ZHTG1BdWdoNkJoWmkwZVBpbDY3TnI5S3REWGJWZ05qdG40amtlSGdlUGxT?=
 =?utf-8?B?bHZHa1FMUElQREQxZXZvODUxcHFoQmNCZDB2TUF0OVMrVnlqU2dLVEQyZDY2?=
 =?utf-8?B?QmNlaWg4L3grQUkzWGdNUzNUbllYcGxZVjNML1IzQ1JiaEsycG53dDY2YVFI?=
 =?utf-8?B?UkNBb3prbGxWeXVMUVFNbnFMMU0zZlF1Y2FuZitIUmRtRm45QWxBaGtPL0R6?=
 =?utf-8?B?bzFoK0szdjQzdEtSMHU1YUVqdGRzTE5KWW5FVkVCck52QnFHeTlHR0NKazdK?=
 =?utf-8?B?L1Z0Yk5jc3pqNUQ3Mk1KZWpQQnZlOEo4VE5wVVhTeDM4U0orTE84Unhob2xV?=
 =?utf-8?B?SVV0Q0JscktyeGVEUk1KVm1wRkZmS1QxTHhJMnRnVmcybTNFaUlLcDE5RGo3?=
 =?utf-8?B?d2liWHVvcUNRdnJTeUp0bGtERDJscHEyK1RCOUdCemNrNXhQdCt1UWhQb2dw?=
 =?utf-8?B?S3c2M25nZXRUbTBqaUp5cDRhSkNkVjJSVW9Nb09tMmg3RlZPVnJlNG1RSGJZ?=
 =?utf-8?B?d3JSZFZRWkFjc0JUcU5NK2Q2NEVZNFgvSytIemp1V21KUlFZVlZjdjlRYUdD?=
 =?utf-8?B?eVZjbXl5OGVpc3ZwUjQwbkJHZXQ2Y3ZVRjkwbWdpNTBIcTZCblNVb3RBOGdP?=
 =?utf-8?B?eHNDL01mKytwSXo3QWQyY2xrbm5mdjlCMUlZRnV2Wld3Q2I4LzE2czBYNzhy?=
 =?utf-8?Q?JRA87Ue4E/LodG3XnSQjn9P62?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b160727-c6af-40cb-db00-08dbb2a1973e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 08:32:10.7646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c0evpzn0d/UbSlwPm4tL6vk7qvdarUM8YJ7c4y5k/Ql+W+qWTnhT0Wq+NtaDQzrmZ4Njil1IuYu592FLptzZsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4972
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/11/23 16:27, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a -25.2% regression of stress-ng.bad-altstack.ops_per_sec on:
> 
> 
> commit: de74976eb65151a2f568e477fc2e0032df5b22b4 ("filemap: add filemap_map_folio_range()")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> testcase: stress-ng
> test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
> parameters:
> 
> 	nr_threads: 100%
> 	testtime: 60s
> 	class: memory
> 	test: bad-altstack
> 	cpufreq_governor: performance
I will take a look at these regressions. Thanks.

> 
> 
> In addition to that, the commit also has significant impact on the following tests:
> 
> +------------------+---------------------------------------------------------------------------------------------+
> | testcase: change | stress-ng: stress-ng.fork.ops_per_sec -13.3% regression                                     |
> | test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory   |
> | test parameters  | class=pts                                                                                   |
> |                  | cpufreq_governor=performance                                                                |
> |                  | nr_threads=100%                                                                             |
> |                  | test=fork                                                                                   |
> |                  | testtime=60s                                                                                |
> +------------------+---------------------------------------------------------------------------------------------+
> | testcase: change | vm-scalability: vm-scalability.throughput -11.1% regression                                 |
> | test machine     | 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480L (Sapphire Rapids) with 512G memory    |
> | test parameters  | cpufreq_governor=performance                                                                |
> |                  | runtime=300s                                                                                |
> |                  | test=mmap-pread-rand                                                                        |
> +------------------+---------------------------------------------------------------------------------------------+
> | testcase: change | stress-ng: stress-ng.zombie.ops_per_sec -74.5% regression                                   |
> | test machine     | 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory |
> | test parameters  | class=scheduler                                                                             |
> |                  | cpufreq_governor=performance                                                                |
> |                  | nr_threads=100%                                                                             |
> |                  | sc_pid_max=4194304                                                                          |
> |                  | test=zombie                                                                                 |
> |                  | testtime=60s                                                                                |
> +------------------+---------------------------------------------------------------------------------------------+
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202309111556.b2aa3d7a-oliver.sang@intel.com
> 
> 
> Details are as below:
> -------------------------------------------------------------------------------------------------->
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20230911/202309111556.b2aa3d7a-oliver.sang@intel.com
> 
> =========================================================================================
> class/compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
>   memory/gcc-12/performance/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp8/bad-altstack/stress-ng/60s
> 
> commit: 
>   9f1f5b60e7 ("mm: use flush_icache_pages() in do_set_pmd()")
>   de74976eb6 ("filemap: add filemap_map_folio_range()")
> 
> 9f1f5b60e76d44fa de74976eb65151a2f568e477fc2 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>    5005804           -25.4%    3732280 ±  4%  cpuidle..usage
>     226369           -22.8%     174812 ±  5%  vmstat.system.cs
>     196009           -10.2%     176042 ±  3%  vmstat.system.in
>       1.35            -0.1        1.22 ±  2%  mpstat.cpu.all.irq%
>       0.67            -0.1        0.53 ±  5%  mpstat.cpu.all.soft%
>       3.69 ±  3%      -0.5        3.21 ±  5%  mpstat.cpu.all.usr%
>    4245150 ±  6%     -25.8%    3149301 ± 29%  numa-meminfo.node1.AnonPages
>    4945434 ±  4%     -26.2%    3647859 ± 26%  numa-meminfo.node1.Inactive
>    4945301 ±  4%     -26.2%    3647723 ± 26%  numa-meminfo.node1.Inactive(anon)
>   73394698 ±  2%     -28.1%   52759723 ±  9%  numa-numastat.node0.local_node
>   73440754 ±  2%     -28.1%   52810446 ±  9%  numa-numastat.node0.numa_hit
>   72370904 ±  2%     -29.3%   51147333 ±  9%  numa-numastat.node1.local_node
>   72404527 ±  2%     -29.3%   51170297 ±  9%  numa-numastat.node1.numa_hit
>    4842492 ±  2%     -14.5%    4141547 ±  4%  meminfo.AnonPages
>    7390687           -11.8%    6519765 ±  3%  meminfo.Committed_AS
>    5853448 ±  2%     -15.7%    4935195 ±  4%  meminfo.Inactive
>    5853245 ±  2%     -15.7%    4934992 ±  4%  meminfo.Inactive(anon)
>    1150839           -19.3%     928885 ±  3%  meminfo.Shmem
>    4978080           -25.8%    3694247 ±  4%  turbostat.C1
>       0.15           -24.4%       0.11 ±  4%  turbostat.IPC
>      25.82 ± 23%     -24.6        1.24 ± 94%  turbostat.PKG_%
>       9925          +106.7%      20517 ± 26%  turbostat.POLL
>     398.49            -4.0%     382.58        turbostat.PkgWatt
>     101.71           -12.3%      89.24        turbostat.RAMWatt
>   73443008 ±  2%     -28.1%   52812536 ±  9%  numa-vmstat.node0.numa_hit
>   73396953 ±  2%     -28.1%   52761813 ±  9%  numa-vmstat.node0.numa_local
>    1061960 ±  6%     -25.8%     787891 ± 29%  numa-vmstat.node1.nr_anon_pages
>    1237001 ±  4%     -26.2%     912544 ± 26%  numa-vmstat.node1.nr_inactive_anon
>    1236999 ±  4%     -26.2%     912542 ± 26%  numa-vmstat.node1.nr_zone_inactive_anon
>   72405504 ±  2%     -29.3%   51172088 ±  9%  numa-vmstat.node1.numa_hit
>   72371881 ±  2%     -29.3%   51149123 ±  9%  numa-vmstat.node1.numa_local
>    3878334           -25.2%    2899973 ±  3%  stress-ng.bad-altstack.ops
>      64637           -25.2%      48331 ±  3%  stress-ng.bad-altstack.ops_per_sec
>    1020183            -9.3%     924917 ±  3%  stress-ng.time.involuntary_context_switches
>      31629 ± 11%    +686.1%     248632 ± 19%  stress-ng.time.major_page_faults
>  1.775e+08 ±  2%     -23.0%  1.366e+08 ±  3%  stress-ng.time.minor_page_faults
>       5351            +1.0%       5407        stress-ng.time.percent_of_cpu_this_job_got
>       2175           +14.1%       2481 ±  2%  stress-ng.time.system_time
>       1152           -23.9%     877.35 ±  7%  stress-ng.time.user_time
>    6559992           -20.8%    5193194 ±  2%  stress-ng.time.voluntary_context_switches
>       4.50 ± 16%     -68.5%       1.42 ± 59%  sched_debug.cfs_rq:/.load_avg.min
>     610.20 ±  3%     -11.2%     541.92 ±  4%  sched_debug.cfs_rq:/.runnable_avg.avg
>     590.68 ±  3%     -11.0%     525.71 ±  4%  sched_debug.cfs_rq:/.util_avg.avg
>       1432 ±  7%     -15.5%       1210 ± 11%  sched_debug.cfs_rq:/.util_avg.max
>     118.53 ± 23%     -49.5%      59.82 ± 18%  sched_debug.cfs_rq:/.util_est_enqueued.avg
>     175.92 ± 13%     -30.6%     122.01 ± 10%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
>     402951 ±  5%     +20.2%     484486 ±  8%  sched_debug.cpu.avg_idle.avg
>    1848476           -25.3%    1381292 ±  3%  sched_debug.cpu.curr->pid.max
>     902123 ±  4%     -25.6%     671441 ±  4%  sched_debug.cpu.curr->pid.stddev
>     113163           -22.0%      88310 ±  4%  sched_debug.cpu.nr_switches.avg
>    1211031 ±  2%     -14.5%    1036001 ±  4%  proc-vmstat.nr_anon_pages
>     973846            -5.7%     918330        proc-vmstat.nr_file_pages
>    1463754 ±  2%     -15.7%    1234145 ±  4%  proc-vmstat.nr_inactive_anon
>       6642 ±  2%      -6.4%       6218        proc-vmstat.nr_page_table_pages
>     287748           -19.3%     232230 ±  3%  proc-vmstat.nr_shmem
>    1463754 ±  2%     -15.7%    1234145 ±  4%  proc-vmstat.nr_zone_inactive_anon
>  1.458e+08 ±  2%     -28.7%   1.04e+08 ±  4%  proc-vmstat.numa_hit
>  1.458e+08 ±  2%     -28.7%  1.039e+08 ±  4%  proc-vmstat.numa_local
>  1.538e+08 ±  2%     -28.6%  1.097e+08 ±  4%  proc-vmstat.pgalloc_normal
>  1.848e+08           -22.3%  1.436e+08 ±  3%  proc-vmstat.pgfault
>  1.488e+08 ±  2%     -28.3%  1.067e+08 ±  4%  proc-vmstat.pgfree
>    7485052           -24.2%    5673016 ±  3%  proc-vmstat.pgreuse
>      17.90            -6.9%      16.67        perf-stat.i.MPKI
>  1.884e+10           -27.2%  1.372e+10 ±  4%  perf-stat.i.branch-instructions
>       0.91            -0.0        0.87        perf-stat.i.branch-miss-rate%
>  1.627e+08           -30.5%   1.13e+08 ±  5%  perf-stat.i.branch-misses
>      27.37            -1.1       26.26        perf-stat.i.cache-miss-rate%
>  4.766e+08 ±  2%     -34.5%  3.123e+08 ±  6%  perf-stat.i.cache-misses
>  1.692e+09           -31.4%  1.161e+09 ±  5%  perf-stat.i.cache-references
>     241702           -23.6%     184568 ±  5%  perf-stat.i.context-switches
>       2.19           +35.9%       2.97 ±  2%  perf-stat.i.cpi
>      65598           -32.1%      44526 ±  7%  perf-stat.i.cpu-migrations
>     582.31 ±  5%     +33.0%     774.35 ±  3%  perf-stat.i.cycles-between-cache-misses
>   34494957 ±  6%     -21.2%   27167191 ±  9%  perf-stat.i.dTLB-load-misses
>  2.329e+10           -25.8%  1.729e+10 ±  4%  perf-stat.i.dTLB-loads
>   21905610 ±  4%     -22.9%   16890155 ±  8%  perf-stat.i.dTLB-store-misses
>  1.189e+10           -23.6%  9.089e+09 ±  4%  perf-stat.i.dTLB-stores
>  9.182e+10           -26.3%  6.764e+10 ±  4%  perf-stat.i.instructions
>       0.47 ±  2%     -23.1%       0.36 ±  3%  perf-stat.i.ipc
>     514.31 ± 12%    +717.4%       4204 ± 20%  perf-stat.i.major-faults
>       1254 ± 12%     +63.7%       2052 ±  3%  perf-stat.i.metric.K/sec
>     872.91           -26.1%     645.30 ±  4%  perf-stat.i.metric.M/sec
>    2910945 ±  2%     -23.2%    2235593 ±  4%  perf-stat.i.minor-faults
>      92.03            -0.8       91.22        perf-stat.i.node-load-miss-rate%
>    1.2e+08 ±  2%     -29.7%   84436459 ±  6%  perf-stat.i.node-load-misses
>    8939523 ±  5%     -19.6%    7184335 ±  7%  perf-stat.i.node-loads
>      55.38            -7.1       48.31        perf-stat.i.node-store-miss-rate%
>   76680149           -31.5%   52522811 ±  5%  perf-stat.i.node-store-misses
>   59789508            -9.3%   54216942 ±  6%  perf-stat.i.node-stores
>    3063984 ±  2%     -23.2%    2352460 ±  4%  perf-stat.i.page-faults
>      18.25            -6.4%      17.08        perf-stat.overall.MPKI
>       0.85            -0.0        0.81        perf-stat.overall.branch-miss-rate%
>      28.13            -1.2       26.92        perf-stat.overall.cache-miss-rate%
>       2.21           +34.6%       2.97 ±  2%  perf-stat.overall.cpi
>     430.75 ±  2%     +50.4%     647.65 ±  4%  perf-stat.overall.cycles-between-cache-misses
>       0.45           -25.6%       0.34 ±  2%  perf-stat.overall.ipc
>      56.77            -6.8       49.96        perf-stat.overall.node-store-miss-rate%
>  1.835e+10           -26.0%  1.357e+10 ±  3%  perf-stat.ps.branch-instructions
>  1.562e+08           -29.2%  1.105e+08 ±  5%  perf-stat.ps.branch-misses
>  4.587e+08 ±  2%     -32.9%  3.076e+08 ±  5%  perf-stat.ps.cache-misses
>  1.631e+09           -29.9%  1.142e+09 ±  4%  perf-stat.ps.cache-references
>     230601           -22.4%     179055 ±  4%  perf-stat.ps.context-switches
>      62819           -32.0%      42714 ±  7%  perf-stat.ps.cpu-migrations
>   34685174 ±  5%     -20.9%   27444426 ±  9%  perf-stat.ps.dTLB-load-misses
>  2.269e+10           -24.6%  1.711e+10 ±  3%  perf-stat.ps.dTLB-loads
>   21412527 ±  4%     -21.8%   16743593 ±  8%  perf-stat.ps.dTLB-store-misses
>   1.16e+10           -22.4%  8.999e+09 ±  3%  perf-stat.ps.dTLB-stores
>  8.935e+10           -25.2%  6.687e+10 ±  3%  perf-stat.ps.instructions
>     494.42 ± 12%    +691.7%       3914 ± 20%  perf-stat.ps.major-faults
>    2841237 ±  2%     -22.1%    2214148 ±  3%  perf-stat.ps.minor-faults
>  1.158e+08 ±  2%     -28.5%   82760390 ±  5%  perf-stat.ps.node-load-misses
>    9347688 ±  6%     -19.6%    7516467 ±  9%  perf-stat.ps.node-loads
>   75112388           -30.5%   52227314 ±  5%  perf-stat.ps.node-store-misses
>   57203372            -8.5%   52340890 ±  5%  perf-stat.ps.node-stores
>    2990035 ±  2%     -22.1%    2329223 ±  3%  perf-stat.ps.page-faults
>  5.556e+12 ±  2%     -24.1%  4.214e+12 ±  2%  perf-stat.total.instructions
>       0.03 ± 10%     -34.1%       0.02 ± 15%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages.pte_alloc_one.do_read_fault.do_fault
>       0.03 ± 11%     -30.4%       0.02 ± 31%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.single_open.do_dentry_open
>       0.02 ±  2%     -26.6%       0.02 ±  8%  perf-sched.sch_delay.avg.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
>       0.02 ±  3%     -26.9%       0.02 ± 11%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
>       0.03 ±  5%     -29.2%       0.02 ± 16%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
>       0.02 ±  5%     -22.9%       0.02 ± 12%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.unlink_file_vma.free_pgtables.exit_mmap
>       0.03 ± 21%     -35.3%       0.02 ± 23%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.path_put.exit_fs.do_exit
>       0.03 ±  7%     -35.0%       0.02 ± 23%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.step_into.open_last_lookups.path_openat
>       0.03 ± 15%     -26.3%       0.02 ± 15%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
>       0.03 ±  2%     -32.4%       0.02 ± 13%  perf-sched.sch_delay.avg.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
>       0.03 ± 11%     -28.8%       0.02 ± 10%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.alloc_empty_file.path_openat.do_filp_open
>       0.02 ±  5%     -13.3%       0.02 ±  2%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.anon_vma_fork.dup_mmap.dup_mm
>       0.02 ± 17%     -52.2%       0.01 ± 13%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.dup_mm.constprop.0
>       0.04 ± 30%     -49.8%       0.02 ± 17%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.security_file_alloc.init_file.alloc_empty_file
>       0.02 ±105%     -89.8%       0.00 ±142%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_node.alloc_vmap_area.__get_vm_area_node.__vmalloc_node_range
>       0.04 ±  4%     -26.8%       0.03 ±  7%  perf-sched.sch_delay.avg.ms.__cond_resched.lock_mm_and_find_vma.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
>       0.03 ± 16%     -38.5%       0.02 ± 33%  perf-sched.sch_delay.avg.ms.__cond_resched.mnt_want_write.open_last_lookups.path_openat.do_filp_open
>       0.05 ± 86%     -79.8%       0.01 ± 95%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.__fdget_pos.ksys_write.do_syscall_64
>       0.03 ± 14%     -31.2%       0.02 ± 25%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.futex_exit_release.exit_mm_release.exit_mm
>       0.03 ±  7%     -24.5%       0.02 ± 13%  perf-sched.sch_delay.avg.ms.__cond_resched.put_files_struct.do_exit.do_group_exit.get_signal
>       0.03 ±  7%     -40.7%       0.02 ± 26%  perf-sched.sch_delay.avg.ms.__cond_resched.remove_vma.exit_mmap.__mmput.exit_mm
>       0.04 ± 24%     -46.2%       0.02 ± 27%  perf-sched.sch_delay.avg.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
>       0.03 ±  2%     -32.6%       0.02 ± 12%  perf-sched.sch_delay.avg.ms.__cond_resched.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
>       0.03 ±  2%     -33.1%       0.02 ± 11%  perf-sched.sch_delay.avg.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
>       0.03           -46.2%       0.01 ± 11%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
>       0.02           -11.1%       0.02 ±  3%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
>       0.03           -24.7%       0.02 ±  8%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
>       0.04 ±  8%     -45.0%       0.02 ± 15%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
>       0.02 ±  4%     -27.0%       0.02 ± 10%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
>       0.03 ±  5%     -41.6%       0.02 ± 17%  perf-sched.sch_delay.avg.ms.io_schedule.folio_wait_bit_common.__do_fault.do_read_fault
>       0.04 ±  9%     -47.1%       0.02 ± 12%  perf-sched.sch_delay.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
>       0.69 ± 10%     +39.0%       0.96 ± 10%  perf-sched.sch_delay.max.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
>       1.30 ±108%     -85.6%       0.19 ± 19%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.anon_vma_clone.anon_vma_fork.dup_mmap
>       0.32 ± 18%     -92.3%       0.02 ± 19%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.dup_mm.constprop.0
>       1.66 ±101%     -82.8%       0.29 ± 24%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.dup_mmap.dup_mm
>       0.02 ± 94%     -90.6%       0.00 ±142%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_node.alloc_vmap_area.__get_vm_area_node.__vmalloc_node_range
>       0.55 ± 12%     -16.8%       0.46 ± 12%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.futex_exit_release.exit_mm_release.exit_mm
>       0.14 ± 51%     -58.5%       0.06 ± 71%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.ldt_dup_context.dup_mmap.dup_mm
>       0.41 ± 19%     -42.8%       0.24 ± 59%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.perf_event_exit_task.do_exit.do_group_exit
>       0.56 ± 14%     -41.6%       0.32 ± 29%  perf-sched.sch_delay.max.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
>       0.25 ± 24%     -69.9%       0.07 ± 66%  perf-sched.sch_delay.max.ms.__cond_resched.uprobe_start_dup_mmap.dup_mmap.dup_mm.constprop
>       3.72 ± 21%     -41.8%       2.16 ± 28%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
>       0.62 ±  8%     +77.7%       1.11 ±  9%  perf-sched.sch_delay.max.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
>       0.15 ± 64%     -70.6%       0.04 ± 56%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.dup_mmap
>       0.45 ± 13%     -30.1%       0.32 ± 21%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_file_vma
>       0.02           -27.5%       0.02 ±  5%  perf-sched.total_sch_delay.average.ms
>       1.56           +31.8%       2.06 ±  3%  perf-sched.total_wait_and_delay.average.ms
>     827124           -21.1%     652241 ±  3%  perf-sched.total_wait_and_delay.count.ms
>       1.54           +32.6%       2.04 ±  3%  perf-sched.total_wait_time.average.ms
>       0.59           +66.9%       0.98 ±  5%  perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
>     299.52 ±  5%      -8.5%     273.93 ±  3%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
>      41.36 ±  3%     +18.5%      49.03 ±  6%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
>      16.06 ±  2%     +30.9%      21.02 ±  3%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>       5.75           +28.4%       7.39 ±  3%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
>      12.67 ± 17%     -53.9%       5.83 ± 58%  perf-sched.wait_and_delay.count.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.shmem_alloc_folio
>       7866           -30.9%       5433 ±  9%  perf-sched.wait_and_delay.count.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
>       9011           -45.3%       4932 ± 10%  perf-sched.wait_and_delay.count.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
>      48.00 ± 15%     -24.7%      36.17 ± 17%  perf-sched.wait_and_delay.count.__cond_resched.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
>       8.33 ± 22%     -66.0%       2.83 ± 47%  perf-sched.wait_and_delay.count.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.generic_file_write_iter
>       9855           -57.4%       4200 ± 12%  perf-sched.wait_and_delay.count.__cond_resched.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
>       7774           -11.5%       6877 ±  4%  perf-sched.wait_and_delay.count.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
>     317531           -25.2%     237490 ±  4%  perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
>     318099           -25.2%     237911 ±  4%  perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
>      15702           +94.1%      30484 ±  2%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
>     233.17 ±  5%      +8.6%     253.33 ±  3%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
>     320.00 ±  3%     -11.0%     284.83 ±  9%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
>      37291           -22.1%      29068 ±  3%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>      56531           -21.9%      44128 ±  3%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
>       0.02 ±  9%     +75.2%       0.04 ± 16%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.wp_page_copy
>       0.57 ±  5%     +65.6%       0.95 ±  9%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.__get_free_pages.pgd_alloc.mm_init
>       0.57 ±  3%     +64.9%       0.94 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.__pmd_alloc.copy_p4d_range.copy_page_range
>       0.57 ±  7%     +68.7%       0.97 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.__pud_alloc.copy_p4d_range.copy_page_range
>       0.44 ± 45%     +79.5%       0.78 ± 13%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.allocate_slab.___slab_alloc.kmem_cache_alloc_node
>       0.58 ±  4%     +67.3%       0.98 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.pte_alloc_one.__pte_alloc.copy_pte_range
>       0.01 ± 11%     +79.5%       0.02 ± 19%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.pte_alloc_one.do_read_fault.do_fault
>       0.57           +57.0%       0.90 ± 16%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.security_task_alloc.copy_process
>       0.58 ±  5%     +65.1%       0.96 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc_node.__vmalloc_area_node.__vmalloc_node_range
>       0.57 ±  7%     +71.2%       0.97 ± 16%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc_node.memcg_alloc_slab_cgroups.allocate_slab
>       0.54 ± 10%     +86.7%       1.01 ± 11%  perf-sched.wait_time.avg.ms.__cond_resched.__mutex_lock.constprop.0.pcpu_alloc
>       0.02 ±  5%     +46.6%       0.03 ± 14%  perf-sched.wait_time.avg.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
>       0.57 ±  4%     +71.6%       0.98 ± 11%  perf-sched.wait_time.avg.ms.__cond_resched.__vmalloc_area_node.__vmalloc_node_range.alloc_thread_stack_node.dup_task_struct
>       0.60 ±  4%     +62.1%       0.97 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.cgroup_css_set_fork.cgroup_can_fork.copy_process.kernel_clone
>       0.58 ±  2%     +67.5%       0.97 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.copy_page_range.dup_mmap.dup_mm.constprop
>       0.58           +68.4%       0.97 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
>       0.59 ±  3%     +66.2%       0.98 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.dentry_kill.dput.proc_invalidate_siblings_dcache.release_task
>       0.03 ±  8%     +65.2%       0.05 ± 21%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.acct_collect.do_exit.do_group_exit
>       0.58 ±  2%     +67.4%       0.97 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.anon_vma_clone.anon_vma_fork.dup_mmap
>       0.58           +69.3%       0.99 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.anon_vma_fork.dup_mmap.dup_mm
>       0.58           +69.2%       0.98 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.dup_mmap.dup_mm.constprop
>       0.58          +195.7%       1.71 ± 97%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.dup_userfaultfd.dup_mmap.dup_mm
>       0.02 ±  3%     +40.0%       0.03 ± 13%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
>       0.02 ± 65%    +137.5%       0.05 ± 23%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect
>       0.02 ±  4%     +42.3%       0.03 ± 19%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.unlink_file_vma.free_pgtables.exit_mmap
>       0.02 ±  5%     +25.8%       0.03 ± 10%  perf-sched.wait_time.avg.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
>       0.61 ±  7%     +64.8%       1.00 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.alloc_pid.copy_process.kernel_clone
>       0.58           +69.6%       0.98 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.anon_vma_fork.dup_mmap.dup_mm
>       0.57 ±  4%     +73.5%       1.00 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.copy_fs_struct.copy_process.kernel_clone
>       0.56 ±  3%     +71.9%       0.96 ± 12%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.copy_sighand.copy_process.kernel_clone
>       0.57 ±  5%     +63.7%       0.93 ± 10%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.copy_signal.copy_process.kernel_clone
>       0.58 ±  4%     +64.6%       0.96 ±  9%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.dup_mm.constprop.0
>       0.57          +348.5%       2.57 ±140%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.prepare_creds.copy_creds.copy_process
>       0.58           +69.4%       0.98 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.dup_mmap.dup_mm
>       0.58 ±  6%     +82.1%       1.06 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_node.dup_task_struct.copy_process.kernel_clone
>       0.03 ±  6%     +42.6%       0.04 ± 19%  perf-sched.wait_time.avg.ms.__cond_resched.mmput.getrusage.__do_sys_getrusage.do_syscall_64
>       0.03 ± 20%     +55.3%       0.04 ± 25%  perf-sched.wait_time.avg.ms.__cond_resched.mnt_want_write.open_last_lookups.path_openat.do_filp_open
>       0.02 ± 13%     +43.4%       0.03 ± 10%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.futex_exit_release.exit_mm_release.exit_mm
>       0.57 ±  4%     +69.7%       0.97 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.ldt_dup_context.dup_mmap.dup_mm
>       0.58          +208.4%       1.78 ±100%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.__percpu_counter_init.mm_init
>       0.57 ±  2%     +71.2%       0.97 ±  9%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.mm_init.dup_mm
>       0.03 ± 27%     +58.2%       0.04 ± 15%  perf-sched.wait_time.avg.ms.__cond_resched.slab_pre_alloc_hook.constprop.0.kmem_cache_alloc_lru
>       0.58           +69.7%       0.98 ±  9%  perf-sched.wait_time.avg.ms.__cond_resched.uprobe_start_dup_mmap.dup_mmap.dup_mm.constprop
>       0.03 ±  9%     +38.6%       0.04 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
>       0.03 ±  3%    +134.6%       0.06 ± 92%  perf-sched.wait_time.avg.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
>       0.04           +21.2%       0.04 ±  3%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
>       0.57           +69.4%       0.96 ±  5%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
>       0.02 ±  4%     +18.1%       0.02 ±  6%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
>       0.01 ± 11%     +44.3%       0.01 ± 10%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.__do_fault.do_read_fault
>       0.01 ± 27%     +83.6%       0.02 ±  5%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
>     299.51 ±  5%      -8.5%     273.91 ±  3%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
>      41.36 ±  3%     +18.5%      49.03 ±  6%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
>       0.41 ±  2%     +74.7%       0.72 ± 11%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pcpu_alloc
>       0.27 ±  5%    +118.9%       0.60 ± 10%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.anon_vma_clone
>       0.27 ±  3%    +130.0%       0.61 ±  9%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.anon_vma_fork
>       0.36 ± 14%    +128.3%       0.83 ± 28%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.dup_mmap
>      16.04 ±  2%     +30.9%      20.99 ±  3%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>       5.73           +28.6%       7.37 ±  3%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
>       1.06 ± 11%     +38.4%       1.46 ± 10%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.wp_page_copy
>       1.05 ± 15%     +28.0%       1.35 ±  9%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.__get_free_pages.pgd_alloc.mm_init
>       0.92 ± 16%     +54.5%       1.42 ±  7%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.__pud_alloc.copy_p4d_range.copy_page_range
>       0.96 ±  8%     +46.0%       1.41 ± 12%  perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc_node.memcg_alloc_slab_cgroups.allocate_slab
>       0.75 ± 30%     +85.9%       1.39 ± 12%  perf-sched.wait_time.max.ms.__cond_resched.__mutex_lock.constprop.0.pcpu_alloc
>       1.07 ± 18%     +46.9%       1.57 ± 16%  perf-sched.wait_time.max.ms.__cond_resched.__vmalloc_area_node.__vmalloc_node_range.alloc_thread_stack_node.dup_task_struct
>       0.41 ±  7%     -39.3%       0.25 ± 46%  perf-sched.wait_time.max.ms.__cond_resched.down_read.exit_mmap.__mmput.exit_mm
>       1.28 ±  6%     +61.6%       2.07 ± 14%  perf-sched.wait_time.max.ms.__cond_resched.down_write.anon_vma_fork.dup_mmap.dup_mm
>       4.00 ± 25%     -44.6%       2.22 ± 10%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.anon_vma_fork.dup_mmap.dup_mm
>       0.85 ± 10%     +51.1%       1.29 ± 20%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.copy_sighand.copy_process.kernel_clone
>       0.98 ± 10%     +54.2%       1.52 ± 16%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.dup_mm.constprop.0
>       1.33 ±  7%  +12540.5%     168.29 ±221%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.prepare_creds.copy_creds.copy_process
>       0.96 ±  8%     +65.7%       1.59 ± 12%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_node.dup_task_struct.copy_process.kernel_clone
>       1.10 ± 12%     +40.3%       1.55 ± 10%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.ldt_dup_context.dup_mmap.dup_mm
>       1.44 ± 11%  +11607.0%     168.31 ±221%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.__percpu_counter_init.mm_init
>       1.13 ± 17%     +48.9%       1.68 ± 16%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.mm_init.dup_mm
>       1.18 ±  7%     +45.0%       1.72 ± 23%  perf-sched.wait_time.max.ms.__cond_resched.uprobe_start_dup_mmap.dup_mmap.dup_mm.constprop
>      39.25           -14.6       24.65 ±  5%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_fork
>      39.25           -14.6       24.65 ±  5%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
>      39.23           -14.6       24.64 ±  5%  perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
>      39.23           -14.6       24.64 ±  5%  perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
>      38.39           -14.3       24.05 ±  5%  perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      35.84           -13.6       22.28 ±  5%  perf-profile.calltrace.cycles-pp.dup_mm.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
>      41.72           -13.1       28.60 ±  4%  perf-profile.calltrace.cycles-pp.__libc_fork
>      35.34           -12.9       22.40 ±  4%  perf-profile.calltrace.cycles-pp.do_group_exit.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare
>      35.33           -12.9       22.40 ±  4%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop
>      35.78           -12.6       23.23 ±  4%  perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
>      35.54           -12.5       23.02 ±  4%  perf-profile.calltrace.cycles-pp.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode
>      34.76           -12.3       22.44 ±  4%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
>      34.76           -12.3       22.44 ±  4%  perf-profile.calltrace.cycles-pp.irqentry_exit_to_user_mode.asm_exc_page_fault
>      34.75           -12.3       22.43 ±  4%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
>      33.06           -12.3       20.80 ±  5%  perf-profile.calltrace.cycles-pp.dup_mmap.dup_mm.copy_process.kernel_clone.__do_sys_clone
>      32.78           -11.7       21.04 ±  4%  perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
>      32.59           -11.6       20.94 ±  4%  perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.get_signal
>      32.51           -11.6       20.87 ±  4%  perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.do_group_exit
>      17.35            -8.1        9.28 ±  6%  perf-profile.calltrace.cycles-pp.anon_vma_fork.dup_mmap.dup_mm.copy_process.kernel_clone
>      14.50            -6.0        8.51 ±  5%  perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.__mmput.exit_mm.do_exit
>      10.14            -4.6        5.59 ±  6%  perf-profile.calltrace.cycles-pp.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput.exit_mm
>      10.56            -4.5        6.04 ±  6%  perf-profile.calltrace.cycles-pp.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm.copy_process
>       4.98            -2.9        2.09 ± 10%  perf-profile.calltrace.cycles-pp.down_write.anon_vma_fork.dup_mmap.dup_mm.copy_process
>       4.78            -2.8        1.94 ± 10%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.anon_vma_fork.dup_mmap.dup_mm
>       4.65            -2.8        1.87 ± 10%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.anon_vma_fork.dup_mmap
>       9.00            -2.5        6.49 ±  4%  perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.__mmput.exit_mm.do_exit
>       8.45            -2.4        6.04 ±  4%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.__mmput.exit_mm
>       8.21            -2.3        5.86 ±  4%  perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap.__mmput
>       3.93            -2.3        1.64 ± 10%  perf-profile.calltrace.cycles-pp.down_write.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm
>       3.70            -2.3        1.45 ±  9%  perf-profile.calltrace.cycles-pp.down_write.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput
>       7.83            -2.2        5.60 ±  4%  perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap
>       3.30            -2.1        1.20 ± 10%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
>       3.50            -2.1        1.41 ± 10%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.anon_vma_clone.anon_vma_fork.dup_mmap
>       5.09 ±  2%      -2.0        3.04 ±  6%  perf-profile.calltrace.cycles-pp.tlb_finish_mmu.exit_mmap.__mmput.exit_mm.do_exit
>       5.04 ±  2%      -2.0        3.00 ±  6%  perf-profile.calltrace.cycles-pp.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput.exit_mm
>       3.38            -2.0        1.35 ± 10%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.anon_vma_clone.anon_vma_fork
>       3.16            -2.0        1.14 ± 10%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_anon_vmas.free_pgtables
>       2.79            -1.8        0.97 ± 12%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.anon_vma_fork
>       4.10 ±  3%      -1.7        2.42 ±  6%  perf-profile.calltrace.cycles-pp.release_pages.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
>       1.88            -1.5        0.39 ± 71%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_anon_vmas
>       1.85            -1.3        0.60 ± 12%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.anon_vma_clone
>       2.64            -1.2        1.39 ±  6%  perf-profile.calltrace.cycles-pp.mm_init.dup_mm.copy_process.kernel_clone.__do_sys_clone
>       3.64            -1.1        2.52 ±  4%  perf-profile.calltrace.cycles-pp.anon_vma_interval_tree_insert.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm
>       3.31            -1.1        2.25 ±  4%  perf-profile.calltrace.cycles-pp.vm_area_dup.dup_mmap.dup_mm.copy_process.kernel_clone
>       2.98            -1.0        1.94 ±  4%  perf-profile.calltrace.cycles-pp.wait4
>       2.92            -1.0        1.90 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.wait4
>       2.91            -1.0        1.89 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
>       2.88            -1.0        1.86 ±  4%  perf-profile.calltrace.cycles-pp.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
>       2.88            -1.0        1.86 ±  4%  perf-profile.calltrace.cycles-pp.kernel_wait4.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
>       3.92 ±  2%      -1.0        2.91 ±  3%  perf-profile.calltrace.cycles-pp.copy_page_range.dup_mmap.dup_mm.copy_process.kernel_clone
>       2.82            -1.0        1.82 ±  4%  perf-profile.calltrace.cycles-pp.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       1.90            -1.0        0.94 ±  7%  perf-profile.calltrace.cycles-pp.__percpu_counter_init.mm_init.dup_mm.copy_process.kernel_clone
>       3.73 ±  2%      -0.9        2.79 ±  3%  perf-profile.calltrace.cycles-pp.copy_p4d_range.copy_page_range.dup_mmap.dup_mm.copy_process
>       2.36 ±  5%      -0.9        1.45 ±  5%  perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.exit_mmap.__mmput.exit_mm
>       1.67            -0.9        0.81 ±  8%  perf-profile.calltrace.cycles-pp.pcpu_alloc.__percpu_counter_init.mm_init.dup_mm.copy_process
>       1.54            -0.9        0.69 ± 10%  perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.anon_vma_fork
>       3.13 ±  3%      -0.8        2.33 ±  3%  perf-profile.calltrace.cycles-pp.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap.dup_mm
>       1.83 ±  6%      -0.7        1.09 ±  8%  perf-profile.calltrace.cycles-pp._compound_head.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
>       1.60 ±  2%      -0.7        0.87 ±  6%  perf-profile.calltrace.cycles-pp.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput
>       2.32            -0.7        1.62 ±  4%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.vm_area_dup.dup_mmap.dup_mm.copy_process
>       1.26            -0.7        0.58 ± 10%  perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.anon_vma_clone
>       1.46 ±  6%      -0.7        0.80 ±  7%  perf-profile.calltrace.cycles-pp.down_write.unlink_file_vma.free_pgtables.exit_mmap.__mmput
>       1.92 ±  5%      -0.7        1.25 ±  6%  perf-profile.calltrace.cycles-pp.down_write.dup_mmap.dup_mm.copy_process.kernel_clone
>       1.48            -0.5        0.97 ±  5%  perf-profile.calltrace.cycles-pp.schedule.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
>       2.05            -0.5        1.55 ±  3%  perf-profile.calltrace.cycles-pp.mas_store.dup_mmap.dup_mm.copy_process.kernel_clone
>       1.47            -0.5        0.97 ±  5%  perf-profile.calltrace.cycles-pp.__schedule.schedule.do_wait.kernel_wait4.__do_sys_wait4
>       0.75            -0.5        0.26 ±100%  perf-profile.calltrace.cycles-pp.kmem_cache_free.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput
>       0.85            -0.5        0.36 ± 70%  perf-profile.calltrace.cycles-pp.free_swap_cache.free_pages_and_swap_cache.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap
>       1.38            -0.5        0.91 ±  3%  perf-profile.calltrace.cycles-pp.dup_task_struct.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
>       1.86 ±  2%      -0.5        1.39 ±  6%  perf-profile.calltrace.cycles-pp.copy_present_pte.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
>       1.12            -0.4        0.70 ±  4%  perf-profile.calltrace.cycles-pp.alloc_thread_stack_node.dup_task_struct.copy_process.kernel_clone.__do_sys_clone
>       1.18            -0.4        0.75 ±  5%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm.__libc_fork
>       1.13            -0.4        0.72 ±  5%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm.__libc_fork
>       0.67            -0.4        0.26 ±100%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
>       0.66            -0.4        0.26 ±100%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
>       1.11            -0.4        0.70 ±  5%  perf-profile.calltrace.cycles-pp.schedule_tail.ret_from_fork.ret_from_fork_asm.__libc_fork
>       2.78 ±  3%      -0.4        2.37 ±  3%  perf-profile.calltrace.cycles-pp.page_remove_rmap.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
>       1.23 ±  4%      -0.4        0.84 ±  4%  perf-profile.calltrace.cycles-pp.up_write.free_pgtables.exit_mmap.__mmput.exit_mm
>       1.21            -0.4        0.83 ±  7%  perf-profile.calltrace.cycles-pp.__anon_vma_interval_tree_remove.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput
>       1.22            -0.4        0.85 ±  4%  perf-profile.calltrace.cycles-pp.__vm_area_free.exit_mmap.__mmput.exit_mm.do_exit
>       1.14            -0.3        0.81 ±  4%  perf-profile.calltrace.cycles-pp.memcg_slab_post_alloc_hook.kmem_cache_alloc.vm_area_dup.dup_mmap.dup_mm
>       0.87            -0.3        0.54 ±  5%  perf-profile.calltrace.cycles-pp.free_pages_and_swap_cache.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
>       1.39            -0.3        1.07 ±  3%  perf-profile.calltrace.cycles-pp.up_write.dup_mmap.dup_mm.copy_process.kernel_clone
>       0.94            -0.3        0.66 ±  4%  perf-profile.calltrace.cycles-pp.wait_task_zombie.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
>       1.23            -0.3        0.96 ±  2%  perf-profile.calltrace.cycles-pp.mas_wr_bnode.mas_store.dup_mmap.dup_mm.copy_process
>       0.88            -0.3        0.61 ±  4%  perf-profile.calltrace.cycles-pp.release_task.wait_task_zombie.do_wait.kernel_wait4.__do_sys_wait4
>       1.09            -0.3        0.83 ±  3%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
>       1.07            -0.2        0.82 ±  3%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>       1.07            -0.2        0.82 ±  3%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>       1.07            -0.2        0.82 ±  3%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
>       0.80            -0.2        0.56 ±  4%  perf-profile.calltrace.cycles-pp.__schedule.do_task_dead.do_exit.do_group_exit.get_signal
>       0.81            -0.2        0.56 ±  4%  perf-profile.calltrace.cycles-pp.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
>       0.79            -0.2        0.54 ±  4%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.anon_vma_fork.dup_mmap.dup_mm.copy_process
>       0.82            -0.2        0.57 ±  6%  perf-profile.calltrace.cycles-pp.remove_vma.exit_mmap.__mmput.exit_mm.do_exit
>       0.89            -0.2        0.64 ±  5%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm
>       0.79            -0.2        0.55 ±  4%  perf-profile.calltrace.cycles-pp.wake_up_new_task.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       1.08            -0.2        0.84 ±  3%  perf-profile.calltrace.cycles-pp.mas_split.mas_wr_bnode.mas_store.dup_mmap.dup_mm
>       1.06            -0.2        0.83 ±  2%  perf-profile.calltrace.cycles-pp.irqentry_exit_to_user_mode.asm_exc_page_fault.stress_bad_altstack
>       1.06            -0.2        0.83 ±  2%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.stress_bad_altstack
>       1.06            -0.2        0.83 ±  2%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.stress_bad_altstack
>       1.00            -0.2        0.78 ±  3%  perf-profile.calltrace.cycles-pp.__slab_free.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput
>       1.05            -0.2        0.84        perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       1.05            -0.2        0.84        perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
>       1.11            -0.2        0.91        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
>       1.10            -0.2        0.90        perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
>       1.11            -0.2        0.91        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
>       1.10            -0.2        0.90        perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
>       0.77            -0.2        0.58 ±  4%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>       0.72 ±  3%      -0.2        0.54 ±  2%  perf-profile.calltrace.cycles-pp.vma_interval_tree_remove.unlink_file_vma.free_pgtables.exit_mmap.__mmput
>       1.14            -0.1        0.99        perf-profile.calltrace.cycles-pp.open64
>       0.73 ±  2%      -0.1        0.65 ±  6%  perf-profile.calltrace.cycles-pp.do_set_pte.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault
>       0.58            -0.1        0.53 ±  2%  perf-profile.calltrace.cycles-pp.__slab_free.exit_mmap.__mmput.exit_mm.do_exit
>       0.59 ±  2%      +0.1        0.67 ±  2%  perf-profile.calltrace.cycles-pp.dup_userfaultfd.dup_mmap.dup_mm.copy_process.kernel_clone
>       0.74 ± 19%      +0.3        1.00 ± 14%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.stress_mwc_reseed
>       0.74 ± 20%      +0.3        1.00 ± 14%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.stress_mwc_reseed
>       0.67 ± 20%      +0.3        0.95 ± 14%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.stress_mwc_reseed
>       1.06 ±  3%      +0.3        1.38 ± 30%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.stress_bad_altstack
>       0.98 ±  3%      +0.3        1.31 ± 31%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.stress_bad_altstack
>       0.84 ±  3%      +0.4        1.20 ± 34%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.stress_bad_altstack
>       0.09 ±223%      +0.6        0.74 ± 15%  perf-profile.calltrace.cycles-pp.shim_nanosleep_uint64
>       0.00            +0.7        0.66 ± 16%  perf-profile.calltrace.cycles-pp.__sigsetjmp@plt
>       1.22            +1.9        3.13 ±  4%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.__libc_fork
>       0.99            +2.0        2.97 ±  5%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.__libc_fork
>       1.00            +2.0        2.98 ±  5%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.__libc_fork
>       0.00            +2.0        1.98 ±  5%  perf-profile.calltrace.cycles-pp.next_uptodate_folio.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault
>       0.70            +2.0        2.70 ±  6%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
>       0.71 ±  2%      +2.0        2.71 ±  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__open64_nocancel
>       0.71 ±  2%      +2.0        2.71 ±  6%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
>       0.72 ±  2%      +2.0        2.72 ±  6%  perf-profile.calltrace.cycles-pp.__open64_nocancel
>       0.71            +2.0        2.71 ±  6%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
>       0.00            +2.0        2.02 ± 16%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.strlen@plt
>       0.80 ±  2%      +2.0        2.83 ±  5%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.__libc_fork
>       0.00            +2.0        2.04 ± 16%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.strlen@plt
>       0.00            +2.0        2.04 ± 16%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.strlen@plt
>       0.00            +2.1        2.05 ± 16%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.strlen@plt
>       0.52 ±  3%      +2.1        2.58 ±  6%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.__sigsetjmp
>       0.52 ±  2%      +2.1        2.58 ±  6%  perf-profile.calltrace.cycles-pp.__sigsetjmp
>       0.00            +2.1        2.06 ± 15%  perf-profile.calltrace.cycles-pp.strlen@plt
>       0.44 ± 44%      +2.1        2.56 ±  6%  perf-profile.calltrace.cycles-pp.setrlimit64
>       0.00            +2.4        2.37 ±  7%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.strncpy_from_user
>       0.00            +2.4        2.39 ±  7%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.strncpy_from_user.getname_flags.do_sys_openat2
>       0.00            +2.4        2.39 ±  7%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.strncpy_from_user.getname_flags
>       0.00            +2.4        2.40 ±  7%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.setrlimit64
>       0.00            +2.4        2.41 ±  7%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.strncpy_from_user.getname_flags.do_sys_openat2.__x64_sys_openat
>       0.00            +2.4        2.42 ±  7%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.setrlimit64
>       0.00            +2.4        2.42 ±  7%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.setrlimit64
>       0.00            +2.4        2.42 ±  7%  perf-profile.calltrace.cycles-pp.strncpy_from_user.getname_flags.do_sys_openat2.__x64_sys_openat.do_syscall_64
>       0.00            +2.4        2.43 ±  6%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.setrlimit64
>       0.00            +2.5        2.45 ±  7%  perf-profile.calltrace.cycles-pp.getname_flags.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.08 ±223%      +2.5        2.54 ±  6%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.__sigsetjmp
>       0.00            +2.5        2.50 ±  6%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.__sigsetjmp
>       0.00            +2.5        2.54 ±  6%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.__sigsetjmp
>      40.24            +2.6       42.88 ±  4%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
>       5.12 ±  4%     +15.0       20.17 ± 12%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
>       5.10 ±  4%     +15.1       20.16 ± 12%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
>       4.57 ±  4%     +15.2       19.75 ± 12%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
>       6.51 ±  3%     +32.7       39.16 ±  6%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
>       4.52 ±  4%     +33.2       37.68 ±  6%  perf-profile.calltrace.cycles-pp.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
>       4.54 ±  4%     +33.2       37.70 ±  6%  perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
>       3.95 ±  8%     +33.3       37.25 ±  6%  perf-profile.calltrace.cycles-pp.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
>      39.23           -14.6       24.64 ±  5%  perf-profile.children.cycles-pp.__do_sys_clone
>      39.23           -14.6       24.64 ±  5%  perf-profile.children.cycles-pp.kernel_clone
>      38.39           -14.3       24.05 ±  5%  perf-profile.children.cycles-pp.copy_process
>      45.65           -14.2       31.50 ±  3%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
>      45.61           -14.1       31.47 ±  3%  perf-profile.children.cycles-pp.do_syscall_64
>      35.84           -13.6       22.28 ±  5%  perf-profile.children.cycles-pp.dup_mm
>      41.88           -13.2       28.71 ±  4%  perf-profile.children.cycles-pp.__libc_fork
>      36.14           -12.6       23.54 ±  4%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
>      36.04           -12.6       23.46 ±  4%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
>      35.79           -12.6       23.23 ±  4%  perf-profile.children.cycles-pp.arch_do_signal_or_restart
>      35.86           -12.6       23.31 ±  4%  perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
>      35.54           -12.5       23.02 ±  4%  perf-profile.children.cycles-pp.get_signal
>      35.34           -12.5       22.85 ±  4%  perf-profile.children.cycles-pp.do_group_exit
>      35.34           -12.5       22.85 ±  4%  perf-profile.children.cycles-pp.do_exit
>      33.16           -12.3       20.87 ±  5%  perf-profile.children.cycles-pp.dup_mmap
>      32.83           -11.8       21.08 ±  4%  perf-profile.children.cycles-pp.exit_mm
>      32.60           -11.7       20.95 ±  4%  perf-profile.children.cycles-pp.__mmput
>      32.54           -11.6       20.89 ±  4%  perf-profile.children.cycles-pp.exit_mmap
>      17.56            -9.3        8.30 ±  7%  perf-profile.children.cycles-pp.down_write
>      13.98            -8.4        5.54 ±  9%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
>      13.39            -8.1        5.28 ±  9%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
>      17.36            -8.1        9.29 ±  7%  perf-profile.children.cycles-pp.anon_vma_fork
>      14.52            -6.0        8.52 ±  5%  perf-profile.children.cycles-pp.free_pgtables
>       8.49            -5.8        2.71 ± 12%  perf-profile.children.cycles-pp.osq_lock
>      10.17            -4.6        5.61 ±  6%  perf-profile.children.cycles-pp.unlink_anon_vmas
>      10.58            -4.5        6.05 ±  6%  perf-profile.children.cycles-pp.anon_vma_clone
>       9.02            -2.5        6.50 ±  4%  perf-profile.children.cycles-pp.unmap_vmas
>       4.42            -2.4        1.98 ±  8%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
>       8.47            -2.4        6.05 ±  4%  perf-profile.children.cycles-pp.unmap_page_range
>       8.23            -2.3        5.88 ±  4%  perf-profile.children.cycles-pp.zap_pmd_range
>       8.04            -2.3        5.75 ±  4%  perf-profile.children.cycles-pp.zap_pte_range
>       5.09 ±  2%      -2.0        3.05 ±  6%  perf-profile.children.cycles-pp.tlb_finish_mmu
>       5.04 ±  2%      -2.0        3.01 ±  6%  perf-profile.children.cycles-pp.tlb_batch_pages_flush
>       4.14 ±  3%      -1.7        2.45 ±  6%  perf-profile.children.cycles-pp.release_pages
>       2.31            -1.4        0.90 ± 10%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
>       4.43            -1.3        3.14 ±  4%  perf-profile.children.cycles-pp.kmem_cache_alloc
>       4.25            -1.3        2.99 ±  3%  perf-profile.children.cycles-pp.up_write
>       2.64            -1.2        1.40 ±  6%  perf-profile.children.cycles-pp.mm_init
>       2.26            -1.1        1.12 ±  6%  perf-profile.children.cycles-pp.pcpu_alloc
>       3.67            -1.1        2.54 ±  4%  perf-profile.children.cycles-pp.anon_vma_interval_tree_insert
>       3.33            -1.1        2.26 ±  5%  perf-profile.children.cycles-pp.vm_area_dup
>       2.98            -1.0        1.94 ±  4%  perf-profile.children.cycles-pp.wait4
>       2.66 ±  6%      -1.0        1.64 ±  8%  perf-profile.children.cycles-pp._compound_head
>       2.88            -1.0        1.87 ±  4%  perf-profile.children.cycles-pp.__do_sys_wait4
>       2.88            -1.0        1.86 ±  4%  perf-profile.children.cycles-pp.kernel_wait4
>       3.93 ±  2%      -1.0        2.92 ±  3%  perf-profile.children.cycles-pp.copy_page_range
>       2.82            -1.0        1.82 ±  4%  perf-profile.children.cycles-pp.do_wait
>       1.90            -1.0        0.95 ±  7%  perf-profile.children.cycles-pp.__percpu_counter_init
>       3.74 ±  2%      -0.9        2.79 ±  3%  perf-profile.children.cycles-pp.copy_p4d_range
>       2.38 ±  5%      -0.9        1.46 ±  5%  perf-profile.children.cycles-pp.unlink_file_vma
>       2.56            -0.8        1.75 ±  3%  perf-profile.children.cycles-pp.kmem_cache_free
>       3.14 ±  2%      -0.8        2.35 ±  3%  perf-profile.children.cycles-pp.copy_pte_range
>       2.69            -0.8        1.90 ±  4%  perf-profile.children.cycles-pp.__schedule
>       1.93            -0.8        1.16 ±  5%  perf-profile.children.cycles-pp.ret_from_fork_asm
>       1.88            -0.8        1.13 ±  6%  perf-profile.children.cycles-pp.ret_from_fork
>       1.61            -0.7        0.87 ±  6%  perf-profile.children.cycles-pp.__put_anon_vma
>       1.40 ±  2%      -0.7        0.72 ±  7%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
>       2.31            -0.7        1.64 ±  5%  perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
>       0.89 ±  3%      -0.7        0.24 ± 13%  perf-profile.children.cycles-pp.__mutex_lock
>       1.55            -0.6        0.93 ±  6%  perf-profile.children.cycles-pp.__mmdrop
>       1.66            -0.6        1.11 ±  4%  perf-profile.children.cycles-pp.mod_objcg_state
>       1.49            -0.5        0.94 ±  5%  perf-profile.children.cycles-pp.finish_task_switch
>       2.06            -0.5        1.56 ±  3%  perf-profile.children.cycles-pp.mas_store
>       2.44            -0.5        1.96 ±  3%  perf-profile.children.cycles-pp.__slab_free
>       1.60            -0.5        1.12 ±  4%  perf-profile.children.cycles-pp.schedule
>       2.10            -0.5        1.62 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock
>       1.89 ±  2%      -0.5        1.41 ±  6%  perf-profile.children.cycles-pp.copy_present_pte
>       1.38            -0.5        0.92 ±  3%  perf-profile.children.cycles-pp.dup_task_struct
>       1.44            -0.5        0.98 ±  4%  perf-profile.children.cycles-pp.pick_next_task_fair
>       1.34            -0.4        0.90 ±  5%  perf-profile.children.cycles-pp.newidle_balance
>       1.12            -0.4        0.70 ±  4%  perf-profile.children.cycles-pp.alloc_thread_stack_node
>       0.91 ±  2%      -0.4        0.48 ±  5%  perf-profile.children.cycles-pp.__vmalloc_node_range
>       1.24            -0.4        0.83 ±  5%  perf-profile.children.cycles-pp.load_balance
>       1.11            -0.4        0.70 ±  5%  perf-profile.children.cycles-pp.schedule_tail
>       2.82 ±  3%      -0.4        2.42 ±  2%  perf-profile.children.cycles-pp.page_remove_rmap
>       0.80 ±  2%      -0.4        0.41 ±  5%  perf-profile.children.cycles-pp.__get_vm_area_node
>       0.78 ±  2%      -0.4        0.39 ±  4%  perf-profile.children.cycles-pp.alloc_vmap_area
>       1.22 ±  2%      -0.4        0.84 ±  8%  perf-profile.children.cycles-pp.__anon_vma_interval_tree_remove
>       1.24            -0.4        0.86 ±  4%  perf-profile.children.cycles-pp.__vm_area_free
>       1.46 ±  3%      -0.4        1.10 ±  4%  perf-profile.children.cycles-pp.__alloc_pages
>       0.91            -0.3        0.57 ±  5%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
>       0.75 ±  2%      -0.3        0.41 ±  7%  perf-profile.children.cycles-pp.kthread
>       0.88            -0.3        0.54 ±  5%  perf-profile.children.cycles-pp.free_swap_cache
>       0.62            -0.3        0.30 ±  7%  perf-profile.children.cycles-pp.free_percpu
>       1.11            -0.3        0.80 ±  4%  perf-profile.children.cycles-pp.__do_softirq
>       0.56 ±  4%      -0.3        0.26 ±  3%  perf-profile.children.cycles-pp.__perf_sw_event
>       0.91            -0.3        0.60 ±  6%  perf-profile.children.cycles-pp.find_busiest_group
>       0.48 ±  2%      -0.3        0.18 ± 11%  perf-profile.children.cycles-pp.queued_write_lock_slowpath
>       0.90            -0.3        0.60 ±  5%  perf-profile.children.cycles-pp.update_sd_lb_stats
>       0.53 ±  4%      -0.3        0.23 ±  3%  perf-profile.children.cycles-pp.___perf_sw_event
>       0.99            -0.3        0.70 ±  5%  perf-profile.children.cycles-pp.rcu_core
>       0.96            -0.3        0.68 ±  5%  perf-profile.children.cycles-pp.rcu_do_batch
>       0.94            -0.3        0.66 ±  4%  perf-profile.children.cycles-pp.wait_task_zombie
>       0.57            -0.3        0.28 ±  6%  perf-profile.children.cycles-pp.percpu_counter_destroy
>       0.64 ± 12%      -0.3        0.36 ± 17%  perf-profile.children.cycles-pp.machine__process_fork_event
>       0.82            -0.3        0.54 ±  5%  perf-profile.children.cycles-pp.update_sg_lb_stats
>       0.88            -0.3        0.61 ±  4%  perf-profile.children.cycles-pp.release_task
>       1.23            -0.3        0.96 ±  2%  perf-profile.children.cycles-pp.mas_wr_bnode
>       1.34            -0.3        1.07        perf-profile.children.cycles-pp.do_filp_open
>       1.33            -0.3        1.07        perf-profile.children.cycles-pp.path_openat
>       0.92 ±  4%      -0.3        0.66 ±  4%  perf-profile.children.cycles-pp.get_page_from_freelist
>       1.09            -0.3        0.83 ±  3%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
>       1.09            -0.3        0.83 ±  3%  perf-profile.children.cycles-pp.cpu_startup_entry
>       0.79 ±  9%      -0.3        0.54 ± 14%  perf-profile.children.cycles-pp.perf_session__deliver_event
>       1.08            -0.3        0.83 ±  3%  perf-profile.children.cycles-pp.do_idle
>       0.81 ±  9%      -0.2        0.56 ± 13%  perf-profile.children.cycles-pp.perf_session__process_user_event
>       0.81 ±  9%      -0.2        0.56 ± 13%  perf-profile.children.cycles-pp.__ordered_events__flush
>       0.82            -0.2        0.58 ±  6%  perf-profile.children.cycles-pp.remove_vma
>       1.07            -0.2        0.82 ±  3%  perf-profile.children.cycles-pp.start_secondary
>       0.81            -0.2        0.56 ±  5%  perf-profile.children.cycles-pp.do_task_dead
>       0.79            -0.2        0.55 ±  4%  perf-profile.children.cycles-pp.wake_up_new_task
>       1.09            -0.2        0.85 ±  2%  perf-profile.children.cycles-pp.mas_split
>       0.41 ±  7%      -0.2        0.18 ± 14%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
>       0.69 ±  5%      -0.2        0.46 ±  6%  perf-profile.children.cycles-pp.osq_unlock
>       1.41            -0.2        1.18 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
>       1.37            -0.2        1.14 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
>       0.74            -0.2        0.52 ±  4%  perf-profile.children.cycles-pp.__cond_resched
>       0.72 ±  2%      -0.2        0.50 ±  5%  perf-profile.children.cycles-pp.mas_next_slot
>       0.81 ±  4%      -0.2        0.60 ±  7%  perf-profile.children.cycles-pp.pte_alloc_one
>       0.51 ±  4%      -0.2        0.30 ±  6%  perf-profile.children.cycles-pp.__rb_erase_color
>       0.81            -0.2        0.60 ±  3%  perf-profile.children.cycles-pp.lock_vma_under_rcu
>       0.73            -0.2        0.52 ±  6%  perf-profile.children.cycles-pp.fput
>       0.79            -0.2        0.59 ±  3%  perf-profile.children.cycles-pp.cpuidle_idle_call
>       0.68            -0.2        0.48 ±  5%  perf-profile.children.cycles-pp.select_task_rq_fair
>       0.68 ±  2%      -0.2        0.48 ±  4%  perf-profile.children.cycles-pp.mas_wr_store_entry
>       0.66            -0.2        0.46 ±  6%  perf-profile.children.cycles-pp.__percpu_counter_sum
>       0.32 ±  2%      -0.2        0.12 ±  8%  perf-profile.children.cycles-pp.queued_read_lock_slowpath
>       0.39 ±  5%      -0.2        0.20 ±  8%  perf-profile.children.cycles-pp.worker_thread
>       1.56            -0.2        1.37        perf-profile.children.cycles-pp.do_set_pte
>       0.50            -0.2        0.32 ±  6%  perf-profile.children.cycles-pp.exit_notify
>       0.68 ±  8%      -0.2        0.50 ± 10%  perf-profile.children.cycles-pp.__pte_alloc
>       0.35 ±  5%      -0.2        0.17 ±  9%  perf-profile.children.cycles-pp.process_one_work
>       0.57 ±  2%      -0.2        0.39 ±  4%  perf-profile.children.cycles-pp.percpu_counter_add_batch
>       0.54 ±  5%      -0.2        0.36 ±  5%  perf-profile.children.cycles-pp.clear_page_erms
>       0.53            -0.2        0.35 ±  5%  perf-profile.children.cycles-pp.__list_del_entry_valid
>       0.40 ± 13%      -0.2        0.22 ± 17%  perf-profile.children.cycles-pp.____machine__findnew_thread
>       0.56            -0.2        0.38 ±  5%  perf-profile.children.cycles-pp.find_idlest_cpu
>       0.80            -0.2        0.62 ±  3%  perf-profile.children.cycles-pp.__irq_exit_rcu
>       0.72 ±  3%      -0.2        0.55 ±  2%  perf-profile.children.cycles-pp.vma_interval_tree_remove
>       0.64            -0.2        0.46 ±  4%  perf-profile.children.cycles-pp.acpi_safe_halt
>       0.68            -0.2        0.51 ±  3%  perf-profile.children.cycles-pp.cpuidle_enter_state
>       0.68            -0.2        0.51 ±  4%  perf-profile.children.cycles-pp.cpuidle_enter
>       0.31 ±  5%      -0.2        0.14 ± 11%  perf-profile.children.cycles-pp.vfree
>       0.32 ±  5%      -0.2        0.15 ± 10%  perf-profile.children.cycles-pp.delayed_vfree_work
>       0.64            -0.2        0.47 ±  3%  perf-profile.children.cycles-pp.acpi_idle_enter
>       0.36 ±  3%      -0.2        0.20 ±  9%  perf-profile.children.cycles-pp.smpboot_thread_fn
>       1.15            -0.2        1.00        perf-profile.children.cycles-pp.open64
>       0.49            -0.2        0.34 ±  5%  perf-profile.children.cycles-pp.find_idlest_group
>       0.50            -0.1        0.35 ±  4%  perf-profile.children.cycles-pp.acct_collect
>       0.34 ±  2%      -0.1        0.19 ±  7%  perf-profile.children.cycles-pp.vma_interval_tree_insert_after
>       0.26 ±  7%      -0.1        0.12 ± 12%  perf-profile.children.cycles-pp.remove_vm_area
>       0.36 ±  5%      -0.1        0.21 ±  6%  perf-profile.children.cycles-pp.__rb_insert_augmented
>       0.33 ±  3%      -0.1        0.18 ± 10%  perf-profile.children.cycles-pp.run_ksoftirqd
>       0.49 ±  2%      -0.1        0.35 ±  4%  perf-profile.children.cycles-pp.___slab_alloc
>       0.62 ±  3%      -0.1        0.48 ±  5%  perf-profile.children.cycles-pp.link_path_walk
>       0.45            -0.1        0.32 ±  4%  perf-profile.children.cycles-pp.update_sg_wakeup_stats
>       0.22 ±  3%      -0.1        0.08 ± 11%  perf-profile.children.cycles-pp.mutex_spin_on_owner
>       0.54 ±  2%      -0.1        0.40 ±  3%  perf-profile.children.cycles-pp.sync_regs
>       0.44 ±  2%      -0.1        0.31 ±  4%  perf-profile.children.cycles-pp.mas_wr_append
>       0.42 ±  3%      -0.1        0.29 ±  5%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
>       0.47 ±  4%      -0.1        0.34 ±  6%  perf-profile.children.cycles-pp.walk_component
>       0.44 ±  2%      -0.1        0.32 ±  3%  perf-profile.children.cycles-pp.obj_cgroup_charge
>       0.19 ±  9%      -0.1        0.08 ± 12%  perf-profile.children.cycles-pp.find_unlink_vmap_area
>       0.28 ± 15%      -0.1        0.17 ± 20%  perf-profile.children.cycles-pp.nsinfo__new
>       0.28 ± 13%      -0.1        0.17 ± 17%  perf-profile.children.cycles-pp.thread__new
>       0.28 ± 14%      -0.1        0.16 ± 19%  perf-profile.children.cycles-pp.__xstat64
>       0.46            -0.1        0.35 ±  3%  perf-profile.children.cycles-pp.open_last_lookups
>       0.43 ±  2%      -0.1        0.32 ±  4%  perf-profile.children.cycles-pp.mas_push_data
>       0.34            -0.1        0.23 ±  3%  perf-profile.children.cycles-pp.dequeue_task_fair
>       0.36            -0.1        0.25 ±  5%  perf-profile.children.cycles-pp.mas_update_gap
>       0.26 ± 14%      -0.1        0.16 ± 18%  perf-profile.children.cycles-pp.__do_sys_newstat
>       0.34 ±  2%      -0.1        0.24 ±  5%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
>       0.48 ±  3%      -0.1        0.38 ±  6%  perf-profile.children.cycles-pp.__memcg_kmem_charge_page
>       0.26 ± 14%      -0.1        0.16 ± 17%  perf-profile.children.cycles-pp.vfs_fstatat
>       0.51            -0.1        0.41 ±  3%  perf-profile.children.cycles-pp.native_irq_return_iret
>       0.31 ±  3%      -0.1        0.21 ±  6%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
>       0.34 ±  3%      -0.1        0.24 ±  5%  perf-profile.children.cycles-pp.cgroup_rstat_updated
>       0.23 ± 13%      -0.1        0.13 ± 14%  perf-profile.children.cycles-pp.maps__clone
>       0.34 ±  2%      -0.1        0.24 ±  3%  perf-profile.children.cycles-pp._find_next_bit
>       0.35            -0.1        0.25 ±  4%  perf-profile.children.cycles-pp.update_load_avg
>       0.24 ± 14%      -0.1        0.14 ± 18%  perf-profile.children.cycles-pp.vfs_statx
>       0.30 ±  3%      -0.1        0.21 ±  5%  perf-profile.children.cycles-pp.memcg_account_kmem
>       0.43 ±  2%      -0.1        0.34 ±  3%  perf-profile.children.cycles-pp.proc_invalidate_siblings_dcache
>       0.35 ±  2%      -0.1        0.26 ±  3%  perf-profile.children.cycles-pp.mtree_range_walk
>       0.22 ± 15%      -0.1        0.13 ± 18%  perf-profile.children.cycles-pp.filename_lookup
>       0.32 ±  3%      -0.1        0.23 ±  6%  perf-profile.children.cycles-pp.__lookup_slow
>       0.28            -0.1        0.19 ±  5%  perf-profile.children.cycles-pp.__anon_vma_interval_tree_augment_rotate
>       0.22 ± 15%      -0.1        0.13 ± 18%  perf-profile.children.cycles-pp.path_lookupat
>       0.29 ±  2%      -0.1        0.21 ±  5%  perf-profile.children.cycles-pp.activate_task
>       0.29 ±  2%      -0.1        0.21 ±  7%  perf-profile.children.cycles-pp.refill_obj_stock
>       0.26            -0.1        0.18 ±  3%  perf-profile.children.cycles-pp.dequeue_entity
>       0.21 ±  3%      -0.1        0.13 ±  6%  perf-profile.children.cycles-pp.free_unref_page
>       0.37 ±  2%      -0.1        0.28 ±  3%  perf-profile.children.cycles-pp.rmqueue
>       0.28 ±  2%      -0.1        0.20 ±  5%  perf-profile.children.cycles-pp.enqueue_task_fair
>       0.32            -0.1        0.24 ±  2%  perf-profile.children.cycles-pp.lookup_open
>       0.36 ±  2%      -0.1        0.28 ±  3%  perf-profile.children.cycles-pp.__put_user_4
>       0.24            -0.1        0.16 ±  7%  perf-profile.children.cycles-pp.new_inode
>       0.26            -0.1        0.18 ±  6%  perf-profile.children.cycles-pp.proc_pid_make_inode
>       0.31 ±  2%      -0.1        0.24 ±  3%  perf-profile.children.cycles-pp.mas_walk
>       0.30 ±  5%      -0.1        0.22 ±  9%  perf-profile.children.cycles-pp.__wp_page_copy_user
>       0.16 ±  3%      -0.1        0.08 ±  8%  perf-profile.children.cycles-pp.free_pcppages_bulk
>       0.44            -0.1        0.36 ±  3%  perf-profile.children.cycles-pp.__nptl_set_robust
>       0.29 ±  5%      -0.1        0.22 ±  8%  perf-profile.children.cycles-pp.copy_mc_enhanced_fast_string
>       0.26 ±  3%      -0.1        0.19 ± 10%  perf-profile.children.cycles-pp.dput
>       0.24 ±  6%      -0.1        0.17 ±  5%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
>       0.30            -0.1        0.23 ±  3%  perf-profile.children.cycles-pp.__read_nocancel
>       0.18 ± 13%      -0.1        0.11 ± 21%  perf-profile.children.cycles-pp.__pud_alloc
>       0.25            -0.1        0.18 ±  3%  perf-profile.children.cycles-pp.sched_move_task
>       0.23 ±  2%      -0.1        0.16 ±  5%  perf-profile.children.cycles-pp.rcu_all_qs
>       0.18 ±  2%      -0.1        0.12 ±  8%  perf-profile.children.cycles-pp.__list_add_valid
>       0.30            -0.1        0.23 ±  4%  perf-profile.children.cycles-pp.put_cred_rcu
>       0.15 ±  6%      -0.1        0.08 ±  8%  perf-profile.children.cycles-pp.mark_page_accessed
>       0.30            -0.1        0.23 ±  2%  perf-profile.children.cycles-pp.ksys_read
>       0.29            -0.1        0.22 ±  3%  perf-profile.children.cycles-pp.vfs_read
>       0.23 ±  5%      -0.1        0.16 ±  5%  perf-profile.children.cycles-pp.__get_obj_cgroup_from_memcg
>       0.30            -0.1        0.23 ±  4%  perf-profile.children.cycles-pp.try_to_wake_up
>       0.29 ±  3%      -0.1        0.23 ±  4%  perf-profile.children.cycles-pp.__reclaim_stacks
>       0.30            -0.1        0.23 ±  4%  perf-profile.children.cycles-pp.down_read_trylock
>       0.22 ±  2%      -0.1        0.15 ±  7%  perf-profile.children.cycles-pp.cpu_util
>       0.26            -0.1        0.19 ±  3%  perf-profile.children.cycles-pp.seq_read_iter
>       0.22            -0.1        0.16 ±  4%  perf-profile.children.cycles-pp.d_alloc_parallel
>       0.21            -0.1        0.15 ±  6%  perf-profile.children.cycles-pp.enqueue_entity
>       0.21 ±  3%      -0.1        0.14 ±  8%  perf-profile.children.cycles-pp.folio_batch_move_lru
>       0.20            -0.1        0.14 ±  5%  perf-profile.children.cycles-pp.mas_leaf_max_gap
>       0.46 ±  2%      -0.1        0.40 ±  4%  perf-profile.children.cycles-pp.memset_orig
>       0.28            -0.1        0.22 ±  4%  perf-profile.children.cycles-pp.do_notify_parent
>       0.16 ±  3%      -0.1        0.11 ±  8%  perf-profile.children.cycles-pp.alloc_inode
>       0.16 ±  2%      -0.1        0.10 ±  4%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru
>       0.20            -0.1        0.14 ±  6%  perf-profile.children.cycles-pp.vm_normal_page
>       0.19            -0.1        0.13 ±  4%  perf-profile.children.cycles-pp.sysvec_call_function_single
>       0.20 ±  4%      -0.1        0.14 ±  6%  perf-profile.children.cycles-pp.lru_add_drain
>       0.20 ±  3%      -0.1        0.14 ±  8%  perf-profile.children.cycles-pp.lru_add_drain_cpu
>       0.17            -0.1        0.12 ±  6%  perf-profile.children.cycles-pp.d_alloc
>       0.26            -0.1        0.21 ±  5%  perf-profile.children.cycles-pp.__wake_up_common_lock
>       0.22 ±  2%      -0.1        0.16 ±  4%  perf-profile.children.cycles-pp.proc_pident_lookup
>       0.12 ±  4%      -0.1        0.07 ±  5%  perf-profile.children.cycles-pp.rmqueue_bulk
>       0.09 ± 12%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.maps__insert
>       0.20 ±  2%      -0.1        0.14 ±  6%  perf-profile.children.cycles-pp.__exit_signal
>       0.56            -0.1        0.51        perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
>       0.56            -0.1        0.50        perf-profile.children.cycles-pp.hrtimer_interrupt
>       0.17            -0.1        0.12 ±  5%  perf-profile.children.cycles-pp.proc_pident_instantiate
>       0.29 ±  2%      -0.1        0.24 ±  3%  perf-profile.children.cycles-pp.d_invalidate
>       0.22 ±  2%      -0.1        0.17 ±  5%  perf-profile.children.cycles-pp.mab_mas_cp
>       0.18 ±  2%      -0.1        0.13 ±  7%  perf-profile.children.cycles-pp.mast_fill_bnode
>       0.24            -0.0        0.19 ±  4%  perf-profile.children.cycles-pp.schedule_idle
>       0.20 ±  2%      -0.0        0.14 ±  5%  perf-profile.children.cycles-pp.pcpu_alloc_area
>       0.14 ±  3%      -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.mas_alloc_nodes
>       0.18 ±  2%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.loadavg_proc_show
>       0.15 ±  4%      -0.0        0.10 ±  8%  perf-profile.children.cycles-pp.__unfreeze_partials
>       0.26            -0.0        0.22 ±  5%  perf-profile.children.cycles-pp.__memcpy
>       0.22 ±  9%      -0.0        0.17 ±  4%  perf-profile.children.cycles-pp.__pmd_alloc
>       0.21 ±  3%      -0.0        0.16 ±  5%  perf-profile.children.cycles-pp.lookup_fast
>       0.11 ±  3%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.__free_one_page
>       0.14 ±  3%      -0.0        0.10 ±  7%  perf-profile.children.cycles-pp.mas_expected_entries
>       0.18 ±  2%      -0.0        0.14 ±  5%  perf-profile.children.cycles-pp.mas_split_final_node
>       0.51            -0.0        0.47        perf-profile.children.cycles-pp.__hrtimer_run_queues
>       0.13 ±  3%      -0.0        0.09 ±  8%  perf-profile.children.cycles-pp.__kmem_cache_alloc_bulk
>       0.26            -0.0        0.22 ±  4%  perf-profile.children.cycles-pp.shrink_dcache_parent
>       0.15 ±  2%      -0.0        0.10 ±  7%  perf-profile.children.cycles-pp.__tlb_remove_page_size
>       0.16 ±  3%      -0.0        0.11 ±  5%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
>       0.15 ±  4%      -0.0        0.11 ±  6%  perf-profile.children.cycles-pp.mas_find
>       0.14            -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.kmem_cache_alloc_bulk
>       0.19 ±  2%      -0.0        0.14 ±  4%  perf-profile.children.cycles-pp.update_curr
>       0.17 ±  2%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.prepare_creds
>       0.18 ±  6%      -0.0        0.14 ±  5%  perf-profile.children.cycles-pp.step_into
>       0.25            -0.0        0.20 ±  3%  perf-profile.children.cycles-pp.__wake_up_common
>       0.16 ±  2%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.__sysvec_call_function_single
>       0.11            -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.pcpu_free_area
>       0.07 ±  5%      -0.0        0.02 ± 99%  perf-profile.children.cycles-pp.uncharge_batch
>       0.07 ±  5%      -0.0        0.02 ± 99%  perf-profile.children.cycles-pp.__switch_to_asm
>       0.16 ±  4%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.free_pgd_range
>       0.08 ± 13%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.malloc
>       0.46            -0.0        0.42 ±  2%  perf-profile.children.cycles-pp.tick_sched_timer
>       0.08 ±  6%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.__d_lookup_rcu
>       0.21 ±  2%      -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_reschedule_ipi
>       0.07 ±  7%      -0.0        0.02 ± 99%  perf-profile.children.cycles-pp.switch_fpu_return
>       0.44            -0.0        0.40 ±  2%  perf-profile.children.cycles-pp.tick_sched_handle
>       0.44            -0.0        0.40        perf-profile.children.cycles-pp.update_process_times
>       0.20            -0.0        0.16 ±  4%  perf-profile.children.cycles-pp.__dentry_kill
>       0.14 ±  5%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.free_p4d_range
>       0.14 ±  5%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.free_pud_range
>       0.09 ±  5%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.rcu_cblist_dequeue
>       0.14 ±  3%      -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.sched_ttwu_pending
>       0.13 ±  3%      -0.0        0.09 ±  7%  perf-profile.children.cycles-pp.allocate_slab
>       0.17 ±  2%      -0.0        0.14 ±  5%  perf-profile.children.cycles-pp.proc_root_lookup
>       0.17 ±  2%      -0.0        0.14 ±  5%  perf-profile.children.cycles-pp.proc_pid_lookup
>       0.16 ±  2%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.perf_iterate_sb
>       0.11 ±  4%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.folio_mark_accessed
>       0.16 ±  2%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.ttwu_do_activate
>       0.13            -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.free_unref_page_list
>       0.11 ±  6%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.__vmalloc_area_node
>       0.06 ±  6%      -0.0        0.02 ± 99%  perf-profile.children.cycles-pp.slab_pre_alloc_hook
>       0.06 ±  6%      -0.0        0.02 ± 99%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
>       0.11 ±  4%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.detach_tasks
>       0.36 ±  3%      -0.0        0.33 ±  3%  perf-profile.children.cycles-pp.unmap_single_vma
>       0.16 ±  3%      -0.0        0.13 ±  6%  perf-profile.children.cycles-pp.__get_free_pages
>       0.12 ±  4%      -0.0        0.08 ±  8%  perf-profile.children.cycles-pp.__kmem_cache_alloc_node
>       0.06            -0.0        0.02 ± 99%  perf-profile.children.cycles-pp.update_rq_clock
>       0.20 ±  4%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.handle_signal
>       0.19 ±  3%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.get_sigframe
>       0.15            -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.alloc_empty_file
>       0.15 ±  8%      -0.0        0.12 ±  9%  perf-profile.children.cycles-pp.do_anonymous_page
>       0.10 ±  3%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_list
>       0.16 ±  4%      -0.0        0.13 ±  6%  perf-profile.children.cycles-pp.pgd_alloc
>       0.12 ±  4%      -0.0        0.08 ±  8%  perf-profile.children.cycles-pp.__d_alloc
>       0.11            -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.mas_mab_cp
>       0.13 ±  2%      -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.__pte_offset_map
>       0.07 ±  6%      -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.shuffle_freelist
>       0.07 ±  6%      -0.0        0.04 ± 44%  perf-profile.children.cycles-pp._find_next_and_bit
>       0.07 ±  6%      -0.0        0.04 ± 44%  perf-profile.children.cycles-pp._find_next_zero_bit
>       0.37 ±  2%      -0.0        0.34 ±  2%  perf-profile.children.cycles-pp.scheduler_tick
>       0.12 ±  5%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.mas_wr_walk
>       0.12            -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.alloc_pid
>       0.20 ±  4%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.x64_setup_rt_frame
>       0.19            -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.shrink_dentry_list
>       0.13 ±  6%      -0.0        0.10 ±  8%  perf-profile.children.cycles-pp.flush_tlb_func
>       0.14 ±  9%      -0.0        0.11 ±  6%  perf-profile.children.cycles-pp.pick_link
>       0.06 ±  7%      -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.__mt_destroy
>       0.25            -0.0        0.22 ±  2%  perf-profile.children.cycles-pp.mas_topiary_replace
>       0.16 ±  3%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.do_coredump
>       0.11 ±  4%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.native_flush_tlb_one_user
>       0.10 ±  4%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.__put_task_struct
>       0.10 ±  5%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.mas_pop_node
>       0.09            -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
>       0.07            -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.sched_cgroup_fork
>       0.07            -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.__init_rwsem
>       0.07            -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.security_cred_free
>       0.07 ±  6%      -0.0        0.04 ± 45%  perf-profile.children.cycles-pp.lockref_get_not_dead
>       0.06 ±  6%      -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.cgroup_can_fork
>       0.06 ±  6%      -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.cpu_clock_sample_group
>       0.21 ±  2%      -0.0        0.18 ±  3%  perf-profile.children.cycles-pp.flush_tlb_mm_range
>       0.14 ±  3%      -0.0        0.11 ±  6%  perf-profile.children.cycles-pp.rep_stos_alternative
>       0.10            -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.copy_creds
>       0.06            -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.update_rq_clock_task
>       0.14 ±  4%      -0.0        0.11 ±  6%  perf-profile.children.cycles-pp.copy_fpstate_to_sigframe
>       0.16 ±  2%      -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.do_open
>       0.18 ±  3%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_irq
>       0.10 ±  4%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.seq_printf
>       0.10 ±  4%      -0.0        0.07 ±  9%  perf-profile.children.cycles-pp.proc_pid_make_base_inode
>       0.08 ±  6%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.free_unref_page_prepare
>       0.08 ±  5%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.inode_init_always
>       0.08 ±  6%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.account_kernel_stack
>       0.08 ±  4%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.__alloc_pages_bulk
>       0.08 ±  5%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.nr_running
>       0.10 ±  3%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.proc_pid_instantiate
>       0.12            -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.select_task_rq
>       0.10 ±  6%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.obj_cgroup_uncharge_pages
>       0.22 ±  3%      -0.0        0.19 ±  3%  perf-profile.children.cycles-pp.vma_alloc_folio
>       0.13 ±  3%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.vsnprintf
>       0.08 ±  4%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.__mod_lruvec_state
>       0.08 ±  4%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.get_partial_node
>       0.09 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.update_blocked_averages
>       0.14 ±  2%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.__do_sys_prlimit64
>       0.07 ±  6%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.mas_next_node
>       0.08 ±  6%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.exit_task_stack_account
>       0.06 ±  7%      -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.terminate_walk
>       0.11 ±  4%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.thread_group_cputime
>       0.11 ±  3%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.perf_event_task_output
>       0.09            -0.0        0.07 ± 10%  perf-profile.children.cycles-pp.stress_get_setting
>       0.08 ±  6%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.lockref_put_return
>       0.11 ±  4%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.do_prlimit
>       0.08 ±  5%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.pte_offset_map_nolock
>       0.06 ±  6%      -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.mprotect_fixup
>       0.07            -0.0        0.05        perf-profile.children.cycles-pp.__do_sys_sysinfo
>       0.07            -0.0        0.05        perf-profile.children.cycles-pp.add_device_randomness
>       0.11            -0.0        0.09        perf-profile.children.cycles-pp.dup_fd
>       0.08 ±  5%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.__entry_text_start
>       0.18 ±  3%      -0.0        0.16 ±  4%  perf-profile.children.cycles-pp.__folio_alloc
>       0.13 ±  5%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.lock_mm_and_find_vma
>       0.11 ±  6%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.__count_memcg_events
>       0.08 ±  4%      -0.0        0.06 ± 13%  perf-profile.children.cycles-pp.lru_add_fn
>       0.07            -0.0        0.05 ±  7%  perf-profile.children.cycles-pp._find_next_or_bit
>       0.07            -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.get_zeroed_page
>       0.08            -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.init_file
>       0.08            -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.put_files_struct
>       0.07 ±  5%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.kmem_cache_free_bulk
>       0.07 ±  5%      -0.0        0.05        perf-profile.children.cycles-pp.menu_select
>       0.07 ±  5%      -0.0        0.05        perf-profile.children.cycles-pp.do_sysinfo
>       0.06            -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.set_next_entity
>       0.06            -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.mutex_unlock
>       0.16 ±  3%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.__mem_cgroup_charge
>       0.09 ±  4%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.copy_signal
>       0.07 ±  5%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.perf_event_task
>       0.07 ±  5%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.mt_find
>       0.07            -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.perf_event_fork
>       0.18 ±  2%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.try_charge_memcg
>       0.09            -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.put_ucounts
>       0.09            -0.0        0.07 ±  6%  perf-profile.children.cycles-pp._atomic_dec_and_lock_irqsave
>       0.09            -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.__x64_sys_mprotect
>       0.09            -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.do_mprotect_pkey
>       0.08 ±  5%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
>       0.07 ±  7%      -0.0        0.05        perf-profile.children.cycles-pp.error_entry
>       0.07 ±  7%      -0.0        0.05        perf-profile.children.cycles-pp.__update_load_avg_se
>       0.07 ±  6%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.kmem_cache_alloc_node
>       0.07 ±  5%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.select_idle_sibling
>       0.07            -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.__p4d_alloc
>       0.12 ±  3%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.do_dentry_open
>       0.11 ±  3%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.evict
>       0.08 ±  6%      -0.0        0.06        perf-profile.children.cycles-pp.mas_store_b_node
>       0.10 ±  5%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.filp_close
>       0.15 ±  3%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.__close_nocancel
>       0.11 ±  4%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.up_read
>       0.15 ±  2%      -0.0        0.14 ±  2%  perf-profile.children.cycles-pp.arch_dup_task_struct
>       0.07 ±  5%      -0.0        0.06        perf-profile.children.cycles-pp.find_vma
>       0.06 ±  7%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.update_rlimit_cpu
>       0.08 ±  6%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.switch_mm_irqs_off
>       0.06 ±  6%      -0.0        0.05        perf-profile.children.cycles-pp.task_rq_lock
>       0.05            +0.0        0.07 ±  8%  perf-profile.children.cycles-pp.pmd_install
>       0.09 ±  9%      +0.0        0.12 ±  6%  perf-profile.children.cycles-pp.xas_find
>       0.05 ± 46%      +0.0        0.09 ±  9%  perf-profile.children.cycles-pp.xas_load
>       0.53 ±  3%      +0.0        0.58        perf-profile.children.cycles-pp.__pte_offset_map_lock
>       0.00            +0.1        0.07 ± 10%  perf-profile.children.cycles-pp.__errno_location
>       0.05            +0.1        0.12 ± 12%  perf-profile.children.cycles-pp.__do_fault
>       0.61            +0.1        0.68        perf-profile.children.cycles-pp.dup_userfaultfd
>       0.00            +0.1        0.08 ± 17%  perf-profile.children.cycles-pp.getloadavg
>       0.00            +0.1        0.09 ± 15%  perf-profile.children.cycles-pp.filemap_fault
>       0.79 ±  2%      +0.1        0.89        perf-profile.children.cycles-pp.page_add_file_rmap
>       0.00            +0.1        0.12 ±  9%  perf-profile.children.cycles-pp.__getpid
>       0.42 ±  4%      +0.3        0.68 ± 16%  perf-profile.children.cycles-pp.__sigsetjmp@plt
>       0.36 ±  5%      +0.3        0.64 ± 17%  perf-profile.children.cycles-pp.stress_align_address
>       0.42 ± 14%      +0.3        0.74 ± 15%  perf-profile.children.cycles-pp.shim_nanosleep_uint64
>       0.41 ±  4%      +1.7        2.12 ± 15%  perf-profile.children.cycles-pp.strlen@plt
>       1.81            +1.8        3.61 ±  4%  perf-profile.children.cycles-pp.do_sys_openat2
>       1.81            +1.8        3.62 ±  4%  perf-profile.children.cycles-pp.__x64_sys_openat
>       0.72 ±  2%      +2.0        2.72 ±  6%  perf-profile.children.cycles-pp.__open64_nocancel
>       0.56 ±  4%      +2.0        2.59 ±  6%  perf-profile.children.cycles-pp.setrlimit64
>       0.58 ±  3%      +2.0        2.63 ±  6%  perf-profile.children.cycles-pp.__sigsetjmp
>       0.44 ±  2%      +2.1        2.50 ±  7%  perf-profile.children.cycles-pp.getname_flags
>       0.41            +2.1        2.47 ±  7%  perf-profile.children.cycles-pp.strncpy_from_user
>       0.00            +4.0        3.99        perf-profile.children.cycles-pp.next_uptodate_folio
>      49.10           +17.6       66.70 ±  2%  perf-profile.children.cycles-pp.asm_exc_page_fault
>      11.96 ±  2%     +30.5       42.47 ±  6%  perf-profile.children.cycles-pp.exc_page_fault
>      11.81 ±  2%     +30.5       42.35 ±  6%  perf-profile.children.cycles-pp.do_user_addr_fault
>      10.45 ±  2%     +30.9       41.30 ±  6%  perf-profile.children.cycles-pp.handle_mm_fault
>       9.88 ±  2%     +31.2       41.04 ±  6%  perf-profile.children.cycles-pp.__handle_mm_fault
>       7.67 ±  2%     +31.2       38.92 ±  6%  perf-profile.children.cycles-pp.filemap_map_pages
>       8.00 ±  2%     +31.3       39.28 ±  6%  perf-profile.children.cycles-pp.do_fault
>       7.94 ±  2%     +31.3       39.24 ±  6%  perf-profile.children.cycles-pp.do_read_fault
>       8.37            -5.7        2.68 ± 11%  perf-profile.self.cycles-pp.osq_lock
>       4.34            -2.4        1.94 ±  9%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
>       2.30            -1.4        0.90 ± 10%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
>       3.45 ±  3%      -1.4        2.08 ±  6%  perf-profile.self.cycles-pp.release_pages
>       4.10            -1.2        2.92 ±  3%  perf-profile.self.cycles-pp.up_write
>       3.61            -1.1        2.50 ±  4%  perf-profile.self.cycles-pp.anon_vma_interval_tree_insert
>       2.55 ±  7%      -1.0        1.56 ±  8%  perf-profile.self.cycles-pp._compound_head
>       2.53            -0.9        1.58 ±  7%  perf-profile.self.cycles-pp.zap_pte_range
>       3.25            -0.7        2.53 ±  3%  perf-profile.self.cycles-pp.down_write
>       1.13 ±  2%      -0.5        0.64 ±  6%  perf-profile.self.cycles-pp.anon_vma_clone
>       2.39            -0.5        1.92 ±  3%  perf-profile.self.cycles-pp.__slab_free
>       1.36            -0.5        0.91 ±  3%  perf-profile.self.cycles-pp.mod_objcg_state
>       1.56            -0.4        1.14 ±  5%  perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
>       1.26            -0.4        0.87 ±  3%  perf-profile.self.cycles-pp.kmem_cache_free
>       1.18            -0.4        0.81 ±  7%  perf-profile.self.cycles-pp.__anon_vma_interval_tree_remove
>       2.71 ±  3%      -0.4        2.35 ±  2%  perf-profile.self.cycles-pp.page_remove_rmap
>       1.52            -0.3        1.18 ±  3%  perf-profile.self.cycles-pp.dup_mmap
>       0.79 ±  2%      -0.3        0.44 ±  6%  perf-profile.self.cycles-pp.unlink_anon_vmas
>       0.90            -0.3        0.58 ±  7%  perf-profile.self.cycles-pp.vm_area_dup
>       0.82            -0.3        0.51 ±  5%  perf-profile.self.cycles-pp.free_swap_cache
>       0.56 ±  4%      -0.3        0.25 ±  9%  perf-profile.self.cycles-pp.rwsem_down_write_slowpath
>       0.48 ±  5%      -0.3        0.20 ±  4%  perf-profile.self.cycles-pp.___perf_sw_event
>       0.90            -0.3        0.63 ±  4%  perf-profile.self.cycles-pp.kmem_cache_alloc
>       0.68 ±  4%      -0.2        0.45 ±  6%  perf-profile.self.cycles-pp.osq_unlock
>       1.14 ±  6%      -0.2        0.92 ±  6%  perf-profile.self.cycles-pp.copy_present_pte
>       0.46            -0.2        0.25 ±  2%  perf-profile.self.cycles-pp.do_set_pte
>       0.70            -0.2        0.50 ±  6%  perf-profile.self.cycles-pp.fput
>       0.58            -0.2        0.38 ±  4%  perf-profile.self.cycles-pp.update_sg_lb_stats
>       0.62            -0.2        0.43 ±  5%  perf-profile.self.cycles-pp.mas_next_slot
>       0.54            -0.2        0.35 ±  2%  perf-profile.self.cycles-pp.anon_vma_fork
>       0.44 ±  4%      -0.2        0.26 ±  6%  perf-profile.self.cycles-pp.__rb_erase_color
>       0.53 ±  5%      -0.2        0.36 ±  6%  perf-profile.self.cycles-pp.clear_page_erms
>       0.53            -0.2        0.36 ±  4%  perf-profile.self.cycles-pp.percpu_counter_add_batch
>       0.71 ±  3%      -0.2        0.54 ±  2%  perf-profile.self.cycles-pp.vma_interval_tree_remove
>       0.51            -0.2        0.34 ±  5%  perf-profile.self.cycles-pp.__list_del_entry_valid
>       0.56            -0.2        0.40 ±  6%  perf-profile.self.cycles-pp.__percpu_counter_sum
>       0.39            -0.2        0.23 ±  4%  perf-profile.self.cycles-pp.__put_anon_vma
>       0.43            -0.2        0.27 ±  5%  perf-profile.self.cycles-pp.pcpu_alloc
>       0.44 ±  8%      -0.2        0.29 ±  7%  perf-profile.self.cycles-pp.rwsem_optimistic_spin
>       0.32 ±  2%      -0.1        0.18 ±  7%  perf-profile.self.cycles-pp.vma_interval_tree_insert_after
>       0.34 ±  5%      -0.1        0.20 ±  5%  perf-profile.self.cycles-pp.__rb_insert_augmented
>       0.53            -0.1        0.39 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
>       0.54 ±  2%      -0.1        0.40 ±  4%  perf-profile.self.cycles-pp.sync_regs
>       0.22 ±  3%      -0.1        0.08 ±  8%  perf-profile.self.cycles-pp.mutex_spin_on_owner
>       0.43            -0.1        0.30 ±  4%  perf-profile.self.cycles-pp.__cond_resched
>       0.36            -0.1        0.24 ±  3%  perf-profile.self.cycles-pp.acct_collect
>       0.38            -0.1        0.26 ±  4%  perf-profile.self.cycles-pp.update_sg_wakeup_stats
>       0.30 ± 14%      -0.1        0.18 ± 22%  perf-profile.self.cycles-pp.copy_pte_range
>       0.51            -0.1        0.41 ±  3%  perf-profile.self.cycles-pp.native_irq_return_iret
>       0.21            -0.1        0.11 ±  9%  perf-profile.self.cycles-pp.queued_write_lock_slowpath
>       0.33 ±  3%      -0.1        0.23 ±  3%  perf-profile.self.cycles-pp.obj_cgroup_charge
>       0.38            -0.1        0.30 ±  2%  perf-profile.self.cycles-pp.acpi_safe_halt
>       0.34 ±  2%      -0.1        0.26 ±  3%  perf-profile.self.cycles-pp.mtree_range_walk
>       0.27            -0.1        0.19 ±  4%  perf-profile.self.cycles-pp.__anon_vma_interval_tree_augment_rotate
>       0.27            -0.1        0.19 ±  6%  perf-profile.self.cycles-pp.refill_obj_stock
>       0.23 ±  4%      -0.1        0.16 ±  4%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
>       0.14 ±  3%      -0.1        0.07 ± 11%  perf-profile.self.cycles-pp.__vm_area_free
>       0.26 ±  2%      -0.1        0.18 ±  2%  perf-profile.self.cycles-pp.___slab_alloc
>       0.24 ±  2%      -0.1        0.17 ±  5%  perf-profile.self.cycles-pp.lock_vma_under_rcu
>       0.29 ±  4%      -0.1        0.22 ±  8%  perf-profile.self.cycles-pp.copy_mc_enhanced_fast_string
>       0.22 ±  4%      -0.1        0.15 ±  7%  perf-profile.self.cycles-pp.get_obj_cgroup_from_current
>       0.17 ±  2%      -0.1        0.11 ±  8%  perf-profile.self.cycles-pp.__list_add_valid
>       0.29            -0.1        0.22 ±  3%  perf-profile.self.cycles-pp.down_read_trylock
>       0.26 ±  2%      -0.1        0.19 ±  4%  perf-profile.self.cycles-pp.__libc_fork
>       0.20 ±  2%      -0.1        0.14 ±  8%  perf-profile.self.cycles-pp.cpu_util
>       0.19 ±  3%      -0.1        0.13 ±  5%  perf-profile.self.cycles-pp.mas_update_gap
>       0.12 ±  7%      -0.1        0.06 ± 11%  perf-profile.self.cycles-pp.mark_page_accessed
>       0.21 ±  3%      -0.1        0.15 ±  4%  perf-profile.self.cycles-pp.unmap_page_range
>       0.21 ±  5%      -0.1        0.15 ±  7%  perf-profile.self.cycles-pp.__get_obj_cgroup_from_memcg
>       0.22 ±  3%      -0.1        0.16 ±  5%  perf-profile.self.cycles-pp.memcg_account_kmem
>       0.18 ±  3%      -0.1        0.12 ±  6%  perf-profile.self.cycles-pp.update_load_avg
>       0.19            -0.1        0.14 ±  5%  perf-profile.self.cycles-pp.mas_leaf_max_gap
>       0.16 ±  2%      -0.1        0.11 ±  7%  perf-profile.self.cycles-pp.copy_page_range
>       0.12 ±  4%      -0.1        0.07 ±  9%  perf-profile.self.cycles-pp.queued_read_lock_slowpath
>       0.20 ±  6%      -0.1        0.15 ±  6%  perf-profile.self.cycles-pp.cgroup_rstat_updated
>       0.20 ±  2%      -0.1        0.14 ±  4%  perf-profile.self.cycles-pp._find_next_bit
>       0.10 ±  5%      -0.1        0.04 ± 45%  perf-profile.self.cycles-pp.__free_one_page
>       0.44 ±  2%      -0.1        0.39 ±  4%  perf-profile.self.cycles-pp.memset_orig
>       0.19 ±  2%      -0.0        0.14 ± 11%  perf-profile.self.cycles-pp.stress_bad_altstack
>       0.13 ±  8%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
>       0.16 ±  2%      -0.0        0.12 ±  6%  perf-profile.self.cycles-pp.rcu_all_qs
>       0.13 ±  4%      -0.0        0.09 ±  8%  perf-profile.self.cycles-pp.zap_pmd_range
>       0.07 ±  5%      -0.0        0.02 ± 99%  perf-profile.self.cycles-pp.__switch_to_asm
>       0.14 ±  3%      -0.0        0.10 ±  6%  perf-profile.self.cycles-pp.__pte_offset_map_lock
>       0.25 ±  2%      -0.0        0.21 ±  5%  perf-profile.self.cycles-pp.__memcpy
>       0.12 ±  4%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.free_pgtables
>       0.08 ±  6%      -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.__d_lookup_rcu
>       0.07 ±  7%      -0.0        0.02 ± 99%  perf-profile.self.cycles-pp._find_next_and_bit
>       0.14 ±  3%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.mas_store
>       0.14 ±  3%      -0.0        0.10 ±  7%  perf-profile.self.cycles-pp.vm_normal_page
>       0.12 ±  4%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.__kmem_cache_alloc_bulk
>       0.17 ±  2%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.mab_mas_cp
>       0.07 ± 12%      -0.0        0.04 ± 71%  perf-profile.self.cycles-pp.malloc
>       0.09 ±  6%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.rcu_cblist_dequeue
>       0.06 ±  6%      -0.0        0.02 ± 99%  perf-profile.self.cycles-pp.error_entry
>       0.07 ±  5%      -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.free_pages_and_swap_cache
>       0.09            -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.free_percpu
>       0.12 ±  4%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.handle_mm_fault
>       0.09 ±  4%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.remove_vma
>       0.10 ±  3%      -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.mas_find
>       0.10 ±  5%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.folio_mark_accessed
>       0.09 ±  5%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.exit_mmap
>       0.25 ±  2%      -0.0        0.22 ±  3%  perf-profile.self.cycles-pp.mas_topiary_replace
>       0.09 ±  5%      -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.__tlb_remove_page_size
>       0.11 ±  4%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.mas_wr_walk
>       0.11 ±  4%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.native_flush_tlb_one_user
>       0.09 ±  5%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.mas_pop_node
>       0.08 ±  5%      -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.mas_push_data
>       0.07            -0.0        0.04 ± 44%  perf-profile.self.cycles-pp._find_next_zero_bit
>       0.06 ±  6%      -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.__sigsetjmp
>       0.08 ±  5%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.__put_user_4
>       0.34 ±  4%      -0.0        0.32 ±  3%  perf-profile.self.cycles-pp.unmap_single_vma
>       0.10 ±  3%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.mas_wr_store_entry
>       0.06            -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.mas_wr_bnode
>       0.06            -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.__reclaim_stacks
>       0.11 ±  3%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.__pte_offset_map
>       0.09 ±  5%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.mas_wr_append
>       0.11 ±  4%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.update_curr
>       0.11 ±  3%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.do_user_addr_fault
>       0.08            -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.copy_process
>       0.07 ±  7%      -0.0        0.04 ± 45%  perf-profile.self.cycles-pp.prepare_creds
>       0.09 ±  4%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.mas_mab_cp
>       0.12 ±  4%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.__schedule
>       0.13 ±  3%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.copy_p4d_range
>       0.08 ±  4%      -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.__perf_sw_event
>       0.08 ±  4%      -0.0        0.06        perf-profile.self.cycles-pp.mm_init
>       0.08 ±  5%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.mast_fill_bnode
>       0.09 ±  5%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.stress_get_setting
>       0.08 ±  6%      -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.lockref_put_return
>       0.09 ±  5%      -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.asm_exc_page_fault
>       0.07            -0.0        0.05        perf-profile.self.cycles-pp.nr_running
>       0.06            -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.strlen@plt
>       0.06            -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.free_pud_range
>       0.06            -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.mutex_unlock
>       0.14 ±  3%      -0.0        0.12 ±  5%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
>       0.08 ± 10%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.rmqueue
>       0.09            -0.0        0.07 ±  6%  perf-profile.self.cycles-pp._atomic_dec_and_lock_irqsave
>       0.07 ±  7%      -0.0        0.05 ±  7%  perf-profile.self.cycles-pp.dup_fd
>       0.08 ±  5%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.pcpu_alloc_area
>       0.08 ±  6%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
>       0.08 ±  6%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.switch_mm_irqs_off
>       0.10 ±  4%      -0.0        0.09 ±  7%  perf-profile.self.cycles-pp.up_read
>       0.06 ±  6%      -0.0        0.05        perf-profile.self.cycles-pp.get_page_from_freelist
>       0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.ptep_clear_flush
>       0.76 ±  2%      +0.1        0.87        perf-profile.self.cycles-pp.page_add_file_rmap
>       0.00            +3.8        3.80        perf-profile.self.cycles-pp.next_uptodate_folio
>       1.41 ±  2%     +31.7       33.08 ±  7%  perf-profile.self.cycles-pp.filemap_map_pages
> 
> 
> ***************************************************************************************************
> lkp-icl-2sp7: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
> =========================================================================================
> class/compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
>   pts/gcc-12/performance/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp7/fork/stress-ng/60s
> 
> commit: 
>   9f1f5b60e7 ("mm: use flush_icache_pages() in do_set_pmd()")
>   de74976eb6 ("filemap: add filemap_map_folio_range()")
> 
> 9f1f5b60e76d44fa de74976eb65151a2f568e477fc2 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>    1393423 ±  3%     -20.9%    1102032 ±  2%  cpuidle..usage
>      76864           -12.8%      66991 ±  2%  vmstat.system.cs
>       0.00 ± 29%      +0.1        0.11 ±  7%  mpstat.cpu.all.iowait%
>       4.35            -0.4        3.93        mpstat.cpu.all.soft%
>     133293 ±  4%      -9.2%     120977 ±  6%  numa-meminfo.node1.SUnreclaim
>     471554 ± 13%     -25.7%     350336 ± 12%  numa-meminfo.node1.Shmem
>    2863944            -8.0%    2634003        meminfo.Inactive
>    2863779            -8.0%    2633836        meminfo.Inactive(anon)
>     267633 ±  3%      -7.5%     247668 ±  4%  meminfo.SUnreclaim
>     626825           -10.2%     562986        meminfo.Shmem
>   30299397           -16.5%   25290170 ±  4%  numa-numastat.node0.local_node
>   30574273           -16.5%   25525439 ±  4%  numa-numastat.node0.numa_hit
>     270840 ±  6%     -14.2%     232249 ± 14%  numa-numastat.node0.other_node
>   29636034 ±  2%     -13.3%   25688715 ±  6%  numa-numastat.node1.local_node
>   29942858 ±  2%     -13.3%   25954938 ±  5%  numa-numastat.node1.numa_hit
>   30580946           -16.5%   25534090 ±  4%  numa-vmstat.node0.numa_hit
>   30306070           -16.5%   25298821 ±  4%  numa-vmstat.node0.numa_local
>     270840 ±  6%     -14.2%     232249 ± 14%  numa-vmstat.node0.numa_other
>     118001 ± 13%     -25.7%      87690 ± 12%  numa-vmstat.node1.nr_shmem
>      33409 ±  4%      -9.5%      30222 ±  6%  numa-vmstat.node1.nr_slab_unreclaimable
>   29948612 ±  2%     -13.3%   25956024 ±  5%  numa-vmstat.node1.numa_hit
>   29641789 ±  2%     -13.3%   25689801 ±  6%  numa-vmstat.node1.numa_local
>    1701805           -13.3%    1474809        stress-ng.fork.ops
>      28363           -13.3%      24579        stress-ng.fork.ops_per_sec
>     196070 ±  2%     -20.8%     155373 ±  4%  stress-ng.time.involuntary_context_switches
>      14911 ±  6%    +964.6%     158745 ±  7%  stress-ng.time.major_page_faults
>  1.284e+08           -18.7%  1.045e+08 ± 11%  stress-ng.time.minor_page_faults
>       3119            +2.0%       3181        stress-ng.time.system_time
>     113.69 ±  2%     -32.8%      76.41 ±  2%  stress-ng.time.user_time
>    3159974            -7.1%    2934998        stress-ng.time.voluntary_context_switches
>       9213 ±  9%    +180.8%      25876 ±  4%  turbostat.C1
>       0.01 ± 31%      +0.0        0.05        turbostat.C1%
>    1042465 ±  3%     -32.7%     701201 ±  5%  turbostat.C1E
>       3.75 ±  2%      -0.5        3.28 ±  3%  turbostat.C1E%
>       0.10           -20.0%       0.08        turbostat.IPC
>       1650 ±  2%     +56.6%       2584 ±  9%  turbostat.POLL
>     230.66            -2.8%     224.15        turbostat.PkgWatt
>      75.92            -5.2%      71.96        turbostat.RAMWatt
>     637764 ±  2%     -12.3%     559588 ±  6%  sched_debug.cfs_rq:/.MIN_vruntime.max
>     263.91 ± 10%    +173.2%     721.05 ± 66%  sched_debug.cfs_rq:/.load_avg.avg
>     637764 ±  2%     -12.3%     559589 ±  6%  sched_debug.cfs_rq:/.max_vruntime.max
>     617832           -14.3%     529781 ±  3%  sched_debug.cfs_rq:/.min_vruntime.avg
>     439310 ±  3%     -15.9%     369572 ±  6%  sched_debug.cfs_rq:/.min_vruntime.min
>      93.37 ± 15%     -19.4%      75.29 ± 17%  sched_debug.cfs_rq:/.util_est_enqueued.avg
>       4.17 ± 17%     +34.3%       5.60 ±  9%  sched_debug.cpu.clock.stddev
>     814830           -13.3%     706518        sched_debug.cpu.curr->pid.max
>     403830           -14.7%     344526        sched_debug.cpu.curr->pid.stddev
>      40522           -12.6%      35397 ±  2%  sched_debug.cpu.nr_switches.avg
>      29933 ±  5%     -12.0%      26346 ±  7%  sched_debug.cpu.nr_switches.min
>      30.67 ± 22%     +52.2%      46.67 ± 16%  sched_debug.cpu.nr_uninterruptible.max
>     -28.92           +74.4%     -50.42        sched_debug.cpu.nr_uninterruptible.min
>      11.77 ±  5%     +59.2%      18.73 ± 12%  sched_debug.cpu.nr_uninterruptible.stddev
>     575349            -7.1%     534305        proc-vmstat.nr_anon_pages
>     842911            -1.9%     827005        proc-vmstat.nr_file_pages
>     716938            -8.0%     659721        proc-vmstat.nr_inactive_anon
>     130143            -4.3%     124519 ±  2%  proc-vmstat.nr_mapped
>       4924            -6.0%       4627 ±  2%  proc-vmstat.nr_page_table_pages
>     156822           -10.1%     140917        proc-vmstat.nr_shmem
>      66832 ±  3%      -6.9%      62207 ±  4%  proc-vmstat.nr_slab_unreclaimable
>     716938            -8.0%     659721        proc-vmstat.nr_zone_inactive_anon
>   60509078 ±  2%     -14.9%   51474061 ±  3%  proc-vmstat.numa_hit
>   59927380 ±  2%     -14.9%   50972568 ±  3%  proc-vmstat.numa_local
>     577989 ±  2%     -14.0%     496858 ±  3%  proc-vmstat.numa_other
>   66640119           -15.0%   56627849 ±  3%  proc-vmstat.pgalloc_normal
>  1.312e+08           -18.2%  1.073e+08 ± 10%  proc-vmstat.pgfault
>   64445803           -14.9%   54819989 ±  3%  proc-vmstat.pgfree
>   60119718           -22.7%   46481479 ± 25%  proc-vmstat.pgreuse
>  1.068e+10           -16.6%  8.899e+09 ±  2%  perf-stat.i.branch-instructions
>   75840999           -16.2%   63544754 ±  2%  perf-stat.i.branch-misses
>      30.59            -1.1       29.46        perf-stat.i.cache-miss-rate%
>   1.92e+08           -20.0%  1.535e+08 ±  2%  perf-stat.i.cache-misses
>  6.283e+08           -16.5%  5.247e+08 ±  2%  perf-stat.i.cache-references
>      79953           -15.1%      67856 ±  2%  perf-stat.i.context-switches
>       3.43           +19.7%       4.11 ±  2%  perf-stat.i.cpi
>      22388 ±  2%     -38.2%      13831 ±  6%  perf-stat.i.cpu-migrations
>     984.38           +23.2%       1212 ±  2%  perf-stat.i.cycles-between-cache-misses
>   19740484 ±  6%     -16.3%   16521409 ±  8%  perf-stat.i.dTLB-load-misses
>    1.3e+10           -15.6%  1.097e+10 ±  2%  perf-stat.i.dTLB-loads
>       0.24 ±  3%      -0.0        0.22 ±  6%  perf-stat.i.dTLB-store-miss-rate%
>   15956338 ±  2%     -19.3%   12872776 ±  7%  perf-stat.i.dTLB-store-misses
>  6.422e+09           -12.9%  5.594e+09        perf-stat.i.dTLB-stores
>  5.162e+10           -15.9%   4.34e+10 ±  2%  perf-stat.i.instructions
>       0.32           -14.6%       0.27 ±  2%  perf-stat.i.ipc
>     250.36 ±  7%   +1059.2%       2902 ±  7%  perf-stat.i.major-faults
>       2036           -15.2%       1727 ±  2%  perf-stat.i.metric.K/sec
>     480.18           -15.5%     405.54 ±  2%  perf-stat.i.metric.M/sec
>    2110044           -19.1%    1707218 ± 10%  perf-stat.i.minor-faults
>   80646029           -18.5%   65745733 ±  2%  perf-stat.i.node-load-misses
>   12640859 ±  3%     -12.5%   11055255 ±  2%  perf-stat.i.node-loads
>   50235371           -22.8%   38806291 ±  3%  perf-stat.i.node-store-misses
>   46512626 ±  2%     -20.9%   36805650 ±  3%  perf-stat.i.node-stores
>    2110294           -19.0%    1710120 ± 10%  perf-stat.i.page-faults
>      30.78            -1.0       29.76        perf-stat.overall.cache-miss-rate%
>       3.50           +17.8%       4.12 ±  2%  perf-stat.overall.cpi
>     928.07           +22.5%       1137 ±  2%  perf-stat.overall.cycles-between-cache-misses
>       0.25 ±  3%      -0.0        0.23 ±  6%  perf-stat.overall.dTLB-store-miss-rate%
>       0.29           -15.1%       0.24 ±  2%  perf-stat.overall.ipc
>      85.78            -0.9       84.87        perf-stat.overall.node-load-miss-rate%
>  1.017e+10           -15.5%  8.597e+09        perf-stat.ps.branch-instructions
>   71096858           -14.6%   60750696 ±  2%  perf-stat.ps.branch-misses
>  1.854e+08           -18.1%  1.519e+08 ±  2%  perf-stat.ps.cache-misses
>  6.023e+08           -15.3%  5.103e+08 ±  2%  perf-stat.ps.cache-references
>      77490           -13.6%      66934 ±  2%  perf-stat.ps.context-switches
>      21219 ±  2%     -33.9%      14030 ±  5%  perf-stat.ps.cpu-migrations
>   19795627 ±  6%     -16.1%   16616085 ±  7%  perf-stat.ps.dTLB-load-misses
>   1.24e+10           -14.4%  1.061e+10        perf-stat.ps.dTLB-loads
>   15378428 ±  2%     -18.5%   12530798 ±  6%  perf-stat.ps.dTLB-store-misses
>  6.158e+09           -11.8%  5.429e+09        perf-stat.ps.dTLB-stores
>  4.918e+10           -14.8%  4.191e+10        perf-stat.ps.instructions
>     232.74 ±  6%    +991.1%       2539 ±  7%  perf-stat.ps.major-faults
>    2027968           -18.2%    1657895 ± 10%  perf-stat.ps.minor-faults
>   77365251           -16.9%   64327762 ±  2%  perf-stat.ps.node-load-misses
>   12821005 ±  3%     -10.6%   11467882 ±  2%  perf-stat.ps.node-loads
>   47651364           -20.9%   37701874 ±  2%  perf-stat.ps.node-store-misses
>   45671351 ±  2%     -18.5%   37216427 ±  3%  perf-stat.ps.node-stores
>    2028200           -18.1%    1660434 ± 10%  perf-stat.ps.page-faults
>  3.018e+12           -15.4%  2.552e+12 ±  3%  perf-stat.total.instructions
>       0.08 ±  4%     -10.0%       0.07 ±  2%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_node_trace.alloc_fair_sched_group.sched_create_group
>       0.09 ±  5%     -22.9%       0.07 ±  8%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.sched_autogroup_create_attach.ksys_setsid
>       0.05 ± 84%     -84.4%       0.01 ±102%  perf-sched.sch_delay.avg.ms.__cond_resched.__vmalloc_area_node.__vmalloc_node_range.alloc_thread_stack_node.dup_task_struct
>       0.06 ± 21%     -46.9%       0.03 ± 26%  perf-sched.sch_delay.avg.ms.__cond_resched.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
>       0.03 ± 18%     -39.7%       0.02 ± 37%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.anon_vma_clone.anon_vma_fork.dup_mmap
>       0.04 ± 30%     -47.5%       0.02 ± 37%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.anon_vma_fork.dup_mmap.dup_mm
>       0.06 ± 57%     -61.6%       0.02 ± 34%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.dup_userfaultfd.dup_mmap.dup_mm
>       0.09 ±  6%    +109.2%       0.18 ±  8%  perf-sched.sch_delay.avg.ms.__cond_resched.lock_mm_and_find_vma.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
>       0.07           -28.5%       0.05 ±  2%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
>       0.05           -28.3%       0.03 ±  6%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
>       0.05 ± 18%     -37.7%       0.03 ± 21%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
>       0.07 ± 23%     +73.4%       0.12 ± 26%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
>       0.05 ±  7%     -28.9%       0.03 ± 20%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
>       0.07 ± 21%    +234.5%       0.25 ± 12%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.ret_from_fork_asm
>       0.09 ± 15%     -46.7%       0.05 ±  2%  perf-sched.sch_delay.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
>       0.02 ± 19%     -42.7%       0.01 ± 42%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.anon_vma_fork
>       0.07 ±  8%     +69.0%       0.11 ± 12%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>       0.12 ±143%     -92.2%       0.01 ±110%  perf-sched.sch_delay.max.ms.__cond_resched.__vmalloc_area_node.__vmalloc_node_range.alloc_thread_stack_node.dup_task_struct
>       0.46 ± 32%     -62.3%       0.18 ± 79%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.anon_vma_fork.dup_mmap.dup_mm
>       1.83 ± 35%     +46.7%       2.69 ±  8%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
>       1.07 ± 29%     -58.9%       0.44 ± 58%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.anon_vma_fork
>       0.07 ±  4%     -26.5%       0.05 ±  4%  perf-sched.total_sch_delay.average.ms
>       3.98           +15.2%       4.59        perf-sched.total_wait_and_delay.average.ms
>     325106           -11.8%     286809 ±  2%  perf-sched.total_wait_and_delay.count.ms
>       3.91           +16.0%       4.53 ±  2%  perf-sched.total_wait_time.average.ms
>       1.37           +30.7%       1.79 ±  3%  perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
>      82.89          +113.4%     176.92 ± 10%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>      22.41 ±  3%    +105.6%      46.08 ± 10%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
>       3309 ±  3%     -75.0%     827.67 ±100%  perf-sched.wait_and_delay.count.__cond_resched.__kmem_cache_alloc_node.kmalloc_node_trace.alloc_fair_sched_group.sched_create_group
>      27.67 ± 17%     -38.0%      17.17 ± 26%  perf-sched.wait_and_delay.count.__cond_resched.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
>     140277           -12.3%     123044        perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
>     140531           -12.3%     123246        perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
>       5685 ±  3%     -17.0%       4721 ±  8%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
>       2160 ±  9%     -35.7%       1389 ± 45%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
>       7268           -52.9%       3422 ± 10%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>      14506 ±  3%     -51.5%       7037 ± 11%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
>       0.05 ± 33%    +178.6%       0.15 ± 23%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.wp_page_copy
>       1.39 ±  7%     +40.7%       1.96 ± 13%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.pte_alloc_one.__pte_alloc.copy_pte_range
>       1.26 ±  9%     +33.2%       1.68 ± 13%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.security_prepare_creds.prepare_creds
>       1.33 ± 10%     +46.2%       1.95 ± 11%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.security_task_alloc.copy_process
>       0.04 ±  4%     +29.5%       0.06 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_node_trace.alloc_fair_sched_group.sched_create_group
>       0.03 ± 10%     +48.4%       0.04 ± 19%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.sched_autogroup_create_attach.ksys_setsid
>       1.27 ±  6%     +37.9%       1.75 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.cgroup_css_set_fork.cgroup_can_fork.copy_process.kernel_clone
>       1.32 ±  3%     +32.3%       1.75 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.copy_page_range.dup_mmap.dup_mm.constprop
>       1.34 ±  2%     +30.2%       1.75 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
>       1.28 ±  3%     +36.0%       1.75 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.anon_vma_clone.anon_vma_fork.dup_mmap
>       1.30 ±  2%     +37.5%       1.78 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.anon_vma_fork.dup_mmap.dup_mm
>       1.31           +34.1%       1.75 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.dup_mmap.dup_mm.constprop
>       1.32 ±  4%     +35.1%       1.78 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.dup_userfaultfd.dup_mmap.dup_mm
>       0.03 ± 48%    +343.4%       0.12 ± 63%  perf-sched.wait_time.avg.ms.__cond_resched.dput.__fput.task_work_run.exit_to_user_mode_loop
>       1.25 ± 13%     +41.9%       1.77 ±  8%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.alloc_pid.copy_process.kernel_clone
>       1.31           +33.4%       1.75 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.anon_vma_fork.dup_mmap.dup_mm
>       1.30 ± 13%     +40.1%       1.82 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.copy_fs_struct.copy_process.kernel_clone
>       1.24 ± 18%     +58.8%       1.97 ± 14%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.copy_signal.copy_process.kernel_clone
>       1.29 ±  4%     +32.8%       1.72 ± 10%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.dup_mm.constprop.0
>       1.32           +34.9%       1.78 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.dup_mmap.dup_mm
>       1.30 ±  2%     +29.8%       1.69 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.__percpu_counter_init.mm_init
>       1.41 ±  5%     +24.3%       1.76 ± 10%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.mm_init.dup_mm
>       1.27 ±  3%     +38.8%       1.76 ± 10%  perf-sched.wait_time.avg.ms.__cond_resched.uprobe_start_dup_mmap.dup_mmap.dup_mm.constprop
>       0.23 ±  5%     +16.9%       0.26 ±  4%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
>       1.33           +32.7%       1.76 ±  3%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
>       0.04 ± 24%    +556.4%       0.25 ± 21%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
>       0.08 ± 57%    +174.5%       0.21 ± 22%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
>       0.01 ± 84%    +683.3%       0.04 ± 28%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.ret_from_fork_asm
>       0.02 ± 20%     +38.8%       0.03 ±  4%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
>       0.89 ±  8%     +39.8%       1.24 ± 15%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pcpu_alloc
>       0.55 ±  5%     +38.9%       0.76 ± 13%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.anon_vma_fork
>      82.82          +113.5%     176.85 ± 10%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>      22.11 ±  3%    +107.0%      45.76 ± 10%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
>       1.35 ± 18%     +43.6%       1.94 ± 26%  perf-sched.wait_time.max.ms.__cond_resched.__mutex_lock.constprop.0.pcpu_alloc
>       0.53 ± 72%    +221.3%       1.72 ± 34%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
>       0.26 ±141%   +1052.5%       2.96 ± 83%  perf-sched.wait_time.max.ms.__cond_resched.dput.__fput.task_work_run.exit_to_user_mode_loop
>       2.12 ±  9%     +49.7%       3.18 ± 19%  perf-sched.wait_time.max.ms.__cond_resched.uprobe_start_dup_mmap.dup_mmap.dup_mm.constprop
>       1.28 ± 21%    +403.9%       6.45 ±101%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
>       0.58 ± 73%    +168.7%       1.56 ± 21%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.ret_from_fork_asm
>       1.30 ± 32%    +151.4%       3.27 ± 19%  perf-sched.wait_time.max.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
>       4.35 ± 11%     +68.9%       7.35 ± 22%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
>      35.78            -8.5       27.26 ±  2%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      35.19            -8.4       26.83 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
>      35.18            -8.4       26.82 ±  3%  perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
>      35.19            -8.4       26.83 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_fork
>      35.18            -8.4       26.82 ±  3%  perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
>      34.32            -8.2       26.14 ±  3%  perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      35.26            -8.0       27.27 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
>      35.26            -8.0       27.27 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      35.24            -8.0       27.26 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      35.24            -8.0       27.26 ±  2%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      32.41            -7.6       24.78 ±  3%  perf-profile.calltrace.cycles-pp.dup_mm.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
>      33.53            -7.5       26.02 ±  2%  perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.do_group_exit
>      33.64            -7.5       26.13 ±  2%  perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
>      33.63            -7.5       26.12 ±  2%  perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
>      36.99            -7.4       29.61 ±  2%  perf-profile.calltrace.cycles-pp.__libc_fork
>      29.90            -7.0       22.86 ±  3%  perf-profile.calltrace.cycles-pp.dup_mmap.dup_mm.copy_process.kernel_clone.__do_sys_clone
>      15.68            -4.1       11.56 ±  4%  perf-profile.calltrace.cycles-pp.anon_vma_fork.dup_mmap.dup_mm.copy_process.kernel_clone
>      12.53            -2.9        9.59 ±  3%  perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.__mmput.exit_mm.do_exit
>      13.12            -2.9       10.26 ±  2%  perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.__mmput.exit_mm.do_exit
>      12.54            -2.7        9.84 ±  2%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.__mmput.exit_mm
>      12.40            -2.7        9.72 ±  2%  perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap.__mmput
>      12.14            -2.6        9.50        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap
>      10.06            -2.5        7.60 ±  3%  perf-profile.calltrace.cycles-pp.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm.copy_process
>       8.72            -2.3        6.41 ±  4%  perf-profile.calltrace.cycles-pp.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput.exit_mm
>       5.30            -1.5        3.84 ±  3%  perf-profile.calltrace.cycles-pp._compound_head.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
>       4.55 ±  2%      -1.5        3.10 ±  5%  perf-profile.calltrace.cycles-pp.down_write.anon_vma_fork.dup_mmap.dup_mm.copy_process
>       4.40 ±  2%      -1.5        2.94 ±  6%  perf-profile.calltrace.cycles-pp.down_write.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm
>       4.12 ±  2%      -1.4        2.67 ±  7%  perf-profile.calltrace.cycles-pp.down_write.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput
>       4.39 ±  2%      -1.4        2.95 ±  5%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.anon_vma_fork.dup_mmap.dup_mm
>       4.33 ±  2%      -1.4        2.91 ±  5%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.anon_vma_fork.dup_mmap
>       4.14 ±  2%      -1.4        2.73 ±  6%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.anon_vma_clone.anon_vma_fork.dup_mmap
>       4.10 ±  2%      -1.4        2.70 ±  6%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.anon_vma_clone.anon_vma_fork
>       3.78 ±  2%      -1.4        2.39 ±  7%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
>       3.74 ±  2%      -1.4        2.36 ±  8%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_anon_vmas.free_pgtables
>       5.39            -1.3        4.07 ±  3%  perf-profile.calltrace.cycles-pp.copy_page_range.dup_mmap.dup_mm.copy_process.kernel_clone
>       5.30            -1.3        3.99 ±  3%  perf-profile.calltrace.cycles-pp.copy_p4d_range.copy_page_range.dup_mmap.dup_mm.copy_process
>       5.26            -1.3        4.01 ±  3%  perf-profile.calltrace.cycles-pp.tlb_finish_mmu.exit_mmap.__mmput.exit_mm.do_exit
>       5.22            -1.2        3.97 ±  3%  perf-profile.calltrace.cycles-pp.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput.exit_mm
>       4.83 ±  2%      -1.2        3.62 ±  3%  perf-profile.calltrace.cycles-pp.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap.dup_mm
>       2.58 ±  3%      -1.1        1.53 ± 10%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_anon_vmas
>       2.72 ±  3%      -1.0        1.67 ±  7%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.anon_vma_clone
>       4.17            -1.0        3.15 ±  3%  perf-profile.calltrace.cycles-pp.release_pages.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
>       2.78 ±  2%      -1.0        1.80 ±  6%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.anon_vma_fork
>       3.54            -0.9        2.64 ±  3%  perf-profile.calltrace.cycles-pp.copy_present_pte.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
>       2.91            -0.8        2.07 ±  4%  perf-profile.calltrace.cycles-pp.wait4
>       2.88            -0.8        2.05 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.wait4
>       2.87            -0.8        2.04 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
>       2.83            -0.8        2.01 ±  4%  perf-profile.calltrace.cycles-pp.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
>       2.82            -0.8        2.00 ±  4%  perf-profile.calltrace.cycles-pp.kernel_wait4.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
>       2.77            -0.8        1.96 ±  4%  perf-profile.calltrace.cycles-pp.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       8.13            -0.8        7.37 ±  2%  perf-profile.calltrace.cycles-pp.setsid
>       8.11            -0.8        7.35 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.setsid
>       8.11            -0.8        7.35 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.setsid
>       8.07            -0.8        7.32 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_setsid.do_syscall_64.entry_SYSCALL_64_after_hwframe.setsid
>       8.07            -0.8        7.32 ±  2%  perf-profile.calltrace.cycles-pp.ksys_setsid.__x64_sys_setsid.do_syscall_64.entry_SYSCALL_64_after_hwframe.setsid
>       1.74            -0.7        1.08 ±  5%  perf-profile.calltrace.cycles-pp._compound_head.copy_present_pte.copy_pte_range.copy_p4d_range.copy_page_range
>       7.80            -0.6        7.18        perf-profile.calltrace.cycles-pp.sched_autogroup_create_attach.ksys_setsid.__x64_sys_setsid.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       2.50            -0.6        1.90 ±  2%  perf-profile.calltrace.cycles-pp.vm_area_dup.dup_mmap.dup_mm.copy_process.kernel_clone
>       3.58            -0.6        3.01 ±  2%  perf-profile.calltrace.cycles-pp.anon_vma_interval_tree_insert.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm
>       2.42 ±  2%      -0.6        1.86 ±  4%  perf-profile.calltrace.cycles-pp.mm_init.dup_mm.copy_process.kernel_clone.__do_sys_clone
>       0.80            -0.5        0.26 ±100%  perf-profile.calltrace.cycles-pp.dup_task_struct.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
>       2.81            -0.5        2.30 ±  3%  perf-profile.calltrace.cycles-pp.online_fair_sched_group.sched_autogroup_create_attach.ksys_setsid.__x64_sys_setsid.do_syscall_64
>       1.92 ±  9%      -0.4        1.50 ±  6%  perf-profile.calltrace.cycles-pp.down_write.dup_mmap.dup_mm.copy_process.kernel_clone
>       1.31            -0.4        0.90 ±  4%  perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.anon_vma_fork
>       2.30 ±  4%      -0.4        1.90 ±  5%  perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.exit_mmap.__mmput.exit_mm
>       1.67            -0.4        1.29 ±  4%  perf-profile.calltrace.cycles-pp.schedule.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
>       1.66            -0.4        1.28 ±  4%  perf-profile.calltrace.cycles-pp.__schedule.schedule.do_wait.kernel_wait4.__do_sys_wait4
>       1.68 ±  2%      -0.4        1.30 ±  4%  perf-profile.calltrace.cycles-pp.__percpu_counter_init.mm_init.dup_mm.copy_process.kernel_clone
>       1.52            -0.4        1.17 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.vm_area_dup.dup_mmap.dup_mm.copy_process
>       3.53            -0.3        3.20        perf-profile.calltrace.cycles-pp.page_remove_rmap.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
>       1.46 ±  3%      -0.3        1.13 ±  5%  perf-profile.calltrace.cycles-pp.pcpu_alloc.__percpu_counter_init.mm_init.dup_mm.copy_process
>       1.42 ±  7%      -0.3        1.10 ±  8%  perf-profile.calltrace.cycles-pp.down_write.unlink_file_vma.free_pgtables.exit_mmap.__mmput
>       1.18            -0.3        0.87 ±  5%  perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.anon_vma_clone
>       1.00 ± 15%      -0.3        0.69 ± 13%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.dup_mmap.dup_mm.copy_process
>       0.96 ± 15%      -0.3        0.66 ± 13%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.dup_mmap.dup_mm
>       0.97 ±  2%      -0.3        0.68 ±  4%  perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_anon_vmas
>       4.07            -0.3        3.80        perf-profile.calltrace.cycles-pp.kmalloc_node_trace.alloc_fair_sched_group.sched_create_group.sched_autogroup_create_attach.ksys_setsid
>       4.04            -0.3        3.77        perf-profile.calltrace.cycles-pp.__kmem_cache_alloc_node.kmalloc_node_trace.alloc_fair_sched_group.sched_create_group.sched_autogroup_create_attach
>       0.90 ± 11%      -0.3        0.64 ± 13%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.unlink_file_vma.free_pgtables.exit_mmap
>       0.86 ± 11%      -0.2        0.62 ± 13%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_file_vma.free_pgtables
>       1.87            -0.2        1.63        perf-profile.calltrace.cycles-pp.memcg_slab_post_alloc_hook.__kmem_cache_alloc_node.kmalloc_node_trace.alloc_fair_sched_group.sched_create_group
>       1.19            -0.2        0.96 ±  2%  perf-profile.calltrace.cycles-pp.__anon_vma_interval_tree_remove.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput
>       1.00 ±  2%      -0.2        0.78 ±  3%  perf-profile.calltrace.cycles-pp.free_pages_and_swap_cache.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
>       0.98 ±  2%      -0.2        0.77 ±  2%  perf-profile.calltrace.cycles-pp.free_swap_cache.free_pages_and_swap_cache.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap
>       1.01            -0.2        0.81 ±  2%  perf-profile.calltrace.cycles-pp.raw_spin_rq_lock_nested.online_fair_sched_group.sched_autogroup_create_attach.ksys_setsid.__x64_sys_setsid
>       1.00            -0.2        0.80 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock.raw_spin_rq_lock_nested.online_fair_sched_group.sched_autogroup_create_attach.ksys_setsid
>       1.58            -0.2        1.39 ±  3%  perf-profile.calltrace.cycles-pp.___slab_alloc.__kmem_cache_alloc_node.kmalloc_node_trace.alloc_fair_sched_group.sched_create_group
>       0.86            -0.2        0.67 ±  2%  perf-profile.calltrace.cycles-pp.memcg_slab_post_alloc_hook.kmem_cache_alloc.vm_area_dup.dup_mmap.dup_mm
>       0.62 ±  2%      -0.2        0.43 ± 44%  perf-profile.calltrace.cycles-pp.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput
>       0.82            -0.2        0.64 ±  3%  perf-profile.calltrace.cycles-pp.wake_up_new_task.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.69            -0.2        0.53 ±  2%  perf-profile.calltrace.cycles-pp.__vm_area_free.exit_mmap.__mmput.exit_mm.do_exit
>       0.72            -0.1        0.57 ±  3%  perf-profile.calltrace.cycles-pp.attach_entity_cfs_rq.online_fair_sched_group.sched_autogroup_create_attach.ksys_setsid.__x64_sys_setsid
>       1.00 ±  2%      -0.1        0.86 ±  3%  perf-profile.calltrace.cycles-pp.up_write.dup_mmap.dup_mm.copy_process.kernel_clone
>       0.73            -0.1        0.59 ±  2%  perf-profile.calltrace.cycles-pp.__slab_free.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput
>       0.74 ±  2%      -0.1        0.61 ±  2%  perf-profile.calltrace.cycles-pp.remove_vma.exit_mmap.__mmput.exit_mm.do_exit
>       0.66 ±  2%      -0.1        0.55 ±  3%  perf-profile.calltrace.cycles-pp.fput.remove_vma.exit_mmap.__mmput.exit_mm
>       1.03            -0.1        0.92 ±  2%  perf-profile.calltrace.cycles-pp.mas_store.dup_mmap.dup_mm.copy_process.kernel_clone
>       0.88 ±  2%      -0.1        0.78 ±  2%  perf-profile.calltrace.cycles-pp.up_write.free_pgtables.exit_mmap.__mmput.exit_mm
>       0.69            -0.1        0.60 ±  3%  perf-profile.calltrace.cycles-pp.deactivate_slab.___slab_alloc.__kmem_cache_alloc_node.kmalloc_node_trace.alloc_fair_sched_group
>       0.61            -0.1        0.54 ±  3%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm
>       0.67            -0.1        0.60 ±  2%  perf-profile.calltrace.cycles-pp.update_rq_clock_task.online_fair_sched_group.sched_autogroup_create_attach.ksys_setsid.__x64_sys_setsid
>       0.62            -0.1        0.56        perf-profile.calltrace.cycles-pp.mas_wr_bnode.mas_store.dup_mmap.dup_mm.copy_process
>       0.79            -0.1        0.73 ±  2%  perf-profile.calltrace.cycles-pp.vma_interval_tree_remove.unlink_file_vma.free_pgtables.exit_mmap.__mmput
>       0.69 ±  9%      +0.3        0.94 ±  8%  perf-profile.calltrace.cycles-pp.stress_fork_fn
>       0.63 ± 10%      +0.3        0.89 ±  8%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.stress_fork_fn
>       0.58 ±  9%      +0.3        0.85 ±  8%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.stress_fork_fn
>       0.58 ±  9%      +0.3        0.85 ±  8%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.stress_fork_fn
>       0.45 ± 45%      +0.4        0.82 ±  9%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.stress_fork_fn
>       0.00            +0.7        0.69 ± 10%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt
>       0.00            +0.7        0.70 ± 10%  perf-profile.calltrace.cycles-pp.rcu_core.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
>       0.00            +0.7        0.70 ±  8%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.getpid@plt
>       0.00            +0.7        0.70 ± 10%  perf-profile.calltrace.cycles-pp.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.filemap_map_pages
>       0.00            +0.7        0.70 ± 10%  perf-profile.calltrace.cycles-pp.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.filemap_map_pages.do_read_fault
>       0.00            +0.7        0.71 ±  8%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.getpid@plt
>       0.00            +0.7        0.71 ±  9%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.getpid@plt
>       0.00            +0.7        0.72 ±  8%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.getpid@plt
>       0.00            +0.7        0.73 ±  9%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.shim_vhangup
>       0.00            +0.7        0.73 ±  9%  perf-profile.calltrace.cycles-pp.getpid@plt
>       0.00            +0.8        0.75 ±  9%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.shim_vhangup
>       0.00            +0.8        0.75 ±  9%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.shim_vhangup
>       0.00            +0.8        0.77 ±  9%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.shim_vhangup
>       0.00            +0.8        0.78 ±  8%  perf-profile.calltrace.cycles-pp.shim_vhangup
>       0.00            +0.8        0.80 ± 10%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.filemap_map_pages.do_read_fault.do_fault
>       0.00            +0.8        0.81 ± 10%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault
>       1.03            +1.3        2.36 ±  5%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.__libc_fork
>       0.90            +1.4        2.25 ±  5%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.__libc_fork
>       0.90            +1.4        2.25 ±  5%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.__libc_fork
>       0.74 ±  2%      +1.4        2.15 ±  6%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.__libc_fork
>       0.00            +1.8        1.78 ±  7%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.strchrnul@plt
>       0.00            +1.8        1.78 ±  7%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.vhangup
>       0.00            +1.8        1.79 ±  7%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.strchrnul@plt
>       0.00            +1.8        1.79 ±  7%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.strchrnul@plt
>       0.00            +1.8        1.80 ±  7%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.vhangup
>       0.00            +1.8        1.80 ±  7%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.vhangup
>       0.00            +1.8        1.80 ±  7%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.__sched_yield
>       0.00            +1.8        1.80 ±  7%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.strchrnul@plt
>       0.00            +1.8        1.80 ±  7%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.__snprintf_chk
>       0.00            +1.8        1.80 ±  7%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.vhangup
>       0.00            +1.8        1.81 ±  7%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.__sched_yield
>       0.00            +1.8        1.81 ±  7%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.__sched_yield
>       0.00            +1.8        1.81 ±  7%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.__snprintf_chk
>       0.00            +1.8        1.81 ±  7%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.__snprintf_chk
>       0.00            +1.8        1.82 ±  7%  perf-profile.calltrace.cycles-pp.strchrnul@plt
>       0.00            +1.8        1.82 ±  7%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.__snprintf_chk
>       0.00            +1.8        1.83 ±  7%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.__sched_yield
>       0.00            +1.8        1.84 ±  7%  perf-profile.calltrace.cycles-pp.vhangup
>       0.00            +1.8        1.84 ±  7%  perf-profile.calltrace.cycles-pp.__snprintf_chk
>       0.00            +1.9        1.92 ±  7%  perf-profile.calltrace.cycles-pp.__sched_yield
>       0.00            +2.9        2.87 ±  2%  perf-profile.calltrace.cycles-pp.next_uptodate_folio.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault
>       7.24 ±  2%     +10.9       18.18 ±  9%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
>       6.80 ±  2%     +11.0       17.80 ±  9%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
>       6.78 ±  2%     +11.0       17.78 ± 10%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
>       6.08 ±  2%     +11.2       17.26 ± 10%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
>       6.64 ±  4%     +22.7       29.37 ±  6%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
>       4.79 ±  2%     +23.1       27.93 ±  7%  perf-profile.calltrace.cycles-pp.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
>       4.91 ±  2%     +23.3       28.25 ±  7%  perf-profile.calltrace.cycles-pp.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
>       4.92 ±  2%     +23.3       28.26 ±  7%  perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
>      82.82           -18.3       64.50 ±  2%  perf-profile.children.cycles-pp.do_syscall_64
>      82.84           -18.3       64.51 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
>      35.18            -8.4       26.82 ±  3%  perf-profile.children.cycles-pp.__do_sys_clone
>      35.18            -8.4       26.82 ±  3%  perf-profile.children.cycles-pp.kernel_clone
>      34.32            -8.2       26.15 ±  3%  perf-profile.children.cycles-pp.copy_process
>      35.78            -8.1       27.66 ±  2%  perf-profile.children.cycles-pp.do_exit
>      35.78            -8.1       27.66 ±  2%  perf-profile.children.cycles-pp.__x64_sys_exit_group
>      35.78            -8.1       27.66 ±  2%  perf-profile.children.cycles-pp.do_group_exit
>      32.41            -7.6       24.78 ±  3%  perf-profile.children.cycles-pp.dup_mm
>      33.68            -7.5       26.16 ±  2%  perf-profile.children.cycles-pp.exit_mm
>      33.54            -7.5       26.03 ±  2%  perf-profile.children.cycles-pp.exit_mmap
>      33.63            -7.5       26.13 ±  2%  perf-profile.children.cycles-pp.__mmput
>      37.08            -7.4       29.68 ±  2%  perf-profile.children.cycles-pp.__libc_fork
>      29.95            -7.1       22.89 ±  3%  perf-profile.children.cycles-pp.dup_mmap
>       6.50            -6.5        0.00        perf-profile.children.cycles-pp.next_uptodate_page
>      17.25            -5.3       12.00 ±  5%  perf-profile.children.cycles-pp.down_write
>      14.39            -4.8        9.56 ±  7%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
>      14.18            -4.8        9.40 ±  7%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
>      15.69            -4.1       11.56 ±  4%  perf-profile.children.cycles-pp.anon_vma_fork
>      10.16            -3.8        6.40 ±  8%  perf-profile.children.cycles-pp.osq_lock
>      12.54            -2.9        9.60 ±  3%  perf-profile.children.cycles-pp.free_pgtables
>      13.13            -2.9       10.27 ±  2%  perf-profile.children.cycles-pp.unmap_vmas
>      12.54            -2.7        9.84 ±  2%  perf-profile.children.cycles-pp.unmap_page_range
>      12.41            -2.7        9.73 ±  2%  perf-profile.children.cycles-pp.zap_pmd_range
>      12.31            -2.7        9.64        perf-profile.children.cycles-pp.zap_pte_range
>      10.06            -2.5        7.60 ±  3%  perf-profile.children.cycles-pp.anon_vma_clone
>       8.73            -2.3        6.42 ±  4%  perf-profile.children.cycles-pp.unlink_anon_vmas
>       7.28            -2.2        5.04 ±  3%  perf-profile.children.cycles-pp._compound_head
>       5.34            -1.3        4.00 ±  3%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
>       5.40            -1.3        4.07 ±  3%  perf-profile.children.cycles-pp.copy_page_range
>       5.30            -1.3        3.99 ±  3%  perf-profile.children.cycles-pp.copy_p4d_range
>       5.26            -1.3        4.01 ±  3%  perf-profile.children.cycles-pp.tlb_finish_mmu
>       5.22            -1.2        3.97 ±  3%  perf-profile.children.cycles-pp.tlb_batch_pages_flush
>       4.84 ±  2%      -1.2        3.64 ±  3%  perf-profile.children.cycles-pp.copy_pte_range
>       3.86            -1.1        2.77 ±  4%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
>       4.19            -1.0        3.16 ±  3%  perf-profile.children.cycles-pp.release_pages
>       3.59            -0.9        2.68 ±  3%  perf-profile.children.cycles-pp.copy_present_pte
>       2.92            -0.8        2.08 ±  4%  perf-profile.children.cycles-pp.wait4
>       2.83            -0.8        2.01 ±  4%  perf-profile.children.cycles-pp.__do_sys_wait4
>       2.82            -0.8        2.00 ±  4%  perf-profile.children.cycles-pp.kernel_wait4
>       2.77            -0.8        1.96 ±  4%  perf-profile.children.cycles-pp.do_wait
>       8.14            -0.8        7.37 ±  2%  perf-profile.children.cycles-pp.setsid
>       8.08            -0.8        7.32 ±  2%  perf-profile.children.cycles-pp.__x64_sys_setsid
>       8.08            -0.8        7.32 ±  2%  perf-profile.children.cycles-pp.ksys_setsid
>       5.74            -0.7        5.03 ±  2%  perf-profile.children.cycles-pp.__do_softirq
>       1.20 ±  2%      -0.7        0.53 ±  8%  perf-profile.children.cycles-pp.ret_from_fork_asm
>       2.56            -0.7        1.90 ±  4%  perf-profile.children.cycles-pp.__schedule
>       1.15 ±  2%      -0.7        0.50 ±  8%  perf-profile.children.cycles-pp.ret_from_fork
>       5.59            -0.6        4.95 ±  2%  perf-profile.children.cycles-pp.rcu_core
>       5.56            -0.6        4.91 ±  2%  perf-profile.children.cycles-pp.rcu_do_batch
>       7.80            -0.6        7.18        perf-profile.children.cycles-pp.sched_autogroup_create_attach
>       2.86            -0.6        2.25 ±  2%  perf-profile.children.cycles-pp.kmem_cache_alloc
>       1.23 ±  2%      -0.6        0.62 ±  7%  perf-profile.children.cycles-pp.queued_write_lock_slowpath
>       2.51            -0.6        1.90 ±  2%  perf-profile.children.cycles-pp.vm_area_dup
>       3.60            -0.6        3.03 ±  2%  perf-profile.children.cycles-pp.anon_vma_interval_tree_insert
>       6.22            -0.6        5.65 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
>       6.26            -0.6        5.70 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
>       2.43 ±  2%      -0.6        1.87 ±  4%  perf-profile.children.cycles-pp.mm_init
>       3.52            -0.6        2.96        perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
>       2.82            -0.5        2.31 ±  2%  perf-profile.children.cycles-pp.online_fair_sched_group
>       1.10            -0.5        0.60 ±  7%  perf-profile.children.cycles-pp.pick_next_task_fair
>       1.42 ±  4%      -0.5        0.92 ±  6%  perf-profile.children.cycles-pp.__alloc_pages
>       5.43            -0.5        4.94 ±  2%  perf-profile.children.cycles-pp.__irq_exit_rcu
>       1.02 ±  2%      -0.5        0.54 ±  7%  perf-profile.children.cycles-pp.newidle_balance
>       4.50            -0.5        4.03 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
>       2.84            -0.5        2.38 ±  2%  perf-profile.children.cycles-pp.__slab_free
>       2.06 ±  2%      -0.5        1.61 ±  4%  perf-profile.children.cycles-pp.pcpu_alloc
>       0.92 ±  2%      -0.4        0.47 ±  7%  perf-profile.children.cycles-pp.load_balance
>       2.31 ±  4%      -0.4        1.91 ±  5%  perf-profile.children.cycles-pp.unlink_file_vma
>       1.68 ±  2%      -0.4        1.31 ±  4%  perf-profile.children.cycles-pp.__percpu_counter_init
>       2.84            -0.4        2.49 ±  2%  perf-profile.children.cycles-pp.up_write
>       3.52            -0.4        3.17 ±  2%  perf-profile.children.cycles-pp.sched_free_group_rcu
>       1.95            -0.4        1.60        perf-profile.children.cycles-pp._raw_spin_lock
>       1.49 ±  2%      -0.3        1.15 ±  3%  perf-profile.children.cycles-pp.finish_task_switch
>       0.65 ±  3%      -0.3        0.31 ±  6%  perf-profile.children.cycles-pp.schedule_tail
>       3.48            -0.3        3.14 ±  2%  perf-profile.children.cycles-pp.free_fair_sched_group
>       1.86            -0.3        1.52 ±  3%  perf-profile.children.cycles-pp.schedule
>       1.51            -0.3        1.18 ±  2%  perf-profile.children.cycles-pp.kmem_cache_free
>       1.91            -0.3        1.59 ±  3%  perf-profile.children.cycles-pp.___slab_alloc
>       3.56            -0.3        3.24        perf-profile.children.cycles-pp.page_remove_rmap
>       0.67 ±  2%      -0.3        0.35 ±  7%  perf-profile.children.cycles-pp.update_sd_lb_stats
>       0.68 ±  2%      -0.3        0.36 ±  7%  perf-profile.children.cycles-pp.find_busiest_group
>       0.48 ±  3%      -0.3        0.18 ± 12%  perf-profile.children.cycles-pp.kthread
>       0.63 ±  2%      -0.3        0.33 ±  8%  perf-profile.children.cycles-pp.update_sg_lb_stats
>       4.19            -0.3        3.89        perf-profile.children.cycles-pp.__kmem_cache_alloc_node
>       0.84 ±  4%      -0.3        0.54 ±  6%  perf-profile.children.cycles-pp.get_page_from_freelist
>       0.50 ±  2%      -0.3        0.20 ± 10%  perf-profile.children.cycles-pp.__perf_sw_event
>       0.80            -0.3        0.51 ±  4%  perf-profile.children.cycles-pp.dup_task_struct
>       0.48 ±  2%      -0.3        0.19 ±  9%  perf-profile.children.cycles-pp.___perf_sw_event
>       0.62 ±  2%      -0.3        0.34 ±  8%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
>       0.62 ±  2%      -0.3        0.34 ±  8%  perf-profile.children.cycles-pp.cpu_startup_entry
>       0.62 ±  2%      -0.3        0.34 ±  8%  perf-profile.children.cycles-pp.do_idle
>       0.79 ±  8%      -0.3        0.52 ± 10%  perf-profile.children.cycles-pp.pte_alloc_one
>       0.61 ±  2%      -0.3        0.34 ±  7%  perf-profile.children.cycles-pp.start_secondary
>       1.29 ±  2%      -0.3        1.01 ±  3%  perf-profile.children.cycles-pp.__mmdrop
>       4.08            -0.3        3.81        perf-profile.children.cycles-pp.kmalloc_node_trace
>       0.89 ±  5%      -0.2        0.65 ±  7%  perf-profile.children.cycles-pp.__mutex_lock
>       0.53 ±  2%      -0.2        0.29 ±  4%  perf-profile.children.cycles-pp.alloc_thread_stack_node
>       0.35 ±  5%      -0.2        0.11 ± 12%  perf-profile.children.cycles-pp.smpboot_thread_fn
>       1.09            -0.2        0.86 ±  2%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
>       1.20            -0.2        0.96 ±  2%  perf-profile.children.cycles-pp.__anon_vma_interval_tree_remove
>       0.63 ± 11%      -0.2        0.40 ± 11%  perf-profile.children.cycles-pp.__pte_alloc
>       0.49 ±  3%      -0.2        0.26 ±  6%  perf-profile.children.cycles-pp.queued_read_lock_slowpath
>       1.04 ±  2%      -0.2        0.81 ±  3%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
>       0.32 ±  5%      -0.2        0.10 ± 14%  perf-profile.children.cycles-pp.run_ksoftirqd
>       0.50 ±  2%      -0.2        0.28 ±  6%  perf-profile.children.cycles-pp.do_task_dead
>       1.01 ±  2%      -0.2        0.79 ±  2%  perf-profile.children.cycles-pp.free_swap_cache
>       0.67            -0.2        0.46 ±  5%  perf-profile.children.cycles-pp.lock_vma_under_rcu
>       0.26 ±  5%      -0.2        0.06 ± 11%  perf-profile.children.cycles-pp.__vmalloc_node_range
>       0.50 ±  3%      -0.2        0.30 ±  8%  perf-profile.children.cycles-pp.clear_page_erms
>       0.60 ±  2%      -0.2        0.41 ±  3%  perf-profile.children.cycles-pp.exit_notify
>       0.55 ±  5%      -0.2        0.36 ±  8%  perf-profile.children.cycles-pp.__memcg_kmem_charge_page
>       1.29            -0.2        1.10 ±  2%  perf-profile.children.cycles-pp.sched_unregister_group_rcu
>       0.54 ±  2%      -0.2        0.36 ±  5%  perf-profile.children.cycles-pp.wait_task_zombie
>       1.28            -0.2        1.10 ±  2%  perf-profile.children.cycles-pp.unregister_fair_sched_group
>       0.82            -0.2        0.64 ±  3%  perf-profile.children.cycles-pp.wake_up_new_task
>       0.38 ±  2%      -0.2        0.21 ±  6%  perf-profile.children.cycles-pp.__setpgid
>       0.37 ±  3%      -0.2        0.20 ±  8%  perf-profile.children.cycles-pp.cpuidle_idle_call
>       0.50 ±  2%      -0.2        0.33 ±  4%  perf-profile.children.cycles-pp.release_task
>       0.52 ± 14%      -0.2        0.35 ± 11%  perf-profile.children.cycles-pp.machine__process_fork_event
>       0.34 ±  2%      -0.2        0.18 ±  5%  perf-profile.children.cycles-pp.__do_sys_setpgid
>       0.69            -0.2        0.53 ±  2%  perf-profile.children.cycles-pp.__vm_area_free
>       0.83 ±  2%      -0.2        0.68 ±  4%  perf-profile.children.cycles-pp.wp_page_copy
>       0.74            -0.1        0.59 ±  3%  perf-profile.children.cycles-pp.attach_entity_cfs_rq
>       0.32 ±  4%      -0.1        0.17 ±  8%  perf-profile.children.cycles-pp.cpuidle_enter
>       0.31 ±  4%      -0.1        0.17 ±  9%  perf-profile.children.cycles-pp.cpuidle_enter_state
>       0.69            -0.1        0.55 ±  3%  perf-profile.children.cycles-pp.update_load_avg
>       0.53            -0.1        0.39 ±  4%  perf-profile.children.cycles-pp.__list_del_entry_valid
>       0.50            -0.1        0.36 ±  4%  perf-profile.children.cycles-pp.unmap_single_vma
>       0.75 ±  2%      -0.1        0.61 ±  2%  perf-profile.children.cycles-pp.remove_vma
>       0.54            -0.1        0.41 ±  2%  perf-profile.children.cycles-pp._exit
>       1.04            -0.1        0.91 ±  2%  perf-profile.children.cycles-pp.remove_entity_load_avg
>       0.84            -0.1        0.72 ±  3%  perf-profile.children.cycles-pp.mod_objcg_state
>       0.68            -0.1        0.55 ±  2%  perf-profile.children.cycles-pp.select_task_rq_fair
>       0.44 ±  2%      -0.1        0.32 ±  2%  perf-profile.children.cycles-pp.acct_collect
>       0.68 ±  2%      -0.1        0.57 ±  2%  perf-profile.children.cycles-pp.fput
>       1.03            -0.1        0.92 ±  2%  perf-profile.children.cycles-pp.mas_store
>       0.62            -0.1        0.51 ±  4%  perf-profile.children.cycles-pp.get_partial_node
>       0.39 ±  3%      -0.1        0.28 ±  7%  perf-profile.children.cycles-pp.copy_mc_enhanced_fast_string
>       0.62 ±  2%      -0.1        0.51 ±  2%  perf-profile.children.cycles-pp.__put_anon_vma
>       0.39 ±  3%      -0.1        0.28 ±  6%  perf-profile.children.cycles-pp.__wp_page_copy_user
>       0.31 ±  4%      -0.1        0.20 ±  7%  perf-profile.children.cycles-pp.rmqueue
>       0.57            -0.1        0.46 ±  2%  perf-profile.children.cycles-pp.find_idlest_cpu
>       0.32 ±  4%      -0.1        0.21 ±  7%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
>       0.48 ±  3%      -0.1        0.37 ±  3%  perf-profile.children.cycles-pp.free_percpu
>       0.71            -0.1        0.61 ±  4%  perf-profile.children.cycles-pp.deactivate_slab
>       0.44 ±  4%      -0.1        0.34 ±  4%  perf-profile.children.cycles-pp.percpu_counter_destroy
>       0.14 ±  4%      -0.1        0.05 ± 45%  perf-profile.children.cycles-pp.rmqueue_bulk
>       0.30 ±  5%      -0.1        0.21 ± 10%  perf-profile.children.cycles-pp.cgroup_rstat_updated
>       0.76            -0.1        0.68 ±  3%  perf-profile.children.cycles-pp.update_rq_clock_task
>       0.58 ±  2%      -0.1        0.49 ±  3%  perf-profile.children.cycles-pp.__percpu_counter_sum
>       0.53            -0.1        0.44 ±  2%  perf-profile.children.cycles-pp.find_idlest_group
>       0.28 ± 14%      -0.1        0.19 ± 11%  perf-profile.children.cycles-pp.____machine__findnew_thread
>       1.97 ±  2%      -0.1        1.88        perf-profile.children.cycles-pp.__unfreeze_partials
>       0.51            -0.1        0.42 ±  2%  perf-profile.children.cycles-pp.update_sg_wakeup_stats
>       0.26 ±  5%      -0.1        0.18 ±  8%  perf-profile.children.cycles-pp.memcg_account_kmem
>       0.24 ± 15%      -0.1        0.15 ± 12%  perf-profile.children.cycles-pp.maps__clone
>       0.78            -0.1        0.70 ±  2%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
>       0.18 ±  5%      -0.1        0.10 ± 12%  perf-profile.children.cycles-pp.free_unref_page
>       0.78            -0.1        0.70 ±  2%  perf-profile.children.cycles-pp.hrtimer_interrupt
>       0.23 ±  2%      -0.1        0.15 ±  6%  perf-profile.children.cycles-pp.down_read_trylock
>       0.18 ±  2%      -0.1        0.10 ±  8%  perf-profile.children.cycles-pp.schedule_idle
>       0.69            -0.1        0.61 ±  3%  perf-profile.children.cycles-pp.__hrtimer_run_queues
>       0.38            -0.1        0.30 ± 22%  perf-profile.children.cycles-pp.do_wp_page
>       0.40 ±  2%      -0.1        0.32 ±  2%  perf-profile.children.cycles-pp.attach_entity_load_avg
>       0.31 ±  2%      -0.1        0.24 ±  3%  perf-profile.children.cycles-pp.dequeue_task_fair
>       0.43 ±  2%      -0.1        0.35 ± 10%  perf-profile.children.cycles-pp.sync_regs
>       0.40 ±  2%      -0.1        0.32 ±  2%  perf-profile.children.cycles-pp.__rb_erase_color
>       0.60            -0.1        0.52 ±  3%  perf-profile.children.cycles-pp.tick_sched_handle
>       0.59            -0.1        0.52 ±  2%  perf-profile.children.cycles-pp.update_process_times
>       0.26 ±  2%      -0.1        0.18 ±  6%  perf-profile.children.cycles-pp.mas_walk
>       0.62 ±  2%      -0.1        0.55 ±  3%  perf-profile.children.cycles-pp.tick_sched_timer
>       0.20 ±  2%      -0.1        0.13 ±  5%  perf-profile.children.cycles-pp.__put_user_4
>       0.13 ±  6%      -0.1        0.06 ± 15%  perf-profile.children.cycles-pp.free_pcppages_bulk
>       0.79            -0.1        0.73 ±  2%  perf-profile.children.cycles-pp.vma_interval_tree_remove
>       0.25            -0.1        0.18 ±  2%  perf-profile.children.cycles-pp.mtree_range_walk
>       0.23            -0.1        0.16 ±  3%  perf-profile.children.cycles-pp.activate_task
>       0.40 ±  2%      -0.1        0.34 ±  2%  perf-profile.children.cycles-pp.mas_next_slot
>       0.33 ±  4%      -0.1        0.26 ±  5%  perf-profile.children.cycles-pp.percpu_counter_add_batch
>       0.27 ±  2%      -0.1        0.20 ±  2%  perf-profile.children.cycles-pp.kfree
>       0.12 ±  3%      -0.1        0.06 ± 13%  perf-profile.children.cycles-pp.worker_thread
>       0.24 ±  2%      -0.1        0.18 ±  4%  perf-profile.children.cycles-pp.dequeue_entity
>       0.62            -0.1        0.56        perf-profile.children.cycles-pp.mas_wr_bnode
>       0.16 ±  4%      -0.1        0.10 ±  6%  perf-profile.children.cycles-pp.update_blocked_averages
>       0.18 ±  4%      -0.1        0.12 ±  5%  perf-profile.children.cycles-pp.pgd_alloc
>       0.14 ±  3%      -0.1        0.07 ± 10%  perf-profile.children.cycles-pp.intel_idle
>       0.24            -0.1        0.18 ±  4%  perf-profile.children.cycles-pp.enqueue_task_fair
>       0.18 ±  4%      -0.1        0.12 ±  4%  perf-profile.children.cycles-pp.__get_free_pages
>       0.15            -0.1        0.09 ±  6%  perf-profile.children.cycles-pp.allocate_slab
>       0.56            -0.1        0.50 ±  2%  perf-profile.children.cycles-pp.mas_split
>       0.29            -0.1        0.24 ±  3%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
>       0.50 ±  3%      -0.1        0.44 ±  4%  perf-profile.children.cycles-pp.osq_unlock
>       0.49 ±  2%      -0.1        0.43 ±  2%  perf-profile.children.cycles-pp.scheduler_tick
>       0.38            -0.1        0.32 ±  2%  perf-profile.children.cycles-pp.sched_move_task
>       0.13 ± 11%      -0.1        0.08 ± 12%  perf-profile.children.cycles-pp.do_anonymous_page
>       0.20 ±  8%      -0.1        0.15 ±  8%  perf-profile.children.cycles-pp.try_charge_memcg
>       0.27 ±  2%      -0.1        0.22 ±  5%  perf-profile.children.cycles-pp.__memcpy
>       0.18 ± 13%      -0.1        0.13 ± 12%  perf-profile.children.cycles-pp.nsinfo__new
>       0.30 ±  3%      -0.0        0.25 ±  2%  perf-profile.children.cycles-pp._find_next_bit
>       0.42 ±  2%      -0.0        0.38 ±  2%  perf-profile.children.cycles-pp.__cond_resched
>       0.18 ±  6%      -0.0        0.13 ±  8%  perf-profile.children.cycles-pp.mutex_spin_on_owner
>       0.18 ± 13%      -0.0        0.13 ± 12%  perf-profile.children.cycles-pp.thread__new
>       0.18 ±  2%      -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.vma_alloc_folio
>       0.24 ±  5%      -0.0        0.19 ±  2%  perf-profile.children.cycles-pp.obj_cgroup_charge
>       0.22 ±  4%      -0.0        0.17 ±  4%  perf-profile.children.cycles-pp.__reclaim_stacks
>       0.18 ±  2%      -0.0        0.13 ±  4%  perf-profile.children.cycles-pp.enqueue_entity
>       0.16 ±  4%      -0.0        0.11 ±  6%  perf-profile.children.cycles-pp.__mem_cgroup_charge
>       0.51 ±  5%      -0.0        0.46 ±  3%  perf-profile.children.cycles-pp.__put_task_struct
>       0.16 ±  3%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.__folio_alloc
>       0.24 ±  4%      -0.0        0.19 ±  3%  perf-profile.children.cycles-pp.vma_interval_tree_insert_after
>       0.19 ±  3%      -0.0        0.15 ±  5%  perf-profile.children.cycles-pp.__list_add_valid
>       0.16 ± 12%      -0.0        0.11 ± 12%  perf-profile.children.cycles-pp.vfs_statx
>       0.17 ± 13%      -0.0        0.12 ± 13%  perf-profile.children.cycles-pp.__do_sys_newstat
>       0.12 ±  4%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.cpu_util
>       0.33 ±  2%      -0.0        0.29 ±  4%  perf-profile.children.cycles-pp.mas_wr_store_entry
>       0.25 ±  2%      -0.0        0.21 ±  2%  perf-profile.children.cycles-pp.do_notify_parent
>       0.24 ±  2%      -0.0        0.20 ±  2%  perf-profile.children.cycles-pp.__rb_insert_augmented
>       0.21 ±  2%      -0.0        0.17 ±  6%  perf-profile.children.cycles-pp.arch_dup_task_struct
>       0.24 ±  3%      -0.0        0.20 ±  2%  perf-profile.children.cycles-pp.__anon_vma_interval_tree_augment_rotate
>       0.22 ±  2%      -0.0        0.18 ±  3%  perf-profile.children.cycles-pp.mas_push_data
>       0.23 ±  2%      -0.0        0.19 ±  2%  perf-profile.children.cycles-pp.perf_event_task_tick
>       0.10 ±  4%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.mas_expected_entries
>       0.10 ±  4%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.mas_alloc_nodes
>       0.09 ±  4%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.__kmem_cache_alloc_bulk
>       0.23 ±  3%      -0.0        0.19 ±  3%  perf-profile.children.cycles-pp.__wake_up_common_lock
>       0.23 ±  2%      -0.0        0.19 ±  2%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
>       0.09 ±  4%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.kmem_cache_alloc_bulk
>       0.24 ±  2%      -0.0        0.20        perf-profile.children.cycles-pp.autogroup_move_group
>       0.13 ±  8%      -0.0        0.09 ±  9%  perf-profile.children.cycles-pp.charge_memcg
>       0.10 ±  4%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.__update_blocked_fair
>       0.07 ± 11%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.step_into
>       0.24 ±  2%      -0.0        0.21        perf-profile.children.cycles-pp.vm_normal_page
>       0.15 ±  3%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.shim_waitpid
>       0.12 ±  7%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.__count_memcg_events
>       0.11 ±  3%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.mas_split_final_node
>       0.08 ±  4%      -0.0        0.05        perf-profile.children.cycles-pp.shuffle_freelist
>       0.13 ±  2%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
>       0.21 ±  2%      -0.0        0.18 ±  5%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
>       0.16 ±  5%      -0.0        0.14 ±  5%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
>       0.12 ±  3%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.mab_mas_cp
>       0.22 ±  2%      -0.0        0.19 ±  3%  perf-profile.children.cycles-pp.mas_wr_append
>       0.06            -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.free_unref_page_prepare
>       0.14 ±  4%      -0.0        0.11 ±  6%  perf-profile.children.cycles-pp.__tlb_remove_page_size
>       0.15 ±  3%      -0.0        0.12 ±  5%  perf-profile.children.cycles-pp.__exit_signal
>       0.08 ±  7%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.switch_fpu_return
>       0.12 ±  5%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
>       0.12 ±  4%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.folio_batch_move_lru
>       0.16 ±  3%      -0.0        0.13 ±  5%  perf-profile.children.cycles-pp.update_curr
>       0.23 ±  2%      -0.0        0.21 ±  3%  perf-profile.children.cycles-pp.try_to_wake_up
>       0.17 ±  4%      -0.0        0.15 ±  4%  perf-profile.children.cycles-pp.mas_update_gap
>       0.15 ±  4%      -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.pcpu_alloc_area
>       0.11 ±  3%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.ttwu_do_activate
>       0.07 ±  5%      -0.0        0.05        perf-profile.children.cycles-pp.get_zeroed_page
>       0.07 ± 12%      -0.0        0.05        perf-profile.children.cycles-pp.rb_next
>       0.12 ±  4%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.alloc_pid
>       0.08 ±  4%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.mark_page_accessed
>       0.15 ±  3%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.refill_obj_stock
>       0.11 ±  4%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp._raw_spin_trylock
>       0.08 ±  5%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.copy_signal
>       0.07 ±  5%      -0.0        0.05        perf-profile.children.cycles-pp.__radix_tree_lookup
>       0.07 ±  5%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.__p4d_alloc
>       0.11 ±  3%      -0.0        0.09        perf-profile.children.cycles-pp.lru_add_drain_cpu
>       0.09            -0.0        0.07 ± 10%  perf-profile.children.cycles-pp.pte_offset_map_nolock
>       0.08 ±  6%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
>       0.14 ±  3%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_irq
>       0.11 ±  3%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.lru_add_drain
>       0.10 ±  4%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.mas_leaf_max_gap
>       0.09            -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.copy_creds
>       0.08 ±  6%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp._raw_write_lock_irq
>       0.12 ±  3%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.perf_iterate_sb
>       0.08 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.pcpu_free_area
>       0.08 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.dup_fd
>       0.08 ±  8%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_list
>       0.07 ±  7%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp._find_next_zero_bit
>       0.09 ±  4%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.free_unref_page_list
>       0.08 ±  5%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.prepare_creds
>       0.09            -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.__pte_offset_map
>       0.09 ±  4%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.update_rq_clock
>       0.10 ±  4%      -0.0        0.09        perf-profile.children.cycles-pp.select_task_rq
>       0.10 ±  4%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.__update_load_avg_blocked_se
>       0.07            -0.0        0.06        perf-profile.children.cycles-pp.perf_event_task_output
>       0.07            -0.0        0.06        perf-profile.children.cycles-pp.propagate_entity_cfs_rq
>       0.06            -0.0        0.05        perf-profile.children.cycles-pp.sched_clock_cpu
>       0.06            -0.0        0.05        perf-profile.children.cycles-pp.__kmem_cache_free
>       0.38            +0.0        0.40        perf-profile.children.cycles-pp.dup_userfaultfd
>       0.06 ± 11%      +0.1        0.12 ±  6%  perf-profile.children.cycles-pp.__getpid
>       0.29            +0.1        0.35 ±  4%  perf-profile.children.cycles-pp.__pte_offset_map_lock
>       0.04 ± 45%      +0.1        0.10 ± 10%  perf-profile.children.cycles-pp.xas_find
>       0.21 ±  3%      +0.1        0.28 ±  3%  perf-profile.children.cycles-pp.init_entity_runnable_average
>       0.83 ±  3%      +0.1        0.91 ±  2%  perf-profile.children.cycles-pp.do_set_pte
>       0.00            +0.1        0.09 ± 10%  perf-profile.children.cycles-pp.xas_load
>       0.00            +0.1        0.10 ±  8%  perf-profile.children.cycles-pp.io_schedule
>       0.00            +0.1        0.10 ±  5%  perf-profile.children.cycles-pp.folio_wait_bit_common
>       0.06 ±  6%      +0.1        0.18 ±  7%  perf-profile.children.cycles-pp.init_tg_cfs_entry
>       0.00            +0.1        0.14 ±  8%  perf-profile.children.cycles-pp.filemap_fault
>       0.00            +0.1        0.14 ±  8%  perf-profile.children.cycles-pp.__do_fault
>       0.47 ±  3%      +0.2        0.63 ±  3%  perf-profile.children.cycles-pp.page_add_file_rmap
>       0.73 ±  9%      +0.2        0.97 ±  7%  perf-profile.children.cycles-pp.stress_fork_fn
>       0.43 ±  8%      +0.3        0.77 ±  8%  perf-profile.children.cycles-pp.getpid@plt
>       0.42            +0.4        0.80 ±  8%  perf-profile.children.cycles-pp.shim_vhangup
>       0.44            +1.4        1.85 ±  7%  perf-profile.children.cycles-pp.vhangup
>       0.40            +1.5        1.85 ±  7%  perf-profile.children.cycles-pp.__snprintf_chk
>       0.48            +1.5        1.93 ±  7%  perf-profile.children.cycles-pp.__sched_yield
>       0.39 ±  2%      +1.5        1.85 ±  7%  perf-profile.children.cycles-pp.strchrnul@plt
>       0.00            +4.9        4.90        perf-profile.children.cycles-pp.next_uptodate_folio
>      13.05           +19.4       32.42 ±  5%  perf-profile.children.cycles-pp.asm_exc_page_fault
>      12.10           +19.5       31.63 ±  6%  perf-profile.children.cycles-pp.exc_page_fault
>      12.07           +19.5       31.61 ±  6%  perf-profile.children.cycles-pp.do_user_addr_fault
>      10.88           +19.8       30.73 ±  6%  perf-profile.children.cycles-pp.handle_mm_fault
>      10.35           +20.1       30.50 ±  6%  perf-profile.children.cycles-pp.__handle_mm_fault
>       8.37           +20.4       28.77 ±  6%  perf-profile.children.cycles-pp.filemap_map_pages
>       8.61           +20.5       29.08 ±  6%  perf-profile.children.cycles-pp.do_fault
>       8.60           +20.5       29.07 ±  6%  perf-profile.children.cycles-pp.do_read_fault
>       6.06            -6.1        0.00        perf-profile.self.cycles-pp.next_uptodate_page
>       9.78            -3.6        6.19 ±  8%  perf-profile.self.cycles-pp.osq_lock
>       6.76            -2.1        4.70 ±  3%  perf-profile.self.cycles-pp._compound_head
>       5.31            -1.3        4.00 ±  3%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
>       3.62            -1.0        2.62 ±  4%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
>       3.42            -0.8        2.65 ±  3%  perf-profile.self.cycles-pp.release_pages
>       2.74 ±  6%      -0.8        1.98 ±  4%  perf-profile.self.cycles-pp.zap_pte_range
>       3.38            -0.5        2.85 ±  2%  perf-profile.self.cycles-pp.anon_vma_interval_tree_insert
>       2.98            -0.5        2.51        perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
>       2.72            -0.4        2.28 ±  2%  perf-profile.self.cycles-pp.__slab_free
>       2.53            -0.3        2.20        perf-profile.self.cycles-pp.down_write
>       2.64            -0.3        2.34 ±  2%  perf-profile.self.cycles-pp.up_write
>       3.31            -0.3        3.03        perf-profile.self.cycles-pp.page_remove_rmap
>       0.42 ±  2%      -0.3        0.15 ± 10%  perf-profile.self.cycles-pp.___perf_sw_event
>       0.51 ±  2%      -0.2        0.26 ±  8%  perf-profile.self.cycles-pp.update_sg_lb_stats
>       0.79 ±  2%      -0.2        0.56 ±  3%  perf-profile.self.cycles-pp.anon_vma_clone
>       0.88            -0.2        0.66 ±  2%  perf-profile.self.cycles-pp.vm_area_dup
>       1.66            -0.2        1.44 ±  2%  perf-profile.self.cycles-pp.copy_present_pte
>       1.12            -0.2        0.91 ±  2%  perf-profile.self.cycles-pp.__anon_vma_interval_tree_remove
>       0.77 ±  2%      -0.2        0.57 ±  3%  perf-profile.self.cycles-pp.kmem_cache_free
>       1.24            -0.2        1.05 ±  2%  perf-profile.self.cycles-pp.dup_mmap
>       0.47 ±  4%      -0.2        0.28 ±  6%  perf-profile.self.cycles-pp.clear_page_erms
>       0.90 ±  2%      -0.2        0.72 ±  2%  perf-profile.self.cycles-pp.free_swap_cache
>       1.17            -0.1        1.03        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
>       0.51            -0.1        0.38 ±  4%  perf-profile.self.cycles-pp.__list_del_entry_valid
>       0.63            -0.1        0.50 ±  2%  perf-profile.self.cycles-pp.unlink_anon_vmas
>       0.46            -0.1        0.33 ±  3%  perf-profile.self.cycles-pp.unmap_single_vma
>       0.51            -0.1        0.40        perf-profile.self.cycles-pp.kmem_cache_alloc
>       0.36 ±  3%      -0.1        0.26 ±  6%  perf-profile.self.cycles-pp.copy_mc_enhanced_fast_string
>       0.34 ±  2%      -0.1        0.24 ±  3%  perf-profile.self.cycles-pp.acct_collect
>       0.64 ±  2%      -0.1        0.54 ±  3%  perf-profile.self.cycles-pp.fput
>       0.28            -0.1        0.19 ±  4%  perf-profile.self.cycles-pp.queued_write_lock_slowpath
>       0.64            -0.1        0.55 ±  2%  perf-profile.self.cycles-pp.mod_objcg_state
>       0.46            -0.1        0.38 ±  3%  perf-profile.self.cycles-pp.update_sg_wakeup_stats
>       0.72            -0.1        0.64 ±  3%  perf-profile.self.cycles-pp.update_rq_clock_task
>       0.40 ±  2%      -0.1        0.32 ±  2%  perf-profile.self.cycles-pp.attach_entity_load_avg
>       0.51 ±  2%      -0.1        0.43 ±  3%  perf-profile.self.cycles-pp.__percpu_counter_sum
>       0.42 ±  2%      -0.1        0.35 ± 10%  perf-profile.self.cycles-pp.sync_regs
>       0.38            -0.1        0.31 ±  4%  perf-profile.self.cycles-pp.remove_entity_load_avg
>       0.40            -0.1        0.33 ±  3%  perf-profile.self.cycles-pp.pcpu_alloc
>       0.21 ±  2%      -0.1        0.14 ±  6%  perf-profile.self.cycles-pp.down_read_trylock
>       0.31            -0.1        0.24 ±  3%  perf-profile.self.cycles-pp.update_load_avg
>       1.26            -0.1        1.19        perf-profile.self.cycles-pp._raw_spin_lock
>       0.34 ± 12%      -0.1        0.28 ±  9%  perf-profile.self.cycles-pp.rwsem_optimistic_spin
>       0.27            -0.1        0.20 ±  2%  perf-profile.self.cycles-pp.kfree
>       0.14 ±  3%      -0.1        0.07 ± 10%  perf-profile.self.cycles-pp.intel_idle
>       0.23 ±  2%      -0.1        0.17 ±  5%  perf-profile.self.cycles-pp.mtree_range_walk
>       0.28            -0.1        0.22 ±  3%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
>       0.20            -0.1        0.14 ±  4%  perf-profile.self.cycles-pp.lock_vma_under_rcu
>       0.29 ±  3%      -0.1        0.23 ±  5%  perf-profile.self.cycles-pp.percpu_counter_add_batch
>       0.19 ±  6%      -0.1        0.14 ±  7%  perf-profile.self.cycles-pp.memcg_account_kmem
>       0.18 ± 11%      -0.1        0.12 ± 12%  perf-profile.self.cycles-pp.cgroup_rstat_updated
>       0.34 ±  2%      -0.1        0.28 ±  3%  perf-profile.self.cycles-pp.mas_next_slot
>       0.24 ±  3%      -0.1        0.18 ±  4%  perf-profile.self.cycles-pp.unregister_fair_sched_group
>       0.20 ± 10%      -0.1        0.14 ± 13%  perf-profile.self.cycles-pp.rwsem_down_write_slowpath
>       0.39            -0.1        0.34 ±  2%  perf-profile.self.cycles-pp.___slab_alloc
>       0.13 ±  9%      -0.1        0.08 ±  6%  perf-profile.self.cycles-pp.__memcg_kmem_charge_page
>       0.33 ±  2%      -0.0        0.28 ±  2%  perf-profile.self.cycles-pp.__rb_erase_color
>       0.08 ±  6%      -0.0        0.02 ± 99%  perf-profile.self.cycles-pp.__kmem_cache_alloc_bulk
>       0.74            -0.0        0.69 ±  2%  perf-profile.self.cycles-pp.vma_interval_tree_remove
>       0.16 ±  7%      -0.0        0.12 ±  8%  perf-profile.self.cycles-pp.try_charge_memcg
>       0.07 ± 12%      -0.0        0.02 ± 99%  perf-profile.self.cycles-pp.rb_next
>       0.08 ± 17%      -0.0        0.04 ± 71%  perf-profile.self.cycles-pp.____machine__findnew_thread
>       0.17 ±  6%      -0.0        0.12 ±  7%  perf-profile.self.cycles-pp.mutex_spin_on_owner
>       0.47 ±  3%      -0.0        0.42 ±  4%  perf-profile.self.cycles-pp.osq_unlock
>       0.24 ±  2%      -0.0        0.20 ±  5%  perf-profile.self.cycles-pp.__memcpy
>       0.22 ±  4%      -0.0        0.18 ±  4%  perf-profile.self.cycles-pp.vma_interval_tree_insert_after
>       0.12            -0.0        0.08 ±  7%  perf-profile.self.cycles-pp.cpu_util
>       0.18 ±  5%      -0.0        0.14 ±  2%  perf-profile.self.cycles-pp.do_set_pte
>       0.06 ±  7%      -0.0        0.02 ± 99%  perf-profile.self.cycles-pp.remove_vma
>       0.17 ±  6%      -0.0        0.13 ±  3%  perf-profile.self.cycles-pp.obj_cgroup_charge
>       0.22 ±  2%      -0.0        0.18 ±  3%  perf-profile.self.cycles-pp.__rb_insert_augmented
>       0.18 ±  2%      -0.0        0.14 ±  4%  perf-profile.self.cycles-pp.__list_add_valid
>       0.22 ±  4%      -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.__anon_vma_interval_tree_augment_rotate
>       0.07 ±  5%      -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.mark_page_accessed
>       0.16 ±  3%      -0.0        0.12 ±  6%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
>       0.06            -0.0        0.02 ± 99%  perf-profile.self.cycles-pp.mm_init
>       0.15 ±  5%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.__libc_fork
>       0.07 ±  5%      -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.__update_blocked_fair
>       0.10 ±  3%      -0.0        0.07        perf-profile.self.cycles-pp.queued_read_lock_slowpath
>       0.24 ±  2%      -0.0        0.21 ±  2%  perf-profile.self.cycles-pp.deactivate_slab
>       0.17 ±  4%      -0.0        0.14        perf-profile.self.cycles-pp.vm_normal_page
>       0.18 ±  2%      -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.get_partial_node
>       0.09 ±  5%      -0.0        0.06        perf-profile.self.cycles-pp.__vm_area_free
>       0.06            -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.pte_offset_map_nolock
>       0.13 ±  2%      -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.online_fair_sched_group
>       0.10 ±  3%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.free_pgtables
>       0.08 ± 11%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.stress_fork_fn
>       0.14 ±  5%      -0.0        0.12 ±  3%  perf-profile.self.cycles-pp._find_next_bit
>       0.09 ±  5%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.mab_mas_cp
>       0.13 ±  2%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.__unfreeze_partials
>       0.12 ±  4%      -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
>       0.10 ±  4%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp._raw_spin_trylock
>       0.11 ±  6%      -0.0        0.09        perf-profile.self.cycles-pp.unmap_page_range
>       0.09 ±  6%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.__schedule
>       0.08 ±  5%      -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.update_curr
>       0.08 ±  6%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp._raw_write_lock_irq
>       0.10 ±  4%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.get_obj_cgroup_from_current
>       0.07 ±  6%      -0.0        0.06        perf-profile.self.cycles-pp.free_percpu
>       0.06 ±  7%      -0.0        0.05 ±  7%  perf-profile.self.cycles-pp._find_next_zero_bit
>       0.07            -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.mas_store
>       0.10 ±  4%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.__update_load_avg_blocked_se
>       0.06 ±  6%      -0.0        0.05        perf-profile.self.cycles-pp.__radix_tree_lookup
>       0.07            -0.0        0.06        perf-profile.self.cycles-pp.copy_process
>       0.05 ±  8%      +0.0        0.07        perf-profile.self.cycles-pp.exit_to_user_mode_prepare
>       0.22 ±  3%      +0.0        0.24        perf-profile.self.cycles-pp.alloc_fair_sched_group
>       0.20 ±  3%      +0.1        0.25 ±  3%  perf-profile.self.cycles-pp.init_entity_runnable_average
>       0.28 ±  3%      +0.1        0.35 ±  3%  perf-profile.self.cycles-pp.__kmem_cache_alloc_node
>       0.05            +0.1        0.17 ±  7%  perf-profile.self.cycles-pp.init_tg_cfs_entry
>       0.43 ±  3%      +0.2        0.58 ±  3%  perf-profile.self.cycles-pp.page_add_file_rmap
>       0.00            +4.5        4.50        perf-profile.self.cycles-pp.next_uptodate_folio
>       0.90           +20.6       21.46 ±  8%  perf-profile.self.cycles-pp.filemap_map_pages
> 
> 
> 
> ***************************************************************************************************
> lkp-spr-2sp3: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480L (Sapphire Rapids) with 512G memory
> =========================================================================================
> compiler/cpufreq_governor/kconfig/rootfs/runtime/tbox_group/test/testcase:
>   gcc-12/performance/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/300s/lkp-spr-2sp3/mmap-pread-rand/vm-scalability
> 
> commit: 
>   9f1f5b60e7 ("mm: use flush_icache_pages() in do_set_pmd()")
>   de74976eb6 ("filemap: add filemap_map_folio_range()")
> 
> 9f1f5b60e76d44fa de74976eb65151a2f568e477fc2 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>      61637           -11.8%      54369        vm-scalability.median
>       1671 ± 51%    -499.9        1171 ±  4%  vm-scalability.stddev%
>   13458014           -11.1%   11962548        vm-scalability.throughput
>       2750 ± 12%    +293.5%      10822 ±  5%  vm-scalability.time.system_time
>      64216           -11.7%      56706        vm-scalability.time.user_time
>   4.03e+09           -10.8%  3.596e+09        vm-scalability.workload
>     159605            +1.8%     162466        proc-vmstat.nr_shmem
>      92.33           -12.1%      81.17        vmstat.cpu.us
>       0.01 ±  3%      +0.0        0.02 ±  7%  mpstat.cpu.all.soft%
>       4.02 ± 12%     +11.7       15.68 ±  5%  mpstat.cpu.all.sys%
>      93.19           -11.2       82.03        mpstat.cpu.all.usr%
>       0.01 ±  5%     -13.0%       0.01 ±  6%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
>       2.02 ± 45%     +48.0%       2.99 ± 15%  perf-sched.wait_and_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
>       2.42 ±  8%     +23.1%       2.98 ± 15%  perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
>     177.45           -19.7      157.76        turbostat.PKG_%
>     694.20            -2.1%     679.50        turbostat.PkgWatt
>      62.93            -7.5%      58.23        turbostat.RAMWatt
>       0.49 ±  3%      -0.0        0.46        perf-profile.children.cycles-pp.hrtimer_interrupt
>       0.43 ±  5%      -0.0        0.40        perf-profile.children.cycles-pp.__hrtimer_run_queues
>       0.50 ±  3%      -0.0        0.47        perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
>       0.40 ±  5%      -0.0        0.37 ±  2%  perf-profile.children.cycles-pp.tick_sched_timer
>       0.38 ±  5%      -0.0        0.35        perf-profile.children.cycles-pp.update_process_times
>     943206           +41.7%    1336270 ±  7%  sched_debug.cpu.avg_idle.avg
>    1823893 ± 13%    +100.4%    3655497 ± 16%  sched_debug.cpu.avg_idle.max
>     172988 ± 16%    +284.9%     665748 ± 21%  sched_debug.cpu.avg_idle.stddev
>     587283 ±  7%     +31.5%     772030 ±  8%  sched_debug.cpu.max_idle_balance_cost.max
>       7394 ± 32%    +592.1%      51171 ± 31%  sched_debug.cpu.max_idle_balance_cost.stddev
>      22.38            -4.9%      21.27        perf-stat.i.MPKI
>  3.153e+10           -10.2%  2.833e+10        perf-stat.i.branch-instructions
>       0.03 ±  5%      +0.0        0.07 ±  3%  perf-stat.i.branch-miss-rate%
>      95.88            -4.4       91.45        perf-stat.i.cache-miss-rate%
>  2.907e+09           -10.3%  2.607e+09        perf-stat.i.cache-misses
>  2.991e+09           -10.1%   2.69e+09        perf-stat.i.cache-references
>       5.07 ±  2%    +116.1%      10.97 ±  8%  perf-stat.i.cpi
>     295.41 ±  4%    +405.0%       1491 ±  9%  perf-stat.i.cycles-between-cache-misses
>       3.53            -0.3        3.22        perf-stat.i.dTLB-load-miss-rate%
>  1.468e+09           -10.4%  1.316e+09        perf-stat.i.dTLB-load-misses
>  3.905e+10           -10.1%  3.509e+10        perf-stat.i.dTLB-loads
>       0.02 ±  2%      +0.0        0.05 ±  8%  perf-stat.i.dTLB-store-miss-rate%
>    2215806 ±  2%      -9.0%    2016922 ±  3%  perf-stat.i.dTLB-store-misses
>  1.214e+10           -10.0%  1.094e+10        perf-stat.i.dTLB-stores
>  1.325e+11           -10.1%  1.191e+11        perf-stat.i.instructions
>       0.20 ±  2%     -10.4%       0.18        perf-stat.i.ipc
>      29.74 ±  9%    +198.9%      88.90 ± 11%  perf-stat.i.metric.K/sec
>     395.53           -10.2%     355.27        perf-stat.i.metric.M/sec
>     203404 ±  3%      -7.0%     189209        perf-stat.i.minor-faults
>  1.062e+09 ±  2%     -15.6%  8.962e+08 ±  2%  perf-stat.i.node-load-misses
>  1.831e+09 ±  2%      -7.4%  1.696e+09 ±  3%  perf-stat.i.node-loads
>     204552 ±  3%      -6.9%     190351        perf-stat.i.page-faults
>       0.02 ±  2%      +0.0        0.02 ±  2%  perf-stat.overall.branch-miss-rate%
>       4.98           +14.6%       5.70        perf-stat.overall.cpi
>     226.86           +15.1%     261.02        perf-stat.overall.cycles-between-cache-misses
>       0.20           -12.8%       0.18        perf-stat.overall.ipc
>      10081            -1.4%       9943        perf-stat.overall.path-length
>  3.143e+10           -12.4%  2.753e+10        perf-stat.ps.branch-instructions
>  2.896e+09           -12.6%   2.53e+09        perf-stat.ps.cache-misses
>   2.98e+09           -12.3%  2.613e+09        perf-stat.ps.cache-references
>  1.463e+09           -12.7%  1.277e+09        perf-stat.ps.dTLB-load-misses
>  3.892e+10           -12.4%  3.411e+10        perf-stat.ps.dTLB-loads
>    2296781 ±  2%      -7.7%    2120487 ±  3%  perf-stat.ps.dTLB-store-misses
>  1.211e+10           -12.1%  1.065e+10        perf-stat.ps.dTLB-stores
>  1.321e+11           -12.3%  1.158e+11        perf-stat.ps.instructions
>  1.058e+09 ±  2%     -17.8%  8.694e+08 ±  2%  perf-stat.ps.node-load-misses
>  1.824e+09 ±  2%      -9.8%  1.646e+09 ±  3%  perf-stat.ps.node-loads
>  4.063e+13           -12.0%  3.576e+13        perf-stat.total.instructions
> 
> 
> 
> ***************************************************************************************************
> lkp-spr-r02: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory
> =========================================================================================
> class/compiler/cpufreq_governor/kconfig/nr_threads/rootfs/sc_pid_max/tbox_group/test/testcase/testtime:
>   scheduler/gcc-12/performance/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/4194304/lkp-spr-r02/zombie/stress-ng/60s
> 
> commit: 
>   9f1f5b60e7 ("mm: use flush_icache_pages() in do_set_pmd()")
>   de74976eb6 ("filemap: add filemap_map_folio_range()")
> 
> 9f1f5b60e76d44fa de74976eb65151a2f568e477fc2 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>     175389 ±  8%     +48.3%     260092 ± 14%  sched_debug.cpu.avg_idle.stddev
>  1.052e+09 ±  4%    +177.7%  2.921e+09 ± 59%  cpuidle..time
>    1486111 ±  8%   +1935.1%   30243535 ± 87%  cpuidle..usage
>       0.01 ± 40%      +5.1        5.09 ± 69%  mpstat.cpu.all.iowait%
>       1.07 ±  3%      -0.8        0.30 ± 98%  mpstat.cpu.all.soft%
>       1.06            -0.5        0.52 ± 61%  mpstat.cpu.all.usr%
>       0.00       +1.2e+107%     122169 ± 65%  vmstat.procs.b
>     291.67 ±  4%   +2001.1%       6128 ± 88%  vmstat.procs.r
>     356111           +60.6%     571836 ± 54%  vmstat.system.in
>      57294         +1320.7%     813995 ±119%  meminfo.KernelStack
>      74462 ±  3%   +3257.4%    2499959 ±130%  meminfo.PageTables
>   25447288           -39.9%   15287038 ± 41%  meminfo.SUnreclaim
>   25634838           -39.4%   15544405 ± 40%  meminfo.Slab
>   66497461 ±  3%     -51.9%   31974064 ± 48%  numa-numastat.node0.local_node
>   66655914 ±  3%     -51.6%   32294668 ± 47%  numa-numastat.node0.numa_hit
>   70406387 ±  3%     -47.7%   36843120 ± 52%  numa-numastat.node1.local_node
>   70506925 ±  3%     -47.4%   37117073 ± 52%  numa-numastat.node1.numa_hit
>      78192 ± 50%    +174.0%     214273 ± 38%  numa-numastat.node1.other_node
>       3390 ± 18%   +4084.9%     141867 ± 53%  turbostat.C1
>       0.15 ±  2%     -56.0%       0.07 ± 44%  turbostat.IPC
>       2056 ± 25%  +1.4e+06%   28675451 ± 92%  turbostat.POLL
>     609.02           -12.0%     535.83 ±  6%  turbostat.PkgWatt
>      35.37           -35.4%      22.85 ± 19%  turbostat.RAMWatt
>     271305 ±  9%    +179.1%     757275 ± 38%  stress-ng.time.involuntary_context_switches
>      66094 ± 15%   +3591.7%    2440028 ± 71%  stress-ng.time.major_page_faults
>  1.498e+08 ±  4%     -54.2%   68628961 ± 56%  stress-ng.time.minor_page_faults
>      12962          +276.6%      48813 ± 81%  stress-ng.time.system_time
>     121.53 ±  3%     -56.3%      53.13 ± 55%  stress-ng.time.user_time
>    3643735           -53.8%    1681822 ± 56%  stress-ng.zombie.ops
>      56119           -74.5%      14319 ±105%  stress-ng.zombie.ops_per_sec
>     385088 ± 37%    +817.9%    3534727 ± 80%  numa-meminfo.node0.AnonPages.max
>      28420 ±  7%   +1062.4%     330365 ±140%  numa-meminfo.node0.KernelStack
>      35679 ± 14%   +2710.3%    1002703 ±153%  numa-meminfo.node0.PageTables
>   12105886 ±  3%     -40.7%    7174505 ± 47%  numa-meminfo.node0.SUnreclaim
>   12220251 ±  3%     -40.4%    7283187 ± 47%  numa-meminfo.node0.Slab
>    1290286 ± 12%     -46.2%     694602 ± 49%  numa-meminfo.node1.FilePages
>     610714 ±  2%     -41.0%     360265 ± 46%  numa-meminfo.node1.Mapped
>   13247897 ±  3%     -45.3%    7243195 ± 51%  numa-meminfo.node1.SUnreclaim
>    1217022 ± 10%     -45.6%     662370 ± 46%  numa-meminfo.node1.Shmem
>   13320721 ±  3%     -44.2%    7434743 ± 48%  numa-meminfo.node1.Slab
>       0.00       +1.7e+104%     172.83 ±138%  proc-vmstat.nr_isolated_anon
>      57369         +1059.9%     665452 ±120%  proc-vmstat.nr_kernel_stack
>      18723 ±  3%   +2604.6%     506387 ±132%  proc-vmstat.nr_page_table_pages
>    6342780           -42.4%    3650813 ± 46%  proc-vmstat.nr_slab_unreclaimable
>  1.371e+08 ±  3%     -49.4%   69417360 ± 50%  proc-vmstat.numa_hit
>  1.369e+08 ±  3%     -49.7%   68822802 ± 50%  proc-vmstat.numa_local
>  1.547e+08 ±  2%     -48.5%   79708856 ± 49%  proc-vmstat.pgalloc_normal
>   1.52e+08 ±  4%     -50.7%   74893245 ± 54%  proc-vmstat.pgfault
>  1.524e+08 ±  2%     -49.2%   77369894 ± 49%  proc-vmstat.pgfree
>    9681032 ±  7%     -57.7%    4096941 ± 60%  proc-vmstat.pgreuse
>      28414 ±  7%    +949.9%     298310 ±166%  numa-vmstat.node0.nr_kernel_stack
>       8996 ± 14%   +2424.4%     227103 ±180%  numa-vmstat.node0.nr_page_table_pages
>    3025579 ±  3%     -42.3%    1745312 ± 52%  numa-vmstat.node0.nr_slab_unreclaimable
>   66655838 ±  3%     -51.6%   32293907 ± 47%  numa-vmstat.node0.numa_hit
>   66497386 ±  3%     -51.9%   31973303 ± 48%  numa-vmstat.node0.numa_local
>     322703 ± 12%     -50.1%     161011 ± 58%  numa-vmstat.node1.nr_file_pages
>     152754 ±  2%     -44.9%      84140 ± 57%  numa-vmstat.node1.nr_mapped
>     304388 ± 10%     -49.8%     152952 ± 56%  numa-vmstat.node1.nr_shmem
>    3310966 ±  3%     -46.8%    1761156 ± 53%  numa-vmstat.node1.nr_slab_unreclaimable
>   70504864 ±  3%     -47.4%   37117466 ± 52%  numa-vmstat.node1.numa_hit
>   70404328 ±  3%     -47.7%   36843513 ± 52%  numa-vmstat.node1.numa_local
>      78191 ± 50%    +174.0%     214273 ± 38%  numa-vmstat.node1.numa_other
>       9.37 ±  2%     -20.6%       7.44 ± 15%  perf-stat.i.MPKI
>   1.58e+08           -15.9%  1.329e+08 ± 11%  perf-stat.i.branch-misses
>  5.873e+08 ±  3%     -38.8%  3.592e+08 ± 14%  perf-stat.i.cache-misses
>  1.574e+09 ±  2%     -36.4%      1e+09 ± 15%  perf-stat.i.cache-references
>      78615           +80.3%     141727 ± 10%  perf-stat.i.context-switches
>       3.69           +48.7%       5.48 ± 23%  perf-stat.i.cpi
>      28686 ±  5%     +68.0%      48183 ± 24%  perf-stat.i.cpu-migrations
>       1094 ±  4%    +318.6%       4582 ± 87%  perf-stat.i.cycles-between-cache-misses
>   93120973 ±  2%     -24.2%   70578623 ± 21%  perf-stat.i.dTLB-load-misses
>       0.56            -0.1        0.41 ± 23%  perf-stat.i.dTLB-store-miss-rate%
>   59029929 ±  2%     -39.3%   35849349 ± 26%  perf-stat.i.dTLB-store-misses
>  9.925e+09 ±  2%     -26.1%  7.339e+09 ± 15%  perf-stat.i.dTLB-stores
>       1009 ± 15%   +3078.5%      32082 ± 24%  perf-stat.i.major-faults
>       2.67           -10.3%       2.39 ± 10%  perf-stat.i.metric.GHz
>       1003 ±  2%     -29.4%     708.55 ± 16%  perf-stat.i.metric.K/sec
>     387.65           -37.1%     243.89 ± 22%  perf-stat.i.metric.M/sec
>    2300158 ±  4%     -32.9%    1542813 ± 19%  perf-stat.i.minor-faults
>  1.368e+08 ±  2%     -26.3%  1.008e+08 ± 14%  perf-stat.i.node-load-misses
>    2301168 ±  4%     -31.4%    1578147 ± 18%  perf-stat.i.page-faults
>       9.65 ±  2%     -44.6%       5.35 ± 51%  perf-stat.overall.MPKI
>       3.70          +125.9%       8.36 ± 37%  perf-stat.overall.cpi
>       1021 ±  3%    +631.6%       7471 ± 88%  perf-stat.overall.cycles-between-cache-misses
>       0.59            -0.2        0.38 ± 39%  perf-stat.overall.dTLB-store-miss-rate%
>       0.27           -47.4%       0.14 ± 43%  perf-stat.overall.ipc
>  3.248e+10           -45.9%  1.758e+10 ± 27%  perf-stat.ps.branch-instructions
>   1.53e+08           -59.0%   62792893 ± 80%  perf-stat.ps.branch-misses
>  5.787e+08 ±  3%     -69.5%  1.767e+08 ± 76%  perf-stat.ps.cache-misses
>  1.541e+09 ±  2%     -68.0%   4.93e+08 ± 77%  perf-stat.ps.cache-references
>   91095243 ±  2%     -59.5%   36919468 ± 61%  perf-stat.ps.dTLB-load-misses
>  4.134e+10           -51.2%  2.016e+10 ± 37%  perf-stat.ps.dTLB-loads
>   57601991 ±  3%     -68.8%   17958458 ± 97%  perf-stat.ps.dTLB-store-misses
>  9.696e+09 ±  2%     -62.5%  3.641e+09 ± 78%  perf-stat.ps.dTLB-stores
>  1.596e+11           -50.2%  7.949e+10 ± 35%  perf-stat.ps.instructions
>     983.10 ± 16%   +1528.2%      16006 ± 47%  perf-stat.ps.major-faults
>    2249530 ±  5%     -65.8%     769259 ± 89%  perf-stat.ps.minor-faults
>  1.351e+08 ±  2%     -62.6%   50573350 ± 80%  perf-stat.ps.node-load-misses
>   21223230 ±  5%     -51.4%   10324363 ± 54%  perf-stat.ps.node-loads
>    2250513 ±  5%     -65.1%     785451 ± 87%  perf-stat.ps.page-faults
> 
> 
> 
> 
> 
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are provided
> for informational purposes only. Any difference in system hardware or software
> design or configuration may affect actual performance.
> 
> 
