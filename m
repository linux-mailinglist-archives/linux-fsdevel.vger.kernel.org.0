Return-Path: <linux-fsdevel+bounces-72572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BB5CFBCA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 04:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9227F300A532
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 03:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDD524677B;
	Wed,  7 Jan 2026 03:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WE9hhhRx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012033.outbound.protection.outlook.com [52.101.48.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E648DDAB;
	Wed,  7 Jan 2026 03:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767754830; cv=fail; b=KkFErnwRZ9I1W9jSyKVfPUBOkzFD8bDzRsNMUzIGOfD7DSitvvq3OX+SuDlnQaCh6rwPr4Oy3FPC5omc2ZBTmeWNksxcPvW81/KO+sQkVgLv//yysAitBkryqxTHaZrQOrHa4FAEeGcaL4o3qL/OfrvI/RfGjVI0lVzGFFaKoNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767754830; c=relaxed/simple;
	bh=tTThRk7qlNlSf/9dvQ/K4MlKDp9k8UNOKi+wNn1/leo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WCtgAhTBYs4EuOI8Z1Zyl5FrNBoW3/F0pbA9SecXAX9rcnlwIq1tOaAY+EyKK1TDY0n9GgE3v51yrfBJCqTjyUFxCvpH33Ah+4VSb1fu1B09six+3VPPn8laAaWRrYYNsNxVnZ/a0K0e4H7kMfUsy3agpQUabq2PWRHmDlyld1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WE9hhhRx; arc=fail smtp.client-ip=52.101.48.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kSNCXdN758yaxXeoFBFLYmWh42nTP/NbptMpo72Vkq/Aiczu8m5M7VR3BGta60Ib5kVoxfxpVY5XwTPZ8NQDrXcSVpEPW/B6D/ztBj2Uh7pHsnjAOdx6hhk8O5V62wuUm7lqcoLa5qb1b5q37ESG/9uitb2O0W7k6IDYwPbqF7Mg8eY8wmJO9lx8NhFC4zao1dFdQOq7b1nMhFwDpdVBF86sG8QgkjVoBAqc4FO5Qn28G7ZoOKTUt3SLqn40OAJnmJJ1bnDlX4/uhFSbuCbddLv//PKJBdwF2vhSzekp/6fs+slqMCFDElQlmN9GGprQ8ytXBq+QBz5vLESqK2juPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZnl3oC4digQAWvH4CbBQQ3bsau8gwyRHGS2CBdtOog=;
 b=DmnCfSMAjx+Oozapkxh/LD9iFasGXJ9le32zzd4s0Zm5ZXejSGy2/BMcJ+1bKzEZxcYXcKMdt7omePcOifbAawrKoqRA34IU2+tPvYJWpts4W6G3+BKrvrr2fBK6S/LssJjgJ7wuVNP1AE8jeBKDTUD39ICpwgwO4eKP8gbUspfMi+2cl5zT5F27gcV6Rn5g01GrprOuKDLnfkFHhWvPjjceBEpgDVMaXVpgJM4s6gPrpm3lmfGuyLl+s1RIuJt3ZxCfGHFWoRPQ/d2FPD/P9vROr8XGTVVEdKwEdPDuSIR9tjuuL4f6vOSETWdvYbUY31hU7Yg1dLUuhe43OeUavQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZnl3oC4digQAWvH4CbBQQ3bsau8gwyRHGS2CBdtOog=;
 b=WE9hhhRxrxnqhVRfcAhaKY2y3UzwKepij4bLxbSgzM47MwAm/EOcEEaZeUPy+bEUOTMZC7qMKU7KrTQKHS8H30CizC9vNceeB+kKCZRd1O+p+XhPRt1rMpUdcMEIa2zm9NzzjYr9SjCQHPDNtS0QwwAvvmzdmVcOr42SDvpOyff0kd2SWJB9Munpzy4cwiPTFpE9ZePE3ypOAW2GzgQhf6pqSn5ARMPF/P4y3gvamN1GN05ffI0uloNHAOu30OC0Rbv+Z2/mbCWQdSFDjK/yexqzh8G5ZBd4sYaNE3zhhvhZxOniaRMR8ziegeA6MJCSzHtDENEXHl0EAPZtVemjQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4; Wed, 7 Jan 2026 03:00:19 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%7]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 03:00:19 +0000
Message-ID: <f974d17e-0eeb-44a6-8a4a-a1bdab5af97c@nvidia.com>
Date: Tue, 6 Jan 2026 18:59:26 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] rust: hrtimer: use READ_ONCE instead of read_volatile
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Gary Guo <gary@garyguo.net>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>, lyude@redhat.com,
 will@kernel.org, peterz@infradead.org, richard.henderson@linaro.org,
 mattst88@gmail.com, linmag7@gmail.com, catalin.marinas@arm.com,
 ojeda@kernel.org, bjorn3_gh@protonmail.com, lossin@kernel.org,
 tmgross@umich.edu, dakr@kernel.org, mark.rutland@arm.com,
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
 <4f3f87ad-62f0-4557-8371-123a2306f573@nvidia.com>
 <aV2yBUW7W_dytCUG@tardis-2.local>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <aV2yBUW7W_dytCUG@tardis-2.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0080.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::21) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|BL3PR12MB6425:EE_
X-MS-Office365-Filtering-Correlation-Id: 669d3e56-a4c6-46ef-f152-08de4d98e421
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkloSFZnK3NoYkFPNTloN3JlUVBhYWpyMktLaXVJYW56eTN1NE1mL1pHNkNU?=
 =?utf-8?B?Z1plMUZmQzFwaWhnZzBhaTVOMENDVWdPZmpTVFpsdSsrcTNvSm5EOWhXbmxw?=
 =?utf-8?B?dHJpcUtHUUFkTnFrWndzVVN2Z0krNXFYWG1vZjk0M2NnRTNWUVhWYjhMV2NR?=
 =?utf-8?B?QkhtbzhmRHpoTHc0T3N2QndORDBIV1FiNHo2Q0F4a1lYT2JIRy9EN3BVWitM?=
 =?utf-8?B?S3BaVStFdFgwVjRqTUtHR09VQ0psdG9sSVNTVCtrOGpidGt6Z2RsMTNvWS9K?=
 =?utf-8?B?OVg1cTZqTnNJNzhvUVpMaXp5bGs1RlpZNDVGZEtZMXgvUENNcmNVbWJRYmhI?=
 =?utf-8?B?SzhHMGE1WUhZckp0WjNoY3JPd2M5L042YmtoUlBUQUhvRU5JVXlET01PTTJn?=
 =?utf-8?B?TENnNndCZHZQS29NdDdZUDBQcXVlNGR6QUMyT2tPWEQ5bWl3dWk4ckptWWJX?=
 =?utf-8?B?RXd6Z3lFMHBpYXpSdHFOWDNUUzJIbXBVaGNZditCdytMZ2M2RzdDZXZFd2dZ?=
 =?utf-8?B?QTRZbEpnRm13aWJIcGtzWmk2RHpVbGhNRko0UEFNa1hYdW9ldHR5bXVjYncr?=
 =?utf-8?B?dk1jbFpyOUxUbkV5UVpkRGF3NHhsaXFzVjhBMko3cDVUQ3BPMGxYRkk5cjhq?=
 =?utf-8?B?eG1pbllPbjk0NnNSSUtydWk4OXlVQitCSURrNFU4MnVnQSszM09DTUFZT0No?=
 =?utf-8?B?S0p0cUE5RGhHZ1NzT3BYMXR1dVJESWJmM1hzQTZNNkpmc3J4ZVZYWTNnQ3lZ?=
 =?utf-8?B?U0I5OThDQW5LajFqMGVqNlZIaDFGMCtyK0lZOUx5Rm1RODJ0b3UrcWwxZHZs?=
 =?utf-8?B?Y1ZndkZERXBJVzBNUThyUlVFMEQxd24xdGRVbGQwdmttZ0lHVFNWVTUxT05S?=
 =?utf-8?B?MExpYlpCeXZSYTlZdEtZU2lVeXdZSzcwR0I5eHVkdzdaMSt0STJsSTl1K0Y4?=
 =?utf-8?B?OWhlNHRwNm5wVEswS24vTEoxRnZQeVRxWjBybGVsKy96aUpScGErTnc5eUZE?=
 =?utf-8?B?cUN5SXp5VmJwSFpqd0RCeDZVMzk4eGttZ0toQWR3WHZxVUNPdUxyOGZxbEp3?=
 =?utf-8?B?ZTZFVFpCNXVVWGg1YTA0L3Q1NEdEeGgrZUdFQjVSaWkySDNGSFk0QmxGaDBs?=
 =?utf-8?B?alIzRzJpb0J0NzRJZmg5c28ybmJ1OUZEenNoaUxrWTA1bC9WZkRIMW02Qytw?=
 =?utf-8?B?Q2ZYS2s3d21JcUxYQllnTGJQVkw1dFJwcnVUTUFPc0dBMjRkRnMxTUVucllm?=
 =?utf-8?B?UlJtM1RWUVRSRFdlRXBNQm9OTmhSaTROMEk1OHhzTE05dVJCSzFwbi8za241?=
 =?utf-8?B?NGxvQUwrYXoyZk1uV3J0c1FIYm9PMHJiUFUrZ3gxZk5MbVRWRjB5TmEwMUNB?=
 =?utf-8?B?dXhVSUU5MXBtRWNray9wUkt5c2VQOVg4Q0liUGRxUHpHN2t3bEUyUW40TkMv?=
 =?utf-8?B?bTU3L3BkWk5UT1FCTzFsSFZ2MGw4MFdOejRZQ1FYbURuWXhOdmh5TUt2bGxt?=
 =?utf-8?B?TVZveEY1eVAxalJLL3ZxVG1UeFRUZEUxRi9YMStFTFZCY0pYUzhXYVhDbHJz?=
 =?utf-8?B?SGloaDNWR3hva0ZzSmw0bnVodU9mUEZUZ0c3ZUdOTXBQNjVHT0xRMzNNNVY2?=
 =?utf-8?B?MHM1ODdSWElmM0ExTk02WVllL0orT1BWOEg1czVycjhEbWdRZ0ZkZjh1L0RL?=
 =?utf-8?B?aGpHZXFDZkdmcHVkNEtnLy95amVlc3BWbCtLSGRLTmwxa1ppcE5xc1gvZHhu?=
 =?utf-8?B?Vk0xUGlvNFRpcXhXOS9qK2JDZFVLbjJtRTRzUDloV1JmZGRiNGk5UFRmMzBz?=
 =?utf-8?B?dTVMSmNNVmFGRzR3MFdHZ05GZzJOYlVLTkxBT015TjdNZlUzcmg4QnNMVXVw?=
 =?utf-8?B?NUkxYVA0YldSUE9KdE5lWkZmUXV6bUVFRXFZSVpwUkNNVDZPTzRLUnhadTMv?=
 =?utf-8?B?VlNYQzF4ejl4TW1OK24yQ2hvcTZEOW5sZ0Q0YXdxcC9jTm16bTBOUDFDaWls?=
 =?utf-8?B?NkFCZmF4aXNBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9416.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUovY2pHNTNwL2tvMmZNeGtHK1pyQkowZTVVVEsxRkFRN2tmWnZWYzZiSjJp?=
 =?utf-8?B?RnJrWVJoTXJ0R3dpMUFUbVk0bTllN2UwbnAzTlY1cTFTYTdjdjQyN0RXUlpP?=
 =?utf-8?B?Rm5kR0dVZnVtSWpnQTJsa3pQanI4S082Y3puT2ZTTGs3ZGRldnFhNnlNKzZs?=
 =?utf-8?B?MzlTRlZXSkMyODltUlpqVXM0OGJYSW9XaVhtNXp4Sjd1NmZEaDdPbHdpV3Fr?=
 =?utf-8?B?dmFsc2o1U0pIZmRRU0FUa0hyTlhUK0kydThKeG9nVGpvWlp4RktoWWJRakN3?=
 =?utf-8?B?ZFZYbWplZmNEQ3pNb1gvdWV0MGNHUUZYQ1ZkRHdXdW5WQnM4ZXkzS1NpTy9Y?=
 =?utf-8?B?d0RPenBxZGFldmN0ZU1PWVRoWjZ1OVI2M1NGd1VXbWlZUHRGdzVSb1hSSVkz?=
 =?utf-8?B?YkQxUXl2ZXpSQXBtcUpINlBGalF0VlU5NjJvcUcreEQvc0l2OTFqNWx6dGJj?=
 =?utf-8?B?TzFhYjRrdGhnaktONU1QRlZVcE8xaVhRRjdRb29xNUlROFFybEVwSS9HMjJ4?=
 =?utf-8?B?L0RWOXhvUVFyMEhoeXN3aERtR2N5Qm5Jby9uZ1FWMEt4WGVvS2U4MTNlT3ZN?=
 =?utf-8?B?NDJsTUU5Q3kyZ2UvMW8zREIrN04yYUpCT2JTbThZU1ZRN2x4bmk3bWxzaFgv?=
 =?utf-8?B?bjRTeXFhSFdKYWd3eVR0SG0yZVFHOGN0U2Q5QWlXWElhcUd6enVWYzB4ME5D?=
 =?utf-8?B?SWpuZWVPUW50YVBHNlRkVDNBNlJTUkRkQ3l0VUk1d2xJMkRkclAxbUcxTVUv?=
 =?utf-8?B?aDBzMFpCc2VxWUEwRlBYcG1seDhKR2FHRUFTNHFuR0ZPVTBSeTBIME8rV2d1?=
 =?utf-8?B?Qms0aHo3elRmTHdGaWlZMDNtV2RWNkt1RlNoaExyYjdUN3Z5ZXQ1N1ZBd21l?=
 =?utf-8?B?SVloVllrT05kTEUwVUZYdHhXRVV3YVdWb1JjeFY4ZExzbXY5S3ZIWTR3VU1n?=
 =?utf-8?B?VWFNR1R1SGN4M0Q4RFhSMVNRUzdJc1ZCMXRZalJBVC9zZkZ6NnBoT3NUYkRF?=
 =?utf-8?B?dzFhZVFrRTFVbDJzWVVSMGdyZmlVamNNcFlmU1hoU2lIN1VwdkNRejl0SjRF?=
 =?utf-8?B?OHlIRVhLL3IzRGNnclNvOEY1dE5TUTBQakV5a2k3Nnp0YzB5VFlYeHZ6U0RO?=
 =?utf-8?B?YXJNTVZ6UTJKeDFCcCs5VmZrSDRZZkViK25tR01rN2hlOWZCYkNnKys4MXpU?=
 =?utf-8?B?QTdYS0ZLZHBhczZ1bUtWZWVUa0hPc0pTQjhlQk8vQ1pPdzd0UGN2dm0wVXZS?=
 =?utf-8?B?bUpDSTJybTVuUExMTE05dG5EblIvdFRaNnBzOUpjVWsxMTdDSU5kRHVLR1hV?=
 =?utf-8?B?NWNBVXRxdCtKQVpCWHA0YTVzN1lVOWZkV0N4NzJaM3NWYTZxUndYZkFlMnFF?=
 =?utf-8?B?aHNqZVdhajlDeEJKb3JLalc4RkJwSEFGeVY2MTV6dWdaeGIvcGJKTGNxUkc4?=
 =?utf-8?B?MFFKRndzaWdnQU9zK2NzL3g1YncrdkFzZlQ1VTFxU0NBZ1l4MkVwRE5YWkQr?=
 =?utf-8?B?QjFXd1lWZkI5WlplRUI2K3N3NmhDay92YVJiOHlieksxRzQzaUl3MEdhOENt?=
 =?utf-8?B?RWM2dnlIZXhhMVRxSW5QOTRpZ3BoSGtDU3FzZlUzSEFMTUE0ZHhLa256cjFS?=
 =?utf-8?B?dmt5ZEliY0pvQXhPU212U2wwUXhadmRPM215dmhDelk4alhQNWV4dkFIMSt6?=
 =?utf-8?B?bG9sSG5NQzhJRG5CVnEwUHd2cVpIRjk2ZzdLbUwrK2RRTytxMGNPVDFRZUJj?=
 =?utf-8?B?NEZyeUtIa3M5VE00bm10bDc4OXB4TWpzc2I3dVY0eG9GMXFvS082SjJTaFFW?=
 =?utf-8?B?TEE5Tlltbk9VUmhoejR5YjYrbnQwTXJmcFBaMUNZYk1KRXNCVW5KU3FLUStY?=
 =?utf-8?B?STNjczJaMVlFRkdBSk53ZFhlRitFQTBEb2o2dkFJeGZsdFNWRkNBRjdJanAw?=
 =?utf-8?B?RGdMNUVhZ2t1QnRabVBYcFd4aUFUZVZhN3huMnc0QXRXK3BUYkkxeHNKcWcx?=
 =?utf-8?B?MFZOQXZGTjJwcGVkMGl0b2xIdlRlRDc1N016RUJsc2lwRTgxTC85N2llSGxx?=
 =?utf-8?B?b2x3TzVjc0hmMEtTcnU1aDVuMkZJM21NOGlUaGRIS2NaYUwyRjFhcEZjbXZl?=
 =?utf-8?B?eHJxbFhweFMvLzdLUnFiSXNOaUN5QW5XZmRmdzNwSGZFUlcxSTkwTFBWTEVs?=
 =?utf-8?B?V1ZjSzF1SHF2bUxQTWVMV3RidVlseHFrcTRBRzBOVVRESnFMMW8zaFdDS2tF?=
 =?utf-8?B?K2dZMG42UzgvUVZBVEZ6QVVVbmMxTlpIcVJyUnlic0VFU1ZpNXdLaXlYQm0w?=
 =?utf-8?B?Z0lwK1JKdktsMjdjUkJLcVVCSmo3dUpYNkdEMlJUVWRPOE1oMHlWUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 669d3e56-a4c6-46ef-f152-08de4d98e421
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 03:00:19.2634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cTHcGjig0FctpEpGvWRcdaTeZ0mo8zSL+jlXgwbotmsMMrarY/Gtipba15eGe1PKXLa0dDPpJjtSoyCxSHoUrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6425

On 1/6/26 5:08 PM, Boqun Feng wrote:
> On Tue, Jan 06, 2026 at 04:47:35PM -0800, John Hubbard wrote:
>> On 1/6/26 10:43 AM, Alice Ryhl wrote:
>>> On Tue, Jan 06, 2026 at 03:23:00PM +0000, Gary Guo wrote:
>>>> On Tue, 06 Jan 2026 13:37:34 +0100
>>>> Andreas Hindborg <a.hindborg@kernel.org> wrote:
>>>>> "FUJITA Tomonori" <fujita.tomonori@gmail.com> writes:
...
>>>>> This is a potentially racy read. As far as I recall, we determined that
>>>>> using read_once is the proper way to handle the situation.
>>>>>
>>>>> I do not think it makes a difference that the read is done by C code.
>>>>
>>>> If that's the case I think the C code should be fixed by inserting the
>>>> READ_ONCE?
>>>
>>> I maintain my position that if this is what you recommend C code does,
>>> it's confusing to not make the same recommendation for Rust abstractions
>>> to the same thing.
>>>
>>> After all, nothing is stopping you from calling atomic_read() in C too.
>>>
>>
>> Hi Alice and everyone!
>>
>> I'm having trouble fully understanding the latest reply, so maybe what
>> I'm saying is actually what you just said.
>>
>> Anyway, we should use READ_ONCE in both the C and Rust code. Relying
>> on the compiler for that is no longer OK. We shouldn't be shy about
>> fixing the C side (not that I think you have been, so far!).
>>
> 
> Agreed on most of it, except that we should be more explicit in Rust,
> by using atomic_load[1] instead of READ_ONCE().
> 
> [1]: https://lore.kernel.org/rust-for-linux/aV0FxCRzXFrNLZik@tardis-2.local/
> 

I see. That does put things in a much clearer state, yes.

thanks,
-- 
John Hubbard


