Return-Path: <linux-fsdevel+bounces-57614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E921DB23E38
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 04:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE0E51AA7A79
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 02:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8721E47A5;
	Wed, 13 Aug 2025 02:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="mcBoqign"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013018.outbound.protection.outlook.com [52.101.127.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8409F2C0F8F;
	Wed, 13 Aug 2025 02:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755051959; cv=fail; b=gX6WA1i9viql3/hyFHrZ9BRQEj0DPxEOUD01FshB1nrbAsWP6SQrYwCf5AbftJadpIvB6KKwUhM+4NyZMrNAsL3Z5zCJaxRapA4zD1ExUabTKb1c5AWW34cWOnz1YIvRqm8rrpo97bhe/CVs69VycupEPGXp4kjprDAAqL4YU+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755051959; c=relaxed/simple;
	bh=Wt61k6Ypx8L2hCXlJ1K8oaODQZCEL2xYrpSLjcGma1A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mV/Gw0iV76aUIhB209D6LagLWeG+IAO8LKxwsEqbMPEWkiLdwIJtqrxKFYeiXp5LlHjgrRh9Jtf8imcKVHpd05OxA4MzwNUDJcOkPXulVXX51Q9Z313HErD7Td9w2AvUSu/8B2zpLEZLSIphqAAbjKopPVr6FgPX8gBPRESSKPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=mcBoqign; arc=fail smtp.client-ip=52.101.127.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vhfFxXen0bzBHF5UER5C4Kek7s2izmwSlXMDKtHeBKf4CFfAkgHrlzhiii/sI8iIyRgsjadY5qrgBI6OrTldDbGmC8u8IkAZamRtk3VV7QVPhyTxPYEQOE+aCH/grMHI+QS5KWnu6elGI9WrHUGh73oXgmU9B8reuFbO5gvhIfo0MFi1H82euX9cBixCJYnJp970zV9Bt+SheqLlAZnAIqk3QxsH0FAELEbzkF7VfhIKfvSidzwFKLYshM++iLsICGWLwEKscQrc3xhqE4nff9VDiQgCuVs4bEyQtQ4J/2vl+5VcfO+cN4Xrl6G80sRvlzeDELZXKdifyf21Mx5UuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hL9iZBN8GkU0UTCDUv2nEZdr/lNCJVrWlKzmhiA3SeY=;
 b=suPKtsH1s6wIyPzQqmKOPAuR5wxu72AW8iIsouWMxrXoBG0XmwYD/I4GXrMGHsGWJzOqLGytf0z6K7N2FITB2CK+dJCZig7e0jL6J2KJkP4KpeG3+7u4elPD/Cta3P7/8K7vSiDj5I0CnA9bwA5tj1d4PKlGJhtL3DHAaNxJecsHqY0FBeQpUqQmKLRhrDhNOnhaSzLP+Nz2e/gpDIAKRzap5Sze5dYWYB4gpaErB201Bfjn6OoZncQSp0v+JshrWS16YhwryLc74ylV+51fYFcmknybirWZx4zMeFA4jV9hKpekNv1nFHbj6dzQPXPFbpfdjPnLldPEvfuuR+0Cdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hL9iZBN8GkU0UTCDUv2nEZdr/lNCJVrWlKzmhiA3SeY=;
 b=mcBoqignWCD2XOsiI8fyjFMJrfbBiOFpVRDqxSE6u/EBBLmdLJ/ppOqHAhISUOP3+wu8Mw4lIADPkdnZ6CGOQ5LKCQJOx5O7oPXmtQnOGaIO00YZYN+tzIBrqBFWYOrPyy1zrf7h13NNgaiwLzIwYeK+bajlnsBcSS/v+eYnXQqDOFLLha2W6aZbjxd3BG5WVkAPAK2lf+ZW8T3ZNd3r4mobjeJE5LIv5F8qsqZdP+5vQWprUkLyybHMtF/mW8kHozpold/EOIxDIy5SkdFS/tJzTHJDGGooTVquEwQfoaf7gRoDozkX3SY29twYOyMRuEa/gpW5WQhXEKDxk4iz1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYSPR06MB6409.apcprd06.prod.outlook.com (2603:1096:400:411::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.22; Wed, 13 Aug 2025 02:25:52 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.9009.018; Wed, 13 Aug 2025
 02:25:52 +0000
Message-ID: <784dd559-612d-4037-b315-d1b30253538a@vivo.com>
Date: Wed, 13 Aug 2025 10:25:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: remove redundant __GFP_NOWARN
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 David Hildenbrand <david@redhat.com>, Rik van Riel <riel@surriel.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>,
 Uladzislau Rezki <urezki@gmail.com>, damon@lists.linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20250812135225.274316-1-rongqianfeng@vivo.com>
 <b5ca3ef2-bd36-4cb5-a733-a5d4f1fb32fa@lucifer.local>
From: Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <b5ca3ef2-bd36-4cb5-a733-a5d4f1fb32fa@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0016.APCP153.PROD.OUTLOOK.COM (2603:1096::26) To
 SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TYSPR06MB6409:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ddd737c-05b8-4ba5-30c2-08ddda10b998
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGJmWDN5T1F3c2N2cTREWEE5bUc3L2duL2dHSjloRUxYRlkyZjZPSkNqZmVx?=
 =?utf-8?B?cmNUdFl6dlEvK0NHVmRMVWc3WlhjYXJaVngvcUI1Zm1kdFNwVkpCYzFSbmVQ?=
 =?utf-8?B?eTRvVVE5RCtIOXY1d2lOQ245dVprSGM0MGRidndYcjNZaWF1allSN09oTk00?=
 =?utf-8?B?RUU0eTFxaFMwV1NoMzlGWEVldkJLN3BVdkRXOXR2ckt6YWRjSTNPRzN4end4?=
 =?utf-8?B?a0c5Ykx6elRUOGNZajVZWHBkSUJaQ0Z4aE9vcW5SbzVkWDhHTTVrQVg1bzBx?=
 =?utf-8?B?anNKV2UrRHpVUGd3NC85alU2Um5OTzJ5aktyQ1BsVU8zQmVMSnJWQ2VjZWtn?=
 =?utf-8?B?UjNBQ1lvbGxuczkwZTlpKzMxT3F4cXdtWUY5NjVTVmZUUm9naVpUMTZOSFNa?=
 =?utf-8?B?a0xLeWtsS3UrQUw2VUxFNkd4SUVhR3JxOEdONE9BaDEvV3dhYXdXVmtFUVRU?=
 =?utf-8?B?N0RCWWVDQWN6WldkYWsrM2V1Tk9XdVZNSlVpa21DQW12WlNXZW5uRnovdm5O?=
 =?utf-8?B?WkxpeTJnS202TUZpdHZRa21ZVllMaVFNTWxXQ1VDeDY2VEtmV0w1cVRYNUxn?=
 =?utf-8?B?RjNOQ1AzWEpDU21DSGlreWFoUnJXVGFCM0pUbFBscVNXM3AwUWhobUhmOUNm?=
 =?utf-8?B?VE9ZWERkSVRocWNtWnNMczBVS2JSUUQ1WEN4QmR0ZG5yYnMxa2NkdmNRZFVE?=
 =?utf-8?B?Qjl4Tm9wT3U5b044OGYwQUtrdUxYUDFFemlkT1FieHFVUVdQOXFzT1JISkVr?=
 =?utf-8?B?dE5Zb2FJN1Z0NUVQVnc3aXdTVmJEUUo3eWVEWEovV2ltMTZmYmQxZzQ2RnRX?=
 =?utf-8?B?SktuMFR5M2hBdmJXdWJkTm1SUUZOK0gzaG1OVUdyU0djNFJYOFdUZ2FNT3ZU?=
 =?utf-8?B?Qnl1M0MzbkVCK1RVVnRBM2ZXR2lUOWQ1Wjg1SWl5WVNEV2VoL05qM09HalJQ?=
 =?utf-8?B?cmxudjNyUVVqbVE0cDA5OUhRMW4xNkc5T3J2MzRDTHhhZmZHWDFHbXA1ZDgx?=
 =?utf-8?B?QWVwa29uc3kvUFc2c0xtQ1gyREVoMlZ6dWZFVDUwM29acnhmamxPcjRwUHhs?=
 =?utf-8?B?SVY5MG85WkN3RnpvSTZ0UkhRSTFjbUpRQVNldWxVRUZKR3orazVBY0NZbnNi?=
 =?utf-8?B?VE1BRnAyYlB1aTNWMDNtbERkTkJUNlp3ZDl0Q1l3MUJ5TDF1aTlnSDM3c3RU?=
 =?utf-8?B?cDRKTDloN0Y1UDBmZGhJZ2lRUUQzQ0ZyUktoL0ZLV1dEVnIvY2htVGNSRGZO?=
 =?utf-8?B?Vk1XVDlsTHEvdVdveW1DeC82Z0JDTis5Y0EvRm5TV29zaHl0SkRiVTBBZld4?=
 =?utf-8?B?Y20rWFF3eHhiYVZTVmRzK0NnWFJKY1hacU5XUHFRdkNBT0ZnU0NtbzIyYjda?=
 =?utf-8?B?UDB5ZjhFUzRIY2xHSDlQMUVOK0VubzNaVXJxeUVZWHZ0c2hZeVlwMnhkWDNt?=
 =?utf-8?B?MU1hM1NwTjRCVlJCWk9hd29DRFk4WTIyYWk5VllHR3hINXBibTE4VlBxRUlV?=
 =?utf-8?B?NklXTElHcDFuVURHcDZlYjk2b2QxV244ZStmWGF3dzVBRmRqQVo0NHpHWlM4?=
 =?utf-8?B?NVNudExMM0xnOE81TDg4a29leE0wSTFJWVUrTFlmSUE1ZGhJMGpxVmlJenpO?=
 =?utf-8?B?STlNM0ViYTQ3aDdmelVmb0dlOUgySFV5eVVPanYwNzdHU01MQ2dCU1V6bDND?=
 =?utf-8?B?aStqaWJTMVBjRnhEdFZ6dHdzajVub1lMNkQ0SlcvUWV3UGN5cFFsWWhiNS9u?=
 =?utf-8?B?YzRIQzdYV05aS3JEWmkxYTZadE9YTm5MZkRTL21UMUs1Vjh4a3JQWmxqSzZo?=
 =?utf-8?B?aUgxYnpUWkFCaTFWMTBkcHRQeVYrR2JXWERlWUVXaE5aUHdKT2hIaGdQaDNn?=
 =?utf-8?B?R2JMV3VJdU40bFljbVovMWNQRXBnYVNlQzhpS043NkU2UDVVVEExekdyZnBE?=
 =?utf-8?Q?WIuv4VEXmxQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUhiaGpqeVVMeHZPUCtlcmtNaXhzM2xJSHFSUDBnVm5leUM0SDcwUFNyS1c2?=
 =?utf-8?B?dmZMUUlsalpKQXg1dXR6Vkc0aFBSUkdkeklOZjRwMTZ0T1hHVmhMVHJ1dDQ2?=
 =?utf-8?B?SU9qS0I2NktnWWROeEdGYTIwQnVmMy95NTJlY3RJcjh6bzM1YUtGTVE3d0Zs?=
 =?utf-8?B?WHlJc0Q4c0U3SEsxRWxiOEVpM1J5a3hwejFHeExtZUw2WWJrb2lQM1NvaDM3?=
 =?utf-8?B?czg1MEVNc2szNTFQR0NoWUI2VkdFQ0F4aGwzakY1VTFYdUZRcUd5elFJdDV2?=
 =?utf-8?B?RzdxV0lEV3Nyek1pTnM0T0o1dmRNY2FNYnpTZm4xaGw2Nzdzdm1CbDJwanE3?=
 =?utf-8?B?RkJDMC91d0srb3FlUm1kN2VDR1BITm1oalRLZU1FTm5RQmI0N2RCODRrWWUr?=
 =?utf-8?B?dUxTc0doYU9IWGhEc1BUYUdieUp3UUJWMFFNZnNrcFAvSSs3Wno0R2xNd0R5?=
 =?utf-8?B?ZzA4OS85eVFKZVZ0WEVJdWdaWEdWWElxK3VsMi9LVU05d3ZQS3ZZbjhrc1NM?=
 =?utf-8?B?a0ovb0NtckV5cDBjR0hYWTVMUXZ3SjhqVHZveFA2OFZaL2RzS1lVT1NSNDd1?=
 =?utf-8?B?c2ptN1pXdE8vL2l1U0FwRm4rMTVQVEY4OFlmcU9lWVV4RlpUTWlKQTB5S3U5?=
 =?utf-8?B?WGNDQkVHM056UExFVHFycUp1cmsyUjdIKzBmM0FvMVVBZ2xCeStvNndHbmpr?=
 =?utf-8?B?b1lqWjlKQ0NDSDl1TmNnd1pJUmkxTCtmZ1lLZTNpNmxIMkhUQk02aVFPTzc3?=
 =?utf-8?B?d1REa2JPeitvREhtaFVyYklSdnlSSnprTkthekEwY0IrQTA1SThvTjdVeXNi?=
 =?utf-8?B?QkRxdkt1U1dCeEcwb2w0OGdPN01ocWQycnU4c3Nmeko2UGliRjl6ZEhrRkNW?=
 =?utf-8?B?cndsd3FqbTRsVkVpWFdXWDBQMFdWMCtleGdXaUVFM2JYM2hXRXRGemIrbGlV?=
 =?utf-8?B?cWRUZFJxMlJrVmhHVTZTcEh4ZExlWGt0NzNTb2ZKV0h1WnFhVjF2aU5kbFAx?=
 =?utf-8?B?YlI1a21qQjFVRlU1MWVNZjBlcTh2MThKS2kvMzJtL0lTcUlWdUx0ODBCL2Z3?=
 =?utf-8?B?QW5PR3BJdTFGTm1Oa0FrUDdKdSthSGVNUDAwdGZhRWl0dDlWdDZZK25SekhD?=
 =?utf-8?B?RlpTejd1NVlxdlV5czFJR01UTmRNZlpaZzFObGtLL296WHpqcGJFK0k3WmpP?=
 =?utf-8?B?SnAwM1JiakhpQldpVzQzUWNMWE11MTJnd2RoQmJKU3VPbXRLR3dEL0ZxYXZ5?=
 =?utf-8?B?bWd5UHFVTzU0dE9ZazJnSXlXTE9PY2w3U1A1STlzUGplQ3psWnpPSmJwdW8x?=
 =?utf-8?B?VFNaOWlBM0ZpbkxyRXUrQzk0UEM0dXpSb2VrYnVwenRyVUowSzl5ZEgxb3BJ?=
 =?utf-8?B?Q0szejVzYjJHTmZmVW1hOWVrc2pLaVB5QWhzdno1NE5waHB4SHFPS2hXVHkz?=
 =?utf-8?B?SEtYeHE5d2VZRFU4cUR2cDI0YW9WMlZncElEejZPeHhTa2dnYWdvZlZwTnNF?=
 =?utf-8?B?c3VXcFBEQVU0dVJUS2VtdENaRERxK3hvaGFKYzhqZ1N2ZG1YVHJBNFdaVGt2?=
 =?utf-8?B?N0ZWNm1ibTM5d21MVjdOcVc5Z1JhTnZORjl2NExhYkhkbDM5cllrWGFZR0hJ?=
 =?utf-8?B?L1JQbVdsc3cwWFBDRG9ZQnVyOURSNnZMM1Y3a0NGeURIOFdmYmxoc1FRY3ZV?=
 =?utf-8?B?V3RqR0dXdGxqd3d3dDZMN2ljZDZlNFVKeWVReVE1enZ4QXpjejZDV3pwWWpO?=
 =?utf-8?B?VlNrOGd2NWxKYWZocU9nUmIzS0UxUjU5VW5IUFlaWW1NOU9PcEcyTWswM29N?=
 =?utf-8?B?akhNL3psbFNOT1J2ajB2WTFzWGxzbnVSN2xjSzdKa0FzQ1hkYlBUcnBVR1E0?=
 =?utf-8?B?aCtSNHRZN3VQSUE0QWNUMTVvT1V3VDFlT0t2SVV4K0NhR21Zd1ZUSU9qZkc3?=
 =?utf-8?B?SE1kZkcxZmJMaGVZYjU0OEx3WUxTaXB3UUUrZ1hBY2d0ZktCNDd2ZnlqR01k?=
 =?utf-8?B?VTAzSmR0aGZpb0p0U0NKbFZ5c3BqWlRJQVg1VUJURitvdmJrUzY2cE9ETzdk?=
 =?utf-8?B?N3VLZnFuSGpZN3lMQjFkTldpS3RCUkRnakxSdGlzUzgvK0lvV2RZL05pcWhs?=
 =?utf-8?Q?jlq1i5MmERhR8Y2p+8yXGVvOV?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ddd737c-05b8-4ba5-30c2-08ddda10b998
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 02:25:52.6243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sFcXLstFqaAzY0yErOeCqfHju4GJfFceycPShuNaOHwodkQAZdGIBRGPz+4MqPmY9xtonhDWHycGwW1NhOJJtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6409


在 2025/8/13 0:46, Lorenzo Stoakes 写道:
> On Tue, Aug 12, 2025 at 09:52:25PM +0800, Qianfeng Rong wrote:
>> Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT") made
>> GFP_NOWAIT implicitly include __GFP_NOWARN.
>>
>> Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT (e.g.,
>> `GFP_NOWAIT | __GFP_NOWARN`) is now redundant.  Let's clean up these
>> redundant flags across subsystems.
>>
>> No functional changes.
>>
>> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
>> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> LGTM, I wonder if there are other such redundancies in the kernel?
For similar redundancies in other subsystems, I submitted separate patches
to minimize potential merge conflicts.

Best regards,
Qianfeng
>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
>

