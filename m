Return-Path: <linux-fsdevel+bounces-34519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFDD9C62F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 21:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61086BE0A8D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 18:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E37219E58;
	Tue, 12 Nov 2024 18:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="eV9s6ZZp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F978219CBB;
	Tue, 12 Nov 2024 18:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731437077; cv=fail; b=HNpTPyEUFp0olhXC5KpxSivdsc5k/cg2ONedDWtHfOj2J6jzLrVWWnCYKCSmivfYmlhsJ9bEnadzmHb1zA3uGQiY2Bqr/NYpZb44GQ9G1jhKXZRJu2vNousEKn74VrwC1w/kWlzIMaymCmCbY9QwegyCDG9iGivJrP+SpZFUADU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731437077; c=relaxed/simple;
	bh=w4NAp/8fIsRH7erMMcXnAKkz0dJ8PYqCWc6e3QskWMg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y8hfNikLvvnicOlNCKloqGBr5GgKOk+EBzb6pkML5ZwNRQ6fBJfeqKuZHH3zwvyCz9TxuFd7I6KLp9cxTzBOG2m8rB9hwp1OG8Pv57xQsQkuoTmtMH3NF8ztvm4kq3qlIGJI6StRytkbv+QgS53u+voubhACVEGW42G2NqIFduQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=eV9s6ZZp; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACHYKvd017953;
	Tue, 12 Nov 2024 10:44:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=w4NAp/8fIsRH7erMMcXnAKkz0dJ8PYqCWc6e3QskWMg=; b=
	eV9s6ZZpMMNKMHR1XCjUMDIsp+rd96ye7evHyPMwS+99MRKBBL5pzrB+uDxqQVc5
	uCnEHdybLNq/HTPwu5WJYetJgW2hbiYfVsSf61gqWg6+Laxfpxf1lSRRRa8eYfMi
	x5A9nf1OlVeO2qW9IFYR7qB2V9T7JvPVp31rIUtmheyZp7c82U5zbuBuPCnYAbLL
	QXdmdkpVpOrY2UgEgajZ9W4c/6XXbSVQj3uHH7GRaA3gZMt1SjUkZVOnGswCC5dU
	NQMDhYb2Rd4WC+Gb9L3domSdzAwHLR5bk4CWdmUgCgu2zreaHR9Y2fYNuCqInapa
	mccMfegvlpUonDPbv9pYGQ==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42vbhkrkqa-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 10:44:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WFkxrtJbkkiZhXyVG5Otg7hH8PEGPulYZaax1wrA7xWOQAFPDOnzMjqjQb6306poDcyY55jOi5CLrQlmLPyKzazAswklwloH0ejWTm6Vuv2aXpsPo6LMENjfbVH/h3W3wSGSUqbW+lX7KHbi3CoiXiXWg4c3IZ3J2m4rzpD+E6m2HRva0AfUnEyxBdU9J3Q/l8tB00tTRhn9qkj5RvIH0HuwOpL5mm2Akceg+zx4iSwMwbOOcysgbEtNaZOJ/9B8MrTE/vce7L9nkAetVVCnnLWeMZKxXhWS3fUSCiW50fGVJivoh5lQq4vdkyKCanx5WDWLtrTgG9WFB8oVCkfiJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4NAp/8fIsRH7erMMcXnAKkz0dJ8PYqCWc6e3QskWMg=;
 b=rsPeBqKi5gSFkiLlRA/exbf1ypOvwvoECHfPTvDhUPgmBSfoQLmDUSDL05S5YiHyXXID9Wi4Snfx5Jpim7OnlEItCLINHjXBwjkIfM1hUapRcIZOdeF87QLrusv8bCbrIvQiW3ZDWsXSTf6IU2h6Ur+ou7g0gkbB5i3EWmhuyAGktKgVpVmcz/ytN4UTIRMKz6fx5dQlj2UyHFxZaGZmooWkLon7CpjBFVuSAg6aN4vxH7Xe5ayGZ7h/m2mQHDDwuOFgQoALu4lp8ErUrtXs0VrB/ifAa22ziP65J0+e/DOHr+5g2XWpmOWuG5wEMDHpHy3CiWswf/no1m80VzZNfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by PH0PR15MB5069.namprd15.prod.outlook.com (2603:10b6:510:ca::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Tue, 12 Nov
 2024 18:44:09 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%3]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 18:44:09 +0000
From: Song Liu <songliubraving@meta.com>
To: Casey Schaufler <casey@schaufler-ca.com>
CC: Song Liu <song@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "eddyz87@gmail.com"
	<eddyz87@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "martin.lau@linux.dev"
	<martin.lau@linux.dev>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "mattbobrowski@google.com"
	<mattbobrowski@google.com>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "repnop@google.com" <repnop@google.com>,
        "jlayton@kernel.org"
	<jlayton@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "mic@digikod.net"
	<mic@digikod.net>,
        "gnoack@google.com" <gnoack@google.com>
Subject: Re: [PATCH bpf-next 0/4] Make inode storage available to tracing prog
Thread-Topic: [PATCH bpf-next 0/4] Make inode storage available to tracing
 prog
Thread-Index: AQHbNNyP/8kz7bh9sEuMXmmPH8p6e7Kz8jgAgAAJuQA=
Date: Tue, 12 Nov 2024 18:44:09 +0000
Message-ID: <ACCC67D1-E206-4D9B-98F7-B24A2A44A532@fb.com>
References: <20241112082600.298035-1-song@kernel.org>
 <d3e82f51-d381-4aaf-a6aa-917d5ec08150@schaufler-ca.com>
In-Reply-To: <d3e82f51-d381-4aaf-a6aa-917d5ec08150@schaufler-ca.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.200.121)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|PH0PR15MB5069:EE_
x-ms-office365-filtering-correlation-id: ca25b063-b95d-43a0-1787-08dd0349fe66
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?T1hvL0ZwM1p1UVZUNHRHcmNyT3hyaUJFcnlFczM4bytoTUo5QUhUaFI4TXpU?=
 =?utf-8?B?cXpjVy9EdmxKNjlQSnBvc2NlWkRWSUxFNjNzRE90ZFRnUEkvK3MzdzE4YTlL?=
 =?utf-8?B?R0ZXd0R5U0l3Z3VzZENLeFg5Vk13clNlZ0twazlZak9lbnAzZlFVcStqdklI?=
 =?utf-8?B?VmhXYS9sTHJBQlc5YkozSW9PZlpsbGNzL1MwSmxkcnF0Q2lqQkcvUHVCMVBV?=
 =?utf-8?B?QmszQWl3VlRSRXRWRDJVUGl4bXhHeE5PK3p1a0x2VUY1WStMOGFRT1hzbENE?=
 =?utf-8?B?YURsaGdDT3ZGM1JHa1U0MWNvWFdLNXlKQmlxSytPNEpoOVhIYlN2M0hnRzk0?=
 =?utf-8?B?WUpXTjJNb25CVkttRVZEZThZNm9iczJnczJqR3l6eFFmTS9FeTJSTERiTHJp?=
 =?utf-8?B?UzVpeFkyaFVCcVAvVkxXcDZkeUF5RGZsSUNXN3BkNExTWHMrVkR1MTMzSVk3?=
 =?utf-8?B?ZXUzWFRjZUUzdzNMQ3E2WjZnSjlVZ2h4YUZDcUg3YnBzRStMZjFCc215Rnky?=
 =?utf-8?B?a0lhV0hJUVFtRGtLR1JXc2dzNFBrZ05OZlVoU1lEYXFYUk1nNFp0elZOWkNF?=
 =?utf-8?B?ZUNNNnpGZmJhaTFVamFFdHZzY2VZQm5oRDd0NVNzQ1E4aEI1MnRSMFQ2bzY0?=
 =?utf-8?B?SzJ6NEV3WWNMMWhNajBtT29SNmZsZ1Z1QmFMdStnU3FzU1R5Z0xxR085YkNs?=
 =?utf-8?B?SUZzMmdwWEpsYjdMWGRBQ2QxdklOYjFwcnNjbEtvQXRMQmZjVGlQK1p2b20y?=
 =?utf-8?B?SW5tTGhDOEFiZVBOT2p3WHRRaytiSmpnNkx2ekd4UUcvL3J3aVk1MDEwTjNn?=
 =?utf-8?B?NnZnUUdKYzBIN3JGbXU1clBaZE9wdTV4elNuOE5zbDhMNmlPcjVLRnJSWE9N?=
 =?utf-8?B?NHZiNW4xTFZFTTgxY2M3SFM3QWpHeWpuWkRqNVl6OFFOaGVZOVdSeUJDUjdo?=
 =?utf-8?B?emVsaXdSaEdBL2lpVnlSMWZZTXNaZElvRDJnZEc1dDlRWmxrV2Yra2RnQ3lG?=
 =?utf-8?B?YStaOVVTbmthQlJ0bzByQzlXMW9NOHhOQWl1Zk03cmRLS3E0WTJIeUQxNnl1?=
 =?utf-8?B?MHFEUVQ5VjlyZCtuRU5Jdm0xNDlJQnY3MEd2R2xRdUxFYlNHbjFGbHRoTnpm?=
 =?utf-8?B?Z2tZNXpnOHl0bjlVVTAvRGJMUnlnVVJmeldiR0NpZ1dqME1LejlETWgxTnN3?=
 =?utf-8?B?cGRQU1M3VUtEcXdwa2lPajB5U1ZRejlnZ3VHWGdEMEcrdXJkc1hUKzBRN1RK?=
 =?utf-8?B?cHNHTEIvcVdKVnhac2gyendERVNaaFlic1BnM2pIZWgvbEg5cHJlKzc1OXFw?=
 =?utf-8?B?ak9TZ0t2VFJmVHRlRGdKQzFHODNHWC9QZS9UNEZZVnlpWm5yY3A3QVBUWEpC?=
 =?utf-8?B?NUxsZ3JUVmNuMnZLWS9jZWhsdDFFQ3F5RXdvR09LYndmc1J4ZjhUM1dONSt1?=
 =?utf-8?B?b2psaDZ2Tnl1QnpWNWpMQkFuYVV6d3A3b0paOWVDem5qY2J3SUw3K09MakRO?=
 =?utf-8?B?cmpVSWg4MkF0SDZHaWxXb0w0T012MW9meWVlWm5TQTdHZG5sMEtlZ3pXTG51?=
 =?utf-8?B?dVBjSFVMTk8xSG9qM0hvL0txY2VtQ0ltYkZNaXlkZHlTRDBjQzk1RkhTdXVF?=
 =?utf-8?B?akdrMmJuZDRFQTY1VGRONlZaRDlvdDVxblBFNUpNSGY4Q3JWRU1IdGhEVWU3?=
 =?utf-8?B?T1oyT1pQdVVZTWhkSmNsU1pTY0VaUmh1cEh3cnV2cVZ3RlJqWTZyL2c2T1dY?=
 =?utf-8?B?d2FjQUtXVHpzYWxlaFByVUJkS0J1TS8vL1V6NHBiV2xzbEtTc3FwdTlrNjdy?=
 =?utf-8?Q?GKEXl+6As+WaF9qn00/u5n/cUxHPxFLVhwkxI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y0YyRjZPZEZsUmxLMFpicHZTRXJrajZUY1dDWjBSWE5INGcraXBRcENTeUx0?=
 =?utf-8?B?K3p3WFo0SjhBY1ZKTTFQUHkvMG5FU0VBMG43amhyWEtXZVFDRDdBMEFzMFJP?=
 =?utf-8?B?OFRkdVVGT1lSRFV0UGJjeUtLeGVxWi9IYWxoc3RvNkR0emFQSlhicnlGT0Fx?=
 =?utf-8?B?cjVnNXdHMTl2d0IxcFN3R2U0eEtBYnJSc1A1aUVJb2dDSTFKUTNLcWc5NFdM?=
 =?utf-8?B?MldIOTRLZkM1WmdDakRXenhDV1dOR0FzNmJ5eVU4NFdvcDNVMTlTbmlENEls?=
 =?utf-8?B?S2hPUTM4ODArUDNKUlJpQlhPa0N0OEhHQ2dJVENKZ2dQZDF3VnhPV3BDMlhq?=
 =?utf-8?B?aGJKbjBsZ3NvWVJoNE5pdHF1bUtRV3Y1Y0FSMng4SExEWHZyd0xDS1E0QVZy?=
 =?utf-8?B?U0lmSTVLRmlmV1ZBUEdGU0dHaHM5SWJjRzE3c21JeFBIYjl5RXl6endSMWVS?=
 =?utf-8?B?M2YzL0E4SzlaQ0FwQTN3dnJma0hRb0VLRTV6TnhBSzZsRzZEQ0pjYWcvVUJE?=
 =?utf-8?B?Z3dxbDJ5dTFLMjkyMHNkN0pBL0hkdml5NElaY3VJUnVQbWhMZDVQZXZ6RVFE?=
 =?utf-8?B?UFRlUTJTcyt4V2dGdTBSUHR2T1lmZE5yVzVuMlp4MzJKUjZhK2xwRzJaeXh4?=
 =?utf-8?B?TXlaai9naWVENExZZTh2QlVVK2pyZ0dOU0lwc2daM1E2TS9FRHNDZnNsb0ln?=
 =?utf-8?B?VjlqNE0wcHV1aGp3dlhIWDAzaC91KzJMT3E1aWl2V0tFODF4bEMxNXN5WVh6?=
 =?utf-8?B?NThRbm0wdHpaKzhqbm1rR2Qxc1VzUXJWYWxST1lYb01wZExEV1Yra1dvY2p5?=
 =?utf-8?B?MU5LS0NyblN1K21SYXRuc2JDUFRPaGJQVDNkZ1VOWElodDBUZE1INzI2NDYx?=
 =?utf-8?B?VnFEYTlTdU5WaHlWOExhV3ZMVm9qVWg0d1AzU2FPUmN0YW5ETGkwb0N2Q1Fh?=
 =?utf-8?B?YmVYc2RqSnJYRUFnVG94cktTZmhXeUlPd2hCay9DdU45ekUzOElGekQ1a0Yv?=
 =?utf-8?B?VWkxdzN3ZzVGZTNPYXdqVnRWY0lQSnNQUGdJczU3d0pmMUtiNXBTemF6cWtP?=
 =?utf-8?B?NGFQMGtiTzd5ZjNIRHd1aWVPVlYxM3ZJNnZNYy9HTzhERFhkNnRrSVR6MjJp?=
 =?utf-8?B?MFdROVU4UnF6ZnBia0MvNDRKYTY2YjhTeGZQU2NZaEp6YXJlckpWSFBqWGMw?=
 =?utf-8?B?MEN5RE9QWFhKY1BNdXlVOEYrZmh5SnFUTUE4dlBJT2JWRUlOc294VHFCK3Bt?=
 =?utf-8?B?enJqV0FtYzU5QWpmOWp5YlErS1I0UnIrbTRZaHhyRDVDa0xSSkRKeVBTNUNE?=
 =?utf-8?B?d05mWTVKWkRPS1NtV2ppUjJsWXlNS01scnhyOTFTaGp4L0h0Z1NGQzhqRDR2?=
 =?utf-8?B?bUhoek5KbVNWWWdDNC9FQWxMT1JvM0tsM2pjcEk1M1pZSXpVdEdWZ1RIa05k?=
 =?utf-8?B?T1orZ2Y1b1c1cVducmduWXI5ZFo0TEtTOTA1SmlTbWNlZHNKS1YyZHNiU2po?=
 =?utf-8?B?eEtNVklpSkVOYi9RYjJHTlc1VnR3VjhWcStaYVhNcEVTcDB0MFBDNXNBbWkv?=
 =?utf-8?B?SExYeld2TEF1MEFXcSszTWdQVjhwQWNvb1l0cEpDcEQ0dlRiUkw2SVFzdkRX?=
 =?utf-8?B?ZGlGTk1hcC9EaEhWYUJLemtMcll5WDZRb3hZL1lCY2ZVZzRtYldsOEZhbDdH?=
 =?utf-8?B?YVIxSG9TNVJNY09uVks5K0ZZbUZ0K2ZZamtVWGMwRjQ2ZVo2cUoveEp3cFVj?=
 =?utf-8?B?M09seEo0NFlUbnZpK0trTExHMTZQSSs1aDRRckpHWmhNYzg5MXpmaitpaHB2?=
 =?utf-8?B?U1ZYeG9ZUUlvZmtlcjMzT1MxcWdFekNrWnFYQWZ1TW8wV3k4aVhlNlgzRHdS?=
 =?utf-8?B?Vk43ckV0ck1yWXFCQk5XcFFpVER0UjBOb1dLMFRuLzhpK1U3clAxZFpMWTN2?=
 =?utf-8?B?dXBmLzJmQ0o1T2xnVysvbFBWLzZSdk0wS2JCWEZ3UzQzeG1hb1RuM0VJK1lM?=
 =?utf-8?B?TDF3VXF2RGNyU1lpZ0h4VUdES3FqTnQ5eldjb2p6VHJPMVpibzJtU2dzNTh4?=
 =?utf-8?B?eW4wdzlpWFViNHBtak02MktOTUViUXFIQ1hTcWQxZEowNGt2UEZaby8reUt4?=
 =?utf-8?B?dmtqQ3UrcU9YcjR0dHJseGxlc2M2Q3oyL1RwL1ZIUnlOY0xqZk1CWUxLd0Yv?=
 =?utf-8?Q?73jv85lRk6WzUooSAY0QHvE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F27135A23A778444A80A1E8CA3A0B1E5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca25b063-b95d-43a0-1787-08dd0349fe66
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 18:44:09.1938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kIIzlGCRSxC7xfZSCfSR4Ll5RkVkrU+VX8WlvNJ79OFMyyCjnO8ixSbB2AoT78nXGIbAfiaYb55h/uzH2c2p6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5069
X-Proofpoint-ORIG-GUID: -ZbzmJi_Mm2S0ZtzqATKKykmgstfPAtc
X-Proofpoint-GUID: -ZbzmJi_Mm2S0ZtzqATKKykmgstfPAtc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

SGkgQ2FzZXksIA0KDQpUaGFua3MgZm9yIHlvdXIgaW5wdXQuIA0KDQo+IE9uIE5vdiAxMiwgMjAy
NCwgYXQgMTA6MDnigK9BTSwgQ2FzZXkgU2NoYXVmbGVyIDxjYXNleUBzY2hhdWZsZXItY2EuY29t
PiB3cm90ZToNCj4gDQo+IE9uIDExLzEyLzIwMjQgMTI6MjUgQU0sIFNvbmcgTGl1IHdyb3RlOg0K
Pj4gYnBmIGlub2RlIGxvY2FsIHN0b3JhZ2UgY2FuIGJlIHVzZWZ1bCBiZXlvbmQgTFNNIHByb2dy
YW1zLiBGb3IgZXhhbXBsZSwNCj4+IGJjYy9saWJicGYtdG9vbHMgZmlsZSogY2FuIHVzZSBpbm9k
ZSBsb2NhbCBzdG9yYWdlIHRvIHNpbXBsaWZ5IHRoZSBsb2dpYy4NCj4+IFRoaXMgc2V0IG1ha2Vz
IGlub2RlIGxvY2FsIHN0b3JhZ2UgYXZhaWxhYmxlIHRvIHRyYWNpbmcgcHJvZ3JhbS4NCj4gDQo+
IE1peGluZyB0aGUgc3RvcmFnZSBhbmQgc2NvcGUgb2YgTFNNIGRhdGEgYW5kIHRyYWNpbmcgZGF0
YSBsZWF2ZXMgYWxsIHNvcnRzDQo+IG9mIG9wcG9ydHVuaXRpZXMgZm9yIGFidXNlLiBBZGQgaW5v
ZGUgZGF0YSBmb3IgdHJhY2luZyBpZiB5b3UgY2FuIGdldCB0aGUNCj4gcGF0Y2ggYWNjZXB0ZWQs
IGJ1dCBkbyBub3QgbW92ZSB0aGUgTFNNIGRhdGEgb3V0IG9mIGlfc2VjdXJpdHkuIE1vdmluZw0K
PiB0aGUgTFNNIGRhdGEgd291bGQgYnJlYWsgdGhlIGludGVncml0eSAoc3VjaCB0aGF0IHRoZXJl
IGlzKSBvZiB0aGUgTFNNDQo+IG1vZGVsLg0KDQpJIGhvbmVzdGx5IGRvbid0IHNlZSBob3cgdGhp
cyB3b3VsZCBjYXVzZSBhbnkgaXNzdWVzLiBFYWNoIGJwZiBpbm9kZSANCnN0b3JhZ2UgbWFwcyBh
cmUgaW5kZXBlbmRlbnQgb2YgZWFjaCBvdGhlciwgYW5kIHRoZSBicGYgbG9jYWwgc3RvcmFnZSBp
cyANCmRlc2lnbmVkIHRvIGhhbmRsZSBtdWx0aXBsZSBpbm9kZSBzdG9yYWdlIG1hcHMgcHJvcGVy
bHkuIFRoZXJlZm9yZSwgaWYNCnRoZSB1c2VyIGRlY2lkZSB0byBzdGljayB3aXRoIG9ubHkgTFNN
IGhvb2tzLCB0aGVyZSBpc24ndCBhbnkgYmVoYXZpb3IgDQpjaGFuZ2UuIE9UT0gsIGlmIHRoZSB1
c2VyIGRlY2lkZXMgc29tZSB0cmFjaW5nIGhvb2tzIChvbiB0cmFjZXBvaW50cywgDQpldGMuKSBh
cmUgbmVlZGVkLCBtYWtpbmcgYSBpbm9kZSBzdG9yYWdlIG1hcCBhdmFpbGFibGUgZm9yIGJvdGgg
dHJhY2luZyANCnByb2dyYW1zIGFuZCBMU00gcHJvZ3JhbXMgd291bGQgaGVscCBzaW1wbGlmeSB0
aGUgbG9naWMuIChBbHRlcm5hdGl2ZWx5LA0KdGhlIHRyYWNpbmcgcHJvZ3JhbXMgbmVlZCB0byBz
dG9yZSBwZXIgaW5vZGUgZGF0YSBpbiBhIGhhc2ggbWFwLCBhbmQgDQp0aGUgTFNNIHByb2dyYW0g
d291bGQgcmVhZCB0aGF0IGluc3RlYWQgb2YgdGhlIGlub2RlIHN0b3JhZ2UgbWFwLikNCg0KRG9l
cyB0aGlzIGFuc3dlciB0aGUgcXVlc3Rpb24gYW5kIGFkZHJlc3MgdGhlIGNvbmNlcm5zPw0KDQpU
aGFua3MsDQpTb25nDQoNCj4gDQo+PiANCj4+IDEvNCBpcyBtaXNzaW5nIGNoYW5nZSBmb3IgYnBm
IHRhc2sgbG9jYWwgc3RvcmFnZS4gMi80IG1vdmUgaW5vZGUgbG9jYWwNCj4+IHN0b3JhZ2UgZnJv
bSBzZWN1cml0eSBibG9iIHRvIGlub2RlLg0KPj4gDQo+PiBTaW1pbGFyIHRvIHRhc2sgbG9jYWwg
c3RvcmFnZSBpbiB0cmFjaW5nIHByb2dyYW0sIGl0IGlzIG5lY2Vzc2FyeSB0byBhZGQNCj4+IHJl
Y3Vyc2lvbiBwcmV2ZW50aW9uIGxvZ2ljIGZvciBpbm9kZSBsb2NhbCBzdG9yYWdlLiBQYXRjaCAz
LzQgYWRkcyBzdWNoDQo+PiBsb2dpYywgYW5kIDQvNCBhZGQgYSB0ZXN0IGZvciB0aGUgcmVjdXJz
aW9uIHByZXZlbnRpb24gbG9naWMuDQo+PiANCj4+IFNvbmcgTGl1ICg0KToNCj4+ICBicGY6IGxz
bTogUmVtb3ZlIGhvb2sgdG8gYnBmX3Rhc2tfc3RvcmFnZV9mcmVlDQo+PiAgYnBmOiBNYWtlIGJw
ZiBpbm9kZSBzdG9yYWdlIGF2YWlsYWJsZSB0byB0cmFjaW5nIHByb2dyYW0NCj4+ICBicGY6IEFk
ZCByZWN1cnNpb24gcHJldmVudGlvbiBsb2dpYyBmb3IgaW5vZGUgc3RvcmFnZQ0KPj4gIHNlbGZ0
ZXN0L2JwZjogVGVzdCBpbm9kZSBsb2NhbCBzdG9yYWdlIHJlY3Vyc2lvbiBwcmV2ZW50aW9uDQoN
ClsuLi5dDQoNCg==

