Return-Path: <linux-fsdevel+bounces-69979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFBAC8CE43
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 07:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DBD83AD41F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 06:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A50C283FC8;
	Thu, 27 Nov 2025 06:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZozjTLzh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5865256C84
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 06:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764223545; cv=fail; b=NZGOBcXOVKeaz33Am4kljmoqi4Ez6tpDzR5SkBwjkI0CDCC4wnnIib5BAaB8JgsZ5UmZncdCJfYjo9HdaSFk96tbHTPiARpI5T0KWFFsKEWDTshkGr2oiTCxKW4+m7DHpW3gPj0V0KZqGeZNmSeGe2nmX18iTJzERtdiDX82HsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764223545; c=relaxed/simple;
	bh=nePGBlgfNSS1wgieVepmtiPkK+mcIhPEQkJR6KFFkeI=;
	h=Message-ID:Date:From:Subject:To:CC:Content-Type:MIME-Version; b=cH0ADa4UawivclPUbtpISKH3b+F47ktkPpVUy944XAnq0UE6bVO2V5SaVdO1OUWkKKxmTLmm6P6lj1t6GVAr8NkQnQDpTvwG2yfKUTwyjWHVn7dz2CDeMT+wuwPgdRebe1/hyjSKwCJ8F5UUuDvOMe7HvVPceoGMM1tLiO0I8So=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZozjTLzh; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764223544; x=1795759544;
  h=message-id:date:from:subject:to:cc:
   content-transfer-encoding:mime-version;
  bh=nePGBlgfNSS1wgieVepmtiPkK+mcIhPEQkJR6KFFkeI=;
  b=ZozjTLzhssi2QbSvzF+pzSU5bAs/mMIJtU2z9sin0WBBdrjjjBwWWzou
   govYrhVyZA9XWJEsZ1QRC7YZeIC2f91M3t3K+hcfjki+FAoeLkO4qXq1x
   l4ihF4D9DQayRwS2xN5WgE/syi/MRDGBk4H+hI/KZTcaMdmNzsuppl9HX
   xJ163ZIe8XKFwAcJCtaZGDKNqmao4rGoIXeEVM9Zukhoa4EVHI+ecBit5
   a8a6ZGqr4M66vLwRzaLarmsgFW6tFO01UvNko6Og4taqb0q1jkRvt6f11
   e3EhJxTogIjkOw+23RrMbvrugcYsYrMwXDCX3YcxwNufLoks4AOBHuQ8X
   g==;
X-CSE-ConnectionGUID: 4pbEf7QVQRinibsChA7Rrg==
X-CSE-MsgGUID: jE/75s4oTzSzRc1eX58YtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="66299304"
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="66299304"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 22:05:43 -0800
X-CSE-ConnectionGUID: R0nQk25qSOueV7RtQQrH9A==
X-CSE-MsgGUID: 8WWsd2yjTxedIUVR3ms9hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="223849616"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 22:05:43 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 26 Nov 2025 22:05:42 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 26 Nov 2025 22:05:42 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.58) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 26 Nov 2025 22:05:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lt8TYmF6JpICUdu6A/4SF/e8hwhX1FA+FJMuGKLE/xm+y6f/BmntCKUfvzT3EAB03/4aOJpRe2f66bKn9IYRfCiycUwiGPlkcHYnrEg1pSGFM8+UlCP6uPv/DKXvfHUg9UzVYEZ/0Uma5Ah0FgL+vKjyTL5J/DHEgBVEQ71C95ce4ah7zpd/McYAhB2WFohUlaVVmBqGgqVPyDBmB4nt1HBc97w6qD1J9s/+XndtgH6K1TJrHQwjz3N91Rbd+L0aPGDLJwkqWrAl9m3nOSOyGEOb4W+OlCBXH6S3Slv8AHDJDtObdNZi+Fd+G6+tTSD628c0JzneqOAiFkOLPyxjcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7vPn93Hll1jqBVwd1PVaAJooUqLk2RpCv4P2OjOhfA=;
 b=ecczYs8nxn/cIdBFkc5CwIPtKcEahb416QkDbvkvxXHbG8JbUI1cpbHiPGzyQdLBo4t+eg5dBW2fe8PcXCSawyGHM6q85lyOEptX0YLFudNqm7v+WCFRWtC4ZLIivDPu0RwSWcQuSU2YIFJhuYSLVTLTFC3MNvzFmSnrRhpfM3ShhZqFwAEH4+wZIfhOoMerpHgUYl5Gln7Z/BiMV0vVZ8WmMhVZy6qeVX43a0URKUNkAN8BbScp4iTZz+qhKs+w8aYOz4JmzSfdQ+EmHsS3y9eOJF34qNn5QI4cQwsDNgJulZpzhuB8vm1qCNiR62DR3RsIS4zeoJLyrcfEMPtotg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com (2603:10b6:a03:488::12)
 by SA3PR11MB7435.namprd11.prod.outlook.com (2603:10b6:806:305::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Thu, 27 Nov
 2025 06:05:39 +0000
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::21c3:4b36:8cc5:b525]) by SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::21c3:4b36:8cc5:b525%5]) with mapi id 15.20.9366.009; Thu, 27 Nov 2025
 06:05:39 +0000
Message-ID: <a27eb5f4-c4c9-406c-9b53-93f7888db14a@intel.com>
Date: Thu, 27 Nov 2025 11:35:32 +0530
User-Agent: Mozilla Thunderbird
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Subject: REGRESSION on linux-next (next-20251125)
Content-Language: en-GB
To: <brauner@kernel.org>
CC: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Kurmi,
 Suresh Kumar" <suresh.kumar.kurmi@intel.com>, "Saarinen, Jani"
	<jani.saarinen@intel.com>, Lucas De Marchi <lucas.demarchi@intel.com>,
	<linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0025.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:17a::15) To SJ1PR11MB6129.namprd11.prod.outlook.com
 (2603:10b6:a03:488::12)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6129:EE_|SA3PR11MB7435:EE_
X-MS-Office365-Filtering-Correlation-Id: e808ae71-b38c-4786-8b25-08de2d7afd42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0J0cHptQ0NYTlJFYWtZVzFPc1R5SzZNbWNFZHZvQUpMb0s3U080d0tMTzRU?=
 =?utf-8?B?eUNtZDE0T1ZVQU5QTWlZRDRVcXlENHRPcWpXOVg1Wi9uVFFJSW84VmdmS1F6?=
 =?utf-8?B?UnFMbmdtL241UmZid2svT0lJNUQ0QTgxVHFTL2oxb1BORjhLTXJjcmQ3SzF3?=
 =?utf-8?B?Z1pVd29LMm56OFlMcTNSb2QvQlVoY2tQTUpBMGNGOHNTU2xFK29LOUhHeU5B?=
 =?utf-8?B?YjVUVXRvRFAybGN5WUs1SVZXdzUzdko2VFFsbTVnSW5DdXQwOXVsRjBaV3kx?=
 =?utf-8?B?Q3RtMzQwTnNrcU5KV2g3OEt4Z0J2NUNlay9aTU5mbVpEZ3UxbGV5WXRjbEt5?=
 =?utf-8?B?alJrV2Z5dzBBdXFHSHJKZmo3a3o2Ukhqc2NucTh5TTNmQUswY0x6eHhlam9X?=
 =?utf-8?B?UkorcGpOUWVqbW9tVU1CK2JvVkU0OFRoU1dDdHk5cmR3Y0pPYkJNaXhEbWEx?=
 =?utf-8?B?ZllONGQzSlorYXJuakhkbjZaMUdjOENJbjQ5Zlg4SkxDS3QwZ3JxcUIva292?=
 =?utf-8?B?R3hLaVRMTUNKT3BEbnpGZUVlaytLbTBRb1EreWtxdXZ6Mkd6SzFsMFE1b21o?=
 =?utf-8?B?dGpmVVV2UnpsQVJiYk12ZkdIWGoxRXJ4TUNiMno5Nkthc3hYVGhnYXlVbmNY?=
 =?utf-8?B?ZUhTdm5aejBTNjNWWEJUWG1kWnVrSzUySmNPT2kvWkF1VCtMZWJsVFU2SzZE?=
 =?utf-8?B?bWkzZVRHd0w1UVROUkgzZkw2b1VPQVhkY0FVaXlhUU8xd2VGNEVzWFFCeWNw?=
 =?utf-8?B?NHRKRzJQSVd1aWZ1M0luY2NtYXhoQ2g0cUFsVU5GSHpVTWJrY3JkUzNYZk0y?=
 =?utf-8?B?TVZKMlpNRFRONEc3eko2TTkzOC94aTZPTWcxMFRDdVZhbzF6WlRnSEdNa0l0?=
 =?utf-8?B?bEhMRjNQbmJLRGUxOEhYOGFOU05DK2lTaUpQZk9MeEdXL0hKMHRxeU00d0Vv?=
 =?utf-8?B?aHZIbVhvT1NCbmtlanE3ZDBaS3laNDNGWGJrMnpQUFQ2SldDVFBUeCtsdWox?=
 =?utf-8?B?SkJVNjdWVXBjNThxVVVhM2htNDZxazdyY3pzb2pVZnRmQmtUYjhEbXkxQ1Bh?=
 =?utf-8?B?Sm1sdmxHbVZqU3J1SUF2SlJ5WFlrRU1iUlhra3YzQ3lNLzZUNWdtVnRPajQ4?=
 =?utf-8?B?NzZ2eFIydkkxUGs3TVNoWWVwOFYrOVUyMGI1VHErRE9kM2VxYjBJSUk1YVJ4?=
 =?utf-8?B?L3o0Q24xSDFjclYxdS9vUW5HSW1IMTdjZkJFVkNjNkZXajdQNXhxelp1aHRT?=
 =?utf-8?B?MXlGNW1pSVlyL3czN25sR1JEaitrYkt4SGx4T2UzZzRBVlBDWFJmYXJ4cmZU?=
 =?utf-8?B?VzlDSjVadVppN3d4TjJyTFptRWtsL0JDSmNoQUlSaFhXOFlyR3p4NWhvSUNG?=
 =?utf-8?B?UkwzRVdyQlEzSHJqOWxNTVhnc0dCaS9PNVRtVGhGWTJyMU5OendKbDc1WjVl?=
 =?utf-8?B?Vmg1QVpndFFpWVVFSC9BWXdzVUI3OVd6bytMQkFYZHlIc3ViYWhtYldDcGVo?=
 =?utf-8?B?ejBabkx0WERLU3YydTI1bWlBRG41M2xOTVkvVzlMc05Oc2JHeGVxQVd3Znpx?=
 =?utf-8?B?aTNyeit2L3E1d1ZLV2dBSmpPNUNILzBzQ0lRT25iVTYzb2M1ZVJFSnNobHVN?=
 =?utf-8?B?TlV1SnRrRDFSVUlKZStCNzZGZUxxNEVlVHo2QkQxVURVeUlnMVBzajVEQVFP?=
 =?utf-8?B?YWRyR3F3SXcxUnQzRnFxQWhHY01NbkNFbVMrQ0I1SzBzYk53WDlSNVE0RVlh?=
 =?utf-8?B?MG5RVHJTRXQxVzRYaDBHYkV4ZUlneGtwWktYYnJKNDAyOTd0YjcwWTdIS3pS?=
 =?utf-8?B?WTlBU1YzUTlOVVcvTXVOQktGTFEyNHY4VDM4L2Z3bE0zNWZBdU1ib1BaZFpD?=
 =?utf-8?B?SmVNd05BSEgrazBnUlVEVUFJbnR1dEFiYjFQZkpzVWVTSzM1NzZBancxckN0?=
 =?utf-8?B?Njljd2FBQWFpS3M5MUxocWRObTlSbUxzdmw0Rk02N0Z0YlBEc0ZxWUJHRUpo?=
 =?utf-8?B?UHpyMFdFenVRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6129.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlFPcDBNN1pQNitUd0FtWjhyUHJxeVdlRlg5NjJGUjJaQ3M3MTZWejdKNTJq?=
 =?utf-8?B?b01BRWFYVjRQUURRK0VqUlhkNWpGc1REK3lRa09vWHdHc3N6TDMvVjNIVmtP?=
 =?utf-8?B?b1JCbms2QUJvaUlWTGI5MVpUejZvR3o5QzIxSmVnM1RETzJkOVpxTVZ6dm85?=
 =?utf-8?B?ODBmMVR5cm8zSkk5b3NKTGoxb2kyK2w0UitkMTF5Zi8zRWl2VFJQdXpUd1hO?=
 =?utf-8?B?NFJwY1JUN3ZzRVBlOUdyK1JTSEYxYTRkbkQyS3VDcUhFY1F5a2RqL1RQbWUr?=
 =?utf-8?B?U2kxYWpFTHhQekxJM0lSVkZVOFpiOXc3SWZkc1luc2ppcGFzU3YyRm51dzND?=
 =?utf-8?B?M01HTVJ3cHVHS0tzTXlJVmhIcm4yOXpVaEpabkNvMlFNL3hpTVB3Mll5bGt4?=
 =?utf-8?B?bURzSzdEeE10Yy82WW1vUmpMRERuMXRmd2VlUG1xWG9kcVBwTmZPcER4K2M0?=
 =?utf-8?B?VEZOMHZmUXQyRnVmYWRIOWc3RkQyTEVoWGFHYWhobnhoTEVwd041VmZFdm5V?=
 =?utf-8?B?RTFSQU9oL3IzU1NmSHNFM0NpK3MvKzJFTjZqb2pSMWhPQnE0L2VpbXN0MUJT?=
 =?utf-8?B?OUZDQVNGTk4yVVYwQzhLQS9pZWtmc2FHSTZJOEllcDFTN2N5a2Nja1dleVdV?=
 =?utf-8?B?ckVRUkFOTVZTV2FxR3BuQUJnU0czMkM1NTltQXc4M3hXQm1PKzFqRHhEWmM1?=
 =?utf-8?B?NW9xMkVOMkFPQ1pONDJhZmgzUG4vZUY0QUhqS2VYVlZvNDBMbXlPenl0Rm82?=
 =?utf-8?B?N1pHbENiYTJNNk9OcXkwZkdaQnVxK2lQQ1hqN0pNWkttVFp3bk42K1Jxdmdy?=
 =?utf-8?B?anp3MW9FaGh3L29lcjBjS1I2UXZxS3VaN096dWlKSmM0dUd3cDhkYWlyQXEw?=
 =?utf-8?B?a2I0SHRreDl0eHNWSVM2MFhLTWphencvZHJxSnRVSUxLbXc4QU51RWQyOVdR?=
 =?utf-8?B?Yk9HcnFYMzhNVEc5QkF4UUZFQVNxVVdxRmhIOHAzb0lKNWU1ZnJ5T3JlWnpS?=
 =?utf-8?B?a2lsMGQvRzhnZmFpRnhhQ3F6MTNiSW5oMkZvY0Evc0FYU0hQTVZZRmJIVGF5?=
 =?utf-8?B?UHZBWjFsei9DVEF5MVoweFZ6a1EzTFJXZ2tWRkNCQjZnUnM3QUlRbG5mWFlw?=
 =?utf-8?B?cmE4M2RaSFRrVUh1RTZyaHFvUWo3dTM0SUl2ZldjUFJTQ3dhRnh6MlVxNkgv?=
 =?utf-8?B?UzVoNjJCeUQyb1pDdk9teHpOUzNBQ0pBc1owSWE2ZlVLb05yR1FPcHREdjVR?=
 =?utf-8?B?eUtmTXJMOUx1eHNHTm44UXBQZWs0UUxRdkk4ZWZZRlRCV1diL0NoSGZ1WHp5?=
 =?utf-8?B?VW1iamE2N2c1VnNybnNvZHRIeW9JQWJwV0ZEcGhxZDlmdjRXU0RzSnEydnNn?=
 =?utf-8?B?QWcreGg2Sm1sakJ6WEl6WlgyZmV0NklGZ2tyQnd4YU5hNXBCVFBET0tWR05x?=
 =?utf-8?B?bzF0cmJTYllLeUZDWnp2bll0OGl1OHBiL3liZTQwUms0ZWlOQ1JLQ1hJOVJ0?=
 =?utf-8?B?ZElaaFNoeWY4SjdEaVExcU4yUGRndTZpSTFjYkFaS0JlamlQOW1IeVhNZGlS?=
 =?utf-8?B?SGtLdjlXZjZYQVk0OElzSFpqeXVISkQya3Jsd0M5S2pnS0ZWVXlvaWRIVCtF?=
 =?utf-8?B?MWk4ZGVuMVZDZnFPdUhOSytZYUI4UlFoa0pXOWlHSmNPZks1cTBXZFFjbmln?=
 =?utf-8?B?S2JCK2dRa1BTYTBkTndPR1ZTdlFaWVdwaFpObW1ZU05aMTJkNDdjd0o3eWFz?=
 =?utf-8?B?UXhudFVEQmt6TTYrTityTmdPY3RGbjVWRkh6RU5xUysxWGo1MDhEeDJLdWJq?=
 =?utf-8?B?dHdtQ1V2dTUwY1FZQzZCczZhbm4wMm5DK2VWdzkxQkFBcWdkNWg0Ny9CdWth?=
 =?utf-8?B?aW8vZDQrU3Mva296SlExY08vbktqU05iZi9WeVhtUDI4c250RUs1MFVzZ3dG?=
 =?utf-8?B?WEc1WGRuRDdHcUJMZ0F4cENDcWVzZE1jM1JPU1I2a2JROGlqVmw5YktPVFlv?=
 =?utf-8?B?VXh6V0RVUEpNZlp5amVjVEFWcldnZzd4ZHZDN2JBaGFnNHBpNDlaYTRpNlhG?=
 =?utf-8?B?Y3M5OVBmOVVkcWw0MWZZQ2IzK2RnVjd2YzRDZnJTcGd2eUNYL0VycWh2V0V1?=
 =?utf-8?B?YUFqaHFEZEc2bThJelFITkZaaFVwYXlCWDUyR1hrdENBK1ozTC9WejJNL1pG?=
 =?utf-8?Q?kW84EImZqPHOTmZR5VVzBP4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e808ae71-b38c-4786-8b25-08de2d7afd42
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6129.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 06:05:39.4473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6+WDRcDn3kwuNq4wI+DS4v0icP75cRwZQRLE6AXnas+szRm7RsgrGyxJgGcIJSP1Yt4ewPwixMGiHusIuQVs4UE2ZMwOV1OU4aB1wbWjfhM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7435
X-OriginatorOrg: intel.com

Hello Christian,

Hope you are doing well. I am Chaitanya from the linux graphics team in 
Intel.

This mail is regarding a regression we are seeing in our CI runs[1] on
linux-next repository.

Since the version next-20251125 [2], we are seeing the following regression

`````````````````````````````````````````````````````````````````````````````````
(kms_busy:5818) sw_sync-CRITICAL: Test assertion failure function 
sw_sync_timeline_create_fence, file ../lib/sw_sync.c:117:
(kms_busy:5818) sw_sync-CRITICAL: Failed assertion: 
sw_sync_fd_is_valid(fence)
(kms_busy:5818) sw_sync-CRITICAL: Last errno: 2, No such file or directory
(kms_busy:5818) sw_sync-CRITICAL: Created invalid fence
(kms_busy:5818) igt_core-INFO: Stack trace:
(kms_busy:5818) igt_core-INFO:   #0 ../lib/igt_core.c:2075 
__igt_fail_assert()
(kms_busy:5818) igt_core-INFO:   #1 [sw_sync_timeline_create_fence+0x5f]
(kms_busy:5818) igt_core-INFO:   #2 ../tests/intel/kms_busy.c:122 
flip_to_fb()
(kms_busy:5818) igt_core-INFO:   #3 ../tests/intel/kms_busy.c:220 
test_flip()
(kms_busy:5818) igt_core-INFO:   #4 ../tests/intel/kms_busy.c:459 
__igt_unique____real_main411()
(kms_busy:5818) igt_core-INFO:   #5 ../tests/intel/kms_busy.c:411 main()
(kms_busy:5818) igt_core-INFO:   #6 [__libc_init_first+0x8a]
(kms_busy:5818) igt_core-INFO:   #7 [__libc_start_main+0x8b]
(kms_busy:5818) igt_core-INFO:   #8 [_start+0x25]
`````````````````````````````````````````````````````````````````````````````````
Details log can be found in [3].

After bisecting the tree, the following patch [4] seems to be the first 
"bad" commit

`````````````````````````````````````````````````````````````````````````````````````````````````````````
commit 8459303c886151b71e8de08b73e384fd2bb7499c
Author: Christian Brauner brauner@kernel.org
Date:   Sun Nov 23 17:33:55 2025 +0100

     dma: port sw_sync_ioctl_create_fence() to FD_PREPARE()
`````````````````````````````````````````````````````````````````````````````````````````````````````````

We also verified that if we revert the patch the issue is not seen.

Could you please check why the patch causes this regression and provide 
a fix if necessary?

Thank you.

Regards

Chaitanya

[1]
https://intel-gfx-ci.01.org/tree/linux-next/combined-alt.html?
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20251125
[3]
https://intel-gfx-ci.01.org/tree/linux-next/next-20251125/bat-arls-6/igt@kms_busy@basic.html
[4] 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20251125&id=8459303c886151b71e8de08b73e384fd2bb7499c

