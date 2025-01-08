Return-Path: <linux-fsdevel+bounces-38670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A86FA06578
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 20:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF8923A6F1E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 19:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54C7202C56;
	Wed,  8 Jan 2025 19:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UcIFRD2L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABBD1F37A7;
	Wed,  8 Jan 2025 19:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736365074; cv=fail; b=d0y3YpK0OSZ63e/oJNAENlwx4hleFIvNkLFCI7iytA5/2n+VH5VVd61Wch43BPXSkfZYSwpMZDwfMvei6WWbTZKjdIMxzbia34QiTsWibUBhFXVhov+oxTdY6I8DqCU2vlc0/RfWvpo2iiP0l8AIRjclPkYlzOacHwbShcJ2kk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736365074; c=relaxed/simple;
	bh=eVzBOIBNgD1Wk33qIOyPEC6xlWO/z3UGrKtNbTUDoZ8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uH8R0B3Vr4u65yOJFAZHX0o4sFiedeYoJBIg8OzEWdE5F2W0HG+KHT7fO1DnDjCN6fptkF4oKRptXAQwPZ0o/iOCJkj5XeSSiyvYs9klgmQ3yYih5EpT5ERBLBRhztubMfrj6ZJeVWhADmXfU6qvUcztyBI6SuPZOwyUIhJOX1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UcIFRD2L; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736365073; x=1767901073;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eVzBOIBNgD1Wk33qIOyPEC6xlWO/z3UGrKtNbTUDoZ8=;
  b=UcIFRD2LgzrSZbO1OIdnIaaHthhtoxuQybUklI8iJVCjZ5L9jTJ5uvTZ
   5bx5mfG3Gy7S35DIapE/3S9Sltht9Y8PcL3sqF5FCyck2KVXAfacTXwZi
   bvf/KqpYPvZ5Y55YEypJYX1HYsX/TwrNowEilXDAYryG2H4YetIKCjt2W
   Aq3jNzaiKq839xYSLDPd4IyDLRVZnzve038RWZHNXcipS/IXXzze9gJ9r
   xM3f846mbwMCCKYtA/nbYz/Fzf2fNWTGIoaUB/V7Deltv3auXvpLCgBhv
   734M0CQVthjGx4P1oreWW106XSXiRnPRc8elgWPALY7BQn8qub4UgTdcw
   w==;
X-CSE-ConnectionGUID: NxL/A2ZaT0qeUMcCfgKCjw==
X-CSE-MsgGUID: bPElaqZpTkmwYCSz7U6L+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="48019792"
X-IronPort-AV: E=Sophos;i="6.12,299,1728975600"; 
   d="scan'208";a="48019792"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 11:37:52 -0800
X-CSE-ConnectionGUID: o32KDh2NT3y0ThZGJqktHA==
X-CSE-MsgGUID: gRUzV08eQWizrnM3wrO0og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,299,1728975600"; 
   d="scan'208";a="103695793"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2025 11:37:51 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 8 Jan 2025 11:37:50 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 8 Jan 2025 11:37:50 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 8 Jan 2025 11:37:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dOErpwIxpzShsEEJBNjLkoohdgaLPl7qXdcGNI8PsZzAq/1WXgTrfeUkvNbkCF97NPZNYpHr/T0Zx3y9R5NOx0hH/VWH7Y2/X642e+icgV7LeHnNtk+Ps24EJitLOG14Eqc/yYrGgTCCKerPm3gw+23qE97FaID2K/NhaGxt/bxvWrmuwdND4lY8x29YdY7H03kTviANCj0z/Cg3ESH7ANESq34iK/3GQRPJNs4x1b/Jz/XJKLCQN5xH9dMNeahy9HtBZ36UJf9L4G16HNN84ZqENb0nO9uXslbkJPxWiBXVTlNbx1D5yEg0Ml739MDDWjFJ3s6Q7/oAaEAvh+VXig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6+NbZR71dWcJ86FjnhNjJ/j+t5eiAvi2bW0oCC6oFE=;
 b=FPXIjyLO5K5rAcS6i/lNU/2YBoMrUeqNqGJPkG0m1JyTpW+K19QCCasviiqITt4aRaQ/SMszLAWRMt5g8BiUQ7TlygS72o/RvDvr50fmy7lAsDw5wdzPOGyN+cIa4ZzSuQ4XdSpd73PqCXJXtfqEnkN1DbcS43Vv1Pob96DbzuK1+LjnWihHOx7PbZeynBoBHk1/5ofPJAZUUqhHUvRBlh8Zh6QIpidba8gWwPeLbNmw/Vek2spaww/s5nujyChpTWtUDSkh89bbmxR/4e5qEaxW2dNavA2MJ60ZjVHsW2iByRakIIBLkPojB3+VXT87nWxvRCHG/1vsLoinPUXDJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6464.namprd11.prod.outlook.com (2603:10b6:930:30::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Wed, 8 Jan
 2025 19:36:58 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8314.015; Wed, 8 Jan 2025
 19:36:58 +0000
Date: Wed, 8 Jan 2025 11:36:52 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alistair Popple <apopple@nvidia.com>, <akpm@linux-foundation.org>,
	<linux-mm@kvack.org>
CC: Alistair Popple <apopple@nvidia.com>, <gerald.schaefer@linux.ibm.com>,
	<dan.j.williams@intel.com>, <jgg@ziepe.ca>, <willy@infradead.org>,
	<david@redhat.com>, <linux-kernel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
	<linux-xfs@vger.kernel.org>, <jhubbard@nvidia.com>, <hch@lst.de>
Subject: Re: [RFC 0/4] mm: Remove pfn_t type
Message-ID: <677ed3d45b9a3_2aff429479@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.a7cdeffaaa366a10c65e2e7544285059cc5d55a4.1736299058.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.a7cdeffaaa366a10c65e2e7544285059cc5d55a4.1736299058.git-series.apopple@nvidia.com>
X-ClientProxiedBy: MW4P221CA0008.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6464:EE_
X-MS-Office365-Filtering-Correlation-Id: c1ac1479-aff8-42f6-ff7c-08dd301bd100
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IEWEoaM+F/TC3jpdd76vshif834WkHvRQ+H25eFeTFcwn5y0DaxGHsb0hQW3?=
 =?us-ascii?Q?iN9aMpFl4E1PFT8rCkXFRdvzaat2bIFZI5SB8/hH0rVVEv61/ANh16wWGGQh?=
 =?us-ascii?Q?4FKbBRsrsNW/RiFuI58jgLo/5zVATf2Yptdi644xOMse5mWzPJa+YoJX3Q3L?=
 =?us-ascii?Q?R3vA3RUn/9DxnsXoYwfp42lrLJYnsthkX8YjRgxIi3pH1hy2gdnhtX9DKNRF?=
 =?us-ascii?Q?9VRwh4zdByq+rqbd9sZpEH8MSuXbhuYLYXbncBmjTiHNnSZH/DWmKR20pk/R?=
 =?us-ascii?Q?0g6rLzw0e3bJJCg1p5tvsgTpRTNnCzAlBSr2dqp5MJOVndJAkwqoGgPFGYuB?=
 =?us-ascii?Q?OAT16Xs/DmhisQcvELID6mT4cYpGkvsZ5WAh8joRYwgPMAjk6UMmzIjBm/di?=
 =?us-ascii?Q?UUc6fUYMGChUvW5bXFkSW/uW8OQU0lKw0ziwuDFRx5I000M2cC+TZSfEVFp+?=
 =?us-ascii?Q?/2GarFqaeINR5i13CNxHBJrYYInVN+7k9X8nWM4xZ+1BzZPDXzpYLsi+kXbU?=
 =?us-ascii?Q?wovDCMTLlpHp5j58FIZT2MDJjg6j0JJg2ht5diF3l6nty6y8nv0/7ZZYxsN/?=
 =?us-ascii?Q?X54XIOlEFHQcUgFrgL17ZdPUqfq7Grzx55YOmalJM94tp0gTtSQMcV7pcwQY?=
 =?us-ascii?Q?aEKVj3LETbxXloPmaWrQYmbOuy7X0EeZ6vZ0jypWx3p0ET0agathseKyE8oc?=
 =?us-ascii?Q?jNJb0GiB/kqKq8oOYJfYKj1SSKJpnrn+P06B2oIaN56nRlzRgQXa3hesBoz8?=
 =?us-ascii?Q?hu0uEa906i+nrALbEFvFundf/zWztqoVHO0NmHeMSTV7V015cPncDTLdfS+P?=
 =?us-ascii?Q?0x4KR7gj4eHRuYM6GXqFAMj0un+nkBkWNj3znxGWRlmU2m9u/3siEXHiQPM5?=
 =?us-ascii?Q?aJ3818fYUd9MppONNA4SQmi9AJtzSKgUnF77EULHKlfCn78OjOaEvyEe2Dqv?=
 =?us-ascii?Q?g77ZxAuVGUzqnC7gze5A0y/RaNzNwXxvfQu3EAwZ0X3RrKI6aFR98cPWPO/I?=
 =?us-ascii?Q?FopW9duYw9Oge7z4AjaZwYFqse7Z/Jvh1zSKF/tc66joxiEK/Pbq/vUJ0caL?=
 =?us-ascii?Q?zGultjnudOH98Qjj2AdzubxOLsH6u/RQchqwPGK3OP8FiZRVn71YuSjDPCMj?=
 =?us-ascii?Q?9IGe5AbsjqXne+69L9ZnqISmENq7Sk7/x0p5qXQLhONr0QJ1JRxpmMb7tolG?=
 =?us-ascii?Q?9l/mqwiXOrABJcPJ5Lu93HI9em8qITkpSr0df2hudzXUQg6JUz98Ajp/8rew?=
 =?us-ascii?Q?Zk4POJcT70w/asLMOBKY/8Ti9xYTZncMSBVPJdfBfSW0JoKhJQb7Guc4a7d9?=
 =?us-ascii?Q?/2T6zNaBDQjesds5SUmBceUtKB+otiASQhLxd1oLkOK+9N5JYKzSy/2KEfa2?=
 =?us-ascii?Q?beQEDapuQoa6SP8JeSPFhsgBGSRKTadi6hDesvMkTueyPFJxhw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bitV8N9i0c7Sy4nik5eiVXGN1zuXTsS/3es+ZYImbhVXISj2zDp3lmwOMSQj?=
 =?us-ascii?Q?ZZKCpJKIqFF4OHZLEaH2IJO29tDaR2/vlElHDd/sHAy58vsZ4CTEStDFMMjS?=
 =?us-ascii?Q?JwCPtd74tkXRWoodKjRrJuPcm5rrryTkFiEzg+D9eRz5Q8s2hEE6mZ+ZC0K7?=
 =?us-ascii?Q?MCFFMhpSgV/UxeycEwiXAMaR0GSmOO7H8J7b7B2sY7YjlbinQuKcLuyr7dLI?=
 =?us-ascii?Q?DPN9H4F0EZRebCrFYswHptXFXcrwMHsTMbyDE6zFVnCPcF7wA/h3sAgvdiQ8?=
 =?us-ascii?Q?EosxMSWZ59eMMLYMtNTBTOx9X/ejtSdhizk8fh4G+0HGZaaDY68luyBGOdaw?=
 =?us-ascii?Q?VqFVHjOlxJ4Z0lWL7FbHX0FOgFGvGKb6egYMHBlW8/jxAIgwp1+ID4FeRD6u?=
 =?us-ascii?Q?B/EgKQ6Xa/61pT/jkx2OmxDOU3NWCENEyGDc21xO4kIIzS9AlmGTz0nfHE85?=
 =?us-ascii?Q?wHvWZqSMNe70rCzZ62ErOAAgitHpVo7Y2C22LOKagcMKXOFnk9luPFRMG3on?=
 =?us-ascii?Q?xnEh1y757lPxLuCIY+pZhr51VG/NCkG51gV52t/LO/wBIplwkAfcS2+Coam5?=
 =?us-ascii?Q?uUO7aErfnn2DAlMqLbGi1fKzlx/G+JZnAACIu9dIxLO3jI60eOo4K454/KqP?=
 =?us-ascii?Q?C9ui5NaDfgnCBpVc6t6RTK+SNgMMxIJo1YkWB2blAph3LfCX3YIiSWGSq9zd?=
 =?us-ascii?Q?Z12Ae77u7iZJYI9ObWqXZDe1r6PyKvMXVtVmj+Cqz8/pb1eEOf1jAHzXeeOg?=
 =?us-ascii?Q?INod2Mzy2f2cZOoYsdNpI9dFBGKVEAUnmaL27++JXgw2ss6PVXXasZdWGlpo?=
 =?us-ascii?Q?eiTfIJcosOsEOXqJ672RazgMJq0FajjQI6+Xw+6WGUV2gc8P2RsuU7gKfFe5?=
 =?us-ascii?Q?UDgHLCHBEWVAoWf/8CBO0KJf+IbOBnco5dAaeaojCdGbxCIQGRziKS75r/M6?=
 =?us-ascii?Q?NPgIX1x7sz6tlN6KZu0A+u1XuaydeLAX2lqdboM+scKAQZIjiwlOCh3yyMHH?=
 =?us-ascii?Q?QYoSBwvztltaXEgfLK5dqosYjxQah9CFbnWyvVpx8jJ94rhCkWhjCup+34Cw?=
 =?us-ascii?Q?2vjdGeYH0+tvEyQykBWJO+rYIxaz/VHfpEYJ98yvaALKHodNZ+SKIElNMsmo?=
 =?us-ascii?Q?x1hyCSOYfLx3H1ZP30yRQlRsCapXVcEBoIieoISj/mF79KyzldYL2A2IB1KK?=
 =?us-ascii?Q?9RN68vpXl5wqvP/Km7DTxg05r4ClaalN1AJBDYPk9aRVbIFy4I1g6CgcwDG8?=
 =?us-ascii?Q?4HXy0yVQivRwN1b5B9lHjlbQvjKpwGBVsRmrGhGt7j1EFOKiaGyKf40RLI4e?=
 =?us-ascii?Q?6HbRCQNgtAvawxUogKdicLbUq2h86oWYDTd93y+fNRPazWcvsV3HusmkvPWa?=
 =?us-ascii?Q?Yz1mJspfr8UbZtTsj+fMCsw2B1AMICX9q/DmqD9Ja0Co07N79VERW3MT3UXI?=
 =?us-ascii?Q?a9HonTsecdYLI0xUuSr3W25RlElcKHS7YZ3PkdzG/88RZehHsgT9LG6l1V3P?=
 =?us-ascii?Q?eSOzFa9NZ1PT5j0YYzj4vvRc3ZdT+N4t1SKz4BVwWNRAFM1n+hrmi4uCDWQa?=
 =?us-ascii?Q?pBg5J2IFWCFmwSXoKrFmpBzSvOdLzB2VgapxdUsd7Zkaqb79NBoHbjrNdb2b?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ac1479-aff8-42f6-ff7c-08dd301bd100
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 19:36:58.6904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JzBK1VVXd82R9zasZOuHdtpIJ42lXhtAF7qOlwDpeYtoV9NkjotXAXE2bGyOyy7dJarjVxqhuvkApJhBrFVhqyjG/2KGUgSXm1L0jKZG7Kk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6464
X-OriginatorOrg: intel.com

Alistair Popple wrote:
> Once my series[1] and Dan's cleanup[2] is merged all users of DAX will
> require a ZONE_DEVICE page which is properly refcounted.  This means there
> is no longer any need for the PFN_DEV and PFN_MAP flags. Furthermore the
> PFN_SG_CHAIN and PFN_SG_LAST flags never appear to have been used. It is
> therefore possible to remove the pfn_t type and replace any usage with raw
> pfns.
> 
> The remaining users of PFN_DEV have simply passed this to
> vmf_insert_mixed(), however once my series is merged vmf_insert_mixed()
> doesn't need these flags anyway so those users can be trivially converted
> to using raw pfns.
> 
> Note that this RFC has only been lightly build tested. Also the third patch
> probably needs further splitting up. I have pushed a tree with this, along
> with the prerequisite series, to
> https://github.com/apopple/linux/tree/pfn_t_cleanup
> 
> [1] - https://lore.kernel.org/linux-mm/cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com/
> [2] - https://lore.kernel.org/linux-mm/172721874675.497781.3277495908107141898.stgit@dwillia2-xfh.jf.intel.com/

For the series you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>


However, I expect that we need [2] at the top of your ZONE_DEVICE
series, because that conversion breaks FS_DAX_LIMITED. I see Andrew is
starting to pick this up so I'll go work that out with him.

