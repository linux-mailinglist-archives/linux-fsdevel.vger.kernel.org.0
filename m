Return-Path: <linux-fsdevel+bounces-52580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1D1AE45FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 16:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB270188A575
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 14:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BA278F5E;
	Mon, 23 Jun 2025 14:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qhryngEY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069D5770E2;
	Mon, 23 Jun 2025 14:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750687733; cv=fail; b=Zuf/bKKj7ca+6N99AGq/goeaTwwRwWlQkThDaj8A5bFQAnbYFpz9bmsyn4aMgpFgnP/EFrfSLkDvqdXDJJWbA7c1Wz4YQfnZC/23w0klCq6dNCg04RXY5OQMMTnV0t8rlVH1SUqDKh3Ezt4DpFRxvHkcijjhZM8IaFpAYrNhbeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750687733; c=relaxed/simple;
	bh=dtZ6l8GIVhdnf7UDsna0C5nnVhAz7532ZaAR4g/XBrg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l3X5zg4YOqg9727AqWPOZXBmUL0zoMCfRq73eBjXtaAWUNaEg+kPKXgifwrGM0Wvs7U6fEHGcA9Ek/tm/rgK1h2cqRsJ1cNklti0dwb8vh+CbTu4RGLuevkbLhaXmVYbcoFRYNXiMi26b5905uFJ975mkm51kqhN1YruWVSNh78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qhryngEY; arc=fail smtp.client-ip=40.107.237.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qGErBlMQmoHgkwxHme72mm0xs+i/jdIt9Qbtm8moXOMGFjG8WXQ0hjBGSgprBTs6A4ImPQjSIEHoIPjMW0SI43Gd4GJ/Zc4VZTgav++jvr4Yj+R8T8m9MS0hD/GotZAZbFRcLjcahKL1mNsAMOEX+Ue5h30Ie8rYbEDf8ZWYmskDU4sUTmpc160dkMm39AQRavKragbIOVQ9M2ljTytxMSJeWKsauZFRH/jpVlHiCGQy56ErqcBlkFOLE29nIz7gK/HCGcvuzocNFAfPV62QwwYBdsn6g+SanU2kub1iFMFsaMBnsVwYPSlOUxtsgDv6fFQVRQTYGoIZYjFWEx3DCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jy63Rf5GsJs5Jq64gObCqMOWeBw7OfMCGCKTaYGoUxg=;
 b=tZnyGFzBDn6SKq6YkA2IF1lUmU8O5/z6zO6lYQmxDoZMTtVBqjWaeB1GOitJ4+zvrd/XjIdv92ploNQ1mJe9dRs9XV/5W1c72eAktpezidCXJp0s40HnKhXU5nMJnDSnO5u7odjN1RGzKJZ9oroC9p7OHGGdRHAtDKjH72VKS/hOC7tNEn7VmfknQFECvj7SBXtGWYMUnVdy94JmL7phIQFj93mubtc0sLP+MgqaNXykRjyTPStxC63VQjbz6GI3fbNeJcHtpvHWRKvoTJeOHqAwTOqFTR59EDLBJrlAyHAm+pQUz9I3yOzr3PonhSqJ76vvKl5oHimc/Ghd+DWV4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jy63Rf5GsJs5Jq64gObCqMOWeBw7OfMCGCKTaYGoUxg=;
 b=qhryngEYQaKzqXFVbC7ylk4xzrjREn0fOqdFF2TizBJ/75Onl7mHjS+RvuF7Ua7wInZzOyl6lWMQE1D7net5KGt8uMijAIqNpta2eY4juazK83QR08+pCc67wMUxpdvWN/xkNctdsRDv7a9VMq4AVB+dd/XzoZ05i+RUiPLnKOM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPFDC28CEE69.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::be8) by CH3PR12MB8510.namprd12.prod.outlook.com
 (2603:10b6:610:15b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 14:08:48 +0000
Received: from IA0PPFDC28CEE69.namprd12.prod.outlook.com
 ([fe80::7945:d828:51e7:6a0f]) by IA0PPFDC28CEE69.namprd12.prod.outlook.com
 ([fe80::7945:d828:51e7:6a0f%4]) with mapi id 15.20.8835.025; Mon, 23 Jun 2025
 14:08:48 +0000
Message-ID: <3114d54f-ed7c-4c68-9d32-53ce04175556@amd.com>
Date: Mon, 23 Jun 2025 19:38:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] fs: export anon_inode_make_secure_inode() and fix
 secretmem LSM bypass
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 brauner@kernel.org, paul@paul-moore.com, rppt@kernel.org,
 viro@zeniv.linux.org.uk
Cc: seanjc@google.com, vbabka@suse.cz, willy@infradead.org,
 pbonzini@redhat.com, tabba@google.com, afranji@google.com,
 ackerleytng@google.com, jack@suse.cz, hch@infradead.org,
 cgzones@googlemail.com, ira.weiny@intel.com, roypat@amazon.co.uk,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20250620070328.803704-3-shivankg@amd.com>
 <f2a205a5-aca9-4788-88ff-bfb3283610c5@redhat.com>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <f2a205a5-aca9-4788-88ff-bfb3283610c5@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0159.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::29) To IA0PPFDC28CEE69.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::be8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPFDC28CEE69:EE_|CH3PR12MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: eb58cbfc-e553-48f2-3ab0-08ddb25f7928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGtNdFVMUlYxeWFxVUtSWTdpS2FoQXp2cjVlUkJtTWJST3Vtd2pna0t0MXZo?=
 =?utf-8?B?ZnJTM2t6S1ROU3FBdzJqR2k0QWtKem1SbDYzV1BNejJsYVFoU2pGV0p0NXBX?=
 =?utf-8?B?R0t6eXFSWWllai96UW5kQXVHTGJkYlZ4SW1PZkQzZWUvWkJObmpHWklIbHBr?=
 =?utf-8?B?MlJidTc4N3g3ZFNCZjNkK1VsbmhjdldCUWRDMXRaU210QTZ4N2lDdFQ5S3hP?=
 =?utf-8?B?OXJGT3dtYkRReno4bldEVWJ6aEYyNG5XR1g0ZTFjZzJVUEx4Q3lOSmNlSmlD?=
 =?utf-8?B?ODlnb3Q1MExNOE5YNE9PYXlOZDdzMWJCSFVGZFRNNEgyeG9iZXZBc0IxOWVU?=
 =?utf-8?B?MDFjZEVKcFFoUGJLMjl2dXhvSWRETDVHU1JEaDRLQkxwVytvMFk0bzRoRnR4?=
 =?utf-8?B?cEFvMVcwR09ZV2gyZWN2UThoT3JxVXRKK1N0MjJ6MjhFUkJhS0tjb0l1WkQ2?=
 =?utf-8?B?WS9CdVJsYjkweXc2Y3plMWovQ2N5SzcvVk95RGVHeFo5Z1lZdVZQQzlrVWFn?=
 =?utf-8?B?WkJwUE5lR0k5OUNEMHRRREtpejd0Vm9BNjVDWXBqVThQaVN5OTlCb01KclJO?=
 =?utf-8?B?VUlrSGVwTmpucVJjamlLTTZwcnJWdUZZbTFPbm5Bc2V4MzMvaVlSYWNRME0v?=
 =?utf-8?B?VHh6U0N4TWl6emh6MDVEQ0Y2djZNbGhJSjRqeEptSFN0OURkWkpTRE9uS2pp?=
 =?utf-8?B?aEtBMHlsbG5OMnB2T3dWQ1dGM29QRVk1eFZRS3htM3UxV2tpcWh6U24rd1l2?=
 =?utf-8?B?Z0Q2cWRpSiswdWRBRzJ5M09uTDRCMFlMcHNoZDF1R2M0YkczZGlsSGtzL1Yv?=
 =?utf-8?B?ZWszdGU2c05ReU9YRHB1Yy93QmVERHJCYWpLQkM2dFFYTTIwekpVcnMzZ243?=
 =?utf-8?B?aWpDUFFoaHhWeVNUcVFQQlBZbnBWWHU1S01ZS2JJYXAvVVBJZi9ISjgwSXpk?=
 =?utf-8?B?aU55cmp2V2VhWHEzREtJQW5yMDl2OVF5TDRqZWo0YUk0NzFhV2NBUkRRRlc3?=
 =?utf-8?B?eFlRSWhEeW05OFZ6Qy9BbnVFeFd4b3g0V2FObUVxTy9nNEp6alRSNk51THRp?=
 =?utf-8?B?bmh5Z05Gb05NSEZUYlhtL3VIQXlHWCtFVUd0LzFYUHI4RHdWMjFLSzJCd3Zl?=
 =?utf-8?B?cFFUc0FackdTK3p0YWpZSzZDeFVyRzZhVi9EL3BPZ3RiOTlQZUd2RFhkWTly?=
 =?utf-8?B?Y2lQVE9maHUzaVJFTEVDU2dyOVZiQlRYZUNVRm5HWWpYQkhuUmhwdXpUcDQ3?=
 =?utf-8?B?TSttRld4UlMvM1BTQXY5aVhqd0k1aUsrRisyMTlKSHBCRkNSUCtHcm9XS0NN?=
 =?utf-8?B?QW9adzJFRmh4dStFUmJyanBqUVZpYytBRlNSd095MHJyZFExVFBKYy9nRXBT?=
 =?utf-8?B?MU5PVW00encya0pCbXFoLy9ITTRlUzIxY2hnK29iYkN5VzUrS3BjOHNRamRX?=
 =?utf-8?B?cVp3Sm5NbXdLMWVlNERwdkM4ZlNCR05UbnF2eVN1MEhEa3d1Q2s0U2VuekZH?=
 =?utf-8?B?emcrU0pEZXBoais3angyVU1ZOVVOOVByYlRTRHdtN0dMQzJVL0VmckEvYitC?=
 =?utf-8?B?RnI2ZmdSRnFTNWI0UjlZSThmYWJ4VXY5bWR6ME5OVEZpdWdNeWRzc1lNVlpu?=
 =?utf-8?B?TVZnT2QxMyt2ZlhSWUtmMjc0ZUFjNGhzZFo5SmZ4Q3dBTFZNRUJnQlBkaEtR?=
 =?utf-8?B?ZkoxUEZXVC9IMkE3Zkd3aUd4QmVIL2dmNVhmbFVVODZVcFZDSmVKdVJtMEJK?=
 =?utf-8?B?Wlpqc1RsT0FCQmJmWXVFWFIvNmhiSUxMMkxhZVp6bkcvL3p5WE9nZ09OZWFY?=
 =?utf-8?B?UVEyQzRuNVZudzVnTm9HcWhkR3lyOGJUZDREeUZJZzVuM3Z1YlVISzdlVFB6?=
 =?utf-8?B?Umd5d1VUenpDbVpyZC9TdUM2ZElHZCsyWGRidkJ6S3M5dUU1bGhzd1JMTzlN?=
 =?utf-8?Q?KcF/xMHGjWA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPFDC28CEE69.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTZSTi83dlJ3MEhzZjJRUEtLN25oZHN6em9wNldHOE1jTWVML2hTTTY3MFpy?=
 =?utf-8?B?b3YwNDVUWW8yRXN6bUNSWVhMK21JT04xc2FNeTJBaW8xMk45QmxnazQwb1dP?=
 =?utf-8?B?bm9ZR3Y1SWE1Uk1lOVNVNGZHMzRyMVpPWlBkY1VKTUlDU2VMVkhOWWd6Wm9J?=
 =?utf-8?B?OTJyajExMXJrSjhyajFLS0FGVUkwMTZTYUpFVGtnSnp3RlNvRStqKzR5bVVr?=
 =?utf-8?B?UWRwSkE5N0tWSUkwRGk5SkR2TXdGeGhucWpCSkhZdERiOVhqUzJzN0VjNldr?=
 =?utf-8?B?M3FzVzJsV1FPcVp1TTZKbEM3MHFuWjVkckZ1QkM1QzdIYzVQQ0x3R2lxM3VH?=
 =?utf-8?B?dGVoUklPd0VNQTFBSGxtbnIyQUxZaTdFQ1NsSS83SkUyYmpDd2lBL2hqclJz?=
 =?utf-8?B?MzhHRTNVaGNUQ1JXZzM5ZEVmN2ZneS92NUFhcXdjM285UllnT3JmRkFjMHRr?=
 =?utf-8?B?czkxVHc3Qyt3M0p2eTBkb3A1a0dxMzRFbjcvRXQ5SHYzZzczclE5UmVBb3lm?=
 =?utf-8?B?VVJGVXlWSUJMU28xYkxzR2dubE5Gd1orSjRaNXh2aG0rZTJKVHM5N2FEaERO?=
 =?utf-8?B?cVhUMy9QaFQxbTk3NytXN3RWWVZNcVJDbXhLS0NqajVwRHNCYU1OVzJDWDB0?=
 =?utf-8?B?MjY2SDAyeUZsdE9PeC9vQ1orNVlidEZXMGdPd2RKQ1RyRW4wVzN0bmo1NkZO?=
 =?utf-8?B?amNPRVdOVkhpQUIxRFNYY2tkVlpEN3VrTmEzaUpjVWN6NjRUQnU3NUUzMTFp?=
 =?utf-8?B?SVhxZFUrQndXM1hHRDlYNmxXL2Z5NktmZ3pneWZTdkhWYmJRLy8zeVdSMng4?=
 =?utf-8?B?elhrVENycE1laysyL1B5YjRyRGM1MHBYNFF0MWRiMjFoYmowSnRZNVd4VitG?=
 =?utf-8?B?aVZyY3FldnVOajFVemJvVEIvOEpYR0R3aVlqdkpQN1g2RlVua1ZaZFBIbmlI?=
 =?utf-8?B?V1l0RWZtV2J4WFZCd0pZYnJIT3BnNERaa2QvYzdBajlab2hZbUNWU0M4V2pi?=
 =?utf-8?B?Vm1LSmdkZUl0NmpZSm5INUt2Y2Z2TkFEc1JrWXB5R1VpTjVTVTBNb2xCaU82?=
 =?utf-8?B?a1JGMThSUk5oZUFjeUVoek0xOXZFVFRxWlVUVml1OUJuUGNuZE1hSmpNT04w?=
 =?utf-8?B?akZlNGZOdGwzK3BxVDBrazZqOW1VeU9oRzF0dU5SWEZHZU14enBkU1VqcE1j?=
 =?utf-8?B?YjFZNzJ3Q3htaEZ5UXBZSEZlUWI3Y2JKWHFkL1R6NVhUUzhBVHVDemZVSlA4?=
 =?utf-8?B?WUJ3VFl0ejNsSWR2SFNzdGZuU1JqTHdxbkdQa2NEc21SZU5tV2NzRzBycUNT?=
 =?utf-8?B?dTZvdFh0OXhIK2FCYUNiSUZqdFJnV3pZNVFtc3JFME9kOXNzTm84NEFWc21F?=
 =?utf-8?B?d3VGZGVSNkNKc25obzFVei81bEVQandrczRDbkZTaUQxTDAxODd3My9ORmlW?=
 =?utf-8?B?dFdkazBicGtIVWl4aVFXTlgrcVc5QnZNdTdJdmFiOXFURjQwRlFZUmp2elpE?=
 =?utf-8?B?ai9MUEZVOTFZaXJyaWorK2F6SERXL0tpdStIbkJqbjVnSUpLcW5CbU9VWnpt?=
 =?utf-8?B?aXo3MzZ6TVQzZHpUdlhLL0tFczVaaEZJZllwRm1mem83b1RDbkZHb0NKRlR6?=
 =?utf-8?B?NFZ5WW9YOEUwMWtRa2hQbmphcmdtTXhyWjNCZ2cycWdXVzhUUG1jTyt4eWdN?=
 =?utf-8?B?bmJidjQ3dHFScFVaQ2h1QzJqVGFtdm05a1E1OVFSYlNnc2xvRzI4ZlZZNE1Q?=
 =?utf-8?B?UnhvNWp5L2s1L0J2OEd4SE4rM2gyTGduY2ZIa1FoRnZKNW9vSTB3M29uVkZq?=
 =?utf-8?B?eVIzMmcybllCY1FldlFwMzFHOVFBSjAvYlJXUGxHRWZCUEF1Wk0zSHV0cGQx?=
 =?utf-8?B?N2wxancyYmVmcXJIVk02N0dVdEdzcVNOdmZuQmIyUHBGZnQ0MGlFWG0vQU9s?=
 =?utf-8?B?MHM4NUN4LzNIcFFPNWh1QWVQRmZGVkZwL2ZtNW5QTjBVK2NDWGM0cUlBRG9X?=
 =?utf-8?B?cjBHc2JxbUIrSmZhcHhtZVdOUU5oRVNJeUtGS0ViSFMrdjMyaXFwOHNhZ090?=
 =?utf-8?B?NFY2YThZU0lHanFCN2pyZkxtTysrVTNNbEJLbDhiM3BMV3k2YnRYYWdHU3lI?=
 =?utf-8?Q?B2pFPH+MArUNXn9TI5ISLokrA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb58cbfc-e553-48f2-3ab0-08ddb25f7928
X-MS-Exchange-CrossTenant-AuthSource: IA0PPFDC28CEE69.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 14:08:48.2348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aBTJUomTaWaRe+DWi2Yn4cykB6SXIWpXg2BYIFw1WORHnxE+nwuXLxcVPsd1VfJI0WkYQlq/X6SeuTg+8CgSZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8510



On 6/23/2025 7:21 PM, David Hildenbrand wrote:
> On 20.06.25 09:03, Shivank Garg wrote:
>> Export anon_inode_make_secure_inode() to allow KVM guest_memfd to create
>> anonymous inodes with proper security context. This replaces the current
>> pattern of calling alloc_anon_inode() followed by
>> inode_init_security_anon() for creating security context manually.
>>
>> This change also fixes a security regression in secretmem where the
>> S_PRIVATE flag was not cleared after alloc_anon_inode(), causing
>> LSM/SELinux checks to be bypassed for secretmem file descriptors.
>>
>> As guest_memfd currently resides in the KVM module, we need to export this
>> symbol for use outside the core kernel. In the future, guest_memfd might be
>> moved to core-mm, at which point the symbols no longer would have to be
>> exported. When/if that happens is still unclear.
>>
>> Fixes: 2bfe15c52612 ("mm: create security context for memfd_secret inodes")
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Suggested-by: Mike Rapoport <rppt@kernel.org>
>> Signed-off-by: Shivank Garg <shivankg@amd.com>
> 
> 
> In general, LGTM, but I think the actual fix should be separated from exporting it for guest_memfd purposes?
> 
> Also makes backporting easier, when EXPORT_SYMBOL_GPL_FOR_MODULES does not exist yet ...
> 
I agree. I did not think about backporting conflicts when sending the patch.

Christian, I can send it as 2 separate patches to make it easier?

Thanks,
Shivank

