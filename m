Return-Path: <linux-fsdevel+bounces-3548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD5B7F638A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 17:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EA33B211B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 16:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678FA3E483;
	Thu, 23 Nov 2023 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VJymjRD1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F875D4A;
	Thu, 23 Nov 2023 08:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700755571; x=1732291571;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SGTTpE6fv0Hs50SZB+f1MD15NYzl9N9F2WWdcRrl3W8=;
  b=VJymjRD1RfeguHfxzTqNoAFXZVrAnaTEG0HPb+tHV0X/9T0auxzoRwvO
   b6day2mHYLmydYigkHizfvpFogbxJnwrf+tXDF0DwCSQj8Lzz0EU24LnQ
   Cgnoep0MOxsxrDlxUrUh+DdpOL4nnlNRb1lpnsBQ6yCzwLjczxhbtFdwg
   zf00qwZotodpecFneBxN9mDULszP07rkDOhwd2XfOzHupMjssg5gjuSW5
   2TOWtNQU/4Rpzb2N5H7rGAWeZYZdLdNIFKaprmkroVARRn+SDekl3v0kY
   oroKaO+wfgez+CFKzquFrOG1Zckjx52z16UnNukGYMlneNmNRkjxK2HWh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="456625440"
X-IronPort-AV: E=Sophos;i="6.04,222,1695711600"; 
   d="scan'208";a="456625440"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 08:06:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="885025668"
X-IronPort-AV: E=Sophos;i="6.04,222,1695711600"; 
   d="scan'208";a="885025668"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Nov 2023 08:05:54 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 23 Nov 2023 08:05:54 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 23 Nov 2023 08:05:54 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 23 Nov 2023 08:05:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGxrImUjG89vm0jWJz9dubd37nH9dqIIBf3E1xiK6DoopDDl5zRjueT0jnwN4+UmsZq1IwdTATTgATGKnVepcG2lNL7ryBFvFsi9cBPW2DamJQ3VSub1LJajJ1B9dTce63ceeMxhiaUgCRUJhr8GSEdddpR5oJS2l6XJcsomFChgWhdhkabQopkYMnDn+wpX5jHSOnMQikuaebBXPwKz8HRgUOOyibNXN+7JBiqv+6F20h5AXiGDPVPOZeN5luVRi01IQG/R+AVURiC6hbCx+AMASDhGER54lzhyFwGg+txFCibSXopjBWUANHBuAIVm4fhO9xOFqI2rk/GoqLUosA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JzabApUMdy0ks/bScwAwy/pqT4UHLkTIUXFggJTOysI=;
 b=GSfjzcoyrFmVabLBWoBpE2EFTRDsOg4Qk9V2yFB7KX2B3t+zk8CZQA6sGmCi766InuzDByH9LPrFqocGnkVXAnVIpbBvWDRiACAZ6sIjm52n0Zrlqmo+qIMwABQAv2W6ZW+Win1C8TkJLe7L/oM3zagQOl6XwS/uMet2qQttUg4qCcnzB3F4bnQrxnwFiH3ltnIidTK/eqvSgBfVekgx6+jYpVKet+aEqxdEVUJowHwpRQC9ZLM4laZp4piZ1NGtbruYdLiqJv0/87QJJkQu1Dlo8EXzrR1ktlteqba9PgOWgl2+i3fWblOopWV80WSqscsprh8h+IgJaUEws83jOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CH3PR11MB8313.namprd11.prod.outlook.com (2603:10b6:610:17c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Thu, 23 Nov
 2023 16:05:51 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20%5]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 16:05:51 +0000
Message-ID: <242216e6-512f-437f-8a91-13d61a291517@intel.com>
Date: Fri, 24 Nov 2023 00:05:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [filemap] c8be038067: vm-scalability.throughput
 -27.3% regression
To: kernel test robot <oliver.sang@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Feng Tang <feng.tang@intel.com>,
	Huang Ying <ying.huang@intel.com>, Matthew Wilcox <willy@infradead.org>,
	<linux-fsdevel@vger.kernel.org>
References: <202311201605.b86d11b-oliver.sang@intel.com>
Content-Language: en-US
From: "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <202311201605.b86d11b-oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0014.apcprd04.prod.outlook.com
 (2603:1096:4:197::18) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CH3PR11MB8313:EE_
X-MS-Office365-Filtering-Correlation-Id: 512b5da1-7078-4c90-5aa2-08dbec3e1074
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cOO4KU9SSxTV26aOqIlC3QGbTrExVoGLARFkSXU+iM2ZAHAX36z52fZbPt16nUzGv3Xbftkg0uqDvlENhdnKoMnlc5Q94SzbJZfXqDJYuA4UBqLU9sXp/rIJI/VHmtHhDVH0NqJJBVnJha3L68dOGHWA9TTw2v0SOg3xlcuKwMUqQucxEr0DFpFUqHj/fukOfTe1s9HCOUYABJM8hqyFGuIEkNk80IXHOMNRZSGDDafDxDXdO8TpVzgp9mYw5UIaSKXq+X3vzY2elAIZ5LR581VvEUthdZDTp06A1zVwXUSK455mrfFuV8MIdXu5UYAkX+XrRwK10jToZfukyb3HTGswTmMOOD5f2S9M4vz/gV29cjhDT/F4OfcoUM9nwBjfL7k3CWuRDMjUQFfQacbRgW43rOdBPzlA34DhdwvVXB65FICEnj7Dc0nrTG+HyOfl808yfDRZ+1MGBj4HJSxVKCmylySaOfzKKldTcOVnHGsmnAsj8XxPst9YrSCyQFXS98Jb+aSJUEqkfL1SaB0AM9keOJXf+dNjx6Ppi70mYHxcRthHEdjM7ROpt/Fq04hhJu33nQLx+zfc9R8xiOmVTVVAMvmNCiHUDnv/opYDpylw54j2WjVWO1V080lGZayeehDkeNoRXVTSeWewzC4GSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(136003)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2616005)(26005)(82960400001)(36756003)(38100700002)(31696002)(86362001)(83380400001)(316002)(6636002)(37006003)(6862004)(4326008)(8936002)(66556008)(66946007)(66476007)(41300700001)(2906002)(5660300002)(31686004)(53546011)(6506007)(6666004)(54906003)(6512007)(8676002)(6486002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmJKR2w5TVQ2REg0eVdicDA4RjVxNmFFY2p0OVdLMkN4alA4VTB2MEhYbFBW?=
 =?utf-8?B?K0FsK201QlFIZXcra280aG1HY2tsZVcvVlJyLzlDNjYvQmlFUXBTajZidkhL?=
 =?utf-8?B?MWJ6OHFZSmY3NklUWGNoczdLNHRZODMrTThrWng3anpLTmI2T09hVDh5am5B?=
 =?utf-8?B?WXN5NW1wbHg2Z0pIY3FNdVI2TXU5cHJOL0VGU1dzdmpYKzNQaGp5QUNtSWo1?=
 =?utf-8?B?aEIzZkg3b1V3Vk1ES3lqZjBvcXA4YWRpendIUFczUmdxdXBBOVJZZUFVZ1RB?=
 =?utf-8?B?bFRaYi84TlF2eWo3c3JvNzcrZ3ZXNUtTSUxuSWc0S0gwMTZoT0hWSGkwUVZq?=
 =?utf-8?B?L0RFT1ZRbXRaZUxVemVMK3RQZDlScjh0SldFaENSYVg3S0lKQnBUZThFNTQ2?=
 =?utf-8?B?NjVpRDZmSWFaTHFvMU5UUHRqdTUxd25LckN4RlBkZmgyY1JDQTJXUWhVdFJE?=
 =?utf-8?B?aEdhRTYrbXNaUm5IYlpsbkpKdmdnYVVGUUhET2liMXR5a01peG5IRTZLdTl2?=
 =?utf-8?B?NFhaQkJYZ2F4MmFGcHBrb1hoQ0JmVlN2MnIvL1hCeTVMZHc1ZnJWT2dZVWlp?=
 =?utf-8?B?Z2d6OEJQaE1kb0Q4VGh4WTZGVk5FeEVpOWg0ZTZXNkVnbXdhR0wydEVWN2VW?=
 =?utf-8?B?emw1Zi9vdDRtaWphSHJMMU9DbnYrMFVLT0JzV2VMVzVSSHdqMXdXU25LNHds?=
 =?utf-8?B?TFM2S3F1cGE4Rnh3WWVVZnJ3a1RSc1ZleWd4cUgvV2VVdUxSSzFuNHRXc215?=
 =?utf-8?B?UnVqVk9OcTN4em13TVBzWmcxNy9Wd1NpWWJHSUFoaTcyemlqdldUc2V5S3Zh?=
 =?utf-8?B?cXo4SmdzQ2p3SkErMVVOMFZSRkVYVlV1NnNlcndyTnRoS2hZVzhFWndPeG1Q?=
 =?utf-8?B?OUZKNXZicHFnUE5uZnZFNlhiWVNZTUlDckh6aWp2UE5nVmQyYnhWdnBJZFVG?=
 =?utf-8?B?ZVJ3cXVUenVtbGJrS3VsOCs0eG04WVp1alVCREt5YW8wSFpjclFNTi9QdUNH?=
 =?utf-8?B?ajFQb0lPTWVHSTN1Y3RvVXY2V3NLL2F2SXUyMXUvVVBuSzBSNmR2aGxCRTFX?=
 =?utf-8?B?a3Q4K1V2cUNySDFxUnZKdkc1ejh2MW80K0VrOTFPU0NuTEJCS1kycGRnRE0v?=
 =?utf-8?B?eTEweFI0Sit1UFpYZHdjeWI3OCt1dDVGNzlYWmV4d0l0UHJXaGZsZmNBYnll?=
 =?utf-8?B?Mms2bUszdUFQdXNpMTJWaURGclF4cVhmNTdVNXNwaER2UzhHWjJGdUZCY2t2?=
 =?utf-8?B?Tk5ySzMzNVpvTFhjS1RPekRQNWlad0szOFdrWEZubFRmNW5uMXArV2tOdW0w?=
 =?utf-8?B?czZEMHJQYVg0MXNnY0tzRnpwU0FzbDhuSllpYjFsNVZKamd4UWVlR3REd3k2?=
 =?utf-8?B?dkovNklhSkp6UzhvZWI5N0VpbGVBRnNwdmNQTGZLdGt3a1A3bGtRMVo2cEt0?=
 =?utf-8?B?NElUcVZydVpoeURjQzcvaGVFUzJFald3RjdyWmxLTGJ0RWtKSnlKRm5US3lJ?=
 =?utf-8?B?U28yWStPRHY5OGhDQUpONng5M2NFN25jVnRUZEFSejZaZW9xVUJwd1pLV2ZY?=
 =?utf-8?B?ZzhJMlZ5R1VPZDBrR2ZocVhES2VSekJKb3FPcFlYSitHNzY1S3RXMzdrOXk0?=
 =?utf-8?B?Nyt1S0Z0a2xEYkNjb3JKQkx0VXhZaEFZemxocXIzaTFIMGd2Y0VFSGI2UDlW?=
 =?utf-8?B?anRHSFdlUFd0bnZuK09lVlNnbVA1WjFSWXBYeUdRZXpkMGxhbzNRMXIzRGhT?=
 =?utf-8?B?OFp5bjBpd25NR3NCSzQrMnl5YUJjcDZMaUx3UCsxWWUrNSs2SW16WlFabFJh?=
 =?utf-8?B?bmxEMUt4Z250aStzbkRwQUxiWS9Ta2FLZ3h6VEU3c2daRVphNjI0b1BSSlBR?=
 =?utf-8?B?d0NqaDNaOE5QUGVYbHhvcVNWNjh2SElqTnRVWDEvcTVEWFZRNWw2d3czOWtZ?=
 =?utf-8?B?L0Eyak8vU1did0ZDM2hIVXJ3WmwxaTFPdnBCaE84UXMveGN3RnZ2M3lodjZX?=
 =?utf-8?B?MWxXMmdQa2VlTEpmVHdrV3FvUHREUFhQOCtHQzBDbnVTdEZ4b2dMYzMyL21s?=
 =?utf-8?B?QXdMSFFGMHNYbWU2ejhUOWFLK09aelhVMWwyZ0hLQVdmamRpNEw3M0NXWnk2?=
 =?utf-8?Q?zlT/ovhBfxn/Iy/YTNSs9PA4Q?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 512b5da1-7078-4c90-5aa2-08dbec3e1074
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 16:05:51.2426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tINPmvr4fjO/5OeRl1/NdyN5h8cw2iIvbaLRSqdPBKT7Z/sq9nmHYvFRc0ecdf99UILRehOtoDvhMdiywlCVAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8313
X-OriginatorOrg: intel.com


On 11/20/2023 9:48 PM, kernel test robot wrote:
> 
> hi, Fengwei,
> 
> we noticed c8be038067 is the fix commit for
> de74976eb65151a2f568e477fc2e0032df5b22b4 ("filemap: add filemap_map_folio_range()")
> 
> and we captured numbers of improvement for this commit
> (refer to below
> "In addition to that, the commit also has significant impact on the following tests"
> part which includes several examples)
> 
> however, recently, we found a regression as title mentioned.
I can reproduce the regression on an Ice Lake platform with 256G memory + 72C/144T.

> 
> the extra information we want to share is we also tested on mainline tip when
> this bisect done, and noticed the regression disappear:
I can also reproduce this "regression disappear on latest mainline". And I found
the related commit was:

commit f5617ffeb450f84c57f7eba1a3524a29955d42b7
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Mon Jul 24 19:54:08 2023 +0100

    mm: run the fault-around code under the VMA lock

With this commit, the map_pages() could be called twice. The first is with VMA lock hold.
The second one is with mmap_lock (even no set_pte because of !pte_none()).

With this commit reverted, the regression can be restored to some level.


And The reason that the "regression disappear on latest mainline" is related with

commit 12214eba1992642eee5813a9cc9f626e5b2d1815 (test6)
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Fri Oct 6 20:53:17 2023 +0100

    mm: handle read faults under the VMA lock


This commit eliminates the second call of map_pages() and the regression can be
restored to some level.

We may still need to move following code block before fault around:
        ret = vmf_can_call_fault(vmf);
        if (ret)
                return ret;

> 
> # extra tests on head commit of linus/master
> # good: [9bacdd8996c77c42ca004440be610692275ff9d0] Merge tag 'for-6.7-rc1-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
> 
> the data is even better than parent:
> 
>   "vm-scalability.throughput": [
>     54122867,
>     58465096,
>     55888729,
>     56960948,
>     56385702,
>     56392203
>   ],
> 
> and we also reverted c8be038067 on maineline tip, but found no big diff:
> 
> # extra tests on revert first bad commit
> # good: [f13a82be4c3252dabd1328a437c309d84ec7a872] Revert "filemap: add filemap_map_order0_folio() to handle order0 folio"
> 
>   "vm-scalability.throughput": [
>     56434337,
>     56199754,
>     56214041,
>     55308070,
>     55401115,
>     55709753
>   ],
> 
> 
> commit: 
>   578d7699e5 ("proc: nommu: /proc/<pid>/maps: release mmap read lock")
>   c8be038067 ("filemap: add filemap_map_order0_folio() to handle order0 folio")
> 
> 578d7699e5c2add8 c8be03806738c86521dbf1e0503 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>     146.95 ±  8%     -83.0%      24.99 ±  3%  vm-scalability.free_time
>     233050           -28.1%     167484        vm-scalability.median
>     590.30 ± 12%    -590.2        0.06 ± 45%  vm-scalability.stddev%
>   51589606           -27.3%   37516397        vm-scalability.throughput

I found very interesting behavior:
1. I am sure the filemap_map_order0_folio() is faster than filemap_map_folio_range()
   if the folio has order 0 (true for shmem for now).

2. If I use tool ebpf_trace to get how many times the filemap_map_order0_folio() is
   called during vm-scalability is running, the test result become better. In general,
   the test result should become worse.

   It looks slower filemap_map_order0_folio() can make better vm-scalability result.
   I did another testing by adding 2us delay in filemap_map_order0_folio(), the
   vm-scalability result get a little bit improved.

3. using perf with 578d7699e5 and c8be038067:
   for do_read_fault() with 578d7699e5 :
        -   48.58%     0.04%  usemem           [kernel.vmlinux]            [k] do_read_fault
           - 48.54% do_read_fault
              - 44.34% filemap_map_pages
                   19.45% filemap_map_folio_range
                   3.22% next_uptodate_folio
                 + 1.72% folio_wake_bit
              + 3.29% __do_fault
                0.65% folio_wake_bit

   for do_read_fault() with c8be038067:
        -   72.98%     0.09%  usemem           [kernel.vmlinux]            [k] do_read_fault
           - 72.89% do_read_fault
              - 52.70% filemap_map_pages
                   32.10% next_uptodate_folio   <----- much higher than 578d7699e5
                 + 12.35% folio_wake_bit
                 + 1.53% set_pte_range
              + 12.43% __do_fault
              + 6.36% folio_wake_bit		<----- higher than 578d7699e5
              + 0.97% finish_fault

   I have theory that faster filemap_map_order0_folio() brings more contention in next_uptodate_folio().

4. I finally located what part of code brought higher contentions in next_uptodate_folio(). It's related with
   following change:
        diff --git a/mm/filemap.c b/mm/filemap.c
        index 582f5317ff71..056a2d2e2428 100644
        --- a/mm/filemap.c
        +++ b/mm/filemap.c
        @@ -3481,7 +3481,6 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
                struct vm_area_struct *vma = vmf->vma;
                struct file *file = vma->vm_file;
                struct page *page = folio_page(folio, start);
        -       unsigned int mmap_miss = READ_ONCE(file->f_ra.mmap_miss);
                unsigned int count = 0;
                pte_t *old_ptep = vmf->pte;
        
        @@ -3489,9 +3488,6 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
                        if (PageHWPoison(page + count))
                                goto skip;
        
        -               if (mmap_miss > 0)
        -                       mmap_miss--;
        -
                        /*
                         * NOTE: If there're PTE markers, we'll leave them to be
                         * handled in the specific fault path, and it'll prohibit the
        @@ -3525,7 +3521,6 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
                }
        
                vmf->pte = old_ptep;
        -       WRITE_ONCE(file->f_ra.mmap_miss, mmap_miss);
        
                return ret;
         }

   If apply above change to 578d7699e5, the next_uptodate_folio() raised. perf command got:
        -   68.83%     0.08%  usemem           [kernel.vmlinux]            [k] do_read_fault
           - 68.75% do_read_fault
              - 49.34% filemap_map_pages
                   29.71% next_uptodate_folio
                 + 11.82% folio_wake_bit
                 + 2.34% filemap_map_folio_range
              - 11.97% __do_fault
                 + 11.93% shmem_fault
              + 6.12% folio_wake_bit
              + 0.92% finish_fault

   And vm-scalability dropped to same level as latest mainline.

   IMHO, we should slowdown filemap_map_order0_folio() because other benchmark can get benefit
   from faster filemap_map_order0_folio(). Thanks.


Regards
Yin, Fengwei

