Return-Path: <linux-fsdevel+bounces-71574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1B5CC85E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 16:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EE703071FB4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 15:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D529E34CFD2;
	Wed, 17 Dec 2025 15:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="yHUFgbZe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D109734C159;
	Wed, 17 Dec 2025 15:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765983817; cv=fail; b=CHFu8Viyrrg6+2PMAAQuXGJBTrEEaONBOEH/VZOtZqdjtctdiFgufn3xXfm9nzp/KRAiSRUin5J2NXjzl48jmvBN/vQI/YYwHfu8p+c7DOVW7ojVXyL4iTZ0tcI9wW9CQPfcWwMYWw46j1ClBIO4xG4Q3rI2lUoOk7WfrGrGZq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765983817; c=relaxed/simple;
	bh=VfNMmEN5hVx/KYgtmjRgZwWsNF+6ZAttHRDDAriWh34=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=px5xFgO0biJj+Yo2EcNC2C091p1JXFcOi5eSlf090tOe4Pj7d/2qM6EfAO0YVTSIzlklpuViqcpUdoj/CpdUSsyswE6bvADPCHxYAgCM9l/K9CNXsunUNFEt/mnuItc0Zi7lmMV3MnaSKPDDwdHNBh6g/x4QRHyeFYuFY9noXik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=yHUFgbZe; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023097.outbound.protection.outlook.com [40.93.196.97]) by mx-outbound42-250.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 17 Dec 2025 15:03:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rYht61ImyPaiM7R+6zeiIHaKES+gbChbA2L4ziouerxdrH323xtDkSn9ZUbLzQ5jNZy1LEy2S/erUb3ousbVsgJkTFdr+hOY+WAeMdc67+hIbhZXTrR8hOyDYPhizgFuSGKNK8WXWY8FYKUV5AjWpZJjXKVDcx6JA7dBqx1QjYRUqlqQ23c0muOLK6jPC2snwhSpQ0K4sr+JS5Xw2XswKRv7407N4N1CfKvzYbk+DT0WeukuxzscHapmSOkJAXlYJBHXBGE9F16ihmDEIzq/w5ZM3oow7XGdHJNPqcvWeiIlgtXu2G9sh8eVTE3KlPqO2J0xKjCqOGu83NjWOCgEsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7qDqEipvXWoA5D9OvgyaE98ZUKMClC1MGTi85pyqhI=;
 b=hs+cmQIpS4e0BX2e/ga8gGcno75yWXZITqBq04JmX82a4je6NksNHucFnVaXN5h5owr1NxhCx8bYRoLu+d+lZg35zVMNG422kJrxn+s4u2DEcasrlXWlpc5a8CqAPfTmzMMVEjhtXyAHy0nkGke8ELb3g3GGH2E0e5dj/R3iYMGFdvnlr/B/GJs1mH5ZayXl7lRl+qJVKoY1P3kgMVhmQ8B8K9BjBcnMy9+IaHS2fqa/20AvmmewjCdCMtDu9Gth5yN5jvXdMqcXIKvIbNUEDZEpVwpqSFCM7LgjL1pPzY65aIyl5prpsS3WhcKBscAsgpdsJbHW2JT1Ji5FaseQWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7qDqEipvXWoA5D9OvgyaE98ZUKMClC1MGTi85pyqhI=;
 b=yHUFgbZeAuhACRuCO0iaiGdOhiWYzgYc4Fh1YC8AlzSeBGMXAkSUq2OIu6uMt8blqsirPqgm/KhMAx+krKIIb95wk2kGU2nik82zQUMWIj8VtDgWDCgMIKdjAT+OaLrmIZ9uKBRuJeAkYql2a/MbK9cjRKdS1TbhnK/yG5hn8Y4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by BL1PR19MB5889.namprd19.prod.outlook.com (2603:10b6:208:398::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:03:02 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::c2de:bba2:8877:3704]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::c2de:bba2:8877:3704%6]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 15:03:02 +0000
Message-ID: <5d08a442-fd74-432f-a5da-4fa9db65e815@ddn.com>
Date: Wed, 17 Dec 2025 16:02:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 4/6] fuse: implementation of the FUSE_LOOKUP_HANDLE
 operation
To: Luis Henriques <luis@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
 "Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>,
 Horst Birthelmer <hbirthelmer@ddn.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Matt Harvey <mharvey@jumptrading.com>,
 "kernel-dev@igalia.com" <kernel-dev@igalia.com>
References: <20251212181254.59365-1-luis@igalia.com>
 <20251212181254.59365-5-luis@igalia.com>
 <76f21528-9b14-4277-8f4c-f30036884e75@ddn.com> <87ike6d4vx.fsf@wotan.olymp>
From: Bernd Schubert <bschubert@ddn.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <87ike6d4vx.fsf@wotan.olymp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0178.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36f::10) To CH2PR19MB3864.namprd19.prod.outlook.com
 (2603:10b6:610:93::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR19MB3864:EE_|BL1PR19MB5889:EE_
X-MS-Office365-Filtering-Correlation-Id: d497dffa-00d4-4a5a-4853-08de3d7d5feb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|10070799003|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXhBczVlZHc1MVhVMUQzWlFVTTg1eHl5ZWFPcmVGckwwYk4zeERFWTNHdTdL?=
 =?utf-8?B?RTZnYjZpc0Y5ajNsY0RGbWp5NEJKQkhzTG95V0Q2R0x5Smc0VGdDM050bEJq?=
 =?utf-8?B?b241YnAwWk5LREZOc3AyQ20wVTlRcnFMMFFGUXAzbXp1Y0VORXBtak5NS0tE?=
 =?utf-8?B?SlcyVWlRNy9HeTBoQUJjVy9PU0Y4SVEweHIvNkZFSmplRTA1TWJOdy9wMHJK?=
 =?utf-8?B?QUNrZ1NZU2JzKzJMZzJ5QU9WS0F3emQ4ZlIyamM1K2JDWnh1dDcvVmd1WFVX?=
 =?utf-8?B?Q2FHUkxjK2hrRXhteWhSd2pmMjV3VUJGOVk0OStHUS9yTHIrVVhkVGhueG5r?=
 =?utf-8?B?TFhJQVVacFpKUjV0dHZ1ZEMrL0lOcUF6UUlXL1NSM2tpeG9kUkpxTGZlNGJY?=
 =?utf-8?B?WXpZS0Nxbjlqc0NiNmQwbnY1RTlKNENsMHlxdVN5NTNHY0tYMmcrM1Znejlp?=
 =?utf-8?B?M0NWZUR6b3JPK3NiK1RTMXBkWTgvMFhkVjJwRkQ5R0ZYb0grdWhaSFJCS1RW?=
 =?utf-8?B?S2lGUjkyUlduN1hDRHdCN3UxdnFLVm5rQzlFWEZZRWRNS2VRWkQ2YVJKZDZ2?=
 =?utf-8?B?ZFFWcEhTNDh3cThsTnlITlRxa0tadzVINWw3NGdGVHhnVEZpenhCbTR0bmpx?=
 =?utf-8?B?M1ZYT3RINEJwMXh6QjBBUUZDb2N3K2p6ZmlkNmthVWhKTU5WYzRSYUU4a1Zl?=
 =?utf-8?B?ZHVYSis1QUhVNVRCYVo1VjNSZDM5Ulhrb25vMXhHcTAwRHRPTk5EVzBLeWtH?=
 =?utf-8?B?a2pLaEFsL2dUZERhSWorWjkvWURtbVlMOVYraXRvYjJna0pxOTZnekc3OU8x?=
 =?utf-8?B?bk9oSGNuWU9oY1p5SzFiaEoweVpadnNxRjNTUDdWSFhMditKQTk3ZzlrR25M?=
 =?utf-8?B?MHR6L25pTnU3TXRsRE9mZ01ob1hZQ1M0R3FFR2FqaW1VWkZCekVxaC9xdnJB?=
 =?utf-8?B?a0ZXeTRYSkNYWjVJb25QS3BZU1JHVnVRMnF3aHFMM0dRMFNwWEQwL0Qzd1R5?=
 =?utf-8?B?cmhMRi96WmdLUklJQUI0SFMzQjhwOGdBb0NSb2l4V1BpZldMcVhQR0JmeElG?=
 =?utf-8?B?aUViTGNKaitISzU2Vkk0RTdNUHhwakREdG9aa1RaaVcvMU1ZcmRsTWZvWmpY?=
 =?utf-8?B?Mmt2eHBwNWwvUW1RMG9XcG5BL2JoRWVGOGRtZG1nSHVhdm10VUdLTzBBNjY3?=
 =?utf-8?B?bm5QUHpQL0xDQmJQako5bTJOTXM1K0pkeUR6QWJQdGZqZk4yWm91Rk5xNWlR?=
 =?utf-8?B?VlpLODcyQXhVaGVPT3VESDJwRjBvdGZQc2ZQRjFqdmZhQTZWZ0Ftb1BCWmgw?=
 =?utf-8?B?WENjdnN1Qm1jRkpRK0J4YXJaRThsQ1VMaC92SGdZZ2tGOXdFK3B6eTNLTkx6?=
 =?utf-8?B?M1Q3ZFMxemU4QW9HUUphcGxGaXJCOXRwVUQzSVZBTGYzMm4rUm9YeUw4TW5z?=
 =?utf-8?B?WFBaazhNNUgzWS9hR01CY01LWTVTY3JLbTB4c3lNV0lKalpJbTU3UC9nNjBh?=
 =?utf-8?B?WExIOXZ6WTB3NGttclNLc3JEQmZGekV5MjUyY3VRNDRxUG82WHkyM3N3SXdO?=
 =?utf-8?B?U0ZwczA2c3pKZmhTOG5JQml6TFNXYjhkcnpoK1QvRmR0TkVqVUxWT2FFNmMv?=
 =?utf-8?B?aXJFc2hMZGJQK3Z4K0J4bTBaLytzMTJPeGhxM0RsRGk5M1MwWWdaS1ozWTVx?=
 =?utf-8?B?ODVoNURWbTVmdTUxemIxL1IzQktTZW14d2IzOHhQUkRTTXp1YStxUTZ4TmhV?=
 =?utf-8?B?L2V3c0JNanB0MFg0UEtUdS8wdUZSVGo1Z2tHZjI3NWt5SXFGZHVIVXVCQzJl?=
 =?utf-8?B?ckIzaERPaGVKQUw1ckZJZEJGUGZ0aVVWV0pZUUcrTkU1OGlFdnpkaDIwYVdP?=
 =?utf-8?B?N1ZPWklBVmR3aWkwZXJVa1ZIc2syZmZMUUVxL2JuWVhWZE9IdlNIRnBzVnZr?=
 =?utf-8?Q?GY8dbAAuIyYelWmj4PKjiEMAALMRWFjB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(10070799003)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHNwa1BTd0Fncll4UFFub29TeTRJaFdibEdTbnZzaXMyK1NEZjNidUgrVXkx?=
 =?utf-8?B?Z1BlaEg2RnFUWEFiMHE5bnd2WWRBNGszSjVvT2F2M2FTbGNKekNNSlU5MWFF?=
 =?utf-8?B?K2l3cERBaEt4ZUc1M1lIN0pNVERROEpNTVViUUZZYmxvN3ZXTkF0NzhwYnMr?=
 =?utf-8?B?Q1NXSitHaGVGRXVRK0xudmorYnVsNDZQc0cvNnBveDVWcENic3lCZGZLTDBV?=
 =?utf-8?B?dmlwYzJOYTFVRXF5RURCNTJlWVBCalZZYlF4bXFhR3pjMXREMkJyYVVRRzFh?=
 =?utf-8?B?elQ5Zk5xUmloZk1VZndvbEt1VWQwdDhPYnVDYkU5WVc0SkZmVmM1SlFJU3Yr?=
 =?utf-8?B?aklGaGZmYS9JcXdjbitYRmhqTSs1SVlkSVdIMzRMaUcxK3RlVmRDVGs1K1Rz?=
 =?utf-8?B?YVB3Rzk4aitjeExnNm02MjBIQ0ludGhIVXd0VkxnVjF1TEU2UkgzSXNFbERl?=
 =?utf-8?B?bXphOEtMZXlZUGFIcS9LVEVMekdqZm9MNXFqbDUrbTcxTDgvZlQzdnFFZFJB?=
 =?utf-8?B?ekZGdnBJRzVJbmo5OGw4NW41RlRMaFFpc3A0bURXY2ptbFFiM3ZlZEdEeWJ2?=
 =?utf-8?B?QVZDZ1d0WFVQOWltNWZuZkN5dklGZ0ozc0dyMDNhRGN6SHZIanF4b1FSM3J4?=
 =?utf-8?B?b3ZaUXVsWHdtR3NVRFRadHRJNTFmM25kWnJSZVV0UTl1SVBsNnZVeWloQm90?=
 =?utf-8?B?Rkt0QXVnLzVZUmNQSS9HajJBTUFpTTk5eTA1SzJRdnJ6QTloVWRsZXBvc0VN?=
 =?utf-8?B?TzdoZDJwOEF5UHNJWlo5M3JEdklpaWRuSkpqS29zUGNBeEtxU1dVNGxIQ1Ex?=
 =?utf-8?B?OE1CVFJhQWVURlF3dUpXVW5xaWV6T2JVcHBDUDNoVENpZEg3SDBMZjY5dTRS?=
 =?utf-8?B?clpVU3hxYkU5R2dTbStvSGVCYWZVdmcyQ0pXRXFwVVJKWTAxTktOYUJzL21m?=
 =?utf-8?B?SmpnZmtFK3BxN3phajF6VmRBb1BaS2plSVRaayt1ZVlhSjZ3OHprY3A0M3c2?=
 =?utf-8?B?NnNtZzNYS3VINWNMVllkZEI0R2p3OUcza1FQRCtHQmtwQlBKaXNtTDFtMXh1?=
 =?utf-8?B?dkxUOVdPK2FjdHpWeVJoNnB6bWJGVUpsc1prdlc0cHhzZi96eVJHNVd5aHVB?=
 =?utf-8?B?OWZ4ZysrYlMrU0l6YW9BNUtaNEdIeGttb3daaWgrZlpHUTZ1MlVTSTFicGlT?=
 =?utf-8?B?S2FiZnZsN2hrUVJoNUVhZmRISFdwQzY3KzBVdWtEam5LeDRnNnFyamdyaDJI?=
 =?utf-8?B?OGRxTEp6UEF3dEF0Z0RHdVozeFVtdWlyMktwVks5UlVmT0d5eHhKK1dRdXZu?=
 =?utf-8?B?VWZ3STBGcS9FYzJjdDVQTE5xeE11aC9VVCtwMHFDcUJoVkdmTlBkL0ZESVIw?=
 =?utf-8?B?NkxJcHdvamFrQXIzUzdWcjJvUktDL2ZGSjNJUFdmMlEwU09VSVk1eEVLd3Zx?=
 =?utf-8?B?K3BFRWo4aFJ0b0FxaXIrbTJvSEEzZ1diMHRCOERwZ015dmxZOGlUQzVHbitU?=
 =?utf-8?B?VGpZYlB1czNMY1pVb0lSZlNBT2F1MHl5WHZmcnkzZG9UL3RSVXpsUXFvRWZv?=
 =?utf-8?B?cDFublpBc1JQWldmMitxLzZJTStVQUF0R21DYWxSYnZOSHJ6Tys2V3JnVmpJ?=
 =?utf-8?B?TFpMdXNHRHNzTTNrSko3Z2puaDZ0aXdjK3hVV1ZVWUsvbTZwUURwMzJETEND?=
 =?utf-8?B?NlM0OXZGYmlicUhkK1daSXFnN2dtMFBGM2V2NUJDc1NuSXlKUGE1cTJtOW5l?=
 =?utf-8?B?YkFhSlFwcTQ4QkxseXROaWYweEFtYkJaZmJhT1BmYjhSTFJxQVdpTXUyVkdu?=
 =?utf-8?B?UDdaOS92VkRpa3d1M1k5cG1Ha3dMWnp3WFkvd3pha2YvUUdreGZBdk03SFRB?=
 =?utf-8?B?dE1wV2Y4aVhLQkp2a1pBWTU3d0txWjlGSUNDVE00YnRZOFVIREFsK1lVUUZq?=
 =?utf-8?B?c1BZV1haL0NtczEya2NZS2FOUG5mQWNhdGNtd0s2blBwZTQvczNSa2RmaWg2?=
 =?utf-8?B?WHBCY2JmWmw1MTJBZjBZY1FyOURkd2taWlRjNmZNcHhBNEt5aTJuRFVvZVZy?=
 =?utf-8?B?RmdJS0Rnem5NMm1LQ3A3ZTA3SVBmM3h4U1BldFZFeG5rTVYxMVNTeTVqWE84?=
 =?utf-8?B?Zm1nTFNPVzZpbUQ1eTRzWmhhUUticDZubjBIWjkzWklCd21McDRJeVlac2tM?=
 =?utf-8?Q?IT8ZpeK9rw564pb2iiiFvVSOBSbLkhGoOLpUPGnsuaVb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7Cw+6p+m/4VXpMTWEoxWoZkaI3pq60lIffRJx3wtq+FKailu/r+e8d4wSMaJwSMrsEq+KxTBzLw4t5tmL7iGqJJqQul6LbIyXM3oo54c4mAF3u7DE3VmrOARDcO4CGpQ82FuzeBD1n4ydWVa+MLHfZY+4kZyHyPYxlE1Ng+dRubF5C46PiWyXne12p+7Vi7smnvzBW3cRXMnML6B7vNERwER7l1yPK+w5QeVXcYNmC+OdCFJE6tfLY0QAVlELrOFPqNcuC/BcuPGlM1HVES6iDA0X3F2DSfrvzNovZe6YI9asldz9QJ6hl4PX1g9mu7zt9UX2hfm6rrJVx8Wjd6p9hFSZFTXCMMHnK6kNThRT+6aN5hKrtQ5sh6Jc5EHSvUDq9n2SWA72G7nAoDqZo1S3ajVYWJpsdnXe1Cm3k+fSLtmjdRtTiS9gMc0UEC1KakTLTgn+kBIsJA3n0REKG23bhbY5Jbwf2iBhQeakoFriWWGTyDVLO+6o9hwUC9zl1aXPTlWk7U21GAGLRAl4nwIVBeTr6CHBwcN99TIOC+KqyIxOjlg4SuUPcHpamegBWjasUni7CM5qYyP8jU/K1Q53DqaZiVR6Md/GZ5l+7TtugKjLUx0lf8iJ7Vt2wplZPOAe2FX1WLqRfLnZuBDk1NboQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d497dffa-00d4-4a5a-4853-08de3d7d5feb
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:03:02.4210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mpj9W0gQH5jfiAkGW9TLN/DGZZUWoZSTQOAPqwA2vMTROjhIKsJS/sFnr7sezSibboAbbyVt4i7qhIWoCRpU3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR19MB5889
X-BESS-ID: 1765983784-111002-7719-6372-1
X-BESS-VER: 2019.1_20251211.2309
X-BESS-Apparent-Source-IP: 40.93.196.97
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsYGRmZAVgZQ0MLCyCDR1MDUwt
	DM3CLVPNks2djczDIp2dLAzMzQwMJIqTYWAHsoJdVBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.269731 [from 
	cloudscan11-241.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1



On 12/16/25 12:48, Luis Henriques wrote:
> On Mon, Dec 15 2025, Bernd Schubert wrote:
> 
>> On 12/12/25 19:12, Luis Henriques wrote:
>>> The implementation of LOOKUP_HANDLE modifies the LOOKUP operation to include
>>> an extra inarg: the file handle for the parent directory (if it is
>>> available).  Also, because fuse_entry_out now has a extra variable size
>>> struct (the actual handle), it also sets the out_argvar flag to true.
>>>
>>> Most of the other modifications in this patch are a fallout from these
>>> changes: because fuse_entry_out has been modified to include a variable size
>>> struct, every operation that receives such a parameter have to take this
>>> into account:
>>>
>>>    CREATE, LINK, LOOKUP, MKDIR, MKNOD, READDIRPLUS, SYMLINK, TMPFILE
>>>
>>> Signed-off-by: Luis Henriques <luis@igalia.com>
>>> ---
>>>   fs/fuse/dev.c             | 16 +++++++
>>>   fs/fuse/dir.c             | 87 ++++++++++++++++++++++++++++++---------
>>>   fs/fuse/fuse_i.h          | 34 +++++++++++++--
>>>   fs/fuse/inode.c           | 69 +++++++++++++++++++++++++++----
>>>   fs/fuse/readdir.c         | 10 ++---
>>>   include/uapi/linux/fuse.h |  8 ++++
>>>   6 files changed, 189 insertions(+), 35 deletions(-)
>>>
>>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>>> index 629e8a043079..fc6acf45ae27 100644
>>> --- a/fs/fuse/dev.c
>>> +++ b/fs/fuse/dev.c
>>> @@ -606,6 +606,22 @@ static void fuse_adjust_compat(struct fuse_conn *fc, struct fuse_args *args)
>>>   	if (fc->minor < 4 && args->opcode == FUSE_STATFS)
>>>   		args->out_args[0].size = FUSE_COMPAT_STATFS_SIZE;
>>>   
>>> +	if (fc->minor < 45) {
>>
>> Could we use fc->lookup_handle here? Numbers are hard with backports
> 
> To be honest, I'm not sure this code is correct.  I just followed the
> pattern.  I'll need to dedicate some more time looking into this,
> specially because the READDIRPLUS op handling is still TBD.
> 
> <snip>
> 
>>> @@ -505,6 +535,30 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
>>>   	if (!inode)
>>>   		return NULL;
>>>   
>>> +	fi = get_fuse_inode(inode);
>>> +	if (fc->lookup_handle) {
>>> +		if ((fh == NULL) && (nodeid != FUSE_ROOT_ID)) {
>>> +			pr_err("NULL file handle for nodeid %llu\n", nodeid);
>>> +			iput(inode);
>>> +			return NULL;
>>
>> Hmm, so there are conditions like "if (fi && fi->fh) {" in lookup and I
>> was thinking "nice, fuse-server can decide to skip the fh for some
>> inodes like FUSE_ROOT_ID. But now it gets forbidden here. In combination
>> with the other comment in fuse_inode_handle_alloc(), could be allocate
>> here to the needed size and allow fuse-server to not send the handle
>> for some files?
> 
> I'm not sure the code is consistent with this regard, but here I'm doing
> exactly that: allowing the fh to be NULL only for FUSE_ROOT_ID.  Or did I
> misunderstood your comment?

Sorry for late reply.

Yeah sorry, what I meant is that the file handle size might be different
for any of the inodes, in between 0 and max-size for any of the inodes?


Thanks,
Bernd



