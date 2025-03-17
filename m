Return-Path: <linux-fsdevel+bounces-44220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7B4A65EA9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 21:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 603411736CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 20:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026051EB5FB;
	Mon, 17 Mar 2025 20:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dw8kzO6c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7338E1EB36;
	Mon, 17 Mar 2025 20:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742241817; cv=fail; b=ZtwaYTs8BR4C8/u7SwlxoFTqVPj/CpsRaANUKL1+qbbzW+pdLo4xQrEOp8JufZOps+C+fu1I6cxpMtGqrlD4hf3VjPnx/Vo69ujqTvIpsxgDjHJujI8/5i8PUyX+HNavoG0vSta0cBjY8Dx1BWSiEzQgPcLQbmg7nXPjpbWOL60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742241817; c=relaxed/simple;
	bh=HQnxstv3lDpMHqPlqLG4pxnIXHgohVE4qBsFAyayt9c=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=kVmrZRhJdyKDlOdpD9Roxj18MuSCC9fF9AWVrLAs92zfP6M+KU6C2X+j33ZAyFXJXo+1H7yFLGb+C4PS2xQgiQRbSt0AoTl6dge4pWsvHFwyciRU9EdVY5ExiZYaSjNJZ+mm/DND/YpTJiOZKFvVfW+hUoxaXhRWitR9DFAoLnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dw8kzO6c; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52HDa66Z011475;
	Mon, 17 Mar 2025 20:03:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=HQnxstv3lDpMHqPlqLG4pxnIXHgohVE4qBsFAyayt9c=; b=dw8kzO6c
	anwJs6LTx4GCqCa+jZfJN/tfvb6HEPHx1a3t/T0fDNSfG/nltu5m0RCIJw6EsG8E
	8ms+GJkTxsxiYXLgZczMNsJjdByBEIKNYC2nUqvjpRsyl5hpw10lCVpaVUeUTXYc
	0ZawFVSvmt4t15PXn6tR6I+aQtYx1NjY1uwFo/QEBf2loy9UMMmQifYbXsLMl/fv
	ZsKZESqShl4Um2wEsEvZUwJVf4vpQpUCtRi7lfCw3pfO8doYb/g7cCgAvJyGKF3i
	NOABXp+0kMCSK4l7gYdGxC6yrP0EJTEnGsfPNokveTNAA1K7fJB60frkzo6APd7g
	C2KtwwKPaVKCUg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45e6255hdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 20:03:23 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52HK3Nw1009061;
	Mon, 17 Mar 2025 20:03:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45e6255hd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 20:03:23 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d/pYu1XPBKjbIl5HeSDxPQ06fIs2rn70drqNVdvdtysz0vmIbEBRwe5NiNatPCXMCCYZxsqCf8Bj2l31urQAHlyg2F2K+QHf2xVE6ntQr76q00ZXADUEg2bRurS43leq097+AfsADmtyj86n+qx1Sh+96fPnww/fdCUMM/LA7NE+kl7FOLbaK58ZI0QeKFFXvbX1WyewqtnzQVa6RY+gzXrxwTeoMhCZUNStJmGCPObLv2DfiLF1afEsUH0flbiN0cd7CHTWsUdW8+JxnSDClR8okqm8ciho2dV2J+Qb2l5S5x4QawrFR6Y9zOf36Z/2U2IWMMr7quaxMUEKxdyz5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQnxstv3lDpMHqPlqLG4pxnIXHgohVE4qBsFAyayt9c=;
 b=nOzr7qLCkgTicQ2sdvcCoh84nv6oDpZkoOydOufRWA+WoQKcV6xM3oMhmtl/YkRkv3JP4HiqKZXBhG+0gIv6554FQRy03BWnbUrsYPMSeNyfaWewpiv7Myr0gjVJuLg/Tdoyyz35cD80oirmThU7zDCOq3OfRKYrHJzXj5tB2/RGbT7NiDDbXh6vTp35cDVHI94LHmM9Dz9AqnxVDYKBPYFHwK4j60D3MupxgLsgMGk6h0J9xYoj1vrREjyR8619Hyvj+0HtKxzieoT7v4/r+n8h/kqKaF9Ps7pbK4T9jViYY5VBI4G1Z0PJ5NNMFKoNAge/8pn13dHOIKC5PFwNuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SJ0PR15MB4647.namprd15.prod.outlook.com (2603:10b6:a03:37c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 20:03:19 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 20:03:19 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: Alex Markuze <amarkuze@redhat.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        David Howells <dhowells@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "jlayton@kernel.org"
	<jlayton@kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "dongsheng.yang@easystack.cn"
	<dongsheng.yang@easystack.cn>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [RFC PATCH 11/35] ceph: Use ceph_databuf in DIO
Thread-Index: AQHblHDp8p1COODJyUyC1UofPIjSz7N3xl4A
Date: Mon, 17 Mar 2025 20:03:19 +0000
Message-ID: <90a695663117ec2822c7384af3943c9d4edcc802.camel@ibm.com>
References: <20250313233341.1675324-1-dhowells@redhat.com>
	 <20250313233341.1675324-12-dhowells@redhat.com>
In-Reply-To: <20250313233341.1675324-12-dhowells@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SJ0PR15MB4647:EE_
x-ms-office365-filtering-correlation-id: f76030f4-4888-4755-7c63-08dd658ec337
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?L1pDMldEenh4WmNjSUFMZ0cxS20xUU8wS3BIajk1RU5TNGwzWWFzUy9BeTBw?=
 =?utf-8?B?ZFo5Yy9ndlIvMmJqVXBQcXdISmtBUGRlTXRldnV0MDVxeVZDN1F1R0tPR3Nx?=
 =?utf-8?B?YnluMEVsODlzZUZMVk91K2IrQkdYbXJ3QlBydVdiY1BKb1g1QzBMOTAxNC9C?=
 =?utf-8?B?NEpBQzdlL0VLaWpBOHR4UWdweUIwMVhaM21rS2FBWk9GbjVsbXN3b2luQ1J5?=
 =?utf-8?B?WVhyRklQYUpNN2Y4NThpY2RxOEQwVGRrZVREYVZhN0lEdW05b0dOTG9DelJ5?=
 =?utf-8?B?RldPTCs1dkw4Y3lJZUZua1NQeVcvK1NUVUlic1dZenk5N285bm5FS3ZqdUY1?=
 =?utf-8?B?UW5QSkdlMVEwN2lCd0dLbC92T1R3TzFCdkkwT2pFYmpQbHVZY256Yy9WRElt?=
 =?utf-8?B?OTJlL1ZzTVprQ0k5RENDMW1SVVR4QjQ3RGhlTWFFN3J4NDNTUWViMS9iRXhV?=
 =?utf-8?B?dlcvTVFucmFHREsrZ2wwRW1BeGRSRW9IQ0NwdlRKdWY0V2M4Q1BuQlh5RzlG?=
 =?utf-8?B?VU1UT21qeWdWc2c2eThIcXRzTC8xT0ZRS2FzbkZ0Wkh3b1RQQUFuTWlvb1p5?=
 =?utf-8?B?OFhYZkRUSW05TWlBVlNzb3lmRmo2UEZJR3h4ZHYzMlBIUk1PSWhQMmtDRGFo?=
 =?utf-8?B?VHNrb3hESis3K1lmWjZjaXhwR1BqZ1RSNWxGQUcydXNjb1hyZDRyUjl1WEsx?=
 =?utf-8?B?R1ZYODlCSkZyaThjZWJHMjJVVHArM0lYeVhYMXdhc29FeXp0R0FCT2QraGla?=
 =?utf-8?B?ZHdYNllZZks0VENDZGR0My95R0xmZytSRTd2eWJCVzhpam5QRWlFd2pOdkQx?=
 =?utf-8?B?TkFLbW1KT1hPV0JiMVhrU1IwaXlGeThNOFVTb1JwQjFRS1BEcnJjcGhLOThU?=
 =?utf-8?B?cDJiWEJndy9YbnBIa2tyQWk4TEsvb0VJT0dqS0RlZ2lpSytyUmFML25OSTJ6?=
 =?utf-8?B?eUpSVWFMOFB2T0xyUDEwaVNTMk5UWERycGNReDN6RWg1dmMyL21nWHN4cjU0?=
 =?utf-8?B?bDIyNkVOZ2pPNVRJODhEYjI4ZzBvQ0ZTaVRLZ1N6ZVVTN1pKU1dnUm9MVnln?=
 =?utf-8?B?eGtXOWtmb1lmMU1Kb0xrdFlRdE5udmZBeVdtcUZycStWMGxmYWlWWjlRd2V1?=
 =?utf-8?B?dFBCYmlmMk1NcW1namVNeDZaMnF1Qk9kN211TENlalI0RmJMcmtMbENzbEVF?=
 =?utf-8?B?UlBCRi94eWxnZGNIbFRRb1ltVmVuWDM3U1hXZlNlZEthcDdWK2JBbGU0MUJp?=
 =?utf-8?B?M3lSU2lvSERWR0Q2ejUrMWJJNHlvWmtXOEVvQ2wzalFwdmRoaCt1ZU5yRDJQ?=
 =?utf-8?B?aXpVZE9qdU5zVkpDc2U4TUUyUldKcHZ0Z0dycHl1dFpWaElzZG9qajR6RXBE?=
 =?utf-8?B?ZWF0QWZxUTc0bVlwb0JqSXUxbGZmeW9ZbXRRRm9MbE9Pbm54UWgrQlpUaGha?=
 =?utf-8?B?UVZ0dkxYR0NkalNsWWRqL3pneDRtM29VZ1hvaGlBWDJDRzhGVm5qM2kyRnhE?=
 =?utf-8?B?alhCamREa0s2UGNGNVZ1R1k3ekVYaEM2NEZWaVZ3NXNYNDRldUVJSU8zcWwv?=
 =?utf-8?B?QVlyMEFzVVN6WnExa1BjeC9zR3VSV3dkL1JadEFYTngxNktSUTh4MDk0Mi9x?=
 =?utf-8?B?blROeFFKSGZ5NFBJK04zZDdrYnplTHhhQWcvU24vSDB2MW1teEhyVWdvK3l6?=
 =?utf-8?B?bnhaK0doQVNXY2VHc1hTVzdQcDFIUlRHb2NkNnZ5L2ZyRVRPVXh5RG15NitI?=
 =?utf-8?B?N0V4WnUrR242VTFXb3d4TXRYOW85dHhGbFZTckExMkI3eE5GbHMvNzR0dDJS?=
 =?utf-8?B?WVRjazlVeXZadENxL2V1Ui9VY1JCRTY3eXkyYXFwVXM1QVY0SG9RZTBMRlVu?=
 =?utf-8?B?ZDFURjd5azN5N2tEQjgzVUFMeldndHJGYzdTK3BkTjlnRE5hbFp6WGFoWHVk?=
 =?utf-8?Q?kavL0s5Vx13S5jm+RwYdckGckyQ82KNJ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NWs0bVgyU2taVmVPRW1xUTd6SnYvd2ZLOEY4MEFjc3NrQXRaYXVOL0lQVEsv?=
 =?utf-8?B?SUcvbXY0MXlyVDFFZGwxc1oyQTF4SWp1b2pKUjZIeFN4UVZXRTlLWi8zYWtC?=
 =?utf-8?B?Z2k0V1g3V0w5MzkwVVB0K2dETm10R2JveEIza1cvQlN4M2Z4Z0hzOHVQS01D?=
 =?utf-8?B?bXRFUHUrL3pPVWdOVmRibnc0R0NqY1doRXlqNnlDeENKUTFWdXNVSUg4eWlH?=
 =?utf-8?B?WGdoamdHMnFMaTUyN2Y4OEgxUWlBb0dCRW5zRjF6VFlHWXQ1NGtRZEZQYkZ3?=
 =?utf-8?B?b0Y3QmF5aGdseUUvNWlwSTVJTlBhd2JWYjhBdWxYU3Era1ZBQnJpNURwZENw?=
 =?utf-8?B?WG8zcTBCamJxWHIyVW5LMnEyVGVBelpHd2NFcDUzelBLM1NQRS9qbE1NRXA3?=
 =?utf-8?B?R1ZuSjlHZkRTcm5FejdaYTk2alRMTTBOY0xmM2k5dlBDbm8wY1c3YUR0eFlN?=
 =?utf-8?B?bmFlcWJvcjE0emVVZWg0R0IxZ0g5R0tTWktIVlc5OEpqYTFSbjgyK1FZMGdM?=
 =?utf-8?B?ZTdVRVNKY1FUU1ZuVytnWk4zcVFFbDNhS3BlSXpYbnlsRko1cG40YkxlZm5G?=
 =?utf-8?B?K3dic0YxbVdyY2VEQjBTSHBMYTJUSnlRR1BldnEzRWc0Yjl1a1pteXpBRXlQ?=
 =?utf-8?B?c3cxa3pOMEdsaUlZcTNTNEdKTUo4emRIc09LTG1jYnR6ZGhjS1pISTJmbjU0?=
 =?utf-8?B?dUVKajMzM0hqZzV6TzBHVGh3NFZRd1lMK3JwUVNscW1GNjV1QXAxZUgzZXVH?=
 =?utf-8?B?cjNYQXhZMTRPaXliNnFEdlp3Y283QTJ6ZGVxdXRtTEoyZ2s4ZDRhVUdmNFcz?=
 =?utf-8?B?aXQzaHZUd2pGcXNtY2J0T3FDcVA0SWdwd2JiSk0xS3hIcGY2R0x2U3VVdXEr?=
 =?utf-8?B?RGtTTkZCeDVYTmFmZWRhRktmOFppQ3ZuNmNMUUUvNmcrYUhsUGFEV0ROOWx0?=
 =?utf-8?B?V3c0bE5SZXJYWHpqbi9idUdxLzlLdlBQT1FVUU1sa3FvcDBrZ21TSldseklj?=
 =?utf-8?B?U1J1V0dQTk5zbWxHdFFkbVZiZ0crT0xKWU5YOHQ4d3lkYnJYaEtVSUEwTmxw?=
 =?utf-8?B?Tjk1SWpHWWdMWFFVYlR2ZVlNYnkxRnZ6Y0VWNHJPTWIwNENWY0o1SWtNYXA1?=
 =?utf-8?B?eHpzM05PWkNWVDJ6aE5heXN0VXNFL0x3UjhBQ3oyNUkzTEtDUWU5MnVxeTU0?=
 =?utf-8?B?MmFrNXBGV0NTWEt0VWlSdEdiZHpBMFhhOU1YaG5OL0xHMmw0REpFd2FYckFB?=
 =?utf-8?B?ajBOQ1BQSWw1NU1lNS83NkpCL3FtN1VtYUZFK2RMcDY0bVhKWkcxVDJodnBY?=
 =?utf-8?B?N0lFTFFpTXhtS3NUb0NFUzdLaVlGWXF5QzlXM3FWYTZBUU5sUVFFUnFhd21V?=
 =?utf-8?B?cnNESEltNWdpUHpHc3JvQUxxZXA5N1N2RmtCc0REMGJWeThpOWNsZE9wak1J?=
 =?utf-8?B?U0lmTkZkR3p2UE1EalBaZGxLMTFmYi9VUGNwM2RkcjAzTDdpeHVLWkt6RGV6?=
 =?utf-8?B?dWJEckF1bUQ1MDgwSWFlOHdLc3IwYnpvOHV3UG9Wajg3S05SSUlCQmNJSUxJ?=
 =?utf-8?B?U1hteGhEVzAyRmNmN3k3UERUbm9qcnhpK1RQeERsb3pXalAxYVJHZzBXWGZy?=
 =?utf-8?B?eDBpWWozemVwNThWY0prVHA4REkzWVpJRWZTbGZwTkoyMkRYenpHZDNOeHh0?=
 =?utf-8?B?M2ZMYkI4SSt0NmoyaEhmOGxLNThLa2Rlb2pRQkFnYkQ4UVJzSEdVRmwvYVVL?=
 =?utf-8?B?LzNqd0tXeUVrOE1TSWQ1WmJKQ2lGdlNUUUJOQ05XNnRoMDluWHlFQzZlWUc0?=
 =?utf-8?B?N1pqOW1DdkJoaVV1QVZKc05PMy9jRDl1RGltNjhJRWVldGJ6M0QxUm16OGNt?=
 =?utf-8?B?MlpWYWxKTFFwU2FHSkJYNnloeXJ1VVlBQmV1MFF0RlhJbmRSV1ZDaEl4S2g0?=
 =?utf-8?B?SXlEa3M1TjdEN3NmR0pmbkMzQVJvRC8vVStPV0hGd0xEMGFqQUZldm1MUzcv?=
 =?utf-8?B?ZGh0akRwSnkyQmZYNDJTZGtrN2JxQWxWeXorMEgxaWkzOS82N2hVYUQ0K2Er?=
 =?utf-8?B?YTh1V2lHckoyYmxZWHFrdnZLbVJBYlc3R0hrbm4rV2wxMDZJTTZrdHB2UVpo?=
 =?utf-8?B?V2Q5eW9UN1l5QjQ0MzJnZGtXTHp3ajFJajM1czhwZFlJNXQ3dnZIb3VaTkNX?=
 =?utf-8?B?Y0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0CE88B47C53AD145BE193E0DF165BC4B@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f76030f4-4888-4755-7c63-08dd658ec337
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 20:03:19.0941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0tMTH2pU2JSSmdQTZM76mMLdC6L+W7CkNSL1ZN6PB3+I5Kl4wq2pX2rRbl/QWMOJ3AN6K5xWKPAojGg3z8+3Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4647
X-Proofpoint-GUID: pKtNReLtc_37VBKYb7QnZ6Wfab45oNWX
X-Proofpoint-ORIG-GUID: naVfMF8iZ7Qi6HYDYo7F1ANNyvbReawd
Subject: Re:  [RFC PATCH 11/35] ceph: Use ceph_databuf in DIO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_08,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503170144

T24gVGh1LCAyMDI1LTAzLTEzIGF0IDIzOjMzICswMDAwLCBEYXZpZCBIb3dlbGxzIHdyb3RlOg0K
PiBTdGFzaCB0aGUgbGlzdCBvZiBwYWdlcyB0byBiZSByZWFkIGludG8vd3JpdHRlbiBmcm9tIGR1
cmluZyBhIGNlcGggZnMNCj4gZGlyZWN0IHJlYWQvd3JpdGUgaW4gYSBjZXBoX2RhdGFidWYgc3Ry
dWN0IHJhdGhlciB0aGFuIHVzaW5nIGEgYnZlYyBhcnJheS4NCj4gRXZlbnR1YWxseSB0aGlzIHdp
bGwgYmUgcmVwbGFjZWQgd2l0aCBqdXN0IGFuIGl0ZXJhdG9yIHN1cHBsaWVkIGJ5DQo+IG5ldGZz
bGliLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGF2aWQgSG93ZWxscyA8ZGhvd2VsbHNAcmVkaGF0
LmNvbT4NCj4gY2M6IFZpYWNoZXNsYXYgRHViZXlrbyA8c2xhdmFAZHViZXlrby5jb20+DQo+IGNj
OiBBbGV4IE1hcmt1emUgPGFtYXJrdXplQHJlZGhhdC5jb20+DQo+IGNjOiBJbHlhIERyeW9tb3Yg
PGlkcnlvbW92QGdtYWlsLmNvbT4NCj4gY2M6IGNlcGgtZGV2ZWxAdmdlci5rZXJuZWwub3JnDQo+
IGNjOiBsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZw0KPiAtLS0NCj4gIGZzL2NlcGgvZmls
ZS5jIHwgMTEwICsrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0NyBpbnNlcnRpb25zKCspLCA2MyBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9mcy9jZXBoL2ZpbGUuYyBiL2ZzL2NlcGgvZmlsZS5jDQo+IGlu
ZGV4IDlkZTI5NjA3NDhiOS4uZmI0MDI0YmM4Mjc0IDEwMDY0NA0KPiAtLS0gYS9mcy9jZXBoL2Zp
bGUuYw0KPiArKysgYi9mcy9jZXBoL2ZpbGUuYw0KPiBAQCAtODIsMTEgKzgyLDEwIEBAIHN0YXRp
YyBfX2xlMzIgY2VwaF9mbGFnc19zeXMyd2lyZShzdHJ1Y3QgY2VwaF9tZHNfY2xpZW50ICptZHNj
LCB1MzIgZmxhZ3MpDQo+ICAgKi8NCj4gICNkZWZpbmUgSVRFUl9HRVRfQlZFQ1NfUEFHRVMJNjQN
Cj4gIA0KPiAtc3RhdGljIHNzaXplX3QgX19pdGVyX2dldF9idmVjcyhzdHJ1Y3QgaW92X2l0ZXIg
Kml0ZXIsIHNpemVfdCBtYXhzaXplLA0KPiAtCQkJCXN0cnVjdCBiaW9fdmVjICpidmVjcykNCj4g
K3N0YXRpYyBpbnQgX19pdGVyX2dldF9idmVjcyhzdHJ1Y3QgaW92X2l0ZXIgKml0ZXIsIHNpemVf
dCBtYXhzaXplLA0KPiArCQkJICAgIHN0cnVjdCBjZXBoX2RhdGFidWYgKmRidWYpDQo+ICB7DQo+
ICAJc2l6ZV90IHNpemUgPSAwOw0KPiAtCWludCBidmVjX2lkeCA9IDA7DQo+ICANCj4gIAlpZiAo
bWF4c2l6ZSA+IGlvdl9pdGVyX2NvdW50KGl0ZXIpKQ0KPiAgCQltYXhzaXplID0gaW92X2l0ZXJf
Y291bnQoaXRlcik7DQo+IEBAIC05OCwyMiArOTcsMjQgQEAgc3RhdGljIHNzaXplX3QgX19pdGVy
X2dldF9idmVjcyhzdHJ1Y3QgaW92X2l0ZXIgKml0ZXIsIHNpemVfdCBtYXhzaXplLA0KPiAgCQlp
bnQgaWR4ID0gMDsNCj4gIA0KPiAgCQlieXRlcyA9IGlvdl9pdGVyX2dldF9wYWdlczIoaXRlciwg
cGFnZXMsIG1heHNpemUgLSBzaXplLA0KPiAtCQkJCQkgICBJVEVSX0dFVF9CVkVDU19QQUdFUywg
JnN0YXJ0KTsNCj4gLQkJaWYgKGJ5dGVzIDwgMCkNCj4gLQkJCXJldHVybiBzaXplID86IGJ5dGVz
Ow0KPiAtDQo+IC0JCXNpemUgKz0gYnl0ZXM7DQo+ICsJCQkJCSAgICBJVEVSX0dFVF9CVkVDU19Q
QUdFUywgJnN0YXJ0KTsNCj4gKwkJaWYgKGJ5dGVzIDwgMCkgew0KPiArCQkJaWYgKHNpemUgPT0g
MCkNCj4gKwkJCQlyZXR1cm4gYnl0ZXM7DQo+ICsJCQlicmVhazsNCg0KSSBhbSBzbGlnaHRseSBj
b25mdXNlZCBieSAnYnJlYWs7JyBoZXJlLiBEbyB3ZSBoYXZlIGEgbG9vcCBhcm91bmQ/DQoNCj4g
KwkJfQ0KPiAgDQo+IC0JCWZvciAoIDsgYnl0ZXM7IGlkeCsrLCBidmVjX2lkeCsrKSB7DQo+ICsJ
CXdoaWxlIChieXRlcykgew0KPiAgCQkJaW50IGxlbiA9IG1pbl90KGludCwgYnl0ZXMsIFBBR0Vf
U0laRSAtIHN0YXJ0KTsNCj4gIA0KPiAtCQkJYnZlY19zZXRfcGFnZSgmYnZlY3NbYnZlY19pZHhd
LCBwYWdlc1tpZHhdLCBsZW4sIHN0YXJ0KTsNCj4gKwkJCWNlcGhfZGF0YWJ1Zl9hcHBlbmRfcGFn
ZShkYnVmLCBwYWdlc1tpZHgrK10sIHN0YXJ0LCBsZW4pOw0KPiAgCQkJYnl0ZXMgLT0gbGVuOw0K
PiArCQkJc2l6ZSArPSBsZW47DQo+ICAJCQlzdGFydCA9IDA7DQo+ICAJCX0NCj4gIAl9DQo+ICAN
Cj4gLQlyZXR1cm4gc2l6ZTsNCj4gKwlyZXR1cm4gMDsNCg0KRG8gd2UgcmVhbGx5IG5lZWQgdG8g
cmV0dXJuIHplcm8gaGVyZT8gSXQgbG9va3MgdG8gbWUgdGhhdCB3ZSBjYWxjdWxhdGVkIHRoZQ0K
c2l6ZSBmb3IgcmV0dXJuaW5nIGhlcmUuIEFtIEkgd3Jvbmc/DQoNCj4gIH0NCj4gIA0KPiAgLyoN
Cj4gQEAgLTEyNCw1MiArMTI1LDQ0IEBAIHN0YXRpYyBzc2l6ZV90IF9faXRlcl9nZXRfYnZlY3Mo
c3RydWN0IGlvdl9pdGVyICppdGVyLCBzaXplX3QgbWF4c2l6ZSwNCj4gICAqIEF0dGVtcHQgdG8g
Z2V0IHVwIHRvIEBtYXhzaXplIGJ5dGVzIHdvcnRoIG9mIHBhZ2VzIGZyb20gQGl0ZXIuDQo+ICAg
KiBSZXR1cm4gdGhlIG51bWJlciBvZiBieXRlcyBpbiB0aGUgY3JlYXRlZCBiaW9fdmVjIGFycmF5
LCBvciBhbiBlcnJvci4NCj4gICAqLw0KPiAtc3RhdGljIHNzaXplX3QgaXRlcl9nZXRfYnZlY3Nf
YWxsb2Moc3RydWN0IGlvdl9pdGVyICppdGVyLCBzaXplX3QgbWF4c2l6ZSwNCj4gLQkJCQkgICAg
c3RydWN0IGJpb192ZWMgKipidmVjcywgaW50ICpudW1fYnZlY3MpDQo+ICtzdGF0aWMgc3RydWN0
IGNlcGhfZGF0YWJ1ZiAqaXRlcl9nZXRfYnZlY3NfYWxsb2Moc3RydWN0IGlvdl9pdGVyICppdGVy
LA0KPiArCQkJCQkJIHNpemVfdCBtYXhzaXplLCBib29sIHdyaXRlKQ0KPiAgew0KPiAtCXN0cnVj
dCBiaW9fdmVjICpidjsNCj4gKwlzdHJ1Y3QgY2VwaF9kYXRhYnVmICpkYnVmOw0KPiAgCXNpemVf
dCBvcmlnX2NvdW50ID0gaW92X2l0ZXJfY291bnQoaXRlcik7DQo+IC0Jc3NpemVfdCBieXRlczsN
Cj4gLQlpbnQgbnBhZ2VzOw0KPiArCWludCBucGFnZXMsIHJldDsNCj4gIA0KPiAgCWlvdl9pdGVy
X3RydW5jYXRlKGl0ZXIsIG1heHNpemUpOw0KPiAgCW5wYWdlcyA9IGlvdl9pdGVyX25wYWdlcyhp
dGVyLCBJTlRfTUFYKTsNCj4gIAlpb3ZfaXRlcl9yZWV4cGFuZChpdGVyLCBvcmlnX2NvdW50KTsN
Cj4gIA0KPiAtCS8qDQo+IC0JICogX19pdGVyX2dldF9idmVjcygpIG1heSBwb3B1bGF0ZSBvbmx5
IHBhcnQgb2YgdGhlIGFycmF5IC0tIHplcm8gaXQNCj4gLQkgKiBvdXQuDQo+IC0JICovDQo+IC0J
YnYgPSBrdm1hbGxvY19hcnJheShucGFnZXMsIHNpemVvZigqYnYpLCBHRlBfS0VSTkVMIHwgX19H
RlBfWkVSTyk7DQo+IC0JaWYgKCFidikNCj4gLQkJcmV0dXJuIC1FTk9NRU07DQo+ICsJaWYgKHdy
aXRlKQ0KPiArCQlkYnVmID0gY2VwaF9kYXRhYnVmX3JlcV9hbGxvYyhucGFnZXMsIDAsIEdGUF9L
RVJORUwpOw0KDQpJIGFtIHN0aWxsIGZlZWxpbmcgY29uZnVzZWQgb2YgYWxsb2NhdGVkIG5wYWdl
cyBvZiB6ZXJvIHNpemUuIDopDQoNCj4gKwllbHNlDQo+ICsJCWRidWYgPSBjZXBoX2RhdGFidWZf
cmVwbHlfYWxsb2MobnBhZ2VzLCAwLCBHRlBfS0VSTkVMKTsNCj4gKwlpZiAoIWRidWYpDQo+ICsJ
CXJldHVybiBFUlJfUFRSKC1FTk9NRU0pOw0KPiAgDQo+IC0JYnl0ZXMgPSBfX2l0ZXJfZ2V0X2J2
ZWNzKGl0ZXIsIG1heHNpemUsIGJ2KTsNCj4gLQlpZiAoYnl0ZXMgPCAwKSB7DQo+ICsJcmV0ID0g
X19pdGVyX2dldF9idmVjcyhpdGVyLCBtYXhzaXplLCBkYnVmKTsNCj4gKwlpZiAocmV0IDwgMCkg
ew0KPiAgCQkvKg0KPiAgCQkgKiBObyBwYWdlcyB3ZXJlIHBpbm5lZCAtLSBqdXN0IGZyZWUgdGhl
IGFycmF5Lg0KPiAgCQkgKi8NCj4gLQkJa3ZmcmVlKGJ2KTsNCj4gLQkJcmV0dXJuIGJ5dGVzOw0K
PiArCQljZXBoX2RhdGFidWZfcmVsZWFzZShkYnVmKTsNCj4gKwkJcmV0dXJuIEVSUl9QVFIocmV0
KTsNCj4gIAl9DQo+ICANCj4gLQkqYnZlY3MgPSBidjsNCj4gLQkqbnVtX2J2ZWNzID0gbnBhZ2Vz
Ow0KPiAtCXJldHVybiBieXRlczsNCj4gKwlyZXR1cm4gZGJ1ZjsNCj4gIH0NCj4gIA0KPiAtc3Rh
dGljIHZvaWQgcHV0X2J2ZWNzKHN0cnVjdCBiaW9fdmVjICpidmVjcywgaW50IG51bV9idmVjcywg
Ym9vbCBzaG91bGRfZGlydHkpDQo+ICtzdGF0aWMgdm9pZCBjZXBoX2RpcnR5X3BhZ2VzKHN0cnVj
dCBjZXBoX2RhdGFidWYgKmRidWYpDQoNCkRvZXMgaXQgbWVhbiB0aGF0IHdlIG5ldmVyIHVzZWQg
c2hvdWxkX2RpcnR5IGFyZ3VtZW50IHdpdGggZmFsc2UgdmFsdWU/IE9yIHRoZQ0KbWFpbiBnb2Fs
IG9mIHRoaXMgbWV0aG9kIGlzIGFsd2F5cyBtYWtpbmcgdGhlIHBhZ2VzIGRpcnR5Pw0KDQo+ICB7
DQo+ICsJc3RydWN0IGJpb192ZWMgKmJ2ZWMgPSBkYnVmLT5idmVjOw0KPiAgCWludCBpOw0KPiAg
DQo+IC0JZm9yIChpID0gMDsgaSA8IG51bV9idmVjczsgaSsrKSB7DQo+IC0JCWlmIChidmVjc1tp
XS5idl9wYWdlKSB7DQo+IC0JCQlpZiAoc2hvdWxkX2RpcnR5KQ0KPiAtCQkJCXNldF9wYWdlX2Rp
cnR5X2xvY2soYnZlY3NbaV0uYnZfcGFnZSk7DQo+IC0JCQlwdXRfcGFnZShidmVjc1tpXS5idl9w
YWdlKTsNCg0KU28sIHdoaWNoIGNvZGUgd2lsbCBwdXRfcGFnZSgpIG5vdz8NCg0KVGhhbmtzLA0K
U2xhdmEuDQoNCj4gLQkJfQ0KPiAtCX0NCj4gLQlrdmZyZWUoYnZlY3MpOw0KPiArCWZvciAoaSA9
IDA7IGkgPCBkYnVmLT5ucl9idmVjOyBpKyspDQo+ICsJCWlmIChidmVjW2ldLmJ2X3BhZ2UpDQo+
ICsJCQlzZXRfcGFnZV9kaXJ0eV9sb2NrKGJ2ZWNbaV0uYnZfcGFnZSk7DQo+ICB9DQo+ICANCj4g
IC8qDQo+IEBAIC0xMzM4LDE0ICsxMzMxLDExIEBAIHN0YXRpYyB2b2lkIGNlcGhfYWlvX2NvbXBs
ZXRlX3JlcShzdHJ1Y3QgY2VwaF9vc2RfcmVxdWVzdCAqcmVxKQ0KPiAgCXN0cnVjdCBjZXBoX29z
ZF9kYXRhICpvc2RfZGF0YSA9IG9zZF9yZXFfb3BfZXh0ZW50X29zZF9kYXRhKHJlcSwgMCk7DQo+
ICAJc3RydWN0IGNlcGhfb3NkX3JlcV9vcCAqb3AgPSAmcmVxLT5yX29wc1swXTsNCj4gIAlzdHJ1
Y3QgY2VwaF9jbGllbnRfbWV0cmljICptZXRyaWMgPSAmY2VwaF9zYl90b19tZHNjKGlub2RlLT5p
X3NiKS0+bWV0cmljOw0KPiAtCXVuc2lnbmVkIGludCBsZW4gPSBvc2RfZGF0YS0+YnZlY19wb3Mu
aXRlci5iaV9zaXplOw0KPiArCXNpemVfdCBsZW4gPSBvc2RfZGF0YS0+aXRlci5jb3VudDsNCj4g
IAlib29sIHNwYXJzZSA9IChvcC0+b3AgPT0gQ0VQSF9PU0RfT1BfU1BBUlNFX1JFQUQpOw0KPiAg
CXN0cnVjdCBjZXBoX2NsaWVudCAqY2wgPSBjZXBoX2lub2RlX3RvX2NsaWVudChpbm9kZSk7DQo+
ICANCj4gLQlCVUdfT04ob3NkX2RhdGEtPnR5cGUgIT0gQ0VQSF9PU0RfREFUQV9UWVBFX0JWRUNT
KTsNCj4gLQlCVUdfT04oIW9zZF9kYXRhLT5udW1fYnZlY3MpOw0KPiAtDQo+IC0JZG91dGMoY2ws
ICJyZXEgJXAgaW5vZGUgJXAgJWxseC4lbGx4LCByYyAlZCBieXRlcyAldVxuIiwgcmVxLA0KPiAr
CWRvdXRjKGNsLCAicmVxICVwIGlub2RlICVwICVsbHguJWxseCwgcmMgJWQgYnl0ZXMgJXp1XG4i
LCByZXEsDQo+ICAJICAgICAgaW5vZGUsIGNlcGhfdmlub3AoaW5vZGUpLCByYywgbGVuKTsNCj4g
IA0KPiAgCWlmIChyYyA9PSAtRU9MRFNOQVBDKSB7DQo+IEBAIC0xMzY3LDcgKzEzNTcsNiBAQCBz
dGF0aWMgdm9pZCBjZXBoX2Fpb19jb21wbGV0ZV9yZXEoc3RydWN0IGNlcGhfb3NkX3JlcXVlc3Qg
KnJlcSkNCj4gIAkJaWYgKHJjID09IC1FTk9FTlQpDQo+ICAJCQlyYyA9IDA7DQo+ICAJCWlmIChy
YyA+PSAwICYmIGxlbiA+IHJjKSB7DQo+IC0JCQlzdHJ1Y3QgaW92X2l0ZXIgaTsNCj4gIAkJCWlu
dCB6bGVuID0gbGVuIC0gcmM7DQo+ICANCj4gIAkJCS8qDQo+IEBAIC0xMzg0LDEwICsxMzczLDgg
QEAgc3RhdGljIHZvaWQgY2VwaF9haW9fY29tcGxldGVfcmVxKHN0cnVjdCBjZXBoX29zZF9yZXF1
ZXN0ICpyZXEpDQo+ICAJCQkJYWlvX3JlcS0+dG90YWxfbGVuID0gcmMgKyB6bGVuOw0KPiAgCQkJ
fQ0KPiAgDQo+IC0JCQlpb3ZfaXRlcl9idmVjKCZpLCBJVEVSX0RFU1QsIG9zZF9kYXRhLT5idmVj
X3Bvcy5idmVjcywNCj4gLQkJCQkgICAgICBvc2RfZGF0YS0+bnVtX2J2ZWNzLCBsZW4pOw0KPiAt
CQkJaW92X2l0ZXJfYWR2YW5jZSgmaSwgcmMpOw0KPiAtCQkJaW92X2l0ZXJfemVybyh6bGVuLCAm
aSk7DQo+ICsJCQlpb3ZfaXRlcl9hZHZhbmNlKCZvc2RfZGF0YS0+aXRlciwgcmMpOw0KPiArCQkJ
aW92X2l0ZXJfemVybyh6bGVuLCAmb3NkX2RhdGEtPml0ZXIpOw0KPiAgCQl9DQo+ICAJfQ0KPiAg
DQo+IEBAIC0xNDAxLDggKzEzODgsOCBAQCBzdGF0aWMgdm9pZCBjZXBoX2Fpb19jb21wbGV0ZV9y
ZXEoc3RydWN0IGNlcGhfb3NkX3JlcXVlc3QgKnJlcSkNCj4gIAkJCQkJCSByZXEtPnJfZW5kX2xh
dGVuY3ksIGxlbiwgcmMpOw0KPiAgCX0NCj4gIA0KPiAtCXB1dF9idmVjcyhvc2RfZGF0YS0+YnZl
Y19wb3MuYnZlY3MsIG9zZF9kYXRhLT5udW1fYnZlY3MsDQo+IC0JCSAgYWlvX3JlcS0+c2hvdWxk
X2RpcnR5KTsNCj4gKwlpZiAoYWlvX3JlcS0+c2hvdWxkX2RpcnR5KQ0KPiArCQljZXBoX2RpcnR5
X3BhZ2VzKG9zZF9kYXRhLT5kYnVmKTsNCj4gIAljZXBoX29zZGNfcHV0X3JlcXVlc3QocmVxKTsN
Cj4gIA0KPiAgCWlmIChyYyA8IDApDQo+IEBAIC0xNDkxLDkgKzE0NzgsOCBAQCBjZXBoX2RpcmVj
dF9yZWFkX3dyaXRlKHN0cnVjdCBraW9jYiAqaW9jYiwgc3RydWN0IGlvdl9pdGVyICppdGVyLA0K
PiAgCXN0cnVjdCBjZXBoX2NsaWVudF9tZXRyaWMgKm1ldHJpYyA9ICZmc2MtPm1kc2MtPm1ldHJp
YzsNCj4gIAlzdHJ1Y3QgY2VwaF92aW5vIHZpbm87DQo+ICAJc3RydWN0IGNlcGhfb3NkX3JlcXVl
c3QgKnJlcTsNCj4gLQlzdHJ1Y3QgYmlvX3ZlYyAqYnZlY3M7DQo+ICAJc3RydWN0IGNlcGhfYWlv
X3JlcXVlc3QgKmFpb19yZXEgPSBOVUxMOw0KPiAtCWludCBudW1fcGFnZXMgPSAwOw0KPiArCXN0
cnVjdCBjZXBoX2RhdGFidWYgKmRidWYgPSBOVUxMOw0KPiAgCWludCBmbGFnczsNCj4gIAlpbnQg
cmV0ID0gMDsNCj4gIAlzdHJ1Y3QgdGltZXNwZWM2NCBtdGltZSA9IGN1cnJlbnRfdGltZShpbm9k
ZSk7DQo+IEBAIC0xNTI5LDggKzE1MTUsOCBAQCBjZXBoX2RpcmVjdF9yZWFkX3dyaXRlKHN0cnVj
dCBraW9jYiAqaW9jYiwgc3RydWN0IGlvdl9pdGVyICppdGVyLA0KPiAgDQo+ICAJd2hpbGUgKGlv
dl9pdGVyX2NvdW50KGl0ZXIpID4gMCkgew0KPiAgCQl1NjQgc2l6ZSA9IGlvdl9pdGVyX2NvdW50
KGl0ZXIpOw0KPiAtCQlzc2l6ZV90IGxlbjsNCj4gIAkJc3RydWN0IGNlcGhfb3NkX3JlcV9vcCAq
b3A7DQo+ICsJCXNpemVfdCBsZW47DQo+ICAJCWludCByZWFkb3AgPSBzcGFyc2UgPyBDRVBIX09T
RF9PUF9TUEFSU0VfUkVBRCA6IENFUEhfT1NEX09QX1JFQUQ7DQo+ICAJCWludCBleHRlbnRfY250
Ow0KPiAgDQo+IEBAIC0xNTYzLDE2ICsxNTQ5LDE3IEBAIGNlcGhfZGlyZWN0X3JlYWRfd3JpdGUo
c3RydWN0IGtpb2NiICppb2NiLCBzdHJ1Y3QgaW92X2l0ZXIgKml0ZXIsDQo+ICAJCQl9DQo+ICAJ
CX0NCj4gIA0KPiAtCQlsZW4gPSBpdGVyX2dldF9idmVjc19hbGxvYyhpdGVyLCBzaXplLCAmYnZl
Y3MsICZudW1fcGFnZXMpOw0KPiAtCQlpZiAobGVuIDwgMCkgew0KPiArCQlkYnVmID0gaXRlcl9n
ZXRfYnZlY3NfYWxsb2MoaXRlciwgc2l6ZSwgd3JpdGUpOw0KPiArCQlpZiAoSVNfRVJSKGRidWYp
KSB7DQo+ICAJCQljZXBoX29zZGNfcHV0X3JlcXVlc3QocmVxKTsNCj4gLQkJCXJldCA9IGxlbjsN
Cj4gKwkJCXJldCA9IFBUUl9FUlIoZGJ1Zik7DQo+ICAJCQlicmVhazsNCj4gIAkJfQ0KPiArCQls
ZW4gPSBjZXBoX2RhdGFidWZfbGVuKGRidWYpOw0KPiAgCQlpZiAobGVuICE9IHNpemUpDQo+ICAJ
CQlvc2RfcmVxX29wX2V4dGVudF91cGRhdGUocmVxLCAwLCBsZW4pOw0KPiAgDQo+IC0JCW9zZF9y
ZXFfb3BfZXh0ZW50X29zZF9kYXRhX2J2ZWNzKHJlcSwgMCwgYnZlY3MsIG51bV9wYWdlcywgbGVu
KTsNCj4gKwkJb3NkX3JlcV9vcF9leHRlbnRfb3NkX2RhdGFidWYocmVxLCAwLCBkYnVmKTsNCj4g
IA0KPiAgCQkvKg0KPiAgCQkgKiBUbyBzaW1wbGlmeSBlcnJvciBoYW5kbGluZywgYWxsb3cgQUlP
IHdoZW4gSU8gd2l0aGluIGlfc2l6ZQ0KPiBAQCAtMTYzNywyMCArMTYyNCwxNyBAQCBjZXBoX2Rp
cmVjdF9yZWFkX3dyaXRlKHN0cnVjdCBraW9jYiAqaW9jYiwgc3RydWN0IGlvdl9pdGVyICppdGVy
LA0KPiAgCQkJCXJldCA9IDA7DQo+ICANCj4gIAkJCWlmIChyZXQgPj0gMCAmJiByZXQgPCBsZW4g
JiYgcG9zICsgcmV0IDwgc2l6ZSkgew0KPiAtCQkJCXN0cnVjdCBpb3ZfaXRlciBpOw0KPiAgCQkJ
CWludCB6bGVuID0gbWluX3Qoc2l6ZV90LCBsZW4gLSByZXQsDQo+ICAJCQkJCQkgc2l6ZSAtIHBv
cyAtIHJldCk7DQo+ICANCj4gLQkJCQlpb3ZfaXRlcl9idmVjKCZpLCBJVEVSX0RFU1QsIGJ2ZWNz
LCBudW1fcGFnZXMsIGxlbik7DQo+IC0JCQkJaW92X2l0ZXJfYWR2YW5jZSgmaSwgcmV0KTsNCj4g
LQkJCQlpb3ZfaXRlcl96ZXJvKHpsZW4sICZpKTsNCj4gKwkJCQlpb3ZfaXRlcl9hZHZhbmNlKCZk
YnVmLT5pdGVyLCByZXQpOw0KPiArCQkJCWlvdl9pdGVyX3plcm8oemxlbiwgJmRidWYtPml0ZXIp
Ow0KPiAgCQkJCXJldCArPSB6bGVuOw0KPiAgCQkJfQ0KPiAgCQkJaWYgKHJldCA+PSAwKQ0KPiAg
CQkJCWxlbiA9IHJldDsNCj4gIAkJfQ0KPiAgDQo+IC0JCXB1dF9idmVjcyhidmVjcywgbnVtX3Bh
Z2VzLCBzaG91bGRfZGlydHkpOw0KPiAgCQljZXBoX29zZGNfcHV0X3JlcXVlc3QocmVxKTsNCj4g
IAkJaWYgKHJldCA8IDApDQo+ICAJCQlicmVhazsNCj4gDQo+IA0KDQo=

