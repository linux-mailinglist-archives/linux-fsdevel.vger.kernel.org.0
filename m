Return-Path: <linux-fsdevel+bounces-41814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C59A37946
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 01:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E88516D363
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 00:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F06D528;
	Mon, 17 Feb 2025 00:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="dkgQdio0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FDC7483;
	Mon, 17 Feb 2025 00:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739753458; cv=fail; b=L1iMHCYq+xxSuW+jgcKr5Nwk+JDmiVjCOI35gDef6ufsVoryEnYsDhGYS84t8Ogy7z5358ewQAgucsnGjM64VLpHraVGfcuD31UE6Vig1xlPEu91obIT+PDAzgER1Q5gNmk3dK+txNuWrOZ1Lx2fDRRiJ1ZDg0GqFJkOgOOKjL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739753458; c=relaxed/simple;
	bh=iYtd1r1XLtDtR3BPEbjR585GNtbHHHLn7/nOtlNsV7w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Rj/blt+XHGopez2LE7ZWajz/hGLGoAgot8Q/iksZTifTo17g7PITpHMiBCkHjxfdm8+kFmXNtmc59unUaL7lPHW1QnKU0JHYbTvQA7KSM9GPhzbAOhIGEzyNtdQ8+CS5zPo+hG1iXYGuoiK9fu04CMY2B8OP0QIqqeWjbaErJ74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=dkgQdio0; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44]) by mx-outbound-ea18-150.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 17 Feb 2025 00:40:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DQusfoeXdIC2/172AVF3M5BusddskOcPjvNKI6B3EzhsesthKq3sFlb4mJXSHeM1CVCLZ5c9TJsVDgBNQStkhkWIIHU5NWpjrsP6C0Mj9QgCj7KWTOHnSD74iAr2sIPbZmBM/oJaMeN6rpkjMdrl5uGK61Wj/3mXm3k7tzvrtiucpGgKDOLea4ONjaGszHqao6Ei0TnhMlNeUXsothn0wIsnFppXRNq+Du2tvC2XGxnJU3GY2q8sfutP5Vgw0NEEVgXhwjSQ9UtwqkHZqbDsaSbBOWmuQDj431oVhRPZqHDBmKmI/MBRdY65HG+vBDWlhYEIf2aMJMl7nBZKAsbbdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLZXDTHk3vK0Ai4Akb24AXjXn53eh11wbT4EMjqtnsk=;
 b=av8L8PMAL7ggO360c4wBveGSSrzTCLiyEFWuM29bPwqbY3TnyXN6W0orxlwpNRlKN+i8eDTF2nwQnZxAUiPQb9JdJVQ1fEaDakHuv4cyS1mN3NdUrR4x9zuHkyBGALaWXtaMD5lEuEyU37PlAmZ8UnYaRrNiV1U6snpkCNKbxtSUnGWsQkHXDMMnGhtHwmhecY6+44Js0A4yWcO53man06+1iPGCj9OvXxLQkxPcOX6dPwFs9quUev6YYlBuImSr2MhbTkX5o2fxnKsiymA/WnpK5GmqB120FjBRhbMCP7B20gSOal9IJK10NM0W1ZA7INglnxeVFDl2qrHJYZNmEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLZXDTHk3vK0Ai4Akb24AXjXn53eh11wbT4EMjqtnsk=;
 b=dkgQdio0U2lmtA2SnHBid7chFsP6nQHuzERDM0np+wcC5g7hcEKQ/pu3uGo/j7LiimrHrCPSHdSBmj715iT4PA3xv+j8xIR5ldq0R0OaLWCnDBscpNiyysFVdcULylJZEoB6iwbm0XHD/PPzraszy6ho9uixOG7BqXVoDq0FVPM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from MN2PR19MB3872.namprd19.prod.outlook.com (2603:10b6:208:1e8::8)
 by PH7PR19MB7533.namprd19.prod.outlook.com (2603:10b6:510:27c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Mon, 17 Feb
 2025 00:40:11 +0000
Received: from MN2PR19MB3872.namprd19.prod.outlook.com
 ([fe80::739:3aed:4ea0:3911]) by MN2PR19MB3872.namprd19.prod.outlook.com
 ([fe80::739:3aed:4ea0:3911%5]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 00:40:11 +0000
Message-ID: <3fac8c84-2c41-461d-92f1-255903fc62a9@ddn.com>
Date: Mon, 17 Feb 2025 01:40:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] fuse: add new function to invalidate cache for all
 inodes
To: Luis Henriques <luis@igalia.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Dave Chinner <david@fromorbit.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Matt Harvey <mharvey@jumptrading.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250216165008.6671-1-luis@igalia.com>
 <20250216165008.6671-3-luis@igalia.com>
From: Bernd Schubert <bschubert@ddn.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250216165008.6671-3-luis@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P251CA0010.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:102:b5::17) To MN2PR19MB3872.namprd19.prod.outlook.com
 (2603:10b6:208:1e8::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR19MB3872:EE_|PH7PR19MB7533:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c04fb82-13b6-4a93-2ba1-08dd4eeba224
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0dleEx3S3VZT0VJeTJ5cHhpUG1mNEdZV1pqRTFUckZNdlVKS3JWZjFmVjMw?=
 =?utf-8?B?VEVEL1dpVWpmTDIxQTJBQ1JpOVdwZnd2Vnh0MVZaZC9neDRuNXZ6STlZVkM1?=
 =?utf-8?B?Q1pIbHR1cTBReXFoUk1XcXpjcEhDaGhrcUpMVnZHd3NQTHA1WGY2SFRMd0No?=
 =?utf-8?B?U1NYckQ4RVp2dWZaRUZvaXpURTVwYmhCcVlwWHpaZUtndUF3ZXc2ZGM4SmxI?=
 =?utf-8?B?UXp0Rjl1TmNHalI1LytGN05hYnk5Nk1nNElhQUs3VHdIcnp6NnpQQVB4TTB1?=
 =?utf-8?B?bzR0THdQS0h4QnIzcnhUUWQ0M1ErVlV3YjdwcDByOHNOUTNjRmxVZmlFS1Av?=
 =?utf-8?B?ZWc1RWRxcnBNT3VIK1NMZHhtbkVtdHRiWTEweGNubjlzWGRQZW1ackw2Y21W?=
 =?utf-8?B?QkZOZGdpY0tveUlIOWhNZVkwT1JGOHNpY0daV0NqZGRaN3BUdW9qUlY0RXdt?=
 =?utf-8?B?V2sxdmtJWXhuSUlabDRUNTcrTlBUbXlBeS9DVkhJTFNZZGdLNzl4UEM2SkdE?=
 =?utf-8?B?K25Ed3FrdzhITGh4M0ZLRFQrMlV0S2RjZXlaWlViR1VWNndQQjk0ZCtiWkdE?=
 =?utf-8?B?K01MYkkxdWt5UGRwOVkyVG9nZzlYQWVrMmQwaUc3UUt0MzB1QWdNZ0ZWVnlt?=
 =?utf-8?B?UzZmNHQ2aExWVSt5T2FnaUswclRQZm5FQjJsNkhnRkE0cXJUem1vSEtvUUcy?=
 =?utf-8?B?Zmtsd3hLSkJqTTZDTi9SbGptRG13QkkzZlQvVzdGdUh2TGdRclVCNjlONStn?=
 =?utf-8?B?Qjl4ekFIZEtOM3dDMjViZ3BFQXVHMFRSNCs0RVg4R0VJUXEzYVRHWTZsVzh2?=
 =?utf-8?B?NEZJMWJ6SFFQeEhvWGsxVXdIQmpuN1NvSWFsWTdrRTM2SXVaZnRtRkFYdVJ6?=
 =?utf-8?B?V0N3S01ZYnFJY2dhdjJpQnRCT3AyNWRhUXFQTHVZSlZRVVJLSzZhRTE3cnBq?=
 =?utf-8?B?TU5CU29ZRkhSZ1E0UlFONXdpY2VKZy9EbVN5SFp4VzVwejJjZVU5cjQ0VlJV?=
 =?utf-8?B?elJMUnNhanRHNmdOOTB4dFRCZFRoVXhpVUJ1amt6VmdZVjhFeWl5ZmVwRlNx?=
 =?utf-8?B?VDcvdDBESXJKbGFqeVB5Tm80cmtVMCtaZVJHOHl4ZjkzL1Zpd2FxWFVLWGRF?=
 =?utf-8?B?MUREZEZXTU5MeGpPYnlVODNEUGY5Njd5Y1A5U0E3ZkV2aDc2QVZ5N0I3cGht?=
 =?utf-8?B?SndKaXNSRzY5Z2ZSOEJVU1lDVmJnaXluYUNyTU12WWpHM2p3Vzc5VGpaSlQ0?=
 =?utf-8?B?Mi83K3BLOFB6am5lbk5IL3hmdlhSQVNWS0MvRnR3WGd1eitNWFVBVGhSK1Nl?=
 =?utf-8?B?aUkyTDNnVlRraFJmUmYwWitsUzZNZ1ZvZE5QUGRQMjF1OENyT0V3dzkzVnUv?=
 =?utf-8?B?Y2FOc29YelJUb3F1SjNCTWFVajk2L1ZCSWVuUXhBeGcwOVZpT3psM0xBT2Zm?=
 =?utf-8?B?N1VINEZ0QTNGQTRoRFZsQVR4TmdFZW9JQ2xrUmJTUmwybldtZjE5b2hSTjV3?=
 =?utf-8?B?cEtxMWNGTkRWdS9GY2lRSkdrNS9kM3M5MkVMUVk1L1Y5N1BEWDR4eDJXZnFu?=
 =?utf-8?B?a09qNzh4VzBIN1dsMXg5QThCMEdjaU1CTUNPeXVSUG93aW9TVmh0YnpVekpI?=
 =?utf-8?B?M0hXcnJ3Skg3MmVTQmF6T3MzcFJRdm1aa0xJeCtKNUtMRUZ2ckRjL2pyYlFy?=
 =?utf-8?B?MFVrbW5LZXVxMUpHelJLZ1h6NTMrb0psS1orNnZEdUIvTk5jUjJJRFJWVHcw?=
 =?utf-8?B?M0kyb1pjQ0tJRm9YTjB6azdPTFIvQXBxdjU2TFpjenJzU1ZqdGVXMENyTkRs?=
 =?utf-8?B?QW5kcDdzOUZRZDNaZkdubHpLRHgvcGhMS2dwVFJJMlNuS1dMaDdiL3hSRENM?=
 =?utf-8?Q?inj0aWBhfW/Kl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR19MB3872.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SE5NeUJaTWRkQnFzQTdvZmRuRk5TTDNQNnFYc3dPYWdCck5UMTRJRlhFUWdY?=
 =?utf-8?B?cC9tMkFlMGtRZ0UyQWJKdXl4RmVZdVZZUlB1alUreU9RVXZGajRqbmJkbkhP?=
 =?utf-8?B?M001dE5qaU81TUhNVmlXTFBOZ0p6V2pkT0tWcHI4N20vVEJNN2ZXNWxHN2k2?=
 =?utf-8?B?UVEyVkY4MzZFNjJiWW9uNXB0Uk5aMEtpS054Wk9OdWVDMExtRUx3YytmM29R?=
 =?utf-8?B?K3M5NUVXNGRET0J3b1hwczU0NnU4MFVJb1VQcndXaG5VbnQwR3haRFI2M3Fz?=
 =?utf-8?B?YTNoZTRKMG9DRk9rOGdnMi8zQkxkbUZzcHZkcTZIZVBwdkJRNGk1aUE5Zld2?=
 =?utf-8?B?NGlzVWNjaVVVMDZUdXl2QXViczc1QUFJYVk1OWZSL1k4L3BQS1NSY2d3V0Qz?=
 =?utf-8?B?QVRsWnNJWjNEbCs4MVlqSldwaVlPM0dOSFVzRWJxb3VTOFJ5RXNralBSbCta?=
 =?utf-8?B?UGpCVGhwYkM2WFZ2U2ltdWZFbmpZZ21kUVU1TXNtb1NrajJkRWtjT0FjTmYy?=
 =?utf-8?B?YmxXTHNkaE9yMzc1SHV4UXk3SFZHUk51ajd3N1k1Z2c5UkI3SG5ITGsyaVFz?=
 =?utf-8?B?dHF6anJqSlJHV3UrdUNiQ1hsYU5FY1FmV3ZBS0t5a0EvZHFkVG1hSWlXdU5W?=
 =?utf-8?B?azk4OVJnZ2RMYmY4Q25nMVllYWxPWFhqbG96cEdMVWd0TGxPRG5PWXNKb1ZS?=
 =?utf-8?B?b1IyNlFRR1FPK2ZZY0YwY2JTK2p4NHExS2RVMEdJTkhyOGFxZ1FHNjBaOHlv?=
 =?utf-8?B?bWVzWUQrWVhlNDFsL1BDSlNidEJacEk2SkthLzRUTm5IVlQ0YzcxaXA3OXNL?=
 =?utf-8?B?NEZlNWMyVm1ZNVRiUUlPOHNwbU5hL2tOY3NxM0F0YTBDdkluVWgzM1kwei9u?=
 =?utf-8?B?dks5RjZmMkVxVmJxMGlyaUF2eTlvNjlaUWVxNWdMMWVFdzFFam8vL3JtbFVm?=
 =?utf-8?B?alFvajNpVjVLVERpbzcwenBVTHlTaFVDUzZxOW5yd085bnJaYUMydTYvMWUv?=
 =?utf-8?B?dkhVWDZIaUtTKzl2Zkd1ZDhpV0djSzg3Q21UQ29jTDVuWDRFdktLZW5SV2Vu?=
 =?utf-8?B?bEVoeXUwYlRERDdLMXFON210L2tUbnpqL1BoUTRBcWxPOHpRcjZ5ZTBUZXlh?=
 =?utf-8?B?cTh6RWxkL3M3R0VUTHZyVnlIM0Rub3lHRE1oWURJV3c4QmQxTnFyRC94aVhq?=
 =?utf-8?B?VEdzbjZ3UHRJMkxGNzd2RTVySlRBejlhTDFsc29iUXczaG9TeXZ1MGRXVE1a?=
 =?utf-8?B?Sll2dEI4RDFianBHMk9Ray9KVm9DV240RWVCVlNqaXEzdUQ4K0VUWTBxRHFu?=
 =?utf-8?B?U3NhMUdRVVNmVVp0YTBtc3VmSDhJb1dod2NKTVlaRnUrNXRIMndrT3NLTWxn?=
 =?utf-8?B?UXIxaEZOVWVNaG9QQTdpUkJlcERoZExFaDgxOEdiZGRYbXpTMm5HUk5teVhH?=
 =?utf-8?B?eXpsRGhxS0E5cTZyclM0SnQ0b1JhSHBLY0hxWC9MT1JQcjRKRTNrbTRlSTFF?=
 =?utf-8?B?eUR2SEpLVHoyd0gyR2ppVUd1TWQwQVV0RU50NXZydXhESWttL25FNGhyK1hU?=
 =?utf-8?B?N1RKN3lOMXlDK1RqVUJZaTBjTk1hSFE2S0JLaC9ZVEl0d1dzMDUzdlZIZGNo?=
 =?utf-8?B?VWk4bmJYdlVjQUVkcG0rbUhnZGRqbjE1SFVTK0NnTTE5SllXeUpFdFNXVThD?=
 =?utf-8?B?ajBKYWxtZkhNSG03Y1BQenQzaDlYbW0yUVN4SW5FK29oVHl5U29BcFFOYmkr?=
 =?utf-8?B?NCtQZDVzNi94anczQVY5NUJjUVhTOVd3aXNSNXIxblJoUTJMYktqREdiaStO?=
 =?utf-8?B?OTN2Skl3bllnc2RtS1Q5Nzh6VkMzZEZybG5icndFWldRV21raGp1OVdFaFRL?=
 =?utf-8?B?SHI3NnFGME93ZmNJbDU0bFQ3SmliVXRIdUc5ckcwOGhXUGt4Qm5yTy9JQVVJ?=
 =?utf-8?B?aWRrQzh3aDFFRWI5eVVnczVQam4wMnU0elFhNmhDdHBUOHJTMTlCMFJaenNI?=
 =?utf-8?B?THdYTGw3ZGpwZjVZZGgrWHdaWG82NVVHWjZEQkMvZjdwUTFMRlU5MHpyL0I3?=
 =?utf-8?B?OUJab0pib0w0aVQxb3BHL1MyQzhNZDZjTk5yeGlxSVNyQVVJdG1uVU9Yd2N4?=
 =?utf-8?B?MHpyTkxoMTQwVEFVWXpjMlNNc0hOR0x0N0txdWxsWDhuZEd5UkNqRlR2SWNj?=
 =?utf-8?Q?jyy/BCp0oUI/0AmwxFSFChSchA1pYgvzwbS66XVIpHvs?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	B7YbnlKIztfS3YqIel0gnQi0seZR0x5XqyP+nhrG0GD3dZ0bxDNr7tmQZ7r0LaP1v4ip2uhSPsY4HBgwiW6dr5wCMSS4nsp99qxwWh9/LEPoxwK7k78DZo+VJmNUir8MwOyBm+sKnl3mftniXvhwHzj7vOaB2vN5FoN2ip/H+HdJkaEwy4QA7iUOkvyTa7XaAH0NS631bWiXEFa03XabtbOLfcKbgQpQi70A2HOYoJ0ek2GpLXODshQEoXenUVl5uGhzztAPsO+MZ6CtkgqWxSu8qPDRwId+0Ko3n00oKefnEbwMy3NPfqZ8wQdGe10f861dR/XkYNcSZgTd1HkOR/zy1qhNHLCFueRTaCLzE3UkOIo1+OLPMz4hnPYr0T+fXaI/5lTw9/a1zE/COAGg783eZ9Bo3vXqPAHLTbE0ux8YmWHOK/uK1gqllz0uhh98lGXMao9CZ+wUtdED4T3yp9LoOJGmxFx6bpxMYU130VWnwnxHRxxsTZJDVu0TBJm/D0SjfmQbEXrW0V1278iGen9GQwDgMKMxm+ManZAjFd71yUtyxAPCrrBu8l98QDY/hzaMX1x8LtN+G5hCSswZQ/KgYj/ZY9N8eDEq/Ta9ce0nTKYO6n5vs/mYtGkdNusA/vtwgVCSVUSNfb6S6othWw==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c04fb82-13b6-4a93-2ba1-08dd4eeba224
X-MS-Exchange-CrossTenant-AuthSource: MN2PR19MB3872.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 00:40:11.2160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dqyv7byHptrA15Z0P73JLcWPGvJrBELI9HOWso9mbbHx2d2dpl7QBqcfFfA0gTK3u+ATOr1ZCE8sHCodMBgZzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB7533
X-BESS-ID: 1739752815-104758-15691-124873-1
X-BESS-VER: 2019.3_20250210.2243
X-BESS-Apparent-Source-IP: 104.47.55.44
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsZAAGRlAAUNkk2NUkzTUkzSzM
	ySk4B0sqlJqlliYqJFSqqBmbGhUm0sAJc/5lNBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.262567 [from 
	cloudscan23-23.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1



On 2/16/25 17:50, Luis Henriques wrote:
> Currently userspace is able to notify the kernel to invalidate the cache
> for an inode.  This means that, if all the inodes in a filesystem need to
> be invalidated, then userspace needs to iterate through all of them and do
> this kernel notification separately.
> 
> This patch adds a new option that allows userspace to invalidate all the
> inodes with a single notification operation.  In addition to invalidate
> all the inodes, it also shrinks the sb dcache.
> 
> Signed-off-by: Luis Henriques <luis@igalia.com>
> ---
>  fs/fuse/inode.c           | 33 +++++++++++++++++++++++++++++++++
>  include/uapi/linux/fuse.h |  3 +++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index e9db2cb8c150..01a4dc5677ae 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -547,6 +547,36 @@ struct inode *fuse_ilookup(struct fuse_conn *fc, u64 nodeid,
>  	return NULL;
>  }
>  
> +static int fuse_reverse_inval_all(struct fuse_conn *fc)
> +{
> +	struct fuse_mount *fm;
> +	struct inode *inode;
> +
> +	inode = fuse_ilookup(fc, FUSE_ROOT_ID, &fm);
> +	if (!inode || !fm)
> +		return -ENOENT;
> +
> +	/* Remove all possible active references to cached inodes */
> +	shrink_dcache_sb(fm->sb);
> +
> +	/* Remove all unreferenced inodes from cache */
> +	invalidate_inodes(fm->sb);
> +
> +	return 0;
> +}
> +
> +/*
> + * Notify to invalidate inodes cache.  It can be called with @nodeid set to
> + * either:
> + *
> + * - An inode number - Any pending writebacks within the rage [@offset @len]
> + *   will be triggered and the inode will be validated.  To invalidate the whole
> + *   cache @offset has to be set to '0' and @len needs to be <= '0'; if @offset
> + *   is negative, only the inode attributes are invalidated.
> + *
> + * - FUSE_INVAL_ALL_INODES - All the inodes in the superblock are invalidated
> + *   and the whole dcache is shrinked.
> + */
>  int fuse_reverse_inval_inode(struct fuse_conn *fc, u64 nodeid,
>  			     loff_t offset, loff_t len)
>  {
> @@ -555,6 +585,9 @@ int fuse_reverse_inval_inode(struct fuse_conn *fc, u64 nodeid,
>  	pgoff_t pg_start;
>  	pgoff_t pg_end;
>  
> +	if (nodeid == FUSE_INVAL_ALL_INODES)
> +		return fuse_reverse_inval_all(fc);
> +
>  	inode = fuse_ilookup(fc, nodeid, NULL);
>  	if (!inode)
>  		return -ENOENT;
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 5e0eb41d967e..e5852b63f99f 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -669,6 +669,9 @@ enum fuse_notify_code {
>  	FUSE_NOTIFY_CODE_MAX,
>  };
>  
> +/* The nodeid to request to invalidate all inodes */
> +#define FUSE_INVAL_ALL_INODES 0
> +
>  /* The read buffer is required to be at least 8k, but may be much larger */
>  #define FUSE_MIN_READ_BUFFER 8192
>  


I think this version might end up in 

static void fuse_evict_inode(struct inode *inode)
{
	struct fuse_inode *fi = get_fuse_inode(inode);

	/* Will write inode on close/munmap and in all other dirtiers */
	WARN_ON(inode->i_state & I_DIRTY_INODE);


if the fuse connection has writeback cache enabled.


Without having it tested, reproducer would probably be to run
something like passthrough_hp (without --direct-io), opening
and writing to a file and then sending FUSE_INVAL_ALL_INODES.



Thanks,
Bernd


