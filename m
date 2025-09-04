Return-Path: <linux-fsdevel+bounces-60300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13431B44815
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 23:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3711C1C8315A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 21:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D9A296BD0;
	Thu,  4 Sep 2025 21:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V8XjZpIo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2067.outbound.protection.outlook.com [40.107.95.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50BC296BBB
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Sep 2025 21:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757020055; cv=fail; b=RSyInJ++qpgFvbjJH6DyZLhsOYVyw03ApBqg3QIvT6q4bJWAJK0og2CreQPaqVNqQd0WtwGmWCu3Sf+NBRueJBfamBJ8OsRvZ9D0O7Xl28mIMxowQsuScHPUkEMVaVZrDRtlUc71lUZuO+g0ubgCAYIjRb6LqhLRTL/ssh9OAEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757020055; c=relaxed/simple;
	bh=WJzabyRs0rbVZ+AfrWsi9ubPXBBXawTaMRc0s9k4G0w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EO5xhlN/9pCBlx4ZTagBMupilciYdc5Ov9JuOTA3MYj4E1NDoPYgfIHnJleJPZgpPq42w9inl/fvCwKrv0LoW88NV7hMKPStB/bXgPCwAiIKfI8FUM6eS9DNHn48MlGstGxketX4vwn/eqG0KeraqAnhCz1qED5evqMMLkSzv1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V8XjZpIo; arc=fail smtp.client-ip=40.107.95.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j8MN/w/XAsqoBgThFPO1I1ZkXRFsh4Fqgh60UCbwBkz3sZDY5toIXsEAtnG9uOQxbART0SzyBeFSybIt/2/NFRkXLnTxPEZH3k41YXpZyGw5dTHRHlSUVEEFmYtNEAI8+Ln0lXVuCB4TH/nBmvQikvZ6emKVTYEt30Qt3EfCdn4BDXzYVQvX0DFhwmpfXDpuLBBYrg/Yh9tPYRGvEEvp1PBIVFiXPvo1U3BS/ZQ/jH3BlpU5RBokT0xb7Tuta+nuzbI7uBWs/58j8j/ZzTB5nH6ASg17C3C4ETOy/Xni40nCZSEhSNHtLxyXGs+VggaCQUi6fK+Z874Urugk7qDh/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DJqObFM130Mqjs/kAl3oSU3HaudIYcj+c8qinlOU7A=;
 b=IOHWtIYCosPg7SOBCIm0AASsY4+6b9gloWm92mGfHKRYinS9O9wmWhFMZYSQUEPYqq6NS2n6xTGw+AN/Z/Zjv/0oSid3Kicg1r7ItAxvQNodxwj5K1UhFmA2apZ5caP4tdeIXck3O0d3s97XFROxNI4Ov6WInRzq9Z89KMfaHGAYnu20bJfav7dUjf/mZQYrYDsfrDkH31/2UfddTq1tFfRPVMnibsiwXdhCORhyC40SRcTVEkyOjUzJgLfohDUvAX0QAn7pSq8ZuQwgixvoO2CRSKJ1lD+fe5te2o/Z3PyY4BGME5mJGlSQIDIL5PpEyjew/a7r4OQWG9fzLKV4jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DJqObFM130Mqjs/kAl3oSU3HaudIYcj+c8qinlOU7A=;
 b=V8XjZpIoqpCHAPVk8WNgkp8G4QyWKDRjNqWPdR7n+R02BHQzZrJNBzFPBU+xlfvxDQdZtzRcy1mYAb2vdKra++HlIgpea+6AiSo8X3W0CYxuIQXMHgr1E3I+WekmbOgDfTUBUowEG5fLE2rlgHAZgdwsPehdLRzEl/rz96xvDjc8cM4/XmAvXA7s2QPgFR58WgJJlH/+Wdn4T4lXp3zKThCgSzhv1bvvpv5DhuGTAdIfh7IpiUNvstgJrEoHzFc4MvUpyhVYUMftKBf/9WxsimPQ4tNAhPbfBBJgjvjRpsRHwDEbimS5G/klH8/qR4hoeb8ul3bB7t7GYGdH6I75IQ==
Received: from BL1PR12MB5094.namprd12.prod.outlook.com (2603:10b6:208:312::18)
 by CH3PR12MB9077.namprd12.prod.outlook.com (2603:10b6:610:1a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 21:07:29 +0000
Received: from BL1PR12MB5094.namprd12.prod.outlook.com
 ([fe80::d9c:75e0:f129:1eb]) by BL1PR12MB5094.namprd12.prod.outlook.com
 ([fe80::d9c:75e0:f129:1eb%6]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 21:07:29 +0000
From: Jim Harris <jiharris@nvidia.com>
To: Miklos Szeredi <mszeredi@redhat.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 4/4] fuse: add prune notification
Thread-Topic: [PATCH 4/4] fuse: add prune notification
Thread-Index: AQHcHBe8NaGypsm8bUq3QBN7h6whwbSDh5sA
Date: Thu, 4 Sep 2025 21:07:29 +0000
Message-ID: <C28127D1-D1AC-4F85-AB84-E77A50C39FE2@nvidia.com>
References: <20250902144148.716383-1-mszeredi@redhat.com>
 <20250902144148.716383-4-mszeredi@redhat.com>
In-Reply-To: <20250902144148.716383-4-mszeredi@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5094:EE_|CH3PR12MB9077:EE_
x-ms-office365-filtering-correlation-id: c9a27e01-480c-4d81-9855-08ddebf70e9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NW5QT29iUHpoK3lIam1MVTZZZGk4SnpPb3NjT0VEc0h6a0djY0pPTHlXZURm?=
 =?utf-8?B?TUdrNFk4MXFTQVZwM3ROek1rTlJEZjlhYjE0VnZiZHFpTGxJK0xSd2V1S0I5?=
 =?utf-8?B?ZXV2c1lDdk1Ebks1U25FMFp5UC9tS0R1RjNUNXgxYXkwT0phSm1ON0N0RlBp?=
 =?utf-8?B?eExneVJZV09WbDVvY1ltcFlObTF3RDZjSnhkeXpDSk4wb1BvdkJ6aGNndnVm?=
 =?utf-8?B?K1F3US9FM1paNnNqdy9kYitCZ0Y2NStGZXpHY1FzYTNpSWZGRC90K3VJWHZa?=
 =?utf-8?B?ckZOYVdtWTdJaUYwbUM5c1dTekpXRFQ1ZFJNekw0ZFE2WU5aSXpmdVJXbFZW?=
 =?utf-8?B?K3JiS2IrVmdJUEVSaWpZRTE5c0VrTmU0Q29WTTFwaVp6RDNsSElQK01ZMjlm?=
 =?utf-8?B?WDlkcll3T2ZweHd1c3h0SysrUW82U25FYnNVejMzenRkMlNQaG8xbFlxYkJl?=
 =?utf-8?B?TU9iek9wODZVbFV1VnZ2WGhDL0xvTUJva0JMOHF4UTZocHZ3MzRCVUR6c3Bk?=
 =?utf-8?B?a2E3a0ZlNURxbEFnVkV4RTBQUEV2RnQyZEluaDNHbFZSc01PZjZBQVBqQUJK?=
 =?utf-8?B?emp2Zkxyd2JBWTRERjhyTTlJcXJPM1N6WGhqSTVIcmQxdnZFQThRMWNVR1dG?=
 =?utf-8?B?QzJDTHNGcDJCSHdjUGNXUEExSFVqWjNvYlowNjhPOFQ3a3ptTkZ2eTBKbEtW?=
 =?utf-8?B?S0gxTlNjRDYxbWRFVXZaSmZ2TEsrQkhBTkdnTDQ3ck5NbGtSMHNGd1RyQ0JC?=
 =?utf-8?B?Qlk1dVg0V2h3UXpSZ3V6eU9RWVZSdENhbXNVMjZWTmFHOVl0V1JVZEpjTkYy?=
 =?utf-8?B?N3ZqVHp6NWJYK01pREpsK0lQMElOUmVrY25Xc3hGcnVUMXZJR3d1R2lyYjdl?=
 =?utf-8?B?UW1VN0FEQ3lERzhQZ3BDT0YrV2dwUmhoUWYzTEI3bU51YjhvTjR3QlZ2QUJz?=
 =?utf-8?B?aWp4ZStxZnIvWldNRDRnc1BuS1crSERjeHhnL1c4SXFDYm9OUUtrb1l5YmZu?=
 =?utf-8?B?UE9DRTNoLzRJejUzZS9SdlVIU0R5ekY1QWZac3hhdXhtMTNubEVNVGRHaHBY?=
 =?utf-8?B?SFlYb045OXhhdmxxQm5VcGxMVFJHZWxvV1NycWVtekZXRW1rbFZnUXVhTjBV?=
 =?utf-8?B?RXZYUGJvMjdSd2k2bGR4NzJWdmwyOEg2eVVOZGl1dE0vVmM2SDR0b0NXRGYv?=
 =?utf-8?B?M3NJMWZmYkJMTUh5a1RBNHE2TnhlSlN0ZENGdHBaSTBQSkd5b2VJbXNSZUlz?=
 =?utf-8?B?WVE5NmZOT2RNU0ZhQ2I5RTVPYjg5ZXZmdSt0Q1dHam9Sa2JiY2tCNi92RUlD?=
 =?utf-8?B?Y3NBTWw5clcwRXBlbEdMQnU0VkxwN3ZVdThZQ3lNVHVkVHFINzhRNmRpQ25w?=
 =?utf-8?B?MnhoWlpwMFFxWFpIYWFicDlMR1hidXIrV2s5N20xUDRtWXovSkxibmRZZ1Zs?=
 =?utf-8?B?anFtaU5mM2JzSmJ3dTlURXNlVWhGWUwwa0pkK1ZHalBKZGFwRitpdHZRVGxj?=
 =?utf-8?B?Z05zeDJLbm0zS3lZYjduM3RPRUJrK2dIb3VkWFk3N2JpRVo5TUgrb091bzZV?=
 =?utf-8?B?bHo2OU8rcVp0SnpaeGNCd3pyb3B3NWhUUmcyaGVZamgwTzBaclBkM08zb3pX?=
 =?utf-8?B?VmZsdUNzZGp4RFRIMTRUYkNOYTVZWXAzWko1QzJSbUVPRytnR09RYnRpYUhT?=
 =?utf-8?B?UHgxQUprMXNDbzgxaHVUWDcvdTRoVXNaOFdvWUxRR1lCUzJaelU2akVTRFhh?=
 =?utf-8?B?TytBdmpKaldldWtPS3lzcjlsV2UvNllybUM1UEY0bHpyT01RS3RMNXJvUXJK?=
 =?utf-8?B?WkJhWWxKd3B2czdnbU5laG1LTXRlbjlnRm0rcHNqZjU0RG1XUWZDc3dTakZ6?=
 =?utf-8?B?Mnp4dUpybkx5bUljMFV4Nmx3WVVDUG0xeUlGN1hSdWRmNWN2QmY5L0huWnJT?=
 =?utf-8?B?WEYwVUk3a3c2VE5KTEFrSkZnZTVZZ2R2bDdXWUh5VzdjY054Y0cvdXBoUzQw?=
 =?utf-8?B?L3B3NWZEelRBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5094.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(4053099003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L2FFTWlaeGdBdHRmRktuWlduQW1UUGJSSnhOL3F6OHZJUEJvVWZHU20vcVRX?=
 =?utf-8?B?c3JVeTB0UWYvQlZJNWlUMEFrWEt5bDg0RFZmT2xhd0ZsMDIrWklZbjFTQkcz?=
 =?utf-8?B?MXQ0SGRZaXhxQ1ArdEtlT3VmK0hFNlU0d2VNSWpzT0JsZ3RuOTBXWjljTUV1?=
 =?utf-8?B?aEo2U1RZYjZYZ1owNHR6RENMNjhKalZTNmdPc0dKc2VNK200a2hLTVkveWVT?=
 =?utf-8?B?MU1sK1FISEw2MWxMNk82UlppSDVLekF0ZmdnQWx0b3E5aEppOTR4dWd1M2Ft?=
 =?utf-8?B?bytyakpzTTRTRzkzczBGNmp5ODRMRVdpSEJHK3JNdzVMTGRBYVllUndzSXZm?=
 =?utf-8?B?ZDhVbmxtRkJkTXpBMXBRZjdnK0wzdDBycVc5WFZmU2JjV2pnTWExTlNGM20y?=
 =?utf-8?B?YzdSWmZYZEd5bkNZOXkyaXdneTgwV013b1NscWljN2Q0ZTlmVDdMd2piS0d5?=
 =?utf-8?B?SWYrY3V0M1lTWXJ4cGc4aTZwMjRJdTlQRU83RkRMbzg1akNMSmV4T3E1Y012?=
 =?utf-8?B?clBJMW0xamlRSWpzYVpKOXIxU2VSc0ozcTRaUlRpN2JUS3luOThwMGdtbW1k?=
 =?utf-8?B?QnZyK3k1VzhROGQ5bWZnQ1VZcjBWR1Bnb05KYmxJQjdZT1hwS2xOeHRsRkUz?=
 =?utf-8?B?NWl4d1JpU0ZVRkRtb2V2WXdvblNDVjNQcHpIQUpwNTY3Q3hmOE1FZHd3NWk3?=
 =?utf-8?B?R3Y0bUR1RVRMeVFoMXo5VzRTRHRIUDhaRllNY0tUQ0wvenpMNkhqSWpOSFhW?=
 =?utf-8?B?QTF0M05OSkNyUEJnaW5GRE5IODlMQ2IvcGRPY0FhSlRnZ1ZWSW9FR1RvZnVu?=
 =?utf-8?B?dXNJU0hVSHE3RVE2dDR4Z1RCSGgxbEJzeGpyNWsxWS9QeEo4d2c1V1pKM3Ry?=
 =?utf-8?B?QTNHMGZLZHRSa1dvdTFtNnVpQUc4SENad21TMFN0RGJiNndhdVpUTkFYQnFu?=
 =?utf-8?B?OWtqZ0w3Z3VQVEFEaHp3b2ZsSXJZS1NCZXZzbGJ6NEpFeTVwTXZoR0h4d01y?=
 =?utf-8?B?c3JncHNtK210R3dLaGNDYmFJSUN0S0RiakRVRXBaWjJLTWYvdy9KNjd5UjZD?=
 =?utf-8?B?VGhDdzF2ZFR3SnZoRGtHMlpTd09WclN1RjhzTlJLQXg1cFdrVEFveGE1RTIr?=
 =?utf-8?B?SXpHUW1rL25yaTI1WXl5bWpvd1l4UGtCbkkxcGxiMXFMQ1pESG91R3hxc2Zi?=
 =?utf-8?B?Nk1sUVhzamV1UUYyblR0YXY2Sk1FdEtTT3N1QTFpQUFOQmpua21ERnJMSzJW?=
 =?utf-8?B?ZENTa0VtV240c0VJbkRYdVpQa2IxYW5iWiszMnd0bmthNHpkUEtGZXptNjJh?=
 =?utf-8?B?RFhMcEhpbm5Qdmk1UFJ5cWYzL1ZMSEh1UEpkOVk2VlBBUnlBQXBrWm9lZ2Rs?=
 =?utf-8?B?Wm9TWUxKMXpNZW9pOHVvWFF6NjVSSG9Tc0xaR1JGVDFOU1BlRW1NZkZIbmFU?=
 =?utf-8?B?YTc4dEVMMjh2c3BmazZVaWRLdExtUEczaUtCNXhjZDBWR3dlKzY4TExlUFor?=
 =?utf-8?B?VnA5ZHRwOVl1cXJQM2pQYlZ5NUxDN0Ywd3NEKzFKSUdDK3VYUVd0dU1mMnk4?=
 =?utf-8?B?YUJ3M1oyYTg5L25Bb3dZZlk0Y3pjOCtOZkM4dFJJWmdQcGFBQlYrMGx3SGEw?=
 =?utf-8?B?ZjgwYm14SFVmL09kRHBwaXNHa3JBRG41eDl5L01kTmx5SWwyd1lYNW5JZHJz?=
 =?utf-8?B?VXdJTFZGTWNHZGRWZWdqYUVsNHhSQWpFd2VaeGVDKzZjaXp1bmRVcndFMlFz?=
 =?utf-8?B?NEhBNjRBeDV0UFdUdXNBcExRVno5R2VLbVAyZURNZ2NUeEoydElZai9pdWUy?=
 =?utf-8?B?Nnl4cGdrd2ZUQUdEWGF1eWVrallTVFNRYVRmLzY1bktkeDNTWFVMUXBSbStW?=
 =?utf-8?B?SXplRllGaE9Sbk5tVGZxczczWU9YdmtCU1B6b21qYmV3S1VuZEVGKy90SDBq?=
 =?utf-8?B?VVFoRWJaYmhWUy9sVU9jUTVRNlk1Nm5Fclk0ZEdHUnRhbGsxVmhFVWNva0xM?=
 =?utf-8?B?R0dFTi8vL0NRczVmUHhqUlZCb2l2RUVCNnhZMW1qd0xkeW43NnFTMGJqNWJ1?=
 =?utf-8?B?UzBSWU9nc3lpeUYxVHlaRENqN3pDSGNCQllOZEZxYlAxeCtzYWJPQUFhaE9P?=
 =?utf-8?Q?vV6KpB3DPs8qE/LSmjxCD0lVE?=
Content-Type: multipart/signed;
	boundary="Apple-Mail=_F2274D3A-E149-4668-B923-9503A6B2F9ED";
	protocol="application/pkcs7-signature"; micalg=sha-256
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5094.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9a27e01-480c-4d81-9855-08ddebf70e9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2025 21:07:29.0910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gOuSp0h2gtMKl3W6m/IhTRAwi1ECU2H/EJDSxiTJZKTz5IvJmiXwPPp8mNp2a/arhsY4dtOw4t51EexWmRJJKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9077

--Apple-Mail=_F2274D3A-E149-4668-B923-9503A6B2F9ED
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Sep 2, 2025, at 7:41=E2=80=AFAM, Miklos Szeredi =
<mszeredi@redhat.com> wrote:
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> Some fuse servers need to prune their caches, which can only be done =
if the
> kernel's own dentry/inode caches are pruned first to avoid dangling
> references.
>=20
> Add FUSE_NOTIFY_PRUNE, which takes an array of node ID's to try and =
get rid
> of.  Inodes with active references are skipped.
>=20
> A similar functionality is already provided by FUSE_NOTIFY_INVAL_ENTRY =
with
> the FUSE_EXPIRE_ONLY flag.  Differences in the interface are
>=20
> FUSE_NOTIFY_INVAL_ENTRY:
>=20
>  - can only prune one dentry
>=20
>  - dentry is determined by parent ID and name
>=20
>  - if inode has multiple aliases (cached hard links), then they would =
have
>    to be invalidated individually to be able to get rid of the inode
>=20
> FUSE_NOTIFY_PRUNE:
>=20
>  - can prune multiple inodes
>=20
>  - inodes determined by their node ID
>=20
>  - aliases are taken care of automatically
>=20
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

Thanks Miklos, this looks great. I=E2=80=99ll give this a spin in our =
virtio-fs FUSE device.

<snip>=

--Apple-Mail=_F2274D3A-E149-4668-B923-9503A6B2F9ED
Content-Disposition: attachment; filename="smime.p7s"
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64

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
LTIwMjMwNTMxMTYwNAYDVQQDEy1qaWhhcnJpcyA2MzZFQkM4OC0yNThCLTQ2QkYtQkU2RS1ERTgz
Mjk3NEVFMkYwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDsK5flcFLKT/1ktmlekKTA
8JwI64E20ekPEvj4KcEynk2b/aaS1Vol+gDoCmp8Q2YKca4RO3IPmWYGMEKWyOwh3R/X+NDC3kEn
xR9FRyPKixPVaVIJOBvpLgTHlTGo6sBECGARmWLNcq/VP/IOEfynt+o0ycfhfMmVCLNeTpVnTDfr
2+gA+EzrG3y7hFlf741+Iu27ml7F2Sb+OuD8LaaIvbUH+47Ha9c7PNbS8gGCOqJ+JqpFbz6nyiVN
KzcxsvQph1p1IlvctilnvGOLNCSQY24IPabPY4mh2jOOELalk8gKhIgeZ4v4XnuDGKzG3OQXjvNW
ki++zsKA+Vb5MH1HAgMBAAGjggNiMIIDXjAOBgNVHQ8BAf8EBAMCBaAwHgYDVR0RBBcwFYETamlo
YXJyaXNAbnZpZGlhLmNvbTAdBgNVHQ4EFgQUXogZtTPa9kRDpzx+baYj2ZB5hNUwHwYDVR0jBBgw
FoAUlatDA/vUWLsb/j02/mvLeNitl7MwggEGBgNVHR8Egf4wgfswgfiggfWggfKGgbhsZGFwOi8v
L0NOPUhRTlZDQTEyMi1DQSgxMCksQ049aHFudmNhMTIyLENOPUNEUCxDTj1QdWJsaWMlMjBLZXkl
MjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9uLERDPW52aWRpYSxEQz1jb20/
Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdD9iYXNlP29iamVjdENsYXNzPWNSTERpc3RyaWJ1dGlv
blBvaW50hjVodHRwOi8vcGtpLm52aWRpYS5jb20vQ2VydEVucm9sbC9IUU5WQ0ExMjItQ0EoMTAp
LmNybDCCAUAGCCsGAQUFBwEBBIIBMjCCAS4wgaoGCCsGAQUFBzAChoGdbGRhcDovLy9DTj1IUU5W
Q0ExMjItQ0EsQ049QUlBLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENO
PUNvbmZpZ3VyYXRpb24sREM9bnZpZGlhLERDPWNvbT9jQUNlcnRpZmljYXRlP2Jhc2U/b2JqZWN0
Q2xhc3M9Y2VydGlmaWNhdGlvbkF1dGhvcml0eTBWBggrBgEFBQcwAoZKaHR0cDovL3BraS5udmlk
aWEuY29tL0NlcnRFbnJvbGwvaHFudmNhMTIyLm52aWRpYS5jb21fSFFOVkNBMTIyLUNBKDExKS5j
cnQwJwYIKwYBBQUHMAGGG2h0dHA6Ly9vY3NwLm52aWRpYS5jb20vb2NzcDA8BgkrBgEEAYI3FQcE
LzAtBiUrBgEEAYI3FQiEt/Bxh8iPbIfRhSGG6Z5lg6ejJWKC/7BT5/cMAgFlAgEkMCkGA1UdJQQi
MCAGCisGAQQBgjcKAwQGCCsGAQUFBwMEBggrBgEFBQcDAjA1BgkrBgEEAYI3FQoEKDAmMAwGCisG
AQQBgjcKAwQwCgYIKwYBBQUHAwQwCgYIKwYBBQUHAwIwDQYJKoZIhvcNAQELBQADggIBABaxnmlH
ePMLNtYtyCN1iDp5l7pbi5wxLNXCULGo252QLCXJwKTosiYCLTT6gOZ+Uhf0QzvbJkGhgu0e3pz3
/SbVwnLZdFMZIsgOR5k85d7cAzE/sRbwVurWZdp125ufyG2DHuoYWE1G9c2rNfgwjKNL1i3JBbG5
Dr2dfUMQyHJB1KwxwfUpNWIC2ClDIxnluV01zPenYIkAqEJGwHWcuhDstCm+TzRMWzueEvJDKYrI
zO5J7SMn0OcGGxmEt4oqYNOULHAsiCd1ULsaHgr3FiIyj1UIUDyPd/VK5a/E4VPhj3xtJtLQjRbn
d+bupdZmIkhAuQLzGdckoxfV3gEhtIlnot0On97zdBbGB+E1f+hF4ogYO/61KnFlaM2CAFPk/LuD
iqTYYB3ysoTOVaSXb/W8mvjx+VY1aWgNfjBJRMCD6BMbBi8XzSB02porHuQpxcT3soUa2jnbM/oR
XS2win7fcEf57lwNPw8cZPPeiIx/na47xrsxRVCmcBoWtVU62ywa/0+XSj602p2sYuVck1cgPoLz
GdBYwNQHSGgUbVspeFQcMfl51EEXrDe3pgnY82qt3kCOSzdBSW3sJfOjN0hcfI76eG3CnabiGnVG
ukDrLIwmyWQp6aS9KxbJr4tq4DfDEnoejOYWc1AeLTDaydw7iBNAR/uMrCqfi5m4GjnqMYICzTCC
AskCAQEwWzBEMRMwEQYKCZImiZPyLGQBGRYDY29tMRYwFAYKCZImiZPyLGQBGRYGbnZpZGlhMRUw
EwYDVQQDEwxIUU5WQ0ExMjItQ0ECE3gBwfkxPjNrfUD9c50ACwHB+TEwDQYJYIZIAWUDBAIBBQCg
ggFDMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDkwNDIxMDcx
OFowLwYJKoZIhvcNAQkEMSIEIMPUJihlIAI7lJqKaRvL31BE5U1a5jFHkFfGfZa7BrGeMGoGCSsG
AQQBgjcQBDFdMFswRDETMBEGCgmSJomT8ixkARkWA2NvbTEWMBQGCgmSJomT8ixkARkWBm52aWRp
YTEVMBMGA1UEAxMMSFFOVkNBMTIyLUNBAhN4AcH5MT4za31A/XOdAAsBwfkxMGwGCyqGSIb3DQEJ
EAILMV2gWzBEMRMwEQYKCZImiZPyLGQBGRYDY29tMRYwFAYKCZImiZPyLGQBGRYGbnZpZGlhMRUw
EwYDVQQDEwxIUU5WQ0ExMjItQ0ECE3gBwfkxPjNrfUD9c50ACwHB+TEwDQYJKoZIhvcNAQELBQAE
ggEAS5R+FMxJvzVYno27Hkx/tipeuMOFiBW4+NsR5cxDnMFHPvtUxXXP0Q8I/Ew8lnPrqgczyGnu
VohZNUlHzZtaQJMyhb15Mk3HZZW5wmi5UEZsGSec41Vg++CLxru1HRzrCOL0Q5cUQ1FIzv0jWHN5
p48roWRgIUmyxx+PRUd/Qzz2TEJf3NqsI9w0WTdFWLmJ+eEeOQiF7RfowN1Wt3lkBqwe8LG9JnMt
wsvg5YKUZY+y2Pu1ZWpZmPHN9Zfg3AfOQyyvdls7u7b31E1HFNctDJVbyot6sNQR0crD5cFoCm1x
XmgtAuajTRli377yP64cMRM8IrxoxvXQIy45z1wTmAAAAAAAAA==

--Apple-Mail=_F2274D3A-E149-4668-B923-9503A6B2F9ED--

