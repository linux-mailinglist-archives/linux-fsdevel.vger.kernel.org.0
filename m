Return-Path: <linux-fsdevel+bounces-65919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8F8C14FFF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 14:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 411CC56277E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 13:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1034C2376FD;
	Tue, 28 Oct 2025 13:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="qZFHiiut"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020098.outbound.protection.outlook.com [52.101.191.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E301F4C8E;
	Tue, 28 Oct 2025 13:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761659497; cv=fail; b=UY9RP/+mB/8mRmup/UbCjtQXFA3npWfY/CocP0DJe+LfW3xRmNiUmj2Ccuj25Gx2FZtHOSrLU/qwhOcy2x9mF5jLacmoK01XsXTBC4Nf/xU2rZ3t86W8oIKVAzr88OJ9dZUa+WZtHl/sI7gDqpamFgxNCNI41ZgpP1Rl488q4KI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761659497; c=relaxed/simple;
	bh=XF4kgT0ZV/ulz4/rb9EswkDXIHNpGMoZybaerlJU6xU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Yv5FFJuwSFiTU6lE7N5pJOXT7iJvj3hWK1IhozrFLy8XZ6Cp2C6+02l8V/VHNsVjZQWDgxHwxdNKKWocevo38HtUJq+y6tjNPqRQh9QBuck21UBn7K+UfwuvfnPrWUY0MKENOGQ9QC1ABMB0QJo/1unwP6QI7C1ahcSmGgJ7IuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=qZFHiiut; arc=fail smtp.client-ip=52.101.191.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MelzqHi13a4dasKrb97baISj/e1Bz3Mt3TMAYowUSrJtDrLSdCkrL0fa1dnaf1XnDukIK+Hj7ILv39ASwalJr8vQXTRQtPMjQ52Pp/Ge00MOxJmU4esX225gq++6kSkL0f2VS7Sot8Aj1Gz6cMsHmIKPNBcUunTrdaXDbEPfGRBBtJFZSvzvH9G36oDHI8v1OeLh5//O82j5uGBZ7yK66paFn1z3vG7So+0wg8nc1tK+Pq5H9Tkg5ilwC81m9PmNwzRpKDQoJkWe0v0aYM37waY6kw+0TfgQImfOHvzr/c/Ak6GJGry4BZHH5ndJlYsCXaiy9Xv7uteLptRflRKNQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSpjMDFzvoZiahWNLB8AqsQvehKUDuvlS8DM8cOs5I0=;
 b=X4yvEvxw12N65n6QB/Oj/1+p7gxzkz8+3ONFB6ycWX7UGeANgrcHfWFzSZRORB6whngXKx2FzjYU+z+WwPY4llmH29O6r75C1P6eI3xoCzXsc7M7SzMOjDNEuhx7k4jrqhcZ4lcfMvlx1hsvlCF0fZdGmAPtc/xLjXTuKNs1jdwSTFz1LAEHwFg8aQEXINclV78pS5iPKOi3bCevowNhT6piJpDSbDAnB07ZZC0BqvTQazv2r7N3bFLVUaIvvw5VRDXtQL/sRJ7Yu6p2ncQmO8P/nzz4ayGAypyz4TzwBcUpY1pMruCyrVexP0ptVImnKIA7qleHMnRmlqtAf+CEVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSpjMDFzvoZiahWNLB8AqsQvehKUDuvlS8DM8cOs5I0=;
 b=qZFHiiutJydKAib5UhfDza5nkG0r0kdBkN9QApbWAj7YOs36dqx+kzrI6j9EvNEKNdtCT+ZxxlPNP2g9Po9CAoozKcaQLn/NxQ82IzxymlqOmotq/AxXh1i+VZmPgFELzMr1L9OTTo2wND8PMolegOxYNi7lYSF7OxM5CCvm6w1AAj6haJop9Z25AzoDzASz15hXBRLGh5zEPJ+xkTyfUPPe/dF/F2DI+4mlAxgDSQsJIOYgKRwCv61DhNemGBNjhc8YOi7g5REnVaT2HfDSXJNAQZDX6VWdznskF3THDhL1dssLnTKJAzTA6hSajLZwv/n+bsv1qfn3pZfBfzKzlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT1PPFC07946807.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::581) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 28 Oct
 2025 13:51:31 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.013; Tue, 28 Oct 2025
 13:51:31 +0000
Message-ID: <71454a26-7ea2-48c0-83bc-84ac7c80ff8a@efficios.com>
Date: Tue, 28 Oct 2025 09:51:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V5 04/12] powerpc/uaccess: Use unsafe wrappers for ASM
 GOTO
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 linuxppc-dev@lists.ozlabs.org, kernel test robot <lkp@intel.com>,
 Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
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
 <20251027083745.356628509@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251027083745.356628509@linutronix.de>
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
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT1PPFC07946807:EE_
X-MS-Office365-Filtering-Correlation-Id: 755a6793-e8f1-491d-5012-08de16291953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXU3RTVxeTZMNm94VTM4ZXRrazQrbElnc0FJU2NGcWtkVVhQMXlJdThZMjUr?=
 =?utf-8?B?Wk03WnJNNDJnTmtuS3F5TXliSFFLTnNESXFidzJZSHR1VmdkK0hGRDh3eGty?=
 =?utf-8?B?TXpBc1VQc3o5aXNWZ1J5YTBzRVgxUG92QmRTMmxQQTlVd2ZycVZOV2pXNCtv?=
 =?utf-8?B?K0w2a3VoMk9UTFgycUpJNGJxUUQwelNYSDFyc2g5dnFScU5ITWlhTGs0VGg1?=
 =?utf-8?B?TVFFVmpMK3J5L3ByY3FiWit1U0pPVGFqZjlTaXFYQ3lVK1d3U1J1elh3REhl?=
 =?utf-8?B?TmRUUkdDL1BiVHAzQTRmS1hsb0lUWk51VlVGd01mWU83K1FKWFprbTk2a0s3?=
 =?utf-8?B?YVlPV2VBN0FySHhaMnFwTmxsRDNQS2N2TFRJNVZzdmxEZUMxeitUd2grQ1Zo?=
 =?utf-8?B?VFl5Nm9mdjZJQnRveElndDk4WU5zeXhJaG5sSmY5M2FtYVFlU2VVQmFJalZx?=
 =?utf-8?B?NE5ocXJGOTJMSTRSc3A4SWtRZndFbXh0aW5DWkRZbkJqMkJ6Z280ZHA3cVBl?=
 =?utf-8?B?MGtEWmZKMG55Mk03WEdFKzZNeGRXMTFpeUpaTmFVVkFlL3VVL3dxMW4zTVBk?=
 =?utf-8?B?Y2RxVE5XU2tzeWdudWc0QUR4QUxyL0w2OTVJUUovOEJ3VGVlcUhvc3BTNTFT?=
 =?utf-8?B?M1FaYUc3Kzd0WWdzMTdsNy9xNFNmL2lQcDB6VElQTmdjS1ZkTGYzRldXMHQ1?=
 =?utf-8?B?S3JIRkwxaWVzSE02cUcvUXZnbDBMOHJ5c0ZhMHcwdHJXMVo0ZkpKYlZKNmg3?=
 =?utf-8?B?eE1wd0pLdUhEUmhpVXZxWHEvL3EzR1NwQ09wL1Y5eGgxa1RiZ2lrRkw2NzVx?=
 =?utf-8?B?ZXdKTXVZUTVNV2tYWm54eVJ0dGJjRHloaURyWDRiTzhLY3FZN0FPdjVVY28x?=
 =?utf-8?B?UU1KaDUwaEx3ZjRaUzI1M2hWaUIvYnlnS2RwRU42R3JJbDZ3T0x2R2diOXM3?=
 =?utf-8?B?TzJwNUlOaWZ1VzdXQ1ZUalZrMjBjbGFOelpFMnA0TFUrbk9MQTBDdjU3aGI0?=
 =?utf-8?B?dWQ0Q2JuTGJjZldmZGl0ZlVVUW9keXN2TUZCR3ZldHg4elRZd1d0NjJOVzZu?=
 =?utf-8?B?c2RFaFo2YWR0eHJzVG1od1J0dVZRemw4RWd2U21QSnNydlhLZUcxMlFEUzZG?=
 =?utf-8?B?cml6NkJ2WnpwRHlrc2FQMytFek9GNitzSEtWb1V5UEUwU1JDZ29xK3RJMjVv?=
 =?utf-8?B?VDZHTWlFeDJ3VnZNMTYxTHBja0o4NXBEQ21vcmhoZysrMlhxekpKeFhwNmR3?=
 =?utf-8?B?UXpyNlgxL0RPNytoVStDUy9zbU9LMXR2N1I5eDFvaE4vZUF2aEE4dTdTZndN?=
 =?utf-8?B?STU4NDFXa2trd2pmdDVHaCtHc1Y5bjVVQzdSN0huVUR3VXRxZTJsYWo3OHZs?=
 =?utf-8?B?MUJOcTBjRzR4V0g3UTdlam1lUEVoeEtLN3h3K2xYSCtHTnBoM0Q0N1JtTkx5?=
 =?utf-8?B?UGViUzFrMTBueTUrdkR4ZGpjai9taE1aK1NkNkxGdXR6cG1TZGR4YmlQZkZh?=
 =?utf-8?B?aDVJYzBpcFNpTzNYZGtlNExBQkt1am5VUlVLcDd2eUxXRTljdEV0V2RuL0JO?=
 =?utf-8?B?Vjd4MGFhQ1RaRzR2bWw1NVFUUHFuaWU3ZFRBSml0azJoNnZqOEM2UkFoczZW?=
 =?utf-8?B?UzB2SWI2TnoydHd4dGtGMWtUR0ZQNGFubUVtWXJxNTJwL1ZWZzg4akZOcldx?=
 =?utf-8?B?UTNMUzhpYWI1eUZYdDFUazVCTkM4RkJBdE9rdnVCMTZJQ0pMSUVEN1ZMY1dp?=
 =?utf-8?B?U2FzbFhYMVAvaTVpSURQWFJkNVk1ZE5VeG5PMU9tckVOK2ROUUdjekJtWito?=
 =?utf-8?B?THhqbk5Ibm9WUHNKdmdQU2FQTDFwcXRydkVvVW14TExYVmRiQW9zR2pnSXNW?=
 =?utf-8?B?alh2K3A0ZXllOEJYVkJZanQ2VjVjV1RhSGxqWThhQmhhd1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WENFamhrTUpnWDRzaGNNcFNkMCtqNmJ0TDNvTk0rK2Z0ckJ0QkszakJ6SmZv?=
 =?utf-8?B?YW1aTHpvV3orVHJEMkFUS3lrVmNoWnZhM09wUXQvMCtteVV6Q2Q2SzhuaDhY?=
 =?utf-8?B?SEVPcTk5MncxMjNVcW9ma1NSU0Jkc1ZiY0Q2WXNRbnlrOWVrVGJPZmp3Y0Rj?=
 =?utf-8?B?V3JKblVMa3FsZnBDQ3lXYmxnVUd6aTlzTzVUR21tVHJMRTArbkkxUEptNC8x?=
 =?utf-8?B?R1hweFdENkU4K1BLODg0Mk5DdWVoTEV4TGMraVlLdzZ3Nk9zNlBNbEpxbkFk?=
 =?utf-8?B?SUJkWGIwV0U0VktzMElYZElFVUtpZjExb2VVZUJSQ3BSdHg2Ri9NOURpaG9z?=
 =?utf-8?B?K01odzQ0cHRUSFBkcS84cVorOWxWa2VqdzZTL252SkFsdHI5UGl1bDY1SHA3?=
 =?utf-8?B?ZEVpZVkwczRRak5taDJFYkhCMmpFQ2xRcVZYU2hOUEVpN05CQlM0Z2ZGUWt6?=
 =?utf-8?B?MTFhdU1SNGV2RXpFRncyUHBEZzZudkwyVFFsZ2JpMEx5bHhyUFlvTWZTZzQ0?=
 =?utf-8?B?dXNVckV4eVNaa1pkaGw0OVJlOUlVaFRVRjJpMHA3RHgrV3p4QmJMM1NmMjBV?=
 =?utf-8?B?aGJrbVNjNWpmY3hkVzJjdHlycXEyNFpZZjNlN2lTdktlUXRpOWVFbGJTd3pZ?=
 =?utf-8?B?anY3MFVBVHZ3RnE5Y05IcGVjRmhOSU9lNWhNbFMzQWdsVklPazk4K3Y4a1RV?=
 =?utf-8?B?L3llak9MYzY1N08xUzJYM1dMbitWR28rbDY1L2pJNTdDRVk5SGR5dlBTSmM0?=
 =?utf-8?B?MEROZGdwbVBjODBIWHJxdWNiQnU4U1hwQ3dVcmFjcnlxM0xublRSZHJtR0g1?=
 =?utf-8?B?ejR2T09ONThXTm1qanVUSjJIYjBGR1g2WG9xZi9yTUdtbUE0UkM3c0tMWkRV?=
 =?utf-8?B?eVVlRVFEbDlKQnBOa3JXVitxV2RRNWhaVVc5czBoVStHR3AzUExGYU01MElw?=
 =?utf-8?B?b1pFaWxBYWZwVGFuMkp0LzNueW5ZT3ZHM2hPdjBjbWtlYmZPVGVQNkpwR1JQ?=
 =?utf-8?B?WkpjUFFuZjEzUkpFUnZ2NXlPU2pVZExEdCtKZkloNTNVdGhtVXArR0tWdXZ6?=
 =?utf-8?B?NWtOcW5heUpxcXpWR2dWb2JmZEl6QndmcjR3aVczUVdTeHphdnZ4T1FidHRp?=
 =?utf-8?B?bUFGZEVvbVdUYmVUb3kxOENIdHJQL3FvTzMza1ZqTVJKQ29VOHVwQ21ObDFj?=
 =?utf-8?B?MXFrTm5Sbldsek4zZDVEZ3N6cE8wdjhJNDhlaCtUbFd3R3ZFczkxV1N2VW5I?=
 =?utf-8?B?T0h3K3hRaFIvYUdhaU9hT0lYdnhnck9JMDZMVER0bmNTVE52MWU0RStaQW9s?=
 =?utf-8?B?NTBiMjhINTlZSzZkZmtsMEdqRENCMlBzdDhOWG9UR3NOY0o5cU5KR2s2b3NU?=
 =?utf-8?B?alI0RFBuaExkMlRnSjZyeEtjWTlHcm9zbVJRTGE2cHR1alU3SmRxQVRtcyth?=
 =?utf-8?B?SjdTNTFyemVVQldSQTRCT2ZpRnhhNnpUeXM1ZTRzWmxEaUxHc1owM1ZJMlBJ?=
 =?utf-8?B?K2poaHZJaDZ6SSt0TzFsbjFzRGdaY0J6Q1BUZzFFMTNxMkhpV2dUY3orMGZj?=
 =?utf-8?B?OHpvV1N6Q1hvOVFXb0doSDh3ZU0yTHZBR2JxUXFVeVZ4WFZiazd5SmZTMEpn?=
 =?utf-8?B?MmJub1FzK01IcmMvMnZSVWQzSnZJa1NFTjZLeXZWSVZqc1IvYXVZaXhCazV4?=
 =?utf-8?B?YTZvMVY3YWUwNGM1VlgxZEtLUDJ4QUZ5TU1mVWdKejIyd3M3MFJwMXVTZnRv?=
 =?utf-8?B?WmVzTm0yZkwvT3BYU1YwUDR6dEZndngwSEdQVHJVVWNKSDg3eXVyd2wwOHRu?=
 =?utf-8?B?WS9KbFdGN1ovSHU2TFRwYTErZjdpV05OV0ZwU0lGazcxYjRJanpBa293MzdM?=
 =?utf-8?B?cnR3bDdKaXkyNXh2ZlJBSThiNXlUTzRaQWV0M0FwK25YZUVTUXVxQTR6blRS?=
 =?utf-8?B?Z3hnSEM0TlV5RlFXdUlmeXdGZmtSUGpKSHJKVmg0WGpRTVBhYUNaUW8xRlpN?=
 =?utf-8?B?WXRKRkNuV2pPTnJJdy9aYXgrS08vMzVHa3YxZWRtelY3bUdQK0J0TEVWR1Qz?=
 =?utf-8?B?YWJGL2gycTBreWplcXZaZG9FcVpocHBwditFUkx6QVBmSDVEMm1DYWhMMk9F?=
 =?utf-8?B?MGFxdXJZR2dxb3piK1RJZklxOWRDV3Y4UEtaVCtmRTExcjhPYzRweXFiR0ZE?=
 =?utf-8?Q?dODdidmKb9ikjsJZtEoJAdk=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 755a6793-e8f1-491d-5012-08de16291953
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 13:51:31.0933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zH2oXHakrP3o//NUT92TpGE8GeIlUbKH5Lj8zPS3bGXbsuCcASudBC3u9Y1/I4ZqhYWD68n0HP3p+7p/LS65byIH9wqmYWAwbrT2NBBGtP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PPFC07946807

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

