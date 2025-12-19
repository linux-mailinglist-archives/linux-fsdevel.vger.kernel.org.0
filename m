Return-Path: <linux-fsdevel+bounces-71783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F08DACD1D1D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 21:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D191307B092
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 20:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248F533C518;
	Fri, 19 Dec 2025 20:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g2UU4TPT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DEC28467D
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 20:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766177077; cv=fail; b=IRwy6cGZ9jEYivJtOWsV3k1rbGVtGfW78JirafYxBVAxSnSUVQEYuYlShElyI7l4X1Y7WZIf2yarqXrfVQsJYvusk37I5+ZQAe+CGhTW5q88kqFnwEnASLSKCnBu7vsdhd60n3W2uF54B65hvVvX0v4khiZdETob24b9SOf8SCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766177077; c=relaxed/simple;
	bh=j4LPKPRIpZPqHK4J9hyKbzH19TcpiFb5H9h00bnbIz4=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=h2AATJBSE93LhDBEbm7NKnAFya19DvJeY6VlPZEmEkqw4z5tdcH1/RNMEJcZSspBbRW/d01NTw68fC6qd1tA/JRDuGKNouLd551Jpu79TVVIxA+1HeyeRzS3+IDV7JcNu9CjO+fiOc6YylQPZqrq02umLQYmpDmSposDRbKbe1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g2UU4TPT; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BJKHJcF026182
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 20:44:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=k6cyXXMYJfeRh+QIL9q0RqjS6rddrha23auBISyR/jQ=; b=g2UU4TPT
	ux4pqCMXrEfa+P1CfwEqiefdm7N5Ehf+wM0KlplCsTJIS+PqFOmzRIXKjZ/Odzrd
	HeVSi47dMe8UUa7AZBRBw5+bWdLkH4+0IQbVxLiN1QYaGqzLEUyEPNYe8IV+RyJ/
	hw1TmwtiD9Jx1WN5OTPaE0DJCojX91v46LLusWAYE1H5V+v2/YFRytVXBDmCYRfb
	Mk4JdSoQJF4yvlD7mpRxQxgb29rhPe5FCcYVpbbXrJM7QLJzX5ZFDwoJuL5gCD0m
	32IWyE9kETwGvqg/tT/rAYwVWAXbqKGNl1vsG3o0eB69GUmh4/LnkSWT17Pa5IVl
	Zp1q1vYI2FC3vw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b4r3hwnga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 20:44:35 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BJKiYxT032334;
	Fri, 19 Dec 2025 20:44:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b4r3hwng5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Dec 2025 20:44:34 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BJKiXRt032196;
	Fri, 19 Dec 2025 20:44:33 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012046.outbound.protection.outlook.com [52.101.43.46])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b4r3hwng3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Dec 2025 20:44:33 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dEa0Rob90hdg8TLWSQE+OzCvj3wwyBBZ/kGtHFsx1Zel4vd4IIPvqLg4g+yoD6tB2HLUwRft4/AeBC6o/BdbEcj8mHIOIblOI6ollbKsB5vHOhN0tMkLOZHdZOIAEKyych/kHwkG+16P2f5YOFilsBCDFcscDa+/cyXHeLa4Zgc1ig9JC0TuoF1It4Ldlnypr8L20ZKpLZA1QYfAx0DVElUoVGa8UYj7ExdpKc3TKa8vYIrv4tcrq8LsV1Zxqmkjq0+UJOfrkqFPfxebJAuVif0XbCkUGQTLAa6G4geGb5xH2LzxduqJjJ3n3spaDORPAOrYy8Ti0IcRLZTqVI/A3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkYCKlFYmUlpEgpH5H58r4z1uRDm/8/mFlEcZkQXYus=;
 b=IBTbWH12PgQhiNQAd3hxtpzfllHFv9spifbUGDWEBGc8eT68HGkSY0JZd6wBStZcHDSolARBBZlwJxn5pM3ho8v8uO83STLGb0sbjWSfTpX8aJPowQCC4RvgP1t0guogMpKtmliOAOGj2ZzHaXETr8PiUMG8nWggiz50pxVfu+/CCevDi1JwbtaFjRX7jWLtOUfAymB1+zctvHytLB7YxXJkCr+ateC5uBxKqDafyK54aFF1RYOWTIIvJ642H8LAXkBxXLDM15CcGyfx1hILbzfYzKCCAHc/Qxzzf18axra/aCuAP6qMFezE/0iyhNJlP0yrgetjh//EaUrctVMHAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CH3PR15MB5916.namprd15.prod.outlook.com (2603:10b6:610:131::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 20:44:31 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9434.001; Fri, 19 Dec 2025
 20:44:31 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "idryomov@gmail.com" <idryomov@gmail.com>,
        Patrick Donnelly
	<pdonnell@redhat.com>
CC: Kotresh Hiremath Ravishankar <khiremat@redhat.com>,
        Viacheslav Dubeyko
	<vdubeyko@redhat.com>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        Pavan
 Rallabhandi <Pavan.Rallabhandi@ibm.com>,
        Alex Markuze <amarkuze@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH v2] ceph: fix kernel crash in ceph_open()
Thread-Index:
 AQHcb5TpmMeL+RYIakuRlVP/l+uM0bUmTK4AgAB3B4CAAG/ZAIAAf60AgAE8koCAAAW6gIAAe9sA
Date: Fri, 19 Dec 2025 20:44:31 +0000
Message-ID: <7d1f950f242b748b16acb88a92e062206628cd35.camel@ibm.com>
References: <20251215215301.10433-2-slava@dubeyko.com>
	 <CA+2bHPbtGQwxT5AcEhF--AthRTzBS2aCb0mKvM_jCu_g+GM17g@mail.gmail.com>
	 <efbd55b968bdaaa89d3cf29a9e7f593aee9957e0.camel@ibm.com>
	 <CA+2bHPYRUycP0M5m6_XJiBXPEw0SyPCKJNk8P5-9uRSdtdFw4w@mail.gmail.com>
	 <CAOi1vP_y+UT8yk00gxQZ7YOfAN3kTu6e6LE1Ya87goMFLEROsw@mail.gmail.com>
	 <CA+2bHPYp-vcorCDEKU=3f6-H2nj5PHT=U_4=4pmO5bihiDStrA@mail.gmail.com>
	 <CAOi1vP8o7NAmrHi96UJ8B8DxFSHCgiczDCU=r2TAVn2oi1VD8A@mail.gmail.com>
	 <CA+2bHPb41OinL5E_HXpXTGww2WWqEU3k06JfVHZ9joUQuYsBPg@mail.gmail.com>
In-Reply-To:
 <CA+2bHPb41OinL5E_HXpXTGww2WWqEU3k06JfVHZ9joUQuYsBPg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CH3PR15MB5916:EE_
x-ms-office365-filtering-correlation-id: 66359cb7-7332-4f25-2829-08de3f3f6912
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UmJPVzVld2c0T2F0R1lUTUxURzdxV2RJazF6Ymg3VnlTa1FPYnhuZGM4TU53?=
 =?utf-8?B?SnZYcEdya0oydjFKd05tZzkreHF3b1Y1enI0MDRZdk5OZGNFeGozWGtIYmZh?=
 =?utf-8?B?NllNZ2szMkc0NmNLSXJzQWE2c05IOFJFdTlPbHE5S2lvQ2pWU2w0NGtrUGpP?=
 =?utf-8?B?VDl5WVB6S0dURVc5NUg3a3orek5RSVNBb3FUSlF3WklCdk9qb0EwUVh3UDg4?=
 =?utf-8?B?dU5BbVpydjI3VVN6a2xKRXVEWVNia3UvcmtOZDNUM3RQQTF3UGN3cUw5OEVM?=
 =?utf-8?B?RVdyek9ReEpMYUppb1JORFZhcjRnbkJZSloyZ1JTc3AzZXAzdUdLUWRrZE0z?=
 =?utf-8?B?UnJpYnI2eWJYNUN4N1liQnQ0M0J1Uyt5Nmo4T0d3MVBVaFBkdFRMV3M2eFdu?=
 =?utf-8?B?ZVplNXRRZi9PUUR5TmR6cThDY1kvRjJ4d0cvb3AzaEF3WkVMa0NzK3NSY2lD?=
 =?utf-8?B?SWRyU3l1WjhaeDdyWW5UMkxEQytVTHFrdW1mVG4vTWZZZ0lmYWY4cnpxcVhX?=
 =?utf-8?B?VmtBODBLTC8rS3JYZDBlUWNtdkVUR1phck85N0c3NWlxSUh0NlBmakdFa0pS?=
 =?utf-8?B?UzM3WEFsbnhhS2p3dk1uTHByazdNWDBrNExiL3h6amt5bWdFL2dIbW1qS2VG?=
 =?utf-8?B?NThIR0RxOXRJQnlxakhrL2hsMW9zZGpaTEJmQ3BWYUI4M080T0pRZ3JQVmMz?=
 =?utf-8?B?NU5DVWJ0c3o1M2xoUGlLc0J6REZKdU44STB2QmFPak5BOSt6YXlUd2wvUDJZ?=
 =?utf-8?B?Rk5qbVhhSnBQVnJ1ZWtPUmhiMkhmcVZENVN2Qjl2d0Z4UlVUaTJBSHZuOGVN?=
 =?utf-8?B?Tk9BaFdJRUNoMXVUNmtIT1FGK3VicXl4d2lvYjQyWjF4SHgwNEhWbFZCZFpk?=
 =?utf-8?B?VU9NaERaY0N3NGNSRTErSUFlMWlzZUllcE5QWm1scnRBRi9LN0FnTENkREkw?=
 =?utf-8?B?R2RVKzVpanFHRnhNOWNOZmtGT2hlOVJva0JlM2dwcWxtallVb2Y3ZFhXSmJG?=
 =?utf-8?B?TllmYjNEQ3pFRlpwaGpkYW9mR0NudGtyZlJCaWdncHpHaW05ZENXb3o3cm5C?=
 =?utf-8?B?aWp0ckZWMXZyOHI2a3k1aktNMCtXdHplNGZwQ1hjT0VBcVZMb1MzdGhzdUhT?=
 =?utf-8?B?ak15ZEd1UlA0cm0yaEh4TmttYml3eEFuRFF1dXNPcmNlQzZ2K0JOVWFrOVdD?=
 =?utf-8?B?SmU3ZW0rMGVvMktQZ3gwVVIrTVNnSUVncDNJY3lGYUx0a3F1Z0R1UUM1K0g2?=
 =?utf-8?B?OUk5UzJGYkpuS1FyVTFGNGNGejdkK1JUYytnengwZmlta3ZzcXdOalpYU085?=
 =?utf-8?B?bVpNdDBaVWcxRjhUYitSK0xmc0l1eGd5TCtZQldmM3gwVTlRSzl1MlJoSTRh?=
 =?utf-8?B?VGdOMmF2NTJYcUdER3pnb1Z1NEFOZ1NSR3dGRDdEOXVnc0JVZWJ4bWZ3SlhX?=
 =?utf-8?B?aDJyMFRtZmhMcmp5R2F6c3ZycHF6aCtpeW1HeGhNdTQwK04rU294dXJNN1dN?=
 =?utf-8?B?dDNZNEg5ZDNwMUU5Smc0NkYwaEN4K3o1cjdWNzdTcVlQS1Bwa28zUGJ2VU1H?=
 =?utf-8?B?NFVabGZDYVZHNE5aTkZ3blQyT29Wd0w1NEZ3N0RhOXZjZ0NBZDJpZHp6SFE1?=
 =?utf-8?B?d0taT3R2UjU1dWpNbTZ5TVRGcE5pc3JjYlZZNi95RnRIdExRWW94WVFWblUz?=
 =?utf-8?B?ZU9uWWEyRXJBeXhlUmc5WUhuZ25DOUFHQU94SUFDdm0yRElnUXY2S3luUE5o?=
 =?utf-8?B?Q2tzczU4aXlQQ1VYRHV5cStkYk9GQ00rSGJWQ0RQMjZmRDR1U0o4aDJYTHNv?=
 =?utf-8?B?azRBWUJ3QWRXUUNpQ2ZNUXVrQ0QxWG9GNUZ5VzJKTnR5a0NUc1ZYM0dqdGpj?=
 =?utf-8?B?b212NUlHM3dmMCtqVXZ3SUcvdHVnVTRSSWJSam1IM25Dem9ab3hWUHMrbmRi?=
 =?utf-8?B?QkZ6NzVYYlBGa3hwc3FnNHFRWUtocTM4NzFWaHVGL1JhaXlaZUhsVVFhSWcv?=
 =?utf-8?B?Vy9sQkg3UW81ZDFSTUVNSGJGRFdkRlY4emZBZ3dJMFY5ZW5qeDVEQjI1ZkFL?=
 =?utf-8?Q?tBCfov?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c2doTlAyZWdLTVQ4Sng4ai9FRlRRbXZsNGdpMmZFZEErYTJwOHEvdzBDUWt0?=
 =?utf-8?B?MzlxSlNYc2ppK0lLZ3c1YkRZNE0zZkhVdzdrK0hKK3ArNEtFQW04SCtId2Ev?=
 =?utf-8?B?VEVUdmxyVFFTV21tcmhoRUpRZVFTd3RHcVlrY3BvUElUTTFaeE9aSk9qejE3?=
 =?utf-8?B?YWdIeHZUaCtXZ3ZZdVZmMURQUDZFaFRVMEFtTldKLzhXWFEraHlMbDBjUFlD?=
 =?utf-8?B?L1U2ckNwMnpRZXpnYVNRVTFnbUlZMkRqbnVNZlNHcFV3NFNKUkNhUUl5bkM0?=
 =?utf-8?B?RU4rckE5SlkzZnQ2b3ZPM3paUGNKUVBNRm1pMG82VlRkK3ZsWUlWdUhIczdn?=
 =?utf-8?B?T3VZdVkwTms3d3l1cG9WbWxWWWRvSVlHZC9xUVpaOEFvY211a21OZkV1K2tu?=
 =?utf-8?B?T3RYZlBnOG53amdUOXVnWTRJVWlUNERLQmNDT2p1dFpiYUtvNHdqaVptOFdy?=
 =?utf-8?B?ZHFzMld1QTJ5WUVmSU5LbFdtb04rWThnTDFLdVo3UFROU3R3cWFXeFNnbWpw?=
 =?utf-8?B?cCtKOGZnTWZNTjgwZUE2MTRabVlWemxvVzFqVHZmSndaRUNZaFhWVjJ0YWVI?=
 =?utf-8?B?L1g2Qy9yNHRaeXYxWjNCWi9SRlJjQmQ4RWpIY3FkQ3dhUU9XVllzR0lOUnlu?=
 =?utf-8?B?c1c5a2dQdmhuajlCcWdxbFIvMWs1clFpUkEybWV0b2s4NU0xZzdhN3VxSExL?=
 =?utf-8?B?Wk95aXB4QVhTc0Q1YnRaTjUrQkdSZ3d6aDBsdmRNSjJKbVJuLzJBTXhlVHlv?=
 =?utf-8?B?eFJ0MkFnSW01THZOdG42d2l5bVJEaUhVWDUvTk9CaHl1WGErRnVPUlNwcVU0?=
 =?utf-8?B?bHRibWxXa1hrS3pqRGFKZnUvQnlvS0Q3bzB2dkNIb0FOUXlLbytlMXF3QkFm?=
 =?utf-8?B?U0w0cElvSDMxTXg4a0VxaFVFWHQwdlFML1B2WmcycVJnRUhEVTB0aUQxSGQv?=
 =?utf-8?B?T2U4bS8rckVvQmEwRGN1ZmtaU20vZktxY1hwK1JYYm5uWitkaHhLUTlJanFm?=
 =?utf-8?B?QmFvUUtQdkcwREsrQmN4ckhwNFQ2aHpjd3Zmdkx0N0ljM3JEeGQ4SVljaEgz?=
 =?utf-8?B?TGgvcm1RWm5OdkVHSUZnRG05R2FYQUNtK1JSdEFadHlEMy93REVDb05HNGpa?=
 =?utf-8?B?N0k1UVh3andiOFpmK2dmdzFOM0MwbE5UdFFmenZ6YVN5UzdsS29SVmh0aVN0?=
 =?utf-8?B?bzVGUEM3Z2tFaWRFY2JzY0FENDBINnk2UGx0blpiU25PbTB0b1FwcW5DYTU5?=
 =?utf-8?B?amd6ZWRtd2RYRVpITzNrcUVLY28vNmJaUEFNaE0wMjhJSS8rRHFHMGdWSnhm?=
 =?utf-8?B?ZVBKelloZXVFaTQ4QVNYMGNCMnhBbHlPSDFRQTE4dzBmdVkvZXJNVi9EaWpj?=
 =?utf-8?B?YlU2NVEwN2Z2WHVpVk84RllBd3ZOQVVCdjBhd3llZStWQklCVkdQVExSeWRa?=
 =?utf-8?B?c3JVQmVXTEhRNWNFUUhPZ2JCOVJ6QjJTNHV4cGp3SnN4aTdRVG45Z0lNeUow?=
 =?utf-8?B?WksxN1lLd3BxWVJjL2xIV21lUHJPbFlFUlYyT2taQ1VVVW1oY1h3cjNhV250?=
 =?utf-8?B?TXZnbDVoVEdxSXJ0OExaemFsMVdYYnFMTHN0VWROZFk4Wm14dFFQSFcyMXMx?=
 =?utf-8?B?WG85aHhLUURsdnNSZnBDZ1pJUUhhb0NqL2RzdWgzR0tMYU5YZlZtNml3bzV4?=
 =?utf-8?B?WG53eU5KZHhWNXhyb2JiY0p6QUVzVmt0QmxYTnUwVU1wUmxGUVNuYkE1dk1S?=
 =?utf-8?B?Rnp2Nmp6dVQvY3FmMmtkcHcvenh2YytVZW1MV3cwVlU1TmdvaVk2MnFQem13?=
 =?utf-8?B?RXRMVDArTi9vdXJWN2JPSnRyUWRWcElTZzFndUVadXpra3JUWjR3ejFOOWox?=
 =?utf-8?B?Vm52SXJ3SW9kbEU4all0L1NVOUhGVmRVUmFLZ2s0SmRYN25PeXhkeFgzWTlE?=
 =?utf-8?B?NS9UT3hlOXpzcFN2Y05XMXBML280QnNFOVV4MmpaSTlxM3J0K2x5NlM1YWhr?=
 =?utf-8?B?OGozU0lVVHdjcE5HWURYNXhKdmhJc1ZIUXZPalNVaU9wcXBkZURhaUJVMXgz?=
 =?utf-8?B?WnlRNVlMVHpHR0FJM0xYaG43dXZ2SkxIQzdOSGt6NUdDMXVjak5TbTg4VHln?=
 =?utf-8?B?a2xXMXFDVGtXMEJ1bS82VWQ0UTFjSTAxYjA3dVU3cUVESkk3d1RPcXR5L2hJ?=
 =?utf-8?B?aUxyTEVQWEsrcHF3dTd5U05pdnRkUXUwRUxDNVU5QnFybmk1Uk5QU2k2SExn?=
 =?utf-8?B?Y0JhYkw0OVd2RXJpL1R2WTBtL05xMk5xN0poeVJDcWErZGxnSHRrTksvdDJi?=
 =?utf-8?B?RlFZbnJtMjQ2MkJJaXZCWWRNWi9UdGdwVG83N2R3WndIQ25Fd1MzcFhldmVR?=
 =?utf-8?Q?nMzzyhO05re48ryynDFz/EAprOCIye5tB8Hme?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66359cb7-7332-4f25-2829-08de3f3f6912
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2025 20:44:31.0469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZZtz0MTZ03ihHZsD8cmUK1LXIma7HDe94IRAMBlT60bRlQ5whWPKPNtwWKtzfu+m3fW5I1ssUW077N9vAm9v7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB5916
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDE3MSBTYWx0ZWRfX4yHYGmFT1UCJ
 x/fcNAvGtB3yX7m2ZwKpzwSUtcDFVM8WQuaVaY9YdZda63GmrXey7tNcuvJZJwuVSa9nXxnmNDd
 EEvUj0GDmXlJvDsNOlbHPQZ3fFxEPRQiasRxtrInSTgdo1kePyXFuVxstIOj/6JMqQpNsnwHLg7
 71CN5W81Laa9DzdhBT9D2WauHzusQRH9Zw0x6XxZq4RVsbJj7Nnwt8R7+W8WkDmx0Ll7eG4aU/D
 lZIh99TSx6bS0mmFpESVovU8oHizbo/gLLH5jCeET2eFCRRSm6cL5viUBWaWScxnM6LjAj3DMbE
 oswsQ8n2eTa5hRZT84e5ilZ/SF+71GL2B4CvVn8yC/s0VZKWlhBmVtuehWdB/U9MC9L005tnVq/
 6/iv0BNkEqL5Oah4lE9/we2LaJ3f363HmsEnLecaW9Rzy0zYPsHrNf8LLe/+WyNn3Wpim8LkwwT
 MASsMj/4vqlX2BKBeIQ==
X-Authority-Analysis: v=2.4 cv=N50k1m9B c=1 sm=1 tr=0 ts=6945b932 cx=c_pps
 a=2EcEh/UKxA6NVIT+L3iE4w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=A2VhLGvBAAAA:20
 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=6bFje_0WgLrlc-5-tOMA:9 a=QEXdDO2ut3YA:10
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: kOe2qiFWkPi5JMDUwX4TqU6TvWgZUUqV
X-Proofpoint-GUID: ETXkEfvDdhfmIx8jecRDhCgfXkqHcFnS
Content-Type: text/plain; charset="utf-8"
Content-ID: <440F062EFCBCEB46A8301D79CE5759B4@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH v2] ceph: fix kernel crash in ceph_open()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_07,2025-12-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 malwarescore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=2 engine=8.19.0-2512120000 definitions=main-2512190171

On Fri, 2025-12-19 at 08:21 -0500, Patrick Donnelly wrote:
> On Fri, Dec 19, 2025 at 8:01=E2=80=AFAM Ilya Dryomov <idryomov@gmail.com>=
 wrote:
> >=20
> > On Thu, Dec 18, 2025 at 7:08=E2=80=AFPM Patrick Donnelly <pdonnell@redh=
at.com> wrote:
> > >=20
> > > On Thu, Dec 18, 2025 at 5:31=E2=80=AFAM Ilya Dryomov <idryomov@gmail.=
com> wrote:
> > > >=20
> > > > On Thu, Dec 18, 2025 at 4:50=E2=80=AFAM Patrick Donnelly <pdonnell@=
redhat.com> wrote:
> > > > > > >  Suggest documenting (in the man page) that
> > > > > > > mds_namespace mntopt can be "*" now.
> > > > > > >=20
> > > > > >=20
> > > > > > Agreed. Which man page do you mean? Because 'man mount' contain=
s no info about
> > > > > > Ceph. And it is my worry that we have nothing there. We should =
do something
> > > > > > about it. Do I miss something here?
> > > > >=20
> > > > > https://github.com/ceph/ceph/blob/2e87714b94a9e16c764ef6f97de50ae=
cf1b0c41e/doc/man/8/mount.ceph.rst =20
> > > > >=20
> > > > > ^ that file. (There may be others but I think that's the main one
> > > > > users look at.)
> > > >=20
> > > > Hi Patrick,
> > > >=20
> > > > Is that actually desired?  After having to take a look at the users=
pace
> > > > code to suggest the path forward in the thread for the previous ver=
sion
> > > > of Slava's patch, I got the impression that "*" was just an MDSAuth=
Caps
> > > > thing.  It's one of the two ways to express a match for any fs_name
> > > > (the other is not specifying fs_name in the cap at all).
> > >=20
> > > Well, '*' is not a valid name for a file system (enforced via
> > > src/mon/MonCommands.h) so it's fairly harmless to allow. I think there
> >=20
> > By "allow", do you mean "handle specially"?  AFAIU passing "-o
> > mds_namespace=3D*" on mount is already allowed in the sense that the
> > value (a single "*" character) would be accepted and then matched
> > literally against the names in the fsmap.  Because "*" isn't a valid
> > name, such an attempt to mount is guaranteed to fail with ENOENT.
>=20
> Yes, correct.
>=20
> > > is a potential issue with "legacy fscid" (which indicates what the
> > > default file system to mount should be according to the ceph admin).
> > > That only really influences the ceph-fuse client I think because --
> > > after now looking at the kernel code -- it seems the kernel just
> > > mounts whatever it can find in the FSMap if no mds_namespace is
> > > specified. (If it were to respect the configured legacy file system,
> > > it should sub to "mdsmap" if no mds_namespace is specified. s.f.
> > > src/mon/MDSMonitor.cc)
> >=20
> > In create_fs_client() the kernel asks for an unqualified mdsmap if
> > no mds_namespace is specified:
> >=20
> >     if (!fsopt->mds_namespace) {
> >             ceph_monc_want_map(&fsc->client->monc, CEPH_SUB_MDSMAP,
> >                                0, true);
> >     } else {
> >             ceph_monc_want_map(&fsc->client->monc, CEPH_SUB_FSMAP,
> >                                0, false);
> >     }
> >=20
> > I thought a subscription for an unqualified mdsmap (i.e. a generic
> > "mdsmap" instead of a specific "mdsmap.<fscid>") was how the default
> > filesystem thing worked.  Does this get overridden somewhere or am
> > I missing something else?
>=20
> Ah, I didn't see that code. Yes, this looks right then.
>=20
> > >=20
> > > So I think there is a potential for "*" to be different from nothing.
> > > The latter is supposed to be whatever the legacy fscid is.
> >=20
> > Are you stating this in the context of mounting or in the context of
> > the MDS auth cap matching?
>=20
> mounting.
>=20
> >  In my previous message, I was trying to
> > separate the case of mounting (where the name can be supplied by the
> > user via mds_namespace option) from the case of ceph_mds_auth_match()
> > where the name that is coming from the mdsmap is matched against the
> > name in the cap.  AFAIU in userspace "*" has special meaning only in
> > the latter case.
>=20
> I understand what you've been saying. I contend that treating "*"
> specially for mds_namespace mntopt could be useful: you can select
> *any* available file system even if none of them are marked as the
> legacy fscid.
>=20
> Big picture I don't think this matters much. It'd probably be better
> to only use namespace_equals (no "*" handling) for mntopt matching and
> something else for the mds auth cap matching (yes "*" handling).
>=20
> > > Slava: I also want to point out that ceph_mdsc_handle_fsmap should
> > > also be calling namespace_equals (it currently duplicates the old
> > > logic).
> > >=20
> > > > I don't think this kind of matching is supposed to occur when mount=
ing.
> > > > When fs_name is passed via ceph_select_filesystem() API or --client=
_fs
> > > > option on mount it appears to be a literal comparison that happens =
in
> > > > FSMapUser::get_fs_cid().
> > >=20
> > > Sorry, are you mixing the kernel and C++? I'm not following.
> >=20
> > I'm trying to ensure that we don't introduce an unnecessary discrepancy
> > in behavior between the kernel client and the userspace client/gateways.
> > If passing "*" for fs_name is a sure way to make Client::mount() fail
> > with ENOENT in userspace, the kernel client shouldn't be doing (and on
> > top of that documenting) something different IMO.
>=20
> I wouldn't suggest the kernel change without also updating userspace.
> In any case, we can drop the suggestion.

OK. Finally, I assume that we agreed to drop: "Suggest documenting (in the =
man
page) that
mds_namespace mntopt can be "*" now." Am I correct? :)

Thanks,
Slava.

