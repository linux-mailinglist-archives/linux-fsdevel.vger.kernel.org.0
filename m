Return-Path: <linux-fsdevel+bounces-60369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B189B46141
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 19:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4003A7C73B8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 17:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F2236CDF5;
	Fri,  5 Sep 2025 17:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XMZVH6gN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD5A3191D6;
	Fri,  5 Sep 2025 17:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757094962; cv=fail; b=dXejcHECZpExHJ2/JNkb1NCTmn332/x6X6WCvRFC7MzKuy+QsZXcucG3khBIaZIiQeP/5CWcso+2eXVzfer0cWuDZvCIUaFpV/XSMFV73mGQkzQylWYYv2V5AdoPpfRF4YrPZX3zbzXI2gNGixhcAYgDVuexvdZgVu4s4GLW5F0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757094962; c=relaxed/simple;
	bh=7IjSQ9byWclcH5bIlEjwBI7g+YjiKJug0t+rY1UrYE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M8Q4HpuYZYw9aSnmIXTqMnQBZaUcrBJ90TzipT3FI6WhnvBAEg+J2LYpyY/udUGAqmnYgpizo68xsgFZkjw5zN4qhYO8Tqa85j4uXyT5W8MIsbdk+mRzmbIEY+jnRPhoKkCWfaPBRuhvLKGwWxC9eG3NucK5Orzt1kywc7MS8Sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XMZVH6gN; arc=fail smtp.client-ip=40.107.93.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vg+GTX3dgqSIB/8JieDxvlbeQCgL8b3sJFKlCSQ79sMEwu7ixidku6nc/MhFT/byYQyYT612dX+kWrg8qpKd3s6mq/vjrDuNAICkwBLSivT4YucfiVUGTzBF47TUnQ8KYxgLwui9pHBXbyISI69b47/EAiyK6Sc0MlcwNfn1ek3o5mJc0CaYCDkr67Z9VBvUZYKkL0Vi8Crrcxu/Jpb7vDBrqz14GLDZc/R2qkWh7czhNF6YEFq4PQCok0y2kGSe2TfmtvhlItaP+0BLZm54Z1O5dSftR9LLlqmVmSSvlOmYG5neuDSnTWZl+OvG3MNIgev5+Kdg5EkbbN29lrYy9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0sAT1MkQhxmaWoh5XM3aNqdHqkTWbLM+p3hq6AJi0Tc=;
 b=gdekvFS10RxH3QTxT59c/JWQC25VLtw1NoYEHDT8TDeeGWuf74D7eNRIH+RPOIu9x0LF2/2BeJc3uVQnyzDuwei5NUZ8EX5VHMg4uuwdD8QxdxQ/a2MCblSfajriTiIqDr1NUBNcFJgxpBZdK87co6mkTI7zjFwWnyiTDEp6CUIEKUuGIkDSzv4tqAkBlkXZZ+4eNNVnIoo1ln+wXxDKZPjWKFKebAb76D7cy78hrLk6jTjVaGGBjoNZA2rNfbFwwgsqASLvJOwi5yepE6noVVI2J7n2xn46wJ8/gvztiRcKmd2uVbn6F0b5ayXSMM/VJ812jRE8yfe7iL4xqclZXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sAT1MkQhxmaWoh5XM3aNqdHqkTWbLM+p3hq6AJi0Tc=;
 b=XMZVH6gNQdBsJgD6KlnrOdP7KgyNH75pj8wF6pJIGOOEfpdOTkPT7w8N4GCXGrCGYDosHh91zS59WIWckQCdhrdJxBfCMNAyqB2WPtHNXWmMbnPhMtk/SDTU1FpzusveJGFgClcMMjUbrsj3X2DMwo2y8oVJ+uu95Vpnif6oFG/N9Xom++pJ6skGdZ+gACDnTHUjoi8eawHi5qsbBraKd1GS6B+l9FtQAv7vFEbQ/v0L15bTk4OtWL47KCS+J3tKanqDowoBPxshQQ2p6GCnabsoU9yGTOcrxOk/bE8u57i+2FIdklpsW9LV1MfDS1QeX9P3JLopvGHhR8E8z5QRDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH7PR12MB9067.namprd12.prod.outlook.com (2603:10b6:510:1f5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.18; Fri, 5 Sep 2025 17:55:56 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9094.016; Fri, 5 Sep 2025
 17:55:56 +0000
From: Zi Yan <ziy@nvidia.com>
To: Mark Brown <broonie@kernel.org>
Cc: Usama Arif <usamaarif642@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, corbet@lwn.net,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org,
 baohua@kernel.org, shakeel.butt@linux.dev, riel@surriel.com,
 laoar.shao@gmail.com, dev.jain@arm.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, vbabka@suse.cz, jannh@google.com,
 Arnd Bergmann <arnd@arndb.de>, sj@kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com, Aishwarya.TCV@arm.com
Subject: Re: [PATCH v5 6/7] selftests: prctl: introduce tests for disabling
 THPs completely
Date: Fri, 05 Sep 2025 13:55:53 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <5F7011AF-8CC2-45E0-A226-273261856FF0@nvidia.com>
In-Reply-To: <c8249725-e91d-4c51-b9bb-40305e61e20d@sirena.org.uk>
References: <20250815135549.130506-1-usamaarif642@gmail.com>
 <20250815135549.130506-7-usamaarif642@gmail.com>
 <c8249725-e91d-4c51-b9bb-40305e61e20d@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN9PR03CA0568.namprd03.prod.outlook.com
 (2603:10b6:408:138::33) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH7PR12MB9067:EE_
X-MS-Office365-Filtering-Correlation-Id: a2d9efb9-96ec-450b-9914-08ddeca576e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWV1V1Z3VVlGVW9yOVdOVEdPd2NSaWFyMCtIODI0WFlwcm5Lc3BaUmVNdGM2?=
 =?utf-8?B?RTA5VjN0cTdTK1p3TlVKVmVXaWRld1A5cnE0aDV2N011ZW1wMStWdDhCeW5M?=
 =?utf-8?B?MlhnZEtnWk1VRlpXdzcyeitvQkRFQlNUcGlxOHRJb1VFbU1hdVdWUTAwRTBn?=
 =?utf-8?B?ckpYWjN4cDU2b2VocGJhZ1BFcVhTWFBWZWY3VDNCdWlGaTRvSERlZ0dreGZy?=
 =?utf-8?B?OHBqQVl5dUhNTWcrK2h1M3VyMGJTeno1RFdvVVNjVTljQzRaeFJ6OU1RaDdt?=
 =?utf-8?B?SitSdWkzVDJYWHJVaWJmTGhQSHM3MURzNU45dEdJZFlkUXg5UzcvK0JUZXNB?=
 =?utf-8?B?L0x6NlU3dGFPSHpHQWxrcjBxbFQrT2pNa0JTMy9yTk1UdWljT1NMOTJMdmt5?=
 =?utf-8?B?b2xubk9veE93SmF6Zmc2YXVMWUNTQXpQTGN5Vm5paXl2RjJVaGJxUWVvQWt6?=
 =?utf-8?B?N2lSaG9wOXk0cWVVWTNkVkNsVkFLNXJ1VHM4dGlQaHkvOGU2TkhFYTdZWnI5?=
 =?utf-8?B?a3BWcng1VDdCS1JQaXV3NHZ4OXJDM3hGMlpQT1dyTDVQZGRaeUZmVVkzNXFn?=
 =?utf-8?B?ZzdxOXNXYSsxaXM2YUtsRitZYlpMMTliMEszWFF6TDlMcUtqc1RMQ3dxd0VH?=
 =?utf-8?B?WjVlWUZzOHdkQTA0eFRPNmhIS2dkd2VDM29oSnpBMkcxblNkaHFIM3dKaXcr?=
 =?utf-8?B?S00xT0FKMytmK0dkeWVKcXJ1N3VLZjE2Z3hFYnVJYXBnWWh5Y0FPeFpINXB0?=
 =?utf-8?B?NE1PMkx3cktqdnZJdE1jV0thdFlSbW9rMnNuTnBYN0ZqRVRCSm1lS0ZxcitC?=
 =?utf-8?B?blBjeHgwR3FRYXhPZXFZRXlyZi9FN2VvdDYxYUUwZWRKMzRVeE1pVVVtMUds?=
 =?utf-8?B?OVc5T2hTQUtSa2kzRno5VmdGTXlybk1KNjBoeWUrOUY3YWprQ0NnMkZqRUNp?=
 =?utf-8?B?MWE4RTVURkluU3gxVzk0UW83U0ZCeTZJY2lkUUVjNXpSaFVnNmpiNmUxOE9t?=
 =?utf-8?B?ZUdJN1Y1d3JaK1N0TlAvbFlkYTVFVGlrYWhYaXFhTmFBQjVtaEkwSHhEWFJz?=
 =?utf-8?B?OFpOdGp1ajNYaGk2QXFTcU8yTnBrQXZBUWxTQzZYcWVQV2NTcWNlQ3NnSW1r?=
 =?utf-8?B?Z2VuSDFhSlVvSktCbE9zZkJYbFJ2dmdZRktBd0drdW01MWtWbmVyU2VzVVFB?=
 =?utf-8?B?c1ZGbHRBWWpOUUVEdUFLQnhES0ZUOGVxL0JZeHlvbWJwNE81aEFJZFZGU2hQ?=
 =?utf-8?B?eVhwdkFVdG5vUDdEZkJhZmdqbVlSU3craTkrMjIrZ1J0VDE0MzNPK2xwbHdj?=
 =?utf-8?B?U1BaNTErbkpXSGRuMmVtSFpPeU1NT0E4L0ZSbE1NSHR4ZmhFRGFGdCtvMldS?=
 =?utf-8?B?NnlveTlZelVuQ3UrTUFtWm5OZWcrTnAyRURVcTVPZnI5WUxsRktGb3F6WHF5?=
 =?utf-8?B?N2NRS2RFb2poV1pZUUFBSENBZGxNNXkxa0pzY05xNnFsdFJiTUc2VnloamZ4?=
 =?utf-8?B?MUdoMTRpZUxORzBtYXczL3ZubFRvQXBBSkduTGRPVzMvU3ZPT0NrNC9iQWph?=
 =?utf-8?B?QkpSRVVySEV6Tm90bkhPNnhFVXdGaXhVYUgxeWdKWmNReWZGNHc4ZmpFbTJo?=
 =?utf-8?B?S1A4bzE1SUl6SGMzbGRWcDc5Zit2VWdVYnV5K2JpeEpRMnZaa0lCTmRzNVlm?=
 =?utf-8?B?SndjOEZnc2N4MmJ2VUFyTVZYZVVjSVRkOHdyYy96b3hSTkR5bmNCYktXdnMz?=
 =?utf-8?B?eFdmY2VxZ0JNUEFqQTd5YUs5TVJwUWJmd1A2VlFkai9KTXVkVVR2U21IU1RF?=
 =?utf-8?B?YzlyT1d4cnJFb1B3bHRzUnEzS1hFVFA1M2NnT0dXT1ZZR0NaOEJMZ2I0SE9Y?=
 =?utf-8?B?cHFscnplaFV1cGpsOEdjYzBZQXc0azZIUmtnOTlaNXI1cVhPS1h3b0R2bjVz?=
 =?utf-8?Q?j7Wz5p+bgzw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnRsd0dYeFdDd3Q5eXFzQS81WU1XMmZBc3huK01ZSVVvTGNSMzk4eG9DaFky?=
 =?utf-8?B?Q3ZHeFh4SXJ1UG1CZEUxakJjYUQ0RmRCUXd0UzFOSG9KQUxIQ3ZwL2FvWmR2?=
 =?utf-8?B?UlptK3NKYTdvV1Y4REpCRXdMY1NFQ0lobFRBVEovRWxBWWFmVEJXOXN0emZL?=
 =?utf-8?B?U3RrZ3BMaEY1eGNLOVpobkQwaTV4dE9BL2E0YmJsMHZaYjFtcmk3M1RrMTZz?=
 =?utf-8?B?Yi9sT0JIVi90cE1mWW14WVpUSnZ5NWFZbm5zZGt2S08yd1RPVWlJWXpTM0Mr?=
 =?utf-8?B?eXBGSEptL2phOGI2NGwwb3N1WVdPZVJDdVZmRVZ0bmZ4QUNmK1JDZ3U2N2t6?=
 =?utf-8?B?TCtkREpWdDBOY0k3T0o5WXR1c0djdEpEMHNhZUpMRW0vd2hWNHN1RGVzbmIy?=
 =?utf-8?B?bSt6L0tCVWNLbFFsWTdNbndWVitlemMzdVJSdWhES1Z5N3hHZWxySVBENHBW?=
 =?utf-8?B?YloxZyt5Tmd5ZEJkVTFaY2JVUG9ZeWdRc0hHTjhYVlpRaGhOdW0vK0Z4NSt5?=
 =?utf-8?B?dDhaZ2hYakNPeklzdU5aZ0JSVzVUb3BZN2JaL2VxMTB6RXo5UjNyVGNaZHFk?=
 =?utf-8?B?MzBQZU9oQVRsc29DbGNaQ0h4czJDQXV2M3RnL3ZxdDA1Q1gvNlAySEhXMHVv?=
 =?utf-8?B?d2VITmtuY2Y5Mk03RjNGK3VYS25LY29OT1MxN2RVUk9YNnVJdDN0bWFrZm90?=
 =?utf-8?B?cE9XQzcreVFBeGZUcWx6RmVXQ0VLbzkrQjV2RXp6ditqN2dvdi9BQWVXVVdX?=
 =?utf-8?B?QjB0RHJRNUFhWlhIMzM5cmlSNHR3dzVsczZlbDIwUWtrOTd3eDl3dDdMS2NP?=
 =?utf-8?B?SmZjN2RnM0plUi9tc1I1cjk1Z2I2d1dPaUl4QjFGL1Q5SnJQWXUwanlEZXpi?=
 =?utf-8?B?MGprTjN5SXd6bjdXWnptM1FQM2xWMnFsbW1BZElUQzMxMHBzVTByNlA0alNy?=
 =?utf-8?B?Q04yUklnd2RzNWZLMm0wVEh0cTZNeERFaXZMVWVVWklRK3B2dlI4RStRdHor?=
 =?utf-8?B?aHBlNEVhc1pNU0NvbE5iSGR4NXFZVm9iUnRvRTEwaHU3SklaSEJGT1lzUXNP?=
 =?utf-8?B?aW1udDl0Yk9rNXlQM0dEQXBRRjBlVVlUOTBCN0hNd3FFN2E1RUZ3VkwxcnYv?=
 =?utf-8?B?V3Juekw4WTJIRkxsdE9sOElEMXZGNXJpRWRSUEdKZ2ZhYWp1TEFRb1I4U2k1?=
 =?utf-8?B?T3lsKzhPcExqU0ZzTmxDNlRPenlxN0JSck16VjFnZUtZdXJNeEZBUjBuQWNs?=
 =?utf-8?B?QmFVb2xNaUtFMllxcXAzUFdUdnJnVGhoUlpsRE9nSWg5dHhTc3hzOGZWcmRV?=
 =?utf-8?B?cXZmRGNpeUEyK3ZaQmMwYlhWTWNQV09zTUJOaDlWaW84U2w3azJBQTVhZXNr?=
 =?utf-8?B?K2Uvd2dOaVhmb29UL3dOUEtvZHBrVXFWZktvVXNWUUU1R1FDRk4rSEZQR1Nn?=
 =?utf-8?B?b2REa2RXMWlnWjJPNWVjQnpRMDBkbG85TGxBb1JUWDZJendWL3pmaVdtMEtK?=
 =?utf-8?B?Q1JGd3JLRG5EV3R0RFRJdnE0Z25hMCtIWFdOYmtaWDdlUEFNa3J0SGlKa2FI?=
 =?utf-8?B?UVZPb0dhOGpmbUVtN3V3di90RW40eEI2QlViQWpkVEh1dit5ejRHR2hZa2tx?=
 =?utf-8?B?cjlQYWZqZXZiWGIyTno5OUJtYnZvN2pzYzJUQ2ZUdzRuSGh5bmpsS21PVDZI?=
 =?utf-8?B?Zk9wY2ZMcFhzaElvMzNhY2ZqdHhBNWhCUm8rNTUzYXM2TlIzbWxWWXlsbFpT?=
 =?utf-8?B?NVN0ZnQzVjJnN25xZjFVN2piVXJZT3RYS3dNQnJyaUorT01rMmVlMTE5cVho?=
 =?utf-8?B?RWw1TWUwYmpnNGlySEc4TlFYaFBtNWtCZDc1d0cxUFA2WC81dEk2SENCcHZh?=
 =?utf-8?B?VTB1cld2N1J4aWlDVWNVbEtGNTUrd3dJRVRlZ1AyQVJFbnpJWlJkU1VZZi9J?=
 =?utf-8?B?TU5OV2E1OHd3T29JS3ZyazhmR0Z3TlZtbjFPeDdZazNKOWxVelBIa0dZRWxC?=
 =?utf-8?B?U0I1N0g0R1V3cTcwTlp4cEJxZW5TZ2ZuNEFVUnNHcTdVdUNTc01NUVdjc2dN?=
 =?utf-8?B?Q3p0OCtzZzA0L0oybDZtM09TbkhXYnI5ODlTYlQxLzJLbm5XZlZEbDRSTXZt?=
 =?utf-8?Q?jduq45Retm2M8SZsGoSh9ZrCQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d9efb9-96ec-450b-9914-08ddeca576e9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 17:55:56.6667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /5ruhRABC+nd6KzphcVO7/Gp3Uik9MsaBdLvxitfzcKb/9KkT481PyuV2W55KO8a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9067

On 5 Sep 2025, at 13:43, Mark Brown wrote:

> On Fri, Aug 15, 2025 at 02:54:58PM +0100, Usama Arif wrote:
>> The test will set the global system THP setting to never, madvise
>> or always depending on the fixture variant and the 2M setting to
>> inherit before it starts (and reset to original at teardown).
>> The fixture setup will also test if PR_SET_THP_DISABLE prctl call can
>> be made to disable all THPs and skip if it fails.
>
> I don't think this is an issue in this patch but with it we're seeing
> build failures in -next on arm64 with:
>
>   make KBUILD_BUILD_USER=3DKernelCI FORMAT=3D.xz ARCH=3Darm64 HOSTCC=3Dgc=
c CROSS_COMPILE=3Daarch64-linux-gnu- CROSS_COMPILE_COMPAT=3Darm-linux-gnuea=
bihf- CC=3D"ccache aarch64-linux-gnu-gcc" O=3D/tmp/kci/linux/build -C/tmp/k=
ci/linux -j98 kselftest-gen_tar
>
>   ...
>
>     CC       prctl_thp_disable
>   prctl_thp_disable.c: In function =E2=80=98test_mmap_thp=E2=80=99:
>   prctl_thp_disable.c:64:39: error: =E2=80=98MADV_COLLAPSE=E2=80=99 undec=
lared (first use in this function); did you mean =E2=80=98MADV_COLD=E2=80=
=99?
>      64 |                 madvise(mem, pmdsize, MADV_COLLAPSE);
>         |                                       ^~~~~~~~~~~~~
>         |                                       MADV_COLD
>
> since the headers_install copy of asm-generic/mman-common.h doesn't
> appear to being picked up with the above build invocation (most others
> are fine).  I'm not clear why, it looks like an appropriate -isystem
> ends up getting passed to the compiler:
>
>   aarch64-linux-gnu-gcc -Wall -O2 -I /linux/tools/testing/selftests/../..=
/..  -isystem /tmp/kci/linux/build/usr/include -isystem /linux/tools/testin=
g/selftests/../../../tools/include/uapi -U_FORTIFY_SOURCE -D_GNU_SOURCE=3D =
    prctl_thp_disable.c vm_util.c thp_settings.c -lrt -lpthread -lm -o /tmp=
/kci/linux/build/kselftest/mm/prctl_thp_disable
>
> but the header there is getting ignored AFAICT.  Probably the problem is
> fairly obvious and I'm just being slow - I'm not quite 100% at the
> minute.

prctl_thp_disable.c uses =E2=80=9C#include <sys/mman.h>=E2=80=9D but asm-ge=
neric/mman-common.h
is included in asm/mman.h. And sys/mman.h gets MADV_COLLAPSE from
bits/mman-linux.h. Maybe that is why?

>
> Thanks to Aishwarya for confirming which patch triggered the issue.


Best Regards,
Yan, Zi

