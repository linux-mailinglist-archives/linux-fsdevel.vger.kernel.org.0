Return-Path: <linux-fsdevel+bounces-75656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sER0Dz01eWnAvwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 22:59:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B63BD9AE05
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 22:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABE25302000F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 21:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543BD333730;
	Tue, 27 Jan 2026 21:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PtXTxU7k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7313321A5;
	Tue, 27 Jan 2026 21:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769551149; cv=fail; b=Q/NFmnlg5stp+zx2iq7ip5fSnvYleQt/78iG9dpo1m0sP6h449jXN20fYuiP9a3rardtaWV5P8ZFrjlP57SflfMMs4/JTgfeyfyTw89ieCKau20Moo1ivHxF7072+5H50LvlhPjDfUaPxVVlImBnnfAnKhS1ngmp691n4WUnkWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769551149; c=relaxed/simple;
	bh=7g26Ws8/x/df3lqVG1zCC/cAHd2C2XO+SXjXjaS5zV0=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=tScvGSbpZ9AoBoBWKuTmJcXQInh8f9pBFoLOBLpmcJBn7piYiM10xjX8BSb98axCNbAU5DulV7o+4t7KjLxTeRPU1Pstty9zCyLE1q6OVf5mRnV9jH/NvsI58nafGu9ZofGwFXLTBHbhb/gY/fAiMfW4MGZilceolzfCnJd93Gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PtXTxU7k; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769551149; x=1801087149;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=7g26Ws8/x/df3lqVG1zCC/cAHd2C2XO+SXjXjaS5zV0=;
  b=PtXTxU7kh0+8rhV4LPaLPbEeDLEgMVMuYNKcJVWNX7EO2hRxlOEdHImS
   +ZW8xgUwPkctUI7RxLyzhoajEanRxDTKVPxqzmgWQvHbgClcc9oBh1zko
   cvsDCGuOXMxkPBEdW87riO11KVooAkxYJ5O3q2dhDBfB18q95Yg4yGzNm
   vTXDj3qmZ5sX4EY1tsRelHCTAx+z8A25Je9zC4xXCGGV62mpWpqa+/jOB
   NesEkgjfz5k9rU2+JQ3DHZ4841mw1MngqC45x5SJVwOnqY70lfFwz/JyB
   ss1NODx00ME9uz8RL2vh5nmxaXE6lRgO/H8T8ezbVpZquLNimkdXEK5oV
   w==;
X-CSE-ConnectionGUID: MDgRVprtQeGZqoO9eFYapQ==
X-CSE-MsgGUID: U2AL1vgwQ1qd8KyGcXzS8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="70814837"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="70814837"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 13:59:08 -0800
X-CSE-ConnectionGUID: qEgV18z2R3qXqeepZaZvtQ==
X-CSE-MsgGUID: NhvNlsKSQumY+tdm+0BiZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="239345957"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 13:59:06 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 27 Jan 2026 13:59:05 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 27 Jan 2026 13:59:05 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.48) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 27 Jan 2026 13:59:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2hZJCI/CZtxrVO53t2g/UV06XV0wieMg3sTWKP6AdC3TpWOFNlfwDBMVWWkn778IFU4EVVHEUh1NsI+dusDd6s/tp8XTDmH4CFFb97HxbnvcIFAa4650uMChvN3InCFRzlidbFi7GZXULiF5vDgrw7kEpxoKvEEQqIXCDHHbqGwIpIvM9enVZ3HlxxeGwzMHKMd9ofMb8Z/KqEeLlc8Xa5sgArpB5wONF21x/z5XZHqwmUWhVSmlcPshV4quYRZdB34sunP/zHtT7jlUbWH/IuKTGplR01X1+sXa7iflNAEdIQnuchwv0Kk2vg+8sxxne977Pht1K8KUcm6aIw5Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMa2HSN0V0RiTKJyzssVn6mA5bqVQ1cglLULLyOw1rI=;
 b=MY3Cp7r502iq+jXDDEleZEZj5rTX2uzvDxxqGRwu0z6Mw+CBqZvHYI6UUCo6DnPvrcnKikKX57Jbt5P1eC+ViKg9mUN4HvREkMKzRk1Xscul+NjbQzJ8zCoGMKEYVjoky99YT0NiAwQEyJnVWqtG/feAs7/LAF+fhEWQtqoY4gg3r2iBOzpQUfJhxbKT5cfsFn2LMhkw9Q7t6WHkPunzUSWLYdYn+muxbZgi2bEBG5+EstqaeAqS2VTuW04stV2u7fSb5yRX0pRt/OqNqtmhXR9JOxqp7LTKlTDwhaSL9SSzLG69SeTnJE4V5+GSDQT02NnrwFTN+agVz4D2W36tdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM6PR11MB4722.namprd11.prod.outlook.com (2603:10b6:5:2a7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 21:59:03 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9564.006; Tue, 27 Jan 2026
 21:59:03 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 27 Jan 2026 13:59:02 -0800
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Matthew Wilcox <willy@infradead.org>, Jan Kara
	<jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, "Ying
 Huang" <huang.ying.caritas@gmail.com>, Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Nathan Fontenot <nathan.fontenot@amd.com>,
	Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>, Zhijian Li
	<lizhijian@fujitsu.com>, Borislav Petkov <bp@alien8.de>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Tomasz Wolski
	<tomasz.wolski@fujitsu.com>
Message-ID: <697935261679_1d33100de@dwillia2-mobl4.notmuch>
In-Reply-To: <20260122045543.218194-5-Smita.KoralahalliChannabasappa@amd.com>
References: <20260122045543.218194-1-Smita.KoralahalliChannabasappa@amd.com>
 <20260122045543.218194-5-Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v5 4/7] cxl/region: Add helper to check Soft Reserved
 containment by CXL regions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:a03:254::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM6PR11MB4722:EE_
X-MS-Office365-Filtering-Correlation-Id: f070c082-a690-4b14-7af8-08de5def48e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cE9pYTJzWU5jUnpjVk1paVFGMG9RWTBnUllBM3hNSUpFV3F4aUlJOUI4SGk4?=
 =?utf-8?B?V3llRUNWU21vcnZPdWY2WUpoT2lDSTh2K05LemUyODcrY0hOalNoOUJCcmRV?=
 =?utf-8?B?bFAzZE1wakNUOWh6SXhBV1pMeFRlN1ZZN1BTTU9iMGEzMHJTcUZQVEZwUTdG?=
 =?utf-8?B?aDFiOG0vSW1pTG5WMWxIWnFPRytZaDlRTWJFQ2lhK21IUjBVQWg1bk5Lbi9F?=
 =?utf-8?B?TU1rKzFuMWtBT3pxMTFEekhGNzZBQXVpWExNM3pVbmFwSDVaUng5cENjeG41?=
 =?utf-8?B?NHZWRjlta05UN1BSWGc4M2ZZQ3c0OXBYU3FWTDUwaGZOeVN0OHA0UGJRaGpC?=
 =?utf-8?B?N1lESzNQZnlLRXVPRkFLd3dMT3FUYkZROGxIVTdjbDlXNFhuNkZvQnc1R1oy?=
 =?utf-8?B?L3FMQk9vUnhpaEphNzJoWUZnWUlSV2k2bDlUVG5PZEpibWVPOS9xYklQRzA5?=
 =?utf-8?B?SmdHNDB1K01LTTU4OHZXVlM3TlZyQXdNSkZibis5bWFyTC91d2RkZk9uT0h5?=
 =?utf-8?B?dnM2UW95RmxnaExaMGhsUXJ5ZitORGF3L2doNGs5MXJlYlkzZllYdDNPQklE?=
 =?utf-8?B?VGtSdVQxMUh4ellJUjQrZWlQRXhiWWs0dmZjTDNCV0svNHNEVW9Fbys5d3NC?=
 =?utf-8?B?aGxLT2hBY2plWlV5T1dIVWU5TE0yV1ZsRTFrK2RVN2Jib3NwTzZIZXJiRktv?=
 =?utf-8?B?VURMWGx0NFEvTFBRL0RvWWlCZUVJdlF1V3Fmdll6MnVDNU9CZy9YUEZ6ampq?=
 =?utf-8?B?TGplUkRjYXVFYzZoK3E5VnNYNFVWUUJteGxJVEtJT3hpeEsvYytvNjZPZVUr?=
 =?utf-8?B?SC9UQVovOElxd1JDYzlQSzlraXpscXJpdVc2WUY4Mkx3cXRIM0Jlbld6aGNa?=
 =?utf-8?B?U3Q1akNQTzBOTDZ6RTh0OHYxbDJBYzRuOEFvWXNzTTBOdEVCL28vV25WazEv?=
 =?utf-8?B?dzZzZ1BxNGgrcHJFVS9Pd1RQT25udjJzU3NiWnh6SktNRUE3SDlCN2VCUkJ6?=
 =?utf-8?B?R01LUy9OeDVvWlJZM2xhNUxtTnF4MEo0SFZORlUwTXJ0dlBraE1MTXlDWEZM?=
 =?utf-8?B?dVhwYWgreWVZanlaRzJUa21TL2VqaDU4cjFhMzcyZmNGWWdIcFBjTHNrcXp4?=
 =?utf-8?B?eFB5R3JoZFhuNVNuVTlMb05Mc1JzUS9PV1pMVG84QWtyKzhuVzNXeXAyU3du?=
 =?utf-8?B?NlIvdC9JSldOZ3FQSC9aS2Z0ZjBTcm1yMlBOUDdQVHJwMzRnRTFHek0yejVX?=
 =?utf-8?B?WHQrVUt6Znllc3Q0cVFISkRXQ2tJb05iQnJXRHNwM0tMVGRJc1daSWxXQi9F?=
 =?utf-8?B?NXVRUnYwOW1rckVINXZDSnN3M0QvUWkvK002WjdMNUpSUm9BL3drajc1OEJ4?=
 =?utf-8?B?NDlVSWZzK055WmNFemZNSCtVYVhDcDNoSXNYSFhDMDllUGw2RU1JbG4zclpo?=
 =?utf-8?B?a1ZDWVBjUHdxc2VLSElNTkxBQUVraTFHZ3FQa2FaWFVoczBOdU9raThycGJw?=
 =?utf-8?B?OTNtVmJzMjlhME8ySVNhRlVRVEl6alJpbXhhaExTRTM5RU0xNHVCUU9oOXRQ?=
 =?utf-8?B?K3ZBYWR5ZWNINE1xUFI4MlQ5Z0xHbXJTK0llWDZhM1JDaTRhbmZ5UVhwVFNZ?=
 =?utf-8?B?YkFXQjNUbGE4ZTg4T2lnamw4cDZsVXdJR3JTR1A3QUVqWVBORUhYUXJpK2Nx?=
 =?utf-8?B?VFVBVG8rczhkOUJCNUFpclFLSk0xcTlleVJpekE5bkZJN0dxU0I1dk05S3dB?=
 =?utf-8?B?dHAySUNHYzBlQ3pleHBsYVJ1aUtidGtJb20vTkpmUnpuUURvT2hETE8vbVR2?=
 =?utf-8?B?cEltMjNGUU9mcDhOblVjNmEzOGFURDJtQlFwcU5lQjF4NkJCS3FXR3VKZWRX?=
 =?utf-8?B?b1VsckxkV0R6aHBUY0VXUkxWYkorM1N4a3E5R0ZPTXRWYzI4OU1FeC9nRThh?=
 =?utf-8?B?QVFwUFJLQ3lad25yNmdqRkxGeFlRWTNmaVJwb2hFSVhXWG5ES3lGRy9WU3Ez?=
 =?utf-8?B?ZGFZWU5iWnNucXIzUGlmTzJkdURTN3c0OUJST1J6OWFFYSt1Tm4vUjVydkU1?=
 =?utf-8?B?dW5mdVNJSm82N3IxRy9URFVBNGxZamlBVks4djNRMzZaTVVlWDlHLzdaWm1v?=
 =?utf-8?Q?GN2o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGJNQ3BtSEJyaTlQeXdvM3FqU3AwMVduUWNTY29taEZsWHBTT25BTDFwWG8y?=
 =?utf-8?B?YW8zQkVORG1tbU1RNjQ1WkFXSW1CRkpZNkNuK3MrbzNYTDRGRkhONytSR1kx?=
 =?utf-8?B?cVVHTVVEMDZEUm1qWmtZRDFCOVA1NXBhNzNtSnVrS0ZMVXAvNEU1b1R6bmcz?=
 =?utf-8?B?eWVzdmxDM3c2SHNhajR2Zm4vMUsxVE1zbGt3WmJsckZZaXhqNit3bEE2QzV6?=
 =?utf-8?B?ZmNIUFhDZXFremJsd3N5dHVkZnpOLzZMU2hNa2tWUTZQc3o1MEV6WEpmYlRu?=
 =?utf-8?B?c0pPWERWL254OFQyZzVhSCtYYTB3YzRnaHBOc1VHRFhMSGl5U1REWUZha0VC?=
 =?utf-8?B?S3RTUHViYW9PZEhoL29odWJiOWRzYkFKdWNUSHVVeUxaN3BIMzBjZXB2Skkz?=
 =?utf-8?B?ZWVNaXhxV0pKckxvd0xqV3I0QVkvdU1JYmxGMmJFSEdZOGd0SXdOcDFHR0FT?=
 =?utf-8?B?QVI2RVhRZFkvQ2RlekhPekh6R2JhQTgxWnFTRWdzYzJvdDg3ZFBsd0JrQ2pF?=
 =?utf-8?B?NklvR1QxUmtTd0ltT0I2bUZPSlloVjRGKzJLTFZhZXZnVi9RbnQ1Sldxd2Rx?=
 =?utf-8?B?ZDh4OGpqUHFBOFlxZ0J1cmthQmgrMW14WUs4eWc2d2xEc1Q3K0xCNHduL0JR?=
 =?utf-8?B?V0pFWkZta0t3SzNUb3p3OHVCWHB2OC9zV3NMQ0JiR09KTHdvaXpjSno4Wll6?=
 =?utf-8?B?MG9lME4wd2VNemlFZWNEODBJRTkyUWtZRkVYQmFiZlUzK1B3aVlqUTB1TEQz?=
 =?utf-8?B?Ti9wS0RkcG1ZMEVCNi9TcWxKZEFiNDRsOWJsZmtNYTloUFA0YkQ3REpxcmlv?=
 =?utf-8?B?Q0c0WktHbHZQbWJSZEZPcUwvNUtmSjlLbmw1U1VOMCtrN3Jrd1QzQ0U5NWo1?=
 =?utf-8?B?amZZR1JKSE5rcCtIaDhRTlJCQWlxWXJpVmViU3hjVk1xV0xwZDZZUjc2ektP?=
 =?utf-8?B?cmVyTkNHRHRsdWI4dUVZU3BrTHh6WnBIR0dtN05XQXV0UVlBNFU4K3p2ZEZw?=
 =?utf-8?B?dHAzUDNXS1hqcU5XTlpKZUI4VmtPR05ETGxKdk1HTXpnUjhlRmUyY0ZPZ3Nk?=
 =?utf-8?B?L2Y3YWM3RVlUSXdGbWNjQ1kxQ0FkUFVzT0QwbWdmS3F1a2RCTGZWdUVaS3Rh?=
 =?utf-8?B?bVhnbTFlQ1owR3BUVkNIbFo2Wkw3VHVqRVRVKzRXVndsc1dvZDVlY1ZzWDkw?=
 =?utf-8?B?Nm9sbGUrOEtqN0ZabC9USFdvN3U1Ty9HajZKUEk3Y2drbCs5Ly9LcHdNdnZ6?=
 =?utf-8?B?RzRxZmtxQmRYbjdvZW5WY3NaNWxRcmpVcjBBZ3pwMUVwRDNCOC96ZWlrTTMv?=
 =?utf-8?B?ajZnbzF0K2QxdHpjeXUyY0Y3b3lscjhWOElQV2Q1Vk9qM3J0UkNXbDN4S2Fi?=
 =?utf-8?B?c1BMQUFoVUlSd0l6K3RkSmZUaWRENjUvaGhoT29rQi9pcFc3YjdsL3UydFp1?=
 =?utf-8?B?SlVINkxsWWpHRlMxOHhPZHNhYTk3aEZieWR4MDVaV2RDQU1udGw3QXJyejVo?=
 =?utf-8?B?bW9heFc0eU14MjVESlFrMTczWTlKdVJrMEU0TmRBY1Y5ZlZ4Qk9GM2JjOHZ3?=
 =?utf-8?B?MVNqak9pcVNoTFpGbWdaaUQ5S0FlMjA4dWYybFdPSGpRRFAzdHFsM0VRaVIv?=
 =?utf-8?B?UlpqUE1pM1RrYjV3TjBxelNWRGF5NDFPQkV0c2xJVCtZdkltcUpjMHA4c01E?=
 =?utf-8?B?MC9zaUU0KzFjbHdzMnZ5QmtXZ2FJTzNhbGlGTWE1TG95aExHdENoK2d3dHoz?=
 =?utf-8?B?STFzeHVuQ09ScUNFcWV6U1FPeHN5dHh2WHZkRGVVQ1U1WEJHWHA3cXl5aUlD?=
 =?utf-8?B?ME42ekVsdGdKdkl2UG93VG5oUHhXZmkwaktPWFQ2Z0xmWUpIVHkyWWZ6UDh3?=
 =?utf-8?B?R3lKWWN4Q2NNSGV5WTd4Yk96aHoxUDhQWG9DaDdmUXZkZFE2M29ETExaYXpj?=
 =?utf-8?B?azEyb0srSHlnNFprUGtMNWo4dmcvOUZrRDlMbU5naUx3MWpTd2hBcGtYMEwx?=
 =?utf-8?B?TUdXL2dVY1FaS2xNYitoY2JtelhMZXU1OUJoSWRaTkhGUTRUcE95M3I2c0xq?=
 =?utf-8?B?emlFWTBwNmlydW1XUWNFcjIraWZUOWxNYnZUTEZtSGFYU1hPWkJUYzEreHQy?=
 =?utf-8?B?M0dpWmdid3EwLzZTNWxrdlo4Uy81YTF3NHAvdHJTTGZuM0RFU1kyM1EwVlM0?=
 =?utf-8?B?WGtzUVN6cnJsSDBzSDduSnZMWnJmeG1nd3BaRDBRN29KYjZ4TmpDUDRkaGNF?=
 =?utf-8?B?aUNXcTNEWE9Hcjh5bm92UU9GTFJreTVNNlFEUFgvNE5udE5FUWhUdVFuQ09T?=
 =?utf-8?B?YXUzbXlWRmw5NDBhRWp6d1RrVUZyUFZOMmxMRkRCcEdHZElRQm14K2lueUVx?=
 =?utf-8?Q?aCv6hieOp0909vrg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f070c082-a690-4b14-7af8-08de5def48e5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 21:59:03.6314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n7dV61xR4/Ko3VKqrAb6ZAKZ5fg9Y5AH495m/w2VooXewZ+gi8ul6E1rs1GfwWE9kaDEDEXvtexbAiTbKR8YQV33iN2Dz+jjjOPZ3cmzKJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4722
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[34];
	TAGGED_FROM(0.00)[bounces-75656-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,dwillia2-mobl4.notmuch:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.j.williams@intel.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: B63BD9AE05
X-Rspamd-Action: no action

Smita Koralahalli wrote:
> Add a helper to determine whether a given Soft Reserved memory range is
> fully contained within the committed CXL region.
> 
> This helper provides a primitive for policy decisions in subsequent
> patches such as co-ordination with dax_hmem to determine whether CXL has
> fully claimed ownership of Soft Reserved memory ranges.
> 
> No functional changes are introduced by this patch.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
>  drivers/cxl/core/region.c | 29 +++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |  5 +++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 45ee598daf95..9827a6dd3187 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3875,6 +3875,35 @@ static int cxl_region_debugfs_poison_clear(void *data, u64 offset)
>  DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
>  			 cxl_region_debugfs_poison_clear, "%llx\n");
>  
> +static int cxl_region_contains_sr_cb(struct device *dev, void *data)
> +{
> +	struct resource *res = data;
> +	struct cxl_region *cxlr;
> +	struct cxl_region_params *p;
> +
> +	if (!is_cxl_region(dev))
> +		return 0;
> +
> +	cxlr = to_cxl_region(dev);
> +	p = &cxlr->params;
> +
> +	if (p->state != CXL_CONFIG_COMMIT)
> +		return 0;
> +
> +	if (!p->res)
> +		return 0;
> +
> +	return resource_contains(p->res, res) ? 1 : 0;

I suspect this is too precise and this should instead be
resource_overlaps(). Because, in the case where the platform is taking
liberties with the specification, there is a high likelihood that
driver's view of the region does not neatly contain the range published
in the memory map.

There is also the problem with the fact that firmware does not
necessarily need to split memory map entries on region boundaries. That
gets slightly better if this @res argument is the range boundary that
has been adjusted by HMAT, but still not a guarantee per the spec.

> +}
> +
> +bool cxl_region_contains_soft_reserve(const struct resource *res)
> +{
> +	guard(rwsem_read)(&cxl_rwsem.region);
> +	return bus_for_each_dev(&cxl_bus_type, NULL, (void *)res,

No, need to cast pointers to 'void *'.

