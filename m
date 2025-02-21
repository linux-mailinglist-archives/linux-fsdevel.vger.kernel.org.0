Return-Path: <linux-fsdevel+bounces-42323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 937CEA403AD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2025 00:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D9EA17CCE9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 23:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4F11B0406;
	Fri, 21 Feb 2025 23:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mdDBot64"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9342C206F01;
	Fri, 21 Feb 2025 23:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740181645; cv=fail; b=JAQv1gbSVleC2IUncF23pTkATTx//y1rJO0ln2EvnqBGH458j6f0MP8qDvbOrJTtOZ41lafrMNUA6VThnqMc0knKY90tuuBjrDB14DGRvHYHU8jTKh5sgurbt1/fImVX77dgLjehc9DrscdRvPoi7VFjyWxQ5XwARO6ppqvcmjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740181645; c=relaxed/simple;
	bh=ZU9t+YvxojdtStPHEzImS2w2i2dukntPTu5jKy79sZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=drtU2jCClGePrbp9Ul8GuMK4CzEwVO1scGolBeBVaBo6dOxabyvZzYQO5I1eQGTEHofujNrGQtpiV/YuZolNzXib05H4iJh4kFkINRPu7s8BNQwMVS/IXL/aK52z9ZqwlnUK/nJRbNWVW+/IYXKSQOJ4PvWUODjDeEI5gi0uzmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mdDBot64; arc=fail smtp.client-ip=40.107.223.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s9VCPwkCZdE7xfUmWjQ3CdL0e8Zs9GgjshoKMKS3A/yWgMD9ypHbx43UtlUfdAOKsapFb/ZDqJXx+cspxhXObI7Mw2AbkNnwyr9TWKs0GgQddrATOJTiArXMYnEdA3JM8DZ2/0wiW+akFOmPUjKfzc+6fVHlo1T77lhhuidM1QmXlCTiurOMQ6TCaux5BzcEPbTs/lmzGekZvyNsp5ydorqPABVszn3SKmFXoybYP1SSoODm0pwe5OZ50/S/Sexi2p/ZlQSm++WRmPLeKan0Uq57AxO5HMSeFjhAjLTD0erAYLsxQzllumXZaQ+1MixWtdOgvNWjL6qcEGsICBYnew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytQnO5mi33tuoH7nlS/i40E6ExO6ME8dnxClsoUlwtM=;
 b=P1zNBgSfXDpiudsW7fka2AR9VArm5H8WQ/hdSOrvoZLCLKcXEFfaso4kx6fwRuJC9jzPcxhxx91AhjT79ordgN5KOPxhMpLMwpSTK0Ps7exmHka6o+uVrdtRkt2vtB/1fZlX3dyWRWdNTUWKkbQXIrQojlEEFXiv9CHJ+TKqyYhVr29m/302zKcdbOWdRN4ZZSUw/WFy2a7s/XP366Qk2H0kfA0RsQHh7D8qEAyCiP/09tuhXMEd0aVVJJNaDeGlUKR558Lh5bj8NgCBqdDLBzavYk2MLFME5u9AKHJYcl14h1kUwpjI24kK/J+kV2OzvNBPeg65yuzPFFetwUdzrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytQnO5mi33tuoH7nlS/i40E6ExO6ME8dnxClsoUlwtM=;
 b=mdDBot64I6Nzpb83XAtZfIxnJjvVUwOXn8adHwcCpSA5ZpNyT78eQMMGrNhh4YRCCMJRN3ZAd7ELdOGtsHrLYNo6Dl1AiLwm7/GBWq4+weV6Y1OyvEnPDOOr1qdfETtBO2A1OZl+j6bH5IhATIkg1DEVACf40o8oGqKReKh9VMCkk21WFel/mIV4zNhMUgDRnF8a3HkrD7ClkV0WXFfwGLgRTKix1478KXKsTIXjq8ZR2Dt6xgBXQkU7ZPd3VHIxhjPVz94zS3gxS2fUSpHHJFt8034dTNYz7LoGuQKInlvJ0Q6gMS6wHSQDjyLpEn/ERLn6EV41z8oq6ItkUmbv1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SN7PR12MB8435.namprd12.prod.outlook.com (2603:10b6:806:2e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Fri, 21 Feb
 2025 23:47:20 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 23:47:19 +0000
From: Zi Yan <ziy@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
 Kairui Song <kasong@tencent.com>, Miaohe Lin <linmiaohe@huawei.com>,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 2/2] mm/shmem: use xas_try_split() in
 shmem_split_large_entry()
Date: Fri, 21 Feb 2025 18:47:14 -0500
X-Mailer: MailMate (2.0r6222)
Message-ID: <7090090D-4E74-4A6B-9B09-D2045AD616F0@nvidia.com>
In-Reply-To: <edd6e5fd-f6d1-420c-a895-2dae5fe746ef@linux.alibaba.com>
References: <20250218235444.1543173-1-ziy@nvidia.com>
 <20250218235444.1543173-3-ziy@nvidia.com>
 <f899d6b3-e607-480b-9acc-d64dfbc755b5@linux.alibaba.com>
 <AD348832-5A6A-48F1-9735-924F144330F7@nvidia.com>
 <47d189c7-3143-4b59-a3af-477d4c46a8a0@linux.alibaba.com>
 <2e4b9927-562d-4cfa-9362-f23e3bcfc454@linux.alibaba.com>
 <42440332-96FF-4ECB-8553-9472125EB33F@nvidia.com>
 <37C4B6AC-0757-4B92-88F3-75F1B4DEFFC5@nvidia.com>
 <655589D4-7E13-4F5B-8968-3FCB71DCE0FC@nvidia.com>
 <edd6e5fd-f6d1-420c-a895-2dae5fe746ef@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN9PR03CA0911.namprd03.prod.outlook.com
 (2603:10b6:408:107::16) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SN7PR12MB8435:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f0968d5-d235-49cc-de70-08dd52d21410
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVhNZkQwTzkrSks3aHQvTnovd1hxUFJnOVdBLzhVanBhY2lNQmdSd0JGM21w?=
 =?utf-8?B?T00xV1ErL3dXdjd2anc2RmFQYjBkU2U1MG93eEQzdVpIczVzRUlnVzU4Q0xP?=
 =?utf-8?B?RmxuM1pqSkNOTjN0NmJyZXA3bVBKVFpsQ0FOZ0sxLzdKL0Nnd2RUejM5azB0?=
 =?utf-8?B?OXJNYkdSdVFZVmZFWHhhMElkeE5VcVdJVmtyN3p1WmQ3ZXloN0pJODlpckRu?=
 =?utf-8?B?dGNiR1RVWk56MzhtMUhCdEJUd1B0bk5DUXpzcDF2NzRJVXFlaHFDelBVczVI?=
 =?utf-8?B?WldSbW54QkhRZG1pbzRra0hkU0V0b2FFK0VkQzVmTjZnYWcxeDBCTGZudndG?=
 =?utf-8?B?NXh3eUZlVnpYNG9lZkY3WWNkYVpXK3JDNzIvWEROc1R4aEpuVFJRd0doWnFE?=
 =?utf-8?B?Z1NoVHkxUDZoOTV1SmtZLzNhREo4c3duTVdTZmdQUGJXeHF4OGRaK09qMkVR?=
 =?utf-8?B?bDlRR2hwQkZNT0M3S09aQ20rL3pMYTZDSjc0NEI3K2M3M0RKTkNESFUzay9G?=
 =?utf-8?B?QjVSN1lMbHJTamJWbUkzTTlQMFE4TEJnVFhxdDkwdXFjazNtVHpIOGVRUVAv?=
 =?utf-8?B?OVlUbjIvRS83K2dhaG13eHdmVERXU0hYUkZZcHJORFJmeDZKcDRTSm1vTUJt?=
 =?utf-8?B?dzFsOWh0OHhEaTlmbmpKUXJ1S0FtRzRORnBndER2WDVBUlowVUx3RDI5Z1Yy?=
 =?utf-8?B?anJ5aUdUNmd0MVIrWk8rb25BWGgvTTE3TmFBLzVJeS9nTE1LWmZ1cWlLS2Fu?=
 =?utf-8?B?WlRNQ04rd3Y4dlZVa0ZPU3lpWTUyM0EwcTNWdmNqZlQ0NW03Mm96US82SGJp?=
 =?utf-8?B?bWE3SXcyY3FqYXpZbU5QdEFVS3RRaDBwMlVNaWdLL2pHT0hCbTdHNG9TTU5V?=
 =?utf-8?B?Z3B2NVdPNjRCNnFSZTMyeldzSm96Z1BhRE00ZVA4NnR2anhFUXZXYkZiL2s2?=
 =?utf-8?B?VlRVVFc1Q1d0MkpWQXoydHQ2eHlOL0R2cW9zanZMNFk2NzIzRktZNDVPTnVv?=
 =?utf-8?B?SmV6dTVPQ2Q3Qks5d3VOdGZNQ2xYL3BaVU5oVDdFSlVHU0tSY29RYkx5dEFR?=
 =?utf-8?B?UGRPMFcra1RFQUxuS0VHTHpYRjliSGdMMUFJZ1Y5SU5acUlSclBZeXMvYVk4?=
 =?utf-8?B?NDIxZjc3eHMwc0JvNERTSFFrN0REOTcwczNwS2RWYnZnQWJkWXBmejVQS3ZY?=
 =?utf-8?B?Y3k0eHdCY1lTZS9HMVN4L0JDMmgxMkxjVHkzTTNMSnBPMExhMjJhMk44RlRF?=
 =?utf-8?B?b3BoR3liS0JRRTk1bVh3dTdKRGdqN1BGcUFoc29HTG4vblQ5azBONjhGNURM?=
 =?utf-8?B?aGJ4S2ZtZFNvVXdpMmFJWjh4d1hFQ1JsbUdxeTl2WDRQQjN3RVAzK0pOcjFx?=
 =?utf-8?B?QTlIR3RTY1UrWXNaQ1ZIWmJPZGNHNHhmQXlSTDkrSkJrK1EvR0NheC9UMG5u?=
 =?utf-8?B?NldiR1ZKOWQxN2x0U1BiRThnSmUyazBZTUgrSDdoQ0NhcjZZTElyRDdpSVFL?=
 =?utf-8?B?Mlk3TWJGZFNxRk9lNGdCMXpyb3hnZFRybE1UMW5NMnprUTVGU1B0QlhLUkJ6?=
 =?utf-8?B?bEJxQlppSFNjYVNiaHQ1VXhMRHNhZ2lyZWFpQ0pwRytGUFlmTEpLdkRyTjYv?=
 =?utf-8?B?OHpLOTZKSmRQWVpDdE5yMEY4bmU2RzczdkZveGRDaWhLanJiNHlpNVhxYU9a?=
 =?utf-8?B?Q3BCTFh0YnVUeUl5UWVuTThTNFdXL2NSMTNOWjA1R1oxaFJhZVZBa2V2K2Rq?=
 =?utf-8?B?aHJaaTlaNUpCM0hJdEk0UWc0R2lnQmppNEtQbUQ3dmFNdllmaE1jMU5mUkpr?=
 =?utf-8?B?QlBWeEJyRXNDNTB2WGo1MmkyZDh5cFV0R2lUUElqbkMvZVc1Y3FGcTdoa3JT?=
 =?utf-8?Q?uhZlqp5NNk7T8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mk5iWGVwUXk5R1VHeGtIMFAzQmoyQ3JIL2FqWHRtcFhPWXhkN254SWEyT2Ny?=
 =?utf-8?B?d0drQ1hBNHZiY0NaRWtrMklPbGpBQ3p5Wjd0OHozVWFoTEg4ajB4a3JEbDJR?=
 =?utf-8?B?Sm9nKzZEVElNenJ2dmtYZFdpa3c4SWdUTUNtbHlNUk1LK0diSjFQRkpXWXNZ?=
 =?utf-8?B?a0h1RkF2MmdqUjdPeXIzVElqQkVWV3Z4M0NrNm94ait2ZDZwazEzNmc1SXZs?=
 =?utf-8?B?RTNWRSs2L3NYbFR6a2YwNHdHemk1amNNeXRIYzNaK25BQmJNVjJvbVdwL3NQ?=
 =?utf-8?B?YmFFWUhIU3hvby9VcnVqNzVBNStZa2VEcTlOU25DMElSWGJzazhQQnpOcUdn?=
 =?utf-8?B?V2ZtTmo3aUNDVzlWdEpqWFkyWE5aM1c5MlhOa1IyVzZiSXJmSW5odTFlL1Jz?=
 =?utf-8?B?bDFQZ3g0R2c3WVFUS3ZNOUtRa0xYK2JQSThpMk9xd2pTVTRSYitZc1VoeU90?=
 =?utf-8?B?cVVUZWhndUhxTEFqRzZGSGpleXpGOGNFWUtUUjQwdzhvUEpHQzdrWCtkS3NB?=
 =?utf-8?B?dDJpdytMd1dHandvK252bk8zRFpnY0FDWHozWGNjSVdNcDBiT1JrVDBrckdR?=
 =?utf-8?B?MmVtMlpzeHovVzVNTlpBSm5Mekdmc0JQaTFhOGtOOUtpQUdCUjk3ejRXRjgw?=
 =?utf-8?B?YkMwTU0vZHBZZUVQVFk5NWN5ek1mSUFwbmNyWVBXVkROMUh6T2QxL1p6RHRL?=
 =?utf-8?B?NThKalBaaDlhYlloaXdLdkhrbTJJczlSY29henF4QkZMM1RWTXVwV1hsVHZt?=
 =?utf-8?B?WXpHYjBDcFZFNVNhR095dEZaOHpGMTFFaGlUMVBoM0NwdUp6VmNvbW1SSkhw?=
 =?utf-8?B?bW5RMTVPL0J4ayt5QlB2bksvdE5lNm9aaUVYTXVJR2N2VXN0T0ZJOU5sOFV1?=
 =?utf-8?B?VWtRMGsyZHliRUFYTEkvWHc1ZHdFZEs1TFRNbFhZcUJDVFNYU2xvUGh1QmQ5?=
 =?utf-8?B?VUc2STkrdytVZ2FQRWkxVTB2TmxwbjY0M09na1BJWTV2YTlobE8vbzZ0Mit3?=
 =?utf-8?B?WlhuSDRlU1BzRnlsdEI1dnNyeXg3d2JVRXN4VVRwS3NUbTVVUzlOdGpDcWFw?=
 =?utf-8?B?SzZPMzV5ZzFBRVhCVS9aMTJ0OFExN0ZQQmZ3Q0VOTDg5bWo3dmJrbzBEbkVV?=
 =?utf-8?B?RnNldFpDRmhKRkhkWlJVU04vd3lDWGMyOUdpOG9GTzN3cjBoSlJDYWo3L1Yz?=
 =?utf-8?B?T3k3OVNhTk1TMEhsYlY3Z1dMdk56S2hKYUFmdjZaQThLWS90OXpDTUVrUllv?=
 =?utf-8?B?VUN6OENCZ1ErNGMzalpvZG5XanQ2b2RRNW4rbDFJWUVKd2dxQTZUdW9CMGJx?=
 =?utf-8?B?djJXMHR5ZGJyUURhYzdSOXFyMVN4VFlFTE5oMDRZN2JXTWh1N0tKbksyb1NV?=
 =?utf-8?B?TTZYLytvSU1vUjJxUHNFenlVQlpkMG81S2tSWklRWDRheGF3eG5XRnB6ckho?=
 =?utf-8?B?OFNMQXQyK2w3ZHBMNjlld1dDY2phMWtobXFjcWxHa3FtZEtBbm8zSHJqSXpG?=
 =?utf-8?B?YkhDS2kxSVFxbytkWFdVMlRYaDdGWDI5WFpvd3Vja25CalRvMzRFOE1QWjY4?=
 =?utf-8?B?UkZCNjhndVlPemxjVHNJSFJ3dFpaQmtaWW04RkxPQ280U0MyRE43eTJJd01P?=
 =?utf-8?B?Zml3bmVhTU9VK0piYUtLNWpTNktoZTNmYUMrNW8vSG0vVFZHeDR0K1VOTkZv?=
 =?utf-8?B?YVM3QnllRXVNSkU4aHBHUVNDUG1sNmxpRjFUb1pReURvbkVuWHdSTzBkVXlD?=
 =?utf-8?B?Q3ZERXl6d1dBSGw5OTgwZFpWVzA5YkQ5VzF4MHQyd2V0Y01mV3Z4b1hFMVpo?=
 =?utf-8?B?Qjc0Y1ltc0pFQnpoNUtLZzhEMjJvMWNGVjRla05EMzhEd1ZGa2JyZHliQXVy?=
 =?utf-8?B?bTJ3SjVZUkpnN0QrK2R4Ni9YZnl0eVlRbWZITWdHMGViOFhkOFZQa1RTNVVq?=
 =?utf-8?B?M2Z1QUtpcHpMWlV1Y2JCa0Z2T3VRTnlmSzFKcjIxVmZtQUszWUdEdnl5Y2xK?=
 =?utf-8?B?My9UWVRwbGhTaXlDTEgzYmZWNms0VTh3ZGJ5MFRpRXJzc0pOcTU4VXR4UTkx?=
 =?utf-8?B?SlJyVzExY1FJckZlSmxEWWl4bXFhTDhWR0Nld1JXdWgveTFtWnRQTDJRU0k4?=
 =?utf-8?Q?zIUE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0968d5-d235-49cc-de70-08dd52d21410
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 23:47:19.0870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TOypr5lbWQa26wYkQ1DILYTBg/LhGEO+3tnHfYM11aN4VteYRgbPPYOoMEx/yR0I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8435

On 21 Feb 2025, at 1:17, Baolin Wang wrote:

> On 2025/2/21 10:38, Zi Yan wrote:
>> On 20 Feb 2025, at 21:33, Zi Yan wrote:
>>
>>> On 20 Feb 2025, at 8:06, Zi Yan wrote:
>>>
>>>> On 20 Feb 2025, at 4:27, Baolin Wang wrote:
>>>>
>>>>> On 2025/2/20 17:07, Baolin Wang wrote:
>>>>>>
>>>>>>
>>>>>> On 2025/2/20 00:10, Zi Yan wrote:
>>>>>>> On 19 Feb 2025, at 5:04, Baolin Wang wrote:
>>>>>>>
>>>>>>>> Hi Zi,
>>>>>>>>
>>>>>>>> Sorry for the late reply due to being busy with other things:)
>>>>>>>
>>>>>>> Thank you for taking a look at the patches. :)
>>>>>>>
>>>>>>>>
>>>>>>>> On 2025/2/19 07:54, Zi Yan wrote:
>>>>>>>>> During shmem_split_large_entry(), large swap entries are covering=
 n slots
>>>>>>>>> and an order-0 folio needs to be inserted.
>>>>>>>>>
>>>>>>>>> Instead of splitting all n slots, only the 1 slot covered by the =
folio
>>>>>>>>> need to be split and the remaining n-1 shadow entries can be reta=
ined with
>>>>>>>>> orders ranging from 0 to n-1.=C2=A0 This method only requires
>>>>>>>>> (n/XA_CHUNK_SHIFT) new xa_nodes instead of (n % XA_CHUNK_SHIFT) *
>>>>>>>>> (n/XA_CHUNK_SHIFT) new xa_nodes, compared to the original
>>>>>>>>> xas_split_alloc() + xas_split() one.
>>>>>>>>>
>>>>>>>>> For example, to split an order-9 large swap entry (assuming XA_CH=
UNK_SHIFT
>>>>>>>>> is 6), 1 xa_node is needed instead of 8.
>>>>>>>>>
>>>>>>>>> xas_try_split_min_order() is used to reduce the number of calls t=
o
>>>>>>>>> xas_try_split() during split.
>>>>>>>>
>>>>>>>> For shmem swapin, if we cannot swap in the whole large folio by sk=
ipping the swap cache, we will split the large swap entry stored in the shm=
em mapping into order-0 swap entries, rather than splitting it into other o=
rders of swap entries. This is because the next time we swap in a shmem fol=
io through shmem_swapin_cluster(), it will still be an order 0 folio.
>>>>>>>
>>>>>>> Right. But the swapin is one folio at a time, right? shmem_split_la=
rge_entry()
>>>>>>
>>>>>> Yes, now we always swapin an order-0 folio from the async swap devic=
e at a time. However, for sync swap device, we will skip the swapcache and =
swapin the whole large folio by commit 1dd44c0af4fa, so it will not call sh=
mem_split_large_entry() in this case.
>>>>
>>>> Got it. I will check the commit.
>>>>
>>>>>>
>>>>>>> should split the large swap entry and give you a slot to store the =
order-0 folio.
>>>>>>> For example, with an order-9 large swap entry, to swap in first ord=
er-0 folio,
>>>>>>> the large swap entry will become order-0, order-0, order-1, order-2=
,=E2=80=A6 order-8,
>>>>>>> after the split. Then the first order-0 swap entry can be used.
>>>>>>> Then, when a second order-0 is swapped in, the second order-0 can b=
e used.
>>>>>>> When the last order-0 is swapped in, the order-8 would be split to
>>>>>>> order-7,order-6,=E2=80=A6,order-1,order-0, order-0, and the last or=
der-0 will be used.
>>>>>>
>>>>>> Yes, understood. However, for the sequential swapin scenarios, where=
 originally only one split operation is needed. However, your approach incr=
eases the number of split operations. Of course, I understand that in non-s=
equential swapin scenarios, your patch will save some xarray memory. It mig=
ht be necessary to evaluate whether the increased split operations will hav=
e a significant impact on the performance of sequential swapin?
>>>>
>>>> Is there a shmem swapin test I can run to measure this? xas_try_split(=
) should
>>>> performance similar operations as existing xas_split_alloc()+xas_split=
().
>
> I think a simple sequential swapin case is enough? Anyway I can help to e=
valuate the performance impact with your new patch.
>
>>>>>>> Maybe the swapin assumes after shmem_split_large_entry(), all swap =
entries
>>>>>>> are order-0, which can lead to issues. There should be some check l=
ike
>>>>>>> if the swap entry order > folio_order, shmem_split_large_entry() sh=
ould
>>>>>>> be used.
>>>>>>>>
>>>>>>>> Moreover I did a quick test with swapping in order 6 shmem folios,=
 however, my test hung, and the console was continuously filled with the fo=
llowing information. It seems there are some issues with shmem swapin handl=
ing. Anyway, I need more time to debug and test.
>>>>>>> To swap in order-6 folios, shmem_split_large_entry() does not alloc=
ate
>>>>>>> any new xa_node, since XA_CHUNK_SHIFT is 6. It is weird to see OOM
>>>>>>> error below. Let me know if there is anything I can help.
>>>>>>
>>>>>> I encountered some issues while testing order 4 and order 6 swapin w=
ith your patches. And I roughly reviewed the patch, and it seems that the n=
ew swap entry stored in the shmem mapping was not correctly updated after t=
he split.
>>>>>>
>>>>>> The following logic is to reset the swap entry after split, and I as=
sume that the large swap entry is always split to order 0 before. As your p=
atch suggests, if a non-uniform split is used, then the logic for resetting=
 the swap entry needs to be changed? Please correct me if I missed somethin=
g.
>>>>>>
>>>>>> /*
>>>>>>   =C2=A0* Re-set the swap entry after splitting, and the swap
>>>>>>   =C2=A0* offset of the original large entry must be continuous.
>>>>>>   =C2=A0*/
>>>>>> for (i =3D 0; i < 1 << order; i++) {
>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0pgoff_t aligned_index =3D round_down(index=
, 1 << order);
>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0swp_entry_t tmp;
>>>>>>
>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0tmp =3D swp_entry(swp_type(swap), swp_offs=
et(swap) + i);
>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0__xa_store(&mapping->i_pages, aligned_inde=
x + i,
>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 swp_t=
o_radix_entry(tmp), 0);
>>>>>> }
>>>>
>>>> Right. I will need to adjust swp_entry_t. Thanks for pointing this out=
.
>>>>
>>>>>
>>>>> In addition, after your patch, the shmem_split_large_entry() seems al=
ways return 0 even though it splits a large swap entry, but we still need r=
e-calculate the swap entry value after splitting, otherwise it may return e=
rrors due to shmem_confirm_swap() validation failure.
>>>>>
>>>>> /*
>>>>>   * If the large swap entry has already been split, it is
>>>>>   * necessary to recalculate the new swap entry based on
>>>>>   * the old order alignment.
>>>>>   */
>>>>>   if (split_order > 0) {
>>>>> 	pgoff_t offset =3D index - round_down(index, 1 << split_order);
>>>>>
>>>>> 	swap =3D swp_entry(swp_type(swap), swp_offset(swap) + offset);
>>>>> }
>>>>
>>>> Got it. I will fix it.
>>>>
>>>> BTW, do you mind sharing your swapin tests so that I can test my new v=
ersion
>>>> properly?
>>>
>>> The diff below adjusts the swp_entry_t and returns the right order afte=
r
>>> shmem_split_large_entry(). Let me know if it fixes your issue.
>>
>> Fixed the compilation error. It will be great if you can share a swapin =
test, so that
>> I can test locally. Thanks.
>
> Sure. I've attached 3 test shmem swapin cases to see if they can help you=
 with testing. I will also find time next week to review and test your patc=
h.
>
> Additionally, you can use zram as a swap device and disable the skipping =
swapcache feature to test the split logic quickly:
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 745f130bfb4c..7374d5c1cdde 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2274,7 +2274,7 @@ static int shmem_swapin_folio(struct inode *inode, =
pgoff_t index,
>         folio =3D swap_cache_get_folio(swap, NULL, 0);
>         if (!folio) {
>                 int order =3D xa_get_order(&mapping->i_pages, index);
> -               bool fallback_order0 =3D false;
> +               bool fallback_order0 =3D true;
>                 int split_order;
>
>                 /* Or update major stats only when swapin succeeds?? */

Thank you for the testing programs and the patch above. With zswap enabled,
I do not see any crash. I also tried to mount a tmpfs, dd a file that
is larger than total memory, and read the file out. The system crashed
with my original patch but no longer crashes with my fix.

In terms of performance, I used your shmem_aligned_swapin.c and increased
the shmem size from 1GB to 10GB and measured the time of memset at the
end, which swaps in memory and triggers split large entry. I see no differe=
nce
between with and without my patch.

I will wait for your results to confirm my fix. Really appreciate your help=
.

BTW, without zswap, it seems that madvise(MADV_PAGEOUT) does not write
shmem to swapfile and during swapin, swap_cache_get_folio() always gets
a folio. I wonder what is the difference between zswap and a swapfile.


--
Best Regards,
Yan, Zi

