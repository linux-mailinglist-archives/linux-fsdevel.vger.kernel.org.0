Return-Path: <linux-fsdevel+bounces-64492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E19E5BE8A1D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 14:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95BA95E1A90
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 12:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B83D32D0EA;
	Fri, 17 Oct 2025 12:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="t+m70L/g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020079.outbound.protection.outlook.com [52.101.191.79])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97ECC266582;
	Fri, 17 Oct 2025 12:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760705079; cv=fail; b=lp2mNzaWf8vxEf42Hv0rQ+rtOfR/8O8UFA2+CoUSsaVYEAWVBcp2yMI7J1JRfT5DV/Po3/0xDFRBnR/ZFVgtVS5wOg48eDyKV885bCXnzfPk7AdFVkVGJvB0ErQDTFhnlpJgK0L5Lop3LSBlaz7BElQjt0oAy5Kb3p0UBanWk1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760705079; c=relaxed/simple;
	bh=EiEyOJHgMXD+e6AQ4g80H+Y+cU4VksadKxP+hbKCdrg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=khkmnC4sImrJQvF5HUphdpAa+967ETE7zHrMw7AZt1uJ+vyNRkDcBBtCojZ1xTGDrQn122fqMP4iZnmViGdrVXcPO7CrygcMwm/+39wLw2OskBz6H53/MOb6tOpVV1vvukL/6QE6Z8Y6sv6iJSsUSjL4A2hxaJB8yhH8wcuoNfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=t+m70L/g; arc=fail smtp.client-ip=52.101.191.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pGWkMKtfbjoFNKYPGL2RD3636SjZrh2bC41I27FnJwayZecPQC5i2NDQH+5QHQeXdp3NBmnBlbvU6orL0Mr0BnZ/k4vGhkFCwnqulzYGgRUOEuoIlh0qX5qYMb7W4TTuOpAYhd0CVXsclMvHcvtE3SVBo7MfKX9ircEDKtk9j34C/ScxjGmNQOXd26F8KvXC2XnLhQ/UVcJre5vDUliRq7caitPhGbscFHxR/WWYsMsJMl6+Q0Hmfry6KhgV18Oy01scTdJgZAmj/I1wU5aLcy+fqye7LVGfw9AbFOlL/DNDf/iUD9Q7pwlos800CE/mEOXo0U4TgRDrhNm/AH4oqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7lL24ui0+nxhMM5p76qa4tNXI1E/STEHpsVrjPPsgQQ=;
 b=djD3IhYZS3433esiRPQbrqATyOjKloAcilbVvGf9uIa25MfZjWP1rFD7N56m6EsMLjJW8jhlXJ/KEzULQsayU3YmUAw4D2EaXdf3vWDQF0NnUB0WI2HU8xT/9F6ieHdlb+RkT1VoKt+t0sBZumXa19fAxsKE6OJgTjzOpAcmmy6UcAAAu4W/WN9dMFxGGxJW1/i2gyYIgNL8PoiWp9GycjCtIXTF6cXi4WKYDbZ9KvkAIzznIhXNjanuno5eQStDusKYgD6cj6RdmLPoP4HbqgwFkT0DF/sbiH+CBww0rPdXu/glUhiKDYRiHg7ntLyUaA+vBT8CU/bJlRdmqp6N0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lL24ui0+nxhMM5p76qa4tNXI1E/STEHpsVrjPPsgQQ=;
 b=t+m70L/gR1UWRMH8Vvz7wvKDEcvO9E4mE0C+fsgSBLA9hORnVtwvl28bo6XfsQA9wiRqFqEksLORcGaztMLTMrUbFl6FuCPn898jy7YE20D6x3zNZSk2b3u6269indm9c5rqAUNDHMNzMSz2+UXtts2oQOMd7U8Ini5cJGUCIUEXeZy+T5To3wITf3ztSYUF5wudV9IuNg01qULvehbf/HCvuUBOgwYamVHZ8r7x/SSeOB/Eu+q4FCFIVA53hhtGfVdNtAIyGO1VzY300FdQIX/qLi7WnGAjM0WX0r8C1LltzhN70BFRUBWGmkIA0K7AeeHOhWxAhayXsXwtvKglMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB11694.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:162::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 12:43:33 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 12:43:33 +0000
Message-ID: <dbf58bbb-9315-49dd-bb10-4e05e368f43a@efficios.com>
Date: Fri, 17 Oct 2025 08:43:31 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 02/12] uaccess: Provide ASM GOTO safe wrappers for
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
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?=
 <andrealmeid@igalia.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
References: <20251017085938.150569636@linutronix.de>
 <20251017093029.938477880@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251017093029.938477880@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0076.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::9) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB11694:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bf7ccb5-9b5c-477c-80a9-08de0d7ac85e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXBsUWwyZVl6US9ORW9xNmNOSkZiL01jN2wrenluak8rTW1kVndJaS9RWXBM?=
 =?utf-8?B?dFVvdlliRmM2Zk9hQlh3aWd1WXpnbVJiQllSN0phSjhwaXBYOTlDaENZb2F2?=
 =?utf-8?B?cTlBYllzZVdvRmJTWENPeGdGMVBTbmdCem5HY2tSQTZiQXB2ODQrUGg2Umxp?=
 =?utf-8?B?djNldDNtcHcydmhrcjhYTnpIZHIzOWZIVkxrcVBUcDRVMHRNL0txMzdKSVFs?=
 =?utf-8?B?NUk5QnlQL0Fabi9HS2hmRGxSQlFxaG1qekttUzRMMjNlQkg3U1JtdlE3WnM4?=
 =?utf-8?B?Y2lzS3haL1YrYldIa3pTcENrTlBBQ3g2L1F5Smgxc1AvT2o4bkI2Zy9yVEF0?=
 =?utf-8?B?aC9XQmdiRlFIbTF4cjJDcEdQekFSWlY3MXRvbW9YMXU5TzZ6SGQ2bFVjci9J?=
 =?utf-8?B?NHM4dUJKRGlKeElJOVdTZG1tUnQ2Z29nUzlRQVhDdTVodzBvQmpRaUZJRnJJ?=
 =?utf-8?B?WFFPQ0RhT1BHTkFBTE9aQ3dVdnZVVVk5bTFOYWllNEtBL243Vjczbm5vaVdW?=
 =?utf-8?B?YktXWVBPak9mM3FjU3VPb3VubVg5N3Ztb1RiNTYzeStVdDEwV0FJdmxtR2k0?=
 =?utf-8?B?SVZpL0tPTjRzUjlxbWQxZHpKV2R4WE15azRvdzZRRVRRNWlNKzRGbzhIeExV?=
 =?utf-8?B?eEQyalczRmVtYS95dWZMU0k5MEdjNnV3L3ZVb200L0FENURtK3FpdUM4T0VC?=
 =?utf-8?B?SjUwa0xIQmIxRmM5bHlsc2NNNGFLei9nR0c3dTBvNStGeXhQMDhWbmdrczB1?=
 =?utf-8?B?cXdaYzFXeVlyN0ZBMTk2RDRwOWVRYlFuc0ppNFNZcVVNaDJBT3VUM1FOOTFl?=
 =?utf-8?B?ZlFwL21iMDVTNTJWRzZGb3orTHVKbWNTTnRaYzZEQWpwTjREVk1tM1FmcjY4?=
 =?utf-8?B?TzVqZlV5RjhPS25KSW5oclJmd1d5QnV5aXZiQjBkWUROVCtyTElxczJOdVUy?=
 =?utf-8?B?RGFZWFlQRmZjL0JVMUoxOGlGdGVPYUZMTDVPL3FFaWEvSE96ZjM4c09BTm5B?=
 =?utf-8?B?cEM5WVFxd01sUVViU29TVjA0U05QeXRiV3UxVWlVeHE5M2pjN1FPTGc4Qk9s?=
 =?utf-8?B?dnArd0VpMFVaWUQ3bnhXWjJQZEZWcEpZRTY3TEtRcVkvRHJoVnF4N3YyUjd2?=
 =?utf-8?B?aFpsYlo4QndqSzkvdWc4QU1YeFdzNm1JQmE3a1UwY29Da1RIVC9CTThBVXI2?=
 =?utf-8?B?cTBHaUdPd05RUnNORi8vTHpGVkVLMXR4RHdmM1ZRamVxT1E3YmNtUHNIOFN3?=
 =?utf-8?B?SVhzNDhlTURhT21HK0hpYVI3UGZkZ2tKWm8yV1YzOTI3QSs2ZUVLVUlMcW9v?=
 =?utf-8?B?emdUK09pWjBoYksyZ0RYSEdzZkUyOTl1ZVBJd0dFSDBhZUJWb0hmQks2Zi9L?=
 =?utf-8?B?YVZaWWdndDlHUlZsNDZwcVRVQ0R4aDdkSHAzUFFsVFRqTmVlSFRObTFUY0t0?=
 =?utf-8?B?UnJNQVFLZ0ltbXBrck0yNEVBdkY5eThLeW53Y0FkY05xQ1ZGS3lscFY2Nmwy?=
 =?utf-8?B?TTVxUVc5Z2pTUmJJNVBHWEJNUVFpdDc5c1JGNFh3U1lQamIrWGtwNHdkb0Jv?=
 =?utf-8?B?ZzVOMmJxOWhpTjZOYXhZR0E3dXFSYlRpUEZDT2Q0NFFzaVpGbno3bjNQRy9J?=
 =?utf-8?B?UDdwTzg2YVJnYUlPSWNoYWdMRDluVXlDcEdJT01xNjl1RmVPMmY2eTVVckpV?=
 =?utf-8?B?NGlCcktjVEVGRHpab0M1ZWt2bkt3cWNpY0p5amo5ZW90MmpReWZMWHRlbFRy?=
 =?utf-8?B?NU9heDJmZGlwZllIR2o1L3A5KzRwNlArZmFibzM0SkxLd2IybXZ3Q0hpMjNF?=
 =?utf-8?B?Q0g2T1hrQ3YyYVdsM0Y0VlFqbjBDRnQvSFRhRms5aDdnMDZBQWUvN25uQ1Bh?=
 =?utf-8?B?SzZQeGJ5SThCc1VzKzhKdHVGZEszaSt6MUhlaXhuWGhseHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STdNSk11VzhKWGFIKzhpL0Q2UTBNSkVxQnptVWRIbkRNL09hOE1YZjdJUk05?=
 =?utf-8?B?bXU4dm5NemprQXo2V3BuaFc2anBUaG1rOUkrQmJMaEM2MTIxUDlsNEZ1YzM1?=
 =?utf-8?B?bCs0L3JXekllRmFua2VxaUdqeWVWTlNibUFTRkVNWUtRVXBrS3N6ZktBcU5y?=
 =?utf-8?B?eUJZNXBCd2dkR3JHdTBaZHVFb0hucStmL1ZnRXZuSlZ5NHNsN2J2MHNWMmI0?=
 =?utf-8?B?Rjk0cXBtcnpzdXU3NjRZWGVmY3lZdGVHL1AyYUhaNDNqazg0VGdtNnY1MTFW?=
 =?utf-8?B?TEkyMkE0TVo0VzZvM251M3RiS1NRYWNHNHdQOVdLQkpSOGg0Snp5ZFZBRlpL?=
 =?utf-8?B?ZUpMS2hQWm12S1lJZUZUNk9hUDhoWWNXUHBIS0NPcGxOVE8xVDZHeUhpN1I0?=
 =?utf-8?B?RHh6QUoySFRqNmVaVG1wL2c1YnBsOFpXV2JjLzcvOHZVQTFaVjdaY1loMHpQ?=
 =?utf-8?B?SWE4QzZjSnBtT1ZXNWsydFNlMmlDbCtBMXZWU2lLT3crcW43NE5xT3h1blpz?=
 =?utf-8?B?UWVhMGFIVGZNN0ZEZlFvWFAwLzFpa21EK1RWMzFBRVJwcWVVVzlrcFd5RjlE?=
 =?utf-8?B?RHlUM1Fqb2kxSkk5QUFyK0F5TkZZSTVNVmZaRVBBN0xmZExCT3h0TG5sclAx?=
 =?utf-8?B?YUVVMlhpdFF3bEptL3FXTWo3VkY1RnpIQmNxY2JQTU53QUlBd3lSWDJYNnZG?=
 =?utf-8?B?WXBTRlpFd3dnOGgwSkdPakt1Ryt5c3RmaXNobzlWR1RzTS95M29wa1NlVk5a?=
 =?utf-8?B?bnVWUzNGSEU4Z1J4eWpGWGhpU2NoZmJ2YXRxUDAza2Q2c1RrMkQ2bkRYakln?=
 =?utf-8?B?YXFHYVByQWVWdkNIeUNoMnhNZ0pDaFFMeEVFcnFUTFZLenBKbXF2bjc4OXpa?=
 =?utf-8?B?eXVhYmRtZXJUcnlCak12WjkzNTJTUDBoMGxaQXhhdDhYUFFFTEJyT2xBL0lo?=
 =?utf-8?B?VmZRc2QvUG5kTW9Eanp4K1BvSlNTc2tBYjlnbXFHTHpNVEg1UXJXZURmZm1y?=
 =?utf-8?B?bGZDY0RHSC8wVWYxU2lNUjQxdTBha3paeE14TGtWVnpSUm5QMEo5Uk42WEFl?=
 =?utf-8?B?eGlVc1hNS0pxZGtRTk1WYjRGb3Q1VE9oOEZ2VER0ZUNhZ3JZQjhwQlBRdEhS?=
 =?utf-8?B?MXdoUnBxaTBWdzJkaWdwZ09HS3RGZHBuOEFMNEtSMVIvdURybkx1YWMzQm9B?=
 =?utf-8?B?WXp6K0MxV1BmV0s5OUJqRER3NTVVbXBadGZDa2Q4Skx1b0c2bUpYL0dKa1g3?=
 =?utf-8?B?S1V5Y1RndUEwWC9qdUZ1NXdaRGRMVTlDQkZLeEJZaU80OSttdDN1d0srZjdJ?=
 =?utf-8?B?RkNlU0xSRVJCUmdHbzlQNEl0U0RQVTQwaTJzMFd3aGU4S1V0QThibDA3SC9O?=
 =?utf-8?B?STFjcmJsRjRVLzEwcmg1RFN5WkhQZit6Rml2YzlxSmlTUFNpUlM3WHhvU3JJ?=
 =?utf-8?B?Ym1TRzJHMk1ISEJjcTJldlNzZ1R6dVcydzJ5Rm0wb3Y0K2hicWxNRUZXWlBW?=
 =?utf-8?B?WjNUSUJ3Q013SWk4VlB0Q1JDWSsyYWI4dFRrT284SFB6NDJueG1QYWk4OGhX?=
 =?utf-8?B?bnh1dnMvNUh0OU8zMktXUUJSeGJ2S2FWSSsyMzZ0U2NDdG5hWHh1ZDMyVDNv?=
 =?utf-8?B?SXJEQ2F5a3hEN0xLU1hmeU1mRGZsczJPZDQ2akdVeFZIanNBUTl6cUVqS2lH?=
 =?utf-8?B?UCtTdHYvQ1pUdk9xcWV5bGswUU93M1Qvc1MyajFJMXM5VTc0djloVEViUVhv?=
 =?utf-8?B?cXJrZnVFd2s0MkQ2cnlTeTFoZTBHMGN5VG5ENWNXalFNQTRCUnBnSTMzRWUz?=
 =?utf-8?B?bFlqUnc2c3BWUzVvMlRXb0hQQkxvNlB2MjBZbEo0Nk9tVnhDbG15WkQ3Zmow?=
 =?utf-8?B?R0NmbldtREJNa1llVC9NeDkxbTBTOXdkVWpSOEZ2aHdqTDNMVEZSa0NBNkYw?=
 =?utf-8?B?MWhlMHErbDVuUnF3YXE2azN0Qk15Q3p0TFhvd2tQT2J6aTZvcENiMWNxN3pH?=
 =?utf-8?B?Y0RVSHVrbkR4U2pWekErQks5Qmp3ZlEvcWl2MC8xQmpyRGExcDlpS3p5WTZT?=
 =?utf-8?B?MThzU0RHQUtDVHI4cktONVQyZlpFSjFLSTFuMG1hNG8rK0FZZjkvRERGUHJM?=
 =?utf-8?B?TzVMUzdtODFMdmVmemJFOGRjdndWc2JGOWRIUExEZ0R4UEdwQzgzS05qOXYr?=
 =?utf-8?Q?SHnaYOYztZHBdTVmniz3RJs=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf7ccb5-9b5c-477c-80a9-08de0d7ac85e
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 12:43:33.3737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /wCDtj2uivzhNPxbY+fISBwqnuILZ6A2VH9fjrNosOTDl+pg09v+95P6qr4kestHc84NZ5/8PtKzhywhUmM7bxJRgZ8i6Def4ZIOFVsANqY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB11694

On 2025-10-17 06:08, Thomas Gleixner wrote:
> ASM GOTO is miscompiled by GCC when it is used inside a auto cleanup scope:
> 
> bool foo(u32 __user *p, u32 val)
> {
> 	scoped_guard(pagefault)
> 		unsafe_put_user(val, p, efault);
> 	return true;
> efault:
> 	return false;
> }
> 
>   e80:	e8 00 00 00 00       	call   e85 <foo+0x5>
>   e85:	65 48 8b 05 00 00 00 00 mov    %gs:0x0(%rip),%rax
>   e8d:	83 80 04 14 00 00 01 	addl   $0x1,0x1404(%rax)   // pf_disable++
>   e94:	89 37                	mov    %esi,(%rdi)
>   e96:	83 a8 04 14 00 00 01 	subl   $0x1,0x1404(%rax)   // pf_disable--
>   e9d:	b8 01 00 00 00       	mov    $0x1,%eax           // success
>   ea2:	e9 00 00 00 00       	jmp    ea7 <foo+0x27>      // ret
>   ea7:	31 c0                	xor    %eax,%eax           // fail
>   ea9:	e9 00 00 00 00       	jmp    eae <foo+0x2e>      // ret
> 
> which is broken as it leaks the pagefault disable counter on failure.
> 
> Clang at least fails the build.
> 
> Linus suggested to add a local label into the macro scope and let that
> jump to the actual caller supplied error label.
> 
>         	__label__ local_label;                                  \
>          arch_unsafe_get_user(x, ptr, local_label);              \
> 	if (0) {                                                \
> 	local_label:                                            \
> 		goto label;                                     \
> 
> That works for both GCC and clang.
> 
> clang:
> 
>   c80:	0f 1f 44 00 00       	   nopl   0x0(%rax,%rax,1)	
>   c85:	65 48 8b 0c 25 00 00 00 00 mov    %gs:0x0,%rcx
>   c8e:	ff 81 04 14 00 00    	   incl   0x1404(%rcx)	   // pf_disable++
>   c94:	31 c0                	   xor    %eax,%eax        // set retval to false
>   c96:	89 37                      mov    %esi,(%rdi)      // write
>   c98:	b0 01                	   mov    $0x1,%al         // set retval to true
>   c9a:	ff 89 04 14 00 00    	   decl   0x1404(%rcx)     // pf_disable--
>   ca0:	2e e9 00 00 00 00    	   cs jmp ca6 <foo+0x26>   // ret
> 
> The exception table entry points correctly to c9a
> 
> GCC:
> 
>   f70:   e8 00 00 00 00          call   f75 <baz+0x5>
>   f75:   65 48 8b 05 00 00 00 00 mov    %gs:0x0(%rip),%rax
>   f7d:   83 80 04 14 00 00 01    addl   $0x1,0x1404(%rax)  // pf_disable++
>   f84:   8b 17                   mov    (%rdi),%edx
>   f86:   89 16                   mov    %edx,(%rsi)
>   f88:   83 a8 04 14 00 00 01    subl   $0x1,0x1404(%rax) // pf_disable--
>   f8f:   b8 01 00 00 00          mov    $0x1,%eax         // success
>   f94:   e9 00 00 00 00          jmp    f99 <baz+0x29>    // ret
>   f99:   83 a8 04 14 00 00 01    subl   $0x1,0x1404(%rax) // pf_disable--
>   fa0:   31 c0                   xor    %eax,%eax         // fail
>   fa2:   e9 00 00 00 00          jmp    fa7 <baz+0x37>    // ret
> 
> The exception table entry points correctly to f99
> 
> So both compilers optimize out the extra goto and emit correct and
> efficient code.
> 
> Provide a generic wrapper to do that to avoid modifying all the affected
> architecture specific implementation with that workaround.
> 
> The only change required for architectures is to rename unsafe_*_user() to
> arch_unsafe_*_user(). That's done in subsequent changes.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Adding a link to a gcc bugzilla entry may be relevant here. Ditto for
clang if there is a bug tracker entry for this.

Other than that:

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> ---
>   include/linux/uaccess.h |   72 +++++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 68 insertions(+), 4 deletions(-)
> 
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -518,7 +518,34 @@ long strncpy_from_user_nofault(char *dst
>   		long count);
>   long strnlen_user_nofault(const void __user *unsafe_addr, long count);
>   
> -#ifndef __get_kernel_nofault
> +#ifdef arch_get_kernel_nofault
> +/*
> + * Wrap the architecture implementation so that @label can be outside of a
> + * cleanup() scope. A regular C goto works correctly, but ASM goto does
> + * not. Clang rejects such an attempt, but GCC silently emits buggy code.
> + */
> +#define __get_kernel_nofault(dst, src, type, label)		\
> +do {								\
> +	__label__ local_label;					\
> +	arch_get_kernel_nofault(dst, src, type, local_label);	\
> +	if (0) {						\
> +	local_label:						\
> +		goto label;					\
> +	}							\
> +} while (0)
> +
> +#define __put_kernel_nofault(dst, src, type, label)		\
> +do {								\
> +	__label__ local_label;					\
> +	arch_get_kernel_nofault(dst, src, type, local_label);	\
> +	if (0) {						\
> +	local_label:						\
> +		goto label;					\
> +	}							\
> +} while (0)
> +
> +#elif !defined(__get_kernel_nofault) /* arch_get_kernel_nofault */
> +
>   #define __get_kernel_nofault(dst, src, type, label)	\
>   do {							\
>   	type __user *p = (type __force __user *)(src);	\
> @@ -535,7 +562,8 @@ do {							\
>   	if (__put_user(data, p))			\
>   		goto label;				\
>   } while (0)
> -#endif
> +
> +#endif  /* !__get_kernel_nofault */
>   
>   /**
>    * get_kernel_nofault(): safely attempt to read from a location
> @@ -549,7 +577,42 @@ do {							\
>   	copy_from_kernel_nofault(&(val), __gk_ptr, sizeof(val));\
>   })
>   
> -#ifndef user_access_begin
> +#ifdef user_access_begin
> +
> +#ifdef arch_unsafe_get_user
> +/*
> + * Wrap the architecture implementation so that @label can be outside of a
> + * cleanup() scope. A regular C goto works correctly, but ASM goto does
> + * not. Clang rejects such an attempt, but GCC silently emits buggy code.
> + *
> + * Some architectures use internal local labels already, but this extra
> + * indirection here is harmless because the compiler optimizes it out
> + * completely in any case. This construct just ensures that the ASM GOTO
> + * target is always in the local scope. The C goto 'label' works correct
> + * when leaving a cleanup() scope.
> + */
> +#define unsafe_get_user(x, ptr, label)			\
> +do {							\
> +	__label__ local_label;				\
> +	arch_unsafe_get_user(x, ptr, local_label);	\
> +	if (0) {					\
> +	local_label:					\
> +		goto label;				\
> +	}						\
> +} while (0)
> +
> +#define unsafe_put_user(x, ptr, label)			\
> +do {							\
> +	__label__ local_label;				\
> +	arch_unsafe_put_user(x, ptr, local_label);	\
> +	if (0) {					\
> +	local_label:					\
> +		goto label;				\
> +	}						\
> +} while (0)
> +#endif /* arch_unsafe_get_user */
> +
> +#else /* user_access_begin */
>   #define user_access_begin(ptr,len) access_ok(ptr, len)
>   #define user_access_end() do { } while (0)
>   #define unsafe_op_wrap(op, err) do { if (unlikely(op)) goto err; } while (0)
> @@ -559,7 +622,8 @@ do {							\
>   #define unsafe_copy_from_user(d,s,l,e) unsafe_op_wrap(__copy_from_user(d,s,l),e)
>   static inline unsigned long user_access_save(void) { return 0UL; }
>   static inline void user_access_restore(unsigned long flags) { }
> -#endif
> +#endif /* !user_access_begin */
> +
>   #ifndef user_write_access_begin
>   #define user_write_access_begin user_access_begin
>   #define user_write_access_end user_access_end
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

