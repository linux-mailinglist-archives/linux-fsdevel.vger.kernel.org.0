Return-Path: <linux-fsdevel+bounces-65916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8F7C14F27
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 14:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 477A51C221DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 13:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AEB334C2E;
	Tue, 28 Oct 2025 13:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="AM/pnHqp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020091.outbound.protection.outlook.com [52.101.189.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE76830FC3C;
	Tue, 28 Oct 2025 13:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761659104; cv=fail; b=fkAyg6WbPy3dvaUiURfzFpYTcT+URnCMPdyAzNkXkqeCfv/6byAYZc44FDvru991hEABuIXObvC5qTpv7hy9GdXQlC2Ni8Vy2Sg3WF3JCcWXCcIkT2ViYOVX5ROdoF7YQlURkwY9oZVsI8qLLY4S3iHJYrEuSAQEgDOTD86zSWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761659104; c=relaxed/simple;
	bh=uLSOCeikEQUaSujYiC2+2oR+8igbDdCQkN4JScG+avY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HC1QmoUtqrZS1Nbuluumqqc6NzCOjGGev3b8N73JUr4KHh+14DcTOGP8K/K6+2t48VV2JDan+zUkKx//yn2gPCApanfToOJfkzzXxDVeHtgfMYMlY6Y61cB3LOYXq+Kwi1l0X7KWoiuRUwiUQDeMaE7gSLSCKTHWqdqcR4yhjuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=AM/pnHqp; arc=fail smtp.client-ip=52.101.189.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GTZsG7z1IilAXqe9f6QhzHg1Vs8L/PXZy9laaU4g4jA2qsXKnDuVAosHRc+BmoCLSqvHryXlHWi3BzuKzcOdJk6gscr+X6mfw+FfV1pYlE1SejaanZOaBa4STP+jDinnKCFWB+kdk14GzVoTZmFkpEWI/IX9DuKLy9hFslY+nkgzSqYmfiF7HzYvkqH914ffHC4tQ2tcSKjZv1mom82hUxb1p4Zz/NNVCu6SaV1AI4kJsq8YTiiWwRZf49SHTZyPSm/fVl9biZwXTfjEi0efusGC/2zh7C8pjoQhDYmUbv2LK+ue6jbDV2DoWlpfHjs7tE8MCIAuqgUePyJyTVkr6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUe2MhJ10+D12UJ287UAFiv43P6keFhcdqsbMqI/nWU=;
 b=k+0PRpANl3M0mnJRduCfpOxtLFejnwOpcloXY49svbbbZIvO1QrflA+8hdvJseLMNj0FhimwvPlnXm4SzXW6kcx3nKJwDj8EharGNEZGQ6VXMSf4lr2/7PL2PAAvQZAJ8hmpeKCPRb5WWkg0FLFZ5dXPnF/rB5tWmpWm1KZTd+pW1VhN8HC6L0iBWtE7uga3fv4KfMeBhXsQ5yi/nUy8WB6JHthVoTfkYeJ2aPZF80GqKKmtSXpbs9nz23sEcGghDZotBC7mTT51uMBMNOuceLUb7oul0Sy52OeKinRkwB48BM5Tuxxjdp4vP+kkgD37bGdwWhl0+r56+lMUUv+H0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUe2MhJ10+D12UJ287UAFiv43P6keFhcdqsbMqI/nWU=;
 b=AM/pnHqpdVGvg7bLruXrrvbF8TJ1XfO88uOuy+fRxsBu0q7ObS77fHvX/ohYIn2YV1zs/HLLyEgarmmYOuEkOQaApu7VUgOmizop5IMzQhcfH0HgFr1eBL/9/lWYAsDjGU+Q8BApCn0lOF06++VC9FxSNBe+/XIXUzmwJ8N0mMgA7CWEtie30FjPBBYncIbkxXxnh/u5IEpKLCHOK/XGd3vz7udnnkG2p6OzV9yAxINPxmZl0CzDvCCyNnp8gGrM+hWnKyy0ZTr8LrySDPd5LKz67ndtAXs1TYLcZEbwL8xSdwDfVcJb+TgeMeXVAbCg5HJ+Fgxvq1mDjf7CCCgAzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT4PR01MB10358.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 28 Oct
 2025 13:44:59 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.013; Tue, 28 Oct 2025
 13:44:58 +0000
Message-ID: <f5367784-d2fc-4c44-8757-722c4f87a690@efficios.com>
Date: Tue, 28 Oct 2025 09:44:56 -0400
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
 Andrew Cooper <andrew.cooper3@citrix.com>,
 David Laight <david.laight.linux@gmail.com>,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?=
 <andrealmeid@igalia.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
References: <20251027083700.573016505@linutronix.de>
 <20251027083745.231716098@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251027083745.231716098@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0223.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::15) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT4PR01MB10358:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f833765-939c-4500-ea6d-08de16282f3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDdQTkxUT2hxT2g3V05tbE9ZYWxsUXkrSVVteHQwdGhsZXE5NWg5UUY0T2Iv?=
 =?utf-8?B?aFJPK01MRHhVSmdYOEZDbVJGQVdXQ0FadlBQbFg4NXovNlJ2WFVhaVg2aFlm?=
 =?utf-8?B?VEdqWHFIeTVhVktVRTFQM1RhelRoeEkrRndJWmV3aFluMnRkNlpLMC9WV0RI?=
 =?utf-8?B?TU5oK2VzM1d2N3pSNkoxWDVBUW9INEZNQS8rMWdPTGpHZmlseFJTWUp3ZGJI?=
 =?utf-8?B?R0RKQUNrQlNSTlh3YnFrb1cwbmtYVXczMFMrOUh1TWtPQVV4Mi9YYUlucE9x?=
 =?utf-8?B?Q09TeXZGVHk5UEh2MFRmK0NzUGVlQnROeE9lMG5Ia1hyMi9jS0RQcnEzR0hk?=
 =?utf-8?B?VW9kS29ZWERFTHA5S2xrT0JuVlg2YTJvS2FvN1JVbHZKOExmenhRNHdUYW9j?=
 =?utf-8?B?ZVhqWmNSNUpHWjNSTGdVQjlWMVRSdEU5MDdqVmlyMWo3MmNleTFVUTlUd09j?=
 =?utf-8?B?UElnS1V0YUJkZU9ZS3VlQzJHNmh5WVdFY0dUTXlNN1dSUVd3RUNRRjNBQVNZ?=
 =?utf-8?B?NlQxeDNCRi9jNWZaK1prZlVkTDM4V080S2NrMzdINGcyaGg4RlY4eWg4TVdu?=
 =?utf-8?B?ZVB5bkpqMzgvWG1aa0tNRkthOXIvci9zZ0ZxVFJabGJhRWFkYWZ3OUl2Z1hC?=
 =?utf-8?B?YTBDVEI3eTU0ZFNxN2xPeUNJUGxyTVMrWk5STUlkUm9pd0RHTlA5WkVLVDdW?=
 =?utf-8?B?ZXF6VDdiMnd1T3FiTFJ4M1FUZ0pDYy9lZFNrMXRCVVBWMXUwaGV5UDNTazVM?=
 =?utf-8?B?OERFeFZIdlZobkxhVDVOT3VaQnFIMHpia2w0NTFVa2xpWWw1OG16UU1qU2hX?=
 =?utf-8?B?dmlCdlRTRkdjQ1R3RUtzb0lBbFc0U1pyODZuMlVxSnRhTGdLcjZZempCQVdC?=
 =?utf-8?B?eWtpbitEcmNFaXVwQVpMV05GRWFQcUt4UkwvbHc3N1FlR05aK0luYU1WdGhU?=
 =?utf-8?B?cFQyNzczeElJZW53NW9PWmNWZ3BWdmo0SDdiMWxxNDVOL2N4eFNRcDgvWTFG?=
 =?utf-8?B?N29vcDJ4WmJDYTEwVU4zaW1pOTlTNTJLa2p4dUgvOGVRaU1LWkdBNjEyNmwx?=
 =?utf-8?B?N3MzVld5bFk1ZmFPVUlDeUhDaW5rdGZ6dDR0WVduRlhaOVgrc3BpTFh3M3Rm?=
 =?utf-8?B?ekh3UW0xNU0xekxScWVPcy9nT3MrdDlKM2Q4OXdBQ2VXM1RZRlhVaElvRWlq?=
 =?utf-8?B?blpwYXp5bEJFSVFma3k0Z1g1N3hhNWN6dm91QTJXMEk4ZlhTZUVTakpWQm42?=
 =?utf-8?B?YkVlQkdIdUlJTkIxY1dLNDgzaVVnd2NqWkFLelgvQUZQR0VUaHFPR2NIeEZx?=
 =?utf-8?B?RlFTY1VKSlB6ekpyMXlMcGFVUjdQaTBTM3ljbHpvVUwxdTNaL2JUcGJpUXpJ?=
 =?utf-8?B?bmx4RW56N1JlSmZPTWVMbGl3RDZoZGRaU2NvTkMvR3JRS05FM0dCQXVkZnBa?=
 =?utf-8?B?M09yZlQzdGJ3ZUhoWVNpRDdDN20zL3dydkNRaXZCV3R2N2oxWURoUU5XMkJx?=
 =?utf-8?B?ejFFeHdjNTdnbnZFSWQ0dTAzb2pheTFSdngvTVBVVXB1U3FHdURTZjVoSVdI?=
 =?utf-8?B?L1ZCRUJFajg2Q1c4ZkhhR2VkNlM1dGtsQXNHRnF0Nlk3WU9CSjJ3aG9rNWlJ?=
 =?utf-8?B?ckg2VEppL3JUTXExVkJTS2gvdklrM3ZrK2VUcW5zMTlmLzlVTHRqeUNSRTds?=
 =?utf-8?B?Mit5Uy9xZ3I5WThsY1p3Ylh0SDV0UHI5RHdkVmZoNTdsMnRzQVppQUhoR1U0?=
 =?utf-8?B?UzJTa203L012QWFXLzcrZWcrL3ZhV3ZhNXJpSEdLTzEzVjR5V08xeVlUTFVn?=
 =?utf-8?B?OUw1VTNUYm9KV1Frc1hoYWhRNmE0UURIU0N2Qk1MK0tmckpGeEh5dmw0T2lz?=
 =?utf-8?B?WGJsaDdtakV1ZHV6YmQvZmkvV2hBV24vUml0RGw0V3hKMEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2dTY282Vk9ZK2tvdktzaHkxTzVBTWp1c3VJTmJtam5VUEcvMUs4bk5vcGdj?=
 =?utf-8?B?dFVCMDRuZy81bzlZSlFlby9hckZ5RnpQb2g5SXV5TzVselUrbElZRU55ZTFv?=
 =?utf-8?B?T2dISjZuSUcvc1RUaDlwUjdvQ1Z1ODJQa256cWhscGN1dXlwK21ZNUl1SDFR?=
 =?utf-8?B?Tk9MU2d1MjZTYWJYVFJBWmtyS25uT2dIOW1Gczh3aVZ3c0d3R2syMm5GZ0pt?=
 =?utf-8?B?ZTd3OUdsTDhyKzFsREQ2dzRFcG5BRUhWRkxZUmVORnF0VmlJbTA0d1FVYXVp?=
 =?utf-8?B?cTR4dm5KUVBVTXdFVExmdVpzRGJvWVg3eWh6VVZlNUloTEZTaFRvcDFpRWQ5?=
 =?utf-8?B?ZjZqSUlBUUljYmI2WFRsL0U0R1FnTWpnNGVsK2xBTTloTEYyN010STB6WVd6?=
 =?utf-8?B?SlVWakR2MFQ1RE9UUEtzamZINlU5SEpLYklaZGtUSUI4WGw2RzN5bmZjU3BR?=
 =?utf-8?B?d0hyQy95L2dMTXZUbzZVOXMybVAwY3hlQ21icEhobThXc3NraHNDUCtJc1FO?=
 =?utf-8?B?R2RXOWtTaHFTNjJuVjB0UnVpZVhMN1UvSzhXeXBNalhMTTZBRFZLWnFFMlBY?=
 =?utf-8?B?dFV4YlBVYmdxK21ha1VoRjBZYTRLNzVuaXhhbDNRWjhvZVQzeFVnTGZXN1NK?=
 =?utf-8?B?RW5jQkJnQ2MyL0JIMnMwaHo5VlFxdkkvYXlaQVpPNGN4Z3M1WU1Xbmp4YjRU?=
 =?utf-8?B?cmtUOEZjQUliOXNia25PaUVxWkRXTDBQdmRwM29uK09CazM0SFFzOFhoY2FX?=
 =?utf-8?B?UWxCbzRBZ3JQS2QrSHJWTjd1UmlFRVRsNlJpQkM4QTRHNmNORGZnRldsVmp0?=
 =?utf-8?B?bDRIb0RlUHJTWTg3bTVzSGRCWVJhbHh6TXk1SlU2VmN2UXM2S3hBYWNqMmtv?=
 =?utf-8?B?V0xDejBqb0RaanM5ZExINDNJQklqYkJ1ZkNPSnZqK3ZTMDhZVWJmbTFRWGx6?=
 =?utf-8?B?SEdUS1JUaVp3Q2djaS9FS3JLbVF3Rml6ZjBqcnhhQlNJZmFHdFhwR2ZwOUQz?=
 =?utf-8?B?VEJQRWRldWJIS3R4ZCtVNFlDWDhvaWg2U0RxaWxWR2UzV01GL2ZqQndxS2RL?=
 =?utf-8?B?ZGsrMmRkTEM4VEtyTzZONCtUdmJBK1ZyNmhWWkhWekFCcHdZRWN0bXpQSlRQ?=
 =?utf-8?B?VmhGY3hyeUViOHNRV3FkMUcyamlwS1NiTXk5QUdKRHZENWhYNkZYT3NtQjds?=
 =?utf-8?B?Mm1uRkc2dFRWR3IwRVZoUXpSOStRa2hCTG5sRDJnOE1XZDZta2hNaEJaczBn?=
 =?utf-8?B?ZFpwRC8wMDViTlp1cFV5SzZ0azQvcXdIMkt6Z1RtMGovODJNam5ZMWNaSGVy?=
 =?utf-8?B?WGRoQnh2bUZHMEU0cG4zUUc2Z2hWQy9PcktDTk5LTE5ZQ0F2YWZLRlFpMXJR?=
 =?utf-8?B?QmhtM0NqQ3BIMWFKS1BtZS9udmNGcEYwanJVMDRaVk41Z3ZuZkM3S3Rxa004?=
 =?utf-8?B?eDUySFVGOFVrU3U0NC9zQTRmUldjUE5icTNhOEQvRTZxTGxsVWFHNDJaVFZh?=
 =?utf-8?B?dHRyMVJyM09RMzNITWtvbzFYUHpraU52ZFE5Uzd3UExITDZWNVZuZ05odTdL?=
 =?utf-8?B?WXhUY3N5QTdsNlRvYUVjNlVXWmVJaWdYcnZpWUhxdkdDUmRzMkhzcFFZUHNP?=
 =?utf-8?B?YUhmV3FnSGlaTjRwbVlHWnk5ZXV6c3FiYXVnUDVYOW9SaWJRbEt6VXNxOTRH?=
 =?utf-8?B?T0syWm56T29CN1VBT3ZjZ1d6YmlYWjE1OVpxQ05sdDRYOWZoVE1jSGpTNWsw?=
 =?utf-8?B?cy9tWW5MSzJ1dWNNdnlaNlFlVVc5QWd0b1VyenlMSEJ5aGh1YkExeVhSMlhC?=
 =?utf-8?B?ZFFlRUVyTm03SkR5S1RXLzZZU1NJdDZYWFN3TWhNcXR4ajBBYUxZcHo0Mllo?=
 =?utf-8?B?WGVZMWNUNW51cVRHY0R3ZmR4M2NZRGZTaFVMUUlFSHRlOHREVWdSY3llZFc1?=
 =?utf-8?B?REZsb0pKSDR6dDR3SGVLNTg5enRUY1BJbHMvQmJhVEJzaE0rNVdwSS9wY1cz?=
 =?utf-8?B?V3JVSDlFcTdib09qZFBmdGdsamRKZlJpMC9mbjRoalU3VFdlSUZVTXhVMHdY?=
 =?utf-8?B?bk9EbFdvOWlobVVOY2dXNDdLWnBVKzMyMFk4L1JVS1pxdUFKWDltSUkyT212?=
 =?utf-8?B?R2Y5MHprTTZJd0xub21JQXkwNGVneHV0NUx0d2dSSVc3RTlWTGsyNk5LdExB?=
 =?utf-8?Q?7XN6t+OlcuKnzA1BELiRP1E=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f833765-939c-4500-ea6d-08de16282f3b
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 13:44:58.3273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hgm1zKowPNuHbMdJiKUjwvrt3PiLoLC+cuVd5/GlMvw3YnLOrkYke/MpFsX9M3C8HbQMwBzChjLCv3pVF2NbjxozWLyhMAdfw5mjtneMDfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB10358

On 2025-10-27 04:43, Thomas Gleixner wrote:
[...]
> + * Some architectures use internal local labels already, but this extra
> + * indirection here is harmless because the compiler optimizes it out
> + * completely in any case. This construct just ensures that the ASM GOTO
> + * target is always in the local scope. The C goto 'label' works correct

correct -> correctly

Other than this nit:

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

