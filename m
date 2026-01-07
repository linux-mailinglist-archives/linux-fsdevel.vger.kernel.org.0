Return-Path: <linux-fsdevel+bounces-72562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AD0CFB82A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 01:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6D683079338
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 00:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107F0202979;
	Wed,  7 Jan 2026 00:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PNh2RJVO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011012.outbound.protection.outlook.com [40.93.194.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09761F583D;
	Wed,  7 Jan 2026 00:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767746891; cv=fail; b=H+RL6HyIYJ42rCgZfMEA9Er1hLZiX9/2jzNX8SIamZq5mlxNSaE0AaXVoh6ksDgT/bjNAxDlG8A/9WKrrXl5/CtWYFvkcWmwOOgl3vNPNRWEPhHWvCRcjRrSX3tiqLQHdEsZlcKmJchjsisJ13KVFgN8B6PdZFYn/xp5nIsR/HA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767746891; c=relaxed/simple;
	bh=AG/c8hRaiqvBB4M3CSXlZieq3/9kyQBQKkZsAdD/rqg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Me62YNc+EY2KPNtAleKLRdUQJny14LVh4pgPF9uDeiYzMO0YxKuihbASQMWw4kk3LXAGqx8Scv2GHvmMdh+EfjJjlzgSZ5bHQZYrwLaF9+r1PdLgJMJElYqGJEKXq/K95/TGqTv3OhFAT1CLny4HDkrd3RFJSrHd/k8S/Z6YPC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PNh2RJVO; arc=fail smtp.client-ip=40.93.194.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eff9TPXnwQQEIEBR6Bf505pGHOgFGg6E/mPs3c50sJhhEBv0DVKV9xV7IKGhBq8IjMLTncVnL+A05RcoFfqxQAiw6aHe/lHr/jVLWr7khAAp/UEn6znhpv3jucDHiaswnviSh4RiSy7nL4H/YmgxoF5zQpYBknxRb7lt95+gdO1EX5Q7QTktcfUwria+4JcdkGhH5oF25/X+sVdsp7tP3OBTVeguCeKFgGorznfqwZPAHmq9/7ILGf9EXKcXF68qQI+apXHdvTLJcKtKCaHcOWxaBQ1fFAzt0cMgasU+p7mNjxfykyKcMz8RH8JT2/woNnRbG9EBYluvzDw82VqOVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Br06jsaeuAAh13GEJ9O8l4SApAxgCW8as4qDsP+dOBo=;
 b=Vz6s1d9VG/5WxElgwZ/EZRbe75vm3ubLcnGyJaMI18tqKWgU+dSamk0bkLkrUqbgoJlNGogIunBnCNjZcb0ara+VQ6j8JHs8WqrLINfceCRASuCXdWqWWMie0NBLJONGu+jOIRaJmFxn3lt6CmVH9bTTyh1dxdJkZwGb4pok0aKA6oVDy3IqFcSL5D95108WyPay1xtJQ0tNoG1+wK4c1LwyjydE1ddBwr1s1AIW9AzhxSf4jRRFzaPkSb4v885Kil+93WXhqQ756xqku4nEJogEOQd3lJb+9e6b/BUSpwWQIlGSlqLtD1rNx6jtQwmeoqcVC6sYvpdpc5UqiPF5lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Br06jsaeuAAh13GEJ9O8l4SApAxgCW8as4qDsP+dOBo=;
 b=PNh2RJVOvcRz/y8QazTXb/5UolZuzMKNnOGd5ot5gD7B5IOcidcD6OLd0hGKrMo8rcbLN1ePBSQsrn1SK0anZBUW6M8dFJ2eVZTTtt2ftGlaeBMA/gs0I72ceGAAbX5JEhHhyieSAgXQK4ZoVp8aDze6n72CMHF15DLtPu/hyyX/jWEbrgJ9ZqygWlGkj+DjBJuXbdoMD6UDVmscSrf1anbyCjIUKdmRaFNSORPpl2fTGFrTSSQVeK4Oj3GH+HCnSnYF9CX1V2Wa2qSwt7Cobo2xFYz2s3K/Hn8srNeg7nTqQDRffG4RKH4npYExrEx/k2DCCUkQMU1o9/LqnH4sbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 CY5PR12MB6082.namprd12.prod.outlook.com (2603:10b6:930:2a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.2; Wed, 7 Jan 2026 00:48:06 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%7]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 00:48:05 +0000
Message-ID: <4f3f87ad-62f0-4557-8371-123a2306f573@nvidia.com>
Date: Tue, 6 Jan 2026 16:47:35 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] rust: hrtimer: use READ_ONCE instead of read_volatile
To: Alice Ryhl <aliceryhl@google.com>, Gary Guo <gary@garyguo.net>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>, lyude@redhat.com,
 boqun.feng@gmail.com, will@kernel.org, peterz@infradead.org,
 richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com,
 catalin.marinas@arm.com, ojeda@kernel.org, bjorn3_gh@protonmail.com,
 lossin@kernel.org, tmgross@umich.edu, dakr@kernel.org, mark.rutland@arm.com,
 frederic@kernel.org, tglx@linutronix.de, anna-maria@linutronix.de,
 jstultz@google.com, sboyd@kernel.org, viro@zeniv.linux.org.uk,
 brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20251231-rwonce-v1-0-702a10b85278@google.com>
 <20251231-rwonce-v1-4-702a10b85278@google.com>
 <20260101.111123.1233018024195968460.fujita.tomonori@gmail.com>
 <L2dmGLLYJbusZn9axfRubM0hIOSTuny2cW3uyUhOVGvck7lQxTzDe0Xxf8Hw2cLxICT8kdmNAE74e-LV7YrReg==@protonmail.internalid>
 <20260101.130012.2122315449079707392.fujita.tomonori@gmail.com>
 <87ikdej4s1.fsf@t14s.mail-host-address-is-not-set>
 <20260106152300.7fec3847.gary@garyguo.net> <aV1XxWbXwkdM_AdA@google.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <aV1XxWbXwkdM_AdA@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0103.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::44) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|CY5PR12MB6082:EE_
X-MS-Office365-Filtering-Correlation-Id: f06c3936-b6f6-4b27-910e-08de4d866b74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U283TzRRU3pLVkVKeUVPZXpqclBRSHVWTVdSaGN6SGg2T2RUcnFKTDhZTWwz?=
 =?utf-8?B?M2NmZm1kR1crd3AwRkU3cXpLYzdyVWRDZkgrdmlTTWI2WUV1TGJUcEdXbngw?=
 =?utf-8?B?czV6eU83UC9RZjgzbCtncXVuTlg4UWRKMFYvMGRkWVorRVlNdWJkelVvVW12?=
 =?utf-8?B?M1UzUU1jSzNDQU1aQkVGRVpud2tRV1FnSTY5ZVEwa0pSK3J2NTRhQjJFb2pN?=
 =?utf-8?B?SEZ5YjBWTkZHUWY5b0JUQ1pERDNqeW5VdGlrWkhsZDlGTG5GNmpRU0YvQ2JI?=
 =?utf-8?B?aWxqV1hBUkJXMmFDNjB6TlRkQ2VjVUJKVkprbjR5ZWhpZ0xxOG5WQ0tZaWNU?=
 =?utf-8?B?TkNrNkVNdi9scVVXTjZZTlE3SW42bWV6aHpjUUVlRWhYUmlvUDdkSTZwNVFo?=
 =?utf-8?B?bXM0WWM5eUdreUdyRFVIQXJPc0VIN1FmWGFyeWE3MDI2NXBrQ01LcHJiOCts?=
 =?utf-8?B?TGxDcVhlV05EQVZmOEFudTZrcjBnVk44TTc0RjlpdGM1L25SRXIreWpEOHph?=
 =?utf-8?B?SzFiRkluM2RMVWw3b0hRcUFSZitGTWtDVnBHTUVBdHp2Tm1qdHFqNTlCMm5M?=
 =?utf-8?B?YnJ2RmdkeTdlQ3dxKzE5dnNxcjdaWUpwcnJJREFQZ2JEZTdtRHAxa01nZ2tu?=
 =?utf-8?B?VG5yelArT0FLZC9jZDQ1RUVvcEhjdzhEUkNuV2VOK29NNEtTNCtsMkFPakg3?=
 =?utf-8?B?NDVLMzlvMml5emxPNzdSM2dpZHpUbFNsbW5DVTVZRGNma3U5Y3ZBK3lRaU1C?=
 =?utf-8?B?OGl3OUcrR3lBaCs5REN2eGRMdDRINlc5VG9RS2hNYkNXZklwd1psQi81OXNx?=
 =?utf-8?B?SE02U2dCQlNGNlJoS2k4TkkyS3NFYjREMlU4bEM2VFpoVmxnSEZOSThxdFhB?=
 =?utf-8?B?dHJQVHY3V2tkeVRUL05Hb0prdmxnOC9JcEdRUWxqRUlLUnNkaEZmY0xCQTRS?=
 =?utf-8?B?K3NrT3E1M3NtVmZ2VmEwL25yNmYyS3dzOHBwUDMvTkhvN0RJUDdiQXRPdDVw?=
 =?utf-8?B?OE1BWGdaRytNSEk4QlFnZkk1aFpROGNja08rNTVDN2NUaW1MeWFvalk0ZFZK?=
 =?utf-8?B?SzRFY2hiTmJrVTkySEk0RmVNa09yVGdpeWxBM1Q2bXVlcldhdlFVQlBDblY5?=
 =?utf-8?B?Um5vOVF6bUM2ZjRQckRQNWRNZ3NqZzRBb0xnZVd0SFMyVzhISVUzanZMOGwr?=
 =?utf-8?B?NmxvalA3K0Y2citsd3piM0VSRlBJc2VXeWJlM2FONm1qcVRMS3pEdmh0Tk8w?=
 =?utf-8?B?eFVaZmV0MWN3UGlUb1Y1dGdHbGdza0ZQNDFjYmZsL21jWHV2SDMzRzY5WGwx?=
 =?utf-8?B?S3VmN3pqTUpoNndxbVdBL21IajJxYUtZcUduVHlUVnNXQmJiT0VucmVIWXVv?=
 =?utf-8?B?amhVaktvVXY3d1EzSWh0bTZKVGsrQVVxYW1KbGdwUksySWJvSzlvei9aNXNX?=
 =?utf-8?B?aU9KYndKNVlzcVhvb2ZmWHE3bFJFWk1xNmtFeDBHSVRsOUt4Zk0yTGdQSDV6?=
 =?utf-8?B?aktiZjJnbXN4R0hFRTRxMGY3UUlrL3lQVlZDNDhpbkVSRGdBd3pGeWthUWVs?=
 =?utf-8?B?WVplR2Q0UXlGaUlQdkJuZSt2MDgxSUNKQkJKdHRCbnpQQ09BV29SMHJnNE5t?=
 =?utf-8?B?S3E5RXJFM1NDVmtYSWdhaExsb2Y2SzVNd3R1Q1ZPcks4NFpDWVVGMm15cFhH?=
 =?utf-8?B?cjNXa3dWWnBmd2h6c0pVbUhMOTFHRGloYWc0UE5tV0dWYy9US0JBQk9HL281?=
 =?utf-8?B?WVdDRE8vZlpaQ0VQNC9rRUlTbjdNc0dFNnJlcnJlTlN0aFFOdEo5UlR2SkE3?=
 =?utf-8?B?Z1QwYmt5ZjFLVGtJekZtSVJZSEN1R25nR1NjS1BKZlIxdXdNSUZyb3pqZVBQ?=
 =?utf-8?B?bDVFUzFWZFN2R3VyMFh1QTZVWWtWVUs2cXZOU3pBQll0QUZ4aWxYZHNGWVZF?=
 =?utf-8?Q?hNC8NlcXZr4PgE9z9Zzdvz+mZr6qpS7A?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9416.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUVrdGZhRjZWNkN4OEIrTnFmSGtRcStRc0twcE5DQzRIVWxHbmtPcGRseDVI?=
 =?utf-8?B?eXViRGZqWDBZOStzcGd3TlNXSmRpNzk1Q3ZBeXBWeUIxTUg0Ukw2eWt4cjEx?=
 =?utf-8?B?ZWVOWlErVGVqdWRGbjJJVExoYjZCMTdtK2V2OXBweENyY3ZZTWZLNkk0bWk0?=
 =?utf-8?B?R3FVWHNuNnNBenRxRUJWWW9CYUlDdUl3eDlrcVJ3MWR0Smx0R3drZjBYRXBm?=
 =?utf-8?B?ZlFVdk5ZakxHeWpRN29UV0JhTm5UVFhkRG5PYzg3NS9sUEdkNDkyZVBzZmVz?=
 =?utf-8?B?MTRSYzVyR21LWGNBNTc1QlFrMHBvc2EwS1FkOTNGek5hQzJsMjhaZ0NCcWww?=
 =?utf-8?B?VTRFVlJaQVNvTVdyeHp1RzRwNUx5VlQzcVZGSm1VK2hpc2RZR3cvZjRxanFO?=
 =?utf-8?B?YklURmZ4S1RHOERKS1RrYXRpSFR3eVhaY0l3UWwwSDRRS0czTjZaWTEzdW43?=
 =?utf-8?B?ZEJFMlFxM0diaC9DbG1uWU1MMkVmZ0lMYko0dCs3TjRqM3QweXhJSVNEUW5v?=
 =?utf-8?B?NkErUHA2SGVSV0xqTFVmN1lsWXBUSHhSRE5JYU02bFErVFJIUExDd1YwOVNO?=
 =?utf-8?B?SUV1RGVCc2N6V0QxN0N1dTFuQXdzWVVmOUVIclVYRk4zSEtKajdkVStHbS9N?=
 =?utf-8?B?Z2JTNWJYdkp6U01vWTUwV0ZNSFFScWxVWTNjYzJ3dUk1TXJBVlZ0WXJqc3FO?=
 =?utf-8?B?SWNiYW5VV3FvTXl2RTVUMEEzaXhydm9XWDJnaXhOd201SlB2UlF1MUtMaXhh?=
 =?utf-8?B?U1haWWF4YjFlWFRvRUJTZ0xCMkNpa2plbEF4by9MRm5vcG80LzhxODN5ZmQ2?=
 =?utf-8?B?RUhhZzhYcVhGYjR3R2JXT1ZtWVhHZnA3aUROUkViMHhlUkhEN2pmZnRqaHN3?=
 =?utf-8?B?TWZMSnZFYW00aWhxU1ZRaDdoSkN5cHlkOGVKTkQvU0hxOURwcFBscnVaMERJ?=
 =?utf-8?B?VzVsdzRvbEEzNXpac1BWRTN4TTlPR0J6clZwekdIVmpzdEZjUjg1Q1VEWmJP?=
 =?utf-8?B?MDF6d1htNTF3RjFkanBFc3NWalhIbllpVTNwcDlTYWdiTVZQRTBKcWFpYmI1?=
 =?utf-8?B?V1M1d0ZZeTY3UFRKS1ZMRFdLR0dnK3NzTFZnZUhPdzRKYWhEaGJaUGgzWTQ4?=
 =?utf-8?B?S1ROemcwWjJhUklDYy9yN2cxRGJCdkd3YlhpRGZYSzBWOS9IQjd0WkljYlZU?=
 =?utf-8?B?NlVidGNEWWRpd3YvUjBhNGtrZEIzSWg4eTFNcksyS1MwOXdoMVlaa0I1WDA1?=
 =?utf-8?B?UmJTd25qWXlqSkNlNEdLakMwdVVtNG1lNmFEcFVDOTMzWUhlMXJ3V1dKWUY3?=
 =?utf-8?B?aXNoVDVqdlZFYmlqMDhjeDBJaEd5OFpMMTJMMnhYU2t6cmh6Z1lJbGR5N3p5?=
 =?utf-8?B?cW5EZXNvcHIyYjB6TGNONmNYdHZ4eG9lOEE0YU52QmhVek5zRW91QmtETlg4?=
 =?utf-8?B?UXp0YkNCOWpyamVObGY1elFYL0lPdHR3eFJ3WjhNa3JxMkZzdWpFYnNQYjJJ?=
 =?utf-8?B?UWkwdkJLejE0NHluVnJ2a1BmREdvRktyenlXOEVUNVlVRFllc1I0NDhiL20v?=
 =?utf-8?B?U2VoNG9JRllZYkVEME9wMkVJdFVzU1JtZC9ndWwyVHU5dkl5a1BaUHdTQm92?=
 =?utf-8?B?QkhGaHhQYzdyK0NaazNqU2x4WFhxcTlFb095djk2VGE1VndnZ3BFWnNqWURE?=
 =?utf-8?B?R0JhcWNJZXl3cDJ2UjJSWWUzdFNESGt6NW5aVkI2ekNrcVcwNGNPTktlRjVQ?=
 =?utf-8?B?OXIvUDVyS1E1KzlEaWhzbkNJbXlaVVpENHNYeXVuRGQ0M1NIbFZxemRFZ2NV?=
 =?utf-8?B?V0xlckxXcnUwNG1RUmxoSmF0a1VQdG9WeTlBbFE1UVdJbWgxUFJSVGlpczhO?=
 =?utf-8?B?M0NUNEFSRVVWQkFzOGF5MnB5eUV6bm9YWnNodVZJQnNPeWRVZm12SHdvUUhw?=
 =?utf-8?B?OW5GQzgySkJEUnFkVGtJVEllQlpUc1UvZHN5NDlUS1dmUUtjY2RzeThpY25Y?=
 =?utf-8?B?a2QzVFNvMkNOZmF2eDcrbklxeXUwY294UG95d2x2djV6ajhHeDBNdGsxZ0RO?=
 =?utf-8?B?YzFYckR6SGdOT2FqY1kvbjhxb1lhRm5lOVV1SzdmNWU5K0FCazZvZDM3aVpt?=
 =?utf-8?B?VnM0bHN0R1QzOTdLei9FTUdqTnY3ejJqZFlJTmlpRlBLcXo2bUVsVjJHMklM?=
 =?utf-8?B?MVBXOVhSMmlwRmEvcmhDSFVidkEyaVpYQmg2S2xtL0FMNjVMdnZxSjZWOUF4?=
 =?utf-8?B?UXU3d2VGMmJVcDlzZW5PK085M1VhR0tSbTFlMGhOTDBDVHJ4WGRnbEl0NWEz?=
 =?utf-8?B?cFkyQzE5Mzc2dVlFOHBFMmQrRkVIcDhpb2ExWEpPcXpyRzFONTNFUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f06c3936-b6f6-4b27-910e-08de4d866b74
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 00:48:05.8545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: igLpqeEJvKu+eUtncGAbt/RnYW/Vr86P57PH6gh7L024BjV6RHVBzQ5t4+dQAUBTHPAhibSQwlIucU+Twu4Wag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6082

On 1/6/26 10:43 AM, Alice Ryhl wrote:
> On Tue, Jan 06, 2026 at 03:23:00PM +0000, Gary Guo wrote:
>> On Tue, 06 Jan 2026 13:37:34 +0100
>> Andreas Hindborg <a.hindborg@kernel.org> wrote:
>>
>>> "FUJITA Tomonori" <fujita.tomonori@gmail.com> writes:
>>>>
>>>> Sorry, of course this should be:
>>>>
>>>> +__rust_helper ktime_t rust_helper_hrtimer_get_expires(const struct hrtimer *timer)
>>>> +{
>>>> +	return hrtimer_get_expires(timer);
>>>> +}
>>>>  
>>>
>>> This is a potentially racy read. As far as I recall, we determined that
>>> using read_once is the proper way to handle the situation.
>>>
>>> I do not think it makes a difference that the read is done by C code.
>>
>> If that's the case I think the C code should be fixed by inserting the
>> READ_ONCE?
> 
> I maintain my position that if this is what you recommend C code does,
> it's confusing to not make the same recommendation for Rust abstractions
> to the same thing.
> 
> After all, nothing is stopping you from calling atomic_read() in C too.
> 

Hi Alice and everyone!

I'm having trouble fully understanding the latest reply, so maybe what
I'm saying is actually what you just said.

Anyway, we should use READ_ONCE in both the C and Rust code. Relying
on the compiler for that is no longer OK. We shouldn't be shy about
fixing the C side (not that I think you have been, so far!).

thanks,
-- 
John Hubbard


