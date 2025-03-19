Return-Path: <linux-fsdevel+bounces-44485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E82CA69AF8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 22:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 732B5189F4EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 21:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBB321ABA2;
	Wed, 19 Mar 2025 21:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lLvABFJL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A7920C47C;
	Wed, 19 Mar 2025 21:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742420081; cv=fail; b=pojTlajQdvgXjQWbCIGY7sGP77HI3sXS5z2kpMZnjxxlclFrN3k2EH1B2wSn1DrcFS8La251JTfJ5Y0oUaZFNME9/sOemXr1Bl4Xskgtw2iRT+1pxcWY0AV4SLrTQ5tvXkQfeC23mgyr1Izi1klF+ok2rUK5H7RYEZT348nXWq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742420081; c=relaxed/simple;
	bh=nufrq2RgzF5UJK8JwNZjl6UK3MqAbO5De0EknVxTsoI=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=ebboyUk5/to5ZKHpWt4xIUFZap+A1ZO05uZEg7y19MUIZ4pBUf4wXEHDw2zfF/F9shn96UYvEyz5FhxS+VpPE2kj5M+qayfvRoKEDGhxUoYkOHhxgouc3VkZe8++Wq2eSBeTHJ5CE8KeFXPooi/Og/5u2BidUCiE8/e4CFCBB9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lLvABFJL; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JLHJnM011881;
	Wed, 19 Mar 2025 21:34:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=nufrq2RgzF5UJK8JwNZjl6UK3MqAbO5De0EknVxTsoI=; b=lLvABFJL
	eEfmurcg2SZkYWn+a9leVkkhvye1UOEb8tZf4YJk3KnBCNGpZ0acFVWt0nBAqOJn
	SylOcOTcXQ7+bzYz2JJCFUEaiP/9vaqNqlf7YQQsQygSiLx1h//jhl/bHyTCfdXF
	vjhRawLu/EAtF/MOdfKKJyUY3f28nH4O50+v+lHoaEu07v92hmiZbxEYD9Uh2KEq
	FROyAof8Wcb2TZneHe5tmYPTosUw1/CoA1KnLXblnJrAc37HpMWnIb0eX+cVSFoK
	owF9LH2ixPt3jTiS2yv2V/Rlmfk6xGsFjLmCs9Z/2lu04cEKdy8E3YiOxxwIN9+U
	8fon8J1nxzy7Kw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45fwy23246-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 21:34:35 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52JLYZ3L019255;
	Wed, 19 Mar 2025 21:34:35 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45fwy23242-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 21:34:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=olEM9au9romZpL8o02Bd5CWlnlXHkE1tgVBB2WKY+Wq6YhrkY18IfXZKWdklhYa8Au8Og5O4wIwfwWKWS6n3hRouO/xJnArjNbf2tweNM+MIyshigmzY03Tv/lW3bHK91+t9KSSDYe8GIHeA/q4jCEHbZxMthU8vv1rV2yRNuxshq6IL+e3Nq+MOSInh4MHU6SkMnBA6gS8cPGgpnT3MUpU8iIX82lqIQEVPGiSED+kvBfCtLEYloiDN5xgcDA/5sS740Hmiwtcg1TJv1cdmRtJMmskmNPLU1u0s0iWEyYakr8PjiLqTbQ53ySIP2I3r1CBGFwDI6ApwVcgAH+q88Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nufrq2RgzF5UJK8JwNZjl6UK3MqAbO5De0EknVxTsoI=;
 b=rGZ8nAj1hzVJioHJ8l2Q9GYDPLxep/fb4YkHxtRa2w1/Y8RM1gaYOklQVXcvJEx6SICzjG4j7O0XR4tE5vGpKVJp1zNOc+rTumqRfhmERdQd/doWbJGx/0krPTinpx73pPnfOp7I3477i6QFEfzG10CeGSB8rKnB0aWvbAN0JGfvEVC4dcUWB0Idi9j5NV2TZ/8wgU+F68G4SdS/3mg3j412o/wMdTv7MDsLwFtusxqBiFDZXtd6zFWnZDAmpOM9lueqw6wUlJdxvPSQY+s1Qe3D9Az3iTETvCNx2JWsk5kJPH8OzgXoFA8rWZHx6grvskUqRuHChIxGgtDN5B9fZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DS0PR15MB6015.namprd15.prod.outlook.com (2603:10b6:8:158::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 21:34:33 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 21:34:33 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "slava@dubeyko.com" <slava@dubeyko.com>,
        Gregory Farnum
	<gfarnum@redhat.com>
CC: Milind Changire <mchangir@redhat.com>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        Alex Markuze <amarkuze@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        David Howells
	<dhowells@redhat.com>,
        Patrick Donnelly <pdonnell@redhat.com>
Thread-Topic: [EXTERNAL] Re: [RFC PATCH] ceph: fix ceph_fallocate() ignoring
 of FALLOC_FL_ALLOCATE_RANGE mode
Thread-Index: AQHbmOMK8qy245T8CU6mMSiSaNG1grN6+6EA
Date: Wed, 19 Mar 2025 21:34:33 +0000
Message-ID: <10a1a68cad3be55bd28f5b72a51110a00cd40854.camel@ibm.com>
References: <20250318234752.886003-1-slava@dubeyko.com>
	 <CAJ4mKGYmcJ5SSbGhEFKrTw_BJWtT1z460JMcbg++7EBreUn6tA@mail.gmail.com>
In-Reply-To:
 <CAJ4mKGYmcJ5SSbGhEFKrTw_BJWtT1z460JMcbg++7EBreUn6tA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DS0PR15MB6015:EE_
x-ms-office365-filtering-correlation-id: 84f626e1-e984-45b7-f728-08dd672dd6e9
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?azRLT1pDNjVDa0RpQmlJR3dEM2RGRTNYcmpDRXc0cHFaRFJ6aXovR2VyWURR?=
 =?utf-8?B?ZUpRaEtTTTFtcUJhcThlK1lYaUplTDdjeFlFeGxwUldPZmtTRDNtb0ZmanZS?=
 =?utf-8?B?UlpURkt0NW03aUNQODMwdzQ0cy9yZDFWMWJjSkVQaEZYNzZDdzk2QjJ2QkJ0?=
 =?utf-8?B?OFViSTg4WUJlS2Zqa3pUQnFhaEZEbUdkQittd1A5TENBaERMRGhsRzZuRllS?=
 =?utf-8?B?amhFcHlKVEdqajVqWUlLaEU1WExhcld6aHl3V3FiS3d1UkgrcmlLbWxKZHd5?=
 =?utf-8?B?cGxwcUxpc2VsL3prVXJEVmpNd2Y4cnBKMWxYKzQveEgzeEtMNktyck84Uy9E?=
 =?utf-8?B?czk3NTdZekhiTlNEa2U3ZkRibDd6Z1VrZS9yZWR4NTl2b0svT29BN0lvVmJv?=
 =?utf-8?B?d1JhZzZzUHpRa0lKVDRDcGdyVEVGaFFWZ1AwNVQ0WkVoL2dIeVhTZFlIZ3p4?=
 =?utf-8?B?VDZJSzBRWm83cjR2RndYVm9JYklodXovV1Fyb3JKaUhjZE5tTXZrR3hJeTJp?=
 =?utf-8?B?YXlFb1dBYU5zdi9xRUd0NFVCOFpUOGxRR0R5Q3h1MGNQK3BWbE4wZ00yc1Vt?=
 =?utf-8?B?MjFqcm5JZFVrdExudkVOYzhHaU1rV1FTWWZvVStuazFXcnFiYy9nN3lTT25F?=
 =?utf-8?B?S1J4Q3A1SFZxVllwK21Fdy9Dalp4djEzc0pRRzRvUnNPREl1VnJJWm4xZWtR?=
 =?utf-8?B?YmpLMENNR2RHbGdHM1l4QWp6TGtZY290YTFHSncyRnVLRFYwT1pmN09Wd05F?=
 =?utf-8?B?QW1adGFFVHRjN2Z2TEpnVDJaUXFhM0RJL3FjbVZHVElPdldWZ09NTWF4VWZU?=
 =?utf-8?B?WmYrLzdWY0tWUTFMWWJSU0cvdTBJVjVkQXFFdVNYakdhL1Z0dFdvdkRqakFp?=
 =?utf-8?B?WVJ0WXdWMlZkRzNIMzV2VVcrVm1QeU13RHpKN1owYVFWQ2lIK0djRmE3Q1M2?=
 =?utf-8?B?cGNmQVM2eWUrWWhTekFtUlJxQjB4a2N4Q2N0RlRHZmZQK2d5bjZxRnI3ZnQ4?=
 =?utf-8?B?L0NTTGV3U3NYaStScVlPTFJGQjROcG1UUG9Cak9lenlid2IreUNVNzhvZTVt?=
 =?utf-8?B?dWxCSHlBMFZ4SmtmYXJoMFIrdDBFSGN2WGk4ODJRekdqbFNNWEE0aDd1aTlt?=
 =?utf-8?B?ZVZGeWhWb2JjdnlDVUI5QWkwR0FwMDlZSHRNcE0rdzM0UlUyZHA0b1FLQmFK?=
 =?utf-8?B?MnJxM25ONWRVczVyVWhvcDVPYVJ2amlIdlVmOEFhME1DREZacm12aVhYNTBL?=
 =?utf-8?B?SEh6STFnRlhqcmo2M0U0N0NCWTF5V2pRM2puM281QW1Rc1ZYaytmREJxbVN3?=
 =?utf-8?B?cnZiMUgzeWg5ZUxydGNkb2hmQmhoaVJ2NDlLK3Boam9ncnUxRUFwN2xWTlpv?=
 =?utf-8?B?SnkzdjZ4amlUZ1N6dVJGdU9CbnIzODBzTmQvQjBEZXhVNGNucVN4eDZ6S2VS?=
 =?utf-8?B?RVVmdHBNV1pDK1YvUWJ3WUJCS2xsSkEwMkFnMmkxdnBVYzAzUE53VVJUL1JQ?=
 =?utf-8?B?a2ZYQ1JKYzhPZUxBanV5Z0o3VkV4TjJMSlcwK3VqZlFKdHg0TURjNDY1WGJq?=
 =?utf-8?B?QldNVG82Ry9nUFBVS1hYMVVZemIwZFhJcmRvL0J6L2ZmbE1DZ1RFUkhBVjRK?=
 =?utf-8?B?YXhjcHp6eGxEeHF2dVZhV1ZSek5ML2Z1U0ErK3VxRStJQkwxYkpZZUNwR2pR?=
 =?utf-8?B?RUpxcGpGU0NoMTRSSkJpWkZ2bGtnU285ajh3azZ2TExSb0llM1JMbzZkQ1J6?=
 =?utf-8?B?QkF0YkJqTGVaUU9VbFJiUmp4TnFRUDlzeU04bWRVWW5qNk5nV1ZScjAzK0tZ?=
 =?utf-8?B?NHlNZUhRRDQwOVVKTmtycFBiNWQ0ZWtmejJiLzk3U1h1dDV5Y1Y2WDJMM1pM?=
 =?utf-8?B?L1FYV2ZUQzVWUkMwQmVlR01lQzU4QU1vMHY3ajZ1SENwMjZHOFRiWm44MzJY?=
 =?utf-8?Q?gqn61YJNb8rJBQwnqVWIvN71DayB3chi?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UjkrbmdDdXhDQzhWRy9BeklkVGVuSlVUM0xmcVlhWkxzZm1YY2FlN2hVeHNU?=
 =?utf-8?B?RmYwN2Y5WkhrNllkMUIyZFdRU0FENC9LMkE2VlRUVjV0KzFCQlorR0szUEl2?=
 =?utf-8?B?S2I4QS9jTXloS01zQytkNERNTWtPK05zTU4vek96c3JJc0M1TDRJY0Q4YjRM?=
 =?utf-8?B?Z3V2QXd6MzBEWGo3dEFBSW9zdkxNYjRjK0NnOU1WVkNKQmlQTjA3L3hRUWdT?=
 =?utf-8?B?S01vOE1nSTg2MXJTaSt6Ky9ldXJobXQwQmMwcjZhVFN6QWJQSFFQM3RlMS93?=
 =?utf-8?B?eVlUS1RXeGYzYXZGVFU2UE5pOXBMT1FVUG9PMitrU091S1RTcUEyencyb2hH?=
 =?utf-8?B?WTA3NFJUTHlMY3NqcTZ2bUx3WUpJZkZRZnBDZEJKclhtbVdUSzNVRU9PUmlO?=
 =?utf-8?B?ZkpENEE2VDJQUWF0RktCME5EL1pVdlFvSlo2MEhVV0ttQW9VbWJLZjluLzJu?=
 =?utf-8?B?SkxmYW93T3pUUXl1M3F1Z3FRdUtGaExXaG83S01ra0JMQ3d2MHNwRi9wRUJR?=
 =?utf-8?B?RUtEL1B1b3pnRWRFR2drQWtsSTF6bWFLcXduQWVQOUs0S1dhcVpFM3Mwd2Zh?=
 =?utf-8?B?R1F5Mkt1NzZIV3dDS3B4WWk0QlNtRFZ3U0t5MC83WXM1WmVRcHZVRkJwUVdx?=
 =?utf-8?B?QXNNcGQ2WVVZNlFTbjBheG5VTWdEeFpNMWJKQXVLR0ZOckZqY1podnUwYTR2?=
 =?utf-8?B?cVBkRkllbytOMWw1ZUdnN2g2anlLcjdCMnJWclBjQUVIR1ZZRDJ1bDdZeU0z?=
 =?utf-8?B?NWx4QktYeHU0YkFpT3I5NmZIQWNOay90MjBXZVFVd0FaaEVsT01XbzVwNWgr?=
 =?utf-8?B?N3JtcmFQK3J6b0RBTE5ueVZrS3N5WUNFd3hGVGQvVVo2MWhMMjI5L28xZ2Ro?=
 =?utf-8?B?aEg2MkZqMlhUeUlWOGFWMmJCZUdlVEhmUDRNSzNxaU1lbFFpUXJzUDFTZlIz?=
 =?utf-8?B?MDVKeWEyMncyZmtQZ1B4MElPVkQ0bVBJdXNyeTBmLzlGbTE3ckdMNTRHeTFu?=
 =?utf-8?B?YW42cS9CZW5Ta2FNbSs1Tmh1Ym1lVlRhUHk5dTVIMEwxSGYwT3JOTVdkSit2?=
 =?utf-8?B?R0h1Mk1JVUlyR1BIUmVJakIvZS91aFdmQ3BUYmQ1bDVXaTM3VXRORThtMXhr?=
 =?utf-8?B?RFArRkJlelFHSzNsSWNIb1psVUIzNmw2VzNVZFAwWFFhWldseDQvTHRiREZh?=
 =?utf-8?B?ZlVBcGQrQVU5eitSZ0pFK2RCOVl2dU4xK2Nqdy80QUFrQlc0WFNiUXBtbGNS?=
 =?utf-8?B?S1hVa1d3RGVtR0l2dEhyTFhxQUlCTVhPRStaaHB5dXY5ak9uMHRIL1hmVGJZ?=
 =?utf-8?B?NW9JTnY3dVJnL1I4K2hNWDBSanJsN2U2RXFkWjZnenJ1M3FFaU5rbGw4ditI?=
 =?utf-8?B?Sk4rWjk0cGEwMEdpOVBQenJXL25qRVV4TUI2SU1YUCttNktUWVpQcnNyWURq?=
 =?utf-8?B?RVh3M1VzRTdNYll5OVVtU0I0RUNJeVNyTjNmSjNHUnMwbjZBSXRkeGswZmF6?=
 =?utf-8?B?RFZBMUo2Nk1wTjE2SmhPTUE0ZG9XRmp1OFhNaUhUL09YMjdzRTh1RzI5U3Bm?=
 =?utf-8?B?Y08xNE15cDdvbmRhMkU3RHFxUEdTQ083OWhiNVNQSE9vcHNudWdaRlZ0c1Vt?=
 =?utf-8?B?MiszYmpmM3A1ajNITEMvcW1VNGpJV21yNFZ3R0htSE5tSGRBeDJ2OXVMTjRn?=
 =?utf-8?B?ZjdzbldENDVVaEpMdFpIL0dZbjBxLzFFczN2R05KdTg1Y0pBMkJtRU9sUkx1?=
 =?utf-8?B?WTJCbG0xMXVnWnZ3RHNMdkllTzQvY0pNY3hqOFB5T1Y5UzZqcUNkZ2pBZElK?=
 =?utf-8?B?WUlBNmQ2cUZGMCtSaWlqaDdxOEVTSzY5TDJwd0ZWWThTa3pIUW9Zd3NsVSt1?=
 =?utf-8?B?ZHJ1cWdGRm81cCs1andIZm9sNEl5dmcvT2FkK0JobEFNYitEcTJRWnN1M0o4?=
 =?utf-8?B?bUVJVW5qamFGZzk4SzFnQWhCZjVlblJsSmIraEczL3NYZWhmLzJSdDhzV1lT?=
 =?utf-8?B?RXFGQXhXaERtOWh2TUtWUEZpTGtUNmJEaTBTVTV0QTR0amIwbE14aUl2Yzk2?=
 =?utf-8?B?ME9LUUlkYS9YcmJmSzZLQUxOaUJ6clAzVkRTQ01kZjc1S3lZNzRya0tkNWFw?=
 =?utf-8?B?V25PM1JLZHk1Q0R4dDdIRk0zN1BRS3lzWEt0RlRwTUJPb2RMaGN0ZUVJMloz?=
 =?utf-8?Q?Uoh13IF3GMk8E9bEI+OdDpw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BE720B47C454342AB6B141589301150@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f626e1-e984-45b7-f728-08dd672dd6e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 21:34:33.3065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u2uCD8ukajUre+F2HWxFOUHoN60cklY5jQ4imUs44TqWy+rNOvB7LsijzS+vLMbziSqstG6A9Sefcs8SELKunw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB6015
X-Proofpoint-ORIG-GUID: 0D0-6iToPmM6JePGBmXg-G6eqBdiDgts
X-Proofpoint-GUID: k2liYpMAyO75AGyVxTShX6KxS6JJClmh
Subject: RE: [RFC PATCH] ceph: fix ceph_fallocate() ignoring of
 FALLOC_FL_ALLOCATE_RANGE mode
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_08,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190144

T24gV2VkLCAyMDI1LTAzLTE5IGF0IDA4OjI0IC0wNzAwLCBHcmVnb3J5IEZhcm51bSB3cm90ZToN
Cj4gT24gVHVlLCBNYXIgMTgsIDIwMjUgYXQgNDo0OOKAr1BNIFZpYWNoZXNsYXYgRHViZXlrbyA8
c2xhdmFAZHViZXlrby5jb20+IHdyb3RlOg0KPiA+IEZyb206IFZpYWNoZXNsYXYgRHViZXlrbyA8
U2xhdmEuRHViZXlrb0BpYm0uY29tPg0KPiA+IA0KPiA+IFRoZSBmaW8gdGVzdCByZXZlYWxzIHRo
ZSBpc3N1ZSBmb3IgdGhlIGNhc2Ugb2YgZmlsZSBzaXplDQo+ID4gaXMgbm90IGFsaWduZWQgb24g
NEsgKGZvciBleGFtcGxlLCA0MTIyLCA4NjAwLCAxMEsgZXRjKS4NCj4gPiBUaGUgcmVwcm9kdWNp
bmcgcGF0aDoNCj4gPiANCj4gPiB0YXJnZXRfZGlyPS9tbnQvY2VwaGZzDQo+ID4gcmVwb3J0X2Rp
cj0vcmVwb3J0DQo+ID4gc2l6ZT0xMDBraQ0KPiA+IG5yZmlsZXM9MTANCj4gPiBwYXR0ZXJuPTB4
NzQ2NTczNzQNCj4gPiANCj4gPiBmaW8gLS1ydW50aW1lPTVNIC0tcnc9d3JpdGUgLS1icz00ayAt
LXNpemU9JHNpemUgXA0KPiA+IC0tbnJmaWxlcz0kbnJmaWxlcyAtLW51bWpvYnM9MTYgLS1idWZm
ZXJfcGF0dGVybj0weDc0NjU3Mzc0IFwNCj4gPiAtLWlvZGVwdGg9MSAtLWRpcmVjdD0wIC0taW9l
bmdpbmU9bGliYWlvIC0tZ3JvdXBfcmVwb3J0aW5nIFwNCj4gPiAtLW5hbWU9ZmlvdGVzdCAtLWRp
cmVjdG9yeT0kdGFyZ2V0X2RpciBcDQo+ID4gLS1vdXRwdXQgJHJlcG9ydF9kaXIvc2VxdWVudGlh
bF93cml0ZS5sb2cNCj4gPiANCj4gPiBmaW8gLS1ydW50aW1lPTVNIC0tdmVyaWZ5X29ubHkgLS12
ZXJpZnk9cGF0dGVybiBcDQo+ID4gLS12ZXJpZnlfcGF0dGVybj0weDc0NjU3Mzc0IC0tc2l6ZT0k
c2l6ZSAtLW5yZmlsZXM9JG5yZmlsZXMgXA0KPiA+IC0tbnVtam9icz0xNiAtLWJzPTRrIC0taW9k
ZXB0aD0xIC0tZGlyZWN0PTAgLS1uYW1lPWZpb3Rlc3QgXA0KPiA+IC0taW9lbmdpbmU9bGliYWlv
IC0tZ3JvdXBfcmVwb3J0aW5nIC0tdmVyaWZ5X2ZhdGFsPTEgXA0KPiA+IC0tdmVyaWZ5X3N0YXRl
X3NhdmU9MCAtLWRpcmVjdG9yeT0kdGFyZ2V0X2RpciBcDQo+ID4gLS1vdXRwdXQgJHJlcG9ydF9k
aXIvdmVyaWZ5X3NlcXVlbnRpYWxfd3JpdGUubG9nDQo+ID4gDQo+ID4gVGhlIGVzc2VuY2Ugb2Yg
dGhlIGlzc3VlIHRoYXQgdGhlIHdyaXRlIHBoYXNlIGNhbGxzDQo+ID4gdGhlIGZhbGxvY2F0ZSgp
IHRvIHByZS1hbGxvY2F0ZSAxMEsgb2YgZmlsZSBzaXplIGFuZCwgdGhlbiwNCj4gPiBpdCB3cml0
ZXMgb25seSA4S0Igb2YgZGF0YS4gSG93ZXZlciwgQ2VwaEZTIGNvZGUNCj4gPiBpbiBjZXBoX2Zh
bGxvY2F0ZSgpIGlnbm9yZXMgdGhlIEZBTExPQ19GTF9BTExPQ0FURV9SQU5HRQ0KPiA+IG1vZGUg
YW5kLCBmaW5hbGx5LCBmaWxlIGlzIDhLIGluIHNpemUgb25seS4gQXMgYSByZXN1bHQsDQo+ID4g
dmVyaWZpY2F0aW9uIHBoYXNlIGluaXRpYXRlcyB3aWVyZCBiZWhhdmlvdXIgb2YgQ2VwaEZTIGNv
ZGUuDQo+ID4gQ2VwaEZTIGNvZGUgY2FsbHMgY2VwaF9mYWxsb2NhdGUoKSBhZ2FpbiBhbmQgY29t
cGxldGVseQ0KPiA+IHJlLXdyaXRlIHRoZSBmaWxlIGNvbnRlbnQgYnkgc29tZSBnYXJiYWdlLiBG
aW5hbGx5LA0KPiA+IHZlcmlmaWNhdGlvbiBwaGFzZSBmYWlscyBiZWNhdXNlIGZpbGUgY29udGFp
bnMgdW5leHBlY3RlZA0KPiA+IGRhdGEgcGF0dGVybi4NCj4gDQo+IA0KPiBDZXBoRlMgZG9lc27i
gJl0IHJlYWxseSBzdXBwb3J0IGZhbGxvY2F0ZSBpbiB0aGUgZ2VuZXJhbCBjYXNlIHRvIGJlZ2lu
DQo+IHdpdGgg4oCUIHdlIGRvbuKAmXQgd2FudCB0byBnbyBvdXQgYW5kIGNyZWF0ZSBhbiBhcmJp
dHJhcnkgbnVtYmVyIG9mIDRNaUINCj4gb2JqZWN0cyBpbiByZXNwb25zZSB0byBhIGxhcmdlIGFs
bG9jYXRpb24gY29tbWFuZC4NCj4gDQoNClRoZSBmYWxsb2NhdGUoKSBzaW1wbHkgaW5jcmVhc2Ug
dGhlIHNpemUgb2YgZmlsZSBpbiBtZXRhZGF0YSBidXQgbm90IGFsbG9jYXRlIG9yDQpmaWxsIHVw
IGFueSBjb250ZW50IG9mIHRoZSBmaWxlLiBTbywgbm8gb2JqZWN0cyB3aWxsIGJlIGNyZWF0ZWQg
YWZ0ZXINCmZhbGxvY2F0ZSgpIGNhbGwuDQoNCigxKSBTZXQgbmV3IHNpemUgb2YgZmlsZSBpbiBt
ZXRhZGF0YToNCisJCQljZXBoX2lub2RlX3NldF9zaXplKGlub2RlLCBvZmZzZXQgKyBsZW5ndGgp
Ow0KDQooMikgTWFyayBpbm9kZSBkaXJ0eToNCisJCQljZXBoX2ZhbGxvY2F0ZV9tYXJrX2RpcnR5
KGlub2RlLCAmcHJlYWxsb2NfY2YpOw0KDQpOb3RoaW5nIG1vcmUgaXMgaGFwcGVuZWQgb24gZmFs
bG9jYXRlKCkgc2lkZS4gVGhlIHJlc3QgaXMgbWFuYWdlZCBieSB3cml0ZSBwYXRoDQppZiB3ZSB0
cnkgdG8gc3RvcmUgc29tZSBjb250ZW50IGluIHRoZSBmaWxlLg0KDQo+ICBBRkFJSyB0aGUgb25s
eSBvbmUNCj4gd2UgcmVhbGx5IGRvIGlzIGxldHRpbmcgeW91IHNldCBhIHNwZWNpZmljIGZpbGUg
c2l6ZSB1cCAob3IgZG93biwNCj4gbWF5YmU/KS7CoA0KPiANCg0KSXQncyBub3QgY29tcGxldGVs
eSBjb3JyZWN0IGZvciB0aGUga2VybmVsIHNpZGUuIE5vdyBDZXBoRlMga2VybmVsIGNvZGUgc3Vw
cG9ydHMNCm9ubHkgKEZBTExPQ19GTF9LRUVQX1NJWkUgfCBGQUxMT0NfRkxfUFVOQ0hfSE9MRSku
IEl0IG1lYW5zIHRoYXQNCmNlcGhfZmFsbG9jYXRlKCkgTkVWRVIgY2hhbmdlcyB0aGUgc2l6ZSBv
ZiB0aGUgZmlsZS4gIA0KDQo+IERvIHdlIGFjdHVhbGx5IHdhbnQgdG8gc3VwcG9ydCB0aGlzIHNw
ZWNpZmljIHN1Yi1waWVjZSBvZiB0aGUNCj4gQVBJPyBXaGF0IGhhcHBlbnMgaWYgc29tZWJvZHkg
dXNlcyBGQUxMT0NfRkxfQUxMT0NBVEVfUkFOR0UgdG8gc2V0IGENCj4gc2l6ZSBvZiA0TWlCKzFL
aUI/IElzIHRoaXMgc3luY2hlZCB3aXRoIHRoZSBjdXJyZW50IHN0YXRlIG9mIHRoZSB1c2VyDQo+
IHNwYWNlIGNsaWVudD8gSSBrbm93IE1pbGluZCBqdXN0IG1hZGUgc29tZSBjaGFuZ2VzIGFyb3Vu
ZCB1c2Vyc3BhY2UNCj4gZmFsbG9jYXRlIHRvIHJhdGlvbmFsaXplIG91ciBiZWhhdmlvci4NCj4g
DQoNClRoZSBzdXBwb3J0IG9mIEZBTExPQ19GTF9BTExPQ0FURV9SQU5HRSBzaW1wbHkgY2hhbmdl
IHRoZSBzaXplIG9mIGZpbGUgaW4NCm1ldGFkYXRhIGFuZCBub3RoaW5nIG1vcmUuIElmIHdlIGRv
bid0IHN1cHBvcnQgdGhlIEZBTExPQ19GTF9BTExPQ0FURV9SQU5HRQ0KbW9kZSwgdGhlbiBjdXJy
ZW50IGJlaGF2aW9yIG9mIGZhbGxvY2F0ZSgpIGNhbGwgbG9va3Mgbm90IGNvbXBsZXRlbHkgY29y
cmVjdC4NCkJlY2F1c2UsIHVzZXIgZXhwZWN0IHRvIHNlZSB0aGUgY29ycmVjdCBzaXplIG9mIGZp
bGUuIExldCdzIGltYWdpbmUgd2UgdXNlZA0KZmFsbG9jYXRlKCkgdG8gZXh0ZW5kIGZpbGUgdG8g
MTBLIHNpemUgYW5kLCB0aGVuIHdlIHdyb3RlIDhLIGRhdGEgaW4gdGhlIGZpbGUsDQp0aGVuIHdl
IHdpbGwgc2VlIG9ubHkgOEsgc2l6ZSBvZiBmaWxlLiBIb3dldmVyLCB3ZSBzaG91bGQgaGF2ZSAx
MEsgZmlsZSBzaXplIGFuZA0Kd2Ugc2hvdWxkIHNlZSA4SyB3cml0dGVuIGNvbnRlbnQgYW5kIHpl
cm9lZCByZXN0IG9mIGZpbGUncyBjb250ZW50Lg0KDQpCdXQgQ2VwaEZTIGtlcm5lbCBjb2RlIGhh
cyBtb3JlIGRhbmdlcm91cyBiZWhhdmlvciBub3cuIElmIHdlIHVzZWQgZmFsbG9jYXRlKCkNCnRv
IGluY3JlYXNlIHRoZSBmaWxlIHNpemUgdG8gMTBLIGFuZCwgdGhlbiwgd2UgaGF2ZSB3cml0dGVu
IDhLIGFnYWluLCBzbywgd2Ugc2VlDQo4SyBmaWxlIHNpemUuIEJ1dCBpZiB3ZSB0cnkgdG8gdmVy
aWZ5IHRoZSBmaWxlJ3MgY29udGVudCwgdGhlbiBpbnN0ZWFkIG9mIG9ubHkNCnJlYWQgcmVxdWVz
dHMgd2UgaGF2ZSBzb21laG93IHRoZSBjZXBoX2ZhbGxvY2F0ZSgpIGNhbGwgdGhhdCBjb21wbGV0
ZWx5IHJlbW92ZQ0KY29udGVudCBvZiB0aGUgZmlsZSBhbmQgd3JpdGUgcmVxdWVzdHMgZmlsbCBp
dCBieSBzb21lIGdhcmJhZ2UgdGhlbi4gSXQgaGFwcGVucw0Kb25seSBmb3IgdW5hbGlnbmVkIGZv
ciA0SyBzaXplIG9mIHRoZSBmaWxlICgxMEssIGZvciBleGFtcGxlKSBidXQgaXQgd29ya3Mgd2Vs
bA0KZm9yIGFsaWduZWQgc2l6ZSBvZiBmaWxlLiBJIGV4cGxhaW5lZCB0aGUgcmVwcm9kdWN0aW9u
IHBhdGggYWJvdmUuDQoNCj4gDQo+ID4gZmlvOiBnb3QgcGF0dGVybiAnZDAnLCB3YW50ZWQgJzc0
Jy4gQmFkIGJpdHMgMw0KPiA+IGZpbzogYmFkIHBhdHRlcm4gYmxvY2sgb2Zmc2V0IDANCj4gPiBw
YXR0ZXJuOiB2ZXJpZnkgZmFpbGVkIGF0IGZpbGUgL21udC9jZXBoZnMvZmlvdGVzdC4zLjAgb2Zm
c2V0IDAsIGxlbmd0aCAyNjMxNDkwMjcwIChyZXF1ZXN0ZWQgYmxvY2s6IG9mZnNldD0wLCBsZW5n
dGg9NDA5NiwgZmxhZ3M9OCkNCj4gPiBmaW86IHZlcmlmeSB0eXBlIG1pc21hdGNoICgzNjk2OSBt
ZWRpYSwgMTggZ2l2ZW4pDQo+ID4gZmlvOiBnb3QgcGF0dGVybiAnMjUnLCB3YW50ZWQgJzc0Jy4g
QmFkIGJpdHMgMw0KPiA+IGZpbzogYmFkIHBhdHRlcm4gYmxvY2sgb2Zmc2V0IDANCj4gPiBwYXR0
ZXJuOiB2ZXJpZnkgZmFpbGVkIGF0IGZpbGUgL21udC9jZXBoZnMvZmlvdGVzdC40LjAgb2Zmc2V0
IDAsIGxlbmd0aCAxNjk0NDM2ODIwIChyZXF1ZXN0ZWQgYmxvY2s6IG9mZnNldD0wLCBsZW5ndGg9
NDA5NiwgZmxhZ3M9OCkNCj4gPiBmaW86IHZlcmlmeSB0eXBlIG1pc21hdGNoICg2NzE0IG1lZGlh
LCAxOCBnaXZlbikNCj4gPiANCj4gPiBFeHBlY3RlZCBzdGF0ZSBvdCB0aGUgZmlsZToNCj4gPiAN
Cj4gPiBoZXhkdW1wIC1DIC4vZmlvdGVzdC4wLjANCj4gPiAwMDAwMDAwMCA3NCA2NSA3MyA3NCA3
NCA2NSA3MyA3NCA3NCA2NSA3MyA3NCA3NCA2NSA3MyA3NCB8dGVzdHRlc3R0ZXN0dGVzdHwgKg0K
PiA+IDAwMDAyMDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIHwuLi4uLi4uLi4uLi4uLi4ufCAqDQo+ID4gMDAwMDIxOTAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgfC4uLi4uLi4ufA0KPiA+IDAwMDAyMTk4DQo+ID4gDQo+ID4gUmVhbCBzdGF0ZSBvZiB0
aGUgZmlsZToNCj4gPiANCj4gPiBoZWFkIC1uIDIgLi9maW90ZXN0LjAuMA0KPiA+IDAwMDAwMDAw
IDM1IGUwIDI4IGNjIDM4IGEwIDk5IDE2IDA2IDljIDZhIGE5IGYyIGNkIGU5IDBhIHw1LiguOC4u
Li4uai4uLi4ufA0KPiA+IDAwMDAwMDEwIDgwIDUzIDJhIDA3IDA5IGU1IDBkIDE1IDcwIDRhIDI1
IGY3IDBiIDM5IDlkIDE4IHwuUyouLi4uLnBKJS4uOS4ufA0KPiA+IA0KPiA+IFRoZSBwYXRjaCBy
ZXdvcmtzIGNlcGhfZmFsbG9jYXRlKCkgbWV0aG9kIGJ5IG1lYW5zIG9mIGFkZGluZw0KPiA+IHN1
cHBvcnQgb2YgRkFMTE9DX0ZMX0FMTE9DQVRFX1JBTkdFIG1vZGUuIEFsc28sIGl0IGFkZHMgdGhl
IGNoZWNraW5nDQo+ID4gdGhhdCBuZXcgc2l6ZSBjYW4gYmUgYWxsb2NhdGVkIGJ5IG1lYW5zIG9m
IGNoZWNraW5nIGlub2RlX25ld3NpemVfb2soKSwNCj4gPiBmc2MtPm1heF9maWxlX3NpemUsIGFu
ZCBjZXBoX3F1b3RhX2lzX21heF9ieXRlc19leGNlZWRlZCgpLg0KPiA+IEludmFsaWRhdGlvbiBh
bmQgbWFraW5nIGRpcnR5IGxvZ2ljIGlzIG1vdmVkIGludG8gZGVkaWNhdGVkDQo+ID4gbWV0aG9k
cy4NCj4gPiANCj4gPiBUaGVyZSBpcyBvbmUgcGVjdWxpYXJpdHkgZm9yIHRoZSBjYXNlIG9mIGdl
bmVyaWMvMTAzIHRlc3QuDQo+ID4gQ2VwaEZTIGxvZ2ljIHJlY2VpdmVzIG1heF9maWxlX3NpemUg
ZnJvbSBNRFMgc2VydmVyIGFuZCBpdCdzIDFUQg0KPiA+IGJ5IGRlZmF1bHQuIEFzIGEgcmVzdWx0
LCBnZW5lcmljLzEwMyBjYW4gZmFpbCBpZiBtYXhfZmlsZV9zaXplDQo+ID4gaXMgc21hbGxlciB0
aGFuIHZvbHVtZSBzaXplOg0KPiA+IA0KPiA+IGdlbmVyaWMvMTAzIDZzIC4uLiAtIG91dHB1dCBt
aXNtYXRjaCAoc2VlIC9ob21lL3NsYXZhZC9YRlNURVNUUy94ZnN0ZXN0cy1kZXYvcmVzdWx0cy8v
Z2VuZXJpYy8xMDMub3V0LmJhZCkNCj4gPiAtLS0gdGVzdHMvZ2VuZXJpYy8xMDMub3V0IDIwMjUt
MDItMjUgMTM6MDU6MzIuNDk0NjY4MjU4IC0wODAwDQo+ID4gKysrIC9ob21lL3NsYXZhZC9YRlNU
RVNUUy94ZnN0ZXN0cy1kZXYvcmVzdWx0cy8vZ2VuZXJpYy8xMDMub3V0LmJhZCAyMDI1LTAzLTE3
IDIyOjI4OjI2LjQ3NTc1MDg3OCAtMDcwMA0KPiA+IEAgLTEsMiArMSwzIEANCj4gPiBRQSBvdXRw
dXQgY3JlYXRlZCBieSAxMDMNCj4gPiArZmFsbG9jYXRlOiBObyBzcGFjZSBsZWZ0IG9uIGRldmlj
ZQ0KPiA+IFNpbGVuY2UgaXMgZ29sZGVuLg0KPiA+IA0KPiA+IFRoZSBzb2x1dGlvbiBpcyB0byBz
ZXQgdGhlIG1heF9maWxlX3NpemUgZXF1YWwgdG8gdm9sdW1lIHNpemU6DQo+IA0KPiANCj4gVGhh
dCBpcyByZWFsbHkgbm90IGEgZ29vZCBpZGVhLiBJcyB0aGVyZSByZWFsbHkgYSB0ZXN0IHRoYXQg
dHJpZXMgdG8NCj4gZmFsbG9jYXRlIHRoYXQgbXVjaCBzcGFjZT8gV2UgcHJvYmFibHkganVzdCB3
YW50IHRvIHNraXAgaXTigKZjbGVhbmluZw0KPiB1cCBmaWxlcyBzZXQgdG8gdGhhdCBzaXplIGlz
buKAmXQgbXVjaCBmdW4uDQoNClRoZSBnZW5lcmljLzIxMyB0cmllcyB0byBmYWxsb2NhdGUoKSBm
aWxlIGlzIGJpZ2dlciB0aGFuIHZvbHVtZSBzaXplLiBJdCdzIG5vdA0KdGhlIGlzc3VlIGhlcmUu
IEFuZCB0aGUgZ2VuZXJpYy8xMDMgdHJpZXMgdG8gZmFsbG9jYXRlKCkgZmlsZSBvZiAodm9sdW1l
X3NpemUgLQ0KNTEySykgZXhwZWN0aW5nIHN1Y2Nlc3Mgb2YgdGhlIG9wZXJhdGlvbi4gVGhlbiBp
dCB0cmllcyB0byBhZGQgYmlnIHhhdHRycw0KZXhwZWN0aW5nIHRvIHJlY2VpdmUgLUVOT1NQQy4g
U28sIEkgaGF2ZSA3VEIgdm9sdW1lIHNpemUgYW5kIDFUQiBtYXhfZmlsZV9zaXplDQpieSBkZWZh
dWx0LiBBcyBhIHJlc3VsdCwgaWYgSSBkb24ndCBzZXQgdXAgbWF4X2ZpbGVfc2l6ZSB0byA3VEIs
IHRoZW4NCmdlbmVyaWMvMTAzIGZhaWxzIGJlY2F1c2UgaXQgY2Fubm90IGZhbGxvY2F0ZSgpIGZp
bGUgb2Ygc2l6ZSB0aGF0IGZpdHMgdG8gdGhlDQpzaXplIG9mIHRoZSB2b2x1bWUuIEkgZG9uJ3Qg
dGhpbmsgdGhhdCBza2lwcGluZyBnZW5lcmljLzEwMyBpcyBhIGdvb2QgaWRlYS4NCg0KVGhhbmtz
LA0KU2xhdmEuDQoNCg0KDQo=

