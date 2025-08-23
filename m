Return-Path: <linux-fsdevel+bounces-58869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE4EB32618
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Aug 2025 03:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 703801D25774
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Aug 2025 01:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2409E13C695;
	Sat, 23 Aug 2025 01:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V6scX2Yu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF83A23B0
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 Aug 2025 01:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755911023; cv=fail; b=fCdbiGHZd8Rd/EfgTfgT/55nFFBe3KiUw74BHGPMbANvPACe3mUcZgxZEmii5Wq2LJx/Au5t4iJ+nJ21F710qK+AmsjdI6OU2zjOaD8Q5bNRs1p5r5GPDRqcNZt12/W82nswx1gnt14Hm2V03HCX/1zp3SyCeZNgP2kLJ+/DQio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755911023; c=relaxed/simple;
	bh=uCpQmWaDWyZuXBpnZOPSCkG6d8aGZwtqisZwmCtYYHs=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=NkQ8DikMHtPJYG29AwFX80CeM4zffELx3nUHVa/c/L3F+L+ytwCMJbH//FIK1COskfW7MoSvRrQ8LxWuOJOb4atpACOrXgnKTZwmvwQ6CHBFAHfEB36s/UlFOZ0zq7vunyCuSoOIY/rWYwYDP3K4zxdzFB0p9uR5sF+OFlpWTl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V6scX2Yu; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755911022; x=1787447022;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=uCpQmWaDWyZuXBpnZOPSCkG6d8aGZwtqisZwmCtYYHs=;
  b=V6scX2Yu5y2mFkcZZPp4Sxm734/4oBZeq78Nc1naWz8vLX6B5gAbQi2Q
   ZP7sgzvMapXTTrSzGxAVl7JKpQRsBYjDK/4Qb3uOE1EN4UAhKGdpXfLYP
   4erOls7Dyp1FmBLnninc08qE3KndUA++Mu1d9W58LVnV5H6t06gEJrVCs
   punnsaVfIoaUzqNhRT/i0l8vM8b4EbifP6+Pmb0g1KBFT1tdXsU8tm4ld
   jAENObiWV7EHN6KMA6fRfoVugH3UooHy3PMcafLN+nxAV+loUXhgD7VrN
   DoP0C24eEyqst9bxpSY8rtcBzFZtfFsuZdPD0/j9F9R84xvs9+/0XXgFb
   A==;
X-CSE-ConnectionGUID: nyp30tEKRu+QtjVJN8uoqw==
X-CSE-MsgGUID: eOckHvBDR3+M5pLj6s+3hQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="58170954"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58170954"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 18:03:41 -0700
X-CSE-ConnectionGUID: TvyCb1qbSJWEi38K5wo1PA==
X-CSE-MsgGUID: VCKbrhGxRU+MDQ2n4tB6IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="199792176"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 18:03:42 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 22 Aug 2025 18:03:40 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 22 Aug 2025 18:03:40 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.66) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 22 Aug 2025 18:03:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BdPG9a7SEgHfYzeYaRokivRyaCmt55BS6HKDf4vCzwHmq8R72ze5+ZS6ay0WOcjhFoId4UhN21bRwb8Qc2iwAo0SWeLZws5HSfvEZOg4t1LS3Na/R9fF1cofqx58KmqY08rZZIx57Rx0+K6KATuhHn72DWnASxggT1Vt+D7cbhBm7nvkT7t5rSK2eFkyIYPDJoENMmWDm7H+IpLzEIauImtnR9ZVrz6WtzdcwhExxaFt2mxJp4dY6A1zsZ4MpludrJ2MBm+lhRL9M7wSt/euSR7XvmzqeWVkg6aqVuI1yuyaKzzCE7VFBgl2t5rVe8K9oqw7t2mlmiPIhBEJ9JPKpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GCx/Vjo7Q19QQz73uPmZ0S7LhRKzAKQpswoWaOsbnQ=;
 b=FU8ml0zMcCV1WswNxgFvLKXyf4l3tYSxMyNf6XG27sfEX8+5DFiLAiKqY/fYJf6o6b5TW3cnIrV58hZnzM9QPjBmDI5efJRs7a0d2ibSukgw+WXfb1eLVAKUU1a7P67oK+Qw5/QxIiOam0r3BmRLYyh7dJIf3G7QANTQaXvNvXGIjmcYf7o69clafdiGzDtgoSCg4F1rOM8ix+uFnCRi4sU3J3xCv1FUcGOUI6ukqVByekQdTQW1JHxrpR48+4uxvpe7goHoNnox/V2mZ0vLxbllmCeKrINGntZLtBhVrYH+HM53G+fBKCRBAAWgmK7sWEp0D6gWuDlPErTM/cJKUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Sat, 23 Aug
 2025 01:03:32 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9052.017; Sat, 23 Aug 2025
 01:03:32 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 22 Aug 2025 18:03:30 -0700
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
	<ksummit@lists.linux.dev>
CC: <linux-fsdevel@vger.kernel.org>
Message-ID: <68a913629af3b_75e310032@dwillia2-mobl4.notmuch>
In-Reply-To: <fc0994de40776609928e8e438355a24a54f1ad10.camel@HansenPartnership.com>
References: <fc0994de40776609928e8e438355a24a54f1ad10.camel@HansenPartnership.com>
Subject: Re: [MAINTAINER SUMMIT] Adding more formality around feature
 inclusion and ejection
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0050.namprd11.prod.outlook.com
 (2603:10b6:a03:80::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d1f8005-1ce5-4a7f-9eb1-08dde1e0e0e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NlRJRWJyRzdNU29JZUcweXY3dFF0OUJmemt0cFFRVjlRbHlIeDRjbHlTZjg0?=
 =?utf-8?B?Rlk3ZXFocWJwd2xEQnRvbHpTWVd3azZhaWl4RTJaRTVaaVJ1dGRwRDhqM01s?=
 =?utf-8?B?ZWZGTG9sYytjZ0pEZEJVNnhvYi85Mk9PVVhIeTg2elBDZndwMVlYS05DdlhG?=
 =?utf-8?B?bGI1WCtGZVh4VUl2S3JzZFJTZ3dxRjlHejcxanBRTVVmcHZHcWNwc3JDR1ZZ?=
 =?utf-8?B?NkZ0SmVPVTU5UGNnUE9jdXdmWUlwSGw4SDdPQjVUdjEzZzJ6czRjd2pQanht?=
 =?utf-8?B?UFg5VlZxMElhS053UVdpMVhKSnl4NUl6MDlvYlhsdHo4OWFGdHhhb1lxQzhL?=
 =?utf-8?B?QmpZaVM5MWIzd0lRdllXUURZaVJEZUQvSHQxRTdPbEdUZW9Ca3p3TUdDVFM0?=
 =?utf-8?B?WjBmKzNvWjlNa0pZV1RGeDN3enlacnpkVzlidEFsZjRYeGtGSXhSOWNGTU9K?=
 =?utf-8?B?dERWa09YaGJGZjZ4bjFTb0FPZVNDbmsxMGlSdGIrbm1zWDJ1S0VQNmZJOUFp?=
 =?utf-8?B?bitRV3VPN25jQzRiU3BobDFSL2NPM1pnM3ZpMWEzYzhTbjREWFpwRzRlT2xW?=
 =?utf-8?B?MExrZS9iYmNwU24vSEJkQXppVVVjaGdLaUN4L0Jud0trb2Z6ZnF0akt5dVFM?=
 =?utf-8?B?SGtqMzZHRzIyM3JlckJFVXRsSUdXd1orZ2hXemJObnFlaW1sN3hHeHl4c25J?=
 =?utf-8?B?dVppZUsyLy9VYmczcnRQaUdnbUlteHQ4RHdUNVdKcnZKWnpLTTdIYmg3RnJB?=
 =?utf-8?B?TWFwRzJFeVFhUmtkTHJYUkYrQkM0REdlRkFzNHZ5R3JiRDlvUndmd0VCNWxI?=
 =?utf-8?B?QUluYU9TNGNHSzd0bHBCQUl4dCt6dFBwMklmanhXanM5VHZnYTJRUFA3WFNN?=
 =?utf-8?B?RCtFYmxPcm5lVEkxRTJCTHptL2RkSzNVaWd0OHI1V09mMUFXaWtaWDdmNW5C?=
 =?utf-8?B?MVZMVzdRK0d3VW5UcDNiRnRHOHdFcEhkOHVDbDcwRmJUOVB5cFZ2Si8wOUpN?=
 =?utf-8?B?bXprc2RsaTB2TGVlZ2NJd0Nsbk5OSUlSSnVjdXM5NW5ON1ZhQ3RSWnpIeVJC?=
 =?utf-8?B?ekEyY0tVTnZVSXpKWEdRcGZZVDlrcUlRMTh2dnNBVEFuK0dmKzgvTFdKODNs?=
 =?utf-8?B?THRwMHFVcStSNzh5VXFLQVVrVGIxenRySjBmSHlmNjc3eEZUSUE3U2lTaHlx?=
 =?utf-8?B?bVdmS0Z6MEdWWW5XM3o2ekVBeXUvSllnQkFrN0RZMldnTURocnlLSDdvcU01?=
 =?utf-8?B?NEk1ZEp3STRpSkgzQnYvc3B1OStmUEJRWDFsaWpWT2pLMWpIcGRHRjFiQ0ZP?=
 =?utf-8?B?ZlpCL201SEI0QWExUVI2bWl0TEhrVUhIZ0lURk9pRmtscVZ4cmk3QmEyaCtx?=
 =?utf-8?B?RHBJUDNIR1k4Vkd2R1BxY2gvZHVFU2VlMnBFZEplNWRJNGFpcFI1aXF2Vkt1?=
 =?utf-8?B?eUpycWJBRWk4dC9ROVp5TmVJcDlJbVFqY3UxOXhuTTlHYmhRai8vQ21sRnQv?=
 =?utf-8?B?YTFkYkxHS0pOc0dQMHlvRzFhRWJRZXU5aGNCbVEwNlFhUjQ1VTAzeW9RUVo5?=
 =?utf-8?B?SCt3RWZmYlpoY2JjMzVsNUZza21BUWpJYnpJVG1ETmMzUERQd1hYc1BXNDRl?=
 =?utf-8?B?Y0V0M3dBd0d2RzJHUHdxeFVHWnhXWXN5RmJWenhKcEIrUks3U3dSUTdtTDlx?=
 =?utf-8?B?Rkg2MmlZYTBaN2UxQUVoUGRqYjVXcHJQaExMTkZ4eit5OUN1NUgyZ3orNEpv?=
 =?utf-8?B?eWRQNUNOWllROFZ3cEtvcnVyb2JhL091cTZIRTgwVVExZHBRdEFybnNNTXBW?=
 =?utf-8?Q?gKGB2XGMhFCEQ7GASzC4eBBpU7j5pGvTvVz04=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnhMZHB1dHdobktQUTRoSSs2Z2Q1RjE1dTZvd3dSN3kyb0wvbnNuSzUwWXNZ?=
 =?utf-8?B?V09OYmJzcVZUNWpqRFI3SUtxRnNjZm9mY2Ezd3crczl2NHNsbzBMZE9sQUlN?=
 =?utf-8?B?RDRNakNPUlBXY05CbTdPbWFVdVpKaEU2SGwwdzRORU9CRFQ0S2dHZjdQYkpJ?=
 =?utf-8?B?djRYc1JJNmNON1NsSlVOdTFjcDIrZld3cFZJMzVnZHduRklnTlUwbTFhS3ph?=
 =?utf-8?B?L2FjNnN3aTZNMi9ORjE0U0w0Rmp0L0dFUlRoWUVHVEloTCttQzJkYnFYLzJU?=
 =?utf-8?B?OXJ6SDk3OFhaRElZclFVSW5kRjBnNVpZM2VTeHhQb3BUV2NwVEk5MVJkNUpj?=
 =?utf-8?B?ZHFmVmhiMUs5TlJsR2cweXJhbWRBekhXZnRQWk9oTmtmOEZQdWphTVNHUXV5?=
 =?utf-8?B?OUpTZTAwTzJ0V0I2R1ZoMm01OFZMb3Bqc3dycU9rcGVVVklTa0hTNmpsanpq?=
 =?utf-8?B?eFE3MDd5MTBhenRaOTh0V1RrSE9pZjBvVHNKQ3lxTWh2MGFvd0dHbUZaRDFK?=
 =?utf-8?B?dHJhUjBTVDQzbEtFQUQrWVk2Ull5L3hvU1AxcTlHSFVTd3JlemNDdzg1aXhL?=
 =?utf-8?B?U2R3dmVpZHVOZ0lYWUVpQ3B6K2laOVkzRjJJbkQxM2FwaTJKV0xxOXUxd1ZP?=
 =?utf-8?B?TUFVbFJLVWg4T0lMODlFUUVSL1NabWhDRlVkSk9HSFgvaTVPU29MRlhQSmIz?=
 =?utf-8?B?MjdkYUFaMlkvTDYxeE9hV2V3QkVWSGJVTFVxOW11UkM0WGpJUUJkM1VDY0Vi?=
 =?utf-8?B?MjM5T05Kd0lPUVIxeE9wMUZSdlBHZlMvczZKR21LRUJVKzNWWVhRdUR4MG9X?=
 =?utf-8?B?WkRqaXlJYnViZk9wcDR6dFZwYTZNa2plQWI0aDFsbHhIaU9zSlZGOS8raHdp?=
 =?utf-8?B?eFZ2cGVUN3VmcmFhS1E5YkVUOUVuRnZ2YXduM2l2NlB5cmptaUFQMmNoZEJR?=
 =?utf-8?B?bjRxVGpPc29sYkRyakQxcE1ib041Z2FOZzlkSjIxRyt4NE13SnpDU3F0VW5K?=
 =?utf-8?B?WG1zWitjbWJVZURhUFZWa05BaStCWXEyRnM0RzJPV2pESEpKcC9OZHZYam1J?=
 =?utf-8?B?WW5iK2N3NDk5T1hYRkJUYyt5ZStjVTd2dXdXQm1SLzNETVc1K0ZRYmdOcjB0?=
 =?utf-8?B?WituZ2dESUFnVTVhdXl5cG5PSXlmWVVKdktWMUtoWWwrOXo4ZXR3TWd3TmlW?=
 =?utf-8?B?b2Y1emNFMkZGYzBwd20vYlJjMjgyWVdUMW9YSTlnZVd5ZGpka0wzeTdnNW9j?=
 =?utf-8?B?ZmhHdUZnMlk4SEIvOXBsaTFoU1ZYUG94bUdTWFBjWm15QVUweGlNZ3ZoOFVB?=
 =?utf-8?B?QXJHamlrZGduQWxXaG43MVZacEZWQVIvTTdMUlNabWVYekNDQVNnSDhNVEZ2?=
 =?utf-8?B?c2FHbDRoUzZDOFV4U1JweWdJM3VNZm43bUxJdnpPWitEVnlqQUU4MkM1VFEw?=
 =?utf-8?B?VVRwZ2tKcGhaSHNGZHZaMDdEMnNnWkYwWUtqcWs4cUJHMSs4SFlsOGJpZ0tQ?=
 =?utf-8?B?UzNzZVRmUjBrdUdBdnlPbnVUd0lTa2tra09CMkJWcjJmWW5ZNXpEcHpZNkhv?=
 =?utf-8?B?N2VWZVBXZm1nTzluaFNqYUNSK0lZeTNSZnV4RXZ5Vk1pdkZvb09BUFR6MWR2?=
 =?utf-8?B?R0VwZmQ0bnVUSDVreWdlcVVwbDR4OFBSR0xCeGwyVWR2S0RmZVRaa2dqMkJl?=
 =?utf-8?B?aGxyc3Z2ejBKSkJQYStyV2NvRTRyV0NTYzM3aE5IYWJhd2xaMEliQmh0MjdN?=
 =?utf-8?B?bUpWRUU2aG5NdFdxSkFkWGxGeTNzenhSVnpEZ1hxOVNzdDV2Q3p2czFMWFZI?=
 =?utf-8?B?bnVpZmE4cmswc3U1SnM4UkY4MXpDN09BL1ZrRWFCb3NYSUJGMS91eHFQVDRP?=
 =?utf-8?B?bnB0WCtrMEtpOGlXaEthbXVMTzRRQVZmci93MG5WdTdsOWZrU1NldWQ5SWRh?=
 =?utf-8?B?a0crZGwrbkd2VTdZZmNDalp4aEZpYlRPRDhEM1pYZFFVTkRsUlFnRnBsMW1i?=
 =?utf-8?B?Q1ZsYlBsMUFib2ZOeitEc1UzdUpwZytQcmhGSVhMV2xSaG9jSVlPV0NpWENY?=
 =?utf-8?B?MGR6WUR6cjc1VXFEcHNub2ViTnhhMVo3ZWpDeWFXb3hKNnRsQjZ5cGVBVXlI?=
 =?utf-8?B?ZWlKMk1OdUd6NnRieHNxd0pWVUd4alJjVDNLSExsTzdjMElENytxTkZpdmVX?=
 =?utf-8?B?Q1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1f8005-1ce5-4a7f-9eb1-08dde1e0e0e7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 01:03:32.0859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PHlIepDKrZBwlz8SxADmCMNsPhQjFQP2I5FirhNvA191NGF1cjGoJdqqjmHhjg6BXMbTxrZ7fQ1ZMPW4iXe0mfwjaeVqmbbg/Rg4olAZ5C8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7573
X-OriginatorOrg: intel.com

James Bottomley wrote:
> I think the only point of agreement on this topic will be that how
> bcachefs was handled wasn't correct at many levels.  I think this shows
> we need more formality around feature inclusion, including a possible
> probationary period and even things like mentorship and we definitely
> need a formal process that extends beyond Linus for deciding we can no
> longer work with someone any more.

A different perspective, the informal, albeit messy, process eventually
arrived at an outcome that does put project health first. There is a
risk here of over-indexing on a proactive formal process for what is an
infrequent, latent, and emergent problem. Look, sometimes it is not
clear that an individual will continually fail to respect personal and
community boundaries until they repeatedly fail to respect personal and
community boundaries.

The change I hope that comes from this is indeed more maturity and
courage around boundary setting. It reinforces a lesson it took me a
while to learn in my career: technical correctness and brilliant ideas
are necessary but insufficient for moving Linux forward. This community
does not lack for talent and ideas. Maintaining trust and collaboration,
that is the hard work of Linux.

This anecdote from Pat rang in my ears this past week:

"You need to be right less and effective more!" [1]

[1]: https://www.linkedin.com/posts/patgelsinger_sometimes-its-not-about-being-right-its-activity-7361475388390191104-rFVb

