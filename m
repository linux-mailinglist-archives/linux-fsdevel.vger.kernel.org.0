Return-Path: <linux-fsdevel+bounces-69934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1973CC8C580
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 00:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 45FD93507C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 23:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79954315D4E;
	Wed, 26 Nov 2025 23:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i4tf7Jzg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1D5304BDC;
	Wed, 26 Nov 2025 23:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764199362; cv=fail; b=gzmTV5+oLNW/yTQtV4vEo/Bib7WUc1foXOjiHcgKxegJyum7WwdILeJJod/T84AtsCTqd3BNt8ilZqmLROAVy4YyWLrte9TYvoXXaZCGMKVgdL6UfOKTNhiQNkv8/CDYR5A875s2PnSzFB0JTSoBzuwa1xW4gI49kMlnlTXHe20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764199362; c=relaxed/simple;
	bh=dVY3oab1jtgsr9k7/P4Ov4k+GpLe4IZS7i29IzKSKZM=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=KdSjq5UULUsvonFR4tVv4eXhgFw/MGovQmdb00jlisD687ZTNIMQ7aSVUMfpxU9/4qd9lhi0PJoWoFs602QmERVyUS9e0qV3XTEA7j+OUmbT9/sYAafuBPEdQkLR1pnfQd3kN2RdUmkylvOlFizDkGCjDybSiGLnYu0K+91Asw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=i4tf7Jzg; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQMFgc0006252;
	Wed, 26 Nov 2025 23:22:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=dVY3oab1jtgsr9k7/P4Ov4k+GpLe4IZS7i29IzKSKZM=; b=i4tf7Jzg
	zGIcErkenFJCwh4cnbQ547PoFHZhKQV0xVuLq7H5PiRKszs9Uw5dSnS+d7kIHNaW
	bgukWAIx4DLQhVWd3qidCzlZgHXyyJPV/BMdH35xsjRbabJY7KFeZ/OTRUUeGdu5
	j7WMRjFS+tDs79sE6dU/k0/Aj01MCjxNXDAUJVcKoH25qpNDdA5sgVDewoN6Qs0q
	EbANJTUPtK8sT4vTZW4Pq9/tl/3UORiKFWc0yYXOu8hY2n6qJetU/vJYsNkrrPjl
	baAL3v8EOzfz9Hb+LMurSE0eFHZdIh9VQsFwKBnOWIRoOpfENAZZN4bnN1yluz/i
	P6mdElUEes5jxA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4uvetae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 23:22:40 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AQNMeCG026503;
	Wed, 26 Nov 2025 23:22:40 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011003.outbound.protection.outlook.com [40.107.208.3])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4uvetab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 23:22:40 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LObM4Grz1tdny8+VTSlFvipU4VKOvLh2NH4/6z2XUxTJ7tmRd08qio9Z8UuEfZn6UvA7TqxHyFH8iGCHtNfNBrAQjiPwrGEmJEecEbEsogceVDtabkEoe6nK433IrcHln8cs06hBpSGDVvXQGIIR5wUKNJfIx9LtG2bj9xQqEpiV3cf17Bjpqia96/3Uaif4Mi7hXkDypGmZxKR+uEWzPZu80EftncdzPqvc0Q6kFaDFhb4yIAtfkqzkiJx80Hfw9Gf/8dN3ao+KTN3rBkrlfpBvK0wCvhrq7phmzXsj1i8+8+LFtd38Wgq0Uzk4D/JTxislzpB7D6YytO4qv1ngnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVY3oab1jtgsr9k7/P4Ov4k+GpLe4IZS7i29IzKSKZM=;
 b=wNu71+jZTzOmdqz2Eu/L16zZh31do/yDga4t9yItKOxBXYwyYo6W8VT7nuuRpmJ+172hXBJCdr96lb8533IrhZqz4LI9TcV+QMSKw7ikCopmJvJsmpeOJ1Hx+Z2MD+B0sa0hrhebY0rBBSFr8ZJAo2feOqfKu6feFpxOz96WOUoTikdoIMvzJtgpu9J27c8qrRNcuC55HedT0a3hkWZZWCxeqz+9O1OaFDWkmbCwvY5sskL2GyKeDNsNa4Eimk5jjuDa3y3p/GQ4xR/okL3pJmPo2K4uG63+YvN39J5AxOTdYgxkPAv0+JYuzdAtnsXoLPMf67wcrofbmHtYTSgdUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by BY3PR15MB5090.namprd15.prod.outlook.com (2603:10b6:a03:3cd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 23:22:38 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 23:22:38 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "nix155nix@gmail.com" <nix155nix@gmail.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [REGRESSION] CephFS kernel client crash (NULL deref
 in strcmp) since Linux 6.17.8
Thread-Index: AQHcXyoo8jk8nOik7E+4JnlVV8GLtrUFmMWA
Date: Wed, 26 Nov 2025 23:22:38 +0000
Message-ID: <53f37729a201ab5878559f178fedb55ef01551a7.camel@ibm.com>
References:
 <CABS1u1DX+YB+Vz1_1gZ0byPLjk7Qhv9x9X+xJYGxx3uWTWyiLw@mail.gmail.com>
In-Reply-To:
 <CABS1u1DX+YB+Vz1_1gZ0byPLjk7Qhv9x9X+xJYGxx3uWTWyiLw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|BY3PR15MB5090:EE_
x-ms-office365-filtering-correlation-id: dd6fa6ef-20a9-402e-52ec-08de2d42b039
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?cXZHb1RCRGg1Q2U1ZG5zR1hMaUZaT0x5cHd2Q2plUFlCOTFBc0RpbUdmYzB0?=
 =?utf-8?B?WWo5aW5PZ0YybWp0NjJzMit4N3Q4L0xEZ1dYRW84ZVV1eWh1Wi92S2FxdW80?=
 =?utf-8?B?WGNOYmxKOXFhZ3dUYjJIUS9VSWNDVTl0MVdXV3h0VnI2RjBFVWhsRHc2Q3Az?=
 =?utf-8?B?Z0NZSWN5V0dCWERDU29qSmR3cFBKZW5iSy9UY1pLNnN6QzB4ZDEzVHdPVkJU?=
 =?utf-8?B?Um1XY2RZS2JpVXZVWnQ2T3M0MEh0eFo4V0JnMUNvVWp4NXpJR2o2UG5vMkxk?=
 =?utf-8?B?UlE2TlVZeFo1bjBkTExKYUt0VmIxU2twK1NzWXNMeEhTNEJSQzZoRHFKeXRU?=
 =?utf-8?B?QU5MZGh3Qnh4QlRQVDlUNllZZC9yREJHa1AwQUdDN214RktJUWlyeFJHUjJh?=
 =?utf-8?B?RUZEYm85dE91b2xaZFRzOWh4T1hENURySTN0VUJGajkrd0t4Tm5RMlpMOVVx?=
 =?utf-8?B?aCtvRU1IVEVFNFM5bWpHVUZpTjdEUkgzS0JoR2xnNUVPbjluTU9ZaGRncURX?=
 =?utf-8?B?UFdpN2YxaWxnRnpJS1F2TTVoWnNPcURYUmJtaEN5bkRmUXczZW5MYTFoaDlp?=
 =?utf-8?B?a0hRUFhkL0Y1cTl4by9GZkgyL3VyQkEyR3NUaFhTSGsyNnBpRFZCdSs5MVRX?=
 =?utf-8?B?L3BhT3pCYko0dmdocXFkank3RW51S1RYejhyL1FBTTVnZ29ydWhCTmYxM093?=
 =?utf-8?B?aFM3eWs3M0RUTDFJMGRuNmRwSG1lcXJoR21wYjNVS0JCblo3eko5ZytONWx4?=
 =?utf-8?B?SFRNSlNRaVM1Vks3ejZqVGl1STJhTnp2QlliUlpPK1BzSmlzTmZoOFlZcGN1?=
 =?utf-8?B?NDBJZ2xlNXpnL2ZRbk5FdWtvelA3R01WaW1Bbkh4SW9mWjNPOU9VTlBiUUJs?=
 =?utf-8?B?VnZmSmVFZW1RckMzZ245YmZQZDRUK3ZxcmtualFNdFExTTAzZ3VjSWJnOWhN?=
 =?utf-8?B?SmN5bEhETjFJNFlXRDZ2K25XNDZWbzdYdDlnMVpMaE1kVWRuSjl3RHNoYXdK?=
 =?utf-8?B?Ykx6VG8wVGtxTHVIMHNwaXQrVEZyakVURnROc09sdytuejdxcWs4eGZacDBu?=
 =?utf-8?B?Ymd0ekoxRlVySEozUDJGTmhsU3ZYLzdNek5yN2phWGZqSXJYcExkbzl4UUxn?=
 =?utf-8?B?eG1GRGRMWjhKcEkxNG5oVHJmdzVyeDB3elE2cEZ2TTJGeGNZZVJnUXZ5eHRa?=
 =?utf-8?B?NlZXdXRjREVmaDBIdnQ2Nk9iZzBqVXZxak5XNDNqQ0ZrbHF3MUloV051OFRR?=
 =?utf-8?B?dlZjcUxPeUp0cjdGeXpsc0FuRXhoQnVlZ21NWnYycXMxc20vcUczUnhmVzdB?=
 =?utf-8?B?MGhiT20wU1ViU2RkUkpvdzMrS0doQnF1bWc2WGFBeDREUzRJcVBxQ09KbmZY?=
 =?utf-8?B?N3UxMVRPUDlodTZDWVlTUmdiNDZYMUh5K2I3NVllY1pHY1Iwa3RxSEwraUxP?=
 =?utf-8?B?N0VLSFJyWHh3UmNxUmxraHdwVXdOVVQ5YkQ3cHlZN1hWVzBUd0kvQ2g3QS9D?=
 =?utf-8?B?blVYN3FReUZFNFZJMTlCNEpvS20xTlZzTVREWnNxTldjMkxOYUlXNWFvOXl0?=
 =?utf-8?B?VFEyQUkvRVJtNGJWWGhqb1hnSWhRUW1QOXAzalkrUWt1YUhEcHphQVVTRkZl?=
 =?utf-8?B?d0Y1eDJCOEZEWWN0VUhzK01MMWR1Z05pN0RSbnlFcjlOdFlpeDhQN2ZoYkFH?=
 =?utf-8?B?eGlsWVJseE9BU2M3UnJmdDRCZkpqcU9aWnNhbEtTMVR0OGFtT2FGTlp2YnBO?=
 =?utf-8?B?RmZyWUJJTENqT0o1M1diMkZsREtUcEdVbE9WblZGc01qU0x1MzdZcUVRMmFO?=
 =?utf-8?B?NnhUNnFad1kzZUVybmJlVFBBc1ljdEErMVc4QVlPWE92bXgrSVlmd0pqYVd5?=
 =?utf-8?B?RytCYnN2ZDhyYzlOL0F6RjFMQkRGTWpvdWhDMnVvYlBCNTVLQkFrRzFScy92?=
 =?utf-8?B?eEpSNWVpa21xK1E4QnFZVlB3andET2Z0R29Zc3lSUVpNMlJHWWMxWCtkQ0pP?=
 =?utf-8?B?UFN0a2dEQlYrYkZhOC9jTnpKVUwyOUJQd2hVbU9JRzJJWVFtaWFFZ3lZWUNZ?=
 =?utf-8?Q?ohftYh?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bllBUk04c2RLQzFxclFIWjkxOGwrTVl6MzFZYlE1Nkp3U04zaUcwYTJiazA2?=
 =?utf-8?B?TjR2WW5wUVVaOFdkbXF1WTltbXBKdHpzSENVU3p5cHU5RXN3VlJQUUFJcHk4?=
 =?utf-8?B?Q2VZNHN2YlIwRnF5aGFGOGRKSVkwSjlJODVXU0tXUFFoSFhKVXZVQURSQ3hH?=
 =?utf-8?B?bUNrV1EreUxYOTI5MVM1c3ZWK2VVN1RYTVhkSTZxbzVQc1lnNmN3MFI4bFM5?=
 =?utf-8?B?M0VLa3dzWHVQYjEwS0xPS1QvMndJdjU0QVo2MzNBTldoNnBIMExhSG5KUXpK?=
 =?utf-8?B?cVhvbUZaZ0dJU1FiQTB0Q1BFUzFvenJCVHpIOVNIRTVPZk9QbmVIUVlXb1d5?=
 =?utf-8?B?azdZdDZvczYzWlgyYml0Y3BHcnk0WFZFckNocTZwYU1WSngreFVkZ0xhZzN3?=
 =?utf-8?B?YW94ZkJKV0ZoS3VSZXlha2VlaUtFWXg1U2ZMTlZMM1JXV2c2YWErS3VLbys2?=
 =?utf-8?B?emhhUzdzcmJwQ3R3Nit2dklNMlFkQ3VyN2J2ZGd1QUlMTlI5VisvN3RQME9O?=
 =?utf-8?B?UXlrVStMTzVNTGFCMi90OS8vSkU3Um8wUWdDOTB5Wmpod3RCaGNIZGlhUlJt?=
 =?utf-8?B?NFZxcEliV01vR2JCdVhUZ2syZWUxZnV0RE4wMnVaVFd5RFpVVnBEOTNJSGdB?=
 =?utf-8?B?THBaeTFiN3NpRlhsVERwWjB5WWlNb05xQmdUU0hFNW1aQTV1RzJaSkoybXBy?=
 =?utf-8?B?cFByYTJzTXNqazZzd1BCdEdDMkNRM0xOYVBRMmNOd2NzYUxtTVNtQm50S3lr?=
 =?utf-8?B?NWlLVEw2aWR0WUhFRFZ0U0VRaERrakJiamlidUxyOENPd29LSklqM3FwZUFm?=
 =?utf-8?B?Q0prVExIR3NnanNKZlIxSThGWEpMNVFockpXMSt6RnN5R2JqTVgzb2tVNzZS?=
 =?utf-8?B?UVZXNFlxVDJEcHFMemJaUWZNVzJmYmF4OGpTdnB3dmZlZGdsRzhVUVBmV1lm?=
 =?utf-8?B?cXlBUFNkYXV0WHUzYU9GMXBROFVKSE1DUkM4T0dIbG9LNitVUVllOGNyWUsr?=
 =?utf-8?B?RXE4d1lXMEduc1FGRXZ4Tm1VTWJJbitHSlQyOUZoOVhWZmhxTit0cEhHS3pi?=
 =?utf-8?B?SmlERGc5WUZvRXN0M2VqZ0txQkxJTlhnTGs4T29DZURTWkpEb0FjdENScHll?=
 =?utf-8?B?Y3lyVGprNFlTRm5DbzByWE1JRWJXQjdOeWFvd0h5V3o1UmFDeGxYY2F0cUQ5?=
 =?utf-8?B?THZDWEt6OW5GcXpUUXcvZFVETXZJVS9UekFFOFA4L1JFeWM5NjEvVHNjMlBz?=
 =?utf-8?B?R2h4b2xQYUxMMDh3cTRqd0NRUDRMcmxlRkhkUVdMSFVWa3VGYmFuZzUrK3Aw?=
 =?utf-8?B?YnpqK0ovZjRneTFQSmVMR3plTE53UXBLQzlNTHE5TUtoOXZUMUZvdEJKU2pj?=
 =?utf-8?B?bXlhRnVCcU53U0pkOW1CWG1kajNrdHlNRDBXd080bEFQME1OdXFXdHZXTk4w?=
 =?utf-8?B?eGlLUWV2Q210RUpySkJqSko3NEFXWks3UjJ5U0NmYk12U3hvWVNIUEVaenRI?=
 =?utf-8?B?WnhCVlVFREVmbE1scWpxYldOOEJHeUhVVHBUMUZvWEcxNjhuK1ErWERxenN5?=
 =?utf-8?B?YVVtL2dXdUFDY0dUekVDSmYyWVFIRGxsTUR6bE02Q1lsY0xXaWpTZWRoL3JQ?=
 =?utf-8?B?LytSOVJKcHVxQ3N2RlphOWk2aVNkVGpEc1lVaWoxbjZaV05WTHpCVjJ3aE4x?=
 =?utf-8?B?Y2tjNk1HV0NjR0RMTS9ZMkQ1N3B1TTVDeHRjMHhTNjBXOEpjZDhsUnBQcGt2?=
 =?utf-8?B?bi95bkFyVGprdGJWYldML3VhM2N3eTdqOXhhK2FwQ3kycTY4OGUzT29KWC9G?=
 =?utf-8?B?RkhGa0NldzlMb2RjUnh6cWZxdHBrdzNHMll2Mm1KM3hPY1hFTEFnSU4zckZ1?=
 =?utf-8?B?aEZkRzA1bEc5VURvcWxvUXNYS2tnaXBKWUp6U0JHWHAwU2lKL1VrMlJrUkhN?=
 =?utf-8?B?cDg1dld2N3hnTlNNTDZRcnNxeWJ4U1lMSVBPaEJKd1U2RjhETkIxWnUya1ZU?=
 =?utf-8?B?MEtUQ1UzRkZnZ2d2WE0yL2ZqUnd5QmxMQ0sxbzVBVlVWL3JNUWszelR3Zjly?=
 =?utf-8?B?akNpcEZVbksrTStoQ2pLM0wvMXRWK0ZrdzNpQU1oMUk0amgvMklkVTFncFBK?=
 =?utf-8?B?TWtCMnhzVnBYSThVVEpOaXdiK1ZUOUpqUGdacy82cTc3dmZ4N0tzU0h5SGNP?=
 =?utf-8?Q?TuEg2jLsylf99E32XYjfygM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <66E501078353E24982AFCA23E375BCA7@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6fa6ef-20a9-402e-52ec-08de2d42b039
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2025 23:22:38.0618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ujn/JXB1UlQq2S2iWkDC1vrToktJEZUFU/lN2Bm8YOu9ioFpfkXMg/lOaJK6OWnv4t7LQvk+ThyG9rbdiKdSXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB5090
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAyMSBTYWx0ZWRfX2WrRv/iD+gbx
 EBrDP1vFdLgiF4z0oIUA+JJWbD0iRaGbH1gezWnTUknXhT8DL/Bq5RDUplyufLui0WN49bl/qNx
 QjAgJHH0yP7gEJT4vt1bvMZsGYFV5sm8K1NSMkQb0W3UoU/LTSkUWzdoAgHdRcPqb0VtmGbEL2J
 +qSYu52M2lcjgIytiRaiM7lEkiA1qq0RtaJJiGiqx25SsKjSsdnTdulhkwOQgynURXvRXjMMRo6
 hKRS0afrUYmO4ytUF0yp25/Kznc1U9+LICQwXGzb1p7TaEHJPT7jrhVWwC/YTDZj+C0+87kujw4
 0vsktS+8k45+FZuHO9NSfuUCXUdQyrDAIth/wvwR42hXYH2GNOuDYsakIzXKEJmvad9+uJqFIQz
 n1Z7pvKeNYFDr1mOzYu6UblSn++58A==
X-Authority-Analysis: v=2.4 cv=PLoCOPqC c=1 sm=1 tr=0 ts=69278bc0 cx=c_pps
 a=8jXpZF9zWVkTg+MA9bOgkg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=SWuGT33woY9ZtE2nFZoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 232TVnc_uIIZoWulRWD_7mj_fJ77qATE
X-Proofpoint-GUID: c52hzszB9KPsmAF8S15saToPzsrIQJQJ
Subject: Re:  [REGRESSION] CephFS kernel client crash (NULL deref in strcmp)
 since Linux 6.17.8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511220021

T24gVGh1LCAyMDI1LTExLTI3IGF0IDAyOjEyICswMzAwLCDQo9C+0LvRgtC10YAg0J4n0JTQuNC8
IHdyb3RlOg0KPiANCj4gU3ViamVjdDogW1JFR1JFU1NJT05dIENlcGhGUyBrZXJuZWwgY2xpZW50
IGNyYXNoIChOVUxMIGRlcmVmIGluIHN0cmNtcCkgc2luY2UgTGludXggNi4xNy44DQo+IFRvOiBj
ZXBoLWRldmVsQHZnZXIua2VybmVsLm9yZw0KPiBDYzogbGludXgtZnNkZXZlbEB2Z2VyLmtlcm5l
bC5vcmcNCj4gDQo+IEhpLA0KPiANCj4gSSB3b3VsZCBsaWtlIHRvIHJlcG9ydCBhIHJlZ3Jlc3Np
b24gaW4gdGhlIGluLWtlcm5lbCBDZXBoRlMgY2xpZW50IHdoaWNoIGFwcGVhcmVkIGJldHdlZW4g
TGludXggNi4xNy43IGFuZCA2LjE3LjguIFRoZSBpc3N1ZSBpcyBmdWxseSByZXByb2R1Y2libGUg
b24gbXkgaGFyZHdhcmUgYW5kIGNvbXBsZXRlbHkgcHJldmVudHMgYWNjZXNzaW5nIENlcGhGUy4N
Cj4gDQo+IFRoZSBzYW1lIENlcGhGUyBjbHVzdGVyIHdvcmtzIGZpbmUgZnJvbSBVYnVudHUgYW5k
IERlYmlhbiBrZXJuZWwgY2xpZW50cywgc28gdGhpcyBhcHBlYXJzIHRvIGJlIGEga2VybmVsLXNp
ZGUgcmVncmVzc2lvbiBpbiB0aGUgQ2VwaEZTIGNsaWVudCBjb2RlcGF0aC4NCj4gDQo+ID09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiBTdW1t
YXJ5DQo+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PQ0KPiANCj4gU3RhcnRpbmcgd2l0aCBMaW51eCA2LjE3LjgsIHJ1bm5pbmcgImxzIC9tbnQv
Y2VwaGZzIiB0cmlnZ2VycyBhbiBpbW1lZGlhdGUga2VybmVsIGNyYXNoIChOVUxMIHBvaW50ZXIg
ZGVyZWZlcmVuY2UgaW4gc3RyY21wKSwgaW5zaWRlOg0KPiANCj4gwqAgY2VwaF9tZHNfY2hlY2tf
YWNjZXNzKCkNCj4gwqAgY2VwaF9vcGVuKCkNCj4gDQo+IENlcGhGUyBiZWNvbWVzIHVudXNhYmxl
OiBhbnkgYXR0ZW1wdCB0byBvcGVuIGZpbGVzIG9yIGRpcmVjdG9yaWVzIG9uIHRoZSBtb3VudCBr
aWxscyB0aGUgY2FsbGluZyBwcm9jZXNzLg0KPiANCj4gUm9sbGluZyBiYWNrIHRvIDYuMTcuNyBm
aXhlcyB0aGUgaXNzdWUuDQo+IA0KPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0NCj4gRW52aXJvbm1lbnQNCj4gPT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+IA0KPiBEaXN0cm86IEFyY2gg
TGludXggKHJvbGxpbmcpDQo+IEtlcm5lbCAoYmFkKTogNi4xNy44LmFyY2gxLTENCj4gS2VybmVs
IChnb29kKTogNi4xNy43LmFyY2gxLTENCj4gQXJjaGl0ZWN0dXJlOiB4ODZfNjQNCj4gDQo+IEhh
cmR3YXJlOg0KPiDCoCBEZWxsIExhdGl0dWRlIDc0OTANCj4gwqAgQklPUyAxLjM5LjAgKDIwMjQt
MDctMDQpDQo+IA0KPiBDZXBoIG1vZHVsZXM6DQo+IMKgIGNlcGgua28gwqAgwqAgc3JjdmVyc2lv
biA4QTkwREE3QkQ3MTE1OTkzQjdEOTFDNQ0KPiDCoCBsaWJjZXBoLmtvIMKgc3JjdmVyc2lvbiA0
NTFDRThBOTJGRUE3NjI1NDE5NDYyQw0KPiANCj4gQ2VwaEZTIG1vdW50Og0KPiDCoCAxNzIuMjcu
MC43MTo2Nzg5LDE3Mi4yNy4xLjUxOjY3ODksMTcyLjI3LjUuMjU6Njc4OTovIC9tbnQvY2VwaGZz
DQo+IMKgIMKgIC10IGNlcGgNCj4gwqAgwqAgLW8gbmFtZT1jZXBoZnMsc2VjcmV0PS4uLixub2F0
aW1lLF9uZXRkZXYseC1zeXN0ZW1kLmF1dG9tb3VudA0KPiANCj4gPT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+IFJlZ3Jlc3Npb24gd2luZG93
DQo+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQ0KPiANCj4gTGFzdCBrbm93biBnb29kOiA2LjE3LjcNCj4gRmlyc3QgYmFkOiDCoCDCoCDCoCA2
LjE3LjgNCj4gQWxzbyBiYWQ6IMKgIMKgIMKgIMKgNi4xNy45DQo+IEFsc28gYWZmZWN0ZWQ6IMKg
IGxpbnV4LWx0cyA2LjEyLnggKHNhbWUgY3Jhc2ggb24gdGhpcyBtYWNoaW5lKQ0KPiANCj4gPT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+IFJl
cHJvZHVjZXINCj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09DQo+IA0KPiAxLiBCb290IGtlcm5lbCA2LjE3Ljggb3IgbmV3ZXIuDQo+IDIuIE1v
dW50IENlcGhGUy4NCj4gMy4gUnVuOiBscyAvbW50L2NlcGhmcw0KPiA0LiBLZXJuZWwgaW1tZWRp
YXRlbHkgQlVHcyB3aXRoIGEgTlVMTCBkZXJlZmVyZW5jZSBhbmQga2lsbHMgdGhlIHByb2Nlc3Mu
DQo+IA0KPiBUaGlzIGlzIDEwMCUgcmVwcm9kdWNpYmxlLg0KPiANCj4gPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+IENyYXNoIGV4Y2VycHQg
KGZ1bGwgZG1lc2cgYXR0YWNoZWQpDQo+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PQ0KPiANCj4gQlVHOiBrZXJuZWwgTlVMTCBwb2ludGVyIGRl
cmVmZXJlbmNlLCBhZGRyZXNzOiAwMDAwMDAwMDAwMDAwMDAwDQo+ICNQRjogc3VwZXJ2aXNvciBy
ZWFkIGFjY2VzcyBpbiBrZXJuZWwgbW9kZQ0KPiBPb3BzOiAwMDAwIFsjMV0gU01QIFBUSQ0KPiBD
UFU6IDEgUElEOiA1MzY1IENvbW06IGxzDQo+IA0KPiBSSVA6IDAwMTA6c3RyY21wKzB4MmMvMHg1
MA0KPiBSQVg6IDAwMDAwMDAwMDAwMDAwMDANCj4gUlNJOiAwMDAwMDAwMDAwMDAwMDAwDQo+IFJE
STogZmZmZjhhMTZkNmRhODdjOA0KPiANCj4gQ2FsbCBUcmFjZToNCj4gwqAgY2VwaF9tZHNfY2hl
Y2tfYWNjZXNzKzB4MTAzLzB4ODQwIFtjZXBoXQ0KPiDCoCBfX3RvdWNoX2NhcCsweDMwLzB4MTgw
IFtjZXBoXQ0KPiDCoCBjZXBoX29wZW4rMHgxN2EvMHg2MjAgW2NlcGhdDQo+IMKgIGRvX2RlbnRy
eV9vcGVuKzB4MjNkLzB4NDgwDQo+IMKgIHZmc19vcGVuDQo+IMKgIHBhdGhfb3BlbmF0DQo+IMKg
IGRvX2ZpbHBfb3Blbg0KPiDCoCBkb19zeXNfb3BlbmF0Mg0KPiDCoCBfX3g2NF9zeXNfb3BlbmF0
DQo+IMKgIGRvX3N5c2NhbGxfNjQNCj4gwqAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1l
DQo+IA0KPiBTZWNvbmQgbHMgcnVuIHByb2R1Y2VzIGFuIGlkZW50aWNhbCBjcmFzaC4NCj4gDQo+
ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0K
PiBOb3Rlcw0KPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT0NCj4gDQo+ICogVGhlIGlzc3VlIG9jY3VycyBiZWZvcmUgYW55IHVzZXIgb3BlcmF0
aW9ucy4NCj4gKiBUaGUgQ2VwaEZTIGNsdXN0ZXIgaXMgdW5jaGFuZ2VkIGJldHdlZW4gdGVzdHMu
DQo+ICogT3RoZXIgTGludXggY2xpZW50cyAoVWJ1bnR1LCBEZWJpYW4ga2VybmVscykgd29yayBm
aW5lLg0KPiAqIEkgY2FuIHRlc3QgcGF0Y2hlcyBvciBoZWxwIGJpc2VjdC4NCj4gDQo+IEZ1bGwg
bG9ncyBhcmUgYXR0YWNoZWQuDQo+IA0KPiANClRoYW5rcyBmb3IgdGhlIHJlcG9ydC4gSSBiZWxp
ZXZlIHdlIGFyZSB0YWxraW5nIGFib3V0IHRoZSBzYW1lIGlzc3VlLiBQbGVhc2UsDQpjaGVjayB0
aGlzIHBhdGNoIFsxXSBhcyBjdXJyZW50IHdvcmthcm91bmQuDQoNClRoYW5rcywNClNsYXZhLg0K
DQpbMV0NCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2NlcGgtZGV2ZWwvOTUzNGU1ODA2MWM3ODMy
ODI2YmJkMzUwMGI5ZGE5NDc5ZThhODI0NC5jYW1lbEBpYm0uY29tL1QvI3QNCg==

