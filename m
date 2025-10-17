Return-Path: <linux-fsdevel+bounces-64500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DE3BE8FAC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 15:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18D7D4E6BB8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 13:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA32F320CB9;
	Fri, 17 Oct 2025 13:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="RwJqor67"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022132.outbound.protection.outlook.com [40.107.193.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7417C120;
	Fri, 17 Oct 2025 13:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760708739; cv=fail; b=aUzwRBA5wTwwefFPJB1g8uS6TgCCH5Co/rK18uQCZVdm7SOyiwhsxO64/0DFgXBvpHIX5x3X/TfmlxhJ47I8QJNbatymiCHCnIV3zhUx6nsd76Q1YOlWyW2HjQm4smtXEUHCBpVeLLRXx24FDoZauyKzAaUXdvYS0LJJlP8ra2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760708739; c=relaxed/simple;
	bh=5nz7t8E+mstMANmiVeoPRek1/bAD8hY2LGeQEpZ+WXo=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N2dxGO3/fhS4xP4NyHwW7sIn/wlCZhzkt4/u/IsH2dSneu0sgr/pdvhOJeA+WSHr3I+dlCcWlyszSd046iLDkRqpNhSDbtQ1I06KiOs+bgeTWxoUTOf0woshh5V8IaexBk0m1CFIfRhUxhIALeuosDjuNEemSfhqdlnx1igDSPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=RwJqor67; arc=fail smtp.client-ip=40.107.193.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cogWU+cG4gxd3YaleO77wkbylOMcw0ZogvcfFVtLqGQagfL7niqI9nzVMwGx5PQxLd2cmznq1SHL0HOTd0GM1rrX2W3g1xpPZRiBFXsfzRG60T1Wb+BKfVvGckLCppOx8cH8kweHTeTESwXjjgWmaOenOvkK5miVpWQ4dhcW+7xqd3Pynj4ynMMmqzg5Ec2XxkqmZcGOAiWP0FFGTF0mgGy7kAjudA9mbd9yZ/oNu+AZIC/oXKVbDtFwPuTua12v/B3obR7sa6HW2FdH4s1ybqTEgAwR8u1V73//ncPyxjUixxMHwDgusi7SYBXdvI6mbVj+RJaoR0kM01HoR8RO4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HyLYKdM7qdudvU9dzfHPJoxwN3QuIFTAlCroH6KGdf4=;
 b=x8N3htqUpNOPFHAzhyza4RVGAL5gsSINwU8KvaSSZW9Bsxf5VsjPqg0NBU/4ledLcCbY0G4zC2lNBy65XBHR2ZLIfqNtjb9Di+GDqv4/JDVI6iwjZ8gllm3GChnkqbrIkN3jgy3WsJwMQ2z01eW5KdGIte87MipqEXwOtlXkyVT4RjnFKnFJyKwmYCzIXJQEyTguCrqx0nmMb4rrJZK1D1Gel8FSW81wgh2ybSfaaEEdKczRguBKFmU1oKyAucZVodwG100k0wZmZmVl2aSFJsenQWdg1VdTiZldURxyfY2rwmn/h22gZT1U9UWqrpgvIgmhANmUAVFznxEWuhfP5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyLYKdM7qdudvU9dzfHPJoxwN3QuIFTAlCroH6KGdf4=;
 b=RwJqor67F57SnR9CAaxjannbg1PGuoF+9qPT1Nh8ZSNC3YJ37AasQSpcKFwen3RXWWKE4j1BTlRLn7CjjmD/4QUUlhZGm8182i6wbh1BAXZuwfoEgb5RfQla9CCUD036ohY3kG6ajgkxgxGf19nc5+Ep6VGETuZ2c8u5eM41bJblGs+ZDFTAxT15lIaN6M5PMY7BD5ZnUgwoU1KBsRsJiwLeLm/NDFHagUKqcnAiG5n/znT2w1Zymet1XXpoWIlh1GQ2r6hxDEhdMDevy4DROKjd1c4EyW2AHyeYaXVk+nLC5tADzXNF5O9ANnzs+mElRS5lluGxYlDXLwxtFH/elQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT1PR01MB9467.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:aa::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 13:45:34 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 13:45:34 +0000
Message-ID: <d58b798a-3994-438c-9c02-678f3178b21e@efficios.com>
Date: Fri, 17 Oct 2025 09:45:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 08/12] uaccess: Provide put/get_user_masked()
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
 <20251017093030.315578108@linutronix.de>
 <eb6c111c-4854-4166-94d0-f45d4f6e7018@efficios.com>
Content-Language: en-US
In-Reply-To: <eb6c111c-4854-4166-94d0-f45d4f6e7018@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0118.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::18) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT1PR01MB9467:EE_
X-MS-Office365-Filtering-Correlation-Id: fcd7d902-5a10-4abf-6434-08de0d83724b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cEFza25nSEYwdW1PVnNlSHpKdzJrZjVXSDlnWk5MRE1OLzlwNzFwSHlSUGww?=
 =?utf-8?B?b2lBUVFCYzFTdzRaa0ZhQlNUSW5XRzdyT2xYZkVMZXZrVVh4RUpOalVUZk03?=
 =?utf-8?B?MkVzbWdGUXhIYTAwODY0UVRtYU5kSTdVTjdDTzVsN2REY01FQmhJZjRab0tl?=
 =?utf-8?B?eVp1NTZJS1RRWXMrREVuVFBsTWRjbXZQdTRiZ1NWOHNybXV1L3V2S2JBQXJx?=
 =?utf-8?B?djFJTHByWUdac2M3TWNuQ3laRW8yREVVbzQyQTk5TlA1QmpqMVF3Z0NaQ2ox?=
 =?utf-8?B?dENUa3J1UGNjSHEwZ3VYZzJ1THJKUHN5dGtYblowNHVIT1RieVUvODdDdytM?=
 =?utf-8?B?UWJtOTh1TGNrbmNaUEZBQWdsVzZpMzY5R2RFcHBJdGRVMGxrOHBpa1o1ZWRY?=
 =?utf-8?B?eEJxN3NSSXU3NVRWMUhpRDZqRWdIYzI4S0lNaks1ckJLV0NMZlNhaVB2VGtu?=
 =?utf-8?B?S3JIcVlpMTEycjQzaXNGSjkvejEycm5nS293MWpKa2RQNjBlUmhOWUVCYVl1?=
 =?utf-8?B?MG9sQWRDVXpGSUF1MkZNcUMwOUJqU2hWck1oU2ZEdHptL0pSWnEvNTNrbWUw?=
 =?utf-8?B?NFloVk9IK0RkZExTdVRmVjZVMy93ajVIUysyb24wendrbnFjUEdoMUtraEVT?=
 =?utf-8?B?YnFWWlpLZnN3ZHpoT0t2TUJKNzJPNTRkaU52R3BwcGdGVXNCZEVNSXpWMC9s?=
 =?utf-8?B?NDF2Mk56dEhVYlVtZ2NoQW9sejlXTzN0R1Z1SVAzaTRKemVhTmhFbEtpeGNT?=
 =?utf-8?B?T3lMNzdzSmJpNTZBVVFrL2pzY3J5VksvZlR2OXQ2aG4wa0ozY015S0JScEVk?=
 =?utf-8?B?Sk1iMEVta2wzckxidm1XNUtpVGQ3eUZYOWp6Y0dTRkYxbXA1dGh6OTZsSnlp?=
 =?utf-8?B?aEgzVTArdDBGTDJLZWNwbnh2VEpyWEZ0bFVmRlpjOEtQUzQyMVcveFNHa3NE?=
 =?utf-8?B?eWFLQmpjNy9aN3R1d29wSndYZ3ZnOW90aXY1dEhOd1d3TGphQjVIVVMvVU54?=
 =?utf-8?B?VnJCSUxhdVB1V1V5YU9EM3B5dzZQSExUNk5xVzhkS3FGTDBJN0RTSVFoSFdm?=
 =?utf-8?B?SUZPaXJGbzNsNkJJVVZKNmhPTG5KaEMwSC9OUW9PaXNNeGQ4azlsdzd5TUdH?=
 =?utf-8?B?SFJaZFBtYzByUkZNd3ZPMlhyYXNOTk5WNkdRTkpHM1Zob0JmUHJYMDZPWlNO?=
 =?utf-8?B?SDRaKzFoaVNoUkZaSGVlV0tqVUR5MVRLNWFLTTh6OTBHQVJGQ0ZRWmphTmkw?=
 =?utf-8?B?VVliN2YrbXlMcWgxdEpoRG9sVytwd2IydndnM0dYOUJXSjR2RXZnYm5Pc3F5?=
 =?utf-8?B?WGw4QkJOTGNzUFFpWVdES1BWdlZTMzF3c20zVzUyRjNYNFA1QlpFb2oxRzVO?=
 =?utf-8?B?UjFMZTdzL2RVNytEZEp4MzNQT2tXNEZOMlRsZzJQTGFqLzcwNzhnZkRHUU16?=
 =?utf-8?B?N0E4dzh0YmI5K3lnWjA4Yi9ra01UdWNvK2NUTTJyaEhmK0tWL3QyVWwxY2RX?=
 =?utf-8?B?MjUvY0ZES2NNN09EWXFMZ0Fpaks3WHZzRmI1VkladHJ2Rm01Y3FrMWd2dDVu?=
 =?utf-8?B?RnREQ0J0OWExN2hmNHZKS0VWSWlxbmVUY1NiUWxjeU5xT25WV3hvNGZJMHA3?=
 =?utf-8?B?ZHlxN0tqZ0tWY3o0SklBV2NKemN3bWhEYkljb3l1K2tyakFPc21tanpKdWU1?=
 =?utf-8?B?RDRoV1VBdkNyTEJqc01GTG5lSStQaVREdnJ4ZnhvNWpwaXFrWWZGWDZ4ZnlZ?=
 =?utf-8?B?WWRJL0lGRXZPbkUwdEtNLzRIZ21jaDRkN1hTVzFvS3VsWWRkVUJMUU0ra21H?=
 =?utf-8?B?U2FrVFM2WFNVS0ZSOWJiclNqY2VPS0x2UzBzcEpkZlJjczZPZ3JoOTIxZk5u?=
 =?utf-8?B?bmxSS2RXcm1WOHZCampiOEJqZlUwQmFjWmxxbFBPbkc1NkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b25KRWdqTkQ5Wkd0aldYRElCbndTck5xQzlmREpHSmZnTzYxcEhJZ3U0VUZ3?=
 =?utf-8?B?RE1XeGY4QmR3WG4vQWxSaEZrZ3p5KzJidDEyNjMrNnhNeFdUNCtveExPVmZB?=
 =?utf-8?B?eHFhcFVkcWVtQXRhM1hYZk1jN0hiQVQ3bTBBTldnRG83V2pzR3k0U3lwZUx5?=
 =?utf-8?B?T015V1QrZ05yRmpIWXRUYllJYnQ5clVQNk1DbDhzOWkySXZ3Zi9mYW5tbGdD?=
 =?utf-8?B?Vis2VEJzb0pTakZjVjlIdXlMU2dkazM0WHNkTFFGbWdJb3VTbHNrVFpaa3I0?=
 =?utf-8?B?aXk0VnVXS3JLcjVRUHdqQ1EwSVYyajlweHJmSjMvMzhjMkpaUXJIbllkbzEz?=
 =?utf-8?B?WDdiNnJsWmJJNGkwZmxXOGRaWDMrbXZ5R2Z5a09xQ2p0YjM0SlNBd2hTQWxW?=
 =?utf-8?B?RlE5Ny9jSksrQVRhWm9vQndBSnAzYmRvTEF1anJPUEhqRUdzZEV0MGk3VE9y?=
 =?utf-8?B?SGJNTHM5T3N1S2luSGRGT0pvbjNwRmZudWdxMy9hNHc1NStrRytnMUNNWXgy?=
 =?utf-8?B?cFN1L3YrOEhGS0NtaVR3andoWnAxUXNDekFCT3l3SDQ0bzQvT1UxMjdOZ09U?=
 =?utf-8?B?S2J1ckpPMk9ZTW1SaC9sS3FPRVh5ZGJWTGxHTFJYdjcrT05YbUpqWEFtc01s?=
 =?utf-8?B?bTBQV1VQdmk1ZzVEQTk5bXZ3aDJJQjE3dEdxcWU5MkhicGsraSt1cXdKeHJr?=
 =?utf-8?B?WU1OT1NjeU5YcDJLRS93YXVlYVJvTEJYL3VlWUZUb2lWVHpUYWE4SlN5em8v?=
 =?utf-8?B?T3ZnMm5BTmRJZWtnem9YSElRM3NVKzRBZFU5RGg3L0ZRVkdiRVdaa3N2bitt?=
 =?utf-8?B?NVpiRHAzaldnUlpXaTIrdGxGSFBTNThkNitFT0tZY2ZlaUFsdFJta0lUeFc2?=
 =?utf-8?B?N3BvbnQrTkhQaFNDRkJ1WFhUSXdhS1RPUnZOdTZCQnhXbm5pSHdoSWp1eStE?=
 =?utf-8?B?VGo1N29Ob1FybmtsYklBelp0S09kL1N1Q3BJZXdYSFNXYzBoMG5CeWNpWGZy?=
 =?utf-8?B?T1VoRzV6bjMxYXlLbm9pWUxKQ2twSTk1MWs1RVM2bVkrSDdxR0xzNEM1eDRl?=
 =?utf-8?B?WjBZaUZ3VVVGbURCQllxckdKOXB1d3d0b2U0b3dxTWtROVF4WHpVY1hTZDN2?=
 =?utf-8?B?UHpoV0N0UTJHbHJtOFRIQm5TbjdNSFQ0TER2NjEyK0R3VE9qNEpPN0xRdEhq?=
 =?utf-8?B?NjdLTVUxZ3kxbVRZVUo0R1NDTHpWMFRZS1k2ZWxWTkMwMXh2SUw2aFFDYTI3?=
 =?utf-8?B?YUU2REpnSHJvS2NWeC9ZTXc5TEtYZDc2SmtxbWgvZ0k1S2tkQWl0d2d4NllM?=
 =?utf-8?B?VUZJbit5aFQ2MmdUd2UrcmVFQXI5emlZQnB4OWVtNnRtMmtCeUJnQllFM3Ni?=
 =?utf-8?B?dGhqeFNJakUwS0ZwYmE3T3FxNCt4bk4wRjZrNXZ3Wlp5RXcxT2l5NlQ4QUNX?=
 =?utf-8?B?dlhBb3FVTUhWcEVBU3kvbjFVZTQ5dC8vT0hFK2UxcEFVaDVaTTNCZWhZWGZ5?=
 =?utf-8?B?eHlYblNaRjVPbWR3K2JTdFoyNU1QVXhRUkFuQ3daN2oxMjVIL29JSWwvWDZ5?=
 =?utf-8?B?anhhMWZvUlZmMjF5K2VyQm9uM2JOSXhMeHBscE9SOFFyUjlYNnIzTGViaTdn?=
 =?utf-8?B?M2MyVVdHMkxKVHRBYWZ1alViTU1TUnlmQzljQjFMeGpHeXpTeHEzajdtZXQ0?=
 =?utf-8?B?aVJXWTFLMkV1SVpJNnpSSXZaWkRMaE5yQjF2NXJnSmN1c2k5MWlNcW82UTV5?=
 =?utf-8?B?Q2V3VHRWWVllQ0ROcXB6dW5YV1ZNVlBYZHhxem9WaVZoSGxwdXlxdTltTXJv?=
 =?utf-8?B?Mk12dWNlY2pyUXhNbXRrRTBJZkNMY1d3WTJpQk1nWmgvT0VuWUtMZnFRWm1G?=
 =?utf-8?B?WlBtUHcrODNiK1J5MDFQWXQxUjBwTFordTNHVVQ0SXlSbVJHYjNDemVtRStZ?=
 =?utf-8?B?Y2FwY1hSZTBKNVYrZi85OXNBZWhpcndsVTl5MjJCbzdlYmh3VHo5NHBEOVRU?=
 =?utf-8?B?ZmJkVjhFUjQvTkdkR0puTDEyb3JjUDNKVE5KbDg4RmxkMzJXeXZWalRSUm1V?=
 =?utf-8?B?SDd3dW1Wc3U3UHorREhtYnlkNTl5YTlLSGYwcjhySFExZjA4YXFOdml6MU9K?=
 =?utf-8?B?elhUUUVDRjNnRnZ2eCttdmEwaGM2amkxcXNXdkk1QUF1QUpHamM4R05KZW1Z?=
 =?utf-8?Q?BL9sKAg3S6Cy4+TX6YzFCZ0=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd7d902-5a10-4abf-6434-08de0d83724b
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 13:45:34.3950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: osdfEw9yIPE7i6w91mvdnQDBZ6ZYtq80nRPr3U/eRTd6Z2C+glA5j60LRU4thf0OJ4yq3QWwcskRr4wCDEPO+PYL8iwjwW05pMhfWs+gVSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB9467

On 2025-10-17 09:41, Mathieu Desnoyers wrote:
[...]
>> +/**
>> + * get_user_masked - Read user data with masked access
[...]
>> + * Return: true if successful, false when faulted

I notice that __get_user() and get_user() return -EFAULT
on error, 0 on success. I suspect the reversed logic
will be rather confusing.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

