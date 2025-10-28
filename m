Return-Path: <linux-fsdevel+bounces-65920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF87C15008
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 14:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45F7B4601FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 13:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717DF238175;
	Tue, 28 Oct 2025 13:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="NKAutIQZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020075.outbound.protection.outlook.com [52.101.189.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8E721A425;
	Tue, 28 Oct 2025 13:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761659562; cv=fail; b=YyfNj4F0OXV6kWTFQpUDpFTVTxJ9xleIUZ+LDumBBASYr0QJHHeDdYKCNt6iQH6dN/xETUFw3kk1hwxwpaXpdlhek18txtvn+1TTLnl7P2bIhXnfzy3AYMWjcwUZV5B86UCIgd0zLm1GLcY4MZUTX/XRUhj9grd6E2fS4O0UF60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761659562; c=relaxed/simple;
	bh=0Mp8lsA3W2F/VsIliEQFzCIlF+bZbfsqrvshqc9/eEA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RQyO7KfEA4tCirlWTTUxNXCw05M2kqjf3lhrBOPWRM7mAUc71zO3Qyxg6Ls9TbG3P8JCiPJF+WfNNUFwfzJZYRO9jnNu9pvEsztbhvWrJty2PzmAChaPwqzxWlVbPOpLtJF5+JElJiawubCQP+FpE4Sr4keBdmbuxnrDade+mc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=NKAutIQZ; arc=fail smtp.client-ip=52.101.189.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hoteiYswSm+vEFMx0VqaBI7eQ4pi7e/Zwno56RfNJFY+EUwF1Ak2qP+CFdtzXVI2IrgZFwSA/ZE5hH4pfZKqDqezwglK8H4mcjqUYiPeTt3EF6pRi6j6rjxCxHbWxH3jBchsXJ7udP7wKlaQIC0PAIm6liywRQngasn2jpjjNIc9+XmDr2L0YEiSHzzBPWmQw+9us3dHCnd9dFM1Mtt2ACiRcM2mpCy+rdCehlrhyErgeUaTcebq+2goQUZYx1ceFnTkntMbewWHd5+ybd2uwT+m+pKHo8kc/608hiE5FsPOigurcEg1W5u/659Ica2EpdqGy/5jI7RHP2L83eamig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=779q5W5y2EGWIxu4uaJ9FT+TZVXO+o6wyOHajOZVNt4=;
 b=NCz5pZvzoe3dNkPoqBP1TNmAa48a8IVa6XCSYcw3QbU1PfkFHRqJkDmXUD7DON42m1N4Y+RppEip8LIBiVcz3L6TySFxqvNm8SOBlstqqRppdsHkPUe8WkCk/Nj8vRzBIvdlQxMIi4DhURbm1yaE84PAhSy34agrMEYq15/S7Iq6KytIFNdFw9Cli2mqOO/KEhqiBvoNv49IAlBzKLyrkOBtOt7I+hrWE7U1sKb4XOsc1z5yLPi5aQRH5jcQR4D/bLfMfz1LhuJ3nyuvxGkCaRQ2fXudlmU3XLa3Tv/OnKBmYLK2dMmdAqQu2iEhIbENLhUHPDzzgXCQhMTLXYORFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=779q5W5y2EGWIxu4uaJ9FT+TZVXO+o6wyOHajOZVNt4=;
 b=NKAutIQZiGTTQRA+QAjzzShe7lujxPTEXOoEm9SXveJ7ua/mMsaaHO7dJTyT1xXOHPv5vC+fQt5kpHVR6so0dKBkej22IO4JrCm5PrrMrn0Gp49aZg+5n7O/s9UKbTmKbTZuzn/I+8dyOq500gBhLL9DZi3avmweGgx3+Vf+1kIxlfWOnJ9uCyxImoTn4DYriicxmFv2+XGDYBwA2feecFgdgba8Q8NMt8RAzjscgcrwrdg9f4X12gf7W0l6rlesZPJpy9hN1oZ7ufwy4/pPV9z/lojuaceejps6mhPlstoCkSarRrazIZNIbQWXutZSlj0JaePNjIF2N43IkkhAmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQ1PR01MB11638.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 28 Oct
 2025 13:52:36 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.013; Tue, 28 Oct 2025
 13:52:36 +0000
Message-ID: <05b2cbf0-09a1-4ba4-855c-617dfea867fb@efficios.com>
Date: Tue, 28 Oct 2025 09:52:33 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V5 05/12] riscv/uaccess: Use unsafe wrappers for ASM GOTO
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org, kernel test robot <lkp@intel.com>,
 Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 linuxppc-dev@lists.ozlabs.org, Heiko Carstens <hca@linux.ibm.com>,
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
 <20251027083745.419351819@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251027083745.419351819@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0483.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::22) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQ1PR01MB11638:EE_
X-MS-Office365-Filtering-Correlation-Id: 91935d11-89fd-4567-2d82-08de16293feb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1kzRE8zTEI0ZHUrWjBVWjJ2TkRmZEpDSVBiMUM3dmY5Ui91dE1nV0t0Mkth?=
 =?utf-8?B?ZnFFcllIbTk3azcxRGR2czUycWNOaDhqSTcrMEVjb0ZMdzVtOE8rc2tXMWRV?=
 =?utf-8?B?dHZmbmFsSjdwbWRBNUx0YkVaTGtZa2Z3MUpURi9FYy8vTXNtVXRXSkN4MnZv?=
 =?utf-8?B?VC9KUDd6QXBNWmF0VUxHNm9Ib1lKa09ZckM2K25xUG4yekI0YU9TWkhQS3g4?=
 =?utf-8?B?SVhRSFl6NTF4T2hDL0UyaUN4RTQzQ0lxQkJCR1YwcVIwNGhlUjNJb2dkN2M1?=
 =?utf-8?B?a3NwSFJBeHJmSFFkUVdPbzZTaENzZmJIaklzQU9WVWhSY055TC9tWCtUdnda?=
 =?utf-8?B?ZnBvdHVjOTJpTFdPUjA5QVRDZzYvYU5iMXBnQjh1WUpia1dYbGJvckdWelY3?=
 =?utf-8?B?dHVwTjh5ZWJ6Rm84V2Q4aGM0Tlh0L0FRMjlXOThPaFAxUXllVmtqZWdVQUVh?=
 =?utf-8?B?M0t2VlV0cFFBeWlVMklYRUFNZDNDaTgrenBIZ0MyaGhjbDRKWTljUm1Eb3h2?=
 =?utf-8?B?dExBcHRZYlcvRFhHZzV1dFBHN2V0ZTBEeGdBekF5cEt1RXdsV0J6L3JzMUxl?=
 =?utf-8?B?MkNaTER3MjZicmtYaVNzcVhpcWI0T3NuT29XYmk1MmI0a0IyRGozTmZncmRo?=
 =?utf-8?B?V0R1Z3dGS1AxMkFmSkNTU05uUWswY1dWTjQ4ZGpqdGUvZUlNTzdQQUJpekR3?=
 =?utf-8?B?ZXh2Nm9URW5tTGtYbGdXM0diNzQ5Y3AyMDk1Zjk2THkrelpJZkVsTjNZMkRD?=
 =?utf-8?B?ZlEvVzVOU1BSZFV6R1dMMHZ0cm9xUVVUQ0FuVUFXU2paVVRKeUVFRWJpR0ZM?=
 =?utf-8?B?K2x6Sk8zRUlCb1dJSmNUcEgyMGl3WmNsZ0FvRUo4R0J2aUt1Y3A4VnJCMnF1?=
 =?utf-8?B?dCtRZ3l5ZXVGdkxUZWxFaGNIc3FEUEhzWnVMcFBQV1FENm1zcGhJbkJMN2s0?=
 =?utf-8?B?ZnplSWFxLzdzcEpidFBGNWJqbGRsQ3cwUEF5SFFWUEY0RjJSTG9jY3RLbUc0?=
 =?utf-8?B?SGVrZjFHWVFvRzd2RlVjdFBkWlR2alFQWU1IQkNyOEZla1NrZzJGVGFKNkI0?=
 =?utf-8?B?UUZXS3RBbk40R2NsK2ZhQWQvdVFvcnVvSmcwd1d5ai94ZjdwbWV1dzd0aFkz?=
 =?utf-8?B?aUhqZlVmczlTbDNTTDI1OGY1a0s5TmZ1emRIbUFXWVNNclh2NTQ2OFpMVVVw?=
 =?utf-8?B?eHNPYWRQOThoTnFzc3NwOFJFT1dOcTFGdE1KYWhtZzZYeWJwK1lPbURXR2ZO?=
 =?utf-8?B?emp2S3FMdmxGdzJnTS9sMVdRRGVKZFV2cVRIemxDNE9HbGxMdXZjaXN2bmZw?=
 =?utf-8?B?S0Z5ZzduamFVWjFrSlV0S0djdU11VDBwU1Axb3NZYnFvODNJUUVQRUNVNDRs?=
 =?utf-8?B?bjZxdlZ6N1lwc2kwdXBTQnR0eTdGRDg5R0Z5SHZ0YzROSjdESEhoQ0VET2tW?=
 =?utf-8?B?eUlUWmxRcnFUT29KRC9uYnRZa25LMm5aS1VtNkU1dzB4MGlsbHJ3RDdSZ1RC?=
 =?utf-8?B?QjRrUXR4bU1waGd6WmVzMFExR3VtcmpvR1JqTzhhOVpSS3FVWjZqeHBGZjJ3?=
 =?utf-8?B?NWVrU2N0RFF6cVVMQUNXaTE0UkhWT01HSlkzRm1Qeld5YktJOVdyOUk2STZM?=
 =?utf-8?B?Yk9Gc0hlMzVSVjJMQXVucFdUY0owTk9Za2FudnJKdnB5S1o2Q1hxYkQvaXd6?=
 =?utf-8?B?T2ZkMG0vbnpvaXVjSE1HWEVqSHBpTE9YeDZIRXV1bTZ1UTRWMURTaW8xUHp1?=
 =?utf-8?B?amN5OHA1b0l2QWt3ZnlwSjFkWVFzS1c0UTB1amtFOUZSUGxRMjhSZm5tY2dk?=
 =?utf-8?B?YlRaRVFiWXRlUUhyZ1BuSEFuT2JFQllWZGF1WTNMRU9ITldTa25mY1dUMnB5?=
 =?utf-8?B?dXNqNG00WFFBRm9QSnNldEZGTHNzaEdlMC9xdk1COTZYK0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWtSYjJ2em1WbTI1THZ3L0tQUXU4KzJmQzNyRnBIZ1pENG9LQXBSSjdMS3JC?=
 =?utf-8?B?QkVvMUwySHJtbHE0NklPRnJFLzlVZTRsZm1sQjAwSTVuRnVjY1VLRTBBakNU?=
 =?utf-8?B?a1BDK254akRRR3U2UXV6a25ZUy9MaXFocG1ud1J1Ri9lM0NvdW91bFBMTzF3?=
 =?utf-8?B?WDYvM21pMEszK3lJL2pwS2xUQ3V5dHNVUkJ2WWY5VExmS1RHb1ZzQTF3M3dB?=
 =?utf-8?B?NXNTK0FHck5FMUF4L1JiZVFWdVpoN1BtYkUyazA1SUttUHJVaWVlSlNsZWNS?=
 =?utf-8?B?bTNKdC85czdBbUtTbXVFNktTYkZ5ODdPL01SOHo1N0NyNGpJYk1oMzJJZno4?=
 =?utf-8?B?UkhralB2MHBUOCt0VTZUNHFnRmtrL1A1ZVhNUFIzb2RjSEVZUUFtLzN3S2JN?=
 =?utf-8?B?OTJhaStLZVAvQ3doVUt6bGh2Y2ZwSW41VlBZMGhHWVd0S2VXaFBGNjBkSWFI?=
 =?utf-8?B?bHh6VDdhUWp2Q2pnMGVSK1dhY2JBU3ovNmRyK1d1N1l2bzhOV3Q1b09wUWt5?=
 =?utf-8?B?QlVCV1BiY3ZtN3dvSGVZTXFsUTNESXVsS0EzSXlGVEFKSjdGUXk3ay8zTk9F?=
 =?utf-8?B?VDFFR0U3bVFxbS9HT1lWOTJyUlNzaFJMOGphRkorZW1GQ3FGZ09ITXNENmtH?=
 =?utf-8?B?NjdMRzkwR3BQUlpvZXFuUFZjTmI2UkJvU2RBcURYcHFTWmo2UXlVZHAzd01h?=
 =?utf-8?B?cEZBbmhJSmdoQ2FmTEJHNWg0R2s5dmx6YW9idXNsTFNVaG5nZmsyZDZObE03?=
 =?utf-8?B?M2diSnpkcUR1QUhNRWlMRHR5S3VkcEJZYXFwb2pTZGZodzRVVEtWM2NndmpL?=
 =?utf-8?B?UUJodTBVM0FVbUpvNDVXS3JUaU1wRUhDamxlbnpIU0l2U0RJOFBNWE5lNGFK?=
 =?utf-8?B?ZWRCeFFDRHZhWG5TM3ZSMVBacWJJcVlrS2tYYy9xbmJXWm9SOWJXcjEwOTdk?=
 =?utf-8?B?SVlzY2NUYklybDJ2YkNqODJiVlQxMktIWkZiR2dYNExxOG1sVlROTmJaK2pY?=
 =?utf-8?B?K1hpT0VPOEVmL2JxU3lmS3NSdHJxTkc4RUg0WmY1Z2VMTXVhdEtTaGlSTWpJ?=
 =?utf-8?B?ZVlPdkNuUDZSU2JVU25LbElwVTVmeTNtK2tYTVZ3SGloYThJUXIxRlR2Mlcv?=
 =?utf-8?B?VjU1b3RuMVhqR3R0Y0Z5bGoweGViVkRYTG9NTWZpODYrN1FHZlk3anRGRlVH?=
 =?utf-8?B?QXV6dVVzMDhFeWFpSU93WURsZWRVVFFDbkZNOVNTWk1mZ1hXYS9VQTRGNW41?=
 =?utf-8?B?bENad25kY2g3Zm5wUDRlK3FucGExQlhhMUxuaGJ0ZTlMU21wMHNpdnRPUUtr?=
 =?utf-8?B?eXBFbzZuQW91YnNMbXpKZHZEeDV0amQrK1hORzFWWjdLT1Iwem5WbGkzYVdv?=
 =?utf-8?B?TlZYMGJFQlZrMC9iTWNIeG5YbHNhYmJ3Q1dxWVp5UFBIc3A4dlZqcGdNdXlG?=
 =?utf-8?B?REN5YkUyNFk4UnVMeDhja2thOGxmNUtUY0hPbmRHQ25KcnI0eDliRTlIcUgz?=
 =?utf-8?B?emo2YThZVTFDMEQrbFo0ejBReVB5S3hhdnBwTGxDTDZwcjdCa2xZTkowemFw?=
 =?utf-8?B?L1hCWnpRSjJScjZvaVoxVzhXVTI2RHFiU080UUFVUlFJTHNPTHRCNmhySWI0?=
 =?utf-8?B?dzJ2NTBXL01OUW53YVE0bWVwallsek9iZHdSeG5TVTZ0WGRwT0xIRGZ5MmdX?=
 =?utf-8?B?SEU2R09iQmNXVWdVMVA5M2ZRVlNIdUtndEVpdkZ0WVNQNy95YnJEaHZaNVoy?=
 =?utf-8?B?ZjErZWgwT1E5eEt0Y1YrazY1Q1hSZU1DSkNGRGJiNCt0OWsyekJXcVhrVWVh?=
 =?utf-8?B?SmdrNTUreVUrcVBOaSsvOUFCU2tobCt3NnNjbS9xVEtZTXJ4bm5wLzBmRjRL?=
 =?utf-8?B?SXVhL2hLY0dpb2VPRUY2RnZUQ2xUSCs2dGYrK2lqTEVuWUduN045UVRiOEpS?=
 =?utf-8?B?cEx0UTdpdCt2ck9tb2RyZVpjOFlaMDNKeEFLbmswbkxsMXNhTCs5b21VYW5z?=
 =?utf-8?B?SW1ud1hFT0Q3RDRUdTlwSTJYdEk0ZVkxR0V1Um13clpvZGFCVS80dU9zN3ZN?=
 =?utf-8?B?OUIydHBqZW1nT0wyYTBJb1lPM0JtVTk2M2lkN1pNa1g3R0hLNXlnTHVVRlRx?=
 =?utf-8?B?b3hqVzdGWkdhNGtwaWkyMDBrREJRLzIvcUpZN05CN1Y4eUs5YTh5U2lIYVRZ?=
 =?utf-8?Q?DZPUZLKThWqnPJzBL6Vvpl8=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91935d11-89fd-4567-2d82-08de16293feb
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 13:52:36.0880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: po5Y0dr+Fy4+run0/sqlNexYPd0BEdDdAV/WeNF3o8Y9gAcn318+f8J0eo6fmvgc1Rb8Pq2/cka9puk1AcnGv/xKG57gENT+45zQG1heD/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQ1PR01MB11638

On 2025-10-27 04:43, Thomas Gleixner wrote:
[...]
> Rename unsafe_*_user() to arch_unsafe_*_user() which makes the generic
> uaccess header wrap it with a local label that makes both compilers emit
> correct code. Same for the kernel_nofault() variants.

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

