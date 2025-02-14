Return-Path: <linux-fsdevel+bounces-41744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A492A365FC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 20:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DBB53AE5E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 19:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34280198A0D;
	Fri, 14 Feb 2025 19:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Cn/+Z5So"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CCE18B460;
	Fri, 14 Feb 2025 19:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739559945; cv=fail; b=FUIMqPi1ZFutAlB5RSyj7dR87Sr0nOoKqTP/+3oj/08P+wYgCJXglnQIgQOhVwcqFNfGWmqzDT2/aCqloA2KBgkxC/XRXaekmyA5PxV6EnK5Q40NXbHBtRIh5Kca4N06YOO5sk0ZycIN2WR8Qlj0JZjVaMDvRt3iCQfeKGPSU6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739559945; c=relaxed/simple;
	bh=+d2ROFyRREsi9W3DkVY1ZzPUue4TMJyG8bITbQrFjFo=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=cajGC76rtnTRQMGzdeOOotwz2tmZeihK3hNxUpSJwTjU/H/N9sxwUyGuAaURsKuPGpEn962zHPXBKIbNmn+n1VWhJ992oVmuTUM7mf2/ebVTmXWDyPe8bEBp8wYkg9LF1Hogru/SKuuP8bItKcvAbA8E2GoyIqX7zJbsxqCLybw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Cn/+Z5So; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51EHGked026046;
	Fri, 14 Feb 2025 19:05:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=+d2ROFyRREsi9W3DkVY1ZzPUue4TMJyG8bITbQrFjFo=; b=Cn/+Z5So
	MQ7bkWwhvoPCgsqmRhX/675Ba/ZNkq7Xhsb0uiT6FqL8Nt1+qsPn0UahSt5QKB57
	gPeqasgGqf8NN1K0e3f7R1WfeIxDJoc6g9tJpgtATlRAK1I6dSwfDaHJF20zD/cd
	Sxy3ZWo29JTba+jCqkNl7uwOkdt0/y8Z9v/bYSQmmMGFN0r/mMUxdkh/mzIjMC/3
	DiSnihMp9GjPmR9SwDEsdXjwSZcYbzhMgT2N3ubcKTi7mX/UREZr7jQuJgcBbESp
	z1O8yORgefQ54dSzXiOi5TjgKmo4c/9LYsu18vo38lL3D7ITI2wA1gHTjlQejNoH
	JFkM8EZbA7yloA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44t1hpu7tp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 19:05:34 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51EJ5Esf022213;
	Fri, 14 Feb 2025 19:05:33 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44t1hpu7tm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 19:05:33 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oneG1TOCYSh2bAg3OJGvtyF0tOZJ4uOq0B77YgymYfiCm9JPKiUD3mgMZmCxtTp8x7i2L/c/Ec6ykefjDcyz0j23JQ0zXrGWkx0WIBLAgen3zLepBBwjfaOHB/DnISX6GUZmNLQFcBGNNH238l18XiootrDBpbwQKz0WJajQNxC1QCO+nyvTc2Fyd6KPL73NG8LFmrMd21wY4kjC4IG364LqbpYTceeFm7SMw8EfbZr8muducFi+AWCm4Dtmwydd6BQXFEbtazq7IJZ8kCmj5FSLrsv9xjK+122L0poyJq5kGfVMR0aRqreYYQzeooXqU1x9a2yv0DWy882pNGHlow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+d2ROFyRREsi9W3DkVY1ZzPUue4TMJyG8bITbQrFjFo=;
 b=LODckNrzeaxTqB/fU0Gdl1NznEIEV/ClRg2+qVUnSMYP0EnxrOiH2I0qqu1ugyYvyizYGS3GD/OXl///LQAvrSttyAkTE5A9jFTqtXj8mya0impDdn1uq6rOXiGjqL3flOMf5C8d2g3uFvIHoXlkltwsLQfSrO+Cd1/5VIe39/wPMJMv2NrDml4Ojjjg/DDj5io2soTs52bKxE5FBhvJRPkbboDjmY+n8gR/93+/uL4DMpz3edTQuZmdeXbbS0dgNhJgdNIEvvO5H4CWK2LpArAcHvBDuptxpBiWG8N+39QNlu3h+q7dMHzfbZtvsYQsQdY7oGhcKwnguxKtZ5fjYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by BLAPR15MB3825.namprd15.prod.outlook.com (2603:10b6:208:27c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Fri, 14 Feb
 2025 19:05:31 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%4]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 19:05:31 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "idryomov@gmail.com" <idryomov@gmail.com>,
        "willy@infradead.org"
	<willy@infradead.org>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        David
 Howells <dhowells@redhat.com>
Thread-Topic: [EXTERNAL] [PATCH v2 3/7] ceph: Use a folio in
 ceph_page_mkwrite()
Thread-Index: AQHbfvkm9YQDHvIicE+6H5vxvFvTqbNHKOIA
Date: Fri, 14 Feb 2025 19:05:31 +0000
Message-ID: <4271daef2c03c497ba305729989bc2ba2d6e0576.camel@ibm.com>
References: <20250214155710.2790505-1-willy@infradead.org>
	 <20250214155710.2790505-4-willy@infradead.org>
In-Reply-To: <20250214155710.2790505-4-willy@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|BLAPR15MB3825:EE_
x-ms-office365-filtering-correlation-id: 49d5cab0-3666-449c-db4c-08dd4d2a8d5a
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d084SkNTNXdZMVh0RHMzWWpKSVVyQ1o4N0NpNWlTN1A5ZURHcTluWTBhMlpF?=
 =?utf-8?B?bmtnUE9HMlNmditjV1QxMUZ4T0QrTjNtY2p4cjdJdjRUNHR4WFFCbEdTcVZ3?=
 =?utf-8?B?ZVp2Sitwd25IRmphVTVkODBWbHlKWmFNUHpvR2JBenM2d012eWZQcGd0dG9Q?=
 =?utf-8?B?SEJDWXlEQTBpU0FWcUpWUUdzMCtXZDFnbTA0T2QxcUgzTDJHZStBa241R052?=
 =?utf-8?B?OVp5cXRsOTltQjdZWDlwUlh3T1JFcGxpSjdLamtvYUxNVk9TeTRhMUtaVlBN?=
 =?utf-8?B?eXlpWUpha0tVTTlLeEE5clpXSFArQ2YzYWFCRXI3MEVkU0U0emJmWGZtNG5O?=
 =?utf-8?B?WWdkR2J2MDBOc1FEZ0ZvSGlWYTB5eVR3TFBjMGE3OC9iVFhRNlhRWWJoZktj?=
 =?utf-8?B?K0lsVFVBZTJneDQ0ZVVkSWNMamVMQTVCVlBNRkszTEVPN2xBN1UxZEg4dWRX?=
 =?utf-8?B?cGtlRVpKVmFHbnZrbWxQalhxUEs0UjZrRm9qYTcvSXFWUTVIdkt5c2xzb0E4?=
 =?utf-8?B?ZFdybkx3OE5QV0U1bzh5ZU51TUJUbjBQMmZ4a0x2eGdpR2x0NFVkaWZQRjAr?=
 =?utf-8?B?SXVvczZEKy9pSHNEWXJFWWlPcFA1bEFLR1FuOFJEczBtR0lXbTh2TzZHZzlD?=
 =?utf-8?B?N0Y5Z21aV0xMNjlGRzlFZ1VwWnl1NXVaaFdrVFQvT0Z3R3VBS3E4TnVKM2xk?=
 =?utf-8?B?Y3hlSzI5WFRRcjliSWo5cUlNdkRZL09wL3JBZFpock1aZE9pelEySUtyQnZq?=
 =?utf-8?B?ZUZROEhNaE1UVjZNa2s4KzVNOS8wVlJxTWJ5TzVqZ29rQWNuanZWbDdjUVFQ?=
 =?utf-8?B?QllQNldRMEZMcG1UNlFaV3M3NGlySGZJM2FJaThCWEhNcGlWRy9JcXh2YkVS?=
 =?utf-8?B?WFVhMmtKVml2S0IxSVd5RHlXM1E4cEtrd25TdVFyYzhLcWt1V215UmNPOVVH?=
 =?utf-8?B?L0txU3JvdWJHeE92c2V5N1BJNjF0by83YzFJT0hxM25waTJNNzF2UHRxeEVW?=
 =?utf-8?B?ckMzcEJyUVVPTjV1aUV4QWFHRUJ4MXM0VXNZKzlISjZpMTh1VTBBTEFnaVJS?=
 =?utf-8?B?eCt1THgvQWFJL1ROaThmR3poMGozSUZLV2ZrSHpOM0VibmRJV2Juc1pKVUtz?=
 =?utf-8?B?ZlV0YVRod1JYMzUwVVlGbElZcVBZaUQ4dEJHMklCeFVockNKc1hRakVTaXZj?=
 =?utf-8?B?bmdidDNiY3huL2IwTUJ3Z3V5Q0xZK2w5d1hia1IvY0RHVWNYYlJtZWtLOVdG?=
 =?utf-8?B?UVFBNm4vTlNVRmgrS0xZNmlaQ3lQelM1bkIyTXBPeTNMakN4bzRZOVpmckph?=
 =?utf-8?B?N1ZFc0xQdkpadHl2aGIvT3l1eFgrcWd3TGVuaUZuS2lmV2swcmR1Vmgvcjgr?=
 =?utf-8?B?djhUY3E1dXJoTUhVKzJtSUtYaEMySHFaWjlVS0k4dkxoNHBLdGRFTlhBd0U5?=
 =?utf-8?B?My9yWVo3b1pFeEljOStkSUcza1BKT3VZbHZKU25TT2NBOTVQaVQwaEdLdXBZ?=
 =?utf-8?B?cVg0MkFORlBMMkNhakl3VjgxTXRveS9vQVZBc3pDUzBPY2RiTzZlbEM5YWkw?=
 =?utf-8?B?RUVENlI2Nm9vZGcrUnppMUczeXlkY3lwTjh1QzZPVlBrWjdsbjdnWkdIR0NH?=
 =?utf-8?B?N1R0Y2h0OE10aklzNFM3eTE2RHhiTmJGZWVtUlE1bVVZblB0d1g2MFFmNVNS?=
 =?utf-8?B?WC9PWUxWUzdyNStmT2dXdEVPYUxaNFNKc05haE1XRjhjZDdneldYRHZXbW5N?=
 =?utf-8?B?Rnl6SUFtRXcyR2VmUHA5eHpTYUdUK3hCdVBObXNtSFkzaGdlWlovNEVWZlZG?=
 =?utf-8?B?TjNsUkw3VGZOb3Zoc21kR0M3ZXFoWEloaWo4VGJNQkg2RGVyTks1azJCd1cy?=
 =?utf-8?B?WjNqT01WVmsyRi83eEZBSzNEUjVyQlZITU5uN01EaXVFbWpjM0k5Q1BRcHVW?=
 =?utf-8?Q?vaHaYUJ2R3UUxIfERoHu79vsx5Ixmt44?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eHZVc3NRNEZxVVY2UHVzUzFMcG9SV0tQUGFKdmV4N2tJejErblNmRU02Mis2?=
 =?utf-8?B?NGJUTkVjTlA3eDR6aW1UeXpTTCs4L0F1Qm1YTTFQbkM0dmVsaVdaTUNxUWF2?=
 =?utf-8?B?U0liSFE4RUV4cFdpaVRhNG9uVUxpcEJ5N0NLSmV1L1hKUzR1S1hxcEFhYTdr?=
 =?utf-8?B?cEtqa2twSHZJS1ZJOEpHblUySlpUbVRIZFV0aE5FVzJZcDg5U0k2d2FmOVpT?=
 =?utf-8?B?WDlsVlZzODQ3ZlJuVzVsRGkvUWhNLzQzallDUzJWV3JUWXlnaUtsV1loZHIz?=
 =?utf-8?B?V3lDdkFHQitNNCtWeFJUQXZnam1jSTIyWFRZN3lYV0FyOEM2Y2tQQ0VLVG44?=
 =?utf-8?B?T2xVT2NUMElOdTdQamNxZVpWQ1IrYkZiaGRpc2Q2dUJOc3cxSWRKVVZPU3B2?=
 =?utf-8?B?a0ZhczNPSEZpMVZyK0FMN2tLeWR0WVYrbzc5ejR2S2xnUHRWMXNpbkMzRHoz?=
 =?utf-8?B?ZUJrbWpiUDRvYmpOR1VuQmxScEE0ZzhydzBMc2hCM1l4Y0xFeG5TL2cvSTBX?=
 =?utf-8?B?MERTRVVtWDczS2YrSVpZajdja0JOajlCQWVKVlY3STBUaHVkbVFIQlFodUZ3?=
 =?utf-8?B?RzZUdmIvTjZZdG1jeWRjeEYvM0dZQzRXeGJXT2NJenpuMUVudzdpOGtvelor?=
 =?utf-8?B?b0RhUVArYmFqVkFXUkVMakN2ZnhHOTUyejhQWG5OR2Z5UFhqV3Y4azhoSE9G?=
 =?utf-8?B?d01Oay92UUxxc1F3cjNiZmZZYXJkeksrWERVLzloWXZqbFl6MzRhVHk2dHpp?=
 =?utf-8?B?RWhrOHRHaFFpUFZDd2FEU3BBczAwQUdXTFMwSENkNEdQeloxeUg4K3NyVjZN?=
 =?utf-8?B?TzRrWW41YWc5Tmd2ZmZBRmVtdVplL25FY0lVdjRKODhKRGFYVGNhWUpxejhZ?=
 =?utf-8?B?bkY5TWkyYk9IdCsxc2RWWG8yb0U4MGVBL0FIYmtyRkpnNE9YMUM4NnBObFh6?=
 =?utf-8?B?dldEZWpBV25sY2VUVlpQcjlBT3dNNFhGN3Nha2hBc3pYYVZ6MTdlQ2dIb01v?=
 =?utf-8?B?eEFiK3YxK21HZC9tdG53SkpRNGxnVXFrYjROYnN1MXlXSERLcEZSUjdmSm1H?=
 =?utf-8?B?UmplcStVdWRJOFBHQWR1QTBHSjVvbkMvRlFRODgrSTR2MTQrdi81U2ttWG5u?=
 =?utf-8?B?TWdvSTZ0OFUwUkZIRlA0QXBCWkF6NjBJV0hxeGh1eDhEdk9xVkZ1M0JJdGZ6?=
 =?utf-8?B?Y1lESERDclUvU0EwU1JXd1NJdk9YVkE2NkpnK2VZaytmZDBKMkZwUDBPbXAx?=
 =?utf-8?B?Y3FyQnlVZHFyMEpka05BV1hoK0FGeUJwQ0NwM1hRUWZCbGVVajVqVTNMY3ZF?=
 =?utf-8?B?aFlVR2wxWDFsOWlDUHdHOGJmdUhKTW9xbjBSekZycGVnYTU3b1dKQWYxVFha?=
 =?utf-8?B?bGorK2g5VnBaV2l0OUdDYm9BVnVyTE5IMlpHd2xsZE9CZXFNMWVtS2Jrb1Fo?=
 =?utf-8?B?ZkxWWmJJWFBia0JqczNUVlQ2Z2lHL1dPWE9DcnVpM1lvR0NJTk9OSEZsRWov?=
 =?utf-8?B?RXc1UGVLY2hOS2ZYMytQQlJQQkorclVDSGZ3cXVLZkRFVy9US3VTZkhuS2Zk?=
 =?utf-8?B?eUFtbU9Ydmk3MWpNT09sUk5wd0UxNkVhVTBnenJVV2U3WTVHMnZXdEFkVmpj?=
 =?utf-8?B?WUFJeEFoQUhtMENnQ05NZU4vV2tGQTRCUHVmM1crL0xLQ0FDbUg4UllNODBS?=
 =?utf-8?B?K1pQcGpnQXFkQXNVUVdFb2lZMTlkYkNCcGI0ajNySmpieVRaMU1HMWpBQlho?=
 =?utf-8?B?dlB5a3BtMGNoMVIrd0NiUkM5UGVxNmVJRmhqOTloaTJpaEYyazBsVEJlVVdw?=
 =?utf-8?B?aDY1WG1qSk9kS3lhQUcveHlFS1Zxa0JFdW1iRHBBcmZiM1pLSzlQM2prYTdk?=
 =?utf-8?B?SXlZNUJzUlBGcURzOGVrTnNMakZ0eGF4WXRIbDdjVWlkL1M0M3JuTGJWRWRL?=
 =?utf-8?B?b3dINnJKVnBlYlh6S0tjT2xoUlMveXgvME1aYU4zbHBLc1BJZHh3bEZpV2dJ?=
 =?utf-8?B?UDAwem44WE51SlY3UnFyb1NyMTJxK3dGcWhWMlFRaFVUWmpwVDhUMzdjV29y?=
 =?utf-8?B?RklSdUl4dm5tQ1gzcldGUU9HeHlqUHdkWWdjRTdMYmJaTHB2QWZ1OWM2WG5v?=
 =?utf-8?B?dW1uK0Z0MWZ4amU4Z1VqTFBYTDZKakcrSWxUNnArSUhzQVl1ZFNKa3psdDBo?=
 =?utf-8?Q?fFiDIzLUHXcrJbEVUrCe/RY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5D86A5A16AA04468A2AC8332C6C8964@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d5cab0-3666-449c-db4c-08dd4d2a8d5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 19:05:31.1556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MeVYQBLagTnSV0awgWwDE1Q5M8PyQN4BRBYCEvbrKz4v3q8K+Au3kr6MIdRRB8s3nDAlQvhuZjDHhooi8Qz0Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3825
X-Proofpoint-ORIG-GUID: JPXEX3D8WcmbZe6t62qGdwX6WgPM_I1k
X-Proofpoint-GUID: EyOeo5WLWmWkhNAlpZPTkwBnN1bxS4Is
Subject: Re:  [PATCH v2 3/7] ceph: Use a folio in ceph_page_mkwrite()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502140127

T24gRnJpLCAyMDI1LTAyLTE0IGF0IDE1OjU3ICswMDAwLCBNYXR0aGV3IFdpbGNveCAoT3JhY2xl
KSB3cm90ZToNCj4gQ29udmVydCB0aGUgcGFzc2VkIHBhZ2UgdG8gYSBmb2xpbyBhbmQgdXNlIGl0
DQo+IHRocm91Z2hvdXQgY2VwaF9wYWdlX21rd3JpdGUoKS4gIFJlbW92ZXMgdGhlIGxhc3QgY2Fs
bCB0bw0KPiBwYWdlX21rd3JpdGVfY2hlY2tfdHJ1bmNhdGUoKSwgdGhlIGxhc3QgY2FsbCB0byBv
ZmZzZXRfaW5fdGhwKCkgYW5kIG9uZQ0KPiBvZiB0aGUgbGFzdCBjYWxscyB0byB0aHBfc2l6ZSgp
LiAgU2F2ZXMgYSBmZXcgY2FsbHMgdG8gY29tcG91bmRfaGVhZCgpLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogTWF0dGhldyBXaWxjb3ggKE9yYWNsZSkgPHdpbGx5QGluZnJhZGVhZC5vcmc+DQo+IC0t
LQ0KPiAgZnMvY2VwaC9hZGRyLmMgfCAyNiArKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2ZzL2NlcGgvYWRkci5jIGIvZnMvY2VwaC9hZGRyLmMNCj4gaW5kZXggOWI5
NzIyNTE4ODFhLi5iNjU5MTAwZjI5MGEgMTAwNjQ0DQo+IC0tLSBhL2ZzL2NlcGgvYWRkci5jDQo+
ICsrKyBiL2ZzL2NlcGgvYWRkci5jDQo+IEBAIC0xNjk1LDggKzE2OTUsOCBAQCBzdGF0aWMgdm1f
ZmF1bHRfdCBjZXBoX3BhZ2VfbWt3cml0ZShzdHJ1Y3Qgdm1fZmF1bHQgKnZtZikNCj4gIAlzdHJ1
Y3QgY2VwaF9pbm9kZV9pbmZvICpjaSA9IGNlcGhfaW5vZGUoaW5vZGUpOw0KPiAgCXN0cnVjdCBj
ZXBoX2ZpbGVfaW5mbyAqZmkgPSB2bWEtPnZtX2ZpbGUtPnByaXZhdGVfZGF0YTsNCj4gIAlzdHJ1
Y3QgY2VwaF9jYXBfZmx1c2ggKnByZWFsbG9jX2NmOw0KPiAtCXN0cnVjdCBwYWdlICpwYWdlID0g
dm1mLT5wYWdlOw0KPiAtCWxvZmZfdCBvZmYgPSBwYWdlX29mZnNldChwYWdlKTsNCj4gKwlzdHJ1
Y3QgZm9saW8gKmZvbGlvID0gcGFnZV9mb2xpbyh2bWYtPnBhZ2UpOw0KPiArCWxvZmZfdCBvZmYg
PSBmb2xpb19wb3MoZm9saW8pOw0KPiAgCWxvZmZfdCBzaXplID0gaV9zaXplX3JlYWQoaW5vZGUp
Ow0KPiAgCXNpemVfdCBsZW47DQo+ICAJaW50IHdhbnQsIGdvdCwgZXJyOw0KPiBAQCAtMTcxMywx
MCArMTcxMywxMCBAQCBzdGF0aWMgdm1fZmF1bHRfdCBjZXBoX3BhZ2VfbWt3cml0ZShzdHJ1Y3Qg
dm1fZmF1bHQgKnZtZikNCj4gIAlzYl9zdGFydF9wYWdlZmF1bHQoaW5vZGUtPmlfc2IpOw0KPiAg
CWNlcGhfYmxvY2tfc2lncygmb2xkc2V0KTsNCj4gIA0KPiAtCWlmIChvZmYgKyB0aHBfc2l6ZShw
YWdlKSA8PSBzaXplKQ0KPiAtCQlsZW4gPSB0aHBfc2l6ZShwYWdlKTsNCj4gKwlpZiAob2ZmICsg
Zm9saW9fc2l6ZShmb2xpbykgPD0gc2l6ZSkNCj4gKwkJbGVuID0gZm9saW9fc2l6ZShmb2xpbyk7
DQo+ICAJZWxzZQ0KPiAtCQlsZW4gPSBvZmZzZXRfaW5fdGhwKHBhZ2UsIHNpemUpOw0KPiArCQls
ZW4gPSBvZmZzZXRfaW5fZm9saW8oZm9saW8sIHNpemUpOw0KPiAgDQo+ICAJZG91dGMoY2wsICIl
bGx4LiVsbHggJWxsdX4lemQgZ2V0dGluZyBjYXBzIGlfc2l6ZSAlbGx1XG4iLA0KPiAgCSAgICAg
IGNlcGhfdmlub3AoaW5vZGUpLCBvZmYsIGxlbiwgc2l6ZSk7DQo+IEBAIC0xNzMzLDMwICsxNzMz
LDMwIEBAIHN0YXRpYyB2bV9mYXVsdF90IGNlcGhfcGFnZV9ta3dyaXRlKHN0cnVjdCB2bV9mYXVs
dCAqdm1mKQ0KPiAgCWRvdXRjKGNsLCAiJWxseC4lbGx4ICVsbHV+JXpkIGdvdCBjYXAgcmVmcyBv
biAlc1xuIiwgY2VwaF92aW5vcChpbm9kZSksDQo+ICAJICAgICAgb2ZmLCBsZW4sIGNlcGhfY2Fw
X3N0cmluZyhnb3QpKTsNCj4gIA0KPiAtCS8qIFVwZGF0ZSB0aW1lIGJlZm9yZSB0YWtpbmcgcGFn
ZSBsb2NrICovDQo+ICsJLyogVXBkYXRlIHRpbWUgYmVmb3JlIHRha2luZyBmb2xpbyBsb2NrICov
DQo+ICAJZmlsZV91cGRhdGVfdGltZSh2bWEtPnZtX2ZpbGUpOw0KPiAgCWlub2RlX2luY19pdmVy
c2lvbl9yYXcoaW5vZGUpOw0KPiAgDQo+ICAJZG8gew0KPiAgCQlzdHJ1Y3QgY2VwaF9zbmFwX2Nv
bnRleHQgKnNuYXBjOw0KPiAgDQo+IC0JCWxvY2tfcGFnZShwYWdlKTsNCj4gKwkJZm9saW9fbG9j
ayhmb2xpbyk7DQo+ICANCj4gLQkJaWYgKHBhZ2VfbWt3cml0ZV9jaGVja190cnVuY2F0ZShwYWdl
LCBpbm9kZSkgPCAwKSB7DQo+IC0JCQl1bmxvY2tfcGFnZShwYWdlKTsNCj4gKwkJaWYgKGZvbGlv
X21rd3JpdGVfY2hlY2tfdHJ1bmNhdGUoZm9saW8sIGlub2RlKSA8IDApIHsNCj4gKwkJCWZvbGlv
X3VubG9jayhmb2xpbyk7DQo+ICAJCQlyZXQgPSBWTV9GQVVMVF9OT1BBR0U7DQo+ICAJCQlicmVh
azsNCj4gIAkJfQ0KPiAgDQo+IC0JCXNuYXBjID0gY2VwaF9maW5kX2luY29tcGF0aWJsZShwYWdl
KTsNCj4gKwkJc25hcGMgPSBjZXBoX2ZpbmRfaW5jb21wYXRpYmxlKCZmb2xpby0+cGFnZSk7DQo+
ICAJCWlmICghc25hcGMpIHsNCj4gLQkJCS8qIHN1Y2Nlc3MuICB3ZSdsbCBrZWVwIHRoZSBwYWdl
IGxvY2tlZC4gKi8NCj4gLQkJCXNldF9wYWdlX2RpcnR5KHBhZ2UpOw0KPiArCQkJLyogc3VjY2Vz
cy4gIHdlJ2xsIGtlZXAgdGhlIGZvbGlvIGxvY2tlZC4gKi8NCj4gKwkJCWZvbGlvX21hcmtfZGly
dHkoZm9saW8pOw0KPiAgCQkJcmV0ID0gVk1fRkFVTFRfTE9DS0VEOw0KPiAgCQkJYnJlYWs7DQo+
ICAJCX0NCj4gIA0KPiAtCQl1bmxvY2tfcGFnZShwYWdlKTsNCj4gKwkJZm9saW9fdW5sb2NrKGZv
bGlvKTsNCj4gIA0KPiAgCQlpZiAoSVNfRVJSKHNuYXBjKSkgew0KPiAgCQkJcmV0ID0gVk1fRkFV
TFRfU0lHQlVTOw0KDQpMb29rcyBnb29kLiBQcmV0dHkgb2J2aW91cyBtb2RpZmljYXRpb24uDQoN
ClJldmlld2VkLWJ5OiBWaWFjaGVzbGF2IER1YmV5a28gPFNsYXZhLkR1YmV5a29AaWJtLmNvbT4N
Cg0KVGhhbmtzLA0KU2xhdmEuDQoNCg==

