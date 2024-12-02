Return-Path: <linux-fsdevel+bounces-36292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3048A9E0F34
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 00:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D312B20A7D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 23:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E501DF75C;
	Mon,  2 Dec 2024 23:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="JmfbBDIL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3901D79B4
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Dec 2024 23:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733180656; cv=fail; b=p0JsIazJmAXTN0rUWIyTG5gnVFlN3Yv0v5lDbqinq2MIXcUYyXwuHM3TloKk24FwNBfup/ls2ErshpP68IAGrA5rp9qEHiNRorv9mJp2TyFFx96gSMlI9p5tlKlz3SI2bxf9MjX3Im/uHgVq4Syzj4PWp1t2VRnmHgS7JT6NhAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733180656; c=relaxed/simple;
	bh=PGDhNyfOmS7Iowd/f9yTTRbnhpBHdPP22zJI37wp3Dg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OkzNOTSuT2yK2nY0zNg3ydicoJqr7JlYpiOpMV9O+5I0MNwOIFcIYn1tQIR80XrrY0zKjaeTEYD8Ta1cm0b1pMfQf8R8ITXmGqKIALLK65uSsFA2m4LMh/RyONlfc7UFaVGpTscV7HXWsPKud8f3ieOa1jFJsyFdJXRG0mc8WEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=JmfbBDIL; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44]) by mx-outbound19-214.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 02 Dec 2024 23:04:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aJXU6oMwEsfiFDG4y5WJtaJO1O9YIPEyaXkPnoZ4+A0T+zXhEQaITSY4cJUNksp4kXxPZHYGSZTCHIEDSWG/fgL3KoYYtCXaUm+18uH9tGJBg0WJcSGMcV6rZmUhBDCiYuslWSnDHJzGk2AnFlfG1BXHrkgxrClVfruyHMl1XhulrNlIQm/3easav/KTGaUwalgJoEsBwtCxsFgwYK09p2F3m+2QKJS9Z5IlHCmeBqjy2mrbFRYlx8fyQEaIL4NwwnY+5KdvmqqTuVy/CS1oU6zJlZ9fX3OTw+YcMgiWY3rzYUiWhcWGxoOlWj2EZR5TRw1kHFSywTftpAFfjY7zFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5tX7iLD4mOKUzK5o4KW+RYvlszeMLdrTrViaLmRzwhE=;
 b=GAGWxNenhQURciizWXK/hpuWmZzecNS13XZOzzSmUz/pjnqNDETrgLF2F/3dpc1yJodf29Wnx9lsICteWxJTm6EM9OI7sPqf3+6fjSlu2aSPgt4NUzAIu2dNHWxDgJPb4TW0G7DPVIEpngXVDMPEeqgXHBdYGAKBwaWYRRQaVC6ppxNOSSnioMj/SU32mzZlouaGIRRpNURQboOTGQBj0BryBOQSDtVSbMbs+QYD6SKTPZPnQRX/WlyuyHMYxGIn0azeMvho42Ichn2fyWxa8Ukwbe/Pb++JFlNM+lv2D1+u/2uYpSS+77+y+qfdtIVWp+xg01P+eNqXa/pNywiH0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tX7iLD4mOKUzK5o4KW+RYvlszeMLdrTrViaLmRzwhE=;
 b=JmfbBDIL7pQG7ecoWEZZOBVg0p4CrVbN0onXWI8t0XmKE31KfDl4q97H/NLp+6XpjOuPWl5SY6EmpKckQ05UzSraegm9vcMP91VzUPyxFRQ3wnkFDRbH3g/TaZXA1tSvnO/QeMuZphpWz6XZsVwYRuA44hYxvDCi4xVM2t2+4k4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by PH7PR19MB7996.namprd19.prod.outlook.com (2603:10b6:510:237::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 23:04:05 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%3]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 23:04:04 +0000
Message-ID: <4b83ecf8-eddc-446d-8ac7-7ff4d72003f3@ddn.com>
Date: Tue, 3 Dec 2024 00:04:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: Set *nbytesp=0 in fuse_get_user_pages on allocation
 failure
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Josef Bacik <josef@toxicpanda.com>,
 Nihar Chaithanya <niharchaithanya@gmail.com>,
 Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org,
 syzbot+87b8e6ed25dbc41759f7@syzkaller.appspotmail.com
References: <20241202-fix-fuse_get_user_pages-v1-1-8b5cccaf5bbe@ddn.com>
 <CAJnrk1ZYq1JX9V1_EZm9ZQHLi+Hz7GPKRO_rbDM36+mWX+GUgQ@mail.gmail.com>
From: Bernd Schubert <bschubert@ddn.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1ZYq1JX9V1_EZm9ZQHLi+Hz7GPKRO_rbDM36+mWX+GUgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR3PR09CA0019.eurprd09.prod.outlook.com
 (2603:10a6:102:b7::24) To CH2PR19MB3864.namprd19.prod.outlook.com
 (2603:10b6:610:93::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR19MB3864:EE_|PH7PR19MB7996:EE_
X-MS-Office365-Filtering-Correlation-Id: 5965e878-5672-4609-b803-08dd13259e36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aWtRcWhSdkdRZTZ1TzZiR2s4K3dQVC9MenYxYkNVK2x1dUJaN2I3cUZWU0Jl?=
 =?utf-8?B?WXpIbDZNMWxJNTliLzNzOEwweDRHRnZjbHo1TWR5VHY4THE1RVdUNXc5M1B6?=
 =?utf-8?B?REwxZWZLTFJDKzdOclorWlVycC9xaXNuMm1EUTVBZG9kdnhDMGRVTmtpaHdC?=
 =?utf-8?B?RXRzSFp2aElLeUFxbEZaTlVEeHpxZzdqeWVTMG02enl5UUlPRWRTV0MyNk9Z?=
 =?utf-8?B?ckZYdDkzbEV2S0R6ZHAyNXErYnZwcGZvZ0NMTmtwOE1aZHZseXAwckhPbElj?=
 =?utf-8?B?M2xOTDRmeERsZS9weDJUTU9jUitxL3FjL3BvWkYwbG44aSsxNDl1WHM2N3Zv?=
 =?utf-8?B?NEV0K201c0E2MnorQWJQQUhmelVZeHY1MlhvSEppRFN1VExkL0tJeE8vNy90?=
 =?utf-8?B?R0cvdDUrbFh5UnZNY0NFbUFJRURNaVh0ZjEvdlNPSUp5UU5KUi9ldDZpZVQz?=
 =?utf-8?B?bXBQTHEvMVlGbTRoRUhjQlpPbVJlQnhpZ3BFSHg3RVhndndzK2FXMkY3aFBv?=
 =?utf-8?B?eGVzWndPNEhpdVRzVHF5YWpzdnFsOUYwcnJvK201a1drYXByQ2EyTzZadHhS?=
 =?utf-8?B?VEovOXh4MkJMTHdBVXdWajFhK0IzQ2hLVXdmL0Y1WkdGdHQ3UEVVTGxoQ1hy?=
 =?utf-8?B?eXZRbVhMQnhUVndjQk9zNWJocnV0SUxvbEFnSmgwRXNFOFFoYmhTNURJdXNN?=
 =?utf-8?B?VEE4MWU3VEF6cEFLOTR2Nlg0ZHc0QjZORk1iNGdQTkgzQkZCQ2haQzVDUURl?=
 =?utf-8?B?eFlGQ2hiRHA0Vk1xUmo0VE1xeGNPMVlKVlBoc3lKdGtLMDZWRkVQMzUxWis0?=
 =?utf-8?B?TWtpSzI5S1A1WDMyTDd2SGFUUTNsbXJ5TXpKcjNHcWxKOVIxWEpwU1lvR1ZC?=
 =?utf-8?B?amlGQm9Ja0ZXcGJwWTd0dUdGRlN1V2ZnU1ZhdFFOd1Nlb3l6ZFBkRkRaMlFz?=
 =?utf-8?B?b3pnUXUvMTh3R2tLYXorZDB4a0RUV29mUWl6Y1lFWWl2Q2wvNXU1U1phVG5m?=
 =?utf-8?B?dUd1MkFQbGNzei9xR3QxQ2hvYXBOak9BQzl4VE1vS1VFSEltcUFpSkVaYTdT?=
 =?utf-8?B?eko3SURKclhyUFNsVHFNdTlMWGU1SGFpbkc2Q3gyMHRuZHBWUVF5NVJwOUJo?=
 =?utf-8?B?OEZ6SGZjT1pLN3RRNXg3S2R4MFplY2pQUEdzWnJ0bnlHT2NKMDlHa1VORGpD?=
 =?utf-8?B?NkhPcWdLQWpYMFRqNnF3UnhGZm8zWE9UaDNhdUJYQjBzQk5nYzhJSEFPL1RO?=
 =?utf-8?B?bnpocVpldTgyZi9uZkFkS0xKREdMYTY0RXBSM3VjR3ZOekI0Z2Q5ekpkTERX?=
 =?utf-8?B?SXgzOWRTdndiOGQ0TWRTbEhHYW5VSWpBYWMyZjB4L2pyVjErTVZKUVFsWFcw?=
 =?utf-8?B?ODFjV1ZPdEVlSW5yS3VkYjdTdFBqVys5OVVCTDZ4bkRwb1p0WVk0TDNHSUlQ?=
 =?utf-8?B?SGN4SGw2bksweVZnTlZGL1k2UzF0WGVNUXp6QVFFSVk0bVZ6RHEzNjFiczNB?=
 =?utf-8?B?cFh4QmFuMDFMaFlQMEhwbUoyQnBTZ3gyZ0phd3IrMDBKUWN5SHJET0ZnNEVa?=
 =?utf-8?B?Q3FpZkNZb1Zha3dUWjJ6dkR6aDJXaktHdmszeUEvbGM4SGQwQ3dOelB5bkNZ?=
 =?utf-8?B?MWc1d3kxV0M4cmJzbG95RVQwSjRHeWtFb0dFM0RpK25vT0ZuRDJvbk41UVVG?=
 =?utf-8?B?RVdtbStqUU0wZGZRRmVnYTZnekhvb0ZGcm1QSjN5dUNPNEtCL2s2R1pCOVlC?=
 =?utf-8?Q?MbYkZoQ8NFWwd3wGL0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUdyZlFhc3UvYXJxeHlCMUZHZ2FzSFFIaU1ibW9ITDh3NEpyZnVtWkFHbFhS?=
 =?utf-8?B?T0ZrRmVHSGVWaXNhaVA3VVdrTktld1FBVW0vY0Q5UEZZOTBuRUh3RmV2d1RY?=
 =?utf-8?B?Wm1RaWVvd3k3SitmSSs0c2RkRmJ6Mm90dUZXSGdhVjVyL1lVNVJ1OWxicTM3?=
 =?utf-8?B?NHpIOE9rSUxwTHNRVHJadEZ2djRObVpWNm15VCs5SXRyQVFKUWZDeFh1UWph?=
 =?utf-8?B?OXV4WlphdlJvUUduMG5Oc284VVBhSzZrdDV4L3BaczJCN1gvS0xjM1ZuWU5V?=
 =?utf-8?B?N0p4MEFabm1uY1Y0SFIraDNSRGJVSmhGSjRFZ2NWZzlEZTZ6dnFPc0ZVbldE?=
 =?utf-8?B?TVcyZDFvWDBoc2RSNktCSkdlZHpuYVAxbHR3KzlaR0QyTmJSaXZFRi83SERt?=
 =?utf-8?B?aGIydkE2M2NmZ0RmQUoyTGU4UlBlenp4QzI3bFkvdm9yemhZc3cvVFA4dXJQ?=
 =?utf-8?B?dTcyQXYyS3gyeHJ5UysrN042YWxGei8wK3RPbngxbURwY1dPTWNOU1NDNlpu?=
 =?utf-8?B?Wmt2K1dsWlZybndWaHZpWHZHUHdDLzdSSnI5b1g1ZW83Vkk0RytTMDZhSndr?=
 =?utf-8?B?ckZjUXdGekhqSEdTNXhzV2lnNTlRWFBwaVdTbUpjQmJiQ29wS1lYTGdpMWIy?=
 =?utf-8?B?Q0RIOFhQcENaTVA0VlZ1STVVQnAxZEJTd1lrRnVMOUFWMk9EclE2Mzhjc3Ay?=
 =?utf-8?B?eFB2Z0pZek5jaFJ6L01zK0t1eklLTldnQlc1SE0yWUNIVURtbWp1a3dXdDh3?=
 =?utf-8?B?eHlwRTl4czUxY2tDc1pTRzBvR2tVM3JRcXQzc2ZnL1ZHcmRiTTRQMThUVjF6?=
 =?utf-8?B?Und6ZS9wWW91a1JqZTBTUDFjakpQVmwyanlHdHdkYWg0cEdlNVVTKzdpcGhk?=
 =?utf-8?B?M245ZnhHVjh6dnNpWjVQMFJxKzZsOXpEdE9uNWVka2wxOENlc1ZNWlA0YTdr?=
 =?utf-8?B?Z0VjWjhoR0pmMkFEdGpmbENicXUwODBsN2NyVWoxY0gxaVFaUElqZXJzdEVD?=
 =?utf-8?B?dEViSXNaNi9NRzRYbzR6VkIzb01rSWhXV0xpd2N4UmNtdDFuUEczZlZudnNQ?=
 =?utf-8?B?emJmTFhTcGY2TmZ6dG1raFRHRXlGM3hyNVkweTJzc0Zmb05DL3FDZVBNcnRV?=
 =?utf-8?B?OGZKUUowVFd3SXhDUXNNSzhjbHI3aEVIcWlKa0NFb01kd29Vd2c1bWt0eGh2?=
 =?utf-8?B?a1BwTHRyTjVQOFVjSndRNFF4QnBlTHF5VlZJYThxVkc1djd3NW5BM2lvOEFI?=
 =?utf-8?B?Q3gya1lpUkpWTFQ2dzdjaTMwV1IyeUh3Z2t2Y2dxcFJnRmhxWk5za2RWeDcw?=
 =?utf-8?B?ZG5LT1RlNHNORTFpYVhXMmxZQmxXZG5nZlJ6bkl1N0ZiKzZLR3hmQTRjWDBS?=
 =?utf-8?B?TUZZUjg0RGF5bDllNXNNQVl4Y1VxcU9SMmtsNUwxMi9lNHJ5NUx3cEFubldl?=
 =?utf-8?B?R25kZXhMWDRHbmRBYThtZVNUSmlUamx6bVN1R2dyMjVMdFZ4UENscTcrbjdC?=
 =?utf-8?B?OFpPLytJVktkUW9BMXVtaDJjZjhOUjZHQm5VVUhNMEg4MFN4dWJYYW9zcHQ0?=
 =?utf-8?B?cUQrb2ltb3A4VU1POW1zQnBSSTNYbXR1djhxd0NZRHgzY0E4Nk5lN3dyM0lC?=
 =?utf-8?B?MFphSzF6WGdvSEluV3FlSkNtTFZ2czFGZE1QNllDNDdiVm83cUxtU0g4aVlZ?=
 =?utf-8?B?cHRJaWk4VE4xeEZDNkp4bG5VRkVQMEozQU1xaGV0Zi96Z2xSRUlWa1pRQzVL?=
 =?utf-8?B?UkxDNGdnenNJZ3hQOVo1a0hvaXNnT0M1RHNkKzR1dXBTcWEwdERlUGt6NEww?=
 =?utf-8?B?TThqMGM4YjNUM2V0aEllem80U2VKT2p3NnVoUEorOHk0eEhWcnpLaGhyV0ZZ?=
 =?utf-8?B?RE9tZnlXMnpuQVN4THNGQzZYWkt4TnNnaEYzRzlsSVJOUGtpSjNYV1NMSHZY?=
 =?utf-8?B?RVl3TkZyV1pZaTJLMlZISHJlVDhGN3pzTnE4MG11RTRUUWxaQlNHY1RZYnNi?=
 =?utf-8?B?MkxFRGg5WXE5THgwQ3lzZStZN1pGNUdCU2pOT1Rpb3JZMmhFTzBHVzBTcTJh?=
 =?utf-8?B?RGF5VXljVlZuQitaS0t1UW9KNG0zb0RYZHhwWjBpUDdTRDNjL3hPN2ZhSDB4?=
 =?utf-8?B?NUxZMFJab2VGVlpXbWdEcDVHa0xVOTEvcmdQQld0ckNxc0ZXNTIxaXUvUFE2?=
 =?utf-8?Q?4/p3X3Bzjs19N1/PZyHSVdaK4S3ZoMdJHVqLRGcuN5Ds?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZITkTWcPFSRrfEXvSDssYqiHX4x++/bK4oNSrEXeZJhONos/Etu+tOId/VHXTO0JT3Flov9MZinOSPe3P6kNniyYvc6LNVm5ZhRxXwyE1YDF5r38kS1Wtp8ZyaKMCYjL9SIgdPufoLp1Nthv64HzrdSZusJUv7EQpMdRzPrFATB4OFU09gRQcxu9oHShpta4ZLNcKsJ+2KKb1GtiiE/084fTDwe/hlLpb9saqhP6/AwoU1dcL7vXQl7p6B2m7RkZxfh/Mj/tiV++HxTzYwSTgEY9jwio08dTQrW478hgEJuZAbra8AfbDTiR6ZjZFtL4KY3mpPTfqyFKTsZR1fD9uhPCl+WGT9LNNEvyL7iCJxkaOh92KXMzf7ugPP9OsBllEFxvK7QP/tMWNJK5a6F4GDR5QwzTb99Gwz93uDJi1vSZjUPjBXylT6pxDzmZFiKuF1xVQuer54se/AONEKHMMZh9GrkiFRs+GhjuGn0/kj/LAM+0k7qxuj7P+PtErurnhDPv2F9cp1shWPBVWLNe0E2eio6yBABsZaSA1W8Px+kJ7orh7BzsavjwuRmRQsRkHEZHXBmyJS88oI8RZG0oT8jHD1N79J0MQwbdCQgPnKQ0cdN7pNViRmeKH1B4BcTf41TxJdiQvpCcP/gmgAhrNw==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5965e878-5672-4609-b803-08dd13259e36
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 23:04:04.7953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7RNOTyxguplkNvSy1Ss44RsMrttJtBWscIYM1n74ZSHLBvM8GsC7XA41M/tHCavxG94FQTMeoW1T6ytXvNh5wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB7996
X-BESS-ID: 1733180648-105078-5483-19431-1
X-BESS-VER: 2019.1_20241126.2220
X-BESS-Apparent-Source-IP: 104.47.58.44
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkbmhmZAVgZQ0NLI0jw52dDEws
	LEMsnQxMQkOdEw0TwlNTnVyNzIwDBFqTYWAEgssBdBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.260846 [from 
	cloudscan16-65.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1



On 12/2/24 23:37, Joanne Koong wrote:
> On Mon, Dec 2, 2024 at 2:10 PM Bernd Schubert <bschubert@ddn.com> wrote:
>>
>> In fuse_get_user_pages(), set *nbytesp to 0 when struct page **pages
>> allocation fails. This prevents the caller (fuse_direct_io) from making
>> incorrect assumptions that could lead to NULL pointer dereferences
>> when processing the request reply.
>>
>> Previously, *nbytesp was left unmodified on allocation failure, which
>> could cause issues if the caller assumed pages had been added to
>> ap->descs[] when they hadn't.
>>
>> Reported-by: syzbot+87b8e6ed25dbc41759f7@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=87b8e6ed25dbc41759f7
>> Fixes: 3b97c3652d91 ("fuse: convert direct io to use folios")
>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> 
> Nice catch! I totally missed that just returning err isn't enough.
> Thanks for fixing!!
> 
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> 
>> ---
>>  fs/fuse/dev.c  | 3 +++
>>  fs/fuse/file.c | 4 +++-
>>  2 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>> index 27ccae63495d14ea339aa6c8da63d0ac44fc8885..2b506493d235e171336f737ba7a380fe16c9f825 100644
>> --- a/fs/fuse/dev.c
>> +++ b/fs/fuse/dev.c
>> @@ -803,6 +803,9 @@ static int fuse_copy_do(struct fuse_copy_state *cs, void **val, unsigned *size)
>>                 void *pgaddr = kmap_local_page(cs->pg);
>>                 void *buf = pgaddr + cs->offset;
>>
>> +               if (WARN_ON_ONCE(!*val))
>> +                       return -EIO;
> 
> We should never run into this case so it makes sense to me to also not
> have this line in (to reduce visual clutter in the code) or to just
> have this be WARN_ON_ONCE(!*val);
> 
>> +
>>                 if (cs->write)
>>                         memcpy(buf, *val, ncpy);
>>                 else
>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>> index 88d0946b5bc98705e0d895bc798aa4d9df080c3c..a8960a2908014250a81e1651d8a611b6936848e2 100644
>> --- a/fs/fuse/file.c
>> +++ b/fs/fuse/file.c
>> @@ -1539,10 +1539,11 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
>>          * manually extract pages using iov_iter_extract_pages() and then
>>          * copy that to a folios array.
>>          */
>> +       ret = -ENOMEM;
>>         struct page **pages = kzalloc(max_pages * sizeof(struct page *),
>>                                       GFP_KERNEL);
>>         if (!pages)
>> -               return -ENOMEM;
>> +               goto out;

Hi Joanne,

sorry, just noticed that unconditionally setting -ENOMEM might cause
issues - sent out v2, but kept your review. Hope that is ok.


Thanks,
Bernd

