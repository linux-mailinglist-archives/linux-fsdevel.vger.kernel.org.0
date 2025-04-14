Return-Path: <linux-fsdevel+bounces-46385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF716A885AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 16:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE39F562D6E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 14:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CB427B4FE;
	Mon, 14 Apr 2025 14:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ggPfTPsk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2042.outbound.protection.outlook.com [40.107.95.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB071E480;
	Mon, 14 Apr 2025 14:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744639923; cv=fail; b=CkeIxXMto4b1kSB7gJ+7/vXcMd9+RXA40nn1z32/OuzNtd6UqwibBRrvf+VfEbcjgbWjcy/zqEzUL17p9TujX5yRVtgTe+iAp0+DEUOY5kU5/FjIOlmF9UC/Sf6q566QOKEYc+aIo12KGsZKnkdnXzqutfiQYRQr9lrLF50IZ5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744639923; c=relaxed/simple;
	bh=fTQL0U3n8qSdjvd30RBS6Eql0ONU9zQp0Rs8K4697GA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FtuTQziJALFbyNIwMhGklfWb8noAc3pau6AECFARymdA0kojJzVDlxTs2lvaiqrHIkrnd7KQ0BHPKZ5QjIogsCiRcfH/CoF96Zj2BN0ra/QmwUeb0gUPGftQX9guIgzcrXjeDjtvvRYLb/vh9xe8CSEZwhUTqYB+FsE0RpCEwPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ggPfTPsk; arc=fail smtp.client-ip=40.107.95.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SjI9rCdlgaEI0koPtI4EvE8I5TzfohkHDmKtGtJ41id19wmVurbpI1VyPOsccmT0bxhi87pKK+2ePVDBVUdqgDcqaWcq8fZl/YVoOClA7oTi7JQjgPVbtUX80GehB5huRlBCofIgc+rjANVzT32ny7eGpaYk19OUnfJ1HBQRg7h6GjvRhaInpQ9d4QDMsV8vilWy4WNv9l6GYH46J7mbNFZYVyTce9WwQ+xb5sG2r4VwcszvpgVp/Oc+K2loHekjF4g17vyrfa6Dv14dsI9AebILc2FDbtKEf9XlpmtoQlH6cahL08T4zlQKhyjIZNavL+WwNJYAtyxHHP+Dj/Uyrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdZFziW/cThW9lnMFe6yLhSW6KtjfcTyBBSE243tqQA=;
 b=JJE8PIKbx2y2QwG0HvxQHZwctcFd9AN2A9/G3/7lWul74UM3dW9CG+3SJulO6SOdBwWx+Oea/RxmOCRd6j8O5Ktgz08YKoOu3kSrT3HGx/sK50VFPjCql8iFvipkT/bvkl4SjqAlGv6MHm1S0b4Tcy8cju5VQT5C5r1cMiRJRCLVcWQ5uLpXIiTjR0niGgOcb5XCElBmNfxidoJ1M14dabSytWCq95PDWiJSctX4QGAKJk2tHLb5dT7auaoKFWyaxtURZ+SHQrSQW9AtkF3/7cZY6dFcG6bATm96a845MggpxWhlCf3FB0RD4WAGs2Br+Ca11XRLgBIXTiFyxtuwAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdZFziW/cThW9lnMFe6yLhSW6KtjfcTyBBSE243tqQA=;
 b=ggPfTPsknYfrRmLuzPYmDygceBvhY9oGL7DaKAO0Bl/TBp5dNKO99ZyFbpDBnu0O53uqOrtrOymUEZjir/+wMft43qKINcBGvUFAlldZMgv2OXwwmqZS/jREIqUkuzaaHwP+5DCYNHAqILZVVLq4Ck3JXrY5O91lNqaWL7Io3dA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SN7PR12MB7156.namprd12.prod.outlook.com (2603:10b6:806:2a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 14:11:59 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 14:11:59 +0000
Message-ID: <9d6a394d-403a-45e0-9351-b9d90c019b9b@amd.com>
Date: Mon, 14 Apr 2025 09:11:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] Add managed SOFT RESERVE resource handling
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 "dave@stgolabs.net" <dave@stgolabs.net>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "dave.jiang@intel.com" <dave.jiang@intel.com>,
 "alison.schofield@intel.com" <alison.schofield@intel.com>,
 "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
 "ira.weiny@intel.com" <ira.weiny@intel.com>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "willy@infradead.org" <willy@infradead.org>, "jack@suse.cz" <jack@suse.cz>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "len.brown@intel.com" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
 "ming.li@zohomail.com" <ming.li@zohomail.com>,
 "nathan.fontenot@amd.com" <nathan.fontenot@amd.com>,
 "Smita.KoralahalliChannabasappa@amd.com"
 <Smita.KoralahalliChannabasappa@amd.com>,
 "huang.ying.caritas@gmail.com" <huang.ying.caritas@gmail.com>,
 "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
 "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
 "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "gourry@gourry.net" <gourry@gourry.net>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "rrichter@amd.com" <rrichter@amd.com>,
 "benjamin.cheatham@amd.com" <benjamin.cheatham@amd.com>,
 "PradeepVineshReddy.Kodamati@amd.com" <PradeepVineshReddy.Kodamati@amd.com>
Cc: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
References: <20250403183315.286710-1-terry.bowman@amd.com>
 <00489171-8e9d-4c97-9538-c5a97d4bac97@fujitsu.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <00489171-8e9d-4c97-9538-c5a97d4bac97@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0022.namprd11.prod.outlook.com
 (2603:10b6:806:d3::27) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SN7PR12MB7156:EE_
X-MS-Office365-Filtering-Correlation-Id: d17ab18b-8591-4891-5840-08dd7b5e51a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEVhRGpKdXFnQnBPekMrQm9YYXcvVnViaGI0My9EZjVRMDdmTytxYW50R0x6?=
 =?utf-8?B?alhXSk1Kdk03Zlc3ckVLOTd2cUI1V2lJRnQrd2t1Wm0wYjBOMFVIOThPRHI1?=
 =?utf-8?B?UzRKdEN6WXd6cG84dHZKaFp3eUtDRTNzM255Rk80cTdHR3hWeGpkWG80VHV3?=
 =?utf-8?B?dUZhUnlSZE1NajlTWndYVGFyaTRmQS8rWktZd2pFZVlScVAzbzBXS0JTUkZp?=
 =?utf-8?B?b2VOYmE4R2t4cGx2QXJJUWN4WlZaVHVKZ2NvU3EzVHE3eFp1d0VHbkU0azZp?=
 =?utf-8?B?T25SVDNNSXVZTUVRVmxhcXphdklYU1I4eG1MLzRUWmIwNGhiWXZNMmdZNzR5?=
 =?utf-8?B?NkgwaElEM2szTHFCSGxCWEVUVjlLL3lERHFpUWFwcm9mWlUrNzFTR294TXpz?=
 =?utf-8?B?Rmt4QUVYTU5SdW5rNmNUMC9TV3lpN1E2WndjRlpPQmhJSXRRTUUxODRFeUFU?=
 =?utf-8?B?eE1qTVpmNjRYbVlYMW9nYjBQcVBMMWJkcklQRVdzT2dKSEpDYXBvNXFXbUR0?=
 =?utf-8?B?SnZUREo4U1NLOUh3YTNVZGFkdTdmRGZ0ZGxxRlRzVXJNWUZHbHZwcnB1RzNN?=
 =?utf-8?B?aDdYS25xanluanBHTGQ0UXlINHBJS05uYVVpNUF0aGQvUjRBR0Y2TEVKR0cy?=
 =?utf-8?B?eWl5d3lJUmJrcTJVOW4xakF4bjdwYS92SDBuRER0VEZDSGdNdEpwRmZXbFR3?=
 =?utf-8?B?a3hpcGxKdnRLSTA5TG9qZzY5bVFLRmJzazllMElFSkxtTDdxRXZWYnlnQmR0?=
 =?utf-8?B?M011MkRaSG9sMGU4TUJtNldIMXNidUJ2RDZ0T1RXbElBMVlZYzE2TlJlcGJo?=
 =?utf-8?B?aVptZHZXMFFIU1VmdDZVUzRZOHk5dllQbFZNenZXLzB6Rnp4RW1zM3JrU2lC?=
 =?utf-8?B?TTdMNk80YWd3VE5ZcUI1TVVyMk1tRlYxQXZuaExXdjlSVUZzbW91WEIzNEJv?=
 =?utf-8?B?TU9lVG9HMUJ2UkNOWGM3MktmeGpSSVY1a3NxUkF6VWs1TzkzZWNVMUk0VlFr?=
 =?utf-8?B?S2M3bER3ZVVpYzBOSjdEclgrOFl0S0FZOUpQTHFUOEVSUzNuakl4ZnBMeUxK?=
 =?utf-8?B?OGsxQUJRckhDcmFwNGFqVUZMNm1wOGxwSEl3SHRVWHI0eGpNN3poOWpGZ3ph?=
 =?utf-8?B?SXVvVHAyd1VOdTFzd2dNejkwZmhBT29Gbk81TXJMR28vWVd6ZjJqN1BZanpp?=
 =?utf-8?B?SU9TZGcxTTd4ZDhkMjlQOHpjcDlLbmdiK3YvSzZrWEEzdzBza1hqcXoySHE3?=
 =?utf-8?B?VFNRdzMvbk1FbnF3d2FSZ2w1WU8rSlFyMmdnMXduSDdsUFZHZEt6em0xcGE3?=
 =?utf-8?B?dmxweU4vL3BVaWJkNzROVlJMb0JlVnJEaHdMNTdLYUg4RENDOWJRZmdoNGs5?=
 =?utf-8?B?WER3Q1lweTFPWjE4OGRYWk1KZFdqOU4vbzc4THNQeVJNcGpYQ2FFNUZxbUVY?=
 =?utf-8?B?REZtdG5lNUQ0ZUcyRm4vUUttd2NQSEtaWjZ0TDgxakYrM3JTbmRVTk9vNzVG?=
 =?utf-8?B?YngvbVBBNzZKM0o0Zm1FcWVvY0hZZlZjcUxaeEtMbmtkS3FYZHVKbDg4ZXVV?=
 =?utf-8?B?MVRQeHpZMDU2ZFFHK2ZOdGVYUG1PcW9qbTJKVzRKWms0RUd6aitRaUJPdmVI?=
 =?utf-8?B?UUtNOGpsaEROdkNQVlZRZmE2UGRqNHFiV1Y2Y2V2Ky9jZ2ZYTDAvQWhuRFg0?=
 =?utf-8?B?K1RSMG45dXA2WXh4UHp6blNNZE9PR1c1L21hbDBBUm05N0VZZ0dCdW92aDdW?=
 =?utf-8?B?bUVjY1VpRkwwdGJ4cTJXR1dzUFF3ZFZySncxQUxYcWZURjdiMHpmVHBKY05M?=
 =?utf-8?B?ZGM5S2xtYkVQQlYyY0xtYlM1YWVoZWpyZ0xTd25rQzR2MlNwQWVSUW4ycDJj?=
 =?utf-8?B?cVFCdUhRd1NiaE9KNkV3cmZMU3NVK21CejluVjdUTDBRK0ZDOFNkeXJMY1Bo?=
 =?utf-8?B?Mk1lN2FESThDZCt4aUpod2dpS2xsaHp1em8xc0xrcUQ5b0E4aS9lSTg1Mk1R?=
 =?utf-8?B?NEdEWkVkRFhnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akFoZi9vcEcxaUY3QThwRUx4U3lLSk4yZnhZcDJvSmdPN21NeGVCR2pwTzJp?=
 =?utf-8?B?VXY4RnRwQUVaZlBDR3VEODIyRFhldnUxMEtKZGx2dXFxQjM3WGNKT3d2aVI3?=
 =?utf-8?B?RUNvU3Y0YUFPcWxwWWRnNkJrZmdnemdZNldQVXFVTzJISXVUT2R3WDFCUVhC?=
 =?utf-8?B?aXhEWHEvQm9YR1lsR1Z6M0tUK0xhN1kyVEJGc3FxNk9JR053ejB5d2hIYUs2?=
 =?utf-8?B?TnRwM3g4eDcwb0ovekZCbS9Jb2lSRFVMRkkrakNiNUp4YWtCbGtyVE1jSHVQ?=
 =?utf-8?B?d21nVktzRXgxS0x3UHR5cGFiaE83d1RybTMrcjRMYVBRSjZHT1V2RzNUWkhM?=
 =?utf-8?B?NmNsTXVOVWkwcENUSkk4R2hNYS9rcTI2REo5U0JaYWlRNHhTZlo2UUJ5Ykha?=
 =?utf-8?B?UWwvYTNYQ2dNL1VCUDV5T2NRdDdhOVF1VWY0R1o5dDlPR0c3dG1qejBTMnNR?=
 =?utf-8?B?NDE0T091dVVTV3JzMFJqRm1HK08yOHAxSXBKd2w5cTl0dWpvUWQ5UDN1dzAr?=
 =?utf-8?B?ck92d2dIN0tRODFIejA2ekZiTG0vWUFuMzljVEo2eUJnOEJGZW1DTW1nS0cr?=
 =?utf-8?B?N2txNTN6QmMxaE5VS1BLTVNTNjg1S05od3dlNWZQNFRZZ2dCcWhCNXJLL05m?=
 =?utf-8?B?b1NQZDZDWWJNcGpFdERxV3ZyRllsaWczMDZiMC9KcEx6c3ZTUEphZGEveG9j?=
 =?utf-8?B?elJEN2k4alhJd2M0Tm5WVkJkaHJ5ajZkOCtWNUlYSlRDOW9vNVAwNFR3akNx?=
 =?utf-8?B?RVUyNDA2Ukdnc2d2WFhNa1ZWWTYyVjJIOFhCQ2hnbnJFb1VZU2h2RWNRcWM1?=
 =?utf-8?B?OFFHNjdJZEhnWGJOVG52L0RDcmZNYmcxejB4YnJ4cW1HNnZMRDllYmV3ZHh2?=
 =?utf-8?B?MEZOV0UxajZvUmVNNXRlc0pGTTRoTnVFTEtLcE0xOFlibkp1ZTBtSlp2NWgw?=
 =?utf-8?B?NHczeW0ybGFSd1E1cFYzQkNxN2s3UTMxcHlRekdMRjZKeFFYWXQvY2l2dmc3?=
 =?utf-8?B?bjYrd2U3R0dJM09WdFdZTTNzWnV3dVV1ZEk3dFhhSU5zckljYk9TL0lzd0Qr?=
 =?utf-8?B?ODRNZVgvbzdFMWZ6L0F0djgyR2Y5TVNma2JhRkluQU5ramJMK1lNd1pGRENX?=
 =?utf-8?B?SFNGUmhzSEVkM3JneTV2TGk1TUJaZ0FOK2RSYnJwdFIrbFBoTVdvd2FnNDN2?=
 =?utf-8?B?V0dtQWVwVW01c1p2cDJYZTJmU2twdDlQRGdTVElzdndkRFBFT2VjUHE3S3FO?=
 =?utf-8?B?VmJxNjBEQ3NKbE5RNTBiR2JNSjRndEJ4NzgrSXgxem5RY3lPb1d5cTY3eWNY?=
 =?utf-8?B?anQ5TURKU1NCci9BbFBCSVVFajV2d0RkNTlLVFB3em9yQXpBb09WcmlNaXlW?=
 =?utf-8?B?T29GNEhkVjlhbTZJL3RjY3l0dDZsVUtiV2JhRnE0S3FCa1hpd2xDcUhmWEV4?=
 =?utf-8?B?RTJhZHQ2T00wbTlWMWM4RE5iYXlDMHBHQ05MZGJhemJSemdqdnY4cWR4S3cw?=
 =?utf-8?B?YktaNHpyQUduTm1rVFFDM1RhT2lUMjE3S01ZTTIydWVpbjZVVXJ4ZzBoUmRS?=
 =?utf-8?B?aTdXWHZGOU8yQlBJR2tEdjBXcWs1UzJvd0lYcUZkQjFjRW1yekpFcGgvVVhE?=
 =?utf-8?B?RTQzVS9PT0I4ZkE2aWpyNVM5RFdFZjA3Z0RzUzRUUDNZbVRuT1FWQi9Vd0RR?=
 =?utf-8?B?QjFYNGZia3pTTXBMY3BRNUdLWUs2RDREMTBjUXNnREE3Um9QbkZycFR2VGk5?=
 =?utf-8?B?c0x3dWZIcVE5L1d5TFFIakFJNVBlMDdURXpuSGpvRExFWUFkQzZlY3poaDR6?=
 =?utf-8?B?RGJKaC9FRW9LajE2dlJSTVRwVE5YTE9kNDlQL2JnaSsxajZJYmZHTlpidHpa?=
 =?utf-8?B?OUpYbUw1Z0lNMkxsNHFrOHJHeWE3UmFaWHo3ZDRDSkpkVnJRcHNaYUcyanRj?=
 =?utf-8?B?eHcvc3ZZZ0ZTUStXUFpSVjBlT3NUOFo3WjhlZWlXdDFFb3YxaXRYc1NRRlVu?=
 =?utf-8?B?R1RWMVZ0a3J2VVc3Sm1KQ3BsN2RpOWhPMUZNaUR2QzBHNUZHR01DRHZaSTQ4?=
 =?utf-8?B?K1laYlpqY2FKRDdQVXZxV3lvZFl1MVBCM0FmaTg3NVBjU1JNZ1lIY3hlN1VT?=
 =?utf-8?Q?ugtPzRBVtGUYg0wQk1xtfoBdW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d17ab18b-8591-4891-5840-08dd7b5e51a8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 14:11:58.8016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dZ+bOQZ8w/ix2p3/LbR8J55iJaRm4tToymscLanZVr0wXyfT+5sFqC2e2YTzuQs5w8Wz4Q5DQrKlCVwB60mjZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7156

Hi Zhijian,

We recreated the failure for the cases you mentioned below. We will be 
adding the fix into v4 I am working on now.

Regards,
Terry



On 4/7/2025 2:31 AM, Zhijian Li (Fujitsu) wrote:
> Hi Terry,
>
> If I understand correctly, this patch set has only considered the situation where the
> soft reserved area and the region are exactly the same, as in pattern 1.
>
> However, I believe we also need to consider situations where these two are not equal,
> which are outlined in pattern 2 and 3 below. Let me explain them:
>
> ===========================================
> Pattern 1:
> - region0 will be created during OS booting due to programed hdm decoder
> - After OS booted, region0 can be re-created again after destroy it
> ┌────────────────────┐
> │       CFMW         │
> └────────────────────┘
> ┌────────────────────┐
> │    reserved0       │
> └────────────────────┘
> ┌────────────────────┐
> │       mem0         │
> └────────────────────┘
> ┌────────────────────┐
> │      region0       │
> └────────────────────┘
>
>
> Pattern 2:
> The HDM decoder is not in a committed state, so during the kernel boot process,
> egion0 will not be created automatically. In this case, the soft reserved area will
> not be removed from the iomem tree. After the OS starts,
> users cannot create a region (cxl create-region) either, as there should
> be an intersection between the soft reserved area and the region.
>                               
> ┌────────────────────┐
> │       CFMW         │
> └────────────────────┘
> ┌────────────────────┐
> │    reserved0       │
> └────────────────────┘
> ┌────────────────────┐
> │       mem0*        │
> └────────────────────┘
> ┌────────────────────┐
> │      N/A           │ region0
> └────────────────────┘
> *HDM decoder in mem0 is not committed.
>                                        
>                
> Pattern 3:
> Region0 is a child of the soft reserved area. In this case, the soft reserved area will
> not be removed from the iomem tree, resulting in being unable to be recreated later after destroy.
> ┌────────────────────┐
> │       CFMW         │
> └────────────────────┘
> ┌────────────────────┐
> │   reserved         │
> └────────────────────┘
> ┌────────────────────┐
> │ mem0    | mem1*    │
> └────────────────────┘
> ┌────────────────────┐
> │region0  |  N/A     │ region1
> └────────────────────┘
> *HDM decoder in mem1 is not committed.
>
>
> Thanks
> Zhijian
>
>
>
> On 04/04/2025 02:33, Terry Bowman wrote:
>> Add the ability to manage SOFT RESERVE iomem resources prior to them being
>> added to the iomem resource tree. This allows drivers, such as CXL, to
>> remove any pieces of the SOFT RESERVE resource that intersect with created
>> CXL regions.
>>
>> The current approach of leaving the SOFT RESERVE resources as is can cause
>> failures during hotplug of devices, such as CXL, because the resource is
>> not available for reuse after teardown of the device.
>>
>> The approach is to add SOFT RESERVE resources to a separate tree during
>> boot. This allows any drivers to update the SOFT RESERVE resources before
>> they are merged into the iomem resource tree. In addition a notifier chain
>> is added so that drivers can be notified when these SOFT RESERVE resources
>> are added to the ioeme resource tree.
>>
>> The CXL driver is modified to use a worker thread that waits for the CXL
>> PCI and CXL mem drivers to be loaded and for their probe routine to
>> complete. Then the driver walks through any created CXL regions to trim any
>> intersections with SOFT RESERVE resources in the iomem tree.
>>
>> The dax driver uses the new soft reserve notifier chain so it can consume
>> any remaining SOFT RESERVES once they're added to the iomem tree.
>>
>> V3 updates:
>>   - Remove srmem resource tree from kernel/resource.c, this is no longer
>>     needed in the current implementation. All SOFT RESERVE resources now
>>     put on the iomem resource tree.
>>   - Remove the no longer needed SOFT_RESERVED_MANAGED kernel config option.
>>   - Add the 'nid' parameter back to hmem_register_resource();
>>   - Remove the no longer used soft reserve notification chain (introduced
>>     in v2). The dax driver is now notified of SOFT RESERVED resources by
>>     the CXL driver.
>>
>> v2 updates:
>>   - Add config option SOFT_RESERVE_MANAGED to control use of the
>>     separate srmem resource tree at boot.
>>   - Only add SOFT RESERVE resources to the soft reserve tree during
>>     boot, they go to the iomem resource tree after boot.
>>   - Remove the resource trimming code in the previous patch to re-use
>>     the existing code in kernel/resource.c
>>   - Add functionality for the cxl acpi driver to wait for the cxl PCI
>>     and me drivers to load.
>>
>> Nathan Fontenot (4):
>>    kernel/resource: Provide mem region release for SOFT RESERVES
>>    cxl: Update Soft Reserved resources upon region creation
>>    dax/mum: Save the dax mum platform device pointer
>>    cxl/dax: Delay consumption of SOFT RESERVE resources
>>
>>   drivers/cxl/Kconfig        |  4 ---
>>   drivers/cxl/acpi.c         | 28 +++++++++++++++++++
>>   drivers/cxl/core/Makefile  |  2 +-
>>   drivers/cxl/core/region.c  | 34 ++++++++++++++++++++++-
>>   drivers/cxl/core/suspend.c | 41 ++++++++++++++++++++++++++++
>>   drivers/cxl/cxl.h          |  3 +++
>>   drivers/cxl/cxlmem.h       |  9 -------
>>   drivers/cxl/cxlpci.h       |  1 +
>>   drivers/cxl/pci.c          |  2 ++
>>   drivers/dax/hmem/device.c  | 47 ++++++++++++++++----------------
>>   drivers/dax/hmem/hmem.c    | 10 ++++---
>>   include/linux/dax.h        | 11 +++++---
>>   include/linux/ioport.h     |  3 +++
>>   include/linux/pm.h         |  7 -----
>>   kernel/resource.c          | 55 +++++++++++++++++++++++++++++++++++---
>>   15 files changed, 202 insertions(+), 55 deletions(-)
>>
>>
>> base-commit: aae0594a7053c60b82621136257c8b648c67b512


