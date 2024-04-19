Return-Path: <linux-fsdevel+bounces-17293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D67488AB03F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 16:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BB2B284DC2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 14:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945C41304B6;
	Fri, 19 Apr 2024 14:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LRFXld0d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAFB12E1D2;
	Fri, 19 Apr 2024 14:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535447; cv=fail; b=B9lMFOQGOwe/T7QBqlu+6Uy4/FO3Pbsz/8bCuHacimE7yvwtuUL9P1Z+nldrr2J6jV1NCZBAqy4YCsMEcjlUkHSeQviHDMGkhiJ1IuV6HOvtAL3ntESRLwnWZplQ7KEhvQ/o+c0IanJpYuka7zhJjS8HJWukqN8/ikJhEpMLIWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535447; c=relaxed/simple;
	bh=DIYInrMvx3VTMGQKvO3XetqZCL3Wvvc6yT//hF422Fk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pryxulD3b39NsBJjbpqvMSJnsxlSSAufgk5jj+SPkU2F9S2x+gM3vz3GdiSSK9kTWTayQ7XcXZr9w1jdbSsaB9kvcD8pNzKBs5iffs1uu8CtEhrpgqxaL8tVXUJjB2VKHIjsdogt4dlRFb8ic0SzL2Iu82mdgNXD2/LAvNyKzuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LRFXld0d; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713535443; x=1745071443;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DIYInrMvx3VTMGQKvO3XetqZCL3Wvvc6yT//hF422Fk=;
  b=LRFXld0dTQQIOmJPbphbvG+VU6mCzD9BQKgarGYz9IbLjMG9bb2tGdml
   FXgI98gDw/U9t4KQwa75484fW5wGsHw5jzODI673ZYzdpfnnMuie6ddmh
   QqWNhs2WDsbye9c6DUmItMjxWXRnbDf77DLMjGTPs8m82geOYa/F3P9h6
   kq8tvtf2q0gXYzyMSzIdMRyLRefu1CQWV5G1PX5oCdVxqx5c7fwGGfXTn
   Fx+a8uRJ5LLykrFJy05rBRRm/fbkerIgZuADBba30Cf4BWDChgODilBpX
   ObdmmHLFQFXVjnLA5sqbav12V0c34KvjFEAlX+hOI/k3hPlxVFi85Knze
   Q==;
X-CSE-ConnectionGUID: lW9Gf3AnTi6Pa0FfbLaBJw==
X-CSE-MsgGUID: EJ8N/TpWRVyOWmbcwxaqoA==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="8996376"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="8996376"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 07:04:02 -0700
X-CSE-ConnectionGUID: Q61Gz204TbWYzcmWsaue0g==
X-CSE-MsgGUID: NSTqq97RQlOA9Gx3qmYswA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="27803901"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Apr 2024 07:04:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Apr 2024 07:03:03 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 19 Apr 2024 07:03:03 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 07:02:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWVbdzLZsKoGipA9E11qtBogufsPjEh6Ywq8iUAaTTI2TVfljSdMA1Twrm4RLKVvaebVKRqN0ROvMsNSDs2Z4UQGYozcegfnCaqUsvd4mXZN87iI9sLvTb5efCuguMfMoIlst36GsNvr9DkiVXTNFN4cFCP4DElwF0wf46OUKa8haNnvtGFE0OUcRk6oeVAQqGRYJwCyLrUsLR0EC6ww8wYY/Or4Z2MAJ/OuG1o+6BVxj26CfLQmajkBo7vdi9duTn4qu0ySTy+XxTVmZNPVGINfhAIymdQWK2cPdFsjYWT6iGql7BdpV4GxZvLi+MGNvFTMH4F2OhGTJSTAd/S4fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3tIsiUALoNsyHEdzalrmf/oi1tNo3tJnXpFVMPuaGoU=;
 b=A4nrXVTCSTPevf0Zs9CXSgDHukqZV0ub9Bpe5iRKNxAl+j1kZeG54nyfxXQ3hg2QYGKHqn5OGdM38Dh+uJFh5N7E7V5G279hUvpG6/JoUfk+dstzPl3Wrbb+BJE+ToqAgehT36XwA+Ku3W0stXSOEYxhMTXuN6XK0ylzStzGjQQ/iSXXPdalMSoNBsQTZC+R+l8lumRGox9bVxEpMEBQ85VBAZb3nKQBLnqxu8UE36CX5wubn9P/5ZdLdTQBaQxTJ0lXTPD1ojKImK+Vb79miFBDGm+Cyo+BWPmJqfKzuh+ptRnKTXVk686kWduWo6njlBWi3ygvSYVkht2htjofhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by IA1PR11MB6100.namprd11.prod.outlook.com (2603:10b6:208:3d4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Fri, 19 Apr
 2024 14:02:22 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::65ce:9835:2c02:b61b]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::65ce:9835:2c02:b61b%7]) with mapi id 15.20.7472.025; Fri, 19 Apr 2024
 14:02:21 +0000
Message-ID: <12e65c32-076a-4394-943e-7c1e9f63bcc0@intel.com>
Date: Fri, 19 Apr 2024 22:02:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/18] mm/rmap: add fast-path for small folios when
 adding/removing/duplicating
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
 <20240409192301.907377-4-david@redhat.com>
Content-Language: en-US
From: "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <20240409192301.907377-4-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:4:186::18) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|IA1PR11MB6100:EE_
X-MS-Office365-Filtering-Correlation-Id: 98eb34b7-0e9d-4909-06e1-08dc60795531
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UkVRQkh3Ky9RYmc4QUJhREUwNXR0dmlTQWNRMUw2blR5ZjdmK29SSXdYL1I5?=
 =?utf-8?B?aks3dERXVjhQdFUwVkQvd2w4UGcxVHljYkdWWUFGZHZreFg1R1I5RDNXZDg0?=
 =?utf-8?B?WkdxWTVVTzJUQkJQRWJBTW91Z1o0cjBlMlU1dEg0QlMwdklyUTdIN0srWUdF?=
 =?utf-8?B?Um1JNk4rNzljVW1aeW5sOEtnVURVcWxHNDdyMVBOZFF5WlRheHJuZ0FZc0Vk?=
 =?utf-8?B?S0ZHMDh0amVCRjJUcVV0MlNRcjRuU2h3eGF6cm8rS04xbkdGSUpubnJYeXpN?=
 =?utf-8?B?dVVDTUhIR1JDcVpTcjBOSUN1RW1sMVp5NXJnaWpYQjNwSWZXdnFKOUdyNmIx?=
 =?utf-8?B?Qkx5WFBrZDUvRmhsTURkZTdFRmY3K3NWTU50ekRvNTl4ZnMxZ0pJaXFFMnd6?=
 =?utf-8?B?RE9GZ1RUT0I5SWN6NkdNZ2V1dSt6ViswQTlGRU9qbnY3UjdFZk9Rb3dYdkx3?=
 =?utf-8?B?TjdTOUpSNUtPTTVzaUlxRG92WmI0REI4YzFYcFdQYzM5SUZoYzkxNGRSYlgy?=
 =?utf-8?B?MFpVZjFBQVBrdHhEdzlIeDQ3WDFJcmJiVHR1L0lkTjY5RlJoa2Jhc3BxdVB1?=
 =?utf-8?B?dVMzT2ozRUlUaFZZRkxaU1V2ZkdtZWJ5bEZsL1VtSGNWNHhjTi9YZCtzTGpH?=
 =?utf-8?B?aVZZQ1ZJN0xBc0xoRmJCR1ByOHdYVkliaG5jUnRWRVprZ0h2VjFZVzJBeVBa?=
 =?utf-8?B?ajRNUC9TS2M1RUw5WDZOUUMydTkvcDhkRnZ5Wlh3ZDVkdmNaQzBVQUVuc25N?=
 =?utf-8?B?TnVGelRUZDFJTjZuSnNpZ3FzY3lPR3ZCdXNuSk10YXVPTEkva3RBcWFxeHkx?=
 =?utf-8?B?b3FQOGgvK21JNEpRNDF2MTI2MmplVHlxenVuaHRiOHp2aFcvZ3Vma3lHVjhW?=
 =?utf-8?B?VG83ZGVTQUJZM3NKNk00Ukx5N0FZZ09XbFcyM3FmMmRPWDhJSjBNeWNLYUhC?=
 =?utf-8?B?a3NPbGEyRTZyN2E1aUR5cDBBY0VMb3pzSWZ3YUMvNnArWGU4cHB0ajRBRFJp?=
 =?utf-8?B?UmozSjBaektaZkR2RHVkc1B6YUFBZEpIaHc1bEJ2VWxTb0xJd291VnZGV1NF?=
 =?utf-8?B?QXZ4TjA3bytCZzR6SXRWVXlYb1RVU1kvZENXYTV2Z2VNUmNGeS82dTlBd3pV?=
 =?utf-8?B?cWc3bXg2VVU0aDRWUDB1ZHI2YVc3S2hpWkxOYlhwczh3V0NZbmlIQXVtbWhI?=
 =?utf-8?B?RTB2aTh6eVFLS2NYRUdNRStNVXpyL2g0anZUQkhPUWpwV280L1kwK1dXRE5m?=
 =?utf-8?B?dUVDclB1c1hMdkFTZExEc2VHb3ZTcEVLa2NEVHVCSEZyZUQzOHlwQXpFUlJs?=
 =?utf-8?B?QllibVQva3RGQTkzRkNUNXUzREhGd2pFTHZVUHBpOG5Qajc5WGFUVUM2enhq?=
 =?utf-8?B?Z01zNkF6TVBSZmtESExYT3pXcnBKQUdrQmQ2ZzlFV2tYdzFtcHNxMC9BenFy?=
 =?utf-8?B?SDZtSUFHbG5hS0lPNDdRN28rV1JncStpMm8yM000WUxyTEQwV2ErKzJTeFRj?=
 =?utf-8?B?RlBtYWdNVkxmZlF3dGdyYnJNQW9odUF6V0o0M0c2NlRTcExRTDBLcGJHanlB?=
 =?utf-8?B?YkdNbW93QzRHTFVsK1pmd1JjQ0NSdHdsTStSR2cvZ2tIcTZyUmxuTk5SQUpM?=
 =?utf-8?B?aGVuTDNnN2VUdFZkRXhIMmNQTHRCdTZEaWJxajJxd0NQaEVuRkpwd1lKMG5x?=
 =?utf-8?B?eDI1cWIzTDR3T1dLajNZRTA5NTVMdGZ2bys2U3VEZnFhR3lBcy9wNU1nPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmJoVG8yZG11SzgvUnUyUHNJOTFOQWNROS8rbjBHWDhsNnJRc0NYbUpZTHJE?=
 =?utf-8?B?NElKNGVPajZOakpFbkp2U01PaTNORjFvSVUwMnlSclFxVk9tSVcvZWVnc1lv?=
 =?utf-8?B?Z3ZHZHdXNDBZS3VMeVlFZkFsZjliTmVObldMMDkzN1d3SjRUK0crMjc5cXFW?=
 =?utf-8?B?eFh0bGpvemZManZpN3hEV3dhVDRleE0zRFQrbmZFbmcvQmQyQVhQZ0FlZlJG?=
 =?utf-8?B?MVZDSGQwUmhoMTk2RmI1TUJXQmg4LzJXdVBRd0ZiS1ZycmhQQjVEV25FNmJ4?=
 =?utf-8?B?SnkvSzl1em95eDdjOE42MVdaS1YxcVhRbjVxcnA4NFFuK2lyTWwvcjZoTk9x?=
 =?utf-8?B?V2pDRHNYSmV5YzFvdTZySmJSWFNPWU5jbkc0VzlNRFZackhLZzQzZ1gyVkVE?=
 =?utf-8?B?TWc4M2tXNUFFTEZZcGwzQlYrWGliWFlVNGpPZTNibWlIODdCeUZYQVhHSEhR?=
 =?utf-8?B?RTJBVEJLZk51NTk5YWtOc3pRY3lWM1BoT25KanRJSDRKZ3pVZ2NRVnZicVNS?=
 =?utf-8?B?WktPckdIZXpQbjQxTnRoTU84MkZ0a0NtR3hFNlJmUVVBS2JmbnNOcDNrK0l3?=
 =?utf-8?B?eW9GejNJVnJDaGRBWVE0bDNvR1dKd0FlUVRKZHNXeVZMbnlZU0g5UUczRzFB?=
 =?utf-8?B?VmF2LzQzTW1xc0RRZmZhc0oyK0dNUk9tbkR5c1d3KzFMdm9ma0FRdnZYNFM3?=
 =?utf-8?B?Y2Z0Rk5sclYxWVo0Vmg3NitEcWNtcWs4K0svRStXbXpwNW1BYk54WWpCcU12?=
 =?utf-8?B?WTFoWWVGUm1pRmlHbjJFQlM5eGFVeXJGTVRTVGlSNkVQQXE0a0o1ZjRHeVpj?=
 =?utf-8?B?L3UraHBnZjBZOUlJeTZBNFFaSjZQa3BreXE5ZDNQcGsvMmU1VDNlakhtQlNk?=
 =?utf-8?B?Qy82Rm5KckxvSit1RTVXdUJwcy9zMmtiVVU3OXVXb215bGFxNUZtN2hFejJ2?=
 =?utf-8?B?OUwwdTFpSEJvN3ltdW1jdWdnVHk1dStLNmpzYThLZkJsVnF2MkpVQmJhZmlP?=
 =?utf-8?B?bFpSYmRneWhhQmVBbm54cVBqRnNjNmJLUGxsTWErSzZVWEV6TU1WbXdnTVV5?=
 =?utf-8?B?WDJPYnF6TDR1ZENwT0NzNk9GdDMxYTZsWXAybFl4aEFSaUxvRXI3Q2MvR1BX?=
 =?utf-8?B?a0ZIUkRSRmEvdFNHWm1LNHRwZmRhT2pGRjBLOHpyZ0Y1dW0yQWJaZmlUNXRG?=
 =?utf-8?B?VWFQZFdudXpUMUFuQWovdXZ5blYraVlDSmU4M1NxYVhsRmU1VGVVaU43UFBj?=
 =?utf-8?B?c1dCWDJ4N0NKQUxETHMxdUk0Z05xc1lUdC9GUmVVV0kvK2tZMTl0NjREakFJ?=
 =?utf-8?B?azF2cWNkc3Zxd1R6NkttRHQvT0Z4c0lsbzhUVml1MjgvNnM4ank5RW5qVGtP?=
 =?utf-8?B?WkNmbklidmRoUlpOWHozcE9GUTVDbloveXRYUDVjajcvMVpkbUR1QmVTKy9B?=
 =?utf-8?B?TmZRY2VwTkh0VXF4aGdMNGZlb0JaSWJiRmtYdHlUZGtnTzlRcElFY1VmaGhl?=
 =?utf-8?B?WWIzbGdaalp1UnU5REhpQmFjWWNxTW1TWC9MYlk0Q0lSUlhScHZsQXJTR1Jt?=
 =?utf-8?B?RXphNHdRUTRPVmR1RURhUEphU1o4RjYyQUhsU1lUMVo2dlRCZDBmTnpSaDl3?=
 =?utf-8?B?SjZUSS9zbjArUFZGUW1ib0g5UTEvZzhBQzhNV2RSVndKRzRyd2Q5RjhtWkdU?=
 =?utf-8?B?c1JmZHFwL01MS0ZNV21XRmdJendWWDc5eHlNUGtBd3Z6c09MQXRRcTZYaE4w?=
 =?utf-8?B?cHhrYW12VXA4cDlTVksvdmQ4UnkvelpWMUJxNXBaaHJZRzBiSGRhSVZob2Nx?=
 =?utf-8?B?UzU5V2ZCempRQUZrSjluMWJjZVdleFZIQmd0b3hodjVXOTRFdWhLMHY4ckJw?=
 =?utf-8?B?aXlVcGhzS2ZUeFpQN1JhQ1V1cGJBZTN5NkpaMXJCc29EVkhWcDM4YkVNK1dW?=
 =?utf-8?B?bHR4eVdMajhJVkhpSmJTL0V0RitiaFl1SG1nc2t1SkRnYmw0YVQxV2Y3MVhv?=
 =?utf-8?B?Z01yaEZkNHBmT2p3dmVSNHgyUEpiYTR5ekRRUFVlamVYamV3cU9odlVTQTl1?=
 =?utf-8?B?L245Wm1CcWxPdjcrRlM1NEhPRjZZbHFpSzUzZVNLaGN2Nytnai9UTWFsNVJD?=
 =?utf-8?B?ZXVHSWZJV3FSWk9kanllcWljTkxJTGJJUmtFWEJrZWxJTTllYWRVT2Q0Q2Zt?=
 =?utf-8?B?eWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 98eb34b7-0e9d-4909-06e1-08dc60795531
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 14:02:21.8795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RKWZ8vOBKmWXBJbnB9RwjlItrUYEUud+b6DnuzCvvBjHMBDzPDr8/lqOQtFeWtipl3JfCvf0wXrliUWWN+/EQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6100
X-OriginatorOrg: intel.com



On 4/10/2024 3:22 AM, David Hildenbrand wrote:
> Let's add a fast-path for small folios to all relevant rmap functions.
> Note that only RMAP_LEVEL_PTE applies.
> 
> This is a preparation for tracking the mapcount of large folios in a
> single value.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>

