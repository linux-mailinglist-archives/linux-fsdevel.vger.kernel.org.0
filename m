Return-Path: <linux-fsdevel+bounces-64252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55874BDFAF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 18:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC4243C4094
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 16:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD0E3376B4;
	Wed, 15 Oct 2025 16:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="f1XhxD/x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FA62EBBA4
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 16:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760546201; cv=fail; b=Yn/1bRSgQ3jIwScLFEjskh0cb3UtBNhkIGo+2FHsMSAhBZe1lcJO6g5w/dhR6kFFmJChsSTqE4i+lTNu5n0DjGv3OSVhbFXF6o6XdePP/OFTv+wxCgAvZRjlV7tlT6rfUdHSNoN8rkWo46GrgZU4NJO+vjCPPEMRn9EFNGenzoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760546201; c=relaxed/simple;
	bh=P/mqBkjDK6qG33Bqg+x7WONGfhknzqcmX+V10T8vSIw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ketgpX1fw6AZym/TPKnjA/njUncOwgcI3bdgyvdeR8BOPZ6yIsi2TZv3KVaOjdsdC7VjfVNKJnRI69efgl9GQ3A4iYyobETM4cSWUb2ep1SzcqHCkouE8NSmTLz+a+Ao/oba06666fC7y87Bsv+ozbo5MdOAIqGIDxloULqDjYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=f1XhxD/x; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022090.outbound.protection.outlook.com [52.101.43.90]) by mx-outbound20-18.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 15 Oct 2025 16:36:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Is+Ki2wclXAUt+LcWv0Fgw4/IwjRtVa+spyVekkhAnWGbrbNVfgWcv/h8CprRFEmvQy71DpAzM9Z3TiTijKMDEZSdlwUqnpqSj2m6DrRx2itoA6KHMcWUQwzCtOdthCa6mWQwrELw1y/tlIc9VQWPg8SnVxDURSqI2p0cbiEjYSb6ptVIDPCYrt5qweqochYpFzGAZAuTdR0pwz/FZxGUiq/WQP/+1weCC/lId3hJeFDMB+CpjsExCtPP80BArVgUEWWyClXJPXDQg4bahTFjr+yiyYYtTUSXZf2X3Xt34V47CGP8Ireb+LuL6Jw6Jn04qchCSTRIKo+hQuplMP9gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/mqBkjDK6qG33Bqg+x7WONGfhknzqcmX+V10T8vSIw=;
 b=fRXmUZnV2rizzI9+tUcq37niOoVTiY82fFAT1snXLkF2prz9KkW7Yp6ILvHdtGJgzpePXAOclSGdDdbeyZyR1396mYcKYLUn2O2Mvf0MojyJCle2EmycffFrdgKipAybi1N0bfuD2g6TlALEKaQjCkQU7E9AMOZusBkkQ0CgP5FK0uUYNRQYcsORDLrD4VTz8ko+1oqpMETMNnqHRh9cVjFb5W9rW22vIKJYvCk261xMyFUpWz+XD1Bpyd1xsBhP6eJqlXRpMyHN7qrMyD4NMoSAz798BK8+MOHooOoUB7hp+9NANjWbZnL6axS/ceTlUgbXiLrI0BFWdAN7L1xU0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/mqBkjDK6qG33Bqg+x7WONGfhknzqcmX+V10T8vSIw=;
 b=f1XhxD/xrIU8+OEjJSm9TvpNIQblD3Q7cFX4ZtRVceMAjuh/OY81qsd6ZvCd4Keo50edgu3gh22TMJk/czlbewK9yjm8MHE0at61wlizO+xKM9ggHpDrJPMBiMgElLGRYnH3YE79yrW4jT+lOIp34M668O7K8EBSqsStAggq+yw=
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by BY3PR19MB5012.namprd19.prod.outlook.com (2603:10b6:a03:361::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Wed, 15 Oct
 2025 16:36:17 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%5]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 16:36:15 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Bernd Schubert <bernd@bsbernd.com>, Joanne Koong <joannelkoong@gmail.com>
CC: Miklos Szeredi <miklos@szeredi.hu>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
	<vschneid@redhat.com>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Luis
 Henriques <luis@igalia.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2] fuse: Wake requests on the same cpu
Thread-Topic: [PATCH v2] fuse: Wake requests on the same cpu
Thread-Index: AQHcPO/nbyrTRFPZK0ucXvW1McZpVLTCRdCAgAERdQCAABKBgA==
Date: Wed, 15 Oct 2025 16:36:15 +0000
Message-ID: <14a5df18-6eda-4d9a-8bbb-b188376405e3@ddn.com>
References: <20251014-wake-same-cpu-v2-1-68f5078845c6@ddn.com>
 <CAJnrk1brjsPoXc_dbMj-Ty4dr5ZCxtVjBn6WGOY8DkGxh87R5Q@mail.gmail.com>
 <6d16a94b-3277-4922-a628-f17f622369bc@bsbernd.com>
In-Reply-To: <6d16a94b-3277-4922-a628-f17f622369bc@bsbernd.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR19MB3864:EE_|BY3PR19MB5012:EE_
x-ms-office365-filtering-correlation-id: f382910e-4f89-44c8-860a-08de0c08f5cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|366016|1800799024|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?a3JMdjZyd2hJV0ZXY3piSWVid1N0bGdPU1BOUFFBTFppMFl1WDE1RytVWFpj?=
 =?utf-8?B?Tnk0OExrVXJhWFlRdEZtVUZrTjZVRXVGeWpKd1ZKLzRpbDErSExjZExHaTd0?=
 =?utf-8?B?emV1NFc1cGE1aThmcHFyQk0wK2RwUGUveUgyLzFhTFJhQTVCaGVROXRQVnU5?=
 =?utf-8?B?RXlYdGg4MVRTN3ZBMjMraEYrWXUvbk5yQWRpWVljZ3o5Z1l4aUFpNUQxYVd5?=
 =?utf-8?B?MUNKTndYeFlORzEvYmk5bXowbmxIcGlBcy8ydXRrem9CRVZOYmJDUklkaFdu?=
 =?utf-8?B?bzdQUFE0RlN4emlFWGlIMXJrcU5kSGNHRVlrTDRRdlN2UTdkQ3ZyMFlYdW9Z?=
 =?utf-8?B?ZDhZOEl1TS83amF6eWJXRCs3Uzg3Q01lWlpJNjNQcGFJT0ttWnZwQnI5cXl2?=
 =?utf-8?B?YldROGcyUWFxd0E4cExOUHF1OWh6NVI1Nml1emRQWlVWblh0dGZkNW1rR0Jk?=
 =?utf-8?B?a3JGZmpRK2p0VTVudC96SGxVUFhnTWhUQzlHUXdKZFBMa3pZMzlMaU1aY25O?=
 =?utf-8?B?dXpyNDhidjFmaHdvc2paQ1lhUkl4UDBmNkdnbWlyelRrUWdzUVZmV2FSMVMr?=
 =?utf-8?B?TVI1TzFuSkFnOFAwajI3R29kN3NscEFmcHRlVHZRdUp5Kys3eU5CTFNFNGFG?=
 =?utf-8?B?NnFlaENURHZ4djQ1U1RQVndmeHU4TzBueVcwZHVTQkllT2J5eXE2RUFjdzVp?=
 =?utf-8?B?cVBnVUNIQmQ5RjdFSHA5S2E2Um5XbDFBaXVmcDdBRkd0UndmZHkxVnFLak5v?=
 =?utf-8?B?STRXZXBSOGFKV0o0SlNaUEQzUGF0bDdKRlQxNmN0dE12YXYvZ25nR25CVVdr?=
 =?utf-8?B?T0hsZ3MzMUQzNlVZWGR3YlYrZXVNWWJXQ0pVbEphaURBTHIydWRaNWFFMmZX?=
 =?utf-8?B?Qk85R0JSWXNGL3p4Q1NReGtOZ2FjanNzTS9Uc05VUzdtZDdkR3BQUkFzcFB1?=
 =?utf-8?B?bXNRRFNGQys0b3VOYjE1L29aNXB5U3FVSm5rMFQ1ek84ellQOU9JSzdLWFB6?=
 =?utf-8?B?SGVoakhXcCtYQUpVMXNzalMzb2lGMWl3MHAwaWZnTXhGYy9CbzFKMjBxS2ZI?=
 =?utf-8?B?WGo3M3FrSzF5N3FSWWlTZzdLSS9kaThPY3lvVXcxTUxQdGl3VkJFUzcvK3gy?=
 =?utf-8?B?MmFTK0ZGUDRMS1ZhZ1FheWxlTzFJVGNGNzNjczl5aUh1NkdZWm12b1B2VmxR?=
 =?utf-8?B?ZE9GTm84ckVyREVZOTkxYUtHNnhpcWJxREhiQ3RrMFFEMGU1T3BiRE9zRXZV?=
 =?utf-8?B?Y0lUN2ZhWkczb2c3VjVWamJtWmMwcjE3c0dvUHhRTHdrK01CUEtOKzFDMWF1?=
 =?utf-8?B?NHZJem0zdzZycHBaSmNWVXR3dy9xNUROSE93WGFGaUpZWlk3cDF0bXFacC8y?=
 =?utf-8?B?dWx1REhEQjdJVENlakRXU0JxOU1KYUt5ckJpWWRQUTlFQ3RycXl2VTdpWU95?=
 =?utf-8?B?KzlDOE9nQXlXQlJ1VkV4MWhQNkZ1V29TcHhDMlc2bkFYeXRybTlsc3RlZHdO?=
 =?utf-8?B?Tm5wRDF2Q1cveWhIS3JjVlpyRnowMnhiRGxOcW9DQlRQU2NaaUNQdDlld3Jl?=
 =?utf-8?B?VlZtMnAvVG96YzQyQWZ3UHp3a1RIOFV2MERHYmpZUXgyZGlhRDc3Rjgvcjk1?=
 =?utf-8?B?Yk5oaHRZVFdlNkxacDAzaVRZaG95eVpRdncrYytEZW5rOGxhLy9MSVpvdFhY?=
 =?utf-8?B?cmNtTmorQUxOVjc2VjhGOEVvSmtHRDNGRmdkR1RmYjErVlphazFNaVlKQi9j?=
 =?utf-8?B?WnJmekhhVDJyRVZ4dWRHbXVsSGR1YzBBbld0WjFPQVo5QzAwK3ZDL3hVcnIr?=
 =?utf-8?B?TC84YVVac2E5RG1RelF6WHV1aVAxSU1XMlg5VWVBSStCaUtFNGNpcFZpdEpw?=
 =?utf-8?B?M0loK2JEbVk2U1pNRW9QOWtCMnpqcEFlcjFqUFJzYTgyMkhBaDhNT1FvamFz?=
 =?utf-8?B?UzZHUjUyTWNiOGhLbjVCTFg0cTF4dDduV3ZQOFJuM29MN3Z2eldpN3hxcklz?=
 =?utf-8?B?elo3c0REZGZsMkg0REdXU0VNSVpXTjQwdEFlei9Ra3FrcDFxUm5XdTl0NTg1?=
 =?utf-8?Q?zK1oDe?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(7416014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Qml4M3djcGZDNHR2NUJtT2lKRzZsc3N6cEJNUERuMk1KNkp2WW5CNWF3blpG?=
 =?utf-8?B?bjl6Q0Vzc0NvVnZ6eG9JbGJnSllxTUhFZVN4MEoyL1A3d1pNeDRmR3J2NG9P?=
 =?utf-8?B?aHBuTmc5LzZTc3BFNnFqUThYeEVHaVpjQkFpZm1sSjF4c0FYYitKZHgwbHNw?=
 =?utf-8?B?R1U1RExMdE1SeGF4cW85dTcrR21peXJya3ZhVC9HdmZwY09CRVNydGt0ZzAr?=
 =?utf-8?B?ZHgvSFdJK0xyYUtSNXp6NnY5QTRPemsvQzEydE93L3dsN0taTmpUQVVISTVT?=
 =?utf-8?B?bGlhVktXTzVPc2NNU2xRbmpUNTZVM1M2bE1ZeGRQMFdXcENKTEZ0NWJsY1ZQ?=
 =?utf-8?B?STVDcThaOHV6b1FjQXBLL3Q5Nmk5UGRtcDRIOFpJNG54WW5IMDJiSVRLWVVt?=
 =?utf-8?B?bHUweUNEM0JhT1djUjh1SzdvUXZoQnE0cXd0WkF0QTNsV1ZSeGpSVDhtS0xP?=
 =?utf-8?B?SW1VSkVlNTdlRkQ3b0Z6alVUU2MxOGlka3ZLdGJ2MTI2RFE1NCt6R0FxaWJq?=
 =?utf-8?B?eExDUm9SRWU5Rm9lRENKaEUyRDdybVpSdXZVeURqczdzZnZXVXZ5RldWdEF3?=
 =?utf-8?B?ajFJVm1FWUJPS2tkdkdGRUllN24vMUE3L3k5SFBZMGxZV2N5eFQyZEdNYkFB?=
 =?utf-8?B?dmM4cTRZNHozQnRPOXhza1hlSElFMmp3dkxyRHEzYXFmcTV6WTdRb3FKS2tO?=
 =?utf-8?B?QWJObUV0eEpRdTJHT1dKb0JvUlU0OFBUaHIzTDdtNC9yL25ZL0JQYS94T1Y3?=
 =?utf-8?B?cWw4WVNabGw0N2Z6b01XZ3M1WW9yRTFveWtSOXk1OGxGZnJ0ZmdROUR1ZzNq?=
 =?utf-8?B?Z2c0UnJaUDdlbXErV2E4UkkrL3pXdUl4M2s0TEdyNGVhbW5yZURqc0hIalJS?=
 =?utf-8?B?YlgrMjJ1M1FGMTVoYkY2YmkrWFhDUzlDamR5ZFRNeHk2K0paRU1MaW1OU21n?=
 =?utf-8?B?N0xJSFlrWk1aUzZWM1QxbkFIaTRFQmZ3bWdEbkdEd1lCU0ltZzNBV1pVZ25q?=
 =?utf-8?B?Y2JPV0cvYlZPR3lDZVlEZWxPSHcwaXM0Ui9UM0dOS1BnbklBc0g1TU9RRWZH?=
 =?utf-8?B?dlBOK245UldhbVZDT0h5ZE5YbDJkS3NjbDhNT2prcnVYQWozaGxsdXFackJ4?=
 =?utf-8?B?QytIay82RGU1d1VKRHZyMWNERzRqZzdCZUpGTkJ0OFBIVkwrSmpjTzVLRDAv?=
 =?utf-8?B?azBTaEVnQnFrS2xWTUgrUjJIM0QxRE9nbGl0NkZEeTUzRUpDMENGR1NtZ2V4?=
 =?utf-8?B?SGppcHl5K1Y2eitCV2lJVFRJVDQ1OGlmay9SalZURStpS0tlWm9RMWJDYTI1?=
 =?utf-8?B?aEVQQWJ3a3o4b1J2K0NhSmxMQkExdHVIV3c0cXdhYXJXK28xVDJJeHYwUHBC?=
 =?utf-8?B?d25GaU5hQ1JwWXVHTURqKzI3M0FVTUxmZnVoemp1RzhRcGdlYVVkOE9YMDhE?=
 =?utf-8?B?T09RR3FUWnVHVzNpRmxtbEc3S2dWejlXaEwrZ041Q2tEck9TaWFnM05ndTdj?=
 =?utf-8?B?Y2s0OVgrZEd3Qkt2YzFSbXY0Y2dvcklVVENQRjlYNnp5VVo1RU5CK2JaMGdF?=
 =?utf-8?B?Q2ZDeHJxaGV1Unk4d3RWUDQvL2R0RmNJTUJBbDVzdFg1Q3ZVR2pzb2RlczVp?=
 =?utf-8?B?RUZad0FaVzdWYnZQbmtyZVNFYkRoYXZsOW11NjY2bXBicUlsNExrenFseDFG?=
 =?utf-8?B?RTZDeCs1TWRLNEMvQTA5aDU1Y21RbktiWEhrbUx3dzJOdTV1UEJxRHlMczNi?=
 =?utf-8?B?ZDFqdUpZK2pSaVpWRmJ1TU1jZllNNGN6eUc4RHFEaEFUNGlnU1h0U0N2Tms2?=
 =?utf-8?B?QlQ4aE9ESmpWV0l2K2JpcnYya2xkSm5LMW5VSGhKQzJSRjQyYkwrZ2ZGK3dy?=
 =?utf-8?B?L2dvTnNDMjd3YkYzbVhpaU51NHJXV0FRWkdQcHlXVS96ME9pbllSek5uSkh5?=
 =?utf-8?B?UzU2eXJWSmk4cWxySGZZbmlINmVyNFErOUw3Smt4ZmUxVDg2dGdQaDZCS0ZH?=
 =?utf-8?B?N2I4WUVnN3NCS0Z4R2RvaE1nTTFRWU1mM3FMU2hNOE81UTgzNW1hNXdQOGM4?=
 =?utf-8?B?cjdEK1pJZGc3WTJKZ1FKZFExZzFaand1OXVRcEpGMGIwUy9SNEM4SW1GV0Z2?=
 =?utf-8?Q?vjF0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <043352B6C9C8554D8CA13B5E61F41123@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Va/fPCdvgD6OpgsAdegjnYWNpRQMtgroF/YXF/4oytzH82VP8PTnJmHExn/Nuf8z/8GeK5C+Li/7ZSCtFdalCS3tHnp8B2Eb/Preud+45n8PL9NUvka9TYKOnqegMc45/yetJL4iYXZbXuuoW3xoWKeQ5YqQxbM7+YmJEWrJTOjNZpdfvYjzqrDJjBwM4D8+TNpdFoGdlCuqSTQXsjEEiy9lHQKbh8eRBHnuM9LFWv/XTEPGesOg3NzkSWgmhUFU8MNchm58esVtjaTCUUOmIkEkzPOZWsWP8e1HbDr9l0W9X0JYN5YHj/4itP2/siAhVNWcOoejFWSgHDrSmkk6PKqjU222QWeXeK27pO6TvA6aGbpoZCtLlzV/cHZPzlSIxbb7NzgeoZsTp0e+rOuqWAxvTkJwg2UpNa/TPm91DsWeW1d3Biogm57VV5MWcYFO6MI40Mp6i/i80h2UkVDbsZoPrVyGSxyB7oaoqyfGGmUpsasJQ/dFuFOBIh50pa1Y3iMfyYcgJYlqivpqdS6mrVhJ7RjW7PtHflE0ftftWOLYSZpH0cZtVdWolEgK5kny1Yu4f6n3koDwAE1STzjp2mbQVzaYaiNpkaVa0V5CIfNCnF+9y7PBt8e4eApQMaldXRU/q7S7lcvwR9zv0nXhjg==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f382910e-4f89-44c8-860a-08de0c08f5cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 16:36:15.5796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SOG+KlXfuQuVS7TmabX31gNj5mLljN7xjRPhncbSmb6M8MeMKdjoHZ84mqmjS/BNzNG+mpjp/k8EUYmS3l6RIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR19MB5012
X-BESS-ID: 1760546180-105138-7590-213-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.43.90
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqYm5oZAVgZQMDHV0szMICnV0i
	TVwNLcNMnQ0tTcINnEyCzFyCjRJDlRqTYWAO7D9XpBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.268229 [from 
	cloudscan20-227.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

T24gMTAvMTUvMjUgMTc6MzAsIEJlcm5kIFNjaHViZXJ0IHdyb3RlOg0KPiANCj4gDQo+IE9uIDEw
LzE1LzI1IDAxOjExLCBKb2FubmUgS29vbmcgd3JvdGU6DQo+PiBPbiBUdWUsIE9jdCAxNCwgMjAy
NSBhdCAyOjUw4oCvQU0gQmVybmQgU2NodWJlcnQgPGJzY2h1YmVydEBkZG4uY29tPiB3cm90ZToN
Cj4+Pg0KPj4+IEZvciBpby11cmluZyBpdCBtYWtlcyBzZW5zZSB0byB3YWtlIHRoZSB3YWl0aW5n
IGFwcGxpY2F0aW9uIChzeW5jaHJvbm91cw0KPj4+IElPKSBvbiB0aGUgc2FtZSBjb3JlLg0KPj4+
DQo+Pj4gV2l0aCBxdWV1ZS1wZXItcG9yZQ0KPj4NCj4+IG5pdCB0eXBvOiBjb3JlLCBub3QgcG9y
ZQ0KPiANCj4gOikgVGhhbmtzLCBkdW5ubyBob3cgSSBtYW5hZ2VkIHRvIGdldCB0aGF0Lg0KPiAN
Cj4+DQo+Pj4NCj4+PiBmaW8gLS1kaXJlY3Rvcnk9L3RtcC9kZXN0IC0tbmFtZT1pb3BzLlwkam9i
bnVtIC0tcnc9cmFuZHJlYWQgLS1icz00ayBcDQo+Pj4gwqDCoMKgwqAgLS1zaXplPTFHIC0tbnVt
am9icz0xIC0taW9kZXB0aD0xIC0tdGltZV9iYXNlZCAtLXJ1bnRpbWU9MzBzDQo+Pj4gwqDCoMKg
wqAgXCAtLWdyb3VwX3JlcG9ydGluZyAtLWlvZW5naW5lPXBzeW5jIC0tZGlyZWN0PTENCj4+Pg0K
Pj4NCj4+IFdoaWNoIHNlcnZlciBhcmUgeW91IHVzaW5nIGZvciB0aGVzZSBiZW5jaG1hcmtzPyBw
YXNzdGhyb3VnaF9ocD8NCj4gDQo+IHBhc3N0aHJvdWdoX2hwIG9uIHRtcGZzLCBzeXN0ZW0gaGFz
IDI1NkdCIFJBTSAtIGVub3VnaCBmb3IgdGhlc2UgDQo+IGJlbmNobWFya3MsIHdpdGggMTYgKDMy
IEhUKSBjb3Jlcy4NCj4gDQo+Pg0KPj4+IG5vLWlvLXVyaW5nDQo+Pj4gwqDCoMKgIFJFQUQ6IGJ3
PTExNk1pQi9zICgxMjJNQi9zKSwgMTE2TWlCL3MtMTE2TWlCL3MNCj4+PiBuby1pby11cmluZyB3
YWtlIG9uIHRoZSBzYW1lIGNvcmUgKG5vdCBwYXJ0IG9mIHRoaXMgcGF0Y2gpDQo+Pj4gwqDCoMKg
IFJFQUQ6IGJ3PTExNU1pQi9zICgxMjBNQi9zKSwgMTE1TWlCL3MtMTE1TWlCL3MNCj4+PiB1bnBh
dGNoZWQNCj4+PiDCoMKgwqAgUkVBRDogYnc9MjYwTWlCL3MgKDI3M01CL3MpLCAyNjBNaUIvcy0y
NjBNaUIvcw0KPj4+IHBhdGNoZWQNCj4+PiDCoMKgwqAgUkVBRDogYnc9MzQ1TWlCL3MgKDM2Mk1C
L3MpLCAzNDVNaUIvcy0zNDVNaUIvcw0KPj4+DQo+Pj4gV2l0aG91dCBpby11cmluZyBhbmQgY29y
ZSBib3VuZCBmdXNlLXNlcnZlciBxdWV1ZXMgdGhlcmUgaXMgYWxtb3N0DQo+Pj4gbm90IGRpZmZl
cmVuY2UuIEluIGZhY3QsIGZpbyByZXN1bHRzIGFyZSB2ZXJ5IGZsdWN0dWF0aW5nLCBpbg0KPj4+
IGJldHdlZW4gODVNQi9zIGFuZCAyMDVNQi9zIGR1cmluZyB0aGUgcnVuLg0KPj4+DQo+Pj4gV2l0
aCAtLW51bWpvYnM9OA0KPj4+DQo+Pj4gdW5wYXRjaGVkDQo+Pj4gwqDCoMKgIFJFQUQ6IGJ3PTIz
NzhNaUIvcyAoMjQ5M01CL3MpLCAyMzc4TWlCL3MtMjM3OE1pQi9zDQo+Pj4gcGF0Y2hlZA0KPj4+
IMKgwqDCoCBSRUFEOiBidz0yNDAyTWlCL3MgKDI1MThNQi9zKSwgMjQwMk1pQi9zLTI0MDJNaUIv
cw0KPj4+IChkaWZmZXJlbmNlcyB3aXRoaW4gdGhlIGNvbmZpZGVuY2UgaW50ZXJ2YWwpDQo+Pj4N
Cj4+PiAnLW8gaW9fdXJpbmdfcV9tYXNrPTAtMzo4LTExJyAoMTYgY29yZSAvIDMyIFNNVCBjb3Jl
IHN5c3RlbSkgYW5kDQo+Pj4NCj4+PiB1bnBhdGNoZWQNCj4+PiDCoMKgwqAgUkVBRDogYnc9MTI4
Nk1pQi9zICgxMzQ4TUIvcyksIDEyODZNaUIvcy0xMjg2TWlCL3MNCj4+PiBwYXRjaGVkDQo+Pj4g
wqDCoMKgIFJFQUQ6IGJ3PTE1NjFNaUIvcyAoMTYzN01CL3MpLCAxNTYxTWlCL3MtMTU2MU1pQi9z
DQo+Pj4NCj4+PiBJLmUuIG5vIGRpZmZlcmVuY2VzIHdpdGggbWFueSBhcHBsaWNhdGlvbiB0aHJl
YWRzIGFuZCBxdWV1ZS1wZXItY29yZSwNCj4+PiBidXQgcGVyZiBnYWluIHdpdGggb3ZlcmxvYWRl
ZCBxdWV1ZXMgLSBhIGJpdCBzdXJwcmlzaW5nLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogQmVy
bmQgU2NodWJlcnQgPGJzY2h1YmVydEBkZG4uY29tPg0KPj4+IC0tLQ0KPj4+IFRoaXMgd2FzIGFs
cmVhZHkgcGFydCBvZiB0aGUgUkZDIHNlcmllcyBhbmQgd2FzIHRoZW4gcmVtb3ZlZCBvbg0KPj4+
IHJlcXVlc3QgdG8ga2VlcCBvdXQgb3B0aW1pemF0aW9ucyBmcm9tIHRoZSBtYWluIGZ1c2UtaW8t
dXJpbmcNCj4+PiBzZXJpZXMuDQo+Pj4gTGF0ZXIgSSB3YXMgaGVzaXRhdGluZyB0byBhZGQgaXQg
YmFjaywgYXMgSSB3YXMgd29ya2luZyBvbiByZWR1Y2luZyB0aGUNCj4+PiByZXF1aXJlZCBudW1i
ZXIgb2YgcXVldWVzL3JpbmdzIGFuZCBpbml0aWFsbHkgdGhvdWdodA0KPj4+IHdha2Utb24tY3Vy
cmVudC1jcHUgbmVlZHMgdG8gYmUgYSBjb25kaXRpb25hbCBpZiBxdWV1ZS1wZXItY29yZSBvcg0K
Pj4+IGEgcmVkdWNlZCBudW1iZXIgb2YgcXVldWVzIGlzIHVzZWQuDQo+Pj4gQWZ0ZXIgdGVzdGlu
ZyB3aXRoIHJlZHVjZWQgbnVtYmVyIG9mIHF1ZXVlcywgdGhlcmUgaXMgc3RpbGwgYSBtZWFzdXJh
YmxlDQo+Pj4gYmVuZWZpdCB3aXRoIHJlZHVjZWQgbnVtYmVyIG9mIHF1ZXVlcyAtIG5vIGNvbmRp
dGlvbiBvbiB0aGF0IG5lZWRlZA0KPj4+IGFuZCB0aGUgcGF0Y2ggY2FuIGJlIGhhbmRsZWQgaW5k
ZXBlbmRlbnRseSBvZiBxdWV1ZSBzaXplIHJlZHVjdGlvbi4NCj4+PiAtLS0NCj4+PiBDaGFuZ2Vz
IGluIHYyOg0KPj4+IC0gRml4IHRoZSBkb3h5Z2VuIGNvbW1lbnQgZm9yIF9fd2FrZV91cF9vbl9j
dXJyZW50X2NwdQ0KPj4+IC0gTW92ZSB1cCB0aGUgJyBXYWtlIHVwIHdhaXRlciBzbGVlcGluZyBp
bg0KPj4+IMKgwqAgcmVxdWVzdF93YWl0X2Fuc3dlcigpJyBjb21tZW50IGluIGZ1c2VfcmVxdWVz
dF9lbmQoKQ0KPj4+IC0gTGluayB0byB2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI1
MTAxMy13YWtlLXNhbWUtY3B1LSANCj4+PiB2MS0xLTQ1ZDgwNTlhZGRlN0BkZG4uY29tDQo+Pj4g
LS0tDQo+Pj4gwqAgZnMvZnVzZS9kZXYuY8KgwqDCoMKgwqDCoMKgIHzCoCA1ICsrKystDQo+Pj4g
wqAgaW5jbHVkZS9saW51eC93YWl0LmggfMKgIDYgKysrLS0tDQo+Pj4gwqAga2VybmVsL3NjaGVk
L3dhaXQuY8KgIHwgMTYgKysrKysrKysrKysrKysrLQ0KPj4+IMKgIDMgZmlsZXMgY2hhbmdlZCwg
MjIgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9m
cy9mdXNlL2Rldi5jIGIvZnMvZnVzZS9kZXYuYw0KPj4+IGluZGV4IA0KPj4+IDEzMmYzODYxOWQ3
MDcyMGNlNzRlZWRjMDAyYTdiOGYzMWU3NjBhNjEuLjNhM2Q4OGU2MGU0OGRmM2FjNTdjZmYzYmU4
ZGYxMmM0ZjIwYWNlOWEgMTAwNjQ0DQo+Pj4gLS0tIGEvZnMvZnVzZS9kZXYuYw0KPj4+ICsrKyBi
L2ZzL2Z1c2UvZGV2LmMNCj4+PiBAQCAtNTAwLDcgKzUwMCwxMCBAQCB2b2lkIGZ1c2VfcmVxdWVz
dF9lbmQoc3RydWN0IGZ1c2VfcmVxICpyZXEpDQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgc3Bpbl91bmxvY2soJmZjLT5iZ19sb2NrKTsNCj4+PiDCoMKgwqDCoMKgwqDCoMKg
IH0gZWxzZSB7DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogV2FrZSB1
cCB3YWl0ZXIgc2xlZXBpbmcgaW4gcmVxdWVzdF93YWl0X2Fuc3dlcigpICovDQo+Pj4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgd2FrZV91cCgmcmVxLT53YWl0cSk7DQo+Pj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHRlc3RfYml0KEZSX1VSSU5HLCAmcmVxLT5mbGFn
cykpDQo+Pg0KPj4gbWlnaHQgYmUgd29ydGggaGF2aW5nIGEgc2VwYXJhdGUgaGVscGVyIGZvciB0
aGlzIHNpbmNlIHRoaXMgaXMgYWxzbw0KPj4gY2FsbGVkIGluIHJlcXVlc3Rfd2FpdF9hbnN3ZXIo
KQ0KPiANCj4gT2ssIEkgY2FuIGRvIHRoYXQgaW4gdjMNCj4gDQo+Pg0KPj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB3YWtlX3VwX29uX2N1cnJlbnRfY3B1
KCZyZXEtPndhaXRxKTsNCj4+DQo+PiBXb24ndCB0aGlzIGxvc2UgY2FjaGUgbG9jYWxpdHkgZm9y
IGFsbCB0aGUgb3RoZXIgZGF0YSB0aGF0IGlzIGluIHRoZQ0KPj4gY2xpZW50IHRocmVhZCdzIGNh
Y2hlIG9uIHRoZSBwcmV2aW91cyBDUFU/IEl0IHNlZW1zIHRvIG1lIGxpa2Ugb24NCj4+IGF2ZXJh
Z2UgdGhpcyB3b3VsZCBiZSBhIGNvc3RsaWVyIG1pc3Mgb3ZlcmFsbD8gV2hhdCBhcmUgeW91ciB0
aG91Z2h0cw0KPj4gb24gdGhpcz8NCj4gDQo+IFNvIGFzIGluIHRoZSBpbnRyb2R1Y3Rpb24sIHdo
aWNoIGI0IG1hZGUgYSAnLS0tJyBjb21tZW50IGJlbG93LA0KPiBpbml0aWFsbHkgSSB0aG91Z2h0
IHRoaXMgc2hvdWxkIGJlIGEgY29uZGl0aW9uYWwgb24gcXVldWUtcGVyLWNvcmUuDQo+IFdpdGgg
cXVldWUtcGVyLWNvcmUgaXQgc2hvdWxkIGJlIGVhc3kgdG8gZXhwbGFpbiwgSSB0aGluay4NCj4g
DQo+IEFwcCBzdWJtaXRzIHJlcXVlc3Qgb24gY29yZS1YLCB3YWl0cy9zbGVlcHMsIHJlcXVlc3Qg
Z2V0cyBoYW5kbGUgb24NCj4gY29yZS1YIGJ5IHF1ZXVlLVguDQo+IElmIHRoZXJlIGFyZSBtb3Jl
IGFwcGxpY2F0aW9ucyBydW5uaW5nIG9uIHRoaXMgY29yZSwgdGhleQ0KPiBnZXQgbGlrZWx5IHJl
LXNjaGVkdWxlZCB0byBhbm90aGVyIGNvcmUsIGFzIHRoZSBsaWJmdXNlIHF1ZXVlIHRocmVhZCBp
cw0KPiBjb3JlIGJvdW5kLiBJZiBvdGhlciBhcHBsaWNhdGlvbnMgZG9uJ3QgZ2V0IHJlLXNjaGVk
dWxlZCBlaXRoZXIgdGhlDQo+IGVudGlyZSBzeXN0ZW0gaXMgb3ZlcmxvYWRlZCBvciBzb21lb25l
IHNldHMgbWFudWFsIGFwcGxpY2F0aW9uIGNvcmUNCj4gYWZmaW5pdHkgLSB3ZSBjYW4ndCBkbyBt
dWNoIGFib3V0IHRoYXQgaW4gZWl0aGVyIGNhc2UuIFdpdGgNCj4gcXVldWUtcGVyLWNvcmUgdGhl
cmUgaXMgYWxzbyBubyBkZWJhdGUgYWJvdXQgInByZXZpb3VzIENQVSIuDQo+IFdvcnNlIGlzIGFj
dHVhbGx5IHNjaGVkdWxlciBiZWhhdmlvciBoZXJlLCBhbHRob3VnaCB0aGUgcmluZyB0aHJlYWQN
Cj4gaXRzZWxmIGdvZXMgdG8gc2xlZXAgc29vbiBlbm91Z2guIEFwcGxpY2F0aW9uIGdldHMgc3Rp
bGwgcXVpdGUgb2Z0ZW4NCj4gcmUtc2NoZWR1bGVkIHRvIGFub3RoZXIgY29yZS4gV2l0aG91dCB3
YWtlLW9uLXNhbWUgY29yZSBiZWhhdmlvciBpcw0KPiBldmVuIHdvcnNlIGFuZCBpdCBqdW1wcyBh
Y3Jvc3MgYWxsIHRoZSB0aW1lLiBOb3QgZ29vZCBmb3IgQ1BVIGNhY2hlLi4uDQo+IA0KPiBXaXRo
IHJlZHVjZWQgcXVldWVzIHdlIGNhbiBhc3N1bWUgdGhhdCBpdCB0byBqdW1wIGJldHdlZW4gY29y
ZXMsIEkNCj4gaGF2ZSBubyBwcm9ibGVtIHRvIG1ha2UgaXQgYSBjb25kaXRpb25hbCBvbiB0aGF0
LCBqdXN0IHJlc3VsdHMgYXJlDQo+IGVuY291cmFnaW5nIHRvIGFwcGx5IGl0IHVuY29uZGl0aW9u
YWxseSAtIHNlZSB0aGUgcmVzdWx0cyBhYm92ZSBmb3INCj4gIi1vIGlvX3VyaW5nX3FfbWFzaz0w
LTM6OC0xMScgKDE2IGNvcmUgLyAzMiBTTVQgY29yZSBzeXN0ZW0pIg0KPiANCg0KSXNuJ3Qgd2hh
dCB5b3UgYXJlIHN1Z2dlc3RpbmcgYSBmdW5jdGlvbiBjYWxsZWQgIndha2Vfb25fcHJldl9jcHUi
Pw0KDQpUaGFua3MsDQpCZXJuZA0K

