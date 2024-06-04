Return-Path: <linux-fsdevel+bounces-20980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C82B78FBB5F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 20:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CDA6B22F38
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 18:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E352149E17;
	Tue,  4 Jun 2024 18:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="263BkwPj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2042.outbound.protection.outlook.com [40.107.95.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964FB12E1CE
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 18:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717524968; cv=fail; b=ReWNdVrLq8pwYoeUSktsYVdPGjxfoQdgwuQYSC8Sbz5h9+rFH/75y4OtI3f1lfMhIR4lRW/+QV0hDAoieaAnnjaIXstXpxOwS21E+ZutVUjM1b30RIiNdKV8LOXGFb1TnN6z8Lsz8ZR94Pu6sbLwshBqoI1pz4ozMrRelUi4sA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717524968; c=relaxed/simple;
	bh=mzUC9OlBC3DowINlxHw6IaUOgJvlFO2CwYKg0c+Ue8g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V0ECvzKg0ROa/uZlCsKaQu3opyAMQtu2PTjM+qIGQ5Wa8ueBGUPmJtsY0bP+GWD0zZYJuHxiKS9eSAxBLHZM3ePizCW+LMnMmy6Up/M6cPl/UnJcMGuwowxtq13NgpwxybCKF77WHFblvONYZ/ybj/O9q9dJBjcl0wCR1Eax878=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=263BkwPj; arc=fail smtp.client-ip=40.107.95.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPwlqDcJ3ndWuvcY7Ot8p+UvxRstIlXFBBvy/W1x6VDvS4j4YvqX29zo6ROMesioGMFl9o5U0Wr+gvUbuznNpGp7yEOZZJfz+CdLntmdHs+a98/aliItj0LXXzgzxbB4xRgJjmJw1mEErEROCGyvqTw+9EVbiomQ3SQU8Gjnsxl9dGKNjMcpU8dr3S0e+gmS9v5VnuDINHIMVXWKnkdl5g//NcgNu4mEVbj43Xbp1H8N8BwgajS8eHXKPrrzHBfuhVn9Qk9LpcKsDYUIx9dV+323U8haHEYtp47oaLP8MYBQMNAVLor8B/CfuEDJW5RQ6H8q1EcLZaZN9zibVNai2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yCXmF4tbfp33VfNnM3li3S9QksWFL4Ur6mjeIaFm08=;
 b=eNXyZtmAmrcmMOYQs17012I/fCBQxyfTp36MXuAz9z+l3xS86Wyt0E7RaMowx53V0FYhLW8KG+ZoNNpM9mIt/Dn093K7EZyxyDKm+T1ungKKl2cvzwPjIU2TrHzlFGwphrJ+6mLzpNflzcOSVdrOfdbEbRsahS98cEd4CUe9bYeR3e9RaNpt40o9YbA7yeYlC7EY54RhlWF8EcX1jkLnTi7CkFTXT7l5zfYg8/k75D++ov84N9UEDob7TSj8a1jlyEeEgrUqS3atZajMg34hNmu+wBvjnMu0A6g3taF2pid2bShJPCw6HjeVV09PSrsJRXfDgWM0JVRQZtwOF3estQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yCXmF4tbfp33VfNnM3li3S9QksWFL4Ur6mjeIaFm08=;
 b=263BkwPjUPhHNQ5z03RWlDt96xQGeWFNx8RKmSCzkfVZ2uc/OrQFHbXbxPfpXMbBiGdiEsDYgBvfDaRTwg9te1aizmLrXxR/0n1hqBLt9J4vnPboESpdqCCIKONDccPuPKFiVbnK9iLeFxDbg2w6halq4wggUB1c+BRcwQ0npOs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS0PR12MB8342.namprd12.prod.outlook.com (2603:10b6:8:f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Tue, 4 Jun
 2024 18:16:02 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 18:16:02 +0000
Message-ID: <1cd7980e-1cfa-4470-b712-48d9d2658435@amd.com>
Date: Tue, 4 Jun 2024 14:16:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2][RFC] amdkfd CRIU fixes
To: Al Viro <viro@zeniv.linux.org.uk>, amd-gfx@lists.freedesktop.org,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: linux-fsdevel@vger.kernel.org
References: <20240604021255.GO1629371@ZenIV> <20240604021456.GB3053943@ZenIV>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240604021456.GB3053943@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0131.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS0PR12MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: e63fb2fc-4a5c-4b38-fbdd-08dc84c2642a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGdtUWVwakhCVmpsZEdaSDgydGFJMlg5TWt6ZXhNYU1BakpzVEh1Vy9KaGpS?=
 =?utf-8?B?UVlSS09wZlF2SitRcDFRejlsaUZZQWlpZzJ6UEFkSjBQeVYxcURFK3NDT2FJ?=
 =?utf-8?B?SzRxTFFqMlRua0JaVFJERUcvMkRxT2R1UWhMRmsvNGhnR0ducTFYWWpRdVFG?=
 =?utf-8?B?RFBwNVQyT1ZtWEpvVEpWTUxkMzdnNXZ1bFNUWVRHTFhQRWQzL0paUm8ya01u?=
 =?utf-8?B?UTZoWnh6UVVvd1dBbXc1anNyWkZkSDVVaG5teTVVQ3FZZUFUMjc2cFp3RzRs?=
 =?utf-8?B?NDZiRnZhUDRudTdHTnVYQkVRNXJ3dHZ4YkVFM2Z0eGpwUmw1QURHV3FMOTMw?=
 =?utf-8?B?YUhUSiswRzc3ZTRpZlNOOUhzVm8xMTNmdmJJMXlKcnZHNGpsNWlyZElWRkdo?=
 =?utf-8?B?VjlaMUs3REJaaTlXMUhCdE4zZzk2dXFwTVREcVdOMWpVbFBnb2ZEdDI1WTQ5?=
 =?utf-8?B?TUliT2VhY21PbXJ3eUFJZVU3Sk1UbU1mQXVqR1gxRkZvQnM3UnE1V1BTeTZD?=
 =?utf-8?B?OTVmcHEvUkFwV01mUmV5b09yVlpwTXNtUEpKa2ZKUmNXRnNyMlE0emJrMi9M?=
 =?utf-8?B?WmNiOHB4YWFEdEpRRHExT05xa3VyNERxZTBWdkI3NVVCbU5PT3Q3a0xUL01a?=
 =?utf-8?B?Kzd2cFI2bStXL29hTGpYYk51SGZEcjN2Y0xRRi9OdnpBMjdhTHQzNE5kWDZI?=
 =?utf-8?B?d0xPdDk3UjVGMmc1YVpVd2JVZVdhTWhsSDJMTHNBZEZmNGEwejlzUy9mdHQw?=
 =?utf-8?B?MkJORWtRKzlhODRTQ1E2WktwRlpRV0FyalJHczVVTUMvTXlrT1NlMWhSbmpR?=
 =?utf-8?B?U3JtUHIvdG5jNko4a2h1anh0T1BTZysreHZyR3JqenhlNDg0bGxrNUtkNFB2?=
 =?utf-8?B?ZFJlZGVUYUJTYkhjOVNFeTBOWWJTeHhtOUtYckMxdFRubXZ6Kzd6SjdUd1dH?=
 =?utf-8?B?U0gzWlpWSEdZZXRLT0VpV2IwNmlHZm5abnNsRlpTWndpVU5XSG9iRU04U2cr?=
 =?utf-8?B?K3U3KzgvUGttb2dzdFRJQlUzb3djYWdNcDkxVWR6NEdHcE8xem9kZzc2YlhZ?=
 =?utf-8?B?dm8wUkdCQWxxRFN5cDlqUWtvUlVuZHpJejRGaUYyV3RxazJuMWRaYVhrS0Iw?=
 =?utf-8?B?QkNocEhSVEpPTFdzMlNGemRYRUlmd1lHZWY3YWdXdEdSSWt3Zkh2WW5vY2lF?=
 =?utf-8?B?VE5odkVjRGVlRkkzZXNGbWZBOHppZCtEL1p5NjFrVjJrUlg1b1JaSTdyckZk?=
 =?utf-8?B?ejM0NjB4Z1lkcU9JSW5uaFpPYzRDaEhJTmtNS1N0RTdTSEt2WmRMcWdtMG5w?=
 =?utf-8?B?S3ZsQ2NVbDE2cUVGTm51VExJdlRHYmFFamk1SFRybTVHZmovSXZ3K3RjNU90?=
 =?utf-8?B?cUp2VEZtMkhselhnRk85NUFUSXNSVW4yREJZYyszdTZSOUNKL2VPQUorMTlI?=
 =?utf-8?B?cUNhbnhrSkJSWEozUE04ZzRmQWRPYWg2Tkl6NG43R3dnT3dYZVJ2UmRUWmpX?=
 =?utf-8?B?eFJjSHdHM3laYzJQWGI1ZkYvVGhvV3Q4VTArb1d0NmQ4Slk0VUNZOFQ2aTZX?=
 =?utf-8?B?SnhWbmhqTkVKVnpZVWJVYUZDc2ZTalVwUHhidWdFSElSSFpndHJoa1RLQXdH?=
 =?utf-8?B?SVRRSytsWVBnOW12WGNEOUxCamZDcnh1NDJyb2JlM3NJczlhMHUyRk52NTBB?=
 =?utf-8?B?d1N0b2NzN1hkQ0E4OHhrcFZ2c1ExUldWUG1admMvclNRMy9YUk0rK3VRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5115.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHc0N2U4TzdId3RxbWVudlFya01XUGEzZEVJMFhxS0kwNDRhNTZpcGZ6UVBO?=
 =?utf-8?B?bjI4ZW54UzJlQmJLRlg2VFUzRlpLSUc3eW9jd1BGejMzeloyd1VQa0tFYmM5?=
 =?utf-8?B?aktETE0wWlJLY0h4cFVMNkdWVFM3ZzQ4eWRKdi9hZ3prZkVNV0dtNnBZMUhB?=
 =?utf-8?B?VXptbjFoOU9Ic1NKQzZTNjAwQW15b2ZqcjUwdmVxQWRvR1lmOGVGejFoMFVK?=
 =?utf-8?B?Y0FKMk9tT0QyQ3ZzK0FPSTBrS2ZWazU1ZnZJdXZqZnlzNEpSdjdNNDQ4aEdC?=
 =?utf-8?B?MnpNaDB3S29kT21mWFBrTjljVzJWQzJoemhkSkpJWjFXWmptNDJ3S3A3SHhR?=
 =?utf-8?B?cllYV0VMcHlkMUQ0RGZZLzRuNzZyZHc1OG05ODkrK09ud04wRDZSbFNtU1Ni?=
 =?utf-8?B?S1g1VURhbG9peUJyRkk5SGdPRmEyQTRmVHJlL3dvWFQyelBwOUR4UUhwZVlu?=
 =?utf-8?B?L0VKeUtlR2NIeHlqVzE4UXFVYk5nODRDUE9GczFva2RpZFQ2K0RKZlhVeS93?=
 =?utf-8?B?eWR1SERJaTgrSmV5L3ZkTXdSRERQam0rbytGOXg2STFlM0dGbEdXSW5zK1pC?=
 =?utf-8?B?SVBjTXhiang2ZzNjajcreVQxaFg1SHA0K2ZOY0RSa202aEgxaEo2VDljOHBq?=
 =?utf-8?B?ZHY2S2FtOVozd2l3Z2ZPcW9kd2hzdklWSS9DNld5dXU5VTNwYzRoNkZ6TUJt?=
 =?utf-8?B?QWpwZFplekhVVXVxdjAwY3ptWWo3MUxjU3JkT0tqbmhzclNrWVVMU3hNZ2cv?=
 =?utf-8?B?MWloTHpuenNPRHlsYTVPYjhQYUZkVlRVY0R3bmlXZmg4NGdBb2FFcXdzVzV0?=
 =?utf-8?B?cng2YnExbXVuKzR0SDY5cHorRk1GRlllcnVObGFBQ0svTTlDdlpsK1lQdkRp?=
 =?utf-8?B?ekRzWDV1OTJWREVTbC9EQ0h2dG5oQ0I2Q2lwYTlTcis4Ymh6eEZiV2JkWm1w?=
 =?utf-8?B?bnRSV1lmTmttYXdjd2h3TFF2b1Bwb05CSEVybmx2OCtyUUZvL3BobUZxM0tH?=
 =?utf-8?B?bERZck5YamsxazUxVFFZdnlRK21BdGdQT3VJSEgvK3R5Z2pwd3NJaS81bTJa?=
 =?utf-8?B?L3J4RWRqL2ljVE5LVVlGTEt2clF4ZHpoQjNLUWJGS0thMzQyNER2WlBVQU9P?=
 =?utf-8?B?dlZiZEw1aFN1RDlMUmt3eW15ODl4elFmVndwb0ZGaUs1UXRKaGtrZFJBNlRY?=
 =?utf-8?B?aU1COFcvUWtyeXVmakVjeVFvUEFJS1MvMTEzMXZDZUJhZk41L0Y4NHpXWDBX?=
 =?utf-8?B?VmwzWElqOExqVE1LZ2xuK1dMVURNQUEranRqeTBEQlI5MGRkc1Vtc0ZaU3FQ?=
 =?utf-8?B?bDRmVVhwYzZVZk01RzBTbTU5S0lveVNhd2hyYWZUYjR5RFQySnQ1L3ZDaHpO?=
 =?utf-8?B?enhWTzJXVmlCeEJ4SUJEbXZoRGFIa2FPM0NqM0dwNGwxUGJqMTljUENTUmsy?=
 =?utf-8?B?bWU3WTgyenRxRktGYjdPeXlGZ090ZkF6NDdzTVJCclNoMUlWdlJUODJ6R1JL?=
 =?utf-8?B?ZVEwZXZtM0JEUHRqakkrVGJYWEFUbjcyU0RmaS9hbXR3VmxTREJ5UkgzUDF4?=
 =?utf-8?B?dnliZFgrYzZBOGQxMGFnelcxN25XUlY1WTR0NFlkNzU2emFWOE1tOWR5Y2N5?=
 =?utf-8?B?Z3E1QlFuVDhVUDhnUjRCNU1UUElORTNmeFl2WTZFNVlYR3dkUmE4ME9RZGxm?=
 =?utf-8?B?eTlvY1ArV2t6MTBublBDRGk2Q1c4OHAxaFQ4SzBnZEF6eFV1YUV6b2dVQU9p?=
 =?utf-8?B?a2htRjZRMnRtN0hrMkRnZm5GbWoxK0g2ampvRzVmUnBETVEwbmhzZ2xaWXZD?=
 =?utf-8?B?NWZOdVZ5ZFFsTjhvNFVHSVNxTHFhVTBnbEpra1ZUbnFhZU5oS2wvRzRJWW5W?=
 =?utf-8?B?K1hNQ2lzbFAxME9aNklWQUtESXpjcmNRc3JjeUVxNnVCdUhwcUJxWDBsZVBi?=
 =?utf-8?B?bnB5eDlvenNvd0dOSXdkNkxXRUMwbEZxTGJkWmMzVWIybExMVUVDTUtaMUVK?=
 =?utf-8?B?ai92RzNoS05qeHN3a1IwdG1mVGNKNXFCL3JnOURjckwzQmhzMU9iTm5zcUxy?=
 =?utf-8?B?RSt6c3d2Yms5cFFUMVBUS3dFQ0x3aHJxbXRYZWdVOUhaanZmUkRJUTFwTkQz?=
 =?utf-8?Q?buJkzfrIiY/Fcp4Jvb4/DbCkJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e63fb2fc-4a5c-4b38-fbdd-08dc84c2642a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 18:16:01.9802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0biws+NYtgbWWMfNVLjNz68aruNqwZai2XB9xcooS2uZ9fRk2wfQJHgxe7QAMo03+NiUB9FqnMLmzzkqWZOXdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8342


On 2024-06-03 22:14, Al Viro wrote:
> Instead of trying to use close_fd() on failure exits, just have
> criu_get_prime_handle() store the file reference without inserting
> it into descriptor table.
>
> Then, once the callers are past the last failure exit, they can go
> and either insert all those file references into the corresponding
> slots of descriptor table, or drop all those file references and
> free the unused descriptors.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Thank you for the patches and the explanation. One minor nit-pick 
inline. With that fixed, this patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>

I can apply this patch to amd-staging-drm-next, if you want. See one 
comment inline ...


> ---
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index fdf171ad4a3c..3f129e1c0daa 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -36,7 +36,6 @@
>   #include <linux/mman.h>
>   #include <linux/ptrace.h>
>   #include <linux/dma-buf.h>
> -#include <linux/fdtable.h>
>   #include <linux/processor.h>
>   #include "kfd_priv.h"
>   #include "kfd_device_queue_manager.h"
> @@ -1857,7 +1856,8 @@ static uint32_t get_process_num_bos(struct kfd_process *p)
>   }
>   
>   static int criu_get_prime_handle(struct kgd_mem *mem,
> -				 int flags, u32 *shared_fd)
> +				 int flags, u32 *shared_fd,
> +				 struct file **file)
>   {
>   	struct dma_buf *dmabuf;
>   	int ret;
> @@ -1868,13 +1868,14 @@ static int criu_get_prime_handle(struct kgd_mem *mem,
>   		return ret;
>   	}
>   
> -	ret = dma_buf_fd(dmabuf, flags);
> +	ret = get_unused_fd_flags(flags);
>   	if (ret < 0) {
>   		pr_err("dmabuf create fd failed, ret:%d\n", ret);
>   		goto out_free_dmabuf;
>   	}
>   
>   	*shared_fd = ret;
> +	*file = dmabuf->file;
>   	return 0;
>   
>   out_free_dmabuf:
> @@ -1882,6 +1883,24 @@ static int criu_get_prime_handle(struct kgd_mem *mem,
>   	return ret;
>   }
>   
> +static void commit_files(struct file **files,
> +			 struct kfd_criu_bo_bucket *bo_buckets,
> +			 unsigned int count,
> +			 int err)
> +{
> +	while (count--) {
> +		struct file *file = files[count];
> +		if (!file)

checkpatch.pl would complain here without an empty line after the 
variable definition.

Regards,
   Felix


> +			continue;
> +		if (err) {
> +			fput(file);
> +			put_unused_fd(bo_buckets[count].dmabuf_fd);
> +		} else {
> +			fd_install(bo_buckets[count].dmabuf_fd, file);
> +		}
> +	}
> +}
> +
>   static int criu_checkpoint_bos(struct kfd_process *p,
>   			       uint32_t num_bos,
>   			       uint8_t __user *user_bos,
> @@ -1890,6 +1909,7 @@ static int criu_checkpoint_bos(struct kfd_process *p,
>   {
>   	struct kfd_criu_bo_bucket *bo_buckets;
>   	struct kfd_criu_bo_priv_data *bo_privs;
> +	struct file **files = NULL;
>   	int ret = 0, pdd_index, bo_index = 0, id;
>   	void *mem;
>   
> @@ -1903,6 +1923,12 @@ static int criu_checkpoint_bos(struct kfd_process *p,
>   		goto exit;
>   	}
>   
> +	files = kvzalloc(num_bos * sizeof(struct file *), GFP_KERNEL);
> +	if (!files) {
> +		ret = -ENOMEM;
> +		goto exit;
> +	}
> +
>   	for (pdd_index = 0; pdd_index < p->n_pdds; pdd_index++) {
>   		struct kfd_process_device *pdd = p->pdds[pdd_index];
>   		struct amdgpu_bo *dumper_bo;
> @@ -1950,7 +1976,7 @@ static int criu_checkpoint_bos(struct kfd_process *p,
>   				ret = criu_get_prime_handle(kgd_mem,
>   						bo_bucket->alloc_flags &
>   						KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE ? DRM_RDWR : 0,
> -						&bo_bucket->dmabuf_fd);
> +						&bo_bucket->dmabuf_fd, &files[bo_index]);
>   				if (ret)
>   					goto exit;
>   			} else {
> @@ -2001,12 +2027,8 @@ static int criu_checkpoint_bos(struct kfd_process *p,
>   	*priv_offset += num_bos * sizeof(*bo_privs);
>   
>   exit:
> -	while (ret && bo_index--) {
> -		if (bo_buckets[bo_index].alloc_flags
> -		    & (KFD_IOC_ALLOC_MEM_FLAGS_VRAM | KFD_IOC_ALLOC_MEM_FLAGS_GTT))
> -			close_fd(bo_buckets[bo_index].dmabuf_fd);
> -	}
> -
> +	commit_files(files, bo_buckets, bo_index, ret);
> +	kvfree(files);
>   	kvfree(bo_buckets);
>   	kvfree(bo_privs);
>   	return ret;
> @@ -2358,7 +2380,8 @@ static int criu_restore_memory_of_gpu(struct kfd_process_device *pdd,
>   
>   static int criu_restore_bo(struct kfd_process *p,
>   			   struct kfd_criu_bo_bucket *bo_bucket,
> -			   struct kfd_criu_bo_priv_data *bo_priv)
> +			   struct kfd_criu_bo_priv_data *bo_priv,
> +			   struct file **file)
>   {
>   	struct kfd_process_device *pdd;
>   	struct kgd_mem *kgd_mem;
> @@ -2410,7 +2433,7 @@ static int criu_restore_bo(struct kfd_process *p,
>   	if (bo_bucket->alloc_flags
>   	    & (KFD_IOC_ALLOC_MEM_FLAGS_VRAM | KFD_IOC_ALLOC_MEM_FLAGS_GTT)) {
>   		ret = criu_get_prime_handle(kgd_mem, DRM_RDWR,
> -					    &bo_bucket->dmabuf_fd);
> +					    &bo_bucket->dmabuf_fd, file);
>   		if (ret)
>   			return ret;
>   	} else {
> @@ -2427,6 +2450,7 @@ static int criu_restore_bos(struct kfd_process *p,
>   {
>   	struct kfd_criu_bo_bucket *bo_buckets = NULL;
>   	struct kfd_criu_bo_priv_data *bo_privs = NULL;
> +	struct file **files = NULL;
>   	int ret = 0;
>   	uint32_t i = 0;
>   
> @@ -2440,6 +2464,12 @@ static int criu_restore_bos(struct kfd_process *p,
>   	if (!bo_buckets)
>   		return -ENOMEM;
>   
> +	files = kvzalloc(args->num_bos * sizeof(struct file *), GFP_KERNEL);
> +	if (!files) {
> +		ret = -ENOMEM;
> +		goto exit;
> +	}
> +
>   	ret = copy_from_user(bo_buckets, (void __user *)args->bos,
>   			     args->num_bos * sizeof(*bo_buckets));
>   	if (ret) {
> @@ -2465,7 +2495,7 @@ static int criu_restore_bos(struct kfd_process *p,
>   
>   	/* Create and map new BOs */
>   	for (; i < args->num_bos; i++) {
> -		ret = criu_restore_bo(p, &bo_buckets[i], &bo_privs[i]);
> +		ret = criu_restore_bo(p, &bo_buckets[i], &bo_privs[i], &files[i]);
>   		if (ret) {
>   			pr_debug("Failed to restore BO[%d] ret%d\n", i, ret);
>   			goto exit;
> @@ -2480,11 +2510,8 @@ static int criu_restore_bos(struct kfd_process *p,
>   		ret = -EFAULT;
>   
>   exit:
> -	while (ret && i--) {
> -		if (bo_buckets[i].alloc_flags
> -		   & (KFD_IOC_ALLOC_MEM_FLAGS_VRAM | KFD_IOC_ALLOC_MEM_FLAGS_GTT))
> -			close_fd(bo_buckets[i].dmabuf_fd);
> -	}
> +	commit_files(files, bo_buckets, i, ret);
> +	kvfree(files);
>   	kvfree(bo_buckets);
>   	kvfree(bo_privs);
>   	return ret;

