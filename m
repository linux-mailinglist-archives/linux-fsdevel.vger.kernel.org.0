Return-Path: <linux-fsdevel+bounces-70374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D20C98FEB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 21:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 05F3F4E257A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 20:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4100262FC7;
	Mon,  1 Dec 2025 20:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iX27i3Tb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDC6A937;
	Mon,  1 Dec 2025 20:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764620422; cv=fail; b=mxRMM7AnsVOWpWLuDybxyMrs6QryLyXUC4g2jAJdwRRuZcy9CMzEQ6+mWMGq+SswXOZkaD3kgJBNsqNWMpRICxrLjHqwNWOZ0TWgjuplNgPl0A4aMw6IQf2x3CWzfPLyZREX+DRkdepvBMx4nNsvpUYGfZ9y2E403h2VaKZPmmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764620422; c=relaxed/simple;
	bh=19dW5HrUYSZR92jbbEfMd7Zwrk1H+AyssjKsWhzlWeI=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=Sd8G6gzSzZ6jYDxv+UKIyyW+2o3mwle9uW+vRVmi7oZ9HJMCv/vwit5E5ttWbOacqqb2yD5bJgaANIkd9zKc6jBbmru2HuQjqe4oUYRAtcDuIfB14/bF4TfVwHsRlqs/H/8MjrlvaVRQMj2XpQQrwPoqnuNiToe4k7CD5dWmEf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iX27i3Tb; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B1BxrbJ008442;
	Mon, 1 Dec 2025 20:20:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=19dW5HrUYSZR92jbbEfMd7Zwrk1H+AyssjKsWhzlWeI=; b=iX27i3Tb
	3YrtYiIkRey7QT3WE0YTvpKT4AcN4OovPjWcyjD0PJPsYRbUD23KSxjj+lzw4Tm8
	R5DXYPf7sd9dcnadFo1W6/Or1D5FR+ZW9NucXQ8G0ewD7zgzW2JJuGoy+tzjVuG0
	5TvJRULpmwHEJbRE06GPdeXsYxwgSJt2R8Li88VPvsOVfYeegfxnF3Udpxoyjd7f
	Fah5/MQ+W5AfKeF46NW8AASfbK1FFWEXYYU0IISF3FeOCB+ZsAoKDEjMKNOiXU1h
	FXwKu+PiI0oLKv/Zf5kdBr3P6bp2kOIyuFIwo4BS408DO81u6ygIMgqhc5AK8Y5M
	Cm5qw5IHt6ogIg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqq8uh7xs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 20:20:17 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B1KEn4v019187;
	Mon, 1 Dec 2025 20:20:16 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012022.outbound.protection.outlook.com [52.101.48.22])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqq8uh7xp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 20:20:16 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLoVGs+bkI24JjYWmfE4zIG1psNrjiLLLxnrilP7Iput2x30gJZYB8Nr2F8D7u0L+Wm8wtIVVh01Bi/iJlrP4EIPOG4ZzrkPI5tM9G29v3kibvRNeGQFaQpKNniNi0ps7vavxI3Ym9wjEcQqGw0weXDLmiMZ4voESr3mSrgMVGMysnIMrYbVzXy2a0T6orX3qPZVAiGFKGGaM0foT/+j0QK91U+fMXUaPjMzqr3DgDPtGIwRLxbBuhUyDyQG91w2Ojhz+R5TLpy+m4MxFi3d/ROAVKfPzsjnCkG1+2z/dNeQ+d7aVNGlBWny5RzrMnNcEYuQ1dF+Qf/+dlThNQa46w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19dW5HrUYSZR92jbbEfMd7Zwrk1H+AyssjKsWhzlWeI=;
 b=nb8z4Vb+MrDlzVW1qQ5KUHqR1Rm9SvvD4XtRZS8U4sf6XfbPtpBzBRLWxJphJmXZQtmopc8nEIDVbgk6KPNbtiPIy0tB7gZ8ag5VAlgN9vSDFTw/iz79DiL2JIxMyhNxLu3L4CpKsB/KCNNz0ao9n9usZos5sBehZLW9hQxlRjmu0cCBcO2jSA73/5lMKRlHUZJPtn3NrMnTS+DwFmCisPfAjqVVt/bsO9hBHjokiRlbBYj3w7FqVmqPG7vMZZtIhh76buVccF97oVonCWK7cIAtBAxPJJ52FfDDr5NUsp66J0etk5BXYXxT+gRXXzcNSThIK3mMrctYR/GwcxjGSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by MW4PR15MB5230.namprd15.prod.outlook.com (2603:10b6:303:187::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 20:20:13 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 20:20:13 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: Alex Markuze <amarkuze@redhat.com>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>
CC: Viacheslav Dubeyko <vdubeyko@redhat.com>,
        "idryomov@gmail.com"
	<idryomov@gmail.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH 1/3] ceph: handle InodeStat v8 versioned field
 in reply parsing
Thread-Index: AQHcX6RK5lplaBuDSk62a6ANpj61iLUNQIIA
Date: Mon, 1 Dec 2025 20:20:13 +0000
Message-ID: <06142f77a8091d5ed7c1523495f6e0ebb33ad83d.camel@ibm.com>
References: <20251127134620.2035796-1-amarkuze@redhat.com>
	 <20251127134620.2035796-2-amarkuze@redhat.com>
In-Reply-To: <20251127134620.2035796-2-amarkuze@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|MW4PR15MB5230:EE_
x-ms-office365-filtering-correlation-id: a9a6d7a0-a68a-48f8-8778-08de3117088c
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NGlzMGdNWFg1Qyt2ZGRNM01HUGhBQWdWMjJHNWV4aFJDYm9YM1M4R25KZjBR?=
 =?utf-8?B?eVFQSU5VWEFaM28xYWdnckllc1FhdnZCem1KZy9naHd4N08xeTJwN0VxZlR4?=
 =?utf-8?B?cXJEaWw4MFZPSUVCRWkrN1d3UXlreEg5NlFaNGpKUFpIaUp2a2xoN2MrU0pD?=
 =?utf-8?B?WVJ3TmVsWUVvcGYxS0VzRWFwTXZ5dXNDcGlPZHVmY01wOU5TdzNGRHZSbi9L?=
 =?utf-8?B?ZlRLaFBwMCtBRUR5b3lxRmQyUW1SSlNDRG01RzVYQnBpUXV3bzlJdTVVS3pZ?=
 =?utf-8?B?bVhiTUttNm1ZQTcwTWxKSDMzYUZaeWtPLy9nRmdKczE3ZkN1azh4Zk9WRUdX?=
 =?utf-8?B?TE5mMlpwQ0xCMTFVMkU0Wk9ma0JqYnMvL2pCU3FGOXBxSWJFc21QUnRHUFZG?=
 =?utf-8?B?ekprV2VHMWFiNi9tRE5EdWNjQlN2ajZLdUlWUjF2eHNMaUxXcmQ1NlNUczlr?=
 =?utf-8?B?UWlHd1pBRUVDamNUUHZaUjV0RVFWYStiaVJrTWYrL3g4c2xmdUdPU05qRHNM?=
 =?utf-8?B?dGI5c3BpblJBOUxYcWJ0dkhpY2hia2ltbFYzNnBDNVlBbkk1RTlIaG5NZHN3?=
 =?utf-8?B?QWN0TVVhQklIaHNETVdGaHZZQUFiWk9jTnlicVpZMDN4UFcvQ3J5OVdTVmlD?=
 =?utf-8?B?dHJoRW9kWHhzS0dzc2ptVHZZYll6NHdoWDA0VmdvV0tCZ2VvdExQWGxrVEpN?=
 =?utf-8?B?U2RpMlgxclBzQzhWdWxCTkFFQzNnVVhCd3l0eVNGdWE4ZjQ3OW9DYXREOU9R?=
 =?utf-8?B?bUtjRzNyV1grZmVDVGhTMVJqNlRNaTRzM2VpQkJQUllkUUN4YVE4VzhJNkFJ?=
 =?utf-8?B?ckZoaHlVNm14SEc3TDg1TmhUc0RQS3pabWppQmF4R0RHWmZxeEhBLzgyYTFF?=
 =?utf-8?B?MUozREFVRG5pcEhZNVhNUkVEeXp2V1BnSlhUNlA4UGo5cTczQVc3bnlqQVg5?=
 =?utf-8?B?Z2NNbk93Q3Zwb0VlVEY2WHgxNnFOUXRmN0g0c2ZoQlhhbUl2a213bGhEWkNz?=
 =?utf-8?B?SkZkeExna0FxVmtDbVlVb20zZEIyNjBqbUdkbVhUK3FNMERxc09YM2t1VThu?=
 =?utf-8?B?RVNPSWdQeFN0ZGFFNDVnc0ZKRCtPWmd5M2lmb2ZZK2JOVnRNdE1JT2VZUjFF?=
 =?utf-8?B?Q2QyNzZQTVFWaGJlSGNZUmJmNmZWWTNDUEhzRWV6ZGdPMDc1L3lPay93SWFa?=
 =?utf-8?B?RitScC9QMDZLM1F4TUkya3ZGN2d3QnJBZFpYK2NxZkU1WG9kelRqRmU2VzJo?=
 =?utf-8?B?ejBSZlZMMXVqR0QxZWowV0VyZS9IellEdmRaWnhHcXcyaHEvNGxCV3hMbE51?=
 =?utf-8?B?NFpRelFxNmhjcURubG0xU0IzcVU0ZHc5Ry9SOEJFeTZMcS8xdGNkVVNwT1ZE?=
 =?utf-8?B?MmRJbW5KOUxRenJacnQyRUVIeWwxZUIvLzdIcU5helhoTzR0emZ5b2Ira1Nu?=
 =?utf-8?B?cEU3VUlMQUNhUU5BcExScDJGajNDb1AxbjVrT1BPQmdmYUxIZ3BKclZKdUZR?=
 =?utf-8?B?Z3daL093NDVWZmlUb3hlNSszbkZ2ejBRV2RIVUZpaTFvbWhneHJzZ3NCT0xP?=
 =?utf-8?B?NFFaK0JVOEY5Um9JS3FKcGhKVGxnbkQwd1JQekFjcXpWVnhKV21DSDhIeHp5?=
 =?utf-8?B?SXJZV09wV1grRmFCbkRUWXN3dkRHR3ZHNE4xVjVlT3NyOHIzemdlSHV6SWhU?=
 =?utf-8?B?Um5tMWxpckY0dGp1SVh1ekpxNlFJV1FZYVhJWU1OMGl1eWxOQ2IzLzNGNkVt?=
 =?utf-8?B?bVg5WGZHblQvN0xBWVFHK0ZQNEo3OFdsd0tPNHprb2ZDWGVtTW56SjhLVVd0?=
 =?utf-8?B?ZkoyUFI3UmdMeGJLdW9lVmVLdXZSVlhMc0MwR3VqeTR0UEVhOEk3VW0xdzhY?=
 =?utf-8?B?SVFXSWlPQlNhcmpkVzNOVzRIbUhnSWlIczJyZjAwSUc0bmdaWUhObGNkSm5C?=
 =?utf-8?B?cHdUL2M3T1hEa3ppUlFOVHBaam8xMHQxM0VlQWJ5Y2k2S2ozY3ZzNXJLdDNJ?=
 =?utf-8?B?cHM4UHk2QXRQVm5mUmxnajZkMkFoMDZIZWpWeGZxSXhNVHQ3c2VCQTdNWDMx?=
 =?utf-8?Q?u3fL5K?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RkhCUmlXamRkZFNtMnJOalFSUUFRSEFzQzB0UzhjWnc1N0wyczBEMi9BL2s2?=
 =?utf-8?B?djFDdnFEY0xybnpHL3V5bFR0OWxQR2RIZ1JKWDRMUWZWNUJ2M1pERVRXa2ky?=
 =?utf-8?B?ZU9TOVZ6WitiWlRKd280b0c1OW5RUHdITVREeGpza1BJLzIyTVl4VFhrVmp2?=
 =?utf-8?B?THhYMjZ6WHdCV1VmcWNGeWdUYmNXQUU5VUo1U1Z4M2JkSHVsQ0dtdzZkTDQx?=
 =?utf-8?B?VW1GdU5kdTlHWWtjRk9XdU9zMmdyelRyV3V1OUpRd2NSOTJsMHVPV0phT2FP?=
 =?utf-8?B?QTg1QVdFdVExZFZ2TWEvWThYZGxDNDRlWWVxYXlJb2owanpYVVIzQ2o2ejZr?=
 =?utf-8?B?QjcvOUtuUENIMHJYL2hVZDVEMU54Tjd1TlhSNi81WGNTVGhwdzNMQXJ2MlNw?=
 =?utf-8?B?dytWRFRBMllQbXNqSU8yQ3JiS201MkF6YjZUNFRvbU0zdlhoeDc1eTR1SHJl?=
 =?utf-8?B?aXd6NEVlY2VYY1R5SHprRitsdG1NZVBrQlo5RHpMdlhFMDd3ODB1N3FrbUp2?=
 =?utf-8?B?dlBpbklJa0tDV09ucEV6bzR3K0pTTSs4amxBak9ta3lGOGxPUzlkVTIyeHFR?=
 =?utf-8?B?VG1acEgzM09kNEE3b3NkMmJ2emg1NUNwZG5CbUo3U3BmRkUycVZTSjhOTE5V?=
 =?utf-8?B?RzgwbThNZEk5UDJOaFA3Vks0VnBGbTNRQ2FXOVNwMzhRVjNVc0NISGNBNXoz?=
 =?utf-8?B?RjJ5UDNMdVpEcU9Dekxienltb0NoVXQ3MmxRZnozY2JUS0RyVWJaM1hQMnU3?=
 =?utf-8?B?bC85WE9vd3ZvWEN3elNjRlNCa1FUNk1ZYWE1NGZmUTJRc25rV1drblJ0RW1j?=
 =?utf-8?B?Y0c5dTNJcnN4WC9ScHNEZTA5czdmSEtndDdrdWJ1ODVaZFFNcDY4M01KTWwy?=
 =?utf-8?B?VUhVR1A1RUUxcVF3RXJudmQxQ1ZlRGI5M0E3Qkwva2JWd1FteTMyVm84UDNE?=
 =?utf-8?B?SUF5M3FURFl5Wm4xYS9UMk90NHdacjd6R25FOUxxczlZMkN2Tk5kQTNsdkVu?=
 =?utf-8?B?OHpNTHdraEs1M2JmM2lCTGM3NVhJZDlzQ3l0K3ArMTRSUjllSmJkc0g1R2FV?=
 =?utf-8?B?akUzMXIyZWhhUVhFT0o0bUpHWU03WDdJSCtTNm5jN2U4VnJDeVlyRUkrK0ha?=
 =?utf-8?B?UjN0ZTR0TDdkSWplS3FDaVhsM09yQ0xLeEI0ZkdKc1lkNjI0U0VpMjVUMnlR?=
 =?utf-8?B?NXNtZEEyNGx0MUo5VGM0cEZFdlRiQjlUaEFLTlU2U0EyNkU2V0lkak1ublN2?=
 =?utf-8?B?cmwvNHlXVXlUSktQVzIwejNGcnl1ekZzMk10RHRMNytSNXBOTVZaNHVPME0x?=
 =?utf-8?B?a1dOb1JhaFhYYmplWmVhNThqMVZ4cmdLTjhKbzBjd0NrWWo5dUE5b0ZUVktC?=
 =?utf-8?B?UytRZElSNFZUL2J3TXY5aTJ3S04rUFVUU1kyVTJJeFZNZnJrUmdzWjFmSmM1?=
 =?utf-8?B?WmJsaE5objMyd3pGaW85Q1M2QXFBVm1OQ0V1T3ViNDR0b3pwUEhSUjk2U2pU?=
 =?utf-8?B?Z3REY2xDTmJxK2E0WG9KMUNxSHBjbVFkRVNCaERhb3RzcnA3Z2NoTE51d2NC?=
 =?utf-8?B?cUJQQVdmT1BYVmlIbHphNzhTdUV4MjU4ai9TMUhFL1VKUDErc05GZHJlTDds?=
 =?utf-8?B?N0Z4WTlUZ2txZnlsOXlSYldYNDF1QzJHVDBaT0t4U0NJSjVSZm5KK3cwdXc0?=
 =?utf-8?B?MnhjUXd2c2s1b1hkZ3dIdmF2TENyV1o5RnJnMjh5RzNkL3g0RHJFVGg4UEdQ?=
 =?utf-8?B?RmJXNWtYZlNtRjI5RVdsM25uRWJOZExCKzhNY1dkeFVmM2IyRW5aeHE0WkQv?=
 =?utf-8?B?WFNqSE8vdTFtT0hwZm5nVW5JUHRxRVA1djByRVNaUU53QlN5NmIwMjQrYkpw?=
 =?utf-8?B?T1RCY2ZPYXE1L3JmS3Z2QmpwYlFiSjlkVkFPQ3R0RCtUR0RGMERxTnZBam1U?=
 =?utf-8?B?VTR1WVM3Q3ZURklpUDc3cGdqUVdlMjhqZFhHZHZDNFNUaDdIRFNYZG5GV0tw?=
 =?utf-8?B?NW0reDBwWHdGdUVvbk1mQUN2WXNvbVFYVWF1TVdBWkZKbVFCU2FVcm9sbnph?=
 =?utf-8?B?Sm10NHZ4M2NiNk02WGIzUkVYL1hKTFBEczNNbTRORDhjdmkvUWtpWnZPd0kv?=
 =?utf-8?B?QTVPVjRYM3Jwa2RXTEJmcitlN1lQMWVjaWtCbHc3VUNqTFNadTRqTk50SXJs?=
 =?utf-8?Q?asj0lFETO2ItmG+8I5IVhQA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4A9A3767F1454448CEA81B9C53D23F2@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a6d7a0-a68a-48f8-8778-08de3117088c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2025 20:20:13.0527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 75WOKnpixepQeUvUNUeexLcC15JqDCv3xdYhu2GWB/0hQNa14h7xTF0OK5tpBXS8RloQqyHxch7gFNKIzcqs2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB5230
X-Proofpoint-ORIG-GUID: NnoMtW9FXODQG4gbYfl5DqKTuE6agTy0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAwOCBTYWx0ZWRfX+h2oadIL/kE0
 xYTpAU82Fp1lYbp7VNmXbbBWnBJgekTzTcMRwDKlqHrFG7x7arcb0jThJVl2Dh63M/INpHCJAqU
 TG9exgGpWQ5lD/G5hhXZ0rIrrq3E8PciJXsA3tcK5kjC9wHmwFFOO+W/FW/G3L+7UOrD+gyV93h
 9q60Ancgj8JV00hxTZcpAkb24uX1IdimSR8i0MNS+JYOWzhdRC4083clAdNz1/DUpo0ioqLkOim
 ptjEpQtS5iH3VfPgFnbcJc6w3LtqQC0uKb7loV2a2NUKw1WyKorNJVAMZn+E76CVEnfM6oQFkse
 lEqzS2rSBEpvDBaxgbhC1HqcFsElmlDHVWmkBR+faRvDS6c8skEOYYb9VYrbbhzd/CiaNltMeQq
 ixwpWNiRvdfUElu9OKAPwwzAinHtVQ==
X-Authority-Analysis: v=2.4 cv=Scz6t/Ru c=1 sm=1 tr=0 ts=692df881 cx=c_pps
 a=WaebrhBVOVZn7IYqRlctMQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8
 a=-V6cHXUExiIFgABV_K0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: sS0OTKTHFqYOyarhKqrLs2FxyxDvhuLg
Subject: Re:  [PATCH 1/3] ceph: handle InodeStat v8 versioned field in reply
 parsing
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511290008

T24gVGh1LCAyMDI1LTExLTI3IGF0IDEzOjQ2ICswMDAwLCBBbGV4IE1hcmt1emUgd3JvdGU6DQo+
IEFkZCBmb3J3YXJkLWNvbXBhdGlibGUgaGFuZGxpbmcgZm9yIHRoZSBuZXcgdmVyc2lvbmVkIGZp
ZWxkIGludHJvZHVjZWQNCj4gaW4gSW5vZGVTdGF0IHY4LiBUaGlzIHBhdGNoIG9ubHkgc2tpcHMg
dGhlIGZpZWxkIHdpdGhvdXQgdXNpbmcgaXQsDQo+IHByZXBhcmluZyBmb3IgZnV0dXJlIHByb3Rv
Y29sIGV4dGVuc2lvbnMuDQo+IA0KPiBUaGUgdjggZW5jb2RpbmcgYWRkcyBhIHZlcnNpb25lZCBz
dWItc3RydWN0dXJlIHRoYXQgbmVlZHMgdG8gYmUgcHJvcGVybHkNCj4gZGVjb2RlZCBhbmQgc2tp
cHBlZCB0byBtYWludGFpbiBjb21wYXRpYmlsaXR5IHdpdGggbmV3ZXIgTURTIHZlcnNpb25zLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogQWxleCBNYXJrdXplIDxhbWFya3V6ZUByZWRoYXQuY29tPg0K
PiAtLS0NCj4gIGZzL2NlcGgvbWRzX2NsaWVudC5jIHwgMTIgKysrKysrKysrKysrDQo+ICAxIGZp
bGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL2NlcGgv
bWRzX2NsaWVudC5jIGIvZnMvY2VwaC9tZHNfY2xpZW50LmMNCj4gaW5kZXggMTc0MDA0N2FlZjBm
Li4zMjU2MWZjNzAxZTUgMTAwNjQ0DQo+IC0tLSBhL2ZzL2NlcGgvbWRzX2NsaWVudC5jDQo+ICsr
KyBiL2ZzL2NlcGgvbWRzX2NsaWVudC5jDQo+IEBAIC0yMzEsNiArMjMxLDE4IEBAIHN0YXRpYyBp
bnQgcGFyc2VfcmVwbHlfaW5mb19pbih2b2lkICoqcCwgdm9pZCAqZW5kLA0KPiAgCQkJCQkJICAg
ICAgaW5mby0+ZnNjcnlwdF9maWxlX2xlbiwgYmFkKTsNCj4gIAkJCX0NCj4gIAkJfQ0KPiArDQo+
ICsJCS8qIHN0cnVjdF92IDggYWRkZWQgYSB2ZXJzaW9uZWQgZmllbGQgLSBza2lwIGl0ICovDQo+
ICsJCWlmIChzdHJ1Y3RfdiA+PSA4KSB7DQo+ICsJCQl1OCB2OF9zdHJ1Y3Rfdiwgdjhfc3RydWN0
X2NvbXBhdDsNCj4gKwkJCXUzMiB2OF9zdHJ1Y3RfbGVuOw0KPiArDQoNClByb2JhYmx5LCB3ZSBu
ZWVkIHRvIGhhdmUgd2FybmluZyBoZXJlIHRoYXQsIGN1cnJlbnRseSwgdGhpcyBwcm90b2NvbCBp
cyBub3QNCnN1cHBvcnRlZCB5ZXQuDQoNClRoYW5rcywNClNsYXZhLg0KDQo+ICsJCQljZXBoX2Rl
Y29kZV84X3NhZmUocCwgZW5kLCB2OF9zdHJ1Y3RfdiwgYmFkKTsNCj4gKwkJCWNlcGhfZGVjb2Rl
Xzhfc2FmZShwLCBlbmQsIHY4X3N0cnVjdF9jb21wYXQsIGJhZCk7DQo+ICsJCQljZXBoX2RlY29k
ZV8zMl9zYWZlKHAsIGVuZCwgdjhfc3RydWN0X2xlbiwgYmFkKTsNCj4gKwkJCWNlcGhfZGVjb2Rl
X3NraXBfbihwLCBlbmQsIHY4X3N0cnVjdF9sZW4sIGJhZCk7DQo+ICsJCX0NCj4gKw0KPiAgCQkq
cCA9IGVuZDsNCj4gIAl9IGVsc2Ugew0KPiAgCQkvKiBsZWdhY3kgKHVudmVyc2lvbmVkKSBzdHJ1
Y3QgKi8NCg==

