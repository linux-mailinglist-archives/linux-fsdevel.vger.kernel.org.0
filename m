Return-Path: <linux-fsdevel+bounces-17291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2CF8AB035
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 16:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04155281B08
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 14:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472B1130481;
	Fri, 19 Apr 2024 14:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f1+Ql/wv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4710F12D77D;
	Fri, 19 Apr 2024 14:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535431; cv=fail; b=jXn7PAsmH9CXp6FFVp9e5dps+x0t1RLIZf30T6kjksB0UXCVXTpi2DEnY0MG647B6s57hJHUWhn7O5WclOISrKVYXe3Hay3Xq+E9aJsSCbeUl2fRHVntAzkwVdKT1lgQTnke9YYE4zMFgUwxlNiS/XPvkxm+oqltoD6XJCSXtPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535431; c=relaxed/simple;
	bh=Mv9U45WVEau0Ro5vV3j5+hOohtUsBSFKXYM/eZ0OeJg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hVK6slnpF8wYB68npRr39AyqAaVi1lD1kBuERaxERt7jPnJuPGi7QJ8eg+Vjw5ZwdqdlwHrdLZZ9tyEay3taXICZmLiTb8QrUy2YAz4PMdjNWSFdcB1hmuQ/BIpnznRsRiWh8rLkg8knC4ET9p/MH4nvZzr5y/8kStKXQxdKJgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f1+Ql/wv; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713535428; x=1745071428;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Mv9U45WVEau0Ro5vV3j5+hOohtUsBSFKXYM/eZ0OeJg=;
  b=f1+Ql/wvTFePbn2cX/IaFrRqpiuOZpmDyntSpgAey9dv5BRgQjoktrxD
   H1tntekOIdSFImIV1ccJeL3QGCakYPvG+hyZumQ+4OHlRjfy8AMBuByCL
   hdKQRntR7GzH56mKenTCilIM1YPEX+MAYoE5pi/vGw5WYyrwFLAnl5tUk
   AxbWg/rnQ0t9PDogvI5g3eJjP1XD9mN2Ef4jTCDJv9gv/8d+Z6cBRFOl2
   Aw5dli7wcYdKLwVcjIYvpYBsHawF+ugHyPzT5GMw730i/x7KFRI6jrnOX
   pPSwKyMyVrdRQI+VQw/0b27i61pZgGtUbhUGIo9Gp/Ykdrk5HESbePvxB
   A==;
X-CSE-ConnectionGUID: eR7g3vKhSveiwgi4ZZdtuw==
X-CSE-MsgGUID: Q/WbJSNpT2K+Z+lnHIQDiA==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="9358506"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="9358506"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 07:03:37 -0700
X-CSE-ConnectionGUID: QyZ2SoVdTjyPLk/zeBbnJg==
X-CSE-MsgGUID: E4tMXk8hQlinOCrTYg8uwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="27991038"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Apr 2024 07:03:37 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Apr 2024 07:03:36 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 19 Apr 2024 07:03:36 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 07:03:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LnOMcHlepoxIn2pgBBahX++wNYlRe7OcNQrbsxt4izTjWs73HAYpGu2nxrVaRidhD4StOe9SqrokvY89G7lGasP2/ReZIs7PKtRUekU3o7+HF6jlCroJfhfE3oJYpS6dTOr5EmwyNezKfkuSYgAZpreKZApK7KZROjdlqO5K61yYWv5cbRplzw/Bngh0mGz0vzJTwY/Ev6z1/SVEa/Gn9fVY/rcUojTEEDf5SiOMgZW6N12PgqIHc1Rv9Ifif1jvqDR0TEM8bTnx3FqPZ4mmQLcwg5rG+oTQdIvQDnnseQPMVx7V6IZMMTF9QnLaNWFxD7z2m58RstPNQvtgcMg3gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nyzI3Vmp3H5kO7IkcqXzvo2dmNQBGHQuKr3i0Q5V7tA=;
 b=Eu9bh76+R+lNTdPIHYAdE+TZs+emvvImvNXe25eNGN4t2hNoNNr0VarertiM5NM+OdGQmH+KVEFlsYPgM2HBHi0c4AkpsfteV36mM+G6bcC1B+Qhb5Mk0vlz9Ba+Pba82Ub0iQZSeK9MlP0MClxtkKye7T93aH1D6g2MWyj5XKkg+jsCYltzoxi2dRCp7j/iCJeyOPLf+hYG+HjOJdUob/iLl+o35tMT+Ca4dvuDlLz7SFzLQRt1ssO68kPzrT2lQQTiLbvR1j87zLFn9/FdUDn8nH/XAUTVtoZj18Kb4BEjNMJq0Dtl84vn6fjTbyY0AIQ5qcFCTI+UJXeBpIjs3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CH3PR11MB7915.namprd11.prod.outlook.com (2603:10b6:610:12f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.29; Fri, 19 Apr
 2024 14:03:02 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::65ce:9835:2c02:b61b]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::65ce:9835:2c02:b61b%7]) with mapi id 15.20.7472.025; Fri, 19 Apr 2024
 14:02:58 +0000
Message-ID: <7be194e4-a17d-452b-ae31-cb49f1530b5f@intel.com>
Date: Fri, 19 Apr 2024 22:02:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/18] mm: track mapcount of large folios in single
 value
To: David Hildenbrand <david@redhat.com>, <linux-kernel@vger.kernel.org>
CC: <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
	<cgroups@vger.kernel.org>, <linux-sh@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)"
	<willy@infradead.org>, Peter Xu <peterx@redhat.com>, Ryan Roberts
	<ryan.roberts@arm.com>, Yang Shi <shy828301@gmail.com>, Zi Yan
	<ziy@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Hugh Dickins
	<hughd@google.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
	<dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, "Muchun
 Song" <muchun.song@linux.dev>, Miaohe Lin <linmiaohe@huawei.com>, "Naoya
 Horiguchi" <naoya.horiguchi@nec.com>, Richard Chang <richardycc@google.com>
References: <20240409192301.907377-1-david@redhat.com>
 <20240409192301.907377-5-david@redhat.com>
Content-Language: en-US
From: "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <20240409192301.907377-5-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::10) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CH3PR11MB7915:EE_
X-MS-Office365-Filtering-Correlation-Id: cfaeced4-ef6c-44a1-1f87-08dc60796b1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: POkdwsIK/Uj5HhbpWA4qmgb23Chodh47K7Bm9dQ16ZOcsh+4aW3ERQO20nD3MHsrE6XsgUzqgv6aQD1jerfXeLOzlBLjL1XbNDtqn+ey/N+nwd+IaTZdxkkV3LzjANgB3EPtbqU5caLJ5CMgNuLyZAMP4s2rav0nWHQlGYEzda7sOefsJplxbhiWoeG2V67ShpIy2Zd9wEzlp7ns1iAM58Y/fKzlWpUt1dVK7uIhc0DePXfcV9DiZdwjhJ53MKLV8JQAPdio0TeCeBgyA/njkikuY1Ora3yaYuwp9iMknPdpFbNrU9PAuejsLP9Uy2V/WvMYUVTRfN5T64iV3t9ozDI1SgyLb7xu/3nuKM3lsrmLjnke/8LDgZw+I0uFDnSm/QoTFMPVWdyHpDD6SiQ70QrZbH5YM60r3y2hYizOHuAmJTJjHgmiSX9eDhQC70ErLNw4ThhOWv8954p0sM5o+qA4hI/q3Hqw3xKfMQinnoMUxxRk2Bhzs19escbrRLZv0vj/CiAkGOpoolx0q5WmPu7cWIehzNoROONW48JV2VrgkqTKzse7uskIc96LFGGLyMKcHkG58AHxJ3710rEBYhCzx0RdUPi+n9wiGQu+WSsH+C4sJfToqI7XMjzqglVG3DO2oDbWcxDA9yp1aTK89uV6NS42+MFTQlhdYXfNYAw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVozUTlmVDhySU1BN1AxMVhBSXQxUk9PQy9lcnkzWGdHYjg4bE1EanluNmZW?=
 =?utf-8?B?ZCsrTVprYlpNcjJXOGpteXlsWmFXVDdJTGpoS2NGTFYwRDA4Mm15N2dydTZ5?=
 =?utf-8?B?eEdNZUFQenkyZFBhUk5yTVYwQmdhTmdTdTYyRWRZbGNCb1k4VXNybDZKT09H?=
 =?utf-8?B?QzBnTlFNcFJ0dHd0YlVjTWEzV1Q2QnlsYjFvZkhSTDdOQklwQzNuRFMvQ2JT?=
 =?utf-8?B?MmRlK3U0UTlOKzY0bnZkTmZWUjhtREdWanRDanZpRmpYRjhPSk1KbkFQN0g4?=
 =?utf-8?B?M2JkZGNVdGx3TEdkZncyYWxsYjNTNFh6QktJdDRRUHFrK1pOb1N3TmNHZ1Uw?=
 =?utf-8?B?TW1seUFFM05wSlB3OElrTFZJeGhRUU9pb2JMVUFiaVhVejZ5Nm9EYUJ6a0Jj?=
 =?utf-8?B?ZzVxdVRNdWpaTmk2bFBMaUhGL2xFVmlzY3Q4TnoxbStLb0hpS0c3R1ovM1lY?=
 =?utf-8?B?YlVYR0U2WVVwcmQ0SWNpVlVmdG41bWlWaE5yU0wwNHBqbWdNWmZZYXlQdmhS?=
 =?utf-8?B?bGFKVzV5ZFVsUEx5YmZUVm9VamF1UDBVT1BlRDBTaWFHMnRuMjdKSUNHTGsw?=
 =?utf-8?B?T2wwc0dCWTFRRGVhNGR2elY5OWh4NWNqamV3WHdRY3ZZZFFFbnJDZXFPS3ND?=
 =?utf-8?B?VVVnUzlxL0FEcjdGRUJ5WjBoMExnbDdLRjNBdVdlSHJzOCtwdEl0QTJVUkMz?=
 =?utf-8?B?V2lYV3Fld3pVQVE4aU5kUjNwOVpTa0drQVIwbHRrczVkRGs5OFc5S1pYVDZ2?=
 =?utf-8?B?N0RhUnlUdzUxWFhHeHhESk1DQmV2Z0dkZ2c4RHBxT0VzUFp0VEJ3alRYZ2xS?=
 =?utf-8?B?TWd5N1B2bExqNis4SFc5QTNkdlM1eXJhUk9mOW9zZWowWTFtUmw1dURtWWFl?=
 =?utf-8?B?dk10T3ZIOWJDUGxuajFTNStqOGVXZksrR3JtR2JXNm9pdkZnNXZ2VGdhZGc3?=
 =?utf-8?B?Y0I1K1ZnRmdhcXdpRmxPNy9WcTh3eVd5WFpkVFZZbTQ2dndxcUpMN0xVSnhK?=
 =?utf-8?B?Z3BOekRMNDNlS1l3cU1PL09QeXlGQ096S3ltU1h6T0kvelRxaHBtVVl5YXVN?=
 =?utf-8?B?ZFBSSDRRV21JNU5OTGpnQXFndzlOQUxTTktRcEN3MUhRTGJoSmZlRWI4SG9Z?=
 =?utf-8?B?dHJ2OFE0bmlZMTk1MGgzN3Q1WHJldldHbUdZNWQxbFZWWGxwRHUxMTBWeDJU?=
 =?utf-8?B?MG00N2pRMnpESldnMjROdU9RL05tVUgxRk5ML2xkYU5HNlpaaEVyNTJzRjV1?=
 =?utf-8?B?YldMUEZlQ1QxRHpvSERhc1lBanhSb3FJQ3ZqajVpcFBObU9obGYxalhQMi9r?=
 =?utf-8?B?R2g5NDNveUJMV3dIZ3YyUGdVQmkzaXZ0VDNSbHpRamM2cDhmUVFwTnIwN3No?=
 =?utf-8?B?QWt5ZU9ZdWxLVjRoT0JFN0dJZENJZ2JFVEo4cmJ1Yzl0WkdCdUFGdkxkUEs1?=
 =?utf-8?B?VDFFbjk0bFlCSURxcmNtTngwdllqK3V0b2RiaU9xTGtGSWVrNzY3WEhZTTha?=
 =?utf-8?B?NXZBb3hpTEplNVA5SlZHRVFEREF5UDB6SVcybkcvTUFmV2g4d2dWWExEZzR2?=
 =?utf-8?B?eVlMa0lZZHZXRy9HVFlMVGE2QjlBMjczbk9JTnFSSE9QdG43dnV1SFFEVHEz?=
 =?utf-8?B?Qk1TL2wwK3laSWUzOVlYRm5XVTFQVXVqcy9DdSsvSkNZaVE4MWJSbGZrdkxh?=
 =?utf-8?B?anJEVCs1MEFqby9IczFOOUpWMTdocGpTR01VaDN1VGNHRGxucTdqUFpRMFZT?=
 =?utf-8?B?eVpBWnJLWlVjSk1LKzVHcUNtZjlDbXMzWXN2cUhQaEhIVVhsK1czNXg3WTho?=
 =?utf-8?B?ZnExc0o1M0NJdytBWmFNMDVTR2FOUnRnRmpwWXJMTUVxNk9sejVvdHdXendx?=
 =?utf-8?B?c0k5M01uZGRjMERYNmxWT0g5NjhyVGxEbzBKN0RJaHZ5dTltY3JkR0ZmSU5G?=
 =?utf-8?B?T2dzOVBrdlNTVndpTExlZlRRKzY4azVRVFBJM2IzU0JVMHpJOW5MaS9sSUFD?=
 =?utf-8?B?V1lhdDVkT3ZiN1FOa21vdVlVSzFIRERucU5DVDBuemhrcTY3TS83dU95U3Nh?=
 =?utf-8?B?VnhxWGJzaS9LeWQrM1FJbUpaWm9xM2E1Y3RxbCtYTGpocjEyc0IyRGZXaEg3?=
 =?utf-8?Q?IevDYZZQ4bAISeXCim+m6PmsP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cfaeced4-ef6c-44a1-1f87-08dc60796b1d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 14:02:58.6456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J7Mbzjk7YcW5agLahDtG+u99an9ViLxGmeOU1cWzs4cPD0arbYnMwKEPp7mtpKSbbwSsj6emMzK8r3atiuS4gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7915
X-OriginatorOrg: intel.com



On 4/10/2024 3:22 AM, David Hildenbrand wrote:
> Let's track the mapcount of large folios in a single value. The mapcount of
> a large folio currently corresponds to the sum of the entire mapcount and
> all page mapcounts.
> 
> This sum is what we actually want to know in folio_mapcount() and it is
> also sufficient for implementing folio_mapped().
> 
> With PTE-mapped THP becoming more important and more widely used, we want
> to avoid looping over all pages of a folio just to obtain the mapcount
> of large folios. The comment "In the common case, avoid the loop when no
> pages mapped by PTE" in folio_total_mapcount() does no longer hold for
> mTHP that are always mapped by PTE.
> 
> Further, we are planning on using folio_mapcount() more
> frequently, and might even want to remove page mapcounts for large
> folios in some kernel configs. Therefore, allow for reading the mapcount of
> large folios efficiently and atomically without looping over any pages.
> 
> Maintain the mapcount also for hugetlb pages for simplicity. Use the new
> mapcount to implement folio_mapcount() and folio_mapped(). Make
> page_mapped() simply call folio_mapped(). We can now get rid of
> folio_large_is_mapped().
> 
> _nr_pages_mapped is now only used in rmap code and for debugging
> purposes. Keep folio_nr_pages_mapped() around, but document that its use
> should be limited to rmap internals and debugging purposes.
> 
> This change implies one additional atomic add/sub whenever
> mapping/unmapping (parts of) a large folio.
> 
> As we now batch RMAP operations for PTE-mapped THP during fork(),
> during unmap/zap, and when PTE-remapping a PMD-mapped THP, and we adjust
> the large mapcount for a PTE batch only once, the added overhead in the
> common case is small. Only when unmapping individual pages of a large folio
> (e.g., during COW), the overhead might be bigger in comparison, but it's
> essentially one additional atomic operation.
> 
> Note that before the new mapcount would overflow, already our refcount
> would overflow: each mapping requires a folio reference. Extend the
> focumentation of folio_mapcount().
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>

