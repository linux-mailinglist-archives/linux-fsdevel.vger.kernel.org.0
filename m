Return-Path: <linux-fsdevel+bounces-42503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A771A42E1E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 21:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F11ED189DA8A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 20:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6219E25C6EA;
	Mon, 24 Feb 2025 20:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jEoRSw4d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876A3245005
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 20:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740429608; cv=fail; b=EVrHPbnps5L6nDIRmYRpnKXONw0L10HLAqH8QFD9FaRo0cNyhiboCqNE7d2Qa8EV3uidoNRz+7eAnQuTFNGtJDqXgm2yWmCRowm0FWTzf4gitP0nBsL0+x5zeFMoTTusoUNpHFBi2yVhPHiAal6JH5ew9XKUvamVEqog80Zpt5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740429608; c=relaxed/simple;
	bh=F6SxwPT3LeZTNKHELaWvncuskEjE2FB2oReq4aSriio=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=BvYKgxbEudq5EtNKLWpvA7Lnidhn9tZw+RZvE2gg3K1kqQMv3ZAofibr5gjANF7SCkBJoPNoTKwGEH/XAWRexrj2AcoQwfIGGaslcfrpgKAKNG08DQgegQUruueHBOs8zl3hOfLuWu38YeWejU0ezAQ+mdA4UR4Z2oRm8ZwmflI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jEoRSw4d; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OFUjNp006492
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 20:40:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=69CoRwu+jpAMqgwG5p8wG+HxUnk0IVb77xyarhIMatU=; b=jEoRSw4d
	CDZKbEHHUFdyJSsO1u2aY1mG6v/gsSkqbjhCh3G2/msNGcctN3LbF800700vscv6
	KoICnkniGSNIPJrGqNcT1mpuf+BSjs7HIMK+jv3toDKQC3hMU6+rqQAQckiIYCvu
	80lV5wClVMJ56NGlpngg5qPJKQRtlC45uLOSwtXyLVdzYw+x3ntoS0zDYEbj5w5d
	iPe8VKR/AS3KazeXkjT0kP7TLZN1O67IUtGzvZkBrrWhyaHQQlVRUYfvR0y0hK7I
	ROR+JOjSXr2PIH3RYgyFizgZYxidVe6RPiBGE31tnsZlovHk2yJPguuUPhKqg4TP
	wGW3u/wEZ8EWhg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 450mfp3mft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 20:40:05 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51OKe5nb031496
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 20:40:05 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 450mfp3mfd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 20:40:04 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WuIvZNxQojda6TrORMp7Xfgc8+sEEOX3m3yV2m+beMj1QCd32IjRpgHhNpI59dceLinwmA+HPsWo6175LJZs8D0ae9dls/OpBLrWoiaiaPHemUPeiImDPB7z1aMVDlXbV3wsNwJzNDPm5IbgatXwfrOkqJqxBZTC5pNrwOvpTD6kc2L5SBrSbcSw9eQfMXOrXSwhqWdhnlBnLEynj4xRiFPqTYE5wPIerJ9QqmQ0l/gJoWDi/sDQXlVL8QRsn8V+2hoCbjL04csCNBXF4kY0/q/fbtOPHqwPhU8OR7uZRNPH3a+kRai/ARh+jcnw0A86aU3W9+SSEdAFK4ABtPIbkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yvDm9B0y8D/95es6yun/2kDF/jRkucx6msqt4nd1/jY=;
 b=pYQh68CQCjXuTJpo3AdQvJqwQ6sPNmF8CLzw2zhypMFowfxQG3/SUGpHR/bbB6biu3NFDlnFdSIELxN7Fy2vpRUyRoZ1Zyrk7tE2/u1SLhVIsNJiPNJNEAibRjoy8XgVBzfwm8c8jNIrmu1UtvhPU/6FDDaDEIiDlXreysREwVu0h9xm0xt4dfX8qM1rOnLRBUYyZOgLbll5wMyx7dlOOdFYKckTMyZS0eB/qOZyqVVqUHsEHzUrhTJVpYBQvMpDtyiBJ2yTG5Cyg0ix3+IlHfmN/NO5r/yUBxpxLO6rg2Kg6MFGPRaiFBZ5MCxb77D2MZJb9gA5QuBzmL11/9R6yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SJ0PR15MB4440.namprd15.prod.outlook.com (2603:10b6:a03:375::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 20:39:58 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 20:39:58 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "willy@infradead.org" <willy@infradead.org>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        David
 Howells <dhowells@redhat.com>
Thread-Topic: [EXTERNAL] Re: [PATCH v3 10/9] fs: Remove
 page_mkwrite_check_truncate()
Thread-Index: AQHbhKGWOUU2y6TX00KVqLDkNzpdYLNW50YAgAACNwCAAAXJAA==
Date: Mon, 24 Feb 2025 20:39:58 +0000
Message-ID: <b210fc3fa1c0071cc9031b38671dfded2651b974.camel@ibm.com>
References: <20250217185119.430193-1-willy@infradead.org>
	 <20250221204421.3590340-1-willy@infradead.org>
	 <Z7jl9cIZ2gka0QP6@casper.infradead.org>
	 <5c1ed8a12c92c143e234a59739af3663e9898ec1.camel@ibm.com>
	 <Z7zURN93vqUfZj1T@casper.infradead.org>
In-Reply-To: <Z7zURN93vqUfZj1T@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SJ0PR15MB4440:EE_
x-ms-office365-filtering-correlation-id: edd99f38-3318-4bee-c656-08dd5513678b
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WVcwRkFrRDZnTXRnSi9HSElndkE3MmNBREwyTVpHTkxBQ3Y2LzJoMXlSRDFh?=
 =?utf-8?B?aThZVG9kOWZYd2xHTWhzK0RKSTlFYkN1NE9PR3lsL0psaWl1WFpxa2kwVWxQ?=
 =?utf-8?B?NVdxWS9VOXlEd3JEdVFmeTlBeGlGZjluTkQzR25mbnhoMm83L2QvMXdvd2VV?=
 =?utf-8?B?Ty8rajJweW9tQk02V1BIMW9TcWdOV1FEOWdwSU9URGdMbmhNUXc1djlrbGlt?=
 =?utf-8?B?eC9PblhzWUdoczlIOEx3U3p6dm00c0k4azk5UUdkaCsrcWVsLzN2UStGRDdk?=
 =?utf-8?B?Q3grcGRXSk1GeWRSekthWTY0Qi9qN0dDbVArTFZnanphVzZYdGhnU0RIVmN1?=
 =?utf-8?B?Rmk3ekYwV25Ma2dBNzZ3ejJ0bmNiN3pLbVpZUGpGZlc2SWlaVXNWWHE5cXps?=
 =?utf-8?B?emhFNXFLNTkvZzJnbm9kb3R2bU9vK1VzOThlNm0xV2NOSWpzRkpnZmI0TzdD?=
 =?utf-8?B?dlBiNGNtTUl1cjVzM2VOQ09oWjgwZ05PYkZ3NU15eEQ5bU9SSmxya01GVmNG?=
 =?utf-8?B?R3dMRytxWnpBWU5kVjBTUFdMOWJtYklMMWZTMU01V0FhSWJFdEJmZWdXckNS?=
 =?utf-8?B?Yk5XZDNrbXozS2ZIYVVLVkxqZGk0MTBMa1JlbTNabUlxZHdQa1BFaVJ1Vmg0?=
 =?utf-8?B?aFVaVy9QWWlIWjM1aGI5OGU1MWZMZWJiZXZBeWZNWkMzV1lQd0N4eTJwMDIx?=
 =?utf-8?B?QXRyUmxiRWd6Z0crcHdsemRaYVdzRDBHbTBuYkdSYlY1NGhIVXZBUXpTLyt1?=
 =?utf-8?B?dWVpQlNyWVhWblk0dHFFRmJSN2NGYlhOQ1p5S3BneDMvTStSQlNpQU0wQkhH?=
 =?utf-8?B?TnNIM0lkWlJ0QllidmdoR095UnFMVHltYnJDVmR6aG9SUDM2WWRRV0tiMjI0?=
 =?utf-8?B?VFFuQ2MxMUhIR3V0aUZLOVpNcnZDZHBpeG9jRklXVzRtVjEyZzA4UHpLQ0FB?=
 =?utf-8?B?MGl2dkNhRGY1RUcramhaTEZzcGtlQzNrSFRFeFNRQVB6aGRTOE9id1F6aElo?=
 =?utf-8?B?MHptbmlYL3N3TTNTMFV4cEtzR085T29ZenBuOE5ZcXhERkErTDlZbmZHTlpK?=
 =?utf-8?B?VjVQSnYwZTdpeVFXTXQ4VVFCaVhycEZPRWtEelVSd20xYjhnVFBFQXlaQ3Qv?=
 =?utf-8?B?T0tGbjRvZHJ1eTB2elRZVnBSTTVSZWdqemsyK3FXdXlhL0tQVUFsdEFPRTFD?=
 =?utf-8?B?WE9SdnozM1g1MWtHOXdjM1ZhRmR5djNqT3ZhaUtrbWJZSGU3cytzZkhpeUU0?=
 =?utf-8?B?bkluVVZ0TExlS1lGNEVZTHlEMVRseDZtb3BvMENFTFYraHlXNk5lU0FOdko2?=
 =?utf-8?B?eTYyTGZYTmE3ZTNsdlRzbE43K0tkVUVoZzNIajRyMmxDZkVhOWduYWNYUkFP?=
 =?utf-8?B?eEdoRXcyYTJMNzJFOGt4VTlZYkxETzQvODNYVThubzFSRUtFSU40YjcyQk05?=
 =?utf-8?B?NnREWHA0aHVVWGJweVB2SkFKUGRqVmV0UG9UZ05GY0I1UHhKd0Yyd1crUStl?=
 =?utf-8?B?N2lmWjU4WEh2MXBzS2NRb0FRWDF0SHBTYTBMR3NMM1hNcTNxbEtPQTkxQkZh?=
 =?utf-8?B?VFN1VkNTa0hraHZjR1RYbXBBOHhYRVg5QWVFZllMV0ZnYmxzQk1jYXR6L1lK?=
 =?utf-8?B?VFAyUmJ2QVBXR0dSdW5Ia3dBamtwTGl2cGZreEtMVEhTdGI2K0c3ZlR3b2hE?=
 =?utf-8?B?SXVYLy9MQnk2QVhQL1RqWnVGTXhtQTVPaW5aemlDd0c5YVY0WVdpN1VvaW8w?=
 =?utf-8?B?ZGw2UGtIS2FJTjBuTFRQeWs4NjVoN3lQR1pEMFcxYTJVbzc0VVF6ZFhRaGtX?=
 =?utf-8?B?aE1Ha3lLTkF1RUt2RXhmUzY3b0w5bjA3Y3hNd2Z4em8yTVlEcHg2QStsa0lO?=
 =?utf-8?B?VFV2NW9ibU4relM5VVZDTjBjRnl6aHRoc3hvdEV4Q2lINk55dnFMTXRPVXdh?=
 =?utf-8?Q?dV5NINOkEX3OYNqsJuCTPSFjIVxDDDzP?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZXZJaGZZMkxOcXU2bW1NcFgyMEhiYVhVSk5TR1hZTHd2eDdrNHltNld5NCt2?=
 =?utf-8?B?b2hzMWtuVGFmU3F6VXAwVGlMditYYzhIVzJDNEc0YXFCSHVXUElYNmloOFdJ?=
 =?utf-8?B?allqcVdhZ0w5bHd5Y2R3Q2hCck90My9rM05jd1I1bkpGbDRySlRWUzFFNngw?=
 =?utf-8?B?NEhBZU14TVhJOUNvVS8vUkwrRGxUNkg5ZUVvUk1PZkhJVEtQdEt5OXp4bGov?=
 =?utf-8?B?N3N4V1hZWGZLU25vNDdxcHRRblpWRmJwNjlpY3BNbG5DL2Zmakg1Zk1OQW9l?=
 =?utf-8?B?ZWtqMkVhb3hnMm91dm9YSVMwSHFBemdKY05MMm1UN2p2bUJkd2EwR2VPazVO?=
 =?utf-8?B?YlFOOGFjV2FueGd1WnY5T2o1azF5TS80RnpXRndSRkVtem9vaFlyMlpMeitr?=
 =?utf-8?B?QmpOcUZHeXplMVp2MXh4VGwzVldZZU1NV1JJditWQ2FoTXZzc01GdDQwOHQv?=
 =?utf-8?B?YmU4RUUwM0ExbkhoRFAzRXc4NWovUlgza1lpdG1pM2x4NFNsMnc1QjE3RE03?=
 =?utf-8?B?T0NMVTJ1VFc5disvSXd4VzJrN01TZ0V5ZjA4STNBOHVHSFZMZ3RNb0NRSVMw?=
 =?utf-8?B?aklFZnJNb01vRXh1eHdvOXBUSmgxNHpLQ2xjdzFKVFBGSVphbjJyM3FwMm5F?=
 =?utf-8?B?dVdlZTM5c0ZFUmJyM25PSDJTR1MwU3ludm9QWkpPVHM4Q1ZFaExSRHFEbVZM?=
 =?utf-8?B?Qm1wVzA4d1NqaEh4Zk5TN1RvSlpZMmVZN1JLUVVjSGpIc0c0ZVYyVWxCVWZj?=
 =?utf-8?B?QmEyWnEwUGxxbVhMRm1mQzV1TFJ1RlZDVjZ4QmNwOEpYTjY1cHNCaFpLNDR3?=
 =?utf-8?B?TGtkSzloTXdYTVJscm56ei81N29mdGVVWnRTYW5DSGRRejhFVUFoNEdVSnMz?=
 =?utf-8?B?SldaaVJ2anRvaEYwa2FWc3ltMEdTYTUwaEc1NnJ4Uy9KWCtCbm1aYlRaVktK?=
 =?utf-8?B?My92RXBsTzBycjdtcFpjd1NaRUNFV1lBTCtGOEFFTGtBb1VhN2RJWCsyazhK?=
 =?utf-8?B?Wm1IbnF2V0ZXbzRaSGljbUJEK08zc1hnYzFzcFQxWVUwenJLRklJejZZTVh4?=
 =?utf-8?B?RlFpQjVqV1NQSzJ1dXlwZVIrVEJjTTFuZUFCQml2azZIODRaWkQwUTQ5WmRo?=
 =?utf-8?B?OWowS09ncFBCbkcxVjh4RFM1TGhDWW94NFYyWVNYYk8yU2V0RVYwNHNoL0ox?=
 =?utf-8?B?UWdrRERhZ0F1SWUxVy9aYlBtNkVkeU52MTl0aTEwdVBIVUowWDdaYUVaa2Za?=
 =?utf-8?B?SGE0b0pMRTIxQ1VONmpxbHlQZVowckNhdS9BRUdvOCtnT1V6amJ4NTFGc29W?=
 =?utf-8?B?ZGhLeVFHR3A5OVRISmZiaVRMbDVmQk15YW1kVkZlOHpsRFN1V3B2dU8zOHJj?=
 =?utf-8?B?M3BtMGsvZ3UyRTNyT21BVWJ5OW9wT3pyYys2ejdvejN4cW1IVWxFdXpDdCtn?=
 =?utf-8?B?MVNQdjNhL25SaERYbjJUbndSY3JUdWgzMHY3ZlR2bDFMUjNLelhEbS9kQmpz?=
 =?utf-8?B?SXFycVBxUUdVeHVDcTdndDhEYmp2MUpkdFVXK2RoWkY0dWhzMzRCdTRSWmJw?=
 =?utf-8?B?UDdtbDAwRlFHdko4ajlCY3NYMk5SbURmcHA4ZVVDaFlHMjFMdlN1SEJWS1RI?=
 =?utf-8?B?UmphZmpFNDlmMnhJMGtuZGs5ZHlxVVc4NlA3b2J0V3BMd2Q1bXozankyOUU2?=
 =?utf-8?B?VEdHdk93LzBGcGNZVWJUSGptZ3c2d2VMeDNOcHRwSUU4c2VZV2hudTNsRUl2?=
 =?utf-8?B?bGY4ZmR6VzIvWlJmTGdOcXBMTllPZElNNXRpL1FoSC8rbzRiTVg0ejNyOXln?=
 =?utf-8?B?UHJUSkIyZk9KTmJLOWVKbEFoQWRVN2x1eUYwM3Vvb3ZCSUtISGF4bkZRZkJS?=
 =?utf-8?B?YWtlNXk4QUMwWElPMVhlWTY4bGtVb1FCd0RndWpTMFpZaU5wZXpENEVrWjJT?=
 =?utf-8?B?Tk5BMDdJQlhmNkpEd3Q5THIvZzA0NW1OeTV4bWtoZkpIWVRpbHFSS1htTzli?=
 =?utf-8?B?MEdPL1IzaGo5NzhBWHV0WE55eXZsaHlQWGtvRGlLU3R0NDJWb2xEd1RzM1Zw?=
 =?utf-8?B?UEkyVVFoS1UwUUhMbkZrSnRQWlRjbmp1ODNxcVQ2Wld6K2o1dG9Xc29MN2xv?=
 =?utf-8?B?VFhMeG9QR1FvQWlRaDRLQjVtUm9FM25Tbnl4SXZjeExFMXNtekNKRzh1OXpu?=
 =?utf-8?Q?cbOs6cuAOB8TOek8PeXCuPw=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edd99f38-3318-4bee-c656-08dd5513678b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 20:39:58.6379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KKIPPBNzEc+FmjE2TWTVvWse2+EdmRhNaK5YfE3Gm9IgWB/0ALKG58pm+dOqUFekeQ9CoMl689+5b5HeKVjkTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4440
X-Proofpoint-ORIG-GUID: PhrpjHnU1W8__Diayt7b3UVZ1wjD9wn1
X-Proofpoint-GUID: PhrpjHnU1W8__Diayt7b3UVZ1wjD9wn1
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F8B3A4A4DA55E44B6B1A80C3F5429C2@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH v3 10/9] fs: Remove page_mkwrite_check_truncate()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_10,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=971 lowpriorityscore=0 mlxscore=0
 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=2
 engine=8.19.0-2502100000 definitions=main-2502240129

On Mon, 2025-02-24 at 20:19 +0000, Matthew Wilcox wrote:
> On Mon, Feb 24, 2025 at 08:11:20PM +0000, Viacheslav Dubeyko wrote:
> > On Fri, 2025-02-21 at 20:45 +0000, Matthew Wilcox wrote:
> > > On Fri, Feb 21, 2025 at 08:44:19PM +0000, Matthew Wilcox (Oracle) wro=
te:
> > > > All callers of this function have now been converted to use
> > > > folio_mkwrite_check_truncate().
> > >=20
> > > Ceph was the last user of this function, and as part of the effort to
> > > remove all uses of page->index during the next merge window, I'd like=
 it
> > > if this patch can go along with the ceph patches.
> >=20
> > Is it patch series? I can see only this email. And [PATCH v3 10/9] looks
> > strange.
> > Is it 10th patch from series of 9th? :) I would like to follow the comp=
lete
> > change. :)
>=20
> It's a late addition to the 9-patch series I sent a few days earlier.
> It's unusual, but not unprecedented.
>=20
> I set the Reply-to properly, so mutt threads it together with the other
> messages in the thread.  Lore too:
> https://lore.kernel.org/linux-fsdevel/5c1ed8a12c92c143e234a59739af3663e98=
98ec1.camel@ibm.com/ =20
>=20

I see. Thanks.

> Does IBM still make you use Lotus Notes?  ;-)

Luckily, we don't use the Lotus Notes. :) Otherwise, it will be impossible =
to
survive. :)

Thanks,
Slava.


