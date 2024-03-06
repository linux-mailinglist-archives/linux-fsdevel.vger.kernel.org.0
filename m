Return-Path: <linux-fsdevel+bounces-13679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5477872E74
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 06:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7519C1F23124
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 05:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CDE1B948;
	Wed,  6 Mar 2024 05:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cLLkvxe4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D129DDBC;
	Wed,  6 Mar 2024 05:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709703384; cv=fail; b=QxmPaK0NTFI5gSl33K219ZgB6PtS5OIIw9FGsiVN/Qq3yz8FuOBUIU9WxR/dr0oQ/9AjAAPIVQrPfuF6+dWNlutzU8cGbcKvzsQzYfmghZJXJBUKScw2Lq+Z0YAznAmDCUxLBxthZXhe+O50A94sTSOABhrjCTHHOyBi/wZWCgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709703384; c=relaxed/simple;
	bh=hqT39Wcq436r0hVjEOqSekPDEy9uSlc6X/5rzRr7hhQ=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aRlqeMPhx+cAtT2CLL0FOxXIX0laH68zcpFgSjtfJnpOghEEA67WtlbAkJ/ekn4d5jg2yBy0RFykce3Ufrkzu8XbrM7fIXbCWKq6LGvPhzE7XMRUV6WHz7G6yoX6zU+jPSVyzfxmb0uxHk/L3sqxhK+iw448WedTa4OjSIR1pWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cLLkvxe4; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709703383; x=1741239383;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hqT39Wcq436r0hVjEOqSekPDEy9uSlc6X/5rzRr7hhQ=;
  b=cLLkvxe4MnN77csHeT8EKYeSChjv8/CkLe7LSdRs8FD/Wl81YR3y5yWN
   VNR02197jw29sOMOc62QS/vmrQn7cDsvtUFnnWWms1UvdggvcjmYhaQq7
   hY1I04C+A2ZRaexMnaJOKJD67XnD87za/+w1dRTCWcMA6m9awvPTz+rAX
   sDMTOuum9Xc3WiPtFgnr9/Uh7OT6TfNgBbzjaG+E8UNHWQauvmsuvUGbT
   ZpL4DxoRxZnzRzIQx6ufmRxZ0Pc0984keEUNY3wCc3oEuaw0/vWE/3ywz
   GlZKs+nG+Ht/u1a+Sh1FxX/t9xxf2uoaTQ8jrGpaObHctJoZp98V16t+j
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4451335"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="4451335"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 21:36:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="9802157"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Mar 2024 21:36:20 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 21:36:20 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Mar 2024 21:36:20 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 21:36:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfoMuCNhdCuehmgcldBKgqnHaHpC+O/d8vPjr3ecxkU5TXV3DmoyXL/4SoR1S0DLwmsfD0p9fEe+EkdkMOSHyc0VOQ1kZcQ9zPftKMnbiGwLxz0h/J7Y99GnchWmCxd2WNYUDp8fuZNpjrKRKFlVx+7gyxd0BhQctPYxUPjmjoTPB+cmVASOnp41hDes/CEXJj+0tIEZfH6d/IRyqDxQqmqe37hyeSEr/jMiZh2rW8cAeIQWvoeDZ5BRjiOHe3O2iNNo1xUvOIf401SnRFWcA03XXxtAff4RHe4nmEzW2TOAZ7c2G6TYCmxfA88NmeccinzLzN2UnLqVoYjRLB7ZMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hqT39Wcq436r0hVjEOqSekPDEy9uSlc6X/5rzRr7hhQ=;
 b=P0JA0VSMOKtSm6YF8OmDfysGu5sICHtzEOp6iW3iWQb3AjoLIZrBQOhJ6c0SUDUpmrxN+3CU2gzb/x8vp69DwFTRVLteeMEVbTLIe+2P2irxBPlZY9fZFMGhbNU99yJF/mTj9rBJ9Sysfr6a+oqRUXZWHLYdrSzKRz4Dn/t0SMNe0Owma4eH1CW7ZjefX0GM5xoWO4axFGVgMVkSWfCM9v3A6VamVKtaDqs7OxZrLDBA2ylULwVrDkYFQzuTSxyu5j63Bs6klsvx1np3rrhAkLnhSHk6r80pACa/6Os0qRlvlK7/jd3zDaQAvZLZ9++RrDxvnw+rnV9tIXEWwM8noA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by LV8PR11MB8722.namprd11.prod.outlook.com (2603:10b6:408:207::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 05:36:17 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::65ce:9835:2c02:b61b]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::65ce:9835:2c02:b61b%7]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 05:36:17 +0000
Message-ID: <707e218d-e9d7-4f37-b9a1-48b237e72e42@intel.com>
Date: Wed, 6 Mar 2024 13:36:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [readahead] ab4443fe3c: vm-scalability.throughput
 -21.4% regression
Content-Language: en-US
From: Yin Fengwei <fengwei.yin@intel.com>
To: Yujie Liu <yujie.liu@intel.com>, Jan Kara <jack@suse.cz>
CC: Oliver Sang <oliver.sang@intel.com>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, Guo Xuenan
	<guoxuenan@huawei.com>, <linux-fsdevel@vger.kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>
References: <202402201642.c8d6bbc3-oliver.sang@intel.com>
 <20240221111425.ozdozcbl3konmkov@quack3>
 <ZdakRFhEouIF5o6D@xsang-OptiPlex-9020>
 <20240222115032.u5h2phfxpn77lu5a@quack3>
 <20240222183756.td7avnk2srg4tydu@quack3> <ZeVVN75kh9Ey4M4G@yujie-X299>
 <dee823ca-7100-4289-8670-95047463c09d@intel.com>
In-Reply-To: <dee823ca-7100-4289-8670-95047463c09d@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::18)
 To CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|LV8PR11MB8722:EE_
X-MS-Office365-Filtering-Correlation-Id: 70260ba5-6201-4ec2-86ea-08dc3d9f585c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8XKSy9Chht+M98gt/7swiQF3Rcx8hc+gENi2PtDMNnCzG5rvkI3zUFKfH8RtynWNgHKIfWlimzDO0XGUIUdbGE8gd3IHP2SNyp6ypb3R1a6EJUJ/A+XXznoWya4wFfG8teLV/9Eov4QuN2Zh8TjRHfCz2tEbyp7f6KGGpsLzIiAfd7iLic8YIYiQgW9zQ1NvCzgLze8XHhyyfwVeayjCKMOVFrVoJ13KWfeIyuy6pq84pfNE/CCTHs1KCp/phO8FY3CZ/ca0Oax8I6Ck3IdDyRBmf9Sy+AZ07wV1RnBQMcU+hHXWBJDPG8B1obePa7xW6lkeaY1B+klVVsDnYbZq7obYKl0s+Nl9fzEbbaABIOfbAlyg8z3oRypf67lES1+O2wHg1YKdWzEoaDclS6hqwqLxhS0eZwS9Jc4UZqaRMpZqQpEG2d8hddO5oRFIujAjJF6W+FLWOSfrCJyOLQFWPuMAwd4FdlfOabzpQToRVRiC1UULrCGAC0TS6qAoOSV2o3itoKwWRIXoE67xpdskc6bqAQ3hOYtjbGlLst0LvH2BWhOgYDZ4EsGvoZqByiIiS5fvdk+3viUUBz+hkcl1nWTkhWeVdkAk/ZUw1ENkYX8Ul/l0c7yoNcpZv2ynGsaCu/zv5f8HHEEu8uXFYI0dO7KqTyzYX5nyOgjecb5OEEc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkNJeEFteEo4SVJvZXJtTWlIQ2xwdUNZcm9FczZaRjVTUmwydnFGaGU2VEc0?=
 =?utf-8?B?MTZWOXBUSGROYkV5N3U3UE15b1c3YVNvbFFoM0Z1Tm12dU12LzJBMnFBOGlo?=
 =?utf-8?B?ZURSc3pmVi8yd1NxLzA2aHJRT2VIZjVaZDV3dGw3c2NtYlI3TGJ6MmIyU1Jr?=
 =?utf-8?B?cWVEQXN2UTJ6YTJoeDRuTUFCaVFzODdmTW5sbmJNVVpXc2tET2FuWUwrY1VS?=
 =?utf-8?B?eHV5WThOdGxRNjY5UE85OXBBN1doYTRSWnRsWDBKVWJLaXJGRXZmQklyNEdN?=
 =?utf-8?B?T3d3ZzBBRGxtTGlxZENmRGRhSDFNd3Judlo0T2d4YWVjcWFrMmU0ZVhndW1E?=
 =?utf-8?B?Vkp6bnVHTmNVVjNVRVFId1FtMEo2NS9Gd09CeWhnYnYrOW1ZcytwZG5OMmlD?=
 =?utf-8?B?aVpVSDVWc1FxN2hKVlV2a01PZ0RXSDIrU04zK2huWisxT0xkNzRnVnRCaFlH?=
 =?utf-8?B?dWxIVVNrWHJNU0E0K3NycmliOCtnQWFWOVJTWitjUHRwemJ5ZTM2a3ZQYk9a?=
 =?utf-8?B?Zng5UDZSblFyS1NWM2MvVVhoM3hUVFl6RnZqNVJEYVA1Y2pZRFljdm1LazZE?=
 =?utf-8?B?bmd0WWJIS0M5dGh0VFBkTXNqL3pZdVZZajI3RzlCR0ZYbmd2RTh4RlNZZUgx?=
 =?utf-8?B?R2VKV3d0K0NoektGV3VSaWovQTZ4cGRXMVFvS240dWtNSjRMUHJmcjcvQ2Rz?=
 =?utf-8?B?RktMQ0NDNHd1YTBSMWtYek5FQjg2bnMydnhRRGFzS0dOQ29mRjdubWRZSXNE?=
 =?utf-8?B?SFlMYmVESDUvdWZ4L3gvdUpoaEFjMDVrK2xGQ25LMk5FZ25YS1NibER4cm5S?=
 =?utf-8?B?SkFFay9yVGZZK0NEelBoL3Nhbno3VVEwUFZPVmhDVFJjVWgrb0RoT1JDRE1u?=
 =?utf-8?B?ZzVrV0NuRS9nRm5uSk9EQzVoOElwSlAybjNjOFo3elp4Ukp0N1h5VThoUjNI?=
 =?utf-8?B?WkNtRW9KeDYrR3NFM2M4Sjh5SWdSM0JxUXRzRnRWMCtCSXg4TXM1NzJuSWpy?=
 =?utf-8?B?UUJMSlRiWEtjdURZWmFVdUZyT3d1dUdiUFptb0dLTFcwUGRaTWdNeithQUFi?=
 =?utf-8?B?aHF3YWxzSHgzSUx2bEtvYWNNcXlkWEpCaW4yWWJQTzJudVZNU1lWUGJrK3pU?=
 =?utf-8?B?bnI2Y1hxdy9TT0xqaDJyeFNkY1VPVTFvSi9aL3lpcnAzUG5GOVpHZ2FrWUdQ?=
 =?utf-8?B?Zyt1Rm0zK1k3aTd4Wno0RGVQZjl2OVhmODBiMCtGUGhIaEsxNWxaRWs5T1Z1?=
 =?utf-8?B?Nk9rK01GZVJtNEVDdjdFc1JmanZtMFRMcUhsU3JIYnVya0ZHMkRvMmhXbFNi?=
 =?utf-8?B?ckVXQzltMWNLSEx0Q2dUbno3bEVWZXYwQk5HYUlaalM2RnJLZjhWOXY5Zmc4?=
 =?utf-8?B?c051ZzI3WWY4UUpnOE5GZUFnemRrMDJqYXZMZlNDOHJGR0t4T0xnK2R1Y3RE?=
 =?utf-8?B?OE9yekRidVJBMXFIaFNoMDBCRHlYUTlaYXpwdDROQUZ4c0pucmtOZ1I1ZndE?=
 =?utf-8?B?aUI2Vm84S3ZqdVZ1eVNVMTV1aFlJVnRNcTJ1MGFBM1RBS2ZLSStKV3dvOUlX?=
 =?utf-8?B?SWUrb28zLzhHemdkbEtVOEFyZmhiT1YvWnNrV2JIbjk0cVhuZmU2OVNiU1Jo?=
 =?utf-8?B?ditUQXMzeVZBOWZKV0lGM0JsUVJwd3pLQUFyUENqVVVWTzBUYi95WGdMMTNt?=
 =?utf-8?B?V2NmVUpkaTBVcjN4cGhDbkR4SHE1aDR2SFdvSEtqMFpNcSs5VnRsYkMrWlN2?=
 =?utf-8?B?ZGlQNThiTzFTclBDOWR4MnhmRWdoSnc2VHRVMDJQd3pRUHRTWEZnZk91YjFB?=
 =?utf-8?B?bEYrS1JxM1VhajJ3QjE5Q213aEhKbzl1ajlCTmJxZ2oyVXN5OU4vYmJzTy95?=
 =?utf-8?B?LzNxWitCb3A1c2NiMmFyZHdmdlJWMEdFN1RYeVIxVFdHUVRSYTlvSkxjWWtO?=
 =?utf-8?B?Qjk1ZVc0U05yRVU1V2szUmJhK1VsK3NRYitzbkdOcTU4dmVUbGNlakR6L1pI?=
 =?utf-8?B?eE1nNjBJRklxNFppaHpPMExvbHdreVdvbnNqc0JlZXAyLzdSeTQrMitHU2lt?=
 =?utf-8?B?OGhneTBRNUpuNGQ2eVFtaFUvTXhESnBRZFpKWi9kYzlKNXJKMW9ObG1jYnE5?=
 =?utf-8?Q?SoqRQDQeISAKv9WPDy9DZ3jvh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70260ba5-6201-4ec2-86ea-08dc3d9f585c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 05:36:17.4701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UcF1jAUWW1Jm64FvX6ksv3i/9yUGZTVWPNmNLuK6zvL8QUTIDWsgkc4I48MwjTnZW4AsFAj4AAKdknyTcF+Kdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8722
X-OriginatorOrg: intel.com



On 3/4/24 13:35, Yin, Fengwei wrote:
> Even the file read throughput is almost same. But the distribution of
> order looks like a regression with ab4443fe3ca6 (more smaller order
> page cache is generated than parent commit). Thanks.
There may be confusion here. Let me clarify it as:
I shouldn't say folio order distribution is a regression. It's smaller
folio order cause more folios added in page cache for same workload. And
raise the lru lock contention which trigger the regression.


Regards
Yin, Fengwei

