Return-Path: <linux-fsdevel+bounces-3642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDFB7F6C71
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 07:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E168428147E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 06:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38D8258C;
	Fri, 24 Nov 2023 06:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fNBNenhB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF0BAD;
	Thu, 23 Nov 2023 22:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700808165; x=1732344165;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HoXb11FyoS4HRtwGdQLJlLEGqtG1aBi2A0cc1edyQSA=;
  b=fNBNenhBKeKq7UxgT4HmruSeZtco/TBwBNyRvgu3Dy7KW+FFmpSR2YX6
   a8TWgeowM5yVrPqUa9xNeLRZ6wSrTiNq84UJAmqNQtSaIm4lXtteJhFoT
   LsJQoqQDL/dCbBuMkgvOT5V+hHTNRu+og3NvnRL1hhJ85NNzMqeJkV7Wi
   dtGGHOlp67BxQRvtitTK8CObAEc8iFA8wyLULxRBqUcmGoJxyBlss9LP1
   dlsp8kpF9K+LJbgiJrv2QgJZzClOm7tOGE7TqYi+ZlvuzJ8Dd2N+X5uax
   La6n1+Zotmg8hMuFp/X0qFjKOn+Zb0GY6o909TMLgcqEYehvki3e+dvGA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="423511526"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="423511526"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 22:42:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="717259639"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="717259639"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Nov 2023 22:42:44 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 23 Nov 2023 22:42:43 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 23 Nov 2023 22:42:43 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 23 Nov 2023 22:42:43 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 23 Nov 2023 22:42:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CH8OO8sa6sWOBsTO1BrOE/nNFDjDuO7+RnNzqO/TV5G6O81kL6j1HHd/9PKxywlvcp7ReU7ATAW93M9pZvsdAOOAu05//egvmMOgbiAH6LEaZRojVNj3550jO/yRN/QFMQsXHTEaReKzDt43kv+QmZQLWel2Zo0B9uy0PZRQb95eBCpxq1ojPU4O4E7nUaXi1dkhHTT83/OlISExftiEQf0q5SyeuFjECuB1K9CSdTurKKzWMq4sNZPIFed+C2Y1sdiURmg/Ha05yqg8MBu6i9VkQqIcR4voc0C1Cz9Vji0V85qx1c5rdHWznQY5AytmYisYu2iKbONfke+wCs6waQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmg7/grjB1Olus528hF3c5HRxJhffUIKWbecHATkZG8=;
 b=LxzOX2g4eXW3vTRMDC+2USElj0eOgi8X+no3hVle8HkNliFLKaMxsi4p2kcvCh+lkKswDFsM694tT96Xcg+kVU3iWoUeF67LDEjOT4PnyyCyvNB4uRrXgkROaoC/XIdHiSlqpbZ82jk4P+9lwTzBs2ql4fG+k7bahxZQBfZESlJXUZoOcgD//AuczjjhSlvdFsCGZ2ib0fMupMNO9ns1HSpSi0Tu9i0PdbBmpLg8FvBsvR+P9tWxYkIzV2ieRVWPr59yzfTUT9660NdAfOdjFdtt1qmYtxnvGoYpPoKsd+izA6lPp/JNAfs2bNDy1SrOdiCVRu5z7q8/U1j6D9b3pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CO1PR11MB5139.namprd11.prod.outlook.com (2603:10b6:303:95::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.21; Fri, 24 Nov
 2023 06:42:31 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20%5]) with mapi id 15.20.7025.020; Fri, 24 Nov 2023
 06:42:31 +0000
Message-ID: <c4e6227d-7089-4d10-8c49-86bf5173b665@intel.com>
Date: Fri, 24 Nov 2023 14:42:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [filemap] c8be038067: vm-scalability.throughput
 -27.3% regression
From: "Yin, Fengwei" <fengwei.yin@intel.com>
To: kernel test robot <oliver.sang@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Feng Tang <feng.tang@intel.com>,
	Huang Ying <ying.huang@intel.com>, Matthew Wilcox <willy@infradead.org>,
	<linux-fsdevel@vger.kernel.org>
References: <202311201605.b86d11b-oliver.sang@intel.com>
 <242216e6-512f-437f-8a91-13d61a291517@intel.com>
Content-Language: en-US
In-Reply-To: <242216e6-512f-437f-8a91-13d61a291517@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0128.apcprd03.prod.outlook.com
 (2603:1096:4:91::32) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CO1PR11MB5139:EE_
X-MS-Office365-Filtering-Correlation-Id: 58147ece-42c8-49d8-5cf3-08dbecb88878
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: avVvi0rsHK3VftEX0gzrsorNv3hUz4Zb09tCfnaB+Qd968Wv4ZUASpGgcifLkxNU0PMpEXyUF14M3RRbdzQoe0BvDKpbdwAdvmz5kObWREpw1rToYeVBbIK+jVlKQDlzNoIs9ditwZSVDn3vPT+bkrjxcp+d5BQqa5lyi//m7UdWdlDCx15GTvebRxuz03oNueBnGAes95ikYom82qgjeaqzPaM8dAersvrMzv2GSb8p9Zv3+Nco0BgNb5Yx5uACA67pX1a7n1vpvzKk4LPZgJC1R/KAdXH9dzB9Skc0/YHz9OAnl8rdQSOulRgCWTvaj/ZmTGmuYSzAI2v1PE8/EON8RXl1O4HHy4LllW1uyaW8loJZ991wgOPsARM2AzdmKUDokeM4lSxwRH5M8oIv+sK33B4mk+TGAovDmnYXQ91Drh0YeMS4lFlTaAzL7OiSu6f/3sqvx5+nlsx7l8wo252OKI2sABFh87OjB0qVc73Wwl5lJqVMKmaQB6/H2MqQ/gbJJjS+x9T4I7RYWmVQSPR8F5vNU0DzCOzAgS/twI4FNWgSeI/5vEqr0butV5IXILSaSom5bwONiTLbogJVjQieJnYLR8wzHGZxuN+qNOx6Patlw8v3ApRPm+WELMVaxy7d+GePZxWV7Lq08Egazw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(2906002)(5660300002)(4326008)(6862004)(8676002)(8936002)(86362001)(31696002)(36756003)(41300700001)(83380400001)(82960400001)(6512007)(26005)(2616005)(38100700002)(31686004)(66556008)(54906003)(66476007)(316002)(66946007)(37006003)(6636002)(6486002)(478600001)(6666004)(53546011)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1FMZzNMbU4xVzVzYVMvWWtSK2JMTThoZmR6dmVlTVM3WnZtbFJONzJGVmdv?=
 =?utf-8?B?V0d1UmtsQzFoMnZTeHNEQmVFZ3Z3MmYzVEJwZTVVZ0dGNUdjOG4rdkdyOG1H?=
 =?utf-8?B?SWV5Nm5aVTZpTnVCOHNPeU5wT0RpeUZsWGpnVWdXelJWQ3lKYURGd1hXaFlx?=
 =?utf-8?B?SEFqSk5FOFdCMUJjRXk4a200MXpqSUFEVUlWWFVaUDNSUi9SL0FjTmpqTTYv?=
 =?utf-8?B?UUg0TzBxVnlwSldCcnkzUWFlbDR5N3FkU01LNzJlU1pFdllnY09wTC95K2R5?=
 =?utf-8?B?T1VZVVIxZk83OVZPUjZjS21CcEJQRWlWcmN3R244U0RoT1l0RzZPN0FvTGdZ?=
 =?utf-8?B?V2ZMUTZBbG9uOWxwdWozTlF4alh4dXduaHJsL2JSYlB4VUV3Q3pTOXY4V0V0?=
 =?utf-8?B?a0lldVhUQk1kdVFRYTJNUmpsbE9lQTA2akN0aWN1R0JvRmZXNFBYM0o5VTdq?=
 =?utf-8?B?VjJaMTdzSWY5S1I5RG1CRDhmVXNxRmprd0l6dGxvNkpsWExHZW1sWkNML1gz?=
 =?utf-8?B?aDk1bDFwdDE3dzhwQnJxeGVpVGRBL29nZFczS2wyVDVQeG00RTdybGt0Zmw5?=
 =?utf-8?B?YnErVnlHWlMyRzQ4cGV4WTN1cXdUZjBLVURuaTI4cTVEcUpkMU9hbVdVeS9G?=
 =?utf-8?B?ZlZqVWhnTXBMR054YXNBY2tqbXg0MFhDYnA3cVFjOWhwdHVaU2dkNDBnRjNR?=
 =?utf-8?B?TXZNSFAzd3BYWkZxRTZqUXkwRWNmdXZSVmR3V0Y0dm1SbW9FbzJRQ0VXM2Q1?=
 =?utf-8?B?NGlTQks1MU9iZGtYTFNNZ0dVVUZtK2RLajkxd2IwTHZyaXpLY1lOcVVjUlVx?=
 =?utf-8?B?Ym5ReFlKdnZERUZEanlTemtmbTMwZU1qTEs1S3R0QS9oZkZUOXphQmNWMVov?=
 =?utf-8?B?VmR4V0kwaHU4d2RLYUREeS9wcXNvU1A0YmFHM0tELzdUL0pBNUVYSzhtYnU2?=
 =?utf-8?B?eWFxWVFybFA3UXVQZlFWellXL25uVEhidkxqcjAxYlZRQTNLQSt1NEtTMHg3?=
 =?utf-8?B?U0tKNm1hY2kvcHRPOUtjcUFIT3IwQTdCdk90SXVINnpBcEYvZHgvYTF5RjFq?=
 =?utf-8?B?MTJaQk5mUnU0cHNvS0hQWjNBSTBmL2xOTWMzZkt2T0pCcEpXNVJxNHpuN3pn?=
 =?utf-8?B?RUNsc1BWOU1IZVVocXQ1TTZkSG5Na1M0Njc0aExHMytFUDZGYmtQNGVNcHh1?=
 =?utf-8?B?c00yS0g3MmZ3cEhBZG5aMTFsM3UvWTVaZ0VHUGhneStrK0xsMDR0cXlyQllK?=
 =?utf-8?B?cDlSMWRxT2FsRmtScytxM1lQdGkzUmtDaGRJVnZOZllkaUZXaDN2b25KWElU?=
 =?utf-8?B?WENiTU5LYVJxYldGUGp0OFFQN0RMSFNTbnVzWXppMW55Y1EyTXc5U1k2bXZP?=
 =?utf-8?B?eThBSW5rdmYwWmg5UE1SZ3d2SUIxdk5Cdk9mQUVGVWQrSGFJWkwrTHFBVkRC?=
 =?utf-8?B?Vy9qQ2pDY3pMQUduQmIrQjZ4VjFlSUFFWE50QXZwT3poY2xkODFwb0FWVm1S?=
 =?utf-8?B?WFJOVlJneFd6M0d0MjRRMWYvUkd1YXRQM0J1a3RlaHNwODJtWERNY1dIcWVq?=
 =?utf-8?B?M2czZTJtMTUvaDVRMitsWnpWNndzQkhlQ1dJRFZTeThSQ0hRQmxFalFHczV3?=
 =?utf-8?B?N0p1cGRWa0x0WVpGZFNOSEhpenRaVXRMWEtuYlFSbG9lRlBZN28rVVNicEJD?=
 =?utf-8?B?bi9tZWpMWmYwdG9uTWtyaExJMmlpdEtoeEphTXo5cHQrdDVDZU5aUThyNnEy?=
 =?utf-8?B?VjdPVElSSm9oY3c5Qi93ak5VMWdiZXNhZ0ZtRC8rMmhTc2MvRUlRWlhBUXp0?=
 =?utf-8?B?cGwrcmU5TFYvVnJjZ0thS0ZWNVBCdjBXLy9abmlNQnFGdDM5bFl6WWJoR1lM?=
 =?utf-8?B?aVdiVW5MaEk1SlZjOFBVaTNaMWhJL1N6cGV4UzdKcmdzbmR6clVSbW50Y1FT?=
 =?utf-8?B?bkRSY0w3VlNnK25sSGRrTmJLVk53YVc4bDM3djhadVlVVUdaNGxiNkhIamxS?=
 =?utf-8?B?VDV1Mnh6THB6aUxHdEVkNkNKclpDZlhPd3JmUWQ1ek85Q2o5RWx3bTRxeUhB?=
 =?utf-8?B?NzZmOGdjRFgwY01mT1NJb3gyZlRaN1k1YnBrUkVURU5zMzY4eTYrc0c3TFhH?=
 =?utf-8?Q?T0LHwlWiQXnUn7i495AojV8kF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 58147ece-42c8-49d8-5cf3-08dbecb88878
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 06:42:31.3907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4JwQKgKQ486ssts5xtRmkiw6EeSN627/fJrzdi1RNCnPfSNxDcb3lX8MBXb80tWSAATToaeD0ESbfoziO0fOnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5139
X-OriginatorOrg: intel.com



On 11/24/2023 12:05 AM, Yin, Fengwei wrote:
> 
> On 11/20/2023 9:48 PM, kernel test robot wrote:
>>
>> hi, Fengwei,
>>
>> we noticed c8be038067 is the fix commit for
>> de74976eb65151a2f568e477fc2e0032df5b22b4 ("filemap: add filemap_map_folio_range()")
>>
>> and we captured numbers of improvement for this commit
>> (refer to below
>> "In addition to that, the commit also has significant impact on the following tests"
>> part which includes several examples)
>>
>> however, recently, we found a regression as title mentioned.
> I can reproduce the regression on an Ice Lake platform with 256G memory + 72C/144T.
> 
>>
>> the extra information we want to share is we also tested on mainline tip when
>> this bisect done, and noticed the regression disappear:
> I can also reproduce this "regression disappear on latest mainline". And I found
> the related commit was:
> 
> commit f5617ffeb450f84c57f7eba1a3524a29955d42b7
> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> Date:   Mon Jul 24 19:54:08 2023 +0100
> 
>     mm: run the fault-around code under the VMA lock
> 
> With this commit, the map_pages() could be called twice. The first is with VMA lock hold.
> The second one is with mmap_lock (even no set_pte because of !pte_none()).
> 
> With this commit reverted, the regression can be restored to some level.
> 
> 
> And The reason that the "regression disappear on latest mainline" is related with
> 
> commit 12214eba1992642eee5813a9cc9f626e5b2d1815 (test6)
> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> Date:   Fri Oct 6 20:53:17 2023 +0100
> 
>     mm: handle read faults under the VMA lock
> 
> 
> This commit eliminates the second call of map_pages() and the regression can be
> restored to some level.
> 
> We may still need to move following code block before fault around:
>         ret = vmf_can_call_fault(vmf);
>         if (ret)
>                 return ret;
> 
>>
>> # extra tests on head commit of linus/master
>> # good: [9bacdd8996c77c42ca004440be610692275ff9d0] Merge tag 'for-6.7-rc1-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
>>
>> the data is even better than parent:
>>
>>   "vm-scalability.throughput": [
>>     54122867,
>>     58465096,
>>     55888729,
>>     56960948,
>>     56385702,
>>     56392203
>>   ],
>>
>> and we also reverted c8be038067 on maineline tip, but found no big diff:
>>
>> # extra tests on revert first bad commit
>> # good: [f13a82be4c3252dabd1328a437c309d84ec7a872] Revert "filemap: add filemap_map_order0_folio() to handle order0 folio"
>>
>>   "vm-scalability.throughput": [
>>     56434337,
>>     56199754,
>>     56214041,
>>     55308070,
>>     55401115,
>>     55709753
>>   ],
>>
>>
>> commit: 
>>   578d7699e5 ("proc: nommu: /proc/<pid>/maps: release mmap read lock")
>>   c8be038067 ("filemap: add filemap_map_order0_folio() to handle order0 folio")
>>
>> 578d7699e5c2add8 c8be03806738c86521dbf1e0503 
>> ---------------- --------------------------- 
>>          %stddev     %change         %stddev
>>              \          |                \  
>>     146.95 ±  8%     -83.0%      24.99 ±  3%  vm-scalability.free_time
>>     233050           -28.1%     167484        vm-scalability.median
>>     590.30 ± 12%    -590.2        0.06 ± 45%  vm-scalability.stddev%
>>   51589606           -27.3%   37516397        vm-scalability.throughput
> 
> I found very interesting behavior:
> 1. I am sure the filemap_map_order0_folio() is faster than filemap_map_folio_range()
>    if the folio has order 0 (true for shmem for now).
> 
> 2. If I use tool ebpf_trace to get how many times the filemap_map_order0_folio() is
>    called during vm-scalability is running, the test result become better. In general,
>    the test result should become worse.
> 
>    It looks slower filemap_map_order0_folio() can make better vm-scalability result.
>    I did another testing by adding 2us delay in filemap_map_order0_folio(), the
>    vm-scalability result get a little bit improved.
> 
> 3. using perf with 578d7699e5 and c8be038067:
>    for do_read_fault() with 578d7699e5 :
>         -   48.58%     0.04%  usemem           [kernel.vmlinux]            [k] do_read_fault
>            - 48.54% do_read_fault
>               - 44.34% filemap_map_pages
>                    19.45% filemap_map_folio_range
>                    3.22% next_uptodate_folio
>                  + 1.72% folio_wake_bit
>               + 3.29% __do_fault
>                 0.65% folio_wake_bit
> 
>    for do_read_fault() with c8be038067:
>         -   72.98%     0.09%  usemem           [kernel.vmlinux]            [k] do_read_fault
>            - 72.89% do_read_fault
>               - 52.70% filemap_map_pages
>                    32.10% next_uptodate_folio   <----- much higher than 578d7699e5
>                  + 12.35% folio_wake_bit
>                  + 1.53% set_pte_range
>               + 12.43% __do_fault
>               + 6.36% folio_wake_bit		<----- higher than 578d7699e5
>               + 0.97% finish_fault
> 
>    I have theory that faster filemap_map_order0_folio() brings more contention in next_uptodate_folio().
> 
> 4. I finally located what part of code brought higher contentions in next_uptodate_folio(). It's related with
>    following change:
>         diff --git a/mm/filemap.c b/mm/filemap.c
>         index 582f5317ff71..056a2d2e2428 100644
>         --- a/mm/filemap.c
>         +++ b/mm/filemap.c
>         @@ -3481,7 +3481,6 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
>                 struct vm_area_struct *vma = vmf->vma;
>                 struct file *file = vma->vm_file;
>                 struct page *page = folio_page(folio, start);
>         -       unsigned int mmap_miss = READ_ONCE(file->f_ra.mmap_miss);
>                 unsigned int count = 0;
>                 pte_t *old_ptep = vmf->pte;
>         
>         @@ -3489,9 +3488,6 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
>                         if (PageHWPoison(page + count))
>                                 goto skip;
>         
>         -               if (mmap_miss > 0)
>         -                       mmap_miss--;
>         -
>                         /*
>                          * NOTE: If there're PTE markers, we'll leave them to be
>                          * handled in the specific fault path, and it'll prohibit the
>         @@ -3525,7 +3521,6 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
>                 }
>         
>                 vmf->pte = old_ptep;
>         -       WRITE_ONCE(file->f_ra.mmap_miss, mmap_miss);
>         
>                 return ret;
>          }
> 
>    If apply above change to 578d7699e5, the next_uptodate_folio() raised. perf command got:
>         -   68.83%     0.08%  usemem           [kernel.vmlinux]            [k] do_read_fault
>            - 68.75% do_read_fault
>               - 49.34% filemap_map_pages
>                    29.71% next_uptodate_folio
>                  + 11.82% folio_wake_bit
>                  + 2.34% filemap_map_folio_range
>               - 11.97% __do_fault
>                  + 11.93% shmem_fault
>               + 6.12% folio_wake_bit
>               + 0.92% finish_fault
> 
>    And vm-scalability dropped to same level as latest mainline.
> 
>    IMHO, we should slowdown filemap_map_order0_folio() because other benchmark can get benefit
Sorry for the typo. I meant "we should not slowdown filemap_map_order0_folio()..".

>    from faster filemap_map_order0_folio(). Thanks.
> 
> 
> Regards
> Yin, Fengwei
> 

