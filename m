Return-Path: <linux-fsdevel+bounces-21135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D5F8FF73A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 23:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1438B28319E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 21:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D5113AD0D;
	Thu,  6 Jun 2024 21:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZnWW6/E4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2076.outbound.protection.outlook.com [40.107.100.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580344594A
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jun 2024 21:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717711060; cv=fail; b=AuKAlf4qFvy92OULhMZEUlGhCTJG2o227dFYOjBuduLy0GNRLsjsk78lINkn+h8RwAFRtT6c0vUOtw0DBMSD6HPl0+//KOlJuOROo0c7S0MW3hBQd158bUfb0qnDwHtHucnEy+UHMwOGE6TGJQCuc1xPNXzSr/1n3rJWg+VYl7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717711060; c=relaxed/simple;
	bh=H5GMERuqyXGMUjnjHLE8CfOPo5Ra23XDh/wikLkptvQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MY/fMsEn7AOyUhyMSnLQJtQOIs0D0Lw0EvAVdT1Vg3wE6xkF+CYOAKFrRfbHMfxXBmIR+4X9VqeWnrTofFOGJNviqfdVZiCtaKmpbITPMEv6yWVprJLHM3RvG3xPHB3UYCAzw0FkIdKvUe7tZp7Yc6QSni3I+bJ8YboJHIJfyCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZnWW6/E4; arc=fail smtp.client-ip=40.107.100.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QB7YxC2dRrsK3VHftserB2RIN+0wgh0/uR7lpbeTQzsHq8cFFjL7v+ezuNCf8rj8xdiLsrOfdZleGeo3veygmoeHTxrkVaav3BtVOk/fa8vQ2LrPDn5o1Q1FKs4QEkulZacLEXRoxGHf+F5MFKLrbDE4xXHaVCmt75+a4+606EFUCWQtC1Q/0NtjDTQfBO7bd2DyoO5ZAn0896t7Qkzk9KNWr9n+fo76JyyRappWmn48Zjk3OkKERzdbIIaP2dXoCfzRonL99ucFujqwIC1vRn7WMTiXfYxoZqiES9vZmkecI8Evgk/eAVkzkyQB4E2qcTmwXlbIZiCGfQE/QSFGVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxbXtup98j6NNpNARdbY3MHuvrrQOJCCGOA7JFWEmiA=;
 b=a45XAO3WLvds7UXx563RBZeD1+Nz0XrVF8To6BRbDCOlQ3zKWSUDS7SHLAV+wEeFW39xJSvfLRgeoTf+m3IUz/2qV+eZcOKE7YiFz1gMv/fgjD/uQYDQoaGkNF4OF0Q5RjSVfL1wOPc+NxmPC9TfXV9zqxFwPWpu9Ug/pbmbMhn5J4EFBDXv+m+0uDRSde+5CsDja5tbNS0pH16s0ggAi/YXhdciVv1RIII5tEejcw8bcXFd/Pv4y0zXPFd9WC4hSLk8snm7PqopBShoJQIkojo+XtWgckyCXbhUPAcvViMXPnDcA5e0du3yWl0alIIt/Re1t2nCsS8D1k6uxiKL6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxbXtup98j6NNpNARdbY3MHuvrrQOJCCGOA7JFWEmiA=;
 b=ZnWW6/E4sJUQSjRAZ1hNfblQZ2Qn2ywm0tkrglbBGeStWUCN7yVPthcUIAwm07OUGBOFgDZDGi2u5KGHAYZ9CAPj/KDJcsVaxQOsupd7zn6wM1L66d7kR57NG1acfibZXgzNb/lHXxf04ZXvSX2YaAcvpOQpNtxs7tgour5C9l0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH8PR12MB6988.namprd12.prod.outlook.com (2603:10b6:510:1bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 21:57:31 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 21:57:31 +0000
Message-ID: <c3562e62-cdcc-4955-a103-50aee438d5eb@amd.com>
Date: Thu, 6 Jun 2024 17:57:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2][RFC] amdgpu: fix a race in kfd_mem_export_dmabuf()
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Al Viro <viro@zeniv.linux.org.uk>, amd-gfx@lists.freedesktop.org,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>
Cc: linux-fsdevel@vger.kernel.org
References: <20240604021255.GO1629371@ZenIV> <20240604021354.GA3053943@ZenIV>
 <611b4f6e-e91b-4759-a170-fb43819000ce@amd.com>
 <f5d487a7-fd11-4fb2-8301-74f74b0a2257@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <f5d487a7-fd11-4fb2-8301-74f74b0a2257@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0904.namprd03.prod.outlook.com
 (2603:10b6:408:107::9) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH8PR12MB6988:EE_
X-MS-Office365-Filtering-Correlation-Id: 36b2a3ed-775d-4aa4-a93d-08dc8673a9e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3JzczIrZzVlWUhxcHVTdEwzYVVrbzJ5WjNKVm1ER0xFaHVJbVFWR0xrWDVN?=
 =?utf-8?B?ODZEcUpFK044bDE1M0lpQ1dRZjYybHIzTnN5Ui9PS1ozQ2RDZDUzYTViSGs4?=
 =?utf-8?B?ZVdBQ0VQOTkvZkV3MnUyeUZpWVFxZ3JtK2dwNmgxV2daZW54SG4xZzF6RWlB?=
 =?utf-8?B?MkVSeVpzb24zZUxWbFlPdWh3Sm5UYTFjTUlOQnFLYXlPdlJtS01PaHBzSlRH?=
 =?utf-8?B?dzVvUnJaQ0ViZmF0Q25NSU1lZ2MwZE54N010QWc4L3VvTXBKYXJxSDZCRHB1?=
 =?utf-8?B?d2xBanV3VmlvVkZYa1ZZYTNLTGdiQXhSVDAyMTFpdUM5TGZvQ3o1YmxSZ3Jo?=
 =?utf-8?B?aDlGZWxZZTJCa2ZXektOcmFaU1RVK1hXRGhLZDhzMGxlRmZOZWpGd1ZrRU5H?=
 =?utf-8?B?Rk45dkNTTTNIYlZORzU2eVBLMkk0VituSmRZeEpDZFZJNWo4Qzd3bThJR2tp?=
 =?utf-8?B?WVl0R2R5SHRqYmM5eU5TZStoZnRDYjR4RXRYR3ZFS25kSnFrNktFbXltbC9U?=
 =?utf-8?B?d2Z2d2thYkVSaXVWYnNkaEVaK29sdXNyWS9SeFliNkRUbDl3dXpHc0EvN2Ji?=
 =?utf-8?B?UWI0K0QvUENZVnl3UU80Ky9jaEJpYisxM0I0cW1qa3ZndWhaYkIvdWdsUmVL?=
 =?utf-8?B?WkRNNGw1cVRZc2dRQWZsVi9YcmdpOWJCUklCYzl3OWdXM2tNYTUvdnVESkRt?=
 =?utf-8?B?Y0pWUlBwRG9XaW1RK2R0cnhjY3lYYzVBaVBFN0hrYWRMaFBuWHFmSUxlaktD?=
 =?utf-8?B?MFlCcFk1RTlwcVpQVEs3WnUvR2lUUEVsMlkwdW5uaDNyaW55c0JtS1pWR21v?=
 =?utf-8?B?dWdRK1dWMldRRXYycGRRN0ZYeEx0b1J2YU1nZytWOHNTd2NHMi9xYUMraUkv?=
 =?utf-8?B?YTRLdjU4bURObmViTzNqZCtGQXVRUFA5NjJrQkovUlJKNklXdS9GYVRQZU9G?=
 =?utf-8?B?bzZQVGJwV3kvQllnbjQ3a2xLcnRVSzNkREYybUpyaCtMTHd3eVNDNG4vaXhp?=
 =?utf-8?B?bjdmOEplVkJId1Y5OGhrbGpqWkJUQXR4NnBHeXZodUZsZEpXTUJHbDhzek1D?=
 =?utf-8?B?OW9reGx2UWVHdmVWUmhiOWNDeE1ieTFpQk9JUkFSdXh3MTVJZFJTU3ViajZj?=
 =?utf-8?B?YkJqTTdPN3pZNlBRQ2V0azJXMzRYcXFKRkF1MXNSMVg2SlZrcHlNTFBIb3BQ?=
 =?utf-8?B?WGtVMng2Umx5WGtRK29rbElyUThmZnZJOGRSb1Z0ODhSVi9Vd0JWVFRCYVNz?=
 =?utf-8?B?L3phNDJXRWx3TTFnQjFQV3ZUT2YzSU1BaGRRYlF5OWF6Y0V5OGs5TENWTHVm?=
 =?utf-8?B?bnpJZ3dCcDdveTljVjBLZFp6Rmx5SjhxZGNUajFrbjZzbEVNTGtlWVBRSzBz?=
 =?utf-8?B?S0phd0d0RlZOUDFqQmNJejhrMUtCYlc0ZWR6cnlYbVRLVDJydnRGNGRISzBH?=
 =?utf-8?B?YXBMVDZ6YUtneUt6RzJIYU9UdmVMYzNab0xJbXdkNWczVXlKUGJTVWtoWk02?=
 =?utf-8?B?MUFKb3haaThwWEN5YnZ1U3h6Nm04RWtseStQcjRnMkxOMXBmSkdvdkU3SmJX?=
 =?utf-8?B?SWd4YVQ4RWR5UlJMYmE1QmREdDRxR3ZFdDFpMi9PMkNDVnMrK291c0JHY3Iv?=
 =?utf-8?B?c2x3Nmc0dnVNb1BnbFBVaGFvS2l6ZFc5Nkh5V0UxMGxnUU5sYVRTYnl1eUlX?=
 =?utf-8?B?VVRBMlRPeUJmTHUxdHVnOVZXaVFta3NTN1NZZUlBc0ZBQ3RqeFJDNkxPbG1S?=
 =?utf-8?Q?IWbHNsYuWApDMaJDg7D3anks741J06TzNA4edcf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5115.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFhLRVo5cTlYaGdWbi9VRE1CVWtORThsbGR6MkN0UitvaUlGYm9pZUhibGl1?=
 =?utf-8?B?eFRhc1VUTFFpWUNZVDhvSGlWbTJSNG1RSThDcFF4VVZZY3Z3VHMrTUJXc2dk?=
 =?utf-8?B?bldVeEh4aVBidG4wSmhSWS9zb0dSUW5ndnRzYjM0WFdIWnJKQUlmUFNDM0Vu?=
 =?utf-8?B?STFCaVB1TVlST2xzckpkakdyazFRelR4UStEWldwdkdsOEZBaU0yd0RXN1lB?=
 =?utf-8?B?MDhNSVl3Q3l1cXZaSUZ1TWlUQ0J0aEoxUU82SzM2OG9xMnZFYXpIenhZbXBF?=
 =?utf-8?B?dTlla1pRbmZseGMwNzlCekFIY3Q5MWd5U3ZqSWMwSHg3S2RIZUxJVnYzMkx0?=
 =?utf-8?B?WjdUNjhnV25wMmRPU1l6WHZKajNyLzhVb2hhYkZaT3lSbmoraGZJK1hnVjFP?=
 =?utf-8?B?elYwbTM0SGtuZFJRQ3hEUHk0V1dqdjBOUnVXT2VmZC9WVEdlR1F1TS9IaVM0?=
 =?utf-8?B?dlNMQkpVakthT0hJYm5TRlltNXRodmk2YUNwWWpXcTl0bWFTMnpHK2ExVlhx?=
 =?utf-8?B?K3NES1B3NGs3S3pjSmZOU0lGaGZhZEVEaUpLMlZkeTd1Vm9LUGhhaWdGZlJT?=
 =?utf-8?B?TGtGMzVKcnh5c0V0RXU4cmJlSTJQT3JlREdhNG5tUm5nSVdmMEhPdmdHNmtQ?=
 =?utf-8?B?aTZOeHRDQkh6MXcwZjNWK3lHMUJqMzYxWEdrVzlFcDFoZXVxcHVCek42ZWox?=
 =?utf-8?B?TUc5QzlMZlhOSkxnbXBPWEduSUY3QTFuOUJIazRqTmkvWWZuNDJqSDYzU0pl?=
 =?utf-8?B?OXp3bDhoQ09hS0wySFByOE1IdmlwdTZTVXNYcHE0VlBaZFhjMTZ5WG9OdlY3?=
 =?utf-8?B?SmpSVDdkL3hqald6TnpaU3FBM3NiUDYxZzRkUnVXMEMxc2pQenYwK3BRMCtJ?=
 =?utf-8?B?RE51MWMreVpZa0w1THVtREdmQWZXU0hnZm00ajVWYWhqZmxLU25CSmxUSHZ4?=
 =?utf-8?B?YTR5bjY4MkNnMENsVnMxNyt1ZW40TDJHVkxUL3l3bTAyVy9iYzFSaWMydFlv?=
 =?utf-8?B?cmNGRFNVaDVGWUlJUEl1WnpXdXc2RHpKam5RVDZnL0ttOE5ka0dNaEpEV3lo?=
 =?utf-8?B?aWR5ZGdqdXhiQ3czazQxMm5UTVlJcWJ4eFUzZ2VKU2duRCtaTURla1ZmUUd1?=
 =?utf-8?B?U0lWRGRQbXpyZm5MS2EyZk41TFBUb0RjM2h2VjUwRnBFcDQvMGpaY3IrR3l3?=
 =?utf-8?B?QWsralQwU1VXODFTS1M0NnlvNW4rUGhVekg5NFhjdGdYWm5WQ1VXVXpoZ0Nj?=
 =?utf-8?B?KzhQd051WmdRMGZOeStXY3RiZE93QllVclRSN0hOLy9ncWpKNUROUzRTL3V3?=
 =?utf-8?B?UW9kTGJUWXd0eGRsYkhlM1dFa1c0ZTk3WktENjBhOFY5aWE4SVZmZ0diemJP?=
 =?utf-8?B?ZGw1MkxNVDNxdFQ4UXprMVR5T3FMaTUrZEFCZ0VXa3pQaGlYMkI1clNjaXpi?=
 =?utf-8?B?ajJacGlOUnZwZzMvTkQ5WmRUZmdsS1N5UXZRMi9hZ2cyU2tWbFJNUnBBdktI?=
 =?utf-8?B?ZTQwUVgyZEVDZVZ2TVZMUUsrblRtRkF0TUhHbW1OV3J5dExBMElCcmJYbDFX?=
 =?utf-8?B?NThXbURGaXVnT3BqclM1VWF4M0VsMVZZcVdMS01qYlBGME5ZYk9CL1o5anRX?=
 =?utf-8?B?YWY0WUFET1NodjhMcFEyYlNhejZjYWg2QjR5dUwzZUFvVCtibmg5TXlPcEoz?=
 =?utf-8?B?MW9Kem03bkVxN1Q4ZEVhZ1BTSGZiTFhQOUN6NlQ4RCtUbUpkT1F2Mllyaktx?=
 =?utf-8?B?WUxIY1BaZVQvM0tUeStmelJvUFFxTUNPVWxCczM1VktETm1UZWpyb1ZpMWIw?=
 =?utf-8?B?YWltOWdoZW5Lbnk1cGtCbUtpL1h3YmZyUWFtb1praDNmVHV2Z2hnd2ZORVc4?=
 =?utf-8?B?aW1RcXpnbmxDQzJHaVZud1QwQTRoMnBXUUhLYVNPTldwUTdtbVowbTRZZEhH?=
 =?utf-8?B?R2NBem40UEdORjFub3dRaWJNWGs4WXpUaWowSVFicFZmOGU3K2JRN0FONVVB?=
 =?utf-8?B?T092U2xWaHdiODdycFhNc0NGQy9yUHZIN1JUay9aOUpsOVRJVXBxYUYzc0Fh?=
 =?utf-8?B?ZEFETElrRjdJUEpaSjFabmVmTlVTOGhJNmZIb2FLcTJCRVl1MWdhLy9WbVZF?=
 =?utf-8?Q?IVt1wYR2AzPM6WT0h8YkX1+l8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b2a3ed-775d-4aa4-a93d-08dc8673a9e6
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:57:31.0630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9x3sEiY6ZU7IM+jy1x53rfwrKJtFDN9tW7Fv90FX+GWCQ0epXJsMKwCA23jdBG3r2EAp40rjSdVg5FZDw1YuSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6988


On 2024-06-05 05:14, Christian König wrote:
> Am 04.06.24 um 20:08 schrieb Felix Kuehling:
>>
>> On 2024-06-03 22:13, Al Viro wrote:
>>> Using drm_gem_prime_handle_to_fd() to set dmabuf up and insert it into
>>> descriptor table, only to have it looked up by file descriptor and
>>> remove it from descriptor table is not just too convoluted - it's
>>> racy; another thread might have modified the descriptor table while
>>> we'd been going through that song and dance.
>>>
>>> It's not hard to fix - turn drm_gem_prime_handle_to_fd()
>>> into a wrapper for a new helper that would simply return the
>>> dmabuf, without messing with descriptor table.
>>>
>>> Then kfd_mem_export_dmabuf() would simply use that new helper
>>> and leave the descriptor table alone.
>>>
>>> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
>>
>> This patch looks good to me on the amdgpu side. For the DRM side I'm 
>> adding dri-devel.
>
> Yeah that patch should probably be split up and the DRM changes 
> discussed separately.
>
> On the other hand skimming over it it seems reasonable to me.
>
> Felix are you going to look into this or should I take a look and try 
> to push it through drm-misc-next?

It doesn't matter much to me, as long as we submit both changes together.

Thanks,
   Felix


>
> Thanks,
> Christian.
>
>>
>> Acked-by: Felix Kuehling <felix.kuehling@amd.com>
>>
>>
>>> ---
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> index 8975cf41a91a..793780bb819c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> @@ -25,7 +25,6 @@
>>>   #include <linux/pagemap.h>
>>>   #include <linux/sched/mm.h>
>>>   #include <linux/sched/task.h>
>>> -#include <linux/fdtable.h>
>>>   #include <drm/ttm/ttm_tt.h>
>>>     #include <drm/drm_exec.h>
>>> @@ -812,18 +811,13 @@ static int kfd_mem_export_dmabuf(struct 
>>> kgd_mem *mem)
>>>       if (!mem->dmabuf) {
>>>           struct amdgpu_device *bo_adev;
>>>           struct dma_buf *dmabuf;
>>> -        int r, fd;
>>>             bo_adev = amdgpu_ttm_adev(mem->bo->tbo.bdev);
>>> -        r = drm_gem_prime_handle_to_fd(&bo_adev->ddev, 
>>> bo_adev->kfd.client.file,
>>> +        dmabuf = drm_gem_prime_handle_to_dmabuf(&bo_adev->ddev, 
>>> bo_adev->kfd.client.file,
>>>                              mem->gem_handle,
>>>               mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE ?
>>> -                           DRM_RDWR : 0, &fd);
>>> -        if (r)
>>> -            return r;
>>> -        dmabuf = dma_buf_get(fd);
>>> -        close_fd(fd);
>>> -        if (WARN_ON_ONCE(IS_ERR(dmabuf)))
>>> +                           DRM_RDWR : 0);
>>> +        if (IS_ERR(dmabuf))
>>>               return PTR_ERR(dmabuf);
>>>           mem->dmabuf = dmabuf;
>>>       }
>>> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
>>> index 03bd3c7bd0dc..622c51d3fe18 100644
>>> --- a/drivers/gpu/drm/drm_prime.c
>>> +++ b/drivers/gpu/drm/drm_prime.c
>>> @@ -409,23 +409,9 @@ static struct dma_buf 
>>> *export_and_register_object(struct drm_device *dev,
>>>       return dmabuf;
>>>   }
>>>   -/**
>>> - * drm_gem_prime_handle_to_fd - PRIME export function for GEM drivers
>>> - * @dev: dev to export the buffer from
>>> - * @file_priv: drm file-private structure
>>> - * @handle: buffer handle to export
>>> - * @flags: flags like DRM_CLOEXEC
>>> - * @prime_fd: pointer to storage for the fd id of the create dma-buf
>>> - *
>>> - * This is the PRIME export function which must be used mandatorily 
>>> by GEM
>>> - * drivers to ensure correct lifetime management of the underlying 
>>> GEM object.
>>> - * The actual exporting from GEM object to a dma-buf is done 
>>> through the
>>> - * &drm_gem_object_funcs.export callback.
>>> - */
>>> -int drm_gem_prime_handle_to_fd(struct drm_device *dev,
>>> +struct dma_buf *drm_gem_prime_handle_to_dmabuf(struct drm_device *dev,
>>>                      struct drm_file *file_priv, uint32_t handle,
>>> -                   uint32_t flags,
>>> -                   int *prime_fd)
>>> +                   uint32_t flags)
>>>   {
>>>       struct drm_gem_object *obj;
>>>       int ret = 0;
>>> @@ -434,14 +420,14 @@ int drm_gem_prime_handle_to_fd(struct 
>>> drm_device *dev,
>>>       mutex_lock(&file_priv->prime.lock);
>>>       obj = drm_gem_object_lookup(file_priv, handle);
>>>       if (!obj)  {
>>> -        ret = -ENOENT;
>>> +        dmabuf = ERR_PTR(-ENOENT);
>>>           goto out_unlock;
>>>       }
>>>         dmabuf = drm_prime_lookup_buf_by_handle(&file_priv->prime, 
>>> handle);
>>>       if (dmabuf) {
>>>           get_dma_buf(dmabuf);
>>> -        goto out_have_handle;
>>> +        goto out;
>>>       }
>>>         mutex_lock(&dev->object_name_lock);
>>> @@ -463,7 +449,6 @@ int drm_gem_prime_handle_to_fd(struct drm_device 
>>> *dev,
>>>           /* normally the created dma-buf takes ownership of the ref,
>>>            * but if that fails then drop the ref
>>>            */
>>> -        ret = PTR_ERR(dmabuf);
>>>           mutex_unlock(&dev->object_name_lock);
>>>           goto out;
>>>       }
>>> @@ -478,34 +463,49 @@ int drm_gem_prime_handle_to_fd(struct 
>>> drm_device *dev,
>>>       ret = drm_prime_add_buf_handle(&file_priv->prime,
>>>                          dmabuf, handle);
>>>       mutex_unlock(&dev->object_name_lock);
>>> -    if (ret)
>>> -        goto fail_put_dmabuf;
>>> -
>>> -out_have_handle:
>>> -    ret = dma_buf_fd(dmabuf, flags);
>>> -    /*
>>> -     * We must _not_ remove the buffer from the handle cache since 
>>> the newly
>>> -     * created dma buf is already linked in the global obj->dma_buf 
>>> pointer,
>>> -     * and that is invariant as long as a userspace gem handle exists.
>>> -     * Closing the handle will clean out the cache anyway, so we 
>>> don't leak.
>>> -     */
>>> -    if (ret < 0) {
>>> -        goto fail_put_dmabuf;
>>> -    } else {
>>> -        *prime_fd = ret;
>>> -        ret = 0;
>>> +    if (ret) {
>>> +        dma_buf_put(dmabuf);
>>> +        dmabuf = ERR_PTR(ret);
>>>       }
>>> -
>>> -    goto out;
>>> -
>>> -fail_put_dmabuf:
>>> -    dma_buf_put(dmabuf);
>>>   out:
>>>       drm_gem_object_put(obj);
>>>   out_unlock:
>>>       mutex_unlock(&file_priv->prime.lock);
>>> +    return dmabuf;
>>> +}
>>> +EXPORT_SYMBOL(drm_gem_prime_handle_to_dmabuf);
>>>   -    return ret;
>>> +/**
>>> + * drm_gem_prime_handle_to_fd - PRIME export function for GEM drivers
>>> + * @dev: dev to export the buffer from
>>> + * @file_priv: drm file-private structure
>>> + * @handle: buffer handle to export
>>> + * @flags: flags like DRM_CLOEXEC
>>> + * @prime_fd: pointer to storage for the fd id of the create dma-buf
>>> + *
>>> + * This is the PRIME export function which must be used mandatorily 
>>> by GEM
>>> + * drivers to ensure correct lifetime management of the underlying 
>>> GEM object.
>>> + * The actual exporting from GEM object to a dma-buf is done 
>>> through the
>>> + * &drm_gem_object_funcs.export callback.
>>> + */
>>> +int drm_gem_prime_handle_to_fd(struct drm_device *dev,
>>> +                   struct drm_file *file_priv, uint32_t handle,
>>> +                   uint32_t flags,
>>> +                   int *prime_fd)
>>> +{
>>> +    struct dma_buf *dmabuf;
>>> +    int fd = get_unused_fd_flags(flags);
>>> +
>>> +    if (fd < 0)
>>> +        return fd;
>>> +
>>> +    dmabuf = drm_gem_prime_handle_to_dmabuf(dev, file_priv, handle, 
>>> flags);
>>> +    if (IS_ERR(dmabuf))
>>> +        return PTR_ERR(dmabuf);
>>> +
>>> +    fd_install(fd, dmabuf->file);
>>> +    *prime_fd = fd;
>>> +    return 0;
>>>   }
>>>   EXPORT_SYMBOL(drm_gem_prime_handle_to_fd);
>>>   diff --git a/include/drm/drm_prime.h b/include/drm/drm_prime.h
>>> index 2a1d01e5b56b..fa085c44d4ca 100644
>>> --- a/include/drm/drm_prime.h
>>> +++ b/include/drm/drm_prime.h
>>> @@ -69,6 +69,9 @@ void drm_gem_dmabuf_release(struct dma_buf *dma_buf);
>>>     int drm_gem_prime_fd_to_handle(struct drm_device *dev,
>>>                      struct drm_file *file_priv, int prime_fd, 
>>> uint32_t *handle);
>>> +struct dma_buf *drm_gem_prime_handle_to_dmabuf(struct drm_device *dev,
>>> +                   struct drm_file *file_priv, uint32_t handle,
>>> +                   uint32_t flags);
>>>   int drm_gem_prime_handle_to_fd(struct drm_device *dev,
>>>                      struct drm_file *file_priv, uint32_t handle, 
>>> uint32_t flags,
>>>                      int *prime_fd);
>

