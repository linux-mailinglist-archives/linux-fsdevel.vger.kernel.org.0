Return-Path: <linux-fsdevel+bounces-64795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B474BF4060
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 01:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 109003AB342
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 23:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E81A313523;
	Mon, 20 Oct 2025 23:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="H6Qx7KRg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA97239E6C
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 23:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761002949; cv=fail; b=WbdWcZWkzvxa3+GRgfakj8y8sZmhOi1MdrrxV48yiBdzLSQqMH/9Wa9Vp7xO6GeMEtfpKzvmjLvdfjYDVyHU3geKtGu+tSSjWnf4WMDPntE3MBw+qVt1sc8LJh3y8RXnxOJtpRKXwUEE+tcTYHcSypctG6y2eHhLiKI2NKH/4OU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761002949; c=relaxed/simple;
	bh=ZV4MA0IJzmYag7NGjJczOeO4q94mITD8GLQq3zaf6x8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J6fknteF/0iy+YgLUy+DZtiqJHLbQ4mCSiCHDATTLzEY8Qn3RgkOeazF+iXP0MCHxFEmOUwy89M3BmBYPgbvAamgN7eKRb0Q267I8BnU2ug7lY16T7ANg5LzQvEdY454nOPkDYlSXjyKOHOdmZwevzQs/Ce8exSDBf4YFK/shO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=H6Qx7KRg; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020141.outbound.protection.outlook.com [52.101.46.141]) by mx-outbound23-145.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 20 Oct 2025 23:28:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OtVKCaLd+hJ7fvGNr6FE74HRwRqLms3S4u4+8QFBVeK2SU7Y/NBMCco5j0Y/zOgOL+A8BgKEKZi3FlwOq2jT0Bmig64uBYbIW0qAmJfFirnr1UXGqOdOrpm1GSRkbFJYfwWnbxKlujndRJMCrHhvk64k2kHnNpkFcZTytMnRcViBnYpvWruNdvx7ckyd/1mLDwlMjBkoPN1a0PldrGnfrismkNgqToxzFuO1VUjLqOINiHo8VpZ1AJStnSJkOa+tbjL63uzLbPnzEUIV8hj6EcGCPzmdJ3CdeR3ZFCPBOJkf6998hprOX8grILpXfM7YPl2FlbLaxiMFzAoLyaZv+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZV4MA0IJzmYag7NGjJczOeO4q94mITD8GLQq3zaf6x8=;
 b=LjSVrv+EDyeJFDEdvhOItsDNj1UqGTIGMx9+ztxzRtml5Z4xDFbBa+/eeDQsOwc5SupDwvs7ffPGJQ2W6S2sSILxGMS9yhpuwKqqgKCuq3YwHIMMQ1tUNAS2QAEv9g2pcNmNh4HYDYfQ/m2vdzfXNioLl5wf61RDeyo3RCaHuDdjlGuw/es7UqgYes3KYwaEw2EO2YUJS7ydt/mQnt6bun8Gxi5k7rZ3pY9GFREVpvchqWa0l7qx0vjd7H9w4qeR4DgOjM8g2ZkH1wUfFrT9cTKkJKtxoAvZTcr75Wt9PUh9X+nNS/HBR8d2S8rFkaVxIYzRyd2Qz5ipLoRWvs8EIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZV4MA0IJzmYag7NGjJczOeO4q94mITD8GLQq3zaf6x8=;
 b=H6Qx7KRgZ6LcMX72XoQOoMldeZhNAfFRJ0igefOI11ZkL1rWmxbJkAc9/2WItyUQti4++EZ09p+XaSxQLOJRdS8UIpXGsJOmg0wwmYvegPB8P2l6rTxsO9hHp1njL1w9yYvc/1E++064gLeWhyR11MFbqebIefsexzOuNIA9e9o=
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by DM6PR19MB3753.namprd19.prod.outlook.com (2603:10b6:5:1::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.10; Mon, 20 Oct 2025 23:28:52 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%5]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 23:28:52 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Joanne Koong <joannelkoong@gmail.com>
CC: Miklos Szeredi <miklos@szeredi.hu>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, Luis Henriques <luis@igalia.com>, Gang He
	<dchg2000@gmail.com>
Subject: Re: [PATCH v3 4/6] fuse: {io-uring} Distribute load among queues
Thread-Topic: [PATCH v3 4/6] fuse: {io-uring} Distribute load among queues
Thread-Index: AQHcPGQ7Rp23Ns/yHkOPjlf/mZxQk7THDuYAgARf1wCAAEL5AIAACBUA
Date: Mon, 20 Oct 2025 23:28:51 +0000
Message-ID: <edc030a1-834e-4bcd-a849-5a034a414933@ddn.com>
References: <20251013-reduced-nr-ring-queues_3-v3-0-6d87c8aa31ae@ddn.com>
 <20251013-reduced-nr-ring-queues_3-v3-4-6d87c8aa31ae@ddn.com>
 <CAJnrk1YEvQ6yR_1HCQ4Aoxg1h+nXKYfPanuL8emiV1T3MonVfg@mail.gmail.com>
 <fb571198-c947-4435-aaf4-76932c219889@ddn.com>
 <CAJnrk1b=OJXq7Typ4xaterNPLpEa0q-0OGBMcQ5p14YPkVofyQ@mail.gmail.com>
In-Reply-To:
 <CAJnrk1b=OJXq7Typ4xaterNPLpEa0q-0OGBMcQ5p14YPkVofyQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR19MB3864:EE_|DM6PR19MB3753:EE_
x-ms-office365-filtering-correlation-id: 1cfeb43a-fd42-4694-1135-08de10306ded
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|10070799003|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?eVNhTUdYMWx5NHhieXpJOW1QbDFCNWhGWkx5V2lJWkwveVBOcHNENmkvTFBB?=
 =?utf-8?B?OVAreTc2bUQ5Y1VKYUFmNDRQZmUzQkYwRmxiQVdhU29JMlJqcFAvdkZ3czdl?=
 =?utf-8?B?amtNcXovQjk4djBXZ3RNTmJhdTBGR2UzcWlrK3AvRzJka1FMV0VGZks3THd5?=
 =?utf-8?B?bEtpbVh5bU12NzJvcGxTSG9maElPcmVHM2Z2MHJBTzRYRWFjTzJ6d001NUVt?=
 =?utf-8?B?NXViOWVLQ1RGSnd6YU5GT1gvdy9ibzJ3bFJnWUpMc0p4SFJ5U2RuSEhqaXdz?=
 =?utf-8?B?TU9tbXlnbFM1anowdUo0TEpLQmtCeTRQYXhZYytJS2ZhaGUwTDhMMlVkQUJI?=
 =?utf-8?B?eVJ3QmlKZFlFRTFCdDdXL3dpM2tqczFQMG5LYzBEU1RxYTl3QzlaUTc5clVW?=
 =?utf-8?B?a3VhcVNiWmU1bjJ3WDBVemRpTTludmsvY09MaTN5MzZnMVhVM3IwUlNnOGZs?=
 =?utf-8?B?RDBzem12Wm1jRU5jbC9tZWc5eGdHNTdwRk1jNllWZ3BKUkZmcS9pTnF2b2FZ?=
 =?utf-8?B?cnk5Y1ZNWG5KKzBEVU5Sc0xWWnFKL29BTHFNeDc1bXRMcnJXZDlwZkdTV0ww?=
 =?utf-8?B?NDJKcUFpWUU1Z3JKK1JvMEFRZ0FnZTdkNVNxM0UwWkZDRXUxN29YdnJPWEoy?=
 =?utf-8?B?czVxdUNZT0RKdVJKYkdiRWIrbWdPalpYUEZ0VUJzTlVDc2xWQnNBV1htMlZF?=
 =?utf-8?B?SUpqdVpUYW91MSttbG1ud01kTzZiV1lNZERMRzdzd2dHemhSd2FSd0VvNEZJ?=
 =?utf-8?B?ODU3a1QzdWRuTm44elpyK081eGd6YktVeENBcWNZNkhZaGFrRkYxd3dwbnBx?=
 =?utf-8?B?VFFSd2JaNGh4OW1CNUNsU1NNS2JjRm12V2hxblRTTFAxYy9jRTF2OEduamY5?=
 =?utf-8?B?cHRJVUNuNW9QalpTU1d6TStEblNrY2pYUHRQRTlpbG9wV0g1d3ltVXpPQjIx?=
 =?utf-8?B?a0NCYWZhcnFRV25wd09BcUdZSVI0MVVwWjA1RE9jbmhYdmZtbnNzOXphODZl?=
 =?utf-8?B?U2I0V3RMMjNJRlN2eklodzBpVkQ2TllpdlEzaVRudTNISDJCU1R5VHRyeHZl?=
 =?utf-8?B?SEwwakVQZktUaGpQY3ZjVTFLNHlMbnQwa1h0cy8zUXdVRTVLZTNFUzVLSXhw?=
 =?utf-8?B?T3RsbHR2d2JVVDB1YURUcVJ5ek1nVFhrTGpIWUhoWlQzeHQ0Smp1TUNMS3FM?=
 =?utf-8?B?cjVzZGVsTmtTaFl5T3U5OVJaSmQ2bU4vSkVvSS82RXhCa1dPdkRZMW5FMWxB?=
 =?utf-8?B?QlJUTGV5RTV4enFUcnpDdWI0NmJUQ05HampQQVcwWHRXb083VXZSNWFHMW04?=
 =?utf-8?B?eU5iRmx5VjNtT1IrT01tSE9EcGwzV2xjNnVXcnZJa0FrRFhtdXRVVm01SjBv?=
 =?utf-8?B?eTR2MmdsT0JsdU1jRW5sTmlkdkpuZklCWXNha0p0bDJJd2RsSlpkWjl3U3lj?=
 =?utf-8?B?ZXh2UDdaMGwxMEJ1L05PQllUYmFkcENyOXhEUzVaaHNpbTFtdkQydnUya2tQ?=
 =?utf-8?B?cHJucS96YXZJb2ZMREhQdVVnQXlqMW9nOFpMWElpbERFSFlNTjJlcGQvOVox?=
 =?utf-8?B?OXJ6RzVSdzNnNlY4N0JKbE5kRUVPa0ZSckFsQzRUZklzV284UjJmSlBrMWNB?=
 =?utf-8?B?R1VxSitVWVRFQnN4NU1ZR2VDRUpQcnJHT09mMHhxRG82N1BpTnRuZTZzL1BX?=
 =?utf-8?B?b1NiU2FYNGlYc0trNkFNQkJZa0Q0UWE2cHBXVlNMS0svZlR5cWdJRG9VNzRR?=
 =?utf-8?B?V1N0SmZaVlduSTl4cnlJWk9vWWhjcjFRRFBiODB4eDhRQ0MyVm1nK3BzZXpa?=
 =?utf-8?B?eGhtT0VTa0NsaGdLSkNDZWVQMXZyVWtIYWdYNDNyWTR6eHRxQU1yMVdlZlNq?=
 =?utf-8?B?RzVoWEY1dnRudnNCV1ROUGpaak1LQ050TWJzankwTlZVcFh5OWt3K0ZKRVZk?=
 =?utf-8?B?T2t0YUZVelg5NVR3OUpyVThUTUtXZm4zZEFJSmV6amx1R0hvaTdJdlNOb1lJ?=
 =?utf-8?B?QkljMHZFanc1Z0xCak5iK3dpNm1uZnd0U2Y5bmNZcVNFdnBubWRFY0RhNnpx?=
 =?utf-8?Q?n9HNop?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(10070799003)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aERnTkpyaU5zUnJnbWZBNEc1aVhFUFAxeEt0M0FDWExiUFMxY2xXS1U5dVdC?=
 =?utf-8?B?QzR6WUo2OWwraUlDMEhCcnFQeW94ZncweVNUd3VPQXlQaFY3dTczYmhPbm02?=
 =?utf-8?B?VGV3RW81QjRvRWlzT3lzbGxiRXVHM1VpZGhFcnYrU095ejA2ZHpGcW8zb2lo?=
 =?utf-8?B?QUVIRmFnSGdKYlJaWjV4Nm9PUmFadVl4ZU9KaWNTSERBVXVWU0VzN3BTNmR6?=
 =?utf-8?B?ZWx3Tk8rcm5JYWNNMkk0Z1FHTjhQR1Y1ZnZhMXN3SWdVa0thWXhuV1NJNVFN?=
 =?utf-8?B?aFhOT2FaMmpBY0dLWWR3VkFBVnpPNk5xeUU3Z2tDVU53ZzNqVWJSWU1lVkdY?=
 =?utf-8?B?Mkg0dkJXWldkS0tGdjZObllXS28zU25DZnRteDNxbEhmTEZlVmFmZTBYallB?=
 =?utf-8?B?R0Z1ZGZ4aHBQcVNySEJwbHFFM0ZwS1FRbWFKYk5RRFdBSkhtQjdaQXVWY0NG?=
 =?utf-8?B?R05tTkI3YU14aXpMRnBFazkwcWdCMEo1Rm1lZk9TaHBsY00rMHlTRjZWcGFo?=
 =?utf-8?B?RXJabU45a0hIUGdDaUVXZWJlRkFtZW5vNXZINVdaZjZ2d2Y5alNLeVdPK3ls?=
 =?utf-8?B?c1YxSWxqK2hCcFNoZWFLNk1oR29SbUgrcnVCWDdvM21VOWFwRWtKbWhsR3Vu?=
 =?utf-8?B?Y2dvZEdXdG5CZEtmeTZNWVhKUHJ1b0JJM0RzQ1kyd3BDMm8xenBzQ3JKOXpH?=
 =?utf-8?B?Yngwdll2TGZEOVY1TFpIWExGNW45clF1MkNwTTFqTU5jWjZRdG9BUGZwaHg0?=
 =?utf-8?B?cXNHa2JmaEtYV0JTU3h0OURVVmUrTUlRWW5WOUd6ZHZCbHpoNHBNLzFaTkZx?=
 =?utf-8?B?L0kwRWc5eGdMbGROWCtwMS9VbTh4NnBscThCWlJSdGluNVJRVHlkTWJyZnd3?=
 =?utf-8?B?R1RCNmUvOHo1ZEZSdjNqL2RsQ05HVFJWUkN6NmRPL2xJT0JobEpQeUhXeVlj?=
 =?utf-8?B?SWhHT2dNVFlYcnZYMlM1UFpRdm0zNFhuQWprVCs3RkpRS052bnp0czl4ejdZ?=
 =?utf-8?B?ekI2SmlPSDlzaXFRNjErb2pmcEY4RmVtaW5IY2R0bWtuVXUyNEh5YzdkNnJE?=
 =?utf-8?B?Z0p4eW5DWGF1clZrSFJ0OXdOT2MrcytKb2xPSGNFdWwyY1BJT0F1bjhUcWdT?=
 =?utf-8?B?cFh0N3gzWTdrb2JxbW5jTC8yc0JFb3Z4blJWbEdWanl0NVAvREYzbUJsUkZ2?=
 =?utf-8?B?cDQrbkxId3NMZnA2VzZWdnJ2T1AxeU5ZK1V2NTNuanA3bUVZOElsOEVubmlS?=
 =?utf-8?B?NFM2MVo0OVpwTWVOV0lYb1Bkc2F3Q1FhQkxTeVU1TmF3VmY4Y0crQ052Qmgw?=
 =?utf-8?B?Wk9rNTgxZHVEanFTQ0FBQmRwSTNLV25yeEVmUEh4MWRPYWJ2R0MxbW83WUJw?=
 =?utf-8?B?ZWRaZi9pcEVXRDRhZzRxVVdSVXJMSmxmR3RGQkJsaUlYS25tblloRmgxRTFv?=
 =?utf-8?B?bE13WWNkWVZGNktZNlF1c3J4ZkJKSUVxWUlMMmtTdStnUXJYbW9mdVRQNS9X?=
 =?utf-8?B?dHZjYWtzWUtFQTU5TVR6YTEzU1Fia01CT0tQRCtudzFGQ1k0TFI3aHc2SVlY?=
 =?utf-8?B?K05rOU1sVktQb3czQWlOa3czU01zZ29uTzQ0N2ZxSU5ReDYxNEhFOFNJcUJz?=
 =?utf-8?B?SzlUbHRSb2JPWEJtc1g4dlNkS2ovR1FJV0lCQWpXV3lpOTVKWHh3eVZ4WmtE?=
 =?utf-8?B?SC9vTWJzMUVtS0c0TWQxZktPclFpMk1neXMzKzJnTEZrbHBCbmFtdnMwODB5?=
 =?utf-8?B?dXlScU51YjFuOU91U25FaUhJeE1wd3ArWENXRlJqWE5KL2lTMjVwb0hxeU9a?=
 =?utf-8?B?dWt5eGFyaloxVmMrc2N0ZmlZS3pURHppekdjblkvVGFsQ3NyVURVcHV4SkdQ?=
 =?utf-8?B?RHZrczczTjdtU25ZT2Q1M3BLc3Fmc0xZdkdyeVdGWHJWaWZNemlWYjFzcHBx?=
 =?utf-8?B?eWdoTDNYZmx0ZkZ0dndkd3RGRUd6VE50eVk4NEdYZW1jUVFLS0FXLzBhaUhO?=
 =?utf-8?B?S0VFeWgwUE51TDJycFk3ZWo3bmlHVTIwQWFwOFlQMS9HdmFOZXR4NE1ueHNV?=
 =?utf-8?B?V243aW0xRjgrYVMwQm9jS0UwK0dVd29Jd3lUV28wb0RYTGdaOVplbGJrZHlQ?=
 =?utf-8?B?WC9EQURadVlxNnhra3RBZTBrOHVJZGxLVVpNYk9DV3JlVWRxWFkwMTZSZ0dq?=
 =?utf-8?Q?UcnBMGjfuxMbfj61G8BDsqA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <64304B5F5CC855458D0A63038B756CBB@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FiPZfp5ZGjrQxYq2tXQpD0IJ1i8lIiBovvdsP7PPt4Q9vBZmleCyv1w9cknT1Hi0liJyibV30WszcC1ivIiWkZ48lwU38g2nhKmwL3nwxL0VLKUTJGLuhqajtfF6alWscQA+Cqu/kb+kEsnUc5dthaQUCwnSVFbh2YYWvLCjKiX3a/U8k2eKQpqotAXjrE94ml1Xl0lTnwVrEUkvUbElu1crzqn7wy5GdXGd/IUFDEE8jMrimJU/Aac6s1Z/cC0045Llhpx9lRQ4CLptDGlwZv2wkOjaaDHKJIHsL7x4sw72R1b5lQjty/GTTYCNykHKpy9xmeXTxAbTOs75nYtV4cr7rS1dC52mizjROiUrsraNMskpA/JF1ojiJ2mY1I25E273gK7dJ7Qgi+DOD2Q4DpIohV8qDjQ29T+/34vlu2wxVjfs2ukvNiFh569avmK9FSdOlfLwS4bBP3Ae1RrUHH8J6uewxyTGtvNfbvl/Cm2Ko9SlBjCehPgFzTW7LHSwxlnmDo4rwgFDnJuk8NI6qsADd1PNEbafHmMaCekyeoadljilh2A/L26MIbEVk1t3NSJuprJq+gXFbsx+VqbHxCuRY6wptbBq2ip3NIA9VaLwwJptzehssBC7nq+lK2tDUMe/KltpOVMEAJDjVqLY0g==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cfeb43a-fd42-4694-1135-08de10306ded
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 23:28:51.7103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /CjqYWtd1/tFVuFlF+yC/cD/eXM1//sF2na6N3UbOEwiq7du5Ch0dWgOWNG7yCoEt1r4Wjz3b7dNMAEBSVgJvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB3753
X-BESS-ID: 1761002934-106033-1832-7439-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.46.141
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVhamZhZAVgZQ0CIl1Tg5KS0txd
	Io1SzZyMTIINHMwsDIwMzSLC3N2NREqTYWAK8tFNVBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.268355 [from 
	cloudscan8-136.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

T24gMTAvMjEvMjUgMDA6NTksIEpvYW5uZSBLb29uZyB3cm90ZToNCj4gT24gTW9uLCBPY3QgMjAs
IDIwMjUgYXQgMTI6MDDigK9QTSBCZXJuZCBTY2h1YmVydCA8YnNjaHViZXJ0QGRkbi5jb20+IHdy
b3RlOg0KPj4NCj4+IE9uIDEwLzE4LzI1IDAyOjEyLCBKb2FubmUgS29vbmcgd3JvdGU6DQo+Pj4g
T24gTW9uLCBPY3QgMTMsIDIwMjUgYXQgMTA6MTDigK9BTSBCZXJuZCBTY2h1YmVydCA8YnNjaHVi
ZXJ0QGRkbi5jb20+IHdyb3RlOg0KPj4+Pg0KPj4+PiBTbyBmYXIgcXVldWUgc2VsZWN0aW9uIHdh
cyBvbmx5IGZvciB0aGUgcXVldWUgY29ycmVzcG9uZGluZw0KPj4+PiB0byB0aGUgY3VycmVudCBj
b3JlLg0KPj4+PiBXaXRoIGJpdG1hcHMgYWJvdXQgcmVnaXN0ZXJlZCBxdWV1ZXMgYW5kIGNvdW50
aW5nIG9mIHF1ZXVlZA0KPj4+PiByZXF1ZXN0cyBwZXIgcXVldWUsIGRpc3RyaWJ1dGluZyB0aGUg
bG9hZCBpcyBwb3NzaWJsZSBub3cuDQo+Pj4+DQo+Pj4+IFRoaXMgaXMgb24gcHVycG9zZSBsb2Nr
bGVzcyBhbmQgYWNjdXJhdGUsIHVuZGVyIHRoZSBhc3N1bXB0aW9uIHRoYXQgYSBsb2NrDQo+Pj4+
IGJldHdlZW4gcXVldWVzIG1pZ2h0IGJlY29tZSB0aGUgbGltaXRpbmcgZmFjdG9yLiBBcHByb3hp
bWF0ZSBzZWxlY3Rpb24NCj4+Pj4gYmFzZWQgb24gcXVldWUtPm5yX3JlcXMgc2hvdWxkIGJlIGdv
b2QgZW5vdWdoLiBJZiBxdWV1ZXMgZ2V0IHNsaWdodGx5DQo+Pj4+IG1vcmUgcmVxdWVzdHMgdGhh
biBnaXZlbiBieSB0aGF0IGNvdW50ZXIgaXQgc2hvdWxkIG5vdCBiZSB0b28gYmFkLA0KPj4+PiBh
cyBudW1iZXIgb2Yga2VybmVsL3VzZXJzcGFjZSB0cmFuc2l0aW9ucyBnZXRzIHJlZHVjZWQgd2l0
aCBoaWdoZXINCj4+Pj4gcXVldWUgc2l6ZXMuDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IEJl
cm5kIFNjaHViZXJ0IDxic2NodWJlcnRAZGRuLmNvbT4NCj4+Pj4gLS0tDQo+Pj4+ICBmcy9mdXNl
L2Rldl91cmluZy5jIHwgOTIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrLS0tLS0NCj4+Pj4gIDEgZmlsZSBjaGFuZ2VkLCA4NCBpbnNlcnRpb25zKCspLCA4
IGRlbGV0aW9ucygtKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvZnMvZnVzZS9kZXZfdXJpbmcu
YyBiL2ZzL2Z1c2UvZGV2X3VyaW5nLmMNCj4+Pj4gaW5kZXggMDJjNGI0MGU3MzljN2FhNDNkYzFj
NTgxZDRmZjFmNzIxNjE3Y2M3OS4uOTI0MDFhZGVjZjgxM2IxYzQ1NzBkOTI1NzE4YmU3NzJjOGYw
Mjk3NSAxMDA2NDQNCj4+Pj4gLS0tIGEvZnMvZnVzZS9kZXZfdXJpbmcuYw0KPj4+PiArKysgYi9m
cy9mdXNlL2Rldl91cmluZy5jDQo+Pj4+IEBAIC0xOSw2ICsxOSwxMCBAQCBNT0RVTEVfUEFSTV9E
RVNDKGVuYWJsZV91cmluZywNCj4+Pj4NCj4+Pj4gICNkZWZpbmUgRlVTRV9VUklOR19JT1ZfU0VH
UyAyIC8qIGhlYWRlciBhbmQgcGF5bG9hZCAqLw0KPj4+Pg0KPj4+PiArLyogTnVtYmVyIG9mIHF1
ZXVlZCBmdXNlIHJlcXVlc3RzIHVudGlsIGEgcXVldWUgaXMgY29uc2lkZXJlZCBmdWxsICovDQo+
Pj4+ICsjZGVmaW5lIEZVUklOR19RX0xPQ0FMX1RIUkVTSE9MRCAyDQo+Pj4+ICsjZGVmaW5lIEZV
UklOR19RX05VTUFfVEhSRVNIT0xEIChGVVJJTkdfUV9MT0NBTF9USFJFU0hPTEQgKyAxKQ0KPj4+
PiArI2RlZmluZSBGVVJJTkdfUV9HTE9CQUxfVEhSRVNIT0xEIChGVVJJTkdfUV9MT0NBTF9USFJF
U0hPTEQgKiAyKQ0KPj4+Pg0KPj4+PiAgYm9vbCBmdXNlX3VyaW5nX2VuYWJsZWQodm9pZCkNCj4+
Pj4gIHsNCj4+Pj4gQEAgLTEyODUsMjIgKzEyODksOTQgQEAgc3RhdGljIHZvaWQgZnVzZV91cmlu
Z19zZW5kX2luX3Rhc2soc3RydWN0IGlvX3VyaW5nX2NtZCAqY21kLA0KPj4+PiAgICAgICAgIGZ1
c2VfdXJpbmdfc2VuZChlbnQsIGNtZCwgZXJyLCBpc3N1ZV9mbGFncyk7DQo+Pj4+ICB9DQo+Pj4+
DQo+Pj4+IC1zdGF0aWMgc3RydWN0IGZ1c2VfcmluZ19xdWV1ZSAqZnVzZV91cmluZ190YXNrX3Rv
X3F1ZXVlKHN0cnVjdCBmdXNlX3JpbmcgKnJpbmcpDQo+Pj4+ICsvKg0KPj4+PiArICogUGljayBi
ZXN0IHF1ZXVlIGZyb20gbWFzay4gRm9sbG93cyB0aGUgYWxnb3JpdGhtIGRlc2NyaWJlZCBpbg0K
Pj4+PiArICogIlRoZSBQb3dlciBvZiBUd28gQ2hvaWNlcyBpbiBSYW5kb21pemVkIExvYWQgQmFs
YW5jaW5nIg0KPj4+PiArICogIChNaWNoYWVsIERhdmlkIE1pdHplbm1hY2hlciwgMTk5MSkNCj4+
Pj4gKyAqLw0KPj4+PiArc3RhdGljIHN0cnVjdCBmdXNlX3JpbmdfcXVldWUgKmZ1c2VfdXJpbmdf
YmVzdF9xdWV1ZShjb25zdCBzdHJ1Y3QgY3B1bWFzayAqbWFzaywNCj4+Pj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgZnVzZV9yaW5n
ICpyaW5nKQ0KPj4+PiArew0KPj4+PiArICAgICAgIHVuc2lnbmVkIGludCBxaWQxLCBxaWQyOw0K
Pj4+PiArICAgICAgIHN0cnVjdCBmdXNlX3JpbmdfcXVldWUgKnF1ZXVlMSwgKnF1ZXVlMjsNCj4+
Pj4gKyAgICAgICBpbnQgd2VpZ2h0ID0gY3B1bWFza193ZWlnaHQobWFzayk7DQo+Pj4+ICsNCj4+
Pj4gKyAgICAgICBpZiAod2VpZ2h0ID09IDApDQo+Pj4+ICsgICAgICAgICAgICAgICByZXR1cm4g
TlVMTDsNCj4+Pj4gKw0KPj4+PiArICAgICAgIGlmICh3ZWlnaHQgPT0gMSkgew0KPj4+PiArICAg
ICAgICAgICAgICAgcWlkMSA9IGNwdW1hc2tfZmlyc3QobWFzayk7DQo+Pj4+ICsgICAgICAgICAg
ICAgICByZXR1cm4gUkVBRF9PTkNFKHJpbmctPnF1ZXVlc1txaWQxXSk7DQo+Pj4+ICsgICAgICAg
fQ0KPj4+PiArDQo+Pj4+ICsgICAgICAgLyogR2V0IHR3byBkaWZmZXJlbnQgcXVldWVzIHVzaW5n
IG9wdGltaXplZCBib3VuZGVkIHJhbmRvbSAqLw0KPj4+PiArICAgICAgIHFpZDEgPSBjcHVtYXNr
X250aChnZXRfcmFuZG9tX3UzMl9iZWxvdyh3ZWlnaHQpLCBtYXNrKTsNCj4+Pj4gKyAgICAgICBx
dWV1ZTEgPSBSRUFEX09OQ0UocmluZy0+cXVldWVzW3FpZDFdKTsNCj4+Pj4gKw0KPj4+PiArICAg
ICAgIHFpZDIgPSBjcHVtYXNrX250aChnZXRfcmFuZG9tX3UzMl9iZWxvdyh3ZWlnaHQpLCBtYXNr
KTsNCj4+Pj4gKw0KPj4+PiArICAgICAgIC8qIEF2b2lkIHJldHJpZXMgYW5kIHRha2UgdGhpcyBx
dWV1ZSBmb3IgY29kZSBzaW1wbGljaXR5ICovDQo+Pj4+ICsgICAgICAgaWYgKHFpZDEgPT0gcWlk
MikNCj4+Pj4gKyAgICAgICAgICAgICAgIHJldHVybiBxdWV1ZTE7DQo+Pj4+ICsNCj4+Pj4gKyAg
ICAgICBxdWV1ZTIgPSBSRUFEX09OQ0UocmluZy0+cXVldWVzW3FpZDJdKTsNCj4+Pj4gKw0KPj4+
PiArICAgICAgIGlmIChXQVJOX09OX09OQ0UoIXF1ZXVlMSB8fCAhcXVldWUyKSkNCj4+Pj4gKyAg
ICAgICAgICAgICAgIHJldHVybiBOVUxMOw0KPj4+PiArDQo+Pj4+ICsgICAgICAgcmV0dXJuIChS
RUFEX09OQ0UocXVldWUxLT5ucl9yZXFzKSA8IFJFQURfT05DRShxdWV1ZTItPm5yX3JlcXMpKSA/
DQo+Pj4+ICsgICAgICAgICAgICAgICBxdWV1ZTEgOiBxdWV1ZTI7DQo+Pj4+ICt9DQo+Pj4+ICsN
Cj4+Pj4gKy8qDQo+Pj4+ICsgKiBHZXQgdGhlIGJlc3QgcXVldWUgZm9yIHRoZSBjdXJyZW50IENQ
VQ0KPj4+PiArICovDQo+Pj4+ICtzdGF0aWMgc3RydWN0IGZ1c2VfcmluZ19xdWV1ZSAqZnVzZV91
cmluZ19nZXRfcXVldWUoc3RydWN0IGZ1c2VfcmluZyAqcmluZykNCj4+Pj4gIHsNCj4+Pj4gICAg
ICAgICB1bnNpZ25lZCBpbnQgcWlkOw0KPj4+PiAtICAgICAgIHN0cnVjdCBmdXNlX3JpbmdfcXVl
dWUgKnF1ZXVlOw0KPj4+PiArICAgICAgIHN0cnVjdCBmdXNlX3JpbmdfcXVldWUgKmxvY2FsX3F1
ZXVlLCAqYmVzdF9udW1hLCAqYmVzdF9nbG9iYWw7DQo+Pj4+ICsgICAgICAgaW50IGxvY2FsX25v
ZGU7DQo+Pj4+ICsgICAgICAgY29uc3Qgc3RydWN0IGNwdW1hc2sgKm51bWFfbWFzaywgKmdsb2Jh
bF9tYXNrOw0KPj4+Pg0KPj4+PiAgICAgICAgIHFpZCA9IHRhc2tfY3B1KGN1cnJlbnQpOw0KPj4+
PiAtDQo+Pj4+ICAgICAgICAgaWYgKFdBUk5fT05DRShxaWQgPj0gcmluZy0+bWF4X25yX3F1ZXVl
cywNCj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICJDb3JlIG51bWJlciAoJXUpIGV4Y2VlZHMg
bnIgcXVldWVzICglenUpXG4iLCBxaWQsDQo+Pj4+ICAgICAgICAgICAgICAgICAgICAgICByaW5n
LT5tYXhfbnJfcXVldWVzKSkNCj4+Pj4gICAgICAgICAgICAgICAgIHFpZCA9IDA7DQo+Pj4+DQo+
Pj4+IC0gICAgICAgcXVldWUgPSByaW5nLT5xdWV1ZXNbcWlkXTsNCj4+Pj4gLSAgICAgICBXQVJO
X09OQ0UoIXF1ZXVlLCAiTWlzc2luZyBxdWV1ZSBmb3IgcWlkICVkXG4iLCBxaWQpOw0KPj4+PiAr
ICAgICAgIGxvY2FsX3F1ZXVlID0gUkVBRF9PTkNFKHJpbmctPnF1ZXVlc1txaWRdKTsNCj4+Pj4g
KyAgICAgICBsb2NhbF9ub2RlID0gY3B1X3RvX25vZGUocWlkKTsNCj4+Pj4gKyAgICAgICBpZiAo
V0FSTl9PTl9PTkNFKGxvY2FsX25vZGUgPiByaW5nLT5ucl9udW1hX25vZGVzKSkNCj4+Pj4gKyAg
ICAgICAgICAgICAgIGxvY2FsX25vZGUgPSAwOw0KPj4+Pg0KPj4+PiAtICAgICAgIHJldHVybiBx
dWV1ZTsNCj4+Pj4gKyAgICAgICAvKiBGYXN0IHBhdGg6IGlmIGxvY2FsIHF1ZXVlIGV4aXN0cyBh
bmQgaXMgbm90IG92ZXJsb2FkZWQsIHVzZSBpdCAqLw0KPj4+PiArICAgICAgIGlmIChsb2NhbF9x
dWV1ZSAmJg0KPj4+PiArICAgICAgICAgICBSRUFEX09OQ0UobG9jYWxfcXVldWUtPm5yX3JlcXMp
IDw9IEZVUklOR19RX0xPQ0FMX1RIUkVTSE9MRCkNCj4+Pj4gKyAgICAgICAgICAgICAgIHJldHVy
biBsb2NhbF9xdWV1ZTsNCj4+Pj4gKw0KPj4+PiArICAgICAgIC8qIEZpbmQgYmVzdCBOVU1BLWxv
Y2FsIHF1ZXVlICovDQo+Pj4+ICsgICAgICAgbnVtYV9tYXNrID0gcmluZy0+bnVtYV9yZWdpc3Rl
cmVkX3FfbWFza1tsb2NhbF9ub2RlXTsNCj4+Pj4gKyAgICAgICBiZXN0X251bWEgPSBmdXNlX3Vy
aW5nX2Jlc3RfcXVldWUobnVtYV9tYXNrLCByaW5nKTsNCj4+Pj4gKw0KPj4+PiArICAgICAgIC8q
IElmIE5VTUEgcXVldWUgaXMgdW5kZXIgdGhyZXNob2xkLCB1c2UgaXQgKi8NCj4+Pj4gKyAgICAg
ICBpZiAoYmVzdF9udW1hICYmDQo+Pj4+ICsgICAgICAgICAgIFJFQURfT05DRShiZXN0X251bWEt
Pm5yX3JlcXMpIDw9IEZVUklOR19RX05VTUFfVEhSRVNIT0xEKQ0KPj4+PiArICAgICAgICAgICAg
ICAgcmV0dXJuIGJlc3RfbnVtYTsNCj4+Pj4gKw0KPj4+PiArICAgICAgIC8qIE5VTUEgcXVldWVz
IGFib3ZlIHRocmVzaG9sZCwgdHJ5IGdsb2JhbCBxdWV1ZXMgKi8NCj4+Pj4gKyAgICAgICBnbG9i
YWxfbWFzayA9IHJpbmctPnJlZ2lzdGVyZWRfcV9tYXNrOw0KPj4+PiArICAgICAgIGJlc3RfZ2xv
YmFsID0gZnVzZV91cmluZ19iZXN0X3F1ZXVlKGdsb2JhbF9tYXNrLCByaW5nKTsNCj4+Pj4gKw0K
Pj4+PiArICAgICAgIC8qIE1pZ2h0IGhhcHBlbiBkdXJpbmcgdGVhciBkb3duICovDQo+Pj4+ICsg
ICAgICAgaWYgKCFiZXN0X2dsb2JhbCkNCj4+Pj4gKyAgICAgICAgICAgICAgIHJldHVybiBOVUxM
Ow0KPj4+PiArDQo+Pj4+ICsgICAgICAgLyogSWYgZ2xvYmFsIHF1ZXVlIGlzIHVuZGVyIGRvdWJs
ZSB0aHJlc2hvbGQsIHVzZSBpdCAqLw0KPj4+PiArICAgICAgIGlmIChSRUFEX09OQ0UoYmVzdF9n
bG9iYWwtPm5yX3JlcXMpIDw9IEZVUklOR19RX0dMT0JBTF9USFJFU0hPTEQpDQo+Pj4+ICsgICAg
ICAgICAgICAgICByZXR1cm4gYmVzdF9nbG9iYWw7DQo+Pj4+ICsNCj4+Pj4gKyAgICAgICAvKiBU
aGVyZSBpcyBubyBpZGVhbCBxdWV1ZSwgc3RheSBudW1hX2xvY2FsIGlmIHBvc3NpYmxlICovDQo+
Pj4+ICsgICAgICAgcmV0dXJuIGJlc3RfbnVtYSA/IGJlc3RfbnVtYSA6IGJlc3RfZ2xvYmFsOw0K
Pj4+PiAgfQ0KPj4+DQo+Pj4gSGkgQmVybmQsDQo+Pj4NCj4+PiBJIHN0YXJ0ZWQgbG9va2luZyBh
IGJpdCBhdCB0aGUgYmxvY2sgbGF5ZXIgYmxrLW1xLmMgY29kZSBiZWNhdXNlLCBhcyBJDQo+Pj4g
dW5kZXJzdGFuZCBpdCwgdGhleSBoYXZlIHRvIGFkZHJlc3MgdGhpcyBzYW1lIHByb2JsZW0gb2Yg
YWxsb2NhdGluZw0KPj4+IHJlcXVlc3RzIHRvIHF1ZXVlcyB3aGlsZSB0YWtpbmcgaW50byBhY2Nv
dW50IE5VTUEgbG9jYWxpdHkuDQo+Pj4NCj4+PiBJIGhhdmVuJ3QgbG9va2VkIGF0IHRoZSBjb2Rl
IGRlZXBseSB5ZXQgYnV0IEkgdGhpbmsgd2hhdCBpdCBkb2VzIGlzDQo+Pj4gbWFpbnRhaW4gYSBz
dGF0aWMgbWFwcGluZyAodGhhdCBjb25zaWRlcnMgbnVtYSB0b3BvbG9neSkgb2YgY3B1cyB0bw0K
Pj4+IHF1ZXVlcyB3aGljaCB0aGVuIG1ha2VzIHF1ZXVlIHNlbGVjdGlvbiB2ZXJ5IHNpbXBsZSB3
aXRoIG1pbmltYWwNCj4+PiBvdmVyaGVhZC4gRm9yIGRpc3RyaWJ1dGluZyBsb2FkLCBJIHRoaW5r
IGl0IHJlbGllcyBvbiB0aGUgQ1BVDQo+Pj4gc2NoZWR1bGVyIHRvIGRpc3RyaWJ1dGUgYXBwbGlj
YXRpb24gdGFza3MgZmFpcmx5IGFjcm9zcyBDUFVzIHJhdGhlcg0KPj4+IHRoYW4gZG9pbmcgbG9h
ZCBiYWxhbmNpbmcgaXRzZWxmICh3aGljaCB3b3VsZCBhbHNvIHRoZW4gaGF2ZSB0byBicmVhaw0K
Pj4+IG51bWEgbG9jYWxpdHkgaWYgdGhlIHJlcXVlc3QgZ2V0cyBtb3ZlZCB0byBhIGRpZmZlcmVu
dCBxdWV1ZSkuDQo+Pj4gUmVnYXJkaW5nIGxvYWQgYmFsYW5jaW5nLCBteSByZWFkIG9mIHRoaXMg
cGF0Y2ggaXMgdGhhdCBpdCB1c2VzIHRoZQ0KPj4+IG51bWJlciBvZiBjdXJyZW50IHJlcXVlc3Rz
IG9uIHF1ZXVlcyBhcyB0aGUgbWV0cmljIG9mIGxvYWQgYnV0IEknbSBub3QNCj4+PiBzdXJlIHRo
YXQncyBhY2N1cmF0ZSAtIGZvciBleGFtcGxlLCBzb21lIHJlcXVlc3RzIG1heSBiZSBtb3JlDQo+
Pj4gaW50ZW5zaXZlIChlZyBmZXRjaGluZyBhIHJlYWQgb3ZlciBhIG5ldHdvcmspIHdoZXJlIGV2
ZW4gaWYgdGhlcmUncw0KPj4+IG9ubHkgYSBmZXcgcmVxdWVzdHMgb24gdGhhdCBxdWV1ZSwgdGhh
dCBxdWV1ZSBjb3VsZCBzdGlsbCBiZSBtb3JlDQo+Pj4gbG9hZGVkIHdpdGggaGlnaGVyIGxhdGVu
Y3kgdGhhbiBvdGhlciBxdWV1ZXMuDQo+Pj4NCj4+PiBJJ20gY3VyaW91cyB0byBoZWFyIHlvdXIg
dGhvdWdodHMgb24gd2hldGhlciB5b3UgdGhpbmsgYSBzaW1wbGUNCj4+PiBtYXBwaW5nIHNvbHV0
aW9uIGxpa2Ugd2hhdCB0aGUgYmxvY2sgbGF5ZXIgZG9lcyB3b3VsZCBzdWZmaWNlIG9yIG5vdA0K
Pj4+IGZvciBmdXNlIHVyaW5nIHF1ZXVlIHNlbGVjdGlvbi4NCj4+DQo+IEhpIEJlcm5kLA0KPiAN
Cj4gVGhhbmtzIGZvciB5b3VyIHJlcGx5IGFuZCBmb3Igc2hhcmluZyB5b3VyIHRob3VnaHRzIG9u
IHRoaXMuDQo+IA0KPj4NCj4+IEhpIEpvYW5uZSwNCj4+DQo+PiB0aGFua3MgZm9yIGxvb2tpbmcg
YXQgdGhlIHBhdGNoLiBJIHRoaW5rIHdlIGhhdmUgcHJpbWFyaWx5IGEgc3RhdGljDQo+PiBtYXBw
aW5nPyBGb3IgY29tcGxldGVuZXNzLCBwbGVhc2UgYWxzbyBsb29rIGF0IHRoZSBwYXRjaCA2LzYs
IHdoaWNoDQo+PiB1cGRhdGVzIHF1ZXVlIHNlbGVjdGlvbi4gQmFzaWNhbGx5IHdpdGggcGF0Y2gg
Ni82IHdlIGhhdmUgc3RhdGljDQo+PiBtYXBwaW5nIHRvIHRoZSBsb2NhbCBxdWV1ZSwgd2l0aCBu
ZWlnaGJvciBxdWV1ZXMgYXMgcmV0cmllcy4gSQ0KPj4gaGFkIGFscmVhZHkgYW5zd2VyZWQgTHVp
cyBxdWVzdGlvbiAtIEkgY2FuIHNob3cgdGhhdCByZXRyaWVzDQo+PiB0byB0aGUgbmVpZ2hib3Ig
UUlEcyBpbXByb3ZlcyBwZXJmb3JtYW5jZSwgYXQgbGVhc3QgZm9yIGZpbydzDQo+PiAnLS1pb2Vu
Z2luZT1pb191cmluZyAtLW51bWpvYnM9ezEuLjh9IC0taW9kZXB0aD17OC4uMTI4fSAtLWRpcmVj
dD0xJy4NCj4+DQo+PiBTbyB0aGF0IGxlYXZlcyB0aGUgZmFsbGJhY2sgdG8gcmFuZG9tIFFJRHMg
LSBJIGRvbid0IGhhdmUgc3Ryb25nDQo+PiBvcGluaW9uIGFib3V0IHRoYXQsIGJ1dCBJIGRvbid0
IHRoaW5rIHRoZSBDUFUgc2NoZWR1bGVyIGNhbiBoYW5kbGUgaXQuDQo+PiBMZXQncyBzYXkgeW91
IGFyZSBkb2luZyB3cml0ZS1iYWNrIHRvIGEgc2luZ2xlIGZpbGUgYW5kIGxldCdzIHNheQ0KPj4g
ZnVzZSBpcyB0dW5lZCB0byBhbGxvdyBsb3QncyBvZiBkaXJ0eSBwYWdlcy4gSG93IHNob3VsZCB0
aGUgc2NoZWR1bGVyDQo+PiBiZSBhYmxlIHRvIGRpc3RyaWJ1dGUgc2luZ2xlIHRocmVhZGVkIGRp
cnR5IHBhZ2UgZmx1c2g/IEVzcGVjaWFsbHkNCj4gDQo+IEZvciB3cml0ZWJhY2ssIEkgYmVsaWV2
ZSB0aGUgd3JpdGViYWNrIHdvcmtxdWV1ZSBpcyB1bmJvdW5kIChJJ20NCj4gc2VlaW5nIGJkaV93
cSBhbGxvY2F0ZWQgd2l0aCBXUV9VTkJPVU5EIGluIGRlZmF1bHRfYmlkX2luaXQoKSkgdG8gYW55
DQo+IGNwdS4gQXMgSSB1bmRlcnN0YW5kIGl0LCB0aGUgd29ya2VyIHRocmVhZCBjYW4gYmUgbWln
cmF0ZWQgYnkgdGhlDQo+IHNjaGVkdWxlciB3aGljaCB3aWxsIGRpc3RyaWJ1dGUgd3JpdGluZyBi
YWNrIGRpcnR5IGRhdGEgYWNyb3NzDQo+IG11bHRpcGxlIGNwdXMgYXMgaXQgc2VlcyBmaXQuDQoN
ClNob3J0IHJlcGx5IGJlZm9yZSBJIGdvdCB0byBiZWQsIGxldCdzIHNheSB3cml0ZS1iYWNrIHdh
bnRzIHRvIHdyaXRlIG91dA0KMU1CLCBidXQgbWF4LXdyaXRlL3BhZ2VzIGlzIHNldCB0byBvbmUg
cGFnZSAtIGl0IHdvdWxkIHJlc3VsdCBpbiAyNTYNCnJlcXVlc3RzLiBOb3cgd2h5IHdvdWxkIHRo
ZSBzY2hlZHVsZXIgbWlncmF0ZSBkdXJpbmcgcmVxdWVzdCBjcmVhdGlvbj8NCkFuZCB3aHkgd291
bGQgd2UgZXZlbiB3YW50IHRoYXQ/DQoNCg0KDQpUaGFua3MsDQpCZXJuZA0K

