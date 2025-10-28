Return-Path: <linux-fsdevel+bounces-65926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84549C151EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 15:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BDF0647AD9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 14:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E573335BAD;
	Tue, 28 Oct 2025 14:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="kwQgvIe6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020120.outbound.protection.outlook.com [52.101.191.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D76421883F;
	Tue, 28 Oct 2025 14:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761660731; cv=fail; b=uMUdgaKVBtInGWMA4ETiM+PbUUrA0sQhJiwCZmR0io7VEiWhqfYIvnM80Ws8l9Q37hwfZboIg4yKPEelSy3pEF+3yTfak0jXNz7nbGOlc8GKjKcHcvgllhfg26E2B8h0EBavSZP78AFaqbv/6adWqn5hTjMlm3QU+O6gEmBRmck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761660731; c=relaxed/simple;
	bh=krmf3gLR7WnFx1D/sWFisgTJykO3Xu5iS8sA7039a2c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JkWblsaMhxdyNvZjjwp3tIQhI+tFx7Fm+zufrXzMHmn2w9juVWzWmRtU86oJdE2Sg0eEflmpoEx3XBYDSNsDQinIcCEFfNVXAzs1RCh3xx8MTlK6QhhZ85S1Ee4CQ9A/m77xPLwrUaAiX4F83KSCdBX+kSiXqHbRhLNvhNqM/64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=kwQgvIe6; arc=fail smtp.client-ip=52.101.191.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DeBEPCKSSrc+zewnYEB/16QBgmfEGDdNaqi87N0LLhbTOOZCTHo2cJzZ+rE0lC5AHbf1OKNz7n7SA5AuCsOrQh36NahWC5T77k2+DnGW7194rP9k9llXFeN+NIech1njpfqhndt+HhRG4QtFRldzRq2QIcrcazJtbADdOv2V447dvDDI1s3YkWaTHCiOob7YjPgpJjHWuLX9nodi47FwxwVGCg3WegAkMZLv2ihfRqhOsN08phxuspxCSZtmHSHKlY8ZwXsxOJeAF32oZA2jEqWjNhRQj+n4QdFfAgjI6AI1/B4dD3KC8i/oQW3NRHC7yBhsSxuPousPhWoHZed+LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2uP3YZgcEk5iPw7Gu0Q4/dqDNo9yNujAVXQiO5apDQ=;
 b=a7S6br11K3P2ffJUBZ+AkQni9GWX0uLvsV+uijRodPwteawHTfyxFpfiCLnDjUyulkE2NPMHtUdii5KmXSm1/9hvwWM2GwWvFiGmdixQZhiOk6t5tqiAEshF6sFa2TUyyOTiCgVMnuRmalBL4pRIx+LdoHpboBDvFNvIRihIbx2NBxWBAmKwUzCYnO7BSjk4brq+xA/W0ZNtFWueA1JKVzbAcPnd9DM8DmEx4oR/5UZuqCJ9dwWhbZUdImss7LP6bobpUxuWrebuqNl//m4Nn2Kc8FZmNJAQPn2XluFtga7jr/X76UVtkTETlZ6g44dOuk0RGZFCqZ8EUyu3TGuyGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2uP3YZgcEk5iPw7Gu0Q4/dqDNo9yNujAVXQiO5apDQ=;
 b=kwQgvIe6D/jfJvl8w/wKozpyUwKqdN4QFqqfub5URQXewrUINGUuBQBk1cffQdQbvBRqfZVRBI5er6qzVdarsUWPMZK5JxU1n63KaIpCQ83COlyWoOvUltandd4hmN9yAat7RCdL75WHuahG0/EtViEEL7l8sOApHANp/KAnggpMw7VQ1sFaS6XP2fbXV6nvi8OwhAOcZrqbLMHOwm1hGI2cJcVMh490otp5BxzUQT8j2dSQLegGRrLpKLY7h1p0/svUP2hEOWrNyQrlVuhnnDKMp0CIV4MwcPUzh1bCyK87+nxUkRFSWm3zpjNhV/VRusqCP6J+ScTYQ11bQvxwkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB5880.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:33::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 14:12:02 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.013; Tue, 28 Oct 2025
 14:12:02 +0000
Message-ID: <3b8e8bec-987c-4082-8584-9bf9759f126d@efficios.com>
Date: Tue, 28 Oct 2025 10:12:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V5 08/12] uaccess: Provide put/get_user_inline()
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
 David Laight <david.laight.linux@gmail.com>,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?=
 <andrealmeid@igalia.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
References: <20251027083700.573016505@linutronix.de>
 <20251027083745.609031602@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251027083745.609031602@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0363.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::12) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB5880:EE_
X-MS-Office365-Filtering-Correlation-Id: c199ae27-b344-4e06-02ae-08de162bf715
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVMxdlhYQjRIblVrc1JpZitET3g4VjFROXZtS3pKOENKTVh6K056M2RTOU1C?=
 =?utf-8?B?SW1wRVY1WGlpS0RXOXBta01vOERFaUZrQXB0SmFCbVBRVlltdlFuc2p3THhu?=
 =?utf-8?B?dVpEZExUOW0rRTc4YU42UzBZbHUrcUxTNVZCQVRHQzlxY09HMFF4NDNMVE5m?=
 =?utf-8?B?V0gwTkpCRVlGSnNBUTBUTzNMU0tlWFo1WUxRYThnZ1A3UGpiNnNiYndVSEtx?=
 =?utf-8?B?Z2lvZHMzdFo4Sm9OcUVWWm9pMjlsZGxTSmJnUnRpbkR1Wm4yaTQzUG9ndEJh?=
 =?utf-8?B?RVdiN2RmSThCbHZkVEs3SlN6a0tsMzljdzRGdWVNdEZaODVBS2dzazh0TjVj?=
 =?utf-8?B?c01WMy8vdk1YYmVvY2gxYVBtTUM3S0hONVNHMmNnZGhncHZ1UmtOMmEydFZo?=
 =?utf-8?B?VHhtWEJHY3lTd3RJMy9pb2tXSi9LaVJHOVpZUkkvbkMxbVdSZXdkQWpmaXBM?=
 =?utf-8?B?VUtWQVNoTkc2M25OWlFSYWpZZmdMeWc2WTVVajlkS2QvWWlSWVFGcWFPSUNo?=
 =?utf-8?B?bWNKeVdJNW1zK1JpM3VsYVhIWXcxNmdsL0sxN3FMRUdQL2M3NXpnVG1xSkhy?=
 =?utf-8?B?VXVmTWk5bmNpRHhqZGdkRGJHWWhNK1R3cFNNdGlvVFRWQ1hmejgvdHQ2T0R0?=
 =?utf-8?B?dFJsbHBucCs2YVZCZlVTWGpjTnkvYkhYdUJSMCtVY3FXUDhkeXhZd2tHWlh5?=
 =?utf-8?B?MG1rV0VXZkE4cUthSHgzLzMvdUpWMHBtc2oxdzR2c1Z5a05VMWt2SFBiVk1U?=
 =?utf-8?B?UkFseEgvRFlPWG0weDB6RzFFU0RTSS9KS1BLb3RtNDllSlNQblViSHFJZ0w3?=
 =?utf-8?B?MTBrYWU0ME9aS2tVbVV6dlZYTDFkRjg5RDlDa25VR2duckpaTTBmeFNFeENR?=
 =?utf-8?B?ckFWVTFPM216L2t6bkU0TWtJR201VW5ndHVmZDFDUmxvcndsSVFDam5OYnlK?=
 =?utf-8?B?MXkxenVPZ3UwcTRZMnc4NjdmNmlQa1F2OHJ5eTlzWGV5WTRpTmUxN2xuaUdC?=
 =?utf-8?B?Ri9vS0ViL1cydXBHSkpSVzVROHE2Q01CRndkUTlRWWhYekdMZXVuYnF2UjZt?=
 =?utf-8?B?MU13eXZoUGYzd1VmZGlmN3dReC9nU3kybXNtcGVnckhwNVllR3hNT2d3clUw?=
 =?utf-8?B?RGlmQ2lPQ2YxSjNldUVuOFpwUThuV3VsWjh0aHc5bmI4TWtlNlFuU1VMVERt?=
 =?utf-8?B?dGNOcnVLL1ZudWRLaExoejZUazlQWW5wV2JFWkxXbHkwWVVtdHBqUlZsVGN0?=
 =?utf-8?B?SlpXRUsyZzdkWkIvMmdqQitKZ3FwQ2l0NFQvSEF2TS9kenNUQ0lFQkNtRDZs?=
 =?utf-8?B?K2NzcWRhUWs3WDVCRW5IV2tYVjQ5L3I2djRyYlRHMlAvWlZuY25OZlZocGV2?=
 =?utf-8?B?bFdCc3FzcGZTZmtIcWxRL1M0eFI0aTB2NXN2ZE52c0poTXlOZkUxTFdkclZL?=
 =?utf-8?B?OFRYajF0RHJvL2lMWVFwdHV0RUYxU2ZJTkhsQjJsME51NkpKT2FJT1IxOUQz?=
 =?utf-8?B?dkh4VStEQkl2T3duZnUvODV6dUQ5ME1XRWk1RlcwaENJdmtoMFhQb3VNVkUx?=
 =?utf-8?B?anArd2VOOTE3NFhaNVIxNm04b1J6VFpWeWZKZDdrbEE2MDZzSU1rU2l3ajFt?=
 =?utf-8?B?eVA3UEJqdzlNdEJMZlRQQWlDdWtybVVRNUNSY2hxN0ZKMFVRU1dza3NEM2dJ?=
 =?utf-8?B?bTBRamNRUVl0aE12TVpBY29CQVI1cnVGMG5FanZkZ1JUU2VsQi9Ca0lsOG9Y?=
 =?utf-8?B?TE54YjZjdkhNTUwremlzNnBmZjQxYXZtUlJEMmlhazdzc1FWOGh2REdMVEdP?=
 =?utf-8?B?VkFNZ1ZTbHVFejBGLzBpbm9NeGZhSW5rNFZEdmk4bE1pVnNseVFuN0ltOC9E?=
 =?utf-8?B?WnZnZlIxUmRWVW9SUjl0SzZmbkpWb2V2K1NGWXZ5YWRxb2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGkxcElab3JUK09GZFdqVWlaRGVjK0hGQ3BuWFhacGlqdDVCSExESkVNbWtV?=
 =?utf-8?B?SHVrMi9JQ1ozWDk5QXkrVUh6S25RbFA0djRNeUs5N0I5TEd2K3ZFaU9qQmFP?=
 =?utf-8?B?SVhTYmlDRi9WNGVJaENGYWZHWlVqT0pKai82R2huOFlQOGUvZjlTN0Znc2ZD?=
 =?utf-8?B?anl6NVhsU0dLQjRzMUFXNm8rc211aENVZWdKRnlSY2h5bDlSQmxLcldEUFBW?=
 =?utf-8?B?Qk1wUEpFdjJIa2N3bDlRck1nWkoyODF5M2I4MDVQWCtOTXBNb3NkcDMyRnIy?=
 =?utf-8?B?STJITEFPZE04YW8rL3dDWEdueVZ5ZFN0eG1ROTlzZ3QvUEU1VjZLRTN0ZjZK?=
 =?utf-8?B?NFlFYXpsVG4yeDVESm1zSmYzS3o4QXNQYXE5Ykk4cVdCN3Z6RnhEZU1ZclI5?=
 =?utf-8?B?L0tuSWlQRFFXdm9CWXB6Ykk2NGFqMi9HaDRoek9sVk1ZTGdHaXNJWG5mRUIr?=
 =?utf-8?B?djQzVkpnVkUvYkJrVGdnOGZ6czhZSlY2UE1aUktCT3hVQWlQN1N4bTM3cUZn?=
 =?utf-8?B?Wm9lb2JvSFgyaVZmcWZrdVg2K25qV1JVMnF4YllHaXNDeDNrR2luVlo4Vzdn?=
 =?utf-8?B?d2txQjBaYlY1L3dpY2tBSmV5cUhCYlBPbTBXYUZGZmhpeVdyd3JXdEpUWnEy?=
 =?utf-8?B?VjBZUVZ5SUl5TktOLzQ1N3JYcHd6anpnQnpxQVo1OEs1TWsxSXd3ZTAyamNP?=
 =?utf-8?B?SWxhSXpyWUw4dnJLWjd3RHBkVHlaSkF5ZVFmR2tMOEFlNkxRdXNaVFJWc3FY?=
 =?utf-8?B?Z3FiRVlnemRVQzg4ZDZqQm5KWFFGVlV1UE5JQ2ZqcnhyaHhoajVuMGRuOTJH?=
 =?utf-8?B?OEF4Y0pwdFBQMFYrSjBtK01ndEhNN3JGOERRQUpnOFlkOTVIVTEyaUtUb2Fh?=
 =?utf-8?B?dnQweXhWUXp6dER2bitPZm9lTGFmbE5YaUlyN0FhWVMvRUlFeWFzWWRFeWVU?=
 =?utf-8?B?anJPZ0lSOGR4TTBFVXB3NFpIQXFlQUVvOHY5SkpxUi9IOFN4VnkrcWw4U1lJ?=
 =?utf-8?B?UzJKNEUxclp5dGdZUVpMbGdtSTNsUkQ3N1RCWldFZ1RpTDlPdXpHNEZpdktE?=
 =?utf-8?B?TVBaNURUWXo0THlTR3RMbzlyZHFBRTFZZ1B0UHMwZnZmY0Q0SWZ0eFlqbVpI?=
 =?utf-8?B?ZUlMcHRBWUJVQmo2WFNudTBkaHZhb1g5bmdocytPcm4vSVlvSnZHQjVVVlJY?=
 =?utf-8?B?TEpxNlhRN1R1Y1JyRDJoZGFrYVpDbTFubzVFRjNoK0ExaDFuM3dGTWplZXEv?=
 =?utf-8?B?NGZjS2VOcnVDUXZ5MTQ1ckRydmhpZ29uZjJUaHErZmVDa3h4UGkzcmRSbmt0?=
 =?utf-8?B?SUM1b2FWSTR4T1RUVXFsWkwwanZhd0RxL1JKODZ2WTZEWjhZYmFTWlVFcWRZ?=
 =?utf-8?B?UDJqbEtnUDhhQXlpM29nUDlhVnpYeW5RTjRJRFJyZk8zYjBIeTgwSkdMVGdG?=
 =?utf-8?B?RjdadkhrMnRZbEFUL2lKSkgyLzFiaGVqa1U2dW9SMmF1TzExcVY0NFErcDdm?=
 =?utf-8?B?b2NOOEVwUmlEWjZ2UnprR3lmVG1LZHBEbmVnMUUvcHFtcWdKQnUzQmVkNXlH?=
 =?utf-8?B?NURaUFNQWWdiQy9IeVRwZkNHbXN2MVliSHduUzVBRkViTE93M0t4aDVDYUN4?=
 =?utf-8?B?V1JsbEltSW5BT29vQXlpOTdOV2tFWEpqczFoVksweTU2eFRwaUxHbHhkNm1W?=
 =?utf-8?B?dTY4RHdiQTFnc2ZNT2NjVEd4cEJZNVlRaWpKMnBkVng2U3RPaHMvekJTZHRN?=
 =?utf-8?B?dkFRZUhiVm03OVlUemFPT2kyVTJHanNmZTBqV3VtdTBVaUNNYW1sWDNFeisz?=
 =?utf-8?B?QXNVRVBxaGw0K0VFRzB2Wm5EYnFxbitoVlJsRFphVE03bUtxY3pYSDBEa1RD?=
 =?utf-8?B?djhxb0xDaVpYSStWNEgxK0pxdmR0VVJnNVdKV2x3aGRUd0ErenA0NGZjZGFF?=
 =?utf-8?B?UFhUakdVdGRpWUcrUWN3b3hqMnNXWE15cW1iS1dGcHdVU0ZUMi9yMmpPSmZD?=
 =?utf-8?B?ZGZqREFpck8veTRBSm5DTXZUaTE1MXZGU2RIWEdJRERDUlc0ZnFIVjFadWpi?=
 =?utf-8?B?d3RwMHlLVUp4dk5QQ216azh4cmk2aUUrTmRtQUswbzZiMjg5TE1adHVIeURt?=
 =?utf-8?B?ZmxzMy9kSWdoeG15QVBXd0lqdndqRGxJdzIyVWliZzd5dWgrTkxQUU1JN2RH?=
 =?utf-8?Q?GWvWA33yTJkjG4nTf4kD6Gg=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c199ae27-b344-4e06-02ae-08de162bf715
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 14:12:02.0013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FkO5veqKmo+h6c7yZuwhxjVwjhmH4IiRhlNbeSfIBcxFU5WJrGiOWpRioqNBujjBzj48zxixAIfMUzFNpFclMhkOqfDr/JHgDS9SzPrBx/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5880

On 2025-10-27 04:43, Thomas Gleixner wrote:
> Provide conveniance wrappers around scoped user access similiar to

conveniance -> convenience
similiar -> similar

I already pointed this out in my review of v3:

https://lore.kernel.org/lkml/eb6c111c-4854-4166-94d0-f45d4f6e7018@efficios.com/

Other than those nits, the rest is OK.

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

