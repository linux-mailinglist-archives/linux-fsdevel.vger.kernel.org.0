Return-Path: <linux-fsdevel+bounces-16723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE6F8A1DD0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 20:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7186C28B5D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 18:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051345823A;
	Thu, 11 Apr 2024 17:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jPtlbLJq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B993858217;
	Thu, 11 Apr 2024 17:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712856553; cv=fail; b=NobCcxjX6Ly4c5QGgmeOnWE1wuHoBSvb5JkRc6lP/+mAd8k5o6VhB55SDq9R2icxTb896wLaZfIRgoIKlkQJjmpzcYW9+pNuhc3YDK74Rcko/JLGISXtzzXDRnVkQgxXa8pEZ7TKgoBXNAT6rrk5/GVNLtFTJpRd9DTvRCUBj6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712856553; c=relaxed/simple;
	bh=S9++cmKNM/rfK9pr5dA1AGUTHSGzVrAMCzjI17M7qRo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RCNziwYDgBDXHkFPCQpcTx7s+VApU38UQ6UzHtNp0qCFe2Xc9l2N1rZzLafYCrvzS2mub3blfND0fLTRp0jRL4+Z34c5EygFECN0nJF+mtxJhDnR4AHDTU4GK1KRs3dXty1+t0dTjh+2jc8/zJru2eEV6OpE2LZPVMQNTAAQVM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jPtlbLJq; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712856552; x=1744392552;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=S9++cmKNM/rfK9pr5dA1AGUTHSGzVrAMCzjI17M7qRo=;
  b=jPtlbLJqWjmpB0KnmGClYKvFk91oi+TE+Rmmx4ebOTN2JyTs0EbyTjjY
   0uur/mNMgK0UzkoX+JoSDYbIOkY6ivB6WVBzmVIzWvMo4akK6Ksu+y81f
   J2JsS91bVVgcs3CwrHDVVVKXigz9aLW6R8JkjyUmrdaLK9wHJbt1gFL/S
   JxU/L1EuG4dleppMPRQjcUfpmnB4MSPANydziDy05RNlhQMMLPabWTVjY
   7t5KE1a5RT1gh7kUOrLGTrCnqpixqA4UBSzksjx23eHCRYQX7WQKaOvqd
   Ybe693JfnPxjsU26irbM8vrno/Q0F8wuKpYu6vC8QyQp+vojlSD34iXwS
   w==;
X-CSE-ConnectionGUID: YQoV2SXQT5KOsvPhpUKIqg==
X-CSE-MsgGUID: LVGo6vfoTHiO2L0cYhj4qA==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="8506394"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="8506394"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 10:29:11 -0700
X-CSE-ConnectionGUID: 8QFyS1sVR6W3dZhI0DAebA==
X-CSE-MsgGUID: oEmW3R15QZyBwkghcc0HXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="21411876"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Apr 2024 10:29:11 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 10:29:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 10:29:10 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 10:29:10 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 10:29:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdUR+y+IoIqvmgavyE4X9vMC0Y4u5k2S3PCn71CejsHnwJhDDcNtNRstWywJm3DkMCPmR+kans+5pGMEQnfsUseArlTyApgRtUZPkFyXNvC4NpNmqAWAMl8+7M+s+NpTetf9suWRGCprTfkLitesABAliw//6Pq2pbfzBcGBL9VFsFHKzjLdSzEU2hRQ/sSMWwtekfV/Dt9DLFi9kxL3Mjxo1R3jiUYs8AL07Ou0mEbsCvU0IrxQJajquDq3aj3b3McbfgE06OB0SDcBCg8aGdWLtkuKus4U7nOv5qV6sSI/43znm9UooNM9m23qjH+6o++YhTLOI0cofvFRnfboMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDlisLhg/qeB79/wN7QJRy6mLSejkFg73v8CPcA6afM=;
 b=JE7rAwI2CVrwxQKy1/KUwOBB/n/FeZLy2n9Poppp1aiZAZHrkQAOhhCP7mEe1Jpy94FHP1QuXu45KTHeJDz76zsAJZbHZ9mW3sq1JGIgDa/bCKGv2sY3MufTXV3N49cff8++MGw3ZnhzLNYF/FT1MoKPa/whvQk0+g+yJm/9UVT00q63Z2WAbFAEA9f/syJyEp14w+dOvasdMzAMjLczW/96N6YTxhL4VICj8CjM8vC5dMO1aGIA8VPeaItl7MByK/72KhxVvsRHWsW3qf8XyFpZYxqFA6pSEhhcdiVCDksDU8tEd6fhOTO/jr5Zk2+KBhfKEh9lJkUUY5f4ALnFSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB7690.namprd11.prod.outlook.com (2603:10b6:8:e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.21; Thu, 11 Apr
 2024 17:28:59 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7430.045; Thu, 11 Apr 2024
 17:28:59 +0000
Date: Thu, 11 Apr 2024 10:28:56 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alistair Popple <apopple@nvidia.com>, <linux-mm@kvack.org>
CC: <david@fromorbit.com>, <dan.j.williams@intel.com>, <jhubbard@nvidia.com>,
	<rcampbell@nvidia.com>, <willy@infradead.org>, <jgg@nvidia.com>,
	<linux-fsdevel@vger.kernel.org>, <jack@suse.cz>, <djwong@kernel.org>,
	<hch@lst.de>, <david@redhat.com>, <ruansy.fnst@fujitsu.com>,
	<nvdimm@lists.linux.dev>, <linux-xfs@vger.kernel.org>,
	<linux-ext4@vger.kernel.org>, <jglisse@redhat.com>, Alistair Popple
	<apopple@nvidia.com>
Subject: Re: [RFC 00/10] fs/dax: Fix FS DAX page reference counts
Message-ID: <66181dd83f74e_15786294e8@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
X-ClientProxiedBy: MW4PR04CA0204.namprd04.prod.outlook.com
 (2603:10b6:303:86::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: 63bd6b9f-9f8c-4638-ab9b-08dc5a4cdf71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WiRmj26CgOxN5tpZWTlzt4UGLiAkEMhFzNHmLaZ7bIBEashbOLrOEj0iWGkEOhUlerre2QA2epUp1Mi7of/5YMzZokrh0M+zqL5v8iU0hhBVe8I6yKyhGq2OuxnRaAalN7wvEPNw83OzMqDbY3FJc8cWZe7caXP5vZD53cKlZudalfoesnYaEcX8GWnnJNTd9iHFldSwDWGYuMbzveCqq3ntlIlVkUMMoD5DLBEPdAaqQnxxYYdZ0RPq6vYMIZmIAm3VF/tqm0iXa5hBvia1z6kVbgnf/3tgY8yx3FdiK3V+Aw+AygEoZJWmKog2aFgKVrZLFU0B4hHBjfv/OkY/p2uA9H0Q0kHZIT/1eFxxXlV/9GNLc5nmvAZYeY4DA+3uE2MsocrckofzfXgldHxotoPaChtEDcGz0rm5II2SoBwnDNbBj5I+vKYuh4BSGaSNmtYvc/OVNfInOBwSxQBVBwneEjNyDYDy+8CFBSv9BKusXDYt2HixvXJLpgAnDU9VBiCl6UBRLUcnzspJaDOEOxrz6byhL3XoVEooGWx2pBPZlHFyXWmfN2YCBPLUpM0pdkx7QIQcy6HMQzTIhWj934Xhx/blDda7xD6z/xsFI9EAFWuUCqzLb3oRp0i8n5LiAn1/5ZMwV378QexoQSWbRRqUbInXdBxiV2H6T5bGKXE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEx1THEwdlZjeDlLckFqbWVNWngvcWlrTVdtM2dFSnBqU3o0d0RjempMbUxl?=
 =?utf-8?B?c3N2NVpieXgyQnErTzY4SEVLL2p4ZVc5S2pDV0hYdjcxZnRGT3dydXpTVE4y?=
 =?utf-8?B?VjBkMk9hSlJNM1NnMVlacWhkQitiZXgzZHlKVGdmVklhUVIrVEtldnA0RStm?=
 =?utf-8?B?cFRlZmNCN1JENzFRWWZCRHdvckoyL2E5RjNobHVoNVVXNGZ5L2RqN0tlTXYv?=
 =?utf-8?B?QUhyMW9hYTNuUXd2RU5ZYXpRT0lUNVpyanRaWTVGalkraVhrOTgrYiszQW9k?=
 =?utf-8?B?NUIrODRnQlhRVVQ5eW5VRjZoQjlwV1RTRUZwZUhGVUFDZ2NZdVFBZ0hmbkpy?=
 =?utf-8?B?dnhXdHlSa1lJNE56SjJveWIvdDltV0VZZGNkaGNwZndONDJoYUg5Y0QxOGJi?=
 =?utf-8?B?WWVRUTdYbnlmYkw5Wjljclcvdlo0SEttRU5yTTFUcm00Um5XK0xVcFZRTHFr?=
 =?utf-8?B?dEdrdFJERnJUeHkxenBFcGJVR1BpOHdOckhFUW0yS25CNkFKTTR3cDZhYXJw?=
 =?utf-8?B?RFVxdC9URlF0cG02c1lXZzRXMWxMNlE4enpYdkhZTWZKM0Rqc0dyaStsV21r?=
 =?utf-8?B?MnIwam1XSktieENMQzkxT0hKUHhHcXdONFdwTm56MWNJOE05VFoyMU9uQWdn?=
 =?utf-8?B?QUU3MWZwM2hXZVB5c0UwRms4b245MEljcUZUZ2VvamxIRmJITnNjL0c1T0ph?=
 =?utf-8?B?cGkyeE02Q2RqZUVTL0NYQ2V5ZkVyZHpXSWtZbi9aNitYVUR6Q3NZZ1RKSks0?=
 =?utf-8?B?NnZ1UTBOQ24zQy9CNmR1TjAxVlBTc202QzFqbkkwSExVNlBtL1pvd1krR0x3?=
 =?utf-8?B?WStqTUlWencxTG05aW5YOWoyRGJwdTFuOEJCTVdMWmxZTy9lOStQbVhaSlRo?=
 =?utf-8?B?ZHpIN2tXZlVwQkZhSVpMSFZ6M0cyWi9jc0R0NzZ0azFCS1V2Um1NMGxDTWVm?=
 =?utf-8?B?Z2wrSHpWUzRacUdMQjhITnU2czFXY1krTUVWT1BTbzBibktUOXlFL3NXQk1Z?=
 =?utf-8?B?N08zLytDWW10SnBOY0huV1V6a3VpRDlreFloT1AwRzBINnQzcnFaU2c5dGVy?=
 =?utf-8?B?THlyaU5hVy9hb0UxSnV0UW9MK2lvQUNEYm41U0RUZk11cVV4NGdTWXF6QUdZ?=
 =?utf-8?B?ZU5kR25yZG5SZVlnb3dPQnR0OUwwYlNMUm1yYzRQdktrRzJGWHRnK3FDNW50?=
 =?utf-8?B?UVEra0lKQm5ka3N4cTZON05hZXRjdWxIc3hvUENGM1FENzBMLzhHK2ZhTnlU?=
 =?utf-8?B?aW10ek13T2FJVWl6TU1mYzlZUXpKd2o0bTRHOWk0V2dBakc4NkNzaGdrUmlT?=
 =?utf-8?B?UWVWcGxkQ2k3aU9yVHkzQ25jUE1IV2VFd3BwTEF1dTljaTdEVVZONVZGMEVy?=
 =?utf-8?B?bk56a0NWbDNWS1JVbU9Xc3V2eFVwSXZBQUYvL1FOaWlRWldVSDdnR2FnWnI4?=
 =?utf-8?B?Q2NySVM5SnB2REsxZ3NkdE5ybkJXeThHZ21QYzlIVS9obDgrSVUzcUo3YVR6?=
 =?utf-8?B?akovN0JvUTNNTDhaRnIzeDkxdmtUYVRRcm5CTHFwdmNEdlcwL3lFb1R3VWFY?=
 =?utf-8?B?b0hEY3l5dzFyeU9FTjJqclVuNmVDN2llcDFydWpuUVpTdXV6bkJBVzQwQlpk?=
 =?utf-8?B?clFaUFViR1EzL3Myc2VCUFJnYnF1ZWRteTF2MGwyYWRYMnJkMU5qdmJEQnB0?=
 =?utf-8?B?R1kwWGNlOEZzMVFodXY2TVhERkpDT2hLNEpQbFdtVHo5d2tSbnpTSmpkU1NO?=
 =?utf-8?B?Qy9DdWdiNzZTdWs4aDlFTjF2QWQ2eEIxNUhWYXJLNGlDRUpYdXhuOGpGN3VE?=
 =?utf-8?B?QUtVNXorUk5kWDF0U2o1UWVBQ1MyaDZHcG92QnVNZWdpOWFjdFRUNHFXQXdZ?=
 =?utf-8?B?ZlRYdGFTc2g1UXJ1OENSOTNPVXdiRllMUkRENGJVb1FxZEdXSE9mSE5jU1M3?=
 =?utf-8?B?cjZ0Uk9ZeUVWakxrajdJNU1rMTUxcVkzY1R4MWR6VkdOZkdVbms1cmlWOHVV?=
 =?utf-8?B?Z3YxRk12WHkrVXk5TCtaZmo3dUtZRlFrdG9YODNkc2xkTCt5Wm1VNFBHaUZS?=
 =?utf-8?B?b1ZTNlVCcTdEQS9GTHIwU2ZxL0daeXJSY08xWXFqaTZmM1RCbVNydUJkVk85?=
 =?utf-8?B?V1ZRZk80aHplTVBMSlI4aGQyM1BQbHJYREJtRXJvMktjeHpaREZGTW1VVFNY?=
 =?utf-8?B?amc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63bd6b9f-9f8c-4638-ab9b-08dc5a4cdf71
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 17:28:59.4520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dG7IIX+yg/cPcvIVeEK/kPEX2yMZ9aUQ/n0dWG06aAnV6fXNkTRq7OwGG7XbF7D4Gwhc+PtXxZ5869rhtrTc40tUQD2twv+JUgJNFwLdzok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7690
X-OriginatorOrg: intel.com

Alistair Popple wrote:
> FS DAX pages have always maintained their own page reference counts
> without following the normal rules for page reference counting. In
> particular pages are considered free when the refcount hits one rather
> than zero and refcounts are not added when mapping the page.

> Tracking this requires special PTE bits (PTE_DEVMAP) and a secondary
> mechanism for allowing GUP to hold references on the page (see
> get_dev_pagemap). However there doesn't seem to be any reason why FS
> DAX pages need their own reference counting scheme.

This is fair. However, for anyone coming in fresh to this situation
maybe some more "how we get here" history helps. That longer story is
here:

http://lore.kernel.org/all/166579181584.2236710.17813547487183983273.stgit@dwillia2-xfh.jf.intel.com/

> This RFC is an initial attempt at removing the special reference
> counting and instead refcount FS DAX pages the same as normal pages.
> 
> There are still a couple of rough edges - in particular I haven't
> completely removed the devmap PTE bit references from arch specific
> code and there is probably some more cleanup of dev_pagemap reference
> counting that could be done, particular in mm/gup.c. I also haven't
> yet compiled on anything other than x86_64.
> 
> Before continuing further with this clean-up though I would appreciate
> some feedback on the viability of this approach and any issues I may
> have overlooked, as I am not intimately familiar with FS DAX code (or
> for that matter the FS layer in general).
> 
> I have of course run some basic testing which didn't reveal any
> problems.

FWIW I see the following with the ndctl/dax test-suite (double-checked
that vanilla v6.6 passes). I will take a look at the patches, but in the
meantime...

# meson test -C build --suite ndctl:dax
ninja: no work to do.
ninja: Entering directory `/root/git/ndctl/build'
[1/70] Generating version.h with a custom command
 1/13 ndctl:dax / daxdev-errors.sh          OK              14.46s
 2/13 ndctl:dax / multi-dax.sh              OK               2.70s
 3/13 ndctl:dax / sub-section.sh            OK               7.21s
 4/13 ndctl:dax / dax-dev                   OK               0.08s
[5/13] 🌖 ndctl:dax / dax-ext4.sh                            0/600s

...that last test crashed with:

 EXT4-fs (pmem0): mounted filesystem 2adea02a-a791-4714-be40-125afd16634b r/w with ordered
ota mode: none.
 page:ffffea0005f00000 refcount:0 mapcount:0 mapping:ffff8882a8a6be10 index:0x5800 pfn:0x1

 head:ffffea0005f00000 order:9 entire_mapcount:0 nr_pages_mapped:0 pincount:0
 aops:ext4_dax_aops ino:c dentry name:"image"
 flags: 0x4ffff800004040(reserved|head|node=0|zone=4|lastcpupid=0x1ffff)
 page_type: 0xffffffff()
 raw: 004ffff800004040 ffff888202681520 0000000000000000 ffff8882a8a6be10
 raw: 0000000000005800 0000000000000000 00000000ffffffff 0000000000000000
 page dumped because: VM_BUG_ON_FOLIO(((unsigned int) folio_ref_count(folio) + 127u <= 127

 ------------[ cut here ]------------
 kernel BUG at include/linux/mm.h:1419!
 invalid opcode: 0000 [#1] PREEMPT SMP PTI
 CPU: 0 PID: 1415 Comm: dax-pmd Tainted: G           OE    N 6.6.0+ #209
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20230524-3.fc38 05/24/2023
 RIP: 0010:dax_insert_pfn_pmd+0x41c/0x430
 Code: 89 c1 41 b8 01 00 00 00 48 89 ea 4c 89 e6 4c 89 f7 e8 18 8a c7 ff e9 e0 fc ff ff 48
c b3 48 89 c7 e8 a4 53 f7 ff <0f> 0b e8 0d ba a8 00 48 8b 15 86 8a 62 01 e9 89 fc ff ff 90

 RSP: 0000:ffffc90001d57b68 EFLAGS: 00010246
 RAX: 000000000000005c RBX: ffffea0005f00000 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: ffffffffb3749a15 RDI: 00000000ffffffff
 RBP: ffff8882982c07e0 R08: 00000000ffffdfff R09: 0000000000000001
 R10: 00000000ffffdfff R11: ffffffffb3a771c0 R12: 800000017c0008e7
 R13: 8000000000000025 R14: ffff888202a395f8 R15: ffffea0005f00000
 FS:  00007fdaa00e3d80(0000) GS:ffff888477000000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007fda9f800000 CR3: 0000000296224000 CR4: 00000000000006f0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  <TASK>
  ? die+0x32/0x80
  ? do_trap+0xd6/0x100
  ? dax_insert_pfn_pmd+0x41c/0x430
  ? dax_insert_pfn_pmd+0x41c/0x430
  ? do_error_trap+0x81/0x110
  ? dax_insert_pfn_pmd+0x41c/0x430
  ? exc_invalid_op+0x4c/0x60
  ? dax_insert_pfn_pmd+0x41c/0x430
  ? asm_exc_invalid_op+0x16/0x20
  ? dax_insert_pfn_pmd+0x41c/0x430
  ? dax_insert_pfn_pmd+0x41c/0x430
  dax_fault_iter+0x5d0/0x700
  dax_iomap_pmd_fault+0x212/0x450
  ext4_dax_huge_fault+0x1dc/0x470
  __handle_mm_fault+0x808/0x13e0
  handle_mm_fault+0x178/0x3e0
  do_user_addr_fault+0x186/0x830
  exc_page_fault+0x6f/0x1d0
  asm_exc_page_fault+0x22/0x30
 RIP: 0033:0x7fdaa072d009

