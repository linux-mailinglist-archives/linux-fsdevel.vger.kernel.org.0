Return-Path: <linux-fsdevel+bounces-42505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D95AA42E39
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 21:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28C4417838B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 20:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C85260A44;
	Mon, 24 Feb 2025 20:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rXE/1cd8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A3218A6BD;
	Mon, 24 Feb 2025 20:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740429962; cv=fail; b=Pjw/La8O+fW1hawqS0xQx1+PKleZwaN4WLsQlt/en8emJ1HJ7WzT5gTUb0+WEcoz+JeXTxqGgaNMpba5Rkwg4tAvbL+eL0QItIuKdYgATWHW+BYN+aJ5gLbSSId2mZN8Z0ghk89k2WYyDmjs5aLU41IWw73a4otqAfoDW5+7ZhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740429962; c=relaxed/simple;
	bh=4KncfUZRSZI7NCnQCDZDH28o0f61q0fVAvDrLFShGjE=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=QySGqF3r1Rh3KTVGNVCtCbT/BbM94k176V2CNUpHsUojW0uiVzSZPM7e4H0phtC4xiaYr3Kc6DO6u3ziS8jYSmt2vvI9srUoNRs73BPoqE191DnD/mU28AvLVVC6HLCs+lTtCretHY8hu1hG+59yuB5vhU9imkpajrzxPRn7PTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rXE/1cd8; arc=fail smtp.client-ip=40.107.92.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GULgkMzThoPaNk0jZ3aJiXVU6p8P/T3ba8CqOhrqrePraCOTnrfpc0MkFr66CkcEOm3mwJXRi83aCvoMJBkxgZmPjrhjQWHefARFik/7ezR/WURG1IvVzRKbX8XAI89GQ42/AS5iyCsGtlsZTqo5o5EfXLiNGfvcgvuPqybI3YkWuNxWlrA4v1rMFbmWAjSoYKU5nVBIbe3OLd7cWMke+Igg84waBzK9AlyzmiZ/gQKWMjTNu6DDfyR7GRws5PY68lf+8z0AigGYWNIRpwi6KraIO7QENf8nZrLgdKvMioUbxGAWAFXXyzuuu5SoO8EtbT1XLpV42GbZiGzNgPqXtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qcD11TMnCxC2xU5Xy89qpU805h+wwangfzJlDDb+IY=;
 b=t0DgNLLAYBODoYtKGA4mCJXyGptIPdn1w41iEIa1G5B/ZS2+9NlZhc6pf4SE34SFnHUGstMKBtbU8lwAQeEcuHS17VBoCZArm6Mk8MKsziI2gsr6VVOqJI4HPHZ8UjawbdZAu9Mm8vzwEi3pCYhjjLuIeaSLYsxIlpEdr1yUVLlC1IpmVURVl7c/6MPyv/zGoVmUotTo5g/rR4I/1UpKuZFM3yUVXi35rvClLso1DjepPM2mS1Crav8Ij5b/24kdVTN/OdcQBVXaKcAKlZVDgNWOfsFwYMXSprDeJEaWofXZxHoMB8kMMoEXZrR9Kv4XmBPbHf63v33RtECT7yWqnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qcD11TMnCxC2xU5Xy89qpU805h+wwangfzJlDDb+IY=;
 b=rXE/1cd89Eo5DFe4RUN259jAnSCYU2aRjNkIui1XuNrSxjDcKoxGA80awhmYDRsOOTGYv6eng8ZOQbkgNspgJc8vRFycNDUasyBn7nRDXGx+7D8SSYB1liF9vz7W/8eYmmdpSMYsk4u9pAy0H55QAYaQAQq7A1rqu9sCJ//EaZRtHTWtXXiGGa3czUXwZjHi+7zXq+5oAZtirmEZ0ZaZLJlp0URCU3r6LvNqqMLnqnbkBuZ4dcQ8u6sSyZmmB9fuCxRUBkxV2QWA5Wpv7V3NI3aggm703OXFTIs1VqnyuGAhTK1pSKzBjMuEs2vSo8RGRjKXbB9N9BnE1yEbLPltrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY5PR12MB6384.namprd12.prod.outlook.com (2603:10b6:930:3c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.18; Mon, 24 Feb 2025 20:45:53 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 20:45:53 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Feb 2025 15:45:51 -0500
Message-Id: <D80YXDU2A6IE.S4PQYSOT0PYI@nvidia.com>
Subject: Re: [PATCH v2 18/20] fs/proc/task_mmu: remove per-page mapcount
 dependency for "mapmax" (CONFIG_NO_PAGE_MAPCOUNT)
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
 Horn" <jannh@google.com>, <owner-linux-mm@kvack.org>
To: "David Hildenbrand" <david@redhat.com>, <linux-kernel@vger.kernel.org>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.20.0
References: <20250224165603.1434404-1-david@redhat.com>
 <20250224165603.1434404-19-david@redhat.com>
In-Reply-To: <20250224165603.1434404-19-david@redhat.com>
X-ClientProxiedBy: BL1PR13CA0114.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::29) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY5PR12MB6384:EE_
X-MS-Office365-Filtering-Correlation-Id: 811bc298-5ad7-4842-3e0a-08dd55143b0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVgyVzNIL3FmbnVud2tlQWJ6MVdod0hTTExRT1RVWUt1TVlyRzFvT0UwVjFt?=
 =?utf-8?B?NW1yVk9XaCtOV1MwZnArQkEweGVodStneldKRzR3elM0Uk9HUng0UjZDL3NF?=
 =?utf-8?B?cmpBdjlscklZT29zaGI4NU01bHdSMmNTOGkzTTdFdEMxYVF2WlpUQXpIRUk0?=
 =?utf-8?B?Tm1LWnJ3blRKYzlLRzNwdks1RmpCeHFhbTlXak02NjJnRm1vd0VJeGxMYzhn?=
 =?utf-8?B?TGJaNWY0dGV1clk0RVBWRG5FSUZpd1BvVjlhTmlkZ0d0dEQwaFJ3emc1NGxj?=
 =?utf-8?B?MXlyODlaVzZSUUJWVXMzYjJxaVNVTGZaWU5ySllSMEx4Q3d0WU9NZHVTVHhW?=
 =?utf-8?B?V1lNZ1N2YXBsMmF5d1hWWVowczUzR1VpU0szYUxabzBxTkdJMVkxYU5LalZu?=
 =?utf-8?B?WGtCeUVEUkhlZmFsQnFQSGRMeFFZTFV0VVYxdkp3QlhUNExqaGppYzRRWDFR?=
 =?utf-8?B?RThtWG92N09HUklmWlZnQzkzajdZL21EejBIKzl5NjNWWlUwaVNyMWdxSE5q?=
 =?utf-8?B?T1JNNGQxandCRGF5Z1hVUnUrUjM5OWo0Mk95MmVNdWVVcUxvSWVaM3VUTi9L?=
 =?utf-8?B?SllHQVZSV1hKbmc1QlRXMWRsVXFuVmpXak1nSmdjZUNqd3ZKbURJTDlYUzJS?=
 =?utf-8?B?cGJOVFZ0TWkzQXQ0SkN4MDZua0RvZHVRbnltUS90L212LzZ2aU4wZmR6RlVN?=
 =?utf-8?B?R1llQVVVQ0xPazgrbUhJUVA0akZhK1A0VHdFTSt3QUo4cWZsUWpJQ2ZxYlo3?=
 =?utf-8?B?TldWa2p5eE9WeU56dHIvV2tsOXQ1VUd5alNqeFk5OGtWbXNueEhYclUwNS9p?=
 =?utf-8?B?NnhIcC85clA0LzJySWRieHdvSXFDZ2xsYkdmSXdhbU1RTWVsNjI2NExxVjJF?=
 =?utf-8?B?UmdsRjNCaGlCbTlXamljNWI5QXR0Z3l3WEVZWDAyanFuWnVDNmlvYUNibHhX?=
 =?utf-8?B?MVFEMk84dXZPQXQ5Mm8rY0lENjg4TUdoYm9WVmhzNExGYnBHYVBGVWdLeFlz?=
 =?utf-8?B?blZPSU5LeGpMQjFtS2UwTU1lbkJLV2ljWDNXQUJUVTZLMW9jWGFHSEk2Wm5W?=
 =?utf-8?B?ams1RzBtcVd2NjRyZ2pmOG1sd05SczVxZTZiZDRkRVcxMnpFQlFIZi91VHlO?=
 =?utf-8?B?NUQyVkFjdmxJZkFiUVRETklyYmJoVXV4YitxcE50R3pPNVIwcHZyMy9jMGxh?=
 =?utf-8?B?UmI2ZGU1TzY4VWZ1RjBRZDBnNlhwT3NJV0pQdCtSTGoxd28zdUJlazBKQWFC?=
 =?utf-8?B?STBkcEF0TjBtNnVYb1Rkalh0RDJ0UjVjYTRRcEVycTJjNFhiR2kwbkJzQkNX?=
 =?utf-8?B?TXhRbkpKWnZoZTFPTGUxbHptZit3YmRjZytmK3UvSTBSelZjVExBbThVNW9o?=
 =?utf-8?B?NGJpcHhPTE5sSkJEK1hQbjlCTVBuSHQrdVlPSjJZMlNrVUR2SjlqODR1LzhN?=
 =?utf-8?B?cnBuL0Q0T3oybU1HMEkrelRtK2JIaDByMkFieTVGRVZsVnBKV0QrN3FtWVl0?=
 =?utf-8?B?aGoySVpPaDI2RmNGWUhZZzgwZytHNmdyMWs5TzdQYWEvNGFIeUhENXhPVVlv?=
 =?utf-8?B?VU1SalZLRkw4MzR6bkhXeENmdTJtL2VGNjVmSXNQV0FPUmRQdnl2YnZ4MEJq?=
 =?utf-8?B?LysyTDV5VjBVRXpHdVYzUHRlcVNPSDdCc2pyWGdBYmp0VGdZZ3BoaVYyMDYy?=
 =?utf-8?B?NHN1R1hxR1V5SUxGZXR1TjRvQXUwNmo0ck9HWUd6QU9lOS9KeDgrT1dCQldK?=
 =?utf-8?B?YnJZR3NmN0tkM3lTVUdjeUNXNjhLUVpZVnl1cTQycXhNdWw5RnhuT0tMTVFy?=
 =?utf-8?B?eEJqNUdrdWZSeGgxL0RnVU5DT1U2dDhuSEI5N1ltUC82aS9CdzhVYVZQOFRX?=
 =?utf-8?Q?1zYmNRxkXCfvY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDcreUUrR0hJZDkwb21rWXN0OUFNSzMwY2JUR3FpRFZtNGJxL0ErYUlwV1Fo?=
 =?utf-8?B?TWUzelA0ZVFpV0wyVENPNWRZK3Y0Q24xUGNnVjBLT29URjVnMmY5ZVFsbjZ4?=
 =?utf-8?B?SDA5OU1teFFyNnhBZmlJbE51QXRjamhWVWZxZzZwZHBmdUo0MzBYQjFVQ3d3?=
 =?utf-8?B?NS85WE9EOFkxZkxmYXI2dWc0bkhBK25RMnJ3K3A0a1I2Wmp1bW5yU3Ftd1hS?=
 =?utf-8?B?NDdiVXJSN1hqeVJxRlA1b2J3S0tZaTBiZHF6RktCd0tRc0ZSWExsZ2lTQ0dq?=
 =?utf-8?B?M0xuVkpTdlltdXV1eENXa29tVVJhRTVaZUdUT01xcW53cjYwenZWMm9hZlFw?=
 =?utf-8?B?blNUY0Z2bXZveXdjbG9FWnE5SmhQbVM0c09pOGVKU0xmdzN3cC9RZ3VjOE5E?=
 =?utf-8?B?YWp6Z2VQUktZTHY0U2tMTnA4WkZrUGtxNUtZcXZVNXhWclJZOG5tV05OdTIz?=
 =?utf-8?B?N1JyejV1N3BNVWIyV0FFbG15V3dJdHEyNlJXTno4aGpDRDlPa0MxYmxYcUN1?=
 =?utf-8?B?dm1RbThXeDFlY1VMekN3a2VSY1Y0NFhiVi9WU2dHdGY5MTlTcFo4U1YwVUlx?=
 =?utf-8?B?UGJtL1dBVXJhdzBMQlYyMGdUN0Y3WElnVVpQblcxaHRBbFhBZGY1dHJZWUMw?=
 =?utf-8?B?MkVSeVhXbGF3QTNMTmNUYWJROGtJM2Izc0NLT1c4MUR2Vkl1RUsvRWVoVU9S?=
 =?utf-8?B?Rmh0RXpwUi85YWpvVDB1b1hvYVZrL1RsYTZWazZMN1lJTnVWVk1rRmNpQVdK?=
 =?utf-8?B?Y2t5clROWmVHQVMxZWs2M0pRWXMrU3VvLzNndStaUUhGdGsxMEtYZzJ5M3Q1?=
 =?utf-8?B?eHl2aG5JSTNoSi94WnBEbDIxN3dpUDB3QlVMc2FDM3NTYjRLN2lUemNtaDRU?=
 =?utf-8?B?a2NOM2RFZHh3SkFTRWlKTm5Xc0VCWEhoYk1WSHhrcTR3aVFYaEszVzVjK0NV?=
 =?utf-8?B?WVoybGYwWHFPVHNqTXMrVWl0UzRZMVlCZE1vaktOdlF0VHZGaGRvL0FWeDln?=
 =?utf-8?B?MGlFVUhWY2lMeG9VQnB2QlVFN2Z0Y0gzcDJRaHFhenNoK1Z4NUJOVHY0OGc1?=
 =?utf-8?B?STFnY2EzdDcxYlRmMm94RWJjRjBaWmJrYVpKY2dCR3NoNWU4aEQ0RDU2VDZG?=
 =?utf-8?B?dWNEZERSWUlrZEYxbi95dDF4VVZTT1BtVkoxT1R4WnE3Z0tLNVZWYkxMVVJa?=
 =?utf-8?B?QVFFT1dZNXBzdDU4WWR3dHZaZUdKckVVVlBNNzVZWTF3aEQzcW9hOGM4MDIy?=
 =?utf-8?B?b1QrY1pZQjQvN1VXZXZyVUhManJueWV1Tm9qeE5nOGprWVltcVhwQ0hXRERm?=
 =?utf-8?B?bXdpeWRCaFZ2OW9zTVVMTkRFWExMVDBMazU0Z21ER0I5L2hGL3RqVnlOMWZZ?=
 =?utf-8?B?NC9PWTlyY1RnNE55YXdHTzlIRmxKcXdDR2JtMW5sREt0d1ZnNUJPOVVjOE5L?=
 =?utf-8?B?ME9PQTJPeVRVMklnclZPSUh0R1VDN3VUM2NTb2RveGR2UWFZNDFUMkdaWDJj?=
 =?utf-8?B?T2lta3lmT0xoTnJGRnpJbjhiZHdaOWwxQ2JCQm0xd1l4TUNFdE1TN0JUa05T?=
 =?utf-8?B?bUttTmFKZmkyUjFjc0IveHlLcGtXa25EMVJzNUdxdVgwcE5EY0l5dlNlVDNn?=
 =?utf-8?B?elF4cVN0YW5ERVRSMkM2cHdYUjFrMGcxTEZkVEdPdmJXWC95a1IvZWhSU2E4?=
 =?utf-8?B?S0hib2FndDR6Wm9SK0FWK3FVYVAvQ1U4cXZCL3ZwM0NqeGNTU2c5eE5jN0dr?=
 =?utf-8?B?RHYvdlJoMzNqR21tdW5OWlhOdExkMXduUWQ1OXpPaEg1bTRtc2YvdGFOaXAr?=
 =?utf-8?B?VG4xSFlycWozSmRPTHZKa2s1eUJEeDIxeEVmSitEMHFjbjBmMVVOQkF6Umcw?=
 =?utf-8?B?NGJyaDR6bDBVZ1hJbXV0STVYQ25DWlJNdjl3WDBNVitmZXZHRTBYblMza3pm?=
 =?utf-8?B?M0ovQXA5TXFRRERRRTZML1VlRGZ3Tk5EemY0Z0N1TWxTbXJwUnpNQUtVQzFs?=
 =?utf-8?B?ckRTL0hSWENDdUtFaktqRDdPcWlLZVpxaWdTQTVuRWNuV1k2cFJCU2tKajhm?=
 =?utf-8?B?aWtJVGFwVVNadjhsY3h0ZTc1OWlTd1FMQjVOVWhCc3ZxVEhWZ3pzRGlscGVF?=
 =?utf-8?Q?fQDVfrGzJ4l7ABY0C4G+Jh/JD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 811bc298-5ad7-4842-3e0a-08dd55143b0f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 20:45:53.6234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9vCsa7hOj+wrHsGsB2SuAHxg+hZ6bFuY4X94cROblhW+gthaT2Y0sY0Zy4u9D0za
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6384

On Mon Feb 24, 2025 at 11:56 AM EST, David Hildenbrand wrote:
> Let's implement an alternative when per-page mapcounts in large folios ar=
e
> no longer maintained -- soon with CONFIG_NO_PAGE_MAPCOUNT.
>
> For calculating "mapmax", we now use the average per-page mapcount in
> a large folio instead of the per-page mapcount.
>
> For hugetlb folios and folios that are not partially mapped into MMs,
> there is no change.
>
> Likely, this change will not matter much in practice, and an alternative
> might be to simple remove this stat with CONFIG_NO_PAGE_MAPCOUNT.
> However, there might be value to it, so let's keep it like that and
> document the behavior.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  Documentation/filesystems/proc.rst | 5 +++++
>  fs/proc/task_mmu.c                 | 7 ++++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesyste=
ms/proc.rst
> index 09f0aed5a08ba..1aa190017f796 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -686,6 +686,11 @@ Where:
>  node locality page counters (N0 =3D=3D node0, N1 =3D=3D node1, ...) and =
the kernel page
>  size, in KB, that is backing the mapping up.
> =20
> +Note that some kernel configurations do not track the precise number of =
times
> +a page part of a larger allocation (e.g., THP) is mapped. In these
> +configurations, "mapmax" might corresponds to the average number of mapp=
ings
> +per page in such a larger allocation instead.
> +
>  1.2 Kernel data
>  ---------------
> =20
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 80839bbf9657f..d7ee842367f0f 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -2862,7 +2862,12 @@ static void gather_stats(struct page *page, struct=
 numa_maps *md, int pte_dirty,
>  			unsigned long nr_pages)
>  {
>  	struct folio *folio =3D page_folio(page);
> -	int count =3D folio_precise_page_mapcount(folio, page);
> +	int count;
> +
> +	if (IS_ENABLED(CONFIG_PAGE_MAPCOUNT))
> +		count =3D folio_precise_page_mapcount(folio, page);
> +	else
> +		count =3D min_t(int, folio_average_page_mapcount(folio), 1);

s/min/max ?

Otherwise, count is at most 1. Anyway, if you change
folio_average_page_mapcount() as I indicated in patch 16, this
will become count =3D folio_average_page_mapcount(folio).

> =20
>  	md->pages +=3D nr_pages;
>  	if (pte_dirty || folio_test_dirty(folio))




--=20
Best Regards,
Yan, Zi


