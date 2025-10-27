Return-Path: <linux-fsdevel+bounces-65704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B4FC0D6D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 13:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6E8C63451E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 12:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805B4301472;
	Mon, 27 Oct 2025 12:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="G1vT7q2/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011002.outbound.protection.outlook.com [52.101.62.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D0DEEAB;
	Mon, 27 Oct 2025 12:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761567172; cv=fail; b=VmFw4XlmcSLNls5xCh8u4hZnOz09EzfXy5Ku1p8eZzRuz7fcX2kx7IdVAaWhn+YyFSQ5jYmp8IHOL+o1jsMtZW8fD+sxsSVMjWA7qjH//ejLUdIuEDqjZdR+tCgl2AKPUkAhBeAEz4tTqNN+G38h/356zZZdfNmHtznZKDOvARE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761567172; c=relaxed/simple;
	bh=La1wQWw0cXC2e4roLKZIUXdomoWopp8luancc82yr/A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uX400EeB8jhhBGVzeGr1yCotIf8lZ4HNsM+f9+7YIGSWrOGwG4x+XAl8qhE3nI7omxEdPeool3u1VcKCjAlGdesPzY/fiGrFcypm3PiIyRdjLojjP+mmfyLrOEaJtchVX3NuuTu1sMxNPg5knnBj81QDph+WuUPWi2yR2Q8F/UU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=citrix.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=G1vT7q2/; arc=fail smtp.client-ip=52.101.62.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XCSlu5/AIoLSeveYAFiJpByFYxzqKwhm7AduZwjO6et60AYreDYDBNAcoKvqzSov2BcrgixCJZD1RmtQXIxE8Q/e1QK6LRpEm+gzOwkFeIwUPva1KgiCjW+ed2WnO5wBFKSpnh2KLCFR6Heih6vNxtp98IwdR6cH2cYr1A463K2lLjzMjowvgdy2w+PQHNFDKEgLGMOiW7Ye8uQ+FSx0r4ICCdLsiAWd3jbmCZyozsy+XHL9JbSJsKYIthylGeH0H4sSLkLHFPT69JUOPqJOapZtvyYweSPW2x7kzQCK64LFROBoK9Stts7Z5ulgDZXA6HA2YlOkMw5MDJmz9cKm0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=La1wQWw0cXC2e4roLKZIUXdomoWopp8luancc82yr/A=;
 b=zJJV+a+3vFAkntnB0z6rWKUoL0nAnrPGEfVCquPp6k6H0G3rWFyqL3QFw/H4YJ9pFcxgQWbh1A5XT4JsMPyI17cLi+Id4MUF2xbfwD3JV7RFlPgbwLsALeXoabp2EvAKsWwSk/H/4zWfeSq6GSqaRoV86adJNzTfInOpNIMHhydYX/F9tq761aNlmO+FaxwQQ49LGD7/52ff6xhoQAtyX0PV2H/ItnOSTn5HI3VwGZMYOehSPsOe2uPyWdyPTxdFbdHtYIDWfa2gPvPJVrEal2ChqFp2YmhcL+Ncz1rM009fsdk6A9gOr4vqcazSWiocNU0Df5AIqwvBgD7oaJ4Psg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=La1wQWw0cXC2e4roLKZIUXdomoWopp8luancc82yr/A=;
 b=G1vT7q2/YJUnAgwOMDT5tKlihQk6kAjbxSAud5qdky3SQs40oMBYoa2Sm54wEFxvQQB0eayUI6JdL934tJx9Dcx40J0wtLa7/dIzRKp+Bjd1ZXygaF5riQRoVxqyIPNp6hjhRtUJI13tMZ81Q9Mc1uM7pw+vrLiV4UePG4pjAXk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from DM4PR03MB7015.namprd03.prod.outlook.com (2603:10b6:8:42::8) by
 BL1PR03MB6104.namprd03.prod.outlook.com (2603:10b6:208:311::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 12:12:45 +0000
Received: from DM4PR03MB7015.namprd03.prod.outlook.com
 ([fe80::e21:7aa4:b1ef:a1f9]) by DM4PR03MB7015.namprd03.prod.outlook.com
 ([fe80::e21:7aa4:b1ef:a1f9%3]) with mapi id 15.20.9253.013; Mon, 27 Oct 2025
 12:12:45 +0000
Message-ID: <a4ad352f-5fc2-4c64-8af0-8835af7064a7@citrix.com>
Date: Mon, 27 Oct 2025 12:12:38 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V5 02/12] uaccess: Provide ASM GOTO safe wrappers for
 unsafe_*_user()
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 kernel test robot <lkp@intel.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 David Laight <david.laight.linux@gmail.com>,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?=
 <andrealmeid@igalia.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
References: <20251027083700.573016505@linutronix.de>
 <20251027083745.231716098@linutronix.de>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
In-Reply-To: <20251027083745.231716098@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0468.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::23) To DM4PR03MB7015.namprd03.prod.outlook.com
 (2603:10b6:8:42::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB7015:EE_|BL1PR03MB6104:EE_
X-MS-Office365-Filtering-Correlation-Id: d7cb4f1e-7d3c-4eff-6d93-08de155222e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c0YvVFFnQTRmeTd4YTl0bkt3SzNWaTJvSVp0dUNlSUwxRzNaWlZ4S2s2Q1Ba?=
 =?utf-8?B?QmdRcmlhemtyVFR2K3JBQkNhNWd4YlRzTUtQNm8vRXg4WW9Cakh6ZXJmc0k1?=
 =?utf-8?B?T3RucHptdk5xY1NLR1U4YU95aDA2QmlJZ29QT2diTFlTNGRCNTU1SG5uMi9q?=
 =?utf-8?B?a05Ock9UVHpJVi9vZk4vb3hhOHJmUlB1a2pRbjAxOFp5Y2w2ZFgrbzUrUU9H?=
 =?utf-8?B?T0ZmVkY1Sy9nak9wWlppSDYwYXlwenhJM0JSb3ZwZ1pMaVJiaGp6aFM1Q05U?=
 =?utf-8?B?dGRlMWhITzJnVmM0QXU2cWhadkU3WmYrVytZK2ZpQlRZcDdGQ2FHSlF5anZC?=
 =?utf-8?B?ejZLRm1tR1FwR244Y2dTdXNVMjJzdGl2YU1reDI3OVQyM1lTeUUzL0ttZXlr?=
 =?utf-8?B?ZWtqNzFQOEUxbTlCRTJROExvMUR4NkZjQmpyM0E1bisvREtJb1pXK3BlMklk?=
 =?utf-8?B?NytKQllOdW5YRlFJNVhlM1dZL1dBZTFhRGVrWVZ3bmVPbFAxUXdZYzR3L1Iy?=
 =?utf-8?B?SkVNdDNoQTlrWFJHWEZ1a1h0WmpvT29rMnNJa1lkeHVNODJhaEFSRmtObU91?=
 =?utf-8?B?dGpCNzZxMGdhWUV0MUN0YzZMbHBQa2FSMWhTNzdCS2RiNXVldTFRbGNtOWFM?=
 =?utf-8?B?MDdLU1ZOL29NY1VRM0gwakRiejJQS2llUTBCR0NrYTZPcXdIWDJaMy9jL1JO?=
 =?utf-8?B?aEpZcXdWNzRYQlNQUUlvSnJnR2srK0xOS1IxQ1NTZ01hekF0N1BiaUZNZUQr?=
 =?utf-8?B?UWlYMEZRSERvcGkzYjhSN0VwbTF2VTlPNDNJWUF1aDRQcGR2YWpqbGdlSmZ1?=
 =?utf-8?B?bnJOL1RmeUVvb2ZxTk1PZG9wOEUvZmo3NUswZ1Z5QVlvZnV1djc3Ukp2QnBk?=
 =?utf-8?B?dGM3aXM1YUJRa3FNK0FQZVRUNERCUHEwSjlFTUE5bEE1YTdHNWJKSkIvK0RD?=
 =?utf-8?B?aEZJUWNCQTQ3RkdZeTN2VmJSNVREMUxxUUdhZHNOZFVIVUpEakpQUmJsZFQ1?=
 =?utf-8?B?T0xXdjAxR3pGaWZIYXFYRWswMGp1V0NDQktaZkVTeURWKytjNjgyNHQvdzFT?=
 =?utf-8?B?dUk2Rk8rUlVJK0h3WHRlaWxwc2N0cFJ0NEZORVJmdnB3UlM2bTF3V3ViOFRE?=
 =?utf-8?B?alpiRG5NS3Jmdk16OXpaZ1RKd3I1am5Ed0tBak4yMFVXc1VlR3Y2VC9wZnZO?=
 =?utf-8?B?NkJwRzJrSXIzcTlrcGJjdlJac0QwTTRTWGNUaTlLYlpsKzY2VXM3cEZ0a09P?=
 =?utf-8?B?NFltaGhCRkQyL2tSSkxLdnZvaFczeUhwUmVMaEFTNUNncE1OWEU0Z045R3Na?=
 =?utf-8?B?WkpjRnFiR0I0OHhoT0hmWFZqR1poejJvb1YvNEZEUHl3TFlKNEoyUENJQktm?=
 =?utf-8?B?aUwzaVkrV2dUcldKckxxZG93cENpTWRpQUtDQWhpWUZDdmZCR25CMGhHMUVu?=
 =?utf-8?B?OE85R1hTT2hxb1RFbGt3WDlaY3BuMTNpT1Y2V2NtZHd5Z0UxWnRBUGhPZWpV?=
 =?utf-8?B?eU9oVEJkQUtOMzkxZWI1aHNuR1FGMnQ1cHJKQmV3QlBIaUwzcHFmYzNmZ00r?=
 =?utf-8?B?UDFtZzlNK0tkUGNBVE5kSE5Ub3F3SHQ2dDlPcWVTbDBjWkpuZDV2QzFHdkxP?=
 =?utf-8?B?M1d4UDJwZWorVllVcEtZa0VjSjZ5WHVHdmZadERrb2lFbVVQaE9sTTFiQy9X?=
 =?utf-8?B?bzZxNTBaS3hnMWg4T21oSzVLR1ppWk5oWjloS2ZEUGN6ZWJ1YUxyYUNMV0dH?=
 =?utf-8?B?WGtsYThGZ1B0eWhuUXNuQktyV3FRQ1JqVmQzeDJId244ZHlET0JCT3B3RVp4?=
 =?utf-8?B?MjFFTTJrUENuL002c0s3YjlZeTdPRmZKWG1HbDZjaVo5aVhUS3ViRFNlZFov?=
 =?utf-8?B?a2RFcUpTSXFuTjdqSGkrUlcyUk9ET0xSQjA0YUhqcUFLT2tYanFsaU95YVFt?=
 =?utf-8?Q?kJvJ0gYNmvgI+RWYtLB1hmrLAYeXldU8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB7015.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vzh5dm9ybHhXNi9TSU9HTVVuZ0VBODEwc1BHdFNCOG1JRVRQcjUvMjB6NmMy?=
 =?utf-8?B?TmJBdW8xaGxuL2dYNWQyYUo3MVZ5djVuYndGUkVJSnlpbmpRV2FmY0l3NWFM?=
 =?utf-8?B?Um5xUEtRU0RBSjdPN3MwTXFvUFBrMTlaYkVtbEkzV0tXSFE5aUh3Qmxxd0kv?=
 =?utf-8?B?Z24vQWl6d0dhZ3dRdjZHRzVLNE4zVEhHL2k0QWZqaG1EcXhZazh2UVUvS0hm?=
 =?utf-8?B?ZVNESFVpdFNGMWtLMVN6azRqK2pZRFdKWnBpdXN2WGxOeGhHOEZFY00xRTdD?=
 =?utf-8?B?RjlDK28wNFFqcTJ4V3VjaWJVRnJuN1QxRklSUTJFQ2dFWmgvcU5YN0FwM3lM?=
 =?utf-8?B?NXdib3ZhTXozUFZHMGltMjhlT0tmT21SOVhQZFJqdno3ck5iV1NyNzVGblRa?=
 =?utf-8?B?VTVheG1rdXprOVd3WUpxS3FzRUxnTCtEN1JsdjlneUxxMkhqUTV4cnU2ajRa?=
 =?utf-8?B?cnpaOW5XcVlQYXNmY2x6Y0ZneERZUk8vdkdnQ1ZJdFZ1S3Zyc3JUek44SDhu?=
 =?utf-8?B?M20rTXpYMGcyNGZKZk04NFJpKzBtbU5mRnVvV2dlMmUyRkNkcEd5WE96Z3Mx?=
 =?utf-8?B?am1zYmk2QUhwYUhrSElSVCt3eHErd0pnaFVuREVKakhsVjlJNjE4S3N0Y0h1?=
 =?utf-8?B?SWFIN3k1UC92QUVwbFpuMlA2emhQTFk4ZVk5M1EyeVNYU28xczRKY1R1blZB?=
 =?utf-8?B?UWZndndBRXU4Qno0ZFBFNTlRYmswOEx2MEpxb0RHbUt6SDR3QzNEWW9jbTlu?=
 =?utf-8?B?dlVuMTJzL0xZaEM1OXlkeHpvVm1zU1N6SHFZbThIZWxwTE1sZFRBM3IyNnNu?=
 =?utf-8?B?anRTcm5od1NhZmh5R25mVnNQRnlsYWtDQWxHdHhsTjE5MTBHMzhnellFZlNw?=
 =?utf-8?B?bFpNbVhWeTMxdzhDZWxBdFdGMXFnSkhmTWtERHhHZm1yakVYUSswSTIrT1Q3?=
 =?utf-8?B?SVUwNTNRU24zL1NQd2lETHRNVk1mWHRTbEV3ZXE1Y2tOOXNEUGZYclFiU1JB?=
 =?utf-8?B?NURCS05mdFhaNFJHbmZRWkEzZTIwR3lRWGVBVXh0YVYvaGJoWG9jV29scWlq?=
 =?utf-8?B?dmFKVHBoVWsyeXZmeVh6WndNZWdRWElYUWNWTWNvSWhkUVg5Y05OalZJcUZw?=
 =?utf-8?B?Y3hPUGpxMEVHQzd3SVNXT3dLb2JveW1WYTVrNmF3UWYvMWJOaENFNndZRTVl?=
 =?utf-8?B?YWZoR1hUMEhtcExOTjBhVU1jMks1bHUyM2tyMmo0YlZSdkVDRVlYblFxdnpy?=
 =?utf-8?B?THFBVXlJTVNIbTdocTZMZ2orUE1yR1ZoQkViM0xraGJ6bEpqVDhlQXBHdzJT?=
 =?utf-8?B?SVY1L3NmWnBma2pNb2RmRU1Rd1lOKzU3dzQrazBnUWhkM0N1UXlCKzNLMzdp?=
 =?utf-8?B?cDJxR3NBT05DSUM3Tks5MnJzamErRmlCZ29qMDF2SHllZTU1MzVaZlJ2VGov?=
 =?utf-8?B?b1NNdXNndmdaUElmYjBiZVNkSW04NnJCTTRCdWVQNyt2UWxmRmhpSHVGOWpW?=
 =?utf-8?B?WGVLYWI5bTNvNSs1TVQrQ3RySGFOR0FEUXUwYmJiYTJVOEZ1b21zMVJINm5U?=
 =?utf-8?B?NlBjSXd5K0I0V3ZGRDQrd1FSUDZJeWZNWHVTNnpUY1dLWW4zV1hXR2Z0Ymxx?=
 =?utf-8?B?UmlSN2FrQ21lNlNrcnJoQSs2N1FyUW9vSlRwTmR5VGk0aURJclR3cjR5Zkk2?=
 =?utf-8?B?bkZSTmhQUDhLekpZcFBPUzJ4RFd4eGlsQWJPT0xkMW44UzJIcnNNR3BCQ1BG?=
 =?utf-8?B?QkdDY1hSQ1NhdlkxcEpoaklwRjlXK3IzUUxFcjdQU3hyU0ZJRmxScjV3eHpJ?=
 =?utf-8?B?V2QrczM2VUxXNmVaem9yRmVtck10alkyZzFpNU55TEh4TnZlQTFuV29iN1h6?=
 =?utf-8?B?TGh3WTRBS0pHNHdlKzJLdFBCa0FpWnB6WitLdnpzNEM1bmY4YmRDRmdXZU9a?=
 =?utf-8?B?aHo3alREaWFLdi9aZlF2b1EzY0JYM1dxMmkwNjR6Y2p4aGk4cktpcnlVeDlt?=
 =?utf-8?B?TzZZUDdGRHMrUnhJdlVyKytxeXkvSjQ5TmEzWWdyZ2RIWEdkb0F1Wi9JWG9U?=
 =?utf-8?B?YXgzOXZTZXFhN1E0UGxqNDNzS3ZVaTFMRUE2QU9qMFJMTWdaTDFGS0k2ckZL?=
 =?utf-8?B?WFlIamVlM09wUFJibm9BS2dVZzAxNDFXUnBiSThmVE55V1VPQUx6SXMzeGkw?=
 =?utf-8?B?NGc9PQ==?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7cb4f1e-7d3c-4eff-6d93-08de155222e1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB7015.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 12:12:45.3341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iT6lsUqjIpYBLliHDlkc2ZMF+j8gzC2dD0gKKEJ2ip4ErxXMtUGQqy+zME185CL8eTLdslk5NN6lhptZK3373cvTNfhljlpbGqAvYn6+S7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR03MB6104

On 27/10/2025 8:43 am, Thomas Gleixner wrote:
> ASM GOTO is miscompiled by GCC when it is used inside a auto cleanup scope:

"inside an auto".  Same on all patches up to 6.

Otherwise, LGTM.

~Andrew

