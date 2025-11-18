Return-Path: <linux-fsdevel+bounces-68900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFCCC67D03
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 08:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 97A9C294F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 07:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3607F2F9D82;
	Tue, 18 Nov 2025 07:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g+hrBE2/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010021.outbound.protection.outlook.com [52.101.61.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C735A275864;
	Tue, 18 Nov 2025 07:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763449336; cv=fail; b=sL67k6N6VQLDZWdGoFyaZp46B6xIoz1xmBIRhBpeVz83RI1SZUUQjrsGt5YGrPnautpWHo6/l0hgtVPQnvc10PaNzj295gpp+ZTMiC9CNorJEDayfOl2nt5N8giZuk6/N3bvrRao35RqS3vW0Dyw3rLQhNw/YkP99fagg+NFKGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763449336; c=relaxed/simple;
	bh=cB9iWRlhf2Dw0xu7A+ZArUOvMrWLYdETUPZfV3mP3Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nZ0bfP0IdhAmxwaDBW2gPBjaXJuRerOSA7N9NWK/A3YTEgiJabdabNlwO8qObnNBwS7xYT0jIpFWmD3VPylGo21B3kDUdGdqEnHoGtzfzbuYxzu6SMQWJ6yUPpnZ0wc0d7tQn1nCP2TeujOPy1cW4svHVJkym/210nnlm0r1b+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g+hrBE2/; arc=fail smtp.client-ip=52.101.61.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ukIZsfEn+a2Ld0cfCsOGISHSb+k8x3mAPHivoQZXrzzaTEu8YOCUb2dVIrQz8JdKStG4AwV7R1NuSRLTdxrDJADsCm7EE61GQKxBo4uIda50kzCc8fe5vGxbu7ac0cHx2nDPpUnE8UtDlwmfparUcgFHCpjjRU67IiR/b2ayJI6Rp4yYgMNuX1B9mDdA0Sqpeg3rrGawW+k6Mt+YMpyabCMeozt+ZfYveJURBcipHa2orWFznBi4dgbDSn6mXhLGBzsdoBdxGCy6BZthVub10njnoxaFubrM/XdGKN9RRg6sLtY5jne+rLgUnQYEyEyCFvw1XKoY9+cD8ob7F5sNHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGWR6rfBeKNpqJT5UASilZ/Kxk9tDnl0IlBbpjCPM24=;
 b=sg6L6XjGKJTQugHIrBMYtu3tU+WTMjDu2d/qY/Iw0HBRBPjhxWtM8B+Bz5QfcnduVqQmOYTYstV7wjAmcWSF2Q0sB+np2H3R+3uQjIvp9EXtalqOipItPpwoPeinlRURsblRWQugLtfh74BThP/saMAxNzm5cRfLBkISCdrTP5wJy3mrpfjcUfyzmDhStTQfkJgwaxHxhcbhXRtbhMveNWJ9hecClV0SXmR7WnEogcjtqjuMvVKyBPg43hy85gim6G55zBo+WsfH+kztgdqjyB6qD48lMF5t01Ix5FhJaWVBX51hUDmQgYO81mjc6ca1eEtOn2NarF9fp+HuI4NDAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGWR6rfBeKNpqJT5UASilZ/Kxk9tDnl0IlBbpjCPM24=;
 b=g+hrBE2/bZ+2tfPBa7hFh2d5uW1fSfypLxxmBSx1EM44n192lxBrlP/8nSiH6Hmfu9WOhsKUzBGRGJxJYWLzMrg01axQFmdRVw1Nu/HotXfVXvs+cpTgl2O9BBn7hWO0zagV1Pjx3wL/TOytLUiyDdT8wfyuiyGPQ73XhybH6jth97YG2+274PPg2vQ8GorOxbjAkGE3bA6yuAtPHxF8h/rxva6WnjyfxKl0NWRLVzvOq/C/bf61/BsTFVnkCNo0G1lHC77jdmgVhOy2a9+mdkWMXK86xCxH502BBaUoNjon8/FRda3Gd18qcq+EDaU3IkecWyHMR0FXCoKc1r1WVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CY8PR12MB8267.namprd12.prod.outlook.com (2603:10b6:930:7c::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.22; Tue, 18 Nov 2025 07:02:07 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.9320.018; Tue, 18 Nov 2025
 07:02:07 +0000
Date: Tue, 18 Nov 2025 18:02:02 +1100
From: Alistair Popple <apopple@nvidia.com>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, kernel-team@meta.com, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	cgroups@vger.kernel.org, dave@stgolabs.net, jonathan.cameron@huawei.com, 
	dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com, 
	ira.weiny@intel.com, dan.j.williams@intel.com, longman@redhat.com, 
	akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, osalvador@suse.de, ziy@nvidia.com, matthew.brost@intel.com, 
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, tj@kernel.org, 
	hannes@cmpxchg.org, mkoutny@suse.com, kees@kernel.org, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, rientjes@google.com, jackmanb@google.com, 
	cl@gentwo.org, harry.yoo@oracle.com, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, zhengqi.arch@bytedance.com, 
	yosry.ahmed@linux.dev, nphamcs@gmail.com, chengming.zhou@linux.dev, 
	fabio.m.de.francesco@linux.intel.com, rrichter@amd.com, ming.li@zohomail.com, usamaarif642@gmail.com, 
	brauner@kernel.org, oleg@redhat.com, namcao@linutronix.de, escape@linux.alibaba.com, 
	dongjoo.seo1@samsung.com
Subject: Re: [RFC LPC2026 PATCH v2 00/11] Specific Purpose Memory NUMA Nodes
Message-ID: <aktv2ivkrvtrox6nvcpxsnq6sagxnmj4yymelgkst6pazzpogo@aexnxfcklg75>
References: <20251112192936.2574429-1-gourry@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251112192936.2574429-1-gourry@gourry.net>
X-ClientProxiedBy: SYCP282CA0010.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:80::22) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CY8PR12MB8267:EE_
X-MS-Office365-Filtering-Correlation-Id: ceaa6cb2-7f8c-491d-d339-08de267062d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MHBqay8rY21UU2lHaWJvbG01UUdzOXhqL2RwK0RYV0Jrdm44TTVGVm8rRkFE?=
 =?utf-8?B?bTM4Y0VJQUZqWENaWFdKSk13RDk1N3ZSN25ybjV2eGl4SW1TTVNVNm1DYzVS?=
 =?utf-8?B?WUg2YWsxZStJdCtOQWNGV3FCUVN1bVcxa1dCQ3Bha0JicVNWcGlBc1F1emdv?=
 =?utf-8?B?V0poSmJudDVRTDYvQWU4ZkZjd1U2RU8xSHA1YlhrcGtaUE9aajQ2THd5WVcx?=
 =?utf-8?B?TVVWaHUwcVBJVEtFR3UrMVkvcDNDSkFhME5ocnNWem0veDlDeERGcHJDTG0y?=
 =?utf-8?B?VlBqOWdUTmF3QXBkd1VOeXFyaW9OQkhUSCtqRE1OOCtxOHBGckl0TWhSQThy?=
 =?utf-8?B?N1RYb1F3eTFSS3ZqQitZc3lNM3BkaysramZ0cTZqNGZsb3JOUkI3RUN3cTJr?=
 =?utf-8?B?R0tmVFhxQXh3LzNPaGJZc01xN3RiQUw3NUtrM1hKcGUvMjV0L0VJV1NmTEpP?=
 =?utf-8?B?Z0ZuMm1lUHhTWUs1amtVVWJ2SGpuSG0xZ2o0aUdKYXhYaHExMWpMQlRlNXIv?=
 =?utf-8?B?a2tjWFlOMUlDUFd4QnZ5cklFSkJlM3hDVUI3RUtZSTBYK0R6Q1MrNUhPWS9T?=
 =?utf-8?B?ai9UdmJxMmU2Ukk1L1JNMUZ1bVVhQVMvSFNFaDZGR3R2ZGM0TzVqMVEvTGY4?=
 =?utf-8?B?cStqZlF4dFZpZUFKazlHRXBzL0FUY3lqblR5UDNuK2tOalQ3RVdUbDlxM1BZ?=
 =?utf-8?B?dEo2YkwzSFdMV0FCZTdyR2M4c3ZLaDQ1WGFhRnJCR1k5WjJZQ1kzT0NPV1Iy?=
 =?utf-8?B?UEdWZFlMN3BDelN5dGFHQzBLM1kzcStEQ1JvS2tlWWd0QjB4Y1RDejk1RXVx?=
 =?utf-8?B?UmlBMjRtZ0pkTlN0UkJIRmJRL29lZWxNSnEwUVNhdVpOaXV6R2FSakk1Wjc2?=
 =?utf-8?B?cjFoR040Q3FuTTFXdFpUN2pPZ1FxcGdKWDRhRGFpQlBYSmZ0OWdrTjVNU2Zj?=
 =?utf-8?B?eE1Zd3dLY0VNQ2FSYmhoNGgyMnBvYnlGOGNUUXlScVhhZFdrSHdaVjNGTG5k?=
 =?utf-8?B?YWVFbm9TQlRpYW9xeXN5ME9aYUUxL2tPRzFFUVM5RXM5OWJsZURLaVkzeFVV?=
 =?utf-8?B?MHhWNDdIUlRxVlJxOEpYTWwzSEJvWEN3bVhuWmRiTGk3OXAwRXZHMGNyQXlE?=
 =?utf-8?B?bVJ5ODNnb1RybjFNSlIzK0t3dnFFUDZQT255VDhaVzQ2bzBXWWh1Ri81MTIr?=
 =?utf-8?B?RG1zYlNjWmhpaHI0THFncjhNWjlqeXN2QTNTUjZmTGhnMTlyZENGaVpBVEkz?=
 =?utf-8?B?a0l4L3dFay9LL2ZPdHRsdzlXTEpCV3dTMjcyR0Q2VE1mMEVPVmJyL29HME9W?=
 =?utf-8?B?ZDJCUVd3NFZES1krbFBtSUhGbG5pMWd6d2MxK2piN1pXZmZvNWpucENpZ1ly?=
 =?utf-8?B?MDBRTEZ5dEkzOTMvSkIvN2RJOUI5c3BNSGs2eXB4RUdWWWpGVXIvaWhiUDJB?=
 =?utf-8?B?Rm9kNUR3L2RXQW10U2NzOTRmbUlXeGkwTUF5clNjSUg2VytUZnZPWFJ6U3Mw?=
 =?utf-8?B?dHRIeGhNbDdNcm1jbjd5cXdsUnArNmVMblM3RE8yUFZlMGp0TVJNZGtKbFdh?=
 =?utf-8?B?WnhEbmN1NXRCM1FRUTVpUnF4M3ZjRGl6Wk8rbE9wS1dVWTVmZk44VEpqbmFF?=
 =?utf-8?B?Q3VPdGsxcFYrbWtoSHRGY0J2eEp4dVlMN3lXNmk5M1BTemMybWJYelVqTHl1?=
 =?utf-8?B?eHBjajdpTEd6MVZYY1BOMWFxMStjbENGZFpLbHFtTmtZZEp3b3ZJSWtOUDgx?=
 =?utf-8?B?dmRMMDRjWUlLTWFObzQ1Z0VCNVJzL01uSUpTdUFkV3I3WTNzMUxjV1dHemw1?=
 =?utf-8?B?VW5ZNEk3SmtlRHE5eEZWQm9YN3kwcGc3bTZBWVFyQ0pOOGZSbjdxWThZQkta?=
 =?utf-8?B?QWxNSm84aTZOL0NiR1J1MS9FTk5CcURvYnZDRWlJNlJ3a1pxUERpR2phMFJH?=
 =?utf-8?Q?Hb1nr1QVl/dWO4LifesOshL559+ZbXHc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkI5RWI3Wk1Za0UvY2MzTjBRNnp1a2hoNXl0LzVpcE51RWZHYnByOXBZV2c3?=
 =?utf-8?B?VzFDTXlSQXN2U2paMUZHUzFCOGRSYi95UjdBbll5TDNEZEoxT3dDY1B1Sjla?=
 =?utf-8?B?VXo2UUx2M0dRNmluODdJQUVSZU9VekEwcEVoTGt3SURWdFoyMkt2dXNjMmx3?=
 =?utf-8?B?ZC9LQlp0bDhMbFBBVzNMSTZKSE1EUmxvRk5DUmllNUlISm1tc25Kd1hhUnR0?=
 =?utf-8?B?Q0FWajNieDJPNlpTdS9oUisrRjFlemxYazh6OEs0R3J6ckhIcFlvaGd3LzhQ?=
 =?utf-8?B?cUUrSk5Ya25GaGFqNWlrVkdoaXBHd25ZOHRyVVhtRFpNS2pyYkFPRnhTc1Bs?=
 =?utf-8?B?d25ISEJiUHpHN0FaRDNDbXYreTZKLytmVmw5TVFNWE1HOEwrYlZLSjQyOWFH?=
 =?utf-8?B?UXIrR2krZHhzQjNoNTRQTHh0SjRQL3RLTDJ0TWRZbmFKSWpKUVd4T05mQ1dy?=
 =?utf-8?B?WHBacFo3aGkvNlZtdVUzNkJuYi9QdE83a1gvUnNBNG5NZnA5RG5wdkxJSVJv?=
 =?utf-8?B?RGRpVmI1UXBXY1FkNVZmaU1UaGVaSStGL3IrVGdTZmlJMW5Qc2FybWZHcnI3?=
 =?utf-8?B?ZDQxdzM3cHNvMGNMb0tHWjk5YVQzdFlKZkFJUnp3T244K0gxNUxCNDZkVWUr?=
 =?utf-8?B?Sk13ZnVjWkt4bGZ4U0hKc3ZhRi82QkdzNWZ6YjVqUCtGMVMvTDVqM2xHVmFz?=
 =?utf-8?B?YkNlcXIySHlyTERSVWZmSllUQ0F6MERnWktPWE5HK2srQTZaenJFb0hnVWlS?=
 =?utf-8?B?Z1llbERaVmNDYVFQQllmeEJPNEtuSHNiZzJ1V0V3L3lzYXBKbzJUL1g4d01P?=
 =?utf-8?B?UGcvV2lPbFE4blhRU3RlVkRZNWx1Wk10bXJ0aWhnTW1XMXYzNzBxWlJWYWZw?=
 =?utf-8?B?R25JRElHUkFYSTdNMHIzdUZIVE4yQUFHODZyNXpRYXJRQTJkNE1LcjZuajhO?=
 =?utf-8?B?WWw5a0lSSCtBU0w0YjdzT25iYldFcGM4VjNtN1c5L0kzOGo2MndNUVN4clla?=
 =?utf-8?B?SUpucDlNQ29rRUpQUTdVdlVjZE5uUlRWOG56eVp5MG0walhmbjcranpqRlRh?=
 =?utf-8?B?eUVOUzRyTlBiSWorZ2c2bGFiWEdjSEFDNFlJTEk3WXpXeG9xUTRKb3plWW5Y?=
 =?utf-8?B?NVllNHIxOFRJODRGR0tmSFJXWlJreWM5SG1WWUt6clNzek85dkJlaWVESlo5?=
 =?utf-8?B?ajVRaEswNHc5RFBOK05mTkV3MmhnRE5XRVJOR3M0OWJRMEFlRVg1eWNubWJJ?=
 =?utf-8?B?dlc0SDNpRnVydi9LTTZkVkhBRE5UM0t4YnhDS2JibE9JTERkZTNLMUxUNmwr?=
 =?utf-8?B?Um1OcWpINDlDV1k3ZE5kbGo3enZsb29TTEYxaFJzS0ZISnhxdEhxUkRLdGdi?=
 =?utf-8?B?aU5GM2lBc2xTeTRudU5VZ1JacktEdHJ2L0RNTkhOdW5mRWs1dGhtczRZN0k0?=
 =?utf-8?B?aGk3MFdsWlZvRlQyWXdLd2krbGE4dXJnQnU4VnVyMGQwTWZNNFkyUUVuangy?=
 =?utf-8?B?SGNSR2IrQmUycGJOa3RPRmhEeWdiYm9zVGMxNG02TjNrYkZzMFM3M0FDbVRp?=
 =?utf-8?B?SHZ6SFdvazlIQklGcE9PZDI0c0gyangzRnc1WVZDVHI2YmVxUXhpYy9wMWZW?=
 =?utf-8?B?K1A1SGpKamh6V0d2a1hiTXlheG53OFpBbThmSUhRelV2Z1dJbnBzeTRjWVFC?=
 =?utf-8?B?VGllN1ZQbFFXZEJLUGlTUDdkSUJQUVduUlp1cTdxRmI5S1l5V1lna2MvdHZp?=
 =?utf-8?B?V3NZWUxwVk9IeThqVWxxZ21CNmE4Sm5IczFZcnJleC9vQ0pGd3pmYUphblow?=
 =?utf-8?B?YTM5WmdHMm4yTmxyVlphVVdCb3VKYTdxNEVDcnpMYmR0Y0dTeWRnY0w3bjho?=
 =?utf-8?B?MGs4RVhoUVRPQnFjYnNRbXlOc0Q5a3hlcHdNamlXMkVMc0lWWU5xTExOQ3pF?=
 =?utf-8?B?T3IrendFSmhZS2lCQnpxMUdueStaMkhlRE5VUXNna1ZNbGJEdTBVRVhhaDJ1?=
 =?utf-8?B?YmNJSlp5N2NWRHJTOWxaRDVkY0FXTEJ5dTZ2UE9SS0ErU1NtZUZwZVVVTWd1?=
 =?utf-8?B?RjRLUzhGREx3cGNEUkdIZHpEUDZpYloyMnM2c29vZlZaL3VXa3F2L0NwLzI5?=
 =?utf-8?Q?SUQf4yxiW887DB4nJO+/Xu1hx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceaa6cb2-7f8c-491d-d339-08de267062d7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 07:02:07.2697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 97Qr0sHgISVNUT0ohdI8npR8LT4ahXnLmsJTkl0WsZ7EyyIpk9rebqv1PsVmBTKNX1XuLuqvtufWl0Jt/DxY/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8267

On 2025-11-13 at 06:29 +1100, Gregory Price <gourry@gourry.net> wrote...
> This is a code RFC for discussion related to
> 
> "Mempolicy is dead, long live memory policy!"
> https://lpc.events/event/19/contributions/2143/
> 
> base-commit: 24172e0d79900908cf5ebf366600616d29c9b417
> (version notes at end)
> 
> At LSF 2026, I plan to discuss:

Excellent! This all sounds quite interesting to me at least so I've added my two
cents here but looking forward to discussing at LPC.

> - Why? (In short: shunting to DAX is a failed pattern for users)
> - Other designs I considered (mempolicy, cpusets, zone_device)

I'm interested in the contrast with zone_device, and in particular why
device_coherent memory doesn't end up being a good fit for this.

> - Why mempolicy.c and cpusets as-is are insufficient
> - SPM types seeking this form of interface (Accelerator, Compression)

I'm sure you can guess my interest is in GPUs which also have memory some people
consider should only be used for specific purposes :-) Currently our coherent
GPUs online this as a normal NUMA noode, for which we have also generally
found mempolicy, cpusets, etc. inadequate as well, so it will be interesting to
hear what short comings you have been running into (I'm less familiar with the
Compression cases you talk about here though).

> - Platform extensions that would be nice to see (SPM-only Bits)
> 
> Open Questions
> - Single SPM nodemask, or multiple based on features?
> - Apply SPM/SysRAM bit on-boot only or at-hotplug?
> - Allocate extra "possible" NUMA nodes for flexbility?

I guess this might make hotplug easier? Particularly in cases where FW hasn't
created the nodes.

> - Should SPM Nodes be zone-restricted? (MOVABLE only?)

For device based memory I think so - otherwise you can never gurantee devices
can be removed or drivers (if required to access the memory) can be unbound as
you can't migrate things off the memory.

> - How to handle things like reclaim and compaction on these nodes.
> 
> 
> With this set, we aim to enable allocation of "special purpose memory"
> with the page allocator (mm/page_alloc.c) without exposing the same
> memory as "System RAM".  Unless a non-userland component, and does so
> with the GFP_SPM_NODE flag, memory on these nodes cannot be allocated.
> 
> This isolation mechanism is a requirement for memory policies which
> depend on certain sets of memory never being used outside special
> interfaces (such as a specific mm/component or driver).
> 
> We present an example of using this mechanism within ZSWAP, as-if
> a "compressed memory node" was present.  How to describe the features
> of memory present on nodes is left up to comment here and at LPC '26.
> 
> Userspace-driven allocations are restricted by the sysram_nodes mask,
> nothing in userspace can explicitly request memory from SPM nodes.
> 
> Instead, the intent is to create new components which understand memory
> features and register those nodes with those components. This abstracts
> the hardware complexity away from userland while also not requiring new
> memory innovations to carry entirely new allocators.
> 
> The ZSwap example demonstrates this with the `mt_spm_nodemask`.  This
> hack treats all spm nodes as-if they are compressed memory nodes, and
> we bypass the software compression logic in zswap in favor of simply
> copying memory directly to the allocated page.  In a real design

So in your example (I get it's a hack) is the main advantage that you can use
all the same memory allocation policies (eg. cgroups) when needing to allocate
the pages? Given this is ZSwap I guess these pages would never be mapped
directly into user-space but would anything in the design prevent that? For
example could a driver say allocate SPM memory and then explicitly migrate an
existing page to it?

> There are 4 major changes in this set:
> 
> 1) Introducing mt_sysram_nodelist in mm/memory-tiers.c which denotes
>    the set of nodes which are eligible for use as normal system ram
> 
>    Some existing users now pass mt_sysram_nodelist into the page
>    allocator instead of NULL, but passing a NULL pointer in will simply
>    have it replaced by mt_sysram_nodelist anyway.  Should a fully NULL
>    pointer still make it to the page allocator, without GFP_SPM_NODE
>    SPM node zones will simply be skipped.
> 
>    mt_sysram_nodelist is always guaranteed to contain the N_MEMORY nodes
>    present during __init, but if empty the use of mt_sysram_nodes()
>    will return a NULL to preserve current behavior.
> 
> 
> 2) The addition of `cpuset.mems.sysram` which restricts allocations to
>    `mt_sysram_nodes` unless GFP_SPM_NODE is used.
> 
>    SPM Nodes are still allowed in cpuset.mems.allowed and effective.
> 
>    This is done to allow separate control over sysram and SPM node sets
>    by cgroups while maintaining the existing hierarchical rules.
> 
>    current cpuset configuration
>    cpuset.mems_allowed
>     |.mems_effective         < (mems_allowed ∩ parent.mems_effective)
>     |->tasks.mems_allowed    < cpuset.mems_effective
> 
>    new cpuset configuration
>    cpuset.mems_allowed
>     |.mems_effective         < (mems_allowed ∩ parent.mems_effective)
>     |.sysram_nodes           < (mems_effective ∩ default_sys_nodemask)
>     |->task.sysram_nodes     < cpuset.sysram_nodes
> 
>    This means mems_allowed still restricts all node usage in any given
>    task context, which is the existing behavior.
> 
> 3) Addition of MHP_SPM_NODE flag to instruct memory_hotplug.c that the
>    capacity being added should mark the node as an SPM Node. 
> 
>    A node is either SysRAM or SPM - never both.  Attempting to add
>    incompatible memory to a node results in hotplug failure.
> 
>    DAX and CXL are made aware of the bit and have `spm_node` bits added
>    to their relevant subsystems.
> 
> 4) Adding GFP_SPM_NODE - which allows page_alloc.c to request memory
>    from the provided node or nodemask.  It changes the behavior of
>    the cpuset mems_allowed and mt_node_allowed() checks.
> 
> v1->v2:
> - naming improvements
>     default_node -> sysram_node
>     protected    -> spm (Specific Purpose Memory)
> - add missing constify patch
> - add patch to update callers of __cpuset_zone_allowed
> - add additional logic to the mm sysram_nodes patch
> - fix bot build issues (ifdef config builds)
> - fix out-of-tree driver build issues (function renames)
> - change compressed_nodelist to spm_nodelist
> - add latch mechanism for sysram/spm nodes (Dan Williams)
>   this drops some extra memory-hotplug logic which is nice
> v1: https://lore.kernel.org/linux-mm/20251107224956.477056-1-gourry@gourry.net/
> 
> Gregory Price (11):
>   mm: constify oom_control, scan_control, and alloc_context nodemask
>   mm: change callers of __cpuset_zone_allowed to cpuset_zone_allowed
>   gfp: Add GFP_SPM_NODE for Specific Purpose Memory (SPM) allocations
>   memory-tiers: Introduce SysRAM and Specific Purpose Memory Nodes
>   mm: restrict slub, oom, compaction, and page_alloc to sysram by
>     default
>   mm,cpusets: rename task->mems_allowed to task->sysram_nodes
>   cpuset: introduce cpuset.mems.sysram
>   mm/memory_hotplug: add MHP_SPM_NODE flag
>   drivers/dax: add spm_node bit to dev_dax
>   drivers/cxl: add spm_node bit to cxl region
>   [HACK] mm/zswap: compressed ram integration example
> 
>  drivers/cxl/core/region.c       |  30 ++++++
>  drivers/cxl/cxl.h               |   2 +
>  drivers/dax/bus.c               |  39 ++++++++
>  drivers/dax/bus.h               |   1 +
>  drivers/dax/cxl.c               |   1 +
>  drivers/dax/dax-private.h       |   1 +
>  drivers/dax/kmem.c              |   2 +
>  fs/proc/array.c                 |   2 +-
>  include/linux/cpuset.h          |  62 +++++++------
>  include/linux/gfp_types.h       |   5 +
>  include/linux/memory-tiers.h    |  47 ++++++++++
>  include/linux/memory_hotplug.h  |  10 ++
>  include/linux/mempolicy.h       |   2 +-
>  include/linux/mm.h              |   4 +-
>  include/linux/mmzone.h          |   6 +-
>  include/linux/oom.h             |   2 +-
>  include/linux/sched.h           |   6 +-
>  include/linux/swap.h            |   2 +-
>  init/init_task.c                |   2 +-
>  kernel/cgroup/cpuset-internal.h |   8 ++
>  kernel/cgroup/cpuset-v1.c       |   7 ++
>  kernel/cgroup/cpuset.c          | 158 ++++++++++++++++++++------------
>  kernel/fork.c                   |   2 +-
>  kernel/sched/fair.c             |   4 +-
>  mm/compaction.c                 |  10 +-
>  mm/hugetlb.c                    |   8 +-
>  mm/internal.h                   |   2 +-
>  mm/memcontrol.c                 |   3 +-
>  mm/memory-tiers.c               |  66 ++++++++++++-
>  mm/memory_hotplug.c             |   7 ++
>  mm/mempolicy.c                  |  34 +++----
>  mm/migrate.c                    |   4 +-
>  mm/mmzone.c                     |   5 +-
>  mm/oom_kill.c                   |  11 ++-
>  mm/page_alloc.c                 |  57 +++++++-----
>  mm/show_mem.c                   |  11 ++-
>  mm/slub.c                       |  15 ++-
>  mm/vmscan.c                     |   6 +-
>  mm/zswap.c                      |  66 ++++++++++++-
>  39 files changed, 532 insertions(+), 178 deletions(-)
> 
> -- 
> 2.51.1
> 

