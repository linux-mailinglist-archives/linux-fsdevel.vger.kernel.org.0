Return-Path: <linux-fsdevel+bounces-40060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C728BA1BC91
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 20:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 320507A5568
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 19:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59008224AE9;
	Fri, 24 Jan 2025 19:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="uYlR3ig+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C3527726
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2025 19:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737745319; cv=fail; b=FckBFZq1S+tbOtIHpLvZQsRNFcWcdVyKg/cZJXwB+6p6tHKaQfzIjx1hVBZnXEqC57K5QBjqgg7N/AaEHz7tG9gkxcZzBtrFGk1e/iz+eOnHg/IaAYzS37c7nWXn6gQ/XAMnQYdSP2FE+2uyNspYKm1T1anGUQWH7IUSGX/ox8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737745319; c=relaxed/simple;
	bh=tno5xCBOSRePm8nWsMuSVT0OMZ2lVk5On8YSs386dLo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k8jCB5Jjf7pyiQvBoXBHDE/3Q1m71mpt99lFioHsVqDxhIMSxN5hpuA2cKOcF+xSwtaP/lQY5oPEamgI2YGv/ZvjG/m/Fqqa54cR14QasNQWkGmTl6TXhgl3qBRgU3PAH7yNAGBCwmOvV8I6GPVfxtMmtUXtX17Ahw6T1ONM20s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=uYlR3ig+; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43]) by mx-outbound43-95.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 24 Jan 2025 19:01:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HfUkr/wsANLn3T+I0F0WmbRjE9nnIiOr82mGt9Kl8h05QcKBpboN/xvlse83nS094xMiER5FZPysIsNMuXY2J874lyhBtUkOa3RKj2JEajjKahFqShpA26yNcCjkOz7D97gHqIhdHajY8bos7EebmV4VNBjcQ93h2/532FfOwBixYA/fyl6S4e9FQRhGqWs9GNOcy7RwtGwfpaI+ADfCNH65QJXWegw8JtCJ3b4CXW87NCUHJf2S45FFyg5bsHDhZeu7bDyvUmP42OwWwqbSPSkpQDGjdROMl60kqzcz6shvwFmM/KRYiXYOm4Y5V4AHWIHvtm/4hbIrStBhegnSmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uaBkeFrXoEy53Eq8OIZ05Qz3svF2W7NsEwRCc7V91Og=;
 b=EryiAQYDVNMUzqbDhbnFWIYMH2EeXrfoE/aIrcn/a0k4ZYF9zAyrU/N7N7vU/+lJcATKOQihJuyUE9Ox8DZ6VPmGtJ+Q3r9vyjX74FDeBFzXc5rKA3/Z0Ww6L4TqC+1djLEmJUymbv7JCqOVE79Rx3D0ih0wnGXAz0Ht4Seerp6/p1+5BgReg8DD9TZbYTJCSKm6AE+1vFvQicPlhHXJ7LNC1khDd/zOMZDdnTGci+GiwMqHZBeKHRGWHkhjrVOvrEm78qeeysFmNPV4JH13DhEx9YodjBI5NmVjCnNjTedJ/4ng6CjK8vQpLVpnpEvuXD9HF2osQyUBMtAXu1hBiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uaBkeFrXoEy53Eq8OIZ05Qz3svF2W7NsEwRCc7V91Og=;
 b=uYlR3ig+ey5auq5/P/0crq9XhF5qCmtg9F1PpsR/7JDSAjf2B35UZh/MdLp/fAgMKBTh9FL+AzYTF87exiwkU05tf8BZFDSLrABbFLed1otiMbtJEGxc8QqXaOidj1WjSaZLpfbqUH1JGfsY7zc261ufVohi4GB+aA6gZWkX3D0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by PH7PR19MB6708.namprd19.prod.outlook.com (2603:10b6:510:1b6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Fri, 24 Jan
 2025 18:59:45 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%5]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 18:59:43 +0000
Message-ID: <780ec83b-ff47-4b67-b0ea-c4237238775e@ddn.com>
Date: Fri, 24 Jan 2025 19:59:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] fuse: over-io-uring fixes
To: Joanne Koong <joannelkoong@gmail.com>, Luis Henriques <luis@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
 Dan Carpenter <dan.carpenter@linaro.org>, linux-fsdevel@vger.kernel.org
References: <20250123-fuse-uring-for-6-14-incremental-to-v10-v1-0-8aee9f27c066@ddn.com>
 <8734h8poxi.fsf@igalia.com>
 <CAJnrk1Ztw2-sq1NSR5G4YrEx-7dFFK=Yu_-QQDY7Jy1tajqDWg@mail.gmail.com>
From: Bernd Schubert <bschubert@ddn.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1Ztw2-sq1NSR5G4YrEx-7dFFK=Yu_-QQDY7Jy1tajqDWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0004.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19e::9) To CH2PR19MB3864.namprd19.prod.outlook.com
 (2603:10b6:610:93::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR19MB3864:EE_|PH7PR19MB6708:EE_
X-MS-Office365-Filtering-Correlation-Id: a73d3464-7bd5-4245-3587-08dd3ca94380
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dC9PZ2lCdWo4TFN6NVpPdGJnRm1icnZ5Y0l1elE5TDRlWmhNbHJBRkNlYkd2?=
 =?utf-8?B?VzhJUE01QWVRN2xqdEwvOGZxRm1adjVZa2wzbkVhWlBLa3I4RHczWEJMbWRL?=
 =?utf-8?B?L3ZpVkp1OGFiTXdWR25SRTk1ZjNKRUFGOGlFK05QYnRseEEyTW85SVNaTDVN?=
 =?utf-8?B?bWdYWlhLa01uck9GOEJoSVFRbzBaT3FqeXEwVkRRbUNYQlRLUkNOQks5eWIw?=
 =?utf-8?B?aUd2SWIzM1RHSFpscElBM1YyZFdCdEJ3ZVpEWURQY0NIeXg0cTBtVVVkak1D?=
 =?utf-8?B?QWtIZk1GbW1sdVdtd3B0TkZOSzJRT0JlQ1VxUjE3V25GSEV6bHl3RVdGckd2?=
 =?utf-8?B?cDVrbmxldzRLRDg5MFJ4ZFdWMXZKNDFMbHFTTTBrMThuUmhndmhwTnZ3V1dR?=
 =?utf-8?B?K0FzTHREQjVTZ2VWeGYxUHFvUmQ0azMyOHlkaE52ai9oSGtIcExCeVZNRnZQ?=
 =?utf-8?B?T0xpOWpBZGVPZ0NpUUhHK0t2OHNmTkxjSkgwSVZkaTYreHhmcVRKQXFIVlFs?=
 =?utf-8?B?TTFDbEc5ZGhKTzltL25RZnJDRmZ6V2lqa1k0Q0ZhK001WnJveTJvWDlya2J6?=
 =?utf-8?B?cTViZkRuKzFrQXhzRkNFQVJiaTN2UHdTSlZ6NGdkbC9PWXUvVFlqZkZaZ3Z1?=
 =?utf-8?B?Ukg2UDlhWmVzR0RCaytvL2pyMVBOeVVRd05NcnQ0RHoxSnRqT2lOSE1VYXpo?=
 =?utf-8?B?TlBuSnZRSDdpakJ0LzNINWIvVmFmRCt5NG9taGlyRE5qaDl0bUxYKzNyYWx4?=
 =?utf-8?B?TmRaN3E4WG9ncGhZSitCU2pRZDZ6M3AwK1lpc25DaHRKVkxoRlBSbnFkK05V?=
 =?utf-8?B?Q1BTeFkwS01CM2d4VVR5VFcrVURSWnp0ZVYzZVVwRTlMS1VEQWpLZEhKNlZ1?=
 =?utf-8?B?QzdoVm9JblNBWVNIVllxZVN0R3NBZTNHclBIU2FzV0lGWm9VWWwvcklZY1l1?=
 =?utf-8?B?cXZjeXNrMTFVZ3VWRTJmdGZSQU1jR3Z2S0FaZ2kwQTZIckg3V3V2U0wwQ1cz?=
 =?utf-8?B?VGhYSkFyZ3Z6byt0ZVloZWo4aWN2dm1zQ2p5VndNWGhGUWFqMHA2emNxYWNy?=
 =?utf-8?B?OWVnZmZHMWVxUGNjdU5JMHNpdmhBYk0zaFdxK0dxWkJWSnNmRXhXNHRWKzJZ?=
 =?utf-8?B?b1JGNFVtalpRaUpUbDhPaUpkM1BHQ2NGOTJERFl5MUUwcnFCZ1JqWEk5b1ZP?=
 =?utf-8?B?cFhwQ2pacWNVdkhYRy9IdVc5RFVEVkduY21Jb0o1cTZ6RWx2bjdnd0VhQU5S?=
 =?utf-8?B?YkZiZGpvM3lHZENaUU9jRmhVNThTS3FtRXRvSXgxS21oRW9iRnFtOVhub0Yr?=
 =?utf-8?B?Q29VbFVYM2o0QmVQWjBqcUZBMU8weGh3RWIyOWY5OFVXczdsQ0Z6TFJtN1Aw?=
 =?utf-8?B?dHA4SFZpQWFFQXVLMzZUdy9hZU1WWVl0Qm9EcXAydER4Z0t0cHpBcEZTaWJQ?=
 =?utf-8?B?M0s0Ujh2OXVROG5qaGp5YjYrRXpseHlkRlhDeEs3MTFYM3BJaldZa3dxR0FD?=
 =?utf-8?B?YzRmUEt4OGsyOEkybG5jSDRVb2JyczdQSzczdlZ5YmRCYms1Yll2NmdRVlZD?=
 =?utf-8?B?QndvZGRIQXorVjVSUW9xQTFTUlNJVCtHckdIR0tDOFRlNmxsNGw2eWJxUGFj?=
 =?utf-8?B?emRtSEFEWG5HblZ0TGdtS1hGV3haMUxKK2J6WUpkWDU0T2RyVnZEV242U3ho?=
 =?utf-8?B?ek1GdjBCSWZQNnJCL1ZpZC9PTWtKYzhvcHZBUVRCeHowcFpUK0d5cmFUYmhh?=
 =?utf-8?B?SVd6OUtBL0MzUWhLR0VlRW94aU5JYW5pSkd2NUVNdGNkcm5GV2J5UTl6ZlBh?=
 =?utf-8?B?bEdnVSt0UnRubjlhSFFLWDJnNGVISnNWd2NZUHlIeTZzNTBWdEI2VHhnQWZv?=
 =?utf-8?Q?Cbj0BFZMxpfcj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzBkQ3hHU1F5MHV3RWRjZkJRb2R3UUR6enN0QUsxVVFmOVdteVVQUmZtOVBu?=
 =?utf-8?B?aDhtT0FNNjZmdkxQNnpoT0JkN3VlV255VndXYzF4eHZjZHFsVlFNUThkOWZl?=
 =?utf-8?B?TUZvbzR3Y1NPMTUxMVU4R1pMVU1lK3dIb1F4U0VyT0labXJyaVJnODk0VlBS?=
 =?utf-8?B?d0FVcVhGaExqTnBiUVNQNmNTWG50NjBNVk9QTEdqeE9xLzM0cVRmTUhTQmFC?=
 =?utf-8?B?a29VVmJTcS9qWVJkUDJTOTZlSW1qTlFiTzYyUXBBS2hJaktYTkVTakNDdTVt?=
 =?utf-8?B?U0tOTy9pZ1diWDFIajROKy9MQzZZSXVucVE2cWpnMTk5NHBIbzE3bEVKSElN?=
 =?utf-8?B?R2NaZW16c0lRUjR6a2JqQWtwWnRsMUJxeU9KVEtEMVJlMTRaODc4Q2xJKy8r?=
 =?utf-8?B?OGREU1IyYlZ5Z0YvdEFkbitENTBjd29QY3BCdDVreGdmVmxEZ3R2c3RyZnpn?=
 =?utf-8?B?WGdtNHlHaDBXTURGR1czQlBwNEJXbjB3ek5ka2hqRkpPTWo3c0tiWnlvTXZT?=
 =?utf-8?B?V3Q0aFhwWGI0V2tvdDRKcTBONjJOd09zazhOWXRUOHlacFgxODRpSFk0Yldn?=
 =?utf-8?B?bkxtdzcvbkdoTkQwMDVSeTk5eFhLbm1Ea2NBQllRaVc1ci9sZURsYmxFSkdO?=
 =?utf-8?B?dG9jZHMrUzZyNlZnNHUybzE0K2k2NEZobVlFTVJSMk5kODN3eWE3UjFhUnAx?=
 =?utf-8?B?WUh6dUx0TVpQRXFodHhScm1pN25kVm1CNGoxSE9RYTFDS3lYZEpOZnZCVGtZ?=
 =?utf-8?B?OWExc282VlIyU2dJU3ZqWXppNWdjUVV6dGN3bkZpWXZJeEtDRmhmamhDb0lm?=
 =?utf-8?B?Z2F3R0NvUmJTNjF3eVZXd3pnV3pqKzFhSUswYTA5VzQ5aUo3ck1ka3V4MDZR?=
 =?utf-8?B?THFCUkV5M3RRSzF4Y0tyY2VtbmNwV1BIRlcyMVRXallTUzd5NXNvbEprbWht?=
 =?utf-8?B?THcrQmJmb3BhTnpBTXJGNGt1cHoxNTNvREY3NFZ5Tmhvc212WHlXcEpYSDdD?=
 =?utf-8?B?ei8xbko1TkxrOXRoMTVwN3ByMXdvOVMrU29rdTJlSC85aERSWTQ2Q1JsT1Rl?=
 =?utf-8?B?azR4ZU1PK0pWVHVDcWJzeU1VWlFqN1JIOHR4UG4rVWNwNWlVWWNvZVVBOUlk?=
 =?utf-8?B?R3FzWVpDYlpmYStEbUxCbjY2SXNYNGtOYnp3d1BjbDVERmw0amV6NHVRZnl2?=
 =?utf-8?B?N2tXM3BVRytaN1JqY1hqbkNvc1d6Q2M5L0FxZzErcnkyU0hHTWZ1aDNuWmdV?=
 =?utf-8?B?VW1hTnFPOS9wUWFZV1dRNWQ4UjE5VG5RaUdOdk04QXcrRTNNQzN1UVU4MDE5?=
 =?utf-8?B?ZDFodXN2czlXVFZPdy9NOVVqZUM4ZHREMzN3Slh2bkZ2VFNoNXhxdzVvcWRZ?=
 =?utf-8?B?Z1A4ZFU2eVBqdjc0ZTB3YWVuZXFHT3VFQzMzZGlOM3dHYU1jUkNsWUc3UWwx?=
 =?utf-8?B?NEM2dEIzQW1QNkhrTmh4ZE9TVmpWeVQ3UXBJbStkZWtxSW5oQXVMQmVFQkJ3?=
 =?utf-8?B?d1gyMVM4UWVhelB0YmFkWDFXSWtlcVR4T25EWW9pNzExMnErSEh3My9XNXUy?=
 =?utf-8?B?VklHUEtYMkVseDNaYmVJWGFrU1ByaGZCbVZZUFpjdUl3b2tWeTUxbE5uYkZH?=
 =?utf-8?B?QnhQZENOU3dIbXpsUG5xb0QvdmhJUEhRMEt0QnBzUHZiL2NRc203V0NzRkpV?=
 =?utf-8?B?N3djcEVrcHpWbkhXQnhXbFlpQndiV3lOWXI0MkJkVkxpZ3NjME82aEphaHBN?=
 =?utf-8?B?bFozaHhzVkJISFhrUmc4aTc5VnNuaWVMYlYxNFNMYWhmYTJ5RGR0ZG9hTTdT?=
 =?utf-8?B?U3Q3blNTeGZscW5mZUxCZjNiRnBaMmJZZlFYZU1udzFEdkI0c3o0eE44YVEz?=
 =?utf-8?B?TTBDQ0J5MzRTRFZjMG51cUQ5ZXdBekZ3ZlRrcTMxdllMZElFZXl3OGdDWmh5?=
 =?utf-8?B?ZDNpRk4xcHI5Sm5VeGtJbjdUdzR4VFFvOEFGbHVLYk8vSm9ib2g3NzRBNktL?=
 =?utf-8?B?L0VFYkk2T2xRMkMzWGtBdTNMdkRsaStSaWtZZjBSMmMxWG4rdjlwbDVLZlZD?=
 =?utf-8?B?OFFYSXBnMW9ySzAyeURKVGJUWEZFbmdKMFh6TG1DYVV1RVBiRDZlK01qc29N?=
 =?utf-8?B?WGVZUzRCT3RIQ0V3bXdhUE9HdlBlZ3Z1SklzLzZBTjZyQ3BIdDY1M2FUNkZY?=
 =?utf-8?Q?65fiV9jomhwPlrhm5s5WYU8mgqwaHtj9zD0U7HxX6Q8k?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QmKnb2J3WOwh1uNebCd4fohPjYGcm8tLCEK2LoVcMZZvZhyDOc7xhXyLXJY9841hir8ps/GS1ZpgWsl6xt7+kP7Yd4QxsmAa8eJouM+ivzaNTng0Hjvkx0N3+UYjbk/pUyeFsOf5LRDuBT4ZfWQpmgRsICKPChhkte+qzuxWBMYuAcSIPJHmuZFkJEYlkxc26XWaFUw8PFl5kycqOXOZ1BMxEG05KxCzWDqZSl56u+v7lTxoepbpYPzFLJRxyYYjXRdTwqrm9btsMcBACIOSbtp6CR/VV9GlF4rGdXMmxqvn3rAmTnvdo16ya9ddnjKessjRXEMoc/c8xcj36K++Ozgxr8WcM4L/+JlyAFXKnWb9/U4bP/4w7mSZuVVWsJzYDObw2ZM7LEqktiCkisUnsXuzlGozJoA64rGd1K3Y6uUShcxPo4R1niftu0Akaq35/nQLjRAmPYcTUcR+cLl1YL8Q53PxGcw1abeRSgsLT6yOXvD3VDahJr4p8kz0GaCwJFo61JG5vRLb27ISf9FsMAat9JkuZ77kz1/jWZD0hafC1EdOnM/MUwmVVJsbZZic6H24Ntk80Wu7ofmiZVdF5wOTQ3KzJSOY85aqfAj8+8uBVz2hujpDfPvP6et5rqq+MpSpnVtYZC/P7Nwn+QMtkg==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a73d3464-7bd5-4245-3587-08dd3ca94380
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 18:59:43.8448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xeA4JR2nchiM8mHvvAaX562SZ8q4A1oS8VeO68BXuSe6cgfDvyFtIgi6dzyOrEIhbAy5U3YK+X6aJLG6qBoMyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB6708
X-BESS-ID: 1737745283-111103-23751-6250-1
X-BESS-VER: 2019.1_20250123.1616
X-BESS-Apparent-Source-IP: 104.47.55.43
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVpYmhkBGBlAs0dAkLcUwOdHA0M
	LS0MI0zTApycLC2MzcMsncwiTFwEypNhYAvdVNgkAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.262030 [from 
	cloudscan10-152.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1



On 1/24/25 19:56, Joanne Koong wrote:
> On Fri, Jan 24, 2025 at 1:00 AM Luis Henriques <luis@igalia.com> wrote:
>>
>> Hi Bernd,
>>
>> On Thu, Jan 23 2025, Bernd Schubert wrote:
>>
>>> This is a list of fixes that came up from review of Luis
>>> and smatch run from Dan.
>>> I didn't put in commit id in the "Fixes:" line, as it is
>>> fuse-io-uring is in linux next only and might get rebases
>>> with new IDs.
>>
>> Thank you for this, Bernd.  And sorry for the extra work -- I should have
>> sent these patches myself instead of simply sending review comments. :-(
> 
> Sorry for the delay, I haven't gotten to looking at the latter
> io-uring patches (10 to 17) yet in v10.
> If there are any minor fixes, Bernd do you prefer that we send review
> comments or that we send patches on top of the for-next tree? Thanks
> for your hard work on this io-uring series.

Either way is fine.  And thanks for all your reviews!


Cheersm
Bernd

