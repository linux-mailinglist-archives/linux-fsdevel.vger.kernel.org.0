Return-Path: <linux-fsdevel+bounces-26829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2578D95BE10
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 20:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69B8A1F2540E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 18:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBED01CFEB7;
	Thu, 22 Aug 2024 18:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NAfRacCL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TGhK1T1P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B09F1CF288;
	Thu, 22 Aug 2024 18:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724350463; cv=fail; b=cbWNclxe2w3y0SvmZs6K0ao/1m2LRtNZ/8Tia7DiqoaUVdAW58t7rAK5D0Su5b4oEqhHGZsVvFm1ylwrNcg6lquYLjQy/aMLipXfHZRQl0iXiOGVLmIuIKaC8t2UxF4gvikPTIjPDYY6YtxK2L2caJ6ofxyBESiBLY9pTVjPYp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724350463; c=relaxed/simple;
	bh=n4a7Zzz9NYTg5/fKxmwfiM4aX5kv2/r313/GG/nBTAg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S6nNeXFFmQpYBea5GIWcrqDtloRd2aUKHGkKljty32Ry9m0HCwyF6fI9CdtLOAZGnaMlreo5wF97FsEBL2ERpan7/aF+FcyoX83Q2edo8Am+9RAcZkS6pB6LeKu5eiicowd4sH1RSh8YQRzVoW0O3pH2pnbd7i01IXdUXAEzqK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NAfRacCL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TGhK1T1P; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47MEQZGm008179;
	Thu, 22 Aug 2024 18:14:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=n4a7Zzz9NYTg5/fKxmwfiM4aX5kv2/r313/GG/nBT
	Ag=; b=NAfRacCL5OK1eZuy59r01+W1+/vmqcJeStpNCik6puGWQ+hjwO9hkJuX0
	6yTPFUgbHrnvs0TTXFx2vz8Ltk+iwBx0m0xEyP+89U66rZv8IRNHrO0ZcnrG3V/K
	xDTvmAGBb837xpY3K5oTfZtm0DPOq/naxlQhQaX4N7nQoQn4d6PWm8Xcaif0yASf
	fjnyk1SnDKzmrbbhICSqgzWnrbJeiTaDQTVwxk4HfUsN36yj8UFapArD5VxG6gSH
	S35hyG0BuCTW7Bhvs1nD165GWCp6r9HsSs0ZxhlT/DLbVa56yfObCRuzt/2IB10Y
	xgtLgCCsu09fnj6IWt5t2KRdd+0zw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412mdt2r7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 18:14:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47MHsYg3012036;
	Thu, 22 Aug 2024 18:14:10 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 416a54rxkb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 18:14:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sMBoEtjJH/jDLyq0Mba0UzwQiK2pDAl1yhBhvpqg2dIzLca25LeJHY4DVUJkovYMnulnmGJSSwbWwmG5h9p2WTsP60W2RFfWsg9ObIufcB/By3i3OBS7ipUb7/zNvZAUMYumiu2t6vutlnahyiyBRZuRjtZzY6l8AALdg1YDMV7UqIkZIaiKNHl79ThXeYliB8yD7U0/vbMnOoE1zi9/N76poRiXGplhUH0cDbJdJOSXWYUd1G4AFQvlpOGkHqrFOL7+7/rrAypmyBV6zBuKkS65D2/sPsFrJOnVvb4W6xG+1/hBc/bftN618VutobztjmZ0Nh3PCd6NXfUGWkoTOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4a7Zzz9NYTg5/fKxmwfiM4aX5kv2/r313/GG/nBTAg=;
 b=wk3M31C+dDSKU5A1ibh5m8kSWVZ/Tw513UeScsA04hpOVIdPGzdtmnsJON4vXlpJmhTOwnTHeWi1cD4+B9zo3lA2h/b56d/HLkAWsddhASWtmVoNrGpzp4ij6ZVYrx8/2iRfdrzWAdUMARGfnJuh04FOTgcrP1L6xw0a9unw4uPjg9C1qIw+KT3VAFycQNuQIeTL8Fp3jgRJlGZEISZzn0TUHQGIp5gK8r3frx5nEgfdcKmwB7aZW440EUXN7SK2KpMhbIKEvrayo4Ee0pf13WsHic5zYYowTfuaCOeZ4MI0gfTbUvT51woVRjira8xpQKX+QIp7WvVgLujF06309A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4a7Zzz9NYTg5/fKxmwfiM4aX5kv2/r313/GG/nBTAg=;
 b=TGhK1T1PkDPZ5pFh8DB7TVUfAi0SrQbfobPL7s2cU6raf3hhHM9VE+Hdyw2vrM4tW+Wdzl5dOhdjA4Z+u1t4EMLNquRqcj/pE+6svv9CBjxJi8iXBKpAUuIfDuXOkg8X58BtHeWoZXsySeyeEVC1J3EJ8vT/Bg7MVDzywhVVzr8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5657.namprd10.prod.outlook.com (2603:10b6:510:fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.12; Thu, 22 Aug
 2024 18:14:06 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 18:14:05 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
CC: Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Trond
 Myklebust <trondmy@hammerspace.com>, Neil Brown <neilb@suse.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v12 05/24] nfsd: fix nfsfh tracepoints to properly handle
 NULL rqstp
Thread-Topic: [PATCH v12 05/24] nfsd: fix nfsfh tracepoints to properly handle
 NULL rqstp
Thread-Index:
 AQHa8mQvTP2Cov6+XUyjJX7Dko/VRLIx/zEAgAA84gCAASk8gIAAD80AgAARpYCAAAOeAIAADvAA
Date: Thu, 22 Aug 2024 18:14:05 +0000
Message-ID: <E5C4EC78-8F93-495F-A0BC-B92BCF649DE3@oracle.com>
References: <20240819181750.70570-1-snitzer@kernel.org>
 <20240819181750.70570-6-snitzer@kernel.org>
 <4ab36f95604da25d8c5b419c927d85d362bca2e8.camel@kernel.org>
 <ZsZa7PX0QtZKWt_R@kernel.org> <ZsdUQ1t4L8dfB0BF@tissot.1015granger.net>
 <ZsdhhIY8WQCPWete@kernel.org>
 <b6cee2822295de115681d9f26f0a473e9d69e2c4.camel@kernel.org>
 <ZsdzWgWi36GVpr7Q@kernel.org>
In-Reply-To: <ZsdzWgWi36GVpr7Q@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB5657:EE_
x-ms-office365-filtering-correlation-id: a01f99e8-6461-498c-271b-08dcc2d63580
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MU9haHpCaTZZUHk5WU5YOU93T0hURHFNRkdwMnFJOWVPTjBONERoUU9vQmNC?=
 =?utf-8?B?NWZxT3ZwajNxaVVsSnFDekp4ZHNuSm9lNzFXZG94bEF3eTJLRUFYYW1nNkNV?=
 =?utf-8?B?aWJMQmZmeGVnanVEMzdCQi83SGQ3Qy9UV3M5MjBMeUdXVlpwckdnZUk0ZnBn?=
 =?utf-8?B?dWszNVRFa052SE5wVzE0MFVPMjJnU1YrRVRsM3pDbzRBdGR3c0lPV0Fhb1Nl?=
 =?utf-8?B?WTBaOCtYd0VNdXh2RHpaUnJ6VW41OURiM3VSY0w5bmxCTjQ2bFBtaFBWQmxv?=
 =?utf-8?B?SDFlRHBlNzUxTkNJWnBSNExRbS82RmlYUjl5RnFGaTMxZllGVGRuMklCR2pU?=
 =?utf-8?B?Ykw2VzljMGdaUWJGQ2g0MmhUdFVnZ2swaTE4ZVRTTFVZaExYdGZyUEh5SDFG?=
 =?utf-8?B?eGRWaDlmaFd2UmJma2R3czRMcmRFaEg4a2FXbVpPa09La3BVZkRweU5kZWFv?=
 =?utf-8?B?a1kyZHNWOVhoR1dYYS9xM3NDYnRjT3pJa1BUeGgwVmFwRjFINVcvUzFpM211?=
 =?utf-8?B?aVJHNjR3bVhHeUNVLzFHNVVmQURvU3Q3Q09TVTIrVDkwTXFoMW5ROEx6bjFQ?=
 =?utf-8?B?YlJnV21IUlVjS0sxdzJTdmtIdlFWbGtXYmZsaU9oWGtQYVhGc3lpcjdKYU12?=
 =?utf-8?B?Vlg2RXZXTG0rREZOR0M0ODVVVE5vQ0FhMHpDUmFCekorWktoMUhlLzVNTVFu?=
 =?utf-8?B?aGxFdDZ3WkhEdVhFQTJmbWtJUXF1S0xvMjlkQXY4WUFVNytBZG4rQ0xvdm8z?=
 =?utf-8?B?c2lzMXpMMFJHM1hraWRFa3puY010VDFNcTZSWEVwUFpuOUhQV1FESXMvK1NH?=
 =?utf-8?B?NGVkU3lpSG15ZWRzWFN5alI1OTlhZ3V1OE1lMFBoMHdSand5UDZhd2RDNlJn?=
 =?utf-8?B?ZVhYVlpJUmF3MlVvRmZPMzBycFE0RFhJbjlqeEhpVWVCTW5yUERqZlZWQ09u?=
 =?utf-8?B?dzdmMUgxQTNFQnNyV1ZwaEJ6WU5EbTNrMjBZQjdueEN0M25HdzNtSHhQWCsr?=
 =?utf-8?B?ejd1YWlQYXdXaks5bFE4YWg0R3ZxTFNhMm5VRVR3cnlQYW9iaklpOHpNcWxY?=
 =?utf-8?B?bzUvNFIrWFZzek5hWkZYWVhiNG96NktUTCtMQ1k1dnU5SGlKN1E3Tm1uVWw1?=
 =?utf-8?B?MjRUNE9qRm1PcFRDN0cxYzhWNk13eitUTnVIVTFwOUdtWmpBaS9DTG14YUpX?=
 =?utf-8?B?Wm1admVaK1NnOGJEMng0ZmJSSEovTTZKbnU1WE5Kbk4zYzkvUGFFNDhMWGNm?=
 =?utf-8?B?QzA3MGxKQlJYWi9PN011Uituc0ZjeDdKWkJqRUhSOHk3elF1Q0lCT2xuMXJV?=
 =?utf-8?B?LzBpcXYzenZ0bUU4VEY0MjhLc2x2R0I2UUdqNllFbWROLzl5ZTdCMG9IQ2hk?=
 =?utf-8?B?VUVJcU1aTnd5Zi81OVJDS2gyeTFvUTVzRW5lTVFuQ2VBa0lhM01kRkYrUmR4?=
 =?utf-8?B?OHo3NzlxMXEyOGJNUFovM3RTNmxWOE5ieDFZVnBveVBQSXQvN2dod3BEaGsw?=
 =?utf-8?B?MTYzT3UvdDlyRlNsdm1QU0dGcDRwZFN2SzZZbCtBUm5LRTI5RVdoeUN3bXNI?=
 =?utf-8?B?SE5LdUxrUmpjZmNuRkp3c1lTa0xYbEsyOC9DM0JWWGliWHgxeWZEVk9RdXV1?=
 =?utf-8?B?ZlpwQjJsMkRmMlFHQlNZV3ZSWmc2UjU4QllSenlQd1hxbGpvZlB5L0RqRmd0?=
 =?utf-8?B?TzMxcU9KOExRYitPcnBDM3JpaDNtaGo2NllVVkFlenZpclQ2U3kzVXVRK1pP?=
 =?utf-8?B?dkpjd2NBRFY5SHNrRUJ6V2FkcnVROXRWbnJOZW1taC9Yc29YOG1MS1pkWVFl?=
 =?utf-8?B?UnV3anZ6dWlYa0EycFFpVnhNVEpmU0N2RjFFaHlCKyt3Ni9ESVBCdUVDV1Bx?=
 =?utf-8?B?dXRBdUFTWVFUN01Zc2RXT3ZXNm9TVXZyR2ZwT1lQam0yemc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UHpqbld6NzNtTi9NQ3pHV3M1Vm1wRVFhS0NEelVybE1XOXFGZDdURWlCVk1W?=
 =?utf-8?B?WUJ1dlMzNTFiZkhldERydk15dGJDdWVEdyt6U1lwS2I2UWlRNzZFK3NLWk5s?=
 =?utf-8?B?TkxsNWhXTjV2MVY1dTFKa2lzNWJZMWUvV0NRUGNHSzQvTE1SUXRFckx6bVdr?=
 =?utf-8?B?Y3pvZEg4cFV1aEdQQURCTWxLQmVnUE5lZUdMTmhQSmFMdlZZRWRIQWtUM004?=
 =?utf-8?B?SUdad1FZQmVxRURxM092RlhvbTlrdS9iTVFEaktxUmFtNTVkb0xqU2h5ZHUv?=
 =?utf-8?B?dTBVQXNEK0lIdkJQOXJvTmVpb25oRU45VUJrWnVTZ1BZbldKK2VRR2h3SzFS?=
 =?utf-8?B?NVVvR1FBTFhieHpTTTRZYjk5ckNwellYT04wRTFIR29NOGExeG1DWmRXMGNC?=
 =?utf-8?B?bzh2V1lhSkhXVmxhMG04WldPR2lyL05rT0NKTlk1dzA5WUZ5aXR5TnJidndu?=
 =?utf-8?B?K3V3TElTMFhKSVlnOW40Vzc3emtsdEdicy9YWTU4S1ppVnBVd01KWnJJSCsx?=
 =?utf-8?B?dkVLRGU0cEdLRWt0ZE1xMVBlZGNJcUZuZ1pvNFZkYW9yZThpdXdHdXU2STFl?=
 =?utf-8?B?VEVqRGVEdTZNcnZKYVF1Unpwa2NSMEQxM2VVV05ibFpVWlJqWCtnZGZhU0xw?=
 =?utf-8?B?Ly9Cbi9aekpQL3l1bU0xeG4vdXhRSDlubW1TUTY4dG9mV1JyKy9tc2pJbDRn?=
 =?utf-8?B?ZTFBOWs5THgrQm9vTXowTC9IdFlIQlpwemdrU1g3M1VXcHJlbTJiRWh3M1Vl?=
 =?utf-8?B?SE1LNXc5Y0U4TTcxNGE1bWJXZWFWdFhwMFA3Vk9zTnRPdjZ6YlZJNWMzM0pz?=
 =?utf-8?B?VVkyRERUV3R0a1Y2V1hkM1BxTlhzUWlDdVVTZHFTY2V0WW4yN0JGMmlleGNQ?=
 =?utf-8?B?VjVjSVBKMjFmR3BpblYwTE5IUm5qSEhsd2UyZHhrWm8vRHgzS2JBdHFDWHVs?=
 =?utf-8?B?UURwZG00ems0dmZtNGNNa0FSVnlYcmJWbEhMc1FYRUhLRE1YdS9aN050Qldq?=
 =?utf-8?B?djVKT2lCMzNBdDhwVlhTTzdLMHUvdHk0R2hCU0twaVFtV0ZsMWxpbVBCOWM3?=
 =?utf-8?B?My8yUkx3RzhxRFlDMFdBeHNjTytYQmtqZU5oaTl4VnpEWVdWaDVKeWk1bFZN?=
 =?utf-8?B?VThMSXhpWHVCUlpPaVkyZDdYQXNLd1pyaTVWQyt2QnFtVTZIV0JrNnBWQTRE?=
 =?utf-8?B?am9ldzJFQStnYlVtT3hlQTA2ZjNxTWxienFnM2xHaExKVGNaSUhsckpyaWhZ?=
 =?utf-8?B?dlM4MEdWZm5ZTU1ibzNDTGxvMzNvNUVzcFFPK0x1Z0RJSzFKYUlweFZkWmkw?=
 =?utf-8?B?QTRWdWVPSFl3c2ZIODViM1d3MUsvKzgyS0RteGNpT1A1NFpGMHZJWGx4ZXhp?=
 =?utf-8?B?K0xQMHhaV2lHUXR0VnVZbnpxUm9mSndBUFlVNWRUVWxlcXk2UGE3M29ObjVQ?=
 =?utf-8?B?MVVwdzdCMmVIYzg2cjg1ZURvUFoxZVFHNTRZS212REU5QWxucDE3bHk3akJ3?=
 =?utf-8?B?RGR0YnltV1ZIdFZXUzRFOUYvRFZVQ3kxdHZqdmZRd1dGOXlIbE5QYkV3SlZx?=
 =?utf-8?B?MGJ0Yy9KSjlsWG41TDhBbW5JVjZLRWJpbXlLOHR4dDF4N1FEdmszaWNYM29E?=
 =?utf-8?B?NkVONUFMQWFFWXdqakZ2T0tndURnb1dUblh5LzNwRm9rcks2VXFjUTJrczFk?=
 =?utf-8?B?QXF1NXA0RXNoemZjbkdla2ZsOEJ3dkhmWXBTNGFab1FGZkN3YU5jTHlqNWY1?=
 =?utf-8?B?Q1NQR2FrZ0JRUDFqdjZtWTU0MExEWVNYN0RSZDFkdmQzZTFHaGdFd3JQQWF3?=
 =?utf-8?B?SndFZFNkSmlOYldGNFUvSEpwU2lvZ0lxSlN6RE9QSnlxUHl3cDM5ZEsyQ0da?=
 =?utf-8?B?WHpWZXhDaVVSWG15ekpVS0gwVU9TaGpuZzNYck4rUUxVOGVZZVlVY1lsUE15?=
 =?utf-8?B?aDA3NGFZandMTlMwN0ZhekV1Smcyb0RYK25uMlBSZGFKNlQvczR3ZGh0T0hU?=
 =?utf-8?B?anZCeVQ1bDlYZSt5RkJ0bGJKeU1uVDVNOC95WklPQVVCQUpiVUU5ejdBL1A5?=
 =?utf-8?B?dEl1eFRKTkY3TDRWU3FQNVFSOFp2VVkvUUJyMEE4eUJVRkw1KzNiTEQrUmpo?=
 =?utf-8?B?U2NmaDNUbmlsNzFJUEhGT2xycS9VMXVwNzBTRDE3d0J5TE9TaFc1bEJYTXBj?=
 =?utf-8?B?b0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9493119C33C114E947644BE1EE2E081@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	o9DMv+oHbtRLqpdl+0vkI7GbFvxe8pXtn92Ht0yrffAbzGuDHvxp03b398oJnIbVv9DIJBSXSu20khurrfyjkmdD6Ox3hS1wyRzENUYB4vhifNEGJ/fXQUpB6inqbWC02+1EMl/kUGFIg5VVv3ZEKf3amXphaUWrzNg8u8PaSoC3YqsR5Fa9Vg1Zwp/jPkvRfbS2XRXlCnMjys4UTjO4HoTKjdBUSCRBcBkGfXJqS7UnGBNzXlEJoW6934cfC1mV/Hb8NA1YeTZlsCWna510amk4s3XibjXw8PqQwY11bcpE8N9RLi/nMW42/CaY3bhzOAHareAvzicVkXxK6N5dJtWISwCfQ8wIAgu2rbOcERTRmigec4jKszov8txv3vy5lch+cgtfsSO4ev+lUBx8u6+hkON9g+ATdNB4LPP0/niduqpP+ZiiVtYGJRC5eQc9F52yfV2lIo2Y8bPQvEmzUxARCoqgyN/6m1xZG/uP63Ziaq355uZ1e7irpyq5TN5TAqkwZjXSJcBAf63UdWRkJT9VlhQ/SZsSVUik1SLrdTE7fr7xcAG0u0FoJKIT5AGRLJloqk2WOoZfOvgQg/wWQkRYLMPTcmrMGbJhxki/8MI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a01f99e8-6461-498c-271b-08dcc2d63580
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2024 18:14:05.5762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 55qGo0eOsG0ncbERqSEccyDrvTlPewOJc2STy+lYSvVRq6/iU1r8vUJJz5Flh17noLBSHgfmxu9r6Lu+E8arRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5657
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_11,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408220137
X-Proofpoint-ORIG-GUID: pvI0zKW5rETgTEtDcj5WxW0TzAz0UIzq
X-Proofpoint-GUID: pvI0zKW5rETgTEtDcj5WxW0TzAz0UIzq

DQoNCj4gT24gQXVnIDIyLCAyMDI0LCBhdCAxOjIw4oCvUE0sIE1pa2UgU25pdHplciA8c25pdHpl
ckBrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFRodSwgQXVnIDIyLCAyMDI0IGF0IDAxOjA3
OjI5UE0gLTA0MDAsIEplZmYgTGF5dG9uIHdyb3RlOg0KPj4gT24gVGh1LCAyMDI0LTA4LTIyIGF0
IDEyOjA0IC0wNDAwLCBNaWtlIFNuaXR6ZXIgd3JvdGU6DQo+Pj4gT24gVGh1LCBBdWcgMjIsIDIw
MjQgYXQgMTE6MDc6NDdBTSAtMDQwMCwgQ2h1Y2sgTGV2ZXIgd3JvdGU6DQo+Pj4+IE9uIFdlZCwg
QXVnIDIxLCAyMDI0IGF0IDA1OjIzOjU2UE0gLTA0MDAsIE1pa2UgU25pdHplciB3cm90ZToNCj4+
Pj4+IE9uIFdlZCwgQXVnIDIxLCAyMDI0IGF0IDAxOjQ2OjAyUE0gLTA0MDAsIEplZmYgTGF5dG9u
IHdyb3RlOg0KPj4+Pj4+IE9uIE1vbiwgMjAyNC0wOC0xOSBhdCAxNDoxNyAtMDQwMCwgTWlrZSBT
bml0emVyIHdyb3RlOg0KPj4+Pj4+PiBGaXhlcyBzdG9wLWdhcCB1c2VkIGluIHByZXZpb3VzIGNv
bW1pdCB3aGVyZSBjYWxsZXIgYXZvaWRlZCB1c2luZw0KPj4+Pj4+PiB0cmFjZXBvaW50IGlmIHJx
c3RwIGlzIE5VTEwuICBJbnN0ZWFkLCBoYXZlIGVhY2ggdHJhY2Vwb2ludCBhdm9pZA0KPj4+Pj4+
PiBkZXJlZmVyZW5jaW5nIE5VTEwgcnFzdHAuDQo+Pj4+Pj4+IA0KPj4+Pj4+PiBTaWduZWQtb2Zm
LWJ5OiBNaWtlIFNuaXR6ZXIgPHNuaXR6ZXJAa2VybmVsLm9yZz4NCj4+Pj4+Pj4gLS0tDQo+Pj4+
Pj4+ICBmcy9uZnNkL25mc2ZoLmMgfCAxMiArKysrLS0tLS0tLS0NCj4+Pj4+Pj4gIGZzL25mc2Qv
dHJhY2UuaCB8IDM2ICsrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQ0KPj4+Pj4+
PiAgMiBmaWxlcyBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCAyMyBkZWxldGlvbnMoLSkNCj4+
Pj4+Pj4gDQo+Pj4+Pj4+IGRpZmYgLS1naXQgYS9mcy9uZnNkL25mc2ZoLmMgYi9mcy9uZnNkL25m
c2ZoLmMNCj4+Pj4+Pj4gaW5kZXggMTllMTczMTg3YWI5Li5iYWU3MjdlNjUyMTQgMTAwNjQ0DQo+
Pj4+Pj4+IC0tLSBhL2ZzL25mc2QvbmZzZmguYw0KPj4+Pj4+PiArKysgYi9mcy9uZnNkL25mc2Zo
LmMNCj4+Pj4+Pj4gQEAgLTE5NSw4ICsxOTUsNyBAQCBzdGF0aWMgX19iZTMyIG5mc2Rfc2V0X2Zo
X2RlbnRyeShzdHJ1Y3Qgc3ZjX3Jxc3QNCj4+Pj4+Pj4gKnJxc3RwLCBzdHJ1Y3QgbmV0ICpuZXQs
DQo+Pj4+Pj4+ICANCj4+Pj4+Pj4gICBlcnJvciA9IG5mc2Vycl9zdGFsZTsNCj4+Pj4+Pj4gICBp
ZiAoSVNfRVJSKGV4cCkpIHsNCj4+Pj4+Pj4gLSBpZiAocnFzdHApDQo+Pj4+Pj4+IC0gdHJhY2Vf
bmZzZF9zZXRfZmhfZGVudHJ5X2JhZGV4cG9ydChycXN0cCwNCj4+Pj4+Pj4gZmhwLCBQVFJfRVJS
KGV4cCkpOw0KPj4+Pj4+PiArIHRyYWNlX25mc2Rfc2V0X2ZoX2RlbnRyeV9iYWRleHBvcnQocnFz
dHAsIGZocCwNCj4+Pj4+Pj4gUFRSX0VSUihleHApKTsNCj4+Pj4+Pj4gIA0KPj4+Pj4+PiAgIGlm
IChQVFJfRVJSKGV4cCkgPT0gLUVOT0VOVCkNCj4+Pj4+Pj4gICByZXR1cm4gZXJyb3I7DQo+Pj4+
Pj4+IEBAIC0yNDQsOCArMjQzLDcgQEAgc3RhdGljIF9fYmUzMiBuZnNkX3NldF9maF9kZW50cnko
c3RydWN0IHN2Y19ycXN0DQo+Pj4+Pj4+ICpycXN0cCwgc3RydWN0IG5ldCAqbmV0LA0KPj4+Pj4+
PiAgIGRhdGFfbGVmdCwNCj4+Pj4+Pj4gZmlsZWlkX3R5cGUsIDAsDQo+Pj4+Pj4+ICAgbmZzZF9h
Y2NlcHRhYmxlLA0KPj4+Pj4+PiBleHApOw0KPj4+Pj4+PiAgIGlmIChJU19FUlJfT1JfTlVMTChk
ZW50cnkpKSB7DQo+Pj4+Pj4+IC0gaWYgKHJxc3RwKQ0KPj4+Pj4+PiAtDQo+Pj4+Pj4+IHRyYWNl
X25mc2Rfc2V0X2ZoX2RlbnRyeV9iYWRoYW5kbGUocnFzdHAsIGZocCwNCj4+Pj4+Pj4gKyB0cmFj
ZV9uZnNkX3NldF9maF9kZW50cnlfYmFkaGFuZGxlKHJxc3RwLA0KPj4+Pj4+PiBmaHAsDQo+Pj4+
Pj4+ICAgZGVudHJ5ID8gIFBUUl9FUlIoZGVudHJ5KSA6DQo+Pj4+Pj4+IC1FU1RBTEUpOw0KPj4+
Pj4+PiAgIHN3aXRjaCAoUFRSX0VSUihkZW50cnkpKSB7DQo+Pj4+Pj4+ICAgY2FzZSAtRU5PTUVN
Og0KPj4+Pj4+PiBAQCAtMzIxLDggKzMxOSw3IEBAIF9fZmhfdmVyaWZ5KHN0cnVjdCBzdmNfcnFz
dCAqcnFzdHAsDQo+Pj4+Pj4+ICAgZGVudHJ5ID0gZmhwLT5maF9kZW50cnk7DQo+Pj4+Pj4+ICAg
ZXhwID0gZmhwLT5maF9leHBvcnQ7DQo+Pj4+Pj4+ICANCj4+Pj4+Pj4gLSBpZiAocnFzdHApDQo+
Pj4+Pj4+IC0gdHJhY2VfbmZzZF9maF92ZXJpZnkocnFzdHAsIGZocCwgdHlwZSwgYWNjZXNzKTsN
Cj4+Pj4+Pj4gKyB0cmFjZV9uZnNkX2ZoX3ZlcmlmeShuZXQsIHJxc3RwLCBmaHAsIHR5cGUsIGFj
Y2Vzcyk7DQo+Pj4+Pj4+ICANCj4+Pj4+Pj4gICAvKg0KPj4+Pj4+PiAgICAqIFdlIHN0aWxsIGhh
dmUgdG8gZG8gYWxsIHRoZXNlIHBlcm1pc3Npb24gY2hlY2tzLCBldmVuDQo+Pj4+Pj4+IHdoZW4N
Cj4+Pj4+Pj4gQEAgLTM3Niw4ICszNzMsNyBAQCBfX2ZoX3ZlcmlmeShzdHJ1Y3Qgc3ZjX3Jxc3Qg
KnJxc3RwLA0KPj4+Pj4+PiAgIC8qIEZpbmFsbHksIGNoZWNrIGFjY2VzcyBwZXJtaXNzaW9ucy4g
Ki8NCj4+Pj4+Pj4gICBlcnJvciA9IG5mc2RfcGVybWlzc2lvbihjcmVkLCBleHAsIGRlbnRyeSwg
YWNjZXNzKTsNCj4+Pj4+Pj4gIG91dDoNCj4+Pj4+Pj4gLSBpZiAocnFzdHApDQo+Pj4+Pj4+IC0g
dHJhY2VfbmZzZF9maF92ZXJpZnlfZXJyKHJxc3RwLCBmaHAsIHR5cGUsIGFjY2VzcywNCj4+Pj4+
Pj4gZXJyb3IpOw0KPj4+Pj4+PiArIHRyYWNlX25mc2RfZmhfdmVyaWZ5X2VycihuZXQsIHJxc3Rw
LCBmaHAsIHR5cGUsIGFjY2VzcywNCj4+Pj4+Pj4gZXJyb3IpOw0KPj4+Pj4+PiAgIGlmIChlcnJv
ciA9PSBuZnNlcnJfc3RhbGUpDQo+Pj4+Pj4+ICAgbmZzZF9zdGF0c19maF9zdGFsZV9pbmMobm4s
IGV4cCk7DQo+Pj4+Pj4+ICAgcmV0dXJuIGVycm9yOw0KPj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZnMv
bmZzZC90cmFjZS5oIGIvZnMvbmZzZC90cmFjZS5oDQo+Pj4+Pj4+IGluZGV4IDc3YmJkMjNhYTE1
MC4uZDQ5YjNjMWUzYmE5IDEwMDY0NA0KPj4+Pj4+PiAtLS0gYS9mcy9uZnNkL3RyYWNlLmgNCj4+
Pj4+Pj4gKysrIGIvZnMvbmZzZC90cmFjZS5oDQo+Pj4+Pj4+IEBAIC0xOTUsMTIgKzE5NSwxMyBA
QCBUUkFDRV9FVkVOVChuZnNkX2NvbXBvdW5kX2VuY29kZV9lcnIsDQo+Pj4+Pj4+ICANCj4+Pj4+
Pj4gIFRSQUNFX0VWRU5UKG5mc2RfZmhfdmVyaWZ5LA0KPj4+Pj4+PiAgIFRQX1BST1RPKA0KPj4+
Pj4+PiArIGNvbnN0IHN0cnVjdCBuZXQgKm5ldCwNCj4+Pj4+Pj4gICBjb25zdCBzdHJ1Y3Qgc3Zj
X3Jxc3QgKnJxc3RwLA0KPj4+Pj4+PiAgIGNvbnN0IHN0cnVjdCBzdmNfZmggKmZocCwNCj4+Pj4+
Pj4gICB1bW9kZV90IHR5cGUsDQo+Pj4+Pj4+ICAgaW50IGFjY2Vzcw0KPj4+Pj4+PiAgICksDQo+
Pj4+Pj4+IC0gVFBfQVJHUyhycXN0cCwgZmhwLCB0eXBlLCBhY2Nlc3MpLA0KPj4+Pj4+PiArIFRQ
X0FSR1MobmV0LCBycXN0cCwgZmhwLCB0eXBlLCBhY2Nlc3MpLA0KPj4+Pj4+PiAgIFRQX1NUUlVD
VF9fZW50cnkoDQo+Pj4+Pj4+ICAgX19maWVsZCh1bnNpZ25lZCBpbnQsIG5ldG5zX2lubykNCj4+
Pj4+Pj4gICBfX3NvY2thZGRyKHNlcnZlciwgcnFzdHAtPnJxX3hwcnQtPnhwdF9yZW1vdGVsZW4p
DQo+Pj4+Pj4+IEBAIC0yMTIsMTIgKzIxMywxNCBAQCBUUkFDRV9FVkVOVChuZnNkX2ZoX3Zlcmlm
eSwNCj4+Pj4+Pj4gICBfX2ZpZWxkKHVuc2lnbmVkIGxvbmcsIGFjY2VzcykNCj4+Pj4+Pj4gICAp
LA0KPj4+Pj4+PiAgIFRQX2Zhc3RfYXNzaWduKA0KPj4+Pj4+PiAtIF9fZW50cnktPm5ldG5zX2lu
byA9IFNWQ19ORVQocnFzdHApLT5ucy5pbnVtOw0KPj4+Pj4+PiAtIF9fYXNzaWduX3NvY2thZGRy
KHNlcnZlciwgJnJxc3RwLT5ycV94cHJ0LQ0KPj4+Pj4+Pj4geHB0X2xvY2FsLA0KPj4+Pj4+PiAt
ICAgICAgICBycXN0cC0+cnFfeHBydC0+eHB0X2xvY2FsbGVuKTsNCj4+Pj4+Pj4gLSBfX2Fzc2ln
bl9zb2NrYWRkcihjbGllbnQsICZycXN0cC0+cnFfeHBydC0NCj4+Pj4+Pj4+IHhwdF9yZW1vdGUs
DQo+Pj4+Pj4+IC0gICBycXN0cC0+cnFfeHBydC0+eHB0X3JlbW90ZWxlbik7DQo+Pj4+Pj4+IC0g
X19lbnRyeS0+eGlkID0gYmUzMl90b19jcHUocnFzdHAtPnJxX3hpZCk7DQo+Pj4+Pj4+ICsgX19l
bnRyeS0+bmV0bnNfaW5vID0gbmV0LT5ucy5pbnVtOw0KPj4+Pj4+PiArIGlmIChycXN0cCkgew0K
Pj4+Pj4+PiArIF9fYXNzaWduX3NvY2thZGRyKHNlcnZlciwgJnJxc3RwLT5ycV94cHJ0LQ0KPj4+
Pj4+Pj4geHB0X2xvY2FsLA0KPj4+Pj4+PiArICAgcnFzdHAtPnJxX3hwcnQtDQo+Pj4+Pj4+PiB4
cHRfbG9jYWxsZW4pOw0KPj4+Pj4+PiArIF9fYXNzaWduX3NvY2thZGRyKGNsaWVudCwgJnJxc3Rw
LT5ycV94cHJ0LQ0KPj4+Pj4+Pj4geHB0X3JlbW90ZSwNCj4+Pj4+Pj4gKyAgIHJxc3RwLT5ycV94
cHJ0LQ0KPj4+Pj4+Pj4geHB0X3JlbW90ZWxlbik7DQo+Pj4+Pj4+ICsgfQ0KPj4+Pj4+IA0KPj4+
Pj4+IERvZXMgdGhpcyBuZWVkIGFuIGVsc2UgYnJhbmNoIHRvIHNldCB0aGVzZSB2YWx1ZXMgdG8g
c29tZXRoaW5nIHdoZW4NCj4+Pj4+PiBycXN0cCBpcyBOVUxMLCBvciBhcmUgd2UgZ3VhcmFudGVl
ZCB0aGF0IHRoZXkgYXJlIGFscmVhZHkgemVyb2VkIG91dA0KPj4+Pj4+IHdoZW4gdGhleSBhcmVu
J3QgYXNzaWduZWQ/DQo+Pj4+PiANCj4+Pj4+IEknbSBub3Qgc3VyZS4gIEl0IGlzbid0IGltbWVk
aWF0ZWx5IGNsZWFyIHdoYXQgaXMgYWN0dWFsbHkgdXNpbmcgdGhlc2UuDQo+Pj4+PiANCj4+Pj4+
IEJ1dCBJIGRpZCBqdXN0IG5vdGljZSBhbiBpbmNvbnNpc3RlbmN5LCB0aGVzZSBlbnRyeSBtZW1i
ZXJzIGFyZSBkZWZpbmVkOg0KPj4+Pj4gDQo+Pj4+PiAgICAgICAgICAgICAgICBfX3NvY2thZGRy
KHNlcnZlciwgcnFzdHAtPnJxX3hwcnQtPnhwdF9yZW1vdGVsZW4pDQo+Pj4+PiAgICAgICAgICAg
ICAgICBfX3NvY2thZGRyKGNsaWVudCwgcnFzdHAtPnJxX3hwcnQtPnhwdF9yZW1vdGVsZW4pDQo+
Pj4+PiANCj4+Pj4+IFlldCB0aGV5IGdvIG9uIHRvIHVzZSBycXN0cC0+cnFfeHBydC0+eHB0X2xv
Y2FsbGVuIGFuZA0KPj4+Pj4gcnFzdHAtPnJxX3hwcnQtPnhwdF9yZW1vdGVsZW4gcmVzcGVjdGl2
ZWx5Lg0KPj4+Pj4gDQo+Pj4+PiBDaHVjaywgd291bGQgd2VsY29tZSB5b3VyIGZlZWRiYWNrIG9u
IGhvdyB0byBwcm9wZXJseSBmaXggdGhlc2UNCj4+Pj4+IHRyYWNlcG9pbnRzIHRvIGhhbmRsZSBy
cXN0cCBiZWluZyBOVUxMLiAgQW5kIHRoZSBpbmNvbnNpc3RlbmN5IEkganVzdA0KPj4+Pj4gbm90
ZWQgaXMgc29tZXRoaW5nIGV4dHJhLg0KPj4+PiANCj4+Pj4gRmlyc3QsIGEgY29tbWVudCBhYm91
dCBwYXRjaCBvcmRlcmluZzogSSB0aGluayB5b3UgY2FuIHByZXNlcnZlDQo+Pj4+IGF0dHJpYnV0
aW9uIGJ1dCBtYWtlIHRoZXNlIGEgbGl0dGxlIGVhc2llciB0byBkaWdlc3QgaWYgeW91IHJldmVy
c2UNCj4+Pj4gNC8gYW5kIDUvLiBGaXggdGhlIHByb2JsZW0gYmVmb3JlIGl0IGJlY29tZXMgYSBw
cm9ibGVtLCBhcyBpdCB3ZXJlLg0KPj4+PiANCj4+Pj4gQXMgYSBnZW5lcmFsIHJlbWFyaywgSSB3
b3VsZCBwcmVmZXIgdG8gcmV0YWluIHRoZSB0cmFjZSBwb2ludHMgYW5kDQo+Pj4+IGV2ZW4gdGhl
IGFkZHJlc3MgaW5mb3JtYXRpb24gaW4gdGhlIGxvY2FsIEkvTyBjYXNlOiB0aGUgY2xpZW50DQo+
Pj4+IGFkZHJlc3MgaXMgYW4gaW1wb3J0YW50IHBhcnQgb2YgdGhlIGRlY2lzaW9uIHRvIHBlcm1p
dCBvciBkZW55DQo+Pj4+IGFjY2VzcyB0byB0aGUgRkggaW4gcXVlc3Rpb24uIFRoZSBpc3N1ZSBp
cyBob3cgdG8gbWFrZSB0aGF0DQo+Pj4+IGhhcHBlbi4uLg0KPj4+PiANCj4+Pj4gVGhlIF9fc29j
a2FkZHIoKSBtYWNyb3MgSSB0aGluayB3aWxsIHRyaWdnZXIgYW4gb29wcyBpZg0KPj4+PiBycXN0
cCA9PSBOVUxMLiBUaGUgc2Vjb25kIGFyZ3VtZW50IGRldGVybWluZXMgdGhlIHNpemUgb2YgYQ0K
Pj4+PiB2YXJpYWJsZS1sZW5ndGggdHJhY2UgZmllbGQgSUlSQy4gT25lIHdheSB0byBhdm9pZCB0
aGF0IGlzIHRvIHVzZSBhDQo+Pj4+IGZpeGVkIHNpemUgZmllbGQgZm9yIHRoZSBhZGRyZXNzZXMg
KGJpZyBlbm91Z2ggdG8gc3RvcmUgYW4gSVB2Ng0KPj4+PiBhZGRyZXNzPyAgb3IgYW4gYWJzdHJh
Y3QgYWRkcmVzcz8gdGhvc2UgY2FuIGdldCBwcmV0dHkgYmlnKQ0KPj4+PiANCj4+Pj4gSSBuZWVk
IHRvIHN0dWR5IDQvIG1vcmUgY2xvc2VseTsgcGVyaGFwcyBpdCBpcyBkb2luZyB0b28gbXVjaCBp
biBhDQo+Pj4+IHNpbmdsZSBwYXRjaC4gKGllLCB0aGUgY29kZSBlbmRzIHVwIGluIGEgYmV0dGVy
IHBsYWNlLCBidXQgdGhlDQo+Pj4+IGRldGFpbHMgb2YgdGhlIHRyYW5zaXRpb24gYXJlIG9ic2N1
cmVkIGJ5IGJlaW5nIGx1bXBlZCB0b2dldGhlciBpbnRvDQo+Pj4+IG9uZSBwYXRjaCkuDQo+Pj4+
IA0KPj4+PiBTbywgY2FuIHlvdSBvciBOZWlsIGFuc3dlcjogd2hhdCB3b3VsZCBhcHBlYXIgYXMg
dGhlIGNsaWVudCBhZGRyZXNzDQo+Pj4+IGZvciBsb2NhbCBJL08gPw0KPj4+IA0KPj4+IEJlZm9y
ZSB3aGVuIHRoZXJlIHdhcyB0aGUgImZha2UiIHN2Y19ycXN0IGl0IHdhcyBpbml0aWFsaXplZCB3
aXRoOg0KPj4+IA0KPj4+ICAgICAgIC8qIE5vdGU6IHdlJ3JlIGNvbm5lY3RpbmcgdG8gb3Vyc2Vs
Ziwgc28gc291cmNlIGFkZHIgPT0gcGVlciBhZGRyICovDQo+Pj4gICAgICAgcnFzdHAtPnJxX2Fk
ZHJsZW4gPSBycGNfcGVlcmFkZHIocnBjX2NsbnQsDQo+Pj4gICAgICAgICAgICAgICAgICAgICAg
IChzdHJ1Y3Qgc29ja2FkZHIgKikmcnFzdHAtPnJxX2FkZHIsDQo+Pj4gICAgICAgICAgICAgICAg
ICAgICAgIHNpemVvZihycXN0cC0+cnFfYWRkcikpOw0KPj4+IA0KPj4+IEFueXdheSwgYXMgdGhl
IGNvZGUgaXMgYWxzbyBub3c6IHRoZSBycGNfY2xudCBwYXNzZWQgdG8NCj4+PiBuZnNkX29wZW5f
bG9jYWxfZmgoKSB3aWxsIHJlZmxlY3QgdGhlIHNhbWUgYWRkcmVzcyBhcyB0aGUgc2VydmVyLg0K
DQpJIGFncmVlIGl0IHNob3VsZCBiZSB0aGUgY2xpZW50J3MgYWN0dWFsIGFkZHJlc3MgdGhhdCBp
cw0KcmVjb3JkZWQgaW4gbmZzZF9vcGVuX2xvY2FsX2ZoKCkgYW5kIGxhdGVyIHJlcG9ydGVkIGJ5
DQp0cmFjZSBwb2ludHMgb3Igb3RoZXIgaW5zdHJ1bWVudGF0aW9uLg0KDQoNCj4+PiBNeSB0aGlu
a2luZyB3YXMgdGhhdCBmb3IgbG9jYWxpbyB0aGVyZSBkb2Vzbid0IG5lZWQgdG8gYmUgYW55IGV4
cGxpY2l0DQo+Pj4gbGlzdGluZyBvZiB0aGUgYWRkcmVzcyBpbmZvIGluIHRoZSB0cmFjZXBvaW50
cyAoYnV0IHRoYXQnZCBiZSBtb3JlDQo+Pj4gY29udmluY2luZyBpZiB3ZSBhdCBsZWFzdCBsb2dn
ZWQgbG9jYWxpbyBieSBsb29raW5nIGZvciBhbmQgbG9nZ2luZw0KPj4+IE5GU0RfTUFZX0xPQ0FM
SU8gaW4gbWF5ZmxhZ3MgcGFzc2VkIHRvIG5mc2RfZmlsZV9hY3F1aXJlX2xvY2FsKS4NCj4+PiAN
Cj4+PiBCdXQgSSBhZ3JlZSBpdCdkIGJlIG5pY2UgdG8gaGF2ZSB0cmFjZXBvaW50cyBsb2cgbWF0
Y2hpbmcgMTI3LjAuMC4xIG9yDQo+Pj4gOjoxLCBldGMgLS0ganVzdCBkb24ndCB0aGluayBpdCBz
dHJpY3RseSBuZWNlc3NhcnkuDQoNClRoZSB1c3VhbCB1c2FnZSBzY2VuYXJpbyBmb3IgdGhlIElQ
IGFkZHJlc3MgaW4gdGhlc2UgcGFydGljdWxhcg0KdHJhY2UgcG9pbnRzIGlzIHRvIHRyb3VibGVz
aG9vdCBpbmNvcnJlY3Qgc2VjdXJpdHkgcG9saWN5DQpzZXR0aW5ncyAoaWUsIGV4cG9ydCBvcHRp
b25zIGJhc2VkIG9uIGNsaWVudCBJUCBhZGRyZXNzKS4NCg0KSSdtIG5vdCBleGFjdGx5IGNsZWFy
IG9uIGhvdyBleHBvcnQgb3B0aW9ucyBhcHBseSB0byBMT0NBTElPDQpvcGVuIHJlcXVlc3RzIC0t
IHRoYXQncyB0aGUgbWFpbiBmb2N1cyBvZiB0aGUgc2VjdXJpdHktcmVsYXRlZA0KcmV2aWV3IEkg
cGxhbiB0byBkby4NCg0KKFNpbWlsYXJpdHkgdG8gcmVtb3RlIE5GU3YzIGJlaGF2aW9yLCBhcyBk
ZXNjcmliZWQgaW4geW91ciBvdGhlcg0KZW1haWwgcmVwbHksIGlzIGluZGVlZCB0aGUgcHJlZmVy
cmVkIG1vZGVsLCBJTU8pLg0KDQoNCj4+PiBPcGVuIHRvIHdoYXRldmVyIHlvdSB0aGluayBiZXN0
Lg0KPj4+IA0KPj4gDQo+PiBUaGUgY2xpZW50IGlzIGxpa2VseSB0byBiZSBjb21pbmcgZnJvbSBh
IGRpZmZlcmVudCBjb250YWluZXIgaW4gbWFueQ0KPj4gY2FzZXMgYW5kIHNvIHdvbid0IGJlIGNv
bWluZyBpbiB2aWEgdGhlIGxvb3BiYWNrIGludGVyZmFjZS4gUHJlc2VudGluZw0KPj4gYSBsb29w
YmFjayBhZGRyZXNzIGluIHRoYXQgY2FzZSBzZWVtcyB3cm9uZy4NCj4gDQo+IFJpZ2h0LCB3YXNu
J3Qgc3VnZ2VzdGluZyB0byBhbHdheXMgZGlzcGxheSBsb29wYmFjayBpbnRlcmZhY2UsIHdhcw0K
PiBzYXlpbmcgaWRlYWwgdG8gZGlzcGxheSByZWFsaXR5LiAgVGhlcmUgaXNuJ3QgYW55dGhpbmcg
c3BlY2lhbCBpbiB0aGUNCj4gcnBjX2NsbnQgYWRkcmVzcy4gIFRoZSBsb2NhbGlvIFJQQyBjbGll
bnQgaXMgY29ubmVjdGluZyB0byB0aGUgc2VydmVyDQo+IHVzaW5nIHRoZSBzYW1lIHJwY2NsaWVu
dCBhcyBORlMgKGNsb25lZCBmcm9tIHRoYXQgdXNlZCBmb3IgTkZTKS4NCj4gDQo+PiBXaGF0IHdv
dWxkIGJlIGlkZWFsIElNTyB3b3VsZCBiZSB0byBzdGlsbCBkaXNwbGF5IHRoZSBhZGRyZXNzZXMg
ZnJvbQ0KPj4gdGhlIHJwY19jbG50IGFuZCBqdXN0IGRpc3BsYXkgYSBmbGFnIG9yIHNvbWV0aGlu
ZyB0aGF0IHNob3dzIHRoYXQgdGhpcw0KPj4gaXMgYSBsb2NhbGlvIHJlcXVlc3QuIEhhdmluZyB0
byBwYXNzIHRoYXQgYXMgYW4gYWRkaXRpb25hbCBhcmcgdG8NCj4+IF9fZmhfdmVyaWZ5IHdvdWxk
IGJlIHByZXR0eSB1Z2x5IHRob3VnaCAoYW5kIG1heSBiZSBhIGxheWVyaW5nDQo+PiB2aW9sYXRp
b24pLg0KDQpORlNEX01BWV9MT0NBTElPIG1pZ2h0IGJlIHNldCBvbmx5IGZvciBMT0NBTElPIG9w
ZW5zLiBJIGRvbid0DQp0aGluayBpdCBpcyB0b2RheSwgYnV0IHRoYXQgY291bGQgYmUgb25lIHdh
eSB0byBpbmRpY2F0ZSB0aGUNCmRpZmZlcmVuY2UgaW4gY2FsbGVycy4NCg0KDQo+IEkgYWdyZWUu
ICBCdXQgeWVhaCwgSSBkb24ndCBoYXZlIGEgc2Vuc2UgZm9yIGhvdyB0byBkbyB0aGlzIGNsZWFu
bHkuDQo+IA0KPiBQYXNzIHJwY19jbG50IGluIGFuZCBvbmx5IHVzZSBpdCBmb3IgYWRkcmVzcyBp
ZiBtYXlmbGFncyBoYXMNCj4gTkZTRF9NQVlfTE9DQUxJTyBzZXQgX2FuZF8gcnFzdG9wIGlzIE5V
TEw/DQoNCldpbGwgaGF2ZSBhIGxvb2ssIGJ1dCBJIGJldCBOZWlsIG1pZ2h0IGJlIHRoZSBiZXN0
IHBlcnNvbiB0bw0KcHJvcG9zZSBhbiBpbml0aWFsIGRlc2lnbi4NCg0KDQotLQ0KQ2h1Y2sgTGV2
ZXINCg0KDQo=

