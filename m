Return-Path: <linux-fsdevel+bounces-75745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBmKB+42eml+4gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:18:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE384A5675
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB79D30B7C98
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 15:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A1F2F7ACA;
	Wed, 28 Jan 2026 15:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eLzmjl02"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012018.outbound.protection.outlook.com [52.101.43.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD7E2DB784;
	Wed, 28 Jan 2026 15:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614807; cv=fail; b=hl1BKeNN1w2+ka6gVhevNTtn9x9hcyEd0AZlq3TNnsgxfatMay1dxEKaxPSgsxi6Z29uyZYsPHp8zj0EBb0QCe1qPwNeA+EKjeP/dXx0F3zW59/pfnDw+vqwH+jAirSG/xZXkC32MYlgibC+7qKSewySF4bG4AK2zxwe2Hkt/Sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614807; c=relaxed/simple;
	bh=sG67u10d0l+481xemmJVI66Bhfz8ArJE8oKGpyV0jic=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W6HkuvWdQdZiLwHiugzx/dE/0mMwgETWo8et3fla8RXlCh/QHtiyb74Kkbfop8aeiJJrUxC3P5bFTJERz2fymhMJgQ0hyZJd4GzZX0c+eIvb6fTDdpMFkJD1zQN9kQYpylsL4xqNa1NPp73mrWZmuIw/GIfiVA1Q1z4+jERfpMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eLzmjl02; arc=fail smtp.client-ip=52.101.43.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WbdRGYnX2xzlMHGIocq96TCQux0yfaoJlLo3qIst+znxCgurbwgmC59Bz95Me+qvBrqGZIb+Im/KNL0TA0p7DazeUVV+29qzOlNT6ux0fciedtei20Rtp+MGvqoB9KP9sa04NQOPYEP1TVKjZ17EHjoyjt7SAOrtvholujLePVoMyytV6G+UCAQT5+ows8gwcg5rXJHh9l+7fnKb6afr+1N06FSN3w70k95Y2TKbHApQccSlaBBSW5XZ8mfE8e9s6vMHIL9ZsqBtzI3kv5n+IUuGBD3yXKS0ipPH+r3M0t8AtIDIlFFrc3hx8PNZpyuDpTmcTpROLHHz4r3Cph9ucA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVKbcrgDlTXfxg2hRJn25jqXKlpA4hcKgyyO2hFUn30=;
 b=L9VNY4kzoQ4dqp94hS8Op4wxHZa7rgft0VXZxPgckq8me6cPGb8uF6xLF4sOus7M5pyYqEJ3neDGugYRkj91TdBfK1XCYQ2ppohWcmsWxDCOo+qgCOCECzQPywtmDpGimC+n2O8KqE6S7YSd8RXzPx7XMrP5UwnMlmfRowDVfLSvVlIX6y5bJjqLnIHOd3mlLkhHbGjQmolUAUqXGNmEYnGbV2+oKtj1zKl5e3rvj8/m0IZePhECmx3HsQf2JZCB+1PJ0Uj4IwAIFXSRCDDdnRG6VH4n89dT0kWlYJhgveJJcmzKAFvnNkURkUsB7BjUThsuAXJVXkF1pCFXzy88EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVKbcrgDlTXfxg2hRJn25jqXKlpA4hcKgyyO2hFUn30=;
 b=eLzmjl02/QWB8Ia/w3oO41QFd8jvUr04v9ODgOjC7mV48UVSCi1H09QwZ6aWWGoyTWLDV7wU9UghC4nwzZOkIKi2bcrk8PfqluV1lU4NowRFk/2fqfgPP/ttu9wQwWyQ1SIFmQYMirf3YSCMMoHGAVBs9AXcMMAoJfMvmiiCRfk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 28 Jan
 2026 15:40:00 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%4]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 15:40:00 +0000
Message-ID: <04e92860-e616-4e74-a349-1397b3a0db81@amd.com>
Date: Wed, 28 Jan 2026 15:39:51 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/7] cxl/region: Skip decoder reset on detach for
 autodiscovered regions
Content-Language: en-US
To: dan.j.williams@intel.com,
 "Koralahalli Channabasappa, Smita" <skoralah@amd.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Matthew Wilcox <willy@infradead.org>,
 Jan Kara <jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Jeff Johnson
 <jeff.johnson@oss.qualcomm.com>, Ying Huang <huang.ying.caritas@gmail.com>,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nathan Fontenot <nathan.fontenot@amd.com>,
 Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
 Benjamin Cheatham <benjamin.cheatham@amd.com>,
 Zhijian Li <lizhijian@fujitsu.com>, Borislav Petkov <bp@alien8.de>,
 Tomasz Wolski <tomasz.wolski@fujitsu.com>
References: <20260122045543.218194-1-Smita.KoralahalliChannabasappa@amd.com>
 <20260122045543.218194-4-Smita.KoralahalliChannabasappa@amd.com>
 <20260122161858.00004b0c@huawei.com>
 <9c5150ba-c443-4ce1-a750-57736f0dabf0@amd.com>
 <69794c2512bfc_1d3310087@dwillia2-mobl4.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <69794c2512bfc_1d3310087@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0221.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::20) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CY8PR12MB7705:EE_
X-MS-Office365-Filtering-Correlation-Id: ec3918f5-06e9-4cfa-8e01-08de5e837f0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFNMZE1tR2ZNYkpuVVVKZlY4NVVwdERlakFaeG41UENEQ0lINDJmb01BV3dJ?=
 =?utf-8?B?VjBrb3o3TmU4Z2tmM1creDlRaE1zbmw1R1BTSCtsNW9tbjBFaEtiMEtRUDJn?=
 =?utf-8?B?R09YeU5UOXpYOGVRcm9QZWJSZXE5N2xrcGEvdkVVcUVYZkJxRXp4OG5pOFZ0?=
 =?utf-8?B?NGFXSXlVd1Jpa1pBSnY0YXBXRUtOblczL29IbmZTM3ZDWENlQVFVRVVVbXpP?=
 =?utf-8?B?cWRVNnhabFVObngrREJQYU9BU1lUbm1FRjZidXluL1EzZFcwRzI4dlpxRGEz?=
 =?utf-8?B?eHJOdVEwVVhnSThYZmRxemhUNlVzVEgweVZ2WGJOdVBWb3IxcnNHRFYvU1lV?=
 =?utf-8?B?QytSYmJQSEo2NDhmdnhNZlB3MVRjSFFIWUEyd3JpUU9sbmc3cUN6OXhjT0VK?=
 =?utf-8?B?NVF4SithZmtvVG83QVBEK1RiV0ZYMTdybTNEQ1p1cXVHc1hXU09xMG9zVW5p?=
 =?utf-8?B?SWp4Qit3Nk9zMnhjblNIY0I3Vk1YUUhKZmpzR2ttUCsyNDNhSzVrd0tiM214?=
 =?utf-8?B?RU1iVjhvS2pQQm5YL1lBUkhNbG4wWHRWZ2JqUkJnWDFFOUZPejl6RVlFWW9C?=
 =?utf-8?B?MXVNQ0hydnZlUFlJVnMwMGkzNXpSMy9Ucnp3cEVCd25MaXlEYnZxLzE2akdq?=
 =?utf-8?B?TnhxN2pTTCtIM1dNSURXaWh5NEo1NVRKSFFLVFh1dUNoZmpxc01Ra1NRazdM?=
 =?utf-8?B?QUpCaWxsalBVWDdHcy9UTXB2WnpoSVQ3NVhkL0tsMk91d29OQ0I3WHJIcUx6?=
 =?utf-8?B?eWhOSkNKNEFZL0RWZWtwWEp3ZFFiZDNhdmhlRDRDZjVDWVBTbzJCVWlsVmlD?=
 =?utf-8?B?RUdDRlBhZWUyL1hNYXVrMUpQcjI5a0M2OE9MUXJnRFc1M3p5OGlhSmNKSHJw?=
 =?utf-8?B?NU1kWTk4TCtKUHVyZzZsRjVMM1FNWi9DV0RKVkhVWkJmclJLVk5GNzY0UVV5?=
 =?utf-8?B?VFQ1T1RNVVRGWFBYMFdiWWJub3JtOWpVS1pQZVgxYm1TaVFkWE5VVEZWS05J?=
 =?utf-8?B?cjU2b1o4cUFTTFBtNVp1dHJkWGNhSXc2L3BLdWRpL3EyWEp0bWlCTURyVlFU?=
 =?utf-8?B?VlVTWkhPRjNyZVppK1ZjdXFocXlOQ0xqbXRSckFhUWxLWmFVRjBZaCtpWHJW?=
 =?utf-8?B?U2Z0UFlzb0pDMEk2RHFYT29Fc3A4d3lvaG5zNE55T1VvdnFERWx1NEx0S3F2?=
 =?utf-8?B?d1BnbTN2cHoyNVltQ2hhSXlHWDBSRENaOTVMMnV4TGVqRUJGSm5qZUlvSlY1?=
 =?utf-8?B?UFdIL0I1Qy9QUjZvcVU1aUdaZ0llVDB5ZjlnUG9UVlNvcGkvcU41RnVITVFO?=
 =?utf-8?B?VFFJSTNIRnZQdHkybUNVanRwV1RaK3A5VVhiRUVLTFV6Zzc5ME8xK0pXL3Vy?=
 =?utf-8?B?dTRaSVhQYVgrMjBOZG1DM2w5ZUZKSVFhUllrWnAwQ0hUa0pleFkxL09sT0Fo?=
 =?utf-8?B?RWhPM01IS1dxUUQ1bVlDOUp0TVVmWDlENnBhUExVenlRb1lOV2dVRVdGYkZN?=
 =?utf-8?B?SWFNQkJtN3N1V1krK3B0NHdLTUZwNDdPK0RiVFdqQzljV0kySjlwT0NjR0hq?=
 =?utf-8?B?ZmNLQXNXT2FDc3hFYTVFdWIvWjZsOVJkYXZQYkpVNHBoTUF4dHZQdjNLNUFx?=
 =?utf-8?B?UWhyT3VYVkhRN0tvRytLRVliL3NBOGxXRm5udkU1dkRFZkwrMi91eGFDN00z?=
 =?utf-8?B?WEN6OHZreWMvTzFuYmhMMG5Ma2l3QTJyamhpTmpGc3k3djhmSnJYZTRJcmJM?=
 =?utf-8?B?eW1aNUgrNDdlU1FSa0s5WitBMWJia1AzQTdLSHBNWm40TmN0bVFFTkxSNDRj?=
 =?utf-8?B?ZWlMVk53OWg1WHVaTUR2d3JzZDYxQWszSUN2U01EdEQzSUoycGZqQTAvQzZp?=
 =?utf-8?B?RkVzUGVObU5RMnU0b2tYdnpBS0hyT1cvMDNhMjNxYStDMTJmd1dYeE5Tb1ZB?=
 =?utf-8?B?TER1V2xGNGdmRWNYS01VNVpWWlF5YXVHN0xEcnZEMkU0VlUzTEZGQ2hzQis2?=
 =?utf-8?B?YVJ3bGd0dzlKSG9XTGErK3J1MURXZDZOMEJtamEyMnc4emFjVjBqK04wREE5?=
 =?utf-8?B?ZGg2QVJrVDRSdzVOeW9TUXNzM01jR3gxZ2hQTnBqRW94eXhLT1VRdm85dVZM?=
 =?utf-8?Q?OVLY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0RSWGZ3dFdJbTdDRTJjMlZhZG43UnhDV0lMbTRWYTVqQjk2VS9HSllJVmRS?=
 =?utf-8?B?Qkc0SzNKZGx6Z3JMM0FXU3BXMktZYlZaTDVOSjdtRGlUb3QvRlRyWVJlR0ps?=
 =?utf-8?B?T2FUSTNmTWlHdzJqZmFtTGg5TURrODI3a3hXYXEzSUR2aVV6elJwSGtORUtV?=
 =?utf-8?B?U1g4WjBnMlpwaXM2SDRheFQwb0VWYmIrbnk3TkhIRlY1aC9hZ0UxSlpKeHlQ?=
 =?utf-8?B?RFdTT1FIVUVqVU1HS3drS1dGMWtGa1lOTUIwRU9UaTJmRWhiaEFnOE5qdklp?=
 =?utf-8?B?RXo3TmJCcE1uZjJwbEVlMUtWY00xcnRwSm8zOUJSNFBLV0FyaFNlU0hXS3F0?=
 =?utf-8?B?bHFsRnRRQ2t0Q2xWVzExRzAzMVhyakIzTGhmcGwzK0FxWkU0NmhiS2NNcS85?=
 =?utf-8?B?NE84N05KdzEvQThzaytJT2Y1L0ZWME5QZmlsVTFXeEx3QUVMNWptcitVRXBx?=
 =?utf-8?B?cGN3cThmZlhMaldIZlRrNTBMLyt5Y1oxVzhrYWxkcVNQL1ErVW43MzE2KzZa?=
 =?utf-8?B?WkRxOGdiT3hsdmdBNG50cURSN09RWk5lNXVkWUx4MXp3Q3VPbHkrbXM1dzRh?=
 =?utf-8?B?cnUxdEgzeTFxWDhKazlEN25oWHhaQzNUSFhvRThqWjdtaDB1ZDJyRkh1ZFAz?=
 =?utf-8?B?cHgyM2pJVFNoUE04VTRZS3dWSGltSGNPNFc5UkRZNWhLV3paazJneDJ0YURF?=
 =?utf-8?B?THl5ZnVrYXZZYnFMdnNmazk0OHg4b0ZISUxkOTlTK0w4dmhzVU4ydS83UVRM?=
 =?utf-8?B?VWVMVnU0RmFxbFZsME14RUZXVGhBOFVZdXloRExQMmdGRTJweXNPOWJlMEVD?=
 =?utf-8?B?bThXeU5VUGh1OFE5OERiTENSVWpJeC84a2YvV3FLTFpaczcwRVE3ZHJuc1dH?=
 =?utf-8?B?bS9oYnQydlQ3cXV6Z1BtbVFkT25LNm01dlAvUUtTREoyYm5wY2szbHVuTThZ?=
 =?utf-8?B?TU54Y2N0VUlCT1E4N200N1E3TjFNT3BLTFdjRkk0azJQajhuRWxkV1lha0w2?=
 =?utf-8?B?MURPOCtLTXk4b3VzcjZuTmp1aUZaSWtleFZ0OG5ZcXM3NUp3U2M5ZU1zYnZC?=
 =?utf-8?B?dDQ2d0dxU255bm10ZFI4NDA4cEkvY2FoU2pObDFlWVdmd2hPcCt6SGpCRTR4?=
 =?utf-8?B?TzBObEZJZTFRQmkvQVBOcHIwa1EwSmpQQ1lHWW1GNG9kb1pQTGhNUUhIVGpJ?=
 =?utf-8?B?NnBlYnQ5UHhvTmsvWjBzWDdHaGNFYTB3aDhVSm1ia3ZEMWJiL013SDFIaWFD?=
 =?utf-8?B?ZDFna1FadDhPYlVmRUx4VFBPVmFMcHQxZTRVYWpaamR4NHNWelFaTTRqYzNE?=
 =?utf-8?B?eDNoQUcxekZtaXlLSXA4T2dCeHVXb0ZtRUZweG8zZzh2NlZKdjEwaUc3eVZW?=
 =?utf-8?B?M2VPUlhYWHpqeW9HeE9TNG1PZGVFeFNGWXZGcUhiYUtWWkFDT1Y4UDIxb3NJ?=
 =?utf-8?B?VGpSVjFBeWhEVEtPYWFlNEVxTFN0Zmsza2lrVFBmRFRUZnFrZFJOOSt4ak5n?=
 =?utf-8?B?ejNhYmVUZlVtR3ByWkNaL1dweUtTWE1iWE9WS1F4aWZMQnYvWU5rTjFPQ2Ry?=
 =?utf-8?B?d21GcU9QTktjSDRFWENFVjFERjZ2em1ORHViYi9rTDErVVEvMVI1NVp3K1lj?=
 =?utf-8?B?WWJGTjc5eDVpWnB2SDVkTkxxbTBVT3BtMURvOURDYWEwVEt5L0k4NkgzVnpV?=
 =?utf-8?B?ejQ5UWR3RUpXZXVXUHNMbFVWamVWTzlJN0U5cDlCdzlNMS9tdElUMUFGK1pk?=
 =?utf-8?B?cmN1MlA3MkxJck5wMkVIZEhoSU1QVzVaUklIdkxGTXp2c1h3QlpRMGF5UFhZ?=
 =?utf-8?B?a0pFY3QxVlh1UkZLbi9JazNZYTd3NzVQbXBHQ3ROcFVoZ0Y4WjVDb29lVm0v?=
 =?utf-8?B?enowTlVEQWI3QnI0dmYrMm8rRVVEU01BS0tXb0J1YU0raTM2OElEUjBsK3JY?=
 =?utf-8?B?Qm9xSm42cGllQ1RaTnp3Z29NTkUrREtQM2RvOVV6cTIyOEVlb2VIN3l3Ykx1?=
 =?utf-8?B?MDMrOHRFOXpOb0JiaXZMRHJKNEtuVm5VQm9wcnp3QzZIQTc2VVFHbE9tcVpW?=
 =?utf-8?B?YWRCRndmYzF5SUo5dnFnYnlJN0pGN0NQTGoyWmNoWHR6Uno5Qy9RZDByWkJJ?=
 =?utf-8?B?VFFRY3BLUCsxc1lET3U0T201b1FNQ05VR2VSTGFKa2NDTGYyV2xwSTlwK1NX?=
 =?utf-8?B?dHpXRExkVVRPeUhrd3IvcDNiMUxuenhmaWZNUDJXREtPZFliS1JFWERDNlEw?=
 =?utf-8?B?Q0J3OXBUaTl3QUdWZXUrb2lYSXZRZ2hnZTd4VS9mQm0reW9oU0Qza2tJYWNk?=
 =?utf-8?B?VDlITEJIQ05KZ250Y3F5c1hGN29UWXZ1MTJ4L1YrSGlHZ1ZzZktsUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec3918f5-06e9-4cfa-8e01-08de5e837f0b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 15:39:59.9774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zs6eMMrInNyfqgcH7PbliIdxZepiky+bAweublYDwrLQYoHJ7YY3HSBpVKHV1auqnrDZy0Mddr5IJJSJxAxT+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7705
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[34];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75745-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,intel.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alucerop@amd.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: AE384A5675
X-Rspamd-Action: no action


On 1/27/26 23:37, dan.j.williams@intel.com wrote:
> Koralahalli Channabasappa, Smita wrote:
> [..]
>> I’m re reading Dan’s note here:
>> https://lore.kernel.org/all/6930dacd6510f_198110020@dwillia2-mobl4.notmuch/
>>
>> Specifically this part:
>> "If the administrator actually wants to destroy and reclaim that
>> physical address space then they need to forcefully de-commit that
>> auto-assembled region via the @commit sysfs attribute. So that means
>> commit_store() needs to clear CXL_REGION_F_AUTO to get the decoder reset
>> to happen."
>>
>> Today the sysfs commit=0 path inside commit_store() resets decoders
>> without the AUTO check whereas the detach path now skips the reset when
>> CXL_REGION_F_AUTO is set.
>>
>> I think the same rationale should apply to the sysfs de-commit path as
>> well? I’m trying to understand the implications of not guarding the
>> reset with AUTO in commit_store().
> Linux tends to give the administrator the ability to know better than the
> kernel. So if the root forcefully decommits the region, root gets to
> keep the pieces.


I have been trying to figure out how to preserve the decoders for Type2 
auto discover regions since, I think, this was demanded after v22 sent 
upstream. This patch/change is what I was looking for, and although I 
did implement it in another way requiring "consensus", this one seems 
good enough and already discussed and approved, so all good.


However, I think it would be also interesting to give the Type2 driver 
the option of resetting decoders as well, what I have been using for v22 
and successfully tested. But this change will preclude that other 
possibility, so, what about an option for clearing CXL_REGION_F_AUTO by 
Type2 drivers? If you want this only to be done by admin/root, I guess a 
module param would do it.



