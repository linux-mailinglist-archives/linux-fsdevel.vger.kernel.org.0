Return-Path: <linux-fsdevel+bounces-60710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84414B50390
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 19:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01E143AB4CC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 16:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB5C35FC31;
	Tue,  9 Sep 2025 16:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="muDBt03w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D65C20FAA4;
	Tue,  9 Sep 2025 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437045; cv=fail; b=E6kbzN0UGTE36Jg3Xa4V+xxnSPo+8DIU1ozKfN1xkPTNrRjf+jk3MRY96NZ6CkixyRqnKRpbMvA823fo28LmE+5YDwUORY72BZwzN/0zRv5OG0pl46jCDWRUWyqcE3Ki8G/REm6rgfF0AOShRXrI5zBvm7kO5/MLVhdsD1UFXbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437045; c=relaxed/simple;
	bh=72AV8olXfo94GGs8EvUKduNNXUwUsbXLGOF1LLKQWEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EX2rEeID3KeeIy99yKPOwWaWV4nP2pKOjsaYRxGcInquI2m+FAzAKlxi57YSUpyMCYyZzO4F2zcooVagENYtbXtx5Yk+lBlWwutq10wuR6OyjU+oxBf1ILe1R/mKas7TMw7t1lAvHy/wEIpEeakS5D7G+nwynp1xrQ1R8Pjjj6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=muDBt03w; arc=fail smtp.client-ip=40.107.92.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tlo3WmcjtA6JWdMI8/JgwtmcUy2TW5feFDz5EnHNZwxodE7R25MXNg7t00SNa3U5BX08sOSjnJHnoIFnuUpA9/xLFS+8GxGI80VmUdPa9u2bu+qWd9A9N7lwaruwG7OCgZ49fAVRW4JjDxcUmfPXwJ0JiWMqR/FC+MwU4Fr5gja7N4ttfY9taAq79MXJHEgvqRElbVtlmP4OAF4Fzovtj/QMqGp4e9J05zUMwOENkXZDBmo7ha1Y7UIwQf3xL8aL1z+gzNopZgbGQHQ5pnJfKcionhTHW9wzJ16BcHrhDMvbHQHBz6I81o6NB57YfSN2vgUdUe0JgJ5iLcz46+pwLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tiv8b8JW/C8fSv6p3sqTIkZ+otzb5HuYbQxddjVliGo=;
 b=Uaw73C5p7QNAbRpQ3UQ97PKY/jYmekJnq6fmFrk9cyykjp9FQG65UM/21cbQ/oHU0fQkhVCAB84jjdaquulO8m+RDHeh54HaV8pvR1DGxrCGjQIuo2ZmPMhpbCrFQ4fZrHrri+OhPmDSB8gNp7Jqu7SrI5odkML2gDaWW8CPaMYeVveuAWAqaPEmoah/57d+rfuW+39Uas2ZqDiV/RPpUE/sOKlN+qBUXzwuL2lutWapJXBRe9waVFYYJbUX1F+aUkD9x2UtopAbHRG0pzNhZqufV8cfq9ZDWQNp8e1MRkujGgdZ9YgPmnmr07t8MX5CR6p+QygZDSJTMYJeSjVZeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tiv8b8JW/C8fSv6p3sqTIkZ+otzb5HuYbQxddjVliGo=;
 b=muDBt03wgvVws2K1SdXJftOvrgh61D7V+TIX1dFQb/jPDFXQj6spEXrAecrY7YdRQHuVt20Gac2ZDqwgsTjPG8w9X00qN6Lh8l6/ugHn84uCPJ6OMJw6gOCTMt1KwyuRcew+mQwAd0JySocSg6XWlXvEVSiGox5SseQcd2inHdYie+GYWeMqWRDYzzcQHBOXBRb9u+zs8kcxS6yam45ovIuP9ZwmC/mCJPsr8cCrpwdqEAXsIyAi+M6sEI6atTHZZUhk5R3wVjHXPEpjkCjfh2OzNt1a2NSfIcUMNCuKEjX+kIn23sFyXOz6dPBZ68qmgUfjqdp06nQuIPt4Tr0xfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by CH3PR12MB8185.namprd12.prod.outlook.com (2603:10b6:610:123::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 16:57:20 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 16:57:20 +0000
Date: Tue, 9 Sep 2025 13:57:18 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <me@yadavpratyush.com>,
	Pratyush Yadav <pratyush@kernel.org>, jasonmiu@google.com,
	graf@amazon.com, changyuanl@google.com, rppt@kernel.org,
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net,
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com, ojeda@kernel.org, aliceryhl@google.com,
	masahiroy@kernel.org, akpm@linux-foundation.org, tj@kernel.org,
	yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev,
	chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com,
	jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
	linux@weissschuh.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, parav@nvidia.com, leonro@nvidia.com,
	witu@nvidia.com
Subject: Re: [PATCH v3 29/30] luo: allow preserving memfd
Message-ID: <20250909165718.GP789684@nvidia.com>
References: <mafs0h5xmw12a.fsf@kernel.org>
 <20250902134846.GN186519@nvidia.com>
 <mafs0v7lzvd7m.fsf@kernel.org>
 <20250903150157.GH470103@nvidia.com>
 <mafs0a53av0hs.fsf@kernel.org>
 <20250904144240.GO470103@nvidia.com>
 <mafs0cy7zllsn.fsf@yadavpratyush.com>
 <CA+CK2bAKL-gyER2abOV-f4M6HOx9=xDE+=jtcDL6YFbQf1-6og@mail.gmail.com>
 <20250909155407.GO789684@nvidia.com>
 <CA+CK2bAvxvXKKanKzMZYrknBnVBUGBwYmgXppdiPbotbXRkGeQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bAvxvXKKanKzMZYrknBnVBUGBwYmgXppdiPbotbXRkGeQ@mail.gmail.com>
X-ClientProxiedBy: YT4PR01CA0190.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::15) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|CH3PR12MB8185:EE_
X-MS-Office365-Filtering-Correlation-Id: c72f8c09-fde0-4d3e-e81c-08ddefc1f0c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWFqUGJJb3FoYk5iZVMvaXRlMFdsSTlSMk5oM2dhRTBtTUFzM1ZYOFBmRVdq?=
 =?utf-8?B?elEvWnVZd3FVcWtFeEtacVVObUZYWmFFSUNwWlByRGRsNlZ4T2xlN2c1KzRQ?=
 =?utf-8?B?cXQzY2p1S1BXMFZlR2VnTHVPQk5HWXV0cS9pY1YyUXF1MlZ6T0p5dlJGakZO?=
 =?utf-8?B?SmQxRnJobWhyQjZjOGJxOGFoNHVFV0E0Q3JVYUxKbXlObkRWLy90cktqYmdi?=
 =?utf-8?B?ZVdVdm0wN25ORENFWmVNRCt0bW12MVBJclk4T0lkMFNsT3RRNkFSYk81UEZ0?=
 =?utf-8?B?Y3pkZGlqcHpaQno5RXd5KzEwYzlwNFhIcXhPRFA2eTRKTnJ0RWlWc0pVWTFX?=
 =?utf-8?B?UFFKYkRJUWVkS0JGVVJMckFnc3l2bkFtcDNPSGowYmZQVVUzZmt1Ym81OHBm?=
 =?utf-8?B?Q3VCTHZvUXpweFoxQzlFNWRGYzVpdzVSWFErZG93QW9hcklIYUZLMytENlR5?=
 =?utf-8?B?Y0wvL3lrWjJuUlp5dStnbW5aOCtCUGxxbndNZ0dTbHU4dEtVMmxoUGFiN3Bk?=
 =?utf-8?B?L0VETHA0YXIxaXpSSTJDeDk0T1JNZUFaWno0cG9KcTVRMGROVFRzak5xRXNl?=
 =?utf-8?B?aGVFWithK1JjeWd5UGtIOFdoZjFBSmRDaHFuSHFkR1U2cGxJaGF0OUFTT0Jx?=
 =?utf-8?B?Y3ZoOVphbG9McVBNOFcxOXpqVUpoejQzc2dla0FTZUIzdXQrNEt3Wkx4RWpC?=
 =?utf-8?B?clhORi9Tay8vbkFsOXo1QlJYYjltVmY0eWF2MGhvMmR4Y1dwTTk5Y3g2eFBr?=
 =?utf-8?B?R2tFcGt6ZURwRGFBczBYMnAxR09LTjcyRmJUWko0NWpnaTkzbE1id3hLTElX?=
 =?utf-8?B?UG9LMkNKMzFpdm9hM3p4S0srak1DZUFVaEhQTUFLRkdDem5nNmlnK2dyZE1L?=
 =?utf-8?B?VjF5R0x2VVp5a3I2WmFKbzRlQ0pteGJZUjl5OHFiOWkyWHNpZ2VVSWxscjhk?=
 =?utf-8?B?ZG1tM0pnTXB6R25LNFQxa2hZZVhFcEpjbzFDVThKZ2ZyMy8vblRrNWZLUnRa?=
 =?utf-8?B?M0REcE9UNGU2bVdMcGZBaVoxa2w4bU8xRVhsaDYvbmd6d0d2RGU3ODg5MDFi?=
 =?utf-8?B?bW12VkhqQjhGUFVZR3NDNWlkbkh0N2JkTkVnbHFLcXUrZkVxSVVldUNuS2VG?=
 =?utf-8?B?V0JVd0M3VWVWTDJacnlsSmptUFFYcmxEY0YwWEhjV2VjaERpVFNiQ2VESEdp?=
 =?utf-8?B?b0RGN3hRamNOeTM2SlYyTGZJYzNDSk1JUFVsallHTEtpbUEyM3Z5L1MrSDF2?=
 =?utf-8?B?RGpib1Myb0JPeThGbzkySTFJSDNzYjR1dm01dGtpbmNHazBPallpa3dUN21t?=
 =?utf-8?B?dWU2VWE1bTdib3dadllUckxlQllkdWs1eW1ZMDNFZnpPWnlBNUpOVzhVaXlV?=
 =?utf-8?B?dUoxTEY1WDl6dHY2SjZGb25jTW0zUzBRcFQ3K0FvZDdSbnh6RUxxNUFySmUz?=
 =?utf-8?B?RzE2cTQ4R2IvLzR0T0xtYm5QK3U3N2JKTjlieEJ3LzRpNFhyRU1iUEdveGFz?=
 =?utf-8?B?cGpSTVpFQ0pUYnJvN3Bmb2ZaOXZZaVY1MEdLS3pqQ2VUa3J3ZGFxcnhPRmdP?=
 =?utf-8?B?TytaTFhId1gybGFpZXlqVWJlM0xtRDVlNjRlVW8vWGpsd2ZRam9GWWtEOUQ3?=
 =?utf-8?B?YWRUNGJvVW5xbHRjSUFOOGt2Unk4OHJtaFB2Wkx5dmV3MEc2QjF6ZXloYmdV?=
 =?utf-8?B?SDlQRmYwd2J6NHkvb0IxVVdLN1VZalhET08zaHJPYkQrM2xvaFNYT0xicUdC?=
 =?utf-8?B?MXJ6c3N6YnZEQnVGWm5UTXJCNTBta1ZlYk1QblpPVVhUbHFNcG1WU2lMVTRR?=
 =?utf-8?B?RFZHL0tIK1F1VXlVbWFLTmhFeE81TG0vUmh2RWQwRHkxVmNkc1dXVGNJSDFQ?=
 =?utf-8?B?Y0NnN21RRTM2RC9CZjdSKzhNV0RMdFdYNmEvc2FqVDNlVXRXcVBOMVZQRm1B?=
 =?utf-8?Q?4QHgLL+PkPc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnlhdUhibi9rMUl5a1E5TVVUT1dxang3YkxIL045cEhrUzdyWTBkS0J6NStt?=
 =?utf-8?B?V01DNVl3RWxUejJFWXNmSURWRDAvY0R0cU5DYm43OEhSMURJcm1GYjhURDNF?=
 =?utf-8?B?VnFGbHo0UGowL0xlWkt4Z2NOT3l3TjRscEVObmpKTTAxY1BoZlBkQVN0SVdm?=
 =?utf-8?B?OEJxa2ZldnBQWkZ4TkttcVpqUTdSVTVlOXhZUUhrZ1Iva1ZMMGVNNXhOS29a?=
 =?utf-8?B?OTdVK2h3NlBiWXBwbEFRSVZvUDVIdXNPUHA4a2RHNGZhdDV1MnVReVdha29k?=
 =?utf-8?B?REtFUVRLU21ZK3J1VkE3UEIwdlFGYkh1N3J3TkM3QWtLOWZUWDhxZ2JtaERv?=
 =?utf-8?B?SEQ2NE0yOUY3bCt0NnlKMGY0aGtqa0xsdzRMenB0MUcrMHBNRTR4cWJZZ2tT?=
 =?utf-8?B?NmpDN3BhQWllZ2JTcGJ6VjFBQVVaYTVGTU42YmhyOEdXWkNRU2g4NVVhUklp?=
 =?utf-8?B?MjFZc0RqMjhsaFJ3V2o5QS9QNE45YzhScThLNThETS9qdkdVZUJ1RlZLVmhU?=
 =?utf-8?B?MUpFQkRvWUNzRzJpT0NmdnNVaDV5aWVnQ3dsRXU5d3hVMzdyLzhLc3RTTjBz?=
 =?utf-8?B?VHJNTHhvRjBlTkVBWThHTDJKbmdFRGtJcHBnc1RyV1pURjNQekU2TUdHblA2?=
 =?utf-8?B?Zlc5TFVRTlRsdUxoaGdhWS83bG5adExQWm9ZdGpFRWR0aHFlT2EyQ3ZsZWVY?=
 =?utf-8?B?NGdJYTJIUG1aUEdINXJNZXZKbGtZcTNJVmQrUmlRUHNzMkRsRXl6VXYrVjNx?=
 =?utf-8?B?MlBuSXBmbmgzRmE0VW8wWU4raDY0WTh5SnhrZ1orWXJZWHlReGczTEI2WlJB?=
 =?utf-8?B?blQyaDRuY2ZYb3hKSFZ3Vkk1aUVLOW5EUWRrQzJGVS9veFZmZ1hYSFR4OVV1?=
 =?utf-8?B?N1Rjd3ZDNzN1NzFqcFFNUWUycUJETCtXOVRrZFF3YURjTmF4ajk3S21vbk9x?=
 =?utf-8?B?dXZ0SmZ6ZjdXWXQ0aWxMeHZnV2h3eTV0bmxqa2RMZVFpbUdmcDRSVXhaUDBM?=
 =?utf-8?B?V2xaTjhRVnIvWWwrc3NUL2lqQ2tlZzZTcFQ5M0R2TDRNeVY4NlVFMFl6NWdB?=
 =?utf-8?B?VmVqenlLdzBRRzRvRXNJcCtXYUwvckx1ZW55b3RGZ2JYeGFCVWJ2QitMUWxt?=
 =?utf-8?B?UVRKVm1zdkc0ZVhNSDVUeXVCeXdlVUFnK2NyMDVRbVJuU2dsN2VFQzdGb2tK?=
 =?utf-8?B?K1htc3RlenlpaFdzSENGbmV6cHJ2YU9YQVNNd0ZvK3VDUVV6UHVDOW1Jdms0?=
 =?utf-8?B?VS9XbitxTENnbDREN0E5bHVQcHh1RittY2MwTWZzUXBLajdJbVprOFlwVlUx?=
 =?utf-8?B?b3pnZHNNQUc1YUg1UThuc2ROYTJHZ2xvUHNvcGVKeEU0MUtyUWtCdVZxSnB2?=
 =?utf-8?B?U1cySmQ0M3NEU2ZETlBVWE0vNnNXVWhnRE5tc0I4ZVZxd1lFT09QRFhBWk9t?=
 =?utf-8?B?UUl1S1U3akxaQjBMKyswbWZJZUJVcHZrUHRUZVoyRjRMWUlhYzJLb05aR2wv?=
 =?utf-8?B?ckVhcndkZEkrK1h4czg2VzRIZURWMzdPaVZKbDUreHBlaXM1VUJWRWpvbDVt?=
 =?utf-8?B?YWVZNFM0TlJzeGJHR1hYN2J1Y0Q2SEFxeXBVR21HUDNVb2oxbS9JZUZXbTg5?=
 =?utf-8?B?dkxpSEhuU3FYcnFNWnVEOWozYnlCMGRZdlNEVUhleHpDM0pjb0h6MVcvNTdN?=
 =?utf-8?B?SERwQ1NPOGRxQ0RPcVZNY0tlUU1wRnhhU3pBRTdIWlBMU3h3NGNvUFMzZVBu?=
 =?utf-8?B?THE4bU5oeG05Q0d2c2xSZWJVc044OVFYb1ppTE5kdnVsM3l5Z0pHb0xRamRa?=
 =?utf-8?B?UThuMkRDZDRuZzBaWXZsUitzSCtWMkNCTjJJY3g0c05GbHlRS1lLRmhUL052?=
 =?utf-8?B?S1ZjaTIwWUVwMXVTWHhNNGRGNjZCWTBudDdFdkJCS1pkMW8yWmRjT1VxY0l0?=
 =?utf-8?B?eUJ3c0M3akVxWC9FcXVIYWlXdVRFZDZtdVhCSjhKZWpybFZraW04NXJua1VF?=
 =?utf-8?B?V2FFVHYxSFVSQmhJcTUyVTZuRFdmOFUyaGlvRGRaeFZOUjBncmFBOTJ4NW8r?=
 =?utf-8?B?REFQQW13U0xrRkNEenpOV09jZnBNRktxbUxzVlNTbE9YSlcwUkRnazJQMnVt?=
 =?utf-8?Q?E3kE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c72f8c09-fde0-4d3e-e81c-08ddefc1f0c5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 16:57:20.6095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pz66KfYckKIB1wNqnlz8/ywMueESonGm6zO0NzOiv1peWc3iVxm4gat7GQr4me35
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8185

On Tue, Sep 09, 2025 at 12:30:35PM -0400, Pasha Tatashin wrote:
> On Tue, Sep 9, 2025 at 11:54 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Tue, Sep 09, 2025 at 11:40:18AM -0400, Pasha Tatashin wrote:
> > > In reality, this is not something that is high priority for cloud
> > > providers, because these kinds of incompatibilities would be found
> > > during qualification; the kernel will fail to update by detecting a
> > > version mismatch during boot instead of during shutdown.
> >
> > Given I expect CSPs will have to add-in specific version support for
> > their own special version-pair needs, I think it would be helpful in
> > the long run to have a tool that reported what versions a kernel build
> > wrote and parsed. Test-to-learn the same information sounds a bit too
> > difficult.
> 
> Yes, I agree. My point was only about the near term: it's just not a
> priority at the moment. This won't block us in the future, as we can
> always add a tooling later to inject the required ELF segments for
> pre-live update checks.

Yes, but lets design things to have this kind of logical code model
where there are specific serializations, with specific versions that
are at least discoverably by greping for some struct luo_xxx_ops or
whatever.

Let's avoid open coding versioning stuff where it is hard to find and
hard to later make a manifest out of

Jason


