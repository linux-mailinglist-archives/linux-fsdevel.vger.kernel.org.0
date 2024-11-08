Return-Path: <linux-fsdevel+bounces-34002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9FF9C1908
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 10:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F27821F242CD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 09:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAC11E1C04;
	Fri,  8 Nov 2024 09:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pJrn4A2s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFD01E1A05;
	Fri,  8 Nov 2024 09:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731057693; cv=fail; b=AV2otDTrDg6rGUGkFgVtnlfIGDhVtfPoP1kNJQsPOMU2oPbRwXxf9KCDcoJPV0/o7yc9P0PBCeQMgpaIsHtHXF/mZ58Vave6lVvN/KI6I7/fuhuXaGoewUZfR8OhQoB7x8Uvxf49ffz3XvfxOhms3191GT9Hw1CEs/go/Ad85eg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731057693; c=relaxed/simple;
	bh=X/4pLfoYNyINViCU7SjJfbIh2sFtFb6emyVwzzQPrxk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A0UxgVV+Nm6Lb39smbhC/ACFzpTrki/Sl4t5QpHeXJIciiUSbPwfGURiRdX7tGSh9Mf0LrX+xhMAuaR0hgjvA4WZALsalAIIwBuYw7yXlZ8f70DrG8CEVZD+Kjfzs7NtqYyrVx8POHcjsw6LPO7UrULX9sbmKswqDmLLJ/llZYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pJrn4A2s; arc=fail smtp.client-ip=40.107.237.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uzHfCcfsxmRq5Aqt9vDxlKoIbJjW9WwMbkxPATERimbUXrdKAidSEro/2wlgXjE9umLGk7pyPz0fIq10ETdOg/qZQ1bLv6mcZiiPeXDJAwM3rMBbIxd4ZAMBZEJifazFhHr6BBCCjUqZS98x7bV3l7zIgYSMLwGBYmJAAYIsrCDOwWxNMU6nTpfB/4k3NigScPSQKRxSm9d++UskHscV79wIzbfmOn/4knG8mHfzi+fnCYLdDZbsJ5qUMXtjzUf4QGSNu3+zUp3YVWmeaV8kQkMf/rMqv4le6/GNtHPmpchjII4K1Cdzmzu3xrIG+yThLVsHBT4HIQfaEl1EoGndsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jnne+wk9DwNyEamUByFnm3V48+poKkF9bVSOu3zG8zU=;
 b=IKzTp/xTbHRAefdzlFFHAp9Whvib6GKlDaMEaHQUbQkdDZIE61uWKPzU2JyDxMRcdSCgCgFj2uburQ/Gv9j6ZiI56GwGEV6sdTpZvEzigjPkbbzoHitjxEE5N9IObMS9OF7Tu6I2SwVBnoYyLePuIE29/BwikMbWnH3a85WaaJn/I4r9ag7/jcF+8EWq+QAIx/e0cLKsyGopaWdkmiTDhgEvKbN7KWyuIh60b6Bp5MN7/p8/9wWTvVTN4Rc7z7Vh6AW0YPmLes1ZozRneLXtixMuEDYcfFI3eS+O1CLx6lGOExKuP5qeqCASJljujSN2It/rFKUWFSjNqa/IQxM7Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnne+wk9DwNyEamUByFnm3V48+poKkF9bVSOu3zG8zU=;
 b=pJrn4A2sQIy+q849M83g437ED8aaWlacZhEZbsEfhkjo3pmD+XsLOVPqstUBLC5EqtUJOBbESaWxxsesC8GuBuS62OS9u3/PTQbHH/SNsycFoxm8iLSnHDtKTNnag7uEvmA3IIDRcmk607B1WAdTPwr06+7ekXdEx+soTJCoXw4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by LV3PR12MB9439.namprd12.prod.outlook.com (2603:10b6:408:20e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Fri, 8 Nov
 2024 09:21:28 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870%6]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 09:21:28 +0000
Message-ID: <d9dc54e8-080f-4dc3-b13e-b65248c25a56@amd.com>
Date: Fri, 8 Nov 2024 14:51:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] Add fbind() and NUMA mempolicy support for KVM
 guest_memfd
To: Matthew Wilcox <willy@infradead.org>
Cc: x86@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-api@vger.kernel.org, linux-arch@vger.kernel.org, kvm@vger.kernel.org,
 chao.gao@intel.com, pgonda@google.com, thomas.lendacky@amd.com,
 seanjc@google.com, luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, arnd@arndb.de,
 pbonzini@redhat.com, kees@kernel.org, bharata@amd.com, nikunj@amd.com,
 michael.day@amd.com, Neeraj.Upadhyay@amd.com, linux-coco@lists.linux.dev
References: <20241105164549.154700-1-shivankg@amd.com>
 <ZypqJ0e-J3C_K8LA@casper.infradead.org>
 <6004eaa4-934c-48f4-b502-cf7e436462fc@amd.com>
 <ZyzYUOX_r3uWin5f@casper.infradead.org>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <ZyzYUOX_r3uWin5f@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:4:197::21) To CH2PR12MB4262.namprd12.prod.outlook.com
 (2603:10b6:610:af::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_|LV3PR12MB9439:EE_
X-MS-Office365-Filtering-Correlation-Id: 53dfd92f-dc0d-4ee2-4221-08dcffd6b93f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UzdtWkxtUkd6OW93NzdGdlJwQVl0bUpJNzN1RU1pZHo1QWYwbVc1NDcvSE9G?=
 =?utf-8?B?RmNoSmNnSGlZS2hyVkhqZEhKVFV2aGlWbkJXTzVKTlhVVE9OVnh5SkpkOEI2?=
 =?utf-8?B?WXJTSjBYbFRySzVxWnBObk5UbnZjUlBDS3pBN2VuV0R5NUNzWWJ5VENPNTFC?=
 =?utf-8?B?a2UzemVkbGVseldNWTZCV2FQSnhGajNjZHQ3Q3BtN2pRSStoVzVaM2gzVmFO?=
 =?utf-8?B?b0h4THhWcVFaL1NlS3pVK1hPbzd1ekcxSFNlNHpFUXF2ejh6UUJkRG5OeHlY?=
 =?utf-8?B?ZlFKN3FwbFFTMG5maVlvS3lZb3dIdTF3Y0QwdzU5Y3ZMS05BeVlZM0NxbGRY?=
 =?utf-8?B?ZTJmS1ZEWm13dGxqL1FzQzlZcHZyUEFpRHhQcnRSQzg4VDJkQjZpWTVyeHJl?=
 =?utf-8?B?RkRTcEFMeWRSam5POWE0SzFsa21xSTZaNHJwZ3hESzBsVHYrVzZ3YmEyb0k2?=
 =?utf-8?B?bFR4WjNTQWJINHNqY0Y0WTVtbkxZZmVCQWdnMUc1M3VPMEpzeVFWZHRTU3Yy?=
 =?utf-8?B?akI0ZTc2ekx3TUFYQ3VWTHNZeUpkZTJWNnhwdUFMZ29MOWpKOHA2c2hSWjEr?=
 =?utf-8?B?Vm1qTXVSbGlUZE9MZWtVdkI4NnI3NDVoTzc2aDBnd2RjRnhuQmNiN3VtWE83?=
 =?utf-8?B?d1Q3WWs5T1IrOWwrLzFYM3BYSk0vZFV5QTB5eFJHLzd1Ni9xMDUycENXamMv?=
 =?utf-8?B?VnR0Z2tOQnlGTjJsK1RmRFVwb2pPMkpTWTlRK3dVNWdxYlF1S1dQOU1TOFBG?=
 =?utf-8?B?ekdzZjRsZkw1d2R1MUtPZlV1UC9PUjkxWU96eVpvNWlMYmFOalRLWVB3MjRn?=
 =?utf-8?B?OTdGaHBwaGhwa3cyNVZjOEVXNklJVGEvZWVRUUN6NVcyZFdsNm4zK3RqVkg1?=
 =?utf-8?B?NW9IZkpFc3VGVzRFVXM3Nno5b1czdVdQMDBDM2FxWk5ERFJCbkQ1MEdybGNv?=
 =?utf-8?B?cjV6Y0FvdmRLK0xUYWpPOStMTFNOdnZVMFkySnhrWmp0aFJoanRoTXJEYkNT?=
 =?utf-8?B?cTQ5L3dwbVUzcmd1MVA2UFlKKzNZRnlIWWlkMVV1eFNSUWZERjVhQ0xhanV2?=
 =?utf-8?B?WUJCR05Nbk1JRERXVEozMTlpSFRxWldkc0sxbGNBM05zeVVqdVhNR2NKblRM?=
 =?utf-8?B?WkVsRmNkeVJRcDR2Y2RwZ0V0Nmw0STBYY082ZVpUcVJUQXNGMlU4SWVDaHNC?=
 =?utf-8?B?SUZYWDgwSENxekR2cDhvNTJpTms5cEFjWkdLU3NMcTc5RVZlK2Z0ZnhvUm1q?=
 =?utf-8?B?c2ZSWG5CSjRvenZXRDFtYXdiSHFJOWlPNFFHTmo0VXBlUElmYUsxWTV2b3hE?=
 =?utf-8?B?S2ZGbm9WRGZWRUoveSt3Wi9aRWNHRU52eEVZV1RpcGEwTS9hdnU1b3RCV2N0?=
 =?utf-8?B?MVArTUxTNUV6aGFxbXlsdUMzVTRwNTJsbmxKZnFCOXN1VFpaaDIyNlFQekN1?=
 =?utf-8?B?V2VMRU9EMHM3YzhCelNHZnllM2JEdUFOaWpGc2MwRXRTalN5M2U1MlZ3K0V4?=
 =?utf-8?B?RVE4OFYrS2FodjBxU2VRZlRqcCswTm5YMTBoanZpSEFtdUtYVFc2bXYyQW1H?=
 =?utf-8?B?NmRMWG9TTUtsdVQxTmwxSktnd05Gc1pQZnpaMXlTRHQzZjJYTEdJMW5haE9i?=
 =?utf-8?B?Wk1OWmxBWENpakI1WTJXeDdCeFBESTZMaFFXUEdLV01EdThSdmg1Y1MrcFh1?=
 =?utf-8?B?QmpiaEVuSzZDZldkZk1xSno5Q2xOQllNTFlhWDEzaGJBbytYZ2tWZkFwYi9J?=
 =?utf-8?Q?BkQ6RbjRwrp7s8A49H6VQzIDKCwCzqLxg5DGN7q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4262.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUg5M2N2Ly9YUGxPYVg0WHRYdGJMaStLT1VpenZJSEJ6dEU3UmJ4RE9vejZz?=
 =?utf-8?B?QnFIL25XRWtNWHhHUW81NC9BY3V0UkZhdEdlZ2IybUFUTFE5eEk1SWZJYzRJ?=
 =?utf-8?B?LzY4VjlKaDBSNEwxVElXd1doM2NaMUZsOG5OSGtZVE9YazFxQk1LUVlvb1pp?=
 =?utf-8?B?WVdkYmNndnlocVprRzlicURuVytSdFBKOFhubkhnVDNBdGRQWXVWY0NENFd6?=
 =?utf-8?B?VjUvOHlNK3RyWUgyWEQ2TStadTJ5Y1Ftc0JXanB4WS9HVlNrVnc3aWpVL0hs?=
 =?utf-8?B?TEt0dUJBcit3YURRZTN1bDd4Q1RGYnExRGxxUVZsSHdVMkpZejFmdFFJWnB6?=
 =?utf-8?B?MmR2MUNxV0t1TmdFRldkTUR2SGRvNTJpZHk5NVdpd09TZVJ1eWN4QWs3VFlm?=
 =?utf-8?B?Y0lkcTZBYVNBMDFXcFlnTExYaXpCTVNFLzVTZDhURXdWdTlRalg4WGIzUVdH?=
 =?utf-8?B?d29kdWN2a05pYjNCYTIxTjYrR1FxNzBmcEg3VTB1bnNjRGh6M2Y5Wm1kREwx?=
 =?utf-8?B?ZDA2TytNWjJCbC82RHo0b3RjVFd5bEdyMHovN3o2cWwyOXZ2UUQ2SnRqTkk5?=
 =?utf-8?B?UlFuN0F0ZzlvOHhHbmJTb2YwUmlVT2pMQm44bFlvM2JrcVVEdC9qQldpeTVE?=
 =?utf-8?B?VXhLWlUwUjQwbHVET09FV3FRY3FFcFlUVEwvV1JUbnJoVnRQZklzMDM1S3No?=
 =?utf-8?B?ZHZHNEJ3MDNBK1BQWFNjYVR5ck9qMWlzYjJTSG9mWnhqVWQ1dUxYUGk1eHNH?=
 =?utf-8?B?TlpiRTNGRnhHdFJPdnlNNlVvQk83dWRkMWd0OWlTRGZmc3ZQZ0V2NGdNWStQ?=
 =?utf-8?B?V2hzcFM4ZVRRQlN2S21GdlN4akE1L3djdGxqRWpwM1QrVDA3U0ZLc1R3MUF6?=
 =?utf-8?B?WHhuMTAzditram5laHFyQTFldDBIR0R5OHNONUhoM1plZEg3WllLbDFVRHpp?=
 =?utf-8?B?amgvaEFpNGJQcWRqeVhrS3ZiK0F4bmhoRnRReXV2SkJKQ0pLV1owSkZBeUdD?=
 =?utf-8?B?VFd4dVZTa1RYUGFEU0hQdnRzRmRqRXpiSmR0TDV0eDVmTlhtK3l1d0lGRzdu?=
 =?utf-8?B?eU9KaEg5UVNDUDFSNG5nMGFvY2lvVlFzTU5pZTA0MlA5U0RIak84bjd6em9Y?=
 =?utf-8?B?SFpaUElaMm5sUkwxdm9qcHZlVklTN0EyajI0dC9BUjhxMk83NHZQdGZ0aHNI?=
 =?utf-8?B?SjFXNHRqRVlXeU9sZlFWNFU5OWtTck9aTmhndW9WTGJOZ1ZhT1BxMmJNWGhy?=
 =?utf-8?B?N1E2cHgyd2NSbEh4SnhBZEN4Z2wxVlBoMEVycS9VV2hFT0JNK0VWZXNERkFG?=
 =?utf-8?B?d2pudVRndFdGcVZTVDBtdUQxSVRKNEJPV2dqREx0a1ZKY3Z3TDV2aHVhMzFx?=
 =?utf-8?B?azNjTllxSVF1bzhleHgxOFFOdEVmTkJLbVpaNk4vZHREVCtMV0ZCTGR1dlFY?=
 =?utf-8?B?dFN3V3RIbWg0KzhGS3FxM0FpbDdSUjgzZkhMY0lBeVJVMUMxZmxIQVlKV2tk?=
 =?utf-8?B?NEtRS2t6WWU1OU1taVBmNDdkS1AvUnM5WWJ2UVZoNHpxSTlZbDJUV1Q3NWZO?=
 =?utf-8?B?MFBUcThFN2d0T3V2Uk5sRnhzbVNvUmt3U1UxQjZOdEk4a015WU9jWlBRMXpy?=
 =?utf-8?B?WEl5cS96M0IrOGUrcXBVNTVsRjJ6OTRUN05kaTFsRVlzaDhuTmpzQjByak8r?=
 =?utf-8?B?ZHJmVkpmNnBVT0JpajZkTU95a2VQVnBOaEFTb0tzOVZUNllnYWN1eWxwWFow?=
 =?utf-8?B?TnBPQTV1OVNiNDhuTG5OYTlBc3NyUmlEbUFlV2NhUzR4cWF0cGgyT0QyamZV?=
 =?utf-8?B?THl0VGMrdHdJd2xadUduMHdQZHpJUWxJNFB4eHFBWmczbEN3bG1BZ1VTVVFk?=
 =?utf-8?B?TjRyaXNuM0ZuSjB4OG1PZUs3Um10ZUJyVFNDYXJFeE8yZlJNSVZUZGNWVUNr?=
 =?utf-8?B?Ym1EckFCSFlHZ3ZXb0pheGJsQ3I3eFU3Y2RPUUVsbEY4aFcvd0xwam9YeXdy?=
 =?utf-8?B?WVhJN1c4ZWZ4Z09LQjhWSVFhM3JHbThxVFB2cHlSMEhOTmI2YmIvUFNoZ0RS?=
 =?utf-8?B?RzhyL2c3OUNGcmYzL094WmdJOXR0Wi9NL3N4U3BmVkQ0ZUFTNE5yQVZtRlNt?=
 =?utf-8?Q?kQRbzy9yxE57GiAhqBXKG+4jX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53dfd92f-dc0d-4ee2-4221-08dcffd6b93f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4262.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 09:21:28.0197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wr6YojbNULGF6KL6P4CWnjd7e45wdv4cratEVAgYlf8MSwOgPzUWOMSktLLIR3dNTGD7VuAlBbl2yc9S27Uo1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9439



On 11/7/2024 8:40 PM, Matthew Wilcox wrote:
> On Thu, Nov 07, 2024 at 02:24:20PM +0530, Shivank Garg wrote:
>> The folio allocation path from guest_memfd typically looks like this...
>>
>> kvm_gmem_get_folio
>>   filemap_grab_folio
>>     __filemap_get_folio
>>       filemap_alloc_folio
>>         __folio_alloc_node_noprof
>>           -> goes to the buddy allocator
>>
>> Hence, I am trying to have a version of filemap_alloc_folio() that takes an mpol.
> 
> It only takes that path if cpuset_do_page_mem_spread() is true.  Is the
> real problem that you're trying to solve that cpusets are being used
> incorrectly?
> 
> Backing up, it seems like you want to make a change to the page cache,
> you've had a long discussion with people who aren't the page cache
> maintainer, and you all understand the pros and cons of everything,
> and here you are dumping a solution on me without talking to me, even
> though I was at Plumbers, you didn't find me to tell me I needed to go
> to your talk.
> 
> So you haven't explained a damned thing to me, and I'm annoyed at you.
> Do better.  Starting with your cover letter.

Hi Matthew,

I apologize for any misunderstanding and not providing adequate context.

To clarify:
- You may recall this work from its earlier iteration as an
  IOCTL-based approach, where you provided valuable review comments [1].
- I was not physically present at LPC. The discussion happened through
  the mailing list [2] and lobby discussion with my colleagues who visited
  Vienna.
- Based on feedback, particularly regarding the suggestion to consider
  fbind() as a more generic solution, we shifted to the current approach.

I posted this as *RFC* specifically to gather feedback on the feasibility of
this approach and to ensure I'm heading in the right direction.

Would you be willing to help me understand:
1. What additional information would be helpful to you and other reviewers?
2. How cpusets can be used correctly to fix this? (your point on
   cpuset_do_page_mem_spread() is interesting and I'll investigate it more
   thoroughly to understand).

I'll work on improving the cover letter to better explain the problem space
and proposed solution.

Thank you for the valuable feedback.

[1] https://lore.kernel.org/linux-mm/ZuimLtrpv1dXczf5@casper.infradead.org
[2] https://lore.kernel.org/linux-mm/ZvEga7srKhympQBt@intel.com

Best regards,
Shivank

