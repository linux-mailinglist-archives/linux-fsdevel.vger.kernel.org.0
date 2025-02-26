Return-Path: <linux-fsdevel+bounces-42694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 181D3A463FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 16:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72B5A3B558C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 15:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A75221F3D;
	Wed, 26 Feb 2025 15:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VDT4dQ+J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2059.outbound.protection.outlook.com [40.107.95.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E90221D8E;
	Wed, 26 Feb 2025 15:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740582213; cv=fail; b=AoOY/a7OKfOV4S1Avpf+uS26ypBndUPB6/PmXqrJZcstYUWr7Yro/8mke1evxFzOWcED+30t9vU1XPlUgz9qAsIMeGl2X1Xype3+HEamFmfe/UT7dFn1h608lqtAuxYnj+BkCiBm34DWPyI9EN7WKhnUu4wqzx+Crcgfm6sdj8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740582213; c=relaxed/simple;
	bh=856QThmjj8SVbDFG+ILHw0Bq9uVJGkJONwiBoi8WQlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SkpGB/Rz0eh+wLlGmnHpzHA0BpCPJdmixHZADcsTe8EBjP5C6NRKCPBfT0FOySc6Wsxz8hY7WLjNwFNGMvN+yL78f0SH5HK5MX3omz1XJNZtc97R8LQu1ckBpg8iSGIi6lPxHVA4E9oRdde6AIfPZ03ocyaRST1JD8fjkO8YUTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VDT4dQ+J; arc=fail smtp.client-ip=40.107.95.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oofqeAQ5DuCKY5JWAgn2EW8NK6SmXxKhf2zWF23wlaia/bQZkqGHPQa7r1YMpUyDLr/4QkSJyyV47TlWATPVeWs0QuuM3yaj4130R0drMHIbc72+9DqqnnfQ2XmUuKh2EpNWIyi66ebYvNDq0RGNGSucSq7enVU4PGFb0Wl+WR3Vu6rTi3/0ww4zd7AGQakMh5/3Av0WalAJykNwOFWMb+ogfbhzb8ydM+O9MYY2aWSBuMeqqjYjmeSLMOuKHFwE1KAjIKqOEdEO81zlsqhyVgYCpqkUDOK+VbIWHfER129IwI5LTEjkXbWSJqSaDKTrDXAaCUHzTMbIv+4/t8JmYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tmo35y/sIbiblmUZyyFRf/iy4bR1jgKGT0rIQSeUuaU=;
 b=pkkKHcVRx8GCJHtwOZAo5QAS0tT1muodZPOVVm2SwjO7tjG+MaZIFjMKllICqtg2QzqEpTFpja4JvjWnLocB3OlfLoLih0fS/T9gGE6NmLYNAVWCAM3xESkwvf5NrcJfZ6UcCJpjqKWnurUhpQEZHk/BF4/Sol9ksHWKmCZZcMQzEIl4NpN7fMV29sIjGfFY+FBPF31RdmNTAzZGSKTqWkLNSqUHw8BBnFGZEtv1tZ4AOxGN/jH+5Y1eXwefId3kdG0aESy/wyoMkuGlXFJ/e7zEnZocrCA7kbiw2iac/tXciBoINAPknvbHgYTtWOyabB5dcxJZHXmw3dyzkUfY4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tmo35y/sIbiblmUZyyFRf/iy4bR1jgKGT0rIQSeUuaU=;
 b=VDT4dQ+JvE8Yt8slS1TKYj2eo7EFt1pu+l/UqUrajWQXLVRxgsh3SbEPvyGMPmobjty4YfkSYXFwRlYJWUH7Fls4sM/moH+AMXcPz5V8veaw5BGL26JrVA9sb3het7M1NYc8NqrYwQGSPa46BHaGnDgYuLRoer6PvdQbzaem06f2oqgn8bZZNsy4CBw54gwBe9QZsPwppjXUiCvT+wBRhy/Q0amYPSiknIfYAjvfKJhu4Tki+9cBZtFp8mNSkg3dWjY0NdMo+W/aKlTEKgI6sx9c4a9OEF/nUr0mIuPhPRB7aFeCr0lnylgFLqWf8ivqfUxPUjaw3tm+YXJX9LKKYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MN2PR12MB4061.namprd12.prod.outlook.com (2603:10b6:208:19a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 15:03:26 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 15:03:26 +0000
From: Zi Yan <ziy@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
 Kairui Song <kasong@tencent.com>, Miaohe Lin <linmiaohe@huawei.com>,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 2/2] mm/shmem: use xas_try_split() in
 shmem_split_large_entry()
Date: Wed, 26 Feb 2025 10:03:22 -0500
X-Mailer: MailMate (2.0r6222)
Message-ID: <4D6394C3-E807-41B6-ACF2-DA3AF9BDFFA9@nvidia.com>
In-Reply-To: <ecc1990e-68d6-4a42-8618-7c1fdfc020a2@linux.alibaba.com>
References: <20250218235444.1543173-1-ziy@nvidia.com>
 <20250218235444.1543173-3-ziy@nvidia.com>
 <f899d6b3-e607-480b-9acc-d64dfbc755b5@linux.alibaba.com>
 <AD348832-5A6A-48F1-9735-924F144330F7@nvidia.com>
 <47d189c7-3143-4b59-a3af-477d4c46a8a0@linux.alibaba.com>
 <2e4b9927-562d-4cfa-9362-f23e3bcfc454@linux.alibaba.com>
 <42440332-96FF-4ECB-8553-9472125EB33F@nvidia.com>
 <37C4B6AC-0757-4B92-88F3-75F1B4DEFFC5@nvidia.com>
 <655589D4-7E13-4F5B-8968-3FCB71DCE0FC@nvidia.com>
 <bd30dc5e-880c-4daf-a86b-b814a1533931@linux.alibaba.com>
 <af6122b4-2324-418b-b925-becf6036d9ab@linux.alibaba.com>
 <C643A2FC-316F-4AA2-8788-84E5D92793F2@nvidia.com>
 <AF487A7A-F685-485D-8D74-756C843D6F0A@nvidia.com>
 <ecc1990e-68d6-4a42-8618-7c1fdfc020a2@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR03CA0057.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::32) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MN2PR12MB4061:EE_
X-MS-Office365-Filtering-Correlation-Id: 68ebd8a4-cc7d-42e7-c2c1-08dd5676b8c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RTYzVmpJREdFOVI0WXVzZUFsUVFVd3I5UXhsejdaRTZJL2FOZVNyNVlIQXVU?=
 =?utf-8?B?TW5kanFlTmhJb3lSVERVM2NBdlU0VEMrMmRkcXkvVEFGZGovQkg3VkpmT0lT?=
 =?utf-8?B?Um1wZDNmemdLRUlQelNaZElJd1hGbTdLMEx6RE0xMWtINXZKZlZ2UHZsd0xP?=
 =?utf-8?B?RmRKQXJkRTZZcDJlclozK3dNbDFwaVVQalBTd2ErTjcyUWpnamJ4dEdWaXV1?=
 =?utf-8?B?QlZuc2RMTG1YQlhsMW1wTDhHa3dMZ29OR09CNmlIbGx3MjBGRDRjSkpCeW5y?=
 =?utf-8?B?b0YydEs3TmhuS05EMVltOG11R1BDcU81cTBZMHFMNC9vQmthdEFOR3NNREpE?=
 =?utf-8?B?eXV0RHlxNVBScGRkSzBlRUR4U1cwTDlQZXJiWWZ0ZFN6MnNKT2NrNHNhQUQv?=
 =?utf-8?B?STAwemNxT3JVeFhNUVJzbkNhaWhKRVVpYVhzOVFqNGRSRXo0OCtwQlcrelVS?=
 =?utf-8?B?UmF5Nm5CRVU5M2d2VVpaSWFEdlIwN3BzQ1YveHBaQXI2OHphcExmb0JUbXhx?=
 =?utf-8?B?bU41ZW9lSEIwZnduVEdkVXY5REs2aE9ydUN2VER5K1RiWGZaVlB0RWpHWFlD?=
 =?utf-8?B?TGxoYUk3bzZzbllJMmw1Ymx6eEpnUzFrL2RpRmxHTm53SWhxbWtJdk5uSDBo?=
 =?utf-8?B?Z09WTHJ0U0NHaHc3OEd5aWhvaHZmdmdkbko5VmVFaXFTanY1Yms5aFFRVDhm?=
 =?utf-8?B?S2poaDB2MlhVdkM0OUxRMW1OMHkxOSs5R3FZWGw0T0s2U3ZtODRyblR4V1pH?=
 =?utf-8?B?a25KQTVUa1c0VzNXSnJ0NDlhOHBJVmdrNi82OGRxc241M3Btb0YydVRhZDdx?=
 =?utf-8?B?bW9KREttdFlWenh4eTdSNWtoTlhmMWFOclQzMDBWMGZiNlArZ0VGTElLOGpt?=
 =?utf-8?B?NktCclg4a2h3SUF3VFVPWVhwdTVOc2I5TFBFNDhMaXhwM284Z0FLMHRvT0Fo?=
 =?utf-8?B?bWE3MUpVUEwyaUM2bzkvQXJuT2VUcDY1bzVydGpzODZUdzNrREZ2eS9hOU9P?=
 =?utf-8?B?VGQrMzR1anZzeWgyV2dqZEZEMGJXNFk0L0JBOXZaRTF0S1RNLzFmZ1dtUzFm?=
 =?utf-8?B?ZEQ2NGN4YTJ0NzlpSFlzWnNyazRrcTg2VXBYUDJrbWhseFRRL01JTWtlZEVQ?=
 =?utf-8?B?L0d4Y25DbXlqVzVkekVmVEExRjNVNytkQXkwZEpSdUVTNXFTWUVrcVhOWThM?=
 =?utf-8?B?N0hodVp6N1YvbFBFUWpOZjNnMVpva2tyb3hBcGlWeWQ0RVFPMWd5MW4xL1Vo?=
 =?utf-8?B?TndML3hhcHZuRlAzMlYxS0N4SXMvUytYcDhpNm9yNXFwNXdSblFqU0RhcWNm?=
 =?utf-8?B?QkpBQklzcFdBTFZndTEyZkd6ZDRROXV4bHRSWkM2dWE1aTMyV0lOSnU2Tnc0?=
 =?utf-8?B?OXRuQ0ZjcFAwV056ajcrY2RFei9kQ05qZUgxY1Y0RlFyOFFIdlEyMU5zY1J2?=
 =?utf-8?B?emVLaTNRbkp0aWtHTFNzejZ2VjJVU3l5cmVheEY3b0wzZ2hPUHJKbVQ0bWV6?=
 =?utf-8?B?dWQ2QmRMbU40WUl1L21FVWlGM3ExNnpVM1JNdGdaOEpLblNuS1FnQVRLU0hZ?=
 =?utf-8?B?RklQb1J6NUQ0bmlNV2ZRSUhDNndnbzBWT2s4TEFLb25YTFZGMitoRGo2RGVW?=
 =?utf-8?B?RG9uWDlRZFBsekZyTjd0dUZ4Mmd1VEc0RlBlZ1NTeVpwVm1iaUU1OE1XdzQ3?=
 =?utf-8?B?MkxmSTVLMVVHck5YeHlFQjUwaTd5TFFxNXNrcUpsZjk4UWVYZVh3dXpCa0ov?=
 =?utf-8?B?MjVzUFNSWHdMaHNsVEFhM3NpQmdhVWxMYlRwdDRaSUV1UkZWaWhIdFVyUzdl?=
 =?utf-8?B?dG9KUmpJZEJZaThXTjFrbThYR0NRUis0OEJYait0ZGJWODhIQmpLTDQzQ1o0?=
 =?utf-8?Q?LpEH6zINZjswZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rkg3N290YzdoSmFsMDRKZEpsWHpZTmJvRWR2T2pLSGQwT3Z1blRudVRDMlFJ?=
 =?utf-8?B?aVltN2pTVFRnZUhsMG9MdGp0WTl0MXVZcU1jN1QzTmh5YUcvSlRsZTlKZURJ?=
 =?utf-8?B?WmJxdjNPL0V0WlJRWUVadXhOWkRYNGd4WXBKYUlLRkRHR2dCUC9weHBtN1Zj?=
 =?utf-8?B?c1NSdVd3cG1SeHJEOTlHSlQ5eC9BUzNIQ1JubWdWdjQ4NHY5R090WW5hYnJN?=
 =?utf-8?B?M2VwdnRmOXpOcnVxdmgvb3ZHV1h4eXNtR1orYnduRS9JNlhKUXZNNDY5RFRD?=
 =?utf-8?B?eTJwRzRGL0Q3elhvL2FNdEF6NDkyTHBGekhSRFowSnVIV0l2UUpsZ0tSaE9F?=
 =?utf-8?B?cVdNRnJkTk9CWWt3VzBVL0wrZHUvemE4djQ2Rm1acE96OU5xRHhMWmpEWmJK?=
 =?utf-8?B?RHlQS294ZnM3Rko3TFZRSDRadXJMbG9ITnhPT1dZZFJrOUVDM09ESFVYY3Jn?=
 =?utf-8?B?eE1TM0JuRDQzNWdqNEVHT29NYkxPQ0JPTkpmT3hxeEpZSTRkSCtRMzJ3NzNQ?=
 =?utf-8?B?L0M2c2Fic1FaMkpjR1FoaDlGYitPMG1xeU9OKytTODltM0RXZ1FLYXZvaWtX?=
 =?utf-8?B?QVNKREE5V0pjbmtyWGoxOEo2WFExQzJSUHVIanlsUEQ2VDRMcVhxVlAzUnUx?=
 =?utf-8?B?MlNTYzFJUnVyOW42WHRPWVJ3Y1h0VVFFV1ZMZVdqSjBlbEtVczJvVnAzblh1?=
 =?utf-8?B?VWp5dWxMVHcrZThHNCtxdHU2YTlRRWhSd3k1S3JBNTZmK3d4RG8rd1BJUUZL?=
 =?utf-8?B?b0Z5enBXdjZtMzg2VnpROU9KZzFvRDFVb2ZJRDNkMzF2QTBqSmU5bFV3UzVJ?=
 =?utf-8?B?WkZWWWFuSTE2UzRwMUJCTWIvNnB0c2liMkhVcmRObCtQT05SR1F6Z1ZsWFE4?=
 =?utf-8?B?Y015VjZ4Q3gvalo5Y0RLTWYwS3h4ZU10U21QQzkyRDA0SlJuYkMxcmk1dUhI?=
 =?utf-8?B?eEN5ckhMZllvY2pBTnlWaVRLQ3pGNFZVMzhBYjJSSDY0ZlhEb3c2Ymh0ay9S?=
 =?utf-8?B?VXVXendIamhhRzUveHlFTVNJUitwaXIxRjg3V0Z1dHpEcDUyOU1vOTE2YkFl?=
 =?utf-8?B?ZE9aTFBCL0NPallFTyt2VTRDeVVyRnpoOHJTVzZnb1I3ZW95cmJ3OWVaUmNu?=
 =?utf-8?B?Nk5CTGg0T3JjbmViQUEyTGFnOVBmcHRzaHVtdXYvRmxoOVNXQWVKb1hxM1hJ?=
 =?utf-8?B?SlBpc0RDM2xaRnBXeFZ6bVA3ZUJvcGVKbWp0THZTQXRaM1BhVTVnTTFydUJ1?=
 =?utf-8?B?TCtIdk5ObWNqRUZicTU3UGt2R0hicDRURTM5RTNNQ2pyVUtrUmdQVGE5NWZl?=
 =?utf-8?B?VG5hZHJ0NmtnTFdwYTgzb3RkSGZUdGhJL3ZRK1Z1YmRGUHNyVGpyWTI0V1JI?=
 =?utf-8?B?NTQySVorQjR5M2hFS2pwMGJqZnBEN0RDcDh4dWIvWTQxOEprc3JnODhHb3lq?=
 =?utf-8?B?Q213NzErWkgzMFhPUHZDTDFqME05VmFzTEtBdkhCNXJVdjBLMGN2MTdwOGpv?=
 =?utf-8?B?TjB3anZEbzRLK2pjM1Y0a1ROZjhyNEN1T2dXeDh1T3ZKc1ZpK1A5VWJHS2Zx?=
 =?utf-8?B?eVUzRnlXeFJqU2E5L3ZSWDVCc3pjSENzYkUrcGpDMlhhbGJPMHNzVWQ2Q3B6?=
 =?utf-8?B?eGJVWUxrT3F2VkQ0ZFRjbzVzWVNqNFhQMmFEVHdkNkJuemZuZ1I5czJpMCtV?=
 =?utf-8?B?M1ZPV3Bmd1JqYlRlTHBrZkRUdEtWOVBNMGFmcVd2ZFVpcE1KMkprWnhPUXRw?=
 =?utf-8?B?dnVJUFppZ0lUQUlsVWZMMjlVU1BjOXkxbmRGcU16RUFKRVhqcUFJellKcGFw?=
 =?utf-8?B?VjFVY0J0Y2dLSzlRWUJ0RWlLZU5XTEZ4UngrY0tMNjNnTEo2NG5IMTNWRTl5?=
 =?utf-8?B?RWhISXB5ZmZlWmRxWG1uQTRyV0VZRDI2MTZsWHc5VUZSWk1ZYlJoYW5zbzF0?=
 =?utf-8?B?dnEyVDdMczRDN3hSdzJWWHBLenlnSjhEdmhrb0tML0FyM3QzY1RNUlZFbTcz?=
 =?utf-8?B?VWJZMUpLVkFKUlZzd0FLeVVjQ1FHMXFzVE5FczNGMzZMUy91OG9vcjczOE84?=
 =?utf-8?B?cG9JY1AyTHhycDFxZ25xNUhiQ2pnSUx5Z3EwM2UxeDkzbUZERisvMXRzL01t?=
 =?utf-8?Q?Y3//ZdGOLlyD9UzU1q0YgVavB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ebd8a4-cc7d-42e7-c2c1-08dd5676b8c3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 15:03:26.4233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9FJp3ITmgzGlzBt5ZDTylkZ1OlbbyG913428P9o7NysVmHC9bZRF6y/c84PXqidB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4061

On 26 Feb 2025, at 1:37, Baolin Wang wrote:

> On 2025/2/26 04:32, Zi Yan wrote:
>> On 25 Feb 2025, at 11:41, Zi Yan wrote:
>>
>>> On 25 Feb 2025, at 5:15, Baolin Wang wrote:
>>>
>>>> On 2025/2/25 17:20, Baolin Wang wrote:
>>>>>
>>>>>
>>>>> On 2025/2/21 10:38, Zi Yan wrote:
>>>>>> On 20 Feb 2025, at 21:33, Zi Yan wrote:
>>>>>>
>>>>>>> On 20 Feb 2025, at 8:06, Zi Yan wrote:
>>>>>>>
>>>>>>>> On 20 Feb 2025, at 4:27, Baolin Wang wrote:
>>>>>>>>
>>>>>>>>> On 2025/2/20 17:07, Baolin Wang wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 2025/2/20 00:10, Zi Yan wrote:
>>>>>>>>>>> On 19 Feb 2025, at 5:04, Baolin Wang wrote:
>>>>>>>>>>>
>>>>>>>>>>>> Hi Zi,
>>>>>>>>>>>>
>>>>>>>>>>>> Sorry for the late reply due to being busy with other things:)
>>>>>>>>>>>
>>>>>>>>>>> Thank you for taking a look at the patches. :)
>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> On 2025/2/19 07:54, Zi Yan wrote:
>>>>>>>>>>>>> During shmem_split_large_entry(), large swap entries are cove=
ring n slots
>>>>>>>>>>>>> and an order-0 folio needs to be inserted.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Instead of splitting all n slots, only the 1 slot covered by =
the folio
>>>>>>>>>>>>> need to be split and the remaining n-1 shadow entries can be =
retained with
>>>>>>>>>>>>> orders ranging from 0 to n-1.=C2=A0 This method only requires
>>>>>>>>>>>>> (n/XA_CHUNK_SHIFT) new xa_nodes instead of (n % XA_CHUNK_SHIF=
T) *
>>>>>>>>>>>>> (n/XA_CHUNK_SHIFT) new xa_nodes, compared to the original
>>>>>>>>>>>>> xas_split_alloc() + xas_split() one.
>>>>>>>>>>>>>
>>>>>>>>>>>>> For example, to split an order-9 large swap entry (assuming X=
A_CHUNK_SHIFT
>>>>>>>>>>>>> is 6), 1 xa_node is needed instead of 8.
>>>>>>>>>>>>>
>>>>>>>>>>>>> xas_try_split_min_order() is used to reduce the number of cal=
ls to
>>>>>>>>>>>>> xas_try_split() during split.
>>>>>>>>>>>>
>>>>>>>>>>>> For shmem swapin, if we cannot swap in the whole large folio b=
y skipping the swap cache, we will split the large swap entry stored in the=
 shmem mapping into order-0 swap entries, rather than splitting it into oth=
er orders of swap entries. This is because the next time we swap in a shmem=
 folio through shmem_swapin_cluster(), it will still be an order 0 folio.
>>>>>>>>>>>
>>>>>>>>>>> Right. But the swapin is one folio at a time, right? shmem_spli=
t_large_entry()
>>>>>>>>>>
>>>>>>>>>> Yes, now we always swapin an order-0 folio from the async swap d=
evice at a time. However, for sync swap device, we will skip the swapcache =
and swapin the whole large folio by commit 1dd44c0af4fa, so it will not cal=
l shmem_split_large_entry() in this case.
>>>>>>>>
>>>>>>>> Got it. I will check the commit.
>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>> should split the large swap entry and give you a slot to store =
the order-0 folio.
>>>>>>>>>>> For example, with an order-9 large swap entry, to swap in first=
 order-0 folio,
>>>>>>>>>>> the large swap entry will become order-0, order-0, order-1, ord=
er-2,=E2=80=A6 order-8,
>>>>>>>>>>> after the split. Then the first order-0 swap entry can be used.
>>>>>>>>>>> Then, when a second order-0 is swapped in, the second order-0 c=
an be used.
>>>>>>>>>>> When the last order-0 is swapped in, the order-8 would be split=
 to
>>>>>>>>>>> order-7,order-6,=E2=80=A6,order-1,order-0, order-0, and the las=
t order-0 will be used.
>>>>>>>>>>
>>>>>>>>>> Yes, understood. However, for the sequential swapin scenarios, w=
here originally only one split operation is needed. However, your approach =
increases the number of split operations. Of course, I understand that in n=
on-sequential swapin scenarios, your patch will save some xarray memory. It=
 might be necessary to evaluate whether the increased split operations will=
 have a significant impact on the performance of sequential swapin?
>>>>>>>>
>>>>>>>> Is there a shmem swapin test I can run to measure this? xas_try_sp=
lit() should
>>>>>>>> performance similar operations as existing xas_split_alloc()+xas_s=
plit().
>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>> Maybe the swapin assumes after shmem_split_large_entry(), all s=
wap entries
>>>>>>>>>>> are order-0, which can lead to issues. There should be some che=
ck like
>>>>>>>>>>> if the swap entry order > folio_order, shmem_split_large_entry(=
) should
>>>>>>>>>>> be used.
>>>>>>>>>>>>
>>>>>>>>>>>> Moreover I did a quick test with swapping in order 6 shmem fol=
ios, however, my test hung, and the console was continuously filled with th=
e following information. It seems there are some issues with shmem swapin h=
andling. Anyway, I need more time to debug and test.
>>>>>>>>>>> To swap in order-6 folios, shmem_split_large_entry() does not a=
llocate
>>>>>>>>>>> any new xa_node, since XA_CHUNK_SHIFT is 6. It is weird to see =
OOM
>>>>>>>>>>> error below. Let me know if there is anything I can help.
>>>>>>>>>>
>>>>>>>>>> I encountered some issues while testing order 4 and order 6 swap=
in with your patches. And I roughly reviewed the patch, and it seems that t=
he new swap entry stored in the shmem mapping was not correctly updated aft=
er the split.
>>>>>>>>>>
>>>>>>>>>> The following logic is to reset the swap entry after split, and =
I assume that the large swap entry is always split to order 0 before. As yo=
ur patch suggests, if a non-uniform split is used, then the logic for reset=
ting the swap entry needs to be changed? Please correct me if I missed some=
thing.
>>>>>>>>>>
>>>>>>>>>> /*
>>>>>>>>>>  =C2=A0 =C2=A0* Re-set the swap entry after splitting, and the s=
wap
>>>>>>>>>>  =C2=A0 =C2=A0* offset of the original large entry must be conti=
nuous.
>>>>>>>>>>  =C2=A0 =C2=A0*/
>>>>>>>>>> for (i =3D 0; i < 1 << order; i++) {
>>>>>>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0pgoff_t aligned_index =3D round_=
down(index, 1 << order);
>>>>>>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0swp_entry_t tmp;
>>>>>>>>>>
>>>>>>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0tmp =3D swp_entry(swp_type(swap)=
, swp_offset(swap) + i);
>>>>>>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0__xa_store(&mapping->i_pages, al=
igned_index + i,
>>>>>>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 swp_to_radix_entry(tmp), 0);
>>>>>>>>>> }
>>>>>>>>
>>>>>>>> Right. I will need to adjust swp_entry_t. Thanks for pointing this=
 out.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> In addition, after your patch, the shmem_split_large_entry() seem=
s always return 0 even though it splits a large swap entry, but we still ne=
ed re-calculate the swap entry value after splitting, otherwise it may retu=
rn errors due to shmem_confirm_swap() validation failure.
>>>>>>>>>
>>>>>>>>> /*
>>>>>>>>>  =C2=A0 * If the large swap entry has already been split, it is
>>>>>>>>>  =C2=A0 * necessary to recalculate the new swap entry based on
>>>>>>>>>  =C2=A0 * the old order alignment.
>>>>>>>>>  =C2=A0 */
>>>>>>>>>  =C2=A0 if (split_order > 0) {
>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0pgoff_t offset =3D index - round_down(in=
dex, 1 << split_order);
>>>>>>>>>
>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0swap =3D swp_entry(swp_type(swap), swp_o=
ffset(swap) + offset);
>>>>>>>>> }
>>>>>>>>
>>>>>>>> Got it. I will fix it.
>>>>>>>>
>>>>>>>> BTW, do you mind sharing your swapin tests so that I can test my n=
ew version
>>>>>>>> properly?
>>>>>>>
>>>>>>> The diff below adjusts the swp_entry_t and returns the right order =
after
>>>>>>> shmem_split_large_entry(). Let me know if it fixes your issue.
>>>>>>
>>>>>> Fixed the compilation error. It will be great if you can share a swa=
pin test, so that
>>>>>> I can test locally. Thanks.
>>>>>>
>>>>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>>>>> index b35ba250c53d..bfc4ef511391 100644
>>>>>> --- a/mm/shmem.c
>>>>>> +++ b/mm/shmem.c
>>>>>> @@ -2162,7 +2162,7 @@ static int shmem_split_large_entry(struct inod=
e *inode, pgoff_t index,
>>>>>>  =C2=A0 {
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct address_space *mapping =3D in=
ode->i_mapping;
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 XA_STATE_ORDER(xas, &mapping->i_page=
s, index, 0);
>>>>>> -=C2=A0=C2=A0=C2=A0 int split_order =3D 0;
>>>>>> +=C2=A0=C2=A0=C2=A0 int split_order =3D 0, entry_order =3D 0;
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;
>>>>>>
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Convert user data gfp flags to xa=
rray node gfp flags */
>>>>>> @@ -2180,6 +2180,7 @@ static int shmem_split_large_entry(struct inod=
e *inode, pgoff_t index,
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 order =3D xa=
s_get_order(&xas);
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 entry_order =3D order;
>>>>>>
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Try to sp=
lit large swap entry in pagecache */
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (order > =
0) {
>>>>>> @@ -2192,23 +2193,23 @@ static int shmem_split_large_entry(struct in=
ode *inode, pgoff_t index,
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xas_try_split(&xas, old, cur_order, GF=
P_NOWAIT);
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (xas_error(&xas))
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto unlock;
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Re-set the swap entry after splitting, and=
 the swap
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * offset of the original large entry must be=
 continuous.
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < 1 << cur_order; i +=3D (1 << spl=
it_order)) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pgoff_t aligned_index =3D =
round_down(index, 1 << cur_order);
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 swp_entry_t tmp;
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D swp_entry(swp_type=
(swap), swp_offset(swap) + i);
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __xa_store(&mapping->i_pag=
es, aligned_index + i,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 swp_to_radix_entry(tmp), 0);
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cur_order =3D split_order;
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 split_order =3D
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xas_try_split_=
min_order(split_order);
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 }
>>>>>
>>>>> This looks incorrect to me. Suppose we are splitting an order-9 swap =
entry, in the first iteration of the loop, it splits the order-9 swap entry=
 into 8 order-6 swap entries. At this point, the order-6 swap entries are r=
eset, and everything seems fine.
>>>>>
>>>>> However, in the second iteration, where an order-6 swap entry is spli=
t into 63 order-0 swap entries, the split operation itself is correct. But
>>>>
>>>> typo: 64
>>>>
>>>>> when resetting the order-0 swap entry, it seems incorrect. Now the 'c=
ur_order' =3D 6 and 'split_order' =3D 0, which means the range for the rese=
t index is always between 0 and 63 (see __xa_store()).
>>>>
>>>> Sorry for confusing. The 'aligned_index' will be rounded down by 'cur_=
order' (which is 6), so the index is correct. But the swap offset calculate=
d by 'swp_offset(swap) + i' looks incorrect, cause the 'i' is always betwee=
n 0 and 63.
>>>
>>> Right. I think I need to recalculate swap=E2=80=99s swp_offset for each=
 iteration
>>> by adding the difference of round_down(index, 1 << cur_order) and
>>> round_down(index, 1 << split_order) and use the new swap in this iterat=
ion.
>>> Thank you a lot for walking me through the details. I really appreciate=
 it. :)
>>>
>>> My tests did not fail probably because I was using linear access patter=
n
>>> to swap in folios.
>>
>> Here is my new fix on top of my original patch. I tested it with zswap
>> and a random swapin order without any issue. Let me know if it passes
>> your tests. Thanks.
>>
>>
>>  From aaf4407546ff08b761435048d0850944d5de211d Mon Sep 17 00:00:00 2001
>> From: Zi Yan <ziy@nvidia.com>
>> Date: Tue, 25 Feb 2025 12:03:34 -0500
>> Subject: [PATCH] mm/shmem: fix shmem_split_large_entry()
>>
>> the swap entry offset was updated incorrectly. fix it.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>   mm/shmem.c | 41 ++++++++++++++++++++++++++---------------
>>   1 file changed, 26 insertions(+), 15 deletions(-)
>>
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 48caa16e8971..f4e58611899f 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -2153,7 +2153,7 @@ static int shmem_split_large_entry(struct inode *i=
node, pgoff_t index,
>>   {
>>   	struct address_space *mapping =3D inode->i_mapping;
>>   	XA_STATE_ORDER(xas, &mapping->i_pages, index, 0);
>> -	int split_order =3D 0;
>> +	int split_order =3D 0, entry_order =3D 0;
>>   	int i;
>>
>>   	/* Convert user data gfp flags to xarray node gfp flags */
>> @@ -2171,35 +2171,46 @@ static int shmem_split_large_entry(struct inode =
*inode, pgoff_t index,
>>   		}
>>
>>   		order =3D xas_get_order(&xas);
>> +		entry_order =3D order;
>
> It seems =E2=80=98entry_order=E2=80=99 and =E2=80=98order=E2=80=99 are du=
plicate variables, and you can remove the 'order' variable.
Sure. Will remove one of them.


>>
>>   		/* Try to split large swap entry in pagecache */
>>   		if (order > 0) {
>
> You can change the code as:
> 		if (!entry_order)
> 			goto unlock;
>
> which can some indentation.
Sure.

>
>>   			int cur_order =3D order;
>> +			pgoff_t swap_index =3D round_down(index, 1 << order);
>>
>>   			split_order =3D xas_try_split_min_order(cur_order);
>>
>>   			while (cur_order > 0) {
>> +				pgoff_t aligned_index =3D
>> +					round_down(index, 1 << cur_order);
>> +				pgoff_t swap_offset =3D aligned_index - swap_index;
>> +
>>   				xas_set_order(&xas, index, split_order);
>>   				xas_try_split(&xas, old, cur_order, GFP_NOWAIT);
>>   				if (xas_error(&xas))
>>   					goto unlock;
>> +
>> +				/*
>> +				 * Re-set the swap entry after splitting, and
>> +				 * the swap offset of the original large entry
>> +				 * must be continuous.
>> +				 */
>> +				for (i =3D 0; i < 1 << cur_order;
>> +				     i +=3D (1 << split_order)) {
>> +					swp_entry_t tmp;
>> +
>> +					tmp =3D swp_entry(swp_type(swap),
>> +							swp_offset(swap) +
>> +							swap_offset +
>> +								i);
>> +					__xa_store(&mapping->i_pages,
>> +						   aligned_index + i,
>> +						   swp_to_radix_entry(tmp), 0);
>> +				}
>>   				cur_order =3D split_order;
>>   				split_order =3D
>>   					xas_try_split_min_order(split_order);
>>   			}
>> -
>> -			/*
>> -			 * Re-set the swap entry after splitting, and the swap
>> -			 * offset of the original large entry must be continuous.
>> -			 */
>> -			for (i =3D 0; i < 1 << order; i++) {
>> -				pgoff_t aligned_index =3D round_down(index, 1 << order);
>> -				swp_entry_t tmp;
>> -
>> -				tmp =3D swp_entry(swp_type(swap), swp_offset(swap) + i);
>> -				__xa_store(&mapping->i_pages, aligned_index + i,
>> -					   swp_to_radix_entry(tmp), 0);
>> -			}
>>   		}
>>
>>   unlock:
>> @@ -2212,7 +2223,7 @@ static int shmem_split_large_entry(struct inode *i=
node, pgoff_t index,
>>   	if (xas_error(&xas))
>>   		return xas_error(&xas);
>>
>> -	return split_order;
>> +	return entry_order;
>>   }
>
> I did not find any obvious issues. But could you rebase and resend the pa=
tch with fixing above coding style issues? (BTW, I posted one bugfix patch =
to fix the split issues[1]) I can do more testing.
>
> [1] https://lore.kernel.org/all/2fe47c557e74e9df5fe2437ccdc6c9115fa1bf70.=
1740476943.git.baolin.wang@linux.alibaba.com/


No problem. Thank you for the review.

Best Regards,
Yan, Zi

