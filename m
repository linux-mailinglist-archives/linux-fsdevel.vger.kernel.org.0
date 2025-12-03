Return-Path: <linux-fsdevel+bounces-70603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74285CA1C69
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 23:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42D5F3029B83
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 22:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972122E06ED;
	Wed,  3 Dec 2025 22:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b3+8u4+z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369E32C375E;
	Wed,  3 Dec 2025 22:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764799569; cv=fail; b=VGkda+UBSI6jnf7/4oJyRxX8CjNzj0zDYvmC+og7kpYtxuD3Aa+AonkXgVlyNIkbKfBWo4CK4EcJnilsGz/N9pcKlm9Ap2jTQdHg0xZfvpnGN0neNnPvW/Jm+T9hBhg0wOx83SuBE2Z6a4MBL5YwnwdnT0b8iUeoTY7XGjMzHeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764799569; c=relaxed/simple;
	bh=qeorh4zrStyzrp5KKQ54KygSKbJ7hj0F71IwPtodUtI=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=g1InZSwT1+pX/ImWYyUZzQ5RSSCCiRwuAX7nmCkR0erWGYTZLdN/0wViyjuv/vfUzCEATS46Pws0MBgN+aFAZMw4dCW0rtgBkrD2u5dKUBpAaznF1B/oixa+COLIFWRUAGbSF2vsp+SD0W1PZi/SMWbh1Vc6Mv7EshKHf2VdCZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b3+8u4+z; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764799568; x=1796335568;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=qeorh4zrStyzrp5KKQ54KygSKbJ7hj0F71IwPtodUtI=;
  b=b3+8u4+zRn+FZ00Hsk2OV6yZl7X1RmO4KKfjSgta6yTy7AARdSKcZkub
   oy7kGSlPAq6DLMQwUWVHluPZxBWWlAOqMmiECv1DMJxSnoVRndrP4+VVh
   qqYgeEolnXv54ZsLIBMlroPsPOa987WWCD3Sb3opnFS5BrtDiPMTFVszr
   sIGFNnA4IgGawGz6apQpUOapdmWwFQOoUSGTjKN9J3E0wQg9Xn4q1F2DK
   Dvt9oIz7260L2Rm8AqCEi2s9q6wQbk9zAsIG5hx0HwqUOEC1ruVNOlftv
   PEDKAEtKB7DqMYn34nlCfk7prLLx1bQnmYxlN92N1ZVbanR9JSRwoGRSP
   A==;
X-CSE-ConnectionGUID: AsiG1wk2TrOyMEaKOe39xA==
X-CSE-MsgGUID: ZPGXdxOqRv2cfxCkOlBllQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="66697779"
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; 
   d="scan'208";a="66697779"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 14:06:07 -0800
X-CSE-ConnectionGUID: uHJnS9NFTOKjPFx8yw9D+Q==
X-CSE-MsgGUID: O6v/X0LcSBWZFww5WUUQSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; 
   d="scan'208";a="198977798"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 14:06:05 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 3 Dec 2025 14:06:05 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 3 Dec 2025 14:06:05 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.21) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 3 Dec 2025 14:06:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j3lyELbh/SrdPpKTlSzUSk7FxLqDC2QjOFVm/Aw/dr12wRxisN5InlovwJZMIFz5qPz9EET8bqE1k6VpG329oY+E4jCuZO+dYC/tFITKniTqLjgov69lvNTbLOSEK13ZTTs/lK4GZ0Yk6xL0CzYlobYHmjUyU1/K+K/1YsXWyCVTLAf80irAOFzYZskMQ4RRLTpGCJ75eeY2Bd3+uUvcKaPmqDiuGatEo8w/uGUCsakiAgLwaDj4013ZaLnms6hkeGJiLtRnehc+XJkN4gaKo85oCt9rXf+fQr7PxpGBm/BBIMwkQZ+5IrvJDm9NpU9lR512q1Ut0vWcYxjtFPoG9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Se2KBF+UeyLrYm/DhF2wQ+6XODwHmwhtvCaN4/J+tKo=;
 b=SQCbTmnISidoSbZhm557XRsYTAOkvFmDiDTUZHQC96TV1qtDfjacSxnZVlCSbN+pqE4xj+wwM9VJ88rDdozlFH5fM4QXQ8DiHF8520/96h6tomHGu92dR+lv9wRC4dDPEvdtArRXrUNtnVqxOUZ1IoR+QBDwY952laRQpW5pbMZEk2puya3w/nvuTHSSPiQwGnB2p80pRxFq2nb7BbqbFJuHeGUpPd8MJGZqXu7UYxkKoOmdPF/xLC8h9I5+1RIXwf/dnU/hxNwd9xsEGs1KK5YJ2D5zfQhDVbMuKMvLpoPsj60gcHrdkYPXHEThbmgbT0a5N2rVDylnclGbur4gdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB7345.namprd11.prod.outlook.com (2603:10b6:610:14a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Wed, 3 Dec
 2025 22:06:01 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 22:06:01 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 3 Dec 2025 14:05:59 -0800
To: Tomasz Wolski <tomasz.wolski@fujitsu.com>, <alison.schofield@intel.com>
CC: <Smita.KoralahalliChannabasappa@amd.com>, <ardb@kernel.org>,
	<benjamin.cheatham@amd.com>, <bp@alien8.de>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, <dave@stgolabs.net>, <gregkh@linuxfoundation.org>,
	<huang.ying.caritas@gmail.com>, <ira.weiny@intel.com>, <jack@suse.cz>,
	<jeff.johnson@oss.qualcomm.com>, <jonathan.cameron@huawei.com>,
	<len.brown@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <lizhijian@fujitsu.com>, <ming.li@zohomail.com>,
	<nathan.fontenot@amd.com>, <nvdimm@lists.linux.dev>, <pavel@kernel.org>,
	<peterz@infradead.org>, <rafael@kernel.org>, <rrichter@amd.com>,
	<terry.bowman@amd.com>, <vishal.l.verma@intel.com>, <willy@infradead.org>,
	<yaoxt.fnst@fujitsu.com>, <yazen.ghannam@amd.com>
Message-ID: <6930b447c48d6_198110029@dwillia2-mobl4.notmuch>
In-Reply-To: <20251203133552.15468-1-tomasz.wolski@fujitsu.com>
References: <aS3y0j96t1ygwJsR@aschofie-mobl2.lan>
 <20251203133552.15468-1-tomasz.wolski@fujitsu.com>
Subject: Re: [PATCH v4 0/9] dax/hmem, cxl: Coordinate Soft Reserved handling
 with CXL and HMEM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0060.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB7345:EE_
X-MS-Office365-Filtering-Correlation-Id: 7585520f-6164-4eba-1bd5-08de32b824eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OC9XaEFXd3JNeTBVQWt3MnpBMGtlSERWYVVKRjJRVFJBallGZm85UitNZmFp?=
 =?utf-8?B?WjBVOWtwa3BEZmNxU0JHc0NpTXYzVEVJVi9scmZMbWVBajRZZG56RlZIcHF2?=
 =?utf-8?B?QXRaOWpIcWtIZGRSakRQYkxuWnpqYnRIK2EweU5UL2FrdXc2QlhtNE9PSDI4?=
 =?utf-8?B?THN3VDNxVnQ1UlZwSkN0VnludFRkNFUzZTViNFl5cGgxU2hCRDFQZUZrbVlh?=
 =?utf-8?B?anFab3poREllUmE5VUdsVWYraFkyRkNXTVdkb2hBSFBtYjRHUEU5eU50M1JK?=
 =?utf-8?B?M3ZQVEp3LzNvSWVMbXNqT3ZNdFc1enRnbzh4a3VCWkRnRlJhRWNMR1haelNP?=
 =?utf-8?B?ai9sQkQ3VmduQWo0Tk91MzRNTkNocjM3NzRKbU9hSjFSTDBzTnVDY2pzd3c1?=
 =?utf-8?B?YzNibnZmVWtXS0Z3ZVRtbHVOMS9RVnozbVRDcFVNY2NwY1M3ZmNFbzlOczhL?=
 =?utf-8?B?K0ZQdDJJVEsyNVNoclJBY2YrelhTdEs1eXNkc3NyZWo2R3lmaDhBVXlsaERW?=
 =?utf-8?B?VFZhaEN0eVhLUGFkVVZQT2xxa2tjTHMyTW5LVmNKaUZFNzZNeFNGN052L0FI?=
 =?utf-8?B?RllNZ01uSFgzM1krWDdrR0szd2JPYmIxdTBPNFBWL3MrOGFRdW5LTmdoZ2J1?=
 =?utf-8?B?aXJqVVlybkQyMkpQeTFGSjNNL2VER2g5MjZOTnJIc0NkVWNFOUhDNkRCSkVy?=
 =?utf-8?B?cFRKYlkxZ1NHZU5lTVlSTHBnV1d3MkxlRThWS1NrOFFZMUM2dEZja2ROQzlF?=
 =?utf-8?B?QmdMalFYYy9sZ3g4bklUVTVNSTFtOFgrT2laMFY4NVFqWUJ4RC9rRzJoN0E4?=
 =?utf-8?B?S1FmSTlsNTh6U3Ywb1dWZ0RxazF4SGxKSVFKMjBtd0tUTkVTdTRvdGVlSGFS?=
 =?utf-8?B?M1pSY3UzOUd5aDU1cGlTV3dGeXZyYWtCRmR4SnU2WFJJMUNoRXFQM2dTM1h3?=
 =?utf-8?B?RWFUU1Ardmo4Mkxud2ZkUWpaUHFBZUF6RjdMVHdzLzV3ZUdyVjZybW4zU3dL?=
 =?utf-8?B?SVRQOU5WSGNFSW04TFVDZmhsaXR6Y3RhN3MzVk9RMFlZd04rcnFydndaaXB0?=
 =?utf-8?B?eEluUmV6SVJWODNBZlZXYkRKc3VRMlZ1cmVhTVk4RGdpRE1ucG1ZTXVGRTZj?=
 =?utf-8?B?STlUaDRaRjQyVUxtSVFNY1Bsd0JrL0FqV3JXMVZvN0hmQXI5eUFSbnVXU3FJ?=
 =?utf-8?B?L0pGV1hpMEtsVDNiekY4d0p6K3c3UzZ6Sm8zSkZ5SUJyKzdGY2VoT1hMb1RN?=
 =?utf-8?B?YURrZnRubFlQaUVEQkxaYlQ0anNTTUtJeUdPZ0RRRVF0YWhnZStLMWdiRUQz?=
 =?utf-8?B?U0VYTHRyc2hyZWF4KzZCV3JTelRZbjZtbTJRNnhLbkdKNWhBWVdBL3FXdEk0?=
 =?utf-8?B?VEgwM0J4Z0J2alA4UzlFT096SmdIVFhYSEE1dmRTR2kwRmRkaEt2S2kzbWgw?=
 =?utf-8?B?SktuemorZkNtVWJ2U0l6ODFqZFpuSlo4a1QyUC9SYlNlUGRocDVpUnNzdnFW?=
 =?utf-8?B?dlVteU94L1JMeXU5VnYyeVF0emJZdGtpcmZBR0JiNldpSDBFVnZZMitQbjRD?=
 =?utf-8?B?aTlEdFE4WFJzWjB2eStUTkVxV0NKM245T1hyQ2tWdDBvbGdZTnB6WlM2U0V4?=
 =?utf-8?B?UjdaMWxWdUFMa0xhcXNVajdFQjFaQzE5bkpMOEEzWUdEeUtHZ2ZSYjZBVHd4?=
 =?utf-8?B?b2UwUDhYNEJqVFk5ZmZPMGZEVGRsQTBwN25pZnFhMlhlUWswTEYvRUVmdG95?=
 =?utf-8?B?OHczUHRQVjVoTUpXdXhtb2U2VzdCZjdReU1GN0I4VE1DdDFUNTUxaFFrNTlN?=
 =?utf-8?B?eEErbFQwSnJvcUlPdWtrRDFHcmovdW1YdDFvSm83RXYxQUc3VVVsVmZFbDlB?=
 =?utf-8?B?UXFjazdOeUw3c3dkcUh4N1F4K1UwMENuU3AzRUpuSWRISXAwZzhHZ282SzY1?=
 =?utf-8?Q?w66fQXznbtHXvTvEOA9neUyLwkubmPoW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1hKN1VqNHBlY1c2Q2VPbVBwNktEZDF3V2J0bWNMQ1l0UG0reFRLdFhpeGZ2?=
 =?utf-8?B?cXAxK1p6QlB4bkNHZWs4NnJTbXVydU5keENWa1hLNWJYMjRKY0lnTnl0U0Jt?=
 =?utf-8?B?Q1pBU0NhMTB6VUhtUEVNaHNsekxYVGp0bFpqZ3UzSUJkOU02MHgwcVVpYVdm?=
 =?utf-8?B?c0l3MTJsYmRROTR6TFJKWk5ycnB6Ymt3WXZRYldhQy9JRXVKdjRLOGY1ZWcz?=
 =?utf-8?B?OEhqdFgzRWFFZVYyUE1seGJXdEIyaEM4TGo0c3JTelJ5aXNiVzBXZ25NeDVI?=
 =?utf-8?B?OUlvWkNpK0ZCVk1jVUM0UU9BTk4wZUFXTjh3cGc3VTAvdU1vRjFyeTJxWXBp?=
 =?utf-8?B?MWNzblVzUW15YlJZSVc0NDVXK1ZHeUxmOGQrWnRIZ0MwaE1KMmdoRWRXRXlL?=
 =?utf-8?B?N0o3TmY1SEd2THJtMStCWXNBTnZuNDVGU0owN2RjT2JZSU84NU5jZU8wVTBz?=
 =?utf-8?B?cytXNVQwRzV6TmdLN2xVNXRhQ08rMTd6MXNrd1VVaVNkVUVWdEZEUjVmZ2Iw?=
 =?utf-8?B?TWVkeXgzR3RVK1A0K2JlTVYycHp2Rk5JYTF1Y2JQU25JTFVaVlFSZUpkUGIr?=
 =?utf-8?B?QzZKam9la0IydGNkcnlSY2ZKZmRIa2pEbWUySkxBNGZzckVyQWJmak9uSE5x?=
 =?utf-8?B?eTczY3ZXcE9NbTkvOVM0TllHOG8zamR0SXpCaWZQM09Vc0VaMzJBbllYRkNI?=
 =?utf-8?B?cjJRQXZVWjRyRHNuZW1nOFJmeG54dG9vRHZ3N05zSU41RFlKbVEvZ1UwcWdL?=
 =?utf-8?B?QlNNdU1jL1Y3cEJ1Qk05SlN4WUZhQkxxb2RVcllldlplMS9UUDlzTTUxZ3Q4?=
 =?utf-8?B?RmY5aEpsenlPaUFCVCsxQU5qV2hGN2dtOU9OYnFEWG96ZUJ4NXdvK2JXQTIr?=
 =?utf-8?B?d3VNdEJ6VmdwOTkrT04wK0hNNVd5NDhML1VrRUFmUWRWRmFnR0JadmxmdGtl?=
 =?utf-8?B?QUNQMDcxU3o2Sk9adGo5empPMWNTRXd5VmtWTi81TVJhWmxpam1WOFZCV0M5?=
 =?utf-8?B?Q1Zhb00wdkFxMU11OU1SK2RiNVkvTDhHKy9CLy81T2tEdU5SMW04RTBYVVNB?=
 =?utf-8?B?d1oyeWtjZW4xMmsyRDhZWFB5M09vVC9xaFdCV0QvYWhOaHgrdTdpK29ZakZX?=
 =?utf-8?B?NmFaNjA4Rm1xVXN6UkFaM3F2T29JYlliTGp3VDZjdm9zUGRsdjdVNkQ3K0Np?=
 =?utf-8?B?bjJHc1JzdThSMFA1UjhxTjh3Z0N4N2RBSld5aFp2VXVlRk9wYTBMem1OOHpV?=
 =?utf-8?B?TjBHUTFWY0ZBcGlndjNBSmhJZmxUWDJWL1RYYVJHNXg4NFRYeTdLdHEvY29H?=
 =?utf-8?B?U0hHTFgrS2pxU1dVK29CS0wwck8yQWJuM1dWclBHM0RyY2hYOGtlYURjMjFx?=
 =?utf-8?B?NExuZGJBM0xtRkdLR1lFbjR0d0o5c3dHcGtQdUNGMTdtei91dXByNXN1Y2hn?=
 =?utf-8?B?WHBENHlxSy9iMnZjaWdqcjBnenNZWUZJeU1CRVlmSHRGNEk1WkhVK1Vjd2Z0?=
 =?utf-8?B?RUZYTjJLQVVKakVxUUF1MmZ6UWwzNzV2cFlUMGpwRWY3RDJ6U3ZmZ3RMUGRE?=
 =?utf-8?B?NGNRTDNKakJ4RXdZdTlwWERoNGZpZlRtVmxGUnd4WkRDYlhoank1eDhNRGlV?=
 =?utf-8?B?T3MxQ2ZhMlpDMlAwRURUcTVCS3FVUFI1VUE5TkpzT3QrWTN1OFpFcm5zMWEx?=
 =?utf-8?B?RHZnRGhEV2wxYmE5ekhKeDNEajdmcHFzcnNwb3U0blBoN2VYSzdNekZ5b0tI?=
 =?utf-8?B?c09Fb2FQM2IvKzE3OGlzQjhjaEN6ai9sV2ZpZGpaZGxrcmdEc0pGYitDZTll?=
 =?utf-8?B?NU9FTDhiVkNPbktReDIwaEpxQ2pVTXB6M1liUHY0eStWN0FGd0t5S3JMbGpl?=
 =?utf-8?B?dEZGajZiSWdvbmw3ajlYMmJ1ZThJYTMzN1FrR2w3VUh6bGYzTjJnUU9FcUJa?=
 =?utf-8?B?elR6MG5nd3g5UWE1MU9lMHkvVVo2b0JSbk5kMVhhVEw1L2Z0cXNNWGdKSE14?=
 =?utf-8?B?QWtzTnRsZWRNQUdPUGxaVDBsbXJBRzBrQkVxSGZpQnIzSVduSlYyY3E1cEpx?=
 =?utf-8?B?S2ZCYVNDQVpVd1EvSUphdjVrcUZrYUlkWUFVN0YxV1UyVUhyWTh3MGhpSklG?=
 =?utf-8?B?M3ZYNlg5UERZOXh1dGY4RXJwVlVuZkdUbURuaDVmSlIyNWdhYllVUzY1d2Ix?=
 =?utf-8?B?TGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7585520f-6164-4eba-1bd5-08de32b824eb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 22:06:00.9959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ne/50NtxCVcW1khYuiQvTGA1nCDfQifNzKt5Io8YlRQ9bW7DnWjWmNxe/8dyA4TJpnmRjkfqHK5THsrvU/MjH2NuoluxsqfOwpF1+QW5qxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7345
X-OriginatorOrg: intel.com

Tomasz Wolski wrote:
[..]
> 
> Hello Smita, Alison
> 
> I did some testing and came across issues with probe order so I applied the 
> three patches mentioned by Smita + fix for the NULL dereference.
> I noticed issues in scenario 3.1 and 4 below but maybe they are related to
> the test setup:

BTW, thanks for all these tests, it helps!

> [1] QEMU: 1 CFMWS + Host-bridge + 1 CXL device
> Soft reserve in not seen in the iomem:
> 
> a90000000-b8fffffff : CXL Window 0
>   a90000000-b8fffffff : region0
>     a90000000-b8fffffff : dax0.0
>       a90000000-b8fffffff : System RAM (kmem)
> 	  
> kernel: [    0.000000][    T0] BIOS-e820: [mem 0x0000000a90000000-0x0000000b8fffffff] soft reserved
> 
> == region teardown
> a90000000-b8fffffff : CXL Window 0
>  // no dax devices
>  
> == region recreate
> a90000000-b8fffffff : CXL Window 0
>   a90000000-b8fffffff : region0
>     a90000000-b8fffffff : dax0.0
>       a90000000-b8fffffff : System RAM (kmem)
> 	  
> == booted with no PCI attached
> a90000000-b8fffffff : Soft Reserved
>   a90000000-b8fffffff : CXL Window 0
>     a90000000-b8fffffff : dax1.0
>       a90000000-b8fffffff : System RAM (kmem)

So this is the expected behavior with the proposal that if the device and
memory is present at boot, but the driver is disabled or fails to
assemble, then the solution falls back to "region-less" dax.

> == ..and hot plug via QEMU terminal => is the following iomem tree expected?
> a90000000-b8fffffff : Soft Reserved
>   a90000000-b8fffffff : CXL Window 0
>     a90000000-b8fffffff : region0
>       a90000000-b8fffffff : dax1.0
>         a90000000-b8fffffff : System RAM (kmem)

Unless I am missing something, this looks like a bug in the test because
if you are truly hot-adding the device after boot, then the BIOS would
have had no reason/chance to create that Soft Reserved entry. The
assumption is that the presence of Soft Reserved always implies that it
was mapping physical hardware that was present at boot.

> kernel: [  129.820136][   T65] cxl_acpi ACPI0017:00: decoder0.0: created region0
> ..
> kernel: [  129.827126][   T65] cxl_region region0: [mem 0xa90000000-0xb8fffffff flags 0x200] has System RAM: [mem 0xa90000000-0xb8fffffff flags 0x83000200]
> 
> [1.1] QEMU: 1 CFMWS + Host-bridge + 1 CXL device
>       Region is smaller than SR - hmem claims the space

The expectation is that a configuration like this is out of scope.
Unless CXL fully covers a Soft Reserved entry it must assume that the
platform is doing something custom / special and disable the CXL
subsystem in its entirety.

The simplifying hope is that there is always a 1:1 correlation between
CXL Region and ACPI SRAT/HMAT range entries such that a Soft Reserved
resource is never misaligned to a CXL region.

Hmm, this might highlight a gap in the implementation. I think we need
to make sure that drivers/acpi/numa/hmat.c::alloc_memory_target()
injects boundaries into soft_reserve_resource. I.e. I think a BIOS might
create a merged EFI memory map entry that spans multiple SRAT/HMAT
ranges in the same proximity domain.

It would be lovely to require BIOS to bound their descriptions on CXL
region boundaries.

> a90000000-bcfffffff : Soft Reserved
>   a90000000-bcfffffff : CXL Window 0
>     a90000000-bcfffffff : dax1.0
>       a90000000-bcfffffff : System RAM (kmem)
> 
> [2] QEMU: 1 CFMWS + Host-bridge + 2 CXL devices
> 
> kernel: [    0.000000][    T0] BIOS-e820: [mem 0x0000000a90000000-0x0000000c8fffffff] soft reserved
> 
> a90000000-c8fffffff : CXL Window 0
>   a90000000-b8fffffff : region1
>     a90000000-b8fffffff : dax1.0
>       a90000000-b8fffffff : System RAM (kmem)
>   b90000000-c8fffffff : region0
>     b90000000-c8fffffff : dax0.0
>       b90000000-c8fffffff : System RAM (kmem)

Wait, you have a CXL region that partially overlaps a Soft Reserved
range? That does not look a configuration the subsystem could ever
support and should fallback to disabling CXL.

> == region1 teardown
> a90000000-c8fffffff : CXL Window 0
>   a90000000-b8fffffff : region0
>     a90000000-b8fffffff : dax0.0
>       a90000000-b8fffffff : System RAM (kmem)
> 
> == recreate region1 - created in correct address range
> 
> a90000000-c8fffffff : CXL Window 0
>   a90000000-b8fffffff : region0
>     a90000000-b8fffffff : dax0.0
>       a90000000-b8fffffff : System RAM (kmem)
>   b90000000-c8fffffff : region1
>     b90000000-c8fffffff : dax1.0
>       b90000000-c8fffffff : System RAM (kmem)
> 
> [2.1] QEMU: 1 CFMWS + Host-bridge + 2 CXL devices
>       Region is smaller than SR - hmem claims the whole space
> 
> kernel: [    0.000000][    T0] BIOS-e820: [mem 0x0000000a90000000-0x0000000ccfffffff] soft reserved
> 
> a90000000-ccfffffff : Soft Reserved
>   a90000000-ccfffffff : CXL Window 0
>     a90000000-ccfffffff : dax1.0
>       a90000000-ccfffffff : System RAM (kmem)
> 
> [3] QEMU: 2 CFMWS + Host-bridge + 2 CXL devices
> 
> a90000000-b8fffffff : CXL Window 0
>   a90000000-b8fffffff : region0
>     a90000000-b8fffffff : dax0.0
>       a90000000-b8fffffff : System RAM (kmem)
> b90000000-c8fffffff : CXL Window 1
>   b90000000-c8fffffff : region1
>     b90000000-c8fffffff : dax1.0
>       b90000000-c8fffffff : System RAM (kmem)
> 
> == Tearing down region 1
> 
> a90000000-b8fffffff : CXL Window 0
>   a90000000-b8fffffff : region0
>     a90000000-b8fffffff : dax0.0
>       a90000000-b8fffffff : System RAM (kmem)
> b90000000-c8fffffff : CXL Window 1
> 
> == Recreate region 1 
> a90000000-b8fffffff : CXL Window 0
>   a90000000-b8fffffff : region0
>     a90000000-b8fffffff : dax0.0
>       a90000000-b8fffffff : System RAM (kmem)
> b90000000-c8fffffff : CXL Window 1
>   b90000000-c8fffffff : region1
>     b90000000-c8fffffff : dax1.0
>       b90000000-c8fffffff : System RAM (kmem)
> 
> [3.1] QEMU: 2 CFMWS + Host-bridge + 2 CXL devices
>       Region does not span whole CXL Window - hmem should claim the whole space, but kmem failed with EBUSY
> 
> a90000000-ccfffffff : Soft Reserved
>   a90000000-bcfffffff : CXL Window 0
>   bd0000000-ccfffffff : CXL Window 1

Again, we do not expect that a real world BIOS would ever present this.
It might be the case that there is a single EFI entry that covers
a90000000-ccfffffff, but the expectation is that SRAT would have
separate entries for a90000000-bcfffffff and bd0000000-ccfffffff so that
everything lines up.

For simplicity I want the fallback to be all or nothing because either
there is full confidence that the CXL Subsystem understands the
configuration, or there is zero confidence. Leave no room for complex
"partial assembly" configurations to debug.

[..]
> 
> [4] Physical machine: 2 CFMWS + Host-bridge + 2 CXL devices
> 
> kernel: BIOS-e820: [mem 0x0000002070000000-0x000000a06fffffff] soft reserved
> 
> 2070000000-606fffffff : CXL Window 0
>   2070000000-606fffffff : region0
>     2070000000-606fffffff : dax0.0
>       2070000000-606fffffff : System RAM (kmem)
> 6070000000-a06fffffff : CXL Window 1
>   6070000000-a06fffffff : region1
>     6070000000-a06fffffff : dax1.0
>       6070000000-a06fffffff : System RAM (kmem)

Ok, so a real world maching that creates a merged
0x0000002070000000-0x000000a06fffffff range. Can you confirm that the
SRAT has separate entries for those ranges? Otherwise, need to rethink
how to keep this fallback algorithm simple and predictable.

> kernel: BIOS-e820: [mem 0x0000002070000000-0x000000a06fffffff] soft reserved
> 
> == region 1 teardown and unplug (the unplug was done via ubind/remove in /sys/bus/pci/devices)

Note that you need to explicitly destroy the region for the physical
removal case. Otherwise, decoders stay committed throughout the
hierarchy. Simple unbind / PCI device removal does not manage CXL
decoders.

> 
> 2070000000-606fffffff : CXL Window 0
>   2070000000-606fffffff : region0
>     2070000000-606fffffff : dax0.0
>       2070000000-606fffffff : System RAM (kmem)
> 6070000000-a06fffffff : CXL Window 1
> 
> == plug - after PCI rescan cannot create hmem 
> 6070000000-a06fffffff : CXL Window 1
>   6070000000-a06fffffff : region1
> 
> kernel: cxl_region region1: config state: 0
> kernel: cxl_acpi ACPI0017:00: decoder0.1: created region1
> kernel: cxl_pci 0000:04:00.0: mem1:decoder10.0: __construct_region region1 res: [mem 0x6070000000-0xa06fffffff flags 0x200] iw: 1 ig: 4096
> kernel: cxl_mem mem1: decoder:decoder10.0 parent:0000:04:00.0 port:endpoint10 range:0x6070000000-0xa06fffffff pos:0
> kernel: cxl region1: region sort successful
> kernel: cxl region1: mem1:endpoint10 decoder10.0 add: mem1:decoder10.0 @ 0 next: none nr_eps: 1 nr_targets: 1
> kernel: cxl region1: pci0000:00:port2 decoder2.1 add: mem1:decoder10.0 @ 0 next: mem1 nr_eps: 1 nr_targets: 1
> kernel: cxl region1: pci0000:00:port2 cxl_port_setup_targets expected iw: 1 ig: 4096 [mem 0x6070000000-0xa06fffffff flags 0x200]
> kernel: cxl region1: pci0000:00:port2 cxl_port_setup_targets got iw: 1 ig: 256 state: disabled 0x6070000000:0xa06fffffff

Did the device get reset in the process? This looks like decoders
bounced in an inconsistent fashion from unplug to replug and
autodiscovery.

