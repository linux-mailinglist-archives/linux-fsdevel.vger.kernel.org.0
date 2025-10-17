Return-Path: <linux-fsdevel+bounces-64491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 319DABE89C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 14:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 980634E6256
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 12:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114F5328601;
	Fri, 17 Oct 2025 12:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Eyd0U48+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020083.outbound.protection.outlook.com [52.101.189.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A6719DF66;
	Fri, 17 Oct 2025 12:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760704617; cv=fail; b=s43z/cp//JIlT0GxMexXx5wf5MgiRNJxtLkZBSqh/IGjJH88cZW1+Kk5fGmu7O26HpbWzw+GQHxk8xCa6c4xlHNY3FvFKzkIs1iz6teXaezseBnh4RxPbB0SL4x+LA7RPz20VkE498ze+D34LzoJwnGDZ1ZTTz//NywDRVS5TCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760704617; c=relaxed/simple;
	bh=/5dsD6Wa2RkyvluoQsjrM9EIT3T0lln2I3/VThzN0mo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BgZVWSEpbgtX63ECRRbeAek0A9cJdc9vZk4+0mBLeHEPGTjW0v78pdjnHoqh0usJzqVtZ+z5DJHc3qxNmAZsLMIgH1Yir9xH2PEj2gIr0whMOEi4ULbrqYWTwmb3Xz3tXzsPdFa4i0og4EO5BTNgyx5FfvUiC3HMQI7fyrAuDCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Eyd0U48+; arc=fail smtp.client-ip=52.101.189.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fmm3y2+jV4oNlHiczGY1Ut5VcvvsueMFIDmZgTTuHoQlapawf3hCOX5ik4VpbCyvkb6Yk4PLSjGKB4+dpTuYcb4TfXM3KHXPsHx5GFZSgruBamiy+il4FGZ1gMwwdpIbP6gWXL6XuzWqBSC0LzbfIgZE9lUAy8bc/zvU5kENvyD06Cu5rKONZ7PuXFf+KAJH6v9GRpe/DnLU9IzLFt8mn7Aj6rlUwzh+utCVgJ+/gr38mDXlKaxsjQJGL04iEhOrEPj7RgfCrouDlZ1paN8wRvNj/ML9NRxyQoxGKF3iMUvnd9dixHQejWXPKeY9AgP9rL11kR3sx4aC5NRwqZZFyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjmdPgLuin1uAqr3oZDlYroQcXfTwQyAOkGrncUeKcA=;
 b=XPIFYMXiL/cUKLGckQeewrXuVKQSxTYmnFMcgQ7vG1riGYaFJMYKZyOMd5hyTnjreyNtTAFfQUdCGE+oY16sFHjTLwXvUUgzIYiHVAu0k8GRrpmDW642bOmTijRcCdvB9uPOyqLhl7QsDY1AWBMmlzK0WKhmS6P9WG/qed1TZabOxOjkDWSW6BXymilZBf/yFLrhInKoDTngLkJ3LYbBLw0JSBbjxgW4ObKkNwXy0T/8UT0+iH171VvLLvgb2pSTxtmNUMlXf8Ew40MT9XKA82XyIgc+mQppaDAj2Bhfmf2d6Wdqbbe+rIpVsPTiFKMvT+EDrPY1a/M9kqOQmY45PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjmdPgLuin1uAqr3oZDlYroQcXfTwQyAOkGrncUeKcA=;
 b=Eyd0U48+hAbb5iG6KkzJqpPeYZJr7eTvvkJ/bzqtEjcBumVFejxCCQI+oUdvmixtmpdI/Vf9U4gBTpY8MUQNo4Oc/7NLTG7KvmC7rmf0bcSLAucJIBkVxdZ/c8e35r6gfWeDghlqxu/M4SZ/J6Nz1lLO4WPbiq4WA0Ta0xlPi8Y8CEK699N/QFWlJtnScB4yM+lwxfmrfnGyBTffa1ZtWDC1VNNzWtyo8O0+HOcQmE0qddYxco2wX87Z8se7fEZgCvLg+szxEnjYGI8j+xUFwmLIkYZWkSi05tsTFqGrtK40xEMs0qxGOWBI+jb+qKCdgEMZeCyaif38Xew8YQ/MHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT6PR01MB11252.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:13b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 12:36:52 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 12:36:52 +0000
Message-ID: <8669c9f6-74c3-4bd6-833c-1d73158dfc97@efficios.com>
Date: Fri, 17 Oct 2025 08:36:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 01/12] ARM: uaccess: Implement missing
 __get_user_asm_dword()
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: kernel test robot <lkp@intel.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?=
 <andrealmeid@igalia.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
References: <20251017085938.150569636@linutronix.de>
 <20251017093029.874834505@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251017093029.874834505@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQ1P288CA0021.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::27) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT6PR01MB11252:EE_
X-MS-Office365-Filtering-Correlation-Id: a4b3446d-1a87-486a-5002-08de0d79d93d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0xnU2QybDhWczZVUlM4Y20veTZZRlZ2ZHRyS3hOOG1zeFh4RitUNWxjMWlw?=
 =?utf-8?B?OEJqcWxXVXNxaHh1UVRwbkNGSnR0em9wUTZqTHN2NjVGQzc5MmpCVk9jQS8r?=
 =?utf-8?B?K1NEb3ZPQldJZWtUNHV1eUxLN25sNjdLcFdqdUg2bFBWOFhkWXV5Mm5WL0xy?=
 =?utf-8?B?UC9NbndjZDN4NkNZOTg4eEExc2hzakk5ZzA2TzB0eE5qa3hiemV4eWhIdDhI?=
 =?utf-8?B?R0hsZk4wcFNWcWFhY2hlSDlZTUhiTDluQTFuOGNSUk5LMis0b094WEhSZEY1?=
 =?utf-8?B?MXNxRFdkelJxeUtVdmJrRE9WdTJpK05oODEwZXEwRGIrc1RNT3RoeVI4TFlK?=
 =?utf-8?B?dnJDbkFCNkpHaXJ1S3ZTTW91bWxsUWtkc2p4SUFjQlk3eFRQYVZ2blFlNVpH?=
 =?utf-8?B?WWJDWThLL0JBTnZLTklPLzk3d2RGSkw4WWdpRHVlUGZsWDl4MHpPa2xyUFV4?=
 =?utf-8?B?a0RHQm1oQnIxVHNmWWJIbzF3dlBRMGlEdk8rWDBsL0Y1amEzSFFUQ09oMWpJ?=
 =?utf-8?B?OEEwRmt3eE5Bdk15ZlZLT1VRQUpjaHllcklHeFArZ0dTS0VNM3ZpejZNSS9n?=
 =?utf-8?B?NzRoMWJROWkrb3BNTldPSjFJV2tCZGhmUlZJeWJqSFBnMXo0bmp2UUl6RlpL?=
 =?utf-8?B?b1c3WkR2T0o3L1NjVVMwaVk4N3lhUmpWUnIrckxqVkFiZUowZEhpR1RLc0FM?=
 =?utf-8?B?QjNUWHoyK2d1RXpZNlBjVFRXNjZXcCtPaHM1U2FySDNRMDgycmlDN0F0TGhD?=
 =?utf-8?B?aTBVUmc4enBvSjJtaDdBenNXdkdNLzd4bWRpSDlBejExMVFkOHE0bUgzdEp6?=
 =?utf-8?B?bm9YY29yNzBUQzJLV2tOb3lLYjVBa1ZEYnN2UThpdkN4OG1tUXdYQ2dvYUFS?=
 =?utf-8?B?bUg3OW9NNXdQZUMwKzJETUxvakpkdlJaZmIwd3A4ZVU3M2lTR1IycXBKODJY?=
 =?utf-8?B?NWIzZ0grWDdCdmpHd3RIMXE3bnl4N08rL2tVNVVZc0pZV2puVW5NV2s0MG1V?=
 =?utf-8?B?T2M2aWJ1dkVTUlpLSE9MQ2dGUUI3MTdhUjRBQmFDaG9JeEpjeGpad1ZZWkpY?=
 =?utf-8?B?b1BGRnptOXRSWXVQNXhzNkNncDRNQXB0Wi81RDdHcEpsMEg4cmF1T2w4dFFx?=
 =?utf-8?B?MktzR1N5ZHc3cmdic2NLSkg4ZE5IcFlUZUNoOUgvcXZFQ0JubzRVRGRpSTJS?=
 =?utf-8?B?dVdkbXNaSmlqeU1iMDNCMmZKWWRHRnZNMkprMXprdTU3OU95SGhiS0wwSXVZ?=
 =?utf-8?B?SWViMmZzQmZNMTEvMFdjaG5VWHpiSFFoZGd0a2pFb0FpY0ZrOGlma3FUdGI4?=
 =?utf-8?B?VlVyNFlhZ1IxWjBodktpaXFDNkVyV05YblVKRGpaa01MSVhZMXB3QittcW1S?=
 =?utf-8?B?b3J1SGJITVZiMmtvSGhKY2ZhcERYd0s4RHNiMTVTTTBISk0xYzN5S0t6Uzls?=
 =?utf-8?B?UnFJeS8wV0VsdCtPS25IOXZSdktONUpKRlZTeHdYMGJQbERkNXdvM2VyM2ww?=
 =?utf-8?B?Mm5BMlpSK0FTb1pHL2JhdFpxbzNtMXhkY3U1L3U2L1FxMEIzUzdKc0NrZzBw?=
 =?utf-8?B?N1ZsOVhadW9Cem9Cb2k3a1JLcE9BL3dsU1k2c0Z5bFlpTTNsTFdFdTVhcTdl?=
 =?utf-8?B?MFAyVFpzL3FhYXR4blI0aGZ6L3NQa21DQUJyQjVERWhwb2Q4WjlZR2RHT1Q1?=
 =?utf-8?B?SkdTNXYxZHRRNEREMUYxVU9DRVA5dldiTDVEaGUyOXVxTHg0Zm1rUmd3MCtR?=
 =?utf-8?B?MG96VC9obGJLVElKK1NuV0NnQkFLSU5lL0Zsd3dUcTlLaU5DTVpaMHAzMGhO?=
 =?utf-8?B?ME5pVXptWm84VjEwVDl3ZElFS3ByRGI2cGxCT09lSXUydmZUbGJTZ2lEanly?=
 =?utf-8?B?eHFiTWZqUnFFY2k3SzVBOTMxeVIrWjJnN1RwUktML3ZzYVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVZhWUQ1djl6aVh0RkJwVHVaSW80eGMyMExUNHR3SFR6TlU5NDFMc2NtZWM5?=
 =?utf-8?B?Q3FYUFRBbmlpY2N1R3hlcUp1cnpSaFdsTUk2WGV0cWRlcEZKbVpFa2tuVEtW?=
 =?utf-8?B?Y2grSzFGQUFFTU1jdk84VXRmUnlXVkFwMjZPQmQzMXBDQlFZZFlqLzhpTUxh?=
 =?utf-8?B?RzNpSE1YYjVHS0FEQnR2M2J5c1REV25rdEJRL3dlOHBRSXQzTmNSbW50Y3M4?=
 =?utf-8?B?UUNLNHpaWXcrYzJtWnVJcEZ2L0VuUCtObWIwZklFRkdGcDR0RjNYck9oTkxD?=
 =?utf-8?B?cHVyejhDenZSNkswTHVQSmVTOWN5VmVvOU94Q2dDU2lYbGVZb1VSM2h1cE9l?=
 =?utf-8?B?RE1IR0JOTnVNK0t0VWszQUNKdVFCR2hYVWNlVzIxWVY2dEY1akZyS0J4WTZR?=
 =?utf-8?B?dUREM2dQZ1hNYVEvQVhCYU9WZFB2enpPM3lndTlOM2Rkb1orMk1Fc0xQUlIr?=
 =?utf-8?B?aDVNdlllRzFFdWFUbjR2bUxNNnRCWEp1bDlKQjNXOWFSTDJIWmNGOGFIVkVB?=
 =?utf-8?B?Wk4yMzJPOXBlSW5BWjk5NmpJNGEzRE52N21TQm1GWEpEaG1DTElPZmNDTWds?=
 =?utf-8?B?Qkx5SjZQY1QxaEI3N3BGcFNMQVBITWZBMU44TXhiTjFteis2MzdweG8wYjdD?=
 =?utf-8?B?dGhYVXU2MVpKUXBiYTJtMUliM0M2KzZXQ0gyNE80UFZaYXI0MjVlcEYzMElT?=
 =?utf-8?B?a0VnU1FvSjlQRDRxVkFUK0lxdVdmQ1hBcFRaUVRNZy9yeW0wMGg2NU1hNUhw?=
 =?utf-8?B?SER6Y0FIOUcvLy9ZNzNuV05vdmNYYVVyd0xSblFrbE9ObXE3dldrSTlwbVhW?=
 =?utf-8?B?UWRKa0xYc1BJYUg3ZktIUzlTbEk0OG5wZkVBbk03ZWQyZUxkRW1ZTGFDU2Vq?=
 =?utf-8?B?K1hPR1UvUFNWUnpqeUh2eWV4b1pSZTJ1YndsZ2VaSkdtYXVwbDlmUzJXRWN4?=
 =?utf-8?B?YmcxSGl2bjRYM2REWWtiT3Z1aHkweUdvZkhZUy8wQWs4YnQzTGhtb05LR3E0?=
 =?utf-8?B?WFZnQUo1YWlSM0Y0SWNUS1NYV3U5djk3WjZZeC94QnlNTUFaZEh6K0VNQVRu?=
 =?utf-8?B?K3JzS3FvT3dyYmpaL2ZTY1pac1d4dFk1NTU2aFAxZGpibnB1K1hCMkF5R2xQ?=
 =?utf-8?B?aE1pZHArSUxqSERMU2lwYUJKeVdCaDkvaFRSbDkyR25kdXJIZXZyMmowU0Fl?=
 =?utf-8?B?QnpmRUs1aFRlQk5zZGlkRVZ3Sjg4RFNGU2FZY3pxSkwwbERCOGtkY0tUT2kv?=
 =?utf-8?B?U1FPYTUyM1gxNUg2T0Z6TVpRUXNyWlBxclBjWFIvd0Y5ckxiZGVSaWRYWTEy?=
 =?utf-8?B?MVpKV0g4eVh4cjFKTDhxOTVVRUx1bFg1ei9oaXpILytnMUd5S25USHI2aTFl?=
 =?utf-8?B?a3I2TFV6K1RaK0pKK3NyV2hPbEhic21XTHNOSk15Q0QvMGgwRFhNSjMzaXha?=
 =?utf-8?B?TVpnNjhpZGFKQUE3eE9jTWVaSHJQNVFMMGFRUUE0TlgrWnFRaEkyMjdtZElF?=
 =?utf-8?B?NWdnSU9pWm5vVGltMU1mV2d1Rno4MFEybFBxckYrL2VPMTFEdmQ3TDRNbmpR?=
 =?utf-8?B?SFVmR3RzUXV0Ty9xc0ZhaDJOK3I5MjRnZVA0UmZPOHUwYzN3TGFPMnVZaHU4?=
 =?utf-8?B?SDVCQnVjK1QyUS85bTZRQ2NrYTRrWUtjbnJZS3RWSEpsc2UyZDJHWVdiZDhR?=
 =?utf-8?B?UHhwOGhzZUZ5UmRpUmlnQ2NPaHR1L1dxZUc0QzJmT2VPem9OOGpJT2t3ZmRX?=
 =?utf-8?B?NEZldS9ZKzh1blNnS2ZqVXA3U2d4MkZnSUtHd2VCbmR5cjVYMmpSN2NKa0ts?=
 =?utf-8?B?N0M2RXRraW9WRllJSFN3VDNaN0Y1YmgyVTl3M09MZG45U0ZkdEx4ejRQVTNy?=
 =?utf-8?B?aC9LR2lwL3hSa0xOeitHN0NrdFNOeUJGTFBOdXVrbitGMTVnUDNUdkViVlRH?=
 =?utf-8?B?bXhSeUVKRmpWOTRHMlJObUp1eWhxd0hRZEFLbS9QUEt0ZzYzS0VPQmRpSjJh?=
 =?utf-8?B?cUFkL01SdE1oTU1IN3lES3NwZDNGbGlCc2Z0RjBDZHZzVVVnRDg3ekpUZGFS?=
 =?utf-8?B?RE5rbS9WOHExNlhYa1phdi9yTzA3cktoQVppMlhCdXMxbVpadzJQMnJXUW1N?=
 =?utf-8?B?cit5UlNSRGVSWnBaTGtLeHRRSlFNN1ZVY2hpcFo3TDFZcEo2SkVmYTBEV21n?=
 =?utf-8?Q?u6SKEpC+fH6NJS+MheHHyFI=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b3446d-1a87-486a-5002-08de0d79d93d
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 12:36:52.3192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nvOQiYBGkP0X2RW+J8b0j1unNJg1wfnrFlP0ApIDVjsUn2O7ijYxD6/F9Kig+gJJkkLIREAebROOlvM8fAd7yHRhQaf+MKAcP6Wc0mHbDr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT6PR01MB11252

On 2025-10-17 06:08, Thomas Gleixner wrote:
> When CONFIG_CPU_SPECTRE=n then get_user() is missing the 8 byte ASM variant
> for no real good reason. This prevents using get_user(u64) in generic code.
> 
> Implement it as a sequence of two 4-byte reads with LE/BE awareness and
> make the unsigned long (or long long) type for the intermediate variable to
> read into dependend on the the target type.
> 
> The __long_type() macro and idea was lifted from PowerPC. Thanks to
> Christophe for pointing it out.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-arm-kernel@lists.infradead.org
> Closes: https://lore.kernel.org/oe-kbuild-all/202509120155.pFgwfeUD-lkp@intel.com/
> ---
> V2a: Solve the *ptr issue vs. unsigned long long - Russell/Christophe
> V2: New patch to fix the 0-day fallout
> ---
>   arch/arm/include/asm/uaccess.h |   26 +++++++++++++++++++++++++-
>   1 file changed, 25 insertions(+), 1 deletion(-)
> 
> --- a/arch/arm/include/asm/uaccess.h
> +++ b/arch/arm/include/asm/uaccess.h
> @@ -283,10 +283,17 @@ extern int __put_user_8(void *, unsigned
>   	__gu_err;							\
>   })
>   
> +/*
> + * This is a type: either unsigned long, if the argument fits into
> + * that type, or otherwise unsigned long long.
> + */
> +#define __long_type(x) \
> +	__typeof__(__builtin_choose_expr(sizeof(x) > sizeof(0UL), 0ULL, 0UL))
> +
>   #define __get_user_err(x, ptr, err, __t)				\
>   do {									\
>   	unsigned long __gu_addr = (unsigned long)(ptr);			\
> -	unsigned long __gu_val;						\
> +	__long_type(x) __gu_val;					\
>   	unsigned int __ua_flags;					\
>   	__chk_user_ptr(ptr);						\
>   	might_fault();							\
> @@ -295,6 +302,7 @@ do {									\
>   	case 1:	__get_user_asm_byte(__gu_val, __gu_addr, err, __t); break;	\
>   	case 2:	__get_user_asm_half(__gu_val, __gu_addr, err, __t); break;	\
>   	case 4:	__get_user_asm_word(__gu_val, __gu_addr, err, __t); break;	\
> +	case 8:	__get_user_asm_dword(__gu_val, __gu_addr, err, __t); break;	\
>   	default: (__gu_val) = __get_user_bad();				\
>   	}								\
>   	uaccess_restore(__ua_flags);					\
> @@ -353,6 +361,22 @@ do {									\
>   #define __get_user_asm_word(x, addr, err, __t)			\
>   	__get_user_asm(x, addr, err, "ldr" __t)
>   
> +#ifdef __ARMEB__
> +#define __WORD0_OFFS	4
> +#define __WORD1_OFFS	0
> +#else
> +#define __WORD0_OFFS	0
> +#define __WORD1_OFFS	4
> +#endif
> +
> +#define __get_user_asm_dword(x, addr, err, __t)				\
> +	({								\
> +	unsigned long __w0, __w1;					\
> +	__get_user_asm(__w0, addr + __WORD0_OFFS, err, "ldr" __t);	\
> +	__get_user_asm(__w1, addr + __WORD1_OFFS, err, "ldr" __t);	\
> +	(x) = ((u64)__w1 << 32) | (u64) __w0;				\
> +})

If we look at __get_user_asm_half, it always loads the lower addresses
first (__gu_addr), and then loads the following address (__gu_addr + 1).

This new code for dword flips the order of word accesses between BE and
LE, which means that on BE we're reading the second word and then moving
back one word.

I'm not sure whether it matters or not, but I'm pointing it out in case
it matters in terms of hardware memory access pattern.

Also we end up with __get_user_asm_{half,dword} that effectively do the
same tricks in very different ways, so it would be good to come up with
a unified pattern.

Thanks,

Mathieu


> +
>   #define __put_user_switch(x, ptr, __err, __fn)				\
>   	do {								\
>   		const __typeof__(*(ptr)) __user *__pu_ptr = (ptr);	\
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

