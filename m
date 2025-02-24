Return-Path: <linux-fsdevel+bounces-42506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BFDA42E64
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 21:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65D03189DBB7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 20:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B538426280C;
	Mon, 24 Feb 2025 20:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i3el/lmX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3597D2512D3;
	Mon, 24 Feb 2025 20:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740430440; cv=fail; b=ZHJmBxHAQOsBwLZLol9LQ56a3dS6GkTAjtK6uW6TtYiKsqBH4OPJ35wzG5U/YY5ouljy68M/aFFubpeGgDrPJjt+hx6nk9KHoYAeqKSkvYyrXccIdfrQe/kcQtij/lCA2MVHvlSRKSO0/ZMJuCG7LLRdyqFIhNyboSsq0+N27xY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740430440; c=relaxed/simple;
	bh=iTYIZltomIrv+2LnUIdW2g7VTFrS1zgqPz6pbUCiIuo=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=YLdymWr4a3lnT7rPRB9Eri+5pWjRx2hlm+P+/TG1YC/MKKbt8+cM9eh3NQmIboHIrfqNTCH1DwhuoeDDAVoomBfnmIPjRIFtOxfC71rcxlaYeDjeKCc4nax5snctTAcevi31EXGTqvm4nM4wTfnOgFPGApAb05fb3XylERpXj/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i3el/lmX; arc=fail smtp.client-ip=40.107.92.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r93aYHPPvGnmvtDb6rRZ2J0z+sGO9tRuhPymbHMKqn576RMy5ecR5p18wrbTKFra+BpYLTtCmCHSPNdonNJsa1BY1o8wENVboqYpKH1d7dUgYqwJIhi21EoPao28kAQSal20fYPjU+2LEegGaRGI8YA5vAmNvHm6TcRbePRgO+f7ex+uP4NmY80mV0sICvVQ0qZc5nIscI1XI1YKnDHrRwtbFl6aMXMoBPjJg+se3W/MXtCzcGgErgdS/MvGe6HHFyQVFSzla+zPN8npzv5qPvLp+kVTNQ+gPekfwSaqYktaJ6uw4yp9nJdoqjontT5ufnC//GqTR7dqOy3Nl/x37Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBgDXppHFvblf16VOUB6Y5vJzUXX/uNP5zwrqd3oykA=;
 b=o6I5XUHNWneAuB7SjPREsgJZC47Jh1SZC7o9OuyZ/2ezBzEyZ8aobdvayIv8A8szEMRTlN5bOHBHfaOlGRYnUQH/tRW7PKnLDzEjNcL/qkQoDXDgoPTJOvts3H1Ojo6dbuxQGAnVZB+823m3ymVlgpANHagyEZ5rgwvkeC9nwqX2c/vA1wM5/S1oCxVMz2kJCLgYVTEr989PNjv0NDEhCVGew+pX1FNyMyBXNWnLLcbvodvU6eoDlLe/WV0UqBH2oEZJxQ65Q4SLHk9QZInyLsNv22Wjj6DoIHxuyIPVd807wsWeLwZqn2IDJZaqcKoYnNsof0N4BOd1v9sepkVKpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBgDXppHFvblf16VOUB6Y5vJzUXX/uNP5zwrqd3oykA=;
 b=i3el/lmXBNsmIjzuD1rFjOPhJF0RUCPnmGEFcrQ9ANa5ay0OwHSJNYq5cqmfKqaaKvN6s1E0OTTDMdYI+TjiZ1TKPSEJRSXn+P1VJugxYC5mz6LclkL2Cxwn40BUveaWkqz2K04puOv54tNiKI9sugzTDeGyy9qgWB4GKtsJbzU1vPyXl1RRybf/JqNX9DgCjIyj7BW5T7DeKV3GxBa/FYBa/pYjw+TETqWLJCyQAi8oJng01gHiIG5ryfcEcaBZZKo6EkatiqC0HgBRz5M38kCntOWSjPshg00VF3pocIUhYkkBygHES/VxTTZ7IV2vwsYkjjRH6ovWgT+LrQZG3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY5PR12MB6384.namprd12.prod.outlook.com (2603:10b6:930:3c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.18; Mon, 24 Feb 2025 20:53:50 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 20:53:50 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Feb 2025 15:53:48 -0500
Message-Id: <D80Z3H6NZARU.1HP5EKXOJ68QH@nvidia.com>
Subject: Re: [PATCH v2 19/20] fs/proc/task_mmu: remove per-page mapcount
 dependency for smaps/smaps_rollup (CONFIG_NO_PAGE_MAPCOUNT)
Cc: <linux-doc@vger.kernel.org>, <cgroups@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-api@vger.kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, "Tejun Heo"
 <tj@kernel.org>, "Zefan Li" <lizefan.x@bytedance.com>, "Johannes Weiner"
 <hannes@cmpxchg.org>, =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 "Jonathan Corbet" <corbet@lwn.net>, "Andy Lutomirski" <luto@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, "Muchun Song" <muchun.song@linux.dev>, "Liam
 R. Howlett" <Liam.Howlett@oracle.com>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Vlastimil Babka" <vbabka@suse.cz>, "Jann
 Horn" <jannh@google.com>
To: "David Hildenbrand" <david@redhat.com>, <linux-kernel@vger.kernel.org>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.20.0
References: <20250224165603.1434404-1-david@redhat.com>
 <20250224165603.1434404-20-david@redhat.com>
In-Reply-To: <20250224165603.1434404-20-david@redhat.com>
X-ClientProxiedBy: MN2PR15CA0061.namprd15.prod.outlook.com
 (2603:10b6:208:237::30) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY5PR12MB6384:EE_
X-MS-Office365-Filtering-Correlation-Id: 34e369da-6e2c-4eef-e323-08dd55155771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cyt6ZGhOOEE1UCtoQW45N3BQWEs2QTN0RmdBM3BJUGNZbXlSVnRaUGtlcXpP?=
 =?utf-8?B?bjA5d08zc2crRTUwMTV4S1JzT2wrbjQyZ0g0dWNEK1Y0V1FzRzM3ZkhINjJX?=
 =?utf-8?B?WFVvcEh0eWVOdjZWVHVLYVdsRkI1d1FERDVEbmJoRFlNQlZ3aGZJL0xLaTIr?=
 =?utf-8?B?UUZJemJQSUR6K3JEdGs0eVM2TkFJem0waTJ0SVBGQTFGNkgvUjNBMEJKTFlD?=
 =?utf-8?B?a0srOG1QOXdXcXlpOHF5bUk4bTNBZy9RWmV1d2ViTHdGejJ2ZENiSVhEM205?=
 =?utf-8?B?ZklBSzVXNjJzQ0hVMmcvci9FS1ljWVJDYUxCRVNZVDBhUlcyUGpLcFN2c1Zk?=
 =?utf-8?B?aU9RdkpHNmJwc3FBaG1idWxGYmQyMTdUUWJpWTRoQ1ZGSFhmdlR1SlEvOGs0?=
 =?utf-8?B?WVpkdmVNNGRYaFY3aEJxWS85RE4wVGFuWVBUZU5lTmlaNWhiNFdrcmVOUzZ5?=
 =?utf-8?B?QzIzcHp4a1ZJYzN5d1h1aVJORHd3V1NBam5HRGJ6anA3b3ZGWUZ3VUVCaDdr?=
 =?utf-8?B?WlVMUlV1TnBqMDBybndabUhaTFlWY0REZFE5dDYrVVJHZEgvUWhsclBzRkw2?=
 =?utf-8?B?YS9SNUVrbks5U3M3dWozWTVtN01BTjNKY3poQjVPWEw1RHlQMkZzK0s2ZENx?=
 =?utf-8?B?SFlqbTFldjhVbWhCcjFDYm9Kd3pDVWNlK3owZ0IrYTNtQ1hsOUsrbytld081?=
 =?utf-8?B?a1o2Y0h2MWhQYzh2M2ZwSXlBZnBkcjhLenJuWFlNSDRIR2d2S0JMWUtpTGVz?=
 =?utf-8?B?eGkxQ09SQjVjdnI3NXNIRjZhSms4V1JGbkdseWgxMnZsN2RxN1c0MHRHSjFY?=
 =?utf-8?B?WkZYUUxEeCszaFpudllSTFlTU04zVTVJWXZEb3RKMGtpd0xTaGhGbmlubC9w?=
 =?utf-8?B?NC91eHQxMExEQk1USnZkMGUzam1jNXdQZkp5TzBMcXJPcmNRN0E4WjZXNnov?=
 =?utf-8?B?ZE5IRFQrb1FSaCsxS3JEaklYZnkzU2hxbmRrQWtPczhWTGtjZ2RRbE9JZURp?=
 =?utf-8?B?WGlhL3BUdGpyVFJEbzYrS2lsTHJJa1krbkpMamFQeFZqM3pDL2xEdzgxSHZQ?=
 =?utf-8?B?OGtOSnJRdTRpN3REOVZBcjBsZ09LeE1GV0plakFXY2FsMXV0SjFPWDh2RG9U?=
 =?utf-8?B?NkFodThDUUxJMGJYcWtYbWhjc2ptOGhDSzh1V0tJN3RBRVdUajh4VTVzZDJB?=
 =?utf-8?B?cE9MVzlVY2dWL1JDMWVlQVk0VHhxV0huOW0ybllicDkxcHExbGc4dzhjWnJI?=
 =?utf-8?B?SXlYMGVRKy9oelhaZ1NNTHY0RHc3WlhKNGlNUy9sMmhNc0M2R24yM1IxVDB4?=
 =?utf-8?B?SjYyNnBrUHNTL3QrUmJ5RjZia3ZEWmwvVGdKa3h2NVArRDlreHAxV1NHSHZt?=
 =?utf-8?B?L1RwVWZFeDdsWjE1TFU5cHhsR0ZrMnI1aVRNYnBWNm1lQ1VZSFc2QnZEUUZw?=
 =?utf-8?B?SStRODE4YzRYMGpMVFpUbTBFdS9FTWlRNkxWOE9uR1RsbGlXWERzb3VSeUVQ?=
 =?utf-8?B?TkIzQ0NJTEwxUm5NdGN2NHovZTY1RnBicUhTL1ZCRDZKUVJndGZzM0xUbUJs?=
 =?utf-8?B?V2tZRmVaeWtWajRFeHpUcXR1R1ZQSXREaUlZcTJCTlFzRldhTG9iUFQrUkR1?=
 =?utf-8?B?VmZraHh5ay9VYnZjRGRTY2NxK1JXa1lnQlE4MlZpSDY3ajlJTGsvSFYwY3lw?=
 =?utf-8?B?YzBTTjRrZXZTVDFSaXVnL2FYdmVXeDZ1Vk9IN1pid1VPUVNKYTA3bHNUMkpr?=
 =?utf-8?B?MXpQblllWnh4U09uR2R3MFkxSHV4TjhKZ3JuTTA1bWFweXdmWnpLKzVNMGYr?=
 =?utf-8?B?QmV5VTg1M1RFQnJkN0JyckRpMXJPN2tvMkJzekMxcnp3MWwwS1I4OE82MEQz?=
 =?utf-8?Q?TZJ+zcL00buYB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzhZTHhpK0xlVzBmQzNHTUxNU2xWc1ZoMEw4RDA2Z0VaY1ZDQllnSHJXcFps?=
 =?utf-8?B?MTI3K0FHaFlwZHRWRUFyZDRNVzBPc3hXSm1WbDVQeGh1UE9NTjRYZmVKN1Vl?=
 =?utf-8?B?aHZRZjFDOUE5KzlPUGRmWVpsMHFUU1lsZ0tEZ2tUbkNxY0d2UWhvQnNUMmVj?=
 =?utf-8?B?OWJTOFpjRHl2WXpsT1JNL0UyR25kSG5zU1VteWo1Tm0wZXcwTEVtVGNTdXpq?=
 =?utf-8?B?Wi90NDJ2Z2RzRWplZ3hwNWIwUURhSGFpN0owczZpTzdpTDF2czJMSUNWRXdy?=
 =?utf-8?B?TW1EK0tBU28za1Rnem9vQUVwZG03UkpNak5HMDl0TTZjNTFWYnhHai93WFBr?=
 =?utf-8?B?cUhQWCtVK2dZdFdRUndQYXZ6cEFSZkkzRkF1SWZ2NldjcUNvOGxtc2NTdnM2?=
 =?utf-8?B?NzI3NXVtZDF5Q2t3R0hNNGMrbHdIZ2lWZTRrMG9pUVJ6Tmo0UjZ4Z0xYQlo5?=
 =?utf-8?B?THp5cXBHdzVHMkJhWjBUOFNPdnpsdzVoT1lPWDRBSTRWRzhuay9mVlFsU2hC?=
 =?utf-8?B?eFRXbHBMaEtRNVJlR2hUWGhuc25iaUxUay9WUzVuWm8wdFpnQUlFUURqdW1W?=
 =?utf-8?B?VWRkV0NqNFkvQTErWUZUNXkycitoRjdhNjRjQWtORVVuMklVRWpMVXk4Q3d2?=
 =?utf-8?B?YUIxTjVTMms1eWJ0S24xYUVpWDlnWnpXdWZLbjJUN3N2WWM5akM4d0dkenph?=
 =?utf-8?B?TEU1UEN4aGJmREVZZWNPZ0ZsTFU2d2N1RktCTUVWalQ0WjVpRkxWV1ZRV09P?=
 =?utf-8?B?SHlQME1SYldSUE5RekVpdGpoUUd0ZVFhVG5YV3hYRkhMS2w0NG1nRkRTTnp3?=
 =?utf-8?B?TWxOQVpGWHN1MkhLT0RGMTFpTS90UjdaMTNKWFc1Mkt1Y2dQcENWQitXVVhn?=
 =?utf-8?B?Z2w0dmVMSU9SS1FSUjhUdWNFbElKOWg4a1M0R2plZTNGU1R0VHhTZjJHdUhM?=
 =?utf-8?B?dWtTbUhXd0dwSW41Qml4anU5bE9rR0RRUEF6RnlTSWRvazFMMHZaRzFaeGkw?=
 =?utf-8?B?dGRsb1BETmVKZTN1cGZvZjArT3dmOWxVQ0tidm1DR2tXbDVGWDZQSlBWNk9s?=
 =?utf-8?B?WmlHNTRYcW5NZHNpWExwZnVvMHo3VDB2UkNLeHhXN2JzaUdzY096WTFLV0Nq?=
 =?utf-8?B?K2RxL21XUUFLTmFKRmhjNGhGcUI2cEsxZmhJSWJYNTRiOEVBSDBGZWYwTkFm?=
 =?utf-8?B?WDczR1JlcHFJZG96MzdMUXhzQUFvMFNOTkhMM1JSUENWb0k2RHF0NVVZZVBl?=
 =?utf-8?B?N1dsU0trNkhzSGhHN3Q2ek5tcUpldnNJQTlOenM1Y0lJb0VUMjlQVkVBOUgv?=
 =?utf-8?B?V0REaHFBdTlqeCsyUmtlZ3R2TzZIYm00OVNxWU5NN2tCREdNQm9pMXhTdXRW?=
 =?utf-8?B?OEh6MUFrL3BXOVpDU2QvQ0pBSnpQaUpNekR4U3JGYVdEMWhmTmJMNnF1dUdt?=
 =?utf-8?B?Nkg2eHdzRTlFb1NCc29TOTFnNktMTHNHN29SRjk5UmY1MVNLYi9HZUpVb21n?=
 =?utf-8?B?R3R1elN4OWhFT3FtSitjaFRId25TQkNJeW0wZ2xmMGdncHZEWXZBcERQL245?=
 =?utf-8?B?VDlZS2t0QzJPMHV3ejkzVkQ0ZGp3VDZwVHhRODBKQzB1YUxma29jSG94U0tK?=
 =?utf-8?B?SnNEZmt5VHUxQU1KamJzajQrQUN2NGNCLzRuQlA0WWR2MmZWcTR4ZHlJblYy?=
 =?utf-8?B?Vk1BZ0o1RXI5aHMxMDBrQ25iQXNKWkpsNDdZSFl4QnJvQy9FOXNPYTZlNVp2?=
 =?utf-8?B?b1FtVGdKN0JUb29Hd0M4eXl4RHh1bzk1RTBaeHR3QjY4SmhjTEhTd3RIeGJQ?=
 =?utf-8?B?Y1o3RU5pdFpiWDVXOTRoZFozaVVoMGd2UmJmbitBdU9kNGxBWHJUbDNZWHpJ?=
 =?utf-8?B?UTRDNTFaWE5Td1hqRDBUREcrdHNpQXRsV3dDckpwMTVwYUQ3SHo3b1NtU0hM?=
 =?utf-8?B?VjBMN0NFZGRhNThNcjczR0FoZTRBaVNXYnN5NGdiUGtJZWRkU0VWU3JoWCtR?=
 =?utf-8?B?a3IyeDZKMm0rQjdPcW5BRS9VRFJ3MzF3ZXhnKzkxVWFJZm8vaGhFWXZQc2lx?=
 =?utf-8?B?TitSNmNqaHIrSzlsTTdQTkllL3RTUG5HaWxpZm1aTk9odElSY0laczBHV2Vi?=
 =?utf-8?Q?W9Qqela0Ti7hG3ibIM54dRSgD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34e369da-6e2c-4eef-e323-08dd55155771
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 20:53:50.7441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9GFR748p+Liz80aeilu/2vq+vTyWbmc+cpSQ5pnEEgdnKxv/7PW9Em1z4MBqxauh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6384

On Mon Feb 24, 2025 at 11:56 AM EST, David Hildenbrand wrote:
> Let's implement an alternative when per-page mapcounts in large folios ar=
e
> no longer maintained -- soon with CONFIG_NO_PAGE_MAPCOUNT.
>
> When computing the output for smaps / smaps_rollups, in particular when
> calculating the USS (Unique Set Size) and the PSS (Proportional Set Size)=
,
> we still rely on per-page mapcounts.
>
> To determine private vs. shared, we'll use folio_likely_mapped_shared(),
> similar to how we handle PM_MMAP_EXCLUSIVE. Similarly, we might now
> under-estimate the USS and count pages towards "shared" that are
> actually "private" ("exclusively mapped").
>
> When calculating the PSS, we'll now also use the average per-page
> mapcount for large folios: this can result in both, an over-estimation
> and an under-estimation of the PSS. The difference is not expected to
> matter much in practice, but we'll have to learn as we go.
>
> We can now provide folio_precise_page_mapcount() only with
> CONFIG_PAGE_MAPCOUNT, and remove one of the last users of per-page
> mapcounts when CONFIG_NO_PAGE_MAPCOUNT is enabled.
>
> Document the new behavior.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  Documentation/filesystems/proc.rst | 13 +++++++++++++
>  fs/proc/internal.h                 |  8 ++++++++
>  fs/proc/task_mmu.c                 | 17 +++++++++++++++--
>  3 files changed, 36 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesyste=
ms/proc.rst
> index 1aa190017f796..57d55274a1f42 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -506,6 +506,19 @@ Note that even a page which is part of a MAP_SHARED =
mapping, but has only
>  a single pte mapped, i.e.  is currently used by only one process, is acc=
ounted
>  as private and not as shared.
> =20
> +Note that in some kernel configurations, all pages part of a larger allo=
cation
> +(e.g., THP) might be considered "shared" if the large allocation is
> +considered "shared": if not all pages are exclusive to the same process.
> +Further, some kernel configurations might consider larger allocations "s=
hared",
> +if they were at one point considered "shared", even if they would now be
> +considered "exclusive".
> +
> +Some kernel configurations do not track the precise number of times a pa=
ge part
> +of a larger allocation is mapped. In this case, when calculating the PSS=
, the
> +average number of mappings per page in this larger allocation might be u=
sed
> +as an approximation for the number of mappings of a page. The PSS calcul=
ation
> +will be imprecise in this case.
> +
>  "Referenced" indicates the amount of memory currently marked as referenc=
ed or
>  accessed.
> =20
> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> index 16aa1fd260771..70205425a2daa 100644
> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -143,6 +143,7 @@ unsigned name_to_int(const struct qstr *qstr);
>  /* Worst case buffer size needed for holding an integer. */
>  #define PROC_NUMBUF 13
> =20
> +#ifdef CONFIG_PAGE_MAPCOUNT
>  /**
>   * folio_precise_page_mapcount() - Number of mappings of this folio page=
.
>   * @folio: The folio.
> @@ -173,6 +174,13 @@ static inline int folio_precise_page_mapcount(struct=
 folio *folio,
> =20
>  	return mapcount;
>  }
> +#else /* !CONFIG_PAGE_MAPCOUNT */
> +static inline int folio_precise_page_mapcount(struct folio *folio,
> +		struct page *page)
> +{
> +	BUILD_BUG();
> +}
> +#endif /* CONFIG_PAGE_MAPCOUNT */
> =20
>  /**
>   * folio_average_page_mapcount() - Average number of mappings per page i=
n this
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index d7ee842367f0f..7ca0bc3bf417d 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -707,6 +707,8 @@ static void smaps_account(struct mem_size_stats *mss,=
 struct page *page,
>  	struct folio *folio =3D page_folio(page);
>  	int i, nr =3D compound ? compound_nr(page) : 1;
>  	unsigned long size =3D nr * PAGE_SIZE;
> +	bool exclusive;
> +	int mapcount;
> =20
>  	/*
>  	 * First accumulate quantities that depend only on |size| and the type
> @@ -747,18 +749,29 @@ static void smaps_account(struct mem_size_stats *ms=
s, struct page *page,
>  				      dirty, locked, present);
>  		return;
>  	}
> +
> +	if (IS_ENABLED(CONFIG_NO_PAGE_MAPCOUNT)) {
> +		mapcount =3D folio_average_page_mapcount(folio);

This seems inconsistent with how folio_average_page_mapcount() is used
in patch 16 and 18.

> +		exclusive =3D !folio_maybe_mapped_shared(folio);
> +	}
> +
>  	/*
>  	 * We obtain a snapshot of the mapcount. Without holding the folio lock
>  	 * this snapshot can be slightly wrong as we cannot always read the
>  	 * mapcount atomically.
>  	 */
>  	for (i =3D 0; i < nr; i++, page++) {
> -		int mapcount =3D folio_precise_page_mapcount(folio, page);
>  		unsigned long pss =3D PAGE_SIZE << PSS_SHIFT;
> +
> +		if (IS_ENABLED(CONFIG_PAGE_MAPCOUNT)) {
> +			mapcount =3D folio_precise_page_mapcount(folio, page);
> +			exclusive =3D mapcount < 2;
> +		}
> +
>  		if (mapcount >=3D 2)
>  			pss /=3D mapcount;
>  		smaps_page_accumulate(mss, folio, PAGE_SIZE, pss,
> -				dirty, locked, mapcount < 2);
> +				dirty, locked, exclusive);
>  	}
>  }
> =20




--=20
Best Regards,
Yan, Zi


