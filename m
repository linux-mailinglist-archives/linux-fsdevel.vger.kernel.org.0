Return-Path: <linux-fsdevel+bounces-23063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 957AB92685F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 20:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAA91B28036
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 18:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57F318C32F;
	Wed,  3 Jul 2024 18:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="H2+2nM/J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D7F1891D8
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jul 2024 18:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720031991; cv=fail; b=TYnmKy0BMSBP9LRmxuo5Nd3suU5qx+Kx/2NxtY0+w8JB9wxpBVQl5eB2OfMtecdhOrniV3yjQLG9zWX6gklRRWYZQfCEIJPAjmzzqv18c33E6h20F4QAvksOoi7WEwwr6CvE5znBN9BjrXWghRAw3SGOe28PCuiAjPVyfAuMJ7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720031991; c=relaxed/simple;
	bh=nEE3AvcpCgc51OZFmclx+N0zODKUCjq/uUHp+6uf4hc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c43h55G8exYxM9SDC1Ea5P3Lmb2PUJEUINf9EhehTdr3zDL7XJW0/NLT7qOrzCuJol+N24H8suMhYNQyky0Q12OWsmrfJIM9phIGkuo1Cx0rdCZ1Or3zjpuhjANZvHSAaLNZHUS4PHTXlgq6S7MmofRMSFRD0SwhODC/nD546ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=H2+2nM/J; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47]) by mx-outbound21-226.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 03 Jul 2024 18:39:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBgu74dX3Z0sI/wqoqOK96FgSNl9NcztJJuhboLpbe/RGWKXkf8U0S6mi+QDUCsnjqlpA/YihnTugABo1IYxAUPA9LG/R3HaJaQPYwA0OfDIRqF9pLAgf+ZcZukjg5ecs7BN1UU0GJgTOBBaxR3cuDDDxnmA/gRzSh3UiRC+YQ7Kvm5DZNHVM6mRqUtnc/Ws5N1tSbKgfSJZUnSyRll1Y7H52P/BPIbDBtMnoykb6NOhHdJTHS1CnD7w5//I+H0iy1Sid03D9l+8I7QqY4g4N8/Kwq/qtH8QTZLCefTZ3XVvAVh6glCwX+pNeu6UIeZyx4KwEtpwUH0YgzK5yuzKow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEE3AvcpCgc51OZFmclx+N0zODKUCjq/uUHp+6uf4hc=;
 b=BOlbe0yaVzIp8RCr7JAiq9q7+FjN5mdSat0+u0RCp4mE5m7YHVFEOww2CupBpfOKUK/VSEFGQtEet717T8OcUayJecDDdOPgJ0Rtwv90xXG8MT/DdgmA34HFISxuoQElrt+07vzJZjTMA2qY74IXlNsP4siuJmEfqHnfiYEjy6wPfhjPKQLSWJ1wi10RPhuA/BCiDJYFNJSxx3LL/rfy66DzLjmWCht+U6F6TKhSkXuK96k9c0HqADoROp+hnlyca+/zTPc94+zS6Sf3OHEuGEhHN5E/RgNU/bAhevf1XDtU/MRS/PqhHwVSNFWxcOEOflbIMvGNWM9BlA2audy6Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEE3AvcpCgc51OZFmclx+N0zODKUCjq/uUHp+6uf4hc=;
 b=H2+2nM/J7cAC93ullfw8ZfYuX8ie2Exh0p+n6iGFdbLRLXSQ8ZvenZKLCpiNWE/U/2LRKx+S0n2xGLbPZO4dqmvc/eH9NMwelFmGHD1Yplxv4juDKM2W5HyZ8oZLGaBwKWQ43bjbXtxM++cRsCxfEmQY/YSF3Xy+gPj9e0LxPm0=
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by SJ1PR19MB6260.namprd19.prod.outlook.com (2603:10b6:a03:459::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 3 Jul
 2024 18:07:51 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%3]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 18:07:50 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>
CC: Bernd Schubert <bernd.schubert@fastmail.fm>, "miklos@szeredi.hu"
	<miklos@szeredi.hu>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fuse: Allow to align reads/writes
Thread-Topic: [PATCH] fuse: Allow to align reads/writes
Thread-Index: AQHazJ1Il8+77AwJ1UK0rigM0WAop7HlHoqAgAAL4QCAABmxgIAABWCAgAAFHgA=
Date: Wed, 3 Jul 2024 18:07:50 +0000
Message-ID: <03aba951-1cab-4a40-a980-6ac3d52b2c91@ddn.com>
References: <20240702163108.616342-1-bschubert@ddn.com>
 <20240703151549.GC734942@perftesting>
 <e6a58319-e6b1-40dc-81b8-11bd3641a9ca@fastmail.fm>
 <20240703173017.GB736953@perftesting>
 <CAJnrk1bYf85ipt2Hf1id-OBOzaASOeegOxnn3vGtUxYHNp3xHg@mail.gmail.com>
In-Reply-To:
 <CAJnrk1bYf85ipt2Hf1id-OBOzaASOeegOxnn3vGtUxYHNp3xHg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR19MB3864:EE_|SJ1PR19MB6260:EE_
x-ms-office365-filtering-correlation-id: 9523c760-4f01-4358-7e10-08dc9b8b0d33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?V1BxWGlabkVvMDBRWTlWVzZFd3V3MEdsV2xPd09GbngxTHZsNVNCaUJGaStp?=
 =?utf-8?B?djEzVkI4c1h3OEZWbThQSml3NEs3NEtBNnlFZkJKWWMxemtQbk1ISVpDeGdh?=
 =?utf-8?B?WnNMMWNXNHVoeDAxZzRwSnFIVStzUk5pNnVoVElUZmdkRXpQOGJDZGJabGcw?=
 =?utf-8?B?RVdaV3p1RjJ5U2Nhc2ZnUGk1cUpadnBWVysxdHNjc2tBTUxDYlJjS3VXcEp4?=
 =?utf-8?B?akY0bHc2WUNvb0ExaHZ5c1ltOTd3Q0dtbC8zcWNYejIrdU45TmNyRUdBNk5s?=
 =?utf-8?B?MFJZRDlaN3ZZTUdxekwvUEdOOFYwUkxhbXh5VllpTHNnSnBRMmxwMHNOWitQ?=
 =?utf-8?B?OXZDeEkrMWtsS1Z5YXNVZTNGSDVxVlNGd0ZWeVd0eUJQeENQdG5ocWdoUTNp?=
 =?utf-8?B?STlEV0NBdmo4ZnlqVThqeE9jN0NqbDk2L1dmZG1SejlnWWptUWVaWE4zUEZY?=
 =?utf-8?B?UEpzYnFuM0UxL3RDZCtuWG9kTnF2VEd5OEo2cE9mUUdwd2F1QUdPZkJXZ1Fz?=
 =?utf-8?B?OTFiTXJFTTlFZFZZeUVFeHVRRFBubEt5TmlMRnUwMnVBRE5QS3BBWkZHak1m?=
 =?utf-8?B?ZUlTZDIzZmJDaG13WnBFck9zRmhKTVo3Ry9RNWRhamFtNklkOHBmR05UM2gx?=
 =?utf-8?B?WmFkVzhlTkloK3I5My9lYWZiZFB2NWIrS1NZVWc0RDVXVGJuTWZEeTFXaVpm?=
 =?utf-8?B?elN5S3oyV2VPVHQwVy9pcXFOaGVLNTUwTm5vZ2dDbzF5ZFU2UE5LaVhWdW8x?=
 =?utf-8?B?NHh2bHBzeGVYckI4c0pmYjYyUmxEeU56enNZaFZXeWI3eWxLNHhrSlpwUkd5?=
 =?utf-8?B?OTBreVFaZzJQR2NoU2h4R3VueVNITDY3dWk5eUxyalkra3graTdpYkVodXJu?=
 =?utf-8?B?a2RoY2Uxd0xPRnkzUzE5M3ZFNko5NExBVVJ6Z1dTWVdtZ0hhYkRSYUg1dnE2?=
 =?utf-8?B?TnJ1UzZ0Zi9PS3NZQnd6RmNlT3FHVUo4eW80NjNWMWRwNFBQSU54NlU5eWsy?=
 =?utf-8?B?SWhzaFZVZEVJSVFwbW1CdFhGc01iZEk4OFpTN2ZPNHYzNXBLNDFpUGl0S3Ny?=
 =?utf-8?B?NUI3ZnVQcjhOY3NHYnhqMS83THhzWndmSFVXR2dVUzZXYUc0dzBqK0JUSTlm?=
 =?utf-8?B?Q3BobVFHMnBLUHFMN0hIOFdrTHlwdUg0dGlBUkJzTjVxNzJVcEtDclFlN1d6?=
 =?utf-8?B?dk9sTlkyRWRneno0WktSc245dXA2cEhVNEI0cVk0NUFGT00wUjIvMHd1RVVD?=
 =?utf-8?B?VExaT2FRR1ZMQVpOTVJ1ekFtWG1KeUxHOS9jeUVmRW9GdVhNQjlBNnhON1hV?=
 =?utf-8?B?S2J3eEgwdlhPSHY3T2hpanBjcWpnTTlEb0tTc0NHaXRuK2l0TnFCb1kyL1Fi?=
 =?utf-8?B?TFBwK2loVTVmYitPejc0aTNJRkpneGVaZkZGMnRENFZmbit1dFV6NDFBdmt3?=
 =?utf-8?B?a3pwZ3A3L0lTbGhyZENQVXRtcW1IcFVYMVRrWkxYQ1lFeUcyaU1nQ2t2THB4?=
 =?utf-8?B?TUhDMXFwMDFlN1Y2VkpmY1o0N1FXT09VS2RNZzBGdWFOZ3dFaExxdm1acWFt?=
 =?utf-8?B?dDhIZTErNkNIVWo4YnRwZzJMMzlHNERWSGIzTjM1Wm9YelhRWWh4U2xLdGE4?=
 =?utf-8?B?S1VwQUxKM3c3VGo4eElRV0c5YUNsdFFFUWR0RitwRXZZRVdwVTNYRWlXdWd6?=
 =?utf-8?B?clBQRTdrUi9XekQzRlZkRS9ueDN4c0Y3QTgzeExlaG41Rmp5QVpicmpaR0hN?=
 =?utf-8?B?VmtVQzIvbnRPUEx6OEJwRzlGZmlDaU5INXBUNmxmbll6Y25YSkRHemdudTc3?=
 =?utf-8?Q?l9Gsp4jiNgOx4HHV73CQlpHH+0MQNRTwvmSqw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bkN3SlFmNEJxR3RwdlZENXVEZDRTRHozTEhSVmhmWllRWUVmVnRpRzhsd0VZ?=
 =?utf-8?B?cklGR1l2ZldYMnVXNTdIVjdYMDViV3V6NEFadTNoUDBKWkoxTE1nbjBjTTRI?=
 =?utf-8?B?djJOTVBSZ1V5bmViTUpEc2llQzd5bTk2L0xxaThvRFZ5SFkyVythQWVxYzQ5?=
 =?utf-8?B?YmNMZ2p3eDBIL1VXYzh5MUdsL0kzZllXa0E5T1RGMUZ4bHg4NkhZUjZRKzJM?=
 =?utf-8?B?eHhudmRTOFh6QkVpeFRhVW8vWnVQbFpiMEpmaSs5VVp2TFd1bTlRRXJ0UTVE?=
 =?utf-8?B?TzdxMTErSE8rRFRlRTBVdE1tRU4ybVZUQlBPUjJaUEQyd3BmK1MyWXo2eXZl?=
 =?utf-8?B?djBEaEtJUC9WSW5QRFI2eXgyME43ZmxLZURYd254WjdwWWZLMjJpZnJReFI1?=
 =?utf-8?B?dU1pOXovQ2JiQitLc1BER05ncmdLNjdjTHFJamJlVlUrKzdkb2toS0F2OVJH?=
 =?utf-8?B?UjN5ajlpSStoTWtJamhIY25jZU9ic2FJVGlWdGUwd1pIaFN3bURPL0dGeFNN?=
 =?utf-8?B?NkdXMlQ3UnN3Z0FKSEhHenNEd2RoUVlPbDkzbklpM1FIckpxTjJweDQ4WVNE?=
 =?utf-8?B?eERJSmg1Nmg3OHFHc09EM1U4Qjg0S1YySk9ac25jTGZzNU9sZkRqaGlqaVBF?=
 =?utf-8?B?OHpIOFNMekJrZTVtMDVwd3RUZUN2Z0VLWUhoZVpWVVZ3anovNXdXVmkyVXJl?=
 =?utf-8?B?dHViN0JDYkRrdytZZWRzdEpSMmVDV0xlU1Q4Rmo5RTRKQWE2Y1NMOGNKMmQ3?=
 =?utf-8?B?bjFQeXRuVGhNZUxxS1JqYWFiR2FBQ2pRVHNLcEMvWW5PYWxKVnZkMUs5OEFl?=
 =?utf-8?B?Q2RLV1Z0NkZqeGJFWDZ1VkFNdm1RaGMzVXR2SHdzUE5NQ3VTN1U4NGpxT3o4?=
 =?utf-8?B?T2xhUThDMUFXSlZqZHREcEFNSGxnK0w2RkZwdFZRb2kzWnRib2hwSS80TFIy?=
 =?utf-8?B?WVpsT0NZQ0hhNWZuZ1N1N1VFeUhwT2x4VEJ1dGxJK0l0LzdUdSsxbGdSSUxI?=
 =?utf-8?B?blh3cmtkK1YxNHhkbzJiNVdSS3J4U3BaYnQxcTlNYmpjd3BmcWNBTHZLVkhH?=
 =?utf-8?B?bytCUlpxT1docEZJVHNrSzJEV2hKeWNSbHdkQ0F0YXhNMFN2SDZZQ3M0TFBa?=
 =?utf-8?B?czcvdklMMHhLbDgxTXdXa2IvS3lqbklyanFZaHlPdldhb1E1eVM2UVRid0hX?=
 =?utf-8?B?dEt5NGN5UWRkN1VhbW5hLzYyckl3OVlFell3eEo2dWRCV1RxODB5ZXRrNUZm?=
 =?utf-8?B?WGNZVXhucStYdUxMbkROd3J1Yjk2SG1EWGhubnBEazJHc3lmMHV5SmFBMzJV?=
 =?utf-8?B?Mi9IRTUxS25rRlhYa091d2NwRE91QmI2Z3ZqY2NqWDNlQ2lQY1ZCd2R4Ym53?=
 =?utf-8?B?citKbmtNeU40MDBPNnZWaEZzcnJvMWVBVjlxK3B4U3N0Q0dvS1lwZEpkUlRF?=
 =?utf-8?B?UmxLbVpvcmRFcTBDUzZkRlFVMk1weTBwVnJZUG03RGhIZllFRXAwUVFxWTBl?=
 =?utf-8?B?Zm1aQVZFY2gwQkpHNUFUUnZGRTF4TTIybFJjdHB0SkUyMXcwTExUR1FVckNY?=
 =?utf-8?B?TVJyT1E4MjQwbTJEbTZwSTNScWNycjdPd3Fsd3hsT0pJUFV0RW90NnE5Wm4w?=
 =?utf-8?B?SjBuTU92aTlINGJnMUdOM3RJdzhnY0FyYXRVckR4cHVEdW1rcWZLQ2RBVVhl?=
 =?utf-8?B?bTMreEVHb2Z0NUU3U3FEMjRxalNYeFYraTJVRk5aU2xydWhHZ0pnZHFaOERN?=
 =?utf-8?B?Qm9rc0xwa1FGS09zTjdFMjZKa0RGWTMxMENhSnk4Wi80bzg3WUFZSnh4bnU1?=
 =?utf-8?B?dVFyQTBaTFNrQkx5ZG9td21uKy8xZitvN2FrSUxTTWxqSU1RTlhnVkFaU20w?=
 =?utf-8?B?MW9EcGpLVUNwcFErc1JKdjl6bkxYbUkxQjQyTU5QZDl3aEVITzZMeURSdFlS?=
 =?utf-8?B?V3YzZzRMTTljUmpSNjFoVWxSR0ZCNVBzUU1XRytEWWVuRUJFa0ttc3l1dUpG?=
 =?utf-8?B?Z0xXNzRvL0MyV0c1ZWJUOFFCbG9KNWt3aU5pYkRSRDBKVnVLZzJJNlN1Yk9W?=
 =?utf-8?B?ZUpUNTVScWxUS3Rzbks5eTZhcHl5L0l1M2lkNGxiclRReGNsaHRQNGp6MkU1?=
 =?utf-8?B?UmhUVU1OS3c5UHNjQStDQ3pJVEZta01odTRCd0Qxblp1VlVmaTEvUjZWVEdD?=
 =?utf-8?Q?KWPJiRbZxzQnY77iB8hzscI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3BA5A0BE5AD08429AC2F3166EB08005@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bQgBgOOayWk8PQf7vfRgx5u7HvQFUSuPkDk+ECIdbUNZAIaxl0mcKthqQTNfNWt6YJr611Z+2ZeaaogWyNtE+5eeLRPwapG8aYvoQPrShERlnomN7tq36O9/vauCy/jAyQvqh7LJSynkRq2lrF01hoEQ7UHq/k6t8bKmSopVyoRfxbY4bZAZQqMAdr6nlPDGt3UqMAfzcdGN3rOqalD9RnOyE94/HWiNpdy3szsY2+tnE9C7fgiQnf3zSN1UabvCwLWcourzC/znEzLezDJpTkwK6UujXaC9UWKjh29VlT6NwMePRZh9vDIlZc3Wr9mYGmyviK4zAAuiGddADYTzP/AuNuoKqenabk72SlzX0Uquw7ZsLWaZmVPTz2B77msOfmH+DxfLerbDSVVwcRIKcpXGCbhUgCs0cv6gShDVifg1LL9DmknYj7GZOeTKk86rvVSTwiqwKC1JfMcMYV9SuOLbdriQB+KMt9TPWYgxm/XuVMeZhOTKVCwcNjmDgtNi52v5nWsWHq4UJY+DfACLHfoDefv/Py55pLBqddjmAwLFfW9RkQPJZdwWlQBvXYFDOxslMw4SEWC9tK46uy2oz5BMRCxclRz9cJmj1tOwSjQjOAlcmNwRpQrc3okNxUkxR/Lb3qWlQV/bjM/5YcPGtQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9523c760-4f01-4358-7e10-08dc9b8b0d33
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 18:07:50.3503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XFKJ5znDDKZYf6Er9fFyTy1QKWHLlC5lCbOJgkzkaWsaEFdkOPUqP9dK9rRx9LB9V6uLEpCGC2Ho9VGMX2lPTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR19MB6260
X-OriginatorOrg: ddn.com
X-BESS-ID: 1720031987-105602-12700-40852-1
X-BESS-VER: 2019.1_20240702.1505
X-BESS-Apparent-Source-IP: 104.47.55.47
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsaGhkZAVgZQ0MTUwMDC0NAg1d
	LMKNHY0sQsLdHE3MzYIsUsOdHMPNVIqTYWAGuS0qVBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.257374 [from 
	cloudscan16-17.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

T24gNy8zLzI0IDE5OjQ5LCBKb2FubmUgS29vbmcgd3JvdGU6DQo+IE9uIFdlZCwgSnVsIDMsIDIw
MjQgYXQgMTA6MzDigK9BTSBKb3NlZiBCYWNpayA8am9zZWZAdG94aWNwYW5kYS5jb20+IHdyb3Rl
Og0KPj4NCj4+IE9uIFdlZCwgSnVsIDAzLCAyMDI0IGF0IDA1OjU4OjIwUE0gKzAyMDAsIEJlcm5k
IFNjaHViZXJ0IHdyb3RlOg0KPj4+DQo+Pj4NCj4+PiBPbiA3LzMvMjQgMTc6MTUsIEpvc2VmIEJh
Y2lrIHdyb3RlOg0KPj4+PiBPbiBUdWUsIEp1bCAwMiwgMjAyNCBhdCAwNjozMTowOFBNICswMjAw
LCBCZXJuZCBTY2h1YmVydCB3cm90ZToNCj4+Pj4+IFJlYWQvd3JpdGVzIElPcyBzaG91bGQgYmUg
cGFnZSBhbGlnbmVkIGFzIGZ1c2Ugc2VydmVyDQo+Pj4+PiBtaWdodCBuZWVkIHRvIGNvcHkgZGF0
YSB0byBhbm90aGVyIGJ1ZmZlciBvdGhlcndpc2UgaW4NCj4+Pj4+IG9yZGVyIHRvIGZ1bGZpbGwg
bmV0d29yayBvciBkZXZpY2Ugc3RvcmFnZSByZXF1aXJlbWVudHMuDQo+Pj4+Pg0KPj4+Pj4gU2lt
cGxlIHJlcHJvZHVjZXIgaXMgd2l0aCBsaWJmdXNlLCBleGFtcGxlL3Bhc3N0aHJvdWdoKg0KPj4+
Pj4gYW5kIG9wZW5pbmcgYSBmaWxlIHdpdGggT19ESVJFQ1QgLSB3aXRob3V0IHRoaXMgY2hhbmdl
DQo+Pj4+PiB3cml0aW5nIHRvIHRoYXQgZmlsZSBmYWlsZWQgd2l0aCAtRUlOVkFMIGlmIHRoZSB1
bmRlcmx5aW5nDQo+Pj4+PiBmaWxlIHN5c3RlbSB3YXMgdXNpbmcgZXh0NCAoZm9yIHBhc3N0aHJv
dWdoX2hwIHRoZQ0KPj4+Pj4gJ3Bhc3N0aHJvdWdoJyBmZWF0dXJlIGhhcyB0byBiZSBkaXNhYmxl
ZCkuDQo+Pj4+Pg0KPj4+Pj4gR2l2ZW4gdGhpcyBuZWVkcyBzZXJ2ZXIgc2lkZSBjaGFuZ2VzIGFz
IG5ldyBmZWF0dXJlIGZsYWcgaXMNCj4+Pj4+IGludHJvZHVjZWQuDQo+Pj4+Pg0KPj4+Pj4gRGlz
YWR2YW50YWdlIG9mIGFsaWduZWQgd3JpdGVzIGlzIHRoYXQgc2VydmVyIHNpZGUgbmVlZHMNCj4+
Pj4+IG5lZWRzIGFub3RoZXIgc3BsaWNlIHN5c2NhbGwgKHdoZW4gc3BsaWNlIGlzIHVzZWQpIHRv
IHNlZWsNCj4+Pj4+IG92ZXIgdGhlIHVuYWxpZ25lZCBhcmVhIC0gaS5lLiBzeXNjYWxsIGFuZCBt
ZW1vcnkgY29weSBvdmVyaGVhZC4NCj4+Pj4+DQo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBCZXJuZCBT
Y2h1YmVydCA8YnNjaHViZXJ0QGRkbi5jb20+DQo+Pj4+Pg0KPj4+Pj4gLS0tDQo+Pj4+PiBGcm9t
IGltcGxlbWVudGF0aW9uIHBvaW50IG9mIHZpZXcgJ3N0cnVjdCBmdXNlX2luX2FyZycgLw0KPj4+
Pj4gJ3N0cnVjdCBmdXNlX2FyZycgZ2V0cyBhbm90aGVyIHBhcmFtZXRlciAnYWxpZ25fc2l6ZScs
IHdoaWNoIGhhcyB0bw0KPj4+Pj4gYmUgc2V0IGJ5IGZ1c2Vfd3JpdGVfYXJnc19maWxsLiBGb3Ig
YWxsIG90aGVyIGZ1c2Ugb3BlcmF0aW9ucyB0aGlzDQo+Pj4+PiBwYXJhbWV0ZXIgaGFzIHRvIGJl
IDAsIHdoaWNoIGlzIGd1cmFudGVlZCBieSB0aGUgZXhpc3RpbmcNCj4+Pj4+IGluaXRpYWxpemF0
aW9uIHZpYSBGVVNFX0FSR1MgYW5kIEM5OSBzdHlsZQ0KPj4+Pj4gaW5pdGlhbGl6YXRpb24geyAu
c2l6ZSA9IDAsIC52YWx1ZSA9IE5VTEwgfSwgaS5lLiBvdGhlciBtZW1iZXJzIGFyZQ0KPj4+Pj4g
emVyby4NCj4+Pj4+IEFub3RoZXIgY2hvaWNlIHdvdWxkIGhhdmUgYmVlbiB0byBleHRlbmQgZnVz
ZV93cml0ZV9pbiB0bw0KPj4+Pj4gUEFHRV9TSVpFIC0gc2l6ZW9mKGZ1c2VfaW5faGVhZGVyKSwg
YnV0IHRoZW4gd291bGQgYmUgYW4NCj4+Pj4+IGFyY2gvUEFHRV9TSVpFIGRlcGVuZGluZyBzdHJ1
Y3Qgc2l6ZSBhbmQgd291bGQgYWxzbyByZXF1aXJlDQo+Pj4+PiBsb3RzIG9mIHN0YWNrIHVzYWdl
Lg0KPj4+Pg0KPj4+PiBDYW4gSSBzZWUgdGhlIGxpYmZ1c2Ugc2lkZSBvZiB0aGlzPyAgSSdtIGNv
bmZ1c2VkIHdoeSB3ZSBuZWVkIHRoZSBhbGlnbl9zaXplIGF0DQo+Pj4+IGFsbD8gIElzIGl0IGVu
b3VnaCB0byBqdXN0IHNheSB0aGF0IHRoaXMgY29ubmVjdGlvbiBpcyBhbGlnbmVkLCBuZWdvdGlh
dGUgd2hhdA0KPj4+PiB0aGUgYWxpZ25tZW50IGlzIHVwIGZyb250LCBhbmQgdGhlbiBhdm9pZCBz
ZW5kaW5nIGl0IGFsb25nIG9uIGV2ZXJ5IHdyaXRlPw0KPj4+DQo+Pj4gU3VyZSwgSSBoYWQgZm9y
Z290dGVuIHRvIHBvc3QgaXQNCj4+PiBodHRwczovL2dpdGh1Yi5jb20vYnNiZXJuZC9saWJmdXNl
L2NvbW1pdC84OTA0OWQwNjZlZmFkZTA0N2E3MmJjZDFhZjhhZDY4MDYxYjExZTdjDQo+Pj4NCj4+
PiBXZSBjb3VsZCBhbHNvIGp1c3QgYWN0IG9uIGZjLT5hbGlnbl93cml0ZXMgLyBGVVNFX0FMSUdO
X1dSSVRFUyBhbmQgYWx3YXlzIHVzZQ0KPj4+IHNpemVvZihzdHJ1Y3QgZnVzZV9pbl9oZWFkZXIp
ICsgc2l6ZW9mKHN0cnVjdCBmdXNlX3dyaXRlX2luKSBpbiBsaWJmdXNlIGFuZCB3b3VsZA0KPj4+
IGF2b2lkIHRvIHNlbmQgaXQgaW5zaWRlIG9mIGZ1c2Vfd3JpdGVfaW4uIFdlIHN0aWxsIG5lZWQg
dG8gYWRkIGl0IHRvIHN0cnVjdCBmdXNlX2luX2FyZywNCj4+PiB1bmxlc3MgeW91IHdhbnQgdG8g
Y2hlY2sgdGhlIHJlcXVlc3QgdHlwZSB3aXRoaW4gZnVzZV9jb3B5X2FyZ3MoKS4NCj4+DQo+PiBJ
IHRoaW5rIEkgbGlrZSB0aGlzIGFwcHJvYWNoIGJldHRlciwgYXQgdGhlIHZlcnkgbGVhc3QgaXQg
YWxsb3dzIHVzIHRvIHVzZSB0aGUNCj4+IHBhZGRpbmcgZm9yIG90aGVyIHNpbGx5IHRoaW5ncyBp
biB0aGUgZnV0dXJlLg0KPj4NCj4gDQo+IFRoaXMgYXBwcm9hY2ggc2VlbXMgY2xlYW5lciB0byBt
ZSBhcyB3ZWxsLg0KPiBJIGFsc28gbGlrZSB0aGUgaWRlYSBvZiBoYXZpbmcgY2FsbGVycyBwYXNz
IGluIHdoZXRoZXIgYWxpZ25tZW50DQo+IHNob3VsZCBiZSBkb25lIG9yIG5vdCB0byBmdXNlX2Nv
cHlfYXJncygpIGluc3RlYWQgb2YgYWRkaW5nDQo+ICJhbGlnbl93cml0ZXMiIHRvIHN0cnVjdCBm
dXNlX2luX2FyZy4NCg0KVGhlcmUgaXMgbm8gY2FsbGVyIGZvciBGVVNFX1dSSVRFIGZvciBmdXNl
X2NvcHlfYXJncygpLCBidXQgaXQgaXMgY2FsbGVkDQpmcm9tIGZ1c2VfZGV2X2RvX3JlYWQgZm9y
IGFsbCByZXF1ZXN0IHR5cGVzLiBJJ20gZ29pbmcgdG8gYWRkIGluIHJlcXVlc3QNCnBhcnNpbmcg
d2l0aGluIGZ1c2VfY29weV9hcmdzLCBJIGNhbid0IGRlY2lkZSBteXNlbGYgd2hpY2ggb2YgYm90
aA0KdmVyc2lvbnMgSSBsaWtlIGxlc3MuDQoNClRoYW5rcywNCkJlcm5kDQoNCg==

