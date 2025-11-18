Return-Path: <linux-fsdevel+bounces-69027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C8BC6BC8E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 22:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 067E2364443
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 21:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF793093C1;
	Tue, 18 Nov 2025 21:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sea9Q42T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010037.outbound.protection.outlook.com [52.101.56.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5184C2F12C5;
	Tue, 18 Nov 2025 21:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763502881; cv=fail; b=cPlGh3Z4Fk5OI5hbiqcdgnFXLpt+cHb4tix4D54lo4P0hfSue2S6QZlaBa3VOSmkXFJeoz7t8fuk7iCis15OakGbspZJOIM92c2X5klbf6dj6LMPoz3lMtWGRNn545g8Js7f9tLXIvWORFyghVCqWyGa4qMeSeVOCUM4LY3FgWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763502881; c=relaxed/simple;
	bh=cT+GXx3NQmPZ28q76Y8yWcNo9bYOius+vRUJ76/iSzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XABZHKtT6mX1/0guyrqX6Z7rjMtAqkkJmVKGiNpdnph8/ro0ZJJRHPx7nsWp9zhJNyeGZ3ZEn7bfpdZKy5VWwazK5eEemcceXD7/djwOUi0JhUbpqv4x0C6QpkYRf2sAggc0pqujRc3YR5lKwtu5210FPvYKyToGP8OD4uJInKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sea9Q42T; arc=fail smtp.client-ip=52.101.56.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WED2zFTqWMvtAKRmN9eyVUww8usHJ/4ErAnslW26jKXaiHo6K6vNOLP9gqClRiaKCcbPlSWOwowRAAlQyfe5EBdI2V1OKx4YoKImb6vnuci3EnkDHbaj/hW0PSBBxLyti14QYQcAhCRLc/ejJFxlUmbgY7kNTPj3Pzkl8jcWVfMeAnC2Q9QeEyHBfGxa5sIq5a1ik7DJtKvxfPo18TkZNftKoufKTx9jh67+04FNTSmQwW1lsshdrenN3rgverYi3Mz2G7Zo99kWMdHydt6L+7FlqMWvUNRprxTvgPEGcP4cyRHTlQMCiciMbd7IsT2PbKAqmQWRcVsEUwUmL6b4pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAb/2sCmHYUzUMIbA5Et3A+9T+th+t2umCznMbN5+wA=;
 b=EV0o1IHRFzoTpCB4aySx5GFHob7n7L7+iItrgkpx1sWehOTo+5zZ75oi0HLsjHyaO1uxRKQHiRQkqjKFoTcUPCXwNDQ094t2KpWTWD983niFU4F68Lt9flB84gVNvoIKQESBg2eoJTiO5GDbpm7BAzjilLWXgA++8ULqzA96r4aAUwoQV3C9l5F8P+xnjvLdrZsFT60JDIH/Ga9wONG6MGtSFZtY1gKPY6nF3mKtesSOxRPcVUd4nDZ81KCdMJ/3LJvejKMm9Hzi4vtDDKtrYEGZR1GRsssAJBnrSXtLkLy88gwl4O2q75T1El7lty8ZJe2s8Dj1PBnVa/qWJYCA9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAb/2sCmHYUzUMIbA5Et3A+9T+th+t2umCznMbN5+wA=;
 b=sea9Q42TVtvY3AlUDltSIIGX364KWMFKgCtFW9ne71wNk1IIIvmfmDruiaHGIU835aVnzXbWCFrTnXc6UGEhrm7P8/vXexoZzbq/YbI9cSp6AluQzn+IFIlke9A7XT82eSKUt0is1R1i61hRrEcClJf3PBvXq7JYnNc9VGT0Fm547m2Sq9bk1V0b+oCqMrTszU0mUYBFutxc+BkdqG14kOkC4icvaf3paTvN3RHihySnqoF24JwOLlHDIIWfNy0tSCBOwwTv9ILE9ry4nhQQq0alCbpO3/SwwksIgvexz8Usq2YCkjsdr+m2KYXWYytVLaFsP+RJzSE8jTt6XAlQVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA1PR12MB6797.namprd12.prod.outlook.com (2603:10b6:806:259::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 21:54:35 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 21:54:35 +0000
From: Zi Yan <ziy@nvidia.com>
To: Jiaqi Yan <jiaqiyan@google.com>
Cc: Harry Yoo <harry.yoo@oracle.com>, Matthew Wilcox <willy@infradead.org>,
 david@redhat.com, Vlastimil Babka <vbabka@suse.cz>, nao.horiguchi@gmail.com,
 linmiaohe@huawei.com, lorenzo.stoakes@oracle.com, william.roche@oracle.com,
 tony.luck@intel.com, wangkefeng.wang@huawei.com, jane.chu@oracle.com,
 akpm@linux-foundation.org, osalvador@suse.de, muchun.song@linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v1 1/2] mm/huge_memory: introduce
 uniform_split_unmapped_folio_to_zero_order
Date: Tue, 18 Nov 2025 16:54:31 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <5D76156D-A84F-493B-BD59-A57375C7A6AF@nvidia.com>
In-Reply-To: <CACw3F53Rck2Bf_C45Uk=A1NJ4zB1B0R1+GqvkNxsz3h3mDx-pQ@mail.gmail.com>
References: <20251116014721.1561456-1-jiaqiyan@google.com>
 <20251116014721.1561456-2-jiaqiyan@google.com>
 <aRm6shtKizyrq_TA@casper.infradead.org> <aRqTLmJBuvBcLYMx@hyeyoo>
 <aRsmaIfCAGy-DRcx@casper.infradead.org>
 <CACw3F50E=AZtgfoExCA-nwS6=NYdFFWpf6+GBUYrWiJOz4xwaw@mail.gmail.com>
 <aRxIP7StvLCh-dc2@hyeyoo>
 <CACw3F53Rck2Bf_C45Uk=A1NJ4zB1B0R1+GqvkNxsz3h3mDx-pQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1P223CA0012.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::17) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA1PR12MB6797:EE_
X-MS-Office365-Filtering-Correlation-Id: b60e840f-fd7f-4e31-93dc-08de26ed1005
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDJYbXQ1aVl5Umoyc05rREJrUnR6aER2VHRFcC9xLzdvOXNEeUxybDVXZ0Q5?=
 =?utf-8?B?WTRkaVIyTytXSGcwbzdPdHVlWW9iUVNoWFJmR1JBeEJRRWUwQUJZelVsUnRR?=
 =?utf-8?B?bW0zQVpvZllOakN0Q2N2b3l2N1VHcnhPQmJDdFArb29OanVHZkg4RGhxSFI2?=
 =?utf-8?B?WlJsMnQ5cHM0cTdaVktYdm05bXlpamdVNkh2SUhUU25vNmJaRjJuaURCMzZa?=
 =?utf-8?B?eDIwbHYzVENjYnVCU2R1RUpmM3owbFhoY3gyRE40S3hXemFVZEZ6cnd0UFBH?=
 =?utf-8?B?N1cxYUZMY3NXOWpoQk9XM0MzQktrWWtWVSsvTHpQOThUSXRMdXowSmprNkFZ?=
 =?utf-8?B?ekFOTDB5eXRzayttZjdxbEEvK0NyMzdYZU1QRkFQUkU4U1h1c05zdWtBa0h5?=
 =?utf-8?B?YzlUMXN1cHF5L3pkcTFPTVQxVHRMcHYzRlhoWUJvMFY4QUY4YnNoYW9CZGJl?=
 =?utf-8?B?dlRxWlJ2VnZaSVVNL3I2Wk9ISHJBbTNKZnNpWU5Zcm9QTzcwNnFxYTZOWVpw?=
 =?utf-8?B?UWIwNU1hNG9BQ2Mza3loZmdhV0l3SnZLTzJCU2F1a0ZYdzg2OGlROWl3cS9s?=
 =?utf-8?B?ZE9XMXZxbFI3VWhwa2g3OU16a1doL1Z4bVYrOUFuOWJIczdYTGZLdWxLZTlQ?=
 =?utf-8?B?NkpsNDhJY01BUnZheHpxNW1XdnJHclphcklkWjhWWnkyWVZxS3RGaFdUcWho?=
 =?utf-8?B?dUdLaHhVd0ZtU0FlTTJIZVBaMDZqVWFZdkhUM1RkUUt6clI1ZXh2djVOUFJ1?=
 =?utf-8?B?QnV6VDZxMkttWGlZOFBtU28rb0ovbkhRcDM2YWxLZWVzZ0FHOEtlVFBpRjR1?=
 =?utf-8?B?MkhwVVMrVjR0NXppNHROYk52MjMvSVAxczhsNXRCd2FPaW5wcncvTnFSc0pS?=
 =?utf-8?B?TmxzMnpkd2s1bzVGaWpFV0hSeFBDNGNQdUdCSEtWRllRT2Z2bUxJTzd4WGdo?=
 =?utf-8?B?TFpMYTQxdTc2NHFWVHIxRWp0QVMxRndmSHllb3NxVm5nQTJlcW1DVndpZkR2?=
 =?utf-8?B?c2p3c24za2RpbkEvV1p3bi9FVldNZjB0ek5QelpzS0hpc2V1K0wxMUMvZzd1?=
 =?utf-8?B?VGdpZ1VQV2l6aS9pb0pkbVRzam1tcVVwL3NpMlJkQ0VqeXp1TmVtU0lTQU1W?=
 =?utf-8?B?REhCSG00NE9BQ040Ylljck9QVHNMd3k0YUFGV3ZRdkZDakpTL2J4SnhjQVpN?=
 =?utf-8?B?c05QeGZ2UUxFQnpZZ1dBb3oyMnUwMXkyQXdNd3I5anQ1TTdZQ3NYQnVQL0gv?=
 =?utf-8?B?N3FmR2FTSUs5QkFSSWhhUHJQTGVTZGVoVXZGT0xLRDM1UjFkSVNURkNEaGQy?=
 =?utf-8?B?YlMzZDcrN3gwaXl1eXZ3eE5wZXNtRFNaaExJTVk4TnAwbW02S3BGYU84YnVM?=
 =?utf-8?B?UlFjRkwvTkhBQnliYm5EVkthNVhYQ1BGdDNIa0cwdHo1QWVqYk16aUNyeWtp?=
 =?utf-8?B?ZzlscDZwZTMyMkQremJySjkxZER2TFc5MmpvZmRJSm9NU1owMnd6aHh4bURR?=
 =?utf-8?B?RWZnellDZStiTXRYTnExd1FtVmFzem10czlJeE9mR1Q4L21tOFI3WWNKUUZH?=
 =?utf-8?B?VU9QYXRIeWs3bWNxTzhqZVJVeHNlaW5pQ0Jla2o1V2tCZHZUam8rdnQ1WWdz?=
 =?utf-8?B?aVl2bWJxUURIcy9sODFIUSt6eHhYdEh6dmswQlI1RnBrV1Fta1UyblVSYVJh?=
 =?utf-8?B?Z0ovanFMcWV1ZDc4Z2dMdlBhb25iUDJyL3Aybkdma0h6YjQ3Q1p2WnpHVlpk?=
 =?utf-8?B?L0V3ajM2dFVhdUZsMUV6UDdldFhEdlNiaGE3RURtdWhEVk44WjM0ZDhSbE03?=
 =?utf-8?B?ZlpmRFYvV0l3QmNGdFpodDlrb0NGMzNMbms5TS9wSGZCcCsyd2JsaHozdlRR?=
 =?utf-8?B?dDNJam1IeWJpSC9ZY25FQ3JvT2VBcFhuVUwzSDV4T29EZWJ5Qm00N1IwMmhM?=
 =?utf-8?Q?BpAYuauzpGVSckNFA4zoQw7G5nnANObO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkRuZTJwaVRUSXh4Y3NwNUVZeDNqR05tM2czb3dTQXR0UFZMbW43akJtNElN?=
 =?utf-8?B?R1hEZnZoS292N0wxYlFML0VyNjhmZ3Bad3ZGZUtaT1JwOHBlQ2pNYTVseUw0?=
 =?utf-8?B?TndIZC8xUEdZV1M2MjRrV1BMekhrVXpPaWVRU2FHMG9LT1VBQUtqUkNjVlR4?=
 =?utf-8?B?aFpCQzNQZHAvSU13S1ltVU1OZTZoV2JkSFEzL2VsT3d3NlZoeGhrVnV6SWcz?=
 =?utf-8?B?VHprL09NSmgrbC8rREVTclEzT1QrbHBIa1pkYTZrMXJWelUrTk9rSWplaGZa?=
 =?utf-8?B?ak1WcmRBNnFiUmpBQjVnKys2MThQUFUyZ09ZYjNvUmVXc241UzEwNEpVUlRi?=
 =?utf-8?B?cnhISUx2OG5SUDRXbzdKS3RacUJnRTdzcE04LzFLd1c0eHE3cmc5blN4QnNp?=
 =?utf-8?B?eDB1V0xCTVowSEl6Z0drVHdOb2p4ek8yUEFoTUJtUDBtZ3JaaFFHOUVvbFVx?=
 =?utf-8?B?bnVjQlZ3TFJwTFJCNzdlREZFeGJXZEdyNEJkV2srbE1WMWJzODJxWWRIV242?=
 =?utf-8?B?cHB1dDVHOUpjQzU4L2g4TXZNUDA0UncwOHhFTGUzYXpBNC9Ta1kyblZ0M1Aw?=
 =?utf-8?B?UmZkRXlmdEF6ekxEZnh4TmQ2WkNad0JveEtta1V6VmRRWkV4QkRlNWw1aGMr?=
 =?utf-8?B?S1NXREE2NlN2ZXpwRkdvbU9JQkhybEpjNCttdW9KaENPMlgxZmNzb0d4bnRH?=
 =?utf-8?B?NDArNmNPWWd6RHJQOUpiUC9weXQySzZER21qUWtIdFlmOWw5ZnFPNmxxVkJL?=
 =?utf-8?B?VFVwOFB3Vk5Yc25Fc1c3eURHWk5vUUpMMnM2ZHlqZGhpcWRQS3dDSGRRd2Mx?=
 =?utf-8?B?U1duVzcrd1JoMS9rNmxuczNyT3lyYzNoM3M0WkxkWXpzeDhQTTNIczlyMXVD?=
 =?utf-8?B?T0M2S3RCdFZjZXVocStzd2p2VlU5NXRKT202REMzOEY1STkxbVVFb2twUHRr?=
 =?utf-8?B?cGU0dlhWdEY1aklWL3FvSmViT3ZKV0tYZFQ4RTQ4OEpaZ21uWU1JVEJOT2Yr?=
 =?utf-8?B?RUtQYy9UenB4YnF2K3AzVCtOZkhVcXlwbi9Zd2RoYTB1R2hzNW1memJvSkl1?=
 =?utf-8?B?dnF5Qmo2NFlZcDk3NWNPTHhNK3A0eTdLYmF2M0phOHV3cC8yTmRuWTBRQ21G?=
 =?utf-8?B?QkozcjI5VkNObndZWlhGZ29EOWV2NU9VeGYvWTVRalRTREp1RlBRclkxaGJ6?=
 =?utf-8?B?RStFNHBvN25WVkZweUdPblZQUGhKenRacVA0ekFQbWNPeUlGbFFuT3JwNUVm?=
 =?utf-8?B?NldrUjdMNlNVdVl4UWZoeTdNUzkxRG1FVWRxcXBFTFA2aTIrcmZ0Y0pvektv?=
 =?utf-8?B?WThrNWc4SFV3TnVIamk0TDlMcDdWZ3ZvRXUzUEFGa1lSaWxVWWQwTXhtaGx4?=
 =?utf-8?B?MGE5b2ZheU9YQmRDZUhYajl4Ulpud2JDdXdvRFBBcXFrUHpEWGplMzJ3bktx?=
 =?utf-8?B?TGFJS1dkZkZpQXZBT3RBQVc4emdNbWZVTWQxdDhxSGRHc3ZTR2hKYkZ1NVBj?=
 =?utf-8?B?MEtYNmM0Ris5MkZxaDJHMU9DYmJnbkc1UExDajh0bUEyN1RPMzBDNmFLSGll?=
 =?utf-8?B?T3daWDRMYWZSc0tNTTEybHE2Q1ZwSHVSN2Fxb01tN3VPY2RMbVJxdUs4Q3Fm?=
 =?utf-8?B?WndPTDd5ZkNxRkdjemlQZmRHb3hvQ29vajBBVXAzcmthTUxNU0lCTmV3YWFq?=
 =?utf-8?B?TERmMnFmV3h4TDJWU01XLzJweDZFdExkSndRNWgzM1A2cVBxeVcxd3JzTi9s?=
 =?utf-8?B?czB4RDBNbWZidDlhZW85OVMyWisxMmk4Zk9rOGRDcWpMbm0xWjVmVGxXRElj?=
 =?utf-8?B?bmdtMjRkVXhLYVFjdEt1TTdsN3IxbE1BK2dmOFBDUFEreU1uaFJPMTJSQytz?=
 =?utf-8?B?a0RBdUJHMnI0dmVVQ2lObFloeThlWnd3VzhPa2FKZzQ4SUs1UzNWSjd5R2lL?=
 =?utf-8?B?UWFnUjh1Vkg4OHlZV3ZuMHo0OVdhM05JdHQxeFlCNFo3RnMyVXBDNzlvM29t?=
 =?utf-8?B?amRYM2QzbTFmQnJNQzluSU5uQkpRZlRUTDlyZ0RpaU5oaFpLdjdTN1NzeVQ4?=
 =?utf-8?B?N0FRTmxySjAzTjFYL2M2SHh5OWtZMU1RaWNub1JqTzhJSWhXVys4SlBEcUpG?=
 =?utf-8?Q?6nsIr/zukLVitHQCpo8AbZly+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b60e840f-fd7f-4e31-93dc-08de26ed1005
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 21:54:35.2565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m2ZfAzUScmo+nJV1DuiFe4DTrAEcDe2pGIcG2kApimOVTErbPnmFSv5rE4bSBCYT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6797

On 18 Nov 2025, at 14:26, Jiaqi Yan wrote:

> On Tue, Nov 18, 2025 at 2:20=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> =
wrote:
>>
>> On Mon, Nov 17, 2025 at 10:24:27PM -0800, Jiaqi Yan wrote:
>>> On Mon, Nov 17, 2025 at 5:43=E2=80=AFAM Matthew Wilcox <willy@infradead=
.org> wrote:
>>>>
>>>> On Mon, Nov 17, 2025 at 12:15:23PM +0900, Harry Yoo wrote:
>>>>> On Sun, Nov 16, 2025 at 11:51:14AM +0000, Matthew Wilcox wrote:
>>>>>> But since we're only doing this on free, we won't need to do folio
>>>>>> allocations at all; we'll just be able to release the good pages to =
the
>>>>>> page allocator and sequester the hwpoison pages.
>>>>>
>>>>> [+Cc PAGE ALLOCATOR folks]
>>>>>
>>>>> So we need an interface to free only healthy portion of a hwpoison fo=
lio.
>>>
>>> +1, with some of my own thoughts below.
>>>
>>>>>
>>>>> I think a proper approach to this should be to "free a hwpoison folio
>>>>> just like freeing a normal folio via folio_put() or free_frozen_pages=
(),
>>>>> then the page allocator will add only healthy pages to the freelist a=
nd
>>>>> isolate the hwpoison pages". Oherwise we'll end up open coding a lot,
>>>>> which is too fragile.
>>>>
>>>> Yes, I think it should be handled by the page allocator.  There may be
>>>
>>> I agree with Matthew, Harry, and David. The page allocator seems best
>>> suited to handle HWPoison subpages without any new folio allocations.
>>
>> Sorry I should have been clearer. I don't think adding an **explicit**
>> interface to free an hwpoison folio is worth; instead implicitly
>> handling during freeing of a folio seems more feasible.
>
> That's fine with me, just more to be taken care of by page allocator.
>
>>
>>>> some complexity to this that I've missed, eg if hugetlb wants to retai=
n
>>>> the good 2MB chunks of a 1GB allocation.  I'm not sure that's a useful
>>>> thing to do or not.
>>>>
>>>>> In fact, that can be done by teaching free_pages_prepare() how to han=
dle
>>>>> the case where one or more subpages of a folio are hwpoison pages.
>>>>>
>>>>> How this should be implemented in the page allocator in memdescs worl=
d?
>>>>> Hmm, we'll want to do some kind of non-uniform split, without actuall=
y
>>>>> splitting the folio but allocating struct buddy?
>>>>
>>>> Let me sketch that out, realising that it's subject to change.
>>>>
>>>> A page in buddy state can't need a memdesc allocated.  Otherwise we're
>>>> allocating memory to free memory, and that way lies madness.  We can't
>>>> do the hack of "embed struct buddy in the page that we're freeing"
>>>> because HIGHMEM.  So we'll never shrink struct page smaller than struc=
t
>>>> buddy (which is fine because I've laid out how to get to a 64 bit stru=
ct
>>>> buddy, and we're probably two years from getting there anyway).
>>>>
>>>> My design for handling hwpoison is that we do allocate a struct hwpois=
on
>>>> for a page.  It looks like this (for now, in my head):
>>>>
>>>> struct hwpoison {
>>>>         memdesc_t original;
>>>>         ... other things ...
>>>> };
>>>>
>>>> So we can replace the memdesc in a page with a hwpoison memdesc when w=
e
>>>> encounter the error.  We still need a folio flag to indicate that "thi=
s
>>>> folio contains a page with hwpoison".  I haven't put much thought yet
>>>> into interaction with HUGETLB_PAGE_OPTIMIZE_VMEMMAP; maybe "other thin=
gs"
>>>> includes an index of where the actually poisoned page is in the folio,
>>>> so it doesn't matter if the pages alias with each other as we can reco=
ver
>>>> the information when it becomes useful to do so.
>>>>
>>>>> But... for now I think hiding this complexity inside the page allocat=
or
>>>>> is good enough. For now this would just mean splitting a frozen page
>>>
>>> I want to add one more thing. For HugeTLB, kernel clears the HWPoison
>>> flag on the folio and move it to every raw pages in raw_hwp_page list
>>> (see folio_clear_hugetlb_hwpoison). So page allocator has no hint that
>>> some pages passed into free_frozen_pages has HWPoison. It has to
>>> traverse 2^order pages to tell, if I am not mistaken, which goes
>>> against the past effort to reduce sanity checks. I believe this is one
>>> reason I choosed to handle the problem in hugetlb / memory-failure.
>>
>> I think we can skip calling folio_clear_hugetlb_hwpoison() and teach the
>
> Nit: also skip folio_free_raw_hwp so the hugetlb-specific llist
> containing the raw pages and owned by memory-failure is preserved? And
> expect the page allocator to use it for whatever purpose then free the
> llist? Doesn't seem to follow the correct ownership rule.
>
>> buddy allocator to handle this. free_pages_prepare() already handles
>> (PageHWPoison(page) && !order) case, we just need to extend that to
>> support hugetlb folios as well.
>>
>>> For the new interface Harry requested, is it the caller's
>>> responsibility to ensure that the folio contains HWPoison pages (to be
>>> even better, maybe point out the exact ones?), so that page allocator
>>> at least doesn't waste cycles to search non-exist HWPoison in the set
>>> of pages?
>>
>> With implicit handling it would be the page allocator's responsibility
>> to check and handle hwpoison hugetlb folios.
>
> Does this mean we must bake hugetlb-specific logic in the page
> allocator's freeing path? AFAICT today the contract in
> free_frozen_page doesn't contain much hugetlb info.
>
> I saw there is already some hugetlb-specific logic in page_alloc.c,
> but perhaps not valid for adding more.
>
>>
>>> Or caller and page allocator need to agree on some contract? Say
>>> caller has to set has_hwpoisoned flag in non-zero order folio to free.
>>> This allows the old interface free_frozen_pages an easy way using the
>>> has_hwpoison flag from the second page. I know has_hwpoison is "#if
>>> defined" on THP and using it for hugetlb probably is not very clean,
>>> but are there other concerns?
>>
>> As you mentioned has_hwpoisoned is used for THPs and for a hugetlb
>> folio. But for a hugetlb folio folio_test_hwpoison() returns true
>> if it has at least one hwpoison pages (assuming that we don't clear it
>> before freeing).
>>
>> So in free_pages_prepare():
>>
>> if (folio_test_hugetlb(folio) && folio_test_hwpoison(folio)) {
>>   /*
>>    * Handle hwpoison hugetlb folios; transfer the error information
>>    * to individual pages, clear hwpoison flag of the folio,
>>    * perform non-uniform split on the frozen folio.
>>    */
>> } else if (PageHWPoison(page) && !order) {
>>   /* We already handle this in the allocator. */
>> }
>>
>> This would be sufficient?
>
> Wouldn't this confuse the page allocator into thinking the healthy
> head page is HWPoison (when it actually isn't)? I thought that was one
> of the reasons has_hwpoison exists.

Is there a reason why hugetlb does not use has_hwpoison flag?

BTW, __split_unmapped_folio() currently sets has_hwpoison to the after-spli=
t
folios by scanning every single page in the to-be-split folio.
The related code is in __split_folio_to_order(). But the code is not
efficient for non-uniform split, since it calls __split_folio_to_order()
multiple time, meaning when non-uniform split order-N to order-0,
2^(N-1) pages are scanned once, 2^(N-2) pages are scanned twice,
2^(N-3) pages are scanned 3 times, ..., 4 pages are scanned N-4 times.
It can be optimized with some additional code in __split_folio_to_order().

Something like the patch below, it assumes PageHWPoison(split_at) =3D=3D tr=
ue:

From 219466f5d5edc4e8bf0e5402c5deffb584c6a2a0 Mon Sep 17 00:00:00 2001
From: Zi Yan <ziy@nvidia.com>
Date: Tue, 18 Nov 2025 14:55:36 -0500
Subject: [PATCH] mm/huge_memory: optimize hwpoison page scan

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d716c6965e27..54a933a20f1b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3233,8 +3233,11 @@ bool can_split_folio(struct folio *folio, int caller=
_pins, int *pextra_pins)
 					caller_pins;
 }

-static bool page_range_has_hwpoisoned(struct page *page, long nr_pages)
+static bool page_range_has_hwpoisoned(struct page *page, long nr_pages, st=
ruct page *donot_scan)
 {
+	if (donot_scan && donot_scan >=3D page && donot_scan < page + nr_pages)
+		return false;
+
 	for (; nr_pages; page++, nr_pages--)
 		if (PageHWPoison(page))
 			return true;
@@ -3246,7 +3249,7 @@ static bool page_range_has_hwpoisoned(struct page *pa=
ge, long nr_pages)
  * all the resulting folios.
  */
 static void __split_folio_to_order(struct folio *folio, int old_order,
-		int new_order)
+		int new_order, struct page *donot_scan)
 {
 	/* Scan poisoned pages when split a poisoned folio to large folios */
 	const bool handle_hwpoison =3D folio_test_has_hwpoisoned(folio) && new_or=
der;
@@ -3258,7 +3261,7 @@ static void __split_folio_to_order(struct folio *foli=
o, int old_order,

 	/* Check first new_nr_pages since the loop below skips them */
 	if (handle_hwpoison &&
-	    page_range_has_hwpoisoned(folio_page(folio, 0), new_nr_pages))
+	    page_range_has_hwpoisoned(folio_page(folio, 0), new_nr_pages, donot_s=
can))
 		folio_set_has_hwpoisoned(folio);
 	/*
 	 * Skip the first new_nr_pages, since the new folio from them have all
@@ -3308,7 +3311,7 @@ static void __split_folio_to_order(struct folio *foli=
o, int old_order,
 				 LRU_GEN_MASK | LRU_REFS_MASK));

 		if (handle_hwpoison &&
-		    page_range_has_hwpoisoned(new_head, new_nr_pages))
+		    page_range_has_hwpoisoned(new_head, new_nr_pages, donot_scan))
 			folio_set_has_hwpoisoned(new_folio);

 		new_folio->mapping =3D folio->mapping;
@@ -3438,7 +3441,7 @@ static int __split_unmapped_folio(struct folio *folio=
, int new_order,
 		folio_split_memcg_refs(folio, old_order, split_order);
 		split_page_owner(&folio->page, old_order, split_order);
 		pgalloc_tag_split(folio, old_order, split_order);
-		__split_folio_to_order(folio, old_order, split_order);
+		__split_folio_to_order(folio, old_order, split_order, uniform_split ? NU=
LL : split_at);

 		if (is_anon) {
 			mod_mthp_stat(old_order, MTHP_STAT_NR_ANON, -1);
--=20
2.51.0


>
>>
>> Or do we want to handle THPs as well, in case of split failure in
>> memory_failure()? if so we need to handle folio_test_has_hwpoisoned()
>> case as well...
>
> Yeah, I think this is another good use case for our request to page alloc=
ator.
>
>>
>>>>> inside the page allocator (probably non-uniform?). We can later re-im=
plement
>>>>> this to provide better support for memdescs.
>>>>
>>>> Yes, I like this approach.  But then I'm not the page allocator
>>>> maintainer ;-)
>>>
>>> If page allocator maintainers can weigh in here, that will be very help=
ful!
>>
>> Yeah, I'm not a maintainer either ;) it'll be great to get opinions
>> from page allocator folks!

I think this is a good approach as long as it does not add too much overhea=
d
on the page freeing path. Otherwise dispatch the job to a workqueue?

Best Regards,
Yan, Zi

