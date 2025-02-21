Return-Path: <linux-fsdevel+bounces-42206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CC7A3EAD7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 03:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D18E019C0CCA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 02:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336BF1D435F;
	Fri, 21 Feb 2025 02:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DmAjR7cQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB5B3C2F;
	Fri, 21 Feb 2025 02:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740105518; cv=fail; b=mRX1/IbhDB1dh4e/bfluMIwnzDAvplx9RYFpwe4jsQRx1KRiPzjK1eap1HuksnUl91JmG466UOdKcay8vaLomo7PhIsxVjEuxANHwCps9j/IId/ZJGykRlasgtiQkytpsW3gZHKkBV9hhB7i7yPQsV1Ud7ErPYyn8qXml7K6T9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740105518; c=relaxed/simple;
	bh=ZzBAYuC4EutoUlZC8HUY+SGCYN6haPvViKM2AKin4C8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AZ+HzLr4+FDHEeml0caTWV/wyE5KdZYKYx9S44jPjCtK1l7hc+AGsgZx8U8Gikw5Kh2sVYn6yab9JdOyoTj7ktFgqZxdHcAp2TufRBvXS4MTq6jA3rd9Na1dyvLpfgGGLNF+Md6gjy4Fnr01QdNi0u03MVduDkHyudeSlsrrQJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DmAjR7cQ; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pXYWZh17CUl+c/rUpAZxG3RRyzHJ/kfKykaX7II+odxE7MnghKfVQ+GL3Mxld6DTJ70D20hzqAfKwM73dYEgWhrgQgrfCmc7wJEsl4kqLI0hkui1y4VU2Xv33t1kk+jnbPXMdSIGGWe7DrQeml+HlY9xoH68CME0TKkrGsWfgXJd0kU6ryVDDGDNA/JzbAszXFQ5lednfqXDEf78AI2JkU8WjgReK5GsBPhkLUkt5fdoXjh5LTUuvDOFnshbzeBzxx0Dh+5wBVJGm+EixsOFPraPkfNVlEsCX2IRAOcW9yMcOYm+woX0tHnm8g7f1CQeQXoUqTlSRVHVlFXmqd8FVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rt9gkX9rbiRL7ApWKHAa9z/vUo4vgPfGqkkBiYPAz74=;
 b=uRDKkvLzwueGiOo1ws5l6BGLQHCKBsFzfPxYt2e3Vn/QIQ2DnobMcWFey4UeT5dJGcKUJtVH8RdfyrntcSTpifUYW476Ac+kW6kScIPo0Hv3CwVKBMWnkgMVhK+1nMTWY6y8DaeKGudEYGqGumvdeep8a4J4+xQW+CbUChFAE41oVojvuqWLcBSQGCFWzuafuQ/irpT4rrBEdR5kF01E5Jt6ul7iUdaXv6k/9e4yRqMwuKknXNMpgF3cFJMW6+8ubB6Q+WT28NcNuYK+7p497eniw+9lgCWc/a6eABtCj6e/hOUOJ/232Y5BNilGEfsMf4d1DZMfEFdJ8poIwib6Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rt9gkX9rbiRL7ApWKHAa9z/vUo4vgPfGqkkBiYPAz74=;
 b=DmAjR7cQtTsK1nnsCeTVnmA5CtWdeC8za76KdV2Gp/Lf4myeD/B++aC00JJRMVn9EO0nScXMseeaZ+X/y/VRxIoEl9YeCqN3BctcuAU5BmUE9Dpikc92a/YYVaNgxgy6C21pAujZHvCyPobb7QeUvT2kvZwCdEq36l7nt2ozi4QHGCrG5aSely0tzPvR9fLgAmdBTGmhxml1luNJt9oIinaYCkxM38XGkCczw271taZeTyayw04j0FgrINj27e8guh2pn/G7Q9WTkTEoU0y3EERfE/sMk6RWNewhldgNdpVHRXgR1IZySOB/Uc7UHJkGexzDtN5k+rPh27LxJzKv+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH0PR12MB7983.namprd12.prod.outlook.com (2603:10b6:510:28e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.16; Fri, 21 Feb 2025 02:38:28 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 02:38:28 +0000
From: Zi Yan <ziy@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
 Kairui Song <kasong@tencent.com>, Miaohe Lin <linmiaohe@huawei.com>,
 <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 2/2] mm/shmem: use xas_try_split() in
 shmem_split_large_entry()
Date: Thu, 20 Feb 2025 21:38:26 -0500
X-Mailer: MailMate (2.0r6222)
Message-ID: <655589D4-7E13-4F5B-8968-3FCB71DCE0FC@nvidia.com>
In-Reply-To: <37C4B6AC-0757-4B92-88F3-75F1B4DEFFC5@nvidia.com>
References: <20250218235444.1543173-1-ziy@nvidia.com>
 <20250218235444.1543173-3-ziy@nvidia.com>
 <f899d6b3-e607-480b-9acc-d64dfbc755b5@linux.alibaba.com>
 <AD348832-5A6A-48F1-9735-924F144330F7@nvidia.com>
 <47d189c7-3143-4b59-a3af-477d4c46a8a0@linux.alibaba.com>
 <2e4b9927-562d-4cfa-9362-f23e3bcfc454@linux.alibaba.com>
 <42440332-96FF-4ECB-8553-9472125EB33F@nvidia.com>
 <37C4B6AC-0757-4B92-88F3-75F1B4DEFFC5@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BLAPR03CA0132.namprd03.prod.outlook.com
 (2603:10b6:208:32e::17) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH0PR12MB7983:EE_
X-MS-Office365-Filtering-Correlation-Id: d0f3cbfc-46f0-4be8-ed6b-08dd5220d2c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aVFkUHhSUWtibUI3WmxrRitJdEN1U2RIRGFUb2RPWEQ2QWgzZ1duYzkvdXBB?=
 =?utf-8?B?anRlYk1ZTUR1MDN5V2VUd01Tclc1emxVZW0zNmF2WElzTnZHckpBRDI2U2tX?=
 =?utf-8?B?MUk3aUkwWVkwbkZHSEZ5aTlWNEVEYzZYMjg3R2NNSC9icHBLV01wQnN1L0Zq?=
 =?utf-8?B?b2o2YUFHVHB1UGpqZithMS9YTWpCcGovWFNNbDNDUkVISTNGZVo3bDNub240?=
 =?utf-8?B?Rng4VUs2Q1RIeENNcmVWMW5PenQ4ZkNWdytMM0ZlaEJraWV2TFNEWFovcjEw?=
 =?utf-8?B?NVliUmhySzhFdzU1eUR1djJtM3dhVStSUzdOY0FDVDNXNENzQ29iTzVFakRE?=
 =?utf-8?B?Y0FtMDhVS0xqM2lmVzRzc1c2M0ZVY05nOUZ0ZkVIVXlYY3cvVGU3aDZ0MGox?=
 =?utf-8?B?K3ZZVXZXdmtjdzEyNGR4cGVjdS95c05OTUtPaUxrZU1zYmQxS1pmL0UzTGpw?=
 =?utf-8?B?VHV4a3REQWdNSHcwMnVxM3dWU1J1dFZZMzhxM0pEMGlUZm9zV293L0pwcEF4?=
 =?utf-8?B?THA5WW5UV1c1VFFwbDQwdXRZMEN4eXI4a010VUs2N3RGQS8zRVBFcWFpMkd0?=
 =?utf-8?B?cXVlM2IrNnZXaGJEcmtSM3NSNDdYSFVJL3J2aUJWVm5vMVR0YWlNay9HMDZT?=
 =?utf-8?B?emQ2YkYrTnJoVjdNc3d1TnBmUVFDalZZMFhvV1Q3ZXV6emYvUHlMRHAzb3Nv?=
 =?utf-8?B?NENnL2tpcnpuZXNIa04rRk1yd3lycWlNMk9hWWpBNWx4L1N5UFJZMXVYWk1Z?=
 =?utf-8?B?SmhER3dlNEZYNE1VVWZsdHJsZ2MyNUY0a1ZLSm8zRlFRTmJYQy9tSHdHVlF0?=
 =?utf-8?B?bFlZbXR2cDdjMGdiK1I2L0hydnQ4N2kwbGxmR2NONllEMzROQmgvN0hsWHM1?=
 =?utf-8?B?M3BtdzJGMGFkb3RUbHhDNENQL2VpRmRscVRETjh0U3I0bjNxR2dQNmZIOUdQ?=
 =?utf-8?B?L09JdkVIWWl3NUlZQzNWNENBRnRIOHZ0Z3JXSWlmVUN4QWd2NGdaQm1NaDlO?=
 =?utf-8?B?ZHpCMmxRdkIxRXpwRXVZVDkxS0EwNmRPVkNjNUdIa3dEdzQyVWgyR1lNY2xr?=
 =?utf-8?B?ZGVoT2g0MFM2ZlBFZ2dWUTlkdXQrdkhGcVdtSW9ZZGVpeXZUVlF1bGV6N0lO?=
 =?utf-8?B?clQ3Slhtcm0rYXE2KzZnSVFJR2JDUzk5Z0dlcmwzNloxZk9QVGtib1RUeW5E?=
 =?utf-8?B?bGtjNXNSOFdOVDJUQkRMNVpaWGIyY1VSaGE0K0VSVHFrQy80NVJNN2Qwcklu?=
 =?utf-8?B?dC9DRVNlcm5tTm83SUNLV0svL0hZZUlqdlJUN2Fnd1pkalhNSjQ1cTBEcnZh?=
 =?utf-8?B?SGdzQWdOY3BSOHd2T0tJMUVlQUU1MW40d1V4TTBEWXlWb1BLVDJwVy9zOG0w?=
 =?utf-8?B?bGUyWFMzMGRWRGFROGlDbjlHUEtWZmVNTkhtV1IwQnl5NUV6NUxVN3JTcU1V?=
 =?utf-8?B?b2VPUlB1dHNXTklRRWp3MHZZcDdMZ2NPcmFCTTBoZnQ4OUpmWERmam5WcEpI?=
 =?utf-8?B?NW1KM3ZHUTh2NkZiQUZFWm1JM3hwajBaZmlEYUx6RFgrcmowd3o3Z1NBS0FV?=
 =?utf-8?B?OU9RTGQ3Uit4Q1BvY3pweVVld01US2cxa0pwL1pxelFhT3oya0dJVTZlNVRI?=
 =?utf-8?B?TG1Ucm9IU3JQNXhyN0hkcnZyNFRiRjQwTHcxTHZJcHU2NU43UDhrUktQbUZ0?=
 =?utf-8?B?eW1oaklabWZTM1JBbm9JeHgzTk1GTzRtTlRybnlVejRHWlE1dG9NSVRlNjJY?=
 =?utf-8?B?cVZ0V3lzdGFyak9Gemo0MEEzTk56MGhWbk5OS0pWNEl2L1ZqME1VRDZaMS9E?=
 =?utf-8?B?cGt4NHpnTmFsZ2tWY2dOTG12N0l6aUpNUmx1aVU2WmpReUR4bWdLOFVnL2Q3?=
 =?utf-8?Q?2Ksop6EsPnwR5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWhKcFVoRGRJTnY5a3RBUzBUd0dkWmN0ZzdFNlhGdG1ZSEovZG1yd3c1a1dt?=
 =?utf-8?B?VUR5Z3FXSC94ZUZOeFhjbTZDOHlzZ0VNemdFRDhmNm51R0JrTXNIZk5FaTdq?=
 =?utf-8?B?NEhLQ2p1Qk5PT1pkQmFjaHpmMXczaTZUdTlIbHhTd2VkYnFQQzBaNG9jUjA5?=
 =?utf-8?B?dHIwYW1BeGdXQXV0Q1NRQk1MTVQ1TmVOaEM1SG9yaU93WDR2WnVpcE1rYWtF?=
 =?utf-8?B?aW80YjNzbWhxd3BaamtqMGRyTTRySENJTGgzMlFQZEh0eEJUZStsVG9qcVRs?=
 =?utf-8?B?Mkd3blZKRzkwaE84bWNsTlp0V0FjLzY3LzJEMDY1Z2hTYjFkZDlxT3hoRDNL?=
 =?utf-8?B?U1JSRndOTGh2TzRHU0ZRb0lQUzM0cDcxRzNSSEQ3OEVCZWRCYlRkL2RiT3JU?=
 =?utf-8?B?aTVuWnZMdzNsaWduZ2lkWWUvYVM0dEhVWGpmOFpkRW1hYTUrSG02MzNkNFE1?=
 =?utf-8?B?cGZ3MzNMcW5oWlVqcTVqTE5MSm9SbHBMV3k2NUJidC9FMXduUXBiSUdYZE1j?=
 =?utf-8?B?dUZacGhtcVhRTXlSTk5aWk5sZEw1YkNHUDBGa2VJSlROZm5MdmhuN3JIRUhj?=
 =?utf-8?B?V2M3YUQxWGdsYlpmcGJBVFZvbDF3aUl5Z0QzY0pFNExMbXVKM3owUWRtVm52?=
 =?utf-8?B?eHRlR1JFRzZwZXZLOEErOGVLeGJsdk9jaDd6TksvWE5XYnptTmNRc0lKcStX?=
 =?utf-8?B?UzRBa2xZL0dUTDdQaTFyalpJZUZZWG4xa0VBWEJoQXFpZURxQ2daNm1SVms0?=
 =?utf-8?B?akJBNTJGcXdQdHZpZ3FSK3RzWXdENUxyaWxrNytsTzZ3b3hZdk5HRFNMaDUr?=
 =?utf-8?B?MlZtTUhlRUNMSGQ1Y3VaNTVwbjltQVBDMmJzYW0xZWpvTEYwRWRKOExBUEpZ?=
 =?utf-8?B?S3ppa0psWGM5YU1uV0pNNitMY0dKRm15T1RoYXJBN0FqUmQyRW1LamgrMUx6?=
 =?utf-8?B?Mm5tUC9kUnBCcXA5UjljRktDSUcwN0IwQTM2L283ZEMvSm83bDEzMkZEN2pl?=
 =?utf-8?B?T2MrTERnR1NVRTU2OWtQa25mTTBmRXgyL1JXcnhNVzkyT3FzOWx3QjFyOHZi?=
 =?utf-8?B?dVY0andtcGFDY3BDb1NySitDa084eVVVVVNUOTgwOThBV2tjUDZac050V0o5?=
 =?utf-8?B?dGFjN2ttV3JWTVZrNTB5L0xTSk8xTVl2Z3lOVHRjYzRBZ3QrU0xkZGZ1S3Bn?=
 =?utf-8?B?MHVQbE9HR1E2d2lBVTEzS2tmZzhyQUgxNUhVSGxhRTZ0NkNyTG5XWm9MdzZt?=
 =?utf-8?B?QkRvTEJOV0Z6SXZOYTRiZUphUkxadXNqMWc2OElNdi9WVHV2RkN5b0tpTEcx?=
 =?utf-8?B?MjRNeWduMy9oMUNpTklhZHpSQVNodXpVazRwRjRjQzZMelUxS1p1SHFlYzVp?=
 =?utf-8?B?WitZS1lSbFBRWCs5UDMxT0hQRW5ORjFqZU0yeHpoWTBlTTZwTjBzVVV1akRD?=
 =?utf-8?B?K0dXR25vU2lweEo5T2pubEdQVmx1TTc1dDU1ZXQ4UGRrUkJQRm1GTDVmVE9p?=
 =?utf-8?B?a2dYVGd5SG5DQjY2QlNpQTJ0RWwvQ3o4U3NUZXhRdVIrcUNPNmw0eTcvMW1q?=
 =?utf-8?B?TnRtakpTT2xwZllMcDZSbU9EK2F1TUJvSk5KdUFRWHh6dnBldXMwRnlVOHps?=
 =?utf-8?B?eU1laWxNMG1XMzJXaUkyZ3VkMVdFL0FMWC9laHlJSjF5U0U0d2RUWE1HYzNR?=
 =?utf-8?B?blY1VmUrT05wT3IrN0krN2xQS24zNHdjUDhSSUJWMTBmVXprVkpSSG1aSXBX?=
 =?utf-8?B?VUloWjAyQTNYdGlYTWppUXFiaktMVjhObUpaeXU3T21FZlJxd3lvemRXNSsx?=
 =?utf-8?B?NGxhaW8rVzhJUEJtNXRmMHpvUDFMVVZtNTA0bkRoUXN2NkxkdXdYMzFyOHM4?=
 =?utf-8?B?WGtFeWIvaXBKSFFPNlIrSC9MdWJDb2JjMEpOcE9KeWRVdU8yUmpTaHNOYWNI?=
 =?utf-8?B?bkhvbmhWMmgxTlZnSkdUSVhZMk00UEdYcm9SZ0NHWUFnOWk5RmJOSlQyRG9q?=
 =?utf-8?B?VHBXZTIzNW5LTzZIaTh3STNRSEVOV2pkcGgwT0NrSmsyTUU3SGhOaU5Ra0FZ?=
 =?utf-8?B?d2c4VXZkRU1wR1E0aUJOL3JiRUV5MXhkbzZsOFlYeG9JdE5RcnhLWisxVXZF?=
 =?utf-8?Q?GmM/K7iZPDliwbbUvc7y73GDi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f3cbfc-46f0-4be8-ed6b-08dd5220d2c1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 02:38:28.5977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rymMTfAjmwfRbQV2Gq7phcEUzEmx58LuLOQgemPrld4b7pfP0wZlFn3SID5Gq/ZF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7983

On 20 Feb 2025, at 21:33, Zi Yan wrote:

> On 20 Feb 2025, at 8:06, Zi Yan wrote:
>
>> On 20 Feb 2025, at 4:27, Baolin Wang wrote:
>>
>>> On 2025/2/20 17:07, Baolin Wang wrote:
>>>>
>>>>
>>>> On 2025/2/20 00:10, Zi Yan wrote:
>>>>> On 19 Feb 2025, at 5:04, Baolin Wang wrote:
>>>>>
>>>>>> Hi Zi,
>>>>>>
>>>>>> Sorry for the late reply due to being busy with other things:)
>>>>>
>>>>> Thank you for taking a look at the patches. :)
>>>>>
>>>>>>
>>>>>> On 2025/2/19 07:54, Zi Yan wrote:
>>>>>>> During shmem_split_large_entry(), large swap entries are covering n=
 slots
>>>>>>> and an order-0 folio needs to be inserted.
>>>>>>>
>>>>>>> Instead of splitting all n slots, only the 1 slot covered by the fo=
lio
>>>>>>> need to be split and the remaining n-1 shadow entries can be retain=
ed with
>>>>>>> orders ranging from 0 to n-1.=C2=A0 This method only requires
>>>>>>> (n/XA_CHUNK_SHIFT) new xa_nodes instead of (n % XA_CHUNK_SHIFT) *
>>>>>>> (n/XA_CHUNK_SHIFT) new xa_nodes, compared to the original
>>>>>>> xas_split_alloc() + xas_split() one.
>>>>>>>
>>>>>>> For example, to split an order-9 large swap entry (assuming XA_CHUN=
K_SHIFT
>>>>>>> is 6), 1 xa_node is needed instead of 8.
>>>>>>>
>>>>>>> xas_try_split_min_order() is used to reduce the number of calls to
>>>>>>> xas_try_split() during split.
>>>>>>
>>>>>> For shmem swapin, if we cannot swap in the whole large folio by skip=
ping the swap cache, we will split the large swap entry stored in the shmem=
 mapping into order-0 swap entries, rather than splitting it into other ord=
ers of swap entries. This is because the next time we swap in a shmem folio=
 through shmem_swapin_cluster(), it will still be an order 0 folio.
>>>>>
>>>>> Right. But the swapin is one folio at a time, right? shmem_split_larg=
e_entry()
>>>>
>>>> Yes, now we always swapin an order-0 folio from the async swap device =
at a time. However, for sync swap device, we will skip the swapcache and sw=
apin the whole large folio by commit 1dd44c0af4fa, so it will not call shme=
m_split_large_entry() in this case.
>>
>> Got it. I will check the commit.
>>
>>>>
>>>>> should split the large swap entry and give you a slot to store the or=
der-0 folio.
>>>>> For example, with an order-9 large swap entry, to swap in first order=
-0 folio,
>>>>> the large swap entry will become order-0, order-0, order-1, order-2,=
=E2=80=A6 order-8,
>>>>> after the split. Then the first order-0 swap entry can be used.
>>>>> Then, when a second order-0 is swapped in, the second order-0 can be =
used.
>>>>> When the last order-0 is swapped in, the order-8 would be split to
>>>>> order-7,order-6,=E2=80=A6,order-1,order-0, order-0, and the last orde=
r-0 will be used.
>>>>
>>>> Yes, understood. However, for the sequential swapin scenarios, where o=
riginally only one split operation is needed. However, your approach increa=
ses the number of split operations. Of course, I understand that in non-seq=
uential swapin scenarios, your patch will save some xarray memory. It might=
 be necessary to evaluate whether the increased split operations will have =
a significant impact on the performance of sequential swapin?
>>
>> Is there a shmem swapin test I can run to measure this? xas_try_split() =
should
>> performance similar operations as existing xas_split_alloc()+xas_split()=
.
>>
>>>>
>>>>> Maybe the swapin assumes after shmem_split_large_entry(), all swap en=
tries
>>>>> are order-0, which can lead to issues. There should be some check lik=
e
>>>>> if the swap entry order > folio_order, shmem_split_large_entry() shou=
ld
>>>>> be used.
>>>>>>
>>>>>> Moreover I did a quick test with swapping in order 6 shmem folios, h=
owever, my test hung, and the console was continuously filled with the foll=
owing information. It seems there are some issues with shmem swapin handlin=
g. Anyway, I need more time to debug and test.
>>>>> To swap in order-6 folios, shmem_split_large_entry() does not allocat=
e
>>>>> any new xa_node, since XA_CHUNK_SHIFT is 6. It is weird to see OOM
>>>>> error below. Let me know if there is anything I can help.
>>>>
>>>> I encountered some issues while testing order 4 and order 6 swapin wit=
h your patches. And I roughly reviewed the patch, and it seems that the new=
 swap entry stored in the shmem mapping was not correctly updated after the=
 split.
>>>>
>>>> The following logic is to reset the swap entry after split, and I assu=
me that the large swap entry is always split to order 0 before. As your pat=
ch suggests, if a non-uniform split is used, then the logic for resetting t=
he swap entry needs to be changed? Please correct me if I missed something.
>>>>
>>>> /*
>>>>  =C2=A0* Re-set the swap entry after splitting, and the swap
>>>>  =C2=A0* offset of the original large entry must be continuous.
>>>>  =C2=A0*/
>>>> for (i =3D 0; i < 1 << order; i++) {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0pgoff_t aligned_index =3D round_down(index, 1=
 << order);
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0swp_entry_t tmp;
>>>>
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0tmp =3D swp_entry(swp_type(swap), swp_offset(=
swap) + i);
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0__xa_store(&mapping->i_pages, aligned_index +=
 i,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 swp_to_r=
adix_entry(tmp), 0);
>>>> }
>>
>> Right. I will need to adjust swp_entry_t. Thanks for pointing this out.
>>
>>>
>>> In addition, after your patch, the shmem_split_large_entry() seems alwa=
ys return 0 even though it splits a large swap entry, but we still need re-=
calculate the swap entry value after splitting, otherwise it may return err=
ors due to shmem_confirm_swap() validation failure.
>>>
>>> /*
>>>  * If the large swap entry has already been split, it is
>>>  * necessary to recalculate the new swap entry based on
>>>  * the old order alignment.
>>>  */
>>>  if (split_order > 0) {
>>> 	pgoff_t offset =3D index - round_down(index, 1 << split_order);
>>>
>>> 	swap =3D swp_entry(swp_type(swap), swp_offset(swap) + offset);
>>> }
>>
>> Got it. I will fix it.
>>
>> BTW, do you mind sharing your swapin tests so that I can test my new ver=
sion
>> properly?
>
> The diff below adjusts the swp_entry_t and returns the right order after
> shmem_split_large_entry(). Let me know if it fixes your issue.

Fixed the compilation error. It will be great if you can share a swapin tes=
t, so that
I can test locally. Thanks.

diff --git a/mm/shmem.c b/mm/shmem.c
index b35ba250c53d..bfc4ef511391 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2162,7 +2162,7 @@ static int shmem_split_large_entry(struct inode *inod=
e, pgoff_t index,
 {
 	struct address_space *mapping =3D inode->i_mapping;
 	XA_STATE_ORDER(xas, &mapping->i_pages, index, 0);
-	int split_order =3D 0;
+	int split_order =3D 0, entry_order =3D 0;
 	int i;

 	/* Convert user data gfp flags to xarray node gfp flags */
@@ -2180,6 +2180,7 @@ static int shmem_split_large_entry(struct inode *inod=
e, pgoff_t index,
 		}

 		order =3D xas_get_order(&xas);
+		entry_order =3D order;

 		/* Try to split large swap entry in pagecache */
 		if (order > 0) {
@@ -2192,23 +2193,23 @@ static int shmem_split_large_entry(struct inode *in=
ode, pgoff_t index,
 				xas_try_split(&xas, old, cur_order, GFP_NOWAIT);
 				if (xas_error(&xas))
 					goto unlock;
+
+				/*
+				 * Re-set the swap entry after splitting, and the swap
+				 * offset of the original large entry must be continuous.
+				 */
+				for (i =3D 0; i < 1 << cur_order; i +=3D (1 << split_order)) {
+					pgoff_t aligned_index =3D round_down(index, 1 << cur_order);
+					swp_entry_t tmp;
+
+					tmp =3D swp_entry(swp_type(swap), swp_offset(swap) + i);
+					__xa_store(&mapping->i_pages, aligned_index + i,
+						   swp_to_radix_entry(tmp), 0);
+				}
 				cur_order =3D split_order;
 				split_order =3D
 					xas_try_split_min_order(split_order);
 			}
-
-			/*
-			 * Re-set the swap entry after splitting, and the swap
-			 * offset of the original large entry must be continuous.
-			 */
-			for (i =3D 0; i < 1 << order; i++) {
-				pgoff_t aligned_index =3D round_down(index, 1 << order);
-				swp_entry_t tmp;
-
-				tmp =3D swp_entry(swp_type(swap), swp_offset(swap) + i);
-				__xa_store(&mapping->i_pages, aligned_index + i,
-					   swp_to_radix_entry(tmp), 0);
-			}
 		}

 unlock:
@@ -2221,7 +2222,7 @@ static int shmem_split_large_entry(struct inode *inod=
e, pgoff_t index,
 	if (xas_error(&xas))
 		return xas_error(&xas);

-	return split_order;
+	return entry_order;
 }

 /*


Best Regards,
Yan, Zi

